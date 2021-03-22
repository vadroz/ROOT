<%@ page import="rciutility.RunSQLStmt, rciutility.CallAs400SrvPgmSup, java.sql.*, java.util.*, java.text.*"%>
<%
   String sStr = request.getParameter("Str");
   String sPiCal = request.getParameter("PiCal");   
   String sSelArea = request.getParameter("Area");
       
   // check if area is exists
   String sPiYr = sPiCal.substring(0,4);
   String sPiMo = sPiCal.substring(4);
   
   boolean bExists = false;
   String sStmt = null;
   RunSQLStmt sql_Area = null;
   ResultSet rs_Area = null;
   
   sStmt =  "select SPSKU, case when SPADJQTY > 0 then SPADJQTY else 0 end as addqty" 
		    + ", case when SPADJQTY < 0 then SPADJQTY else 0 end as rmvqty" 
		    + ", ides, substr(vnam,1,10) as vnam, substr(clrn,1,10) as clrnm, snam"
		    + ", (select max(ugtin) from iptsfil.IPUPCXF where iCls=uCls and iVen = uVen" 
		    + " and iSty = uSty and iClr = uClr and iSiz = uSiz"              
		    + " and substr(ugtin,1,1) <> '4' ) as ugtin, igtin"
		    + ", iret * SPADJQTY as iret, sparea"
		    + " from rci.PIARCORR"            
            + " inner join iptsfil.IpItHdr on isku=spsku"
            + " inner join iptsfil.IpMrVen on iven=vven"
            + " inner join iptsfil.IpColor on iclr=cclr"
            + " inner join iptsfil.IpSizes on isiz=ssiz"            
            + " where spstr=" + sStr + " and sppiyr=" + sPiYr + " and sppimo=" + sPiMo
     ;
	if(!sSelArea.equals("ALL"))
	{
		sStmt += " and sparea=" + sSelArea;
		sStmt += " order by sparea, spsku";
	}	    
     
    System.out.println(sStmt);
   	sql_Area = new RunSQLStmt();
   	sql_Area.setPrepStmt(sStmt);
   	rs_Area = sql_Area.runQuery();
   	   
   	System.out.println(sStmt);
   	   
   	// if already excists - delete existing entries
   	Vector<String> vSku = new Vector<String>();
   	Vector<String> vAddQty = new Vector<String>();
   	Vector<String> vRmvQty = new Vector<String>();
   	Vector<String> vDesc = new Vector<String>();
   	Vector<String> vVenNm = new Vector<String>();
   	Vector<String> vClrNm = new Vector<String>();
   	Vector<String> vSizNm = new Vector<String>();
   	Vector<String> vUpc = new Vector<String>();
   	Vector<String> vRet = new Vector<String>();
   	Vector<String> vArea = new Vector<String>();
   	
   	while(sql_Area.readNextRecord())
   	{
   		vSku.add(sql_Area.getData("spsku"));
   		vAddQty.add(sql_Area.getData("addqty"));
   		vRmvQty.add(sql_Area.getData("rmvqty"));
   		String desc = sql_Area.getData("ides");
   		desc = desc.replaceAll("'", "`");
   		vDesc.add(desc);
   		
   		String vennm = sql_Area.getData("vnam");
   		vennm = desc.replaceAll("'", "`");
   		vVenNm.add(vennm);
   		
   		vClrNm.add(sql_Area.getData("clrnm"));
   		vSizNm.add(sql_Area.getData("snam"));
   		if(sql_Area.getData("ugtin") != null){ vUpc.add(sql_Area.getData("ugtin")); }
   		else{ vUpc.add(sql_Area.getData("igtin")); }
   		vRet.add(sql_Area.getData("iret"));
   		vArea.add(sql_Area.getData("spArea"));
   	}
   	sql_Area.disconnect();   	
   	
   	String [] sSku = vSku.toArray(new String [] {});
   	String [] sAddQty = vAddQty.toArray(new String [] {});
   	String [] sRmvQty = vRmvQty.toArray(new String [] {});
   	String [] sDesc = vDesc.toArray(new String [] {});
   	String [] sVenNm = vVenNm.toArray(new String [] {});
   	String [] sClrNm = vClrNm.toArray(new String [] {});
   	String [] sSizNm = vSizNm.toArray(new String [] {});
   	String [] sUpc = vUpc.toArray(new String [] {});
   	String [] sRet = vRet.toArray(new String [] {});
   	String [] sArea = vArea.toArray(new String [] {});
   	
   	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
   	 
%>
<script>
var SelArea = "<%=sSelArea%>"; 
var Sku = [<%=srvpgm.cvtToJavaScriptArray(sSku)%>];
var AddQty = [<%=srvpgm.cvtToJavaScriptArray(sAddQty)%>];
var RmvQty = [<%=srvpgm.cvtToJavaScriptArray(sRmvQty)%>];
var Desc = [<%=srvpgm.cvtToJavaScriptArray(sDesc)%>];
var VenNm = [<%=srvpgm.cvtToJavaScriptArray(sVenNm)%>];
var ClrNm = [<%=srvpgm.cvtToJavaScriptArray(sClrNm)%>];
var SizNm = [<%=srvpgm.cvtToJavaScriptArray(sSizNm)%>];
var Upc = [<%=srvpgm.cvtToJavaScriptArray(sUpc)%>];
var Ret = [<%=srvpgm.cvtToJavaScriptArray(sRet)%>];
var Area = [<%=srvpgm.cvtToJavaScriptArray(sArea)%>];

if(SelArea != "ALL"){ parent.setCorrSkuList(Sku, AddQty,RmvQty,Desc, VenNm, ClrNm, SizNm, Upc);}
else { parent.setCorrAllSkuList(Sku, AddQty,RmvQty,Desc, VenNm, ClrNm, SizNm, Upc, Ret, Area ); }
</script>












