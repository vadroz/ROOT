<%@ page import="ecommerce.EcShopReadyOrdDtl, java.util.*, java.sql.*"%>
<%
   String sOrder = request.getParameter("Order");

if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
{
    response.sendRedirect("SignOn1.jsp?TARGET=EcShopReadyOrdDtl.jsp&APPL=ALL");
}
else
{
    String sUser = session.getAttribute("USER").toString();

    EcShopReadyOrdDtl readyorditm = new EcShopReadyOrdDtl(sOrder, sUser);

    int iNumOfItm = readyorditm.getNumOfItm();
    String sItem = readyorditm.getItem();
    String sQty = readyorditm.getQty();
    String sPrice = readyorditm.getPrice();
    String sPart = readyorditm.getPart();

    String sCls = readyorditm.getCls();
    String sVen = readyorditm.getVen();
    String sSty = readyorditm.getSty();
    String sClr = readyorditm.getClr();
    String sSiz = readyorditm.getSiz();
    String sVenSty = readyorditm.getVenSty();
    String sName = readyorditm.getName();
%>
<script language="javascript">
var Item = [<%=sItem%>];
var Qty = [<%=sQty%>];
var Price = [<%=sPrice%>];
var Part = [<%=sPart%>];
var Cls = [<%=sCls%>];
var Ven = [<%=sVen%>];
var Sty = [<%=sSty%>];
var Clr = [<%=sClr%>];
var Siz = [<%=sSiz%>];
var VenSty = [<%=sVenSty%>];
var Name = [<%=sName%>];

parent.showItems(Item, Qty, Price, Part, Cls, Ven, Sty, Clr, Siz, VenSty, Name);

</script>

<%
  readyorditm.disconnect();
  readyorditm = null;
  }
%>
