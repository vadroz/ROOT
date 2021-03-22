<%@ page import="mozu_com.MozuOrdSave"%>
<%
    String sSite = request.getParameter("Site");
    String sOrder = request.getParameter("Order");

    String [] sSku = request.getParameterValues("Sku");
    String [] sQty = request.getParameterValues("Qty");
    String [] sAmt = request.getParameterValues("Amt");
    String [] sTax = request.getParameterValues("Tax");
    String [] sShip = request.getParameterValues("Ship");
    String [] sShipTax = request.getParameterValues("ShipTax");
    String [] sNote = request.getParameterValues("Note");

    String sAction = request.getParameter("Action");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER") != null && session.getAttribute("ECOMADJ") != null)
{
     String sUser = session.getAttribute("USER").toString();
     MozuOrdSave ordsv = new MozuOrdSave();
     
     ordsv.saveRet(sSite, sOrder, sSku, sQty, sRet, sOldRet, sShipCost,
        sTax, sAdjDate, sRefOnlCred, sAction, sUser);

%>
<script language="javascript">
parent.restart();
</script>
<%
   ordsv.disconnect();
}
else {%>
<script language="javascript">
alert("Your session is expired. Please Sign on again.")
</script>
<%}%>