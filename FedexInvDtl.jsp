<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.text.*, java.util.*,java.text.SimpleDateFormat
, rciutility.CallAs400SrvPgmSup, rciutility.ConnToCounterPoint"%>
<%
   	String sInv = request.getParameter("Inv");
	String sInvDt = request.getParameter("InvDt");
	String sSelPon = request.getParameter("Pon");
	String sAction = request.getParameter("Action");
   
   	SimpleDateFormat sdfMdy = new SimpleDateFormat("MM/dd/yyyy");
   	SimpleDateFormat sdfIso = new SimpleDateFormat("yyyy-MM-dd");
   	
  	String sIsoInvDt = sdfIso.format(sdfMdy.parse(sInvDt)); 
  	
  	
  	RunSQLStmt runsql = new RunSQLStmt();
  	String sPon = new String();
    String sCost = new String();
    String sLineHaul = new String();
    String sTotal = new String();
    String sFuel = new String();
    String sGain = new String();
    String sPayAmt = new String();
    
    String sTrcId = new String();    
    String sSrvcTy = new String();
    String sSrvcCd = new String();
    String sShpDt = new String();
    String sGfrt = new String();
    String sDisc = new String();
    String sNet = new String();
    String sCurrNet = new String();
    String sBench = new String();
    String sAddHand = new String();
    String sAddrCorr = new String();
    String sCODFees = new String();
    String sDclAcc = new String();
    String sDelAreaSurch = new String();
    String sResidDel = new String();
    String sSatDel = new String();
    String sOthAcc = new String();
    String sGroundDisc1 = new String();
    String sGroundDisc2 = new String();
    String sEcOrd = new String();
    String sEcOrdTot = new String();
    String sEcOrdShipSub = new String();
    String sEcOrdHandle = new String();
    
  	if(sAction.equals("POList"))
  	{
    	String sStmt = "select FHPON,FHHCOST,FHLINHL,FHTOTACC,FHFULE,FHGAIN,FHPAYAMT" 
       	+ " from rci.FCHDR"
       	+ " where fhinv=" + sInv 
       	+ " and FhInvDt='" + sIsoInvDt + "'"
       	+ " order by FHPON"
    	;          
    	//System.out.println("\n" + sStmt);
          
    	runsql.setPrepStmt(sStmt);
    	ResultSet rs = runsql.runQuery();
          		
    	Vector<String> vPon = new Vector<String>();
    	Vector<String> vCost = new Vector<String>();
    	Vector<String> vLineHaul = new Vector<String>();
    	Vector<String> vTotal = new Vector<String>();
   	 	Vector<String> vFuel = new Vector<String>();
    	Vector<String> vGain = new Vector<String>();
    	Vector<String> vPayAmt = new Vector<String>();
    	    
    	while(runsql.readNextRecord())
    	{        		  
    		vPon.add(runsql.getData("FHPON").trim());
    		vCost.add(runsql.getData("FHHCOST").trim());
    		vLineHaul.add(runsql.getData("FHLINHL").trim());
    		vTotal.add(runsql.getData("FHTOTACC").trim());
    		vFuel.add(runsql.getData("FHFULE").trim());
    		vGain.add(runsql.getData("FHGAIN").trim());
    		vPayAmt.add(runsql.getData("FHPAYAMT").trim());
    	} 
    	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
    
    	sPon = srvpgm.cvtToJavaScriptArray(vPon.toArray( new String[vPon.size()]));
    	sCost = srvpgm.cvtToJavaScriptArray(vCost.toArray( new String[vPon.size()]));
    	sLineHaul = srvpgm.cvtToJavaScriptArray(vLineHaul.toArray( new String[vPon.size()]));
    	sTotal = srvpgm.cvtToJavaScriptArray(vTotal.toArray( new String[vPon.size()]));
    	sFuel = srvpgm.cvtToJavaScriptArray(vFuel.toArray( new String[vPon.size()]));
    	sGain = srvpgm.cvtToJavaScriptArray(vGain.toArray( new String[vPon.size()]));
    	sPayAmt = srvpgm.cvtToJavaScriptArray(vPayAmt.toArray( new String[vPon.size()]));
  	}
  	if(sAction.equals("PODtl"))
  	{
    	String sStmt = "with fedexf as (" 
    	+ "select FDSEQ,FDTRCID,FDSRVTY,FDSRVCD" 
  		+ ",char(FDSHPDT, usa) as FdShpDt,FDGFRT,FDDISC,FDNET,FDCNET,FDBENCH "
  		+ ",FDGAIN,FDFUEL,FDAHND,FDACORR,FDCODF,FDDVACC,FDDASCH,FDRDLV" 
  		+ ",FDSDLV,FDOTHAC,FDGRND1,FDGRND2,FDTOT"
  		+ ",(select ftord from rci.mofdxpti where fdtrcid=fttrcid) as ec_ord"
       	+ " from rci.FCDtl"
       	+ " where fdinv=" + sInv 
       	+ " and FdInvDt='" + sIsoInvDt + "'"
       	+ " and fdpon=" + sSelPon 
       	+ ")" 
       	+ " select FDSEQ,FDTRCID,FDSRVTY,FDSRVCD" 
  		+ ",FDSHPDT,FDGFRT,FDDISC,FDNET,FDCNET,FDBENCH "
  		+ ",FDGAIN,FDFUEL,FDAHND,FDACORR,FDCODF,FDDVACC,FDDASCH,FDRDLV" 
  		+ ",FDSDLV,FDOTHAC,FDGRND1,FDGRND2,FDTOT"
       	+ ",case when ec_ord is not null then ec_ord else 0 end as ec_ord" 
       	+ ",case when ohtot is not null then ohtot else 0 end as ohtot" 
       	+ ",case when OHSHPST is not null then OHSHPST else 0 end as OHSHPST"
       	+ ",case when OHHNDTOT is not null then OHHNDTOT else 0 end as OHHNDTOT"
       	+ " from fedexf"
       	+ " left join rci.MOOrdH on ohord=ec_ord"
       	+ " order by FDTRCID, FdSeq"
    	;          
    	System.out.println("\n" + sStmt);
          
    	runsql.setPrepStmt(sStmt);
    	ResultSet rs = runsql.runQuery();
          		
    	int iLine = 0;
    	Vector<String> vTrcId = new Vector<String>();
	    Vector<String> vSrvcTy = new Vector<String>();
	    Vector<String> vSrvcCd = new Vector<String>();
	    Vector<String> vShpDt = new Vector<String>();
	    Vector<String> vGfrt = new Vector<String>();
	    Vector<String> vDisc = new Vector<String>();
	    Vector<String> vNet = new Vector<String>();
	    Vector<String> vCurrNet = new Vector<String>();
	    Vector<String> vBench = new Vector<String>();
	    Vector<String> vGain = new Vector<String>();
	    Vector<String> vFuel = new Vector<String>();
	    Vector<String> vAddHand = new Vector<String>();
	    Vector<String> vAddrCorr = new Vector<String>();
	    Vector<String> vCODFees = new Vector<String>();
	    Vector<String> vDclAcc = new Vector<String>();
	    Vector<String> vDelAreaSurch = new Vector<String>();
	    Vector<String> vResidDel = new Vector<String>();
	    Vector<String> vSatDel = new Vector<String>();
	    Vector<String> vOthAcc = new Vector<String>();
	    Vector<String> vGroundDisc1 = new Vector<String>();
	    Vector<String> vGroundDisc2 = new Vector<String>();
	    Vector<String> vTotal = new Vector<String>();
	    Vector<String> vEcOrd = new Vector<String>();
	    Vector<String> vEcOrdTot = new Vector<String>();
	    Vector<String> vEcOrdShipSub = new Vector<String>();
	    Vector<String> vEcOrdHandle = new Vector<String>();
	    
    	while(runsql.readNextRecord())
    	{        		 
    		vTrcId.add(runsql.getData("FDTRCID").trim());
    		vSrvcTy.add(runsql.getData("FDSRVTY").trim());
    		vSrvcCd.add(runsql.getData("FDSRVCD").trim());
    		vShpDt.add(runsql.getData("FDSHPDT").trim());
    		vGfrt.add(runsql.getData("FDGFRT").trim());
    		vDisc.add(runsql.getData("FDDISC").trim());
    		vNet.add(runsql.getData("FdNet").trim());
    		vCurrNet.add(runsql.getData("FdCNet").trim());
    		vBench.add(runsql.getData("FdBench").trim());
    		vGain.add(runsql.getData("FdGain").trim());
    		vFuel.add(runsql.getData("FdFuel").trim());
    		vAddHand.add(runsql.getData("FdAhnd").trim());
    		vAddrCorr.add(runsql.getData("FdACorr").trim());
    		vCODFees.add(runsql.getData("FdCodF").trim());
    		vDclAcc.add(runsql.getData("FdDvAcc").trim());
    		vDelAreaSurch.add(runsql.getData("FDDASCH").trim());
    		vResidDel.add(runsql.getData("FDRDLV").trim());
    		vSatDel.add(runsql.getData("FDSDLV").trim());
    		vOthAcc.add(runsql.getData("FDOTHAC").trim());
    		vGroundDisc1.add(runsql.getData("FDGRND1").trim());
    		vGroundDisc2.add(runsql.getData("FDGRND2").trim());
    		vTotal.add(runsql.getData("FDTOT").trim()); 
    		vEcOrd.add(runsql.getData("ec_ord").trim());
    		vEcOrdTot.add(runsql.getData("ohtot").trim());
    		vEcOrdShipSub.add(runsql.getData("OHSHPST").trim());
    		vEcOrdHandle.add(runsql.getData("OHHNDTOT").trim());
    		
    	} 
    	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
    
    	sTrcId = srvpgm.cvtToJavaScriptArray(vTrcId.toArray( new String[vTrcId.size()]));
    	sSrvcTy = srvpgm.cvtToJavaScriptArray(vSrvcTy.toArray( new String[vSrvcTy.size()]));
    	sSrvcCd = srvpgm.cvtToJavaScriptArray(vSrvcCd.toArray( new String[vSrvcCd.size()]));
    	sShpDt = srvpgm.cvtToJavaScriptArray(vShpDt.toArray( new String[vShpDt.size()]));
    	sGfrt = srvpgm.cvtToJavaScriptArray(vGfrt.toArray( new String[vGfrt.size()]));
    	sDisc = srvpgm.cvtToJavaScriptArray(vDisc.toArray( new String[vDisc.size()]));
    	sNet = srvpgm.cvtToJavaScriptArray(vNet.toArray( new String[vNet.size()]));
    	sCurrNet = srvpgm.cvtToJavaScriptArray(vCurrNet.toArray( new String[vCurrNet.size()]));
    	sBench = srvpgm.cvtToJavaScriptArray(vBench.toArray( new String[vBench.size()]));
    	sGain = srvpgm.cvtToJavaScriptArray(vGain.toArray( new String[vGain.size()]));
    	sFuel = srvpgm.cvtToJavaScriptArray(vFuel.toArray( new String[vFuel.size()]));
    	sAddHand = srvpgm.cvtToJavaScriptArray(vAddHand.toArray( new String[vAddHand.size()]));
    	sAddrCorr = srvpgm.cvtToJavaScriptArray(vAddrCorr.toArray( new String[vAddrCorr.size()]));
    	sCODFees = srvpgm.cvtToJavaScriptArray(vCODFees.toArray( new String[vCODFees.size()]));
    	sDclAcc = srvpgm.cvtToJavaScriptArray(vDclAcc.toArray( new String[vDclAcc.size()]));
    	sDelAreaSurch = srvpgm.cvtToJavaScriptArray(vDelAreaSurch.toArray( new String[vDelAreaSurch.size()]));
    	sResidDel = srvpgm.cvtToJavaScriptArray(vResidDel.toArray( new String[vResidDel.size()]));
    	sSatDel = srvpgm.cvtToJavaScriptArray(vSatDel.toArray( new String[vSatDel.size()]));
    	sOthAcc = srvpgm.cvtToJavaScriptArray(vOthAcc.toArray( new String[vOthAcc.size()]));
    	sGroundDisc1 = srvpgm.cvtToJavaScriptArray(vGroundDisc1.toArray( new String[vGroundDisc1.size()]));
    	sGroundDisc2 = srvpgm.cvtToJavaScriptArray(vGroundDisc2.toArray( new String[vGroundDisc2.size()]));
    	sTotal = srvpgm.cvtToJavaScriptArray(vTotal.toArray( new String[vTotal.size()]));
    	sEcOrd = srvpgm.cvtToJavaScriptArray(vEcOrd.toArray( new String[vEcOrd.size()]));
    	sEcOrdTot = srvpgm.cvtToJavaScriptArray(vEcOrdTot.toArray( new String[vEcOrdTot.size()]));
    	sEcOrdShipSub = srvpgm.cvtToJavaScriptArray(vEcOrdShipSub.toArray( new String[vEcOrdShipSub.size()]));
    	sEcOrdHandle = srvpgm.cvtToJavaScriptArray(vEcOrdHandle.toArray( new String[vEcOrdHandle.size()]));
  	}
  	
%>
 
<script>
var inv = "<%=sInv%>";
var invDt = "<%=sInvDt%>";
<%if(sAction.equals("POList")){%>
	var pon = [<%=sPon%>];
	var cost = [<%=sCost%>];
	var lineh = [<%=sPon%>];
	var total = [<%=sLineHaul%>];
	var fuel = [<%=sFuel%>];
	var gain = [<%=sGain%>];
	var payAmt = [<%=sPayAmt%>];

 
	parent.showPOList(inv, invDt, pon, cost, lineh, total, fuel, gain, payAmt); 
<%}
else if(sAction.equals("PODtl")){ %>
	var pon = "<%=sSelPon%>";
	var trcId = [<%=sTrcId%>];
	var srvcTy = [<%=sSrvcTy%>];
	var srvcCd = [<%=sSrvcCd%>];
	var shpDt = [<%=sShpDt%>];
	var gfrt = [<%=sGfrt%>];
	var disc = [<%=sDisc%>];
	var net = [<%=sNet%>];
	var currNet = [<%=sCurrNet%>];
	var bench = [<%=sBench%>];
	var gain = [<%=sGain%>];
	var fuel = [<%=sFuel%>];
	var addHand = [<%=sAddHand%>];
	var addrCorr = [<%=sAddrCorr%>];
	var codFees = [<%=sCODFees%>];
	var dclAcc = [<%=sDclAcc%>];
	var delAreaSurch = [<%=sDelAreaSurch%>];
	var residDel = [<%=sResidDel%>];
	var satDel = [<%=sSatDel%>];
	var othAcc = [<%=sOthAcc%>];
	var groundDisc1 = [<%=sGroundDisc1%>];
	var groundDisc2 = [<%=sGroundDisc2%>];
	var total = [<%=sTotal%>];
	var ecOrd = [<%=sEcOrd%>];
	var ecOrdTot = [<%=sEcOrdTot%>];
	var ecOrdShipSub = [<%=sEcOrdShipSub%>];
	var ecOrdHandle = [<%=sEcOrdHandle%>];
	
	parent.showPODtl(inv, invDt, pon 
	  , trcId,srvcTy,srvcCd,srvcTy,srvcCd, shpDt, gfrt, disc, net, currNet
	  , bench, gain, fuel, addHand, addrCorr, codFees, dclAcc, delAreaSurch
	  , residDel, satDel, othAcc, groundDisc1, groundDisc2, total
	  , ecOrd, ecOrdTot, ecOrdShipSub, ecOrdHandle); 
<%}%>

</script>
 