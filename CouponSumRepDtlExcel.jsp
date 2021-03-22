<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, rciutility.CallAs400SrvPgmSup
,java.text.*, java.math.*"%>
<%
  String sSelStr = request.getParameter("Str");
  String sSelCoup = request.getParameter("Coup");
  String sFrDate = request.getParameter("FrDate");
  String sToDate = request.getParameter("ToDate");
  String sInclDiv = request.getParameter("InclDiv");
  String sBogo = request.getParameter("Bogo");
  String sInclCode = request.getParameter("InclCode");
  String sCust = request.getParameter("Cust");
  
  response.setContentType("application/vnd.ms-excel");
  //response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
  
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
   String sTran = "";
   String sDate = "";
   String sCash = "";
   String sClsNm = "";
   String sSlsp = "";
   String sDiv = "";
   String sCoup = "";
   String sCoupNm = "";
   String sCode = "";
   String sStr = "";
    
   sStmt = "select digits(ecls) as ecls, digits(even) as even, digits(esty) as esty" 
	       + ", digits(eclr) as eclr , digits(esiz) as esiz, eret,ecst, edisc, dec(eqty,9,0) as eqty" 
	       + ", isku, igtin, ides, ivst, vnam, clrn, snam, ereg, eent, edai, digits(ecsh) as ecsh, clnm, digits(eemp) as eemp, cdiv" 
	       + ", ecoup"
	       + ", case when ecoup > 0 then (select anam from rci.AdvCode where acod=ecoup) else ' ' end as coupNm"
	       + ", edsc, eist"
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
       
       if(!sSelStr.equals("ALL")) { sStmt += " and eist=" + sSelStr; }  
       if(!sSelCoup.equals("ALL")) 
       { 
    	   sStmt += " and (ecoup = " + sSelCoup
    	    + " or ecoup=0 and elid <> ' ' and dec(substr(elid,1,4),4,0) = " + sSelCoup + ")"; 
           ; 
       }
       
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
       
       sStmt += " order by cdiv, ecls, esku ";  

   System.out.println("\n" + sStmt);
   runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   runsql.runQuery();
   
   out.println("\t\t\t Retail Concepts, Inc" );
   out.println("\t\t\t Market Code Summary" );
   out.println("\t\t\t Store: " + sSelStr + "\t Discount Code: " + sSelCoup + "\tFrom: " + sFrDate + "\tTo: " + sToDate);
   
   out.println("Str\tDate\tReg\tTrans\tCashier\tSalesperson \tDiv \tClass\tDescription" 
     + "\tColor Name\tSize Name\tVendor Style\tVendor Name\tSKU\tGTIN\tQTY\tRet\tDisc $\tDisc %" 
     + "\tCode\tMkt. Code\tMkt. Code Name");
		  
   while(runsql.readNextRecord())
   {	   	
	   sCls = runsql.getData("ecls").trim();
   		sVen = runsql.getData("even").trim();
   		sSty = runsql.getData("esty").trim();
   		sClr = runsql.getData("eclr").trim();
   		sSiz = runsql.getData("esiz").trim();   		
   		sCost = runsql.getData("ecst").trim();   		
   		sRet = runsql.getData("eret").trim();   		
   		sDisc = runsql.getData("edisc");   		
   		
   	// calculate discount percents   		
   		double dRet = Double.valueOf(sRet);
   		double dDisc = Double.valueOf(sDisc);
   		double dPrc = 0.00;
   		if(dRet != 0.00)
   		{
   			dPrc = dDisc / dRet * 100.00;   			
   		}
   		BigDecimal bdPrc = BigDecimal.valueOf(dPrc);
   		bdPrc = bdPrc.setScale(2, RoundingMode.HALF_UP);   		
   		sDiscPrc = bdPrc.toString();
   		
   		
   		sQty = runsql.getData("eqty");
   		sSku = runsql.getData("isku").trim();
   		sGtin = runsql.getData("igtin").trim();
   		
   		sDesc = runsql.getData("ides").trim();
   		sDesc = sDesc.replaceAll("'", "&#39;");
   		
   		sVenSty = runsql.getData("ivst").trim();
   		sVenSty = sVenSty.replaceAll("'", "&#39;");
   		
   		sClrNm = runsql.getData("clrn").trim();
   		sClrNm = sClrNm.replaceAll("'", "&#39;");
   		
   		sSizNm = runsql.getData("snam").trim();
   		sSizNm = sSizNm.replaceAll("'", "&#39;");
   		
   		sVenNm = runsql.getData("vnam").trim();
   		sVenNm = sVenNm.replaceAll("'", "&#39;");
   		
   		sReg = runsql.getData("ereg").trim();
   		sTran = runsql.getData("eent").trim();
   		sDate = runsql.getData("edai").trim();
   		sCash = runsql.getData("ecsh").trim();
   		sClsNm = runsql.getData("clnm").trim();
   		sSlsp = runsql.getData("eemp").trim();
   		sDiv = runsql.getData("cdiv").trim();
   		sCoup = runsql.getData("ecoup").trim();   		
   		sCoupNm = runsql.getData("coupNm").trim();
   		sCode = runsql.getData("eDsc").trim();
   		sStr = runsql.getData("eist").trim();
   		
   		out.println(sStr + "\t" + sDate + "\t" + sReg + "\t" + sTran + "\t" + sCash + "\t" + sSlsp
   			 + "\t" + sDiv + "\t" + sCls + " - " + sClsNm + "\t" + sDesc + "\t" + sClrNm
   			 + "\t" + sSizNm + "\t" + sVenSty + "\t" + sVenNm + "\t" + sSku + "\t" + sGtin
   			 + "\t" + sQty + "\t" + sRet + "\t" + sDisc + "\t" + sDiscPrc + "%"
   			 + "\t" + sCode + "\t" + sCoup + "\t" + sCoupNm
   		);
   		
   		
   		CallAs400SrvPgmSup srv = new CallAs400SrvPgmSup();
   	}
     
   	    runsql.disconnect();
   	    runsql = null;   		
  
   
%>

 

<%}%>








