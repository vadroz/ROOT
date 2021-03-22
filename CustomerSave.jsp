<%@ page import="discountcard.CustomerSave , java.util.*"%>
<%
   String sSrchCode = request.getParameter("Code");
   String sSrchName = request.getParameter("Name");
   String sSrchAddr1 = request.getParameter("Addr1");
   String sSrchAddr2 = request.getParameter("Addr2");
   String sSrchCity = request.getParameter("City");
   String sSrchState = request.getParameter("State");
   String sSrchZip = request.getParameter("Zip");
   String sSrchPhone = request.getParameter("Phone");
   String sSrchEMail = request.getParameter("EMail");
   String sSrchRide = request.getParameter("Ride");
   String sSrchTeam = request.getParameter("Team");
   String sAction = request.getParameter("Action");

   if(sSrchCode==null) sSrchCode = "0000";
   if(sSrchName==null) sSrchName = " ";
   if(sSrchAddr1==null) sSrchAddr1 = " ";
   if(sSrchAddr2==null) sSrchAddr2 = " ";
   if(sSrchCity==null) sSrchCity = " ";
   if(sSrchState==null) sSrchState = " ";
   if(sSrchZip==null) sSrchZip = " ";
   if(sSrchPhone==null) sSrchPhone = " ";
   if(sSrchEMail==null) sSrchEMail = " ";
   if(sSrchRide==null) sSrchRide = " ";
   if(sSrchTeam==null) sSrchTeam = " ";

   CustomerSave cstsav = null;
   int iNumOfErr = 0;
   String sError = null;
   String sCode = null;
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
   cstsav = new CustomerSave(sSrchCode, sSrchName, sSrchAddr1, sSrchAddr2, sSrchCity,
   sSrchState, sSrchZip, sSrchPhone, sSrchEMail, sSrchRide, sSrchTeam, sAction, session.getAttribute("USER").toString());
   sCode = cstsav.getCode();
   iNumOfErr = cstsav.getNumOfErr();
   sError= cstsav.getError();
   cstsav.disconnect();
}
%>

<SCRIPT language="JavaScript1.2">
<%if  (session.getAttribute("USER")!=null){%>
   var NumOfErr = <%=iNumOfErr%>;
   var Error = [<%=sError%>];
   var Code = "<%=sCode%>";

   goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
   function goBack()
   {
      if(NumOfErr > 0) parent.displayError(Error);
      else parent.reStart(Code);
   }
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>
</SCRIPT>







