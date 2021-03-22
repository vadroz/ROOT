<%@ page import="java.util.*, java.text.*"%>
<%    
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MozuRtvOptCateg.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
   
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Mozu Rtv Opt & Categ</title>

<SCRIPT>

//--------------- Global variables -----------------------
var progressIntFunc = null;
var progressTime = 0;
//--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
// update Options
//==============================================================================
function updOptions(action)
{
	progressIntFunc = setInterval(function() {showProgress() }, 1000);
	
	var url = "MozuRtvOptCategUpd.jsp?Action=" + action;
	window.frame1.location.href = url;
}

//==============================================================================
// show message
//==============================================================================
function showMsg(msg)
{
	clearInterval( progressIntFunc );
	hidePanel2();
	progressTime = 0;
	
	alert(msg);
}

//==============================================================================
//hide panel
//==============================================================================
function hidePanel()
{
	document.all.dvItem.innerHTML = "";
	document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
//show exist options for selection
//==============================================================================
function showWaitBanner()
{	
	progressTime++; 
	var html = "<table><tr style='font-size:12px;'>"
	html += "<td>Please wait...</td>";  
	
	for(var i=0; i < progressTime; i++)
	{ 
		html += "<td style='background:blue;'>&nbsp;</td><td>&nbsp;</td>";
	}
	html += "</tr></table>";
	
	if(progressTime >= 10){ progressTime=0; }
	
	document.all.dvWait.innerHTML = html;
	document.all.dvWait.style.height = "20px";
	document.all.dvWait.style.pixelLeft= document.documentElement.scrollLeft + 340;
	document.all.dvWait.style.pixelTop= document.documentElement.scrollTop + 205;
	document.all.dvWait.style.backgroundColor="#cccfff"
	document.all.dvWait.style.visibility = "visible";
}
//==============================================================================
//show error from Mozu New Option creation  
//==============================================================================
function showProgress()
{	
	progressTime++; 
	var html = "Please wait while database is updating<br>"
	  + "<table><tr style='font-size:10px;'>"
	
	for(var i=0; i < progressTime; i++)
	{ 
		html += "<td style='background:blue;'>&nbsp;</td><td>&nbsp;</td>";
	}
	html += "</tr></table>";
	
	if(progressTime >= 10){progressTime=0;}
	
	document.all.dvProgBar.innerHTML = html;
  document.all.dvProgBar.style.width = 250;
	document.all.dvProgBar.style.pixelLeft= document.documentElement.scrollLeft + 400;
	document.all.dvProgBar.style.pixelTop= document.documentElement.scrollTop + 300;
	document.all.dvProgBar.style.visibility = "visible";
}
//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel2()
{
	document.all.dvProgBar.innerHTML = "xxx";
	document.all.dvProgBar.style.visibility = "hidden";
}
</SCRIPT>
<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvWait" class="dvItem"></div>
<div id="dvProgBar" class="dvProgBar"></div>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<iframe  id="frame2"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Mozu Retrieve Options or Categories and Update AS/400 Files 
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;              
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr>
          <td align=center>
          	<button onclick="updOptions('Upd_Option')">Update Options</button> &nbsp; &nbsp; &nbsp;
          	<button onclick="updOptions('Upd_Categ')">Update Categories</button>        
      	  </td>
      </tr>
   </table>
 </body>
</html>
<%
}
%>