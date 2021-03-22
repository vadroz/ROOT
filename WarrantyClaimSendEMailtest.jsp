<%@ page import="rciutility.SendMail"%>
<%
   String sSubject = "subj test";
   String sMessage = "Message testvr 12234";
   String sMailAddr = "vrozen@sunandski.com";
   String sCCMailAddr = "vrozen@sunandski.com";
   String sFromMailAddr = "pmayer@sunandski.com";

   String [] sItemAttach = request.getParameterValues("ItemAttach");
   String [] sPicAttach = request.getParameterValues("PicAttach");

   //SendMail sndmail = new SendMail("patioclaims@sunandski.com", sMailAddr, sSubject, sMessage);
   //System.out.println(sFromMailAddr + "\nsMailAddr: " + sMailAddr + "\nsCCMailAddr: " + sCCMailAddr
   //    + "\n" + sSubject + "\n" + (sItemAttach == null) + "\n" + (sPicAttach == null));
   SendMail sndmail = new SendMail();
   sndmail.sendWithAttachments(sFromMailAddr, sMailAddr, sCCMailAddr, null, sSubject
                       , sMessage, sPicAttach);
 %>

<script>
parent.alert("Message has been sent.")
</script>