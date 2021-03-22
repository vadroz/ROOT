<!DOCTYPE html>	
<%@ page import="inventoryreports.PiReCntArea, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String sStore = request.getParameter("Store");
   String sPICal = request.getParameter("PICal");   
   String sTop = request.getParameter("Top");   
   String sSort = request.getParameter("Sort");
   
   if(sSort == null){ sSort = "Place"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PiReCntArea.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	
	String sPiYr = sPICal.substring(0, 4);
	String sPiMo = sPICal.substring(4);
	
	PiReCntArea piarea = new PiReCntArea();	
	piarea.setStrArea(sStore, sPiYr, sPiMo, sTop, sSort, sUser);

	int iNumOfArea = piarea.getNumOfArea();  
	
	String sSelStr = "ALL";
	String sStrAllowed = session.getAttribute("STORE").toString();
	if(!sStrAllowed.startsWith("ALL")){ sSelStr = sStrAllowed; }
	
	String sStrLst = "";
    String sStrNameLst = "";
	
    if (sSelStr.equals("ALL"))
    { 
		StoreSelect strlst = new StoreSelect(22);
    	int iNumOfStr = strlst.getNumOfStr();
    	sStrLst = strlst.getStrNum();
    	sStrNameLst = strlst.getStrName();
    }
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>PI Str Area Recount</title>

<SCRIPT>

//--------------- Global variables -----------------------
var Store = "<%=sStore%>";
var PiCal = "<%=sPICal%>";
var From = "<%=sTop%>";
var Sort = "<%=sSort%>"
var User = "<%=sUser%>";
var NumOfArea = "<%=iNumOfArea%>";

var ArrStr = [<%=sStrLst%>];
var ArrStrNm = [<%=sStrNameLst%>];

var aItems = new Array();
var MxItem = 0;

var progressIntFunc = null;
var progressTime = 0;

var MaxSku = null;
var UpdCol = null;

var NewArea = null;
var NewSku = null;
var NewUpc = null;
var NewDesc = null;
var NewAdjAdd = null;
var NewAdjRmv = null;

//--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
// set recount area
//==============================================================================
function setRecount(area, ok)
{
	var hdr = "Area:" + area;
	
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	      + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel();' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popRecount(area, ok)
	       + "</td></tr>"
	     + "</table>"

	
	//document.all.dvItem.style.width=500;
	
	var name = "#td" + area;
	var top = $(name).offset().top + 20;
	 	   
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft = document.documentElement.scrollLeft + 400;
	document.all.dvItem.style.pixelTop = top;	
	document.all.dvItem.style.visibility = "visible";
	
	document.all.Area.value = area;
	document.all.VerifyOk.checked = ok == "Y";	
}
//==============================================================================
// populate panel
//==============================================================================
function popRecount(area, ok)
{		   
   var panel = "<table class='tbl01' id='tblLog'>"
	 + "<tr>"
	  + "<td class='td08'>Verified Ok"
		  + "<input class='Small' name='VerifyOk' type='checkbox' value='Y'>"
	  + "</td>"	       
	+ "</tr>"
    + "<tr>"
      + "<td class='td08'>"
    	  + "<TextArea class='Small' name='Comment' cols=50 rows=4></TextArea>"    
          + "<input type='hidden' name='Area'>"
      + "</td>"	       
    + "</tr>";  
    
	panel += "</table> <br/>";
    panel += "<tr>"
	  + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
	   + "</tr>";
	   
    panel += "</table>"
        + "<button onClick='vldRecount();' class='Small'>Save</button>&nbsp; &nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
    ;
        
	return panel;
}
//==============================================================================
//validate new value
//==============================================================================
function vldRecount()
{
	var error = false;
  	var msg = "";
  	var br = "";
  	document.all.tdError.innerHTML="";
  	
  	var area = document.all.Area.value;
  	var comment = document.all.Comment.value.trim();
  	if(comment==""){ error=true; msg += br + "Please enter comment."; br="<br>"; }
  	
  	var ok = ""
  	if(document.all.VerifyOk.checked){ ok = "Y"; } 
  	
  	if(error){ document.all.tdError.innerHTML=msg; }
  	else{ sbmRecount(area, comment, ok); }
}
//==============================================================================
//submit store status changes
//==============================================================================
function sbmRecount(area, comment, ok)
{
	comment = comment.replace(/\n\r?/g, '<br />');
	
  	var nwelem = window.frame1.document.createElement("div");
  	nwelem.id = "dvSbmCorrSku"
  	
  	var html = "<form name='frmCorrSku'"
     + " METHOD=Post ACTION='PiReCntAreaSv.jsp'>"
     + "<input name='Str'>"
     + "<input name='PiCal'>"
     + "<input name='Area'>"     
     + "<input name='Comment'>"       
     + "<input name='Action'>"
     + "<input name='Ok'>"
     + "<input name='User'>"

  	html += "</form>"
  		
  	nwelem.innerHTML = html;
  	window.frame1.document.body.appendChild(nwelem);

  	window.frame1.document.all.Str.value = Store;
  	window.frame1.document.all.PiCal.value = PiCal;
  	window.frame1.document.all.Area.value = area;
  	window.frame1.document.all.Comment.value = comment;
  	window.frame1.document.all.Ok.value = ok;
  	window.frame1.document.all.Action.value="ADD";
  	window.frame1.document.all.User.value=User;
  
  	window.frame1.document.frmCorrSku.submit();
}

//==============================================================================
// set sku correction for selected area
//==============================================================================
function setCorrSku(area, numsku)
{
	var hdr = "Area Corrections:" + area;
	
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	      + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popCorrSku(area)
	       + "</td></tr>"
     + "</table>"
			
	var name = "#td" + area;
	var top = $(name).offset().top + 20;
	 	   
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft = document.documentElement.scrollLeft + 400;
	document.all.dvItem.style.pixelTop = top;
	document.all.dvItem.style.visibility = "visible";
	
	$(document).ready(function(){
	    $("input").focus(function(){
	    	$( this ).css( "background-color", "#ffff66" );
	    });
	});
	$(document).ready(function(){
	    $("input").blur(function(){
	    	$( this ).css( "background-color", "white" );
	    });
	});
	
	
	document.all.Area.value = area;
	document.all.Sku.focus();
	getCorrSkuExist(area);
}
//==============================================================================
// populate panel
//==============================================================================
function popCorrSku(area)
{		   
   var panel = "<table class='tbl01' id='tblCorrSku'>"
	+ "<tr>"
	    + "<th class='th02' rowspan=2>Area</th>"
	    + "<th class='th02' rowspan=2>SKU/UPC</th>"
	    + "<th class='th02' rowspan=2>UPC</th>"
	    + "<th class='th02' colspan=2>Quantity</th>"
	    + "<th class='th02' rowspan=2>Description</th>"	    
	    + "<th class='th02' rowspan=2>Vendor<br>Nme</th>"
	    + "<th class='th02' rowspan=2>Color</th>"
	    + "<th class='th02' rowspan=2>Size</th>"	   
	    + "<th class='th02' rowspan=2>Dlt</th>"
	+ "</tr>"
	+ "<tr>"    	
    	+ "<th class='th02'>Add</th>"
    	+ "<th class='th02'>Remove</th>"
	+ "</tr>"
    + "<tr>"
      + "<td class='td11' style='border:none;'>" + area + "</td>"
      + "<td class='td11' style='border:none;'>"
    	  + "<input class='Small' name='Sku' onkeydown='setOnKeyDown(this)' size=15 maxlength=12>"    
          + "<input type='hidden' name='Area'>"
      + "</td>"
      + "<td class='td11' style='border:none;'><span id='spnDesc'><span></td>"
      
      + "<td class='td11' style='border:none;'>"
	  	+ "<input class='Small' name='AddQty'  onkeydown='setOnKeyDown(this)' size=6 maxlength=5>"
  	  + "</td>"
  	  + "<td class='td11' style='border:none;'>"
  		+ "<input class='Small' name='RmvQty'  onkeydown='setOnKeyDown(this)' size=6 maxlength=5>"
	  + "</td>"
    + "</tr>";  
	    
    panel += "<tr>"
	  	+ "<td id='tdError' class='Small' colspan=6 style='color:red;font-size:12px;'></td>"
	   + "</tr>";
	panel += "<tr>"
	      + "<td id='tdButton' class='Small' style='text-align:center;' colspan=6>"
	      	//+ "<a href='javascript: vldCorrSku();' class='Small'>Save</a>&nbsp; &nbsp;"
	        + "<a href='javascript: hidePanel(); restart();' class='Small'>Close</a>&nbsp;"
	      + "</td>"	      
	  + "</tr>";   
	  
    panel += "<tbody id='tbdNewSku'></tbody>";
    panel += "<tbody id='tbdExsSku'></tbody>";
    panel += "</table>";
        
	return panel;
}
//==============================================================================
//validate sorrected sku entry 
//==============================================================================
function setOnKeyDown(obj)
{
	var key = event.keyCode

	// enter key in any field or tab key in comment  
	if(key == 13)
	{
		if(obj.name == "Sku"){ document.all.AddQty.focus(); document.all.AddQty.select();}
		else if(obj.name == "AddQty"){ document.all.RmvQty.focus(); document.all.RmvQty.select();}
		else if(obj.name == "RmvQty"){ vldCorrSku(); }
	}	
	if(key == 9)
	{
		if(obj.name == "RmvQty"){ vldCorrSku(); }
	}
}		
//==============================================================================
//validate sorrected sku entry 
//==============================================================================
function vldCorrSku()
{
	var error = false;
  	var msg = "";
  	var br = "";
  	document.all.tdError.innerHTML="";
  	
  	var area = document.all.Area.value;
  	var sku = document.all.Sku.value.trim();
  	if(sku==""){ error=true; msg += br + "Please enter SKU/UPC."; br="<br>"; }
  	else if(isNaN(sku)){ error=true; msg += br + "SKU/UPC must be numeric."; br="<br>"; }
  	else
  	{
  		progressIntFunc = setInterval(function() {showWaitBanner() }, 1000);
		var sresult = getScannedItem(sku);
	    if( sresult == "")
	    {
	    	error=true; msg = br + "Item is not found on System."; br = "<br>"; 
	    }
	    else
	    { 
	    	sku =  NewSku;
	    	document.all.Sku.value = NewSku;
	    	document.all.spnDesc.innerHTML = NewDesc;
	    }
  	}
  	
  	var addq = document.all.AddQty.value.trim();
  	if(isNaN(addq)){ error=true; msg += br + "Add Qtuantity must be numeric."; br="<br>"; }
  	else if(eval(addq) < 0){ error=true; msg += br + "Add Qtuantity cannot be negative."; br="<br>"; }
  	else if(addq == ""){ addq = "0"; }
  	
  	
  	var rmvq = document.all.RmvQty.value.trim();
  	if(isNaN(rmvq)){ error=true; msg += br + "Remove Qtuantity must be numeric."; br="<br>"; }
  	else if(eval(rmvq) < 0){ error=true; msg += br + "Remove Qtuantity cannot be negative."; br="<br>"; }
  	else if(rmvq == ""){ rmvq = "0"; }
  	
  	if(eval(rmvq) == 0 && eval(addq) == 0 ){ error=true; msg += br + "Enter 1 of the Qtuantities."; br="<br>"; }
  	else if(eval(addq) > 0 && eval(rmvq) > 0 ){ error=true; msg += br + "Enter only 1 of the Qtuantities."; br="<br>"; }
  	
  	var adjqty;
  	if(eval(addq) > 0){adjqty = addq; }
  	else { adjqty = eval(rmvq) * (-1) ; }
  	
  	NewArea = area;
  	NewAdjAdd = addq;
  	NewAdjRmv = rmvq;  	
  	
  	if(error){ document.all.tdError.innerHTML=msg; }
  	else{ sbmCorrSku(area, sku, adjqty); }
}
//==============================================================================
//submit store status changes
//==============================================================================
function sbmCorrSku(area, sku, adjqty)
{	
  	var nwelem = window.frame1.document.createElement("div");
  	nwelem.id = "dvSbmCorrSku"
  	
  	var html = "<form name='frmCorrSku'"
     + " METHOD=Post ACTION='PiReCntAreaSv.jsp'>"
     + "<input name='Str'>"
     + "<input name='PiCal'>"
     + "<input name='Area'>"     
     + "<input name='Sku'>"
     + "<input name='AdjQty'>"
     + "<input name='Action'>"
     + "<input name='User'>"
     
	html += "</form>"
		  		
  	nwelem.innerHTML = html;
  	window.frame1.document.body.appendChild(nwelem);

  	window.frame1.document.all.Str.value = Store;
  	window.frame1.document.all.PiCal.value = PiCal;
	window.frame1.document.all.Area.value = area;
 	window.frame1.document.all.Sku.value = sku;
 	window.frame1.document.all.AdjQty.value = adjqty; 
  	window.frame1.document.all.Action.value="ADDSKU";
  	window.frame1.document.all.User.value=User;
  
  	window.frame1.document.frmCorrSku.submit();
}
//==============================================================================
// get already entered sku for area corrections
//==============================================================================
function getCorrSkuExist(area)
{
	NewArea = area;
	
	var url = "PiReCntAreaCorr.jsp?"
	 + "Str=" + Store
	 + "&PiCal=" + PiCal
	 + "&Area=" + area
	
	window.frame2.document.location.href = url;
}
//==============================================================================
//set new sku in table
//==============================================================================
function setCorrSkuList(sku, addQty,rmvQty,desc, venNm, clrNm, sizNm, upc)
{
	MaxSku = sku.length;
	
	for(var i=0; i < sku.length;i++)
	{
		var tblCorrSku = document.getElementById("tblCorrSku");
		var tbody = document.getElementById("tbdExsSku"); 	
		
		var row = tbody.insertRow(-1);
    	row.className="trDtl08";
    	var name = "trExsSku" + i;
    	row.id = name;
    	var td = new Array();
    	    	    
    	td[0] = addTDElem("", "tdArea", "td11");
    	
    	td[1] = addTDElem("", "tdSku", "td18");
    	newlink = document.createElement("a");
    	newlink.setAttribute("class", "Small");
    	func = "javascript: updCorrSku('" + NewArea + "', '" + sku[i] + "', '" + name + "')";
    	newlink.setAttribute("href", func);
    	newlink.innerHTML = sku[i];
    	td[1].appendChild(newlink);    	    	
    	
    	td[2] = addTDElem(upc[i], "tdUpc", "td11");
    	td[3] = addTDElem(addQty[i], "tdAddQty", "td12");
    	td[4] = addTDElem(rmvQty[i], "tdRmvQty", "td12");
    	
    	td[5] = addTDElem(desc[i], "tdDesc", "td11");
    	td[6] = addTDElem(venNm[i], "tdVenNm", "td11");
    	td[7] = addTDElem(clrNm[i], "tdClrNm", "td11");
    	td[8] = addTDElem(sizNm[i], "tdSizNm", "td11");    	
    	
    	td[9] = addTDElem("", "tdDltSku", "td11");    	
    	newlink = document.createElement("a");
    	newlink.setAttribute("class", "Small");
    	func = "javascript: dltCorrSku('" + NewArea + "', '" + sku[i] + "', '" + name + "')";
    	newlink.setAttribute("href", func);
    	newlink.innerHTML = "Dlt";    	
    	td[9].appendChild(newlink);
    	
        
    	for(var j=0; j < td.length;j++){ row.appendChild(td[j]); }
	}
}
//==============================================================================
// set new sku in table
//==============================================================================
function setNewCorrSku(skuExists)
{
	if(!skuExists)
	{
		var tblCorrSku = document.getElementById("tblCorrSku");
		var tbody = document.getElementById("tbdNewSku"); 	
	
		var row = tbody.insertRow(-1);
    	row.className="trDtl04";
    	row.id = name;
    	var td = new Array();
    
    	td[0] = addTDElem(NewArea, "tdArea", "td11");
    	td[1] = addTDElem(NewSku, "tdSku", "td18");
    	td[2] = addTDElem(NewDesc, "tdDesc", "td11");
    	td[3] = addTDElem(NewAdjAdd, "tdAddQty", "td12");
    	td[4] = addTDElem(NewAdjRmv, "tdRmvQty", "td12");
        
    	for(var i=0; i < td.length;i++){ row.appendChild(td[i]); }
	}
	else
	{
		var tbody = document.getElementById("tbdExsSku");
		var rows = tbody.rows;
		for(var i=0; i < rows.length; i++)
		{
			var cell = rows[i].cells; 
			if(cell[1].innerHTML.indexOf(NewSku) >= 0)
			{
				cell[3].innerHTML = NewAdjAdd;
				cell[4].innerHTML = NewAdjRmv;
				break;
			}
		}
	}
	
	document.all.Sku.value = "";
	document.all.Sku.focus();
	document.all.spnDesc.innerHTML = "";
	document.all.AddQty.value = "";
	document.all.RmvQty.value = "";
	
}


//==============================================================================
//set new sku in table
//==============================================================================
function setCorrAllSkuList(sku, addQty,rmvQty,desc, venNm, clrNm, sizNm, upc, ret, area)
{
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	      + "<td class='BoxName' nowrap>All Addjustments</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popCorrAllSkuList(sku, addQty,rmvQty,desc
	    		  , venNm, clrNm, sizNm, upc, ret, area )
	       + "</td></tr>"
    + "</table>"
	 	   
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.Left = 400;
	document.all.dvItem.style.Top = 100;
	document.all.dvItem.style.visibility = "visible";	 
}
//==============================================================================
//set new sku in table
//==============================================================================
function popCorrAllSkuList(sku, addQty,rmvQty,desc, venNm, clrNm, sizNm, upc, ret, area)
{
	var panel = "<table class='tbl01' id='tblCorrAllSku'>"
		+ "<tr class='trHdr01'>"
		    + "<th class='th02' >Area</th>"
		    + "<th class='th02' >SKU/UPC</th>"
		    + "<th class='th02' >UPC</th>"
		    + "<th class='th02' >Quantity</th>"
		    + "<th class='th02' >Retail</th>"
		    + "<th class='th02' >Description</th>"	    
		    + "<th class='th02' >Vendor<br>Nme</th>"
		    + "<th class='th02' >Color</th>"
		    + "<th class='th02' >Size</th>"
		+ "</tr>"
	
	var  cls = "trDtl06";
	var svArea = area[0];
	var totqty = 0;
	var totret = 0;
	
	for(var i=0; i < sku.length; i++)
	{
	    if(svArea != area[i] && cls == "trDtl06"){ cls = "trDtl04"; }
	    else if(svArea != area[i] && cls == "trDtl04"){ cls = "trDtl06"; }
	    svArea = area[i];
	    
		panel += "<tr class='" + cls + "'>"
		   + "<td class='td11'>" + area[i] + "</td>"
		   + "<td class='td11'>" + sku[i] + "</td>"
		   + "<td class='td11'>" + upc[i] + "</td>"
		;   
	
		panel += "<td class='td12'>";
		
		if(addQty[i] != "0" ) { panel += addQty[i]; totqty += eval(addQty[i]);}
		else { panel += rmvQty[i]; totqty += eval(rmvQty[i]);}
		totret += eval( ret[i]);
		
		panel += "</td>";
		
		panel += "<td class='td12'>" + ret[i] + "</td>"
		   + "<td class='td11'>" + desc[i] + "</td>"
		   + "<td class='td11'>" + venNm[i] + "</td>"
		   + "<td class='td11'>" + clrNm[i] + "</td>"
		   + "<td class='td11'>" + sizNm[i] + "</td>"
		 + "</tr>"
		 ;
	}
	
	panel += "<tr class='trDtl15'>"
	   	+ "<td class='td11'>Total</td>"
	   	+ "<td class='td11' colspan=2>&nbsp;</td>"
	   	+ "<td class='td12'>" + totqty + "</td>"
	   	+ "<td class='td12'>" + totret + "</td>"
	   	+ "<td class='td11' colspan=4>&nbsp;</td>"
	   + "</tr>"
		
  panel += "</table>";
	
  return panel;
}


//==============================================================================
//add new TD element
//==============================================================================
function addTDElem(value, id, classnm)
{
	var td = document.createElement("TD") // Reason
	td.appendChild (document.createTextNode(value))
	td.className=classnm;
	td.id = id;
	return td;
}
//==============================================================================
// update exists sku
//==============================================================================
function updCorrSku(area, sku, row)
{
	document.all[row].style.backgroundColor = "#dddfff";
	
  	var cell = document.all[row].cells;
  	document.all.Area.value = area;
  	document.all.Sku.value = sku;  	
  	document.all.spnDesc.innerHTML = cell[2].innerHTML;
  	document.all.AddQty.value = cell[3].innerHTML;
  	document.all.RmvQty.value = cell[4].innerHTML;
  	
}
//==============================================================================
//delete sku from list of corrections
//==============================================================================
function dltCorrSku(area, sku, row)
{
	document.all[row].style.backgroundColor = "black";
	document.all[row].style.color = "white";
	
	var url = "PiReCntAreaSv.jsp?"
	   + "Str=" + Store
	   + "&PiCal=" + PiCal
	   + "&Area=" + area
	   + "&Sku=" + sku
	   + "&Action=DLTSKU"
		
	window.frame2.document.location.href = url;
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
    		
    		clearInterval( progressIntFunc );
    		document.all.dvWait.style.visibility = "hidden";
 		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return sku.trim();
}
//==============================================================================
//reload page
//==============================================================================
function restart()
{
	window.location.reload();  
}
//==============================================================================
// re-sort page
//==============================================================================
function resort(sort)
{		
	var url="PiReCntArea.jsp?Store=<%=sStore%>&PICal=<%=sPICal%>&Top=<%=sTop%>&Sort=" + sort;
	window.location.href = url;
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
// submit next page or set to new beginning or/and page size
//==============================================================================
function sbmNewSet(reset)
{
	var url ="PiReCntArea.jsp?Store=" + Store + "&PICal=" + PiCal;
			
	if(!reset)
	{
		var from = eval(From) + eval(Size);
		url += "&From=" + from + "&Size=" + Size;
	}
	else 
	{
		var from = document.all.From.value;
		var size = document.all.Size.value;
		url += "&From=" + from + "&Size=" + size;
	}
	
	window.location.href = url;
}
//==============================================================================
//set - applied filter
//==============================================================================
function setFilter(sel)
{	
	for(var i=0; i < NumOfArea; i++)
	{
		var fldnm = "trArea" + i 
		var row = document.all[fldnm];
		var fldnm = "spnCorr" + i 
		var corr = document.all[fldnm].innerHTML;
		var fldnm = "tdCommt" + i 
		var comm = document.all[fldnm].innerHTML;
		
		var bshow = [ false,false,false,false ];
		
		if(sel.value==0 && corr == "true"){ bshow[0] = true; }
		if(sel.value==1 && comm != ""){ bshow[1] = true; }
		if(sel.value==2 && (comm != "" || corr == "true")){ bshow[2] = true; }
		if(sel.value==3 ){ bshow[3] = true; }
		
		var disp = "table-row";
		if(bshow[0] || bshow[1] || bshow[2] || bshow[3]){ disp = "table-row"; }
		else{ disp = "none";}
		row.style.display = disp;
	}
	sel.checked = false;
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

<!-------------------------------------------------------------------->
<div  id="dvHelp" style="border: gray 1px ridge;background-color: cornsilk; position:absolute; 
          left:10; top:50;  width:auto; z-index:100;">
          <table class="tbl02" id="tblTags">
            <tr class="trDtl12">
              <td class="td11"><b>
                1) Click the Area link, then Print and recount the Area by SKU/UPC.<br>
                2) Add Area Corrections - by SKU/UPC for any count errors found.<br>
                3) Add a Comment, if no errors were found.
                </b>
              </td>
          	</tr>
          	          	
          </table>
 </div>
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
            <br>Store (5%) Recount Area:
            <br>All Areas are ranked by the highest potential for shrink/swell.             
            <br>Store: <%=sStore%>              
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="PiReCntAreaSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;
              <a href="javascript: getCorrSkuExist('ALL')">All Adjustments</a>
          </th>
       </tr>      
       <tr class="trHdr">
       	  <th colspan=45 style="text-align:left;" >
             <br>
             <span style="font-size:12px; text-align:left;">
             	All Areas having "Zero" potential for Shrink/Swell are excluded from this list.
             
             &nbsp; &nbsp; &nbsp;
             
             <input type="checkbox" name="InpFilter" value="0" onclick="setFilter(this)"> Corrections Only
             &nbsp; &nbsp; &nbsp;
             <input type="checkbox" name="InpFilter" value="1" onclick="setFilter(this)"> Comments Only
             &nbsp; &nbsp; &nbsp;
             <input type="checkbox" name="InpFilter" value="2" onclick="setFilter(this)"> Corrections/Comments
             &nbsp; &nbsp; &nbsp;
             <input type="checkbox" name="InpFilter" value="3" onclick="setFilter(this)"> All
             </span>                                        
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02" rowspan=2><a href="javascript: resort('Place')">Rank</a></th>
          <th class="th02" rowspan=2 ><a href="javascript: resort('Area')">Area</a></th>
          <th class="th02" rowspan=2 >Div</th>
          <th class="th02" rowspan=2 ># of Items<br>Count</th>
          <th class="th02" rowspan=2 >Total<br>Units</th>
          <th class="th02" rowspan=2 >Potential<br>Mis-Counts<br>In this Area</th>
          <th class="th02" rowspan=2 >Potential<br>Retail<br>Shrink/Swell</th>
          <!-- th class="th02" >Potential Unit<br>Shrink/Swell</th -->
          <th class="th02" colspan=4>Sku Area<br>Corrections<br>Add</th>
          <th class="th02" rowspan=2 >Recounted By</th>
          <th class="th02" rowspan=2 >Recounted<br>Date/Time</th>          
          <th class="th02" rowspan=2 >Add/Change<br>Comment</th> 
          <th class="th02" rowspan=2 >Verified<br>Ok</th>         
          <th class="th02" rowspan=2 >Comment</th>        
          <th class="th02" rowspan=2 >SACA-001E<br>Recount<br>Entry</th>
          <th class="th02" rowspan=2 >SACA-001E<br>WIS<br>Count</th>
          <th class="th02" rowspan=2 >SACA-001E<br>S&S<br>Count</th>
          <th class="th02" rowspan=2 nowrap >Corrections Posted<br>By User/Date/Time</th>   
        </tr>
        
        <tr class="trHdr01">
          <th class="th02" >Add</th>
          <th class="th02" ># of SKUs</th>           
          <th class="th02" >Total<br>Qty</th>
          <th class="th02" >Total<br>Ret</th>
        </tr>
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfArea; i++) {        	   
        	   piarea.setDetail();
   			   String sArea = piarea.getArea();
   			   String sQty = piarea.getQty();
   			   String sRet = piarea.getRet();
   			   String sCost = piarea.getCost();
   			   String sAdjQty = piarea.getAdjQty();
   			   String sAdjRet = piarea.getAdjRet();			
   			   String sAdjCst = piarea.getAdjCst();
   			   String sNumItm = piarea.getNumItm();
   		       String sQtyScr = piarea.getQtyScr();
   			   String sRetScr = piarea.getRetScr();
   			   String sItmScr = piarea.getItmScr();
   			   String sTotScr = piarea.getTotScr();
   			   String sPlace = piarea.getPlace();
   			   String sCntBy = piarea.getCntBy();
   			   String sCntDt = piarea.getCntDt();
   			   String sCntTm = piarea.getCntTm();
   			   String sCommt = piarea.getCommt();
   			   String sDivLst = piarea.getDivLst();
			   String sTotNumItm = piarea.getTotNumItm();
			   String sTotQty = piarea.getTotQty();
			   String sTotAdjQty = piarea.getTotAdjQty();
			   String sTotAdjRet = piarea.getTotAdjRet();
			   String sTotAdjCost = piarea.getTotAdjCost();
			   String sAreaEntUser = piarea.getAreaEntUser();
			   String sAreaEntWisCnt = piarea.getAreaEntWisCnt();
			   String sAreaEntRciCnt = piarea.getAreaEntRciCnt();
			   String sAreaEntRciCntSku = piarea.getAreaEntRciCntSku();
			   String sAreaCorrNumSku = piarea.getAreaCorrNumSku();
			   String sVerifyOk = piarea.getVerifyOk();
			   String sPost = piarea.getPost();
			   String sPostUs = piarea.getPostUs();
			   String sPostDt = piarea.getPostDt();
			   String sPostTm = piarea.getPostTm();
			   String sCorrQty = piarea.getCorrQty();
			   String sCorrRet = piarea.getCorrRet();
			   
			   System.out.println(sPlace + "  sAreaEntUser=" + sAreaEntUser + " " + sAreaEntRciCntSku);
			   if(!sAreaEntUser.trim().equals("") && sAreaEntRciCntSku.equals("Y")){sTrCls = "trDtl15";}
			   else if(!sAreaEntUser.trim().equals("") && (!sAreaEntWisCnt.equals(sTotQty) || !sAreaEntRciCnt.equals(sTotQty))){sTrCls = "trDtl13";}			   
			   else {sTrCls = "trDtl06";} 
           %>                           
                <tr id="trArea<%=i%>" class="<%=sTrCls%>">
                <td class="td12" nowrap><%=sPlace%></td>
                <td class="td12" nowrap><a href="PIWIRep.jsp?STORE=<%=sStore%>&AREA=<%=sArea%>&PICal=<%=sPICal%>&SUBMIT=Submit" target="_blank"><%=sArea%></a></td>
                <td class="td11" nowrap><%=sDivLst%></td>
                <td class="td12" nowrap><%=sTotNumItm%></td>
                <td class="td12" nowrap><%=sTotQty%></td>                
                <td class="td12" nowrap><%=sNumItm%></td>                
                <td class="td12" nowrap>$<%=sAdjRet%></td>                     
                <!-- td class="td12" nowrap><%=sTotAdjQty%></td -->                
                <td class="td18" id="tdCorr<%=sArea%>" nowrap>
                    <a href="javascript: setCorrSku('<%=sArea%>','<%=sAreaCorrNumSku%>')" >
                       <%if(sAreaCorrNumSku.equals("0")){%>Add<%} else {%>Upd<%}%>
                    </a>
                </td>
                <td class="td12" nowrap><%if(!sAreaCorrNumSku.equals("0")){%><%=sAreaCorrNumSku%><%}%></td>                                
                <td class="td12" id="tdCorrQty<%=i%>" nowrap><%if(!sCorrQty.equals("0")){%><%=sCorrQty%><%}%>
                    <span id="spnCorr<%=i%>" style="display:none"><%=!sAreaCorrNumSku.equals("0")%></span>
                </td>                
                <td class="td12" id="tdCorrRet<%=i%>" nowrap><%if(!sCorrRet.equals(".00")){%>$<%=sCorrRet%><%}%></td>
                
                <td class="td11" nowrap><%=sCntBy%></td>
                <td class="td11" nowrap><%if(!sCntDt.equals("01/01/0001")){%><%=sCntDt%>&nbsp;&nbsp;<%=sCntTm%><%}%></td>
                <td class="td18" id="td<%=sArea%>" nowrap><a href="javascript: setRecount('<%=sArea%>','<%=sVerifyOk%>')" >Add</a></td>
                <td class="td18"><%=sVerifyOk%></td>
                <td class="td11" id="tdCommt<%=i%>"><%=sCommt%></td>
                <td class="td11" nowrap><%=sAreaEntUser%></td>
                <td class="td11" nowrap><%=sAreaEntWisCnt%></td>
                <td class="td11" nowrap><%=sAreaEntRciCnt%></td>
                <td class="td11" nowrap>
          		    <%if(sPost.equals("Y")){%>
          			    <%=sPostUs%> &nbsp; <%=sPostDt%> &nbsp; <%=sPostTm%>
          			<%}%>
          		</td>
              </tr>
              <script></script>	
           <%}%>
           
           <!-- ==============Total Line  -->
           <%
           	piarea.setTotals();
   			String sCorrQty = piarea.getCorrQty();
   			String sCorrRet = piarea.getCorrRet();
           %> 
           <tr id="trTotal" class="trDtl04">
                <td class="td18" colspan=2>Total</td>
                <td class="td12" colspan=7></td>
           		<td class="td12"><%=sCorrQty%></td>
           		<td class="td12">$<%=sCorrRet%></td>
           		<td class="td12" colspan=9></td>
           </tr>
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
   <p style="text-align:left;">
   Notes:
   <br><span style="background: pink">Pink Lines</span>: Indicate total quantity mismatch between SACA entry during your PI Count, and the total QTY we received from WIS for this Area Count.
  <br><span style="background: LemonChiffon">Yellow Lines</span>:  Indicate SACA areas that were indicated as "recounted" on the night of your PI Count.
 </body>
</html>
<%
piarea.disconnect();
piarea = null;
}
%>