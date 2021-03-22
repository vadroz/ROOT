<%@ page import="dcfrtbill.DcCtnDtlAcknSv, java.util.*"%>
<%

String sCarton = request.getParameter("Carton");
String sAction = request.getParameter("Action");
String sComment = request.getParameter("Comment");
String sUser = request.getParameter("User");
String [] sSku = request.getParameterValues("Sku");
String [] sQty = request.getParameterValues("Qty");
String [] sNew = request.getParameterValues("New");

   boolean bSessionExpired = false;
   //----------------------------------
   // Application Authorization
   //----------------------------------

   if (session.getAttribute("USER")==null)
   {
      bSessionExpired = true; 
   }
   {
        
	  System.out.println("DcCtnDtlAcknSv ==>\n" + sCarton + "|" + sSku[0] + "|" + sNew[0] + "|" + sQty[0]
			  + "|" + sComment + "|" + sAction + "|" + sUser);
	  
	  DcCtnDtlAcknSv rcvctn = new DcCtnDtlAcknSv();
	  rcvctn.setMarkedItem(sCarton, sSku, sNew, sQty, sComment, sAction, sUser);
      rcvctn.disconnect();
   }
%>
<html>
<head>
<style>
 body {background:ivory;}
</style>
</head>

<SCRIPT language="JavaScript1.2">
var Action = "<%=sAction%>";

if(Action != "AddNewSku" && Action != "DltNewSku") { restartReport(); }
else{ parent.location.reload(); }

// send employee availability to schedule
function restartReport()
{
	if(Action)
  parent.returnToParent();   
}
</SCRIPT>


