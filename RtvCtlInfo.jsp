<%@ page import="rtvregister.RtvCtlInfo, rtvregister.RtvReasonCode"%>
<%
   String sSelCtl = request.getParameter("Ctl");   

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=RtvCtlInfo.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();
      String sStrAllowed = session.getAttribute("STORE").toString();    
      
      RtvCtlInfo ctlinfo = new RtvCtlInfo();
  	  ctlinfo.setCtlInfo(sSelCtl, sUser);  	 
	  ctlinfo.setCtlInfo();
	
	  String sVen = ctlinfo.getVen();
	  String sStr = ctlinfo.getStr();
	  String sCtlReas = ctlinfo.getCtlReas();
	  String sCtlSts = ctlinfo.getCtlSts();
	  String sName = ctlinfo.getName();
	  String sCtlUsr = ctlinfo.getCtlUsr();
	  String sCtlDt = ctlinfo.getCtlDt();
	  String sCtlTm = ctlinfo.getCtlTm();
	  String sVenNm = ctlinfo.getVenNm();
	  String sVenAddr1 = ctlinfo.getVenAddr1();
	  String sVenAddr2 = ctlinfo.getVenAddr2();
	  String sVenAddr3 = ctlinfo.getVenAddr3();
	  String sVenCont = ctlinfo.getVenCont();
	  String sVenPhn = ctlinfo.getVenPhn();
	  String sVenEmail = ctlinfo.getVenEmail();
	  String sVenAlwRt = ctlinfo.getVenAlwRt();
	  String sVenInstC = ctlinfo.getVenInstC();
	  String sVenInstR = ctlinfo.getVenInstR();
	  
	  String sHdrStsJva = ctlinfo.getHdrStsJva();
  	  String sItmStsJva = ctlinfo.getItmStsJva();
	  
	  RtvReasonCode reasCode = new RtvReasonCode();
      String sReason = reasCode.getReasonCode();
      String sReasonDesc = reasCode.getReasonDesc();
%>

<html>
<head>

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<style type="text/css" media="print">
  @page { transform: rotate(90deg); }
  .NonPrt  { display:none; }
</style>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
// orser header info
var CtlNum = "<%=sSelCtl%>";
var StrAllowed = "<%=sStrAllowed%>";
var Store = "<%=sStr%>";
var Vendor = "<%=sVen%>";
var User = "<%=sUser%>";
var CtlSts = "<%=sCtlSts%>";
var CtlReas = "<%=sCtlReas%>";

var Reason = [<%=sReasonDesc%>];
var NewSku = "";
var NewVen = "";
var NewDesc = "";
var NewStrQty = "";
var NewOnRtv = "";
var NewOnMos = "";
var NewRemind = "";


var HdrStsLst = [<%=sHdrStsJva%>];
var ItmStsLst = [<%=sItmStsJva%>];

var ItemWithPic = new Array();
var PicPath = new Array();
var ItemPicArg = 0;
var PoNum = null;
var DocNum = null;
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvPhoto", "dvReason", "dvPoList"]);
   
   document.all.spnStsEmail.style.display = "none";
   setItmStsVis(true);
   
   rtvCtlComments();
   
   rtvItemComments();
   rtvItemPictures();   
   rtvLogEntires();
   
}
//==============================================================================
// add Ctl comments
//==============================================================================
function addCtlHdrCommt(id, text, action)
{
   var hdr = "Claim Comments";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popCtlCommentsPanel(id, action)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 40;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 95;
   document.all.dvItem.style.visibility = "visible";

   if(text != null){document.all.Comm.value=text;}
   if(action == "DELETE"){document.all.Comm.readOnly=true;}
   document.all.CommId.value = id;
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popCtlCommentsPanel(id, action)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<td class='Prompt' nowrap><textarea name='Comm' cols=170 rows=5></textarea>"
           + "<input name='CommId' type='hidden'>"
         + "</td>"
       + "</tr>"

  panel += "<tr>";
  if(action=="ADD")
  {
     panel += "<td class='Prompt1'><br><br><button onClick='ValidateClmCommt(&#34;ADD_CLM_COMMENT&#34;)' class='Small'>Add Comments</button>&nbsp;"
  }
  else if(action=="UPDATE")
  {
     panel += "<td class='Prompt1'><br><br><button onClick='ValidateClmCommt(&#34;UPD_CLM_COMMENT&#34;)' class='Small'>Update Comments</button>&nbsp;"
  }
  else if(action=="DELETE")
  {
     panel += "<td class='Prompt1'><br><br><button onClick='ValidateClmCommt(&#34;DLT_CLM_COMMENT&#34;)' class='Small'>Delte Comments</button>&nbsp;"
  }

  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}


//==============================================================================
// change status menu
//==============================================================================
function chgStatusMenu()
{
   var hdr = "Change Control Number Status";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popChgStsPanel()
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 125;
   document.all.dvItem.style.visibility = "visible";

   chkCurSelSts();
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popChgStsPanel()
{
  var dummy = "<table>";
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"

  for(var i=0; i < HdrStsLst.length; i++)
  {
     panel += "<tr><td class='Prompt' nowrap><input name='CtlSts' type='radio' value='" + HdrStsLst[i] + "'></td>"
         + "<td class='Prompt' nowrap>" + HdrStsLst[i] + "</td>"
       + "</tr>"
  }

  panel += "<tr>";
  panel += "<td class='Prompt1' colspan=2><br><br><button onClick='ValidateCtlSts(&#34;Chg_Ctl_Sts&#34;)' class='Small'>Submit</button>&nbsp;"
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";

  return panel;
}
//==============================================================================
// populate dropdown menu for item issues
//==============================================================================
function chkCurSelSts()
{
   for(var i=0; i < HdrStsLst.length; i++)
   {
      if(HdrStsLst[i]==CtlSts) { document.all.CtlSts[i].checked = true; }
   }
}
//==============================================================================
//change Item Status Menu
//==============================================================================
function chgItmStsMenu(item, sku, sts)
{
	var hdr = "Change Item Status. SKU: " + sku;

	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	  + "<tr>"
	     + "<td class='BoxName' nowrap>" + hdr + "</td>"
	     + "<td class='BoxClose' valign=top>"
	       +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	     + "</td></tr>"
	  + "<tr><td class='Prompt' colspan=2>" + popItmStsPanel()
	     + "</td></tr>"
	+ "</table>"

	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
	document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 125;
	document.all.dvItem.style.visibility = "visible";
	
	for(var i=0; i < ItmStsLst.length; i++)
	{
		if(ItmStsLst[i]==sts) { document.all.ItmSts[i].checked = true; }
	}
	document.all.ItemId.value = item;
}
//==============================================================================
//populate Entry Panel
//==============================================================================
function popItmStsPanel()
{	
	var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"

	for(var i=0; i < ItmStsLst.length; i++)
	{
  		panel += "<tr><td class='Prompt' nowrap><input name='ItmSts' type='radio' value='" + ItmStsLst[i] + "'></td>"
      		+ "<td class='Prompt' nowrap>" + ItmStsLst[i]
      		+ "<input type='hidden' name='ItemId'>"
      		+ "</td>"
    	+ "</tr>"
	}

	panel += "<tr>";
	panel += "<td class='Prompt1' colspan=2><br><br><button onClick='ValidateItmSts(&#34;Chg_Itm_Sts&#34;)' class='Small'>Submit</button>&nbsp;"
	panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
	panel += "</table>";

	return panel;
}
//==============================================================================
// populate Control Status from dropdown menu
//==============================================================================
function setCtlSts(ddmenu)
{
    var i = ddmenu.selectedIndex;
    if(ddmenu.options[i].value != "")
    {
      document.all.CtlSts.value = ddmenu.options[i].value;
    }
}
//==============================================================================
// add item comments
//==============================================================================
function addItmComments(item, sku, id, text, action)
{
   var hdr = "SKU " + sku + " Comments";
   var html = "<table border=0 cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
      + "<tr><td class='Prompt' colspan=2>" + popItemCommentsPanel(item, sku, id, text, action) + "</td></tr>"
   + "</table>"
   
   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 40;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 95;
   document.all.dvItem.style.visibility = "visible";   
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popItemCommentsPanel(item, sku, id, text, action)
{
  var panel = "<table border=1 cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td ><textarea name='Comm' cols=100 rows=5></textarea>"
          + "<input name='CommId' type='hidden'>"
          + "</td>"
       + "</tr>"

  panel += "<tr><td><br><br><button onClick='ValidateItemCommt(&#34;ADD_ITM_COMMENT&#34;, &#34;" + item + "&#34;)' class='Small'>Add Comments</button>&nbsp;"
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
//get PO Items
//==============================================================================
function getPOItem(action)
{	
	var error = false;
	var msg = "";
	
	var po = document.all.SelPO.value.trim();
	if(isNaN(po)){ error=true; msg="PO is not numeric." }
	else if(po==""){ error=true; msg="Please type PO#." }
	else if(po=="0"){ error=true; msg="Please type PO#." }
	else
	{
	   var l = po.length;
	   for(var i=0; i < 10-l; i++)
	   {
		   po = "0" + po;
	   }
	}
	
	if(error){ alert(msg); }
	else
	{		
		getVenSku(action, po, null);
	}
}

//==============================================================================
//get PO Items
//==============================================================================
function getDocItem(action)
{	
	var error = false;
	var msg = "";
			
	var doc = document.all.SelDoc.value.trim();
	if(isNaN(doc)){ error=true; msg="Documnet is not numeric." }
	else if(doc==""){ error=true; msg="Please type Document#." }
	else if(doc=="0"){ error=true; msg="Please type Document#." }
	else
	{
	   var l = doc.length;
	   for(var i=0; i < 10-l; i++)
	   {
		   doc = "0" + doc;
	   }
	}
	
	var str = document.all.SelStr.value.trim();
	if(isNaN(str)){ error=true; msg +="\nIssuing Store is not numeric." }
	else if(str==""){ error=true; msg +="\nPlease type Issuing Store." }
	else if(str=="0"){ error=true; msg +="\nPlease type Issuing Store." }	
			
	if(error){ alert(msg); }
	else{ getVenSku(action, doc, str); }
}
//==============================================================================
// show vendor Items
//==============================================================================
function getVenSku(action, sel, iss_str)
{	
	DocNum = null;
	PoNum = null;
	var str = Store;
	if(Store.length == 1){ str = "0" + str; }
	var url = "RtvSkuVenLst.jsp?Str=" + str + "&Ven=" + Vendor
	 + "&Action=" + action;
	
	if(action == "PO_ITEM")
	{ 		
		url +="&PO=" + sel;
		PoNum = sel;
	}
	if(action == "DOC_ITEM")
	{ 		
		url +="&Doc=" + sel + "&IssStr=" + iss_str;		
		DocNum = sel;
	}
	           
	window.frame1.location.href = url;	
}

//==============================================================================
//get sku for selected vendor
//==============================================================================
function showVenSku(cls, ven, sty, clr, siz, desc, vst, sku, inv, upc, onrtv, onmos
		, poqty, poqtyrem, pocost, clrnm, siznm, action)
{
	var hdr = "Item List";
	    
	   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popItem(cls, ven, sty, clr, siz, desc, vst, sku, inv
	    		, upc, onrtv, onmos, poqty, poqtyrem,pocost, clrnm, siznm)
	     + "</td></tr>"
	   + "</table>"

	   document.all.dvItem.innerHTML = html;
	   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 10;
	   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 205;
	   document.all.dvItem.style.visibility = "visible";
	   
	   if(CtlReas!="RTV Merchandise")
	   {
		   var reas = document.all.tdReas;
		   
		   for(var i=0; i < reas.length; i++){ reas[i].style.display = "none"; }
	   }
	   var commt = document.all.tdCommt;
	   for(var i=0; i < commt.length; i++){ commt[i].style.display = "none"; }
}
//==============================================================================
//populate Entry Panel
//==============================================================================
function popItem( cls, ven, sty, clr, siz, desc, vst, sku, inv, upc, onrtv, onmos
		, poqty, poqtyrem, pocost, clrnm, siznm )
{	
	var panel = "<div id='dvInt' class='dvInternal' style='width=1100px'>" 
	  + "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
	panel += "<tr class='trHdr01'>"
    + "<th class='th02' >Sel<br><input type='checkbox' onclick='javascript: selAllItems(&#34;" + sku.length + "&#34;, this)'></th>"
    + "<th class='th02' >Long Item Number</th>"
    + "<th class='th02' >Short SKU</th>"
    + "<th class='th02' >UPC</th>"    
    + "<th class='th02' >Description</th>"
    + "<th class='th02' >Vendor Style</th>"
    + "<th class='th02' >Color</th>"
    + "<th class='th02' >Size</th>"
    + "<th class='th02' >On-Hand</th>"
    
    if(poqty != null)
    {
    	panel += "<th class='th02' >PO<br>Qty</th>"
    	 + "<th class='th02' >PO Qty<br>Received</th>"
    	 + "<th class='th02' >PO<br>Cost</th>"
    }	
    
    panel += "<th class='th02' >Rtv Qty</th>"
    + "<th class='th02' id='tdReas'>Defective</th>"
    + "<th class='th02' id='tdCommt' >Comment</th>"
    + "<th class='th02' >Error</th>"
  + "</tr>"
  
  for(var i=0; i < sku.length; i++)
  {
	var setreasfunc = "setItmReas";
	if(CtlReas!="RTV Merchandise")
    {
		setreasfunc = "setItmReasQuick";
    }
	
  	panel += "<tr class='trDtl07'>"
  	  + "<td class='td11' >" 
  	  	+ "<input name='SelSku" + i + "' value='"+ sku[i] +"' type='checkbox'"
  	  	+ " onclick='if(this.checked){" + setreasfunc + "(&#34;" + i + "&#34;)}'>"
  	  + "</td>"
  	  + "<td class='td11' nowrap>" + cls[i] + "-" + ven[i] + "-" + sty[i]  + "-" + clr[i]  + "-" + siz[i] + "</td>"
  	  + "<td class='td18' >" + sku[i] + "</td>"
  	  + "<td class='td18' >" + upc[i] + "</td>"
  	  + "<td class='td11' >" + desc[i] + "</td>"
  	  + "<td class='td11' >" + vst[i] + "</td>"
  	  + "<td class='td11' >" + clrnm[i] + "</td>"
  	  + "<td class='td11' >" + siznm[i] + "</td>"
  	  + "<td class='td11' >" + inv[i] 
  	     + "<input name='Inv"+ i + "' value='" + inv[i] + "' type='hidden'>"
  	     + "<input name='OnRtv"+ i + "' value='" + onrtv[i] + "' type='hidden'>"
  	     + "<input name='OnMos"+ i + "' value='" + onmos[i] + "' type='hidden'>"
  	  + "</td>"
  	  
  	if(poqty != null)
	{
	  	panel += "<td class='td11'>" + poqty[i]  + "<input name='PO"+ i + "' value='" + PoNum + "' type='hidden'></td>"
	  	 + "<td class='td11' >" + poqtyrem[i] + "</td>"
	  	 + "<td class='td11' >" + pocost[i] + "</td>"
	}
  	
  	panel += "<td class='td11' ><input name='Qty" + i + "' value='1' size=5 maxlength=3";
  	  
  	if(inv[i]=="1"){ panel += " type='hidden'"; }
  	  
  	panel += ">&nbsp;</td>"
  	  	+ "<td class='td11' id='tdReas'>"
  	    	+ "<input name='selItmReasNm" + i + "' size=20 maxlength=20 readonly>"
  	    	+ "<input name='selItmReas" + i + "' type='hidden'>"
  		+ "</td>"
  		//+ "<td class='td11' ><input name='SelItmDef" + i + "' size=1 maxlength=1 readonly></td>"
  		+ "<td class='td11' id='tdCommt'><input name='SelItmCommt" + i + "' size=12 maxlength=50 readonly readonly>"
  		+ "<td class='tdError1' id='tdErr" + i + "' nowrap>&nbsp;</td>"
  	  + "</tr>";
  }  
	panel += "</table>";	   
	panel += "</div>";
	
	panel += "<button onClick='vldVenSku(&#34;" + sku.length + "&#34;)' class='Small'>Submit</button>&nbsp;"
		panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button>"
	return panel;
}
//==============================================================================
//validate selected sku from Vendor SKU list
//==============================================================================
function vldVenSku(numofsku)
{
	var error=false;
		
	var sku = new Array();
	var reason = new Array();
	var defect = new Array();
	var comment = new Array();
	var qty = new Array();
	
	for(var i=0; i < numofsku; i++)
	{
		var skuobjnm = "SelSku" + i; 
		var skuobj = document.all[skuobjnm];
		var errnm = "tdErr" + i;
		var tderr = document.all[errnm];
		tderr.innerHTML = "";		 
		var br = "";
		
		var invnm = "Inv" + i;
		NewStrQty = document.all[invnm].value;	
		var onrtvnm = "OnRtv" + i;
		NewOnRtv = document.all[onrtvnm].value;
		var onmosnm = "OnMos" + i;
		NewOnMos = document.all[onmosnm].value;
		NewRemind = eval(NewStrQty) - eval(NewOnRtv) - eval(NewOnMos);
		
		if( skuobj.checked )
		{	
			var qtyobjnm = "Qty" + i; 
			var qtyobj = document.all[qtyobjnm];
			if(isNaN(qtyobj.value.trim()) || eval(qtyobj.value.trim()) <= 0){ error = true; tderr.innerHTML += br + "Qty is not numeric."; br = "<br>"; }
			else if(eval(qtyobj.value.trim()) > eval(NewRemind)){ error = true; tderr.innerHTML += br + "Qty is greater then available."; br = "<br>"; }
			else{qty[qty.length] = qtyobj.value.trim(); }
						
			var reasobjnm = "selItmReas" + i; 
			var reasobj = document.all[reasobjnm];
			if(CtlReas == "RTV Merchandise" 
			    && reasobj.value.trim() == "" || reasobj.value.trim() == "NONE")
			{
				error = true; tderr.innerHTML += br + "Please select Reason."; br = "<br>";
			}
			
					
			var defobjnm = "SelItmDef" + i; 
			var defobj = "N";
			var commtnm = "SelItmCommt" + i; 
			var commtobj = document.all[commtnm];
			
			sku[sku.length] = skuobj.value;
			if(CtlReas == "RTV Merchandise"){ reason[reason.length] = reasobj.value; }
			else{ reason[reason.length] = "SAME"; }
			defect[defect.length] = defobj.value;
			comment[comment.length] = commtobj.value;			
		}		
	}
	
	if(error){alert("Fix problems");}
	else
	{ 
		hidePanel();
		saveRtventry( sku, reason, comment, defect, qty, "ADD_ITEM"); 
	}
}
//==============================================================================
// select all items on panel
//==============================================================================
function selAllItems(numofsku, sel)
{
	var check = true;
	if(!sel.checked){ check = false;}
	
	for(var i=0; i < numofsku; i++)
	{
		var skuobjnm = "SelSku" + i; 
		var skuobj = document.all[skuobjnm];
		skuobj.checked = check;
	}	
}
//==============================================================================
//show PO number selection list
//==============================================================================
function showPoError( msg )
{
	   var hdr = "Item List";
	    
	   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel2();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + msg
	     + "</td></tr>"
	   + "</table>"

	   document.all.dvPoList.innerHTML = html;
	   document.all.dvPoList.style.width = 300;
	   document.all.dvPoList.style.pixelLeft= document.documentElement.scrollLeft + 200;
	   document.all.dvPoList.style.pixelTop= document.documentElement.scrollTop + 125;
	   document.all.dvPoList.style.visibility = "visible";	      
}
//==============================================================================
// set item quatity and reasons without prompt
//==============================================================================
function setItmReasQuick(arg)
{
	var qty = "Qty" + arg; 
	document.all[qty].value = "1";
	
	var reas = "selItmReas" + arg; 
	document.all[reas].value = "SAME";	
	var reasnm = "selItmReasNm" + arg; 
	document.all[reasnm].value = "Same";
	
	var commt = "SelItmCommt" + arg;
	document.all[commt].value = "";			
}
//==============================================================================
//set Item reason
//==============================================================================
function setItmReas(arg)
{
	var sku = "SelSku" + arg;
	
	var hdr = "RTV Attribute. SKU: " + document.all[sku].value;
	    
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	   + "<tr>"
	     + "<td class='BoxName' nowrap>" + hdr + "</td>"
	     + "<td class='BoxClose' valign=top>"
	       +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel1();' alt='Close'>"
	     + "</td></tr>"
	  + "<tr><td class='Prompt' colspan=2>" + popItmReas(arg)
	   + "</td></tr>"
	+ "</table>"

	document.all.dvReason.innerHTML = html;
	document.all.dvReason.style.width=400
	document.all.dvReason.style.pixelLeft= document.documentElement.scrollLeft + 220;
	document.all.dvReason.style.pixelTop= document.documentElement.scrollTop + 180;
	document.all.dvReason.style.visibility = "visible";
	
	document.all.SelReas.options[0] = new Option("--- Select Defective Code ---", "NONE");
	for (var i = 0; i < Reason.length; i++)
	{
		document.all.SelReas.options[i+1] = new Option(Reason[i], Reason[i]);
	}
 	
	var invnm = "Inv" + arg;
	if(document.all[invnm].value == "1"){document.all.SelQty.readOnly = true;}
	
	NewStrQty = document.all[invnm].value;	
	var onrtvnm = "OnRtv" + arg;
	NewOnRtv = document.all[onrtvnm].value;
	var onmosnm = "OnMos" + arg;
	NewOnMos = document.all[onmosnm].value;
	NewRemind = eval(NewStrQty) - eval(NewOnRtv) - eval(NewOnMos);
	
	document.all.spnOnHand.innerHTML = NewStrQty; 
	document.all.spnOnRtv.innerHTML = NewOnRtv;
	document.all.spnOnMos.innerHTML = NewOnMos;
	document.all.spnRemind.innerHTML = NewRemind;
	
	document.all.trCommt.style.display="none";
}
//==============================================================================
//populate Entry Panel
//==============================================================================
function popItmReas(i)
{
	var panel =  "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
	if(CtlReas=="RTV Merchandise")
	{
		panel += "<tr class='trDtl03'>"
			+ "<td class='td11' >Defective:</td>"
			+ "<td class='td11' ><select name='SelReas'></select></td>"   		
	 	+ "</tr>"
	}
	panel += "<tr class='trDtl03' style='display:none;'>"
		+ "<td class='td11' >Defective Item:</td>"
		+ "<td class='td11' ><input name='SelDefect' type='checkbox' value='Y'></td>"   		
	 + "</tr>"
	 panel += "<tr class='trDtl03'>"
		+ "<td class='td11' >RTV Qty:</td>"
		+ "<td class='td11' ><input name='SelQty' value='1' size=5 maxlength=3></td>"   		
	 + "</tr>"
	 + "<tr class='trDtl03' id='trRemain'>"
		+ "<td class='td11' colspan=2>"
	    	+ "OnHand: <span id='spnOnHand'></span> &nbsp; &nbsp; &nbsp; "
 			+ "On RTV: <span id='spnOnRtv'></span> &nbsp; &nbsp; &nbsp; "
 			+ "On MOS: <span id='spnOnMos'></span> &nbsp; &nbsp; &nbsp; "
 			+ "Remainder: <span id='spnRemind'></span>" 
 	    + "</td"
 	 + "</tr>"	 
	 + "<tr class='trDtl03' id='trCommt'>"
		+ "<td class='td11' >Comment:</td>"
		+ "<td class='td11' ><input name='SelCommt' maxlength='50' size='50'></td>"   		
	 + "</tr>"
	 ; 
         
	panel += "<tr class='trDtl03'>" 
	   + "<td class='td11' colspan=7><br><br><button onClick='setSelIImReas(&#34;" + i +"&#34;)' class='Small'>Update</button>&nbsp;"
	panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel1();' class='Small'>Close</button></td></tr>"
	panel += "</table>";
	   
	panel += "</form>";
	return panel;
}
//==============================================================================
//display comment for other reason code
//==============================================================================
function chgItmSelReas(reas)
{
	if(reas.value == "P")
	{
		document.all.trCommt.style.display = "block";
		document.all.SelCommt.focus();
	}
	else
	{
		document.all.trCommt.style.display = "none";
	}
}
//==============================================================================
//set Selected reason and defective item
//==============================================================================
function setSelIImReas(i)
{
	var error = false;
	var msg = " ";	
		
	if(CtlReas=="RTV Merchandise")
	{
		var reasCode = document.all.SelReas.options[document.all.SelReas.selectedIndex].value;	
		var reasCodeNm = document.all.SelReas.options[document.all.SelReas.selectedIndex].text;	
		if(document.all.SelReas.selectedIndex == 0){error = true;msg += "\nPlease select Defective Code.";}
	}
	
	//var def = "SelItmDef" + i;
	//document.all[def].value = "N"	 
	//if(document.all.SelDefect.checked){ document.all[def].value = "Y"; }	
	
	var commt = "SelItmCommt" + i;
	document.all[commt].value = document.all.SelCommt.value;
	
	var commt = "SelItmCommt" + i;
	document.all[commt].value = document.all.SelCommt.value;
	
	var newqty = document.all.SelQty.value.trim();
	if(newqty == "" || newqty == 0){ error = true;msg += "\nPlease enter quantity."; }
	else if(isNaN(newqty)){ error = true;msg += "\nQuantity is not numeric value."; }
	else if(eval(newqty) > eval(NewRemind)){ error = true; msg += "\nQuantity is greater then available.The remainder quantity is " + NewRemind + "; " }
	
	if(error){ alert(msg);}
	else
	{
		if(CtlReas=="RTV Merchandise")
		{
			var reas = "selItmReas" + i; document.all[reas].value = reasCode;	
			var reasnm = "selItmReasNm" + i; document.all[reasnm].value = reasCodeNm;
		}
		else
		{
			var reas = "selItmReas" + i; document.all[reas].value = "SAME";	
			var reasnm = "selItmReasNm" + i; document.all[reasnm].value = "Same";
		}
		var qty = "Qty" + i; document.all[qty].value = newqty;
		
		hidePanel1(); 
	}
}
//==============================================================================
//hide panel
//==============================================================================
function hidePanel1()
{
	document.all.dvReason.style.visibility = "hidden";
}
//==============================================================================
//hide panel
//==============================================================================
function hidePanel2()
{
	document.all.dvPoList.style.visibility = "hidden";
}
//==============================================================================
//change Control Number item properties
//==============================================================================
function chgCtlItm(action, item, sku, qty)
{
   PoNum = null;
   var hdr = "Add Item";
   if(action=="DLT_ITEM"){ hdr = "Delete Item"; }
   if(action=="UPD_ITEM"){ hdr = "Update Item"; }
    
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popCtlItmPanel(action)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.width = "400px";
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 200;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";
    
   if(CtlReas=="RTV Merchandise"){ popReason(); }
   
   if(action=="DLT_ITEM" || action=="UPD_ITEM")
   {
	   document.all.Search.readOnly = true;
	   document.all.Search.value = sku;
	   document.all.trCommt.style.display = "none";
	   if(action=="DLT_ITEM") { document.all.trQty.readOnly = true;}
	   document.all.Qty.value = qty;
	   document.all.SvQty.value = qty;
	   document.all.ItmId.value = item;
	   
	   search = getScannedItem(sku);
	   document.all.spnOnHand.innerHTML = NewStrQty; 
	   document.all.spnOnRtv.innerHTML = NewOnRtv;
	   document.all.spnOnMos.innerHTML = NewOnMos;	   
	   document.all.spnRemind.innerHTML = NewRemind; 
   }
   if(action=="ADD_ITEM")
   {
	   document.all.Qty.value = "1";
	   document.all.SvQty.value = "0";
   }
   
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popCtlItmPanel(action)
{
  var panel = ""; 
  if(action=="DLT_ITEM")
  {
	  panel += "Are You shure that you want delete this item?"
  }
  
  panel += "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
     +  "<tr class='trHdr03'><td class='td33'>Sku/UPC</td>"
            + "<td class='td32' nowrap colspan=2><input class='Small' name='Search'>"
            + "&nbsp; &nbsp; <span id='spnDesc'></span>"
            + "<input type='hidden' name='ItmId'>"
            + "</td>"
     + "</tr>"
  
  panel += "<tr class='trHdr03' id='trQty' ><td class='td33'>Quantity</td>"
         + "<td class='td32' nowrap colspan=2>" 
             + "<input class='Small' name='Qty' size=10 maxlength=5>"  
             + "<input type='hidden' name='SvQty'>"
         + "</td>"
         
  panel += "<tr class='trHdr03' id='trOnHand' nowrap><td class='td33' colspan=3>" 
    	+ "OnHand: <span id='spnOnHand'></span> &nbsp; "
    	+ "On RTV: <span id='spnOnRtv'></span> &nbsp; "
    	+ "On MOS: <span id='spnOnMos'></span> &nbsp; "
    	+ "Remainder: <span id='spnRemind'></span>" 
    + "</td>"
     
       
  if(CtlReas=="RTV Merchandise")
  {
	  panel += "<tr class='trHdr03' id='trReas'><td class='td33' nowrap>Defective</td>"
            + "<td class='td33'><input class='Small' name='Reason' size=20 readonly></td>"
            + "<td class='td33'><select class='Smal' name='SelReas' onchange='setReason(this)'></select></td>"
       + "</tr>"
  }

  panel += "<tr class='trHdr03' style='display:none;'><td class='td33' nowrap>Defective</td>"
            + "<td class='td32' colspan=2 ><input type='checkbox' name='Defect' value='Y'></td>"
       + "</tr>"
       
  panel += "<tr class='trHdr03' id='trCommt' ><td class='td33'>Comment</td>"
       + "<td class='td32' nowrap colspan=2><input class='Small' name='Comment' size=100 maxlength=50>"
       + "</td>"
    + "</tr>"
 
      // ----- buttons ---------
      panel += "<tr class='trHdr03'>";
      // add
      panel += "<td class='td33' colspan='3'><br><br><button onClick='ValidateItm(&#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"
      panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
      panel += "</table>";
  return panel;
}
 
//==============================================================================
// populate dropdown menu for item issues
//==============================================================================
function popReason()
{
   document.all.SelReas.options[0] = new Option("--- Select Reason Code ---", "");
   for(var i=0; i < Reason.length; i++)
   {
      document.all.SelReas.options[i+1] = new Option( Reason[i] ,Reason[i]);
   }
}
//==============================================================================
// populate Reason Code from dropdown menu
//==============================================================================
function setReason(ddmenu)
{
    var i = ddmenu.selectedIndex;
    if(ddmenu.options[i].value != "")
    {
      document.all.Reason.value = ddmenu.options[i].value;
    }
}
      
//==============================================================================
// validate Item changes
//==============================================================================
function ValidateItm(action)
{
	var error = false;
	var msg = " ";
	
	var reason = "SAME";
	
	if(CtlReas=="RTV Merchandise" && action != "DLT_ITEM")
	{  
	    var reason = document.all.Reason.value.trim();
	}    
	
	var defect = " ";
	if (document.all.Defect.checked) defect = document.all.Defect.value;  
	  
	var search = document.all.Search.value.trim();
	
	var comment = " ";
	if(action != "DLT_ITEM")
	{
		comment = document.all.Comment.value.trim();	
    	if(comment==null || comment==""){comment=" ";}
	}
	else{ comment="The " + search + " has been deleted."; }	
    
    if(action != "ADD_ITEM")
    {
    	search = document.all.ItmId.value;
    }
	
	// search by sku
	if(search == "") { error = true; msg = "The search is empty. Please, enter valid SKU or UPC number.\n" }	
	else if(isNaN(search)){ error = true; msg = "The search is invalid. The value must be numeric.\n"; }
	else if(action == "ADD_ITEM")
	{
		search = getScannedItem(search)
		if(search == "") { error = true; msg = "Item is not found on System.\n" }
		else {  document.all.Search.value = NewSku; document.all.spnDesc.innerHTML = NewDesc; }
	}
	
	if(NewVen != Vendor) { error = true; msg += "The Vendor on Sku is not same as on Control.\n" }	
	
	var qty = document.all.Qty.value.trim();
	var svqty = document.all.SvQty.value.trim();
	var rem = eval(NewRemind) - (-1 * eval(svqty));
	
	if(qty == "") { error = true; msg += "The quantity is empty. Please, enter quantity.\n" }	
	else if(isNaN(qty)){ error = true; msg += "The quantity is invalid. The value must be numeric.\n"; }
	else if(eval(qty) > rem) 
	{
		error = true; msg += "Selected quantity is greater than quantity remaind. The remainder quantity is " + NewRemind + ".\n"; 
	}
	
	
	document.all.spnOnHand.innerHTML = NewStrQty; 
	document.all.spnOnRtv.innerHTML = NewOnRtv;
	document.all.spnOnMos.innerHTML = NewOnMos;
	document.all.spnRemind.innerHTML = NewRemind; 
	
	if(reason==null || reason==""){ msg += "Please select Reason.\n"; error = true; }

	if (error) alert(msg);
	else
	{
		saveRtventry( [search], [reason], [comment], [defect], [qty], action);
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
	var qty = null;
	var onrtv = null;
	 
	
	var url = "RtvCtlValidItem.jsp?Item=" + item
		+ "&Str=" + Store;

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
    		
    		valid = parseElem(resp, "UPC_Valid") == "true";
		    NewSku = parseElem(resp, "SKU");
    		NewStrQty = parseElem(resp, "QTY");    		
    		NewOnRtv = parseElem(resp, "OnRTV");
    		NewOnMos = parseElem(resp, "OnMOS");
    		NewRemind = eval(NewStrQty) - eval(NewOnRtv) - eval(NewOnMos);    		
    		NewDesc = parseElem(resp, "DESC");    		
    		NewVen = parseElem(resp, "VEN");
    		
    		//clearInterval( progressIntFunc );
    		//document.all.dvWait.style.visibility = "hidden";
 		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return NewSku;
}
//==============================================================================
//parse XML elements
//==============================================================================
function parseElem(resp, tag )
{
	var taglen = tag.length + 2;
	var beg = resp.indexOf("<" + tag + ">") + taglen;
	var end = resp.indexOf("</" + tag+ ">");
	return resp.substring(beg, end);
}
//==============================================================================
// submit Item changes
//==============================================================================
function saveRtventry(search, reason, commt, defect,qty, action )
{
	var nwelem = window.frame1.document.createElement("div");
	nwelem.id = "dvSbmSku"

	var html = "<form name='frmAddSku'"
  		+ " METHOD=Post ACTION='RtvCtlSv.jsp'>"
  		+ "<input class='Small' name='Ctl'>"
  		+ "<input class='Small' name='PO'>"
  		+ "<input class='Small' name='Str'>"
  	
  	for(var i=0; i < search.length; i++)
  	{	
  		html += "<input class='Small' name='Sku'>"
    	+ "<input class='Small' name='Reas'>"
  		+ "<input class='Small' name='Dft'>"
  		+ "<input class='Small' name='ICmt'>"
  		+ "<input class='Small' name='Qty'>"
  	}	
  		
  	html += "<input class='Small' name='Action'>"  	    
  	    + "<input class='Small' name='User'>"
  	 + "</form>";

	nwelem.innerHTML = html;
	
	window.frame1.document.appendChild(nwelem);
		
	window.frame1.document.all.Ctl.value = CtlNum;
	
	window.frame1.document.all.PO.value = " ";
	if(PoNum != null){window.frame1.document.all.PO.value = PoNum;}
	
	window.frame1.document.all.Str.value = Store;		
	
	for(var i=0; i < search.length; i++)
  	{	
		if(search.length > 1)
  	    { 	
			window.frame1.document.all.Sku[i].value = search[i];
			window.frame1.document.all.Reas[i].value = reason[i];
			window.frame1.document.all.Dft[i].value = defect[i];
			window.frame1.document.all.ICmt[i].value = commt[i];
			window.frame1.document.all.Qty[i].value = qty[i];
  	    }
		else
		{
			window.frame1.document.all.Sku.value = search[i];
			window.frame1.document.all.Reas.value = reason[i];
			window.frame1.document.all.Dft.value = defect[i];
			window.frame1.document.all.ICmt.value = commt[i];
			window.frame1.document.all.Qty.value = qty[i];
		}
  	}
	
	window.frame1.document.all.Action.value = action;
	window.frame1.document.all.User.value = User;
	
	window.frame1.document.frmAddSku.submit();
   
    hidePanel()
}
//==============================================================================
// check email
//==============================================================================
function checkEmail(email)
{
   var good = true;
   var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
   if (!filter.test(email))
   {
     good = false;
   }
   return good;
}
//==============================================================================
// Add Claim comments
//==============================================================================
function ValidateClmCommt(action)
{
   var comm = document.all.Comm.value;
   comm = comm.replace(/\n\r?/g, '<br />');   

   var commArr = new Array();
   for(var i=0, j=0, k=0, m=0, n=0; i < comm.length; i++)
   {
      if(comm.substring(i, i+1) == " "){ k++; }
      else { k=0; }

      if( m == 100 ) { j++;  m=0; }

      // no more than 1 blank
      if(k < 2 && n < 2)
      {
         commArr[j] += comm.substring(i, i+1);
         m++;
      }
   }

   // save first line of comments
   sbmNewComm(action, "0000000000", comm, "0000000000");
}
//==============================================================================
// Add Item comments
//==============================================================================
function ValidateItemCommt(action, sku)
{
   var comm = document.all.Comm.value;
   comm = comm.replace(/\n\r?/g, '<br />');
   var commid = document.all.CommId.value;

   var commArr = new Array();
   for(var i=0, j=0, k=0, m=0, n=0; i < comm.length; i++)
   {
      if(comm.substring(i, i+1) == " "){ k++; }
      else { k=0; }

      if( m == 100 ) { j++;  m=0; }

      // no more than 1 blank
      if(k < 2 && n < 2)
      {
         commArr[j] += comm.substring(i, i+1);
         m++;
      }
   }

   // save first line of comments
   sbmNewComm(action, sku, comm, commid);
}
//==============================================================================
// refresh Claim
//==============================================================================
function sbmNewComm(action, sku, comment, commid)
{
   var nwelem = window.frame1.document.createElement("div");
   nwelem.id = "dvSbmCommt"

   var html = "<form name='frmAddComment'"
       + " METHOD=Post ACTION='RtvCtlSv.jsp'>"
       + "<input class='Small' name='Ctl'>"
       + "<input class='Small' name='Sku'>"       
       + "<input class='Small' name='Commt'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Ctl.value = CtlNum;
   window.frame1.document.all.Sku.value=sku;
   window.frame1.document.all.Commt.value=comment;
   window.frame1.document.all.Action.value=action;

   //alert(html)
   window.frame1.document.frmAddComment.submit();
   hidePanel();
}
//==============================================================================
// validate ctl status
//==============================================================================
function ValidateCtlSts(action)
{
   var error = false;
   var msg = "";
   var CtlSts = null;

   for(var i=0; i < document.all.CtlSts.length; i++)
   {
      if( document.all.CtlSts[i].checked ) { CtlSts = document.all.CtlSts[i].value.trim(); break; }
   }

   if(error){ alert(msg); }
   else { sbmCtlSts(CtlSts, action) }
}
//==============================================================================
// submit ctl status
//==============================================================================
function sbmCtlSts(sts, action)
{
    var url = "RtvCtlSv.jsp?"
     + "&Ctl=" + CtlNum
     + "&Sts=" + sts
     + "&Action=" + action

   //alert(url)
   window.frame1.location.href = url;
   hidePanel()
}
//==============================================================================
//validate ctl status
//==============================================================================
function ValidateItmSts(action)
{
	var error = false;
	var msg = "";
	var sts = null;

	for(var i=0; i < document.all.ItmSts.length; i++)
	{
   		if( document.all.ItmSts[i].checked ) { sts = document.all.ItmSts[i].value.trim(); break; }
	}
	var item = document.all.ItemId.value;
	

	if(error){ alert(msg); }
	else { sbmItmSts(item, sts, action) }
}
//==============================================================================
//submit item status
//==============================================================================
function sbmItmSts(item, sts, action)
{
 	var url = "RtvCtlSv.jsp?"
  		+ "&Ctl=" + CtlNum
  		+ "&Sku=" + item
  		+ "&Sts=" + sts
  		+ "&Action=" + action

	//alert(url)
	window.frame1.location.href = url;
	hidePanel()
}
//==============================================================================
// refresh Claim
//==============================================================================
function refreshClaim(clm, ord)
{
   var url = "RtvCtlInfo.jsp?Order=" + ord + "&Claim=" + clm
   window.location.href = url;
}

//==============================================================================
// load item photo
//==============================================================================
function loadPhoto(item)
{
   var html = ""
     + "<table width='100%' cellPadding='0' cellSpacing='0'>"
           + "<tr>"
       + "<td class='BoxName' nowrap>Add Photo</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
           + "<tr colspan='2'>"
           + "<td align=center>"
           + "<form name='Upload'  method='post' enctype='multipart/form-data' action='RtvCtlLoad.jsp'>"
               + "<input type='File' name='Doc' class='Small1' size=50><br>"
               + "<input type='hidden' name='Ctl'>"
               + "<input type='hidden' name='Item' >"
               + "<input type='hidden' name='FileName'>"
           + "</form>"
           + "</td></tr>"
           + "<tr colspan='2'>"
           + "<td align=center>"
           + "<button name='Submit' class='Small' onClick='sbmUpload()'>Upload</button> &nbsp; "
           + "<button name='Cancel' class='Small' onClick='hidePanel();'>Cancel</button>"
           + "</td></tr>"
     + "</table>"

  //alert(html)
  document.all.dvItem.innerHTML=html;
  document.all.dvItem.style.width = 200;
  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 250;
  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 200;
  document.all.dvItem.style.visibility="visible"

  document.Upload.Ctl.value = CtlNum;
  document.Upload.Item.value = item;
  document.Upload.Doc.focus();
}

//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
// submit Upload
//==============================================================================
function sbmUpload()
{
  var error = false;
  var msg = "";
  var file = document.Upload.Doc.value.trim();
  document.Upload.FileName.value = file;
  if(file == "")
  {
     error = true;
     msg = "Please type full file path"
  }
  if (error) { alert(msg);}
  else
  {
    document.Upload.submit();
  }
}
  
//==============================================================================
// retreive ctl comments
//==============================================================================
function rtvCtlComments()
{
   var url = "RtvCtlCommt.jsp?Ctl=" + CtlNum
     + "&Action=Hdr_Comment"
   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// set ctl comments
//==============================================================================
function setCtlComments(commid, line, type, commt, hide, recusr, recdt, rectm)
{
   if(commid.length > 0)
   {
	   var panel = "<table id='tblCtlCmt' border=0 width='100%' cellPadding='0' cellSpacing='0'>"
    		panel += "<tr class='trHdr01'>"    	    
    	    + "<th class='th02' >User, Date, Time</th>"
    	    + "<th class='th02' >Control Comments</th>"    	    
    	  + "</tr>"
    	  
       var svCommt = commid[0];
       var dcom = new Array();
       dcom[0] = "";
       var drec = new Array();
       drec[0] = recusr[0] + ", " + recdt[0] + ", " + rectm[0];
       
       for(var i=0, j=0; i < commid.length; i++)
       {
    	   if(svCommt != commid[i])    	   
    	   {    		   
    		   svCommt = commid[i];
    		   j++;
    		   dcom[j] = "";
    		   drec[j] = recusr[i] + ", " + recdt[i] + ", " + rectm[i];
    	   }
    	   
    	   dcom[j] += commt[i];           
       }
    	  
       for(var i=0; i < dcom.length; i++)
       {
    	   panel += "<tr class='trDtl07'>"    		
    	   panel +="<td class='td11' style='width:15%' nowrap>" + drec[i] + "</td>"
    	  	  + "<td class='td11' >" + dcom[i] + "</td>"    	  	  
       }
       panel += "</tr></table>";
	  document.all.dvCTlHdrCommt.innerHTML = panel;
   }
}
//==============================================================================
// retreive item comments
//==============================================================================
function rtvItemComments()
{
	 var url = "RtvCtlCommt.jsp?Ctl=" + CtlNum
     + "&Action=Itm_Comment"

     window.frame2.location.href = url;
}
//==============================================================================
// set item comments
//==============================================================================
function setItemComments(commid, line, type, commt, hide, recusr, recdt, rectm, item, sku, desc, vensty)
{
	if(commid.length > 0)
	{
		var panel = "<table id='tblItmCmt' border=0 width='100%' cellPadding='0' cellSpacing='0'>"
	   	panel += "<tr class='trHdr01'>"
	        + "<th class='th02' style='width:15%' >User, Date, Time</th>"
	        + "<th class='th02' >Item Comments</th>"    	    
	      + "</tr>"
	    	  
	    var svCommt = commid[0];	      
	    	      
	    var dcom = new Array();
	    dcom[0] = "";
	    var drec = new Array();
	    drec[0] = recusr[0] + ", " + recdt[0] + ", " + rectm[0];
	    
	    var ditem = new Array();
	    var dsku = new Array();
	    var dvensty = new Array();
	    var svItem = "";
	    
	    ditem[0] = item[0];	    
	    dsku[0] = sku[0];
	    dvensty[0] = vensty[0];	    
	       
	    for(var i=0, j=0; i < commid.length; i++)
	    {	
	    	if(svCommt != commid[i])    	   
	    	{
	    		svCommt = commid[i];
	    		j++;
	    		dcom[j] = "";
	    		drec[j] = recusr[i] + ", " + recdt[i] + ", " + rectm[i];
	    		ditem[j] = item[i];
	    		dsku[j] = sku[i];
	    		dvensty[j] = vensty[i];
	    	}	
	    	
	    	dcom[j] += commt[i];           
	    }
	    
	    
	    svItem = ditem[0];
	    panel += "<tr class='trHdr04'>"
	        + "<th class='th02' id='tdItem" + ditem[0] + "' colspan=2>SKU: " + dsku[0] + " Style: " + dvensty[0] + "</th>"
	      + "</tr>"  
	    
	    for(var i=0; i < dcom.length; i++)
	    {
	    	if(svItem != ditem[i])    	   
	    	{
	    		panel += "<tr class='trHdr04'>"
	    	        + "<th class='th02' id='tdItem" + ditem[i] + "' colspan=2>SKU: " + dsku[i] + " Style: " + dvensty[i] + "</th>"
	    	      + "</tr>"
	    	      svItem = ditem[i];
	    	}
	    	
	    	panel += "<tr class='trDtl07'>"    		
	    	panel +="<td class='td11'  nowrap>" + drec[i] + "</td>"
	    	 	  + "<td class='td11' >" + dcom[i] + "</td>"    	  	  
	    }
	    panel += "</tr></table>";
		document.all.dvItmComments.innerHTML = panel;
	}
}
//==============================================================================
// retreive item pictures
//==============================================================================
function rtvItemPictures()
{
	var url = "RtvCtlCommt.jsp?Ctl=" + CtlNum
    + "&Action=Itm_Photo"
    window.frame3.location.href = url;
}

//==============================================================================
// set Picture on page //item, file, recusr, recdt, rectm, item, sku, desc, vensty
//==============================================================================
function setPictures(item, pic, recusr, recdt, rectm, item, sku, desc, vensty)
{
   var html = "";
   if(pic.length > 0)
   {
      html = "<table border=1 id='tbl" + item + "Picture'><tr>";
      for(var i=0, j=0; i < pic.length; i++)
      {
         html += "<td id='tdPic" + item[i] + "'>";
         path = "RTV/" + pic[i];
         // only pictures
         if(path.toLowerCase().indexOf(".jpeg") >= 0 || path.toLowerCase().indexOf(".jpg") >= 0
            && path.toLowerCase().indexOf(".tiff") >= 0 || path.toLowerCase().indexOf(".gif") >= 0
            && path.toLowerCase().indexOf(".png") >= 0 || path.toLowerCase().indexOf(".bmp") >= 0
            && path.toLowerCase().indexOf(".svg") >= 0 || path.toLowerCase().indexOf(".vnd") >= 0
            && path.toLowerCase().indexOf(".prs") >= 0 || path.toLowerCase().indexOf(".mp") >= 0
            && path.toLowerCase().indexOf(".dv") >= 0 || path.toLowerCase().indexOf(".pw") >= 0)

         {
            html += "<img style='cursor:pointer;' src='" + path + "' width='100' height='100' alt='Click to Magnified'"
                 + " onclick='window.open(&#34;" + path + "&#34;)'"
                 + " />"
         }
         else
         {
             j++;
             html += "<a style='font-size:10px' href='" + path + "' target='_blank'>Document (" + j + ")</a><br>"
         }

         html += "<br><a class='Small' href='javascript: dltPicture(&#34;" + item[i] + "&#34;,&#34;" + pic[i] + "&#34;)'>Delete</a> &nbsp; &nbsp;"

         html += "</td>";

         var maxPic = ItemWithPic.length;
         ItemWithPic[maxPic] = vensty[i];
         PicPath[maxPic] = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/RTV/" + pic[i];

      }

      html += "</td></tr></table>";
      document.all.dvItmPictures.innerHTML += html + "<br>&nbsp;";
   }
    

   window.frame3.close();
}
//==============================================================================
// scroll to Item comments
//==============================================================================
function showPicMenu(item, sku, ven, vennm, vensty, pic, obj)
{
   var hdr = "Picture Menu";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePhotoMenu();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popPicMenuPanel(item, sku, ven, vennm, vensty, pic)
     + "</td></tr>"
   + "</table>"

   var pos = getObjPosition(obj);

   document.all.dvPhoto.innerHTML = html;
   document.all.dvPhoto.style.pixelLeft = pos[0] + 110;
   document.all.dvPhoto.style.pixelTop = pos[1] - 50;
   document.all.dvPhoto.style.visibility = "visible";

   //document.all.tblPicMenu.onmouseout = function() { hidePanel(); };
}
//==============================================================================
// populate Picture Menu
//==============================================================================
function popPicMenuPanel(item, sku, ven, vennm, vensty, pic)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0' id='tblPicMenu'>"
  panel += "<tr><td class='Prompt'>SKU: " + sku + " Style: " + vensty + "</td></tr>"
       + "<tr><td class='Prompt'><a href='" + pic + "' target='_blank'>Magnified</a></td></tr>"
       + "<tr><td class='Prompt'><a href='javascript: dltPicture(&#34;" + item + "&#34;,&#34;" + pic + "&#34;)'>Delete</a></td></tr>"
       + "<tr><td class='Prompt'>&nbsp;</td></tr>"
       + "<tr><td class='Prompt'><a href='javascript: hidePhotoMenu();'>Cancel</a></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePhotoMenu()
{
   document.all.dvPhoto.innerHTML = " ";
   document.all.dvPhoto.style.visibility = "hidden";
}
//==============================================================================
// populate Picture Menu
//==============================================================================
function dltPicture(item, filenm)
{
   var url = "RtvCtlSv.jsp?&Ctl=" + CtlNum
     + "&Sku=" + item
     + "&File=" + filenm
     + "&Action=Dlt_Itm_Photo"

   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// scroll to Item comments
//==============================================================================
function scrollToItemComm(sku)
{
   var name = "tdItem" + sku;
   var obj = document.all[name];
   if(obj != null)
   {
   		var pos = getObjPosition(obj);
   		window.scrollTo(0, pos[1]);
   }
}
//==============================================================================
// scroll to Item picture
//==============================================================================
function scrollToItemPic(sku)
{
   var name = "tdPic" + sku;
   var obj = document.all[name];
   if(obj != null)
   {
	   var pos = getObjPosition(obj);
   	   window.scrollTo(0, pos[1]);
   }
}
//==============================================================================
// send email message
//==============================================================================
function setEMail(toEmail)
{
   var hdr = "Send Claim by E-Mail";

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
   document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 250;
   document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 200;
   document.all.dvItem.style.visibility = "visible";

   document.all.ToAddr.value = toEmail;
   if(User == "vrozen"){document.all.ToAddr.value="vrozen@sunandski.com";}
   
   document.all.Subj.value = "RA Request from Retail Concepts, Inc - for RTV CN#" + CtlNum;
   document.all.Msg.value = "";
}
//==============================================================================
// populate Picture Menu
//==============================================================================
function popEMailPanel()
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt'>E-Mail Address</td></tr>"
         + "<tr><td class='Prompt'><input class='Small' size=50 name='ToAddr'></td></tr>"
       + "<tr><td class='Prompt'>Subject &nbsp;</td></tr>"
         + "<tr><td class='Prompt'><input class='Small' size=50 name='Subj'></td></tr>"
       + "<tr><td class='Prompt'>Message &nbsp;</td></tr>"
         + "<tr><td class='Prompt'><input class='Small' size=50 name='Msg'></td></tr>"
       + "<tr><td class='Prompt'>Include Claim Information</td></tr>"
         + "<tr><td class='Prompt'>"
            + "<input type='radio' name='Incl' value='Y' checked>Yes &nbsp;  &nbsp; "
            + "<input type='radio' size=50 name='Incl'  value='N'>No"
            + "</td></tr>"

       + "<tr><td class='Prompt1'>"
         + "<button class='Small' onclick='validateEMail()'>Send</button> &nbsp;"
         + "<button class='Small' onclick='hidePanel()'>Cancel</button> &nbsp;"
       + "</td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// validate email message properties
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

   var incl = document.all.Incl[0].checked;

   if(body =="" && !incl){error=true; msg="Please enter message text or(and) include Control information."}

   if(error){ alert(msg); }
   else { sbmEMail(toaddr, subj, body, incl); }
}
//==============================================================================
// send email message
//==============================================================================
function sbmEMail(toaddr, subj, body, incl)
{
	document.all.spnStsEmail.style.display = "block";
	setItmStsVis(false);
		
	var msg = "<style>"
      + " table.tbl01 { border:none; padding: 0px; border-spacing: 0; border-collapse: collapse; width:100% } "
      + " tr.trHdr01 { background: #FFE4C4; text-align:center; font-size:10px;font-weight:bold; } "
      + " th.th02 { border: darkred solid 1px;  text-align:center; vertical-align:top; font-family:Verdanda; font-size:11px; } "
      + " tr.trDtl04 { background: white; text-align:center; font-size:10px; }"
      + " tr.trDtl06 { background: #e7e7e7; text-align:center; font-size:10px; } "
      + " td.td11 {border: lightsalmon solid 1px; border-right: darkred solid 1px; text-align:left; vertical-align:middle; padding: 3px; } "
      + " td.td12 { border: lightsalmon solid 1px; border-right: darkred solid 1px; text-align:right; vertical-align:middle; padding: 3px; } "
      + " td.td18 { border: lightsalmon solid 1px; border-right: darkred solid 1px; text-align:center; vertical-align:middle; padding: 3px; } "
      + " td.td46 { border: none; text-align:right; vertical-align:middle; padding: 3px; } "
      + " td.td45 { border: none; text-align:left; vertical-align:middle; padding: 3px; } " 
      + " #cellLink { display:none; }"
      + " #trLinks1 { display:none; }"
      + " #trBotton1 { display:none; }"
      + " #tblCtlCmt { display:none; }"
      + " #tblItmCmt { display:none; }"
      + " #trDFI { display:none; }"
      + " #tdDFI { display:none; }"
      + " #trInstr { display:none; }"
      + " #tdInstr { display:none; }"
      + " #tblInstr { display:none; }"
      + " .spnItmStsEmail { display:none; }"
      + " .spnItmStsEmail { display: block; }"      
      + " .NonPrt  { display:none; } "      

  msg += "</style> <body>";
  
  document.all.dvCTlHdrCommt.innerHTML="";

  document.all.spnHdrImg.innerHTML = "Sun & Ski Patio";
  msg += " " + document.all.tblClaim.outerHTML
   //+ "<br>" + document.all.tblClaimPic.outerHTML;

  var nwelem = window.frame2.document.createElement("div");
  nwelem.id = "dvSbmCommt"

  var html = "<form name='frmSendEmail'"
       + " METHOD=Post ACTION='RtvCtlSendEMail.jsp'>"
       + "<input class='Small' name='MailAddr'>"
       + "<input class='Small' name='CCMailAddr'>"
       + "<input class='Small' name='FromMailAddr'>"
       + "<input class='Small' name='Subject'>"
       + "<input class='Small' name='Message'>"
       + "<input class='Small' name='Ctl'>"
       + "<input class='Small' name='Commt'>"

   //ItemWithPic[ItemWithPic.length] = "patio_logos1.jpg"
   //PicPath[PicPath.length] = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/MainMenu/patio_logos1.jpg";   
    	          
   for(var i=0; i < ItemWithPic.length; i++)
   {
     html += "<input type='hidden' name='ItemAttach' value='" + ItemWithPic[i] + "'>"
     html += "<input type='hidden' name='PicAttach' value='" + PicPath[i] + "'>"     
   }
       
       
   html += "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   window.frame2.document.appendChild(nwelem);

   window.frame2.document.all.MailAddr.value = toaddr;

   // send on store mail account
   var ccmail = "";
   //if(StrAllowed.indexOf("ALL") >= 0){ ccmail = "<%=sUser%>@sunandski.com"; }
   //else { ccmail = "Store" + StrAllowed + "@sunandski.com"; }
   //ccmail += ", pmeyer@sunandski.com, kknight@sunandski.com";
   
   window.frame2.document.all.CCMailAddr.value = ccmail;

   var str = Store;
   if(Store.length==1){ str = "0" + Store; }
   var frAddr = "Store" + str + "@sunandski.com"
   window.frame2.document.all.FromMailAddr.value = frAddr;
   window.frame2.document.all.Subject.value = subj;

   if(body != "" && incl)
   {
      msg = "<div style='color:blue; font-size:14px;'>" + body + "</div>"
          + "<br><hr /><br>" + msg;
   }
   else if(body != "" && !incl){ msg = body; }

   msg += "</body>";
   window.frame2.document.all.Message.value=msg;
   
   //alert(msg)
   window.frame2.document.frmSendEmail.submit();
   hidePanel();
   document.all.spnStsEmail.style.display = "none";

   var text = "E-mail message was sent to " + toaddr
      + "<br>Subject: " + subj
      + "<br>Message: " + body; 
   sbmNewComm("ADD_CLM_COMMENT", "0000000000", text);
}
//==============================================================================
// show Log Entries
//==============================================================================
function rtvLogEntires()
{
   var url = "RtvCtlLog.jsp?"
     + "Ctl=" + CtlNum
   //alert(url)
   window.frame4.location.href = url;
}
//==============================================================================
// show Log Entries
//==============================================================================
function setLogSts(type, item, sku, vensty, sts, recusr, recdt, rectm)
{
	if(item.length > 0)
	   {
		   var panel = "<table id='tblAllLog' border=0 width='100%' cellPadding='0' cellSpacing='0'>"
	    		panel += "<tr class='trHdr01'>"    	    
	    	    + "<th class='th02' >Type</th>"
	    	    + "<th class='th02' >Control<br>Status</th>"
	    	    + "<th class='th02' >Sku</th>"
	    	    + "<th class='th02' >Vendor<br>Style</th>"
	    	    + "<th class='th02' >Item<br>Status</th>"
	    	    + "<th class='th02' >User</th>"
	    	    + "<th class='th02' >Date</th>"
	    	    + "<th class='th02' >Time</th>"
	    	  + "</tr>"
	    	  
	       for(var i=0; i < item.length; i++)
	       {
	    	   panel += "<tr class='trDtl07'>"    		
	    	   panel +="<td class='td11'>" + type[i] + "</td>"
	    	   
	    	   if(type[i]=="Ctl"){ panel +="<td class='td11'>" + sts[i] + "</td>" }
	    	   else { panel +="<td class='td11'>&nbsp;</td>" }
	    	   
	    	   panel += "<td class='td11' >" + sku[i] + "</td>"
	    	  	+ "<td class='td11' >" + vensty[i] + "&nbsp;</td>"
	    	  	
	    	   if(type[i]!="Ctl"){ panel +="<td class='td11'>" + sts[i] + "</td>" }
		       else { panel +="<td class='td11'>&nbsp;</td>" }
	    	  	
	    	   panel += "<td class='td11' >" + recusr[i] + "</td>"
	    	   panel += "<td class='td11' >" + recdt[i] + "</td>"
	    	   panel += "<td class='td11' >" + rectm[i] + "</td>"	    	  	
	       }
	       panel += "</tr></table>";
		  document.all.dvLog.innerHTML = panel;
		  document.all.tblCtlLog.style.pageBreakBefore = "always";
	   }	
}
//==============================================================================
//print
//==============================================================================
function print_onclick() {
    window.print();	
    return false;
}
//==============================================================================
// set status as link or string
//==============================================================================
function setItmStsVis(show)
{
	var ldisp = "block";
	var edisp = "none";
	if(!show)
	{
		ldisp = "none";
		edisp = "block";
	}
	
	if(typeof spnItmSts === 'string')
	{
		document.all.spnItmSts.style.display = ldisp;
		document.all.spnItmStsEmail.style.display = edisp;
	}
	else
	{
		var lspn = document.all.spnItmSts;
		var espn = document.all.spnItmStsEmail;
		for(var i=0; i < lspn.length; i++)
		{
			lspn[i].style.display = ldisp;
			espn[i].style.display = edisp;
		}
	}
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<title>RTV Ctl Entry</title>

<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame2"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame3"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame4"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvPoList" class="dvItem"></div>
<div id="dvPhoto" class="dvItem"></div>
<div id="dvHelp" class="dvHelp"></div>
<div id="dvReason" class="dvItem"></div>
<!-------------------------------------------------------------------->
   <table  class="tbl01" id="tblClaim" width="100%" >
     <tr>       
      <td ALIGN="center" VALIGN="TOP"nowrap>      
      <span id="spnHdrImg"><img src="Sun_ski_logo4.png" height="50px" alt="Sun and Ski Patio"></span>
      <br>RTV Control Number Entry
      <br>
       </b>
       </td>       
      </tr>

    <tr class="NonPrt">
      <td ALIGN="center" VALIGN="TOP" colspan="3">
        <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        <a href="RtvCtlSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page.
        &nbsp;&nbsp;&nbsp;
      </td>
    </tr>
    <tr>
      <td ALIGN="left" VALIGN="TOP"  colspan="3" nowrap>
<!-------------------------------------------------------------------->
<!-- Order Header Information ->
<!-------------------------------------------------------------------->
   <table class="tbl01" >
     <tr class="trDtl04">
     	<td class="td11" nowrap>Status: 
     	    <span id="spnSts"><a href="javascript: chgStatusMenu();"><%=sCtlSts%></a></span>
     	    <span id="spnStsEmail"><%=sCtlSts%></span>
     	</td>
     	<td class="td11" nowrap>Reason: <b><%=sCtlReas%></b> </td>
        <td class="td11" nowrap>Control Number: <b><%=sSelCtl%></b> </td>        
     </tr>   
     <tr class="trDtl04">     	
     	<td class="td11" nowrap>Created On: <%=sCtlDt%> / <%=sCtlTm%></td>
     	<td class="td11" nowrap>Comment: <%=sName%> </td>
     	<td class="td11">Store: <%=sStr%></td>
     </tr>  
     <tr class="trDtl04">
     	<td class="td11" nowrap>By User: <%=sCtlUsr%></td>
     	<td class="td11" nowrap>&nbsp;</td>
     	<td class="td11" nowrap>&nbsp;</td>
     </tr>
     <tr class="trDtl04" id="trDFI">
       <td class="td18" id="tdDFI" nowrap>&nbsp;</td>
       <td class="td11" id="tdDFI" nowrap colspan=2>DFI Allowance: <%=sVenAlwRt%></td>
     </tr> 
     
     <tr  class="trDtl04" id="trInstr">
        <td class="td18" id="tdInstr" nowrap>&nbsp;</td>
     	<td class="td11" id="tdInstr" colspan=2>
     		<table border=0  id="tblInstr">
     	      <tr class="trDtl04">
     	       <td class="td46">Instructions:</td>
     	       <td class="td45"><%=sVenInstC%></td>
     	      </tr>
     	      <tr class="trDtl04">
     	       <td class="td46">&nbsp;</td>
     	       <td class="td45"><%=sVenInstR%></td>
     	      </tr>
     		</table>       
     </tr>		
     <tr  class="trDtl04">
     	<td class="td11"  colspan=3>
     		<table class="tbl01">
     	      <tr class="trDtl04">
     	       <td class="td45" width="5%" nowrap>Vendor Info:</td> 
     	       <td class="td45" colspan=3><%=sVen%></td>
     	      </tr>
     	      <tr class="trDtl04">
     	       <td class="td46">Name:</td><td class="td45" colspan=3><b><%=sVenNm %></b></td>
     	      </tr>
     	      <tr class="trDtl04">
     	       <td class="td46">Address:</td><td class="td45" colspan=3><%=sVenAddr1%></td>
     	      </tr class="trDtl04">
     	      <tr class="trDtl04">
     	       <td class="td46">&nbsp;</td><td class="td45" colspan=3><%=sVenAddr2%>
     	         <%if(!sVenAddr3.equals("")){%>, <%=sVenAddr3%><%}%>
     	       </td>
     	      </tr>
     	      <tr class="trDtl04">
     	       <td class="td46">Contact:</td><td class="td45"><%=sVenCont%>
     	        &nbsp; &nbsp; &nbsp; Phone#: <%=sVenPhn%> 
     	        &nbsp; &nbsp; &nbsp; Email: <%=sVenEmail%></td>
     	      </tr>     	    
     	    </table>
     	</td>     	
     </td>      
   </table>
   
 <!----------------------- end of table ------------------------>
     </td>
   </tr>
    <tr id="trBotton1">
      <td ALIGN="left" VALIGN="TOP"  colspan="3" nowrap>   
           <button class="Small" onClick="setEMail('<%=sVenEmail%>');">Email Vendor</button>&nbsp;
           <button class="Small" onClick="addCtlHdrCommt(0,null,'ADD');">Add Comments</button> &nbsp;
           <button class="Small" onClick="print_onclick();">Print</button> &nbsp;         
      </td>
    </tr>

    <!----------------------- Claim Comments ------------------------>
    <tr  class="NonPrt">
      <td colspan=3 align=left><br><div id="dvCTlHdrCommt" style="width:100%;"></div><br>&nbsp;</td>
    </tr>
    <!----------------------- Purchased Item List ----------------------------->
    <tr id="trLinks1">
      <td colspan=3> <a href="javascript: chgCtlItm('ADD_ITEM', null, null, null)">Add Sku</a> &nbsp; &nbsp; &nbsp;
      <a href="javascript: getVenSku('VEN_ITEM', null, null)">On Hand List</a> &nbsp; &nbsp; &nbsp;
      
      PO#: <input name="SelPO" class="Small" size=11 maxlength=10> <a href="javascript: getPOItem('PO_ITEM')">PO Item List</a> &nbsp; &nbsp; &nbsp;
      Doc#: <input name="SelDoc"  size=6 maxlength=5 class="Small"> Str: <input name="SelStr" class="Small" size=3 maxlength=2> <a href="javascript: getDocItem('DOC_ITEM')">Document Item List</a> &nbsp; &nbsp; &nbsp;
      </td>
    </tr>
    <tr>
      <td colspan=3>
         <table class="tbl01"  width="100%">
           <tr class="trHdr01">
              <th class="th02" rowspan=2 nowrap>Short SKU<br>UPC</th>
              <th class="th02" rowspan=2 nowrap>Vendor Style<br>Reason</th>
              <th class="th02" rowspan=2 nowrap>Color</th>
              <th class="th02" rowspan=2 nowrap>Size</th>
              <th class="th02" rowspan=2 nowrap>Desctription</th>
              <th class="th02" rowspan=2 nowrap>QTY</th>
              <th class="th02" rowspan=2 nowrap>Cost</th>
              <th class="th02" rowspan=2 nowrap>Ext.<br>Cost</th>
              <th class="th02" rowspan=2 nowrap>Status</th>  
              <th class="th02" id="cellLink" nowrap>Comments</th>
              <th class="th02" id="cellLink" nowrap>Photo</th>
              <th class="th02" id="cellLink" rowspan=2 nowrap>Upd</th>
              <th class="th02" id="cellLink" rowspan=2 nowrap>D<br>l<br>t</th>             
           </tr>
           <tr class="trHdr01">
           		<th class="th02" id="cellLink">Add</th>
           		<th class="th02" id="cellLink">Add</th>           		
           </tr>
            
           <%String sCss1="trDtl04";%>
           <%while(ctlinfo.getNext())
       	    { 
       		ctlinfo.setDetail();
       		String sItmId = ctlinfo.getItmId();
       		String sSku = ctlinfo.getSku();
       		String sReas = ctlinfo.getReas();
       		String sMos = ctlinfo.getMos();
       		String sRecal = ctlinfo.getRecal();
       		String sDefect = ctlinfo.getDefect();
       		String sItmSts = ctlinfo.getItmSts();
       		String sRaNum = ctlinfo.getRaNum();
       		String sDocNum = ctlinfo.getDocNum();
       		String sRecUsr = ctlinfo.getRecUsr();
       		String sRecDt = ctlinfo.getRecDt();
       		String sRecTm = ctlinfo.getRecTm();
       		String sDesc = ctlinfo.getDesc();
       		String sVenSty = ctlinfo.getVenSty();		 
       		String sUpd = ctlinfo.getUpd();
       		String sQty = ctlinfo.getQty();
    		String sCost = ctlinfo.getCost();
    		String sExtCost = ctlinfo.getExtCost();
    		String sClrNm = ctlinfo.getClrNm();
    		String sSizNm = ctlinfo.getSizNm();
       		%>
              <tr class="<%=sCss1%>">
                 <td class="td11" nowrap><%=sSku%></td>
                 <td class="td11" nowrap><%=sVenSty%></td>
                 <td class="td11" nowrap><%=sClrNm%></td>
                 <td class="td11" nowrap><%=sSizNm%></td>
                 <td class="td11" nowrap><%=sDesc%></td>
                 <td class="td12" nowrap><%=sQty%></td>
                 <td class="td11" nowrap>$<%=sCost%></td>                 
                 <td class="td11" nowrap>$<%=sExtCost%></td>
                 
                 <td class="td11" nowrap>
                    <span id="spnItmSts"><a href="javascript: chgItmStsMenu('<%=sItmId%>','<%=sSku%>','<%=sItmSts%>')"><%=sItmSts%></a></span>
                    <span id="spnItmStsEmail"><%=sItmSts%></span>
                 </td>
                 <td class="td18" id="cellLink" rowspan=2 nowrap><a href="javascript: addItmComments('<%=sItmId%>', '<%=sSku%>', 0, null, 'ADD_ITEM_COMMT')">Add</a></td>
                 <!-- td class="td18" rowspan=2 nowrap><a href="javascript: scrollToItemComm('<%=sItmId%>')"><img style="border:none;"  src="Comments_Img1.bmp" width="15" height="20" alt="Show Comments" /></a></td-->
                 <td class="td18" id="cellLink" rowspan=2 nowrap><a href="javascript: loadPhoto('<%=sItmId%>')">Add</a></td>
                 <!-- td class="td18" rowspan=2 nowrap><a href="javascript: scrollToItemPic('<%=sItmId%>', '<%=sSku%>')"><img style="border:none;"  src="Camera_Img.jpg"  width="40" height="25" alt="Add Photo" /></a></td -->
                 <td class="td18" id="cellLink" rowspan=2 nowrap><a href="javascript: chgCtlItm('UPD_ITEM','<%=sItmId%>', '<%=sSku%>', '<%=sQty%>')">Upd</a></td>
                 <td class="td18" id="cellLink" rowspan=2 nowrap><a href="javascript: chgCtlItm('DLT_ITEM','<%=sItmId%>', '<%=sSku%>', '<%=sQty%>')">D</a></td>
              </tr>    
              <tr class="<%=sCss1%>">
                 <td class="td12" nowrap><%=sUpd%>&nbsp;</td>
                 <td class="td12" nowrap><%=sReas%></td>
                 <td class="td11" nowrap>&nbsp;</td> 
                 <td class="td11" nowrap>&nbsp;</td>
                 <td class="td11" nowrap>&nbsp;</td>
                 <td class="td11" nowrap>&nbsp;</td>
                 <td class="td11" nowrap>&nbsp;</td>
                 <td class="td11" nowrap>&nbsp;</td>
                 <td class="td11" nowrap>&nbsp;</td>
              </tr>
              <%if(sCss1.equals("trDtl06")) { sCss1="trDtl04"; } else { sCss1="trDtl06"; }%>
           <%}%>
           <!----------------------- end of table ------------------------>
           <%
           	  ctlinfo.setItemTotal();
       		  String sQty = ctlinfo.getQty();
       	      String sExtCost = ctlinfo.getExtCost();	
           %>
           <tr class="trDtl15">
               <td class="td11" nowrap colspan=5>Total</td>
               <td class="td12" nowrap><%=sQty%></td>
               <td class="td12" nowrap>&nbsp;</td>
               <td class="td11" nowrap>$<%=sExtCost%></td>
               <td class="td12" nowrap colspan=5>&nbsp;</td>
           </tr>      
         </table>
      </td>
    </tr>
    <!----------------------- end of table ------------------------>

    <!----------------------- Item Comments ------------------------>
    <tr class="NonPrt">
      <td colspan=3 align=left><br><div id="dvItmComments" style="width:100%;"></div>
      </td>
    </tr>
    </table>
    <!----------------------- Item Pictures ------------------------>
    <table border=0 cellPadding="0"  cellSpacing="0" id="tblClaimPic">
        <tr  class="NonPrt">
           <td colspan=3 align=left><br><div id="dvItmPictures" style="width:100%;"></div>
        </td>
    </tr>
   </table>

   <!----------------------- Item Pictures ------------------------>
    <table border=0 cellPadding="0"  cellSpacing="0" id="tblCtlLog">
        <tr  class="NonPrt">
           <td><br><div id="dvLog" style="width:100%;"></div>
        </td>
    </tr>
 
 
   </table>

 </body>
</html>
<%
ctlinfo.disconnect();
ctlinfo = null;
}
%>






