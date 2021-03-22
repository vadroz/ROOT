<%@ page import="java.security.*"%>
Creation Time: <%=session.getCreationTime()%><br>
Id: <%=session.getId()%><br>
Rem User: <%=request.getRemoteUser()%><br>
Auth: <%=request.getAuthType()%><br>
<% Principal p = request.getUserPrincipal();%>
<% if (p==null) out.println("null");%>

