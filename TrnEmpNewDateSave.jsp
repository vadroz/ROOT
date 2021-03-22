<%@ page import="emptraining.TrnEmpNewDateSave , java.util.*"%>
<%
   String sEmp = request.getParameter("Emp");
   String sNewDate = request.getParameter("NewDate");
   String sReason = request.getParameter("Reason");
   String sAction = request.getParameter("Action");

   if(sReason == null) sReason = " ";

//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null && session.getAttribute("TRNCHGDT")!=null)
{
     String sUser = session.getAttribute("USER").toString();
     TrnEmpNewDateSave savnewdt = new TrnEmpNewDateSave(sEmp, sNewDate, sReason, sAction, sUser);
}
%>

<SCRIPT language="JavaScript1.2">
<%if  (session.getAttribute("USER")!=null){%>

    goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
   function goBack()
   {
      parent.restart();
   }
<%}
  else {%>
     alert("Your internet session is expired or You are not authorized.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>
</SCRIPT>







