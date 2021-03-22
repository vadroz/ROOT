<%@ page import="rciutility.StoreSelect, payrollreports.SetFisMonBudget, java.util.*"%>
<% String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sMonth = request.getParameter("MONBEG");

  //-------------- Security ---------------------
  String sStrAllowed = null;
  String sAccess = null;
  String sUser = null;
  Vector vStr = null;
  Iterator iter = null;
  String [] sStrAlwLst = null;

  String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     response.sendRedirect("SignOn1.jsp?TARGET=FiscalMonthBudget.jsp&APPL=" + sAppl + "&" + request.getQueryString());
   }
   else {
     sAccess = session.getAttribute("ACCESS").toString();
     sStrAllowed = session.getAttribute("STORE").toString();
     if (!sStrAllowed.startsWith("ALL"))
     {
       vStr = (Vector) session.getAttribute("STRLST");
       if (vStr.indexOf(sStore.trim()) >= 0){ sStrAllowed = sStore.trim(); }
     }


     sUser = session.getAttribute("USER").toString();

     if (sAccess != null && !sAccess.equals("1")
         || !sStrAllowed.startsWith("ALL")
         && !sStore.equals(sStrAllowed.trim()))
     {
       response.sendRedirect("index.jsp");
     }
   }
  // -------------- End Security -----------------

  StoreSelect StrSelect = null;
  SetFisMonBudget setbud = null;
  String sStr = null;
  String sStrName = null;
  int iNumOfWeeks = 0;

   String [] sWeeks = null;
   String [] sPlans = null;
   String [] sBudget = null;
   String [] sMgmInp = null;
   String [] sBdgPrc = null;
   String [] sMgmPrc = null;

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

   String [] sLastChgUser = null;
   String [] sLastChgDate = null;
   String [] sLastChgTime= null;

   String [] sColor = null;

   String [] sApprvSts = null;
   String [] sNewReq = null;
   String [] sNewRsp = null;
   String [] sNewTot = null;

   String [] sWkBeg = null;

   if(session.getAttribute("USER") != null)
   {
     if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
     {
        StrSelect = new StoreSelect(4);
     }
     else
     {
        iter = vStr.iterator();
        int iStrAlwLst = 0;
        sStrAlwLst = new String[vStr.size()];
        while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next();iStrAlwLst++;}
        if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
        else StrSelect = new StoreSelect(new String[]{sStrAllowed});
     }
     sStr = StrSelect.getStrNum();
     sStrName = StrSelect.getStrName();

     setbud = new SetFisMonBudget(sStore, sMonth, sUser);
     iNumOfWeeks = setbud.getNumOfWeeks();
     sWeeks = setbud.getWeeks();
     sWkBeg = setbud.getWkBeg();
     sPlans = setbud.getPlans();
     sBudget = setbud.getBudget();
     sMgmInp = setbud.getMgmInp();
     sBdgPrc = setbud.getBdgPrc();
     sMgmPrc = setbud.getMgmPrc();

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

     sLastChgUser = setbud.getLastUser();
     sLastChgDate = setbud.getLastDate();
     sLastChgTime = setbud.getLastTime();

     sColor = setbud.getColor();

     sApprvSts = setbud.getApproveStatus();
     sNewReq = setbud.getNewReq();
     sNewRsp = setbud.getNewRsp();
     sNewTot = setbud.getNewTot();

     setbud.disconnect();

     // variance allowed
     boolean bVarAllowed = sStrAllowed.startsWith("ALL") || sUser.startsWith("kknight");
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:lightgrey; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }
	td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable2{ background:cornsilk; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable3{ background:cornsilk; border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable4 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
        td.DataTable5 { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:10px }
        td.DataTable6{ background:seashell; border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }
</style>
<SCRIPT language="JavaScript1.2">
var CurStore = <%=sStore%>;
var CurStrName = "<%=sThisStrName%>";
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];

function bodyLoad(){
    doStrSelect();
}

// Load Stores
function doStrSelect(id) {
    var df = document.forms[0];
    for (idx = 1; idx < stores.length; idx++){
        df.STORE.options[idx-1] = new Option(stores[idx] + " - " + storeNames[idx],stores[idx]);
    }
}

function submitForm()
{
   var SbmString = "FiscalMonthBudget.jsp";
       SbmString = SbmString + "?STORE="
              + document.getStore.STORE.options[document.getStore.STORE.selectedIndex].value
              + "&STRNAME="
              + storeNames[document.getStore.STORE.selectedIndex + 1]
              + "&MONBEG=<%=sMonth%>";
   // alert(SbmString);
    window.location.href=SbmString;
}

</SCRIPT>
</head>
<body  onload="bodyLoad();">

         <div id="tooltip2" style="position:absolute;visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:150px;background-color:LemonChiffon; z-index:10"></div>
         <div align="CENTER" name="divTest" onMouseover="showtip2(this,event,' ');" onMouseout="hidetip2();" STYLE="cursor: hand">
         </div>

   <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>Budget / Labor Scheduler</b><br>
<!------------- store selector ----------------------------->
      <form name="getStore" action="javascript:submitForm();">
      Select Store <SELECT name="STORE"></SELECT>
      <input type="submit" value="GO">
      </form>
<!------------- end of store selector ---------------------->
        <font size="+1" ><b>Store:&nbsp<%=sStore + "-" + sThisStrName%>;

        </b></font>
        <p><a href="../"><font color="red">Home</font></a>&#62;
        <!-- a href="StrScheduling.html"><font color="red">Payroll</font></a -->
        <a href="FiscalMonthSel.jsp"><font color="red">Store Selector</font></a>&#62;
        This page
      </td>
    </tr>

    <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
<!------------- start of dollars table ------------------------>
      <table class="DataTable" align="center" >
             <tr>
                  <th class="DataTable" rowspan="2">Week<br/>End</th>
                  <th class="DataTable" rowspan="2">S<br>t<br>a<br>t<br>u<br>s</th>
                  <th class="DataTable" colspan="2">My<br>Msg</th>
                  <th class="DataTable" rowspan="2">T<br>o<br>t<br>a<br>l</th>
                  <th class="DataTable" rowspan="2">Planned<br/>Sales</th>
                  <th class="DataTable" rowspan="2">C<br>o<br>v</th>
                  <th class="DataTable" colspan="3">Payroll Dollars</th>
                  <th class="DataTable" rowspan="2">D<br>t<br>l</th>
                  <th class="DataTable" colspan="3">Payroll %</th>
                  <th class="DataTable" rowspan="2">B<br>u<br>d<br>g<br>e<br>t</th>
                  <th class="DataTable" rowspan="2">Last<br>User</th>
                  <th class="DataTable" rowspan="2">Last<br>Date</th>
                  <th class="DataTable" rowspan="2">Last<br>Time</th>
                  <%if (bVarAllowed) {%>
                     <th class="DataTable" rowspan="2">V<br>a<br>r<br>i<br>a<br>n<br>c<br>e</th>
                  <%}%>
             </tr>
             <tr>
               <th class="DataTable" >N<br>e<br>w</th>
               <th class="DataTable" >R<br>p<br>l<br>y</th>
                <th class="DataTable">Budget </th>
                <th class="DataTable">Calculated<br/>per Schedule</th>
                <th class="DataTable">Over<br/>(Under)</th>

                <th class="DataTable">Budget </th>
                <th class="DataTable">Calculated per<br/>Schedule</th>
                <th class="DataTable">Over<br/>(Under)</th>
             </tr>


             <%for(int i=0; i < iNumOfWeeks; i++){%>
               <tr>
                 <td class="DataTable1">
                    <a href="SchedbyWeek.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeeks[i]%>">
                                        <%=sWeeks[i]%></a></td>

                 <td class="DataTable5">
                   <a href="Forum.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeeks[i]%>"
                       target="_blank"><%if(!sApprvSts[i].trim().equals("")){%><%=sApprvSts[i]%><%} else {%>&nbsp;&nbsp;<%}%></a>
                 </td>
                 <td class="DataTable5"><%=sNewReq[i]%></td>
                 <td class="DataTable5"><%=sNewRsp[i]%></td>
                 <td class="DataTable5"><a href="Forum.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeeks[i]%>"
                       target="_blank"><%=sNewTot[i]%></a></td>

                 <td class="DataTable1">$<%=sPlans[i]%></td>

                 <th class="DataTable">
                     <a href="EmpNumbyHourWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeeks[i]%>&WKDATE=<%=sWkBeg[i]%>&FROM=BUDGET&WKDAY=MONDAY>">
                       C</a>
                 </th>

                 <td class="DataTable1">$<%=sBudget[i]%></td>
                 <td class="DataTable1">$<%=sMgmInp[i]%></td>
                 <td class="DataTable3"><font color="<%=sColor[i]%>">$<%=sPayVar[i]%></font></td>

                 <th class="DataTable"><a href="SchWkPay.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeeks[i]%>">D</a></th>

                 <td class="DataTable1"><%=sBdgPrc[i]%>%</td>
                 <td class="DataTable1"><%=sMgmPrc[i]%>%</td>
                 <td class="DataTable3"><font color="<%=sColor[i]%>"><%=sPrcVar[i]%>%</font></td>

                 <th class="DataTable"><a href="WkBdgHrs.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeeks[i]%>">B</a></th>

                 <td class="DataTable4"><%=sLastChgUser[i]%></td>
                 <td class="DataTable4"><%=sLastChgDate[i]%></td>
                 <td class="DataTable4"><%=sLastChgTime[i]%></td>
                 <%if (bVarAllowed) {%>
                     <th class="DataTable"><a href="BdgActVar.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&FRWKEND=<%=sWeeks[i]%>&TOWKEND=<%=sWeeks[i]%>">V</a></th>
                 <%}%>
               </tr>
             <%}%>
             <tr>
               <td class="DataTable3">Total</td>

               <th class="DataTable" colspan="4">&nbsp;</th>
               <td class="DataTable3">$<%=sTotDlrTbl[0]%></td>
               <th class="DataTable">&nbsp;&nbsp;</th>

               <td class="DataTable3">$<%=sTotDlrTbl[1]%></td>
               <td class="DataTable3">$<%=sTotDlrTbl[2]%></td>
               <td class="DataTable3">$<%=sTotDlrTbl[3]%></td>

               <th class="DataTable">&nbsp;&nbsp;</th>

               <td class="DataTable3"><%=sTotDlrTbl[4]%>%</td>
               <td class="DataTable3"><%=sTotDlrTbl[5]%>%</td>
               <td class="DataTable3"><%=sTotDlrTbl[6]%>%</td>
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable3" colspan="3">&#160;</td>
             </tr>
       </table>

<!------------- end of data table ------------------------>
<p>
<!------------- start of hour table ------------------------>
      <table class="DataTable" align="center" >
             <tr>
                  <th class="DataTable" rowspan="3" width="15%">Week End</th>
                  <th class="DataTable" colspan="7"># of Hours</th>
                  <th class="DataTable" rowspan="3">&nbsp;</th>
                  <th class="DataTable" colspan="7">Average Wage</th>
             </tr>
             <tr>
                <th class="DataTable">Budget<br>Hours</th>
                <th class="DataTable" colspan="5">Calculated per Schedule</th>
                <th class="DataTable">Var</th>

                <th class="DataTable" >Budget</th>
                <th class="DataTable" colspan="5">Calculated per Schedule</th>

                <th class="DataTable">Var</th>
             </tr>
             <tr>
                <th class="DataTable">Hrs</th>
                <th class="DataTable">Management</th>
                <th class="DataTable">Selling</th>
                <th class="DataTable">Non-Selling</th>
                <th class="DataTable">Training</th>
                <th class="DataTable">Total</th>
                <th class="DataTable">Over<br>(Under)</th>

                <th class="DataTable">Avr<br>Wage/<br>Hrs</th>
                <th class="DataTable">Management</th>
                <th class="DataTable">Selling</th>
                <th class="DataTable">Non-Selling</th>
                <th class="DataTable">Training</th>
                <th class="DataTable">Total</th>
                <th class="DataTable">Over<br>(Under)</th>
             </tr>
             <tr>
             <%for(int i=0; i < iNumOfWeeks; i++){%>
               <tr>
                 <td class="DataTable1" width="15%"><%=sWeeks[i]%></td>
                 <td class="DataTable6"><%=sBdgMinHrs[i]%></td>
                 <td class="DataTable1"><%=sMgmHrs[i]%></td>
                 <td class="DataTable1"><%=sSlsHrs[i]%></td>
                 <td class="DataTable1"><%=sNSlHrs[i]%></td>
                 <td class="DataTable1"><%=sTrnHrs[i]%></td>
                 <td class="DataTable3"><%=sTotHrs[i]%></td>
                 <td class="DataTable6" nowrap><%=sBdgVarMin[i].trim()%></td>

                 <th class="DataTable">&nbsp;&nbsp;</th>

                 <td class="DataTable6">$<%=sBdgAvr[i]%></td>
                 <td class="DataTable1">$<%=sMgmAvgUsg[i]%></td>
                 <td class="DataTable1">$<%=sSlsAvgUsg[i]%></td>
                 <td class="DataTable1">$<%=sNSlAvgUsg[i]%></td>
                 <td class="DataTable1">$<%=sTrnAvgUsg[i]%></td>
                 <td class="DataTable3">$<%=sTotAvgUsg[i]%></td>
                 <td class="DataTable6" nowrap>$<%=sBdgVarAvr[i].trim()%></td>
               </tr>
             <%}%>
             <tr>
               <td class="DataTable3">Total</td>
               <td class="DataTable3"><%=sTotBdgTbl[0]%></td>
               <td class="DataTable3"><%=sTotHrsTbl[0]%></td>
               <td class="DataTable3"><%=sTotHrsTbl[1]%></td>
               <td class="DataTable3"><%=sTotHrsTbl[2]%></td>
               <td class="DataTable3"><%=sTotHrsTbl[3]%></td>
               <td class="DataTable3"><%=sTotHrsTbl[4]%></td>
               <td class="DataTable3" nowrap><%=sTotBdgTbl[1].trim()%></td>

               <th class="DataTable">&nbsp;&nbsp;</th>

               <td class="DataTable3">$<%=sTotBdgTbl[2]%></td>
               <td class="DataTable3">$<%=sTotAvgTbl[0]%></td>
               <td class="DataTable3">$<%=sTotAvgTbl[1]%></td>
               <td class="DataTable3">$<%=sTotAvgTbl[2]%></td>
               <td class="DataTable3">$<%=sTotAvgTbl[3]%></td>
               <td class="DataTable3">$<%=sTotAvgTbl[4]%></td>
               <td class="DataTable3" nowrap>$<%=sTotBdgTbl[3].trim()%></td>
             </tr>
       </table>
    <tr bgColor="moccasin">
      <td ALIGN="center"><font size="-1">
        </font>
      </td>
    </tr>


<!------------- end of data table ------------------------>
<p>

       </td>
    </tr>
  </table>

</body>
</html>
<%}%>