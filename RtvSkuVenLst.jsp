<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*, rciutility.CallAs400SrvPgmSup"%>
<%
   String sStr = request.getParameter("Str"); 
   String sVen = request.getParameter("Ven");
   
   String sPoNum = request.getParameter("PO");
   String sDocNum = request.getParameter("Doc");
   String sIssStr = request.getParameter("IssStr");
   String sAction = request.getParameter("Action");
   
   if(sAction == null){ sAction = "VEN_ITEM"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
	String sClsJsa = null;
    String sVenJsa = null;
    String sStyJsa = null;
    String sClrJsa = null;
    String sSizJsa = null;
    String sClrNmJsa = null;
    String sSizNmJsa = null;
    String sDescJsa = null;
    String sVstJsa = null;
    String sSkuJsa = null;
    String sInvJsa = null;
    String sUpdJsa = null;
    String sPoQtyJsa = null;
    String sPoQtyRemJsa = null;
    String sPoCostJsa = null;
    String sOnRtvJsa = null;
    String sOnMosJsa = null;
    
    Vector<String> vCls = new Vector<String>();
   	Vector<String> vVen = new Vector<String>();
   	Vector<String> vSty = new Vector<String>();
   	Vector<String> vClr = new Vector<String>();
   	Vector<String> vSiz = new Vector<String>();
   	Vector<String> vClrNm = new Vector<String>();
   	Vector<String> vSizNm = new Vector<String>();
   	Vector<String> vDesc = new Vector<String>();
   	Vector<String> vVst = new Vector<String>();
   	Vector<String> vSku = new Vector<String>();
   	Vector<String> vInv = new Vector<String>();
	Vector<String> vUpd = new Vector<String>();
	Vector<String> vPoQty = new Vector<String>();
	Vector<String> vPoQtyRem = new Vector<String>();
	Vector<String> vPoCost = new Vector<String>();
	Vector<String> vOnRtv = new Vector<String>();
	Vector<String> vOnMos = new Vector<String>();
    
    boolean bError = false;
    String msg = "";
    
    String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	if(sStr.length() == 1)
	{
		sStr = "0" + sStr; 
	}
	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
    
	if(sAction.equals("VEN_ITEM"))
	{
		String sPrepStmt = "select  digits(icls) as icls, digits(iven) as iven"
	    + ", digits(isty) as isty, digits(iclr) as iclr, digits(isiz) as isiz"
		+ ", ides , ivst, isku, dinv" + sStr
   	 	+ ", (select max(uupd) from iptsfil.IPUPCXF where iCls=uCls and iVen = uven" 
   	 	+ " and iSty = uSty and iClr = uClr and iSiz = uSiz"               
   	 	+ " and substr(uupd,1,1) <> '4' ) as uupd"
   	 	+ ", iupd"
   	 	+ ", (select sum(riqty) from rci.RvItem where isku=risku"
   	   	+ " and exists(select 1 from rci.RvHdr where rictlid=rhctlid" 
   	   	+ " and RHCTLSTS not in ('Cancelled', 'Completed'))) as onrtv"
		
		+ ", (select sum(miqty) from rci.MkItem where isku=misku"
		+ " and exists(select 1 from rci.MkHdr where mictlid=mhctlid" 
		+ " and MHCTLSTS not in ('Cancelled', 'Completed'))) as onmos"
							
   	   	+ ", clrn, snam"
   	 	+ " from iptsfil.ipithdr"
   	 	+ " inner join iptsfil.ipitdtl on dcls=icls and dven=iven and dsty=isty and dclr=iclr and dsiz=isiz and drid=0"   	 	
   	 	+ " inner join iptsfil.ipcolor on dclr=cclr"
   	 	+ " inner join iptsfil.ipsizes on dsiz=ssiz"
   	 	+ " where iven=" + sVen + " and dinv" + sStr + " > 0"
   	 	+ " order by icls, iven, isty, iclr,isiz";
	   	
   		//System.out.println(sPrepStmt);
   	
   		ResultSet rslset = null;
   		RunSQLStmt runsql = new RunSQLStmt();
   		runsql.setPrepStmt(sPrepStmt);		   
   		runsql.runQuery();
   		    
    	while(runsql.readNextRecord())
   		{
 	  		vCls.add(runsql.getData("icls"));
   			vVen.add(runsql.getData("iven"));
   			vSty.add(runsql.getData("isty"));
   			vClr.add(runsql.getData("iclr"));
   			vSiz.add(runsql.getData("isiz"));
   			vClrNm.add(runsql.getData("clrn"));
   			vSizNm.add(runsql.getData("snam"));
	   		
   			String sDesc = runsql.getData("ides");
   			sDesc = sDesc.replaceAll("'", "&quote;");
   			vDesc.add(sDesc);
   			vVst.add(runsql.getData("ivst"));
   			vSku.add(runsql.getData("isku"));
   			vInv.add(runsql.getData("dinv" + sStr));
   		
   			String uupd = runsql.getData("uupd");
   			String iupd = runsql.getData("iupd");
   			if(uupd==null){vUpd.add(iupd);}
   			else{vUpd.add(uupd);}
   			
   			String onrtv = runsql.getData("onrtv");
   			if(onrtv!=null){vOnRtv.add(onrtv); }
   			else{vOnRtv.add("0");}
   			
   			String onmos = runsql.getData("onmos");
   			if(onmos!=null){vOnMos.add(onmos); }
   			else{vOnMos.add("0");}
   			
   		}		
     
    	sClsJsa = srvpgm.cvtToJavaScriptArray(vCls.toArray(new String[]{}));
    	sVenJsa = srvpgm.cvtToJavaScriptArray(vVen.toArray(new String[]{}));
    	sStyJsa = srvpgm.cvtToJavaScriptArray(vSty.toArray(new String[]{}));
    	sClrJsa = srvpgm.cvtToJavaScriptArray(vClr.toArray(new String[]{}));
    	sSizJsa = srvpgm.cvtToJavaScriptArray(vSiz.toArray(new String[]{}));
    	sClrNmJsa = srvpgm.cvtToJavaScriptArray(vClrNm.toArray(new String[]{}));
    	sSizNmJsa = srvpgm.cvtToJavaScriptArray(vSizNm.toArray(new String[]{}));
    	sDescJsa = srvpgm.cvtToJavaScriptArray(vDesc.toArray(new String[]{}));
    	sVstJsa = srvpgm.cvtToJavaScriptArray(vVst.toArray(new String[]{}));
    	sSkuJsa = srvpgm.cvtToJavaScriptArray(vSku.toArray(new String[]{}));
    	sInvJsa = srvpgm.cvtToJavaScriptArray(vInv.toArray(new String[]{}));
    	sUpdJsa = srvpgm.cvtToJavaScriptArray(vUpd.toArray(new String[]{}));
    	sOnRtvJsa = srvpgm.cvtToJavaScriptArray(vOnRtv.toArray(new String[]{}));
    	sOnMosJsa = srvpgm.cvtToJavaScriptArray(vOnMos.toArray(new String[]{}));
    
    	runsql.disconnect();
   		runsql = null;
   	
	}
	else if(sAction.equals("PO_ITEM"))
	{		
		String sPrepStmt = "select digits(p.icls) as icls, digits(p.iven) as iven"
	        + ", digits(p.isty) as isty, digits(p.iclr) as iclr, digits(p.isiz) as isiz"
		    + ", h.ides, h.ivst, h.isku, dinv" + sStr
			+ ", (select max(uupd) from iptsfil.IPUPCXF where h.iCls=uCls and h.iVen = uven" 
		   	+ " and h.iSty = uSty and h.iClr = uClr and h.iSiz = uSiz"               
		   	+ " and substr(uupd,1,1) <> '4' ) as uupd"
		   	+ ", h.iupd, iqty, itqr, dec(round(p.ilnc,2),9,2) as ilnc"
		   	+ ", (select sum(riqty) from rci.RvItem where h.isku=risku"
		   	+ " and exists(select 1 from rci.RvHdr where rictlid=rhctlid" 
		   	+ " and RHCTLSTS not in ('Cancelled', 'Completed'))) as onrtv"
			
			+ ", (select sum(miqty) from rci.MkItem where isku=misku"
			+ " and exists(select 1 from rci.MkHdr where mictlid=mhctlid" 
			+ " and MHCTLSTS not in ('Cancelled', 'Completed'))) as onmos"
								
		   	+ ", p.iven as xven"
		   	+ ", clrn, snam"
		   	+ " from iptsfil.IpPoItm p"
		   	+ " inner join iptsfil.ipithdr h on p.icls=h.icls and p.iven=h.iven and p.isty=h.isty and  p.iclr=h.iclr and p.isiz=h.isiz"
   			+ " inner join iptsfil.ipitdtl d on d.dcls=h.icls and d.dven=h.iven and dsty=h.isty and d.dclr=h.iclr and d.dsiz=h.isiz and d.drid=0"
   			+ " inner join iptsfil.ipcolor on d.dclr=cclr"
   			+ " inner join iptsfil.ipsizes on d.dsiz=ssiz"
   			+ " where iono='" + sPoNum + "'"
		   	+ " order by p.icls, p.iven, p.isty, p.iclr, p.isiz";
			   	
		   	//System.out.println(sPrepStmt);
		   	
		   	ResultSet rslset = null;
		   	RunSQLStmt runsql = new RunSQLStmt();
		   	runsql.setPrepStmt(sPrepStmt);		   
		   	runsql.runQuery();
		   		   
		   	
			int iItem = 0; 
		   	boolean bFound = false;
		   	
		    while(runsql.readNextRecord())
		   	{
		    	bFound = true;
		    	String sOnhQty = runsql.getData("dinv" + sStr).trim();
		    	if(!sOnhQty.equals("0"))
		    	{
		    		String ven = runsql.getData("xven");		    	
		    		if(!ven.equals(sVen))
		    		{
		    			bError = true;
		    			msg = "PO vendor is not same as Control Number Vendor";		    		
		    			break;
		    		}
		    	
		    		iItem++;
		    	
		 			vCls.add(runsql.getData("icls"));
		   			vVen.add(runsql.getData("iven"));
		   			vSty.add(runsql.getData("isty"));
		   			vClr.add(runsql.getData("iclr"));
		   			vSiz.add(runsql.getData("isiz"));
		   			vClrNm.add(runsql.getData("clrn"));
		   			vSizNm.add(runsql.getData("clrn"));
			   	
		   			String sDesc = runsql.getData("ides");
		   			sDesc = sDesc.replaceAll("'", "&quote;");
		   			vDesc.add(sDesc);
		   		
		   			vVst.add(runsql.getData("ivst"));
		   			vSku.add(runsql.getData("isku"));
		   		
		   			String uupd = runsql.getData("uupd");
		   			String iupd = runsql.getData("iupd");
		   			if(uupd==null){vUpd.add(iupd);}
		   			else{vUpd.add(uupd);}
		   		
			   		vInv.add(sOnhQty);
			   		vPoQty.add(runsql.getData("iqty"));
			   		vPoQtyRem.add(runsql.getData("ITQR"));
		   			vPoCost.add(runsql.getData("ilnc"));

	   				String onrtv = runsql.getData("onrtv");
	   				if(onrtv==null){vOnRtv.add(onrtv); }
	   				else{vOnRtv.add("0");}
	   	   			
	   				String onmos = runsql.getData("onmos");
	   	   			if(onmos!=null){vOnMos.add(onmos); }
	   	   			else{vOnMos.add("0");}
	   	   			
		    	}
		   	}  		
		    
		    // populate if no error
		    if(!bError && iItem > 0)
		    {
		    	sClsJsa = srvpgm.cvtToJavaScriptArray(vCls.toArray(new String[]{}));
		    	sVenJsa = srvpgm.cvtToJavaScriptArray(vVen.toArray(new String[]{}));
		    	sStyJsa = srvpgm.cvtToJavaScriptArray(vSty.toArray(new String[]{}));
		    	sClrJsa = srvpgm.cvtToJavaScriptArray(vClr.toArray(new String[]{}));
		    	sSizJsa = srvpgm.cvtToJavaScriptArray(vSiz.toArray(new String[]{}));
		    	sClrNmJsa = srvpgm.cvtToJavaScriptArray(vClrNm.toArray(new String[]{}));
		    	sSizNmJsa = srvpgm.cvtToJavaScriptArray(vSizNm.toArray(new String[]{}));
		    	sDescJsa = srvpgm.cvtToJavaScriptArray(vDesc.toArray(new String[]{}));
		    	sVstJsa = srvpgm.cvtToJavaScriptArray(vVst.toArray(new String[]{}));
		    	sSkuJsa = srvpgm.cvtToJavaScriptArray(vSku.toArray(new String[]{}));
		    	sInvJsa = srvpgm.cvtToJavaScriptArray(vInv.toArray(new String[]{}));
		    	sUpdJsa = srvpgm.cvtToJavaScriptArray(vUpd.toArray(new String[]{}));
		    	sPoQtyJsa = srvpgm.cvtToJavaScriptArray(vPoQty.toArray(new String[]{}));
		    	sPoQtyRemJsa = srvpgm.cvtToJavaScriptArray(vPoQtyRem.toArray(new String[]{}));
		    	sPoCostJsa = srvpgm.cvtToJavaScriptArray(vPoCost.toArray(new String[]{}));
		    	sOnRtvJsa = srvpgm.cvtToJavaScriptArray(vOnRtv.toArray(new String[]{}));
		    	sOnMosJsa = srvpgm.cvtToJavaScriptArray(vOnMos.toArray(new String[]{}));
		    }
			else if(!bError && !bFound){ bError = true; msg = "PO is not found."; }
			else if(!bError && iItem==0){ bError = true; msg = "There are no items on hand."; }
		    
		    runsql.disconnect();
		   	runsql = null;
	}
	else if(sAction.equals("DOC_ITEM"))
	{		
		String sPrepStmt = "select digits(icls) as icls, digits(iven) as iven"
	        + ", digits(isty) as isty, digits(iclr) as iclr, digits(isiz) as isiz"
		    + ", ides, ivst, isku, dinv" + sStr
			+ ", (select max(uupd) from iptsfil.IPUPCXF where iCls=uCls and iVen = uven" 
		   	+ " and iSty = uSty and iClr = uClr and iSiz = uSiz"               
		   	+ " and substr(uupd,1,1) <> '4' ) as uupd"
		   	+ ", iupd, dqty as iqty, dec(round(DVLC,2),9,2) as ilnc"
		   	+ ", (select sum(riqty) from rci.RvItem where h.isku=risku"
		   	+ " and exists(select 1 from rci.RvHdr where rictlid=rhctlid" 
		   	+ " and RHCTLSTS not in ('Cancelled', 'Completed'))) as onrtv"
			
			+ ", (select sum(miqty) from rci.MkItem where isku=misku"
			+ " and exists(select 1 from rci.MkHdr where mictlid=mhctlid" 
			+ " and MHCTLSTS not in ('Cancelled', 'Completed'))) as onmos"
								
		   	+ ", h.iven as xven"
		   	+ ",clrn,snam"
		   	+ " from iptsfil.IpPnDst p"
		   	+ " inner join iptsfil.ipithdr h on p.dcls=icls and p.dven=iven and p.dsty=isty and p.dclr=iclr and p.dsiz=isiz"
   			+ " inner join iptsfil.ipitdtl d on d.dcls=icls and d.dven=iven and d.dsty=isty and d.dclr=iclr and d.dsiz=isiz and d.drid=0"
   			+ " inner join iptsfil.ipcolor on d.dclr=cclr"
   		   	+ " inner join iptsfil.ipsizes on d.dsiz=ssiz"
   			+ " where DDC#=" + sDocNum + " and DDS#=" + sStr + " and DIS#=" + sIssStr
   			+ " and p.dven=" + sVen   
		   	+ " order by icls, iven, isty, iclr, isiz";
			   	
		   	System.out.println("\n" + sPrepStmt);
		   	
		   	ResultSet rslset = null;
		   	RunSQLStmt runsql = new RunSQLStmt();
		   	runsql.setPrepStmt(sPrepStmt);		   
		   	runsql.runQuery();
		   		   
		   	
			int iItem = 0; 
		   	boolean bFound = false;
		   	
		    while(runsql.readNextRecord())
		   	{
		    	bFound = true;
		    	String sOnhQty = runsql.getData("dinv" + sStr).trim();
		    	if(!sOnhQty.equals("0"))
		    	{		    		
		    	
		    		iItem++;
		    	
		 			vCls.add(runsql.getData("icls"));
		   			vVen.add(runsql.getData("iven"));
		   			vSty.add(runsql.getData("isty"));
		   			vClr.add(runsql.getData("iclr"));
		   			vSiz.add(runsql.getData("isiz"));
		   			vClrNm.add(runsql.getData("clrn"));
		   			vSizNm.add(runsql.getData("snam"));
			   	
		   			String sDesc = runsql.getData("ides");
		   			sDesc = sDesc.replaceAll("'", "&quote;");
		   			vDesc.add(sDesc);
		   		
		   			vVst.add(runsql.getData("ivst"));
		   			vSku.add(runsql.getData("isku"));
		   		
		   			String uupd = runsql.getData("uupd");
		   			String iupd = runsql.getData("iupd");
		   			if(uupd==null){vUpd.add(iupd);}
		   			else{vUpd.add(uupd);}
		   		
			   		vInv.add(sOnhQty);
			   		vPoQty.add(runsql.getData("iqty"));
			   		vPoQtyRem.add("0");
			   		vPoCost.add(runsql.getData("ilnc"));

	   				String onrtv = runsql.getData("onrtv");
	   				if(onrtv==null){vOnRtv.add(onrtv); }
	   				else{vOnRtv.add("0");}

	   				String onmos = runsql.getData("onmos");
	   	   			if(onmos!=null){vOnMos.add(onmos); }
	   	   			else{vOnMos.add("0");}
	   	   			
		    	}
		   	}  		
		    
		    // populate if no error
		    if(!bError && iItem > 0)
		    {
		    	sClsJsa = srvpgm.cvtToJavaScriptArray(vCls.toArray(new String[]{}));
		    	sVenJsa = srvpgm.cvtToJavaScriptArray(vVen.toArray(new String[]{}));
		    	sStyJsa = srvpgm.cvtToJavaScriptArray(vSty.toArray(new String[]{}));
		    	sClrJsa = srvpgm.cvtToJavaScriptArray(vClr.toArray(new String[]{}));
		    	sSizJsa = srvpgm.cvtToJavaScriptArray(vSiz.toArray(new String[]{}));
		    	sClrNmJsa = srvpgm.cvtToJavaScriptArray(vClrNm.toArray(new String[]{}));
		    	sSizNmJsa = srvpgm.cvtToJavaScriptArray(vSizNm.toArray(new String[]{}));
		    	sDescJsa = srvpgm.cvtToJavaScriptArray(vDesc.toArray(new String[]{}));
		    	sVstJsa = srvpgm.cvtToJavaScriptArray(vVst.toArray(new String[]{}));
		    	sSkuJsa = srvpgm.cvtToJavaScriptArray(vSku.toArray(new String[]{}));
		    	sInvJsa = srvpgm.cvtToJavaScriptArray(vInv.toArray(new String[]{}));
		    	sUpdJsa = srvpgm.cvtToJavaScriptArray(vUpd.toArray(new String[]{}));
		    	sPoQtyJsa = srvpgm.cvtToJavaScriptArray(vPoQty.toArray(new String[]{}));
		    	sPoQtyRemJsa = srvpgm.cvtToJavaScriptArray(vPoQtyRem.toArray(new String[]{}));
		    	sPoCostJsa = srvpgm.cvtToJavaScriptArray(vPoCost.toArray(new String[]{}));
		    	sOnRtvJsa = srvpgm.cvtToJavaScriptArray(vOnRtv.toArray(new String[]{}));
		    	sOnMosJsa = srvpgm.cvtToJavaScriptArray(vOnMos.toArray(new String[]{}));
		    }
			else if(!bError && !bFound){ bError = true; msg = "Document # is not found."; }
			else if(!bError && iItem==0){ bError = true; msg = "There are no items on hand."; }
		    
		    runsql.disconnect();
		   	runsql = null;
	}
   	
%>
<html>  
<SCRIPT>
var cls = [<%=sClsJsa%>];
var ven = [<%=sVenJsa%>];
var sty = [<%=sStyJsa%>];
var clr = [<%=sClrJsa%>];
var siz = [<%=sSizJsa%>];
var clrnm = [<%=sClrNmJsa%>];
var siznm = [<%=sSizNmJsa%>];
var desc = [<%=sDescJsa%>];
var vst = [<%=sVstJsa%>];
var sku = [<%=sSkuJsa%>];
var inv = [<%=sInvJsa%>]; 
var upd = [<%=sUpdJsa%>];
var error = <%=bError%>;
var msg = "<%=msg%>";
var poqty = [<%=sPoQtyJsa%>];
var poqtyrem = [<%=sPoQtyRemJsa%>];
var pocost = [<%=sPoCostJsa%>];
var onrtv = [<%=sOnRtvJsa%>];
var onmos = [<%=sOnMosJsa%>];

var Action = "<%=sAction%>";

if(Action == "VEN_ITEM" || Action == "DOC_ITEM")
{
	poqty = null;
    poqtyrem = null;
    pocost = null;
}

if(error){ parent.showPoError( msg ); }
else if(Action == "VEN_ITEM" || Action == "PO_ITEM" || Action == "DOC_ITEM") 
{ 
	parent.showVenSku(cls, ven, sty, clr, siz, desc
		, vst, sku, inv, upd, onrtv, onmos, poqty, poqtyrem,pocost, clrnm, siznm, Action); 
}

</SCRIPT>
</html>
<%
}
else{%>
	<script>alert("Your session is expired.Please signon.again.")</script>
<%}%>