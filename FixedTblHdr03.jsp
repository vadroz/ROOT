<!DOCTYPE html>
<%@ page import=" java.util.*"%>
<%     

%>
<html>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE11" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var hWidth = new Array();
var hdr = new Array();

//--------------- End of Global variables ----------------
function bodyLoad()
{	 
	 
	hdr[0] = document.getElementById("thDiv");	
	hdr[1] = document.getElementById("thXfer");
	hdr[2] = document.getElementById("thUser");
	hdr[3] = document.getElementById("thDate");
	
	hWidth[0] = hdr[0].scrollWidth;
	hWidth[1] = hdr[1].scrollWidth;
	hWidth[2] = hdr[2].scrollWidth;
	hWidth[3] = hdr[3].scrollWidth;
	
	window.status = hWidth; 
}

 
//=========================================================
// check scroll
//=========================================================
$(window).scroll(function() 
{	
	var row = document.all.thead1;
	var elementTop = $(row).offset().top;
	var elementBottom = elementTop + $(row).outerHeight();
	var viewportTop = $(window).scrollTop();
	var viewportBottom = viewportTop + $(window).height();

	if(elementTop + 20 < viewportTop  )
	{
		var offsetTop = viewportTop; // $(this).scrollTop();
		$("#thead1").css({position : "absolute", "z-index" : 60, top: offsetTop});		
		
		hdr[0].width = hWidth[0];
		hdr[1].width = hWidth[1];
		hdr[2].width = hWidth[2];
		hdr[3].width = hWidth[3];
	}
	else 
	{
		$("#thead1").css({position : "static"});		
	}
		
	window.status = "elementTop=" + elementTop + " | viewportTop=" + viewportTop
	  + " offsetTop=" + offsetTop

});
</SCRIPT>


</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
    <div id="dvComment" class="dvComment">test div position</div>
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
  <!----------------- Items Send to store table ------------------------>
 <b>TEST</b> 
  <table class="tbl02" cellPadding="0" cellSpacing="0">
    <thead id="thead1">
    <tr class="trHdr01" id="trHdr1">
      <th class="th02" id="thDiv">Div</th>      
      <th class="th02" id="thXfer">Xfer<br>%</th>      
    </tr>
    <tr class="trHdr01"  id="trHdr2">
      <th class="th02" id="thUser" >User</th>
      <th class="th02" id="thDate" >Date</th>      
    </tr>
    </thead>
<!------------------------------- Detail Data --------------------------------->
    <%for(int i=0; i< 100; i++){    	        
    %>
      <tr class="trDtl04">
      	<td class="td11" nowrap ><%=i * 10%>  xxxxxxxxxxxxx</td>
      	<td class="td11" nowrap ><%=i * 1317%> DDDDDDDDDDDDDDDDD</td>        
      </tr>
    <%}%>
<!---------------------------- end of Detail data ----------------------------->
 </table>

 <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>

<% 
%>
