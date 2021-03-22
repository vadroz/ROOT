<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sStr = request.getParameter("str");
   String sStmt = "select BaStr, BaText, BaFSiz, BaFName, BaClr, BaBack, BaBlink" 
     + " from rci.PRSTRBAN " 
     + " where BaStr = " + sStr
    ;
    //System.out.println(sStmt); 
    
    RunSQLStmt sql_NewId = new RunSQLStmt();
    sql_NewId.setPrepStmt(sStmt);
    ResultSet rs_NewId = sql_NewId.runQuery();
    String sText = "";
    String sFontSz = "";
    String sFontNm = "";
    String sColor = "";
    String sBackground = "";
    String sBlink = "";
    if(sql_NewId.readNextRecord())
    {
    	sText = sql_NewId.getData("BaText").trim();
    	sFontSz = sql_NewId.getData("BaFSiz").trim();
    	sFontNm = sql_NewId.getData("BaFName").trim();
    	sColor = sql_NewId.getData("BaClr").trim();
    	sBackground = sql_NewId.getData("BaBack").trim();
    	sBlink = sql_NewId.getData("BaBlink").trim();    	
    }
    sql_NewId.disconnect();
    //System.out.println(sText); 
%>{"banner":[{"text":"<%=sText%>","size":"<%=sFontSz%>","font":"<%=sFontNm%>","color":"<%=sColor%>","background":"<%=sBackground%>","blink":"<%=sBlink%>"}] }










