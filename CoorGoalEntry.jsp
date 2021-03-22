<%@ page import="coordinators.CoorGoalEntry , java.util.*"%>
<%
   String sMonthYear = request.getParameter("MonthYear");
   String sMonthName = request.getParameter("MonthName");
   String sCoordinator = request.getParameter("Coordinator");
   String sStore = request.getParameter("Store");
   String sStrIdx = request.getParameter("StrIdx");
   String [] sWeek = request.getParameterValues("Week");
   String [] sPercent = request.getParameterValues("Prc");
   String [] sGoal = request.getParameterValues("Goal");
   String [] sLYSales = request.getParameterValues("Sales");

   CoorGoalEntry cogoent = new CoorGoalEntry(sCoordinator, sStore, sWeek, sPercent, sGoal, sLYSales);
   cogoent.disconnect();
%>

<SCRIPT language="JavaScript1.2">

getNextGoals();

// send employee availability to schedule
function getNextGoals()
{
  //alert(<%=sStrIdx%>);
  parent.saveNextStrGoal(<%=sStrIdx%>);
  // window.frame1.close();
}
</SCRIPT>







