<%@ page import="rciutility.StoreSelect, rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
   String sStrAllowed = null;

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   String sUser = null;

   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     response.sendRedirect("SignOn1.jsp?TARGET=BdgSchActWkSel.jsp&APPL=" + sAppl);
   }
   else {

     sStrAllowed = session.getAttribute("STORE").toString();
     sUser = session.getAttribute("USER").toString();

    if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
    {
      StrSelect = new StoreSelect(10);
    }
    else
    {
     Vector vStr = (Vector) session.getAttribute("STRLST");
     String [] sStrAlwLst = new String[ vStr.size()];
     Iterator iter = vStr.iterator();

     int iStrAlwLst = 0;
     while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

     if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
     else StrSelect = new StoreSelect(new String[]{sStrAllowed});
    }

    sStr = StrSelect.getStrNum();
    sStrName = StrSelect.getStrName();

   }

   java.util.Date dCurDate = new java.util.Date();
   SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
   String sCurDate = sdf.format(dCurDate);

   String sPrepStmt = "select pyr#, pmo#, pime from rci.fsyper"
     + " where pida='" + sCurDate + "'";
   //System.out.println(sPrepStmt);
   ResultSet rslset = null;
   RunSQLStmt runsql = new RunSQLStmt();
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
  .small{ text-align:left; font-family:Arial; font-size:10px;}
</style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<SCRIPT language="JavaScript">
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];
var StrAllowed = "<%=sStrAllowed%>";
var User = "<%=sUser%>";

var CurYear = "<%=sYear%>";
var CurMonth = eval("<%=sMonth%>") - 1;
//==============================================================================
// initial processes
//==============================================================================
function bodyLoad()
{
  doStrSelect();
  doSelDate();
  doMonthSelect();
  dspDateSel();
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id)
{
    var df = document.all;
    for (idx = 0; idx < stores.length; idx++)
    {
      df.Store.options[idx] = new Option(stores[idx] + " - " + storeNames[idx],stores[idx]);
    }
    document.all.Store.selectedIndex=1;
}

//==============================================================================
// Weeks Stores
//==============================================================================
function doMonthSelect(id)
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
// populate date with yesterdate
//==============================================================================
function  doSelDate()
{
  var date = new Date(new Date() - 86400000);
  var dofw = date.getDay();
  date = new Date(date - 86400000 * (dofw - 7));
  document.all.Wkend.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);
  date.setHours(18);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000 * 7);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000 * 7);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// change action on submit
//==============================================================================
function validate()
{
   var error =false;
   var msg = "";

   var url = null;
   var str = document.all.Store.options[document.all.Store.selectedIndex].value;
   var strId = document.all.Store.selectedIndex;
   var wkend = document.all.Wkend.value
   var year = document.all.Year[document.all.Year.selectedIndex].value
   var monnum = document.all.Month[document.all.Month.selectedIndex].value
   var monname = document.all.Month[document.all.Month.selectedIndex].text

   var periodType = "";
   for(var i=0; i < document.all.DatTyp.length; i++)
   {
      if ( document.all.DatTyp[i].checked ) { periodType = document.all.DatTyp[i].value; }
   }

   // weekly report
   if(periodType == "W") { "PrMonBudgAllStr.jsp?&WEEKEND=" + wkend+ "&Year=" + year + "&Month=" + monnum + "&MonName=" + monname; }
   // monthly report
   else if(periodType == "M")
   {
      "PrMonStrBdgSch.jsp?STORE=" + str + "&StrName=" + storeNames[strId]
            + "&STRNAME=" + storeNames[document.getStore.STORE.selectedIndex]
            + "&Year=" + year + "&Month=" + monnum + "&MonName=" + monname;
   }

   if (error) {alert(msg); }
   else { submit(url) }
}
//==============================================================================
// change action on submit
//==============================================================================
function submit(url)
{
    //alert(url);
    window.location.href=url;
}
//==============================================================================
// change action on submit
//==============================================================================
function dspDateSel()
{
   var periodType = "";
   for(var i=0; i < document.all.DatTyp.length; i++)
   {
      if ( document.all.DatTyp[i].checked ) { periodType = document.all.DatTyp[i].value; }
   }

   if(periodType == "W")
   {
      document.all.trWkSel.style.display = "block"
      document.all.trYrSel.style.display = "none"
      document.all.trMonSel.style.display = "none"
   }
   if(periodType == "M")
   {
      document.all.trWkSel.style.display = "none"
      document.all.trYrSel.style.display = "block"
      document.all.trMonSel.style.display = "block"
   }
}

</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

</head>
<body  onload="bodyLoad();">

 <!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="menu" class="Menu"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2">
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Allowable Budget vs. Schedule and Actual Payroll - Selection
       </b><br><br>

       <a href="index.jsp">Home</a>

      <table>
      <!-- =============================================================== -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>
      <tr>
         <td><br>Select Store:<br><br></td><td><br><SELECT name="Store"></SELECT><br><br></td>
      </tr>
      <!-- =============================================================== -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>
      <TR>
          <TD align=center colspan=2><br>
             <input type="radio" name="DatTyp" onclick="dspDateSel()" value="W" checked>Weekly &nbsp; &nbsp; &nbsp; &nbsp;
             <input type="radio" name="DatTyp" onclick="dspDateSel()" value="M">Monthly &nbsp; &nbsp; &nbsp; &nbsp;
             <br><br>
          </TD>
      </TR>
      <!-- ============================== Weekly ================================= -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>
      <TR id="trWkSel">
          <TD align=center colspan=2><br>
           Week Ending Date: &nbsp;
              <button class="Small" name="Down" onClick="setDate('DOWN', 'Wkend')">&#60;</button>
              <input name="Wkend" type="text" size=10 maxlength=10 readonly>
              <button class="Small" name="Up" onClick="setDate('UP', 'Wkend')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 800, 300, document.all.Wkend)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              <br><br>
          </TD>
      </TR>
      <!-- ===================== Monthly and Quarterly ===================== -->
      <TR id="trYrSel">
          <TD align=right>Fiscal Year:</td>
          <TD align=left><SELECT name="Year"></SELECT></TD>
      </TR>
      <TR id="trMonSel">
          <TD align=right>Fiscal Month:</td>
          <TD align=left><SELECT name="Month"></SELECT></TD>
      </TR>

      <!-- =============================================================== -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>
      <tr>
         <td align="center" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <button name="submit" onClick="validate()">Submit</button>
      </tr>
      </table>
                </td>
            </tr>
       </table>

        </body>
      </html>
