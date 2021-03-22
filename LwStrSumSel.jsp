<%@ page import="java.util.*"%>
<%
%>

<style>
  .Small {font-family:Arial; font-size:10px }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top}

  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
        width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
</style>


<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var DateRange = true;

//==============================================================================
// on load
//==============================================================================
function bodyLoad(){
  // populate date with yesterdate
  doSelDate();
  switchDates()
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  doSelDate(){
  var date = new Date(new Date() - 86400000);
  var dofw = date.getDay();
  date = new Date(date - 86400000 * dofw);

  document.all.FromDt.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  document.all.ToDt.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";
  var frdate =  document.all.FromDt.value;
  var todate =  document.all.ToDt.value;

  // validate date range
  if(DateRange)
  {
      var from = new Date(frdate)
      var to = new Date(todate)
      if(from > to){ error = true; msg += "\nFrom date greater than to date."}
  }
  else
  {
    frdate = "NONE";
  }

  if (error) alert(msg);
  else { sbmReport( frdate, todate) }

  return error == false;
}
//==============================================================================
// submit report
//==============================================================================
function sbmReport(frdate, todate)
{
   url = "LwStrSum.jsp?"
       + "&FrDate=" + frdate
       + "&ToDate=" + todate
   //alert(url)
   window.location.href = url;
}
//==============================================================================
// switch frome date range to 1 date (WTD/MTD/YTD)
//==============================================================================
function switchDates()
{
  if(DateRange)
  {
    document.all.spnFrom.style.display = "none";
    document.all.btnDate.innerHTML = "Date Range";
  }
  else
  {
     document.all.spnFrom.style.display = "inline";
     document.all.btnDate.innerHTML = "One Date";
  }
  DateRange = !DateRange;
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
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<!-------------------------------------------------------------------->
<HTML><HEAD>
<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<!-------------------------------------------------------------------->
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Layaway Store Summary - Selection</B>

      <TABLE>
        <TBODY>
        <!-- =============================================================== -->
        <tr style="background:red; font-size:1px"><td colspan=4>&nbsp;</td></tr>
        <TR>
          <TD align=center colspan=4>
              <span id="spnFrom">From Weekending Date:
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FromDt')">&#60;</button>
              <input name="FromDt" type="text" size=10 maxlength=10>
              <button class="Small" name="Up" onClick="setDate('UP', 'FromDt')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 500, 300, document.all.FromDt)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a> &nbsp; &nbsp; &nbsp;
              </span>

           To Weekending Date:
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDt')">&#60;</button>
              <input name="ToDt" type="text" size=10 maxlength=10>
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDt')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 800, 300, document.all.ToDt)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
            <br><button class="Small" id="btnDate" onClick="switchDates()">One Date</button>
          </TD>
        </TR>

        <TR>
            <TD align=center colSpan=4>
               <button onClick="Validate()">Submit</button>
           </TD>
          </TR>
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
