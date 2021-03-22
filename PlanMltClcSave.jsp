<%@ page import="agedanalysis.PlanMltClcSave , java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("PLAN") == null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PlanSave.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   String [] sStore = request.getParameterValues("Str");
   String sClass = request.getParameter("Cls");
   String [] sPrc = request.getParameterValues("Prc");
   String sChgPlan = request.getParameter("AlwChg");
   String sSelYear = request.getParameter("Year");
   String sClcBase = request.getParameter("ClcBase");
   String sCateg = request.getParameter("Categ");

   //System.out.println("\n" + sStore[0] + "|" + sClass + "|" + sClcBase + "|" + sSelYear + "|" + sCateg + "|" + sChgPlan);
   //for(int i=0; i < sPrc.length; i++)  {   System.out.print(" " + sPrc[i]);  }

   PlanMltClcSave plansv = new PlanMltClcSave(sStore, sClass, sClcBase, sPrc, sSelYear, sCateg, sChgPlan);
   plansv.disconnect();
   plansv = null;
%>

<SCRIPT language="JavaScript1.2">
goBack();

// send employee availability to schedule
function goBack()
{
  parent.sbmPlan();
}
</SCRIPT>
<%}%>