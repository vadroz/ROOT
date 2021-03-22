<%@ page import="java.util.*, java.text.*"%>
<%
    String sRand = request.getParameter("t");
    System.out.print(sRand);
%>
<%=new java.util.Date().toString()%>
