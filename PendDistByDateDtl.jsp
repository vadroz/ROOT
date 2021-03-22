<!DOCTYPE html>	
<%@ page import=" java.util.*, java.text.*
, rciutility.RunSQLStmt, java.sql.ResultSet, rciutility.CallAs400SrvPgmSup"%>  
<%
    String sDate = request.getParameter("Date");
    String sSelStr = request.getParameter("Str");
    String sSelDiv = request.getParameter("Div");
    String sByGrp = request.getParameter("By");
    String sSts = request.getParameter("Sts");

	String sStmt = "select dds#, cdiv, ddc#, dono, digits(dcls) as dcls, digits(dven) as dven, digits(dsty) as dsty," 
	  + " digits(dclr) as dclr, digits(dsiz) as dsiz, dqty"
	  + ", isku, ides, iret, vnam"
	  + " from IpTsFil.IpPnDst"
	  + " inner join IpTsFil.IpClass on ccls=dcls"
	  + " inner join IpTsFil.IpItHdr on icls=dcls and iven=dven and isty=dsty and iclr=dclr and isiz=dsiz"
	  + " inner join IpTsFil.IpMrVen on vven=dven"
	  + " where"
	  ;
	if(sByGrp.equals("Str")) { sStmt += " dds#=" + sSelStr; }
	else { sStmt += " cdiv=" + sSelDiv; }
	
	sStmt += " and ddti = '" + sDate + "'"
	  + " and dsts = '" + sSts + "'"
	;
	// select division
	if(!sSelDiv.equals("0")){ sStmt += " and cdiv = " + sSelDiv; }
	   
    sStmt += " order by ddc#, dono, dcls, dven, dsty, dclr, dsiz";
    		
	//System.out.println("\n" + sStmt);
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	   	  
	Vector<String> vDoc = new Vector<String>();
	Vector<String> vPo = new Vector<String>();
	Vector<String> vStr = new Vector<String>();
	Vector<String> vDiv = new Vector<String>();
	Vector<String> vCls = new Vector<String>();
	Vector<String> vVen = new Vector<String>();
	Vector<String> vSty = new Vector<String>();
	Vector<String> vClr = new Vector<String>();
	Vector<String> vSiz = new Vector<String>();
	Vector<String> vQty = new Vector<String>();
	Vector<String> vSku = new Vector<String>();
	Vector<String> vDesc = new Vector<String>();
	Vector<String> vRet = new Vector<String>();
	Vector<String> vVenNm = new Vector<String>();
	
	while(runsql.readNextRecord())
	{
		vDoc.add(runsql.getData("ddc#").trim());	
		vPo.add(runsql.getData("dono").trim());
		vStr.add(runsql.getData("dds#").trim());
		vDiv.add(runsql.getData("cdiv").trim());
		vCls.add(runsql.getData("dcls").trim());
		vVen.add(runsql.getData("dven").trim());
		vSty.add(runsql.getData("dsty").trim());
		vClr.add(runsql.getData("dclr").trim());
		vSiz.add(runsql.getData("dsiz").trim());
		vQty.add(runsql.getData("dqty").trim());
		vSku.add(runsql.getData("isku").trim());
		vDesc.add(runsql.getData("ides").trim().replaceAll("'", "&#39;"));
		vRet.add(runsql.getData("iret").trim());
		vVenNm.add(runsql.getData("vnam").trim().replaceAll("'", "&#39;"));
	}
	rs.close();
	runsql.disconnect();
	
	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
	
	String sDoc = srvpgm.cvtToJavaScriptArray(vDoc.toArray(new String[vDoc.size()]));
	String sPo  = srvpgm.cvtToJavaScriptArray(vPo.toArray(new String[vPo.size()]));
	String sStr = srvpgm.cvtToJavaScriptArray(vStr.toArray(new String[vStr.size()]));
	String sDiv = srvpgm.cvtToJavaScriptArray(vDiv.toArray(new String[vDiv.size()]));
	String sCls = srvpgm.cvtToJavaScriptArray(vCls.toArray(new String[vCls.size()]));
	String sVen = srvpgm.cvtToJavaScriptArray(vVen.toArray(new String[vVen.size()]));
	String sSty = srvpgm.cvtToJavaScriptArray(vSty.toArray(new String[vSty.size()]));
	String sClr = srvpgm.cvtToJavaScriptArray(vClr.toArray(new String[vClr.size()]));
	String sSiz = srvpgm.cvtToJavaScriptArray(vSiz.toArray(new String[vSiz.size()]));
	String sQty = srvpgm.cvtToJavaScriptArray(vQty.toArray(new String[vQty.size()]));	
	String sSku = srvpgm.cvtToJavaScriptArray(vSku.toArray(new String[vSku.size()]));
	String sDesc = srvpgm.cvtToJavaScriptArray(vDesc.toArray(new String[vDesc.size()]));
	String sRet = srvpgm.cvtToJavaScriptArray(vRet.toArray(new String[vRet.size()]));
	String sVenNm = srvpgm.cvtToJavaScriptArray(vVenNm.toArray(new String[vVenNm.size()]));
	
%>
<SCRIPT>
  var Date = "<%=sDate%>";
  var SelStr = "<%=sSelStr%>";
  var SelDiv = "<%=sSelDiv%>";
  var Doc = [<%=sDoc%>];
  var Po = [<%=sPo%>];
  var Str = [<%=sStr%>];
  var Div = [<%=sDiv%>];
  var Cls = [<%=sCls%>];
  var Ven = [<%=sVen%>];
  var Sty = [<%=sSty%>];
  var Clr = [<%=sClr%>];
  var Siz = [<%=sSiz%>];
  var Qty = [<%=sQty%>];
  var Sku = [<%=sSku%>]; 
  var Desc = [<%=sDesc%>]; 
  var Ret = [<%=sRet%>]; 
  var VenNm = [<%=sVenNm%>]; 
  
  parent.setCellDtl(Date, SelStr, SelDiv, Doc, Po, Str, Div, Cls, Ven, Sty, Clr, Siz, Qty
		  ,Sku, Desc, Ret, VenNm);
</SCRIPT>
 