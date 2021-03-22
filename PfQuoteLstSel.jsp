<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PfQuoteLstSel.jsp&APPL=ALL");
   }
   else
   {
      int iSpace = 6;
%>

<style>
 body {background:ivory;}
 
 table.tbl01 { border:none; padding: 0px; border-spacing: 0; border-collapse: collapse; width:100%}
 table.tbl02 { border: lightblue ridge 2px; margin-left: auto; margin-right: auto; 
         padding: 0px; border-spacing: 0; border-collapse: collapse; }
 
 table.Tb1 { background:#FFE4C4;}
 td.DTb1 { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }
 td.DTb11 { border-right: darkred solid 1px; align:left;
            padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }
 .Small { font-size: 10px }
 input.Small1 {background:LemonChiffon; font-family:Arial; font-size:10px }

 tr.DataTable { background:white; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:white; font-family:Arial; font-size:12px; font-weight: bold }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:#FFCC99; font-family:Arial; font-size:10px }
        tr.DataTable5 { background:LemonChiffon; font-family:Arial; font-size:10px }

 th.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; }

 td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;  padding-right:3px; text-align:left;}
 td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}
 td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:center;}


 div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background: #016aab; color:white; text-align:center; font-family:Arial; 
                    font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background: #016aab;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }

      td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px; border-bottom: darkred solid 1px; text-align:left;}
      td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}
      td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}

</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script name="javascript">
var CstProp = null;
var Cust = null;
var SlsPerson = null;
var block = "table-row";
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
  if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
  
  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ block="block"; }
	
  document.all.tdDate1.style.display=block
  document.all.tdDate2.style.display="none"

  setBoxclasses(["BoxName",  "BoxClose"], ["dvStatus"]);
}
//==============================================================================
// show date selection
//==============================================================================
function showDates(datety)
{
   if(datety == "ORD" || datety == "TODAY" || datety == "SEASON")
   {
      document.all.tdDate1.style.display="none"
      document.all.tdDate2.style.display=block
   }

   doSelDate(datety)
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates(datety)
{
   if(datety == 'ORD')
   {
      document.all.tdDate1.style.display=block
      document.all.tdDate2.style.display="none"
      document.all.FrOrdDate.value = "01/01/0001"
      document.all.ToOrdDate.value = "12/31/2999"
   }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(datety){
  var df = document.all;
  var date = new Date(new Date() - 7 * 86400000);
  if(datety == "TODAY") { date = new Date(); }
  if(datety == "SEASON") { date = new Date(); df.FrOrdDate.value = "01/01/" + date.getFullYear()}

  if(datety == "ORD" || datety == "TODAY") { df.FrOrdDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear() }

  date = new Date(new Date());
  if(datety == "ORD" || datety == "TODAY" || datety == "SEASON") { df.ToOrdDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear() }
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
// Validate form entry fields
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";
  var sts = false
  var pysts = false
  var sosts = false
  var cust = document.all.Cust.value.trim();

  if(cust != "" && isNaN(cust)){ error=true; msg += "Customer Number must be numeric." }

  // selling stores
  var strobj = document.all.StrGrp;
  var strchk = false;
  for(var i=0; i < strobj.length; i++) { if(strobj[i].checked){ strchk = true; } }
  if (cust == "" && !strchk){ msg += "\nPlease, check at least 1 selling store\n"; error = true; }
  // if stores not check and customer selected assume all store selected
  if (cust != "" && !isNaN(cust) && !strchk)
  {
     for(var i=0; i < strobj.length; i++) { strobj[i].checked = true; }
  }

  // transferring stores
  strobj = document.all.StrTrf;
  strchk = false;
  for(var i=0; i < strobj.length; i++) { if(strobj[i].checked){ strchk = true; } }
  if (!strchk){ msg += "Please, check at least 1 transfering store\n"; error = true; }

  // validate status
  for(var i=0; i < document.all.Status.length; i++) { if(document.all.Status[i].checked) sts = true;}

  SlsPerson = document.all.SlsPer.value

  if (error){ alert(msg); }
  else{ submitForms(); }
}
//==============================================================================
// submit form
//==============================================================================
function submitForms()
{
   var frorddt = document.all.FrOrdDate.value
   var toorddt = document.all.ToOrdDate.value
   var cust = document.all.Cust.value

   var url = "PfQuoteLst.jsp?FrOrdDt=" +  frorddt
     + "&ToOrdDt=" + toorddt
     + "&Cust=" + cust
     + "&SlsPer=" + SlsPerson

   // set requered statuses
   for(var i=1; i < document.all.Status.length; i++)
   {
      if(document.all.Status[i].checked) url += "&Status=" + document.all.Status[i].value
   }

   // set requered follow ups
   for(var i=0; i < document.all.CommType.length; i++)
   {
      if(document.all.CommType[i].checked) url += "&CommType=" + document.all.CommType[i].value
   }


   // set requered special order statuses
   for(var i=0; i < document.all.InclSO.length; i++)
   {
      if(document.all.InclSO[i].checked) url += "&InclSO=" + document.all.InclSO[i].value
   }

   // selected selling stores
   for(var i=0; i < document.all.StrGrp.length; i++)
   {
      if(document.all.StrGrp[i].checked) url += "&StrGrp=" + document.all.StrGrp[i].value
   }
   // selected transfering stores
   for(var i=0; i < document.all.StrTrf.length; i++)
   {
      if(document.all.StrTrf[i].checked) url += "&StrTrf=" + document.all.StrTrf[i].value
   }

   //alert(url)
   window.location.href=url
}
//==============================================================================
// check all open order statuses
//==============================================================================
function chkAllSts(allsts)
{
   var mark = allsts.checked;
   // set requered statuses
   for(var i=0; i < document.all.CommType.length; i++)
   {
      document.all.CommType[i].checked = mark;
   }
   document.all.Status[1].checked = mark;
   document.all.Status[2].checked = mark;
}
//==============================================================================
// uncheck all open
//==============================================================================
function unChkOth(chkbox)
{
   document.all.Status[0].checked = false;
}
//==============================================================================
// get Searched Item
//==============================================================================
function showCustSearchPanel()
{
   var hdr = "Search Customer Information";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan='2'>" + popCstSearchPanel()
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "250";}
   else { document.all.dvStatus.style.width = "auto";}
   
   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left= getLeftScreenPos() + 300;
   document.all.dvStatus.style.top= getTopScreenPos() + 100;
   document.all.dvStatus.style.visibility = "visible";
   document.all.Last.focus();
}
//==============================================================================
// populate Customer Searched
//==============================================================================
function popCstSearchPanel()
{
  var panel = "<table class='tbl02'>"
  panel += "<tr id='trReg'><td class='Prompt' nowrap>Last Name:</td>"
         + "<td class='Prompt'><input class='Small1' name='Last' size=50 maxsize=50></td>"
       + "</tr>"
       + "<tr id='trReg'><td class='Prompt' nowrap>First Name:</td>"
         + "<td class='Prompt'><input class='Small1' name='First' size=50 maxsize=50></td>"
       + "</tr>"
       + "<tr id='trReg'><td class='Prompt' nowrap>Phone:</td>"
         + "<td class='Prompt'><input class='Small1' name='Phone' size=14 maxsize=14></td>"
       + "</tr>"
       + "<tr id='trReg'><td class='Prompt' nowrap>E-Mail:</td>"
         + "<td class='Prompt'><input class='Small1' name='SrchEMail' size=50 maxsize=50></td>"
       + "</tr>"
       + "<tr id='trReg'><td class='Prompt' nowrap>Quote:</td>"
         + "<td class='Prompt'><input class='Small1' name='SrchOrder' size=10 maxsize=10></td>"
       + "</tr>"

  panel += "<tr><td class='Prompt1' colspan='2'><br><br><button onClick='ValidateCustSearch()' class='Small1'>Submit</button>&nbsp;"
  + "<button onClick='hidePanel();' class='Small1'>Close</button></td></tr>"

     panel += "</table>";
  return panel;
}
//==============================================================================
// populate Customer Searched
//==============================================================================
function ValidateCustSearch()
{
   var error = false;
   var msg = "";

   var last = document.all.Last.value.trim();
   var first = document.all.First.value.trim();
   var phone = document.all.Phone.value.trim();
   var email = document.all.SrchEMail.value.trim();
   var order = document.all.SrchOrder.value.trim();

   if   ((last == null || last == "") && (first == null || first == "")
      && (phone == null || phone == "") && (email == null || email == "")
      && (order == null || order == ""))
   {
      msg = "Please, enter search criteria."
      error = true;
   }
   if(error) { alert(msg) }
   else { sbmCustSearch(last, first, phone, email, order); }
}
//==============================================================================
// populate Customer Searched
//==============================================================================
function sbmCustSearch(last, first, phone, email, order)
{
   var url = "PfCstSearch.jsp?"
     + "Last=" + last
     + "&First=" + first
     + "&Phone=" + phone
     + "&EMail=" + email
     + "&Order=" + order
   hidePanel();
   //alert(url)
   //window.location.href=url
   window.frame1.location.href=url
}
//==============================================================================
// show Customer Searched
//==============================================================================
function showCustList(cust, cstprop, slsPerson, shipInstr, orddt, paid, order)
{
   window.frame1.close();
   Cust = cust;
   CstProp = cstprop;
   Slsper = slsPerson;
   ShipInstr = shipInstr;
   ShipInstr = shipInstr;

   var hdr = "Customer List";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popCustListPanel(cust, cstprop, slsPerson, shipInstr, orddt, paid, order)
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvStatus.style.width = "300";}
   else { document.all.dvStatus.style.width = "auto";}
   
   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.left= getLeftScreenPos() + 300;
   document.all.dvStatus.style.top= getTopScreenPos() + 100;
   document.all.dvStatus.style.visibility = "visible";
}
//==============================================================================
// populate Customer List
//==============================================================================
function popCustListPanel(cust, cstprop, slsPerson, shipInstr, orddt, paid, order)
{
  var dummy = "<table>";

  var panel = "<table class='tbl02'>"
  panel += "<tr class='DataTable1'>"
              + "<th class='DataTable1' rowspan=2 nowrap>Cust<br>#</th>"
              + "<th class='DataTable1' rowspan=2 nowrap>Last<br>Name</th>"
              + "<th class='DataTable1' rowspan=2 nowrap>First<br>Name</th>"
              + "<th class='DataTable1' rowspan=2 nowrap>City</th>"
              + "<th class='DataTable1' rowspan=2 nowrap>State</th>"
              + "<th class='DataTable1' rowspan=2 nowrap>Zip</th>"
              + "<th class='DataTable1' rowspan=2 nowrap>Phone</th>"
              + "<th class='DataTable1' nowrap colspan=3>Last Order</th>"
         + "</tr>"
         panel += "<tr class='DataTable1'>"
            + "<th class='DataTable1' nowrap>Order#</th>"
            + "<th class='DataTable1' nowrap>Date</th>"
            + "<th class='DataTable1' nowrap>Paid</th>"
         + "</tr>"
  for(var i=0; i < cust.length; i++)
  {
     panel += "<tr class='DataTable'>"
              + "<td class='StrInv1' nowrap>" + cust[i] + "</td>"
              + "<td class='StrInv1' nowrap><a href='javascript: setCust(" + i + ")'>" + cstprop[i][0] + "</a></td>"
              + "<td class='StrInv1' nowrap>" + cstprop[i][1] + "</td>"
              + "<td class='StrInv1' nowrap>" + cstprop[i][5] + "</td>"
              + "<td class='StrInv1' nowrap>" + cstprop[i][6] + "</td>"
              + "<td class='StrInv1' nowrap>" + cstprop[i][7] + "</td>"
              + "<td class='StrInv1' nowrap>" + cstprop[i][8] + "</td>"
              + "<td class='StrInv1' nowrap><a href='OrderEntry.jsp?Order=" + order[i] +"'>" + order[i] + "</a></td>"
              + "<td class='StrInv1' nowrap>" + orddt[i] + "</td>"
              + "<td class='StrInv1' nowrap>" + paid[i] + "</td>"
           + "</tr>"
  }

  panel += "<tr><td class='DataTable2' colspan=7><button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";

  return panel;
}
//==============================================================================
// set Customer on page
//==============================================================================
function setCust(i)
{
  document.all.Cust.value = Cust[i];
  hidePanel(); // close customer list panle
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvStatus.innerHTML = " ";
   document.all.dvStatus.style.visibility = "hidden";
}
//==============================================================================
// check/reset store
//==============================================================================
function checkStr(grp, sellOrTrf)
{
   var str = null;
   if (sellOrTrf){ str = document.all.StrGrp; }
   else{ str = document.all.StrTrf; }


   for(var i=0; i < str.length; i++){ str[i].checked = false; }

   if(grp !="RESET")
   {
      for(var i=0; i < str.length; i++)
      {
         if(grp=="ALL"){ str[i].checked = true; }
         if(grp=="SCH" && (str[i].value == "35" || str[i].value == "46" || str[i].value == "50")){ str[i].checked = true; }
         if(grp=="SAS" && (str[i].value == "63" || str[i].value == "64" || str[i].value == "68")){ str[i].checked = true; }
      }
   }
}

//==============================================================================
// show selected order
//==============================================================================
function showSelOrder()
{
   var order = document.all.Order.value.trim();
   if(order !="")
   {
      if(order.trim()=="" || isNaN(order)) order = 0;
      unload_function();
      var url = "OrderEntry.jsp?Order=" + order;
      window.location.href=url;
   }
   else{alert("Please enter Quote number.")}
}

//==============================================================================
// show selected order on the list view
//==============================================================================
function showOrderOnList()
{
   var order = document.all.Order.value.trim();
   if(order.trim()=="" || isNaN(order)){ alert("Please enter correct order number.");}
   else
   {
      unload_function()
      var url = "PfQuoteLst.jsp?Order=" + order
        + "&FrOrdDt=01/01/0001&ToOrdDt=12/31/2999"
        + "&Status=Q&Status=O&Status=F&Status=T&Status=T&Status=R&Status=C&Status=D"
        + "&InclSO=B"
        + "&StrGrp=35&StrGrp=46&StrGrp=50&StrGrp=86&StrGrp=63&StrGrp=64&StrGrp=68"
        + "&StrTrf=35&StrTrf=46&StrTrf=50&StrTrf=86&StrTrf=63&StrTrf=64&StrTrf=68&StrTrf=55"

      window.location.href=url;
   }
}

window.onbeforeunload = unload_function;

//==============================================================================
// show selected order on the list view
//==============================================================================
function unload_function()
{
    window.onbeforeunload = function()
    {
      document.all.Order.value = "";
      document.all.SlsPer.value = "";
    }
}

</script>

<!-- import calendar functions -->
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<html>
<head>
<title>
Patio Furniture Order List
</title>
</head>
<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Patio Furniture - Quote List Selection</B>

       <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>

       <!-- -->
      <TABLE border=0>
        <TBODY>
        <!-- ===================== New Orders ============================== -->
        <TR>
          <TD class="DTb1" style="border-bottom: darkred solid 1px;text-align:center;"  colSpan=6>
           &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            <b>Order/Quote:</b> <input class="Small" name="Order" type="text" size=10 maxlength=10> &nbsp;
                <button class="Small" onclick="showSelOrder();">Go to Quote</button> &nbsp; &nbsp;
                <button class="Small" onclick="showOrderOnList();">View on List</button>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR style="display:none;">
            <TD valign=top align=center colspan="2"><b><u>Select Order Type</u></b></TD>
        </tr>
        <TR style="display:none;" >
            <TD class=DTb1 align=left colspan="2"><%for(int i=0; i < iSpace*5; i++){%>&nbsp;<%}%>
              <INPUT type="radio" name="InclSO" value="N" >In-Stock Orders Only <%for(int i=0; i < 5; i++){%>&nbsp;<%}%>
              <INPUT type="radio" name="InclSO" value="O" >Special Orders Only <%for(int i=0; i < 5; i++){%>&nbsp;<%}%>
              <INPUT type="radio" name="InclSO" value="B" checked>Both
            </TD>
        </TR>
        <!-- =============================================================== -->
        <tr><td style="border-top: darkred solid 1px;font-size:1px;" colspan=6>&nbsp;</td></tr>
        <TR>
            <td><b>Select Selling Stores: </b></td>
            <TD style="padding-top: 10px; padding-bottom: 10px;" align=left valign=top>

              <INPUT type="checkbox" name="StrGrp" value="35" checked>35 &nbsp;
              <INPUT type="checkbox" name="StrGrp" value="46" checked>46 &nbsp;
              <INPUT type="checkbox" name="StrGrp" value="50" checked>50 &nbsp; &nbsp;

              <INPUT type="checkbox" name="StrGrp" value="86" checked>86 &nbsp; &nbsp;

              <INPUT type="checkbox" name="StrGrp" value="63" checked>63 &nbsp;
              <INPUT type="checkbox" name="StrGrp" value="64" checked>64 &nbsp;
              <INPUT type="checkbox" name="StrGrp" value="68" checked>68 &nbsp; &nbsp;

              <br><a href="javascript: checkStr('ALL', true)" style="font-size:12px;">All</a>, &nbsp;
                  <a href="javascript: checkStr('SCH', true)" style="font-size:12px;">DC Area</a>, &nbsp;
                  <a href="javascript: checkStr('SAS', true)" style="font-size:12px;">NE Area</a>, &nbsp;
                  <a href="javascript: checkStr('RESET', true)" style="font-size:12px;">Reset</a> &nbsp;
            </TD>
        </TR>

        <TR  style="display:none;">
            <td><b>Inventory From Stores: </b></td>
            <TD style="padding-top: 10px; padding-bottom: 10px;" align=left valign=top>

              <INPUT type="checkbox" name="StrTrf" value="35" checked>35 &nbsp;
              <INPUT type="checkbox" name="StrTrf" value="46" checked>46 &nbsp;
              <INPUT type="checkbox" name="StrTrf" value="50" checked>50 &nbsp; &nbsp;

              <INPUT type="checkbox" name="StrTrf" value="86" checked>86 &nbsp; &nbsp;

              <INPUT type="checkbox" name="StrTrf" value="63" checked>63 &nbsp;
              <INPUT type="checkbox" name="StrTrf" value="64" checked>64 &nbsp;
              <INPUT type="checkbox" name="StrTrf" value="68" checked>68 &nbsp; &nbsp;

              <INPUT type="checkbox" name="StrTrf" value="55" checked>55 &nbsp; &nbsp;

              <br><a href="javascript: checkStr('ALL', false)" style="font-size:12px;">All</a>, &nbsp;
                  <a href="javascript: checkStr('SCH', false)" style="font-size:12px;">Ski Chalet</a>, &nbsp;
                  <a href="javascript: checkStr('SAS', false)" style="font-size:12px;">Sun & Ski</a>, &nbsp;
                  <a href="javascript: checkStr('RESET', false)" style="font-size:12px;">Reset</a> &nbsp;
            </TD>
        </TR>
        <TR>
           <TD style="border-top: darkred solid 1px; padding-top: 10px; padding-bottom: 10px;" align=center valign=top colspan=2>
                <b>Salesperson:</b><input class="Small" name="SlsPer" type="text" size=4 maxlength=4> &nbsp;
           </TD>
        </TR>

        <!-- =============================================================== -->
        <TR>
            <TD style="border-top: darkred solid 1px; padding-top: 10px; padding-bottom: 10px;" align=center valign=top colspan=2>
              <b><u>Select Quote Status</u></b>
            </TD>
        </TR>
        <TR>
           <TD>&nbsp;</td>
            <TD  align=left valign=top colspan=2>
              <INPUT type="checkbox" name="Status" onclick="chkAllSts(this)">All Quotes
              <br><INPUT type="checkbox" name="Status" onclick="unChkOth(this)" value="A" checked >All Active Quotes
              <br><br>&nbsp; &nbsp; <b>Follow Up:</b>
              <br><INPUT type="checkbox" name="CommType" onclick="unChkOth(this)" value="QST1" checked >Initial Phone Call
              <br><INPUT type="checkbox" name="CommType" onclick="unChkOth(this)" value="QST2" checked >Thank You Card/Email
              <br><INPUT type="checkbox" name="CommType" onclick="unChkOth(this)" value="QST3" checked >Final Phone Call
              <br>
              <br><INPUT type="checkbox" name="Status" onclick="unChkOth(this)" value="E" >Closed Quotes
            </TD>
         </tr>
        <!-- ======================== From Date ======================================= -->   
        
        <TR>
          <TD class="DTb1" id="tdDate1" colspan="2" align=center style="border-top: darkred solid 1px; padding-top: 10px;" >
             <button class="Small" id="btnSelOrdToday" onclick="showDates('SEASON')">This Season</button> &nbsp;
             <button class="Small" id="btnSelOrdDates" onclick="showDates('ORD')">Optional Quote Date Selection</button> &nbsp;
             <button class="Small" id="btnSelOrdToday" onclick="showDates('TODAY')">Quoted Today</button>
          </td>
        </TR>
             
        <TR>  
          <TD class=DTb1 id="tdDate2" colspan="2" align=center style="border-top: darkred solid 1px; padding-top: 10px;" >
             <b>Quote Date From:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrOrdDate')">&#60;</button>
              <input class="Small" name="FrOrdDate" type="text" value="01/01/0001" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrOrdDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 300, 500, document.all.FrOrdDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < iSpace * 2; i++){%>&nbsp;<%}%>

              <b>Quote Date To:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToOrdDate')">&#60;</button>
              <input class="Small" name="ToOrdDate" type="text" value="12/31/2999" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToOrdDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 810, 500, document.all.ToOrdDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelOrdDates" onclick="showAllDates('ORD')">All Date</button>
          </TD>
        </TR>
        
        

        <!-- =============================================================== -->
        <TR>
           <TD style="border-top: darkred solid 1px; padding-top: 10px;" class=DTb1 align=center colSpan="2">
                <b>Customer Number:</b><input class="Small" name="Cust" type="text" size=10 maxlength=10> &nbsp;
                <button class="Small" onclick="showCustSearchPanel();">Customer Search</button>
           </TD>
        </TR>

        <!-- =============================================================== -->
        <TR>
           <TD style="border-top: darkred solid 1px; padding-top: 10px;" class=DTb1 align=center colSpan="2">&nbsp;&nbsp;&nbsp;&nbsp;
               <button onclick="Validate()" id="SUBMIT" >Submit</button>
           </TD>
        </TR>
       <!-- =============================================================== -->
        </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</body>
</html>
<%}%>