<!DOCTYPE html>	
<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
String sPgm = request.getParameter("pgm");
String sProc = request.getParameter("proc");
String sLimit = request.getParameter("limit");
String sCount = request.getParameter("count");
String sAction = request.getParameter("action");

String sStmt = null;
RunSQLStmt runsql = new RunSQLStmt();
ResultSet rs = null;

if(sAction.equals("Reset") || sAction.equals("Chg"))
{
	sStmt = "update RCI.XxDbgCtl set Limit=" + sLimit + ", count=" + sCount
	  + ", rec_dt=current date, rec_tm=current time"		
	  + " where srv_pgm='" + sPgm + "' and process='" + sProc + "'";
	//System.out.println(sStmt);
	runsql = new RunSQLStmt();
	runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	
	runsql.disconnect();
	sStmt = "delete from RCI.EcUData where UdSite='" + sPgm + "'" + " and UdTable='" + sProc + "'";
	System.out.println(sStmt);
	runsql = new RunSQLStmt();
	runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
} 
else if(sAction.equals("Add"))
{
	runsql.disconnect();
	sStmt = "insert into RCI.XxDbgCtl values('" + sPgm + "'"
		  + ",'" + sProc + "'," + sLimit + "," + sCount + ", current date, current time)";
	System.out.println(sStmt);
	runsql = new RunSQLStmt();
	runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);		
}
else if(sAction.equals("Dlt"))
{
	sStmt = "delete from RCI.XxDbgCtl"		
	  + " where srv_pgm='" + sPgm + "' and process='" + sProc + "'";
	System.out.println(sStmt);
	runsql = new RunSQLStmt();
	runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
}
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">


<SCRIPT>
parent.location.reload();
</SCRIPT>

