<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sStr = request.getParameter("str");
   String sArea = request.getParameter("area");
   String sLine = request.getParameter("line");
   String sPiYr = request.getParameter("piyr");
   String sPiMo = request.getParameter("pimo");
   String sWisCnt = request.getParameter("wis");
   String sRciCnt = request.getParameter("rci");
   String sRecUsr = request.getParameter("recusr");
   String sReCnt = request.getParameter("recnt");
   String sCommt = request.getParameter("commt");
   String sType = request.getParameter("type");
   String sAction = request.getParameter("action");
   String sTags = request.getParameter("tags");
   String sRcntBySku = request.getParameter("rcntsku");
   String sUser = request.getParameter("user");
   
   
   if(sWisCnt == null){sWisCnt = "0";}
   if(sRciCnt == null){sRciCnt = "0";}
   if(sRecUsr == null){sRecUsr = " ";}
   if(sReCnt == null){sReCnt = "N";}
   if(sCommt == null){sCommt = " ";}
   if(sType == null){sType = " ";}
   if(sRcntBySku == null){sRcntBySku = "N";}
   
if(sAction.equals("ADD") || sAction.equals("UPD") || sAction.equals("DLT"))
{
   // check if area is exists
   String sStmt =  "select SCAREA"
	  	+ " from rci.PISTARCN"
	  	+ " where SCSTR=" + sStr + " and scpiyr=" + sPiYr + " and scpimo=" + sPiMo
	  	+ " and scarea=" + sArea;   
   
   RunSQLStmt sql_Area = new RunSQLStmt();
   sql_Area.setPrepStmt(sStmt);
   ResultSet rs_Area = sql_Area.runQuery();
   
   System.out.println(sStmt);
   
   // if already excists - delete existing entries
   if(sql_Area.readNextRecord())
   {
	   sStmt =  "delete from rci.PISTARCN"
			  	+ " where SCSTR=" + sStr + " and scpiyr=" + sPiYr + " and scpimo=" + sPiMo
			  	+ " and scarea=" + sArea;
	   sql_Area = new RunSQLStmt();
	   sql_Area.setPrepStmt(sStmt);
	   int irs = sql_Area.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	   sql_Area.disconnect();
	   System.out.println(sStmt);
   }   
   
   sql_Area.disconnect();
   
   
   if(!sAction.equals("DLT"))
   {
	   sStmt = "insert into rci.PISTARCN values(" 
	  	+ sStr + "," + sPiYr + "," + sPiMo + "," + sArea
	  	+ "," + sWisCnt + "," + sRciCnt +  ", '" + sRecUsr + "','" + sReCnt 
	  	+ "','" + sCommt + "','" + sType + "','" + sRcntBySku
	  	+ "','" + sUser + "', current date, current time"
	   + ")";
	   sql_Area = new RunSQLStmt();
	   sql_Area.setPrepStmt(sStmt);
   	   int irs = sql_Area.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
       sql_Area.disconnect();
       System.out.println(sStmt);
   }
}
else if(sAction.equals("SAVTAG"))
{  
   String sStmt =  "delete from rci.PIWISARA"
		  	+ " where SwSTR=" + sStr + " and swpiyr=" + sPiYr + " and swpimo=" + sPiMo
	;
   RunSQLStmt sql_Area = new RunSQLStmt();
   sql_Area.setPrepStmt(sStmt);
   int irs = sql_Area.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
   sql_Area.disconnect();
   System.out.println(sStmt);
	
   sStmt = "insert into rci.PIWISARA values(" 
	  	+ sStr + "," + sPiYr + "," + sPiMo + "," + sTags
	  	+ ")";
   sql_Area = new RunSQLStmt();
   sql_Area.setPrepStmt(sStmt);   
   ResultSet rs_Area = sql_Area.runQuery();
   
   sql_Area.setPrepStmt(sStmt);
   irs = sql_Area.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
   sql_Area.disconnect();
   System.out.println(sStmt);    
}
%>
<Area><%=sArea%></Area><Line><%=sLine%></Line>












