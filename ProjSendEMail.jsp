<%@ page import="rciutility.SendMail"%>
<%
   String sSubject = request.getParameter("Subject");
   String sMessage = request.getParameter("Message");
   String sMailAddr = request.getParameter("MailAddr");
   String sCCMailAddr = request.getParameter("CCMailAddr");
   String sFromMailAddr = request.getParameter("FromMailAddr");
   String [] sPicAttach = request.getParameterValues("PicAttach");

   //System.out.println(sMailAddr + " " + sSubject);
   SendMail sendmail = new SendMail(sFromMailAddr, sMailAddr, sSubject, sMessage);
   //System.out.println("Sent?");
   sendmail = null;
 %>

 Sent to:
 <%=sMailAddr%>
<script>
  //parent.restart();
</script>