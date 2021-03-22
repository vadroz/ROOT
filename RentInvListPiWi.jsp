<!DOCTYPE html>
<%@ page import="rental.RentInvListPiWi ,java.util.*, java.text.*"%>
<%
   String [] sSrchCls = request.getParameterValues("Cls");
   String [] sSrchStr = request.getParameterValues("Str");
   String sIncl = request.getParameter("Incl");
   String sYear = request.getParameter("Year");
   String sSort = request.getParameter("Sort");
   String sUcr = request.getParameter("Ucr");

   if (sSort == null){ sSort = "ITEM"; }
   if (sIncl == null){ sIncl = " "; }
   if (sUcr == null){ sUcr = "U"; }
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=RentInvListPiWi.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {

   String sUser = session.getAttribute("USER").toString();

   // set flag to allow delete inventory serial number
   boolean bAllowInvDlt = (session.getAttribute("REINVDLT") != null);

   RentInvListPiWi rentinv = new RentInvListPiWi(sSrchCls, sSrchStr, sIncl, sYear, sSort, sUser);
   int iNumOfStr = rentinv.getNumOfStr();
   String [] sStr = rentinv.getStr();
   
   String sClsJsa = rentinv.cvtToJavaScriptArray(sSrchCls);
   String sStrJsa = rentinv.cvtToJavaScriptArray(sStr);
%>
<html>

<head>

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE11" />

<title>Rent Inv List</title>

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="XXsetFixedTblHdr.js"></script>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var ClsLst = [<%=sClsJsa%>];
var StrLst = [<%=sStrJsa%>];
var Incl = "<%=sIncl%>";
var Sort = "<%=sSort%>";
var Year = "<%=sYear%>";

var StrType = true;

var ChkItem = new Array();
var ChkItemDtl = new Array();

var SelObj = null;
var SelStr = null;
var SelCls = null;
var SelVen = null;
var SelSty = null;
var SelClr = null;
var SelSiz = null;
var SelDesc = null;
var SelClrnm = null;
var SelSiznm = null;

var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";
var LastDate = null;
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvChkItm", "dvCont", "dvItem", "dvComment"]);
	
	//getHdrWidth("thead1");
	//getDtlRowWidth("tbody1");
	
	showClsTot();
}

//==============================================================================
//show tag availability
//==============================================================================
function showClsTot()
{
	var dvload = document.getElementById("dvLoadClsTot");	
	var dvshow = document.getElementById("dvShowClsTot");
	dvshow.innerHTML = dvload.innerHTML; 
	dvload.style.display = "none";
}
//==============================================================================
// show tag availability
//==============================================================================
function showTagAvl(cls, ven,  sty, clr, siz, desc, clrNm, sizNm, invId, srlNum
	    , contId, pickDt, rtnDt,str, itmSts, rmvDt, purchYr, equipTy, irow
	    , testDt, grade, tech, techNm, rmvUs, brand, model, addDt, mfgSn, life, venNm
	    , cmAddUs, cmAddDt, cmAddTm, piStr, piArea, piDate, piTime)
{
  var hdr = desc + " &nbsp; Size: " + sizNm + " Store:" + str;

  var html = "<table class='tbl02'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvChkItm&#34;); hidePanel(&#34;dvItem&#34;);' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popTagAvlPanel(cls, ven,  sty, clr, siz, desc, clrNm, sizNm, invId, srlNum
		    , contId, pickDt, rtnDt,str, itmSts, rmvDt, purchYr, equipTy, irow
		    , testDt, grade, tech, techNm, rmvUs, brand, model, addDt, mfgSn, life, venNm
		    , cmAddUs, cmAddDt, cmAddTm, piStr, piArea, piDate, piTime)

   html += "</td></tr></table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "250";}
   else { document.all.dvItem.style.width = "auto";}
   
   document.all.dvChkItm.innerHTML = html;   
   document.all.dvChkItm.style.left= (getLeftScreenPos() + 100) + "px";
   document.all.dvChkItm.style.top= (getTopScreenPos() + 10) + "px";
   document.all.dvChkItm.style.visibility = "visible";
}
//==============================================================================
// populate Marked Item Panel
//==============================================================================
function popTagAvlPanel(cls, ven,  sty, clr, siz, desc, clrNm, sizNm, invId, srlNum
	    , contId, pickDt, rtnDt,str, itmSts, rmvDt, purchYr, equipTy, irow
	    , testDt, grade, tech, techNm, rmvUs, brand, model, addDt, mfgSn, life, venNm
	    , cmAddUs, cmAddDt, cmAddTm, piStr, piArea, piDate, piTime)
{
   SelStr = str;
   SelCls = cls;
   SelVen = ven;
   SelSty = sty;
   SelClr = clr;
   SelSiz = siz;
   SelDesc = desc;
   SelClrnm = clrNm;
   SelSiznm = sizNm;

   var panel = "<table  class='tbl02'>";
   panel += "<tr class='trHdr01'>"
             + "<th class='th13' rowspan=2 nowrap>No.</th>"
             + "<th class='th13' rowspan=2 nowrap>SS Barcode<br>ID</th>"
             + "<th class='th13' rowspan=2 nowrap>Has Contract?</th>"
             + "<th class='th13' rowspan=2 nowrap>Sts</th>"
             + "<th class='th13' rowspan=2 nowrap>Change Item<br>Status</th>"
             + "<th class='th13' rowspan=2 nowrap>Show<br>Comments</th>"
             + "<th class='th13' rowspan=2 nowrap>Purchase<br>Year</th>"
             + "<th class='th13' rowspan=2 nowrap>Brand</th>"
             + "<th class='th13' rowspan=2 nowrap>Model</th>"
             + "<th class='th13' rowspan=2 nowrap>Life</th>"
             + "<th class='th13' rowspan=2 nowrap>Created<br>By<br>User</th>"
             + "<th class='th13' rowspan=2 nowrap>Created<br>Date</th>"
             + "<th class='th13' rowspan=2 nowrap>Created<br>Time</th>"
             + "<th class='th13' colspan=2 nowrap>Last Scan Count</th>" 
             
          + "</tr>"
          ;
          
    panel += "<tr class='trHdr01'>"
    		+ "<th class='th13' nowrap>Str / Area</th>" 
        	+ "<th class='th13' nowrap>Date/Time</th>"
     	  + "</tr>"
          ;

   for(var i=0; i < srlNum.length; i++)
   {
      // check if any contract in the future assigned to serial number
      var hasCont = false;
      for(var j=0; j < contId[i].length; j++)
      {
          if(contId[i][j]!=""){ hasCont = true; break;}
      }

      panel += "<tr class='trDtl04'>"
    	+ "<td class='td11' nowrap>" + (i+1) + "</td>"
        + "<td class='td11' nowrap><a href='javascript: updInvBySrlNum(&#34;" + srlNum[i] + "&#34;)'>" + srlNum[i] + "</a></td>"

      // link to list of existing contract on that equipment
      if(hasCont)
      {
         panel += "<td class='td11' nowrap> &nbsp; &nbsp; <a href='javascript: getContLst(&#34;"
           + invId[i] + "&#34;)'>" + contId[i] + "</a>"
           +  " Pick: " + pickDt[i] + " Ret:&nbsp; " + rtnDt[i]  
           + "</td>"
      }
      else {panel += "<td class='td18' nowrap>No</td>"}

      if (itmSts[i]==""){ panel += "<td class='td11' nowrap>Ready</td>"; }
      else{panel += "<td class='td11' nowrap>" + itmSts[i] + " &nbsp; Removed:&nbsp;" + rmvUs[i] + "&nbsp;" + rmvDt[i] + " </td>"}
      
      

      // link to make serial# unavailable
      if(itmSts[i]=="")
      {
         panel += "<td class='td11' nowrap><a href='javascript: chgItmAvail(&#34;" + invId[i]
           + "&#34;,&#34;RMV_INV_AVAIL&#34;, &#34;" + srlNum[i] +  "&#34;)'>Update</a></td>"
      }
      //else if(!hasCont && itmSts[i]=="UNAVAIL")
      else if(itmSts[i]=="UNAVAIL")
      {
         panel += "<td class='td11' nowrap><a href='javascript: chgItmAvail(&#34;" + invId[i]
           + "&#34;,&#34;RTN_INV_AVAIL&#34;, &#34;" + srlNum[i] +  "&#34;)'>Activate</a></td>"
      }
      else{panel += "<td class='td11' nowrap>&nbsp;</td>"}

      panel += "<td class='td11' id='tdDspCommt" + i + "' nowrap><a href='javascript: getCommt(&#34;" + invId[i] + "&#34;,&#34;" + i + "&#34;)'>Display</a></td>"

      var etNm = "Any";
      if(equipTy[i] == "L"){ etNm = "Lease"; }
      else if(equipTy[i] == "R"){ etNm = "Rent"; }
      
      panel += "<td class='td11' nowrap>" + purchYr[i] + "</td>"
      panel += "<td class='td11' nowrap>" + brand[i] + " - " + venNm[i] +"</td>"
      panel += "<td class='td11' nowrap>" + model[i] + "</td>"
      panel += "<td class='td11' nowrap>" + life[i] + "</td>"
      panel += "<td class='td11'>" + cmAddUs[i]  + "</td>"
      panel += "<td class='td18'>" + cmAddDt[i]  + "</td>"
      panel += "<td class='td18'>" + cmAddTm[i]  + "</td>"
      panel += "<td class='td18'>" + piStr[i] + " - " + piArea[i] + "</td>"
      panel += "<td class='td18'>" + piDate[i] + " " + piTime[i] + "</td>"
   }

   panel += "<tr>"
        
   panel += "<td class='Prompt1' colspan=8>"
        + "<button onClick='getSrlNum(&#34;" + str + "&#34;, &#34;" + cls + "&#34;, &#34;"
        + ven + "&#34;, &#34;" + sty + "&#34;, &#34;" + clr + "&#34;, &#34;" + siz + "&#34;, &#34;"
        + desc + "&#34;, &#34;" + clrNm + "&#34;, &#34;" + sizNm + "&#34;, &#34;" + irow + "&#34;)' class='Small'>Refresh</button> &nbsp; &nbsp;"

        + "<button onClick='hidePanel(&#34;dvChkItm&#34;); hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"
      + "</td>"
   
        + "</tr>"

   panel += "</table>";

   return panel;
}
//==============================================================================
// show checked out items
//==============================================================================
function getSrlNum(str, cls, ven, sty, clr, siz, desc, clrnm, siznm, irow)
{
   hidePanel("dvItem");
   hidePanel("dvCont");

   var date = new Date();
   var mdy = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
   
   url="RentTagAvlQuickLst.jsp?Cls=" + cls
   	+ "&Ven=" + ven
   	+ "&Sty=" + sty
   	+ "&Clr=" + clr
   	+ "&Siz=" + siz
   	+ "&Str=" + str
   	+ "&FrDate=" + mdy
   	+ "&ToDate=ENDOFYEAR"
   	+ "&Desc=" + desc
   	+ "&ClrNm=" + clrnm
   	+ "&SizNm=" + siznm
   	+ "&Row=" + irow
   
   //alert(url);
   window.frame1.location.href=url;
}
//==============================================================================
// show checked out items
//==============================================================================
function createSrlNum(str, cls, ven, sty, clr, siz, desc, clrnm, siznm)
{
	var url = "RentInvAdd.jsp?Str=" + str 
	 + "&Cls=" + cls
	 + "&Siz=" + siz
	 + "&SizNm=" + siznm
	 + "&Action=CrtNewForStrCls"
	 ;
	window.open(url);
}
//==============================================================================
//show checked out items
//==============================================================================
function updInvBySrlNum(srlnum)
{
	var url = "RentInvAdd.jsp?SrlNum=" + srlnum 
	 + "&Action=UpdInvBySrlNum"
	 ;
	window.open(url);
}
//==============================================================================
// check key pressed 
//==============================================================================
function getKeyEnter(e)
{
	if (e.keyCode == 13) 
	{
		document.all.btnAdd.click();
    }
}
//==============================================================================
//check scanned item against order
//==============================================================================
function getScannedItem(sn)
{
	var valid = true;
	var url = "RentChkSrlNum.jsp?Sn=" + sn;

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
  			var beg = resp.indexOf("<SN_Valid>") + 10;
  			var end = resp.indexOf("</SN_Valid>");
  			valid = resp.substring(beg, end) == "true";
		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return valid;
}
//==============================================================================
//delete last serial numbers by number of rows 
//==============================================================================
function dltSrlNumGrp(str, cls, ven, sty, clr, siz, desc, clrnm, siznm)
{
var hdr = "Delete Last Serial Number";

var html = "<table class='tbl02'>"
  + "<tr>"
    + "<td class='BoxName' nowrap>" + hdr + "</td>"
    + "<td class='BoxClose' valign=top>"
      +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
    + "</td></tr>"
html += "<tr><td class='Prompt' colspan=2>"

html += popdltSrlNumGrp(str, cls, ven, sty, clr, siz, desc, clrnm, siznm)

html += "</td></tr></table>"

document.all.dvItem.innerHTML = html;
document.all.dvItem.style.width = 350;
document.all.dvItem.style.left= (getLeftScreenPos() + 300)  + "px";
document.all.dvItem.style.top= (getTopScreenPos() + 120)  + "px";
document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate new serial number panel
//==============================================================================
function popdltSrlNumGrp(str, cls, ven, sty, clr, siz, desc, clrnm, siznm)
{
var panel = "<table class='tbl02'>";
	panel += "<tr class='trDtl04'>"
		 + "<td class='td11' nowrap>"
		 + "The Only equipments w/o contract will be counted and deleted?"             
		 + "</td>"
	   + "</tr>"
       
       + "<tr class='td11'>"
         + "<td class='td11' nowrap>"
           + "Delete Last S/N <input name='Qty' value='1' size=3 maxlength=3>"             
         + "</td>"
    + "</tr>"

panel += "<tr class='td11'><td class='Prompt1' colspan=4>"
      + "<button onClick='vldDltSrlNumGrp(&#34;" + str + "&#34;, &#34;" + cls + "&#34;, &#34;"
      + ven + "&#34;, &#34;" + sty + "&#34;, &#34;" + clr + "&#34;, &#34;" + siz + "&#34;, &#34;"
      + desc + "&#34;, &#34;" + clrnm + "&#34;, &#34;" + siznm + "&#34;)' class='Small'>Delete</button> &nbsp; &nbsp;"
     + "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"
    + "</td>"
 + "</tr>"

panel += "</table>";

return panel;
}
//==============================================================================
//validate new serial number
//==============================================================================
function vldDltSrlNumGrp(str, cls, ven, sty, clr, siz, desc, clrnm, siznm)
{
	var error = false;
	var msg="";
	
	var qty = document.all.Qty.value.trim();
	if(qty == ""){ error=true; msg="Please enter quantity of deleting S/N"}
	else if(isNaN(qty)){ error=true; msg="Quantity is not numeric"}
	else if( eval(qty) < 1 || eval(qty) > 100){ error=true; msg="Quantity must be from 1 to 100"}
	
	if(error){ alert(msg); }
	else{ sbmDltSrlNumGrp(str, cls, ven, sty, clr, siz, desc, clrnm, siznm, qty); }
}
//==============================================================================
//submit new serial number
//==============================================================================
function sbmDltSrlNumGrp(str, cls, ven, sty, clr, siz, desc, clrnm, siznm, qty)
{
	SelStr = str;
	SelCls = cls;
	SelVen = ven;
	SelSty = sty;
	SelClr = clr;
	SelSiz = siz;
	SelDesc = desc;
	SelClrnm = clrnm;
	SelSiznm = siznm;

	var date = new Date();
	var mdy = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
	var reason = " ";	

	hidePanel("dvItem");
	hidePanel("dvCont");

	url="RentContractSave.jsp?"
      + "Cls=" + cls
      + "&Ven=" + ven
      + "&Sty=" + sty
      + "&Clr=" + clr
      + "&Siz=" + siz
      + "&Str=" + str
      + "&Reason=" + reason
      + "&NumSn=" + qty
      + "&Action=DLT_LAST_SN"
	;
	//alert(url);
	window.frame1.location.href=url;
}
//==============================================================================
// refresh serial number
//==============================================================================
function refreshSrl()
{
   getSrlNum(SelStr, SelCls, SelVen, SelSty, SelClr, SelSiz, SelDesc, SelClrnm, SelSiznm, 0);
}
//==============================================================================
// get Comments
//==============================================================================
function getCommt(invId, arg)
{
   var objnm = "tdDspCommt" + arg;
   SelObj = document.all[objnm];
   var url = "RentItemComments.jsp?"
     + "InvId=" + invId
     + "&Action=INV_ID_COMMT"

   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// get comments
//==============================================================================
function showComments(commId, firstTy, firstId, secondTy, secondId, thirdTy, thirdId
      , line, subType, commt, recUsr, recDt, recTm)
{
   var hdr = "All Comments";
   var html = "<table class='tbl02'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvComment&#34;);' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"
    + "<tr><td class='Prompt'>" + popComments(commId, firstTy, firstId, secondTy, secondId, thirdTy, thirdId
      , line, subType, commt, recUsr, recDt, recTm)
     + "</td></tr>"
   + "</table>"

   var pos = getObjPosition(SelObj);
   document.all.dvComment.innerHTML = html;
   document.all.dvComment.style.left= (getLeftScreenPos() + 50)  + "px";
   document.all.dvComment.style.top= (pos[1] + 25)  + "px";
   document.all.dvComment.style.visibility = "visible";
}
//==============================================================================
// populate customer equipment
//==============================================================================
function popComments(commId, firstTy, firstId, secondTy, secondId, thirdTy, thirdId
      , line, subType, commt, recUsr, recDt, recTm)
{
  var panel = "<table class='tbl02'>"
  panel += "<tr class='trHdr01'>"
         + "<th class='th13'>Type</th>"
         + "<th class='th13' width='75%'>Comments</th>"
         + "<th class='th13'>User</th>"
         + "<th class='th13'>Date</th>"
         + "<th class='th13'>Time</th>"
       + "</tr>"

  var clsId = "1";
  for(var i=0, j=0; i < commId.length; i++)
  {
     if(i > 0 && commId[i] != commId[i-1])
     {
        if( clsId=="1" ){ clsId = ""; }
        else { clsId = "1"; }
     }

     if(i == 0 || i > 0 && commId[i] != commId[i-1])
     {
        panel += "<tr class='trDtl04" + clsId + "' id='trCommt" + j + "'>"
        panel += "<td class='td11' id='tdType" + j + "'>" + subType[i] + "</td>"
        panel += "<td class='td11'>"
        j++;
        NumOfCommt = j;
     }

     panel += commt[i];

     if( commId[i] != commId[i+1])
     {
        panel += "</td>"
               + "<td class='td11' nowrap>" + recUsr[i] + "</td>"
               + "<td class='td11' nowrap>" + recDt[i] + "</td>"
               + "<td class='td11' nowrap>" + recTm[i] + "</td>"
          + "</tr>"
     }
  }

  panel += "</table>";
  return panel;
}
//==============================================================================
// filter comments
//==============================================================================
function filterCommt(grp)
{
   for(var i=0; i < NumOfCommt; i++)
   {
      var tdname = "tdType" + i;
      var trname = "trCommt" + i;
      if(grp == "All" || document.all[tdname].innerHTML == grp)
      {
         document.all[trname].style.display="block";
      }
      else{ document.all[trname].style.display="none"; }
      }
}
//==============================================================================
// change item availability
//==============================================================================
function chgItmAvail(invId, action, srlNum )
{
   var hdr = "Change Item Status &nbsp; Serial# " + srlNum;

   var html = "<table class='tbl02'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popItmAvail(invId, action)

   html += "</td></tr></table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.width = 600;
   document.all.dvItem.style.left= getLeftScreenPos() + 300;
   document.all.dvItem.style.top= getTopScreenPos() + 120;
   document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate Marked Item Panel
//==============================================================================
function popItmAvail(invId, action)
{
   var panel = "<table class='tbl02'>";
   panel += "<tr class='trDtl15'>"
             + "<td><textarea name='Commt' cols=70 rows=5></textarea></td>"
          + "</tr>"
   if (action == "RMV_INV_AVAIL")
   {
      panel += "<tr class='trDtl15'>"
            + "<td nowrap>Reason" 
            + " &nbsp; <input name='Reason' type='radio' value='NOT COUNTED' checked>Not Counted"
            + " &nbsp; <input name='Reason' type='radio' value='DAMAGED'>Damaged"
            + " &nbsp; <input name='Reason' type='radio' value='STOLEN' >Lost/Stolen"
            + " &nbsp; <input name='Reason' type='radio' value='WARNOUT' >Worn out</td>"
          + "</tr>"
   }
   
          
   panel += "<tr><td class='Prompt1' colspan=5>"
   if (action == "RMV_INV_AVAIL")
    {
    	panel += "<button onClick='setItmUanavail(&#34;" + invId + "&#34;,&#34;" + action
    	            + "&#34;);' class='Small'>Unavailable</button> &nbsp; &nbsp;"
     }
        	   else
        	   {
        	      panel += "<button onClick='setItmUanavail(&#34;" + invId + "&#34;,&#34;" + action
        	            + "&#34;);' class='Small'>Make Available</button> &nbsp; &nbsp;"
        	   }

   panel += "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button> &nbsp; &nbsp;"
        + "</td></tr>"

   panel += "</table>";

   return panel;
}
//==============================================================================
// set Item status
//==============================================================================
function setItmUanavail(invId, action)
{
   var commt = document.all.Commt.value;
   commt = commt.replace(/\n\r?/g, '<br />');

   var reason = "";
   if (action == "RMV_INV_AVAIL")
   {
      for(var i=0; i < document.all.Reason.length; i++)
      {
         if(document.all.Reason[i].checked)
         {
           reason = document.all.Reason[i].value;
           break;
         }
      }
   }
   else { reason = "AVAILABLE"; }

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmItmAvail"

    var html = "<form name='frmItmAvail'"
       + " METHOD=Post ACTION='RentContractSave.jsp'>"
       + "<input class='Small' name='InvId'>"
       + "<input class='Small' name='Commt'>"
       + "<input class='Small' name='Reason'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);
   window.frame1.document.all.InvId.value = invId;
   window.frame1.document.all.Commt.value=commt;
   window.frame1.document.all.Reason.value=reason;
   window.frame1.document.all.Action.value=action;

   //alert(html)
   window.frame1.document.frmItmAvail.submit();
   hidePanel("dvItem");
}

//==============================================================================
// set test stamp
//==============================================================================
function setTestStamp(invId, action, srlNum)
{
	var hdr = "Set Test Stamp &nbsp; Serial# " + srlNum;

	   var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
	       + "</td></tr>"
	   html += "<tr><td class='Prompt' colspan=2>"

	   html += popTestStamp(invId, action)

	   html += "</td></tr></table>"

	   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "200"; }
	   else { document.all.dvItem.style.width = "auto"; }
	   
	   document.all.dvItem.innerHTML = html;
	   document.all.dvItem.style.left= getLeftScreenPos() + 300;
	   document.all.dvItem.style.top= getTopScreenPos() + 120;
	   document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate Marked Item Panel
//==============================================================================
function popTestStamp(invId, action)
{
   var panel = "<table  border=1 width='100%' cellPadding='0' cellSpacing='0' >";
   panel += "<tr class='trDtl15'>"
        + "<td>Grade:</td>"
        + "<td nowrap>" 
          	+ " <input type='radio' name='Grade' value='PASSED'>Passed &nbsp; " 
          	+ " <input type='radio' name='Grade' value='FAILED'>Failed"
        + "</td>"
     + "</tr>"
     + "<tr class='trDtl15'>"
     	+ "<td nowrap>Tech:</td>"
     	+ "<td nowrap><input name='Tech' maxlength='4' size='6'></td>"
  	+ "</tr>"
   
  	panel += "<tr class='trDtl15'>" 
  	 + "<td align=center colspan=2><button onClick='vldItmTest(&#34;" + invId + "&#34;,&#34;" + action
  		+ "&#34;);' class='Small'>Submit</button> &nbsp; &nbsp;"
  	panel += "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button> &nbsp; &nbsp;"
        + "</td></tr>"
   	panel += "</table>";
   	return panel;
}
//==============================================================================
//validate item test stamp
//==============================================================================
function vldItmTest(invId, action)
{
	var error = false;
	var msg = "";
	
	var grade = null;
	for(var i=0; i < document.all.Grade.length; i++)
	{
		if(document.all.Grade[i].checked){ grade = document.all.Grade[i].value; break; }
	}
	if(grade == null){ error=true; msg += "\nPlease check grade."; }
	
	var tech = document.all.Tech.value.trim();
	if(tech==""){error = true; msg += "\nPlease enter your employee number"; }
	else if(isNaN(tech)){error = true; msg += "\n>The employee number is not numeric"; }
	else if (!isEmpNumValid(tech)){error = true; msg += "\nEmployee number is invalid."; }	
    
	
	if(error) { alert(msg) }
	else { sbmItmTest(invId, grade, tech, action) }
}
//==============================================================================
//submit Item Test Grade 
//==============================================================================
function sbmItmTest(invId, grade, tech, action)
{
	url = "RentContractSave.jsp?InvId=" + invId
	 + "&Grade=" + grade
	 + "&Tech=" + tech
	 + "&Action=" + action
	;
	if(isIE || isSafari){ window.frame1.location.href = url; }
   else if(isChrome || isEdge) { window.frame1.src = url; }
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
// reload screen
//==============================================================================
function updSrlNum(invId, srlNum, val, name)
{
   var hdr = "Change Serial# " + srlNum;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popSrlNum(invId, srlNum, val, name)

   html += "</td></tr></table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.left= getLeftScreenPos() + 300;
   document.all.dvItem.style.top= getTopScreenPos() + 120;
   document.all.dvItem.style.visibility = "visible";
   document.all.dvItem.style.background = "khaki";
   
   if(name == "PURCHYR"){ document.all.PurchYr.focus(); }
   if(name == "BRAND"){ rtvVendors(); document.all.Ven.focus(); document.all.Ven.value=val;  }
   if(name == "MODEL"){ document.all.Model.focus();  document.all.Model.value = val; }
   if(name=="ADDDT"){ document.all.AddDate.value = val; }
}
//==============================================================================
// populate Marked Item Panel
//==============================================================================
function popSrlNum(invId, srlNum, val, name)
{
   var action = "";
   var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>";
   panel += "<tr class='trDtl32'>"
   if (name == "PURCHYR")
   {
      panel += "<td class='td11' nowrap>Purchase Year: </td>"
             + "<td><input class='Small' name='PurchYr' size=4 maxlength=4></td>"
      action = "UPD_PURCH_YR";
   }
   else if (name == "EQUIPTY")
   {
      panel += "<td class='td11' nowrap>Equipment Type: </td>"
            + "<td nowrap>"
            + "<input name='EquipTy' type='radio' value='L'>Lease &nbsp; "
            + "<input name='EquipTy' type='radio' value='R'>Rental &nbsp;"
            + "<input name='EquipTy' type='radio' value='ANY' checked>Any &nbsp;"
            + "</td>"
      action = "UPD_EQUIP_TYPE";
   }   
   else if (name == "BRAND")
   {
      panel += "<td class='td11' nowrap>Brand: </td>"
            + "<td nowrap>"
            + "<input name='Ven' class='Small' size=7 maxlength=5>&nbsp;"
            + "<input class='Small' name='VenName' size=50 value='Other' readonly>&nbsp;"
            + "<div id='dvVendor'></div>"
            + "</td>"
      action = "UPD_BRAND";
   }   
   else if (name == "MODEL")
   {
      panel += "<td class='td11' nowrap>Model: </td>"
            + "<td nowrap>"
            + "<input class='Small' name='Model' size=32 maxlength=30>&nbsp;"
            + "</td>"
      action = "UPD_MODEL";
   }
   else if (name == "ADDDT")
   {
      panel += "<td class='td11' nowrap>Add Date: </td>"
            + "<td nowrap>"
            + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;AddDate&#34;)'>&#60;</button>"
            + "<input class='Small' name='AddDate' type='text'  size=10 maxlength=10>&nbsp;"
            + "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, &#34;AddDate&#34;)'>&#62;</button>"
            + "&nbsp;&nbsp;"
            + "<a href='javascript:showCalendar(1, null, null, 600, 180, document.all.AddDate)' >"
            + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>"
            + "</td>"
      action = "UPD_ADDDT";
   }
   
   panel += "</tr>"

   panel += "<tr><td class='Prompt1' colspan=2>"
   panel += "<button onClick='validateSrlNumParts(&#34;" + invId + "&#34;,&#34;" + action
            + "&#34;);' class='Small'>Submit</button> &nbsp; &nbsp;"
   panel += "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button> &nbsp; &nbsp;"
        + "</td></tr>"

   panel += "</table>";

   return panel;
}
//==============================================================================
// validate serial number parts updates
//==============================================================================
function validateSrlNumParts(invId, action)
{
   var error = false;
   var msg = "";
   var yr = "";
   var type = "";
   var brand = "";
   var model = "";
   var addDt = "";

   // get current calendar year
   var date = new Date();
   var curYr = eval(date.getFullYear()) + 1;
   if(action=="UPD_PURCH_YR")
   {
      yr = document.all.PurchYr.value.trim();
      if(yr == ""){ error = true; msg = "Please enter purchase year."; }
      else if(isNaN(yr)){ error = true; msg = "Purchase year is not numeric."; }
      else if(eval(yr) < 2000 || eval(yr) > curYr){ error = true; msg = "Purchase year is out of range."; }
   }
   else if(action=="UPD_EQUIP_TYPE")
   {
      for(var i=0; i < document.all.EquipTy.length; i++)
      {
         if(document.all.EquipTy[i].checked)
         {
            type = document.all.EquipTy[i].value.trim();
            break;
         }
      }
   }
   else if(action=="UPD_BRAND")
   {
	   brand = document.all.Ven.value.trim();	   
   }
   else if(action=="UPD_MODEL")
   {
	   model = document.all.Model.value.trim();	   
   }
   else if(action=="UPD_ADDDT")
   {
	   addDt = document.all.AddDate.value.trim();	   
   }

   if(error) { alert(msg) }
   else { sbmSrlNumParts(invId, yr, type, brand,model,addDt, action) }
}
//==============================================================================
// submit serial number updates
//==============================================================================
function sbmSrlNumParts(invId, yr, type, brand,model,addDt, action)
{
   url="RentContractSave.jsp?"
      + "InvId=" + invId
      + "&PurchYr=" + yr
      + "&EquipTy=" + type
      + "&Brand=" + brand
      + "&Model=" + model
      + "&AddDt=" + addDt
      + "&Action=" + action
   ;
   //alert(url);
   window.frame1.location.href=url;
}
//==============================================================================
// delete serial
//==============================================================================
function dltSrlNum(invId, srlNum)
{
   var hdr = "Delete Serial# " + srlNum;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += "<table border=1 width='100%' cellPadding=0 cellSpacing=0 align=left>"
       + "<tr style='background: #cccfff; color:red; font-size:14px; font-weight:bold;'>"
           + "<td nowrap>Do you realy want to delete this inventory?</td>"
       + "</tr>"
       + "<tr>"
          + "<td align=center><button onClick='sbmDltSrlNum(&#34;" + invId + "&#34;);' class='Small'>Submit</button> &nbsp; &nbsp;"
          + "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button></td>"
       + "<tr>"
     + "</table>"

   html += "</td></tr></table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.left= getLeftScreenPos() + 300;
   document.all.dvItem.style.top= getTopScreenPos() + 140;
   document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// submit seraila number deletion
//==============================================================================
function sbmDltSrlNum(invId)
{
   url="RentContractSave.jsp?"
      + "InvId=" + invId
      + "&Action=DLT_SRL_NUM"
   ;
   //alert(url);
   window.frame1.location.href=url;
}
//==============================================================================
// reload screen
//==============================================================================
function refreshScreen()
{
  window.location.reload();
}
//==============================================================================
// show
//==============================================================================
function getContLst(invId)
{
   var date = new Date();
   var mdy = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

   url="RentalItmContLst.jsp?InvId=" + invId
         + "&FrDate=" + mdy
         + "&ToDate=ENDOFYEAR"
   ;
   //alert(url);
   window.frame1.location.href=url;
}
//==============================================================================
// show
//==============================================================================
function showItemCont(InvId, Cont, Cust, PickDt, RetDt, FirstNm, MInit, LastNm, HPhone, CPhone, EMail)
{
  var hdr = "Contract List";

  var html = "<table border=1 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvCont&#34;);' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popItemCont(InvId, Cont, Cust, PickDt, RetDt, FirstNm, MInit, LastNm, HPhone, CPhone, EMail)

   html += "</td></tr></table>"

   document.all.dvCont.innerHTML = html;   
   document.all.dvCont.style.left= getLeftScreenPos() + 350;
   document.all.dvCont.style.top= getTopScreenPos() + 50;
   document.all.dvCont.style.visibility = "visible";
   document.all.dvCont.style.width = "500px";      
}
//==============================================================================
// populate Item Contract List
//==============================================================================
function popItemCont(InvId, Cont, Cust, PickDt, RetDt, FirstNm, MInit, LastNm, HPhone, CPhone, EMail)
{
var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
   panel += "<tr class='trHdr01'>"
             + "<th class='th13' nowrap>Contract</th>"
             + "<th class='th13' nowrap>Name</th>"
             + "<th class='th13' nowrap>Home<br>Phone</th>"
             + "<th class='th13' nowrap>Cell<br>Phone</th>"
             + "<th class='th13' nowrap>E-Mail</th>"
          + "</tr>"

   for(var i=0; i < Cont.length; i++)
   {
      panel += "<tr class='trDtl04'>"
          + "<td class='td11' nowrap><a href='RentContractInfo.jsp?ContId=" + Cont[i] + "' target='_blank'>" + Cont[i] + "</a></td>"
          + "<td class='td11' nowrap>" + FirstNm[i] + " " + MInit[i] + " " + LastNm[i] + "</td>"
          + "<td class='td11' nowrap>" + HPhone[i] + "&nbsp;</td>"
          + "<td class='td11' nowrap>" + CPhone[i] + "&nbsp;</td>"
          + "<td class='td11' nowrap>" + EMail[i] + "&nbsp;</td>"
        + "</tr>"
   }

   panel += "<tr><td class='Prompt1' colspan=5>"
        + "<button onClick='hidePanel(&#34;dvCont&#34;);' class='Small'>Close</button> &nbsp; &nbsp;"
        + "</td></tr>"

   panel += "</table>";

   return panel;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel(obj)
{   
	if(document.all.CalendarMenu != null){ hidetip2(); }
	document.all[obj].innerHTML = " ";
   	document.all[obj].style.visibility = "hidden";   
}
//==============================================================================
// show help
//==============================================================================
function getHelp(on, obj)
{
   if(on)
   {
      var pos = getObjPosition(obj);
      var posX = pos[0] + 35;
      var posY = pos[1] - 15;
      document.all.dvHelp.innerHTML = "Click to Add";
      document.all.dvHelp.style.left = posX + "px";
      document.all.dvHelp.style.top = posY + "px";
      document.all.dvHelp.style.visibility = "visible";
   }
   else{document.all.dvHelp.style.visibility = "hidden";}
}
//==============================================================================
// redispaly page with or without new items
//==============================================================================
function setInclItem(incl)
{
   var url = "RentInvListPiWi.jsp"
   var qstr = window.location.search

   var pos = qstr.indexOf("&Incl=")

   if(pos > 0) { qstr = qstr.substring(0, pos); }
   if(incl){ qstr += "&Incl=Y"; }
   url += qstr;

   //alert(url);
   window.location.href=url;
}

//==============================================================================
//retreive vendors
//==============================================================================
function rtvVendors()
{
	if (Vendor==null)
	{
		var url = "RetreiveVendorList.jsp"
		window.frame1.location = url;
	}
	else 
	{ 
		showVendors(Vendor, VenName);
	}
}
//==============================================================================
//popilate division selection
//==============================================================================
function showVendors(ven, venName)
{
	Vendor = ven;
	VenName = venName;
	var html = "<input name='FndVen' class='Small' size=5 maxlength=5>&nbsp;"
  		+ "<input name='FndVenName' class='Small1' size=25 maxlength=25>&nbsp;"
  		+ "<button onclick='findSelVen()' class='Small'>Find</button>&nbsp;";
	
	html += "<div id='dvInt' class='dvInternal'>"
      + "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='font-size:10px;'>"
	for(var i=0; i < ven.length; i++)
	{
  		html += "<tr id='trVen'><td style='cursor:default;' onclick='javascript: showVenSelect(&#34;" + ven[i] + "&#34;, &#34;" + venName[i] + "&#34;)'>" + venName[i] + "</td></tr>"
	}
	html += "</table></div>"
	var pos = getObjPosition(document.all.VenName)

	document.all.dvVendor.innerHTML = html;
	document.all.dvVendor.style.left= pos[0] + "px";
	document.all.dvVendor.style.top= (pos[1] - (-25)) + "px";
	document.all.dvVendor.style.visibility = "visible";
}
//==============================================================================
//show selected Department Selected
//==============================================================================
function showVenSelect(ven, vennm)
{
	document.all.VenName.value = vennm
	document.all.Ven.value = ven
}
 
//==============================================================================
//find selected vendor
//==============================================================================
function findSelVen()
{
	var ven = document.all.FndVen.value.trim().toUpperCase();
	var vennm = document.all.FndVenName.value.trim().toUpperCase();
	var dvVen = document.all.dvVendor
	var fnd = false;

	// zeroed last search
	if(ven != "" && ven != " " || LastVen != vennm) LastTr=-1;
	LastVen = vennm;

	for(var i=LastTr+1; i < Vendor.length; i++)
	{
  		if(ven != "" && ven != " " && ven == Vendor[i]) { fnd = true; LastTr=i; break;}
  		else if(vennm != "" && vennm != " " && VenName[i].indexOf(vennm) >= 0) { fnd = true; LastTr=i; break;}
  		document.all.trVen[i].style.color="black";
	}

	// if found set value and scroll div to the found record
	if(fnd)
	{
  		var pos = document.all.trVen[LastTr].offsetTop;
  		document.all.trVen[LastTr].style.color="red";
  		dvInt.scrollTop=pos;
	}
	else { LastTr=-1; }
}
//==============================================================================
//populate date with yesterdate
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
// resubmit program with with different data types
//==============================================================================
function  setUcr(ucr)
{ 	
	var url = "RentInvListPiWi.jsp?"
	
	for(var i=0; i < ClsLst.length; i++){ url += "&Cls=" + ClsLst[i]; }
	for(var i=0; i < StrLst.length; i++){ url += "&Str=" + StrLst[i]; }
	
	url += "&Incl=" + Incl;
	url += "&Sort=" + Sort;
	url += "&Year=" + Year;
	url += "&Ucr=" + ucr;
	
	window.location.href=url;
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
<div id="dvHelp" class="dvHelp"></div>
<div id="dvChkItm" class="dvItem"></div>
<div id="dvCont" class="dvItem"></div>
<div id="dvItem" class="dvItem"></div>
<div id="dvComment" class="dvItem"></div>
 
<!-------------------------------------------------------------------->

    <table class="tbl01">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>Rental Inventory Cycle Count Reconciliation
        <br>Fiscal Year: <%=sYear %> 
        <br><input type="radio" name="inpUcr" value="U" <%if(sUcr.equals("U")){%>checked<%}%> onclick="setUcr('U')">Unit &nbsp;&nbsp;
            <input type="radio" name="inpUcr" value="C" <%if(sUcr.equals("C")){%>checked<%}%> onclick="setUcr('C')">Cost &nbsp;&nbsp;
            <input type="radio" name="inpUcr" value="R" <%if(sUcr.equals("R")){%>checked<%}%> onclick="setUcr('R')">Retail &nbsp;&nbsp;
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="RentInvListPiWiSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page.<br>
      &nbsp; &nbsp; &nbsp;
      
      <br>
     <span style="background: yellow;">
     Note:  Variance does not include S/N's that have been removed from availability,<br>OR if the S/N is listed on a Contract that is still (Open/Picked Up status).
     </span> 
     
     <br>
     <br>
      
  <div id="dvShowClsTot"></div>    
  <br><br>    
      
  <!----------------------- Item List ------------------------------>
     <table  class="tbl04" id="tbDetail">
      <thead id="thead1">
       <tr class="trHdr01">
          <th class="th13" rowspan=3>Dpt</th>
          <th class="th13" rowspan=3>Class</th>
          <th class="th13" rowspan=3>Size</th>
          <th class="th13" rowspan=2 colspan=3>Total</th>
          
          <td class="Separator02">&nbsp;</td>
          <th class="th13" colspan="<%=iNumOfStr * 4%> ">Stores
            <br><span id="spnStrHdr">Inventory</span> &nbsp;
          </th>
       </tr>
       <tr class="trHdr01">
          <%for(int i=0; i < iNumOfStr; i++){%>
             <td class="Separator02" rowspan=2>&nbsp;</td>
             <th class="th13" colspan=3><%=sStr[i]%></th>             
          <%}%>
       </tr>
       
       <tr class="trHdr01">
          <th class="th13">Defined</th>
          <th class="th13">Scanned</th>
          <th class="th13" >Var<br>+/-</th>
          <%for(int i=0; i < iNumOfStr; i++){%>
             <th class="th13">Defined</th>
             <th class="th13">Scanned</th>
             <th class="th13">Var<br>+/-</th>
          <%}%>
       </tr>
       
     </thead> 
     <tbody id="tbody1">
  <!-------------------------- Order List ------------------------------->
      <%
       int iLine = 0;
       while(rentinv.getNext())
       {
          rentinv.getItemList();

          String sDpt = rentinv.getDpt();
          String sCls = rentinv.getCls();
          String sVen = rentinv.getVen();
          String sSty = rentinv.getSty();
          String sClr = rentinv.getClr();
          String sSiz = rentinv.getSiz();
          String sDptNm = rentinv.getDptNm();
          String sClsNm = rentinv.getClsNm();
          String sClrNm = rentinv.getClrNm();
          String sSizNm = rentinv.getSizNm();
          String sTotQty = rentinv.getTotQty();
          String sTotCnt = rentinv.getTotCnt();
          String sTotVar = rentinv.getTotVar();
          
          rentinv.getItemDtl();
          String [] sStrQty = rentinv.getStrQty();
          String [] sStrAvlQty = rentinv.getStrAvlQty();
          String [] sStrCount = rentinv.getStrCount();
          String [] sStrVar = rentinv.getStrVar();
          
          if(sUcr.equals("C"))
          {
        	  sTotQty = rentinv.getTotCost();
              sTotCnt = rentinv.getTotCntCost();
              sTotVar = rentinv.getTotVarCost();
              
              sStrQty = rentinv.getStrCost();
              sStrCount = rentinv.getStrCntCost();
              sStrVar = rentinv.getStrVarCost();
          }
          
          if(sUcr.equals("R"))
          {
        	 sTotQty = rentinv.getTotRet();
             sTotCnt = rentinv.getTotCntRet();
             sTotVar = rentinv.getTotVarRet();
              
             sStrQty = rentinv.getStrRet();
             sStrCount = rentinv.getStrCntRet();
             sStrVar = rentinv.getStrVarRet();
          }
          
          if(iLine > 0 && iLine % 30 == 0){
      %> 
      <tr class="trHdr06">
          <th class="th02">Dpt</th>
          <th class="th02">Class</th>
          <th class="th02">Size</th>
          <th class="th02"colspan=3>Total</th>
          <%for(int i=0; i < iNumOfStr; i++){%>
             <td class="Separator02">&nbsp;</td>
             <th class="th02"colspan=3><%=sStr[i]%></th>
          <%}%>
      </tr>     
      <%}
        iLine++;
      %>
      
         <tr class="trDtl04">
           <td class="td11" nowrap><%=sDptNm%></td>
           <td class="td11" nowrap><%=sClsNm%></td>
           <td class="td11" nowrap><%=sSizNm%></td>
           <td class="td12"><%=sTotQty%></td>
           <td class="td12"><%=sTotCnt%></td>
           <td class="td12"  style="background: pink; font-weight: bold;" nowrap><%=sTotVar%></td>
           
           <%for(int i=0; i < iNumOfStr; i++){%>
              <td class="Separator02">&nbsp;</td>
              <td class="td12" style="display: none;" id="tdAllInv">&nbsp;<%=sStrQty[i]%></td>
              <td class="td12" id="tdAvlInv" >
                   <%if(!sStrQty[i].equals("")){%>
                   <a href="javascript: getSrlNum('<%=sStr[i]%>', '<%=sCls%>', '<%=sVen%>', '<%=sSty%>',
                   '<%=sClr%>', '<%=sSiz%>', ' ', '<%=sClrNm%>', '<%=sSizNm%>', '<%=i%>')"><%=sStrQty[i]%></a>
                      
                   <%} else{%>
                         &nbsp;
                   <%}%>
              </td>
              <td class="td12" id="tdAllInv"> &nbsp;<%=sStrCount[i]%></td>
              <td class="td12" id="tdAllInv"  nowrap style="background: pink; font-weight: bold;"> &nbsp;<%=sStrVar[i]%></td>
           <%}%>
         </tr>
      <%}%>
     
     <!----------------------- Report totals ------------------------> 
      <%
      rentinv.setTotal();
      String [] sStrQty = rentinv.getStrQty();
      String [] sStrCount = rentinv.getStrCount();
      String [] sStrVar = rentinv.getStrVar();
      
      String sTotQty = rentinv.getTotQty();
      String sTotCnt = rentinv.getTotCnt();
      String sTotVar = rentinv.getTotVar();
      
      if(sUcr.equals("C"))
      {
    	  sTotQty = rentinv.getTotCost();
          sTotCnt = rentinv.getTotCntCost();
          sTotVar = rentinv.getTotVarCost();
          
          sStrQty = rentinv.getStrCost();
          sStrCount = rentinv.getStrCntCost();
          sStrVar = rentinv.getStrVarCost();
      }
      
      if(sUcr.equals("R"))
      {
    	 sTotQty = rentinv.getTotRet();
         sTotCnt = rentinv.getTotCntRet();
         sTotVar = rentinv.getTotVarRet();
          
         sStrQty = rentinv.getStrRet();
         sStrCount = rentinv.getStrCntRet();
         sStrVar = rentinv.getStrVarRet();
      }
      %>
      	<tr class="trDtl15">
      		<td class="td11">Totals</td>
           <td class="td11" nowrap>&nbsp;</td>
           <td class="td11" nowrap>&nbsp;</td>
           <td class="td12" nowrap><%=sTotQty%></td>
           <td class="td12" nowrap><%=sTotCnt%></td>
           <td class="td12" nowrap style="background: pink; font-weight: bold;"><%=sTotVar%></td>
                      
           <%for(int i=0; i < iNumOfStr; i++){%>
           	  <td class="Separator02">&nbsp;</td>
              <td class="td12" nowrap>&nbsp;<%=sStrQty[i]%></td>
              <td class="td12" nowrap>&nbsp;<%=sStrCount[i]%></td>
              <td class="td12" nowrap style="background: pink; font-weight: bold;" >&nbsp;<%=sStrVar[i]%></td>
               
           <%} %>
      	</tr>
      </tbody>
    </table>
  <!----------------------- end of table ------------------------>
  <br>
  
  <!----------------------- Dpt/Cls Totals ------------------------>
  <div id="dvLoadClsTot">
  
     <table  class="tbl04" id="tbClsTot">
      <tr class="trHdr01">
         <th class="th13" colspan="<%=iNumOfStr * 4 + 5%> ">Class Totals
      </tr>
      <tr class="trHdr01">
          <th class="th13" rowspan=3>Dpt</th>
          <th class="th13" rowspan=3>Class</th>
          <th class="th13" rowspan=2 colspan=3>Total</th>
          
          <td class="Separator02">&nbsp;</td>
          <th class="th13" colspan="<%=iNumOfStr * 4%> ">Stores
            <br><span id="spnStrHdr">Inventory</span> &nbsp;
          </th>
       </tr>
       <tr class="trHdr01">
          <%for(int i=0; i < iNumOfStr; i++){%>
             <td class="Separator02" rowspan=2>&nbsp;</td>
             <th class="th13" colspan=3><%=sStr[i]%></th>             
          <%}%>
       </tr>
       
       <tr class="trHdr01">
          <th class="th13">Defined</th>
          <th class="th13">Scanned</th>
          <th class="th13" >Var<br>+/-</th>
          <%for(int i=0; i < iNumOfStr; i++){%>
             <th class="th13">Defined</th>
             <th class="th13">Scanned</th>
             <th class="th13">Var<br>+/-</th>
          <%}%>
       </tr>
       
     <%rentinv.setNumOfCls();
     int iNumOfCls = rentinv.getNumOfCls();
     
     for(int i=0; i < iNumOfCls; i++)
     {
     	rentinv.setClsTot();    
     	String sDptNm = rentinv.getDptNm();
     	String sClsNm = rentinv.getClsNm();
     	sStrQty = rentinv.getStrQty();
        sStrCount = rentinv.getStrCount();
        sStrVar = rentinv.getStrVar();
         
        sTotQty = rentinv.getTotQty();
        sTotCnt = rentinv.getTotCnt();
        sTotVar = rentinv.getTotVar();
        
        if(sUcr.equals("C"))
        {
      	  sTotQty = rentinv.getTotCost();
            sTotCnt = rentinv.getTotCntCost();
            sTotVar = rentinv.getTotVarCost();
            
            sStrQty = rentinv.getStrCost();
            sStrCount = rentinv.getStrCntCost();
            sStrVar = rentinv.getStrVarCost();
        }
        
        if(sUcr.equals("R"))
        {
      	 sTotQty = rentinv.getTotRet();
           sTotCnt = rentinv.getTotCntRet();
           sTotVar = rentinv.getTotVarRet();
            
           sStrQty = rentinv.getStrRet();
           sStrCount = rentinv.getStrCntRet();
           sStrVar = rentinv.getStrVarRet();
        }
     %>
        <tr class="trDtl15">
      	   <td class="td11" nowrap><%=sDptNm%></td>
           <td class="td11" nowrap><%=sClsNm%></td>
           <td class="td12" nowrap><%=sTotQty%></td>
           <td class="td12" nowrap><%=sTotCnt%></td>
           <td class="td12" nowrap style="background: pink; font-weight: bold;"><%=sTotVar%></td>
                      
           <%for(int k=0; k < iNumOfStr; k++){%>
           	  <td class="Separator02">&nbsp;</td>
              <td class="td12" nowrap>&nbsp;<%=sStrQty[k]%></td>
              <td class="td12" nowrap>&nbsp;<%=sStrCount[k]%></td>
              <td class="td12" nowrap style="background: pink; font-weight: bold;" >&nbsp;<%=sStrVar[k]%></td>
               
           <%} %>
      	</tr>
     <%}%>
     
     <%
      	rentinv.setTotal();
      	sStrQty = rentinv.getStrQty();
      	sStrCount = rentinv.getStrCount();
      	sStrVar = rentinv.getStrVar();
      
      	sTotQty = rentinv.getTotQty();
      	sTotCnt = rentinv.getTotCnt();
      	sTotVar = rentinv.getTotVar();
      	
      	if(sUcr.equals("C"))
        {
      	    sTotQty = rentinv.getTotCost();
            sTotCnt = rentinv.getTotCntCost();
            sTotVar = rentinv.getTotVarCost();
            
            sStrQty = rentinv.getStrCost();
            sStrCount = rentinv.getStrCntCost();
            sStrVar = rentinv.getStrVarCost();
        }
        
        if(sUcr.equals("R"))
        {
      	 sTotQty = rentinv.getTotRet();
           sTotCnt = rentinv.getTotCntRet();
           sTotVar = rentinv.getTotVarRet();
            
           sStrQty = rentinv.getStrRet();
           sStrCount = rentinv.getStrCntRet();
           sStrVar = rentinv.getStrVarRet();
        }
      	%>
      	<tr class="trDtl16">
      		<td class="td11">Totals</td>
           <td class="td11" nowrap>&nbsp;</td>
           <td class="td12" nowrap><%=sTotQty%></td>
           <td class="td12" nowrap><%=sTotCnt%></td>
           <td class="td12" nowrap style="background: pink; font-weight: bold;"><%=sTotVar%></td>
                      
           <%for(int i=0; i < iNumOfStr; i++){%>
           	  <td class="Separator02">&nbsp;</td>
              <td class="td12" nowrap>&nbsp;<%=sStrQty[i]%></td>
              <td class="td12" nowrap>&nbsp;<%=sStrCount[i]%></td>
              <td class="td12" nowrap style="background: pink; font-weight: bold;" >&nbsp;<%=sStrVar[i]%></td>
               
           <%} %>
      	</tr> 
     
     
     </table>
  </div>
  
  
     </td>
   </tr>

  </table>
 </body>
</html>


<%  rentinv.disconnect();
  }%>