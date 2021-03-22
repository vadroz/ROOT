<%@ page import="patiosales.OrderEntry , java.util.*"%>
<%
   String sOrder = request.getParameter("Order");
   String sSku = request.getParameter("Sku");
   String sQty55 = request.getParameter("Qty55");
   String sQty35 = request.getParameter("Qty35");
   String sQty46 = request.getParameter("Qty46");
   String sQty50 = request.getParameter("Qty50");
   String sQty86 = request.getParameter("Qty86");
   String sQty63 = request.getParameter("Qty63");
   String sQty64 = request.getParameter("Qty64");
   String sQty68 = request.getParameter("Qty68");
   String sSetQty = request.getParameter("SetQty");
   String sSet = request.getParameter("Set");
   String [] sSetSku = request.getParameterValues("SetSku");
   String [] sSetQty55 = request.getParameterValues("SetQty55");
   String [] sSetQty35 = request.getParameterValues("SetQty35");
   String [] sSetQty46 = request.getParameterValues("SetQty46");
   String [] sSetQty50 = request.getParameterValues("SetQty50");
   String [] sSetQty86 = request.getParameterValues("SetQty86");
   String [] sSetQty63 = request.getParameterValues("SetQty63");
   String [] sSetQty64 = request.getParameterValues("SetQty64");
   String [] sSetQty68 = request.getParameterValues("SetQty68");
   String sPrice = request.getParameter("Price");
   String sVen = request.getParameter("Ven");
   String sVenSty = request.getParameter("VenSty");
   String sDesc = request.getParameter("Desc");
   String sFrmClr = request.getParameter("FrmClr");
   String sFrmMat = request.getParameter("FrmMat");
   String sFabClr = request.getParameter("FabClr");
   String sFabNum = request.getParameter("FabNum");
   String sItmSiz = request.getParameter("ItmSiz");
   String sComment = request.getParameter("Comment");
   String sPoNum = request.getParameter("PoNum");
   String sMainSku = request.getParameter("MainSku");

   String sQty = request.getParameter("Qty");
   String sAction = request.getParameter("Action");

   String [] sGrpTot = request.getParameterValues("GrpTot");
   String [] sGrpDscPrc = request.getParameterValues("GrpDscPrc");
   String [] sGrpDscAmt = request.getParameterValues("GrpDscAmt");
   String [] sGrpNewAmt = request.getParameterValues("GrpNewAmt");

   String [] sIdSku = request.getParameterValues("IdSku");
   String [] sIdSeq = request.getParameterValues("IdSeq");
   String [] sIdGrp = request.getParameterValues("IdGrp");
   String [] sIdDscAmt = request.getParameterValues("IdDscAmt");
   String [] sIdDscPrc = request.getParameterValues("IdDscPrc");
   String [] sIdUpgAmt = request.getParameterValues("IdUpgAmt");
   String [] sIdNewRet = request.getParameterValues("IdNewRet");
   
   String sClear = request.getParameter("Clear");
   String sUser = request.getParameter("User");

   if(sQty55==null) sQty55 = "0";
   if(sQty35==null) sQty35 = "0";
   if(sQty46==null) sQty46 = "0";
   if(sQty50==null) sQty50 = "0";
   if(sQty86==null) sQty86 = "0";
   if(sQty63==null) sQty63 = "0";
   if(sQty64==null) sQty64 = "0";
   if(sQty68==null) sQty68 = "0";
   if(sPrice==null) sPrice = "0";

   if(sFrmClr==null) sFrmClr = " ";
   if(sFrmMat==null) sFrmMat = " ";
   if(sFabClr==null) sFabClr = " ";
   if(sFabNum==null) sFabNum = " ";
   if(sItmSiz==null) sItmSiz = " ";
   if(sComment==null) sComment = " ";
   if(sPoNum==null) sPoNum = " ";

   OrderEntry ordent = new OrderEntry();
   int iNumOfErr = 0;
   String sError = null;
   
   
   //int iInect = session.getMaxInactiveInterval();
   //long lAcc = session.getLastAccessedTime();
   //Date dAcc = new Date(lAcc);
   //System.out.println("MaxInactiveInterval=" + iInect + "  LastAccessedTime=" + lAcc );
   
//----------------------------------
// Application Authorization
//----------------------------------
   // Item taken
   if (sAction.equals("ADDITMTAKE") || sAction.equals("DLTITMTAKE"))
   {
      ordent.savItmTaken(sOrder, sSku, sQty, sAction, sUser);
   }
   // Set component taken
   else if (sAction.equals("ADDSETTAKE") || sAction.equals("DLTSETTAKE"))
   {
      ordent.savSetTaken(sOrder, sMainSku, sSku, sQty, sAction, sUser);
   }
   // SAVE GROUP discount
   else if (sAction.equals("SaveGrpDsc"))
   {
       if(sGrpDscPrc != null && sGrpDscPrc.length > 0)
       {
	     for(int i=0; i < sGrpDscPrc.length; i++)
         {
    	   sClear="N";
    	   if(i==0){ sClear="Y"; }
    	   
    	   ordent.savGrpDisc(sOrder, Integer.toString(i+1), sGrpDscPrc[i], sGrpDscAmt[i], sGrpNewAmt[i]
	   		, sGrpTot[i], sClear, sAction, sUser);
         }
       }
   }
   // SAVE item discount
   else if (sAction.equals("SaveItmDsc"))
   {
	   for(int i=0; i < sIdSku.length; i++)
       {
		   sClear="N";
    	   if(i == 0){ sClear="Y"; }
    	   else if(i == sIdSku.length-1){ sClear="L"; }
    	   
		   ordent.savItemDisc(sOrder, sIdSku[i], sIdSeq[i], sIdGrp[i], sIdDscAmt[i]
	   		 , sIdDscPrc [i], sIdUpgAmt[i], sIdNewRet[i]
             , sClear, sAction, sUser);
       }
   }
   // SAVE item discount
   else if (sAction.equals("ClearItmDisc"))
   {
      ordent.dltItmDisc(sOrder, sAction, sUser);
   }
   
      // Item entry/update delete
   else if (!sAction.equals("ADDSPOR") && !sAction.equals("UPDSPOR") && !sAction.equals("DLTSPOR"))
   {
      if(sSet.equals("N")) { sSet = "0"; }
      else { sSet = "1"; }
      ordent.saveOrderDtl(sOrder, sSku, sSet, " "
        , sQty55, sQty35, sQty46, sQty50, sQty86, sQty63, sQty64, sQty68, sSetQty
        , sPrice, sAction, sUser);

      ordent.setError();

      iNumOfErr = ordent.getNumOfErr();
      sError = ordent.getError();

      if(iNumOfErr == 0 && sSet.equals("1"))
      {
         for(int i=0; i < sSetSku.length; i++)
         {
            ordent.saveOrderDtl(sOrder, sSku, "2", sSetSku[i]
            , sSetQty55[i], sSetQty35[i], sSetQty46[i], sSetQty50[i], sSetQty86[i]
            , sSetQty63[i], sSetQty64[i], sSetQty68[i]
            , "0", "0", sAction, sUser);
         }
      }
   }
   
   // special Order Item Entry
   else
   {
      //System.out.println(sOrder + " " + sSku + " " + sVen + " " + sVenSty + " " + sComment + " " + sPoNum);
      ordent.saveSpecOrderDtl(sOrder, sSku, sVen, sVenSty, sDesc, sSetQty, sPrice, sFrmClr,
              sFrmMat, sFabClr, sFabNum, sItmSiz, sComment, sPoNum, sAction, sUser);

      iNumOfErr = ordent.getNumOfErr();
      sError = ordent.getError();
   }

   ordent.disconnect();

%>

<SCRIPT language="JavaScript1.2">
   var NumOfErr = <%=iNumOfErr%>;
   var Error = [<%=sError%>];
   var Action = "<%=sAction%>";

   goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
     if(NumOfErr > 0){ parent.displayError(Error); }
     else if (Action == "SaveGrpDsc"){ parent.saveNewItmRet();}
     else if (Action == "SaveItmDsc"){ parent.restart();}
     else if (Action == "ClearItmDisc"){ parent.closeWin();}
     else { parent.reStart(); }
}
</SCRIPT>







