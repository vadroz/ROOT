<%@ page import="emptraining.EmpTrnEnt , java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("TRAINING") == null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=EmpTrnEnt.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   String sEmp = request.getParameter("Emp");
   String sTrn = request.getParameter("Trn");
   String sTrnPgm = request.getParameter("TrnPgm");

   String [] sOptSeq = request.getParameterValues("OptSeq");
   String [] sChk = request.getParameterValues("Chk");

   String sUser = session.getAttribute("USER").toString();

   EmpTrnEnt trnsave = new EmpTrnEnt(sTrnPgm, sEmp, sTrn, sOptSeq, sChk, sUser);
   int iNumOfErr = trnsave.getNumOfErr();
   String sError = trnsave.getError();

   trnsave.disconnect();

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
<%}%>