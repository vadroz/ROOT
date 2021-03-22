<%@ page import="payrollreports.StrDlyToDoSave, java.util.*"%>
<%
   String sStore = request.getParameter("Store");
   String sDate = request.getParameter("Date");
   String sEmp = request.getParameter("Emp");
   String sGroup = request.getParameter("Group");
   String sAction = request.getParameter("Action");

   if (session.getAttribute("USER")!=null )
   {
     String sUser = session.getAttribute("USER").toString();

     StrDlyToDoSave savgrp = new StrDlyToDoSave(sStore, sDate, sEmp, sGroup, sAction, sUser);
%>

<SCRIPT language="JavaScript">
parent.restart()
</script>
<%
   savgrp.disconnect();
   savgrp = null;
}%>