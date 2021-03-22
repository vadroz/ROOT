<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
	String sStr = request.getParameter("Str");
	String sIncl = request.getParameter("Incl");
 
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER") != null)
{
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();	
	
	boolean bExist = false;
	RunSQLStmt runsql = new RunSQLStmt();	
	
 	String sUpdate = "update rci.MOSTRCON set"
	   + " ScIncl='" + sIncl + "'"
       + " where ScStr=" + sStr;
  	runsql = new RunSQLStmt();
   	runsql.setPrepStmt(sUpdate);
   	int irs = runsql.runSinglePrepStmt(sUpdate, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
   	runsql.disconnect();
 	
%>
<html>
<SCRIPT>
  parent.location.reload(); 

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