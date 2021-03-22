<%@ page import="rciutility.StoreSelect, java.util.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     out.println(request.getRequestURI());
     response.sendRedirect("SignOn1.jsp?TARGET=EvtCalSel.jsp&APPL=ALL");
   }
   else
   {
      StoreSelect  StrSelect = new StoreSelect();
      String sStr = StrSelect.getStrNum();
      String sStrName = StrSelect.getStrName();
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
  .small{ text-align:left; font-family:Arial; font-size:11px;}

  div.dvMenu {position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10}

</style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<SCRIPT language="JavaScript1.2">
var OptGroup = new Array();
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
   setYear();
   // populate store dropdown box
   doStrSelect();
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect() {
    var stores = [<%=sStr%>];
    var storeNames = [<%=sStrName%>];

    document.all.Store.options[0] = new Option("All Stores",stores[0]);
    for (idx = 1; idx < stores.length; idx++)
    {
       document.all.Store.options[idx] = new Option(stores[idx] + " - " + storeNames[idx],stores[idx]);
    }
}
//==============================================================================
// Setup Year drop-menu
//==============================================================================
function setYear()
{
  var curDate = new Date();
  var curMonth = curDate.getMonth() + 1;
  var curYear = curDate.getFullYear();
  if (curMonth > 4) curYear = eval(curYear) + 1;
  var max = 2;
  var year = curYear;
  year = curYear - 3;  max = 6;

  var optg = new Array();
  var selyr = new Array();

  // clear options
  for(var i=document.all.Year.length-1; i > 0; i--)
  {
    document.all.Year.options[i]=null;
  }

  for(var i=0; i < max; i++)
  {
     document.all.Year.options[i] = new Option(year, year);
     year++;
  }

  var month = ["April", "May", "June", "July", "August", "September", "October",
               "November", "December", "January", "February", "March"];
  for(var i=0; i < 12; i++)
  {
     document.all.Month.options[i] = new Option(month[i], i+1);
  }
}

//==============================================================================
// Validate
//==============================================================================
function Validate()
{
  var error = false;
  var msg = " ";
  var selq = false;

  if (error) alert(msg);

  return error == false;
}
//==============================================================================
// submit Event Clendar
//==============================================================================
function sbmEvtCal()
{
   var url = "EvtFisCal.jsp?"
   var year = document.all.Year.options[document.all.Year.selectedIndex].value;
   var month = document.all.Month.options[document.all.Month.selectedIndex].value;
   url += "YrMon=" + year + month
        + "&Store=" + document.all.Store.options[document.all.Store.selectedIndex].value

   //alert(url);
   window.location.href = url;
}
</SCRIPT>

</head>
<body  onload="bodyLoad();">

<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2">
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Event Fiscal Calendar - Selection</b><br>

      <form name="getStore" onSubmit="return Validate();" action="javascript:sbmEvtCal()" >
      <table>
      <!-- ----------------------------------------------------------------- -->
      <!-- Year Selection -->
      <!-- ----------------------------------------------------------------- -->
      <tr>
         <td valign="Top">Fiscal Year/Month:</td>
         <td>
            <SELECT name="Year" class="small"></SELECT>&nbsp; &nbsp;
            <SELECT name="Month" class="small"></SELECT>
         </td>
      </tr>
      <!-- ----------------------------------------------------------------- -->
      <!-- Year Selection -->
      <!-- ----------------------------------------------------------------- -->
      <tr>
         <td valign="Top">Store: </td>
         <td>
            <SELECT name="Store" class="small"></SELECT>
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