<%@ page import="java.util.*, java.text.*, java.sql.*, rciutility.RunSQLStmt"%>
<%@ page contentType="application/vnd.ms-excel"%>
<%
    String sPrepStmt = "select * "
        + " from vrLIB.MyTeamSup"
        + " order by OHORDATE, OHBFNAM, OHBLNAM";

      ResultSet rs = null;
      RunSQLStmt runsql = new RunSQLStmt();
      runsql.setPrepStmt(sPrepStmt);
      rs = runsql.runQuery();
%>
<body>
<b><u>My Team Support List</u></b>
<table border=1>
  <tr>
    <th>Order Date</th>
    <th>First Name</th>
    <th>Last Name</th>
    <th>E-Mail</th>
    <th>Ride</th>
    <th>Team</th>
  </tr>
  <%while(runsql.readNextRecord())
  {
     String sOrDate = runsql.getData("OHORDATE");
     String sFirst =  runsql.getData("OHBFNAM");
     String sLast = runsql.getData("OHBLNAM");
     String sEmail = runsql.getData("ceemail");
     String sGroup = runsql.getData("agrp");
     String sTeam = runsql.getData("btteam");

     if(sOrDate==null){ sOrDate = " ";}
     if(sFirst==null){ sFirst = " ";}
     if(sLast==null){ sLast = " ";}
     if(sEmail==null){ sEmail = " ";}
     if(sGroup==null){ sGroup = " ";}
     if(sTeam==null){ sTeam = " ";}
  %>
    <tr>
      <td><%=sOrDate%></td>
      <td><%=sFirst%></td>
      <td><%=sLast%></td>
      <td><%=sEmail%></td>
      <td><%=sGroup%></td>
      <td><%=sTeam%></td>
    </tr>
  <%}%>

</table>
</body>

<%
   runsql.disconnect();
   runsql = null;
%>