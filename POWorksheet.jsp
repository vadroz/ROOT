<%@ page import="posend.POWorksheet, java.util.*, java.text.*, inventoryreports.PiCalendar
,rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*"%>
<%
 //----------------------------------
 // Application Authorization
 //----------------------------------

 if (session.getAttribute("USER")==null)
 {
   response.sendRedirect("SignOn1.jsp?TARGET=POWorksheet.jsp&APPL=ALL&" + request.getQueryString());
 }
 else
 {
    String sPONum = request.getParameter("PO");
    String sUser = session.getAttribute("USER").toString();
    String sSort = request.getParameter("Sort");

    if(sSort == null) sSort = "SEQ";

    POWorksheet POWorksheet = new POWorksheet(sPONum, sUser, sSort);
    String sPages = POWorksheet.getPages();
    String sOrdDt = POWorksheet.getOrdDt();
    String sOrgAntcDt = POWorksheet.getOrgAntcDt();
    String sAntcDt = POWorksheet.getAntcDt();
    String sCnclDt = POWorksheet.getCnclDt();
    String sOrigPO = POWorksheet.getOrigPO();
    String sVia = POWorksheet.getVia();
    String sTerms = POWorksheet.getTerms();
    String sCommod = POWorksheet.getCommod();
    String sVenNum = POWorksheet.getVenNum();
    String sVenName = POWorksheet.getVenName();
    String [] sTopCmt = POWorksheet.getTopCmt();
    String [] sBotCmt = POWorksheet.getBotCmt();
    String sBuyer = POWorksheet.getBuyer();
    String sPORet = POWorksheet.getPORet();
    String sPOCost = POWorksheet.getPOCost();
    String sPOQty = POWorksheet.getPOQty();
    String sDisc = POWorksheet.getDisc();
    String sStatus = POWorksheet.getStatus();
    String sRevNum = POWorksheet.getRevNum();
    String [] sShipTo = POWorksheet.getShipTo();
    String sDiv = POWorksheet.getDiv();
    String sDivName = POWorksheet.getDivName();
    String sPOReceipt = POWorksheet.getPOReceipt();
    String sPOLastDt = POWorksheet.getPOLastDt();
    String sTotOpnQty = POWorksheet.getTotOpnQty();
    String sTotRcvQty = POWorksheet.getTotRcvQty();

    int iNumOfItm = POWorksheet.getNumOfItm();
    String [] sCls = POWorksheet.getCls();
    String [] sVen = POWorksheet.getVen();
    String [] sSty = POWorksheet.getSty();
    String [] sClr = POWorksheet.getClr();
    String [] sSiz = POWorksheet.getSiz();
    String [] sSku = POWorksheet.getSku();
    String [] sCost = POWorksheet.getCost();
    String [] sRet = POWorksheet.getRet();
    String [] sQty = POWorksheet.getQty();
    String [] sDesc = POWorksheet.getDesc();
    String [] sVenSty = POWorksheet.getVenSty();
    String [] sUpc = POWorksheet.getUpc();
    String [] sClrName = POWorksheet.getClrName();
    String [] sSizName = POWorksheet.getSizName();
    String [] sLvlBreak = POWorksheet.getLvlBreak();
    String [] sSeq = POWorksheet.getSeq();
    String [] sLastQty = POWorksheet.getLastQty();
    String [] sOnHand = POWorksheet.getOnHand();
    String [] sRcvQty = POWorksheet.getRcvQty();
    String [] sOrgQty = POWorksheet.getOrgQty();
    String [] sClsNm = POWorksheet.getClsNm();
    
    int iNumOfPages = POWorksheet.getNumOfPages();
    int [] iNumOfItemsOnPage = POWorksheet.getNumOfItemsOnPage();

    POWorksheet.disconnect();
    POWorksheet = null;
    
    SimpleDateFormat usaDt = new SimpleDateFormat("MM/dd/yyyy");
    Calendar cal = Calendar.getInstance();    
    
    cal.setTime(new java.util.Date());
    cal.add(Calendar.DATE, -30);
    java.util.Date dt = cal.getTime();    
    String sHstFrDt = usaDt.format(dt);
    
    cal.setTime(new java.util.Date());
    cal.add(Calendar.DATE, +30);
    dt = cal.getTime();
    String sHstToDt = usaDt.format(dt);
    System.out.println(" to" + sHstToDt);
    
 // get PI Calendar
    PiCalendar setcal = new PiCalendar();
    String sPiYear = setcal.getYear();
    String sPiMonth = setcal.getMonth();
    String sPiDesc = setcal.getDesc();
    setcal.disconnect();    
    
    // get employee list
    String sPrepStmt = "select erci, ename"
   		+ " from Rci.Rciemp"
    	+ " where estore=" + sShipTo[0]   		    
    	+ " order by ename";
    	   	
   	System.out.println(sPrepStmt);
    	   	
   	ResultSet rslset = null;
   	RunSQLStmt runsql = new RunSQLStmt();
  	runsql.setPrepStmt(sPrepStmt);		   
   	runsql.runQuery();
    	   		   
   	Vector<String> vEmp = new Vector<String>();
   	Vector<String> vEmpNm = new Vector<String>();
   	
   	while(runsql.readNextRecord())
   	{
   		vEmp.add(runsql.getData("erci"));
   		vEmpNm.add(runsql.getData("ename"));
   	}
    runsql.disconnect();
    runsql = null;
%>

<style>
   @media screen{ body {background:white;}  }

        table.DataTable { border: black solid 1px; text-align:center;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}

        th.DataTable { border-bottom: black solid 1px; border-right: black solid 1px; padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:10px }

        th.DataTable1 { border-bottom: black solid 1px; border-right: black solid 1px; padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        th.DataTable2 {  padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:11px }


        tr.DataTable { background: #E7E7E7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: white; font-family:Arial; font-size:10px }
        tr.DataTable2 { background: white; font-family:Arial; font-size:11px; font-weight:bold }
        tr.DataTable3 { color:red; background: khaki; font-family:Arial; font-size:12px; font-weight:bold; }
        tr.DataTable4 { background:#FFCC99; font-family:Arial; font-size:12px; font-weight:bold; }
        tr.DataTable5 { background: LemonChiffon; font-family:Arial; font-size:10px }


        td.Hdr { padding-top:0px; padding-bottom:0px; padding-left:3px;
                 padding-right:3px; text-align:left;}

        td.DataTable { border-bottom: black solid 1px; border-right: black solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable1 { border-bottom: black solid 1px; border-right: black solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px; vertical-align:top;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { border-bottom: black solid 1px; border-right: black solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

        td.DataTable3 { border-bottom: black solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; }

        td.DataTable4 { padding-top:3px; padding-bottom:3px; padding-left:3px; vertical-align:top;
                         padding-right:3px; text-align:left;}
        td.DataTable5 { padding-top:3px; padding-bottom:3px; padding-left:3px; vertical-align:top;
                         padding-right:3px; text-align:center;}
        td.DataTable6 { padding-top:3px; padding-bottom:3px; padding-left:3px; vertical-align:top;
                         padding-right:3px; text-align:right;}

		td.DataTable7 { cursor: hand; text-decoration: underline; color:blue;border-bottom: black solid 1px; border-right: black solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        

        td.Page { border: black solid 1px; vertical-align:top;
                  padding-top:3px; padding-bottom:3px; padding-left:3px;
                  padding-right:3px; text-align:left;}


        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }
        button.btnSubmit { font-size:10px }

        div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}


        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Prompt {border-bottom: black solid 2px; border-right: black solid 1px; text-align:center;
                   font-family:Arial; font-size:10px; }

@media print
{
   @page {size: landscape}
   #LastRct {display:none;}
   button.btnSubmit {display:none;}
}

</style>

<script name="javascript1.2">
var NumOfItm = "<%=iNumOfItm%>";
var NumOfNewItm = 0;
var PONum = "<%=sPONum%>";

var Carr = null;
var Boxes = null;
var RcvDt = null;
var ChkDt = null;
var PlQty = null;
var RcvQty = null;
var RcvBy = null;
var Commt = null;

var VenSty = new Array();
var Upc = new Array();
var Sku = new Array();
var Desc = new Array();
var ClrNm= new Array();
var SizNm = new Array();
var ItmQty = new Array();
var ItmSeq = new Array();

var nwVenSty = new Array();
var nwUpc = new Array();
var nwSku = new Array();
var nwDesc = new Array();
var nwClrNm= new Array();
var nwSizNm = new Array();
var nwItmQty = new Array();
var nwItmSeq = new Array();

var HstStr = "<%=sShipTo[0]%>";
var HstFrDt = "<%=sHstFrDt%>";
var HstToDt = "<%=sHstToDt%>";

var PiYear = [<%=sPiYear%>];
var PiMonth = [<%=sPiMonth%>];
var PiDesc =  [<%=sPiDesc%>];

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   // activate move box
   setBoxclasses(["BoxName",  "BoxClose"], ["Prompt"]);
}

//==============================================================================
//run on loading
//==============================================================================
function getSkuHist(sku)
{
	var cal = PiYear[0] + PiMonth[0];
	for(var i=0; i < PiYear.length; i++)
	{
		if(PiDesc[i].indexOf("End of Year PI") > 0)			
		{
			cal = PiYear[i] + PiMonth[i];
			break;
		}
	}
	
	var url = "PIItmSlsHst.jsp?Sku=" + sku 
		+ "&SlsOnTop=1" 
		+ "&STORE=" + HstStr
		+ "&FromDate=01/01/0001"
		+ "&ToDate=12/31/2999"
		+ "&PICal=" + cal
	window.open(url, "Sku_History");
	
}
//==============================================================================
// receiving all item
//==============================================================================
function rcvAllItem()
{
   for(var i=0, j=0; i < NumOfItm; i++)
   {
     var qtynm = "tdQty" + i;
     var rcvnm = "tdRcv" + i;
     var itmq = "ItmQty" + i;
     var seqnm = "tdSeq" + i;

     var qty = document.all[qtynm].innerHTML;
     var rcv = document.all[rcvnm].innerHTML;
     var seq = document.all[seqnm].innerHTML;
     var ready = eval(qty) - eval(rcv);
     if(ready > 0){ document.all[itmq].value = ready; }
  }
}
//==============================================================================
// show PO receiving information
//==============================================================================
function showRcvInfo()
{
   var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap>PO Item Receiving Verification</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
     + "<tr><td class='Prompt' colspan=2>" + popRcvInfo()
      + "</td></tr>"

   html += "</table>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft = document.documentElement.scrollLeft + 200;
   document.all.Prompt.style.pixelTop= document.documentElement.scrollTop + 50;
   document.all.Prompt.style.visibility = "visible";

   document.all.spnRcvQty.innerHTML = RcvQty;
}
//==============================================================================
// populate correction table
//==============================================================================
function popRcvInfo()
{
  var error = new Array();
  var msg = "";
  var panel = "<span style='font-size:12px; font-weight:bold;'>"
    + "Submit PO Receiving to Inventory Control"
    + "<span>"

  Carr = document.all.Carr.value.trim();
  Boxes = document.all.NumBox.value.trim();
  RcvDt = document.all.RcvDt.value.trim();
  ChkDt = document.all.ChkDt.value.trim();
  PlQty = document.all.PlQty.value.trim();
  RcvQty = 0; //document.all.RcvQty.value.trim();
  RcvBy = document.all.RcvBy.value.trim();
  Commt = document.all.Commt.value.trim();

  panel += "<table border=0 width='100%' cellPadding='0' cellSpacing='0' id='tblRcvHdr'>"
  panel += "<tr class='DataTable5'>"
         + "<td class='DataTable4' nowrap>Freight Carrier: <b>" + Carr + "</b></td>"
         + "<td class='DataTable4' nowrap># of Boxes: <b>" + Boxes + "</b></td>"
         + "<td class='DataTable4' nowrap>Date Received: <b>" + RcvDt + "</b></td>"
       + "</tr>"

       + "<tr class='DataTable5'>"
         + "<td class='DataTable4' nowrap>Check Date: <b>" + ChkDt + "</b></td>"
         + "<td class='DataTable4' nowrap>P/L Qty: <b>" + PlQty + "</b></td>"
         + "<td class='DataTable4' nowrap>Rcv&#180;d Qty: <b><span id='spnRcvQty'>" + RcvQty + "</span></b></td>"
       + "</tr>"

       + "<tr class='DataTable5'>"
         + "<td class='DataTable4' nowrap>Rcv&#180;d by: <b>" + RcvBy + "</b></td>"
         + "<td class='DataTable4' colspan=2>Comments: <b>" + Commt + "</b></td>"
       + "</tr>"
         
        	
       var compl = new Array(6);
       
       compl[0] = "No"; compl[1] = "No"; compl[2] = "No"; 
       compl[3] = "No"; compl[4] = "No"; compl[5] = "No"
       if (document.all.ComplErr[0].checked){ compl[0] = "Yes"; }
       if (document.all.ComplErr[1].checked){ compl[1] = "Yes"; }
       if (document.all.ComplErr[2].checked){ compl[2] = "Yes"; }
       if (document.all.ComplErr[3].checked){ compl[3] = "Yes"; }
       if (document.all.ComplErr[4].checked){ compl[4] = "Yes"; }
       if (document.all.ComplErr[5].checked){ compl[5] = "Yes"; }
       
       panel += "<tr class='DataTable5'>"
    	   + "<td class='DataTable5' colspan=3 nowrap>"
       panel += "<table border=0  cellPadding='0' cellSpacing='0'>"	   
       
       panel += "<tr class='DataTable5'>"
      	 + "<td class='DataTable4' nowrap>EDI/ASN Carton labels - but they will not Scan</td>"
      	 + "<td class='DataTable5'><b>" + compl[0] + "</b></td>"
       + "</tr>"	 
       + "<tr class='DataTable5'>"
    	 + "<td class='DataTable4' nowrap>No PO number listed on outside cartons </td>"
    	 + "<td class='DataTable5'><b>" + compl[1] + "</b></td>"
       + "</tr>"
       + "<tr class='DataTable5'>"
    	 + "<td class='DataTable4'nowrap>No Packing List (P/L) on outside label or inside cartons</td>"
    	 + "<td class='DataTable5'><b>" + compl[2] + "</b></td>"
       + "</tr>"
       + "<tr class='DataTable5'>"
    	 + "<td class='DataTable4' nowrap>Overages in QTYs received vs, Total QTY Ordered</td>"
    	 + "<td class='DataTable5'><b>" + compl[3] + "</b></td>"
       + "</tr>"
       + "<tr class='DataTable5'>"
    	 + "<td class='DataTable4' nowrap>Shortages in QTY received (listed on P/L, but not recvd in shipment.)</td>"
    	 + "<td class='DataTable5'><b>" + compl[4] + "</b></td>"
       + "</tr>"
       + "<tr class='DataTable5'>"
  	 	 + "<td class='DataTable4' nowrap>Received a substitution (SUB), item is not on the PO.</td>"
  	     + "<td class='DataTable5'><b>" + compl[5] + "</b></td>"
       + "</tr>"
       
       
       panel += "</table>";
       panel += "</td></tr>"; 
       
  panel += "</table>";

  // ----------- Items ---------------
  VenSty = nwVenSty;
  Upc = nwUpc;
  Sku = nwSku;
  Desc = nwDesc;
  ClrNm= nwClrNm;
  SizNm = nwSizNm;
  ItmQty = nwItmQty;
  ItmSeq[0] = 0;

  panel += "<table border=1 width='100%' cellPadding='0' cellSpacing='0' id='tblRcvItm'>"
  panel += "<tr class='DataTable4'>"
         + "<th class='DataTable2' nowrap>Vendor<br>Style</th>"
         + "<th class='DataTable2' nowrap>UPC</th>"
         + "<th class='DataTable2' nowrap>Sku</th>"
         + "<th class='DataTable2' nowrap>Description</th>"
         + "<th class='DataTable2' nowrap>Color<br>Name</th>"
         + "<th class='DataTable2' nowrap>Size<br>Name</th>"
         + "<th class='DataTable2' nowrap>Rcv<br>Qty</th>"
       + "</tr>"

  for(var i=0, j=0; i < eval(NumOfItm) + eval(NumOfNewItm); i++)
  {
     var vensty = "tdVenSty" + i;
     var upc = "tdUpc" + i;
     var sku = "tdSku" + i;
     var desc = "tdDesc" + i;
     var clrnm = "tdClrNm" + i;
     var siznm = "tdSizNm" + i;
     var itmq = "ItmQty" + i;
     var itmseq = "tdSeq" + i;

     if(document.all[itmq].value.trim() != "")
     {
       VenSty[j] = document.all[vensty].innerHTML;
       Upc[j] = document.all[upc].innerHTML;
       Sku[j] = document.all[sku].innerHTML;
       Desc[j] = document.all[desc].innerHTML;
       ClrNm[j] = document.all[clrnm].innerHTML;
       SizNm[j] = document.all[siznm].innerHTML;
       ItmQty[j] = document.all[itmq].value.trim();
       ItmSeq[j] = document.all[itmseq].innerHTML;

       RcvQty = eval(RcvQty) -  -1 * eval(ItmQty[j]);

       panel += "<tr class='DataTable'>"
           + "<td class='DataTable4' nowrap>" + VenSty[j] +  "</th>"
           + "<td class='DataTable4' nowrap>" + Upc[j] +  "</th>"
           + "<td class='DataTable4' nowrap>" + Sku[j] +  "</th>"
           + "<td class='DataTable4' nowrap>" + Desc[j] +  "</th>"
           + "<td class='DataTable4' nowrap>" + ClrNm[j] +  "</th>"
           + "<td class='DataTable4' nowrap>" + SizNm[j] +  "</th>"
           + "<td class='DataTable4' nowrap>" + ItmQty[j] +  "</th>"
        + "</tr>"
        j++;
     }
  }

  // ---------- validate header and items -----------------
  msg = validateHdr();
  msg += validateDtl();
  error[0] = (msg != "");

  if(error[0])
  {
     panel += "<tr class='DataTable3'><td class='DataTable4' colspan=7>" + msg + "</td></tr>"
  }

  panel += "<tr><td class='DataTable5' colspan=9>";

  if(!error[0])
  {
    panel += "<button class='Small' onclick='sbmPORcv();'>Submit</button> &nbsp; "
  }

  panel += "<button class='Small' onclick='hidePanel();'>Close</button>"
      + "</td></tr>"

  panel += "</table>";
  return panel;
}


//==============================================================================
// validate PO receiving information
//==============================================================================
function validateHdr()
{
   var msg = "";

   if(Carr == ""){msg += "Freight Carrier is blank." }
   if(Boxes == "" || isNaN(Boxes) || eval(Boxes) <= 0){ msg += "<br>Number of boxes is blank or invalid." }
   if(RcvDt == "" ){ msg += "<br>Receiving date is blank." }
   if(ChkDt == "" ){ msg += "<br>Check date is blank." }
   if(PlQty == "" || isNaN(PlQty) || eval(PlQty) <= 0){ msg += "<br>P/L Quantity is blank or invalid." }
   
   if(RcvBy == "" ){ msg += "<br>Received by Employee Id is blank." }
   else
   {
	   	sel = document.getElementById("SelEmp");
	   	var find = false;
	  	for(var i=0; i < sel.length; i++)
	  	{
	  		if(RcvBy == sel.options[i].value){ find = true; break;}
	  	}
	  	if( !find ){ msg += "<br>Received by Employee Id is incorrect." }
   }

   return msg;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function validateDtl()
{
   var msg = "";
   var error = false;

   if(ItmQty.length == 0){msg += "<br>Please received at least 1 item."}
   else
   {
      for(var i=0; i < ItmQty.length; i++)
      {
         if(isNaN(ItmQty[i]) || eval(ItmQty[i]) < 0){ error = true; }
      }
   }

   if(error){ msg += "<br>Item Received Quantity is blank or invalid." }

   return msg;
}
//==============================================================================
// submit PO receiving
//==============================================================================
function sbmPORcv()
{
   var html = "<form method='post' action='PORcvSav.jsp' name='frmPORcv'>"
     + "<input name='PO' value='" + PONum + "'>"
     + "<input name='Carr' value='" + Carr + "'>"
     + "<input name='Boxes' value='" + Boxes + "'>"
     + "<input name='RcvDt' value='" + RcvDt + "'>"
     + "<input name='ChkDt' value='" + ChkDt + "'>"
     + "<input name='PlQty' value='" + PlQty + "'>"
     + "<input name='RcvQty' value='" + RcvQty + "'>"
     + "<input name='RcvBy' value='" + RcvBy + "'>"
     + "<input name='User' value='<%=sUser%>'>"
     + "<input name='Commt' value='" + Commt + "'>"

   var compl = document.all.ComplErr;
   for(var i=0; i < compl.length; i++)
   {  
	  var check = 'N'; 
	  if(compl[i].checked){ check = 'Y'; } 
	  
	  html += "<input name='ComplErr' value='" + check + "'>";
   }
   
   for(var i=0; i < VenSty.length; i++)
   {
      html += "<input name='VenSty' value='" + VenSty[i] + "'>"
         + "<input name='Upc' value='" + Upc[i] + "'>"
         + "<input name='Sku' value='" + Sku[i] + "'>"
         + "<input name='Desc' value='" + Desc[i] + "'>"
         + "<input name='ClrNm' value='" + ClrNm[i] + "'>"
         + "<input name='SizNm' value='" + SizNm[i] + "'>"
         + "<input name='ItmQty' value='" + ItmQty[i] + "'>"
         + "<input name='ItmSeq' value='" + ItmSeq[i] + "'>"
   }
   html += "</form>";

   var nwelem = window.frame1.document.createElement("div");
   nwelem.id = "dvSbmPORcv"
   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   //alert(html)
   window.frame1.document.frmPORcv.submit();
}

//==============================================================================
// add new item
//==============================================================================
function addNewItem()
{
   var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap>Add New Item to PO</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
     + "<tr><td class='Prompt' colspan=2>" + popNewItem()
      + "</td></tr>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft = document.documentElement.scrollLeft + 20;
   document.all.Prompt.style.pixelTop= document.documentElement.scrollTop + 50;
   document.all.Prompt.style.visibility = "visible";
}
//==============================================================================
// populate new Item panel
//==============================================================================
function popNewItem()
{
  var error = new Array();
  var msg = "";
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0' id='tblRcvHdr'>"

  panel += "<table border=1 width='100%' cellPadding='0' cellSpacing='0' id='tblRcvItm'>"
  panel += "<tr class='DataTable4'>"
         + "<th class='DataTable2' nowrap>Vendor<br>Style</th>"
         + "<th class='DataTable2' nowrap>UPC</th>"
         + "<th class='DataTable2' nowrap>Sku</th>"
         + "<th class='DataTable2' nowrap>Description</th>"
         + "<th class='DataTable2' nowrap>Color<br>Name</th>"
         + "<th class='DataTable2' nowrap>Size<br>Name</th>"
         + "<th class='DataTable2' nowrap>Rcv<br>Qty</th>"
       + "</tr>"

       panel += "<tr class='DataTable'>"
           + "<td class='DataTable4'><input name='inpVenSty' size=15 maxlength=15></td>"
           + "<td class='DataTable4'><input name='inpUpc' size=13 maxlength=13></td>"
           + "<td class='DataTable4'><input name='inpSku' size=10 maxlength=10></td>"
           + "<td class='DataTable4'><input name='inpDesc' size=25 maxlength=25></td>"
           + "<td class='DataTable4'><input name='inpClrNm' size=25 maxlength=25></td>"
           + "<td class='DataTable4'><input name='inpSizNm' size=10 maxlength=10></td>"
           + "<td class='DataTable4'><input name='inpItmQty' size=5 maxlength=5></td>"
        + "</tr>"

  panel += "<tr class='DataTable3'><td class='DataTable4' id='tdErrMsg' colspan=7>" + msg + "</td></tr>"

  panel += "<tr><td class='DataTable5' colspan=9>";
  panel += "<button class='Small' onclick='validateNewItem();'>Submit</button> &nbsp; "
  panel += "<button class='Small' onclick='hidePanel();'>Close</button>"
      + "</td></tr>"

  panel += "</table>";
  return panel;
}

//==============================================================================
// validate new PO rceiving
//==============================================================================
function validateNewItem()
{
   var msg = "";
   var error = false;

   var vensty = document.all.inpVenSty.value.trim();
   var upc = document.all.inpUpc.value.trim();
   var sku = document.all.inpSku.value.trim();
   var desc = document.all.inpDesc.value.trim();
   var clrnm = document.all.inpClrNm.value.trim();
   var siznm = document.all.inpSizNm.value.trim();
   var itmqty = document.all.inpItmQty.value.trim();

   if( vensty == ""){ error = true; msg += "<br>Vendor Style is blank."; }
   if( upc == ""){ error = true; msg += "<br>UPC is blank."; }
   if( desc == ""){ error = true; msg += "<br>Description is blank."; }
   if( clrnm == ""){ error = true; msg += "<br>Clear Name is blank."; }
   if( siznm == ""){ error = true; msg += "<br>Size Name is blank."; }
   if( itmqty == "" || isNaN(itmqty) || eval(itmqty) <= 0){ error = true; msg += "<br>Item Quantity is blank or invalid."; }

   if(error){ document.all.tdErrMsg.innerHTML = msg;}
   else
   {
      document.all.tdErrMsg.innerHTML = "";
      crtNewItem(vensty, upc, sku, desc, clrnm, siznm, itmqty);
   }
}
//==============================================================================
// create new item as row in table
//==============================================================================
function crtNewItem(vensty, upc, sku, desc, clrnm, siznm, itmqty)
{
   nwVenSty[NumOfNewItm] = vensty;
   nwUpc[NumOfNewItm] = upc;
   nwSku [NumOfNewItm] = sku;
   nwDesc[NumOfNewItm] = desc;
   nwClrNm[NumOfNewItm] = clrnm;
   nwSizNm[NumOfNewItm] = siznm;
   nwItmQty[NumOfNewItm] = itmqty;

   NumOfNewItm++;
   var i = eval(NumOfItm) + eval(NumOfNewItm) - 1;
   var tbody = document.getElementById("tblItem").getElementsByTagName("TBODY")[0];

   var row = document.createElement("TR");
   row.className="DataTable1";

   var td1 = document.createElement("td");
   td1.id = "tdClsNm" + i;
   td1.appendChild(document.createTextNode(" "));
   td1.className="DataTable1";
  
   var td2 = document.createElement("td");
   td2.id = "tdVenSty" + i;
   td2.appendChild(document.createTextNode(vensty));
   td2.className="DataTable1";

   var td3 = document.createElement("td")
   td3.id = "tdUpc" + i;
   td3.className="DataTable";
   td3.appendChild (document.createTextNode(upc))

   var td4 = document.createElement("td")
   td4.id = "tdDesc" + i;
   td4.className="DataTable1";
   td4.appendChild (document.createTextNode(desc))

   var td5 = document.createElement("td")
   td5.id = "tdClrNm" + i;
   td5.className="DataTable1";
   td5.appendChild (document.createTextNode(clrnm))

   var td6 = document.createElement("td")
   td6.id = "tdSizNm" + i;
   td6.className="DataTable1";
   td6.appendChild (document.createTextNode(siznm))

   var td7 = document.createElement("td")
   td7.id = "tdSku" + i;
   td7.className="DataTable7";
   td7.appendChild (document.createTextNode(sku))

   var td8 = document.createElement("td")
   td8.className="DataTable2";
   td8.appendChild (document.createTextNode(" "))

   var td9 = document.createElement("td")
   td9.className="DataTable2";
   td9.appendChild (document.createTextNode(" "))

   var td10 = document.createElement("td")
   td10.className="DataTable2";
   td10.appendChild (document.createTextNode(" "))
   
   var td11 = document.createElement("td")
   td11.className="DataTable";
   td11.id = "tdSeq" + i;
   td11.appendChild (document.createTextNode(" "))

   var td12 = document.createElement("td")
   td12.id = "tdItmQty" + i;
   td12.className="DataTable";
   td12.innerHTML="<input name='ItmQty" + i + "' class='Small' size=9 maxlength=9 value='" + itmqty + "'>";

   var td13 = document.createElement("td")
   td13.className="DataTable2";
   td13.appendChild (document.createTextNode(" "))

   var td14 = document.createElement("td")
   td14.className="DataTable2";
   td14.appendChild (document.createTextNode(" "))

   row.appendChild(td1);
   row.appendChild(td2);
   row.appendChild(td3);
   row.appendChild(td4);
   row.appendChild(td5);
   row.appendChild(td6);
   row.appendChild(td7);
   row.appendChild(td8);
   row.appendChild(td9);
   row.appendChild(td10);
   row.appendChild(td11);
   row.appendChild(td12);
   row.appendChild(td13);
   row.appendChild(td14);
    
   
   tbody.appendChild(row);

   hidePanel();
}
//==============================================================================
// retreive substitution item lsit entered at any date for this PO
//==============================================================================
function setSubstitutions()
{
   var url = "PORcvNewItems.jsp?PO=" + PONum
   window.frame1.location = url;
}
//==============================================================================
// show substitutions
//==============================================================================
function showSubstitutions(rcvDt, venSty, upc, sku, desc, clrNm, sizNm, rcvQty, init)
{
var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap>PO Item Substitution</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
     + "<tr><td class='Prompt' colspan=2>" + popSubstitutions(rcvDt, venSty, upc, sku, desc, clrNm, sizNm, rcvQty, init)
      + "</td></tr>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft = document.documentElement.scrollLeft + 300;
   document.all.Prompt.style.pixelTop= document.documentElement.scrollTop + 50;
   document.all.Prompt.style.visibility = "visible";
}
//==============================================================================
// populate new Item panel
//==============================================================================
function popSubstitutions(rcvDt, venSty, upc, sku, desc, clrNm, sizNm, rcvQty, init)
{
  var error = new Array();
  var msg = "";
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0' id='tblRcvHdr'>"

  panel += "<table border=1 width='100%' cellPadding='0' cellSpacing='0' id='tblRcvItm'>"
  panel += "<tr class='DataTable4'>"
         + "<th class='DataTable2' nowrap>Receiving<br>Date</th>"
         + "<th class='DataTable2' nowrap>Vendor<br>Style</th>"
         + "<th class='DataTable2' nowrap>UPC</th>"
         + "<th class='DataTable2' nowrap>Sku</th>"
         + "<th class='DataTable2' nowrap>Description</th>"
         + "<th class='DataTable2' nowrap>Color<br>Name</th>"
         + "<th class='DataTable2' nowrap>Size<br>Name</th>"
         + "<th class='DataTable2' nowrap>Rcv<br>Qty</th>"
         + "<th class='DataTable2' nowrap>Init</th>"
       + "</tr>"

  for(var i=0; i < rcvDt.length; i++)
  {
       panel += "<tr class='DataTable'>"
           + "<td class='DataTable4' nowrap>" + rcvDt[i] + "</td>"
           + "<td class='DataTable4' nowrap>" + venSty[i] + "</td>"
           + "<td class='DataTable4' nowrap>" + upc[i] + "</td>"
           + "<td class='DataTable6' nowrap>&nbsp;" + sku[i] + "</td>"
           + "<td class='DataTable4' nowrap>&nbsp;" + desc[i] + "</td>"
           + "<td class='DataTable4' nowrap>&nbsp;" + clrNm[i] + "</td>"
           + "<td class='DataTable4' nowrap>&nbsp;" + sizNm[i] + "</td>"
           + "<td class='DataTable6' nowrap>&nbsp;" + rcvQty[i] + "</td>"
           + "<td class='DataTable4' nowrap>" + init[i] + "</td>"
        + "</tr>"
  }

  panel += "<tr><td class='DataTable5' colspan=9>";
  panel += "<button class='Small' onclick='hidePanel();'>Close</button>"
      + "</td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.Prompt.innerHTML = " ";
   document.all.Prompt.style.visibility = "hidden";
}

//==============================================================================
// restart window
//==============================================================================
function restart()
{
   alert("PO Receiving information was saved.");
   window.location.reload()
}
//==============================================================================
// set selected employee
//==============================================================================
function setSelEmp(sel)
{
	rcvby = document.getElementById("RcvBy");
	rcvby.value = sel.options[sel.selectedIndex].value;
}
//==============================================================================
//set selected employee
//==============================================================================
function setEmpNm(empid)
{
	sel = document.all.SelEmp;
	for(var i=0; i < sel.length; i++)
	{
		if(sel.options[i].value == empid.value)
		{
			sel.selectedIndex = i;
			break;
		}
	}
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<HTML><HEAD>

<META content="RCI, Inc." name=POPrint></HEAD>
<BODY onload="bodyLoad();">

<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
  <div id="Prompt" class="Prompt"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <!-- ================================================================= -->
  <!-- ================================================================= -->
  <tr>
    <td vAlign=top align=center colspan=3>
       <b>Retail Concepts, Inc
       <br>Receiving Worksheet
       <br>
       </b>
    </td>
  </tr>
  <tr>
    <td class="Hdr" colspan=3>
      <table class="DataTable" cellPadding="0" cellSpacing="0" width="100%" height="100%">
         <tr class="DataTable1">
           <td class="Hdr">
                  Division: <%=sDiv + " - " + sDivName%> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  Str <span style="font-size:14px;font-weight:bold;"><%=sShipTo[0]%></span>
              <br>Freight Carrier: <input name="Carr" size=30 class="Small" maxlength=30>
              <br># of Cartons: <input name="NumBox" size=5 class="Small" maxlength=5>
              <br>Packing List Qty: <input name="PlQty" size=9 class="Small" maxlength=9>              
              
           </td>
           <td class="Hdr">
              P.O.# <span style="font-size:18px; font-weight:bold;"><%=sPONum%> - <%=sVenName%></span>

              
              <br>Date RCV'D: <input name="RcvDt" size=10 class="Small" maxlength=10 readonly>
              <a href="javascript:showCalendar(1, null, null, 150, 180, document.all.RcvDt)" >
                    <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              <br>Date Checked: <input name="ChkDt" size=10 class="Small" maxlength=10 readonly>
                 <a href="javascript:showCalendar(1, null, null, 602, 180, document.all.ChkDt)" >
                    <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              
              <br>By Store Associate: <input name="RcvBy" id="RcvBy" size=10 class="Small" maxlength=10 
                            onblur="setEmpNm(this)">
              <select class="Small" name="SelEmp" id="SelEmp" onchange="setSelEmp(this)">
              <%for(int i=0; i < vEmp.size(); i++){%>
              <option value="<%=vEmp.get(i)%>"><%=vEmp.get(i)%> <%=vEmpNm.get(i)%></option>
              <%} %>
              </select>
           </td>
           <td class="Hdr">Comment: <textarea name="Commt" class="Small" rows="5" cols="55" maxlength="200"></textarea>
         </tr>
         <tr class="DataTable1">
           <td class="Hdr" colspan=3 style="background:#e7e7e7">
              <u><b>Note any Vendor Compliance Issues: &nbsp; &nbsp;&nbsp; (check all that apply)</b></u>
           </td>
         </tr>   
         <tr class="DataTable1">
           <td class="Hdr">
             <input type="checkbox" name="ComplErr">EDI/ASN Carton labels - but they will not Scan
             <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(upload pictures of a few cartons labels, that do not scan)
           <td class="Hdr">
                <input type="checkbox" name="ComplErr">No PO number listed on outside cartons           
            <br><input type="checkbox" name="ComplErr">No Packing List (P/L) on outside label or inside cartons.
            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(upload all Packing Lists, if received on this PO)
           </td>
           <td class="Hdr">             
            <input type="checkbox" name="ComplErr">Overages in QTYs received vs, Total QTY Ordered.
            <br><input type="checkbox" name="ComplErr">Shortages in QTY received (listed on P/L, but not recvd in shipment.)
            <br><input type="checkbox" name="ComplErr">Received a substitution (SUB), item is not on the PO.            
           </td>
         </tr>
         
         <tr class="DataTable1">
           <td class="Hdr">Vendor <%=sVenNum%>&nbsp;&nbsp;Buyer <%=sBuyer%></td>
           <td class="Hdr"><%=sTopCmt[0]%></td>
           <td class="Hdr"><%=sBotCmt[0]%></td>
         </tr>
         <tr class="DataTable1">
           <td class="Hdr"><%=sTopCmt[1]%></td>
           <td class="Hdr"><%=sBotCmt[1]%></td>
         </tr>
         <tr class="DataTable1">
           <td class="Hdr">Cnl <%=sCnclDt%>&nbsp;&nbsp;Antc <%=sAntcDt%></td>
           <td class="Hdr"><%=sTopCmt[2]%></td>
           <td class="Hdr"><%=sBotCmt[2]%></td>
         </tr>
         <tr class="DataTable1">
           <td class="Hdr">Orig.Antc <%=sOrgAntcDt%></td>
           <td class="Hdr"><%=sTopCmt[3]%></td>
         </tr>
      </table>
       dfsdfsdfsdf
    </td>
  </tr>

   <!-- ======================= Details =============================== -->
     <TR>
       <TD vAlign=top align=left colspan=3>
       <!-- ==================== Company name box - center =================== -->
       <table id="tblItem" class="DataTable" cellPadding="0" cellSpacing="0" width="100%" >
         <!-- ----------Detail box --------------------- -->
         <tr  class="DataTable">
           <th class="DataTable1">Class Name</th>
           <th class="DataTable1"><a href="POWorksheet.jsp?PO=<%=sPONum%>&Sort=VENSTY">Vendor Style</a></th>
           <th class="DataTable1"><a href="POWorksheet.jsp?PO=<%=sPONum%>&Sort=UPC">UPC</a></th>
           <th class="DataTable1"><a href="POWorksheet.jsp?PO=<%=sPONum%>&Sort=DESC">Description</a></th>
           <th class="DataTable1"><a href="POWorksheet.jsp?PO=<%=sPONum%>&Sort=COLOR">Color</a></th>
           <th class="DataTable1"><a href="POWorksheet.jsp?PO=<%=sPONum%>&Sort=SIZE">Size</a></th>
           <th class="DataTable1"><a href="POWorksheet.jsp?PO=<%=sPONum%>&Sort=SKU">Short Sku</a></th>
           <th class="DataTable1">Retail</th>
           <th class="DataTable1">Orig<br>Order<br>Qty</th>
           <th class="DataTable1">Current<br>On Hand</th>
           <th class="DataTable1"><a href="POWorksheet.jsp?PO=<%=sPONum%>&Sort=SEQ">Seq<br>No.</a></th>
           <th class="DataTable1">Received</th>
           <th class="DataTable1">Current<br>Open<br>Qty</th>
           <th class="DataTable1">Total<br>Rec'd<br>Qty</th>
           <th class="DataTable1" id="LastRct">Last Receipt<br>
              <%if(!sPOLastDt.trim().equals("")){%>
                <%=sPOLastDt%><br>
                <a href="POAllReceipt.jsp?PO=<%=sPONum%>" style="font-size:10px">All Receipt</a>
                </th>
              <%} else {%>&nbsp;<%}%>
         </tr>

         <tbody id="tbdItem">
         <%int iCurrentPage = 0;
           for(int i=0, j=0; i < iNumOfItm; i++, j++){
        		// negative current open - overrecived
        	 	String sClr1="";
        	    String sClr2="";
        	    if(sQty[i].indexOf("-") >= 0)
        	    { 
        	    	sClr1="background: #3399ff; color: white;";
        	    	sClr2="background: lightblue;font-size:11px;font-weight:bold;";
        	    }
        	    else if(!sQty[i].equals("0"))
        	    {
        	    	sClr2="background:#ccffcc;font-size:11px;font-weight:bold;";
        	    }        	    
           %>

       <!-- ======================= Header for page break =============================== -->
       <%// page break  - show next page header
         if (j > iNumOfItemsOnPage[iCurrentPage]) { iCurrentPage++; j=1; %>
          </table></TD></TR>
          <TR><TD vAlign=top align=left colspan=3><div style="page-break-before:always"></div>
          <table class="DataTable" cellPadding="0" cellSpacing="0" width="100%">
           <tr  class="DataTable1"><td colspan=15>
             <table class="DataTable" cellPadding="0" cellSpacing="0" width="100%" height="100%">
                <!-- ----------Line 1 left box --------------------- -->
                <tr  class="DataTable">
                  <th class="DataTable1">P.O.# <%=sPONum%></th>
                  <th class="DataTable1">Page <%=iCurrentPage+1%> of <%=sPages%></th>
                  <td class="DataTable1"><span style="font-size:12px; font-weight:bold">RETAIL CONCEPTS</span>, Inc</td>
                  <td class="DataTable1"><span style="font-size:12px; font-weight:bold">Receiving Worksheet</span></td>
                  <td class="DataTable1">Ship To:<span style="font-size:12px; font-weight:bold;"><%=sShipTo[0]%></span></td>
               </tr>
             </table>
           </td>
         </tr>
         <tr  class="DataTable">
           <th class="DataTable1">Class Name</th>
           <th class="DataTable1">Vendor Style</th>
           <th class="DataTable1">UPC</th>
           <!--th class="DataTable1">Description / Long Item Number / Color / Short Sku</th -->
           <th class="DataTable1">Description</th>
           <th class="DataTable1">Color</th>
           <th class="DataTable1">Size</th>
           <th class="DataTable1">Short Sku</th>
           <th class="DataTable1">Retail</th>
           <th class="DataTable1">Orig<br>Order<br>QTY</th>
           <th class="DataTable1">Current<br>On Hand</th>
           <th class="DataTable1">Seq<br>No.</th>
           <th class="DataTable1">Received</th>
           <th class="DataTable1">Current<br>Open<br>Qty</th>
           <th class="DataTable1">Total<br>Rec'd<br>Qty</th>
           <th class="DataTable1" id="LastRct">Last Receipt</td>
         </tr>
       <%}%>
       <!-- ======================= End Header for page break =============================== -->
           <tr  class="DataTable1">
             <td class="DataTable1"><%=sClsNm[i]%></td>
             <td class="DataTable1" id="tdVenSty<%=i%>"><%=sVenSty[i]%></td>
             <td class="DataTable" id="tdUpc<%=i%>"><%=sUpc[i]%></td>
             <td class="DataTable1" id="tdDesc<%=i%>"><%=sDesc[i]%></td>
             <td class="DataTable1" id="tdClrNm<%=i%>"><%=sClrName[i] + " - " + sClr[i]%></td>
             <td class="DataTable1" id="tdSizNm<%=i%>"><%=sSizName[i] + " - " + sSiz[i]%></td>
             <td class="DataTable7" id="tdSku<%=i%>" onclick="getSkuHist(&#34;<%=sSku[i]%>&#34;)" ><%=sSku[i]%></td>
             <td class="DataTable2">$<%=sRet[i]%></td>
             <td class="DataTable2" style="<%=sClr1%>" id="tdQty<%=i%>"><%=sOrgQty[i]%></td>
             <td class="DataTable2" style="<%if(sOnHand[i].indexOf("-") >= 0){%>background:pink;font-size:11px;font-weight:bold<%}%>"><%=sOnHand[i]%><% %></td>
             <td class="DataTable2" id="tdSeq<%=i%>"><%=sSeq[i]%></td>
             <td class="DataTable"><input name="ItmQty<%=i%>" size=9 class="Small" maxlength=9></td>
             <td class="DataTable2" id="tdQty<%=i%>" style="<%=sClr2%>" ><%=sQty[i]%></td>
             <td class="DataTable2" style="<%=sClr1%>" id="tdRcv<%=i%>"><%=sRcvQty[i]%></td>
             <td class="DataTable2" id="LastRct">&nbsp;<%=sLastQty[i]%></td>
           </tr>
         <%}%>

         <!-- ======================= total =============================== -->
           <tr><td style="font-size:1px; border:solid 1px black;" colspan=13>&nbsp;</td></tr>
           <tr  class="DataTable1">
             <td class="DataTable1" colspan=8>Total</td>
             <td class="DataTable2"><%=sPOQty%></td>

             <td class="DataTable2"><%=sTotRcvQty%></td>
             <td class="DataTable2" colspan=4>&nbsp;</td>
           </tr>


         </tbody>
       </table>
       <p style="text-align: center">
          <button class="btnSubmit" onclick="showRcvInfo()">Submit</button> &nbsp; &nbsp; &nbsp;
          <button class="btnSubmit" onclick="rcvAllItem()">Receive All Open</button> &nbsp; &nbsp; &nbsp;
          <button class="btnSubmit" onclick="addNewItem()">Add Items Not on PO</button> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          <button class="btnSubmit" onclick="setSubstitutions()">Previously Added Items</button>

       </TD>
    </TR>
       </table>
       </TD>
    </TR>
   </TABLE>
</script>

</BODY>
</HTML>

<%}%>

