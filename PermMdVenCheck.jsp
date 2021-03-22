<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sVen = request.getParameter("Ven");
      
   String sStmt = "select vnam"
		+ " from IpTsFil.IpMrVen"
		+ " where vven=" + sVen
	;
   
   System.out.println("\n MozuValidateItem.jsp - " + sStmt);

   RunSQLStmt sql_Item = new RunSQLStmt();
   sql_Item.setPrepStmt(sStmt);
   ResultSet rs_Item = sql_Item.runQuery();
   boolean bVenFound = false;
   
   if(sql_Item.readNextRecord())
   {
      bVenFound = true;     
   }   
   sql_Item.disconnect();
   
%>
<Ven_Valid><%=bVenFound%></Ven_Valid>













