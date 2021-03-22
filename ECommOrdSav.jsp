<%@ page import="ecommerce.ECommOrdSav , java.util.*"%>
<%
   String sSite = request.getParameter("Site");
   String sOrder = request.getParameter("Order");
   String sDtlId = request.getParameter("DtlId");
   String sAction = request.getParameter("Action");

   ECommOrdSav orddtlsts = null;
   int iNumOfErr = 0;
   String sError = null;
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null && session.getAttribute("ECOMMCNL")!=null)
{
   orddtlsts = new ECommOrdSav(sSite, sOrder, sDtlId, sAction, session.getAttribute("USER").toString());
   iNumOfErr = orddtlsts.getNumOfErr();
   sError = orddtlsts.getError();
   orddtlsts.disconnect();
}
%>

<SCRIPT language="JavaScript1.2">
<%if (session.getAttribute("USER")!=null){%>
    var NumOfErr = <%=iNumOfErr%>;
    var Error = [<%=sError%>];

   goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
   function goBack()
   {
     if(NumOfErr > 0) { parent.displayError(Error); }
     else parent.restart();
   }
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>
</SCRIPT>







