<!DOCTYPE html>
<%@ page import="dcfrtbill.CtnInq , java.util.*"%>
<%
   String sSelCtn = request.getParameter("Carton");
   String sAckn = request.getParameter("Ackn");
   String sComment = request.getParameter("Comment");
   String sSort = request.getParameter("Sort");
   
   if(sComment == null || sComment.trim().equals("")){ sComment = " "; }
   if(sSort == null || sSort.trim().equals("")){ sSort = "Div"; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=DcCtnDtlAckn.jsp&APPL=ALL");
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();

      //System.out.println("sort=" + sSort);
      CtnInq cartoninq = new CtnInq(sSelCtn, sSort, sUser);

      boolean bNotFound = cartoninq.getNotFound();
      String sCtn = cartoninq.getCtn();
      String sIssStr = cartoninq.getIssStr();
      String sDstStr = cartoninq.getDstStr();
      String sShipId = cartoninq.getShipId();
      String sShipTrackId = cartoninq.getShipTrackId();
      String sReg = cartoninq.getReg();
      String sTrans = cartoninq.getTrans();
      String sLastDate = cartoninq.getLastDate();
      String sDocNum = cartoninq.getDocNum();
      String sShipDt = cartoninq.getShipDt();
      String sPick = cartoninq.getPick();
      
      int iNumOfItem = 0;
%>

<html>
<head>
<title>Carton Acknowledge</title>

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE11" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>

<SCRIPT language="JavaScript">
var Carton = "<%=sSelCtn%>";
var Ackn = "<%=sAckn%>";
var User = "<%=sUser%>";
var Comment = "<%=sComment%>";

var NumOfItem = 0;
// new Item 
var NewSku = null;
var NewUPC = null;
var NewDesc = null;
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) 
	{  
	   isSafari = true;
	   setDraggable();
	}
	else
	{
	   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
	} 
}
//==============================================================================
//re-sort report
//==============================================================================
function resort(sort)
{
	var url = "DcCtnDtlAckn.jsp?Carton=<%=sSelCtn%>"
	 + "&Sort=" + sort
	;
	
    window.location.href = url
}
//==============================================================================
// reset input fields
//==============================================================================
function reset()
{
	for(var i=0; i < NumOfItem; i++)
	{
		var newitm  = document.getElementById("NewItm" + i).value;
		if(newitm != "Y")
		{
			document.getElementById("chkAfft" + i).checked=false;
			document.getElementById("QtyAfft" + i).value = "";
			document.getElementById("Error" + i).innerHTML = "";
		}
	}
}
//==============================================================================
// validate
//==============================================================================
function Validate()
{
	var error = false;
	var msg = "";
	
	var aItem = new Array();
	var aQty = new Array();
	var found = false;
	var errfld = false;
	for(var i=0; i < NumOfItem; i++)
	{
		var newitm  = document.getElementById("NewItm" + i).value;
		if(newitm != "Y")
		{
			var chkAfft = document.getElementById("chkAfft" + i);
			var item = document.getElementById("Sku" + i).innerHTML;
			var currqty = document.getElementById("CurrQty" + i).innerHTML.trim();
			var qty = document.getElementById("QtyAfft" + i).value.trim();
		
		
			if(chkAfft.checked)
			{  
				if(qty == ""){ qty=currqty; }
			
				if(isNaN(qty)){ error = true; document.getElementById("Error" + i).innerHTML = "Value is not numeric"; errfld = true; }
				aItem[aItem.length] = item;
				aQty[aQty.length] = qty;
				found = true;
			}
			else if(qty != "")
			{ 
				error = true; 
				document.getElementById("Error" + i).innerHTML = "Check item, or clear quantity value."; errfld = true; 
			} 
		}
	}	
	
	if(!found){ error = true; msg += "Please check at least 1 item."; }
	if(errfld){ error = true; msg += "Invalid value(s) entered."; }
	
	
	if(error){ alert(msg); }
	else{ sbmCtnRcv(aItem, aQty); }
}
//==============================================================================
// submit item receiving
//==============================================================================
function sbmCtnRcv(aItem, aQty)
{
	if(isIE){ nwelem = window.frame1.document.createElement("div"); }
	else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
	else{ nwelem = window.frame1.contentDocument.createElement("div");}
    
    nwelem.id = "dvSbmCtnAckn";
  	 var html = "<form name='frmSbmCtnAckn'"
      + " METHOD=Post ACTION='DcCtnDtlAcknSv.jsp'>";
      
   	 html += "<input name='Carton'>"
  		+ "<input name='Comment'>"
  		+ "<input name='Action'>"
   		+ "<input name='User'>"   
   	 
	for(var i=0; i < aItem.length;i++)
    {
		html += "<input name='Sku'>"     
              + "<input name='Qty'>"
              + "<input name='New'>"
		;              
    }
	 
	html += "</form>"
    
    nwelem.innerHTML = html;
    
    if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
    else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
    else if(isSafari){ window.frame1.document.body.appendChild(nwelem); }
    else{ window.frame1.contentDocument.body.appendChild(nwelem); }

    for(var i=0; i < aItem.length;i++)
    {	 
    	if(isIE || isSafari)
	 	{
    		window.frame1.document.all.Carton.value = Carton;
    		window.frame1.document.all.Comment.value = Comment;
    		window.frame1.document.all.Action.value = Ackn;
    		window.frame1.document.all.User.value = User;
    		for(var i=0; i < aItem.length;i++)
    	    {
    			if(aItem.length == 1)
    			{
    				window.frame1.document.all.Sku.value = aItem[i];
    				window.frame1.document.all.Qty.value = aQty[i];
    				window.frame1.document.all.New.value = "N";
    			}
    			else
    			{
    				window.frame1.document.all.Sku[i].value = aItem[i];
    				window.frame1.document.all.Qty[i].value = aQty[i];
    				window.frame1.document.all.New[i].value = "N";
    			}
    	    }    		
	 	}
    	else
    	{
    		window.frame1.document.all.Carton.value = Carton;
    		window.frame1.document.all.Action.value = Ackn;
    		window.frame1.document.all.User.value = User;
    		for(var i=0; i < aItem.length;i++)
    	    {
    			if(aItem.length == 1)
    			{
    				window.frame1.contentDocument.forms[0].Sku.value = aItem[i];
    				window.frame1.contentDocument.forms[0].Qty.value = aQty[i];
    				window.frame1.contentDocument.forms[0].New.value = "N";
    			}
    			else
    			{
    				window.frame1.contentDocument.forms[0].Sku[i].value = aItem[i];
    				window.frame1.contentDocument.forms[0].Qty[i].value = aQty[i];
    				window.frame1.contentDocument.forms[0].New[i].value = "N";
    			}
    	    } 
  	  	}
    } 
    
    if(isIE || isSafari) {window.frame1.document.frmSbmCtnAckn.submit(); }
    else { window.frame1.contentDocument.forms[0].submit(); }
}
//==============================================================================
//restart parent window and close this window
//==============================================================================
function returnToParent()
{
	opener.restartReport(false);
	closeWin();
}
//==============================================================================
// close window
//==============================================================================
function closeWin()
{
	window.close(); 
}
//==============================================================================
// add new sku 
//==============================================================================
function addNewSku()
{ 
	var hdr = "Add New SKU";
	  var html = "<table class='tbl02'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popNewSku()
	     + "</td></tr>"
	   + "</table>"

	  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "250";}
	  else { document.all.dvItem.style.width = "auto";}
	   
	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.left = "120px";
	  document.all.dvItem.style.top = "90px";
	  document.all.dvItem.style.visibility = "visible";
	  
	  if(User.indexOf("w7")==0){ document.all.Emp.readOnly = true; } 
}
//==============================================================================
//populate picked Item
//==============================================================================
function popNewSku()
{
	var panel = "<table class='tbl02'>";
	panel += "<tr class='trHdr01'>"
		 + "<td nowrap class='td12'>SKU/UPC:</td>"
		 + "<td nowrap class='td11'>"
		 	+ "<input class='Small' name='Sku' size=15 maxlength=13>"
		 	+ "<br><span id='spnDesc'></span>"
		 + "</td>"
	  + "</tr>";
	  
	  panel += "<tr class='trHdr01'>"
			 + "<td nowrap class='td12'>Qty:</td>"
			 + "<td nowrap class='td11'>"
			 	+ "<input class='Small' name='Qty' size=7 maxlength=5>"
			 + "</td>"
		  + "</tr>"
	
  	panel += "<tr class='trDtl04'>"
	      + "<td id='tdError' class='tdError' colspan=2></td>"
	    + "</tr>"

	panel += "<tr class='trDtl04'>"
	      + "<td nowrap class='td12' colspan=10><button onClick='vldNewSku()' class='Small'" 
	          + " id='btnPostPackId'>Submit</button>"
	         + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
		  + "</td></tr>"
	
	return panel;	  
}
//==============================================================================
// validate new sku 
//==============================================================================
function vldNewSku()
{
	var error = false;
	var msg = "";
	var br = "";
	var errfld = document.all.tdError;
	errfld.innerHTML = "";
	
	var sku = document.all.Sku.value.trim();
	if(sku==""){ error=true; msg += br + "Please enter SKU/UPC number"; br = "<br/>"  }
	else if(isNaN(sku)){ error=true; msg += br + "The SKU/UPC has not valid numeric value."; br = "<br/>"  }
	else
	{
		var sresult = getScannedItem(sku);
    	if( sresult == ""){ error=true; msg = br + "Item is not found on System."; br = "<br>"; }
    	else{ document.all.spnDesc.innerHTML = NewDesc; }
    	
    	if( isItemAlreadyOnCtn(NewSku)){ error=true; msg = br + "Item is already on Carton."; br = "<br>"; }
	}
	
	var qty = document.all.Qty.value.trim();
	if(qty=="" || eval(qty) <= 0){ error=true; msg += br + "Please enter Quantity"; br = "<br/>"  }
	else if(isNaN(qty)){ error=true; msg += br + "The Quantity has not valid numeric value."; br = "<br/>"  }
	
	if(error){ errfld.innerHTML = msg; }
	else{ sbmNewSku(sku, qty); }
}
//==============================================================================
// submit new sku
//==============================================================================
function sbmNewSku(sku, qty)
{
	if(isIE){ nwelem = window.frame1.document.createElement("div"); }
	else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
	else{ nwelem = window.frame1.contentDocument.createElement("div");}
    
    nwelem.id = "dvSbmNewSku";
  	 var html = "<form name='frmSbmNewSku'"
      + " METHOD=Post ACTION='DcCtnDtlAcknSv.jsp'>";
      
   	 html += "<input name='Carton'>"
  		+ "<input name='Comment'>"
  		+ "<input name='Action'>"
   		+ "<input name='User'>"   
   		+ "<input name='Sku'>"     
        + "<input name='Qty'>"
        + "<input name='New'>"
		;              
    
	 
	html += "</form>"
    
    nwelem.innerHTML = html;
    
    if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
    else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
    else if(isSafari){ window.frame1.document.body.appendChild(nwelem); }
    else{ window.frame1.contentDocument.body.appendChild(nwelem); }

    if(isIE || isSafari)
	{
    	window.frame1.document.all.Carton.value = Carton;
    	window.frame1.document.all.Comment.value = Comment;
    	window.frame1.document.all.Action.value = "AddNewSku";
    	window.frame1.document.all.User.value = User;
    	window.frame1.document.all.Sku.value = NewSku;
    	window.frame1.document.all.Qty.value = qty;
    	window.frame1.document.all.New.value = "Y";
    }
    else
    {
    	window.frame1.document.all.Carton.value = Carton;
    	window.frame1.document.all.Action.value = "AddNewSku";
    	window.frame1.document.all.User.value = User;
    	window.frame1.contentDocument.forms[0].Sku.value = NewSku;
    	window.frame1.contentDocument.forms[0].Qty.value = qty;
    	window.frame1.contentDocument.forms[0].New.value = "Y";
  	}
    
    if(isIE || isSafari) {window.frame1.document.frmSbmNewSku.submit(); }
    else { window.frame1.contentDocument.forms[0].submit(); }
}
//==============================================================================
//check scanned item against order
//==============================================================================
function isItemAlreadyOnCtn(newsku)
{
	var found = false;
	
	for(var i=0; i < NumOfItem; i++)
	{		
		var sku = document.getElementById("Sku" + i).innerHTML;
		var newitm  = document.getElementById("NewItm" + i).value;
		for(var j=0; j < sku; j++)
		{
			if(sku.substring(j,j+1) != "0")
			{
				sku = sku.substring(j);
				break;
			}
		}
		// compare only legitement itmes 
		if(newsku==sku && newitm != "Y"){ found = true; break; }
	}
	
	return found;
}
//==============================================================================
//check scanned item against order
//==============================================================================
function getScannedItem(item)
{
	var valid = true;
	var sku = "";
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
//Hide selection screen
//==============================================================================
function dltNewItm(sku)
{
	var hdr = "Delete New SKU";
	  var html = "<table class='tbl02'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popDltNewSku(sku)
	     + "</td></tr>"
	   + "</table>"

	  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "250";}
	  else { document.all.dvItem.style.width = "auto";}
	   
	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.left = "120px";
	  document.all.dvItem.style.top = "90px";
	  document.all.dvItem.style.visibility = "visible";
	  
	  if(User.indexOf("w7")==0){ document.all.Emp.readOnly = true; } 
}
//==============================================================================
//populate picked Item
//==============================================================================
function popDltNewSku(sku)
{
	var panel = "<table class='tbl02'>";
	panel += "<tr class='trHdr01'>"
		 + "<td nowrap class='td12'>SKU/UPC:</td>"
		 + "<td nowrap class='td11'>" + sku + "</td>"
	  + "</tr>";
	
	panel += "<tr class='trDtl04'>"
	      + "<td nowrap class='td12' colspan=10><button onClick='sbmDltNewSku(&#34;" + sku + "&#34;)' class='Small'" 
	          + " id='btnPostPackId'>Delete</button>"
	         + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
		  + "</td></tr>"
	
	return panel;	  
}
//==============================================================================
//submit new sku
//==============================================================================
function sbmDltNewSku(sku)
{
	if(isIE){ nwelem = window.frame1.document.createElement("div"); }
	else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
	else{ nwelem = window.frame1.contentDocument.createElement("div");}
 
 	nwelem.id = "dvSbmNewSku";
	var html = "<form name='frmSbmNewSku'"
   		+ " METHOD=Post ACTION='DcCtnDtlAcknSv.jsp'>";
   
	html += "<input name='Carton'>"
		+ "<input name='Comment'>"
		+ "<input name='Action'>"
		+ "<input name='User'>"   
		+ "<input name='Sku'>"     
     	+ "<input name='Qty'>"
     	+ "<input name='New'>"
	;              
 	 
	html += "</form>"
 
 	nwelem.innerHTML = html;
 
 	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
 	else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
 	else if(isSafari){ window.frame1.document.body.appendChild(nwelem); }
 	else{ window.frame1.contentDocument.body.appendChild(nwelem); }

 	if(isIE || isSafari)
	{
 		window.frame1.document.all.Carton.value = Carton;
 		window.frame1.document.all.Comment.value = Comment;
 		window.frame1.document.all.Action.value = "DltNewSku";
 		window.frame1.document.all.User.value = User;
 		window.frame1.document.all.Sku.value = sku;
 		window.frame1.document.all.Qty.value = "0";
 		window.frame1.document.all.New.value = "Y";
 	}
 	else
	{
 		window.frame1.document.all.Carton.value = Carton;
 		window.frame1.document.all.Action.value = "DltNewSku";
 		window.frame1.document.all.User.value = User;
 		window.frame1.contentDocument.forms[0].Sku.value = sku;
 		window.frame1.contentDocument.forms[0].Qty.value = "0";
 		window.frame1.contentDocument.forms[0].New.value = "Y";
	}
 
 	if(isIE || isSafari) {window.frame1.document.frmSbmNewSku.submit(); }
 	else { window.frame1.contentDocument.forms[0].submit(); }
} 
//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel()
{
	document.all.dvItem.innerHTML = " ";
	document.all.dvItem.style.visibility = "hidden";
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

</head>

<body  onload="bodyLoad();">

 <!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
 <div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

  <table class="tbl01">
    <tr class="trHdr">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Carton Detail Acknowledge: <%=sSelCtn%>
       <br>Mark 
       		 <%if(sAckn.equals("R")){%>Received<%} 
       		 else if(sAckn.equals("M")){%>Missed<%} 
       		 else if(sAckn.equals("D")){%>Damaged<%}%> 
           Items
       <br>Comments: <%=sComment%>
       </b>       
       <br>
        
     </td>
   	</tr>
   </table>
   
  <!-- Continue to build only if carton is found in history member of carton file  -->
  <%if (!bNotFound){%>
      <!-- ====================== Carton Header ============================ -->
      <table id="tblData" class="tbl02">
        <tr class="trDtl15">
          <td class="td71" nowrap>Issuing Store</td><td class="td12" nowrap><%=sIssStr%></td>
          <td class="td71">&nbsp;</td>
          <td class="td71" nowrap>Destination Store</td><td class="td12" nowrap><%=sDstStr%></td>
          <td class="td71">&nbsp;</td>
          <td class="td71" nowrap>Ship Date</td><td class="td12" nowrap><%=sShipDt%></td>
        </tr>
        <tr class="trDtl15">
          <td class="td71" nowrap>Shipping Id</td><td class="td12" nowrap><%=sShipId%></td>
          <td class="td71">&nbsp;</th>
          <td class="td71" nowrap>Shipping Tracking Id</td><td class="td12" nowrap><%=sShipTrackId%></td>
          <td class="td71">&nbsp;</th>
          <td class="td71" nowrap>&nbsp;</td><td class="td12" nowrap>&nbsp;</td>
        </tr>
        <tr class="trDtl15">
          <td class="td71" nowrap>&nbsp;</td><td class="td12" nowrap>&nbsp;</td>
          <td class="td71">&nbsp;</th>
          <td class="td71" nowrap>Pallet Number</td><td class="td12" nowrap><%=sTrans%></td>
          <td class="td71">&nbsp;</th>
          <td class="td71" nowrap>&nbsp;</td><td class="td12" nowrap>&nbsp;</td>
        </tr>
      </table>
      <p>
     
      <!-- a href="DstCtnItem.jsp?Carton=<%=sSelCtn%>" target="_blank">Additional Info</a -->
     
      <!-- ====================== Carton Items ============================ -->
      <table id="tblData" class="tbl02">
         <tr id="trHdr01" class="trHdr01">
           <th class="th02"><a href="javascript: resort('Div')">Div</a><br>#</th>           
           <th class="th02"><a href="javascript: resort('SKU')">Short SKU</a></th>
           <th class="th02"><a href="javascript: resort('Desc')">Item Description</a>              
           		<br><a class="Small" href="javascript: addNewSku()">Add New SKU</a>
           </th>
           <th class="th02"><a href="javascript: resort('UPC')">UPC</a></th>
           <th class="th02"><a href="javascript: resort('VenNm')">Vendor Name</a></th>
           <th class="th02"><a href="javascript: resort('VenSty')">Vendor<br>Style</a></th>
           <th class="th02">Color<br>Name</th>
           <th class="th02">Size<br>Name</th>
           
           <!-- th class="th02">Component<br>Qty</th -->
           <th class="th02">Current<br>Qty</th>
           <th class="th02">Ret</th>
           <th class="th02">Distro<br>#</th>
           <th class="th02">Check<br>Affected<br>Items</th>
           <th class="th02">Qty<br>Affected</th>
           <th class="th02">Error</th>
           <th class="th02">Rcv</th>
           <th class="th02">Miss</th>
           <th class="th02">Dmg</th>  
           <th class="th02">Delete</th>
         </tr>
         <%
           String sTrCls = "trDtl06"; 
           while( cartoninq.getNext())
           {
        	 int i=iNumOfItem;  
             cartoninq.setItemList();
             String sDiv = cartoninq.getDiv();
             String sDpt = cartoninq.getDpt();
             String sCls = cartoninq.getCls();
             String sVen = cartoninq.getVen();
             String sSty = cartoninq.getSty();
             String sClr = cartoninq.getClr();
             String sSiz = cartoninq.getSiz();
             String sSku = cartoninq.getSku();
             String sDesc = cartoninq.getDesc();
             String sCompQty = cartoninq.getCompQty();
             String sCurrQty = cartoninq.getCurrQty();
             String sQtyAlc = cartoninq.getQtyAlc();
             String sQtyPick = cartoninq.getQtyPick();
             String sAlcNum = cartoninq.getAlcNum();
             String sUpc = cartoninq.getUpc();
             String sVenNm = cartoninq.getVenNm();
             String sVenSty = cartoninq.getVenSty();
             String sClrNm = cartoninq.getClrNm();
             String sSizNm = cartoninq.getSizNm();
             String sRet = cartoninq.getRet();
             String sExtRet = cartoninq.getExtRet();
             
             String sRcvQty = cartoninq.getRcvQty();
             String sMissQty = cartoninq.getMissQty();
             String sDmgQty = cartoninq.getDmgQty();
             String sNewItm = cartoninq.getNewItm();
             
             if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
			 else {sTrCls = "trDtl06";}
             
             if(sNewItm.equals("Y")){sTrCls = "trDtl13";}
         %>
             <tr class="<%=sTrCls%>">
                <td class="td12" nowrap><%=sDiv%></td>
                <td class="td12" id="Sku<%=i%>"  nowrap><%=sSku%></td>
                <td class="td11" nowrap><%=sDesc%>
                	<input type="hidden" name="NewItm<%=i%>"  id="NewItm<%=i%>" value="<%=sNewItm%>" >
                </td>
                
                <td class="td12" nowrap><%=sUpc%></td>
                <td class="td11" nowrap><%=sVenNm%></td>
                <td class="td12" nowrap><%=sVenSty%></td>
                <td class="td11" nowrap><%=sClrNm%></td>
                <td class="td11" nowrap><%=sSizNm%></td>
                <td class="td12" id="CurrQty<%=i%>" name="CurrQty<%=i%>" nowrap><%=sCurrQty%></td>
                <td class="td12" nowrap><%=sRet%></td>
                <td class="td12" nowrap><%=sDocNum%></td>
                <td class="td12" nowrap><%if(!sNewItm.equals("Y") && !sAckn.equals("R")){%><input class="Small" type="checkbox" id="chkAfft<%=i%>" name="chkAfft<%=i%>" value="Y"><%}%></td>
                <td class="td12" nowrap><%if(!sNewItm.equals("Y") && !sAckn.equals("R")){%><input class="Small" id="QtyAfft<%=i%>" name="QtyAfft<%=i%>" size="5" maxlength="7" ><%}%></td>
                <td class="td12" id="Error<%=i%>" style="color:red;" nowrap></td>
                <td class="td12" nowrap><%=sRcvQty%></td>
                <td class="td12" nowrap><%=sMissQty%></td>
                <td class="td12" nowrap><%=sDmgQty%></td>
                <td class="td12" nowrap>
                	<%if(sNewItm.equals("Y")){%>
                		<a href="javascript: dltNewItm('<%=sSku%>')">Delete</a>    
                	<%}%>
                </td>
             </tr>
         <%iNumOfItem++;
           }%>
         <%
         cartoninq.setTotals();
         String sCompQty = cartoninq.getCompQty();
         String sCurrQty = cartoninq.getCurrQty();
         String sQtyAlc = cartoninq.getQtyAlc();
         String sQtyPick = cartoninq.getQtyPick();
         String sRet = cartoninq.getRet();
         String sExtRet = cartoninq.getExtRet();
         String sRcvQty = cartoninq.getRcvQty();
         String sMissQty = cartoninq.getMissQty();
         String sDmgQty = cartoninq.getDmgQty();
         %>
         <tr class="trDtl12">
         	<td class="td11" colspan=8>Totals</td>
         	<td class="td12" nowrap><%=sCurrQty%></td>         	
            <td class="td12" colspan=5 nowrap>&nbsp;</td>
            <td class="td12" nowrap><%=sRcvQty%></td>
            <td class="td12" nowrap><%=sMissQty%></td>
            <td class="td12" nowrap><%=sDmgQty%></td>
            <td class="td12" nowrap>&nbsp;</td>
                             
         </tr>
      </table>
      <script type="text/javascript">NumOfItem="<%=iNumOfItem%>";</script>
      <br>
      <br>
       
  <%} else{%>The carton is not found. Please, select correct number.<%}%>
  
  
    <p align=center>
    <%if(!sAckn.equals("R")){%>
    	<button id="btnSbm" onclick="Validate()">Submit</button> &nbsp; &nbsp;
    	<button id="btnSbm" onclick="reset()">Reset</button> &nbsp; &nbsp;
    <%}%>
    <button id="btnSbm" onclick="closeWin()">Cancel</button>
  </body>
</html>

<%
    cartoninq.disconnect();
    cartoninq = null;
  }
%>



