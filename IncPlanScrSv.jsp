<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
   String sYear = request.getParameter("Year");
   String sQtr = request.getParameter("Qtr");
   String sScrCd = request.getParameter("ScrCd");
   String sScrNm = request.getParameter("ScrNm");   
   
   String [] sStr = request.getParameterValues("Str");
   String [] sScr = request.getParameterValues("Scr");
   String [] sPay = request.getParameterValues("Pay");
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER") != null)
{
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();	
	
	RunSQLStmt runsql = new RunSQLStmt();
	
	// check if record exists
	String sExist = "select MsStr from rci.INMANSCR" 
	  + " where MsName='" + sScrCd + "'" + " and MsYear=" + sYear + " and MsQtr=" + sQtr;
	System.out.println(sExist);  
	runsql.setPrepStmt(sExist);		   
	runsql.runQuery();
	
	// delete existing records for selected year/quoter and score name 
	if(runsql.readNextRecord())
	{
		runsql.disconnect();
	   	String sDelete = "delete from rci.INMANSCR" 
	   	      + " where MsName='" + sScrCd + "'" + " and MsYear=" + sYear + " and MsQtr=" + sQtr;
	   	System.out.println(sDelete);  
	   	runsql = new RunSQLStmt();
	   	runsql.setPrepStmt(sDelete);
	   	int irs = runsql.runSinglePrepStmt(sDelete, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	}
	runsql.disconnect();
	
	
	// add new scores
	for(int i=0; i < sStr.length; i++)	
	{	
		String sInsert = "insert into rci.INMANSCR values("
		 + "'" + sScrCd + "'," + sYear + "," + sQtr
		 + "," + sStr[i] + "," + sScr[i] + "," + sPay[i]
		 + ",'" + sUser + "', current date, current time"		 
   	     + ")";   	
		System.out.println(sInsert); 
		runsql = new RunSQLStmt();
   		runsql.setPrepStmt(sInsert);		   
   		int irs = runsql.runSinglePrepStmt(sInsert, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
   		runsql.disconnect();
   	    runsql = null;
   	    
	}
%>
<html>
<SCRIPT>
parent.restart(); 
</SCRIPT>
</html>
<%
}
else
{%>
	<script>
	alert("Your session is expired. Please signon again.")
	</script>
<%}%>