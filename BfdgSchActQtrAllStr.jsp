<%@ page import="java.util.*, java.text.*, payrollreports.BfdgSchActQtrAllStr"%>
<%
   String sYear = request.getParameter("Year");
   String sQuarter = request.getParameter("Qtr");
   String sMonName = request.getParameter("MonName");

   long lStartTime = (new java.util.Date()).getTime();
   
   String sUser = session.getAttribute("USER").toString();   
   String sAppl = "PAYROLL";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
 && !session.getAttribute("APPLICATION").equals(sAppl))
{
   response.sendRedirect("SignOn1.jsp?TARGET=BfdgSchActQtrAllStr.jsp&APPL=" + sAppl + "&" + request.getQueryString());
}
else
{
    BfdgSchActQtrAllStr bdgwkall = new BfdgSchActQtrAllStr(sYear, sQuarter, sUser);
    int iNumOfReg = bdgwkall.getNumOfReg();
    String [] sReg = bdgwkall.getReg();
    String [] sRegNm = bdgwkall.getRegNm();
    int [] iRegStr = bdgwkall.getRegStr();


    int iNumOfStr = bdgwkall.getNumOfStr();
    String [] sStr = bdgwkall.getStr();
    String [] sStrNm = bdgwkall.getStrNm();
    int iStrNum = 0;
    int iGrpNum = 0;
    String [] sLineCell = null;
    String sWarnLine20 = null;
    String sWarnLine21 = null;
    String sWarnLine23 = null;

    String sPassedWkend = bdgwkall.getPassedWkend();
    String Str55ActProcPy = null;
%>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
</style>
<html>
<head><Meta http-equiv="refresh"></head>


<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top ;font-size:12px }
        th.DataTable2 { background:#FFCC99; white-space: nowrap; padding-top:3px; padding-bottom:3px;
                       writing-mode: tb-rl; filter: flipv fliph; text-align:left; font-size:12px }
        th.DataTable3 { background:#ccffcc; padding-top:3px; padding-bottom:3px; font-size:12px }
        th.DataTable4 { background:#ccccff; padding-top:3px; padding-bottom:3px; font-size:12px }
        th.DataTable5 { background:#ccffcc; writing-mode: tb-rl; filter: flipv fliph;
                        padding-left:1px; padding-right:1px; padding-top:10px;
                        font-size:12px; text-align:left;}
        th.DataTable6 { background:#FFCC99; text-align:center; vertical-align:top ;font-size:10px }

        tr.DataTable { background: white; font-size:10px }
        tr.Divdr1 { background: darkred; font-size:1px }
        tr.DataTable2 { background: #ccccff; font-size:10px }
        tr.DataTable3 { background: #ccffcc; font-size:10px }
        tr.DataTable31 { background: #ffff99; font-size:10px }
        tr.DataTable32 { background: gold; font-size:10px }
        tr.DataTable33 { background: white; font-size:10px }
        tr.DataTable4 { color:Maroon; background: Khaki; font-size:10px }
        tr.DataTable5 { background: cornsilk; font-size:10px }


        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }

        td.DataTable01 { background: yellow; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }

        td.DataTable02 { background: Khaki; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }

        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable21 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}
        td.DataTable22 {  background: azure; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}

        td.DataTable2p { background: #d0d0d0; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2g { background:lightgreen; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2r { background:red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

        td.DataTable210 { background: lightgreen; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}
        td.DataTable211 { background: pink; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}

        td.DataTable3 { background: black; font-size:12px }

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvEmpList { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvSlsGoal { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon;
              text-align:center; font-size:10px}

        div.dvHelp { position:absolute; visibility:hidden; background-attachment: scroll;
               width:150; background-color:LemonChiffon; z-index:10;
              text-align:left; font-size:12px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

</style>
<html>
<head><Meta http-equiv="refresh"></head>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variables
//==============================================================================
var GrpBdg = new Array();
var GrpBdgName = new Array();
var GrpBdgHrs = new Array();
var GrpBdgPayReg = new Array();
var GrpBdgPayCom = new Array();
var GrpBdgPayLSpiff = new Array();
var GrpBdgPayMSpiff = new Array();
var GrpBdgPayOther = new Array();
var GrpBdgPay = new Array();
var GrpBdgAvgPay = new Array();
var GrpBdgAvgCom = new Array();
var GrpBdgAvgLSpiff = new Array();
var GrpBdgAvgMSpiff = new Array();
var GrpBdgAvgOther = new Array();
var GrpBdgAvg = new Array();
var NumOfGrp = 0;

var ActEmpGrpName = new Array();
var ActEmpGrpHrs = new Array();
var ActEmpGrpPay = new Array();
var ActEmpGrpCom = new Array();
var ActEmpGrpLSpiff = new Array();
var ActEmpGrpMSpiff = new Array();
var ActEmpGrpTot = new Array();
var ActEmpGrpAvgPay = new Array();
var ActEmpGrpAvgCom = new Array();
var ActEmpGrpAvgLSpiff = new Array();
var ActEmpGrpAvgMSpiff = new Array();
var ActEmpGrpAvgTot = new Array();
var ActEmpGrpSlsRet = new Array();
var ActEmpGrpIncPay = new Array();
var ActEmpGrpAvgIncPay = new Array();

//==============================================================================
// initializing process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvEmpList"]);
}
//==============================================================================
// show Employee actual hours and payments
//==============================================================================
function showGrpBdg(arg, str)
{
  var hdr = "Payroll Dollars<br>Store: " + str;
  if (str == "REG"){ hdr = "Payroll Dollars<br>Region Total"}
  else if (str == "COMP"){ hdr = "Payroll Dollars<br>Company Total"}

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popGrpBdgPanel(arg)

   html += "</td></tr></table>"

   document.all.dvEmpList.innerHTML = html;
   document.all.dvEmpList.style.width = 250;
   document.all.dvEmpList.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvEmpList.style.pixelTop= document.documentElement.scrollTop + 10;
   document.all.dvEmpList.style.visibility = "visible";
}
//==============================================================================
// populate Column Panel
//==============================================================================
function popGrpBdgPanel(str)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
  panel += "<tr class='DataTable2'>"
             + "<th class='DataTable3' rowspan=2 nowrap>Group</th>"
             + "<th class='DataTable3' colspan=7 nowrap>Budget</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp</th>"
             + "<th class='DataTable3' colspan=7 nowrap>Actual/Schedule</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp</th>"
             + "<th class='DataTable3' colspan=7 rowspan=2 nowrap>Sales<br>Retail</th>"
         + "</tr>"
         + "<tr class='DataTable2'>"
             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"

             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"
         + "</tr>"

  for(var  i=0, j=0; i < GrpBdg[str].length; i++)
  {
       if (GrpBdgName[str][i].indexOf("Total") >= 0) {  panel += "<tr class='DataTable32'>" }
       else {  panel += "<tr class='DataTable3'>" }

       j = getActEmpGrpArg(str, GrpBdgName[str][i]);

       panel += "<td class='DataTable1' nowrap>" + GrpBdgName[str][i] + "</td>"
             + "<td class='DataTable2' nowrap>" + GrpBdgHrs[str][i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgPayReg[str][i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgPayCom[str][i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgPayLSpiff[str][i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgPayMSpiff[str][i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgPayOther[str][i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgPay[str][i] + "</td>"
             + "<th class='DataTable3' nowrap>&nbsp</th>"
             + "<td class='DataTable' nowrap>" + ActEmpGrpHrs[str][j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpPay[str][j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpCom[str][j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpLSpiff[str][j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpMSpiff[str][j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpIncPay[str][j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpTot[str][j] + "</td>"
             + "<th class='DataTable3' nowrap>&nbsp</th>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpSlsRet[str][j] + "</td>"
         + "</tr>"

  }

  panel += "<tr><td class='Prompt1' colspan=17>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}

//==============================================================================
// show Employee actual hours and payments
//==============================================================================
function showGrpBdgAvg(arg, str)
{
  var hdr = "Average Rate<br>Store: " + str;
  if (str == "REG"){ hdr = "Average Rate<br>Region Total"}
  else if (str == "COMP"){ hdr = "Average Rate<br>Company Total"}

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popGrpBdgAvgPanel(arg)

   html += "</td></tr></table>"

   document.all.dvEmpList.innerHTML = html;
   document.all.dvEmpList.style.width = 250;
   document.all.dvEmpList.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvEmpList.style.pixelTop= document.documentElement.scrollTop + 10;
   document.all.dvEmpList.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Column Panel
//--------------------------------------------------------
function popGrpBdgAvgPanel(arg)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
  panel += "<tr class='DataTable2'>"
             + "<th class='DataTable3' rowspan=2 nowrap>Group</th>"
             + "<th class='DataTable3' colspan=7 nowrap>Budget</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp</th>"
             + "<th class='DataTable3' colspan=7 nowrap>Actual/Schedule</th>"
         + "</tr>"
         + "<tr class='DataTable2'>"
             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"

             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"
         + "</tr>"

  for(var  i=0, j=0; i < GrpBdg[arg].length; i++)
  {
       if (GrpBdgName[arg][i].indexOf("Total") >= 0) {  panel += "<tr class='DataTable32'>" }
       else {  panel += "<tr class='DataTable3'>" }

       j = getActEmpGrpArg(arg, GrpBdgName[arg][i]);

       panel += "<td class='DataTable1' nowrap>" + GrpBdgName[arg][i] + "</td>"
             + "<td class='DataTable2' nowrap>" + GrpBdgHrs[arg][i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvgPay[arg][i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvgCom[arg][i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvgLSpiff[arg][i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvgMSpiff[arg][i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvgOther[arg][i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvg[arg][i] + "</td>"
             + "<th class='DataTable3' nowrap>&nbsp</th>"
             + "<td class='DataTable2' nowrap>" + ActEmpGrpHrs[arg][j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgPay[arg][j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgCom[arg][j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgLSpiff[arg][j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgMSpiff[arg][j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgIncPay[arg][j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgTot[arg][j] + "</td>"
         + "</tr>"

  }

  panel += "<tr><td class='Prompt1' colspan=17>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//--------------------------------------------------------
// get actual employee group argument
//--------------------------------------------------------
function getActEmpGrpArg(str, grp)
{
   var arg = 0;
   var found = false;
   var max = ActEmpGrpName.length;

   for(var  i=0; i < max; i++)
   {
      if(grp == ActEmpGrpName[str][i]){ arg = i; found = true;}
   }
   if(!found)
   {
      ActEmpGrpName[str][max] = grp;
      ActEmpGrpHrs[str][max] = 0;
      ActEmpGrpPay[str][max] = 0;
      ActEmpGrpCom[str][max] = 0;
      ActEmpGrpLSpiff[str][max] = 0;
      ActEmpGrpMSpiff[str][max] = 0;
      ActEmpGrpTot[str][max] = 0;
      ActEmpGrpAvgPay[str][max] = 0;
      ActEmpGrpAvgCom[str][max] = 0;
      ActEmpGrpAvgLSpiff[str][max] = 0;
      ActEmpGrpAvgMSpiff[str][max] = 0;
      ActEmpGrpAvgTot[str][max] = 0;
      ActEmpGrpSlsRet[str][max] = 0;
      ActEmpGrpIncPay[str][max] = 0;
      ActEmpGrpAvgIncPay[str][max] = 0;
      arg = max;
   }

   return arg;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvEmpList.innerHTML = " ";
   document.all.dvEmpList.style.visibility = "hidden";
}

</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>



<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvEmpList" class="dvEmpList"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
   <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
      <br>Quarterly Budget vs. Schedule and Actual Payroll (New Schedule)
      <br>Quarter: <%=sQuarter%>/<%=sYear%> (thru w/e <%=sPassedWkend%>)
      </b>

      <br><br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <a href="BfdgSchActWkSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;

      <table border=1 cellPadding="0" cellSpacing="0" >
        <tr>
          <th colspan=12></th>
          <th class="DataTable3" colspan=20>Hourly Employee Only (Excludes Holiday, Sick, Vacation and TMC.)</th>
        </tr>
        <tr>
          <th colspan=3></th>
          <th class="DataTable4" colspan=6>Sales</th>
          <th colspan=3></th>
          <th class="DataTable4" colspan=7>P/R Hours</th>
          <th></th>
          <th class="DataTable4" colspan=3>P/R $'s</th>
          <th class="DataTable4" colspan=3>Hourly Rate</th>
          <th></th>
          <th class="DataTable4" colspan=5>Variance</th>
          <th></th>
          <th class="DataTable4" colspan=6>T/M/C</th>
          <th></th>
          <th class="DataTable4" colspan=5>Actual Processed Payroll</th>
        </tr>
        <tr>
          <th class="DataTable" rowspan=2>Reg</th>
          <th class="DataTable" rowspan=2>Store</th>
          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="DataTable2" nowrap>Original Sales Plan</th>
          <th class="DataTable2">Sales Forecast Trend Rate</th>
          <th class="DataTable2">Sales Forecast</th>
          <th class="DataTable2">Sales Forecast Dollars +/-</th>
          <th class="DataTable2">Sales Actual / Forecast </th>
          <th class="DataTable2">Sales Actual / Forecast Dollars +/-</th>
          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="DataTable5" rowspan=2>Bdg vs Act $'s</th>
          <th class="DataTable5" rowspan=2>Bdg vs Act Avg Rate</th>
          <th class="DataTable2">Original Budget Hours</th>
          <th class="DataTable2">Hours Earned</th>
          <th class="DataTable2">Hours Earned (Based on Sales / Sal Emp on V or H)</th>
          <th class="DataTable2">Allowable Budget Hours</th>
          <th class="DataTable2">Actual Hrs. / Adjusted Hrs. To Reach Allowable Budget</th>
          <th class="DataTable2">Actual Hrs. / Adjusted Hrs. To Reach Allowable Budget</th>
          <th class="DataTable2">Hours Actual / Scheduled</th>
          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="DataTable2">Original Payroll Budget Dollars </th>
          <th class="DataTable2">Allowable Budget Dollars</th>
          <th class="DataTable2">Hourly Payroll $ Actual / Scheduled </th>
          <th class="DataTable2">Original Budgeted Average Hourly Rate</th>
          <th class="DataTable2">Allowable Budgeted Average Hourly Rate</th>
          <th class="DataTable2">Actual / Scheduled Average Hourly Rate</th>
          <th class="DataTable" rowspan=2>&nbsp;</th>
          <th class="DataTable2">Actual / Scheduled Hours +/- Allowable Budget</th>
          <th class="DataTable2">Actual / Scheduled Dollars +/- Allowable Budget</th>
          <th class="DataTable2">Original Budget Payroll % To Original Sales Plan</th>
          <th class="DataTable2">Actual / Scheduled Payroll % To Actual / Forecast Sales</th>
          <th class="DataTable2">Allowable Budget Payroll % To Actual / Forecast Sales</th>

          <th class="DataTable" rowspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>

          <th class="DataTable2">Budget Hours - Training/Meeting/Clinics</th>
          <th class="DataTable2">Hours Scheduled - TMC</th>
          <th class="DataTable2">Hours Actual - TMC</th>
          <th class="DataTable2">Payroll Budget $'s - TMC</th>
          <th class="DataTable2">Hours Payroll $'s/Scheduled - TMC</th>
          <th class="DataTable2">Hours Payroll $'s/Actual - TMC</th>

          <th class="DataTable" rowspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>

          <th class="DataTable2">Hours</th>
          <th class="DataTable2">Hourly Payroll (Daily/Cumulative)</th>
          <th class="DataTable2">Average Hourly Rate</th>
          <th class="DataTable2">Memo: Challenge</th>
          <th class="DataTable2">Actual Calculated & Processed +/-</th>
        </tr>
        <tr>
            <th class="DataTable">2</th>
            <th class="DataTable">3</th>
            <th class="DataTable">4</th>
            <th class="DataTable">5</th>
            <th class="DataTable">6</th>
            <th class="DataTable">7</th>

            <th class="DataTable">9</th>
            <th class="DataTable">10a</th>
            <th class="DataTable">10b</th>
            <th class="DataTable">11</th>
            <th class="DataTable">12</th>
            <th class="DataTable">13</th>
            <th class="DataTable">14</th>

            <th class="DataTable">15</th>
            <th class="DataTable">16</th>
            <th class="DataTable">17</th>
            <th class="DataTable">18</th>
            <th class="DataTable">19</th>
            <th class="DataTable">20</th>

            <th class="DataTable">21</th>
            <th class="DataTable">22</th>
            <th class="DataTable">23</th>
            <th class="DataTable">24</th>
            <th class="DataTable">25</th>

            <th class="DataTable">1</th>
            <th class="DataTable">2a</th>
            <th class="DataTable">2b</th>
            <th class="DataTable">3</th>
            <th class="DataTable">4a</th>
            <th class="DataTable">4b</th>

            <th class="DataTable">14</th>
            <th class="DataTable">17</th>
            <th class="DataTable">19</th>
            <th class="DataTable">&nbsp;</th>
            <th class="DataTable">&nbsp;</th>
        </tr>

     <tr class="Divdr1"></td><td colspan=45>&nbsp;</td></tr>
     <!------------------------- Region --------------------------------------->
     <%for(int i=0; i < iNumOfReg; i++){%>
        <tr class="DataTable">
           <th class="DataTable3" rowspan="<%=iRegStr[i] + 1%>"><%=sReg[i]%></th>

        <!-- ------------------- Stores --------------------------------------->
        <%for(int j=0; j < iRegStr[i]; j++, iStrNum++)
          {
             bdgwkall.setStrBdgInfo();
             sLineCell = bdgwkall.getLineCell();
             sWarnLine20 = bdgwkall.getWarnLine20();
             sWarnLine23 = bdgwkall.getWarnLine23();
             sWarnLine21 = bdgwkall.getWarnLine21();

             // List of budget groups
             bdgwkall.setGrpBdg("S");
             int iNumOfGrpBdg = bdgwkall.getNumOfGrpBdg();
             String sGrpBdg = bdgwkall.getGrpBdgJsa();
             String sGrpBdgName = bdgwkall.getGrpBdgNameJsa();
             String sGrpBdgHrs = bdgwkall.getGrpBdgHrsJsa();

             String sGrpBdgPayReg = bdgwkall.getGrpBdgPayRegJsa();
             String sGrpBdgPayCom = bdgwkall.getGrpBdgPayComJsa();
             String sGrpBdgPayLSpiff = bdgwkall.getGrpBdgPayLSpiffJsa();
             String sGrpBdgPayMSpiff = bdgwkall.getGrpBdgPayMSpiffJsa();
             String sGrpBdgPayOther = bdgwkall.getGrpBdgPayOtherJsa();
             String sGrpBdgPay = bdgwkall.getGrpBdgPayJsa();

             String sGrpBdgAvgPay = bdgwkall.getGrpBdgAvgPayJsa();
             String sGrpBdgAvgCom = bdgwkall.getGrpBdgAvgComJsa();
             String sGrpBdgAvgLSpiff = bdgwkall.getGrpBdgAvgLSpiffJsa();
             String sGrpBdgAvgMSpiff = bdgwkall.getGrpBdgAvgMSpiffJsa();
             String sGrpBdgAvgOther = bdgwkall.getGrpBdgAvgOtherJsa();
             String sGrpBdgAvg = bdgwkall.getGrpBdgAvgJsa();

             // Actual Employee Budget Group totals
             bdgwkall.setActEmpGrp("S");
             String sActEmpGrpName = bdgwkall.getActEmpGrpNameJsa();
             String sActEmpGrpHrs = bdgwkall.getActEmpGrpHrsJsa();
             String sActEmpGrpPay = bdgwkall.getActEmpGrpPayJsa();
             String sActEmpGrpCom = bdgwkall.getActEmpGrpComJsa();
             String sActEmpGrpLSpiff = bdgwkall.getActEmpGrpLSpiffJsa();
             String sActEmpGrpMSpiff = bdgwkall.getActEmpGrpMSpiffJsa();
             String sActEmpGrpTot = bdgwkall.getActEmpGrpTotJsa();
             String sActEmpGrpAvgPay = bdgwkall.getActEmpGrpAvgPayJsa();
             String sActEmpGrpAvgCom = bdgwkall.getActEmpGrpAvgComJsa();
             String sActEmpGrpAvgLSpiff = bdgwkall.getActEmpGrpAvgLSpiffJsa();
             String sActEmpGrpAvgMSpiff = bdgwkall.getActEmpGrpAvgMSpiffJsa();
             String sActEmpGrpAvgTot = bdgwkall.getActEmpGrpAvgTotJsa();
             String sActEmpGrpSlsRet = bdgwkall.getActEmpGrpSlsRetJsa();
             String sActEmpGrpIncPay = bdgwkall.getActEmpGrpIncPayJsa();
             String sActEmpGrpAvgIncPay = bdgwkall.getActEmpGrpAvgIncPayJsa();
             
             if(sStr[iStrNum].equals("55"))
             {
            	 Str55ActProcPy = sLineCell[28];
             }
        %>
            <%if(j > 0){%><tr class="DataTable"><%}%>

            <td class="DataTable"><a href="BfdgSchActQtr.jsp?Store=<%=sStr[iStrNum]%>&Year=<%=sYear%>&Qtr=<%=sQuarter%>" target="_blank"><%=sStr[iStrNum]%></a></td>
            <th class="DataTable">&nbsp;</th>

            <!-- Sales -->
            <td class="DataTable">$<%=sLineCell[0]%></td>
            <td class="DataTable" nowrap><%=sLineCell[1]%>%</td>
            <td class="DataTable" nowrap>$<%=sLineCell[2]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[3]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[4]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[5]%></td>

            <th class="DataTable">&nbsp;</th>
            <th class="DataTable3"><a href="javascript: showGrpBdg('<%=iGrpNum%>', '<%=sStr[iStrNum]%>')">B</a></th>
            <th class="DataTable3"><a href="javascript: showGrpBdgAvg('<%=iGrpNum++%>', '<%=sStr[iStrNum]%>')">A</a></th>

            <!-- Hourly Employee Only (Excludes Holiday, Sick, Vacation and TMC.) -->
            <!-- P/R Hours -->
            <td class="DataTable01"><%=sLineCell[6]%></td>
            <td class="DataTable"><%=sLineCell[7]%></td>
            <td class="DataTable"><%=sLineCell[36]%></td>
            <td class="DataTable"><%=sLineCell[8]%></td>
            <td class="DataTable02"><%=sLineCell[9]%></td>
            <td class="DataTable02"><%=sLineCell[10]%></td>
            <td class="DataTable"><%=sLineCell[11]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- P/R $'s -->
            <td class="DataTable">$<%=sLineCell[12]%></td>
            <td class="DataTable">$<%=sLineCell[13]%></td>
            <td class="DataTable">$<%=sLineCell[14]%></td>

            <!-- Hourly Rate -->
            <td class="DataTable">$<%=sLineCell[15]%></td>
            <td class="DataTable">$<%=sLineCell[16]%></td>
            <td class="DataTable">$<%=sLineCell[17]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- Variance -->
            <td class="DataTable2<%if(sWarnLine20.equals("1")){%>r<%} else {%>g<%}%>"><%=sLineCell[18]%></td>
            <td class="DataTable2<%if(sWarnLine21.equals("1")){%>r<%} else {%>g<%}%>">$<%=sLineCell[19]%></td>
            <td class="DataTable"><%=sLineCell[20]%></td>
            <td class="DataTable2<%if(sWarnLine23.equals("1")){%>r<%} else {%>g<%}%>"><%=sLineCell[21]%></td>
            <td class="DataTable"><%=sLineCell[22]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- T/M/C -->
            <td class="DataTable"><%=sLineCell[23]%></td>
            <!-- td class="DataTable"><%=sLineCell[24]%></td -->
            <td class="DataTable"><%=sLineCell[32]%></td>
            <td class="DataTable"><%=sLineCell[34]%></td>
            <td class="DataTable">$<%=sLineCell[25]%></td>
            <!-- td class="DataTable"><%=sLineCell[26]%></td -->
            <td class="DataTable">$<%=sLineCell[33]%></td>
            <td class="DataTable">$<%=sLineCell[35]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- Actual Processed Payroll -->
            <td class="DataTable"><%=sLineCell[27]%></td>
            <td class="DataTable"><%=sLineCell[28]%></td>
            <td class="DataTable"><%=sLineCell[29]%></td>
            <td class="DataTable"><%=sLineCell[30]%></td>
            <td class="DataTable" nowrap><%=sLineCell[31]%></td>

            <script>
               GrpBdg[NumOfGrp] = [<%=sGrpBdg%>]; GrpBdgName[NumOfGrp] = [<%=sGrpBdgName%>]; GrpBdgHrs[NumOfGrp] = [<%=sGrpBdgHrs%>];
               GrpBdgPayReg[NumOfGrp] = [<%=sGrpBdgPayReg%>]; GrpBdgPayCom[NumOfGrp] = [<%=sGrpBdgPayCom%>];
               GrpBdgPayLSpiff[NumOfGrp] = [<%=sGrpBdgPayLSpiff%>]; GrpBdgPayMSpiff[NumOfGrp] = [<%=sGrpBdgPayMSpiff%>];
               GrpBdgPayOther[NumOfGrp] = [<%=sGrpBdgPayOther%>]; GrpBdgPay[NumOfGrp] = [<%=sGrpBdgPay%>];
               GrpBdgAvgPay[NumOfGrp] = [<%=sGrpBdgAvgPay%>]; GrpBdgAvgCom[NumOfGrp] = [<%=sGrpBdgAvgCom%>];
               GrpBdgAvgLSpiff[NumOfGrp] = [<%=sGrpBdgAvgLSpiff%>]; GrpBdgAvgMSpiff[NumOfGrp] = [<%=sGrpBdgAvgMSpiff%>];
               GrpBdgAvgOther[NumOfGrp] = [<%=sGrpBdgAvgOther%>]; GrpBdgAvg[NumOfGrp] = [<%=sGrpBdgAvg%>];

               ActEmpGrpName[NumOfGrp] = [<%=sActEmpGrpName%>]; ActEmpGrpHrs[NumOfGrp] = [<%=sActEmpGrpHrs%>];
               ActEmpGrpPay[NumOfGrp] = [<%=sActEmpGrpPay%>]; ActEmpGrpCom[NumOfGrp] = [<%=sActEmpGrpCom%>];
               ActEmpGrpLSpiff[NumOfGrp] = [<%=sActEmpGrpLSpiff%>]; ActEmpGrpMSpiff[NumOfGrp] = [<%=sActEmpGrpMSpiff%>];
               ActEmpGrpTot[NumOfGrp] = [<%=sActEmpGrpTot%>]; ActEmpGrpAvgPay[NumOfGrp] = [<%=sActEmpGrpAvgPay%>];
               ActEmpGrpAvgCom[NumOfGrp] = [<%=sActEmpGrpAvgCom%>]; ActEmpGrpAvgLSpiff[NumOfGrp] = [<%=sActEmpGrpAvgLSpiff%>];
               ActEmpGrpAvgMSpiff[NumOfGrp] = [<%=sActEmpGrpAvgMSpiff%>]; ActEmpGrpAvgTot[NumOfGrp] = [<%=sActEmpGrpAvgTot%>];
               ActEmpGrpSlsRet[NumOfGrp] = [<%=sActEmpGrpSlsRet%>]; ActEmpGrpIncPay[NumOfGrp] = [<%=sActEmpGrpIncPay%>];
               ActEmpGrpAvgIncPay[NumOfGrp] = [<%=sActEmpGrpAvgIncPay%>];
               NumOfGrp++;
            </script>
           </tr>
        <%}%>

        <!-- ======== Region totals ========== -->
        <%
          bdgwkall.setRegBdgInfo();
          sLineCell = bdgwkall.getLineCell();
          sWarnLine20 = bdgwkall.getWarnLine20();
          sWarnLine23 = bdgwkall.getWarnLine23();
          sWarnLine21= bdgwkall.getWarnLine21();

          // List of budget groups
          bdgwkall.setGrpBdg("R");
          int iNumOfGrpBdg = bdgwkall.getNumOfGrpBdg();
          String sGrpBdg = bdgwkall.getGrpBdgJsa();
          String sGrpBdgName = bdgwkall.getGrpBdgNameJsa();
          String sGrpBdgHrs = bdgwkall.getGrpBdgHrsJsa();

          String sGrpBdgPayReg = bdgwkall.getGrpBdgPayRegJsa();
          String sGrpBdgPayCom = bdgwkall.getGrpBdgPayComJsa();
          String sGrpBdgPayLSpiff = bdgwkall.getGrpBdgPayLSpiffJsa();
          String sGrpBdgPayMSpiff = bdgwkall.getGrpBdgPayMSpiffJsa();
          String sGrpBdgPayOther = bdgwkall.getGrpBdgPayOtherJsa();
          String sGrpBdgPay = bdgwkall.getGrpBdgPayJsa();

          String sGrpBdgAvgPay = bdgwkall.getGrpBdgAvgPayJsa();
          String sGrpBdgAvgCom = bdgwkall.getGrpBdgAvgComJsa();
          String sGrpBdgAvgLSpiff = bdgwkall.getGrpBdgAvgLSpiffJsa();
          String sGrpBdgAvgMSpiff = bdgwkall.getGrpBdgAvgMSpiffJsa();
          String sGrpBdgAvgOther = bdgwkall.getGrpBdgAvgOtherJsa();
          String sGrpBdgAvg = bdgwkall.getGrpBdgAvgJsa();

          // Actual Employee Budget Group totals
          bdgwkall.setActEmpGrp("R");
          String sActEmpGrpName = bdgwkall.getActEmpGrpNameJsa();
          String sActEmpGrpHrs = bdgwkall.getActEmpGrpHrsJsa();
          String sActEmpGrpPay = bdgwkall.getActEmpGrpPayJsa();
          String sActEmpGrpCom = bdgwkall.getActEmpGrpComJsa();
          String sActEmpGrpLSpiff = bdgwkall.getActEmpGrpLSpiffJsa();
          String sActEmpGrpMSpiff = bdgwkall.getActEmpGrpMSpiffJsa();
          String sActEmpGrpTot = bdgwkall.getActEmpGrpTotJsa();
          String sActEmpGrpAvgPay = bdgwkall.getActEmpGrpAvgPayJsa();
          String sActEmpGrpAvgCom = bdgwkall.getActEmpGrpAvgComJsa();
          String sActEmpGrpAvgLSpiff = bdgwkall.getActEmpGrpAvgLSpiffJsa();
          String sActEmpGrpAvgMSpiff = bdgwkall.getActEmpGrpAvgMSpiffJsa();
          String sActEmpGrpAvgTot = bdgwkall.getActEmpGrpAvgTotJsa();
          String sActEmpGrpSlsRet = bdgwkall.getActEmpGrpSlsRetJsa();
          String sActEmpGrpIncPay = bdgwkall.getActEmpGrpIncPayJsa();
          String sActEmpGrpAvgIncPay = bdgwkall.getActEmpGrpAvgIncPayJsa();
        %>

        <tr class="DataTable5">
        <td class="DataTable">Region Totals</td>
            <th class="DataTable">&nbsp;</th>

            <!-- Sales -->
            <td class="DataTable">$<%=sLineCell[0]%></td>
            <td class="DataTable" nowrap><%=sLineCell[1]%>%</td>
            <td class="DataTable" nowrap>$<%=sLineCell[2]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[3]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[4]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[5]%></td>

            <th class="DataTable">&nbsp;</th>
            <th class="DataTable3"><a href="javascript: showGrpBdg('<%=iGrpNum%>', 'REG')">B</a></th>
            <th class="DataTable3"><a href="javascript: showGrpBdgAvg('<%=iGrpNum++%>', 'REG')">A</a></th>

            <!-- Hourly Employee Only (Excludes Holiday, Sick, Vacation and TMC.) -->
            <!-- P/R Hours -->
            <td class="DataTable01"><%=sLineCell[6]%></td>
            <td class="DataTable"><%=sLineCell[7]%></td>
            <td class="DataTable"><%=sLineCell[36]%></td>
            <td class="DataTable"><%=sLineCell[8]%></td>
            <td class="DataTable02"><%=sLineCell[9]%></td>
            <td class="DataTable02"><%=sLineCell[10]%></td>
            <td class="DataTable"><%=sLineCell[11]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- P/R $'s -->
            <td class="DataTable">$<%=sLineCell[12]%></td>
            <td class="DataTable">$<%=sLineCell[13]%></td>
            <td class="DataTable">$<%=sLineCell[14]%></td>

            <!-- Hourly Rate -->
            <td class="DataTable">$<%=sLineCell[15]%></td>
            <td class="DataTable">$<%=sLineCell[16]%></td>
            <td class="DataTable">$<%=sLineCell[17]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- Variance -->
            <td class="DataTable2<%if(sWarnLine20.equals("1")){%>r<%} else {%>g<%}%>"><%=sLineCell[18]%></td>
            <td class="DataTable2<%if(sWarnLine21.equals("1")){%>r<%} else {%>g<%}%>">$<%=sLineCell[19]%></td>
            <td class="DataTable"><%=sLineCell[20]%></td>
            <td class="DataTable2<%if(sWarnLine23.equals("1")){%>r<%} else {%>g<%}%>"><%=sLineCell[21]%></td>
            <td class="DataTable"><%=sLineCell[22]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- T/M/C -->
            <td class="DataTable"><%=sLineCell[23]%></td>
            <!-- td class="DataTable"><%=sLineCell[24]%></td -->
            <td class="DataTable"><%=sLineCell[32]%></td>
            <td class="DataTable"><%=sLineCell[34]%></td>
            <td class="DataTable">$<%=sLineCell[25]%></td>
            <!-- td class="DataTable"><%=sLineCell[26]%></td -->
            <td class="DataTable">$<%=sLineCell[33]%></td>
            <td class="DataTable">$<%=sLineCell[35]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- Actual Processed Payroll -->
            <td class="DataTable"><%=sLineCell[27]%></td>
            <td class="DataTable"><%=sLineCell[28]%></td>
            <td class="DataTable"><%=sLineCell[29]%></td>
            <td class="DataTable"><%=sLineCell[30]%></td>
            <td class="DataTable" nowrap><%=sLineCell[31]%></td>

        </tr>
        <tr class="Divdr1"></td><td colspan=45>&nbsp;</td></tr>
        <tr>
            <th class="DataTable6" colspan=3>&nbsp;</th>
            <th class="DataTable6">2</th>
            <th class="DataTable6">3</th>
            <th class="DataTable6">4</th>
            <th class="DataTable6">5</th>
            <th class="DataTable6">6</th>
            <th class="DataTable6">7</th>

            <th class="DataTable6" colspan=3>&nbsp;</th>

            <th class="DataTable6">9</th>
            <th class="DataTable6">10a</th>
            <th class="DataTable6">10b</th>
            <th class="DataTable6">11</th>
            <th class="DataTable6">12</th>
            <th class="DataTable6">13</th>
            <th class="DataTable6">14</th>

            <th class="DataTable6">&nbsp;</th>

            <th class="DataTable6">15</th>
            <th class="DataTable6">16</th>
            <th class="DataTable6">17</th>
            <th class="DataTable6">18</th>
            <th class="DataTable6">19</th>
            <th class="DataTable6">20</th>

            <th class="DataTable6">&nbsp;</th>

            <th class="DataTable6">21</th>
            <th class="DataTable6">22</th>
            <th class="DataTable6">23</th>
            <th class="DataTable6">24</th>
            <th class="DataTable6">25</th>

            <th class="DataTable6">&nbsp;</th>

            <th class="DataTable6">1</th>
            <th class="DataTable6">2a</th>
            <th class="DataTable6">2b</th>
            <th class="DataTable6">3</th>
            <th class="DataTable6">4a</th>
            <th class="DataTable6">4b</th>

            <th class="DataTable6">&nbsp;</th>

            <th class="DataTable6">14</th>
            <th class="DataTable6">17</th>
            <th class="DataTable6">19</th>
            <th class="DataTable6">&nbsp;</th>
            <th class="DataTable6">&nbsp;</th>
        </tr>
        <tr class="Divdr1"></td><td colspan=45>&nbsp;</td></tr>

        <script>
               GrpBdg[NumOfGrp] = [<%=sGrpBdg%>]; GrpBdgName[NumOfGrp] = [<%=sGrpBdgName%>]; GrpBdgHrs[NumOfGrp] = [<%=sGrpBdgHrs%>];
               GrpBdgPayReg[NumOfGrp] = [<%=sGrpBdgPayReg%>]; GrpBdgPayCom[NumOfGrp] = [<%=sGrpBdgPayCom%>];
               GrpBdgPayLSpiff[NumOfGrp] = [<%=sGrpBdgPayLSpiff%>]; GrpBdgPayMSpiff[NumOfGrp] = [<%=sGrpBdgPayMSpiff%>];
               GrpBdgPayOther[NumOfGrp] = [<%=sGrpBdgPayOther%>]; GrpBdgPay[NumOfGrp] = [<%=sGrpBdgPay%>];
               GrpBdgAvgPay[NumOfGrp] = [<%=sGrpBdgAvgPay%>]; GrpBdgAvgCom[NumOfGrp] = [<%=sGrpBdgAvgCom%>];
               GrpBdgAvgLSpiff[NumOfGrp] = [<%=sGrpBdgAvgLSpiff%>]; GrpBdgAvgMSpiff[NumOfGrp] = [<%=sGrpBdgAvgMSpiff%>];
               GrpBdgAvgOther[NumOfGrp] = [<%=sGrpBdgAvgOther%>]; GrpBdgAvg[NumOfGrp] = [<%=sGrpBdgAvg%>];

               ActEmpGrpName[NumOfGrp] = [<%=sActEmpGrpName%>]; ActEmpGrpHrs[NumOfGrp] = [<%=sActEmpGrpHrs%>];
               ActEmpGrpPay[NumOfGrp] = [<%=sActEmpGrpPay%>]; ActEmpGrpCom[NumOfGrp] = [<%=sActEmpGrpCom%>];
               ActEmpGrpLSpiff[NumOfGrp] = [<%=sActEmpGrpLSpiff%>]; ActEmpGrpMSpiff[NumOfGrp] = [<%=sActEmpGrpMSpiff%>];
               ActEmpGrpTot[NumOfGrp] = [<%=sActEmpGrpTot%>]; ActEmpGrpAvgPay[NumOfGrp] = [<%=sActEmpGrpAvgPay%>];
               ActEmpGrpAvgCom[NumOfGrp] = [<%=sActEmpGrpAvgCom%>]; ActEmpGrpAvgLSpiff[NumOfGrp] = [<%=sActEmpGrpAvgLSpiff%>];
               ActEmpGrpAvgMSpiff[NumOfGrp] = [<%=sActEmpGrpAvgMSpiff%>]; ActEmpGrpAvgTot[NumOfGrp] = [<%=sActEmpGrpAvgTot%>];
               ActEmpGrpSlsRet[NumOfGrp] = [<%=sActEmpGrpSlsRet%>]; ActEmpGrpIncPay[NumOfGrp] = [<%=sActEmpGrpIncPay%>];
               ActEmpGrpAvgIncPay[NumOfGrp] = [<%=sActEmpGrpAvgIncPay%>];
               NumOfGrp++;
        </script>
     <%}%>

     <tr class="Divdr1"></td><td colspan=45>&nbsp;</td></tr>
     <tr class="Divdr1"></td><td colspan=45>&nbsp;</td></tr>

     <!-- ======== Report totals ========== -->
     <%
          bdgwkall.setRepBdgInfo();
          sLineCell = bdgwkall.getLineCell();
          sWarnLine20 = bdgwkall.getWarnLine20();
          sWarnLine23 = bdgwkall.getWarnLine23();
          sWarnLine21 = bdgwkall.getWarnLine21();

          // List of budget groups
          bdgwkall.setGrpBdg("T");
          int iNumOfGrpBdg = bdgwkall.getNumOfGrpBdg();
          String sGrpBdg = bdgwkall.getGrpBdgJsa();
          String sGrpBdgName = bdgwkall.getGrpBdgNameJsa();
          String sGrpBdgHrs = bdgwkall.getGrpBdgHrsJsa();

          String sGrpBdgPayReg = bdgwkall.getGrpBdgPayRegJsa();
          String sGrpBdgPayCom = bdgwkall.getGrpBdgPayComJsa();
          String sGrpBdgPayLSpiff = bdgwkall.getGrpBdgPayLSpiffJsa();
          String sGrpBdgPayMSpiff = bdgwkall.getGrpBdgPayMSpiffJsa();
          String sGrpBdgPayOther = bdgwkall.getGrpBdgPayOtherJsa();
          String sGrpBdgPay = bdgwkall.getGrpBdgPayJsa();

          String sGrpBdgAvgPay = bdgwkall.getGrpBdgAvgPayJsa();
          String sGrpBdgAvgCom = bdgwkall.getGrpBdgAvgComJsa();
          String sGrpBdgAvgLSpiff = bdgwkall.getGrpBdgAvgLSpiffJsa();
          String sGrpBdgAvgMSpiff = bdgwkall.getGrpBdgAvgMSpiffJsa();
          String sGrpBdgAvgOther = bdgwkall.getGrpBdgAvgOtherJsa();
          String sGrpBdgAvg = bdgwkall.getGrpBdgAvgJsa();

          // Actual Employee Budget Group totals
          bdgwkall.setActEmpGrp("T");
          String sActEmpGrpName = bdgwkall.getActEmpGrpNameJsa();
          String sActEmpGrpHrs = bdgwkall.getActEmpGrpHrsJsa();
          String sActEmpGrpPay = bdgwkall.getActEmpGrpPayJsa();
          String sActEmpGrpCom = bdgwkall.getActEmpGrpComJsa();
          String sActEmpGrpLSpiff = bdgwkall.getActEmpGrpLSpiffJsa();
          String sActEmpGrpMSpiff = bdgwkall.getActEmpGrpMSpiffJsa();
          String sActEmpGrpTot = bdgwkall.getActEmpGrpTotJsa();
          String sActEmpGrpAvgPay = bdgwkall.getActEmpGrpAvgPayJsa();
          String sActEmpGrpAvgCom = bdgwkall.getActEmpGrpAvgComJsa();
          String sActEmpGrpAvgLSpiff = bdgwkall.getActEmpGrpAvgLSpiffJsa();
          String sActEmpGrpAvgMSpiff = bdgwkall.getActEmpGrpAvgMSpiffJsa();
          String sActEmpGrpAvgTot = bdgwkall.getActEmpGrpAvgTotJsa();
          String sActEmpGrpSlsRet = bdgwkall.getActEmpGrpSlsRetJsa();
          String sActEmpGrpIncPay = bdgwkall.getActEmpGrpIncPayJsa();
          String sActEmpGrpAvgIncPay = bdgwkall.getActEmpGrpAvgIncPayJsa();
     %>
     <tr class="DataTable5">
      <td class="DataTable" colspan=2>Company Totals</td>
          <th class="DataTable">&nbsp;</th>

            <!-- Sales -->
            <td class="DataTable">$<%=sLineCell[0]%></td>
            <td class="DataTable" nowrap><%=sLineCell[1]%>%</td>
            <td class="DataTable" nowrap>$<%=sLineCell[2]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[3]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[4]%></td>
            <td class="DataTable" nowrap>$<%=sLineCell[5]%></td>

            <th class="DataTable">&nbsp;</th>
            <th class="DataTable3"><a href="javascript: showGrpBdg('<%=iGrpNum%>', 'COMP')">B</a></th>
            <th class="DataTable3"><a href="javascript: showGrpBdgAvg('<%=iGrpNum++%>', 'COMP')">A</a></th>


            <!-- Hourly Employee Only (Excludes Holiday, Sick, Vacation and TMC.) -->
            <!-- P/R Hours -->
            <td class="DataTable01"><%=sLineCell[6]%></td>
            <td class="DataTable"><%=sLineCell[7]%></td>
            <td class="DataTable"><%=sLineCell[36]%></td>
            <td class="DataTable"><%=sLineCell[8]%></td>
            <td class="DataTable02"><%=sLineCell[9]%></td>
            <td class="DataTable02"><%=sLineCell[10]%></td>
            <td class="DataTable"><%=sLineCell[11]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- P/R $'s -->
            <td class="DataTable">$<%=sLineCell[12]%></td>
            <td class="DataTable">$<%=sLineCell[13]%></td>
            <td class="DataTable">$<%=sLineCell[14]%></td>

            <!-- Hourly Rate -->
            <td class="DataTable">$<%=sLineCell[15]%></td>
            <td class="DataTable">$<%=sLineCell[16]%></td>
            <td class="DataTable">$<%=sLineCell[17]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- Variance -->
            <td class="DataTable2<%if(sWarnLine20.equals("1")){%>r<%} else {%>g<%}%>"><%=sLineCell[18]%></td>
            <td class="DataTable2<%if(sWarnLine21.equals("1")){%>r<%} else {%>g<%}%>">$<%=sLineCell[19]%></td>
            <td class="DataTable"><%=sLineCell[20]%></td>
            <td class="DataTable2<%if(sWarnLine23.equals("1")){%>r<%} else {%>g<%}%>"><%=sLineCell[21]%></td>
            <td class="DataTable"><%=sLineCell[22]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- T/M/C -->
            <td class="DataTable"><%=sLineCell[23]%></td>
            <!-- td class="DataTable"><%=sLineCell[24]%></td -->
            <td class="DataTable"><%=sLineCell[32]%></td>
            <td class="DataTable"><%=sLineCell[34]%></td>
            <td class="DataTable">$<%=sLineCell[25]%></td>
            <!-- td class="DataTable"><%=sLineCell[26]%></td -->
            <td class="DataTable">$<%=sLineCell[33]%></td>
            <td class="DataTable">$<%=sLineCell[35]%></td>

            <th class="DataTable">&nbsp;</th>

            <!-- Actual Processed Payroll -->
            <td class="DataTable"><%=sLineCell[27]%></td>
            <td class="DataTable"><%=sLineCell[28]%></td>
            <td class="DataTable"><%=sLineCell[29]%></td>
            <td class="DataTable"><%=sLineCell[30]%></td>
            <td class="DataTable" nowrap><%=sLineCell[31]%></td>

          <script>
               GrpBdg[NumOfGrp] = [<%=sGrpBdg%>]; GrpBdgName[NumOfGrp] = [<%=sGrpBdgName%>]; GrpBdgHrs[NumOfGrp] = [<%=sGrpBdgHrs%>];
               GrpBdgPayReg[NumOfGrp] = [<%=sGrpBdgPayReg%>]; GrpBdgPayCom[NumOfGrp] = [<%=sGrpBdgPayCom%>];
               GrpBdgPayLSpiff[NumOfGrp] = [<%=sGrpBdgPayLSpiff%>]; GrpBdgPayMSpiff[NumOfGrp] = [<%=sGrpBdgPayMSpiff%>];
               GrpBdgPayOther[NumOfGrp] = [<%=sGrpBdgPayOther%>]; GrpBdgPay[NumOfGrp] = [<%=sGrpBdgPay%>];
               GrpBdgAvgPay[NumOfGrp] = [<%=sGrpBdgAvgPay%>]; GrpBdgAvgCom[NumOfGrp] = [<%=sGrpBdgAvgCom%>];
               GrpBdgAvgLSpiff[NumOfGrp] = [<%=sGrpBdgAvgLSpiff%>]; GrpBdgAvgMSpiff[NumOfGrp] = [<%=sGrpBdgAvgMSpiff%>];
               GrpBdgAvgOther[NumOfGrp] = [<%=sGrpBdgAvgOther%>]; GrpBdgAvg[NumOfGrp] = [<%=sGrpBdgAvg%>];

               ActEmpGrpName[NumOfGrp] = [<%=sActEmpGrpName%>]; ActEmpGrpHrs[NumOfGrp] = [<%=sActEmpGrpHrs%>];
               ActEmpGrpPay[NumOfGrp] = [<%=sActEmpGrpPay%>]; ActEmpGrpCom[NumOfGrp] = [<%=sActEmpGrpCom%>];
               ActEmpGrpLSpiff[NumOfGrp] = [<%=sActEmpGrpLSpiff%>]; ActEmpGrpMSpiff[NumOfGrp] = [<%=sActEmpGrpMSpiff%>];
               ActEmpGrpTot[NumOfGrp] = [<%=sActEmpGrpTot%>]; ActEmpGrpAvgPay[NumOfGrp] = [<%=sActEmpGrpAvgPay%>];
               ActEmpGrpAvgCom[NumOfGrp] = [<%=sActEmpGrpAvgCom%>]; ActEmpGrpAvgLSpiff[NumOfGrp] = [<%=sActEmpGrpAvgLSpiff%>];
               ActEmpGrpAvgMSpiff[NumOfGrp] = [<%=sActEmpGrpAvgMSpiff%>]; ActEmpGrpAvgTot[NumOfGrp] = [<%=sActEmpGrpAvgTot%>];
               ActEmpGrpSlsRet[NumOfGrp] = [<%=sActEmpGrpSlsRet%>]; ActEmpGrpIncPay[NumOfGrp] = [<%=sActEmpGrpIncPay%>];
               ActEmpGrpAvgIncPay[NumOfGrp] = [<%=sActEmpGrpAvgIncPay%>];
               NumOfGrp++;
        </script>
      </tr>
   </table>
    <!----------------------- end of table ---------------------------------->

   </table>
<br><br>
<!----------------------------------------------------------------------------->
<%
     bdgwkall.setABTotal();
     String sAbtTmc = bdgwkall.getAbtTmc();
     String sAbtProcAmt = bdgwkall.getAbtProcAmt();
     String sAbtRes1 = bdgwkall.getAbtRes1();
     String sAbtCalcAmt = bdgwkall.getAbtCalcAmt();
     String sAbtRes2 = bdgwkall.getAbtRes2();
     String sAbtIncPay = bdgwkall.getAbtIncPay();
     String sAbtAlwAmt = bdgwkall.getAbtAlwAmt();
     String sAbtVarOvr = bdgwkall.getAbtVarOvr();
     String sAbtActPrc = bdgwkall.getAbtActPrc();
     String sAbtAlwPrc = bdgwkall.getAbtAlwPrc();
	 String sAbtCoorInc = bdgwkall.getAbtCoorInc();
	 long lAb = Long.parseLong(sAbtAlwAmt.replaceAll(",", ""));
     long lTmc = Long.parseLong(sAbtTmc.replaceAll(",", ""));
     long lChall = Long.parseLong(sAbtIncPay.replaceAll(",", ""));
     long lStr55 = Long.parseLong(Str55ActProcPy.replaceAll(",", ""));
     long lCoor = Long.parseLong(sAbtCoorInc.replaceAll(",", ""));
     long lAdjAlwBdg = lAb + lTmc + lChall + lStr55 + lCoor;
     String sAdjAlwBdg = String.format("%,d", lAdjAlwBdg);
     
     long lAbtProcAmt = Long.parseLong(sAbtProcAmt.replaceAll(",", ""));
     long lVarFav = lAdjAlwBdg - lAbtProcAmt;
     sAbtVarOvr = String.format("%,d", lVarFav);
     String sColor = "g";
     if(lVarFav < 0 ){  sColor = "r"; }
     String sSpace = "&nbsp;";
     for(int i=0; i < 5; i++){ sSpace += "&nbsp;"; }
     	 
  %>
  <table border=0 cellPadding="0" cellSpacing="0">
    <tr>
      
      <td width="30%">&nbsp;</td>
      <td>
         <table border=0 cellPadding="0" cellSpacing="0" style="text-align:left; font-size:14px;">
           <tr>
                <td nowrap>Allowed Budget</td>  <td nowrap><%=sSpace%></td>
                <td class="DataTable">$<%=sAbtAlwAmt%></td> <td nowrap><%=sSpace%></td> <td align=left nowrap>(16)</td>
           </tr>
           <tr>
                <td nowrap>Add Exclusions to Allowable Budget:</td>
           </tr>
           <tr>
                <td nowrap><%=sSpace%>TMC (Actual) </td><td><%=sSpace%></td>
                <td class="DataTable"><%=sSpace%>$<%=sAbtTmc%></td> <td nowrap><%=sSpace%></td><td align=left nowrap>(4T)</td>
           </tr>
           <tr>
                <td nowrap><%=sSpace%>Challenge (Actual)</td> <td nowrap><%=sSpace%></td>
                <td class="DataTable"><%=sSpace%>$<%=sAbtIncPay%></td> <td nowrap><%=sSpace%></td><td align=left nowrap>Memo:Challenge</td>
           </tr>
           <tr>
                <td nowrap><%=sSpace%>Store 55 (Actual)</td><td nowrap><%=sSpace%></td>
                <td class="DataTable"><%=sSpace%>$<%=Str55ActProcPy%></td> <td nowrap><%=sSpace%></td><td align=left nowrap>(17P)</td>
           </tr>
           <tr>
                <td nowrap><u><%=sSpace%>Coordinator GM Incentive</u></td><td nowrap><%=sSpace%></td>
                <td class="DataTable"><u><%=sSpace%>$<%=sAbtCoorInc%></u></td> <td nowrap><%=sSpace%></td><td align=left nowrap>&nbsp;</td>
           </tr>                                 
           <tr>
                <td nowrap><b>Adjusted Allowed Budget</b></td><td nowrap><%=sSpace%></td>
                <td class="DataTable"><b>$<%=sAdjAlwBdg%></b></td> <td nowrap><%=sSpace%></td><td align=left nowrap>Calculated</td>
           </tr>
           <tr>
                <td nowrap>Actual Processed Payroll</td><td nowrap><%=sSpace%></td>
                <td class="DataTable">$<%=sAbtProcAmt%></td> <td nowrap><%=sSpace%></td><td align=left nowrap>(17P)</td>
           </tr>           
           <tr>
                <td nowrap>Variance-Fav(Unfav)</td><td nowrap><%=sSpace%></td>
                <td class="DataTable2<%=sColor%>">$<%=sAbtVarOvr%></td> <td nowrap><%=sSpace%></td><td align=left nowrap>Adjusted Bdg - Actual Bdg</td>
           </tr>
         </table>
      </td>
    <tr>
  </table>
<!----------------------------------------------------------------------------->
 <
  <%bdgwkall.disconnect();%>
<%}%>


  <%
long lEndTime = (new java.util.Date()).getTime();
long lElapse = (lEndTime - lStartTime) / 1000;
if (lElapse==0) {lElapse = 1;}
//System.out.println("B/Item X-fer loading Elapse time=" + lElapse + " second(s)");
%>
<p  style="text-align: left; font-size:10px; font-weigth:bold;">Elapse: <%=lElapse%> sec.</td>
  
/body>

</html>


