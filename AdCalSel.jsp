<%@ page import="java.util.*, advertising.AdCalSel"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     out.println(request.getRequestURI());
     response.sendRedirect("SignOn1.jsp?TARGET=AdCalSel.jsp&APPL=ALL");
   }
   else
   {
     AdCalSel adCalSel = new AdCalSel();

     String sMonBegJsa = adCalSel.getMonBegJsa();
     String sMonNameJsa = adCalSel.getMonNameJsa();
     String sYearJsa = adCalSel.getYearJsa();
     String sCurMon = adCalSel.getCurMon();

     adCalSel.disconnect();
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

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<SCRIPT language="JavaScript">
var MonBegs = [<%=sMonBegJsa%>];
var MonName = [<%=sMonNameJsa%>];
var Year = [<%=sYearJsa%>];
var CurMon = "<%=sCurMon%>";

//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
   setMonth();
}
//==============================================================================
// Setup month drop-menu
//==============================================================================
function setMonth()
{
  var df = document.forms[0];
  for (var i = 0; i < MonBegs.length; i++)
  {
    df.FiscMon.options[i] = new Option(MonName[i] + "  " + Year[i], MonBegs[i]);
  }
  df.FiscMon.selectedIndex = CurMon;
}

//==============================================================================
// submit Advertising List Page
//==============================================================================
function sbmAdList()
{
  var sel = document.forms[0].FiscMon.selectedIndex;
  var comparison = document.forms[0].Ty_vs_Ly.checked;
  var url = "AdCal.jsp?"
  if(comparison)
  {
    url = "AdCalTyVsLy.jsp?"
  }
   url += "&MonBeg=" + document.forms[0].FiscMon[sel].value
        + "&MonName=" + document.forms[0].FiscMon[sel].text
        + "&Year=" + Year[sel]
   //alert(url);
   window.location.href = url;
}
</SCRIPT>
          </head>
 <body  onload="bodyLoad();">

 <!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
<div id="menu" class="Menu"></div>
<!--div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2">
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Advertising - Month Selection</b><br>

      <form name="getStore" action="javascript:sbmAdList()" >
      <table>
      <!-- ----------------------------------------------------------------- -->
      <!-- Month Selection -->
      <!-- ----------------------------------------------------------------- -->
      <tr>
         <td>Month Date</td>
         <td>
            <SELECT name="FiscMon"></SELECT>
         </td>
      </tr>
      <!-- ----------------------------------------------------------------- -->
      <!-- Month Selection -->
      <!-- ----------------------------------------------------------------- -->
      <tr>
         <td colspan=2>TY vs. LY
            <input name="Ty_vs_Ly" type="checkbox" value="Y">
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