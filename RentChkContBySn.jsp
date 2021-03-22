<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sSrlNum = request.getParameter("Sn");

   String sStmt = "select CtCont, CTPICDT, CTRTNDT, CTSTS, CTSTR"	
    + ",(select csfname from rci.recusth where cscust=ctcust) as fname"
    + ",(select cslname from rci.recusth where cscust=ctcust) as lname"
	+ " from Rci.ReConti"
	+ " inner join Rci.ReContH on ivCont=ctCont"
	+ " where exists(select 1 from rci.reinv where EiSrln='" + sSrlNum + "'"
	+ " and ivinvid=eiinvid)"
	+ " and CtSts in ('READY', 'PICKEDUP')"
    ;   
   
   System.out.println("\n" + sStmt);

   RunSQLStmt sql_Item = new RunSQLStmt();
   sql_Item.setPrepStmt(sStmt);
   ResultSet rs_Item = sql_Item.runQuery();
   boolean bSnFound = false;
   
   String sCtCont = "";
   String sCtStr = "";
   String sCtPicDt = "";
   String sCtRtnDt = "";
   String sCtSts = "";
   String sCtFName = "";
   String sCtLName = "";
   
   if(sql_Item.readNextRecord())
   {
      bSnFound = true;
      sCtCont = sql_Item.getData("ctCont").trim();      
      sCtPicDt = sql_Item.getData("ctPicDt").trim();
      sCtRtnDt = sql_Item.getData("ctRtnDt").trim();
      sCtSts = sql_Item.getData("ctSts").trim();
      sCtStr = sql_Item.getData("ctStr").trim();
      sCtFName = sql_Item.getData("FName").trim();  
      sCtLName = sql_Item.getData("LName").trim(); 
   }
   sql_Item.disconnect();
   
   
   // get items 
   sStmt = "select IVINVID, EISRLN, EICLS, EIVEN, EISIZ, EIBRAND, EIMODEL"
        + ", clnm, vnam, snam"
        + ", case when IRQTY is not null then IRQTY else 0 end as irqty"
		+ " from Rci.ReConti"
		+ " inner join Rci.ReInv on IVINVID=EiInvId"
		+ " inner join IpTsFil.ipClass on ccls=EiCls"
		+ " inner join IpTsFil.ipMrVen on vven=EiBrand"
		+ " inner join IpTsFil.ipSizes on ssiz=EiSiz"
		+ " left join Rci.ReContG on IrCont=IvCont and IRINVID=EiInvId"
		+ " where ivCont = " + sCtCont
	   ;   
   
	   System.out.println("\n1. " + sStmt);
	   
	   sql_Item = new RunSQLStmt();
	   sql_Item.setPrepStmt(sStmt);
	   rs_Item = sql_Item.runQuery();
	   
	   Vector<String> vInvId = new Vector<String>();
	   Vector<String> vSrlN = new Vector<String>();
	   Vector<String> vCls = new Vector<String>();
	   Vector<String> vSiz = new Vector<String>();
	   Vector<String> vBrand = new Vector<String>();
	   Vector<String> vModel = new Vector<String>();
	   Vector<String> vClsNm = new Vector<String>();
	   Vector<String> vVenNm = new Vector<String>();
	   Vector<String> vSizNm = new Vector<String>();
	   Vector<String> vPairQty = new Vector<String>();
	   
	   while(sql_Item.readNextRecord())
	   {
	      bSnFound = true;
	      vInvId.add(sql_Item.getData("IVINVID").trim());
	      vSrlN.add(sql_Item.getData("EISRLN").trim());
	      vCls.add(sql_Item.getData("EICLS").trim()); 
	      vSiz.add(sql_Item.getData("EiSiz").trim());
	      vBrand.add(sql_Item.getData("EiBrand").trim());
	      vModel.add(sql_Item.getData("EiModel").trim());
	      vClsNm.add(sql_Item.getData("clnm").trim());
	      vVenNm.add(sql_Item.getData("vnam").trim());
	      vSizNm.add(sql_Item.getData("snam").trim());
	      vPairQty.add(sql_Item.getData("irqty").trim());
	   }
	   sql_Item.disconnect();
	   
	   // get items 
	   sStmt = "select count(*) as count" 
			+ " from Rci.ReConti"
			+ " where ivCont = " + sCtCont
			+ " and ivinvid=9999999999"
		   ;   
	   
	   System.out.println("\n2. " + sStmt);
	   
	   sql_Item = new RunSQLStmt();
	   sql_Item.setPrepStmt(sStmt);
	   rs_Item = sql_Item.runQuery();
	   boolean bPoles = false;
	   String sPoles = "0";
	   if(sql_Item.readNextRecord())
	   {
		   bPoles = true;
	       sPoles = sql_Item.getData("count").trim();
	   }
	   sql_Item.disconnect();
%>
<SN_Valid><%=bSnFound%></SN_Valid><CtCont><%=sCtCont%></CtCont><CtPicDt><%=sCtPicDt%></CtPicDt><CtRtnDt><%=sCtRtnDt%></CtRtnDt>
<CtSts><%=sCtSts%></CtSts><CtStr><%=sCtStr%></CtStr><CtFName><%=sCtFName%></CtFName>
<CtLName><%=sCtLName%></CtLName>
<%for(int i=0; i < vInvId.size(); i++){%>
  <InvId><%=vInvId.get(i)%></InvId><SrlN><%=vSrlN.get(i)%></SrlN><Cls><%=vCls.get(i)%></Cls>
  <Siz><%=vSiz.get(i)%></Siz><Brand><%=vBrand.get(i)%></Brand><Model><%=vModel.get(i)%></Model>
  <ClsNm><%=vClsNm.get(i)%></ClsNm><VenNm><%=vVenNm.get(i)%></VenNm><SizNm><%=vSizNm.get(i)%></SizNm>
  <PairQty><%=vPairQty.get(i)%></PairQty><Poles><%=sPoles%></Poles>
<%}%>










