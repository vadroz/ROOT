<%@ page import="emptraining.EmpTestAsgnSave, java.util.*"%>
<%
   String sEmp = request.getParameter("Emp");
   String sTest = request.getParameter("Test");

   EmpTestAsgnSave emptstsav = new EmpTestAsgnSave(sEmp, sTest);
   emptstsav.disconnect();
   emptstsav = null;
   this.finalize();
%>






