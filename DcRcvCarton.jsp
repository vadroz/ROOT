<%@ page import="dcfrtbill.DcRcvCarton, java.util.*"%>
<%
   boolean bSessionExpired = false;
   //----------------------------------
   // Application Authorization
   //----------------------------------

   if (session.getAttribute("USER")==null)
   {
      bSessionExpired = true;
   }
   {
      String sFrtBill = request.getParameter("Frtb");
      String sPallet = request.getParameter("Pallet");
      String sCarton = request.getParameter("Carton");
      String sAction = request.getParameter("Action");
      String sComment = request.getParameter("Comment");
      String sDistro = request.getParameter("Distro");
      String sAudFB = request.getParameter("AudFB");
      String sAudMN = request.getParameter("AudMN");
      String sAudPW = request.getParameter("AudPW");
      String sInteId = request.getParameter("InetId");

      String sUser = session.getAttribute("USER").toString();
      
      if(sInteId != null && !sInteId.equals("")){ sUser = sInteId; }

      if(sFrtBill==null) { sFrtBill = "  " ; }
      else{ sFrtBill = sFrtBill.trim();}

      if(sPallet==null) sPallet = "  ";
      if(sCarton==null) sCarton = "  ";
      if(sComment==null) sComment = "  ";
      if(sDistro==null) sDistro = "  ";   
      if(sAudFB==null) sAudFB = "  ";
      if(sAudMN==null) sAudMN = "  ";
      if(sAudPW==null) sAudPW = "  ";

      System.out.println("\n"
       + sFrtBill + "|" + sPallet + "|" + sCarton + "|" + sAction + "|" + sComment + "|"
       + sDistro + "|" +sAudFB + "|" +sAudMN + "|" +sAudPW + "|" +sUser);
      DcRcvCarton rcvctn = new DcRcvCarton(sFrtBill, sPallet, sCarton, sAction, sComment, sDistro, sAudFB, sAudMN, sAudPW, sUser);
      rcvctn.disconnect();
   }
%>
<html>
<head>
<style>
 body {background:ivory;}
</style>
</head>

<SCRIPT language="JavaScript1.2">
restartReport();
// send employee availability to schedule
function restartReport()
{
  parent.restartReport(<%=bSessionExpired%>);
  // window.close();
}
</SCRIPT>


