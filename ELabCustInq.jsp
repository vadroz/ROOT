<%@ page import="java.util.*, java.text.*, ecommerce.EComSendToELab"%>
<%
   String sSite = request.getParameter("Site");
   String sCustEMail = request.getParameter("CustEmail");

   String sMailId = null;
   if(sSite.equals("SASS")){ sMailId = "5797"; }
   else if(sSite.equals("SKCH")){ sMailId = "6046"; }
   else if(sSite.equals("RLHD")){ sMailId = "6037"; }
   else if(sSite.equals("SSTP")){ sMailId = "7146"; }

   EComSendToELab custInq = new EComSendToELab();
   custInq.getCustStatus(sCustEMail, sMailId);

   String sResponse = custInq.getResponse();

   custInq = null;
%>

<%=sResponse%>



