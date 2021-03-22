<%@ page import="rciutility.ClassSelect, rciutility.StoreSelect, rciutility.RunSQLStmt
  , rciutility.CallAs400SrvPgmSup, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null )
   {
     response.sendRedirect("SignOn1.jsp?TARGET=StockPosRep.jsp&APPL=ALL");
   }
   else
   {

      ClassSelect divsel = null;
       

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

      StoreSelect strlst = null;
      strlst = new StoreSelect(25);
     
      String sStrJsa = strlst.getStrNum();
      String sStrNameJsa = strlst.getStrName();

      int iNumOfStr = strlst.getNumOfStr();
      String [] sStr = strlst.getStrLst();

      String [] sStrRegLst = strlst.getStrRegLst();
      String sStrRegJsa = strlst.getStrReg();

      String [] sStrDistLst = strlst.getStrDistLst();
      String sStrDistJsa = strlst.getStrDist();
      String [] sStrDistNmLst = strlst.getStrDistNmLst();
      String sStrDistNmJsa = strlst.getStrDistNm();

      String [] sStrMallLst = strlst.getStrMallLst();
      String sStrMallJsa = strlst.getStrMall();

      //============================================
      // get current fiscal year
      java.util.Date dCurDate = new java.util.Date();
      SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
      String sCurDate = sdf.format(dCurDate);
      
      // get division groups
      String sPrepStmt = "select grpn, div from rci.DIVGRPS"
    	   + " order by GRPC, DIV";
   	  //System.out.println(sPrepStmt);
      ResultSet rslset = null;
      RunSQLStmt runsql = new RunSQLStmt();
      runsql.setPrepStmt(sPrepStmt);
      runsql.runQuery();
      
      Vector<String> vGrpNm = new Vector<String>();
      Vector<String> vDiv = new Vector<String>();
      
      while(runsql.readNextRecord())
      {
    	  vGrpNm.add(runsql.getData("grpn").trim());
    	  vDiv.add(runsql.getData("div").trim());
      }
      
      String [] sGrpNm = (String []) vGrpNm.toArray(new String[vGrpNm.size()]);
      String [] sGrpDiv = (String []) vDiv.toArray(new String[vDiv.size()]);
      
      CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
      String sGrpNmJva = srvpgm.cvtToJavaScriptArray(sGrpNm);
      String sGrpDivJva = srvpgm.cvtToJavaScriptArray(sGrpDiv);
      srvpgm = null;
      
      vDiv.toArray();
      runsql.disconnect();
      runsql = null;
%>

<title>Aged Summary Selection</title>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<style>
	#trMultDiv { display:none}
  	#trSingleDiv { display:block}
</style>


<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script name="javascript">
var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";

var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];

var ArrGrp = [<%=sGrpNmJva%>];
var ArrDiv = [<%=sGrpDivJva%>];

var blockRow = "table-row";
var blockCell = "table-cell";

var MultView = false;
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ blockRow = "block"; blockCell = "block"; }
	
  	doDivSelect(null); 
  	
  	 
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
function doDivSelect(id)
{
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
           df.selDiv.options[idx] = new Option(divisionNames[idx],divisions[idx]);
        }
        id = 0
        if (document.all.DivArg.value.trim() > 0) id = eval(document.all.DivArg.value.trim());
        df.selDiv.selectedIndex = id;
    }

    df.DivName.value = df.selDiv.options[id].text
    df.Div.value = df.selDiv.options[id].value
    df.DivArg.value = id

    allowed = dep_div[id].split(":");

    //  clear current depts
    for (idx = df.selDpt.length; idx >= 0; idx--)
    {
       df.selDpt.options[idx] = null;
    }

    //  if all are to be displayed
    if (allowed[0] == "all")
    {
       for (idx = 0; idx < depts.length; idx++)
            df.selDpt.options[idx] = new Option(deptNames[idx],depts[idx]);
    }
    //  else display the desired depts
    else
    {
       for (idx = 0; idx < allowed.length; idx++)
           df.selDpt.options[idx] = new Option(deptNames[allowed[idx]], depts[allowed[idx]]);
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
   document.all.DptName.value = document.all.selDpt.options[id].text
   document.all.Dpt.value = document.all.selDpt.options[id].value

   // clear class
   for(var i = document.all.selCls.length; i >= 0; i--) {document.all.selCls.options[i] = null;}
   document.all.selCls.options[0] = new Option("All Classes", "ALL")
   document.all.selCls.options[0] = new Option("All Classes", "ALL")
   document.all.selCls.selectedIndex=0;
   document.all.selCls.size=1
}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showClsSelect(id)
{
   document.all.ClsName.value = document.all.selCls.options[id].text
   document.all.Cls.value = document.all.selCls.options[id].value
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
   for(var i = document.all.selCls.length; i >= 0; i--) {document.all.selCls.options[i] = null;}

   //popilate
   for(var i=0; i < cls.length; i++)
   {
     document.all.selCls.options[i] = new Option(clsName[i], cls[i]);
   }
   document.all.selCls.size=5
}

//==============================================================================
// change Summary option depend on selection
//==============================================================================
function chgSumOpt(clear)
{
  var sumopt = document.all.SumOpt;
  var max = sumopt.length;

  // clear all option when NONE selected
  if(clear)
  {
     for(var i=0; i < max; i++ )
     {
        if(i < max-1) { sumopt[i].checked = false; }
     }
  }
  else
  {
     sumopt[sumopt.length - 1].checked = false;
  }
}

//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = " ";

  var divMult = document.all.DivM;
  var divarr = new Array();
  divarr[0] = document.all.Div.value.trim();
  var divnm = document.all.DivName.value.trim();
  var dpt = document.all.Dpt.value.trim();
  var dptnm = document.all.DptName.value.trim();
  var cls = document.all.Cls.value.trim();
  var clsnm = document.all.ClsName.value.trim();
 
  
//get selected divisions  
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
  if(MultView){ dpt = "ALL"; cls="ALL";}
   
  
//store
  var selstr = new Array();
  if (ArrStr.length < 3){ selstr[0] = document.all.Store.value; }
  else
  {
     var str = document.all.Str;
     selstr = new Array();
     var numstr = 0
     for(var i=0; i < str.length; i++)
     {
       if(str[i].checked){ selstr[numstr] = str[i].value; numstr++; }
     }
     if (numstr == 0){ error=true; msg+="At least 1 store must be selected.";}
  }  
  
  var grp = "Str";
  if(numstr == 1){ grp = "Ctl"; }
  
  var level = "Str";
  var bystr = document.all.BYSTR;
  var SorM = "Y";
  for(var i=0; i < bystr.length;i++)
  {
	  if(bystr[i].checked) { SorM = bystr[i].value; break; }
  }
  
  if(SorM == "Y"){ level = "Str"; }
  else if(MultView){ level = "Div"; }
  else if(divarr[0]=="ALL" && dpt=="ALL" && cls=="ALL"){ level = "Div"; }
  else if(dpt=="ALL" && cls=="ALL"){ level = "Dpt"; }
  else { level = "Cls"; }
  
  var ucrsel = document.all.Ucr;
  var ucr = "R";
  for(var i=0; i < ucrsel.length;i++)
  {
	  if(ucrsel[i].checked) { ucr = ucrsel[i].value; break; }
  }
  
  var prec = "3";
  
  if (error) alert(msg);
  else{ sbmSlsRep(divarr, dpt, cls, selstr, level, ucr, prec); }
  return error == false;
}
//==============================================================================
// Submit Stock Position Report
//==============================================================================
function sbmSlsRep(div, dpt, cls, str, level, ucr, prec)
{
  var url = null;
  url = "AgedSumByDiv.jsp?"
  url += "&Dpt=" + dpt
      + "&Cls=" + cls
      + "&Level=" + level
      + "&Ucr=" + ucr
      + "&Prec=" + prec
  ;
  
  for(var i=0; i < div.length; i++) { url += "&Div=" + div[i]; }
  for(var i=0; i < str.length; i++) { url += "&Str=" + str[i]; }
	  
  //alert(url);
  window.location.href=url;
}
//==============================================================================
//set all store or unmark
//==============================================================================
function setAll(on)
{
var str = document.all.Str;
for(var i=0; i < str.length; i++) { str[i].checked = on; }
}
//==============================================================================
//check by regions
//==============================================================================
function checkReg(dist)
{
var str = document.all.Str
var chk1 = false;
var chk2 = false;

// check 1st selected group check status and save it
var find = false;
for(var i=0; i < str.length; i++)
{
  for(var j=0; j < ArrStr.length; j++)
  {
     if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist
       || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
       || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
       || str[i].value == "68" || str[i].value == "86")))
     {
       chk1 = !str[i].checked;
       find = true;
       break;
     };
  }
  if (find){ break;}
}
chk2 = !chk1;

for(var i=0; i < str.length; i++)
{
  str[i].checked = chk2;
  for(var j=0; j < ArrStr.length; j++)
  {
     if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist
       || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
       || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
       || str[i].value == "68" || str[i].value == "86")))
     {
        str[i].checked = chk1;
     };
  }
}
}

//==============================================================================
//check by districts
//==============================================================================
function checkDist(dist)
{
var str = document.all.Str
var chk1 = false;
var chk2 = false;

// check 1st selected group check status and save it
var find = false;
for(var i=0; i < str.length; i++)
{
  for(var j=0; j < ArrStr.length; j++)
  {
     if(str[i].value == ArrStr[j] && ArrStrDist[j] == dist)
     {
       chk1 = !str[i].checked;
       find = true;
       break;
     };
  }
  if (find){ break;}
}
chk2 = !chk1;

for(var i=0; i < str.length; i++)
{
  str[i].checked = chk2;
  for(var j=0; j < ArrStr.length; j++)
  {
     if(str[i].value == ArrStr[j] && ArrStrDist[j] == dist)
     {
        str[i].checked = chk1;
     };
  }
}
}

//==============================================================================
//check mall
//==============================================================================
function checkMall(type)
{
var str = document.all.Str
var chk1 = true;
var chk2 = false;

for(var i=0; i < str.length; i++)
{
  str[i].checked = chk2;
  for(var j=0; j < ArrStr.length; j++)
  {
     if(str[i].value == ArrStr[j] && ArrStrMall[j] == type)
     {
        str[i].checked = chk1;
     };
  }
}
}
//==============================================================================
//check division by selected group
//==============================================================================
function setAllDiv(chk)
{
	var divfld = document.all.DivM;
	for(var i=0; i < divfld.length; i++)
	{
		divfld[i].checked = chk;
	}
}
//==============================================================================
//check division by selected group
//==============================================================================
function checkDivGrp(grp)
{
	var divfld = document.all.DivM;
	for(var i=0; i < divfld.length; i++)
	{
		divfld[i].checked = false;
		for(var j=0; j < ArrGrp.length; j++)
		{
			var a = ArrGrp[j], b = ArrDiv[j], c = divfld[i].value;
			var t = a==grp, v = b == c;
			if(ArrGrp[j]==grp && ArrDiv[j] == divfld[i].value)
			{
				divfld[i].checked = true;
			}
		}
	}
}
//==============================================================================
//switch between single and multiple divisions selections
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
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script src="Calendar.js"></script>

<HTML><HEAD><meta http-equiv="refresh">

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<TABLE class="tbl05">
  <TBODY>

  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Aged Inventory Summary Report - Selection</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>

      <TABLE border=0>
        <TBODY>
        <!-- ------------- Division  --------------------------------- -->
        <TR id="trSingleDiv">
          <TD>Division:</TD>
          <TD>
             <input class="Small" name="DivName" size=50 readonly>
             <input class="Small" name="Div" type="hidden">
             <input class="Small" name="DivArg" type="hidden" value=0><br>
             <SELECT name="selDiv" class="Small" onchange="doDivSelect(this.selectedIndex);" size=5>
                <OPTION value="ALL">All Divisions</OPTION>
             </SELECT>
          </TD>
        <!-- ======================= Department ============================ -->
          <TD id="trSingleDiv" class="Cell">Department:</TD>
          <TD class="Cell1">
             <input class="Small" name="DptName" size=50 value="All Departments" readonly>
             <input class="Small" name="Dpt" type="hidden" value="ALL"><br>
             <SELECT class="Small" name=selDpt onchange="showDptSelect(this.selectedIndex);"  size=5>
                <OPTION value="ALL">All Departments</OPTION>
             </SELECT>
          </TD>
        </TR>
        <TR>
            <TD class="Cell" >&nbsp;</TD>
         </TR>
        <!-- ========================== Class ============================== -->
        <TR  id="trSingleDiv">
            <TD class="Cell" >Class:</TD>
            <TD class="Cell1">
              <input class="Small" name="ClsName" size=50 value="All Classes" readonly>
              <input class="Small" name="Cls" type="hidden" value="ALL">
              <button class="Small" value="Select Class" name=SUBMIT onClick="rtvClasses()">Select Class</button><br>
              <SELECT name="selCls" class="Small" onchange="showClsSelect(this.selectedIndex);">
                 <OPTION value="ALL">All Classes</OPTION>
              </SELECT>
            </TD>
        </TR>
        <TR id="trSingleDiv">
            <TD class="Cell1" align=center colspan=4>
              <button class="Small" onClick="switchDiv('MULTIPLE')">Multiple Divisions</button>
           </td>
        </TR>
        
        
        <!-- ===================== Multiple Division Selection ============= -->
        <TR id="trMultDiv">
          <TD class="Cell" >Division:</TD>   
          <TD class="Small" colspan=4 nowrap>
            <%for(int i=0; i < sDivArr.length; i++){%>
               <input class="Small" name="DivM" type="checkbox" value="<%=sDivArr[i]%>"> <%=sDivArr[i]%>
               <%if(i > 0 && i % 14 == 0){%><br><%}%>
            <%}%>
            <br>
            <%if(iNumOfStr > 1) {%>
              <br><button class="Small" onClick="setAllDiv(true)">All Divisions</button> &nbsp;
              
              <button onclick='checkDivGrp(&#34;SKI&#34;)' class='Small'>Ski</button> &nbsp; &nbsp;
              <button onclick='checkDivGrp(&#34;OUTDOOR&#34;)' class='Small'>Outdoor</button> &nbsp; &nbsp;
              <button onclick='checkDivGrp(&#34;CYCLING&#34;)' class='Small'>Cycling</button> &nbsp; &nbsp;
              <button onclick='checkDivGrp(&#34;WATER&#34;)' class='Small'>Water</button> &nbsp; &nbsp;
              <button onclick='checkDivGrp(&#34;SKATE&#34;)' class='Small'>Skate</button> &nbsp; &nbsp;
              <button onclick='checkDivGrp(&#34;ACTIVE APPAREL&#34;)' class='Small'>Active Apparel</button> &nbsp; &nbsp;
              <button onclick='checkDivGrp(&#34;FOOTWEAR&#34;)' class='Small'>Footwear</button> &nbsp; &nbsp;
              <button onclick='checkDivGrp(&#34;PATIO&#34;)' class='Small'>Patio</button> &nbsp; &nbsp;
              <button onclick='checkDivGrp(&#34;OTHER&#34;)' class='Small'>Other</button> &nbsp; &nbsp;
                          
              <button class="Small" onClick="setAllDiv(false)">Reset</button><br><br>
              <%}%>
          </TD>
        </TR>
        <TR id="trMultDiv">
           <TD class="Cell1" align=center colspan=4>
              <button class="Small"  onClick="switchDiv('SINGLE')">Single Divisions</button>
           </td>
        </TR>
        
        
        <!-- =============================================================== -->
        <TR><TD style="border-top:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
         <!-- ============== Multiple Store selection ======================= -->
        <tr id="trMult">
         <td colspan="5" class="Small" nowrap>

         <%for(int i=0; i < iNumOfStr; i++){%>
                  <input class="Small" name="Str" type="checkbox" value="<%=sStr[i]%>"><%=sStr[i]%>&nbsp;
                  <%if(i > 0 && i % 14 == 0){%><br><%}%>
              <%}%>
              <%if(iNumOfStr > 1) {%>
              <br><button class="Small" onClick="setAll(true)">All Store</button> &nbsp;  
              <button onclick='checkReg(&#34;1&#34;)' class='Small'>Dist 1</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;2&#34;)' class='Small'>Dist 2</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;3&#34;)' class='Small'>Dist 3</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;4&#34;)' class='Small'>Dist 4</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;99&#34;)' class='Small'>Dist 99</button> &nbsp; &nbsp;
                          
              <button class="Small" onClick="setAll(false)">Reset</button><br><br>
              <%}%>

         </td>
        </tr>
        
         
        
         
         <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2"  align=center  colspan=4><b><u>Report by:</b></u></TD></tr>

        <TR>
          <TD class="Cell2"  align=center  colspan=4>
             <input name="BYSTR" type="radio" value="Y" checked>Store &nbsp; &nbsp;
              <input name="BYSTR" type="radio" value="N">Div/Dpt/Cls/Ven
          </TD>
        </TR>
        
        <!-- =============================================================== -->
        <TR><TD class="Cell2"  align=center  colspan=4><br><b><u>Select type of information:</b></u></TD></tr> 
        <TR>
          <TD class="Cell2"  align=center  colspan=4>
             <input name="Ucr" type="radio" value="U">Unit &nbsp; &nbsp;
             <input name="Ucr" type="radio" value="C" checked>Cost &nbsp; &nbsp;
             <input name="Ucr" type="radio" value="R">Retail
          </TD>
        </TR>
        
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD></TD>
            <TD class="Cell2"  align=center colSpan=4>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate()">
           </TD>
          </TR>
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>

</BODY></HTML>
<%}%>