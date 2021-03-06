<%@ page import="payrollreports.PrWkSched,  rciutility.SetStrEmp, java.util.*"%>
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
   boolean bAccess = false;

   /*System.out.println(sStore + "|" + sThisStrName + "|" + sWeekEnd + "|" + sMonth + "|" + sFrom
       + "|" + sSchTyp + "|" + sShwGoal + "|" + sNumOfErr);
*/
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
  Vector vStr = (Vector) session.getAttribute("STRLST");
  String [] sStrAlwLst = new String[ vStr.size()];
  Iterator iter = vStr.iterator();

  int iStrAlwLst = 0;
  while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

  String sStrAllowed = null;
  String sAppl = "PAYROLL";
  boolean bChange = false;
   if (session.getAttribute("USER")==null )
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PrWkSched.jsp&" + request.getQueryString());
   }
   else
   {
     sUser = session.getAttribute("USER").toString();
     sStrAllowed = session.getAttribute("STORE").toString();
     bAccess = session.getAttribute("ACCESS") != null && session.getAttribute("ACCESS").toString().equals("1");
     bChange = session.getAttribute(sAppl)!=null;
   }
  // -------------- End Security -----------------

    PrWkSched sWkSch = new PrWkSched(sStore, sWeekEnd);

    int iNumOfSec = sWkSch.getNumOfSec();
    int iNumOfGrp = sWkSch.getNumOfGrp();
    int [] iNumSecGrp = sWkSch.getNumSecGrp();
    String [] sSecLst = sWkSch.getSecLst();
    String [] sSecName = sWkSch.getSecName();
    String [] sGrpLst = sWkSch.getGrpLst();
    String [] sGrpName = sWkSch.getGrpName();
    String [] sSecTot = sWkSch.getSecTot();
    String sRepTot = sWkSch.getRepTot();
    String [] sTotDay = sWkSch.getTotDay();

    String [][] sSecDay = sWkSch.getSecDay();

    int [] iNumGrpEmp = sWkSch.getNumGrpEmp();
    String [][] sGrpEmp = sWkSch.getGrpEmp();
    String [][][] sGrpSch = null;
    String [][][] sGrpTim = null;
    String [][] sGrpEmpTot = sWkSch.getGrpEmpTot();

    String [][] sGrpDpt = sWkSch.getGrpEmpTot();
    String [][] sGrpTtl = sWkSch.getGrpTtl();
    String [][] sGrpTimOff = sWkSch.getGrpTimOff();
    String [][] sGrpOvr7 =sWkSch.getGrpOvr7();
    String [][][] sGrpHTyp = sWkSch.getGrpHTyp();
    String [][] sGrpMlt = sWkSch.getGrpMlt();
    String [][] sGrpMltClr = sWkSch.getGrpMltClr();
    String [][] sGrpAvail = sWkSch.getGrpAvail();

   String [][][] sSlsGoal = null;

   if (sSchTyp.equals("HRS")) {
     sGrpSch = sWkSch.getGrpHrs();
   }
   else {
     sGrpSch = sWkSch.getGrpTim();
   }
   sSlsGoal = sWkSch.getSlsGoal();


   String sGrpAvailJSA = sWkSch.getGrpAvailJSA();

   String [] sWkDate = sWkSch.getWeekDate();
   String [] sShort = sWkSch.getShort();
   String [] sWkDays = new String[]{"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun" } ;
   String [] sDaysOfWeek = new String[]{"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" } ;

   String [] sEmpDay = new String[]{sWkSch.getEmpbyDay(1),sWkSch.getEmpbyDay(2),
              sWkSch.getEmpbyDay(3),sWkSch.getEmpbyDay(4),sWkSch.getEmpbyDay(5),
              sWkSch.getEmpbyDay(6),sWkSch.getEmpbyDay(7)};

   String [] sDailySlsGoal = sWkSch.getDailySlsGoal();
   String [] sDailyOrgGoal = sWkSch.getDailyOrgGoal();
   String [] sSlsGoalHr = sWkSch.getSlsGoalHr();

   String sWeeks = sWkSch.getWeeksJSA();
   String sMonthBegs =  sWkSch.getMonthBegsJSA();
   String sBaseWkJSA = sWkSch.getBaseWksJSA();
   String sBsWkNameJSA = sWkSch.getBsWkNameJSA();
   String sBaseMn = sWkSch.getBaseMonJSA();

   String [] sBaseWk = sWkSch.getBaseWk();
   String [] sBsWkName = sWkSch.getBsWkName();

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

   // get Employees numbers and names
   SetStrEmp StrEmp = null;
   if(sWeekEnd.substring(sWeekEnd.lastIndexOf("/")).equals("2099")) { StrEmp =  new SetStrEmp(sStore,"BASE"); }
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

   int iAll = 0;
   for(int i = 0; i < iNumOfGrp; i++) { iAll += iNumGrpEmp[i]; }
   String [] sAllEmp = new String[iAll];

   iAll = 0;
   for(int i = 0; i < iNumOfGrp; i++)
   {
      for(int j=iAll; j<iNumGrpEmp[i]; j++, iAll++){ sAllEmp[j] = sGrpSch[i][j][0];}
   }

   // Use name of base weeks instead of date
   String sWeekName = sWeekEnd;
   if(sWeekEnd.substring(sWeekEnd.lastIndexOf("/")).equals("2099"))
   {
     for(int i=0; i < sBaseWk.length; i++)
     {
       if (sWeekEnd.equals(sBaseWk[i]))
       {
         sWeekName = sBsWkName[i];
       }
     }
   }

   // number employee working per hour
   String [] sMgrByHrs = sWkSch.getEmpByHrs(0);
   String [] sSlsByHrs = sWkSch.getEmpByHrs(1);
   String [] sNSlByHrs = sWkSch.getEmpByHrs(2);
   String [] sTrnByHrs = sWkSch.getEmpByHrs(3);
   String [] sTotByHrs = sWkSch.getEmpByHrs(4);

   sWkSch.setActSls();
   String [] sActSls = sWkSch.getActSls();


   int iMon = Integer.parseInt(sWeekEnd.substring(0, sWeekEnd.indexOf("/")).trim()) - 1;
   int [] iFysMon = new int[]{10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9};
   String sBaseWkend = null;
   if(iFysMon[iMon] <= 6 ){ sBaseWkend = "01/17/2099";}
   else{ sBaseWkend = "01/24/2099";}

   boolean bAlwBdgAuth = session.getAttribute("NEWPAYROLL") != null;

   boolean bBaseSched = sWeekEnd.indexOf("2099") >= 0;
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
        th.DataTable2 { background:#FFCC99; <%if(bChange){%>cursor: hand;<%}%> padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        td.DataTable2 { color:red; background:cornsilk; <%if(bChange){%>cursor: hand;<%}%> border-top: darkred solid 1px; border-bottom: darkred solid 1px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
        td.DataTable3 { color:red; background:cornsilk; border-top: double darkred;  border-right: darkred solid 1px;padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:11px; font-weight:bold }

        td.DataTable9 { color:red; background:cornsilk; border-top: double darkred; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable10 { color:brown;  <%if(bChange){%>cursor: hand;<%}%> background: Linen; border-top: darkred solid 1px; border-bottom: darkred solid 1px; padding-top:0px; padding-bottom:0px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable11 { color:red; background:cornsilk; <%if(bChange){%>cursor: hand;<%}%> border-top: double darkred; border-bottom: darkred solid 1px;  border-right: darkred solid 1px;padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:11px; font-weight:bold}
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
              border: black solid 2px; width:150px; background-color:LemonChiffon;
              text-align:center; font-size:10px}
        div.MsgBrd { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:110px; height:25px;
              background-color:Azure; z-index:10;
              text-align:center; font-size:10px}


        td.Menu   {border-bottom: black solid 1px; <%if(bChange){%>cursor: hand;<%}%> text-align:left; font-family:Arial; font-size:10px; }
        td.Menu1  {border-bottom: black solid 1px; text-align:left; font-family:Arial; font-size:12px; }
        td.Menu2  {text-align:right; font-family:Arial; font-size:12px; }
        td.Menu3  {border-bottom: black solid 1px; text-align:left; font-family:Arial; font-size:10px; }

        td.MsgBrd   {border-bottom: black solid 1px; font-family:Arial; font-size:10px; }
        td.MsgBrd1   {font-family:Arial; font-size:10px; }

        tr.BSVar { font-size:10px; }
        tr.BSVar1 { background:azure; font-size:10px; }
        td.BSVar { text-align:left; }
        td.BSVar1 { text-align:right; }
        td.BSVar11 { color: red; text-align:right; }
        td.BSVar2 { text-align:center; }

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
        td.DataTable { background:#e7e7e7; <%if(bChange){%>cursor: hand;<%}%> padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
	td.DataTable1 { background:#e7e7e7; <%if(bChange){%>cursor: hand;<%}%> padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable4 { background:#e7e7e7; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable6 { background: #afdcec; <%if(bChange){%>cursor: hand;<%}%> padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-style: italic; font-size:10px }
        td.DataTable7 { background: #99c68e; <%if(bChange){%>cursor: hand;<%}%> padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-style: italic; font-size:10px }
        td.DataTable8 { background: gold; <%if(bChange){%>cursor: hand;<%}%> padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-style: italic; font-size:10px }
        div.dvBdgVsSchedVar { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon;
              text-align:center; font-size:10px}
        div.dvClinic { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon;
              text-align:center; font-size:10px}
        div.CmdButton { position:absolute; visibility:hidden; background-attachment: scroll;
              width:100px; height:50px; text-align:center; font-size:10px}
}

@media print {
        td.DataTable {   border-bottom: darkred solid 1px; background:#e7e7e7; cursor: hand; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
	td.DataTable1 {  border-bottom: darkred solid 1px;background:#e7e7e7; cursor: hand; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable4 {  border-bottom: darkred solid 1px;background:#e7e7e7; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable6 {  border-bottom: darkred solid 1px;background: #afdcec; cursor: hand; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-style: italic; font-size:10px }
        td.DataTable7 {  border-bottom: darkred solid 1px;background: #99c68e; cursor: hand; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-style: italic; font-size:10px }
        td.DataTable8 {  border-bottom: darkred solid 1px;background: gold; cursor: hand; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-style: italic; font-size:10px }
        div.dvBdgVsSchedVar { display:none; }
        div.dvClinic { display:none; }
        div.CmdButton { display:none; }
}

</style>

<SCRIPT language="JavaScript1.2">
//==============================================================================
// Global variables
//==============================================================================
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
var BaseSched = <%=bBaseSched%>
var GrpLst = [<%=sWkSch.getGrpLstJSA()%>];
var GrpName = [<%=sWkSch.getGrpNameJSA()%>];
var GrpSecLst = [<%=sWkSch.getGrpSecLstJSA()%>];
var GrpSecName = [<%=sWkSch.getGrpSecNameJSA()%>];
var GrpEmp = [<%=sWkSch.getGrpEmpJSA()%>];

var GrpAvail = [<%=sGrpAvailJSA%>]

var EmpNum = new Array(<%=sEmpNum.length%>)
var EmpName = new Array(<%=sEmpName.length%>)
var DptName = new Array(<%=sDptName.length%>)
var TimeOffType = [<%=sTimeOffTypeJSA%>];
var DayAvail = [<%=sDayAvailJSA%>];
var From = "<%=sFrom%>"
var DptType = new Array(<%=sDptType.length%>)
var SelDays;

<%for(int i=0; i < sEmpNum.length; i++){%>EmpNum[<%=i%>] = "<%=sEmpNum[i]%>";  EmpName[<%=i%>] = "<%=sEmpName[i]%>"; DptName[<%=i%>] = "<%=sDptName[i]%>";   DptType[<%=i%>] = "<%=sDptType[i]%>";<%}%>

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

var WkDate = new Array(<%=sWkDate.length%>);
<%for(int i=0; i < sWkDate.length; i++){%>
    WkDate[<%=i%>] = "<%=sWkDate[i]%>"
<%}%>

var NewHire = "<%=sNewHire%>"
var WkDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

var Events = [<%=sEventsJSA%>];
var EvtDay = [<%=sEvtDayJSA%>];
var EvtTime = [<%=sEvtTimeJSA%>];
//var Events = [<%=sEventsJSA%>];
var EvtCmt = [<%=sEvtCmtJSA%>];

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

var TrnByHrs = new Array(7);
<%for(int i=0; i<7; i++){%>
  TrnByHrs[<%=i%>] = [<%=sTrnByHrs[i]%>]
<%}%>

var TotByHrs = new Array(7);
<%for(int i=0; i<7; i++){%>
  TotByHrs[<%=i%>] = [<%=sTotByHrs[i]%>]
<%}%>

var selectedEmployee
var selectedGrp
var selectedGrpName
var selectedHrsType = new Array(7);
var selectedTimOffType
var selAvlReq = false;
var selEmpNumAvl = null;
var selDayAvl = null;
var selTimAvl = null;

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

var Access = <%=bAccess%>;
var Allow = "NO"

var NegativeBdgVar = false;

empDayHrsCopy = null;

//==============================================================================
// initialize at begg=inning
//==============================================================================
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
  <%if(bChange){%> chkMsgBoard(); <%}%>
  chkClinics();

  //addButton();
  <%if(bChange && bAccess){%>addWkBudget();<%}%>
  <%if(bAccess){%>rtvBdgVsSched(); <%}%>
}
//==============================================================================
// retreive budget vs schedule variances
//==============================================================================
function rtvBdgVsSched()
{
   var url="PrBdgSchedVar.jsp?Store=<%=sStore%>"
       + "&Wkend=<%=sWeekEnd%>"

   //alert(url)
   //window.location = url;
   window.frame3.location = url;
}

//==============================================================================
// show budget vs schedule variances
//==============================================================================
function showBdgSchedVar(BdgHrs, SchHrs, HrsVar, PrcVar)
{
  var html = "<table cellPadding='0' cellSpacing='0' width='100%'>"
      html += "<tr align='center'>"
         + "<td class='Grid' nowrap>Budget vs. Schedule</td>"
         + "<td  class='Grid2'>"
         + "<img src='CloseButton.bmp' onclick='javascript:hidedvBdgVsSchedVar();' alt='Close'>"
         + "</td></tr>"
         + "<tr>"
         + "<td colspan=2>" + popBdgVsSchedVarPanel(BdgHrs, SchHrs, HrsVar) + "</td></tr>"

  html += "</table>"

  var curLeft = 0;
  var curTop = 0;
  var obj = document.all.thTotal
  while (obj.offsetParent)
  {
    curLeft += obj.offsetLeft
    curTop += obj.offsetTop
    obj = obj.offsetParent;
  }

  document.all.dvBdgVsSchedVar.innerHTML=html
  //document.all.dvBdgVsSchedVar.style.pixelLeft= curLeft + 48;
  //document.all.dvBdgVsSchedVar.style.pixelTop= curTop;
  document.all.dvBdgVsSchedVar.style.pixelLeft=10;
  document.all.dvBdgVsSchedVar.style.pixelTop=110;
  document.all.dvBdgVsSchedVar.style.visibility="visible"

  window.frame3.close();

  if(NegativeBdgVar)
  {
     if(PrcVar > 5 || PrcVar < -5){ alert("Warrning!\nScheduled hours exceed the Allowable Budget\nmore than on 5%."); }
  }
}
//==============================================================================
// populate clinic panel
//==============================================================================
function popBdgVsSchedVarPanel(BdgHrs, SchHrs, HrsVar)
{
   var html = "<table border=1 cellPadding='0' cellSpacing='0' width='100%'>"
            + "<tr class='DataTable'>"
              + "<th class='DataTable'>&nbsp;</th>"
              + "<th class='DataTable'>Allowable<br>Budget</th>"
              + "<th class='DataTable'>Schedule</th>"
              + "<th class='DataTable'>Variance</th>"
            + "</tr>";

   var color = "";
   if (HrsVar.indexOf("-") > 0){ color = "1"; NegativeBdgVar = true;} // show negative variance in red

   html += "<tr class='BSVar'>"
           + "<th class='DataTable'>Hours</th>"
           + "<td nowrap class='BSVar1'>" + BdgHrs + "</td>"
           + "<td nowrap class='BSVar1'>" + SchHrs + "</td>"
           + "<td nowrap class='BSVar1" + color + "'>" + HrsVar + "</td>"
         + "</tr>";
   // show budget and schedule amount only to managers
   html += "<tr class='BSVar1'>"
           + "<td colspan=4 nowrap >Note: Exclude salaried employees and H,S,V,B.</td>"
         + "</tr>";

   html += "</tr></table>"
   return html
}



//==============================================================================
// add Budget Link
//==============================================================================
function addWkBudget()
{
   var html = "<table border=1 style='font-size:10px' cellPadding='0' cellSpacing='0'>"
       + "<tr>"
         + "<td nowrap><a target='_blank' href='WkBdgHrs.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>'>Weekly Budget<a></td>"
       + "</tr>"
       + "<tr>"
         + "<td nowrap><a a target='_blank' href='PrWkSched.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sBaseWkend%>'>Base Schedule<a></td>"
       + "</tr>"

   <%if(bAlwBdgAuth){%>
      html += "<tr>"
              + "<td nowrap><a a target='_blank' href='BdgSchActWk.jsp?Store=<%=sStore%>&StrName=<%=sThisStrName%>&Wkend=<%=sWeekEnd%>'>Allowable Budget<a></td>"
            + "</tr>"
   <%}%>
   html += "</table>"

   document.all.CmdButton.innerHTML=html
   document.all.CmdButton.style.pixelLeft=5
   document.all.CmdButton.style.pixelTop=300
   document.all.CmdButton.style.visibility="visible"
}

//==============================================================================
// add Button
//==============================================================================
function addButton()
{
   var html = "<button class='small' onclick='showSchedVsActual()'>Budget Sales vs.<br>Sched</button>"
   document.all.CmdButton1.innerHTML=html
   document.all.CmdButton1.style.pixelLeft=10
   document.all.CmdButton1.style.pixelTop=500
   document.all.CmdButton1.style.visibility="visible"
}
//==============================================================================
// show Schedule vs budget sales (Correlation Coefficient)
//==============================================================================
function showSchedVsActual()
{
    var url = "PrSlsToHrsCorrelation.jsp?Store=<%=sStore%>&Wkend=<%=sWeekEnd%>";
    var WindowName = 'Budget_Sales_vs_Schedule';
    var WindowOptions = 'width=900, height=600,left=10,top=10, toolbar=yes,location=yes,directories=yes,status=yes,menubar=yes,scrollbars=yes,copyhistory=no, resizable=yes';
    window.open(url, WindowName, WindowOptions);
}
//==============================================================================
// Show Hours or Schedule
//==============================================================================
function chgSch(type){
 var schtyp = null;
 if (type.value == "Hours")  schtyp = 'HRS';
 else schtyp = 'TIM';
 var loc = "PrWkSched.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>"
         + "&SCHTYP=" + schtyp
         + "&SHWGOAL=<%=sShwGoal%>";
 window.location.href = loc
}

//==============================================================================
// Show/Hide Sales Goal
//==============================================================================
function dspGoal(type)
{
 var shwgoal = type.value.substring(0,1)
 var loc = "PrWkSched.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>"
         + "&SCHTYP=<%=sSchTyp%>"
         + "&SHWGOAL=" + shwgoal;
  //alert(loc)
 window.location.href = loc
}
//==============================================================================
// display another week
//==============================================================================
function chgSelDate()
{
 var selIdx = document.all.newDate.options.selectedIndex;
 var newWeekEnd = document.all.newDate.options[selIdx].value;
 var mon = null;
 if(MonthBegs.length > selIdx){ mon = MonthBegs[selIdx]; }
 else{ mon = BaseMn[selIdx - MonthBegs.length]; }

 var loc = "PrWkSched.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>"
         + "&MONBEG=" + mon
         + "&WEEKEND=" + newWeekEnd
         + "&SCHTYP=<%=sSchTyp%>" + "&SHWGOAL=<%=sShwGoal%>";
 //alert(loc)
 hidetip2();
 window.location.href = loc
}
//==============================================================================
// Show day selection menu
//==============================================================================
function ShowMenu(obj, igrp, iemp, iday, goal, tmOff)
{
 var day;
 var grp;
 var grpname;
 var selAvlReq = false;

 if (tmOff!=null) selectedTimOffType = tmOff;

 var subgrp=null;
 var curLeft = 0;
 var curTop = 0;
 var MenuHtml;
 var MenuGoal= " ";
 var MenuEmp = " ";
 var MenuGrp = " ";
 var MenuSub = " ";
 var MenuAdd = " ";
 var MenuNew = " ";
 var MenuVac = " ";
 var MenuHol = " ";
 var MenuOff = " ";
 var MenuDel = " ";
 var MenuCpy = " ";
 var MenuCpyDly = " ";
 var MenuPasteDly = " ";
 var MenuMov = " ";
 var MenuAvl = " ";

 if(igrp != null && iemp != null){ emp = GrpEmp[igrp][iemp]; grp = GrpLst[igrp]; grpname = GrpName[igrp];  }
 else if(igrp != null){ grp = GrpLst[igrp]; grpname = GrpName[igrp];  }

 // customize menu options depend on selected employee group
 MenuGrp = "<tr><td class='Menu3' colspan='2' align='center'>Group:" + GrpSecName[igrp] + "</td></tr>";
 MenuSub = "<tr><td class='Menu3' colspan='2' align='center'>Sub-Group:" + GrpName[igrp] + "</td></tr>";

 if(igrp != null && iemp != null){ MenuEmp = "<td class='Menu1' nowrap><b>" + GrpEmp[igrp][iemp] + "</b>" + "</td>"; }
 else if(igrp != null && iemp == null)
 {
   MenuEmp = "<td class='Menu1' nowrap><b>Group: " + GrpSecName[igrp] + "</b>" + "</td>";
   MenuGrp = "";
 }
 else
 {
   MenuEmp = "<td class='Menu1' nowrap><b>Store</b></td>";
   MenuGrp = "";
   MenuSub = "";
 }

 // customize menu options for selected employee day
 if(iday != null)
 {
   //day = obj.id.substring(44);
   day = WkDate[iday];
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

   // check if copy hours allowed
   if(isCopyHrsAllowed(obj, emp, grp, day)){
       MenuCpyDly = "<tr><td colspan='2' class='Menu' align='center' "
              + "onclick='copyDlyHrs(&#34;"
              + emp + "&#34;, &#34;" + grp + "&#34;, &#34;" + day + "&#34;); hideMenu();'>Copy Hours"
              + "</td></tr>"
   }

   // check if Paste is allowed
   if(isPasteHrsAllowed(obj, emp, grp, day)){
       MenuPasteDly = "<tr><td colspan='2' class='Menu' align='center' "
              + "onclick='pasteDlyHrs(&#34;"
              + emp + "&#34;, &#34;" + grp + "&#34;, &#34;" + day + "&#34;); hideMenu();'>Paste Hours"
              + "</td></tr>"
   }

   MenuAvl = setAvail(GrpEmp[igrp][iemp], igrp);

   if(GrpSecLst[igrp] == 'SLSP')
   {
      MenuGoal= "<tr><td class='Menu' colspan='2' align='center'>" + "Sales Goal: " + goal + "</td></tr>";
   }
 }


 // customize menu options for selected employee
 else if(iemp != null){
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

   MenuAvl = setAvail(GrpEmp[igrp][iemp], igrp);
 }
 // customize menu options for selected group
 else if(igrp != null){
   MenuAdd = "<tr><td class='Menu' colspan='2' align='center' "
           + "onclick='addNew(&#34;" + grp + "&#34;, &#34;"
           + grpname + "&#34;, "
           + "&#34;" + subgrp + "&#34;"
           + ");hideMenu();'>Add/Override"
           + "</td></tr>";
   if (GrpLst[igrp] == "NSLOT" || GrpLst[igrp] == "TRAIN")
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
   MenuDel = "<tr><td colspan='2' class='Menu' align='center' "
           + "onclick='dltEntry(&#34;"
           + "GRP&#34;, &#34;" + grp + "&#34;, null, &#34;GRPWEEK&#34;);hideMenu();'>Delete whole week"
           + "</td></tr>"
 }
 // customize menu options for store
 else if(igrp == null){
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
   + MenuMov + MenuDel + MenuAvl + MenuCpyDly + MenuPasteDly
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
//==============================================================================
// check if selected cell has already selected hours
//==============================================================================
function isCopyHrsAllowed(obj, emp, grp, day)
{
   return Allow=="YES" && obj.innerHTML != "&nbsp; ";
}
//==============================================================================
// save copied Hours
//==============================================================================
function copyDlyHrs(emp, grp, day)
{
   empDayHrsCopy = new EmpDayHrs(emp, grp, day);
}

//==============================================================================
// check if paste hours function is allowed on menu
//==============================================================================
function isPasteHrsAllowed(obj, emp, grp, day)
{
   var allow = empDayHrsCopy != null;
   return allow;
}
//==============================================================================
// paste copied hours in selected cells
//==============================================================================
function pasteDlyHrs(emp, grp, day)
{
    // change action string
    var url = "PrSavSchedEntCopy.jsp?STORE=" + CurStore
          + "&STRNAME=" + CurStrName
          + "&MONBEG=" + Month
          + "&WEEKEND=" + WeekEnd

          + "&CPYEMP=" + empDayHrsCopy.getEmpName()
          + "&CPYGRP=" + empDayHrsCopy.getGroup()
          + "&CPYDAY=" + empDayHrsCopy.getDay()

          + "&TOEMP=" + emp
          + "&TOGRP=" + grp
          + "&TODAY=" + day

          + "&ACTION=PASTEHRS"
  //alert(url)
  //window.location.href = url;
  window.frame1.location.href = url;
}
//==============================================================================
// reload this page
//==============================================================================
function reloadPage(){ window.location.reload(); }
//==============================================================================
// show selection menu for events section
//==============================================================================
function ShowEvtMenu(obj, EvtNum)
{
   var MenuName = null;
   var MenuDlt = null;
   var MenuAdd = null;
   var MenuDsp = " ";
   var MenuAttach = " ";

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

     MenuAttach = "<tr><td class='Menu' onclick='addEmpForEvent(&#34;"
      + EvtNum + "&#34;," + EvtDay[EvtNum] + "); hideMenu();'>Attach Employees</td></tr>";
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
   + MenuAttach
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
//==============================================================================
// add Employee for selected event
//==============================================================================
function addEmpForEvent(evt, day)
{
    var dummy="<table>"
    var html = "<table cellPadding='0' cellSpacing='0'>"

    html += "<tr align='center'>"
         + "<td class='Grid' nowrap>Select Employees for Event in Training"
       + "</td>"


    html += "<td  class='Grid'>"
         + "<img src='CloseButton.bmp' onclick='javascript:hidetip2();' alt='Close'>"
         + "</td></tr>"

    html += "<tr style='font-size:5px;'><td colspan=2>&nbsp;</td></tr>"


    html += "<tr align='center'><td>"
    html += popEmployeeSelList();
    html += showTimeEntryForEvent(evt, day);

    html += "</td></tr>"
    + "<tr align='center'><td>"
      + "&nbsp;&nbsp;<button class='small' onclick='ValidateEvtEmp(&#34;" + evt + "&#34;, &#34;"
      + day + "&#34;)'>Add Employees</button>"
      + "&nbsp;&nbsp;<button class='small' name='close' onclick='hidetip2()'>Close</button><br>&nbsp;</td></tr>"
    + "</table>"

    document.all.tooltip2.innerHTML=html
    document.all.tooltip2.style.pixelLeft=100
    document.all.tooltip2.style.pixelTop=document.documentElement.scrollTop+50
    document.all.tooltip2.style.visibility="visible"
}
//==============================================================================
// populate employee selection list
//==============================================================================
function popEmployeeSelList()
{
    var dummy = "<table>"
    var html = "<table border=1 cellPadding='0' cellSpacing='0'>"


    for(var i=0, j=0; i < EmpNum.length;i++)
    {
       if(j==0){ html += "<tr>" }

       html += "<td style='text-align:left; font-size:10px;' nowrap>"
          + "<input name='selEmp' type='checkbox' value='" +  EmpNum[i] + "'>"
          + EmpName[i] + "</td>"

       if(j==4){ html += "</tr>"; j=0;}
       else { j++; }
    }

    html += "<tr><td style='text-align:center; font-size:10px;' colspan=5>"
      + "<button class='small' onClick='selAllEvtEmp(true)'>Select All</button>"
      + "<button class='small' onClick='selAllEvtEmp(false)'>Reset</button>"
      + "</td></tr>"
     + "</table>"
    return html;
}
//==============================================================================
// time entry for selected employee for selected event and date
//==============================================================================
function showTimeEntryForEvent(evt, day)
{

   var entryTimeHtml = "<form name='HRSENTRY' method='GET' >"

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
      + "<td class='EntTbl'>&nbsp;</td>"

       <% for(int i=0; i < sHrs.length; i++){ %>
         <% for(int k=0; k < sMin.length; k++){%>
      +  "<td class='EntTbl1' id='<%=sHrs[i]%><%=sMin[k]%>' onclick='enterTime(this, false);'>&nbsp;</td>"
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

      entryTimeHtml += "</table></form>"

  var dummy = "<table>"

  return entryTimeHtml;
}
//==============================================================================
// check/reset all store employees for this event
//==============================================================================
function selAllEvtEmp(chk)
{
   var emp = document.all.selEmp
   for(var i=0; i < emp.length; i++) { emp[i].checked = chk; }
}

//==============================================================================
// Validate "employees to event attachment process"
//==============================================================================
function ValidateEvtEmp(evt, day)
{
   var error = false;
   var msg = "";

   // validate employee entry
   var emp = document.all.selEmp
   var selemp = false;
   var emplist = new Array();
   for(var i=0, j=0; i < emp.length; i++)
   {
      if(emp[i].checked) { emplist[j] = emp[i].value; j++; selemp = true; }
   }

   if (!selemp) {error = true; msg += "Please, select at least 1 employee.\n"}

   // check Begining/Ending Time
   if (BegTime <= " ") { error = true; msg += "Please enter beginning time. \n"; }
   if (EndTime <= " ") { error = true; msg += "Please enter ending time. \n";  }


   if(error) { alert(msg); }
   else { sbmEvtEmpEntry(evt, day, emplist) }
}
//==============================================================================
// submit selected employee for selected event
//==============================================================================
function sbmEvtEmpEntry(evt, day, emplist)
{
   var url="PrEmpEvtSave.jsp?Str=" + CurStore
       + "&EvtDate=" + WkDate[EvtDay[evt]]
       + "&EvtTime=" + EvtTime[evt]
       + "&Evt=" + Events[evt]

   for(var i=0; i < emplist.length; i++)
   {
      url += "&Emp=" + emplist[i];
   }

   url += "&BegTime=" + BegTime
        + "&EndTime=" + EndTime;

   //alert(url)
   //window.location = url;
   window.frame1.location = url;
}
//==============================================================================
// return from entered employees for event
//==============================================================================
function rtnEmpEvt(err)
{
   var msg = "";

   for(var i=0; i < err.length; i++) { msg += err[i] + "\n"; }
   if(err.length > 0){ alert(msg); }

   window.frame1.close();
   window.location.reload();
}
//==============================================================================
// dispaly Event details
//==============================================================================
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
    document.all.tooltip2.style.pixelLeft=50
    document.all.tooltip2.style.pixelTop=document.documentElement.scrollTop+200
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
//==============================================================================
// Set availability menu option for selected employee
//==============================================================================
function setAvail(emp, igrp)
{
  var MenuAvl= " ";
  var Avl = GrpAvail[igrp];

  for(i = 0; i < Avl.length; i++)
  {
    if(Avl[i] == "A")
    {
      MenuAvl = "<tr><td colspan='2' class='Menu' align='center' "
           + "onclick='getAvail(&#34;" + emp + "&#34;, &#34;setEmpAvail&#34;); hideMenu();'>Availability"
           + "</td></tr>";
      selAvlReq = true;
      break;
    }
  }
  return MenuAvl;
}
//==============================================================================
// retreive employee availability
//==============================================================================
function getAvail(emp, func)
{
  var MyURL = 'GetAvail.jsp?EMPNUM=' + emp + "&FUNCTION=" + func;
  var MyWindowName = 'GetaAvail';
  var MyWindowOptions =
     'width=400,height=150, left=180,top=80, toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,resize=no,menubar=no';
  window.open(MyURL, MyWindowName, MyWindowOptions);
}
//==============================================================================
// show employee availability
//==============================================================================
function setEmpAvail(emp, DayAvail, TimAvail)
{
   selEmpNumAvl = emp;
   selDayAvl = new Array(7);
   selTimAvl = new Array(7);
   for(i=0; i<7; i++) { selDayAvl[i] = DayAvail[i]; selTimAvl[i] = TimAvail[i]; }

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
//==============================================================================
// get employee and days
//==============================================================================
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

//==============================================================================
// validate Employee Day Selection
//==============================================================================
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
//==============================================================================
// retreive employee availability
//==============================================================================
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
//==============================================================================
// set color to green - all available
//==============================================================================
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
//==============================================================================
// show employee availability
//==============================================================================
function setSelEmpAvl(emp, DayAvail, TimAvail)
{
  var avl = [document.all.Avl1, document.all.Avl2, document.all.Avl3, document.all.Avl4,
             document.all.Avl5, document.all.Avl6, document.all.Avl7];
  if(emp!=null)
  {
     selEmpNumAvl = emp;
     selDayAvl = new Array(7);
     selTimAvl = new Array(7);
     for(i=0; i<7; i++) { selDayAvl[i] = DayAvail[i]; selTimAvl[i] = TimAvail[i]; }
  }


  for(i=0; i<7; i++)
  {
    avl[i].innerHTML="&nbsp;";

    if(selDayAvl[i]=="0") { avl[i].style.background="green"; }
    else if(selDayAvl[i]=="1")  {avl[i].style.background="red"; }
    else if(selDayAvl[i]=="2")
    {
      avl[i].style.background="#FFE4C4";
      avl[i].innerHTML=selTimAvl[i];
    }
  }
}
//==============================================================================
// Open prompt window
//==============================================================================
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
//==============================================================================
// move employee to different group
//==============================================================================
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

  for(var i=0; i < GrpLst.length; i++)
  {
     document.all.newGroup.options[i] = new Option(GrpName[i], GrpLst[i])
  }
}

//==============================================================================
// check all day as selected for input
//==============================================================================
function chgAlldays(check)
{ document.all('DAY1').checked=check; document.all('DAY2').checked=check
  document.all('DAY3').checked=check; document.all('DAY4').checked=check
  document.all('DAY5').checked=check; document.all('DAY6').checked=check;
  document.all('DAY7').checked=check;
}
//==============================================================================
// get employee and days
//==============================================================================
function getEmpDaySel(grp, grpname, emp, day)
{
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
   for(i=0;i<7;i++)
   {
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
// add time for selected employee and date
//==============================================================================
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
      +  "<td class='EntTbl1' id='<%=sHrs[i]%><%=sMin[k]%>' onclick='enterTime(this, true);'>&nbsp;</td>"
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

      if (selAvlReq)
      {
         entryTimeHtml += "<table border=1 style='font-size:10px' cellPadding='0' cellSpacing='0'>"
           + "<tr><td rowspan='2'>Availability by Days:</td>"
             + "<td>Monday</td>"
             + "<td>Tuesday</td>"
             + "<td>Wednesday</td>"
             + "<td>Thursday</td>"
             + "<td>Friday</td>"
             + "<td>Saturday</td>"
             + "<td>Sunday</td>"
           + "</tr>"
           + "<tr>"
             + "<td nowrap><div id='Avl1'></div></td>"
             + "<td nowrap><div id='Avl2'></div></td>"
             + "<td nowrap><div id='Avl3'></div></td>"
             + "<td nowrap><div id='Avl4'></div></td>"
             + "<td nowrap><div id='Avl5'></div></td>"
             + "<td nowrap><div id='Avl6'></div></td>"
             + "<td nowrap><div id='Avl7'></div></td>"
           + "</tr>"
         + "</table>"
      }

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

    if (selAvlReq && selEmpNumAvl.substring(0,4) == selectedEmployee.substring(0,4) && selDayAvl != null) { setSelEmpAvl(null, null, null) }
    else if (selAvlReq) { getAvail(selectedEmployee.substring(0,4), "setSelEmpAvl") }
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
  var TrnNum = TrnByHrs[Day];
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

//==============================================================================
// display group by hour
//==============================================================================
function dspGrpbyHr(sec, secnm)
{
  var curLeft = document.documentElement.scrollLeft+ 100;
  var curTop = 20;
  var hrs = ["07am", "08am", "09am", "10am", "11am", "12pm", "01pm", "02pm", "03pm", "04pm", "05pm", "06pm", "07pm", "08pm", "09pm", "10pm", "11pm", "12am"];
  var grpname = secnm;

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
      if (sec==0) empHrHtml += "<th class='EntTbl'>" + WkDays[i] + "</th>"
    }
    + "</tr>";

  var cnt = 0;

  for(i=0; i < 18; i++)
  {
      empHrHtml +="<tr>"
        + "<td class='EntTbl'>" + hrs[i] + "</td>"
      for(j=0; j < 7; j++)
      {
         if(sec== 0) empHrHtml += "<td class='EntTbl'>" + MgrByHrs[j][i] + "</td>"
         if(sec== 1) empHrHtml += "<td class='EntTbl'>" + SlsByHrs[j][i] + "</td>"
         if(sec== 2) empHrHtml += "<td class='EntTbl'>" + NSlByHrs[j][i] + "</td>"
         if(sec== 3) empHrHtml += "<td class='EntTbl'>" + TrnByHrs[j][i] + "</td>"
         if(sec== 4) empHrHtml += "<td class='EntTbl'>" + TotByHrs[j][i] + "</td>"
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
//==============================================================================
// close employee selection window
//==============================================================================
function hidetip2(){
    document.all.tooltip2.style.visibility="hidden"
}
//==============================================================================
// load employee list in selection field
//==============================================================================
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
//==============================================================================
// save entered regular time
//==============================================================================
function enterTime(cur, nonevt){
 var id = cur.id;
 document.forms[0].ResetEntry.disabled = false;
 if(nonevt)
 {
   document.forms[0].Regular.disabled = false;

   if (document.forms[0].Vacation!=null) document.forms[0].Vacation.disabled = true;
   if (document.forms[0].Holiday!=null) document.forms[0].Holiday.disabled = true;
   document.forms[0].ReqOff.disabled = true;
 }

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
//==============================================================================
// Update readonly field that show selected times
//==============================================================================
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
//==============================================================================
// save entered vacation/holiday/request off time
//==============================================================================
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
  //if (ovr=='CHK' && isEmpTimeOverlaped(day)){
  //    msg += "Selected employee already scheduled for this day. \n";
  //}

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
// check, if new entry is new or override existing one
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
  return alreadysched;
}
//==============================================================================
// check, if new entry is new or override existing one
//==============================================================================
function isEmpTimeOverlaped(day)
{
  //alert(day + " " + selectedEmployee)
  return false;
}

//==============================================================================
// change Sales Goial
//==============================================================================
function chgSlsGoal(day)
{
  var dayOfweek = "Every Day";
  if (day < 7){ dayOfweek = WkDays[day]; }

  var html = "<table cellPadding='0' border=0 cellSpacing='0' width='100%'>"
      html += "<tr align='center'>"
         + "<td class='Grid' nowrap>Change Sales Goal: " + dayOfweek + "</td>"
         + "<td  class='Grid2'>"
         + "<img src='CloseButton.bmp' onclick='javascript:hidedvSlsGoal();' alt='Close'>"
         + "</td></tr>"
         + "<tr>"
         + "<td colspan=2>" + popChgSlsGoalPanel(day) + "</td></tr>"

  html += "</table>"

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
            + "<tr>"
              + "<td class='EntTbl' nowrap >&nbsp; Percents &nbsp;</th>"
              + "<td class='EntTbl' nowrap>&nbsp; <input class='small' name='NewSlsGoal'> &nbsp;</th>"
            + "</tr>"
            + "<tr>"
              + "<td class='EntTbl' colspan=2>"
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
     + "&Wkend=<%=sWeekEnd%>"
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
// save entered time
//==============================================================================
function submit(){
  var selEmpNum = selectedEmployee.substring(0,4)
  var selEmpName = selectedEmployee.substring(5);
  hidetip2();

  // change action string
  SbmString = "PrSavSchedEnt.jsp?STORE=" + CurStore
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
  if (Allow=="YES") { window.location.href = SbmString; }
  else alert("This week has the APPROVED status. Changes is not allowed");
}

//==============================================================================
// delete employee schedule
//==============================================================================
function dltEntry(emp, grp, day, range){
if(day==null) day=WeekEnd
if(range==null) range=" "
  SbmString = "PrSavSchedEnt.jsp?STORE=" + CurStore
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
 SbmString = "PrSavSchedEnt.jsp?STORE=" + CurStore
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

//==============================================================================
// move employee to another group
//==============================================================================
function moveEmp(emp, grp)
{
 var selIdx = document.all.newGroup.options.selectedIndex;
 var newGroup = document.all.newGroup.options[selIdx].value

 SbmString = "PrSavSchedEnt.jsp?STORE=" + CurStore
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

//==============================================================================
// Request days off employee schedule
//==============================================================================
function genReqOff(emp, grp, day){
  SbmString = "PrSavSchedEnt.jsp?STORE=" + CurStore
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
//==============================================================================
// object - employee daily hours -  used in copy hours function
//==============================================================================
function EmpDayHrs(emp, grp, day)
{
   this.emp = emp;
   this.grp = grp;
   this.day = day;
}
//==============================================================================
// create methods of EmpDayHrs - get name, get group and get Day
//==============================================================================
function EmpDayHrs.prototype.getEmpName(){ return this.emp; }
function EmpDayHrs.prototype.getGroup(){ return this.grp; }
function EmpDayHrs.prototype.getDay(){ return this.day; }
//==============================================================================
//create String method Trim
//==============================================================================
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
    || event.srcElement.className=="CmdButton"
    || event.srcElement.className=="Menu1"){
   while (obj.offsetParent){
     if (obj.id=="menu" || obj.id=="tooltip2" || obj.id=="dvClinics" || obj.id=="dvBdgVsSchedVar"
         || obj.id=="dvSlsGoal" || obj.id=="CmdButton" )
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
  //this.focus();
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

  //if(AprvSts != "*APPROVED" || AprvSts == "*APPROVED" && Access)  {  Allow = "YES";  }

  if(AprvSts != "*APPROVED" || AprvSts == "*APPROVED" && Access && !BaseSched)  {  Allow = "YES";  }
}
//==============================================================================
// show number of new messages by store and week
//==============================================================================
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
//==============================================================================
// Check Message board
//==============================================================================
function chkClinics()
{
  var url = "ClinicStrWkLst.jsp?Store=<%=sStore%>&Weekend=<%=sWeekEnd%>&User=<%=sUser%>";

  //alert(url)
  window.frame2.location = url;
}
//==============================================================================
// dhow Clinics for selected store and week
//==============================================================================
function showClinicWeekly(name, date, brand)
{
  var html = "<table cellPadding='0' cellSpacing='0' width='100%'>"
      html += "<tr align='center'>"
         + "<td class='Grid' nowrap>Clinics</td>"
         + "<td  class='Grid2'>"
         + "<img src='CloseButton.bmp' onclick='javascript:hidedvClinics();' alt='Close'>"
         + "</td></tr>"
         + "<tr>"
         + "<td colspan=2>" + popClinicsPanel(name, date, brand) + "</td></tr>"

  html += "</table>"

  document.all.dvClinics.innerHTML=html
  document.all.dvClinics.style.pixelLeft=10;
  document.all.dvClinics.style.pixelTop=410;
  document.all.dvClinics.style.visibility="visible"
}
//==============================================================================
// populate clinic panel
//==============================================================================
function popClinicsPanel(name, date, brand)
{
   var html = "<table class='DataTable' cellPadding='0' cellSpacing='0' width='100%'>"
            + "<tr class='DataTable'>"
              + "<th class='DataTable' colspan=3><a href='javascript: showStrClinic()'>Go to Clinics Calendar</a></th>"
            + "<tr class='DataTable'>"
              + "<th class='DataTable'>Name</th>"
              + "<th class='DataTable'>Date</th>"
              + "<th class='DataTable'>Brand</th>"
            + "</tr>";

   for(var i=0; i < name.length; i++)
   {
      html += "<tr class='DataTable'>"
            + "<td nowrap class='DataTable'>" + name[i] + "</td>"
            + "<td class='DataTable'>" + date[i] + "</td>"
            + "<td nowrap class='DataTable'>" + brand[i] + "</td>"
            + "</tr>"
   }

   html += "</tr></table>"
   return html
}
// ------------------------------------------------------
// show list of clinics approval request
// ------------------------------------------------------
function showStrClinic()
{

   var mon = WeekEnd.substring(0, WeekEnd.indexOf("/") + 1);
   var year = WeekEnd.substring(WeekEnd.indexOf("/", WeekEnd.indexOf("/") + 1) + 1);

   var url = "VendorClinics.jsp?Store=" + CurStore
           + "&MonYr=" + mon + year
   //alert(url)
   window.location.href = url;
}
//==============================================================================
// close clinic list panel
//==============================================================================
function hidedvClinics()
{
    document.all.dvClinics.style.visibility="hidden"
}
//==============================================================================
// close clinic list panel
//==============================================================================
function hidedvBdgVsSchedVar()
{
    document.all.dvBdgVsSchedVar.style.visibility="hidden"
}

//==============================================================================
// return to small size
//==============================================================================
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
          + "&From=PrWkSched.jsp";
  //alert(loc);
  window.location.href=loc;
}
//==============================================================================
//==============================================================================
function EmpAvail(emp, dayavail, timeavail)
{
   this.emp = emp;
   this.dayavail = new Array();
   this.timeavail = new Array();

   for(var i=0; i < dayavail.length; i++)
   {
      this.dayavail[i] = dayavail[i];
      this.timeavail[i] = timeavail[i];
   }
}

</SCRIPT>

</head>
<!-------------------------------------------------------------------->
<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame2"  src="" frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame3"  src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->


  <div id="tooltip2" class="Tootip"></div>
  <div id="menu" class="Menu"></div>
  <div id="msgbrd" class="MsgBrd"></div>
  <div id="dvClinics" class="dvClinic"></div>
  <div id="dvBdgVsSchedVar" class="dvBdgVsSchedVar"></div>
  <div id="dvSlsGoal" class="dvClinic"></div>
  <div id="CmdButton" class="CmdButton"></div>
  <div id="CmdButton1" class="CmdButton"></div>

<!-------------------------------------------------------------------->
  <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin"><td ALIGN="center" VALIGN="TOP" colspan="3">
      <b>Weekly Schedule Summary (Old Schedule)</b>
     </tr>
     <tr bgColor="moccasin">
        <td ALIGN="left" VALIGN="TOP" width="33%"><b>&nbsp;Store:&nbsp;<%=sStore + " - " + sThisStrName%></b></td>
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
        <!--a href="StrScheduling.html"><font color="red" size="-1">Payroll</font></a -->
        <%if(sFrom.equals("AVGPAYREP")){%>
          <a href="APRSelector.jsp"><font color="red" size="-1">Store Selector</font></a>&#62;
          <a href="AvgPayRep.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>">
             <font color="red" size="-1">Average Pay Report</font></a>&#62;
        <%}
        else {%>
          <a href="PrWkSchedSel.jsp"><font color="red" size="-1">Store/Week Selector</font></a>&#62;
        <%}%>
         This page &nbsp;&nbsp;&nbsp;
         <a href="PrtWkSched.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&WEEKEND=<%=sWeekEnd%>" class="blue">Print By Employee Name</a>
        <!------------- start of dollars table ------------------------>

      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable" rowspan="2" colspan="3" >Employee/Title</th>
           <th class="DataTable2" colspan="7" id="ALL"
                <%if(bChange){%> onclick="ShowMenu(this, null, null, null,  '<%=sDailySlsGoal[7]%>', null)"<%}%>>Days</th>
           <th class="DataTable" rowspan="3" id="thTotal" >Total</th>
         </tr>
         <tr>
           <%for(int i=0; i < 7; i++){%>
             <th class="DataTable" >
              <%if(bChange){%>
               <a href="PrDaySched.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWkDate[i]%>&FROM=<%=sFrom%>&WKDAY=<%=sDaysOfWeek[i]%>">
                <%=sShort[i]%></a>
              <%} else {%><%=sShort[i]%><%}%>

             </th>
           <%}%>
         </tr>
         <tr>
           <th class="DataTable1" colspan="3">
            <%if(bChange){%>
                <a href="PrEmpNum.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWkDate[0]%>&FROM=<%=sFrom%>&WKDAY=<%=sDaysOfWeek[0]%>&SELSEC=ALL">
                    Store Coverage</a>
            <%} else{%>&nbsp;<%}%>
           </th>
           <%for(int i=0; i < 7; i++){%>
             <th class="DataTable2" id="EBH<%=i%>" <%if(bChange){%>onClick="dspEmpbyHr(this, '<%=sWkDate[i]%>', '<%=sDaysOfWeek[i]%>')" <%}%>>
                <%=sWkDays[i]%></th>
           <%}%>
         </tr>
     <!-- ------------- Original Daily Sales Goals ---------------- -->
         <tr>
           <th class="DataTable1" colspan="3">
           <%if(bAccess){%>Original Sales Plan<%} else {%>Original Sales Plan<%}%></th>
           <%for(int i=0; i < 8; i++){%>
             <th class="DataTable" >$<%=sDailyOrgGoal[i]%></th>
           <%}%>
         </tr>
     <!-- --------------- Daily Sales Goals ---------------- -->
         <tr>
           <th class="DataTable1" colspan="3">
           <%if(bAccess){%><a href="javascript:chgSlsGoal('7')">Sales Forecast</a><%} else {%>Sales Forecast<%}%></th>
           <%for(int i=0; i < 8; i++){%>
             <th class="DataTable" ><%if(bAccess){%><a href="javascript:chgSlsGoal('<%=i%>')">$<%=sDailySlsGoal[i]%></a><%} else {%>$<%=sDailySlsGoal[i]%><%}%></th>
           <%}%>
         </tr>
     <!-- --------------- Actual Sales --------------------- -->
         <tr>
           <th class="DataTable1" colspan="3">Actual Sales</th>
           <%for(int i=0; i < 8; i++){%>
             <th class="DataTable" ><%=sActSls[i]%></th>
           <%}%>
         </tr>

   <!-- ------------------------ Sections Header ------------------------------------------ -->
   <%int iSec = 0;
     int iSecGrp = 0;
     for(int i=0; i < iNumOfGrp; i++){%>
       <%if(iSecGrp == 0){%>
         <tr>
           <td class="DataTable11" id="SECTION"><%=sSecName[iSec]%></td>
           <td class="DataTable14">
             <%if(sSecLst[iSec].equals("MNGR")){%><%if(bChange){%><a href="javascript:dspGrpbyHr('<%=iSec%>', '<%=sSecName[iSec]%>')">Cov</a><%} else {%>&nbsp;<%}%><%}
               else {%><%if(bChange){%><a href="PrEmpNum.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWkDate[0]%>&FROM=<%=sFrom%>&WKDAY=<%=sDaysOfWeek[0]%>&SELSEC=<%=sSecLst[iSec]%>">Cov</a><%} else {%>&nbsp;<%}%><%}%>
           </td>
           </td>
             <td class="DataTable13" nowrap>Tot Hours</td>
                <%for(int j=0; j< 7; j++){%>
                  <td class="DataTable13" ><%=sSecDay[iSec][j]%></td>
                <%}%>
             <td class="DataTable13" ><%=sSecTot[iSec]%></td>
         </tr>

        <%if(sSecLst[iSec].equals("SELL")){%>
            <tr>
               <td class="DataTable15" colspan=2>&nbsp;</td>
               <td class="DataTable16">Sls/Hour</td>
               <%for(int l=0; l< 7; l++){%>
                  <td class="DataTable16" >$<%=sSlsGoalHr[l]%></td>
               <%}%>
               <td class="DataTable16">$<%=sSlsGoalHr[7]%></td>
            </tr>
        <%}%>
       <%}%>
       <!----------------------- Group Header -------------------------------------------------->
         <tr>
           <td class="DataTable10" colspan="3" id="<%=sGrpLst[i]%>_GP" <%if(bChange){%>onclick="ShowMenu(this, '<%=i%>', null, null, '<%=sDailySlsGoal[7]%>', null)"<%}%> ><%=sGrpName[i]%></td>
           <td class="DataTable17" colspan="8">&nbsp;
              <%if(bChange){%>
                <a href="PrEmpNum.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWkDate[0]%>&FROM=<%=sFrom%>&WKDAY=<%=sDaysOfWeek[0]%>&SELGRP=<%=sGrpLst[i]%>">
                <span style="font-family=Arial; font-size=10px">Cov</span></a>
              <%}%>
           </td>
         </tr>
        <!-- ------------------------ Group Details ----------------------------------- -->
        <%for(int j=0; j < iNumGrpEmp[i]; j++){%>
           <tr>
              <td class="DataTable" id="<%=sGrpLst[i]%>_EMP" <%if(bChange){%>onclick="ShowMenu(this, '<%=i%>', '<%=j%>', null, null, '<%=sGrpTimOff[i][j]%>')"<%}%>>
                  <font color="<%=sGrpMltClr[i][j]%>"><%=sGrpEmp[i][j]%>
                  <sup><%=sGrpOvr7[i][j]+sGrpAvail[i][j]%></sup><%=sGrpMlt[i][j]%></font></td>

              <td class="DataTable4" colspan="2"><%=sGrpTtl[i][j]%></td>
              <%for(int k=0; k < 7; k++)
              {
                String skClass = "DataTable";
                String skValue = sGrpSch[i][j][k];

                if(sGrpHTyp[i][j][k].equals("VAC")){ skClass += "6"; skValue = "Vacation"; }
                else if(sGrpHTyp[i][j][k].equals("HOL")){ skClass += "7"; skValue = "Holiday"; }
                else if(sGrpHTyp[i][j][k].equals("OFF")){ skClass += "8"; skValue = "Request Off"; }
                else { skClass += "1";}
             %>
                <td class="<%=skClass%>" <%if(bChange){%> id="tdHrs" onclick="ShowMenu(this, '<%=i%>', '<%=j%>', '<%=k%>', '0', '<%=sGrpTimOff[i][j]%>')" <%}%> nowrap><%=skValue%>
                   <%if(sGrpHTyp[i][j][k].equals("REG") && sSecLst[iSec].equals("SELL") && sShwGoal.equals("S") && sSlsGoal[i][j] != null){%>
                       <br><%=sSlsGoal[i][j][k]%><%}%>
                </td>
                </td>
              <%}%>
              <td class="DataTable4"><font color="<%=sWkSch.chkOvrTim(sGrpEmp[i][j])[0]%>"><%=sGrpEmpTot[i][j]%><%=sWkSch.chkOvrTim(sGrpEmp[i][j])[1]%></font></td>
           </tr>
       <%}%>

       <%
            iSecGrp++;
            if (iSecGrp == iNumSecGrp[iSec]){ iSecGrp = 0; iSec++; }
         }
       %>

      <!-- ========================== Table total ========================================== -->
      <tr>
       <td class="Total" >Total</td>
       <td class="Total2">
       <%if(bChange){%><a href="javascript:dspGrpbyHr(4)">Cov</a><%} else {%>&nbsp;<%}%>
       </td>
       <td class="Total1">&nbsp;</td>
       <%for(int i=0; i< 7; i++){%>
           <td class="Total1" ><%=sTotDay[i]%></td>
        <%}%>
       <td class="Total1"><%=sRepTot%></td>
      </tr>
      <tr>
           <th class="DataTable1" colspan="3">
              <%if(bChange){%>
                 <a href="PrEmpNum.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWkDate[0]%>&FROM=<%=sFrom%>&WKDAY=<%=sDaysOfWeek[0]%>&SELSEC=ALL">
                 Store Coverage</a>
              <%} else {%>&nbsp;<%}%>
           </th>
           <%for(int i=0; i < 7; i++){%>
             <th class="DataTable2" id="EBH<%=i%>" <%if(bChange){%>onClick="dspEmpbyHr(this, '<%=sWkDate[i]%>', '<%=sDaysOfWeek[i]%>')"<%}%>>
               <!--a href="EmpNumbyHour.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWkDate[i]%>&FROM=<%=sFrom%>&WKDAY=<%=sDaysOfWeek[i]%>"-->
                <%=sWkDays[i]%></th>
           <%}%>
           <th class="DataTable2">&nbsp;</th>
      </tr>

      <!-- --------------- Store Weekly Events ---------------- -->
      <tr>
       <td class="DataTable11" id="EVTGP" colspan="11"
          <%if(bChange){%>onclick="ShowEvtMenu(this, null, null)"<%}%>>Events</td>
      </tr>

      <!-- --------------- Store Weekly Event Details ---------------- -->
      <%for(int i=0; i < iNumOfEvt; i++){%>
         <tr>
          <td class="DataTable" id="EVT<%=sEvents[i]%>" colspan="3"
              <%if(bChange){%>onclick="ShowEvtMenu(this, <%=i%>, null)"<%}%> >
             <%=sEvents[i]%></td>
          <%for(int k=0; k < 7; k++){%>
          <%if (iEvtDay[i] == k){%>
              <td class="DataTable1" id="EVTDT<%=i%>"
                  <%if(bChange){%>onclick="ShowEvtMenu(this, <%=i%>)"<%}%>><%=sEvtTime[i]%></td>
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

       <%if(bChange){%>
          <br><font size="-1">Click here to see the Monthly</font>
             <a href="PrMonBdg.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>">
             <font color="red" size="-1">Budget</font></a>
             <font size="-1">You must be authorized to use this option.</font>
          <%}%>
       <br><font size="-1">Last update made by: <%=sUserId%> on
            <%=sLastChgDate%> at <%=sLastChgTime%>.</font>
       <%if   (sStrAllowed != null && sStrAllowed.trim().equals("ALL") ||
               vStr != null && vStr.size() > 1){%>
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
<%
  sWkSch.disconnect();
  sWkSch = null;
%>