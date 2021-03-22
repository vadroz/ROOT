<%@ page import="discountcard.CustomerPurchase ,java.util.*, java.text.*"%>
<%
   response.setContentType("application/vnd.ms-excel");
   String sSrchCode = request.getParameter("Code");
   String sCustomer = request.getParameter("Customer");
   String sSrchFrom = request.getParameter("From");
   String sSrchTo = request.getParameter("To");
   String sSort = request.getParameter("Sort");
   
   if(sSort != null){ sSort = "STRDATE"; }
   

   int iNumOfPrch = 0;
   CustomerPurchase custprch = new CustomerPurchase(sSrchCode, sSrchFrom, sSrchTo,sSort, session.getAttribute("USER").toString());
   iNumOfPrch = custprch.getNumOfPrch();

   out.println("\t\t\t Retail Concepts, Inc" );
   out.println("\t\t\t Customer Purchase List" );
   out.println("Store\t Purchase Date\t Retail\t Quantity\t Short SKU\t Item Description");

   for(int i=0; i < iNumOfPrch; i++)
   {
      custprch.setPurchaseList();
      String sStr = custprch.getStr();
      String sDate = custprch.getDate();
      String sRet = custprch.getRet();
      String sQty = custprch.getQty();
      String sSku = custprch.getSku();
      String sDesc = custprch.getDesc();

      out.print(sStr);
      out.print("\t" + sDate);
      out.print("\t" + sRet);
      out.print("\t" + sQty);
      out.print("\t" + sSku);
      out.println("\t" + sDesc);
   }

   custprch.disconnect();
%>