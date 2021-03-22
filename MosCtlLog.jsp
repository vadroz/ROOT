<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*, rciutility.CallAs400SrvPgmSup"%>
<%
   String sCtl = request.getParameter("Ctl"); 
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	Vector<String> vType = new Vector<String>();
	Vector<String> vItem = new Vector<String>();
	Vector<String> vSku = new Vector<String>();
	Vector<String> vVenSty = new Vector<String>();
	Vector<String> vSts = new Vector<String>();	
	Vector<String> vRecUsr = new Vector<String>();
	Vector<String> vRecDt = new Vector<String>();
	Vector<String> vRecTm = new Vector<String>();
	Vector<String> vDesc = new Vector<String>();
			
	Vector<String> vFile = new Vector<String>();
	String sType = "";
	String sItem = "";
	String sSku = "";
	String sVenSty = "";
	String sSts = "";
	String sRecUsr = "";
	String sRecDt = "";
	String sRecTm = "";
	String sDesc = "";
	
	String sPrepStmt = "with logf as(" 
	  + " select 'Ctl' as type"                                           
	  + ", 0 as item_Id, 0 as sku,  0 as vendor, ' ' as ven_sty"           
	  + ", MLSTS as sts, mlrecus as xuser, mLRECDT as chgdt, mLRECTM as chgtm, ' ' as ides"            
	  + " from rci.MkHDRLOG cl" 
	  + " where mLCTLID = " + sCtl
	  + " union"                                                           
	  + " select 'Item' as type, mCITEMID as item_Id, misku as sku, iven as vendor, ivst as ven_sty"           
	  + ", mcitmsts as sts, mCCHGUS as xuser, mCCHGDT as chgdt, mCCHGTM as chgtm"    
	  + ", ides"
	  + " from rci.MkItmLog"
	  + " inner join rci.MkItem on mCITEMID=mIITEMID"
	  + " inner join iptsfil.IpItHdr on misku=isku"
	  + " where mCCLMID = " + sCtl           
	  + " )"                          
	  + " select type, item_id, sku, vendor, ven_sty, sts, xuser, chgdt, chgtm, ides" 
	  + " from logf"         
	  + " order by chgdt, chgtm";
   	
   	//System.out.println(sPrepStmt);
   	
   	ResultSet rslset = null;
   	RunSQLStmt runsql = new RunSQLStmt();
   	runsql.setPrepStmt(sPrepStmt);		   
   	runsql.runQuery();
   		
   	while(runsql.readNextRecord())
   	{
   	 	vType.add(runsql.getData("type"));
   	 	vItem.add(runsql.getData("item_id"));
   	 	vSku.add(runsql.getData("sku"));
   	 	vVenSty.add(runsql.getData("ven_sty"));
   	 	vSts.add(runsql.getData("sts"));
   		vRecUsr.add(runsql.getData("xuser"));
   		vRecDt.add(runsql.getData("chgdt"));
   		vRecTm.add(runsql.getData("chgtm"));
   		
   		String desc = runsql.getData("ides");
   		desc = desc.replaceAll("'", "&#39;");
   		vDesc.add(desc);
   	}
    
   	runsql.disconnect();
   	runsql = null;
	
	
	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
	sType = srvpgm.cvtToJavaScriptArray(vType.toArray(new String[]{}));
	sItem = srvpgm.cvtToJavaScriptArray(vItem.toArray(new String[]{}));
	sSku = srvpgm.cvtToJavaScriptArray(vSku.toArray(new String[]{}));
	sVenSty = srvpgm.cvtToJavaScriptArray(vVenSty.toArray(new String[]{}));
	sSts = srvpgm.cvtToJavaScriptArray(vSts.toArray(new String[]{}));
	sRecUsr = srvpgm.cvtToJavaScriptArray(vRecUsr.toArray(new String[]{}));
	sRecDt = srvpgm.cvtToJavaScriptArray(vRecDt.toArray(new String[]{}));
	sRecTm = srvpgm.cvtToJavaScriptArray(vRecTm.toArray(new String[]{}));
	sDesc = srvpgm.cvtToJavaScriptArray(vDesc.toArray(new String[]{}));	
	
%>
<html>  
<SCRIPT>
var type = [<%=sType%>];
var item = [<%=sItem%>];
var sku = [<%=sSku%>];
var vensty = [<%=sVenSty%>];
var sts = [<%=sSts%>];
var recusr = [<%=sRecUsr%>];
var recdt = [<%=sRecDt%>];
var rectm = [<%=sRecTm%>];
var desc = [<%=sDesc%>];

parent.setLogSts(type, item, sku, vensty, sts, recusr, recdt, rectm, desc);

</SCRIPT>
</html>
<%
}
else{%>
	<script>alert("Your session is expired.Please signon.again.")</script>
<%}%>



