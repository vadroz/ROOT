<%@ page import="emptraining.EmpCheckName , java.util.*"%>
<%
   String sEmp = request.getParameter("Emp");
   String sFName = request.getParameter("FName");
   String sLName = request.getParameter("LName");

   EmpCheckName empchk = new EmpCheckName(sEmp, sFName, sLName);
   int iNumOfErr = empchk.getNumOfErr();
   String sError = empchk.getError();

   empchk.disconnect();

%>

<SCRIPT language="JavaScript1.2">
var NumOfErr = <%=iNumOfErr%>
var Error = [<%=sError%>];
var Emp = "<%=sEmp%>";
var FName = "<%=sFName%>";
var LName = "<%=sLName%>";

goBack();

// send employee availability to schedule
function goBack()
{
  if(NumOfErr > 0) parent.displayError(Error);
  else parent.submitForm(Emp, FName, LName);
}
</SCRIPT>
