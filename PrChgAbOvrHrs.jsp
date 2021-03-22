<%@ page import="payrollreports.PrChgAbOvrHrs"%>
<%
    String sStr = request.getParameter("Str");
    String sWkend = request.getParameter("Wkend");
    String sHrs = request.getParameter("Hrs");
    String sComment = request.getParameter("Comment");
    String sAction = request.getParameter("Action");
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null && session.getAttribute("PAYROLL")!=null)
{
    String sUser = session.getAttribute("USER").toString();
    PrChgAbOvrHrs abhrssav = new PrChgAbOvrHrs(sStr, sWkend, sHrs, sComment, sAction, sUser);
%>
<script name="javascript1.3">
//------------------------------------------------------------------------------
goback();
//==============================================================================
// run on loading
//==============================================================================
function goback()
{
   parent.rtnChgSlsGoal("");
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