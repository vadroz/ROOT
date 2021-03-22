<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sCls = request.getParameter("Cls");
   
   String sStmt = null;
   sStmt = "select ccls, clnm"
	    + " from IpTsFil.IPCLASS"
     	+ " where ccls=" + sCls;   
   
   System.out.println(sStmt);

   RunSQLStmt sql_Item = new RunSQLStmt();
   sql_Item.setPrepStmt(sStmt);
   ResultSet rs_Item = sql_Item.runQuery();
   
   boolean bClsFound = false;   
   String sClsNm = "";
   
   if(sql_Item.readNextRecord())
   {
      bClsFound = true;
      sClsNm = sql_Item.getData("clnm");      
   }
   sql_Item.disconnect();
   //System.out.println(sSku);

%>
<Cls_Valid><%=bClsFound%></Cls_Valid><Cls><%=sCls%></Cls><ClsNm><%=sClsNm%></ClsNm>












