<%@ page import="patiosales.PfsChkPO, java.util.*"%>
<%
   String sPoNum = request.getParameter("PoNum");
   int iNumOfErr = 0;
   String sError = null;
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
   PfsChkPO getvend = new PfsChkPO(sPoNum, session.getAttribute("USER").toString());

   iNumOfErr = getvend.getNumOfErr();
   sError = getvend.getErrorJsa();

   getvend.disconnect();
}
%>

<SCRIPT language="JavaScript1.2">
<%if  (session.getAttribute("USER")!=null){%>
   var NumOfErr = <%=iNumOfErr%>;
   var Error = [<%=sError%>];

   goBack();
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
<%}%>
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
   if(NumOfErr > 0) parent.displayError(Error);
   else
   {
     parent.savePONum();
     this.close();
   }
}
</SCRIPT>
