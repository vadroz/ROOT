<!DOCTYPE html>	
<%@ page import=" java.util.*, java.text.*
, rciutility.RunSQLStmt, java.sql.ResultSet, rciutility.CallAs400SrvPgmSup"%>  
<%
    String sSelVen = request.getParameter("Ven");
    String sSelSts = request.getParameter("Sts");
    
	String sStmt = "with dtlf as (" 
	 + "select digits(icls) as icls, digits(iven) as iven, digits(isty) as isty" 
	 + ", digits(iclr) as iclr, digits(isiz) as isiz, pnsts" 
	 + ",(select  hono from IpTsFil.IpPoHdr where hblk = digits(opord) and hven=iven" 
	 + " fetch first 1 rows only) as PO#" 
	 + ", opord, opsku, pnsn, ides, ivst, char(PNRECDT, usa) as PNRECDT" 
	 + ", case when pnsts='Assigned' and timestamp(PNRECDT,PNRECTM) <= current timestamp - 48 hours" 
	 + " then 1 else 0 end as errflg"
	 
	 + ", (select 1 from iptsfil.IpAnItm"
	 + " inner join iptsfil.IpAnDtl on bono=cono and basn=casn and bstr=cstr" 
	 + " where cstr=70" 
	 + " and ccls=icls and cven=iven and csty=isty" 
	 + " and cclr=iclr and csiz=isiz" 
	 + " and exists(select 1 from IpTsFil.IpPoHdr where hblk = digits(opord) and hono=cono)" 
	 + " fetch first 1 rows only" 
	 + ") as asn_count"
	 
	 + " from rci.MoOrPas" 
	 + " inner join rci.MoOrdH on ohord=opord" 
	 + " inner join rci.mospstn on opid=pnpickid" 
	 + " inner join IpTsFil.ipithdr on isku=opsku" 
	 + " where pnstr=70"	 
	 ;
	
	if(!sSelSts.equals("Cancelled")){ sStmt += " and ohordsts <> 'Cancelled'"; }
	else 
	{  
		sStmt += " and (ohordsts = 'Cancelled' or pnsts in('Cancelled', 'Sold Out'))";  
	}
	
	sStmt += " and iven=" + sSelVen;
	
	if(!sSelSts.equals("Cancelled")){ sStmt += " and pnsts ='" + sSelSts + "'"; }
	 
	sStmt += " and exists(select 1 from IpTsFil.IpPoHdr where hblk = digits(opord) fetch first 1 rows only)" 		
		+ ")" 
		+ " select icls, iven, isty, iclr, isiz, pnsts" 
		+ ", case when asn_count is null then 'None' else ' ' end as asn_count" 
		+ ", case when PO# is null then ' ' else PO# end as PO#" 
		+ ", opord, opsku, pnsn, ides, ivst, PNRECDT, errflg" 
		+ " from dtlf "
		+ " order by opord, opsku, PO#"
	  ;			
	System.out.println("\n" + sStmt);
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	   	  
	Vector<String> vCls = new Vector<String>();
	Vector<String> vVen = new Vector<String>();
	Vector<String> vSty = new Vector<String>();
	Vector<String> vClr = new Vector<String>();
	Vector<String> vSiz = new Vector<String>();
	Vector<String> vSts = new Vector<String>();
	Vector<String> vPo = new Vector<String>();
	Vector<String> vOrd = new Vector<String>();
	Vector<String> vSku = new Vector<String>();
	Vector<String> vSrln = new Vector<String>();
	Vector<String> vDesc = new Vector<String>();
	Vector<String> vVenSty = new Vector<String>();
	Vector<String> vStsDt = new Vector<String>();
	Vector<String> vErrFlg = new Vector<String>();
	Vector<String> vAsn = new Vector<String>();
	
	while(runsql.readNextRecord())
	{		
		vCls.add(runsql.getData("icls").trim());
		vVen.add(runsql.getData("iven").trim());
		vSty.add(runsql.getData("isty").trim());
		vClr.add(runsql.getData("iclr").trim());
		vSiz.add(runsql.getData("isiz").trim());
		vPo.add(runsql.getData("PO#").trim());
		vOrd.add(runsql.getData("opord").trim());
		vSku.add(runsql.getData("opsku").trim());
		vSrln.add(runsql.getData("pnsn").trim());
		vDesc.add(runsql.getData("ides").trim().replaceAll("'", "&#39;"));
		vVenSty.add(runsql.getData("ivst").trim().replaceAll("'", "&#39;"));
		vStsDt.add(runsql.getData("PnRecDt").trim());
		vErrFlg.add(runsql.getData("errflg").trim());
		vAsn.add(runsql.getData("asn_count").trim());
	}
	rs.close();
	runsql.disconnect();
	
	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
		
	String sCls = srvpgm.cvtToJavaScriptArray(vCls.toArray(new String[vCls.size()]));
	String sVen = srvpgm.cvtToJavaScriptArray(vVen.toArray(new String[vVen.size()]));
	String sSty = srvpgm.cvtToJavaScriptArray(vSty.toArray(new String[vSty.size()]));
	String sClr = srvpgm.cvtToJavaScriptArray(vClr.toArray(new String[vClr.size()]));
	String sSiz = srvpgm.cvtToJavaScriptArray(vSiz.toArray(new String[vSiz.size()]));
	String sPo  = srvpgm.cvtToJavaScriptArray(vPo.toArray(new String[vPo.size()]));
	String sOrd  = srvpgm.cvtToJavaScriptArray(vOrd.toArray(new String[vOrd.size()]));	
	String sSku = srvpgm.cvtToJavaScriptArray(vSku.toArray(new String[vSku.size()]));
	String sSrln = srvpgm.cvtToJavaScriptArray(vSrln.toArray(new String[vSrln.size()]));
	String sDesc = srvpgm.cvtToJavaScriptArray(vDesc.toArray(new String[vDesc.size()]));
	String sVenSty = srvpgm.cvtToJavaScriptArray(vVenSty.toArray(new String[vVenSty.size()]));
	String sStsDt = srvpgm.cvtToJavaScriptArray(vStsDt.toArray(new String[vStsDt.size()]));
	String sErrFlg = srvpgm.cvtToJavaScriptArray(vErrFlg.toArray(new String[vErrFlg.size()]));
	String sAsn = srvpgm.cvtToJavaScriptArray(vAsn.toArray(new String[vAsn.size()]));
%>
<SCRIPT>
  var SelSts = "<%=sSelSts%>";
  var SelVen = "<%=sSelVen%>";  
  var Cls = [<%=sCls%>];
  var Ven = [<%=sVen%>];
  var Sty = [<%=sSty%>];
  var Clr = [<%=sClr%>];
  var Siz = [<%=sSiz%>];
  var Po = [<%=sPo%>];
  var Ord = [<%=sOrd%>];
  var Sku = [<%=sSku%>];
  var Srln = [<%=sSrln%>];
  var Desc = [<%=sDesc%>];
  var VenSty = [<%=sVenSty%>];
  var StsDt = [<%=sStsDt%>];
  var ErrFlg = [<%=sErrFlg%>];
  var Asn = [<%=sAsn%>];
  
  parent.setCellDtl(SelVen, SelSts, Cls, Ven, Sty, Clr, Siz, Po, Ord, Sku, Srln, Desc
		  , VenSty, StsDt, ErrFlg, Asn);
</SCRIPT>
 