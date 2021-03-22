<%@ page import="java.util.*, java.text.*, ecommerce.EcDailyShipToStr_as_CSV"%>
<%
    String sDate = request.getParameter("Date");
    EcDailyShipToStr_as_CSV dlysts = new EcDailyShipToStr_as_CSV(sDate);
    dlysts = null;
%>
