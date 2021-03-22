<%@ page import="ecommerce.EComUncondExclSave ,java.util.*, java.text.*"%>
<%
   String sStr = request.getParameter("Str");
   String sSku = request.getParameter("Sku");
   String sQty = request.getParameter("Qty");
   String sReason = request.getParameter("Reason");
   String sRDesc = request.getParameter("RDesc");
   String sExpDt = request.getParameter("ExpDt");
   String sEmp = request.getParameter("Emp");
   String sAction = request.getParameter("Action");
   String sRestart = request.getParameter("Restart");

   if(sRestart == null){sRestart = "N";}

   String sUser = session.getAttribute("USER").toString();

   EComUncondExclSave uncitmsv = new EComUncondExclSave();

   int iNumOfErr = 0;

   // add/chg/delete sku
   //System.out.println(sStr + "|" + sSku + "|" + sQty + "|" + sReason + "|" + sExpDt
   //     + "|" + sRDesc + "|" + sEmp + "|" + sAction + "|" + sUser);
   uncitmsv.saveSku( sStr, sSku, sQty, sReason, sRDesc, sExpDt, sEmp, sAction, sUser);
   iNumOfErr = uncitmsv.getNumOfErr();
   String sError = "";
   if (iNumOfErr > 0)
   {
      sError = uncitmsv.getErrorJsa();
   }

   //==========================================================================
   // disconnect
   //==========================================================================
   uncitmsv.disconnect();
%>
<SCRIPT language="JavaScript1.2">

 var Error = [<%=sError%>];
 var Restart = <%=sRestart.equals("Y")%>

 if(Error.length > 0){ parent.showError(Error); }
 else if(Restart){  parent.restart(); };
 else {  parent.hidePanel(); };

</SCRIPT>













