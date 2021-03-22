<%@ page import="java.util.*, java.text.*, counterpoint.UplCustEmail, counterpoint.SendCustEmailToBronto"%>
<%
   String sDate = request.getParameter("Date");

   System.out.println("\nSendCustEmailToBronto");

   // upload data to as400 DB
   UplCustEmail  uplcust  = new UplCustEmail(sDate);
   uplcust.disconnect();
   uplcust = null;

   // send data to EmailLab
   SendCustEmailToBronto sendcust = new SendCustEmailToBronto();
   sendcust.sendCustInfo();
   sendcust = null;
%>






