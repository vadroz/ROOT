<%@ page import="itemtransfer.ScanItemSave , java.util.*"%>
<%
   String sIssStr = request.getParameter("IssStr");
   String sDstStr = request.getParameter("DstStr");
   String sCtn = request.getParameter("Ctn");
   String sItem = request.getParameter("Item");
   String sQty = request.getParameter("Qty");
   String sAction = request.getParameter("Action");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
    String sUser = session.getAttribute("USER").toString();
    ScanItemSave savitem = new ScanItemSave(sIssStr, sDstStr, sCtn, sItem, sQty, sAction, sUser);
    int iNumOfErr = savitem.getNumOfErr();
    String sError = savitem.getErrorJSA();
    
    savitem.disconnect();
    savitem = null;

%>

<SCRIPT language="JavaScript1.2">

var Error = [<%=sError%>];

goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
   function goBack()
   {
      parent.reStart(Error);
   }

</SCRIPT>
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>