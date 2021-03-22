<%@ page import="advertising.FisCal, java.util.*"%>
<%
   String sMonBeg = request.getParameter("MonBeg");
   String sMonEnd = request.getParameter("MonEnd");
   String sAction = request.getParameter("Action");

   if(sMonBeg == null) sMonBeg = " ";
   if(sMonEnd == null) sMonEnd = " ";
   if(sAction == null) sAction = "CURRENT";

   FisCal fisCal = new FisCal(sMonBeg, sMonEnd, sAction);

   String sMon = fisCal.getMon();
   String sYear = fisCal.getFullYear();
   sMonBeg = fisCal.getMonBeg();
   sMonEnd = fisCal.getMonEnd();

   fisCal.disconnect();
%>
<html>
<head>
<style>
        body {background:LemonChiffon;}
        a { color:blue} a:visited { color:blue}  a:hover { color:blue}

        table.Cal { background:LemonChiffon; text-align:center;}
        th.CalH { background-color:lightgrey; text-align:center; font-size:10px}
        td.Cal { background-color:white; text-align:center; font-size:10px}
        div.Cal {border: z-index: 1; text-align:center; font-size:10px}

        .small{ text-align:left; font-family:Arial; font-size:10px;}
</style>
<SCRIPT language="JavaScript1.2">
//------------------------------------------------------------------------------
// global variables
//------------------------------------------------------------------------------
  var Mon = "<%=sMon%>";
  var Year = "<%=sYear%>";
  var MonBeg = "<%=sMonBeg%>";
  var MonEnd = "<%=sMonEnd%>";

//------------------------------------------------------------------------------
// body load
//------------------------------------------------------------------------------
function bodyLoad()
{
  dspCalendar()
}

//==============================================================================
// display Filter for promotion selection
//==============================================================================
function dspCalendar()
{
   var date = new Date(MonBeg);
   var end = new Date(MonEnd);
   date.setHours(18);
   end.setHours(18);

   var rightArrow =  "<img src='right.gif' style='border=none' alt='Next month' width=15 height=10>"
   var leftArrow =  "<img src='left.gif' style='border=none' alt='Privious month' width=15 height=10>"


   var html = "<table class='Cal'>"
     + "<tr>"
     + "<th class='CalH'><a href='javascript: showCal(&#34;PRIOR&#34;)'>" + leftArrow + "</a></th>"
     + "<th class='CalH' colspan='5'>" + Mon + " " + Year + "</th>"
     + "<th class='CalH'><a href='javascript: showCal(&#34;NEXT&#34;)'>" + rightArrow + "</a></th>"
     + "</tr>"
     + "<tr><th class='CalH'>Mo</th><th class='CalH'>Tu</th><th class='CalH'>We</th><th class='CalH'>Th</th><th class='CalH'>Fr</th><th class='CalH'>Sa</th><th class='CalH'>Su</th></tr>"

   while( date <= end)
   {
      html += "<tr>"
      for(var i=0; i < 7 ; i++)
      {
        html +=  "<td class='Cal'>" + date.getDate() + "</td>"
        //Next Date
        date.setDate(date.getDate() + 1);
      }
      html += "</tr>"
   }

     html += "</table>"
     html += "<a href='javascript:window.close()'><b>Close<b></a>"

   document.all.dvCalendar.innerHTML=html
   document.all.dvCalendar.style.pixelLeft=0
   document.all.dvCalendar.style.pixelTop=0
}

//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function showCal(action)
{
  var url = "FisCal.jsp?"
          + "MonBeg=" + MonBeg
          + "&MonEnd=" + MonEnd
          + "&Action=" + action
  window.location.href = url
}
//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, " "); }
    return s;
}
</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<!-------------------------------------------------------------------->
<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvCalendar" class="Cal"></div>
<!-------------------------------------------------------------------->
</body>
</html>


