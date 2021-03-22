<%@ page import="payrollreports.SavMsgEnt, java.util.*"%>
<% // Get query string parameters
   String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sMonth = request.getParameter("MONBEG");
   String sWeekend = request.getParameter("WEEKEND");
   String sSender = request.getParameter("Sender");
   String sUser = request.getParameter("User");
   String sText = request.getParameter("Text");
   String sRecepient = request.getParameter("To");
   String sReferTo =  request.getParameter("ReferTo");
   String sApprove =  request.getParameter("APRVSTS");
   String sCancel =  request.getParameter("Cancel");
   String sFrom =  request.getParameter("From");


   String sReqAnsw = " ";

   if (sUser == null) sUser = sSender;
   if (sReferTo == null) sReferTo = " ";
   if (request.getParameter("ReqAnswer") != null) { sReqAnsw = "Y"; }
   if (sApprove == null){ sApprove = " "; }
   if(sText==null) sText =  " ";
   if(sCancel==null) sCancel =  " ";

   String sUserId = null;

   //-------------- Security ---------------------
   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null
    || session.getAttribute("APPLICATION") !=null
    && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     Enumeration  en = request.getParameterNames();
     String sParam =null;
     String sPrmValue = null;
     String sTarget = "PayrollSignOn.jsp?TARGET=SavMsgEnt.jsp&APPL=" + sAppl;
     StringBuffer sbQuery = new StringBuffer() ;

     while (en.hasMoreElements())
      {
        sParam = en.nextElement().toString();
        sPrmValue = request.getParameter(sParam);
        sbQuery.append("&" + sParam + "=" + sPrmValue);
      }
   response.sendRedirect(sTarget + sbQuery.toString());
   }
  //-------------- End Security -----------------
   else
   {
     sUserId = session.getAttribute("USER").toString();

     SavMsgEnt savMsg = new SavMsgEnt(sStore, sWeekend, sSender, sUser, sRecepient, sText,
        sReqAnsw, sReferTo, sApprove, sCancel);

     savMsg.disconnect();

     String sLink = null;
     if (sFrom != null)
     {
        sLink = sFrom + "?STORE=" + sStore
                   + "&STRNAME=" + sThisStrName
                   + "&MONBEG=" + sMonth
                   + "&WEEKEND=" + sWeekend;
     }
     else
     {
        sLink = "Forum.jsp?STORE=" + sStore
              + "&STRNAME=" + sThisStrName
              + "&MONBEG=" + sMonth
              + "&WEEKEND=" + sWeekend;
     }

     response.sendRedirect(sLink);
  }
 %>

<html>
<head>
<SCRIPT language="JavaScript1.2">
</SCRIPT>
</head>
 <body>
 <%if(sUserId!=null){%>
   Test:
  <p align="left">Str= <%=sStore%>
  <br>StrName= <%=sThisStrName %>
  <br>Month= <%=sMonth%>
  <br>Weekend= <%=sWeekend%>
  <br>Sender= <%=sSender%>
  <br>User= <%=sUser%>
  <br>Recepient= <%=sRecepient%>
  <br>Text= <%=sText%>
  <br>Required Reply = <%=sReqAnsw%>
  <br>Refered To = <%=sReferTo%>
  <br>Approve = <%=sApprove%>
  <br>Cancel = <%=sCancel%>

 <%}%>
 </body>
</html>
