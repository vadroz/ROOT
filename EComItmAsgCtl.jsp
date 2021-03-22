<%@ page import="ecommerce.EComItmAsgCtl, inventoryreports.PiCalendar"%>
<%
    String [] sStatus = request.getParameterValues("Sts");
    String sStsFrDate = request.getParameter("StsFrDate");
    String sStsToDate = request.getParameter("StsToDate");
    String sSort = request.getParameter("Sort");
    String sTop = request.getParameter("Top");
    String sSelSku = request.getParameter("Sku");
    String sSelOrd = request.getParameter("Ord");
    String sSelOrdSts = request.getParameter("OrdSts");

    if(sSort==null) sSort = "ORD";
    if(sTop==null) sTop = "0";
    if(sSelSku==null){sSelSku=" ";}
    if(sSelOrd==null){sSelOrd=" ";}
    if(sSelOrdSts==null){sSelOrdSts="1";}
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null && session.getAttribute("ECOMSECURE")!=null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComItmAsgCtl.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    String sAuthStr = session.getAttribute("STORE").toString().trim();
    String sUser = session.getAttribute("USER").toString();
    EComItmAsgCtl itmasgn = new EComItmAsgCtl(sStatus, sStsFrDate, sStsToDate
           , sSelSku, sSelOrd, sSelOrdSts, sSort, sUser);

    int iNumOfItm = itmasgn.getNumOfItm();
    int iNumOfStr = itmasgn.getNumOfStr();
    String [] sStr = itmasgn.getStr();
    String sStrJsa = itmasgn.getStrJsa();

    // authorized to changed assign store and notes
    boolean bAssign = sAuthStr.equals("ALL");
    // authorized to changed send str and notes
    boolean bSend = !sAuthStr.equals("ALL");

    String sStrAllowed = session.getAttribute("STORE").toString();
    String sPrinter = "QPRINT4";
    if(!sStrAllowed.equals("ALL"))
    {
       sPrinter = "S" + sStrAllowed + "OUTQ";
    }

    // get PI Calendar
    PiCalendar setcal = new PiCalendar();
    String sYear = setcal.getYear();
    String sMonth = setcal.getMonth();
    String sMonName = setcal.getDesc();
    setcal.disconnect();
%>
<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:green; font-size:10px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}

        table.DataTable { font-size:10px }

        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px;
                       padding-bottom:3px; text-align:center; font-size:11px; text-decoration: underline;}

        tr.DataTable0 { background: #E7E7E7; font-size:12px }
        tr.DataTable1 { background: yellow; font-size:12px }
        tr.DataTable2 { background: darkred; font-size:1px}
        tr.DataTable3 { background: LemonChiffon; font-size:12px}

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTableC { cursor:hand; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable1C { cursor:hand;  padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable2C { cursor:hand; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        .Small {font-size:10px }
        .btnSmall {font-size:8px; display:none;}
        .Medium {font-size:12px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:50; background-color:LemonChiffon; z-index:20;
              text-align:center; vertical-align:top; font-size:10px}

        div.dvAvail { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:50; background-color:LemonChiffon; z-index:10;
              text-align:center; vertical-align:top; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

</style>


<script name="javascript1.2">
//==============================================================================
// Global variables
//==============================================================================
var Sts = new Array();
<%for(int i=0; i < sStatus.length; i++){%>Sts[<%=i%>]= "<%=sStatus[i]%>";<%}%>
var StsFrDate = "<%=sStsFrDate%>"
var StsToDate = "<%=sStsToDate%>"
var SelOrd = "<%=sSelOrd%>";
var SelOrdSts = "<%=sSelOrdSts%>";

var NumOfItm = <%=iNumOfItm%>;

var SelObj = null;
var ChgOrder = new Array(NumOfItm);

var StrAllowed = "<%=sStrAllowed%>";

var PiYear = [<%=sYear%>];
var PiMonth = [<%=sMonth%>];
var PiDesc =  [<%=sMonName%>];

var ShipLessReq = false;
var Top = "<%=sTop%>";

document.onkeyup=catchEscape

var ReasgFromStr = "0";
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvAvail"]);
   foldColmn("cellFold1");
   foldColmn("cellFold2");
   window.scroll(0, Top);
}
//==============================================================================
// run on loading
//==============================================================================
function catchEscape()
{
   var key = window.event
   if (key.keyCode=="27"){ hidePanel(); }
}
//==============================================================================
// set selected Quantity
//==============================================================================
function setQtySel(site, ord, sku, str, sts, qty, asgqty,availqty,  action)
{
  //var pos = getPosition(SelObj);

  var hdr = "Assign Order: " + ord + " &nbsp; SKU: " + sku;
  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();hidePanel1();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popQtySel(site, ord, sku, str, sts, qty, asgqty,availqty,  action)
     + "</td></tr>"
   + "</table>"

  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 450;
  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
  document.all.dvItem.style.visibility = "visible";

  // populate quantity
  if(sts != "Sold Out" && sts != "Resolve") {popQtyFld(qty, asgqty, availqty, sts, action);}
}
//==============================================================================
// populate quantity and status change panel
//==============================================================================
function popQtySel(site, ord, sku, str, sts, qty, asgqty,availqty,  action)
{
   var qtynm = "Assign Qty: ";

   var panel = "<table cellPadding='0' cellSpacing='0'>"
    + "<tr>"
      + "<td nowrap class='Medium' style='font-weight:bold' colspan=2>Store: " + str + "</td>"
    + "</tr>"

    if(sts!="Sold Out" && sts!="Resolve")
    {
       panel += "<tr>"
         + "<td nowrap class='Small'>" + qtynm + "</td>"
         + "<td nowrap><select class='Small' id='selQty'></select></td>"
        + "</tr>"
    }

    if(sts == "Resolve")
    {
       panel += "<tr>"
           + "<td nowrap class='Small'>CNF or Ship</td>"
           + "<td nowrap>"
              + "<input class='Small' type='radio' onclick='setRslvTy(&#34;0&#34;)' name='RslvTy' value='SHIP'>Ship &nbsp; &nbsp;"
              + "<input class='Small' type='radio' onclick='setRslvTy(&#34;1&#34;)' name='RslvTy' value='CNF'>CNF"
           + "</td>"
          + "</tr>"
    }

  if(sts == "Shipped" || sts == 'Resolve')
  {
      panel += "<tr>"
           + "<td nowrap class='Small'>Reason: </td>"
           + "<td nowrap class='Small'>"
              + "<select class='Small' name='Reason'>"
                 + "<option value='None'>-- select resolution type --</option>"
              + "</select>"
           + "</td>"
        + "</tr>"
  }

  panel += "<tr>"
       + "<td nowrap class='Small'>Comment: </td>"
       + "<td nowrap class='Small'><TextArea class='Small' id='txaNote' cols=30 rows=3></TextArea></td>"
    + "</tr>"

    + "<tr>"
       + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
    + "</tr>"

    + "<tr>"
         + "<td nowrap class='Small'><button onClick='ValidateStrPickSendQty("
            + "&#34;" + site + "&#34;,&#34;" + ord + "&#34;,&#34;" + sku + "&#34;"
            + ",&#34;" + str + "&#34;"
            + ",&#34;" + sts + "&#34;"
            + ",&#34;" + qty + "&#34;"
            + ",&#34;" + asgqty + "&#34;"
            + ",&#34;" + availqty + "&#34;"
            + ",&#34;" + action + "&#34;)' class='Small'>Submit</button>"
       + "<button onClick='hidePanel(); hidePanel1();' class='Small'>Cancel</button>"
    + "</td></tr></table>"
   return panel;
}
//==============================================================================
// populate quantity
//==============================================================================
function popQtyFld(ordqty, asgqty, availqty, sts, action)
{
   var max = eval(asgqty);
   var asg = null;
   if(sts == "Assigned"){ max = eval(ordqty); }

   if(availqty < asgqty){ max = availqty; }


   for(var i=0; i <= max; i++) {  document.all.selQty.options[i] = new Option(i,i) }
}
//==============================================================================
// set resolve problem reason
//==============================================================================
function setRslvTy(type)
{
   var rslvty = document.all.Reason;
   for(var i=rslvty.length-1; i >= 0; i-- )
   {
      rslvty.options[i]=null;
   }

   if(type == "0")
   {
       rslvty.options[0] = new Option("Completed","Completed");
   }
   else
   {
     rslvty.options[0] = new Option("-- select reason --","None");
     rslvty.options[1] = new Option("Cannot Locate","Cannot Locate");
     rslvty.options[2] = new Option("RTV","RTV");
     rslvty.options[3] = new Option("Soiled/Damaged","Soiled/Damaged");
     rslvty.options[4] = new Option("Missing Pieces","Missing Pieces");
   }
}
//==============================================================================
// validate assigned send  and
//==============================================================================
function ValidateStrPickSendQty(site,ord,sku,str,sts,currqty,asgqty,availqty,action)
{
    var error = false;
    var msg = "";
    document.all.tdError.innerHTML="";

    var qty = "0";
    if(sts!="Sold Out" && sts != "Resolve")
    {
       qty = document.all.selQty.options[document.all.selQty.selectedIndex].value;
       if(qty == asgqty){error = true; msg += "<br>You did not change current quantity";}
    }

    var rslvty = "";
    var rslvtyobj = document.all.RslvTy;
    if(sts == "Resolve")
    {
       for(var i=0; i < rslvtyobj.length; i++)
       {
          if( rslvtyobj[i].checked ){ rslvty = rslvtyobj[i].value; break;}
       }
       if(rslvty==""){ error = true; msg += "<br>Please, check resolution type - Ship or CNF"; }
    }

    var emp = "SAME";

    var reas = " ";
    if(sts == "Resolve" && rslvty == "CNF")
    {
       var reas  = document.all.Reason.options[document.all.Reason.selectedIndex].value;
       if(document.all.Reason.selectedIndex == 0 ){error = true; msg += "<br>Please select reason."; }
    }


    var note = document.all.txaNote.value.trim();
    if(sts == "Resolve" && note == ""){error = true; msg += "<br>Please type resolution.";}
    else if(note == "" && qty < asgqty){error = true; msg += "<br>Please explain why you decrease assigned quantity.";}

    ShipLessReq = qty < asgqty && sts == "Shipped";

    if(error){ document.all.tdError.innerHTML=msg; }
    else{ sbmStrPickSendQty(site, ord, sku, str, sts, qty, emp, reas, note,rslvty, action); }
}

//==============================================================================
// quick complete shipment
//==============================================================================
function setCompl(site, ord, sku)
{
  var hdr = "Assign Order: " + ord + " &nbsp; SKU: " + sku;
  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popCompl(site, ord, sku)
     + "</td></tr>"
   + "</table>"

  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 400;
  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
  document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate quick complete shipment
//==============================================================================
function popCompl(site, ord, sku)
{
   var qtynm = "Shipped Qty: ";

   var panel = "<table cellPadding='0' cellSpacing='0'>"

    panel += "<tr>"
         + "<td nowrap class='Small'>" + qtynm + "</td>"
         + "<td nowrap><input class='Small' id='ShpQty' size='5' maxlength='5'></td>"
        + "</tr>"

  panel += "<tr>"
       + "<td nowrap class='Small'>Store: </td>"
       + "<td nowrap class='Small'><input class='Small' id='Str' size='2' maxlength='2'></td>"
    + "</tr>"

    + "<tr>"
       + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
    + "</tr>"

    + "<tr>"
         + "<td nowrap class='Small'><button onClick='vldCompl("
            + "&#34;" + site + "&#34;,&#34;" + ord + "&#34;,&#34;" + sku
            + "&#34;)' class='Small'>Submit</button>"
       + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
    + "</td></tr></table>"
   return panel;
}
//==============================================================================
// validate quick completion
//==============================================================================
function vldCompl(site, ord, sku)
{
    var error = false;
    var msg = "";
    document.all.tdError.innerHTML="";

    var qty = "0";
    qty = document.all.ShpQty.value.trim();
    if(qty == ""){error = true; msg += "<br>Please, enter quantity";}
    else if(isNaN(qty)){error = true; msg += "<br>Please, enter numeric value";}
    else if(eval(qty) <= 0 ){error = true; msg += "<br>Quantity must be positive number";}

    var str = "0";
    str = document.all.Str.value.trim();
    if(str == ""){error = true; msg += "<br>Please, enter quantity";}
    else if(isNaN(str)){error = true; msg += "<br>Please, enter numeric value";}
    else if(eval(str) <= 0 ){error = true; msg += "<br>Store must be positive number";}

    var emp = "SAME";

    var reas = "Completed";
    var note = "The quick completion";

    if(error){ document.all.tdError.innerHTML=msg; }
    else{ sbmStrPickSendQty(site, ord, sku, str, "Shipped", qty, emp, reas, note, "", "QUICKSHIP"); }
}
//==============================================================================
// submit store status changes
//==============================================================================
function sbmStrPickSendQty(site,ord,sku,str, sts, qty, emp, reas, note, rslvty, action)
{
    note = note.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmStrSts"

    var html = "<form name='frmChgStrSts'"
       + " METHOD=Post ACTION='EComItmAsgSave.jsp'>"
       + "<input name='Site'>"
       + "<input name='Order'>"
       + "<input name='Sku'>"
       + "<input name='Str'>"
       + "<input name='FromStr'>"
       + "<input name='Sts'>"
       + "<input name='Qty'>"
       + "<input name='Emp'>"
       + "<input name='Note'>"
       + "<input name='Excl'>"
       + "<input name='Reas'>"
       + "<input name='Action'>"
     html += "</form>"

   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Site.value = site;
   window.frame1.document.all.Order.value = ord;
   window.frame1.document.all.Sku.value = sku;
   window.frame1.document.all.Str.value = str;
   window.frame1.document.all.FromStr.value = ReasgFromStr;
   window.frame1.document.all.Sts.value = sts + rslvty;
   window.frame1.document.all.Qty.value = qty;
   window.frame1.document.all.Emp.value = emp;

   if(rslvty == "CNF"){ window.frame1.document.all.Excl.value = "Y"; }
   else { window.frame1.document.all.Excl.value = "N"; }
   window.frame1.document.all.Reas.value = reas;

   window.frame1.document.all.Note.value = "<REASON>" + reas + "</REASON>" + note;
   window.frame1.document.all.Action.value=action;

   window.frame1.document.frmChgStrSts.submit();
}
//==============================================================================
// set Note Text Area
//==============================================================================
function setNote(site, ord, sku, str, text, action, obj)
{
  SelObj = obj;

  var pos = getPosition(obj);
  var html = "<table cellPadding='0' cellSpacing='0'>"
    + "<tr>"
       + "<td nowrap>Note: <TextArea class='Small' id='txaNote' cols=30 rows=3></TextArea></td>"
    + "</tr>"
    + "<tr>"
       + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
    + "</tr>"

    + "<tr>"
       + "<td nowrap><button onClick='ValidateNote("
         + "&#34;" + site + "&#34;,&#34;" + ord + "&#34;,&#34;" + sku + "&#34;"
         + ",&#34;" + str + "&#34;"
         + ",&#34;" + action + "&#34;"
         + ")' class='Small'>Chg</button>"
         + "<button onClick='hidePanel();' class='Small'>Close</button>"
    + "</td></tr></table>"

  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft= pos[0];
  document.all.dvItem.style.pixelTop= pos[1];
  document.all.dvItem.style.visibility = "visible";

  // populate note
  document.all.txaNote.value = text;
}
//==============================================================================
// validate assigned send  and
//==============================================================================
function ValidateNote(site,ord,sku,str,action)
{
    var error = false;
    var msg = "";
    document.all.tdError.innerHTML="";

    var note = document.all.txaNote.value.trim();
    if(note==""){error = true; msg += "Please enter note."; }

    if(error){ document.all.tdError.innerHTML=msg; }
    else{ sbmNote(site, ord, sku, str, note, action); }
}
//==============================================================================
// submit store status changes
//==============================================================================
function sbmNote(site, ord, sku, str, note, action)
{
    note = note.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmStrSts"

    var html = "<form name='frmChgStrSts'"
       + " METHOD=Post ACTION='EComItmAsgSave.jsp'>"
       + "<input name='Site'>"
       + "<input name='Order'>"
       + "<input name='Sku'>"
       + "<input name='Str'>"
       + "<input name='Note'>"
       + "<input name='Action'>"
     html += "</form>"

   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Site.value = site;
   window.frame1.document.all.Order.value = ord;
   window.frame1.document.all.Sku.value = sku;
   window.frame1.document.all.Str.value = str;
   window.frame1.document.all.Note.value = note;
   window.frame1.document.all.Action.value=action;

   window.frame1.document.frmChgStrSts.submit();
}
//==============================================================================
// set Mail Tracking ID
//==============================================================================
function setMail(site, ord, sku, str, text, action, obj)
{
  SelObj = obj;

  var pos = getPosition(obj);
  var html = "<table cellPadding='0' cellSpacing='0'>"
    + "<tr>"
       + "<td nowrap>Mail #: <input class='Small' id='inpMail' size=30 maxlength=30></td>"
    + "</tr>"
    + "<tr>"
       + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
    + "</tr>"

    + "<tr>"
       + "<td nowrap><button onClick='ValidateMail("
         + "&#34;" + site + "&#34;,&#34;" + ord + "&#34;,&#34;" + sku + "&#34;"
         + ",&#34;" + str + "&#34;"
         + ",&#34;" + action + "&#34;"
         + ")' class='Small'>Chg</button>"
         + "<button onClick='hidePanel();' class='Small'>Close</button>"
    + "</td></tr></table>"

  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft= pos[0];
  document.all.dvItem.style.pixelTop= pos[1];
  document.all.dvItem.style.visibility = "visible";

  // populate quantity
  document.all.inpMail.value = text;
}
//==============================================================================
// validate assigned send  and
//==============================================================================
function ValidateMail(site,ord,sku,str,action)
{
    var error = false;
    var msg = "";
    document.all.tdError.innerHTML="";

    var note = document.all.inpMail.value.trim();
    if(note==""){error = true; msg += "Please enter mail number."; }

    if(error){ document.all.tdError.innerHTML=msg; }
    else{ sbmMail(site, ord, sku, str, note, action); }
}
//==============================================================================
// submit store status changes
//==============================================================================
function sbmMail(site, ord, sku, str, note, action)
{
    note = note.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmStrSts"

    var html = "<form name='frmChgStrSts'"
       + " METHOD=Post ACTION='EComItmAsgSave.jsp'>"
       + "<input name='Site'>"
       + "<input name='Order'>"
       + "<input name='Sku'>"
       + "<input name='Str'>"
       + "<input name='Note'>"
       + "<input name='Action'>"
     html += "</form>"

   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Site.value = site;
   window.frame1.document.all.Order.value = ord;
   window.frame1.document.all.Sku.value = sku;
   window.frame1.document.all.Str.value = str;
   window.frame1.document.all.Note.value = note;
   window.frame1.document.all.Action.value=action;

   window.frame1.document.frmChgStrSts.submit();
}
//==============================================================================
// set selected Quantity
//==============================================================================
function setStatus(site, ord, sku, sts, strsts, obj)
{
  SelObj = obj;
  var hdr = "Cancel Order: " + ord + " &nbsp; SKU: " + sku ;
  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popStsPnl(site, ord, sku, sts, strsts)
     + "</td></tr>"
   + "</table>"

  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 400;
  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
  document.all.dvItem.style.visibility = "visible";

  // populate quantity
  popStatus(site, ord, sku, sts, strsts);
}
//==============================================================================
// populate status panel
//==============================================================================
function popStsPnl(site, ord, sku, sts, strsts)
{
  var panel = "<table cellPadding='0' cellSpacing='0'>"
    + "<tr>"
       + "<td nowrap class='Small'>Status: </td>"
       + "<td nowrap class='Small'><select class='Small' id='selSts'></select></td>"
    + "</tr>"

    + "<tr>"
       + "<td nowrap class='Small'>Comment: </td>"
       + "<td nowrap class='Small'><TextArea class='Small' id='txaNote' cols=30 rows=3></TextArea></td>"
    + "</tr>"

    + "<tr>"
       + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
    + "</tr>"

    + "<tr>"
       + "<td nowrap class='Small'><button onClick='ValidateSts(&#34;" + site + "&#34;,&#34;" + ord + "&#34;,&#34;" + sku + "&#34;)' class='Small'>Submit</button>"
       + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
    + "</td></tr></table>"
   return panel;
}
//==============================================================================
// populate quantity
//==============================================================================
function popStatus(site, ord, sku, sts, strsts)
{
   var sel = document.all.selSts;
   var aSts = new Array();

   if(sts == "Open"){ aSts = ["Cancelled"]; }
   else if(sts == "Assigned")
   {
      for(var i=0; i < strsts.length; i++)
      {
         if(strsts[i] == "Shipped" || strsts[i] == "partially Shipped"){ aSts[0] = ["Partially Shipped"]; }
      }
      if(aSts.length == 0){ aSts[0] = [ "Cancelled" ]; }
   }
   else if(sts == "Partially Shipped"){ aSts = ["Assigned", "Cancelled"]; }
   else if(sts == "Cancelled"){ aSts = ["Open"]; }

   for(var i=0; i < aSts.length; i++)
   {
     sel.options[i] = new Option(aSts[i], aSts[i]); }
   }

//==============================================================================
// validate store status changes
//==============================================================================
function ValidateSts(site,ord,sku)
{
    var error = false;
    var msg = "";
    document.all.tdError.innerHTML="";

    var sts = document.all.selSts.options[document.all.selSts.selectedIndex].value;
    var emp = 0;

    var note = document.all.txaNote.value.trim();
    if(note==""){error = true; msg += "<br>Please enter note to explain statsus changes."; }

    if(error){ document.all.tdError.innerHTML=msg; }
    else{ sbmSts(site,ord,sku, sts, emp, note); }
}
//==============================================================================
// submit store status changes
//==============================================================================
function sbmSts(site,ord,sku, sts, emp, note)
{
    note = note.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmStrSts"

    var html = "<form name='frmChgStrSts'"
       + " METHOD=Post ACTION='EComItmAsgSave.jsp'>"
       + "<input name='Site'>"
       + "<input name='Order'>"
       + "<input name='Sku'>"
       + "<input name='Sts'>"
       + "<input name='Emp'>"
       + "<input name='Note'>"
       + "<input name='Action'>"
     html += "</form>"

   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Site.value = site;
   window.frame1.document.all.Order.value = ord;
   window.frame1.document.all.Sku.value = sku;
   window.frame1.document.all.Sts.value = sts;
   window.frame1.document.all.Emp.value = emp;
   window.frame1.document.all.Note.value = note;
   window.frame1.document.all.Action.value="CHGSTS";

   window.frame1.document.frmChgStrSts.submit();
}

//==============================================================================
// retreive comment for selected store
//==============================================================================
function getStrCommt(site, ord, sku)
{
   url = "EComItmAsgCommt.jsp?"
      + "Site=" + site
      + "&Order=" + ord
      + "&Sku=" + sku
      + "&Str=0"
      + "&Action=GETSTRCMMT"

   window.frame1.location.href = url;
}
//==============================================================================
// display comment for selected store
//==============================================================================
function showComments(site, ord, sku, str, type,emp, commt, recusr, recdt, rectm)
{
   var hdr = "Comments. Order: " + ord + " &nbsp; SKU: " + sku ;
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel1();' alt='Close'>"
       + "</td></tr>"
     + "<tr><td class='Prompt' colspan=2>" + popComment(site, ord, sku, str, type,emp, commt, recusr, recdt, rectm)
       + "</td></tr>"
     + "</table>"

  document.all.dvAvail.style.width=500;
  document.all.dvAvail.innerHTML = html;
  document.all.dvAvail.style.pixelLeft=document.documentElement.scrollLeft + 50;
  document.all.dvAvail.style.pixelTop=document.documentElement.scrollTop + 100;
  document.all.dvAvail.style.visibility = "visible";

}
//==============================================================================
// populate panel
//==============================================================================
function popComment(site, ord, sku, str, type,emp, commt, recusr, recdt, rectm)
{
   var panel = "<table border=1 style='font-size:12px' cellPadding='0' cellSpacing='0' width='100%'>"
    + "<tr style='background:#FFCC99'>"
       + "<th>Type</th>"
       + "<th>Store</th>"
       + "<th nowrap>Emp #</th>"
       + "<th>Comment</th>"
       + "<th>Recorded by</th>"
    + "</tr>"
   for(var i=0; i < commt.length; i++)
   {
      panel += "<tr>"
        + "<td nowrap>" + type[i] + "</td>"
      if(str[i] != "0") { panel += "<td style='text-align:right' nowrap>" + str[i] + "&nbsp;</td>" }
      else{ html += "<td style='text-align:right' nowrap>H.O.&nbsp;</td>" }

      panel += "<td nowrap>&nbsp;" + emp[i] + "</td>"
        + "<td>" + commt[i] + "</td>"
        + "<td nowrap>" + recusr[i] + " " + recdt[i] + " " + rectm[i] + "</td>"
   }
   panel += "<tr>"
    + "<td nowrap class='Small' style='text-align:center' colspan=5>"
       + "<button onClick='hidePanel1();' class='Small'>Close</button>"
    + "</td></tr></table>"

   return panel;
}
//==============================================================================
// display return error from save process
//==============================================================================
function rtnWithError(err)
{
   document.all.tdError.innerHTML = "";
   var br = "";
   for(var i=0; i < err.length; i++)
   {
      document.all.tdError.innerHTML = br + err[i];
      br = "<br>";
   }
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
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
   SelObj = null;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel1()
{
   document.all.dvAvail.innerHTML = " ";
   document.all.dvAvail.style.visibility = "hidden";
}
//==============================================================================
// resort table
//==============================================================================
function resort(sort)
{
  url = "EComItmAsgCtl.jsp?Sort=" + sort
  for(var i=0; i < Sts.length;  i++)
  {
     url += "&Sts=" + Sts[i];
  }
  url += "&StsFrDate=" + StsFrDate;
  url += "&StsToDate=" + StsToDate;

  window.location.href=url;
}
//==============================================================================
// reload page
//==============================================================================
function restart()
{
  url = "EComItmAsgCtl.jsp?Sort=<%=sSort%>"

  for(var i=0; i < Sts.length;  i++)
  {
     url += "&Sts=" + Sts[i];
  }
  url += "&StsFrDate=" + StsFrDate;
  url += "&StsToDate=" + StsToDate;

  var pos = [0,0];
  if(SelObj != null)
  {
     pos = getPosition(SelObj);
     pos[1] -= 2
  }

  url += "&Top=" + pos[1];
  url += "&Ord=" + SelOrd
       + "&OrdSts=" + SelOrdSts

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// show error
//==============================================================================
function showError(err)
{
   var text = "";
   for(var i=0; i < err.length; i++){ text += "\n" + err[i]; }
   alert(text);
}
//==============================================================================
// update store quantity cell
//==============================================================================
function updStrProp(sku, sts, qty, action)
{
   SelObj.innerHTML = sts;
   SelObj.style.backgroundColor = "yellow";
   hidePanel();
}
//==============================================================================
// update store quantity cell
//==============================================================================
function updStsProp(sts, action)
{
   SelObj.innerHTML = sts;
   SelObj.style.backgroundColor = "yellow";
   hidePanel();
}
//==============================================================================
// re-use frame
//==============================================================================
function reuseFrame()
{
  window.frame1.close();
}
//==============================================================================
// print pick slip
//==============================================================================
function prtPackSlip(site, ord, str, printer, outq, outqlib, whsOrStr, str)
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
//==============================================================================
// set selected Quantity
//==============================================================================
function setStrSts(site, ord, sku, str, sts, obj)
{
  SelObj = obj;

  var pos = getPosition(obj);

  var html = "<table cellPadding='0' cellSpacing='0'>"
    + "<tr>"
       + "<td nowrap class='Small'>Status: </td>"
       + "<td nowrap class='Small'><select class='Small' id='selSts'></select></td>"
    + "</tr>"
    + "<tr>"
       + "<td nowrap class='Small'>Employee Number: </td>"
       + "<td nowrap class='Small'><input class='Small' id='Emp' size=4 maxlength=4></td>"
    + "</tr>"
    + "<tr>"
       + "<td nowrap class='Small'>Comment: </td>"
       + "<td nowrap class='Small'><TextArea class='Small' id='txaNote' cols=30 rows=3></TextArea></td>"
    + "</tr>"

    + "<tr>"
       + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
    + "</tr>"

    + "<tr>"
         + "<td nowrap class='Small'><button onClick='ValidateStrSts(&#34;" + site + "&#34;,&#34;" + ord + "&#34;,&#34;" + sku + "&#34;,&#34;" + str + "&#34;)' class='Small'>Chg</button>"
       + "<button onClick='hidePanel();' class='Small'>Close</button>"
    + "</td></tr></table>"

  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft= pos[0];
  document.all.dvItem.style.pixelTop= pos[1];
  document.all.dvItem.style.visibility = "visible";

  // populate quantity
  document.all.selSts.options[0] = new Option(sts, sts);
}
//==============================================================================
// validate store status changes
//==============================================================================
function ValidateStrSts(site,ord,sku,str)
{
    var error = false;
    var msg = "";
    document.all.tdError.innerHTML="";

    var aord = new Array();
    var asite = new Array();
    if(ord=="MARKED")
    {
       for(var i=0; i < NumOfItm; i++)
       {
          var ordnm = "PrtGrp" + i
          var sitenm = "PrtSite" + i
          if(document.all[ordnm] != null)
          {
            if(document.all[ordnm].checked)
            {
               aord[aord.length] = document.all[ordnm].value;
               asite[asite.length] = document.all[sitenm].value;
            }
          }
       }
       if(aord.length == 0){ error = true; msg += "<br>At least one order mast be marked for print."; }
    }

    var sts = document.all.selSts.options[document.all.selSts.selectedIndex].value;
    var emp = document.all.Emp.value.trim();
    if(emp==""){error = true; msg += "<br>Please enter your employee number"; }
    else if(isNaN(emp)){error = true; msg += "<br>The employee number is not numeric"; }

    var note = document.all.txaNote.value.trim();

    if(error){ document.all.tdError.innerHTML=msg; }
    else{ sbmStrSts(site,ord,sku,str, sts, emp, note, asite, aord); }
}
//==============================================================================
// submit store status changes
//==============================================================================
function sbmStrSts(site,ord,sku,str, sts, emp, note, asite, aord)
{
    note = note.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmStrSts"

    var html = "<form name='frmChgStrSts'"
       + " METHOD=Post ACTION='EComItmAsgSave.jsp'>"
       + "<input name='Site'>"
       + "<input name='Order'>"
       + "<input name='Sku'>"
       + "<input name='Str'>"
       + "<input name='Sts'>"
       + "<input name='Emp'>"
       + "<input name='Note'>"
       + "<input name='Action'>"

     for(var i=0; i < aord.length ;i++)
     {
        html += "<input name='OrdL'>";
        html += "<input name='SiteL'>";
     }

     html += "</form>"

   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Site.value = site;
   window.frame1.document.all.Order.value = ord;
   window.frame1.document.all.Sku.value = sku;
   window.frame1.document.all.Str.value = str;
   window.frame1.document.all.Sts.value = sts;
   window.frame1.document.all.Emp.value = emp;
   window.frame1.document.all.Note.value = note;
   window.frame1.document.all.Action.value="CHGSTRSTS";

   for(var i=0; i < aord.length ;i++)
   {
      window.frame1.document.all.OrdL[i].value = aord[i];
      window.frame1.document.all.SiteL[i].value = asite[i];
   }
   window.frame1.document.frmChgStrSts.submit();
}
//==============================================================================
// link to Return Validation page
//==============================================================================
function getSlsBySku(sku)
{
   var date = new Date(new Date() - 30 * 86400000);
   var from = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
   date = new Date(new Date() - 86400000);
   var to = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
   var lastPI = PiYear[0] + PiMonth[0];

   url ="PIItmSlsHst.jsp?Sku=" + sku
       + "&SlsOnTop=1"
       + "&STORE=ALL"
       + "&FromDate=" + from
       + "&ToDate=" + to
       + "&PICal=" + lastPI
   //alert(url)
   window.open(url, "_blank");
}
//==============================================================================
// fold/unfold columns
//==============================================================================
function foldColmn(objnm)
{
   var col = document.all[objnm];
   var disp = "none";
   if(col[0].style.display=="none"){ disp = "block"; }
   for(var i=0; i < col.length; i++)
   {
       col[i].style.display = disp;
   }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setExpDt(noexp)
{
   if(noexp.checked) { document.all.spnExpDt.style.display = "none"; }
   else{ document.all.spnExpDt.style.display = "inline"; }
}
//==============================================================================
// populate date with prior aor future dates
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
// hide panel
//==============================================================================
function hidePanel()
{
   document.all.dvItem.innerHTML = "";
   document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
// reset checkbox for order printing
//==============================================================================
function resetPrtMrk()
{
   for(var i=0; i < NumOfItm; i++)
   {
      var objnm = "PrtGrp" + i
      if(document.all[objnm] != null)
      {
        document.all[objnm].checked = false;
      }
   }
}
//==============================================================================
// show available Qty
//==============================================================================
function showAvlQty(site, ord, sku, str, ordqty, avl, asg, sts, totasg, obj, hist)
{
   SelObj = obj;
   //var pos = getPosition(obj);

   var hdr = "Order: " + ord + " &nbsp; SKU: " + sku ;
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popAvlQty(site, ord, sku, str, ordqty, avl, asg, sts, totasg, hist )
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 400;
   document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
   document.all.dvItem.style.width= 200;
   document.all.dvItem.style.visibility = "visible";

   var tdreasg = document.all.tdReasg;
   var tdrasglnk = document.all.tdReasgLnk;
   for(var i=0 ; i < tdreasg.length; i++)
   {
      tdreasg[i].style.display="none"
      <%if(!bAssign){%>tdrasglnk[i].style.display="none"<%}%>
   }


}
//==============================================================================
// populate assign qty panel
//==============================================================================
function popAvlQty(site, ord, sku, str, ordqty, avl, asg, sts, totasg, hist )
{
  var panel = "<table border=1 cellPadding='0' cellSpacing='0' width='100%'>"
    + "<tr class='DataTable0'>"
       + "<th class='DataTable' class='Small'>Store</th>"
       + "<th class='DataTable' class='Small'>Available<br>Qty</th>"
       + "<th class='DataTable' class='Small' id='tdAvl'>Assigned<br>Qty</th>"
       + "<th class='DataTable' class='Small' nowrap>Sku/Str<br>Status</th>"
       + "<th class='DataTable' class='Small' id='tdReasgLnk'>Reassign</th>"
       + "<th class='DataTable' class='Small' id='tdReasg'>Reassign<br>To<br>Str</th>"
    + "</tr>"

    // calculate number of total assigned quantity
    var totAsg = 0;
    for(var i=0; i < str.length; i++)
    {
       if(asg[i] != null && asg[i] != ""){ totAsg += eval(asg[i]); }
    }

    for(var i=0; i < str.length; i++)
    {
      if(avl[i]!="0" || asg[i] != "")
      {
         panel += "<tr class='DataTable0'>"
           + "<td class='DataTable' class='Small'>" + str[i] + "</td>"
           + "<td class='DataTable' id='tdAvl'" + i + "class='Small'>"
         if(eval(ordqty) > totAsg)
         {
            panel += "<a href='javascript: setQtySel(&#34;" + site
                  + "&#34;,&#34;" + ord +  "&#34;, &#34;" + sku
                  + "&#34;, &#34;" + str[i] + "&#34;, &#34;Assigned&#34;, &#34;" + ordqty
                  + "&#34;, &#34;" + asg[i] + "&#34;, &#34;" + avl[i] + "&#34;, &#34;CHGSTRSTS&#34;"
                  + ");'>" + avl[i] + "</a>"
         }
         else {panel += avl[i]; }
         panel += "</td>"
         panel += "<td class='DataTable' class='Small'>&nbsp;" + asg[i] + "&nbsp;</td>"
           + "<td class='DataTable' class='Small' nowrap>&nbsp;" + sts[i] + "&nbsp;</td>"

         var currsts = "";
         var currstr = "";
         if (!hist == "" && hist.indexOf("Assigned") >= 0) { currsts = "Assigned"; currstr= hist.substring(0,2); }
         if (!hist == "" && hist.indexOf("Printed") >= 0) { currsts = "Printed"; currstr= hist.substring(0,2); }
         if (!hist == "" && hist.indexOf("Picked") >= 0) { currsts = "Picked"; currstr= hist.substring(0,2); }
         if (!hist == "" && hist.indexOf("Shipped") >= 0) { currsts = "Shipped"; currstr= hist.substring(0,2); }

         panel += "<td class='DataTable' class='Small' nowrap  id='tdReasgLnk'>&nbsp;"
         if( currsts == sts[i] && sts[i] != "")
         {
            panel += "<a href='javascript: setSelReAsg(&#34;" + str[i] + "&#34;);'>R</a>"
         }
         else {panel += "&nbsp;"; }
         panel += "</td>";


         panel += "<td class='DataTable' class='Small' nowrap id='tdReasg'>&nbsp;"
         if( currsts != sts[i] && sts[i] != "Cannot Fill")
         {
            panel += "<a href='javascript: setQtySel(&#34;" + site
                  + "&#34;,&#34;" + ord +  "&#34;, &#34;" + sku
                  + "&#34;, &#34;" + str[i] + "&#34;, &#34;Assigned&#34;, &#34;" + ordqty
                  + "&#34;, &#34;" + asg[i] + "&#34;, &#34;" + avl[i] + "&#34;, &#34;REASSIGN&#34;"
                  + ");'>" + avl[i] + "</a>"
         }
         else {panel += "&nbsp;"; }
         panel += "</td>";

         panel += "</tr>"
      }
    }

    panel += "<tr class='DataTable0'>"
     + "<td class='DataTable' class='Small' colspan=5>"
       + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
     + "</td></tr></table>"
   return panel;
}
//==============================================================================
// show available items for reasignment
//==============================================================================
function setSelReAsg(str)
{
   ReasgFromStr = str;
   var tdreasg = document.all.tdReasg;
   var tdavl = document.all.tdAvl;
   for(var i=0 ; i < tdreasg.length; i++)
   {
      tdreasg[i].style.display="block";
      tdavl[i].style.display="none";
   }
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvAvail" class="dvAvail"></div>
<!-------------------------------------------------------------------->
<div style="clear: both; overflow: AUTO; width: 100%; height: 100%; POSITION: relative; color:black;">

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin style="z-index: 60; position: relative; top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);">
    <TD vAlign=top align=left><B>Retail Concepts Inc.
        <BR>E-Commerce Store Fulfillments - HO Control
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="EComItmAsgCtlSel.jsp" class="small"><font color="red">Select</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;
        &nbsp;&nbsp;
        <a href="javascript: foldColmn('cellFold1')">fold/unfold order info</a>
        &nbsp; &nbsp; &nbsp; &nbsp;
        <a href="javascript: foldColmn('cellFold2')">fold/unfold item info</a>
        &nbsp; &nbsp; &nbsp; &nbsp;
    </td>
    </tr>
    <TR bgColor=moccasin>
    <TD vAlign=top align=middle colspan=2>
<!-- ======================================================================= -->
       <table border=1 class="DataTable" cellPadding="0" cellSpacing="0">
         <tr class="DataTable" style="z-index: 60; position: relative; top: expression(this.offsetParent.scrollTop - 3);">
             <th class="DataTable"><a href="javascript: resort('ORD')">Order #</a></th>
             <th class="DataTable" id="cellFold1">Order<br>Date</th>
             <th class="DataTable" id="cellFold1">Customer<br>Name</th>
             <th class="DataTable" id="cellFold1">Ship To<br>City/State</th>
             <th class="DataTable"><a href="javascript: resort('SHIP')">Ship Method</a></th>
             <th class="DataTable">Order<br>Status</th>

             <th class="DataTable" id="cellFold2">Div<br>#</th>
             <th class="DataTable" id="cellFold2">Long Item Number</th>
             <th class="DataTable" id="cellFold2">Item<br>Description</th>
             <th class="DataTable" id="cellFold2">Vendor Name</th>
             <th class="DataTable" >SKU</th>
             <th class="DataTable" >UPC</th>
             <th class="DataTable" >Ret</th>
             <th class="DataTable" >SKU<br>Status</th>

             <th class="DataTable">L<br>o<br>g</th>
             <th class="DataTable">Ord<br>Qty</th>
             <th class="DataTable">Total<br>Avail</th>
             <th class="DataTable">Total<br>Asg</th>
             <th class="DataTable">Asg Str<br>/Sts/Date</th>
             <!-- th class="DataTable">C<br>m<br>p<br>l</th -->
             <th class="DataTable">Resolve</th>
             <th class="DataTable">Sold Out</th>
          </tr>
       <!-- ============================ Details =========================== -->
       <%String SvOrd = null;%>
       <%boolean bOrdClr = false;%>
       <%for(int i=0; i < iNumOfItm; i++ )
         {
            itmasgn.setItmList();
            String sOrd = itmasgn.getOrd();
            String sSite = itmasgn.getSite();
            String sOrdSts = itmasgn.getOrdSts();
            String sSku = itmasgn.getSku();
            String sQty = itmasgn.getQty();
            String sPickSts = itmasgn.getPickSts();
            String sPStsDate = itmasgn.getPStsDate();
            String sShipNm = itmasgn.getShipNm();
            String sShipCity = itmasgn.getShipCity();
            String sShipState = itmasgn.getShipState();
            String sShipMeth = itmasgn.getShipMeth();
            String sShipMethNm = itmasgn.getShipMethNm();
            String sOrdDate = itmasgn.getOrdDate();
            String sUpc = itmasgn.getUpc();
            String sDiv = itmasgn.getDiv();
            String sCls = itmasgn.getCls();
            String sVen = itmasgn.getVen();
            String sSty = itmasgn.getSty();
            String sClr = itmasgn.getClr();
            String sSiz = itmasgn.getSiz();
            String sDesc = itmasgn.getDesc();
            String sVenNm = itmasgn.getVenNm();
            String sRet = itmasgn.getRet();
            String [] sAvlQty = itmasgn.getAvlQty();
            String [] sAsgQty = itmasgn.getAsgQty();
            String [] sAsgSts = itmasgn.getAsgSts();
            String [] sAsgDt = itmasgn.getAsgDt();
            int iNumOfHst = itmasgn.getNumOfHst();
            String [] sAsgHst = itmasgn.getAsgHst();
            String sTotAvl = itmasgn.getTotAvl();
            String sTotAsg = itmasgn.getTotAsg();

            String sAvlJsa = itmasgn.cvtToJavaScriptArray(sAvlQty);
            String sAsgJsa = itmasgn.cvtToJavaScriptArray(sAsgQty);
            String sStsJsa = itmasgn.cvtToJavaScriptArray(sAsgSts);

            String sComa = "";

            String sOrdClr = "";
            if (i==0) { SvOrd = sOrd; }
            if(!SvOrd.equals(sOrd)){ bOrdClr = !bOrdClr;}
            if(bOrdClr){ sOrdClr = "#E7E7E7"; }
            else { sOrdClr = "Cornsilk"; }

            boolean bExpedited = sShipMeth.equals("151") || sShipMeth.equals("152")
                              || sShipMeth.equals("153") || sShipMeth.equals("154");
            if (sAsgHst.length == 0){ sAsgHst = new String[]{""}; }
       %>
         <tr class="DataTable0" <%if(!sOrdClr.equals("")){%>style="background:<%=sOrdClr%>"<%}%>>
            <td class="DataTable" nowrap>
               <a href="EComOrdInfo.jsp?Site=<%=sSite%>&Order=<%=sOrd%>" target="_blank"><%=sOrd%></a>
            </td>
            <td class="DataTable1" id="cellFold1" nowrap><%=sOrdDate%></td>
            <td class="DataTable1" id="cellFold1" nowrap><%=sShipNm%></td>
            <td class="DataTable1" id="cellFold1" nowrap><%=sShipCity%>, <%=sShipState%></td>
            <td class="DataTable1" <%if(bExpedited){%>style="font-weight:bold;"<%}%> nowrap><%=sShipMeth%> - <%=sShipMethNm%></td>
            <td class="DataTable1" nowrap><%=sOrdSts%></td>

            <td class="DataTable" id="cellFold2" nowrap><%=sDiv%></td>
            <td class="DataTable" id="cellFold2" nowrap><%=sCls%>-<%=sVen%>-<%=sSty%>-<%=sClr%>-<%=sSiz%></td>
            <td class="DataTable1" id="cellFold2" nowrap><%=sDesc%></td>
            <td class="DataTable1" id="cellFold2" nowrap><%=sVenNm%></td>
            <td class="DataTable2" nowrap><%=sSku%><!--a href="javascript: getSlsBySku(<%=sSku%>)"><%=sSku%></a--></td>
            <td class="DataTable2" nowrap><%=sUpc%></td>
            <td class="DataTable2" nowrap>$<%=sRet%></td>
            <td class="DataTable2" id="tdSts<%=i%>" nowrap>
             <%if(sPickSts.equals("Open")){%><a href="javascript: setStatus('<%=sSite%>' , '<%=sOrd%>', '<%=sSku%>', '<%=sPickSts%>', [<%=sStsJsa%>], document.all.tdSts<%=i%>)"><%=sPickSts%></a>
             <%} else {%>&nbsp;<%}%>
            </td>
            <th class="DataTable" style="vertical-align:middle;" id="thLog<%=i%>">
                <a href="javascript: getStrCommt('<%=sSite%>' , '<%=sOrd%>', '<%=sSku%>');">&nbsp;L&nbsp;</a>
            </th>
            <td class="DataTable2" nowrap><%=sQty%></td>

            <td class="DataTable" id="tdTotAvl<%=i%>" nowrap>
                  <a href="javascript:showAvlQty('<%=sSite%>','<%=sOrd%>','<%=sSku%>',[<%=sStrJsa%>], '<%=sQty%>',[<%=sAvlJsa%>], [<%=sAsgJsa%>], [<%=sStsJsa%>], '<%=sTotAsg%>', document.all.tdTotAvl<%=i%>, '<%=sAsgHst[0]%>')"><%=sTotAvl%></a>
            </td>
            <td class="DataTable" id="tdTotAsg<%=i%>" <%if(!sQty.equals(sTotAsg)){%>style="background:pink"<%}%> nowrap><%=sTotAsg%></td>
            <td class="DataTable1" id="tdStrSts<%=i%>" nowrap>
              <% String sBr = "";
                 for(int j=0; j < iNumOfHst; j++){%>
                   <%=sBr%><%=sAsgHst[j]%><%sBr="<br>";%>
                 <%}%>
              &nbsp;
            </td>

            <!-- Resolve problem -->
            <td class="DataTable1" id="tdStrSts<%=i%>" nowrap>
              <% sBr = "";
                 for(int j=0; j < iNumOfHst; j++){%>
                 <%=sBr%>
                 <%if(j == 0 && !sAsgHst[j].equals("") && sAsgHst[j].indexOf("Problem") >= 0){%>
                   <a href="javascript:
                       getStrCommt('<%=sSite%>' , '<%=sOrd%>', '<%=sSku%>');
                       setQtySel('<%=sSite%>', '<%=sOrd%>', '<%=sSku%>'
                       , '<%=sAsgHst[j].substring(0,2)%>', 'Resolve', '0', '0','0',  'CHGSTRSTS')">Resolve</a>
                 <%}%>
                 &nbsp;
                 <%sBr="<br>";%>
              <%}%>
              &nbsp;
            </td>

            <!-- Sold out -->
            <td class="DataTable1" id="tdStrSts<%=i%>" nowrap>
              <% sBr = "";
                 for(int j=0; j < iNumOfHst; j++){%>
                 <%=sBr%>
                 <%if(j == 0 && !sAsgHst[j].equals("") && sAsgHst[j].indexOf("Sold Out") < 0){%>
                   <a href="javascript:setQtySel('<%=sSite%>', '<%=sOrd%>', '<%=sSku%>'
                       , '<%=sAsgHst[j].substring(0,2)%>', 'Sold Out', '0', '0','0',  'CHGSTRSTS')">Sold Out</a>
                 <%}%>
                 &nbsp;
                 <%sBr="<br>";%>
              <%}%>
              &nbsp;
            </td>


            <!--td class="DataTable1" id="tdStrSts<%=i%>" nowrap>
               <a href="javascript: setCompl('<%=sSite%>', '<%=sOrd%>', '<%=sSku%>')">C</a>
               &nbsp;
            </td -->
          </tr>
          <% SvOrd = sOrd; %>
       <%}%>
     </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</div>
</BODY></HTML>
<%
   itmasgn.disconnect();
   itmasgn = null;
   }
%>