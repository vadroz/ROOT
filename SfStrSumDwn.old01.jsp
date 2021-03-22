<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%><%
	response.setHeader("Content-Encoding", "UTF-8");
	response.setContentType("text/csv; charset=UTF-8");
	response.setHeader("Content-Disposition","attachment; filename=StoreForceMonthlySummary.csv");

  	String sYear = request.getParameter("Year");
	String sMon = request.getParameter("Mon");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=SfStrSumDwn.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	String sStmt = "select SFSTR, SFPER, SFWEEK, SFSLS, SFBSHRS, SFBSPAY, SFBNHRS"
		+ ",SFBNPAY, SFBCOM, SFBLSPF, SFBMSPF "
		+ " from rci.SfMnSum a"
		+ " where  SfYear=" + sYear +" and SfMon=" + sMon;
	System.out.println(sStmt);
						
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	Vector<String> vStore = new Vector<String>();
	Vector<String> vPer = new Vector<String>();
	Vector<String> vWeek = new Vector<String>();
	Vector<String> vPlan = new Vector<String>();	
	Vector<String> vSellHrs = new Vector<String>();
	Vector<String> vSellPay = new Vector<String>();
	Vector<String> vNonSellHrs = new Vector<String>();
	Vector<String> vNonSellPay = new Vector<String>();
	Vector<String> vComm = new Vector<String>();
	Vector<String> vLbrSpiff = new Vector<String>();
	Vector<String> vPaySpiff = new Vector<String>(); 
						
	while(runsql.readNextRecord())
	{
		vStore.add(runsql.getData("SFSTR").trim());
		vPer.add(runsql.getData("SFPER").trim());
		vWeek.add(runsql.getData("SFWEEK").trim());
		vPlan.add(runsql.getData("SFSLS").trim());
		vSellHrs.add(runsql.getData("SFBSHRS").trim());
		vSellPay.add(runsql.getData("SFBSPAY").trim());
		vNonSellHrs.add(runsql.getData("SFBNHRS").trim());
		vNonSellPay.add(runsql.getData("SFBNPay").trim());
		vComm.add(runsql.getData("SFBCOM").trim());
		vLbrSpiff.add(runsql.getData("SFBLSPF").trim());
		vPaySpiff.add(runsql.getData("SFBMSPF").trim());
		 
	}
				
	String [] sStr = vStore.toArray(new String[]{});
	String [] sPer = vPer.toArray(new String[]{});
	String [] sWeek = vWeek.toArray(new String[]{});
	String [] sPlan = vPlan.toArray(new String[]{});
	String [] sSellHrs = vSellHrs.toArray(new String[]{});
	String [] sSellPay = vSellPay.toArray(new String[]{});
	String [] sNonSellHrs = vNonSellHrs.toArray(new String[]{});
	String [] sNonSellPay = vNonSellPay.toArray(new String[]{});
	String [] sComm = vComm.toArray(new String[]{});
	String [] sLbrSpiff = vLbrSpiff.toArray(new String[]{});
	String [] sPaySpiff = vPaySpiff.toArray(new String[]{});
			 
	rs.close();
	runsql.disconnect();
	%>Str Code,Week,Net Sales Plan,Selling Hrs,Selling Pay,Non-Selling Hrs,Non-Selling Pay,Commission, Laybor Spiff,Pay Spiff
<%for(int i=0; i < sStr.length; i++){%><%=sStr[i]%>,<%=sPer[i]%>,<%=sPlan[i]%>,<%=sSellHrs[i]%>,<%=sSellPay[i]%>,<%=sNonSellHrs[i]%>,<%=sNonSellPay[i]%>,<%=sComm[i]%>,<%=sLbrSpiff[i]%>,<%=sPaySpiff[i]%>
<%}%>
<%
}
%>