<%@ page import="rciutility.RunSQLStmt, rciutility.CallAs400SrvPgmSup, java.util.*
, java.text.*, java.io.*, java.math.*, java.sql.*"%>
<%
	String sSelParent = request.getParameter("Prod");
	String sStmt = "select a.prod, price, sales, cival as color, sival as size,ki_prc,ki_sls" 
			+ ", time(a.recdt) as rectm"
			+ ", (select price from rci.moprcinv b where b.prod = a.prod and date(b.recdt) = date(a.recdt) - 1 days fetch first 1 row only)  as old_prc"
			+ ", (select sales from rci.moprcinv b where b.prod = a.prod and date(b.recdt) = date(a.recdt) - 1 days fetch first 1 row only)  as old_sls"
     		+ " from rci.moprcinv a"
     		+ " left join rci.MoItWeb on"     			 
     		+ " dec(substr(a.prod,1,4),4,0) = wcls" 
     		+ " and dec(substr(a.prod,5,5),5,0) = wven"
     		+ " and dec(substr(a.prod,10,4),4,0) = wsty"
     		+ " and dec(substr(a.prod,15,3),3,0) = wclr"
     		+ " and dec(substr(a.prod,18,4),4,0) = wsiz"     			
     		+ " left join rci.MoColor on cisite='11961' and ciopt=dec(substr(trim(wclrnm),1,7),7,0)" 
     		+ " left join rci.MoSize on sisite='11961' and siopt=dec(substr(trim(wsiznm),1,7),7,0)"
     		+ " left join rci.MoPrcTod b on b.prod=a.prod and b.recdt >= current date"     			     			
     		+ " where a.parent = 2 and a.prod like('" + sSelParent + "%')"
     		+ " and a.recdt >= current date"
     		+ " and exists(select 1 from rci.moprcinv b where a.prod=b.prod and a.recdt > b.recdt " 
     		+ " and (a.price <> b.price or a.sales <> b.sales)"
     		+ " and recdt >= date(current date) - 1 days  and recdt < date(current date))"     			
     		+ " order by a.prod"
     		;
         	System.out.println(sStmt);
           	RunSQLStmt runsql = new RunSQLStmt();
 			runsql.setPrepStmt(sStmt);
 			ResultSet rs = runsql.runQuery();	
 			int i=0;
 			
 			Vector<String> vProd = new Vector<String>();
 			Vector<String> vPrice = new Vector<String>();
 			Vector<String> vSales = new Vector<String>(); 			
 			Vector<String> vClrNm = new Vector<String>();
 			Vector<String> vSizNm = new Vector<String>();
 			Vector<String> vKiPrc = new Vector<String>();
 			Vector<String> vKiSls = new Vector<String>(); 			
 			Vector<String> vRecTm = new Vector<String>();
 			Vector<String> vOldPrc = new Vector<String>();
 			Vector<String> vOldSls = new Vector<String>();
 			
 			while(runsql.readNextRecord())
 			{
 				i++;
 				vProd.add(runsql.getData("prod").trim());
 				vPrice.add(runsql.getData("price").trim());
 				vSales.add(runsql.getData("sales").trim());
 				vClrNm.add(runsql.getData("color").trim());
 				vSizNm.add(runsql.getData("size").trim());
 				
 				String kp = runsql.getData("ki_prc");
 				if(kp == null){ kp = ""; }
 				vKiPrc.add(kp.trim());
 				
 				String ks = runsql.getData("ki_sls");
 				if(ks==null){ ks = "";}
 				vKiSls.add(ks.trim());
 				
 				vRecTm.add(runsql.getData("rectm").trim());
 				vOldPrc.add(runsql.getData("old_prc").trim());
 				vOldSls.add(runsql.getData("old_sls").trim());
 			}
 			
 			CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
 			
 			String sProd = srvpgm.cvtToJavaScriptArray(vProd.toArray(new String[vProd.size()]));
 			String sPrice = srvpgm.cvtToJavaScriptArray(vPrice.toArray(new String[vPrice.size()]));
 			String sSales = srvpgm.cvtToJavaScriptArray(vSales.toArray(new String[vSales.size()]));
 			String sClrNm = srvpgm.cvtToJavaScriptArray(vClrNm.toArray(new String[vClrNm.size()]));
 			String sSizNm = srvpgm.cvtToJavaScriptArray(vSizNm.toArray(new String[vSizNm.size()]));
 			String sKiPrc = srvpgm.cvtToJavaScriptArray(vKiPrc.toArray(new String[vKiPrc.size()]));
 			String sKiSls = srvpgm.cvtToJavaScriptArray(vKiSls.toArray(new String[vKiSls.size()]));
 			String sRecTm = srvpgm.cvtToJavaScriptArray(vRecTm.toArray(new String[vRecTm.size()]));
 			String sOldPrc = srvpgm.cvtToJavaScriptArray(vOldPrc.toArray(new String[vOldPrc.size()]));
 			String sOldSls = srvpgm.cvtToJavaScriptArray(vOldSls.toArray(new String[vOldSls.size()]));
 			
%>


<SCRIPT language="JavaScript1.2">
var prod =  [<%=sProd%>];
var price = [<%=sPrice%>];
var sales = [<%=sSales%>];
var clrNm = [<%=sClrNm%>];
var sizNm = [<%=sSizNm%>];
var kiPrc = [<%=sKiPrc%>];
var kiSls = [<%=sKiSls%>];
var recTm = [<%=sRecTm%>];
var oldPrc = [<%=sOldPrc%>];
var oldSls = [<%=sOldSls%>];

parent.showChildPrc(prod,price,sales,clrNm,sizNm,kiPrc,kiSls,recTm,oldPrc,oldSls);

</SCRIPT>


