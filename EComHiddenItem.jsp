<%@ page import="ecommerce.EComHiddenItem, java.util.*"%>
<%@ page contentType="application/vnd.ms-excel"%>
<%

//-------------------- populate class/store arrays -----------------------------
     EComHiddenItem hiditm = new EComHiddenItem();


    out.println( "Div\tClass\tClass Name\tVendor\tStyle\tColor\tSize\tSKU\tLoc\tUnloc(File)"
       + "\tUnloc(Calc)\tStk Ldgr On Hand\tStr 70 Retail\tEcom File Price\tName\tRetail Loc\tRetail Unloc");
    while(hiditm.getNext())
    {
       hiditm.setDetail();
       int iNumOfItm = hiditm.getNumOfItm();

       String [] sDiv = hiditm.getDiv();
       String [] sCls = hiditm.getCls();
       String [] sClsName = hiditm.getClsName();
       String [] sVen = hiditm.getVen();
       String [] sSty = hiditm.getSty();
       String [] sClr = hiditm.getClr();
       String [] sSiz = hiditm.getSiz();
       String [] sWhseQty = hiditm.getWhseQty();
       String [] sPendQty = hiditm.getPendQty();
       String [] sStrQty = hiditm.getStrQty();
       String [] sStrPrc = hiditm.getStrPrc();
       String [] sEcPrc = hiditm.getEcPrc();
       String [] sName = hiditm.getName();
       String [] sUnloc = hiditm.getUnloc();
       String [] sLocRet = hiditm.getLocRet();
       String [] sUnlRet = hiditm.getUnlRet();
       String [] sSku = hiditm.getSku();

       for(int i=0; i < iNumOfItm; i++)
       {
          out.println(sDiv[i]
            + "\t" + sCls[i]
            + "\t" + sClsName[i]
            + "\t" + sVen[i]
            + "\t" + sSty[i]
            + "\t" + sClr[i]
            + "\t" + sSiz[i]
            + "\t" + sSku[i]
            + "\t" + sWhseQty[i]
            + "\t" + sPendQty[i]
            + "\t" + sUnloc[i]
            + "\t" + sStrQty[i]
            + "\t" + sStrPrc[i]
            + "\t" + sEcPrc[i]
            + "\t" + sName[i]
            + "\t" + sLocRet[i]
            + "\t" + sUnlRet[i]
          );
       }
    }

  hiditm.disconnect();
  hiditm = null;
%>

