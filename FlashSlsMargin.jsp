<!DOCTYPE html>
<%@ page import="flashreps.FlashSlsMargin, rciutility.StoreSelect, rciutility.RunSQLStmt, rciutility.RtvStrGrp, java.sql.*, java.util.*, java.text.*"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String sDiv = request.getParameter("Div");
   String sDpt = request.getParameter("Dpt");
   String sCls = request.getParameter("Cls");
   String sToDate = request.getParameter("ToDate");    
   String sBy = request.getParameter("ShowBy");
   String sSelCol = request.getParameter("col");
   String sSort = request.getParameter("Sort");
   
   SimpleDateFormat smp = new SimpleDateFormat("MM/dd/yyyy");
   
   if(sDiv == null){ sDiv = "ALL"; }
   if(sDpt == null){ sDpt = "ALL"; }
   if(sCls == null){ sCls = "ALL"; }
   if(sToDate == null)
   {
	   java.util.Date dtPrior  = new java.util.Date(new java.util.Date().getTime() - 24 * 60 * 60 * 1000);
      sToDate = smp.format(dtPrior);
   }  
   
   if(sSelStr != null && sSelStr[0].equals("ALL")){sSelStr = null;}
   
   if(sSelCol == null) {  sSelCol = "4"; }
   
   if(sBy == null){ sBy = "STR"; }
   if(sSort == null){ sSort = "Grp"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=FlashSlsMargin.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   StoreSelect strsel = new StoreSelect();
   String sStrJsa = strsel.getStrNum();
   String sStrNameJsa = strsel.getStrName();
   int iNumOfStr = strsel.getNumOfStr();
   String [] sStrLst = strsel.getStrLst();
   String [] sStrRegLst = strsel.getStrRegLst();
   String sStrRegJsa = strsel.getStrReg();

   String [] sStrDistLst = strsel.getStrDistLst();
   String sStrDistJsa = strsel.getStrDist();
   String [] sStrDistNmLst = strsel.getStrDistNmLst();
   String sStrDistNmJsa = strsel.getStrDistNm();

   String [] sStrMallLst = strsel.getStrMallLst();
   String sStrMallJsa = strsel.getStrMall();

   int iSpace = 6;

   if(sSelStr ==null)
   {
      Vector vStr = new Vector();
      for(int i=0; i < iNumOfStr; i++)
      {
         if(!sStrLst[i].equals("55") && !sStrLst[i].equals("89") )
         {
           vStr.add(sStrLst[i]);
         }
      }

      sSelStr = (String [])vStr.toArray(new String[vStr.size()]);;
   }

   String sUser = session.getAttribute("USER").toString();
   
   //System.out.println(sFrom + "|" + sTo + "|" + sStrOpt + "|" + sDatOpt + "|" + sSort + "|" + sUser);
   FlashSlsMargin flashm = new FlashSlsMargin(sSelStr, sDiv, sDpt, sCls, sToDate, sBy, sSort, sUser);
   
   int iNumOfGrp = flashm.getNumOfGrp();
   int iNumOfReg = flashm.getNumOfReg();
   
   String [] sWkDate = flashm.getWkDate();
   
   RtvStrGrp rtvstr = new RtvStrGrp();
   String sGrpNmJsa = rtvstr.getGrpJsa();
   String sGrpBtnJsa = rtvstr.getGrpBtnJsa();
   String sGrpStrJsa = rtvstr.getStrJsa();  
   
   java.util.Date dCurDate = new java.util.Date();
   SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
   String sCurDate = sdf.format(dCurDate);

   String sPrepStmt = "select pyr#, pmo#, pime from rci.fsyper"
     + " where pida='" + sCurDate + "'";
   //System.out.println(sPrepStmt);
   ResultSet rslset = null;
   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sPrepStmt);
   runsql.runQuery();
   runsql.readNextRecord();
   String sYear = runsql.getData("pyr#");
   String sMonth = runsql.getData("pmo#");
   String sMnend = runsql.getData("pime");
   runsql.disconnect();
   runsql = null;
   
   // set Group column name
   String sGrpColNm = "Store";
   if(sBy.equals("MERCH"))
   {
	   if(!sDpt.equals("ALL") && sCls.equals("ALL")){ sGrpColNm = "Class";}
	   else if(!sDiv.equals("ALL") && sDpt.equals("ALL") && sCls.equals("ALL")){ sGrpColNm = "Dpt";}
	   else if(sDiv.equals("ALL") && sDpt.equals("ALL") && sCls.equals("ALL")){ sGrpColNm = "Div";}
   }
   
   // allow or not drill down
   boolean bDrill = true;
   if(sSelStr.length == 1 && (!sDpt.equals("ALL")) || !sCls.equals("ALL"))
   {
	      bDrill = false;
   }
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Flash Sales - GM</title>

<SCRIPT>

//--------------- Global variables -----------------------
var ToDate = "<%=sToDate%>";
var ArrStr = [<%=sStrJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];
var ArrGrpNm = [<%=sGrpNmJsa%>];
var ArrGrpBtn = [<%=sGrpBtnJsa%>];
var ArrGrpStr = [<%=sGrpStrJsa%>];

var SelDiv = "<%=sDiv%>";
var SelDpt = "<%=sDpt%>";
var SelCls = "<%=sCls%>";

var SelCol = "<%=sSelCol%>";
var ShowBy = "<%=sBy%>";
var Sort = "<%=sSort%>"

var ArrSelStr = new Array();
<%for(int i=0; i < sSelStr.length; i++){%>ArrSelStr[<%=i%>] = "<%=sSelStr[i]%>";<%}%>

var AllLines = 0;
//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvGraph"]);
   setSelectPanelShort(); 
   setSelectedColumns();
}
//==============================================================================
// set Short form of select parameters
//==============================================================================
function setSelectPanelShort()
{
   var hdr = " &nbsp; &nbsp; &nbsp; Select Report Parameters &nbsp; &nbsp; &nbsp; ";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='RestoreButton.bmp' onclick='javascript:setSelectPanel();' alt='Restore'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"
   html += "</td></tr></table>"

   document.all.dvSelect.innerHTML=html;
   document.all.dvSelect.style.pixelLeft= document.documentElement.scrollLeft + 10;
   document.all.dvSelect.style.pixelTop= document.documentElement.scrollTop + 120;
   document.all.dvSelect.style.width=200;
}
//==============================================================================
// set Weekly Selection Panel
//==============================================================================
function setSelectPanel()
{
  var hdr = "Select Report Parameters";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='MinimizeButton.bmp' onclick='javascript:setSelectPanelShort();' alt='Minimize'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"
   
   html += popSelWk();

   html += "</td></tr></table>"
   document.all.dvSelect.innerHTML=html;
   document.all.dvSelect.style.width=600;
   
   setInitDateSel();
   
   document.all.SelDiv.value = SelDiv;
   document.all.SelDpt.value = SelDpt;
   document.all.SelCls.value = SelCls;
   
   rtvDivDptCls("ALL", "ALL", "DIVDPT");  
   
   // setup date range   
   var str = document.all.Str;
   for(var i=0; i < str.length; i++)
   {
      for(var j=0; j < ArrStr.length; j++)
      {
         if(str[i].value == ArrSelStr[j]){ str[i].checked = true;}
         else{ str[i].checked == false; }
      }
   }
   
// checked selected columns
   var col = document.all.SelCol;
   for(var i=0; i < col.length; i++)
   {
	   if(col[i].value == SelCol){ col[i].checked = true;}
       else{ col[i].checked == false; }      
   }
}
//==============================================================================
// populate Column Panel
//==============================================================================
function popSelWk()
{
  var panel = "<table border=0 cellPadding=0 cellSpacing=0>"
	+ "<tr class='trDtl04'>"
      + "<td class='td09' colspan=3>"
	     + "<table border=0 cellPadding='0' cellSpacing='0'  width='100%'>"
         	+ "<tr><td class='td08'>Division:</td>"
          		+ "<td class='td08'>"
          		   + "<input name='SelDiv' class='Small' maxlength=3 size=3 readonly>&nbsp;"
          		   + "<select class='Small' name='Division' onchange='doDivSelect(this.selectedIndex); setSelMearch();'></select>" 
        		+ "</td>"
          	+ "</tr>"
          	+ "<tr class='trDtl04'>"
      		    + "<td class='td08'>Department:</td>"
          		+ "<td class='td08'>"
          			+ "<input name='SelDpt' class='Small' maxlength=3 size=3 readonly>&nbsp;"
      		    	+ "<select class='Small' name='Department' onChange='clearClassSel(); setSelMearch();' ></select>"
            		+ "&nbsp;<button onClick='rtvClasses()' class='Small'>Classes</button></td>"
            + "</tr>"
            + "<tr class='trDtl04'>"		
      			+ "<td class='td08'>Class:</td>"
         		+ "<td class='td08'>" 
         			+ "<input name='SelCls' class='Small' maxlength=4 size=4 readonly>&nbsp;"
         			+ "<select class='Small' name='Class' onChange='setSelMearch();' ></select>"
         		+ "</td>"
         	+ "</tr>"
         + "</table>"
    + "</tr>"
    
    + "<tr><td class='Separator01' colspan=3>&nbsp</td></tr>"
    
    + "<tr class='trDtl07'>"
       + "<td class='td09' colspan=3><u>Stores</u></td>"
     + "</tr>"
     + "<tr style='background:#F8ECE0'>"
       + "<td class='td09' colspan=3>"
          + "<table border=0  width='100%'>"
              + "<tr>"

  for(var i=1, j=0; i < ArrStr.length; i++, j++)
  {
     if(j > 0 && j % 17 == 0){ panel += "<tr>"}
     panel += "<td class='Small' nowrap>"
          + "<input type='checkbox' class='Small' name='Str' value='" + ArrStr[i] + "'>" + ArrStr[i]
        + "</td>"
  }

  panel += "</table>"
          + "<button onclick='checkAll(true)' class='Small'>All</button> &nbsp; &nbsp;"
          + "<button onclick='checkAll(false)' class='Small'>Reset</button>";
  var space = " &nbsp; &nbsp;";
  
  // add store group buttons
  for(var i=0; i < ArrGrpNm.length; i++)
  {
	  if(ArrGrpBtn[i]=="Mall (7)") { panel += "<br>"; } 
	  else if(ArrGrpBtn[i]=="All Brick & Mortar") { panel += "<br>"; } 
	  panel += space + "<button onclick='checkStrGrp(&#34;" + ArrGrpNm[i] + "&#34;,&#34;" + ArrGrpBtn[i] + "&#34;, this)' class='Small'>" + ArrGrpBtn[i] + "</button>"
	   
  }
  
  panel += "<br>"
    + "<span style='font-size:11px'>Note: Clicking the Store Group button more than once, toggles to INCLUDE or EXCLUDE the stores in this group.</span>" 
          
  panel += "</td>"
     + "</tr>"
     
     + "<tr><td class='Separator01' colspan=3>&nbsp</td></tr>"
     
     + "<tr id='trDt2' class='trDtl06'>"
     	+ "<td class='td08'>Show by:</td>"
     	+ "<td class='td08'>"
     	    + "<input type='radio' class='Small' name='ShowBy' value='STR' checked>Store &nbsp; "
     	    + "<input type='radio' class='Small' name='ShowBy' value='MERCH'>Merchandise Group &nbsp; "
     	+ "</td>"
     + "</tr>"	
     
     + "<tr><td class='Separator01' colspan=3>&nbsp</td></tr>"

     + "<tr id='trDt2' class='trDtl05'>"
       + "<td class='td08' id='td2Dates' width='10%'>To:</td>"
       + "<td class='td08' id='td2Dates' width='35%'>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;To&#34;)'>&#60;</button>"
          + "<input name='To' class='Small' size='10' >"
          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;To&#34;)'>&#62;</button>"       
          + " &nbsp; <a href='javascript:showCalendar(1, null, null, 650, 250, document.all.To)'>"
              + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
     + "</tr>"
 
     + "<tr><td class='Separator01' colspan=3>&nbsp</td></tr>"
   
     + "<tr  class='trDtl06'>"
     + "<td class='td08' colspan=3>"      
        + "<table>"
        
        + "<tr><td nowrap colspan='2'>Selected Groups:</td>"
           + "<td  nowrap><input type='radio' class='Small' name='SelCol' value='0'>Retail</td>"
           + "<td  nowrap><input type='radio' class='Small' name='SelCol' value='1'>Cost</td>"
           + "<td  nowrap><input type='radio' class='Small' name='SelCol' value='2'>Units</td>"
           + "<td  nowrap><input type='radio' class='Small' name='SelCol' value='3'>GM $</td>"
           + "<td  nowrap><input type='radio' class='Small' name='SelCol' value='4'>GM %</td>"
           + "<td  nowrap><input type='radio' class='Small' name='SelCol' value='5'>Avg Retail per Unit Sold - (Retail/Units)</td>"
        + "</tr>"        
      + "</table>"          

    + "</tr>"
     
    + "<tr><td class='Separator01' colspan=3>&nbsp</td></tr>";
     
  	panel += "<tr><td class='td09' colspan=3>"
    	   + "<button onClick='Validate()' class='Small'>Submit</button> &nbsp;"
           + "<button onClick='setSelectPanelShort();' class='Small'>Close</button>&nbsp;</td></tr>";

  	panel += "</table>";

  	return panel;
}
//==============================================================================
//retreive classes
//==============================================================================
function rtvClasses()
{
	var div = document.all.Division.options[document.all.Division.selectedIndex].value
	var dpt = document.all.Department.options[document.all.Department.selectedIndex].value
	rtvDivDptCls(div, dpt, "CLASS");
}
//==============================================================================
//retreive div/dpt/classes
//==============================================================================
function rtvDivDptCls(div, dpt, info)
{
	var url = "RetreiveDivDptCls.jsp?"
        + "Division=" + div
        + "&Department=" + dpt
        + "&Info=" + info;

	//alert(url);
	//window.location.href = url;
	window.frame1.location = url;
}
//==============================================================================
//populate division dropdown menu
//==============================================================================
function doDivSelect(id) 
{
	var df = document.all;
	var chkIdx = id == null;

 	var allowed;

 	if (id == null || id == 0) 
 	{
     	//  populate the division list
     	for (var i = 0; i < Div.length; i++)
     	{
         	df.Division.options[i] = new Option(DivName[i], Div[i]);
         	if(chkIdx && Div[i]==SelDiv){ df.Division.selectedIndex = i; }
     	}         	
     	id = 0;
 	}
    allowed = DptGroup[id].split(":");

    //  clear current depts
    for (var i = df.Department.length; i >= 0; i--) df.Department.options[i] = null;

    //  if all are to be displayed
    if (allowed[0] == "all")
         for (var i = 0; i < Dpt.length; i++)
         {    
        	 df.Department.options[i] = new Option(DptName[i],Dpt[i]);
        	 if(chkIdx && Dpt[i]==SelDpt){ df.Department.selectedIndex = i; }
         }

     //  else display the desired depts
     else
         for (var i = 0; i < allowed.length; i++)
         {  	 
             df.Department.options[i] = new Option(DptName[allowed[i]], Dpt[allowed[i]]);
         }    
     clearClassSel();
}
//==============================================================================
// set selected mercahndise group
//==============================================================================
function setSelMearch()
{
	document.all.SelDiv.value = document.all.Division.options[document.all.Division.selectedIndex].value;
    document.all.SelDpt.value = document.all.Department.options[document.all.Department.selectedIndex].value;
    document.all.SelCls.value = document.all.Class.options[document.all.Class.selectedIndex].value;
}

//==============================================================================
//clear Class dropdown menu
//==============================================================================
function clearClassSel()
{
//  clear current classes
for (var i = document.all.Class.length; i >= 0; i--)
{
   document.all.Class.options[i] = null;
}
document.all.Class.options[0] = new Option("All Classes","ALL");
}
//==============================================================================
//show selected Division/ department
//==============================================================================
function showDivDpt(div, divName, dpt, dptName, dptGroup)
{
	window.frame1.close();
	Div = div;
	DivName = divName;
	Dpt = dpt;
	DptName = dptName;
	DptGroup = dptGroup;
	// populate division and department
	if(document.all.Division != null) doDivSelect(null);
}
//==============================================================================
//show selected classes
//==============================================================================
function showClasses(cls, clsName)
{
if(document.all.Class != null)
{
   // clear
   for(var i = document.all.Class.length; i >= 0; i--) {document.all.Class.options[i] = null;}

   //popilate
   for(var i=0; i < cls.length; i++)
   {
     document.all.Class.options[i] = new Option(clsName[i], cls[i]);
   }
   window.frame1.close();
}
}
//==============================================================================
//set selected columns
//==============================================================================
function setSelectedColumns()
{	
	// test selected columns
	var retcol = document.all.spnRet;
	var costcol = document.all.spnCost;
	var qtycol = document.all.spnQty;
	var margcol = document.all.spnMarg;
	var margprccol = document.all.spnMargPrc;
	var avgcol = document.all.spnAvg;
	
	var dispret = "none"; 
	if(SelCol == 0){dispret = "block";}
	var dispcost = "none"; 
	if(SelCol == 1){dispcost = "block";}
	var dispqty = "none"; 
	if(SelCol == 2){dispqty = "block";}
	var dispmarg = "none"; 
	if(SelCol == 3){dispmarg = "block";}
	var dispmargp = "none"; 
	if(SelCol == 4){dispmargp = "block";}
	var dispavg = "none"; 
	if(SelCol == 5){dispavg = "block";}
	
	for(var i=0; i < retcol.length; i++){ retcol[i].style.display = dispret; }
	for(var i=0; i < retcol.length; i++){ costcol[i].style.display = dispcost; }
	for(var i=0; i < retcol.length; i++){ qtycol[i].style.display = dispqty; }
	for(var i=0; i < retcol.length; i++){ margcol[i].style.display = dispmarg; }
	for(var i=0; i < retcol.length; i++){ margprccol[i].style.display = dispmargp; }
	for(var i=0; i < retcol.length; i++){ avgcol[i].style.display = dispavg; }
}
//==============================================================================
// check all stores
//==============================================================================
function checkAll(chk)
{
  var str = document.all.Str

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk;
  }
}
//==============================================================================
// check by regions
//==============================================================================
function checkStrGrp(grp, btn, obj)
{
  var str = document.all.Str
  var chk1 = false;
  var chk2 = false;
  
  // find location of clicked button in store group array
  var argg = -1;
  for(var i=0; i < ArrGrpNm.length; i++)
  {
      if(ArrGrpNm[i]==grp){argg=i; break;}
  }  

  // check 1st selected group check status and save it
  var find = false;
  for(var i=0; i < str.length; i++)
  {
     for(var j=0; j < ArrGrpStr[argg].length; j++)
     {    	
        if(str[i].value == ArrGrpStr[argg][j])
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
     for(var j=0; j < ArrGrpStr[argg].length; j++)
     {
    	var s = str[i].value;
     	var g = ArrGrpStr[argg][j];
    	if(str[i].value == ArrGrpStr[argg][j])
        {
           str[i].checked = chk1;           
           break;
        };
     }
  }
}

//==============================================================================
// check by districts
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
// check mall
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
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
}

//==============================================================================
// set date ranges
//==============================================================================
function setDtRange()
{
   var grp = document.all.DtGrp;
   for(var i=0; i < grp.length; i++)
   {
      if(grp[i].checked && i < grp.length-1)
      {
         document.all.trDt2[0].style.display="none";
         document.all.trDt2[1].style.display="none";
         document.all.trDt3[0].style.display="none";
         document.all.trDt3[1].style.display="none";
         break;
      }
      else if(grp[i].checked)
      {
    	 if(DateFmt == "C")
    	 {	 
            document.all.trDt2[0].style.display="block";
            document.all.trDt2[1].style.display="block";
            document.all.trDt3[0].style.display="none";
            document.all.trDt3[1].style.display="none";            
            break;
    	 }
    	 else
    	 {
    		 document.all.trDt3[0].style.display="block";
             document.all.trDt3[1].style.display="block";
             document.all.trDt2[0].style.display="none";
             document.all.trDt2[1].style.display="none";
             break;
    	 }
      }
   }
}
//==============================================================================
// set initial date selectio
//==============================================================================
function setInitDateSel()
{	
	document.all.To.value = ToDate;
}
//==============================================================================
// Validate entry
//==============================================================================
function Validate()
{
   var error = false;
   var msg = "";
   var br = "";

   // get selected stores
   var str = document.all.Str;
   var selstr = new Array();
   var numstr = 0
   for(var i=0; i < str.length; i++)
   {
     if(str[i].checked){ selstr[numstr] = str[i].value; numstr++;}
   }
   if (numstr == 0){ error=true; msg+="At least 1 store must be selected."; br = "<br>";}
   
   var seldiv = document.all.SelDiv.value.trim();
   var seldpt = document.all.SelDpt.value.trim();
   var selcls = document.all.SelCls.value.trim();
  
   var showby = document.all.ShowBy;
   var selby = "";
   for(var i=0; i < showby.length;i++)
   {
	   if(showby[i].checked){ selby = showby[i].value; }
   }	   
   
   // get date
   var selTo = " ";
   selTo = document.all.To.value.trim();
   
   var selcol = SelCol;
   var col = document.all.SelCol;
   for(var i=0; i < col.length; i++)
   {
	   if(col[i].checked){ selcol = col[i].value; break; } 
   }	   
   
   if(error){alert(msg)}
   else{ submitForm(selstr, seldiv, seldpt, selcls, selTo, selcol, selby); }
}
//==============================================================================
// change action on submit
//==============================================================================
function submitForm(selstr, seldiv, seldpt, selcls, selTo, selcol, selby)
{
   var url;
   url = "FlashSlsMargin.jsp?Div=" + seldiv + "&Dpt=" + seldpt + "&Cls=" + selcls;
   
   for(var i=0; i < selstr.length; i++) { url += "&Str=" + selstr[i]; }
   
   url += "&ShowBy=" + selby;
   url += "&ToDate=" + selTo;
   url += "&col=" + selcol; 

   //alert(url);
   window.location.href=url;
}
//==============================================================================
//Hide selection screen
//==============================================================================
function drillDown(grp)
{
	var url = "FlashSlsMargin.jsp?";
		
	var selby = ShowBy;
	if(selby == "MERCH" && SelDpt != "ALL" ){ url += "Div=" + SelDiv + "&Dpt=" + SelDpt + "&Cls=" + grp; selby = "STR";}
	else if(selby == "MERCH" && SelDiv != "ALL" ){ url += "Div=" + SelDiv + "&Dpt=" + grp + "&Cls=ALL"; }
	else if(selby == "MERCH"){ url += "Div=" + grp + "&Dpt=ALL&Cls=ALL"; }
	else if(selby == "STR"){ url += "Div=" + SelDiv + "&Dpt=" + SelDpt + "&Cls=" + SelCls + "&Str=" + grp; selby = "MERCH";}
	   
	if(ShowBy != "STR")
	{
	   for(var i=0; i < ArrSelStr.length; i++) { url += "&Str=" + ArrSelStr[i]; }
	}
	   
	url += "&ShowBy=" + selby;
	url += "&ToDate=" + ToDate;
	url += "&col=" + SelCol;
	url += "&Sort=" + Sort;
	
	//alert(url)
	window.location.href = url;
}

//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvGraph.innerHTML = " ";
   document.all.dvGraph.style.visibility = "hidden";
}

//==============================================================================
// re-sort report
//==============================================================================
function resort(sort, col)
{
   var url = "FlashSlsMargin.jsp?"
     + "Div=" + SelDiv + "&Dpt=" + SelDpt + "&Cls=" + SelCls;		   
	
	for(var i=0; i < ArrSelStr.length; i++) { url += "&Str=" + ArrSelStr[i]; }
	   
	url += "&ShowBy=" + ShowBy;
	url += "&ToDate=" + ToDate;
	url += "&col=" + SelCol;
	
	url += "&Sort=";
	if(col != null)
	{ 
		if( SelCol == 0 ){url += "Ret" + sort + col;}
		else if( SelCol == 1 ){url += "Cost" + sort + col;}
		else if( SelCol == 2 ){url += "Qty" + sort + col;}
		else if( SelCol == 3 ){url += "Marg" + sort + col;}
		else if( SelCol == 4 ){url += "MargP" + sort + col;}
		else if( SelCol == 5 ){url += "Avg" + sort + col;}
	}
	else{ url += "Grp"; }
	
	//alert(url)
	window.location.href = url;
}
//==============================================================================
//reverse by merchandise group
//==============================================================================
function reverseGrp()
{
	var url = "FlashSlsMargin.jsp?"
	+ "Div=" + SelDiv + "&Dpt=" + SelDpt + "&Cls=" + SelCls;		   
		
	for(var i=0; i < ArrSelStr.length; i++) { url += "&Str=" + ArrSelStr[i]; }
		   
	var by = "STR";
	if(ShowBy == "STR"){ by = "MERCH"; }
	url += "&ShowBy=" + by;
	url += "&ToDate=" + ToDate;
	url += "&col=" + SelCol;
		
	url += "&Sort=" + Sort;
	window.location.href = url;
}
</SCRIPT>
<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvSelect" class="dvSelect"></div>
<div id="dvGraph" class="dvGraph"></div>
<div id="dvSbm" class="dvGraph"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame100"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <thead>
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Flash Sales Report
            <br>Stores:
               <%String sComa = "";%>
               <%for(int i=0; i < sSelStr.length;i++){%>
                  <%if(i > 0 && i%20 == 0){%><br><%}%>
                  <%=sComa%><%=sSelStr[i]%>
                  <%sComa = ", ";%>
               <%}%>
             <br>Div: <%=sDiv%> &nbsp; Dpt: <%=sDpt%> &nbsp; Cls: <%=sCls%>  

              <br>To: <span id="spnToHdr"><%=sToDate%></span> &nbsp;&nbsp;&nbsp;&nbsp;
            </b>
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr>
          </td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02" rowspan="4">
             <a href="javascript: resort('Grp', null)"><%=sGrpColNm%></a><br><br>
             <a href="javascript: reverseGrp()"><%if(sBy.equals("STR")){%>Merch Grp<%} else {%>Str<%}%><a>
          </th>
          <th class="th02" colspan="28">Date</th>
          <th class="th02" rowspan="4">&nbsp;</th>
          <th class="th02" rowspan="2" colspan="3">W-T-D</th>
          <th class="th02" rowspan="4">&nbsp;</th>
          <th class="th02" rowspan="2">LY Wk<br>Ending</th>
          <th class="th02" rowspan="4">&nbsp;</th>
          <th class="th02" rowspan="2" colspan="3">M-T-D</th>
          <th class="th02" rowspan="4">&nbsp;</th>
          <th class="th02" rowspan="2">LY Month<br>Ending</th>
          <th class="th02" rowspan="4">&nbsp;</th>
          <th class="th02" rowspan="2" colspan="3">Q-T-D</th>
          <th class="th02" rowspan="4">&nbsp;</th>
          <th class="th02" rowspan="2" colspan="3">Y-T-D</th>
          <th class="th02" rowspan="4"><a href="javascript: resort('Grp')"><%=sGrpColNm%></a></th>
        </tr>
        <tr class="trHdr01">
          <%for(int i=0; i < 7; i++){%>
             <th class="th02" rowspan="3">&nbsp;</th>
             <th class="th02" colspan=3><%=sWkDate[i]%></th>
          <%}%>
        </tr>
        <tr class="trHdr01">
          <%for(int i=0; i < 13; i++){%>
             <th class="th02" <%if(i != 8 && i != 10){%>colspan=3<%}%>>               
                <span id="spnRet" nowrap>Retail $</span>
                <span id="spnCost">Cost $</span>
                <span id="spnQty">Units</span>
                <span id="spnMarg">Margin $</span>
                <span id="spnMargPrc">Margin %</span>
                <span id="spnAvg">Avg Retail<br>per Unit Sold<br>(Retail/Units)</span>               
             </th>             
          <%}%>          
        </tr>  
              
        <tr class="trHdr01">
          <%for(int i=0; i < 13; i++){%>
             <%if(i != 8 && i != 10){%><th class="th02"><a href="javascript:resort('TY', '<%=i+1%>')">TY</a></th><%}%>
             <th class="th02"><a href="javascript:resort('LY', '<%=i+1%>')">LY</a></th>
             <%if(i != 8 && i != 10){%><th class="th02"><a href="javascript:resort('VAR', '<%=i+1%>')">Var</a></th><%}%>                          
          <%}%>
           
        </tr>
        </thead>
<!------------------------------- Detail --------------------------------->
           <%int iLine=0;%>           
           <%for(int i=0; i < iNumOfGrp; i++) {
        	   flashm.setSales();
    		   String sGrp = flashm.getGrp();
    		   String sGrpNm = flashm.getGrpNm();
    		   String [] sTyRet = flashm.getTyRet();
    		   String [] sTyCost = flashm.getTyCost();
    		   String [] sTyQty = flashm.getTyQty();
    		   String [] sLyRet = flashm.getLyRet();
    		   String [] sLyCost = flashm.getLyCost();
    		   String [] sLyQty = flashm.getLyQty();
    		   
    		   String [] sTyMarg = flashm.getTyMarg();
    		   String [] sTyMargPrc = flashm.getTyMargPrc();
    		   String [] sLyMarg = flashm.getLyMarg();
    		   String [] sLyMargPrc = flashm.getLyMargPrc();
    		   
    		   String [] sVarRet = flashm.getVarRet();
    		   String [] sVarCost = flashm.getVarCost();
    		   String [] sVarQty = flashm.getVarQty();
    		   String [] sVarMarg = flashm.getVarMarg();
    		   String [] sVarMargPrc = flashm.getVarMargPrc();
    		   
    		   String [] sTyAvg = flashm.getTyAvg();
    		   String [] sLyAvg = flashm.getLyAvg();
    		   String [] sVarAvg = flashm.getVarAvg();
           %>
              <tr id="trId<%=iLine%>" class="trDtl01">
                <td class="td11" nowrap>
                    <%if(bDrill){ %><a href="javascript: drillDown('<%=sGrp%>')"><%=sGrp%> - <%=sGrpNm%></a><%}
                    else{%><%=sGrp%> - <%=sGrpNm%><%}%>                    
                </td>
                <%for(int j=0; j < 13; j++){%>
                   <td class="td10">&nbsp;</td>
                   <%if(j != 8 && j != 10){%>
                      <td class="td04" nowrap>
                      	<span id="spnRet"><%=sTyRet[j]%></span>
                      	<span id="spnCost"><%=sTyCost[j]%></span>
                      	<span id="spnQty"><%=sTyQty[j]%></span>
                      	<span id="spnMarg"><%=sTyMarg[j]%></span>
                      	<span id="spnMargPrc"><%=sTyMargPrc[j]%></span>
                      	<span id="spnAvg"><%=sTyAvg[j]%></span>
                   	  </td>
                   <%}%>
                   <td class="td04" nowrap>
                      <span id="spnRet"><%=sLyRet[j]%></span>
                      <span id="spnCost"><%=sLyCost[j]%></span>
                      <span id="spnQty"><%=sLyQty[j]%></span>
                      <span id="spnMarg"><%=sLyMarg[j]%></span>
                      <span id="spnMargPrc"><%=sLyMargPrc[j]%></span>
                      <span id="spnAvg"><%=sLyAvg[j]%></span>
                   </td>
                   <%if(j != 8 && j != 10){%>
                      <td class="td12" nowrap>
                      	<span id="spnRet"><%=sVarRet[j]%></span>
                      	<span id="spnCost"><%=sVarCost[j]%></span>
                      	<span id="spnQty"><%=sVarQty[j]%></span>
                      	<span id="spnMarg"><%=sVarMarg[j]%></span>
                      	<span id="spnMargPrc"><%=sVarMargPrc[j]%></span>
                      	<span id="spnAvg"><%=sVarAvg[j]%></span>
                   	  </td>
                   <%}%>                                                         
                <%}%>
                     
                <td class="td05" nowrap>
                    <%if(bDrill){ %><a href="javascript: drillDown('<%=sGrp%>')"><%=sGrp%></a><%}
                    else{%><%=sGrp%><%}%>                    
                </td>      
              </tr>                                  
              <%iLine++;%>                
           <%}%>
           <!-- ============================================================= -->
           <!-- ================ Region Total line =========================== -->
           <!-- ============================================================= -->
           <tr><td class="Separator03" colspan="50">&nbsp;</td></tr>
           
           <%for(int i=0; i < iNumOfReg; i++) {
        	   flashm.setRegTot();
    		   String sGrp = flashm.getGrp();
    		   String sGrpNm = flashm.getGrpNm();
    		   String [] sTyRet = flashm.getTyRet();
    		   String [] sTyCost = flashm.getTyCost();
    		   String [] sTyQty = flashm.getTyQty();
    		   String [] sLyRet = flashm.getLyRet();
    		   String [] sLyCost = flashm.getLyCost();
    		   String [] sLyQty = flashm.getLyQty();
    		   
    		   String [] sTyMarg = flashm.getTyMarg();
    		   String [] sTyMargPrc = flashm.getTyMargPrc();
    		   String [] sLyMarg = flashm.getLyMarg();
    		   String [] sLyMargPrc = flashm.getLyMargPrc();
    		   
    		   String [] sVarRet = flashm.getVarRet();
    		   String [] sVarCost = flashm.getVarCost();
    		   String [] sVarQty = flashm.getVarQty();
    		   String [] sVarMarg = flashm.getVarMarg();
    		   String [] sVarMargPrc = flashm.getVarMargPrc();  
    		   
    		   String [] sTyAvg = flashm.getTyAvg();
    		   String [] sLyAvg = flashm.getLyAvg();
    		   String [] sVarAvg = flashm.getVarAvg();
           %>
              <tr id="trId<%=iLine%>" class="trDtl02">
                <td class="td11" nowrap><%=sGrpNm%></td>
                <%for(int j=0; j < 13; j++){%>
                   <td class="td10">&nbsp;</td>
                   <%if(j != 8 && j != 10){%>
                   <td class="td04" nowrap>
                      <span id="spnRet"><%=sTyRet[j]%></span>
                      <span id="spnCost"><%=sTyCost[j]%></span>
                      <span id="spnQty"><%=sTyQty[j]%></span>
                      <span id="spnMarg"><%=sTyMarg[j]%></span>
                      <span id="spnMargPrc"><%=sTyMargPrc[j]%></span>
                      <span id="spnAvg"><%=sTyAvg[j]%></span>
                   </td>
                   <%}%>
                   <td class="td04" nowrap>
                      <span id="spnRet"><%=sLyRet[j]%></span>
                      <span id="spnCost"><%=sLyCost[j]%></span>
                      <span id="spnQty"><%=sLyQty[j]%></span>
                      <span id="spnMarg"><%=sLyMarg[j]%></span>
                      <span id="spnMargPrc"><%=sLyMargPrc[j]%></span>
                      <span id="spnAvg"><%=sLyAvg[j]%></span>
                   </td>
                   <%if(j != 8 && j != 10){%>
                   <td class="td12" nowrap>
                      <span id="spnRet"><%=sVarRet[j]%></span>
                      <span id="spnCost"><%=sVarCost[j]%></span>
                      <span id="spnQty"><%=sVarQty[j]%></span>
                      <span id="spnMarg"><%=sVarMarg[j]%></span>
                      <span id="spnMargPrc"><%=sVarMargPrc[j]%></span>
                      <span id="spnAvg"><%=sVarAvg[j]%></span>
                   </td>                     
                   <%}%>                                    
                <%}%>
                     
                <td class="td05" nowrap><%=sGrpNm%></td>   
              </tr>                                  
              <%iLine++;%>                
           <%}%>
           
           <!-- ================ Total line ================================= -->           
           <tr><td class="Separator03" colspan="50">&nbsp;</td></tr>
           
           <%
           flashm.setTotal();
           String sGrp = flashm.getGrp();
		   String sGrpNm = flashm.getGrpNm();
		   String [] sTyRet = flashm.getTyRet();
		   String [] sTyCost = flashm.getTyCost();
		   String [] sTyQty = flashm.getTyQty();
		   String [] sLyRet = flashm.getLyRet();
		   String [] sLyCost = flashm.getLyCost();
		   String [] sLyQty = flashm.getLyQty();
		   
		   String [] sTyMarg = flashm.getTyMarg();
		   String [] sTyMargPrc = flashm.getTyMargPrc();
		   String [] sLyMarg = flashm.getLyMarg();
		   String [] sLyMargPrc = flashm.getLyMargPrc();
		   
		   String [] sVarRet = flashm.getVarRet();
		   String [] sVarCost = flashm.getVarCost();
		   String [] sVarQty = flashm.getVarQty();
		   String [] sVarMarg = flashm.getVarMarg();
		   String [] sVarMargPrc = flashm.getVarMargPrc();
		   
		   String [] sTyAvg = flashm.getTyAvg();
		   String [] sLyAvg = flashm.getLyAvg();
		   String [] sVarAvg = flashm.getVarAvg();
           %>             
           <tr id="trId<%=iLine%>" class="trDtl03">
                <td class="td11" nowrap><%=sGrpNm%></td>
                <%for(int j=0; j < 13; j++){%>
                   <td class="td10">&nbsp;</td>
                   <%if(j != 8 && j != 10){%>
                   <td class="td04" nowrap>
                      <span id="spnRet"><%=sTyRet[j]%></span>
                      <span id="spnCost"><%=sTyCost[j]%></span>
                      <span id="spnQty"><%=sTyQty[j]%></span>
                      <span id="spnMarg"><%=sTyMarg[j]%></span>
                      <span id="spnMargPrc"><%=sTyMargPrc[j]%></span>
                      <span id="spnAvg"><%=sTyAvg[j]%></span>
                   </td>
                   <%}%>
                   <td class="td04" nowrap>
                      <span id="spnRet"><%=sLyRet[j]%></span>
                      <span id="spnCost"><%=sLyCost[j]%></span>
                      <span id="spnQty"><%=sLyQty[j]%></span>
                      <span id="spnMarg"><%=sLyMarg[j]%></span>
                      <span id="spnMargPrc"><%=sLyMargPrc[j]%></span>
                      <span id="spnAvg"><%=sLyAvg[j]%></span>
                   </td>
                   <%if(j != 8 && j != 10){%>
                   <td class="td12" nowrap>
                      <span id="spnRet"><%=sVarRet[j]%></span>
                      <span id="spnCost"><%=sVarCost[j]%></span>
                      <span id="spnQty"><%=sVarQty[j]%></span>
                      <span id="spnMarg"><%=sVarMarg[j]%></span>
                      <span id="spnMargPrc"><%=sVarMargPrc[j]%></span>
                      <span id="spnAvg"><%=sVarAvg[j]%></span>
                   </td>                     
                   <%}%>                                    
                <%}%>
                
                <td class="td05" nowrap><%=sGrpNm%></td>      
              </tr>                                  
              <%iLine++;%>   
      </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
flashm.disconnect();
flashm = null;
}
%>