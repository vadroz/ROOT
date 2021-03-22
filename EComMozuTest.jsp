    <%@ page import="java.util.*, java.text.*"
       contentType="x-vol-app-claims;"   
    %>
<%
%>
<html>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<script language="javascript">
function sbmAppl()
{
	document.all.frmAuth.submit(); 
}
</script>
<body>
<form action="https://t2659.sandbox.mozu.com/api/platform/applications/authtickets/" 
      method="POST" id="frmAuth" >
      <input name="ApplicationId" value="afa8d0c.getorder001.1.0.0.release">
      <input name="SharedSecret" value="c77ba3eb972c4504973666fd1e2c1b68">
</form>
<button onclick="sbmAppl()">Submit</button>
</body>
</html>




