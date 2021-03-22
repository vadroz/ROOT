<%@ page import="emptraining.GroupTestEnt, java.util.*"%>
<%
   String sGroup = request.getParameter("Group");
   String sGroupName = request.getParameter("GroupName");
   String sSort = request.getParameter("Sort");
   String sAction = request.getParameter("Action");

   GroupTestEnt testqasv = new GroupTestEnt(sGroup, sGroupName, sSort, sAction);
   testqasv.disconnect();
   testqasv = null;
%>
<SCRIPT language="JavaScript1.2">
goBack();
function goBack(){   parent.reStart(); }
</SCRIPT>






