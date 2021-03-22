<%@ page import="java.util.*, java.sql.*, rciutility.RunSQLStmt"%>
<%
   String sPrepStmt = "select piwe from rci.fsyper a"
    + " where piwe <= current date and piwe >= piyb"
    + " and pida = piwe "
    + " order by piwe desc"
    + " fetch first 60 rows only";

      System.out.println(sPrepStmt);

      String sWkend = "";
      String sComa = "";

      ResultSet rs = null;
      RunSQLStmt runsql = new RunSQLStmt();
      runsql.setPrepStmt(sPrepStmt);
      rs = runsql.runQuery();
      while(runsql.readNextRecord())
      {
        sWkend += sComa + "\"" + runsql.getData("piwe") + "\"";
        sComa=",";
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
// ----------------------- Global variables --------------------
Weeks = [<%=sWkend%>];

// -------------------- End Global variables -------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad(){
  doWeekSelect();
}
//==============================================================================
// Weeks Stores
//==============================================================================
function doWeekSelect() {
    var df = document.forms[0];
    var todate = new Date();

    var sunday;
    var max = 20;
    var sundayUSA = new Array();

    for (var i = 0; i < Weeks.length; i++)
    {
        sunday = new Date(Weeks[i].substring(0, 4), eval(Weeks[i].substring(5, 7)) - 1, Weeks[i].substring(8));
        sunday.setHours(18);
        sundayUSA[i] = eval(sunday.getMonth()+1) + "/" + sunday.getDate() + "/" + sunday.getFullYear();
        sunday.setTime(sunday.getTime() - (7 * 86400000));
    }

    if(Weeks.length < max)
    {
       sunday = new Date(Weeks[Weeks.length-1].substring(0, 4),
                    eval(Weeks[Weeks.length-1].substring(5, 7)) - 1,
                         Weeks[Weeks.length-1].substring(8));
       sunday.setHours(18);
       for (var i = 0; i < max - Weeks.length; i++)
       {
          sundayUSA[sundayUSA.length] = eval(sunday.getMonth()+1) + "/" + sunday.getDate() + "/" + sunday.getFullYear();
          sunday.setTime(sunday.getTime() - (7 * 86400000));
       }
    }

    for (var i = 0; i < sundayUSA.length; i++)
    {
       df.FROMWK.options[i] = new Option(sundayUSA[i], sundayUSA[i]);
       df.TOWK.options[i] = new Option(sundayUSA[i], sundayUSA[i]);
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
//==============================================================================
// change action on submit
//==============================================================================
function submitForm(){
   var SbmString;
   var selTop = document.getTopSlr.TOPSLR.value;
   var wkIdx = document.getTopSlr.FROMWK.selectedIndex;
   var from = document.getTopSlr.FROMWK.options[wkIdx].value;
   var wkIdx = document.getTopSlr.TOWK.selectedIndex;
   var to = document.getTopSlr.TOWK.options[wkIdx].value;

   SbmString = "StrProdRankingTop20.jsp?TOPSLR=" + selTop
      + "&FROMWK=" + from
      + "&TOWK=" + to;

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
       <br>Top Salesperson Ranking</b><br>

      <form name="getTopSlr" action="javascript:submitForm()">
      <table>
      <tr>
         <td>Number of returned top sellers: </td><td><input name="TOPSLR" value="20" size="2" maxlength="2"></td>
      </tr>
      <!-- ================================================================= -->
      <!--  -->
      <!-- ================================================================= -->
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
         <input type="submit" value="Submit">&nbsp;&nbsp;&nbsp;&nbsp;
      </tr>
      </table>
      </form>
                </td>
            </tr>
       </table>

        </body>
      </html>
