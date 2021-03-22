<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sItem = request.getParameter("Item");
   String sStr = request.getParameter("Str");
   
   if(sStr.length() == 1){ sStr = "0" + sStr; }

   String sStmt = null;
   if(sItem.length() >= 12)
   {  	
	   if(sItem.length() == 12){  sItem = "00" + sItem; }
	   else if(sItem.length() == 13){  sItem = "0" + sItem; }
	   System.out.println(sItem + " | " + sItem.length());
	   
	   sStmt = "select isku, iven, ides, dinv" + sStr + " as qty"
	    + ", (select sum(riqty) from rci.RvItem where isku=risku"
		+ " and exists(select 1 from rci.RvHdr where rictlid=rhctlid" 
		+ " and RHCTLSTS not in ('Processed'))) as onrtv"	 
		   
		+ ", (select sum(riqty) from rci.RvItem where isku=risku"		
		+ " and exists(select 1 from rci.RvHdr where rictlid=rhctlid"
		+ " and RhStr=" + sStr
		+ " and RHCTLSTS not in ('Processed'))) as onrtv"
			
		+ ", (select sum(miqty) from rci.MkItem where isku=misku"
		+ " and exists(select 1 from rci.MkHdr where mictlid=mhctlid" 
		+ " and MhStr=" + sStr
		+ " and MHCTLSTS not in ('Processed'))) as onmos"
		+ ", iret, idiv, icls"
		
     	+ " from IpTsFil.IPUPCXF"
     	+ " inner join IpTsFil.IpItHdr on icls=ucls and iven=uven and isty=usty and iclr=uclr and isiz=usiz"
     	+ " inner join IpTsFil.IpItDtl on icls=dcls and iven=dven and isty=dsty"     		 
     	+ " where ugtin='" + sItem + "'"
     	+ " order by ugtin desc"
     	+ " fetch first 1 row only";
   }
   else
   {
	   sStmt = "select isku, iven, ides, dinv" + sStr + " as qty"
			   
		+ ", (select sum(riqty) from rci.RvItem where isku=risku"		
	    + " and exists(select 1 from rci.RvHdr where rictlid=rhctlid"
	    + " and RhStr=" + sStr
		+ " and RHCTLSTS not in ('Processed'))) as onrtv"
		
		+ ", (select sum(miqty) from rci.MkItem where isku=misku"
		+ " and exists(select 1 from rci.MkHdr where mictlid=mhctlid" 
		+ " and MhStr=" + sStr
		+ " and MHCTLSTS not in ( 'Processed'))) as onmos"
		+ ", iret, idiv, icls"
				
		+ " from IpTsFil.IpItHdr"
		+ " inner join IpTsFil.IpItDtl on icls=dcls and iven=dven and isty=dsty" 
		+ " and iclr=dclr and isiz=dsiz and drid=0"
		+ " where isku=" + sItem;
   }
   System.out.println(sStmt);

   RunSQLStmt sql_Item = new RunSQLStmt();
   sql_Item.setPrepStmt(sStmt);
   ResultSet rs_Item = sql_Item.runQuery();
   
   boolean bUpcFound = false;
   
   String sSku = "";
   String sVen = "";
   String sDesc = "";
   String sQty = "";
   String sOnRtv = "";
   String sOnMos = "";
   String sRet = "";
   String sDiv = "";
   String sCls = "";
   
   if(sql_Item.readNextRecord())
   {
      bUpcFound = true;
      sSku = sql_Item.getData("isku");
      sVen = sql_Item.getData("iven");
      sDesc = sql_Item.getData("ides").trim();
      sQty = sql_Item.getData("qty");       
      sOnRtv = sql_Item.getData("onrtv");
      if(sOnRtv==null){sOnRtv = "0";}
      sOnMos = sql_Item.getData("onmos");
      if(sOnMos==null){sOnMos = "0";}
      
      sRet = sql_Item.getData("iret").trim();
      sDiv = sql_Item.getData("idiv").trim();
      sCls = sql_Item.getData("icls").trim();
   }
   
   
   
   sStmt = "select sum(UcQty) as qty, max(UCRECDT) as entdt" 
    + " from rci.EcUnCnd"
    + " where ucsku=" + sSku + " and ucstr=" + sStr                         
    + " and UcExpDt >= current date";
    
   System.out.println(sStmt);
   
   sql_Item = new RunSQLStmt();
   sql_Item.setPrepStmt(sStmt);
   rs_Item = sql_Item.runQuery();
   
   boolean bExclFound = false;
   String sExQty = "";
   String sExEntDt = "";
   
   if(sql_Item.readNextRecord())
   {	  
	  sExQty = sql_Item.getData("qty");
	  if(sExQty == null){sExQty = "";}
	  sExEntDt = sql_Item.getData("entdt");
	  if(sExEntDt == null){sExEntDt = "";}
	  bExclFound = !sExQty.trim().equals("");
   }
   
   sql_Item.disconnect();

%>
<UPC_Valid><%=bUpcFound%></UPC_Valid><SKU><%=sSku%></SKU><VEN><%=sVen%></VEN><QTY><%=sQty%></QTY><OnRTV><%=sOnRtv%></OnRTV><OnMOS><%=sOnMos%></OnMOS><DESC><%=sDesc%></DESC>
<RET><%=sRet%></RET><DIV><%=sDiv%></DIV><CLS><%=sCls%></CLS><Excluded><%=bExclFound%></Excluded><ExcludedQty><%=sExQty%></ExcludedQty><ExcluedDate><%=sExEntDt%></ExcluedDate>












