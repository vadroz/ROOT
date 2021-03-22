<%@ page import="google_analytics.Ecom_Visits_Save, java.text.*, java.util.*, rciutility.RunSQLStmt, java.sql.ResultSet"%>
<%
    String sDate = request.getParameter("Date");
    String sVisits = request.getParameter("Visits");
    String sAmount = request.getParameter("Amount");
    int arg = Integer.parseInt(request.getParameter("arg")) + 1;

    //System.out.println("EcHeadcount Save - Date: " + sDate + "|" + sVisits + "|" + sAmount);

    Ecom_Visits_Save savtraf = new Ecom_Visits_Save(sDate, sVisits);   
    savtraf.disconnect();
    savtraf = null;

    String sPrepStmt = "delete from rci.EcTrafc where etdate='"
       + sDate.substring(0,4) + "-" + sDate.substring(4, 6) + "-" + sDate.substring(6) + "'";
    //System.out.println(sPrepStmt);
    RunSQLStmt runsql = new RunSQLStmt();
    ResultSet rslset = runsql.getResult();
    int irs = runsql.runSinglePrepStmt(sPrepStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

    sPrepStmt = "insert into rci.EcTrafc values('"
     + sDate.substring(0,4) + "-" + sDate.substring(4, 6) + "-" + sDate.substring(6)
     + "', " + sVisits + ")";
    //System.out.println(sPrepStmt);
    runsql.setPrepStmt(sPrepStmt);
    irs = runsql.runSinglePrepStmt(sPrepStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
    runsql.disconnect();

%>
EcHeadcount Save 
<br>Date:  <%=sDate%>
<br><%=sVisits %>
<br><%=sAmount %>

<script>
  parent.saveData_in_DB("<%=arg%>")
</script>

