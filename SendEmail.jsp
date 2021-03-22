<%@ page import="mail.SendMail, java.util.*"%>
<%
    String sSubject = request.getParameter("subject");
    String sFrom = request.getParameter("from");
    String sTo = request.getParameter("to");
    String sCc = request.getParameter("cc");
    String sBcc = request.getParameter("bcc");
    String sBody = request.getParameter("body");

    mail.SendMail sndmail = new mail.SendMail(sFrom, sTo, sCc, sBcc, null, sSubject, sBody);
    
    sndmail = null;
%>
<br><%=sSubject%>
<br><%=sFrom%>
<br><%=sTo%> 
<br><%=sCc%> 
<br><%=sBcc%>
<br><%=sBody%>