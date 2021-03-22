<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, rciutility.CallAs400SrvPgmSup
,java.text.*, java.math.*"%>
<%
  String sStr = request.getParameter("Str");
  String sSelCoup = request.getParameter("Coup");
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
   
   if(!sStr.equals("70"))
   {
	   sStmt = "select digits(ecls) as ecls, digits(even) as even, digits(esty) as esty" 
       + ", digits(eclr) as eclr , digits(esiz) as esiz, eret,ecst, edisc, dec(eqty,9,0) as eqty" 
       + ", isku, igtin, ides, ivst, vnam, clrn, snam, ereg, eent, edai, digits(ecsh) as ecsh, clnm, digits(eemp) as eemp, cdiv" 
       + ", case when ecoup > 0 then ecoup when elid <> ' ' then dec(substr(elid,1,4),4,0) end as ecoup"
       + ", case when ecoup > 0 then (select anam from rci.AdvCode where acod=ecoup)" 
       + " when elid <> ' ' then (select anam from rci.AdvCode where acod=dec(substr(elid,1,4),4,0))" 
       + " else ' ' end as coupNm"
       + " from Rci.RciSacm" 
       + " inner join IpTsFil.IpItHdr on ecls=icls and even=iven and esty=isty and eclr=iclr" 
       + " and esiz=isiz" 
       + " inner join IpTsFil.IpMrVen on vven=even" 
       + " inner join IpTsFil.IpColor on cclr=eclr" 
       + " inner join IpTsFil.IpSizes on ssiz=esiz" 
       + " inner join IpTsFil.IpClass on ccls=ecls"
       + " where edai>='" + sFrDate + "'" 
       + " and edai <= '" + sToDate + "'" 
       + " and edisc <> 0 "
       + " and etos not in ('080', '80')"
       ;
       
       if(!sInclDiv.equals("Y")){ sStmt += " and idiv not in (95,96,97,98) and ecls not in (604, 7737)"; }
       
       
       // Include/Exclude BOGO
       if(sBogo.equals("1"))
       { 
    	   sStmt += " and (edsc not in (2,12) " 
             + "or edsc in (2,12) " 
    		 + " and not (abs(abs(eret) - abs(edisc)) <= 0.10 or abs(abs(eret/2) - abs(edisc)) <= 0.10))"; 
       }
       else if(sBogo.equals("3"))
       { 
    	   sStmt += " and edsc in (2,12) " 
            + "and (abs(abs(eret) - abs(edisc)) <= 0.10 or abs(abs(eret/2) - abs(edisc)) <= 0.10) "; 
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
       
       sStmt += " and (ecoup = " + sSelCoup
    		+ " or ecoup=0 and elid <> ' ' and dec(substr(elid,1,4),4,0) = " + sSelCoup + ")"; 
       
       
      if(sSort.equals("Div")){ sStmt +=  " order by cdiv, ecls, esku "; }
      else if(sSort.equals("Cashier")){ sStmt +=  " order by ecsh, cdiv, ecls"; }
      else if(sSort.equals("Retail")){ sStmt +=  " order by eret desc, cdiv, ecls "; }
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
   		bdPrc = bdPrc.setScale(2, RoundingMode.HALF_UP);   		
   		vDiscPrc.add(bdPrc.toString());
   		   		
   		vQty.add(runsql.getData("eqty"));
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
   	}
     
   	    runsql.disconnect();
   	    runsql = null;   		
  
   
%>

<script name="javascript1.2">
var str = "<%=sStr%>";
var code = "<%=sSelCoup%>";
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

parent.showDiscDtl(str, code, year, frdate, todate, cls, ven, sty, clr, siz, ret, cost, disc
   ,qty , desc, sku, gtin, venSty, clrNm, sizNm, venNm
   , reg, tran, date, cash, clsNm, slsp, div, coup, coupNm, discPrc); 
</script>

<%}%>








