<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*, java.io.*"%>
<%
   String sItem = request.getParameter("Item");
   
   
   String sStmt = null;
   if(sItem.length() >= 12)
   {  	
	   if(sItem.length() == 12){  sItem = "00" + sItem; }
	   else if(sItem.length() == 13){  sItem = "0" + sItem; }
	   System.out.println(sItem + " | " + sItem.length());
	   
	   sStmt = "select isku, idiv, icls, iven, isty, iclr, isiz"	   
     	+ " from IpTsFil.IPUPCXF"
     	+ " inner join IpTsFil.IpItHdr on icls=ucls and iven=uven and isty=usty and iclr=uclr and isiz=usiz"
     	+ " where ugtin='" + sItem + "'"
     	+ " order by ugtin desc"
     	+ " fetch first 1 row only";
   }
   else
   {
	   sStmt = "select isku, idiv, icls, iven, isty, iclr, isiz"
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
   String sDiv = "";
   String sCls = "";
   String sVen = "";
   String sSty = "";
   String sClr = "";
   String sSiz = "";
   
   if(sql_Item.readNextRecord())
   {
      bUpcFound = true;
      sSku = sql_Item.getData("isku");
      sDiv = sql_Item.getData("idiv");
      sCls = sql_Item.getData("icls");
      sVen = sql_Item.getData("iven");
      if(sVen.length() == 4 ){ sVen = "0" + sVen; } 
      sSty = sql_Item.getData("isty");       
      sClr = sql_Item.getData("iclr");
      sSiz = sql_Item.getData("isiz");      
   }
   
   sql_Item.disconnect();
   
   
   String sLink = "/Signs/Products/Division " + sDiv + "/" + sCls + "." + sVen + "." + sSty + ".000";
   sLink += ".doc";

   String sPath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT" + sLink;
   File f = new File(sPath);
  
   if(!f.exists())
   {	   
	   sLink = "Not Found";       
   }
   
   
%>
<UPC_Valid><%=bUpcFound%></UPC_Valid><SKU><%=sSku%></SKU><PATH><%=sLink%></PATH>










