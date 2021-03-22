<%@ page import="rciutility.StoreSelect, dcfrtbill.DstStsInq, java.util.*"%>
<%
   long lStartTime = (new Date()).getTime();

   String sRcdSrc = request.getParameter("RecSrc");
   String sIStore = request.getParameter("IStore");
   String sIStrName = request.getParameter("IStrName");
   String sDStore = request.getParameter("DStore");
   String sDStrName = request.getParameter("DStrName");
   String sDistro = request.getParameter("Distro");
   String sFrom = request.getParameter("FromDate");
   String sTo = request.getParameter("ToDate");
   String sStatus = request.getParameter("Status");
   String sSort = request.getParameter("Sort");
   String sPageType = request.getParameter("PageType");
   
   String sPonum = request.getParameter("Ponum");
   String sAlloc = request.getParameter("Alloc");
   String sReceipt = request.getParameter("Receipt");
   String sSelPick = request.getParameter("Pick");
   String [] sSelDiv = request.getParameterValues("mDiv");

   if(sPonum==null || sPonum.equals("")) { sPonum = " "; }
   if(sAlloc==null || sAlloc.equals("")) { sAlloc = " "; }
   if(sReceipt==null || sReceipt.equals("")) { sReceipt = " "; }
   if(sSelPick==null || sSelPick.equals("")) { sSelPick = " "; }
   
   if(sSort==null) { sSort = "ISTR"; }
   if(sPageType==null) { sPageType = "I"; }
   
   if(sSelDiv==null) { sSelDiv = new String[]{"ALL"}; }
  
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=DstStsInq.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   boolean bAllow = sPageType.equals("A");
   System.out.println();
   if(!sPonum.trim().equals("") || !sAlloc.trim().equals("") || !sReceipt.trim().equals(""))
   {
	   sRcdSrc = "B"; sIStore = "ALLIW"; sDStore = "ALL"; sStatus = " ";
	   sFrom = "01/01/0001"; sTo = "12/31/2999";
   } 	   
  	//System.out.print("RecSrc: " + sRcdSrc + "<br>IssStr: " + sIStore + "<br>DstStr: " + sDStore
    //         + "<br>From: " + sFrom + "<br>To: " + sTo + "<br>Status: " + sStatus
    //         + "<br>sPonum=" + sPonum);
    DstStsInq dstinq = new DstStsInq(sRcdSrc, sIStore, sDStore, sFrom, sTo, sStatus, sDistro
		   ,sPonum, sAlloc, sReceipt, sSelPick, sSelDiv, sSort);

   int iNumOfDst = dstinq.getNumOfDst();
   String sIssStr = null;
   String sDstDate = null;
   String sSts = null;
   String sStsDate = null;
   String sQty = null;
   String sNetQty = null;
   String sCst = null;
   String sRet = null;
   String sPoNo = null;
   String sRecpt = null;
   String sAlcNo = null;
   String sShip = null;
   String sDiv = null;
   String sDpt = null;
   String sCls = null;
   String sSku = null;
   String sDesc = null;
   String sUpc = null;
   String sDstStr = null;
   String sDocNum = null;
   String sVen = null;
   String sSty = null;
   String sClr = null;
   String sSiz = null;
   String sVenName = null;
   String sRecord = null;
   String sAcknExp = null;
   String sAcknQty = null;
   String sPick = null;
   String sIssOnh = null;
   String sDstOnh = null;
   String sDscQty = null;
   String sIssAdj = null;
   String sDstAdj = null;
   String sCarton = null;   
   String sClrNm = null;
   String sSizNm = null;
   String sVenSty = null;

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;
   String sStrAllowed = session.getAttribute("STORE").toString();
   StrSelect = new StoreSelect(3);

   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();
   
   String sQryStr = request.getQueryString();
   if(sQryStr.indexOf("Sort=") >= 0)
   {
	   int i = sQryStr.indexOf("&Sort=");
	   int j = sQryStr.substring(i + 1).indexOf("&");
	   
	   //System.out.println("\n 1 ==>" + sQryStr.substring(0, i));
	   //System.out.println("\n 2 ==>" + sQryStr.substring(i+j));
	   
	   int k = i+j+1;	   
	   sQryStr = sQryStr.substring(0, i);
	   if(j > 0)	   
	   {
		   //System.out.println("\n i,j,k ==>" + i + ", " + j + ", " + k);
		   sQryStr += sQryStr.substring(k);
	   }
   }   
   //System.out.println("\n result ==>" + sQryStr);   
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        .link1 { color:blue; display:none;}
        table.DataTable { border: darkred solid 1px;background:cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: none;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.Row { background:lightgrey; font-family:Arial; font-size:10px }
        tr.Row1 { background:Cornsilk; font-family:Arial; font-size:10px }

        td.Cell { padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:left;}
        td.Cell1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:right;}

        td.Cell2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:Center;}

        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        .Small {font-family:Arial; font-size:10px }

        div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:100;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left;font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center;font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }

</style>
<title>Distribution Inq/Ackn</title>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
TotOnly = <%if(sSort.equals("ISTR") || sSort.equals("DSTR")){%>true;<%} else {%>false;<%}%>
var Stores = [<%=sStr%>]
var StoreNames = [<%=sStrName%>]
var DestStore = null;
var SentQty = null;
var SelCell = null;

Distro = new Array();
var Warn = false;
//--------------- End of Global variables ----------------
//--------------------------------------------------------
// function execute when page body is loading
//--------------------------------------------------------
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
	
   	setBoxclasses(["BoxName",  "BoxClose"], ["dvPrompt"]);
   	// show total only or total and detail lines
   	showTotDtl();
}
//--------------------------------------------------------
// whow total only or total and detail lines
//--------------------------------------------------------
function showTotDtl()
{
   var dtl = document.all.Detail
   var MaxDtl = 0;
   if(dtl != null){ MaxDtl = dtl.length }

   for(var i=0; i < MaxDtl; i++)
   {
      if(TotOnly)
      {
        dtl[i].style.display="none";
        document.styleSheets[0].rules[4].style.display = "none";
      }
      else
      {
    	  if(isIE && ua.indexOf("MSIE 7.0") >= 0)
    	  {
    		  dtl[i].style.display="block";
        	  document.styleSheets[0].rules[4].style.display = "block";
    	  }
    	  else
    	  {
    		  dtl[i].style.display="table-row";
        	  document.styleSheets[0].rules[4].style.display = "table-row";
    	  }
      }
   }

   if(TotOnly){  document.all.spnTotDtl.innerHTML = "Show Details"  }
   else { document.all.spnTotDtl.innerHTML = "Totals Only" }

   TotOnly = !TotOnly;
}
//==============================================================================
// set Acknowledge
//==============================================================================
function setAcknowl(ist, dst, ctn, sku, qty, cell)
{
   SelCell = cell;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>Carton " + ctn + " Acknowledgement</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popItemPanel(ist, dst, ctn, sku)+ "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvPrompt.style.width = "250";}
   else { document.all.dvPrompt.style.width = "auto";}
   
   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.left= getLeftScreenPos() + 250;
   document.all.dvPrompt.style.top= getTopScreenPos() + 60;
   document.all.dvPrompt.style.visibility = "visible";

   document.all.IsstrStr.value = ist
   DestStore = dst;
   SentQty = qty
   document.all.DestStr.value = dst;

   // populate sku and quantity
   if (sku == "NEW") { document.all.Sku.readOnly = false; }
   else if (sku != "ALL")
   {
     document.all.Sku.readOnly = true;
     document.all.Sku.value = sku;
     document.all.Qty.value = qty;
     document.all.Qty.focus();
     document.all.Qty.select();
   }
   else
   {
     //doDestStrSelect();
   }
   document.all.Ctn.value = ctn;
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popItemPanel(ist, dst, ctn, sku)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='5'>"

  // Issuing Store
  panel += "<tr><td class='Prompt' nowrap>Issuing Store:</td>"
         + "<td><input name='IsstrStr' class='Small' size=2 readOnly></td>"
         + "</tr>";

  // Exception
  //if(sku=="ALL")
  //{
     // Destination Store
  //   panel += "<tr><td class='Prompt' nowrap>Destination Store:</td>"
  //          + "<td class='Prompt' nowrap>"
  //             + "<input name='DestStr' class='Small' size=2 readOnly><br>"
  //             + "<select name='selDestStr' class='Small' onChange='chgDestStr(this)'></select>"
  //          + "</td>"
  //        + "</tr>";
  // }
  // else
  // {
      // Destination Store
      panel += "<tr><td class='Prompt' nowrap>Destination Store:</td>"
            + "<td class='Prompt' nowrap>"
               + "<input name='DestStr' class='Small' size=2 readOnly>"
            + "</td>"
          + "</tr>";
  // }

  // Destination Store
  panel += "<tr><td class='Prompt' nowrap>Carton:</td>"
           + "<td class='Prompt' nowrap>"
           + "<input name='Ctn' class='Small' size=6 readOnly><br>"
           + "</td>"
         + "</tr>";

  // Exception
  //if(sku=="ALL")
  //{
  //   panel += "<tr><td class='Prompt' nowrap>Exception:</td>"
  //          + "<td class='Prompt' nowrap>"
  //            + "<input class='Small' type='radio' name='Exp' value='N' checked>Normal &nbsp; &nbsp; &nbsp; &nbsp;"
  //            + "<input class='Small' type='radio' name='Exp' value='E'>Exception"
  //          + "</td>"
  //        + "</tr>";
  // }
     // Quantity
   // else if(sku!="ALL")
   if(sku!="ALL")
   {
      panel += "<tr><td class='Prompt' nowrap>Sku/UPC:</td>"
             + "<td class='Prompt' nowrap><input class='Small' name='Sku' size=16 maxlength=14>"
             + "</td>"
          + "</tr>"
          + "<tr><td class='Prompt' nowrap>Quantity:</td>"
             + "<td class='Prompt' nowrap><input class='Small' name='Qty' size=9 maxlength=9></td>"
          + "</tr>";
   }

  var type = "SKU";
  if (sku == "ALL"){ type = "ALL" }
  else if (sku == "NEW"){ type = "NEW" }

  // buttons
  panel += "<tr><td class='Prompt1' colspan='2'>"
        + "<button class='Small' id='Submit' onClick='Validate(&#34;" + type + "&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button class='Small' onClick='hidePanel();' class='Small'>Close</button>&nbsp;&nbsp;&nbsp;"
  panel += "</td></tr></table>";

  return panel;
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvPrompt.style.visibility = "hidden";
   SelItem = null;
   NewQty = null;
}
//==============================================================================
// Load Issuing Stores
//==============================================================================
function doDestStrSelect()
{
   var str = document.all.selDestStr;
   str.options[0] = new Option("--- Original Store --", "SAME");
   for (var i = 1, j=1; i < Stores.length; i++)
   {
     if(Stores[i] != "<%=sIStore%>" && Stores[i] != DestStore)
     {
        str.options[j++] = new Option(Stores[i] + " - " + StoreNames[i],Stores[i]);
     }
   }
   str.selectedIndex=0;
}
//==============================================================================
// change Destination Store
//==============================================================================
function chgDestStr(seldst)
{
   var str = seldst.options[seldst.selectedIndex].value.trim()
   if(str=="SAME")
   {
      document.all.DestStr.value = DestStore;
   }
   else
   {
      document.all.DestStr.value = str;
      document.all.Exp[0].checked = false;
      document.all.Exp[1].checked = true;
   }
}
//==============================================================================
// validate entered UPC and SKU
//==============================================================================
function  Validate(type)
{
   var msg = "";
   var error = false;

   var ist =  document.all.IsstrStr.value;
   var dst =  document.all.DestStr.value;
   var ctn =  document.all.Ctn.value;
   var sku = "ALL";
   var qty = 0;
   var exp = "E";
   var action = "ACKNOWL";

   // receveing store is not a same as destination store in pending destribution
   if(dst != DestStore){ exp = "N"; }

   if(type != "ALL")
   {
     sku = document.all.Sku.value.trim();
     if(type == "NEW")
     {
        if (sku == "") { error = true; msg += "SKU/UPC is not entered.\n" }
        else if (isNaN(sku))  { error = true; msg += "SKU/UPC is not numeric.\n" }
        else if (eval(sku) < 0)  { error = true; msg += "SKU/UPC should not be negative.\n" }
     }


     qty = document.all.Qty.value.trim();
     // validate quantity
     if (qty == "") { error = true; msg += "Quantity is not entered.\n" }
     else if (isNaN(qty))  { error = true; msg += "Quantity is not numeric.\n" }
     else if (eval(qty) < 0)  { error = true; msg += "Quantity should not be negative.\n" }
     exp = "N";
     action = "ITMACKN";
   }

   var msg = "Acknowledge Qty = " + qty
       + "<br>Shipped Qty = " + SentQty
       + "<br><br>You partially acknowledged a distribution."
       + "<br>Items with no acknowledgment will be charged back to issuing store."

       //+ "\n\nThese do not match, are you sure you want to continue \n with this acknowledgement quantity."

   if(error){ alert(msg) }
   else
   {
      if(type == "ALL" || SentQty == qty)  {  sbmAcknow(ist, dst, ctn, exp, sku, qty, action) }
      else if(type != "ALL" && SentQty != qty) { confAcknowl(msg, ist, dst, ctn, exp, sku, qty, action); }
      else{ hidePanel(); }
   }
}
//==============================================================================
// submit entered UPC or SKU
//==============================================================================
function confAcknowl(msg, ist, dst, ctn, exp, sku, qty, action)
{
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>Confirm Acknowledgement</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt1' colspan=2>&nbsp;<br>"
      + "<span style='font-size:12px; font-weight:bold'>" + msg + "</span><br><br>"
      + "<button class='Small' onclick='sbmAcknow(&#34;" + ist + "&#34;,&#34;" + dst + "&#34;,&#34;"
      + ctn + "&#34;,&#34;" + exp + "&#34;,&#34;" + sku + "&#34;,&#34;" + qty + "&#34;,&#34;"
      + action + "&#34;)'>Confirm</button> &nbsp; "
      + "<button class='Small' onclick='hidePanel();'>Cancel</button>"
    + "<br><br></td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvPrompt.style.width = "400";}
   else { document.all.dvPrompt.style.width = "auto";}
   
   document.all.dvPrompt.innerHTML = html; 
   document.all.dvPrompt.style.left = getLeftScreenPos() + 250;
   document.all.dvPrompt.style.top = getTopScreenPos() + 60;
   document.all.dvPrompt.style.visibility = "visible";

}
//==============================================================================
// submit entered UPC or SKU
//==============================================================================
function sbmAcknow(ist, dst, ctn, exp, sku, qty, action)
{
      var url = "DistAknowSave.jsp?IssStr=" + ist
        + "&DstStr=" + dst
        + "&Ctn=" + ctn
        + "&Sku=" + sku
        + "&Qty=" + qty
        + "&Expcept=" + exp
        + "&Action=" + action

     //alert(url)
     //window.location.href=url;
     window.frame1.location.href=url;
}
//==============================================================================
// restart after item entry
//==============================================================================
function reStart(err)
{
   msg = "";
   if(err != null && err.length > 0 )
   {
      for(var i=0; i < err.length; i++) { msg += err[i] + "\n"}
      alert(msg)
   }
   else
   {
      if(document.all[SelCell] != null)
      {
        document.all[SelCell].style.backgroundColor = "green";
        document.all[SelCell].innerHTML = "*";
      }
   }
   hidePanel();
}
//==============================================================================
// run on exit
//==============================================================================
//var needToConfirm = true;
//<%if(bAllow){%>
//window.onbeforeunload = confirmExit;
//function confirmExit()
//{
//    if (needToConfirm && isAcknolReq()) { return "Quantity Acknowldged does not \nequal quantity shipped."; }
//    needToConfirm = true;
//}
//<%}%>
//==============================================================================
// is acknowledge requered for some items
//==============================================================================
function isAcknolReq()
{
   var acknol = 0;
   var dtl = 0;
   var warn = false;
   for(var i=0; i < Distro.length; i++)
   {
      if(Distro[i].dtl)
      {
         if(Distro[i].acknol) { acknol++; }
         dtl++;
      }
   }
   warn = acknol > 0 && acknol < dtl;

   return warn;
}

//==============================================================================
// change acknowledgment flag for detail record
//==============================================================================
function chgObjAcknol(arg)
{
   for(var i=0; i < Distro.length; i++)
   {
      if(Distro[i].line == arg){  Distro[i].acknol = true;}
   }
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
  <div id="dvPrompt" class="Prompt"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
<!-------------------------------------------------------------------------------->
     <tr bgColor="ivory" style="z-index: 60; position: relative; top: expression(this.offsetParent.scrollTop-15);" >
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br><%if(bAllow){%>Distribution Acknowledgment<%} else {%>Distribution Status Inquiry<%}%>
          </b>
     </tr>
<!-------------------------------------------------------------------->
     <tr bgColor="ivory" style="z-index: 60; position: relative; top: expression(this.offsetParent.scrollTop-15);" >
      <td ALIGN="center" VALIGN="TOP" >

      <a onclick="needToConfirm=true;" href="/"><font color="red" size="-1">Home</font></a>&#62;
          <%if(bAllow){%><a onclick="needToConfirm=true;" href="DstStsAcknSel.jsp"><font color="red" size="-1">Selection</font></a><%}
          else {%><a href="DstStsInqSel.jsp"><font color="red" size="-1">Selection</font></a><%}%>&#62;
          <font size="-1">This Page.</font>
<p align=left>
 <table border=0 cellPadding="0" cellSpacing="0">
  <tr><td>
   <table class="DataTable" cellPadding="0" cellSpacing="0">
      <tr class="Row1"><th class="DataTable" colspan=2>Page Selection</th></tr>
      <tr class="Row1"><td class="Cell">Issuing Store</td>
          <td class="Cell"><%=sIStrName%></td>
      </tr>
      <tr class="Row1"><td class="Cell">Destination Store</td>
          <td class="Cell"><%=sDStrName%></td>
      </tr>
      <tr class="Row1"><td class="Cell">Document Number</td>
          <td class="Cell"><%=sDistro%>&nbsp;</td>
      </tr>
      <tr class="Row1"><td class="Cell">From Date</td>
          <td class="Cell"><%=sFrom%>&nbsp;</td>
      </tr>
      <tr class="Row1"><td class="Cell">To Date</td>
          <td class="Cell"><%=sTo%>&nbsp;</td>
      </tr>
   </table>
  </td>
  <td> &nbsp; &nbsp; &nbsp;<td>
  <td style="font-size:12px" nowrap>
  Warning: When acknowledging by item, do not leave a transfer partially acknowledged.
  Overnight processing will assume a zero quantity for <br>unacknowledged items and
  transfer them back to the shipping store. Complete the acknowledgement of a transfer
  before walking away or closing<br>this window.

  <td>
 </tr>
 </table> 
<!-------------------------------------------------------------------->
<p align=center>
      <a onclick="needToConfirm=false;" href="javascript:showTotDtl();"><span id="spnTotDtl" style="font-size:12px"></span></a>
      <%for(int i=0; i < 10; i++){%>&nbsp; <%}%>
      <span style="border: darkred solid 1px;background:green;font-size:10px;">&nbsp;*&nbsp;</span>
      <span style="font-size:10px;"> - Refresh your screen to display recently entered data</span>
</td>
 </tr>
 <tr bgColor="ivory">
  <td ALIGN="center" VALIGN="TOP" >
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr style="z-index: 60; position: relative; top: expression(this.offsetParent.scrollTop-16);">
	    	<th class="DataTable1"><a href="DstStsInq.jsp?RecSrc=<%=sRcdSrc%>&IStore=<%=sIStore%>&IStrName=<%=sIStrName%>&DStore=<%=sDStore%>&DStrName=<%=sDStrName%>&Distro=<%=sDistro%>&FromDate=<%=sFrom%>&ToDate=<%=sTo%>&Status=<%=sStatus%>&Sort=ISTR">Issuing<br>Store</a></th>
            <th class="DataTable1"><a href="DstStsInq.jsp?RecSrc=<%=sRcdSrc%>&IStore=<%=sIStore%>&IStrName=<%=sIStrName%>&DStore=<%=sDStore%>&DStrName=<%=sDStrName%>&Distro=<%=sDistro%>&FromDate=<%=sFrom%>&ToDate=<%=sTo%>&Status=<%=sStatus%>&Sort=DSTR">Dest<br>Store</a></th>
            <th class="DataTable1">Document<br>Number</th>
            <th class="DataTable1">Dist<br>Date</th>
            <th class="DataTable1">Carton</th>
            <th class="DataTable1">S<br>r<br>c</th>
            <th class="DataTable1">Status</th>
            <th class="DataTable1">Status<br>Date</th>
            <th class="DataTable1">
              <%if(bAllow){%>Div<br>#<%} else {%>
                   <a href="DstStsInq.jsp?<%=sQryStr%>&Sort=DIV">Div<br>#</a>
              <%}%>
            </th>
            <th class="DataTable1">Dpt<br>#</th>
            <th class="DataTable1">Cls<br>#</th>
            <th class="DataTable1">Short<br>SKU</th>
            <th class="DataTable1">UPC</th>
            <th class="DataTable1">Item<br>Description</th>
            <th class="DataTable1">Color</th>
            <th class="DataTable1">Size</th>
            <th class="DataTable1">Vendor<br>Style</th>
            <th class="DataTable1">
              <%if(bAllow){%>Vendor<%} else {%>
                 <a href="DstStsInq.jsp?<%=sQryStr%>&Sort=VEN">Vendor</a>
              <%}%>   
            </th>
            <th class="DataTable1">Orig<br>Qty</th>
            <th class="DataTable1">Net<br>Qty</th>
            <th class="DataTable1">Retail</th>
            <th class="DataTable1">P.O.<br>#</th>
            <th class="DataTable1">Receipt<br>#</th>
            <th class="DataTable1">Pick<br>#</th>
            <th class="DataTable1">Alc<br>#</th>
            <th class="DataTable1">Shipment<br>#</th>
            <th class="DataTable1">Iss Str<br>Onhand</th>
            <th class="DataTable1">Dst Str<br>Onhand</th>
            
            <%if(bAllow){%>
               <th class="DataTable">A<br>c<br>k<br>n<br>l</th>
            <%}%>
               <!--th class="DataTable">Acknowl.<br>Type</th -->
               <th class="DataTable">Acknowl.<br>Qty</th>
               <th class="DataTable">Diff</th>
               <th class="DataTable" colspan=2 nowrap>Last PI Count Results</th> 
        </tr>
        <tr style="z-index: 60; position: relative; top: expression(this.offsetParent.scrollTop-16);">
        	<%for(int i=0; i < 28; i++){%><th class="DataTable">&nbsp;</th><%}%>
        	<%if(bAllow){%><th class="DataTable">&nbsp;</th><%} %>
        	<%for(int i=0; i < 2; i++){%><th class="DataTable">&nbsp;</th><%}%> 
        	    	
        	<th class="DataTable">Iss Str</th>
            <th class="DataTable">Dst Str</th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
        <%String SvDocNum = null;%>
        <%for(int i=0, j=-1; i < iNumOfDst; i++) {
           // set distribution to array
           dstinq.setDstSts();

           sIssStr = dstinq.getIsStr();
           sDstDate = dstinq.getDstDate();
           sSts = dstinq.getsSts();
           sStsDate = dstinq.getStsDate();
           sQty = dstinq.getQty();
           sNetQty = dstinq.getNetQty();
           sCst = dstinq.getCst();
           sRet = dstinq.getRet();
           sPoNo = dstinq.getPoNo();
           sRecpt = dstinq.getRecpt();
           sAlcNo = dstinq.getAlcNo();
           sShip = dstinq.getShip();
           sDiv = dstinq.getDiv();
           sDpt = dstinq.getDpt();
           sCls = dstinq.getCls();
           sSku = dstinq.getSku();
           sDesc = dstinq.getDesc();
           sUpc = dstinq.getUpc();
           sDstStr = dstinq.getDstStr();
           sDocNum = dstinq.getDocNum();
           sVen = dstinq.getVen();
           sSty = dstinq.getSty();
           sClr = dstinq.getClr();
           sSiz = dstinq.getSiz();
           sVenName = dstinq.getVenName();
           sRecord = dstinq.getRecord();
           sAcknExp = dstinq.getAcknExp();
           sAcknQty = dstinq.getAcknQty();
           sPick = dstinq.getPick();
           sIssOnh = dstinq.getIssOnh();
           sDstOnh = dstinq.getDstOnh();
           sDscQty = dstinq.getDscQty();
           sIssAdj = dstinq.getIssAdj();
           sDstAdj = dstinq.getDstAdj();
           sCarton = dstinq.getCarton();
           sClrNm = dstinq.getClrNm();
           sSizNm = dstinq.getSizNm();
           sVenSty = dstinq.getVenSty();
           			
           String sExcept = "";
           if(sAcknExp.trim().equals("N")) { sExcept = "Normal"; }
           if(sAcknExp.trim().equals("E")) { sExcept = "Exception"; }

           if(SvDocNum == null || !SvDocNum.equals(sDocNum))
           {
              SvDocNum = sDocNum;
              j++;
           }
      %>

             <tr class="<%if(!sSku.trim().equals("TOTAL")){%>Row<%} else {%>Row1<%}%>"
                 id="<%if(!sSku.trim().equals("TOTAL")){%>Detail<%} else {%>Total<%}%>">
               <td class="Cell" nowrap><%=sIssStr%></td>
               <td class="Cell" nowrap><%=sDstStr%></td>
               <td class="Cell1" nowrap><%=sDocNum%></td>
               <td class="Cell" nowrap><%=sDstDate%></td>
               <td class="Cell" nowrap><%=sCarton%>&nbsp;</td>

               <%if(!sSku.trim().equals("TOTAL")){%>
                  <td class="Cell" nowrap><%=sRecord%></td>
                  <td class="Cell" nowrap><%=sSts%></td>
                  <td class="Cell" nowrap><%=sStsDate%></td>
                  <td class="Cell" nowrap><%=sDiv%></td>
                  <td class="Cell" nowrap><%=sDpt%></td>
                  <td class="Cell" nowrap><%=sCls%></td>
                  <td class="Cell" nowrap><%=sSku%></td>
                  <td class="Cell" nowrap><%=sUpc%></td>
                  <td class="Cell" nowrap><%=sDesc%></td>
                  <td class="Cell" nowrap><%=sClrNm%></td>
                  <td class="Cell" nowrap><%=sSizNm%></td>
                  <td class="Cell" nowrap><%=sVenSty%></td>
                  <td class="Cell" nowrap><%=sVenName%></td>
               <%}
                 else {%>   
                  <td class="Cell" colspan=13>&nbsp;</td>
               <%}%>


               <td class="Cell1" nowrap><%=sQty%></td>
               <td class="Cell1" <%if(!sSku.trim().equals("TOTAL")){%>style="background: lightgreen;"<%} %> nowrap>&nbsp;<%=sNetQty%></td>
               <td class="Cell1" nowrap><%=sRet%></td>
               <%if(!sSku.trim().equals("TOTAL")){%>
                 <td class="Cell" nowrap>&nbsp;<%=sPoNo%></td>
                 <td class="Cell" nowrap><%=sRecpt%></td>
                 <td class="Cell" nowrap><%=sPick%></td>
                 <td class="Cell" nowrap><%=sAlcNo%></td>
                 <td class="Cell" nowrap><%=sShip%></td>
                 <td class="Cell" nowrap><%if(!sIssOnh.equals("0")){%><%=sIssOnh%><%} else {%>&nbsp;<%}%></td>
                 <td class="Cell" nowrap><%if(!sDstOnh.equals("0")){%><%=sDstOnh%><%} else {%>&nbsp;<%}%></td>
               <%}
               
                 else {%>
                   <%if(bAllow){%>
                      <td class="Cell" colspan=7>
                         <a class="link1" onclick="needToConfirm=false;" href="javascript: setAcknowl('<%=sIssStr%>', '<%=sDstStr%>', '<%=sDocNum%>', 'NEW', '0', null )">Ackn. Unspecified SKU</a>
                      </td>
                   <%} else {%><td class="Cell" colspan=7>&nbsp;</td><%}%>
               <%}%>

               <%if(bAllow){%>
                  <td id="tdAckn<%=i%>" class="Cell" nowrap>
                    <a onclick="needToConfirm=false;chgObjAcknol('<%=i%>')" href="javascript: setAcknowl('<%=sIssStr%>', '<%=sDstStr%>', '<%=sDocNum%>', '<%if(sSku.trim().equals("TOTAL")){%>ALL<%} else {%><%=sSku%><%}%>', '<%=sQty%>', 'tdAckn<%=i%>' )"
                     <%if(!sAcknQty.equals("")){%> style="background: green"<%}%>>A</a>
                  </td>
               <%}%>
                  <td class="Cell1" nowrap>&nbsp;<%=sAcknQty%></td>
                  <td class="Cell1" nowrap>&nbsp;<%=sDstOnh%></td>
                  <td class="Cell1" nowrap><%if(!sIssAdj.trim().equals("") && !sIssAdj.trim().equals("0")){%><%=sIssAdj%><%} else {%>&nbsp;<%}%></td>
                  <td class="Cell1" nowrap><%if(!sDstAdj.trim().equals("") && !sDstAdj.trim().equals("0")){%><%=sDstAdj%><%} else {%>&nbsp;<%}%></td>
            </tr>
            <script>
              var objDistro = new Object();
              objDistro.grp = "<%=j%>";
              objDistro.line = "<%=i%>";
              objDistro.dtl = <%=!sSku.trim().equals("TOTAL")%>;
              objDistro.acknol = <%=!sAcknQty.equals("0") && !sAcknQty.equals("")%>;
              Distro[<%=i%>] = objDistro;
            </script>
        <%}%>
     </table>
<!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%
  dstinq.disconnect();

  long lEndTime = (new Date()).getTime();
  long lElapse = (lEndTime - lStartTime) / 1000;
  if (lElapse==0) lElapse = 1;
  //System.out.println("Elapse time:" + lElapse);
%>

<%}%>
