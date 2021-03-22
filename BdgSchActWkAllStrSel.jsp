<%@ page import="java.util.*"%>
<%
   String sStrAllowed = null;
   String sUser = null;

   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sAppl = "PAYROLL";
   sStrAllowed = session.getAttribute("STORE").toString();

   Vector vStr = (Vector) session.getAttribute("STRLST");
   String [] sStrAlwLst = new String[ vStr.size()];
   Iterator iter = vStr.iterator();

   int iStrAlwLst = 0;
   while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl)
   || sStrAllowed == null || !sStrAllowed.startsWith("ALL") && sStrAlwLst.length < 2)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=BdgSchActWkAllStrSel.jsp&APPL=" + sAppl);
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

   var wkend = document.all.Wkend.value

   if (error) {alert(msg); }
   else { submit(wkend) }
}
//==============================================================================
// change action on submit
//==============================================================================
function submit(wkend){
   SbmString = "BdgSchActWkAllStr.jsp?"
        + "Wkend=" + wkend;

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
     <tr>
      <td height="20%" COLSPAN="2">
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Weekly Budget vs. Schedule and Actual Payroll - Selection
       </b><br><br>

       <a href="index.jsp">Home</a>

      <table>

      <!-- =============================================================== -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>
      <TR>
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
