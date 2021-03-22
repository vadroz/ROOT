<%@ page import="itemtransfer.DistAknowSave , java.util.*"%>
<%
   String sIssStr = request.getParameter("IssStr");
   String sDstStr = request.getParameter("DstStr");
   String sCtn = request.getParameter("Ctn");
   String sSku = request.getParameter("Sku");
   String sQty = request.getParameter("Qty");
   String sExcept = request.getParameter("Expcept");
   String sAction = request.getParameter("Action");

//----------------------------------
// Application Authorization
//----------------------------------
System.out.println(sIssStr + " " + sDstStr + " " + sCtn + " " + sSku + " " + sQty + " " + sExcept + " " + sAction);

if (session.getAttribute("USER")!=null)
{
    String sUser = session.getAttribute("USER").toString();
    DistAknowSave savackn = new DistAknowSave(sIssStr, sDstStr, sCtn, sSku, sQty, sExcept, sAction, sUser);
    int iNumOfErr = savackn.getNumOfErr();
    String sError = savackn.getErrorJSA();

    savackn.disconnect();
    savackn = null;

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