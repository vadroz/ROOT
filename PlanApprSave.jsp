<%@ page import="agedanalysis.PlanSave , java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("PLAN") == null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PlanApprSave.jsp&APPL=ALL&" + request.getQueryString());
}
else
{

   String [] sStore = request.getParameterValues("STORE");
   String [] sDivision = request.getParameterValues("DIVISION");
   String sDepartment = request.getParameter("DEPARTMENT");
   String sClass = request.getParameter("CLASS");
   String sChgPlan = request.getParameter("ChgPlan");
   String [] sYear = request.getParameterValues("Year");

   //System.out.println(sYear[0]  + " " + sYear[1]);
   PlanSave plans = new PlanSave(sStore, sDivision, sDepartment, sClass, sChgPlan, sYear);
   plans.disconnect();
%>

<SCRIPT language="JavaScript1.2">

goBack();


// send employee availability to schedule
function goBack()
{
  parent.returnToSelection();
}
</SCRIPT>
<%}%>