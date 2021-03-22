<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*, rciutility.CallAs400SrvPgmSup"%>
<%
String sStr = request.getParameter("Str"); 
String sCash = request.getParameter("Cash");
String sCheck = request.getParameter("Check");
String sAction = request.getParameter("Action");

   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
	String sUser = session.getAttribute("USER").toString();
	System.out.println("sAction=" + sAction);
	if(sAction.equals("Add"))
	{	
		String sInsert = "insert into rci.SPDYLOG values("
				 + sStr + "," + sCash + "," + sCheck 
				 + ",'" + sUser + "', current date, current time"		 
		   	     + ")";   	
		//System.out.println(sInsert); 
		RunSQLStmt runsql = new RunSQLStmt();
		runsql.setPrepStmt(sInsert);		   
		int irs = runsql.runSinglePrepStmt(sInsert, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		runsql.disconnect();
		runsql = null;
	}	
%>
<html>  
<SCRIPT>
	parent.location.reload();
</SCRIPT>
</html>
<%
}
else{%>
	<script>alert("Your session is expired.Please signon.again.")</script>
<%}%>