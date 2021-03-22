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
   /*System.out.println(sFromMailAddr + "\nsMailAddr: " + sMailAddr + "\nsCCMailAddr: " + sCCMailAddr
       + "\n" + sSubject + "\nsItemAttach=" + (sItemAttach == null)  
      + "\nsPicAttach=" + (sPicAttach==null) );
   */
      //+ " file:" + sPicAttach[0] );
   
   SendMail sndmail = new SendMail();
   sndmail.sendWithAttachments(sFromMailAddr, sMailAddr, sCCMailAddr, null, sSubject
                       , sMessage, sPicAttach);
 %>

<script>
try {	parent.alert("Message has been sent.") } catch(err){}
try {	parent.showAlert("Message has been sent."); } catch(err){}
</script>