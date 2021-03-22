<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.util.*, java.text.*"%>
<%
	String sCents = request.getParameter("cents");
    String sType = request.getParameter("type");
    String sAction = request.getParameter("action");
    String sErrMsg = null;
    boolean bError = false;
    
    String sStmt = null;
    RunSQLStmt runsql = new RunSQLStmt();
    ResultSet rs = null;
    
    //System.out.println("sCents=" + sCents + " sType=" + sType + " sAmt=" + sAmt + " sReg=" + sReg
    //		 + " sClr=" + sClr + " sSpc=" + sSpc + " sAction=" + sAction);
    
    sStmt = "update RCI.EcSlsGrp set type='" + sType + "'" 	   
          + " where Cents=" + sCents;
    //System.out.println(sStmt);
	runsql = new RunSQLStmt();
	runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
%>
<script>
<%if(bError){%>parent.dispError("<%=sErrMsg%>")<%}
  else {%>parent.restart();<%}%>
</script>

sCents <%=sCents%>
<br>sType <%=sType%>
bError <%=bError%>
sErrMsg <%=sErrMsg%>




