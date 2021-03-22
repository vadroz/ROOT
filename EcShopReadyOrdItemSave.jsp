<%@ page import="ecommerce.EcShopReadyOrdItemSave, java.util.*, java.sql.*"%>
<%
   String sOrder = request.getParameter("Order");
   String sItem = request.getParameter("Item");
   String sCls = request.getParameter("Cls");
   String sVen = request.getParameter("Ven");
   String sSty = request.getParameter("Sty");
   String sClr = request.getParameter("Clr");
   String sSiz = request.getParameter("Siz");

if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
{
    response.sendRedirect("SignOn1.jsp?TARGET=EcShopReadyOrdItemSave.jsp&APPL=ALL");
}
else
{
    String sUser = session.getAttribute("USER").toString();

    EcShopReadyOrdItemSave orditmsv = new EcShopReadyOrdItemSave(sOrder, sItem, sCls, sVen,
                sSty, sClr, sSiz, sUser );

    String sError = orditmsv.getError();

%>
<script language="javascript">
var Error = "<%=sError%>";

parent.saveItemsResult(Error);

</script>

<%
  orditmsv.disconnect();
  orditmsv = null;
  }
%>
