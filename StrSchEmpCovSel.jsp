<%@ page import="rciutility.StoreSelect, java.util.*"%>
<%
  //----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=StrSchEmpCovSel.jsp&APPL=ALL");
}
else
{
   String sUser = session.getAttribute("USER").toString();

   StoreSelect StrSelect = new StoreSelect(4);
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
function bodyLoad()
{
  doStrSelect();

  var date = new Date();
  date.setHours(18);
  while( date.getDay() != 0 )
  {
     var date = new Date(date.getTime() - -86400000);
  }

  document.all.Date.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id)
{
    var df = document.all;
    df.Store.options[0] = new Option("Bike Stores Only", "BIKE");

    for (var i=0, j=1; i < stores.length; i++, j++)
    {
      df.Store.options[j] = new Option(stores[i] + " - " + storeNames[i],stores[i]);
    }
    var next = stores.length;
    df.Store.options[next++] = new Option("Region 1", "REG01");
    df.Store.options[next++] = new Option("Region 2", "REG02");
    df.Store.options[next++] = new Option("Region 3", "REG03");
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000 * 7);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000 * 7);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// change action on submit
//==============================================================================
function submitReport()
{
   var str = document.all.Store[document.all.Store.selectedIndex].value
   var strnm = document.all.Store[document.all.Store.selectedIndex].text
   var date = document.all.Date.value;
   var slsmaxlvl = document.all.SlsMaxLvl.value;
   var slsminlvl = document.all.SlsMinLvl.value;


   if(isNaN(slsmaxlvl)) { alert("Salary Threshold is not a valid number") }
   else if(isNaN(slsminlvl)) { alert("Salary Minimum level is not a valid number") }
   else
   {

     var url = "StrSchEmpCov.jsp?"
          + "Store=" + str
          + "&StoreNm=" + strnm
          + "&Wkend=" + date
          + "&SlsMaxLvl=" + slsmaxlvl
          + "&SlsMinLvl=" + slsminlvl
          + "&Group=SLBK"

     //alert(url);
     window.location.href = url;
  }
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
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Store Scheduled Employee Coverage Analysis - Selection</b><br>
       <br><a href="index.jsp"><font size="-1" color="red">Home</font></a>
      <table>
      <!-- ================================ Store ========================== -->
      <tr>
         <td>Select Store:</td><td><SELECT class="Small" name="Store"></SELECT></td>
      </tr>
      <!-- ============== select Date Range ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="2">&nbsp;</TD></TR>
        <TR><TD colspan="2">&nbsp;</TD></TR>
        <TR>
          <TD align=right >Weekending:</td>
          <TD align=left >
              <button class="Small" name="Down" onClick="setDate('DOWN', 'Date')">&#60;&#60;</button>
              <input class="Small" name="Date" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'Date')">&#62;&#62;</button>
          </td>
        </tr>
        <!-- ============== select Sales Minimum and Max Level============== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="2">&nbsp;</TD></TR>
        <TR><TD colspan="2">&nbsp;</TD></TR>
        <TR>
          <TD align=center colspan=2><b><u>Bike Sales Per Hour</u></b></td>
        <TR>
          <TD align=right >Threshold:</td>
          <TD align=level>
              <input class="Small" name="SlsMaxLvl" type="text" size=5 maxlength=5 value="500">
          </td>
        </tr>
        <TR>
          <TD align=right >Minimum:</td>
          <TD align=level>
              <input class="Small" name="SlsMinLvl" type="text" size=5 maxlength=5 value="50">
          </td>
        </tr>
        <TR>
          <TD align=center colspan=2>(also includes time periods with no bike sales coverage)</td>
        <TR>

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