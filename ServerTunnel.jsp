<%@ page import="java.util.*"%>
<%
   String sTest = request.getParameter("Test");
   if (sTest==null) sTest = "Empty";
   out.print("JSP ===> " + sTest + " :End");
   out.flush();
%>

