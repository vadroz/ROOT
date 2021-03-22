<%@ page import="rciutility.StoreSelect,  java.util.*"%>
<%
  //----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=VendorReportCardSel.jsp&APPL=ALL");
}
else
{
   StoreSelect StrSelect = new StoreSelect(4);
   String sUser = session.getAttribute("USER").toString();
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
  .small{ text-align:left; font-family:Arial; font-size:10px;}
</style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<SCRIPT language="JavaScript">
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];
var User = "<%=sUser%>";
//==============================================================================
// initial processes
//==============================================================================
function bodyLoad(){
  doStrSelect();

  var date = new Date(new Date() - 86400000);
  document.all.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
  var date = new Date(new Date() - 86400000 * 7);
  document.all.FrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id)
{
    var df = document.all;
    for (var i=0; i < stores.length; i++)
    {
      df.STORE.options[i] = new Option(stores[i] + " - " + storeNames[i],stores[i]);
    }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// change action on submit
//==============================================================================
function submitReport(){
   var url;
   var strIdx = document.all.STORE.selectedIndex;
   var selStore = document.all.STORE.options[strIdx].value;
   var selStoreName = storeNames[strIdx+1];
   var from = document.all.FrDate.value;
   var to = document.all.ToDate.value;

   url = "UnscanSkuRep.jsp"
        + "?Store=" + selStore
        + "&StrName=" + selStoreName
        + "&From=" + from
        + "&To=" + to

    //alert(url);
    window.location.href = url;
}
</SCRIPT>
<script LANGUAGE="JavaScript1.3" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.3" src="Calendar.js"></script>

</head>
<body  onload="bodyLoad();">

 <!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2">
        <img src="Sun_ski_logo1.jpg" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Unscannable SKU Report - Selection</b><br>

      <table>
      <tr>
         <td>Select Store:</td><td><SELECT name="STORE"></SELECT></td>
      </tr>

      <!-- ============== select Date Range ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="2">&nbsp;</TD></TR>
        <TR>
          <TD align=center style="padding-top: 10px;">From Date:</td>
          <TD align=center style="padding-top: 10px;">
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrDate')">&#60;</button>
              <input class="Small" name="FrDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 650, 200, document.all.FrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </td>
        </tr>
        <tr>
        <TD align=center style="padding-top: 10px;">To Date:</td>
        <TD align=center style="padding-top: 10px;">
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate')">&#60;</button>
              <input class="Small" name="ToDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 650, 200, document.all.ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
          </TD>
        </TR>
     <!-- ========================== Submit ================================ -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="2">&nbsp;</TD></TR>
      <tr>
         <td align="center" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <button onClick="submitReport()">Submit</button>
      </tr>
      </table>

     </td>
     </tr>
    </table>
  </body>
</html>
<%}%>