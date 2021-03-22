<%@ page import="java.util.*, java.text.*, ecommerce.EComSendToELab"%>
<%
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");
   if(sFrom==null){sFrom = "LASTDAY";}
   if(sTo==null){sFrom = " ";}

   EComSendToELab sendelab = new EComSendToELab(sFrom, sTo);   
   sendelab.disconnect();
   sendelab = null;
%>






