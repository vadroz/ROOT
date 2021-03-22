<%@ page import="onhand01.ItemBSR ,java.util.*, java.text.*"%>
<%
   response.setContentType("application/vnd.ms-excel");

   String sSrchDiv = request.getParameter("Div");
   String sSrchDpt = request.getParameter("Dpt");
   String sSrchCls = request.getParameter("Cls");
   String sSrchVen = request.getParameter("Ven");

   String sFile = "filename=";
   if (!sSrchDiv.equals("ALL")) sFile = sFile + "Div" + sSrchDiv.trim();
   if (!sSrchDpt.equals("ALL")) sFile = sFile + "Dpt" + sSrchDpt.trim();
   if (!sSrchCls.equals("ALL")) sFile = sFile + "Cls" + sSrchCls.trim();
   if (!sSrchVen.equals("ALL")) sFile = sFile + "Ven" + sSrchVen.trim();

   response.setHeader("content-disposition", sFile);


   ItemBSR itmbsr = new ItemBSR(sSrchDiv, sSrchDpt, sSrchCls, sSrchVen);
   int iNumOfItm = itmbsr.getNumOfItm();

   out.print("Div\tDpt\tCategory\tSubcategory\tManufacturer\tName\tHeight\tWidth\tDepth"
           + "\tColor \tSize \tPrice\tUnit Cost \t");
   out.print("1\t3\t4\t5\t8\t10\t11\t20\t28\t30\t35\t40\t45\t46\t50\t61\t70\t82\t88\t98");
   out.print("\tLong SKU\tID\tClass#\tColor#\tSize#\n");


   for(int i=0; i < iNumOfItm; i++)
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
      String sDptName = itmbsr.getDptName();
      String sClsName = itmbsr.getClsName();
      String sVenName = itmbsr.getVenName();
      String sClrName = itmbsr.getClrName();
      String sSizName = itmbsr.getSizName();
      String sRet = itmbsr.getRet();
      String sCost = itmbsr.getCost();
      int iNumOfStr = itmbsr.getNumOfStr();
      String [] sStock = itmbsr.getStock();
      String sHeight = itmbsr.getHeight();
      String sWidth = itmbsr.getWidth();
      String sLength = itmbsr.getLength();
      String sWeight = itmbsr.getWeight();

      out.print(sDiv);
      out.print("\t" + sDpt);
      out.print("\t" + sDptName);
      out.print("\t" + sClsName);
      out.print("\t" + sVenName);
      out.print("\t" + sDesc + " " + sClrName + " " + sSizName);
      out.print("\t" + sHeight + "\t" + sWidth + "\t" + sLength);
      out.print("\t" + sClrName);
      out.print("\t" + sSizName);
      out.print("\t" + sRet);
      out.print("\t" + sCost);

      for(int j=0; j < iNumOfStr; j++) { out.print("\t" + sStock[j]); }

      out.print("\t" + sCls + " " + sVen + " " + sSty + " " + sClr + " " + sSiz);
      out.print("\t" + sSku);
      out.print("\t" + sCls);
      out.print("\t" + sClr);
      out.print("\t" + sSiz + "\n");
   }

   itmbsr.disconnect();
%>