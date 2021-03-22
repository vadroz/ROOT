<%@ page import="payrollreports.PrChgSlsGoal"%>
<%
    String sStr = request.getParameter("Str");
    String sWkend = request.getParameter("Wkend");
    String sDay = request.getParameter("Day");
    String sGoal = request.getParameter("Goal");
    String sAction = request.getParameter("Action");
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null && session.getAttribute("PAYROLL")!=null)
{
    String sUser = session.getAttribute("USER").toString();
    PrChgSlsGoal chggoal = new PrChgSlsGoal(sStr, sWkend, sDay, sGoal, sAction, sUser);
    String sError = chggoal.getError();
%>
<script name="javascript1.3">
//------------------------------------------------------------------------------
var Error = [<%=sError%>]
goback();
//==============================================================================
// run on loading
//==============================================================================
function goback()
{
   parent.rtnChgSlsGoal(Error);
}
</script>
<%
   }
   else {
%>
<script name="javascript">
  alert("Your session is expired, please sign on again.")
</script>
<%}%>