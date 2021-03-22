<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.util.*, java.text.*"%>
<%
String sVen = request.getParameter("Ven");
String sVenNm = request.getParameter("VenNm");
String sAcct = request.getParameter("Acct");
String sClaim = request.getParameter("Claim");
String sClaimEMail = request.getParameter("ClaimEMail");
String sClaimForm = request.getParameter("ClaimForm");
String sMainPhn = request.getParameter("MainPhn");
String sMainEMail = request.getParameter("MainEMail");
String sCont = request.getParameter("Cont");
String sContPhn1 = request.getParameter("ContPhn1");
String sContPhn2  = request.getParameter("ContPhn2");
String sContEMail = request.getParameter("ContEMail");
String sRepNm = request.getParameter("RepNm");
String sRepPhn1 = request.getParameter("RepPhn1");
String sRepPhn2 = request.getParameter("RepPhn2");
String sRepEMail = request.getParameter("RepEMail");

String sAction = request.getParameter("Action");
 
String sUser = session.getAttribute("USER").toString();

String sStmt = null;

RunSQLStmt runsql = new RunSQLStmt();
ResultSet rs = null;

if(sAction.equals("ADD") || sAction.equals("UPD"))
{
   sStmt = "Select * from RCI.PatVenP where vpven=" + sVen;   
   runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   rs = runsql.runQuery();
   
   if(runsql.readNextRecord()) 
   { 
	   rs.close();
	   runsql.disconnect();
	   sStmt = "update RCI.PatVenP set" 
	      + " VpName='" + sVenNm + "'"
	      + ", VpAcct='" + sAcct + "'"
	      + ", VpClaim='" + sClaim + "'"
	      + ", VpEMail='" + sClaimEMail + "'"
	      + ", VpCForm='" + sClaimForm + "'"
	      + ", VpMain1='" + sMainPhn + "'"
	      + ", VpMEMail='" + sMainEMail + "'"
	      + ", VpCont='" + sCont + "'"
	      + ", VpCPhon1='" + sContPhn1 + "'"
	      + ", VpCPhon2='" + sContPhn2 + "'"
	      + ", VpCEMail='" + sContEMail + "'"
	      + ", VpRep='" + sRepNm + "'"
	      + ", VpRPhon1='" + sRepPhn1 + "'"
	      + ", VpRPhon2='" + sRepPhn2 + "'"
	      + ", VpREMail='" + sRepEMail + "'"	      
	      + ", VpRUser='" + sUser + "'"
	      + ", VpRDate=current date"
	      + ", VpRTime=current time"	      
	      + " where vpven=" + sVen;   	   
	   runsql = new RunSQLStmt();
	   runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
   }
   else
   {
	   rs.close();
	   runsql.disconnect();
	   sStmt = "insert into RCI.PatVenP values("
			+ sVen 
			+ ", '" + sVenNm + "'"			
			+ ", '" + sAcct + "'"
			+ ", '" + sClaim + "'"
		    + ", '" + sClaimEMail + "'"
			+ ", '" + sClaimForm + "'"
		    + ", '" + sMainPhn + "'"
			+ ", '" + sMainEMail + "'"
		    + ", '" + sCont + "'"
			+ ", '" + sContPhn1 + "'"
		    + ", '" + sContPhn2 + "'"
			+ ", '" + sContEMail + "'"
		    + ", '" + sRepNm + "'"
			+ ", '" + sRepPhn1 + "'"
		    + ", '" + sRepPhn2 + "'"
			+ ", '" + sRepEMail + "'"		     
		    + ",'" + sUser + "', current date, current time"
		  + ")";
	   runsql = new RunSQLStmt();
	   runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);		   
   }
}
else if(sAction.equals("DLT"))
{
	sStmt = "delete from RCI.PatVenP where vpven=" + sVen;
	runsql = new RunSQLStmt();
	runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
}
rs = null;
runsql.disconnect();
runsql = null;
%>
<script>
parent.restart();
</script>




