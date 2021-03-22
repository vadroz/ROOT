<!DOCTYPE html>	
<%@ page import="mozu_com.MozuStrSrlRtn, rciutility.StoreSelect, rciutility.RunSQLStmt
, java.sql.*, java.util.*, java.text.*"%>
<%
   String sSelCust = request.getParameter("Cust");
   String sSelOrd = request.getParameter("Order");
   String sSelPack = request.getParameter("Pack");
   String sSelSku = request.getParameter("Sku");
   String [] sSelSts = request.getParameterValues("Sts");
   String sFrDate = request.getParameter("FrDate");
   String sToDate = request.getParameter("ToDate");
   String sSort = request.getParameter("Sort");
   
   if(sSort == null){ sSort = "ORD"; }
   if(sSelPack == null){ sSelPack = " "; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("ECOMRTN") == null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MozuStrSrlRtn.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStmt = null;
    RunSQLStmt runsql = new RunSQLStmt();
    ResultSet rs = null;
    
    String sSite = null;
    sStmt = "select BxSite from RCI.MOSNDBX";           
	runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	rs = runsql.runQuery();
	if(runsql.readNextRecord())
	{
		sSite = runsql.getData("BxSite");
	}	
	rs.close();
	runsql.disconnect();
	
	String sUser = session.getAttribute("USER").toString();
	MozuStrSrlRtn srlretn = new MozuStrSrlRtn(sSelCust, sSelOrd, sSelPack, sSelSku, sSelSts, sFrDate, sToDate, sSort, sUser);

	int iNumOfItm = srlretn.getNumOfItm();  
	
	String sSelStr = "ALL";
	String sStrAllowed = session.getAttribute("STORE").toString();
	if(!sStrAllowed.startsWith("ALL")){ sSelStr = sStrAllowed; }
	
	String sStrLst = "";
    String sStrNameLst = "";
	
    StoreSelect strlst = new StoreSelect(22);
    int iNumOfStr = strlst.getNumOfStr();
    sStrLst = strlst.getStrNum();
    sStrNameLst = strlst.getStrName();
    
%>
<html>
<head>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Item Return</title>
   
<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>
   
<SCRIPT>

//--------------- Global variables -----------------------
var Cust = "<%=sSelCust%>";
var Ord = "<%=sSelOrd%>";
var Pack = "<%=sSelPack%>";
var Sku = "<%=sSelSku%>";
var FrDate = "<%=sFrDate%>";
var ToDate = "<%=sToDate%>";
var Sort = "<%=sSort%>"
var User = "<%=sUser%>";
var SelSts = [<%=srlretn.cvtToJavaScriptArray(sSelSts)%>];
var SelStr = "<%=sSelStr%>";

var ArrStr = [<%=sStrLst%>];
var ArrStrNm = [<%=sStrNameLst%>];

var aItems = new Array();
var MxItem = 0;
var item = { ord:"", sku:"", cust:"", billNm:"", email:"", ups:"", desc:"", venNm:"", venSty:"" 
		, cls:"", ven :"", sty:"", clr:"", siz:"", clrNm:"", sizNm:"", srl: ""};
var srl = { id:"", str:"", fflSts:"", reason:"", rtnSts:"", rtnStr:"", rtnAct:"", trans:"" 
	, refOpt:"", track:"" };		

var aarg = new Array();

var progressIntFunc = null;
var progressTime = 0;

var NewSku = null; 
var NewDesc = null;
var ArrReas = [	"None","Did Not Like","Changed Mind","Order Wrong Size"
               	,"Remove Sensor Tag"
               	,"Did not Receive","Other", "Not the Item Ordered"];
               	
var ArrReasNm = [	"-- select reason --","Did Not Like","Changed Mind","Wrong Size"
               	,"Remove Sensor Tag","Did not Receive","Other","Not the Item Ordered"];
               	
  
var ArrRtnAct = ["None", "Refund", "Buyers Review", "ECOM Review", "MOS","Do Not Process"];
var ArrRtnActNm = ["-- select action --","Refund","Buyers Review", "ECOM Review","Mark Out of Stock"
                   ,"Do Not Process" ];

var SvLine = null;


//--------------- End of Global variables ----------------
//==============================================================================
// initial process
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
	
   
   	if(SelStr != "ALL" && Ord != "ALL")
   	{
   		document.all.divScanItem.style.visibility = "visible"; 
	   	document.all.divScanItem.style.left = getLeftScreenPos() + 20;
	   	document.all.divScanItem.style.top = getTopScreenPos() + 100;
   	}
   	if(Ord != "ALL"){ getOrdCommt();}   	
}
 

//==============================================================================
// Upload Picture
//==============================================================================
function upload(file) 
{
  var form = new FormData(),
	      xhr = new XMLHttpRequest();

	  form.append('image', file);
	  xhr.open('post', 'server.php', true);
	  xhr.send(form);
}
//==============================================================================
// select/change return item  
//==============================================================================
function selRtnSrl(arg, action, multship)
{
	
	
	item = aItems[arg];
	
	var hdr = "Order: " + item.ord
	if (action != "AddItem" ){ hdr += " &nbsp; &nbsp; SKU: " + item.sku; }
	else{hdr += " &nbsp; &nbsp; Add SKU"}
	
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popRtnSrlPanel(arg, action)
	     + "</td></tr>"
	   + "</table>"

	var name = "#tdUpd" + arg;
	var top = $(name).offset().top - 50;
	top = top.toFixed() + "px";   
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.left = "200px";
	document.all.dvItem.style.top = top;
	document.all.dvItem.style.visibility = "visible";
		  
	if(action == "AddItem" || action == "AddRtn")
	{
		if(SelStr != "ALL"){ document.all.Str.value = SelStr; }		  
		else{ document.all.Str.readOnly = false; }		  
		if(action == "AddItem"){document.all.RtnAct.selectedIndex=1;}
	}
	else{ document.all.Str.value = item.srl.rtnStr; }
	  
	// set return status
	if(SelStr != "ALL" || action == "DltRtn"){ document.all.dvRtnSts.style.display = "none"; }	  
	if(SelStr == "ALL"){ document.all.trEmp.style.display = "none"; }
	   
	if(SelStr == "70" || SelStr == "ALL" && item.srl.rtnStr == "70")
	{
		setStr();
	}
	else 
	{ 
		document.all.trTrans.style.display = "none";
		document.all.trTrack.style.display = "none";
	}
	  
	setReas(action);	  
	 
	if (action != "AddItem" )
	{ 
		document.all.trNOItem.style.display = "none"; 		  
		setRtnSts();		  
		setRefOpt(action);
		setTrackId();
	}
	setRtnAct(action, multship);
}
//==============================================================================
// set reason
//==============================================================================
function setReas(action)
{
	var reas = document.all.Reas;
	
	for(var i=0, j=0; i < ArrReas.length; i++)
	{
		if(SelStr == "ALL" || SelStr != "ALL" && ArrReas[i] != "Did not Receive")
		{
			j = reas.length;
			if(SelStr != "ALL" && action != "AddItem" && i < 7)
			{			   
	   	   		reas.options[j] = new Option(ArrReasNm[i], ArrReas[i]);
			}
			else if(SelStr != "ALL" && action == "AddItem" && i == 7)
			{			   
	   	   		reas.options[j] = new Option(ArrReasNm[i], ArrReas[i]);
			}
			else if(SelStr == "ALL")
			{	
	   	   		reas.options[j] = new Option(ArrReasNm[i], ArrReas[i]);
			}
				
			if(item.srl.reason != "" && ArrReas[i] == item.srl.reason)
			{
				reas.selectedIndex = j; 
			}
		}
	}	
}
//==============================================================================
// set return Status
//==============================================================================
function setRtnSts()
{
	var sts = document.all.RtnSts;
	for(var i=0; i < sts.options.length; i++)
	{
	     if(item.srl.rtnSts==sts.options[i].value){ sts.selectedIndex = i; }
	}
}
//==============================================================================
//set return action
//==============================================================================
function setRtnAct(action, multship)
{
	var act = document.all.RtnAct;	
	var opt = document.all.RefOpt;	
	
	for(var i=0; i < ArrRtnAct.length; i++)
	{
		var x = ArrRtnAct[i];
		var y = ArrRtnAct[i] == "ECOM Review";
			
		if(SelStr == "ALL" || SelStr == "70" || 
		   SelStr != "ALL" && SelStr != "70" && ArrRtnAct[i] != "Buyers Review" && ArrRtnAct[i] != "MOS")
		{
			if(SelStr != "ALL" && multship)
			{
				if( ArrRtnAct[i] != "ECOM Review")
				{
					act.options[act.options.length] = new Option(ArrRtnActNm[i], ArrRtnAct[i]);
				}
			}
			else if(action == "AddRtn" && ArrRtnAct[i] != "ECOM Review")
			{
				act.options[act.options.length] = new Option(ArrRtnActNm[i], ArrRtnAct[i]);
			}
			else if(action == "AddItem" && ArrRtnAct[i] == "ECOM Review")
			{
				act.options[act.options.length] = new Option(ArrRtnActNm[i], ArrRtnAct[i]);
				opt[3].checked=true;
			}
			else if(action == "UpdRtn" || action == "DltRtn")
			{
				act.options[act.options.length] = new Option(ArrRtnActNm[i], ArrRtnAct[i]);
			}
		}		
	}
	
	for(var i=0; i < act.options.length; i++)
	{
		 if(item.srl.reason=="Remove Sensor Tag" && act.options[i].value == "Do Not Process")
		 { 
			 act.selectedIndex = i;			 
		 }
		 else if(item.srl.rtnAct==act.options[i].value){ act.selectedIndex = i; }
	}
}
//==============================================================================
//set refund pay method(option)
//==============================================================================
function setRefOpt(action)
{
	var opt = document.all.RefOpt;
	opt[0].checked = false;
	opt[1].checked = false;
	opt[2].checked = false;
	opt[3].checked = false;
	if(action == "AddRtn" || item.srl.refOpt=="Orig")	{ opt[0].checked = true; }
	else if(item.srl.refOpt=="Cred"){ opt[1].checked = true; }
	else if(item.srl.refOpt=="Gift"){ opt[2].checked = true; }
	else if(item.srl.refOpt=="None"){ opt[3].checked = true; }
	
}
//==============================================================================
//set mail track id fedex, ups, usps
//==============================================================================
function setTrackId()
{
	document.all.Track.value = item.srl.track;	
}
//==============================================================================
//Load Stores
//==============================================================================
function setStr()
{
 	var df = document.all;
 	var j = 0;
 	j=1;

 	for (; j < ArrStr.length; j++)
 	{ 		
 		var i= df.Trans.options.length;
 		df.Trans.options[df.Trans.options.length] = new Option(ArrStr[j] + " - " + ArrStrNm[j], ArrStr[j]); 		
 		if(item.srl.trans == ArrStr[j]){document.all.Trans.selectedIndex=i;}
 	} 	
}
//==============================================================================
//validate store status changes
//==============================================================================
function popRtnSrlPanel(arg, action)
{
	item = aItems[arg];
	var rtnsts = item.srl.rtnSts;
	if(rtnsts ==""){ rtnsts = "*** None ***"; } 
	
	//var panel = "Scan Item: <input id='ScanSku' onkeypress='if (window.event.keyCode == 13) { searchScan(this.value.trim()); }' class='Small' maxlength=12 size=12>"
	var panel = "";
	
	panel += "<table class='tbl02'>"
	    + "<tr class='trDtl09'>"
		+ "<th class='th06'>";
    if(action != "AddItem") 
    { 
    	panel+= "SKU: " + item.sku
	 	 + "<br>UPC: " + item.ups
	 	 + "<br>Desc: " + item.desc
	 	 + "<br>Venodr: " + item.venNm
	 	+ "<br>Ven. Style: " + item.venSty
	 	+ "<br>Color: " + item.clrNm
	 	+ "<br>Size: " + item.sizNm
    } 		
	panel += "&nbsp;</th>"
		+ "<td class='td08'>"
			+ "<table class='tbl06'>"
				+ "<tr class='trDtl09'>"
					+ "<td class='td26'>S/N</td>"
					+ "<td class='td29'> &nbsp; &nbsp; &nbsp; <b>" + item.srl.id + "</b></td>"
				+ "</tr>"
				+ "<tr class='trDtl09'>"
					+ "<td class='td26'>Store</td>"
			    	+ "<td class='td29'><input name='Str'  readonly size=2 maxlength=2></td>"
			 	+ "</tr>"	
				+ "<tr class='trDtl09'>"
					+ "<td class='td26'>Reason</td>"
					+ "<td class='td29'><select name='Reas' onchange='chkReas(this)'></select>"	                   	
		            + "</td>"
		        + "</tr>"
		        + "<tr class='trDtl09' id='trNOItem'>"
	    			+ "<td class='td26'>Not Ordered Item</td>"
	    			+ "<td class='td29'><input name='Item' onkeydown='chkItem(this, event)' size=15 maxlength=15>"
	    	    		+ " &nbsp; <span id='spnDesc'></span>"
	    			+ "</td>"
	    		+ "</tr>"
	    
	    + "<tr class='trDtl09' id='trAction'>"
    		+ "<td class='td26'>Refund Action</td>"
    		+ "<td class='td29'><select name='RtnAct'></select><br>"
    			+ "<input type='radio' name='RefOpt' value='Orig' checked>Original Payment Method &nbsp;"  
    			+ "<input type='radio' name='RefOpt' value='Cred'>Store Credit &nbsp;"
    			+ "<input type='radio' name='RefOpt' value='Gift'>Gift Card &nbsp;"	
    			+ "<input type='radio' name='RefOpt' value='None'>None &nbsp;"
    		+ "</td>"
    	+ "</tr>"
    	
    	+ "<tr class='trDtl09' id='trTrans'>"
		+ "<td class='td26'>Transfer To</td>"
		+ "<td class='td29'><select name='Trans'></select>"
		+ "</td>"
	+ "</tr>"
	 	       
		+ "<tr class='trDtl09' id='trEmp'>"
			+ "<td class='td26'>Employee</td>"
			+ "<td class='td29'><input name='Emp' size=4 maxlength=4></td>"
		+ "</tr>"
		+ "<tr class='trDtl09'>"
	    	+ "<td class='td26'>Comment</td>"
	    	+ "<td class='td29'><TextArea name='Commt' cols=50 rows=4></TextArea></td>"
	 	+ "</tr>"
	 	+ "<tr class='trDtl09' id='trTrack'>"
			+ "<td class='td26' nowrap>Tracking ID</td>"
    		+ "<td class='td29'><input name='Track' size=52 maxlength=50> Scan FedEx, UPS, USPS barcode</td>"
 		+ "</tr>"
	panel += "<tr class='trDtl09'>"
	 		+ "<td class='td26' colspan=2><div id='dvRtnSts'>"
	 		+ "<select name='RtnSts'>" 
	 		    + "<option value='None'>-- select status --</option>"
	 			+ "<option value='Submitted'>Submitted</option>"
	 			+ "<option value='Waiting'>Waiting</option>"
	 			+ "<option value='Processed'>Processed</option>"
	 		+ "</select></div></td>"
	 	+ "</tr>"
	
	panel += "</table>"
			+ "</td>"
	  	+ "</tr>"
	
	panel += "<tr class='trDtl09'>"
		+ "<td class='tdError' id='tdError' colspan=2></td>"
	  + "</tr>";
	  
			
	panel += "<tr class='trDtl09'>"
    	+ "<td nowrap class='td09' colspan=2><button onClick='ValidateSrlRtn(&#34;" + arg + "&#34;,&#34;" + action + "&#34;)' class='Small'>Submit</button>"
    	+ " &nbsp; <button onClick='hidePanel();' class='Small'>Cancel</button>"
 	 + "</td></tr></table>"
 	 
	return panel;
}

//==============================================================================
//validate return entries 
//==============================================================================
function ValidateSrlRtn(arg, action)
{	
	item = aItems[arg];
	
	var error = false;
    var msg = "";
    var br = "";
    document.all.tdError.innerHTML = "";
    
    var reas = "";
    var noitem = "";
    var str = "";
    var trans = "";
    var rtnact = "";
    var refopt = "";
    var emp = "";
    var commt = "";
    var track = "";
    var rtnsts = "";
    	
  if (action != "DltRtn")
  {
    reas = document.all.Reas.options[document.all.Reas.selectedIndex].value;
    if(action != "DltRtn" && reas=="None"){ error=true; msg = br + "Please select return Reason."; br = "<br>";}
        
    noitem = document.all.Item.value.trim();
    if (reas == "Not the Item Ordered")
	{    	
    	if (SelStr != "ALL" && noitem == "") { error=true; msg = br + "Please enter Item Number."; br = "<br>"; }
    	else if(SelStr != "ALL" && isNaN(noitem)){ error=true; msg = br + "Item is not numeric."; br = "<br>"; }
    	else if (SelStr != "ALL")
    	{ 
    		progressIntFunc = setInterval(function() {showWaitBanner() }, 1000);
    		var sresult = getScannedItem(noitem);
    	    if( sresult == "")
    	    {
    	    	error=true; msg = br + "Item is not found on System."; br = "<br>"; 
    	    }
    	    else{ document.all.spnDesc.innerHTML = NewDesc; }
    	} 
	}
	else 
	{
		document.all.Item.value = "";
	}
        
    str = document.all.Str.value;
    if(str=="" || eval(str)==0){ error=true; msg = br + "Please enter your Store number."; br = "<br>"; }
    else if(isNaN(str)){ error=true; msg = br + "Store number is not numeric."; br = "<br>"; }
        
    if(reas != "Remove Sensor Tag" && trans=="None"){ error=true; msg = br + "Please enter your Store number."; br = "<br>"; }
    else if(isNaN(str)){ error=true; msg = br + "Store number is not numeric."; br = "<br>"; }
    
    rtnact = document.all.RtnAct.options[document.all.RtnAct.selectedIndex].value;
    if(rtnact=="None"){ error=true; msg = br + "Please select Refund Action."; br = "<br>";}
    
    refopt = null;
    for(var i=0; i < document.all.RefOpt.length;i++)
    {
    	if(document.all.RefOpt[i].checked){refopt = document.all.RefOpt[i].value;}
    }
    
    
    if(document.all.Trans.selectedIndex >= 0){ trans = document.all.Trans.options[document.all.Trans.selectedIndex].value; }
    
    if(SelStr == "70" && trans=="None" && rtnact != "Buyers Review" && rtnact != "MOS")
    { 
    	error=true; msg = br + "Please select Transfer To Store number."; br = "<br>"; 
    }
        
    emp = document.all.Emp.value.trim().toUpperCase();
    if(SelStr != "ALL")
    {
    	if(emp==""){error = true; msg += br + "Please enter your employee number";  br = "<br>"; }		
		else if (!isEmpNumValid(emp)){error = true; msg += br + "Employee number is invalid."; br = "<br>"; }
    }
    else{emp = "SAME"; }    
    
	commt = document.all.Commt.value.trim();
	if(SelStr != "ALL" && reas == "Other" && commt == "")
    {
    	error = true; msg += br + "Please enter comment";  br = "<br>"; 		
    }	
	
	track = document.all.Track.value;
	
	rtnsts = "Submitted";
	if(SelStr=="ALL")
	{
		rtnsts = document.all.RtnSts.options[document.all.RtnSts.selectedIndex].value;		
	}
	else
	{
		if(item.srl.rtnSts != ""){ rtnsts = item.srl.rtnSts; }
	}
  }
		
    if(error){ document.all.tdError.innerHTML = msg;}
    else{ sbmSrlRtn(arg, str, reas, rtnact, trans, emp, commt, rtnsts, refopt, track, action); }    
}
//==============================================================================
//check scanned item against order
//==============================================================================
function SearchScannedItem(scan)
{	
	document.all.spnScanError.innerHTML = "";
	// get sku
	if(scan.length > 10)
	{
		scan = getScannedItem(scan);
	}
	var found = false;
	for(var i=0; i < aItems.length; i++)
	{
		item = aItems[i];	
		if(item.sku==scan && item.srl.rtnAct == "")
		{
			found = true;
			selRtnSrl(i,"AddRtn", false);			
			break;
		}
	}
	if(!found){document.all.spnScanError.innerHTML = "Item already returned, or not found.";} 
}
//==============================================================================
//check not on Order item entry on tab 
//==============================================================================
function chkItem(item, event)
{
	var key = event.keyCode;
	if(key == 9 || key == 13)
	{
		var sresult = getScannedItem(item.value);
		document.all.spnDesc.innerHTML = NewDesc; 
	}
		
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
//check scanned item against order
//==============================================================================
function getAllUPC(line)
{
	var item = aItems[line];
	SvLine = line; 
	var url = "MozuItemUPCList.jsp?cls=" + item.cls
	  + "&ven=" + item.ven
	  + "&sty=" + item.sty
	  + "&clr=" + item.clr
	  + "&siz=" + item.siz
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
      		var resp = JSON.parse( xmlhttp.responseText );
      		popTipTool(resp);      		
      	}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
	xmlhttp.send();
}
//==============================================================================
//display list of UPC Code 
//==============================================================================
function popTipTool(resp)
{
	var html = "";
	
	var hdr = "UPC List";
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel1();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>"
	
	var br = "";
	for(var i=0; i < resp.upc_list.length;i++)
	{
		html += br + resp.upc_list[i].upc;
		br = "<br>";
	}
	
	html += "</td></tr>"
		   + "</table>"

		
	var name = "tdUpc" + SvLine;
	var obj = document.all[name];
	var pos  = getObjPosition(obj);
	var x = getTopScreenPos();
	var y = Math.abs(x - pos[1]);
	pos[1] = x + y;
	
	document.all.dvTool.innerHTML = html;
	document.all.dvTool.style.visibility = "visible";
	document.all.dvTool.style.left = pos[0] + 75;
	document.all.dvTool.style.top = pos[1];
}
//==============================================================================
// submit return entries 
//==============================================================================
function sbmSrlRtn(arg, str, reas, rtnact, trans, emp, commt, rtnsts, refopt, track, action)
{
	item = aItems[arg];
	
	var nwelem = window.frame1.document.createElement("div");
	nwelem.id = "dvSbmStrSts"
	aSelOrd = new Array();

	var html = "<form name='frmChgSlrRtn'"
	 + " METHOD=Post ACTION='MozuStrSlrRtnSv.jsp'>"
	 + "<input name='Site'>"
	 + "<input name='Ord'>"
	 + "<input name='Pack'>"
	 + "<input name='Sku'>"
	 + "<input name='Srl'>"
	 + "<input name='Str'>"
	 + "<input name='Reas'>"
	 + "<input name='RtnSts'>"
	 + "<input name='RtnAct'>"
	 + "<input name='Trans'>"	 
	 + "<input name='Emp'>"
	 + "<input name='User'>"
	 + "<input name='Comment'>"
	 + "<input name='RefOpt'>"
	 + "<input name='Track'>"
	 + "<input name='Action'>"
	html += "</form>"

	nwelem.innerHTML = html;
	window.frame1.document.body.appendChild(nwelem);

	window.frame1.document.all.Site.value = "<%=sSite%>";
	window.frame1.document.all.Ord.value = item.ord;
	window.frame1.document.all.Pack.value = Pack;
	
	if (action != "AddItem" )
	{ 
		window.frame1.document.all.Sku.value = item.sku;		
	}
	else{ window.frame1.document.all.Sku.value = NewSku; }
	window.frame1.document.all.Srl.value = item.srl.id;
	window.frame1.document.all.Str.value = str;
	window.frame1.document.all.Reas.value = reas;
	window.frame1.document.all.RtnSts.value = rtnsts;
	window.frame1.document.all.RtnAct.value = rtnact;
	window.frame1.document.all.Trans.value = trans;
	window.frame1.document.all.Emp.value = emp;
	window.frame1.document.all.User.value = User;
	
	commt = commt.replace(/\n\r?/g, '<br />');
	window.frame1.document.all.Comment.value = commt;
	window.frame1.document.all.RefOpt.value = refopt;
	window.frame1.document.all.Track.value = track;
	window.frame1.document.all.Action.value = action;
	
	window.frame1.document.frmChgSlrRtn.submit();
}
//==============================================================================
//check employee number
//==============================================================================
function isEmpNumValid(emp)
{
	var valid = true;
	var url = "EComItmAsgValidEmp.jsp?Emp=" + emp;
	var xmlhttp;
	// code for IE7+, Firefox, Chrome, Opera, Safari
	if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
	// code for IE6, IE5
	else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

	xmlhttp.onreadystatechange=function()
	{
 		if (xmlhttp.readyState==4 && xmlhttp.status==200)
 		{
  		valid = xmlhttp.responseText.indexOf("true") >= 0;
 		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

return valid;
}

//==============================================================================
// check reason value, set action if necessary
//==============================================================================
function chkReas(sel)
{
	if(sel.options[sel.selectedIndex].value == "Remove Sensor Tag" )
	{
		var act = document.all.RtnAct;
		var opt = document.all.RefOpt;
		opt[0].checked = true;
		
		for(var i=0; i < act.length; i++)
		{
			if(act.options[i].value == "Do Not Process")
			{ 
				act.selectedIndex = i;
				opt[3].checked = true;
			}
		}
	}
	else if(sel.options[sel.selectedIndex].value != "Not the Item Ordered")
	{
		var act = document.all.RtnAct;
		var opt = document.all.RefOpt;
		opt[0].checked = true;		
		for(var i=0; i < act.length; i++)
		{
			if(act.options[i].value == "Refund"){ act.selectedIndex = i;}
		}
	}
}
//==============================================================================
//retreive comment for selected store
//==============================================================================
function getSkuCommt(arg)
{
	item = aItems[arg];
	
	url = "MozuRtnCommt.jsp?"
 	 + "Site=<%=sSite%>"
  	 + "&Order=" + item.ord
 	 + "&Sku=" + item.sku
  	 + "&Str=" + item.srl.str
  	 + "&Action=GETSTRCMMT"

	window.frame1.location.href = url;
}

//==============================================================================
//display comment for selected store
//==============================================================================
function showSkuComments(site, order, sku, serial, str, type, emp, commt, recusr, recdt, rectm, grp)
{
	var hdr = "Logging Information. Order:" + order + "&nbsp;&nbsp;&nbsp;SKU:" + sku;
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
  	 + "<tr>"
   	 	+ "<td class='BoxName' nowrap>" + hdr + "</td>"
     	+ "<td class='BoxClose' valign=top>"
      	  +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
     	+ "</td></tr>"
   	 + "<tr><td class='Prompt' colspan=2>" + popLog(type,emp, commt, recusr, recdt, rectm
   			 , str, serial, grp)
  	 + "</td></tr>"
	+ "</table>"

	document.all.dvItem.style.width=900;
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.left= (getLeftScreenPos() + 300) + "px";
	document.all.dvItem.style.top= (getTopScreenPos() + 100) + "px";
	document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate log andcomments panel
//==============================================================================
function popLog(type,emp, commt, recusr, recdt, rectm, str, serial, grp)
{
	var panel = "<table class='tbl02' id='tblLog'>"
 		+ "<tr class='trDtl09'>"
    		+ "<th class='th09'>Type</th>"
    		+ "<th class='th09'>S/N</th>"
   			+ "<th class='th09'>Store</th>"
    		+ "<th class='th09'>Comment</th>"
    		+ "<th class='th09'>Recorded by</th>"
 		+ "</tr>"
	for(var i=0; i < commt.length; i++)
	{
   		panel += "<tr class='trDtl09' id='trCommt"+ i + "'>"
     		+ "<td class='td26' nowrap>" + type[i] 
     		   + "<input type='hidden' name='inpGrp" + i + "' value='" + grp[i] + "'>"
     		+ "</td>"
     		+ "<td class='td26' nowrap>" + serial[i] + "</td>"
   		if(str[i] != "0") { panel += "<td class='td26' nowrap>" + str[i] + "&nbsp;</td>" }
   		else{ panel += "<td class='td26' nowrap>H.O.&nbsp;</td>" }

   		panel += "<td class='td26'>" + commt[i] + "</td>"
     		+ "<td class='td26' nowrap>" + recusr[i] + " " + recdt[i] + " " + rectm[i] + "</td>"
	}

	panel += "</table>"
 		+ "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
 		+ "<button onClick='printLog();' class='Small'>Print</button>&nbsp;" 		

   return panel;
}
//==============================================================================
// set selected comments 
//==============================================================================
function setSelCommt(type, len)
{
	for(var i=0; i < len; i++)
	{
		var name = "inpGrp" + i;
		var grp = document.all[name].value;
		var name = "trCommt" + i;
		var tr = document.all[name];
		var disp = "none";
		
		if(type=="ALL"){ disp = "table-row"; }
		else if(type=="RTN" && grp == "1"){ disp = "table-row"; }
		
		tr.style.display = disp;
	}
}
//==============================================================================
//retreive comment for selected store
//==============================================================================
function getOrdCommt()
{
	item = aItems[0];
	
	url = "MozuRtnCommt.jsp?"
	 + "Site=<%=sSite%>"
	 + "&Order=" + item.ord
	 + "&Sku=ALL"
	 + "&Str=ALL"
	 + "&Action=GETORDCMMT"

	window.frame1.location.href = url;
}
//==============================================================================
//display comment for selected store
//==============================================================================
function showOrdComments(site, order, serial, str, type, emp, commt, recusr, recdt, rectm, grp, sku)
{
	var html = "<table border=0 cellPadding=0 cellSpacing=0  style='background: LemonChiffon;text-align:center'>"	
 	 + "<tr><td class='Prompt' colspan=2>" + popOrdComments(site, order, serial, str, type, emp, commt, recusr, recdt, rectm, grp, sku)
	 + "</td></tr>"
	+ "</table>"
	
	document.all.dvLog.innerHTML = html;
	document.all.dvLog.style.visibility = "visible";
}
//==============================================================================
//populate log andcomments panel
//==============================================================================
function popOrdComments(site, order, serial, str, type, emp, commt, recusr, recdt, rectm, grp, sku)
{
	var panel = "<table class='tbl02' id='tblLog'>"
		+ "<tr class='trDtl09'>"
  		+ "<th class='th09'>SKU</th>"
  		+ "<th class='th09'>S/N</th>"
 		+ "<th class='th09'>Store</th>"
 		+ "<th class='th09'>Type</th>"
  		+ "<th class='th09'>Comment</th>"
  		+ "<th class='th09'>Recorded by</th>"
		+ "</tr>"
	for(var i=0; i < commt.length; i++)
	{
 		panel += "<tr class='trDtl09' id='trCommt"+ i + "'>"
   		+ "<td class='td26' nowrap>" + sku[i] + "</td>"
   		+ "<td class='td26' nowrap>" + serial[i] + "</td>"
 		if(str[i] != "0") { panel += "<td class='td26' nowrap>" + str[i] + "&nbsp;</td>" }
 		else{ panel += "<td class='td26' nowrap>H.O.&nbsp;</td>" }

   		panel += "<td class='td26' nowrap>" + type[i] + "</td>"
   		
   		if(type[i]=="Comment"){panel += "<td class='td26'>" + commt[i] + "</td>";}
   		else {panel += "<td class='td47'>" + commt[i] + "</td>";}
   		panel += "<td class='td26' nowrap>" + recusr[i] + " " + recdt[i] + " " + rectm[i] + "</td>"
	}
		
	panel += "</table>";
 return panel;
}
//==============================================================================
//open new window with Log 
//==============================================================================
function printLog()
{
	var tbl = document.all.tblLog.outerHTML;
	  var WindowOptions =
	   'width=600,height=500, left=100,top=50, resizable=yes , toolbar=yes, location=yes, directories=no, status=yes, scrollbars=yes,menubar=yes';
	var win = window.open("", "PrintLog", WindowOptions);
	
	var hdr  = '<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />'
	 + '<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">'
	 win.document.write(hdr);
	 win.document.write(tbl);
	
	hidePanel();
}

//==============================================================================
// select Print serials
//==============================================================================
function selPrtSrl(arg)
{
	var selitm = aItems[arg];
	aarg = new Array();
	// get list of return itemfor current orders
	for(var i=0; i < aItems.length; i++)
	{
		item = aItems[i];
		if(selitm.ord == item.ord && item.srl.rtnSts!="")
		{ 
			aarg[aarg.length] = i;
		}		
	}		
	var hdr = "Order:" + selitm.ord;
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
  	 + "<tr>"
   	 	+ "<td class='BoxName' nowrap>" + hdr + "</td>"
     	+ "<td class='BoxClose' valign=top>"
      	  +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
     	+ "</td></tr>"
   	 + "<tr><td class='Prompt' colspan=2>" + popPrtSrlPanel()
  	 + "</td></tr>"
	+ "</table>"

	document.all.dvItem.style.width=600;
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.left = (getLeftScreenPos() + 300) + "px";
	document.all.dvItem.style.top = (getTopScreenPos() + 100) + "px";
	document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate log andcomments panel
//==============================================================================
function popPrtSrlPanel()
{	
	var panel = "<table class='tbl02' id='tblLog'>"
 		+ "<tr class='trDtl09'>"
 		    + "<th class='th09'>Check</th>"
    		+ "<th class='th09'>SKU</th>"
    		+ "<th class='th09'>UPC</th>"
    		+ "<th class='th09'>Description</th>"
    		+ "<th class='th09'>S/N</th>"
    		+ "<th class='th09'>Reason</th>"    		
 		+ "</tr>"
	for(var i=0; i < aarg.length; i++)
	{
		item = aItems[aarg[i]];
		panel += "<tr class='trDtl09'>"
			+ "<td class='td26' nowrap><input name='Prt" + i + "' type='checkbox' value='" + i + "' checked></td>"
     		+ "<td class='td26' nowrap>" + item.sku + "</td>"
     		+ "<td class='td26' nowrap>" + item.ups + "</td>"
     		+ "<td class='td26' nowrap>" + item.desc + "</td>"
     		+ "<td class='td26' nowrap>" + item.srl.id + "</td>"
     		+ "<td class='td26' nowrap>" + item.srl.reason + "</td>"
     	  + "</tr>";	
   	}
 		
	panel += "</table>"
 		+ "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
 		+ "<button onClick='vldPrtSrl();' class='Small'>Print</button>"
 
 		

	return panel;
}

//==============================================================================
//validate serial number selected to print 
//==============================================================================
function vldPrtSrl()
{
	var error = false;
	var msg = "";
	var chk = false;
	var asel = new Array();
	for(var i=0; i < aarg.length; i++)
	{
		var inp = "Prt" + i;
		if(document.all[inp].checked)
		{
			chk = true;
			item = aItems[aarg[i]];
			asel[asel.length] = item; 
		}
	}
	
	if(!chk){ error=true; msg += "Please check at least 1 item that you want to print."; }
	
	if(error){ alert(msg);}
	else{ sbmPrtSrl(asel); }
}
//==============================================================================
// submit selected serial number to print 
//==============================================================================
function sbmPrtSrl(asel)
{	
	aSelOrd = new Array();

	var url = "MozuPrtSlrRtn.jsp?Site=<%=sSite%>"
	 + "&Ord=" + item.ord
	for(var i=0; i < asel.length; i++)
	{
		item = asel[i];
		url += "&s=" + item.sku
		 + "&u=" + item.ups
		 + "&t=" + SelStr
		 + "&v=" + item.srl.id
		 + "&d=" + item.desc
		 + "&r=" + item.srl.reason;
	}
	
	window.location.href=url;
}

//==============================================================================
// get a shot by webcam
//==============================================================================
function getPic(arg)
{
}
//==============================================================================
//hide panel
//==============================================================================
function snapPic(arg)
{
	var canvas = document.querySelector('canvas');
    var ctx = canvas.getContext('2d');
    
    canvas.width = video.clientWidth;
    canvas.height = video.clientHeight;
    
    ctx.drawImage(video, 10, 10, 450, 350 );
    
    //document.getElementById("videoElement").style.display = "none";
    //document.getElementById("Snap").style.display = "none";
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
//hide panel
//==============================================================================
function hidePanel1()
{
	document.all.dvTool.innerHTML = "";
	document.all.dvTool.style.visibility = "hidden";
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
	var url = "MozuStrSrlRtn.jsp?Cust=" + Cust 
		+ "&Order=" + Ord 
		+ "&Sku=" + Sku 
		+ "&FrDate=" + FrDate 
		+ "&ToDate=" + ToDate
		
    for(var i=0; i < SelSts.length; i++)
    {
    	url += "&Sts=" + SelSts[i];
    }
	url += "&Sort=" + sort;
	  
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
	document.all.dvWait.style.left= getLeftScreenPos() + 340;
	document.all.dvWait.style.top= getTopScreenPos() + 205;
	document.all.dvWait.style.backgroundColor="#cccfff"
	document.all.dvWait.style.visibility = "visible";
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
<div id="divScanItem" class="dvItem">
Scan Item SKU or UPC: <input name="ScanItem" onkeypress="if (window.event.keyCode == 13) { SearchScannedItem(this.value.trim()); }" size=15 maxlength=12>
<span id="spnScanError" style="color:red;"></span>
</div>
<div id="dvTool" class="dvItem"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <br><br><br><br>
      <table class="tbl01">	
        <tr class="trHdr">
          <th align=center>
            <b>Retail Concepts, Inc
            <br>ECOM Item Return
            </b>
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="MozuStrSrlRtnSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;                                                                    
          </th>
        </tr>  
        <tr>
          <td align=left>
          <span style="font-size:11px;">*Use 'Add Item(s)' button under Returns, when a customer returns an item not originally ordered.</span>
          </td>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02" >No.</th>
          <th class="th02" ><a href="javascript: resort('ORD')" >Order</a></th>
          <th class="th02" >Chg<br>Ord<br>#</th>
          <th class="th02" >Pack ID</th>          
          <th class="th02" >Billing<br>Name</th>          
          <th class="th02" ><a href="javascript: resort('ORDDT')" >Order<br>Date</a></th>          
          <th class="th02" ><a href="javascript: resort('SKU')" >SKU</a></th>
          <th class="th02" ><a href="javascript: resort('ITEM')" >Item Number</a></th>
          <th class="th02" nowrap><sup>*</sup>Returns<br><a href="javascript: selRtnSrl(0, 'AddItem', false)">Add Item(s)</a></th>
          <th class="th02" >Pic</th>
          <th class="th02">UPC</th>
          <th class="th02" ><a href="javascript: resort('DESC')" >Description</a></th>
          <th class="th02" >Vendor<br>Name</th>
          <th class="th02" >Color<br>Name</th>
          <th class="th02" >Size<br>Name</th>
          <th class="th02" >S/N</th>          
          <th class="th02" >FFL Status</th>
          <th class="th02" >L<br>o<br>g</th>
          <th class="th02" >Reason</th>
          <th class="th02" >P<br>r<br>t</th>
          <th class="th02" >Return<br>Status</th>
          <th class="th02" >Return<br>to Str</th>
          <th class="th02" ><a href="javascript: resort('ENTDT')" >Entered Date, Time</a></th>          
          <th class="th02" >Entered by User</th>
          <th class="th02" >Refund<br>Action</th>
          <th class="th02" >Refund<br>Method</th>
          
          <%if(sSelStr.equals("ALL") || sSelStr.equals("70")){%>     
          	<th class="th02" >Transfer<br>To<br>Str</th>     
            <th class="th02" >Track Id<br>(FedEx, UPS, USPS)</th>
          	<th class="th02" >Buyer</th>          
          <%}%>
          
          <th class="th02" >Dlt</th>
        </tr>
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfItm; i++) {        	   
        	   srlretn.setItemLst();
               
        	   String sOrd = srlretn.getOrd();
               if(!sSvOrd.equals(sOrd) && sTrCls.equals("trDtl04")){ sTrCls = "trDtl06"; sSvOrd = sOrd; }
               else if(!sSvOrd.equals(sOrd) && sTrCls.equals("trDtl06")){ sTrCls = "trDtl04"; sSvOrd = sOrd; }
               
               String sCust  = srlretn.getCust();
               String sEMail  = srlretn.getEMail();
               String sBillNm  = srlretn.getBillNm();
               String sSku = srlretn.getSku();
               String sOrdDt  = srlretn.getOrdDt();
               String sCls  = srlretn.getCls();
               String sVen  = srlretn.getVen();
               String sSty  = srlretn.getSty();
               String sClr  = srlretn.getClr();
               String sSiz  = srlretn.getSiz();
               String sDesc  = srlretn.getDesc();
               String sVenNm  = srlretn.getVenNm();
               String sVenSty  = srlretn.getVenSty();
               sVenSty = sVenSty.replaceAll("\"", "in");
               String sUps  = srlretn.getUps();
               String sPackId  = srlretn.getPackId();
               String sMaxSrl  = srlretn.getMaxSrl();
               String sItmOnOrd  = srlretn.getItmOnOrd();
               String sBuyer  = srlretn.getBuyer();
               String sBuyerNm  = srlretn.getBuyerNm();
               String sClrNm  = srlretn.getClrNm();
               String sSizNm  = srlretn.getSizNm();
               
               SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/YYYY");
        	   java.util.Date date = new java.util.Date();
        	   String sTodate = sdf.format(date);
        	         	   
                              
               srlretn.setNumOfSrl();               
               int iNumOfSrl = srlretn.getNumOfSrl();               
           %>                           
<!------------------------------- s/n --------------------------------->
           <%for(int j=0; j < iNumOfSrl; j++) {
        	   srlretn.setSrlLst(j+1);
        	   String sSrl  = srlretn.getSrl();
        	   String sStr = srlretn.getStr();
        	   String sFflSts  = srlretn.getFflSts();
        	   String sReason  = srlretn.getReason();
        	   String sRtnSts  = srlretn.getRtnSts();       
        	   String sEntUsr  = srlretn.getEntUsr();
        	   String sEntDt  = srlretn.getEntDt();
        	   String sEntTm  = srlretn.getEntTm();
        	   String sRtnStr  = srlretn.getRtnStr();
        	   String sEmp  = srlretn.getEmp();
        	   String sEmpNm  = srlretn.getEmpNm();
        	   String sSrlOnOrd  = srlretn.getSrlOnOrd();
        	   String sRtnAct  = srlretn.getRtnAct();
        	   String sTrans  = srlretn.getTrans();
        	   String sTrack  = srlretn.getTrack();
        	   String sRefOpt  = srlretn.getRefOpt();
        	   boolean bMultShip  = srlretn.getMultShip();
        	   String sShpDt  = srlretn.getShpDt();
        	  
        	   
        	   SimpleDateFormat sdfUsa = new SimpleDateFormat("MM/dd/yyyy");
        	   java.util.Date dShpDt = sdfUsa.parse(sShpDt);
        	   java.util.Date dCurDt = new java.util.Date();
        	   long ldiff = dCurDt.getTime() - dShpDt.getTime();
        	   long ldays =  ldiff / (1000 * 60 * 60 * 24);
        	   
        	   boolean bAllowRtn = !sTodate.equals(sShpDt) && ldays < 365;  
        	   
        	   String sSvTrCls = sTrCls;
        	   if(sFflSts.equals("Error")){ sTrCls = "trDtl14"; }
        	   if(sSrlOnOrd.equals("N")){ sTrCls = "trDtl13"; }
        	   if(bMultShip){ sTrCls = "trDtl18"; }
        	   
        	   iArg++;
        	   String sAction = "AddRtn";
        	   if(sSelStr.equals("ALL") || sSelStr.equals("70") && !sRtnSts.equals("")){ sAction = "UpdRtn"; }
           %>
                <tr id="trId" class="<%=sTrCls%>">
                <td class="td11" nowrap><%=i+1%></td>
                <td class="td11" nowrap><a href="MozuOrdInfo.jsp?Site=<%=sSite%>&Order=<%=sOrd%>" target="_blank"><%=sOrd%></a></td>
                <td class="td11" id="tdUpd<%=iArg%>" nowrap>
                	<%if(sSrlOnOrd.equals("N") && sSelStr.equals("ALL")){%>
                         <a href="javascript: selRtnSrl('<%=iArg%>', 'ChgOrd', <%=bMultShip%>)">CO</a>
                    <%} else{%>&nbsp;<%} %>
                </td>                
                <td class="td11" nowrap><%=sPackId%></td>
                <td class="td11" nowrap><%=sBillNm%></td>
                <td class="td11" nowrap><%=sOrdDt%></td>
                <td class="td11" nowrap><%=sSku%></td>
                <td class="td11" nowrap><%=sCls%>-<%=sVen%>-<%=sSty%>-<%=sClr%>-<%=sSiz%></td>
                <td class="td18" id="tdUpd<%=iArg%>" nowrap>&nbsp;
                <%if(!sSelStr.equals("ALL") && sRtnSts.equals("") 
                       || sSelStr.equals("ALL") && !sRtnSts.equals("") 
                       || sSelStr.equals("70") && !sRtnSts.equals("Submitted") && !sRtnSts.equals("Processed")){%>
                         
                         <%if(bAllowRtn){%>
                         <a href="javascript: selRtnSrl('<%=iArg%>', '<%=sAction%>', <%=bMultShip%>)">R</a>
                         <%}%>
                    <%}%>
                </td>
                <td class="td11" nowrap><a href="javascript: getPic('<%=iArg%>')">Pic</a></td>
                <td id="tdUpc<%=iArg%>" class="td11" nowrap onclick="getAllUPC('<%=iArg%>')"><%=sUps%></td>
                <td class="td11" nowrap><%=sDesc%></td>
                <td class="td11" nowrap><%=sVenNm%></td>
                <td class="td11" nowrap><%=sClrNm%></td>
                <td class="td11" nowrap><%=sSizNm%></td>
                <td class="td12" nowrap><%=sSrl%></td>                
                <td class="td11" nowrap><%=sFflSts%></td>
                <td class="td11" nowrap><a href="javascript: getSkuCommt('<%=iArg%>')">L</a></td>
                <td class="td11" nowrap><%=sReason%></td>
                <td class="td11" nowrap>&nbsp;
                  <%if(!sRtnSts.equals("")){%><a href="javascript: selPrtSrl('<%=iArg%>')">P</a><%}%>&nbsp;
                </td>
                <td class="td11" nowrap><%=sRtnSts%></td>
                <td class="td12" nowrap><%=sRtnStr%></td>
                <td class="td11" nowrap><%if(!sRtnSts.equals("")){%><%=sEntDt%> <%=sEntTm%><%}%>&nbsp;</td>
                <td class="td11" nowrap><%if(!sRtnSts.equals("")){%><%=sEmp%>-<%=sEmpNm%><%}%>&nbsp;</td>
                <td class="td11" nowrap><%=sRtnAct%></td>
                <td class="td11" nowrap><%=sRefOpt%></td>                
                <%if(sSelStr.equals("ALL") || sSelStr.equals("70")){%>
                	<td class="td11" nowrap><%=sTrans%></td>                
                	<td class="td11" nowrap><%=sTrack%></td>                
                	<td class="td11" nowrap><%=sBuyerNm%></td>
                <%}%>
                
                <td class="td11" nowrap>
                	<%if(sSelStr.equals("ALL") && sRtnSts.equals("Submitted")){%><a href="javascript: selRtnSrl('<%=iArg%>', 'DltRtn', false)">Dlt</a><%}%>
                </td>                                                             
              </tr>
              <script>                 		
                 srl = { id:"<%=sSrl%>", str:"<%=sStr%>", fflSts:"<%=sFflSts%>", reason:"<%=sReason%>"
                	, rtnSts:"<%=sRtnSts%>", rtnStr:"<%=sRtnStr%>"
                	, rtnAct:"<%=sRtnAct%>", trans:"<%=sTrans%>", refOpt:"<%=sRefOpt%>"
                	, track:"<%=sTrack%>"
                };                 
                 
                 item = { ord:"<%=sOrd%>", sku:"<%=sSku%>", cust:"<%=sCust%>", billNm:"<%=sBillNm%>"
               	  , email:"<%=sEMail%>", ups:"<%=sUps%>", desc:"<%=sDesc%>", venNm:"<%=sVenNm%>"
               	  , venSty:"<%=sVenSty%>", cls:"<%=sCls%>", ven:"<%=sVen%>", sty:"<%=sSty%>"
               	  , clr:"<%=sClr%>", siz:"<%=sSiz%>", clrNm:"<%=sClrNm%>", sizNm:"<%=sSizNm%>"
               	  , srl:srl};             		
                 
                 aItems[MxItem] = item;                 
                 MxItem++;
              </script>
              <% sTrCls = sSvTrCls; %>	
             <%}%>
           <%}%>           
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
   
   <!-- ==================================================== -->
   <p>
   <br><br><div id="dvLog"></div >
   <!-- ==================================================== -->
   
   	<div id="container">
    	<video autoplay="true" id="videoElement" style="background: yellow; border: 1px black solid;"></video>
    	<p>
    	<canvas  style="background: khaki; border: 1px black solid ; "></canvas>
    	<br>
    	<button id="Snap" onclick="getPic();">snap</button>    
	</div>
   
   <p> <span style="text-align: left;">
   <u>Shaded Rows:</u>
   <br><span style="background: gold;">Yellow   = Item was shipped from multiple stores.</span>
   <br><span style="background: pink;">Pink = A new Item was added to the order (returned as wrong item received by customer)</span>
   <br><span style="background: orange;">Orange = Item's status is in Error.</span>
   </span>
   
 </body>
</html>
<script>
var video = document.querySelector("#videoElement");

if (navigator.mediaDevices.getUserMedia) {       
    navigator.mediaDevices.getUserMedia({video: true})
  .then(function(stream) {
    video.srcObject = stream;
  })
  .catch(function(error) {
    console.log("Something went wrong!");
  });
}
</script>
<%
srlretn.disconnect();
srlretn = null;
}
%>