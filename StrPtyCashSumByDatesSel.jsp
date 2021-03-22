<%@ page import=" java.util.*"%>
<%
   String sStrAllowed = null;
   String sUser = null;

   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sAppl = "PTYCSH";
   
   /*System.out.println("User=" + session.getAttribute("USER")
   	+ "|Appl=" + session.getAttribute(sAppl)
   	+ "|Attrib=" + session.getAttribute("APPLICATION")	
   );
   */
   
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=StrPtyCashSumSel.jsp&APPL=" + sAppl);
   }
   else
   {
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
var User = "<%=sUser%>";
//==============================================================================
// initial processes
//==============================================================================
function bodyLoad()
{
  doSelDate();
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  doSelDate(){
  var todate = new Date(new Date() - 86400000);
  var frdate = new Date(todate - 86400000 * 30);

  document.all.FrWeek.value = (frdate.getMonth()+1) + "/" + frdate.getDate() + "/" + frdate.getFullYear()
  document.all.ToWeek.value = (todate.getMonth()+1) + "/" + todate.getDate() + "/" + todate.getFullYear()
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);
  date.setHours(18);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000 );
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// change action on submit
//==============================================================================
function validate()
{
   var error =false;
   var msg = "";

   var frdate = document.all.FrWeek.value
   var todate = document.all.ToWeek.value

   if (error) {alert(msg); }
   else { submit(frdate, todate) }
}
//==============================================================================
// change action on submit
//==============================================================================
function submit(frdate, todate){
   SbmString = "StrPtyCashSumByDates.jsp"
    + "?FrDate=" + frdate
    + "&ToDate=" + todate
   ;

    //alert(SbmString);
    window.location.href=SbmString;
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
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>All Store Petty Cash Summary By Date Range - Selection
       </b><br><br>

       <a href="index.jsp">Home</a>

      <table>
      <!-- =============================================================== -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>
      <TR>
          <TD align=center colspan=2><br>
           <span id="spnFrom">From Date:
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrWeek')">&#60;</button>
              <input name="FrWeek" type="text" size=10 maxlength=10>
              <button class="Small" name="Up" onClick="setDate('UP', 'FrWeek')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 500, 300, document.all.FrWeek)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a> &nbsp; &nbsp; &nbsp;
              </span>

           To Date:
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToWeek')">&#60;</button>
              <input name="ToWeek" type="text" size=10 maxlength=10>
              <button class="Small" name="Up" onClick="setDate('UP', 'ToWeek')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 800, 300, document.all.ToWeek)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
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
