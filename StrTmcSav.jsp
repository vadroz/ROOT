<%@ page import="payrollreports.StrTmcSav, java.util.*"%>
<%
   String sStore = request.getParameter("Store");
   String sWeekend = request.getParameter("Week");
   String sType = request.getParameter("Type");
   String sTmcNum = request.getParameter("TmcNum");
   String sCmt = request.getParameter("Cmt");
   String sDay = request.getParameter("Day");
   String sDur = request.getParameter("Dur");
   String [] sEmp = request.getParameterValues("Emp");
   String sAction = request.getParameter("Action");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
    String sUser = session.getAttribute("USER").toString();

    StrTmcSav payent = new StrTmcSav(sStore, sWeekend, sType, sTmcNum, sCmt, sDay,
                                   sDur, sEmp, sAction, sUser);
    int iNumOfErr = payent.getNumOfErr();
    String sError = payent.getErrorJSA();

    payent.disconnect();
    payent = null;

%>

<SCRIPT language="JavaScript1.2">

var Error = [<%=sError%>];

goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
   function goBack()
   {
      parent.reStart(Error);
   }

</SCRIPT>
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>