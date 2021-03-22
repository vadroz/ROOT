<jsp:include page="ChkLogin.jsp">
   <jsp:param name="APPL" value="PAYROLL" />
</jsp:include>
<%
  int iSession = tomcatsecurity.SessionGuard.getActiveSessions();
%>
<script name="javascript">
</script>
<HTML><HEAD>
<BODY >

<h1>Tomcat Security Test</h1>
URI:  <%=request.getRequestURI()%><br>
  <%=request.getQueryString()%><br>
  Session counter = <%=iSession%>

</BODY>
</HTML>
