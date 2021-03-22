<%@ page import="menu.*, java.util.*, java.text.*"%>
<%
    String sUrl = request.getParameter("Url");
    String sMenu = request.getParameter("Menu");
    String sUser = request.getParameter("User");

    SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
    Calendar cal = Calendar.getInstance();
    cal.add(Calendar.DATE, -1);
    Date date = cal.getTime();
    String sUsgDate = df.format(date);

    System.out.print(sUsgDate + "  URL:" + sUrl + " User: " + sUser);
%>

