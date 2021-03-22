<%@ page import="patiosales.PfsMarkClosedDelDate, java.util.*"%>
<%
  String sDate = request.getParameter("Date");
  String sAction = request.getParameter("Action");
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("PFSDELDT") == null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PfsMarkClosedDelDate.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
  if(sAction != null)
  {
      PfsMarkClosedDelDate markdate = new PfsMarkClosedDelDate(sDate, sAction, session.getAttribute("USER").toString());
      markdate.disconnect();
  }
%>
<style>
  body {background:ivory; text-align:center;}
  a:link { color:blue;  font-size:10px;} a:visited { color:blue; font-size:10px;}  a:hover { color:blue; font-size:10px;}
</style>
<SCRIPT language="JavaScript">
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
    getCalendar();
}
//==============================================================================
// get calendar screen
//==============================================================================
function getCalendar()
{
    var pos = getObjectPosition(document.all.CloseDate);
    showCalendar(1, null, null, pos[0], (pos[1]+100), document.all.CloseDate, null,
                 'PfsCheckDelDate.jsp', true)
}

//==============================================================================
// Open/Close Dates on delivery calendar
//==============================================================================
function sbmCloseDate(close)
{
   var date = document.all.CloseDate.value
   if (date!="")
   {
      var action = null;
      if (close) { action="CLOSE";}
      else { action="OPEN";}
      var url = "PfsMarkClosedDelDate.jsp?Action=" + action
              + "&Date=" + date
      window.location.href=url;
   }
   else { alert("Date is not selected.");}
}
//==============================================================================
// get calendar screen
//==============================================================================
function getObjectPosition(obj)
{
   var pos = new Array(2);
   pos[0] = obj.offsetLeft
   pos[1] = obj.offsetTop

   return pos;
}
</SCRIPT>
<script LANGUAGE="JavaScript" src="Calendar.js"></script>



<body onload="bodyLoad()">
<b>Retail Concepts, Inc
<br>Patio Furniture Close Delivery Dates
</b><br><br>
<a href="index.jsp"><font color="red" size="-1">Home</font></a>
<br>
<!---------------------------------------------------------------------------------->
<iframe  id="frameChkCalendar"  src=""  frameborder=0 height="0" width="0"></iframe>
<!---------------------------------------------------------------------------------->
Enter Closed Date: <input name="CloseDate" readonly>
<button onClick="getCalendar()" style="border: none; background:none;">
  <img src="calendar.gif" alt="Show Calendar" width="34" height="21">
</button>

<br><button onClick="sbmCloseDate(true)">Close Date</button> &nbsp; &nbsp;
    <button onClick="sbmCloseDate(false)">Open Date</button>
</body>
<%}%>
