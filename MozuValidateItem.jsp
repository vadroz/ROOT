<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sItem = request.getParameter("Item");
   String sSite = request.getParameter("Site");

   
   String sStmt = "select ides"
		+ ", case when ILDWNDT <= sdStrDt then 'Y' else 'N' end as oldpar"
		+ ", case when wddat <= sdStrDt then 'Y' else 'N' end as oldchi"
		+ ", case when IdLine  is not null then IdLine else ' ' end as WName"
		+ ", case when cival is not null then cival else ' ' end as clrnm"
		+ ", case when sival is not null then sival else ' ' end as siznm"
		+ " from IpTsFil.IpItHdr"
		+ " inner join rci.MoPrtDtl on ilcls=icls and ilven=iven and ilsty=isty"
		+ " inner join rci.MoItWeb on wcls=icls and wven=iven and wsty=isty"
		+ " inner join rci.MOIP40C on 1=1"
		+ " and wclr=iclr and wsiz=isiz"
		+ " left join rci.MoPrtDsc on idcls=iCLS and idven=iVen and idSty=iSty"
		+ " and idType = 'WName' and idseq=1"
		+ " left join rci.MoColor on cisite='" + sSite + "' and  char(ciOpt) = trim(wClrNm)"
		+ " left join rci.MoSize  on sisite='" + sSite + "' and  char(siOpt) = trim(wSizNm)"	
		+ " inner join IpTsFil.IpColor on cclr = iclr"
		+ " inner join IpTsFil.IpSizes on ssiz = isiz"
		+ " where icls=" + sItem.substring(0,4)
		+ " and iven=" + sItem.substring(4, 10)
		+ " and isty=" + sItem.substring(10, 17)
		+ " and iclr=" + sItem.substring(17, 21)
		+ " and isiz=" + sItem.substring(21)
	;
   
   //System.out.println("\n MozuValidateItem.jsp - " + sStmt);

   RunSQLStmt sql_Item = new RunSQLStmt();
   sql_Item.setPrepStmt(sStmt);
   ResultSet rs_Item = sql_Item.runQuery();
   boolean bUpcFound = false;
   String sSku = "";
   String sDesc = "";   
   String sOldPar = "";
   String sOldChi = "";
   String sWName = "";
   String sClrNm = "";
   String sSizNm = "";
   
   if(sql_Item.readNextRecord())
   {
      bUpcFound = true;
      sDesc = sql_Item.getData("ides");
      sOldPar = sql_Item.getData("oldpar");
      sOldChi = sql_Item.getData("oldchi");
      sWName = sql_Item.getData("WName").trim();
      if(sWName.equals("")){sWName = sDesc; }
      sClrNm = sql_Item.getData("clrnm").trim();
      sSizNm = sql_Item.getData("siznm").trim();
   }   
   sql_Item.disconnect();
   
   String sKiboItem = "";  
   if(sOldPar.equals("Y"))
   {
	   sKiboItem += sItem.substring(0,4) + sItem.substring(5, 10) + sItem.substring(13, 17);
   }
   else
   {
	   sKiboItem += sItem.substring(0,17);
   }
   
   if(sOldChi.equals("Y"))
   {
	   sKiboItem += "-" + sItem.substring(18, 21) + sItem.substring(22);
   }
   else
   { 
	   sKiboItem += "-" + sItem.substring(17);   
   }
   //System.out.println(sSku);

%>
<Item_Valid><%=bUpcFound%></Item_Valid><Desc><%=sWName%></Desc><Kibo><%=sKiboItem%></Kibo>
<ClrNm><%=sClrNm%></ClrNm><SizNm><%=sSizNm%></SizNm>













