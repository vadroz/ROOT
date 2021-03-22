<%@ page import="patiosales.OrderEntry , java.util.*, java.math.BigDecimal"%>
<%
   String sOrder = request.getParameter("Order");
   String sCust = request.getParameter("Cust");
   String sSlsper = request.getParameter("Slsper");
   String sDelDate = request.getParameter("DelDate");
   String sStore = request.getParameter("Store");
   String sShpInstr = request.getParameter("ShpInstr");
   String sLastName = request.getParameter("LastName");
   String sFirstName = request.getParameter("FirstName");
   String sAddr1 = request.getParameter("Addr1");
   String sAddr2 = request.getParameter("Addr2");
   String sCity = request.getParameter("City");
   String sState = request.getParameter("State");
   String sZip = request.getParameter("Zip");
   String sDayPhn = request.getParameter("DayPhn");
   String sEvtPhn = request.getParameter("EvtPhn");
   String sExtWorkPhn = request.getParameter("ExtWorkPhn");
   String sCellPhn = request.getParameter("CellPhn");
   String sEMail = request.getParameter("EMail");
   String sAlwEml = request.getParameter("AlwEml");
   String sAction = request.getParameter("Action");

   String sSts = request.getParameter("Sts");
   String sReg = request.getParameter("Reg");
   String sTrans = request.getParameter("Trans");
   String sShpPrc = request.getParameter("ShpPrc");
   String sCommtType = request.getParameter("CommtType");
   String sComments = request.getParameter("Comments");
   String sVenNum = request.getParameter("Ven");
   String sPONum = request.getParameter("PONum");
   String sEmpNum = request.getParameter("EmpNum");
   String sUser = request.getParameter("User");
   
   String sSpecOrd = request.getParameter("Spo");
   String sCustPickup = request.getParameter("CPup");

   if(sComments==null) sComments=" ";
   if(sSpecOrd == null || sSpecOrd.equals("")){sSpecOrd = " ";}
   if(sCustPickup == null || sCustPickup.equals("")){sCustPickup = " ";}


   int iNumOfErr = 0;
   String sError = null;

//----------------------------------
// Application Authorization
//----------------------------------
    OrderEntry ordent = new OrderEntry();

   // change status
   if(sAction.equals("CHGSTS") || sAction.equals("CHGSOSTS") || sAction.equals("CHGREGTRN"))
   {
      if(sReg==null){ sReg=" "; }
      if(sTrans==null){ sTrans=" "; }
      if(sEmpNum != null){ sTrans = sEmpNum; } // for cancellation quotes
      ordent.saveOrdSts(sOrder, sSts, sReg, sTrans, sAction, sUser);
      iNumOfErr = ordent.getNumOfErr();

      if(iNumOfErr == 0 && !sComments.trim().equals(""))
      {
         ordent.saveComments(sOrder, sCommtType, sComments, "ADDCOMMENT", sUser);
      }
      // update delivery date if status='ready-to-delivery'
      if (sAction.equals("CHGSTS") && sSts.equals("R"))
      {
         ordent.setOrdDlvDate(sOrder, sDelDate, "CHGORDDELDT", sUser);
      }
   }

   // change shipping price
   else if (sAction.equals("SHPPRC") || sAction.equals("DSCAMT") || sAction.equals("DLVPRC") || sAction.equals("OVRTAX")
         || sAction.equals("PAIDBYCST") || sAction.equals("ASMPRC") || sAction.equals("PROPLAN"))
   {
      ordent.saveShipPrc(sOrder, Double.parseDouble(sShpPrc), sAction, sUser);
   }
   // change comments or notes
   else if (sAction.equals("ADDCOMMENT") || sAction.equals("ADDNOTE") || sAction.equals("ADDCUSTRSP"))
   {
      if(sAction.equals("ADDNOTE")){ sCommtType = "NOT"; }
      ordent.saveComments(sOrder, sCommtType, sComments, sAction, sUser);
   }
   // change order delivery date
   else if (sAction.equals("CHGORDDELDT"))
   {
      ordent.setOrdDlvDate(sOrder, sDelDate, sAction, sUser);
   }
   // change vendor delivery date
   else if (sAction.equals("CHGVNDELDT"))
   {
      ordent.setVenDlvDate(sOrder, sVenNum, sPONum, sDelDate, null, null, null, null, null, null, sAction, sUser);
   }
   // add new PO
   else if (sAction.equals("ADDPONUM"))
   {
      ordent.setVenPO(sOrder, sVenNum, sPONum, sAction, sUser);
   }
   // add / update order
   else
   {
      if(sAction.equals("ADDORD") || sAction.equals("ADDQUO") || sAction.equals("ADDWAR"))
      {
          ordent.setNewOrder();
          sOrder = ordent.getOrdNum();
      }
      System.out.println("sOrder=" + sOrder + "  sDelDate=" + sDelDate);
      ordent.saveAddUpdOrdHdr(sOrder, sCust, sSlsper, sStore, sDelDate,  sShpInstr, sLastName, sFirstName
          ,sAddr1, sAddr2, sCity, sState, sZip, sDayPhn, sExtWorkPhn, sEvtPhn, sCellPhn, sEMail, sAlwEml
          ,sSpecOrd,sCustPickup
          ,sAction, sUser);
      ordent.setError();
   }

   iNumOfErr = ordent.getNumOfErr();
   sError = ordent.getError();

   ordent.disconnect();

%>

<SCRIPT language="JavaScript1.2">

   var NumOfErr = <%=iNumOfErr%>;
   var Error = [<%=sError%>];
   var Action = "<%=sAction%>";  
   var Order= "<%=sOrder%>"
   goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{	
   if(NumOfErr > 0){ parent.displayError(Error); }
   else if(Action == "ADDORD" || Action == "ADDQUO") { parent.saveCustAnsw(Order); }
   else if(Action == "ADDWAR" || Action == "UPDWAR") { parent.reStartNewOrd(Order) }
   else { parent.reStart(); }
}
 
</SCRIPT>
