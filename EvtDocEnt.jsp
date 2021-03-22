<%@ page import="eventcalendar.EvtDocEnt , java.util.*"%>
<%
   String sEvent = request.getParameter("Event");
   String sFrom = request.getParameter("From");
   String sType = request.getParameter("Type");
   String sPath = request.getParameter("Path");
   String sAction = request.getParameter("Action");

   System.out.println(sEvent + "|" + sFrom + "|" + sType + "|" + sPath + "|" + sAction);
   EvtDocEnt docent = new EvtDocEnt(sEvent, sFrom, sType, sPath, sAction);
   int iNumOfErr = docent.getNumOfErr();
   String sError = docent.getError();

   docent.disconnect();
%>

<SCRIPT language="JavaScript1.2">
var NumOfErr = <%=iNumOfErr%>
var Error = [<%=sError%>];

goBack();

// send employee availability to schedule
function goBack()
{
  if(NumOfErr > 0) parent.displayError(Error);
  else parent.reStart();
}
</SCRIPT>
