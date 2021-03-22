<%@ page import="java.util.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=TimeCardRecapSel.jsp&APPL=ALL");
}
else
{
%>

<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}
  td.Cell3 {font-size:12px; text-align:center; vertical-align:top}
  td.Cell4 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;}

  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   showDates();
}
//==============================================================================
// show date selection
//==============================================================================
function showDates(type)
{
     document.all.tdDate.style.display="block"
     doSelDate()
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate()
{
    var df = document.all;
    var date = new Date(new Date() - 86400000);
    var dofw = date.getDay();
    date = new Date(date - 86400000 * (dofw - 7));
    date.setHours(18);
    df.Wkend.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);
  date.setHours(18);

  if(direction == "DOWN") date = new Date(new Date(date) - 7 * 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - 7 * -86400000);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}


//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";

  // order date
  var wkend = document.all.Wkend.value;

  if (error) alert(msg);
  else{ sbmOrdList(wkend) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmOrdList(wkend)
{
  var url = null;
  url = "TimecardRecap.jsp?Wkend=" + wkend

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// check All Types
//==============================================================================
function chkTypeAll(chko)
{
   var type = document.all.Type;
   var mark = false;
   var alltype = chko.name == "TypeAll";

   if (chko.checked) mark = true;
   if (alltype)
   {
      for(var i=0; i < type.length; i++) { type[i].checked = mark }
      document.all.TypeAllOrd.checked = false;
   }
   else
   {
      for(var i=0; i < type.length; i++) { type[i].checked = false; }
      type[0].checked = mark;
      type[1].checked = mark;
      type[3].checked = mark;
      document.all.TypeAll.checked = false;
   }
}
//==============================================================================
// check All Status
//==============================================================================
function chkStsAll(chko)
{
   var sts = document.all.Sts;
   var mark = false;
   if (chko.checked) mark = true;
   for(var i=0; i < sts.length; i++)
   {
      if(sts[i].value != "P" && sts[i].value != "N"){ sts[i].checked = mark }
   }
}
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<HTML><HEAD><meta http-equiv="refresh">

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
        <BR>Timecard Recap - Selection</B>
        <br><a href="../" class="small"><font color="red">Home</font></a>

      <TABLE>
        <TBODY>
        <!-- ============== select Order changes ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=5>Week Selection</TD></tr>

        <TR>
          <TD id="tdDate" colspan=4 align=center style="padding-top: 10px;" >
              <button class="Small" name="Down" onClick="setDate('DOWN', 'Wkend')">&#60;</button>
              <input class="Small" name="Wkend" type="text" size=10 maxlength=10 readonly>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'Wkend')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.Wkend)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="5" >&nbsp;</TD></TR>
        <TR>
            <TD align=center colSpan=5>
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