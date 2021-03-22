<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
  	String sYear = request.getParameter("Year");
	String sMon = request.getParameter("Mon");
	System.out.println("Gen:" + sYear + " " + sMon);
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=SfStrSumGen.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	if(sMon.length() == 1){sMon = "0" + sMon;}
	String sParam = sYear + sMon + sUser;
	String sStmt = "call RCI.SFSTRSUM ('" + sParam + "')";
	System.out.println(sStmt);
						
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	runsql.runQuery();
	runsql.readNextRecord();  
	runsql.disconnect();
	%> 
<script type="text/javascript">
parent.location.reload();
</script>	
<%
}
%>