<%@ page import="ecommerce.EComItmAsg"%>
<%
    String [] sStatus = request.getParameterValues("Sts");
    String sStsFrDate = request.getParameter("StsFrDate");
    String sStsToDate = request.getParameter("StsToDate");
    String sSort = request.getParameter("Sort");

    if(sSort==null) sSort = "ORD";
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComItmAsg.jsp");
}
else
{
    String sAuthStr = session.getAttribute("STORE").toString().trim();
    String sUser = session.getAttribute("USER").toString();
    EComItmAsg itmasgn = new EComItmAsg(sStatus, sStsFrDate, sStsToDate, sSort, sUser);
    int iNumOfItm = itmasgn.getNumOfItm();
    int iNumOfStr = itmasgn.getNumOfStr();
    String [] sStr = itmasgn.getStr();
    String sStrJsa = itmasgn.getStrJsa();

    // authorized to changed assign store and notes
    boolean bAssign = sAuthStr.equals("ALL");
    // authorized to changed send str and notes
    boolean bSend = !sAuthStr.equals("ALL");
%>
<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:green; font-size:10px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}

        table.DataTable {font-size:10px }

        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px;
                       padding-bottom:3px; text-align:center; font-size:11px; text-decoration: underline;}

        tr.DataTable0 { background: #E7E7E7; font-size:10px }
        tr.DataTable1 { background: yellow; font-size:10px }
        tr.DataTable2 { background: darkred; font-size:1px}

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTableC { cursor:hand; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable1C { cursor:hand; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable2C { cursor:hand; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        .Small {font-size:10px }
        .btnSmall {font-size:8px; display:none;}

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
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

var NumOfItm = <%=iNumOfItm%>;
var NumOfStr = <%=iNumOfStr%>;
var Store = [<%=sStrJsa%>];
var Site = new Array(NumOfItm);
var Order = new Array(NumOfItm);
var Sku = new Array(NumOfItm);
var Qty = new Array(NumOfItm);
var PickSts = new Array(NumOfItm);

var AsgNote = new Array(NumOfItm);
var AsgQty = new Array(NumOfItm);
var SndQty = new Array(NumOfItm);
var AvlQty = new Array(NumOfItm);
var Mail = new Array(NumOfItm);
var SndNote = new Array(NumOfItm);

var SelObj = null;
var ChgOrder = new Array(NumOfItm);

document.onkeyup=catchEscape

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   for(var i=0; i < NumOfItm; i++)
   {
      for(var j=0; j < NumOfStr; j++)
      {
         ChgOrder[i] = new Array(eval(NumOfStr) * 4 + 3);
      }
   }
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
function setQtySel(i, j, obj)
{
  SelObj = obj;

  var pos = [0,0];
  pos[0] = obj.getBoundingClientRect().left;
  pos[1] = obj.getBoundingClientRect().top;

  var html = "<table cellPadding='0' cellSpacing='0'>"
    + "<tr><td nowrap>"
    + "<select class='Small' id='selQty'></select>"
    + "<button onClick='chgSelQty(" + i + ", " + j + ")' class='Small'>Chg</button>"
    + "<button onClick='hidePanel();' class='Small'>Close</button>"
    + "</td></tr></table>"

  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + pos[0];
  document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + pos[1];
  document.all.dvItem.style.visibility = "visible";

  // populate quantity
  popQtyFld(i, j);
}
//==============================================================================
// populate quantity
//==============================================================================
function popQtyFld(i, j)
{
   var max = eval(Qty[i]);
   var asg = null;

   // subtract already assigned number to other store
   if(SelObj.id=="tdAsg")
   {
      for(var k=0; k < NumOfStr; k++)
      {
         asg  = eval(AsgQty[i][k])
         if (k != j && asg != null)
         {
            max = max - eval(AsgQty[i][k]);
         }
      }
   }

   // compare with assigned number
   if(SelObj.id=="tdSnd")
   {
      if (AsgQty[i][j] != null ) {  max = eval(AsgQty[i][j]); }
   }

   // assigned quantity cannot be greater then available
   if (AvlQty[i][j] != null && AvlQty[i][j] < max ) { max = eval(AvlQty[i][j]); }

   for(var i=0; i <= max; i++) {  document.all.selQty.options[i] = new Option(i,i) }
}
//==============================================================================
// set selected Quantity
//==============================================================================
function chgSelQty(i, j)
{
  var qty = document.all.selQty.options[document.all.selQty.selectedIndex].value;
  SelObj.innerHTML = qty;

  // save
  var k = 2 + 4 * j;
  if (SelObj.id=="tdSnd") { k += 1;}
  ChgOrder[i][k] = qty;

  var btn = "btnSave" + i;
  document.all[btn].style.display="block"; // show save button
  hidePanel();
}
//==============================================================================
// set Note Text Area
//==============================================================================
function setNote(i, j, obj)
{
  SelObj = obj;

  var pos = [0,0];
  pos[0] = obj.getBoundingClientRect().left;
  pos[1] = obj.getBoundingClientRect().top;

  var html = "<table cellPadding='0' cellSpacing='0'>"
    + "<tr><td nowrap>"
    + "<TextArea class='Small' id='txaNote' cols=30 rows=3></TextArea>"
    + "<button onClick='chgTxANote(" + i + ", " + j + ")' class='Small'>Chg</button>"
    + "<button onClick='hidePanel();' class='Small'>Close</button>"
    + "</td></tr></table>"

  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft= pos[0];
  document.all.dvItem.style.pixelTop= pos[1];
  document.all.dvItem.style.visibility = "visible";

  // populate quantity
  popTxANote(i, j);
}
//==============================================================================
// populate note text
//==============================================================================
function popTxANote(i, j)
{
   var text = null;
   if (j == null) { text = AsgNote[i]; }
   else { text = SndNote[i][j]; }
   // get new text
   if (SelObj.innerHTML.trim(" ") != "&nbsp;") { text = SelObj.innerHTML.trim(" "); }

   document.all.txaNote.value = text;
}
//==============================================================================
// set selected Quantity
//==============================================================================
function chgTxANote(i, j)
{
  var note = document.all.txaNote.value;
  SelObj.innerHTML = note;

  // save new value
  if (j==null) { ChgOrder[i][0] = note; }
  else { ChgOrder[i][2 + 4 * (j) + 3] = note; }

  var btn = "btnSave" + i
  document.all[btn].style.display="block"; // show save button
  hidePanel();
}
//==============================================================================
// set Mail Tracking ID
//==============================================================================
function setMail(i, j, obj)
{
  SelObj = obj;

  var pos = [0,0];
  pos[0] = obj.getBoundingClientRect().left;
  pos[1] = obj.getBoundingClientRect().top;

  var html = "<table cellPadding='0' cellSpacing='0'>"
    + "<tr><td nowrap>"
    + "<input class='Small' id='inpMail' size=30 maxlength=30></TextArea>"
    + "<button onClick='chgInpMail(" + i + ", " + j + ")' class='Small'>Chg</button>"
    + "<button onClick='hidePanel();' class='Small'>Close</button>"
    + "</td></tr></table>"

  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft= pos[0];
  document.all.dvItem.style.pixelTop= pos[1];
  document.all.dvItem.style.visibility = "visible";

  // populate quantity
  popInpMail(i, j);
}
//==============================================================================
// populate note text
//==============================================================================
function popInpMail(i, j)
{
   var text = Mail[i][j];
   // get new text
   if (SelObj.innerHTML.trim(" ") != "&nbsp;") { text = SelObj.innerHTML.trim(" "); }

   document.all.inpMail.value = text;
}
//==============================================================================
// set selected Quantity
//==============================================================================
function chgInpMail(i, j)
{
  var mail = document.all.inpMail.value;
  SelObj.innerHTML = mail;
  // show save button under order #
  var btn = "btnSave" + i
  document.all[btn].style.display="block";
  ChgOrder[i][2 + 4 * j + 2] = mail;
  hidePanel();
}
//==============================================================================
// set selected Quantity
//==============================================================================
function setStatus(i, obj)
{
  SelObj = obj;

  var pos = getPosition(obj);
  var html = "<table cellPadding='0' cellSpacing='0'>"
    + "<tr><td nowrap>"
    + "<select class='Small' id='selSts'></select>"
    + "<button onClick='chgStatus(" + i + ")' class='Small'>Chg</button>"
    + "<button onClick='hidePanel();' class='Small'>Close</button>"
    + "</td></tr></table>"

  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft= pos[0];
  document.all.dvItem.style.pixelTop= pos[1];
  document.all.dvItem.style.visibility = "visible";

  // populate quantity
  popStatus(i);
}
//==============================================================================
// populate quantity
//==============================================================================
function popStatus(i)
{
   document.all.selSts.options[0] = new Option("Open", "Open");
   document.all.selSts.options[1] = new Option("Assign", "Assign");
   document.all.selSts.options[2] = new Option("Send", "Send");
   document.all.selSts.options[3] = new Option("Cancel ", "Cancel");

   for(var i=0; i < 4; i++)
   {
      if (PickSts[i]=="Open") document.all.selSts.selectedIndex = 0;
      if (PickSts[i]=="Assign") document.all.selSts.selectedIndex = 1;
      if (PickSts[i]=="Send") document.all.selSts.selectedIndex = 2;
      if (PickSts[i]=="Cancel") document.all.selSts.selectedIndex = 3;
   }
}
//==============================================================================
// set selected Quantity
//==============================================================================
function chgStatus(i)
{
  var qty = document.all.selSts.options[document.all.selSts.selectedIndex].value;
  SelObj.innerHTML = qty;

  // save
  ChgOrder[i][1] = qty;

  var btn = "btnSave" + i;
  document.all[btn].style.display="block"; // show save button
  hidePanel();
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
// resort table
//==============================================================================
function resort(sort)
{
  url = "EComItmAsg.jsp?Sort=" + sort
  for(var i=0; i < Sts.length;  i++)
  {
     url += "&Sts=" + Sts[i];
  }
  url += "&StsFrDate=" + StsFrDate;
  url += "&StsToDate=" + StsToDate;

  window.location.href=url;
}
//==============================================================================
// save changed Order/Item
//==============================================================================
function saveItmAssign(i)
{
  var chgord = ChgOrder[i];
  var note = chgord[0];
  var sts = chgord[1];
  var asgq = new Array(NumOfStr);
  var sndq = new Array(NumOfStr);
  var mail = new Array(NumOfStr);
  var strnote = new Array(NumOfStr);

  for(var j=0; j < NumOfStr; j++)
  {
     asgq[j] = chgord[2 + 4 * j + 0];
     sndq[j] = chgord[2 + 4 * j + 1];
     mail[j] = chgord[2 + 4 * j + 2];
     strnote[j] = chgord[2 + 4 * j + 3];
  }
  sbmItmAssign(i, note, sts, asgq, sndq, mail, strnote);
}
//==============================================================================
// submit Order/Item changes to save
//==============================================================================
function sbmItmAssign(i, note, sts, asgq, sndq, mail, strnote)
{
   var url = "EComItmAsgSave.jsp?"
      + "Site=" + Site[i]
      + "&Order=" + Order[i]
      + "&Sku=" + Sku[i]

   if(note != null) { url +="&Note=" + note.trim(" ").replaceSpecChar(); AsgNote[i] = note.trim(" ");} else { url +="&Note=*NONE"; }
   if(sts != null) { url +="&Sts=" + sts.trim(" "); PickSts[i] = sts.trim(" ");} else { url +="&Sts=*NONE"; }

   for(var j=0; j < NumOfStr; j++)
   {
     if(asgq[j] != null || sndq[j] != null || mail[j] != null || strnote[j] != null)
     {
        url +="&Str=" + Store[j];
        if(asgq[j] != null) { url +="&AsgQ=" + asgq[j]; AsgQty[i][j] = asgq[j];} else { url +="&AsgQ=*NONE"; }
        if(sndq[j] != null) { url +="&SndQ=" + sndq[j]; SndQty[i][j] = sndq[j];} else { url +="&SndQ=*NONE"; }
        if(mail[j] != null) { url +="&Mail=" + mail[j].trim(" ").replaceSpecChar(); Mail[i][j] = mail[j].trim(" ");} else { url +="&Mail=*NONE"; }
        if(strnote[j] != null) { url +="&StrN=" + strnote[j].trim(" ").replaceSpecChar(); SndNote[i][j] = strnote[j].trim(" ");} else { url +="&StrN=*NONE"; }
    }

   }

   var btn = "btnSave" + i;
   document.all[btn].style.display="none"; // remove save button
   SelObj = null;

   //alert(url + "\nUrl Length: " + url.length)
   //window.location.href = url;
   window.frame1.location.href = url;
}
//==============================================================================
// re-use frame
//==============================================================================
function reuseFrame()
{
  window.frame1.close();
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
<!-------------------------------------------------------------------->

<div style="clear: both; overflow: AUTO; width: 100%; height: 94%; POSITION: relative; color:black;" >

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin  style="z-index: 60; position: relative; top: expression(this.offsetParent.scrollTop);; left: expression(this.offsetParent.scrollLeft);">
    <TD vAlign=top align=left style="z-index: 60; position: relative; left: expression(this.offsetParent.scrollLeft);"><B>Retail Concepts Inc.
        <BR>E-Commerce: Items w/o Inventory
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;
        <font size="-1">T=Mail Tracking ID</font>&nbsp;&nbsp;
        <font size="-1">N=Store Note</font>&nbsp;&nbsp;
     </td>
   </tr>
   <TR bgColor=moccasin>
     <TD vAlign=top align=middle>
<!-- ======================================================================= -->
       <table class="DataTable"  border=1 cellPadding="0" cellSpacing="0">
         <!--tr class="DataTable" style="z-index: 60; position: relative; left: -1; top: expression(this.offsetParent.scrollTop-3);" -->
         <tr class="DataTable">
             <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);"><a href="javascript: resort('ORD')">Order #</a></th>
             <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);"><a href="javascript: resort('ORDSTS')">Ord<br>Sts</a></th>
             <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);" >SKU</th>
             <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);"><a href="javascript: resort('PSTS')">Pick<br>Sts</a></th>
             <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);"><a href="javascript: resort('USERNM')">Last Changed<br>by User</a></th>
             <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);">&nbsp;</th>
             <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);">Assigned<br>to<br>Stores</th>
             <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);">&nbsp;</th>
             <th class="DataTable" style="z-index: 40; position: relative;  top: expression(this.offsetParent.scrollTop);" colspan=<%=iNumOfStr * 4%>>Store</th>
          </tr>
          <tr class="DataTable">
              <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);">&nbsp;</th>
              <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);">&nbsp;</th>
              <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);">QTY</th>
              <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);"><a href="javascript: resort('PSDATE')">Pick Sts<br>Date</a></th>
              <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);">&nbsp;</th>
              <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);">&nbsp;</th>
              <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);">&nbsp;</th>
              <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);" >T</th>
            <%for(int i=0; i < iNumOfStr; i++){%>
               <th class="DataTable" style="z-index: 40; position: relative;  top: expression(this.offsetParent.scrollTop);" colspan=<%=3%>><%=sStr[i]%></th>
               <th class="DataTable" style="z-index: 40; position: relative;  top: expression(this.offsetParent.scrollTop);">&nbsp;</th>
            <%}%>
          </tr>
          <tr class="DataTable">
            <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);">&nbsp;</th>
            <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);" colspan=4>Home Office Note</th>
            <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);">&nbsp;</th>
            <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);">&nbsp;</th>
            <th class="DataTable" style="z-index: 60; position: relative;  top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);" >N</th>
            <%for(int i=0; i < iNumOfStr; i++){%>
               <th class="DataTable" style="z-index: 40; position: relative;  top: expression(this.offsetParent.scrollTop);">Asg<br>Qty</th>
               <th class="DataTable" style="z-index: 40; position: relative;  top: expression(this.offsetParent.scrollTop);">Snd<br>Qty</th>
               <th class="DataTable" style="z-index: 40; position: relative;  top: expression(this.offsetParent.scrollTop);">Avail<br>Qty</th>
               <th class="DataTable" style="z-index: 40; position: relative;  top: expression(this.offsetParent.scrollTop);">&nbsp;</th>
            <%}%>
         </tr>
       <!-- ============================ Details =========================== -->
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
            String sPStsUser = itmasgn.getPStsUser();
            String sUserName = itmasgn.getUserName();
            String [] sAsgQty = itmasgn.getAsgQty();
            String [] sSndQty = itmasgn.getSndQty();
            String [] sAvlQty = itmasgn.getAvlQty();
            String [] sMail = itmasgn.getMail();
            String sAsgNote = itmasgn.getAsgNote();
            String [] sStrNote = itmasgn.getStrNote();

            String sAsgQtyJsa = itmasgn.getAsgQtyJsa();
            String sSndQtyJsa = itmasgn.getSndQtyJsa();
            String sAvlQtyJsa = itmasgn.getAvlQtyJsa();
            String sStrNoteJsa = itmasgn.getStrNoteJsa();
            String sMailJsa = itmasgn.getMailJsa();

            String sAsgStrLst = "";
            String sComa = "";
            boolean bStrAssgn = false;
            for(int j=0; j < iNumOfStr; j++)
            {
                if(!sAsgQty[j].equals("")){sAsgStrLst += sComa + sStr[j]; sComa=",";bStrAssgn = true;}
            }

            boolean bStrSend = false;
            for(int j=0; j < iNumOfStr; j++)
            {
                if(!sSndQty[j].equals("") && !sSndQty[j].equals("0")){bStrSend = true;}
            }
            String sOrdClr = "";
            if(sPickSts.equals("Send")){ sOrdClr = "#ACFA58"; }
            else if(sPickSts.equals("Assign")){ sOrdClr = "#F4FA58"; }
       %>
         <tr class="DataTable0">
            <td class="DataTable" <%if(bStrAssgn || bStrSend){%>style="background:<%=sOrdClr%>"<%}%> rowspan=3 nowrap
                style="z-index: 40; position: relative; left: expression(this.offsetParent.scrollLeft);">
               <a href="EComOrdInfo.jsp?Site=<%=sSite%>&Order=<%=sOrd%>" target="_blank"><%=sOrd%></a><br><br>
               <button id="btnSave<%=i%>" onClick="saveItmAssign(<%=i%>)" class="btnSmall">Save</button>
            </td>
            <td class="DataTable1"style="z-index: 40; position: relative; left: expression(this.offsetParent.scrollLeft);" rowspan=2 nowrap>
               <%=sOrdSts%>
            </td>
            <td class="DataTable" style="z-index: 40; position: relative; left: expression(this.offsetParent.scrollLeft);" nowrap><%=sSku%></td>

            <%if(bAssign){%><td class="DataTableC" style="z-index: 40; position: relative; left: expression(this.offsetParent.scrollLeft);" id="tdPSts" onClick="javascript: setStatus(<%=i%>, this);"><%=sPickSts%></td><%}
              else {%><td class="DataTable" style="z-index: 40; position: relative; left: expression(this.offsetParent.scrollLeft);" id="tdPSts"><%=sPickSts%></td><%}%>

            <td class="DataTable1" style="z-index: 40; position: relative; left: expression(this.offsetParent.scrollLeft);" rowspan=2 nowrap><%=sUserName%></td>
            <th class="DataTable" style="z-index: 40; position: relative; left: expression(this.offsetParent.scrollLeft);" rowspan=3>&nbsp;</th>
            <td class="DataTable1" style="z-index: 40; position: relative; left: expression(this.offsetParent.scrollLeft);" rowspan=3 nowrap><%=sAsgStrLst%></td>
            <td class="DataTable" style="z-index: 40; position: relative; left: expression(this.offsetParent.scrollLeft);">&nbsp;</td>
            <%for(int j=0; j < iNumOfStr; j++){%>
              <%if(bAssign){%><td class="DataTable2C" id="tdAsg" onClick="javascript: setQtySel(<%=i%>, <%=j%>, this);">&nbsp;<%=sAsgQty[j]%></td><%}
                else {%><td class="DataTable2" id="tdAsg">&nbsp;<%=sAsgQty[j]%></td><%}%>

              <%if(bSend && sAuthStr.trim().equals(sStr[j].trim())){%><td class="DataTable2C" id="tdSnd" onClick="javascript: setQtySel(<%=i%>, <%=j%>, this);"><%=sSndQty[j]%></td><%}
              else {%><td class="DataTable2" id="tdSnd" >&nbsp;<%=sSndQty[j]%></td><%}%>
              <td class="DataTable2" id="tdAvl" nowrap >&nbsp;<%=sAvlQty[j]%></td>
              <th class="DataTable" rowspan=3>&nbsp;</th>
            <%}%>
          </tr>

          <script>Site[<%=i%>]="<%=sSite%>"; Order[<%=i%>]="<%=sOrd%>"; Sku[<%=i%>]="<%=sSku%>"; Qty[<%=i%>]="<%=sQty%>";
                AsgQty[<%=i%>] = [<%=sAsgQtyJsa%>]; SndQty[<%=i%>] = [<%=sSndQtyJsa%>];
                AvlQty[<%=i%>] = [<%=sAvlQtyJsa%>]; Mail[<%=i%>] = [<%=sMailJsa%>];
                SndNote[<%=i%>]=[<%=sStrNoteJsa%>];
                PickSts[<%=i%>]="<%=sPickSts%>"; AsgNote[<%=i%>]="<%=sAsgNote%>";
          </script>

          <tr class="DataTable0">
            <td class="DataTable2" style="z-index: 40; position: relative; left: expression(this.offsetParent.scrollLeft);"><%=sQty%></td>
            <td class="DataTable" style="z-index: 40; position: relative; left: expression(this.offsetParent.scrollLeft);"><%=sPStsDate%></td>
            <td class="DataTable" style="z-index: 40; position: relative; left: expression(this.offsetParent.scrollLeft);">T</td>
            <%for(int j=0; j < iNumOfStr; j++){%>
              <%if(bSend){%><td class="DataTable1C" colspan=3 id="tdMail" onClick="javascript: setMail(<%=i%>, <%=j%>, this);" nowrap><%=sMail[j]%>&nbsp;</td><%}
              else {%><td class="DataTable1" colspan=3 id="tdMail" nowrap><%=sMail[j]%>&nbsp;</td><%}%>
            <%}%>
          </tr>
          <tr class="DataTable0">
            <%if(bAssign){%><td class="DataTable1C" style="z-index: 40; position: relative; left: expression(this.offsetParent.scrollLeft);" colspan=4 id="tdNote" onClick="javascript: setNote(<%=i%>, null, this);"><%=sAsgNote%>&nbsp;</td><%}
            else {%><td class="DataTable1" style="z-index: 40; position: relative; left: expression(this.offsetParent.scrollLeft);" colspan=4 id="tdNote"><%=sAsgNote%>&nbsp;</td><%}%>

            <td class="DataTable" style="z-index: 40; position: relative; left: expression(this.offsetParent.scrollLeft);">N</td>
            <%for(int j=0; j < iNumOfStr; j++){%>
              <%if(bSend){%><td class="DataTable1C" colspan=3 id="tdStrNote" onClick="javascript: setNote(<%=i%>, <%=j%>, this);"><%=sStrNote[j]%>&nbsp;</td><%}
              else {%><td class="DataTable1" colspan=3 id="tdStrNote"><%=sStrNote[j]%>&nbsp;</td><%}%>
            <%}%>
          </tr>
          <tr class="DataTable2"><td colspan=150>&nbsp;</td></tr>
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