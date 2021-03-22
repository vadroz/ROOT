<%@ page import="payrollreports.PsEmpEvtSave"%>
<%
    String sStr = request.getParameter("Str");
    String sEvtDate = request.getParameter("EvtDate");
    String sEvtTime = request.getParameter("EvtTime");
    String sEvt = request.getParameter("Evt");
    String [] sEmp = request.getParameterValues("Emp");
    String sBegTime = request.getParameter("BegTime");
    String sEndTime = request.getParameter("EndTime");

//----------------------------------
// Application Authorization
//----------------------------------
    if (session.getAttribute("USER")!=null && session.getAttribute("PAYROLL")!=null)
    {
    String sUser = session.getAttribute("USER").toString();

    //System.out.println(sStr + "|" + sEvt + "|" + sEvtDate + "|" + sEvtTime + "|" + sEmp[0] + "|" + sBegTime + "|" + sEndTime);
    PsEmpEvtSave empevtsav = new PsEmpEvtSave(sStr, sEvtDate, sEvtTime, sEvt, sEmp,
                                              sBegTime, sEndTime, sUser);
    String sError = empevtsav.getError();
%>
<script name="javascript1.3">
//------------------------------------------------------------------------------
var Error = [<%=sError%>]
goback();
//==============================================================================
// run on loading
//==============================================================================
function goback()
{
   parent.rtnEmpEvt(Error);
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