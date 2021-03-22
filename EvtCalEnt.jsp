<%@ page import="eventcalendar.EvtCalEnt , java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")==null
 || (session.getAttribute("EVTCALCHG") == null && session.getAttribute("EVTCALSTR") == null))
{
     response.sendRedirect("SignOn1.jsp?TARGET=EvtCalEnt.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   String sEvent = request.getParameter("Event");
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");
   String sScope = request.getParameter("Scope");
   String sRemind = request.getParameter("Remind");
   String sStrEvtTy = request.getParameter("StrEvtTy");
   String sEvtTime = request.getParameter("EvtTime");
   String [] sCol = request.getParameterValues("Col");
   String sType = request.getParameter("Type");
   String sAction = request.getParameter("Action");
   String sUser = session.getAttribute("USER").toString();

   if (sRemind==null) sRemind = " ";
   if (sStrEvtTy==null) sStrEvtTy = " ";
   if (sEvtTime==null) sEvtTime = " ";

   System.out.println(sEvent + "|" + sFrom + "|" + sTo + "|" + sScope + "|" + sRemind
	+ "|" + sType + "|" + sAction + "|" + sUser + "|");
   for(int i=0; i < sCol.length; i++)   { System.out.println(sCol[i] + " l=" + sCol[i].length());  }
   

   EvtCalEnt evtcal = new EvtCalEnt(sEvent, sFrom, sTo, sScope, sRemind, sStrEvtTy, sEvtTime, sCol, sType, sAction, sUser);
   int iNumOfErr = evtcal.getNumOfErr();
   String sError = evtcal.getError();

   evtcal.disconnect();

%>

<SCRIPT language="JavaScript1.2">
var NumOfErr = <%=iNumOfErr%>;
var Error = [<%=sError%>];

goBack();

// send employee availability to schedule
function goBack()
{
  if(NumOfErr > 0) parent.displayError(Error);
  else parent.reStart();
}
</SCRIPT>
<%}%>