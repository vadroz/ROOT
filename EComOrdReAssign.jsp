<%@ page import="ecommerce.EComOrdReAssign"%>
<%
    String sSite = request.getParameter("Site");
    String sOrder = request.getParameter("Order");
    String sSku = request.getParameter("Sku");
    String sWhs = request.getParameter("Whs");
    String sQty = request.getParameter("Qty");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComOrdInfo.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    EComOrdReAssign ordreass = new EComOrdReAssign();
    ordreass.reAsgSku(sSite, sOrder, sSku, sWhs, sQty, sUser);
%>
  
<%
   ordreass.disconnect();
   }
%>
<script language="javascript">
parent.refresh();
</script>
