<%@ page import="ecommerce.EComUpload"%>
<%
   String sAction = request.getParameter("Action");
   if (sAction == null) sAction = "REDIRECT";
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComUpload.jsp");
}
else
{
	String sUser = session.getAttribute("USER").toString();
    int iNumOfErr = 0;
    String sError = null;
    if (sAction.equals("UPLOAD"))
    {
       EComUpload uplord = new EComUpload(sUser);
       iNumOfErr = uplord.getNumOfErr();
       sError = uplord.getError();
    }
%>
<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>
<style>
  body {background:ivory;}
</style>
<script name="javascript1.2">
var NumOfErr = 0;
var Error = null;
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   <%
   if(sAction.equals("UPLOAD")) {%>
     var NumOfErr = <%=iNumOfErr%>;
     var Error = [<%=sError%>]
     showMessage();
   <%}
   else {%>
     resubmit()
   <%}%>
}
//==============================================================================
// show error
//==============================================================================
function showMessage()
{
   if(NumOfErr == 0) { alert("Order Tables Updated") }
   else { alert(Error) }
   parent.goToMainPage();
}
//==============================================================================
// re-submit
//==============================================================================
function resubmit()
{
   var url = "EComUpload.jsp?Action=UPLOAD";
   //alert(url);
   window.frame1.location.href=url

}
//==============================================================================
// re-submit
//==============================================================================
function goToMainPage()
{
  // return to main page
  window.location.href="index.jsp"
}
//==============================================================================
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<h1>Upload Order Files to As400</h1>
   <MARQUEE><font size = +2>Wait while tables are updating...</font></MARQUEE>
</body>
<%}%>