<%@ page import="ecommerce.EComProd"%>
<%
    String sSrchDiv = request.getParameter("Div");
    String sSrchDpt = request.getParameter("Dpt");
    String sSrchCls = request.getParameter("Cls");
    String sSrchVen = request.getParameter("Ven");
    String sSeason = request.getParameter("Season");
    String sReady = request.getParameter("Ready");
    String sApproved = request.getParameter("Approved");
    String sSrchAssign = request.getParameter("Assign");
    String sSrchSite = request.getParameter("Site");
    String sSrchStock = request.getParameter("Stock");
    String sExcel = request.getParameter("Excel");
    String sSort = request.getParameter("Sort");
    String sPO30Dy = request.getParameter("PO30Dy");
    String sPO60Dy = request.getParameter("PO60Dy");
    String sPO90Dy = request.getParameter("PO90Dy");

    if(sSort==null){ sSort = "ITEM"; }
    if(sPO30Dy==null){ sPO30Dy = "0"; }
    if(sPO60Dy==null){ sPO60Dy = "0"; }
    if(sPO90Dy==null){ sPO90Dy = "0"; }
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComProd.jsp&APPL=ECOMMERCE&" + request.getQueryString());
}
else
{
    boolean bChgProd = session.getAttribute("ECOMPROD") != null;
    boolean bDltProd = session.getAttribute("ECPRODDLT") != null;
    String sUser = session.getAttribute("USER").toString();

    /*System.out.println(
      sSrchDiv + "|" + sSrchDpt + "|" + sSrchCls + "|" + sSrchVen + "|" + sSeason
          + "|" + sReady + "|" +  sApproved + "|" +  sSrchAssign + "|" + sSrchSite
          + "|" + sSrchStock + "|" + sSort + "|" + sUser
    ); */
    EComProd prodlst = new EComProd(sSrchDiv, sSrchDpt, sSrchCls, sSrchVen, sSeason,
       sReady, sApproved, sSrchAssign, sSrchSite, sSrchStock, sPO30Dy, sPO60Dy, sPO90Dy, sSort, sUser);

    int iNumOfProd = prodlst.getNumOfProd();

    if (sExcel.equals("Y")) { response.setContentType("application/vnd.ms-excel"); }

    int iCountAll = 0;
    int iCountComplete = 0;
%>
<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { padding- top:3px; padding-bottom:3px; text-align:center; font-size:11px;}

        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable0 { background: red; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-size:10px }
        tr.DataTable2 { background: CornSilk; font-size:12px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvTooltip { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:15; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        tr.Prompt { background: lavender; font-size:10px }
        tr.Prompt1 { background: seashell; font-size:10px }
        tr.Prompt2 { background: LightCyan; font-size:11px }

        th.Prompt { background:#FFCC99; text-align:ceneter; vertical-align:midle; font-family:Arial; font-size:11px; }
        td.Prompt { padding-left:3px; padding-right:3px; text-align:left; vertical-align:top; font-family:Arial;}
        td.Prompt1 { padding-left:3px; padding-right:3px; text-align:center; vertical-align:top; font-family:Arial;}
        td.Prompt2 { padding-left:3px; padding-right:3px; text-align:right; font-family:Arial; }
        td.Prompt3 { padding-left:3px; padding-right:3px; text-align:left; vertical-align:midle; font-family:Arial;}


</style>


<script language="javascript1.3">
//------------------------------------------------------------------------------
var NumOfProd = <%=iNumOfProd%>;
var SelCol=null;
var SelCell = new Array(NumOfProd);
var SelValue = null;
var SbmCmd = new Array();
var SbmLoop = 0;
var SbmQty = 0;
var Child = "none";
var Site = "<%=sSrchSite%>"
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   //foldExpandChild();
}
//==============================================================================
// get Item price
//==============================================================================
function getItemPrice(prod)
{
   var cls = prod.substring( 0,  4);
   var ven = prod.substring( 4,  9);
   var sty = prod.substring( 9, 13);
   var clr = prod.substring(14, 17);
   var siz = prod.substring(17, 21);

   var url = "EComItmPrc.jsp?"
      + "Cls=" + cls
      + "&Ven=" + ven
      + "&Sty=" + sty
      + "&Clr=" + clr
      + "&Siz=" + siz

   //alert(url)
   //window.location.href = url
   window.frame1.location.href = url
}

//--------------------------------------------------------
// fold/expand Child
//--------------------------------------------------------
function showPrc(item, sku, map, mapExpDt, ipSug, ipRet, ipS70Prc, ipS70Alt, ipS70AltFrom,
    ipS70AltTo, ipTmp, ipTmpFrom, ipTmpTo, ecMsrp, ecRet, ecPrice, ecSales)
{
   //check if order is paid off
   var hdr = "Product Price";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>" + popPricePanel(item, sku, map, mapExpDt,
         ipSug, ipRet, ipS70Prc, ipS70Alt, ipS70AltFrom, ipS70AltTo, ipTmp, ipTmpFrom,
         ipTmpTo, ecMsrp, ecRet, ecPrice, ecSales)

   html += "</td></tr></table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.width = 250;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";
}
//--------------------------------------------------------
// populate price panel
//--------------------------------------------------------
function popPricePanel(item, sku, map, mapExpDt,
               ipSug, ipRet, ipS70Prc, ipS70Alt, ipS70AltFrom, ipS70AltTo, ipTmp, ipTmpFrom, ipTmpTo, ecMsrp, ecRet,
               ecPrice, ecSales)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='Prompt'><th class='Prompt' colspan=6>Island Pacific Price</th></tr>"
           + "<tr class='Prompt'r><td class='Prompt3' nowrap>Item </td>"
           + "<td class='Prompt'nowrap>" + item + "</td>"
           + "<th class='Prompt' rowspan=6>&nbsp;</th>"
           + "<td class='Prompt' nowrap>Sku </td>"
           + "<td class='Prompt1'>" + sku + "</td>"
         + "</tr>"
         + "<tr class='Prompt'><td class='Prompt3' nowrap>Map Price(Map) </td>"
           + "<td class='Prompt2'>" + map + "</td>"
           + "<td class='Prompt3' nowrap>Map Experation Date(MapEXP) </td>"
           + "<td class='Prompt1'>" + mapExpDt + "</td>"
         + "</tr>"
         + "<tr class='Prompt'><td class='Prompt3' nowrap>Suggested Price(IPSug) </td>"
           + "<td class='Prompt2'>" + ipSug + "</td>"
           + "<td class='Prompt3' nowrap>Chain Retail Price(IPRET) </td>"
           + "<td class='Prompt2'>" + ipRet + "</td>"
         + "</tr>"

         + "<tr class='Prompt'><td class='Prompt3' nowrap>Store 70 Price(Str70Prc)</td>"
           + "<td class='Prompt2'>" + ipS70Prc + "</td>"
           + "<td class='Prompt3' colspan=2>&nbsp;</td>"
         + "</tr>"

         + "<tr class='Prompt'><td class='Prompt3' nowrap>Store 70 Alternate Price(Str70AltPrc)</td>"
           + "<td class='Prompt2'>" + ipS70Alt + "</td>"
           + "<td class='Prompt3' nowrap>Effetive Dates(Str70AltEffDate): </td>"
           + "<td class='Prompt2'>" + ipS70AltFrom + " - "  + ipS70AltTo +"</td>"
         + "</tr>"

         + "<tr class='Prompt'><td class='Prompt3' nowrap>Temporary Price(TempPrice) </td>"
           + "<td class='Prompt2'>" + ipTmp + "</td>"
           + "<td class='Prompt3' nowrap>Temporary Price Effective Dates(TempEffDate)</td>"
           + "<td class='Prompt2' nowrap>" + ipTmpFrom  + " - " + ipTmpTo + "</td>"
         + "</tr>"

         + "<tr><th class='Prompt' colspan=5>E-Commerce Price</th></tr>"

         + "<tr class='Prompt1'><td class='Prompt3' nowrap>MSRP (ECMSRP)</td>"
           + "<td class='Prompt2'>&nbsp;" + ecMsrp + "</td>"
           + "<th class='Prompt' rowspan=2>&nbsp;</th>"
           + "<td class='Prompt3' nowrap>Retail (ECRetail)</td>"
           + "<td class='Prompt2'>" + ecRet + "</td>"
         + "</tr>"
         + "<tr class='Prompt1'><td class='Prompt3' nowrap>Shopzilla Price(SZPrice) </td>"
           + "<td class='Prompt2'>" + ecPrice + "</td>"
           + "<td class='Prompt3' nowrap>Sales (ECSales) </td>"
           + "<td class='Prompt2'>&nbsp;" + ecSales + "</td>"
         + "</tr>"

  panel += "<tr><th class='Prompt' colspan=5 nowrap><button onClick='hidePanel();' class='Small'>Close</button></th></tr>"
         + "<tr class='Prompt2'><td class='Prompt' colspan=5 nowrap> E-Commerce Manufacturing Suggested Price ECMSRP = IPSug<br>"
              + "If IPSug &#60;= IPRet or difference between IPSug and IPRet less than 50 cents, "
              + "then ECMSRP is not published."
          + "</td></tr>"

          + "<tr class='Prompt2'><td class='Prompt' colspan=5 nowrap> E-Commerce Retail Price ECRET = IPRet<br>"
              + "If IPRet &#60; Map, then ECRET = Map."
          + "</td></tr>"

          + "<tr class='Prompt2'><td class='Prompt' colspan=5 nowrap> Shopzilla Price SZPrice = IPRet<br>"
              + "If IPRet &#60; Map, Then SZPrice = Map."
          + "</td></tr>"

          + "<tr class='Prompt2'><td class='Prompt' colspan=5 nowrap> E-Commerce Sales Price <br>"
              + "1. If there is an alternate price for Store 70 is not expired and  greater than Map, then ECSales = Str70AltPrc;<br>"
              + "2. If rule 1 is not applied and TempPrice is greater than Map and not expired, then ECSales = TempPrice;<br>"
              + "3. If rule 1, 2 are not applied and TempPrice is less than Map and not expired, then ECSales = Map;<br>"
              + "4. If there are none of the above rules applied, then ECSales is not published."
          + "</td></tr>"

  panel += "</table>";


  return panel;
}
//--------------------------------------------------------
// fold/expand Child
//--------------------------------------------------------
function foldExpandChild()
{
   for(var i=0; i < NumOfProd; i++)
   {
      if ( document.all.trProd[i].className== "DataTable"
        || document.all.trProd[i].className== "DataTable0")
      {
         document.all.trProd[i].style.display=Child;
      }
      else(window.status="Loaded records: " + i)
   }

   if (Child == "none") { Child = "block"; }
   else { Child = "none"; }
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}

//==============================================================================
// mark attribute on Item Header
//==============================================================================
function markItem(i, prod, fld, type)
{
  // allowed not in download mode
   var fdone = document.all.tdDone[i];
   var fprity = document.all.tdPriority[i];
   var fdelete = document.all.tdDelete[i];
   var frow = document.all.trProd[i];

   if (fld == "DONE") { if (fdone.innerHTML.substring(0, 4) != "<IMG")  { fdone.innerHTML = "<img src='Present_box.jpg' width='25' hight='25'>";  } else { fdone.innerHTML = " "; } }
   if (fld == "PRIORITY") { if (fprity.innerHTML.substring(0, 4) != "<IMG")  { fprity.innerHTML = "<img src='Runner.jpg' width='25' hight='25'>";  } else { fprity.innerHTML = " "; } }
   if (fld == "DELETE") { fdelete.innerHTML = "****"; frow.style.backgroundColor="purple";   }

   var url = "EComProdSave.jsp?Site=<%=sSrchSite%>"
    + "&Prod=" + prod
    + "&Type=" + type

   if (fld == "DONE") url += "&Action=UPDDONE";
   if (fld == "PRIORITY") url += "&Action=PRIORITY";
   if (fld == "DELETE") url += "&Action=DELETE";

   //alert(url);
   //window.location.href=url
   window.frame1.location.href=url
}
//==============================================================================
// mark attribute on Item Header
//==============================================================================
function sbmPriority(i, prod, chkBox)
{
  // Switch beetween high and regular priority
   var url = "EComProdSave.jsp?Prod=" + prod
   if(chkBox.checked) url += "&Action=PTYHIGH";
   else url += "&Action=PTYREG";

   //alert(url);
   //window.location.href=url
   window.frame1.location.href=url
}
//==============================================================================
// update selected colimn cells
//==============================================================================
function colUpdate()
{
   // exit if there are no selection made
   if(SelCol==null) { alert("There is no selected column."); return}

   var colnm = null
   var size = 0;

   //check if order is paid off
   var hdr = "Update Column: ";
   if(SelCol=="ASSIGN") { colnm = "Assigned"; size=10; }
   hdr += colnm;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>" + popGenderPanel(SelCol, colnm)

   html += "</td></tr></table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.width = 250;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";
   document.all.Col.value = SelValue;
   document.all.Col.focus()
}

//--------------------------------------------------------
// populate Column Panel
//--------------------------------------------------------
function popGenderPanel(col, colnm)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt3' nowrap>" + colnm + "</td>"
           + "<td class='Prompt' colspan='2'>"
             + "<input name=Col class='Small' maxlength=30 size=35>"
           + "</td>"
         + "</tr>"

  panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
        + "<button onClick='sbmColumn(&#34;" + col + "&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
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
// select column cells for updates
//==============================================================================
function selColumnCell(i,prod, fld)
{
   var cell = null;
   var hdr = null;
   if (NumOfProd > 1)
   {
     if(fld=="ASSIGN") { cell = document.all.tdAssign[i]; hdr = document.all.thAssign;}
  }
  else
  {
     if(fld=="ASSIGN") { cell = document.all.tdDesc; hdr = document.all.thAssign;}
  }

   if(SelCol==null || SelCol == fld)
   {
      SelCol = fld;
      if(SelCell[i] == null || !SelCell[i])
      {
         cell.style.backgroundColor="lightsalmon"; SelCell[i] = true;
         hdr.style.backgroundColor="#fbb917";
         if (SelValue == null) SelValue = cell.innerHTML;
      }
      else
      {
         cell.style.backgroundColor="cornsilk"; SelCell[i] = false;
      }
   }
}
//==============================================================================
// clear selection
//==============================================================================
function clrColSel()
{
   // do not clear, if no selection
   if(SelCol==null) return;

   var cell = null;
   var hdr = null;

   if(SelCol=="ASSIGN") { cell = document.all.tdAssign; hdr = document.all.thAssign;}

   for(var i=0; i < NumOfProd; i++)
   {
      if (SelCell[i] == true)
      {
        if(NumOfProd > 1)
        {
          cell[i].style.backgroundColor="cornsilk";
          hdr.style.backgroundColor="#FFCC99";
          SelCell[i]=false;
        }
        else
        {
          cell.style.backgroundColor="cornsilk";
          hdr.style.backgroundColor="#FFCC99";
          SelCell=false;
        }
      }
   }
   SelCol = null;
   SelValue = null;
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function sbmColumn(col)
{
   var prod = 0;

   var column = document.all.dvItem.innerHTML = document.all.Col.value;

   document.all.dvItem.innerHTML = "<MARQUEE><font size = +2>Wait while table is updating...</font></MARQUEE>";
   document.all.dvItem.style.width = 600;
   document.all.dvItem.style.height = 50;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";

   for(var i=0, j=0; i < NumOfProd; i++)
   {
      if(SelCell[i] != null && SelCell[i])
      {
        if (NumOfProd > 1)
        {
           if(SelCol=="ASSIGN") document.all.tdAssign[i].innerHTML = column;
           var link = "linkProd" + i;
           prod = document.all[link].innerHTML;
        }
        else
        {
           if(SelCol=="ASSIGN") document.all.tdAssign.innerHTML = column;
           // if(document.all.Down != null) document.all.Down.checked = true;
           prod = document.all.tdProd.innerHTML.substring(0, 20);
        }

        var url = "EComProdSave.jsp?Prod=" + prod
                + "&Site=<%=sSrchSite%>"
        if(col=="ASSIGN") url += "&Assign=" + column + "&Action=UPDASSIGN";

        SbmCmd[j++] = url;
        SbmQty = j;
      }
   }

   reuseFrame(); // submit all requests
}
//--------------------------------------------------------
// reuse frame
//--------------------------------------------------------
function reuseFrame()
{
   if (SbmLoop < SbmQty)
   {
      //alert(SbmCmd[SbmLoop])
      //window.location.href=SbmCmd[SbmLoop];
      window.frame1.location.href= SbmCmd[SbmLoop];
      SbmLoop++;
   }
   else
   {
      SbmCmd = new Array();
      SbmLoop = 0;
      SbmQty = 0;
      hidePanel();
      clrColSel();
   }
}
//==============================================================================
// show table with different sorting
//==============================================================================
function resort(sort)
{
   var url = "EComProd.jsp?"
           + "Div=<%=sSrchDiv%>"
           + "&Dpt=<%=sSrchDpt%>"
           + "&Cls=<%=sSrchCls%>"
           + "&Ven=<%=sSrchVen%>"
           + "&Season=<%=sSeason%>"
           + "&Ready=<%=sReady%>"
           + "&Approved=<%=sApproved%>"
           + "&Assign=<%=sSrchAssign%>"
           + "&Site=<%=sSrchSite%>"
           + "&Excel=<%=sExcel%>"
           + "&Stock=<%=sSrchStock%>"
           + "&Sort=" + sort;
   //alert(url)
   window.location.href=url;
}
//==============================================================================
// switch Volusion site
//==============================================================================
function otherSite()
{
   var url = "EComProd.jsp?"
           + "Div=<%=sSrchDiv%>"
           + "&Dpt=<%=sSrchDpt%>"
           + "&Cls=<%=sSrchCls%>"
           + "&Ven=<%=sSrchVen%>"
           + "&Season=<%=sSeason%>"
           + "&Ready=<%=sReady%>"
           + "&Approved=<%=sApproved%>"
           + "&Assign=<%=sSrchAssign%>"
           + "&Excel=<%=sExcel%>"
           + "&Stock=<%=sSrchStock%>"
           + "&Sort=<%=sSort%>"

   if(Site=="SASS"){ url += "&Site=SKCH"; }
   else { url += "&Site=SASS"; }
   //alert(url)
   window.location.href=url;
}
//==============================================================================
// show column name on "mouse over" event
//==============================================================================
function showColName(col, cell)
{
   var html = "<table width='100%' cellPadding='0' cellSpacing='0' style='font-size:10px;'>"
            + "<tr><td nowrap>" + col + "</td></tr>"

   var pos = getObjectPosition(cell)
   document.all.dvTooltip.innerHTML = html;
   document.all.dvTooltip.style.pixelLeft= pos[0];
   document.all.dvTooltip.style.pixelTop= pos[1]-15;
   document.all.dvTooltip.style.visibility = "visible";
}
//==============================================================================
// change Note option and note text
//==============================================================================
function chgNoteOption(prod, parent, opt, note)
{
    //check if order is paid off
   var hdr = "Product: " + prod;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>" + popNotePanel(prod, parent, opt, note)

   html += "</td></tr></table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.width = 250;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";

   for(var i=0; i < document.all.NoteOpt.length; i++)
   {
      if(opt == document.all.NoteOpt[i].value || opt == "" && i == 0){ document.all.NoteOpt[i].checked = true; }
   }
   document.all.Note.value = note;
}
//==============================================================================
// populate Note Panel
//==============================================================================
function popNotePanel(prod, parent, opt, note)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable2'><th nowrap>Product Note Option:</th>"
           + "<td nowrap>"
             + "<input type='radio' name=NoteOpt class='Small' value='NONE'>None<br>"
             + "<input type='radio' name=NoteOpt class='Small' value='PHOTO'>Photo Not Available<br>"
             + "<input type='radio' name=NoteOpt class='Small' value='CONTENT'>Content Not Available<br>"
             + "<input type='radio' name=NoteOpt class='Small' value='PHOTOCONT'>Phot & Content Not Available<br>"
             + "<input type='radio' name=NoteOpt class='Small' value='UNKNOWN'>Unknown Style/Color/Size<br>"
             + "<input type='radio' name=NoteOpt class='Small' value='WEBCAT'>Web Category Missing"
           + "</td>"
         + "</tr>"
         + "<tr class='DataTable2'><th nowrap>Product Note:</th>"
           + "<td nowrap>"
             + "<TextArea name=Note class='Small' cols=50 rows=4 "
             + " onKeyDown='textCounter(this, 200);' onKeyUp='textCounter(this,200);'"
               + " text=" + note + "></TextArea>"
           + "</td>"
         + "</tr>"

  panel += "<tr><td class='Prompt1' colspan='2'><br><br>"
        + "<button onClick='sbmNote(&#34;" + prod + "&#34;, &#34;" + parent + "&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// limit size of text area
//==============================================================================
function textCounter(field, maxlimit)
{
   if (field.value.length > maxlimit)
   {
      field.value = field.value.substring(0, maxlimit);
   }
}
//==============================================================================
// validate note option entry
//==============================================================================
function sbmNote(prod, parent)
{
  var opt = "";

  for(var i=0; i < document.all.NoteOpt.length; i++)
  {
     if(document.all.NoteOpt[i].checked){opt = document.all.NoteOpt[i].value; }
  }

  var note = document.all.Note.value.replaceSpecChar()
  var type = "1";
  if(!parent){type = "2";}

  var url = "EComProdSave.jsp?Prod=" + prod
       + "&Site=<%=sSrchSite%>"
       + "&Type=" + type
       + "&NoteOpt=" + opt
       + "&Note=" + note
       + "&Action=UPDNOTE"
  //alert(url);
  window.frame1.location.href=url;
}
//==============================================================================
// hide column name
//==============================================================================
function hideColName(){document.all.dvTooltip.style.visibility = "hidden";}
//==============================================================================
// show column name
//==============================================================================
function getObjectPosition(obj)
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
<!-------------------------------------------------------------------->
<div id="dvTooltip" class="dvTooltip"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>E-Commerce Item List
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="EComProdSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript: colUpdate()">Update</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript: clrColSel()">Clear</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript: foldExpandChild()">Expand/Fold</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript: otherSite()">Change Site</a>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
       <tr class="DataTable1">
         <th class="DataTable2" colspan=22 id="thTopTotal"></th>
       </tr>
         <tr class="DataTable">
             <th class="DataTable"><a href="javascript:resort('DIV')">Div</a></th>
             <th class="DataTable"><a href="javascript:resort('DPT')">Dpt</a></th>
             <th class="DataTable">Site</th>
             <th class="DataTable">Season/<br>Year Model</th>
             <th class="DataTable"><a href="javascript:resort('PROD')">Product</a></th>
             <th class="DataTable"><a href="javascript:resort('NAME')">Product Name</a></th>
             <th class="DataTable">Vendor<br>Style</th>
             <th class="DataTable">Color Name</th>
             <th class="DataTable">Size Name</th>
             <th class="DataTable">Price</th>
             <th class="DataTable">Items<br>In Str</th>
             <th class="DataTable">PO Due<br>in 30 Days</th>
             <th class="DataTable">PO Due<br>in 60 Days</th>
             <th class="DataTable">PO Due<br>in 90 Days</th>
             <th class="DataTable"><a href="javascript:resort('HIDE')">Hide</a></th>
             <th class="DataTable"><a href="javascript:resort('DESC')">Description</a></th>
             <th class="DataTable"><a href="javascript:resort('FEAT')">Feature</a></th>
             <!-- th class="DataTable"><a href="javascript:resort('PHOTO')">Photo</a></th>
             <th class="DataTable"><a href="javascript:resort('CATEG')">Category</a></th>
             <th class="DataTable"><a href="javascript:resort('OPTION')">Option</a></th>  -->
             <th class="DataTable">Weight</th>
             <th class="DataTable"><a href="javascript:resort('PRIORITY')">Priority</a></th>
             <th class="DataTable"><a href="javascript:resort('DONE')">Done</a></th>
             <th id="thAssign" class="DataTable"><a href="javascript:resort('ASSIGN')">Assigned</a></th>
             <th class="DataTable">Product<br>Note<br>Option</th>
             <th class="DataTable">Product<br>Note</th>
             <%if(bDltProd){%>
                <th id="thDelete" class="DataTable">Dlt</th>
             <%}%>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfProd; i++ )
         {
            prodlst.setDetail();
            String sDiv = prodlst.getDiv();
            String sDpt = prodlst.getDpt();
            String sProd = prodlst.getProd();
            boolean bParent = prodlst.getParent();
            String sHide = prodlst.getHide();
            String sDesc = prodlst.getDesc();
            String sFeature = prodlst.getFeature();
            String sPhoto = prodlst.getPhoto();
            String sCateg = prodlst.getCateg();
            boolean bPriority = prodlst.getPriority();
            String sAssign = prodlst.getAssign();
            boolean bDone = prodlst.getDone();
            String sProdName = prodlst.getProdName();
            String sClrName = prodlst.getClrName();
            String sSizName = prodlst.getSizName();
            String sSite = prodlst.getSite();
            String sOption = prodlst.getOption();
            String sPrice = prodlst.getPrice();
            String sInfoSls = prodlst.getInfoSls();
            String sItemCount = prodlst.getItemCount();
            String sSeas = prodlst.getSeason();
            String sModelYr = prodlst.getModelYr();
            String sModel = prodlst.getModel();
            String sNoteOption = prodlst.getNoteOption();
            String sNote = prodlst.getNote();
            String sDue30Qty = prodlst.getDue30Qty();
            String sDue60Qty = prodlst.getDue60Qty();   
            String sDue90Qty = prodlst.getDue90Qty();
            String sWgt = prodlst.getWgt();

            String sNoteOptText = " ";
            if(sNoteOption.equals("PHOTO")){ sNoteOptText = "Photo Not Available"; }
            else if(sNoteOption.equals("CONTENT")){ sNoteOptText = "Content Not Available"; }
            else if(sNoteOption.equals("PHOTOCONT")){ sNoteOptText = "Photo and Content Not Available"; }
            else if(sNoteOption.equals("UNKNOWN")){ sNoteOptText = "Unknown Style/Color/Size"; }
            else if(sNoteOption.equals("WEBCAT")){ sNoteOptText = "Web Category Missing"; }

            if(bParent)
            {
              iCountAll++;
              if(sDesc.equals("Y") && sFeature.equals("Y") && sPhoto.equals("Y")
                && sCateg.equals("Y") && sOption.equals("Y")) { iCountComplete++; }
            }

            String sLink = "https://www.sunandski.com/admin/TableViewer.asp?table=Products&IsASearch=Y&NOSAVE___Form_Submission_Token=C675318536E040D89D0435F0210747AC&NOSAVE___Is_Quick_Edit_Window=N&submit.search.x=++++++Search++++++&ProductCode="
              + sProd + "&CHECKBOX.Ships_By_Itself=Y&CHECKBOX.Additional_Handling_Indicator=Y&CHECKBOX.Oversized=Y&CHECKBOX.FreeShippingItem=Y&CHECKBOX.HideProduct=Y&CHECKBOX.Hide_When_OutOfStock=Y&CHECKBOX.EnableMultiChildAddToCart=Y&CHECKBOX.Private_Section_Customers_Only=Y&CHECKBOX.Hide_YouSave=Y&CHECKBOX.AllowPriceEdit=Y&CHECKBOX.Hide_FreeAccessories=Y&CHECKBOX.EnableOptions_InventoryControl=Y&CHECKBOX.AddToPO_Now=Y&CHECKBOX.DoNotAllowBackOrders=Y&CHECKBOX.AutoDropShip=Y";
            if (sSite.equals("2")) { sLink = "https://www.skichalet.com/admin/TableViewer.asp?table=Products&IsASearch=Y&NOSAVE___Form_Submission_Token=C675318536E040D89D0435F0210747AC&NOSAVE___Is_Quick_Edit_Window=N&submit.search.x=++++++Search++++++&ProductCode="
                     + sProd + "&CHECKBOX.Ships_By_Itself=Y&CHECKBOX.Additional_Handling_Indicator=Y&CHECKBOX.Oversized=Y&CHECKBOX.FreeShippingItem=Y&CHECKBOX.HideProduct=Y&CHECKBOX.Hide_When_OutOfStock=Y&CHECKBOX.EnableMultiChildAddToCart=Y&CHECKBOX.Private_Section_Customers_Only=Y&CHECKBOX.Hide_YouSave=Y&CHECKBOX.AllowPriceEdit=Y&CHECKBOX.Hide_FreeAccessories=Y&CHECKBOX.EnableOptions_InventoryControl=Y&CHECKBOX.AddToPO_Now=Y&CHECKBOX.DoNotAllowBackOrders=Y&CHECKBOX.AutoDropShip=Y"; }
            if (sSite.equals("3")) { sLink = "https://www.rebelboardsports.com/admin/TableViewer.asp?table=Products&IsASearch=Y&NOSAVE___Form_Submission_Token=C675318536E040D89D0435F0210747AC&NOSAVE___Is_Quick_Edit_Window=N&submit.search.x=++++++Search++++++&ProductCode="
              + sProd + "&CHECKBOX.Ships_By_Itself=Y&CHECKBOX.Additional_Handling_Indicator=Y&CHECKBOX.Oversized=Y&CHECKBOX.FreeShippingItem=Y&CHECKBOX.HideProduct=Y&CHECKBOX.Hide_When_OutOfStock=Y&CHECKBOX.EnableMultiChildAddToCart=Y&CHECKBOX.Private_Section_Customers_Only=Y&CHECKBOX.Hide_YouSave=Y&CHECKBOX.AllowPriceEdit=Y&CHECKBOX.Hide_FreeAccessories=Y&CHECKBOX.EnableOptions_InventoryControl=Y&CHECKBOX.AddToPO_Now=Y&CHECKBOX.DoNotAllowBackOrders=Y&CHECKBOX.AutoDropShip=Y"; }

        %>
         <tr id="trProd" class="DataTable<%if(bParent){%>1<%} else if(sInfoSls.equals("0")){%>0<%}%>">
            <td id="tdDiv" class="DataTable1" nowrap ><%=sDiv%></td>
            <td id="tdDpt" class="DataTable1" nowrap><%=sDpt%></td>
            <td id="tdDpt" class="DataTable1"><%if(sSite.equals("1")){%>Sun&Ski<%} else if(sSite.equals("2")) {%>SkiChl<%}else if(sSite.equals("3")) {%>Rebel<%}%></td>
            <td id="tdSeas" class="DataTable1" nowrap><%if(!bParent){%><%=sSeas + "/" + sModelYr%><%}%>&nbsp;</td>
            <td id="tdProd" class="DataTable1" nowrap>
               <%if(bParent) {%><a class="small" id="linkProd<%=i%>" href="<%=sLink%>" target="_blank"><%=sProd%></a>
               <%} else {%><%=sProd%><%}%></td>
            <td class="DataTable1" nowrap onMouseOver="showColName('Product Name', this)" onMouseOut="hideColName()"><%=sProdName%></td>
            <td id="tdModel" class="DataTable1" nowrap><%=sModel%></td>
            <td class="DataTable1" onMouseOver="showColName('Color Name', this)" onMouseOut="hideColName()"><%=sClrName%></td>
            <td class="DataTable1" onMouseOver="showColName('Size Name', this)" onMouseOut="hideColName()"><%=sSizName%></td>
            <td class="DataTable2" onMouseOver="showColName('Price', this)" onMouseOut="hideColName()">
                <%if(!bParent) {%><a href="javascript: getItemPrice('<%=sProd%>')" class="Small"><%=sPrice%></a><%} else {%><%=sPrice%><%}%>
            </td>
            
            <td class="DataTable2" onMouseOver="showColName('Item Count', this)" onMouseOut="hideColName()"><%=sItemCount%></td>
            <td class="DataTable2"><%=sDue30Qty%></td>
            <td class="DataTable2"><%=sDue60Qty%></td>
            <td class="DataTable2"><%=sDue90Qty%></td>
            
            
            <td class="DataTable1" nowrap onMouseOver="showColName('Hide', this)" onMouseOut="hideColName()"><%=sHide%></td>
            <td class="DataTable1" nowrap onMouseOver="showColName('Desc', this)" onMouseOut="hideColName()"><%=sDesc%></td>
            <td class="DataTable1" nowrap onMouseOver="showColName('Feature', this)" onMouseOut="hideColName()"><%=sFeature%></td>
            <!-- td class="DataTable1" nowrap onMouseOver="showColName('Photo', this)" onMouseOut="hideColName()"><%=sPhoto%></td>
            <td class="DataTable1" nowrap onMouseOver="showColName('Category', this)" onMouseOut="hideColName()"><%=sCateg%></td>
            <td class="DataTable1" nowrap onMouseOver="showColName('Option', this)" onMouseOut="hideColName()"><%=sOption%></td>  -->
            <td class="DataTable2"><%=sWgt%></td>
            <td id="tdPriority" class="DataTable" <%if(bParent && bChgProd) {%>onclick="markItem(<%=i%>, '<%=sProd%>', 'PRIORITY', '1')"<%}%>>
                 <%if(bPriority) {%><img src="Runner.jpg" width="25" height="25"><%}%></td>
            <td id="tdDone" class="DataTable" nowrap <%if(bParent && bChgProd) {%>onclick="markItem(<%=i%>, '<%=sProd%>', 'DONE', '1')"<%}%>>
                  <% if(bDone) {%><img src='Present_box.jpg' width='25' hight='25'><%}%>
            </td>
            <td id="tdAssign" <%if(bParent && bChgProd) {%>onMouseDown="selColumnCell(<%=i%>, '<%=sProd%>', 'ASSIGN')" <%}%> class="DataTable1" nowrap><%=sAssign%></td>

            <td id="tdNote" class="DataTable1" nowrap onMouseOver="showColName('Note Option', this)" onMouseOut="hideColName()">
                <a href="javascript: chgNoteOption('<%=sProd%>', <%=bParent%>, '<%=sNoteOption%>','<%=sNote%>')"><%if(!sNoteOption.equals("")){%><%=sNoteOptText%><%} else if(bParent){%>None<%}%></a>
            </td>
            <td id="tdNote" class="DataTable1" nowrap onMouseOver="showColName('Note', this)" onMouseOut="hideColName()"><%=sNote%></td>

            <%if(bDltProd){%>
               <td id="tdDelete" class="DataTable1"><a class="small"  href="javascript: markItem(<%=i%>, '<%=sProd%>', 'DELETE', <%if(bParent){%>'1'<%} else {%>'2'<%}%>)">D</a></td>
            <%}%>
          </tr>
       <%}%>

       <tr class="DataTable1">
         <th class="DataTable2" colspan=22 id="thBotTotal"></th>
       </tr>
     </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
    double dPrc = 0;
    if(iCountAll > 0)
    {
       dPrc = (double)iCountComplete / iCountAll * 10000;
       dPrc = Math.round(dPrc) / 100.00;
    }
%>
<script language="javascript">
  var html = "All Parents = <%=iCountAll%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
          + "Complete Parents = <%=iCountComplete%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
          +  "Complete Percent = <%=dPrc%>%";
  document.all.thTopTotal.innerHTML = html;
  document.all.thBotTotal.innerHTML = html;
</script>
<%
   prodlst.disconnect();
   }
%>
