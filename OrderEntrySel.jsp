<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=OrderEntrySel.jsp&APPL=ALL");
   }
   else
   {

   }
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
</style>


<SCRIPT language="JavaScript">
//==============================================================================
// run at body loading time
//==============================================================================
function bodyLoad()
{
}

//==============================================================================
// change action on submit
//==============================================================================
function submitForm()
{
   var SbmString;
   var order = document.ordent.Order.value

   if(order.trim()=="") order = 0;

   SbmString = "OrderEntry.jsp"
        + "?Order=" + order;

    //alert(SbmString);
    window.location.href=SbmString;
}
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

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
       <br>Patio Furniture Sales - Order Selection</b><br>

      <form name="ordent" action="javascript:submitForm()">
      <table>
      <!-- ----------------------------------------------------------------- -->
      <!-- Order Entry -->
      <!-- ----------------------------------------------------------------- -->
      <tr>
         <td align=center>Order #:&nbsp;<input name="Order" type="text" maxlength=10 size=10></td>

      </tr>
      <!-- ----------------------------------------------------------------- -->
      <!-- Command buttons -->
      <!-- ----------------------------------------------------------------- -->
      <tr><td align="center" colspan=3>
         <input type="submit" value="Submit">&nbsp;&nbsp;
         <input type="submit" onClick="document.all.Order.value='';" value="New Order">
         <br><br>
         <div style="text-align:left; color: darkblue; font-weight:bold;">
             Note: Order entry is only for items that requre delivery or pick-up.<br>
             Ring carry-out items directly in POS.
         </div>
         <br>
         <a href="../"><font color="red" size="-1">Home</font></a>
      </tr>
      </table>
      </form>
                </td>
            </tr>
       </table>

        </body>
      </html>
