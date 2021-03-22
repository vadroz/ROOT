<%@ page import="java.util.*, java.text.*, ecommerce.EComSendToELab"%>
<%
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");

   String sSite = request.getParameter("Site");
   String sOrder = request.getParameter("Order");

   if(sFrom==null){sFrom = "LASTDAY";}
   if(sTo==null){sTo = " ";}

   EComSendToELab sendelab = new EComSendToELab();

   // System.out.println("From:" + sFrom);

   if(sFrom.equals("CSTINFO") ){ sendelab.sendSingleOrderCustInfo(sSite, sOrder); }
   if(sFrom.equals("STSORD") ){ sendelab.sendShipToStrSingleOrder(sSite, sOrder); }
   else if(sFrom.equals("STSTOELB") ) { sendelab.sendShipToStrStatus(); }
   else { sendelab.sendCustInfo(sFrom, sTo); }
%>
<%
if(sFrom.equals("CSTINFO") || sFrom.equals("STSORD")){
   String sResponse = sendelab.getResponse();
%>

<script language="javascript">
  parent.showELabResult('<%=sResponse%>', '<%=sFrom%>');
</script>

<%}%>


<%
   sendelab.disconnect();
   sendelab = null;
%>





