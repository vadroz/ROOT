<%@ page import="java.util.*, java.text.*"%>
<%
// check when user signon for this session
java.util.Date sessDate = null;
long lElapse = 99999;
if(session.getAttribute("DATE")!=null)
{
  sessDate = (java.util.Date)session.getAttribute("DATE");
  lElapse = (new java.util.Date()).getTime() -   sessDate.getTime();
}

if (session.getAttribute("USER")==null  || session.getAttribute("EMPSALARY")==null || lElapse > 3000)
{
   response.sendRedirect("SignOn1.jsp?TARGET=CredCardInq.jsp&APPL=ALL");
}
else
{   
	
	response.sendRedirect("https://balance.worldpay.us/GLCardBalance.aspx");
	
%>

<style>
  .Small {font-family: times; font-size:10px }
  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top}
  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
        width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
 
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
    
} 
</script>

<HTML><HEAD>

<meta http-equiv="refresh" content="10; url=index.jsp">

<BODY onload="bodyLoad();">
<a class="blue" href="https://balance.worldpay.us/GLCardBalance.aspx" target="_blank">
      		   <img alt="Ride" src="MainMenu/S&S Gift Card.jpg" style="width:42px;height:22px; border:0;vertical-align:middle;">
      		   Sun & Ski Gift Card Balance Inquiry</a>
</BODY></HTML>
<%}%>