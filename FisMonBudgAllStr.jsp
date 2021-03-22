<%@ page import="payrollreports.SetFMBdgAll,  payrollreports.SetWeeks, java.util.*, java.text.*"%>
<% String sMonth = request.getParameter("MONBEG");
   String sWeekEnd = request.getParameter("WEEKEND");
   String sSort = request.getParameter("SORT");
   String sGroup = request.getParameter("GROUP");
   String sWkDate = null;

   SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
   Calendar cal = Calendar.getInstance();
   cal.set(Integer.parseInt(sWeekEnd.substring(6, 10)),
           Integer.parseInt(sWeekEnd.substring(0, 2)) - 1,
           Integer.parseInt(sWeekEnd.substring(3, 5)));
   cal.add(Calendar.DATE, -6);
   Date date = cal.getTime();
   sWkDate = df.format(date);

   if (sSort==null) { sSort = "STR";}
   if (sGroup==null) { sGroup = "ALL";}

  //-------------- Security ---------------------
  String sStrAllowed = null;
  String sAccess = null;
  String sUser = " ";
  String sAppl = "PAYROLL";
  if   (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
    && !session.getAttribute("APPLICATION").equals(sAppl))
  {
     response.sendRedirect("SignOn1.jsp?TARGET=FisMonBudgAllStr.jsp&APPL=" + sAppl + "&" + request.getQueryString());
  }
   else {
     sAccess = session.getAttribute("ACCESS").toString();
     sStrAllowed = session.getAttribute("STORE").toString();
     sUser = session.getAttribute("USER").toString();

     if (sAccess != null && !sAccess.equals("1") &&
         sStrAllowed.startsWith("ALL"))
     {
       response.sendRedirect("StrScheduling.html");
     }
   }
  // -------------- End Security -----------------
  SetFMBdgAll setbud = null;
  int iNumOfStr = 0;

   String []  sStore = null;
   String []  sStoreName = null;
   int iNumOfReg = 0;
   String [] sReg = null;
   String [] sRegs = null;
   int [] iReg = null;

   String [] sPlans = null;
   String [] sBudget = null;
   String [] sMgmInp = null;
   String [] sBdgPrc = null;
   String [] sMgmPrc = null;
   String [] sColor = null;

   String [] sPayVar = null;
   String [] sPrcVar = null;

   String [] sMgmHrs = null;
   String [] sSlsHrs = null;
   String [] sNSlHrs = null;
   String [] sTrnHrs = null;
   String [] sTotHrs = null;

   String [] sMgmAvgUsg = null;
   String [] sSlsAvgUsg = null;
   String [] sNSlAvgUsg = null;
   String [] sTrnAvgUsg = null;
   String [] sTotAvgUsg = null;

   String [] sBdgMinHrs = null;
   String [] sBdgVarMin = null;
   String [] sBdgAvr = null;
   String [] sBdgVarAvr = null;

   String [] sTotDlrTbl = null;
   String [] sTotHrsTbl = null;
   String [] sTotAvgTbl = null;
   String [] sTotBdgTbl = null;

   String [] sSlsProd = null;
   String [] sOthProd = null;
   String [] sTotProd = null;

   String sAllSlsProd = null;
   String sAllOthProd = null;
   String sAllTotProd = null;

   String sTotActPay = null;
   String sTotActHrs = null;
   String sTotActPrc = null;
   String sTotActSls = null;
   String sTotActAvg = null;
   String sTotTmcHrs = null;

   String [] [] sRegTot = null;

   String [] sApprvSts = null;
   String [] sNewReq = null;
   String [] sNewRsp = null;
   String [] sNewTot = null;
   String [] sActPay = null;
   String [] sActHrs = null;
   String [] sActPrc = null;
   String [] sActSls = null;
   String [] sActAvg = null;
   String [] sTmcHrs = null;
   String sActual= null;

   String sInclReg = "1";
   if(sGroup.equals("STR")) {sInclReg = "0";}


   setbud = new SetFMBdgAll(sWeekEnd, sSort, sInclReg, sUser);
   iNumOfStr = setbud.getNumOfStr();
   sStore = setbud.getStores();
   sStoreName = setbud.getStoreNames();
   iNumOfReg = setbud.getNumOfReg();
   sReg = setbud.getRegion();
   sRegs = setbud.getRegions();
   iReg = setbud.getRegStrQty();

   sPlans = setbud.getPlans();
   sBudget = setbud.getBudget();
   sMgmInp = setbud.getMgmInp();
   sBdgPrc = setbud.getBdgPrc();
   sMgmPrc = setbud.getMgmPrc();
   sColor = setbud.getColor();

   sPayVar = setbud.getPayVar();
   sPrcVar = setbud.getPrcVar();

   sMgmHrs = setbud.getMgmHrs();
   sSlsHrs = setbud.getSlsHrs();
   sNSlHrs = setbud.getNSlHrs();
   sTrnHrs = setbud.getTrnHrs();
   sTotHrs = setbud.getTotHrs();

   sMgmAvgUsg = setbud.getMgmAvgUsg();
   sSlsAvgUsg = setbud.getSlsAvgUsg();
   sNSlAvgUsg = setbud.getNSlAvgUsg();
   sTrnAvgUsg = setbud.getTrnAvgUsg();
   sTotAvgUsg = setbud.getTotAvgUsg();

   sBdgMinHrs = setbud.getBdgMinHrs();
   sBdgVarMin = setbud.getBdgVarMin();
   sBdgAvr = setbud.getBdgAvr();
   sBdgVarAvr = setbud.getBdgVarAvr();

   sTotDlrTbl = setbud.getTotDlrTbl();
   sTotHrsTbl = setbud.getTotHrsTbl();
   sTotAvgTbl = setbud.getTotAvgTbl();
   sTotBdgTbl = setbud.getTotBdgTbl();

   sSlsProd = setbud.getSlsProd();
   sOthProd = setbud.getOthProd();
   sTotProd = setbud.getTotProd();

   sAllSlsProd = setbud.getAllSlsProd();
   sAllOthProd = setbud.getAllOthProd();
   sAllTotProd = setbud.getAllTotProd();

   sTotActPay = setbud.getTotActPay();
   sTotActHrs = setbud.getTotActHrs();
   sTotActPrc = setbud.getTotActPrc();
   sTotActSls = setbud.getTotActSls();
   sTotActAvg = setbud.getTotActAvg();
   sTotTmcHrs = setbud.getTotTmcHrs();

   sRegTot = setbud.getRegTot();
   sApprvSts = setbud.getApproveStatus();
   sNewReq = setbud.getNewReq();
   sNewRsp = setbud.getNewRsp();
   sNewTot = setbud.getNewTot();

   sActPay = setbud.getActPay();
   sActHrs = setbud.getActHrs();
   sActPrc = setbud.getActPrc();
   sActSls = setbud.getActSls();
   sActAvg = setbud.getActAvg();
   sActual = setbud.getActual();
   sTmcHrs = setbud.getTmcHrs();

   setbud.disconnect();

   // get 11 weeks
   SetWeeks SetWk = new SetWeeks("11WK");
   int iNumOfWeeks = SetWk.getNumOfWeeks();
   String sWeeksJSA = SetWk.getWeeksJSA();
   String sMonthsJSA = SetWk.getMonthBegJSA();

   String sBaseWkJSA = SetWk.getBaseWkJSA();
   String sBsWkNameJSA = SetWk.getBsWkNameJSA();
   String sBsMonBegJSA = SetWk.getBsMonBegJSA();

   String [] sSGStr = setbud.getSGStr();
   String [] sSGStrNm = setbud.getSGStrNm();
   String [][] sSlsGoal = setbud.getSlsGoal();
   String [][] sSGHrs = setbud.getSGHrs();
   String [][] sSGHiLo = setbud.getSGHiLo();

   String sSGStrJsa = setbud.getSGStrJsa();
   String sSGStrNmJsa = setbud.getSGStrNmJsa();
   String sSlsGoalJsa = setbud.getSlsGoalJsa();
   String sSGHrsJsa = setbud.getSGHrsJsa();
   String sSGHiLoJsa = setbud.getSGHiLoJsa();

   SetWk.disconnect();
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}

        th.DataTable { background:#FFCC99;padding-top:1px; padding-bottom:1px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99;padding-top:1px; padding-bottom:1px; border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:1px; padding-bottom:1px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        td.DataTable { background:#e7e7e7; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
	td.DataTable1 { background:#e7e7e7; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable1H { background:lightblue; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable1L { background:pink; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable2{ background:cornsilk; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable3{ background:cornsilk; border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable4 { background:#e7e7e7; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable5{ background:cornsilk; border-bottom: darkred solid 1px; border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable6 { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:10px }
        td.DataTable7 { background:seashell; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable8 { background:#e7e7e7; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }

</style>
<SCRIPT language="JavaScript">

 var Weeks = [<%=sWeeksJSA%>];
 var MonthWks = [<%=sMonthsJSA%>];
 var Month = "<%=sMonth%>";
 var WeekEnd = "<%=sWeekEnd%>";

 var BaseWk = [<%=sBaseWkJSA%>];
 var BsMonBeg = [<%=sBsMonBegJSA%>];
 var BsWkName = [<%=sBsWkNameJSA%>];

 var Sort = "<%=sSort%>";
 var Group = "<%=sGroup%>"

 var RegNum = "<%=iNumOfReg%>"
 var Reg = new Array(RegNum);
<%for(int i=0; i<iNumOfReg; i++){%>
  Reg[<%=i%>] = [<%=sReg[i]%>]
<%}%>

SGStr = [<%=sSGStrJsa%>];
SGStrNm = [<%=sSGStrNmJsa%>];
SlsGoal = [<%=sSlsGoalJsa%>];
SGHrs = [<%=sSGHrsJsa%>];
SGHiLo = [<%=sSGHiLoJsa%>];
//==============================================================================
// initialize on loading
//==============================================================================
function bodyLoad(){
 doWeekSelect();
 doGroupSelect();
}

// resort table
function reSort(sortby)
{
  var df = document.forms[0];
  var sbmString = "FisMonBudgAllStr.jsp?MONBEG=" + Month
                + "&WEEKEND=" + WeekEnd
                + "&SORT=" + sortby
                + "&GROUP=" + df.GROUP.options[df.GROUP.selectedIndex].value;
  window.location.href=sbmString;
}

// Weeks Stores
function doWeekSelect(id) {
    var df = document.forms[0];
    for (idx = 0; idx < Weeks.length; idx++)
    {
         df.WEEK.options[idx] =
            new Option(Weeks[idx], Weeks[idx]);
          if (WeekEnd==Weeks[idx])
          {
             df.WEEK.selectedIndex=idx;
          }
    }

    for (idy=0; idy < BaseWk.length; idy++, idx++)
    {
      df.WEEK.options[idx] =
            new Option(BsWkName[idy], BaseWk[idy]);
            if (WeekEnd==BaseWk[idy])
          {
             df.WEEK.selectedIndex=idx;
          }
    }
}

// Weeks Stores
function doGroupSelect() {
    var df = document.forms[0];
    df.GROUP.options[0] =  new Option("All Regions ", "ALL");
    if (Group=="ALL"){ df.GROUP.selectedIndex=0;}

    for (idx = 0; idx < Reg.length; idx++)
    {
         df.GROUP.options[idx+1] =  new Option("Region " + Reg[idx], Reg[idx]);
         if (Group==Reg[idx])
          {
             df.GROUP.selectedIndex=idx+1;
          }
    }

    df.GROUP.options[Reg.length + 1] =  new Option("All Stores" , "STR");
    if (Group=="STR"){ df.GROUP.selectedIndex=Reg.length+1;}
    df.GROUP.options[Reg.length + 2] =  new Option("Totals Only" , "TOTAL");
    if (Group=="TOTAL"){ df.GROUP.selectedIndex=Reg.length + 2;}
}


function submitForm()
{
   var idx = document.getStore.WEEK.selectedIndex;
   var selMonth = null;

   // check if base schedule or regular schedule
   if (idx < MonthWks.length)
   {
     selMonth = MonthWks[idx]
   }
   else
   {
     selMonth = BsMonBeg[idx - MonthWks.length];
   }

   var SbmString = "FisMonBudgAllStr.jsp"
         + "?MONBEG=" + selMonth
         + "&WEEKEND="
         + document.getStore.WEEK.options[document.getStore.WEEK.selectedIndex].value
         + "&GROUP="
         + document.getStore.GROUP.options[document.getStore.GROUP.selectedIndex].value

   // alert(SbmString);
    window.location.href=SbmString;
}
//==============================================================================
// resort Sales goal table
//==============================================================================
function resortSlsGoal(sort)
{
   SortSlsGoal = sort;

   var html = "<table class='DataTable'  cellPadding='0'>"
     + "<tr>"
       + "<th class='DataTable' rowspan=3><a href='javascript: resortSlsGoal(&#34;STORE&#34;)'>Store</a></th>"
       + "<th class='DataTable1' rowspan=3>&nbsp;</th>"
       + "<th class='DataTable' colspan=24>Sales Goal (85%)<br>&#34;SP&#34; - Productivity</th>"
     + "</tr>"
     + "<tr>"
       + "<th class='DataTable' colspan=2>Mon</th>"
       + "<th class='DataTable1' rowspan=2>&nbsp;</th>"
       + "<th class='DataTable' colspan=2>Tue</th>"
       + "<th class='DataTable1' rowspan=2>&nbsp;</th>"
       + "<th class='DataTable' colspan=2>Wed</th>"
       + "<th class='DataTable1' rowspan=2>&nbsp;</th>"
       + "<th class='DataTable' colspan=2>Thu</th>"
       + "<th class='DataTable1' rowspan=2>&nbsp;</th>"
       + "<th class='DataTable' colspan=2>Fri</th>"
       + "<th class='DataTable1' rowspan=2>&nbsp;</th>"
       + "<th class='DataTable' colspan=2>Sat</th>"
       + "<th class='DataTable1' rowspan=2>&nbsp;</th>"
       + "<th class='DataTable' colspan=2>Sun</th>"
       + "<th class='DataTable1' rowspan=2>&nbsp;</th>"
       + "<th class='DataTable' colspan=2>Total</th>"
       + "<th class='DataTable1' rowspan=2>&nbsp;</th>"
      + "</tr>"
      + "<tr>"

      for(i=0; i < 8; i++)
      {
         html += "<th class='DataTable2'><a href='javascript: resortSlsGoal(&#34;" + i + "&#34;)'>SP</a></th>"
               + "<th class='DataTable2'>Hrs</th>"
      }
   html += "</tr>"

   var sortBy = popSortArr(sort);

   html += rebuildTable(sortBy);

   html += "</table>"

   document.all.dvSlsGoal.innerHTML = html;
}
//==============================================================================
// populate sorting array
//==============================================================================
function rebuildTable(sortBy)
{
   var html = "";

   for(var i=0; i < SGStr.length; i++)
   {
       var arg =  sortBy[i].substring(sortBy[i].indexOf("@") + 1);
       html += "<tr>"
            + "<td class='DataTable8'>" + SGStr[arg] + " - " + SGStrNm[arg] + "</td>"
            + "<th class='DataTable1'>&nbsp;</th>"
       for(var j=0; j < 8; j++)
       {
          html += "<td class='DataTable1" + SGHiLo[arg][j] + "'  id='SP" + i + j + "'  >$" + SlsGoal[arg][j] + "</td>"
               + "<td class='DataTable1'>" + SGHrs[arg][j] + "</td>"
               + "<th class='DataTable1'>&nbsp;</th>"
       }
       html += "</tr>"
   }

   return html;
}
//==============================================================================
// populate sorting array
//==============================================================================
function popSortArr(sort)
{
   var sortby = new Array(SGStr.length);
   var elem = "";
   var str = "";
   var goal = "";

   for(var i=0; i < SGStr.length; i++)
   {
      str = setNum(SGStr[i], 7);
      if(sort !="STORE") { goal = setNum(SlsGoal[i][sort], 7); }
      else { goal = "0000000"; }

      if(sort !="STORE") { sortby[i] = goal + str + "@" + i }
      else { sortby[i] = str + goal + "@" + i }
   }

   if (sort !="STORE") sortby.sort(sortTable);

   return sortby;
}
//==============================================================================
// populate sorting array
//==============================================================================
function setNum(num, max)
{
   var string = "";
   var len = num.length;
   string = num;
   for(var i=0; i < max; i++)
   {
      if( i < max-len){ string = " " + string; }
      else { break; }
   }
   return string;
}
//==============================================================================
// populate sorting array
//==============================================================================
function sortTable(elm1, elm2)
{
   return eval(elm2.substring(0,7)) - eval(elm1.substring(0,7));
}
//==============================================================================
// show weekly hi and low result for each store
//==============================================================================
function showWklyHiLo()
{
   for(var i=0; i < SGStr.length; i++)
   {
      for(var j=0; j < 8; j++)
      {
         var cell = 0
      }
   }
}
</SCRIPT>
</head>
<body  onload="bodyLoad();">

         <div id="tooltip2" style="position:absolute;visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:150px;background-color:LemonChiffon; z-index:10"></div>
         <div align="CENTER" name="divTest" onMouseover="showtip2(this,event,' ');" onMouseout="hidetip2();" STYLE="cursor: hand">
         </div>

   <table border="0" width="100%" height="100%">
    <tr bgColor="moccasin">
     <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>All Store Weekly Budget<br>
      Weekending: <%=sWeekEnd%></b><br>
<!------------- store selector ----------------------------->
      <form name="getStore" action="javascript:submitForm();">
      <table border="0">
       <tr>
        <td align="right">Weekending:</td>
        <td><SELECT name="WEEK"></SELECT></td>
        <td><input type="submit" name="NEWWEEK" value="GO"></td>
        <td>&nbsp;&nbsp;</td>
        <td align="right">Group by:</td>
        <td><SELECT name="GROUP"></SELECT></td>
        <td><input type="submit" name="NEWTOTAL" value="GO"></td>
       </tr>
      </table>
      </form>
<!------------- end of store selector ---------------------->

        <p align=left style="font-size:12px">
        * Actuals = Total Payroll  <%for(int i=0; i < 45; i++){%>&nbsp;<%}%>
        <a href="../"><font color="red">Home</font></a>&#62;
        <!--a href="StrScheduling.html"><font color="red">Payroll</font></a -->
        <a href="FiscalMonthSel.jsp"><font color="red">Week Selector</font></a>&#62;
        This page

<!------------- start of dollars table ------------------------>
      <table class="DataTable" align="center" >
             <tr>
               <th class="DataTable" rowspan="3">Reg<br/>#</th>
               <th class="DataTable" rowspan="3"><a href="javascript:reSort('STR');">Str</a><br/>#</th>
               <th class="DataTable" rowspan="3">S<br>t<br>a<br>t<br>u<br>s</th>
               <th class="DataTable" colspan="2" nowrap >My<br>Msg</th>
               <th class="DataTable" rowspan="3">T<br>o<br>t<br>a<br>l</th>

               <%if(sActual.equals("1")){%>
                  <th class="DataTable" colspan="2">Sales</th>
               <%}
               else{%>
                 <th class="DataTable" rowspan="3"><a href="javascript:reSort('PLN');">Planned<br/>Sales</a></th>
               <%}%>

               <th class="DataTable1" rowspan="3">C<br>o<br>v</th>
               <th class="DataTable" colspan="<%if(sActual.equals("1")){%>4<%}%><%else{%>3<%}%>">
                          Payroll Dollars</th>
               <th class="DataTable" rowspan="3">D<br>t<br>l</th>
               <th class="DataTable" colspan="<%if(sActual.equals("1")){%>4<%}%><%else{%>3<%}%>">
                          Payroll %</th>

               <th class="DataTable1"  rowspan="3">B<br>u<br>d<br>g<br>e<br>t</th>

               <th class="DataTable" colspan="<%if(sActual.equals("1")){%>9<%}%><%else{%>7<%}%>">
                          # of Hours</th>

               <%if(sActual.equals("1")){%>
                 <th class="DataTable1" rowspan="3">V<br>a<br>r<br>i<br>a<br>n<br>c<br>e</th>
               <%}
                 else {%><th class="DataTable1" rowspan="3">&nbsp;</th><%}%>

               <th class="DataTable" colspan="<%if(sActual.equals("1")){%>8<%}%><%else{%>7<%}%>">
                          Average Wage</th>

               <th class="DataTable1">&nbsp;</th>
               <th class="DataTable" colspan="3">Sales Productivity</th>
               <th class="DataTable" rowspan="3">Str<br/>#</th>
             </tr>

             <tr>
                <th class="DataTable" rowspan="2" nowrap>N<br>e<br>w</th>
                <th class="DataTable" rowspan="2" nowrap>R<br>p<br>l<br>y</th>

                <%if(sActual.equals("1")){%>
                  <th class="DataTable" rowspan="2"><a href="javascript:reSort('PLN');">Planned</a></th>
                  <th class="DataTable" rowspan="2">Actual</th>
                <%}%>

                <th class="DataTable" rowspan="2"><a href="javascript:reSort('BDG');">Budget</a> </th>
                <th class="DataTable" rowspan="2"><a href="javascript:reSort('PAY');">Calc<br/>per Schedule</a></th>
                <th class="DataTable">Budg. vs.<br>Sched.</th>
                <%if(sActual.equals("1")){%>
                  <th class="DataTable" rowspan="2">Actual</th>
                <%}%>

                <th class="DataTable" rowspan="2"><a href="javascript:reSort('BDP');">Budget</a></th>
                <th class="DataTable" rowspan="2"><a href="javascript:reSort('PAP');">Calc per<br/>Schedule</a></th>
                <th class="DataTable">Budg. vs.<br>Sched.</th>

                <%if(sActual.equals("1")){%>
                  <th class="DataTable" rowspan="2">Actual</th>
                <%}%>

                <th class="DataTable">Budget<br>Hours</th>

                <th class="DataTable" colspan="5">Calculated per Schedule</th>
                <th class="DataTable">Budg. vs.<br>Sched.</th>

                <%if(sActual.equals("1")){%>
                  <th class="DataTable" rowspan="2">Actual</th>
                  <th class="DataTable" rowspan="2">TMC</th>
                <%}%>

                <th class="DataTable">Budget</th>
                <th class="DataTable" colspan="5">Calculated per Schedule</th>
                 <th class="DataTable">Budg. vs.<br>Sched.</th>

                <%if(sActual.equals("1")){%>
                   <th class="DataTable" rowspan="2">Actual</th>
                <%}%>

                <th class="DataTable1" rowspan="2">&nbsp;</th>

                <th class="DataTable" rowspan="2"><a href="javascript:reSort('PRS');">Sell</a></th>
                <th class="DataTable" rowspan="2"><a href="javascript:reSort('PRO');">Mgr/<br>Non-Sell/<br>Trn</a></th>
                <th class="DataTable" rowspan="2"><a href="javascript:reSort('PRT');">Total</a></th>

             </tr>
             <tr>
                <th class="DataTable"><a href="javascript:reSort('OVA');">Over<br/>(Under)</a></th>
                <th class="DataTable"><a href="javascript:reSort('OVP');">Over<br/>(Under)</a></th>
                <th class="DataTable">Hrs</th>

                <th class="DataTable"><a href="javascript:reSort('MGR');">Mgr</a></th>
                <th class="DataTable"><a href="javascript:reSort('SLS');">Sell</a></th>
                <th class="DataTable" nowrap><a href="javascript:reSort('NSL');">Non-<br>Sell</a></th>
                <th class="DataTable" nowrap><a href="javascript:reSort('TRN');">Trn</a></th>
                <th class="DataTable"><a href="javascript:reSort('TOT');">Total</a></th>
                <th class="DataTable">Over<br>(Under)</th>

                <th class="DataTable">Avg</th>
                <th class="DataTable"><a href="javascript:reSort('AWM');">Mgr</a></th>
                <th class="DataTable"><a href="javascript:reSort('AWS');">Sell</a></th>
                <th class="DataTable" nowrap><a href="javascript:reSort('AWN');">Non-<br>Sell</a></th>
                <th class="DataTable" nowrap><a href="javascript:reSort('AWR');">Trn</a></th>
                <th class="DataTable"><a href="javascript:reSort('AWT');">Total</a></th>
                <th class="DataTable">Over<br>(Under)</th>

                <!-- th class="DataTable">Avr<br>Wage/<br>Hrs</th -->
             </tr>

           <!-- ************************************************************ -->
           <!-- ------------------------- Region Loop details -------------- -->
           <!-- ************************************************************ -->
           <%int i=0, k=0;%>
           <%for(int j=0; j < iNumOfReg; j++){%>
             <%if(sGroup.equals("ALL") || sGroup.equals("STR") ||
                  sGroup.equals(sReg[j])){%>

           <tr>
            <% if(!sGroup.equals("STR")){%>
             <td class="DataTable4" nowrap rowspan="<%=iReg[j]+1%>">
                <%=sReg[j]%></td>
            <%}%>

             <!-- ---------------------- Store Loop ----------------------- -->
             <%for(k=0;  i < iNumOfStr && k < iReg[j]; i++, k++){%>
               <%if(k > 0){%>
                  <tr>
               <%}%>

               <% if(sGroup.equals("STR")){%>
                  <td class="DataTable1" nowrap>
                  <%=sRegs[i]%></td>
               <%}%>
                 <td class="DataTable" nowrap>
                    <a href="SchedbyWeek.jsp?STORE=<%=sStore[i]%>&STRNAME=<%=sStoreName[i]%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>">
                              <%=sStore[i]%></a></td>

                 <td class="DataTable6" nowrap>
                    <a href="Forum.jsp?STORE=<%=sStore[i]%>&STRNAME=<%=sStoreName[i]%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>"
                       target="_blank">
                      <%if(!sApprvSts[i].equals(" ")){%><%=sApprvSts[i]%><%} else {%>&nbsp;<%}%></a>
                 </td>
                 <td class="DataTable6" nowrap><%=sNewReq[i]%></a></td>
                 <td class="DataTable6" nowrap><%=sNewRsp[i]%></a></td>
                 <td class="DataTable6" nowrap><a href="Forum.jsp?STORE=<%=sStore[i]%>&STRNAME=<%=sStoreName[i]%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>"
                       target="_blank"><%=sNewTot[i]%></a></td>

                 <td class="DataTable1" nowrap>$<%=sPlans[i]%></td>
                 <%if(sActual.equals("1")){%>
                   <td class="DataTable1" nowrap>$<%=sActSls[i]%></th>
                 <%}%>
                 <th class="DataTable1">
                    <a href="EmpNumbyHourWk.jsp?STORE=<%=sStore[i]%>&STRNAME=<%=sStoreName[i]%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWkDate%>&FROM=BUDGET&WKDAY=Monday%>">
                    C</a>
                 </th>
                 <td class="DataTable1" nowrap>$<%=sBudget[i]%></td>
                 <td class="DataTable1" nowrap>$<%=sMgmInp[i]%></td>
                 <td class="DataTable3" nowrap><font color="<%=sColor[i]%>">$<%=sPayVar[i]%></font></td>
                 <%if(sActual.equals("1")){%>
                   <td class="DataTable1" nowrap>$<%=sActPay[i]%></th>
                 <%}%>

                 <th class="DataTable"><a href="SchWkPay.jsp?STORE=<%=sStore[i]%>&STRNAME=<%=sStoreName[i]%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>">D</a></th>

                 <td class="DataTable1" nowrap><%=sBdgPrc[i]%>%</td>
                 <td class="DataTable1" nowrap><%=sMgmPrc[i]%>%</td>
                 <td class="DataTable3" nowrap><font color="<%=sColor[i]%>"><%=sPrcVar[i]%>%</font></td>
                 <%if(sActual.equals("1")){%>
                   <td class="DataTable1" nowrap><%=sActPrc[i]%>%</th>
                 <%}%>

                 <th class="DataTable1"><a href="WkBdgHrs.jsp?STORE=<%=sStore[i]%>&STRNAME=<%=sStoreName[i]%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>">B</a></th>

                 <td class="DataTable7" nowrap><%=sBdgMinHrs[i].trim()%></td>
                 <td class="DataTable1" nowrap><%=sMgmHrs[i]%></td>
                 <td class="DataTable1" nowrap><%=sSlsHrs[i]%></td>
                 <td class="DataTable1" nowrap><%=sNSlHrs[i]%></td>
                 <td class="DataTable1" nowrap><%=sTrnHrs[i]%></td>
                 <td class="DataTable3" nowrap><%=sTotHrs[i]%></td>
                 <td class="DataTable7" <%if(sBdgVarMin[i].indexOf("-") < 0){%>style="color:red;"<%}%> nowrap><%=sBdgVarMin[i].trim()%></td>
                 <%if(sActual.equals("1")){%>
                   <td class="DataTable1" nowrap><%=sActHrs[i]%></th>
                   <td class="DataTable1" nowrap><%=sTmcHrs[i]%></th>
                 <%}%>

                 <%if(sActual.equals("1")){%>
                    <th class="DataTable"><a href="BdgActVar.jsp?STORE=<%=sStore[i]%>&STRNAME=<%=sStoreName[i]%>&FRWKEND=<%=sWeekEnd%>&TOWKEND=<%=sWeekEnd%>">V</a></th>
                 <%}
                 else {%><th class="DataTable1" nowrap>&nbsp;</th><%}%>

                 <td class="DataTable7" nowrap>$<%=sBdgAvr[i].trim()%></td>
                 <td class="DataTable1" nowrap>$<%=sMgmAvgUsg[i]%></td>
                 <td class="DataTable1" nowrap>$<%=sSlsAvgUsg[i]%></td>
                 <td class="DataTable1" nowrap>$<%=sNSlAvgUsg[i]%></td>
                 <td class="DataTable1" nowrap>$<%=sTrnAvgUsg[i]%></td>
                 <td class="DataTable3" nowrap>$<%=sTotAvgUsg[i]%></td>
                 <td class="DataTable7" nowrap>$<%=sBdgVarAvr[i].trim()%></td>
                 <%if(sActual.equals("1")){%>
                   <td class="DataTable1" nowrap>$<%=sActAvg[i]%></th>
                 <%}%>

                 <th class="DataTable1" nowrap>&nbsp;</th>

                 <td class="DataTable1" nowrap>$<%=sSlsProd[i]%></td>
                 <td class="DataTable1" nowrap>$<%=sOthProd[i]%></td>
                 <td class="DataTable3" nowrap>$<%=sTotProd[i]%></td>

                 <td class="DataTable" nowrap>
                    <a href="SchedbyWeek.jsp?STORE=<%=sStore[i]%>&STRNAME=<%=sStoreName[i]%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>">
                              <%=sStore[i]%></a></td>
               </tr>
             <%}%>

             <!-- ----------------Region total------------------------- -->
             <% if(!sGroup.equals("STR")){%>
              <tr>
               <td class="DataTable5">Reg</td>
               <th class="DataTable" colspan=4>&nbsp;</th>

               <td class="DataTable5"><%=sRegTot[j][0]%></td>
               <%if(sActual.equals("1")){%>
                 <td class="DataTable5"><%=sRegTot[j][1]%></td>
               <%}%>
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5"><%=sRegTot[j][2]%></td>
               <td class="DataTable5"><%=sRegTot[j][3]%></td>
               <td class="DataTable5"><%=sRegTot[j][4]%></td>
               <%if(sActual.equals("1")){%>
                 <td class="DataTable5"><%=sRegTot[j][5]%></td>
               <%}%>
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5"><%=sRegTot[j][6]%></td>
               <td class="DataTable5"><%=sRegTot[j][7]%></td>
               <td class="DataTable5"><%=sRegTot[j][8]%></td>
               <%if(sActual.equals("1")){%>
                 <td class="DataTable5"><%=sRegTot[j][9]%></td>
               <%}%>

               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5"><%=sRegTot[j][21]%></td>
               <td class="DataTable5"><%=sRegTot[j][10]%></td>
               <td class="DataTable5"><%=sRegTot[j][11]%></td>
               <td class="DataTable5"><%=sRegTot[j][12]%></td>
               <td class="DataTable5"><%=sRegTot[j][13]%></td>
               <td class="DataTable5"><%=sRegTot[j][14]%></td>
               <td class="DataTable5" <%if(sRegTot[j][22].indexOf("-") < 0){%>style="color:red;"<%}%>><%=sRegTot[j][22]%></td>
               <%if(sActual.equals("1")){%>
                 <td class="DataTable5"><%=sRegTot[j][15]%></td>
                 <td class="DataTable5"><%=sRegTot[j][29]%></td>
               <%}%>

               <th class="DataTable">&nbsp;</th>

               <td class="DataTable5"><%=sRegTot[j][23]%></td>
               <td class="DataTable5"><%=sRegTot[j][16]%></td>
               <td class="DataTable5"><%=sRegTot[j][17]%></td>
               <td class="DataTable5"><%=sRegTot[j][18]%></td>
               <td class="DataTable5"><%=sRegTot[j][19]%></td>
               <td class="DataTable5"><%=sRegTot[j][20]%></td>
               <td class="DataTable5"><%=sRegTot[j][24]%></td>
               <%if(sActual.equals("1")){%>
                 <td class="DataTable5"><%=sRegTot[j][28]%></td>
               <%}%>

               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5"><%=sRegTot[j][25]%></td>
               <td class="DataTable5"><%=sRegTot[j][26]%></td>
               <td class="DataTable5"><%=sRegTot[j][27]%></td>

               <td class="DataTable5">Reg</td>
              </tr>
             <%}%>
           <%}
           else { i += iReg[j]; }%>

          <%}%>


           <!-- ************************************************************ -->
           <!-- -------------------- Region Loop - totals only ------------- -->
           <!-- ************************************************************ -->

           <%for(int j=0; j < iNumOfReg; j++){%>
           <%if(sGroup.equals("TOTAL")){%>
            <tr>
              <td class="DataTable4" nowrap>
                 <%=sReg[j]%></td>
             <!-- Region total -->
              <td class="DataTable5">Reg</td>
              <th class="DataTable" colspan=4>&nbsp;</th>

               <td class="DataTable5"><%=sRegTot[j][0]%></td>
               <%if(sActual.equals("1")){%>
                 <td class="DataTable5"><%=sRegTot[j][1]%></td>
               <%}%>
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5"><%=sRegTot[j][2]%></td>
               <td class="DataTable5"><%=sRegTot[j][3]%></td>
               <td class="DataTable5"><%=sRegTot[j][4]%></td>
               <%if(sActual.equals("1")){%>
                 <td class="DataTable5"><%=sRegTot[j][5]%></td>
               <%}%>
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5"><%=sRegTot[j][6]%></td>
               <td class="DataTable5"><%=sRegTot[j][7]%></td>
               <td class="DataTable5"><%=sRegTot[j][8]%></td>
               <%if(sActual.equals("1")){%>
                 <td class="DataTable5"><%=sRegTot[j][9]%></td>
               <%}%>

               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5"><%=sRegTot[j][21]%></td>
               <td class="DataTable5"><%=sRegTot[j][10]%></td>
               <td class="DataTable5"><%=sRegTot[j][11]%></td>
               <td class="DataTable5"><%=sRegTot[j][12]%></td>
               <td class="DataTable5"><%=sRegTot[j][13]%></td>
               <td class="DataTable5"><%=sRegTot[j][14]%></td>
               <td class="DataTable5" <%if(sRegTot[j][22].indexOf("-") < 0){%>style="color:red;"<%}%> nowrap><%=sRegTot[j][22]%></td>
               <%if(sActual.equals("1")){%>
                 <td class="DataTable5"><%=sRegTot[j][15]%></td>
                 <td class="DataTable5"><%=sRegTot[j][29]%></td>
               <%}%>

               <th class="DataTable">&nbsp;</th>

               <td class="DataTable5"><%=sRegTot[j][23]%></td>

               <td class="DataTable5"><%=sRegTot[j][16]%></td>
               <td class="DataTable5"><%=sRegTot[j][17]%></td>
               <td class="DataTable5"><%=sRegTot[j][18]%></td>
               <td class="DataTable5"><%=sRegTot[j][19]%></td>
               <td class="DataTable5"><%=sRegTot[j][20]%></td>
               <td class="DataTable5"><%=sRegTot[j][24]%></td>
               <%if(sActual.equals("1")){%>
                 <td class="DataTable5"><%=sRegTot[j][28]%></td>
               <%}%>

               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5"><%=sRegTot[j][25]%></td>
               <td class="DataTable5"><%=sRegTot[j][26]%></td>
               <td class="DataTable5"><%=sRegTot[j][27]%></td>

               <td class="DataTable5">Reg</td>
             </tr>
           <%}%>
          <%}%>

         <!-- ************************************************************ -->
         <!-- -------------------- Company totals ------------------------ -->
         <!-- ************************************************************ -->
            <tr>
               <td class="DataTable3" colspan="2">Total</td>

               <th class="DataTable1" colspan=4>&nbsp;</th>
               <td class="DataTable3" nowrap>$<%=sTotDlrTbl[0]%></td>
               <%if(sActual.equals("1")){%>
                 <td class="DataTable3" nowrap>$<%=sTotActSls%></td>
               <%}%>
               <th class="DataTable1">&nbsp;</th>

               <td class="DataTable3" nowrap>$<%=sTotDlrTbl[1]%></td>
               <td class="DataTable3" nowrap>$<%=sTotDlrTbl[2]%></td>
               <td class="DataTable3" nowrap>$<%=sTotDlrTbl[3]%></td>
               <%if(sActual.equals("1")){%>
                 <td class="DataTable3" nowrap>$<%=sTotActPay%></td>
               <%}%>

               <th class="DataTable1">&nbsp;</th>

               <td class="DataTable3" nowrap><%=sTotDlrTbl[4]%>%</td>
               <td class="DataTable3" nowrap><%=sTotDlrTbl[5]%>%</td>
               <td class="DataTable3" nowrap><%=sTotDlrTbl[6]%>%</td>
               <%if(sActual.equals("1")){%>
                 <td class="DataTable3" nowrap><%=sTotActPrc%>%</td>
               <%}%>

               <th class="DataTable1">&nbsp;</th>
               <td class="DataTable3" nowrap><%=sTotBdgTbl[0]%></td>

               <td class="DataTable3" nowrap><%=sTotHrsTbl[0]%></td>
               <td class="DataTable3" nowrap><%=sTotHrsTbl[1]%></td>
               <td class="DataTable3" nowrap><%=sTotHrsTbl[2]%></td>
               <td class="DataTable3" nowrap><%=sTotHrsTbl[3]%></td>
               <td class="DataTable3" nowrap><%=sTotHrsTbl[4]%></td>
               <td class="DataTable3" <%if(sTotBdgTbl[1].indexOf("-") < 0){%>style="color:red;"<%}%>
                    nowrap><%=sTotBdgTbl[1].trim()%></td>
               <%if(sActual.equals("1")){%>
                 <td class="DataTable3" nowrap><%=sTotActHrs%></td>
                 <td class="DataTable3" nowrap><%=sTotTmcHrs%></td>
               <%}%>

               <%if(sActual.equals("1")){%>
                 <th class="DataTable1">
                 <a href="BdgActVar.jsp?STORE=ALL&STRNAME=All Stores&FRWKEND=<%=sWeekEnd%>&TOWKEND=<%=sWeekEnd%>">V</a></th>
               <%}
                 else { %><th class="DataTable1">&nbsp;</th><%}%>

               <td class="DataTable3" nowrap>$<%=sTotBdgTbl[2]%></td>

               <td class="DataTable3" nowrap>$<%=sTotAvgTbl[0]%></td>
               <td class="DataTable3" nowrap>$<%=sTotAvgTbl[1]%></td>
               <td class="DataTable3" nowrap>$<%=sTotAvgTbl[2]%></td>
               <td class="DataTable3" nowrap>$<%=sTotAvgTbl[3]%></td>
               <td class="DataTable3" nowrap>$<%=sTotAvgTbl[4]%></td>
               <td class="DataTable3" nowrap>$<%=sTotBdgTbl[3].trim()%></td>
               <%if(sActual.equals("1")){%>
                 <td class="DataTable3" nowrap>$<%=sTotActAvg%></td>
               <%}%>

               <th class="DataTable1">&nbsp;</th>

               <td class="DataTable3" nowrap>$<%=sAllSlsProd%></td>
               <td class="DataTable3" nowrap>$<%=sAllOthProd%></td>
               <td class="DataTable3" nowrap>$<%=sAllTotProd%></td>
               <td class="DataTable3">Total</td>
             </tr>
       </table>
<!------------- end of data table ------------------------>
<p style="font-size:10px">
* Budgeted, Scheduled and Actual payroll hours and dollars exclude holiday, vacation, sick pay and bonuses.
<br>
<br>
<!------------- Sales Goal per Store ------------------------>
<div id="dvSlsGoal">
<table class="DataTable"  cellPadding="0">
    <tr>
      <th class="DataTable" rowspan=3>Store</th>
      <th class="DataTable1" rowspan=3>&nbsp;</th>
      <th class="DataTable" colspan=24>Sales Goal (85%)<br>"SP" - Productivity</th>
    </tr>
    <tr>
      <th class="DataTable" colspan=2>Mon</th>
      <th class="DataTable1" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan=2>Tue</th>
      <th class="DataTable1" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan=2>Wed</th>
      <th class="DataTable1" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan=2>Thu</th>
      <th class="DataTable1" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan=2>Fri</th>
      <th class="DataTable1" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan=2>Sat</th>
      <th class="DataTable1" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan=2>Sun</th>
      <th class="DataTable1" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan=2>Total</th>
      <th class="DataTable1" rowspan=2>&nbsp;</th>
    </tr>
    <tr>
      <%for(int m=0; m < 8; m++){%>
         <th class="DataTable2"><a href="javascript: resortSlsGoal('<%=m%>')">SP</a></th>
         <th class="DataTable2">Hrs</th>
      <%}%>
    </tr>

    <%for(int l=0; l < iNumOfStr; l++){%>
      <tr>
         <td class="DataTable8"><%=sSGStr[l] + " - " + sSGStrNm[l]%></td>
         <th class="DataTable1">&nbsp;</th>
         <%for(int m=0; m < 8; m++){%>
            <td class="DataTable1<%=sSGHiLo[l][m]%>" id="SP<%=l%><%=m%>" >$<%=sSlsGoal[l][m]%></td>
            <td class="DataTable1"><%=sSGHrs[l][m]%></td>
            <th class="DataTable1">&nbsp;</th>
         <%}%>
      </tr>
    <%}%>
</table>
</div>
<!------------- end of data table ------------------------>

                </td>
            </tr>
       </table>

        </body>
      </html>
