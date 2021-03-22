<%@ page import="salesvelocity.HCDlyLst, rciutility.StoreSelect, rciutility.RunSQLStmt, rciutility.RtvStrGrp, java.sql.*, java.util.*, java.text.*"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");    
   String sStrOpt = request.getParameter("StrOpt");
   String sDatOpt = request.getParameter("DatOpt");
   String sMissOpt = request.getParameter("MissOpt");
   String sDatBrk = request.getParameter("DatBrk");   
   String sSort = request.getParameter("Sort");
   String [] sSelCol = request.getParameterValues("col");
   String [] sSelGrp = request.getParameterValues("grp");
   String [] sGoal = request.getParameterValues("Goal");
   String sPrint = request.getParameter("print");

   SimpleDateFormat smp = new SimpleDateFormat("MM/dd/yyyy");
   
   if(sFrom == null)
   {
      java.util.Date dtPrior  = new java.util.Date(new java.util.Date().getTime() - 24 * 60 * 60 * 1000);
      sFrom = smp.format(dtPrior);
   }
   if(sTo == null)
   {
	   java.util.Date dtPrior  = new java.util.Date(new java.util.Date().getTime() - 24 * 60 * 60 * 1000);
      sTo = smp.format(dtPrior);
   }
   if(sStrOpt == null){ sStrOpt = "STR"; }
   if(sDatOpt == null){ sDatOpt = "NONE"; }
   if(sDatBrk == null){ sDatBrk = "None"; }
   if(sMissOpt == null){ sMissOpt = "Y"; }
   if(sSort == null){ sSort = "STR"; }
   if(sGoal == null){ sGoal= new String[3]; sGoal[0] = "10"; sGoal[1] = "10"; sGoal[2] = "10";}
   if(sSelCol == null)
   { 
	   sSelCol = new String[8];
	   for(int i=0; i < 8; i++){ sSelCol[i] = Integer.toString(i); }		   
   }
   if(sSelGrp == null)
   { 
	   sSelGrp = new String[3];
	   for(int i=0; i < 3; i++){ sSelGrp[i] = Integer.toString(i); }		   
   }
      
   boolean bGoalHdr = false;
   for(int i=0; i < sSelGrp.length; i++){ if(sSelGrp[i] == "3"){bGoalHdr = true;}  }
   
   if(sPrint == null || sPrint.equals("")){sPrint = "N"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=HCDlyLst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   String sQuery = ""; 
   if(request.getQueryString() != null){ sQuery = request.getQueryString(); }
   
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
         if(!sStrLst[i].equals("55") && !sStrLst[i].equals("89")
            && !sStrLst[i].equals("70")	 && !sStrLst[i].equals("75")		 )
         {
           vStr.add(sStrLst[i]);
         }
      }

      sSelStr = (String [])vStr.toArray(new String[vStr.size()]);;
   }

   String sUser = session.getAttribute("USER").toString();
   boolean bUpdStrGrp = session.getAttribute("ITMAINT") != null;
   
 

   //System.out.println(sFrom + "|" + sTo + "|" + sStrOpt + "|" + sDatOpt + "|" + sSort + "|" + sUser);
   HCDlyLst hcdly = new HCDlyLst(sSelStr, sFrom, sTo, sMissOpt, sDatBrk, sGoal, sSort, sUser);
   int iNumOfDtl = hcdly.getNumOfStr();
   int iNumOfReg = hcdly.getNumOfReg();
   int iNumOfGrp = hcdly.getNumOfGrp();
   int iNumOfPer = hcdly.getNumOfPer();
   String [] sPer = hcdly.getPer();
   String sPerJva = hcdly.cvtToJavaScriptArray(sPer);
   String sSelColJsa = hcdly.cvtToJavaScriptArray(sSelCol);
   String sSelGrpJsa = hcdly.cvtToJavaScriptArray(sSelGrp);
   String sGoalJsa = hcdly.cvtToJavaScriptArray(sGoal);
   
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
   
%>
<html>
<head>
<title>Conversion</title>

<style>body {background:ivory; margin:0 auto; }
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: #b4bbc6 solid 2px; background:#FFE4C4;  margin:0 auto;}

        th.DataTable  { border-bottom: #b4bbc6 solid 1px; border-right: #b4bbc6 solid 1px; background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1  { border-bottom: #b4bbc6 solid 1px; border-right: #b4bbc6 solid 1px;  background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:14px }
        th.DataTable2  { background: black; border: black solid 1px; padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable3  { border-bottom: #b4bbc6 solid 1px; border-right: #b4bbc6 solid 1px;  background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:16px }


        tr.DataTable  { background:white; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#E1F5A9; font-family:Arial; font-size:10px }        
        tr.DataTable2  { background:gray; color:white; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:#F6CEF5; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:#F3E2A9; font-family:Arial; font-size:10px }
        tr.DataTable5 { background:#EFFBEF; font-family:Arial; font-size:10px }
        tr.DataTable6 { background:#D8CEF6; font-family:Arial; font-size:10px }
        

        td.DataTable { border-bottom: #b4bbc6 solid 1px; border-right: #b4bbc6 solid 1px;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:right;}
        td.DataTable1 { border-bottom: #b4bbc6 solid 1px; border-right: #b4bbc6 solid 1px;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:left;}
        td.DataTable2 { border-bottom: #b4bbc6 solid 1px; border-right: #b4bbc6 solid 1px;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:left;}

        td.DataTable3 { border-bottom: #b4bbc6 solid 1px; border-right: #b4bbc6 solid 1px;background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:10px }
        td.DataTable4 { border-bottom: #b4bbc6 solid 1px; border-right: #b4bbc6 solid 1px;background:red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
                       
        td.DataTable5 { background: lightgrey; border-bottom: #b4bbc6 solid 1px; border-right: #b4bbc6 solid 1px;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:right;}
		td.DataTable6 { background: #afa37b; border-bottom: #b4bbc6 solid 1px; border-right: #b4bbc6 solid 1px;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:right;}                      
        td.DataTable7 { background: #aba2c1; border-bottom: #b4bbc6 solid 1px; border-right: #b4bbc6 solid 1px;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:right;}
        td.DataTable8 { background: #adbc82; border-bottom: #b4bbc6 solid 1px; border-right: #b4bbc6 solid 1px;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:right;}               
                       
                       
        .Small {font-size:10px }
        .Small1 {font-size:10px; text-align:center;}
        .Medium {font-size:12px }
        .Medium1 {font-size:12px; font-weight:bold; }
        select.Small {margin-top:3px; font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }

        div.dvGraph { position:absolute; visibility:hidden; background-attachment: scroll;
              border:  black solid 1px; width: auto; background-color:LemonChiffon; z-index:20;
              text-align:center; vertical-align:top; font-size:10px}      

       div.dvSelect { position:absolute; background-attachment: scroll;
              border: black solid 2px; width: 300px; background-color:LemonChiffon; z-index:1;
              text-align:center; font-size:12px}

        td.BoxName {cursor:move;background: #016aab; color:white; text-align:center; 
                    font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background: #016aab; vertical-align:bottom;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Prompt { text-align:left; vertical-align: bottom; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align: bottom; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align: bottom; font-family:Arial; font-size:10px; }
        td.Prompt4 { text-align:left; vertical-align: bottom; font-family:Arial; font-size:10px; }
        
        td.Separator01 { border-top: #EFFBEF ridge 2px; font-size:1px; }
        td.Separator02 { background: salmon ridge px; font-size:1px; }
</style>
<SCRIPT>

//--------------- Global variables -----------------------
var From = "<%=sFrom%>";
var To = "<%=sTo%>";
var MissOpt = "<%=sMissOpt%>";
var DatBrk = "<%=sDatBrk%>";
var Goal = "<%=sGoal%>";
var ArrStr = [<%=sStrJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];
var ArrGrpNm = [<%=sGrpNmJsa%>];
var ArrGrpBtn = [<%=sGrpBtnJsa%>];
var ArrGrpStr = [<%=sGrpStrJsa%>];

var ArrSelStr = new Array();
<%for(int i=0; i < sSelStr.length; i++){%>
   ArrSelStr[<%=i%>] = "<%=sSelStr[i]%>";
<%}%>

var ArrSelCol = [<%=sSelColJsa%>];
var ArrSelGrp = [<%=sSelGrpJsa%>];
var ArrSelGoal = [<%=sGoalJsa%>];

var NumOfPer = "<%=iNumOfPer%>";
var NumOfDtl = "<%=iNumOfDtl%>";
var NumOfReg = "<%=iNumOfReg%>";
var NumOfGrp = "<%=iNumOfGrp%>";
var ArrPer = [<%=sPerJva%>]; 

var DispPer = true; 

var CurYear = "<%=sYear%>";
var CurMonth = eval("<%=sMonth%>") - 1;
var DateFmt = "C";

var mon = ["April", "May", "June", "July", "August", "September", "October", "November", "December", "January", "February", "March"];
var AllLines = 0;
var Print = "<%=sPrint%>";


var isOpera = (!!window.opr && !!opr.addons) || !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0;
//Firefox 1.0+
var isFirefox = typeof InstallTrigger !== 'undefined';
//Safari 3.0+ "[object HTMLElementConstructor]" 
var isSafari = /constructor/i.test(window.HTMLElement) || (function (p) { return p.toString() === "[object SafariRemoteNotification]"; })(!window['safari'] || safari.pushNotification);
//Internet Explorer 6-11
var isIE = /*@cc_on!@*/false || !!document.documentMode;
//Edge 20+
var isEdge = !isIE && !!window.StyleMedia;
//Chrome 1+
var isChrome = !!window.chrome && !!window.chrome.webstore;
//Blink engine detection
var isBlink = (isChrome || isOpera) && !!window.CSS;
//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   if(isIE){ document.body.style.textAlign = "center";  }
   
   setBoxclasses(["BoxName",  "BoxClose"], ["dvGraph"]);
   setSelectPanelShort(); 
   setSelectedColumns(); 
   if(From.indexOf("F") == 0 ){ setDateHdr(); }
}
//==============================================================================
//set dates on the page for fiscal yr/mo selection
//==============================================================================
function setDateHdr()
{	 
	var frmon = From.substring(6).trim() - 1;
	var tomon = To.substring(6).trim() - 1;
	document.all.spnFrHdr.innerHTML = From.substring(1,5) + "/" + mon[frmon];
	document.all.spnToHdr.innerHTML = To.substring(1,5) + "/" + mon[tomon];
}
//==============================================================================
// set Short form of select parameters
//==============================================================================
function setSelectPanelShort()
{
   var hdr = "Select Report Parameters";

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
   document.all.dvSelect.style.pixelTop= document.documentElement.scrollTop + 20;
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
   
   
   if(isIE){ document.all.dvSelect.style.width=600; }
   else if(isChrome || isEdge) { document.all.dvSelect.style.width="auto"; }
   
   
   // set fiscal year/mo selection   
   setFiscSel();
   setInitDateSel();
   
   // setup date range
   var grp = document.all.DtGrp;
   for(var i=0; i < grp.length; i++)
   {
      if(From == grp[i].value){ grp[i].checked = true; break; }
   }
   setDtRange();

   var str = document.all.Str;
   for(var i=0; i < str.length; i++)
   {
      for(var j=0; j < ArrStr.length; j++)
      {
         if(str[i].value == ArrSelStr[j]){ str[i].checked = true;}
         else{ str[i].checked == false; }
      }
   }
   
   if(MissOpt == "Y"){ document.all.MissOpt[0].checked = true }
   else{ document.all.MissOpt[1].checked = true };
   
   var dtbrk = document.all.DtBrk;
   for(var i=0; i < dtbrk.length; i++)
   {
      if(dtbrk[i].value == DatBrk){ dtbrk[i].checked = true;}
      else{ dtbrk[i].checked == false; }      
   }
   
   // checked selected columns
   var col = document.all.SelCol;
   for(var i=0; i < col.length; i++)
   {
      for(var j=0; j < ArrSelCol.length; j++)
      {
         if(col[i].value == ArrSelCol[j]){ col[i].checked = true;}
         else{ col[i].checked == false; }
      }
   }
   
   // checked selected columns
   col = document.all.SelGrp;
   for(var i=0; i < col.length; i++)
   {
      for(var j=0; j < ArrSelGrp.length; j++)
      {
         if(col[i].value == ArrSelGrp[j]){ col[i].checked = true;}
         else{ col[i].checked == false; }
      }
   }
   
   document.all.Goal[0].value = ArrSelGoal[0];
   document.all.Goal[1].value = ArrSelGoal[1];
   document.all.Goal[2].value = ArrSelGoal[2];
}
//==============================================================================
// populate Column Panel
//==============================================================================
function popSelWk()
{
  var panel = "<table border=0 cellPadding=0 cellSpacing=0>"
    + "<tr>"
       + "<td class='Prompt1' colspan=3><u>Stores</u></td>"
     + "</tr>"
     + "<tr>"
       + "<td class='Prompt1' colspan=3>"
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
          + "<button onclick='checkAll(false)' class='Small'>Reset</button> &nbsp; &nbsp;"
          + "<button onclick='checkStrGrp(&#34;1&#34;)' class='Small'>Bikes-Jay</button> &nbsp; &nbsp;"
          + "<button onclick='checkStrGrp(&#34;2&#34;)' class='Small'>Bikes-Jeremy</button> &nbsp; &nbsp;";
  var space = " &nbsp; &nbsp;";
  
  // add store group buttons
  /*for(var i=0; i < ArrGrpNm.length; i++)
  {
	  if(ArrGrpBtn[i]=="Mall (7)") { panel += "<br>"; } 
	  else if(ArrGrpBtn[i]=="All Brick & Mortar") { panel += "<br>"; } 
	  panel += space + "<button onclick='checkStrGrp(&#34;" + ArrGrpNm[i] + "&#34;,&#34;" + ArrGrpBtn[i] + "&#34;, this)' class='Small'>" + ArrGrpBtn[i] + "</button>"
	   
  }*/
  
  panel += "<br>Note: Clicking the Store Group button more than once, toggles to INCLUDE or EXCLUDE the stores in this group." 
          
  panel += "</td>"
     + "</tr>"
     
     + "<tr><td class='Separator01' colspan=3>&nbsp</td></tr>"
     
     + "<tr id='trDt1'  style='background:azure'>"
     + "<td class='Prompt' colspan=3>"
        + " Display Details: "
        + "<input type='radio' name='DtBrk' value='Date'>By Date &nbsp; &nbsp;"
        + "<input type='radio' name='DtBrk' value='Week'>By Week &nbsp; &nbsp;"
        + "<input type='radio' name='DtBrk' value='Month'>By Month &nbsp; &nbsp;"
        + "<input type='radio' name='DtBrk' value='None' checked>Totals Only &nbsp; &nbsp;"
     + "</td>"
   + "</tr>"
     
     + "<tr id='trDt1'  style='background:azure'>"
        + "<td class='Prompt' colspan=3><u>Date Selection:</u>&nbsp"
           + "<input type='radio' name='DtGrp' value='WTD' onclick='setDtRange()'>W-T-D &nbsp; &nbsp;"
           + "<input type='radio' name='DtGrp' value='MTD' onclick='setDtRange()'>M-T-D &nbsp; &nbsp;"
           + "<input type='radio' name='DtGrp' value='QTD' onclick='setDtRange()'>Q-T-D &nbsp; &nbsp;"
           + "<input type='radio' name='DtGrp' value='YTD' onclick='setDtRange()'>Y-T-D &nbsp; &nbsp;"
           + "<input type='radio' name='DtGrp' value='PMN' onclick='setDtRange()'>Prior Month &nbsp; &nbsp;"
           + "<input type='radio' name='DtGrp' value='RANGE' onclick='setDtRange()' checked>Date Range<br>&nbsp;"
        + "</td>"
      + "</tr>"

    + "<tr id='trDt2' style='background:azure'>"
       + "<td class='Prompt' id='td2Dates' width='10%'>From:</td>"
       + "<td class='Prompt4' id='td2Dates'  nowrap>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;From&#34;)'>&#60;</button>"
          + "<input name='From' class='Small' size='10' >"
          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;From&#34;)'>&#62;</button>"
          + " &nbsp; <a href='javascript:showCalendar(1, null, null, 650, 170, document.all.From)'>"
          + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
       + "<td class='Prompt4' rowspan=2><button class='Small' onclick='switchFYCD(true)'>Fiscal Yr/Mo</button></td>"
    + "</tr>"
    + "<tr id='trDt2' style='background:azure'>"
       + "<td class='Prompt' id='td2Dates' width='10%'>To:</td>"
       + "<td class='Prompt4' id='td2Dates'  nowrap>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;To&#34;)'>&#60;</button>"
          + "<input name='To' class='Small' size='10' >"
          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;To&#34;)'>&#62;</button>"       
          + " &nbsp; <a href='javascript:showCalendar(1, null, null, 650, 250, document.all.To)'>"
              + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
     + "</tr>"
     
     + "<tr id='trDt3' style='background:azure'>"
     + "<td class='Prompt' id='td2Dates' width='10%'>From:</td>"
     + "<td class='Prompt4' id='td2Dates'  nowrap>"
        + "<select name='FromYr' class='Small'></select> &nbsp; "
        + "<select name='FromMo' class='Small'><select>"
     + "</td>"
     + "<td class='Prompt4' rowspan=2><button class='Small' onclick='switchFYCD(false)'>Dates</button></td>"
  + "</tr>"
  + "<tr id='trDt3' style='background:azure'>"
     + "<td class='Prompt' id='td2Dates' width='10%'>To:</td>"
     + "<td class='Prompt4' id='td2Dates'  nowrap>"
        + "<select name='ToYr' class='Small'></select> &nbsp; "
        + "<select name='ToMo' class='Small'><select>"
     + "</td>"
   + "</tr>"
     
     

   + "<tr><td class='Separator01' colspan=3>&nbsp</td></tr>"
   
     + "<tr style='background:#ccffcc'>"
       + "<td class='Prompt1' colspan=3><u>Report Options:</u></td>"
     + "</tr>"
     + "<tr style='background:#ccffcc'>"
       + "<td class='Prompt1' colspan=3>"
          + "<table border=0>"
              + "<tr>"
                  + "<td class='Small' nowrap><input type='radio' class='Small' name='MissOpt' value='Y'>Exclude Incomplete Date</td>"
                  + "<td class='Small' nowrap><input type='radio' class='Small' name='MissOpt' value='N' checked>Show All Data</td>"
              + "</tr>"
          + "</table>"
       + "</td>"
     + "</tr>"   
     + "<tr style='background:#ccffcc'>"
       + "<td class='Prompt' colspan=3>"      
          + "<table border=0>"
          
          + "<tr><td class='Small1' nowrap colspan='2'>Selected Groups:"
          			+ "<button onclick='chkColAll(true)' class='Small'>All</button> &nbsp; &nbsp;"
          			+ "<button onclick='chkColAll(false)' class='Small'>Reset</button>"            
        		+ "</td>"
             + "<td class='Small1' nowrap><input type='checkbox' class='Small' name='SelCol' value='0'>Trafic</td>"
             + "<td class='Small1' nowrap><input type='checkbox' class='Small' name='SelCol' value='1'>Conversion Rate</td>"
             + "<td class='Small1' nowrap><input type='checkbox' class='Small' name='SelCol' value='2'>Transactions</td>"
             + "<td class='Small1' nowrap><input type='checkbox' class='Small' name='SelCol' value='3'>Avg Sales Price</td>"
          + "</tr>"
          + "<tr><td class='Small1' nowrap colspan='2'>&nbsp;</td>" 
             + "<td class='Small1' nowrap><input type='checkbox' class='Small' name='SelCol' value='4'>Tot Sales</td>"
             + "<td class='Small1' nowrap><input type='checkbox' class='Small' name='SelCol' value='5'>Returns</td>"
             + "<td class='Small1' nowrap><input type='checkbox' class='Small' name='SelCol' value='6'>Net Sales</td>"
             + "<td class='Small1' nowrap><input type='checkbox' class='Small' name='SelCol' value='7'>Perf. vs Opp.</td>"                 
          + "</tr>"
          
          + "<tr><td class='Small1' nowrap colspan='2'>Select Column Details:&nbsp;"
          		+ "<button onclick='chkGrpAll(true)' class='Small'>All</button> &nbsp; &nbsp;"
          		+ "<button onclick='chkGrpAll(false)' class='Small'>Reset</button>"            
          		+ "</td>"
        	  + "<td class='Small1' nowrap colspan='2'>" 
          		+ "<input type='checkbox' class='Small' name='SelGrp' value='0'>TY &nbsp; "
          		+ "<input type='checkbox' class='Small' name='SelGrp' value='1'>LY &nbsp; "
          		+ "<input type='checkbox' class='Small' name='SelGrp' value='2'>Var &nbsp; "
          		+ "<input type='checkbox' class='Small' name='SelGrp' value='3'>Goal &nbsp; " 
        	  + "</td>"
        	+ "</tr>"
        + "</table>"          

      + "</tr>"
      + "<tr><td class='Separator01' colspan=3>&nbsp</td></tr>"
    
      + "<tr style='background:#F3E2A9'>"
        + "<td class='Prompt1' colspan=3>"
        + "<table border=0 width='100%'>"
          	  + "<tr><td class='Small1' nowrap>Goal as % of LY: &nbsp;"
          	      + "&nbsp; Traffic <input class='Small' name='Goal' size=5 maxlength=5>% &nbsp; &nbsp;"
          	      + "&nbsp; Conv. Rate <input class='Small' name='Goal' size=5 maxlength=5>% &nbsp; &nbsp;"
          	      + "&nbsp; ASP <input class='Small' name='Goal' size=5 maxlength=5>% &nbsp; &nbsp;"
              	+ "</td>"
	          + "</tr>"
          + "</table>"
          
          + "<table border=0 width='100%'>"
             + "<tr><td style='color:red; font-weight:bold; font-size:12px;' id='tdError' nowrap></td></tr>"          
          + "</table>"
          
       + "</td>"
     + "</tr>"
     + "<tr><td class='Separator01' colspan=3>&nbsp</td></tr>";   
     
  panel += "<tr><td class='Prompt1' colspan=3>"
        + "<button onClick='Validate()' class='Small'>Submit</button> &nbsp;"
        + "<button onClick='setSelectPanelShort();' class='Small'>Close</button>&nbsp;</td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// check all columns
//==============================================================================
function chkColAll(chk)
{
  var col = document.all.SelCol;
  for(var i=0; i < col.length; i++){ col[i].checked = chk; }
}
//==============================================================================
//check all columns group
//==============================================================================
function chkGrpAll(chk)
{
var col = document.all.SelGrp;
for(var i=0; i < col.length; i++){ col[i].checked = chk; }
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
function checkStrGrp(grp) //, btn, obj)
{
  /*var str = document.all.Str
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
  */
  
  	var str = document.all.Str
	 
	//check 1st selected group check status and save it
	var find = false;
	var arrGrp1 = ["3","4","6","8","15","16","17","25","77","82","87","88"];
	var arrGrp2 = [ "10","11","22","28","29","35","40","42","50","66","90","91","93","96","98" ];
	for(var i=0; i < str.length; i++)
	{
		find = false;
		str[i].checked = false;
		if(grp == "1")
		{
			for(var j=0; j < arrGrp1.length; j++)
			{			
				if(str[i].value == arrGrp1[j])
 				{
   				str[i].checked = true;
   				find = true;
   				break;
 				};   			
			}
		}
		
		if(grp == "2")
		{
			for(var j=0; j < arrGrp2.length; j++)
			{			
				if(str[i].value == arrGrp2[j])
 				{
   				str[i].checked = true;
   				find = true;
   				break;
 				};   			
			}
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
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
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
	// populate from week with to week if litteral range selected
	if(From == "WTD" || From == "MTD" || From == "QTD" || From == "YTD" || From == "PMN")
	{
		document.all.From.value = To;
	    document.all.To.value = To;
	    switchFYCD(false);
	}
	else
	{
		if(From.indexOf("F") < 0 ) 
		{ 
			document.all.From.value = From;
		    document.all.To.value = To;
			switchFYCD(false); 
		}
		else
		{
			//set fiscal year		
			switchFYCD(true);		
			for (var i=0; i < 5; i++)
			{
			    if (document.all.FromYr.options[i].value == From.substring(1,5)){ document.all.FromYr.selectedIndex = i; break;};
			}   
			var frmon = From.substring(6).trim() - 1;
			document.all.FromMo.selectedIndex = frmon; 
			
			
			for (var i=0; i < 5; i++)
			{
		    	if (document.all.ToYr.options[i].value == To.substring(1,5)){ document.all.ToYr.selectedIndex = i; break;};
			}
			var tomon = To.substring(6).trim() - 1;
			document.all.ToMo.selectedIndex = tomon;
			
			// set date selection to last date
			date = new Date(new Date() - 24*60*60*1000)
			document.all.From.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
		    document.all.To.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
		}
	}	
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

  
   // get date
   var selFrom = " ";
   var selTo = " ";
   if(DateFmt == "C")
   {
	   selFrom = document.all.From.value.trim();
	   selTo = document.all.To.value.trim();
   }
   else
   {
	   selFrom = "F" + document.all.FromYr.options[document.all.FromYr.selectedIndex].value.trim()
	     + "/" + document.all.FromMo.options[document.all.FromMo.selectedIndex].value.trim();
	   selTo = "F" + document.all.ToYr.options[document.all.ToYr.selectedIndex].value.trim()
	     + "/" + document.all.ToMo.options[document.all.ToMo.selectedIndex].value.trim();  
   }

   var grp = document.all.DtGrp;
   var grpnum = 0;
   for(var i=0; i < grp.length; i++)
   {
      if(grp[i].checked && i < grp.length-1)
      {
         grpnum=i;
         selFrom = grp[i].value;
         break;
      }
   }
   
   var dtbreak = document.all.DtBrk;
   var dtbrk = "None";
   for(var i=0; i < dtbreak.length-1; i++)
   {      
      if(dtbreak[i].checked)
      {
    	  dtbrk=dtbreak[i].value;
          break;
      }
   }

   // used incomplete date in total or not
   var missopt = null;
   var missoptobj = document.all.MissOpt;
   for(var i=0; i < missoptobj.length; i++)
   {
      if(missoptobj[i].checked){  missopt = missoptobj[i].value; break; }
   }
   
   
   // get selected columns
   var col = document.all.SelCol;
   var selcol = new Array();
   var numcol = 0
   for(var i=0; i < col.length; i++)
   {
     if(col[i].checked){ selcol[numcol] = col[i].value; numcol++;}
   }
   if (numcol == 0){ error=true; msg+="At least 1 column must be selected."; br = "<br>";}
   
// get selected group columns
   col = document.all.SelGrp;
   var selgrp = new Array();
   var numgrp = 0
   for(var i=0; i < col.length; i++)
   {
     if(col[i].checked){ selgrp[numgrp] = col[i].value; numgrp++;}
   }
   if (numgrp == 0){ error=true; msg+="At least 1 column details (TY,LY,Goal) must be selected."; br = "<br>";}
   
   
   var goal = new Array(3);
   goal[0] = document.all.Goal[0].value.trim();
   if(goal[0]==""){ error=true; msg+="Please type Goal."; br = "<br>"; }
   else if(isNaN(goal[0])){ error=true; msg+="The Goal is not a numeric."; br = "<br>"; }
   else if(eval(goal[0]) > 100 || eval(goal[0]) < -100){ error=true; msg+="The Goal cannot be greater then 100 ort less than -100 percents."; br = "<br>"; }
   
   goal[1] = document.all.Goal[1].value.trim();
   if(goal[1]==""){ error=true; msg+="Please type Goal."; br = "<br>"; }
   else if(isNaN(goal[1])){ error=true; msg+="The Goal is not a numeric."; br = "<br>"; }
   else if(eval(goal[1]) > 100 || eval(goal[1]) < -100){ error=true; msg+="The Goal cannot be greater then 100 ort less than -100 percents."; br = "<br>"; }
   
   goal[2] = document.all.Goal[2].value.trim();
   if(goal[2]==""){ error=true; msg+="Please type Goal."; br = "<br>"; }
   else if(isNaN(goal[2])){ error=true; msg+="The Goal is not a numeric."; br = "<br>"; }
   else if(eval(goal[2]) > 100 || eval(goal[2]) < -100){ error=true; msg+="The Goal cannot be greater then 100 ort less than -100 percents."; br = "<br>"; }

   if(error){alert(msg)}
   else{ submitForm(selstr, selFrom, selTo, missopt, dtbrk, selcol, goal, selgrp); }
}
//==============================================================================
// change action on submit
//==============================================================================
function submitForm(selstr, selFrom, selTo, missopt, dtbrk, selcol, goal, selgrp)
{
   var url;
   url = "HCDlyLst.jsp?From=" + selFrom + "&To=" + selTo;
   for(var i=0; i < selstr.length; i++) { url += "&Str=" + selstr[i]; }
   url += "&MissOpt=" + missopt;
   url += "&DatBrk=" + dtbrk;
   url += "&Sort=<%=sSort%>";      
   for(var i=0; i < selcol.length; i++){ url += "&col=" + selcol[i]; }   
   for(var i=0; i < selgrp.length; i++){ url += "&grp=" + selgrp[i]; }
   for(var i=0; i < goal.length; i++){ url += "&Goal=" + goal[i]; }   

   //alert(url);
   window.location.href=url;
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
//set fiscal year selection 
//==============================================================================
function setFiscSel()
{
	  var year = CurYear - 4;
	  for (var i=0; i < 5; i++)
	  {
	     document.all.FromYr.options[i] = new Option(year, year);
	     document.all.ToYr.options[i] = new Option(year, year);
	     if (year == CurYear )
	     { 
	    	 document.all.FromYr.selectedIndex = i;
	    	 document.all.ToYr.selectedIndex = i;
	     }
	     year++;
	  }

	  for (var i=0; i < mon.length; i++)
	  {
	     document.all.FromMo.options[i] = new Option(mon[i], (i+1));
	     document.all.ToMo.options[i] = new Option(mon[i], (i+1));
	     if (i == CurMonth )
	     { 
	    	 document.all.FromMo.selectedIndex = i;
	    	 document.all.ToMo.selectedIndex = i;
	     }
	  }
	
}
//==============================================================================
// switch between fiscal year and date selection 
//==============================================================================
function switchFYCD(grp)
{
    var trDt = document.all.trDt2;
    var trFy = document.all.trDt3;
    for(var i=0; i < trFy.length; i++)
    {
    	if(grp)
    	{
    	  trDt[i].style.display="none";
    	  trFy[i].style.display="block";
    	  DateFmt = "F";
    	}
    	else
    	{
    	  trDt[i].style.display="block";
      	  trFy[i].style.display="none";
      	  DateFmt = "C";
    	}
    }
    	
}
//==============================================================================
// set selected columns
//==============================================================================
function setSelectedColumns()
{	
	for(var i=0; i < 8; i++)
	{		
		// test selected columns
		var find = false;
		for(var j=0; j < ArrSelCol.length; j++) 
		{ 
			if(ArrSelCol[j]==i){ find = true; break; }
		}	  
		
		// make unvisible unselected columns
		if(!find)
		{
			var colnm = "col" + i + "h0";			
		    document.all[colnm].style.display="none";
		    
		    var colnm = "col" + i + "hs";
		    var col = document.all[colnm];
		    if(i==7){col.style.display="none";}
		    else
		    {
		    	for(var k=0; k < col.length; k++)
		    	{
			    	col[k].style.display="none";
			    }
		    }
		    
		    for(var k=0; k < 4; k++)
		    {
		    	//col0d0 col0d1 col0d2
		       	var colnm = "col" + i + "d" + k;
		    	var col = document.all[colnm];
		    	if(col != null)
		    	{
		    		for(var m=0; m < col.length; m++)
		    		{
		    			col[m].style.display="none";
		    		}
		    	}
		    }
		}
		if(i < 7){setSelGrpCol(i);}
	}
}
//==============================================================================
//set selected column groups
//==============================================================================
function setSelGrpCol(grp)
{ 
	var span = 4;
	for(var i=0; i < 4; i++)
	{		
		// test selected columns
		var find = false;
		for(var j=0; j < ArrSelGrp.length; j++) 
		{ 
			if(ArrSelGrp[j]==i){ find = true; break; }
		}	  
		
		// make unvisible unselected columns
		if(!find)
		{
			var colnm = "col" + grp + "h0";
			span -= 1;
		    document.all[colnm].colSpan=span;
		    //col0d
		    var colnm = "col" + grp + "hs";
		    var col = document.all[colnm];
		    col[i].style.display="none";	
		    
		    var colnm = "col" + grp + "d" + i;
		    var col = document.all[colnm];		    
		    for(var k=0; k < col.length; k++)
		    {
		    	col[k].style.display="none";
		    }
		}		
	}
}

//==============================================================================
// re-sort report
//==============================================================================
function resort(sort)
{
   var url;
   url = "HCDlyLst.jsp?From=<%=sFrom%>&To=<%=sTo%>";
   for(var i=0; i < ArrSelStr.length; i++)
   {
     url += "&Str=" + ArrSelStr[i];
   }

   url += "&MissOpt=<%=sMissOpt%>";
   url += "&Sort=" + sort;
   
   for(var i=0; i < ArrSelCol.length; i++)
   {
	  url += "&col=" + ArrSelCol[i];      
   }

   //alert(url);
   window.location.href=url;
}
//==============================================================================
//fold/unfold period break data
//==============================================================================
function showPeriodHcd()
{	
	DispPer = !DispPer;
	var disp = "block";	
	if(!DispPer){ disp = "none"; }
	
	for(var i=0; i < AllLines; i++)
	{
		var trid = "trId" + i;
		var row = document.all[trid];
		for(var j=1; j < row.length; j++)
		{
			row[j].style.display = disp;			
		}
	}
}

//==============================================================================
// set graphs 
//==============================================================================
function setGraph(type, grp, row)
{
	var hdr = "Select Columns for Graphs.";
	if(type=="STR"){ hdr += ". Store: " + grp}
	else if(type=="DIST"){ hdr += ". District: " + grp}
	else if(type=="GROUP"){ hdr += ". Group: " + grp}
	else if(type=="TOTAL"){ hdr += ". Report Total"}

	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>"
	        + popGraphCol(type, grp, row)
	     + "</td></tr>"
	   + "</table>"

	  document.all.dvGraph.innerHTML = html;
	  document.all.dvGraph.style.pixelLeft=document.documentElement.scrollLeft + 400;
	  document.all.dvGraph.style.pixelTop=document.documentElement.scrollTop + 100;
	  document.all.dvGraph.style.visibility = "visible";
}
//==============================================================================
//set graphs 
//==============================================================================
function popGraphCol(type, grp, row)
{
	var panel = "<table>"
		+ "<tr>"
	      + "<td nowrap class='Medium' rowspan=2>Groups:</td>"
	      + "<td nowrap class='Small'>"
	         + "<input name='Grp' type='radio' value='Traffic' checked>Traffic"
	      + "</td>"   
	      + "<td nowrap class='Small'>"	      
	         + "<input name='Grp' type='radio' value='Conversion Rate'>Conversion Rate"
	      + "</td>"   
		  + "<td nowrap class='Small'>"   
	         + "<input name='Grp' type='radio' value='Transaction'>Transaction"
	      + "</td>"   
		  + "<td nowrap class='Small'>"  
	         + "<input name='Grp' type='radio' value='Avg Sales Price'>Avg Sales Price"
	      + "</td>"
	    + "</tr>"
	    
	    + "<tr>"
	      + "<td nowrap class='Small'>"
	         + "<input name='Grp' type='radio' onclick='chkColGrp(true)' value='Total Sales'>Tot Sales"
	      + "</td>"   
	      + "<td nowrap class='Small'>"	      
	         + "<input name='Grp' type='radio' onclick='chkColGrp(true)' value='Returns'>Returns"
	      + "</td>"   
		  + "<td nowrap class='Small'>"   
	         + "<input name='Grp' type='radio' onclick='chkColGrp(true)' value='Net Sales'>Net Sales"
	      + "</td>"   
		  + "<td nowrap class='Small'>"  
	         + "<input name='Grp' type='radio' onclick='chkColGrp(false)' value='Perf. vs Opp.' >Perf. vs Opp."
	      + "</td>"
	    + "</tr>"
	    
	    + "<tr><td id='tdError' nowrap class='Small' colspan=5></td></tr>"   
	    
	    + "<tr>"
	      + "<td nowrap class='Medium'>Column Details:</td>"
	      + "<td nowrap class='Small' colspan=4>"
	         + "<input name='ColDtl' type='checkbox' onclick='chkColDtl(true)' value='TY' checked>TY&nbsp;"
	         + "<input name='ColDtl' type='checkbox' onclick='chkColDtl(true)' value='LY' checked>LY&nbsp;"
	         + "<input name='ColDtl' type='checkbox' onclick='chkColDtl(false)' value='Var'>Var&nbsp;"
	         + "<input name='ColDtl' type='checkbox' onclick='chkColDtl(true)' value='Goal' checked>Goal&nbsp;"
	      + "</td>"
	    + "</tr>"
	    
	    + "<tr>"
        + "<td nowrap class='Small1' colspan=5><button onClick='vldGraphValue("
           + "&#34;" + type + "&#34;,&#34;" + grp + "&#34;,&#34;" + row + "&#34;"           
           + ")' class='Small'>Submit</button> &nbsp; "
      + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
   + "</td></tr></table>"
  return panel;    
}
//==============================================================================
//set graphs 
//==============================================================================
function vldGraphValue(type, grp, row)
{
	var error = false;
	var msg = "";
	var errfld = document.all.tdError;
	
	var colGrpId = "";
	var colGrpNm = "";
	for(var i=0; i < document.all.Grp.length ;i++)
	{
		if(document.all.Grp[i].checked)
		{ 
			colGrpId = i;
			colGrpNm = document.all.Grp[i].value;
			break;
		}
	}
	
	var colid = new Array();
	var colnm = new Array();	
	if (colGrpId != 7)
	{
		for(var i=0; i < document.all.ColDtl.length ;i++)
		{
			if(document.all.ColDtl[i].checked)
			{ 
				colid[colid.length] = i;
				colnm[colnm.length] = document.all.ColDtl[i].value;
			}
		}
	}
	else 
	{	
		colid[colid.length] = 2;
		colnm[colnm.length] = document.all.ColDtl[2].value;	
	}
	
	if(colid.length == 0){ error = true; msg += "Please select column details."; }
	
	if(error){ errfld.value = msg;}
	else{ getGraphValue(type, grp, row, colGrpId, colGrpNm, colid, colnm); }
	
}
//==============================================================================
// get graphs page 
//==============================================================================
function getGraphValue(type, str, row, colGrpId, colGrpNm, colid, colnm)
{	
	var ArrColGrp = [[2,3,4,5], [6,7,8,9], [10,11,12,13], [14,15,16,17], [18,19,20,21]
	               , [22,23,24,25], [26,27,28,29],[30]];

	 
	var valTy = Array();
	var valLy = Array();
	var valVar = Array();
	var valGoal = Array();
	
		
	for(var i=0; i < NumOfPer; i++)
	{		 
		var id = eval(row);
		var trid = "trId" + id;
		var rowobj = document.all[trid];
		var cellobj = rowobj[i+1].getElementsByTagName("td");
	    		
		for(var j=0; j < colid.length; j++)
	    {			
			
			if(colid[j]==0)
			{
				var cellid = ArrColGrp[colGrpId][0];
		        valTy[valTy.length] = rmvComaPercent(cellobj[cellid].innerHTML);		        
			}
			if(colid[j]==1)
			{
				var cellid = ArrColGrp[colGrpId][1];
		        valLy[valLy.length] = rmvComaPercent(cellobj[cellid].innerHTML);
			}
			if(colid[j]==2)
			{
				var cellid = 0;
				if(colGrpId != "7"){cellid = ArrColGrp[colGrpId][2];}
				else{cellid = ArrColGrp[colGrpId][0];}
		        valVar[valVar.length] = rmvComaPercent(cellobj[cellid].innerHTML);
			}
			if(colid[j]==3)
			{
				var cellid = ArrColGrp[colGrpId][3];
		        valGoal[valGoal.length] = rmvComaPercent(cellobj[cellid].innerHTML);
			}
	    }   
	}
	
    var nwelem = document.all.dvSbm;
    
    var html = "<form name='frmGraph'"
       + " METHOD='Post'  target='_blank' ACTION='LineGraph001.jsp'>"
       + "<input name='Type'>"
       + "<input name='Str'>"
       + "<input name='GrpNm'>"
       
    for(var i=0; i < colnm.length; i++){ html += "<input name='ColNm'>"; }
    for(var i=0; i < ArrPer.length; i++){ html += "<input name='Per'>"; }
    for(var i=0; i < valTy.length; i++){ html += "<input name='TY'>"; }
    for(var i=0; i < valLy.length; i++){ html += "<input name='LY'>"; }
    for(var i=0; i < valVar.length; i++){ html += "<input name='Var'>"; }
    for(var i=0; i < valGoal.length; i++){ html += "<input name='Goal'>"; }
    
    html += "</form>"

    nwelem.innerHTML = html;
    document.appendChild(nwelem);
    
    // populate form
    document.all.Type.value = type;
    document.all.Str.value = str;
    document.all.GrpNm.value = colGrpNm;   
   	    
    if(colnm.length == 1){ document.all.ColNm.value = colnm[0];}
    else { for(var i=0; i < colnm.length; i++)	{ document.all.ColNm[i].value = colnm[i]; }  }
	
    for(var i=0; i < ArrPer.length; i++){ document.all.Per[i].value = ArrPer[i] }
	for(var i=0; i < valTy.length; i++){ document.all.TY[i].value = valTy[i] }
	for(var i=0; i < valLy.length; i++)	{ document.all.LY[i].value = valLy[i] }
	for(var i=0; i < valVar.length; i++){ document.all.Var[i].value = valVar[i]}
	for(var i=0; i < valGoal.length; i++) { document.all.Goal[i].value = valGoal[i] }
    
    window.document.frmGraph.submit();
}
//==============================================================================
//remove comas and % $
//==============================================================================
function rmvComaPercent(number)
{
	while(number.indexOf(",") >= 0)
	{
		number = number.replace(",", "");
	}
	
	if(number.indexOf("$") >= 0)
	{
		number = number.replace("$", ""); 
	}
	
	if(number.indexOf("%") >= 0)
	{
		number = number.replace("%", ""); 
	}
		
	return number;
}
//==============================================================================
//check column Details (TY/LY/Var/Goal)
//==============================================================================
function chkColDtl(comb)
{
	var col = document.all.ColDtl;
	if(!comb)
	{
		col[0].checked = false; col[1].checked = false; col[3].checked = false;		
	}
	else
	{
		col[2].checked = false;
	}
}

//==============================================================================
//check column group
//==============================================================================
function chkColGrp(comb)
{
	var col = document.all.ColDtl;
	if(!comb)
	{
		col[0].checked = false; col[1].checked = false; col[2].checked = true; col[3].checked = false;		
	}
	else
	{
		col[0].disable = false; col[1].disable = false; col[2].disable = false; col[3].disable = false;
	}
}

//==============================================================================
//check column group
//==============================================================================
function setPrint()
{
	var url;
	url = "HCDlyLst.jsp?From=<%=sFrom%>&To=<%=sTo%>";
	for(var i=0; i < ArrSelStr.length; i++)
	{
	   url += "&Str=" + ArrSelStr[i];
	}

	url += "&MissOpt=<%=sMissOpt%>";
	url += "&Sort=<%=sSort%>";
	   
	for(var i=0; i < ArrSelCol.length; i++)
	{
	   url += "&col=" + ArrSelCol[i];      
	}
	
	if(Print == "Y"){ url += "&print=N"; }
	else { url += "&print=Y"; }
	
	//alert(url);
	window.location.href=url;
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
<%if(!sPrint.equals("Y")){%>
 <div style="clear: both; overflow: AUTO; width: 100%; height: 94%; POSITION: relative; color:black;" >
<%}%>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=0 class="DataTable" cellPadding="0" cellSpacing="0" id="tblMain">
        <thead>
        <tr style="z-index: 60; position: relative; left: -1; 
             <%if(!sPrint.equals("Y")){%>top: expression(this.offsetParent.scrollTop-2);<%}%>">
          <th class="DataTable1" style="border-right:none" colspan=45>
            <b>Retail Concepts, Inc
            <br>Traffic Report 
            <br>Stores:
               <%String sComa = "";%>
               <%for(int i=0; i < sSelStr.length;i++){%>
                  <%if(i > 0 && i%20 == 0){%><br><%}%>
                  <%=sComa%><%=sSelStr[i]%>
                  <%sComa = ", ";%>
               <%}%>

              <br><%if(sFrom.equals("WTD")){%>Week-To-Date<%}
                    else if(sFrom.equals("MTD")){%>Month-To-Date<%}
                    else if(sFrom.equals("QTD")){%>Quater-To-Date<%}
                    else if(sFrom.equals("YTD")){%>Year-To-Date<%}
                    else if(sFrom.equals("PMN")){%>Prior Month<%}                    
                    else {%>
                       From: <span id="spnFrHdr"><%=sFrom%></span> &nbsp;&nbsp;&nbsp;&nbsp;
                       To: <span id="spnToHdr"><%=sTo%></span> &nbsp;&nbsp;&nbsp;&nbsp;
                    <%}%>
            </b>
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;
              <%if(bUpdStrGrp){%><a href="InetStrGrpLst.jsp" target="_blank">Maint Str Groups</a><%}%>
              &nbsp; &nbsp; &nbsp; &nbsp;
              <%if(!sPrint.equals("Y")){%><a href="javascript: setPrint()">Print(unpin header)</a><%}
              else {%><a href="javascript: setPrint()">Original(pin header)</a><%}%>
              
              &nbsp; &nbsp; &nbsp; &nbsp;<a href="HCDlyLstExcel.jsp?<%=sQuery%>">To Excel</a>
          </th>
        </tr>


        <tr style="z-index: 60; position: relative; left: -1; 
            <%if(!sPrint.equals("Y")){%>top: expression(this.offsetParent.scrollTop-2);<%}%>">
          <th class="DataTable"><a href="javascript: resort('STR')">Str</a></th>
          <th class="DataTable">Date</th>

          <th class="DataTable" id="col0h0" colspan=4>(A)<br>Traffic<br><%if(bGoalHdr){ %>Goal as % of LY: <%=sGoal[0]%>%<%}%></th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col1h0" colspan=4>Conversion<br>Rate<%if(bGoalHdr){ %><br>Goal as % of LY: <%=sGoal[1]%>%<%}%></th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col2h0" colspan=4>Transactions</th>          
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col3h0" colspan=4>Average Sales<br>Price<%if(bGoalHdr){ %><br>Goal as % of LY: <%=sGoal[2]%>%<%}%></th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col4h0" colspan=4>Total Sales</th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col5h0" colspan=4>Returns</th>
          <th class="DataTable2">&nbsp;</th>
          <th class="DataTable3" id="col6h0" colspan=4>(B)<br>Net Sales</th>
          <th class="DataTable2">&nbsp;</th>
          <th class="DataTable" id="col7h0">(B) - (A)<br><a href="javascript: resort('PVSO')">Performance<br>vs.<br>Opportunity</a></th>
        </tr>

        <tr style="z-index: 60; position: relative; left: -1; 
            <%if(!sPrint.equals("Y")){%>top: expression(this.offsetParent.scrollTop-2);<%}%>">
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable">
              <%if(!sDatBrk.equals("None")){%>
                 <a href="javascript: showPeriodHcd()">fold/unfold</a><%} else{%>&nbsp;
              <%}%>
          </th>
          <th class="DataTable" id="col0hs"><a href="javascript: resort('TRAFTY')">TY</a></th>
          <th class="DataTable" id="col0hs"><a href="javascript: resort('TRAFLY')">LY</a></th>
          <th class="DataTable" id="col0hs"><a href="javascript: resort('TRAFVAR')">Var</a></th>
          <th class="DataTable" id="col0hs">Goal</th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col1hs"><a href="javascript: resort('CRATTY')">TY</a></th>
          <th class="DataTable" id="col1hs"><a href="javascript: resort('CRATLY')">LY</a></th>
          <th class="DataTable" id="col1hs"><a href="javascript: resort('CRATVAR')">Var</a></th>
          <th class="DataTable" id="col1hs">Goal</th>          
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col2hs"><a href="javascript: resort('TRANTY')">TY</a></th>
          <th class="DataTable" id="col2hs"><a href="javascript: resort('TRANLY')">LY</a></th>
          <th class="DataTable" id="col2hs"><a href="javascript: resort('TRANVAR')">Var</a></th>
          <th class="DataTable" id="col2hs">Goal</th>          
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col3hs"><a href="javascript: resort('ASPTY')">TY</a></th>
          <th class="DataTable" id="col3hs"><a href="javascript: resort('ASPLY')">LY</a></th>
          <th class="DataTable" id="col3hs"><a href="javascript: resort('ASPVAR')">Var</a></th>
          <th class="DataTable" id="col3hs">Goal</th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col4hs"><a href="javascript: resort('TOTSTY')">TY</a></th>
          <th class="DataTable" id="col4hs"><a href="javascript: resort('TOTSLY')">LY</a></th>
          <th class="DataTable" id="col4hs"><a href="javascript: resort('TOTSVAR')">Var</a></th>
          <th class="DataTable" id="col4hs">Goal</th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable" id="col5hs"><a href="javascript: resort('RETTY')">TY</a></th>
          <th class="DataTable" id="col5hs"><a href="javascript: resort('RETLY')">LY</a></th>
          <th class="DataTable" id="col5hs"><a href="javascript: resort('RETVAR')">Var</a></th>
          <th class="DataTable" id="col5hs">Goal</th>
          <th class="DataTable2">&nbsp;</th>
          <th class="DataTable" id="col6hs"><a href="javascript: resort('NETTY')">TY</a></th>
          <th class="DataTable" id="col6hs"><a href="javascript: resort('NETLY')">LY</a></th>
          <th class="DataTable" id="col6hs"><a href="javascript: resort('NETVAR')">Var</a></th>
          <th class="DataTable" id="col6hs">Goal</th>
          <th class="DataTable2">&nbsp;</th>
          <th class="DataTable" id="col7hs">Var</th>
        </tr>

        </thead>
<!------------------------------- Detail --------------------------------->
           <%int iLine=0;%>           
           <%for(int i=0; i < iNumOfDtl; i++) {
        	  hcdly.setHeadCounts();              
              String sStr = hcdly.getStr();
              String sDate = hcdly.getDate();
              String sTyTraf = hcdly.getTyTraf();
              String sTyTrans = hcdly.getTyTrans();
              String sTyConv = hcdly.getTyConv();
              String sTyAsp = hcdly.getTyAsp();
              String sTyTotSls = hcdly.getTyTotSls();
              String sTyTotRet = hcdly.getTyTotRet();
              String sTyTotNet = hcdly.getTyTotNet();

              String sLyTraf = hcdly.getLyTraf();
              String sLyTrans = hcdly.getLyTrans();
              String sLyConv = hcdly.getLyConv();
              String sLyAsp = hcdly.getLyAsp();
              String sLyTotSls = hcdly.getLyTotSls();
              String sLyTotRet = hcdly.getLyTotRet();
              String sLyTotNet = hcdly.getLyTotNet();

              String sVaTraf = hcdly.getVaTraf();
              String sVaTrans = hcdly.getVaTrans();
              String sVaConv = hcdly.getVaConv();
              String sVaAsp = hcdly.getVaAsp();
              String sVaTotSls = hcdly.getVaTotSls();
              String sVaTotRet = hcdly.getVaTotRet();
              String sVaTotNet = hcdly.getVaTotNet();
              String sPerfVsOpt = hcdly.getPerfVsOpt();
              String sMissed = hcdly.getMissed();   
              
              String sGlTraf = hcdly.getGlTraf();
              String sGlTrans = hcdly.getGlTrans();
              String sGlConv = hcdly.getGlConv();
              String sGlAsp = hcdly.getGlAsp();
              String sGlTotSls = hcdly.getGlTotSls();
              String sGlTotRet = hcdly.getGlTotRet();
              String sGlTotNet = hcdly.getGlTotNet();
           %>
              <%if(!sDatBrk.equals("None")){%>
                  <tr class="DataTable"><td class="Separator02" colspan=38>&nbsp;</td></tr>
              <%}%>
              <tr id="trId<%=iLine%>" class="DataTable<%if(sTyTraf.equals("0") || sLyTraf.equals("0")){%>2<%} else if(sMissed.equals("Y")){%>3<%}%>">
                <td class="DataTable"><%=sStr%> <%if(iNumOfPer > 0){%><a href="javascript: setGraph('STR', '<%=sStr%>', '<%=iLine%>')">(G)</a><%}%></td>
                <td class="DataTable">&nbsp;</td>
                
                <td class="DataTable" id="col0d0"><%=sTyTraf%></td>
                <td class="DataTable" id="col0d1"><%=sLyTraf%></td>
                <td class="DataTable" id="col0d2" nowrap><%=sVaTraf%>%</td>
                <td class="DataTable" id="col0d3"><%=sGlTraf%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col1d0" nowrap><%=sTyConv%>%</td>
                <td class="DataTable" id="col1d1" nowrap><%=sLyConv%>%</td>
                <td class="DataTable" id="col1d2" nowrap><%=sVaConv%>%</td>
                <td class="DataTable" id="col1d3" nowrap><%=sGlConv%>%</td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col2d0" nowrap><%=sTyTrans %></td>
                <td class="DataTable" id="col2d1" nowrap><%=sLyTrans %></td>
                <td class="DataTable" id="col2d2" nowrap><%=sVaTrans%>%</td>
                <td class="DataTable" id="col2d3" nowrap><%=sGlTrans %></td>
                
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col3d0" nowrap>$<%=sTyAsp%></td>
                <td class="DataTable" id="col3d1" nowrap>$<%=sLyAsp%></td>
                <td class="DataTable" id="col3d2" nowrap><%=sVaAsp%>%</td>
                <td class="DataTable" id="col3d3" nowrap>$<%=sGlAsp%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col4d0" nowrap>$<%=sTyTotSls%></td>
                <td class="DataTable" id="col4d1" nowrap>$<%=sLyTotSls%></td>                
                <td class="DataTable" id="col4d2" nowrap><%=sVaTotSls%>%</td>
                <td class="DataTable" id="col4d3" nowrap>$<%=sGlTotSls%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col5d0" nowrap>$<%=sTyTotRet%></td>
                <td class="DataTable" id="col5d1" nowrap>$<%=sLyTotRet%></td>
                <td class="DataTable" id="col5d2" nowrap><%=sVaTotRet%>%</td>
                <td class="DataTable" id="col5d3" nowrap>$<%=sGlTotRet%></td>
                <th class="DataTable2">&nbsp;</th>
                <td class="DataTable5" id="col6d0" nowrap>$<%=sTyTotNet%></td>
                <td class="DataTable5" id="col6d1" nowrap>$<%=sLyTotNet%></td>
                <td class="DataTable5" id="col6d2" nowrap><%=sVaTotNet%>%</td>
                <td class="DataTable5" id="col6d3" nowrap>$<%=sGlTotNet%></td>
                <th class="DataTable2">&nbsp;</th>
                <td class="DataTable" id="col7d2" nowrap><%=sPerfVsOpt %>%</td>                
                <!-- ============== Detail Period Breaks ====================================-->                
                <%
                for(int j = 0; j < iNumOfPer; j++)
                {
             	   hcdly.setHdCntPer(sStr, j);
             	   sStr = hcdly.getStr();
                    sDate = hcdly.getDate();

                    sTyTraf = hcdly.getTyTraf();
                    sTyTrans = hcdly.getTyTrans();
                    sTyConv = hcdly.getTyConv();
                    sTyAsp = hcdly.getTyAsp();
                    sTyTotSls = hcdly.getTyTotSls();
                    sTyTotRet = hcdly.getTyTotRet();
                    sTyTotNet = hcdly.getTyTotNet();

                    sLyTraf = hcdly.getLyTraf();
                    sLyTrans = hcdly.getLyTrans();
                    sLyConv = hcdly.getLyConv();
                    sLyAsp = hcdly.getLyAsp();
                    sLyTotSls = hcdly.getLyTotSls();
                    sLyTotRet = hcdly.getLyTotRet();
                    sLyTotNet = hcdly.getLyTotNet();

                    sVaTraf = hcdly.getVaTraf();
                    sVaTrans = hcdly.getVaTrans();
                    sVaConv = hcdly.getVaConv();
                    sVaAsp = hcdly.getVaAsp();
                    sVaTotSls = hcdly.getVaTotSls();
                    sVaTotRet = hcdly.getVaTotRet();
                    sVaTotNet = hcdly.getVaTotNet();
                    sPerfVsOpt = hcdly.getPerfVsOpt();
                    sMissed = hcdly.getMissed();
                    
                    sGlTraf = hcdly.getGlTraf();
                    sGlTrans = hcdly.getGlTrans();
                    sGlConv = hcdly.getGlConv();
                    sGlAsp = hcdly.getGlAsp();
                    sGlTotSls = hcdly.getGlTotSls();
                    sGlTotRet = hcdly.getGlTotRet();
                    sGlTotNet = hcdly.getGlTotNet();
                    %>
                    <tr id="trId<%=iLine%>" class="DataTable5"> <!-- id="trPer" -->                
        		        <td class="DataTable">&nbsp;</td>
    	        	    <td class="DataTable"><%=sPer[j]%></td>
                
	                	<td class="DataTable" id="col0d0"><%=sTyTraf%></td>
                		<td class="DataTable" id="col0d1"><%=sLyTraf%></td>
	        	        <td class="DataTable" id="col0d2" nowrap><%=sVaTraf%>%</td>
	        	        <td class="DataTable" id="col0d3"><%=sGlTraf%></td>
    		            <th class="DataTable">&nbsp;</th>
	    	            <td class="DataTable" id="col1d0" nowrap><%=sTyConv%>%</td>
		                <td class="DataTable" id="col1d1" nowrap><%=sLyConv%>%</td>
        	        	<td class="DataTable" id="col1d2" nowrap><%=sVaConv%>%</td>
        	        	<td class="DataTable" id="col1d3" nowrap><%=sGlConv%>%</td>
    	        	    <th class="DataTable">&nbsp;</th>
	    	            <td class="DataTable" id="col2d0"><%=sTyTrans%></td>
            	    	<td class="DataTable" id="col2d1"><%=sLyTrans%></td>
            		    <td class="DataTable" id="col2d2" nowrap><%=sVaTrans%>%</td>
            		    <td class="DataTable" id="col2d3"><%=sGlTrans%></td>        	        	
    	        	    <th class="DataTable">&nbsp;</th>
        		        <td class="DataTable" id="col3d0">$<%=sTyAsp%></td>
    	        	    <td class="DataTable" id="col3d1">$<%=sLyAsp%></td>    	        	    
	                	<td class="DataTable" id="col3d2" nowrap><%=sVaAsp%>%</td>
	                	<td class="DataTable" id="col3d3">$<%=sGlAsp%></td>
		           	    <th class="DataTable">&nbsp;</th>
        		        <td class="DataTable" id="col4d0">$<%=sTyTotSls%></td>
    	    	        <td class="DataTable" id="col4d1">$<%=sLyTotSls%></td>
	                	<td class="DataTable" id="col4d2" nowrap><%=sVaTotSls%>%</td>
	                	<td class="DataTable" id="col4d3">$<%=sGlTotSls%></td>
                		<th class="DataTable">&nbsp;</th>
	                	<td class="DataTable" id="col5d0">$<%=sTyTotRet%></td>
    	            	<td class="DataTable" id="col5d1">$<%=sLyTotRet%></td>
        	        	<td class="DataTable" id="col5d2" nowrap><%=sVaTotRet%>%</td>
        	        	<td class="DataTable" id="col5d3">$<%=sGlTotRet%></td>
            	    	<th class="DataTable2">&nbsp;</th>
                		<td class="DataTable5" id="col6d0">$<%=sTyTotNet%></td>
                		<td class="DataTable5" id="col6d1">$<%=sLyTotNet%></td>
                		<td class="DataTable5" id="col6d2" nowrap><%=sVaTotNet%>%</td>
                		<td class="DataTable5" id="col6d3">$<%=sGlTotNet%></td>
                		<th class="DataTable">&nbsp;</th>
                		<td class="DataTable2" id="col7d2" nowrap><%=sPerfVsOpt%>%</td>                    
                	</tr>
                <%}%>
                <%iLine++;%>                
           <%}%>
           <!-- ============== Region Totals ====================================-->
           <%for(int i=0; i < iNumOfReg; i++) {               
              hcdly.setRegTot();
              String sStr = hcdly.getStr();
              String sDate = hcdly.getDate();
              String sTyTraf = hcdly.getTyTraf();
              String sTyTrans = hcdly.getTyTrans();
              String sTyConv = hcdly.getTyConv();
              String sTyAsp = hcdly.getTyAsp();
              String sTyTotSls = hcdly.getTyTotSls();
              String sTyTotRet = hcdly.getTyTotRet();
              String sTyTotNet = hcdly.getTyTotNet();

              String sLyTraf = hcdly.getLyTraf();
              String sLyTrans = hcdly.getLyTrans();
              String sLyConv = hcdly.getLyConv();
              String sLyAsp = hcdly.getLyAsp();
              String sLyTotSls = hcdly.getLyTotSls();
              String sLyTotRet = hcdly.getLyTotRet();
              String sLyTotNet = hcdly.getLyTotNet();

              String sVaTraf = hcdly.getVaTraf();
              String sVaTrans = hcdly.getVaTrans();
              String sVaConv = hcdly.getVaConv();
              String sVaAsp = hcdly.getVaAsp();
              String sVaTotSls = hcdly.getVaTotSls();
              String sVaTotRet = hcdly.getVaTotRet();
              String sVaTotNet = hcdly.getVaTotNet();
              String sPerfVsOpt = hcdly.getPerfVsOpt();
              
              String sGlTraf = hcdly.getGlTraf();
              String sGlTrans = hcdly.getGlTrans();
              String sGlConv = hcdly.getGlConv();
              String sGlAsp = hcdly.getGlAsp();
              String sGlTotSls = hcdly.getGlTotSls();
              String sGlTotRet = hcdly.getGlTotRet();
              String sGlTotNet = hcdly.getGlTotNet();
           %>              
              <tr id="trId<%=iLine%>" class="DataTable4">
                <td class="DataTable" nowrap>Dist <%=sStr%> <%if(iNumOfPer > 0){%><a href="javascript: setGraph('DIST', '<%=sStr%>', '<%=iLine%>')">(G)</a><%}%></td>
                <td class="DataTable">&nbsp;</td>
                <td class="DataTable" id="col0d0"><%=sTyTraf%></td>
                <td class="DataTable" id="col0d1"><%=sLyTraf%></td>
                <td class="DataTable" id="col0d2" nowrap><%=sVaTraf%>%</td>
                <td class="DataTable" id="col0d3"><%=sGlTraf%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col1d0"><%=sTyConv%>%</td>
                <td class="DataTable" id="col1d1"><%=sLyConv%>%</td>
                <td class="DataTable" id="col1d2" nowrap><%=sVaConv%>%</td>
                <td class="DataTable" id="col1d3"><%=sGlConv%>%</td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col2d0"><%=sTyTrans%></td>
                <td class="DataTable" id="col2d1"><%=sLyTrans%></td>
                <td class="DataTable" id="col2d2" nowrap><%=sVaTrans%>%</td>
                <td class="DataTable" id="col2d3"><%=sGlTrans%></td>                
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col3d0">$<%=sTyAsp%></td>
                <td class="DataTable" id="col3d1">$<%=sLyAsp%></td>
                <td class="DataTable" id="col3d2" nowrap><%=sVaAsp%>%</td>
                <td class="DataTable" id="col3d3">$<%=sGlAsp%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col4d0">$<%=sTyTotSls%></td>
                <td class="DataTable" id="col4d1">$<%=sLyTotSls%></td>
                <td class="DataTable" id="col4d2" nowrap><%=sVaTotSls%>%</td>
                <td class="DataTable" id="col4d3">$<%=sGlTotSls%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col5d0">$<%=sTyTotRet%></td>
                <td class="DataTable" id="col5d1">$<%=sLyTotRet%></td>
                <td class="DataTable" id="col5d2" nowrap><%=sVaTotRet%>%</td>
                <td class="DataTable" id="col5d3">$<%=sGlTotRet%></td>
                <th class="DataTable2">&nbsp;</th>
                <td class="DataTable6" id="col6d0">$<%=sTyTotNet%></td>
                <td class="DataTable6" id="col6d1">$<%=sLyTotNet%></td>
                <td class="DataTable6" id="col6d2" nowrap><%=sVaTotNet%>%</td>
                <td class="DataTable6" id="col6d3">$<%=sGlTotNet%></td>
                <th class="DataTable2">&nbsp;</th>
                <td class="DataTable" id="col7d2" nowrap><%=sPerfVsOpt%>%</td>
                
                <!-- ============== Region Period Breaks ====================================-->
                <%                
                for(int j = 0; j < iNumOfPer; j++ )
                {
             	   hcdly.setRegPer(sStr, j);
             	   sStr = hcdly.getStr();
                    sDate = hcdly.getDate();

                    sTyTraf = hcdly.getTyTraf();
                    sTyTrans = hcdly.getTyTrans();
                    sTyConv = hcdly.getTyConv();
                    sTyAsp = hcdly.getTyAsp();
                    sTyTotSls = hcdly.getTyTotSls();
                    sTyTotRet = hcdly.getTyTotRet();
                    sTyTotNet = hcdly.getTyTotNet();

                    sLyTraf = hcdly.getLyTraf();
                    sLyTrans = hcdly.getLyTrans();
                    sLyConv = hcdly.getLyConv();
                    sLyAsp = hcdly.getLyAsp();
                    sLyTotSls = hcdly.getLyTotSls();
                    sLyTotRet = hcdly.getLyTotRet();
                    sLyTotNet = hcdly.getLyTotNet();

                    sVaTraf = hcdly.getVaTraf();
                    sVaTrans = hcdly.getVaTrans();
                    sVaConv = hcdly.getVaConv();
                    sVaAsp = hcdly.getVaAsp();
                    sVaTotSls = hcdly.getVaTotSls();
                    sVaTotRet = hcdly.getVaTotRet();
                    sVaTotNet = hcdly.getVaTotNet();
                    sPerfVsOpt = hcdly.getPerfVsOpt();
                    
                    sGlTraf = hcdly.getGlTraf();
                    sGlTrans = hcdly.getGlTrans();
                    sGlConv = hcdly.getGlConv();
                    sGlAsp = hcdly.getGlAsp();
                    sGlTotSls = hcdly.getGlTotSls();
                    sGlTotRet = hcdly.getGlTotRet();
                    sGlTotNet = hcdly.getGlTotNet();
                    %>                    
                    <tr id="trId<%=iLine%>" class="DataTable5"> <!-- id="trPer" -->           
        		        <td class="DataTable">&nbsp;</td>
    	        	    <td class="DataTable"><%=sPer[j]%></td>
                
	                	<td class="DataTable" id="col0d0"><%=sTyTraf%></td>
                		<td class="DataTable" id="col0d1"><%=sLyTraf%></td>
	        	        <td class="DataTable" id="col0d2" nowrap><%=sVaTraf%>%</td>
	        	        <td class="DataTable" id="col0d3"><%=sGlTraf%></td>
	        	        <th class="DataTable">&nbsp;</th>
	    	            <td class="DataTable" id="col1d0" nowrap><%=sTyConv%>%</td>
		                <td class="DataTable" id="col1d1" nowrap><%=sLyConv%>%</td>
        	        	<td class="DataTable" id="col1d2" nowrap><%=sVaConv%>%</td>
        	        	<td class="DataTable" id="col1d3" nowrap><%=sGlConv%>%</td>
    		            <th class="DataTable">&nbsp;</th>
	    	            <td class="DataTable" id="col2d0"><%=sTyTrans%></td>
            	    	<td class="DataTable" id="col2d1"><%=sLyTrans%></td>
            		    <td class="DataTable" id="col2d2" nowrap><%=sVaTrans%>%</td>
            		    <td class="DataTable" id="col2d3"><%=sGlTrans%></td>        	        	
    	        	    <th class="DataTable">&nbsp;</th>
        		        <td class="DataTable" id="col3d0">$<%=sTyAsp%></td>
    	        	    <td class="DataTable" id="col3d1">$<%=sLyAsp%></td>
	                	<td class="DataTable" id="col3d2" nowrap><%=sVaAsp%>%</td>
	                	<td class="DataTable" id="col3d3">$<%=sGlAsp%></td>
		           	    <th class="DataTable">&nbsp;</th>
        		        <td class="DataTable" id="col4d0">$<%=sTyTotSls%></td>
    	    	        <td class="DataTable" id="col4d1">$<%=sLyTotSls%></td>
	                	<td class="DataTable" id="col4d2" nowrap><%=sVaTotSls%>%</td>
	                	<td class="DataTable" id="col4d3">$<%=sGlTotSls%></td>
                		<th class="DataTable">&nbsp;</th>
	                	<td class="DataTable" id="col5d0">$<%=sTyTotRet%></td>
    	            	<td class="DataTable" id="col5d1">$<%=sLyTotRet%></td>
        	        	<td class="DataTable" id="col5d2" nowrap><%=sVaTotRet%>%</td>
        	        	<td class="DataTable" id="col5d3">$<%=sGlTotRet%></td>
            	    	<th class="DataTable2">&nbsp;</th>
                		<td class="DataTable5" id="col6d0">$<%=sTyTotNet%></td>
                		<td class="DataTable5" id="col6d1">$<%=sLyTotNet%></td>
                		<td class="DataTable5" id="col6d2" nowrap><%=sVaTotNet%>%</td>
                		<td class="DataTable5" id="col6d3">$<%=sGlTotNet%></td>
                		<th class="DataTable2">&nbsp;</th>
                		<td class="DataTable" id="col7d2" nowrap><%=sPerfVsOpt%>%</td>                    
                	</tr>                	    
                <%}%>
                <%iLine++;%>
             <%}%>             
             
             <!-- ============== Group Totals ====================================-->
           <%for(int i=0; i < iNumOfGrp; i++) {               
              hcdly.setGrpTot();
              String sStr = hcdly.getStr();
              String sDate = hcdly.getDate();
              String sTyTraf = hcdly.getTyTraf();
              String sTyTrans = hcdly.getTyTrans();
              String sTyConv = hcdly.getTyConv();
              String sTyAsp = hcdly.getTyAsp();
              String sTyTotSls = hcdly.getTyTotSls();
              String sTyTotRet = hcdly.getTyTotRet();
              String sTyTotNet = hcdly.getTyTotNet();

              String sLyTraf = hcdly.getLyTraf();
              String sLyTrans = hcdly.getLyTrans();
              String sLyConv = hcdly.getLyConv();
              String sLyAsp = hcdly.getLyAsp();
              String sLyTotSls = hcdly.getLyTotSls();
              String sLyTotRet = hcdly.getLyTotRet();
              String sLyTotNet = hcdly.getLyTotNet();

              String sVaTraf = hcdly.getVaTraf();
              String sVaTrans = hcdly.getVaTrans();
              String sVaConv = hcdly.getVaConv();
              String sVaAsp = hcdly.getVaAsp();
              String sVaTotSls = hcdly.getVaTotSls();
              String sVaTotRet = hcdly.getVaTotRet();
              String sVaTotNet = hcdly.getVaTotNet();
              String sPerfVsOpt = hcdly.getPerfVsOpt();
              
              String sGlTraf = hcdly.getGlTraf();
              String sGlTrans = hcdly.getGlTrans();
              String sGlConv = hcdly.getGlConv();
              String sGlAsp = hcdly.getGlAsp();
              String sGlTotSls = hcdly.getGlTotSls();
              String sGlTotRet = hcdly.getGlTotRet();
              String sGlTotNet = hcdly.getGlTotNet();
           %>
              <tr id="trId<%=iLine%>" class="DataTable6">
                <td class="DataTable" nowrap><%=sStr%> <%if(iNumOfPer > 0){%><a href="javascript: setGraph('GROUP', '<%=sStr%>', '<%=iLine%>')">(G)</a><%}%></td>
                <td class="DataTable">&nbsp;</td>
                <td class="DataTable" id="col0d0"><%=sTyTraf%></td>
                <td class="DataTable" id="col0d1"><%=sLyTraf%></td>
                <td class="DataTable" id="col0d2" nowrap><%=sVaTraf%>%</td>
                <td class="DataTable" id="col0d3"><%=sGlTraf%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col1d0"><%=sTyConv%>%</td>
                <td class="DataTable" id="col1d1"><%=sLyConv%>%</td>
                <td class="DataTable" id="col1d2" nowrap><%=sVaConv%>%</td>
                <td class="DataTable" id="col1d3"><%=sGlConv%>%</td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col2d0"><%=sTyTrans%></td>
                <td class="DataTable" id="col2d1"><%=sLyTrans%></td>
                <td class="DataTable" id="col2d2" nowrap><%=sVaTrans%>%</td>
                <td class="DataTable" id="col2d3"><%=sGlTrans%></td>                
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col3d0">$<%=sTyAsp%></td>
                <td class="DataTable" id="col3d1">$<%=sLyAsp%></td>
                <td class="DataTable" id="col3d2" nowrap><%=sVaAsp%>%</td>
                <td class="DataTable" id="col3d3">$<%=sGlAsp%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col4d0">$<%=sTyTotSls%></td>
                <td class="DataTable" id="col4d1">$<%=sLyTotSls%></td>
                <td class="DataTable" id="col4d2" nowrap><%=sVaTotSls%>%</td>
                <td class="DataTable" id="col4d3">$<%=sGlTotSls%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col5d0">$<%=sTyTotRet%></td>
                <td class="DataTable" id="col5d1">$<%=sLyTotRet%></td>
                <td class="DataTable" id="col5d2" nowrap><%=sVaTotRet%>%</td>
                <td class="DataTable" id="col5d3">$<%=sGlTotRet%></td>
                <th class="DataTable2">&nbsp;</th>
                <td class="DataTable7" id="col6d0">$<%=sTyTotNet%></td>
                <td class="DataTable7" id="col6d1">$<%=sLyTotNet%></td>
                <td class="DataTable7" id="col6d2" nowrap><%=sVaTotNet%>%</td>
                <td class="DataTable7" id="col6d3">$<%=sGlTotNet%></td>
                <th class="DataTable2">&nbsp;</th>
                <td class="DataTable" id="col7d2" nowrap><%=sPerfVsOpt%>%</td>
                
                <!-- ============== Group Period Breaks ====================================-->
                <%
                for(int j = 0; j < iNumOfPer; j++ )
                {
                   hcdly.setGrpPer(Integer.toString(i+1), j);
             	   sStr = hcdly.getStr();
                    sDate = hcdly.getDate();

                    sTyTraf = hcdly.getTyTraf();
                    sTyTrans = hcdly.getTyTrans();
                    sTyConv = hcdly.getTyConv();
                    sTyAsp = hcdly.getTyAsp();
                    sTyTotSls = hcdly.getTyTotSls();
                    sTyTotRet = hcdly.getTyTotRet();
                    sTyTotNet = hcdly.getTyTotNet();

                    sLyTraf = hcdly.getLyTraf();
                    sLyTrans = hcdly.getLyTrans();
                    sLyConv = hcdly.getLyConv();
                    sLyAsp = hcdly.getLyAsp();
                    sLyTotSls = hcdly.getLyTotSls();
                    sLyTotRet = hcdly.getLyTotRet();
                    sLyTotNet = hcdly.getLyTotNet();

                    sVaTraf = hcdly.getVaTraf();
                    sVaTrans = hcdly.getVaTrans();
                    sVaConv = hcdly.getVaConv();
                    sVaAsp = hcdly.getVaAsp();
                    sVaTotSls = hcdly.getVaTotSls();
                    sVaTotRet = hcdly.getVaTotRet();
                    sVaTotNet = hcdly.getVaTotNet();
                    sPerfVsOpt = hcdly.getPerfVsOpt();
                    
                    sGlTraf = hcdly.getGlTraf();
                    sGlTrans = hcdly.getGlTrans();
                    sGlConv = hcdly.getGlConv();
                    sGlAsp = hcdly.getGlAsp();
                    sGlTotSls = hcdly.getGlTotSls();
                    sGlTotRet = hcdly.getGlTotRet();
                    sGlTotNet = hcdly.getGlTotNet();
                    %>
                    <tr id="trId<%=iLine%>" class="DataTable5"> <!-- id="trPer" --> 
        		        <td class="DataTable">&nbsp;</td>
    	        	    <td class="DataTable"><%=sPer[j]%></td>
                
	                	<td class="DataTable" id="col0d0"><%=sTyTraf%></td>
                		<td class="DataTable" id="col0d1"><%=sLyTraf%></td>
	        	        <td class="DataTable" id="col0d2" nowrap><%=sVaTraf%>%</td>
	        	        <td class="DataTable" id="col0d3"><%=sGlTraf%></td>
	        	        <th class="DataTable">&nbsp;</th>
	    	            <td class="DataTable" id="col1d0" nowrap><%=sTyConv%>%</td>
		                <td class="DataTable" id="col1d1" nowrap><%=sLyConv%>%</td>
        	        	<td class="DataTable" id="col1d2" nowrap><%=sVaConv%>%</td>
        	        	<td class="DataTable" id="col1d3" nowrap><%=sGlConv%>%</td>
    		            <th class="DataTable">&nbsp;</th>
	    	            <td class="DataTable" id="col2d0"><%=sTyTrans%></td>
            	    	<td class="DataTable" id="col2d1"><%=sLyTrans%></td>
            		    <td class="DataTable" id="col2d2" nowrap><%=sVaTrans%>%</td>
            		    <td class="DataTable" id="col2d3"><%=sGlTrans%></td>        	        	
    	        	    <th class="DataTable">&nbsp;</th>
        		        <td class="DataTable" id="col3d0">$<%=sTyAsp%></td>
    	        	    <td class="DataTable" id="col3d1">$<%=sLyAsp%></td>
	                	<td class="DataTable" id="col3d2" nowrap><%=sVaAsp%>%</td>
	                	<td class="DataTable" id="col3d3">$<%=sGlAsp%></td>
		           	    <th class="DataTable">&nbsp;</th>
        		        <td class="DataTable" id="col4d0">$<%=sTyTotSls%></td>
    	    	        <td class="DataTable" id="col4d1">$<%=sLyTotSls%></td>
	                	<td class="DataTable" id="col4d2" nowrap><%=sVaTotSls%>%</td>
	                	<td class="DataTable" id="col4d3">$<%=sGlTotSls%></td>
                		<th class="DataTable">&nbsp;</th>
	                	<td class="DataTable" id="col5d0">$<%=sTyTotRet%></td>
    	            	<td class="DataTable" id="col5d1">$<%=sLyTotRet%></td>
        	        	<td class="DataTable" id="col5d2" nowrap><%=sVaTotRet%>%</td>
        	        	<td class="DataTable" id="col5d3">$<%=sGlTotRet%></td>
            	    	<th class="DataTable2">&nbsp;</th>
                		<td class="DataTable5" id="col6d0">$<%=sTyTotNet%></td>
                		<td class="DataTable5" id="col6d1">$<%=sLyTotNet%></td>
                		<td class="DataTable5" id="col6d2" nowrap><%=sVaTotNet%>%</td>
                		<td class="DataTable5" id="col6d3">$<%=sGlTotNet%></td>
                		<th class="DataTable2">&nbsp;</th>
                		<td class="DataTable" id="col7d2" nowrap><%=sPerfVsOpt%>%</td>                    
                	</tr>    
                <%}%> 
                <%iLine++;%>                         
             <%}%>
             
           <!-- ============== Totals =======================================-->
           <%
              hcdly.setTotal();
              String sStr = hcdly.getStr();
              String sDate = hcdly.getDate();
              String sTyTraf = hcdly.getTyTraf();
              String sTyTrans = hcdly.getTyTrans();
              String sTyConv = hcdly.getTyConv();
              String sTyAsp = hcdly.getTyAsp();
              String sTyTotSls = hcdly.getTyTotSls();
              String sTyTotRet = hcdly.getTyTotRet();
              String sTyTotNet = hcdly.getTyTotNet();

              String sLyTraf = hcdly.getLyTraf();
              String sLyTrans = hcdly.getLyTrans();
              String sLyConv = hcdly.getLyConv();
              String sLyAsp = hcdly.getLyAsp();
              String sLyTotSls = hcdly.getLyTotSls();
              String sLyTotRet = hcdly.getLyTotRet();
              String sLyTotNet = hcdly.getLyTotNet();

              String sVaTraf = hcdly.getVaTraf();
              String sVaTrans = hcdly.getVaTrans();
              String sVaConv = hcdly.getVaConv();
              String sVaAsp = hcdly.getVaAsp();
              String sVaTotSls = hcdly.getVaTotSls();
              String sVaTotRet = hcdly.getVaTotRet();
              String sVaTotNet = hcdly.getVaTotNet();
              String sPerfVsOpt = hcdly.getPerfVsOpt();
              
              String sGlTraf = hcdly.getGlTraf();
              String sGlTrans = hcdly.getGlTrans();
              String sGlConv = hcdly.getGlConv();
              String sGlAsp = hcdly.getGlAsp();
              String sGlTotSls = hcdly.getGlTotSls();
              String sGlTotRet = hcdly.getGlTotRet();
              String sGlTotNet = hcdly.getGlTotNet();
           %>
              <tr  id="trId<%=iLine%>"  class="DataTable1">
                <td class="DataTable"><%=sStr%> <%if(iNumOfPer > 0){%><a href="javascript: setGraph('TOTAL', '<%=sStr%>', '<%=iLine%>')">(G)</a><%}%></td>
                <td class="DataTable">&nbsp;</td>
                <td class="DataTable" id="col0d0"><%=sTyTraf%></td>
                <td class="DataTable" id="col0d1"><%=sLyTraf%></td>
                <td class="DataTable" id="col0d2" nowrap><%=sVaTraf%>%</td>
                <td class="DataTable" id="col0d3"><%=sGlTraf%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col1d0"><%=sTyConv%>%</td>
                <td class="DataTable" id="col1d1"><%=sLyConv%>%</td>
                <td class="DataTable" id="col1d2" nowrap><%=sVaConv%>%</td>
                <td class="DataTable" id="col1d3"><%=sGlConv%>%</td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col2d0"><%=sTyTrans%></td>
                <td class="DataTable" id="col2d1"><%=sLyTrans%></td>
                <td class="DataTable" id="col2d2" nowrap><%=sVaTrans%>%</td>
                <td class="DataTable" id="col2d3"><%=sGlTrans%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col3d0">$<%=sTyAsp%></td>
                <td class="DataTable" id="col3d1">$<%=sLyAsp%></td>
                <td class="DataTable" id="col3d2" nowrap><%=sVaAsp%>%</td>
                <td class="DataTable" id="col3d3">$<%=sGlAsp%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col4d0">$<%=sTyTotSls%></td>
                <td class="DataTable" id="col4d1">$<%=sLyTotSls%></td>
                <td class="DataTable" id="col4d2" nowrap><%=sVaTotSls%>%</td>
                <td class="DataTable" id="col4d3">$<%=sGlTotSls%></td>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" id="col5d0">$<%=sTyTotRet%></td>
                <td class="DataTable" id="col5d1">$<%=sLyTotRet%></td>
                <td class="DataTable" id="col5d2" nowrap><%=sVaTotRet%>%</td>
                <td class="DataTable" id="col5d3">$<%=sGlTotRet%></td>
                <th class="DataTable2">&nbsp;</th>
                <td class="DataTable8" id="col6d0">$<%=sTyTotNet%></td>
                <td class="DataTable8" id="col6d1">$<%=sLyTotNet%></td>
                <td class="DataTable8" id="col6d2" nowrap><%=sVaTotNet%>%</td>
                <td class="DataTable8" id="col6d3">$<%=sGlTotNet%></td>
                <th class="DataTable2">&nbsp;</th>
                <td class="DataTable" id="col7d2" nowrap><%=sPerfVsOpt%>%</td>
                
                <!-- ============== Report Total Period Breaks ====================================-->
                <%
                for(int j = 0; j < iNumOfPer; j++ )
                {
             	   hcdly.setTotPer( j);
             	   sStr = hcdly.getStr();
                    sDate = hcdly.getDate();

                    sTyTraf = hcdly.getTyTraf();
                    sTyTrans = hcdly.getTyTrans();
                    sTyConv = hcdly.getTyConv();
                    sTyAsp = hcdly.getTyAsp();
                    sTyTotSls = hcdly.getTyTotSls();
                    sTyTotRet = hcdly.getTyTotRet();
                    sTyTotNet = hcdly.getTyTotNet();

                    sLyTraf = hcdly.getLyTraf();
                    sLyTrans = hcdly.getLyTrans();
                    sLyConv = hcdly.getLyConv();
                    sLyAsp = hcdly.getLyAsp();
                    sLyTotSls = hcdly.getLyTotSls();
                    sLyTotRet = hcdly.getLyTotRet();
                    sLyTotNet = hcdly.getLyTotNet();

                    sVaTraf = hcdly.getVaTraf();
                    sVaTrans = hcdly.getVaTrans();
                    sVaConv = hcdly.getVaConv();
                    sVaAsp = hcdly.getVaAsp();
                    sVaTotSls = hcdly.getVaTotSls();
                    sVaTotRet = hcdly.getVaTotRet();
                    sVaTotNet = hcdly.getVaTotNet();
                    sPerfVsOpt = hcdly.getPerfVsOpt();
                    
                    sGlTraf = hcdly.getGlTraf();
                    sGlTrans = hcdly.getGlTrans();
                    sGlConv = hcdly.getGlConv();
                    sGlAsp = hcdly.getGlAsp();
                    sGlTotSls = hcdly.getGlTotSls();
                    sGlTotRet = hcdly.getGlTotRet();
                    sGlTotNet = hcdly.getGlTotNet();
                    %>
                    <tr  id="trId<%=iLine%>" class="DataTable5"> <!-- id="trPer" -->   
        		        <td class="DataTable">&nbsp;</td>
    	        	    <td class="DataTable"><%=sPer[j]%></td>
                
	                	<td class="DataTable" id="col0d0"><%=sTyTraf%></td>
                		<td class="DataTable" id="col0d1"><%=sLyTraf%></td>
	        	        <td class="DataTable" id="col0d2" nowrap><%=sVaTraf%>%</td>
	        	        <td class="DataTable" id="col0d3"><%=sGlTraf%></td>
    		            <th class="DataTable">&nbsp;</th>
	    	            <td class="DataTable" id="col1d0" nowrap><%=sTyConv%>%</td>
		                <td class="DataTable" id="col1d1" nowrap><%=sLyConv%>%</td>
        	        	<td class="DataTable" id="col1d2" nowrap><%=sVaConv%>%</td>
        	        	<td class="DataTable" id="col1d3" nowrap><%=sGlConv%>%</td>
    	        	    <th class="DataTable">&nbsp;</th>
	    	            <td class="DataTable" id="col2d0"><%=sTyTrans%></td>
            	    	<td class="DataTable" id="col2d1"><%=sLyTrans%></td>
            		    <td class="DataTable" id="col2d2" nowrap><%=sVaTrans%>%</td>
            		    <td class="DataTable" id="col2d3"><%=sGlTrans%></td>
        	        	<th class="DataTable">&nbsp;</th>
        		        <td class="DataTable" id="col3d0">$<%=sTyAsp%></td>
    	        	    <td class="DataTable" id="col3d1">$<%=sLyAsp%></td>
	                	<td class="DataTable" id="col3d2" nowrap><%=sVaAsp%>%</td>
	                	<td class="DataTable" id="col3d3">$<%=sGlAsp%></td>
		           	    <th class="DataTable">&nbsp;</th>
        		        <td class="DataTable" id="col4d0">$<%=sTyTotSls%></td>
    	    	        <td class="DataTable" id="col4d1">$<%=sLyTotSls%></td>
	                	<td class="DataTable" id="col4d2" nowrap><%=sVaTotSls%>%</td>
	                	<td class="DataTable" id="col4d3">$<%=sGlTotSls%></td>
                		<th class="DataTable">&nbsp;</th>
	                	<td class="DataTable" id="col5d0">$<%=sTyTotRet%></td>
    	            	<td class="DataTable" id="col5d1">$<%=sLyTotRet%></td>
        	        	<td class="DataTable" id="col5d2" nowrap><%=sVaTotRet%>%</td>
        	        	<td class="DataTable" id="col5d3">$<%=sGlTotRet%></td>
            	    	<th class="DataTable2">&nbsp;</th>
                		<td class="DataTable5" id="col6d0">$<%=sTyTotNet%></td>
                		<td class="DataTable5" id="col6d1">$<%=sLyTotNet%></td>
                		<td class="DataTable5" id="col6d2" nowrap><%=sVaTotNet%>%</td>
                		<td class="DataTable5" id="col6d3">$<%=sGlTotNet%></td>
                		<th class="DataTable2">&nbsp;</th>
                		<td class="DataTable" id="col7d2" nowrap><%=sPerfVsOpt%>%</td>                    
                	</tr>    
                <%}%>                
      </table>
      <!----------------------- end of table ------------------------>
      <script type="text/javascript">AllLines = eval("<%=iLine%>");</script>
 </div>
 <span style="text-align:left;font-size:14px">
      Conversion statistics are updated daily at approximately 9:45 am.
 </span>
 <br><br>
 <span style="text-align:left;font-size:14px">
      <span style="background:gray; color:white;font-weight:bold">Stores</span> shaded in gray are not included in totals.
 </span>
 <br>
 <span style="text-align:left;font-size:14px">
      <span style="background:#F6CEF5; font-weight:bold">Stores</span> shaded in pink are not completely included in totals.
 </span>
 <br>
 <span style="text-align:left;font-size:14px">
 PvO is calculated on the traffic variance column vs. the net sales variance column.
 </span> 
 </body>
</html>
<%
  hcdly.disconnect();
  hcdly = null;
}
%>