<%@ page import="java.util.*, java.text.*, payrollreports.BfdgSchActWk"%>
<%
   String sStore = request.getParameter("Store");
   String sStrName = request.getParameter("StrName");
   String sWkend = request.getParameter("Wkend");

   String sUser = session.getAttribute("USER").toString();
   String sAppl = "PRLAB";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
 && !session.getAttribute("APPLICATION").equals(sAppl))
{
   response.sendRedirect("SignOn1.jsp?TARGET=BfdgSchActWk.jsp&APPL=" + sAppl + "&" + request.getQueryString());
}
else
{

     String sStrAllowed = session.getAttribute("STORE").toString();
     sUser = session.getAttribute("USER").toString();

     boolean bStrAlwed = false;
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


   BfdgSchActWk bdgwk = new BfdgSchActWk(sStore, sWkend, sUser);

   String [] sSlsPlan = bdgwk.getSlsPlan();
   String [] sSlsPlanPrc = bdgwk.getSlsPlanPrc();
   // Alternate Goal
   String [] sAltSlsPlan = bdgwk.getAltSlsPlan();
   String [] sAltSlsPlanPrc = bdgwk.getAltSlsPlanPrc();
   String [] sAltSlsPlanDiff = bdgwk.getAltSlsPlanDiff();
   // Actual Sales
   String [] sActSls = bdgwk.getActSls();
   String [] sActSlsDiff = bdgwk.getActSlsDiff();
   String [] sActOrigPrc = bdgwk.getActOrigPrc();

   // Actual Pays
   String [] sActPayHrs = bdgwk.getActPayHrs();
   String [] sActPayAmt = bdgwk.getActPayAmt();
   String [] sActPayAvg = bdgwk.getActPayAvg();
   String [] sActComPay = bdgwk.getActComPay();
   String [] sActTmcHrs = bdgwk.getActTmcHrs();
   String [] sActTmcPay = bdgwk.getActTmcPay();
   String [] sTmcHrsSch = bdgwk.getTmcHrsSch();
   String [] sTmcPaySch = bdgwk.getTmcPaySch();
   String [] sTmcHrsAct = bdgwk.getTmcHrsAct();
   String [] sTmcPayAct = bdgwk.getTmcPayAct();

   // Actual Processed Payroll
   String sActPrcPayHrs = bdgwk.getActPrcPayHrs();
   String sActPrcPayAmt = bdgwk.getActPrcPayAmt();
   String sActPrcPayAvg = bdgwk.getActPrcPayAvg();

   // Schedule Hours
   String [] sSchHrs = bdgwk.getSchHrs();
   String [] sSchPrc = bdgwk.getSchPrc();

   // Budget Hours and Pay amounts
   String [] sBdgHrs = bdgwk.getBdgHrs();
   String [] sBdgPay = bdgwk.getBdgPay();
   String [] sBdgAvg = bdgwk.getBdgAvg();
   String [] sBdgTmcHrs = bdgwk.getBdgTmcHrs();
   String [] sBdgTmcPay = bdgwk.getBdgTmcPay();

   String [] sHrsEarned = bdgwk.getHrsEarned();
   String [] sHrsEarnedNoSlry = bdgwk.getHrsEarnedNoSlry();
   String [] sHrsEarnedOnBased = bdgwk.getHrsEarnedOnBased();
   String [] sHrsAllowed = bdgwk.getHrsAllowed();
   String [] sPayAllowed = bdgwk.getPayAllowed();
   String [] sHrsBdgVar = bdgwk.getHrsBdgVar();
   String [] sPayBdgVar = bdgwk.getPayBdgVar();
   String [] sPrcHrsBdgVar = bdgwk.getPrcHrsBdgVar();
   String [] sPrcPayBdgVar = bdgwk.getPrcPayBdgVar();
   String [] sBdgPayOfSls = bdgwk.getBdgPayOfSls();
   String [] sActPayOfSls = bdgwk.getActPayOfSls();
   String [] sActPrcPayOfSls = bdgwk.getActPrcPayOfSls();
   String [] sAllowBdgActPrc = bdgwk.getAllowBdgActPrc();
   String [] sWarnLessBase = bdgwk.getWarnLessBase();
   String [] sWarnL10 = bdgwk.getWarnL10();

   String sSlsCommRatio = bdgwk.getSlsCommRatio();
   String sSlsCommRate = bdgwk.getSlsCommRate();
   String sLSpiff = bdgwk.getLSpiff();
   String sPSpiff = bdgwk.getPSpiff();
   String sSlsPayrollPrc = bdgwk.getSlsPayrollPrc();
   String sAlwHrRate = bdgwk.getAlwHrRate();

   String sBaseSchDt = bdgwk.getBaseSchDt();
   String sBaseSlrHrs = bdgwk.getBaseSlrHrs();
   String sNoSlryHrs = bdgwk.getNoSlryHrs();
   String sTmcSlryHrs = bdgwk.getTmcSlyrHrs();
   String sSickSlryHrs = bdgwk.getSickSlyrHrs();
   String sCurrSlrHrs = bdgwk.getCurrSlrHrs();

   //Adjustment to Budget
   String [] sAdjVar = bdgwk.getAdjVar();
   String [] sBdgAdj = bdgwk.getBdgAdj();

   // Actual Employee Wages
   String sActEmp = bdgwk.getActEmpJsa();
   String sActEmpName = bdgwk.getActEmpNameJsa();
   String sActEmpHorS = bdgwk.getActEmpHorSJsa();
   String sActEmpDept = bdgwk.getActEmpDeptJsa();
   String sActEmpStr = bdgwk.getActEmpStrJsa();
   String sActEmpHrs = bdgwk.getActEmpHrsJsa();
   String sActEmpPay = bdgwk.getActEmpPayJsa();
   String sActEmpCom = bdgwk.getActEmpComJsa();
   String sActEmpLSpiff = bdgwk.getActEmpLSpiffJsa();
   String sActEmpMSpiff = bdgwk.getActEmpMSpiffJsa();
   String sActEmpTot = bdgwk.getActEmpTotJsa();
   String sActEmpBdgGrp = bdgwk.getActEmpBdgGrpJsa();
   String sActEmpAvgPay = bdgwk.getActEmpAvgPayJsa();
   String sActEmpAvgCom = bdgwk.getActEmpAvgComJsa();
   String sActEmpAvgLSpiff = bdgwk.getActEmpAvgLSpiffJsa();
   String sActEmpAvgMSpiff = bdgwk.getActEmpAvgMSpiffJsa();
   String sActEmpAvgTot = bdgwk.getActEmpAvgTotJsa();
   String sActEmpSlsRet = bdgwk.getActEmpSlsRetJsa();
   String sActEmpIncPay = bdgwk.getActEmpIncPayJsa();
   String sActEmpAvgIncPay = bdgwk.getActEmpAvgIncPayJsa();

   // Actual Employees Budget Group totals
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
   String sActEmpGrpSlsRet = bdgwk.getActEmpGrpslsRetJsa();
   String sActEmpGrpIncPay = bdgwk.getActEmpGrpIncPayJsa();
   String sActEmpGrpAvgIncPay = bdgwk.getActEmpGrpAvgIncPayJsa();


   // Scheduled Employees Budget Group totals
   String sSchGrpName = bdgwk.getSchGrpNameJsa();
   String sSchGrpHrs = bdgwk.getSchGrpHrsJsa();
   String sSchGrpPay = bdgwk.getSchGrpPayJsa();
   String sSchGrpCom = bdgwk.getSchGrpComJsa();
   String sSchGrpLSpiff = bdgwk.getSchGrpLSpiffJsa();
   String sSchGrpMSpiff = bdgwk.getSchGrpMSpiffJsa();
   String sSchGrpTot = bdgwk.getSchGrpTotJsa();
   String sSchGrpAvgPay = bdgwk.getSchGrpAvgPayJsa();
   String sSchGrpAvgCom = bdgwk.getSchGrpAvgComJsa();
   String sSchGrpAvgLSpiff = bdgwk.getSchGrpAvgLSpiffJsa();
   String sSchGrpAvgMSpiff = bdgwk.getSchGrpAvgMSpiffJsa();
   String sSchGrpAvgTot = bdgwk.getSchGrpAvgTotJsa();
   String sSchGrpSlsRet = bdgwk.getSchGrpslsRetJsa();
   String sSchGrpIncPay = bdgwk.getSchGrpIncPayJsa();
   String sSchGrpAvgIncPay = bdgwk.getSchGrpAvgIncPayJsa();

   // total for actual & schedule
   String sTotGrpName = bdgwk.getTotGrpNameJsa();
   String sTotGrpHrs = bdgwk.getTotGrpHrsJsa();
   String sTotGrpPay = bdgwk.getTotGrpPayJsa();
   String sTotGrpCom = bdgwk.getTotGrpComJsa();
   String sTotGrpLSpiff = bdgwk.getTotGrpLSpiffJsa();
   String sTotGrpMSpiff = bdgwk.getTotGrpMSpiffJsa();
   String sTotGrpTot = bdgwk.getTotGrpTotJsa();
   String sTotGrpAvgPay = bdgwk.getTotGrpAvgPayJsa();
   String sTotGrpAvgCom = bdgwk.getTotGrpAvgComJsa();
   String sTotGrpAvgLSpiff = bdgwk.getTotGrpAvgLSpiffJsa();
   String sTotGrpAvgMSpiff = bdgwk.getTotGrpAvgMSpiffJsa();
   String sTotGrpAvgTot = bdgwk.getTotGrpAvgTotJsa();
   String sTotGrpSlsRet = bdgwk.getTotGrpslsRetJsa();
   String sTotGrpIncPay = bdgwk.getTotGrpIncPayJsa();
   String sTotGrpAvgIncPay = bdgwk.getTotGrpAvgIncPayJsa();

   // total for actual & schedule
   String sLyGrpName = bdgwk.getLyGrpNameJsa();
   String sLyGrpHrs = bdgwk.getLyGrpHrsJsa();
   String sLyGrpPay = bdgwk.getLyGrpPayJsa();
   String sLyGrpCom = bdgwk.getLyGrpComJsa();
   String sLyGrpLSpiff = bdgwk.getLyGrpLSpiffJsa();
   String sLyGrpMSpiff = bdgwk.getLyGrpMSpiffJsa();
   String sLyGrpTot = bdgwk.getLyGrpTotJsa();
   String sLyGrpAvgPay = bdgwk.getLyGrpAvgPayJsa();
   String sLyGrpAvgCom = bdgwk.getLyGrpAvgComJsa();
   String sLyGrpAvgLSpiff = bdgwk.getLyGrpAvgLSpiffJsa();
   String sLyGrpAvgMSpiff = bdgwk.getLyGrpAvgMSpiffJsa();
   String sLyGrpAvgTot = bdgwk.getLyGrpAvgTotJsa();
   String sLyGrpSlsRet = bdgwk.getLyGrpSlsRetJsa();
   String sLyGrpIncPay = bdgwk.getLyGrpIncPayJsa();
   String sLyGrpAvgIncPay = bdgwk.getLyGrpAvgIncPayJsa();

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

   // Base budget
   String sBaseBdg = bdgwk.getBaseBdg();
   String sBaseHrlyHrs = bdgwk.getBaseHrlyHrs();

   // Override Ab calculated hours
   String sAbOvrHrs = bdgwk.getAbOvrHrs();
   String sAbOvrComment = bdgwk.getAbOvrComment();
   String sAbOvrUser = bdgwk.getAbOvrUser();
   String sAbOvrDate = bdgwk.getAbOvrDate();
   String sAbOvrTime = bdgwk.getAbOvrTime();

   // warnins
   String sWarnLine13 = bdgwk.getWarnLine13();
   String sWarnLine23 = bdgwk.getWarnLine23();

   // salary employee/days
   String sSlrCurOrBase = bdgwk.getSlrCurOrBaseJsa();
   String sSlrEmpNm = bdgwk.getSlrEmpNmJsa();
   String sSlrEmpDt = bdgwk.getSlrEmpDtJsa();

   int iNumOfPassDays = bdgwk.getNumOfPassDays();
   String [] sCssClsAdd = new String[8];
   for(int i=0; i < 7; i++)
   {
      if(iNumOfPassDays > 0 && i < iNumOfPassDays) sCssClsAdd[i] = "p";
      else if(iNumOfPassDays == 7) sCssClsAdd[i] = "p";
      else { sCssClsAdd[i] = ""; }
   }
   sCssClsAdd[7] = "";

   String [] sWkDays = new String[]{"Mon","Tue","Wed","Thu","Fri","Sat","Sun", "Total"};

   SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
   Date dWkEndDt = sdf.parse(sWkend);

   long lBegDate = dWkEndDt.getTime() - 86400000 * 6;

   Date dCurDate = new Date();
   long lSelDate = dWkEndDt.getTime();
   long lCurDate = dCurDate.getTime();
   boolean bChgOfTrendAllowed = lSelDate >= lCurDate;
   boolean bCurWeek = lSelDate >= lCurDate &&  lBegDate <= lCurDate;

   boolean bAvOvrHrsAllowed = sUser.equals("mparker")
                           || sUser.equals("vrozen")
                           || sUser.equals("jlegaspi")
                           || sUser.equals("bswann")
                           ;
%>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}

        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:middle ;font-size:12px }
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

        th.DataTable1 { background:fa9b17;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top ;font-size:12px }
        th.DataTable11 { background:coral ;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top ;font-size:12px }
        th.DataTable12 { background:charTReuse ;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top ;font-size:12px }
        th.DataTable13 { background: #46c7c7; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top ;font-size:12px }
        th.DataTable14 { background: #fff380; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top ;font-size:12px }
        th.DataTable15 { background: #f75d59; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top ;font-size:12px }

        th.DataTable2 { background:fa9b17; padding-top:3px; padding-bottom:3px;
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

        th.DataTable3 { background:#ccccff; padding-top:3px; padding-bottom:3px; font-size:12px }
        th.DataTable31 { border-top: grey solid 3px;  background:#ccccff; padding-top:3px; padding-bottom:3px; font-size:12px; text-align:left;}
        th.DataTable311 { background:#ccccff; padding-top:3px; padding-bottom:3px; font-size:12px; text-align:left;}
        th.DataTable32 { border-top: grey solid 3px;  background:#E2F3ED; padding-top:3px; padding-bottom:3px; font-size:12px; text-align:left;}
        th.DataTable321 { border-bottom: black solid 3px;  background:#E2F3ED; padding-top:3px; padding-bottom:3px; font-size:12px; text-align:left;}
        th.DataTable322 { background:#E2F3ED; padding-top:3px; padding-bottom:3px; font-size:12px; text-align:left;}

        th.DataTable4 { padding-top:3px; padding-bottom:3px;
                       text-align:left; vertical-align:top ;font-size:12px }
        th.DataTable41 { padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable5 { filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#FDC4A9, endColorStr=#D08560);
                       padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:middle ;font-size:12px }

        tr.DataTable { background: white; font-size:12px }
        tr.DataTable1 { background: yellow; font-size:12px }
        tr.Divdr1 { background: darkred; font-size:1px }
        th.Divdr2l { border-left: black solid 3px; background:#ccccff;  font-size:1px}
        th.Divdr2r { border-right: black solid 3px; background:#ccccff;  font-size:1px}
        th.Divdr2b { border-bottom: black solid 3px; background:#ccccff;  font-size:1px}
        th.Divdr2t { border-top: black solid 3px; background:#ccccff;  font-size:1px}
        tr.DataTable2 { background: #ccccff; font-size:10px }
        tr.DataTable3 { background: #ccffcc; font-size:10px }
        tr.DataTable31 { background: #ffff99; font-size:10px }
        tr.DataTable32 { background: gold; font-size:10px }
        tr.DataTable33 { background: white; font-size:10px }
        tr.DataTable4 { color: Maroon; background: Khaki; font-size:12px }
        tr.DataTable5 { background: #ccffcc; font-size:12px; vertical-align:top}

        tr.DataTable6 { border-top: red solid 1px; background: #ccffcc; font-size:12px; vertical-align:top}



        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2d { border-bottom: black solid 3px; padding-top:3px; padding-bottom:3px; padding-left:3px;
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

        td.DataTable212 { background: tan; padding-top:3px; padding-bottom:3px; padding-left:3px;
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

        div.dvWkSel { border: black solid 2px; position:absolute; background-attachment: scroll;
                      width:200; background-color:LemonChiffon; z-index:10;
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
<script LANGUAGE="JavaScript" src="Calendar.js"></script>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variables
//==============================================================================
var ActEmp = [<%=sActEmp%>];
var ActEmpName = [<%=sActEmpName%>];
var ActEmpHorS = [<%=sActEmpHorS%>];
var ActEmpDept = [<%=sActEmpDept%>];
var ActEmpStr = [<%=sActEmpStr%>];
var ActEmpHrs = [<%=sActEmpHrs%>];
var ActEmpPay = [<%=sActEmpPay%>];
var ActEmpCom = [<%=sActEmpCom%>];
var ActEmpLSpiff = [<%=sActEmpLSpiff%>];
var ActEmpMSpiff = [<%=sActEmpMSpiff%>];
var ActEmpTot = [<%=sActEmpTot%>];
var ActEmpBdgGrp = [<%=sActEmpBdgGrp%>];
var ActEmpAvgPay = [<%=sActEmpAvgPay%>];
var ActEmpAvgCom = [<%=sActEmpAvgCom%>];
var ActEmpAvgLSpiff = [<%=sActEmpAvgLSpiff%>];
var ActEmpAvgMSpiff = [<%=sActEmpAvgMSpiff%>];
var ActEmpAvgTot = [<%=sActEmpAvgTot%>];
var ActEmpSlsRet = [<%=sActEmpSlsRet%>];
var ActEmpIncPay = [<%=sActEmpIncPay%>];
var ActEmpAvgIncPay = [<%=sActEmpAvgIncPay%>];

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

var SchGrpName = [<%=sSchGrpName%>];
var SchGrpHrs = [<%=sSchGrpHrs%>];
var SchGrpPay = [<%=sSchGrpPay%>];
var SchGrpCom = [<%=sSchGrpCom%>];
var SchGrpLSpiff = [<%=sSchGrpLSpiff%>];
var SchGrpMSpiff = [<%=sSchGrpMSpiff%>];
var SchGrpTot = [<%=sSchGrpTot%>];
var SchGrpAvgPay = [<%=sSchGrpAvgPay%>];
var SchGrpAvgCom = [<%=sSchGrpAvgCom%>];
var SchGrpAvgLSpiff = [<%=sSchGrpAvgLSpiff%>];
var SchGrpAvgMSpiff = [<%=sSchGrpAvgMSpiff%>];
var SchGrpAvgTot = [<%=sSchGrpAvgTot%>];
var SchGrpSlsRet = [<%=sSchGrpSlsRet%>];
var SchGrpIncPay = [<%=sSchGrpIncPay%>];
var SchGrpAvgIncPay = [<%=sSchGrpAvgIncPay%>];

var TotGrpName = [<%=sTotGrpName%>];
var TotGrpHrs = [<%=sTotGrpHrs%>];
var TotGrpPay = [<%=sTotGrpPay%>];
var TotGrpCom = [<%=sTotGrpCom%>];
var TotGrpLSpiff = [<%=sTotGrpLSpiff%>];
var TotGrpMSpiff = [<%=sTotGrpMSpiff%>];
var TotGrpTot = [<%=sTotGrpTot%>];
var TotGrpAvgPay = [<%=sTotGrpAvgPay%>];
var TotGrpAvgCom = [<%=sTotGrpAvgCom%>];
var TotGrpAvgLSpiff = [<%=sTotGrpAvgLSpiff%>];
var TotGrpAvgMSpiff = [<%=sTotGrpAvgMSpiff%>];
var TotGrpAvgTot = [<%=sTotGrpAvgTot%>];
var TotGrpSlsRet = [<%=sTotGrpSlsRet%>];
var TotGrpIncPay = [<%=sTotGrpIncPay%>];
var TotGrpAvgIncPay = [<%=sTotGrpAvgIncPay%>];

var LyGrpName = [<%=sLyGrpName%>];
var LyGrpHrs = [<%=sLyGrpHrs%>];
var LyGrpPay = [<%=sLyGrpPay%>];
var LyGrpCom = [<%=sLyGrpCom%>];
var LyGrpLSpiff = [<%=sLyGrpLSpiff%>];
var LyGrpMSpiff = [<%=sLyGrpMSpiff%>];
var LyGrpTot = [<%=sLyGrpTot%>];
var LyGrpAvgPay = [<%=sLyGrpAvgPay%>];
var LyGrpAvgCom = [<%=sLyGrpAvgCom%>];
var LyGrpAvgLSpiff = [<%=sLyGrpAvgLSpiff%>];
var LyGrpAvgMSpiff = [<%=sLyGrpAvgMSpiff%>];
var LyGrpAvgTot = [<%=sLyGrpAvgTot%>];
var LyGrpSlsRet = [<%=sLyGrpSlsRet%>];
var LyGrpIncPay = [<%=sLyGrpIncPay%>];
var LyGrpAvgIncPay = [<%=sLyGrpAvgIncPay%>];

var AltSort = new Array(ActEmp.length - 1);
var SortBy = "EMPLOYEE";

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

var BaseBdg = "<%=sBaseBdg%>";
var BaseHrlyHrs = "<%=sBaseHrlyHrs%>";

var SlrCurOrBase = [<%=sSlrCurOrBase%>];
var SlrEmpNm = [<%=sSlrEmpNm%>];
var SlrEmpDt = [<%=sSlrEmpDt%>];

var AbOvrHrs = "<%=sAbOvrHrs%>";
var AbOvrComment = "<%=sAbOvrComment%>";
var AbOvrUser = "<%=sAbOvrUser%>";
var AbOvrDate = "<%=sAbOvrDate%>";
var AbOvrTime = "<%=sAbOvrTime%>";

var WkDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
//==============================================================================

function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvEmpList", "dvSlsGoal"]);
   doSelDate();
   <%if(!sUser.equals("vrozen")){%>
      //foldLines();
   <%}%>
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  doSelDate()
{
  var date = new Date(new Date() - 86400000);
  var dofw = date.getDay();
  date = new Date(date - 86400000 * (dofw - 7));
  document.all.Wkend.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// show Employee actual hours and payments
//==============================================================================
function showActEmp()
{
  var hdr = "Employees Actual Hours and Payments<br>with exceptions (V,H,S)";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popActEmpPanel()

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
function popActEmpPanel()
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
  panel += "<tr class='DataTable2'>"
             + "<th class='DataTable3' rowspan=2 nowrap><a href='javascript: sortActEmp(0)'>Emp<br>Num</a></th>"
             + "<th class='DataTable3' rowspan=2 nowrap>Employee<br>Name</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>Hours<br>or<br>Salary</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>Dept</th>"
             + "<th class='DataTable3' rowspan=2 nowrap><a href='javascript: sortActEmp(1)'>Budget<br>Group</a></th>"
             + "<th class='DataTable3' rowspan=2 nowrap>Orig<br>Str</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>Hrs</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' colspan=6 nowrap>Payroll Dollars</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' colspan=6 nowrap>Average Rates</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>Sales<br>Retail</th>"
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

  for(var  i=0, j=0; i < ActEmp.length; i++)
  {
     if (SortBy=="BDGGRP"){ j = AltSort[i];}
     else{ j = i; }

     if(ActEmpName[j].indexOf("Total") > 0)
     {
      panel += "<tr class='DataTable31'>"
             + "<td class='DataTable1' colspan=6>" + ActEmpName[j] + "</td>"
     }
     else
     {
       panel += "<tr class='DataTable3'>"
             + "<td class='DataTable' nowrap>" + ActEmp[j] + "</td>"
             + "<td class='DataTable1' nowrap>" + ActEmpName[j] + "</td>"
             + "<td class='DataTable' nowrap>" + ActEmpHorS[j] + "</td>"
             + "<td class='DataTable' nowrap>" + ActEmpDept[j] + "</td>"
             + "<td class='DataTable1' nowrap>" + ActEmpBdgGrp[j] + "</td>"
             + "<td class='DataTable2' nowrap>" + ActEmpStr[j] + "</td>"
     }
     panel += "<td class='DataTable2' nowrap>" + ActEmpHrs[j] + "</td>"
           + "<th class='DataTable3' nowrap>&nbsp;</th>"
           + "<td class='DataTable2' nowrap>$" + ActEmpPay[j] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpCom[j] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpLSpiff[j] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpMSpiff[j] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpIncPay[j] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpTot[j] + "</td>"

           + "<th class='DataTable3' nowrap>&nbsp;</th>"

           + "<td class='DataTable2' nowrap>$" + ActEmpAvgPay[j] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpAvgCom[j] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpAvgLSpiff[j] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpAvgMSpiff[j] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpAvgIncPay[j] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpAvgTot[j] + "</td>"

           + "<th class='DataTable3' nowrap>&nbsp;</th>"
           + "<td class='DataTable2' nowrap>$" + ActEmpSlsRet[j] + "</td>"

         + "</tr>"

  }

  panel += "<tr><td class='Prompt1' colspan=23>"
        + "<button onClick='hidePanel();' class='Small'>Close</button> &nbsp; &nbsp;"
        + "<button onClick='printTblContent(&#34;dvEmpList&#34;);' class='Small'>Print</button>"
        + "</td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// sort by column
//==============================================================================
function sortActEmp(col)
{
   if (col == 1)
   {
      var empArr = new Array(ActEmp.length - 1);

      for(var i=0; i < ActEmp.length - 1; i++)
      {
         empArr[i] = ActEmpBdgGrp[i] + "@$@" + i;
      }

      empArr.sort()

      for(var i=0; i < ActEmp.length - 1; i++)
      {
         AltSort[i] = eval(empArr[i].substring(empArr[i].indexOf("@$@") + 3));
      }
      AltSort[ActEmp.length - 1] = ActEmp.length - 1;
      SortBy = "BDGGRP";
   }
   else
   {
      SortBy = "EMPLOYEE";
   }
   showActEmp();
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
             + "<th class='DataTable3' colspan=6 nowrap>Payroll Dollars</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' colspan=6 nowrap>Average Rates</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>Sales<br>Retail</th>"
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
           + "<td class='DataTable2' nowrap>$" + ActEmpGrpIncPay[i] + "</td>"
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

  panel += "<tr><td class='Prompt1' colspan=18>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// show Scheduled Active employee hours by budget groups
//==============================================================================
function showSchActEmpGrp()
{
  var hdr = "Employees Schedule and Actual Hours and Payments by Budget Group<br>with exceptions (V,H,S)";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popSchActEmpGrpPanel()

   html += "</td></tr></table>"

   document.all.dvEmpList.innerHTML = html;
   document.all.dvEmpList.style.width = 250;
   document.all.dvEmpList.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvEmpList.style.pixelTop= document.documentElement.scrollTop + 10;
   document.all.dvEmpList.style.visibility = "visible";

   switchCol("tdActPay", "thAllAct", "thActPay", 5);
   switchCol("tdActAvg", "thAllAct", "thActAvg", 5);
   switchCol("tdSchPay", "thAllSch", "thSchPay", 5);
   switchCol("tdSchAvg", "thAllSch", "thSchAvg", 5);
   switchCol("tdTotPay", "thAllTot", "thTotPay", 5);
   switchCol("tdTotAvg", "thAllTot", "thTotAvg", 5);
}
//--------------------------------------------------------
// populate Column Panel
//--------------------------------------------------------
function popSchActEmpGrpPanel()
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
  panel += "<tr class='DataTable2'>"
             + "<th class='DataTable3' rowspan=3 nowrap>Group</th>"
             + "<th class='DataTable3' id='thAllAct' colspan=17 nowrap><a href='javascript: switchCol(&#34;tdActPay&#34;, &#34;thAllAct&#34;, &#34;thActPay&#34;, 5); switchCol(&#34;tdActAvg&#34;, &#34;thAllAct&#34;, &#34;thActAvg&#34;, 5)'>Actual</a></th>"
             + "<th class='DataTable3' rowspan=3 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' id='thAllSch' colspan=15 nowrap><a href='javascript: switchCol(&#34;tdSchPay&#34;, &#34;thAllSch&#34;, &#34;thSchPay&#34;, 5); switchCol(&#34;tdSchAvg&#34;, &#34;thAllSch&#34;, &#34;thSchAvg&#34;, 5)'>Schedule</a></th>"
             + "<th class='DataTable3' rowspan=3 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' id='thAllTot' colspan=15 nowrap><a href='javascript: switchCol(&#34;tdTotPay&#34;, &#34;thAllTot&#34;, &#34;thTotPay&#34;, 5); switchCol(&#34;tdTotAvg&#34;, &#34;thAllTot&#34;, &#34;thTotAvg&#34;, 5)'>Total</a></th>"

         + "</tr>"
         + "<tr class='DataTable2'>"
             + "<th class='DataTable3' rowspan=2 nowrap>Hrs</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' id='thActPay' colspan=6 nowrap>Payroll Dollars</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' id='thActAvg' colspan=6 nowrap>Average Rates</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>Sales<br>Retail</th>"

             + "<th class='DataTable3' rowspan=2 nowrap>Hrs</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' id='thSchPay'  colspan=6 nowrap>Payroll Dollars</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' id='thSchAvg' colspan=6 nowrap>Average Rates</th>"

             + "<th class='DataTable3' rowspan=2 nowrap>Hrs</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' id='thTotPay'  colspan=6 nowrap>Payroll Dollars</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' id='thTotAvg' colspan=6 nowrap>Average Rates</th>"
         + "</tr>"
         + "<tr class='DataTable2'>"
             + "<th class='DataTable3' id='tdActPay' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdActPay' nowrap>Sales<br>Comm</th>"
             + "<th class='DataTable3' id='tdActPay' nowrap>Labor<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdActPay' nowrap>Paid<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdActPay' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Total<br>Pay</th>"

             + "<th class='DataTable3' id='tdActAvg' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdActAvg' nowrap>Sales<br>Comm</th>"
             + "<th class='DataTable3' id='tdActAvg' nowrap>Labor<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdActAvg' nowrap>Paid<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdActAvg' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Total<br>Pay</th>"

             + "<th class='DataTable3' id='tdSchPay'  nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdSchPay' nowrap>Sales<br>Comm</th>"
             + "<th class='DataTable3' id='tdSchPay' nowrap>Labor<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdSchPay' nowrap>Paid<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdSchPay' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Total<br>Pay</th>"

             + "<th class='DataTable3' id='tdSchAvg' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdSchAvg' nowrap>Sales<br>Comm</th>"
             + "<th class='DataTable3' id='tdSchAvg' nowrap>Labor<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdSchAvg' nowrap>Paid<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdSchAvg' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Total<br>Pay</th>"

             + "<th class='DataTable3' id='tdTotPay'  nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdTotPay' nowrap>Sales<br>Comm</th>"
             + "<th class='DataTable3' id='tdTotPay' nowrap>Labor<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdTotPay' nowrap>Paid<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdTotPay' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Total<br>Pay</th>"

             + "<th class='DataTable3' id='tdTotAvg' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdTotAvg' nowrap>Sales<br>Comm</th>"
             + "<th class='DataTable3' id='tdTotAvg' nowrap>Labor<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdTotAvg' nowrap>Paid<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdTotAvg' nowrap>Other</th>"
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
           + "<td class='DataTable2' id='tdActPay' nowrap>$" + ActEmpGrpPay[i] + "</td>"
           + "<td class='DataTable2' id='tdActPay' nowrap>$" + ActEmpGrpCom[i] + "</td>"
           + "<td class='DataTable2' id='tdActPay' nowrap>$" + ActEmpGrpLSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdActPay' nowrap>$" + ActEmpGrpMSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdActPay' nowrap>$" + ActEmpGrpIncPay[i] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpGrpTot[i] + "</td>"

           + "<th class='DataTable3' nowrap>&nbsp;</th>"

           + "<td class='DataTable2' id='tdActAvg' nowrap>$" + ActEmpGrpAvgPay[i] + "</td>"
           + "<td class='DataTable2' id='tdActAvg' nowrap>$" + ActEmpGrpAvgCom[i] + "</td>"
           + "<td class='DataTable2' id='tdActAvg' nowrap>$" + ActEmpGrpAvgLSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdActAvg' nowrap>$" + ActEmpGrpAvgMSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdActAvg' nowrap>$" + ActEmpGrpAvgIncPay[i] + "</td>"
           + "<td class='DataTable2' nowrap>$" + ActEmpGrpAvgTot[i] + "</td>"
           + "<th class='DataTable3' nowrap>&nbsp;</th>"
           + "<td class='DataTable2' nowrap>$" + ActEmpGrpSlsRet[i] + "</td>"

           + "<th class='DataTable3' nowrap>&nbsp;</th>"

           + "<td class='DataTable2' nowrap>" + SchGrpHrs[i] + "</td>"
           + "<th class='DataTable3' nowrap>&nbsp;</th>"
           + "<td class='DataTable2' id='tdSchPay' nowrap>$" + SchGrpPay[i] + "</td>"
           + "<td class='DataTable2' id='tdSchPay' nowrap>$" + SchGrpCom[i] + "</td>"
           + "<td class='DataTable2' id='tdSchPay' nowrap>$" + SchGrpLSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdSchPay' nowrap>$" + SchGrpMSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdSchPay' nowrap>$" + SchGrpIncPay[i] + "</td>"
           + "<td class='DataTable2' nowrap>$" + SchGrpTot[i] + "</td>"

           + "<th class='DataTable3' nowrap>&nbsp;</th>"

           + "<td class='DataTable2' id='tdSchAvg' nowrap>$" + SchGrpAvgPay[i] + "</td>"
           + "<td class='DataTable2' id='tdSchAvg' nowrap>$" + SchGrpAvgCom[i] + "</td>"
           + "<td class='DataTable2' id='tdSchAvg' nowrap>$" + SchGrpAvgLSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdSchAvg' nowrap>$" + SchGrpAvgMSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdSchAvg' nowrap>$" + SchGrpAvgIncPay[i] + "</td>"
           + "<td class='DataTable2' nowrap>$" + SchGrpAvgTot[i] + "</td>"

           + "<th class='DataTable3' nowrap>&nbsp;</th>"

           + "<td class='DataTable2' nowrap>" + TotGrpHrs[i] + "</td>"
           + "<th class='DataTable3' nowrap>&nbsp;</th>"
           + "<td class='DataTable2' id='tdTotPay' nowrap>$" + TotGrpPay[i] + "</td>"
           + "<td class='DataTable2' id='tdTotPay' nowrap>$" + TotGrpCom[i] + "</td>"
           + "<td class='DataTable2' id='tdTotPay' nowrap>$" + TotGrpLSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdTotPay' nowrap>$" + TotGrpMSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdTotPay' nowrap>$" + TotGrpIncPay[i] + "</td>"
           + "<td class='DataTable2' nowrap>$" + TotGrpTot[i] + "</td>"

           + "<th class='DataTable3' nowrap>&nbsp;</th>"

           + "<td class='DataTable2' id='tdTotAvg' nowrap>$" + TotGrpAvgPay[i] + "</td>"
           + "<td class='DataTable2' id='tdTotAvg' nowrap>$" + TotGrpAvgCom[i] + "</td>"
           + "<td class='DataTable2' id='tdTotAvg' nowrap>$" + TotGrpAvgLSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdTotAvg' nowrap>$" + TotGrpAvgMSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdTotAvg' nowrap>$" + TotGrpAvgIncPay[i] + "</td>"
           + "<td class='DataTable2' nowrap>$" + TotGrpAvgTot[i] + "</td>"
         + "</tr>"
  }

  panel += "<tr><td class='Prompt1' colspan=50>"
        + "<button onClick='hidePanel();' class='Small'>Close</button> &nbsp; &nbsp;"
        + "<button onClick='printTblContent(&#34;dvEmpList&#34;);' class='Small'>Print</button>"
        + "</td></tr>"

  panel += "</table>";

  return panel;
}


//==============================================================================
// show Employee actual hours and payments by budget groups
//==============================================================================
function showLyActGrp()
{
  var hdr = "Employees Actual Hours and Payments by Budget Group<br>with exceptions (V,H,S)";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popLyActGrpPanel()

   html += "</td></tr></table>"

   document.all.dvEmpList.innerHTML = html;
   document.all.dvEmpList.style.width = 250;
   document.all.dvEmpList.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvEmpList.style.pixelTop= document.documentElement.scrollTop + 10;
   document.all.dvEmpList.style.visibility = "visible";

   switchCol("tdActPay", "thAllAct", "thActPay", 5);
   switchCol("tdActAvg", "thAllAct", "thActAvg", 5);
   switchCol("tdTotPay", "thAllTot", "thTotPay", 5);
   switchCol("tdTotAvg", "thAllTot", "thTotAvg", 5);
}
//--------------------------------------------------------
// populate Column Panel
//--------------------------------------------------------
function popLyActGrpPanel()
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
  panel += "<tr class='DataTable2'>"
             + "<th class='DataTable3' id='thAllTot' colspan=16 nowrap><a href='javascript: switchCol(&#34;tdTotPay&#34;, &#34;thAllTot&#34;, &#34;thTotPay&#34;, 5); switchCol(&#34;tdTotAvg&#34;, &#34;thAllTot&#34;, &#34;thTotAvg&#34;, 5)'>This Year Total</a></th>"
             + "<th class='DataTable3' rowspan=3 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' id='thAllAct' colspan=15 nowrap><a href='javascript: switchCol(&#34;tdActPay&#34;, &#34;thAllAct&#34;, &#34;thActPay&#34;, 5); switchCol(&#34;tdActAvg&#34;, &#34;thAllAct&#34;, &#34;thActAvg&#34;, 5)'>Last Year Totals</a></th>"
         + "</tr>"
         + "<tr class='DataTable2'>"
             + "<th class='DataTable3' rowspan=2 nowrap>Group</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>Hrs</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' id='thTotPay' colspan=6 nowrap>Payroll Dollars</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' id='thTotAvg' colspan=6 nowrap>Average Rates</th>"

             + "<th class='DataTable3' rowspan=2 nowrap>Hrs</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' id='thActPay' colspan=6 nowrap>Payroll Dollars</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' id='thActAvg' colspan=6 nowrap>Average Rates</th>"
         + "</tr>"
         + "<tr class='DataTable2'>"
             + "<th class='DataTable3' id='tdTotPay' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdTotPay' nowrap>Sales<br>Comm</th>"
             + "<th class='DataTable3' id='tdTotPay' nowrap>Labor<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdTotPay' nowrap>Paid<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdTotPay' nowrap>Others</th>"
             + "<th class='DataTable3' nowrap>Total<br>Pay</th>"

             + "<th class='DataTable3' id='tdTotAvg' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdTotAvg' nowrap>Sales<br>Comm</th>"
             + "<th class='DataTable3' id='tdTotAvg' nowrap>Labor<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdTotAvg' nowrap>Paid<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdTotAvg' nowrap>Others</th>"
             + "<th class='DataTable3' nowrap>Total<br>Pay</th>"

             + "<th class='DataTable3' id='tdActPay' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdActPay' nowrap>Sales<br>Comm</th>"
             + "<th class='DataTable3' id='tdActPay' nowrap>Labor<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdActPay' nowrap>Paid<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdActPay' nowrap>Others</th>"
             + "<th class='DataTable3' nowrap>Total<br>Pay</th>"

             + "<th class='DataTable3' id='tdActAvg' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdActAvg' nowrap>Sales<br>Comm</th>"
             + "<th class='DataTable3' id='tdActAvg' nowrap>Labor<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdActAvg' nowrap>Paid<br>Spiffs</th>"
             + "<th class='DataTable3' id='tdActAvg' nowrap>Others</th>"
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
     panel += "<td class='DataTable2' nowrap>" + TotGrpHrs[i] + "</td>"
           + "<th class='DataTable3' nowrap>&nbsp;</th>"
           + "<td class='DataTable2' id='tdTotPay' nowrap>$" + TotGrpPay[i] + "</td>"
           + "<td class='DataTable2' id='tdTotPay' nowrap>$" + TotGrpCom[i] + "</td>"
           + "<td class='DataTable2' id='tdTotPay' nowrap>$" + TotGrpLSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdTotPay' nowrap>$" + TotGrpMSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdTotPay' nowrap>$0</td>"
           + "<td class='DataTable2' nowrap>$" + TotGrpTot[i] + "</td>"

           + "<th class='DataTable3' nowrap>&nbsp;</th>"

           + "<td class='DataTable2' id='tdTotAvg' nowrap>$" + TotGrpAvgPay[i] + "</td>"
           + "<td class='DataTable2' id='tdTotAvg' nowrap>$" + TotGrpAvgCom[i] + "</td>"
           + "<td class='DataTable2' id='tdTotAvg' nowrap>$" + TotGrpAvgLSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdTotAvg' nowrap>$" + TotGrpAvgMSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdTotAvg' nowrap>$" + TotGrpAvgIncPay[i] + "</td>"
           + "<td class='DataTable2' nowrap>$" + TotGrpAvgTot[i] + "</td>"

           + "<th class='DataTable3' nowrap>&nbsp;</th>"

           + "<td class='DataTable2' nowrap>" + LyGrpHrs[i] + "</td>"
           + "<th class='DataTable3' nowrap>&nbsp;</th>"
           + "<td class='DataTable2' id='tdActPay' nowrap>$" + LyGrpPay[i] + "</td>"
           + "<td class='DataTable2' id='tdActPay' nowrap>$" + LyGrpCom[i] + "</td>"
           + "<td class='DataTable2' id='tdActPay' nowrap>$" + LyGrpLSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdActPay' nowrap>$" + LyGrpMSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdActPay' nowrap>$" + LyGrpIncPay[i] + "</td>"
           + "<td class='DataTable2' nowrap>$" + LyGrpTot[i] + "</td>"

           + "<th class='DataTable3' nowrap>&nbsp;</th>"

           + "<td class='DataTable2' id='tdActAvg' nowrap>$" + LyGrpAvgPay[i] + "</td>"
           + "<td class='DataTable2' id='tdActAvg' nowrap>$" + LyGrpAvgCom[i] + "</td>"
           + "<td class='DataTable2' id='tdActAvg' nowrap>$" + LyGrpAvgLSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdActAvg' nowrap>$" + LyGrpAvgMSpiff[i] + "</td>"
           + "<td class='DataTable2' id='tdActAvg' nowrap>$0</td>"
           + "<td class='DataTable2' nowrap>$" + LyGrpAvgTot[i] + "</td>"
         + "</tr>"

  }

  panel += "<tr><td class='Prompt1' colspan=37>"
        + "<button onClick='hidePanel();' class='Small'>Close</button> &nbsp; &nbsp;"
        + "<button onClick='printTblContent(&#34;dvEmpList&#34;);' class='Small'>Print</button>"
        + "</td></tr>"

  panel += "</table>";

  return panel;
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
//--------------------------------------------------------
// populate Column Panel
//--------------------------------------------------------
function popGrpBdgPanel()
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
  panel += "<tr class='DataTable2'>"
             + "<th class='DataTable3' rowspan=2 nowrap>Group</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>Hours</th>"
             + "<th class='DataTable3' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' colspan=6 nowrap>Payroll Dollars</th>"
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
       var grpnm = GrpBdgName[i];
       if (GrpBdgName[i].indexOf("Total") >= 0) {  panel += "<tr class='DataTable32'>"; grpnm += " (excl. Bike Bldr. hrs.)"; }
       else {  panel += "<tr class='DataTable3'>" }
       panel += "<td class='DataTable1' nowrap>" + grpnm + "</td>"
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
        + "<button onClick='hidePanel();' class='Small'>Close</button> &nbsp; &nbsp;"
        + "<button onClick='printTblContent(&#34;dvEmpList&#34;);' class='Small'>Print</button>"
        + "</td></tr>"

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

   switchCol("tdBdgAvg", "thAllBdg", "thBdgAvg", 5);
   switchCol("tdActAvg", "thAllAct", "thActAvg", 5);
   switchCol("tdSchAvg", "thAllSch", "thSchAvg", 5);
   switchCol("tdTotAvg", "thAllTot", "thTotAvg", 5);
   switchCol("tdVarAvg", "thAllVar", "thVarAvg", 5);
}
//--------------------------------------------------------
// populate Column Panel
//--------------------------------------------------------
function popGrpBdgAvgPanel()
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
  panel += "<tr class='DataTable2'>"
             + "<th class='DataTable3' rowspan=2 nowrap>Group</th>"
             + "<th class='DataTable3' id='thAllBdg' colspan=7 nowrap><a href='javascript: switchCol(&#34;tdBdgAvg&#34;, &#34;thAllBdg&#34;, &#34;thBdgAvg&#34;, 5)'>Budget</a></th>"
             + "<th class='Divdr2r' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable31' id='thAllAct' colspan=7 nowrap><a href='javascript: switchCol(&#34;tdActAvg&#34;, &#34;thAllAct&#34;, &#34;thActAvg&#34;, 5)'>Actual</a></th>"
             + "<th class='Divdr2t' rowspan=2 nowrap>&nbsp</th>"
             + "<th class='DataTable31' id='thAllSch' colspan=7 nowrap><a href='javascript: switchCol(&#34;tdSchAvg&#34;, &#34;thAllSch&#34;, &#34;thSchAvg&#34;, 5)'>Schedule</a></th>"
             + "<th class='Divdr2t' rowspan=2 nowrap>&nbsp</th>"
             + "<th class='DataTable31' id='thAllTot' colspan=7 nowrap><a href='javascript: switchCol(&#34;tdTotAvg&#34;, &#34;thAllTot&#34;, &#34;thTotAvg&#34;, 5)'>Act + Sch</a></th>"
             + "<th class='Divdr2l' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable3' id='thAllVar' colspan=7 nowrap><a href='javascript: switchCol(&#34;tdVarAvg&#34;, &#34;thAllVar&#34;, &#34;thVarAvg&#34;, 5)'>Variances</th>"
         + "</tr>"
         + "<tr class='DataTable2'>"
             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' id='tdBdgAvg' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdBdgAvg' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' id='tdBdgAvg' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' id='tdBdgAvg' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' id='tdBdgAvg' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"

             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' id='tdActAvg' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdActAvg' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' id='tdActAvg' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' id='tdActAvg' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' id='tdActAvg' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"

             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' id='tdSchAvg' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdSchAvg' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' id='tdSchAvg' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' id='tdSchAvg' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' id='tdSchAvg' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"

             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' id='tdTotAvg' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdTotAvg' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' id='tdTotAvg' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' id='tdTotAvg' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' id='tdTotAvg' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"

             + "<th class='DataTable3' nowrap>Hrs</th>"
             + "<th class='DataTable3' id='tdVarAvg' nowrap>Reg<br>Earn</th>"
             + "<th class='DataTable3' id='tdVarAvg' nowrap>Sls<br>Comm</th>"
             + "<th class='DataTable3' id='tdVarAvg' nowrap>Labor<br>Spiff</th>"
             + "<th class='DataTable3' id='tdVarAvg' nowrap>Paid<br> Spiff</th>"
             + "<th class='DataTable3' id='tdVarAvg' nowrap>Other</th>"
             + "<th class='DataTable3' nowrap>Tot</th>"
         + "</tr>"

  var tdClass = "class='DataTable2'";
  var tdClassb = "class='DataTable3'";
  for(var  i=0, j=0; i < GrpBdg.length; i++)
  {
       if(i == GrpBdg.length-1){tdClass = "class='DataTable2d'"; tdClassb = "class='Divdr2b'";}

       grpnm = GrpBdgName[i];
       if (GrpBdgName[i].indexOf("Total") >= 0) {  panel += "<tr class='DataTable32'>"; grpnm += " (excl. Bike Bldr. hrs.)"; }
       else {  panel += "<tr class='DataTable3'>"; }

       j = getActEmpGrpArg(GrpBdgName[i]);

       panel += "<td class='DataTable1' nowrap>" + grpnm + "</td>"
             + "<td class='DataTable2' nowrap>" + GrpBdgHrs[i] + "</td>"
             + "<td class='DataTable2' id='tdBdgAvg' nowrap>$" + GrpBdgAvgPay[i] + "</td>"
             + "<td class='DataTable2' id='tdBdgAvg' nowrap>$" + GrpBdgAvgCom[i] + "</td>"
             + "<td class='DataTable2' id='tdBdgAvg' nowrap>$" + GrpBdgAvgLSpiff[i] + "</td>"
             + "<td class='DataTable2' id='tdBdgAvg' nowrap>$" + GrpBdgAvgMSpiff[i] + "</td>"
             + "<td class='DataTable2' id='tdBdgAvg' nowrap>$" + GrpBdgAvgOther[i] + "</td>"
             + "<td class='DataTable2' nowrap>$" + GrpBdgAvg[i] + "</td>"

             + "<th class='Divdr2r' nowrap>&nbsp;</th>"
             + "<td " + tdClass + " nowrap>" + ActEmpGrpHrs[j] + "</td>"
             + "<td " + tdClass + " id='tdActAvg' nowrap>$" + ActEmpGrpAvgPay[j] + "</td>"
             + "<td " + tdClass + " id='tdActAvg' nowrap>$" + ActEmpGrpAvgCom[j] + "</td>"
             + "<td " + tdClass + " id='tdActAvg' nowrap>$" + ActEmpGrpAvgLSpiff[j] + "</td>"
             + "<td " + tdClass + " id='tdActAvg' nowrap>$" + ActEmpGrpAvgMSpiff[j] + "</td>"
             + "<td " + tdClass + " id='tdActAvg' nowrap>$" + ActEmpGrpAvgIncPay[j] + "</td>"
             + "<td " + tdClass + " nowrap>$" + ActEmpGrpAvgTot[j] + "</td>"

             + "<th " + tdClassb + " nowrap>&nbsp</th>"
             + "<td " + tdClass + " nowrap>" + SchGrpHrs[j] + "</td>"
             + "<td " + tdClass + " id='tdSchAvg' nowrap>$" + SchGrpAvgPay[j] + "</td>"
             + "<td " + tdClass + " id='tdSchAvg' nowrap>$" + SchGrpAvgCom[j] + "</td>"
             + "<td " + tdClass + " id='tdSchAvg' nowrap>$" + SchGrpAvgLSpiff[j] + "</td>"
             + "<td " + tdClass + " id='tdSchAvg' nowrap>$" + SchGrpAvgMSpiff[j] + "</td>"
             + "<td " + tdClass + " id='tdSchAvg' nowrap>$" + SchGrpAvgIncPay[j] + "</td>"
             + "<td " + tdClass + " nowrap>$" + SchGrpAvgTot[j] + "</td>"

             + "<th " + tdClassb + " nowrap>&nbsp</th>"
             + "<td " + tdClass + " nowrap>" + TotGrpHrs[j] + "</td>"
             + "<td " + tdClass + " id='tdTotAvg' nowrap>$" + TotGrpAvgPay[j] + "</td>"
             + "<td " + tdClass + " id='tdTotAvg' nowrap>$" + TotGrpAvgCom[j] + "</td>"
             + "<td " + tdClass + " id='tdTotAvg' nowrap>$" + TotGrpAvgLSpiff[j] + "</td>"
             + "<td " + tdClass + " id='tdTotAvg' nowrap>$" + TotGrpAvgMSpiff[j] + "</td>"
             + "<td " + tdClass + " id='tdTotAvg' nowrap>$" + TotGrpAvgIncPay[j] + "</td>"
             + "<td " + tdClass + " nowrap>$" + TotGrpAvgTot[j] + "</td>"

             + "<th class='Divdr2l' nowrap>&nbsp;</th>"
             + "<td class='DataTable2' nowrap>" + VarGrpHrs[j] + "</td>"
             + "<td class='DataTable2' id='tdVarAvg' nowrap>$" + VarGrpAvgPay[j] + "</td>"
             + "<td class='DataTable2' id='tdVarAvg' nowrap>$" + VarGrpAvgCom[j] + "</td>"
             + "<td class='DataTable2' id='tdVarAvg' nowrap>$" + VarGrpAvgLSpiff[j] + "</td>"
             + "<td class='DataTable2' id='tdVarAvg' nowrap>$" + VarGrpAvgMSpiff[j] + "</td>"
             + "<td class='DataTable2' id='tdVarAvg' nowrap>$" + VarGrpAvgIncPay[j] + "</td>"
             + "<td class='DataTable2' nowrap>$" + VarGrpAvgTot[j] + "</td>"
         + "</tr>"

  }

  panel += "<tr><td class='Prompt1' colspan=44>"
        + "<button onClick='hidePanel();' class='Small'>Close</button> &nbsp; &nbsp;"
        + "<button onClick='printTblContent(&#34;dvEmpList&#34;);' class='Small'>Print</button>"
        + "</td></tr>"

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
      ActEmpGrpSlsRet[max] = 0;
      arg = max;
   }

   return arg;
}

//==============================================================================
// fold/unfold columns
//==============================================================================
function switchCol(cellId, hdrId1, hdrId2, numcol)
{
   var status = null;
   var cell = document.all[cellId];
   var hdr1 = document.all[hdrId1];
   var hdr2 = document.all[hdrId2];

   if(cell[0].style.display != "none")
   {
      status = "none";
      if(hdr1 != null) { hdr1.colSpan = hdr1.colSpan - numcol; }
      if(hdr2 != null) { hdr2.colSpan = hdr2.colSpan - numcol; }
   }
   else
   {
      status = "block";
      if(hdr1 != null) { hdr1.colSpan = hdr1.colSpan + numcol; }
      if(hdr2 != null) { hdr2.colSpan = hdr2.colSpan + numcol; }
   }

   for(var i=0; i < cell.length; i++) { cell[i].style.display = status; }
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvEmpList.innerHTML = " ";
   document.all.dvEmpList.style.visibility = "hidden";
}

//==============================================================================
// change Sales Goial
//==============================================================================
function chgSlsGoal(day)
{
  var hdr = "Every Day";
  if (day < 7){ hdr = WkDays[day]; }

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>Change Sales Goal: " + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript: hidedvSlsGoal();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>" + popChgSlsGoalPanel(day)
        + "</td></tr></table>"

  document.all.dvSlsGoal.innerHTML=html
  document.all.dvSlsGoal.style.pixelLeft=10;
  document.all.dvSlsGoal.style.pixelTop=210;
  document.all.dvSlsGoal.style.visibility="visible"
}
//==============================================================================
// populate clinic panel
//==============================================================================
function popChgSlsGoalPanel(day)
{
   var html = "<table border=0 cellPadding='0' cellSpacing='0' width='100%'>"
            + "<tr class='DataTable3'>"
              + "<td class='DataTable' nowrap >&nbsp; Percents &nbsp;</th>"
              + "<td class='DataTable' nowrap>&nbsp; <input class='small' name='NewSlsGoal'> &nbsp;</th>"
            + "</tr>"
            + "<tr class='DataTable3'>"
              + "<td class='DataTable' colspan=2>"
                 + "<button class='small' onClick='sbmNewSlsGoal(&#34;" + day + "&#34;, &#34;CHG&#34;)'>Change</button>"
                 + "<button class='small' onClick='sbmNewSlsGoal(&#34;" + day + "&#34;, &#34;RMV&#34;)'>Remove</button>"
                 + "<button class='small' onClick='hidedvSlsGoal()'>Cancel</button>"
              + "</td>"
            + "</tr>";
   html += "</table>"
   return html;
}

//==============================================================================
// submit Sales goal saving process
//==============================================================================
function sbmNewSlsGoal(day, action)
{
   var slsgoal = document.all.NewSlsGoal.value.trim();
   var error = false;
   var msg = "";

   if(action=="CHG")
   {
      if(slsgoal == ""){ msg += "New Sales Goal is not entered.\n"; error=true;}
      else if(isNaN(slsgoal)){ msg += "New Sales Goal is not numeric.\n"; error=true;}
      else if(eval(slsgoal) > 100 || eval(slsgoal) < -100){ msg += "New Sales Goal cannot be grater than 100% or less than -100%.\n"; error=true;}
   }
   else { slsgoal = 0; }

   var url = "PrChgSlsGoal.jsp?"
     + "Str=<%=sStore%>"
     + "&Wkend=<%=sWkend%>"
     + "&Day=" + day
     + "&Goal=" + slsgoal
     + "&Action=" + action

   if(error){ alert(msg)}
   else
   {
      //alert(url)
      //window.location = url;
      window.frame1.location = url;
   }
}
//==============================================================================
// change Mike Parker Hours
//==============================================================================
function chgAbOvrHrs()
{
  var hdr = "Override AB Hours";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>Change Sales Goal: " + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>" + popAbOvrHrsPanel()
        + "</td></tr></table>"

  document.all.dvEmpList.innerHTML=html
  document.all.dvEmpList.style.pixelLeft=80;
  document.all.dvEmpList.style.pixelTop=210;
  document.all.dvEmpList.style.visibility="visible"

  if(AbOvrHrs != "0")
  {
     document.all.NewAbHrs.value = AbOvrHrs;
     document.all.NewAbComment.value = AbOvrComment;
  }
}
//==============================================================================
// create a panel for Override AB Hours
//==============================================================================
function popAbOvrHrsPanel()
{
   var panel = "<table border=0 cellPadding='0' cellSpacing='0' width='100%'>"
            + "<tr class='DataTable3'>"
              + "<td class='DataTable2' nowrap >&nbsp; Allowable Hours &nbsp;</th>"
              + "<td class='DataTable1' nowrap>&nbsp; <input class='small' name='NewAbHrs' maxlength=5> &nbsp;</th>"
            + "</tr>"

            + "<tr class='DataTable3'>"
              + "<td class='DataTable2' nowrap >&nbsp; Comments &nbsp;</th>"
              + "<td class='DataTable1' nowrap>&nbsp; <input class='small' name='NewAbComment' size=100 maxlength=100> &nbsp;</th>"
            + "</tr>"

            + "<tr class='DataTable3'>"
              + "<td class='DataTable' colspan=2>"
                 + "<button class='small' onClick='sbmNewAbHrs(&#34;CHG&#34;)'>Change</button>"
                 + "<button class='small' onClick='sbmNewAbHrs(&#34;RMV&#34;)'>Remove</button>"
                 + "<button class='small' onClick='hidePanel()'>Cancel</button>"
              + "</td>"
            + "</tr>";

   panel += "</table>"

   return panel;
}
//==============================================================================
// submit New AB Hours
//==============================================================================
function sbmNewAbHrs(action)
{
   var abhrs = document.all.NewAbHrs.value.trim();
   var abcommt = document.all.NewAbComment.value.trim().replaceSpecChar();
   var error = false;
   var msg = "";

   if(action == "CHG")
   {
        if(isNaN(abhrs) || eval(abhrs) == 0){ error = true; msg = "Hours is invalid or 0." }
   }
   else if(action == "RMV")
   {
      abhrs = "0";
      abcommt = "NONE";
   }

   var url = "PrChgAbOvrHrs.jsp?"
     + "Str=<%=sStore%>"
     + "&Wkend=<%=sWkend%>"
     + "&Hrs=" + abhrs
     + "&Comment=" + abcommt
     + "&Action=" + action

   if(error){ alert(msg) }
   else
   {
     //alert(url)
     window.frame1.location.href = url;
   }
}
//==============================================================================
// close clinic list panel
//==============================================================================
function hidedvSlsGoal(){ document.all.dvSlsGoal.style.visibility="hidden" }
//==============================================================================
// this function called after new goal was applied
//==============================================================================
function rtnChgSlsGoal(error)
{
   var msg = "";
   var err = error.length > 0;
   if (err)
   {
      for(var i=0; i < error.length; i++) { msg += error[i] + "\n"; }
      alert(msg);
   }
   else { window.location.reload(); }
}
//==============================================================================
// display help when mouse over row name
//==============================================================================
function displayHelp(text, obj)
{
   var html = "<div style='border: black solid 1px;'>" + text + "</div>";
   var pos = getObjPosition(obj);
   document.all.dvHelp.innerHTML = html;
   document.all.dvHelp.style.pixelLeft= pos[0] - 200;
   document.all.dvHelp.style.pixelTop= pos[1] - 25;
   document.all.dvHelp.style.visibility = "visible";
}
//==============================================================================
// display all help texts
//==============================================================================
function displayAllHelp()
{
   var html = "";
   var id = null;

   for(var i=1; i < 25; i++)
   {
      id = "th" + i;
      html += getHelpText(id) + "<p style='text-align:left'>";
   }

   var MyWindowName = "Weekly_Budget";
   var MyWindowOptions =
    "left=20, top=20, width=800,height=600, toolbar=yes, location=yes, directories=yes, status=yes, scrollbars=yes, menubar=yes, scrollbars=1, resizable=yes";

   window_help = window.open("", MyWindowName, MyWindowOptions);
   window_help.document.write(html);
   window_help.document.close();

}
//==============================================================================
// display Hours earhed calculation formulas
//==============================================================================
function dspCalcFormulaHrsEarn(arg, bdgTotHrs, bdgTotPay, bdgAvgRate, totSlsDiff,
           bdgPos, hrsEarned, hsvEarned, slsCommRatio, slsCommRate, lSpiff, pSpiff, slsPayrollPrc,
           actSls, origPlan, slsTrend, dayPass, tag)
{
   var wkday = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "Total"];
   var hdr = "Hours Earned(Lost) Based on Sales";
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0 id='tblHrsEarn'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript: hidedvSlsGoal();' alt='Close'>"
       + "</td></tr>"
       + "<tr><td class='Prompt' colspan=2 id='dvHrsEarn'>"
          + "<div id='dvCals' style='overflow:auto;'>"
            + popCalcFormulaHrsEarn(bdgTotHrs, bdgTotPay, bdgAvgRate, totSlsDiff, bdgPos,
                  hrsEarned, hsvEarned, slsCommRatio, slsCommRate, lSpiff, pSpiff, slsPayrollPrc,
                  actSls, origPlan, slsTrend, dayPass, tag)
          + "</div>"
       + "</td></tr>"
     + "</table>"

   document.all.dvSlsGoal.innerHTML=html
   document.all.dvSlsGoal.style.pixelLeft=document.documentElement.scrollLeft + 200;
   document.all.dvSlsGoal.style.pixelTop=document.documentElement.scrollTop + 70;
   document.all.dvSlsGoal.style.visibility="visible"

   //document.all.dvCals.style.height = 300;

   window.location.hash=tag;
}
//==============================================================================
// populate Hours earhed calculation formulas panel
//==============================================================================
function popCalcFormulaHrsEarn(bdgTotHrs, bdgTotPay, bdgAvgRate, totSlsDiff, bdgPos, hrsEarned
         , hsvEarned, slsCommRatio, slsCommRate, lSpiff, pSpiff, slsPayrollPrc, actSls
         , origPlan, slsTrend, dayPass,tag)
{
    var act = removeComas(actSls);
    var plan = removeComas(origPlan);
    var abHrs = removeComas(AbOvrHrs);

    var slsThresh = eval(removeComas(BaseBdg));
    var altSls = eval(removeComas(slsTrend));
    var compTo = addCommas(plan);
    var compToLine = "Less of Original Sales Plan (Line 2)";
    var compToLine2 = " &nbsp; If Original Sales Plan (line 2) is greater than Sales Threshold,<br> &nbsp; then let this line B be equal to Original Sales Plan";
    var noCalcLine = "No hours are earned or lost as Actual/Forecast Sales (line 6)<br>are equal to or below Sales Threshold"

    var slsDiff = act - plan;
    if(plan < slsThresh)
    {
       slsDiff = act - slsThresh;
       compTo = BaseBdg;
       compToLine = "Less of Sales Threshold";
       compToLine2 = " &nbsp; If Original Sales Plan (line 2) is less than Sales Threshold,<br> &nbsp; then let this line B be equal to Sales Threshold";
    }

    var threshold = eval(removeComas(BaseBdg)) > eval(act) && eval(removeComas(totSlsDiff)) > 0;
    if(threshold) { slsDiff = 0; slsPayrollPrc = "0";}

    var result1 = clcRes1(slsDiff, bdgPos);
    var result2 = clcRes2(hsvEarned, bdgAvgRate);
    var result3 = clcRes3(bdgTotPay, result1, result2, 0);
    if(abHrs > 0) { result3 = clcRes2(abHrs, bdgAvgRate); }
    var result4 = clcRes4(slsDiff, slsCommRatio, slsCommRate);
    var result5 = clcRes5(lSpiff, pSpiff, slsPayrollPrc);
    // calculate new spiffs
    var result6 = clcRes3(result5, result4, '0', 0);
    // add new spiffs to allowable budget dollars
    var result3 = clcRes3(result3, result6, '0', 0);

    var result7 = clcRes6(result6, bdgTotHrs, 2);
    var result8 = clcRes3(result7, bdgAvgRate, '0', 2);
    var result9 = clcRes6(result3, result8, 0);
    var result10 = clcRes10(result1, bdgAvgRate);
    var result11 = clcRes11(result10, 2);
    var bdgHrs = eval(removeComas(bdgTotHrs));

    var abClcHrs = eval(bdgHrs) + eval(result11);
    if( abClcHrs < eval(BaseHrlyHrs))
    {
       noCalcLine = "Even though Actual/Forecast Sales are less than Original Sales Plan "
          + "<br>no hours are lost as hours below Base Hours";
    }

    var html = "<table border=0 cellPadding='0' cellSpacing='0' width='100%'>"

    html += "<tr class='DataTable3'>"
                + "<th class='DataTable32' colspan=2 nowrap > &nbsp; Memo: Sales Threshold</th>"
                + "<th class='DataTable32' nowrap >&nbsp;</th>"
                + "<th class='DataTable32' nowrap >$" + BaseBdg + "</th>"
                + "<th class='DataTable32' nowrap >&nbsp;</th>"
             + "</tr>"

    html += "<tr class='DataTable3'>"
           + "<th class='DataTable322' nowrap colspan=2> &nbsp; Memo: Base Hours (hourly only)</th>"
           + "<th class='DataTable322' nowrap >&nbsp;</td>"
           + "<th class='DataTable322' nowrap >" + BaseHrlyHrs + "</td>"
           + "<th class='DataTable322' nowrap >&nbsp;</td>"
          + "</tr>"

    html += "<tr class='DataTable3'>"
           + "<th class='DataTable321' nowrap colspan=2> &nbsp; Memo: Original Budget Hours (line 9)</th>"
           + "<th class='DataTable321' nowrap >&nbsp;</td>"
           + "<th class='DataTable321' nowrap >" + bdgTotHrs + "</td>"
           + "<th class='DataTable321' nowrap >&nbsp;</td>"
          + "</tr>"

    if(abHrs == 0 && (act <= slsThresh || abClcHrs < eval(BaseHrlyHrs) ))
    {
       html += "<tr class='DataTable3'>"
           + "<th class='DataTable311' nowrap > &nbsp; I. &nbsp; </th>"
           + "<th class='DataTable311' nowrap >" + noCalcLine + "</th>"
           + "<td class='DataTable' nowrap >&nbsp;</td>"
           + "<td class='DataTable' nowrap >0</td>"
           + "<td class='DataTable2' nowrap >&nbsp;</td>"
        + "</tr>"
    }
    else if(abHrs == 0)
    {
       html += "<tr class='DataTable3'>"
           + "<th class='DataTable311' nowrap > &nbsp; A. &nbsp; </th>"
           + "<th class='DataTable311' nowrap > &nbsp; Actual/Forecast Sales (line 6)</th>"
           + "<td class='DataTable' nowrap >&nbsp;</td>"
           + "<td class='DataTable' nowrap >$" + actSls + "</td>"
           + "<td class='DataTable2' nowrap >&nbsp;</td>"
        + "</tr>"

        html += "<tr class='DataTable3'>"
                + "<th class='DataTable31' nowrap > &nbsp; B. &nbsp; </th>"
                + "<th class='DataTable31'>  &nbsp; " + compToLine
                  + "<br><span style='color:blue; font-size:10px;'>" + compToLine2 + "</span>"
                + "</th>"
                + "<td class='DataTable' nowrap >-</td>"
                + "<td class='DataTable' nowrap >$" + compTo + "</td>"
                + "<td class='DataTable2' nowrap >&nbsp;</td>"
             + "</tr>"

        html += "<tr class='DataTable3'>"
           + "<th class='DataTable31' nowrap > &nbsp; C. &nbsp; </th>"
           + "<th class='DataTable31' nowrap > &nbsp; Increase(decrease) in sales</th>"
           + "<td class='DataTable' nowrap >&nbsp;</td>"
           + "<td class='DataTable' nowrap style='border-top: black solid 1px;'>$" + addCommas(slsDiff) + "</td>"
           + "<td class='DataTable2' nowrap style='border-top: black solid 1px;'>&nbsp;</td>"
        + "</tr>"

        + "<tr class='DataTable3'>"
           + "<th class='DataTable31' nowrap > &nbsp; D. &nbsp; </th>"
           + "<th class='DataTable31' nowrap > &nbsp; Times Original Payroll % (line 23) </th>"
           + "<td class='DataTable' nowrap >x</td>"
           + "<td class='DataTable2' nowrap >" + bdgPos + "%</td>"
           + "<td class='DataTable' nowrap >&nbsp;</td>"
        + "</tr>"

        + "<tr class='DataTable3'>"
           + "<th class='DataTable31' nowrap > &nbsp; E. &nbsp; </th>"
           + "<th class='DataTable31' nowrap > &nbsp; Increase(decrease) in payroll $'s before applying factor</th>"
           + "<td class='DataTable' nowrap >=</td>"
           + "<td class='DataTable2' nowrap style='border-top: black solid 1px;' >$" + addCommas(result1) + "</td>"
           + "<td class='DataTable2' nowrap style='border-top: black solid 1px;' >&nbsp;</td>"
        + "</tr>"

        + "<tr class='DataTable3'>"
           + "<th class='DataTable31' nowrap > &nbsp; F. &nbsp; </th>"
           + "<th class='DataTable31' nowrap > &nbsp; Divided by Original Budgeted Average Hourly Rate (line 18)</th>"
           + "<td class='DataTable'  nowrap >:</td>"
           + "<td class='DataTable2' nowrap >$" + bdgAvgRate + "</td>"
           + "<td class='DataTable' nowrap >&nbsp;</td>"
        + "</tr>"

        + "<tr class='DataTable3'>"
           + "<th class='DataTable31' nowrap > &nbsp; G. &nbsp; </th>"
           + "<th class='DataTable31' nowrap > &nbsp; # hours earned (lost) before applying factor</th>"
           + "<td class='DataTable' nowrap >=</td>"
           + "<td class='DataTable2' nowrap style='border-top: black solid 1px;' >" + result10 + "</td>"
           + "<td class='DataTable2' nowrap style='border-top: black solid 1px;' >&nbsp;</td>"
        + "</tr>"


        + "<tr class='DataTable3'>"
           + "<th class='DataTable31' nowrap > &nbsp; H. &nbsp; </th>"
           + "<th class='DataTable31' nowrap > &nbsp; Divided by factor 2 </th>"
           + "<td class='DataTable' nowrap >:</td>"
           + "<td class='DataTable2' nowrap >2</td>"
           + "<td class='DataTable' nowrap >&nbsp;</td>"
        + "</tr>"

        + "<tr class='DataTable3'>"
           + "<th class='DataTable31' nowrap > &nbsp; I. &nbsp; </th>"
           + "<th class='DataTable31' nowrap> &nbsp; Increase(decrease) in Budget Hours"
        if( abClcHrs < eval(BaseHrlyHrs))
        {
           html +=  "<br><span style='color:blue; font-size:10px'> &nbsp; AB Hrs were overridden to 0 becase it less then Base Hours.</span>"
        }
        html += "</th>"
           + "<td class='DataTable' nowrap >=</td>"
           + "<td class='DataTable2' nowrap style='border-top: black solid 1px;' >&nbsp;</td>"
           + "<td class='DataTable2' nowrap style='border-top: black solid 1px;' >" + result11 + "</td>"
        + "</tr>"
     }

        html += "<tr class='DataTable3'>"
           + "<td colspan=5 nowrap style='border-top: red solid 2px; border-bottom: red solid 2px; font-size:10px'>"
             + "Note: No hours will be lost if the original budget hours are equal to or below base hours.<br>"
             + "No hours will be earned or lost if actual/forecast sales are equal to or less than the sales threshold."
           + "</td>"
        + "</tr>"
   html += "</table>"
   return html;
}
//==============================================================================
// add Commas
//==============================================================================
function addCommas(nStr)
{
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
}

//==============================================================================
// display Earned based on base schedule
//==============================================================================
function dspEarnOnBase(bdgHrs, hrsEarnedOnBased)
{
   var hdr = "Hours Earned Based on Base Schedule. ";
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript: hidedvSlsGoal();' alt='Close'>"
       + "</td></tr>"
       + "<tr><td class='Prompt' colspan=2>"
          + popEarnOnBase(bdgHrs, hrsEarnedOnBased)
       + "</td></tr>"
     + "</table>"

   document.all.dvSlsGoal.style.width=250;
   document.all.dvSlsGoal.innerHTML=html
   document.all.dvSlsGoal.style.pixelLeft=document.documentElement.scrollLeft + 100;
   document.all.dvSlsGoal.style.pixelTop=document.documentElement.scrollTop + 200;
   document.all.dvSlsGoal.style.visibility="visible"
}
//==============================================================================
// populate Earned based on base schedule
//==============================================================================
function popEarnOnBase(bdgHrs, hrsEarnedOnBased)
{
    var html = "<table border=0 cellPadding='0' cellSpacing='0' width='100%'>"
        + "<tr class='DataTable3'>"
           + "<th class='DataTable31' nowrap >Base Schedule Hourly Employee Hours</th>"
           + "<td class='DataTable' nowrap >&nbsp;</td>"
           + "<td class='DataTable2' nowrap >" + BaseHrlyHrs + "</td>"
        + "</tr>"
        + "<tr class='DataTable3'>"
           + "<th class='DataTable31' nowrap >Actual/Schedule Hours</th>"
           + "<td class='DataTable' nowrap >-</td>"
           + "<td class='DataTable2' nowrap >" + bdgHrs + "</td>"
        + "</tr>"
        + "<tr class='DataTable3'>"
           + "<th class='DataTable31' nowrap >Hours Earned</th>"
           + "<td class='DataTable' nowrap >=</td>"
           + "<td class='DataTable2' nowrap >" + hrsEarnedOnBased + "</td>"
        + "</tr>"
   html += "</table>"
   return html;
}

//==============================================================================
// calculate sales excess or shortage
//==============================================================================
function clcRes1(amt1, amt2)
{
   //var result = amt1 * eval(removeComas(amt2)) / 100 / 2;
   var result = amt1 * eval(removeComas(amt2)) / 100;
   return (result).toFixed(0);
}
//==============================================================================
// calculate sales excess or shortage
//==============================================================================
function clcRes10(amt1, amt2)
{
   var result = 0;
   if(amt2 != 0){ result = amt1 / eval(amt2); }
   return (result).toFixed(0);
}
//==============================================================================
// calculate sales excess or shortage
//==============================================================================
function clcRes11(amt1, amt2)
{
   var result = 0;
   if(amt2 != 0){ result = amt1 / eval(amt2); }
   return (result).toFixed(0);
}
//==============================================================================
// calculate HSV dollars
//==============================================================================
function clcRes2(hsv, avgrate)
{
   var hsv = removeComas(hsv);
   return (hsv * avgrate).toFixed(0);
}
//==============================================================================
// calculate payroll hours
//==============================================================================
function clcRes3(amt1, amt2, amt3, precision)
{
   var amt1 = removeComas(amt1);
   var amt2 = removeComas(amt2);
   var amt3 = removeComas(amt3);

   return (eval(amt1) + eval(amt2) + eval(amt3)).toFixed(precision);
}
//==============================================================================
// calculate new sales commissions
//==============================================================================
function clcRes4(totSlsDiff, slsCommRatio, slsCommRate)
{
   var totSlsDiff = totSlsDiff;
   var slsCommRatio = removeComas(slsCommRatio);
   var slsCommRate = removeComas(slsCommRate);
   return (totSlsDiff * eval(slsCommRatio) / 100 * eval(slsCommRate) / 100).toFixed(0);
}
//==============================================================================
// calculate new spiff
//==============================================================================
function clcRes5(lSpiff, pSpiff, slsPayrollPrc)
{
   var lSpiff = removeComas(lSpiff);
   var pSpiff = removeComas(pSpiff);
   var slsPayrollPrc = removeComas(slsPayrollPrc);
   return ((eval(lSpiff) +  eval(pSpiff)) * eval(slsPayrollPrc) / 100).toFixed(0);
}
//==============================================================================
// calculate payroll hours
//==============================================================================
function clcRes6(amt1, amt2, precision)
{
   var amt1 = removeComas(amt1);
   var amt2 = removeComas(amt2);
   var result = 0;

   if(amt2 != 0)
   {
      result = (eval(amt1) / eval(amt2)).toFixed(precision);
   }
   return result;
}
//==============================================================================
// calculate payroll hours
//==============================================================================
function removeComas(number)
{
   var number1 = "";
   var neg = false
   for(var i=0; i < number.length; i++)
   {
      if (number.substring(i, i+1) != "," && number.substring(i, i+1) != "-")
      {
        number1 += number.substring(i, i+1);
      }
      else if(number.substring(i, i+1) == "-"){neg = true;}
   }

   if(neg) { number1 = number1 * (-1) };
   return number1;
}

//==============================================================================
// display Calculated Salary Employee reserved hours
//==============================================================================
function dispSlrReserv(baseDt, baseHrs, currHrs, reserved, nosalary, tmchrs, sickhrs)
{
   var hdr = "Salary Employee Hours";
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript: hidedvSlsGoal();' alt='Close'>"
       + "</td></tr>"
        + "<tr><td class='Prompt' colspan=2>"
          + popSlrReserv(baseDt, baseHrs, currHrs, reserved, nosalary, tmchrs, sickhrs)
       + "</td></tr>"
     + "</table>"

   document.all.dvSlsGoal.innerHTML=html
   document.all.dvSlsGoal.style.pixelLeft=document.documentElement.scrollLeft + 100;
   document.all.dvSlsGoal.style.pixelTop=document.documentElement.scrollTop + 200;
   document.all.dvSlsGoal.style.visibility="visible"
}
//==============================================================================
// populate Hours earhed calculation formulas panel
//==============================================================================
function popSlrReserv(baseDt, baseHrs, currHrs, reserved, nosalary, tmchrs, sickhrs)
{

    var html = "<table border=0 cellPadding='0' cellSpacing='0' width='100%'>"
        + "<tr class='DataTable3'>"
           + "<td class='DataTable1' nowrap >Base schedule salary employee days</td>"
           + "<td class='DataTable1' nowrap >&nbsp;</td>"
           + "<td class='DataTable2' nowrap >" + baseHrs + "</td>"
        + "</tr>"
        + "<tr class='DataTable3'>"
           + "<td class='DataTable1' nowrap >Selected week schedule salary employee days</td>"
           + "<td class='DataTable1' nowrap >-</td>"
           + "<td class='DataTable2' nowrap >" + currHrs + "</td>"
        + "</tr>"
        + "<tr class='DataTable3'>"
           + "<td class='DataTable1' nowrap >Differance (in days)</td>"
           + "<td class='DataTable1' nowrap >=</td>"
           + "<td class='DataTable2' nowrap >" + (baseHrs - currHrs) + "</td>"
        + "</tr>"
        + "<tr class='DataTable3'>"
           + "<td class='DataTable1' nowrap >* 8 hours per day</td>"
           + "<td class='DataTable1' nowrap >=</td>"
           + "<td class='DataTable2' nowrap >" + (baseHrs - currHrs) * 8 + "</td>"
        + "</tr>"

        + "<tr class='DataTable3'>"
           + "<td class='DataTable1' nowrap >No salary hours used in calculation</td>"
           + "<td class='DataTable1' nowrap >=</td>"
           + "<td class='DataTable2' nowrap >" + nosalary + "</td>"
        + "</tr>"

        + "<tr class='DataTable3'>"
           + "<td class='DataTable1' nowrap >TMC hours</td>"
           + "<td class='DataTable1' nowrap >=</td>"
           + "<td class='DataTable2' nowrap >" + tmchrs + "</td>"
        + "</tr>"

        + "<tr class='DataTable3'>"
           + "<td class='DataTable1' nowrap >Sick hours</td>"
           + "<td class='DataTable1' nowrap >=</td>"
           + "<td class='DataTable2' nowrap >" + sickhrs + "</td>"
        + "</tr>"

        + "<tr class='DataTable3'>"
           + "<td class='DataTable1' nowrap >Rounded to the nearest multiple of 7</td>"
           + "<td class='DataTable1' nowrap >=</td>"
           + "<td class='DataTable2' nowrap >" + reserved + "</td>"
        + "</tr>"
        + "<tr class='DataTable3'>"
           + "<th class='DataTable31' colspan=3><a href='PsWkSched.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName.trim()%>&MONBEG=01/04/2099&WEEKEND=" + baseDt + "' target='_blank'>Base Schedule</a>"
           + " &nbsp; &nbsp; &nbsp; <a href='PsWkSched.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName.trim()%>&MONBEG=<%=sWkend%>&WEEKEND=<%=sWkend%>' target='_blank'>Selected Week Schedule</a></th>"

           //&MONBEG=02/23/2009&WEEKEND=03/15/2009
        + "</tr>"

       html += "</table>"
   return html;
}

//==============================================================================
// shows Salary Employee/Days
//==============================================================================
function showSlrEmpDays()
{
   var hdr = "Salary Employee List";
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript: hidedvSlsGoal();' alt='Close'>"
       + "</td></tr>"
        + "<tr><td class='Prompt' colspan=2>"
          + popSlrEmpDays()
       + "</td></tr>"
     + "</table>"

   document.all.dvSlsGoal.style.width=250;
   document.all.dvSlsGoal.innerHTML=html
   document.all.dvSlsGoal.style.pixelLeft=document.documentElement.scrollLeft + 100;
   document.all.dvSlsGoal.style.pixelTop=document.documentElement.scrollTop + 200;
   document.all.dvSlsGoal.style.visibility="visible"
}
//==============================================================================
// populate Salary Employee/Days Schedule
//==============================================================================
function popSlrEmpDays()
{
    var html = "<table border=1 cellPadding='0' cellSpacing='0' width='100%'>"
        + "<tr class='DataTable5'>"
           + "<th class='DataTable'>Weekending: <%=sWkend%></th>"
           + "<th class='DataTable'>Base Schedule</th>"
        + "</tr>"

        + "<tr class='DataTable5'>"
           + "<td class='DataTable'>" + popSlrEmpDaysSelWk() + "</td>"
           + "<td class='DataTable'>" + popSlrEmpDaysBasWk() + "</td>"
        + "</tr>"

       html += "</table>"
   return html;
}
//==============================================================================
// populate Salary Employee/Days Schedule for selected week
//==============================================================================
function popSlrEmpDaysSelWk()
{
    var html = "<table border=1 cellPadding='0' cellSpacing='0' width='100%'>"
        + "<tr class='DataTable5'>"
           + "<th class='DataTable'>No.</th>"
           + "<th class='DataTable'>Employee</th>"
           + "<th class='DataTable'>Date</th>"
        + "</tr>"
    var j = 0;
    for(var i=0; i < SlrEmpNm.length; i++)
    {
       if(SlrCurOrBase[i] == "1")
       {
          j++;
          html += "<tr class='DataTable3'>"
                + "<td class='DataTable2' nowrap>" + j + "</td>"
                + "<td class='DataTable1' nowrap>" + SlrEmpNm[i] + "</td>"
                + "<td class='DataTable'>" + SlrEmpDt[i] + "</td>"
            + "</tr>";
       }
    }

    html += "<tr class='DataTable3'>"
         + "<td class='DataTable1' nowrap colspan=3><b>Summary: " + j + " days</b></td>"
       + "</tr>"
     + "</table>"
    return html;
}
//==============================================================================
// populate Salary Employee/Days Schedule for base schedule
//==============================================================================
function popSlrEmpDaysBasWk()
{
   var html = "<table border=1 cellPadding='0' cellSpacing='0' width='100%'>"
        + "<tr class='DataTable3'>"
           + "<th class='DataTable'>No.</th>"
           + "<th class='DataTable'>Employee</th>"
           + "<th class='DataTable'>Date</th>"
        + "</tr>"
   var j = 0;
   for(var i=0; i < SlrEmpNm.length; i++)
   {
      if(SlrCurOrBase[i] == "0")
      {
         j++;
         html += "<tr class='DataTable3'>"
               + "<td class='DataTable2' nowrap>" + j + "</td>"
               + "<td class='DataTable1' nowrap>" + SlrEmpNm[i] + "</td>"
               + "<td class='DataTable'>" + SlrEmpDt[i] + "</td>"
           + "</tr>";
       }
    }

    html += "<tr class='DataTable3'>"
         + "<td class='DataTable1' nowrap colspan=3><b>Summary: " + j + " days</b></td>"
       + "</tr>"
     + "</table>"
    return html;
}
//==============================================================================
// hide help text
//==============================================================================
function hideHelp(){ document.all.dvHelp.style.visibility="hidden" }


//==============================================================================
// populate date with yesterdate
//==============================================================================
function setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);
  date.setHours(18);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000 * 7);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000 * 7);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// submit report
//==============================================================================
function sbmReport()
{
   var wkend = document.all.Wkend.value
   SbmString = "BfdgSchActWk.jsp"
        + "?Store=<%=sStore%>&StrName=<%=sStrName.trim()%>"
        + "&Wkend=" + wkend;

    //alert(SbmString);
    window.location.href=SbmString;
}

//==============================================================================
// fold / unfold lines
//==============================================================================
function foldLines()
{
   var status = null;
   var cell = document.all.tdFold;

   if(cell[0].style.display != "none"){status = "none"; }
   else { status = "block"}
   for(var i=0; i < cell.length; i++) { cell[i].style.display = status; }
}
//==============================================================================
// print table content
//==============================================================================
function printTblContent(obj)
{
   var r1 = document.getElementById(obj);

   var MyWindowName = "Payroll_Budget_ByEmployee_Grp";
   var MyWindowOptions =
    "left=20, top=20, width=800,height=600, toolbar=yes, location=yes, directories=yes, status=yes, scrollbars=yes, menubar=yes, scrollbars=1, resizable=yes";

   var html = r1.outerHTML
   window_tbl = window.open("", MyWindowName, MyWindowOptions);
     window_tbl.document.write('<style>'
       + 'tr.DataTable3 { background: #ccffcc; font-size:10px }'
       + ' tr.DataTable31 { background: #ffff99; font-size:10px }'
       + ' tr.DataTable32 { background: gold; font-size:10px }'
       + ' th.Divdr2t { border-top: black solid 3px; background:#ccccff;  font-size:1px}'
       + ' th.Divdr2r { border-right: black solid 3px; background:#ccccff;  font-size:1px}'
       + ' th.Divdr2l { border-left: black solid 3px; background:#ccccff;  font-size:1px}'
       + ' th.Divdr2b { border-bottom: black solid 3px; background:#ccccff;  font-size:1px}'
       + ' th.DataTable3 { background:#ccccff; padding-top:3px; padding-bottom:3px; font-size:12px }'
       + ' th.DataTable31 { border-top: black solid 3px;  background:#ccccff; padding-top:3px; padding-bottom:3px; font-size:12px; text-align:left;}'
       + ' td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:center; }'
       + ' td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}'
       + ' td.DataTable2d { border-bottom: black solid 3px; padding-top:3px; padding-bottom:3px; padding-left:3px;'
       + ' padding-right:3px; text-align:right;}'
       + ' td.DataTable3 { background: black; font-size:12px }'
      + '</style>');
   window_tbl.document.write('<BODY onload="window.print();window.close();">\n'
      + '<div width=500>' + html + '</div>'
      + '</BODY">\n')
   window_tbl.document.close();
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>


<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvSlsGoal" class="dvSlsGoal"></div>
<div id="dvEmpList" class="dvEmpList"></div>
<div id="dvHelp" class="dvHelp"></div>
<!----------------------------------------------------------------------------->
<div id="dvWkSel" class="dvWkSel">
  <button class="Small" name="Down" onClick="setDate('DOWN', 'Wkend')">&#60;</button>
  <input name="Wkend" class="Small" type="text" size=10 maxlength=10 readonly>&nbsp;
  <button class="Small" name="Up" onClick="setDate('UP', 'Wkend')">&#62;</button>
  <a href="javascript:showCalendar(1, null, null, 10, 90, document.all.Wkend)" >
  <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
  <br><button class="Small" onClick="sbmReport()">Submit</button>
</div >
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
      <br>Allowable Budget Review (Weekly) (New Schedule)
      <br> Store: <%=sStore%> &nbsp; &nbsp; Weekending date: <%=sWkend%>
      </b>

      <br><br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <a href="BfdgSchActWkSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
      <a href="javascript: displayAllHelp()">Budget Formulas</a>&nbsp;&nbsp;
      <a href="javascript: foldLines()">Fold/Unfold</a>&nbsp;&nbsp;
      <a href="PsWkSched.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName.trim()%>&MONBEG=<%=sWkend%>&WEEKEND=<%=sWkend%>" target="_blank">Weekly Schedule</a>&nbsp;&nbsp;
      <a href="PsWkSched.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName.trim()%>&MONBEG=01/04/2099&WEEKEND=<%=sBaseSchDt%>" target="_blank">Base Schedule</a>&nbsp;&nbsp;
      <a href="javascript: showSlrEmpDays()">Salary Emplolyee</a>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0" >
        <tr>
          <td class="DataTable" rowspan=14></td>
          <td class="DataTable"></td>
          <th class="DataTable">No.</th>
          <th class="DataTable" onmouseover="hideHelp()">Memo: &nbsp; &nbsp; &nbsp; Sales Threshold $<%=sBaseBdg%></th>
          <%for(int i=0; i < 8; i++){%>
             <th class="DataTable"><%=sWkDays[i]%></th>
          <%}%>
          <%if(!bChgOfTrendAllowed){%>
             <th class="DataTable">Actual<br>Processed<br>Payroll</th>
          <%}%>

        </tr>
     <!-------------------- Sales Plan Spread by Day % ------------------------>
     <tr class="DataTable">
        <th class="DataTable2" rowspan=10 id="tabSales">Sales</th>
        <th class="DataTable00" id="tdFold">1</th>
        <th class="DataTable1" id="tdFold">Original Sales Plan Spread by Day %</th>
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable21" id="tdFold"><%=sSlsPlanPrc[i]%>%</td>
        <%}%>
     </tr>
     <!-------------------- Sales Plan ---------------------------------------->
     <tr class="DataTable">
       <th class="DataTable00">2</th>
        <th class="DataTable1" >Original Sales Plan</th>
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable21">$<%=sSlsPlan[i]%></td>
        <%}%>
     </tr>
     <!------------------- Alternate Sales Goal by Day % ---------------------->
     <tr class="Divdr1"><td colspan=11>&nbsp;</td></tr>
     <tr class="DataTable">
        <th class="DataTable00">3</th>
        <th class="DataTable1"><%if(bChgOfTrendAllowed){%><a href="javascript:chgSlsGoal('7')">Sales Forecast Trend Rate</a><%} else {%>Sales Forecast Trend Rate<%}%></th>
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable2"><%if(bChgOfTrendAllowed){%><a href="javascript:chgSlsGoal('<%=i%>')"><%=sAltSlsPlanPrc[i]%></a><%} else {%><%=sAltSlsPlanPrc[i]%><%}%>%</td>
        <%}%>
     </tr>

     <!----------------------- Alternate Sales Goal --------------------------->
     <tr class="DataTable">
        <th class="DataTable00">4</th>
        <th class="DataTable1" >Sales Forecast</th>
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable2">$<%=sAltSlsPlan[i]%></td>
        <%}%>
     </tr>
     <!----------------------- Alternate Sales Goal Difference ---------------->
     <tr class="DataTable">
        <th class="DataTable00" id="tdFold">5</th>
        <th class="DataTable1" id="tdFold">Sales Forecast Dollars +/- vs. Original Sales Plan</th>
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable2" id="tdFold">$<%=sAltSlsPlanDiff[i]%></td>
        <%}%>
     </tr>

     <!------------------------ Actual Sales  --------------------------------->
     <tr class="Divdr1"><td colspan=11>&nbsp;</td></tr>
     <tr class="DataTable">
        <th class="DataTable00">6</th>
        <th class="DataTable1" >Sales Actual / Forecast</th>
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable2<%if(i < iNumOfPassDays){%>p<%}%>">$<%=sActSls[i]%></td>
        <%}%>
     </tr>

     <!------------------------ Actual Sales Difference ----------------------->
     <tr class="DataTable">
        <th class="DataTable00" id="tdFold" rowspan=2>7</th>
        <th class="DataTable1" id="tdFold">Sales Actual / Forecast Dollars +/- vs. Original Sales Plan</th>
        <%for(int i=0; i < 8; i++){%>
           <td id="tdFold" class="DataTable2<%if(i < iNumOfPassDays){%>p<%}%>">$<%=sActSlsDiff[i]%></td>
        <%}%>
     </tr>

     <tr class="DataTable">
        <th class="DataTable1" id="tdFold">Sales Actual vs. Original Sales Plan</th>
        <%for(int i=0; i < 8; i++){%>
           <td id="tdFold" class="DataTable2<%if(i < iNumOfPassDays){%>p<%}%>"><%=sActOrigPrc[i]%>%</td>
        <%}%>
     </tr>

     <tr class="Divdr1"><td style="background: white;"></td><td colspan=11>&nbsp;</td></tr>
     <tr class="Divdr1"><td style="background: white;"></td><td colspan=11>&nbsp;</td></tr>
     <tr class="Divdr1"><td style="background: white;"></td><td colspan=11>&nbsp;</td></tr>

     <!---------------- Payroll Budget Spread by Day -------------------------->
     <tr class="DataTable">
        <td style="background: white;" colspan=2></td>
        <th class="DataTable00" id="tdFold">8</th>
        <th class="DataTable1"  id="tdFold">Payroll Budget Spread by Day</th>
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable21" id="tdFold"><%=sSchPrc[i]%>%</td>
        <%}%>
     </tr>
     <!----------------------- Budget Hours ----------------------------------->
     <tr class="DataTable">
        <th class="DataTable21" rowspan=23 nowrap>Hourly Employee Only &nbsp; &nbsp<br>(Excludes Holiday, Sick, Vacation and TMC.)</th>
        <th class="DataTable22" rowspan=8>P/R Hours</th>
        <th class="DataTable01">9</th>
        <th class="DataTable11" >Original Budget Hours
           <a href="javascript: showGrpBdg()"><i><sup>(List #1)</sup></i></a>&nbsp;
        </th>
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable21"><%=sBdgHrs[i]%></td>
        <%}%>
     </tr>
     <!-------------------------- Hours Earned -------------------------------->
     <tr class="DataTable">
        <th class="DataTable01" rowspan=2  id="tdFold">10</th>
        <!-- th class="DataTable11"  id="tdFold">Hours Earned (Based on Base Schedule)</th>
        <%for(int i=0; i < 8; i++){%>
           <td  id="tdFold" class="DataTable2<%if(i < iNumOfPassDays){%>p<%}%>">
              <%if(i==7 && !sHrsEarnedOnBased[i].equals("0")){%><a href="javascript: dspEarnOnBase('<%=sBdgHrs[i]%>', '<%=sHrsEarnedOnBased[i]%>')"><%=sHrsEarnedOnBased[i]%><a><%} else {%><%=sHrsEarnedOnBased[i]%><%}%>
           </td>
        <%}%>
     </tr -->
     <!-- tr class="DataTable" -->
        <th class="DataTable11"  id="tdFold">Hours Earned (Based on Sales)</th>
        <%for(int i=0; i < 8; i++){%>
           <td  id="tdFold" class="DataTable2<%if(i < iNumOfPassDays){%>p<%}%>">
              <%if(i==7){%><a href="javascript: dspCalcFormulaHrsEarn('<%=i%>','<%=sBdgHrs[7]%>','<%=sBdgPay[7]%>', '<%=sBdgAvg[7]%>', '<%=sActSlsDiff[7]%>', '<%=sBdgPayOfSls[7]%>', '<%=sHrsEarned[i]%>', '<%=sHrsEarnedNoSlry[7]%>', '<%=sSlsCommRatio%>', '<%=sSlsCommRate%>', '<%=sLSpiff%>', '<%=sPSpiff%>', '<%=sSlsPayrollPrc%>', '<%=sActSls[7]%>', '<%=sSlsPlan[7]%>', '<%=sAltSlsPlan[7]%>','<%=iNumOfPassDays%>','alwhrs')">
                  <%=sHrsEarned[i]%></a><%if(sWarnL10[i].equals("1")){%><sup>*</sup><%}%>
              <%} else {%><%=sHrsEarned[i]%><%if(sWarnL10[i].equals("1")){%><sup>*</sup><%}%><%}%>
           </td>
        <%}%>
     </tr>
     <tr class="DataTable">
        <th class="DataTable11" id="tdFold">Hours Earned (Based on Salaried Employees on V or H)&nbsp;</th>
        <%for(int i=0; i < 8; i++){%>
           <td  id="tdFold" class="DataTable2<%if(i < iNumOfPassDays){%>p<%}%>">
           <%if(i==7 && !sHrsEarnedNoSlry[i].equals("0")){%><a href="javascript: dispSlrReserv('<%=sBaseSchDt%>', '<%=sBaseSlrHrs%>', '<%=sCurrSlrHrs%>', '<%=sHrsEarnedNoSlry[i]%>', '<%=sNoSlryHrs%>', '<%=sTmcSlryHrs%>', '<%=sSickSlryHrs%>')"><%=sHrsEarnedNoSlry[i]%></a><%} else {%><%=sHrsEarnedNoSlry[i]%><%}%></td>
        <%}%>
     </tr>
     <!------------------------- Hours Allowed Revised ------------------------>
     <tr class="DataTable">
        <th class="DataTable01" rowspan=2>11</th>
        <th class="DataTable11">Allowable Budget Hours</th>
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable2<%if(i < iNumOfPassDays){%>p<%}%>">
           <%if(i==7){%><%=sHrsAllowed[i]%><%if(sWarnL10[i].equals("1")){%><sup>*</sup><%}%><%} else {%><%=sHrsAllowed[i]%><%if(sWarnL10[i].equals("1")){%><sup>*</sup><%}%><%}%>
           </td>
        <%}%>
     </tr>
     <tr class="DataTable">
        <th class="DataTable11">Store Ops Manual Allowable Budget Hours Adjustment</th>
        <td class="DataTable1" colspan=7><%=sAbOvrComment%>&nbsp;</td>
        <td class="DataTable2">
           <%if(bAvOvrHrsAllowed) {%><a href="javascript: chgAbOvrHrs()"><%if(!sAbOvrHrs.equals("0")){%><%=sAbOvrHrs%><%} else{%>None<%}%>&nbsp;</a>
           <%} else {%><%if(!sAbOvrHrs.equals("0")){%><%=sAbOvrHrs%><%} else{%>None<%}%><%}%>
        </td>
     </tr>

     <!------------------------- Adjustment to hours needed ------------------------>
     <tr class="DataTable" id="tdFold">
        <th class="DataTable01">12</th>
        <th class="DataTable11" >Actual Hrs. / Adjustment to Hours Needed To Reach Allowable Budget</th>
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable2<%if(i < iNumOfPassDays){%>p<%}%>"><%if(i >= iNumOfPassDays){%><%=sAdjVar[i]%><%} else {%>&nbsp;<%}%></td>
        <%}%>
     </tr>
     <!------------------------- Adjusted Budget Hours ------------------------>
     <tr class="DataTable4" id="tdFold">
        <th class="DataTable01">13</th>
        <th class="DataTable11">Actual Hrs. / Adjusted Hrs. To Reach Allowable Budget</th>
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable21<%if(i==7 && iNumOfPassDays < 7){%>2<%}%>"><%=sBdgAdj[i]%></td>
        <%}%>
     </tr>
     <!------------------------- Hours Actual --------------------------------->
     <tr class="DataTable4">
        <th class="DataTable01">14</th>
        <th class="DataTable11">Hours Actual / Scheduled
          <a href="javascript: showActEmp()"><i><sup>(List #2)</sup></i></a>
          <%if(bCurWeek){%><a href="javascript: showSchActEmpGrp()"><i><sup>(List by Grp TY)</sup></i></a>
          <%} else {%><a href="javascript: showActEmpGrp()"><i><sup>(List by Grp TY)</sup></i></a><%}%>
          <a href="javascript: showLyActGrp()"><i><sup>(List by Grp LY)</sup></i></a>
        </th>
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable21<%if(i==7 && iNumOfPassDays < 7){%>2<%}%>"><%=sActPayHrs[i]%></td>
        <%}%>
        <%if(!bChgOfTrendAllowed){%>
             <td class="DataTable22"><%=sActPrcPayHrs%></td>
          <%}%>
     </tr>
     <!------------------------- Payroll Budget Dollars ----------------------->
     <tr class="DataTable">
        <th class="DataTable23" rowspan=4>P/R $'s</th>
        <th class="DataTable02">15</th>
        <th class="DataTable12">Original Payroll Budget Dollars <a href="javascript: showGrpBdg()"><i><sup>(List #1)</sup></i></a></th>
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable2">$<%=sBdgPay[i]%></td>
        <%}%>
     </tr>
     <!------------------------- Revised Budget Dollars ----------------------->
     <tr class="DataTable">
        <th class="DataTable02">16</th>
        <th class="DataTable12">Allowable Budget Dollars</th>
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable2<%if(i < iNumOfPassDays){%>p<%}%>">
               <%if(i==7){%>$<%=sPayAllowed[i]%><%if(sWarnL10[i].equals("1")){%><sup>*</sup><%}%><%} else {%>$<%=sPayAllowed[i]%><%if(sWarnL10[i].equals("1")){%><sup>*</sup><%}%><%}%>
           </td>
        <%}%>
     </tr>
     <!-------------------- Hourly Payroll $ Actual --------------------------->
     <tr class="DataTable">
        <th class="DataTable02" rowspan=2>17</th>
        <th class="DataTable12" rowspan=2 >Actual / Scheduled Payroll $ (Daily/Cumulative)
           <a href="javascript: showActEmp()"><i><sup>(List #2)</sup></i></a>
           <%if(bCurWeek){%><a href="javascript: showSchActEmpGrp()"><i><sup>(List by Grp TY)</sup></i></a>
           <%} else {%><a href="javascript: showActEmpGrp()"><i><sup>(List by Grp TY)</sup></i></a><%}%>
           </a>
        </th>
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable2<%=sCssClsAdd[i]%>">$<%=sActPayAmt[i]%></td>
        <%}%>
        <%if(!bChgOfTrendAllowed){%>
           <td class="DataTable22">$<%=sActPrcPayAmt%></td>
        <%}%>
     </tr>

     <!-------------------- Commulative Hourly Payroll $ Actual --------------------------->
     <tr class="DataTable">
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable2<%=sCssClsAdd[i]%>">$<%=sActComPay[i]%></td>
        <%}%>
        <td class="DataTable2">
        </th>
     </tr>

     <!------------------------ Average Hourly Rate --------------------------->
     <tr class="DataTable">
        <th class="DataTable24" rowspan=3>Hourly<br>Rate</th>
        <th class="DataTable03">18</th>
        <th class="DataTable13">Original Budgeted Average Hourly Rate</th>
        <td class="DataTable3" colspan=7>&nbsp;</td>
        <td class="DataTable21">$<%=sBdgAvg[7]%></td>
     </tr>
     <!------------------------ Allowable Budget Rate ------------------------->
     <tr class="DataTable">
        <th class="DataTable03">19</th>
        <th class="DataTable13">Allowable Budgeted Average Hourly Rate</th>
        <td class="DataTable3" colspan=7>&nbsp;</td>
        <td class="DataTable21">
            $<%=sAlwHrRate%><%if(sWarnL10[7].equals("1")){%><sup>*</sup><%}%>
        </td>
     </tr>
     <!----------------- Actual / Scheduled Average Hourly Rate --------------->
     <tr class="DataTable">
        <th class="DataTable03">20</th>
        <th class="DataTable13">Actual / Scheduled Average Hourly Rate
           <a href="javascript: showGrpBdgAvg()"><i><sup>(Bdg vs Act Avg)</sup></i></a>
        </th>
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable21">$<%=sActPayAvg[i]%></td>
        <%}%>
        <%if(!bChgOfTrendAllowed){%>
           <td class="DataTable22">$<%=sActPrcPayAvg%></td>
        <%}%>
     </tr>

     <tr class="Divdr1"><td style="background: white;"></td><td colspan=11>&nbsp;</td></tr>
     <tr class="Divdr1"><td style="background: white;"></td><td colspan=11>&nbsp;</td></tr>
     <tr class="Divdr1"><td style="background: white;"></td><td colspan=11>&nbsp;</td></tr>

     <!------------------------ Hours +/- Rate -------------------------------->

     <tr class="DataTable">
        <th class="DataTable25" rowspan=5>Variance</th>
        <th class="DataTable04">21</th>
        <th class="DataTable14">Actual / Scheduled Hours vs. Allowable Budget Hours</th>
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable2<%if(i < iNumOfPassDays){%>p<%}%><%if(i==7 && sHrsBdgVar[i].indexOf("-") >= 0){%>g<%} else if(i==7){%>r<%}%>"><%=sHrsBdgVar[i]%></td>
        <%}%>
        <%if(!bChgOfTrendAllowed){%>
           <!--td class="DataTable22"><%=sPrcHrsBdgVar[7]%></td-->
        <%}%>
     </tr>
     <!------------------------ Dollars +/- Rate --------------------------->
     <tr class="DataTable" id="tdFold">
        <th class="DataTable04">22</th>
        <th class="DataTable14">Actual / Scheduled Dollars +/- Allowable Budget Dollars</th>
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable2<%if(i < iNumOfPassDays){%>p<%}%><%if(i==7 && sPayBdgVar[i].indexOf("-") >= 0){%>g<%} else if(i==7){%>r<%}%>">$<%=sPayBdgVar[i]%></td>
        <%}%>
        <%if(!bChgOfTrendAllowed){%>
           <!--td class="DataTable22">$<%=sPrcPayBdgVar[7]%></td-->
        <%}%>
     </tr>

     <!--------------------- Budget Payroll % To Sales ------------------------>
     <tr class="DataTable">
        <th class="DataTable04">23</th>
        <th class="DataTable14">Original Budget Payroll % To Original Sales Plan</th>
        <%for(int i=0; i < 8; i++){%>
           <td class="DataTable2<%if(i < iNumOfPassDays){%>p<%}%>"><%=sBdgPayOfSls[i]%>%</td>
        <%}%>
     </tr>

     <!--------------------- Actual Payroll % To Sales ------------------------>
     <tr class="DataTable">
        <th class="DataTable04">24</th>
        <th class="DataTable14">Actual / Scheduled Payroll %</th>
        <%for(int i=0; i < 7; i++){%>
           <td class="DataTable2<%if(i < iNumOfPassDays){%>p<%}%>"><%=sActPayOfSls[i]%>%</td>
        <%}%>
           <td class="DataTable21<%=sWarnLine23%>"><%=sActPayOfSls[7]%>%</td>
     </tr>
     <!--------------------- Actual Payroll % To Sales ------------------------>
     <tr class="DataTable">
        <th class="DataTable04">25</th>
        <th class="DataTable14">Allowable Budget Payroll %</th>
        <%for(int i=0; i < 7; i++){%>
           <td class="DataTable2<%if(i < iNumOfPassDays){%>p<%}%>"><%=sAllowBdgActPrc[i]%>%</td>
        <%}%>
           <td class="DataTable21"><%=sAllowBdgActPrc[7]%>%</td>
     </tr>

     <%for(int t=0; t < 5; t++){%>
        <tr class="Divdr1"><td style="background: white;" colspan=2></td><td colspan=11>&nbsp;</td></tr>
     <%}%>

     <!--------------- Budget Hours - Training/Meeting/Clinics ---------------->
     <tr class="DataTable">
        <th rowspan=6></th>
        <th class="DataTable26" rowspan=6>TMC</th>
        <th class="DataTable05">1</th>
        <th class="DataTable15">Budget Hours - Training/Meeting/Clinics</th>
        <%for(int i=0; i < 8; i++){%>
            <td class="DataTable2"><%=sBdgTmcHrs[i]%></td>
        <%}%>
        <td class="DataTable2" rowspan=6></td>
     </tr>
     <!--------------------- Hours Actual/Scheduled - TMC ---------------------->
     <tr class="DataTable">
        <th class="DataTable05">2a</th>
        <th class="DataTable15">Hours Scheduled - TMC</th>
        <%for(int i=0; i < 8; i++){%>
            <td class="DataTable2<%if(i < iNumOfPassDays){%>p<%}%>"><%=sTmcHrsSch[i]%></td>
        <%}%>
     </tr>
     <tr class="DataTable">
        <th class="DataTable05">2b</th>
        <th class="DataTable15">Hours Actual - TMC</th>
        <%for(int i=0; i < 8; i++){%>
            <td class="DataTable2<%if(i < iNumOfPassDays){%>p<%}%>"><%=sTmcHrsAct[i]%></td>
        <%}%>
     </tr>
     <!----------------------- Payroll Budget $'s - TMC ----------------------->
     <tr class="DataTable">
        <th class="DataTable05">3</th>
        <th class="DataTable15">Payroll Budget $'s - TMC</th>
        <%for(int i=0; i < 8; i++){%>
            <td class="DataTable2">$<%=sBdgTmcPay[i]%></td>
        <%}%>
     </tr>
     <!--------------------- Hours Payrol $'s/Scheduled - TMC ---------------------->
     <tr class="DataTable">
        <th class="DataTable05">4a</th>
        <th class="DataTable15">Hours Payroll $'s/Scheduled - TMC</th>
        <%for(int i=0; i < 8; i++){%>
            <td class="DataTable2<%if(i < iNumOfPassDays){%>p<%}%>">$<%=sTmcPaySch[i]%></td>
        <%}%>
     </tr>
     <tr class="DataTable">
        <th class="DataTable05">4b</th>
        <th class="DataTable15">Hours Payroll $'s/Actual - TMC</th>
        <%for(int i=0; i < 8; i++){%>
            <td class="DataTable2<%if(i < iNumOfPassDays){%>p<%}%>">$<%=sTmcPayAct[i]%></td>
        <%}%>
     </tr>

    </table>
    <!----------------------- end of table ---------------------------------->



  </table>
 </body>

</html>

<SCRIPT language="JavaScript">
//==============================================================================
// Help text
//==============================================================================
function getHelpText(id)
{
   var text = "";
   if(id == "th1") {text = "1. Represents the percentage of sales by day based on the daily sales"
     + " plan obtained from RCI Corporate." }
   else if(id == "th2") {text = "2. Represents daily sales plan obtained from RCI Corporate." }
   else if(id == "th3") {text = "3. Stores may utilize this field to increase or"
     + " decrease daily / weekly sales (a) to reflect current trends or (b) in anticipation"
     + " of an increase or decrease due to other factors. Adjustments in this field may"
     + " cause Budget Hours to increase or decrease. However if the Sales Forecast is less than or"
     + " equal to the Sales Threshold <br>(per the Base Schedule), hours will not be increased or decreased." }
   else if(id == "th4") {text = "4. Equals adjusted Sales Forecast based on input in Sales Forecast Trend Rate."
     + "<br> = (2) * (100% + (3))" }
   else if(id == "th5") {text = "5. Equals the amount by which Sales Forecast has been"
     + " adjusted based on input in Sales Forecast Trend Rate.<br> = (2) * (3)" }
   else if(id == "th6") {text = "6. Represents Actual daily Sales (for days that have passed) or Forecast daily"
     + " Sales (for days remaining)." }
   else if(id == "th7") {text = "7. Equals the difference between actual sales and Original Sales Plan.<br>= (6) - (2)" }
   else if(id == "th8") {text = "8. Represents the daily hourly payroll budget based on how"
     + " the schedule is written. For example, if a store manager writes a schedule using 12%"
     + " of the total week's hours (for hourly employees) on Monday, then 12% will be reflected"
     + " in the box for Monday." }
   else if(id == "th9") {text = "9. Represents total hourly budgeted hours spread by day. This is calculated"
     + " by taking the total week's budget in hours (obtained from RCI Corporate) and multiplying"
     + " by the percentages shown on line 8." }
   else if(id == "th10") {text = "10. Represents (1) additional/fewer hours earned (or taken away) based on"
     + " actual sales vs. Original Sales Plan or (2) additional hours earned if a salaried"
     + " employee is scheduled for Vacation or Holiday. Excess sales above Original Sales Plan may earn additional hours"
     + " based on the following calculation: <br>Excess sales above Original Sales Plan X Original Budgeted Payroll %,"
     + " divided by 2 <br><br>For example, if a store achieves excess sales of $2,000 budget"
     + " and budgeted store payroll is 10% of sales, the store will earn an additional $100 in payroll"
     + " ($2,000 times 10% divided by 2 equals $100). <br><br>Conversely, if actual sales are below"
     + " budgeted sales, the store may lose hours based on the same calculation. However, no hours"
     + " will be lost if the store is operating at base hours." }
   else if(id == "th11") {text = "11. Equals Budget Hours + Hours Earned<br> = (9) + (10)" }
   else if(id == "th12") {text = "12. Represents adjustment to the scheduled hours needed (for days remaining only)"
     + " to attain weekly Allowable Budget  Hours." }
   else if(id == "th13") {text = "13. Represents actual hours for days passed and hours needed on schedule"
     + " (for days remaning only) to attain weekly Allowable Budget Hours."}
   else if(id == "th14") {text = "14. Represents actual hours (for days passed) and  scheduled hours(for remaining days) "
     + " for hourly employees (click on 'list' for detail)." }
   else if(id == "th15") {text = "15. Represents daily Payroll Budget Dollars based on the"
     + " percentages shown on line (8) - Payroll Budget Spread by Day. The weekly total in this"
     + " line is obtained from line 18 - Budget Hourly Dollars <br> = (16) * (8) " }
   else if(id == "th16") {text = "16. Equals Payroll Budget Dollars plus Hours Earned times Original Budgeted"
     + " Average Hourly Rate.<br> = (15) + ((10) * (19))" }
   else if(id == "th17") {text = "17. Represents actual hourly payroll dollars, including sales commissions"
     + " and entered SPIFFs, for days passed and forecast payroll dollars, based on scheduled hours, for remaining days." }
   else if(id == "th18") {text = "18. Represents budgeted Average Hourly Rate obtained from RCI Corporate." }
   else if(id == "th19") {text = "19. Equals Payroll Budget Dollars divided by Budgeted Hours.<br>"
     + " = (13) / (9)" }
   else if(id == "th20") {text = "20. Equals Actual/Scheduled Hours less Allowable Budget Hours.<br> = (14) - (11)" }
   else if(id == "th21") {text = "21. Equals Actual/Scheduled Dollars less Allowable Budget Dollars.<br> = (17) - (16)" }
   else if(id == "th22") {text = "22. Equals Original Payroll Budget Dollars divided by Original Sales Plan.<br> = (15) / (2)" }
   else if(id == "th23") {text = "23. Equals Actual/Scheduled Payroll Dollars divided by Actual/Forecat Sales.<br> = (17) / (6)" }
   else if(id == "th24") {text = "24. Equals Allowable Budget Payroll Dollars divided by Actual/Forecat Sales.<br> = (16) / (6)" }



   return text;
}
</script>

<%bdgwk.disconnect();%>

<%}%>






