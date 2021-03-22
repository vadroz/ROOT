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
			
	Vector<String> vFile = new Vector<String>();
	String sType = "";
	String sItem = "";
	String sSku = "";
	String sVenSty = "";
	String sSts = "";
	String sRecUsr = "";
	String sRecDt = "";
	String sRecTm = "";
	
	String sPrepStmt = "with logf as(" 
	  + " select 'Ctl' as type"                                           
	  + ", 0 as item_Id, 0 as sku, 0 as vendor, ' ' as ven_sty"           
	  + ", RLSTS as sts, rlrecus as xuser, RLRECDT as chgdt, RLRECTM as chgtm"            
	  + " from rci.RVHDRLOG cl" 
	  + " where RLCTLID = " + sCtl
	  + " union"                                                           
	  + " select 'Item' as type, RCITEMID as item_Id, risku as sku, iven as vendor, ivst as ven_sty"           
	  + ", rcitmsts as sts, RCCHGUS as xuser, RCCHGDT as chgdt, RCCHGTM as chgtm"       
	  + " from rci.RvItmLog"
	  + " inner join rci.RvItem on RCITEMID=RIITEMID"
	  + " inner join iptsfil.IpItHdr on risku=isku"
	  + " where RCCLMID = " + sCtl           
	  + " )"                          
	  + " select type, item_id, sku, vendor, ven_sty, sts, xuser, chgdt, chgtm" 
	  + " from logf"         
	  + " order by chgdt, chgtm";
   	
   	System.out.println(sPrepStmt);
   	
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

parent.setLogSts(type, item, sku, vensty, sts, recusr, recdt, rectm);

</SCRIPT>
</html>
<%
}
else{%>
	<script>alert("Your session is expired.Please signon.again.")</script>
<%}%>



