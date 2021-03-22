<%@ page import="rciutility.StoreSelect, payrollreports.StrAvgPay"%>
<% StrAvgPay stravgpay = null;
   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   int iNumOfWeeks = 0;

   String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");

   StrSelect = new StoreSelect();
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();

   stravgpay = new StrAvgPay(sStore);
   iNumOfWeeks = stravgpay.getNumOfWeeks();
   String [] sTyWeeks = stravgpay.getTYWeeks();
   String [] sLyWeeks = stravgpay.getLYWeeks();
   String [] sTyMonths = stravgpay.getTYMonths();

   String [] tyMgSls = stravgpay.getTYMgmSls();
   String [] tyNmSls = stravgpay.getTYNMgMls();
   String [] tyTotSls = stravgpay.getTYTotSls();

   String [] lyMgSls = stravgpay.getLYMgmSls();
   String [] lyNmSls = stravgpay.getLYNMgMls();
   String [] lyTotSls = stravgpay.getLYTotSls();

   String [] tySelHrs = stravgpay.getTYSelHrs();
   String [] tyNSlHrs = stravgpay.getTYNSlHrs();
   String [] tyTotHrs = stravgpay.getTYTotHrs();

   String [] lySelHrs = stravgpay.getLYSelHrs();
   String [] lyNSlHrs = stravgpay.getLYNSlHrs();
   String [] lyTotHrs = stravgpay.getLYTotHrs();

   String [] tySelAvg = stravgpay.getTYSelAvg();
   String [] tyNSlAvg = stravgpay.getTYNSlAvg();
   String [] tyTotAvg = stravgpay.getTYTotAvg();

   String [] lySelAvg = stravgpay.getLYSelAvg();
   String [] lyNSlAvg = stravgpay.getLYNSlAvg();
   String [] lyTotAvg = stravgpay.getLYTotAvg();
   int iAllowEntry = stravgpay.getAllowEntry();

   String [] tySelPrc = stravgpay.getTYSelPrc();
   String [] tyNSlPrc = stravgpay.getTYNSlPrc();
   String [] tyTotPrc = stravgpay.getTYTotPrc();

   String [] lySelPrc = stravgpay.getLYSelPrc();
   String [] lyNSlPrc = stravgpay.getLYNSlPrc();
   String [] lyTotPrc = stravgpay.getLYTotPrc();
   stravgpay.disconnect();
%>

<html>
<head>
<SCRIPT language="JavaScript">
	document.write("<style>body {background:ivory;}");
        document.write("a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}" );
        document.write("table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}");
        document.write("th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }");
        document.write("td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px; }");
	document.write("td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }");
        document.write("td.DataTable2 { border-bottom: darkred solid 1px;background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }");
        document.write("td.DataTable3 { background:lightgrey; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }");
        document.write("td.DataTable4 { border-bottom: darkred solid 1px;background:lightgrey; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }");
        document.write("td.DataTable5 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }");
        document.write("td.DataTable6 { border-bottom: darkred solid 1px;background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }");
        document.write("</style>");

var CurStore = <%=sStore%>;
var CurStrName = "<%=sThisStrName%>";

function bodyLoad(){
  doStrSelect();
}
// Load Stores
function doStrSelect(id) {
    var df = document.forms[0];
    var stores = [<%=sStr%>];
    var storeNames = [<%=sStrName%>];

    for (idx = 1; idx < stores.length; idx++){
        df.STORE.options[idx-1] = new Option(storeNames[idx],stores[idx]);
    }
}
function submitForm(){
   var SbmString = "AvgPayRep.jsp";
    SbmString = SbmString + "?STORE="
              + document.getStore.STORE.options[document.getStore.STORE.selectedIndex].value
              + "&STRNAME="
              + document.getStore.STORE.options[document.getStore.STORE.selectedIndex].text
    //alert(SbmString);
    window.location.href=SbmString;
}
</SCRIPT>
          </head>
 <body  onload="bodyLoad();">

         <div id="tooltip2" style="position:absolute;visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:150px;background-color:LemonChiffon; z-index:10"></div>
         <div align="CENTER" name="divTest" onMouseover="showtip2(this,event,' ');" onMouseout="hidetip2();" STYLE="cursor: hand">
         </div>

           <table border="0" width="100%" height="100%">
            <tr>
            <td height="20%" COLSPAN="2">
              <img src="Sun_ski_logo4.png" /></td>
             </tr>
             <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>Average Pay Report</b>
      <br><b>Store:&nbsp;<script>document.write(CurStrName);</script></b>
<!------------- store selector ----------------------------->
      <form name="getStore" action="javascript:submitForm();">
      Select Store <SELECT name="STORE"></SELECT>
      <input type="submit" value="GO">
      </form>
<!------------- end of store selector ---------------------->


        &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
        <a href="../"><font color="red">Home</font></a>&#62;
        <a href="../StrScheduling.html"><font color="red">Payroll</font></a>&#62;
        <a href="../APRSelector.jsp"><font color="red">Store Selector</font></a>&#62;
        Report

<!------------- start of data table ------------------------>
      <table class="DataTable" width="80%"align="center">
             <tr>
                  <th class="DataTable" rowspan="3">TY/<br>LY</th>
                  <th class="DataTable" rowspan="3">Week End</th>
                  <th class="DataTable" rowspan="2" colspan="3">Sales</th>
                  <th class="DataTable" colspan="9">Number of Hrs./Avg Wage (Non-Mgmt.)</th>
             </tr>
             <tr>
                 <th class="DataTable" colspan="3">Selling</th>
                  <th class="DataTable" colspan="3">Non-selling</th>
                  <th class="DataTable" colspan="3">Total</th>
             </tr>
                <th class="DataTable">Mgmt</th>
                <th class="DataTable">Non-Mgmt</th>
                <th class="DataTable">Total</th>
                <th class="DataTable"># of Hrs</th>
                <th class="DataTable">Avg<br>Wage</th>
                <th class="DataTable">Pay<br>%</th>
                <th class="DataTable"># of Hrs</th>
                <th class="DataTable">Avg<br>Wage</th>
                <th class="DataTable">Pay<br>%</th>
                <th class="DataTable"># of Hrs</th>
                <th class="DataTable">Avg<br>Wage</th>
                <th class="DataTable">Pay<br>%</th>
             <tr>
             </tr>
             <%for(int i=0; i < iNumOfWeeks; i++){%>
               <tr>
                   <td class="DataTable5">TY</td>
                   <td class="DataTable1">
                   <!-- Check if average pay entry is allowed -->
                   <% String sRequest = "SchedbyWeek.jsp?STORE=" + sStore
                        + "&STRNAME=" + sThisStrName
                        + "&MONBEG=" + sTyMonths[i]
                        + "&WEEKEND=" + sTyWeeks[i]
                        + "&FROM=AVGPAYREP";
                   if(iAllowEntry <= i){%>
                        <a href="<%=sRequest%>"><%=sTyWeeks[i]%></a>
                   <%}
                   else {%><%=sTyWeeks[i]%><%}%>
                     </td>


                   <td class="DataTable3">$<%=tyMgSls[i]%></td>
                   <td class="DataTable3">$<%=tyNmSls[i]%></td>
                   <td class="DataTable1">$<%=tyTotSls[i]%></td>

                   <td class="DataTable3"><%=tySelHrs[i]%></td>
                   <td class="DataTable3">$<%=tySelAvg[i]%></td>
                   <td class="DataTable1"><%=tySelPrc[i]%>%</td>

                   <td class="DataTable3"><%=tyNSlHrs[i]%></td>
                   <td class="DataTable3">$<%=tyNSlAvg[i]%></td>
                   <td class="DataTable1"><%=tyNSlPrc[i]%>%</td>

                   <td class="DataTable3"><%=tyTotHrs[i]%></td>
                   <td class="DataTable3">$<%=tyTotAvg[i]%></td>
                   <td class="DataTable3"><%=tyTotPrc[i]%>%</td>
               </tr>
               <tr>
                   <td class="DataTable6">LY</td>
                   <td class="DataTable2"><%=sLyWeeks[i]%></td>

                   <td class="DataTable4">$<%=lyMgSls[i]%></td>
                   <td class="DataTable4">$<%=lyNmSls[i]%></td>
                   <td class="DataTable2">$<%=lyTotSls[i]%></td>

                   <td class="DataTable4"><%=lySelHrs[i]%></td>
                   <td class="DataTable4">$<%=lySelAvg[i]%></td>
                   <td class="DataTable2"><%=lySelPrc[i]%>%</td>

                   <td class="DataTable4"><%=lyNSlHrs[i]%></td>
                   <td class="DataTable4">$<%=lyNSlAvg[i]%></td>
                   <td class="DataTable2"><%=lyNSlPrc[i]%>%</td>

                   <td class="DataTable4"><%=lyTotHrs[i]%></td>
                   <td class="DataTable4">$<%=lyTotAvg[i]%></td>
                   <td class="DataTable4"><%=lyTotPrc[i]%>%</td>
               </tr>
             <%}%>
       </table>

<!------------- end of data table ------------------------>
                </td>
            </tr>
       </table>

        </body>
      </html>
