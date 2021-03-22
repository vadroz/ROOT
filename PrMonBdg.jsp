<%@ page import="rciutility.StoreSelect, payrollreports.PrMonBdg, java.util.*, java.text.SimpleDateFormat"%>
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
     response.sendRedirect("SignOn1.jsp?TARGET=PrMonBdg.jsp&APPL=" + sAppl + "&" + request.getQueryString());
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

  // -------------- End Security -----------------

  StoreSelect StrSelect = null;
  String sStr = null;
  String sStrName = null;

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

   PrMonBdg schbdg = new PrMonBdg(sStore, sMonth, sUser);
   int iNumOfWeeks = schbdg.getNumOfWeeks();
    String [] swk = schbdg.getWeeks();

    String [] sWeeks = schbdg.getWeeks();
    String [] sPlans = schbdg.getPlans();

    String [] sBudget = schbdg.getBudget();
    String [] sPaySched = schbdg.getPaySched();
    String [] sPayVar = schbdg.getPayVar();

    String [] sBdgPrc = schbdg.getBdgPrc();
    String [] sEmpPrc = schbdg.getEmpPrc();
    String [] sPrcVar = schbdg.getPrcVar();

    String [] sBdgMinHrs = schbdg.getBdgMinHrs();
    String [] sBdgVarMin = schbdg.getBdgVarMin();
    String [] sBdgAvr = schbdg.getBdgAvr();
    String [] sBdgVarAvr = schbdg.getBdgAvr();

    String [] sLastUser = schbdg.getLastUser();
    String [] sLastChgDate = schbdg.getLastDate();
    String [] sLastChgTime = schbdg.getLastTime();
    String [] sColor = schbdg.getColor();

    String [] sApprvSts = schbdg.getApproveSts();
    String [] sNewReq = schbdg.getNewReq();
    String [] sNewRsp = schbdg.getNewRsp();
    String [] sNewTot = schbdg.getNewTot();

    int iNumOfSec = schbdg.getNumOfSec();
    String [] sSecLst = schbdg.getSecLst();
    String [] sSecName = schbdg.getSecName();

    String [][] sSecHrs = schbdg.getSecHrs();
    String [] sTotHrs = schbdg.getTotHrs();
    String [] sTotHrsVar = schbdg.getTotHrsVar();

    String [][] sSecAvgUsg = schbdg.getSecAvgUsg();
    String [] sTotAvgUsg = schbdg.getTotAvgUsg();
    String [] sTotAvgUsgVar = schbdg.getTotAvgUsgVar();

    // --------- Totals ----------------
    String sRepPlans = schbdg.getRepPlans();

    String sRepBudget = schbdg.getRepBudget();
    String sRepPaySched = schbdg.getRepPaySched();
    String sRepPayVar = schbdg.getRepPayVar();

    String sRepBdgPrc = schbdg.getRepBdgPrc();
    String sRepEmpPrc = schbdg.getRepEmpPrc();
    String sRepPrcVar = schbdg.getRepPrcVar();

    String sRepBdgMinHrs = schbdg.getRepBdgMinHrs();
    String sRepBdgVarMin = schbdg.getRepBdgVarMin();
    String sRepBdgAvr = schbdg.getRepBdgAvr();
    String sRepBdgVarAvr = schbdg.getRepBdgAvr();

    String [] sRepSecHrs = schbdg.getRepSecHrs();
    String sRepTotHrs = schbdg.getRepTotHrs();
    String sRepTotHrsVar = schbdg.getRepTotHrsVar();

    String [] sRepSecAvgUsg = schbdg.getRepSecAvgUsg();
    String sRepTotAvgUsg = schbdg.getRepTotAvgUsg();
    String sRepTotAvgUsgVar = schbdg.getRepTotAvgUsgVar();

   schbdg.disconnect();
   schbdg = null;

   // variance allowed
   boolean bVarAllowed = sStrAllowed.startsWith("ALL") || sUser.startsWith("kknight");

   // get week beginning date
   SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");

   String [] sWkBeg = new String[sWeeks.length];
   for(int i=0; i < sWkBeg.length; i++)
   {
     sWkBeg[i] = sdf.format(new Date(sdf.parse(sWeeks[i]).getTime() - 86400000 * 6));
   }
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
   var SbmString = "PrMonBdg.jsp";
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
        <a href="PrMonBdgSel.jsp"><font color="red">Store Selector</font></a>&#62;
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
                    <a href="PrWkSched.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeeks[i]%>">
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
                     <a href="EmpNumbyHourWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeeks[i]%>&WKDATE=<%=sWkBeg[i]%>&FROM=BUDGET&WKDAY=MONDAY>">C</a>
                     <!-- &MONBEG=11/23/2009&WEEKEND=11/29/2009&WKDATE=11/23/2009&FROM=BUDGET&WKDAY=Monday&SELSEC=ALL  -->
                     <!-- &MONBEG=11/23/2009&WEEKEND=11/29/2009&WKDATE=11/29/2009&FROM=BUDGET&WKDAY=MONDAY>  -->
                 </th>

                 <td class="DataTable1">$<%=sBudget[i]%></td>
                 <td class="DataTable1">$<%=sPaySched[i]%></td>
                 <td class="DataTable3"><font color="<%=sColor[i]%>">$<%=sPayVar[i]%></font></td>

                 <th class="DataTable">&nbsp; <!--a href="PrWkPay.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeeks[i]%>">D</a></th -->

                 <td class="DataTable1"><%=sBdgPrc[i]%>%</td>
                 <td class="DataTable1"><%=sEmpPrc[i]%>%</td>
                 <td class="DataTable3"><font color="<%=sColor[i]%>"><%=sPrcVar[i]%>%</font></td>

                 <th class="DataTable"><a href="WkBdgHrs.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeeks[i]%>">B</a></th>

                 <td class="DataTable4"><%=sLastUser[i]%></td>
                 <td class="DataTable4"><%=sLastChgDate[i]%></td>
                 <td class="DataTable4"><%=sLastChgTime[i]%></td>
                 <%if (bVarAllowed) {%>
                     <th class="DataTable"><a href="BdgActVar.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&FRWKEND=<%=sWeeks[i]%>&TOWKEND=<%=sWeeks[i]%>">V</a></th>
                 <%}%>
               </tr>
             <%}%>
             <!--  ------------ Totals ---------------- -->
             <tr>
               <td class="DataTable3">Total</td>

               <th class="DataTable" colspan="4">&nbsp;</th>
               <td class="DataTable3">$<%=sRepPlans%></td>
               <th class="DataTable">&nbsp;&nbsp;</th>

               <td class="DataTable3">$<%=sRepBudget%></td>
               <td class="DataTable3">$<%=sRepPaySched%></td>
               <td class="DataTable3">$<%=sRepPayVar%></td>

               <th class="DataTable">&nbsp;&nbsp;</th>

               <td class="DataTable3"><%=sRepBdgPrc%>%</td>
               <td class="DataTable3"><%=sRepEmpPrc%>%</td>
               <td class="DataTable3"><%=sRepPrcVar%>%</td>
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
                <%for(int i=0; i < iNumOfSec; i++){%>
                  <th class="DataTable"><%=sSecName[i]%></th>
                <%}%>
                <th class="DataTable">Total</th>
                <th class="DataTable">Over<br>(Under)</th>

                <th class="DataTable">Avr<br>Wage/<br>Hrs</th>
                <%for(int i=0; i < iNumOfSec; i++){%>
                  <th class="DataTable"><%=sSecName[i]%></th>
                <%}%>
                <th class="DataTable">Total</th>
                <th class="DataTable">Over<br>(Under)</th>
             </tr>
             <tr>
             <%for(int i=0; i < iNumOfWeeks; i++){

             %>
               <tr>
                 <td class="DataTable1" width="15%"><%=sWeeks[i]%></td>
                 <!-- ------ # of Hours -------------- -->
                 <td class="DataTable6"><%=sBdgMinHrs[i]%></td>
                 <%for(int j=0; j < iNumOfSec; j++){%>
                     <td class="DataTable1"><%=sSecHrs[i][j]%></td>
                  <%}%>
                 <td class="DataTable3"><%=sTotHrs[i]%></td>
                 <td class="DataTable6" nowrap><%=sTotHrsVar[i]%></td>

                 <th class="DataTable">&nbsp;&nbsp;</th>

                 <!-- ------ Average Wage -------------- -->
                 <td class="DataTable6">$<%=sBdgAvr[i]%></td>
                  <%for(int j=0; j < iNumOfSec; j++){%>
                     <td class="DataTable1">$<%=sSecAvgUsg[i][j]%></td>
                  <%}%>

                 <td class="DataTable3">$<%=sTotAvgUsg[i]%></td>
                 <td class="DataTable6" nowrap>$<%=sTotAvgUsgVar[i]%></td>
               </tr>
             <%}%>

             <!-- ---------------------------------------------------------- -->
             <!-- Totals -->
             <!-- ---------------------------------------------------------- -->
             <tr>
               <td class="DataTable3">Total</td>

               <!-- -------- #of Hours -------------- -->
               <td class="DataTable3"><%=sRepBdgMinHrs%></td>
               <%for(int i=0; i < iNumOfSec; i++){%>
                  <td class="DataTable3"><%=sRepSecHrs[i]%></td>
               <%}%>
               <td class="DataTable3"><%=sRepTotHrs%></td>
               <td class="DataTable3" nowrap><%=sRepTotHrsVar%></td>

               <th class="DataTable">&nbsp;&nbsp;</th>

               <td class="DataTable3">$<%=sRepBdgAvr%></td>
               <%for(int i=0; i < iNumOfSec; i++){%>
                  <td class="DataTable3">$<%=sRepSecAvgUsg[i]%></td>
               <%}%>

               <td class="DataTable3">$<%=sRepTotAvgUsg%></td>
               <td class="DataTable3" nowrap>$<%=sRepTotAvgUsgVar%></td>
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