<%@ page import="patiosales.WarrantyClaimVen ,java.util.*, java.text.*"%>
<%
   String sVen = request.getParameter("Ven");

//----------------------------------
// Application Authorization
//----------------------------------
String sUser = session.getAttribute("USER").toString();

if (session.getAttribute("USER")!=null)
{
    WarrantyClaimVen wcveninf = new WarrantyClaimVen();
    wcveninf.getVenInfo(sVen, sUser);

    String sVenNm = wcveninf.getVenNm();
    String sAcct = wcveninf.getAcct();
    String sClaim = wcveninf.getClaim();
    String sForm = wcveninf.getForm();
    String sEmail = wcveninf.getEmail();
    String sMainPhn = wcveninf.getMainPhn();
    String sMainEmail = wcveninf.getMainEmail();
    String sContact = wcveninf.getContact();
    String sContPhn1 = wcveninf.getContPhn1();
    String sContPhn2 = wcveninf.getContPhn2();
    String sContEmail = wcveninf.getContEmail();
    String sReply = wcveninf.getReply();
    String sRepPhn1 = wcveninf.getRepPhn1();
    String sRepPhn2 = wcveninf.getRepPhn2();
    String sRepEmail = wcveninf.getRepEmail();
    String sRecUs = wcveninf.getRecUs();
    String sRecDt = wcveninf.getRecDt();
    String sRecTm = wcveninf.getRecTm();

    wcveninf.disconnect();
    wcveninf = null;
%>
<SCRIPT language="JavaScript1.2">
  var ven = "<%=sVen%>";
  var venNm = "<%=sVenNm%>";
  var acct = "<%=sAcct%>";
  var claimSbm = "<%=sClaim%>";
  var form = "<%=sForm%>";
  var email = "<%=sEmail%>";
  var mainPhn = "<%=sMainPhn%>";
  var mainEmail = "<%=sMainEmail%>";
  var contact = "<%=sContact%>";
  var contPhn1 = "<%=sContPhn1%>";
  var contPhn2 = "<%=sContPhn2%>";
  var contEmail = "<%=sContEmail%>";
  var rep = "<%=sReply%>";
  var repPhn1 = "<%=sRepPhn1%>";
  var repPhn2 = "<%=sRepPhn2%>";
  var repEmail = "<%=sRepEmail%>";
  var recUsr = "<%=sRecUs%>";
  var recDt = "<%=sRecDt%>";
  var recTm = "<%=sRecTm%>";

  parent.showVenInfo(ven, venNm, acct, claimSbm, form, email, mainPhn, mainEmail, contact, contPhn1, contPhn2, contEmail
                     , rep, repPhn1, repPhn2, repEmail, recUsr, recDt, recTm);
</SCRIPT>

<%}
else {%>
<SCRIPT language="JavaScript1.2">
 alert("You are not authorized to modify claim.")
</SCRIPT>

<%}%>





