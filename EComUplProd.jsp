<%@ page import="ecommerce.EComUplProd"%>
<%
   String sSite = request.getParameter("Site");
   String sAction = request.getParameter("Action");
   if (sAction == null) sAction = "REDIRECT";
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComUplProd.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    if (sAction.equals("UPLOAD"))
    {
       System.out.println(sSite);
       EComUplProd uplprod = new EComUplProd(sSite, sUser);
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
   alert("Product Tables Updated")
   parent.goToMainPage();
}
//==============================================================================
// re-submit
//==============================================================================
function resubmit()
{
   var chkSite = document.all.Site;
   var site = null;

   for(var i=0; i < chkSite.length; i++)
   {
      if (chkSite[i].checked) { site = chkSite[i].value; break; }
   }
   var url = "EComUplProd.jsp?Site=" + site
           + "&Action=UPLOAD";
   //alert(url);
   window.frame1.location.href=url

   document.all.mrqWait.style.display="block";
   document.all.tblSite.style.display="none";
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
<iframe  id="frame2"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<MARQUEE id="mrqWait" style="display:none;"><font size = +2>Wait while tables are updating...</font></MARQUEE>

<TABLE height="100%" width="100%" border=0 id="tblSite">
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>E-Commerce - Product Uploading
        </B><br>
        Select Sites: &nbsp; &nbsp;
        <input class="Small" name="Site" type="radio" value="SASS" checked>Sun and Ski Sports &nbsp; &nbsp; &nbsp;
        <input class="Small" name="Site" type="radio" value="SKCH">Ski Chalet &nbsp; &nbsp; &nbsp;
        <input class="Small" name="Site" type="radio" value="SSTP">Ski Stop &nbsp; &nbsp; &nbsp;
        <input class="Small" name="Site" type="radio" value="RLHD">Rebel Board Sports &nbsp; &nbsp; &nbsp;
        <input class="Small" name="Site" type="radio" value="RACK">Total Car Racks
        <br>
        <button onclick="resubmit();">Upload</button>
    </td>
  <tr>
</table>
</body>
<%}%>



