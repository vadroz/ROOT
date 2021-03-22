<%@ page import="counterpoint.UplStrDailySls, java.math.BigDecimal"%>
<%
   String sStore = request.getParameter("Store");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
    UplStrDailySls dlySls = new UplStrDailySls();
    dlySls.getStrSales(sStore);
    BigDecimal bdSalesDaily = dlySls.getSalesDlySum();
%>
<script name="javascript1.2">
  var StrSalesSum = "<%=bdSalesDaily.toString()%>"
  parent.showDlySls();
</script>
<%}%>







