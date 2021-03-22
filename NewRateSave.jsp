<%@ page import="employeecenter.NewRateSave , java.util.*"%>
<%
   String sEmp = request.getParameter("Emp");
   String sRate = request.getParameter("Rate");
   String sNewDept = request.getParameter("NewDept");
   String sPerf = request.getParameter("Perf");
   String sLead = request.getParameter("Lead");
   String sPotenl = request.getParameter("Potenl");
   String sAction = request.getParameter("Action");
   String sLock = request.getParameter("Lock");
   String [] sStore = request.getParameterValues("Str");
   String [] sDept = request.getParameterValues("Dept");
   String [] sTtl = request.getParameterValues("Ttl");
   String sSph = request.getParameter("Sph");

   if(sPerf == null){ sPerf = " "; }
   if(sLead == null){ sLead = " "; }
   if(sPotenl == null){ sPotenl = " "; }
   if(sNewDept == null){ sNewDept = " "; }
   if(sLock == null || sLock.equals("")){ sLock = " "; }

//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null && session.getAttribute("EMPSALARY")!=null)
{
   NewRateSave savrate = new NewRateSave();

   String sUser = session.getAttribute("USER").toString();
   if(sAction.equals("CHECKALL"))
   {
      savrate.markedAll(sStore, sDept, sTtl, sAction, sUser);
   }
   else if(sAction.equals("SAVSPH"))
   {
      savrate.saveSPH(sEmp, sSph, sAction, sUser);
   }
   else if(sAction.equals("CHGLOCKSTS"))
   {
      savrate.saveLockdown(sStore[0], sLock, sAction, sUser);
   }
   else
   {
      savrate.saveEmployee(sEmp, sRate, sNewDept, sPerf, sLead, sPotenl, sAction, sUser);
   }
   savrate.disconnect();
}
%>

<SCRIPT language="JavaScript1.2">
<%if  (session.getAttribute("USER")!=null){%>
   goBack();
<%} else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
<%}%>
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
   parent.restart();
}
</SCRIPT>







