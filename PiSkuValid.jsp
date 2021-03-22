<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   	String sItem = request.getParameter("Item");
	String sStr = request.getParameter("Str");
	String sPiCal = request.getParameter("PiCal");


   String sStmt = null;
   if(sItem.length() >= 12)
   {  	
	   sStmt = "select isku, ides, ugtin"
	    + ",icls,iven,isty,iclr,isiz"
     	+ " from IpTsFil.IPUPCXF"
     	+ " inner join IpTsFil.IpItHdr on icls=ucls and iven=uven and isty=usty and iclr=uclr and isiz=usiz"
     	+ " where ugtin=" + sItem.substring(0, 12)
     	+ " order by ugtin desc"
     	+ " fetch first 1 row only";
   }
   else
   {
	   sStmt = "select isku, ides"
		+ ",icls,iven,isty,iclr,isiz"	   
		+ ",(select ugtin from IpTsFil.IPUPCXF where icls=ucls and iven=uven and isty=usty and iclr=uclr and isiz=usiz"
		+ " order by rrn(IpTsFil.IPUPCXF) desc fetch first 1 row only) as ugtin"
		+ " from IpTsFil.IpItHdr"
		+ " where isku=" + sItem;
   }
   

   RunSQLStmt sql_Item = new RunSQLStmt();
   sql_Item.setPrepStmt(sStmt);
   ResultSet rs_Item = sql_Item.runQuery();
   boolean bUpcFound = false;
   String sSku = "";
   String sDesc = "";
   String sUpd = "";
   String sCls= "";
   String sVen = "";
   String sSty = "";
   String sClr = "";
   String sSiz = "";
   
   if(sql_Item.readNextRecord())
   {
      bUpcFound = true;
      sSku = sql_Item.getData("isku");
      sDesc = sql_Item.getData("ides");
      sUpd = sql_Item.getData("ugtin");
      sCls = sql_Item.getData("icls");
      sVen = sql_Item.getData("iven");
      sSty = sql_Item.getData("isty");
      sClr = sql_Item.getData("iclr");
      sSiz = sql_Item.getData("isiz");
   }
   
   String sAdjSum = "0";
   String sPiSum = "0";
   
   if(sStr != null && sPiCal != null && bUpcFound)
   {
	   String sSelPiYr = sPiCal.substring(0, 4);
	   String sSelPiMo = sPiCal.substring(4);
	   
	   sStmt = "select sum(ADAQTY) as adjqty, sum(ADCQTY) as piqty"   
    	+ " from Rci.Piad00"
    	+ " where adstr=" + sStr 
    	+ " and adyear=" + sSelPiYr
    	+ " and admonth=" + sSelPiMo
    	+ " and adcls=" + sCls
    	+ " and adven=" + sVen
    	+ " and adsty=" + sSty
    	+ " and adclr=" + sClr
    	+ " and adsiz=" + sSiz
    	;
	   System.out.println(sStmt);
	      
	   sql_Item = new RunSQLStmt();
	   sql_Item.setPrepStmt(sStmt);
	   rs_Item = sql_Item.runQuery();
	   if(sql_Item.readNextRecord())
	   {
		   sAdjSum = sql_Item.getData("adjqty");
		   sPiSum = sql_Item.getData("piqty");
	   }   
   }
   
   sql_Item.disconnect();
   //System.out.println(sSku);

%>
<UPC_Valid><%=bUpcFound%></UPC_Valid><SKU><%=sSku%></SKU><DESC><%=sDesc%></DESC><UPC><%=sUpd%></UPC><ADJQTY><%=sAdjSum%></ADJQTY><PIQTY><%=sPiSum%></PIQTY>












