<%@ page import="java.util.*, java.text.*"%>
<%
%>
<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }


  div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
  td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
  .myCorner{ background: white}
  .myCorner1{ background: red}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<!-- script type="text/javascript" src="JQuery/jquery-1.7.2.js"></script -->

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript" src="http://malsup.github.com/jquery.corner.js"></script>

<script>
$(document).ready(function(){
   $("#dvRound").corner("round 8px").parent().css('padding', '4px').corner("round 10px")
});

</script>

<script name="javascript">

//==============================================================================
//  display Wait Panel
//==============================================================================
function showWaitPanel()
{
  StartTime = new Date();

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' id='tdHdr' nowrap>Starting Time " + StartTime.getHours() + ":" + StartTime.getMinutes() + ":" + StartTime.getSeconds() + "</td>"
    + "<tr><td class='Prompt'><br><br><br><marquee>Wait while data is retreiving...</marquee><br><br><br></td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";

   setTimer();
}

//==============================================================================
//  set Timer
//==============================================================================
function setTimer()
{
	setTimeout("showTime()",1000);
	return false;
}
//==============================================================================
//  set Timer
//==============================================================================
function showTime()
{
   var date = new Date();
   document.all.tdHdr.innerHTML = "Starting Time " +  + StartTime.getHours() + ":" + StartTime.getMinutes() + ":" + StartTime.getSeconds()
     + " &nbsp; &nbsp; Current Time " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();

   loadXMLDoc();

   setTimeout("showTime()",1000);
}

function loadXMLDoc()
{
   var xhttp = null;
   if (window.XMLHttpRequest)
   {
      // code for IE7+, Firefox, Chrome, Opera, Safari
      xhttp = new XMLHttpRequest();
   }
   else
   {
      // code for IE6, IE5
      xhttp = new ActiveXObject("Microsoft.XMLHTTP");
   }
   xhttp.open("GET","Ajax_getReq.jsp?t=" + Math.random(),true);
   xhttp.send();

   xhttp.onreadystatechange=function()
   {
     if (xhttp.readyState==4 && xhttp.status==200)
     {
       document.getElementById("dvTime").innerHTML=xhttp.responseText;
     }
   }
}
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY>
<!-- ========================================================================-->
<div id="dvItem" class="dvItem"></div>
<!-- ========================================================================-->

<div id="myDiv"><h2>Let AJAX change this text</h2></div>
<button type="button" onclick="loadXMLDoc()">Change Content</button>
<div id="dvTime"></div>

<br>
<br>
<br>

<button onclick="showWaitPanel();">Timer</button>

<br>
<br>
<div class="myCorner1">
<div class="myCorner" id="dvRound">Test<br>Test<br>Test<br>Test<br>Test</div>
</div>

</BODY></HTML>
