<%@ page import="payrollreports.BaseSchedWkAdjSave, java.util.*, java.text.*"%>
<%
   String sWkend = request.getParameter("Wkend");
   String [] sStr = request.getParameterValues("Str");
   String [] sSls = request.getParameterValues("Sls");
   String [] sHrs = request.getParameterValues("Hrs");
   String sUser = session.getAttribute("USER").toString();

   String sAppl = "PAYROLL";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
 && !session.getAttribute("APPLICATION").equals(sAppl))
{
   response.sendRedirect("SignOn1.jsp?TARGET=BaseSchedWkAdjSaveSel.jsp&APPL=" + sAppl);
}
else
{
   //System.out.println(sWkend + "|" + sStr + "|" + sSls + "|" + sHrs);
   BaseSchedWkAdjSave bswkadj = new BaseSchedWkAdjSave(sWkend, sStr, sSls, sHrs, sUser);
%>
<SCRIPT language="JavaScript">
//==============================================================================
// Global variables
//==============================================================================
alert("Base schedule adjustments have been saved.")
parent.returnToSelect();
</script>

<%
  bswkadj.disconnect();
  bswkadj = null;
%>
<%}%>






