<%@ page import="patiosales.WarrantyClaimSav ,java.util.*, java.text.*,  java.io.*"%>
<%
   String sSelOrder = request.getParameter("Order");
   String sAction = request.getParameter("Action");
   String sSelClaim = request.getParameter("Claim");
   String sItem = request.getParameter("Item");
   String sSku = request.getParameter("Sku");
   String sVen = request.getParameter("Ven");
   String sVenSty = request.getParameter("VenSty");
   String sFile = request.getParameter("File");
   String sPath = request.getParameter("Path");
   String sQty = request.getParameter("Qty");
   String sSelClmSts = request.getParameter("ClmSts");
   String sItemIss = request.getParameter("ItmIss");
   String sItemAct = request.getParameter("ItmAct");
   String sItemSts = request.getParameter("ItmSts");
   String sRANum = request.getParameter("RANum");
   String sItmFin = request.getParameter("ItmFin");
   String sEstShpDt = request.getParameter("EstShpDt");
   String sComment = request.getParameter("Comment");
   String sCommId = request.getParameter("CommId");

   String sSelCust = request.getParameter("Cust");
   String sFirstNm = request.getParameter("FirstNm");
   String sLastNm = request.getParameter("LastNm");
   String sAddr1 = request.getParameter("Addr1");
   String sAddr2 = request.getParameter("Addr2");
   String sAddr3 = request.getParameter("Addr3");
   String sCity = request.getParameter("City");
   String sState = request.getParameter("State");
   String sZip = request.getParameter("Zip");
   String sDayPhn = request.getParameter("DayPhn");
   String sExt = request.getParameter("Ext");
   String sEvPhn = request.getParameter("EvPhn");
   String sCell = request.getParameter("Cell");
   String sEmail = request.getParameter("Email");

   if(sRANum == null || sRANum.equals("")){ sRANum = " "; }

//----------------------------------
// Application Authorization
//----------------------------------
String sUser = session.getAttribute("USER").toString();

if (session.getAttribute("USER")!=null)
{
   WarrantyClaimSav wcsave = new WarrantyClaimSav();

   String sOrder = null;
   String sClmSts = null;

   //-------------------------------
   // Open new claim
   //-------------------------------
   if(sAction.equals("OPEN_NEW_CLAIM"))
   {
      wcsave.crtNewClaim(sSelOrder, sAction, sUser);
      sOrder = wcsave.getOrder();
      sSelClaim = wcsave.getClaim();
      sClmSts = wcsave.getClmSts();
   }
   //-------------------------------
   // Add Item
   //-------------------------------
   if(sAction.equals("ADD_ITEM") || sAction.equals("UPD_ITEM") || sAction.equals("RMV_ITEM"))
   {
      /*System.out.println(sSelOrder + "|" + sSelClaim + "|" + sSku + "|" + sQty
       + "|" + sItemIss + "|" + sItemAct + "|" + sItemSts + "|" + sAction + "|" + sUser);
      */
      wcsave.chgItem(sSelOrder, sSelClaim, sItem, sSku, sVen, sVenSty, sQty, sItemIss, sItemAct,
       sItemSts, sRANum, sItmFin, sEstShpDt, sAction, sUser);
   }
   //-------------------------------
   // add claim comments
   //-------------------------------
   if(sAction.equals("ADD_CLM_COMMENT"))
   {
      //System.out.println(sSelOrder + "|" + sSelClaim  + "|" + sComment + "|" + sAction);
      wcsave.crtNewClmComment(sSelOrder, sSelClaim, sComment, sAction, sUser);
   }
   //-------------------------------
   // update claim comments
   //-------------------------------
   if(sAction.equals("UPD_CLM_COMMENT"))
   {
      //System.out.println(sSelOrder + "|" + sSelClaim  + "|" + sComment + "|" + sAction);
      wcsave.updClmComment(sSelOrder, sSelClaim, sComment, sCommId, sAction, sUser);
   }
   //-------------------------------
   // delete claim comments
   //-------------------------------
   if(sAction.equals("DLT_CLM_COMMENT"))
   {
      //System.out.println(sSelOrder + "|" + sSelClaim  + "|" + sComment + "|" + sAction);
      wcsave.dltClmComment(sSelOrder, sSelClaim, sComment, sCommId, sAction, sUser);
   }
   //-------------------------------
   // add item comments
   //-------------------------------
   if(sAction.equals("ADD_ITM_COMMENT"))
   {
      wcsave.crtNewItmComment(sSelOrder, sSelClaim, sSku, sComment, sAction, sUser);
   }
   //-------------------------------
   // update item comments
   //-------------------------------
   if(sAction.equals("UPD_ITM_COMMENT"))
   {
      wcsave.updItmComment(sSelOrder, sSelClaim, sSku, sComment, sCommId, sAction, sUser);
   }
   //-------------------------------
   // update item comments
   //-------------------------------
   if(sAction.equals("DLT_ITM_COMMENT"))
   {
      wcsave.dltItmComment(sSelOrder, sSelClaim, sSku, sComment, sCommId, sAction, sUser);
   }
   //------------------------------------
   // create auto message when email sent
   //------------------------------------
   if(sAction.equals("MESSAGE_SENT"))
   {
      wcsave.crtNewClmComment(sSelOrder, sSelClaim, sComment, sAction, sUser);
   }
   //-------------------------------
   // change customer information
   //-------------------------------
   if(sAction.equals("CHG_CUSTOMER_INFO"))
   {
      wcsave.chgCustInfo(sSelOrder, sSelClaim, sSelCust, sFirstNm, sLastNm, sAddr1, sAddr2, sAddr3, sCity
          , sState, sZip, sDayPhn, sExt, sEvPhn, sCell, sEmail,  sAction, sUser);
   }
   //-------------------------------
   // add item comments
   //-------------------------------
   if(sAction.equals("DLT_ITM_PICTURE"))
   {
      wcsave.dltItmPicture(sSelOrder, sSelClaim, sItem, sPath, sAction, sUser);
      sPath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/Warranty_Claims/" + sPath;

      try{
         File f = new File(sPath);
         if(f.exists() && f.isFile())
         {
           f.delete();
         }
         f = null;
      }
      catch( Exception e )
      {
         System.out.println(e.getMessage());
      }
   }

   //-------------------------------
   // add claim comments
   //-------------------------------
   if(sAction.equals("CHG_CLM_STS"))
   {
      //System.out.println(sSelOrder + " " + sSelClaim + " " + sSelClmSts + " " + sAction + " " + sUser);
      wcsave.chgClmSts(sSelOrder, sSelClaim, sSelClmSts, sAction, sUser);
   }
%>


<SCRIPT language="JavaScript1.2">
var Action = "<%=sAction%>";

parent.refreshClaim("<%=sSelClaim%>", "<%=sSelOrder%>");

</SCRIPT>

<%
  wcsave.disconnect();
  wcsave = null;
}
else {%>
<SCRIPT language="JavaScript1.2">
 alert("You are not authorized to modify claim.")
</SCRIPT>
<%}%>






