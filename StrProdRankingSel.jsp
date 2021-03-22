<%@ page import="rciutility.StoreSelect, payrollreports.SetWeeks"%>
<%
   String sStrAllowed = null;

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   StrSelect = new StoreSelect();
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();
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
var StrAllowed = "<%=sStrAllowed%>";

function bodyLoad(){
  doStrSelect();
  doWeekSelect();
  document.forms[0].WEEK.disabled=false;
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id)
{
    var df = document.forms[0];

    for (idx = 0; idx < stores.length; idx++)
    {
      df.STORE.options[idx] = new Option(stores[idx] + " - " + storeNames[idx],stores[idx]);
    }
}
//==============================================================================
// Weeks Stores
//==============================================================================
function doWeekSelect() {
    var df = document.forms[0];
    var idx = 0;

    var todate = new Date();
    todate.setHours = 18;
    sunday = new Date(todate.getFullYear(), todate.getMonth(), todate.getDate()-todate.getDay());
    sunday.setHours = 10;

    for (idx = 0; idx < 100; idx++)
    {
      sundayUSA = eval(sunday.getMonth()+1) + "/" + sunday.getDate() + "/" + sunday.getFullYear();
      df.WEEK.options[idx] = new Option(sundayUSA, sundayUSA);
      sunday.setHours = 18;
      sunday = new Date(sunday.getFullYear(), sunday.getMonth(), sunday.getDate()-7);
    }
}

//==============================================================================
// change action on submit
//==============================================================================
function submitForm(){
   var SbmString;
   var strIdx = document.getStore.STORE.selectedIndex;
   var selStore = document.getStore.STORE.options[strIdx].value;
   var selStoreName = storeNames[strIdx];
   var wkIdx = document.getStore.WEEK.selectedIndex;
   var selWeek = document.getStore.WEEK.options[wkIdx].value;
   if(strIdx != 0)   SbmString = "StrProdRanking.jsp?STORE=" + selStore  + "&STRNAME=" + selStoreName
                             + "&WEEKEND=" + selWeek;
   else  SbmString = "StrProdRankingSum.jsp?WEEKEND=" + selWeek;

    //alert(SbmString);
    window.location.href=SbmString;
}

</SCRIPT>
          </head>
 <body  onload="bodyLoad();">

  <table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2">
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>All Stores - Ranking by Week</b><br>

      <form name="getStore" action="javascript:submitForm()">
      <table>
      <tr>
         <td>Select Store:</td><td><SELECT name="STORE"></SELECT></td>
      <tr>
        <td>Select Weekending:</td>
        <td><SELECT name="WEEK"></SELECT></td>
      </tr>


      <tr>
         <td align="center" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <input type="submit" value="Submit">&nbsp;&nbsp;&nbsp;&nbsp;
      </tr>
      </table>
      </form>
                </td>
            </tr>
       </table>

        </body>
      </html>
