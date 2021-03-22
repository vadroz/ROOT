<%@ page import="payrollreports.PrBdgSchedVar"%>
<%
    String sStore = request.getParameter("Store");
    String sWkend = request.getParameter("Wkend");

    String sAppl = "PAYROLL";

    if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PrBdgSchedVar.jsp&APPL=" + sAppl + "&" + request.getQueryString());
   }
   else
   {
    String sUser = session.getAttribute("USER").toString();

    PrBdgSchedVar schpay = new PrBdgSchedVar(sStore, sWkend,  sUser);
    String sBdgHrs = schpay.getBdgHrs();
    String sSchHrs = schpay.getSchHrs();
    String sHrsVar = schpay.getHrsVar();
    String sPrcVar = schpay.getPrcVar();

    schpay.disconnect();
%>


<script name="javascript1.2">
  var BdgHrs = "<%=sBdgHrs%>";
  var SchHrs = "<%=sSchHrs%>";
  var HrsVar = "<%=sHrsVar%>";
  var PrcVar = "<%=sPrcVar%>";

  setBdgSchedVar();
//==============================================================================
// Return  employee pays to budget detail page
//==============================================================================
function setBdgSchedVar()
{
   parent.showBdgSchedVar(BdgHrs, SchHrs, HrsVar, PrcVar);
}
</script>

<body>None</body>
<%}%>