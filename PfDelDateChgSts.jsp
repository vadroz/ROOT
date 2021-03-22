<%@ page import="patiosales.PfsMarkClosedDelDate, java.util.*"%>
<%
  String sReg = request.getParameter("Reg");
  String sDate = request.getParameter("Date");
  String sAction = request.getParameter("Action");
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER") !=null && session.getAttribute("PFSDELDT") != null)
{
   PfsMarkClosedDelDate markdate = new PfsMarkClosedDelDate(sReg, sDate, sAction, session.getAttribute("USER").toString());
   markdate.disconnect();
%>
<SCRIPT language="JavaScript">
  parent.restart()
</SCRIPT>
<%}%>