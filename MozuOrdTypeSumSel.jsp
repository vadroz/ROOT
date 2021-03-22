<!DOCTYPE html>	
<!--%@ page import=";"%-->

<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=MozuOrdTypeSel.jsp&APPL=ALL");
   }
   else
   {
%>

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Mozu Order Type Summary</title>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
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
function doSelDate(){
  var df = document.all;
  var date = new Date(new Date() - 86400000);
  df.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

  date = new Date(date.getTime() - 6 * 86400000);
  df.FromDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

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
function Validate()
{
  var error = false;
  var msg = "";
  
  var from = document.all.FromDate.value;
  var to = document.all.ToDate.value;

  if (error) alert(msg);
  else{ sbmOrdList(from, to) }
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmOrdList(from, to)
{
  var url = null;
  url = "MozuOrdTypeSum.jsp?"

  url += "From=" + from
      + "&To=" + to

  //alert(url)
  window.location.href=url;
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
  <TR>
    <TD  height="20%"><IMG
    src="Sun_ski_logo4.png"></TD>
  </TR>
  
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Mozu Order Type Summary - Selection</B><br>
        <br><a href="/" class="Small">Home</a>

             
      <TABLE>
        <TBODY>
         

        <!-- ============== select latest changes ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD id="tdDate2" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FromDate')">&#60;</button>
              <input class="Small" name="FromDate" type="text" size=10 maxlength=10 >&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FromDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 400, 300, document.all.FromDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate')">&#60;</button>
              <input class="Small" name="ToDate" type="text" size=10 maxlength=10 >&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 700, 300, document.all.ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
          </TD>
        </TR>

        <!-- ================== Buttons ==================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <button onClick="Validate()">Submit</button>
               <br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;
               &nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;
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
