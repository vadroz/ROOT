<%@ page import="ecommerce.EComOrdAdjSave"%>
<%
    String sAdjId = request.getParameter("AdjId");
    String sSite = request.getParameter("Site");
    String sOrder = request.getParameter("Order");

    String [] sDtlId = request.getParameterValues("DtlId");
    String [] sSku = request.getParameterValues("Sku");
    String [] sQty = request.getParameterValues("Qty");
    String [] sRet = request.getParameterValues("Ret");
    String [] sOldRet = request.getParameterValues("OldRet");

    String sShipCost = request.getParameter("ShipCost");
    String sTax = request.getParameter("Tax");
    String sAdjDate = request.getParameter("AdjDate");
    String sRefOnlCred = request.getParameter("RefOnlCred");
    String sAction = request.getParameter("Action");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER") != null && session.getAttribute("ECOMADJ") != null)
{
     String sUser = session.getAttribute("USER").toString();
     EComOrdAdjSave adjsave = new EComOrdAdjSave();
     adjsave.saveOrder(sAdjId, sSite, sOrder, sDtlId, sSku, sQty, sRet, sOldRet, sShipCost,
        sTax, sAdjDate, sRefOnlCred, sAction, sUser);

%>
<script language="javascript">
parent.restart();
</script>
<%
   adjsave.disconnect();
}
else {%>
<script language="javascript">
alert("Your session is expired. Please Sign on again.")
</script>
<%}%>