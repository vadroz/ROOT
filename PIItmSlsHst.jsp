<%@ page import="inventoryreports.PIItmSlsHst, java.util.Date , java.text.SimpleDateFormat, rciutility.StoreSelect, inventoryreports.PiCalendar"%>
<%
    String sStore = request.getParameter("STORE");
    String sSelSku = request.getParameter("Sku");
    String sSlsOnTop = request.getParameter("SlsOnTop");
    String sFromDate = request.getParameter("FromDate");
    String sToDate = request.getParameter("ToDate");
    String sPiYearMo = request.getParameter("PICal");

    if (sSlsOnTop==null) sSlsOnTop = "1";
    if(sFromDate==null) sFromDate=" ";
    if(sToDate==null) sToDate=" ";
    if(sPiYearMo==null){ sPiYearMo = "LASTIN"; /* Last inventory */ }

    //System.out.println(sStore + "|" + sSelSku + "|" + sFromDate + "|" + sToDate + "|" + sPiYearMo);
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PIItmSlsHst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();

    PIItmSlsHst piitsls = new PIItmSlsHst(sSelSku, sStore, sFromDate, sToDate,
                     sPiYearMo.substring(0, 4),  sPiYearMo.substring(4));

    String sDiv = piitsls.getDiv();
    String sDpt = piitsls.getDpt();
    String sCls = piitsls.getCls();
    String sVen = piitsls.getVen();
    String sSty = piitsls.getSty();
    String sClr = piitsls.getClr();
    String sSiz = piitsls.getSiz();
    String sDesc = piitsls.getDesc();
    String sClrName = piitsls.getClrName();
    String sSizName = piitsls.getSizName();
    String sVenSty = piitsls.getVenSty();
    String sVenName = piitsls.getVenName();
    String sSku = piitsls.getSku();
    String sItmQty = piitsls.getItmQty();
    String sItmRet = piitsls.getItmRet();
    String sItmSls = piitsls.getItmSls();
    String sUpc = piitsls.getUpc();
    String sDstOut = piitsls.getDstOut();
    String sDstIn = piitsls.getDstIn();
    
    String sDivNm = piitsls.getDivNm();
    String sDptNm = piitsls.getDptNm();
    String sClsNm = piitsls.getClsNm();
    String sWName = piitsls.getWName();
    String sTotNetQty = piitsls.getTotNetQty();
    String sTotDistro = piitsls.getTotDistro();
    String sSugRet = piitsls.getSugRet();
    String sOrgRet = piitsls.getOrgRet();
    String sLMdRet = piitsls.getLMdRet();
    String sLMdDate = piitsls.getLMdDate();
    String sNetOnh = piitsls.getNetOnh();
    String sKiboPar= piitsls.getKiboPar();
    
    String sRcl = piitsls.getRcl();
    String sRclSku = piitsls.getRclSku();
    
    int iNumOfSls = piitsls.getNumOfSls();
    String [] sEmp = piitsls.getEmp();
    String [] sEmpName = piitsls.getEmpName();
    String [] sCsh = piitsls.getCsh();
    String [] sCshName = piitsls.getCshName();
    String [] sTrans = piitsls.getTrans();
    String [] sReg = piitsls.getReg();
    String [] sDate = piitsls.getDate();
    String [] sTime = piitsls.getTime();
    String [] sSlsQty = piitsls.getSlsQty();
    String [] sSlsRet = piitsls.getSlsRet();
    String [] sSlsPcn = piitsls.getSlsPcn();
    String [] sEmpPurch = piitsls.getEmpPurch();
    String [] sEmpPurchNm = piitsls.getEmpPurchNm();
    String [] sTranType = piitsls.getTranType();
    String [] sOrdNum = piitsls.getOrdNum();

    int iNumOfDst = piitsls.getNumOfDst();
    String [] sIssStr = piitsls.getIssStr();
    String [] sDstStr = piitsls.getDstStr();
    String [] sDstDoc = piitsls.getDstDoc();
    String [] sDstDate = piitsls.getDstDate();
    String [] sDstQty = piitsls.getDstQty();
    String [] sShpDate = piitsls.getShpDate();
    String [] sAckDate = piitsls.getAckDate();
    String [] sAckTime = piitsls.getAckTime();
    String [] sAckUser = piitsls.getAckUser();
    String [] sInOut = piitsls.getInOut();
    String [] sAckQty = piitsls.getAckQty();
    String [] sNetQty = piitsls.getNetQty();
    String [] sFrtb = piitsls.getFrtb();
    String [] sAllcNum = piitsls.getAllcNum();
    String [] sAllcDt = piitsls.getAllcDt();
    String [] sPickNum = piitsls.getPickNum();
    String [] sPickDt = piitsls.getPickDt();
    String [] sDstPO = piitsls.getDstPO();
    String [] sDstCtn = piitsls.getDstCtn();
    String [] sDstCtnDt = piitsls.getDstCtnDt();
    String [] sAckType = piitsls.getAckType();

    int iNumOfPo = piitsls.getNumOfPo();
    String [] sPoNum = piitsls.getPoNum();
    String [] sPoAntDate = piitsls.getPoAntDate();
    String [] sPoQty = piitsls.getPoQty();
    String [] sPoTQr = piitsls.getPoTQr();
    String [] sPoRQty = piitsls.getPoRQty();
    String [] sPoFuture = piitsls.getPoFuture();
    String [] sPoDstMtd = piitsls.getPoDstMtd();
    String [] sPoDmName = piitsls.getPoDmName();
    String [] sPoShpDt = piitsls.getPoShpDt();
    String [] sPoLstRctDt = piitsls.getPoLstRctDt();  
    String [] sPoStr = piitsls.getPoStr();
    String [] sPoRecpt = piitsls.getPoRecpt();

    int iNumOfAdj = piitsls.getNumOfAdj();
    String [] sTyBook = piitsls.getTyBook();
    String [] sTyCount = piitsls.getTyCount();
    String [] sTyAdj = piitsls.getTyAdj();
    String [] sLyBook = piitsls.getLyBook();
    String [] sLyCount = piitsls.getLyCount();
    String [] sLyAdj = piitsls.getLyAdj();

    int iNumOfPat = piitsls.getNumOfPat();
    String [] sPatTran = piitsls.getPatTran();
    String [] sPatDate = piitsls.getPatDate();
    String [] sPatQty = piitsls.getPatQty();
    String [] sPatRet = piitsls.getPatRet();
    
    int iNumOfMos = piitsls.getNumOfMos();  
    String [] sMosStr = piitsls.getMosStr();
    String [] sMosDate = piitsls.getMosDate();
    String [] sMosText = piitsls.getMosText();
    String [] sMosUser = piitsls.getMosUser();
    String [] sMosCtl = piitsls.getMosCtl();
    String [] sMosPostDt = piitsls.getMosPostDt();
    String [] sMosQty = piitsls.getMosQty();
    String [] sMosRet = piitsls.getMosRet();
    String [] sMosType = piitsls.getMosType();
    String [] sMosReas = piitsls.getMosReas();
    String [] sMosTran = piitsls.getMosTran();
    String [] sMosMkUser = piitsls.getMosMkUser();
    String [] sMosMkDate = piitsls.getMosMkDate();
    String [] sMosMkTime = piitsls.getMosMkTime();

    int iNumOfRtv = piitsls.getNumOfRtv();
    String [] sRtvStr = piitsls.getRtvStr();
    String [] sRtvDate = piitsls.getRtvDate();
    String [] sRtvRaNum = piitsls.getRtvRaNum();
    String [] sRtvPoNum = piitsls.getRtvPoNum();
    String [] sRtvUser = piitsls.getRtvUser();
    String [] sRtvQty = piitsls.getRtvQty();
    
    int iNumOfErr = piitsls.getNumOfErr();
    String sError = piitsls.getError();

    String sLastPiCountDate = piitsls.getLastPiCountDate();
    String sPiCountDesc = piitsls.getPiCountDesc();
    String sLastPiCountDesc = piitsls.getLastPiCountDesc();
    String sLastPiCal = piitsls.getLastPiCal();    

    piitsls.disconnect();

    StoreSelect StrSelect = null;
    String sStr = null;
    String sStrName = null;

    StrSelect = new StoreSelect(4);
    sStr = StrSelect.getStrNum();
    sStrName = StrSelect.getStrName();

    // get PI Calendar
    PiCalendar setcal = new PiCalendar();
    String sYear = setcal.getYear();
    String sMonth = setcal.getMonth();
    String sMonName = setcal.getDesc();
    setcal.disconnect();
    
    String sStrAllowed = session.getAttribute("STORE").toString();
	
%>
<title>SKU History</title>
<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px; text-decoration: underline;}
        th.DataTable2 { background:moccasin;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background: #E7E7E7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: LemonChiffon; font-family:Arial; font-size:10px }
        tr.DataTable2 { background: #b5eaaa; font-family:Arial; font-size:10px }
        tr.DataTable3 { font-family:Arial; font-size:10px }
        tr.DataTable4 { background: #b5eaaa; font-family:Arial; font-size:12px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable01 { background: #ccffcc; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}

        td.DataTable3 { cursor:hand; color:blue; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space: nowrap; text-decoration: underline;}
        
        td.DataTable4 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; font-size:12px; font-weight: bold }               

        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvSelect { position:absolute; background-attachment: scroll;
              border: black solid 2px; width:250px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}

        td.BoxName {cursor:move;  background: #016aab; 
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background: #016aab; vertical-align:bottom;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Prompt { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:midle; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:middle; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

</style> 

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>


<script name="javascript1.2">
//------------------------------------------------------------------------------
var PiYear = [<%=sYear%>];
var PiMonth = [<%=sMonth%>];
var PiDesc =  [<%=sMonName%>];

var ArrStr = [<%=sStr%>];
var ArrStrNm = [<%=sStrName%>];

var Store = "<%=sStore%>";
var Sku = "<%=sSelSku%>";
var From = "<%=sFromDate%>";
var To = "<%=sToDate%>";
var PiCal = "<%=sPiYearMo%>";

var SlsOnTop = false;
var Error = [<%=sError%>]
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   <%if(!sSlsOnTop.equals("1")){%>switchTables();<%}%>
   if(Error.length > 0)
   {
     var msg = "";
     for(var i=0;i < Error.length; i++){ msg += Error[1] + "\n"}
     alert(msg);
   }
   setSelectPanelShort();
}
//==============================================================================
// set Short form of select parameters
//==============================================================================
function setSelectPanelShort()
{
   var hdr = "Select Report Parameters";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='RestoreButton.bmp' onclick='javascript:setSelectPanel();' alt='Restore'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"
   html += "</td></tr></table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvSelect.style.width = "200";}
   else if(isSafari){ document.all.dvSelect.style.width = "200";}
   else { document.all.dvSelect.style.width = "auto";}
   
   document.all.dvSelect.innerHTML=html;
   document.all.dvSelect.style.left= getLeftScreenPos() + 10;
   document.all.dvSelect.style.top= getTopScreenPos() + 20;   
}
//==============================================================================
// set Weekly Selection Panel
//==============================================================================
function setSelectPanel()
{
  var hdr = "Select Report Parameters";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='MinimizeButton.bmp' onclick='javascript:setSelectPanelShort();' alt='Minimize'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popSelWk()

   html += "</td></tr></table>"
   document.all.dvSelect.innerHTML=html;

   setStrSel();
   setDateSel(From != "01/01/0001");
   document.all.Sku.value = Sku;
   document.all.From.value = From;
   document.all.To.value = To;
   setPICal()
   
}
//==============================================================================
// populate Column Panel
//==============================================================================
function popSelWk()
{
  var panel = "<table border=0 cellPadding=0 cellSpacing=0>"
    + "<tr>"
       + "<td class='Prompt' nowrap>Sku/UPC: &nbsp;</td>"
       + "<td class='Prompt3' colspan=2>"
         + "<input class='Small' id='Sku' maxlength=12 size=12>"
       + "</td>"
     + "</tr>"

     + "<tr>"
       + "<td class='Prompt'>Stores: &nbsp;</td>"
       + "<td class='Prompt3' colspan=2>"
         + "<select class='Small' id='selStr'></select>"
       + "</td>"
     + "</tr>"
     
    + "<TR id='trSelDt'>"
     	+ "<TD class=DTb1 align=center colspan=2>"
        	+ "<button class='Small'  onclick='setDateSel(true)'>Select Date</button>"
		+ "</TD>"          
	+ "</TR>"
	
    + "<tr id='trFrDt' style='background:azure'>"
       + "<td class='Prompt' id='td2Dates' width='30px'>From:</td>"
       + "<td class='Prompt' id='td2Dates'>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;From&#34;)'>&#60;</button>"
          + "<input name='From' class='Small' size='10' >"
          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;From&#34;)'>&#62;</button>"
       + "</td>"
       + "<td class='Prompt' id='td2Dates'><a href='javascript: showCalendar(1, null, null, 300, 10, document.all.From)'>"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
    + "</tr>"
    + "<tr id='trToDt' style='background:azure'>"
       + "<td class='Prompt' id='td2Dates' width='30px'>To:</td>"
       + "<td class='Prompt' id='td2Dates'>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;To&#34;)'>&#60;</button>"
          + "<input name='To' class='Small' size='10' >"
          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;To&#34;)'>&#62;</button>"
          + "<br><button class='Small'  onclick='setDateSel(false)'>All Date</button>"
       + "</td>"
       + "<td class='Prompt' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 300, 120, document.all.To)'>"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>"         
       + "</td>"  
     + "</tr>"

     + "<tr>"
       + "<td class='Prompt' nowrap>PI Calendar: &nbsp;</td>"
       + "<td class='Prompt3' colspan=2>"
         + "<select class='Small' id='selPiCal'></select>"
       + "</td>"
     + "</tr>"
     + "<tr>"
     	+ "<td class='Prompt' colspan=3>"
             + "Note:  If no dates are selected, all Sku History since the last FULL - PI Count will be displayed"
        + "</td>"
     + "</tr>"


  panel += "<tr><td class='Prompt1' colspan=3>"
        + "<button onClick='Validate()' class='Small'>Submit</button> &nbsp;"
        + "<button onClick='setSelectPanelShort();' class='Small'>Close</button>&nbsp;</td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
//check date type selection
//==============================================================================
function setDateSel(sel)
{
	if(sel)	
	{ 
		doSelDate();
		document.all.trSelDt.style.display = "none";
		document.all.trFrDt.style.display = "block";
		document.all.trToDt.style.display = "block";
	}
	else
	{
		document.all.trSelDt.style.display = "block";
		document.all.trFrDt.style.display = "none";
		document.all.trToDt.style.display = "none";
		document.all.From.value = "01/01/0001";
		document.all.To.value = "12/31/2099";
	}
}
//==============================================================================
//populate date with yesterdate
//==============================================================================
function doSelDate()
{
var df = document.all;
var date = new Date(new Date());
date.setHours(18)
df.To.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();

date = new Date(date - 86400000 * 30);
df.From.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function setStrSel()
{
   var sel = document.all.selStr;
   for(var i=1; i < ArrStr.length; i++)
   {
      sel.options[i-1] = new Option(ArrStr[i] + " - " + ArrStrNm[i], ArrStr[i]);
      if(Store == ArrStr[i]){ sel.selectedIndex = i-1; }
   }
}
//==============================================================================
// populate PI calendar
//==============================================================================
function setPICal()
{
   var sel = document.all.selPiCal;
   for(var i=0; i < PiYear.length; i++)
   {
      var pc = PiYear[i] + PiMonth[i];
      sel.options[i] = new Option(PiDesc[i], pc);
      if(PiCal == pc){ sel.selectedIndex = i; }
   }
}

//==============================================================================
// populate date with yesterdate
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
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = " ";

  var str = document.all.selStr.options[document.all.selStr.selectedIndex].value;
  var sku = document.all.Sku.value;
  if(sku.trim()=="")
  {
     msg = "Please, enter SKU or UPC code"
     error = true;
  }
  var from = document.all.From.value;
  var to = document.all.To.value;

  var pical = document.all.selPiCal.options[document.all.selPiCal.selectedIndex].value;

  if (error) alert(msg);
  else{ sbmReport(sku, str, from, to, pical); }
}

//==============================================================================
// switch tables
//==============================================================================
function sbmReport(sku, str, from, to, pical)
{
   var url = "PIItmSlsHst.jsp?Sku=" + sku
     + "&STORE=" + str
     + "&FromDate=" + from
     + "&ToDate=" + to
     + "&PICal=" + pical
     ;
   window.location.href = url;
}

//==============================================================================
// switch tables
//==============================================================================
function switchTables()
{
   var table1 = document.all.tbSales;
   var table2 = document.all.tbDestr;
   var table3 = document.all.tbPatio;

   if (SlsOnTop != true)
   {
     document.all.dvTop.removeChild(table1);
     if(table3 != null) { document.all.dvTop.removeChild(table3); }
     document.all.dvBottom.removeChild(table2);

     document.all.dvTop.appendChild(table2);
     document.all.dvBottom.appendChild(table1);
     if(table3 != null) { document.all.dvBottom.appendChild(table3); }
   }
   else
   {
     document.all.dvTop.removeChild(table2);
     document.all.dvBottom.removeChild(table1);
     if(table3 != null) {document.all.dvBottom.removeChild(table3); }

     document.all.dvTop.appendChild(table1);
     if(table3 != null) {document.all.dvTop.appendChild(table3);}
     document.all.dvBottom.appendChild(table2);
   }
   SlsOnTop = !SlsOnTop;

}

//==============================================================================
//show customer purchase list
//==============================================================================
function getCustInq(phn)
{
	var clrphn = phn.replace(/[^\d]/g, '');    
    url = "servlet/searchcust.SrchCustPurchase?PHONE=" + clrphn + "&SUBMIT=Submit";
    custInq = window.open(url);
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>


<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvSelect" class="dvSelect"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Historical Details
        <br>Store: <%=sStore%>
        </B><br>


       <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
       <a href="SalesBySkuSel.jsp"><font color="red" size="-1">PI Select</font></a>&#62;
       <font size="-1">This Page.</font>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0">

         <tr  class="DataTable1">
           <td class="DataTable2">Div:</td>
           <td class="DataTable1" nowrap><%=sDiv%> - <%=sDivNm%></td>           
           <th class="DataTable" rowspan="8">&nbsp;&nbsp;</th>       
           <td class="DataTable2">MFG Sugg:</td>
           <td class="DataTable1" nowrap><%=sSugRet%></td>
           <th class="DataTable" rowspan="8">&nbsp;&nbsp;</th>
           <td class="DataTable2" >Vendor Name:</td>
           <td class="DataTable1" nowrap><%=sVenName%></td>
         </tr>
         <tr  class="DataTable1">
           <td class="DataTable2">Dpt:</td>
           <td class="DataTable1" nowrap><%=sDpt%> - <%=sDptNm%></td>
           <td class="DataTable2">Original:</td>
           <td class="DataTable1" nowrap><%=sOrgRet%></td>
           <td class="DataTable2" >Color:</td>
           <td class="DataTable1" nowrap><%=sClrName%></td>
         </tr>
         
         <tr  class="DataTable1">
           <td class="DataTable2">Class:</td>
           <td class="DataTable1" nowrap><%=sCls%> - <%=sClsNm%></td>
           <td class="DataTable2" nowrap>Last Mkdwn:</td>
           <td class="DataTable1" nowrap><%if(!sLMdRet.equals(".00")){%><%=sLMdRet%><%}else {%>&nbsp;<%}%></td>
           <td class="DataTable2" >Size:</td>
           <td class="DataTable1" nowrap><%=sSizName%></td>           
         </tr>
         
         <tr  class="DataTable1">
           <td class="DataTable2">Long Item Number:</td>
           <td class="DataTable1" nowrap><%=sCls + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz%>
           <%if(!sKiboPar.equals("") && sStrAllowed.startsWith("ALL")){%>
               <a href="https://www.sunandski.com/p/<%=sKiboPar%>" target="_blank">(sunandski.com)</a>
               
           <%}%>    
           </td>
           <td class="DataTable2">as of:</td>
           <td class="DataTable1" nowrap><%if(!sLMdDate.equals("01/01/0001")){%><%=sLMdDate%><%}else {%>&nbsp;<%}%></td>
           <td class="DataTable2" >Current Retail:</td>
           <td class="DataTable4" nowrap>$<%=sItmRet%></td>
         </tr>
         <tr  class="DataTable4">
           <td class="DataTable2" >Description:<br><%if(!sWName.equals("")){%>Web Name:<%}%></td>
           <td class="DataTable1" nowrap><b><%=sDesc%><br><%=sWName%></b></td>
           <td class="DataTable2" >Computer on Hand:<br><span style='font-size:11px;'>(including In-Transit)</span></td>
           <td class="DataTable2" ><b><%=sItmQty%></b></td>
           <td class="DataTable2" >Qty On Hand:<br><span style='font-size:11px;'>(excluding In-Transit)</span></td>
           <td class="DataTable1" nowrap><b><%=sNetOnh%></b></td>           
         </tr>
         <tr  class="DataTable1">
           <td class="DataTable2">Short Sku:</td>
           <td class="DataTable1" nowrap>
             <a href="servlet/onhand01.OnHands03?STORE=<%=sStore%>&CLASS=<%=sCls%>&VENDOR=<%=sVen%>&STYLE=<%=sSty%>&User=<%=sUser%>&OutSlt=HTML&KioskStr=NONE&KioskSrc=NONE" target="_blank" style="font-size:12px"><%=sSku%></a>
           </td>           
           
           <td class="DataTable2" style="background: moccasin" rowspan=4 colspan=2>&nbsp;</td>
           
           <td class="DataTable2" >Total $ Sold:</td>
           <td class="DataTable1" nowrap>$<%=sItmSls%></td>
         </tr>
         <tr  class="DataTable1">
           <td class="DataTable2">UPC:</td>
           <td class="DataTable1"><%=sUpc%></td>
           <td class="DataTable2">Net Unit Sold:</td>
           <td class="DataTable1" nowrap><%=sTotNetQty%></td>
         </tr>
         <tr  class="DataTable1">
           <td class="DataTable2" >Vendor Style:</td>
           <td class="DataTable1" nowrap><%=sVenSty%></td>
           <td class="DataTable2" >Distro Summary:</td>
           <td class="DataTable1" nowrap><%=sTotDistro%> &nbsp; &nbsp; (Out: <%=sDstOut%> In: <%=sDstIn%>)</td>
         </tr>
       </table>
       <br>
       <%if(!sRcl.equals("0")){%>
         <table border=1 cellPadding="0" cellSpacing="0">
            <tr  class="DataTable1">
              <td class="DataTable2">
                 <%if(sRcl.equals("1")){%>Inventory is now in SKU:<%}
                 else{%>Inventory was in SKU:<%}%>                 
              </td>
              <td class="DataTable1" nowrap>
                 <a href="PIItmSlsHst.jsp?Sku=<%=sRclSku%>&STORE=<%=sStore%>&FromDate=<%=sFromDate%>&ToDate=<%=sToDate%>&PICal=<%=sPiYearMo%>"><%=sRclSku%></a>
              </td>           
            </tr>           
         </table>
         <br>
       <%}%>

<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbAdj">
         <tr  class="DataTable">
           <th class="DataTable" colspan="3">This Year's PI Results<br>PI Adjustment Details
             <br>&nbsp;<span style="border:1px solid black; background:#ccffcc; font-size:12px;margin:3px">&nbsp;<b><%=sPiCountDesc%></b>&nbsp;</span>
           </th>
           <th class="DataTable2" rowspan=2> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;</th>
           <th class="DataTable" colspan="3">Last Full Count - PI Results<br>PIAdjustment Details
             <br>&nbsp;<span style="border:1px solid black; background:#ccffcc; font-size:12px;margin:3px">&nbsp;<b><%=sLastPiCountDesc%></b>&nbsp;</span>
           </th>
         </tr>
         <tr  class="DataTable">
           <th class="DataTable">Physical Count</th>
           <th class="DataTable">Computer On Hand</th>
           <th class="DataTable">Total Adjustment</th>

           <th class="DataTable">Physical Count</th>
           <th class="DataTable">Computer On Hand</th>
           <th class="DataTable">Total Adjustment</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfAdj; i++ ){%>
          <tr class="DataTable">
            <td class="DataTable" nowrap>
               <a href="UpcInvSearch.jsp?UPC=&SKU=<%=sSelSku%>&Search=Search&STORE=<%=sStore%>&PICal=<%=sPiYearMo%>" target="_blank"><%=sTyCount[i]%></a>
            </td>
            <td class="DataTable" nowrap><%=sTyBook[i]%></td>
            <td class="DataTable" nowrap><%=sTyAdj[i]%></td>
            <th class="DataTable2">&nbsp;</th>
            
            <td class="DataTable" nowrap>
               <a href="UpcInvSearch.jsp?UPC=&SKU=<%=sSelSku%>&Search=Search&STORE=<%=sStore%>&PICal=<%=sLastPiCal%>" target="_blank"><%=sLyCount[i]%></a>
            </td>
            <td class="DataTable" nowrap><%=sLyBook[i]%></td>
            <td class="DataTable" nowrap><%=sLyAdj[i]%></td>
          </tr>
       <%}%>
       <tr  class="DataTable">
           <th class="DataTable2" colspan="3">&nbsp;</th>
           <th class="DataTable2" rowspan=2>&nbsp;</th>
           <th class="DataTable2" colspan="3">
              <span style="font-size:12px;">Prior full PI count date:&nbsp;<b><%=sLastPiCountDate%></b></span>
           </th>
         </tr>
       </table>
<!-- ======================================================================= -->
       <br><br>


     <div id="dvTop" style="font-size:10px;">
       <a href="javascript: switchTables()">Switch tables</a>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSales">
         <tr  class="DataTable">
           <th class="DataTable" colspan="12">Item Sales History
               <br><span style="font-size:10px;">Warning! This table does not show more than 1000 transactions.</span></th>
         </tr>
         <tr  class="DataTable">
           <th class="DataTable">Sales<br>Person</th>
           <th class="DataTable">Cashier</th>
           <th class="DataTable">Trans.<br>Type</th>
           <th class="DataTable">Trans.</th>
           <th class="DataTable">Layaway/<br>Order</th>
           <th class="DataTable">Reg.</th>
           <th class="DataTable">Date</th>
           <th class="DataTable">Time</th>
           <th class="DataTable">Qty</th>
           <th class="DataTable">Sold For</th>
           <th class="DataTable">Customer<br>Phone #</th>
           <th class="DataTable">Employee<br>Purch</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfSls; i++ ){%>
          <tr class="DataTable">
            <td class="DataTable1" nowrap><%=sEmp[i] + " " + sEmpName[i]%></td>
            <td class="DataTable1" nowrap><%=sCsh[i] + " " + sCshName[i]%></td>
            <td class="DataTable" nowrap><%=sTranType[i]%></td>
            <td class="DataTable" nowrap><%=sTrans[i]%></td>
            <td class="DataTable" nowrap><%=sOrdNum[i]%></td>
            <td class="DataTable" nowrap><%=sReg[i]%></td>
            <td class="DataTable" nowrap><%=sDate[i]%></td>
            <td class="DataTable" nowrap><%=sTime[i]%></td>
            <td class="DataTable2" nowrap><%=sSlsQty[i]%></td>
            <td class="DataTable2" nowrap><%=sSlsRet[i]%></td>
            <td class="DataTable2" nowrap>&nbsp;<a href="javascript: getCustInq('<%=sSlsPcn[i]%>')"><%=sSlsPcn[i]%></a></td>
            <td class="DataTable2" nowrap>&nbsp;<%if(!sEmpPurch[i].equals("")){%><%=sEmpPurch[i]%> - <%=sEmpPurchNm[i]%><%}%></td>
          </tr>
       <%}%>
       </table>

<!-- ======================================================================= -->
       <%if(sDiv.equals("50")){%>
       <br>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbPatio">
         <tr  class="DataTable">
           <th class="DataTable" colspan="9">Patio Sales History
         </tr>
         <tr  class="DataTable">
           <th class="DataTable">PSO#</th>
           <th class="DataTable">Date</th>
           <th class="DataTable">Qty</th>
           <th class="DataTable">Sold For</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfPat; i++ ){%>
          <tr class="DataTable">
            <td class="DataTable1" nowrap><%=sPatTran[i]%></td>
            <td class="DataTable1" nowrap><%=sPatDate[i]%></td>
            <td class="DataTable1" nowrap><%=sPatQty[i]%></td>
            <td class="DataTable1" nowrap><%=sPatRet[i]%></td>
          </tr>
       <%}%>
       </table>
       <%}%>
<!-- ======================================================================= -->
     </div>
<br>

     <div id="dvBottom">
      <%String sDstInOut = null;%>
      <table border=1 cellPadding="0" cellSpacing="0" id="tbDestr">
      <%for(int k=0; k < 2; k++ ){
          if(k==0){sDstInOut = "I";}
          else {sDstInOut = "O";}
      %>
<!-- ======================================================================= -->
         <tr class="DataTable">
           <th class="DataTable" colspan="17">Distribution (<%if(k==0){%>IN<%} else {%>OUT<%}%>)</th>
         </tr>
         <tr  class="DataTable">
           <th class="DataTable" rowspan=2>Issuing<br>Store</th>
           <th class="DataTable" rowspan=2>Destination<br>Store</th>
           <th class="DataTable" colspan=3>Allocation</th>
           <th class="DataTable" colspan=2>Pick</th>
           <th class="DataTable" colspan=2>Carton</th>
           <th class="DataTable" rowspan=2>Distribution<br>Document</th>
           <!--  th class="DataTable" rowspan=2>Distribution<br>Date</th -->
           <th class="DataTable" rowspan=2>Shipment<br>Date</th>
           <th class="DataTable" rowspan=2>Qty</th>
           <th class="DataTable" colspan=4>Acknowledgment</th>
           <th class="DataTable" rowspan=2>*Diff</th>
         </tr>
         <tr  class="DataTable">
           <th class="DataTable">Number</th>
           <th class="DataTable">Date</th>
           <th class="DataTable">PO</th>
           <th class="DataTable">Number</th>
           <th class="DataTable">Date</th>
           <th class="DataTable">Number</th>
           <th class="DataTable">Date</th>
           
           <th class="DataTable">Date</th>
           <th class="DataTable">Time</th>
           <th class="DataTable">User</th>
           <th class="DataTable">Qty</th>
         </tr>

       <!-- ============================ Details =========================== -->

       <%for(int i=0; i < iNumOfDst; i++ ){%>
         <%if(sInOut[i].equals(sDstInOut)){%>
           <tr class="DataTable">	
             <td class="DataTable" nowrap><%=sIssStr[i]%></td>
             <td class="DataTable" nowrap><%=sDstStr[i]%></td>
             <td class="DataTable" nowrap><%=sAllcNum[i]%></td>
             <td class="DataTable" nowrap><%if(!sAllcDt[i].equals("01/01/0001")){%><%=sAllcDt[i]%><%}%></td>
             <td class="DataTable" nowrap><%=sDstPO[i]%></td>
             <td class="DataTable" nowrap><%=sPickNum[i]%></td>
             <td class="DataTable" nowrap><%if(!sPickDt[i].equals("01/01/0001")){%><%=sPickDt[i]%><%}%></td>
             <td class="DataTable" nowrap><a href="CtnInq.jsp?Carton=<%=sDstCtn[i]%>" target="_blank"><%=sDstCtn[i]%></a></td>            
             <td class="DataTable" nowrap><%=sDstCtnDt[i]%></td>
             <td class="DataTable" nowrap>
             <%if(!sFrtb[i].equals("")){%>
                 <a href="servlet/dcfrtbill.DcFrtBill?STORE=ALL&FrtBill=<%=sFrtb[i]%>&FromDate=01/01/0001&ToDate=01/01/0001&repType=B&filter=A" target="_blank"><%=sDstDoc[i]%></a>
             <%} else {%>
                <%if(k==0){%>
              		<a href="DstStsInq.jsp?RecSrc=B&IStore=ALLIW&IStrName=All+Inter-stores&DStore=<%=sStore%>&DStrName=<%=sStore%>&PageType=I&Distro=<%=sDstDoc[i]%>&Ponum=&Alloc=&Receipt=&Status=+&SUBMIT=Submit&SvRecSrc=B&FromDate=<%=sLastPiCountDate%>&ToDate=12/31/2999" target="_blank"><%=sDstDoc[i]%></a>             		
             	<%} else{%>
             	    <a href="DstStsInq.jsp?RecSrc=B&IStore=<%=sStore%>&IStrName=<%=sStore%>&DStore=ALL&DStrName=<%=sStore%>&PageType=I&Distro=<%=sDstDoc[i]%>&Ponum=&Alloc=&Receipt=&Status=+&SUBMIT=Submit&SvRecSrc=B&FromDate=<%=sLastPiCountDate%>&ToDate=12/31/2999" target="_blank"><%=sDstDoc[i]%></a>             		
             	<%}%>
             <%}%>  
             </td>
             <!--  td class="DataTable" nowrap><%=sDstDate[i]%></td -->
             <td class="DataTable" nowrap><%if(!sShpDate[i].equals("01/01/0001")){%><%=sShpDate[i]%><%}%></td>
             <td class="DataTable2" nowrap><%if(sStore.equals("1") || !sDstQty[i].equals("0")){%><%=sDstQty[i]%><%} else{%>&nbsp;<%}%></td>

             <td class="DataTable" <%if(sAckType[i].equals("M") || sAckType[i].equals("D")){%>style="background: pink;"<%}%> nowrap><%if(!sAckDate[i].equals("01/01/0001")){%><%=sAckDate[i]%><%} else{%>&nbsp;<%}%></td>
             <td class="DataTable" <%if(sAckType[i].equals("M") || sAckType[i].equals("D")){%>style="background: pink;"<%}%> nowrap><%if(!sAckDate[i].equals("01/01/0001")){%><%=sAckTime[i]%><%} else{%>&nbsp;<%}%></td>
             <td class="DataTable1" <%if(sAckType[i].equals("M") || sAckType[i].equals("D")){%>style="background: pink;"<%}%> nowrap><%if(!sAckDate[i].equals("01/01/0001")){%><%=sAckUser[i]%><%} else{%>&nbsp;<%}%></td>
             <td class="DataTable2" <%if(sAckType[i].equals("M") || sAckType[i].equals("D")){%>style="background: pink;"<%}%> nowrap><%if(!sAckDate[i].equals("01/01/0001")){%><%=sAckQty[i]%><%} else{%>&nbsp;<%}%></td>
             <td class="DataTable2" <%if(sAckType[i].equals("M") || sAckType[i].equals("D")){%>style="background: pink;"<%}%> nowrap><%if(!sAckDate[i].equals("01/01/0001")){%><%=sNetQty[i]%><%} else{%>&nbsp;<%}%></td>
           </tr>
         <%}%>
       <%}%>
       <tr>
         <td colspan="11" style="border-bottom:none;">
            <span style="font-size:11px;">*Diff = If the quantity listed in this column is NEGATIVE, the quantity was charged BACK to the Issuing Store.</span><br>&nbsp;
         </td>
      </tr>
      <%}%>
     </table>

<!-- ======================================================================= -->
     </div>
     <br>&nbsp;

<!-- ========================== PO List ==================================== -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbPoLst">
         <tr  class="DataTable">
           <th class="DataTable" colspan="10">PO List</th>
         </tr>
         <tr  class="DataTable">
           <th class="DataTable">PO Number</th>
           <th class="DataTable">Str</th>
           <th class="DataTable">Distro Method</th>
           <th class="DataTable">Ship<br>Date</th>
           <th class="DataTable">Anticipate<br>Delivery Date</th>           
           <th class="DataTable">Last<br>Receipt<br>Date</th>
           <th class="DataTable">Last<br>Receipt<br>Number</th>
           <th class="DataTable">Ordered<br>Qty</th>
           <th class="DataTable">Received<br>Qty</th>
           <th class="DataTable">Remained<br>Qty</th>
         </tr>


       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfPo; i++ ){%>
          <tr class="DataTable">
            <td class="DataTable" nowrap><%=sPoNum[i]%></td>
            <td class="DataTable" nowrap><%=sPoStr[i]%></td>
            <td class="DataTable" nowrap>            
                <%if(sPoStr[i].equals("1") || sPoStr[i].equals("55") || sPoStr[i].equals("86") 
                	 || sPoStr[i].equals("46")){%>
              	   <%=sPoDstMtd[i]%> - <%=sPoDmName[i]%>
                <%} else{%>&nbsp;<%}%>
            </td>
            <td class="DataTable" nowrap><%=sPoShpDt[i]%></td>
            <td class="DataTable<%if(sPoFuture[i].equals("1")){%>01<%}%>" nowrap><%=sPoAntDate[i]%></td>            
            <td class="DataTable" nowrap><%if(!sPoLstRctDt[i].equals("01/01/0001")){%><%=sPoLstRctDt[i]%><%} else{%>&nbsp;<%}%></td>
            <td class="DataTable2" nowrap><%=sPoRecpt[i]%></td>
            <td class="DataTable2" nowrap><%=sPoQty[i]%></td>
            <td class="DataTable2" nowrap><%=sPoTQr[i]%></td>
            <td class="DataTable2" nowrap><%=sPoRQty[i]%></td>
          </tr>
       <%}%>
       </table>
       
         <br>&nbsp;

<!-- ========================== MOS List ==================================== -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbPoLst">
         <tr  class="DataTable">
           <th class="DataTable" colspan="13">MOS - Inventory Adjustments - Sku Exchanges</th>
         </tr>
         <tr  class="DataTable">
           <th class="DataTable">Str</th>
           <th class="DataTable">Date</th>
           <th class="DataTable">Description</th>
           <th class="DataTable">Reason</th>
           <th class="DataTable">Processed<br>By</th>
           <th class="DataTable">IP Ctl#</th>
           <th class="DataTable">Control# </th>
           <th class="DataTable">Entered By</th>
           <th class="DataTable">Entered<br>Date/Time</th>
           <th class="DataTable">Type</th>
           <!--  th class="DataTable">Entry Date</th -->
           <th class="DataTable">Ret</th>
           <th class="DataTable">Qty</th> 
           
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfMos; i++ ){%>
          <tr class="DataTable">
            <td class="DataTable" nowrap><%=sMosStr[i]%></td>
            <td class="DataTable" nowrap><%=sMosDate[i]%></td>
            <td class="DataTable1" nowrap><%if(!sMosMkUser[i].equals("")){%>MOS Intranet<%} else {%><%=sMosText[i]%><%}%></td>
            <td class="DataTable" nowrap><%=sMosReas[i]%></td>
            <td class="DataTable" nowrap><%=sMosUser[i]%></td>
            <td class="DataTable" nowrap><%=sMosCtl[i]%></td> 
            <td class="DataTable" nowrap><%=sMosTran[i]%></td>
            <td class="DataTable" nowrap><%=sMosMkUser[i]%></td>
            <td class="DataTable" nowrap><%=sMosMkDate[i]%> <%=sMosMkTime[i]%></td>            
            <td class="DataTable" nowrap><%=sMosType[i]%></td>
            <!-- td class="DataTable" nowrap><%=sMosPostDt[i]%></td -->            
            <td class="DataTable" nowrap><%=sMosRet[i]%></td>
            <td class="DataTable" nowrap><%=sMosQty[i]%></td>                        
          </tr>
       <%}%>
       </table>
       <br>
       <!-- ========================== Rtv List ==================================== -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbPoLst">
         <tr  class="DataTable">
           <th class="DataTable" colspan="9">Return to Vendor (RTV)</th>
         </tr>
         <tr  class="DataTable">
           <th class="DataTable">Str</th>
           <th class="DataTable">Entry Date</th>
           <th class="DataTable">RA#</th>
           <th class="DataTable">PO#</th>
           <th class="DataTable">User</th>
           <th class="DataTable">Qty</th>
           
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfRtv; i++ ){%>
          <tr class="DataTable">
            <td class="DataTable" nowrap><%=sRtvStr[i]%></td>
            <td class="DataTable" nowrap><%=sRtvDate[i]%></td>
            <td class="DataTable" nowrap><%=sRtvRaNum[i]%></td>
            <td class="DataTable" nowrap><%=sRtvPoNum[i]%></td>
            <td class="DataTable" nowrap><%=sRtvUser[i]%></td>
            <td class="DataTable" nowrap><%=sRtvQty[i]%></td>            
          </tr>
       <%}%>
       </table>
       
       
<p style="font-size:12px">
<b><u>Note:</u></b>  Regardless of date criteria initially entered; No Sales, Distribution or 
PO History activity dated <u>PRIOR</u> to the <b>Last Full PI Count Date</b> will be displayed.

      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
piitsls.disconnect();
piitsls = null;
}
%>
