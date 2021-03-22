<!DOCTYPE HTML > 
<%@ page import="java.util.*, java.text.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=MozuStrSrlRtnSel.jsp&APPL=ALL");
   }
   else
   {
	   String sUser = session.getAttribute("USER").toString();
	   String sSelStr = "ALL";		
	   String sStrAllowed = session.getAttribute("STORE").toString();		
	   if(!sStrAllowed.startsWith("ALL")){ sSelStr = sStrAllowed; }
	   int iSpace = 6;
	   	   
	   
	   if (session.getAttribute("W70ITMRET") != null)
	   {
		   sSelStr = "70";		   
	   }
	   
	   boolean bProbAllow = false;
	   if(sUser.indexOf("w7") == 0)
	   {
		   bProbAllow = true;
	   }
%>
<html>
<head>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Item Return</title>


<script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>

<script name="javascript">
var CstProp = null;
var Cust = null;
var SelStr = "<%=sSelStr%>";
var User = "<%=sUser%>"
var NewOrd = null;
var NewOrdDt = null;
var NewDays = null;

//jQuery(function($){ $("#Cust").mask("999-999-9999");	});
document.onkeypress = disableEnterKey;
//==============================================================================
//disable enter key
//==============================================================================
function disableEnterKey(e)
{
  var key;
  if(window.event)
  {
       key = window.event.keyCode; //IE
       if (key == 13)
       { 
    	   Validate(); 
       }
  }
  return (key != 13);
}
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
  	//document.all.tdDate1.style.display="inline"
  	//document.all.tdDate2.style.display="none"
  	$('.Date2').hide();
  	$('.More').hide();
  
  	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
  	document.all.PackId.focus();
  	document.all.Cust.value = ""; 
  	document.all.Sku.value = "";
}
//==============================================================================
//get more selection 
//==============================================================================
function getMoreSel()
{
	$('.More').toggle();
	$('.MoreLink').hide();
	
}
//==============================================================================
// show date selection
//==============================================================================
function showDates(datety)
{
    $('.Date1').hide();
	$('.Date2').toggle();
	
	
    doSelDate(datety)
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates(datety)
{
      $('.Date1').toggle();
	  $('.Date2').hide();
	  
      document.all.FrOrdDate.value = "01/01/0001";
      document.all.ToOrdDate.value = "12/31/2999";
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(datety)
{  
  var date = new Date(new Date() - 7 * 86400000);
  document.all.FrOrdDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  date = new Date(new Date());
  document.all.ToOrdDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
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
// Validate form entry fields
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";
  var br = "";
  document.all.tdError.innerHTML = "";
   
  var cust = document.all.Cust.value.trim();
  
   
  var ord = document.all.Order.value.trim().toUpperCase();
  if(ord != "" && (isNaN(ord) || eval(ord) == 0)){error=true; msg += br + "Order is not numeric or 0."; br = "<br>";}
  else if(ord != "") 
  {
	  if( !getScannedOrdPack(ord, "Order"))
      {
  		  error=true; msg += br + "Order is not found on System."; br = "<br>"; 
  	  }
	  else if(eval(NewDays) > 90 && eval(NewDays) < 365)
	  {
		  var text = "This Order " + NewOrd + " on " + NewOrdDt
		  + ", purchased " + NewDays + " days ago!"
		  + "\nPlease verify this is the correct Order # being returned, before continuing."
		  var cont = confirm(text);
		  if(cont != true ){ error=true; msg += br + "You cancelled selection."; br = "<br>"; }
	  } 
	  else if(eval(NewDays) >= 365)
	  {
		  var text = "This order cannot be returned (over 1 year since purchased)." 
		      + " Please contact ECOM Customer Service, for further assistance."
		  alert(text);
		  error=true; 
		  msg += br + "The order is too old."; br = "<br>"; 
	  } 
	  
  } 
  
  var pack = document.all.PackId.value.trim().toUpperCase();
  if(pack != "" && (isNaN(pack) || eval(pack) == 0)){error=true; msg += br + "Order is not numeric or 0."; br = "<br>";}
  else if(pack != "") 
  {
	  if( !getScannedOrdPack(pack, "Pack") )
      {
  		  error=true; msg += br + "Pack is not found on System."; br = "<br>"; 
  	  }
  	  else if(eval(NewDays) > 90)
	  {
		  var text = "The Packing ID entered is from Order " + NewOrd + " on " + NewOrdDt
		  + ", purchased " + NewDays + " days ago!"
		  + "\nPlease verify this is the correct Order # being returned, before continuing."
		  ;
		  var cont = confirm(text);
		  if(cont != true ){ error=true; msg += br + "You cancelled selection."; br = "<br>"; }
	  } 
  } 
   
  
  var sku = document.all.Sku.value.trim().toUpperCase();
  if(sku != "" && (isNaN(sku) || eval(sku) == 0)){error=true; msg += br + "SKU is not numeric or 0."; br = "<br>";}
  else if(sku != "") 
  {
	  var sku = getScannedItem(sku);  
  	  if( sku == "")
      {
  		  error=true; msg += br + "Item is not found on System."; br = "<br>"; 
  	  }
  }

  var rtnsts = new Array();
  var stschk = false;
  var stsobj = document.all.Sts;
  if(SelStr == "ALL")
  {  
	  for(var i=0; i < stsobj.length; i++)
	  {
	  	if(stsobj[i].checked)
	 	 {
			  rtnsts[rtnsts.length] = stsobj[i].value;
			  stschk = true;
		  }	 	   
	  }
  }
  else { rtnsts[0] = "ALL"; stschk = true; }
  
  if( !stschk ){error=true; msg += br + "Please select return Status."; br = "<br>";}
  
  var frdate = document.all.FrOrdDate.value;
  var todate = document.all.ToOrdDate.value;
  
  if(cust=="" ){ cust = "ALL"; }
  if(ord=="" ){ ord = "ALL"; }
  if(sku=="" ){ sku = "ALL"; }
  if(pack=="" ){ pack = "ALL"; }
  
  if(SelStr != "ALL" && cust=="ALL" && ord=="ALL" && pack=="ALL" && sku=="ALL" && frdate=="01/01/0001" && todate=="12/31/2999" )
  {
	  error=true; msg += br + "Please select at least one parameter or date range"; br = "<br>";
  }    
  
  if (error) document.all.tdError.innerHTML = msg;
  else { sbmRep(cust, ord, pack, sku, rtnsts, frdate, todate);  }
  return error == false;
}
//==============================================================================
//check scanned item against order
//==============================================================================
function getScannedItem(item)
{
	var valid = true;
	var sku = null;
	var desc = null;
	var url = "EComItmAsgValidItem.jsp?Item=" + item;

	var xmlhttp;
	// code for IE7+, Firefox, Chrome, Opera, Safari
	if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
	// code for IE6, IE5
	else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

	xmlhttp.onreadystatechange=function()
	{
 		if (xmlhttp.readyState==4 && xmlhttp.status==200)
 		{
    		var  resp = xmlhttp.responseText;
    		var beg = resp.indexOf("<UPC_Valid>") + 11;
    		var end = resp.indexOf("</UPC_Valid>");
    		valid = resp.substring(beg, end) == "true";

		    var beg = resp.indexOf("<SKU>") + 5;
    		var end = resp.indexOf("</SKU>");
    		sku = resp.substring(beg, end);
    		NewSku = sku;
    		
    		var beg = resp.indexOf("<DESC>") + 6;
    		var end = resp.indexOf("</DESC>");
    		desc = resp.substring(beg, end);
    		NewDesc = desc;     		
    		
 		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return sku.trim();
}
//==============================================================================
//check scanned item against order
//==============================================================================
function getScannedOrdPack(scan, type)
{
	var valid = true;
	NewOrd = null;
	NewDays = null;
	NewOrdDt = null;
	
	var url = "MozuValidOrdPack.jsp?";
	if(type=="Order"){url += "Order=" + scan; }
	else if(type=="Pack"){ url += "Pack=" + scan ;}

	var xmlhttp;
	// code for IE7+, Firefox, Chrome, Opera, Safari
	if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
	// code for IE6, IE5
	else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

	xmlhttp.onreadystatechange=function()
	{
 		if (xmlhttp.readyState==4 && xmlhttp.status==200)
 		{
    		var  resp = xmlhttp.responseText;
    		valid = getXmlValue("ORD_Valid", resp) == "true";
            if(valid)
            {
               NewOrd = getXmlValue("Order", resp);
               NewOrdDt = getXmlValue("Ord_Dt", resp);
               NewDays = getXmlValue("Days", resp);
            }
 		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return valid;
}
//==============================================================================
//get XML value 
//==============================================================================
function getXmlValue(tag, resp)
{
	var opntag = "<" + tag + ">";
	var beg = resp.indexOf(opntag) + opntag.length;
	var clstag = "</" + tag + ">";
	var end = resp.indexOf(clstag);
	xmlval = resp.substring(beg, end);
	return xmlval;
}
//==============================================================================
// unmask
//==============================================================================
function unmask(phone)
{
	var nphn = "";
	for(var i=0; i < phone.length; i++)
	{
		if(phone.substring(i, i+1) != "("
		   && phone.substring(i, i+1) != ")"
		   && phone.substring(i, i+1) != "-"
		   && phone.substring(i, i+1) != " "
		)
		{ 
			nphn += phone.substring(i, i+1); 
		}
	}
	return nphn
}
//==============================================================================
// submit form
//==============================================================================
function sbmRep(cust, ord, pack, sku, rtnsts, frdate, todate) 
{   
   var url = "MozuStrSrlRtn.jsp?Cust=" + cust
     + "&Order=" + ord
     + "&Pack=" + pack
     + "&Sku=" + sku
	 + "&FrDate=" +  frdate
     + "&ToDate=" + todate

    for(var i=0; i < rtnsts.length; i++)
    {
   		url += "&Sts=" + rtnsts[i];
    }
   
   //alert(url)
   window.location.href=url
}
//==============================================================================
// set problem order
//==============================================================================
function setProblemOrd()
{
	var hdr = "DC/ECOM Problem Order - Email"
	
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popProblemOrd()
	     + "</td></tr>"
	   + "</table>"

	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft = document.documentElement.scrollLeft + 200;
	document.all.dvItem.style.pixelTop = document.documentElement.scrollTop + 120;
	document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//validate store status changes
//==============================================================================
function popProblemOrd()
{
	var panel = "";
	
	panel += "<table class='tbl02'>"
	  + "<tr class='trDtl09'>"
	  	+ "<td class='td48'>Type of Trouble:</td>"
	  	+ "<td class='td48'>" 
	  		+ "<input type='radio' name='Type' value='O'>No Order Info"
	  		+ " &nbsp; <input type='radio' name='Type' value='S'>Return to Sender"
	  	+ "</td>"
	  + "</tr>"
	  + "<tr class='trDtl09'>"
	  	+ "<td class='td48'>UPC/SKU:</td>"
	  	+ "<td class='td48'>" 
	  		+ "<input class='Small' name='Search' size='14' maxlength='12'>"
	  		+ "&nbsp; <span class='Small' id='spnDesc'></span"
	  	+ "</td>"
	  + "</tr>"
	  + "<tr class='trDtl09'>"
	  	+ "<td class='td48'>Tracking ID:</td>"
	  	+ "<td class='td48'>" 
	  		+ "<input class='Small' id='Track' size='50' maxlength='50'>"
	  	+ "</td>"
	  + "</tr>"
	  + "<tr class='trDtl09'>"
	  	+ "<td class='td48'>Comments:</td>"
	  	+ "<td class='td48'>" 
	  	    + "<input class='Small' id='Comment' size='100' maxlength='100'>"	  		
	  	+ "</td>"
	  + "</tr>"
	
	panel += "<tr class='trDtl09'>"
		+ "<td class='tdError' id='tdError1' colspan=2></td>"
	  + "</tr>";
	  
			
	panel += "<tr class='trDtl09'>"
  	+ "<td nowrap class='td09' colspan=2><button onClick='VldProblemOrd()' class='Small'>Submit</button>"
  	+ " &nbsp; <button onClick='hidePanel();' class='Small'>Cancel</button>"
	 + "</td></tr></table>"
	 
	return panel;
}
//==============================================================================
// validate Problem Order
//==============================================================================
function VldProblemOrd()
{
	  var error = false;
	  var msg = "";
	  var br = "";
	  document.all.tdError1.innerHTML = "";
	  
	  var type = "";
	  for(var i=0; i < document.all.Type.length ; i++)
	  {
		  if(document.all.Type[i].checked)
		  {
			  type = document.all.Type[i].value;
		  }			  
	  }
	  
	  if(type == ""){ error=true; msg += br + "Please select Type of problem."; br = "<br>"; }
	  
	  var sku = document.all.Search.value.trim().toUpperCase();
	  if(sku != "" && (isNaN(sku) || eval(sku) == 0)){error=true; msg += br + "SKU is not numeric or 0."; br = "<br>";}
	  else if(sku != "") 
	  {
		  var sku = getScannedItem(sku);  
	  	  if( sku == "")
	      {
	  		  error=true; msg += br + "Item is not found on System."; br = "<br>"; 
	  	  }
	  	  else{ document.all.spnDesc.innerHTML = NewDesc; }
	  }
	  
	  var track = document.all.Track.value.trim();
	  
	  var comment = document.all.Comment.value.trim();
	  if(sku=="" && comment=="")
	  {
		  error=true; msg += br + "The Comment is required, if sku is not entered."; br = "<br>";
	  }
	  
	  
	  if (error) document.all.tdError1.innerHTML = msg;
	  else { sbmProblemOrd(type, sku, track, comment );  }
}
//==============================================================================
// submit Problem Order
//==============================================================================
function sbmProblemOrd(type, sku, track, comment  )
{
 	var nwelem = window.frame1.document.createElement("div");
	nwelem.id = "dvSbmProbOrd"
	aSelOrd = new Array();

	var html = "<form name='frmSndProbOrd'"
	 + " METHOD=Post ACTION='MozuStrSlrRtnSv.jsp'>"
	 + "<input name='Type'>"
	 + "<input name='Sku'>"	 
	 + "<input name='Track'>"	
	 + "<input name='Comment'>"
	 + "<input name='Action'>"
	 + "<input name='User'>"
	html += "</form>"

	nwelem.innerHTML = html;
	window.frame1.document.body.appendChild(nwelem);
	 
	window.frame1.document.all.Type.value = type;
	
    window.frame1.document.all.Sku.value = sku;
    window.frame1.document.all.Track.value = track;
	window.frame1.document.all.User.value = User;
	
	comment = comment.replace(/\n\r?/g, '<br />');
	window.frame1.document.all.Comment.value = comment;
	
	window.frame1.document.all.Action.value = "SendProbOrd";
	
	window.frame1.document.frmSndProbOrd.submit();
}
//==============================================================================
//submit Problem Order
//==============================================================================
function restart()
{
    alert("The e-mail has been send to ECOM.");	
    hidePanel();
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
//--------------------------------------------------------
// set return status
//--------------------------------------------------------
function setSts(sel)
{
	var sts = document.all.Sts;
	for(var i=0; i < sts.length; i++)
	{
		if(sel == "ALL" && sts[i].value != sel)
		{
			sts[i].checked = false;
		}
		else if(sel != "ALL" && sts[i].value == "ALL")
		{
			sts[i].checked = false;
		}		
	}
}
</script>

<!-- import calendar functions -->
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<body onload="bodyLoad();" class="body">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
 
<!-------------------------------------------------------------------->


<TABLE class="tbl05">
  <TBODY>
  <TR>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>ECOM Item Return - Selection</B>

       <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>
       <br><!-- a href="mailto: allecomm@sunandski.com"><font color="green" size="-1">E-Mail To ECOM</font></a -->
       <%if(bProbAllow){%>
       		<button class="Small" onclick="setProblemOrd()">ECOM Problem Order</button>
       <%}%>
       <br>&nbsp;

       <!-- -->
      <TABLE  border="0">
         
        <!-- ======================== Order ======================================= -->
        <TR>
          <td>Scan Packing ID:</td>
          <td><input name="PackId"></td>          
        </TR>
        <TR>
           <td colspan=2 style="font-size:10px;">(barcode next to Order #)<br>&nbsp;</td>
        </TR>
        
        <TR>
           <td colspan=2 style="font-size:14px;text-align:center; font-weight:bold">- OR - <br>&nbsp;</td>
        </TR>
        
        
        <TR>
          <td>Enter Order #:</td>
          <td><input name="Order"></td>          
        </TR>
        
        <!-- ======================== Processed ======================================= -->
        <%if(sSelStr.equals("ALL")){%>
        	<TR>
          		<td>Status:</td>
          		<td>          		   
          		   <input name="Sts" type="checkbox" onclick="setSts('Submitted')" value="Submitted">Submitted &nbsp; &nbsp; &nbsp;
          		   <input name="Sts" type="checkbox" onclick="setSts('Waiting')" value="Waiting" >Waiting &nbsp; &nbsp; &nbsp;
          		   <input name="Sts" type="checkbox" onclick="setSts('Processed')" value="Processed" >Processed &nbsp; &nbsp; &nbsp;
          		   <input name="Sts" type="checkbox" onclick="setSts('Error')" value="Error" >Error &nbsp; &nbsp; &nbsp;
          		   <input name="Sts" type="checkbox" onclick="setSts('Error')" value="Fixed" >Fixed &nbsp; &nbsp; &nbsp;       		   
          		   <input name="Sts" type="checkbox" onclick="setSts('ALL')" value="ALL" checked>Any
          		</td>          
        	</TR>
        <%}%>
        
        
        
        
        <TR id="trMore" class="MoreLink">
          <td colspan="2" style="text-align:center">&nbsp;<br>   
             <a href="javascript: getMoreSel(); ">More Selections</a><br> &nbsp;
          </td>
        </tr>
        <tbody id="tbMore" class="More"> 
        
        
        <!-- ======================== Customer ======================================= -->
        <TR id="trCust" class="Cust">
          <td>Customer:</td>
          <td><input id="Cust" name="Cust"  type="text"/></td>
                    
        </TR>  
        <!-- ======================== SKU ======================================= -->
        <TR id="trSku" class="Sku">
          <td>SKU or UPC:</td>
          <td><input name="Sku"></td>          
        </TR>
        
         
        <!-- ======================== From Date ======================================= -->
        <%if(sSelStr.equals("ALL")){%>
        <TR>
          <td id="tdDate1" class="Date1" colspan=2 style="text-align:center;" >   
             <button class="Small" id="btnSelOrdToday" onclick="showDates('SEASON')">Date Selection</button> &nbsp
          </td>
        </tr>
        <%} %>
                
        <tr>  
          <TD id="tdDate2" class="Date2" colspan=2>
             <b>Order Date From:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrOrdDate')">&#60;</button>
              <input class="Small" name="FrOrdDate" type="text" value="01/01/0001" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrOrdDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 300, 150, document.all.FrOrdDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < iSpace * 2; i++){%>&nbsp;<%}%>

              <b>Order Date To:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToOrdDate')">&#60;</button>
              <input class="Small" name="ToOrdDate" type="text" value="12/31/2999" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToOrdDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 700, 150, document.all.ToOrdDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelOrdDates" onclick="showAllDates('ORD')">All Date</button>
          </TD>
        </TR>
        
        </tbody>

        <!-- =============================================================== -->
        <TR>
           <TD colspan=2 style="text-align:center"> 
               <button type=submit onclick="Validate()" name=SUBMIT >Submit</button>
           </TD>
        </TR>
        <!-- =============================================================== -->
        <TR>
           <TD colspan=2 style="color:red;text-align: left" id="tdError"></TD>
        </TR>
        
       <!-- =============================================================== -->
       </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</body>
</html>
<%}%>