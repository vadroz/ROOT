<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=CoorGoalCompSel.jsp&APPL=ALL&" + request.getQueryString());
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

<SCRIPT language="JavaScript1.2">
//==============================================================================
// load initial values
//==============================================================================
function bodyLoad()
{
   setWeekSelection();
   setCoordinatorSelection();
}

//==============================================================================
// populate week selection field
//==============================================================================
function setWeekSelection()
{
   var curdate = new Date();
   curdate.setMonth(curdate.getMonth() + 3)

   var mon = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October","November", "December"]
   for(var i=0; i < 12 ; i++)
   {
     document.forms[0].MonthYear[i] = new Option(mon[curdate.getMonth()] + " " + curdate.getFullYear(),
                                              curdate.getFullYear() + "-" + (curdate.getMonth()+1) + "-1");
     curdate.setMonth(curdate.getMonth() - 1)
   }
}
//==============================================================================
// populate week selection field
//==============================================================================
function setCoordinatorSelection()
{
   var coor = ["Cycle","Water", "Snow", "Skate", "Outdoor", "Footwear"]
   for(var i=0; i < coor.length ; i++)
   {
     document.forms[0].Coordinator[i] = new Option(coor[i], coor[i].toUpperCase());
   }
}

//==============================================================================
// change action on submit
//==============================================================================
function submitForm(){
   var SbmString;
   var selWeek = document.getCoord.MonthYear.options[document.getCoord.MonthYear.selectedIndex];
   var selCoor = document.getCoord.Coordinator.options[document.getCoord.Coordinator.selectedIndex].value;
   SbmString = "CoorGoalComp.jsp"
        + "?MonthYear=" + selWeek.value
        + "&MonthName=" + selWeek.text
        + "&Coordinator=" + selCoor

    //alert(SbmString);
    window.location.href=SbmString;
}

</SCRIPT>
          </head>
 <body  onload="bodyLoad();">

 <!-------------------------------------------------------------------->
<iframe id="frame1" src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="menu" class="Menu"></div>
<!--div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2">
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Coordinator Incentive Plans<br></b>

      <form name="getCoord" action="javascript:submitForm()">
      <table>
      <tr>
        <td>Select Month/Year:</td>
        <td><SELECT name="MonthYear"></SELECT></td>
      </tr>
      <tr>
        <td>Select Coordinator:</td>
        <td><SELECT name="Coordinator"></SELECT></td>
      </tr>
      <tr>
         <td align="center" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="submit" value="Submit"></td>
      </tr>
      </table>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <a href="../"><font color="red" size="-1">Home</font></a>
      </form>
                </td>
            </tr>
       </table>
        </body>
      </html>
