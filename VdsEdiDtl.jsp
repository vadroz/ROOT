<!DOCTYPE html>	
<%@ page import=" java.util.*, java.text.*
, rciutility.RunSQLStmt, java.sql.ResultSet, rciutility.CallAs400SrvPgmSup"%>  
<%
    String sSelPo = request.getParameter("Po");
    String sSelSts = request.getParameter("Sts");
    String sSelSku = request.getParameter("Sku");
    
	String sStmt = "select papo#, pasts, padate, pashsku, pasku, PAPHONE, PAEMAIL, PAVSTYLE";
	
	if(sSelSts.equals("Shipped"))
	{
		sStmt += ", case when B### is null then ' ' else b### end as trackid";
	}
	
	sStmt += " from rci.rc855";
	
	if(sSelSts.equals("Shipped"))
	{
		sStmt += " left join IpTsFil.IPANITM on cono=papo# and csku=pashsku"
		 + " left join IpTsFil.IpAnDtl on bono=cono and basn=casn and bstr=cstr"		
		;
	}
	
	sStmt += " where papo#='" + sSelPo + "'"
	 + " and pashsku=" + sSelSku
	  ;			
	System.out.println("\n" + sStmt);
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	
	Vector<String> vSts = new Vector<String>();
	Vector<String> vDate = new Vector<String>();
	Vector<String> vItem = new Vector<String>();
	Vector<String> vOrd = new Vector<String>();
	Vector<String> vSku = new Vector<String>();	
	Vector<String> vPhone = new Vector<String>();
	Vector<String> vEmail = new Vector<String>();
	Vector<String> vVenSty = new Vector<String>();
	Vector<String> vTrackId = new Vector<String>();
	
	while(runsql.readNextRecord())
	{		
		vSts.add(runsql.getData("pasts").trim());
		vDate.add(runsql.getData("padate").trim());
		vItem.add(runsql.getData("pasku").trim());
		vSku.add(runsql.getData("pashsku").trim());
		vPhone.add(runsql.getData("PAPHONE").trim());
		vEmail.add(runsql.getData("PAEMAIL").trim());		
		vVenSty.add(runsql.getData("PAVSTYLE").trim().replaceAll("'", "&#39;"));
		if(sSelSts.equals("Shipped")) { vTrackId.add(runsql.getData("trackid").trim()); }
		else { vTrackId.add(" "); }
	}
	rs.close();
	runsql.disconnect();
	
	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
	
	String sSts  = srvpgm.cvtToJavaScriptArray(vSts.toArray(new String[vSts.size()]));
	String sDate  = srvpgm.cvtToJavaScriptArray(vDate.toArray(new String[vDate.size()]));
	String sItem  = srvpgm.cvtToJavaScriptArray(vItem.toArray(new String[vItem.size()]));
	String sSku  = srvpgm.cvtToJavaScriptArray(vSku.toArray(new String[vSku.size()]));
	String sPhone  = srvpgm.cvtToJavaScriptArray(vPhone.toArray(new String[vPhone.size()]));
	String sEmail  = srvpgm.cvtToJavaScriptArray(vEmail.toArray(new String[vEmail.size()]));
	String sVenSty = srvpgm.cvtToJavaScriptArray(vVenSty.toArray(new String[vVenSty.size()]));
	String sTrackId = srvpgm.cvtToJavaScriptArray(vTrackId.toArray(new String[vTrackId.size()]));
%>
<SCRIPT>
  var SelPo = "<%=sSelPo%>";  
  var Date = [<%=sDate%>];
  var Sts = [<%=sSts%>];
  var Item = [<%=sItem%>];
  var Sku = [<%=sSku%>];
  var Phone = [<%=sPhone%>];
  var Email = [<%=sEmail%>];
  var VenSty = [<%=sVenSty%>];
  var TrackId = [<%=sTrackId%>];
  
  parent.setPoDtl(SelPo, Date, Sts, Item, Sku, Phone, Email, VenSty, TrackId);
  
</SCRIPT>
 