<%@ page import="payrollreports.PsDaySched"%>
<% String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sWeekDay = request.getParameter("WKDATE");
   String sMonth = request.getParameter("MONBEG");
   String sWeekEnd = request.getParameter("WEEKEND");
   String sFrom = request.getParameter("FROM");
   String sDayOfWeek = request.getParameter("WKDAY");

    //-------------- Security ---------------------
   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PsDaySched.jsp&APPL=" + sAppl + "&" + request.getQueryString());
   }
  //-------------- End Security -----------------


   PsDaySched prSch = new PsDaySched(sStore, sWeekDay);
   int iNumOfSec = prSch.getNumOfSec();
    int iNumOfGrp = prSch.getNumOfGrp();
    int [] iNumSecGrp = prSch.getNumSecGrp();
    String [] sSecLst = prSch.getSecLst();
    String [] sSecName = prSch.getSecName();
    String [] sGrpLst = prSch.getGrpLst();
    String [] sGrpName = prSch.getGrpName();

    String [] sSlsTot = prSch.getSlsTot();
    String [] sHrsTot = prSch.getHrsTot();
    String [][] sSecNum = prSch.getSecNum();

    String sAllEmp = prSch.getAllEmp();
    int iNumOfEvt = prSch.getNumOfEvt();
    String [] sEvent = prSch.getEvent();
    String [] sEvtTime = prSch.getEvtTime();
    String [] sEvtComt = prSch.getEvtComt();

   // Hours/Minutes array
   String [] sHrsTxt = new String[]{"07","08","09","10","11","12",
                                 "01","02","03","04","05","06",
                                 "07","08","09","10","11","12"};
   String [] sHrs = new String[18];
   String [] sMin = new String[]{"00", "30"};
   for(int i=7; i<25;i++){
     sHrs[i-7] = Integer.toString(i);
     if (sHrs[i-7].length()== 1) {
        sHrs[i-7] = "0" + sHrs[i-7];
     }
   }

   // Hours/Minutes array
   String [] sHrsDsp = new String[]{"07<br>am","08<br>am","09<br>am","10<br>am",
                                 "11<br>am","12<br>pm", "01<br>pm","02<br>pm",
                                 "03<br>pm","04<br>pm","05<br>pm","06<br>pm",
                                 "07<br>pm","08<br>pm","09<br>pm","10<br>pm",
                                 "11<br>pm", "12<br>am"};
   String sClrBox = null;
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:#d7d7d7; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
        td.DataTable2 { color:red; background:cornsilk; cursor: hand; border-top: double darkred; border-bottom: darkred solid 1px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px ;}
        td.DataTable3 { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:8px; }
        td.DataTable4 { background:#FFCC99; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable5 { background:white;border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:8px; }
        td.DataTable6 { background:gold;border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }
        td.DataTable7 { color:red; background:cornsilk; border-top: double darkred; border-bottom: darkred solid 1px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px;}
        td.DataTable8 { color:brown; background: Linen; border-top: darkred solid 1px; border-bottom: darkred solid 1px; padding-top:0px; padding-bottom:0px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable9 { color:red; background:cornsilk; border-top: double darkred; border-bottom: darkred solid 1px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:11px; font-weight:bold}
        td.DataTable10 { background:#d7d7d7; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable11 { background:#d7d7d7; cursor: hand; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }

        td.EntTbl  { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }
        td.EntTbl1  { background:white; border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }
        td.EntTbl2  { background:red; border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }
        td.EntTbl3 { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:8px; }

        td.Menu   {border-bottom: black solid 1px; cursor: hand; text-align:left; font-family:Arial; font-size:10px; }
        td.Menu1  {border-bottom: black solid 1px; text-align:left; font-family:Arial; font-size:12px; }
        td.Menu2  {text-align:right; font-family:Arial; font-size:12px; }
        td.Menu3  {border-bottom: black solid 1px; text-align:left; font-family:Arial; font-size:10px; }

        td.Grid  { background:darkblue; color:white; text-align:center; font-family:Arial; font-size:11px; font-weight:bolder}
        tr.Grid1 { text-align:center; font-family:Arial; font-size:10px;}
        button.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:center; font-family:Arial; font-size:10px;}
</style>
<SCRIPT language="JavaScript">
//--------------- Global variables -----------------------
//--------------- End of Global variables -----------------------
//--------------------------------------------------------------------------
</SCRIPT>
</head>
<!-------------------------------------------------------------------->
<body>
<!-------------------------------------------------------------------->
<div id="tooltip2" style="position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px;background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px"></div>


<div id="menu" style="position:absolute;visibility:hidden; background-attachment: scroll;
              border: black solid 3px; width:150px;background-color:Azure; z-index:10;
              text-align:center"></div>


    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP" colspan="3"><b>Daily Store Schedule</b></td>
     </tr>
     <tr bgColor="moccasin">
       <td ALIGN="left" VALIGN="TOP"><b>&nbsp;Store:&nbsp;<%=sThisStrName%></b></td>
       <td ALIGN="center" VALIGN="TOP">&nbsp;</td>
       <td ALIGN="right" VALIGN="TOP"><b>Date: <%=sDayOfWeek%>, <%=sWeekDay%>&nbsp;</b></td>
     </tr>
     <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP" colspan="3"><b>Daily Sales Goal:&nbsp;$<%=sSlsTot[0]%></b></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" colspan="3">
        <a href="../"><font color="red" size="-1">Home</font></a>&#62;
        <%if(sFrom.equals("AVGPAYREP")){%>
          <a href="APRSelector.jsp"><font color="red"  size="-1">Store Selector</font></a>&#62;
          <a href="AvgPayRep.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>">
            <font color="red" size="-1">Average Pay Report</font></a>&#62;
        <%}
        else {%>
          <a href="PsWkSchedSel.jsp"><font color="red" size="-1">Store/Week Selector</font></a>&#62;
        <%}%>
        <a href="PsWkSched.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&FROM=<%=sFrom%>">
          <font color="red"  size="-1">Weekly Schedule</font></a>&#62;
         <font size="-1">This page</font>
      <!------------- start of dollars table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable" colspan="3">Employee</th>
           <th class="DataTable" colspan="36">In/Out Time</th>
           <th class="DataTable" rowspan="3">Hours</th>
           <th class="DataTable" rowspan="3">Sales<br>Goals</th>
         </tr>
         <tr>
           <th class="DataTable" rowspan="2">Name</th>
           <th class="DataTable" rowspan="2">Dpt</th>
           <th class="DataTable" rowspan="2"> Title </th>

           <%for(int i=0; i < sHrsDsp.length; i++) {%>
             <td class="DataTable4" colspan="<%=sMin.length%>"><%=sHrsDsp[i]%></td>
           <%}%>
         </tr>
         <tr >
         <%for(int i=0, k=0; i < (sHrsDsp.length * sMin.length); i++, k++){
          if(k >= sMin.length) k=0; %>
          <td class="DataTable3"><%=sMin[k]%></td>
         <%}%>
         </tr>


   <!-- ------------------------ Sections Header ------------------------------------------ -->
   <%int iSec = 0;
     int iSecGrp = 0;

     for(int i=0; i < iNumOfGrp; i++){%>
       <%if(iSecGrp == 0){%>
         <tr>
           <td class="DataTable9"  colspan="3" id="SECTION"><%=sSecName[iSec]%></td>
           <%for(int j=0; j < sHrsDsp.length; j++) {%>
             <%if(!sSecLst[iSec].equals("SPEC")){%>
                <td class="DataTable7" colspan="<%=sMin.length%>"><%if(sSecNum[iSec][j].trim().equals("") ){%>&nbsp;<%}%><%=sSecNum[iSec][j]%></td>
             <%} else {%>
                <td class="DataTable7" colspan="<%=sMin.length%>">&nbsp;</td>
             <%}%>
           <%}%>
           <!-- Total hours per day-->
           <%if(!sSecLst[iSec].equals("SPEC")){%><td class="DataTable2"><%=sHrsTot[iSec]%></td>
           <%} else {%><td class="DataTable2">&nbsp;</td><%}%>
           <!-- Sales Goals -->
           <%if(sSecLst[iSec].equals("APPRL")){%><td class="DataTable2">$<%=sSlsTot[1]%></td>
           <%} else {%><td class="DataTable2">&nbsp;</td><%}%>
         </tr>
       <%}%>
    <!-- =================================================================== -->
    <!-- Group Header -->
    <!-- =================================================================== -->
         <tr>
           <td class="DataTable8" colspan="3" id="<%=sGrpLst[i]%>_GP"><%=sGrpName[i]%></td>
           <td class="DataTable8" colspan="38">&nbsp;</td>
         </tr>
    <!-- =================================================================== -->
    <!-- Group Details  -->
    <!-- =================================================================== -->
        <%
           prSch.setSched(sGrpLst[i]);
           int iNumOfEmp = prSch.getNumOfEmp();
           String [] sGrpEmp = prSch.getGrpEmp();
           String [] sGrpDpt = prSch.getGrpDpt();
           String [] sGrpTtl = prSch.getGrpTtl();
           String [] sGrpTim = prSch.getGrpTim();
           String [] sGrpTot = prSch.getGrpTot();
           String [] sGrpHTyp = prSch.getGrpHTyp();
           String [] sGrpReg = prSch.getGrpReg();
           String [] sGrpGoal = prSch.getGrpGoal();
        %>

        <%for(int j=0; j < iNumOfEmp; j++){%>
           <tr>
             <td class="DataTable11" id="<%=sGrpEmp[j]+sWeekDay%>" >&nbsp;&nbsp;&nbsp;<%=sGrpEmp[j].trim()%></td>
             <td class="DataTable">&nbsp;<%=sGrpDpt[j]%>&nbsp;</td>
             <td class="DataTable">&nbsp;<%=sGrpTtl[j]%>&nbsp;</td>

             <%if (sGrpHTyp[j].equals("VAC")) sClrBox = "blue_clr.bmp";
             else if (sGrpHTyp[j].equals("HOL")) sClrBox = "green_clr.bmp";
             else if (sGrpHTyp[j].equals("OFF")) sClrBox = "yellow_clr.bmp";
             else sClrBox = "red_clr.bmp";%>

             <%if (!sGrpHTyp[j].equals("OFF")) {%>
                <%for(int k=0; k<36; k++)
                  {
                     if(sGrpTim[j].substring(k,k+1).equals("1")) {%>
                        <td class="DataTable5"><img src="<%=sClrBox%>" ></td>
                   <%}
                     else {%>
                        <td class="DataTable5">&nbsp;</td>
                     <%}%>
                  <%}%>
                  <td class="DataTable"><%if(sGrpTot != null && sGrpTot.length > 0){%><%=sGrpTot[j]%><%}%></td>
                  <td class="DataTable"><%if(sGrpGoal.length > 0 && sSecLst[iSec].equals("APPRL")){%><%=sGrpGoal[j]%><%} else {%>&nbsp;<%}%></td>
            <%}
            else {%>
              <td class="DataTable6" colspan="38">Request Off</td>
            <%}%>
           </tr>
        <%}%>
     <!-- end of group loop -->
     <%
          iSecGrp++;
          if (iSecGrp == iNumSecGrp[iSec]){ iSecGrp = 0; iSec++; }
       }%>

    <!-- =================================================================== -->
    <!-- Totals -->
    <!-- =================================================================== -->
    <tr>
           <td class="DataTable9"  colspan="3" id="SECTION">Totals</td>

           <%for(int i=0; i < sHrsDsp.length; i++) {%>
              <td class="DataTable7" colspan="<%=sMin.length%>"><%if(sSecNum[3][i].trim().equals("") ){%>&nbsp;<%}%><%=sSecNum[3][i]%></td>
           <%}%>

           <td class="DataTable2"><%=sHrsTot[3]%></td>
           <td class="DataTable2">&nbsp;</td>
         </tr>
         <tr>
            <td class="DataTable4" colspan="3">&nbsp;</td>
            <%for(int i=0; i < sHrsDsp.length; i++) {%>
               <td class="DataTable4" colspan="<%=sMin.length%>"><%=sHrsDsp[i]%></td>
            <%}%>
            <td class="DataTable4" colspan="2">&nbsp;</td>
         </tr>
     <!-- ---------------------------------------------------------------- -->
     <!-- ---------------------------- Events ---------------------------- -->
     <!-- ---------------------------------------------------------------- -->
         <tr>
           <td class="DataTable9" colspan="41">Events</td>
         </tr>
         <%for(int i=0; i < iNumOfEvt; i++) {%>
           <tr>
            <td class="DataTable11" id="EVT<%=i%>" >
                 <%=sEvent[i]%></td>
            <td class="DataTable10" id="EVD<%=i%>" colspan='2'><%=sEvtTime[i]%></td>
            <td class="DataTable11" colspan='38'
               id="EVD<%=i%>" onclick="ShowEvtMenu(this)"><%=sEvtComt[i]%></td>
           <tr>
         <%}%>

       </table>

<!------------- end of data table ------------------------>
<tr bgColor="moccasin">
       <td ALIGN="right" VALIGN="TOP" colspan="3">
       <font size="-1">* - The amount of sales goal for selling personnel is 85% of store total sales goal.</font>
       </td>
</tr>
<tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP" colspan="3">
<a name="HoursEntry"></a>

    </td>
   </tr>
  </table>
 </body>
</html>
<%prSch.disconnect();%>