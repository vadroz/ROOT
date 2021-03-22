<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.util.*, java.text.*"%>
<%
	String sProf = request.getParameter("prof");
    String sQty = request.getParameter("qty");
    String sAmt = request.getParameter("amt");
    String sReg = request.getParameter("regsls");
    String sClr = request.getParameter("clr");
    String sSpc = request.getParameter("spc");
    String sAction = request.getParameter("action");
    String sErrMsg = null;
    boolean bError = false;
    
    String sStmt = null;
    RunSQLStmt runsql = new RunSQLStmt();
    ResultSet rs = null;
    
    //System.out.println("sProf=" + sProf + " sQty=" + sQty + " sAmt=" + sAmt + " sReg=" + sReg
    //		 + " sClr=" + sClr + " sSpc=" + sSpc + " sAction=" + sAction);
    
    if(sAction.equals("Add"))
    {
       sStmt = "Select * from RCI.ECDIPRF where Profile='" + sProf + "'";            
	   runsql = new RunSQLStmt();
	   runsql.setPrepStmt(sStmt);
	   rs = runsql.runQuery();
	   if(runsql.readNextRecord()) { bError = true; sErrMsg = "Profile already exists."; }
	   else 
	   {  		   
		   rs.close();
		   runsql.disconnect();
		   sStmt = "insert into RCI.ECDIPRF values('" + sProf + "'"
			  + "," + sQty + "," + sAmt + ",'" + sReg + "','" + sClr + "','" + sSpc + "')";
		   runsql = new RunSQLStmt();
		   runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);		   
	   }
    }
    else if(sAction.equals("Upd"))
    {
       sStmt = "update RCI.ECDIPRF set min_qty=" + sQty + ", min_amt=" + sAmt 
    	 + ", sls_reg='" + sReg + "'" + ", sls_clr='" + sClr + "'" + ", sls_spc='" + sSpc + "'" 	   
         + " where Profile='" + sProf + "'";
       //System.out.println(sStmt);
	   runsql = new RunSQLStmt();
	   runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
    }
    else if(sAction.equals("Dlt"))
    {
       sStmt = "delete from RCI.ECDIPRF" 
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




