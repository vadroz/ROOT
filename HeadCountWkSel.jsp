<%@ page import="rciutility.StoreSelect, rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=HeadCountWkSel.jsp&APPL=ALL");
}
else
{
    String sStrAllowed = session.getAttribute("STORE").toString();
    String sUser = session.getAttribute("USER").toString();
    StoreSelect strlst = null;
    int iStrAlwLst = 0;

    if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
    {
      strlst = new StoreSelect(5);
    }
    else
    {
     Vector vStr = (Vector) session.getAttribute("STRLST");
     String [] sStrAlwLst = new String[ vStr.size()];
     Iterator iter = vStr.iterator();

     while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

     if (vStr.size() > 1) { strlst = new StoreSelect(sStrAlwLst); }
     else strlst = new StoreSelect(new String[]{sStrAllowed});
    }

    String sStrJsa = strlst.getStrNum();
    String sStrNameJsa = strlst.getStrName();

    int iNumOfStr = strlst.getNumOfStr();
    String [] sStr = strlst.getStrLst();

    String [] sStrRegLst = strlst.getStrRegLst();
    String sStrRegJsa = strlst.getStrReg();

    String [] sStrDistLst = strlst.getStrDistLst();
    String sStrDistJsa = strlst.getStrDist();
    String [] sStrDistNmLst = strlst.getStrDistNmLst();
    String sStrDistNmJsa = strlst.getStrDistNm();

    String [] sStrMallLst = strlst.getStrMallLst();
    String sStrMallJsa = strlst.getStrMall();

    ResultSet rslset = null;
    RunSQLStmt runsql = new RunSQLStmt();

    java.util.Date dCurDate = new java.util.Date();
    SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
    String sCurDate = sdf.format(dCurDate);

    String sPrepStmt = "select pyr#, pmo#, pime from rci.fsyper"
     + " where pida='" + sCurDate + "'";
    //System.out.println(sPrepStmt);
    rslset = null;
    runsql = new RunSQLStmt();
    runsql.setPrepStmt(sPrepStmt);
    runsql.runQuery();
    runsql.readNextRecord();
    String sYear = runsql.getData("pyr#");
    String sMonth = runsql.getData("pmo#");
    String sMnend = runsql.getData("pime");

    runsql.disconnect();
    runsql = null;
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
  .Small{ text-align:left; font-family:Arial; font-size:10px;}
</style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<SCRIPT language="JavaScript">
var CurYear = "<%=sYear%>";
var CurMonth = eval("<%=sMonth%>") - 1;

var stores = [<%=sStrJsa%>];
var storeNames = [<%=sStrNameJsa%>];

var ArrStr = [<%=sStrJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];

//==============================================================================
// populate fields on page load
//==============================================================================
function bodyLoad(){
  doWeekSelect();
  setYrMon();
  dspDateSel();
}
//==============================================================================
// Weeks Stores
//==============================================================================
function doWeekSelect() {
    var df = document.all;
    var idx = 0;

    var todate = new Date();
    var sunday = new Date(todate.getFullYear(), todate.getMonth(), todate.getDate()-todate.getDay(), 18);

    sundayUSA = eval(sunday.getMonth()+1) + "/" + sunday.getDate() + "/" + sunday.getFullYear();
    df.FrWeek.value = sundayUSA;
    df.ToWeek.value = sundayUSA;
}

//==============================================================================
// change to date when from date selected. This will be prevent error when from
// date greater than to date
//==============================================================================
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
// set all store or unmark
//==============================================================================
function setAll(on)
{
   var str = document.all.Str;
   for(var i=0; i < str.length; i++) { str[i].checked = on; }
}
//==============================================================================
// check by regions
//==============================================================================
function checkReg(dist)
{
  var str = document.all.Str
  var chk1 = false;
  var chk2 = false;

  // check 1st selected group check status and save it
  var find = false;
  for(var i=0; i < str.length; i++)
  {
     for(var j=0; j < ArrStr.length; j++)
     {
        if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist
          || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
          || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
          || str[i].value == "68" || str[i].value == "86")))
        {
          chk1 = !str[i].checked;
          find = true;
          break;
        };
     }
     if (find){ break;}
  }
  chk2 = !chk1;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist
          || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
          || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
          || str[i].value == "68" || str[i].value == "86")))
        {
           str[i].checked = chk1;
        };
     }
  }
}

//==============================================================================
// check by districts
//==============================================================================
function checkDist(dist)
{
  var str = document.all.Str
  var chk1 = false;
  var chk2 = false;

  // check 1st selected group check status and save it
  var find = false;
  for(var i=0; i < str.length; i++)
  {
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrDist[j] == dist)
        {
          chk1 = !str[i].checked;
          find = true;
          break;
        };
     }
     if (find){ break;}
  }
  chk2 = !chk1;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrDist[j] == dist)
        {
           str[i].checked = chk1;
        };
     }
  }
}

//==============================================================================
// check mall
//==============================================================================
function checkMall(type)
{
  var str = document.all.Str
  var chk1 = true;
  var chk2 = false;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrMall[j] == type)
        {
           str[i].checked = chk1;
        };
     }
  }
}
//==============================================================================
// Validate entry
//==============================================================================
function Validate()
{
   var error = false;
   var msg = "";

   // get selected media
   var str = document.all.Str;
   var selstr = new Array();
   var numstr = 0
   if(ArrStr.length > 2)
   {
   for(var i=0; i < str.length; i++)
   {
     if(str[i].checked){ selstr[numstr] = str[i].value.replaceSpecChar(); numstr++; }
   }
   if (numstr == 0){ error=true; msg+="At least 1 store must be selected.";}
   }
   else{ selstr[0] = str.value.replaceSpecChar(); }

   // date selection
   var rangeType = "";
   for(var i=0; i < document.all.DatTyp.length; i++)
   {
      if ( document.all.DatTyp[i].checked ) { rangeType = document.all.DatTyp[i].value; }
   }

   if(rangeType == "W")
   {
      var selFrWeek = document.all.FrWeek.value.trim();
      var selToWeek = document.all.ToWeek.value.trim();
      var year = "NONE";
      var mon = "NONE";
   }
   if(rangeType == "M")
   {
      var selFrWeek = "NONE";
      var selToWeek = "NONE";
      var year = document.all.Year.options[document.all.Year.selectedIndex].value.trim();
      var mon = document.all.Month.options[document.all.Month.selectedIndex].value.trim();
   }

   var miss = null;
   for(var i=0; i < document.all.MissOpt.length; i++)
   {
      if(document.all.MissOpt[i].checked){ miss=document.all.MissOpt[i].value}
   }

   if(error){alert(msg)}
   else{ submitForm(selstr, selFrWeek, selToWeek, year, mon, miss) }
}
//==============================================================================
// change action on submit
//==============================================================================
function submitForm(selstr, selFrWeek, selToWeek, year, mon, miss){
   var url;

   url = "HeadCountWk.jsp?FrWeek=" + selFrWeek + "&ToWeek=" + selToWeek
     + "&Year=" + year + "&Month=" + mon + "&MissOpt=" + miss
   for(var i=0; i < selstr.length; i++){ url += "&Str=" + selstr[i]; }

   //alert(url);
   window.location.href=url;
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000 * 7);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000 * 7);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// set date ranges
//==============================================================================
function setDtRange()
{
   var grp = document.all.DtGrp;
   for(var i=0; i < grp.length; i++)
   {
      if(grp[i].checked && i < grp.length-1)
      {
         document.all.trDt2.style.display="none"; break;
      }
      else if(grp[i].checked)
      {
         document.all.trDt2.style.display="block"; break;
      }
   }
}
//==============================================================================
// set Year/Month
//==============================================================================
function setYrMon()
{
  var year = CurYear - 1;
  for (var i=0; i < 3; i++)
  {
     document.all.Year.options[i] = new Option(year, year);
     if (year == CurYear ){ document.all.Year.selectedIndex = i; }
     year++;
  }

  var mon = ["April", "May", "June", "July", "August", "September", "October", "November", "December", "January", "February", "March"]

  for (var i=0; i < mon.length; i++)
  {
     document.all.Month.options[i] = new Option(mon[i], (i+1));
     if (i == CurMonth ){ document.all.Month.selectedIndex = i; }
  }
}
//==============================================================================
// change action on submit
//==============================================================================
function dspDateSel()
{
   var rangeType = "";
   for(var i=0; i < document.all.DatTyp.length; i++)
   {
      if ( document.all.DatTyp[i].checked ) { rangeType = document.all.DatTyp[i].value; }
   }

   if(rangeType == "W")
   {
      document.all.trDt1.style.display = "none"
      document.all.trDt2.style.display = "none"
      document.all.trDt3.style.display = "block"
   }
   if(rangeType == "M")
   {
      document.all.trDt1.style.display = "block"
      document.all.trDt2.style.display = "block"
      document.all.trDt3.style.display = "none"
   }
}


</SCRIPT>
</head>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>


 <body  onload="bodyLoad();">

  <table border="0" align=center width="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Weekly Headcount Report - Selection</b><br>
       <a href="/"><font color="red" size="-1">Home</font></a>


      <table border=0>
      <!-- ================================================================= -->
      <!-- Store selection -->
      <!-- ================================================================= -->
      <TR>
            <TD class="Cell2" colspan=5>Store Selection</TD>
        </tr>
        <tr>
            <TD class="Cell1">&nbsp;</td>
            <TD class="Cell1" nowrap colspan=3>
              <%for(int i=0; i < iNumOfStr; i++){%>
                  <input name="Str" type="checkbox" value="<%=sStr[i]%>" <%if(iNumOfStr == 1){%>checked<%}%>><%=sStr[i]%>&nbsp;
                  <%if(i > 0 && i % 14 == 0){%><br><%}%>
              <%}%>
              <%if(iNumOfStr > 1) {%>
              <br><button class="Small" onClick="setAll(true)">All Store</button> &nbsp;

              <button onclick='checkReg(&#34;1&#34;)' class='Small'>Dist 1</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;2&#34;)' class='Small'>Dist 2</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;3&#34;)' class='Small'>Dist 3</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;99&#34;)' class='Small'>Dist 99</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;PATIO&#34;)' class='Small'>Patio</button> &nbsp; &nbsp;
              <br>
              <button onclick='checkDist(&#34;9&#34;)' class='Small'>Houston</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;20&#34;)' class='Small'>Dallas/FtW</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;35&#34;)' class='Small'>Ski Chalet</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;38&#34;)' class='Small'>Boston</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;41&#34;)' class='Small'>OKC</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;52&#34;)' class='Small'>Charl</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;53&#34;)' class='Small'>Nash</button> &nbsp; &nbsp;
              <br>
              <button onclick='checkMall(&#34;&#34;)' class='Small'>Mall</button> &nbsp; &nbsp;
              <button onclick='checkMall(&#34;NOT&#34;)' class='Small'>Non-Mall</button> &nbsp; &nbsp;

              <button class="Small" onClick="setAll(false)">Reset</button><br><br>
              <%}%>
        </TR>
      <!-- =============================================================================== -->
      <tr>
         <td colspan=4 style="border-bottom: darkred solid 1px; font-size: 3px">&nbsp;</td>
      </tr>

      <TR>
          <TD align=left colspan=4>Date Selection<br>
             <input type="radio" name="DatTyp" onclick="dspDateSel()" value="W" checked>Weekly &nbsp; &nbsp; &nbsp; &nbsp;
             <input type="radio" name="DatTyp" onclick="dspDateSel()" value="M">Monthly &nbsp; &nbsp; &nbsp; &nbsp;
             <br><br>
          </TD>
      </TR>

      <tr id="trDt1">
        <td align="left">Fiscal Year:&nbsp</td>
        <td align="left"  class="Small" colspan=2 style="display:none">
          <TD align=left><SELECT name="Year"></SELECT></TD>
      </TR>
      <TR id="trDt2">
          <TD align=right>Fiscal Month:</td>
          <TD align=left><SELECT name="Month"></SELECT></TD>
      </TR>

      <tr id="trDt3">
        <td align="right">From Week:&nbsp</td>
        <td>
           <button class="Small" name="Down" onClick="setDate('DOWN', 'FrWeek')">&#60;</button>
           <input name="FrWeek" class="Small" size="10" readOnly/>
           <button class="Small" name="Down" onClick="setDate('UP', 'FrWeek')">&#62;</button>
           <a href="javascript:showCalendar(1, null, null, 350, 350, document.all.FrWeek)">
           <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a></td>
        <td align="right">To Week:&nbsp</td>
        <td>
           <button class="Small" name="Down" onClick="setDate('DOWN', 'ToWeek')">&#60;</button>
           <input name="ToWeek" class="Small" size="10" readOnly/>
           <button class="Small" name="Down" onClick="setDate('UP', 'ToWeek')">&#62;</button>
           <a href="javascript:showCalendar(1, null, null, 650, 350, document.all.ToWeek)">
           <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a></td>
      </tr>
      <!-- =============================================================================== -->
      <tr>
         <td colspan=4 style="border-bottom: darkred solid 1px; font-size: 3px">&nbsp;</td>
      </tr>

      <TR>
          <TD align=left colspan=4>Report Options<br>
             <input type="radio" name="MissOpt" value="Y">Exclude Inclomplete Date &nbsp; &nbsp; &nbsp; &nbsp;
             <input type="radio" name="MissOpt" value="N" checked>Show All Data
             <br><br>
          </TD>
      </TR>
      <!-- =============================================================================== -->
      <tr>
         <td align="center" colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <button onClick="Validate()">Submit</button>
      </tr>


      </table>
         <br><br><br><br><br><br>&nbsp;
      </td>
     </tr>
   </table>
  </body>
</html>
<%}%>