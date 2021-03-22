<%@ page import="ecommerce.EComRmaLst"%>
<%
   String [] sSts = request.getParameterValues("Sts");
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");
   String sOrder = request.getParameter("Order");
   String sAction = request.getParameter("Action");

   if (sOrder == null) { sOrder = " "; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null && session.getAttribute("ECOMDWNL")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=EcRmaLst.jsp&APPL=ALL");
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();

      //System.out.println(sSts[0] + "|" + sFrom);
      EComRmaLst rmalst = new EComRmaLst(sSts, sFrom, sTo, sOrder, sAction, sUser);
%>

<html>
<head>
<title>Returned Item List</title>
<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#efefef; font-family:Arial; font-size:10px }
        tr.DataTable11 { background:pink; font-family:Arial; font-size:10px }

        td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center;}
        td.DataTable2 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:right;}

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150; background-color: white; z-index:10;
              text-align:center; font-size:10px}
                td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}

        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

        .Small {font-size:10px;}
        <!--------------------------------------------------------------------->
</style>




<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Site = new Array();
var Ord = new Array();
var OrdDtl = new Array();
var Cls = new Array();
var Ven = new Array();
var Sty = new Array();
var Clr = new Array();
var Siz = new Array();
var Sku = new Array();
var Desc = new Array();
var Qty = new Array();
var Ret = new Array();
var ExtRet = new Array();
var Ship = new Array();
var Tax = new Array();
var Tot = new Array();
var Sts = new Array();
var Tender = new Array();
var TaxReq = new Array();
var RefTyGood = new Array();

var UpdRecArg = null;

var MarkALLItem = false;
var MarkAll_Cur_Arg = 0;

var SavColor = "#efefef";
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{

}

//==============================================================================
// initialize process
//==============================================================================
function showItem(arg)
{
   var hdr = "Order:&nbsp;" + Ord[arg] + "&nbsp; Detail: " + OrdDtl[arg];

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popItmPanel(arg)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";

   // populate value in input fields
   document.all.Ret.value = Ret[arg];
   document.all.ExtRet.value = ExtRet[arg];
   document.all.ExtRet.style.background = "#e7e7e7";
   document.all.Tax.value = Tax[arg];
   document.all.Tot.value = Tot[arg];
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popItmPanel(arg)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable'><td class='DataTable' nowrap>Item: &nbsp; </td>"
           + "<td class='DataTable' nowrap>" + Cls[arg] + "-" + Ven[arg] + "-" + Sty[arg] + "-" + Clr[arg] + "-" + Siz[arg]
           + " &nbsp; " + Desc[arg] + "</td>"
        + "</tr>"

        + "<tr class='DataTable'><td class='DataTable' >Quantity:</td>"
           + "<td class='DataTable'>" + Qty[arg] + "</td>"
        + "</tr>"

        + "<tr class='DataTable'><td class='DataTable' >Unit Retail:</td>"
           + "<td class='DataTable'> &nbsp; <input name='Ret' class='Small' size=7 maxlength=7>"
               + "&nbsp; <button onclick='clcNewExtRet(&#34;" + arg +  "&#34;)'>Calc</button>"
           + "</td>"
        + "</tr>"
        
        + "<tr class='DataTable'><td class='DataTable' >Extended Retail:</td>"
           + "<td class='DataTable'> &nbsp; <input name='ExtRet' class='Small' size=7 maxlength=7 readonly></td>"
        + "</tr>"

        + "<tr class='DataTable'><td class='DataTable' >Shipping:</td>"
           + "<td class='DataTable'> &nbsp; <input name='Ship' class='Small' size=7 maxlength=7> Per Order: &nbsp; "
           + Ship[arg] + "</td>"
        + "</tr>"

        + "<tr class='DataTable'><td class='DataTable' >Tax:</td>"
           + "<td class='DataTable'> &nbsp; <input name='Tax' class='Small' size=7 maxlength=7></td>"
        + "</tr>"

        + "<tr class='DataTable'><td class='DataTable' >Tender:</td>"
           + "<td class='DataTable'> &nbsp; <input name='Tender' class='Small' size=2 maxlength=2> Per Order: &nbsp; "
           + Tender[arg] + "</td>"
        + "</tr>"

        + "<tr class='DataTable'><td class='DataTable' >Total:</td>"
           + "<td class='DataTable'> &nbsp; <input name='Tot' class='Small' size=7 maxlength=7 readOnly></td>"
        + "</tr>"

        + "<tr class='DataTable'><td class='DataTable' >Tender:</td>"
           + "<td class='DataTable'>" + Tender[arg] + "</td>"
        + "</tr>"

  panel += "<tr class='DataTable'><td class='DataTable' colspan='2'>"
        + "<button onClick='Validate(" + arg + ", &#34;MARK&#34;)' "
        + "class='Small'>Submit</button> &nbsp; &nbsp; "

  if(Sts[arg] == "N" || Sts[arg] == "X")
  {
    panel += "<button onClick='Validate(" + arg + ", &#34;UNMARK&#34; )' "
          + "class='Small'>Unmark</button> &nbsp; &nbsp; "
  }
  else
  {
     panel += "<button onClick='Validate(" + arg + ", &#34;SKIP&#34; )' "
        + "class='Small'>Skip</button> &nbsp; &nbsp; "
  }

  panel += "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";


  return panel;
}
//==============================================================================
//calculate new extended retail
//==============================================================================
function clcNewExtRet(arg)
{
	var error = false;
	var msg = "";
	var ret = document.all.Ret.value.trim();
	if(isNaN(ret)){ error = true; msg += "Unit retail price is not numeric;"}
	
	if(error){alert(msg);}
	else{ document.all.ExtRet.value = (ret * Qty[arg]).toFixed(2);}	 	     
}
//==============================================================================
// mark all
//==============================================================================
function markAll()
{
  MarkALLItem = true;
  markAll_Next_Item();
}
//==============================================================================
// mark all
//==============================================================================
function markAll_Next_Item()
{
  var error = false;

  // submit only unprocessed and unmarked records
  while(Sts[MarkAll_Cur_Arg] != "" &&  MarkAll_Cur_Arg < Ord.length)
  {
    MarkAll_Cur_Arg++;
  }

  var ret = Ret[MarkAll_Cur_Arg]
  var tax = Tax[MarkAll_Cur_Arg]
  var ship = 0;
  var tender = "";

  if (isNaN(ret)) { error = true; }
  else if (eval(ret) <= 0) { error = true; }

  if (isNaN(tax)) { error = true; }
  else if (eval(tax) < 0) { error = true; }

  if(!error){ sbmItem(MarkAll_Cur_Arg, ret, tax, ship, tender, "MARK") }

  if (MarkAll_Cur_Arg < Ord.length - 1) { MarkAll_Cur_Arg++; }
  else { MarkALLItem = false; MarkAll_Cur_Arg = 0; }
}
//--------------------------------------------------------
// quick process
//--------------------------------------------------------
function quickProc(arg, action)
{
   var error = false;
   var msg = "";

   var ret = ExtRet[arg]
   var tax = Tax[arg]
   var ship = 0
   var tender = "";

   if( action == "MARK")
   {
      if (isNaN(ret)) { error = true; msg += "\nValue in Retail box must be numeric."}
      else if (eval(ret) < 0) { error = true; msg += "\nRetail amount must be positive number."}

      if (isNaN(tax)) { error = true; msg += "\nValue in Tax box must be numeric."}
      else if (eval(tax) < 0) { error = true; msg += "\nTax amount must be positive number or 0."}
      else if(eval(tax[arg]) == 0 && TaxReq[arg] == "1"){ error = true; msg += "\nTax cannot be 0 for this item." }

      if(Tender[arg].trim() == ""){ error = true; msg += "\nTender is not found." }
      if(RefTyGood[arg] != "1"){ error = true; msg += "\nRefund type is incorrect. The Item cannot be processed." }
   }

   if(error){ alert(msg); }
   else { sbmItem(arg, ret, tax, ship, tender, action) }
}
//--------------------------------------------------------
// Validate processed Items
//--------------------------------------------------------
function Validate(arg, action)
{
   var error = false;
   var msg = "";

   var ret = document.all.ExtRet.value
   var tax = document.all.Tax.value
   var ship = document.all.Ship.value
   var tender = document.all.Tender.value.trim();

   if( action == "MARK")
   {
      if (isNaN(ret)) { error = true; msg += "\nValue in Retail box must be numeric."}
      else if (eval(ret) <= 0) { error = true; msg += "\nRetail amount must be positive number."}

      if (isNaN(tax)) { error = true; msg += "\nValue in Tax box must be numeric."}
      else if (eval(tax) < 0) { error = true; msg += "\nTax amount must be positive number or 0."}

      if (isNaN(ship)) { error = true; msg += "\nValue in Shipping Cost box must be numeric."}
      else if (eval(ship) <= 0) { error = true; msg += "\nShipping Cost amount must be positive number."}

      if(Tender[arg].trim() == "" && tender == ""){ error = true; msg += "\nTender is not found." }
      else if (tender != "" && tender != "38" && tender != "90" && tender != "91" && tender != "92"
          && tender != "93" && tender != "94" && tender != "81" && tender != "80" && tender != "68")
      {
         error = true; msg += "\nTender is invalid."
      }
      if(RefTyGood[arg] != "1"){ error = true; msg += "\nRefund type is incorrect. The Item cannot be processed." }

   }
   if(error){ alert(msg); }
   else { sbmItem(arg, ret, tax, ship, tender, action) }
}
//--------------------------------------------------------
// submit processed Items
//--------------------------------------------------------
function sbmItem(arg, ret, tax, ship, tender,  action)
{
  UpdRecArg = arg;
  hidePanel();
  showWaitPanel();

  var url = "EComRmaSav.jsp?"
    + "Site=" + Site[arg]
    + "&Ord=" + Ord[arg]
    + "&OrdDtl=" + OrdDtl[arg]
    + "&Ret=" + ret
    + "&Tax=" + tax
    + "&Ship=" + ship
    + "&Tender=" + tender
    + "&Action=" + action

  //alert(url)
  //window.location = url;
  window.frame1.location = url;
}
//--------------------------------------------------------
// show Waiting Panel, while return will be updated
//--------------------------------------------------------
function showWaitPanel()
{
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
    + "<tr><td class='Prompt' colspan=2>"
     + "Item return is updating now. Wait ... &nbsp; &nbsp; &nbsp; &nbsp; <br><br><br><br><br>"
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";
}
//--------------------------------------------------------
// changes was saved
//--------------------------------------------------------
function chgSaved(ret, tax, ship)
{
   window.frame1.close();

   var i = UpdRecArg;
   UpdRecArg = null;
   var tdret = "tdRet" + i;
   var tdtax = "tdTax" + i;
   var tdship = "tdShip" + i;
   var tdsts = "tdSts" + i;
   var tritem = "trItem" + i;

   document.all[tdret].innerHTML = ret;
   document.all[tdtax].innerHTML = tax;
   document.all[tdship].innerHTML = ship;
   document.all[tdsts].innerHTML = " *** Updated *** ";
   document.all[tritem].style.backgroundColor = "pink";

   Ret[i] = ret;
   Tax[i] = tax;
   Ship[i] = ship;

   hidePanel();

   if (MarkALLItem) { markAll_Next_Item(); }
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
// change text color on mouse moved over table row
function mouseOver(obj)
{
  SavColor = obj.style.backgroundColor;
  obj.style.color = "red";
  obj.style.backgroundColor = "yellow";
}

// change text color on mouse moved out table row
function mouseOut (obj)
{
  obj.style.color = "black";
  obj.style.backgroundColor = SavColor;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>Returned Item List
        </b>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="EComRmaLstSel.jsp"><font color="red" size="-1">Select</font></a>&#62;
      <font size="-1">This Page</font> &nbsp; &nbsp; &nbsp; &nbsp;

      <!--a href="javascript: markAll()">Mark All</a -->
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable">
         <th class="DataTable" nowrap>Order</th>
         <th class="DataTable" nowrap>Order<br>Detail</th>
         <th class="DataTable" nowrap>P<br>r<br>o<br>c</th>
         <th class="DataTable" nowrap>Long Item Number</th>
         <th class="DataTable" nowrap>Sku</th>
         <th class="DataTable" nowrap>Description</th>
         <th class="DataTable" nowrap>Rtn<br>Qty</th>
         <th class="DataTable" nowrap>Extended<br>Retail</th>
         <th class="DataTable" nowrap>Unit<br>Retail</th>
         <th class="DataTable" nowrap>Ship<br>Per<br>Order</th>
         <th class="DataTable" nowrap>Tax<br>Per<br>Item</th>
         <th class="DataTable" nowrap>Rtn<br>Total</th>
         <th class="DataTable" nowrap>Tender</th>
         <th class="DataTable" nowrap>Return<br>Date</th>
         <th class="DataTable" nowrap>Rtn<br>to<br>IP</th>
         <th class="DataTable" nowrap>SA<br>Proc<br>Date</th>
      </tr>
      <TBODY>

      <!----------------------- Order List ------------------------>
      <%
        int iNum = 0;
        while( rmalst.getNext() ){%>
        <%
           rmalst.getItem();
           String sSite = rmalst.getSite();
           String sOrd = rmalst.getOrd();
           String sOrdDtl = rmalst.getOrdDtl();
           String sCls = rmalst.getCls();
           String sVen = rmalst.getVen();
           String sSty = rmalst.getSty();
           String sClr = rmalst.getClr();
           String sSiz = rmalst.getSiz();
           String sSku = rmalst.getSku();
           String sDesc = rmalst.getDesc();
           String sRetQty = rmalst.getRetQty();
           String sTotQty = rmalst.getTotQty();
           String sExtRet = rmalst.getExtRet();
           String sRet = rmalst.getRet();
           String sShip = rmalst.getShip();
           String sTax = rmalst.getTax();
           String sIpSls = rmalst.getIpSls();
           String sIpDate = rmalst.getIpDate();
           String sIpTime = rmalst.getIpTime();
           String sCrtDate = rmalst.getCrtDate();
           String sCrtTime = rmalst.getCrtTime();
           String sTender = rmalst.getTender();
           String sRetDate = rmalst.getRetDate();
           String sRetTime = rmalst.getRetTime();
           String sTotRet = rmalst.getTotRet();
           String sTaxReq = rmalst.getTaxReq();
           String sRefTyGood = rmalst.getRefTyGood();
           String sStyle1 = "";
           if(sRefTyGood.equals("0")){ sStyle1 = "background:pink"; }
           String sMarkTax = "";
           if(sTaxReq.equals("1")){ sMarkTax = "<span style='color:red;'>*</span>"; }
        %>
          <tr  class="DataTable1<%if(sIpSls.equals("N")){%><%=1%><%}%>" id="trItem<%=iNum%>" onmouseover="mouseOver(this)" onmouseout="mouseOut(this)">
            <td class="DataTable">
              <%if(!sIpSls.equals("Y")){%><span style="<%=sStyle1%>"><a href="javascript: showItem('<%=iNum%>')"><%=sOrd%></a><%} else{%><%=sOrd%><%}%></span>
            </td>
            <td class="DataTable2"><%=sOrdDtl%></td>
            <td class="DataTable"><%if(!sIpSls.equals("Y")){%><a href="javascript: quickProc('<%=iNum%>', 'MARK')">sbm</a><%} else{%>&nbsp;<%}%></td>
            <td class="DataTable" nowrap><%=sCls + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz%></td>
            <td class="DataTable"><%=sSku%></td>
            <td class="DataTable" nowrap><%=sDesc%></td>
            <td class="DataTable2"><%=sRetQty%></td>
            <td class="DataTable2" id="tdRet<%=iNum%>">$<%=sExtRet%></td>
            <td class="DataTable2" id="tdRet<%=iNum%>">$<%=sRet%></td>
            <td class="DataTable2" id="tdShip<%=iNum%>">$<%=sShip%></td>
            <td class="DataTable2" id="tdTax<%=iNum%>"><%=sMarkTax%> $<%=sTax%></td>
            <td class="DataTable2" id="tdTot<%=iNum%>">$<%=sTotRet%></td>
            <td class="DataTable"><%=sTender%></td>
            <td class="DataTable"><%=sRetDate%></td>
            <td class="DataTable1" id="tdSts<%=iNum%>"><%=sIpSls%></td>
            <td class="DataTable"><%if(!sIpDate.equals("01/01/0001")){%><%=sIpDate%><%}%></td>
            <script>
              Site[<%=iNum%>]="<%=sSite%>";
              Ord[<%=iNum%>]="<%=sOrd%>";OrdDtl[<%=iNum%>]="<%=sOrdDtl%>"; Cls[<%=iNum%>]="<%=sCls%>";
              Ven[<%=iNum%>]="<%=sVen%>"; Sty[<%=iNum%>]="<%=sSty%>"; Clr[<%=iNum%>]="<%=sClr%>";
              Siz[<%=iNum%>]="<%=sSiz%>"; Sku[<%=iNum%>]="<%=sSku%>";
              Qty[<%=iNum%>]="<%=sRetQty%>"; Ret[<%=iNum%>]="<%=sRet%>"; ExtRet[<%=iNum%>]="<%=sExtRet%>"; Ship[<%=iNum%>]="<%=sShip%>";
              Tax[<%=iNum%>]="<%=sTax%>"; Sts[<%=iNum%>]="<%=sIpSls%>"; Desc[<%=iNum%>]="<%=sDesc%>";
              Tender[<%=iNum%>]="<%=sTender%>"; Tot[<%=iNum%>]="<%=sTotRet%>";TaxReq[<%=iNum%>]="<%=sTaxReq%>";
              RefTyGood[<%=iNum%>]="<%=sRefTyGood%>";
            </script>
          </tr>
          <%iNum++;%>
      <%}%>
      <!---------------------------------------------------------------------->
      <!----------  Total                             ------------------------>
      <!---------------------------------------------------------------------->
      <%
      rmalst.getTotal();
      String sExtRet = rmalst.getExtRet();
      String sTotQty = rmalst.getTotQty();
      String sShip = rmalst.getShip();
      String sTax = rmalst.getTax();
      String sTotRet = rmalst.getTotRet();
      %>
      <tr  class="DataTable" onmouseover="mouseOver(this)" onmouseout="mouseOut(this)">
          <td class="DataTable2">Total</td>
          <td class="DataTable2">&nbsp;</td>
          <td class="DataTable2">&nbsp;</td>
          <td class="DataTable2">&nbsp;</td>
          <td class="DataTable2">&nbsp;</td>
          <td class="DataTable2">&nbsp;</td>

          <td class="DataTable2"><%=sTotQty%></td>
          <td class="DataTable2">$<%=sExtRet%></td>
          <td class="DataTable2">&nbsp;</td>
          <td class="DataTable2">$<%=sShip%></td>
          <td class="DataTable2">$<%=sTax%></td>
          <td class="DataTable2">$<%=sTotRet%></td>

          <td class="DataTable2">&nbsp;</td>
          <td class="DataTable2">&nbsp;</td>
          <td class="DataTable2">&nbsp;</td>
          <td class="DataTable2">&nbsp;</td>
      </tr>

      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
  <p align=left >
    <span style="color:red;">*</span> - Tax is requered for this purchase
    <br><span style="background:pink;">0012345678</span> - Refund Type is incorrect.
  <p align=left>
      <table border=1  cellPadding="0"  cellSpacing="0" style="background:lemonchiffon;font-size:11px">
       <tr><th>&nbsp; Tender&nbsp;</th><th>Description</th></tr>
       <tr><td style="text-align:center">T38</td><td>E-COMM: PAYPAL REFUND</td></tr>
       <tr><td style="text-align:center">T44</td><td>E-COMM: SHOPATRON REFUND</td></tr>
       <tr><td style="text-align:center">T68</td><td>ECOM ON-LINE GIFT CARD</td></tr>
       <tr><td style="text-align:center">T80</td><td>CASH REFUND</td></tr>
       <tr><td style="text-align:center">T88</td><td>RETURN-MAIL CHECK</td></tr>
       <tr><td style="text-align:center">T90</td><td>VISA REFUND</td></tr>
       <tr><td style="text-align:center">T91</td><td>MASTERCARD REFUND</td></tr>
       <tr><td style="text-align:center">T92</td><td>DISCOVER REFUND</td></tr>
       <tr><td style="text-align:center">T93</td><td>RETURN-DINERS REFUND</td></tr>
       <tr><td style="text-align:center">T94</td><td>AMEX REFUND</td></tr>
   </table>

     </td>
   </tr>

  </table>
 </body>
</html>
<%
    rmalst.disconnect();
    rmalst = null;
%>
<%}%>