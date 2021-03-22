<%@ page import="java.util.*, payrollreports.PrSchedVsActual"%>
<%
   String sStore = request.getParameter("Store");
   String sWkend = request.getParameter("Wkend");

   String sUser = session.getAttribute("USER").toString();

   PrSchedVsActual schact = new PrSchedVsActual(sStore, sWkend, sUser);
   int iMaxPeriod = schact.getMaxPeriod();
%>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }

        tr.DataTable { background: #E7E7E7; font-size:12px }
        tr.DataTable0 { background: red; font-size:12px }
        tr.DataTable1 { background: CornSilk; font-size:12px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
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

<body>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
      <br>Monthly Payroll Schedule vs. Budget/Actual</b>

      <br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" >Category</th>
          <th class="DataTable" >Mon</th>
          <th class="DataTable" >Tue</th>
          <th class="DataTable" >Wed</th>
          <th class="DataTable" >Thu</th>
          <th class="DataTable" >Fri</th>
          <th class="DataTable" >Sat</th>
          <th class="DataTable" >Sun</th>
          <th class="DataTable" >&nbsp;</th>
          <th class="DataTable" >Weekly<br>Total</th>
          <th class="DataTable" >&nbsp;</th>
          <th class="DataTable" >Fiscal<br>M-T-D</th>
          <th class="DataTable" >&nbsp;</th>
          <th class="DataTable" >Fiscal<br>Monthend</th>
        </tr>
     <!------------------------------- Schdule Hours -------------------------->
     <%
       schact.setSched();
       String [] sHours = schact.getHours();
       String [] sPayAmt = schact.getPayAmt();
     %>
     <tr><th class="DataTable" colspan=14>Schedule</th></tr>
     <tr class="DataTable">
        <td class="DataTable">Hours</td>
        <%for(int i=0; i < iMaxPeriod; i++){%>
           <td class="DataTable"><%=sHours[i]%></td>
           <%if(i >= 6 && i < iMaxPeriod - 1){%><th class="DataTable" >&nbsp;</th><%}%>
        <%}%>
      </tr>
      <!------------------------------- Schdule pay amount -------------------->
      <tr class="DataTable">
        <td class="DataTable">Pay Amounts</td>
        <%for(int i=0; i < iMaxPeriod; i++){%>
           <td class="DataTable">$<%=sPayAmt[i]%></td>
           <%if(i >= 6 && i < iMaxPeriod - 1){%><th class="DataTable" >&nbsp;</th><%}%>
        <%}%>
      </tr>

      <!------------------------------- Actual Hours -------------------------->
     <%
       schact.setActual();
       sHours = schact.getHours();
       sPayAmt = schact.getPayAmt();
     %>
     <tr><th class="DataTable" colspan=14>Actual</th></tr>
     <tr class="DataTable">
        <td class="DataTable">Hours</td>
        <%for(int i=0; i < iMaxPeriod; i++){%>
           <td class="DataTable"><%=sHours[i]%></td>
           <%if(i >= 6 && i < iMaxPeriod - 1){%><th class="DataTable" >&nbsp;</th><%}%>
        <%}%>
      </tr>
      <!------------------------------- Actual pay amount -------------------->
      <tr class="DataTable">
        <td class="DataTable">Pay Amounts</td>
        <%for(int i=0; i < iMaxPeriod; i++){%>
           <td class="DataTable">$<%=sPayAmt[i]%></td>
           <%if(i >= 6 && i < iMaxPeriod - 1){%><th class="DataTable" >&nbsp;</th><%}%>
        <%}%>
      </tr>

      <!------------------------ End Details ---------------------------------->

   </table>
    <!----------------------- end of table ---------------------------------->

  </table>
 </body>

</html>

<%schact.disconnect();%>
