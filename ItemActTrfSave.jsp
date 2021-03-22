<%@ page import="java.util.*, itemtransfer.ItemActTrfSave"%>
<%
   String sStr = request.getParameter("Str");
   String sTran = request.getParameter("Tran");
   String sCls = request.getParameter("Cls");
   String sVen = request.getParameter("Ven");
   String sSty = request.getParameter("Sty");
   String sClr = request.getParameter("Clr");
   String sSiz = request.getParameter("Siz");
   String sQty = request.getParameter("Qty");
   String sSeq = request.getParameter("Seq");
   String sAction = request.getParameter("Action");

   ItemActTrfSave savtrf = new ItemActTrfSave(sStr, sTran, sCls, sVen, sSty, sClr, sSiz,
                                   sSeq, sQty, sAction);
   boolean bError = savtrf.getError();

   savtrf.disconnect();
   savtrf = null;
%>

<html>
<head>


<SCRIPT language="JavaScript">
//==============================================================================
// Global variable
//==============================================================================
var Error = <%=bError%>;

goBack();
//==============================================================================
// return result
//==============================================================================
function goBack()
{
   parent.updateLine(Error);
}
</SCRIPT>