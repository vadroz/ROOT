<%@ page import="mozu_com.MozuOrdInfo, mozu_com.MozuOrdAdjInfo, mozu_com.MozuOrdReturns
  ,rciutility.RunSQLStmt, java.sql.*, java.util.*"%>
<%   
    String sSite = request.getParameter("Site");
    String sOrder = request.getParameter("Order");
    //System.out.println(sSite + "|" + sOrder);
//----------------------------------
// Application Authorization
//----------------------------------
//if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=MozuOrdInfo.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    String sUser = session.getAttribute("USER").toString();
    String sStrAllowed = session.getAttribute("STORE").toString();
    boolean bDltSts = false;
	if(sStrAllowed.startsWith("ALL")){ bDltSts = true; }    
    
    MozuOrdInfo ordLst = new MozuOrdInfo(sSite, sOrder, sUser);
    boolean bOrdFound = ordLst.getOrdFound();
    boolean bAllowButton = session.getAttribute("ECOMMERCE")!= null;
    boolean bAllowCancel = false;//session.getAttribute("ECOMMCNL")!= null;
    boolean bAllowAdj = session.getAttribute("ECOMADJ")!= null;
    boolean bAllowDist = session.getAttribute("ECPICKCHG")!= null; // changed allocation and Pick distribution

    String sOrd = ordLst.getOrd();
    String sCust = ordLst.getCust();    
    String sBillComp = ordLst.getBillComp();
    String sBillFNam = ordLst.getBillFNam();
    String sBillLNam = ordLst.getBillLNam();
    String sBillAddr1 = ordLst.getBillAddr1();
    String sBillAddr2 = ordLst.getBillAddr2();
    String sBillCity = ordLst.getBillCity();
    String sBillState = ordLst.getBillState();
    String sBillZip = ordLst.getBillZip();
    String sBillCountry = ordLst.getBillCountry();
    String sBillPhn = ordLst.getBillPhn();
    String sBillFax = ordLst.getBillFax();

    String sShipComp = ordLst.getShipComp();
    String sShipFNam = ordLst.getShipFNam();
    String sShipLNam = ordLst.getShipLNam();
    String sShipAddr1 = ordLst.getShipAddr1();
    String sShipAddr2 = ordLst.getShipAddr2();
    String sShipCity = ordLst.getShipCity();
    String sShipState = ordLst.getShipState();
    String sShipZip = ordLst.getShipZip();
    String sShipCountry = ordLst.getShipCountry();
    String sShipPhn = ordLst.getShipPhn();
    String sShipFax = ordLst.getShipFax();

    String sShipMthId = ordLst.getShipMthId();
    String sShipCost = ordLst.getShipCost();
    String sTaxRate = ordLst.getTaxRate();
    String sPayAmt = ordLst.getPayAmt();
    String sPayMth = ordLst.getPayMth();
    String sPayDecline = ordLst.getPayDecline();
    String sCashTender = ordLst.getCashTender();
    String sPoNum = ordLst.getPoNum();
    String sLocked = ordLst.getLocked();
    String sShipped = ordLst.getShipped();
    String sOrdVen = ordLst.getOrdVen();
    String sOrdDate = ordLst.getOrdDate();
    String sShipDate = ordLst.getShipDate();
    String sLstModDate = ordLst.getLstModDate();
    String sStatus = ordLst.getStatus();
    String sTotPayRcv = ordLst.getTotPayRcv();
    String sTotPayAuth = ordLst.getTotPayAuth();
    String sTax = ordLst.getTax();
    String sShipRes = ordLst.getShipRes();
    String sTender = ordLst.getTender();
    String sEmail = ordLst.getEmail();
    String sEmailSubscriber = ordLst.getEmailSubscriber();
    String sShipTot = ordLst.getShipTot();
    String sHandTot = ordLst.getHandTot();

    int iNumOfDtl = ordLst.getNumOfDtl();
    int iNumOfCtn = ordLst.getNumOfCtn();

    int iReadyWhsPrt = 0;
    int iReadyStrPrt = 0;

    MozuOrdAdjInfo ordadj = new MozuOrdAdjInfo(sSite, sOrder, sUser);

    boolean bAdjOrdFound = ordadj.getOrdFound();
    String sAdjId = ordadj.getAdjId();
    String sAdjShipChk = ordadj.getAdjShipChk();
    String sAdjShipCost = ordadj.getAdjShipCost();
    String sAdjTaxChk = ordadj.getAdjTaxChk();
    String sAdjTax = ordadj.getAdjTax();
    String sAdjDate = ordadj.getAdjDate();
    String sRefOnlCred = ordadj.getRefOnlCred();

    String sAdjDtlId = ordadj.getAdjDtlId();
    String sAdjSku = ordadj.getAdjSku();
    String sAdjQty = ordadj.getAdjQty();
    String sAdjRet = ordadj.getAdjRet();
    String sAdjOldRet = ordadj.getAdjOldRet();
    
    
    MozuOrdReturns ordret = new MozuOrdReturns(sSite, sOrder, sUser);

    boolean bOrdRetFound = ordret.getOrdFound();
    
    String sRetId = ordret.getRetId();
    String sRetIpSls = ordret.getRetIpSls();
    String sRetIpSlsDt = ordret.getRetIpSlsDt();
    String sRetIpSlsTm = ordret.getRetIpSlsTm();
    String sRetCrtUsr = ordret.getRetCrtUsr();
    String sRetCrtDt = ordret.getRetCrtDt();
    String sRetCrtTm = ordret.getRetCrtTm();
    String sRetAmt = ordret.getRetAmt();
    String sRetTax = ordret.getRetTax();
    String sRetShp = ordret.getRetShp();
    String sRetShpTax = ordret.getRetShpTax();
    String sRetNote = ordret.getRetNote();

    String sRetItmId = ordret.getRetItmId();
    String sRetItmSku = ordret.getRetItmSku();
    String sRetItmQtyRcv = ordret.getRetItmQtyRcv();
    String sRetItmQtyRSt = ordret.getRetItmQtyRSt();
    String sRetItmQtyShp = ordret.getRetItmQtyShp();
    String sRetItmQtyOrd = ordret.getRetItmQtyOrd();
    String sRetItmAmt = ordret.getRetItmAmt();
    String sRetItmTax = ordret.getRetItmTax();
    String sRetItmShp = ordret.getRetItmShp();
    String sRetItmShpTax = ordret.getRetItmShpTax();
    String sRetItmOrg = ordret.getRetItmOrg();
    String sRetItmNote = ordret.getRetItmNote();
    ordret.disconnect();
    
    boolean bStsExists = false;
    if(bDltSts)
    {
    	String sPrepStmt = "select shord"   	 	
  	   	 	+ " from rci.MoOrStsH"
   	   	 	+ " where ShSite=" + sSite + " and Shord=" + sOrder;
    	   	
    	RunSQLStmt runsql = new RunSQLStmt();
    	runsql.setPrepStmt(sPrepStmt);		   
    	runsql.runQuery();
    	if(runsql.readNextRecord()){ bStsExists = true; }    	
    	runsql.disconnect();
    } 
    
    // number of Return items
    int iNumOfRtn = ordLst.getNumOfRtn();
    // number of internal Notes
    int iNumOfIntNt = ordLst.getNumOfIntNt();
%>

<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        
        table.DataTable { padding: 0px; border-spacing: 0; border-collapse: collapse;  
              border: grey solid 1px; font-size:10px }
        table.DataTable1 { padding: 0px; border-spacing: 0; border-collapse: collapse;   
                background: LemonChiffon; border: grey solid 1px; font-size:10px }        
        
        th.DataTable { border-bottom: grey solid 1px; border-right: grey solid 1px; background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { border-bottom: grey solid 1px; border-right: grey solid 1px; cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}

        tr.DataTable { background: #E7E7E7; font-size:12px }
        tr.DataTable1 { background: CornSilk; font-size:12px }
        tr.DataTable2 { font-size:10px; vertical-aligh: middle}

        td.DataTable { border-bottom: grey solid 1px; border-right: grey solid 1px;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { border-bottom: grey solid 1px; border-right: grey solid 1px;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable12 { border-bottom: grey solid 1px; border-right: grey solid 1px;color:red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable11 { border-bottom: grey solid 1px; border-right: grey solid 1px;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; vertical-align: top; text-align:left; white-space:}
        td.DataTable2 { border-bottom: grey solid 1px; border-right: grey solid 1px;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { border-bottom: grey solid 1px; border-right: grey solid 1px;cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:100; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
              
        div.dvHoCtl { position:absolute; background-attachment: scroll;
              border: none; width:100; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}      

        td.BoxName {cursor:move; background: #016aab; 
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background: #016aab; 
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:11px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:11px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:11px; }

</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script name="javascript1.2">
var NumOfDtl = <%=iNumOfDtl%>;
var OrdDtlId = new Array();
var OrdCls = new Array();
var OrdVen = new Array();
var OrdSty = new Array();
var OrdClr = new Array();
var OrdSiz = new Array();
var OrdSku = new Array();
var OrdDesc = new Array();
var OrdMfg = new Array();
var OrdQty = new Array();
var OrdRet = new Array();
var OrigExtRet = new Array();
var OrdShpCost = "<%=sShipCost%>";
var OrdTaxAmt = "<%=sTax%>";
var TaxRate = "<%=sTaxRate%>";
var ShipCost = "<%=sShipCost%>";
var TotPay = "<%=sTotPayAuth%>";


var AdjId = <%if(sAdjId != null){%>"<%=sAdjId%>"<%} else {%>null<%}%>;
var AdjShipChk = <%if(sAdjId != null){%><%=sAdjShipChk.equals("Y")%><%} else {%>false<%}%>;
var AdjShipCost = <%if(sAdjId != null){%>"<%=sAdjShipCost%>"<%} else {%>null<%}%>;
var AdjTaxChk = <%if(sAdjId != null){%><%=sAdjTaxChk.equals("Y")%><%} else {%>false<%}%>;
var AdjRefOnlCred = <%if(sAdjId != null){%><%=sRefOnlCred.equals("Y")%><%} else {%>false<%}%>;
var AdjTax = <%if(sAdjId != null){%>"<%=sAdjTax%>"<%} else {%>null<%}%>;
var AdjDate = <%if(sAdjId != null){%>"<%=sAdjDate%>"<%} else {%>null<%}%>;
var AdjDtlId = [<%=sAdjDtlId%>];
var AdjSku = [<%=sAdjSku%>];
var AdjQty = [<%=sAdjQty%>];
var AdjRet = [<%=sAdjRet%>];
var AdjOldRet = [<%=sAdjOldRet%>];
var AdjOrdFound = <%=bAdjOrdFound%>;

var OrdRetFound = <%=bOrdRetFound%>;
var RetId = [<%=sRetId%>];
var RetIpSls = [<%=sRetIpSls%>];
var RetIpSlsDt = [<%=sRetIpSlsDt%>];
var RetIpSlsTm = [<%=sRetIpSlsTm%>];
var RetCrtUsr = [<%=sRetCrtUsr%>];
var RetCrtDt = [<%=sRetCrtDt%>];
var RetCrtTm = [<%=sRetCrtTm%>];
var RetAmt = [<%=sRetAmt%>];
var RetTax = [<%=sRetTax%>];
var RetShp = [<%=sRetShp%>];
var RetShpTax = [<%=sRetShpTax%>];
var RetNote = [<%=sRetNote%>];

var RetItmId = [<%=sRetItmId%>];
var RetItmSku = [<%=sRetItmSku%>];
var RetItmQtyRcv = [<%=sRetItmQtyRcv%>];
var RetItmQtyRSt = [<%=sRetItmQtyRSt%>];
var RetItmQtyShp = [<%=sRetItmQtyShp%>];
var RetItmQtyOrd = [<%=sRetItmQtyOrd%>];
var RetItmAmt = [<%=sRetItmAmt%>];
var RetItmTax = [<%=sRetItmTax%>];
var RetItmShp = [<%=sRetItmShp%>];
var RetItmShpTax = [<%=sRetItmShpTax%>];
var RetItmOrg = [<%=sRetItmOrg%>];
var RetItmNote = [<%=sRetItmNote%>];

var Used = false;
var SbmCmd = new Array();
var SbmLoop = 0;
var SbmQty = 0;
var SelCol=null;
var SelCell = new Array(NumOfDtl);
//------------------------------------------------------------------------------

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{	
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) 
	{  
	   isSafari = true;
	   setDraggable();
	}
	else { setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvHoCtl"]); }
	
    <%if(!bOrdFound){%>
      alert("Order is not found");
      history.go(-1);
    <%}%>

   showFflHOCtl();
}
//==============================================================================
//show FFL HO Control  
//==============================================================================
function showFflHOCtl()
{
	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvHoCtl.style.width = "250";}
	else { document.all.dvHoCtl.style.width = "auto";}
	
	var pll = document.getElementById("pLastLine");
	var pllpos = getObjPosition(pll);
	
	document.all.dvHoCtl.style.pixelLeft= document.documentElement.scrollLeft + 250;
	document.all.dvHoCtl.style.pixelTop = pllpos[1] + 10;
}
//--------------------------------------------------------
// change Delete Status
//--------------------------------------------------------
function chgDtlSts(site, ord, dtlId, dtlSts)
{
  var hdr = "Order:&nbsp;" + ord + "&nbsp; Detail Id:" + dtlId;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt1' colspan=2>"
        + popItmPanel(site, ord, dtlId, dtlSts)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Item Status Panel
//--------------------------------------------------------
function popItmPanel(site, ord, dtlId, dtlSts)
{
  var panel = "<table border=0 width='100%' cellPadding='5' cellSpacing='0'>"
  panel += "<tr><td class='Prompt'>"

  if(dtlSts != "Y") { panel += "Current status:" + "ACTIVE" }
  else { panel += "Current status:&nbsp;" + "DELETED" }

  panel += "</td></tr>"
  panel += "<tr><td class='Prompt'>Do you want to change status?</td></tr>"

  panel += "<tr><td class='Prompt1'>"
        + "<button onClick='sbmItem(&#34;" + site + "&#34;,&#34;" + ord + "&#34;,&#34;" + dtlId + "&#34;)' "
        + "class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
//--------------------------------------------------------
// submit changes for order status
//--------------------------------------------------------
function sbmItem(site, ord, dtlId)
{
  hidePanel();

  var url = "ECommOrdSav.jsp?Site=" + site
      + "&Order=" + ord
      + "&DtlId=" + dtlId
      + "&Action=CNLDTLID"
  //alert(url)
  //window.location.href=url
  window.frame1.location.href=url
}
//--------------------------------------------------------
// print pick slip
//--------------------------------------------------------
function prtPackSlip(site, ord, printer, outq, outqlib, whsOrStr, str)
{

  var url = "EComOrdReprint.jsp?Site=" + site
      + "&Order=" + ord
  if (printer != null) { url += "&Printer=" + printer }
  if (outq != null) { url += "&Outq=" + outq + "&OutqLib=" + outqlib}
  url += "&WhsOrStr=" + whsOrStr
  url += "&Str=" + str

  //alert(url)
  //window.location.href=url
  window.frame1.location.href=url
}
//--------------------------------------------------------
// reassign sku from warehouse to store
//--------------------------------------------------------
function reAssigSku(site, ord, sku, whse, qty)
{
	var hdr = "Reassign item to other store";

    var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popReAssg(site, ord, sku, whse, qty)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";
   setReassgQty(qty);
}
//==============================================================================
// populate result
//==============================================================================
function popReAssg(site, ord, sku, whse, qty)
{
   var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
   panel += "<tr><td class='Prompt' >Order: </td>"
            + "<td class='Prompt' nowrap>" + ord + "</td>"
         + "</tr>"
         + "<tr><td class='Prompt' >SKU: </td>"
            + "<td class='Prompt' nowrap>" + sku + "</td>"
         + "</tr>"
         + "<tr><td class='Prompt' >Warehouse: </td>"
            + "<td class='Prompt' nowrap>" + whse + "</td>"
         + "</tr>"
         + "<tr><td class='Prompt' nowrap>Quantity to reassigned(" + qty + "):&nbsp;</td>"
            + "<td class='Prompt' nowrap><select name='selReassg'></select></td>"
         + "</tr>"
         + "<tr><td class='Prompt' colspan=2 id='tdError' nowrap></td>"
            
         + "</tr>"

   panel += "<tr><td class='Prompt1' colspan='2'><br><br>"
	      + "<button onClick='vldReAssg(&#34;" + site + "&#34;,&#34;" + ord + "&#34;,&#34;" + sku + "&#34;,&#34;" + whse + "&#34;);' class='Small'>Reassign</button> &nbsp; "
             + "<button onClick='hidePanel();' class='Small'>Close</button>"
          + "</td></tr>"

   panel += "</table>";

  return panel;
}

//==============================================================================
//set reassigned qty
//==============================================================================
function setReassgQty(qty)
{
	var sel = document.all.selReassg;
	sel.options[0] = new Option("--- select reasigned qty ---",0);
	for(var i=1, j=0; j < qty; i++, j++)
	{	   
	   sel.options[i] = new Option(i,i);
	   
	}
}
//==============================================================================
//populate result
//==============================================================================

function vldReAssg(site, ord, sku, whse)
{
   var error = false;
   var msg ="";
   document.all.tdError.innerHTML = "";
   document.all.tdError.style.color = "red";
   
   var qty = document.all.selReassg.options[document.all.selReassg.selectedIndex].value;
   if(qty == 0){ error=true; msg="Please, select reassigning quantity.";}
   
   if(error){document.all.tdError.innerHTML = msg; }
   else{ sbmReAssigSku(site, ord, sku, whse, qty);  }
}

//--------------------------------------------------------
// submit reassign sku from warehouse to store
//--------------------------------------------------------
function sbmReAssigSku(site, ord, sku, whse, qty)
{
var url = "EComOrdReAssign.jsp?Site=" + site
   + "&Order=" + ord
   + "&Sku=" + sku
   + "&Whs=" + whse
   + "&Qty=" + qty

//alert(url)
//window.location.href=url
window.frame1.location.href=url
}
//--------------------------------------------------------
// display Error
//--------------------------------------------------------
function dspPackSlip(site, ord)
{
  var url = "EComOrdPack.jsp?Site=" + site
      + "&Order=" + ord

  //alert(url)
  window.location.href=url
}

//==============================================================================
// add order to UPS again
//==============================================================================
function sendOrdToUPS(site, order)
{
   var url = "EComUPS_Add.jsp?Site=" + site
      + "&Order=" + order

   //alert(url)
   //window.location.href=url
   window.frame1.location.href=url
}
//==============================================================================
// send customer info to elab
//==============================================================================
function updateOrderProperties(site, ord)
{
   var url = "MozuGetOrder.jsp?"
      + "&Site=" + site
      + "&Order=" + ord

   //alert(url)
   //window.location.href=url
   window.frame1.location.href=url
}
//==============================================================================
//send customer info to bronto
//==============================================================================
function sendCustInfoToBronto(site, ord)
{
	var url = "MozuSendToBronto.jsp?From=CSTINFO"
	      + "&Site=" + site
	      + "&Order=" + ord
    window.frame1.location.href=url
}
//==============================================================================
// refresh
//==============================================================================
function refresh(){ window.location.reload();}
//==============================================================================
// send customer info to elab
//==============================================================================
function getCustELabInfo(site, custEmail)
{
   var url = "ELabCustInq.jsp?"
      + "Site=" + site
      + "&CustEmail=" + custEmail;

  var windowName = "Test01";
  var windowOptions = "width=1000,height=600, toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,menubar=no";

  win2 = window.open(url, windowName, windowOptions);
}
//==============================================================================
// show elab result
//==============================================================================
function showELabResult(outResp, action)
{
    var resp = "Customer Information sent to Bronto successfully";
    var error = false;
    if(action == "INQUIRY"){ resp = outResp; }
    else if(! (outResp.indexOf("success") >= 0)){ resp = outResp; error = true; }
    else if(action=="STSORD"){ resp = "Ship-to-store status sent to Bronto successfully"; }

    var hdr = "Send to Bronto"

    var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popResult(resp, action, error)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate result
//==============================================================================
function popResult(resp, action, error)
{
   var isErr = parseResponde(resp, "isError");
   var errCode = parseResponde(resp, "errorCode");
   var isNew = parseResponde(resp, "isNew");
   var id = parseResponde(resp, "id");

   //alert(isErr + "\n" + errCode + "\n" + isNew + "\n" + id)

   var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
   panel += "<tr><td class='Prompt' >id</td>"
            + "<td class='Prompt' nowrap>" + id + "</td>"
         + "</tr>"
         + "<tr><td class='Prompt' >New:</td>"
            + "<td class='Prompt' nowrap>" + isNew + "</td>"
         + "</tr>"
         + "<tr><td class='Prompt' >Error:</td>"
            + "<td class='Prompt' nowrap>" + isErr + "</td>"
         + "</tr>"
         + "<tr><td class='Prompt' nowrap>Error Code:</td>"
            + "<td class='Prompt' nowrap>" + errCode + "</td>"
         + "</tr>"

   panel += "<tr><td class='Prompt1' colspan='2'><br><br>"
             + "<button onClick='hidePanel();' class='Small'>Close</button>"
          + "</td></tr>"

   panel += "</table>";

  return panel;
}
//==============================================================================
// parse respond
//==============================================================================
function parseResponde(xml, tag)
{
   var stag = "<" + tag + ">";
   var etag = "</" + tag + ">";
   var start = xml.indexOf(stag) + stag.length;
   var end = xml.indexOf(etag);
   var data = xml.substring(start, end);

   return data;
}
//==============================================================================
// wotk with adjustment
//==============================================================================
function setAdjustment(ord)
{
   var hdr = "Adjustment for Order: " + ord

    var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popAdjust(ord)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 50;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";

   if(AdjOrdFound)  { setAdjItmDtl(); }
   else { doSelDate(document.all.AdjDate); }
}
//==============================================================================
// populate result
//==============================================================================
function popAdjust(ord)
{
   var dummy = "<table>";
   var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"

   panel += "<tr><th class='DataTable' rowspan=2 nowrap >Select</th>"
             + "<th class='DataTable' rowspan=2 nowrap>Dtl.Id</th>"
             + "<th class='DataTable' rowspan=2 nowrap>Item Number</th>"
             + "<th class='DataTable' rowspan=2 nowrap>Sku</th>"
             + "<th class='DataTable' rowspan=2 nowrap>Desc</th>"
             + "<th class='DataTable' rowspan=2 nowrap>Mfg</th>"

             + "<th class='DataTable' colspan=2 nowrap>Original</th>"
             + "<th class='DataTable' rowspan=2 nowrap>&nbsp;</th>"
             + "<th class='DataTable' colspan=3 nowrap>Revised</th>"
         + "</tr>"
         + "<tr>"
             + "<th class='DataTable' nowrap>Qty</th>"
             + "<th class='DataTable' nowrap>Ext. Ret</th>"
             + "<th class='DataTable' nowrap>Qty</th>"
             + "<th class='DataTable' nowrap>Orig. Ret<br>Amount</th>"
             + "<th class='DataTable' nowrap>New Extended<br>Ret Amount</th>"
         + "</tr>"

      for(var i=0; i < OrdSku.length; i++)
      {
         if (OrdDtlId[i] != "0000000000"){ panel += "<tr>" }
         else { panel += "<tr style='display:none;'>" }
         panel += "<td class='Prompt' nowrap><input class='Small' name='SelItm' type='checkBox' onclick='enableAdjDtl(this)'  value='" + i + "'></td>"

            + "<td class='Prompt' nowrap>" + OrdDtlId[i] + "</td>"
            + "<td class='Prompt' nowrap>" + OrdCls[i] + "-" + OrdVen[i] + "-" + OrdSty[i] + "-" + OrdClr[i] + "-" + OrdSiz[i] + "</td>"
            + "<td class='Prompt' nowrap>" + OrdSku[i] + "</td>"
            + "<td class='Prompt' nowrap>" + OrdDesc[i] + "&nbsp;</td>"
            + "<td class='Prompt' nowrap>" + OrdMfg[i] + "&nbsp;</td>"
            + "<td class='Prompt2' nowrap>" + OrdQty[i] + "</td>"
            + "<td class='Prompt2' nowrap>$" + OrigExtRet[i] + "</td>"
            + "<th class='DataTable' nowrap>&nbsp;</th>"
            + "<td class='Prompt2' nowrap><input class='Small' style='background:gray' name='AdjQty' value='" + OrdQty[i] + "' maxlength=10 size=10 disabled></td>"
            + "<td class='Prompt2' nowrap>$<input class='Small' style='background:gray' name='AdjOldRet' value='" + OrigExtRet[i] + "'  maxlength=10 size=10 disabled></td>"
            + "<td class='Prompt2' nowrap>$<input class='Small' style='background:gray' name='AdjRet'  maxlength=10 size=10 disabled></td>"
         + "</tr>"

   }

   panel += "<tr class='DataTable2'><td colspan=3 style='font-size:11px; font-weight:bold;' nowrap>Shipping Cost: "
            + "&nbsp;<input class='Small' name='SelOrd' type='checkBox' onclick='enableHdr(this)' value='SHPCOST'>&nbsp;"
            + "&nbsp;$<input class='Small' style='background:gray' name='ShipCost' maxlength=10 size=10 disabled></td>"

          + "<td  colspan=2 style='font-size:11px; font-weight:bold;' nowrap>Tax Amount: "
            + "&nbsp;<input class='Small' name='SelOrd' type='checkBox' onclick='enableHdr(this)' value='TAX'>&nbsp;"
            + "&nbsp;$<input class='Small' style='background:gray' name='TaxAmt' maxlength=10 size=10 disabled></td>"

          + "<td  colspan=2 style='font-size:11px; font-weight:bold;' nowrap>Refund to On-line Credit: "
               + "&nbsp;<input class='Small' name='RefOnlCred' type='checkBox' value='Y'>&nbsp;"
               + "<br>Original Payment method: <%=sPayMth%>"
          + "</td>"

          + "<td  colspan=3 style='font-size:11px; font-weight:bold;' nowrap>&nbsp;Adjustment Date: "
            + "&nbsp;<input class='Small' name='AdjDate' maxlength=10 size=10 readOnly>"
            + "&nbsp; <!--a href='javascript:showCalendar(1, null, null, 200, 400, document.all.AdjDate)'>"
            + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a-->"
          + "</td>"


   panel += "<tr><td class='Prompt1' colspan='12'><br>"
   if (!AdjOrdFound) { panel += "<button onClick='Validate(&#34;ADD&#34;);' class='Small'>Add</button> &nbsp; "  }
   else
   {
      panel += "<button onClick='Validate(&#34;UPD&#34;);' class='Small'>Update</button> &nbsp; "
      panel += "<button onClick='Validate(&#34;DLT&#34;);' class='Small'>Delete</button> &nbsp; "
   }

   panel += "<button onClick='hidePanel();' class='Small'>Close</button>"
          + "</td></tr>"

   panel += "</table>";

  return panel;
}
//==============================================================================
//wotk with returns
//==============================================================================
function setReturn(ord)
{
	var hdr = "Return Items for Order: " + ord

 	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
  		+ "<tr>"
    		+ "<td class='BoxName' nowrap>" + hdr + "</td>"
    		+ "<td class='BoxClose' valign=top>"
      			+  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
    		+ "</td></tr>"
 		+ "<tr>" 
 			+ "<td class='Prompt' colspan=2>" + popReturn(ord) + "</td>"
  		+ "</tr>"
	+ "</table>"

	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 50;
	document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";
		
	setRefAvail();
	setRefVal();	
}
//==============================================================================
//populate result
//==============================================================================
function popReturn(ord)
{
	var panel = ""; 
	
	var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"

	panel += "<tr><th class='DataTable' rowspan=2 nowrap >Select</th>"
          + "<th class='DataTable' rowspan=2 nowrap>Item Number</th>"
          + "<th class='DataTable' rowspan=2 nowrap>Sku</th>"
          + "<th class='DataTable' rowspan=2 nowrap>Desc</th>"
          + "<th class='DataTable' rowspan=2 nowrap>Mfg</th>"

          + "<th class='DataTable' colspan=2 nowrap>Amt</th>"
          + "<th class='DataTable' rowspan=2 nowrap>&nbsp;</th>"
          + "<th class='DataTable' colspan=5 nowrap>Revised</th>"
      + "</tr>"
      + "<tr>"
          + "<th class='DataTable' nowrap>Qty</th>"
          + "<th class='DataTable' nowrap>Ext. Ret</th>"
          + "<th class='DataTable' nowrap>Qty</th>"
          + "<th class='DataTable' nowrap>Refund<br>Amount</th>"
          + "<th class='DataTable' nowrap>Tax<br>Amount</th>"
          + "<th class='DataTable' nowrap>Shipping<br>Fee</th>"
          + "<th class='DataTable' nowrap>Shipping<br>Tax</th>"
          + "<th class='DataTable' nowrap>Note</th>"
      + "</tr>"

    for(var i=0; i < OrdSku.length; i++)
    {
      if (OrdDtlId[i] != "0000000000"){ panel += "<tr>" }
      else { panel += "<tr style='display:none;'>" }
      panel += "<td class='Prompt' nowrap><input class='Small' name='SelItm" + i + "' type='checkBox' onclick='enableRetDtl(this)'  value='" + i + "'></td>"

         + "<td class='Prompt' nowrap>" + OrdCls[i] + "-" + OrdVen[i] + "-" + OrdSty[i] + "-" + OrdClr[i] + "-" + OrdSiz[i] + "</td>"
         + "<td class='Prompt' nowrap>" + OrdSku[i] + "</td>"
         + "<td class='Prompt' nowrap>" + OrdDesc[i] + "&nbsp;</td>"
         + "<td class='Prompt' nowrap>" + OrdMfg[i] + "&nbsp;</td>"
         + "<td class='Prompt2' nowrap>" + OrdQty[i] + "</td>"
         + "<td class='Prompt2' nowrap>$" + OrdRet[i] + "</td>"
         + "<th class='DataTable' nowrap>&nbsp;</th>"
         + "<td class='Prompt2' nowrap><input class='Small' id='ItmQty" + i + "'  name='ItmQty" + i + "' value='" + OrdQty[i] + "' maxlength=10 size=10 disabled></td>"
         + "<td class='Prompt2' nowrap>$<input class='Small' id='ItmAmt" + i + "' name='ItmAmt" + i + "'  maxlength=10 size=10 disabled></td>"
         + "<td class='Prompt2' nowrap>$<input class='Small' id='ItmTax" + i + "' name='ItmTax" + i + "'  maxlength=10 size=10 disabled></td>"
         + "<td class='Prompt2' nowrap>$<input class='Small' id='ItmShp" + i + "' name='ItmShp" + i + "'  maxlength=10 size=10 disabled></td>"
         + "<td class='Prompt2' nowrap>$<input class='Small' id='ItmShpTax" + i + "' name='ItmShpTax" + i + "'  maxlength=10 size=10 disabled></td>"
         + "<td class='Prompt2' nowrap>$<input class='Small' id='ItmNote" + i + "' name='ItmNote" + i + "'  maxlength=100 size=30 disabled></td>"
      + "</tr>";	
	}
    
	panel += "<tr><td class='Prompt1' colspan='12'><br>"
	if (!OrdRetFound) { panel += "<button onClick='ValRetItm(&#34;ADD&#34;);' class='Small'>Add</button> &nbsp; "  }
	else
	{
   		panel += "<button onClick='ValRetItm(&#34;UPD&#34;);' class='Small'>Update</button> &nbsp; "
   		panel += "<button onClick='ValRetItm(&#34;DLT&#34;);' class='Small'>Delete</button> &nbsp; "
	}

	panel += "<button onClick='hidePanel();' class='Small'>Close</button>"
       + "</td></tr>";
	panel += "</table> ";
	
	if (OrdRetFound) 
	{
		panel += "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"	
		 + "<tr><th class='DataTable' nowrap >Sku</th>"
	        + "<th class='DataTable' nowrap>Return ID</th>"
	        + "<th class='DataTable' nowrap>Qty</th>"
	        + "<th class='DataTable' nowrap>Amt</th>"
	        + "<th class='DataTable' nowrap>Tax</th>"
	        + "<th class='DataTable' nowrap>Shipping</th>"
	        + "<th class='DataTable' nowrap>Shipping Tax </th>"
	        + "<th class='DataTable'>Note</th>"
	   	  + "</tr>";       
	   
		for(var i=0; i < RetItmSku.length; i++)
    	{
			panel += "<tr class='DataTable'>"
			  + "<td class='DataTable' id='RetItmSku" + i + "' nowrap></td>"
			  + "<td class='DataTable' id='RetItmId" + i + "' nowrap></td>"
			  + "<td class='DataTable' id='RetItmQty" + i + "' nowrap></td>"
			  + "<td class='DataTable' id='RetItmAmt" + i + "' nowrap></td>"
			  + "<td class='DataTable' id='RetItmTax" + i + "' nowrap></td>"
			  + "<td class='DataTable' id='RetItmShp" + i + "' nowrap></td>"
			  + "<td class='DataTable' id='RetItmShpTax" + i + "' nowrap></td>"
			  + "<td class='DataTable' id='RetItmNote" + i + "' nowrap></td>"
			  + "</tr>";			  
    	}
	   
		panel += "</table>";
	} 
	
	return panel;	
}
//==============================================================================
// allow enter refund
//==============================================================================
function setRefAvail()
{	
	for(var i=0; i < OrdSku.length; i++)
    {
		var qtyref = eval(0);
		
		for(var j=0; j < RetItmSku.length; j++)
		{
		   if(OrdSku[i] == RetItmSku[j] && RetItmId != "")
		   {
			   qtyref -= -1 * eval(RetItmQtyRcv[j]);
		   }
		}
		
		var disp = "block";
		if(qtyref >= OrdQty[i]){ disp = "none"; }
		var sel = "SelItm" + i;
		document.all[sel].style.display = disp; 
		
		document.getElementById("ItmQty" + i).value = OrdQty[i];
		document.getElementById("ItmAmt" + i).value = OrdRet[i];
		var tax = (OrdRet[i] * TaxRate).toFixed(2);
		document.getElementById("ItmTax" + i).value = tax;
		var ship =  (ShipCost / TotPay * OrdRet[i]).toFixed(2);
		document.getElementById("ItmShp" + i).value = ship;
		var tax = (ship * TaxRate).toFixed(2);
		document.getElementById("ItmShpTax" + i).value = tax;
    }
	
}
//==============================================================================
// set refund values
//==============================================================================
function setRefVal()
{
	for(var i=0; i < RetItmSku.length; i++)
	{
		document.getElementById("RetItmSku" + i).innerHTML = RetItmSku[i];
		document.getElementById("RetItmId" + i).innerHTML = RetItmId[i];
		document.getElementById("RetItmQty" + i).innerHTML = RetItmQtyRcv[i];
		document.getElementById("RetItmAmt" + i).innerHTML = RetItmAmt[i];
		document.getElementById("RetItmTax" + i).innerHTML = RetItmTax[i];
		document.getElementById("RetItmShp" + i).innerHTML = RetItmShp[i];		
		document.getElementById("RetItmShpTax" + i).innerHTML = RetItmShpTax[i];
		document.getElementById("RetItmNote" + i).innerHTML = RetItmNote[i];
	}
}

//==============================================================================
// populate today date
//==============================================================================
function  doSelDate(dayobj)
{
  var date = new Date();
  dayobj.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

//==============================================================================
// enable/disabled adjustment item entry fields
//==============================================================================
function enableAdjDtl(obj)
{
   var dtl = <%=iNumOfDtl%>;
   if (dtl > 1)
   {
      if(obj.checked)
      {
         document.all.AdjQty[obj.value].disabled = false; document.all.AdjQty[obj.value].style.background = "white";
         document.all.AdjOldRet[obj.value].disabled = false; document.all.AdjOldRet[obj.value].style.background = "white";
         document.all.AdjRet[obj.value].disabled = false; document.all.AdjRet[obj.value].style.background = "white";
      }
      else
      {
         document.all.AdjQty[obj.value].disabled = true; document.all.AdjQty[obj.value].style.background = "gray";
         document.all.AdjOldRet[obj.value].disabled = true;document.all.AdjOldRet[obj.value].style.background = "gray";
         document.all.AdjRet[obj.value].disabled = true;document.all.AdjRet[obj.value].style.background = "gray";
      }
   }
   else
   {
      if(obj.checked)
      {
        document.all.AdjQty.disabled = false; document.all.AdjQty.style.background = "white";
        document.all.AdjOldRet.disabled = false; document.all.AdjOldRet.style.background = "white";
        document.all.AdjRet.disabled = false; document.all.AdjRet.style.background = "white";
      }
      else
      {
         document.all.AdjQty.disabled = true; document.all.AdjQty.style.background = "gray";
         document.all.AdjOldRet.disabled = true; document.all.AdjOldRet.style.background = "gray";
         document.all.AdjRet.disabled = true; document.all.AdjRet.style.background = "gray";
      }
   }
}

//==============================================================================
// enable/disabled item entry fields
//==============================================================================
function enableHdr(obj)
{
   if (obj.value == "SHPCOST")
   {
      if(obj.checked) { document.all.ShipCost.disabled = false; document.all.ShipCost.style.background = "white"; }
      else { document.all.ShipCost.disabled = true; document.all.ShipCost.style.background = "gray"; }
   }
   if (obj.value == "TAX")
   {
      if(obj.checked) { document.all.TaxAmt.disabled = false; document.all.TaxAmt.style.background = "white"; }
      else { document.all.TaxAmt.disabled = true; document.all.TaxAmt.style.background = "gray"; }
   }
}
//==============================================================================
//enable/disabled adjustment item entry fields
//==============================================================================
function enableRetDtl(obj)
{
	var iarg = obj.value;
	
	var qtynm = "ItmQty" + iarg;
	var amtnm = "ItmAmt" + iarg;
	var taxnm = "ItmTax" + iarg;
	var shpnm = "ItmShp" + iarg;
	var shptaxnm = "ItmShpTax" + iarg;
	var note = "ItmNote" + iarg;
	
	var able = !obj.checked;	
	
	document.getElementById(qtynm).disabled = able;
	document.getElementById(amtnm).disabled = able;
	document.getElementById(taxnm).disabled = able;
	document.getElementById(shpnm).disabled = able;
	document.getElementById(shptaxnm).disabled = able;
	document.getElementById(note).disabled = able;	
}
//==============================================================================
// set item detail adjustment price
//==============================================================================
function setAdjItmDtl()
{
   var dtl = <%=iNumOfDtl%>;
   var qty = null;
   var ret = null;
   var oldret = null;
   var sel = null;

   document.all.SelOrd[0].checked = AdjShipChk;
   document.all.ShipCost.value = AdjShipCost;
   document.all.ShipCost.disabled = !AdjShipChk;
   if(AdjShipChk) { document.all.ShipCost.style.background = "white"; }

   document.all.SelOrd[1].checked = AdjTaxChk;
   document.all.TaxAmt.value = AdjTax;
   document.all.TaxAmt.disabled = !AdjTaxChk;
   if(AdjTaxChk) {document.all.TaxAmt.style.background = "white"; }
   document.all.AdjDate.value = AdjDate;

   for(var i=0; i < dtl; i++)
   {
     if(dtl > 1) { qty = document.all.AdjQty[i]; oldret = document.all.AdjOldRet[i]; ret = document.all.AdjRet[i];  sel = document.all.SelItm[i]; }
     else { qty = document.all.AdjQty; oldret = document.all.AdjOldRet; ret = document.all.AdjRet; sel = document.all.SelItm; }

     for(var j=0; j < AdjDtlId.length; j++)
     {
        //alert(i + " " + j + " " + AdjDtlId[j] + " " + OrdDtlId[i] + "\n" + (AdjDtlId[j] == OrdDtlId[i]))
        if(AdjDtlId[j] == OrdDtlId[i])
        {
           sel.checked = true;
           qty.value = AdjQty[j]; qty.disabled=false; qty.style.background="white";
           ret.value = AdjRet[j]; ret.disabled=false; ret.style.background="white";
           oldret.value = AdjOldRet[j]; oldret.disabled=false; oldret.style.background="white";
        }
     }
  }
}
//==============================================================================
// validate order adjustments
//==============================================================================
function Validate(action)
{
   var error = false;
   var msg = "";
   var numSelItm = 0;
   var dtlId = new Array();
   var sku = new Array();
   var qty = new Array();
   var ret = new Array();
   var oldret = new Array();
   var selqty = false;
   var selret = false;
   var selship = false;
   var seltax = false;
   var ship = null;
   var tax = null;
   var refonlcred = "N";

   // retreive detail adjustments
   for(var i=0, j=0; i < OrdSku.length; i++)
   {
      if (OrdSku.length > 1 && document.all.SelItm[i].checked
         || OrdSku.length == 1 && document.all.SelItm.checked )
      {
         dtlId[j] = OrdDtlId[i];
         sku[j] = OrdSku[i];
         if(OrdSku.length > 1){ qty[j] = document.all.AdjQty[i].value; ret[j] = document.all.AdjRet[i].value;  oldret[j] = document.all.AdjOldRet[i].value;}
         else { qty[j] = document.all.AdjQty.value; ret[j] = document.all.AdjRet.value; oldret[j] = document.all.AdjOldRet.value;}

         if(qty[j].trim() != "" && !isNaN(qty[j].trim())) {selqty = true;}
         else { error = true; msg += "\nQuantity is incorrect for sku:" + OrdSku[i]}

         if(ret[j].trim() != "" && !isNaN(ret[j].trim())) {selret = true;}
         else { error = true; msg += "\nRetail Price is incorrect for sku:" + OrdSku[i] }

         if(oldret[j].trim() != "" && !isNaN(oldret[j].trim())) {seloldret = true;}
         else { error = true; msg += "\nOriginal Retail Price is incorrect for sku:" + OrdSku[i] }
         j++;
      }
   }

   // shipping cost adjustment
   if(document.all.SelOrd[0].checked)
   {
      if(document.all.ShipCost.value.trim() != "" && !isNaN(document.all.ShipCost.value.trim()) ) { selship = true; ship = document.all.ShipCost.value.trim() }
      else { error = true; msg += "\nShipping cost is incorrect"}
   }

   // tax amount adjustment
   if(document.all.SelOrd[1].checked)
   {
      if(document.all.TaxAmt.value.trim() != "" && !isNaN(document.all.TaxAmt.value.trim()) ) { seltax = true; tax = document.all.TaxAmt.value.trim();}
      else { error = true; msg += "\nTax amount is incorrect"}
   }

   // refund to online credit
   if(document.all.RefOnlCred.checked){ refonlcred = document.all.RefOnlCred.value; }

   // adjustment date mast be specified
   if(document.all.AdjDate.value.trim() != ""){adjdt = document.all.AdjDate.value.trim(); }
   else {  error = true; msg += "\nAdjustment date is not specified."}

   // no adjustment made
   if(!selship && !seltax && !selret) {error = true; msg += "\nNo adjustment has been made."}

   if(error){ alert(msg) }
   else { sbmOrdAdj(dtlId, sku, qty, ret, oldret, ship, tax, adjdt, refonlcred, action ) }
}
//==============================================================================
// submit order adjustments
//==============================================================================
function sbmOrdAdj( dtlId, sku, qty, ret, oldret, ship, tax, adjdt, refonlcred,  action )
{
   var url = "EComOrdAdjSave.jsp?&Site=<%=sSite%>&Order=<%=sOrder%>"
     if(AdjId != null){ url += "&AdjId=" + AdjId }
     else{ url += "&AdjId=0" }

     if(ship != null) { url += "&ShipCost=" + ship }
     if(tax != null) { url += "&Tax=" + tax }
     url += "&AdjDate=" + adjdt

     for(var i=0; i < dtlId.length; i++)
     {
        url += "&DtlId=" + dtlId[i]
        url += "&Sku=" + sku[i]
        url += "&Qty=" + qty[i]
        url += "&Ret=" + ret[i]
        url += "&OldRet=" + oldret[i]
     }

     url += "&RefOnlCred=" + refonlcred
     url += "&Action=" + action

    //alert(url);
    //window.location.href=url;
    window.frame1.location.href=url;
}
//==============================================================================
//validate order adjustments
//==============================================================================
function ValRetItm(action)
{
	var error = false;
	var msg = "";
	var numSelItm = 0;
	var sku = new Array();
	var qty = new Array();
	var amt = new Array();
	var tax = new Array();
	var shp = new Array();
	var shptax = new Array();

	// retreive detail adjustments
	for(var i=0, j=0; i < OrdSku.length; i++)
	{	
   		if (OrdSku.length > 1 && document.getElementById("SelItm" + i).checked )
   		{
      		sku[j] = OrdSku[i];
      		qty[j] = document.getElementById("ItmQty" + i).value; 
      		amt[j] = document.getElementById("ItmAmt" + i).value;  
      		tax[j] = document.getElementById("ItmTax" + i).value;
      		shp[j] = document.getElementById("ItmShp" + i).value;
      		shptax[j] = document.getElementById("ItmShpTax" + i).value;
      		note[j] = document.getElementById("ItmNote" + i).value;
	      
    		if(qty[j].trim() != "" && isNaN(qty[j].trim())) 
      		{
    	  		error = true; msg += "\nQuantity is incorrect for sku:" + OrdSku[i]
      		}

      		if(amt[j].trim() != "" && isNaN(amt[j].trim())) 
      		{ 
    	  		error = true; msg += "\nRetail Price is incorrect for sku:" + OrdSku[i] 
      		}

		    if(tax[j].trim() != "" && isNaN(tax[j].trim())) 
      		{
    	  		error = true; msg += "\nTax is incorrect for sku:" + OrdSku[i] 
      		}

      		if(shp[j].trim() != "" && isNaN(shp[j].trim())) 
      		{
    	  		error = true; msg += "\nShipping is incorrect for sku:" + OrdSku[i] 
      		}
      
      		if(shp[j].trim() != "" && isNaN(shp[j].trim())) 
      		{
    	  		error = true; msg += "\nShipping Tax is incorrect for sku:" + OrdSku[i] 
      		}
      
      		j++;
   		}
	}

	if(error){ alert(msg) }
	else { sbmOrdRet(sku, qty, amt, tax, shp, shptax, note, action ) }
}
//==============================================================================
//submit order return / refund
//==============================================================================
function sbmOrdRet( sku, qty, amt, tax, shp, shptax, note, action )
{
	note = note.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmOrdRet"

    var html = "<form name='frmSbmOrdRet'"
       + " METHOD=Post ACTION='MozuOrdRetSave.jsp'>"
       
    for(var i=0; i < sku.length;i++)
    {    	
       html += "<input name='Site' value='<%=sSite%>'>"
       + "<input name='Order' value='<%=sOrder%>'>"
       + "<input name='Sku' value='" + sku[i] + "'>"
       + "<input name='Qty' value='" + qty[i] +  "'>"
       + "<input name='Amt' value='" + amt[i] +  "'>"
       + "<input name='Tax' value='" + tax[i] +  "'>"
       + "<input name='Ship' value='" + shp[i] +  "'>"
       + "<input name='ShipTax' value='" + shptax[i] +  "'>"
       + "<input name='Note' value='" + note[i] +  "'>"
   	}  
       
    html += "<input name='Action'>"
    html += "</form>"

   	nwelem.innerHTML = html;
    window.frame1.document.appendChild(nwelem);        
    
    window.frame1.document.all.Action.value=action;
    
    window.frame1.document.frmSbmOrdRet.submit();
}
//--------------------------------------------------------
// display Error
//--------------------------------------------------------
function displayError(error)
{
   var msg = "";
   for(var i=0; i < error.length; i++)
   {
      msg += error[i] + "\n"
   }

   alert(msg);
   window.frame1.close();
}
//--------------------------------------------------------
// restart window after status changed
//--------------------------------------------------------
function restart()
{
   window.location.reload();
}
//==============================================================================
// delete ship-to-store header record
//==============================================================================
function dltSTSHdr(ord)
{
	var url = "MozuDltSTS.jsp?Site=<%=sSite%>"
	 + "&Order=" + ord;
	window.frame1.location.href=url;
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>


<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>E-Commerce Order Details
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="MozuOrdLstSel.jsp" class="small"><font color="red">Select</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<%if (bOrdFound) {%>
<!-- ======================================================================= -->
       <table class="DataTable1" >
         <tr class="DataTable1">
           <td class="DataTable">Order</td>
           <td class="DataTable"><%=sOrd%>&nbsp;
              <%if(bAllowButton){%>
                 <button class="Small" onclick="updateOrderProperties('<%=sSite%>','<%=sOrd%>')">Get Order</button>
              <%}%>
           </td>
           <th class="DataTable">&nbsp;&nbsp;</th>
           <td class="DataTable">Customer</td>
           <td class="DataTable"><%=sCust%> &nbsp;
               <%if(bAllowButton){%>
                   <button class="Small" onclick="sendCustInfoToBronto('<%=sSite%>', '<%=sOrd%>')">Get EMail </button>
               <%}%>
           </td>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable" colspan=2>Bill To</td>
           <th class="DataTable">&nbsp;&nbsp;</th>
           <td class="DataTable" colspan=2>Ship To</td>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable1"  colspan=2><%if(!sBillComp.trim().equals("")){%><%=sBillComp%><br><%}%>
             <%=sBillFNam%> <%=sBillLNam%><br>
             <%if(!sBillAddr1.trim().equals("")){%><%=sBillAddr1%><br><%}%>
             <%if(!sBillAddr2.trim().equals("")){%><%=sBillAddr2%><br><%}%>
             <%=sBillCity%>, <%=sBillState%>, <%=sBillZip%><br>
             Phone: <%=sBillPhn%>, Fax: <%=sBillFax%>
           </td>
           <th class="DataTable">&nbsp;&nbsp;</th>
           <td class="DataTable1"  colspan=2><%if(!sShipComp.trim().equals("")){%><%=sShipComp%><br><%}%>
             <%=sShipFNam%> <%=sShipLNam%><br>
             <%if(!sShipAddr1.trim().equals("")){%><%=sShipAddr1%><br><%}%>
             <%if(!sShipAddr2.trim().equals("")){%><%=sShipAddr2%><br><%}%>
             <%=sShipCity%>, <%=sShipState%>, <%=sShipZip%><br>
             Phone: <%=sShipPhn%>, Fax: <%=sShipFax%>
           </td>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable1">Shipping Method</td>
           <td class="DataTable"><%=sShipMthId%></td>
           <th class="DataTable">&nbsp;&nbsp;</th>
           <td class="DataTable1">Shipping Cost</td>
           <td class="DataTable"><%=sShipCost%></td>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable1">Shipping Total</td>
           <td class="DataTable"><%=sShipTot%></td>
           <th class="DataTable">&nbsp;&nbsp;</th>
           <td class="DataTable1">Handling Total</td>
           <td class="DataTable"><%=sHandTot%></td>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable1">Tax Rate</td>
           <td class="DataTable"><%=sTaxRate%></td>
           <th class="DataTable">&nbsp;&nbsp;</th>
           <td class="DataTable1">Payment Amount</td>
           <td class="DataTable"><%=sPayAmt%></td>
         </tr>

         <tr class="DataTable1">
           <td class="DataTable1">Pay Method</td>
           <td class="DataTable"><%=sPayMth%></td>
           <th class="DataTable">&nbsp;&nbsp;</th>
           <td class="DataTable1">Payment Declined</td>
           <td class="DataTable"><%=sPayDecline%>&nbsp;</td>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable1">Cash Tender</td>
           <td class="DataTable"><%=sCashTender%>&nbsp;</td>
           <th class="DataTable">&nbsp;&nbsp;</th>
           <td class="DataTable1">P.O. Number</td>
           <td class="DataTable"><%=sPoNum%>&nbsp;</td>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable1">Locked</td>
           <td class="DataTable"><%=sLocked%>&nbsp;</td>
           <th class="DataTable">&nbsp;&nbsp;</th>
           <td class="DataTable1">Shipped</td>
           <td class="DataTable"><%=sShipped%>&nbsp;</td>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable1">Order Date</td>
           <td class="DataTable"><%=sOrdDate%>&nbsp;</td>
           <th class="DataTable">&nbsp;&nbsp;</th>
           <td class="DataTable1">Shipped Date</td>
           <td class="DataTable"><%=sShipDate%>&nbsp;</td>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable1">Last Modification Date</td>
           <td class="DataTable"><%=sLstModDate%>&nbsp;</td>
           <th class="DataTable">&nbsp;&nbsp;</th>
           <td class="DataTable1">Status</td>
           <td class="DataTable"><%=sStatus%>&nbsp;</td>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable1">Total Payment Received</td>
           <td class="DataTable"><%=sTotPayRcv%>&nbsp;</td>
           <th class="DataTable">&nbsp;&nbsp;</th>
           <td class="DataTable1">Total Payment Authorized</td>
           <td class="DataTable"><%=sTotPayAuth%>&nbsp;</td>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable1">Tax</td>
           <td class="DataTable"><%=sTax%>&nbsp;</td>
           <th class="DataTable">&nbsp;&nbsp;</th>
           <td class="DataTable1">Shipping Residential </td>
           <td class="DataTable"><%=sShipRes%>&nbsp;</td>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable1">Tender</td>
           <td class="DataTable" ><%=sTender%>&nbsp;</td>
           <th class="DataTable">&nbsp;&nbsp;</th>
           <td class="DataTable1" >Email & Subscription</td>
           <td class="DataTable1<%if(sEmail.equals("Not found")){%>2<%}%>" ><%=sEmail%> &nbsp; <%=sEmailSubscriber%></td>
         </tr>
         <%if(bAllowAdj){%>
            <tr class="DataTable1">
              <td class="DataTable" colspan=5>Click <a href="javascript: setAdjustment('<%=sOrd%>');">here</a> to work with order adjustment</td>
            </tr>
            <tr class="DataTable1">
              <td class="DataTable" colspan=5>Click <a href="javascript: setReturn('<%=sOrd%>');">here</a> to work with order item Retiurns</td>
            </tr>            
         <%}%>
         <%if(bDltSts && bStsExists){%>
         	<tr class="DataTable1">
              <td class="DataTable" colspan=5>Click <a href="javascript: dltSTSHdr('<%=sOrd%>')">here</a> to remove Ship-to-Store records</td>
            </tr>
         <%}%>
       </table><br><br>

<!-- ======================================================================= -->
       <table  class="DataTable"  >
         <tr class="DataTable">
             <th class="DataTable">Dtl<br>Id</th>
             <th class="DataTable">Item Number<br>Cls-Ven-Sty-Clr-Siz</th>
             <th class="DataTable">Sku</th>
             <th class="DataTable">UPC</th>
             <th class="DataTable">Description</th>
             <th class="DataTable">Manufacturer</th>
             <th class="DataTable">Qty</th>
             <th class="DataTable">Retail</th>
             <th class="DataTable">Total<br>Retail</th>
             <th class="DataTable">Discount</th>
             <th class="DataTable">Total<br>Retail<br>After Disc</th>
             <th class="DataTable">Cost</th>
             <th class="DataTable">GM $</th>
             <th class="DataTable">GM %</th>
             <th class="DataTable">Free<br>Ship</th>
             <!--  th class="DataTable">Qty On<br>Hold</th -->
             <th class="DataTable">Qty On<br>Shipping</th>
             <!-- th class="DataTable">Auto<br>Dropship</th -->
             <th class="DataTable">Delete<br>Sts</th>
             <%if(bAllowCancel){%>
             <th class="DataTable">Delete/<br>Undelete</th>
             <%}%>
          </tr>
       <!-- ============================ Details =========================== -->
         <%for(int i=0; i < iNumOfDtl; i++ )
         {
            ordLst.setDetail();
            String sDtlId = ordLst.getDtlId();
            String sCls = ordLst.getCls();
            String sVen = ordLst.getVen();
            String sSty = ordLst.getSty();
            String sClr = ordLst.getClr();
            String sSiz = ordLst.getSiz();
            String sSku = ordLst.getSku();
            String sDesc = ordLst.getDesc();
            String sMfg = ordLst.getMfg();
            String sQty = ordLst.getQty();
            String sRet = ordLst.getRet();
            String sOrigExtRet = ordLst.getOrigExtRet();
            String sTotRet = ordLst.getTotRet();
            String sFreeShip = ordLst.getFreeShip();
            String sQtyOnHold = ordLst.getQtyOnHold();
            String sQtyOnShip = ordLst.getQtyOnShip();
            String sAutoDropShip = ordLst.getAutoDropShip();
            String sDtlSts = ordLst.getDtlSts();
            String sUpc = ordLst.getUpc();
            String sCost = ordLst.getCost();
            String sGmAmt = ordLst.getGmAmt();
            String sGmPrc = ordLst.getGmPrc();
            String sDisc = ordLst.getDisc();
            String sTotRetAfterDisc = ordLst.getTotRetAfterDisc();
       %>
         <tr id="trItem" class="DataTable">
            <td class="DataTable2" nowrap><%=sDtlId%></td>
            <td class="DataTable2" nowrap>
              <a href="MozuParentLst.jsp?Div=ALL&Dpt=ALL&Cls=ALL&Ven=ALL&From=ALL&To=ALL&FromIP=ALL&ToIP=ALL&Site=<%=sSite%>&MarkDownl=0&Excel=N&Parent=<%=sCls + sVen + sSty%>&Pon=&ModelYr=&MapExpDt=&InvAvl=NONE&MarkedWeb=9&InvStr=ALL" target="_blank"><%=sCls + sVen + sSty%></a>
                  <%="-" + sClr + "-" + sSiz%>
              </td>
            <td class="DataTable2" nowrap><%=sSku%></td>
            <td class="DataTable2" nowrap><%=sUpc%></td>
            <td class="DataTable1" nowrap><%=sDesc%></td>
            <td class="DataTable1" nowrap><%=sMfg%></td>
            <td class="DataTable2" nowrap><%=sQty%></td>
            <td class="DataTable2" nowrap>$<%=sRet%></td>
            <td class="DataTable2" nowrap>$<%=sTotRet%></td>
            <td class="DataTable2" nowrap>$<%=sDisc%></td>
            <td class="DataTable2" nowrap>$<%=sTotRetAfterDisc%></td>
            <td class="DataTable2" nowrap>$<%=sCost%></td>
            <td class="DataTable2" nowrap>$<%=sGmAmt%></td>
            <td class="DataTable2" nowrap><%=sGmPrc%>%</td>            
            <td class="DataTable" nowrap><%=sFreeShip%></td>
            <!-- td class="DataTable2" nowrap><%=sQtyOnHold%></td -->
            <td class="DataTable2" nowrap><%=sQtyOnShip%></td>
            <!-- td class="DataTable" nowrap><%=sAutoDropShip%></td -->
            <td class="DataTable" nowrap><%=sDtlSts%></td>
            <%if(bAllowCancel){%>
               <td class="DataTable" nowrap><a href="javascript:chgDtlSts('<%=sSite%>', '<%=sOrd%>', '<%=sDtlId%>', '<%=sDtlSts%>')">D/U</a></td>
            <%}%>
          </tr>
          <script language="javascript">OrdDtlId[<%=i%>] = "<%=sDtlId%>"; OrdCls[<%=i%>] = "<%=sCls%>"; OrdVen[<%=i%>] = "<%=sVen%>";
            OrdSty[<%=i%>] = "<%=sSty%>"; OrdClr[<%=i%>] = "<%=sClr%>"; OrdSiz[<%=i%>] = "<%=sSiz%>";
            OrdSku[<%=i%>] = "<%=sSku%>"; OrdDesc[<%=i%>] = "<%=sDesc%>";  OrdMfg[<%=i%>] = "<%=sMfg%>";
            OrdQty[<%=i%>] = "<%=sQty%>"; OrdRet[<%=i%>] = "<%=sTotRet%>"; OrigExtRet[<%=i%>] = "<%=sOrigExtRet%>";
           </script>
       <%}%>
     </table>
     <br><br>
     <!-- ============================ Return Items =========================== -->
   <%if(iNumOfRtn > 0){%>
     <table border=1 cellPadding="0" cellSpacing="0" >
         <tr class="DataTable">
           <th class="DataTable" colspan="11">Returned Items</th>
         </tr>
         <tr class="DataTable">
           <th class="DataTable">SKU</th>
           <th class="DataTable">S/N</th>
           <th class="DataTable">Str</th>
           <th class="DataTable">Reason</th>
           <th class="DataTable">Status</th>
           <th class="DataTable">Emp</th>
           <th class="DataTable">Action</th>
           <th class="DataTable">Refund<br> Option</th>
           <th class="DataTable">Reported</th>
           <th class="DataTable">Comment</th> 
           <th class="DataTable">Mail<br>Tracking Id</th>
        </tr>

        <%for(int i=0; i < iNumOfRtn; i++ )
        {
        	ordLst.setRtnItem();
            String sRtnSku = ordLst.getRtnSku();
            String sRtnSn = ordLst.getRtnSn();
            String sRtnStr = ordLst.getRtnStr();
            String sRtnReas = ordLst.getRtnReas();
            String sRtnSts = ordLst.getRtnSts();
            String sRtnEmp = ordLst.getRtnEmp();
            String sRtnEmpNm = ordLst.getRtnEmpNm();
            String sRtnCommt = ordLst.getRtnCommt();
            String sRtnRecUs = ordLst.getRtnRecUs();
            String sRtnRecDt = ordLst.getRtnRecDt();
            String sRtnRecTm = ordLst.getRtnRecTm();
            String sRtnIpProc = ordLst.getRtnIpProc();
            String sRtnIpProcDt = ordLst.getRtnIpProcDt();
            String sRtnIpProcTm = ordLst.getRtnIpProcTm();
            String sRtnAction = ordLst.getRtnAction();
            String sRtnBuyer = ordLst.getRtnBuyer();
            String sRtnMailTrac = ordLst.getRtnMailTrac();
            String sRtnRefOpt = ordLst.getRtnRefOpt();
            String sRtnTrnFfl = ordLst.getRtnTrnFfl();
            String sRtnTrnFflDt = ordLst.getRtnTrnFflDt();
            String sRtnTrnFflTm = ordLst.getRtnTrnFflTm();
        %>
           <tr id="trItem" class="DataTable">
             <td class="DataTable2" nowrap><%=sRtnSku%></td>
             <td class="DataTable2" nowrap><%=sRtnSn%></td>
             <td class="DataTable2" nowrap><%=sRtnStr%></td>
             <td class="DataTable2" nowrap><%=sRtnReas%></td>
             <td class="DataTable2" nowrap><%=sRtnSts%></td>
             <td class="DataTable2" nowrap><%=sRtnEmp%> <%=sRtnEmpNm%></td>
             <td class="DataTable2" nowrap><%=sRtnAction%>&nbsp;</td>
             <td class="DataTable2" nowrap><%=sRtnRefOpt%>&nbsp;</td>
             <td class="DataTable2" nowrap><%=sRtnRecUs%> <%=sRtnRecDt%> <%=sRtnRecTm%>&nbsp;</td>
             <td class="DataTable2" nowrap><%=sRtnCommt%>&nbsp;</td>
             <td class="DataTable2" nowrap><%=sRtnMailTrac%>&nbsp;</td>
           </tr>
         <%}%>
      </table>

      

   <%}%>
   <br><br>
    <!-- ============================ Internal Notes =========================== -->
   <%if(iNumOfIntNt > 0){%>
     <table border=1 cellPadding="0" cellSpacing="0" width="90%" >
         <tr class="DataTable">
           <th class="DataTable" colspan="3">Internal Notes</th>
         </tr>
         <tr class="DataTable">
           <th class="DataTable">User</th>
           <th class="DataTable">Date/Time</th>
           <th class="DataTable">Note</th>
        </tr>

        <%for(int i=0; i < iNumOfIntNt; i++ )
        {
        	ordLst.setIntNote();
            String sIntNtUpdBy = ordLst.getIntNtUpdBy();
            String sIntNtUpdDt = ordLst.getIntNtUpdDt();
            String sIntNtMsg = ordLst.getIntNtMsg();
             
        %>
           <tr id="trItem" class="DataTable">
             <td class="DataTable1" nowrap><%=sIntNtUpdBy%></td>
             <td class="DataTable2" nowrap><%=sIntNtUpdDt%></td>
             <td class="DataTable1"><%=sIntNtMsg%></td>
              
           </tr>
       <%}%>
      </table>
    <%}%>    
<br><br>
     <!-- ============================ Allocation =========================== -->
     <table class="DataTable">
         <tr class="DataTable">
           <th class="DataTable" colspan=11>Allocation and Pick Distribution</th>
         </tr>
         <tr class="DataTable">
           <th class="DataTable">Sku</th>
           <th class="DataTable">Description</th>
           <th class="DataTable">Warehouse</th>
           <th class="DataTable">Alloc<br>Qty</th>
           <th class="DataTable">Alloc</th>
           <th class="DataTable">Pick</th>
           <th class="DataTable">Print</th>
           <th class="DataTable">Ups</th>
           <th class="DataTable">Date and Time</th>
           <th class="DataTable">Ship Method</th>
           <%if(bAllowDist){%>
              <th class="DataTable">Chg Dist</th>
           <%}%>
        </tr>

        <%boolean bUps = false;%>
        <%for(int i=0; i < iNumOfDtl; i++ )
        {
           ordLst.setAllocation();
           int iNumOfWhs = ordLst.getNumOfWhs();
           String [] sWhse = ordLst.getWhse();
           String [] sAllocQty = ordLst.getAllocQty();
           String [] sAlloc = ordLst.getAlloc();
           String [] sPick = ordLst.getPick();
           String [] sPrint = ordLst.getPrint();
           String [] sUps = ordLst.getUps();
           String [] sPrtDate = ordLst.getPrtDate();
           String [] sPrtTime = ordLst.getPrtTime();
           String [] sShipMeth = ordLst.getShipMeth();
           String sAllocSku = ordLst.getAllocSku();
           String sAllocDesc = ordLst.getAllocDesc();
         %>
           <%for(int j=0; j < iNumOfWhs; j++){
              // counted ready to reprint skus
              if(sAlloc[j].equals("Y") && sPick[j].equals("Y") && sWhse[j].equals("1")) { iReadyWhsPrt++; }
              else if(sAlloc[j].equals("Y") && sPick[j].equals("Y") && sWhse[j].equals("70")) { iReadyWhsPrt++; }
              else if(sAlloc[j].equals("Y")) { iReadyStrPrt++; }
              // already added to UPS file
              if(sUps[j].equals("Y")){ bUps = true; }
           %>
             <tr id="trItem" class="DataTable">
               <td class="DataTable2" nowrap><%=sAllocSku%></td>
               <td class="DataTable2" nowrap><%=sAllocDesc%></td>
               <td class="DataTable2" nowrap><%=sWhse[j]%></td>
               <td class="DataTable2" nowrap><%=sAllocQty[j]%></td>
               <td class="DataTable" nowrap><%=sAlloc[j]%></td>
               <td class="DataTable" nowrap><%=sPick[j]%></td>

               <td class="DataTable2" nowrap><%=sPrint[j]%>
                  <%if(sWhse[j].equals("1") || sWhse[j].equals("70")){%>
                     (<a class="Small" href="javascript: prtPackSlip('<%=sSite%>', '<%=sOrder%>', 'QPRINT4', null, null, 'Y', 0)">
                          reprint</a>),
                     (<a class="Small" href="javascript: prtPackSlip('<%=sSite%>', '<%=sOrder%>', 'EMAIL', null, null, 'Y', 0)">
                         e-mail</a>)
                  <%}%>
                  <%if(!sWhse[j].equals("1") && !sWhse[j].equals("70")){%>
                     (<a class="Small" href="javascript: prtPackSlip('<%=sSite%>', '<%=sOrder%>', 'QPRINT4', null, null, 'N', <%=sWhse[j]%>)">reprint</a>),
                     (<a class="Small" href="javascript: prtPackSlip('<%=sSite%>', '<%=sOrder%>', 'EMAIL', null, null, 'N', <%=sWhse[j]%>)">e-mail</a>)
         <%}%>

               </td>
               <td class="DataTable" nowrap><%=sUps[j]%></td>
               <td class="DataTable" nowrap><%=sPrtDate[j]%> <%=sPrtTime[j]%></td>
               <td class="DataTable1" nowrap><%=sShipMeth[j]%></td>
               <%if(bAllowDist){%>
                   <td class="DataTable1" nowrap>
                      <%if(sWhse[j].equals("1") || sWhse[j].equals("70")){%>
                        <a class="Small" href="javascript: reAssigSku('<%=sSite%>', '<%=sOrder%>', '<%=sAllocSku%>', '<%=sWhse[j]%>', '<%=sAllocQty[j]%>')">Open</a>
                      <%}%>
                   </td>
               <%}%>
             </tr>
           <%}%>
         <%}%>
      </table>

      <br>
      <%if((iReadyWhsPrt > 0 || iReadyStrPrt > 0)  && bAllowButton){%>
      <%if(!sEmail.equals("Not found") && bAllowButton){%>
         &nbsp; &nbsp; &nbsp;
         <button class="Small" onclick="sendCustInfoToBronto('<%=sSite%>', '<%=sOrder%>')">Send custormer information<br>to Bronto</button>
      <%}%>
      <%if(bUps){%>
          &nbsp; &nbsp; &nbsp;
          <button class="Small" onclick="sendOrdToUPS('<%=sSite%>', '<%=sOrder%>')">Add to UPS</button>
      <%}%>
         <!-- button class="Small" onclick="prtPackSlip('<%=sSite%>', '<%=sOrder%>', null, 'WAREHSELJ7', 'QUSRSYS')">
            Reprint Order Pack Slip<br>(on WAREHSELJ7)
         </button -->
      <%}%>



      <br><br>
   <!-- ============================ Allocation =========================== -->
   <%if(iNumOfCtn > 0){%>
     <table border=1 cellPadding="0" cellSpacing="0" >
         <tr class="DataTable">
           <th class="DataTable" colspan=10>Ship-To-Store</th>
         </tr>
         <tr class="DataTable">
           <th class="DataTable">Str</th>
           <th class="DataTable">Carton</th>
           <th class="DataTable">Shipped</th>
           <th class="DataTable">Received</th>
           <th class="DataTable">Handled</th>
        </tr>

        <%for(int i=0; i < iNumOfCtn; i++ )
        {
          ordLst.setCarton();
          String sStsStr = ordLst.getStsStr();
          String sCarton = ordLst.getCarton();
          String sStsShip = ordLst.getStsShip();
          String sStsShipDt = ordLst.getStsShipDt();
          String sStsShipTm = ordLst.getStsShipTm();
          String sStsRecvd = ordLst.getStsRecvd();
          String sStsRcvUs = ordLst.getStsRcvUs();
          String sStsRcvSts = ordLst.getStsRcvSts();
          String sStsRcvDt = ordLst.getStsRcvDt();
          String sStsRcvTm = ordLst.getStsRcvTm();
          String sStsHandle = ordLst.getStsHandle();
          String sStsHndUs = ordLst.getStsHndUs();
          String sStsHndDt = ordLst.getStsHndDt();
          String sStsHndTm = ordLst.getStsHndTm();
        %>
           <tr id="trItem" class="DataTable">
             <td class="DataTable2" nowrap><%=sStsStr%></td>
             <td class="DataTable" nowrap><%=sCarton%></td>
             <td class="DataTable1" nowrap><%if(sStsShip.equals("Y")){%><%=sStsShipDt%> <%=sStsShipTm%><%}%></td>
             <td class="DataTable11" nowrap><%if(sStsRecvd.equals("Y")){%><%=sStsRcvUs%><br><%=sStsRcvSts%><br><%=sStsRcvDt%> <%=sStsRcvTm%><%}%></td>
             <td class="DataTable11" nowrap><%if(sStsHandle.equals("Y")){%><%=sStsHndUs%><br><%=sStsRcvDt%> <%=sStsRcvTm%><%}%></td>
           </tr>
         <%}%>
      </table>

      <%if(bAllowButton){%>
          <button class="Small" onclick="dspPackSlip('<%=sSite%>', '<%=sOrder%>')">Order Pack Slip</button>
          <%if(!sEmail.equals("Not found")){%>
             &nbsp; &nbsp; &nbsp;
             <button class="Small" onclick="sendCustInfoToBronto('<%=sSite%>', '<%=sOrder%>')">Send ship-to-store<br>status to Bronto</button>
          <%}%>
      <%}%>

   <%}%>
   
   
   
<%}%>
<%if(bAllowButton){%>
   <button class="Small" onclick="getCustELabInfo('<%=sSite%>','<%=sEmail%>')">Get ELab Info</button>
<%}%>
<p id="pLastLine">
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
   <!-------------------------------------------------------------------->
   <!-- iframe  id="frame2"  src=""  frameborder=1 height="300" width="100%"></iframe -->
   <p id="pBottom" />
   <div id="dvHoCtl" class="dvHoCtl">
      <table border=0 width='100%' cellPadding=0 cellSpacing=0>
	     <tr>
	       <td class='BoxName' nowrap>HO Control</td>
	           <td class='BoxClose' valign=top>	           
	        </td>
	     </tr>
	     <tr>
	     	<td class='Prompt1'>
	       		<object type="text/html"  id="objHoCtl"
    			data = "MozuSrlAsgCtl.jsp?StsFrDate=01/01/0001&StsToDate=12/31/2099&Ord=<%=sOrder%>&OrdSts=1&Sts=Open&Sts=Assigned&Sts=Printed&Sts=Picked&Sts=Problem&Sts=Resolve&Sts=Shipped&Sts=Cannot Fill&Sts=Sold Out&Sts=Error&Sts=Cancelled&InDiv=Yes"
    			width="800px" height="300px" style="overflow:auto;">
    			</object>
	        </td>
	     </tr>
	  </table>
   </div>
   <%for(int i=0; i < 20;i++){%>&nbsp;<br/><%}%>  
   
   
 </BODY>
</HTML>
<%
   ordLst.disconnect();
   }
%>