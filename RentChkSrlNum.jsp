<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sSrlNum = request.getParameter("Sn");
   String sStrNum = request.getParameter("Str");

   String sStmt = "with invf as ("
		+ "select EIINVID,EISTR,EICLS,eisiz,EISRLN,EIPRCHYR,EIBRAND,EIMODEL,EIADDDT,EIMFGSN,EILIFE"
		+ ",EITRADE,clnm, vnam, snam"	
		+ ", eists"
		+ ", (select CoComm from rci.RECOMMT where COFSTTY='INVENTORY' and COFSTID = eiinvid "
		//+ " and cocomm in ('DAMAGED', 'NOT COUNTED', 'STOLEN', 'WARNOUT')"
		+ " and ( cocomm like ('%DAMAGED%')" 
		+ " or cocomm like ( '%NOT COUNTED%')" 
		+ " or cocomm like ( '%STOLEN%')" 
		+ " or cocomm like ( '%WARNOUT%')" 
		+ " or cocomm like ( '%DUPLICATE S/N%')" 
		+ ")"		
		+ " order by CORECDT desc,  CORECTM desc fetch first 1 row only) as reason"
		
		+ ",(select ctcont from rci.ReConth where exists(select 1 from rci.ReContI where"
		+ " IVCONT = ctcont and IVINVID = EIINVID and IvScan = 'Y')" 
		+ " and ctsts in ('OPEN', 'PICKEDUP')"
		+ " and CTPICDT <= current date "
		+ " order by CTRECDT desc, CTRECTM desc fetch first 1 row only"
		+ ") as cont"
		+ ",(select CTPICDT from rci.ReConth where exists(select 1 from rci.ReContI where"
		+ " IVCONT = ctcont and IVINVID = EIINVID and IvScan = 'Y')" 
		+ " and ctsts in ('OPEN', 'PICKEDUP')"
		+ " and CTPICDT <= current date"
		+ " order by CTRECDT desc, CTRECTM desc fetch first 1 row only"
		+ ") as CTPICDT"
		+ ",(select CTRTNDT from rci.ReConth where exists(select 1 from rci.ReContI where"
		+ " IVCONT = ctcont and IVINVID = EIINVID and IvScan = 'Y')" 
		+ " and ctsts in ('OPEN', 'PICKEDUP')"
		+ " and CTPICDT <= current date"
		+ " order by CTRECDT desc, CTRECTM desc fetch first 1 row only"
		+ ") as CTRTNDT"
		+ ",(select CTSTS from rci.ReConth where exists(select 1 from rci.ReContI where"
		+ " IVCONT = ctcont and IVINVID = EIINVID and IvScan = 'Y')" 
		+ " and ctsts in ('OPEN', 'PICKEDUP')"
		+ " and CTPICDT <= current date"
		+ " order by CTRECDT desc, CTRECTM desc fetch first 1 row only"
		+ ") as CTSTS"
		+ ", case when EITESTDT is not null and EiTestDt <> '0001-01-01' then char(EITESTDT, usa) else ' ' end as EITESTDT" 
		+ ",EIGRADE,EITECH"	
		+ ", case when EiADDDT=EIRECDT then char(EIRECTM,usa) else ' ' end as AddTm"
		+ ", case when EiADDDT=EIRECDT then EIRECUS else ' ' end as AddUser"
		+ ", case when eitech > 0 then (select ename from rci.rciemp where erci=eitech)"
		+ " else ' ' end as techName"
		+ " from Rci.ReInv"			 
		+ " inner join iptsfil.IpClass on eicls=ccls"
		+ " inner join iptsfil.IpMrVen on eibrand=vven"
		+ " inner join iptsfil.IpSizes on eisiz=ssiz"
     	+ " where EiSrln='" + sSrlNum + "'"
     	;
		
		if(sStrNum != null)
		{
			sStmt += " and eiStr=" + sStrNum; 
		}
     	
    	sStmt += " fetch first 1 row only"
    	
        + ")"
    	+ " select EIINVID,EISTR,EICLS,eisiz,EISRLN,EIPRCHYR,EIBRAND,EIMODEL" 
        + ", char(EIADDDT,usa) as EiAddDt" 
    	+ ",EIMFGSN,EILIFE,EITRADE,clnm, vnam, snam, eists"
    	+ ", case when reason is not null then reason else '' end as reason"
    	+ ", case when cont is not null then cont else 0 end as cont"
    	+ ", case when CTPICDT is not null then ctpicdt else '0001-01-01' end as ctpicdt"
    	+ ", case when CTRTNDT is not null then ctrtndt else '0001-01-01' end as ctrtndt"
    	+ ", case when CTSts is not null then ctSts else '' end as ctsts"
    	+ ", EITESTDT,EIGRADE,EITECH, AddTm, AddUser, techName" 
    	+ " from invf"
    ;   
   
   System.out.println("\n" + sStmt);

   RunSQLStmt sql_Item = new RunSQLStmt();
   sql_Item.setPrepStmt(sStmt);
   ResultSet rs_Item = sql_Item.runQuery();
   boolean bSnFound = false;
   
   String sInvId = "";
   String sStr = "";
   String sCls = "";
   String sSiz = "";
   String sSrlNm = "";
   String sPrchYr = "";
   String sBrand = "";
   String sModel = "";
   String sMfgSn = "";
   String sLife = "";
   String sTrade = "";
   String sClsNm = "";
   String sVenNm = "";
   String sSizNm = "";
   String sInvSts = "";
   String sReason = "";
   String sCont = "";
   String sContPD = "";
   String sContRD = "";
   String sContSts = "";
   String sTestDt = "";
   String sGrade = "";
   String sTech = "";
   String sAddDt = "";
   String sAddTm = "";
   String sAddUs = "";
   String sTechName = "";
   
   if(sql_Item.readNextRecord())
   {
      bSnFound = true;  
      
      sInvId = sql_Item.getData("EIINVID").trim();
	  sStr = sql_Item.getData("eiStr").trim();
	  sCls = sql_Item.getData("eiCls").trim();
	  sSiz = sql_Item.getData("eisiz").trim();
	  sSrlNum = sql_Item.getData("EISRLN").trim();
	  sPrchYr = sql_Item.getData("EIPRCHYR").trim();
	  sBrand = sql_Item.getData("eiBrand").trim();
	  sModel = sql_Item.getData("eiModel").trim();
	  sMfgSn= sql_Item.getData("eiMfgSn").trim();
	  sLife = sql_Item.getData("eiLife").trim();
	  sTrade = sql_Item.getData("eiTrade").trim();
	  sClsNm = sql_Item.getData("clnm").trim();
	  sVenNm = sql_Item.getData("vnam").trim();
	  sSizNm = sql_Item.getData("snam").trim();
	  sInvSts = sql_Item.getData("EiSts").trim();
	  
	  sReason = sql_Item.getData("reason");
	  if(sReason == null){ sReason = ""; }
	  else{ sReason = sReason.trim(); } 
	  sCont = sql_Item.getData("cont");
	  sContPD = sql_Item.getData("ctpicdt");
	  sContRD = sql_Item.getData("ctrtndt");
	  sContSts = sql_Item.getData("ctsts");
	  if(sCont.equals("0"))
	  { 
		  sCont = ""; 
		  sContPD = "";
		  sContRD = "";
		  sContSts = "";
	  }	  
	  else 
	  {
		  sCont = sCont.trim(); 
		  sContPD = sContPD.trim();
		  sContRD = sContRD.trim(); 
		  sContSts = sContSts.trim();
	  }
	  sTestDt = sql_Item.getData("EITESTDT");
	  sGrade = sql_Item.getData("EIGrade");
	  sTech = sql_Item.getData("EITech");
	  sAddDt = sql_Item.getData("EIAddDt");
	  sAddTm = sql_Item.getData("AddTm");
	  sAddUs = sql_Item.getData("AddUser");
	  sTechName = sql_Item.getData("TechName");
   }
   sql_Item.disconnect();
%>
<SN_Valid><%=bSnFound%></SN_Valid>
<InvId><%=sInvId%></InvId><Str><%=sStr%></Str><Cls><%=sCls%></Cls><Siz><%=sSiz%></Siz><SrlNum><%=sSrlNum%></SrlNum>
<PerchYr><%=sPrchYr%></PerchYr><Brand><%=sBrand%></Brand><Model><%=sModel%></Model>
<MfgSn><%=sMfgSn%></MfgSn><Life><%=sLife%></Life><ClsNm><%=sClsNm%></ClsNm><VenNm><%=sVenNm%></VenNm>
<SizNm><%=sSizNm%></SizNm><Trade><%=sTrade%></Trade><InvSts><%=sInvSts%></InvSts>
<Reason><%=sReason%></Reason>
<Cont><%=sCont%></Cont><ContPD><%=sContPD%></ContPD><ContRD><%=sContRD%></ContRD><ContSts><%=sContSts%></ContSts>
<TestDt><%=sTestDt%></TestDt><Grade><%=sGrade%></Grade><Tech><%=sTech%> - <%=sTechName%></Tech>
<AddDt><%=sAddDt%></AddDt><AddTm><%=sAddTm%></AddTm><AddUs><%=sAddUs%></AddUs>











