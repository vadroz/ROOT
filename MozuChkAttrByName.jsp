<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sAttr = request.getParameter("Attr");
   String sOptNm = request.getParameter("OptNm");
   String sProdId = request.getParameter("ProdId");  
   
   String sStmt = null;

   boolean bClrSiz = false;
    
   sStmt = "select pcopt, pcval"
	 + " from rci.MoPtAtr"
	 + " where pcsite='11961'"
	 + " and pctyid=" + sProdId
	 + " and pcattr='" + sAttr + "'"
	 + " and upper(pcval) = upper('" + sOptNm + "')"
	 + " fetch first 1 row only"
	 ;
   //System.out.println(sStmt);

   String sOptId = "";
   String sOptVal = "";
   boolean bError = false;
   
   RunSQLStmt sql_Attr = new RunSQLStmt();
   sql_Attr.setPrepStmt(sStmt);
   ResultSet rs_Attr = sql_Attr.runQuery();
   
   if(sql_Attr.readNextRecord())
   {  	   
	   sOptId = sql_Attr.getData("pcopt").trim();
	   sOptVal = sql_Attr.getData("pcval").trim();
   }
   else
   {
	   bError = true;
   }
   sql_Attr.disconnect();
%><Error><%=bError%></Error><OptId><%=sOptId%></OptId><OptVal><%=sOptVal%></OptVal>
 










