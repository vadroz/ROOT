<%@ page import="java.text.*, java.util.*, rciutility.RunSQLStmt, java.sql.ResultSet"%>
<%
    String sStr = request.getParameter("str");
    String sText = request.getParameter("text");
    String sSize = request.getParameter("size");
    String sFont = request.getParameter("font");
    String sClr = request.getParameter("clr");
    String sBack = request.getParameter("back");
    String sBlink = request.getParameter("blink");
        
    String sPrepStmt = "delete from rci.PRSTRBAN where bastr=" + sStr.trim();
    System.out.println(sPrepStmt);
    RunSQLStmt runsql = new RunSQLStmt();
    ResultSet rslset = runsql.getResult();
    int irs = runsql.runSinglePrepStmt(sPrepStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

    sPrepStmt = "insert into rci.PRSTRBAN values("
       + sStr 
       + ", '" + sText + "'" 
       + ", " + sSize
       + ", '" + sFont + "'"
       + ", '" + sClr + "'"   		   
       + ", '" + sBack + "'"
       + ", '" + sBlink + "'"
     + ")";
    System.out.println(sPrepStmt);
    runsql.setPrepStmt(sPrepStmt);
    irs = runsql.runSinglePrepStmt(sPrepStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
    runsql.disconnect();
%>
<script language="javascript">
  parent.restart();
</script>

