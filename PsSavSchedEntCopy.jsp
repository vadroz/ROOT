<%@ page import="payrollreports.PsSavSchedEntCopy, java.util.*"%>
<% // Get query string parameters
   String sStore = request.getParameter("STORE");
   String sWeekEnd = request.getParameter("WEEKEND");

   String sCpyEmp = request.getParameter("CPYEMP");
   String sCpyGrp = request.getParameter("CPYGRP");
   String sCpyDay = request.getParameter("CPYDAY");

   String sToEmp = request.getParameter("TOEMP");
   String sToGrp = request.getParameter("TOGRP");
   String sToDay = request.getParameter("TODAY");
   String sKey = request.getParameter("Key");

   String sAction = request.getParameter("ACTION");

   if (sKey == null || sKey.equals("")){ sKey = " ";}

   //------------------------------------------------------------------------------------------------------
   // Application Authorization
   //------------------------------------------------------------------------------------------------------
   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")!=null && session.getAttribute(sAppl)!=null)
   {
     String sUser = session.getAttribute("USER").toString();

     PsSavSchedEntCopy savecpyh = new PsSavSchedEntCopy();
     savecpyh.saveCopiedHours(sStore, sWeekEnd, sCpyEmp, sCpyGrp, sCpyDay,
              sToEmp, sToGrp, sToDay, sKey, sUser);

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
 else
 {
    var msg =""
    for(var i=0; i < Error.length; i++) { msg += "\n" + Error[i] }
    alert(msg);
 }
</script>

<%}
else {%>alert("Your session is expired. Please, sign on again.")<%}%>
