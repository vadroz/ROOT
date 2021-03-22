<%@ page import="rciutility.StoreSelect"%>
<%
   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=BikeWorkshopSel.jsp&APPL=ALL");
   }
   else
   {
      StrSelect = new StoreSelect();
      StrSelect = new StoreSelect();
      sStr = StrSelect.getStrNum();
      sStrName = StrSelect.getStrName();
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

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<SCRIPT language="JavaScript">
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];

function bodyLoad(){
  doStrSelect();
}

// Load Stores
function doStrSelect(id) {
    var df = document.forms[0];

    for (idx = 1; idx < stores.length; idx++)
                df.Store.options[idx-1] = new Option(stores[idx] + " - " + storeNames[idx],stores[idx]);
    document.getStore.Store.selectedIndex=0;
}


// change action on submit
function submitForm(){
   var SbmString;
   var strIdx = document.getStore.Store.selectedIndex;
   var selStore = document.getStore.Store.options[strIdx].value;
   var selStoreName = storeNames[strIdx+1];
   var ticket = document.getStore.Ticket.value

   if(ticket.trim()=="") ticket = 0;

   SbmString = "BikeWorkShop.jsp"
        + "?Store=" + selStore
        + "&StrName=" + selStoreName
        + "&Ticket=" + ticket;

    //alert(SbmString);
    window.location.href=SbmString;
}
// --------------------------------------------------------------------------
// trim method
// --------------------------------------------------------------------------
String.prototype.trim = function()
{
  return( this.replace(/^\s*/,'').replace(/\s*$/,'') );
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
       <br>Bike Workshop - Store selection</b><br>

      <form name="getStore" action="javascript:submitForm()">
      <table>
      <!-- ----------------------------------------------------------------- -->
      <!-- Store Selection -->
      <!-- ----------------------------------------------------------------- -->
      <tr>
         <td>Select Store:</td><td><SELECT name="Store"></SELECT></td>
      </tr>
      <!-- ----------------------------------------------------------------- -->
      <!-- Ticket Entry -->
      <!-- ----------------------------------------------------------------- -->
      <tr>
         <td>Ticket #:</td><td><input name="Ticket" type="text" maxlength=10 size=10>
             <font size="-1">Leave a blank or 0 for a new one</font>
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
                </td>
            </tr>
       </table>

        </body>
      </html>
