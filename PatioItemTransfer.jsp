<%@ page import="patiosales.PatioItemTransfer, java.util.*"%>
<%
    System.out.println("0");
    String sFrOrdDt = request.getParameter("FrOrd");
    String sToOrdDt = request.getParameter("ToOrd");
    String sFrDelDt = request.getParameter("FrDel");
    String sToDelDt = request.getParameter("ToDel");
    String [] sStore = request.getParameterValues("Str");
    String [] sTrfStr = request.getParameterValues("Trf");
    String [] sSts = request.getParameterValues("Sts");
    String sSort = request.getParameter("Sort");

    if(sSort==null){ sSort = "DELDA"; }
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=PatioItemTransfer.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    PatioItemTransfer pfitmtrf = new PatioItemTransfer(sFrOrdDt, sToOrdDt, sFrDelDt, sToDelDt
      , sStore, sTrfStr, sSts, sSort, session.getAttribute("USER").toString());
%>
<HTML>
<HEAD>
<title>Patio Sales</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { padding-top:3px; padding-bottom:3px; text-align:center; font-size:11px;}
        th.DataTable3 { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:10px }
        th.DataTable4 { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:middle ;font-size:10px }

        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable0 { background: red; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-size:10px }
        tr.DataTable2 { background: CornSilk; font-size:11px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable21 { background: #b0b0b0; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvSelect { position:absolute; background-attachment: scroll;
              border: black solid 1px; width:175; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

</style>

<script name="javascript1.3">
//------------------------------------------------------------------------------
var SlsStr = [<%=pfitmtrf.cvtToJavaScriptArray(sStore)%>]
var TrfStr = [<%=pfitmtrf.cvtToJavaScriptArray(sTrfStr)%>]
var OrdSts = [<%=pfitmtrf.cvtToJavaScriptArray(sSts)%>]

var ArrStr = ["35", "46", "50", "86", "55", "63", "64", "68"]
var FrOrdDt = "<%=sFrOrdDt%>";
var ToOrdDt = "<%=sToOrdDt%>";
var FrDelDt = "<%=sFrDelDt%>";
var ToDelDt = "<%=sToDelDt%>";

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
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
   document.all.dvSelect.innerHTML=html;
   document.all.dvSelect.style.pixelLeft= 10;
   document.all.dvSelect.style.pixelTop= 10;
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

   var str = document.all.Str;
   setSelStr(document.all.Str, SlsStr);
   setSelStr(document.all.Trf, TrfStr);

   for(var i=0; i < document.all.Status.length; i++)
   {
      for(var j=0; j < OrdSts.length; j++)
      {
         if(document.all.Status[i].value == OrdSts[j]){ document.all.Status[i].checked = true; }
      }
   }

   if(FrOrdDt == "01/01/0001") { showAllDates("ORD") }
   else { showDates("ORD") }
   if(FrDelDt == "01/01/0001") { showAllDates("DEL") }
   else { showDates("DEL") }
}
//==============================================================================
// populate Column Panel
//==============================================================================
function setSelStr(str, selstr)
{
   for(var i=0; i < str.length; i++)
   {
      for(var j=0; j < ArrStr.length; j++)
      {
         if(str[i].value == selstr[j]){ str[i].checked = true;}
         else{ str[i].checked == false; }
      }
   }
}
//==============================================================================
// populate Column Panel
//==============================================================================
function popSelWk()
{
  var panel = "<table border=0 cellPadding=0 cellSpacing=0>"

  // transfer store selection
  panel += "<tr class='DataTable2'>"
       + "<td class='DataTable' valign='bottom' nowrap><b>Inventory From Stores:</b>"
       + "<td class='DataTable'>"
  for(var i=0, j=0; i < ArrStr.length; i++, j++)
  {
     panel += "<input type='checkbox' class='Small' name='Trf' value='" + ArrStr[i] + "'>" + ArrStr[i]
     + "&nbsp;"
  }
  panel += "</td></tr>"

  // sales store selection
  panel += "<tr class='DataTable2'>"
       + "<td class='DataTable' valign='bottom' nowrap><b>Select Selling Stores:</b>"
       + "<td class='DataTable'>"
  for(var i=0, j=0; i < ArrStr.length; i++, j++)
  {
     if(ArrStr[i] != "55")
     {
         panel += "<input type='checkbox' class='Small' name='Str' value='" + ArrStr[i] + "'>" + ArrStr[i]
                + "&nbsp;"
     }
  }
  panel += "</td></tr>"

  // Status selection
  panel += "<TR class='DataTable2'>"
         + "<TD class='DataTable' colspan=2><b><u>Select Order Status</u></b><br>"
         + "<INPUT type='checkbox' name='Status'  value='W' checked>Waiting for Xfer"
         + " &nbsp; "
         + "<INPUT type='checkbox' name='Status' value='U' >Transferred<br> &nbsp; "

 // Order Date selection
 panel += "<TR class='DataTable2'>"
         + "<TD class='DataTable' id='tdDate1' colspan=6 align=center style='padding-top: 10px;' >"
         + "<button id='btnSelOrdDates' onclick='showDates(&#34;ORD&#34;)'>Optional Order Date Selection</button>"
         + "</td>"

        + "<TD class='DataTable' id='tdDate2' colspan=6 align=center style='border-top: darkred solid 1px; padding-top: 10px;'  nowrap>"
        + "<b>Order Date From:</b>"
        + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;FrOrdDate&#34;)'>&#60;</button>"
        + "<input class='Small' name='FrOrdDate' type='text' value='01/01/0001' size=10 maxlength=10>&nbsp;"
        + "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, &#34;FrOrdDate&#34;)'>&#62;</button>"
        + "&nbsp;&nbsp;&nbsp;"
        + "<a href='javascript:showCalendar(1, null, null, 300, 250, document.forms[0].FrOrdDate)' >"
        + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>"

        + "&nbsp;"
        + "<b>Order Date To:</b>"
        + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;ToOrdDate&#34;)'>&#60;</button>"
        + "<input class='Small' name='ToOrdDate' type='text' value='12/31/2999' size=10 maxlength=10>&nbsp;"
        + "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, &#34;ToOrdDate&#34;)'>&#62;</button>"
        + "&nbsp;&nbsp;&nbsp;"
        + "<a href='javascript:showCalendar(1, null, null, 300, 250, document.forms[0].ToOrdDate)' >"
        + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a><br>"
        + "<button id='btnSelOrdDates' onclick='showAllDates(&#34;ORD&#34;)'>All Date</button>"
        + "</TD>"
        + "</TR>"

        + "<TR class='DataTable2'>"
        + "<TD class='DataTable' id='tdDate3' colspan=6 align=center style='padding-top: 10px;' >"
        + "<button id='btnSelDelDates' onclick='showDates(&#34;DEL&#34;)'>Optional Delivery Date Selection</button>"
        + "</td>"
        + "<TD class='DataTable' id='tdDate4' colspan=6 align=center style='border-top: darkred solid 1px; padding-top: 10px;' nowrap>"
        + "<b>Delivery Date From:</b>"
        + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;FrDelDate&#34;)'>&#60;</button>"
        + "<input class='Small' name='FrDelDate' type='text' value='01/01/0001' size=10 maxlength=10>&nbsp;"
        + "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, &#34;FrDelDate&#34;)'>&#62;</button>"
        + "&nbsp;&nbsp;&nbsp;"
        + "<a href='javascript:showCalendar(1, null, null, 300, 250, document.forms[0].FrDelDate)' >"
        + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>"

        + "&nbsp"
        + "<b>Delivery Date To:</b>"
        + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;ToDelDate&#34;)'>&#60;</button>"
        + "<input class='Small' name='ToDelDate' type='text' value='12/31/2999' size=10 maxlength=10>&nbsp;"
        + "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, &#34;ToDelDate&#34;)'>&#62;</button>"
        + "&nbsp;&nbsp;&nbsp;"
        + "<a href='javascript:showCalendar(1, null, null, 300, 250, document.forms[0].ToDelDate)' >"
        + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a><br>"
        + "<button id='btnSelDelDates' onclick='showAllDates(&#34;DEL&#34;)'>All Date</button>"
        + "</TD>"
        + "</TR>"

  panel += "<tr><td class='Prompt1' colspan=3>"
        + "<button onClick='Validate()' class='Small'>Submit</button> &nbsp;"
        + "<button onClick='setSelectPanelShort();' class='Small'>Close</button>&nbsp;</td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates(datety)
{
   if(datety == 'ORD')
   {
      document.all.tdDate1.style.display="block"
      document.all.tdDate2.style.display="none"
      document.all.FrOrdDate.value = "01/01/0001"
      document.all.ToOrdDate.value = "12/31/2999"
   }
   else
   {
      document.all.tdDate3.style.display="block"
      document.all.tdDate4.style.display="none"
      document.all.FrDelDate.value = "01/01/0001"
      document.all.ToDelDate.value = "12/31/2999"
   }
}
//==============================================================================
// show date selection
//==============================================================================
function showDates(datety)
{

   if(datety == "ORD")
   {
      document.all.tdDate1.style.display="none"
      document.all.tdDate2.style.display="block"
   }
   else
   {
      document.all.tdDate3.style.display="none"
      document.all.tdDate4.style.display="block"
   }

   doSelDate(datety)
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(datety)
{
  if(datety == "ORD")
  {
    var date = new Date();
    if(FrOrdDt != "01/01/0001"){ date = new Date(FrOrdDt); }
    document.all.FrOrdDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
    var date = new Date();
    if(FrOrdDt != "01/01/0001"){ date = new Date(ToOrdDt); }
    document.all.ToOrdDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
  }
  else
  {
     var date = new Date();
     if(FrDelDt != "01/01/0001"){ date = new Date(FrDelDt); }
     document.all.FrDelDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
     var date = new Date();
     if(FrDelDt != "01/01/0001"){ date = new Date(ToDelDt); }
     document.all.ToDelDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
  }
}
//==============================================================================
// validate entries
//==============================================================================
function  Validate()
{
  var error = false;
  var msg = "";

  var stores = document.all.Str;
  var str = new Array();
  var action;

  // at least 1 store must be selected
  var strsel = false;
  for(var i=0, j=0; i < stores.length; i++ )
  {
     if(stores[i].checked)
     {
        strsel=true;
        str[j] = stores[i].value;
        j++;
     }
  }
  if(!strsel)
  {
    msg += "\n Please, check at least 1 store";
    error = true;
  }

  // at least 1 transfer store must be selected
  var trfstr = document.all.Trf;
  var trf = new Array();
  var trfsel = false;
  for(var i=0, j=0; i < trfstr.length; i++ )
  {
     if(trfstr[i].checked)
     {
        trfsel=true;
        trf[j] = trfstr[i].value;
        j++;
     }
  }

  if(!trfsel)
  {
    msg += "\n Please, check at least 1 transfer store";
    error = true;
  }

  // status options
  var stsopt = document.all.Status;
  var sts = new Array();
  var stssel = false;
  for(var i=0, j=0; i < stsopt.length; i++ )
  {
     if(stsopt[i].checked)
     {
        stssel=true;
        sts[j] = stsopt[i].value;
        j++;
     }
  }
  if(!stssel) { msg += "\n Please, check at least 1 order status"; error = true; }

  var frorddt = document.all.FrOrdDate.value.trim();
  var toorddt = document.all.ToOrdDate.value.trim();
  var frdeldt = document.all.FrDelDate.value.trim();
  var todeldt = document.all.ToDelDate.value.trim();

  if (error) alert(msg);
  else{ sbmReport(frorddt, toorddt, frdeldt, todeldt, str, trf, sts) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmReport(frorddt, toorddt, frdeldt, todeldt, str, trf, sts)
{
  var url = "PatioItemTransfer.jsp?FrOrd=" + frorddt
    + "&ToOrd=" + toorddt
    + "&FrDel=" + frdeldt
    + "&ToDel=" + todeldt

  // selected store
  for(var i=0; i < str.length; i++) { url += "&Str=" + str[i]; }
  // selected transfer store
  for(var i=0; i < trf.length; i++) { url += "&Trf=" + trf[i]; }
  // selected transfer store
  for(var i=0; i < sts.length; i++) { url += "&Sts=" + sts[i]; }

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// check all stores
//==============================================================================
function checkAll(action)
{
  var str = document.all.Str

  for(var i=0; i < str.length; i++)
  {
     if(action == "ALL"){ str[i].checked = true; }
     else if(action == "DC" && (str[i].value=="35" || str[i].value=="46" || str[i].value=="50") ){ str[i].checked = true; }
     else if(action == "NY" && str[i].value=="86"){ str[i].checked = true; }
     else if(action == "NE" && (str[i].value=="55" || str[i].value=="63" || str[i].value=="64" || str[i].value=="68")){ str[i].checked = true; }
     else{ str[i].checked = false; }
  }
}

//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, objnm)
{
  var obj = document.all[objnm];
  var date = new Date(obj.value);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  obj.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// resort report
//==============================================================================
function resort(sort)
{
   var url = "PatioItemTransfer.jsp?FrOrd=<%=sFrOrdDt%>&ToOrd=<%=sToOrdDt%>"
      + "&FrDel=<%=sFrDelDt%>&ToDel=<%=sToDelDt%>"

   for(var i=0; i < SlsStr.length; i++) {  url += "&Str=" + SlsStr[i]; }
   for(var i=0; i < TrfStr.length; i++) {  url += "&Trf=" + TrfStr[i]; }
   for(var i=0; i < OrdSts.length; i++) {  url += "&Sts=" + OrdSts[i]; }

   url += "&Sort=" + sort

   window.location.href=url;
}
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>


<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvSelect" class="dvSelect"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Patio Furniture Item Transfer<br>
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="PatioItemTransferSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp; &nbsp;
        </button>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
            <th class="DataTable"><a href="javascript: resort('ISTR')">Inv Request<br>From<br>Store</a></th>
            <th class="DataTable"><a href="javascript: resort('DSTR')">Transfer to<br>Selling Store</a></th>
            <th class="DataTable"><a href="javascript: resort('DELDA')">Delivery<br>Date<br>to Cust</a></th>
            <th class="DataTable"><a href="javascript: resort('ORD')">Order</a></th>
            <th class="DataTable"><a href="javascript: resort('STS')">Status</a></th>
            <th class="DataTable"><a href="javascript: resort('CUST')">Customer<br>Name</a></th>
            <th class="DataTable"><a href="javascript: resort('SLSDA')">Date of<br>Sale</a></th>
            <th class="DataTable"><a href="javascript: resort('DESC')">Item<br>Description</a></th>
            <th class="DataTable"><a href="javascript: resort('VEN')">Vendor<br>Name</a></th>
            <th class="DataTable"><a href="javascript: resort('VENSTY')">Vendor<br>Style</a></th>
            <th class="DataTable"><a href="javascript: resort('COLOR')">Color</a></th>
            <th class="DataTable"><a href="javascript: resort('SIZE')">Size</a></th>
            <th class="DataTable"><a href="javascript: resort('SKU')">Short<br>Sku</a></th>
            <th class="DataTable">Qty</th>
            <th class="DataTable">Chain<br>Retail</th>
            <th class="DataTable">INV From<br>Store<br>On Hand</th>
            <th class="DataTable">SOLD At<br>Store<br>Onhand</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%String sSvOrd = null;         
         while(pfitmtrf.getNext()){           
           pfitmtrf.setTrfItm();
           int iNumOfItm = pfitmtrf.getNumOfItm();
           String [] sIssStr = pfitmtrf.getIssStr();
           String [] sDstStr = pfitmtrf.getDstStr();
           String [] sOrd = pfitmtrf.getOrd();
           String [] sOrdSts = pfitmtrf.getOrdSts();
           String [] sType = pfitmtrf.getType();
           String [] sSku = pfitmtrf.getSku();
           String [] sQty = pfitmtrf.getQty();
           String [] sDesc = pfitmtrf.getDesc();
           String [] sOrdDate = pfitmtrf.getOrdDate();
           String [] sDelDate = pfitmtrf.getDelDate();
           String [] sVenNm = pfitmtrf.getVenNm();
           String [] sVenSty = pfitmtrf.getVenSty();
           String [] sColor = pfitmtrf.getColor();
           String [] sSize = pfitmtrf.getSize();
           String [] sRet = pfitmtrf.getRet();
           String [] sFirstNm = pfitmtrf.getFirstNm();
           String [] sLastNm = pfitmtrf.getLastNm();
           String [] sIssOnh = pfitmtrf.getIssOnh();
           String [] sDstOnh = pfitmtrf.getDstOnh();

           for(int i=0; i < iNumOfItm; i++ ){%>
              <%if((sSort.equals("ORD") || sSort.equals("DELDA")) && sSvOrd != null && !sSvOrd.equals(sOrd[i])){%>
                 <tr class="DataTable1">
                    <td class="DataTable2" colspan=17>&nbsp;</td>
                 </tr>
              <%}%>
              <tr id="trProd" class="DataTable">
                  <td class="DataTable2" nowrap><%=sIssStr[i]%></td>
                  <td class="DataTable2" nowrap><%=sDstStr[i]%></td>
                  <td class="DataTable1" nowrap><%if(!sDelDate[i].equals("01/01/0001")){%><%=sDelDate[i]%><%} else{%>Customer Pickup<%}%></td>
                  <td class="DataTable2" nowrap><a target="_blank" href="OrderEntry.jsp?Order=<%=sOrd[i]%>&List=Y&Stock=Y"><%=sOrd[i]%></a></td>
                  <td class="DataTable1" nowrap><%=sOrdSts[i]%></td>
                  <td class="DataTable1" nowrap><%=sLastNm[i]%>, <%=sFirstNm[i]%></td>
                  <td class="DataTable1" nowrap><%=sOrdDate[i]%></td>
                  <td class="DataTable1" nowrap><%=sDesc[i]%></td>
                  <td class="DataTable1" nowrap><%=sVenNm[i]%></td>
                  <td class="DataTable1" nowrap><%=sVenSty[i]%></td>
                  <td class="DataTable1" nowrap><%=sColor[i]%></td>
                  <td class="DataTable1" nowrap><%=sSize[i]%></td>
                  <td class="DataTable2" nowrap><%=sSku[i]%></td>
                  <td class="DataTable2" nowrap><%=sQty[i]%></td>
                  <td class="DataTable2" nowrap><%=sRet[i]%></td>
                  <td class="DataTable2" nowrap><%=sIssOnh[i]%></td>
                  <td class="DataTable2" nowrap><%=sDstOnh[i]%></td>
              </tr>
              <%sSvOrd=sOrd[i];%>
          <%}%>
       <%}%>
     </table>

      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   pfitmtrf.disconnect();
   pfitmtrf = null;
   }
%>