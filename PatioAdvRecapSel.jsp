<%@ page import="java.util.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PatioBsrRepSel.jsp&APPL=ALL");
   }
   else
   {
%>

<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:bottom}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:middle}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:middle; font-weight:bold;text-decoration:underline}

  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  doSelDate();
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate()
{
  var df = document.all;
  var date = new Date();

  // last ran
  var frdat = document.all.FrDateSv.value;
  var todat = document.all.ToDateSv.value;

  if (todat != null && todat.trim() != ''){ df.ToDate.value = todat }
  else { df.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear() }

  var date = new Date(new Date() - 6 * 86400000);
  date.setHours(18);

  if (frdat != null && frdat.trim() != ''){ df.FrDate.value = frdat }
  else { df.FrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear() }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);


  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// Validate form
//==============================================================================
function Validate(excel)
{
  var error = false;
  var msg = "";

  var frdate = document.all.FrDate.value.trim();
  var todate = document.all.ToDate.value.trim();

  if (error) alert(msg);
  else{ sbmCustRecap(frdate, todate) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmCustRecap(frdate, todate)
{
  // save date for next run
  document.all.FrDateSv.value = frdate;
  document.all.FrDateSv.value = todate;

  var url = "PatioAdvRecap.jsp?FrDate=" + frdate
          + "&ToDate=" + todate

  //alert(url)
  window.location.href=url;
}
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<HTML><HEAD><meta http-equiv="refresh">
<title>Patio - Cust Heard</title>
</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Patio - How Customer Heard About Us - Selection</B>
        <br><a href="/"><span style="color:red;">Home</span></A>

      <TABLE>
        <TBODY>
        <!-- ========================Sales Date ============================= -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell" >From Date:</TD>
            <TD class="Cell1" nowrap>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrDate')">&#60;</button>
              <input class="Small" name="FrDate" type="text" size=10 maxlength=10 readOnly>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrDate')">&#62;</button>&nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 250, 100, document.all.FrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              <input type="hidden" name="FrDateSv">&nbsp;
            </TD>

            <TD class="Cell" >To Date:</TD>
            <TD class="Cell1" nowrap>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate')">&#60;</button>
              <input class="Small" name="ToDate" type="text" size=10 maxlength=10 readOnly>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate')">&#62;</button>&nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 850, 100, document.all.ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              <input type="hidden" name="ToDateSv">&nbsp;
            </TD>

          </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate(false)">
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