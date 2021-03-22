<%@ page import="payrollreports.PsSavSchedSubstitute, java.util.*"%>
<% // Get query string parameters
   String sStore = request.getParameter("STORE");
   String sWeekEnd = request.getParameter("WEEKEND");

   String sCpyEmp = request.getParameter("CPYEMP");
   String sCpyGrp = request.getParameter("CPYGRP");

   String sToEmp = request.getParameter("TOEMP");
   String sDays = request.getParameter("DAYS");
   String sAction = request.getParameter("ACTION");

   //------------------------------------------------------------------------------------------------------
   // Application Authorization
   //------------------------------------------------------------------------------------------------------
   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")!=null && session.getAttribute(sAppl)!=null)
   {
     String sUser = session.getAttribute("USER").toString();
     PsSavSchedSubstitute savecpyh = new PsSavSchedSubstitute();
     //System.out.println(sStore + "\n" + sWeekEnd + "\n" + sCpyEmp + "\n" + sCpyGrp + "\n"
     //   + sToEmp + "\n" + sDays + "\n" + sUser);

     savecpyh.saveSubstitute(sStore, sWeekEnd, sCpyEmp, sCpyGrp, sToEmp, sDays, sUser);
     String sError = savecpyh.getErrorJsa();

     savecpyh.disconnect();
     savecpyh = null;
 %>

<script language="javascript">
 var Error = [<%=sError%>];
 if(Error.length == 0)
 {
    parent.reloadPage();
 }
 else {

    var msg =""
    for(var i=0; i < Error.length; i++) { msg += "\n" + Error[i] }
    alert(msg);
 }
</script>

<%}
else {%>alert("Your session is expired. Please, sign on again.")<%}%>
