<%@ page import="java.text.*, java.util.*, mozu_com.MozuVenSumAttrSv, java.sql.ResultSet"%>
<%
   String sSite = request.getParameter("Site");
   String sVen = request.getParameter("Ven");
   String sType = request.getParameter("Type");
   String sNote = request.getParameter("Note");
   String sAction = request.getParameter("Action");
   
//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null)
{  		
	String sUser = session.getAttribute("USER").toString();
	MozuVenSumAttrSv vensum = new MozuVenSumAttrSv();
	vensum.saveNote(sSite, sVen, sType, sNote, sAction, sUser);
%>
	
<SCRIPT>
	parent.location.reload();
</SCRIPT>
<%}
  else {%>
  <SCRIPT language="JavaScript1.2">
      alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  </SCRIPT>
  <%}%>

