<%@ page import="java.util.*, java.text.*, ecommerce.EComUPS_Add"%>
<%
   String sOrder = request.getParameter("Order");
   String sSite = request.getParameter("Site");

   if(sOrder == null ) { sOrder = "ALL"; }
   if(sSite == null ) { sSite = " "; }

   EComUPS_Add  ups_add  = new EComUPS_Add();

   if(sOrder.equals("ALL")) { ups_add.rtvAllOrders(); }
   else { ups_add.rtvSingleOrder(sSite, sOrder); }

   ups_add.disconnect();
   ups_add = null;
%>

<%if(!sOrder.equals("ALL")) {%>
  <script language="javascript">
    alert("The order Information have been loaded to UPS file.")
  </script>
<%}%>




