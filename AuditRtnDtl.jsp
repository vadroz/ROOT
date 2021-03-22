<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, rciutility.CallAs400SrvPgmSup"%>
<%
  String sStr = request.getParameter("Str");
  String sDayFr = request.getParameter("DayFr");
  String sDayTo = request.getParameter("DayTo");
  String sFrDate = request.getParameter("FrDate");
  String sToDate = request.getParameter("ToDate");

//----------------------------------
// Application Authorization
//----------------------------------

if (session.getAttribute("USER")!=null)
{
   String sUser = session.getAttribute("USER").toString();
   
   String sPrepStmt = "";
   RunSQLStmt runsql = null;
   String sRtnStr = "";
   String sSlsStr = "";
   String sRtnDt = "";
   String sSlsDt = ""; 
   String sRtnRet = "";
   String sRtnCost = "";
   String sRtnQty = "";
   String sEmpPurch = "";
   String sSlsDoc = "";
   String sRtnDoc = "";
   String sSlsCash = "";
   String sSlsEmp = "";
   String sRtnCash = "";
   String sSku = "";
   String sGtin = "";
   String sDesc = "";
   String sVenSty = "";
   String sClrNm = "";
   String sSizNm = "";
   String sVenNm = "";
   String sRtnReg = "";
   String sRtnTran = "";
   String sSlsReg = "";
   String sSlsTran = "";
   
   if(!sStr.equals("70") && !sDayFr.equals("NONE"))
   {
     sPrepStmt = "select r.eist as r_str,s.eist as s_str,r.edai as r_dai" 
	 + ", r.ereg as r_reg, r.eent as r_tran"	   
     + ",s.edai as s_dai,r.eret as r_ret,r.ecst as r_cost,r.eqty as r_qty" 
     + ", case when s.etos='080' then 'Y' else ' ' end as emppurch" 
     + ",s.edoc as s_doc,r.edoc as r_doc, s.ecsh as s_cash, s.eemp as s_emp"
     + ", s.ereg as s_reg, s.eent as s_tran "
     + ", r.ecsh as r_cash, isku, iGtin, ides, ivst, clrn, snam, vnam" 
     + " from rci.rcisacm r" 
     + " inner join rci.rcisacm s on r.erdoc = s.edoc and r.esku=s.esku and r.echk=s.echk" 
     + " left join iptsfil.ipithdr on isku = r.esku *10 + r.echk" 
     + " left join iptsfil.ipColor on cclr=iclr"
     + " left join iptsfil.ipSizes on ssiz=isiz"
     + " left join iptsfil.ipMrVen on vven=iven"
     + " where  ((r.etos ='001' or r.etos ='000' and r.eqty < 0) or (r.etos ='01' or r.etos ='00' and r.eqty < 0))" 
   	 + " and r.edai >= '" + sFrDate + "'" 
     + " and r.edai <= '" + sToDate + "'"
   	 + " and r.erdoc <> 0" 
     + " and r.eist=" + sStr 
   	 + " and  Days(r.edai) - Days(s.edai)  >=" + sDayFr
   	 + " and  Days(r.edai) - Days(s.edai)  <=" + sDayTo
   	 + " order by r.edai, r.ereg, r.eent, r_cash"
   	;

   System.out.println(sPrepStmt);
   runsql = new RunSQLStmt();
   runsql.setPrepStmt(sPrepStmt);
   runsql.runQuery();
   
   Vector<String> vRtnStr = new Vector<String>();
   Vector<String> vSlsStr = new Vector<String>();
   Vector<String> vRtnDt = new Vector<String>();
   Vector<String> vSlsDt = new Vector<String>();
   Vector<String> vRtnRet = new Vector<String>();
   Vector<String> vRtnCost = new Vector<String>();
   Vector<String> vRtnQty = new Vector<String>();
   Vector<String> vEmpPurch = new Vector<String>();
   Vector<String> vSlsDoc = new Vector<String>();
   Vector<String> vRtnDoc = new Vector<String>();
   Vector<String> vSlsCash = new Vector<String>();
   Vector<String> vSlsEmp = new Vector<String>();
   Vector<String> vRtnCash = new Vector<String>();
   Vector<String> vSku = new Vector<String>();
   Vector<String> vGtin = new Vector<String>();
   Vector<String> vDesc = new Vector<String>();
   Vector<String> vVenSty = new Vector<String>();
   Vector<String> vClrNm = new Vector<String>();
   Vector<String> vSizNm = new Vector<String>();
   Vector<String> vVenNm = new Vector<String>();   
   
   Vector<String> vRtnReg = new Vector<String>();
   Vector<String> vRtnTran = new Vector<String>();
   Vector<String> vSlsReg = new Vector<String>();
   Vector<String> vSlsTran = new Vector<String>();
   		
   while(runsql.readNextRecord())
   {
   		vRtnStr.add(runsql.getData("r_str").trim());
   		vSlsStr.add(runsql.getData("s_str").trim());
   		vRtnDt.add(runsql.getData("r_dai").trim());
   		vSlsDt.add(runsql.getData("s_dai").trim());
   		vRtnRet.add(runsql.getData("r_ret").trim());
   		vRtnCost.add(runsql.getData("r_cost").trim());
   		vRtnQty.add(runsql.getData("r_qty").trim());
   		vEmpPurch.add(runsql.getData("emppurch"));
   		vSlsDoc.add(runsql.getData("s_doc").trim());
   		vRtnDoc.add(runsql.getData("r_doc").trim());
   		vSlsCash.add(runsql.getData("s_cash").trim());
   		vSlsEmp.add(runsql.getData("s_emp").trim());
   		vRtnCash.add(runsql.getData("r_cash").trim());
   		vSku.add(runsql.getData("isku").trim());
   		vGtin.add(runsql.getData("igtin").trim());
   		
   		String s = runsql.getData("ides").trim();
   		s = s.replaceAll("'", "%27");
   		vDesc.add(s);
   		
   		s = runsql.getData("ivst").trim();
   		s = s.replaceAll("'", "%27");
   		vVenSty.add(s);  
   		
   		s = runsql.getData("clrn").trim();
   		s = s.replaceAll("'", "%27");
   		vClrNm.add(s);  
   		
   		s = runsql.getData("snam").trim();
   		s = s.replaceAll("'", "%27");
   		vSizNm.add(s);  
   		
   		s = runsql.getData("vnam").trim();
   		s = s.replaceAll("'", "%27");
   		vVenNm.add(s);
   		
   		vRtnReg.add(runsql.getData("r_reg").trim());
   		vRtnTran.add(runsql.getData("r_tran").trim());
   		vSlsReg.add(runsql.getData("s_reg").trim());
   		vSlsTran.add(runsql.getData("s_tran").trim());
   }
   		
   		CallAs400SrvPgmSup srv = new CallAs400SrvPgmSup();
   		sRtnStr = srv.cvtToJavaScriptArray( vRtnStr.toArray(new String[]{}) );
   		sSlsStr = srv.cvtToJavaScriptArray( vSlsStr.toArray(new String[]{}) );
   		sRtnDt = srv.cvtToJavaScriptArray( vRtnDt.toArray(new String[]{}) );
   		sSlsDt = srv.cvtToJavaScriptArray( vSlsDt.toArray(new String[]{}) );
   		sRtnRet = srv.cvtToJavaScriptArray( vRtnRet.toArray(new String[]{}) );
   		sRtnCost = srv.cvtToJavaScriptArray( vRtnCost.toArray(new String[]{}) );
   		sRtnQty = srv.cvtToJavaScriptArray( vRtnQty.toArray(new String[]{}) );
   		sEmpPurch = srv.cvtToJavaScriptArray( vEmpPurch.toArray(new String[]{}) );
   		sSlsDoc = srv.cvtToJavaScriptArray( vSlsDoc.toArray(new String[]{}) );
   		sRtnDoc = srv.cvtToJavaScriptArray( vRtnDoc.toArray(new String[]{}) );
   		sSlsCash = srv.cvtToJavaScriptArray( vSlsCash.toArray(new String[]{}) );
   		sSlsEmp = srv.cvtToJavaScriptArray( vSlsEmp.toArray(new String[]{}) );
   		sRtnCash = srv.cvtToJavaScriptArray( vRtnCash.toArray(new String[]{}) );
   		sSku = srv.cvtToJavaScriptArray( vSku.toArray(new String[]{}) );
   		sGtin = srv.cvtToJavaScriptArray( vGtin.toArray(new String[]{}) );
   		sDesc = srv.cvtToJavaScriptArray( vDesc.toArray(new String[]{}) );
   		sVenSty = srv.cvtToJavaScriptArray( vVenSty.toArray(new String[]{}) );
   		sClrNm = srv.cvtToJavaScriptArray( vClrNm.toArray(new String[]{}) );
   		sSizNm = srv.cvtToJavaScriptArray( vSizNm.toArray(new String[]{}) );
   		sVenNm = srv.cvtToJavaScriptArray( vVenNm.toArray(new String[]{}) );
   		sRtnReg = srv.cvtToJavaScriptArray( vRtnReg.toArray(new String[]{}) );
   		sRtnTran = srv.cvtToJavaScriptArray( vRtnTran.toArray(new String[]{}) );
   		sSlsReg = srv.cvtToJavaScriptArray( vSlsReg.toArray(new String[]{}) );
   		sSlsTran = srv.cvtToJavaScriptArray( vSlsTran.toArray(new String[]{}) );
   }
   else if(!sDayFr.equals("NONE"))
   {
	  sPrepStmt = "select 70 as r_str,s.eist as s_str,r.edai as r_dai" 
       + ", r.ereg as r_reg, r.eent as r_tran,s.edai as s_dai,r.eret as r_ret" 
	   + ",r.ecst as r_cost,r.eqty as r_qty" 
       + ",case when s.etos='080' then 'Y' else ' ' end as emppurch" 
	   + ",s.edoc as s_doc,r.edoc as r_doc, s.ecsh as s_cash, s.eemp as s_emp" 
       + ", s.ereg as s_reg, s.eent as s_tran, r.ecsh as r_cash, isku, iGtin," 
	   + " ides, ivst, clrn, snam, vnam" 
       + " from rci.ECSRLRT" 
	   + " inner join rci.MoOrdh on ohsite = rssite and ohord=rsord" 
       + " inner join rci.RciSacm r on r.eent=rsord and rssku=r.ESPC1# and r.eqty < 0" 
	   + " inner join rci.RciSacm s on s.eent=rsord and rssku=s.ESPC1# and s.eqty  > 0" 
       + " left join iptsfil.ipithdr on isku = r.ESPC1#" 
	   + " left join iptsfil.ipColor on cclr=iclr" 
       + " left join iptsfil.ipSizes on ssiz=isiz" 
	   + " left join iptsfil.ipMrVen on vven=iven"
	   + " where ((r.etos ='001' or r.etos ='000') or (r.etos ='01' or r.etos ='00'))" 
	   	 + " and RSIPRTNDT >= '" + sFrDate + "'" 
	     + " and RSIPRTNDT <= '" + sToDate + "'"
	     + " and r.eqty < 0"
	   	 + " and  Days(RSIPRTNDT) - Days(ohordate) >=" + sDayFr
	   	 + " and  Days(RSIPRTNDT) - Days(ohordate) <=" + sDayTo
	   	 + " order by RSIPRTNDT, r.edai, r.ereg, r.eent, r_cash"
	   	;

	   System.out.println(sPrepStmt);
	   runsql = new RunSQLStmt();
	   runsql.setPrepStmt(sPrepStmt);
	   runsql.runQuery();
	   
	   Vector<String> vRtnStr = new Vector<String>();
	   Vector<String> vSlsStr = new Vector<String>();
	   Vector<String> vRtnDt = new Vector<String>();
	   Vector<String> vSlsDt = new Vector<String>();
	   Vector<String> vRtnRet = new Vector<String>();
	   Vector<String> vRtnCost = new Vector<String>();
	   Vector<String> vRtnQty = new Vector<String>();
	   Vector<String> vEmpPurch = new Vector<String>();
	   Vector<String> vSlsDoc = new Vector<String>();
	   Vector<String> vRtnDoc = new Vector<String>();
	   Vector<String> vSlsCash = new Vector<String>();
	   Vector<String> vSlsEmp = new Vector<String>();
	   Vector<String> vRtnCash = new Vector<String>();
	   Vector<String> vSku = new Vector<String>();
	   Vector<String> vGtin = new Vector<String>();
	   Vector<String> vDesc = new Vector<String>();
	   Vector<String> vVenSty = new Vector<String>();
	   Vector<String> vClrNm = new Vector<String>();
	   Vector<String> vSizNm = new Vector<String>();
	   Vector<String> vVenNm = new Vector<String>();   
	   
	   Vector<String> vRtnReg = new Vector<String>();
	   Vector<String> vRtnTran = new Vector<String>();
	   Vector<String> vSlsReg = new Vector<String>();
	   Vector<String> vSlsTran = new Vector<String>();
	   		
	   while(runsql.readNextRecord())
	   {
	   		vRtnStr.add(runsql.getData("r_str").trim());
	   		vSlsStr.add(runsql.getData("s_str").trim());
	   		vRtnDt.add(runsql.getData("r_dai").trim());
	   		vSlsDt.add(runsql.getData("s_dai").trim());
	   		vRtnRet.add(runsql.getData("r_ret").trim());
	   		vRtnCost.add(runsql.getData("r_cost").trim());
	   		vRtnQty.add(runsql.getData("r_qty").trim());
	   		vEmpPurch.add(runsql.getData("emppurch"));
	   		vSlsDoc.add(runsql.getData("s_doc").trim());
	   		vRtnDoc.add(runsql.getData("r_doc").trim());
	   		vSlsCash.add(runsql.getData("s_cash").trim());
	   		vSlsEmp.add(runsql.getData("s_emp").trim());
	   		vRtnCash.add(runsql.getData("r_cash").trim());
	   		vSku.add(runsql.getData("isku").trim());
	   		vGtin.add(runsql.getData("igtin").trim());
	   		
	   		String s = runsql.getData("ides").trim();
	   		s = s.replaceAll("'", "%27");
	   		vDesc.add(s);
	   		
	   		s = runsql.getData("ivst").trim();
	   		s = s.replaceAll("'", "%27");
	   		vVenSty.add(s);  
	   		
	   		s = runsql.getData("clrn").trim();
	   		s = s.replaceAll("'", "%27");
	   		vClrNm.add(s);  
	   		
	   		s = runsql.getData("snam").trim();
	   		s = s.replaceAll("'", "%27");
	   		vSizNm.add(s);  
	   		
	   		s = runsql.getData("vnam").trim();
	   		s = s.replaceAll("'", "%27");
	   		vVenNm.add(s);
	   		
	   		vRtnReg.add(runsql.getData("r_reg").trim());
	   		vRtnTran.add(runsql.getData("r_tran").trim());
	   		vSlsReg.add(runsql.getData("s_reg").trim());
	   		vSlsTran.add(runsql.getData("s_tran").trim());
	   }
	   		
	   		CallAs400SrvPgmSup srv = new CallAs400SrvPgmSup();
	   		sRtnStr = srv.cvtToJavaScriptArray( vRtnStr.toArray(new String[]{}) );
	   		sSlsStr = srv.cvtToJavaScriptArray( vSlsStr.toArray(new String[]{}) );
	   		sRtnDt = srv.cvtToJavaScriptArray( vRtnDt.toArray(new String[]{}) );
	   		sSlsDt = srv.cvtToJavaScriptArray( vSlsDt.toArray(new String[]{}) );
	   		sRtnRet = srv.cvtToJavaScriptArray( vRtnRet.toArray(new String[]{}) );
	   		sRtnCost = srv.cvtToJavaScriptArray( vRtnCost.toArray(new String[]{}) );
	   		sRtnQty = srv.cvtToJavaScriptArray( vRtnQty.toArray(new String[]{}) );
	   		sEmpPurch = srv.cvtToJavaScriptArray( vEmpPurch.toArray(new String[]{}) );
	   		sSlsDoc = srv.cvtToJavaScriptArray( vSlsDoc.toArray(new String[]{}) );
	   		sRtnDoc = srv.cvtToJavaScriptArray( vRtnDoc.toArray(new String[]{}) );
	   		sSlsCash = srv.cvtToJavaScriptArray( vSlsCash.toArray(new String[]{}) );
	   		sSlsEmp = srv.cvtToJavaScriptArray( vSlsEmp.toArray(new String[]{}) );
	   		sRtnCash = srv.cvtToJavaScriptArray( vRtnCash.toArray(new String[]{}) );
	   		sSku = srv.cvtToJavaScriptArray( vSku.toArray(new String[]{}) );
	   		sGtin = srv.cvtToJavaScriptArray( vGtin.toArray(new String[]{}) );
	   		sDesc = srv.cvtToJavaScriptArray( vDesc.toArray(new String[]{}) );
	   		sVenSty = srv.cvtToJavaScriptArray( vVenSty.toArray(new String[]{}) );
	   		sClrNm = srv.cvtToJavaScriptArray( vClrNm.toArray(new String[]{}) );
	   		sSizNm = srv.cvtToJavaScriptArray( vSizNm.toArray(new String[]{}) );
	   		sVenNm = srv.cvtToJavaScriptArray( vVenNm.toArray(new String[]{}) );
	   		sRtnReg = srv.cvtToJavaScriptArray( vRtnReg.toArray(new String[]{}) );
	   		sRtnTran = srv.cvtToJavaScriptArray( vRtnTran.toArray(new String[]{}) );
	   		sSlsReg = srv.cvtToJavaScriptArray( vSlsReg.toArray(new String[]{}) );
	   		sSlsTran = srv.cvtToJavaScriptArray( vSlsTran.toArray(new String[]{}) );
	   }
   else if(sDayFr.equals("NONE"))
   {
     	sPrepStmt = "select r.eist as r_str,0 as s_str,r.edai as r_dai" 
	 	+ ", r.ereg as r_reg, r.eent as r_tran"	   
     	+ ",' ' as s_dai,r.eret as r_ret,r.ecst as r_cost,r.eqty as r_qty" 
     	+ ", ' ' as emppurch" 
     	+ ",0 as s_doc,r.edoc as r_doc, 0 as s_cash, 0 as s_emp"
     	+ ", 0 as s_reg, 0 as s_tran "
     	+ ", r.ecsh as r_cash, isku, iGtin, ides, ivst, clrn, snam, vnam" 
     	+ " from rci.rcisacm r" 
     	+ " left join iptsfil.ipithdr on isku = r.esku *10 + r.echk" 
     	+ " left join iptsfil.ipColor on cclr=iclr"
     	+ " left join iptsfil.ipSizes on ssiz=isiz"
     	+ " left join iptsfil.ipMrVen on vven=iven"
     	+ " where  r.ertn='Y' and (r.edoc=0 or r.erdoc = 0)" 
   	 	+ " and r.edai >= '" + sFrDate + "'" 
     	+ " and r.edai <= '" + sToDate + "'"
   	 	+ " and r.eist=" + sStr 
   	 	+ " order by r.edai, r.ereg, r.eent, r_cash"
   	;

   System.out.println("\n" + sPrepStmt);
   runsql = new RunSQLStmt();
   runsql.setPrepStmt(sPrepStmt);
   runsql.runQuery();
   
   Vector<String> vRtnStr = new Vector<String>();
   Vector<String> vSlsStr = new Vector<String>();
   Vector<String> vRtnDt = new Vector<String>();
   Vector<String> vSlsDt = new Vector<String>();
   Vector<String> vRtnRet = new Vector<String>();
   Vector<String> vRtnCost = new Vector<String>();
   Vector<String> vRtnQty = new Vector<String>();
   Vector<String> vEmpPurch = new Vector<String>();
   Vector<String> vSlsDoc = new Vector<String>();
   Vector<String> vRtnDoc = new Vector<String>();
   Vector<String> vSlsCash = new Vector<String>();
   Vector<String> vSlsEmp = new Vector<String>();
   Vector<String> vRtnCash = new Vector<String>();
   Vector<String> vSku = new Vector<String>();
   Vector<String> vGtin = new Vector<String>();
   Vector<String> vDesc = new Vector<String>();
   Vector<String> vVenSty = new Vector<String>();
   Vector<String> vClrNm = new Vector<String>();
   Vector<String> vSizNm = new Vector<String>();
   Vector<String> vVenNm = new Vector<String>();   
   
   Vector<String> vRtnReg = new Vector<String>();
   Vector<String> vRtnTran = new Vector<String>();
   Vector<String> vSlsReg = new Vector<String>();
   Vector<String> vSlsTran = new Vector<String>();
   		
   while(runsql.readNextRecord())
   {
   		vRtnStr.add(runsql.getData("r_str").trim());
   		vSlsStr.add(runsql.getData("s_str").trim());
   		vRtnDt.add(runsql.getData("r_dai").trim());
   		vSlsDt.add(runsql.getData("s_dai").trim());
   		vRtnRet.add(runsql.getData("r_ret").trim());
   		vRtnCost.add(runsql.getData("r_cost").trim());
   		vRtnQty.add(runsql.getData("r_qty").trim());
   		vEmpPurch.add(runsql.getData("emppurch"));
   		vSlsDoc.add(runsql.getData("s_doc").trim());
   		vRtnDoc.add(runsql.getData("r_doc").trim());
   		vSlsCash.add(runsql.getData("s_cash").trim());
   		vSlsEmp.add(runsql.getData("s_emp").trim());
   		vRtnCash.add(runsql.getData("r_cash").trim());
   		vSku.add(runsql.getData("isku").trim());
   		vGtin.add(runsql.getData("igtin").trim());
   		
   		String s = runsql.getData("ides").trim();
   		s = s.replaceAll("'", "%27");
   		vDesc.add(s);
   		
   		s = runsql.getData("ivst").trim();
   		s = s.replaceAll("'", "%27");
   		vVenSty.add(s);  
   		
   		s = runsql.getData("clrn").trim();
   		s = s.replaceAll("'", "%27");
   		vClrNm.add(s);  
   		
   		s = runsql.getData("snam").trim();
   		s = s.replaceAll("'", "%27");
   		vSizNm.add(s);  
   		
   		s = runsql.getData("vnam").trim();
   		s = s.replaceAll("'", "%27");
   		vVenNm.add(s);
   		
   		vRtnReg.add(runsql.getData("r_reg").trim());
   		vRtnTran.add(runsql.getData("r_tran").trim());
   		vSlsReg.add(runsql.getData("s_reg").trim());
   		vSlsTran.add(runsql.getData("s_tran").trim());
   }
   		
   		CallAs400SrvPgmSup srv = new CallAs400SrvPgmSup();
   		sRtnStr = srv.cvtToJavaScriptArray( vRtnStr.toArray(new String[]{}) );
   		sSlsStr = srv.cvtToJavaScriptArray( vSlsStr.toArray(new String[]{}) );
   		sRtnDt = srv.cvtToJavaScriptArray( vRtnDt.toArray(new String[]{}) );
   		sSlsDt = srv.cvtToJavaScriptArray( vSlsDt.toArray(new String[]{}) );
   		sRtnRet = srv.cvtToJavaScriptArray( vRtnRet.toArray(new String[]{}) );
   		sRtnCost = srv.cvtToJavaScriptArray( vRtnCost.toArray(new String[]{}) );
   		sRtnQty = srv.cvtToJavaScriptArray( vRtnQty.toArray(new String[]{}) );
   		sEmpPurch = srv.cvtToJavaScriptArray( vEmpPurch.toArray(new String[]{}) );
   		sSlsDoc = srv.cvtToJavaScriptArray( vSlsDoc.toArray(new String[]{}) );
   		sRtnDoc = srv.cvtToJavaScriptArray( vRtnDoc.toArray(new String[]{}) );
   		sSlsCash = srv.cvtToJavaScriptArray( vSlsCash.toArray(new String[]{}) );
   		sSlsEmp = srv.cvtToJavaScriptArray( vSlsEmp.toArray(new String[]{}) );
   		sRtnCash = srv.cvtToJavaScriptArray( vRtnCash.toArray(new String[]{}) );
   		sSku = srv.cvtToJavaScriptArray( vSku.toArray(new String[]{}) );
   		sGtin = srv.cvtToJavaScriptArray( vGtin.toArray(new String[]{}) );
   		sDesc = srv.cvtToJavaScriptArray( vDesc.toArray(new String[]{}) );
   		sVenSty = srv.cvtToJavaScriptArray( vVenSty.toArray(new String[]{}) );
   		sClrNm = srv.cvtToJavaScriptArray( vClrNm.toArray(new String[]{}) );
   		sSizNm = srv.cvtToJavaScriptArray( vSizNm.toArray(new String[]{}) );
   		sVenNm = srv.cvtToJavaScriptArray( vVenNm.toArray(new String[]{}) );
   		sRtnReg = srv.cvtToJavaScriptArray( vRtnReg.toArray(new String[]{}) );
   		sRtnTran = srv.cvtToJavaScriptArray( vRtnTran.toArray(new String[]{}) );
   		sSlsReg = srv.cvtToJavaScriptArray( vSlsReg.toArray(new String[]{}) );
   		sSlsTran = srv.cvtToJavaScriptArray( vSlsTran.toArray(new String[]{}) );
   }
   	    runsql.disconnect();
   	    runsql = null;   		
  
   
%>

<script name="javascript1.2">
var selStr = "<%=sStr%>";
var dayFr = "<%=sDayFr%>";
var dayTo = "<%=sDayTo%>";
var frDate = "<%=sFrDate%>";
var toDate = "<%=sToDate%>";		

var rtnStr = [<%=sRtnStr%>];
var slsStr = [<%=sSlsStr%>];
var rtnDt = [<%=sRtnDt%>];
var slsDt = [<%=sSlsDt%>];
var rtnRet = [<%=sRtnRet%>];
var rtnCost = [<%=sRtnCost%>];
var rtnQty = [<%=sRtnQty%>];
var empPurch = [<%=sEmpPurch%>];
var slsDoc = [<%=sSlsDoc%>];
var rtnDoc = [<%=sRtnDoc%>];
var slsCash = [<%=sSlsCash%>];
var slsEmp = [<%=sSlsEmp%>];
var rtnCash = [<%=sRtnCash%>];
var sku = [<%=sSku%>];
var gtin = [<%=sGtin%>];
var desc = [<%=sDesc%>];
var venSty = [<%=sVenSty%>];
var clrNm = [<%=sClrNm%>];
var sizNm = [<%=sSizNm%>];
var venNm = [<%=sVenNm%>];
var rtnReg = [<%=sRtnReg%>];
var rtnTran = [<%=sRtnTran%>];
var slsReg = [<%=sSlsReg%>];
var slsTran = [<%=sSlsTran%>];

parent.showRtnDtl(selStr, dayFr, dayTo, frDate, toDate
   , rtnStr, slsStr, rtnDt, slsDt, rtnRet, rtnCost, rtnQty, empPurch
   , slsDoc, rtnDoc, slsCash, slsEmp, rtnCash, sku, gtin, desc
   , venSty, clrNm, sizNm, venNm, rtnReg, rtnTran, slsReg, slsTran ); 
</script>

<%}%>








