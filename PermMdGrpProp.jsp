<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*
, rciutility.CallAs400SrvPgmSup"%>
<%
    String sBatch = request.getParameter("Batch");
	String sStmt = "select MGSHORT,MGLONG,MGBATCH,MGSTS,MGCDAT,MGCTIM,MGCUSER,MGBSRLVL" 
     + ",MGPERM,MGFRLRI,MGTOLRI,MGFRLSI,MGTOLSI,MGCLRN,MGMINRET,MGMAXRET,MGPRCNT, MGPRCEND"
   	 + " from rci.MdGrp"
   	 + " where MgBATCH=" + sBatch;
   		
   	//System.out.println(sStmt);
   	
   	ResultSet rslset = null;
   	RunSQLStmt runsql = new RunSQLStmt();
   	runsql.setPrepStmt(sStmt);		   
   	runsql.runQuery();
   	
   	String sShortNm = "";
   	String sLongNm = "";
   	String sBsrLvl = "";
   	String sPerm = "";
   	String sClearance = "";
   	String sFrRcvDt = "";
   	String sToRcvDt = "";
   	String sFrSlsDt = "";
   	String sToSlsDt = "";
   	String sFrMkdwnDt = "";
   	String sToMkdwnDt = "";
   	String sMdPrc = "";
   	String sMdCent = "";
   	String sMinRet = "";
   	String sMaxRet = "";
   	   	
   	if(runsql.readNextRecord())
   	{
   	 	sShortNm = runsql.getData("MGSHORT");
   	 	sLongNm = runsql.getData("MGLONG");
   	 	sBsrLvl = runsql.getData("MGBSRLVL");
    	sPerm = runsql.getData("MGPERM");
    	sClearance = runsql.getData("MGCLRN");
    	
    	sFrRcvDt = runsql.getData("MGFRLRI");
    	if(sFrRcvDt == null){ sFrRcvDt = ""; }
    	
    	sToRcvDt = runsql.getData("MGTOLRI");
    	if(sToRcvDt == null){ sToRcvDt = ""; }
    	
    	sFrSlsDt = runsql.getData("MGFRLSI");
    	if(sFrSlsDt == null){ sFrSlsDt = ""; }
    	
    	sToSlsDt = runsql.getData("MGTOLSI");
    	if(sToSlsDt == null){ sToSlsDt = ""; }
    	
    	sFrMkdwnDt = runsql.getData("MGFRLMI");
    	if(sFrMkdwnDt == null){ sFrMkdwnDt = ""; }
    	
    	sToMkdwnDt = runsql.getData("MGTOLMI");
    	if(sToMkdwnDt == null){ sToMkdwnDt = ""; }
    	
    	sMdPrc = runsql.getData("MGPRCNT");
    	sMdCent = runsql.getData("MGPRCEND");
    	sMinRet = runsql.getData("MGMinRet");
    	sMaxRet = runsql.getData("MGMaxRet");
   	}
   	runsql.disconnect();
   	
   	// selected div/dpt/cls
   	sStmt = "select  MITYPE, MIGRP"   			
   	   + ", case when MITYPE = 'D' then (select dnam from IpTsFil.IpDivsn where ddiv=migrp)"   	   
   	   + " when MITYPE = 'P' then (select dnam from IpTsFil.IpDepts where ddpt=migrp)" 
   	   + " when MITYPE = 'C' then (select clnm from IpTsFil.IpClass where ccls=migrp)  end   as name"
   	   + " from rci.MDGRPIN"
   	   + " where MiBATCH=" + sBatch;
   	   		
   	//System.out.println(sStmt);
   	   	
   	runsql = new RunSQLStmt();
   	runsql.setPrepStmt(sStmt);		   
   	runsql.runQuery();
   	   	
   	Vector<String> vHierTy = new Vector<String>();
   	Vector<String> vHier = new Vector<String>();
   	Vector<String> vHierNm = new Vector<String>();
   	
   	while(runsql.readNextRecord())
   	{
   		vHierTy.add(runsql.getData("MiType"));
   		vHier.add(runsql.getData("MiGrp"));
   		vHierNm.add(runsql.getData("name"));
   	}
   	runsql.disconnect();
   	
   	String [] sHierTy = vHierTy.toArray(new String[]{});
   	String [] sHier = vHier.toArray(new String[]{});
   	String [] sHierNm = vHierNm.toArray(new String[]{});
   	
   	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
 	String sHierTyJsa = srvpgm.cvtToJavaScriptArray(sHierTy);
 	String sHierJsa = srvpgm.cvtToJavaScriptArray(sHier);
 	String sHierNmJsa = srvpgm.cvtToJavaScriptArray(sHierNm);
 	
 	// selected price endings
 	sStmt = "select  MeCent"   			
 	   	   + " from rci.MDGRPPE"
 	   	   + " where MeBATCH=" + sBatch;
 	   	   		
 	//System.out.println(sStmt);
 	   	   	
 	runsql = new RunSQLStmt();
 	runsql.setPrepStmt(sStmt);		   
 	runsql.runQuery();
 	   	   	
 	Vector<String> vCent = new Vector<String>();
 	   	
 	while(runsql.readNextRecord())
 	{
 		vCent.add(runsql.getData("MeCent"));
 	}
 	runsql.disconnect();
 	   	
 	String [] sCent = vCent.toArray(new String[]{}); 	
 	String sCentJsa = srvpgm.cvtToJavaScriptArray(sCent); 
 	
 	// selected vendors
  	sStmt = "select  MvType, MvVen"   			
  	   	   + " from rci.MdGrpVe"
  	   	   + " where MvBATCH=" + sBatch;
  	   	   		
  	//System.out.println(sStmt);
  	   	   	
  	runsql = new RunSQLStmt();
  	runsql.setPrepStmt(sStmt);		   
  	runsql.runQuery();
  	
  	String sVenTy = "N";
  	Vector<String> vVen = new Vector<String>();
  	   	
  	while(runsql.readNextRecord())
  	{
  		if(sVenTy.equals("N")){ sVenTy = runsql.getData("MvType"); }
  		vVen.add(runsql.getData("MvVen"));
  	}
  	runsql.disconnect();
  	   	
  	String [] sVen = vVen.toArray(new String[]{}); 	
  	String sVenJsa = srvpgm.cvtToJavaScriptArray(sVen); 
  	
  	
    // selected vendors
   	sStmt = "select  MaAttr, MaVal"   			
   	   	   + " from rci.MdGrpAt"
   	   	   + " where MaBATCH=" + sBatch;
   	   	   		
   	System.out.println(sStmt);
   	   	   	
   	runsql = new RunSQLStmt();
   	runsql.setPrepStmt(sStmt);		   
   	runsql.runQuery();
   	
   	Vector<String> vAttr = new Vector<String>();
   	Vector<String> vAttrVal = new Vector<String>();
   	   	
   	while(runsql.readNextRecord())
   	{
   		vAttr.add(runsql.getData("MaAttr"));
   		vAttrVal.add(runsql.getData("MaVal"));
   	}
   	runsql.disconnect();
   	   	
   	String [] sAttr = vAttr.toArray(new String[]{});
   	String [] sAttrVal = vAttrVal.toArray(new String[]{});
   	String sAttrJsa = srvpgm.cvtToJavaScriptArray(sAttr);
   	String sAttrValJsa = srvpgm.cvtToJavaScriptArray(sAttrVal); 	
%>

<script name="javascript1.2">
var batch = "<%=sBatch%>";
var shortnm = "<%=sShortNm%>";
var longnm = "<%=sLongNm%>";
var bsrLvl = "<%=sBsrLvl%>";
var perm = "<%=sPerm%>";
var clear = "<%=sClearance%>";
var frRcvDt = "<%=sFrRcvDt%>";
var toRcvDt = "<%=sToRcvDt%>";
var frSlsDt = "<%=sFrSlsDt%>";
var toSlsDt = "<%=sToSlsDt%>";
var frMkdwnDt = "<%=sFrMkdwnDt%>";
var toMkdwnDt = "<%=sToMkdwnDt%>";
var mdPrc = "<%=sMdPrc%>";
var mdCent = "<%=sMdCent%>";
var minRet= "<%=sMinRet%>";
var maxRet= "<%=sMaxRet%>";

var hierTy = [<%=sHierTyJsa%>];
var hier = [<%=sHierJsa%>];
var hierNm = [<%=sHierNmJsa%>];
var cent = [<%=sCentJsa%>];

var venTy = "<%=sVenTy%>";
var ven = [<%=sVenJsa%>];

var attr = [<%=sAttrJsa%>];
var attrVal = [<%=sAttrValJsa%>];

parent.setBatchProp(batch, shortnm, longnm, bsrLvl, perm, clear  
 , frRcvDt, toRcvDt, frSlsDt, toSlsDt, frMkdwnDt, toMkdwnDt, hierTy, hier, hierNm, cent
 , venTy, ven, attr, attrVal, mdPrc,mdCent,minRet,maxRet);

//==============================================================================
// run on loading
//==============================================================================

</script>