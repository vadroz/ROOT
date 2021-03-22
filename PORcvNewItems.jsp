<%@ page import="posend.PORcvNewItems, java.util.*"%>
<%
 //----------------------------------
 // Application Authorization
 //----------------------------------

 if (session.getAttribute("USER")!=null)
 {
    String sPONum = request.getParameter("PO");
    String sUser = session.getAttribute("USER").toString();


    PORcvNewItems subsitm = new PORcvNewItems(sPONum, sUser);
    int iNumOfItm = subsitm.getNumOfItm();
%>

<script language="javascript">
var RcvDt = new Array();
var VenSty = new Array();
var Upc = new Array();
var Sku = new Array();
var Desc = new Array();
var ClrNm = new Array();
var SizNm = new Array();
var RcvQty = new Array();
var Init = new Array();

<%for(int i=0; i < iNumOfItm; i++)
  {
       subsitm.setPOSbsList();
       String sRcvDt = subsitm.getRcvDt();
       String sVenSty = subsitm.getVenSty();
       String sUpc = subsitm.getUpc();
       String sSku = subsitm.getSku();
       String sDesc = subsitm.getDesc();
       String sClrNm = subsitm.getClrNm();
       String sSizNm = subsitm.getSizNm();
       String sRcvQty = subsitm.getRcvQty();
       String sInit = subsitm.getInit();
%>
  RcvDt[<%=i%>] = "<%=sRcvDt%>";
  VenSty[<%=i%>] = "<%=sVenSty%>";
  Upc[<%=i%>] = "<%=sUpc%>";
  Sku[<%=i%>] = "<%=sSku%>";
  Desc[<%=i%>] = "<%=sDesc%>";
  ClrNm[<%=i%>] = "<%=sClrNm%>";
  SizNm[<%=i%>] = "<%=sSizNm%>";
  RcvQty[<%=i%>] = "<%=sRcvQty%>";
  Init[<%=i%>] = "<%=sInit%>";
<%}%>

  parent.showSubstitutions(RcvDt, VenSty, Upc, Sku, Desc, ClrNm, SizNm, RcvQty, Init);

</script>

<% subsitm.disconnect();
} else {%>
<script language="javascript">
  alert("Please refresh your screen and sign on");
</script>
<%}%>