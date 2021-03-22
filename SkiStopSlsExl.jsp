<%@ page import="flashreps.SkiStopSales ,java.util.*, java.text.*"%>
<%
   response.setContentType("application/vnd.ms-excel");
   String sDiv = request.getParameter("Div");
   String sDpt = request.getParameter("Dpt");
   String sCls = request.getParameter("Cls");
   String sVendor = request.getParameter("Ven");
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");
   String sItmLevel = request.getParameter("ItmLevel");
   String sDatLevel = request.getParameter("DatLevel");
   String sUser = session.getAttribute("USER").toString();

   SkiStopSales strSstSls = new SkiStopSales(sDiv, sDpt, sCls, sVendor, sFrom, sTo, sItmLevel, sDatLevel, sUser);
   int iNumOfGrp = strSstSls.getNumOfGrp();
   String sSelFrom = strSstSls.getSelFrom();
   String sSelTo = strSstSls.getSelTo();

   String sColName = null;
   if(sItmLevel.equals("DIV")){ sColName = "Division";}
   else if(sItmLevel.equals("DPT")){ sColName = "Department";}
   else if(sItmLevel.equals("CLS")){ sColName = "Class";}
   else if(sItmLevel.equals("VEN")){ sColName = "Vendor";}
   else if(sItmLevel.equals("ITEM")){ sColName = "Item";}
   else if(sItmLevel.equals("SUBCAT")){ sColName = " ";}
   else { sColName = "";}

   out.println("\t\t\t Retail Concepts, Inc" );
   out.println("\t\t\t Store 86 Sales Summary" );
   out.println("Selection:\t Div: " + sDiv + "\t Dpt: " + sDpt + "\t Cls: " + sCls + "\t Ven: " + sVendor);
   out.println("Dates:\t From: " + sSelFrom + "\t To: " + sSelTo);
   out.print("\n Period \t" + sColName);

   if(sItmLevel.equals("SUBCAT")){ out.print(" \t Category \t Sub-Category "); }
   else if(sItmLevel.equals("ITEM")){out.print(" \t Category \t Sub-Category \t Vendor \t Ski Stop Vendor"); }

   out.print("\t Ret \t Qty \t Cost \t P.O. Ret \t P.O. Qty \t P.O. Cost \t Gross Margin \t GM%");
   out.print("\t Inv.Ret \t Inv.Qty \t Inv.Cost ");


   for(int i=0; i < iNumOfGrp; i++)
   {
      strSstSls.setSalesInfo();
        String sPeriod = strSstSls.getPeriod();
        String sGrp = strSstSls.getGrp();
        String sGrpName = strSstSls.getGrpName();
        String sQty = strSstSls.getQty();
        String sRet = strSstSls.getRet();
        String sCost = strSstSls.getCost();
        String sPeriodBreak = strSstSls.getPeriodBreak();
        String sPoQty = strSstSls.getPoQty();
        String sPoRet = strSstSls.getPoRet();
        String sPoCost = strSstSls.getPoCost();
        String sVen = strSstSls.getVen();
        String sVenName = strSstSls.getVenName();
        String sCateg = strSstSls.getCateg();
        String sSubCateg = strSstSls.getSubCateg();
        String sGrsMrg = strSstSls.getGrsMrg();
        String sGrsMrgPrc = strSstSls.getGrsMrgPrc();
        String sInvQty = strSstSls.getInvQty();
        String sInvRet = strSstSls.getInvRet();
        String sInvCost = strSstSls.getInvCost();
        String sSstVen = strSstSls.getSstVen();
        String sSstVenName = strSstSls.getSstVenName();

      if (!sItmLevel.equals("NONE") || sPeriodBreak.equals("1"))
      {
         out.print("\n" + sPeriod);
         if(!sItmLevel.equals("SUBCAT"))
         {
            out.print("\t " + sGrp);
            if (!sPeriodBreak.equals("1")) { out.print(" - " + sGrpName); }
         }
         else
         {
            out.print("\t\t" + sCateg + "\t" + sSubCateg);
         }

         if(sItmLevel.equals("ITEM"))
         {
            out.print("\t" + sCateg + "\t" + sSubCateg + "\t" + sVen + " - " + sVenName + "\t" + sSstVen + " - " + sSstVenName);
         }

         out.print("\t" + sRet);
         out.print("\t" + sQty);
         out.print("\t" + sCost);
         out.print("\t" + sPoRet);
         out.print("\t" + sPoQty);
         out.print("\t" + sPoCost);
         out.print("\t" + sGrsMrg);
         out.print("\t" + sGrsMrgPrc + "%");
         out.print("\t" + sInvRet);
         out.print("\t" + sInvQty);
         out.print("\t" + sInvCost);
      }
   }

   // Report Total
   strSstSls.setTotal();
   String sQty = strSstSls.getQty();
   String sRet = strSstSls.getRet();
   String sCost = strSstSls.getCost();
   String sPoQty = strSstSls.getPoQty();
   String sPoRet = strSstSls.getPoRet();
   String sPoCost = strSstSls.getPoCost();
   String sGrsMrg = strSstSls.getGrsMrg();
   String sGrsMrgPrc = strSstSls.getGrsMrgPrc();
   String sInvQty = strSstSls.getInvQty();
   String sInvRet = strSstSls.getInvRet();
   String sInvCost = strSstSls.getInvCost();

   out.print("\n Total:\t");
   if(sItmLevel.equals("SUBCAT")){ out.print("\t\t"); }
   else if(sItmLevel.equals("ITEM")){ out.print("\t\t\t"); }

   out.print("\t" + sRet);
   out.print("\t" + sQty);
   out.print("\t" + sCost);
   out.print("\t" + sPoRet);
   out.print("\t" + sPoQty);
   out.print("\t" + sPoCost);
   out.print("\t" + sGrsMrg);
   out.print("\t" + sGrsMrgPrc + "%");
   out.print("\t" + sInvRet);
   out.print("\t" + sInvQty);
   out.print("\t" + sInvCost);

   strSstSls.disconnect();
   strSstSls = null;
%>