<%@ page import=" rciutility.ClassSelect"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=MozuCnlSumSel.jsp&APPL=ALL");
   }
   else
   {
      
%>
<HTML>
<HEAD>
<title>Mozu Sts Summary</title>
<META content="RCI, Inc." name="E-Commerce">

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

</HEAD>

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
//populate date with yesterdate
//==============================================================================
function doSelDate()
{
	var df = document.all;

	var date = new Date(new Date() - 7 * 86400000);
    df.FrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
    var date = new Date(new Date() - 86400000);
    df.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
//populate date with yesterdate
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
// find object postition
//==============================================================================
function objPosition(obj)
{
   var pos = new Array(2);
   pos[0] = 0;
   pos[1] = 0;
   // position menu on the screen
   if (obj.offsetParent)
   {
     while (obj.offsetParent)
     {
       pos[0] += obj.offsetLeft
       pos[1] += obj.offsetTop
       obj = obj.offsetParent;
     }
   }
   else if (obj.x)
   {
     pos[0] += obj.x;
     pos[1] += obj.y;
   }
   return pos;
}

//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";

  var frdt = document.all.FrDate.value.trim();
  var todt = document.all.ToDate.value.trim();
  
  var stssel = document.all.Sts;
  var sts = null;
  for(var i=0; i < stssel.length; i++)
  {	 
	  if(stssel[i].checked){ sts = stssel[i].value; break; }
  }
    
  if (error) alert(msg);
  else{ sbmPlan(frdt, todt, sts); }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(frdt, todt, sts)
{
  var url = null;
  url = "MozuCnlSum.jsp?"

  url += "FromDt=" + frdt
      + "&ToDt=" + todt
      + "&Sts=" + sts
      + "&Sort=USER"
    ;
  
  //alert(url)
  window.location.href=url;
}
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

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
        <BR>Mozu Summary for Selected Status - Selection</B>
        <br>
          <a href="/"><font color="red" size="-1">Home</font></a>
      <TABLE>
        <TBODY>    
        <tr>
            <TD   nowrap>
              <input class="Small" name="Sts" type="radio" value="Assigned">Assigned &nbsp;
              <input class="Small" name="Sts" type="radio" value="Printed">Printed &nbsp;
              <input class="Small" name="Sts" type="radio" value="Picked">Picked &nbsp;
              <input class="Small" name="Sts" type="radio" value="Problem">Problem &nbsp;
              <input class="Small" name="Sts" type="radio" value="Resolve">Resolve &nbsp;
              <input class="Small" name="Sts" type="radio" value="Shipped" checked>Shipped &nbsp;
              <input class="Small" name="Sts" type="radio" value="Cannot Fill">Cannot Fill &nbsp;
              <input class="Small" name="Sts" type="radio" value="Sold Out">Sold Out &nbsp;
              <input class="Small" name="Sts" type="radio" value="Cancelled">Cancelled &nbsp;
              <input class="Small" name="Sts" type="radio" value="Error">Error
            </td>
        </TR>
        <TR>
          <TD id="tdDate2" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrDate')">&#60;</button>
              <input class="Small" name="FrDate" type="text"  size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 400, 250, document.all.FrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate')">&#60;</button>
              <input class="Small" name="ToDate" type="text"  size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 800, 250, document.all.ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
          </TD>
        </TR>   
       
        <!-- ================================================================================================= -->

        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
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
