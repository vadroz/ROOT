<%@ page import="java.util.*"%>
<%
   String sSite = request.getParameter("Site");
   System.out.println(sSite);
   response.sendRedirect(sSite);
%>
