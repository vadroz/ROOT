<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sCode = request.getParameter("Code");

   String sStmt = null;	   
   sStmt = "select acod"
     	+ " from rci.AdvCode"
     	+ " where acod=" + sCode;
   
   //System.out.println(sStmt);

   RunSQLStmt sql_Item = new RunSQLStmt();
   sql_Item.setPrepStmt(sStmt);
   ResultSet rs_Item = sql_Item.runQuery();
   boolean bFound = false;
   if(sql_Item.readNextRecord())
   {
      bFound = true;
   }
   sql_Item.disconnect();
   sql_Item = null;
%>
<Valid><%=bFound%></Valid>












