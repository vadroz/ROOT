<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sItem = request.getParameter("Item");

   String sStmt = null;
   if(sItem.length() >= 12)
   {  	
	   if(sItem.trim().length() == 12){ sItem = "00" + sItem; }
	   else if(sItem.trim().length() == 13){ sItem = "0" + sItem; }
	   
	   sStmt = "select isku, ides"
     	+ " from IpTsFil.IPUPCXF"
     	+ " inner join IpTsFil.IpItHdr on icls=ucls and iven=uven and isty=usty and iclr=uclr and isiz=usiz"
     	+ " where ugtin='" + sItem + "'"
     	+ " order by ugtin desc"
     	+ " fetch first 1 row only";
   }
   else
   {
	   sStmt = "select isku, ides"
		     	+ " from IpTsFil.IpItHdr"
		     	+ " where isku=" + sItem;
   }
   System.out.println(sStmt);

   RunSQLStmt sql_Item = new RunSQLStmt();
   sql_Item.setPrepStmt(sStmt);
   ResultSet rs_Item = sql_Item.runQuery();
   boolean bUpcFound = false;
   String sSku = "";
   String sDesc = "";
   if(sql_Item.readNextRecord())
   {
      bUpcFound = true;
      sSku = sql_Item.getData("isku");
      sDesc = sql_Item.getData("ides");
   }
   sql_Item.disconnect();
   //System.out.println(sSku);

%>
<UPC_Valid><%=bUpcFound%></UPC_Valid><SKU><%=sSku%></SKU><DESC><%=sDesc%></DESC>












