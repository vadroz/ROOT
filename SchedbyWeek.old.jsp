<%@ page import="payrollreports.SetWkSched,  rciutility.SetStrEmp, java.util.*"%>
<%
   String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sWeekEnd = request.getParameter("WEEKEND");
   String sMonth = request.getParameter("MONBEG");
   String sFrom = request.getParameter("FROM");
   String sSchTyp = request.getParameter("SCHTYP");
   String sShwGoal = request.getParameter("SHWGOAL");
   String sNumOfErr = request.getParameter("NumOfErr");
   int iNumOfErr = 0;
   String [] sError = null;
   String sUser = " ";

   if (sNumOfErr != null)
   {
     iNumOfErr =  Integer.parseInt(sNumOfErr);
     String sErrPrm = "Error";
     sError = new String[iNumOfErr];
     for(int i=0; i < iNumOfErr; i++)
     {
       sErrPrm = "Error" + i;
       sError[i] = request.getParameter(sErrPrm);
     }
   }

   if (sSchTyp == null) sSchTyp = "TIM";
   if (sShwGoal == null) sShwGoal = "H";
   if (sFrom == null) sFrom = "BUDGET";

  //-------------- Security ---------------------
  String sStrAllowed = null;
  String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null
    || session.getAttribute("APPLICATION") !=null
    && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     Enumeration  en = request.getParameterNames();
     String sParam =null;
     String sPrmValue = null;
     String sTarget = "PayrollSignOn.jsp?TARGET=SchedbyWeek.jsp&APPL=" + sAppl;
     StringBuffer sbQuery = new StringBuffer() ;

     while (en.hasMoreElements())
      {
        sParam = en.nextElement().toString();
        sPrmValue = request.getParameter(sParam);
          sbQuery.append("&" + sParam + "=" + sPrmValue);
      }
     response.sendRedirect(sTarget + sbQuery.toString());
   }
   else
   {
     sUser = session.getAttribute("USER").toString();
     sStrAllowed = session.getAttribute("STORE").toString();
   }
  // -------------- End Security -----------------


   SetWkSched sWkSch = new SetWkSched(sStore, sWeekEnd);

   int iNumOfMgr = sWkSch.getNumOfMgr();
   int iNumOfSls = sWkSch.getNumOfSls();
   int iNumOfSBk = sWkSch.getNumOfSBk();
   int iNumOfNSl = sWkSch.getNumOfNSl();
   int iNumOfNRc = sWkSch.getNumOfNRc();
   int iNumOfNBk = sWkSch.getNumOfNBk();
   int iNumOfNOt = sWkSch.getNumOfNOt();
   int iNumOfTrn = sWkSch.getNumOfTrn();


   String [][] sMgrSch = null;
   String [][] sSlsSch = null;
   String [][] sSBkSch = null;

   String [][] sNSlSch = null;
   String [][] sNRcSch = null;
   String [][] sNBkSch = null;
   String [][] sNOtSch = null;
   String [][] sTrnSch = null;

   String [][] sSlsGoal = null;
   String [][] sSBkGoal = null;
   String [][] sMgrHTyp = null;
   String [][] sSlsHTyp = null;
   String [][] sSBkHTyp = null;
   String [][] sNSlHTyp = null;
   String [][] sNRcHTyp = null;
   String [][] sNBkHTyp = null;
   String [][] sNOtHTyp = null;
   String [][] sTrnHTyp = null;

   if (sSchTyp.equals("HRS")) {
     sMgrSch = sWkSch.getMgrHrs();
     sSlsSch = sWkSch.getSlsHrs();
     sSBkSch = sWkSch.getSBkHrs();
     sNSlSch = sWkSch.getNSlHrs();
     sNRcSch = sWkSch.getNRcHrs();
     sNBkSch = sWkSch.getNBkHrs();
     sNOtSch = sWkSch.getNOtHrs();
     sTrnSch = sWkSch.getTrnHrs();
   }
   else {
     sMgrSch = sWkSch.getMgrTim();
     sSlsSch = sWkSch.getSlsTim();
     sSBkSch = sWkSch.getSBkTim();
     sNSlSch = sWkSch.getNSlTim();
     sNRcSch = sWkSch.getNRcTim();
     sNBkSch = sWkSch.getNBkTim();
     sNOtSch = sWkSch.getNOtTim();
     sTrnSch = sWkSch.getTrnTim();
   }
   sSlsGoal = sWkSch.getSlsGoal();
   sSBkGoal = sWkSch.getSBkGoal();

   sMgrHTyp = sWkSch.getMgrHTyp();
   sSlsHTyp = sWkSch.getSlsHTyp();
   sSBkHTyp = sWkSch.getSBkHTyp();
   sNSlHTyp = sWkSch.getNSlHTyp();
   sNRcHTyp = sWkSch.getNRcHTyp();
   sNBkHTyp = sWkSch.getNBkHTyp();
   sNOtHTyp = sWkSch.getNOtHTyp();
   sTrnHTyp = sWkSch.getTrnHTyp();

   String [] sMgrTot = sWkSch.getMgrTot();
   String [] sSlsTot = sWkSch.getSlsTot();
   String [] sSBkTot = sWkSch.getSBkTot();
   String [] sNSlTot = sWkSch.getNSlTot();
   String [] sNRcTot = sWkSch.getNRcTot();
   String [] sNBkTot = sWkSch.getNBkTot();
   String [] sNOtTot = sWkSch.getNOtTot();
   String [] sGrpTot = sWkSch.getGrpTot();
   String [] sTrnTot = sWkSch.getTrnTot();

   String [] sMgrOvTm = sWkSch.getMgrOvTm();
   String [] sSlsOvTm = sWkSch.getSlsOvTm();
   String [] sSBkOvTm = sWkSch.getSBkOvTm();
   String [] sNSlOvTm = sWkSch.getNSlOvTm();
   String [] sNRcOvTm = sWkSch.getNRcOvTm();
   String [] sNBkOvTm = sWkSch.getNBkOvTm();
   String [] sNOtOvTm = sWkSch.getNOtOvTm();
   String [] sTrnOvTm = sWkSch.getTrnOvTm();

   String [] sMgrOvTmClr = sWkSch.getMgrOvTmClr();
   String [] sSlsOvTmClr = sWkSch.getSlsOvTmClr();
   String [] sSBkOvTmClr = sWkSch.getSBkOvTmClr();
   String [] sNSlOvTmClr = sWkSch.getNSlOvTmClr();
   String [] sNRcOvTmClr = sWkSch.getNRcOvTmClr();
   String [] sNBkOvTmClr = sWkSch.getNBkOvTmClr();
   String [] sNOtOvTmClr = sWkSch.getNOtOvTmClr();
   String [] sTrnOvTmClr = sWkSch.getTrnOvTmClr();

   String [] sMgrMlt = sWkSch.getMgrMlt();
   String [] sSlsMlt = sWkSch.getSlsMlt();
   String [] sSBkMlt = sWkSch.getSBkMlt();
   String [] sNSlMlt = sWkSch.getNSlMlt();
   String [] sNRcMlt = sWkSch.getNRcMlt();
   String [] sNBkMlt = sWkSch.getNBkMlt();
   String [] sNOtMlt = sWkSch.getNOtMlt();
   String [] sTrnMlt = sWkSch.getTrnMlt();

   String [] sMgrMltClr = sWkSch.getMgrMltClr();
   String [] sSlsMltClr = sWkSch.getSlsMltClr();
   String [] sSBkMltClr = sWkSch.getSBkMltClr();
   String [] sNSlMltClr = sWkSch.getNSlMltClr();
   String [] sNRcMltClr = sWkSch.getNRcMltClr();
   String [] sNBkMltClr = sWkSch.getNBkMltClr();
   String [] sNOtMltClr = sWkSch.getNOtMltClr();
   String [] sTrnMltClr = sWkSch.getTrnMltClr();

   String [] sMgrDpt = sWkSch.getMgrDpt();
   String [] sSlsDpt = sWkSch.getSlsDpt();
   String [] sSBkDpt = sWkSch.getSBkDpt();
   String [] sNSlDpt = sWkSch.getNSlDpt();
   String [] sNRcDpt = sWkSch.getNRcDpt();
   String [] sNBkDpt = sWkSch.getNBkDpt();
   String [] sNOtDpt = sWkSch.getNOtDpt();
   String [] sTrnDpt = sWkSch.getTrnDpt();

   String [] sMgrTtl = sWkSch.getMgrTtl();
   String [] sSlsTtl = sWkSch.getSlsTtl();
   String [] sSBkTtl = sWkSch.getSBkTtl();
   String [] sNSlTtl = sWkSch.getNSlTtl();
   String [] sNRcTtl = sWkSch.getNRcTtl();
   String [] sNBkTtl = sWkSch.getNBkTtl();
   String [] sNOtTtl = sWkSch.getNOtTtl();
   String [] sTrnTtl = sWkSch.getTrnTtl();

   String [] sMgrDay = sWkSch.getMgrDay();
   String [] sSlsDay = sWkSch.getSlsDay();
   String [] sNSlDay = sWkSch.getNSlDay();
   String [] sTrnDay = sWkSch.getTrnDay();
   String [] sTotDay = sWkSch.getTotDay();

   String [] sMgrTimOff = sWkSch.getMgrTimOff();
   String [] sSlsTimOff = sWkSch.getSlsTimOff();
   String [] sSBkTimOff = sWkSch.getSBkTimOff();
   String [] sNSlTimOff = sWkSch.getNSlTimOff();
   String [] sNRcTimOff = sWkSch.getNRcTimOff();
   String [] sNBkTimOff = sWkSch.getNBkTimOff();
   String [] sNOtTimOff = sWkSch.getNOtTimOff();
   String [] sTrnTimOff = sWkSch.getTrnTimOff();

   String [] sMgrOvr7 = sWkSch.getMgrOvr7();
   String [] sSlsOvr7 = sWkSch.getSlsOvr7();
   String [] sSBkOvr7 = sWkSch.getSBkOvr7();
   String [] sNSlOvr7 = sWkSch.getNSlOvr7();
   String [] sNRcOvr7 = sWkSch.getNRcOvr7();
   String [] sNBkOvr7 = sWkSch.getNBkOvr7();
   String [] sNOtOvr7 = sWkSch.getNOtOvr7();
   String [] sTrnOvr7 = sWkSch.getTrnOvr7();

   String [] sMgrAvail = sWkSch.getMgrAvail();
   String [] sSlsAvail = sWkSch.getSlsAvail();
   String [] sSBkAvail = sWkSch.getSBkAvail();
   String [] sNSlAvail = sWkSch.getNSlAvail();
   String [] sNRcAvail = sWkSch.getNRcAvail();
   String [] sNBkAvail = sWkSch.getNBkAvail();
   String [] sNOtAvail = sWkSch.getNOtAvail();
   String [] sTrnAvail = sWkSch.getTrnAvail();

   String sMgrAvailJSA = sWkSch.getMgrAvailJSA();
   String sSlsAvailJSA = sWkSch.getSlsAvailJSA();
   String sSBkAvailJSA = sWkSch.getSBkAvailJSA();
   String sNSlAvailJSA = sWkSch.getNSlAvailJSA();
   String sNRcAvailJSA = sWkSch.getNRcAvailJSA();
   String sNBkAvailJSA = sWkSch.getNBkAvailJSA();
   String sNOtAvailJSA = sWkSch.getNOtAvailJSA();
   String sTrnAvailJSA = sWkSch.getTrnAvailJSA();

   String [] sWkDate = sWkSch.getWeekDate();
   String [] sShort = sWkSch.getShort();
   String [] sWkDays = new String[]{"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun" } ;
   String [] sDaysOfWeek = new String[]{"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" } ;

   String [] sEmpDay = new String[]{sWkSch.getEmpbyDay(1),sWkSch.getEmpbyDay(2),
              sWkSch.getEmpbyDay(3),sWkSch.getEmpbyDay(4),sWkSch.getEmpbyDay(5),
              sWkSch.getEmpbyDay(6),sWkSch.getEmpbyDay(7)};
   String [] sDailySlsGoal = sWkSch.getDailySlsGoal();
   String [] sSlsGoalHr = sWkSch.getSlsGoalHr();
   String sWeeks = sWkSch.getWeeksJSA();
   String sMonthBegs =  sWkSch.getMonthBegsJSA();
   String sBaseWkJSA = sWkSch.getBaseWksJSA();
   String sBsWkNameJSA = sWkSch.getBsWkNameJSA();
   String sBaseMn = sWkSch.getBaseMonJSA();

   String [] sBaseWk = sWkSch.getBaseWk();
   String [] sBsWkName = sWkSch.getBsWkName();

   // number employee working per hour
   String [] sMgrByHrs = sWkSch.getEmpByHrs("MNGR");
   String [] sSlsByHrs = sWkSch.getEmpByHrs("SLSP");
   String [] sNSlByHrs = sWkSch.getEmpByHrs("NSLSP");
   String [] sTotByHrs = sWkSch.getEmpByHrs("TOTAL");

   // Last user/date/time
   String sLastChgDate = sWkSch.getLastDate();
   String sLastChgTime = sWkSch.getLastTime();
   String sUserId = sWkSch.getLastUser();

   // store weekly events
   int iNumOfEvt = sWkSch.getNumOfEvt();
   String [] sEvents = sWkSch.getEvents();
   int [] iEvtDay = sWkSch.getEvtDay();
   String [] sEvtTime = sWkSch.getEvtTime();
   String [] sEvtCmt = sWkSch.getEvtCmt();
   String sEventsJSA = sWkSch.getEventsJSA();
   String sEvtDayJSA = sWkSch.getEvtDayJSA();
   String sEvtTimeJSA = sWkSch.getEvtTimeJSA();
   String sEvtCmtJSA = sWkSch.getEvtCmtJSA();


   String sEMail = sWkSch.getEMail();
   String sApproveSts = sWkSch.getAprvSts();
   String sNewHire = sWkSch.getNewHire();

   sWkSch.disconnect();
   // get Employees numbers and names
   SetStrEmp StrEmp = null;
   if(sWeekEnd.substring(6, 10).equals("2099")) StrEmp =  new SetStrEmp(sStore,"BASE");
   else StrEmp =  new SetStrEmp(sStore,"RCI");

   int iNumOfEmp = StrEmp.getNumOfEmp();
   String [] sEmpNum = StrEmp.getEmpNum();
   String [] sEmpName = StrEmp.getEmpName();
   String [] sDptName = StrEmp.getDptName();
   String [] sDptType = StrEmp.getDptType();
   String sDayAvailJSA = StrEmp.getDayAvailJSA();
   String sTimeOffTypeJSA = StrEmp.getTimeOffTypeJSA();
   StrEmp.disconnect();

   // Hours/Minutes array
   String [] sHrsTxt = new String[]{"07","08","09","10","11","12",
                                 "01","02","03","04","05","06",
                                 "07","08","09","10","11","12"};
   String [] sHrs = new String[18];
   String [] sMin = new String[]{"00", "15", "30", "45"};
   for(int i=7; i<25;i++){
     sHrs[i-7] = Integer.toString(i);
     if (sHrs[i-7].length()== 1) {
        sHrs[i-7] = "0" + sHrs[i-7];
     }
   }

   String [] sAllEmp = new String[iNumOfMgr + iNumOfSBk + iNumOfSls
                     + iNumOfNSl + iNumOfNRc + iNumOfNBk + iNumOfNOt + iNumOfTrn];
   int iAll = 0;
   for(int i=iAll; i<iNumOfMgr; i++, iAll++){ sAllEmp[i] = sMgrSch[i][0];}
   for(int i=iAll; i<iNumOfSls; i++, iAll++){ sAllEmp[i] = sSlsSch[i][0];}
   for(int i=iAll; i<iNumOfSBk; i++, iAll++){ sAllEmp[i] = sSBkSch[i][0];}
   for(int i=iAll; i<iNumOfNSl; i++, iAll++){ sAllEmp[i] = sNSlSch[i][0];}
   for(int i=iAll; i<iNumOfNRc; i++, iAll++){ sAllEmp[i] = sNRcSch[i][0];}
   for(int i=iAll; i<iNumOfNBk; i++, iAll++){ sAllEmp[i] = sNBkSch[i][0];}
   for(int i=iAll; i<iNumOfNOt; i++, iAll++){ sAllEmp[i] = sNOtSch[i][0];}
   for(int i=iAll; i<iNumOfTrn; i++, iAll++){ sAllEmp[i] = sTrnSch[i][0];}

   // Use name of base weeks instead of date
   String sWeekName = sWeekEnd;
   if(sWeekEnd.substring(6, 10).equals("2099"))
   {
     for(int i=0; i < sBaseWk.length; i++)
     {
       if (sWeekEnd.equals(sBaseWk[i]))
       {
         sWeekName = sBsWkName[i];
       }
     }
   }

%>
<html>
<head>
<style>
        body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        a.Menu:link { color:black; text-decoration:none }
        a.Menu:visited { color:black; text-decoration:none }
        a.Menu:hover { color:red; text-decoration:none }

        table.DataTable { border: darkred solid 1px; background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:right; font-family:Verdanda; font-size:12px }
        th.DataTable2 { background:#FFCC99; cursor: hand; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        td.DataTable2 { color:red; background:cornsilk; cursor: hand; border-top: darkred solid 1px; border-bottom: darkred solid 1px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
        td.DataTable3 { color:red; background:cornsilk; border-top: double darkred;  border-right: darkred solid 1px;padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:11px; font-weight:bold }

        td.DataTable9 { color:red; background:cornsilk; border-top: double darkred; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable10 { color:brown;  cursor: hand; background: Linen; border-top: darkred solid 1px; border-bottom: darkred solid 1px; padding-top:0px; padding-bottom:0px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable11 { color:red; background:cornsilk; cursor: hand; border-top: double darkred; border-bottom: darkred solid 1px;  border-right: darkred solid 1px;padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:11px; font-weight:bold}
        td.DataTable12 { color:red; background:cornsilk; border-top: double darkred; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable13 { color:red; background:cornsilk; border-bottom: darkred solid 1px; border-top: double darkred; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable14 { color:red; background:cornsilk; border-bottom: darkred solid 1px; border-top: double darkred; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable15 { color:red; background:cornsilk; border-top: darkred solid 1px; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable16 { color:red; background:cornsilk; border-top: darkred solid 1px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable17 { background: Linen; border-top: darkred solid 1px; border-bottom: darkred solid 1px; padding-top:0px; padding-bottom:0px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }

        td.Total { color:red; background:cornsilk; border-top: double darkred; border-bottom: darkred solid 1px; border-right: darkred solid 1px;padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:11px; font-weight:bold }
        td.Total1 { color:red; background:cornsilk; border-top: double darkred; border-bottom: darkred solid 1px; border-right: darkred solid 1px;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Arial; font-size:10px;}
        td.Total2 { color:red; background:cornsilk; border-top: double darkred; border-bottom: darkred solid 1px; padding-top:3px; padding-bottom:3px; text-align:center; font-family:Arial; font-size:10px}

        th.EntTbl  { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; font-weight:bolder}
        td.EntTbl  { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }
        td.EntTbl1 { background:white; border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }
        td.EntTbl2 { background:red; border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }
        td.EntTbl3 { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:9px; }
        td.EntTbl4 { background:green; border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }
        td.EntTbl5 { text-align:center; font-family:Arial; font-size:10px; }

        div.Menu  {position:absolute;visibility:hidden; background-attachment: scroll;
              border: black solid 3px; width:150px;background-color:Azure; z-index:10;
              text-align:center;}
        div.Tootip { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
        div.MsgBrd { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:110px; height:25px;
              background-color:Azure; z-index:10;
              text-align:center; font-size:10px}

        td.Menu   {border-bottom: black solid 1px; cursor: hand; text-align:left; font-family:Arial; font-size:10px; }
        td.Menu1  {border-bottom: black solid 1px; text-align:left; font-family:Arial; font-size:12px; }
        td.Menu2  {text-align:right; font-family:Arial; font-size:12px; }
        td.Menu3  {border-bottom: black solid 1px; text-align:left; font-family:Arial; font-size:10px; }

        td.MsgBrd   {border-bottom: black solid 1px; font-family:Arial; font-size:10px; }
        td.MsgBrd1   {font-family:Arial; font-size:10px; }

        div.shwTime {visibility:hidden; color:brown; font-size:12px; font-weight:bolder}

        td.Grid  { background:darkblue; color:white; text-align:center; font-family:Arial; font-size:11px;
                   padding-left:3px; padding-right:3px; font-weight:bolder}
        tr.Grid1 { text-align:center; font-family:Arial; font-size:10px;}
        td.Grid2  { background:darkblue; color:white; text-align:right; font-family:Arial; font-size:11px; font-weight:bolder}
        button.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:center; font-family:Arial; font-size:10px;}
        textarea.small{ text-align:left; font-family:Arial; font-size:10px;}
        input.small{ text-align:left; font-family:Arial; font-size:10px;}

@media screen
{
        td.DataTable { background:lightgrey; cursor: hand; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
	td.DataTable1 { background:lightgrey; cursor: hand; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable4 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable6 { background: #afdcec; cursor: hand; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-style: italic; font-size:10px }
        td.DataTable7 { background: #99c68e; cursor: hand; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-style: italic; font-size:10px }
        td.DataTable8 { background: gold; cursor: hand; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-style: italic; font-size:10px }
}

@media print {
        td.DataTable {   border-bottom: darkred solid 1px; background:lightgrey; cursor: hand; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
	td.DataTable1 {  border-bottom: darkred solid 1px;background:lightgrey; cursor: hand; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable4 {  border-bottom: darkred solid 1px;background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable6 {  border-bottom: darkred solid 1px;background: #afdcec; cursor: hand; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-style: italic; font-size:10px }
        td.DataTable7 {  border-bottom: darkred solid 1px;background: #99c68e; cursor: hand; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-style: italic; font-size:10px }
        td.DataTable8 {  border-bottom: darkred solid 1px;background: gold; cursor: hand; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-style: italic; font-size:10px }
}

</style>
<SCRIPT language="JavaScript1.2">

var NumOfErr = "<%=iNumOfErr%>";
var Error = "<br>";
<%for(int i=0; i < iNumOfErr; i++){ %>
  Error += "<%=sError[i]%>" + "<br>";
<%}%>

var CurStore = <%=sStore%>;
var CurStrName = "<%=sThisStrName%>";
var CurStrName = "<%=sThisStrName%>";
var Month = "<%=sMonth%>"
var WeekEnd = "<%=sWeekEnd%>"
var EmpNum = new Array(<%=sEmpNum.length%>)
var EmpName = new Array(<%=sEmpName.length%>)
var DptName = new Array(<%=sDptName.length%>)
var TimeOffType = [<%=sTimeOffTypeJSA%>];
var DayAvail = [<%=sDayAvailJSA%>];
var From = "<%=sFrom%>"
var DptType = new Array(<%=sDptType.length%>)
var SelDays;

var BaseWk = [<%=sBaseWkJSA%>];
var BsWkName = [<%=sBsWkNameJSA%>];
var BaseMn = [<%=sBaseMn%>];

var EmpDay1 = [<%=sEmpDay[0]%>];
var EmpDay2 = [<%=sEmpDay[1]%>];
var EmpDay3 = [<%=sEmpDay[2]%>];
var EmpDay4 = [<%=sEmpDay[3]%>];
var EmpDay5 = [<%=sEmpDay[4]%>];
var EmpDay6 = [<%=sEmpDay[5]%>];
var EmpDay7 = [<%=sEmpDay[6]%>];
var Weeks = [<%=sWeeks%>]
var MonthBegs = [<%=sMonthBegs%>]

var MgrByHrs = new Array(7);
<%for(int i=0; i<7; i++){%>
  MgrByHrs[<%=i%>] = [<%=sMgrByHrs[i]%>]
<%}%>
var SlsByHrs = new Array(7);
<%for(int i=0; i<7; i++){%>
  SlsByHrs[<%=i%>] = [<%=sSlsByHrs[i]%>]
<%}%>
var NSlByHrs = new Array(7);
<%for(int i=0; i<7; i++){%>
  NSlByHrs[<%=i%>] = [<%=sNSlByHrs[i]%>]
<%}%>
var TotByHrs = new Array(7);
<%for(int i=0; i<7; i++){%>
  TotByHrs[<%=i%>] = [<%=sTotByHrs[i]%>]
<%}%>

<%for(int i=0; i < sEmpNum.length; i++){%>
   EmpNum[<%=i%>] = "<%=sEmpNum[i]%>"
   EmpName[<%=i%>] = "<%=sEmpName[i]%>"
   DptName[<%=i%>] = "<%=sDptName[i]%>"
   DptType[<%=i%>] = "<%=sDptType[i]%>"
<%}%>
var NumOfAllEmp = <%=(iNumOfMgr + iNumOfSls + iNumOfNSl)%>
var AllEmp = new Array("<%=sAllEmp.length%>")
<%for(int i=0; i < sAllEmp.length; i++){%>
   AllEmp[<%=i%>] = "<%=sAllEmp[i]%>"
<%}%>

var WkDate = new Array(<%=sWkDate.length%>);
<%for(int i=0; i < sWkDate.length; i++){%>
    WkDate[<%=i%>] = "<%=sWkDate[i]%>"
<%}%>

var NewHire = "<%=sNewHire%>"
var WkDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

var Events = [<%=sEventsJSA%>];
var EvtDay = [<%=sEvtDayJSA%>];
var EvtTime = [<%=sEvtTimeJSA%>];
var Events = [<%=sEventsJSA%>];
var EvtCmt = [<%=sEvtCmtJSA%>];

var MgrAvail = [<%=sMgrAvailJSA%>]
var SlsAvail = [<%=sSlsAvailJSA%>]
var SBkAvail = [<%=sSBkAvailJSA%>]
var NSlAvail = [<%=sNSlAvailJSA%>]
var NRcAvail = [<%=sNRcAvailJSA%>]
var NBkAvail = [<%=sNBkAvailJSA%>]
var NOtAvail = [<%=sNOtAvailJSA%>]
var TrnAvail = [<%=sTrnAvailJSA%>]

var selectedEmployee
var selectedGrp
var selectedGrpName
var selectedHrsType = new Array(7);
var selectedTimOffType
var selDayAvl
var selTimAvl

var selectedEvent
var selectedEvtNum = -1;
var selEvtDay = -1;
var selEvtTime
var selEvtDtl
var selEvtInf

// this variable use to keep selected time in hour entry table
var BegTime = null;
var EndTime = null;
var table = null;
var cells = null;

var savDate = new Array(7);
var savBegTim = new Array(7);
var savEndTim = new Array(7);
var savArg=-1;

var AprvSts;
var AprvSnd;
var AprvDat;
var AprvTim;
var msgTable;

var Allow = "NO"

// body load
function bodyLoad()
{
  if (NumOfErr > "0")
  {
    var WindowName = 'Error_Report';
    var WindowOptions =
     'width=400,height=200, left=180,top=80, toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,resize=no,menubar=no';
    var generator=window.open('', WindowName, WindowOptions);

    generator.document.write('<html><head><title>Error Report</title>');
    generator.document.write('<style>p.ErrMsg{color:red; text-align:center;');
    generator.document.write('font-family:Arial; font-size:12px; font-weight:bolder }</style>');
    generator.document.write('</head><body>');
    generator.document.write('<p class="ErrMsg">' + Error);
    generator.document.write('<p align=center><a href="javascript:self.close()">Close</a>');
    generator.document.write('</body></html>');
    generator.document.close();
  }
  chkMsgBoard();
}

// Show Hours or Schedule
function chgSch(type){
 var schtyp = null;
 if (type.value == "Hours")  schtyp = 'HRS';
 else schtyp = 'TIM';
 var loc = "SchedbyWeek.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>"
         + "&SCHTYP=" + schtyp
         + "&SHWGOAL=<%=sShwGoal%>";
 window.location.href = loc
}

// Show/Hide Sales Goal
function dspGoal(type)
{
 var shwgoal = type.value.substring(0,1)
 var loc = "SchedbyWeek.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>"
         + "&SCHTYP=<%=sSchTyp%>"
         + "&SHWGOAL=" + shwgoal;
  //alert(loc)
 window.location.href = loc
}

// display another week
function chgSelDate()
{
 var selIdx = document.all.newDate.options.selectedIndex;
 var newWeekEnd = document.all.newDate.options[selIdx].value;
 var mon = null;
 if(MonthBegs.length > selIdx){ mon = MonthBegs[selIdx]; }
 else{ mon = BaseMn[selIdx - MonthBegs.length]; }

 var loc = "SchedbyWeek.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>"
         + "&MONBEG=" + mon
         + "&WEEKEND=" + newWeekEnd
         + "&SCHTYP=<%=sSchTyp%>" + "&SHWGOAL=<%=sShwGoal%>";
 //alert(loc)
 hidetip2();
 window.location.href = loc
}

function ShowMenu(obj, goal, tmOff){
 var prefx = obj.id.substring(0,4);
 var emp = obj.id.substring(4,43);
 var day;
 var grp;
 var grpname;
 if (tmOff!=null) selectedTimOffType = tmOff;

 var subgrp=null;
 var curLeft = 0;
 var curTop = 0;
 var MenuHtml;
 var MenuGoal= " ";
 var MenuEmp = "<td class='Menu1' nowrap><b>" + emp.substring(5) + "</b>" + "</td>";
 var MenuGrp = " ";
 var MenuSub = " ";
 var MenuAdd = " ";
 var MenuNew = " ";
 var MenuVac = " ";
 var MenuHol = " ";
 var MenuOff = " ";
 var MenuDel = " ";
 var MenuCpy = " ";
 var MenuMov = " ";
 var MenuAvl = " ";

  // customize menu options depend on selected employee group
 if(prefx.substring(0,1) == "M")
 {
     grp = 'MNGR';
     MenuGrp = "<tr><td class='Menu3' colspan='2' align='center'>Group: Manager</td></tr>";
     grpname='Managers';
 }
 else if(prefx.substring(0,2) == "SL")
 {
     grp = 'SLSP'
     MenuGrp="<tr><td class='Menu3' colspan='2' align='center'>Group: Sales personnel</td></tr>";
     grpname='Sales personnel';
     subgrp='Regular Sales';
     MenuSub = "<tr><td class='Menu3' colspan='2' align='center'>Sub-Group: Salesman</td></tr>";
 }
 else if(prefx.substring(0,2) == "SB")
 {
     grp = 'SLBK'
     MenuGrp="<tr><td class='Menu3' colspan='2' align='center'>Group: Sales personnel</td></tr>";
     grpname='Sales personnel';
     subgrp='Bike Sales';
     MenuSub = "<tr><td class='Menu3' colspan='2' align='center'>Sub-Group: Bike Department</td></tr>";
 }
 else if(prefx.substring(0,2) == "NC")
  {
     grp = 'NSLSP';
     MenuGrp="<tr><td class='Menu3' colspan='2' align='center'>Group: Non-sales personnel</td></tr>";
     grpname='Non-sales personnel';
     subgrp='Cashiers';
     MenuSub = "<tr><td class='Menu3' colspan='2' align='center'>Sub-Group: Cashiers</td></tr>";
  }
  else if(prefx.substring(0,2) == "NR")
  {
     grp = 'NSLRC';
     MenuGrp="<tr><td class='Menu3' colspan='2' align='center'>Group: Non-sales personnel</td></tr>";
     grpname='Non-sales personnel';
     subgrp='Receiving';
     MenuSub = "<tr><td class='Menu3' colspan='2' align='center'>Sub-Group: Receiving</td></tr>";
  }
  else if(prefx.substring(0,2) == "NB")
  {
     grp = 'NSLBK';
     MenuGrp="<tr><td class='Menu3' colspan='2' align='center'>Group: Non-sales personnel</td></tr>";
     grpname='Non-sales personnel';
     subgrp='Bike Sales';
     MenuSub = "<tr><td class='Menu3' colspan='2' align='center'>Sub-Group: Bike Shop</td></tr>";
  }
  else if(prefx.substring(0,2) == "NO")
  {
     grp = 'NSLOT';
     MenuGrp="<tr><td class='Menu3' colspan='2' align='center'>Group: Non-sales personnel</td></tr>";
     grpname='Non-sales personnel';
     subgrp='Other';
     MenuSub = "<tr><td class='Menu3' colspan='2' align='center'>Sub-Group: Other</td></tr>";
  }
  else if(prefx.substring(0,2) == "NT")
  {
     grp = 'NSLTR';
     MenuGrp="<tr><td class='Menu3' colspan='2' align='center'>Group: Non-sales personnel</td></tr>";
     grpname='Non-sales personnel';
     subgrp='Training';
     MenuSub = "<tr><td class='Menu3' colspan='2' align='center'>Sub-Group: Training</td></tr>";
  }
  else if(prefx.substring(0,2) == "TR")
  {
     grp = 'TRAIN';
     MenuGrp="<tr><td class='Menu3' colspan='2' align='center'>Group: Training</td></tr>";
     grpname='Training';
  }


 // customize menu options for selected employee day
 if(prefx.substring(2,4) == "DS"){
   day = obj.id.substring(44);
   MenuAdd = "<tr><td class='Menu' colspan='2' align='center' "
           + "onclick='getEmpDaySel(&#34;"
           + grp + "&#34;, &#34;" + grpname + "&#34;, &#34;"
           + emp + "&#34;, &#34;" + day + "&#34;, false, false); hideMenu();'>Add/Override"
           + "</td></tr>"
   MenuOff = "<tr><td colspan='2' class='Menu' align='center' "
           + "onclick='genReqOff(&#34;"
           + emp + "&#34;, &#34;" + grp + "&#34;, &#34;" + day + "&#34;); hideMenu();'>Requires day off"
           + "</td></tr>"
   MenuDel = "<tr><td colspan='2' class='Menu' align='center' "
           + "onclick='dltEntry(&#34;"
           + emp + "&#34;, &#34;" + grp + "&#34;, &#34;" + day + "&#34;,null); hideMenu();'>Delete"
           + "</td></tr>"

   if(grp == 'SLSP')
   {
      MenuGoal= "<tr><td class='Menu' colspan='2' align='center'>" + "Sales Goal: " + goal + "</td></tr>";
   }

 }
 // customize menu options for selected employee
 else if(prefx.substring(2,4) == "EN"){
   MenuAdd = "<tr><td class='Menu' colspan='2' align='center' "
           + "onclick='addNew(&#34;" + grp + "&#34;, &#34;" + grpname + "&#34;, "
           + "&#34;" + subgrp + "&#34;, "
           + "&#34;" + emp + "&#34;);hideMenu();'>Add/Override"
           + "</td></tr>";
   if(emp.substring(5,13)!="New Hire")
   {
      MenuCpy = "<tr><td class='Menu' colspan='2' align='center' "
              + "onclick='selectWeekEnd(&#34;COPY&#34;,"
              + "&#34;" + emp + "&#34;, &#34;" + grp + "&#34;, &#34;EMPWEEK&#34;); hideMenu();'>Copy"
              + "</td></tr>"
      MenuMov = "<tr><td class='Menu' colspan='2' align='center' "
           + "onclick='selectNewGrp("
           + "&#34;" + emp + "&#34;, &#34;" + grp + "&#34;); hideMenu();'>Move"
           + "</td></tr>";
   }
   MenuDel = "<tr><td colspan='2' class='Menu' align='center' "
           + "onclick='dltEntry(&#34;"
           + emp + "&#34;, &#34;" + grp + "&#34;, null, &#34;EMPWEEK&#34;); hideMenu();'>Delete whole week"
           + "</td></tr>"

   MenuAvl = setAvail(emp, grp);
 }
 // customize menu options for selected group
 else if(prefx.substring(2,4) == "GP"){
   MenuAdd = "<tr><td class='Menu' colspan='2' align='center' "
           + "onclick='addNew(&#34;" + grp + "&#34;, &#34;"
           + grpname + "&#34;, "
           + "&#34;" + subgrp + "&#34;"
           + ");hideMenu();'>Add/Override"
           + "</td></tr>";
   if (prefx.substring(0,2) == "NO")
   {
      MenuNew = "<tr><td class='Menu' colspan='2' align='center' "
           + "onclick='addNewHire(&#34;" + grp + "&#34;, &#34;"
           + grpname + "&#34;, "
           + "&#34;" + subgrp + "&#34;, "
           + "&#34;" + NewHire + ' New Hire' + "&#34;);hideMenu();'>Add New Hire"
           + "</td></tr>";
   }
   MenuCpy = "<tr><td class='Menu' colspan='2' align='center' "
           + "onclick='selectWeekEnd(&#34;COPY&#34;,"
           + "&#34;GRP&#34;, &#34;" + grp + "&#34;, &#34;GRPWEEK&#34;); hideMenu();'>Copy"
           + "</td></tr>"
   MenuEmp = "<td class='Menu1' nowrap><b>" + grpname + "</b></td>";
   MenuGrp = " " ;
   MenuDel = "<tr><td colspan='2' class='Menu' align='center' "
           + "onclick='dltEntry(&#34;"
           + "GRP&#34;, &#34;" + grp + "&#34;, null, &#34;GRPWEEK&#34;);hideMenu();'>Delete whole week"
           + "</td></tr>"
 }
 // customize menu options for store
 else if(prefx == "ALL"){
   MenuEmp = "<td class='Menu1' nowrap><b>Store</b></td>";
   MenuGrp = " ";
   MenuCpy = "<tr><td class='Menu' colspan='2' align='center' "
           + "onclick='selectWeekEnd(&#34;COPY&#34;,"
           + "&#34;ALL&#34;, &#34;ALL&#34;, &#34;STRWEEK&#34;); hideMenu();'>Copy"
           + "</td></tr>"
   MenuDel = "<tr><td colspan='2' class='Menu' align='center' "
           + "onclick='dltEntry(&#34;"
           + "STR&#34;, &#34;ALL&#34;, null, &#34;STRWEEK&#34;); hideMenu();'>Delete whole week"
           + "</td></tr>"
 }

 if (obj.offsetParent) {
   while (obj.offsetParent){
     curLeft += obj.offsetLeft
     curTop += obj.offsetTop
     obj = obj.offsetParent;
   }
 }
 else if (obj.x) {
    curLeft += obj.x;
    curTop += obj.y;
 }

 MenuHtml = "<table width='100%' cellPadding='0' cellSpacing='0'>"
   + "<tr>"
   + MenuEmp
   + "<td class='Menu2' valign=top>"
   +  "<img src='CloseButton.bmp' onclick='javascript:hideMenu();' alt='Close'>"
   + "</td></tr>"
   + MenuGrp + MenuSub + MenuGoal + MenuAdd + MenuNew + MenuCpy + MenuVac + MenuHol + MenuOff
   + MenuMov + MenuDel + MenuAvl
   + "<tr><td colspan='2' class='Menu' align='center' "
   + "onclick='hideMenu();'>Close"
   + "</td></tr>"
   + "</table>"


    if (curTop > (document.documentElement.scrollTop + screen.height - 250))
    {
      curTop = document.documentElement.scrollTop + screen.height - 300;
    }
    curLeft += 70;
    if (curLeft > (document.documentElement.scrollLeft + screen.width - 200))
    {
      curLeft = document.documentElement.scrollLeft + screen.width - 200;
    }

    document.all.menu.innerHTML=MenuHtml
    document.all.menu.style.pixelLeft=curLeft
    document.all.menu.style.pixelTop=curTop
    document.all.menu.style.visibility="visible"
}

function ShowEvtMenu(obj, EvtNum)
{
   var MenuName = null;
   var MenuDlt = null;
   var MenuAdd = null;
   var MenuDsp = " ";
   var MenuClose = "<tr><td colspan='2' class='Menu' align='center' "
     + "onclick='hideMenu();'>Close"
     + "</td></tr>";
   if (EvtNum == null)
   {
     MenuName = "<td class='Menu'>Events</td>";
     MenuDlt = "<tr><td class='Menu' onclick='dltEvtEntry(&#34;ALL&#34;, null); hideMenu();'>Delete all events</td></tr>";
     MenuAdd = "<tr><td class='Menu' onclick='selEvtProp(null); hideMenu();'>Add</td></tr>";
   }
   else
   {
     MenuName = "<td class='Menu'>" + Events[EvtNum] + " " + WkDate[EvtDay[EvtNum]] + "</td>";
     MenuDlt = "<tr><td class='Menu' onclick='dltEvtEntry(&#34;"
      + Events[EvtNum]
      + "&#34;," + EvtDay[EvtNum] + "); hideMenu();'>Delete</td></tr>";
     MenuAdd = "<tr><td class='Menu' onclick='selEvtProp(&#34;"
      + EvtNum + "&#34;); hideMenu();'>Override</td></tr>";

     MenuDsp = "<tr><td class='Menu' onclick='dspEvtEntry(&#34;"
      + EvtNum + "&#34;," + EvtDay[EvtNum] + "); hideMenu();'>Comments</td></tr>";

   }

   var curLeft = 0;
   var curTop = 0;

   var MenuHtml = "<table width='100%' cellPadding='0' cellSpacing='0'>"
   + "<tr>"
     + MenuName
     + "<td class='Menu2' valign=top>"
     +  "<img src='CloseButton.bmp' onclick='javascript:hideMenu();' alt='Close'>"
     + "</td>"
   + "</tr>"
   + MenuAdd
   + MenuDsp
   + MenuDlt
   + MenuClose
   + "</table>"


   if (obj.offsetParent) {
   while (obj.offsetParent){
     curLeft += obj.offsetLeft
     curTop += obj.offsetTop
     obj = obj.offsetParent;
   }
 }
 else if (obj.x) {
    curLeft += obj.x;
    curTop += obj.y;
 }

 if (curTop > (document.documentElement.scrollTop + screen.height - 250))
    {
      curTop = document.documentElement.scrollTop + screen.height - 300;
    }
    curLeft += 70;
    if (curLeft > (document.documentElement.scrollLeft + screen.width - 200))
    {
      curLeft = document.documentElement.scrollLeft + screen.width - 200;
 }

 document.all.menu.innerHTML=MenuHtml
 document.all.menu.style.pixelLeft=curLeft
 document.all.menu.style.pixelTop=curTop
 document.all.menu.style.visibility="visible"
}


// dispaly Event details
function dspEvtEntry(EvtNum, DayNum)
{
  var eventHtml = "<table cellPadding='0' cellSpacing='0' width='100%'>"
      eventHtml += "<tr align='center'>"
         + "<td class='Grid' nowrap>"+ Events[EvtNum]  + "- " + WkDate[DayNum] + "</td>"
         + "<td  class='Grid'>"
         + "<img src='CloseButton.bmp' onclick='javascript:hidetip2();' alt='Close'>"
         + "</td></tr>"
         + "<tr><td><span style='font-family:Arial; font-size:10px;'>"
         + EvtCmt[EvtNum]
         + "</span></td></tr>"
    eventHtml +="</table>"

    document.all.tooltip2.innerHTML=eventHtml
    document.all.tooltip2.style.pixelLeft=150
    document.all.tooltip2.style.pixelTop=document.documentElement.scrollTop+20
    document.all.tooltip2.style.visibility="visible"
}

function selEvtProp(EvtNum)
{
  var evtName = " ";
  var param = null;
  var evtTime = "&#160;&#160;Time: <input class='small' name='EvtTime'  maxlength=20 size=15>";
  var evtComment = " ";

  var eventHtml = "<table cellPadding='0' cellSpacing='0' width='100%'>"

  if (EvtNum == null)
  {
    eventHtml += "<tr align='center'>"
      + "<td class='Grid'>Select Event Name and Date</td>"
      + "<td  class='Grid'>"
      + "<img src='CloseButton.bmp' onclick='javascript:hidetip2();' alt='Close'>"
      + "</td></tr>"
     evtName = "<tr><td>Event: <input class='small' name='EvtName' size='15' maxlength='15' type='text'>"
      + evtTime;
      + "</tr></td>"
  }
  else
  {
    param = "&#34;" + EvtNum + "&#34;";
    eventHtml += "<tr align='center'>"
      + "<td class='Grid'>"+ Events[EvtNum] + " - Select Event Date</td>"
      + "<td  class='Grid'>"
      + "<img src='CloseButton.bmp' onclick='javascript:hidetip2();' alt='Close'>"
      + "</td></tr>"
      evtName = "<tr><td align='center'>" + evtTime + "</tr></td>"
  }


  evtComment ="<tr class='Grid1'><td colspan='2'>"
    + "<TextArea class='small' name='EvtDtl'  cols='50'>";
  evtComment += "</TextArea>"
    + "</td></tr>";

  eventHtml +=
      "<tr><td>Days:"
    + "<input name='DAY' type='radio' value='0' >Mon"
    + "<input name='DAY' type='radio' value='1' >Tue"
    + "<input name='DAY' type='radio' value='2' >Wed"
    + "<input name='DAY' type='radio' value='3' >Thu"
    + "<input name='DAY' type='radio' value='4' >Fri"
    + "<input name='DAY' type='radio' value='5' >Sat"
    + "<input name='DAY' type='radio' value='6' >Sun"
    + "</td></tr>"
    + evtName
    + evtComment
    + "<tr align='center'><td>"
    + "&nbsp;&nbsp;<button class='small' name='getEmp' onclick='getEvtDaySel("
    + param + ")'>Add</button>"
    + "&nbsp;&nbsp;<button class='small' name='close' onclick='hidetip2()'>Close</button><br>&nbsp;</td></tr>"
    + "</table>"

    eventHtml += "</table>"

    document.all.tooltip2.innerHTML=eventHtml
    document.all.tooltip2.style.pixelLeft=150
    document.all.tooltip2.style.pixelTop=document.documentElement.scrollTop+20
    document.all.tooltip2.style.visibility="visible"

    if (EvtNum != null)
    {
      document.all.DAY[EvtDay[EvtNum]].checked=true;
      document.all.EvtTime.value=EvtTime[EvtNum];
      document.all.EvtDtl.value=EvtCmt[EvtNum];
    }
}

// Set availability menu option for selected employee
function setAvail(emp, grp)
{
  var MenuAvl= " ";
  var Avl;

  if(grp == 'MNGR'){
    Avl = new Array(MgrAvail.length)
    Avl = MgrAvail;
  }
  if(grp == 'SLSP')  {
     Avl = new Array(SlsAvail.length)
     Avl = SlsAvail;
  }
  if(grp == 'SLBK')  {
     Avl = new Array(SBkAvail.length)
     Avl = SBkAvail;
  }
  if(grp == 'NSLSP') {
     Avl = new Array(NSlAvail.length)
     Avl = NSlAvail;
  }
  if(grp == 'NSLRC') {
     Avl = new Array(NRcAvail.length)
     Avl = NRcAvail;
  }
  if(grp == 'NSLBK') {
    Avl = new Array(NBkAvail.length)
    Avl = NBkAvail;
  }
  if(grp == 'NSLOT') {
     Avl = new Array(NOtAvail.length)
     Avl = NOtAvail;
  }
  if(grp == 'TRAIN') {
     Avl = new Array(TrnAvail.length)
     Avl = TrnAvail;
  }


  for(i = 0; i < Avl.length; i++)
  {
    if(Avl[i] == "A")
    {
      MenuAvl = "<tr><td colspan='2' class='Menu' align='center' "
           + "onclick='getAvail(&#34;" + emp + "&#34;, &#34;setEmpAvail&#34;); hideMenu();'>Availability"
           + "</td></tr>"
      break;
    }
  }
  return MenuAvl;
}

function getAvail(emp, func)
{
  var MyURL = 'GetAvail.jsp?EMPNUM=' + emp + "&FUNCTION=" + func;
  var MyWindowName = 'GetaAvail';
  var MyWindowOptions =
   'width=400,height=150, left=180,top=80, toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,resize=no,menubar=no';

  //alert(MyURL)
  window.open(MyURL, MyWindowName, MyWindowOptions);
}

// show employee availability
function setEmpAvail(emp, DayAvail, TimAvail)
{
   var AvailHtml = "<table cellPadding='0' cellSpacing='0' width='100%'>"
    + "<tr align='center'>"
    + "<td class='Grid' nowrap>" + emp + " - Availability</td>"
    + "<td  class='Grid'>"
    + "<img src='CloseButton.bmp' onclick='javascript:hidetip2();' alt='Close'>"
    + "</td></tr>"
    + "<tr><td colspan='2'>";

   var AvilTbl =  "<table class='DataTable' cellPadding='0' cellSpacing='0'"
   + " id='TbHrsEnt' width='100%'><tr>"
   for(i=0; i < 7; i++){
    AvilTbl += "<th class='EntTbl'>"
            + WkDays[i]
            + "</th>"
   }
   AvilTbl += "</tr><tr>"

   for(i=0; i < 7; i++){
     if(DayAvail[i]=="0")
     {
       AvilTbl += "<td class='EntTbl4'>&#160;&#160;&#160;&#160;&#160;</td>"
     }
     else if(DayAvail[i]=="1")
     {
       AvilTbl += "<td class='EntTbl2'>&#160;&#160;&#160;&#160;&#160;</td>"
     }
     else if(DayAvail[i]=="2")
     {
       AvilTbl += "<td class='EntTbl'  nowrap>" + TimAvail[i] + "</td>"
     }
   }
    AvilTbl += "</tr></table>"

    AvailHtml += AvilTbl + "</td></tr>"
    + "<tr align='center'><td>"
    + "<button class='small' name='close' onclick='hidetip2()'>Close</button></td></tr>"
    + "</table>"

    AvailHtml += "</table>"

    document.all.tooltip2.innerHTML=AvailHtml
    document.all.tooltip2.style.pixelLeft=150
    document.all.tooltip2.style.pixelTop=document.documentElement.scrollTop+50
    document.all.tooltip2.style.visibility="visible"
}

// get employee and days
function getEvtDaySel(EvtNum){
 selEvtDtl = new Array(7)
 if (EvtNum==null)
 {
   selectedEvent = document.all.EvtName.value;
 }
 else
 {
   selectedEvent = Events[EvtNum];
   selectedEvtNum = EvtNum;
 }

 for (i=0; i < 7 ; i++){
     if(document.all('DAY')[i].checked) {
       selEvtDay = i;
     }
   }
 selEvtTime = document.all.EvtTime.value;
 selEvtInf = document.all.EvtDtl.value

 // Save event, if no errors
 if (ValidateEvt()){
    submitEvt();
 }
}


// validate Employee Day Selection
function ValidateEvt()
{
  var msg = " ";
  var error = false;
  var nam = false;
  var dup = false;
  var rsv = false;
  var tim = false;
  var sel = false;

  // check Event name entered
  for(i=0; i < selectedEvent.length;i++)
  {
    if(selectedEvent.substring(i,i+1) > " ")   {  nam=true;  }
  }

  if (!nam)
  {
      msg = "Please enter event.\n";
      error = true;
  }

  // check, if Event name is not duplicated
  for(i=0; i < Events.length ; i++)
  {
    if(selectedEvent == Events[i]) { dup = true }
  }
  if (dup)
  {
      msg += "The event already exists.\n";
      error = true;
  }

  // check for reserved name
  if(selectedEvent == "ALL") { rsv = true }
  if (rsv)
  {
      msg += "Please,  rename event - ALL is reserved word.\n";
      error = true;
  }


  // check selected days
  for(i=0;i<7;i++)
  {
    if(selEvtDay >= 0)  sel=true;
  }

  if(!sel)
  {
      msg += "Please check at least one day. \n";
      error = true;
  }

  // check Event Name
  for(i=0; i < selEvtTime.length;i++)
  {
    if(selEvtTime.substring(i,i+1) > " ")   {  tim=true;  }
  }
  if (!tim)
  {
      msg += "Please enter event time.\n";
      error = true;
  }

  if(error) alert(msg);
  return error == false;
}

//========================================================================
// close drop menu
function hideMenu(){
  BegTime = null;
  EndTime = null;
  table = null;
  cells = null;

    document.all.menu.style.visibility="hidden"
}

//==============================================================================
// enter new hire position
//==============================================================================
function addNewHire(grp, grpname, subgrp, emp)
{
    var newEmpHtml = "<table cellPadding='0' cellSpacing='0' width=100%>"
    newEmpHtml += "<tr>"
           + "<td class='Grid' nowrap>New Hire Position</td>"
           + "<td  class='Grid2' >"
           + "<img src='CloseButton.bmp' onclick='javascript:hidetip2();' alt='Close'>"
           + "</td>"
         + "</tr>"
         + "<tr>"
           + "<td class='EntTbl5' >Employee Position:</td>"
           + "<td class='EntTbl5'><input name='Position' size=10 maxlength=10></td>"
         + "</tr>"
         + "<tr>"
           + "<td class='EntTbl5'><button class='small' name='Continue'"
              + " onclick='chgNewHire(&#34;" + grp + "&#34;, &#34;" + grpname + "&#34;, &#34;"
              + subgrp + "&#34;, &#34;" + emp + "&#34;)'>Continue</button>&nbsp;&nbsp;</td>"
           + "<td class='EntTbl5' colspan='2'><button class='small' name='close' onclick='hidetip2()'>Close</button></td>"
         + "</tr>"
         + "</table>";


    document.all.tooltip2.innerHTML=newEmpHtml
    document.all.tooltip2.style.pixelLeft=250
    document.all.tooltip2.style.pixelTop=document.documentElement.scrollTop+40
    document.all.tooltip2.style.visibility="visible"
}
//==============================================================================
// change new hire employee name by entered position
//==============================================================================
function chgNewHire(grp, grpname, subgrp, emp)
{
   var position = document.all.Position.value.trim()
   if (position != "") emp = emp.trim() + " - " + position;
   addNew(grp, grpname, subgrp, emp);
}
//==============================================================================
// show employee and day selection table
//==============================================================================
function addNew(grp, grpname, subgrp, emp){
 var param = '"' + grp + '", "' + grpname
 if(emp==null) param += '", null, null';
 else param += '", "' + emp + '", null';
 savArg=-1;

 var newEmpHtml = "<table cellPadding='0' cellSpacing='0'>"

    if(emp==null){
      newEmpHtml += "<tr align='center'>"
         + "<td class='Grid' nowrap>Select another employee as a " + grpname
    }
    else{
      newEmpHtml += "<tr align='center'>"
         + "<td class='Grid' nowrap>" + emp.substring(5)
         + " - " + grpname
    }

    if (subgrp!=null && subgrp!="null"){ newEmpHtml += ", " + subgrp }
    newEmpHtml += "</td>"


    newEmpHtml += "<td  class='Grid'>"
         + "<img src='CloseButton.bmp' onclick='javascript:hidetip2();' alt='Close'>"
         + "</td></tr>"

    newEmpHtml += "<tr><td></td><td></td></tr>"

    if(emp==null){
       newEmpHtml += "<tr align='center'><td nowrap>&nbsp;&nbsp;&nbsp;"
         + "<select name='SelEmp' onChange='checkAvail(null)'></select>"
         + "&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:openPromptWdw()'><font size='-2'>other store</font></a>"
         + "</td></tr>"
    }
    newEmpHtml += "<tr align='center'><td>"
    + "<table class='DataTable' cellPadding='0' cellSpacing='0' id='TbHrsEnt'>"
    + "<tr>"
    + "<td class='EntTbl' rowspan='2'>Days:</td>"
    + "<td class='EntTbl'><input name='DAY1' type='checkbox' value='0' ><br>&#160;Monday&#160;</td>"
    + "<td class='EntTbl'><input name='DAY2' type='checkbox' value='1' ><br>&#160;Tuesday&#160;</td>"
    + "<td class='EntTbl'><input name='DAY3' type='checkbox' value='2' ><br>&#160;Wednesday&#160;</td>"
    + "<td class='EntTbl'><input name='DAY4' type='checkbox' value='3' ><br>&#160;Thursday&#160;</td>"
    + "<td class='EntTbl'><input name='DAY5' type='checkbox' value='4' ><br>&#160;Friday&#160;</td>"
    + "<td class='EntTbl'><input name='DAY6' type='checkbox' value='5' ><br>&#160;Saturday&#160;</td>"
    + "<td class='EntTbl'><input name='DAY7' type='checkbox' value='6' ><br>&#160;Sunday&#160;</td>"
    + "</tr>"
    + "<tr>"
    + "<td class='EntTbl' nowrap><div id='Avl1'></div></td>"
    + "<td class='EntTbl' nowrap><div id='Avl2'></div></td>"
    + "<td class='EntTbl' nowrap><div id='Avl3'></div></td>"
    + "<td class='EntTbl' nowrap><div id='Avl4'></div></td>"
    + "<td class='EntTbl' nowrap><div id='Avl5'></div></td>"
    + "<td class='EntTbl' nowrap><div id='Avl6'></div></td>"
    + "<td class='EntTbl' nowrap><div id='Avl7'></div></td>"
    + "</tr>"
    + "</table>"
    + "</td></tr>"
    + "<tr align='center'><td>"
    + "&nbsp;&nbsp;<button class='small' name='getEmp' onclick='getEmpDaySel(" + param + ", false, false)'>Continue</button>"
    + "&nbsp;&nbsp;<button class='small' name='chkDays' onclick='chgAlldays(true)'>All Days</button>"
    + "&nbsp;&nbsp;<button class='small' name='chkDays' onclick='chgAlldays(false)'>Reset</button>"
    + "&nbsp;&nbsp;<button class='small' name='close' onclick='hidetip2()'>Close</button><br>&nbsp;</td></tr>"
    + "</table>"

    document.all.tooltip2.innerHTML=newEmpHtml
    document.all.tooltip2.style.pixelLeft=150
    document.all.tooltip2.style.pixelTop=document.documentElement.scrollTop+20
    document.all.tooltip2.style.visibility="visible"

    loadSelEmp(grp, emp);
    if(emp!=null && emp.substring(5, 13) != "New Hire") { checkAvail(emp); }

}

function checkAvail(emp)
{
  var selIdx = -1;
  var selEmp

  // preselected employee
  if(emp==null)
  {
    selIdx = document.all.SelEmp.selectedIndex;
    selEmp = document.all.SelEmp.options[selIdx].value
  }
  else
  {
    selEmp = emp.substring(0, 4);
    for(i=0; i < EmpNum.length; i++)
    {
       if(EmpNum[i] == selEmp) { selIdx = i; break;}
    }
  }

   if(selIdx == -1) getAvail(selEmp, "setSelEmpAvl");
   else if(EmpName.length > selIdx)
   {
     if(DayAvail[selIdx]=='A')
     {
       getAvail(EmpNum[selIdx] , "setSelEmpAvl");
     }
     else
     {
       setAllAval();
     }
   }
}

// set color to green - all available
function setAllAval()
{
  var avl = [document.all.Avl1, document.all.Avl2, document.all.Avl3, document.all.Avl4,
             document.all.Avl5, document.all.Avl6, document.all.Avl7];
  for(i=0; i<7; i++)
  {
    avl[i].innerHTML= "&#160;";
    avl[i].style.background="green";
    avl[i].style.visibility="visible";
  }
}

// show employee availability
function setSelEmpAvl(emp, DayAvail, TimAvail)
{
  var avl = [document.all.Avl1, document.all.Avl2, document.all.Avl3, document.all.Avl4,
             document.all.Avl5, document.all.Avl6, document.all.Avl7];
  selDayAvl = DayAvail;
  selTimAvl = TimAvail;
  for(i=0; i<7; i++)
  {
    avl[i].innerHTML=" ";
    if(selDayAvl[i]=="0") avl[i].style.background="green";
    else if(selDayAvl[i]=="1") avl[i].style.background="red";
    else if(selDayAvl[i]=="2")
    {
      avl[i].style.background="#FFE4C4";
      avl[i].innerHTML=selTimAvl[i];
    }
  }

}

// Open prompt window
function openPromptWdw() {
  var fileType = "RCI";
  if(WeekEnd.substring(6, 10) == "2099") {fileType = "BASE";}

  var MyURL = 'SelectEmployee.jsp?EMPNUM=SelEmp&TYPE=SELECT&FILETYPE='
          + fileType + "&STORE=" + CurStore;
  var MyWindowName = 'Test01';
  var MyWindowOptions =
   'width=600,height=400, toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,resize=no,menubar=no';

  //alert(MyURL)
  window.open(MyURL, MyWindowName, MyWindowOptions);
}


// show employee and day selection table
function selectWeekEnd(type, emp, grp, range){
 var weHtml = "<table cellPadding='0' cellSpacing='0'>"
    + "<tr align='right'>"
    + "<td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"

    if(type=='DAY') weHtml += "<b>Go To</b></td>";
    else            weHtml += "<b>Copy Selection To</b></td>";

    weHtml += "<td align=right valign=top>"
    + "<img src='CloseButton.bmp' onclick='javascript:hidetip2();' alt='Close'>"
    + "</td></tr>"
    + "<tr align='center'><td nowrap>&nbsp;&nbsp;Week Ending Date: </td>"
    +  "<td align=right valign=top>"
    + "<select name='newDate'>";
 for(i=0; i< 11 ;i++)
 {
   weHtml += "<option value='" + Weeks[i] + "'>"
          + Weeks[i] + "</options>"
 }

 for(i=0; i < BaseWk.length ;i++)
 {
   weHtml += "<option value='" + BaseWk[i] + "'>"
          + BsWkName[i] + "</options>"
 }

 weHtml += "</select>&nbsp;&nbsp;"
    +  "</td></tr>"
    +  "<tr align='center'><td colspan=2>"
 // show another weekending day
 if(type=='DAY')
 {
    weHtml += "<button name='newDay' onclick='chgSelDate()'>Submit</button>"
 }
 // select weekending day to copy selected entity
 else
 {
    weHtml += "<button name='newDay' onclick='copyToSelDate(&#34;"
               + emp + "&#34;, &#34;" + grp + "&#34;, &#34;"
               + range + "&#34;)'>Copy</button>"
 }
weHtml += "&nbsp;&nbsp;<button name='close' onclick='hidetip2()'>Close</button><br>&nbsp;"
if(type!='DAY')
{
  weHtml += "<br><font size='-1' color='red'>**This copy feature will NOT overwrite an employee's already existing scheduled day for this future week."
}
   weHtml +="</font></td></tr></table>"

    document.all.tooltip2.innerHTML=weHtml
    document.all.tooltip2.style.pixelLeft=screen.width/2 - 100
    document.all.tooltip2.style.pixelTop=document.documentElement.scrollTop+20
    document.all.tooltip2.style.visibility="visible"

    document.all.newDate.selectedIndex=6;
}

function selectNewGrp(emp, grp)
{
 var MoveHtml = "<table cellPadding='0' cellSpacing='0'>"
    + "<tr align='right'>"
    + "<td class='Grid' nowrap>"+ emp + " - " + grp + "</td>"
    + "<td class='Grid'>"
    + "<img src='CloseButton.bmp' onclick='javascript:hidetip2();' alt='Close'>"
    + "</td></tr>"
    + "<tr class='Grid1'></tr>"
    + "<tr class='Grid1'><td nowrap>&nbsp;Move To group:&nbsp;"
    + "<select name='newGroup'>"
    +   "<option value='MNGR'>Managers</option>"
    +   "<option value='SLSP'>Regular Sales</option>"
    +   "<option value='SLBK'>Bike sales</option>"
    +   "<option value='NSLSP'>Cashiers</option>"
    +   "<option value='NSLRC'>Receiving</option>"
    +   "<option value='NSLBK'>Bike Shop</option>"
    +   "<option value='NSLOT'>Others</option>"
    +   "<option value='TRAIN'>Training</option>"
    + "</select>"
    + "</td></tr>"
    + "<tr class='Grid1'></tr>"
    + "<tr class='Grid1'>"
    + "<td><button class='small' name='Move' onclick='moveEmp(&#34;"
    + emp + "&#34;, &#34;" + grp + "&#34;);hidetip2();'>Move</button>"
    + "</td></tr>"
    + "<tr class='Grid1'></tr>"
    + "</table>"

  document.all.tooltip2.innerHTML=MoveHtml
  document.all.tooltip2.style.pixelLeft=screen.width/2 - 100
  document.all.tooltip2.style.pixelTop=document.documentElement.scrollTop+20
  document.all.newGroup.style.fontSize="10";
  document.all.tooltip2.style.visibility="visible"
}


// check all day as selected for input
function chgAlldays(check)
{ document.all('DAY1').checked=check; document.all('DAY2').checked=check
  document.all('DAY3').checked=check; document.all('DAY4').checked=check
  document.all('DAY5').checked=check; document.all('DAY6').checked=check;
  document.all('DAY7').checked=check;
}

// get employee and days
function getEmpDaySel(grp, grpname, emp, day){
 if (emp==null && day==null)
 {
   selectedEmployee = document.all.SelEmp.options[document.all.SelEmp.selectedIndex].value

   if(EmpName.length > document.all.SelEmp.selectedIndex)
   {
      selectedEmployee += " " + EmpName[document.all.SelEmp.selectedIndex];
      selectedTimOffType = TimeOffType[document.all.SelEmp.selectedIndex];
   }
   else
   {
      selectedEmployee += " " + document.all.SelEmp.options[document.all.SelEmp.selectedIndex].text
      selectedTimOffType = "RQOFF";
   }

   SelDays = [document.all('DAY1').checked, document.all('DAY2').checked,
              document.all('DAY3').checked, document.all('DAY4').checked,
              document.all('DAY5').checked, document.all('DAY6').checked,
              document.all('DAY7').checked]
 }
 else if (emp!=null && day==null)
 {
   selectedEmployee = emp;
   SelDays = [document.all('DAY1').checked, document.all('DAY2').checked,
              document.all('DAY3').checked, document.all('DAY4').checked,
              document.all('DAY5').checked, document.all('DAY6').checked,
              document.all('DAY7').checked]
 }
 else
 {
   hideMenu();
   selectedEmployee = emp;
   SelDays = new Array(7)
   for(i=0;i<7;i++){
     if (WkDate[i]==day){ SelDays[i] = true; }
     else { SelDays[i] = false; }
   }
 }

 if(isEmpDaySelValid()) {
   selectedGrp = grp
   selectedGrpName = grpname
   for(i=0;i<7;i++)
   {
     if (SelDays[i]==true)
     {
        SelDays[i]=false;
        showTimeEntry(grp, grpname, WkDate[i], WkDays[i]);
        break;
     }
   }
 }
}

// validate Employee Day Selection
function isEmpDaySelValid()
{
  var msg = '';
  var error = false;

  // check Employee Name or Number
  if (selectedEmployee <= " " || selectedEmployee.substring(0,8) == "RESERVED")
  {
      msg = "Please select employee. \n";
      error = true;
  }
  var sel = false;
  for(i=0;i<7;i++)
  {
    if(SelDays[i] == true)  sel=true;
  }



  // Check selected day
  if(!sel)
  {
      msg += "Please check at least one day. \n";
      error = true;
  }

  if(error) alert(msg);
  return error == false;
}


// add time for selected employee and date
function showTimeEntry(grp, grpname, day, dayofWeek){
 var empOnSchd = isEmpOnSched(day);

 var entryTimeHtml = "<form name='HRSENTRY' method='GET' >"
    + "<table width='100%' cellPadding='0' cellSpacing='0'>"
    + "<tr><td class='Grid'>&nbsp;&nbsp;&nbsp;</td>"
    + "<td class='Grid' colspan='4'>" + selectedEmployee.substring(5)
    + " - " + grpname
    + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + dayofWeek + ", " + day
    + "</td>"
    +  "<td class='Grid' align=right valign=top>"
    +  "<img src='CloseButton.bmp' onclick='javascript:hidetip2();' alt='Close'>"
    + "</td></tr>"
    + "<tr class='Grid1'></tr>"
    + "<tr class='Grid1'><td>&nbsp;</td>"
    + "<td colspan='4'>"
    + "<table class='DataTable' cellPadding='0' cellSpacing='0' id='TbHrsEnt'>"
    + "<tr><td class='EntTbl' colspan='<%=sHrs.length * sMin.length-2%>' nowrap>"
    + "Hours Entry - click on white cells to select a time, to change - click on reset button"
    + "</td></tr>"
    + "<tr>"
    + "<td class='EntTbl' rowspan='2'><button class='small' name='ResetEntry' type='button' DISABLED onclick='resetHrs();'>Reset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button></td>"
      <%for(int i=0; i < sHrs.length;i++){
             if(i == sHrs.length-1) {%>
              + "<td class='EntTbl'><%=sHrsTxt[i]%></td>"
      <%}
             else {%>
              + "<td class='EntTbl' colspan='<%=sMin.length%>'><%=sHrsTxt[i]%></td>"
           <%}%>
         <%}%>
     + "</tr>"
     + "<tr >"
         <%for(int i=0, k=0; i < (sHrs.length * sMin.length-3); i++, k++){
             if(k >= sMin.length) k=0; %>
           + "<td class='EntTbl3'><%=sMin[k]%></td>"
         <%}%>
      +  "</tr>"
      +  "<tr>"
      + "<td class='EntTbl'>"
      + "<button class='small' name='Regular'"
      + " onclick='if (Validate(document.HRSENTRY, &#34;" + day+"&#34;)){ savSingleDay(&#34;"
      + day+"&#34;,false, &#34;REG&#34;);}'>Regular&nbsp;&nbsp;</button>"
      + "</td>"

       <% for(int i=0; i < sHrs.length; i++){ %>
         <% for(int k=0; k < sMin.length; k++){%>
      +  "<td class='EntTbl1' id='<%=sHrs[i]%><%=sMin[k]%>' onclick='enterTime(this);'>&nbsp;</td>"
             <%if(i == sHrs.length-1) break;
            }%>
        <%}%>
      + "</tr>"

      + "<tr><td class='EntTbl'>&nbsp;</td>"
      + "<td class='EntTbl' colspan='9'>Beginning at:&nbsp;&nbsp;</td> "
      + "<td class='EntTbl' colspan='8'><div class='shwTime' id='dvBegTime' >&nbsp;</div></td>"
      + "<td class='EntTbl' colspan='9'>Ending at:&nbsp;&nbsp;</td>"
      + "<td class='EntTbl' colspan='9'><div class='shwTime' id='dvEndTime'>&nbsp;</div></td>"
      + "</tr>";

      if(selectedTimOffType != "RQOFF" && selectedEmployee.substring(5, 13) != "New Hire")
      {
        entryTimeHtml += "<tr>"
          + "<td class='EntTbl'>"
          + "<button class='small' name='Vacation' "
          + "onclick='enterOutTime(&#34;VAC&#34;);"
          + "if (Validate(document.HRSENTRY, &#34;" + day+"&#34;)){"
          + "savSingleDay(&#34;" + day+"&#34;,false, &#34;VAC&#34;);}'>"
          + "Vacation</button>"
          + "</td>"
          + "<td class='EntTbl' id='VAC4HRS' colspan='17'>"
          + "<input name='VACHRS' type='radio' value='4H' onclick='chgBtnSts(&#34;VAC&#34;)'>1/2 of day"
          + "</td>"
          + "<td class='EntTbl' id='VAC8HRS' colspan='18'>"
          + "<input name='VACHRS' type='radio' value='8H' checked onclick='chgBtnSts(&#34;VAC&#34;)'>Whole day"
          + "</td>"
          + "</tr>"

          + "<tr><td class='EntTbl' colspan='36'>&nbsp;</td></tr>"

          +  "<tr>"
          + "<td class='EntTbl'>"
          + "<button class='small' name='Holiday' "
          + "onclick='enterOutTime(&#34;HOL&#34;);"
          + "if (Validate(document.HRSENTRY, &#34;" + day+"&#34;)){"
          + "savSingleDay(&#34;" + day+"&#34;,false, &#34;HOL&#34;);}'>"
          + "Holiday&nbsp;&nbsp;</button>"
          + "</td>"
          + "<td class='EntTbl' id='HOL4HRS' colspan='17'>"
          + "<input name='HOLHRS' type='radio' value='4H' onclick='chgBtnSts(&#34;HOL&#34;)'>1/2 of day"
          + "</td>"
          + "<td class='EntTbl' id='HOL8HRS' colspan='18'>"
          + "<input name='HOLHRS' type='radio' value='8H' checked onclick='chgBtnSts(&#34;HOL&#34;)'>Whole day"
          + "</td>"
          + "</tr>";
      }

      entryTimeHtml += "<tr>"
      + "<td class='EntTbl'>"
      + "<button class='small' name='ReqOff' "
      + "onclick='enterOutTime(&#34;VAC&#34;);"
      + "if (Validate(document.HRSENTRY, &#34;" + day+"&#34;)){"
      + "savSingleDay(&#34;" + day+"&#34;,false, &#34;OFF&#34;);}'>"
      + "Request Off</button>"
      + "</td>"
      + "<td class='EntTbl' colspan='35'>"
      + "</td>"
      + "</table>"

      + "</td></tr>"
      + "<tr  class='Grid1'>"
      + "<td>&nbsp;</td><td colspan='4'>"
      + "<button class='small' name='close' onclick='hidetip2()'>Close</button>"
      + "&nbsp;&nbsp;<button class='small' name='close' onclick='savSingleDay(&#34;"+ day+"&#34;,true, "
      + false + ", " + false + ")'>Skip</button>"

  if (empOnSchd)
  {
     entryTimeHtml += "&nbsp;&nbsp;<input name='Override' type='checkbox' value='OVR'>"
      + "Override"
  }
  entryTimeHtml += "<input name='ApplyToAll' type='checkbox' value='APPLY'>"
      + "Apply to all days"
      + "</td></tr>"
      + "</table>"
      + "</form>"

    document.all.tooltip2.innerHTML=entryTimeHtml
    document.all.tooltip2.style.pixelLeft=screen.width/2-450
    document.all.tooltip2.style.pixelTop=document.documentElement.scrollTop+100
    document.all.tooltip2.style.visibility="visible"
}
//==============================================================================
// save single day time entry, show next selected day
//==============================================================================
function savSingleDay(day, skip, TimeType){
  var found = false
  var apply = false;
  if (!skip)
  {
    savArg++;
    savDate[savArg] = day;
    savBegTim[savArg] = BegTime.substring(0,2) + ":" + BegTime.substring(2,4);
    savEndTim[savArg] = EndTime.substring(0,2) + ":" + EndTime.substring(2,4);
    selectedHrsType[savArg] = TimeType;

    // apply time for all selected days
    apply = document.all.ApplyToAll.checked;
     if(apply){
      for(i=0;i<7;i++){
        if (SelDays[i]==true){
            savArg++;
            savDate[savArg] = WkDate[i];
            savBegTim[savArg] = BegTime.substring(0,2) + ":" + BegTime.substring(2,4);
            savEndTim[savArg] = EndTime.substring(0,2) + ":" + EndTime.substring(2,4);
            selectedHrsType[savArg] = TimeType;
            SelDays[i]=false;
        }
      }
    }
  }

  // show next selected day
  BegTime = null;
  EndTime = null;
  table = null;
  cells = null;



  for(i=0;i<7;i++){
    if (SelDays[i]==true){
        SelDays[i]=false;
        showTimeEntry(selectedGrp, selectedGrpName, WkDate[i], WkDays[i]);
        found = true;
        break;
    }
  }

  // submit hours entry requirements after schedule entered for all selected dates

  if (!found && savArg >=0){ submit(); }
  else if (!found) hidetip2();
}

//==============================================================================
// show Emp by Hrs
//==============================================================================
function dspEmpbyHr(obj, day, dayOfWeek)
{
  var Day = obj.id.substring(3,4);
  var curLeft = 0;
  var curTop =0;
  var hrs = ["07am", "08am", "09am", "10am", "11am", "12pm", "01pm", "02pm", "03pm", "04pm", "05pm", "06pm", "07pm", "08pm", "09pm", "10pm", "11pm", "12am"];

  var MgrNum = MgrByHrs[Day];
  var SlsNum = SlsByHrs[Day];
  var NSlNum = NSlByHrs[Day];
  var TotNum = TotByHrs[Day];

  var empHrHtml = "<table width='100%' cellPadding='0' cellSpacing='0'>"
    +  "<tr>"
    + "<td class='Grid'>" + dayOfWeek + ", " + day + "</td>"
    + "<td class='Grid' align=right valign=top>"
    +  "<img src='CloseButton.bmp' onclick='javascript:hidetip2();' alt='Close'>"
    + "</td></tr>"

    + "<tr><td colspan='2'>"
    + "<table class='DataTable' cellPadding='0' cellSpacing='0'"
    + "width='100%'>"
    + "<tr>"
    + "<th class='EntTbl'>Hours</td>"
    + "<th class='EntTbl'>M</td><th class='EntTbl'>S</td>"
    + "<th class='EntTbl'>N</td><th class='EntTbl'>T</td>"
    + "</tr>";

  var cnt = 0;
  for(i=0; i < 18; i++)
  {
      empHrHtml +="<tr>"
      + "<td class='EntTbl'>" + hrs[i] + "</td>"
      + "<td class='EntTbl'>" + MgrNum[i] + "</td>"
      + "<td class='EntTbl'>" + SlsNum[i] + "</td>"
      + "<td class='EntTbl'>" + NSlNum[i] + "</td>"
      + "<td class='EntTbl'>" + TotNum[i] + "</td>"
      + "</tr>"
   }

  empHrHtml += "</table>"
    + "</td></tr>"
    + "</table>"

   if (obj.offsetParent) {
    while (obj.offsetParent){
      curLeft += obj.offsetLeft
      curTop += obj.offsetTop
      obj = obj.offsetParent;
    }
   }

  document.all.tooltip2.innerHTML=empHrHtml
  document.all.tooltip2.style.pixelLeft=curLeft - 150
  document.all.tooltip2.style.pixelTop=document.documentElement.scrollTop+10
  document.all.tooltip2.style.visibility="visible"
}


// display group by hour
function dspGrpbyHr(grp)
{
  var curLeft = document.documentElement.scrollLeft+ 100;
  var curTop = 20;
  var hrs = ["07am", "08am", "09am", "10am", "11am", "12pm", "01pm", "02pm", "03pm", "04pm", "05pm", "06pm", "07pm", "08pm", "09pm", "10pm", "11pm", "12am"];
  var grpname;
  if(grp=='MNGR') grpname = 'Managers'
  if(grp=='SLSP') grpname = 'Selling Personnel'
  if(grp=='NSLSP') grpname = 'Non-Selling Personnel'
  if(grp=='TRAIN') grpname = 'Training'
  if(grp=='TOTAL') grpname = 'Totals'

  var empHrHtml = "<table width='100%' cellPadding='0' cellSpacing='0'>"
    +  "<tr>"
    + "<td class='Grid' nowrap>Weekening: " + WeekEnd + " - " + grpname
    + "</td>"
    + "<td class='Grid2' >"
    +  "<img src='CloseButton.bmp' onclick='javascript:hidetip2();' alt='Close'>"
    + "</td></tr>"

    + "<tr><td colspan='2'>"
    + "<table class='DataTable' cellPadding='0' cellSpacing='0'"
    + "width='100%'>"
    + "<tr>"
    + "<th class='EntTbl' rowspan='2'>Hours</th>"
    for(i=0;i<7;i++)
    {
      empHrHtml += "<th class='EntTbl'>" + WkDate[i].substring(0,5) + "</th>"
    }
    empHrHtml += "</tr><tr>"

    for(i=0;i<7;i++)
    {
      if (grp=="MNGR") empHrHtml += "<th class='EntTbl'>" + WkDays[i] + "</th>"
    }
    + "</tr>";

  var cnt = 0;
  for(i=0; i < 18; i++)
  {
      empHrHtml +="<tr>"
        + "<td class='EntTbl'>" + hrs[i] + "</td>"
      for(j=0; j < 7; j++)
      {
         if(grp=='MNGR') empHrHtml += "<td class='EntTbl'>" + MgrByHrs[j][i] + "</td>"
         if(grp=='SLSP') empHrHtml += "<td class='EntTbl'>" + SlsByHrs[j][i] + "</td>"
         if(grp=='NSLSP') empHrHtml += "<td class='EntTbl'>" + NSlByHrs[j][i] + "</td>"
         if(grp=='TOTAL') empHrHtml += "<td class='EntTbl'>" + TotByHrs[j][i] + "</td>"

     }
     empHrHtml +="</tr>"
   }

  empHrHtml += "</table>"
    + "</td></tr>"
    + "</table>"

  document.all.tooltip2.innerHTML=empHrHtml
  document.all.tooltip2.style.pixelLeft=curLeft
  document.all.tooltip2.style.pixelTop=document.documentElement.scrollTop+10
  document.all.tooltip2.style.visibility="visible"
}

// close employee selection window
function hidetip2(){
    document.all.tooltip2.style.visibility="hidden"
}

// load employee list in selection field
function  loadSelEmp(grp, emp){
 // Change Department name same as in FSYUDCI file
 if(grp == "MNGR") grp = "MGMT";
 else if(grp == "SLSP") grp = "SELL";
 else if(grp == "NSLSP") grp = "NONS";
 else if(grp == "TRAIN") grp = "NONS";
 var j = 0;

  if(emp == null)
  {
   // clear select employee field
   for(var i=0; i < EmpNum.length;i++){
     document.all.SelEmp.options[i] = null;
   }

   // load employee for selected employee type
   for(var i=0; i < EmpNum.length;i++){
      document.all.SelEmp.options[j] = new Option(EmpName[i] + " / " + DptName[i] , EmpNum[i]);
      j++;
   }
   document.all.SelEmp.options[EmpNum.length] = new Option("Reserved for another store selection", "RESERVED");
   document.all.SelEmp.options[EmpNum.length].style.color="Red";
   document.all.SelEmp.style.fontSize="10";
 }
}

 // save entered regular time
function enterTime(cur){
 var id = cur.id;
 document.forms[0].ResetEntry.disabled = false;
 document.forms[0].Regular.disabled = false;
 if (document.forms[0].Vacation!=null) document.forms[0].Vacation.disabled = true;
 if (document.forms[0].Holiday!=null) document.forms[0].Holiday.disabled = true;
 document.forms[0].ReqOff.disabled = true;
 if (BegTime != null && EndTime != null){
  return; // do not allow to enter more then 2 cells
 }
 if(cur.className=="EntTbl1") {
    cur.className="EntTbl2"
    if (BegTime == null)
    {
        BegTime = cur.id;
    }
    else if(BegTime != cur.id ) {EndTime = cur.id; }
 }

 // initialized table and cells variables
 if(table == null){
    table = document.getElementById("TbHrsEnt");
    cells = table.getElementsByTagName("td");
  }

 // change color for all cells includeed in working time
 if (BegTime != null && EndTime != null){
  var found = false;
  // fix error when in time greater than hout time
  if (BegTime > EndTime){
      var saveTime = BegTime;
      BegTime = EndTime;
      EndTime = saveTime;
  }

  for(var i=0; i < cells.length; i++){
    if (cells.item(i).id == BegTime){  found = true; }
    if (found){ cells.item(i).className="EntTbl2"; }
    if (cells.item(i).id == EndTime){ found = false; }
  }
 }
 popupWorkHours(cur);
}

// Update readonly field that show selected times
function popupWorkHours(cur){
  if (BegTime != null){
    var hrs  = BegTime.substring(0,2)
    var type = " AM"
    if (hrs > "12" && hrs < "24") {
        hrs = hrs - 12;
        type = " PM"
    }
    else if (hrs == "12") {
        hrs = 12;
        type = " PM"
    }
    else if (hrs == "24") {
        hrs = 12;
        type = " AM"
    }
    var min = BegTime.substring(2,4);
    document.all.dvBegTime.innerHTML= hrs + ":" + min + type
    document.all.dvBegTime.style.visibility="visible"
  }

  if (EndTime != null){
    var hrs  = EndTime.substring(0,2)
    var type = " AM"
    if (hrs > "12" && hrs < "24") {
        hrs = hrs - 12;
        type = " PM"
    }
    else if (hrs == "12") {
        hrs = 12;
        type = " PM"
    }
    else if (hrs == "24") {
        hrs = 12;
        type = " AM"
    }
    var min = EndTime.substring(2,4);
    document.all.dvEndTime.innerHTML= hrs + ":" + min + type
    document.all.dvEndTime.style.visibility="visible"

  }
}

// save entered vacation/holiday/request off time
function enterOutTime(TimeType)
{
// do not entered time for for employee that is not eligible for vac/hol
  if (selectedTimOffType == 'RQOFF') TimeType='OFF'

  if(TimeType=="VAC" || TimeType=="HOL")
  {
    if(document.HRSENTRY.VACHRS[0].checked)
    {
      if (selectedTimOffType == '40HRS')
      {
        BegTime = "0800";
        EndTime = "1200";
      }
      else
      { // 3hrs for 30hrs/wk employee vac/hol
        BegTime = "0800";
        EndTime = "1100";
      }
    }
    else
    {
      if (selectedTimOffType == '40HRS')
      {
        BegTime = "0800";
        EndTime = "1600";
      }
      else
      { //6hrs for 30hrs/wk employee vac/hol
        BegTime = "0800";
        EndTime = "1400";
      }
    }
  }
  else
  {
    BegTime = "0800";
    EndTime = "0900";
  }
}


// reset hours by resetentry button
function resetHrs(){
 if(cells!=null){
   for(var i=0; i < cells.length; i++){
     if (cells.item(i).id >= "0700" && cells.item(i).id <= "2400")
     cells.item(i).className="EntTbl1";
   }
 }

 BegTime = null;
 EndTime = null;
 table = null;
 cells = null;

 document.forms[0].ResetEntry.disabled = true;
 document.forms[0].Regular.disabled = false;

 if(document.forms[0].Vacation != null) document.forms[0].Vacation.disabled = false;
 if(document.forms[0].Holiday != null) document.forms[0].Holiday.disabled = false;
 document.forms[0].ReqOff.disabled = false;

 document.all.dvBegTime.innerHTML= null;
 document.all.dvBegTime.style.visibility="hidden"
 document.all.dvEndTime.innerHTML= null;
 document.all.dvEndTime.style.visibility="hidden"
}

//change vac, hol button status when radio button was clicked clicked
function chgBtnSts(TimeType)
{
  resetHrs();
  if (TimeType=="VAC")
  {
    document.forms[0].ResetEntry.disabled = false;
    if(document.forms[0].Vacation != null) document.forms[0].Vacation.disabled = false;
    if(document.forms[0].Holiday != null) document.forms[0].Holiday.disabled = true;
    document.forms[0].Regular.disabled = true;
    document.forms[0].ReqOff.disabled = true;
  }
  else if (TimeType=="HOL")
  {
    document.forms[0].ResetEntry.disabled = false;
    if(document.forms[0].Vacation != null) document.forms[0].Vacation.disabled = true;
    if(document.forms[0].Holiday != null) document.forms[0].Holiday.disabled = false;
    document.forms[0].Regular.disabled = true;
    document.forms[0].ReqOff.disabled = true;
  }
}

// Validate form entry values
function Validate(docFrm, day){
  var selEmpNum = selectedEmployee.substring(0,4);
  var selEmpName = selectedEmployee.substring(5);
  var msg = '';
  var error = false;
  var dayArg = 0;
  var ovr="CHK";
  if (docFrm.Override!=null && docFrm.Override.checked)
  {
    ovr="OVR";
  }

  // check Employee Name or Number
  if (selectedEmployee <= " ") {
      msg = "Please enter employee name or(and) number. \n";
  }

  // check if employee hours already exists in the schedule
  if (ovr=='CHK' && isEmpOnSched(day)){
      msg += "Selected employee already scheduled for this day. \n";
  }

  if (BegTime <= " ") { msg += "Please enter beginning time. \n"; }
  // check Employee Ending Time
  if (EndTime <= " ") { msg += "Please enter ending time. \n";  }

  // show error messages
  if (msg != ''){
      error = true;
      alert(msg);
  }
  return error == false;
}
//==============================================================================
// check, if employee entry already in schedule
//==============================================================================
function isEmpOnSched(day)
{
  var empday = new Array();
  for(i=0; i < 7 ; i++)
  {
    if (day == WkDate[i])
    {
      dayArg=i; break;
    }
  }

  if (  dayArg == 0) empday = EmpDay1;
  if (  dayArg == 1) empday = EmpDay2;
  if (  dayArg == 2) empday = EmpDay3;
  if (  dayArg == 3) empday = EmpDay4;
  if (  dayArg == 4) empday = EmpDay5;
  if (  dayArg == 5) empday = EmpDay6;
  if (  dayArg == 6) empday = EmpDay7;
  var alreadysched = false;

  for(i=0; i<empday.length; i++){
     if (empday[i].substring(0, selectedEmployee.length) == selectedEmployee)
     {
       alreadysched = true;
       break;
     }
  }
  return alreadysched
}
//==============================================================================
// save entered time
//==============================================================================
function submit(){
  var selEmpNum = selectedEmployee.substring(0,4)
  var selEmpName = selectedEmployee.substring(5);
  hidetip2();

  // change action string
  SbmString = "SavHrsEnt.jsp?STORE=" + CurStore
                + "&STRNAME=" + CurStrName
                + "&MONBEG=" + Month
                + "&WEEKEND=" + WeekEnd
                + "&GRP=" + selectedGrp
                + "&EMPNUM=" + selEmpNum
                + "&EMPNAME=" + selEmpName
                + "&ACTION=ADD"
                + "&FROM=" + From
                + "&POS=ENTRY"
                + "&SCHTYP=" + "<%=sSchTyp%>"
                + "&SHWGOAL=" + "<%=sShwGoal%>"
                + "&DOC=WEEK";

for (i=0;i<=savArg;i++){
    SbmString = SbmString + "&WKDATE" + i + "=" + savDate[i]
              + "&BEGTIME" + i + "=" + savBegTim[i]
              + "&ENDTIME" + i + "=" + savEndTim[i]
              + "&HRSTYP" + i + "=" + selectedHrsType[i];
}
  //alert(SbmString)
  if (Allow=="YES") window.location.href = SbmString;
  else alert("This week has the APPROVED status. Changes is not allowed");
}


// delete employee schedule
function dltEntry(emp, grp, day, range){
if(day==null) day=WeekEnd
if(range==null) range=" "
  SbmString = "SavHrsEnt.jsp?STORE=" + CurStore
                + "&STRNAME=" + CurStrName
                + "&MONBEG=" + Month
                + "&WEEKEND=" + WeekEnd
                + "&GRP=" + grp
                + "&EMPNUM=" + emp.substring(0, 4)
                + "&EMPNAME=" + emp.substring(5)
                + "&ACTION=DLT"
                + "&ACTRANGE=" + range
                + "&FROM=" + From
                + "&POS=LIST"
                + "&SCHTYP=" + "<%=sSchTyp%>"
                + "&SHWGOAL=" + "<%=sShwGoal%>"
                + "&DOC=WEEK"
                + "&WKDATE0=" + day
                + "&BEGTIME0=00:00"
                + "&ENDTIME0=00:00"
                + "&HRSTYP0=ALL";
  //alert(SbmString);
  if (Allow=="YES") window.location.href = SbmString;
  else alert("This week has the APPROVED status. Changes is not allowed!");
}

// copy Employee day Selection
function copyToSelDate(emp, grp, range)
{
 var selIdx = document.all.newDate.options.selectedIndex;
 var toWeekEnd = document.all.newDate.options[selIdx].value
 SbmString = "SavHrsEnt.jsp?STORE=" + CurStore
                + "&STRNAME=" + CurStrName
                + "&MONBEG=" + Month
                + "&WEEKEND=" + WeekEnd
                + "&GRP=" + grp
                + "&EMPNUM=" + emp.substring(0, 4)
                + "&EMPNAME=" + emp.substring(5)
                + "&ACTION=CPY"
                + "&WKDATE0=" + toWeekEnd
                + "&ACTRANGE=" + range
                + "&FROM=" + From
                + "&POS=LIST"
                + "&SCHTYP=<%=sSchTyp%>"
                + "&SHWGOAL=<%=sShwGoal%>"
                + "&DOC=WEEK"
                + "&BEGTIME0=00:00"
                + "&ENDTIME0=00:00"
                + "&HRSTYP0=ALL";
  //alert(SbmString);
  window.location.href=SbmString;
}


function moveEmp(emp, grp)
{
 var selIdx = document.all.newGroup.options.selectedIndex;
 var newGroup = document.all.newGroup.options[selIdx].value

 SbmString = "SavHrsEnt.jsp?STORE=" + CurStore
                + "&STRNAME=" + CurStrName
                + "&MONBEG=" + Month
                + "&WEEKEND=" + WeekEnd
                + "&GRP=" + grp
                + "&NEWGRP=" + newGroup
                + "&EMPNUM=" + emp.substring(0, 4)
                + "&EMPNAME=" + emp.substring(5)
                + "&ACTION=MOV"
                + "&WKDATE0=" + WeekEnd
                + "&ACTRANGE=EMPWEEK"
                + "&FROM=" + From
                + "&POS=LIST"
                + "&SCHTYP=<%=sSchTyp%>"
                + "&SHWGOAL=<%=sShwGoal%>"
                + "&DOC=WEEK"
                + "&BEGTIME0=00:00"
                + "&ENDTIME0=00:00"
                + "&HRSTYP0=ALL";
  //alert(SbmString);
  if (Allow=="YES") window.location.href = SbmString;
  else alert("This week has the APPROVED status. Changes is not allowed!");
}


// Request days off employee schedule
function genReqOff(emp, grp, day){
  SbmString = "SavHrsEnt.jsp?STORE=" + CurStore
                + "&STRNAME=" + CurStrName
                + "&MONBEG=" + Month
                + "&WEEKEND=" + WeekEnd
                + "&GRP=" + grp
                + "&EMPNUM=" + emp.substring(0, 4)
                + "&EMPNAME=" + emp.substring(5)
                + "&ACTION=ADD"
                + "&HRSTYP0=OFF"
                + "&FROM=" + From
                + "&POS=LIST"
                + "&SCHTYP=" + "<%=sSchTyp%>"
                + "&SHWGOAL=" + "<%=sShwGoal%>"
                + "&DOC=WEEK"
                + "&WKDATE0=" + day
                + "&BEGTIME0=08:00"
                + "&ENDTIME0=09:00";
  //alert(SbmString);
  if (Allow=="YES") window.location.href = SbmString;
  else alert("This week has the APPROVED status. Changes is not allowed!");
}

/**------------------------------------------------------------------**/
/**--------------------- Save Events --------------------------------**/
/**------------------------------------------------------------------**/
function submitEvt()
{
  hidetip2();
  // change action string
  SbmString = "SavEvtEnt.jsp?STORE=" + CurStore
                + "&STRNAME=" + CurStrName
                + "&MONBEG=" + Month
                + "&WEEKEND=" + WeekEnd
                + "&EVENT=" + selectedEvent
                + "&ACTION=ADD"
                + "&FROM=" + From
                + "&POS=ENTRY"
                + "&SCHTYP=" + "<%=sSchTyp%>"
                + "&SHWGOAL=<%=sShwGoal%>"
                + "&DOC=WEEK"
                + "&WKDATE=" + WkDate[selEvtDay]
                + "&DAYTIME=" + selEvtTime
                + "&EVTINF=" + selEvtInf;

  //alert(SbmString)
  window.location.href = SbmString;
}

// delete employee schedule
function dltEvtEntry(event, dayNum){
day = WkDate[dayNum];
if(dayNum==null) day=WeekEnd
  SbmString = "SavEvtEnt.jsp?STORE=" + CurStore
                + "&STRNAME=" + CurStrName
                + "&MONBEG=" + Month
                + "&WEEKEND=" + WeekEnd
                + "&EVENT=" + event
                + "&ACTION=DLT"
                + "&FROM=" + From
                + "&POS=LIST"
                + "&SCHTYP=" + "<%=sSchTyp%>"
                + "&SHWGOAL=" + "<%=sShwGoal%>"
                + "&DOC=WEEK"
                + "&WKDATE=" + day
                + "&DAYTIME=NONE"
                + "&EVTINF=NONE"
  //alert(SbmString);
  window.location.href=SbmString;
}

//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, " "); }
    return s;
}

/**------------------------------------------------------------------**/
/**--------------------- End Save Events ----------------------------**/
/**------------------------------------------------------------------**/

// ---------------- Move Boxes ---------------------------------------
var dragapproved=false
var z,x,y
function move(){
if (event.button==1&&dragapproved){
z.style.pixelLeft=temp1+event.clientX-x
z.style.pixelTop=temp2+event.clientY-y
return false
}
}
function drags(){
if (!document.all)
return
var obj = event.srcElement

if (event.srcElement.className=="Grid"
    || event.srcElement.className=="Menu"
    || event.srcElement.className=="Menu1"){
   while (obj.offsetParent){
     if (obj.id=="menu" || obj.id=="tooltip2")
     {
       z=obj;
       break;
     }
     obj = obj.offsetParent;
   }
  dragapproved=true;
  temp1=z.style.pixelLeft
  temp2=z.style.pixelTop
  x=event.clientX
  y=event.clientY
  document.onmousemove=move
}
}
document.onmousedown=drags
document.onmouseup=new Function("dragapproved=false")
// ---------------- End of Move Boxes ---------------------------------------

// ---------------------- Check Message board --------------------------------
function chkMsgBoard()
{
  var MyURL = "GetMsgBoard.jsp?STORE=<%=sStore%>&WEEKEND=<%=sWeekEnd%>&USER=<%=sUser%>&Self=Yes";
   "width=400,height=50, left=10,top=10, toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,resize=no,menubar=no";

  //alert(MyURL)
  window.frame1.location = MyURL;
  this.focus();
}

// populate message board parameters
function setMsgBrd(Sts, Snd, Dat, Tim, Str, Name, Wkend, Req, Rsp)
{
  AprvSts = Sts;
  AprvSnd = Snd;
  AprvDat = Dat;
  AprvTim = Tim;

  var  msgHtml = "<table cellPadding='0' cellSpacing='0'><tr><td class='MsgBrd' colspan=2 nowrap>Schedule Status: " + AprvSts + "</tr></td>"
               + "<tr>"
  if (Str.length > 0)
  {
    msgHtml += "<td class='MsgBrd1'><a href='javascript:showMsgBrdNews()' ><marquee><b>New messages</b></marquee></a></td>";
  }
  else
  {
     // msgHtml += "<td class='MsgBrd1' nowrap><a href='Forum.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&WEEKEND=<%=sWeekEnd%>' target='_blank'>"
     msgHtml += "<td class='MsgBrd1' nowrap><a href='Forum.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&WEEKEND=<%=sWeekEnd%>&MONBEG=<%=sMonth%>' target='_blank'>"
     + "Go To Message Board</a></td>"
  }
  msgHtml += "<td nowrap class='MsgBrd1' width='30%'>,&nbsp;<a href='javascript:chkMsgBoard()'>refresh</a></td></tr></table>"


  document.all.msgbrd.innerHTML=msgHtml
  document.all.msgbrd.style.pixelLeft=10;
  document.all.msgbrd.style.pixelTop=60;
  document.all.msgbrd.style.visibility="visible"

  msgTable = "<table class='DataTable'><tr>"
       + "<th class='DataTable'>Str</th>"
       + "<th class='DataTable'>Week</th>"
       + "<th class='DataTable'>New</th>"
       + "<th class='DataTable'>Reply</th></tr>";

  for(i=0; i < Str.length; i++)
  {
    msgTable += "<tr><td class='DataTable'>" + Str[i] + "</td>"
             + "<td class='DataTable'>"
             + "<a href='Forum.jsp?STORE="+ Str[i]
             + "&STRNAME="+ Name[i] +"&WEEKEND=" + Wkend[i] + "' target='_blank'>"
             + Wkend[i] + "</a>"
             + "</td>"
             + "<td class='DataTable'>" + Req[i] + "</td>"
             + "<td class='DataTable'>" + Rsp[i] + "</td></tr>"
  }
  msgTable += "</table>";

  if(AprvSts != "*APPROVED")
  {
    Allow = "YES";
  }
}

// show number of new messages by store and week
function showMsgBrdNews()
{
  var  msgHtml = "AprvSts: " + AprvSts + msgTable
       + "<button class='small' type='button' name='collapse' onclick='collapse()'>"
       + "Collapse</button>"

  document.all.msgbrd.innerHTML=msgHtml
  document.all.msgbrd.style.pixelLeft=10;
  document.all.msgbrd.style.pixelTop=60;
  document.all.msgbrd.style.visibility="visible"
}

// return to small size
function collapse()
{
  var  msgHtml = "<table cellPadding='0' cellSpacing='0'><tr><td class='MsgBrd' colspan=2 nowrap>Schedule Status: " + AprvSts
         + "</td></tr>";
  msgHtml += "<tr><td class='MsgBrd1' nowrap><a href='javascript:showMsgBrdNews()'><marquee><b>New messages</marquee></b></a></td>";
  msgHtml += "<td class='MsgBrd1' nowrap width='30%'>,&nbsp;<a href='javascript:chkMsgBoard()'>refresh</a></td></tr></table>"

  document.all.msgbrd.innerHTML=msgHtml
  document.all.msgbrd.style.pixelLeft=10;
  document.all.msgbrd.style.pixelTop=60;
  document.all.msgbrd.style.visibility="visible"
}

function ChangeSchedStatus(sts)
{
  var apSts = "Y";
  if (sts == "*APPROVED") apSts = "N";

  var loc = "SaveMsgEnt.jsp?"
          + "STORE=<%=sStore%>"
          + "&STRNAME=<%=sThisStrName%>"
          + "&WEEKEND=<%=sWeekEnd%>"
          + "&MONBEG=<%=sMonth%>"
          + "&Sender=<%=sUser%>"
          + "&User=<%=sUser%>"
          + "&To=*GET"
          + "&APRVSTS=" + apSts
          + "&From=SchedbyWeek.jsp";
  //alert(loc);
  window.location.href=loc;
}

// ---------------------- End Message board --------------------------------
</SCRIPT>
</head>
<!-------------------------------------------------------------------->
<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->


  <div id="tooltip2" class="Tootip"></div>
  <div id="menu" class="Menu"></div>
  <div id="msgbrd" class="MsgBrd"></div>

<!-------------------------------------------------------------------->
  <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin"><td ALIGN="center" VALIGN="TOP" colspan="3">
      <b>Weekly Schedule Summary</b>
     </tr>
     <tr bgColor="moccasin">
        <td ALIGN="left" VALIGN="TOP"><b>&nbsp;Store:&nbsp;<%=sStore + " - " + sThisStrName%></b></td>
        <td ALIGN="center" VALIGN="TOP">&nbsp;</td>
        <td ALIGN="right" VALIGN="TOP"><b>Week Ending:&nbsp;<%=sWeekName%>&nbsp;</b></td>
     </tr>
     <tr bgColor="moccasin">
        <td ALIGN="left" VALIGN="TOP">&nbsp;</td>
        <td ALIGN="center" VALIGN="TOP"><b>Weekly Sales Goal: $<%=sDailySlsGoal[7]%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></td>
        <td ALIGN="right" VALIGN="TOP"><font size="-1"><a href="javascript:selectWeekEnd('DAY', null, null, null)">week endings</a>&nbsp;</font></td>
     </tr>
     <tr bgColor="moccasin">
        <td ALIGN="center" VALIGN="TOP" colspan="3">
        <a href="Availability.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>"><font color="red" size="-1">Availability</font></a>;
        <a href="mailto:<%=sEMail%>"><font color="red" size="-1">E-mail</font></a>;
        <a href="../"><font color="red" size="-1">Home</font></a>&#62;
        <a href="StrScheduling.html"><font color="red" size="-1">Payroll</font></a>&#62;
        <%if(sFrom.equals("AVGPAYREP")){%>
          <a href="APRSelector.jsp"><font color="red" size="-1">Store Selector</font></a>&#62;
          <a href="AvgPayRep.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>">
             <font color="red" size="-1">Average Pay Report</font></a>&#62;
        <%}
        else {%>
          <a href="SchedbyWkSel.jsp"><font color="red" size="-1">Store/Week Selector</font></a>&#62;
        <%}%>
         This page
        <!------------- start of dollars table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable" rowspan="2" colspan="3" >Employee/Title</th>
           <th class="DataTable2" colspan="7" id="ALL"
                 onclick="ShowMenu(this, '<%=sDailySlsGoal[7]%>', null)">Days</th>
           <th class="DataTable" rowspan="4">Total<br>Hours</th>
         </tr>
         <tr>
           <%for(int i=0; i < 7; i++){%>
             <th class="DataTable" >
               <a href="SchedbyDay.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWkDate[i]%>&FROM=<%=sFrom%>&WKDAY=<%=sDaysOfWeek[i]%>">
                <%=sShort[i]%></a>
             </th>
           <%}%>
         </tr>
         <tr>
           <th class="DataTable1" colspan="3">
              <a href="EmpNumbyHourWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWkDate[0]%>&FROM=<%=sFrom%>&WKDAY=<%=sDaysOfWeek[0]%>">
                 Store Coverage</a>
           </th>
           <%for(int i=0; i < 7; i++){%>
             <th class="DataTable2" id="EBH<%=i%>" onClick="dspEmpbyHr(this, '<%=sWkDate[i]%>', '<%=sDaysOfWeek[i]%>')">
                <%=sWkDays[i]%></th>
           <%}%>
         </tr>
     <!-- --------------- Daily Sales Goals ---------------- -->
         <tr>
           <th class="DataTable1" colspan="3">Sales Goal</th>
           <%for(int i=0; i < 7; i++){%>
             <th class="DataTable" >$<%=sDailySlsGoal[i]%></th>
           <%}%>
         </tr>

     <!-- --------------- Managers ---------------- -->
      <tr>
        <td class="DataTable11" id="MNGP" onclick="ShowMenu(this, 0, null)" >Managers</td>
         <td class="DataTable14">
         <a href="javascript:dspGrpbyHr('MNGR')">Cov</a>
         <!--a href="EmpNumbyHourWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWkDate[0]%>&FROM=<%=sFrom%>&WKDAY=<%=sDaysOfWeek[0]%>&SHWGRP=MNGR">
           Cov</a -->
         </td>
        </td>
          <td class="DataTable13" nowrap>Tot Hours</td>
        <%for(int i=0; i< 7; i++){%>
           <td class="DataTable13" ><%=sMgrDay[i]%></td>
        <%}%>
        <td class="DataTable13" ><%=sGrpTot[0]%></td>
      </tr>

      <%for(int i=0; i < iNumOfMgr; i++){%>
         <tr >
          <td class="DataTable" id="MNEN<%=sMgrSch[i][0]%> " onclick="ShowMenu(this, 0, '<%=sMgrTimOff[i]%>')" nowrap>
             <font color="<%=sMgrMltClr[i]%>"><%=sMgrSch[i][0].substring(5)%>
                   <sup><%=sMgrOvr7[i]+sMgrAvail[i]%><sup><%=sMgrMlt[i]%></font></td>
          <!--td class="DataTable1"><%=sMgrDpt[i]%></td-->
          <td class="DataTable4" colspan="2"><%=sMgrTtl[i]%></td>
          <%for(int k=1; k < 8; k++){
             if(sMgrHTyp[i][k].equals("VAC")){%>
               <td class="DataTable6" id="MNDS<%=sMgrSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this, '0', '<%=sMgrTimOff[i]%>')">Vacation</td>
             <%}
             else if(sMgrHTyp[i][k].equals("HOL")){%>
               <td class="DataTable7" id="MNDS<%=sMgrSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this, '0', '<%=sMgrTimOff[i]%>')" nowrap>Holiday</td>
             <%}
             else if(sMgrHTyp[i][k].equals("OFF")){%>
               <td class="DataTable8" id="MNDS<%=sMgrSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this, '0', '<%=sMgrTimOff[i]%>')" nowrap>Request off</td>
             <%}
              else {%>
                <td class="DataTable1" id="MNDS<%=sMgrSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this, '0', '<%=sMgrTimOff[i]%>')" nowrap><%=sMgrSch[i][k]%></td>
              <%}%>
          <%}%>
          <td class="DataTable4"><font color="<%=sMgrOvTmClr[i]%>"><%=sMgrTot[i]%><%=sMgrOvTm[i]%></font></td>
         </tr>
       <%}%>

       <!-- --------------- Selling personnel ---------------- -->
      <tr>
       <td class="DataTable3" id="SLGP" rowspan="2">Selling &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <a href="EmpNumbyHourWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWkDate[0]%>&FROM=<%=sFrom%>&WKDAY=<%=sDaysOfWeek[0]%>&SHWGRP=MNSLS">
            <span style="font-family=Arial; font-size=10px">Mgr/Sell</span></a>
       </td>
       <td class="DataTable12">&nbsp;</td>
       <td class="DataTable9" nowrap>Tot Hours</td>
       <%for(int i=0; i< 7; i++){%>
           <td class="DataTable9" ><%=sSlsDay[i]%></td>
        <%}%>
       <td class="DataTable9"><%=sGrpTot[1]%></td>
      </tr>
      <tr>
      <td class="DataTable15">
        <a href="EmpNumbyHourWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWkDate[0]%>&FROM=<%=sFrom%>&WKDAY=<%=sDaysOfWeek[0]%>&SHWGRP=SLSP">
            Cov</a>
      </td>
       <td class="DataTable16">Sls/Hour</td>
       <%for(int i=0; i< 7; i++){%>
           <td class="DataTable16" >$<%=sSlsGoalHr[i]%></td>
        <%}%>
        <td class="DataTable16">$<%=sSlsGoalHr[7]%></td>
      </tr>
      <!-- --------------- Sales Department ---------------- -->
       <tr>
       <td class="DataTable10" colspan="3" id="SLGP" onclick="ShowMenu(this, '<%=sDailySlsGoal[7]%>', null)" >&nbsp;&nbsp;Regular Sales</td>
           <td class="DataTable10" colspan="8">&nbsp;</td>
      </tr>
      <!-- --------------- Sales Department Details ---------------- -->
      <%for(int i=0; i < iNumOfSls; i++){%>
         <tr>
          <td class="DataTable" id="SLEN<%=sSlsSch[i][0]%>" onclick="ShowMenu(this, 0, '<%=sSlsTimOff[i]%>')">
               <font color="<%=sSlsMltClr[i]%>"><%=sSlsSch[i][0].substring(5)%>
               <sup><%=sSlsOvr7[i]+sSlsAvail[i]%></sup><%=sSlsMlt[i]%></font></td>
          <td class="DataTable4" colspan="2"><%=sSlsTtl[i]%></td>
          <%for(int k=1; k < 8; k++){
            if(sSlsHTyp[i][k].equals("VAC")){%>
              <td class="DataTable6" id="SLDS<%=sSlsSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sSlsTimOff[i]%>')">Vacation</td>
          <%}
            else if(sSlsHTyp[i][k].equals("HOL")){%>
              <td class="DataTable7" id="SLDS<%=sSlsSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sSlsTimOff[i]%>')" >Holiday</td>
           <%}
           else if(sSlsHTyp[i][k].equals("OFF")){%>
              <td class="DataTable8" id="SLDS<%=sSlsSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sSlsTimOff[i]%>')" >Request Off</td>
           <%}
            else {%>
              <td class="DataTable1" id="SLDS<%=sSlsSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this, '<%=sSlsGoal[i][k]%>', '<%=sSlsTimOff[i]%>')"
                      nowrap><%=sSlsSch[i][k]%>
               <br><%if(sShwGoal.equals("S")){%><%=sSlsGoal[i][k]%><%}%></td>
           <%}%>
          <%}%>
          <td class="DataTable4"><font color="<%=sSlsOvTmClr[i]%>"><%=sSlsTot[i]%>
                <%=sSlsOvTm[i]%></font></td>
         </tr>
       <%}%>
       <!-- --------------- SLSP - Bike Department ---------------- -->
       <tr>
       <td class="DataTable10" colspan="3" id="SBGP" onclick="ShowMenu(this, '<%=sDailySlsGoal[7]%>', null)" >&nbsp;&nbsp;Bike Sales</td>
           <td class="DataTable10" colspan="8">&nbsp;</td>
      </tr>
      <!-- --------------- SLSP - Bike Department Details ---------------- -->
            <%for(int i=0; i < iNumOfSBk; i++){%>
         <tr>
          <td class="DataTable" id="SBEN<%=sSBkSch[i][0]%>" onclick="ShowMenu(this, 0, '<%=sSBkTimOff[i]%>')">
               <font color="<%=sSBkMltClr[i]%>"><%=sSBkSch[i][0].substring(5)%>
               <sup><%=sSBkOvr7[i]+sSBkAvail[i]%></sup><%=sSBkMlt[i]%></font></td>
          <!--td class="DataTable1"><%=sSBkDpt[i]%></td-->
          <td class="DataTable4" colspan="2"><%=sSBkTtl[i]%></td>
          <%for(int k=1; k < 8; k++){
            if(sSBkHTyp[i][k].equals("VAC")){%>
              <td class="DataTable6" id="SBDS<%=sSBkSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sSBkTimOff[i]%>')">Vacation</td>
          <%}
            else if(sSBkHTyp[i][k].equals("HOL")){%>
              <td class="DataTable7" id="SBDS<%=sSBkSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sSBkTimOff[i]%>')" >Holiday</td>
           <%}
           else if(sSBkHTyp[i][k].equals("OFF")){%>
              <td class="DataTable8" id="SBDS<%=sSBkSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sSBkTimOff[i]%>')" >Request Off</td>
           <%}
            else {%>
              <td class="DataTable1" id="SBDS<%=sSBkSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this, '<%=sSBkGoal[i][k]%>', '<%=sSBkTimOff[i]%>')"
                      nowrap><%=sSBkSch[i][k]%>
               <br><%if(sShwGoal.equals("S")){%><%=sSBkGoal[i][k]%><%}%></td>
           <%}%>
          <%}%>
          <td class="DataTable4"><font color="<%=sSBkOvTmClr[i]%>"><%=sSBkTot[i]%>
                <%=sSBkOvTm[i]%></font></td>
         </tr>
       <%}%>


     <!-- --------------- Non- Selling personnel ---------------- -->
      <tr>
       <td class="DataTable3" id="NCGP">Non-Selling</td>
       <td class="DataTable12"><a href="EmpNumbyHourWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWkDate[0]%>&FROM=<%=sFrom%>&WKDAY=<%=sDaysOfWeek[0]%>&SHWGRP=NSLSP">
           Cov</a></td>
       <td class="DataTable9" nowrap>Tot Hours</td>
       <%for(int i=0; i< 7; i++){%>
           <td class="DataTable9" ><%=sNSlDay[i]%></td>
        <%}%>
       <td class="DataTable9"><%=sGrpTot[2]%></td>
      </tr>
      <!-- --------------- Cashiers Department ---------------- -->
       <tr>
       <td class="DataTable10" colspan="3" id="NCGP" onclick="ShowMenu(this, '<%=sDailySlsGoal[7]%>', null)" >&nbsp;&nbsp;Cashiers</td>
           <td class="DataTable17" colspan="8"><a href="javascript:dspGrpbyHr('NSLSP')">Cov</a></td>
      </tr>
      <!-- --------------- Salling personnel - Cashiers Department Details ---------------- -->

      <%for(int i=0; i < iNumOfNSl; i++){%>
         <tr>
          <td class="DataTable" id="NCEN<%=sNSlSch[i][0]%>" onclick="ShowMenu(this, 0, '<%=sNSlTimOff[i]%>')">
              <font color="<%=sNSlMltClr[i]%>"><%=sNSlSch[i][0].substring(5)%>
              <%=sNSlMlt[i]%><sup><%=sNSlOvr7[i]+sNSlAvail[i]%></sup></font></td>
          <td class="DataTable4" colspan="2"><%=sNSlTtl[i]%></td>
          <%for(int k=1; k < 8; k++){
            if(sNSlHTyp[i][k].equals("VAC")){%>
              <td class="DataTable6" id="NCDS<%=sNSlSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sNSlTimOff[i]%>')">Vacation</td>
          <%}
           else if(sNSlHTyp[i][k].equals("HOL")){%>
              <td class="DataTable7" id="NCDS<%=sNSlSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sNSlTimOff[i]%>')">Holiday</td>
          <%}
          else if(sNSlHTyp[i][k].equals("OFF")){%>
              <td class="DataTable8" id="NCDS<%=sNSlSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sNSlTimOff[i]%>')">Request Off</td>
          <%}
            else {%>
              <td class="DataTable1" id="NCDS<%=sNSlSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sNSlTimOff[i]%>')" nowrap><%=sNSlSch[i][k]%></td>
            <%}%>
          <%}%>
          <td class="DataTable4"><%=sNSlTot[i]%><font color="<%=sNSlOvTmClr[i]%>"><%=sNSlOvTm[i]%></dont></td>
         </tr>
       <%}%>
       <!-- --------------- Receiving Department ---------------- -->
       <tr>
       <td class="DataTable10" colspan="3" id="NRGP" onclick="ShowMenu(this, '<%=sDailySlsGoal[7]%>', null)" >&nbsp;&nbsp;Receiving</td>
           <td class="DataTable10" colspan="8">&nbsp;</td>
      </tr>
      <!-- --------------- Non-Selling personnel- Receiving Department Details ---------------- -->
      <%for(int i=0; i < iNumOfNRc; i++){%>
         <tr>
          <td class="DataTable" id="NREN<%=sNRcSch[i][0]%>" onclick="ShowMenu(this, 0, '<%=sNRcTimOff[i]%>')">
              <font color="<%=sNRcMltClr[i]%>"><%=sNRcSch[i][0].substring(5)%>
              <%=sNRcMlt[i]%><sup><%=sNRcOvr7[i]+sNRcAvail[i]%></sup></font></td>
          <td class="DataTable4" colspan="2"><%=sNRcTtl[i]%></td>
          <%for(int k=1; k < 8; k++){
            if(sNRcHTyp[i][k].equals("VAC")){%>
              <td class="DataTable6" id="NRDS<%=sNRcSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sNRcTimOff[i]%>')">Vacation</td>
          <%}
           else if(sNRcHTyp[i][k].equals("HOL")){%>
              <td class="DataTable7" id="NRDS<%=sNRcSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sNRcTimOff[i]%>')">Holiday</td>
          <%}
          else if(sNRcHTyp[i][k].equals("OFF")){%>
              <td class="DataTable8" id="NRDS<%=sNRcSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sNRcTimOff[i]%>')">Request Off</td>
          <%}
            else {%>
              <td class="DataTable1" id="NRDS<%=sNRcSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sNRcTimOff[i]%>')" nowrap><%=sNRcSch[i][k]%></td>
            <%}%>
          <%}%>
          <td class="DataTable4"><%=sNRcTot[i]%>
             <font color="<%=sNRcOvTmClr[i]%>"><%=sNRcOvTm[i]%></font></td>
         </tr>
       <%}%>

      <!-- --------------- Bike Department ---------------- -->
       <tr>
       <td class="DataTable10" colspan="3" id="NBGP" onclick="ShowMenu(this, 0, null)" >&nbsp;&nbsp;Bike Shop</td>
           <td class="DataTable10" colspan="8">&nbsp;</td>
      </tr>
      <!-- --------------- Non-Selling personnel- Bike Department Details ---------------- -->
      <%for(int i=0; i < iNumOfNBk; i++){%>
         <tr>
          <td class="DataTable" id="NBEN<%=sNBkSch[i][0]%>" onclick="ShowMenu(this, 0, '<%=sNBkTimOff[i]%>')">
              <font color="<%=sNBkMltClr[i]%>"><%=sNBkSch[i][0].substring(5)%>
              <%=sNBkMlt[i]%><sup><%=sNBkOvr7[i]+sNBkAvail[i]%></sup></font></td>
          <td class="DataTable4" colspan="2"><%=sNBkTtl[i]%></td>
          <%for(int k=1; k < 8; k++){
            if(sNBkHTyp[i][k].equals("VAC")){%>
              <td class="DataTable6" id="NBDS<%=sNBkSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sNBkTimOff[i]%>')">Vacation</td>
          <%}
           else if(sNBkHTyp[i][k].equals("HOL")){%>
              <td class="DataTable7" id="NBDS<%=sNBkSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sNBkTimOff[i]%>')">Holiday</td>
          <%}
          else if(sNBkHTyp[i][k].equals("OFF")){%>
              <td class="DataTable8" id="NBDS<%=sNBkSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sNBkTimOff[i]%>')">Request Off</td>
          <%}
            else {%>
              <td class="DataTable1" id="NBDS<%=sNBkSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sNBkTimOff[i]%>')" nowrap><%=sNBkSch[i][k]%></td>
            <%}%>
          <%}%>
          <td class="DataTable4"><%=sNBkTot[i]%>
             <font color="<%=sNBkOvTmClr[i]%>"><%=sNBkOvTm[i]%></font></td>
         </tr>
       <%}%>
     <!-- --------------- Other Department ---------------- -->
       <tr>
       <td class="DataTable10" colspan="3" id="NOGP" onclick="ShowMenu(this, 0,null)" >&nbsp;&nbsp;Other</td>
           <td class="DataTable10" colspan="8">&nbsp;</td>
      </tr>
      <!-- --------------- Non-Selling personnel- Other Details ---------------- -->
      <%for(int i=0; i < iNumOfNOt; i++){%>
         <tr>
          <td class="DataTable" id="NOEN<%=sNOtSch[i][0]%>" onclick="ShowMenu(this, 0, '<%=sNOtTimOff[i]%>')">
              <font color="<%=sNOtMltClr[i]%>"><%=sNOtSch[i][0].substring(5)%>
              <sup><%=sNOtOvr7[i]+sNOtAvail[i]%></sup><%=sNOtMlt[i]%></font></td>

          <td class="DataTable4" colspan="2"><%=sNOtTtl[i]%></td>
          <%for(int k=1; k < 8; k++){
            if(sNOtHTyp[i][k].equals("VAC")){%>
              <td class="DataTable6" id="NODS<%=sNOtSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sNOtTimOff[i]%>')">Vacation</td>
          <%}
           else if(sNOtHTyp[i][k].equals("HOL")){%>
              <td class="DataTable7" id="NODS<%=sNOtSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sNOtTimOff[i]%>')">Holiday</td>
          <%}
          else if(sNOtHTyp[i][k].equals("OFF")){%>
              <td class="DataTable8" id="NODS<%=sNOtSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sNOtTimOff[i]%>')">Request Off</td>
          <%}
            else {%>
              <td class="DataTable1" id="NODS<%=sNOtSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this,'0', '<%=sNOtTimOff[i]%>')" nowrap><%=sNOtSch[i][k]%></td>
            <%}%>
          <%}%>
          <td class="DataTable4"><%=sNOtTot[i]%>
             <font color="<%=sNOtOvTmClr[i]%>"><%=sNOtOvTm[i]%></font></td>
         </tr>
       <%}%>

      <!-- --------------- Training ---------------- -->
      <tr>
        <td class="DataTable11" id="TRGP" onclick="ShowMenu(this, 0, null)" >Training</td>
        <td class="DataTable13" nowrap colspan="2">Tot Hours</td>
        <%for(int i=0; i< 7; i++){%>
           <td class="DataTable13" ><%=sTrnDay[i]%></td>
        <%}%>
        <td class="DataTable13" ><%=sGrpTot[3]%></td>
      </tr>

      <%for(int i=0; i < iNumOfTrn; i++){%>
         <tr >
          <td class="DataTable" id="TREN<%=sTrnSch[i][0]%> " onclick="ShowMenu(this, 0, '<%=sTrnTimOff[i]%>')" nowrap>
             <font color="<%=sTrnMltClr[i]%>"><%=sTrnSch[i][0].substring(5)%>
                   <sup><%=sTrnOvr7[i]+sTrnAvail[i]%><sup><%=sTrnMlt[i]%></font></td>
          <!--td class="DataTable1"><%=sTrnDpt[i]%></td-->
          <td class="DataTable4" colspan="2"><%=sTrnTtl[i]%></td>
          <%for(int k=1; k < 8; k++){
             if(sTrnHTyp[i][k].equals("VAC")){%>
               <td class="DataTable6" id="TRDS<%=sTrnSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this, '0', '<%=sTrnTimOff[i]%>')">Vacation</td>
             <%}
             else if(sTrnHTyp[i][k].equals("HOL")){%>
               <td class="DataTable7" id="TRDS<%=sTrnSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this, '0', '<%=sTrnTimOff[i]%>')" nowrap>Holiday</td>
             <%}
             else if(sTrnHTyp[i][k].equals("OFF")){%>
               <td class="DataTable8" id="TRDS<%=sTrnSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this, '0', '<%=sTrnTimOff[i]%>')" nowrap>Request off</td>
             <%}
              else {%>
                <td class="DataTable1" id="TRDS<%=sTrnSch[i][0]+sWkDate[k-1]%>" onclick="ShowMenu(this, '0', '<%=sTrnTimOff[i]%>')" nowrap><%=sTrnSch[i][k]%></td>
              <%}%>
          <%}%>
          <td class="DataTable4"><font color="<%=sTrnOvTmClr[i]%>"><%=sTrnTot[i]%><%=sTrnOvTm[i]%></font></td>
         </tr>
       <%}%>



      <!-- --------------- Table total ---------------- -->
      <tr>
       <td class="Total" >Total</td>
       <td class="Total2">
        <a href="javascript:dspGrpbyHr('TOTAL')">Cov</a>
       </td>
       <td class="Total1">&nbsp;</td>
       <%for(int i=0; i< 7; i++){%>
           <td class="Total1" ><%=sTotDay[i]%></td>
        <%}%>
       <td class="Total1"><%=sGrpTot[4]%></td>
      </tr>
      <tr>
           <th class="DataTable1" colspan="3">
              <a href="EmpNumbyHourWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWkDate[0]%>&FROM=<%=sFrom%>&WKDAY=<%=sDaysOfWeek[0]%>">
              Store Coverage</a>
           </th>
           <%for(int i=0; i < 7; i++){%>
             <th class="DataTable2" id="EBH<%=i%>" onClick="dspEmpbyHr(this, '<%=sWkDate[i]%>', '<%=sDaysOfWeek[i]%>')">
               <!--a href="EmpNumbyHour.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWkDate[i]%>&FROM=<%=sFrom%>&WKDAY=<%=sDaysOfWeek[i]%>"-->
                <%=sWkDays[i]%></th>
           <%}%>
           <th class="DataTable2">&nbsp;</th>
      </tr>

      <!-- --------------- Store Weekly Events ---------------- -->
      <tr>
       <td class="DataTable11" id="EVTGP" colspan="11"
          onclick="ShowEvtMenu(this, null, null)">Events</td>
      </tr>

      <!-- --------------- Store Weekly Event Details ---------------- -->
      <%for(int i=0; i < iNumOfEvt; i++){%>
         <tr>
          <td class="DataTable" id="EVT<%=sEvents[i]%>" colspan="3"
              onclick="ShowEvtMenu(this, <%=i%>, null)" >
             <%=sEvents[i]%></td>
          <%for(int k=0; k < 7; k++){%>
          <%if (iEvtDay[i] == k){%>
              <td class="DataTable1" id="EVTDT<%=i%>"
                  onclick="ShowEvtMenu(this, <%=i%>)"><%=sEvtTime[i]%></td>
                 <%}
                 else{%><td class="DataTable4">&#160;</td><%}%>

          <%}%>
          <td class="DataTable4">&#160;</td>
         </tr>
       <%}%>


      <!-- --------------- End Store Weekly Events ---------------- -->
     </table>
<!------------- end of data table ------------------------>

                </td>
            </tr>

            <tr><td align=left><font size="-1" color="red">
               ** - Employee scheduled in more than 1 Group/Dept.
               <br><sup>7</sup> - Employee scheduled for more than 7 days in a row.
               <br><sup>A</sup> - Check employee availability.
               </font></td><td></td>
              <td align=right><font size="-1" color="red">* - Overtime alert!</font>
              </td>
            </tr>

       </table>
       <p align="center" >
       <button name="CHGSCH" type="button" onclick="chgSch(this)">
         <%if(sSchTyp.equals("TIM")){%>Hours<%} else {%>Schedule<%}%>
       </button>&nbsp;&nbsp;
       <button name="SHWGOAL" type="button" onclick="dspGoal(this)">
          <%if(sShwGoal.equals("S")){%>Hide Sales Goal<%} else {%>Sales Goal<%}%>
       </button>

       <br><font size="-1">Click here to see the Monthly</font>
           <a href="FiscalMonthBudget.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>">
          <font color="red" size="-1">Budget</font></a>
          <font size="-1">You must be authorized to use this option.</font>
       <br><font size="-1">Last update made by: <%=sUserId%> on
            <%=sLastChgDate%> at <%=sLastChgTime%>.</font>
       <%if   (sStrAllowed != null && sStrAllowed.trim().equals("ALL")){%>
         <br><font size="-1">Click here to </font>
             <a href="javascript: ChangeSchedStatus('<%=sApproveSts%>')">
                <font color="red" size="-1">
                <%if (!sApproveSts.equals("*APPROVED")) {%>
                   Approve Schedule
                <%}
                else {%>
                   Postpone Schedule
                <%}%>
                </font></a>
       <%}%>
  </body>


</html>
