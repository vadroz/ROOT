<%@ page import="java.util.*, java.text.*"%>
<%
%>
 
<html>
<head><Meta http-equiv="refresh"></head>
<title>Camera</title>

<style>
.draggable { position:absolute; background-attachment: scroll;
              width:50; background:LemonChiffon; z-index:10;
              text-align:center; vertical-align:top; font-size:10px}

        
        td.BoxName {cursor:move; background: #016aab; color:white; text-align:center; font-family:Arial; 
                     font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background: #016aab;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
</style>


<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script class="jsbin" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>


<SCRIPT language="JavaScript">
//==============================================================================
// initializing process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) 
	{  
		isSafari = true;
		setDraggable();
	}
}

//==============================================================================
//submit store status changes
//==============================================================================
function sbmStrSts()
{	
	clearIframeContent("frame1");
	var nwelem = "";
	
	if(isIE){ nwelem = window.frame1.document.createElement("div"); }
	else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
	else{ nwelem = window.frame1.contentDocument.createElement("div");}
	nwelem.id = "dvSendEMail"
	
	var html = "<form name='frmCommt'"
   + " METHOD=Post ACTION='PiStrAreaSkuEntSv.jsp'>"
   + "<input name='Str'>"
   + "<input name='PiCal'>"    
   + "<input name='Comment'>"
   + "<input name='Action'>"
   + "<input name='User'>"
   
	html += "</form>"
		  		
	nwelem.innerHTML = html;	
	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
	else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
	else if(isSafari){ window.frame1.document.body.appendChild(nwelem); }
	else{ window.frame1.contentDocument.body.appendChild(nwelem); }

	 
	 
	if(isIE || isSafari)
	{ 
		window.frame1.document.all.Str.value = "xxx";	
		window.frame1.document.all.PiCal.value = "xxx";	 
		window.frame1.document.all.Action.value = "ADDSTRCOMMT";
		window.frame1.document.all.Comment.value = "xxx";
		window.frame1.document.all.User.value="xxx";
		window.frame1.document.frmCommt.submit();
	}
	else
	{
		window.frame1.contentDocument.forms[0].Str.value = "xxx";	 
		window.frame1.contentDocument.forms[0].PiCal.value = "xxx";	 
		window.frame1.contentDocument.forms[0].Action.value = "ADDSTRCOMMT";
		window.frame1.contentDocument.forms[0].Comment.value = "xxx";
		window.frame1.contentDocument.forms[0].User.value="xxx";
		window.frame1.contentDocument.forms[0].submit();
	}

	
}
//==============================================================================
// clear  iframe content
//==============================================================================
function clearIframeContent(id) {
	  var iframe = document.getElementById(id);
	    try {
	      var doc = (iframe.contentDocument)? iframe.contentDocument: iframe.contentWindow.document;
	      doc.body.innerHTML = "";
	    }
	    catch(e) {
	      // alert(e.message);
	    }
	  return false;
	}
//==============================================================================
//show iframe content
//==============================================================================
function showIframeContent(id) {
	  var iframe = document.getElementById(id);
	    try {
	      var doc = (iframe.contentDocument)? iframe.contentDocument: iframe.contentWindow.document;
	      alert(doc.body.innerHTML);
	    }
	    catch(e) {
	       alert(e.message);
	    }
	  return false;
	}
//==============================================================================
//search order 
//==============================================================================
function searchOrder(inp)
{
	alert(" key=" + window.event.keyCode + " val=" + inp.value);
}

</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvItem" class="draggable"><br>Drug me<br>&nbsp</div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" frameborder=0 height="300" width="100%"></iframe>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
      <br>Test Mobile Camera 
      </b>
     </tr>
     <tr>
       <td>
          Camera: <input type="file" accept="image/*" capture="camera">          
       </td>
     </tr>
  
    <tr>
    	<td><button onclick="javascript: sbmStrSts()">Submit</button></td>
    </tr>
    
    <tr>
    	<td>Scan:<br>   
    	<input name="ScanOrd" 
    	   onkeypress="alert(window.event.keyCode); if (window.event.keyCode < 48 || window.event.keyCode > 57) { searchOrder(this); }" 
    	   maxlength=15 size=15>
    	</td>
    </tr>
    
    <tr>
    	<td>Scan:<br>
    	<input name="ScanOrd" 
    	   onkeypress="if (window.event.keyCode == 13) { searchOrder(this); }" 
    	   maxlength=15 size=15>
    	</td>
    </tr>
    
    <tr>
    	<td>Scan:<br>
    	<input name="ScanOrd" 
    	   onkeypress="if (window.event.keyCode == 13) { searchOrder(this); }" 
    	   maxlength=15 size=15>
    	</td>
    </tr>
      
   </table>         
 </body>

</html>
 

 
