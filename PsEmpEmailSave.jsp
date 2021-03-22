<%@ page import="payrollreports.PsEmpEmailSave"%>
<%
    String sEmp = request.getParameter("Emp");
    String sEMail = request.getParameter("EMail");
//----------------------------------
// Application Authorization
//----------------------------------
    if (session.getAttribute("USER")!=null && session.getAttribute("PAYROLL")!=null)
    {
    String sUser = session.getAttribute("USER").toString();

    //System.out.println(sEmp + "|" + sEMail);
    PsEmpEmailSave emlsav = new PsEmpEmailSave(sEmp, sEMail, sUser);
    emlsav.disconnect();
    emlsav = null;
%>
<script name="javascript1.3">

</script>
<%=sEmp%> -
<%=sEMail%>
<%

   }
   else {
%>
<script name="javascript">
  alert("Your session is expired, please sign on again.")
</script>
<%}%>


