<%@ page import="java.util.*, java.text.*"%>
<%
   response.setContentType("application/vnd.ms-excel");
   String sContent = request.getParameter("Content");
   
   
   out.println("Retail Concepts, Inc" );
   out.println("<br>Coupon Sales List" );
   
   out.println(sContent);
   
%>