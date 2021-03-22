<!DOCTYPE html>
<%@ page import="ecommerce.EComSrlAsgCtl, inventoryreports.PiCalendar"%>
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
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComSrlAsgCtl.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    String sAuthStr = session.getAttribute("STORE").toString().trim();
    String sUser = session.getAttribute("USER").toString();
    EComSrlAsgCtl itmasgn = new EComSrlAsgCtl(sStatus, sStsFrDate, sStsToDate
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
<meta http-equiv="X-UA-Compatible" content="IE=7">
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:green; font-size:10px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}

        table.TblMainPage {font-size:12px; width:100%; height:100% }
        table.DataTable { font-size:10px }
        

        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px;
                       padding-bottom:3px; text-align:center; font-size:11px; text-decoration: underline;}                       
        th.DataTable2 { padding-top:3px; padding-bottom:3px;text-align:left; vertical-align:top ;font-size:12px}               

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

        td.DataTable1R { background: red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable1Y { background: yellow; padding-top:3px; padding-bottom:3px; padding-left:3px;
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
             

        div.dvAvail { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:50; background-color:LemonChiffon; z-index:10;
              text-align:center; vertical-align:top; font-size:10px}
              
        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}       

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

</style>


<script>
//==============================================================================
// Global variables
//==============================================================================
var Sts = new Array();
<%for(int i=0; i < sStatus.length; i++){%>Sts[<%=i%>]= "<%=sStatus[i]%>";<%}%>
var StsFrDate = "<%=sStsFrDate%>"
var StsToDate = "<%=sStsToDate%>"

var NumOfItm = <%=iNumOfItm%>;

var SelObj = null;
var ChgOrder = new Array(NumOfItm);
var AvlSrn = new Array();

var StrAllowed = "<%=sStrAllowed%>";

var PiYear = [<%=sYear%>];
var PiMonth = [<%=sMonth%>];
var PiDesc =  [<%=sMonName%>];

var ShipLessReq = false;
var Top = "<%=sTop%>";

document.onkeyup=catchEscape

var ReasgFromStr = "0";

var FxHdr = null;
var FxDtl = null;
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvAvail"]);
   foldColmn("cellFold1");
   <%if(!sUser.equals("tcraig") && !sUser.equals("aleigh")){%>foldColmn("cellFold2");<%}%>
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
function setQtySel(site, ord, sku, snid, str, sts, qty, availqty, action, currsts)
{	
  var hdr = "Assign Order: " + ord + " &nbsp; SKU: " + sku;  
  if(sts == null){ hdr = "Order: " + ord + " &nbsp; SKU: " + sku; }
  
  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popQtySel(site, ord, sku, snid, str, sts, qty, availqty,  action)
     + "</td></tr>"
   + "</table>"

  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 400;
  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
  document.all.dvItem.style.visibility = "visible";
  
  setStsList(sts, currsts);
  document.all.trAttr01.style.display="none";
  document.all.trAttr02.style.display="none";
  document.all.trAttr03.style.display="none";
}
//==============================================================================
// populate quantity and status change panel
//==============================================================================
function popQtySel(site, ord, sku, snid, str, sts, qty, availqty,  action)
{
   var qtynm = "Assign Qty: ";

   var panel = "<table cellPadding='0' cellSpacing='0'>"
    + "<tr>"
      + "<td nowrap class='Medium' style='font-weight:bold' colspan=2>Store: " + str + "</td>"
    + "</tr>"
    + "<tr>"
      + "<td nowrap class='Small'>New status: </td>"      
      + "<td nowrap>"
         + "<select class='Small' name='StsSel' onchange='setStsAttr(this)'></select>"
      + "</td>"
    + "</tr>"
   
    
   panel += "<tr id='trAttr01'>"
           + "<td nowrap class='Small'>CNF or Ship</td>"
           + "<td nowrap>"
              + "<input class='Small' type='radio' onclick='setRslvTy(&#34;0&#34;)' name='RslvTy' value='SHIP'>Ship &nbsp; &nbsp;"
              + "<input class='Small' type='radio' onclick='setRslvTy(&#34;1&#34;)' name='RslvTy' value='CNF'>CNF"
           + "</td>"
          + "</tr>"

   panel += "<tr id='trAttr02'>"
           + "<td nowrap class='Small'>Reason: </td>"
           + "<td nowrap class='Small'>"
              + "<select class='Small' id='Reason'>"
                 + "<option value='None'>-- select resolution type --</option>"
              + "</select>"
           + "</td>"
        + "</tr>";
   
   panel += "<tr id='trAttr03'>"
      + "<td nowrap class='Small'>Qty:</td>"
      + "<td nowrap class='Small'>"
         + "<select class='Small' id='NewQty'>"
           + "<option value='0'>0</option>"
           + "<option value='1'>1</option>"
         + "</select>"
      + "</td>"
    + "</tr>";      

  panel += "<tr>"
       + "<td nowrap class='Small'>Comment: </td>"
       + "<td nowrap class='Small'><TextArea class='Small' id='txaNote' cols=30 rows=3></TextArea></td>"
    + "</tr>"

    + "<tr>"
       + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
    + "</tr>"

    + "<tr>"
         + "<td nowrap class='Small' colspan=2><button onClick='ValidateStrPickSendQty("
            + "&#34;" + site + "&#34;,&#34;" + ord + "&#34;,&#34;" + sku + "&#34;"
            + ",&#34;" + snid + "&#34;"
            + ",&#34;" + str + "&#34;"            
            + ",&#34;" + qty + "&#34;"
            + ",&#34;" + availqty + "&#34;"
            + ",&#34;" + action + "&#34;)' class='Small'>Submit</button>"
       + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
    + "</td></tr></table>"
   return panel;
}
//==============================================================================
//set status list 
//==============================================================================
function setStsList(newsts, currsts)
{
	var sts = document.all.StsSel;
	var stslst = ["Assigned","Printed", "Picked", "Problem", "Resolve", "Shipped", "Cannot Fill", "Sold Out","Error" ,"Cancelled"];
	
	for(var i=0, j=0; i < stslst.length;i++)
	{
	   if(currsts == null || stslst[i] !=currsts)
	   {	   
	      sts.options[j] = new Option(stslst[i], stslst[i]);
	      j++;
	   }
	}
	
}
//==============================================================================
// set status attribultes 
//==============================================================================
function setStsAttr(sel)
{
	var sts = sel.options[sel.selectedIndex].value;
	document.all.trAttr01.style.display="none";
	document.all.trAttr02.style.display="none";
	document.all.trAttr03.style.display="none";
	
	if(sts == "Resolve")
	{
		document.all.trAttr01.style.display="block";
		document.all.trAttr02.style.display="block";		
	}
	else if(sts == "Picked")
	{
		document.all.trAttr03.style.display="block";
	}		
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
function ValidateStrPickSendQty(site,ord,sku, snid, str,qty,availqty,action)
{
    var error = false;
    var msg = "";
    document.all.tdError.innerHTML="";

    var srnobj = new Array();
    var sts = document.all.StsSel.options[document.all.StsSel.selectedIndex].value;

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
    
    if(document.all.NewQty != null)
    {
       qty = document.all.NewQty.options[document.all.NewQty.selectedIndex].value;	
    }
    if(sts == "Shipped"){ qty = '1'}
    
    var note = document.all.txaNote.value.trim();
    if(sts == "Resolve" && note == ""){error = true; msg += "<br>Please type resolution.";}

    if(error){ document.all.tdError.innerHTML=msg; }
    else{ sbmStrPickSendQty(site, ord, sku, snid, str, sts, emp, reas, note, rslvty, qty, action); }
}
//==============================================================================
// quick complete shipment
//==============================================================================
function setCompl(site, ord, sku, snid)
{
  var hdr = "Assign Order: " + ord + " &nbsp; SKU: " + sku;
  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popCompl(site, ord, sku, snid)
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
function popCompl(site, ord, sku, snid)
{
   var qtynm = "Shipped Qty: ";

   var panel = "<table cellPadding='0' cellSpacing='0'>"

    panel += "<tr>"
         + "<td nowrap class='Small'>" + qtynm + "</td>"
         + "<td nowrap> &nbsp; 1</td>"
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
            + "&#34;" + site + "&#34;,&#34;" + ord + "&#34;,&#34;" + sku + "&#34;,&#34;" + snid
            + "&#34;)' class='Small'>Submit</button>"
       + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
    + "</td></tr></table>"
   return panel;
}
//==============================================================================
// validate quick completion
//==============================================================================
function vldCompl(site, ord, sku, snid)
{
    var error = false;
    var msg = "";
    document.all.tdError.innerHTML="";

    var qty = "1";

    var str = "0";
    str = document.all.Str.value.trim();
    if(str == ""){error = true; msg += "<br>Please, enter quantity";}
    else if(isNaN(str)){error = true; msg += "<br>Please, enter numeric value";}
    else if(eval(str) <= 0 ){error = true; msg += "<br>Store must be positive number";}

    var emp = "SAME";

    var reas = "Completed";
    var note = "The quick completion";

    if(error){ document.all.tdError.innerHTML=msg; }
    else{ sbmStrPickSendQty(site, ord, sku, snid, str, "Shipped", emp, reas, note, "", "0", "QUICKSHIP"); }
}

//==============================================================================
// submit store status changes
//==============================================================================
function sbmStrPickSendQty(site,ord,sku, snid, str, sts, emp, reas, note, rslvty, qty, action)
{
    note = note.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmStrSts"

    var html = "<form name='frmChgStrSts'"
       + " METHOD=Post ACTION='EComSrlAsgSave.jsp'>"
       + "<input name='Site'>"
       + "<input name='Order'>"
       + "<input name='Sku'>"
       + "<input name='Str'>"
       + "<input name='FromStr'>"
       + "<input name='Sts'>"
       + "<input name='Emp'>"
       + "<input name='Note'>"
       + "<input name='Excl'>"
       + "<input name='Reas'>"
       + "<input name='Action'>"
       + "<input name='Srn'>"
       + "<input name='Qty'>"

     html += "</form>"

   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Site.value = site;
   window.frame1.document.all.Order.value = ord;
   window.frame1.document.all.Sku.value = sku;
   window.frame1.document.all.Srn.value = snid;
   window.frame1.document.all.Str.value = str;
   window.frame1.document.all.FromStr.value = ReasgFromStr;
   window.frame1.document.all.Sts.value = sts + rslvty;;
   window.frame1.document.all.Emp.value = emp;
   window.frame1.document.all.Qty.value = qty;

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
       + " METHOD=Post ACTION='EComSrlAsgSave.jsp'>"
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
       + " METHOD=Post ACTION='EComSrlAsgSave.jsp'>"
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
       + " METHOD=Post ACTION='EComSrlAsgSave.jsp'>"
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
function getStrCommt(site, ord, sku, obj)
{
   SelObj = obj;

   url = "EComSrlAsgCommt.jsp?"
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
function showComments(site, ord, sku, serial, str, type,emp, commt, recusr, recdt, rectm)
{
   var hdr = "Comments. Order: " + ord + " &nbsp; SKU: " + sku ;
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
     + "<tr><td class='Prompt' colspan=2>" + popComment(site, ord, sku, serial, str, type,emp, commt, recusr, recdt, rectm)
       + "</td></tr>"
     + "</table>"

  document.all.dvItem.style.width=700;
  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 200;
  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
  document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate panel
//==============================================================================
function popComment(site, ord, sku, serial, str, type,emp, commt, recusr, recdt, rectm)
{
   var panel = "<table border=1 style='font-size:12px' cellPadding='0' cellSpacing='0' width='100%' id='tblLog'>"
    + "<tr style='background:#FFCC99'>"
       + "<th>S/N</th>"
       + "<th>Type</th>"
       + "<th>Store</th>"
       + "<th nowrap>Emp #</th>"
       + "<th>Comment</th>"
       + "<th>Recorded by</th>"
    + "</tr>"
   for(var i=0; i < commt.length; i++)
   {
      panel += "<tr><td nowrap>" + serial[i] + "</td>"
      panel += "<td nowrap>" + type[i] + "</td>"

      if(str[i] != "0") { panel += "<td style='text-align:right' nowrap>" + str[i] + "&nbsp;</td>" }
      else{ panel += "<td style='text-align:right' nowrap>H.O.&nbsp;</td>" }
      panel += "<td nowrap>&nbsp;" + emp[i] + "</td>"
        + "<td>" + commt[i] + "&nbsp;</td>"
        + "<td nowrap>" + recusr[i] + " " + recdt[i] + " " + rectm[i] + "</td>"
   }

    panel += "</table>"
        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
        + "<button onClick='printLog();' class='Small'>Print</button>"
        
   return panel;
}
//==============================================================================
//open new window with Log 
//==============================================================================
function printLog()
{
	var tbl = document.all.tblLog.outerHTML;
	  var WindowOptions =
	   'width=600,height=500, left=100,top=50, resizable=yes , toolbar=yes, location=yes, directories=no, status=yes, scrollbars=yes,menubar=yes';
	var win = window.open("", "PrintLog", WindowOptions);
	win.document.write(tbl);
	hidePanel();
}

//==============================================================================
//retreive comment for selected store
//==============================================================================
function getFedEx(site, ord, sku)
{	
	url = "EComFedExInfo.jsp?"
	    + "Site=" + site
	    + "&Order=" + ord.replace(/\b0+/g, '') 
	    + "&Action=GETFEDEX";

	window.frame1.location.href = url;
}
//==============================================================================
// show fedex data
//==============================================================================
function showFedEx(fxhdr, fxdtl)
{
	FxHdr = fxhdr;
	FxDtl = fxdtl;
	var hdr = "Federal Express Information. Order: " + fxhdr[0];
	   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popFedEx(fxhdr, fxdtl)
	       + "</td></tr>"
	     + "</table>"

	  document.all.dvItem.style.width=600;
	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 200;
	  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 20;
	  document.all.dvItem.style.visibility = "visible";
	  
	  if( fxhdr[5] != null && fxhdr[5] !=""){document.all.Cmpny.value = fxhdr[5];}
	  if( fxhdr[6] != null && fxhdr[6] !=""){document.all.Addrs1.value = fxhdr[6];}
	  if( fxhdr[7] != null && fxhdr[7] !=""){document.all.Addrs2.value = fxhdr[7];}
	  if( fxhdr[8] != null && fxhdr[8] !=""){document.all.City.value = fxhdr[8];}
	  if( fxhdr[9] != null && fxhdr[9] !=""){document.all.State.value = fxhdr[9];}
	  if( fxhdr[10] != null && fxhdr[10] !=""){document.all.Zip.value = fxhdr[10];}
	  if( fxhdr[12] != null && fxhdr[12] !=""){document.all.Phone.value = fxhdr[12];}
	  if( fxhdr[16] != null && fxhdr[16] !=""){document.all.ShpMeth.value = fxhdr[16];}
	  
	  for(var i=0; i < fxdtl.length; i++)
	  {
		 var sts = "Status" + i;
		 var obj = document.all[sts];
		 obj.options[0] = new Option("None", "None");
		 obj.options[1] = new Option("SHIPPED", "SHIPPED");
		 if(fxdtl[i][3]=="SHIPPED"){ obj.selectedIndex = 1; }
		 else{ obj.selectedIndex = 0; }
	  }
	}
	//==============================================================================
	// populate panel
	//==============================================================================
	function popFedEx(fxhdr, fxdtl)
	{		   
	   var panel = "<table border=1 style='font-size:12px' cellPadding='0' cellSpacing='0' width='100%' id='tblLog'>"
	    + "<tr class='DataTable'>"
	       + "<th colspan='2' width='50%'>Shipping Address</th>"
	       + "<th colspan='2' width='50%'>Payments</th>"
	    + "</tr>"   
	    + "<tr>"   
	       + "<th class='DataTable2'>Name</th><td class='DataTable1'>" + fxhdr[3] + "&nbsp;</td>"
	       + "<th class='DataTable2'>Total Shipping Cost</th><td class='DataTable1'>" + fxhdr[15] + "&nbsp;</td>"
	    + "</tr>"   
		+ "<tr>"   
	       + "<th class='DataTable2'>Company</th>"
	       + "<td class='DataTable1'><input name='Cmpny' class='Small' size='50' maxlength='50'></td>"
	       + "<th class='DataTable2'>Shipping Method</th>" 
	       + "<td class='DataTable1'><input name='ShpMeth' class='Small' size='5' maxlength='5' onclick='this.select()'></td>"
	    + "</tr>"   
		+ "<tr>"   
	       + "<th class='DataTable2'>Address 1</th>"
	       + "<td class='DataTable1'><input name='Addrs1' class='Small' size='50' maxlength='50'></td>"
	       + "<th class='DataTable2'>Residential? (Y/N)</th><td class='DataTable1'>" + fxhdr[18] + "&nbsp;</td>"
	    + "</tr>"   
		+ "<tr>"   
	       + "<th class='DataTable2'>Address 2</th>"
	       + "<td class='DataTable1'><input name='Addrs2' class='Small' size='50' maxlength='50'></td>"
	       + "<th class='DataTable2'>Notification</th><td class='DataTable1'>" + fxhdr[21] + "&nbsp;</td>"
	    + "</tr>"
	    + "<tr>"   
	       + "<th class='DataTable2'>City</th>" 
	       + "<td class='DataTable1'><input name='City' class='Small' size='50' maxlength='50'></td>"
	       + "<th class='DataTable2'>Notification Type</th><td class='DataTable1'>" + fxhdr[22] + "&nbsp;</td>"
	    + "</tr>"
	    + "<tr>"   
	       + "<th class='DataTable2'>State</th>" 
	       + "<td class='DataTable1'><input name='State' class='Small' size='2' maxlength='2'></td>"
	       + "<th class='DataTable2'>Delivery Note</th><td class='DataTable1'>" + fxhdr[23] + "&nbsp;</td>"
	    + "</tr>"
	    + "<tr>"   
	       + "<th class='DataTable2'>Zip Code</th>" 
	       + "<td class='DataTable1'><input name='Zip' class='Small' size='10' maxlength='10'></td>"
	       + "<th class='DataTable2'>Insurance</th><td class='DataTable1'>" + fxhdr[26] + "&nbsp;</td>"
	    + "</tr>"	    
	    + "<tr>"   
	       + "<th class='DataTable2'>Country</th><td class='DataTable1'>" + fxhdr[11] + "&nbsp;</td>"
	       + "<th class='DataTable2'>Insurance Option</th><td class='DataTable1'>" + fxhdr[27] + "&nbsp;</td>"
	    + "</tr>"
	    + "<tr>"   
	       + "<th class='DataTable2' nowrap>Phone Number</th>" 
	       + "<td class='DataTable1'><input name='Phone' class='Small' size='50' maxlength='50'></td>"
	       + "<th class='DataTable2'>USPS</th><td class='DataTable1'>" + fxhdr[24] + "&nbsp;</td>"
	    + "</tr>"
	    + "<tr>"   
	       + "<th class='DataTable2'>Fax Number</th><td class='DataTable1'>" + fxhdr[13] + "&nbsp;</td>"
	       + "<th class='DataTable2'>USPS</th><td class='DataTable1'>" + fxhdr[29] + "&nbsp;</td>"
	    + "</tr>"
	    
	    + "<tr>"   
	       + "<th class='DataTable2'>E-Mail</th><td class='DataTable1'>" + fxhdr[4] + "&nbsp;</td>"
	       + "<th class='DataTable2'>Product Code</th><td class='DataTable1'>" + fxhdr[17] + "&nbsp;</td>"
	    + "</tr>";
	panel += "</table>"
	    
	    // details
	panel += "<table border=1 style='font-size:12px' cellPadding='0' cellSpacing='0' width='100%' id='tblLog'>"
		    + "<tr class='DataTable'>"
		       + "<th class='DataTable'>Store</th>"
		       + "<th class='DataTable'>SKU</th>"
		       + "<th class='DataTable'>S/N</th>"
		       + "<th class='DataTable'>Status</th>"
		       + "<th class='DataTable'>Description</th>"
		       + "<th class='DataTable'>Manufacturer</th>"
		       + "<th class='DataTable'>Retail</th>"
		       + "<th class='DataTable'>Pick ID</th>"
		       + "<th class='DataTable'>Pack ID</th>"		       		       
		    + "</tr>";
	    
	for(var i=0; i < fxdtl.length; i++)
	{
		panel += "<tr class='DataTable'>"
		   + "<td class='DataTable'>" + fxdtl[i][0] + "&nbsp;</td>"		   
		   + "<td class='DataTable'>" + fxdtl[i][1] + "&nbsp;"
		     + "<input name='Sku" + i + "' value='" + fxdtl[i][1] + "'>"
		   + "</td>"
		   + "<td class='DataTable'>" + fxdtl[i][2] + "&nbsp;</td>"
		   + "<td class='DataTable'><select name='Status" + i + "' class='Small'></select></td>"
		   + "<td class='DataTable' nowrap>" + fxdtl[i][4] + "&nbsp;</td>"
		   + "<td class='DataTable'>" + fxdtl[i][5] + "&nbsp;</td>"
		   + "<td class='DataTable'>" + fxdtl[i][6] + "&nbsp;</td>"
		   + "<td class='DataTable'>" + fxdtl[i][7] + "&nbsp;</td>"
		   + "<td class='DataTable'>" + fxdtl[i][8] + "&nbsp;</td>"
		 + "</tr>";
	}	    
	
	panel += "<tr>"
    		  + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
 		   + "</tr>";
 		   
	panel += "</table>"
	        + "<button onClick='vldFedEx();' class='Small'>Save Changes</button>&nbsp; &nbsp;"
	        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;";
	        
	return panel;
}
//==============================================================================
// validate fed ex corrections
//==============================================================================
function vldFedEx()
{
	var error = false;
    var msg = "";
    document.all.tdError.innerHTML="";

    var cmpny = document.all.Cmpny.value.trim();    
    var addrs1 = document.all.Addrs1.value.trim();
    if(addrs1==""){error=true;msg += "Please enter Address 1 line"; }
    var addrs2 = document.all.Addrs2.value.trim();    
    var city = document.all.City.value.trim();
    if(city==""){error=true;msg += "Please enter City"; }
    var state = document.all.State.value.trim();
    if(state==""){error=true;msg += "Please enter State"; }
    var zip = document.all.Zip.value.trim();
    if(zip==""){error=true;msg += "Please enter Zip"; }
    var phone = document.all.Phone.value.trim();
    if(phone==""){error=true;msg += "Please enter Phone"; }
    var shpmeth = document.all.ShpMeth.value.trim();
    if(shpmeth==""){error=true;msg += "Please enter Shipping Method"; }
    
    var sts = new Array();
    for(var i=0; i < FxDtl.length; i++)
    {
    	var stsnm = "Status" + i;
    	var obj = document.all[stsnm];
    	sts[i] = obj.options[obj.selectedIndex].value;
    }
    
    var sku = new Array();
    for(var i=0; i < FxDtl.length; i++)
    {
    	var skunm = "Sku" + i;
    	sku[i] = document.all[skunm].value;
    }
    
    if(error){ document.all.tdError.innerHTML=msg; }
    else{ sbmFedEx(cmpny, addrs1, addrs2, city, state, zip, phone, shpmeth, sku, sts); }
}
//==============================================================================
// submit store status changes
//==============================================================================
function sbmFedEx(cmpny, addrs1, addrs2, city, state, zip, phone, shpmeth, sku, sts)
{
	cmpny = cmpny.replace(/\n\r?/g, '<br />');
	addrs1 = addrs1.replace(/\n\r?/g, '<br />');
	addrs2 = addrs2.replace(/\n\r?/g, '<br />');
	city = city.replace(/\n\r?/g, '<br />');
	state = state.replace(/\n\r?/g, '<br />');
	zip = zip.replace(/\n\r?/g, '<br />');
	phone = phone.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmStrSts"

    var html = "<form name='frmChgFedEx'"
       + " METHOD=Post ACTION='EComFedExInfo.jsp'>"
       + "<input name='Order'>"
       + "<input name='Company'>"
       + "<input name='Address1'>"
       + "<input name='Address2'>"
       + "<input name='City'>"
       + "<input name='State'>"
       + "<input name='Zip'>"
       + "<input name='Phone'>"
       + "<input name='ShpMeth'>"
       + "<input name='Action'>"

    for(var i=0; i < sku.length ;i++) { html += "<input name='Sku'>"; }
    for(var i=0; i < sts.length ;i++) { html += "<input name='Sts'>"; }

    html += "</form>"

    nwelem.innerHTML = html;
    window.frame1.document.appendChild(nwelem);

    window.frame1.document.all.Order.value = FxHdr[0];
    window.frame1.document.all.Company.value = cmpny;
    window.frame1.document.all.Address1.value = addrs1;
    window.frame1.document.all.Address2.value = addrs2;
    window.frame1.document.all.City.value = city;
    window.frame1.document.all.State.value = state;
    window.frame1.document.all.Zip.value = zip;
    window.frame1.document.all.Phone.value = phone;    
    window.frame1.document.all.Action.value="Save";
    window.frame1.document.all.ShpMeth.value = shpmeth;

    if(sts.length == 1)
    { 
    	window.frame1.document.all.Sku.value = sku[0];
    	window.frame1.document.all.Sts.value = sts[0];
    }
    else 
    {
    	for(var i=0; i < sts.length ;i++)
    	{
       		window.frame1.document.all.Sts[i].value = sts[i];
       		window.frame1.document.all.Sku[i].value = sku[i];
    	}
    }
    window.frame1.document.frmChgFedEx.submit();
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
  url = "EComSrlAsgCtl.jsp?Sort=" + sort
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
  url = "EComSrlAsgCtl.jsp?Sort=<%=sSort%>"

  for(var i=0; i < Sts.length;  i++)
  {
     url += "&Sts=" + Sts[i];
  }
  url += "&StsFrDate=" + StsFrDate;
  url += "&StsToDate=" + StsToDate;
  url += "&Ord=<%=sSelOrd%>"

  var pos = [0,0];
  if(SelObj != null)
  {
     pos = getPosition(SelObj);
     pos[1] -= 2
  }

  url += "&Top=" + pos[1];

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
       + " METHOD=Post ACTION='EComSrlAsgSave.jsp'>"
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
   window.frame1.document.all.Action.value="FIXSTRSTS";

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
function showAvlQty(site, ord, sku, str, ordqty, avl, obj, snid, snsts, snstr, place)
{
   SelObj = obj;
  
   var hdr = "Order: " + ord + " &nbsp; SKU: " + sku ;
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popAvlQty(site, ord, sku, str, ordqty, avl, obj, snid, snsts, snstr, place)
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
function popAvlQty(site, ord, sku, str, ordqty, avl, obj, snid, snsts, snstr, place )
{
  var panel = "<table border=1 cellPadding='0' cellSpacing='0' width='100%'>"
    + "<tr class='DataTable0'>"
       + "<th class='DataTable' class='Small'>Store</th>"
       + "<th class='DataTable' class='Small'>Available<br>Qty</th>"
       + "<th class='DataTable' class='Small' id='tdAvl'>Assigned<br>Qty</th>"
       + "<th class='DataTable' class='Small' nowrap>Sku/Str<br>Status</th>"
       + "<th class='DataTable' class='Small' id='tdReasgLnk'>Reassign</th>"
       + "<th class='DataTable' class='Small' id='tdPlace'>Place</th>"
       + "<th class='DataTable' class='Small' id='tdReasg'>Reassign<br>To<br>Str</th>"       
    + "</tr>"

    // calculate number of total assigned quantity
    for(var i=0; i < str.length; i++)
    {
      if( avl[i] != "0" || str[i] == snstr )
      {

         panel += "<tr class='DataTable0'>"
           + "<td class='DataTable' class='Small'>" + str[i] + "</td>"
           + "<td class='DataTable' id='tdAvl'" + i + "class='Small'>"

         if(str[i] != snstr && (snsts =="Open" || snsts == "Cannot Fill" || snsts == "Error"))
         {
            panel += "<a href='javascript: setQtySel(&#34;" + site
                  + "&#34;,&#34;" + ord +  "&#34;, &#34;" + sku
                  + "&#34;,&#34;" + snid
                  + "&#34;, &#34;" + str[i] + "&#34;, &#34;Assigned&#34;, &#34;" + ordqty
                  + "&#34;, &#34;" + avl[i] + "&#34;, &#34;CHGSTRSTS&#34;"
                  + ");'>" + avl[i] + "</a>"
         }
         else{ panel += avl[i]; }


         panel += "</td>"
         if(str[i] == snstr)
         {
            panel += "<td class='DataTable' class='Small'>1</td>"
            panel += "<td class='DataTable' class='Small' nowrap>" + snsts + "&nbsp;</td>"
            // reassign
            panel += "<td class='DataTable' class='Small' nowrap  id='tdReasgLnk'>&nbsp;"
            if( snsts == "Assigned" || snsts == "Printed" || snsts == "Picked" || snsts == "Shipped")
            {
               panel += "<a href='javascript: setSelReAsg(&#34;" + str[i] + "&#34;);'>R</a>"
            }
         }
         else
         {
            panel += "<td class='DataTable' class='Small'>&nbsp;</td>"
            panel += "<td class='DataTable' class='Small'>&nbsp;</td>"
            panel += "<td class='DataTable' class='Small'>&nbsp;</td>"
         }

         panel += "<td class='DataTable' class='Small'>" + place[i] + "</td>";
         panel += "<td class='DataTable' class='Small' nowrap id='tdReasg'>&nbsp;"

         if(str[i] != snstr && snsts !="Open" && snsts != "Cannot Fill" && snsts != "Canceled" && snsts != "Error")
         {
            panel += "<a href='javascript: setQtySel(&#34;" + site
                  + "&#34;,&#34;" + ord +  "&#34;, &#34;" + sku
                  + "&#34;,&#34;" + snid
                  + "&#34;, &#34;" + str[i] + "&#34;, &#34;Assigned&#34;, &#34;" + ordqty
                  + "&#34;, &#34;" + avl[i] + "&#34;, &#34;REASSIGN&#34;"
                  + ");'>" + avl[i] + "</a>"
         }
         else{ panel += avl[i]; }

         panel += "</td>";
         panel += "</tr>"
         }
         
          
    }

    panel += "<tr class='DataTable0'>"
     + "<td class='DataTable' class='Small' colspan=6>"
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
<TABLE class="TblMainPage">
  <TBODY>
  <TR>
    <TD vAlign=top align=left><B>Retail Concepts Inc.
        <BR>E-Commerce Store Fulfillments - HO Control
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="EComSrlAsgCtlSel.jsp" class="small"><font color="red">Select</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;
        &nbsp;&nbsp;
        <a href="javascript: foldColmn('cellFold1')">fold/unfold order info</a>
        &nbsp; &nbsp; &nbsp; &nbsp;
        <a href="javascript: foldColmn('cellFold2')">fold/unfold item info</a>
        &nbsp; &nbsp; &nbsp; &nbsp;
    </td>
    </tr>
    <TR>
    <TD vAlign=top align=middle colspan=2>
<!-- ======================================================================= -->
       <table border=1 class="DataTable" cellPadding="0" cellSpacing="0">
         <tr class="DataTable" >
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
             <th class="DataTable">FX</th>
             <th class="DataTable">Ord<br>Qty</th>
             <th class="DataTable">Total<br>Avail</th>
             <th class="DataTable">Asg Str<br>/Sts/Date</th>
             <th class="DataTable">Chg<br>S/N<br>Status</th>
             <!--th class="DataTable">C<br>m<br>p<br>l</th -->             
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
            String [] sPlace = itmasgn.getPlace();
            String sTotAvl = itmasgn.getTotAvl();
            String sOpId = itmasgn.getOpId();

            itmasgn.setSNList(sOpId, sUser);
            int iNumOfSn = itmasgn.getNumOfSn();

            String sAvlJsa = itmasgn.cvtToJavaScriptArray(sAvlQty);
            String sPlaceJsa = itmasgn.cvtToJavaScriptArray(sPlace);
            String sComa = "";

            String sOrdClr = "";
            if (i==0) { SvOrd = sOrd; }
            if(!SvOrd.equals(sOrd)){ bOrdClr = !bOrdClr;}
            if(bOrdClr){ sOrdClr = "#E7E7E7"; }
            else { sOrdClr = "Cornsilk"; }

            boolean bExpedited = sShipMeth.equals("151") || sShipMeth.equals("152")
                               || sShipMeth.equals("153") || sShipMeth.equals("154");

            //System.out.println("iNumOfSn " + iNumOfSn);
       %>
         <tr class="DataTable0" <%if(!sOrdClr.equals("")){%>style="background:<%=sOrdClr%>"<%}%>>
            <td class="DataTable" nowrap rowspan="<%=iNumOfSn%>">
               <a href="EComOrdInfo.jsp?Site=<%=sSite%>&Order=<%=sOrd%>" target="_blank"><%=sOrd%></a>
            </td>
            <td class="DataTable1" id="cellFold1" nowrap rowspan="<%=iNumOfSn%>"><%=sOrdDate%></td>
            <td class="DataTable1" id="cellFold1" nowrap rowspan="<%=iNumOfSn%>"><%=sShipNm%></td>
            <td class="DataTable1" id="cellFold1" nowrap rowspan="<%=iNumOfSn%>"><%=sShipCity%>, <%=sShipState%></td>
            <td class="DataTable1" <%if(bExpedited){%>style="font-weight:bold;"<%}%> nowrap rowspan="<%=iNumOfSn%>"><%=sShipMeth%> - <%=sShipMethNm%></td>
            <td class="DataTable1" nowrap rowspan="<%=iNumOfSn%>"><%=sOrdSts%></td>

            <td class="DataTable" id="cellFold2" nowrap rowspan="<%=iNumOfSn%>"><%=sDiv%></td>
            <td class="DataTable" id="cellFold2" nowrap rowspan="<%=iNumOfSn%>"><%=sCls%>-<%=sVen%>-<%=sSty%>-<%=sClr%>-<%=sSiz%></td>
            <td class="DataTable1" id="cellFold2" nowrap rowspan="<%=iNumOfSn%>"><%=sDesc%></td>
            <td class="DataTable1" id="cellFold2" nowrap rowspan="<%=iNumOfSn%>"><%=sVenNm%></td>
            <td class="DataTable2" nowrap rowspan="<%=iNumOfSn%>"><%=sSku%><!--a href="javascript: getSlsBySku(<%=sSku%>)"><%=sSku%></a--></td>
            <td class="DataTable2" nowrap rowspan="<%=iNumOfSn%>"><%=sUpc%></td>
            <td class="DataTable2" nowrap rowspan="<%=iNumOfSn%>">$<%=sRet%></td>
            <td class="DataTable2" id="tdSts<%=i%>" nowrap rowspan="<%=iNumOfSn%>">
             <%if(sPickSts.equals("Open")){%><a href="javascript: setStatus('<%=sSite%>' , '<%=sOrd%>', '<%=sSku%>', '<%=sPickSts%>', ['X'], document.all.tdSts<%=i%>)"><%=sPickSts%></a>
             <%} else {%>&nbsp;<%}%>
            </td>
            <th class="DataTable" style="vertical-align:middle;" id="thLog<%=i%>" rowspan="<%=iNumOfSn%>">
                <a href="javascript: getStrCommt('<%=sSite%>' , '<%=sOrd%>', '<%=sSku%>', document.all.thLog<%=i%>);">&nbsp;L&nbsp;</a>
            </th>
            <th class="DataTable" style="vertical-align:middle;" id="thLog<%=i%>" rowspan="<%=iNumOfSn%>">
                <a href="javascript: getFedEx('<%=sSite%>' , '<%=sOrd%>', '<%=sSku%>');">&nbsp;FX&nbsp;</a>
            </th>
            <td class="DataTable2" nowrap rowspan="<%=iNumOfSn%>"><%=sQty%></td>


            <%for(int j=0; j < iNumOfSn; j++ ){
                itmasgn.getSNList();
                String sSnId = itmasgn.getSnId();
                String sSnSts = itmasgn.getSnSts();
                String sSnStr = itmasgn.getSnStr();
                String sSnStsDt = itmasgn.getSnStsDt();
                String sSnStsTm = itmasgn.getSnStsTm();
            %>
                <%if(j > 0){%>
                   </tr><tr class="DataTable0" <%if(!sOrdClr.equals("")){%>style="background:<%=sOrdClr%>"<%}%>>
                <%}%>
                <td class="DataTable" id="tdTotAvl<%=i%>" nowrap>
                    <a href="javascript: showAvlQty('<%=sSite%>','<%=sOrd%>','<%=sSku%>'
                    ,[<%=sStrJsa%>], '<%=sQty%>',[<%=sAvlJsa%>], document.all.tdTotAvl<%=i%>
                    , '<%=sSnId%>', '<%=sSnSts%>', '<%=sSnStr%>',[<%=sPlaceJsa%>])"><%=sTotAvl%></a>
                </td>
                <td class="DataTable1" id="tdStrSts<%=i%>" nowrap><%=sSnStr%>-<%=sSnSts%> <%=sSnStsDt%></td>
                
                <td class="DataTable1" id="tdStrSts<%=i%>" nowrap>                   
                   <a href="javascript:setQtySel('<%=sSite%>', '<%=sOrd%>', '<%=sSku%>'
                       , '<%=sSnId%>', '<%=sSnStr%>', null, '0','0', 'CHGSTRSTS', '<%=sSnSts%>')">Change</a>                   
                   &nbsp;
                </td>
                
            <%}%>            
          </tr>
          <% SvOrd = sOrd; %>
       <%}%>
     </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   itmasgn.disconnect();
   itmasgn = null;
   }
%>