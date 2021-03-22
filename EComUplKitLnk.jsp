<%@ page import="ecommerce.EComUplKitLnk"%>
<%
   String sSite = request.getParameter("Site");
   String sAction = request.getParameter("Action");
   if (sAction == null) sAction = "REDIRECT";
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComUplKitLnk.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    if (sAction.equals("UPLOAD"))
    {
       System.out.println(sSite);
       EComUplKitLnk uplkit = new EComUplKitLnk(sSite, sUser);
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
   alert("Payment Log Tables Updated")
   parent.redisplay();
}
//==============================================================================
// re-submit
//==============================================================================
function resubmit()
{
   var selSite = document.all.Site;
   var site = null;
   for(var i=0; i < selSite.length; i++)
   {
      if (document.all.Site[i].checked) { site = document.all.Site[i].value; break;}
   }

   var url = "EComUplKitLnk.jsp?Site=" + site
           + "&Action=UPLOAD";
   //alert(url);
   window.frame1.location.href=url
   document.all.mrqWait.style.display="block";
   document.all.tblSite.style.display="none";//
}
//==============================================================================
// re-submit
//==============================================================================
function redisplay()
{
  // return to main page
  window.location.href="EComUplKitLnk.jsp"
}
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame2"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<MARQUEE id="mrqWait" style="display:none;"><font size = +2>Wait while tables are updating...</font></MARQUEE>

<TABLE height="100%" width="100%" border=0 id="tblSite">
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>E-Commerce - Payment Log Uploading
        </B><br>
        Select Sites: &nbsp; &nbsp;
        <input class="Small" name="Site" type="radio" value="SASS" checked>Sun and Ski Sports &nbsp; &nbsp; &nbsp;
        <input class="Small" name="Site" type="radio" value="SKCH">Ski Chalet &nbsp; &nbsp; &nbsp;
        <input class="Small" name="Site" type="radio" value="SSTP">Ski Stop &nbsp; &nbsp; &nbsp;
        <input class="Small" name="Site" type="radio" value="RLHD">Railhead &nbsp; &nbsp; &nbsp;
        <button onclick="resubmit();">Upload</button>

       <br><a href="/"><font color="red" size="-1">Home</font></a>&#62;
       <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp
    </td>
  <tr>
</table>

</body>
<%}%>



