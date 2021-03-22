<%@ page import="java.io.File, java.util.*"%>
<%
   String sFile = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT/CRM/" + request.getParameter("File");

%>
<script name="javascript1.2">
<% try {%>

<%  File file = new File(sFile);
    file.delete();%>
    parent.restart();
<%}
catch (Exception e) {%>
   alert("<%=e.getMessage()%>")
<%}%>


</script>