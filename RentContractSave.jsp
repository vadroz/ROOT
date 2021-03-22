<%@ page import="rental.RentContractSave, rental.RentTagAvlQuickLst,java.util.*, java.text.*"%>
<%
   String sFrDate = request.getParameter("FrDate");
   String sToDate = request.getParameter("ToDate");

   String sCont = request.getParameter("Cont");
   String sCust = request.getParameter("Cust");
   String sSts = request.getParameter("Sts");
   String sStr = request.getParameter("Str");

   String sFName = request.getParameter("FName");
   String sMInit = request.getParameter("MInit");
   String sLName = request.getParameter("LName");
   String sAddr1 = request.getParameter("Addr1");
   String sAddr2 = request.getParameter("Addr2");
   String sCity = request.getParameter("City");
   String sState = request.getParameter("State");
   String sZip = request.getParameter("Zip");
   String sEMail = request.getParameter("EMail");
   String sHPhone = request.getParameter("HPhone");
   String sCPhone = request.getParameter("CPhone");
   String sBDate = request.getParameter("BDate");
   String sGroup = request.getParameter("Group");
   String sWeight = request.getParameter("Weight");
   String sHeightFt = request.getParameter("HeightFt");
   String sHeightIn = request.getParameter("HeightIn");
   String sShoeSiz = request.getParameter("ShoeSiz");
   String sSkiType = request.getParameter("SkiType");
   String sStance = request.getParameter("Stance");
   String sSrlNum = request.getParameter("SrlNm");
   String sInvId = request.getParameter("InvId");
   String sReason = request.getParameter("Reason");
   String sMondoSiz = request.getParameter("MondoSiz");
   String sAngleLeft = request.getParameter("AngleLeft");
   String sAngleRight = request.getParameter("AngleRight");
   String sDmgWvr = request.getParameter("DmgWvr");
   String sHalfDay = request.getParameter("HalfDay");
   String sOnline = request.getParameter("Online");
   String sParent = request.getParameter("Parent");

   String sCls = request.getParameter("Cls");
   String sVen = request.getParameter("Ven");
   String sSty = request.getParameter("Sty");
   String sClr = request.getParameter("Clr");
   String sSiz = request.getParameter("Siz");

   String sBootLn = request.getParameter("BootLn");
   String sLeftToe = request.getParameter("LeftToe");
   String sRightToe = request.getParameter("RightToe");
   String sLeftHeal = request.getParameter("LeftHeal");
   String sRightHeal = request.getParameter("RightHeal");

   String sCommt = request.getParameter("Commt");
   String sUserNm = request.getParameter("UserNm");
   String sPayReq = request.getParameter("PayReq");
   String sAction = request.getParameter("Action");
   String sUnrel = request.getParameter("Unrel");

   String sPurchYr = request.getParameter("PurchYr");
   String sEquipTy = request.getParameter("EquipTy");
   String sNumSn = request.getParameter("NumSn");
   String sGrade = request.getParameter("Grade");
   String sTech = request.getParameter("Tech");
   
   String sBrand = request.getParameter("Brand");
   String sModel = request.getParameter("Model");
   String sAddDt = request.getParameter("AddDt");
   
   String sGrp = request.getParameter("Grp");
   String sMfgSn = request.getParameter("MfgSn");
   String sLife = request.getParameter("Life");
   String sRentTy = request.getParameter("RentTy");
   String sTrade = request.getParameter("Trade");
   String sOldSrlNum = request.getParameter("OldSrlNum");
   String sIntl = request.getParameter("Intl");
   String sPickAmPm = request.getParameter("PickAmPm");
   String sDropAmPm = request.getParameter("DropAmPm");
   

   if (sCont == null){ sCont = " "; }
   if (sCust == null){ sCust = " "; }
   if (sSts == null) { sSts = " "; }
   if (sSkiType == null) { sSkiType = " "; }
   if (sStance == null) { sStance = " "; }
   if (sUserNm == null) { sUserNm = " "; }
   if (sPayReq == null) { sPayReq = " "; }
   if (sUnrel == null) { sUnrel = " "; }
   if (sDmgWvr == null) { sDmgWvr = "SAME"; }
   if (sHalfDay == null) { sHalfDay = " "; }
   if (sOnline == null) { sOnline = " "; }
   
   if (sPickAmPm == null) { sPickAmPm = " "; }
   if (sDropAmPm == null) { sDropAmPm = " "; }

   if (sPurchYr == null) { sPurchYr = " "; }
   if (sEquipTy == null) { sEquipTy = " "; }
   if (sShoeSiz == null) { sShoeSiz = " "; }
   if (sNumSn == null){ sNumSn = "1"; }

   if (sIntl == null){ sIntl = " "; }
   if (sParent == null){ sParent = " "; }
   
   String sUser = " ";
   if(session.getAttribute("USER") != null)
   {
   		sUser = session.getAttribute("USER").toString();
   }
   else if(sAction.equals("ADD_CUST_ONLY") || sAction.equals("UPD_CUST_ONLY"))
   {
	   sUser = "CUST";
   }
    
   RentContractSave rentsave = new RentContractSave();

   int iNumOfConf = 0;
   String sConfCont = null;
   String sConfSts = null;
   String sConfInvId = null;
   String sConfSrlNum = null;
   String sConfDesc = null;
   String sConfSizeNm = null;
   String sConfCust = null;
   String sConfFName = null;
   String sConfMInit = null;
   String sConfLName = null;

   String sRtnInvId = null;
   String sRtnSrlNum = null;
   String sRtnCls = null;
   String sRtnClsNm = null;
   String sError = "";
   String sChgSts = "N";
   
   //==========================================================================
   // Open new Contract and add primary customer
   //==========================================================================
   if(sAction.equals("OPEN_CONT"))
   {
      //open new contract
      rentsave.saveContract(sCont, sGrp, sCust, sSts, sFrDate, sToDate, sStr, sDmgWvr
    	, sHalfDay, sOnline, sParent
    	, sPickAmPm, sDropAmPm
    	, sAction, sUser, sUserNm);
      sCont = rentsave.getCont();
      sSts = rentsave.getSts();
     
      System.out.println("sCont=" + sCont + " sSts=" + sSts);
     
      // add primary customer 
      if(sCust.trim().equals("")){ sAction = "ADD_CUST"; }
      else { sAction = "UPD_CUST"; }
 
      //System.out.println(" anlef=" + sAngleLeft + " damagew=" + sDmgWvr);
      rentsave.saveCustomer(sCont, sCust, sFName, sMInit, sLName, sAddr1, sAddr2, sCity, sState, sZip, sEMail
              , sHPhone, sCPhone, sGroup, sBDate, sHeightFt, sHeightIn, sWeight
              , sShoeSiz, sSkiType, sStance, sMondoSiz, sAngleLeft, sAngleRight, sIntl
              , sAction, sUser);
      sCust = rentsave.getCust();

      //System.out.println("sAction " + sAction + " Contract: " + sCont + "  Cust: " + sCust);

      // assign customer to contract add 1 st skier to RECONTS file
      sAction = "ADD_CUST_CONT";
      rentsave.saveContract(sCont, sGrp, sCust, sSts, sFrDate, sToDate, sStr, sDmgWvr
    	, sHalfDay, sOnline, sParent
    	, sPickAmPm, sDropAmPm
    	, sAction, sUser, sUserNm);
    }
   else if(sAction.equals("ADD_CUST_ONLY") || sAction.equals("UPD_CUST_ONLY")){
	   
	   System.out.println("sAction:" + sAction + " Cont=" + sCont + "| Cust=" + sCust 
			   + "| FName=" + sFName + "| Addr1=" + sAddr1 + "| Intl=" + sIntl);
	   rentsave.saveCustomer(sCont, sCust, sFName, sMInit, sLName, sAddr1, sAddr2, sCity, sState, sZip, sEMail
	              , sHPhone, sCPhone, sGroup, sBDate, sHeightFt, sHeightIn, sWeight
	              , sShoeSiz, sSkiType, sStance, sMondoSiz, sAngleLeft, sAngleRight, sIntl, sAction, sUser);
	   sCust = rentsave.getCust();
   }
    //==========================================================================
    // update contract date and status
    //==========================================================================
    else if(sAction.equals("CHG_CONT_STS"))
    {	
       if (!rentsave.checkContract(sCont, "SAME", sSts, sFrDate, sToDate, "SAME", sAction, sUser))
       {   
    	   iNumOfConf = rentsave.getNumOfConf();
    	   rentsave.saveContract(sCont, sGrp, "SAME", sSts, sFrDate, sToDate, "SAME","SAME"
    			   , sHalfDay, sOnline, "SAME", sPickAmPm, sDropAmPm
    			   , sAction, sUser, sUserNm);

           // change customer status
           sCust = rentsave.getCust();   
           if(sUnrel.equals("Y")){  rentsave.saveRtnCustSts(sCust, sUnrel, "CUST_CHG_STS", sUser); }

           if(iNumOfConf == 0){ sAction = "CONT_CONF_FOUND"; }
       }
       else
       {
    	  iNumOfConf = rentsave.getNumOfConf();
          sConfCont = rentsave.getConfCont();
          sConfSts = rentsave.getConfSts();
          sConfInvId = rentsave.getConfInvId();
          sConfSrlNum = rentsave.getConfSrlNum();
          sConfDesc = rentsave.getConfDesc();
          sConfSizeNm = rentsave.getConfSizeNm();
          sConfCust = rentsave.getConfCust();
          sConfFName = rentsave.getConfFName();
          sConfMInit = rentsave.getConfMInit();
          sConfLName = rentsave.getConfLName();
          sAction = "CONT_ERR_CONF";
       }
    }
    //==========================================================================
    // assign customer to contract add 1 st skier to RECONTS file
    //==========================================================================
    else if(sAction.equals("UPD_CONT"))
    {
       rentsave.saveContract(sCont, sGrp, sCust, sSts, sFrDate, sToDate, sStr, sDmgWvr
    		   , sHalfDay, sOnline, sParent
    		   , sPickAmPm, sDropAmPm
    		   , sAction, sUser, sUserNm);
    }
    else if(sAction.equals("NEED_PAY"))
    {
        rentsave.savePayReq(sCont, sPayReq, sAction, sUser);
    }

    //==========================================================================
    // add customer
    //==========================================================================
    else if(sAction.equals("ADD_CUST_ADD_CUST_CONT")
         || sAction.equals("UPD_CUST_ADD_CUST_CONT") || sAction.equals("UPD_CUST_UPD_CUST_CONT"))
    {
       String sCustAct = sAction.substring(0, 8);
       rentsave.saveCustomer(sCont, sCust, sFName, sMInit, sLName, sAddr1, sAddr2, sCity, sState, sZip, sEMail
              , sHPhone, sCPhone, sGroup, sBDate, sHeightFt, sHeightIn, sWeight
              , sShoeSiz, sSkiType, sStance, sMondoSiz, sAngleLeft, sAngleRight, sIntl, sCustAct, sUser);
       sCust = rentsave.getCust();

       // assign customer to contract add 1 st skier to RECONTS file
       String sCustContAct = sAction.substring(9);
       
       //System.out.println("saveSkier: sCustContAct= " + sCustContAct + "| sParent=" + sParent); 
       if(sCustContAct.equals("ADD_CUST_CONT") || sCustContAct.equals("UPD_CUST_CONT"))
       {    	  
          rentsave.saveSkier(sCont, sCust, sDmgWvr, sParent, sCustContAct, sUser);
       }
    }
    //==========================================================================
    // change returned customer status
    //==========================================================================
    else if(sAction.equals("DLT_CUST_CONT"))
    {
       rentsave.saveSkier(sCont, sCust, sDmgWvr, sParent, sAction, sUser);
    }
    //==========================================================================
    // add customer
    //==========================================================================
    else if(sAction.equals("CUST_CHG_STS"))
    {
       rentsave.saveRtnCustSts(sCust, sUnrel, sAction, sUser);
    }

    //==========================================================================
    // check out inventory for contract and customer
    //==========================================================================
    else if(sAction.startsWith("ADD_CONT_TAG") 
    	|| sAction.equals("DLT_CONT_TAG") 
    	|| sAction.equals("ADD_POLES"))
    {
       rentsave.saveContCustInv(sCont, sCust, sInvId, " ", " ", " ", " ", " ", sAction, sUser);
    }

    //==========================================================================
    // check out inventory for contract and customer
    //==========================================================================
    else if(sAction.equals("ADD_USED_TAG"))
    {

       if (!rentsave.checkInvAvail(sCont, sCust, sInvId, " ", " ", " ", " ", " ", sAction, sUser))
       {
           iNumOfConf = rentsave.getNumOfConf();
           
           rentsave.saveContCustInv(sCont, sCust, sInvId, " ", " ", " ", " ", " ", sAction, sUser);
           sRtnInvId = rentsave.getInvId();
           sRtnSrlNum = rentsave.getSrlNum();
       }
       else
       {
          iNumOfConf = rentsave.getNumOfConf();
          sConfCont = rentsave.getConfCont();
          sConfSts = rentsave.getConfSts();
          sConfInvId = rentsave.getConfInvId();
          sConfSrlNum = rentsave.getConfSrlNum();
          sConfDesc = rentsave.getConfDesc();
          sConfSizeNm = rentsave.getConfSizeNm();
          sConfCust = rentsave.getConfCust();
          sConfFName = rentsave.getConfFName();
          sConfMInit = rentsave.getConfMInit();
          sConfLName = rentsave.getConfLName();
          sAction = "CONT_ERR_CONF";
       }
    }

    //==========================================================================
    // update inventory settings
    //==========================================================================
    else if(sAction.equals("UPD_CONT_TAG"))
    {
       rentsave.saveContCustInv(sCont, sCust, sInvId, sBootLn, sLeftToe, sRightToe
       , sLeftHeal, sRightHeal, sAction, sUser);
    }
    //==========================================================================
    // update assigned to contract serial number 
    //==========================================================================
    else if(sAction.equals("CHG_CONT_EQP"))
    {
    	//System.out.println(sSrlNum + "|" + sCont + "|" + sUser);
    	boolean bOk = rentsave.checkSrlNumAvail(sCont, sSrlNum, sUser);
    	if(rentsave.checkSrlNumAvail(sCont, sSrlNum, sUser))
    	{    		
    		rentsave.saveContSrlNum(sCont, sSrlNum, sOldSrlNum, sAction, sUser);
    	}
    	else
    	{ 
    		sError = rentsave.getError();
    		iNumOfConf = rentsave.getNumOfConf();
            sConfCont = rentsave.getConfCont();
            sConfSts = rentsave.getConfSts();
            sConfInvId = rentsave.getConfInvId();
            sConfSrlNum = rentsave.getConfSrlNum();
            sConfDesc = rentsave.getConfDesc();
            sConfSizeNm = rentsave.getConfSizeNm();
            sConfCust = rentsave.getConfCust();
            sConfFName = rentsave.getConfFName();
            sConfMInit = rentsave.getConfMInit();
            sConfLName = rentsave.getConfLName();
    	}
    } 
 	//==========================================================================
 	// assign any tag from available contract  
 	//==========================================================================
 	else if(sAction.equals("ADD_AVAIL_TAG"))
 	{
   		rentsave.setContAvlTag(sCont, sCust, sStr, sCls, sVen, sSty, sClr, sSiz, sAction, sUser);   	
 	}    
    //==========================================================================
    // add comments for contract
    //==========================================================================
    else if(sAction.equals("ADD_COMMT"))
    {
       rentsave.saveComment(sCont, sCommt, sAction, sUser);
    }

    //==========================================================================
    // change availability
    //==========================================================================
    else if(sAction.equals("RMV_INV_AVAIL") || sAction.equals("RTN_INV_AVAIL"))
    {
       rentsave.saveInvSts(sInvId, sReason, sCommt, sAction, sUser);
    }
    //==========================================================================
    // add new serial number
    //==========================================================================
    else if(sAction.equals("CRT_SRL_NUM"))
    {
       //System.out.println(sCls + "|" + sVen + "|" + sSty + "|" + sClr + "|" + sSiz + "|"
       //    + sStr + "|" + sReason + "|" + sAction + "|" + sUser);
       rentsave.addNewSerial(sCls, sVen, sSty, sClr, sSiz, sStr, sReason, sSrlNum, sBrand
    		   , sModel, sAddDt, sAction, sUser);
    }
   
 	//==========================================================================
   	// add new serial number
   	//==========================================================================
   	else if(sAction.equals("DLT_LAST_SN"))
   	{
        //System.out.println(sCls + "|" + sVen + "|" + sSty + "|" + sClr + "|" + sSiz + "|"
       //  + sStr + "|" + sReason + "|" + sAction + "|" + sUser);
       rentsave.dltLastSerial(sCls, sVen, sSty, sClr, sSiz, sStr, sReason, sNumSn, sAction, sUser);
    }
 	//==========================================================================
  	// update test grade of Item
  	//==========================================================================
  	else if(sAction.equals("TEST_STAMP") || sAction.equals("TEST_STAMP_CONT"))
  	{
      rentsave.setTestStamp(sInvId, sGrade, sTech, sAction, sUser);
    }
    //==========================================================================
    // add new serial number
    //==========================================================================
    else if(sAction.equals("UPD_PURCH_YR") || sAction.equals("UPD_EQUIP_TYPE")
         || sAction.equals("UPD_BRAND") || sAction.equals("UPD_MODEL") || sAction.equals("UPD_ADDDT"))
    {
       //System.out.println(sInvId + "|" + sPurchYr + "|" + sEquipTy + "|" + sAction + "|" + sUser);
       rentsave.updSerial(sInvId, sPurchYr, sEquipTy, sBrand, sModel, sAddDt, sAction, sUser);
    }

    //==========================================================================
    // delete new serial number
    //==========================================================================
    else if(sAction.equals("DLT_SRL_NUM") )
    {
       rentsave.dltSerial(sInvId, sAction, sUser);
    }
   
 	//==========================================================================
   	// add new inventory (RentInvAdd.jsp)
   	//==========================================================================
   	else if(sAction.equals("ADDNEWINV") || sAction.equals("UPDNEWINV"))
   	{    	
   		rentsave.chgNewInv(sStr, sRentTy, sGrp, sEquipTy, sSrlNum, sBrand, sModel, sMfgSn, sSiz
   				, sPurchYr, sLife, sTrade, sAddDt, sAction, sUser);
   		sRtnInvId = rentsave.getInvId();
    	sRtnCls = rentsave.getCls();
    	sRtnClsNm = rentsave.getClsNm();
   	}
   
    //==========================================================================
  	// add new inventory (RentInvAdd.jsp)
  	//==========================================================================
  	else if(sAction.equals("Add_Rtn_SN"))
  	{      		
  		//System.out.println("saveRtnInv: " + "|" + sCont + "|" + sSrlNum + "|" + sAction + "|" + sUser);
  		rentsave.saveRtnInv(sCont, sSrlNum, sAction, sUser);
  		sError = rentsave.getError();
  		//System.out.println("saveRtnInv: " + sError );
  	}
   
    //==========================================================================
 	// add new inventory (RentInvAdd.jsp)
 	//==========================================================================
 	else if(sAction.equals("Rtn_Sts_Cont"))  
 	{      		
 		//System.out.println("saveContRtn: A" + "|" + sCont + "|" + sAction + "|" + sUser);
 		rentsave.saveContRtn(sCont, sAction, sUser); 
 		sChgSts = rentsave.getChgSts();
 	}
    //==========================================================================
    // Open new Contract and add primary customer
    //==========================================================================
    else if(sAction.equals("Switch_Payee"))
    {
    	rentsave.saveSwitchPayee(sCont, sCust, sAction, sUser); 
    }
   
    /*+ "<input name='Model'>"
      + "<input name='MfgSn'>"
      + "<input name='PurchYr'>"
      + "<input name='Life'>"
      + "<input name='AddDt'>"
      + "<input name='Action'>"*/

    //==========================================================================
    // disconnect
    //==========================================================================
    rentsave.disconnect();
    //System.out.println("RentContractSave Action=" + sAction);
%>
Contract: <%=sCont%><br>
Customer: <%=sCust%><br>
Pick up: <%=sFrDate%><br>
Drop off: <%=sToDate%><br>
InvId: <%=sInvId%><br>
Action = <%=sAction%><br>
BootLn = <%=sBootLn%><br>
Left Toe = <%=sLeftToe%><br>
Right Toe = <%=sRightToe%><br>
Left Heal = <%=sLeftHeal%><br>
Right Heal = <%=sRightHeal%><br>
Sts = <%=sSts%><br>
Commt = <%=sCommt%><br>

<SCRIPT language="JavaScript1.2">

 var ConfCont = [<%=sConfCont%>];
 var ConfSts = [<%=sConfSts%>];
 var ConfInvId = [<%=sConfInvId%>];
 var ConfSrlNum = [<%=sConfSrlNum%>];
 var ConfDesc = [<%=sConfDesc%>];
 var ConfSizeNm = [<%=sConfSizeNm%>];
 var ConfCust = [<%=sConfCust%>];
 var ConfFName = [<%=sConfFName%>];
 var ConfMInit = [<%=sConfMInit%>];
 var ConfLName = [<%=sConfLName%>];
 var NumOfUnresolvedConf = <%=iNumOfConf%>;
 var RtnInvId = "<%=sRtnInvId%>";
 var RtnSrlNum = "<%=sRtnSrlNum%>";
 var RtnCls = "<%=sRtnCls%>";
 var RtnClsNm = "<%=sRtnClsNm%>";
 var Action = "<%=sAction%>" 

  <%if(sAction.equals("CRT_SRL_NUM") || sAction.equals("UPD_PURCH_YR") || sAction.equals("UPD_EQUIP_TYPE")
    || sAction.equals("UPD_BRAND") || sAction.equals("UPD_MODEL") || sAction.equals("UPD_ADDDT")
    || sAction.equals("DLT_SRL_NUM") || sAction.equals("DLT_LAST_SN") || sAction.equals("TEST_STAMP")
    ) {%>
       parent.refreshSrl()
  <%}
    else if(sAction.startsWith("ADD_CONT_TAG") || sAction.equals("ADD_POLES")){%>
       parent.refreshTag("<%=sCont%>", "<%=sCust%>", true, null, null);
  <%}
    else if(sAction.equals("ADD_USED_TAG")){%>
       parent.refreshTag("<%=sCont%>", "<%=sCust%>", false, RtnInvId, RtnSrlNum);
  <%}
    else if(sAction.equals("CONT_ERR_CONF")){%>
       parent.showConflicts(ConfCont, ConfInvId, ConfSts, ConfSrlNum, ConfDesc, ConfSizeNm
                          , ConfCust, ConfFName, ConfMInit, ConfLName);
  <%}
    else if(sAction.equals("CONT_CONF_FOUND")){%>
       parent.showWarning();
  <%}
    else if(sAction.equals("ADDNEWINV") || sAction.equals("UPDNEWINV")
    	|| sAction.equals("RMV_INV_AVAIL") || sAction.equals("RTN_INV_AVAIL")){%>
       parent.refreshTbl(RtnInvId, RtnCls, RtnClsNm);
  <%}
     else if(sAction.equals("CHG_CONT_EQP")){%>
       parent.refreshEqp("<%=sError%>", NumOfUnresolvedConf, ConfCont, ConfInvId, ConfSts, ConfSrlNum, ConfDesc
    	, ConfSizeNm, ConfCust, ConfFName, ConfMInit, ConfLName);
  <%}
     else if(sAction.equals("ADD_AVAIL_TAG")){%>
     parent.refreshAvlEqp("<%=sError%>");
  <%}  
     else if(sAction.equals("Add_Rtn_SN")){ %>
       parent.refreshRtn("<%=sCont%>", "<%=sSrlNum%>", "<%=sError%>"); 
  <%}  
     else if(sAction.equals("Rtn_Sts_Cont")){ %>
     parent.refreshContSts("<%=sCont%>", "<%=sChgSts%>");
  <%} 
     else if(sAction.equals("ADD_CUST_ONLY") || sAction.equals("UPD_CUST_ONLY")) { %>
     parent.refreshCust("<%=sCust%>");
  <%}
     else if(   !sAction.equals("RMV_INV_AVAIL") && !sAction.equals("RTN_INV_AVAIL") ){%>
      // open_cont return here
      parent.refreshCont("<%=sCont%>");
      
  <%}
     else if( sAction.equals("Switch_Payee") ){%>
     parent.refreshCont("<%=sCont%>", "<%=sAction%>");     
 <%}
    else {%>parent.refreshScreen()<%}%>
</SCRIPT>













