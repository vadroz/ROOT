<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sItem = request.getParameter("Item");
   String sStr = request.getParameter("Str");
   
   if(sStr.length() == 1){ sStr = "0" + sStr; }

   String sStmt = null;
   if(sItem.length() >= 12)
   {  	
	   sStmt = "select isku, iven, ides, dinv" + sStr
	    + ", (select sum(riqty) from rci.RvItem where isku=risku"
		+ " and exists(select 1 from rci.RvHdr where rictlid=rhctlid" 
		+ " and RHCTLSTS not in ('Cancelled', 'Completed'))) as onrtv"
		
		+ ", (select sum(miqty) from rci.MkItem where isku=misku"
		+ " and exists(select 1 from rci.MkHdr where mictlid=mhctlid" 
		+ " and MHCTLSTS not in ('Cancelled', 'Completed'))) as onmos"
							
     	+ " from IpTsFil.IPUPCXF"
     	+ " inner join IpTsFil.IpItHdr on icls=ucls and iven=uven and isty=usty and iclr=uclr and isiz=usiz"
     	+ " inner join IpTsFil.IpItDtl on icls=dcls and iven=dven and isty=dsty"     		 
     	+ " where uupd=" + sItem
     	+ " order by uupd desc"
     	+ " fetch first 1 row only";
   }
   else
   {
	   sStmt = "select isku, iven, ides, dinv" + sStr + " as qty"
		+ ", (select sum(riqty) from rci.RvItem where isku=risku"
	    + " and exists(select 1 from rci.RvHdr where rictlid=rhctlid" 
		+ " and RHCTLSTS not in ('Cancelled', 'Completed'))) as onrtv"
		
		+ ", (select sum(miqty) from rci.MkItem where isku=misku"
		+ " and exists(select 1 from rci.MkHdr where mictlid=mhctlid" 
		+ " and MHCTLSTS not in ('Cancelled', 'Completed'))) as onmos"
								   
		+ " from IpTsFil.IpItHdr"
		+ " inner join IpTsFil.IpItDtl on icls=dcls and iven=dven and isty=dsty" 
		+ " and iclr=dclr and isiz=dsiz and drid=0"
		+ " where isku=" + sItem;
   }
   //System.out.println(sStmt);

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
   
   if(sql_Item.readNextRecord())
   {
      bUpcFound = true;
      sSku = sql_Item.getData("isku");
      sVen = sql_Item.getData("iven");
      sDesc = sql_Item.getData("ides");
      sQty = sql_Item.getData("qty");
      sOnRtv = sql_Item.getData("onrtv");
      sOnMos = sql_Item.getData("onmos");
   }
   sql_Item.disconnect();
   //System.out.println(sSku);

%>
<UPC_Valid><%=bUpcFound%></UPC_Valid><SKU><%=sSku%></SKU><VEN><%=sVen%></VEN><QTY><%=sQty%></QTY><OnRTV><%=sOnRtv%></OnRTV><OnMOS><%=sOnMos%></OnMOS><DESC><%=sDesc%></DESC>












