<%@ page import="emptraining.EmpTestQASave, java.util.*"%>
<%
   String sEmp = request.getParameter("Emp");
   String sTest = request.getParameter("Test");
   String sScore = request.getParameter("Score");
   String sScrPrc = request.getParameter("ScrPrc");

   EmpTestQASave testqasv = new EmpTestQASave(sEmp, sTest, sScore, sScrPrc);
   testqasv.disconnect();
   testqasv = null;
%>




