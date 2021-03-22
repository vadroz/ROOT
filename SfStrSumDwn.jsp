<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%><%

	response.setHeader("Content-Encoding", "UTF-8");
	response.setContentType("text/csv; charset=UTF-8");
	response.setHeader("Content-Disposition","attachment; filename=StoreForceMonthlySummary.csv");

  	String sYear = request.getParameter("Year");
	String sMon = request.getParameter("Mon");
	String sType = request.getParameter("Type");

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
	
	String sStmt = "select SFSTR, SFPER, SFWEEK, SFSLS, SFBSHRS,SFADM,SFRCV,SFVIS,SFECOM,SFEVT,SFINV"
	    + ", SFERND,SFOTHR,SFRECOV, SFBSLAM + SFBNSAM as Base_Amt,SFsABR,SfNABR,SFPAYP,SFBCOM,SFBLSPF,SFBMSPF,SFCONV" 
	    + ",SFAVTK,SFIPT,SFSLRY"
		+ " from rci.SfMnSum a"
		+ " where  SfYear=" + sYear +" and SfMon=" + sMon
	    + " order by sfstr, sfper"
	    ;
	//System.out.println(sStmt);
						
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	Vector<String> vStore = new Vector<String>();
	Vector<String> vPer = new Vector<String>();
	Vector<String> vWeek = new Vector<String>();
	Vector<String> vPlan = new Vector<String>();	
	Vector<String> vSellHrs = new Vector<String>();
	
	Vector<String> vAdm = new Vector<String>();
	Vector<String> vRcv = new Vector<String>();
	Vector<String> vVis = new Vector<String>();
	Vector<String> vEcom = new Vector<String>();
	Vector<String> vEvt = new Vector<String>();
	Vector<String> vInv = new Vector<String>();
	Vector<String> vErnd = new Vector<String>();
	Vector<String> vOthr = new Vector<String>();
	Vector<String> vRecov = new Vector<String>();
	Vector<String> vBaseSellAmt = new Vector<String>();
	 
	Vector<String> vSAbr = new Vector<String>();
	Vector<String> vNAbr = new Vector<String>();
	Vector<String> vPayPrc = new Vector<String>();	
	Vector<String> vComm = new Vector<String>();
	Vector<String> vLbrSpiff = new Vector<String>();
	Vector<String> vPaySpiff = new Vector<String>();	
	Vector<String> vConv = new Vector<String>();
	Vector<String> vAvgTick = new Vector<String>();
	Vector<String> vIpt = new Vector<String>();
	Vector<String> vSalary = new Vector<String>();
						
	while(runsql.readNextRecord())
	{
		vStore.add(runsql.getData("SFSTR").trim());
		vPer.add(runsql.getData("SFPER").trim());
		vWeek.add(runsql.getData("SFWEEK").trim());
		vPlan.add(runsql.getData("SFSLS").trim());
		vSellHrs.add(runsql.getData("SFBSHRS").trim());		
		vAdm.add(runsql.getData("SFADM").trim());
		vRcv.add(runsql.getData("SfRcv").trim());
		vVis.add(runsql.getData("SFVIS").trim());
		vEcom.add(runsql.getData("SfEcom").trim());
		vEvt.add(runsql.getData("SfEvt").trim());
		vInv.add(runsql.getData("SfInv").trim());
		vErnd.add(runsql.getData("SfErnd").trim());
		vOthr.add(runsql.getData("SfOthr").trim());
		vRecov.add(runsql.getData("SfRecov").trim());
		vBaseSellAmt.add(runsql.getData("Base_Amt").trim());		 
		vSAbr.add(runsql.getData("SfsAbr").trim());
		vNAbr.add(runsql.getData("SfnAbr").trim());
		vPayPrc.add(runsql.getData("SfPayp").trim());
		vComm.add(runsql.getData("SFBCOM").trim());
		vLbrSpiff.add(runsql.getData("SFBLSPF").trim());
		vPaySpiff.add(runsql.getData("SFBMSPF").trim());
		vConv.add(runsql.getData("SfConv").trim());
		vAvgTick.add(runsql.getData("SfAvtk").trim());
		vIpt.add(runsql.getData("SfIpt").trim());
		vSalary.add(runsql.getData("SfSlry").trim());
	}
				
	String [] sStr = vStore.toArray(new String[]{});
	String [] sPer = vPer.toArray(new String[]{});
	String [] sWeek = vWeek.toArray(new String[]{});
	String [] sPlan = vPlan.toArray(new String[]{});
	String [] sSellHrs = vSellHrs.toArray(new String[]{});	
	String [] sAdm = vAdm.toArray(new String[]{});
	String [] sRcv = vRcv.toArray(new String[]{});
	String [] sVis = vVis.toArray(new String[]{});
	String [] sEcom = vEcom.toArray(new String[]{});
	String [] sEvt = vEvt.toArray(new String[]{});
	String [] sInv = vInv.toArray(new String[]{});
	String [] sErnd = vErnd.toArray(new String[]{});
	String [] sOthr = vOthr.toArray(new String[]{});
	String [] sRecov = vRecov.toArray(new String[]{});
	String [] sBaseSellAmt = vBaseSellAmt.toArray(new String[]{});	 
	String [] sSAbr = vSAbr.toArray(new String[]{});
	String [] sNAbr = vNAbr.toArray(new String[]{});
	String [] sPayPrc = vPayPrc.toArray(new String[]{});	
	String [] sComm = vComm.toArray(new String[]{});
	String [] sLbrSpiff = vLbrSpiff.toArray(new String[]{});
	String [] sPaySpiff = vPaySpiff.toArray(new String[]{});
	String [] sConv = vConv.toArray(new String[]{});
	String [] sAvgTick = vAvgTick.toArray(new String[]{});
	String [] sIpt = vIpt.toArray(new String[]{});
	String [] sSalary = vSalary.toArray(new String[]{});
			 
	rs.close();
	runsql.disconnect();%><%if(sType.equals("S")){%>Store Code,Year,Week,Net Sales,Selling Hours,Salary Hours,ABR,Base $,Payroll %,Conversion,Avg. Ticket,IPT
   <%for(int i=0; i < sStr.length; i++){%><%=sStr[i]%>,<%=sYear%>,<%=sPer[i]%>,<%=sPlan[i]%>,<%=sSellHrs[i]%>,<%=sSalary[i]%>,<%=sSAbr[i]%>,<%=sBaseSellAmt[i]%>,<%=sPayPrc[i]%>,<%=sConv[i]%>,<%=sAvgTick[i]%>,<%=sIpt[i]%>
<%}%>
<%} else if(sType.equals("N")){%>Store Code,Year,Week,Open/Close,Admin,Receiving/Delivery,Visual,EComm,Events,Errand,Other,Recovery
   <%for(int i=0; i < sStr.length; i++){%><%=sStr[i]%>,<%=sYear%>,<%=sPer[i]%>, ,<%=sAdm[i]%>,<%=sRcv[i]%>,<%=sVis[i]%>,<%=sEcom[i]%>,<%=sEvt[i]%>,<%=sErnd[i]%>,<%=sOthr[i]%>,<%=sRecov[i]%>
<%}%>
<%}%>
<%
}
%>