<!DOCTYPE html>	
<%@ page import="inventoryreports.PiAreaEnt, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String sStore = request.getParameter("Store");
   String sPICal = request.getParameter("PICal");   
   String sSort = request.getParameter("Sort");
   
   if(sSort == null){ sSort = "AREA"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PiAreaEnt.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	/*(sStr, sPiYr, sPiMo, sFrom, sSize, sSort, sUser )*/
	String sPiYr = sPICal.substring(0, 4);
	String sPiMo = sPICal.substring(4);
	PiAreaEnt piarea = new PiAreaEnt();
	System.out.println(sPiYr + " " + sPiMo);
	piarea.setStrArea(sStore, sPiYr, sPiMo, sSort, sUser);

	int iNumOfArea = piarea.getNumOfArea(); 
	int iNumOfTag = piarea.getNumOfTag();
	
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

<title>PI Area Count</title>

<script src="https://code.jquery.com/jquery-1.10.2.js"></script>


<SCRIPT>

//--------------- Global variables -----------------------
var Store = "<%=sStore%>";
var PiCal = "<%=sPICal%>";
var Sort = "<%=sSort%>"
var User = "<%=sUser%>";
var NumOfArea = "<%=iNumOfArea%>";
var NumOfTag = "<%=iNumOfTag%>";

var ArrStr = [<%=sStrLst%>];
var ArrStrNm = [<%=sStrNameLst%>];

var aItems = new Array();
var MxItem = 0;

var progressIntFunc = null;
var progressTime = 0;

var CurrAreas = 0;
var ValidLine = false; 
var EntAllow = false;
var NumOfSkuCnt = "0";
 
//--------------- End of Global variables ----------------

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


//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   if(NumOfTag == 0)
   {
	   document.all.tdTagErr.innerHTML = "Please enter Number Of Tags";
   }
   else
   { 
	   setEntrTag();	   
   }
  
   
   var tt = $("#dvLink").offset().top + $("#dvLink").outerHeight();
   document.all.dvRecount.style.pixelTop = tt + 25;
   var tt = $("#dvLink").offset().top + $("#dvLink").outerHeight()
      + $("#dvRecount").outerHeight();
   document.all.dvHelp.style.pixelTop = tt + 50;
   
}
//==============================================================================
// calculate recount tag percentage  
//==============================================================================
function setEntrTag()
{	
	/*for(var i=0; i < NumOfArea;i++)
	{
		name = "lnkArea" + i;
		var carea = document.all[name];
		//if(carea.innerHTML > 221){ CurrAreas++; }
	}
	*/
	CurrAreas = NumOfArea;
	document.all.Tags.value = NumOfTag;
	document.all.tdEntPrc.innerHTML = (CurrAreas / (NumOfTag - 221) * 100).toFixed(1) + "%"; 
	var need = ((NumOfTag - 221) * 0.25).toFixed(0);
	document.all.tdEntNeed.innerHTML = need;
	document.all.spnEntArea.innerHTML = CurrAreas;
	
	document.all.spnEntSkuArea.innerHTML = NumOfSkuCnt;
	document.all.tdEntSkuPrc.innerHTML = (NumOfSkuCnt / CurrAreas * 100).toFixed(1) + "%";	 
	
	setEntAreaPrc();
}

//==============================================================================
// set white color on background of all input field 
//=============================================================================	
function setBackClr()
{
   for(var i=0; i < NumOfArea ;i++)
   {
	    name = "WisCnt" + i;
		var wcnt = document.all[name];
		wcnt.style.background="white";
		name = "RciCnt" + i;
		var rcnt = document.all[name];
		rcnt.style.background="white";
		name = "RecUsr" + i;
		var recusr = document.all[name];
		recusr.style.background="white";
		//name = "ReCount" + i;
		//var recnt = document.all[name];
		//recnt.style.background="white";
		name = "Commt" + i;
		var commt = document.all[name];
		commt.style.background="white";
   }	
}
//==============================================================================
//check which Key Down pressed 
//==============================================================================
function chkKeyDown(grp, event)
{
	var name = grp;
	var obj = document.all[name];
	
	var wcnt = document.all.WisCnt;
	var rcnt = document.all.RciCnt;
	var recusr = document.all.RecUsr;
	var recnt = document.all.ReCount;
	var rcntsku = document.all.RcntBySku;
	var commt = document.all.Commt;
	
	var key = event.keyCode
		
	// enter key in any field or tab key in comment  
	if(key == 13 && EntAllow)
	{	
		vldLine(grp);
		if(ValidLine)
		{ 
			// jump to next field in line
			if(grp == "Area") { wcnt.focus();	wcnt.select(); }
			else if(grp == "WisCnt") { rcnt.focus();	rcnt.select(); } 
			else if(grp == "RciCnt"){ recusr.focus(); recusr.select(); }
			else if(grp == "RecUsr"){ recnt.focus(); }
			else if(grp == "ReCount"){ rcntsku.focus();	rcntsku.select();	}
			else if(grp == "RcntBySku"){ commt.focus();	commt.select();	}
			else if(grp == "RcntBySku"){ rcntsku.focus();	rcntsku.select();	}
		}			
	}
	
	if(key == 9 && EntAllow)
	{		
		vldLine(grp);
		if(ValidLine)
		{ 			
		}			
	}
}
//==============================================================================
// validate Line or single fiedls
//==============================================================================
function vldLine(grp)
{
	var error = false;
	var msg = "";
	var br = "";
	var name = "tdError";
	var errfld = document.all[name];
	ValidLine = false;
	
	var area = document.all.Area;
	var wcnt = document.all.WisCnt;
	var rcnt = document.all.RciCnt;
	var recusr = document.all.RecUsr;
	var recnt = document.all.ReCount;
	var commt = document.all.Commt;
	
	var rcntsku = document.all.RcntBySku;
	
	var diff = document.all.tdDiff;
	
	if(wcnt.value.trim() == ""){ wcnt.value = "0"; }
	if(rcnt.value.trim() == ""){ rcnt.value = "0"; } 
	
	errfld.innerHTML = "";
	
	if(isNaN(area.value.trim())){ error = true; msg += br + "Area Number is not numeric"; br = "<br>";}
	else if(area.value.trim()=="" || eval(area.value.trim()) < 1){ error = true; msg += br + "Area Number Count cannot be blank or 0"; br = "<br>";}
	else if(eval(area.value.trim()) >2000){ error = true; msg += br + "Area Number cannot exceed 2000"; br = "<br>";}
	
	if(isNaN(wcnt.value.trim())){ error = true; msg += br + "WIS Count is not numeric"; br = "<br>";}
	else if(eval(wcnt.value.trim()) < 0){ error = true; msg += br + "WIS Count is not positive"; br = "<br>";}
	
	if(isNaN(rcnt.value.trim())){ error = true; msg += br + "RCI Count is not numeric"; br = "<br>";}
	else if(eval(rcnt.value.trim()) < 0){ error = true; msg += br + "RCI Count is not positive"; br = "<br>";}
	else
	{ 
		try {
			diffcount = eval(wcnt.value) - eval(rcnt.value);
			diff.innerHTML = eval(wcnt.value) - eval(rcnt.value);	
			if(diffcount != 0){diff.style.background = "#F75D59";}
			else {diff.style.background = "lightgreen";}
		}
		catch(err) { diff.innerHTML = ""; }
	}	
		
	var recntval = "N";	
	if( recnt.checked ){recntval = "Y";}
	
	var rcntskuval = "N";	
	if( rcntsku.checked ){rcntskuval = "Y";}
	
	if(error){errfld.innerHTML = msg;}
	else if( grp == "Commt" ) 
	{
		ValidLine = true;
		sbmArea("ADD", area.value, wcnt.value, rcnt.value, recntval, recusr.value, commt.value.trim().replace(/[^a-zA-Z ]/g, ""), rcntskuval); 
	}
	else{ ValidLine = true; }	
}


//==============================================================================
//hide panel
//==============================================================================
function hidePanel()
{
	document.all.dvItem.innerHTML = "";
	document.all.dvItem.style.visibility = "hidden";
	clearInterval( progressIntFunc );
	document.all.dvWait.style.visibility = "hidden";
}

//==============================================================================
// show Add area panel
//==============================================================================
function showAddPanel(line, action)
{	   
   EntAllow = true;
   
   var rt = $("#dvRecount").offset().left + $("#dvRecount").outerWidth();
      
   document.all.dvSelect.style.visibility = 'visible';   
   var width = document.all.dvSelect.clientWidth / 2 - 50
   //document.all.dvSelect.style.pixelLeft = document.documentElement.clientWidth / 2 - width;
   document.all.dvSelect.style.pixelLeft = rt + 25;
   document.all.Area.focus();
   
   var area = document.all.Area;
   var wcnt = document.all.WisCnt;
   var rcnt = document.all.RciCnt;
   var recnt = document.all.ReCount;
   var recusr = document.all.RecUsr;
   var commt = document.all.Commt;
   var rcntsku = document.all.RcntBySku;
   
   if(line >= 0)
   {
	   
	   
	   name = "trArea" + line;
	   var row = document.all[name];
			
	  name = "lnkArea" + line;
	  var carea = document.all[name];
	  name = "tdWisCnt" + line;
	  var cwcnt = document.all[name];	
	  name = "tdRciCnt" + line;
	  var crcnt = document.all[name];
	  name = "tdDiff" + line;
	  var ccommt = document.all[name];
	  name = "tdRecUsr" + line;
	  var crecusr = document.all[name];
	  name = "tdReCount" + line;	  
	  var crecnt = document.all[name];	  
	  name = "tdReBySku" + line;	  
	  var crcntsku = document.all[name];	  
	  name = "tdCommt" + line;
	  var ccommt = document.all[name];
			
	  row.style.background = "yellow";
	  area.value = carea.innerHTML;
	  wcnt.value = cwcnt.innerHTML;
	  rcnt.value = crcnt.innerHTML;	  
	  recusr.value = crecusr.innerHTML;
	  recnt.checked = false;
	  if(crecnt.innerHTML == "Y"){ recnt.checked = true; }
	  
	  rcntsku.checked = false;	  
	  if(crcntsku.innerHTML == "Y"){ rcntsku.checked = true; }
	  
	  commt.value = ccommt.innerHTML;
   }
   else
   {
	   area.value = "";
	   wcnt.value = "0";
	   rcnt.value = "0";
	   recusr.value = "";
	   recnt.checked = false;
	   commt.value = "";
	   rcntsku.checked = false;
   }
}
//==============================================================================
//hide panel
//==============================================================================
function dltPanel(line)
{
	hidePanel1();
	
	name = "trArea" + line;
	var row = document.all[name];
			
	name = "lnkArea" + line;
	var carea = document.all[name];
	name = "tdWisCnt" + line;
	var cwcnt = document.all[name];	
	name = "tdRciCnt" + line;
	var crcnt = document.all[name];
	name = "tdDiff" + line;
	var ccommt = document.all[name];
	name = "tdRecUsr" + line;
	var crecusr = document.all[name];
	name = "tdReCount" + line;
	var crecnt = document.all[name];
	name = "tdCommt" + line;
	var ccommt = document.all[name];
	name = "tdReBySku" + line;
	var crcntsku = document.all[name];
			
	row.style.background = "black";
	row.style.color = "white";
	
	var hdr = "Delete Area: " + carea.innerHTML;
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popDltAreaPanel(line, carea.innerHTML
	    		, cwcnt.innerHTML, crcnt.innerHTML, crecusr.innerHTML, crecnt.innerHTML, ccommt.innerHTML, crcntsku.innerHTML)
	     + "</td></tr>"
	   + "</table>"
	   
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft = document.documentElement.scrollLeft + 300;
	document.all.dvItem.style.pixelTop = document.documentElement.scrollTop + 200;
	document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate delete area panel
//==============================================================================
function popDltAreaPanel(line, carea, cwcnt, crcnt, crecusr, crecnt, ccommt, crcntsku)
{
    var panel = "<h3>Do you want to DELETE area " + carea + "?</h3>";
	
	panel += "<table class='tbl02'>"
	    + "<tr class='trDtl09'>"
		   + "<th class='th06'>Area: </th><td class='td11'>" + carea + "</th>"
		+ "</tr>"
		+ "<tr class='trDtl09'>"
		   + "<th class='th06'>WIS Count: </th><td class='td11'>" + cwcnt + "</th>"
		+ "</tr>"
		+ "<tr class='trDtl09'>"
		   + "<th class='th06'>RCI Count: </th><td class='td11'>" + crcnt + "</th>"
		+ "</tr>"
		+ "<tr class='trDtl09'>"
		   + "<th class='th06'>RCI Team Member: </th><td class='td11'>" + crecusr + "</th>"
		+ "</tr>"
		+ "<tr class='trDtl09'>"
		   + "<th class='th06'>Recounted?: </th><td class='td11'>" + crecnt + "</th>"
		+ "<tr class='trDtl09'>"
		   + "<th class='th06'>Recounted by SKU?: </th><td class='td11'>" + crcntsku + "</th>"
		+ "</tr>"
		+ "<tr class='trDtl09'>"
		   + "<th class='th06'>Comment: </th><td class='td11'>" + ccommt + "</th>"
		+ "</tr>"
		
		panel += "<tr class='trDtl09'>"
	    	+ "<td nowrap class='td09' colspan=2><button onClick='sbmArea(&#34;DLT&#34;"
	    	  + ",&#34;" + carea + "&#34;"
	    	  + ",&#34;" + cwcnt + "&#34;"
	    	  + ",&#34;" + crcnt + "&#34;"
	    	  + ",&#34;" + crecnt + "&#34;"	    	  
	    	  + ",&#34;" + crecusr + "&#34;"
	    	  + ",&#34;" + ccommt + "&#34;"
	    	  + ",&#34;" + crcntsku + "&#34;"
	    	+ ")'class='Small'>Submit</button>"
	    	+ " &nbsp; <button onClick='hidePanel();' class='Small'>Cancel</button>"
	 	 + "</td></tr></table>"
	 	 
	return panel;	
}

//==============================================================================
//submit area entries
//==============================================================================
function sbmArea(action, carea, cwcnt, crcnt, crecnt, crecusr, ccommt, crcntsku)
{
	EntAllow = false;
	progressIntFunc = setInterval(function() {showWaitBanner() }, 1000);
	
	var url = "PiAreaEntSv.jsp";
	
	var param = "str=" + Store
	 + "&area=" + carea
	 + "&piyr=" + PiCal.substring(0, 4)
	 + "&pimo=" + PiCal.substring(4)
	 + "&wis=" + cwcnt
	 + "&rci=" + crcnt	 
	 + "&recusr=" + crecusr
	 + "&recnt=" + crecnt
	 + "&rcntsku=" + crcntsku
	 + "&commt=" + ccommt
	 + "&action=" + action
	 + "&user=" + User
	 ;	 

	var xmlhttp;
	// code for IE7+, Firefox, Chrome, Opera, Safari
	if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
	// code for IE6, IE5
	else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{			
			if(action!="DLT"){ setUpdVal(); }		
			
			document.all.Area.value = "";
			document.all.WisCnt.value = "";
			document.all.RciCnt.value = "";
			document.all.RecUsr.value = "";
			document.all.ReCount.checked = false;
			document.all.RcntBySku.checked = false;
			document.all.Commt.value = "";
			
			var diff = document.all.tdDiff;
			diff.innerHTML ="";
			diff.style.background ="#e7e7e7";
			
			document.all.Area.focus();	
			
			clearInterval( progressIntFunc );
    		document.all.dvWait.style.visibility = "hidden";
    		
    		if(action!="DLT"){ EntAllow = true; }
    		
    		if(action=="DLT"){ hidePanel(); }
 		}
	}
	xmlhttp.open("POST",url,true); // synchronize with this apps

	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlhttp.setRequestHeader("Content-length", param.length);
	xmlhttp.setRequestHeader("Connection", "close");
	
	xmlhttp.send(param);
}
//==============================================================================
//set updated values
//==============================================================================
function setUpdVal()
{
	var area = document.all.Area;
	var wcnt = document.all.WisCnt;
	var rcnt = document.all.RciCnt;
	var recnt = document.all.ReCount;
	var recusr = document.all.RecUsr;
	var commt = document.all.Commt;
	var rcntsku = document.all.RcntBySku;
	
	var found = false; 
		
	for(var i=0; i < NumOfArea;i++ )
 	{
		name = "trArea" + i;
		var row = document.all[name];
		
		name = "lnkArea" + i;
		var carea = document.all[name];		
		name = "tdWisCnt" + i;
		var cwcnt = document.all[name];	
		name = "tdRciCnt" + i;
		var crcnt = document.all[name];
		name = "tdDiff" + i;
		var ccommt = document.all[name];
		name = "tdRecUsr" + i;
		var crecusr = document.all[name];
		name = "tdReCount" + i;
		var crecnt = document.all[name];
		name = "tdCommt" + i;
		var ccommt = document.all[name];
		name = "tdReBySku" + i;
		var crcntsku = document.all[name];
		
		if(carea.innerHTML == area.value.trim())
		{
			row.style.background = "cornsilk";
			cwcnt.innerHTML = wcnt.value.trim();
			crcnt.innerHTML = rcnt.value.trim();
			crecusr.innerHTML = recusr.value.trim();
			ccommt.innerHTML = commt.value.trim();
			if(recnt.checked){crecnt.innerHTML = "Y"}
			else{crecnt.innerHTML = "N"}
			if(rcntsku.checked){crcntsku.innerHTML = "Y"}
			else{crcntsku.innerHTML = "N"}
			
			found = true;
			break;
		}
  	}
	
	if(!found)
	{		 
		var name = "trArea" + NumOfArea;
		
		var tblArea = document.getElementById("tblEnt");
		var tbody = tblArea.tBodies[0];	
		
		var row = tbody.insertRow(-1);
	    row.className="trDtl07";
	    row.id = name;
	    var td = new Array();
	    
	    td[0] = addTDElem(area.value, "tdArea" + NumOfArea, "td11");
	    td[1] = addTDElem(wcnt.value, "tdWisCnt" + NumOfArea, "td12");
	    td[2] = addTDElem(rcnt.value, "tdRciCnt" + NumOfArea, "td12");
	    
	    var diff = eval(wcnt.value) - eval(rcnt.value);
	    td[3] = addTDElem(diff, "tdDiff" + NumOfArea, "td12");	    
	    if(diff == "0"){ td[3].style.background = "lightgreen"; }
	    else if(diff != "0" && eval(wcnt.value) != "0"){ td[3].style.background = "#F75D59"; }
	    
	    td[4] = addTDElem(recusr.value, "tdRecUsr" + NumOfArea, "td12");
	    
	    var recntval = "N";
	    if(recnt.checked){recntval = "Y"}	    
	    td[5] = addTDElem(recntval, "tdReCount" + NumOfArea, "td34");
	    
	    var rcntskuval = "N";
	    if(rcntsku.checked){rcntskuval = "Y"}	    
	    td[6] = addTDElem(rcntskuval, "tdReBySku" + NumOfArea, "td34");
	    
	    td[7] = addTDElem(commt.value, "tdCommt" + NumOfArea, "td11");
	    
	    td[8] = addTDElem("", "tdDlt" + NumOfArea, "td11");
	    
	    for(var i=0; i < td.length;i++){ row.appendChild(td[i]); }	  
	    CurrAreas++;
	    document.all.tdEntPrc.innerHTML = (CurrAreas / (NumOfTag - 221) * 100).toFixed(1) + "%";
	    document.all.spnEntArea.innerHTML = CurrAreas;
	    document.all.spnEntSkuArea.innerHTML = NumOfSkuCnt;
		document.all.tdEntSkuPrc.innerHTML = (NumOfSkuCnt / CurrAreas * 100).toFixed(1) + "%";
	}
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
//hide panel
//==============================================================================
function hidePanel1()
{
	document.all.dvSelect.style.visibility = "hidden";	
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
	var url="PiAreaEnt.jsp?Store=<%=sStore%>&PICal=<%=sPICal%>"
	   + "&Sort=" +sort	
	   window.location.href = url;
}
//==============================================================================
//validate numberof tags
//==============================================================================
function vldNumTags()
{
	var error = false;
	var msg = "";
	var br = "";
	var errfld = document.all.tdTagErr;
	
	var tags = document.all.Tags;
	
	errfld.innerHTML = "";
	
	if(isNaN(tags.value.trim())){ error = true; msg += br + "Number of Tags is not numeric"; br = "<br>";}
	else if(tags.value.trim()=="" || eval(tags.value.trim()) < 222){ error = true; msg += br + "Number of Tags cannot be blank less than 221"; br = "<br>";}
	 	
	if(error){errfld.innerHTML = msg;}
	else 
	{ 
		sbmTags(tags.value); 
	}	 
}
//==============================================================================
//submit area entries
//==============================================================================
function sbmTags(tags)
{
	progressIntFunc = setInterval(function() {showWaitBanner() }, 1000);
	NumOfTag = tags; 
	
	var url = "PiAreaEntSv.jsp";
	
	var param = "str=" + Store
	 + "&piyr=" + PiCal.substring(0, 4)
	 + "&pimo=" + PiCal.substring(4)
	 + "&tags=" + tags
	 + "&action=SAVTAG" 
	 ;	 

	var xmlhttp;
	// code for IE7+, Firefox, Chrome, Opera, Safari
	if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
	// code for IE6, IE5
	else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{	
			document.all.tdEntPrc.innerHTML = (CurrAreas / (NumOfTag - 221) * 100).toFixed(1) + "%";
			document.all.spnEntArea.innerHTML = CurrAreas;			
			var need = ((NumOfTag - 221) * 0.25).toFixed(0);
			document.all.tdEntNeed.innerHTML = need;
			document.all.spnEntSkuArea.innerHTML = NumOfSkuCnt;
			document.all.tdEntSkuPrc.innerHTML = (NumOfSkuCnt / CurrAreas * 100).toFixed(1) + "%";
			
			setEntAreaPrc();
			
			clearInterval( progressIntFunc );
  		    document.all.dvWait.style.visibility = "hidden";  		 
		}
	}
	xmlhttp.open("POST",url,true); // synchronize with this apps

	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlhttp.setRequestHeader("Content-length", param.length);
	xmlhttp.setRequestHeader("Connection", "close");
	
	xmlhttp.send(param);
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
//show exist options for selection
//==============================================================================
function setEntAreaPrc()
{	
	$("#tdEntPrc").each(function(){
	var z = parseFloat(this.innerHTML) / 25 * 100;	
	var r = 100;
	r = (r * (1 - 0.01 * z)).toFixed(0);	
    var g = "255";
    var b = "255";
    
    if(r < 0){r=0;}    
    
    this.style.backgroundColor = "rgb(" + r + "%," + g + "%," + b + "%)"
	});
}
</SCRIPT>
<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()" >
  
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvWait" class="dvItem"></div>

<div  id="dvLink" style="border: gray 1px ridge;background-color: cornsilk; position:fixed; 
          left:10; top:10;  width:auto; z-index:100;">
          <table class="tbl02" id="tblTags">
            <tr class="trHdr01">
          		<td class="td11">Prenumbered Worksheets:</td>
          		<td class="td11">
          		   <a href="/Physical Inventory/001W-1000 Areas.pdf" target="_blank">1000</a>,
          		   <a href="/Physical Inventory/001W-1250 Areas.pdf" target="_blank">1250</a>,<br>
          		   <a href="/Physical Inventory/001W-1500 Areas.pdf" target="_blank">1500</a>, 
          		   <a href="/Physical Inventory/001W-2000 Areas.pdf" target="_blank">2000</a>          		
          		</td>
          	</tr>
          </table>
 </div>
 
<div  id="dvRecount" style="border: gray 1px ridge;background-color: cornsilk; position:fixed; 
          lft:10; top:10;  width:auto; z-index:100;">
          <table class="tbl02" id="tblTags">
            <tr class="trHdr01">
          		<td class="td11">Enter Last Area Tag #:</td>
          		<td class="td11" nowrap><input name="Tags" size=5 maxlength=4 style="font-size:24px"></td> 
          	</tr>
          	<tr class="trHdr01">
          		<td class="td11">Areas Needed: (25% Goal)</td>
          		<td class="td11" id="tdEntNeed" nowrap>0%</td> 
          	</tr>
          	<tr class="trHdr04">
          		<td class="td18" colspan=3>Recounted Areas</td>
          	</tr>
          	
          	<tr class="trHdr01">
          		<td class="td11" style="border-right:none;">Areas Entered: <span id="spnEntArea"></span></td>
          		<td class="td42" id="tdEntPrc" nowrap>0%</td> 
          	</tr>
          	<tr class="trHdr01">
          		<td class="td11" style="border-right:none;">% of SKU recounted: <span id="spnEntSkuArea"></span></td>
          		<td class="td18" id="tdEntSkuPrc" nowrap>0%</td> 
          	</tr>
          	
          	<tr class="trHdr04">
          		<td class="td41" colspan=2>Only Area #'s over 221 are included in this calculation.</td>
          	</tr>	
          	
          	<tr class="trHdr01">
          		<td class="tdError" id="tdTagErr" colspan="3" nowrap></td>
          	</tr>
          	<tr class="trHdr01">
          		<td class="td14" colspan=3><a href="javascript: vldNumTags();">Save</a></td> 
          	</tr>
          </table>
</div>
<div  id="dvSelect" style="border: gray 1px ridge;background-color: cornsilk; position:fixed; 
         visibility:hidden; top:300;  width:auto; z-index:100;">
               
     <table class="tbl02" id="tblEnt">
        <tr class="trHdr01">
          <th class="th02" >Area</th>          
          <th class="th02" >WIS<br>Count</th>
          <th class="th02" >S&S<br>Count</th>
          <th class="th02" >Unit<br>Diff</th>
          <th class="th02" >S&S<br>Team Member</th>
          <th class="th02" >Did<br>have to<br>recount<br>this?</th>
          <th class="th02" >Did you<br>check<br>the Area<br>by SKU?</th>
          <th class="th02" >Comment</th>
          <th class="th02">Error</th>
        </tr>
        
        
        <tr id="trEnt" class="trDtl06">
                <td class="td11" nowrap><input name="Area"  onkeydown="chkKeyDown('Area', event)" size=5 maxlength=4></td>
                <td class="td11" nowrap><input name="WisCnt" onkeydown="chkKeyDown('WisCnt', event)" size=5 maxlength=4></td>
                <td class="td11" nowrap><input name="RciCnt" onkeydown="chkKeyDown('RciCnt', event)" size=5 maxlength=4></td>
                <td  id="tdDiff" class="td12" style="background:#e7e7e7" nowrap></td>
                <td class="td11" nowrap><input name="RecUsr" onkeydown="chkKeyDown('RecUsr', event)" size=12 maxlength=10></td>
                <td class="td11" nowrap>
                    <input type="checkbox" name="ReCount" onkeydown="chkKeyDown('ReCount', event)" value="Y">Yes &nbsp;
                </td>
                <td class="td11" nowrap>
                    <input type="checkbox" name="RcntBySku" onkeydown="chkKeyDown('RcntBySku', event)" value="Y">Yes &nbsp;
                </td>
                <td class="td11" nowrap><input name="Commt" onkeydown="chkKeyDown('Commt', event)" size=31 maxlength=30></td>
                <td class="tdError" id="tdError" nowrap></td>
         </tr>
         <tr id="trEnt1" class="trDtl12">
         	<td class="td38" colspan="9">
              <!-- a href="javascript: if(EntAllow) { vldLine('Commt') }">Add</a -->
              <a href="javascript: hidePanel1(); restart();">Refresh & Close</a>
            </td>  
         </tr>     
      </table>
               
</div>

 <div  id="dvHelp" style="border: gray 1px ridge;background-color: cornsilk; position:fixed; 
          left:10; top:250;  width:auto; z-index:100;">
          <table class="tbl02" id="tblTags">
            <tr class="trDtl12">
              <td class="td18"><b><u>Tips or Entry:</u><b></b></td>
          	</tr>
          	<tr class="trDtl12">
              <td class="td11">Press F5(CMD5) refresh, often!</td>
          	</tr>
          	<tr class="trDtl12">
              <td class="td18"><b><u>Adding Areas:</u><b></b></td>
          	</tr>
          	<tr class="trDtl12">
              <td class="td11">-Use TAB of ENTER key.
              <br>-Use Spacebar to check 'Yes'.
              <br>-Last field entry, will 'auto' 
              <br>&nbsp;add area and setup for next	entry.
              </td>
          	</tr>
          </table>
 </div>

<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>Retail Concepts, Inc
            <br>Store Area Count Audits
            <br>Store: <%=sStore%>
            </b>
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="PiAreaEntSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02" id="tblArea">
        <tr class="trHdr01">
          <th class="th02" ><a href="javascript: resort('AREA')">Area</a><br><br><a href="javascript: showAddPanel('-1', 'Add')">Add</a></th> 
          <th class="th02" >WIS<br>Count</th>
          <th class="th02" >S&S<br>Count</th>
          <th class="th02" >Unit<br>Diff</th>
          <th class="th02" >S&S<br>Team Member</th>
          <th class="th02" >Did<br>have to<br>recount<br>this?</th>
          <th class="th02" >Did you<br>check<br>the Area<br>by SKU?</th>
          <th class="th02" >Comment</th>
          <th class="th02" ><a href="javascript: resort('DATE')">Recounted<br>User, Date, Time</a></th>
          <th class="th02" >D<br>l<br>t</th>          
        </tr>
        <tbody id="tbNew"></tbody> 
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfArea; i++) {        	   
        	   piarea.setDetail();
   			   String sArea = piarea.getArea();
   			   String sType = piarea.getType();
   			   String sWisCnt = piarea.getWisCnt();
   			   String sRciCnt = piarea.getRciCnt();
   			   String sRecUsr = piarea.getRecUsr();
   			   String sReCount = piarea.getReCount();
   			   String sRecntBySku = piarea.getRecntBySku();   			
   			   String sCommt = piarea.getCommt();
   			   String sHas = piarea.getHas();
   			   String sDiff = piarea.getDiff();
   			   String sRstUsr = piarea.getRstUsr();
   			   String sRstDt = piarea.getRstDt();
   			   String sRstTm = piarea.getRstTm();
   			   
   			   if(sWisCnt.equals("0") && sRciCnt.equals("0")){sTrCls = "trDtl13"; }
   			   else{ sTrCls = "trDtl06"; }
   			   
   			   String sDiffClr = "";
   			   if(sDiff.equals("0") && !sWisCnt.equals("0")){ sDiffClr = "style=\"background:lightgreen\"";}
   			   if(!sDiff.equals("0")){ sDiffClr = "style=\"background:#F75D59\"";}
           %>                           
                <tr id="trArea<%=i%>" class="<%=sTrCls%>">
                <td id="tdArea<%=i%>" class="td12" nowrap><a id="lnkArea<%=i%>"  href="javascript: showAddPanel('<%=i%>', 'Upd')"><%=sArea%></a></td>
                <td id="tdWisCnt<%=i%>" class="td12" nowrap><%=sWisCnt%></td>
                <td id="tdRciCnt<%=i%>" class="td12" nowrap><%=sRciCnt%></td>
                <td id="tdDiff<%=i%>" class="td12" <%=sDiffClr%> nowrap><%if(!sDiff.equals("0")){%><%=sDiff%><%} else {%>&nbsp;<%}%></td>
                <td id="tdRecUsr<%=i%>" class="td11" nowrap><%=sRecUsr%></td>
                <td id="tdReCount<%=i%>" class="td34" nowrap><%=sReCount%></td>
                <td id="tdReBySku<%=i%>" class="td34" nowrap><%=sRecntBySku%></td>
                <td id="tdCommt<%=i%>" class="td11" nowrap><%=sCommt%></td>           
                <td id="tdCommt<%=i%>" class="td11" nowrap><%=sRstUsr%> <%=sRstDt%> <%=sRstTm%></td>     
                <td class="td11"><a href="javascript: dltPanel('<%=i%>')">Dlt</a></td>
              </tr>
              <script></script>	
           <%}%>
           
           <%
           	piarea.setTotal();
   			String sWisCnt = piarea.getWisCnt();
   			String sRciCnt = piarea.getRciCnt();
   			String sDiff = piarea.getDiff();
   			String sNumOfSkuCnt = piarea.getNumOfSkuCnt();
           %>          
            <tr id="trTotal" class="trDtl16">
                <td class="td11" nowrap>Total Entry</td>
                <td class="td12" nowrap><%=sWisCnt%></td>
                <td class="td12" nowrap><%=sRciCnt%></td>
                <td class="td12" nowrap><%=sDiff%></td>
                <td class="td11" nowrap>&nbsp;</td>
                <td class="td11" nowrap>&nbsp;</td>
                <td class="td11" nowrap>&nbsp;</td>
                <td class="td11" nowrap>&nbsp;</td>
                <td class="td11" nowrap>&nbsp;</td>
                <td class="td11" nowrap>&nbsp;</td>
              </tr>
              <script>NumOfSkuCnt = "<%=sNumOfSkuCnt%>";</script>
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
piarea.disconnect();
piarea = null;
}
%>