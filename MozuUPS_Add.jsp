<%@ page import="java.util.*, java.text.*, mozu_com.MozuUPS_Add"%>
<%
   String sOrder = request.getParameter("Order");
   String sSite = request.getParameter("Site");

   if(sOrder == null ) { sOrder = "ALL"; }
   if(sSite == null ) { sSite = " "; } 

   MozuUPS_Add  ups_add  = new MozuUPS_Add();

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




