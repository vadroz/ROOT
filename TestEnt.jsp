<%@ page import="emptraining.TestEnt, java.util.*"%>
<%
   String sTest = request.getParameter("Test");
   String sSort = request.getParameter("Sort");
   String sTstName = request.getParameter("TstName");
   String sGroup = request.getParameter("Group");
   String sAction = request.getParameter("Action");

   //System.out.println(" T: " + sTest + " S: " + sSort + " TN: " + sTstName + " G:" + sGroup + " T:" + sAction);
   TestEnt tstsv = new TestEnt(sTest, sSort, sTstName, sGroup, sAction);
   tstsv.disconnect();
   tstsv = null;
%>
<SCRIPT language="JavaScript1.2">
//goBack();
function goBack(){   parent.reStart(); }
</SCRIPT>






