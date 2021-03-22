<%@ page import="javax.servlet.*"%>
<%@ page import="java.util.Vector, java.math.BigDecimal"%>
<%@ page import="strschdinq.TimeTblLst, strschdinq.SlsCharts"%>

<% TimeTblLst timtbl = null;
   SlsCharts slschr = null;
   String sStore = request.getParameter("STORE");
   String sYear = request.getParameter("YEAR");
   String sMonth = request.getParameter("MONTH");
   String sDay = request.getParameter("DAY");

   timtbl = new TimeTblLst(sStore, sYear, sMonth, sDay);
   slschr = new SlsCharts(sStore, sYear, sMonth, sDay);

   int iEmpNum = timtbl.getEmpNum();
   String [] sEmpName = timtbl.getEmpName();
   String [] sDept = timtbl.getDept();
   Vector vTime = timtbl.getTime();
   String [] sTime = null;
   String [] sElapse = timtbl.getElapse();

   int iSlsEmpNum = slschr.getEmpNum();
   String [] sAmount = slschr.getAmount();
   String [] sAxleY = slschr.getAxleY();
   String [] sHeight = slschr.getHeight();
   String [] sSign = slschr.getSign();
   int iZeroBox = slschr.getZeroBox();

%>
 <html>
	 <head>
           <SCRIPT language="JavaScript">
		document.write("<style>body {background:ivory;}");
                document.write("table.DataTable { background:#FFE4C4;border: darkred solid 1px;text-align:center;}");
                document.write("th.DataTable  { background:#FFCC99;padding-top:5px; padding-bottom:3px; border-right: darkred solid 1px; border-bottom: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:10px }");
                document.write("th.DataTable1 { background:#FFCC99;padding-top:5px; padding-bottom:3px; border-right: darkred solid 1px; border-bottom: darkred solid 1px;text-align:left; font-family:Verdanda; font-size:10px }");
                document.write("td.DataTable  { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }");
                document.write("td.DataTable1  { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px; }");
		document.write("td.DataTable2 { border-bottom: lightgrey solid 1px; text-align:left; font-family:Arial; font-size:10px }");
                document.write("td.DataTable3 { border-right: black solid 1px; text-align:right; font-family:Arial; font-size:10px }");
                document.write("td.DataTable4 { border-top: black solid 1px; text-align:right; font-family:Arial; font-size:10px }");
                document.write("td.DataTable5 { border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:10px }");
                document.write("td.DataTable6 { border-left: darkred solid 1px; border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }");
                document.write("td.DataTable7 { border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }");
		document.write("</style>");
           </SCRIPT>
          </head>
         <body>
      <P align="center"/>
      <b><font size=-1>Retail Concepts, Inc
      <br/>Store Scheduling Inquiry&#160;&#160;&#160;&#160;
      <br/>Store:<%=sStore%> Date:<%=sMonth + "/" + sDay + "/" + sYear%></font></b>

    <table class="DataTable" cellPadding="0" cellSpacing="0" >
             <tr>
                  <td colspan="72" class="DataTable1" bgcolor="white">&#160;&#160;&#160;&#160;
                     <font style="background: blue; border: black solid 1px;">&#160;&#160;&#160;</font> - Working Hours&#160;&#160;&#160;&#160;
                     <font style="background: yellow; border: black solid 1px;">&#160;&#160;&#160;</font> - Lunches /Breaks&#160;&#160;&#160;&#160;
                     <font style="background: red; border: black solid 1px;">&#160;&#160;&#160;</font> - Clocking Errors&#160;&#160;&#160;&#160;
                  </td>
             </tr>
             <tr>
                  <td rowspan="2" class="DataTable1" nowrap>Employee<br/>Number and Name</td>
                  <td rowspan="2" class="DataTable" nowrap>Dept</td>
                  <td colspan="4" class="DataTable">07</td>
                  <td colspan="4" class="DataTable">08</td>
                  <td colspan="4" class="DataTable">09</td>
                  <td colspan="4" class="DataTable">10</td>
                  <td colspan="4" class="DataTable">11</td>
                  <td colspan="4" class="DataTable">12</td>
                  <td colspan="4" class="DataTable">13</td>
                  <td colspan="4" class="DataTable">14</td>
                  <td colspan="4" class="DataTable">15</td>
                  <td colspan="4" class="DataTable">16</td>
                  <td colspan="4" class="DataTable">17</td>
                  <td colspan="4" class="DataTable">18</td>
                  <td colspan="4" class="DataTable">19</td>
                  <td colspan="4" class="DataTable">20</td>
                  <td colspan="4" class="DataTable">21</td>
                  <td colspan="4" class="DataTable">22</td>
                  <td colspan="4" class="DataTable">23</td>
                  <td rowspan="2" class="DataTable" nowrap>Total<br/>Hours</td>
                  <td rowspan="2" class="DataTable7" nowrap>Employee<br/>Sales</td>
             </tr>
             <tr>
               <%for (int j=0; j < 68; j++){%>
                 <%="<td class='DataTable'>&#160;</td>"%>
               <%}%>

             </tr>
           <% for (int i=0; i < iEmpNum; i++){%>
             <tr>
              <%="<td class='DataTable1' nowrap bgcolor='lightgrey'>" + sEmpName[i] + "</td>"%>
              <%="<td class='DataTable' nowrap bgcolor='lightgrey'>" + sDept[i] + "</td>"%>

              <%sTime = (String[]) vTime.get(i);%>
              <%for (int j=0; j < 68; j++){%>
                 <%="<td class=DataTable2 bgcolor=" + sTime[j] + ">&#160;&#160;&#160;</td>"%>
              <%}%>
              <!-- Time at work-->
              <%="<td class='DataTable6' nowrap bgcolor='lightgrey'>" + sElapse[i] + "</td>"%>
              <!-- Employee Sales amount -->
              <%="<td class='DataTable7' nowrap bgcolor='lightgrey'>" + sAmount[i] + "</td>"%>
             </tr>
           <%}%>

           <%//test number of employee coming from timetbllst and slscharts program
             // if some employee is not on time clocking list add extra line to show correct amount
           if(iSlsEmpNum > iEmpNum){%>
              <tr><td class="DataTable1" bgcolor="lightgrey">Other</td>
               <td class="DataTable1" bgcolor="lightgrey">&#160;</td>
               <td colspan="68" class="DataTable2" bgcolor="white">&#160;</td>
               <td class="DataTable6" bgcolor="lightgrey">0:00</td>
               <td class="DataTable7" bgcolor="lightgrey"><%=sAmount[iSlsEmpNum-1]%></td>
              </tr>
           <%}%>

           <tr><td class="DataTable1" bgcolor="cornsilk">Total</td>
               <td class="DataTable1" bgcolor="cornsilk">&#160;</td>
               <td colspan="68" class="DataTable2" bgcolor="cornsilk">&#160;</td>
               <td class="DataTable6" bgcolor="cornsilk"><%=sElapse[50]%></td>
               <td class="DataTable7" bgcolor="cornsilk"><%=sAmount[50]%></td>
              </tr>

        <!-- -----------------Positive block---------------------- -->

             <tr><td class="DataTable" rowspan="<%=iZeroBox%>"><%="Total Sales: " + sAmount[101]%></td>
                 <td class="DataTable3"><%=sAxleY[0]%></td>
              <%for(int i=0;i < 17; i++){%>
                 <td colspan="4"  rowspan="<%=iZeroBox%>" valign="bottom"  class="DataTable5">
                   <%if (sSign[i].equals("P")){%>
                    <div id="Layer1"  style="height:<%=(sHeight[i])%>px; z-index:1; background-color: green; layer-background-color: green; border-right: white solid 1px"></div>
                   <%}
                   else {%><%="&#160;"%> <%}%>
                 </td>
              <%}%>
             </tr>
             <%for(int i=0; i < (iZeroBox-1); i++){%>
                   <tr><td class="DataTable3"><%= sAxleY[i+1]%></td></tr>
              <%}%>
        <!-- ------------------End Positive block------------------- -->
        <!-- -----------------Negative block---------------------- -->
        <%if (iZeroBox < 11) {%>
             <tr><td rowspan="<%=12 - iZeroBox%>"></td>
                 <td class="DataTable3">0</td>
                   <%for(int i=0;i < 17; i++){%>
                 <td colspan="4" rowspan="<%=12 - iZeroBox%>" valign="top"  class="DataTable4">
                   <%if (sSign[i].equals("N")){%>
                        <div id="Layer1"  style="height:<%=(sHeight[i])%>px; z-index:1; background-color: red; layer-background-color: red; border-right: white solid 1px"></div>
                   <%}
                   else {%><%="&#160;"%> <%}%>
                 </td>
              <%}%>
             </tr>
          <%for(int i=iZeroBox; i < (iZeroBox + 1); i++){%>
              <tr><td class="DataTable3"><%=sAxleY[i]%></td></tr>
           <%}%>
         <%}%>
        <!-- ------------------End Negative block------------------- -->
                 <tr>
                  <td rowspan="2" nowrap>&#160;</td>
                  <td rowspan="2" nowrap>&#160;</td>
                  <td colspan="4" class="DataTable4">07</td>
                  <td colspan="4" class="DataTable4">08</td>
                  <td colspan="4" class="DataTable4">09</td>
                  <td colspan="4" class="DataTable4">10</td>
                  <td colspan="4" class="DataTable4">11</td>
                  <td colspan="4" class="DataTable4">12</td>
                  <td colspan="4" class="DataTable4">13</td>
                  <td colspan="4" class="DataTable4">14</td>
                  <td colspan="4" class="DataTable4">15</td>
                  <td colspan="4" class="DataTable4">16</td>
                  <td colspan="4" class="DataTable4">17</td>
                  <td colspan="4" class="DataTable4">18</td>
                  <td colspan="4" class="DataTable4">19</td>
                  <td colspan="4" class="DataTable4">20</td>
                  <td colspan="4" class="DataTable4">21</td>
                  <td colspan="4" class="DataTable4">22</td>
                  <td colspan="4" class="DataTable4">23</td>
             </tr>
         </table>

        </body>
        <SCRIPT>
        </SCRIPT>
 </html>
