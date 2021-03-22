<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page import="inventoryreports.PiStrAreaSkuEnt, rciutility.StoreSelect
, rciutility.RunSQLStmt
, java.text.SimpleDateFormat 
, java.sql.*
, java.util.*, java.text.*"%>
<%
   String sStore = request.getParameter("Store");
   String sPICal = request.getParameter("PICal");   
   String sTop = request.getParameter("Top");   
   String sSort = request.getParameter("Sort");
   
   if(sSort == null){ sSort = "Area"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PiStrAreaSkuEnt.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	
	String sSelPiYr = sPICal.substring(0, 4);
	String sSelPiMo = sPICal.substring(4);
	
	PiStrAreaSkuEnt piarea = new PiStrAreaSkuEnt();	
	piarea.setStrArea(sStore, sSelPiYr, sSelPiMo, sSort, sUser);

	int iNumOfItm = piarea.getNumOfItm(); 
	String sAsOfDate = piarea.getAsOfDate();
	
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
    
    boolean bRevAllow = sUser.equals("psnyder") || sUser.equals("vrozen") || sUser.equals("srutherfor")
    		|| sUser.equals("jburke") || sUser.equals("criley");
%>
<html>
<head>
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
var NumOfItm = "<%=iNumOfItm%>";

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
var NewReas = null;
var NewUpc = null;
var NewAdjQty = null;
var NewPiQty = null;
var SvSku = null;
var CurrAct = null;

var SelRow = null;
//--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
// set sku correction for selected area
//==============================================================================
function setCorrSku(area, sku, qty, reas, desc, action)
{
	CurrAct = action;
	
	var hdr = null;
	if(action=="ADDSKU"){ hdr = "Add SKU to the Area"; }
	else if(action=="UPDSKU"){ hdr = "Update SKU for Area"; }
	else if(action=="DLTSKU"){ hdr = "Delete SKU from Area"; }
	
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	      + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	html += "<tr><td class='Prompt' colspan=2>" + popCorrSku(area, sku, action)+ "</td></tr>"
	html += "</table>"
			
	//var name = "#td" + area;
	//var top = $(name).offset().top + 20;
	 	   
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft = document.documentElement.scrollLeft + 50;
	document.all.dvItem.style.pixelTop = document.documentElement.scrollTop + 100;
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
	
	
	//document.all.Area.value = area;
	if(action !="DLTSKU"){ document.all.Area.focus(); }
	
	if(action =="UPDSKU")
	{	
		document.all.Area.value = area;		
		document.all.Sku.value = sku;
		document.all.Sku.readOnly = true;
		document.all.Area.readOnly = true;
		if(eval(qty) > 0 ){ document.all.AddQty.value = qty; }
		else { document.all.RmvQty.value = Math.abs(eval(qty)); }
		
		while(reas.indexOf("@#@") >= 0){reas = reas.replace("@#@", "'");}
		while(reas.indexOf("%^%") >= 0){reas = reas.replace("%^%", "\"");}
		
		document.all.Reas.value = reas;
	}
	//getCorrSkuExist(area);
}
//==============================================================================
// populate panel
//==============================================================================
function popCorrSku(area, sku, action)
{	
	var panel = "";
	if(action !="DLTSKU")
	{
   		panel = "<table class='tbl01' id='tblCorrSku'>"
		+ "<tr>"
	    	+ "<th class='th02' rowspan=2>Area</th>"
	    	+ "<th class='th02' rowspan=2>SKU/UPC</th>"
	    	+ "<th class='th02' rowspan=2>UPC</th>"
	    	+ "<th class='th02' colspan=2>Quantity</th>"
	    	+ "<th class='th02' rowspan=2>Reason</th>"
	    	+ "<th class='th02' rowspan=2>Description</th>"	    
	    	+ "<th class='th02' rowspan=2>Vendor<br>Nme</th>"
	    	+ "<th class='th02' rowspan=2>Color</th>"
	    	+ "<th class='th02' rowspan=2>Size</th>"	   
	    	+ "<th class='th02' rowspan=2>Dlt</th>"
		+ "</tr>"
	
	
		panel += "<tr>"    	
    		+ "<th class='th02'>Add</th>"
    		+ "<th class='th02'>Remove</th>"
		+ "</tr>"
    	+ "<tr>"      
    	  	+ "<td class='td11' style='border:none;'>"
			  	+ "<input class='Small' name='Area'  onkeydown='setOnKeyDown(this)' size=7 maxlength=5>"
	  		+ "</td>"
      		+ "<td class='td11' style='border:none;'>"
    	  		+ "<input class='Small' name='Sku' onkeydown='setOnKeyDown(this)' size=15 maxlength=12>"
      		+ "</td>"
      		+ "<td class='td11' style='border:none;'><span id='spnDesc'><span></td>"
		      
      		+ "<td class='td11' style='border:none;'>"
	  			+ "<input class='Small' name='AddQty'  onkeydown='setOnKeyDown(this)' size=6 maxlength=5>"
  	  		+ "</td>"
  	  		+ "<td class='td11' style='border:none;'>"
  				+ "<input class='Small' name='RmvQty'  onkeydown='setOnKeyDown(this)' size=6 maxlength=5>"
	  		+ "</td>"
	  		+ "<td class='td11' style='border:none;'>"
				+ "<textArea class='Small' name='Reas' onkeydown='setOnKeyDown(this)' rows=5 cols=60></textArea>"
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
	  	+	"</tr>";   
	  
    	panel += "<tbody id='tbdNewSku'></tbody>";
	}
	else
	{
		panel = "<table class='tbl01' id='tblCorrSku'>"
				+ "<tr>"
		    		+ "<th class='th02'>Area</th>"
		    		+ "<th class='th02'>SKU/UPC</th>"
		    	+ "</tr>"
		    	+ "<tr>"
	    			+ "<td class='td18' style='border:none;'>" + area + "</td>"
	    			+ "<td class='td18' style='border:none;'>" + sku + "</td>"
	    	+ "</tr>";
		panel += "<tr>"
		      + "<td id='tdButton' class='Small' style='text-align:center;' colspan=6>"		      	
		        + "<a href='javascript: dltCorrSku(&#34;" + area + "&#34;,&#34;" + sku + "&#34;)' class='Small'>Delete</a> &nbsp; &nbsp; &nbsp;"
		        + "<a href='javascript: hidePanel(); restart();' class='Small'>Close</a>"
		      + "</td>"	      
		  	+	"</tr>";	
	}
	//panel += "<tbody id='tbdExsSku'></tbody>";
    
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
		else if(obj.name == "RmvQty"){ document.all.RmvQty.focus(); document.all.Reas.select();}
		else if(obj.name == "Reas"){ vldCorrSku(); }
	}	
	if(key == 9)
	{
		if(obj.name == "Reas"){ vldCorrSku(); }
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
  	
  	var area = document.all.Area.value.trim();
  	if(area==""){ error=true; msg += br + "Please enter Area."; br="<br>"; }
  	else if(isNaN(area)){ error=true; msg += br + "Area must be numeric."; br="<br>"; }  	
  	
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
  	else if(eval(addq) > 0 && eval(rmvq) > 0 ){ error=true; msg += br + "Enter only 1 of the Quantities."; br="<br>"; }
  	
  	var reas = document.all.Reas.value.trim();
  	if(reas==""){ error=true; msg += br + "Please enter Reason."; br="<br>"; }
  	else if(reas.length > 256){ error=true; msg += br + "The Reason text length m/b 256. this text is " + reas.length; br="<br>"; } 
  	
  	var adjqty;
  	if(eval(addq) > 0){adjqty = addq; }
  	else { adjqty = eval(rmvq) * (-1) ; }
  	
  	if(eval(rmvq) > eval(NewPiQty) )
  	{ 
  		error=true; 
  		msg += br + "You cannot remove quantity greater than your PI count."; 
  		br="<br>"; 
  	}  	
  	
  	if((SvSku == null || SvSku != NewSku) && eval(NewAdjQty) > 0 && eval(addq) > 0 )
  	{ 
  		error=true; 
  		msg += br + "Warning !!! The positive adjustment for this item already posted - " + NewAdjQty; 
  		br="<br>"; 
  		SvSku = NewSku;
  	}
  	
  	NewArea = area;
  	NewAdjAdd = addq;
  	NewAdjRmv = rmvq;  
  	NewReas = reas;  	 
  	
  	if(error){ document.all.tdError.innerHTML=msg; }
  	else{ sbmCorrSku(area, sku, adjqty, reas); }
}
//==============================================================================
//submit store status changes
//==============================================================================
function sbmCorrSku(area, sku, adjqty, reas)
{	
  	var nwelem = window.frame1.document.createElement("div");
  	nwelem.id = "dvSendEMail"
  	
  	var html = "<form name='frmCorrSku'"
     + " METHOD=Post ACTION='PiStrAreaSkuEntSv.jsp'>"
     + "<input name='Str'>"
     + "<input name='PiCal'>"
     + "<input name='Area'>"     
     + "<input name='Sku'>"
     + "<input name='AdjQty'>"
     + "<input name='Reas'>"
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
  	window.frame1.document.all.Action.value = CurrAct
  	window.frame1.document.all.Reas.value = reas;
  	window.frame1.document.all.User.value=User;
  
  	window.frame1.document.frmCorrSku.submit();
}
//==============================================================================
//send email message
//==============================================================================
function setEMail()
{
	var hdr = "Send E-mail to DM";

	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
		+ "<tr>"
  		+ "<td class='BoxName' nowrap>" + hdr + "</td>"
  		+ "<td class='BoxClose' valign=top>"
  		  	+  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
  		+ "</td></tr>"
		+ "<tr><td class='Prompt' colspan=2>" + popEMailPanel()
			+ "</td></tr>"
	+ "</table>"   


	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.width = 350;
	document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 250;
	document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 200;
	document.all.dvItem.style.visibility = "visible";

	document.all.ToAddr.value = setGMEMail();
	if(User == "vrozen"){document.all.ToAddr.value="vrozen@sunandski.com";}

	document.all.Subj.value = "PI - Adjustment Correction Entry. Store <%=sStore%>" ;
	document.all.Msg.value = "";
	
}
//==============================================================================
//set store GM email address 
//==============================================================================
function setGMEMail()
{
	var str = Store;
	if(str.length ==1){ str = "0" + str; }
	var addr = "GM" + str + "@sunandski.com";
	return addr;
}
//==============================================================================
//populate Picture Menu
//==============================================================================
function popEMailPanel()
{
	var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
	panel += "<tr><td class='Prompt'>E-Mail Address</td></tr>"
	    + "<tr><td class='Prompt'><input class='Small' size=50 name='ToAddr'></td></tr>"
  		+ "<tr><td class='Prompt'>Subject &nbsp;</td></tr>"
    	+ "<tr><td class='Prompt'><input class='Small' size=50 name='Subj'></td></tr>"
  		+ "<tr><td class='Prompt'>Message &nbsp;</td></tr>"
    	+ "<tr><td class='Prompt'><TextArea class='Small' cols=50 rows=3 name='Msg'></TextArea></td></tr>"
  		/*+ "<tr><td class='Prompt'>Include MOS information</td></tr>"
    	+ "<tr><td class='Prompt'>"
       		+ "<input type='radio' name='Incl' value='Y' checked>Yes &nbsp;  &nbsp; "
       		+ "<input type='radio' size=50 name='Incl'  value='N'>No"
       	+ "</td>"
       	*/
       	+ "</tr>" 

  		+ "<tr><td class='Prompt1'>"
    		+ "<button class='Small' onclick='validateEMail()'>Send</button> &nbsp;"
    		+ "<button class='Small' onclick='hidePanel()'>Cancel</button> &nbsp;"
  		+ "</td></tr>"
		panel += "</table>";
		return panel;
}
//==============================================================================
//validate email message properties
//==============================================================================
function validateEMail()
{
var msg = "";
var error = false;

var toaddr = document.all.ToAddr.value.trim();
if(toaddr ==""){error=true; msg="Please enter Email Address"; }

var subj = document.all.Subj.value.trim();
if(subj ==""){error=true; msg="Please enter Subject Address"}

var body = document.all.Msg.value.trim();

var incl = false; //document.all.Incl[0].checked;

if(body =="" && !incl){error=true; msg="Please enter message text or(and) include Control information."}

if(error){ alert(msg); }
else { sbmEMail(toaddr, subj, body, incl, true); }
}
//==============================================================================
//send email message
//==============================================================================
function sbmEMail(toaddr, subj, body, incl, addcommt)
{		
	var msg = "<style>"
	      + " table.tbl02 { border: lightblue ridge 2px; margin-left: auto; margin-right: auto;  padding: 0px; border-spacing: 0; border-collapse: collapse;} "
	      + " tr.trHdr01 { background: #FFE4C4; text-align:center; font-size:10px;font-weight:bold; } "
	      + " tr.trHdr04 { background: LemonChiffon; text-align:center; font-size:18px;font-weight:bold; } "
	      + " th.th02 { border: darkred solid 1px;  text-align:center; vertical-align:top; font-family:Verdanda; font-size:11px; } "
	      + " tr.trDtl03 { background: cornsilk; text-align:center; font-size:11px; } "
	      + " tr.trDtl04 { background: white; text-align:center; font-size:10px; }"
	      + " tr.trDtl06 { background: #e7e7e7; text-align:center; font-size:10px; } "
	      + " tr.trDtl07 { background: #F8ECE0; text-align:center; font-size:12px; } "
	      + " td.td11 {border: lightsalmon solid 1px; border-right: darkred solid 1px; text-align:left; vertical-align:middle; padding: 3px; } "
	      + " td.td12 { border: lightsalmon solid 1px; border-right: darkred solid 1px; text-align:right; vertical-align:middle; padding: 3px; } "
	      + " td.td18 { border: lightsalmon solid 1px; border-right: darkred solid 1px; text-align:center; vertical-align:middle; padding: 3px; } "
	      + " td.td46 { border: none; text-align:right; vertical-align:middle; padding: 3px; } "
	      + " td.td45 { border: none; text-align:left; vertical-align:middle; padding: 3px; } " 
	      + " #cellLink { display:none; }"
	      + " #trLinks1 { display:none; }"
	      + " #trBotton1 { display:none; }"
	      + " #trDFI { display:none; }"
	      + " #tdDFI { display:none; }"
	      + " #trInstr { display:none; }"
	      + " #tdInstr { display:none; }"
	      + " #tblInstr { display:none; }"
	      + " .spnItmStsEmail { display:none; }"
	      + " .spnItmStsEmail { display: block; }"      
	      + " .NonPrt  { display:none; } "      

	  msg += "</style> <body>";
	
	
	var nwelem = window.frame2.document.createElement("div");
  	nwelem.id = "dvSendEMail"
  	
  	var html = "<form name='frmSendEmail'"
  	   + " METHOD=Post ACTION='RtvCtlSendEMail.jsp'>"
  	   + "<input class='Small' name='MailAddr'>"
  	   + "<input class='Small' name='CCMailAddr'>"
  	   + "<input class='Small' name='FromMailAddr'>"
  	   + "<input class='Small' name='Subject'>"
  	   + "<input class='Small' name='Message'>"
     
	html += "</form>"
		  		
  	nwelem.innerHTML = html;
  	window.frame2.document.body.appendChild(nwelem);
  	
  	window.frame2.document.all.MailAddr.value = toaddr;    
    window.frame2.document.all.CCMailAddr.value = " ";
    var str = Store;
    if(Store.length==1){ str = "0" + Store; }
    var frAddr = "Store" + str + "@sunandski.com"
    window.frame2.document.all.FromMailAddr.value = frAddr;
    window.frame2.document.all.Subject.value = subj;
    
    msg += body;
    if(incl){msg += "<br><br>" + document.all.tblEnt.outerHTML;}
    msg += "</body>";
    
    window.frame2.document.all.Message.value=msg;
  
  	window.frame2.document.frmSendEmail.submit();
  	hidePanel();
}


//==============================================================================
// get already entered sku for area corrections
//==============================================================================
function getCorrSkuExist(area)
{
	NewArea = area;
	
	var url = "PiStrAreaSkuEntCorr.jsp?"
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
	var tblCorrSku = document.getElementById("tblCorrSku");
	var tbody = document.getElementById("tbdNewSku"); 	
	
	var row = tbody.insertRow(-1);
    row.className="trDtl04";
    row.id = name;
    var td = new Array();
    
    td[0] = addTDElem(NewArea, "tdArea", "td11");
    td[1] = addTDElem(NewSku, "tdSku", "td18");
    td[2] = addTDElem(NewUpc, "tdUpc", "td11");
    td[3] = addTDElem(NewAdjAdd, "tdAddQty", "td12");
    td[4] = addTDElem(NewAdjRmv, "tdRmvQty", "td12");
    td[5] = addTDElem(NewReas, "tdReas", "td11");
    td[6] = addTDElem(NewDesc, "tdDesc", "td11");
       
    for(var i=0; i < td.length;i++){ row.appendChild(td[i]); }
	
	document.all.Sku.value = "";
	document.all.Sku.focus();
	document.all.spnDesc.innerHTML = "";
	document.all.AddQty.value = "";
	document.all.RmvQty.value = "";
	document.all.Reas.value = "";	
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
function dltCorrSku(area, sku)
{
	var url = "PiStrAreaSkuEntSv.jsp?"
	   + "Str=" + Store
	   + "&PiCal=" + PiCal
	   + "&Area=" + area
	   + "&Sku=" + sku
	   + "&Action=DLTSKU"
	   ;
		
	window.frame2.document.location.href = url;
}
//==============================================================================
// reverse adjustment 
//==============================================================================
function setRevSku( area, sku, qty, arg, action)
{	
	SelRow = arg;
	
	var hdr = "Reverse SKU Last Posted Correction";
	
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	      + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	html += "<tr><td class='Prompt' colspan=2>" + popRevSku(area, sku,qty,action)+ "</td></tr>"
	html += "</table>";
	
	document.all.dvItem.style.width = 300;
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft = document.documentElement.scrollLeft + 150;
	document.all.dvItem.style.pixelTop = document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";	
}
//==============================================================================
//populate panel
//==============================================================================
function popRevSku(area, sku, qty, action)
{	
	var panel = "<table class='tbl01' border='1' id='tblRevSku'>"
		+ "<tr>"
	    	+ "<th style='text-align:right'>Area:</th>"
	    	+ "<td style='text-align:right'>" + area + "</td>"	    	
		+ "</tr>"
		+ "<tr>"
    	    + "<th style='text-align:right'>SKU</th>"
    		+ "<td style='text-align:right'>" + sku + "</td>"	    	
	   	+ "</tr>"
	   	+ "<tr>"
    		+ "<th style='text-align:right'>Reversed Qty</th>"
    		+ "<td style='text-align:right'>" + eval(qty) * (-1) + "</td>"	    	
		+ "</tr>"
		;
	panel += "<tr>"
		      + "<td id='tdButton' class='Small' style='text-align:center;' colspan=6>"		      	
		        + "<a href='javascript: sbmRevSku(&#34;" + area + "&#34;,&#34;" + sku 
		              + "&#34;,&#34;" + eval(qty) * (-1) + "&#34;,&#34;" + action 
		              + "&#34;)' class='Small'>Reverse</a> &nbsp; &nbsp; &nbsp;"
		        + "<a href='javascript: hidePanel();' class='Small'>Close</a>"
		      + "</td>"	      
		  	+	"</tr>";	
	
 	panel += "</table>";
     
	return panel;
}
//==============================================================================
//reverse adjustment 
//==============================================================================
function sbmRevSku( area, sku, qty, action)
{	
	var url = "PiStrAreaSkuEntSv.jsp?"
	   + "Str=" + Store
	   + "&PiCal=" + PiCal
	   + "&Area=" + area
	   + "&Sku=" + sku
	   + "&AdjQty=" + qty
	   + "&Action=" + action
	   + "&User=" + User
	   ;				
	window.frame2.document.location.href = url;	
}
//==============================================================================
// update reversed SKU
//==============================================================================
function updRevSku()
{
	hidePanel();
	
	var rownm = "trArea" + SelRow;
	var row = document.all[rownm];
	row.style.background = "LemonChiffon";
	
	var cellnm = "tdEnt" + SelRow;
	var cell = document.all[cellnm];
	cell.innerHTML = "Reversed by "  + User;
	
	cellnm = "tdDlt" + SelRow;
	cell = document.all[cellnm];
	cell.innerHTML = "";
	
	cellnm = "tdRev" + SelRow;
	cell = document.all[cellnm];
	cell.innerHTML = "";
	
	cellnm = "tdPost" + SelRow;
	cell = document.all[cellnm];
	cell.innerHTML = "";
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
	var url = "PiSkuValid.jsp?Item=" + item
		+ "&Str=" + Store
		+ "&PiCal=" + PiCal
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
    		
    		var beg = resp.indexOf("<UPC>") + 5;
    		var end = resp.indexOf("</UPC>");
    		upc = resp.substring(beg, end);
    		NewUpc = upc;
    		
    		var beg = resp.indexOf("<ADJQTY>") + 8;
    		var end = resp.indexOf("</ADJQTY>");
    		NewAdjQty = resp.substring(beg, end); 
    		
    		var beg = resp.indexOf("<PIQTY>") + 7;
    		var end = resp.indexOf("</PIQTY>");
    		NewPiQty = resp.substring(beg, end);
    		
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
//enter comment
//==============================================================================
function setCommt()
{
	var hdr = "Add Comments"; 
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	      + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	html += "<tr><td class='Prompt' colspan=2>" + popCommt() + "</td></tr>"
	html += "</table>"
			
	  	   
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.width = 550;
	document.all.dvItem.style.pixelLeft = document.documentElement.scrollLeft + 250;
	document.all.dvItem.style.pixelTop = document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate panel
//==============================================================================
function popCommt()
{	
	var panel = "<table class='tbl02' id='tblCorrSku' width='100%'>"
		+ "<tr class='trHdr03'>"
	    	+ "<th class='th02'>Comments</th>" 
		+ "</tr>"
	 
	panel += "<tr class='trDtl03'>"    	
      		+ "<td class='td18' style='border:none;'>"
				+ "<textArea  name='Commt' rows=5 cols=60 maxlength=800></textArea>"
	  		+ "</td>"
    	+ "</tr>";  
	    
    panel += "<tr>"
  			+ "<td id='tdError' class='Small' colspan=6 style='color:red;font-size:12px;'></td>"
   		+ "</tr>";	 
	panel += "<tr  class='trDtl12'>"
		      + "<td id='tdButton' class='td18' style='text-align:center;' colspan=6>"		      	
		        + "<a href='javascript: vldCommt()' class='Small'>Add</a> &nbsp; &nbsp; &nbsp;"
		        + "<a href='javascript: hidePanel(); restart();' class='Small'>Close</a>"
		      + "</td>"	      
		  	+	"</tr>";	
     
    panel += "</table>";
        
	return panel;
}
//==============================================================================
//validate comments
//==============================================================================
function vldCommt()
{
	var error = false;
  	var msg = "";
  	var br = "";
  	document.all.tdError.innerHTML="";
  	
  	var commt = document.all.Commt.value;
  	if(commt.trim() == ""){error = true; msg += "Please enter a text."}
  	
  	if (commt.length > 800){ commt = commt.substring(0,800); }
  	
  	if(error){ document.all.tdError.innerHTML=msg; }
  	else{ sbmCommt(commt); }
}
//==============================================================================
//submit store status changes
//==============================================================================
function sbmCommt(commt)
{	
	var nwelem = window.frame1.document.createElement("div");
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
	window.frame1.document.body.appendChild(nwelem);

	window.frame1.document.all.Str.value = Store;
	window.frame1.document.all.PiCal.value = PiCal;	 
	window.frame1.document.all.Action.value = "ADDSTRCOMMT";
	window.frame1.document.all.Comment.value = commt;
	window.frame1.document.all.User.value=User;

	window.frame1.document.frmCommt.submit();
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
	var url="PiStrAreaSkuEnt.jsp?Store=<%=sStore%>&PICal=<%=sPICal%>&Top=<%=sTop%>&Sort=" + sort;
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
	var url ="PiStrAreaSkuEnt.jsp?Store=" + Store + "&PICal=" + PiCal;
			
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
<!-- div  id="dvHelp" style="border: gray 1px ridge;background-color: cornsilk; position:absolute; 
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
 </div -->
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
            <br>PI - Adjustment Correction Entry             
            <br>Store: <%=sStore%>              
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="PiStrAreaSkuEntSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;
              <br><a href="javascript: setCorrSku(null, null, null, null, null, 'ADDSKU')">Add Area/Sku Corrections</a>
              <br><a href="javascript: setCommt()">Area Reconciliation Comments</a>  
              <br><a href="javascript: setEMail()">E-Mail to DM</a> 
              
               
                        
          </th>
        </tr>
        
        <tr>
          <td align=left><b>* Use '9999' for SKU corrections with no Area count.</b></td>
        </tr>     
        
        
        <tr>
          <td>  
      <table class="tbl02" id="tblEnt">
        <tr class="trHdr01">        
          <th class="th02" rowspan=2><a href="PiStrAreaSkuEnt.jsp?Store=<%=sStore%>&PICal=<%=sPICal%>&Sort=Area">Area</a></th>
          <th class="th02" rowspan=2 ><a href="PiStrAreaSkuEnt.jsp?Store=<%=sStore%>&PICal=<%=sPICal%>&Sort=SKU">SKU</a></th>
          <th class="th02" rowspan=2 >H<br>i<br>s<br>t</th>          
          <th class="th02" rowspan=2 >UPC</th>
          <th class="th02" rowspan=2 >Qty<br>Adjusted</th>          
          <th class="th02" rowspan=2 >Reason for Miscount</th>
          <th class="th02" rowspan=2 >By User, Date, Time </th>
          <th class="th02" rowspan=2 >Item<br>Description</th>
          <th class="th02" rowspan=2 >Vendor<br>Name</th>
          <th class="th02" rowspan=2 >Color</th>
          <th class="th02" rowspan=2 >Size</th>
          <th class="th02" rowspan=2 >Extended<br>Retail</th>
          <th class="th02" rowspan=2 >Dlt</th>
          <th class="th02" rowspan=2 >Rev</th>
          <th class="th02" rowspan=2 >Posted By User/Date/Time</th>          
          <th class="th02" rowspan=2 >SKU</th>
          <th class="th02" rowspan=2 >Qty<br>Adjusted</th>
          <th class="th02" colspan=3 nowrap>
             PI Unit Adjustments<br>Total results for SKU<br> As Of <%=sAsOfDate%> 
          </th>          
        </tr>
        <tr class="trHdr01">
          <th class="th02"><a href="PiStrAreaSkuEnt.jsp?Store=<%=sStore%>&PICal=<%=sPICal%>&Sort=PICount">PI<br>Counts</a></th>
          <th class="th02"><a href="PiStrAreaSkuEnt.jsp?Store=<%=sStore%>&PICal=<%=sPICal%>&Sort=OnHand">On Hand</a></th>
          <th class="th02"><a href="PiStrAreaSkuEnt.jsp?Store=<%=sStore%>&PICal=<%=sPICal%>&Sort=Adjust">Adjustment</a></th>
        </tr>  
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfItm; i++) {        	   
        	   	piarea.setDetail();
        	   	String sStr = piarea.getStr();
   				String sPiYr = piarea.getPiYr();
   				String sPiMo = piarea.getPiMo();
   				String sArea = piarea.getArea();
   				String sSku = piarea.getSku();
   				String sQty = piarea.getQty();
   				String sReas = piarea.getReas();
   				String sEntUser = piarea.getUser();
   				String sDate = piarea.getDate();
   				String sTime = piarea.getTime();
   				String sCls = piarea.getCls();
   				String sVen = piarea.getVen();
   				String sSty = piarea.getSty();
   				String sClr = piarea.getClr();
   				String sSiz = piarea.getSiz();
   				String sDesc = piarea.getDesc();
   				String sVenSty = piarea.getVenSty();
   				String sVenNm = piarea.getVenNm();
   				String sClrNm = piarea.getClrNm();
   				String sSizNm = piarea.getSizNm(); 
   				String sUpc = piarea.getUpc();
   				String sPrice = piarea.getPrice();
   				
   				String sPost = piarea.getPost();
   				String sPostUs = piarea.getPostUs();
   				String sPostDt = piarea.getPostDt();
   				String sPostTm = piarea.getPostTm();
   				
   				String sTop5Prc = piarea.getTop5Prc();
   				String sTop5PrcEnt = piarea.getTop5PrcEnt();
   				String sBookQty = piarea.getBookQty();
   				String sPhyQty = piarea.getPhyQty();
   				String sAdjQty = piarea.getAdjQty();
   				
   				String sReasFx = sReas.replaceAll("'", "@#@");
   				sReasFx = sReasFx.replaceAll("\"", "%^%");
   				
   				String sDescFx = sDesc.replaceAll("'", "@#@");
   				sDescFx = sDescFx.replaceAll("\"", "%^%");
   				
   				String sAdjStyle = "";
   				if(!sAdjQty.equals("0") && sAdjQty.indexOf("-") >= 0){ sAdjStyle = "style=\"background: pink;\""; }
   				else if(!sAdjQty.equals("0") && sAdjQty.indexOf("-") < 0){ sAdjStyle = "style=\"background: lightgreen;\""; }
           %>                           
                <tr id="trArea<%=i%>" class="<%=sTrCls%>" <%if(sTop5PrcEnt.equals("Y")){%>style="background: lightblue;"<%}%>>
                <td class="td12" nowrap <%if(sTop5Prc.equals("Y")){%>style="background:pink;"<%}%>><%=sArea%></td>
                <td class="td12" nowrap>
                	<a href="javascript: setCorrSku( '<%=sArea%>', '<%=sSku%>', '<%=sQty%>', '<%=sReasFx%>', '<%=sDesc%>', 'UPDSKU')"><%=sSku%></a>
                </td>
                <td class="td12" nowrap>
                   <a href="PIItmSlsHst.jsp?STORE=<%=sStore%>&PICal=<%=sPICal%>&Sku=<%=sSku%>&FromDate=01/01/0001&ToDate=12/31/2099" target="_blank">H</a>
                </td>
                <td class="td12" nowrap><%=sUpc%></td>
                <td class="td12" nowrap><%=sQty%></td>                 
                <td class="td11" nowrap><%=sReas%></td>
                <td class="td12" id="tdEnt<%=i%>" nowrap><%=sEntUser%>, <%=sDate%> <%=sTime%></td>
                <td class="td11" nowrap><%=sDesc%></td>
                <td class="td11" nowrap><%=sVenNm%></td>
                <td class="td11" nowrap><%=sClrNm%></td>
                <td class="td11" nowrap><%=sSizNm%></td>
                <td class="td11" nowrap><%=sPrice%></td>
                <td class="td18" id="tdDlt<%=i%>" nowrap>
                    <%if(sPost.equals("")){%>
          			<a href="javascript: setCorrSku( '<%=sArea%>', '<%=sSku%>', null, null, null, 'DLTSKU')">Dlt</a>
          			<%} %>
          		</td>
          		<td class="td18" id="tdRev<%=i%>" nowrap>
                    <%if(sPost.equals("Y") && bRevAllow){%>
          			<a href="javascript: setRevSku( '<%=sArea%>', '<%=sSku%>', '<%=sQty%>', '<%=i%>','REVSKU')">Rev</a>
          			<%} %>
          		</td>            
          		<td class="td11"  id="tdPost<%=i%>" nowrap>
          		    <%if(sPost.equals("Y")){%>
          			    <%=sPostUs%> &nbsp; <%=sPostDt%> &nbsp; <%=sPostTm%>
          			<%}%>
          		</td>
          		
          		<td class="td12" nowrap>
                	<a href="javascript: setCorrSku( '<%=sArea%>', '<%=sSku%>', '<%=sQty%>', '<%=sReasFx%>', '<%=sDesc%>', 'UPDSKU')"><%=sSku%></a>
                </td>
                <td class="td12" nowrap><%=sQty%></td>
          		
          		<td class="td12" nowrap><%=sPhyQty%></td> 
          		<td class="td12" nowrap><%=sBookQty%></td>
          		<td class="td12" nowrap <%=sAdjStyle%>><%=sAdjQty%></td>        
              </tr>
              <script></script>	
           <%}%> 
           
           <!----------------------- total  ------------------------>
           <%
           	piarea.setTotal();
       		String sPrice = piarea.getPrice();
	       	String sQty = piarea.getQty();
           %>           
           <tr class="trDtl03">
           	<td class="td12" nowrap colspan=2>Total</td>
           	<td class="td12" nowrap><%=sQty%></td>
           	<td class="td12" nowrap colspan=8>Extended Retail</td>
           	<td class="td11" nowrap><%=sPrice%></td>
           	<td class="td12" colspan=7 nowrap>&nbsp;</td>
           </tr>
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
   
   <p style="text-align:left;">
   <span style="background:pink">999</span> - Area was included in the Top 5% - of areas.
   <br>
   <span style="background: lightblue">Alert - Check for possible Double Entry</span> - The same Area/Sku/Qty was entered on the 5% Area Recounts. 
   <p style="text-align:center;">
   
   <table class="tbl02" id="tblComm">
        <tr class="trHdr01">
          <th class="th02" >Comments</th>
          <th class="th02" >User</th>
          <th class="th02" >Date/Time</th>  
        </tr>   
   <%
 //-------------- check allowed stores ------------------       
   String sPrepStmt = "select SCCOMM, ScRecBy, ScRecDt,ScRecTm"   	 	
     	 	+ " from rci.PiStrCom"
      	 	+ " where ScStr=" + sStore  
      	 	+ " and scPiYr=" + sSelPiYr + " and scPiMo=" + sSelPiMo   
      	 	+ " and ScType = 'FINAL'"
      	 	+ " order by scid";     
   
     //System.out.println("header Comments\n" + sPrepStmt);
   	   	
     ResultSet rslset = null;
     RunSQLStmt runsql = new RunSQLStmt();
     runsql.setPrepStmt(sPrepStmt);		   
     runsql.runQuery();
   	
     while(runsql.readNextRecord()){%>
     	<tr class="trDtl03">           	 
           	<td class="td11"><%=runsql.getData("ScComm")%></td>
           	<td class="td11" nowrap><%=runsql.getData("ScRecBy")%></td>
           	<td class="td18" nowrap>
           		<%=runsql.getData("ScRecDt")%>&nbsp;
           		<%=runsql.getData("ScRecTm")%>
           	</td>
        </tr>    	 
   	 <%}   	    
     runsql.disconnect();
     runsql = null;
   %>
   
   <p style="text-align:left;">
   
 </body>
</html>
<%
piarea.disconnect();
piarea = null;
}
%>