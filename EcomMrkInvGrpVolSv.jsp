<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.util.*, java.text.*"%>
<%
String sMrk = request.getParameter("Mrk");
String sDiv = request.getParameter("Div");
String sProf = request.getParameter("Prof");
String sQty = request.getParameter("Qty");
String sAmt = request.getParameter("Amt");
String sPrc = request.getParameter("Prc");
String sAction = request.getParameter("Action");

if(sDiv == null){ sDiv = "0";}
if(sProf == null){ sProf = " ";}

if(sQty == null || sQty.trim().equals("")){sQty = "0";}
if(sAmt == null || sAmt.trim().equals("")){sAmt = "0";}
if(sPrc == null || sPrc.trim().equals("")){sPrc = "0";}
 
String sUser = session.getAttribute("USER").toString();

String sErrMsg = null;
boolean bError = false;

String sStmt = null;
RunSQLStmt runsql = new RunSQLStmt();
ResultSet rs = null;

if(sAction.equals("Add_Upd"))
{
   sStmt = "Select * from RCI.ECMRKLVL" 
    + " where div=" + sDiv + " and market=" + sMrk;   
   runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   rs = runsql.runQuery();
   if(runsql.readNextRecord()) 
   { 
	   rs.close();
	   runsql.disconnect();
	   sStmt = "update RCI.ECMRKLVL set" 
	      + " Profile='" + sProf + "'" + ", min_qty=" + sQty + ", min_amt=" + sAmt + ", ffl_prc=" + sPrc 
		  + ", user='" + sUser + "'" + ", rec_date=current date, rec_time=current time" 
		  + " where div=" + sDiv + " and market=" + sMrk;	   
	   runsql = new RunSQLStmt();
	   runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
   }
   else 
   {  		   
	   rs.close();
	   runsql.disconnect();
	   sStmt = "insert into RCI.ECMRKLVL values("
			+ sDiv + ", " + sMrk			
		    + ",'" + sProf + "'" + "," + sQty + "," + sAmt + "," + sPrc  
		    + ",'" + sUser + "', current date, current time"
		  + ")";
	   runsql = new RunSQLStmt();
	   runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);		   
   }
}
else if(sAction.equals("Remove"))
{
	sStmt = "delete from RCI.ECMRKLVL" 
		      + " where div=" + sDiv + " and market=" + sMrk;
	runsql = new RunSQLStmt();
	runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
}
else if(sAction.equals("STR_UPD"))
{
	sStmt = "update RCI.ECMRKLVL set" 
	   + " Profile='" + sProf + "'" + ", min_qty=" + sQty + ", min_amt=" + sAmt + ", ffl_prc=" + sPrc
	   + ", user='" + sUser + "'" + ", rec_date=current date, rec_time=current time" 
	   + " where market=" + sMrk;
	
	if(!sDiv.equals("ALL")){sStmt += " and Div=" + sDiv;}
	else if( sDiv.equals("ALL")){sStmt += " and Div <> 0";}
	
	System.out.println(sStmt);
	
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




