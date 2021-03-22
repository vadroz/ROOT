<%@ page import="rciutility.StoreSelect"%>
<%
   String sStrAllowed = null;

   StoreSelect strsel = new StoreSelect();
   String sStr = strsel.getStrNum();
   String sStrName = strsel.getStrName();
   int iNumOfStr = strsel.getNumOfStr();
   String [] sStrLst = strsel.getStrLst();
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

//------------------------------------------------------------------------------
// populate fields on page load
//------------------------------------------------------------------------------
function bodyLoad(){
  doWeekSelect();
  document.all.FROMWK.disabled=false;
}
//------------------------------------------------------------------------------
// Weeks Stores
//------------------------------------------------------------------------------
function doWeekSelect() {
    var df = document.all;
    var idx = 0;

    var todate = new Date();
    var sunday = new Date(todate.getFullYear(), todate.getMonth(), todate.getDate()-todate.getDay(), 18);

    // from date
    for (var idx = 0; idx < 90; idx++)
    {
      sundayUSA = eval(sunday.getMonth()+1) + "/" + sunday.getDate() + "/" + sunday.getFullYear();
      df.FROMWK.options[idx] = new Option(sundayUSA, sundayUSA);
      sunday.setTime(sunday.getTime() - (7 * 86400000));
    }

    // to date
    sunday = new Date(todate.getFullYear(), todate.getMonth(), todate.getDate()-todate.getDay(), 18);
    for (var idx = 0; idx < 90; idx++)
    {
      sundayUSA = eval(sunday.getMonth()+1) + "/" + sunday.getDate() + "/" + sunday.getFullYear();
      df.TOWK.options[idx] = new Option(sundayUSA, sundayUSA);
      sunday.setTime(sunday.getTime() - (7 * 86400000));
    }
}

//------------------------------------------------------------------------------
// change to date when from date selected. This will be prevent error when from
// date greater than to date
//------------------------------------------------------------------------------
function chgToDate(selTo)
{
  var df = document.all;

  var to = new Date(selTo.options[selTo.selectedIndex].value);
  var from = new Date(df.FROMWK.options[df.FROMWK.selectedIndex].value);

  if(to < from)
  {
    for (var i = 0; i < df.FROMWK.length; i++)
    {
      if(df.FROMWK.options[i].value <= selTo.options[selTo.selectedIndex].value)
      {

        df.FROMWK.selectedIndex = i;
        break;
      }
    }
  }
}
//------------------------------------------------------------------------------
// check all stores
//------------------------------------------------------------------------------
function checkAll(chk)
{
  var str = document.all.Str

  for(var i=0; i < <%=iNumOfStr%>; i++)
  {
     str[i].checked = chk;
  }
}
//------------------------------------------------------------------------------
// Validate entry
//------------------------------------------------------------------------------
function Validate()
{
   var error = false;
   var msg = "";

   // get selected stores
   var str = document.all.Str;
   var selstr = new Array();
   var numstr = 0
   var selnm = null;

   for(var i=0; i < str.length; i++)
   {
     if(str[i].checked){ selstr[numstr] = str[i].value; numstr++; selnm = storeNames[i+1]; }
   }

   if (numstr == 0){ error=true; msg+="At least 1 store must be selected.";}

   var frwkIdx = document.all.FROMWK.selectedIndex;
   var selFrWeek = document.all.FROMWK.options[frwkIdx].value;
   var towkIdx = document.all.TOWK.selectedIndex;
   var selToWeek = document.all.TOWK.options[towkIdx].value;

   if(error){alert(msg)}
   else{ submitForm(numstr, selstr, selnm, selFrWeek, selToWeek) }
}
//------------------------------------------------------------------------------
// change action on submit
//------------------------------------------------------------------------------
function submitForm(numstr, selstr, selnm, selFrWeek, selToWeek){
   var url;

   if(numstr == 1)
   {
      url = "StrProd2Dates.jsp?STORE=" + selstr[0]  + "&STRNAME=" + selnm
                + "&FROMWKEND=" + selFrWeek + "&TOWKEND=" + selToWeek;
   }
   else
   {
      url = "StrProd2DatesSum.jsp?FROMWKEND=" + selFrWeek + "&TOWKEND=" + selToWeek;
      for(var i=0; i < numstr; i++)
      {
        url += "&Str=" + selstr[i];
      }
   }

   //alert(url);
   window.location.href=url;
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
       <br>All Stores - Ranking by Date Range</b><br>

      <table>
      <!-- =============================================================================== -->
      <!-- Store list -->
      <!-- =============================================================================== -->
      <tr>
         <td>Store:</td>
         <td>
            <%for(int i=0; i < iNumOfStr; i++){%>
               <%if(!sStrLst[i].equals("55") && !sStrLst[i].equals("89")){%>
                  <%if(i == iNumOfStr / 2){%><br><%}%>
                  <input type="checkbox" name="Str" value="<%=sStrLst[i]%>"><%=sStrLst[i]%>&nbsp; &nbsp; &nbsp;
               <%}%>
            <%}%>
            <br><button onclick="checkAll(true)" class="Small">Check All</button> &nbsp; &nbsp;
                <button onclick="checkAll(false)" class="Small">Reset</button>
         </td>
      <!-- =============================================================================== -->
      <tr>
         <td colspan=2 style="border-bottom: darkred solid 1px; font-size: 3px">&nbsp;</td>
      </tr>
      <tr>
        <td>From Weekending:</td><td><SELECT name="FROMWK">
            </SELECT></td>
      </tr>
      <tr>
        <td>To Weekending:</td><td><SELECT name="TOWK" onChange="chgToDate(this)">
            </SELECT></td>
      </tr>
      <tr>
         <td align="center" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <button onClick="Validate()">Submit</button>
      </tr>
      </table>
                </td>
            </tr>
       </table>

        </body>
      </html>
