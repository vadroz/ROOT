<%@ page import="inventoryreports.PiWiSave, java.util.*"%>
<%
   String sStore = request.getParameter("Store");
   String sMbr = request.getParameter("Mbr");
   String sArea = request.getParameter("Area");
   String sPiYearMo = request.getParameter("PICal");
   String sSku = request.getParameter("Sku");
   String sSeq = request.getParameter("Seq");
   String sUpc = request.getParameter("Upc");
   String sQty = request.getParameter("Qty");
   String sAction = request.getParameter("Action");
   
   String [] sArrSku = request.getParameterValues("asku");
   String [] sArrRet = request.getParameterValues("nwp");

   if(sSku ==null){ sSku = " "; }
   
   System.out.println( "Seq = " + sSeq);
   
   if(sSeq == null)
   {
	   System.out.println( "Seq = " + sSeq);
	   sSeq = " "; 
   }
   
   if(sUpc ==null){ sUpc = " "; }
   if(sQty ==null){ sQty = " "; }

   PiWiSave invsav = new PiWiSave();

   if(sAction.equals("DLTAREA"))
   {
      //System.out.println(sStore + "|" + sArea + "|" + sPiYearMo.substring(0, 4)
      //  + "|" +  sPiYearMo.substring(4) + "|" + sMbr);
      invsav.dltArea(sStore, sArea, sPiYearMo.substring(0, 4),  sPiYearMo.substring(4), sMbr);
   }
   else if(sAction.equals("ADDITEM") || sAction.equals("UPDITEM") || sAction.equals("DLTITEM"))
   {
     System.out.println(sStore + "|" + sArea + "|" + sPiYearMo.substring(0, 4)
        + "|" +  sPiYearMo.substring(4) + "|" + sMbr + "|" + sSku + "|Seq: " + sSeq + "|" + sUpc + "|"
        + sQty + "|" + sAction);
      invsav.setItem(sStore, sArea, sPiYearMo.substring(0, 4),  sPiYearMo.substring(4), sMbr
         , sSku, sSeq, sUpc, sQty, sAction);
   }
   else if(sAction.equals("UpdPrc"))
   {
	   invsav.setAleas(sStore, sArea, sPiYearMo.substring(0, 4),  sPiYearMo.substring(4), sMbr);
	   
	   for(int i=0; i < sArrSku.length; i++)
	   {
	   		invsav.setNewPrc(sStore, sArea, sPiYearMo.substring(0, 4),  sPiYearMo.substring(4), sMbr
		         , sArrSku[i], sArrRet[i]);
	   }
   }
   
   

   invsav.setError();
   int iNumOfErr = invsav.getNumOfErr();
   String sError = invsav.cvtToJavaScriptArray(invsav.getError());

   invsav.disconnect();
%>

<SCRIPT language="JavaScript">
 <%if(iNumOfErr == 0){%>parent.window.location.reload();<%}
   else {%>
      var Error = [<%=sError%>];
      parent.showError(Error)
  <%}%>
</script>









