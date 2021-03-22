<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.util.*, java.text.*"%>
<%
	String sProf = request.getParameter("prof");
    String sQty = request.getParameter("qty");
    String sAmt = request.getParameter("amt");
    String sPrc = request.getParameter("prc");
    String sAction = request.getParameter("action");
    String sErrMsg = null;
    boolean bError = false;
    
    String sStmt = null;
    RunSQLStmt runsql = new RunSQLStmt();
    ResultSet rs = null;
    
    if(sAction.equals("Add"))
    {
       sStmt = "Select * from RCI.ECMRKPRF where Profile='" + sProf + "'";            
	   runsql = new RunSQLStmt();
	   runsql.setPrepStmt(sStmt);
	   rs = runsql.runQuery();
	   if(runsql.readNextRecord()) { bError = true; sErrMsg = "Profile already exists."; }
	   else 
	   {  		   
		   rs.close();
		   runsql.disconnect();
		   sStmt = "insert into RCI.ECMRKPRF values('" + sProf + "'"
			  + "," + sQty + "," + sAmt + "," + sPrc + ")";
		   runsql = new RunSQLStmt();
		   runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);		   
	   }
    }
    else if(sAction.equals("Upd"))
    {
       sStmt = "update RCI.ECMRKPRF set min_qty=" + sQty + ", min_amt=" + sAmt + ", ffl_prc=" + sPrc 
         + " where Profile='" + sProf + "'";            
	   runsql = new RunSQLStmt();
	   runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
    }
    else if(sAction.equals("Dlt"))
    {
       sStmt = "delete from RCI.ECMRKPRF" 
         + " where Profile='" + sProf + "'";            
	   runsql = new RunSQLStmt();
	   runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
    }
%>
<script>
<%if(bError){%>parent.dispError("<%=sErrMsg%>")<%}
  else {%>parent.restart();<%}%>
</script>

sProf <%=sProf%>
<br>sQty <%=sQty%>
<br>sAmt <%=sAmt%>
bError <%=bError%>
sErrMsg <%=sErrMsg%>




