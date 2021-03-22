<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.text.*, java.util.*, rciutility.CallAs400SrvPgmSup"%>
<%
String sStr = request.getParameter("Str");  
String sFrom = request.getParameter("From");
String sTo = request.getParameter("To");
String sSts = request.getParameter("Sts");
String sAction = request.getParameter("Action");

if(sAction == null){ sAction = "ByAssignedDate"; }

//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{  		   
	String sStmt = null;
	RunSQLStmt runsql = new RunSQLStmt();
	ResultSet rs = null;
	
	Vector<String> vSite = new Vector<String>();
	Vector<String> vOrd = new Vector<String>();
	Vector<String> vSku = new Vector<String>();
	Vector<String> vAsgDt = new Vector<String>();
	Vector<String> vOrdDt = new Vector<String>();
	Vector<String> vDesc = new Vector<String>();
	Vector<String> vCls = new Vector<String>();
	Vector<String> vVen = new Vector<String>();
	Vector<String> vSty = new Vector<String>();
	Vector<String> vVenNm = new Vector<String>();
	Vector<String> vRet = new Vector<String>();
	Vector<String> vOrdSts = new Vector<String>();
	Vector<String> vFflSts = new Vector<String>();
	Vector<String> vPaySts = new Vector<String>();
	Vector<String> vOldPar = new Vector<String>();
	
	String [] sSite = null;
	String [] sOrd = null;
	String [] sSku = null;
	String [] sAsgDt = null;
	String [] sOrdDt = null;
	String [] sDesc = null;
	String [] sCls = null;	
	String [] sVen = null;
	String [] sSty = null;
	String [] sVenNm = null;
	String [] sRet = null;
	String [] sOrdSts = null;
	String [] sFflSts = null;
	String [] sPaySts = null;
	String [] sOldPar = null;
	
	if(sAction.equals("ByAssignedDate"))
	{	
	
		sStmt = "select opsite,  opord, opsku"	  	 
	 	+ ", char((select min(PmRecDt) from rci.MoSpLoj where pmpickid=opid"              
			 + " and pmstr=" + sStr + " and PmRecDt >= '" + sFrom + "'" 
			 + " and PmRecDt <= '" + sTo + "'"       
			 + " and pmtype = 'Assigned'), usa) as asgDt"
	 	+ ", char(OHORDATE, usa) as ohordate, ides" 
	 	+ ", digits(icls) as icls, digits(iven) as  iven, digits(isty) as isty"
	 	+ ", odret, vnam" 
	 	+ ", ohOrdSts, ohFflSts, ohPaySts"
	 	+ ", case when ildwndt <= sdstrdt then 'Y' else 'N' end as oldpar"	
	 	+ " from rci.MoOrPas"
	 	+ " inner join rci.MoOrdH on opsite=ohsite and opord=ohord"	 
	 	+ " INNER JOIN IPTSFIL.IPITHDR ON opSKU = ISKU"
	 	+ " inner join RCI.MoOrdD ON  opord= odord and  opSKU = odSKU" 
	 	+ " INNER JOIN IPTSFIL.IPMrVen ON Iven=vven"
	 	+ " inner join rci.MoPrtDtl on ilcls=icls and ilven=iven and ilsty=isty"
	 	+ " inner join rci.MoIp40C on 1=1"
	 	+ " where opsite='11961'"                                                
	 	+ " and exists(select 1 from rci.MoSpLoj where pmpickid=opid"              
	 	+ " and pmstr=" + sStr + " and PmRecDt >= '" + sFrom + "'" 
	 	+ " and PmRecDt <= '" + sTo + "'"       
	 	+ " and pmtype = 'Assigned')";
	
		if(sSts.equals("Error"))
		{	 
			sStmt += " and exists(select 1 from rci.MoSpLoj where pmpickid=opid and pmstr=" + sStr 
	 	  	+ " and pmtype = 'Error')";
		}
		else if(sSts.equals("CNF"))
		{
			sStmt += " and exists(select 1 from rci.MoSpLoj where pmpickid=opid and pmstr=" + sStr 
			 + " and pmtype in ('Cannot Fill','Sold Out','Canceled'))";
		}	
	
		sStmt += " order by opsite, opord"; 
	} 	
	else if(sAction.equals("ByStatusDate"))
	{	
	
		sStmt = "select opsite,  opord, opsku"	  	 
	 	+ ", char((select min(PmRecDt) from rci.MoSpLoj where pmpickid=opid"              
			 + " and pmstr=" + sStr        
			 + " and pmtype = 'Assigned'), usa) as asgDt"
	 	+ ", char(OHORDATE, usa) as ohordate, ides" 
	 	+ ", digits(icls) as icls, digits(iven) as  iven, digits(isty) as isty"
	 	+ ", odret, vnam" 
	 	+ ", ohOrdSts, ohFflSts, ohPaySts"
	 	+ ", case when ildwndt <= sdstrdt then 'Y' else 'N' end as oldpar"	 	 
	 	+ " from rci.MoOrPas"
	 	+ " inner join rci.MoOrdH on opsite=ohsite and opord=ohord"	 
	 	+ " INNER JOIN IPTSFIL.IPITHDR ON opSKU = ISKU"
	 	+ " inner join RCI.MoOrdD ON opOrd = odord and opSKU = odSKU"
	 	+ " INNER JOIN IPTSFIL.IPMrVen ON Iven=vven"
	 	+ " inner join rci.MoPrtDtl on ilcls=icls and ilven=iven and ilsty=isty"
	 	+ " inner join rci.MoIp40C on 1=1"
	 	+ " where opsite='11961'"                                                
	 	+ " and exists(select 1 from rci.MoSpLoj where pmpickid=opid"              
	 	+ " and pmstr=" + sStr + " and PmRecDt >= '" + sFrom + "'" 
	 	+ " and PmRecDt <= '" + sTo + "'";	 	
	 	
		if(sSts.equals("Error"))
		{
			sStmt += " and pmtype = 'Error')";		
		}
		else if(sSts.equals("Cannot Fill"))
		{
			sStmt += " and pmtype in ('Cannot Fill','Sold Out','Canceled'))";
		}
		else if(sSts.equals("Shipped"))
		{
			sStmt += " and pmtype = 'Shipped')";		
		}
		else if(sSts.equals("Cancelled"))
		{
			sStmt += " and pmtype = 'Cancelled')";		
		}
		else if(sSts.equals("Resolve"))
		{
			sStmt += " and pmtype = 'Resolve')";		
		}
		else if(sSts.equals("Problem"))
		{
			sStmt += " and pmtype = 'Problem')";		
		}
		else if(sSts.equals("Picked"))
		{
			sStmt += " and pmtype = 'Picked')";		
		}
		else if(sSts.equals("Printed"))
		{
			sStmt += " and pmtype = 'Printed')";		
		}
		else if(sSts.equals("Assigned"))
		{
			sStmt += " and pmtype = 'Assigned')";		
		}
		
		sStmt += " order by opsite, opord"; 
	} 
	
	System.out.println("\n" + sStmt);
	
	
	runsql.setPrepStmt(sStmt);
	rs = runsql.runQuery();
	
	while(runsql.readNextRecord())
	{
		vSite.add(runsql.getData("opsite").trim());
		vOrd.add(runsql.getData("opord").trim());
		vSku.add(runsql.getData("opsku").trim());
		String asgdt = runsql.getData("asgdt");
		if(asgdt == null){asgdt="Not Assigned";}
		vAsgDt.add(asgdt);
		vOrdDt.add(runsql.getData("OHORDATE").trim());
		
		String desc = runsql.getData("ides").trim();
		desc = desc.replaceAll("'", "&#39;");
		vDesc.add(desc);
		
		vCls.add(runsql.getData("icls").trim());
		vVen.add(runsql.getData("iven").trim());
		vSty.add(runsql.getData("isty").trim());
		
		String vennm = runsql.getData("vnam").trim();
		vennm = vennm.replaceAll("'", "&#39;");		
		vVenNm.add(vennm);
		
		vRet.add(runsql.getData("odret").trim());
		vOrdSts.add(runsql.getData("ohOrdSts").trim());
		vFflSts.add(runsql.getData("ohFflSts").trim());
		vPaySts.add(runsql.getData("ohPaySts").trim());
		vOldPar.add(runsql.getData("oldpar").trim());
	}
	
	sSite = vSite.toArray(new String[]{});
	sOrd = vOrd.toArray(new String[]{});
	sSku = vSku.toArray(new String[]{});
	sAsgDt = vAsgDt.toArray(new String[]{});
	sOrdDt = vOrdDt.toArray(new String[]{});
	sDesc = vDesc.toArray(new String[]{});
	sCls = vCls.toArray(new String[]{});	
	sVen = vVen.toArray(new String[]{});
	sSty = vSty.toArray(new String[]{});
	sVenNm = vVenNm.toArray(new String[]{});
	sRet = vRet.toArray(new String[]{});
	sOrdSts = vOrdSts.toArray(new String[]{});
	sFflSts = vFflSts.toArray(new String[]{});
	sPaySts = vPaySts.toArray(new String[]{});
	sOldPar = vOldPar.toArray(new String[]{});
		
	rs.close();
	runsql.disconnect();
	
	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();	
%>
	
<SCRIPT>
var str = "<%=sStr%>";
var from = "<%=sFrom%>";
var to = "<%=sTo%>";
var site = [<%=srvpgm.cvtToJavaScriptArray(sSite)%>];
var ord = [<%=srvpgm.cvtToJavaScriptArray(sOrd)%>];
var sku = [<%=srvpgm.cvtToJavaScriptArray(sSku)%>];
var asgdt = [<%=srvpgm.cvtToJavaScriptArray(sAsgDt)%>];
var orddt = [<%=srvpgm.cvtToJavaScriptArray(sOrdDt)%>];
var desc = [<%=srvpgm.cvtToJavaScriptArray(sDesc)%>];
var cls = [<%=srvpgm.cvtToJavaScriptArray(sCls)%>];
var ven = [<%=srvpgm.cvtToJavaScriptArray(sVen)%>];
var sty = [<%=srvpgm.cvtToJavaScriptArray(sSty)%>];
var vennm = [<%=srvpgm.cvtToJavaScriptArray(sVenNm)%>];
var ret = [<%=srvpgm.cvtToJavaScriptArray(sRet)%>];
var ordsts = [<%=srvpgm.cvtToJavaScriptArray(sOrdSts)%>];
var fflsts = [<%=srvpgm.cvtToJavaScriptArray(sFflSts)%>];
var paysts = [<%=srvpgm.cvtToJavaScriptArray(sPaySts)%>];
var oldpar = [<%=srvpgm.cvtToJavaScriptArray(sOldPar)%>];
  
parent.setOrdLst(str, from, to, site, ord, sku, asgdt, orddt, desc, cls, ven, sty, vennm, ret
		, ordsts, fflsts, paysts, oldpar);
   
</SCRIPT>
<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

