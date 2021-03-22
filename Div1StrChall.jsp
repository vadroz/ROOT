<%@ page import="menu.SalesChallengeByStr , java.util.*, java.io.File"%>
<%
    String sStore = request.getParameter("Store");
    String sSrchWeek = request.getParameter("Week");

    // Charts and table for div 1 challenage
    SalesChallengeByStr slschall = new SalesChallengeByStr(sStore, sSrchWeek);
    int iNumOfRow = slschall.getNumOfRow();
%>
<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { padding- top:3px; padding-bottom:3px; text-align:center; font-size:11px;}

        tr.DataTable { background: white; font-size:10px }
        tr.DataTable0 { background: red; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-size:10px }
        tr.Divider { background: darkred; font-size:3px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable21 { background:#c58917; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}
        td.DataTable22 { background:#e7e7e7; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}
        td.DataTable23 { background:#fdd017; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}

        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}



</style>

<SCRIPT language="JavaScript1.2">
this.focus();

//==============================================================================
// Show Flash sales
//==============================================================================
function showFlashSls(str, week)
{
   var url = "FlashSalesTyLy.jsp?Store=" + str
           + "&Division=ALL"
           + "&DivName=All%20Divisions"
           + "&Department=ALL"
           + "&DptName=All%20Departments"
           + "&Class=ALL"
           + "&clsName=All%20Classes"
           + "&Date=" + week
           + "&Level=D"
           + "&Period=MTDTYLY"
           + "&Sort=GRP"
           + "&Chall=17M"

    //alert(url)
    window.location.href=url;
}

</script>
<BODY>

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <br>Store Employee Incentives
        <br>Store: <%=sStore%>
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <font size="-1">This Page.</font>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbStrSls">
         <tr class="DataTable">
             <%if(sStore.equals("ALL")){%><th class="DataTable" rowspan=2>Store</th><%}%>
             <th class="DataTable" rowspan=2>Week</th>
               <th class="DataTable" rowspan=2>F<br>l<br>a<br>s<br>h</th>
             <th class="DataTable" colspan=3>Weekly</th>
             <th class="DataTable" rowspan=2>&nbsp;</th>
             <th class="DataTable" colspan=6>Cumulative</th>
             <th class="DataTable" rowspan=2>&nbsp;</th>
             <th class="DataTable" colspan=2>Hours</th>
             <th class="DataTable" rowspan=2>&nbsp;</th>
             <th class="DataTable" colspan=2>Dollars</th>
         </tr>
         <tr class="DataTable">
             <th class="DataTable">TY</th>
             <th class="DataTable">LY</th>
             <th class="DataTable">Inc</th>

             <th class="DataTable">TY</th>
             <th class="DataTable">LY</th>
             <th class="DataTable">Inc</th>

             <th class="DataTable">TY<br>(2nd)</th>
             <th class="DataTable">LY<br>(2nd)</th>
             <th class="DataTable">Inc<br>(2nd)</th>

             <!-- th class="DataTable">TY<br>(3rd)</th>
             <th class="DataTable">LY<br>(3rd)</th>
             <th class="DataTable">Inc<br>(3rd)</th -->

             <th class="DataTable">This<br>Week</th>
             <th class="DataTable">All<br>Weeks</th>
             <th class="DataTable">This<br>Week</th>
             <th class="DataTable">All<br>Weeks</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfRow; i++ )
         {
            slschall.setWeekSls();
            String sStr = slschall.getStr();
            String sWeek = slschall.getWeek();
            String sTySales = slschall.getTySales();
            String sLySales = slschall.getLySales();
            String sSlsVar = slschall.getSlsVar();

            String sTyComSls = slschall.getTyComSls();
            String sLyComSls = slschall.getLyComSls();
            String sComVar = slschall.getComVar();
            String sWkHrs = slschall.getWkHrs();
            String sComHrs = slschall.getComHrs();
            String sIncAmt = slschall.getIncAmt();
            String sComAmt = slschall.getComAmt();
            String sTyComSls1 = slschall.getTyComSls1();
            String sLyComSls1 = slschall.getLyComSls1();
            String sComVar1 = slschall.getComVar1();
            String sTyComSls2 = slschall.getTyComSls2();
            String sLyComSls2 = slschall.getLyComSls2();
            String sComVar2 = slschall.getComVar2();
            String sPlace = slschall.getPlace();

            String [] sColor = new String[]{ sPlace, sPlace, sPlace };
            double [] dVar = new double[]{0, 0, 0};

            dVar[0] = Double.parseDouble(sComVar);
            // 2nd chance color changes
            dVar[1] = Double.parseDouble(sComVar1);
            //3rd chance color changes
            dVar[2] = Double.parseDouble(sComVar2);

            // select the best result and discolored other
            for(int k=0; k < 3; k++)
            {
                for(int j=0; j < 3; j++)
                {
                   if (k != j)
                   {
                      if (dVar[k] >= dVar[j]) { sColor[j] = ""; }
                      else {sColor[k] = "";}
                   }
                }
            }
        %>
            <tr id="trWeek" class="DataTable">
              <%if(sStore.equals("ALL")){%><td class="DataTable" nowrap ><%=sStr%></td><%}%>
              <td class="DataTable" nowrap ><%=sWeek%></td>
              <th class="DataTable"><a href="javascript: showFlashSls('<%=sStr%>', '<%=sWeek%>')">F</a></th>
              <td class="DataTable2" nowrap >$<%=sTySales%></td>
              <td class="DataTable2" nowrap >$<%=sLySales%></td>
              <td class="DataTable2" nowrap ><%=sSlsVar%>%</td>
                <th class="DataTable">&nbsp;</th>
              <td class="DataTable2" nowrap >$<%=sTyComSls%></td>
              <td class="DataTable2" nowrap >$<%=sLyComSls%></td>
              <td class="DataTable2<%=sColor[0]%>" nowrap ><%=sComVar%>%</td>
              <td class="DataTable2" nowrap >$<%=sTyComSls1%></td>
              <td class="DataTable2" nowrap >$<%=sLyComSls1%></td>
              <td class="DataTable2<%=sColor[1]%>" nowrap ><%=sComVar1%>%</td>
              <!--td class="DataTable2" nowrap >$<%=sTyComSls2%></td>
              <td class="DataTable2" nowrap >$<%=sLyComSls2%></td>
              <td class="DataTable2<%=sColor[2]%>" nowrap ><%=sComVar2%>%</td-->
                 <th class="DataTable">&nbsp;</th>
              <td class="DataTable2" nowrap ><%=sWkHrs%></td>
              <td class="DataTable2" nowrap ><%=sComHrs%></td>
              <th class="DataTable">&nbsp;</th>
              <td class="DataTable2" nowrap >$<%=sIncAmt%></td>
              <td class="DataTable2" nowrap >$<%=sComAmt%></td>
            </tr>
       <%}%>
   <!-- ================================ Totals ============================ -->
   <%if(sStore.equals("ALL")){%>
       <tr id="trWeek" class="Divider">
              <td colspan=19>&nbsp;</td>
       </tr>
       <%
            slschall.setTotal();
            String sTySales = slschall.getTySales();
            String sLySales = slschall.getLySales();
            String sSlsVar = slschall.getSlsVar();

            String sTyComSls = slschall.getTyComSls();
            String sLyComSls = slschall.getLyComSls();
            String sComVar = slschall.getComVar();
            String sWkHrs = slschall.getWkHrs();
            String sComHrs = slschall.getComHrs();
            String sIncAmt = slschall.getIncAmt();
            String sComAmt = slschall.getComAmt();
            String sTyComSls1 = slschall.getTyComSls1();
            String sLyComSls1 = slschall.getLyComSls1();
            String sComVar1 = slschall.getComVar1();
            String sTyComSls2 = slschall.getTyComSls2();
            String sLyComSls2 = slschall.getLyComSls2();
            String sComVar2 = slschall.getComVar2();
       %>
            <tr id="trWeek" class="DataTable1">
              <td class="DataTable" nowrap colspan=2 >Total</td>
              <th class="DataTable">
                 <%if(sStore.equals("ALL")) {%>
                     <a href="javascript: showFlashSls('ALL', '<%=sSrchWeek%>')">F</a>
                 <%} else {%>&nbsp;<%}%>
              </th>
              <td class="DataTable2" nowrap >$<%=sTySales%></td>
              <td class="DataTable2" nowrap >$<%=sLySales%></td>
              <td class="DataTable2" nowrap ><%=sSlsVar%>%</td>
              <th class="DataTable">&nbsp;</th>
              <td class="DataTable2" nowrap >$<%=sTyComSls%></td>
              <td class="DataTable2" nowrap >$<%=sLyComSls%></td>
              <td class="DataTable2" nowrap ><%=sComVar%>%</td>
              <td class="DataTable2" nowrap >$<%=sTyComSls1%></td>
              <td class="DataTable2" nowrap >$<%=sLyComSls1%></td>
              <td class="DataTable2" nowrap ><%=sComVar1%>%</td>
              <!--td class="DataTable2" nowrap >$<%=sTyComSls2%></td>
              <td class="DataTable2" nowrap >$<%=sLyComSls2%></td>
              <td class="DataTable2" nowrap ><%=sComVar2%>%</td -->
                <th class="DataTable">&nbsp;</th>
              <td class="DataTable2" nowrap ><%=sWkHrs%></td>
              <td class="DataTable2" nowrap ><%=sComHrs%></td>
              <th class="DataTable">&nbsp;</th>
              <td class="DataTable2" nowrap >$<%=sIncAmt%></td>
              <td class="DataTable2" nowrap >$<%=sComAmt%></td>
            </tr>
     <%}%>
     </table><br><br>
<!-- ======================================================================= -->
 <table border=0 cellPadding="0" cellSpacing="0" style="text-align:center;">
         <tr>
            <th colspan=3>Extra pay per hour </th>
            <th rowspan=4 style="font-size:18px; padding-left:10px; vertical-align:middle;">
                Achievement is <br> based on <br> cumulative <br> percentage <br> increase.</th>
         </tr>
         <tr>
           <td>&nbsp;</td>
           <td>&nbsp;</td>
           <td style="background: #fdd017;">15%<br>$1.00</td>
         </tr>
         <tr>
           <td>&nbsp;</td>
           <td style="background: #e7e7e7;">10%<br>75&#162;</td>
           <td style="background: #fdd017;">&nbsp;</td>
         </tr>
         <tr>
           <td style="background: #c58917;">5%<br>50&#162;</td>
           <td style="background: #e7e7e7;">&nbsp;</td>
           <td style="background: #fdd017;">&nbsp;</td>
         </tr>

         <tr>
           <td>Bronze</td><td>Silver</td><td>Gold</td>
         </tr>
         <tr>
           <td colspan=4><b>Group1: 3, 4, 5, 8, 10, 11, 20, 28, 30, 35, 40, 45, 46, 50, 61, 82 86, 88 and 98</b></td>
         </tr>
     </table>
<!-- ======================================================================= -->

<br><br>
     <table border=0 cellPadding="0" cellSpacing="0" style="text-align:center;">
         <tr>
            <th colspan=3>Extra pay per hour </th>
            <th rowspan=4 style="font-size:18px; padding-left:10px; vertical-align:middle;">
                Achievement is <br> based on <br> cumulative <br> percentage <br> increase.</th>
         </tr>
         <tr>
           <td>&nbsp;</td>
           <td>&nbsp;</td>
           <td style="background: #fdd017;">15%<br>$1.00</td>
         </tr>
         <tr>
           <td>&nbsp;</td>
           <td style="background: #e7e7e7;">10%<br>75&#162;</td>
           <td style="background: #fdd017;">&nbsp;</td>
         </tr>
         <tr>
           <td style="background: #c58917;">5%<br>50&#162;</td>
           <td style="background: #e7e7e7;">&nbsp;</td>
           <td style="background: #fdd017;">&nbsp;</td>
         </tr>

         <tr>
           <td>Bronze</td><td>Silver</td><td>Gold</td>
         </tr>
         <tr>
           <td colspan=4><b>Group2: 70, 92* and 96*</b></td>
         </tr>

         <tr>
           <td colspan=4 style="font-size:11px;">* - Dollar goals for new stores to be adjusted monthly</td>
         </tr>
     </table>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY>
</HTML>
<%
   slschall.disconnect();
   slschall = null;
%>