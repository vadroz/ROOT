<%@ page import="onhand01.ItemSlotEval, java.util.*,  java.text.*"%>
<%@ page contentType="application/vnd.ms-excel"%>
<%
   String sSelDiv = request.getParameter("Div");
   String sSelSku = request.getParameter("Sku");
   String sMinQty = request.getParameter("MinQty");

   //System.out.println(sSelDiv + " " + sSelSku + " " + sMinQty);
   ItemSlotEval itmbsr = new ItemSlotEval(sSelDiv,  sSelSku, sMinQty);
   int iNumOfItm = itmbsr.getNumOfItm();

   out.print( "Div\tDiv Name\tDpt\tDepartment Name\tLong Item Number\tSKU");
   out.print( "\tClass Name\tVendor Name\tColor Name\tSize Name" );
   out.print( "\tDescription\tVendor Style");
   out.print( "\tOn-hand DC\tOn-Hand Store\tOn-hand Total");
   out.print( "\tOn Order DC\tOn Order Store\tOn Order Total");
   out.print( "\tBSR DC\tBSR Store\tBSR Total\tMin Dist Lot\tUnit Sales");
   out.print( "\n");

   String t = "\t";

   for(int i=0; i < iNumOfItm ;i++)
    {
      itmbsr.setItmList();
      String sDiv = itmbsr.getDiv();
      String sDpt = itmbsr.getDpt();
      String sCls = itmbsr.getCls();
      String sVen = itmbsr.getVen();
      String sSty = itmbsr.getSty();
      String sClr = itmbsr.getClr();
      String sSiz = itmbsr.getSiz();
      String sSku = itmbsr.getSku();
      String sDesc = itmbsr.getDesc();
      String sVenSty = itmbsr.getVenSty();
      String sOnhDc = itmbsr.getOnhDc();
      String sOnhStr = itmbsr.getOnhStr();
      String sOnhTot = itmbsr.getOnhTot();
      String sOrdDc = itmbsr.getOrdDc();
      String sOrdStr = itmbsr.getOrdStr();
      String sOrdTot = itmbsr.getOrdTot();
      String sBsrDc = itmbsr.getBsrDc();
      String sBsrStr = itmbsr.getBsrStr();
      String sBsrTot = itmbsr.getBsrTot();
      String sDivNm = itmbsr.getDivNm();
      String sDptNm = itmbsr.getDptNm();
      String sClsNm = itmbsr.getClsNm();
      String sVenNm = itmbsr.getVenNm();
      String sClrNm = itmbsr.getClrNm();
      String sSizNm = itmbsr.getSizNm();
      String sMinDstLot = itmbsr.getMinDstLot();
      String sUntSls = itmbsr.getUntSls();

      out.println(sDiv + t + sDivNm + t + sDpt + t + sDptNm
          + t + sCls + "-" + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz
          + t + sSku + t + sClsNm + t + sVenNm + t + sClrNm + t + sSizNm
          + t + sDesc + t + sVenSty
          + t + sOnhDc + t + sOnhStr + t + sOnhTot
          + t + sOrdDc + t + sOrdStr + t + sOrdTot
          + t + sBsrDc + t + sBsrStr + t + sBsrTot
          + t + sMinDstLot + t + sUntSls
      );
   }

   itmbsr.disconnect();
%>
