<%@ page import="payrollreports.PayEntrySav, java.util.*"%>
<%
   String sStore = request.getParameter("Store");
   String sWeekend = request.getParameter("Week");
   String sEmp = request.getParameter("Emp");
   String sDay = request.getParameter("Day");
   String sPyType = request.getParameter("PyType");
   String sSubType = request.getParameter("SubType");
   String sAmt = request.getParameter("Amt");
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
    String sUser = session.getAttribute("USER").toString();

    PayEntrySav payent = new PayEntrySav(sStore, sWeekend, sEmp, sDay, sPyType, sSubType, sAmt, sUser);
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