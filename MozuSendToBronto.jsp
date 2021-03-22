<%@ page import="java.util.*, java.text.*, mozu_com.MozuSendToBronto"%>
<%
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");

   String sSite = request.getParameter("Site");
   String sOrder = request.getParameter("Order");   

   if(sFrom==null){sFrom = "LASTDAY";}
   if(sTo==null){sTo = " ";}

   MozuSendToBronto sendBronto = new MozuSendToBronto();

   // System.out.println("From:" + sFrom);

   if(sFrom.equals("CSTINFO") ){ sendBronto.sendSingleOrderCustInfo(sSite, sOrder); }
   else if(sFrom.equals("CUSTID") ){ sendBronto.sendCustId(sSite, sOrder); }
   else if(sFrom.equals("STSORD") ){ sendBronto.sendShipToStrSingleOrder(sSite, sOrder); }
   else if(sFrom.equals("STSTOBRO") ) { sendBronto.sendShipToStrStatus(); }
   else if(sFrom.equals("SOLDOUT") ) { sendBronto.sendSoldOutMsg(); }
   else { sendBronto.sendCustInfo(sFrom, sTo); }
%>
<%
if(sFrom.equals("CSTINFO") || sFrom.equals("STSORD")){
   String sResponse = sendBronto.getResponse();
%>

<script language="javascript">
  parent.showELabResult('<%=sResponse%>', '<%=sFrom%>');
</script>

<%}%>


<%
   sendBronto.disconnect();
   sendBronto = null;
%>





