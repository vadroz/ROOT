<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sGrp = request.getParameter("Grp");
   String sName = request.getParameter("Name");
   String sDesc = request.getParameter("Desc");
   String sSort = request.getParameter("Sort");
   String sStr = request.getParameter("Str");
   String sAction = request.getParameter("Action");
   
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
   String sUser = session.getAttribute("USER").toString();
   
   if(sAction.equals("AddGrp"))
   {
	    String sPrepStmt = "insert into rci.IStrGrp values("
	       + "'" + sGrp + "'"
	       + "," + sSort
	       + ",'" + sName + "'"	       
	       + ",'" + sDesc + "'"
         + ")";
	    System.out.println(sPrepStmt);
	    RunSQLStmt runsql = new RunSQLStmt();
	    ResultSet rslset = runsql.getResult();
	    runsql.setPrepStmt(sPrepStmt);
	    int irs = runsql.runSinglePrepStmt(sPrepStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	    runsql.disconnect();   
   }
   
   if(sAction.equals("AddGrp"))
   {
	    String sPrepStmt = "insert into rci.IStrGrp values("
	       + "'" + sGrp + "'"
	       + "," + sSort
	       + ",'" + sName + "'"	       
	       + ",'" + sDesc + "'"
         + ")";	    
	    RunSQLStmt runsql = new RunSQLStmt();
	    ResultSet rslset = runsql.getResult();
	    runsql.setPrepStmt(sPrepStmt);
	    int irs = runsql.runSinglePrepStmt(sPrepStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	    runsql.disconnect();   
   }
   else if(sAction.equals("UpdGrp"))
   {
	    String sPrepStmt = "update rci.IStrGrp set"	       
	       + " issort=" + sSort
	       + ", isgrpnm='" + sName + "'"	       
	       + ", isdesc='" + sDesc + "'"
         + " where isgrp='" + sGrp + "'";	    
	    RunSQLStmt runsql = new RunSQLStmt();
	    ResultSet rslset = runsql.getResult();
	    runsql.setPrepStmt(sPrepStmt);
	    int irs = runsql.runSinglePrepStmt(sPrepStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	    runsql.disconnect();   
   }
   else if(sAction.equals("DltGrp"))
   {
	    String sPrepStmt = "delete from rci.IStrGrp"
         + " where isgrp='" + sGrp + "'";
	    RunSQLStmt runsql = new RunSQLStmt();
	    ResultSet rslset = runsql.getResult();
	    runsql.setPrepStmt(sPrepStmt);
	    int irs = runsql.runSinglePrepStmt(sPrepStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	    runsql.disconnect();
	    
	    sPrepStmt = "delete from rci.IStrGrpS"
	      + " where itgrp='" + sGrp + "'";	      
	   	runsql = new RunSQLStmt();
	   	rslset = runsql.getResult();
	   	runsql.setPrepStmt(sPrepStmt);
	   	irs = runsql.runSinglePrepStmt(sPrepStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	   	runsql.disconnect();
   }
   else if(sAction.equals("AddStr"))
   {
	    String sPrepStmt = "insert into rci.IStrGrpS values("
	       + "'" + sGrp + "'"
	       + "," + sStr	       
         + ")";
	    RunSQLStmt runsql = new RunSQLStmt();
	    ResultSet rslset = runsql.getResult();
	    runsql.setPrepStmt(sPrepStmt);
	    int irs = runsql.runSinglePrepStmt(sPrepStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	    runsql.disconnect();   
   }
   else if(sAction.equals("DltStr"))
   {
	    String sPrepStmt = "delete from rci.IStrGrpS"
         + " where itgrp='" + sGrp + "'"
         + " and itstr=" + sStr;
	    //System.out.println(sPrepStmt);
	    RunSQLStmt runsql = new RunSQLStmt();
	    ResultSet rslset = runsql.getResult();
	    runsql.setPrepStmt(sPrepStmt);
	    int irs = runsql.runSinglePrepStmt(sPrepStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	    runsql.disconnect();   
   }

%>
<SCRIPT language="JavaScript1.2">
var action = "<%=sAction%>";
if(action.indexOf("Str") < 0) { goBack(); } 

//==============================================================================
// send employee availability to schedule
//==============================================================================
   function goBack()
   {	  
 	  parent.restart(); 
   }
</SCRIPT>
<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

