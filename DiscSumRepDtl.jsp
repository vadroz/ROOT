<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, rciutility.CallAs400SrvPgmSup
,java.text.*, java.math.*"%>
<%
  String sStr = request.getParameter("Str");
  String sCode = request.getParameter("Code");
  String sYear = request.getParameter("Year");
  String sFrDate = request.getParameter("FrDate");
  String sToDate = request.getParameter("ToDate");
  String sSort = request.getParameter("Sort");
  String sInclDiv = request.getParameter("InclDiv");
  String sBogo = request.getParameter("Bogo");
  String sInclCode = request.getParameter("InclCode");
  String sCust = request.getParameter("Cust");

//----------------------------------
// Application Authorization
//----------------------------------

 
if (session.getAttribute("USER")!=null)
{
   String sUser = session.getAttribute("USER").toString();
   
   String sStmt = "";
   RunSQLStmt runsql = null;
   String sCls = "";
   String sVen = "";
   String sSty = "";
   String sClr = ""; 
   String sSiz = "";
   String sRet = "";
   String sCost = "";
   String sDisc = "";
   String sDiscPrc = "";
   String sQty = "";
   String sDesc = "";
   String sSku = "";
   String sGtin = "";
   String sVenSty = "";
   String sClrNm = "";
   String sSizNm = "";
   String sVenNm = "";
   String sReg = "";
   String sTran= "";
   String sDate= "";
   String sCash= "";
   String sClsNm= "";
   String sSlsp= "";
   String sDiv= "";
   String sCoup= "";
   String sCoupNm= "";
   String sPrice= "";
   String sTotQty = "";
   String sTotRet = "";
   String sTotDisc = "";
   
   
   if(!sStr.equals("70"))
   {
	   sStmt = "select digits(ecls) as ecls, digits(even) as even, digits(esty) as esty" 
       + ", digits(eclr) as eclr , digits(esiz) as esiz, eret,ecst, edisc, dec(eqty,9,0) as eqty" 
       + ", isku, igtin, ides, ivst, vnam, clrn, snam, ereg, eent, edai, digits(ecsh) as ecsh, clnm, digits(eemp) as eemp, cdiv" 
       + ", ecoup"
       + ", case when ecoup > 0 then (select anam from rci.AdvCode where acod=ecoup) else ' ' end as coupNm"
       + ", dec(eprc * eqty,9,2) as price"
       + " from Rci.RciSacm" 
       + " inner join IpTsFil.IpItHdr on ecls=icls and even=iven and esty=isty and eclr=iclr" 
       + " and esiz=isiz" 
       + " inner join IpTsFil.IpMrVen on vven=even" 
       + " inner join IpTsFil.IpColor on cclr=eclr" 
       + " inner join IpTsFil.IpSizes on ssiz=esiz" 
       + " inner join IpTsFil.IpClass on ccls=ecls"
       + " where edai>='" + sFrDate + "'" 
       + " and edai <= '" + sToDate + "'" 
       + " and edisc <> 0 ";
       
       if(!sCode.equals("07") && !sCode.equals("EMP")){ sStmt += " and edsc = " + sCode + " and ecoup <> 1080";  }
       else if(!sCode.equals("EMP")) { sStmt += " and (edsc=7 or ecoup = 1080)";  }
       
       //exclude employee purchases
       if(!sCode.equals("EMP")){ sStmt += " and etos not in ('080', '80')";  }
       else{ sStmt += " and etos in ('080', '80')";  }
       
       if(!sInclDiv.equals("Y")){ sStmt += " and idiv not in (95,96,97,98) and ecls not in (604, 7737)"; }
       
       // include/exclude BOGO
       if(sBogo.equals("1"))
       { 
    	   sStmt += " and (edsc not in (2,12) " 
    		+ "or edsc in (2,12) " 
    	    + " and (abs(abs(eret) - abs(edisc)) > 0.10 or abs(abs(eret/2) - abs(edisc)) > 0.10))"; 
       }
       else if(sBogo.equals("3"))
       { 
    	   sStmt += " and edsc in (2,12)" 
    	    + " and (abs(abs(eret) - abs(edisc)) <= 0.10 or abs(abs(eret/2) - abs(edisc)) <= 0.10) "; 
       }
       
       // include/exclude Marketing Code
       if(sInclCode.equals("2"))
       { 
    	   sStmt += " and ecoup > 0"; 
       }
       else if(sInclCode.equals("3"))
       { 
    	   sStmt += " and ecoup = 0"; 
       }
       
       // include/exclude Store Walk-in custormer 
       if(sCust.equals("2"))
       { 
    	   sStmt += " and not exists(select 1 from IpStore where sspn <> ' ' and epcn = dec(sspn))"; 
       }
       else if(sCust.equals("3"))
       { 
    	   sStmt += " and exists(select 1 from IpStore where sspn <> ' ' and epcn = dec(sspn))"; 
       }
    	   
       sStmt += " and eist=" + sStr; 
       ;
       
      if(sSort.equals("Div")){ sStmt +=  " order by edai, ereg, eent "; }
      else if(sSort.equals("Cashier")){ sStmt +=  " order by ecsh, edai, ereg, eent"; }
      else if(sSort.equals("Retail")){ sStmt +=  " order by eret desc, edai, ereg, eent "; }
      else if(sSort.equals("Vendor")){ sStmt +=  " order by vnam, edai, ereg, eent "; }
      else if(sSort.equals("Disc$")){ sStmt +=  " order by edisc, edai, ereg, eent "; }
   	;

   System.out.println("\n" + sStmt);
   runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   runsql.runQuery();
   
   Vector<String> vCls = new Vector<String>();
   Vector<String> vVen = new Vector<String>();
   Vector<String> vSty = new Vector<String>();
   Vector<String> vClr = new Vector<String>();
   Vector<String> vSiz = new Vector<String>();
   Vector<String> vRet = new Vector<String>();
   Vector<String> vCost = new Vector<String>();
   Vector<String> vDisc = new Vector<String>();
   Vector<String> vDiscPrc = new Vector<String>();
   Vector<String> vQty = new Vector<String>();
   Vector<String> vDesc = new Vector<String>();
   Vector<String> vSku = new Vector<String>();
   Vector<String> vGtin = new Vector<String>();
   Vector<String> vVenSty = new Vector<String>();
   Vector<String> vClrNm = new Vector<String>();
   Vector<String> vSizNm = new Vector<String>();
   Vector<String> vVenNm = new Vector<String>();
   Vector<String> vReg = new Vector<String>();
   Vector<String> vTran = new Vector<String>();
   Vector<String> vDate = new Vector<String>();
   Vector<String> vCash = new Vector<String>();
   Vector<String> vClsNm = new Vector<String>();
   Vector<String> vSlsp = new Vector<String>();
   Vector<String> vDiv = new Vector<String>();
   Vector<String> vCoup = new Vector<String>();
   Vector<String> vCoupNm = new Vector<String>();
   Vector<String> vPrice = new Vector<String>();
   		
   double dTotQty = 0.00;
   double dTotRet = 0.00;
   double dTotDisc = 0.00;
   
   while(runsql.readNextRecord())
   {
   		vCls.add(runsql.getData("ecls").trim());
   		vVen.add(runsql.getData("even").trim());
   		vSty.add(runsql.getData("esty").trim());
   		vClr.add(runsql.getData("eclr").trim());
   		vSiz.add(runsql.getData("esiz").trim());
   		vCost.add(runsql.getData("ecst").trim());
   		
   		String ret = runsql.getData("eret");
   		vRet.add(ret.trim());
   		String disc = runsql.getData("edisc");   		
   		vDisc.add(disc);
   		
   		// calculate discount percents   		
   		double dRet = Double.valueOf(ret);
   		double dDisc = Double.valueOf(disc);
   		double dPrc = 0.00;
   		if(dRet != 0.00)
   		{
   			dPrc = dDisc / dRet * 100.00;   			
   		}
   		BigDecimal bdPrc = BigDecimal.valueOf(dPrc);
   		bdPrc = bdPrc.setScale(1, RoundingMode.HALF_UP);   		
   		vDiscPrc.add(bdPrc.toString());
   		   		
   		String qty = runsql.getData("eqty"); 
   		vQty.add(qty);
   		
   		// sumurize total   		
   		dTotQty += Double.valueOf(qty);
   		dTotRet += dRet;
   		dTotDisc += dDisc;
   		
   		vSku.add(runsql.getData("isku").trim());
   		vGtin.add(runsql.getData("igtin").trim());
   		
   		String s = runsql.getData("ides").trim();
   		s = s.replaceAll("'", "&#39;");
   		vDesc.add(s);
   		
   		s = runsql.getData("ivst").trim();
   		s = s.replaceAll("'", "&#39;");
   		vVenSty.add(s);  
   		
   		s = runsql.getData("clrn").trim();
   		s = s.replaceAll("'", "&#39;");
   		vClrNm.add(s);  
   		
   		s = runsql.getData("snam").trim();
   		s = s.replaceAll("'", "&#39;");
   		vSizNm.add(s);  
   		
   		s = runsql.getData("vnam").trim();
   		s = s.replaceAll("'", "&#39;");
   		vVenNm.add(s);
   		
   		vReg.add(runsql.getData("ereg").trim());
   		vTran.add(runsql.getData("eent").trim());
   		vDate.add(runsql.getData("edai").trim());
   		vCash.add(runsql.getData("ecsh").trim());
   		
   		s = runsql.getData("clnm").trim();
   		s = s.replaceAll("'", "&#39;");
   		vClsNm.add(s);
   		
   		vSlsp.add(runsql.getData("eemp").trim());
   		vDiv.add(runsql.getData("cdiv").trim());
   		vCoup.add(runsql.getData("ecoup").trim());
   		vCoupNm.add(runsql.getData("coupNm").trim());
   		vPrice.add(runsql.getData("price").trim());
   }
   		
   		CallAs400SrvPgmSup srv = new CallAs400SrvPgmSup();
   		sCls = srv.cvtToJavaScriptArray( vCls.toArray(new String[]{}) );
   		sVen = srv.cvtToJavaScriptArray( vVen.toArray(new String[]{}) );
   		sSty = srv.cvtToJavaScriptArray( vSty.toArray(new String[]{}) );
   		sClr = srv.cvtToJavaScriptArray( vClr.toArray(new String[]{}) );
   		sSiz = srv.cvtToJavaScriptArray( vSiz.toArray(new String[]{}) );
   		sRet = srv.cvtToJavaScriptArray( vRet.toArray(new String[]{}) );
   		sCost = srv.cvtToJavaScriptArray( vCost.toArray(new String[]{}) );
   		sDisc = srv.cvtToJavaScriptArray( vDisc.toArray(new String[]{}) );
   		sDiscPrc = srv.cvtToJavaScriptArray( vDiscPrc.toArray(new String[]{}) );
   		sQty = srv.cvtToJavaScriptArray( vQty.toArray(new String[]{}) );
   		sDesc = srv.cvtToJavaScriptArray( vDesc.toArray(new String[]{}) );
   		sSku = srv.cvtToJavaScriptArray( vSku.toArray(new String[]{}) );
   		sGtin = srv.cvtToJavaScriptArray( vGtin.toArray(new String[]{}) );
   		sDesc = srv.cvtToJavaScriptArray( vDesc.toArray(new String[]{}) );
   		sVenSty = srv.cvtToJavaScriptArray( vVenSty.toArray(new String[]{}) );
   		sClrNm = srv.cvtToJavaScriptArray( vClrNm.toArray(new String[]{}) );
   		sSizNm = srv.cvtToJavaScriptArray( vSizNm.toArray(new String[]{}) );
   		sVenNm = srv.cvtToJavaScriptArray( vVenNm.toArray(new String[]{}) );
   		sReg = srv.cvtToJavaScriptArray( vReg.toArray(new String[]{}) );
   		sTran = srv.cvtToJavaScriptArray( vTran.toArray(new String[]{}) );
   		sDate = srv.cvtToJavaScriptArray( vDate.toArray(new String[]{}) );
   		sCash = srv.cvtToJavaScriptArray( vCash.toArray(new String[]{}) );
   		sClsNm = srv.cvtToJavaScriptArray( vClsNm.toArray(new String[]{}) );
   		sSlsp = srv.cvtToJavaScriptArray( vSlsp.toArray(new String[]{}) );
   		sDiv = srv.cvtToJavaScriptArray( vDiv.toArray(new String[]{}) );
   		sCoup = srv.cvtToJavaScriptArray( vCoup.toArray(new String[]{}) );
   		sCoupNm = srv.cvtToJavaScriptArray( vCoupNm.toArray(new String[]{}) );
   		sPrice = srv.cvtToJavaScriptArray( vPrice.toArray(new String[]{}) );
   		   		
   		BigDecimal bdQty = BigDecimal.valueOf(dTotQty);
   		bdQty = bdQty.setScale(0, RoundingMode.HALF_UP);
   		sTotQty = bdQty.toString();
   		BigDecimal bdRet = BigDecimal.valueOf(dTotRet);
   		bdRet = bdRet.setScale(2, RoundingMode.HALF_UP);
   		sTotRet = bdRet.toString();
   		BigDecimal bdDisc = BigDecimal.valueOf(dTotDisc);
   		bdDisc = bdDisc.setScale(2, RoundingMode.HALF_UP);   		
   		sTotDisc = bdDisc.toString();
   	}
     
   	    runsql.disconnect();
   	    runsql = null;   		
  
   
%>

<script name="javascript1.2">
var str = "<%=sStr%>";
var code = "<%=sCode%>";
var year = "<%=sYear%>";
var frdate = "<%=sFrDate%>";
var todate = "<%=sToDate%>";		

var cls = [<%=sCls%>];
var ven = [<%=sVen%>];
var sty = [<%=sSty%>];
var clr = [<%=sClr%>];
var siz = [<%=sSiz%>];
var ret = [<%=sRet%>];
var cost = [<%=sCost%>];
var disc = [<%=sDisc%>];
var discPrc = [<%=sDiscPrc%>];
var qty = [<%=sQty%>];
var desc = [<%=sDesc%>];
var sku = [<%=sSku%>];
var gtin = [<%=sGtin%>];
var desc = [<%=sDesc%>];
var venSty = [<%=sVenSty%>];
var clrNm = [<%=sClrNm%>];
var sizNm = [<%=sSizNm%>];
var venNm = [<%=sVenNm%>];
var reg = [<%=sReg%>];
var tran = [<%=sTran%>];
var date = [<%=sDate%>];
var cash = [<%=sCash%>];
var clsNm = [<%=sClsNm%>];
var slsp = [<%=sSlsp%>];
var div = [<%=sDiv%>];
var coup = [<%=sCoup%>];
var coupNm = [<%=sCoupNm%>];
var price = [<%=sPrice%>];

var totQty = "<%=sTotQty%>";
var totRet = "<%=sTotRet%>";
var totDisc = "<%=sTotDisc%>";

parent.showDiscDtl(str, code, year, frdate, todate, cls, ven, sty, clr, siz, ret, cost, disc
   ,qty , desc, sku, gtin, venSty, clrNm, sizNm, venNm
   , reg, tran, date, cash, clsNm, slsp, div, coup, coupNm, discPrc, price, totQty, totRet, totDisc); 
</script>

<%}%>








