<%@ page import="storetobuyers.StrBuyerMsgSave, java.util.*"%>
<% // Get query string parameters
   String sStore = request.getParameter("Store");
   String sStrName = request.getParameter("StrName");
   String sWeekend = request.getParameter("Weekend");
   String sSender = request.getParameter("Sender");
   String sUser = request.getParameter("User");
   String sText = request.getParameter("Text");
   String sRecipient = request.getParameter("To");
   String sReferTo =  request.getParameter("ReferTo");
   String sCancel =  request.getParameter("Cancel");
   String sFrom =  request.getParameter("From");

   String sReqAnsw = " ";

   if (sUser == null) sUser = sSender;
   if (sReferTo == null) sReferTo = " ";
   if (request.getParameter("ReqAnswer") != null) { sReqAnsw = "Y"; }
   if(sText==null) sText =  " ";
   if(sCancel==null) sCancel =  " ";

   String sUserId = null;

   //-------------- Security ---------------------
   String sAppl = "STRBYRMSG";
   if (session.getAttribute("USER")==null || session.getAttribute("STRBYRMSG") ==null)
   {
     Enumeration  en = request.getParameterNames();
     String sParam =null;
     String sPrmValue = null;
     String sTarget = "SignOn1.jsp?TARGET=StrBuyerMsgSave.jsp&APPL=" + sAppl;
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

     /*System.out.println(sStore + "|" + sWeekend + "|" + sSender + "|" + sUser + "|" + sRecipient
      + "|" + sText + "|" + sReqAnsw + "|" + sReferTo + "|" + sCancel); */
     StrBuyerMsgSave savemsg = new StrBuyerMsgSave(sStore, sWeekend, sSender, sRecipient,
        sReqAnsw, sReferTo, sUser, sCancel, sText);

     savemsg.disconnect();

     String sLink = "StrBuyerMsgBoard.jsp?Store=" + sStore
              + "&StrName=" + sStrName
              + "&Weekend=" + sWeekend;

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
  <br>StrName= <%=sStrName %>
  <br>Weekend= <%=sWeekend%>
  <br>Sender= <%=sSender%>
  <br>User= <%=sUser%>
  <br>Recipient= <%=sRecipient%>
  <br>Text= <%=sText%>
  <br>Required Reply = <%=sReqAnsw%>
  <br>Refered To = <%=sReferTo%>
  <br>Cancel = <%=sCancel%>

 <%}%>
 </body>
</html>
