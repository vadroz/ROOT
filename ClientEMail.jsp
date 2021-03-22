<%@ page import="java.util.*, java.text.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=WarrantyClaimInfo.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();
%>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   document.all.FrAddr.value = "<%=sUser%>@sunandski.com"
   <%if(sUser.equals("vrozen")){%>
     document.all.ToAddr.value = "<%=sUser%>@yahoo.com"
   <%}%>
}
//==============================================================================
// send email message
//==============================================================================
function sbmEMail()
{
   var url = "WarrantyClaimSendEMail.jsp?"
       + "MailAddr=" + document.all.ToAddr.value.trim()
       + "&FromMailAddr=" + document.all.FrAddr.value.trim()
       + "&Subject=" + document.all.Subj.value.trim()
       + "&Message=" + document.all.Msg.value.trim()

   //alert(msg)
   window.frame1.location.href = url;
}
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="200" width="100%"></iframe>
<!-------------------------------------------------------------------->

<table with="100%" align=center>
  <tr>
    <td >
     <span style="font-size:26px;font-weight:bold;">Send Email</span>
    </td>
  </tr>
  <tr>
    <td>

      <table>
         <tr><td>From E-Mail Address</td><td><input size=50 name='FrAddr'></td></tr>
         <tr><td>To E-Mail Address</td><td><input size=50 name='ToAddr'></td></tr>
         <tr><td>Subject &nbsp;</td><td><input size=50 name='Subj' value="Send message outside network"></td></tr>
         <tr><td>Message &nbsp;</td><td><input size=50 name='Msg' value="Test, test, test,  Send message outside network"></td></tr>
         <tr><td colspan=2 align=center><button onclick="sbmEMail()">Submit</button></td></tr>
      </table>

    </td>
  </tr>
</table>
</body>
<%}%>