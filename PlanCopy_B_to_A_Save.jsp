<%@ page import="agedanalysis.PlanCopy_B_to_A_Save , java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("PLNAPPROVE") == null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PlanCopy_B_to_A_Save.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   String [] sDiv = request.getParameterValues("Div");
   String [] sYear = request.getParameterValues("Year");
   PlanCopy_B_to_A_Save plans = new PlanCopy_B_to_A_Save(sDiv, sYear, session.getAttribute("USER").toString());
%>

<SCRIPT language="JavaScript1.2">
goBack();

// send employee availability to schedule
function goBack()
{
  parent.redisplayPlanCopy();
}
</SCRIPT>
<%}%>