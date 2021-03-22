<%@ page import="rental.RentContList ,java.util.*, java.text.*"%>
<%
   String sRorL = request.getParameter("RorL");
   String [] sSrchStr = request.getParameterValues("Str");
   String [] sSrchSts = request.getParameterValues("Sts");
   String sSrchCust = request.getParameter("Cust");
   String sFrDate = request.getParameter("FrDate");
   String sToDate = request.getParameter("ToDate");
   String sFrOpnDate = request.getParameter("FrOpnDate");
   String sToOpnDate = request.getParameter("ToOpnDate");   
   String sSort = request.getParameter("Sort");   
   String sSelGrp = request.getParameter("Grp");
    

   if (sRorL == null){ sRorL = "B"; }
   if (sSrchCust == null){ sSrchCust = " "; }
   if (sSort == null){ sSort = "CONT"; }
    
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=RentContList.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
     System.out.println("sFrOpnDate=" + sFrOpnDate + "| sToOpnDate=" + sToOpnDate);
   String sUser = session.getAttribute("USER").toString();
   RentContList rentinv = new RentContList(sSelGrp, sRorL, sSrchStr, sSrchCust, sSrchSts
	   , sFrDate, sToDate, sFrOpnDate, sToOpnDate
	   , sSort, sUser);

   String sStrJsa = rentinv.cvtToJavaScriptArray(sSrchStr);
   String sStsJsa = rentinv.cvtToJavaScriptArray(sSrchSts);
%>
<html>
<head>
<title>Rent_Contract_List</title>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable9 { background: LemonChiffon; font-family:Arial; font-size:10px; text-align:center;}
        tr.DataTable10 { background: #defcfc; font-family:Arial; font-size:11px; text-align:center;}

        td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right;}
        td.DataTable2 {border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.DataTable21 {background:pink; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable3 {background:#e7e7e7; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable31 {background:green; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable32 {background:red; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
                        
        td.DataTable4 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}                

        td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}

        td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}

        td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}
        #tdAllInv { display: none; }
        #tdAvlInv { display: block; }

        <!--------------------------------------------------------------------->
        .Small {font-family:Arial; font-size:10px }
        input.Small {font-family:Arial; font-size:10px }
        button.Small {font-family:Arial; font-size:10px }
        select.Small {font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
              
        div.dvLegend  { background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; 
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        
         div.dvHelp { position:absolute;border: none;text-align:center; width: 50px;height:50px; 
     top: 0; right: 50px; font-size:11px; white-space: nowrap;}
  
    
  a.helpLink { background-image:url("/scripts/Help02.png"); display:block;
     height:50px; width:50px; text-indent:-9999px; }
     
        
</style>

<script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var SelStr = [<%=sStrJsa%>];
var SelSts = [<%=sStsJsa%>];
var SelGrp = "<%=sSelGrp%>";
var MaxLine = 0;
var aCust = new Array();
var aCustNm = new Array();
var aCont = new Array();
var aPickDt = new Array();
var aRtnDt = new Array();
var aEntDt = new Array();
var aSts = new Array();

var aDupCust = new Array();
var aDupCustNm = new Array();
var aDupCont = new Array();
var aDupPickDt = new Array();
var aDupRtnDt = new Array();
var aDupSts = new Array();
var aDupEntDt = new Array();

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
	
   	setBoxclasses(["BoxName",  "BoxClose"], ["dvStatus", "dvDupCust", "dvLegend"]);
   	
   	setDupCust();
   	
   	setLegend();
   	
}
//==============================================================================
// set page legend
//==============================================================================
function setLegend()
{
   dvLegend
   var hdr = "Status Uses/Meanings:";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
     + "</tr>"
     + "<tr><td class='Prompt' colspan=2>" + popLegend()
     + "</td>" 
     + "</tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvLegend.style.width = "700"; }
   else if(isSafari) { document.all.dvLegend.style.width = "auto"; }
   
   var obj = document.getElementById("thLast");
   var pos = getObjPosition(obj);
   
   document.all.dvLegend.innerHTML = html;   
   document.all.dvLegend.style.left= pos[0] + 300 ;
   document.all.dvLegend.style.top= pos[1];
   document.all.dvLegend.style.visibility = "visible";
}
//==============================================================================
// popilate legend
//==============================================================================
function popLegend()
{
	var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
	panel += "<tr class='DataTable10'>"
	  + "<td class='DataTable4'><b><u>OPEN</u></b></td>"
	  + "<td class='DataTable4'>&nbsp;</td>"
	  + "<td class='DataTable4' nowrap>Contract has been initially entered.  Equipment (S/N's)" 
	     + " on this contract <br> will <b><u>continue</u></b> to be 'available' to rent on any other contract." 
	     + "<br> Equipment (S/N's) on OPEN contracts will <b><u>continue</u></b> to be swapped out " 
	     + "<br>(behind the screens) for overall availability of rental inventory."
      + "</td>"
	 + "</tr>";
	 
	panel += "<tr class='DataTable10'>"
	  + "<td class='DataTable4'><b><u>READY</u></b></td>"
	  + "<td class='DataTable4'>&nbsp;</td>"
	  + "<td class='DataTable4' nowrap>Ski TECH should immediately verify S/N's listed on the" 
	     + " Contract and then<br> change the status when all equipment has been set/fitted " 
	     + "(made 'ready')." 
	     + "<br>Equipment (S/N's) will <b><u>no longer</u></b> be available for rental on another contract" 
	     + "<br>on these contract dates."
	  + "</td>"
	 + "</tr>"; 
	
	panel += "<tr class='DataTable10'>"
	  + "<td class='DataTable4'><b><u>PICKEDUP</u></b></td>"
	  + "<td class='DataTable4'>&nbsp;</td>"
	  + "<td class='DataTable4' nowrap>Equipment has been 'Picked Up' by the Customer." 
	  	+ "Equipment (S/N's) will<br><b><u>no longer</u></b> be available for rental" 
	  	+ " on another contract on these same contract<br> dates."
	  + "</td>"
	 + "</tr>";  
	
	panel += "<tr class='DataTable10'>"
  	  + "<td class='DataTable4'><b><u>RETURNED</u></b></td>"
	  + "<td class='DataTable4'>&nbsp;</td>"
	  + "<td class='DataTable4' nowrap>Equipment has been 'returned' by the Customer." 
	  + " Equipment (S/N's) will <br><b><u>immediately</u></b> be available for rental."
	  + "</td>"
	 + "</tr>";  

	panel += "<tr class='DataTable10'>"
	  + "<td class='DataTable4'><b><u>CANCELLED</u></b></td>"
	  + "<td class='DataTable4'>&nbsp;</td>"
	  + "<td class='DataTable4' nowrap>Contracts that are either Duplicates of another existing" 
	  + " Contract, OR was<br>never picked up. Equipment (S/N's) will <b><u>immediately</u></b>" 
	  + " be available for rental. "
	  + "</td>"
	 + "</tr>";  

	panel += "</table>";
	return panel;
}
//==============================================================================
// re-sort table
//==============================================================================
function resort(column)
{
   var dummy="</table>";
   
   var url ="RentContList.jsp?&RorL=<%=sRorL%>";
   for(var i=0; i < SelStr.length; i++) { url += "&Str=" + SelStr[i]; }
   for(var i=0; i < SelSts.length; i++) { url += "&Sts=" + SelSts[i]; }
   url += "&Sort=" + column
     + "&FrDate=<%=sFrDate%>"
     + "&ToDate=<%=sToDate%>"
     + "&FrOpnDate=<%=sFrOpnDate%>"
     + "&ToOpnDate=<%=sToOpnDate%>"
     + "&Grp=<%=sSelGrp%>";
   window.location.href = url;
}

//==============================================================================
// change status
//==============================================================================
function chgSts(cont, cursts, pickDt, rtnDt)
{
   var hdr = "Contract: " + cont;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popStatusPanel(cont, cursts)
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left= getLeftScreenPos() + 540;
   document.all.dvStatus.style.top= getTopScreenPos() + 95;
   document.all.dvStatus.style.visibility = "visible";

   document.all.selSts.options[0] = new Option("OPEN","OPEN");
   document.all.selSts.options[1] = new Option("READY","READY");
   document.all.selSts.options[2] = new Option("PICKEDUP","PICKEDUP");
   document.all.selSts.options[3] = new Option("RETURNED","RETURNED");
   document.all.selSts.options[4] = new Option("CANCELLED","CANCELLED");

   document.all.FrDate1.value = pickDt;
   document.all.ToDate1.value = rtnDt;
   document.all.tdUnrel.style.display = "none";
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popStatusPanel(cont, cursts)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable9'>"
           + "<td colspan=2>Current Status: <u><b>" + cursts + "</b></u><br>&nbsp;</td>"
       + "</tr>"
       + "<tr class='DataTable9'>"
          + "<td style='text-align:right;'>Status </td>"
          + "<td style='text-align:left;' nowrap><select name='selSts' class='Small' onchange='chkSelSts(this)'></select>"
          + "<input name='FrDate1' type='hidden' readonly>"
          + "<input name='ToDate1' type='hidden' readonly>"
          + "</td>"
        + "</tr>"

  panel += "<tr class='DataTable9'>"
        + "<td id='tdUnrel' colspan=2 nowrap>"
          + "<input type='checkbox' name='Unrel' value='Y'>"
          + "Reservation - Not Picked up!"
        + "</td></tr>"

  panel += "<tr class='DataTable9'>";
  panel += "<td colspan=2 ><br><br><button onClick='ValidateSts(&#34;" + cont + "&#34;)' class='Small'>Change</button>&nbsp;"
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// check selected status
//==============================================================================
function chkSelSts(sel)
{
   if(sel.options[sel.selectedIndex].value=="CANCELLED")
   {
     document.all.tdUnrel.style.display="block";
   }
}

//==============================================================================
// hide panel
//==============================================================================
function hidePanel()
{
   document.all.dvStatus.innerHTML = "";
   document.all.dvStatus.style.visibility = "hidden";
}
//==============================================================================
// validate new status
//==============================================================================
function ValidateSts(cont)
{
   var error=false;
   var msg = "";

   var sts = document.all.selSts[document.all.selSts.selectedIndex].value;
   var frdate = document.all.FrDate1.value;
   var todate = document.all.ToDate1.value;
   var aproove = true;
   var unrel = " ";
   if (document.all.Unrel.checked){unrel=document.all.Unrel.value;}

   if(sts=="RETURNED" ) { aproove = chkRtnDt(sts, todate) }

   if(error){ alert(msg); }
   else if(aproove){ sbmNewSts(cont, sts, frdate, todate, unrel) }
}
//==============================================================================
// check returned date when returned status selected
//==============================================================================
function chkRtnDt(sts, rtnDt)
{
   var rdate = new Date(rtnDt);
   var today = new Date();
   rdate.setHours("23");
   var aproove = true;

   if(rdate > today)
   {
      aproove = confirm("Are you sure you want to RETURN this contract?")
   }
   return aproove;
}
//==============================================================================
// submit new status
//==============================================================================
function sbmNewSts(cont, sts, frdate, todate, unrel)
{
   var url = "RentContractSave.jsp?"
     + "&Cont=" + cont
     + "&Sts=" + sts
     + "&FrDate=" + frdate
     + "&ToDate=" + todate
     + "&Unrel=" + unrel
     + "&Action=CHG_CONT_STS"

   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// reload after save new status
//==============================================================================
function refreshCont(cont)
{
   var url ="RentContList.jsp?&RorL=<%=sRorL%>";
   for(var i=0; i < SelStr.length; i++) { url += "&Str=" + SelStr[i]; }
   for(var i=0; i < SelSts.length; i++) { url += "&Sts=" + SelSts[i]; }
   url += "&Sort=<%=sSort%>"
     + "&FrDate=<%=sFrDate%>"
     + "&ToDate=<%=sToDate%>"
     + "&FrOpnDate=<%=sFrOpnDate%>"
     + "&ToOpnDate=<%=sToOpnDate%>"
     + "&Grp=" + SelGrp 
   ;
   window.location.href = url;
}

//==============================================================================
//send email message
//==============================================================================
function emailOrd(toaddr, str)
{
	var hdr = "Send Customer Reminder";
	
	var html = "<table class='tbl01'>"
		+ "<tr>"
  		+ "<td class='BoxName' nowrap>" + hdr + "</td>"
  		+ "<td class='BoxClose' valign=top>"
    			+  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
  		+ "</td></tr>"
		+ "<tr><td class='Prompt' colspan=2>" + popEMailPanel(str)
			+ "</td></tr>"
		+ "</table>"

	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "500"; }
	else if(isSafari) { document.all.dvStatus.style.width = "auto"; }
		   
	document.all.dvStatus.innerHTML = html;
	var left = getLeftScreenPos() + 300;
	var top = getTopScreenPos() + 100;
	document.all.dvStatus.style.left = left + "px";
	document.all.dvStatus.style.top = top + "px";   
	document.all.dvStatus.style.visibility = "visible";

	document.all.ToAddr.value = toaddr;
	
	var iOpt = 0; 
	document.all.selEmailAddr.options[iOpt++] = new Option("--- Select email address ---", "NONE"); 
    document.all.selEmailAddr.options[iOpt++] = new Option("Polly Snyder", "psnyder@sunandski.com");
    document.all.selEmailAddr.options[iOpt++] = new Option("Vadim Rozen", "vrozen@sunandski.com");
    
    var toAddrNm = "Store" + str;
    var toAddr = "Store" + str + "@sunandski.com";
    document.all.selEmailAddr.options[iOpt++] = new Option(toAddrNm, toAddr);
  	
	var subj = "Your Lease expired today";
	document.all.Subj.value = subj;	
}
//==============================================================================
//populate Picture Menu
//==============================================================================
function popEMailPanel(str)
{
	var panel = "<table class='tbl02'>"
	panel += "<tr><td class='Prompt'>E-Mail Address</td></tr>"
    	+ "<tr><td class='Prompt'><input class='Small' size=50 name='ToAddr'>"
       		+ "<br><select class='Small' name='selEmailAddr' onchange='setEmailAddr(this)'></select>"
    	+ "</td></tr>"
  		+ "<tr><td class='Prompt'>Subject &nbsp;</td></tr>"
    	+ "<tr><td class='Prompt'><input class='Small' size=50 name='Subj'></td></tr>"
  		+ "<tr><td class='Prompt'>Message &nbsp;</td></tr>"
    	+ "<tr><td class='Prompt'><textarea class='Small' cols=100 rows=7 name='Msg' id='Msg'></textarea></td></tr>"
  		+ "<tr><td class='Prompt1'>"
    		+ "<button class='Small' onclick='validateEMail(&#34;" + str + "&#34;)'>Send</button> &nbsp;"
    		+ "<button class='Small' onclick='hidePanel()'>Cancel</button> &nbsp;"
  		+ "</td></tr>"
	panel += "</table>";

	panel += "<span style='display:none'>" 
    	+ "<input name='CmtTy' type='radio' value='EMAIL' checked>"
    	+ "<input name='CmtTy' type='radio' value='FAKE'>"
    	+ "<input name='txaComment' type='Textarea'>"
  	+ "</span>"

return panel;
}
//==============================================================================
//set selected email address line
//==============================================================================
function setEmailAddr(sel)
{
	document.all.ToAddr.value = sel.options[sel.selectedIndex].value; 
}
//==============================================================================
//validate email message properties
//==============================================================================
function validateEMail(str)
{
var msg = "";
var error = false;

var toaddr = document.all.ToAddr.value.trim();
if(toaddr ==""){error=true; msg="Please enter Email Address"; }

var subj = document.all.Subj.value.trim();
if(subj ==""){error=true; msg="Please enter Subject Address"}

var body = document.all.Msg.value.trim();

if(body =="" && !incl){error=true; msg="Please enter message text or(and) include claim information."}

	if(error){ alert(msg); }
	else 
	{	
		var str = str;
		if(str.length==1){ str = "0" + str; }
		
		var frAddr = "Store" + str + "@sunandski.com";			
	
		document.all.txaComment.value = "Emailed " + subj + ". To " + toaddr + ". " + body;	
		sbmEMail(str, toaddr, subj, body); 
	}
}
//==============================================================================
//email Order
//==============================================================================
function sbmEMail(str, toaddr, subj, body)
{    	
 	var nwelem = "";
	
 	if(isIE){ nwelem = window.frame1.document.createElement("div"); }
 	else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
 	else{ nwelem = window.frame1.contentDocument.createElement("div");}
 	nwelem.id = "dvSbmCommt"

 	var html = "<form name='frmSendEmail'"
      + " METHOD=Post ACTION='WarrantyClaimSendEMail.jsp'>"
      + "<input class='Small' name='User'>"
      + "<input class='Small' name='MailAddr'>"
      + "<input class='Small' name='CCMailAddr'>"
      + "<input class='Small' name='FromMailAddr'>"
      + "<input class='Small' name='Subject'>"
      + "<input class='Small' name='Message'>";
      
 	html += "</form>"
 
 	nwelem.innerHTML = html;
 	frmcommt = document.all.frmEmail;
 	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
 	else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
 	else if(isSafari){window.frame1.document.body.appendChild(nwelem);}
 	else{ window.frame1.contentDocument.body.appendChild(nwelem); } 
 
 	if(isIE || isSafari)
 	{
	    window.frame1.document.all.User.value = "<%=sUser%>";
		window.frame1.document.all.Subject.value = subj;
 		window.frame1.document.all.Message.value = body;
 		window.frame1.document.all.MailAddr.value = toaddr;
 
 		if(str!=30) 
 		{
 			if(str.length==1){ str = "0" + Str; }
 			window.frame1.document.all.CCMailAddr.value = "GM" + str + "@sunandski.com";
 			var frAddr = "Store" + str + "@sunandski.com"		   
 	 		window.frame1.document.all.FromMailAddr.value = frAddr;   
 		}
 		else
 		{
 			window.frame1.document.all.CCMailAddr.value = "kknight@sunandski.com";
 			window.frame1.document.all.FromMailAddr.value = "kknight@sunandski.com";
 		}
 		 
 		window.frame1.document.frmSendEmail.submit();  
 	}
 	else
 	{
	    window.frame1.contentDocument.forms[0].User.value = "<%=sUser%>";
	   	window.frame1.contentDocument.forms[0].Subject.value = subj;
		window.frame1.contentDocument.forms[0].Message.value = body;
		window.frame1.contentDocument.forms[0].MailAddr.value = toaddr;


 		if(str!=30) 
 		{
			var str = Str;
			if(str.length==1){ str = "0" + Str; }
			window.frame1.contentDocument.forms[0].CCMailAddr.value = "GM" + str + "@sunandski.com";
			var frAddr = "Store" + str + "@sunandski.com"
			window.frame1.contentDocument.forms[0].FromMailAddr.value = frAddr;
 		}
 		else
 		{
 			window.frame1.contentDocument.forms[0].CCMailAddr.value = "kknight@sunandski.com";;
			window.frame1.contentDocument.forms[0].FromMailAddr.value = "kknight@sunandski.com";;
 		}
 		
		for(var i=0; i < RecUsr.length; i++)
		{
	   		if(User == RecUsr[i]){ frAddr =  RecUsr[i] + "@sunandski.com"; break; } 
		}   
		    
		window.frame1.contentDocument.forms[0].submit(); 
 	}
 
 	hidePanel();
}
//==============================================================================
// set same customer
//==============================================================================
function setDupCust()
{
	var aChkDup = new Array();	
	 
	for(var i=0; i < aCust.length; i++ )
	{	
		var iDup = -1;
		for(var j=0; j < aCust.length; j++ )
		{
			if(i != j && aCust[j] == aCust[i])
			{ 
				iDup = i;
				break;
			}
		}
		
	    if(iDup >= 0)
	    {
			var found = false;
	    	for(var j=0, k=0; j < aChkDup.length; j++ )
			{
				if(aChkDup[j] == aCust[i])
				{ 
					found = true;
					break;
				}
			}
	    	
	    	if(!found)
	    	{
	    		aChkDup[aChkDup.length] = aCust[iDup];
	    	}
	    }
	}	
	
	
	for(var i=0, k=0; i < aChkDup.length; i++ )
	{
		for(var j=0; j < aCust.length; j++ )
		{
			if(aChkDup[i] == aCust[j])
			{
				aDupCust[k] = aCust[j];
				aDupCustNm[k] = aCustNm[j];
				aDupCont[k] = aCont[j]; 
				if(aPickDt[j] != null){	aDupPickDt[k] = aPickDt[j]; }
				else{ aDupPickDt[k] = "&nbsp;"; }
				if(aRtnDt[j] != null){	aDupRtnDt[k] = aRtnDt[j]; }
				else{ aDupRtnDt[k] = "&nbsp;"; }
				if(aSts[j] != null){	aDupSts[k] = aSts[j]; }
				else{ aDupSts[k] = "&nbsp;"; }
				if(aEntDt[j] != null){	aDupEntDt[k] = aEntDt[j]; }
				else{ aDupEntDt[k] = "&nbsp;"; }
				k++;
			}
		}
	}
		
}
//==============================================================================
//show same customer
//==============================================================================
function showDupCust()
{
var hdr = "Show DUP Customer";
	
	var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
		+ "<tr>"
  		+ "<td class='BoxName' nowrap>" + hdr + "</td>"
  		+ "<td class='BoxClose' valign=top>"
    			+  "<img src='CloseButton.bmp' onclick='javascript: hidePanel1();' alt='Close'>"
  		+ "</td></tr>"
		+ "<tr><td class='Prompt' colspan=2>" + popDupCust()
			+ "</td></tr>"
		+ "</table>"

	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvDupCust.style.width = "400"; }
	else if(isSafari) { document.all.dvDupCust.style.width = "auto"; }
		   
	document.all.dvDupCust.innerHTML = html;
	var left = getLeftScreenPos() + 300;
	var top = getTopScreenPos() + 100;
	document.all.dvDupCust.style.left = left + "px";
	document.all.dvDupCust.style.top = top + "px";   
	document.all.dvDupCust.style.visibility = "visible";	 
}
//==============================================================================
//populate Picture Menu
//==============================================================================
function popDupCust()
{
	var panel = "<table border='1' cellPadding='0' cellSpacing='0'>"
	panel += "<tr class='DataTable'>" 
	  + "<th class='DataTable'>Customer</th>"
	  + "<th class='DataTable'>Contract</th>"
	  + "<th class='DataTable'>Entry<br>Date</th>"
	  + "<th class='DataTable'>Pickup<br>Date</th>"
	  + "<th class='DataTable'>Return<br>Date</th>"
	  + "<th class='DataTable'>Status</th></tr>"
	  
    ;
	  var str = "";
	for(var i=0; i < aDupCust.length; i++)
	{
		panel += "<tr class='DataTable9'>" 
		 	+ "<td class='DataTable2' nowrap>" + aDupCustNm[i] + "</td>"
		 	+ "<td class='DataTable2'>"  
		 	   + "<a href='RentContractInfo.jsp?ContId=" + aDupCont[i] + "' target='_blank'>" + aDupCont[i] + "</a>" 
		 	+ "</td>"
		 	+ "<td class='DataTable2' nowrap>" + aDupEntDt[i] + "</td>"
		 	+ "<td class='DataTable2'>" + aDupPickDt[i] + "</td>"
		 	+ "<td class='DataTable2'>" + aDupRtnDt[i] + "</td>"
		 	+ "<td class='DataTable2'>"  
		 	   + "<a href='javascript: chgSts(&#34;" + aDupCont[i] + "&#34;, &#34;" + aDupSts[i] + "&#34;, &#34;" + aDupPickDt[i] + "&#34;, &#34;" + aDupRtnDt[i] + "&#34;)'>" + aDupSts[i] + "</a>"
		 	+ "</td>"
		 + "</tr>";
	}  
	  
    panel += "<tr><td class='Prompt1' colspan='6'>"
   		+ "<button class='Small' onclick='hidePanel1()'>Cancel</button> &nbsp;"
  	  + "</td></tr>";
	
  	panel += "</table>";

  	return panel;
}
//==============================================================================
//hide panel
//==============================================================================
function hidePanel1()
{
	document.all.dvDupCust.innerHTML = "";
	document.all.dvDupCust.style.visibility = "hidden";
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<div id="dvDupCust" class="dvStatus"></div>
<div id="dvHelp" class="dvHelp">
<a  class="helpLink" href="Intranet Reference Documents/3.0%20Rental%20Contracts%20-%20List.pdf" title="Click here for help" target="_blank">&nbsp;</a>
</div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Rental Contract
        <br> Equipments: 
        <%if(sSelGrp.equals("SKI")){%>Skis, Snowboards<%}
        else if(sSelGrp.equals("BIKE")){%>Bikes<%}
        else if(sSelGrp.equals("WATER")){%>Waterboards<%}
        else if(sSelGrp.equals("ALL")){%>All<%}%>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="RentContListSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page.
      &nbsp; &nbsp; 
      <%if(!sSelGrp.equals("ALL")){%><a href="RentContractInfo.jsp?Grp=<%=sSelGrp%>" target="_blank">New Contract</a><%}%>
      &nbsp; &nbsp; <a href="javascript: showDupCust()" style="color: red;">Show DUP Customer</a>
      <br>
      <br>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable">
          <th class="DataTable" rowspan=2>No.</th>
          <th class="DataTable" rowspan=2><a href="javascript: resort('CONT')">Contract</a></th>
          <th class="DataTable" rowspan=2><a href="javascript: resort('CRTDT')">Entry<br>Date</a></th>
          <th class="DataTable" rowspan=2><a href="javascript: resort('STORE')">Store</a></th>
          <th class="DataTable" rowspan=2><a href="javascript: resort('PICKUP')">Pick up<br>Date</a></th>
          <th class="DataTable" rowspan=2><a href="javascript: resort('DROPOFF')">Drop off<br>Date</a></th>
          <th class="DataTable" rowspan=2># of Days</th>
          <th class="DataTable" rowspan=2><a href="javascript: resort('ONLINE')">On-Line Reservations</a>
          	<br><span style="font-size: 10px">(New or Returning<br>Customer)</span>
          </th>
          <th class="DataTable" rowspan=2><a href="javascript: resort('CUSTNM')">Customer Name</a></th>
          <th class="DataTable" rowspan=2>E-Mail</th>
          <th class="DataTable" rowspan=2>Home<br>Phone</th>
          <th class="DataTable" rowspan=2>Cell<br>Phone</th>
          <th class="DataTable" rowspan=2><a href="javascript: resort('STS')">Status</a></th>
          <th class="DataTable" colspan=2>Number of Renters</th>
        </tr>
        <tr class="DataTable">
          <th class="DataTable">On the Contract</th>
          <th class="DataTable"  >Equipment<br>Fitted / Reserved</th>
       </tr>
  <!-------------------------- Order List ------------------------------->
      <%
       int iLine = 0;
       while(rentinv.getNext())
       {
          rentinv.getContList();

          String sCont = rentinv.getCont();
          String sCust = rentinv.getCust();
          String sPickDt = rentinv.getPickDt();
          String sRtnDt = rentinv.getRtnDt();
          String sSts = rentinv.getSts();
          String sStr = rentinv.getStr();
          String sCashier = rentinv.getCashier();
          String sRecDt = rentinv.getRecDt();
          String sNumOfSkr = rentinv.getNumOfSkr();
          String sFirstNm = rentinv.getFirstNm();
          String sMInit = rentinv.getMInit();
          String sLastNm = rentinv.getLastNm();
          String sEMail = rentinv.getEMail();
          String sHomePhn = rentinv.getHomePhn();
          String sCellPhn = rentinv.getCellPhn();
          String sNumOfFit = rentinv.getNumOfFit();
          String sSameCust = rentinv.getSameCust();
          String sRecTm = rentinv.getRecTm();
          String sNumOfScan = rentinv.getNumOfScan();
          String sNumOfUnScan = rentinv.getNumOfUnScan();
          String sOnline = rentinv.getOnline();
          String sOnlPriCust = rentinv.getOnlPriCust();
          String sGroup = rentinv.getGroup();
          String sPuDofWk = rentinv.getPuDofWk();
          String sDoDofWk = rentinv.getDoDofWk();
          String sNumOfDay = rentinv.getNumOfDay();
          String sPuAmPm = rentinv.getPuAmPm();
          String sDoAmPm = rentinv.getDoAmPm();
          String sUnpack = rentinv.getUnpack();
          iLine++;
          
          SimpleDateFormat sdfMdy = new SimpleDateFormat("MM/dd/yyyy");
          Date dPickDt = sdfMdy.parse(sPickDt);
          Date dCurrDt = new Date();
          
          dPickDt.setHours(18);
          dCurrDt.setHours(18);
          
          long lPickDt = dPickDt.getTime();
          long lCurrDt = dCurrDt.getTime();
          double dMillis = lPickDt - lCurrDt;
          if(dMillis < 0){ dMillis = 0;}
          
          double dDays = dMillis / (3600 * 1000 * 24);
          
          String sCellOnline = "&nbsp;";
          String sCellOnlSty = "";
          if(sOnline.equals("Y") && sOnlPriCust.equals("1"))
          {
        	  sCellOnline = "Yes - Returning";        	  
          }
          else if(sOnline.equals("Y") && sOnlPriCust.equals("2"))
          {
        	  sCellOnline = "Yes - Prior No-Show";
        	  sCellOnlSty = "style=\"background: #fefbc9; color:#a60808;\"";
          }
          else if(sOnline.equals("Y") && sOnlPriCust.equals("3"))
          {
        	  sCellOnline = "Yes - New";
        	  sCellOnlSty = "style=\"background: #d9f5ce; color:#a60808;\"";
          }
          String sPuAmPmClr = "yellow";
          if(sPuAmPm.equals("P")){ sPuAmPmClr = "#79a8f2"; }
          String sDoAmPmClr = "yellow";
          
          if(sDoAmPm.equals("P"))
          { 
        	  sDoAmPmClr = "#79a8f2"; 
          }
          
          SimpleDateFormat sdfUsa1 = new SimpleDateFormat("MM/dd/yyyy");  
          SimpleDateFormat sdfMdy1 = new SimpleDateFormat("MM/dd/yy");
          
          String sPuDtMDY = sdfMdy1.format(sdfUsa1.parse(sPickDt));
          String sDoDtMDY = sdfMdy1.format(sdfUsa1.parse(sRtnDt));
      %>
         <tr class="DataTable1">
           <td class="DataTable2"><%=iLine%></td>
           <td class="DataTable"><a href="RentContractInfo.jsp?Grp=<%=sGroup%>&Str=<%=sStr%>&ContId=<%=sCont%>" target="_blank"><%=sCont%></a></td>
           <td class="DataTable2"><span style="font-size: 12px; font-weight: bold;"><%=sRecDt%></span> <%=sRecTm%></td>
           <td class="DataTable2"><%=sStr%></td>
           <td class="DataTable" nowrap><span style="font-size: 12px; font-weight: bold;"><%=sPuDtMDY%></span> (<%=sPuDofWk%>-<span style="background: <%=sPuAmPmClr%>"><%=sPuAmPm%></span>)</td>
           <td class="DataTable" nowrap><span style="font-size: 12px; font-weight: bold;"><%=sDoDtMDY%></span> (<%=sDoDofWk%>-<span style="background: <%=sDoAmPmClr%>"><%=sDoAmPm%></span>)</td>
           <td class="DataTable2"><%=sNumOfDay%></td>
           <td class="DataTable2" <%=sCellOnlSty%> nowrap><%=sCellOnline%></td>
           <td class="DataTable" nowrap>
              <%=sFirstNm%> <%=sMInit%> <%=sLastNm%>
              <%if(sSameCust.equals("Y")){%><span style="color: red; vertical-align: super; font-size: 10px">dup</span><%}%>
           </td>
           <td class="DataTable"><a href="javascript: emailOrd('<%=sEMail%>', '<%=sStr%>')"><%=sEMail%></a></td>
           <td class="DataTable"><%=sHomePhn%></td>
           <td class="DataTable"><%=sCellPhn%></td>
           <td class="DataTable"><a href="javascript: chgSts('<%=sCont%>', '<%=sSts%>', '<%=sPickDt%>', '<%=sRtnDt%>')"><%=sSts%></a></td>
           <td class="DataTable2"><%=sNumOfSkr%></td>
           <%
           String sStyle = "";
           int iSkr = Integer.parseInt(sNumOfSkr);
           int iFit = Integer.parseInt(sNumOfFit);
             
           String sFitScan = sNumOfFit; 
           if(sSts.equals("CANCELLED")){ sFitScan = "&nbsp;"; }           
           else if(!sOnline.equals("Y") && iSkr > iFit){ sFitScan = (iSkr - iFit) + "- INCOMPLETE"; sStyle = "style=\"background:red;\"";}
           else if(sOnline.equals("Y") && iSkr > iFit){ sFitScan = "INCOMPLETE PACKAGE"; sStyle = "style=\"background:red;\"";}
           else if ( sOnline.equals("Y") && sUnpack.equals("1")){ sFitScan = "INCOMPLETE PACKAGE"; sStyle = "style=\"background:red;\"";}
           else if(!sNumOfUnScan.equals("0")) { sFitScan = "S/N's NOT SCANNED"; sStyle = "style=\"background:yellow; color: red;\"";}
           else if(!sNumOfUnScan.equals("0")){ sFitScan = "EQUIP is RESERVED"; sStyle = "style=\"background:lightgreen;\"";}
           
           /*  sFitScan += " | Skr=" + iSkr 
              +  " | Fit=" + iFit            	
              + " | UnScan=" + sNumOfUnScan
              + " | days = " + Math.round(dDays); 
            		 ;
             */            		 
           
           %>
           <td class="DataTable2" <%=sStyle%> nowrap><%=sFitScan%></td>
         </tr>
         <script>
         MaxLine = eval("<%=iLine%>");
         aCust[aCust.length] = "<%=sCust%>";
         aCustNm[aCustNm.length] = "<%=sFirstNm%> <%=sMInit%> <%=sLastNm%>";
         aCont[aCont.length] = "<%=sCont%>";
         aPickDt[aCust.length] = "<%=sPickDt%>";
         aRtnDt[aCust.length] = "<%=sRtnDt%>";
         aSts[aCust.length] = "<%=sSts%>";
         aEntDt[aCust.length] = "<%=sRecDt%> <%=sRecTm%>";
         </script>
      <%}%>
      
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>  
  </table>
  
  <p id="thLast" align=center>
  <div id="dvLegend" class="dvLegend"></div>
  
 </body>
</html>


<%  rentinv.disconnect();
  }%>