<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sSite = request.getParameter("Site");
   String sOrder = request.getParameter("Order");
      
   String sDelete = "delete from rci.MOORSTSH where ShSite=" + sSite
	 + " and ShOrd=" + sOrder;
   
   //System.out.println(sDelete);  
   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sDelete);
   int irs = runsql.runSinglePrepStmt(sDelete, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
   runsql.disconnect();
   
%>
<script>
   parent.restart();
</script>
 










