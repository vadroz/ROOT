<%@ page import="rciutility.SendMail"%>
<%
   String sSubject = request.getParameter("Subject");
   String sMessage = request.getParameter("Message");
   String sMailAddr = request.getParameter("MailAddr");
   String sCCMailAddr = request.getParameter("CCMailAddr");
   String sFromMailAddr = request.getParameter("FromMailAddr");

   String [] sItemAttach = request.getParameterValues("ItemAttach");
   String [] sPicAttach = request.getParameterValues("PicAttach");

   //SendMail sndmail = new SendMail("patioclaims@sunandski.com", sMailAddr, sSubject, sMessage);
   //System.out.println(sFromMailAddr + "|" + sMailAddr + "|" + sCCMailAddr);
   SendMail sndmail = new SendMail();
   sndmail.sendWithAttachments(sFromMailAddr, sMailAddr, sCCMailAddr, null, sSubject
                       , sMessage, sPicAttach);
 %>

<script>
parent.alert("Message has been sent.")
</script>