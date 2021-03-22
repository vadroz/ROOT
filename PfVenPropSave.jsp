<%@ page import="patiosales.PfVenPropSave , java.util.*, java.math.BigDecimal"%>
<%
   String sVen = request.getParameter("Ven");
   String sContact = request.getParameter("Contact");
   String sPhone1 = request.getParameter("Phone1");
   String sPhone2 = request.getParameter("Phone2");
   String sPhone3 = request.getParameter("Phone3");
   String sEMail = request.getParameter("Email");
   String sAction = request.getParameter("Action");

   if(sVen == null){ sVen = " ";}
   if(sContact == null){ sContact = " ";}
   if(sPhone1 == null){ sPhone1 = " ";}
   if(sPhone2 == null){ sPhone2 = " ";}
   if(sPhone3 == null){ sPhone3 = " ";}
   if(sEMail == null){ sEMail = " ";}

   int iNumOfErr = 0;
   String sError = null;
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{
   PfVenPropSave vensave = new PfVenPropSave(sVen, sContact, sPhone1, sPhone2, sPhone3, sEMail, sAction, session.getAttribute("USER").toString());

   iNumOfErr = vensave.getNumOfErr();
   sError = vensave.getError();

   vensave.disconnect();
   vensave = null;
}
%>

<SCRIPT language="JavaScript1.2">
<%if  (session.getAttribute("USER")!=null){%>
   var NumOfErr = <%=iNumOfErr%>;
   var Error = [<%=sError%>];
   goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
   if(NumOfErr > 0) parent.displayError(Error);
   else parent.reStart();
}
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>
</SCRIPT>
