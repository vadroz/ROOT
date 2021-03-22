<%@ page import="rtvregister.RtvRegList, rtvregister.RtvReasonCode, java.util.*, java.text.SimpleDateFormat"%>
<%@page contentType="application/vnd.ms-excel"%>
<%
      boolean bBuyer = false;
      if(session.getAttribute("RTVREGBUYR") != null) bBuyer = true;


      String sStore = request.getParameter("Store");
      String sStrName = request.getParameter("StrName");
      String sDivision = request.getParameter("Division");
      String sDivisionName = request.getParameter("DivName");
      String sVendor = request.getParameter("Vendor");
      String sReason = request.getParameter("Reason");
      String sFrDate = request.getParameter("FrDate");
      String sAction = request.getParameter("Action");
      String sSort = request.getParameter("Sort");

      if(sSort==null) sSort = "VEN";

      //System.out.print(sStore + "|" + sDivision + "|" + sVendor + "|" + sReason + "|" + sFrDate + "|" + sAction + "|" + sSort + "|");
      RtvRegList rtvreg = new RtvRegList(sStore, sDivision,  sVendor, sReason, sFrDate, sAction, sSort);

      int iNumOfItm = rtvreg.getNumOfItm();
      int iNumOfStr = rtvreg.getNumOfStr();

      RtvReasonCode reasCode = new RtvReasonCode();
      String sReasonLst = reasCode.getReasonCode();
      String sReasonDesc = reasCode.getReasonDesc();

      // get vendor name
      rtvreg.setItem();


      Calendar cal = Calendar.getInstance();
      SimpleDateFormat sdfmt = new SimpleDateFormat("MM-dd-yyyy");
      System.out.println(sdfmt.format(cal.getTime()));
%>
<%if (!sVendor.equals("ALL")){%><%=rtvreg.getVenName()%><%}%>
<%=sdfmt.format(cal.getTime())%>
<%
  out.print("\nShort Sku" + "\tDescription" + "\tVendor Style" + "\tColor Name" + "\tSize Name"
  + "\tReason" + "\tComment");
%>

<%
    for(int i=0; i < iNumOfItm; i++ )
    {
       if(i > 0) { rtvreg.setItem();}
       String sStrLst = rtvreg.getStr();
       String sCls = rtvreg.getCls();
       String sVen = rtvreg.getVen();
       String sSty = rtvreg.getSty();
       String sClr = rtvreg.getClr();
       String sSiz = rtvreg.getSiz();
       String sSeq = rtvreg.getSeq();
       String sReasonName = rtvreg.getReason();
       String sComment = rtvreg.getComment();
       String sSku = rtvreg.getSku();
       String sUpc = rtvreg.getUpc();
       String sDesc = rtvreg.getDesc();
       String sClrName = rtvreg.getClrName();
       String sSizName = rtvreg.getSizName();
       String sVenName = rtvreg.getVenName();
       String sVenSty = rtvreg.getVenSty();
       String sDocNum = rtvreg.getDocNum();
       String sClsName = rtvreg.getClsName();
       String sDiv = rtvreg.getDiv();
       String sDivName = rtvreg.getDivName();

       String sRaNum = rtvreg.getRaNum();
       String sMarkOutStock = rtvreg.getMarkOutStock();
       String sRecall = rtvreg.getRecall();
       String sRgDate = rtvreg.getRgDate();
       String sRgTime = rtvreg.getRgTime();
       String sRgUser = rtvreg.getRgUser();
       String sRaDate = rtvreg.getRaDate();
       String sRaTime = rtvreg.getRaTime();
       String sRaUser = rtvreg.getRaUser();
       String sCost = rtvreg.getCost();
       String sLstRcpt = rtvreg.getLstRcpt();
       String sDefect = rtvreg.getDefect();

       out.print(
          "\n" + sSku
        + "\t" + sDesc.trim()
        + "\t" + sVenSty.trim()
        + "\t" + sClrName.trim()
        + "\t" + sSizName.trim()
        + "\t" + sReasonName.trim()
        + "\t" + sComment.trim()
        );
}%>

<%
    rtvreg.disconnect();
    rtvreg=null;
%>



