<%@ page import="patiosales.PsOrdGetItem, java.util.*"%>
<%
   String sOrder = request.getParameter("Order");
   String sSrchSku = request.getParameter("Sku");
   String sSrchUpc = request.getParameter("Upc");
   String sAction = request.getParameter("Action");

   if(sOrder==null) sOrder = " ";
   if(sSrchSku==null) sSrchSku = " ";
   if(sSrchUpc==null) sSrchUpc = " ";

   int iNumOfErr = 0;
   String sError = null;

   String sDesc = null;
   String sSku = null;
   String sUpc = null;
   String sSet = null;
   String sPrice = null;
   String sGroup = null;
   String sQty35 = null;
   String sQty46 = null;
   String sQty50 = null;
   String sQty86 = null;
   String sQty63 = null;
   String sQty64 = null;
   String sQty68 = null;
   String sQty55 = null;
   String sSugPrc = null;
   String sTempPrc = null;
   String sClrNm = null;
   String sVenNm = null;
   String sVenSty = null;
   String sItmPoQty = null;
   String sDisconn = null;

   int iNumOfSet = 0;
   String sSetDesc = null;
   String sSetSku = null;
   String sSetUpc = null;
   String sSetPrice = null;
   String sSetSugPrc = null;
   String sSetGroup = null;
   String sSetQty35 = null;
   String sSetQty46 = null;
   String sSetQty50 = null;
   String sSetQty86 = null;
   String sSetQty63 = null;
   String sSetQty64 = null;
   String sSetQty68 = null;
   String sSetQty55 = null;
   String sSetTot = null;
   String sSetUntPrc = null;
   String sSetTempPrc = null;
   String sSetClrNm = null;
   String sSetVenNm = null;
   String sSetVenSty = null;
   String sSetPoQty = null;
   String sSetDisconn = null;

   PsOrdGetItem getitem = new PsOrdGetItem(sOrder, sSrchSku, sSrchUpc, session.getAttribute("USER").toString());

    sDesc = getitem.getDesc();
    sSku = getitem.getSku();
    sUpc = getitem.getUpc();
    sSet = getitem.getSet();
    sPrice = getitem.getPrice();
    sGroup = getitem.getGroup();
    sQty35 = getitem.getQty35();
    sQty46 = getitem.getQty46();
    sQty50 = getitem.getQty50();
    sQty86 = getitem.getQty86();
    sQty63 = getitem.getQty63();
    sQty64 = getitem.getQty64();
    sQty68 = getitem.getQty68();
    sQty55 = getitem.getQty55();
    sSugPrc = getitem.getSugPrc();
    sTempPrc = getitem.getTempPrc();
    sClrNm = getitem.getClrNm();
    sVenNm = getitem.getVenNm();
    sVenSty = getitem.getVenSty();
    sItmPoQty = getitem.getItmPoQty();
    sDisconn = getitem.getDisconn();

    iNumOfErr = getitem.getNumOfErr();
    sError = getitem.getErrorJsa();

    iNumOfSet = getitem.getNumOfSet();

    if(iNumOfSet > 0)
    {
       sSetDesc = getitem.getSetDesc();
       sSetSku = getitem.getSetSku();
       sSetUpc = getitem.getSetUpc();
       sSetPrice = getitem.getSetPrice();
       sSetSugPrc = getitem.getSetSugPrc();
       sSetGroup = getitem.getSetGroup();
       sSetQty55 = getitem.getSetQty55();
       sSetQty35 = getitem.getSetQty35();
       sSetQty46 = getitem.getSetQty46();
       sSetQty50 = getitem.getSetQty50();
       sSetQty86 = getitem.getSetQty86();
       sSetQty63 = getitem.getSetQty63();
       sSetQty64 = getitem.getSetQty64();
       sSetQty68 = getitem.getSetQty68();
       sSetTot = getitem.getSetTot();
       sSetUntPrc = getitem.getSetUntPrc();
       sSetTempPrc = getitem.getSetTempPrc();
       sSetClrNm = getitem.getSetClrNm();
       sSetVenNm = getitem.getSetVenNm();
       sSetVenSty = getitem.getSetVenSty();
       sSetPoQty = getitem.getSetPoQty();
       sSetDisconn = getitem.getSetDisconn();
    }

    // PO List
    int iNumOfPoItm = getitem.getNumOfPoItm();
    String sPoSku = getitem.getPoSku();
    String sStrPo = getitem.getStrPo();
    String sPoStr = getitem.getPoStr();
    String sPoNum = getitem.getPoNum();
    String sPoQty = getitem.getPoQty();
    String sPoAdi = getitem.getPoAdi();
%>

<SCRIPT language="JavaScript1.2">
   var NumOfErr = <%=iNumOfErr%>;
   var Error = [<%=sError%>];

   var NumOfSet = <%=iNumOfSet%>;
   var Desc = "<%=sDesc%>";
   var Sku = "<%=sSku%>";
   var Upc = "<%=sUpc%>";
   var Set = "<%=sSet%>";
   var Price = "<%=sPrice%>";
   var Group = "<%=sGroup%>";
   var Qty35 = [<%=sQty35%>];
   var Qty46 = [<%=sQty46%>];
   var Qty50 = [<%=sQty50%>];
   var Qty86 = [<%=sQty86%>];
   var Qty63 = [<%=sQty63%>];
   var Qty64 = [<%=sQty64%>];
   var Qty68 = [<%=sQty68%>];
   var Qty55 = [<%=sQty55%>];
   var SugPrc = "<%=sSugPrc%>";
   var TempPrc = "<%=sTempPrc%>";
   var Action = "<%=sAction%>"
   var ClrNm = "<%=sClrNm%>";
   var VenNm = "<%=sVenNm%>";
   var VenSty = "<%=sVenSty%>";
   var ItmPoQty = "<%=sItmPoQty%>";
   var Disconn = "<%=sDisconn%>";

   // Set components
   var SetDesc = [<%=sSetDesc%>];
   var SetSku = [<%=sSetSku%>];
   var SetUpc = [<%=sSetUpc%>];
   var SetPrice = [<%=sSetPrice%>];
   var SetGroup = [<%=sSetGroup%>];
   var SetQty35 = [<%=sSetQty35%>];
   var SetQty46 = [<%=sSetQty46%>];
   var SetQty50 = [<%=sSetQty50%>];
   var SetQty86 = [<%=sSetQty86%>];
   var SetQty63 = [<%=sSetQty63%>];
   var SetQty64 = [<%=sSetQty64%>];
   var SetQty68 = [<%=sSetQty68%>];
   var SetQty55 = [<%=sSetQty55%>];
   var SetSugPrc = [<%=sSetSugPrc%>];
   var SetTot = [<%=sSetTot%>];
   var SetUntPrc = [<%=sSetUntPrc%>];
   var SetTempPrc = [<%=sSetTempPrc%>];
   var SetClrNm = [<%=sSetClrNm%>];
   var SetVenNm = [<%=sSetVenNm%>];
   var SetVenSty = [<%=sSetVenSty%>];
   var SetPoQty = [<%=sSetPoQty%>];
   var SetDisconn = [<%=sSetDisconn%>];

   var NumOfPoItm = "<%=iNumOfPoItm%>";
   var PoSku = [<%=sPoSku%>];
   var LineBySku = [<%=sStrPo%>];
   var PoStr = [<%=sPoStr%>];
   var PoNum = [<%=sPoNum%>];
   var PoQty = [<%=sPoQty%>];
   var PoAdi = [<%=sPoAdi%>];

   goBack();

//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
   if(NumOfErr > 0) parent.displayError(Error);
   else
   {
      //if (Desc.length < 13 || Desc.substring(0, 13) !="SPECIAL ORDER")
      if(Sku != "0005487251")
      {
         parent.popAddLine(Desc, Sku, Upc, Set, Price, Group, Qty35, Qty46, Qty50, Qty86
         , Qty63, Qty64, Qty68, Qty55, SugPrc, TempPrc, ClrNm, VenNm, VenSty, ItmPoQty, Disconn, Action);
         if (Set==1)
         {        	 
            parent.popAddSetLines(NumOfSet, SetDesc, SetSku, SetUpc, SetPrice, SetGroup
              , SetQty35, SetQty46, SetQty50, SetQty86, SetQty63, SetQty64, SetQty68, SetQty55
              , SetSugPrc, SetTot, SetUntPrc
              , SetTempPrc, SetClrNm, SetVenNm, SetVenSty, SetPoQty, SetDisconn, Action);
         }
         else if (Set==2 && parent.popSetLists != null)
         {
        	parent.popSetLists(NumOfSet, SetDesc, SetSku, SetUpc, SetPrice, SetGroup
              , SetQty35, SetQty46, SetQty50, SetQty86, SetQty63, SetQty64, SetQty68, SetQty55
              , SetSugPrc, SetTot, SetUntPrc
              , SetTempPrc, SetClrNm, SetVenNm, SetVenSty, SetPoQty, SetDisconn, Action);
         }
      }
      else
      {
         parent.popAddSpecOrd(Desc, Sku, Upc, Action);
      }

      if(parent.popPoTable != null)
      {
         parent.popPoTable(NumOfPoItm, PoSku, LineBySku, PoStr, PoNum, PoQty, PoAdi);
      }
   }

}
</SCRIPT>
<%
    getitem.disconnect();
    getitem = null;
%>