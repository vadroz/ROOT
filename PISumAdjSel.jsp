<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat
,rciutility.ClassSelect, rciutility.StoreSelect
, inventoryreports.PiCalendar, java.sql.*, java.util.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null )
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PISumAdjSel.jsp&APPL=ALL");
   }
   else
   {
	  String sUser =  session.getAttribute("USER").toString();
	  String sStrAllowed = session.getAttribute("STORE").toString();
	  
      ClassSelect divsel = null;
      StoreSelect strsel = null;

      String sDiv = null;
      String sDivName = null;
      String sDpt = null;
      String sDptName = null;
      String sDptGroup = null;
      String sCls = null;
      String sClsName = null;

      divsel = new ClassSelect();
      sDiv = divsel.getDivNum();
      sDivName = divsel.getDivName();
      sDpt = divsel.getDptNum();
      sDptName = divsel.getDptName();
      sDptGroup = divsel.getDptGroup();

      String [] sDivArr = divsel.getDivArr();

      strsel = new StoreSelect(3);
      int iNumOfStr = strsel.getNumOfStr();
      String [] sStr = strsel.getStrLst();
      System.out.println("1. iNumOfStr=" + iNumOfStr);
      
      // get PI Calendar
      PiCalendar setcal = new PiCalendar();
      String sYear = setcal.getYear();
      String sMonth = setcal.getMonth();
      String sDesc = setcal.getDesc();
      setcal.disconnect();
      
      String sPrepStmt = "select ASEMP,ASSTR,ASALL"   	 	
      	 	+ " from rci.PIUSRST"
       	 	+ " where asemp='" + sUser + "'" 
       	 	+ " order by asStr";       	
         	
      ResultSet rslset = null;
      RunSQLStmt runsql = new RunSQLStmt();
      runsql.setPrepStmt(sPrepStmt);		   
      runsql.runQuery();
    	
      Vector<String> vStr = new Vector<String>();            
      boolean bAllAllow = false;
      
      while(runsql.readNextRecord())
      {
    	  vStr.add(runsql.getData("ASSTR"));
    	  String sAll = runsql.getData("ASALL");
    	  if(sAll.equals("Y")){ bAllAllow = true;}	
      }
    	    
      runsql.disconnect();
      runsql = null;      
      
      System.out.println("bAllAllow=" + bAllAllow);
      
      if(!bAllAllow)
      { 
    	  sStr = vStr.toArray(new String[]{});
    	  iNumOfStr = sStr.length;
      }
      
      sPrepStmt = "select PISTORE"
    	+  " from rci.PHYINVSTR a"
    	+ " inner join table(select PiYear, PiMonth  from rci.PhyInv order by PiYear desc, PiMonth desc"
    	+ " fetch first 1 row only) b on a.piYear=b.PiYear and a.PiMonth = b.PiMonth"
    	+ " where PiReady = 'Y'"
    	+ " and PiStore in ("
    	;
      
    	String sComa = "";
    	boolean [] bStrChk = new boolean[iNumOfStr];
    	if(iNumOfStr > 0)
    	{    	
        	for(int i=0; i < iNumOfStr; i++)
      		{
    	  		sPrepStmt += sComa + sStr[i];
    	  		sComa = ",";
	    	  	bStrChk[i] = false;
    	  	}
      		sPrepStmt += ")";
    	} 
    	else
    	{
    		bStrChk = new boolean[1];
    		sPrepStmt += sStrAllowed + ")";
    		bStrChk[0] = false;
    		strsel = new StoreSelect(sStrAllowed);
    	    iNumOfStr = strsel.getNumOfStr();
    	    sStr = strsel.getStrLst();
    	}
      	
    	System.out.println("\n" + sPrepStmt);
    	
      	rslset = null;
      	runsql = new RunSQLStmt();
      	runsql.setPrepStmt(sPrepStmt);		   
      	runsql.runQuery();
        
      	while(runsql.readNextRecord())
      	{
	  	  	String pistr = runsql.getData("pistore").trim();
	  	  	for(int i=0; i < iNumOfStr; i++)
	      	{	  	  		
	  	  		if(sStr[i].equals(pistr)){ bStrChk[i] = true; break;}
	      	}
      	}
      	    
      runsql.disconnect();
      runsql = null;  
      
      boolean bExclUsr = sUser.equals("psnyder") || sUser.equals("vrozen")  || sUser.equals("srutherfor")
    		  || sUser.equals("ptownsend") || sUser.equals("jburke");      
%>
<title>PI-Sum Adj Sel</title> 
<style>
  .Small {font-family: times; font-size:10px }
  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top}
  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
        width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}

  #trMultDiv { display:none}
  #trSingleDiv { display:block}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script name="javascript">
var PiYear = [<%=sYear%>];
var PiMonth = [<%=sMonth%>];
var PiDesc =  [<%=sDesc%>];

var MultView = false;

var SASStr = [3,4,5,8,10,11,20,28,29,30,40,42,45,61,63,64,66,75,82,87,88,90,92,93,94,96,98,99,100,101,102,199];
var SKIStr = [35,46,50];
var STPStr = [86];
var WHSStr = [1,55,59, 70,71,99,101,102];
var MALLStr = [4,29,40,42,45,63,82,88,90,98];
var NMALLStr = [3,5,8,10,11,20,28,30,35,46,50,61,63,64,66,86,92,93,94,96];
var NumOfStr = "<%=iNumOfStr%>";
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
	doDivSelect(null);
  	popPICal();
}
//==============================================================================
// change Store selection
//==============================================================================
function popPICal()
{
   document.all.PICal1yrBk.options[0] = new Option("None", "NONE");
   document.all.PICal2yrBk.options[0] = new Option("None", "NONE");

   for(var i=0, j=1; i < PiYear.length; i++, j++)
   {
      document.all.PICal.options[i] = new Option(PiDesc[i], PiYear[i] + PiMonth[i]);
      document.all.PICal1yrBk.options[j] = new Option(PiDesc[i], PiYear[i] + PiMonth[i]);
      document.all.PICal2yrBk.options[j] = new Option(PiDesc[i], PiYear[i] + PiMonth[i]);
   }

}
//==============================================================================
// populate class selection
//==============================================================================
function doClsSelect() {
    var df = document.all;
    var classes = [<%=sCls%>];
    var clsNames = [<%=sClsName%>];
    document.all.DivArg.value = 0;

    //  clear current classes
        for (idx = df.CLASS.length; idx >= 0; idx--)
            df.CLASS.options[idx] = null;
   //  populate the class list
        for (idx = 0; idx < classes.length; idx++)
        {
                df.CLASS.options[idx] = new Option(clsNames[idx], classes[idx]);
        }
}

//==============================================================================
// popilate division selection
//==============================================================================
function doDivSelect(id) {
    var df = document.all;
    var divisions = [<%=sDiv%>];
    var divisionNames = [<%=sDivName%>];
    var depts = [<%=sDpt%>];
    var deptNames = [<%=sDptName%>];
    var dep_div = [<%=sDptGroup%>];
    var chg = id;

    var allowed;

    if (id == null)
    {
        //  populate the division list
        for (idx = 0; idx < divisions.length; idx++)
        {
           df.DIVISION.options[idx] = new Option(divisionNames[idx],divisions[idx]);
        }
        id = 0
        if (document.all.DivArg.value.trim() > 0) id = eval(document.all.DivArg.value.trim());
        df.DIVISION.selectedIndex = id;
    }

    df.DivName.value = df.DIVISION.options[id].text
    df.Div.value = df.DIVISION.options[id].value
    df.DivArg.value = id

    allowed = dep_div[id].split(":");

    //  clear current depts
    for (idx = df.DEPARTMENT.length; idx >= 0; idx--)
    {
       df.DEPARTMENT.options[idx] = null;
    }

    //  if all are to be displayed
    if (allowed[0] == "all")
    {
       for (idx = 0; idx < depts.length; idx++)
            df.DEPARTMENT.options[idx] = new Option(deptNames[idx],depts[idx]);
    }
    //  else display the desired depts
    else
    {
       for (idx = 0; idx < allowed.length; idx++)
           df.DEPARTMENT.options[idx] = new Option(deptNames[allowed[idx]], depts[allowed[idx]]);
    }

    if(chg!=null)
    {
      showDptSelect(0);
      showClsSelect(0);
    }
}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showDptSelect(id)
{
   document.all.DptName.value = document.all.DEPARTMENT.options[id].text
   document.all.Dpt.value = document.all.DEPARTMENT.options[id].value

   // clear class
   for(var i = document.all.CLASS.length; i >= 0; i--) {document.all.CLASS.options[i] = null;}
   document.all.CLASS.options[0] = new Option("All Classes", "ALL")
   document.all.CLASS.options[0] = new Option("All Classes", "ALL")
   document.all.CLASS.selectedIndex=0;
   document.all.CLASS.size=1
}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showClsSelect(id)
{
   document.all.ClsName.value = document.all.CLASS.options[id].text
   document.all.Cls.value = document.all.CLASS.options[id].value
}
//==============================================================================
// retreive classes
//==============================================================================
function rtvClasses()
{
   var div = document.all.Div.value
   var dpt = document.all.Dpt.value

   var url = "RetreiveDivDptCls.jsp?"
           + "Division=" + div
           + "&Department=" + dpt;
   //alert(url);
   //window.location.href = url;
   window.frame1.location = url;
}
//==============================================================================
// show selected classes
//==============================================================================
function showClasses(cls, clsName)
{
   // clear
   for(var i = document.all.CLASS.length; i >= 0; i--) {document.all.CLASS.options[i] = null;}

   //popilate
   for(var i=0; i < cls.length; i++)
   {
     document.all.CLASS.options[i] = new Option(clsName[i], cls[i]);
   }
   document.all.CLASS.size=5
}

//==============================================================================
// change Store selection
//==============================================================================
function chgStrSel(str)
{
  var stores = document.all.STORE;
  var selstr = str.value;
  var mark = str.checked;

  // clear all
  clrStrSel();

  var grp = new Array();
  if(selstr == "SAS"){grp = SASStr;}
  else if(selstr == "SCH"){grp = SKIStr;}
  else if(selstr == "WHS"){grp = WHSStr;}
  else if(selstr == "MALL"){grp = MALLStr;}
  else if(selstr == "NMALL"){grp = NMALLStr;}

  for(var i=0; i < stores.length; i++ )
  {
     var strval = eval(stores[i].value);
     if(selstr == "ALL") { stores[i].checked=mark; }
     else
     {
       for(var j=0; j < grp.length; j++ )
       {
          if(grp[j] == strval){ stores[i].checked=mark; break;}
       }
     }
  }

  str.checked = false;
}
//==============================================================================
// unchecked all store (reset button)
//==============================================================================
function clrStrSel()
{
   var stores = document.all.STORE;
   for(var i=0; i < stores.length; i++ ) { stores[i].checked=false; }
}

//==============================================================================
// Set Action
//==============================================================================
function setAction(target){
  var form = document.forms[0];
  var action = null;
  form.action = action;

  if(target==1) { action = "PISumAdj.jsp"; form.BYCHAIN.value = "N"; }
  else if(target==2) { action = "PISumAdj.jsp"; form.BYCHAIN.value = "Y"; }
  form.action = action;
}

//==============================================================================
// Validate form
//==============================================================================
function Validate(type)
{
  var error = false;
  var msg = " ";

  var divMult = document.all.DivM;
  //alert(form.CLASS.options[form.CLASS.selectedIndex].value)

  var div = document.all.DIVISION.options[document.all.DIVISION.selectedIndex].value;
  var dptid = document.all.DEPARTMENT.selectedIndex;
  if(dptid < 0 ){ dptid = 0; }
  var dpt = document.all.DEPARTMENT.options[dptid].value;
  var clsid = document.all.CLASS.selectedIndex;
  if(clsid < 0 ){ clsid = 0; }
  var cls = document.all.CLASS.options[clsid].value;

  // get selected divisions
  var divarr = new Array();
  var divsel = false;
  for(var i=0, j=0; i < divMult.length; i++ )
  {
     if(divMult[i].checked)
     {
        divsel=true;
        divarr[j] = divMult[i].value;
        j++;
     }
     if(!MultView){ divMult[i].checked = false; }
  }

  if(MultView && !divsel)
  {
    msg += "\n Please, check at least 1 division";
    error = true;
  }
  if(MultView){dpt = "ALL"; cls="ALL";}


  // get selected stores
  var stores = document.all.STORE;
  var str = new Array();
  var strsel = false;
  
  if(NumOfStr == 1)
  {
	  strsel=true;
      str[0] = stores.value;      
  }
  else 	  
  {	  
  	for(var i=0, j=0; i < stores.length; i++ )
  	{
    	if(stores[i].checked)
     	{
        	strsel=true;
        	str[j] = stores[i].value;
        	j++;
     	}
  	}
  }

  if(!strsel)
  {
    msg += "\n Please, check at least 1 store";
    error = true;
  }
 
  var pical = document.all.PICal.options[document.all.PICal.selectedIndex].value;
  var pical1 = document.all.PICal1yrBk.options[document.all.PICal1yrBk.selectedIndex].value;
  var pical2 = document.all.PICal2yrBk.options[document.all.PICal2yrBk.selectedIndex].value;
  
  var picalnm = document.all.PICal.options[document.all.PICal.selectedIndex].text;
  document.all.PICalNm.value = picalnm;
  var picalnm1 = document.all.PICal1yrBk.options[document.all.PICal1yrBk.selectedIndex].text;
  document.all.PICalNm1yb.value = picalnm1;
  var picalnm2 = document.all.PICal2yrBk.options[document.all.PICal2yrBk.selectedIndex].text;
  document.all.PICalNm2yb.value = picalnm2;
  
  var incl9 = " ";
  if(document.all.Incl900.checked){ incl9 = "Y"; }
  
  if (error) alert(msg);
  else  
  {
	  var level = getLevel(MultView, div, dpt, cls);      
      sbmPIAdj(type, div, divarr, dpt, cls, str, pical, pical1, pical2, picalnm, picalnm1, picalnm2, level,incl9);
  }
}
//==============================================================================
// Submit PI Summary Adjustment
//==============================================================================
function sbmPIAdj(type, div, divarr, dpt, cls, str, pical, pical1, pical2, picalnm
    , picalnm1, picalnm2, level, incl9)
{
	var bychain = "N";
	if(type=="2") { bychain = "Y"; }		
	
	url = "PISumAdj.jsp?BYCHAIN=" + bychain;
	if(MultView)
	{
		for(var i=0; i < divarr.length; i++){ url += "&DivM=" + divarr[i]; }
	}
	else{ url += "&DIVISION=" + div; }
	
	for(var i=0; i < str.length; i++){ url += "&STORE=" + str[i]; }
	
	url += "&DEPARTMENT=" + dpt;
	url += "&CLASS=" + cls;
	url += "&LEVEL=" + level;
	url += "&Incl900=" + incl9;	
	url += "&PICal=" + pical;
	url += "&PICal1yrBk=" + pical1;
	url += "&PICal2yrBk=" + pical2;
	url += "&PICalNm=" + picalnm;
	url += "&PICalNm1yb=" + picalnm1;
	url += "&PICalNm2yb=" + picalnm2;
	
	window.location.href=url;
}
//==============================================================================
// return selected level
//==============================================================================
function  getLevel(MultView, DIVISION, DEPARTMENT, CLASS)
{
  var Level = null;
    if(MultView || DIVISION=="ALL" && DEPARTMENT=="ALL" && CLASS=="ALL") Level = "000";
    else if(DIVISION !="ALL" && DEPARTMENT=="ALL" && CLASS=="ALL") Level = "100";
    else if(DEPARTMENT!="ALL") Level = "010";
    else if(CLASS!="ALL") Level = "010";
  return Level;
}

//==============================================================================
// show month ending date as tooltip
//==============================================================================
function hideTooltips()
{
   document.all.tooltip1.style.visibility = "hidden";
   document.all.tooltip2.style.visibility = "hidden";
}

//==============================================================================
// switch between single and multiple divisions selections
//==============================================================================
function switchDiv(group)
{
   var single = document.all.trSingleDiv;
   var mult = document.all.trMultDiv;
   var sdisp = "none";
   var mdisp = "block";

   if(group == "SINGLE"){ sdisp = "block"; mdisp = "none"; MultView = false;}
   else { MultView = true; }

   for(var i=0; i < single.length; i++){ single[i].style.display = sdisp; }
   for(var i=0; i < mult.length; i++){ mult[i].style.display = mdisp; }
}

//==============================================================================
// disable enter key
//==============================================================================
function disableEnterKey(e)
{
     var key;
     if(window.event)
     {
          key = window.event.keyCode; //IE
     }
     return (key != 13);
}
document.onkeypress = disableEnterKey;
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

<HTML><HEAD><meta http-equiv="refresh">

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="tooltip1" style="position:absolute; visibility:hidden; background-color:LemonChiffon; z-index:10; font-size:10px; "></div>
<div id="tooltip2" style="position:absolute; visibility:hidden; background-color:LemonChiffon; z-index:10; font-size:10px;"></div>
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <!--TR><TD height="20%"><IMG src="Sun_ski_logo4.png"></TD></TR -->

  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Physical Inventory Adjustment Report - Selection </B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>&nbsp; &nbsp; &nbsp; &nbsp;

      <!-- FORM  method="GET" onSubmit="return Validate(this);" -->
      <TABLE>
        <TBODY>
        <!-- ------------- Division  --------------------------------- -->
        <TR id="trSingleDiv">
          <TD class="Cell" >Division:</TD>
          <TD class="Cell1" >
             <input class="Small" name="DivName" size=50 readonly>
             <input class="Small" name="Div" type="hidden">
             <input class="Small" name="DivArg" type="hidden" value=0><br>
             <SELECT name="DIVISION" class="Small" onchange="doDivSelect(this.selectedIndex);" size=5>
                <OPTION value="ALL">All Divisions</OPTION>
             </SELECT>
          </TD>
        <!-- ======================= Department ============================ -->
          <TD class="Cell">Department:</TD>
          <TD class="Cell1">
             <input class="Small" name="DptName" size=50 value="All Departments" readonly>
             <input class="Small" name="Dpt" type="hidden" value="ALL"><br>
             <SELECT class="Small" name=DEPARTMENT onchange="showDptSelect(this.selectedIndex);"  size=5>
                <OPTION value="ALL">All Departments</OPTION>
             </SELECT>
          </TD>
        </TR>
        <TR id="trSingleDiv">
            <TD class="Cell" colspan=4>&nbsp;</TD>
         </TR>
        <!-- ========================== Class ============================== -->
        <TR id="trSingleDiv">
            <TD class="Cell" >Class:</TD>
            <TD class="Cell1">
              <input class="Small" name="ClsName" size=50 value="All Classes" readonly>
              <input class="Small" name="Cls" type="hidden" value="ALL">
              <button class="Small" value="Select Class" name="SelCls" onClick="rtvClasses()">Select Class</button><br>
              <SELECT name="CLASS" class="Small" onchange="showClsSelect(this.selectedIndex);">
                 <OPTION value="ALL">All Classes</OPTION>
              </SELECT>
            </TD>
            <TD align=left style="font-size=11px" colspan=2>
               <span style="color:red">*Stores - Do not check mark this!</span><br>
               <span id="spIncl900"><input type="checkbox" name="Incl900" value="Y">
                 Include Div: 94 - 98, Dpt: 900-Demos,
                 <br> 986-Liquidation and 988-Lift Tickets and 50-Other
               </span>
            </TD>
        <TR id="trSingleDiv">
           <TD class="Cell2" colspan=4>
              <button class="Small" onClick="switchDiv('MULTIPLE')">Multiple Divisions</button>
           </td>
        </TR>

        <!-- ===================== Multiple Division Selection ============= -->
        <TR id="trMultDiv">
          <TD class="Cell" >Division:</TD>
          <TD class="Cell1" colspan=3>
            <%for(int i=0; i < sDivArr.length; i++){%>
               <input class="Small" name="DivM" type="checkbox" value="<%=sDivArr[i]%>"> <%=sDivArr[i]%> &nbsp; &nbsp;
            <%}%>
          </TD>
        </TR>
        <TR id="trMultDiv">
           <TD class="Cell1" colspan=4>
              <button class="Small"  onClick="switchDiv('SINGLE')">Single Divisions</button>
           </td>
        </TR>

        <!-- ========================== Store ============================== -->
        <!-- =============================================================== -->
        <TR><TD style="border-top:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell1"  colspan=5>
          Store:
           <%if(iNumOfStr > 1){%>
             <input name="GrpStrSel" type="checkbox" value="ALL" onclick="chgStrSel(this)">All Stores &nbsp;&nbsp;
             <button class="Small" id="GrpStrSel" onclick="clrStrSel()">Reset</button> &nbsp;&nbsp;
             <br>
           <%} %>

             <%for(int i=0, j=0 ; i<iNumOfStr; i++, j++) {%>
                <%if(bExclUsr || bStrChk[i]){%>
               	   <input name="STORE" type="checkbox" value="<%=sStr[i]%>" ><%=sStr[i]%>&nbsp;&nbsp;
               	   <%if(j == 15) {%><br><% j=0; }%>
                <%}%>
             <%}%>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <!-- ============== select Shipping changes ======================== -->
        <!-- ====================== PI Calendar selection=================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD colspan=4>
            <table cellPadding="0" cellSpacing="0">
              <tr>
                 <th class="Cell" nowrap colspan=1>&nbsp;</th>
                 <th class="Cell" nowrap colspan=7>Also Show Result From:</th>
              </tr>
              <tr>
                 <TD class="Cell" nowrap>PI Calendar:</TD>
                 <TD class="Cell1"><select class="Small" name="PICal"></select><input name="PICalNm" type=hidden></td>
                 <TD class="Cell" nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
                 <TD class="Cell" nowrap>PI Calendar:</TD>
                 <TD class="Cell1"><select class="Small" name="PICal1yrBk"></select><input name="PICalNm1yb" type=hidden></td>
                 <TD class="Cell" nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
                 <TD class="Cell" nowrap>PI Calendar:</TD>
                 <TD class="Cell1"><select class="Small" name="PICal2yrBk"></select><input name="PICalNm2yb" type=hidden></td>
              </tr>
            </table>
          </td>
          </tr>

        <!-- =============================================================== -->

           </table>
          </TD>
        </TR>

        <!-- =============================================================== -->
        <TR>
        <TR>
           <TD align=center colSpan=5>
               <button  id="SBMSTR" onClick="Validate('1')">Display by Store</button>
               &nbsp;&nbsp;&nbsp;&nbsp;
               <button id="SBMCHAIN" onClick="Validate('2')">Display by Merchandise Category</button>
               <INPUT name="BYCHAIN" type="hidden">
               <INPUT name="LEVEL" type="hidden" value="000" >
           </TD>
          </TR>
         </TBODY>
        </TABLE>
        <!-- /FORM -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>