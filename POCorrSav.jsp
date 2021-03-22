<%@ page import="posend.POCorrSav"%>
<%
 //----------------------------------
 // Application Authorization
 //----------------------------------

 if (session.getAttribute("USER")!=null)
 {
    String sPoNum = request.getParameter("PO");
    String sLastRctDt = request.getParameter("LastRctDt");
    String sReceipt = request.getParameter("Receipt");

    String [] sSeq = request.getParameterValues("Seq");
    String [] sSku = request.getParameterValues("Sku");
    String [] sQty = request.getParameterValues("Qty");
    String [] sActQty = request.getParameterValues("ActQty");
    String [] sInit = request.getParameterValues("Init");
    String [] sCommt = request.getParameterValues("Commt");

    String sUser = session.getAttribute("USER").toString();

    POCorrSav porctsv = new POCorrSav();


%>
<%
   for(int i=0; i < sSeq.length; i++)
   {
      porctsv.saveCorrSav(sPoNum, sLastRctDt, sReceipt, sSeq[i], sSku[i], sQty[i], sActQty[i], sInit[i], sCommt[i], sUser);
   }
   porctsv.sendEMail();
%>

<script name="javascript1.2">
  parent.location.reload();
</script>
<%
    porctsv.disconnect();
    porctsv = null;
}
 else {%>
 <script name="javascript1.2">
    alert("Please, sign on.")
 </script>
<%}%>

