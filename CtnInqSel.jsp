<%@ page import="java.util.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=CtnInqSel.jsp&APPL=ALL");
   }
   else
   {
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
  th.DataTable { padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;background:#FFE4C4;border-right: darkred solid 1px;text-align:center; font-family:Arial; font-size:10px }
  td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px; }
  td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
  td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }

  div.Menu { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
  tr.Grid1 { text-align:center; font-family:Arial; font-size:10px;}
  td.Grid  { background:darkblue; color:white; text-align:center;
             font-family:Arial; font-size:11px; font-weight:bolder}
  td.Grid2  { background:darkblue; color:white; text-align:right;
              font-family:Arial; font-size:11px; font-weight:bolder}
  .small{ text-align:left; font-family:Arial; font-size:10px;}

  div.dvMenu {position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10}

</style>

<SCRIPT language="JavaScript">

//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
}
//==============================================================================
// Validate form entry
//==============================================================================
function Validate()
{
   var error = false;
   var msg = "";
   var ctn = document.all.Carton.value.trim();
   if(ctn == ""){ error = true; msg = "\nPlease, enter carton number." }
   else if(isNaN(ctn)){ error = true; msg = "\nCarton is not numeric." }

   if (error) { alert(msg) }

   return !error;
}
</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

</head>

<body  onload="bodyLoad();">

 <!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="menu" class="Menu"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2">
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Carton Inquiry - Selection</b><br>

      <form name="CtnInq" action="CtnInq.jsp" method="GET" onsubmit="return Validate();">
      <table>
      <!-- ----------------------------------------------------------------- -->
      <!-- Carton Selection -->
      <!-- ----------------------------------------------------------------- -->
      <tr>
         <td>Carton Number</td>
         <td>
            <input name="Carton" size=20 maxlength=20>
         </td>
      </tr>
      <!-- ----------------------------------------------------------------- -->
      <!-- Command buttons -->
      <!-- ----------------------------------------------------------------- -->
      <tr>
         <td align="center" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;
         <input type="submit" value="Submit">
      </tr>
      </table>
      </form>
        <a href="../"><font color="red" size="-1">Home</font></a>
      </td>
     </tr>
    </table>
  </body>
</html>
<%}%>