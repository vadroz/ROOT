<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.util.*, java.text.*"%>
<%
String sStr = request.getParameter("Str");
String sDiv = request.getParameter("Div");
String sDpt = request.getParameter("Dpt");
String sCls = request.getParameter("Cls");
String sVen = request.getParameter("Ven");
String sProf = request.getParameter("Prof");
String sQty = request.getParameter("Qty");
String sAmt = request.getParameter("Amt");
String sAction = request.getParameter("Action");

if(sDiv == null){ sDiv = "0";}
if(sDpt == null){ sDpt = "0";}
if(sCls == null){ sCls = "0";}
if(sVen == null){ sVen = "0";}
if(sProf == null){ sProf = " ";}

if(sQty == null || sQty.trim().equals("")){sQty = "0";}
if(sAmt == null || sAmt.trim().equals("")){sAmt = "0";}
 
String sUser = session.getAttribute("USER").toString();

String sErrMsg = null;
boolean bError = false;

String sStmt = null;
RunSQLStmt runsql = new RunSQLStmt();
ResultSet rs = null;

if(sAction.equals("Add_Upd"))
{
   sStmt = "Select * from RCI.ECSTDVIN" 
    + " where div=" + sDiv + " and dpt=" + sDpt + " and class=" + sCls + " and vendor=" + sVen + " and store=" + sStr;   
   runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   rs = runsql.runQuery();
   if(runsql.readNextRecord()) 
   { 
	   rs.close();
	   runsql.disconnect();
	   sStmt = "update RCI.ECSTDVIN set" 
	      + " Profile='" + sProf + "'" + ", min_qty=" + sQty + ", min_amt=" + sAmt 
		  + ", user='" + sUser + "'" + ", rec_date=current date, rec_time=current time" 
		  + " where div=" + sDiv + " and dpt=" + sDpt + " and class=" + sCls + " and vendor=" + sVen + " and store=" + sStr;	   
	   runsql = new RunSQLStmt();
	   runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
   }
   else 
   {  		   
	   rs.close();
	   runsql.disconnect();
	   sStmt = "insert into RCI.ECSTDVIN values("
			+ sDiv + ", " + sDpt + ", " + sCls + ", " + sVen + ", " + sStr			
		    + ",'" + sProf + "'" + "," + sQty + "," + sAmt 
		    + ",'" + sUser + "', current date, current time"
		  + ")";
	   runsql = new RunSQLStmt();
	   runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);		   
   }
}
else if(sAction.equals("Remove"))
{
	sStmt = "delete from RCI.ECSTDVIN" 
		      + " where div=" + sDiv + " and dpt=" + sDpt + " and class=" + sCls + " and vendor=" + sVen + " and store=" + sStr;
	runsql = new RunSQLStmt();
	runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
}
else if(sAction.equals("STR_UPD"))
{
	sStmt = "update RCI.ECSTDVIN set" 
		      + " Profile='" + sProf + "'" + ", min_qty=" + sQty + ", min_amt=" + sAmt 
			  + ", user='" + sUser + "'" + ", rec_date=current date, rec_time=current time" 
			  + " where store=" + sStr;
	
	if(!sVen.equals("ALL")){sStmt += " and Div=" + sDiv + " and Dpt=" + sDpt + " and Class=" + sCls + " and vendor=" + sVen;}
	else if(!sCls.equals("ALL")){sStmt += " and Div=" + sDiv + " and Dpt=" + sDpt + " and Class=" + sCls;}
	else if(!sDpt.equals("ALL")){sStmt += " and Div=" + sDiv + " and Dpt=" + sDpt + " and vendor=0";}
	else if(!sDiv.equals("ALL")){sStmt += " and Div=" + sDiv + " and Class=0 and vendor=0";}
	else if( sDiv.equals("ALL")){sStmt += " and Div <> 0 and Dpt=0 and Class=0 and vendor=0";}
	
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




