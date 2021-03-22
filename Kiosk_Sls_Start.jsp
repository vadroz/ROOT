<%@ page import="java.text.*, java.util.*, java.sql.ResultSet"%>
<%
    String sFrDate = request.getParameter("From");
    String sToDate = request.getParameter("To");

    System.out.println("Start Kiosk_Sls_Start.jsp.");

    String sUrl = "Kiosk_Sls_by_js.jsp?From=" + sFrDate + "&To=" + sToDate;
    response.sendRedirect(sUrl);
%>
<html>
<head>
  <title>Kiosk Sales redirect</title>
</head>
<h1>Kiosk Sales redirect</h1>
<body>

</body>
</html>


