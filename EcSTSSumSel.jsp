<%@ page import="java.util.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null )
   {
     response.sendRedirect("SignOn1.jsp?TARGET=EcSTSSumSel.jsp&APPL=ALL");
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
      document.all.tdDate1.style.display="block"
      document.all.tdDate2.style.display="none"
      document.all.tdDate3.style.display="none"
      var date = new Date(new Date() - 86400000);
      date.setHours(18);

      // to sales date
      document.all.StsToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

      // from sales date
      var day = 0;
      for(var i=0; i < 7; i++)
      {
         day = date.getDay();
         if (date.getDay()==0){ break; }
         date = new Date(date.getTime() - 86400000);
      }
      document.all.StsFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

//==============================================================================
// show date selection
//==============================================================================
function showDates(type)
{
   if(type==1)
   {
     document.all.tdDate1.style.display="none"
     document.all.tdDate2.style.display="block"
     document.all.tdDate3.style.display="block"
   }
   else
   {
     document.all.tdDate1.style.display="none"
     document.all.tdDate2.style.display="block"
     document.all.tdDate3.style.display="block"
   }
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
  var stsfrdate = document.all.StsFrDate.value;
  var ststodate = document.all.StsToDate.value;

  if (error) alert(msg);
  else{ sbmSlsRep(stsfrdate, ststodate) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmSlsRep( stsfrdate, ststodate )
{
  var url = null;
  url = "EcSTSSum.jsp?"
     + "FrDate=" + stsfrdate
     + "&ToDate=" + ststodate;

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
        <BR>Ship-To-Store Summary - Selection</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>

      <TABLE>
        <TBODY>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=4><b><u>Select Ship-To-Store Activity Dates</b></u> <br>If no date selected, defaulted dates are week-to-date</TD></tr>

        <TR>
          <TD id="tdDate1" colspan=4 align=center style="padding-top: 10px;" >
             <button id="btnSelDates" onclick="showDates(2)">Optional Date Selection</button>
          </td>
          <TD id="tdDate2" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date: </b>
             <button class="Small" name="Down" onClick="setDate('DOWN', 'StsFrDate', 'YEAR')">y-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'StsFrDate', 'MON')">m-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'StsFrDate', 'DAY')">d-</button>
              <input class="Small" name="StsFrDate" type="text"  size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'StsFrDate', 'DAY')">d+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'StsFrDate', 'MON')">m+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'StsFrDate', 'YEAR')">y+</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.StsFrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date: </b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'StsToDate', 'YEAR')">y-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'StsToDate', 'MON')">m-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'StsToDate', 'DAY')">d-</button>
              <input class="Small" name="StsToDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'StsToDate', 'DAY')">d+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'StsToDate', 'MON')">m+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'StsToDate', 'YEAR')">y+</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.StsToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </td>
        </tr>
        <TR><TD class="Cell2" id="tdDate3" colspan=4>
              <p><button id="btnSelDates" onclick="showAllDates()">Week-To-Date</button>
          </TD>
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