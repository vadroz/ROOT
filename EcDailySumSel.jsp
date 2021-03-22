<%@ page import="java.util.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null )
   {
     response.sendRedirect("SignOn1.jsp?TARGET=EcDailySumSel.jsp&APPL=ALL");
   }
   else
   {
%>

<style>
  .Small {font-family: times; font-size:10px }
  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top}
  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
        width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  .Small { text-align:center; font-size:10px }
  </style>

<script LANGUAGE="JavaScript" src="Calendar.js"></script>


<script name="javascript">
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  showAllDates()
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates()
{
      var date = new Date(new Date() - 86400000);
      date.setHours(18);

      // shipping Date
      document.all.ShipDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = " ";

  // sales date
  // sales date
  var shipdate = document.all.ShipDate.value;

  if (error) alert(msg);
  else{ sbmSlsRep(shipdate) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmSlsRep( shipdate )
{
  var url = null;
  url = "EcDailySum.jsp?"
     + "ShipDate=" + shipdate

  //alert(url)
  window.location.href=url;
}


//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id, ymd)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN" && ymd=="DAY") { date = new Date(new Date(date) - 86400000); }
  else if(direction == "UP" && ymd=="DAY") { date = new Date(new Date(date) - -86400000); }

  if(direction == "DOWN" && ymd=="MON") { date.setMonth(date.getMonth()-1); }
  else if(direction == "UP" && ymd=="MON") { date.setMonth(date.getMonth()+1); }

  if(direction == "DOWN" && ymd=="YEAR") { date.setYear(date.getFullYear()-1); }
  else if(direction == "UP" && ymd=="YEAR") { date.setYear(date.getFullYear()+1); }

  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<HTML><HEAD><meta http-equiv="refresh">

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <!--TR><TD height="20%"><IMG src="Sun_ski_logo4.png"></TD></TR -->

  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Daily Shipping Summary - Selection</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>

      <TABLE>
        <TBODY>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=4><b><u>Select Ship Dates</b></u></TD></tr>

        <TR>
          <TD id="tdDate2" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date: </b>
             <button class="Small" name="Down" onClick="setDate('DOWN', 'ShipDate', 'YEAR')">y-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ShipDate', 'MON')">m-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ShipDate', 'DAY')">d-</button>
              <input class="Small" name="ShipDate" type="text"  size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ShipDate', 'DAY')">d+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'ShipDate', 'MON')">m+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'ShipDate', 'YEAR')">y+</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.ShipDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

          </td>
        </tr>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD></TD>
            <TD class="Cell2" colSpan=4>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate()">
           </TD>
          </TR>
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>

</BODY></HTML>
<%}%>