<%@ page import="java.util.*, java.text.SimpleDateFormat, rciutility.RunSQLStmt, java.sql.*"%>
<%
   String sSku = request.getParameter("Sku");
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");

   //===========================================================================
   // check last date
   //===========================================================================
   String sPrepStmt = "select ohord, ohcust , char(ohordate, usa) as date, odqty, ohsfnam, ohslnam, ceemail"
     + " from rci.ecordh inner join rci.ecordd on ohord=odord"
     + " and odsku = " + sSku.trim()
     + " and ohordate >= '" + sFrom + "'"
     + " and ohordate <= '" + sTo + "'"
     + " inner join rci.EcCstEma on cesite=ohsite and cecust=ohcust"
     + " order by ohordate";

   //System.out.println(sPrepStmt);
   ResultSet rslset = null;
   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sPrepStmt);
   runsql.runQuery();
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
      <br>E-Commerce Special SKU Sales</b>
      <br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" >Order<br>Number</th>
          <th class="DataTable">Customer<br>Number</th>
          <th class="DataTable">Order<br>Date</th>
          <th class="DataTable">Customer Name</th>
          <th class="DataTable">Email Address</th>
        </tr>
     <!------------------------------- Data Detail --------------------------------->
      <%while(runsql.readNextRecord()){
        String sOrd = runsql.getData("ohord");
        String sCust = runsql.getData("ohcust");
        String sDate = runsql.getData("date");
        String sFirstName = runsql.getData("ohsfnam");
        String sLastName = runsql.getData("ohslnam");
        String sEMail = runsql.getData("ceemail");
      %>
        <tr class="DataTable">
          <td class="DataTable"><%=sOrd%></td>
          <td class="DataTable"><%=sCust%></td>
          <td class="DataTable"><%=sDate%></td>
          <td class="DataTable1"><%=sFirstName + " " + sLastName%></td>
          <td class="DataTable1"><%=sEMail%></td>
        </tr>
      <%}%>
      <!------------------------ End Details ---------------------------------->

   </table>
    <!----------------------- end of table ---------------------------------->

  </table>
 </body>

</html>

<%runsql.disconnect();%>
