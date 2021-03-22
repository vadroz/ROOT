<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
   String sStrAllowed = null;
   String sUser = null;

   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sAppl = "PAYROLL";
   String sAccess = session.getAttribute("ACCESS").toString();
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
    || session.getAttribute(sAppl)!=null && !session.getAttribute(sAppl).equals(sAppl))
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PrActAvgWageSel.jsp&APPL=" + sAppl);
   }
   else
   {
      System.out.println(1);
      if (sAccess != null && !sAccess.equals("1")) { response.sendRedirect("index.jsp"); }
   }
   System.out.println(2);
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
var User = "<%=sUser%>";
//==============================================================================
// initial processes
//==============================================================================
function bodyLoad()
{
  doSelDate();
  dspRepType()
}

//==============================================================================
// populate date with yesterdate
//==============================================================================
function  doSelDate()
{
  var date = new Date(new Date() - 86400000);
  var dofw = date.getDay();
  date = new Date(date - 86400000 * dofw);
  document.all.From.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

  date = new Date(date - 86400000 * (-7));
  document.all.To.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

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
   var repTy = "0";
   if (document.all.RepType[1].checked){repTy = "1"}

   var show = "";
   for(var i=0; i < document.all.DataType.length; i++)
   {
      if (document.all.DataType[i].checked){ show = document.all.DataType[i].value; break }
   }

   var from = document.all.From.value;
   var to = document.all.To.value;

   if( repTy == "0" ) { url = "PrActAvgWage.jsp?From=BEGWEEK&To=" + to + "&Show=" + show; }
   else { url = "PrActAvgWage.jsp?From=" + from + "&To=" + to + "&Show=" + show; }

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
function dspRepType()
{
   var rangeType = "";
   for(var i=0; i < document.all.RepType.length; i++)
   {
      if ( document.all.RepType[i].checked ) { rangeType = document.all.RepType[i].value; }
   }

   if(rangeType == "1")
   {
      document.all.trFrom.style.display = "none"
      document.all.spTo.innerHTML = "Weekending";
    }
   if(rangeType == "2")
   {
      document.all.trFrom.style.display = "block";
      document.all.spTo.innerHTML = "To";
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
      <TR>
          <TD align=center colspan=2><br>
             <input type="radio" name="RepType" onclick="dspRepType()" value="1" checked>Weekending &nbsp;
             <input type="radio" name="RepType" onclick="dspRepType()" value="2">From/To Weekending Selection &nbsp; &nbsp; &nbsp; &nbsp;
             <br><br>
          </TD>
      </TR>
      <!-- ============================== Weekly ================================= -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>
      <tr><td style="text-align:center; font-weight:bold">Week Ending Date(s):</td></tr>
      <TR id="trFrom">
          <TD align=center colspan=2><br>
           From: &nbsp;
              <button class="Small" name="Down" onClick="setDate('DOWN', 'From')">&#60;</button>
              <input name="From" type="text" size=10 maxlength=10 readonly>
              <button class="Small" name="Up" onClick="setDate('UP', 'From')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 800, 300, document.all.From)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </TD>
      </TR>
      <TR id="trTo">
          <TD align=center colspan=2><br>
           <span id="spTo">Weekending</span>: &nbsp;
              <button class="Small" name="Down" onClick="setDate('DOWN', 'To')">&#60;</button>
              <input name="To" type="text" size=10 maxlength=10 readonly>
              <button class="Small" name="Up" onClick="setDate('UP', 'To')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 800, 300, document.all.To)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </TD>
      </TR>

      <!-- =============================================================== -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>
      <TR>
          <TD align=center colspan=2><br>
             <input type="radio" name="DataType" value="Hrs" checked>Hours &nbsp;
             <input type="radio" name="DataType" value="Dlr">Dollars &nbsp;
             <input type="radio" name="DataType" value="Avg">Average Wage &nbsp;
             <input type="radio" name="DataType" value="Prc" >Percents &nbsp;
             <br><br>
          </TD>
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
