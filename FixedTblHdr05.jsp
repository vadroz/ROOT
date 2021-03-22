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
<script LANGUAGE="JavaScript1.2" src="XXsetFixedTblHdr.js"></script>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
function bodyLoad()
{	 
	getHdrWidth("thead1");
	getDtlRowWidth("tbody1");
	
	window.status = dWidth + " - " + hWidth; 
}

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
      <th class="th13" id="thDiv">Div</th>  
      <th class="th13" id="thXfer" rowspan=2>&nbsp;</th>    
      <th class="th13" id="thXfer" colspan=3>Xfer<br>%</th>      
    </tr>
    <tr class="trHdr01"  id="trHdr2">
      <th class="th13" id="thUser" >User</th>
      <th class="th13" id="thDate" >Date</th>      
      <th class="th13" id="thDate" >Time</th>
      <th class="th13" id="thDate" >Seconds</th>
    </tr>
    </thead>
    <tbody id="tbody1">
<!------------------------------- Detail Data --------------------------------->
    <%for(int i=0; i< 100; i++){    	        
    %>
      <tr class="trDtl04">
      	<td class="td11" nowrap ><%=i * 10%></td>
      	<th class="th13" >&nbsp;</th>    
      	<td class="td11" nowrap ><%=i * 1317%></td>
      	<td class="td11" nowrap ><%=i * 5%></td>
      	<td class="td11" nowrap ><%=i * 6%></td>
      </tr>
    <%}%>
<!---------------------------- end of Detail data ----------------------------->
	</tbody>
 </table>

 <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>

<% 
%>
