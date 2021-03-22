<%@ page import="ecommerce.EComVolAPI"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComUplRMA_Direct.jsp");
}
else
{
%>
<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>
        body {background:white;}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}

        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:11px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}

        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable12 { color:red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}



        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvOrder { visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:300; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }

</style>

<script name="javascript1.2">

var Site = null;
var Ord = null;

var DtlId = new Array();
var Cls = new Array();
var Ven = new Array();
var Sty = new Array();
var Clr = new Array();
var Siz = new Array();
var Sku = new Array();
var Desc = new Array();
var QtyOnShip = new Array();
var Upc = new Array();
var Ret = new Array();

// Scanned Items List
var ScanUpc = new Array();
var ScanQty = new Array();
var ScanItemOnOrd = new Array();
var ScanQtyMatchOrd = new Array();
var ScanRow = -1;
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
  //setBoxclasses(["BoxName",  "BoxClose"], ["dvOrder"], ["dvItem"], ["dvItemList"] );
  document.all.trButton.style.display = "none";
  document.all.Order.focus();
}
//==============================================================================
// check that Enter key was pressed
//==============================================================================
function onOrderEnter()
{
   if(event.keyCode==13){ chkOrdEnt() }
}
//==============================================================================
// validate order entry
//==============================================================================
function chkOrdEnt()
{
   var error = false;
   var msg = "";
   var ord = "";
   var site = "";

   var inpOrder = document.all.Order.value.trim();
   if(inpOrder == "" || isNaN(inpOrder)){ error = true; msg = "Order is not entered or is not numeric."}
   else if(inpOrder.length != 6){ error = true; msg = "Order must contain 6 digits."}
   else
   {
      var numsite = inpOrder.substring(5);

      if (numsite == '1'){ site = "SASS";}
      else if (numsite == '2'){ site = "SKCH";}
      else if (numsite == '3'){ site = "SSTP";}
      else if (numsite == '4'){ site = "RLHD";}

      ord = inpOrder.substring(0, 5)
   }

   if(error){ alert(msg); }
   else{ rcvOrdInfo(site, ord) }
}
//==============================================================================
// receive order Info
//==============================================================================
function rcvOrdInfo(site, ord)
{
   var url = "EComOrdInq.jsp?Site=" + site
       + "&Order=" + ord

   //alert(url);
   //window.location.href = url;
   window.frame1.location.href = url;
}

//==============================================================================
// set selected order information
//==============================================================================
function setOrdInfo(site, ord, dtlId, cls, ven, sty, clr, siz, sku, desc, qtyOnShip, upc, ret)
{
   Site = site;
   Ord = ord;

   for(var i=0; i < dtlId.length; i++)
   {
     DtlId[i] = dtlId[i]; Cls[i] = cls[i];
     Ven[i] = ven[i]; Sty[i] = sty[i]; Clr[i] = cls[i]; Siz[i] = siz[i];
     Sku[i] = sku[i];  Desc[i] = desc[i]; QtyOnShip[i] = qtyOnShip[i];
     Upc[i] = upc[i]; Ret[i] = ret[i];
   }

   var hdr = "Site: " + site + "&nbsp; Order:&nbsp;" + ord;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
     + "</tr>"
     + "<tr><td class='Prompt1'>"
         + popItmPanel(site, ord, dtlId, cls, ven, sty, clr, siz, sku, desc, qtyOnShip, upc, ret)
      + "</td></tr>"
    + "</table>"

   document.all.dvOrder.innerHTML = html;
   document.all.dvOrder.style.visibility = "visible";
   //document.all.dvOrder.style.pixelLeft= document.documentElement.scrollLeft + 100;
   //document.all.dvOrder.style.pixelTop= document.documentElement.scrollTop + 150;


   document.all.Order.disabled = true;
   document.all.getOrder.disabled = true;
   getItemPanel();
}
//==============================================================================
// populate Item Status Panel
//==============================================================================
function popItmPanel(site, ord, dtlId, cls, ven, sty, clr, siz, sku, desc, qtyOnShip, upc, ret)
{
  var dummy = "<table>";
  var panel = "<table border=1 width='100%' cellPadding='5' cellSpacing='0'>"
     + "<tr>"
        + "<th class='DataTable'>Dtl<br>Id</th>"
        + "<th class='DataTable' nowrap>Item Number<br>Cls-Ven-Sty-Clr-Siz</th>"
        + "<th class='DataTable' nowrap>Sku</th>"
        + "<th class='DataTable' nowrap>UPC</th>"
        + "<th class='DataTable' nowrap>Desciption</th>"
        + "<th class='DataTable' nowrap>Retail</th>"
        + "<th class='DataTable' nowrap>Q-ty On<br>Shipping</th>"
     + "</tr>"

  for(var i=0, j=0; i < dtlId.length; i++)
  {
     panel += "<tr class='DataTable'>"
            + "<td class='DataTable'>" + dtlId[i] + "</td>"
            + "<td class='DataTable' nowrap>" + cls[i] + "-" + ven[i] + "-" + sty[i] + "-"
                + clr[i] + "-" + siz[i] + "</td>"
            + "<td class='DataTable' nowrap>" + sku[i] + "</td>"
            + "<td class='DataTable' nowrap>" + upc[i] + "</td>"
            + "<td class='DataTable' nowrap>" + desc[i] + "</td>"
            + "<td class='DataTable' nowrap>" + ret[i] + "</td>"
            + "<td class='DataTable' nowrap>" + qtyOnShip[i] + "</td>"
         + "</tr>"
  }
  panel += "</table>";

  return panel;
}
//==============================================================================
// set selected order information
//==============================================================================
function getItemPanel()
{
   var hdr = "Scan Items in Box";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
     + "</tr>"
    + "<tr><td class='Prompt1' colspan=2>"
        + popItemPanel()
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.visibility = "visible";

   document.all.Item.value = "";
   document.all.Item.focus();
}
//==============================================================================
// populate Item Status Panel
//==============================================================================
function popItemPanel()
{
  var panel = "<table border=1 width='100%' cellPadding='5' cellSpacing='0'>"
     + "<tr>"
        + "<td class='Prompt'>Item:</td>"
        + "<td class='Prompt'><input class='Small' name='Item' onKeyUp='onItemEnter()' size=12 maxlength=12></td>"
     + "</tr>"
  panel += "</table>";

  return panel;
}
//==============================================================================
// check that Enter key was pressed
//==============================================================================
function onItemEnter()
{
   if(event.keyCode==13){ addNewItem() }
}
//==============================================================================
// add new Item to Scanned Item List table
//==============================================================================
function addNewItem()
{
   var scanUpc = document.all.Item.value.trim();
   var foundOnOrder = isItemOnOrder(scanUpc);
   // add or update item
   var oldItem = addItemOnScanList(scanUpc)

   if(document.all.tbItemList == null) { createItemListTable(); }

   if(!oldItem) { addScannedRow(scanUpc); }

   document.all.Item.value = "";
   document.all.Item.focus();
}
//==============================================================================
// check if this Item is on Order List
//==============================================================================
function isItemOnOrder(scanUpc)
{
   var found = false;
   for(var i=0; i < Upc.length; i++)
   {
     if(Upc[i] == scanUpc){ found = true; }
   }
   return found;
}
//==============================================================================
// check if this Item is on Order List
//==============================================================================
function addItemOnScanList(scanUpc)
{
   var found = false;
   var row = -1;

   for(var i=0; i < ScanUpc.length; i++)
   {
     var old = "" + ScanUpc[i].trim();

     if(old == scanUpc.trim())
     {
       found = true; row = i; ScanQty[row] += 1;
       updScannedRow(scanUpc, row, ScanQty[row]);
       break;
     }
   }

   if(!found)
   {
     ScanRow += 1;
     ScanUpc[ScanRow]  = scanUpc;
     ScanQty[ScanRow] = 1;
     ScanItemOnOrd[ScanRow] = false;
     ScanQtyMatchOrd[ScanRow] = false;
   }
   return found;
}

//==============================================================================
// create scanned item list table
//==============================================================================
function createItemListTable()
{
   var hdr = "Scan Item List";

   var html = "<table border=1 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
     + "</tr>"
     + "<tr><td class='Prompt1' colspan=2>"
         + "<table id='tbItemList'><tr><th class='DataTable'>UPC</th><th class='DataTable'>Qauntity</th>"
         + "<th class='DataTable'>Item<br>Found</th><th class='DataTable'>Quantity<br>match</th></tr>"
         + "<tbody></tbody></table>"
     + "</td></tr>"
   + "</table>"

   document.all.dvItemList.innerHTML = html;
   document.all.dvItemList.style.visibility = "visible";
}

//==============================================================================
// add Scanned row in the scanned item list table
//==============================================================================
function addScannedRow(scanUpc)
{
   var tbody = document.getElementById("tbItemList").getElementsByTagName("TBODY")[0];
   var row = document.createElement("TR")
   row.className="DataTable";
   row.id="trItm" + ScanRow; //add ID

   var td = new Array();
   td[0] = addTDElem(scanUpc, "tdUpc" + ScanRow, "DataTable") // Upc Code
   td[1] = addTDElem("1", "tdQty" + ScanRow, "DataTable") // Upc Code

   // item is found/not found in Order
   ScanItemOnOrd[ScanRow] = isItemFoundOnOrder(scanUpc);
   if (ScanItemOnOrd[ScanRow]) { td[2] = addTDElem("Yes", "tdItmFnd" + ScanRow, "DataTable") }
   else { td[2] = addTDElem("No", "tdItmFnd" + ScanRow, "DataTable") }

   ScanQtyMatchOrd[ScanRow] = isQtyMatch(scanUpc, 1);
   if (ScanQtyMatchOrd[ScanRow]) { td[3] = addTDElem("Yes", "tdQtyMatch" + ScanRow, "DataTable") }
   else { td[3] = addTDElem("No", "tdQtyMatch" + ScanRow, "DataTable") }

   // add cell to row
   for(var i=0; i < td.length; i++) { row.appendChild(td[i]); }

   // add row to table
   tbody.appendChild(row);

   document.all.trButton.style.display = "block";
}
//==============================================================================
// add new TD element
//==============================================================================
function addTDElem(value, id, classnm)
{
  var td = document.createElement("TD") // Reason
  td.appendChild (document.createTextNode(value))
  td.className=classnm;
  td.id = id;
  return td;
}

//==============================================================================
// update Scanned Item rows quantity
//==============================================================================
function updScannedRow(scanUpc, row, newqty)
{
   var qtynm = "tdQty" + row
   var qtymatch = "tdQtyMatch" + row

   document.all[qtynm].innerHTML = newqty;

   if (isQtyMatch(scanUpc, newqty)) { document.all[qtymatch].innerHTML = "Yes";}
   else { document.all[qtymatch].innerHTML = "No";}
}

//==============================================================================
// validate scanning
//==============================================================================
function isItemFoundOnOrder(scanUpc)
{
   var  found = false;

   for(var i=0; i < Upc.length; i++)
   {
       var ordupc  = "" + Upc[i];
       if(ordupc == scanUpc) { found = true; break;}
   }
   return found
}

//==============================================================================
// is quantity entered match with order qty
//==============================================================================
function isQtyMatch(scanUpc, qty)
{
   var  match = false;

   for(var i=0; i < Upc.length; i++)
   {
       var ordupc  = "" + Upc[i];
       if(ordupc == scanUpc)
       {
         if(eval(qty) == eval(QtyOnShip[i])) { match = true; break; }
       }
   }
   return match;
}
//==============================================================================
// validate scanning
//==============================================================================
function ValidateScan()
{
   var msg ="";
   var error = false;

   for(var i=0; i < ScanUpc.length; i++)
   {
       if(!ScanItemOnOrd[i] || !ScanQtyMatchOrd[i])
       {
          error = true;
          msg = "Some items is not found on order or quantity is not match.";
          break;
       }
   }

   if(error){ alert(msg) }
   else { saveScan() }
}
//==============================================================================
// save scan
//==============================================================================
function saveScan()
{
   var url = "EcomSvScan.jsp";

   alert(url)
}
//==============================================================================
// reset screen
//==============================================================================
function reset()
{
   window.location.reload();
}
//==============================================================================
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->


<TABLE  width="100%" border=0 id="tblSite">
  <TR>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>E-Commerce Order Packing Verifications
        </B><br>
        <a href="index.jsp">Home</a>
        <br>

        Order: <input name="Order" onKeyUp="onOrderEnter()" size=10 maxsize=10> &nbsp;
        <button class="Small" id="getOrder"  onclick="chkOrdEnt();">Get Order</button>  &nbsp;
        <button class="Small" onclick="reset();">New</button>
    </td>
  <tr>

  <!-- ====================== Order Information ============================ -->
  <tr><td align=center ><div id="dvOrder" class="dvOrder"></div></td></tr>
  <!-- ===================================================================== -->
  <tr><td align=center><div id="dvItem" class="dvOrder"></div></td></tr>
  <!-- ====================== Scanned Item List ============================ -->
  <tr><td align=center><div id="dvItemList" class="dvOrder"></div></td></tr>
  <!-- ===================================================================== -->

  <tr id="trButton"><td align=center><button class="Small" onclick="ValidateScan();">Save</button></td></tr>
</table>

</body>
<%}%>







