<%@ page import="onhand01.ItemBsrEdit_v2, java.util.*"%>
<%
   String sDivision = request.getParameter("Div");
   String sDepartment = request.getParameter("Dpt");
   String sClass = request.getParameter("Cls");
   String sVendor = request.getParameter("Ven");
   String sSelSty = request.getParameter("Sty");  
   String sSelBsrLvl = request.getParameter("BsrLvl"); 
   String sFrLastRcvDt = request.getParameter("FrLastRcvDt");
   String sToLastRcvDt = request.getParameter("ToLastRcvDt");
   String sFrLastSlsDt = request.getParameter("FrLastSlsDt");
   String sToLastSlsDt = request.getParameter("ToLastSlsDt");
   String sFrLastMdnDt = request.getParameter("FrLastMdnDt");
   String sToLastMdnDt = request.getParameter("ToLastMdnDt");
   String sPermMdn = request.getParameter("PermMdn");
   String sNeverOuts = request.getParameter("NeverOuts");
   String sRrn = request.getParameter("Rrn");
   String sPageSize = request.getParameter("PageSize");
    
   if(sDivision == null) { sDivision = "ALL"; }
   if(sDepartment == null) { sDepartment = "ALL"; }
   if(sClass == null) { sClass = "ALL"; }
   if(sClass == null) { sVendor = "Vendor"; }
   if(sSelSty == null) { sSelSty = "ALL"; }
   if(sRrn == null){ sRrn = "0";}
   if(sPageSize == null){ sPageSize = "30";}
   
   long lStartTime = (new Date()).getTime();
    
   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sAppl = "TRANSFER";
   String sStrAllowed = "";

   //System.out.println(session.getAttribute("USER") + " appl: " + session.getAttribute("APPLICATION"));
   if (session.getAttribute("USER")==null
    || session.getAttribute("APPLICATION") !=null
    && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     Enumeration  en = request.getParameterNames();
     String sParam =null;
     String sPrmValue = null;
     String sTarget = "PayrollSignOn.jsp?TARGET=ItemBsrEdit_v2&APPL=" + sAppl;
     StringBuffer sbQuery = new StringBuffer() ;

     while (en.hasMoreElements())
      {
        sParam = en.nextElement().toString();
        sPrmValue = request.getParameter(sParam);
          sbQuery.append("&" + sParam + "=" + sPrmValue);
      }

      response.sendRedirect(sTarget + sbQuery.toString());
   }
   else {
     sStrAllowed = session.getAttribute("STORE").toString().trim();
     if (!sStrAllowed.startsWith("ALL"))
     {
        response.sendRedirect("ItemBsrEditSel_v2.jsp");
     }
  
     //System.out.println("ItemBsrEdit_v2.jsp" + sDivision + "|" + sDepartment + "|" + sClass + "|" + sVendor + "|"
     //  + sSelSty + "|" + sBatch + "|" + sBComment);
     ItemBsrEdit_v2 itemLst = new ItemBsrEdit_v2(sDivision, sDepartment, sClass, sVendor, sSelSty
    	, sSelBsrLvl, sFrLastRcvDt, sToLastRcvDt, sFrLastSlsDt, sToLastSlsDt, sFrLastMdnDt, sToLastMdnDt
    	, sPermMdn, sNeverOuts, sRrn,sPageSize);

     int iNumOfCVS = itemLst.getNumOfCVS();
     int iNumOfStr = itemLst.getNumOfStr();
     String [] sStr = itemLst.getStr();
     String sStrJSA = itemLst.getStrJSA();
     
     boolean bEof = itemLst.getEof();
     String sLastRrn = itemLst.getLastRrn();     
     
     //System.out.println( "Batch=" + sBatch + "|" + sBComment);
    
   // color code for transfer items
   String [] sColor = new String[]{"255 255 0", "0 255 0",
                                   "255 105 180", "180 150 255",
                                   "255 69 0", "0 191 255"
                                   };         
    
%>

<html>
<head>
<title>Item BSR(new)</title>
<style>body {background: ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: ivory solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: ivory solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: Seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background: Cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable3 { background: #ccccff; font-family:Arial; font-size:10px }
        tr.DataTable4 { background: #ccffcc; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; text-align:left;}
        td.DataTable3 { padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        text-align: center;}
        td.DataTable4 { padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: double darkred; border-right: darkred solid 1px;
                        text-align:left;}
        td.DataTable5 { padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: double darkred; border-right: darkred solid 1px;
                        text-align:left;}
        td.DataTable6 { background:moccasin;   padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        text-align:left;}

        td.DataTable7 { background:moccasin; padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: double darkred; border-right: darkred solid 1px;
                        text-align:center;}
        td.DataTable8 { background:moccasin;   padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; text-align:left;}
        td.DataTable9 { background:moccasin; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable10 { padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        text-align:left;}
        td.DataTable11 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                         visibility:hidden;  text-align:right;}
        td.DataTable12 { padding-top:3px; padding-bottom:3px;padding-left:3px; padding-right:3px;                       
                        text-align: center;}                 
        td.DataTable13{ padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        text-align: center;}  
            

        td.StrInv { padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}

        td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}

        td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}
                    
        td.StrMin { background: #ccd1e8; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}
                    
        td.StrIdeal { background: #e0d1d0; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}
                    
         td.StrMax { background: #e2e2d0; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                     border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
                     
         td.StrMin1 { background: #e6edf7; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}
                    
        td.StrIdeal1 { background: #f9eae0; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}
                    
         td.StrMax1 { background: #f4f9e0; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                     border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}                   

        <!-------- select another div/dpt/class pad ------->
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        input.Small1 {width:20; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }

        <!-------- transfer entry pad ------->
        div.fake { }
        div.dvTransfer { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvMenu { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; background-color:Azure; z-index:10;
              text-align:center; font-size:10px}

        td.Grid  { background:darkblue; color:white; text-align:center; font-family:Arial; font-size:11px; font-weight:bolder}
        td.Grid1 { text-align:left; font-family:Arial; font-size:10px;}
        td.Grid2  { background:darkblue; color:white; text-align:right;
                    font-family:Arial; font-size:11px; font-weight:bolder}
        td.Grid3 { text-align:center; font-family:Arial; font-size:10px;}

        td.Menu {  text-align:left; font-family:Arial; font-size:10px;}


        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:100; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
              
        div.dvPrompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:300; background-color:LemonChiffon; z-index:100;
              text-align:center; font-size:10px }              

        td.BoxName {background: #016aab; padding: 3px; color:white; text-align:center;   font-size:12px; font-weight:bold } 
 		td.BoxClose {background: #016aab; padding: 3px; color:white; text-align:right;   font-size:12px; font-weight:bold }
              
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

        <!-------- end transfer entry pad ------->

</style>


<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Division ="<%=sDivision%>";
var Department ="<%=sDepartment%>";

var NumOfCVS = "<%=iNumOfCVS%>";
var Stores = [<%=sStrJSA%>];
 

var draged=false;
var disabledCell = new Array(1000);
var daCellMax = 0;

var aStrCol = new Array();

var aCellItmInvId = new Array();
var aCellCvsInvId = new Array();
var aCellItmSlsId = new Array();
var aCellCvsSlsId = new Array();
var aCellCvsSellId= new Array();

var aCellItmMinId = new Array();
var aCellItmIdealId = new Array();
var aCellItmMaxId = new Array();
var aCellCvsMinId = new Array();
var aCellCvsIdealId = new Array();
var aCellCvsMaxId = new Array();

var aItmInvByStr = new Array();
var aItmSlsByStr = new Array();
var aItmMinByStr = new Array();
var aItmIdealByStr = new Array();
var aItmMaxByStr = new Array();

var aCvsInvByStr = new Array();
var aCvsSlsByStr = new Array();
var aCvsSellByStr= new Array();

var aCvsMinByStr = new Array();
var aCvsIdealByStr = new Array();
var aCvsMaxByStr = new Array();

var SelCls = null;
var SelVen = null;
var SelSty = null;
var SelClr = null;
var SelSiz = null;
var SelRow = null;

var StartTime = "<%=lStartTime%>";
var EndTime = "<%=lStartTime%>";
//--------------- End of Global variables ----------------
function bodyLoad()
{  
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) {  isSafari = true; }
	
	   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvPrompt"]);
	   
	setItemByStr(); 
}
 
//==========================================================================
// set Item and CVS cell id by stores
//==========================================================================
function setItemByStr()
{
	for(var i=0; i < Stores.length; i++)
	{
		aItmInvByStr[i] = new Array();
		aItmSlsByStr[i] = new Array();
		
		aItmMinByStr[i] = new Array();
		aItmIdealByStr[i] = new Array();
		aItmMaxByStr[i] = new Array();
		
		aCvsInvByStr[i] = new Array();
		aCvsSlsByStr[i] = new Array();
		aCvsMinByStr[i] = new Array();
		aCvsIdealByStr[i] = new Array();
		
		aCvsMaxByStr[i] = new Array();
		
		aCvsSellByStr[i] = new Array();
		
		for(var j=0, k=0; j < aCellItmInvId.length; j++)
		{   
			var search = aCellItmInvId[j].substring(28);
			if(search == Stores[i])
			{
				aItmInvByStr[i][k] = aCellItmInvId[j];
				aItmSlsByStr[i][k] = aCellItmSlsId[j];
				aItmMinByStr[i][k] = aCellItmMinId[j];
				aItmIdealByStr[i][k] = aCellItmIdealId[j];
				aItmMaxByStr[i][k] = aCellItmMaxId[j];
				k++;
			}
		}
		
		for(var j=0, k=0; j < aCellCvsInvId.length; j++)
		{   
			var search = aCellCvsInvId[j].substring(19);
			if(search == Stores[i])			
			{
				aCvsInvByStr[i][k] = aCellCvsInvId[j];
				aCvsSlsByStr[i][k] = aCellCvsSlsId[j];
				aCvsMinByStr[i][k] = aCellCvsMinId[j];
				aCvsIdealByStr[i][k] = aCellCvsIdealId[j];
				aCvsMaxByStr[i][k] = aCellCvsMaxId[j];
				aCvsSellByStr[i][k] = aCellCvsSellId[j];
				k++;
			}
		}
	}
	var len = aItmInvByStr.length;
}
//==============================================================================
// Apply to all items on page 
//==============================================================================
function ApplyToAll(div, dpt, cls, ven, sty)
{
	var hdr = "Increase/Decrease for All Items on Page";
	if(cls != null && ven != null && sty != null){ hdr = "Increase/Decrease for Item" + cls + "-" + ven + "-" + sty; }
	else if(div != null){ hdr = "Increase/Decrease for Div: " + div }
	else if(dpt != null){ hdr = "Increase/Decrease for Dpt: " + dpt }
	else if(cls != null){ hdr = "Increase/Decrease for Cls: " + cls }
	

	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel1();' alt='Close'>"
	       + "</td></tr>"
	html += "<tr><td class='Prompt' colspan=2>"

	html += popApply(div, dpt, cls, ven, sty);

	html += "</td></tr></table>"
	
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.width = 250;
	document.all.dvItem.style.left = getLeftScreenPos() + 150;
	document.all.dvItem.style.top = getTopScreenPos() + 100;
	document.all.dvItem.style.visibility = "visible";
	
	if(div != null)	{ document.all.Div.value = div; }
	if(dpt != null)	{ document.all.Dpt.value = dpt; }
	if(cls != null) { document.all.Cls.value = cls; }	
	if(ven != null) { document.all.Ven.value = ven; }
	if(sty != null) { document.all.Sty.value = sty;	}
}
//==============================================================================
//populate - apply to all item on page
//==============================================================================
function popApply(div, dpt, cls, ven, sty)
{
	var panel = "<table border=1 width='100%' cellPadding='3' cellSpacing='0'>"

	 
	panel += "<tr class='DataTable4'><td class='DataTable3' nowrap>"
    panel += "Minimum: <input name='inpMin' maxlength=5 size=3>"
       + " &nbsp; Ideal: <input name='inpIdeal' maxlength=5 size=3>"
       + " &nbsp; Maximum: <input name='inpMax' maxlength=5 size=3>"
       + "<br>"
    ;   
    if(div == null && dpt == null && cls == null || ven != null){    
       panel += "&nbsp;<button onclick='VldApply(&#34;1&#34;)' >Adjust Level</button>";
    }   
    panel += "&nbsp;<button onclick='VldApply(&#34;3&#34;)' >Apply As %</button>"
    	 + '<br>(Only levels greater than <b><u>zero</u></b> will be affected)'
	panel += "</td></tr>" 

	panel += "<tr class='DataTable4'><td class='Prompt1' colspan=3>"	  
   		+ "<button onClick='hidePanel1();' class='Small'>Close</button>" 
   		+ "</td></tr>"

	panel += "</table>";
	
	if(div != null){ panel += "<input type='hidden' name='Div'>"; }
	if(dpt != null){ panel += "<input type='hidden' name='Dpt'>"; }
	if(cls != null){ panel += "<input type='hidden' name='Cls'>"; }
	if(ven != null){ panel += "<input type='hidden' name='Ven'>"; }
	if(sty != null){ panel += "<input type='hidden' name='Sty'>"; }

	return panel;
}
//==============================================================================
// validate apply to all
//==============================================================================
function VldApply(type)
{
	var error = false;
	var msg = "";
	
	var dpt = null;
	var div = null;
	var cls = null;
	var ven = null;
	var sty = null;
	
	if(document.all.Div != null) { div = document.all.Div.value; }
	if(document.all.Dpt != null) { div = document.all.Dpt.value; }
	if(document.all.Cls != null) { cls = document.all.Cls.value; }
	if(document.all.Ven != null) { ven = document.all.Ven.value; }
	if(document.all.Sty != null) {	sty = document.all.Sty.value; }
	
	var obj = " ";
	var min = document.all.inpMin.value;	
	while (min.match(obj)) { min = min.replace(obj, ""); }
	var ideal = document.all.inpIdeal.value;
	while (ideal.match(obj)) { ideal = ideal.replace(obj, ""); }
	var max = document.all.inpMax.value;
	while (max.match(obj)) { max = max.replace(obj, ""); }

	if(isNaN(min)){error=true; msg+="\nThe Minimum Quantity is not a valid number."}
	if(isNaN(ideal)){error=true; msg+="\nThe Ideal Quantity is not a valid number."}
	if(isNaN(max)){error=true; msg+="\nThe Maximum Quantity is not a valid number."}
	
	if(!error && min=="" && ideal=="" && max==""){error=true; msg+="\nAt leas one of the Quantities must be not entered."; }
		
	if(error){ alert(msg); }
	else{sbmApply(type, min, ideal, max, div, dpt, cls, ven, sty );} 
}
//==============================================================================
//submit - apply to all
//==============================================================================
function sbmApply(type, min, ideal, max, div, dpt, cls, ven, sty )
{	
	var items = aItmInvByStr[0]; 
	
	if(isIE){ nwelem = window.frame1.document.createElement("div"); }
    else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
	else{ nwelem = window.frame1.contentDocument.createElement("div");}
    
    nwelem.id = "dvSbmApplyToAll";
  	var html = "<form name='frmApplyToAll'"
      + " METHOD=Post ACTION='ItemBSRSave.jsp'>"
      + "<input name='Type'>"
      + "<input name='Min'>"
      + "<input name='Ideal'>"
      + "<input name='Max'>"
      + "<input name='Div'>"
      + "<input name='Dpt'>"
      + "<input name='Cls'>"
      + "<input name='Action'>"
    ;
   	        
    var maxi = 0; 
    var fldval = new Array();
    
    
    // save items on page or selected CVS 
    if( div == null && dpt == null && cls == null && ven == null && sty == null
        || cls != null && ven != null && sty != null)
    {			
    	for(var i=0; i < items.length;i++)
    	{
			var item = items[i];
			if(item.length > 26 && (cls==null || isSelCVS(item, cls,ven,sty)))
			{
				html += "<input name='Item'>";
				fldval[maxi] = item.substring(1,27); 
				maxi++;
			}
    	}	
    }
	 
	html += "</form>";
    
    nwelem.innerHTML = html;
    
    if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
    else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
    else if(isSafari){ window.frame1.document.body.appendChild(nwelem); }
    else{ window.frame1.contentDocument.body.appendChild(nwelem); }

    window.frame1.document.all.Type.value = type;
    window.frame1.document.all.Min.value = min;
    window.frame1.document.all.Ideal.value = ideal;
    window.frame1.document.all.Max.value = max;
    window.frame1.document.all.Action.value = "APPLY";
    
 	// save items on page or selected CVS 
    if( div == null && dpt == null && cls == null && ven == null && sty == null
        || cls != null && ven != null && sty != null)
    {
    	for(var i=0; i < maxi; i++ )
    	{
    		if(maxi == 1){ window.frame1.document.all.Item.value = fldval[i]; }
    		else{window.frame1.document.all.Item[i].value = fldval[i];}
    	}
    }   
    else // save class vendor style 
    {
    	if(div != null) { window.frame1.document.all.Div.value = div; }
    	if(dpt != null) { window.frame1.document.all.Dpt.value = dpt; }
    	if(cls != null) { window.frame1.document.all.Cls.value = cls; }
    }
 	
    if(isIE || isSafari) {window.frame1.document.frmApplyToAll.submit(); }
    else { window.frame1.contentDocument.forms[0].submit(); }	
}
//==============================================================================
// check if item is selected 
//==============================================================================
function isSelCVS(item, cls,ven,sty)
{  
	var save = false;
	
	save  = item.substring(1,5) == cls && item.substring(5, 11) == ven 
	&& item.substring(11, 18) == sty;
	
	return save;
}

//==============================================================================
//  copy from store to store 
//==============================================================================
function copyFromStr()
{
	var hdr = "Copy From/To Store (OR) Zero out Store";
	
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel1();' alt='Close'>"
	       + "</td></tr>"
	html += "<tr><td class='Prompt' colspan=2>"

	html += popFromStr();

	html += "</td></tr></table>"
	
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.width = 250;
	document.all.dvItem.style.left = getLeftScreenPos() + 450;
	document.all.dvItem.style.top = getTopScreenPos() + 100;
	document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate - copy from store to store 
//==============================================================================
function popFromStr()
{
	var panel = "<table border=0 width='100%' cellPadding='3' cellSpacing='0'>";
	 
	panel += "<tr class='DataTable4'><td class='DataTable12' nowrap><b><u>Copy DR Level:</u></b> "
	   + "</td></tr>"
	   + "<tr class='DataTable4'><td class='DataTable12' nowrap>"
       + "From Store: <input name='FrStr' id='FrStr' maxlength=2 size=4>"
       + " &nbsp; To Store: <input name='ToStr' id='ToStr' maxlength=2 size=4>"
       + "</td></tr>"
       + "<tr class='DataTable4'><td class='DataTable12' nowrap>"
       + "BSR Level: <input type='checkbox' name='Ideal' id='Ideal' value='Y'>Ideal"
       + " &nbsp; <input type='checkbox' name='Max' id='Max' value='Y'>Max"
       + " &nbsp; <input type='checkbox' name='Min' id='Min' value='Y'>Min"
       + "</td></tr>"
       + "<tr class='DataTable4'><td class='DataTable12' colspan=3>"
 	      + "<button class='Small' onclick='VldCpyFromStr()' >Copy</button>&nbsp; &nbsp; "
       + "</td></tr>"
       + "<tr class='DataTable4'><td class='DataTable12' colspan=3>"    	  
 	     + "<br>Note: This will copy levels on"
 	     + "&nbsp;<span style='color: red; font-weight: bold'>ALL</span>"
 	    + " items<br>(from initially selection!)"

    panel += "<tr class='DataTable4'><td class='DataTable10' nowrap>&nbsp;</td</tr>"
    
    panel += "<tr class='DataTable4'><td class='DataTable12' nowrap><b><u>Zero DR Level:</u></b> "
   		+ "</td></tr>"
   	    + "<tr class='DataTable4'><td class='DataTable12' nowrap>"
          + "Select Store: <input name='ZeroStr' id='ZeroStr' maxlength=2 size=4>"
          + "</td></tr>"
          + "<tr class='DataTable4'><td class='DataTable12' nowrap>"
          + "BSR Level: <input type='checkbox' name='ZeroIdeal' id='ZeroIdeal' value='Y'>Ideal"
          + " &nbsp; <input type='checkbox' name='ZeroMax' id='ZeroMax' value='Y'>Max"
          + " &nbsp; <input type='checkbox' name='ZeroMin' id='ZeroMin' value='Y'>Min"
        + "</td></tr>"
        + "<tr class='DataTable4'><td class='DataTable12' colspan=3>"
	      + "<button class='Small' onclick='VldZeroLevel()' >Zero Level</button>&nbsp; &nbsp; "
   	    + "</td></tr>"
   	    + "<tr class='DataTable4'><td class='DataTable12' colspan=3>"    	  
    	  + "<br>Note: This will zero levels on"
    	  + "&nbsp;<span style='color: red; font-weight: bold'>ALL</span>"
    	+ " items<br>(from inititally selection) for this Store!."
    	  
    panel += "<tr class='DataTable4'><td class='DataTable13' nowrap>&nbsp;</td</tr>"	  
    panel += "<button onClick='hidePanel1();' class='Small'>Close</button>"		 
   		+ "</td></tr>"

	panel += "</table>";
	
	return panel;
}
//==============================================================================
//validate - copy from store to store 
//==============================================================================
function VldCpyFromStr()
{
	var error = false;
	var msg = "";
	
	var frStr = document.getElementById("FrStr").value.trim();
	var toStr = document.getElementById("ToStr").value.trim();
	
	if(frStr == "" ){error=true; msg +="\nPlease enter From Store number.";}
	else if( isNaN(frStr) ){error=true; msg +="\nFrom Store number is invalid.";}
	else if( eval(frStr) <= 0 ){error=true; msg +="\nFrom Store number m/b positive.";}
	
	if(toStr == "" ){error=true; msg +="\nPlease enter To Store number.";}
	else if( isNaN(toStr) ){error=true; msg +="\nTo Store number is invalid.";}
	else if( eval(toStr) <= 0 ){error=true; msg +="\nTo Store number m/b positive.";}
	
	var ideal = "N";
	if(document.getElementById("Ideal").checked){ ideal = "Y"; }
	
	var max = "N";
	if(document.getElementById("Max").checked){ max = "Y"; }
	
	var min = "N";
	if(document.getElementById("Min").checked){ min = "Y"; }
		 
	if(ideal != "Y" && max != "Y" && min != "Y" ){error=true; msg +="\nPlease select BSR Level.";}
	
	if(error){ alert(msg); }
	else{sbmCpyFromStr( frStr, toStr, ideal, max, min );} 
}
//==============================================================================
//submit - copy from store to store 
//==============================================================================
function sbmCpyFromStr(frStr, toStr, ideal, max, min)
{
	hidePanel1();
	
	var url ="ItemBSRSave.jsp?Div=<%=sDivision%>" 
		  + "&Dpt=<%=sDepartment%>" 
		  + "&Cls=<%=sClass%>" 
		  + "&Ven=<%=sVendor%>"
		  + "&Sty=<%=sSelSty%>"
		  + "&BsrLvl=<%=sSelBsrLvl%>"
		  + "&FrLastRcvDt=<%=sFrLastRcvDt%>"
		  + "&ToLastRcvDt=<%=sToLastRcvDt%>"
		  + "&FrLastSlsDt=<%=sFrLastSlsDt%>"
		  + "&ToLastSlsDt=<%=sToLastSlsDt%>"
		  + "&FrLastMdnDt=<%=sFrLastMdnDt%>"
		  + "&ToLastMdnDt=<%=sToLastMdnDt%>"
		  + "&PermMdn=<%=sPermMdn%>"
		  + "&NeverOuts=<%=sNeverOuts%>"	  
		  + "&Rrn=<%=sLastRrn%>"
		  + "&PageSize=<%=sPageSize%>"
		  + "&FrStr=" + frStr
		  + "&ToStr=" + toStr
		  + "&BlIdeal=" + ideal
		  + "&BlMax=" + max
		  + "&BlMin=" + min		  
	      + "&Action=CpyFrmStr"
	      
	window.frame1.location.href = url;
}

//==============================================================================
//validate - copy from store to store 
//==============================================================================
function VldZeroLevel()
{
	var error = false;
	var msg = "";
	
	var zeroStr = document.getElementById("ZeroStr").value.trim(); 
	
	if(zeroStr == "" ){error=true; msg +="\nPlease enter Store number.";}
	else if( eval(zeroStr) <= 0 ){error=true; msg +="\nSelected Store number m/b positive.";}
	
	
	var ideal = "N";
	if(document.getElementById("ZeroIdeal").checked){ ideal = "Y"; }
	
	var max = "N";
	if(document.getElementById("ZeroMax").checked){ max = "Y"; }
	
	var min = "N";
	if(document.getElementById("ZeroMin").checked){ min = "Y"; }
		 
	if(ideal != "Y" && max != "Y" && min != "Y" ){error=true; msg +="\nPlease select BSR Level.";}
	
	if(error){ alert(msg); }
	else{sbmZeroLevel( zeroStr, ideal, max, min );} 
}
//==============================================================================
//submit - copy from store to store 
//==============================================================================
function sbmZeroLevel(zeroStr, ideal, max, min )
{
	hidePanel1();
	
	var url ="ItemBSRSave.jsp?Div=<%=sDivision%>" 
		  + "&Dpt=<%=sDepartment%>" 
		  + "&Cls=<%=sClass%>" 
		  + "&Ven=<%=sVendor%>"
		  + "&Sty=<%=sSelSty%>"
		  + "&BsrLvl=<%=sSelBsrLvl%>"
		  + "&FrLastRcvDt=<%=sFrLastRcvDt%>"
		  + "&ToLastRcvDt=<%=sToLastRcvDt%>"
		  + "&FrLastSlsDt=<%=sFrLastSlsDt%>"
		  + "&ToLastSlsDt=<%=sToLastSlsDt%>"
		  + "&FrLastMdnDt=<%=sFrLastMdnDt%>"
		  + "&ToLastMdnDt=<%=sToLastMdnDt%>"
		  + "&PermMdn=<%=sPermMdn%>"
		  + "&NeverOuts=<%=sNeverOuts%>"	  
		  + "&Rrn=<%=sLastRrn%>"
		  + "&PageSize=<%=sPageSize%>"
		  + "&FrStr=" + zeroStr
		  + "&ToStr=0"
		  + "&BlIdeal=" + ideal
		  + "&BlMax=" + max
		  + "&BlMin=" + min		  
	      + "&Action=ZeroStr"
	      
	window.frame1.location.href = url;
}
//==============================================================================
//show list of store 
//==============================================================================
function strSel()
{
	var hdr = "Select Store Columns";

	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel1();' alt='Close'>"
	       + "</td></tr>"
	html += "<tr><td class='Prompt' colspan=2>"

	html += popStrSel();

	html += "</td></tr></table>"
	
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.width = 250;
	document.all.dvItem.style.left = getLeftScreenPos() + 150;
	document.all.dvItem.style.top = getTopScreenPos() + 100;
	document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate store list selection
//==============================================================================
function popStrSel()
{
	var panel = "<table border=1 width='100%' cellPadding='3' cellSpacing='0'>"

	panel += "<tr class='DataTable3'>"
    + "<th nowrap>Stores</th>"
   + "</tr>"

	panel += "<tr class='DataTable4'><td nowrap>"

	for(var i=0; i < Stores.length; i++)
	{
		panel += "&nbsp;&nbsp;<input name='strsel' type='checkbox' value='" + Stores[i] + "'>" + Stores[i]
		if(i > 0 && i%15==0){ panel += "<br>"; }
	}
	panel += "&nbsp;&nbsp;<a href='javascript: setAllStr(true)'>All</a>"
	panel += "&nbsp;&nbsp;<a href='javascript: setAllStr(false)'>Reset</a>"
	panel += "</td></tr>"

	panel += "<tr class='DataTable4'><td class='Prompt1' colspan=3>"
	 + "<button onClick='showSelStr();' class='Small'>Select</button>&nbsp;"
   + "<button onClick='hidePanel1();' class='Small'>Close</button>" 
   + "</td></tr>"

	panel += "</table>";

	return panel;
}
//==============================================================================
//show selected store columns 
//==============================================================================
function showSelStr()
{
	var str = document.all.strsel;
	aStrCol = new Array();
	var itot = 0;
	for(var i=0; i < str.length; i++)
	{		
		aStrCol[i] = str[i].checked;
		
		
		var shl2 = document.getElementById("StrHdrL2" + i);
		var shInv = document.getElementById("StrInv" + i);
		var shSls = document.getElementById("StrSls" + i);
		var shMin = document.getElementById("StrMin" + i);
		var shIdeal = document.getElementById("StrIdeal" + i);
		var shMax = document.getElementById("StrMax" + i);
		  
		var aItmInv = new Array();
		
		
		if(aStrCol[i])
		{ 
			itot++;
			shl2.style.display = "block";	
			shInv.style.display = "block";
			shSls.style.display = "block";
			shMin.style.display = "block";
			shIdeal.style.display = "block";
			shMax.style.display = "block";
		 
			for(var j=0; j < NumOfCVS; j++)
			{	
				var shl3nm = "StrHdrL3" + j + "_" + i;
				var shl3 = document.all[shl3nm];				
				shl3.style.display = "block";			 
			}
			
			for(var j=0; j < aItmInv.length; j++)
			{
				document.getElementById(aItmInv[j] + j).style.display = "block";	
			}
			
			for(var j=0; j < aItmInvByStr[i].length; j++)
			{
				var celnm = aItmInvByStr[i][j];
				var celli = document.getElementById(celnm);
				var celnm = aItmSlsByStr[i][j];
				var cells = document.getElementById(celnm);
				celli.style.display = "block";
				cells.style.display = "block";
				
				var celnm = aItmMinByStr[i][j];
				var cellmin = document.getElementById(celnm);
				cellmin.style.display = "block";
				
				var celnm = aItmIdealByStr[i][j];
				var cellideal = document.getElementById(celnm);
				cellideal.style.display = "block";
				
				var celnm = aItmMaxByStr[i][j];
				var cellmax = document.getElementById(celnm);
				cellmax.style.display = "block";
			}
			for(var j=0; j < aCvsInvByStr[i].length; j++)
			{
				var celli = document.getElementById(aCvsInvByStr[i][j]);
				celli.style.display = "block";
				var cells = document.getElementById(aCvsSlsByStr[i][j]);
				cells.style.display = "block";
				var cellf = document.getElementById(aCvsSellByStr[i][j]);				
				cellf.style.display = "block";	
				
				var cellmin = document.getElementById(aCvsMinByStr[i][j]);
				cellmin.style.display = "block";
				var cellideal = document.getElementById(aCvsIdealByStr[i][j]);
				cellideal.style.display = "block";
				var cellmax = document.getElementById(aCvsMaxByStr[i][j]);
				cellmax.style.display = "block";
			}
			
		}
		else
		{
			shl2.style.display = "none";
			shInv.style.display = "none";
			shSls.style.display = "none";
			shMin.style.display = "none";
			shIdeal.style.display = "none";
			shMax.style.display = "none";

			for(var j=0; j < NumOfCVS; j++)
			{	
				var shl3nm = "StrHdrL3" + j + "_" + i;
				var shl3 = document.all[shl3nm];				
				shl3.style.display = "none";			 
			}
			
			for(var j=0; j < aItmInv.length; j++)
			{
				document.getElementById(aItmInv[j] + j).style.display = "none";	
			}
			
			for(var j=0; j < aItmInvByStr[i].length; j++)
			{
				var celnm = aItmInvByStr[i][j];
				var celli = document.getElementById(celnm);
				celli.style.display = "none";
				
				var celnm = aItmSlsByStr[i][j];
				var cells = document.getElementById(celnm);				
				cells.style.display = "none";
				
				var celnm = aItmMinByStr[i][j];
				var cellmin = document.getElementById(celnm);
				cellmin.style.display = "none";
				
				var celnm = aItmIdealByStr[i][j];
				var cellideal = document.getElementById(celnm);
				cellideal.style.display = "none";
				
				var celnm = aItmMaxByStr[i][j];
				var cellmax = document.getElementById(celnm);
				cellmax.style.display = "none";
			}
			for(var j=0; j < aCvsInvByStr[i].length; j++)
			{
				var celli = document.getElementById(aCvsInvByStr[i][j]);
				celli.style.display = "none";
				var cells = document.getElementById(aCvsSlsByStr[i][j]);				
				cells.style.display = "none";
				var cellf = document.getElementById(aCvsSellByStr[i][j]);				
				cellf.style.display = "none";
				
				var cellmin = document.getElementById(aCvsMinByStr[i][j]);
				cellmin.style.display = "none";
				var cellideal = document.getElementById(aCvsIdealByStr[i][j]);
				cellideal.style.display = "none";
				var cellmax = document.getElementById(aCvsMaxByStr[i][j]);
				cellmax.style.display = "none";
			}
		}
	}
	document.all.StrHdrL1.colSpan = itot * 3;
	hidePanel1();
}
//==============================================================================
//set store selection on/off 
//==============================================================================
function setAllStr(chk)
{
	var str = document.all.strsel;
	for(var i=0; i < str.length; i++)
	{
		str[i].checked = chk;
	}
}
//==============================================================================
//change BSR level
//==============================================================================
function chgBSR(i, cls, ven, sty, clr, siz, desc, min, ideal, max, stock, sales)
{
	SelCls = cls;
	SelVen = ven;
	SelSty = sty;
	SelClr = clr;
	SelSiz = siz;
	SelRow = i;

	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
  		+ "<tr>"
    		+ "<td class='BoxName' nowrap>Item: " + cls + "-" + ven + "-" + sty + "-" + clr + "-" + siz + "</td>"
    		+ "<td class='BoxClose' valign=top>"
      			+  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
    		+ "</td></tr>"
 		+ "<tr><td class='Prompt' colspan=2>" + popBSRPanel(desc, stock, sales)+ "</td></tr>"
	+ "</table>"

document.all.dvPrompt.innerHTML = html;
document.all.dvPrompt.style.left = getLeftScreenPos() + 100;
document.all.dvPrompt.style.top = getTopScreenPos() + 10;
document.all.dvPrompt.style.visibility = "visible";

for(var i=0; i < Stores.length; i++)
{
	   document.all.Min[i].value = min[i];
	   document.all.Ideal[i].value = ideal[i];
	   document.all.Max[i].value = max[i];
}
}

//--------------------------------------------------------
//populate Entry Panel
//--------------------------------------------------------
function popBSRPanel(desc, stock, sales)
{
var dummy = "<table>";
var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"

// Description
panel += "<tr><td class='Prompt' nowrap>Item Description:</td>"
      + "<td class='Prompt' colspan=2>" + desc + "</td></tr>";
// Store
panel += "<tr><td class='Prompt1' nowrap>Store</td>"
	     + "<td class='Prompt1' nowrap>Min</td>"
      + "<td class='Prompt1' nowrap>Ideal</td>"
      + "<td class='Prompt1' nowrap>Maximum</td>"
      + "<td class='Prompt1' nowrap>Inv</td>"
      + "<td class='Prompt1' nowrap>Sales</td>"
      + "</tr>"
      ;

	for(var i=0; i < Stores.length; i++)
	{
  		panel += "<tr><td class='Prompt1' nowrap>" + Stores[i] + "</td>"
     		+ "<td class='Prompt1'><input id='Min' class='Small' maxlength=5 size=5></td>"         
  			+ "<td class='Prompt1'><input id='Ideal' class='Small' maxlength=5 size=5></td>"
     		+ "<td class='Prompt1'><input id='Max' class='Small' maxlength=5 size=5></td>"
    	 	+ "<td class='Prompt2'>&nbsp;" + stock[i] + "</td>"
     		+ "<td class='Prompt2'>&nbsp;" + sales[i] + "</td>"
   		+ "</tr>";
	}

	// buttons
	panel += "<tr><td class='Prompt1' colspan='2'>"
     + "<button id='Submit' onClick='ValidateBSR()' class='Small'>Submit</button>&nbsp;"
     + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;&nbsp;&nbsp;"
	panel += "</td></tr></table>";

	return panel;
}

 
//--------------------------------------------------------
//show approve message for BSR zeroout action
//--------------------------------------------------------
function showZeroMsg(i, cls, ven, sty, clr, siz, desc, min, ideal, max, stock, sales)
{
	var msg = "Item: " + cls + "-" + ven + "-" + sty + "-" + clr + "-" + siz + "\n" + desc + "\n"
         + "\nAre You sure you want to delete the stock level for this item?"
	var a = confirm(msg, "Yes","No");
	if(a)
	{
	  	var min = new Array(Stores.length);
   		var ideal = new Array(Stores.length);
   		var max = new Array(Stores.length);
   		for(var i=0; i < Stores.length; i++) { ideal[i] = 0; max[i] = 0; min[i] = 0; }

   		SelCls = cls;
   		SelVen = ven;
   		SelSty = sty;
   		SelClr = clr;
   		SelSiz = siz;
   		SelRow = i;

   		NewMin = min;
   		NewIdeal = ideal;
   		NewMax = max;
   
   		SubmitBSR(min, ideal, max)
	}
}
//--------------------------------------------------------
//populate Entry Panel
//--------------------------------------------------------
function hidePanel(){ document.all.dvPrompt.style.visibility = "hidden"; }
function hidePanel1(){ document.all.dvItem.style.visibility = "hidden"; }

//--------------------------------------------------------
//Validate entry
//--------------------------------------------------------
function ValidateBSR()
{
	var min = new Array(Stores.length);
	var ideal = new Array(Stores.length);
	var max = new Array(Stores.length);
	var error=false;
	var msg = "";
	for(var i=0; i < Stores.length; i++)
	{
		min[i] = document.all.Min[i].value.trim(" ");
	  	if(min[i]=="" || min[i]==" ") { min[i]=0; }
	  	ideal[i] = document.all.Ideal[i].value.trim(" ");
   		if(ideal[i]=="" || ideal[i]==" ") { ideal[i]=0; }
   		max[i] = document.all.Max[i].value.trim(" ");
   		if(max[i]=="" || max[i]==" ") { max[i]=0; }

   		if(isNaN(min[i])){ error = true; document.all.Min[i].focus(); break; }
   		if(isNaN(ideal[i])){ error = true; document.all.Ideal[i].focus(); break; }
   		if(isNaN(max[i])){ error = true; document.all.Max[i].focus(); break; }      
	}

	NewMin = min;
	NewIdeal = ideal;
	NewMax = max;
	msg = "Entered Value is not numeric\n";
	if(error){ alert(msg) }
	else(SubmitBSR(min, ideal, max))
}

	//--------------------------------------------------------
//submit changes
//--------------------------------------------------------
function SubmitBSR(min, ideal, max)
{
	if (document.all.Submit != null) { document.all.Submit.disabled = true; } //disable submit button

	var url = "ItemBSRSave.jsp?"
    + "Cls=" + SelCls
    + "&Ven=" + SelVen
    + "&Sty=" + SelSty
    + "&Clr=" + SelClr
    + "&Siz=" + SelSiz

	for(var i=0; i < Stores.length; i++)
	{
   		url += "&Ideal=" + eval(ideal[i]) 
       	+ "&Max=" + eval(max[i])
       	+ "&Min=" + eval(min[i]);
	}
	url += "&Action=CHGBSR"

	//alert(url)
	//window.location.href=url;
	window.frame1.location.href=url;
}

 

//--------------------------------------------------------
//update line
//--------------------------------------------------------
function updateLine(error)
{
	hidePanel();
	window.frame1.close();	
	
	var color = "#efc6f4";

	for(var i=0; i < Stores.length; i++)
	{		
		var min = "imin" + SelCls + SelVen + SelSty + SelClr + SelSiz + "-" + Stores[i];
		var ideal = "iideal" + SelCls + SelVen + SelSty + SelClr + SelSiz + "-" + Stores[i];
		var max = "imax" + SelCls + SelVen + SelSty + SelClr + SelSiz + "-" + Stores[i];
		
		if(NewMin[i] > 0) 
		{	
			document.all[min].innerHTML = NewMin[i];
			document.all[min].style.backgroundColor = color;
		}
		else{document.all[min].innerHTML = "&nbsp;";}
		
	 	if(NewIdeal[i] > 0) 
	 	{	
	 		document.all[ideal].innerHTML = NewIdeal[i]; 
	 		document.all[ideal].style.backgroundColor = color;
	 	}
	 	else{document.all[ideal].innerHTML = "&nbsp;";}
	 	
  		if(NewMax[i] > 0) 
  		{	
  			document.all[max].innerHTML = NewMax[i]; 
  			document.all[max].style.backgroundColor = color;
  		}
  		else{document.all[max].innerHTML = "&nbsp;";}
	}
}
//--------------------------------------------------------------------------
//go to next page 
//--------------------------------------------------------------------------
function getNextPage()
{
	var url = "ItemBsrEdit_v2.jsp?Div=<%=sDivision%>" 
	  + "&Dpt=<%=sDepartment%>" 
	  + "&Cls=<%=sClass%>" 
	  + "&Ven=<%=sVendor%>"
	  + "&BsrLvl=<%=sSelBsrLvl%>"
	  + "&FrLastRcvDt=<%=sFrLastRcvDt%>"
	  + "&ToLastRcvDt=<%=sToLastRcvDt%>"
	  + "&FrLastSlsDt=<%=sFrLastSlsDt%>"
	  + "&ToLastSlsDt=<%=sToLastSlsDt%>"
	  + "&FrLastMdnDt=<%=sFrLastMdnDt%>"
	  + "&ToLastMdnDt=<%=sToLastMdnDt%>"
	  + "&PermMdn=<%=sPermMdn%>"
	  + "&NeverOuts=<%=sNeverOuts%>"	  
	  + "&Rrn=<%=sLastRrn%>"
	  + "&PageSize=<%=sPageSize%>"
	 ; 
	window.location.href = url;   
}
</SCRIPT>

<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe id="frame1" src=""  height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
  <div id="dvTransfer"></div>
<!-------------------------------------------------------------------->
  <div id="dvItem" class="dvItem"></div>
  <div id="dvPrompt" class="dvPrompt"></div>
<!-------------------------------------------------------------------->

    <table border="0" width="0" height="0" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">

      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Item DR (BSR) Editing
      <br>Div: <%=sDivision%> &nbsp;&nbsp
          Dpt: <%=sDepartment%> &nbsp;&nbsp
          Class: <%=sClass%> &nbsp;&nbsp
      </b>
     <tr bgColor="moccasin">
      <td ALIGN="left" VALIGN="TOP">


<!-- ------------ Legend -------------- -->
  <table border=0 cellPadding="0" cellSpacing="0">
   <tr>     
    <td style="font-size:10px;vertical-align: bottom;"> &nbsp; * - selloff percentage calculation does not include negative inventory.</td>
   </tr>
  </table >
   <!-- ----Aquamarine-------- End Legend -------------- -->

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="ItemBsrEditSel_v2.jsp">
         <font color="red" size="-1">Select Items</font></a>&#62;<font size="-1">
      This Page.
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%if(!bEof){%><a href="javascript: getNextPage()">Next Page</a><%}%>

      <!-- Change number of visible store number lines -->
      <!--  Show store numbers on every    
      <a href="javascript: redispStrLine(1)">1</a>,&nbsp;
      <a href="javascript: redispStrLine(2)">2</a>,&nbsp;
      <a href="javascript: redispStrLine(3)">3</a>,&nbsp;
      <a href="javascript: redispStrLine(4)">4</a>,&nbsp;
      <a href="javascript: redispStrLine(5)">5</a>&nbsp;
      style 
      -->
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <a href="javascript: strSel()">Store Display</a>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      
      <a href="javascript: ApplyToAll(null, null, null, null, null)">Apply to Page</a>
      <%if(!sDivision.equals("ALL")){%>&nbsp;&nbsp;&nbsp;
      	<a href="javascript: ApplyToAll('<%=sDivision%>', null, null, null, null)">Apply to Div</a>
      <%}%>
      <%if(!sDepartment.equals("ALL")){%>&nbsp;&nbsp;&nbsp;
      	<a href="javascript: ApplyToAll(null, '<%=sDepartment%>', null, null, null)">Apply to Dept</a>
      <%}%>
      <%if(!sClass.equals("ALL")){%>&nbsp;&nbsp;&nbsp;
      	<a href="javascript: ApplyToAll(null, null, '<%=sClass%>', null, null)">Apply to Class</a>
      <%}%>
      &nbsp;&nbsp;&nbsp;  
      <a href="javascript: copyFromStr()">Apply to Store</a>
      
      </font>
      
      
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" rowspan="2" colspan="2">Item Number<br>          
              <a href="javascript:colapse();">Fold/Unfold</a></th>
          <th class="DataTable"  rowspan="4">B<br>A<br>S<br>?</th>   
          <th class="DataTable" rowspan="4">Z<br>e<br>r<br>o<br>e<br>d</th> 
          <th class="DataTable" rowspan="2" colspan="3">Chain</th>
          <th class="DataTable" rowspan="4">&nbsp;</th>
          <th class="DataTable" id="StrHdrL1" colspan="<%=iNumOfStr * 3%>">Stores</th>
          <th class="DataTable" rowspan="2" colspan="2">Item Number
              <!-- >br><a href="javascript:colapse();">Fold/Unfold</a -->
          </th>
          
        </tr>

        <tr>
          <%for(int i=0; i < iNumOfStr; i++){%>             
               <th class="DataTable" id="StrHdrL2<%=i%>" colspan="3"><%=sStr[i]%></th>
          <%}%>
        </tr>

        <tr>
          <th class="DataTable" rowspan=2>Class-Ven-Sty</th>
          <th class="DataTable" rowspan=2>Clr-Size</th>

          <th class="DataTable">Min</th>
          <th class="DataTable">Ideal</th>
          <th class="DataTable">Max</th>

          <%for(int i=0; i<iNumOfStr; i++){%>             
                <th class="DataTable" id="StrMin<%=i%>">Min</th>
                <th class="DataTable" id="StrIdeal<%=i%>">Ideal</th>
                <th class="DataTable" id="StrMax<%=i%>">Max</th>
          <%}%>

          <th class="DataTable" rowspan=2>Clr-Size</th>
          <th class="DataTable" rowspan=2>Class-Ven-Sty</th>
        </tr>
        
        <tr>
          <th class="DataTable" colspan=2>Inv</th>
          <th class="DataTable">Sls</th>          

          <%for(int i=0; i<iNumOfStr; i++){%>             
                <th class="DataTable" colspan=2 id="StrInv<%=i%>">Inv</th>
                <th class="DataTable" id="StrSls<%=i%>">Sls</th>             
          <%}%>
        </tr>

<!------------------------------- Detail Data --------------------------------->	  
  <%for(int i=0; i < iNumOfCVS; i++) {
		itemLst.setItemLst();
  		itemLst.setNumOfItm();
      	int iNumOfItm = itemLst.getNumOfItm();
      	
      	itemLst.setCVS();
      	String sCvsDesc = itemLst.getDesc();
      	String sCvsRet = itemLst.getRet();
        String sCvsOrgRet = itemLst.getOrgRet();
        String sCvsSlsUnt = itemLst.getSlsUnt();
        String sCvsCost = itemLst.getCost();
        String sCvsMdDate = itemLst.getMdDate();
        String sCvsFrtRct = itemLst.getFrtRct();
        String sCvsLstRct = itemLst.getLstRct();
        String sCvsVenSty = itemLst.getVenSty();
        String [] sCvsInv = itemLst.getInv();;
    	String [] sCvsSlsQty = itemLst.getSlsQty();
    	String [] sCvsIdeal = itemLst.getIdeal();
    	String [] sCvsMinimum = itemLst.getMinimum();
    	String [] sCvsMaximum = itemLst.getMaximum();
    	String [] sCvsSts = itemLst.getSts();
    	String [] sCvsSellOff = itemLst.getSellOff();	
    	String sCvsTotSellOff = itemLst.getTotSellOff();
    	String sCvsChnInv = itemLst.getChnInv();
    	String sCvsChnSls = itemLst.getChnSls();   
    	String [] sCvsCellId = itemLst.getCellId();
    	String sCvsLstSlsDt = itemLst.getLstSlsDt();
    	String sCvsChnMin = itemLst.getChnMin();
    	String sCvsChnIdeal = itemLst.getChnIdeal();
    	String sCvsChnMax = itemLst.getChnMax();
  %>
  <!-------------------------------Item Detail ---------------------------------->
  <%for(int j=0; j < iNumOfItm; j++) {
	 	itemLst.setItemDtl(j);
  		String sCls = itemLst.getCls();
  		String sVen = itemLst.getVen();
  		String sSty = itemLst.getSty();
  		String sClr = itemLst.getClr();
  		String sSiz = itemLst.getSiz();
    
  		String [] sInv = itemLst.getInv();
  		String [] sSlsQty = itemLst.getSlsQty();
  		String [] sIdeal = itemLst.getIdeal();
  		String [] sMinimum = itemLst.getMinimum();
  		String [] sMaximum = itemLst.getMaximum();
  		String [] sSts = itemLst.getSts();
  		String sChnInv = itemLst.getChnInv();
    	String sChnSls = itemLst.getChnSls();
    	String [] sCellId = itemLst.getCellId();
    	String sBsrLvl = itemLst.getBsrLvl();
    	String sChnMin = itemLst.getChnMin();
    	String sChnIdeal = itemLst.getChnIdeal();
    	String sChnMax = itemLst.getChnMax();
    	
    	String sIdealJsa = itemLst.getIdealJsa();
    	String sMinJsa = itemLst.getMinimumJsa();
    	String sMaxJsa = itemLst.getMaximumJsa();
    	String sInvJsa = itemLst.getInvJsa();
    	String sSlsQtyJsa = itemLst.getSlsQtyJsa();    	
    	
    	//String sBsrClr = "";
    	//if(sBsrLvl.equals("N")){sBsrClr = "style=\"background: pink; \""; }
  %>
    <tr  class="DataTable">
        <td class="DataTable1" rowspan=2 nowrap>
            <%if(j==0){%><a href="javascript: ApplyToAll(null,null,'<%=sCls%>', '<%=sVen%>', '<%=sSty%>')"><%=sCls + "-" + sVen + "-" + sSty%><%} else {%>&nbsp;<%}%></a></td>		
        <td class="DataTable1" rowspan=2 nowrap>
        <a class="Small" href="javascript: chgBSR(<%=iNumOfItm%>, '<%=sCls%>', '<%=sVen%>', '<%=sSty%>', '<%=sClr%>', '<%=sSiz%>', '<%=sCvsDesc%>', [<%=sMinJsa%>], [<%=sIdealJsa%>], [<%=sMaxJsa%>], [<%=sInvJsa%>], [<%=sSlsQtyJsa%>])">
                    <%=sClr + "-" + sSiz%></a>
        </td>
        <td class="DataTable9" rowspan=2  nowrap>&nbsp;<%=sBsrLvl%></td>
        <td class="DataTable9" rowspan=2 ><button onclick="showZeroMsg(<%=iNumOfItm%>, '<%=sCls%>', '<%=sVen%>', '<%=sSty%>', '<%=sClr%>', '<%=sSiz%>', '<%=sCvsDesc%>', [<%=sMinJsa%>], [<%=sIdealJsa%>], [<%=sMaxJsa%>], [<%=sInvJsa%>], [<%=sSlsQtyJsa%>])" class="Small1">0</button></td>
        <td class="DataTable8" nowrap>&nbsp;<%=sChnMin%></td>
        <td class="DataTable8" nowrap>&nbsp;<%=sChnIdeal%></td>
        <td class="DataTable9" nowrap>&nbsp;<%=sChnMax%></td>
        <td class="DataTable9" nowrap>BSR Level</td>
        <!-- store inv & dtl on item Level -->

        <%for(int k=0; k < iNumOfStr; k++){
        	String sCellClr = "";
        %>
             
               
            <td class="StrMin" <%=sCellClr%> nowrap
                id="imin<%=sCls%><%=sVen%><%=sSty%><%=sClr%><%=sSiz%>-<%=sStr[k]%>" ><%=sMinimum[k]%>
            </td>                  
            <td class="StrIdeal"  id="iideal<%=sCls%><%=sVen%><%=sSty%><%=sClr%><%=sSiz%>-<%=sStr[k]%>">
              &nbsp;<%=sIdeal[k]%>
            </td>                 
            <td class="StrMax"  id="imax<%=sCls%><%=sVen%><%=sSty%><%=sClr%><%=sSiz%>-<%=sStr[k]%>">
              &nbsp;<%=sMaximum[k]%>
            </td>  
            
            <!-- ----------------- -->
            <script>
              aCellItmMinId[aCellItmMinId.length] = "imin<%=sCls%><%=sVen%><%=sSty%><%=sClr%><%=sSiz%>-<%=sStr[k]%>";
              aCellItmIdealId[aCellItmIdealId.length] = "iideal<%=sCls%><%=sVen%><%=sSty%><%=sClr%><%=sSiz%>-<%=sStr[k]%>";
              aCellItmMaxId[aCellItmMaxId.length] = "imax<%=sCls%><%=sVen%><%=sSty%><%=sClr%><%=sSiz%>-<%=sStr[k]%>";
            </script>                        
        <%}%>

        <td class="DataTable1" rowspan=2 nowrap><%=sClr + "-" + sSiz%></td>
        <td class="DataTable1" rowspan=2 nowrap>
            <%if(j==0){%><%=sCls + "-" + sVen + "-" + sSty%><%} else {%>&nbsp;<%}%>
        </td>
    </tr>
    <tr  class="DataTable">
    	<td class="DataTable8" colspan=2 nowrap>&nbsp;<%=sChnInv%></td>
        <td class="DataTable9" nowrap>&nbsp;<%=sChnSls%></td>
        <td class="DataTable9" nowrap>Inv/Sls</td>
        <%for(int k=0; k < iNumOfStr; k++){%>
        	<td class="StrInv" colspan=2 nowrap id="i<%=sCls%><%=sVen%><%=sSty%><%=sClr%><%=sSiz%>-<%=sStr[k]%>" >
        	   <%=sInv[k]%>
            </td>                  
            <td class="DataTable10"  id="isls<%=sCls%><%=sVen%><%=sSty%><%=sClr%><%=sSiz%>-<%=sStr[k]%>"  >
              &nbsp;<%=sSlsQty[k]%>
            </td>
            
            <script>
              aCellItmInvId[aCellItmInvId.length] = "i<%=sCls%><%=sVen%><%=sSty%><%=sClr%><%=sSiz%>-<%=sStr[k]%>";
              aCellItmSlsId[aCellItmSlsId.length] = "isls<%=sCls%><%=sVen%><%=sSty%><%=sClr%><%=sSiz%>-<%=sStr[k]%>";
            </script>     
        <%}%>
    </tr>
  <%}%>
<!-------------------------------End Item Detail ------------------------------>
  <!------------------------------- CVS Detail --------------------------------->
    <%    
    String sCls = itemLst.getCls();
	String sVen = itemLst.getVen();
	String sSty = itemLst.getSty();
        
     
    %>
    <tr class="DataTable1">
      <td class="DataTable5" nowrap rowspan="3" colspan="4"
          onclick="showMenu('<%=sCls%>', '<%=sVen%>',  '<%=sSty%>', null, null, this, ' ', ' ')">
        <span style="font-size:11px; font-weight:bolder"><%=sCvsDesc%></span><br>
        C: <%=sCvsCost%>&nbsp;&nbsp;R: <%=sCvsRet%>&nbsp;&nbsp;OR: <%=sCvsOrgRet%><br>
        VST: <%=sCvsVenSty%><br>
        FR: <%=sCvsFrtRct%>&nbsp;&nbsp;LR: <%=sCvsLstRct%><br>
        LS: <%=sCvsLstSlsDt%>&nbsp;&nbsp;M: <%=sCvsMdDate%>
      </td>

      <td class="DataTable8" nowrap colspan=2>&nbsp;<%=sCvsChnInv%></td>
      <td class="DataTable9" nowrap>&nbsp;<%=sCvsChnSls%></td>
      <td class="DataTable9">BSR Level</td>

      <!-- store inv & dtl on CVS Level -->
      <%for(int j=0; j < iNumOfStr; j++){
    	String sCellClr = "";        	
      %>
      <!-- ----------------- -->
        
          <td class="StrMin1" id="cmin<%=sCls%><%=sVen%><%=sSty%>-<%=sStr[j]%>" <%=sCellClr%> ><%=sCvsMinimum[j]%></td>
          <td class="StrIdeal1" id="cideal<%=sCls%><%=sVen%><%=sSty%>-<%=sStr[j]%>" >&nbsp;<%=sCvsIdeal[j]%></td>
          <td class="StrMax1" id="cmax<%=sCls%><%=sVen%><%=sSty%>-<%=sStr[j]%>" >&nbsp;<%=sCvsMaximum[j]%></td>
          
          <script>
              aCellCvsMinId[aCellCvsMinId.length] = "cmin<%=sCls%><%=sVen%><%=sSty%>-<%=sStr[j]%>";
              aCellCvsIdealId[aCellCvsIdealId.length] = "cideal<%=sCls%><%=sVen%><%=sSty%>-<%=sStr[j]%>";
              aCellCvsMaxId[aCellCvsMaxId.length] = "cmax<%=sCls%><%=sVen%><%=sSty%>-<%=sStr[j]%>";
      	  </script>   
      	                   
      <%}%>

      <td class="DataTable5" nowrap rowspan="3" colspan="2"
          onclick="showMenu('<%=sCls%>', '<%=sVen%>',  '<%=sSty%>', null, null, this, ' ', ' ')">
        <span style="font-size:11px; font-weight:bolder"><%=sCvsDesc%></span><br>
        C: <%=sCvsCost%>&nbsp;&nbsp;R: <%=sCvsRet%>&nbsp;&nbsp;OR: <%=sCvsOrgRet%><br>
        M: <%=sCvsMdDate%>&nbsp;&nbsp;VST: <%=sCvsVenSty%><br>
        FR: <%=sCvsFrtRct%>&nbsp;&nbsp;LR: <%=sCvsLstRct%><br>
        LS: <%=sCvsLstSlsDt%>&nbsp;&nbsp;
      </td>
    </tr>
    
    
    <tr class="DataTable1">      
      <td class="DataTable9" colspan="3">&nbsp;</td>
      <td class="DataTable9">Inv/Sls</td>
      <%for(int j=0; j < iNumOfStr; j++){%>        
      	  <td class="StrInv" colspan=2 id="c<%=sCls%><%=sVen%><%=sSty%>-<%=sStr[j]%>" ><%=sCvsInv[j]%></td>
          <td class="DataTable" id="csls<%=sCls%><%=sVen%><%=sSty%>-<%=sStr[j]%>" >&nbsp;<%=sCvsSlsQty[j]%></td>
          
          <script>
              aCellCvsInvId[aCellCvsInvId.length] = "c<%=sCls%><%=sVen%><%=sSty%>-<%=sStr[j]%>";
              aCellCvsSlsId[aCellCvsSlsId.length] = "csls<%=sCls%><%=sVen%><%=sSty%>-<%=sStr[j]%>";
      	  </script>   
      <%}%>
    </tr>
    

    <tr class="DataTable1">
      <td class="DataTable7" colspan="3">&nbsp;<%=sCvsTotSellOff%></td>
      <td class="DataTable7">&nbsp;</td>
      <%for(int j=0; j < iNumOfStr; j++){%>        
           <td class="DataTable4" id="csell<%=sCls%><%=sVen%><%=sSty%>-<%=sStr[j]%>" colspan=3>&nbsp;<%=sCvsSellOff[j]%></td>
           <script>
           aCellCvsSellId[aCellCvsSellId.length] = "csell<%=sCls%><%=sVen%><%=sSty%>-<%=sStr[j]%>";
      	  </script>
      <%}%>
    </tr>

      <tr id="STRHDR<%=i%>">
        <td class="StrLst" colspan="8">Stores</td>
        <%for(int j=0; j < iNumOfStr; j++){%>           
            <td class="StrLst" id="StrHdrL3<%=i%>_<%=j%>"  colspan="3"><%=sStr[j]%></td>
        <%}%>
        
        
        <td class="StrLst" colspan="3">Stores</td>
      </tr>         
   <%}%>
    <!----------------------- end of data ------------------------>
 </table>
 
 <%if(!bEof){%><a class="Small" href="javascript: getNextPage()">Next Page</a><%}%>
 
 <!----------------------- end of table ------------------------>
<%
long lEndTime = (new Date()).getTime();
long lElapse = (lEndTime - lStartTime) / 1000;
if (lElapse==0) {lElapse = 1;}
//System.out.println("B/Item X-fer loading Elapse time=" + lElapse + " second(s)");
%>       
<p  style="text-align: left; font-size:10px; font-weigth:bold;">Elapse: <%=lElapse%> sec.</td>

  </table>
  
  <script type="text/javascript">
 	var EndTime = Date.now();
 	var lapse = (EndTime - StartTime) / 1000;
 	window.status = "lapse=" + lapse;
  </script>
  
 </body>
</html> 
<% 
	itemLst.disconnect();
	itemLst = null;
	
}
%>

