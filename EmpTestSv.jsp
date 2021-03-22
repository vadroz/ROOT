<%@ page import="emptraining.EmpTestSv, java.util.*"%>
<%
   String sEmp = request.getParameter("Emp");
   String sTest = request.getParameter("Test");
   String sAttDate = request.getParameter("AttDate");
   String sScore = request.getParameter("Score");
   String sScrPrc = request.getParameter("ScrPrc");
   String sAction = request.getParameter("Action");


   EmpTestSv emptstsav = new EmpTestSv(sEmp, sTest, sAttDate, sScore, sScrPrc, sAction);

   emptstsav.disconnect();
   emptstsav = null;
%>
<script language="javascript">
  parent.window.location.reload();
</script>





