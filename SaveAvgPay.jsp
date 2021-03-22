<%@ page import="payrollreports.SaveAvgPay"%>
<% // Get query string parameters
   String sStore = request.getParameter("STORE");
   String sStrName = request.getParameter("STRNAME");
   String sWeek = request.getParameter("WEEK");
   String sSelAvgPay = request.getParameter("SELLAVGPAY");
   String sNSlAvgPay = request.getParameter("NONSAVGPAY");
   String sSelPrc = request.getParameter("SELLPRC");
   String sNSlPrc = request.getParameter("NONSPRC");
   SaveAvgPay svpay = new SaveAvgPay(sStore, sWeek, sSelAvgPay, sNSlAvgPay, sSelPrc, sNSlPrc);
   svpay.disconnect();
     // redirect to topic list
    String sLink = "AvgPayRep.jsp?STORE=" + sStore
                 + "&STRNAME=" + sStrName;
    svpay.disconnect();
    response.sendRedirect(sLink);
 %>

<html>
<head>

</head>
 <body>
<!-- Test:
  <p align="left">Selling Personnel Average:
  <p align="left">Non-Selling Personnel Average:
  <p align="left">Selling Personnel Procents:
  <p align="left">Non-Selling Personnel Procents: -->
 </body>
</html>
