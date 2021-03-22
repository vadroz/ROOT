<%@ page import="salesigns01.ProdSignCreateFromExcel, java.text.*, java.util.*"%>
<%
   String sFile = request.getParameter("File");
   String sAction = request.getParameter("Action");
   if (sAction == null) sAction = "REDIRECT";
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=ProdSignCreateFromExcel.jsp");
}
else
{
	String sUser = session.getAttribute("USER").toString();
    boolean bError = false;
    if (sAction.equals("UPLOAD"))
    {
       System.out.println("Manifest: " + sFile);
       ProdSignCreateFromExcel crtSigns = new ProdSignCreateFromExcel(sFile, sUser);
       System.out.println("Manifest Uploaded");
       
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
   if (!error) { alert("Manifest have been uploaded.") }
   else { alert("Some error occured.") }
   parent.redisplay();
}
//==============================================================================
// re-submit
//==============================================================================
function resubmit()
{
   var File = document.all.File.value;
   var url = "ProdSignCreateFromExcel.jsp?File=" + replaceSlash(File.replaceSpecChar())
           + "&Action=UPLOAD";
   //alert(url);
   window.frame1.location.href=url
   document.all.mrqWait.style.display="block";
   document.all.tblProd.style.display="none";//
}
//==============================================================================
// replace backslashes pn strait one
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
  window.location.href="ProdSignCreateFromExcel.jsp"
}
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<MARQUEE id="mrqWait" style="display:none;"><font size = +2>Wait while tables are updating...</font></MARQUEE>

<TABLE height="100%" width="100%" border=0 id="tblProd">
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Create Product Signs From Excel
        </B><br><br>
        <br><a href="/"><font color="red" size="-1">Home</font></a>&#62;
       <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp
        <table>
        <tr style="text-align:left">
           <td>File:</td><td><input class="Small" type="File" name="File" size=50><td>
        </tr>
        <tr style="text-align:center">
         <td colspan=2><button onclick="resubmit();">Upload</button></td>
        </table>
    </td>
  <tr>
</table>

</body>
<%}%>



