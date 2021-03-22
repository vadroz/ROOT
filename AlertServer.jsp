<%@ page import="java.io.*, java.util.*, java.net.*, menu.AlertServer"%>
<%
     String sAction = request.getParameter("Action");

     if(sAction != null)
     {
        AlertServer alserver = new AlertServer();
     }
%>
<HTML>
<HEAD>
<title>RCI Alert Server</title>
<META content="RCI, Inc." name="RCI_Alert_Server">
</HEAD>

  <body>
  <!-------------------------------------------------------------------->
  <iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
  <!-------------------------------------------------------------------->

    <H1>Alert Server</H1>
    <br>Started at <%=(new Date())%>
    <br>Do not press refresh button
    <br>Do not close

    <br>
    <br>
    <br><button onClick="window.location.href='AlertServerStop.jsp'">Stop Alert Server</button>&nbsp;&nbsp;&nbsp;
  </body>
</html>

<script name="javascript1.2">
<%if(sAction == null){%>
   window.frame1.location.href = "AlertServer.jsp?Action=Start"
<%}%>
</script>
