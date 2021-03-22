<%@ page import="posend.PORcvSav"%>
<%
 //----------------------------------
 // Application Authorization
 //----------------------------------
    String sPONum = request.getParameter("PO");
    String sRcvDt = request.getParameter("RcvDt");
    String sCarr = request.getParameter("Carr");
    String sBoxes = request.getParameter("Boxes");
    String sPlQty = request.getParameter("PlQty");
    String sChkDt = request.getParameter("ChkDt");
    String sRcvQty = request.getParameter("RcvQty");
    String sRcvBy = request.getParameter("RcvBy");
    String sUser = request.getParameter("User");
    String sCommt = request.getParameter("Commt");
    String [] sComplErr = request.getParameterValues("ComplErr");

    String [] sVenSty = request.getParameterValues("VenSty");
    String [] sUpc = request.getParameterValues("Upc");
    String [] sSku = request.getParameterValues("Sku");
    String [] sDesc = request.getParameterValues("Desc");
    String [] sClrNm = request.getParameterValues("ClrNm");
    String [] sSizNm = request.getParameterValues("SizNm");
    String [] sItmQty = request.getParameterValues("ItmQty");
    String [] sItmSeq = request.getParameterValues("ItmSeq");

    
    PORcvSav porcvsav = new PORcvSav();

    porcvsav.savePOHdr(sPONum, sRcvDt, sCarr, sBoxes, sPlQty, sChkDt, sRcvQty, sComplErr, sRcvBy, sCommt, sUser);

    for(int i=0; i < sVenSty.length; i++)
    {
      System.out.println("Detail - " + sVenSty[i] + "|" + sUpc[i] + " " + sSku[i] + " " + sDesc[i] + " " + sClrNm[i]  + " " + sSizNm[i] + " " + sItmQty[i] + " " + sUser);
      porcvsav.savePOItm(sVenSty[i], sUpc[i], sSku[i], sDesc[i], sClrNm[i], sSizNm[i], sItmQty[i], sItmSeq[i], sUser);
    }

    porcvsav.sendMsg();

    porcvsav.disconnect();
%>
<script>

  parent.restart();

</script>
