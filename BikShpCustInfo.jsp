<%@ page import="specialorder.TicketInfo, java.util.*, java.text.*"%>
<%
   String sCustNum = request.getParameter("CustNum");

   TicketInfo tkInfo = new TicketInfo(sCustNum, false);

         String sLastName = tkInfo.getLastName();
         String sFirstName = tkInfo.getFirstName();
         String sAddress = tkInfo.getAddress();
         String sCity = tkInfo.getCity();
         String sState = tkInfo.getState();
         String sZip = tkInfo.getZip();
         String sHomePh = tkInfo.getHomePh();
         String sWorkPh = tkInfo.getWorkPh();
         String sExtWrk = tkInfo.getExtWrk();
         String sCellPh = tkInfo.getCellPh();
         String sEMail = tkInfo.getEMail();
         String sCustFnd = tkInfo.getCustFnd();

         tkInfo.disconnect();
%>

<SCRIPT language="JavaScript1.2">

setCustInfo();

// send employee availability to schedule
function setCustInfo()
{
  parent.setSelectedCust( "<%=sLastName%>", "<%=sFirstName%>", "<%=sAddress%>",
     "<%=sCity%>", "<%=sState%>", "<%=sZip%>", "<%=sHomePh%>", "<%=sWorkPh%>",
     "<%=sExtWrk%>", "<%=sCellPh%>", "<%=sEMail%>" );
}
</SCRIPT>
