<%@ page import="itemtransfer.ScanItem, java.util.*, java.text.SimpleDateFormat"%>
<%
   String sIssStr = request.getParameter("IssStr");
   String sDstStr = request.getParameter("DstStr");
   String sSelCtn = request.getParameter("Ctn");
   //----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=ScanItem.jsp&APPL=ALL");
}
else
{
    String sUser = session.getAttribute("USER").toString();

    ScanItem itemLst = new ScanItem(sIssStr, sDstStr, sSelCtn, sUser);
    String sCtn = itemLst.getCtn();
    int iNumOfItm = itemLst.getNumOfItm();

    int iNumOfErr = itemLst.getNumOfErr();
    String sError = itemLst.getErrorJSA();
%>

<html>
<head>

<style>
@media screen
{
   th.DataTable3 { padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
   td.tdScreen  { text-align:center; vertical-align:top;}
}
@media print
{
   th.DataTable3 { display:none }
   td.tdScreen  { display:none }
}

  body {background:white;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  table.DataTable { border: darkred solid 1px;text-align:center;}
  th.DataTable { padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

  tr.DataTable { font-family:Arial; font-size:10px }

  td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:right;}
  td.DataTable1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:left;}
  td.DataTable2{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:center;}


  div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left;font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center;font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }


</style>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript1.2">
var Error = [<%=sError%>];
var ScanAllowed = <%=(iNumOfErr == 0)%>
var Stores = null;
var StoreNames = null;

//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//---------------------------------------------
// initialize value on load
//---------------------------------------------
function  bodyload()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) 
	{  
	   isSafari = true;
	}
	setBoxclasses(["BoxName",  "BoxClose"], ["dvPrompt"]);
   	showError();
}
//==============================================================================
// show errors
//==============================================================================
function showError()
{
   var msg = "";
   for(var i=0; i < Error.length; i++)
   {
      msg += Error[i];
   }
   if( msg != "" ) { alert(msg) }
   Error = null;
}
//==============================================================================
// show Item change panel
//==============================================================================
function chgItem(sku, qty)
{
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>Update Transfered Quantity</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popItemPanel(sku, qty)+ "</td></tr>"
   + "</table>"

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.left = getLeftScreenPos() + 300;
   document.all.dvPrompt.style.top = getTopScreenPos() + 50;
   document.all.dvPrompt.style.visibility = "visible";

   // populate sku and quantity
   document.all.Sku.value = sku;
   document.all.QtyUpd.value = qty;

   document.all.QtyUpd.focus();
   document.all.QtyUpd.select();
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popItemPanel(sku, desc, qty)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"

  // Quantity
  panel += "<tr><td class='Prompt2' nowrap>Short SKU:&nbsp;&nbsp;</td>"
         + "<td class='Prompt' nowrap><input name='Sku' size=12 maxlength=12 readonly></td>"
         + "</tr>";
  // Quantity
  panel += "<tr><td class='Prompt2' nowrap>Quantity:&nbsp;&nbsp;</td>"
         + "<td class='Prompt' nowrap><input name='QtyUpd' size=9 maxlength=9></td>"
         + "</tr>";

  // buttons
  panel += "<tr><td class='Prompt1' colspan='2'>"
        + "<button id='Submit' onClick='Validate(&#34;UPD&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;&nbsp;&nbsp;"
  panel += "</td></tr></table>";

  return panel;
}
//==============================================================================
// get object coordinats
//==============================================================================
function getPosition(obj)
{
   var pos = [0, 0];

   // position menu on the screen
   if (obj.offsetParent)
   {
     while (obj.offsetParent)
     {
       pos[0] += obj.offsetLeft
       pos[1] += obj.offsetTop
       obj = obj.offsetParent;
     }
   }
   else if (obj.x)
   {
     pos[0] += obj.x;
     pos[1] += obj.y;
   }
   return pos;
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
// delete item from transfer file
//==============================================================================
function dltItem(sku)
{
   if (confirm('Please confirm that item must be deleted?'))
   {
      sbmItem(sku, 0, "DLT")
   }
}

//==============================================================================
// validate entered UPC and SKU
//==============================================================================
function  Validate(action)
{
   var msg = "";
   var error = false;

   var item = null;
   var qty = 0;

   if(action=="ADD")
   {
     item = document.all.Item.value.trim();
     qty = document.all.Qty.value.trim();
   }
   else
   {
      item = document.all.Sku.value.trim();
      qty = document.all.QtyUpd.value.trim();
   }

   // validate sku/upc
   if (item == "") { error = true; msg += "UPC/SKU is not entered.\n" }
   else if (isNaN(item))  { error = true; msg += "UPC/SKU is not numeric.\n" }

   // validate quantity
   if (qty == "") { error = true; msg += "Quantity is not entered.\n" }
   else if (isNaN(qty))  { error = true; msg += "Quantity is not numeric.\n" }
   else if (eval(qty) <= 0)  { error = true; msg += "Quantity must be greater than 0.\n" }

   if(error){ alert(msg) }
   else { sbmItem(item, qty, action)  }
}
//==============================================================================
// submit entered UPC or SKU
//==============================================================================
function sbmItem(item, qty, action)
{
   var url = "ScanItemSave.jsp?IssStr=<%=sIssStr%>"
    + "&DstStr=<%=sDstStr%>"
    + "&Ctn=<%=sCtn%>"
    + "&Item=" + item
    + "&Qty=" + qty
    + "&Action=" + action
    ;

   //alert(url)
   //window.location.href=url;
   if(isIE || isSafari){ window.frame1.location.href = url; }
   else if(isChrome || isEdge) { window.frame1.src = url; }
}

//==============================================================================
// get Store list
//==============================================================================
function getStrLst()
{
   if (Stores == null)
   {
     document.all.btnNewCarton.disabled=true
     var url = "RcvStrLst.jsp"
     //alert(url)
     //window.location.href=url;
     if(isIE){ window.frame1.location.href = url; }
     else if(isChrome || isEdge) { window.frame1.src = url; }
   }
   else
   {
      createNewCarton()
   }
}
//==============================================================================
// set Store list
//==============================================================================
function setStrLst(str, strnm)
{
   Stores = str;
   StoreNames = strnm;
   document.all.btnNewCarton.disabled=false
   createNewCarton();
}
//==============================================================================
// show Item change panel
//==============================================================================
function createNewCarton()
{
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>Start New Carton</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popCartonPanel()+ "</td></tr>"
   + "</table>"

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.left= getLeftScreenPos() + 300;
   document.all.dvPrompt.style.top= getTopScreenPos() + 60;
   document.all.dvPrompt.style.visibility = "visible";

   // load destination store
   doDestStrSelect();
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popCartonPanel(sku, desc, qty)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"

  // Destination Store
  panel += "<tr><td class='Prompt2' nowrap>Destination Store:&nbsp;&nbsp;</td>"
         + "<td class='Prompt' nowrap><select class='Small' name='DestStr'></select>"
         + "</tr>";
  // buttons
  panel += "<tr><td class='Prompt1' colspan='2'>"
        + "<button id='Submit' onClick='sbmCtnDtl(null, &#34;NEW&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;&nbsp;&nbsp;"
  panel += "</td></tr></table>";

  return panel;
}
//==============================================================================
// Load Issuing Stores
//==============================================================================
function doDestStrSelect()
{
   var str = document.all.DestStr;

   for (var i = 1, j=0; i < Stores.length; i++)
   {
     if(Stores[i] != <%=sIssStr%>)
     {
        str.options[j++] = new Option(Stores[i] + " - " + StoreNames[i],Stores[i]);
     }
   }
   str.selectedIndex=0;
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
// show Carton details
//==============================================================================
function sbmCtnDtl(dst, ctn)
{
   if (ctn=="NEW")
   {
      dst = document.all.DestStr.options[document.all.DestStr.selectedIndex].value;
   }
   var url = "ScanItem.jsp?IssStr=<%=sIssStr%>"
        + "&DstStr=" + dst
        + "&Ctn=" + ctn
   //alert(url)
   window.location.href = url
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
      var url = "ScanItem.jsp?IssStr=<%=sIssStr%>"
         + "&DstStr=<%=sDstStr%>"
         + "&Ctn=<%=sCtn%>"
      window.location.href=url
   }
}
</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

</head>
<body onload="bodyload()">
<!-------------------------------------------------------------------->
  <div id="dvPrompt" class="Prompt"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

 <table border="0" width="100%" cellPadding="0" cellSpacing="0">
   <tr>
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Scan Transfer
      <br>Destination Store: <%=sDstStr%>
      <br>Carton: <%=sCtn%>
      </b>
     <tr>
      <td class="tdScreen" >

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="ScanItemSel.jsp"><font color="red" size="-1">Select Store</font></a>&#62;
      <a href="ScanTrfCtnLst.jsp?IssStr=<%=sIssStr%>"><font color="red" size="-1">Carton List</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp<br><br>

      </td>
   </tr>
   <!-- -------------------------------------------------------------------- -->
   <!--  New Items -->
   <!-- -------------------------------------------------------------------- -->
   <tr>
      <td class="tdScreen">
        <table  cellPadding="0" cellSpacing="0" align="center">
          <tr>
             <td VALIGN="TOP">UPC/SKU: &nbsp; </td><td><input name="Item" maxlength="14" size="16">  &nbsp;  &nbsp;</td>

          </tr>
          <tr>
             <td VALIGN="TOP">Quantity: &nbsp; </td><td><input name="Qty" maxlength="9" size="9" value='1'>  &nbsp;  &nbsp;</td>
          </tr>
          <tr>
             <td ALIGN="center" colspan=2>&nbsp; &nbsp; &nbsp; <button onClick="Validate('ADD')">Add Item</button><br><br>
          </tr>
        </table>
      </td>
   </tr>

   <tr>
      <td ALIGN="center" VALIGN="TOP">

  <!----------------- beginning of table ------------------------>
  <table class="DataTable" cellPadding="0" cellSpacing="0">
    <tr>
      <th class="DataTable">Dest<br>Store</th>
      <th class="DataTable">Vendor<br>Style</th>
      <th class="DataTable">Vendor<br>Name</th>
      <th class="DataTable">Description</th>
      <th class="DataTable">Color</th>
      <th class="DataTable">Size</th>
      <th class="DataTable">Short Sku</th>
      <th class="DataTable">UPC</th>
      <th class="DataTable">Tranfer/Seq</th>
      <th class="DataTable">Qty</th>
      <th class="DataTable">Issuing Str<br>On Hand</th>
      <th class="DataTable3">Delete</th>
    </tr>
<!------------------------------- Detail Data --------------------------------->
    <%
      for(int i=0; i<iNumOfItm; i++)
      {
         itemLst.setNextItem();
         String sDestStr = itemLst.getDestStr();
         String sCls = itemLst.getCls();
         String sVen = itemLst.getVen();
         String sSty = itemLst.getSty();
         String sClr = itemLst.getClr();
         String sSiz = itemLst.getSiz();
         String sDesc = itemLst.getDesc();
         String sTran = itemLst.getTran();
         String sReg = itemLst.getReg();
         String sSeq = itemLst.getSeq();
         String sSku = itemLst.getSku();
         String sUpc = itemLst.getUpc();
         String sQty = itemLst.getQty();
         String sApprv = itemLst.getApprv();
         String sReason = itemLst.getReason();
         String sRecall = itemLst.getRecall();
         String sVenSty = itemLst.getVenSty();
         String sVenNm = itemLst.getVenNm();
         String sClrNm = itemLst.getClrNm();
         String sSizNm = itemLst.getSizNm();
         String sOnhand = itemLst.getOnhand();
    %>
         <tr class="DataTable">
           <td class="DataTable"><%=sDestStr%></td>
           <td class="DataTable"><%=sVenSty%></td>
           <td class="DataTable"><%=sVenNm%></td>
           <td class="DataTable"><%=sDesc%></td>
           <td class="DataTable"><%=sClrNm%></td>
           <td class="DataTable"><%=sSizNm%></td>
           <td class="DataTable"><%=sSku%></td>
           <td class="DataTable"><%=sUpc%></td>
           <td class="DataTable"><%=sTran%> / <%=sSeq%></td>
           <td class="DataTable"><a class="Small" href="javascript: chgItem('<%=sSku%>','<%=sQty%>')"><%=sQty%></a></td>
           <td class="DataTable"><%=sOnhand%></td>
           <th class="DataTable3" nowrap><a class="Small" href="javascript: dltItem(<%=sSku%>)">Delete</a></th>
    <%}%>
<!---------------------------- end of Report Totals ------------------------------>
 </table>
 <button id="btnNewCarton" onClick="getStrLst();">New Carton</button><br>
 <button onClick="window.location.href='index.jsp'">Transfer Complete</button>
 <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%
}%>