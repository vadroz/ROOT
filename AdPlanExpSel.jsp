<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
   ResultSet rslset = null;
   RunSQLStmt runsql = new RunSQLStmt();

   // get all amrkets
   String sPrepStmt = "select Market from rci.AdSpend group by Market order by Market";
   runsql.setPrepStmt(sPrepStmt);
   runsql.runQuery();
   Vector vMarket = new Vector();

   while(runsql.readNextRecord())
   {
      vMarket.add(runsql.getData("Market"));
   }

   Iterator it = vMarket.iterator();
   String [] sMarket = new String[vMarket.size()];
   vMarket.toArray((String []) sMarket);
   int iNumOfMrk = sMarket.length;

   // get all medias
   String [] sMedia = new String[]{"Print", "Radio", "Outdoor", "TV", "Direct Mail"
       , "Non-Traditional - Sponsorship", "Non-Traditional - Online"};
   int iNumOfMed = sMedia.length;


   java.util.Date dCurDate = new java.util.Date();
   SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
   String sCurDate = sdf.format(dCurDate);

   sPrepStmt = "select pyr#, pmo#, pime from rci.fsyper"
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

   String sStrAllowed = session.getAttribute("STORE").toString();
   boolean bAllStr = false;
   if (sStrAllowed != null && sStrAllowed.startsWith("ALL")) { bAllStr = true; }
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
//==============================================================================
// populate fields on page load
//==============================================================================
function bodyLoad(){
  doWeekSelect();
  setYrMon();
  dspDateSel()
  checkAllMarkets(true);
  checkAllMedias(true);
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
// check all markets
//==============================================================================
function checkAllMarkets(chk)
{
  var mrk = document.all.Mrk

  for(var i=0; i < <%=iNumOfMrk%>; i++)
  {
     mrk[i].checked = chk;
  }
}
//==============================================================================
// check all medias
//==============================================================================
function checkAllMedias(chk)
{
  var med = document.all.Med

  for(var i=0; i < <%=iNumOfMed%>; i++)
  {
     med[i].checked = chk;
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
   var mrk = document.all.Mrk;
   var selmrk = new Array();
   var nummrk = 0
   for(var i=0; i < mrk.length; i++)
   {
     if(mrk[i].checked){ selmrk[nummrk] = mrk[i].value.replaceSpecChar(); nummrk++; }
   }
   if (nummrk == 0){ error=true; msg+="At least 1 market must be selected.";}

   // get selected media
   var med = document.all.Med;
   var selmed = new Array();
   var nummed = 0
   for(var i=0; i < med.length; i++)
   {
     if(med[i].checked){ selmed[nummed] = med[i].value.replaceSpecChar(); nummed++; }
   }
   if (nummed == 0){ error=true; msg+="At least 1 media must be selected.";}

   var type = document.all.Type;
   var seltyp = new Array();
   var numtyp = 0
   for(var i=0; i < type.length; i++)
   {
     if(type[i].checked){ seltyp[numtyp] = type[i].value.replaceSpecChar(); numtyp++; }
   }
   if (numtyp == 0){ error=true; msg+="At least 1 type must be selected.";}

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
   else{ submitForm(selmrk, selmed, selFrWeek, selToWeek, seltyp, year, mon, miss) }
}
//==============================================================================
// change action on submit
//==============================================================================
function submitForm(selmrk, selmed, selFrWeek, selToWeek, seltyp, year, mon, miss)
{
   var url;

   url = "AdPlanExp.jsp?FrWeek=" + selFrWeek + "&ToWeek=" + selToWeek
     + "&Year=" + year + "&Month=" + mon + "&MissOpt=" + miss
   for(var i=0; i < selmrk.length; i++){ url += "&Mrk=" + selmrk[i]; }
   for(var i=0; i < selmed.length; i++) { url += "&Med=" + selmed[i]; }
   for(var i=0; i < seltyp.length; i++) { url += "&Type=" + seltyp[i]; }

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
  var year = CurYear - 2;
  for (var i=0; i < 4; i++)
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
       <br>Weekly Ad Spend - Selection</b><br>
       <a href="/"><font color="red" size="-1">Home</font></a>


      <table border=0>
      <!-- =============================================================================== -->
      <!-- Store list -->
      <!-- =============================================================================== -->
      <tr>
         <td valign=top>Markets:</td>
         <td colspan=3>
            <table border=0>
              <tr>
                <%for(int i=0, j=0; i < iNumOfMrk; i++){%>
                    <%if(j > 0 && j % 8 == 0){%><tr><%}%>
                    <td class="Small">
                      <input type="checkbox" class="Small" name="Mrk" value="<%=sMarket[i].trim()%>"><%=sMarket[i]%>
                      <%j++;%>
                    </td>

                <%}%>
               </tr>
            </table>
            <br><button onclick="checkAllMarkets(true)" class="Small">Check All</button> &nbsp; &nbsp;
            <button onclick="checkAllMarkets(false)" class="Small">Reset</button>
         </td>

      <!-- =============================================================================== -->
      <!-- filter active/inactive  -->
      <!-- =============================================================================== -->
      <tr>
         <td colspan=4 style="border-bottom: darkred solid 1px; font-size: 3px">&nbsp;</td>
      </tr>
      <tr>
         <td valign=top>Medias:</td>
         <td colspan=3>
            <table border=0>
              <tr>
                <%for(int i=0, j=0; i < iNumOfMed; i++){%>
                    <%if(j > 0 && j % 4 == 0){%><tr><%}%>
                    <td class="Small">
                      <input type="checkbox" class="Small" name="Med" value="<%=sMedia[i].trim()%>"><%=sMedia[i]%>
                      <%j++;%>
                    </td>

                <%}%>
               </tr>
            </table>
            <br><button onclick="checkAllMedias(true)" class="Small">Check All</button> &nbsp; &nbsp;
            <button onclick="checkAllMedias(false)" class="Small">Reset</button>
         </td>
     </tr>
     <tr>
         <td valign=top>Show:</td>
         <td colspan=3>
           <input type="checkbox" class="Small" name="Type" value="Gross Spend" checked>Gross Spend &nbsp; &nbsp;
           <span  <%if(!bAllStr){%>style="display:none;"<%}%>>
              <input type="checkbox" class="Small" name="Type" value="Net of coop">Net Of Coop &nbsp; &nbsp;
              <input type="checkbox" class="Small" name="Type" value="Coop portion">Coop Portion &nbsp; &nbsp;
           </span>
         </td>
    </tr>

      <!-- =============================================================================== -->
      <tr>
         <td colspan=4 style="border-bottom: darkred solid 1px; font-size: 3px">&nbsp;</td>
      </tr>

      <TR>
          <TD align=left colspan=2>Date Selection<br>
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
           <a href="javascript:showCalendar(1, null, null, 650, 350, document.all.FrWeek)">
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
