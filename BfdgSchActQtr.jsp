<%@ page import="java.util.*, java.text.*, payrollreports.BfdgSchActQtr"%>
<%
   String sStore = request.getParameter("Store");
   String sStrName = request.getParameter("StrName");
   String sYear = request.getParameter("Year");
   String sQtr = request.getParameter("Qtr");

   if(sStrName == null){ sStrName = " "; }

   String sUser = session.getAttribute("USER").toString();
   String sAppl = "PAYROLL";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
 && !session.getAttribute("APPLICATION").equals(sAppl))
{
   response.sendRedirect("SignOn1.jsp?TARGET=BfdgSchActQtr.jsp&APPL=" + sAppl + "&" + request.getQueryString());
}
else
{
     boolean bStrAlwed = false;
     String sStrAllowed = session.getAttribute("STORE").toString();
     if (sStrAllowed != null && (sStrAllowed.startsWith("ALL") || sStrAllowed.equals(sStore)))
     {
       bStrAlwed = true;
     }
     else
     {
       Vector vStr = (Vector) session.getAttribute("STRLST");
       Iterator iter = vStr.iterator();
       while (iter.hasNext())
       {
          if (((String)iter.next()).equals(sStore)){ bStrAlwed = true; }
       }
     }
     if(!bStrAlwed){ response.sendRedirect("BfdgSchActWkSel.jsp"); }

   BfdgSchActQtr bdgwk = new BfdgSchActQtr(sStore, sYear, sQtr, sUser);

   int iNumOfWk = bdgwk.getNumOfWk();
   int iNumOfWkPass = bdgwk.getNumOfWkPass();
   String sQtdDate = bdgwk.getQtdDate();
   String [] sWkend = bdgwk.getWkend();
   String [] sMonEnd = bdgwk.getMonEnd();
   int [] iMonNum = bdgwk.getMonNum();
   int [] iMonFiscalNum = bdgwk.getMonFiscalNum();

   int iNumOfCol = iNumOfWk;

   String [] sSlsPlan = bdgwk.getSlsPlan();

   // Alternate Goal
   String [] sAltSlsPlan = bdgwk.getAltSlsPlan();
   String [] sAltSlsPlanPrc = bdgwk.getAltSlsPlanPrc();
   String [] sAltSlsPlanDiff = bdgwk.getAltSlsPlanDiff();

   // Actual Sales
   String [] sActSls = bdgwk.getActSls();
   String [] sActSlsDiff = bdgwk.getActSlsDiff();

   // Actual Pays
   String [] sActPayHrs = bdgwk.getActPayHrs();
   String [] sActPayAmt = bdgwk.getActPayAmt();
   String [] sActPayAvg = bdgwk.getActPayAvg();
   String [] sActTmcHrs = bdgwk.getActTmcHrs();
   String [] sActTmcPay = bdgwk.getActTmcPay();
   String [] sActIncPay = bdgwk.getActTmcPay();
   String [] sTmcHrsSch = bdgwk.getTmcHrsSch();
   String [] sTmcPaySch = bdgwk.getTmcPaySch();
   String [] sTmcHrsAct = bdgwk.getTmcHrsAct();
   String [] sTmcPayAct = bdgwk.getTmcPayAct();

   // Actual Processed Payroll
   String [] sActPrcPayHrs = bdgwk.getActPrcPayHrs();
   String [] sActPrcPayAmt = bdgwk.getActPrcPayAmt();
   String [] sActPrcPayAvg = bdgwk.getActPrcPayAvg();
   String [] sAllowBdgActPrc = bdgwk.getAllowBdgActPrc();
   String [] sWarnLessBase = bdgwk.getWarnLessBase();

   // Budget Hours and Pay amounts
   String [] sBdgHrs = bdgwk.getBdgHrs();
   String [] sBdgPay = bdgwk.getBdgPay();
   String [] sBdgAvg = bdgwk.getBdgAvg();
   String [] sBdgTmcHrs = bdgwk.getBdgTmcHrs();
   String [] sBdgTmcPay = bdgwk.getBdgTmcPay();

   // Calculated variences
   String [] sHrsEarned = bdgwk.getHrsEarned();
   String [] sSlrCredHrs = bdgwk.getSlrCredHrs();
   String [] sHrsAllowed = bdgwk.getHrsAllowed();
   String [] sPayAllowed = bdgwk.getPayAllowed();
   String [] sHrsBdgVar = bdgwk.getHrsBdgVar();
   String [] sPayBdgVar = bdgwk.getPayBdgVar();
   String [] sPrcHrsBdgVar = bdgwk.getPrcHrsBdgVar();
   String [] sPrcPayBdgVar = bdgwk.getPrcPayBdgVar();
   String [] sBdgPayOfSls = bdgwk.getBdgPayOfSls();
   String [] sActPayOfSls = bdgwk.getActPayOfSls();
   String [] sActPrcPayOfSls = bdgwk.getActPrcPayOfSls();

   String [] sSlsCommRatio = bdgwk.getSlsCommRatio();
   String [] sSlsCommRate = bdgwk.getSlsCommRate();
   String [] sLSpiff = bdgwk.getLSpiff();
   String [] sPSpiff = bdgwk.getPSpiff();
   String [] sSlsPayrollPrc = bdgwk.getSlsPayrollPrc();
   String [] sAlwHrRate = bdgwk.getAlwHrRate();

   //Adjustment to Budget
   String [] sAdjVar = bdgwk.getAdjVar();
   String [] sBdgAdj = bdgwk.getBdgAdj();
   boolean [] bSchApproved = bdgwk.getSchApproved();

   // warnins
   String [] sWarnLine13 = bdgwk.getWarnLine13();
   String [] sWarnLine23 = bdgwk.getWarnLine23();

   // List of budget groups
   int iNumOfGrpBdg = bdgwk.getNumOfGrpBdg();
   String sGrpBdg = bdgwk.getGrpBdgJsa();
   String sGrpBdgName = bdgwk.getGrpBdgNameJsa();
   String sGrpBdgHrs = bdgwk.getGrpBdgHrsJsa();
   String sGrpBdgPayReg = bdgwk.getGrpBdgPayRegJsa();
   String sGrpBdgPayCom = bdgwk.getGrpBdgPayComJsa();
   String sGrpBdgPayLSpiff = bdgwk.getGrpBdgPayLSpiffJsa();
   String sGrpBdgPayMSpiff = bdgwk.getGrpBdgPayMSpiffJsa();
   String sGrpBdgPayOther = bdgwk.getGrpBdgPayOtherJsa();
   String sGrpBdgPay = bdgwk.getGrpBdgPayJsa();
   String sGrpBdgAvgPay = bdgwk.getGrpBdgAvgPayJsa();
   String sGrpBdgAvgCom = bdgwk.getGrpBdgAvgComJsa();
   String sGrpBdgAvgLSpiff = bdgwk.getGrpBdgAvgLSpiffJsa();
   String sGrpBdgAvgMSpiff = bdgwk.getGrpBdgAvgMSpiffJsa();
   String sGrpBdgAvgOther = bdgwk.getGrpBdgAvgOtherJsa();
   String sGrpBdgAvg = bdgwk.getGrpBdgAvgJsa();

   // Actual Employee Budget Group totals
   String sActEmpGrpName = bdgwk.getActEmpGrpNameJsa();
   String sActEmpGrpHrs = bdgwk.getActEmpGrpHrsJsa();
   String sActEmpGrpPay = bdgwk.getActEmpGrpPayJsa();
   String sActEmpGrpCom = bdgwk.getActEmpGrpComJsa();
   String sActEmpGrpLSpiff = bdgwk.getActEmpGrpLSpiffJsa();
   String sActEmpGrpMSpiff = bdgwk.getActEmpGrpMSpiffJsa();
   String sActEmpGrpTot = bdgwk.getActEmpGrpTotJsa();
   String sActEmpGrpAvgPay = bdgwk.getActEmpGrpAvgPayJsa();
   String sActEmpGrpAvgCom = bdgwk.getActEmpGrpAvgComJsa();
   String sActEmpGrpAvgLSpiff = bdgwk.getActEmpGrpAvgLSpiffJsa();
   String sActEmpGrpAvgMSpiff = bdgwk.getActEmpGrpAvgMSpiffJsa();
   String sActEmpGrpAvgTot = bdgwk.getActEmpGrpAvgTotJsa();
   String sActEmpGrpSlsRet = bdgwk.getActEmpGrpSlsRetJsa();
   String sActEmpGrpIncPay = bdgwk.getActEmpGrpIncPayJsa();
   String sActEmpGrpAvgIncPay = bdgwk.getActEmpGrpAvgIncPayJsa();

   // Budget / Actual Variance Budget Group totals
   String sVarGrpName = bdgwk.getVarGrpNameJsa();
   String sVarGrpHrs = bdgwk.getVarGrpHrsJsa();
   String sVarGrpPay = bdgwk.getVarGrpPayJsa();
   String sVarGrpCom = bdgwk.getVarGrpComJsa();
   String sVarGrpLSpiff = bdgwk.getVarGrpLSpiffJsa();
   String sVarGrpMSpiff = bdgwk.getVarGrpMSpiffJsa();
   String sVarGrpTot = bdgwk.getVarGrpTotJsa();
   String sVarGrpAvgPay = bdgwk.getVarGrpAvgPayJsa();
   String sVarGrpAvgCom = bdgwk.getVarGrpAvgComJsa();
   String sVarGrpAvgLSpiff = bdgwk.getVarGrpAvgLSpiffJsa();
   String sVarGrpAvgMSpiff = bdgwk.getVarGrpAvgMSpiffJsa();
   String sVarGrpAvgTot = bdgwk.getVarGrpAvgTotJsa();
   String sVarGrpSlsRet = bdgwk.getVarGrpslsRetJsa();
   String sVarGrpIncPay = bdgwk.getVarGrpIncPayJsa();
   String sVarGrpAvgIncPay = bdgwk.getVarGrpAvgIncPayJsa();

   String [] sMonNameArr = new String[]{"April", "May", "June", "July", "August", "September", "October", "November", "December", "January", "February", "March"};
   int iQtr = Integer.parseInt(sQtr.trim());
   int [] iMonNumArr = new int[]{0, 3, 6, 9};
%>
<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable00 { background:fa9b17; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:middle ;font-size:12px }
        th.DataTable01 { background:Coral; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:middle ;font-size:12px }
        th.DataTable02 { background:charTReuse; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:middle ;font-size:12px }
        th.DataTable03 { background:#46c7c7; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:middle ;font-size:12px }
        th.DataTable04 { background:#fff380; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:middle ;font-size:12px }
        th.DataTable05 { background:#f75d59; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:middle ;font-size:12px }

        th.DataTable1 { background: #fa9b17 ;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top ;font-size:12px }
        th.DataTable11 { background:coral ;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top ;font-size:12px }
        th.DataTable12 { background:charTReuse ;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top ;font-size:12px }
        th.DataTable13 { background: #46c7c7 ; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top ;font-size:12px }
        th.DataTable14 { background: #fff380; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top ;font-size:12px }
        th.DataTable15 { background: #f75d59; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top ;font-size:12px }

        th.DataTable2 { background: #fa9b17 ; padding-top:3px; padding-bottom:3px;
                       writing-mode: tb-rl; filter: flipv fliph; font-size:12px }
        th.DataTable21 { background:#ccffcc; padding-top:3px; padding-bottom:3px;
                       writing-mode: tb-rl; filter: flipv fliph; font-size:12px }
        th.DataTable22 { background:Coral; padding-top:3px; padding-bottom:3px;
                       writing-mode: tb-rl; filter: flipv fliph; font-size:12px }
        th.DataTable23 { background:charTReuse; padding-top:3px; padding-bottom:3px;
                       writing-mode: tb-rl; filter: flipv fliph; font-size:12px }
        th.DataTable24 { background:#46c7c7; padding-top:3px; padding-bottom:3px;
                       writing-mode: tb-rl; filter: flipv fliph; font-size:12px }
        th.DataTable25 { background:#fff380; padding-top:3px; padding-bottom:3px;
                       writing-mode: tb-rl; filter: flipv fliph; font-size:12px }
        th.DataTable26 { background: #f75d59; padding-top:3px; padding-bottom:3px;
                       writing-mode: tb-rl; filter: flipv fliph; font-size:12px }

        td.DataTable2p { background: #d0d0d0; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2g { background:lightgreen; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2r { background:pink; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}


        tr.DataTable { background: white; font-size:12px }
        tr.DataTable1 { background: yellow; font-size:12px }
        tr.Divdr1 { background: darkred; font-size:1px }
        tr.DataTable2 { background: #ccccff; font-size:10px }
        tr.DataTable3 { background: #ccffcc; font-size:10px }
        tr.DataTable31 { background: #ffff99; font-size:10px }
        tr.DataTable32 { background: gold; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable21 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}
        td.DataTable22 {  background: azure; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}
        td.DataTable210 { background: lightgreen; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}
        td.DataTable211 { background: pink; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}
        td.DataTable212 { background: tan; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;  font-weight: bold}

        td.DataTable2p { background: #d0d0d0; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

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
var GrpBdg = [<%=sGrpBdg%>];
var GrpBdgName = [<%=sGrpBdgName%>];
var GrpBdgHrs = [<%=sGrpBdgHrs%>];
var GrpBdgPayReg = [<%=sGrpBdgPayReg%>];
var GrpBdgPayCom = [<%=sGrpBdgPayCom%>];
var GrpBdgPayLSpiff = [<%=sGrpBdgPayLSpiff%>];
var GrpBdgPayMSpiff = [<%=sGrpBdgPayMSpiff%>];
var GrpBdgPayOther = [<%=sGrpBdgPayOther%>];
var GrpBdgPay = [<%=sGrpBdgPay%>];
var GrpBdgAvgPay = [<%=sGrpBdgAvgPay%>];
var GrpBdgAvgCom = [<%=sGrpBdgAvgCom%>];
var GrpBdgAvgLSpiff = [<%=sGrpBdgAvgLSpiff%>];
var GrpBdgAvgMSpiff = [<%=sGrpBdgAvgMSpiff%>];
var GrpBdgAvgOther = [<%=sGrpBdgAvgOther%>];
var GrpBdgAvg = [<%=sGrpBdgAvg%>];

var ActEmpGrpName = [<%=sActEmpGrpName%>];
var ActEmpGrpHrs = [<%=sActEmpGrpHrs%>];
var ActEmpGrpPay = [<%=sActEmpGrpPay%>];
var ActEmpGrpCom = [<%=sActEmpGrpCom%>];
var ActEmpGrpLSpiff = [<%=sActEmpGrpLSpiff%>];
var ActEmpGrpMSpiff = [<%=sActEmpGrpMSpiff%>];
var ActEmpGrpTot = [<%=sActEmpGrpTot%>];
var ActEmpGrpAvgPay = [<%=sActEmpGrpAvgPay%>];
var ActEmpGrpAvgCom = [<%=sActEmpGrpAvgCom%>];
var ActEmpGrpAvgLSpiff = [<%=sActEmpGrpAvgLSpiff%>];
var ActEmpGrpAvgMSpiff = [<%=sActEmpGrpAvgMSpiff%>];
var ActEmpGrpAvgTot = [<%=sActEmpGrpAvgTot%>];
var ActEmpGrpSlsRet = [<%=sActEmpGrpSlsRet%>];
var ActEmpGrpIncPay = [<%=sActEmpGrpIncPay%>];
var ActEmpGrpAvgIncPay = [<%=sActEmpGrpAvgIncPay%>];

var VarGrpName = [<%=sVarGrpName%>];
var VarGrpHrs = [<%=sVarGrpHrs%>];
var VarGrpPay = [<%=sVarGrpPay%>];
var VarGrpCom = [<%=sVarGrpCom%>];
var VarGrpLSpiff = [<%=sVarGrpLSpiff%>];
var VarGrpMSpiff = [<%=sVarGrpMSpiff%>];
var VarGrpTot = [<%=sVarGrpTot%>];
var VarGrpAvgPay = [<%=sVarGrpAvgPay%>];
var VarGrpAvgCom = [<%=sVarGrpAvgCom%>];
var VarGrpAvgLSpiff = [<%=sVarGrpAvgLSpiff%>];
var VarGrpAvgMSpiff = [<%=sVarGrpAvgMSpiff%>];
var VarGrpAvgTot = [<%=sVarGrpAvgTot%>];
var VarGrpSlsRet = [<%=sVarGrpSlsRet%>];
var VarGrpIncPay = [<%=sVarGrpIncPay%>];
var VarGrpAvgIncPay = [<%=sVarGrpAvgIncPay%>];

var NumOfWk = <%=iNumOfWk%>
//==============================================================================
// initilize on load
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvEmpList"]);
   showWeekCols('1');
   showWeekCols('2');
   showWeekCols('3');
}
//==============================================================================
// show Employee actual hours and payments
//==============================================================================
function showGrpBdg()
{
  var hdr = "Payroll Budget by Employee Groups";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popGrpBdgPanel()

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
function popGrpBdgPanel()
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
  panel += "<tr class='DataTable2'>"
             + "<th class='DataTable3' rowspan=2 nowrap>Group</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>Hours</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' colspan=6 nowrap>PAyroll Dollars</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' colspan=6 nowrap>Average Rates</th>"
         + "</tr>"
         + "<tr class='DataTable2'>"
             + "<th class='DataTable3' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"

             + "<th class='DataTable3' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"
         + "</tr>"

  for(var  i=0; i < GrpBdg.length; i++)
  {
       if (GrpBdgName[i].indexOf("Total") >= 0) {  panel += "<tr class='DataTable32'>" }
       else {  panel += "<tr class='DataTable3'>" }
       panel += "<td class='DataTable1' nowrap>" + GrpBdgName[i] + "</td>"
             + "<td class='DataTable2' nowrap>" + GrpBdgHrs[i] + "</td>"
             + "<th class='DataTable3' nowrap>&nbsp;</th>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgPayReg[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgPayCom[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgPayLSpiff[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgPayMSpiff[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgPayOther[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgPay[i] + "</td>"
             + "<th class='DataTable3' nowrap>&nbsp;</th>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvgPay[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvgCom[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvgLSpiff[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvgMSpiff[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvgOther[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvg[i] + "</td>"
         + "</tr>"

  }

  panel += "<tr><td class='Prompt1' colspan=16>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}


//==============================================================================
// display weekly budget details by date in new window
//==============================================================================
function getWkBdgRep(wkend)
{
  var fileType = "RCI";

  var url = 'BfdgSchActWk.jsp?Store=<%=sStore%>&StrName=<%=sStrName%>&Wkend=' + wkend
  document.all.frame1.style.height = "600";
  document.all.frame1.style.width = "100%";

  document.all.frame1.style.height = "600";
  document.all.frame1.style.width = "100%";

  window.frame1.location = url;
}

//==============================================================================
// show Employee actual hours and payments by budget groups
//==============================================================================
function showActEmpGrp()
{
  var hdr = "Employees Actual Hours and Payments by Budget Group<br>with exceptions (V,H,S)";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popActEmpGrpPanel()

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
function popActEmpGrpPanel()
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
  panel += "<tr class='DataTable2'>"
             + "<th class='DataTable3' rowspan=2 nowrap>Group</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>Hrs</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' colspan=6 nowrap>Payments</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' colspan=6 nowrap>Average Rates</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' colspan=6 nowrap>Sales<br>Retail</th>"
         + "</tr>"
         + "<tr class='DataTable2'>"
             + "<th class='DataTable3' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' nowrap>Sales<br>Comm</th>"
             + "<th class='DataTable3' nowrap>Labor<br>Spiffs</th>"
             + "<th class='DataTable3' nowrap>Paid<br>Spiffs</th>"
             + "<th class='DataTable3' nowrap>Others</th>"
             + "<th class='DataTable3' nowrap>Total<br>Pay</th>"

             + "<th class='DataTable3' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' nowrap>Sales<br>Comm</th>"
             + "<th class='DataTable3' nowrap>Labor<br>Spiffs</th>"
             + "<th class='DataTable3' nowrap>Paid<br>Spiffs</th>"
             + "<th class='DataTable3' nowrap>Others</th>"
             + "<th class='DataTable3' nowrap>Total<br>Pay</th>"
         + "</tr>"

  for(var  i=0; i < ActEmpGrpName.length; i++)
  {
     if(ActEmpGrpName[i].indexOf("Total") >= 0)
     {
      panel += "<tr class='DataTable31'>"
             + "<td class='DataTable1'>" + ActEmpGrpName[i] + "</td>"
     }
     else
     {
       panel += "<tr class='DataTable3'>"
             + "<td class='DataTable1' nowrap>" + ActEmpGrpName[i] + "</td>"
     }
     panel += "<td class='DataTable2' nowrap>" + ActEmpGrpHrs[i] + "</td>"
           + "<th class='DataTable3' nowrap>&nbsp;</th>"
           + "<td class='DataTable2' nowrap>$" + ActEmpGrpPay[i] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpGrpCom[i] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpGrpLSpiff[i] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpGrpMSpiff[i] + "</td>"
           + "<td class='DataTable2' nowrap>$x" + ActEmpGrpIncPay[i] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpGrpTot[i] + "</td>"

           + "<th class='DataTable3' nowrap>&nbsp;</th>"

           + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgPay[i] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgCom[i] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgLSpiff[i] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgMSpiff[i] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgIncPay[i] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgTot[i] + "</td>"
           + "<th class='DataTable3' nowrap>&nbsp;</th>"
           + "<td class='DataTable2' nowrap>$" + ActEmpGrpSlsRet[i] + "</td>"
         + "</tr>"

  }

  panel += "<tr><td class='Prompt1' colspan=16>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}

//==============================================================================
// show Employee actual hours and payments
//==============================================================================
function showGrpBdgAvg()
{
  var hdr = "Average Rate Comparison - Hourly Employees";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popGrpBdgAvgPanel()

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
function popGrpBdgAvgPanel()
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
  panel += "<tr class='DataTable2'>"
             + "<th class='DataTable3' rowspan=2 nowrap>Group</th>"
             + "<th class='DataTable3' colspan=7 nowrap>Budget</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp</th>"
             + "<th class='DataTable3' colspan=7 nowrap>Actual/Schedule</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp</th>"
             + "<th class='DataTable3' colspan=7 nowrap>Variances</th>"
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

             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"
         + "</tr>"

  for(var  i=0, j=0; i < GrpBdg.length; i++)
  {
       if (GrpBdgName[i].indexOf("Total") >= 0) {  panel += "<tr class='DataTable32'>" }
       else {  panel += "<tr class='DataTable3'>" }

       j = getActEmpGrpArg(GrpBdgName[i]);

       panel += "<td class='DataTable1' nowrap>" + GrpBdgName[i] + "</td>"
             + "<td class='DataTable2' nowrap>" + GrpBdgHrs[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvgPay[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvgCom[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvgLSpiff[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvgMSpiff[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvgOther[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvg[i] + "</td>"

             + "<th class='DataTable3' nowrap>&nbsp</th>"
             + "<td class='DataTable2' nowrap>" + ActEmpGrpHrs[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgPay[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgCom[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgLSpiff[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgMSpiff[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgIncPay[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgTot[j] + "</td>"

             + "<th class='DataTable3' nowrap>&nbsp</th>"
             + "<td class='DataTable2' nowrap>" + VarGrpHrs[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + VarGrpAvgPay[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + VarGrpAvgCom[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + VarGrpAvgLSpiff[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + VarGrpAvgMSpiff[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + VarGrpAvgIncPay[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + VarGrpAvgTot[j] + "</td>"
         + "</tr>"

  }

  panel += "<tr><td class='Prompt1' colspan=25>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// show Budget vs actual payroll $'s
//==============================================================================
function showGrpBdgPay()
{
  var hdr = "Payroll Dollars";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popGrpBdgPayPanel()

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
function popGrpBdgPayPanel()
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
  panel += "<tr class='DataTable2'>"
             + "<th class='DataTable3' rowspan=2 nowrap>Group</th>"
             + "<th class='DataTable3' colspan=7 nowrap>Budget</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp</th>"
             + "<th class='DataTable3' colspan=8 nowrap>Actual/Schedule</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp</th>"
             + "<th class='DataTable3' colspan=7 nowrap>Variances</th>"
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
             + "<th class='DataTable3' nowrap>Sales</th>"

             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"
         + "</tr>"

  for(var  i=0, j=0; i < GrpBdg.length; i++)
  {
       if (GrpBdgName[i].indexOf("Total") >= 0) {  panel += "<tr class='DataTable32'>" }
       else {  panel += "<tr class='DataTable3'>" }

       j = getActEmpGrpArg(GrpBdgName[i]);

       panel += "<td class='DataTable1' nowrap>" + GrpBdgName[i] + "</td>"
             + "<td class='DataTable2' nowrap>" + GrpBdgHrs[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgPayReg[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgPayCom[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgPayLSpiff[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgPayMSpiff[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgPayOther[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgPay[i] + "</td>"

             + "<th class='DataTable3' nowrap>&nbsp</th>"
             + "<td class='DataTable2' nowrap>" + ActEmpGrpHrs[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpPay[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpCom[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpLSpiff[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpMSpiff[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpIncPay[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpTot[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + ActEmpGrpSlsRet[j] + "</td>"

             + "<th class='DataTable3' nowrap>&nbsp</th>"
             + "<td class='DataTable2' nowrap>" + VarGrpHrs[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + VarGrpPay[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + VarGrpCom[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + VarGrpLSpiff[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + VarGrpMSpiff[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + VarGrpIncPay[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + VarGrpTot[j] + "</td>"
         + "</tr>"
  }

  panel += "<tr><td class='Prompt1' colspan=25>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}

//--------------------------------------------------------
// get actual employee group argument
//--------------------------------------------------------
function getActEmpGrpArg(grp)
{
   var arg = 0;
   var found = false;
   var max = ActEmpGrpName.length;

   for(var  i=0; i < max; i++)
   {
      if(grp == ActEmpGrpName[i]){ arg = i; found = true;}
   }
   if(!found)
   {
      ActEmpGrpName[max] = grp;
      ActEmpGrpHrs[max] = 0;
      ActEmpGrpPay[max] = 0;
      ActEmpGrpCom[max] = 0;
      ActEmpGrpLSpiff[max] = 0;
      ActEmpGrpMSpiff[max] = 0;
      ActEmpGrpTot[max] = 0;
      ActEmpGrpAvgPay[max] = 0;
      ActEmpGrpAvgCom[max] = 0;
      ActEmpGrpAvgLSpiff[max] = 0;
      ActEmpGrpAvgMSpiff[max] = 0;
      ActEmpGrpAvgTot[max] = 0;
      ActEmpGrpAvgSlsRet[max] = 0;
      ActEmpGrpIncPay[max] = 0;
      ActEmpGrpAvgIncPay[max] = 0;
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

//==============================================================================
// show/hide weekly columns
//==============================================================================
function showWeekCols(mon)
{
   var status = null;
   var colid = "wk" + mon + "0"
   var cell = document.all[colid];

   if(cell[0].style.display != "none") {  status = "none"; }
   else
   {
      status = "block";
   }



   for(var i=0; i < cell.length; i++) { cell[i].style.display = status; }
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvEmpList" class="dvEmpList"></div>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
      <br>Allowable Budget Review (Quarterly) (New Schedule)
      <br> Store: <%=sStore%> &nbsp; &nbsp; Fiscal Year/Quarter <%=sYear%> / <%=sQtr%>
      </b>

      <br><br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <a href="BfdgSchActWkSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 width="100%" cellPadding="0" cellSpacing="0">
        <tr>
          <td class="DataTable" rowspan=13></td>
          <td class="DataTable" rowspan=2></td>
          <th class="DataTable" rowspan=2>No.</th>
          <th class="DataTable" rowspan=2>&nbsp;</th>
          <%for(int i=0, j=0; i < iNumOfWk; i++){%>
             <!-- Weeks -->
             <%if(sMonEnd[i].equals("0")){%>
                <th class="DataTable" id="wk<%=iMonNum[i] + sMonEnd[i]%>" rowspan=2 nowrap>
                    <a href="javascript: getWkBdgRep('<%=sWkend[i]%>');"><%=sWkend[i]%>
                    <br><sup><i><%if(sMonEnd[i].equals("0") && bSchApproved[i]){%>Approved<%}%></i></sup>
                </th>
             <!-- Months -->
             <%} else if(sMonEnd[i].equals("1")) {%>
                 <th class="DataTable" rowspan=2 nowrap>
                    <a href="javascript: showWeekCols('<%=iMonNum[i]%>');"><%=sWkend[i]%>
                    <br><%=sMonNameArr[iMonNumArr[iQtr - 1] + j]%><%j++;%></a>
                 </th>
             <!-- Quarter and QTD -->
             <%} else if(sMonEnd[i].equals("2")) {%>
                 <th class="DataTable" rowspan=2 nowrap><%=sWkend[i]%></th>
             <%}  else if(sMonEnd[i].equals("3")) {%>
                 <th class="DataTable" rowspan=2 nowrap><%=sWkend[i]%><br><%=sQtdDate%></th>
             <%}%>

          <%}%>
          <th class="DataTable" colspan="<%=iNumOfWk%>" id="thActPrcPay">Actual<br>Processed<br>Payroll</th>
        </tr>
        <tr>
           <%for(int i=0, j=0; i < iNumOfWk-2; i++){%>
              <th class="DataTable" id="wk<%=iMonNum[i] + sMonEnd[i]%>">
                 <%if(sMonEnd[i].equals("1")) {%><br><%=sMonNameArr[iMonNumArr[iQtr - 1] + j]%><%j++;%><%}
                 else {%><%=sWkend[i]%><%}%>
              </th>
           <%}%>
           <th class="DataTable">QTD</th>
        </tr>

     <!-------------------- Sales Plan ---------------------------------------->
     <tr class="DataTable">
        <th class="DataTable2" rowspan=8>Sales</th>
        <th class="DataTable00">2</th>
        <th class="DataTable1">Original Sales Plan</th>
        <%for(int i=0; i < iNumOfCol; i++){%>
           <td class="DataTable21" id="wk<%=iMonNum[i] + sMonEnd[i]%>">$<%=sSlsPlan[i]%></td>
        <%}%>
        <td class="DataTable" colspan=<%=iNumOfWk%>>&nbsp;</td>
     </tr>

     <!------------------- Alternate Sales Goal by Day % ---------------------->
     <tr class="Divdr1"><td colspan="<%=iNumOfCol + iNumOfWk + 1%>">&nbsp;</td></tr>
     <tr class="DataTable">
        <th class="DataTable00">3</th>
        <th class="DataTable1">Sales Forecast Trend Rate</th>
        <%for(int i=0; i < iNumOfCol; i++){%>
           <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>"><%=sAltSlsPlanPrc[i]%>%</td>
        <%}%>
        <td class="DataTable" rowspan=3 colspan=<%=iNumOfWk%>>&nbsp;</td>
     </tr>

     <!----------------------- Alternate Sales Goal --------------------------->
     <tr class="DataTable">
        <th class="DataTable00">4</th>
        <th class="DataTable1">Sales Forecast</th>
        <%for(int i=0; i < iNumOfCol; i++){%>
           <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>">$<%=sAltSlsPlan[i]%></td>
        <%}%>
     </tr>
     <!----------------------- Alternate Sales Goal Difference ---------------->
     <tr class="DataTable">
        <th class="DataTable00">5</th>
        <th class="DataTable1">Sales Forecast Dollars +/-</th>
        <%for(int i=0; i < iNumOfCol; i++){%>
           <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>">$<%=sAltSlsPlanDiff[i]%></td>
        <%}%>
     </tr>
     <!------------------------ Actual Sales  --------------------------------->
     <tr class="Divdr1"><td colspan="<%=iNumOfCol + iNumOfWk + 1%>">&nbsp;</td></tr>
     <tr class="DataTable">
        <th class="DataTable00">6</th>
        <th class="DataTable1">Sales Actual / Forecast</th>
        <%for(int i=0; i < iNumOfCol; i++){%>
           <td class="DataTable21" id="wk<%=iMonNum[i] + sMonEnd[i]%>">$<%=sActSls[i]%></td>
        <%}%>
        <td class="DataTable" rowspan=2 colspan=<%=iNumOfWk%>>&nbsp;</td>
     </tr>

     <!----------------------- Sales Dollars +/- ------------------------------>
     <tr class="DataTable">
        <th class="DataTable00">7</th>
        <th class="DataTable1">Sales Dollars +/-</th>
        <%for(int i=0; i < iNumOfCol; i++){%>
           <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>">$<%=sActSlsDiff[i]%></td>
        <%}%>
     </tr>

     <tr class="Divdr1"><td style="background: white;"><td colspan="<%=iNumOfCol + iNumOfWk + 1%>">&nbsp;</td></tr>
     <tr class="Divdr1"><td style="background: white;"><td colspan="<%=iNumOfCol + iNumOfWk + 1%>">&nbsp;</td></tr>
     <tr class="Divdr1"><td style="background: white;"><td colspan="<%=iNumOfCol + iNumOfWk + 1%>">&nbsp;</td></tr>

     <!------------------- Budget Hours --------------------------------------->
     <tr class="DataTable1">
        <th class="DataTable21" rowspan=21 nowrap>Hourly Employee Only<br>(Excludes Holiday, Sick, Vacation and TMC.)</th>
        <th class="DataTable22" rowspan=7>P/R Hours</th>
        <th class="DataTable01">9</th>
        <th class="DataTable11">Original Budget Hours</th>
        <%for(int i=0; i < iNumOfCol; i++){%>
           <td class="DataTable21" id="wk<%=iMonNum[i] + sMonEnd[i]%>"><%=sBdgHrs[i]%></td>
        <%}%>
        <td class="DataTable" style="background:white;" rowspan=6 colspan=<%=iNumOfWk%>>&nbsp;</td>
     </tr>
     <!-------------------------- Hours Earned -------------------------------->
     <tr class="DataTable">
        <th class="DataTable01" rowspan=2>10</th>
        <th class="DataTable11">Hours Earned (Based on Sales)</th>
        <%for(int i=0, j=0; i < iNumOfCol; i++){%>
           <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>">&nbsp;
              <%if(j <= iNumOfWkPass || i >= iNumOfCol-1 || iNumOfWkPass == iNumOfWk - 5){%><%=sHrsEarned[i]%>
                 <%if(sMonEnd[i].equals("0")){ j++; }%>
              <%}%>
           </td>
        <%}%>
     </tr>
     <tr class="DataTable">
        <th class="DataTable11">Hours Earned (Based on Salaried Employees on V or H)</th>
        <%for(int i=0, j=0; i < iNumOfCol; i++){%>
           <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>">&nbsp;
           <%if(j <= iNumOfWkPass || i >= iNumOfCol-1 || iNumOfWkPass == iNumOfWk - 5){%><%=sSlrCredHrs[i]%>
               <%if(sMonEnd[i].equals("0")){ j++; }%>
           <%}%>
        </td>
        <%}%>
     </tr>
     <!------------------------- Hours Allowed Revised ------------------------>
     <tr class="DataTable">
        <th class="DataTable01">11</th>
        <th class="DataTable11">Allowable Budget Hours</th>
        <%for(int i=0, j=0; i < iNumOfCol; i++){%>
           <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>">&nbsp;
             <%if(j <= iNumOfWkPass || i >= iNumOfCol-1 || iNumOfWkPass == iNumOfWk - 5){%><%=sHrsAllowed[i]%>
                <%if(sMonEnd[i].equals("0")){ j++; }%>
             <%}%>
           </td>
        <%}%>
     </tr>
     <!------------------------- Adjustment to hours needed ------------------------>
     <tr class="DataTable">
        <th class="DataTable01">12</th>
        <th class="DataTable11">Actual Hrs. / Adjustment to Hours Needed To Reach Allowable Budget</th>
        <%for(int i=0, j=0; i < iNumOfCol; i++){%>
           <%if(!sAdjVar[i].equals("---")){%><td class="DataTable2"  id="wk<%=iMonNum[i] + sMonEnd[i]%>">&nbsp;
           <%if(j <= iNumOfWkPass || i >= iNumOfCol-1 || iNumOfWkPass == iNumOfWk - 5){%><%=sAdjVar[i]%><%}%></td>
           <%} else {%><td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>">&nbsp;</td><%}%>
           <%if(sMonEnd[i].equals("0")){ j++; }%>
        <%}%>
     </tr>
     <!------------------------- Adjusted Budget Hours ------------------------>
     <tr class="DataTable">
        <th class="DataTable01">13</th>
        <th class="DataTable11">Actual Hrs. / Adjusted Hrs. To Reach Allowable Budget</th>
        <%for(int i=0, j=0; i < iNumOfCol; i++){%>
           <%if(!sAdjVar[i].equals("---")){%>
              <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>">&nbsp;
                <%if(j <= iNumOfWkPass || i >= iNumOfCol-1 || iNumOfWkPass == iNumOfWk - 5){%><%=sBdgAdj[i]%><%}%>
              </td>
          <%} else {%><td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>">&nbsp;<%}%>
          <%if(sMonEnd[i].equals("0")){ j++; }%>
        <%}%>
     </tr>

     <!------------------------- Hours Actual --------------------------------->
     <tr class="DataTable">
        <th class="DataTable01">14</th>
        <th class="DataTable11">Hours Actual / Scheduled</th>
        <%for(int i=0, j=0; i < iNumOfCol; i++){%>
           <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>">&nbsp;
             <%if(j <= iNumOfWkPass || i >= iNumOfCol-1 || iNumOfWkPass == iNumOfWk - 5){%><%=sActPayHrs[i]%>
                 <%if(sMonEnd[i].equals("0")){ j++; }%>
             <%}%>
          </td>
        <%}%>

        <%for(int i=0; i < iNumOfWk-2; i++){%>
           <td class="DataTable22" id="wk<%=iMonNum[i] + sMonEnd[i]%>"><%=sActPrcPayHrs[i]%></td>
        <%}%>
        <td class="DataTable22"><%=sActPrcPayHrs[iNumOfCol-1]%></td>

     </tr>
<!------------------------- Payroll Budget Dollars ----------------------->
     <tr class="DataTable">
        <th class="DataTable23" rowspan=3>P/R $'s</th>
        <th class="DataTable02">15</th>
        <th class="DataTable12">Original Payroll Budget Dollars</th>
        <%for(int i=0; i < iNumOfCol; i++){%>
           <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>">$<%=sBdgPay[i]%></td>
        <%}%>
        <td class="DataTable" rowspan=2 colspan=<%=iNumOfWk%>>&nbsp;</td>
     </tr>
     <!------------------------- Revised Budget Dollars ----------------------->
     <tr class="DataTable">
        <th class="DataTable02">16</th>
        <th class="DataTable12">Allowable Budget Dollars</th>
        <%for(int i=0, j=0; i < iNumOfCol; i++){%>
           <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>">&nbsp;
              <%if(j <= iNumOfWkPass || i >= iNumOfCol-1 || iNumOfWkPass == iNumOfWk - 5){%>$<%=sPayAllowed[i]%>
                  <%if(sMonEnd[i].equals("0")){ j++; }%>
              <%}%>
           </td>
        <%}%>
     </tr>
     <!-------------------- Hourly Payroll $ Actual --------------------------->
     <tr class="DataTable">
        <th class="DataTable02">17</th>
        <th class="DataTable12">Hourly Payroll $ Actual / Scheduled <a href="javascript: showGrpBdgPay()"><i><sup>(Bdg vs Act Payroll)</sup></i></a></th>
        <%for(int i=0, j=0; i < iNumOfCol; i++){%>
           <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>">&nbsp;
              <%if(j <= iNumOfWkPass || i >= iNumOfCol-1 || iNumOfWkPass == iNumOfWk - 5){%>$<%=sActPayAmt[i]%>
                  <%if(sMonEnd[i].equals("0")){ j++; }%>
              <%}%>
           </td>
        <%}%>
        <%for(int i=0, j=0; i < iNumOfWk-2; i++){%>
           <td class="DataTable22" id="wk<%=iMonNum[i] + sMonEnd[i]%>">$<%=sActPrcPayAmt[i]%></td>
        <%}%>
        <td class="DataTable22">$<%=sActPrcPayAmt[iNumOfCol-1]%></td>
     </tr>

     <!--------------- Origianl Budgeted Average Hourly Rate ------------------>
     <tr class="DataTable">
        <th class="DataTable24" rowspan=3>Hourly<br>Rate</th>
        <th class="DataTable03">18</th>
        <th class="DataTable13">Original Budgeted Average Hourly Rate</th>
        <%for(int i=0; i < iNumOfCol; i++){%>
           <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>">$<%=sBdgAvg[i]%></td>
        <%}%>
        <td class="DataTable" colspan=<%=iNumOfWk%>>&nbsp;</td>
     </tr>
     <!-------------- Allowable Budgeted Average Hourly Rate ------------------>
     <tr class="DataTable">
        <th class="DataTable03">19</th>
        <th class="DataTable13">Allowable Budgeted Average Hourly Rate</th>
          <%for(int i=0, j=0; i < iNumOfCol; i++){%>
           <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>">&nbsp;
               <%if(j <= iNumOfWkPass || i >= iNumOfCol-1 || iNumOfWkPass == iNumOfWk - 5){%>$<%=sAlwHrRate[i]%>
                   <%if(sMonEnd[i].equals("0")){ j++; }%>
               <%}%>
           </td>
        <%}%>
        <td class="DataTable" colspan=<%=iNumOfWk%>>&nbsp;</td>
     </tr>
     <!--------------- Actual / Scheduled Average Hourly Rate ----------------->
     <tr class="DataTable">
        <th class="DataTable03">20</th>
        <th class="DataTable13">Actual / Scheduled Average Hourly Rate
           <a href="javascript: showGrpBdgAvg()"><i><sup>(Bdg vs Act Avg)</sup></i></a>
        </th>
        <%for(int i=0, j=0; i < iNumOfCol; i++){%>
           <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>">&nbsp;
               <%if(j <= iNumOfWkPass || i >= iNumOfCol-1 || iNumOfWkPass == iNumOfWk - 5){%>$<%=sActPayAvg[i]%>
                   <%if(sMonEnd[i].equals("0")){ j++; }%>
               <%}%>
           </td>
        <%}%>
        <%for(int i=0; i < iNumOfWk-2; i++){%>
           <td class="DataTable22" id="wk<%=iMonNum[i] + sMonEnd[i]%>">$<%=sActPrcPayAvg[i]%></td>
        <%}%>
        <td class="DataTable22">$<%=sActPrcPayAvg[iNumOfWk-1]%></td>
     </tr>

     <tr class="Divdr1"><td style="background: white;"><td colspan="<%=iNumOfCol + iNumOfWk + 1%>">&nbsp;</td></tr>
     <tr class="Divdr1"><td style="background: white;"><td colspan="<%=iNumOfCol + iNumOfWk + 1%>">&nbsp;</td></tr>
     <tr class="Divdr1"><td style="background: white;"><td colspan="<%=iNumOfCol + iNumOfWk + 1%>">&nbsp;</td></tr>

     <!------------------------ Hours +/- Rate -------------------------------->

     <tr class="DataTable">
        <th class="DataTable25" rowspan=5>Variance</th>
        <th class="DataTable04">21</th>
        <th class="DataTable14">Actual / Scheduled Hours vs. Allowable Budget</th>
        <%for(int i=0, j=0; i < iNumOfCol; i++){%>
           <td class="DataTable2<%if((j <= iNumOfWkPass || i >= iNumOfCol-1 || iNumOfWkPass == iNumOfWk - 5) && sHrsBdgVar[i].indexOf("-") >= 0){%>g<%} else if(i < iNumOfWkPass || i == iNumOfCol-1 || iNumOfWk == iNumOfWkPass) {%>r<%}%>" id="wk<%=iMonNum[i] + sMonEnd[i]%>">&nbsp;
               <%if(j <= iNumOfWkPass || i >= iNumOfCol-1 || iNumOfWkPass == iNumOfWk - 5){%><%=sHrsBdgVar[i]%>
                    <%if(sMonEnd[i].equals("0")){ j++; }%>
               <%}%>
            </td>
        <%}%>
        <td class="DataTable" rowspan=5 colspan=<%=iNumOfWk%>>&nbsp;</td>
        <!-- td class="DataTable22"><%=sPrcHrsBdgVar[iNumOfCol-1]%></td -->
     </tr>
     <!------------------------ Dollars +/- Rate --------------------------->
     <tr class="DataTable">
        <th class="DataTable04">22</th>
        <th class="DataTable14">Actual / Scheduled Dollars +/- Allowable Budget Dollars</th>
        <%for(int i=0, j=0; i < iNumOfCol; i++){%>
           <td class="DataTable2<%if((j <= iNumOfWkPass || i >= iNumOfCol-1 || iNumOfWkPass == iNumOfWk - 5) && sPayBdgVar[i].indexOf("-") >= 0){%>g<%} else if(i < iNumOfWkPass || i == iNumOfCol-1 || iNumOfWk == iNumOfWkPass) {%>r<%}%>"
               id="wk<%=iMonNum[i] + sMonEnd[i]%>">&nbsp;<%if(i < iNumOfWkPass || i == iNumOfCol-1 || iNumOfWk == iNumOfWkPass){%>
               $<%=sPayBdgVar[i]%><%}%><%if(sMonEnd[i].equals("0")){ j++; }%>
           </td>
        <%}%>
        <!-- td class="DataTable22">$<%=sPrcPayBdgVar[iNumOfCol-1]%></td -->
     </tr>

     <!--------------------- Budget Payroll % To Sales ------------------------>
     <tr class="DataTable">
        <th class="DataTable04">23</th>
        <th class="DataTable14">Original Budget Payroll % To Original Sales Plan</th>
        <%for(int i=0; i < iNumOfCol; i++){%>
           <td class="DataTable21" id="wk<%=iMonNum[i] + sMonEnd[i]%>">&nbsp;<%if(i < iNumOfWkPass || i == iNumOfCol-1 || iNumOfWk == iNumOfWkPass){%><%=sBdgPayOfSls[i]%>%<%}%></td>
        <%}%>
     </tr>

     <!--------------------- Actual Payroll % To Sales ------------------------>
     <tr class="DataTable">
        <th class="DataTable04">24</th>
        <th class="DataTable14">Actual / Scheduled Payroll % To Actual / Forecast Sales</th>
        <%for(int i=0, j=0; i < iNumOfCol; i++){%>
           <td id="wk<%=iMonNum[i] + sMonEnd[i]%>" class="DataTable21<%=sWarnLine23[i]%>">&nbsp;
               <%if(j <= iNumOfWkPass || i >= iNumOfCol-1 || iNumOfWkPass == iNumOfWk - 5){%><%=sActPayOfSls[i]%>%
                   <%if(sMonEnd[i].equals("0")){ j++; }%>
               <%}%>
           </td>
        <%}%>
        <!--td class="DataTable22"><%=sActPayOfSls[iNumOfCol-1]%>%</td -->
     </tr>
     <!--------------------- Actual Payroll % To Sales ------------------------>
     <tr class="DataTable">
        <th class="DataTable04">25</th>
        <th class="DataTable14">Allowable Budget Payroll % To Actual / Forecast Sales</th>
        <%for(int i=0, j=0; i < iNumOfCol; i++){%>
           <td class="DataTable21" id="wk<%=iMonNum[i] + sMonEnd[i]%>">&nbsp;
               <%if(j <= iNumOfWkPass || i >= iNumOfCol-1 || iNumOfWkPass == iNumOfWk - 5){%><%=sAllowBdgActPrc[i]%>%
                  <%if(sMonEnd[i].equals("0")){ j++; }%>
               <%}%>
           </td>
        <%}%>
     </tr>

     <tr class="Divdr1"><td style="background: white;" colspan=2><td colspan="<%=iNumOfCol + iNumOfWk + 1%>">&nbsp;</td></tr>
     <tr class="Divdr1"><td style="background: white;" colspan=2><td colspan="<%=iNumOfCol + iNumOfWk + 1%>">&nbsp;</td></tr>
     <tr class="Divdr1"><td style="background: white;" colspan=2><td colspan="<%=iNumOfCol + iNumOfWk + 1%>">&nbsp;</td></tr>
     <tr class="Divdr1"><td style="background: white;" colspan=2><td colspan="<%=iNumOfCol + iNumOfWk + 1%>">&nbsp;</td></tr>
     <tr class="Divdr1"><td style="background: white;" colspan=2><td colspan="<%=iNumOfCol + iNumOfWk + 1%>">&nbsp;</td></tr>

     <!--------------- Budget Hours - Training/Meeting/Clinics ---------------->
     <tr class="DataTable">
       <td class="DataTable" rowspan=6></td>
        <th class="DataTable26" rowspan=6>T/M/C</th>
        <th class="DataTable05">1</th>
        <th class="DataTable15">Budget Hours - Training/Meeting/Clinics</th>
        <%for(int i=0; i < iNumOfCol; i++){%>
            <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>"><%=sBdgTmcHrs[i]%></td>
        <%}%>
        <td class="DataTable" rowspan=6 colspan=<%=iNumOfWk%>>&nbsp;</td>
     </tr>
     <!--------------------- Hours Actual/Scheduled - TMC ---------------------->
     <tr class="DataTable">
        <th class="DataTable05">2a</th>
        <th class="DataTable15">Hours Scheduled - TMC</th>
        <%for(int i=0; i < iNumOfCol; i++){%>
            <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>"><%=sTmcHrsSch[i]%></td>
        <%}%>
     </tr>
     <tr class="DataTable">
        <th class="DataTable05">2b</th>
        <th class="DataTable15">Hours Actual - TMC</th>
        <%for(int i=0; i < iNumOfCol; i++){%>
            <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>"><%=sTmcHrsAct[i]%></td>
        <%}%>
     </tr>
     <!----------------------- Payroll Budget $'s - TMC ----------------------->
     <tr class="DataTable">
        <th class="DataTable05">3</th>
        <th class="DataTable15">Payroll Budget $'s - TMC</th>
        <%for(int i=0; i < iNumOfCol; i++){%>
            <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>">$<%=sBdgTmcPay[i]%></td>
        <%}%>
     </tr>
     <!--------------------- Hours Payrol $'s/Scheduled - TMC ---------------------->
     <tr class="DataTable">
        <th class="DataTable05">4a</th>
        <th class="DataTable15">Hours Payrol Scheduled - TMC</th>
        <%for(int i=0; i < iNumOfCol; i++){%>
            <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>">$<%=sTmcPaySch[i]%></td>
        <%}%>
     </tr>
     <tr class="DataTable">
        <th class="DataTable05">4</th>
        <th class="DataTable15">Hours Payrol Actual - TMC</th>
        <%for(int i=0; i < iNumOfCol; i++){%>
            <td class="DataTable2" id="wk<%=iMonNum[i] + sMonEnd[i]%>">$<%=sTmcPayAct[i]%></td>
        <%}%>
     </tr>

   </table>
    <!----------------------- end of table ---------------------------------->

  </table>
<div style="color:darkred;font-size:12px;">
Note: Amounts in 'Actual Processed Payroll' (see column on far right side of this page) may be
 different than amounts in line 17 - 'Actual Hourly Payroll Dollars' due to clocking errors.<br>
 For incentive plan purposes, amounts in 'Actual Process Payroll' will be used.
</div>
<!-- ======================================================================= -->
<iframe  id="frame1"  src="" frameborder=1 height="0" width="0"></iframe>
<!-- ======================================================================= -->

 </body>

</html>

<%bdgwk.disconnect();%>

<%}%>






