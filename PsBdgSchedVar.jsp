<%@ page import="payrollreports.PsBdgSchedVar"%>
<%
    String sStore = request.getParameter("Store");
    String sWkend = request.getParameter("Wkend");

    String sAppl = "PAYROLL";

    if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PsBdgSchedVar.jsp&APPL=" + sAppl + "&" + request.getQueryString());
   }
   else
   {
    String sUser = session.getAttribute("USER").toString();

    PsBdgSchedVar schpay = new PsBdgSchedVar(sStore, sWkend,  sUser);
    String sBdgHrs = schpay.getBdgHrs();
    String sSchHrs = schpay.getSchHrs();
    String sHrsVar = schpay.getHrsVar();
    String sPrcVar = schpay.getPrcVar();

    int INumOfGrp = schpay.getNumOfGrp();
    String sGrpName = schpay.getGrpNameJva();
    String sGrpBdgHrs = schpay.getGrpBdgHrsJva();
    String sGrpSchHrs = schpay.getGrpSchHrsJva();
    String sGrpHrsVar = schpay.getGrpHrsVarJva();

    schpay.disconnect();
%>


<script name="javascript1.2">
  var BdgHrs = "<%=sBdgHrs%>";
  var SchHrs = "<%=sSchHrs%>";
  var HrsVar = "<%=sHrsVar%>";
  var PrcVar = "<%=sPrcVar%>";

  var GrpName = [<%=sGrpName%>];
  var GrpBdgHrs = [<%=sGrpBdgHrs%>];
  var GrpSchHrs = [<%=sGrpSchHrs%>];
  var GrpHrsVar = [<%=sGrpHrsVar%>];

  setBdgSchedVar();
//==============================================================================
// Return  employee pays to budget detail page
//==============================================================================
function setBdgSchedVar()
{
   parent.showBdgSchedVar(BdgHrs, SchHrs, HrsVar, PrcVar, GrpName, GrpBdgHrs, GrpSchHrs, GrpHrsVar);
}
</script>

<body>None</body>
<%}%>