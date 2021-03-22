<%@ page import="flashreps.SkiStopInv ,java.util.*, java.text.*"%>
<%
   response.setContentType("application/vnd.ms-excel");
   String sDiv = request.getParameter("Div");
   String sDpt = request.getParameter("Dpt");
   String sCls = request.getParameter("Cls");
   String sVendor = request.getParameter("Ven");
   String sItmLevel = request.getParameter("ItmLevel");
   String sUser = session.getAttribute("USER").toString();

   SkiStopInv strSstSls = new SkiStopInv(sDiv, sDpt, sCls, sVendor, sItmLevel, sUser);
   int iNumOfGrp = strSstSls.getNumOfGrp();

   String sColName = null;
   if(sItmLevel.equals("DIV")){ sColName = "Division";}
   else if(sItmLevel.equals("DPT")){ sColName = "Department";}
   else if(sItmLevel.equals("CLS")){ sColName = "Class";}
   else if(sItmLevel.equals("VEN")){ sColName = "Vendor";}
   else if(sItmLevel.equals("ITEM")){ sColName = "Item";}
   else { sColName = "";}

   out.println("\t\t\t Retail Concepts, Inc" );
   out.println("\t\t\t Store 86 Inventory Summary" );
   out.println("Selection:\t Div: " + sDiv + "\t Dpt: " + sDpt + "\t Cls: " + sCls + "\t Ven: " + sVendor);
   out.print("\n" + sColName);

   if(sItmLevel.equals("ITEM")){out.print("\t Vendor \t Category \t Sub-Category \t Ski Stop Vendor"); }

   out.print("\t Inv.Ret \t Inv.Qty \t Inv.Cost ");

   for(int i=0; i < iNumOfGrp; i++)
   {
      strSstSls.setSalesInfo();
        String sGrp = strSstSls.getGrp();
        String sGrpName = strSstSls.getGrpName();
        String sVen = strSstSls.getVen();
        String sVenName = strSstSls.getVenName();
        String sCateg = strSstSls.getCateg();
        String sSubCateg = strSstSls.getSubCateg();
        String sInvQty = strSstSls.getInvQty();
        String sInvRet = strSstSls.getInvRet();
        String sInvCost = strSstSls.getInvCost();
        String sSstVen = strSstSls.getSstVen();
        String sSstVenName = strSstSls.getSstVenName();


         out.print("\n" + sGrp);
         out.print(" - " + sGrpName);

         if(sItmLevel.equals("ITEM"))
         {
            out.print("\t" + sVen + " - " + sVenName + "\t" + sCateg + "\t" + sSubCateg + "\t" + sSstVen + " - " + sSstVenName);
         }

         out.print("\t" + sInvRet);
         out.print("\t" + sInvQty);
         out.print("\t" + sInvCost);

   }

   // Report Total
   strSstSls.setTotal();
   String sInvQty = strSstSls.getInvQty();
   String sInvRet = strSstSls.getInvRet();
   String sInvCost = strSstSls.getInvCost();

   out.print("\n Total:");
   if(sItmLevel.equals("ITEM")){ out.print("\t\t\t\t"); }

   out.print("\t" + sInvRet);
   out.print("\t" + sInvQty);
   out.print("\t" + sInvCost);

   strSstSls.disconnect();
   strSstSls = null;
%>