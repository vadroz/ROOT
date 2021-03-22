<%@ page import="salesigns01.SlsSignCreateFromExcel"%>
<%
   String sEvent = request.getParameter("Event");
   String sFile = request.getParameter("File");
   String sAction = request.getParameter("Action");
   if (sAction == null) sAction = "REDIRECT";
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=SlsSignCreateFromExcel.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    boolean bError = false;
    if (sAction.equals("UPLOAD"))
    {
       System.out.println("Manifest: " + sFile + "  Event: " + sEvent);
       SlsSignCreateFromExcel crtSigns = new SlsSignCreateFromExcel(sFile, sEvent, sUser);
       bError = crtSigns.getError();
       crtSigns.disconnect();
       crtSigns = null;
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
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   <%
   if(sAction.equals("UPLOAD")) {%>
     showMessage();
   <%}%>
}
//==============================================================================
// show error
//==============================================================================
function showMessage()
{
   var error = <%=bError%>
   if (!error) { alert("Payment Log Tables Updated") }
   else { alert("Some error occured.") }
   parent.redisplay();
}
//==============================================================================
// re-submit
//==============================================================================
function resubmit()
{
   var Event = document.all.Event.value;
   var File = document.all.File.value;
   var url = "SlsSignCreateFromExcel.jsp?File=" + replaceSlash(File.replaceSpecChar())
           + "&Event=" + Event
           + "&Action=UPLOAD";
   //alert(url);
   window.frame1.location.href=url
   document.all.mrqWait.style.display="block";
   document.all.tblEvent.style.display="none";//
}
//==============================================================================
//replace backslashes pn strait one
//==============================================================================
function replaceSlash(file)
{		
	file = file.replace(/\\/g, "/");	
	return file;
}
//==============================================================================
// re-submit
//==============================================================================
function redisplay()
{
  // return to main page
  window.location.href="SlsSignCreateFromExcel.jsp"
}
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<MARQUEE id="mrqWait" style="display:none;"><font size = +2>Wait while tables are updating...</font></MARQUEE>

<TABLE height="100%" width="100%" border=0 id="tblEvent">
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Create Sale Signs From Manifest
        </B><br><br>
        <br><a href="/"><font color="red" size="-1">Home</font></a>&#62;
       <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp
        <table>
        <tr style="text-align:left">
           <td>File:</td><td><input class="Small" type="File" name="File" size=50><td>
        </tr>
        <tr style="text-align:left">
           <td>Events:</td><td><input class="Small" name="Event" size=2 maxlength=2></td>
        </tr>
        <tr style="text-align:center">
         <td colspan=2><button onclick="resubmit();">Upload</button></td>
        </table>
    </td>
  <tr>
</table>

</body>
<%}%>



