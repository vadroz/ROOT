<%@ page import="java.util.*, java.text.*, counterpoint.UplCustEmail, counterpoint.SendCustEmailToElab"%>
<%
   String sDate = request.getParameter("Date");

   // upload data to as400 DB
   UplCustEmail  uplcust  = new UplCustEmail(sDate);
   uplcust.disconnect();
   uplcust = null;

   // send data to EmailLab
   SendCustEmailToElab sendcust = new SendCustEmailToElab();
   sendcust.sendCustInfo();
   sendcust = null;
%>






