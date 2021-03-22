<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sShortNm = request.getParameter("ShortNm");
      
   String sStmt = "select MGSHORT"
		+ " from Rci.MdGrp"
		+ " where MGSHORT='" + sShortNm + "'"
	;
   
   RunSQLStmt sql_Item = new RunSQLStmt();
   sql_Item.setPrepStmt(sStmt);
   ResultSet rs_Item = sql_Item.runQuery();
   boolean bNameFound = false;
   
   if(sql_Item.readNextRecord())
   {
      bNameFound = true;     
   }   
  
   sStmt = "select GRPC"
	+ " from Iptsfil.IPIGRPN"
	+ " where GRPC='" + sShortNm + "'"
   ;
	   
   System.out.println("\n PermMdGrpNmCheck.jsp - " + sStmt);

   sql_Item = new RunSQLStmt();
   sql_Item.setPrepStmt(sStmt);
   rs_Item = sql_Item.runQuery();
   if(sql_Item.readNextRecord())
   {
	  bNameFound = true;     
   }   
	   
   sql_Item.disconnect();
   
%>
<Name_Valid><%=bNameFound%></Name_Valid>













