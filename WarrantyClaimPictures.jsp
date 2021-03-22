<%@ page import="patiosales.WarrantyClaimPictures ,java.util.*, java.text.*"%>
<%
   String sSelOrder = request.getParameter("Order");
   String sAction = request.getParameter("Action");
   String sSelClaim = request.getParameter("Claim");
   String sItem = request.getParameter("Item");
   String sSku = request.getParameter("Sku");
   String sVen = request.getParameter("Ven");
   String sVenNm = request.getParameter("VenNm");
   String sVenSty = request.getParameter("VenSty");

//----------------------------------
// Application Authorization
//----------------------------------
String sUser = session.getAttribute("USER").toString();

if (session.getAttribute("USER")!=null)
{
   WarrantyClaimPictures wcclmpic = new WarrantyClaimPictures();
    wcclmpic.rtvItemPictures(sSelOrder, sSelClaim, sItem, sAction, sUser);

    int iNumOfPic = wcclmpic.getNumOfPic();
    String sPicJva = wcclmpic.getPicJva();

    wcclmpic.disconnect();
    wcclmpic = null;

    sVenSty = sVenSty.replaceAll("\"", "&#34;");
%>

<SCRIPT language="JavaScript1.2">
var Item = "<%=sItem%>";
var Sku = "<%=sSku%>";
var Ven = "<%=sVen%>";
var VenNm = "<%=sVenNm%>";
var VenSty = "<%=sVenSty%>";
var Action = "<%=sAction%>";
var Pic = [<%=sPicJva%>];

parent.setPictures(Item, Sku, Ven, VenNm, VenSty, Pic);

</SCRIPT>

<%
}
else {%>
<SCRIPT language="JavaScript1.2">
 alert("You are not authorized to get pictures.")
</SCRIPT>
<%}%>






