<%@ page import="itemtransfer.ItemList, java.util.*"%>
<%
   String sDivision = request.getParameter("Div");
   String sDepartment = request.getParameter("Dpt");
   String sClass = request.getParameter("Cls");
   String sVendor = request.getParameter("Ven");
   String sSelSty = request.getParameter("Sty");
   String sRRN = request.getParameter("RRN");
   String sBatch = request.getParameter("Batch");
   String sBWhse = request.getParameter("BWhse");
   String sBComment = request.getParameter("BComment");

   if(sDivision == null) sDivision = "ALL";
   if(sDepartment == null) sDepartment = "ALL";
   if(sClass == null) sClass = "ALL";
   if(sClass == null) sVendor = "Vendor";
   if(sSelSty == null) sSelSty = "ALL";
   if(sRRN == null) sRRN = " ";

   ItemList itemLst = null;

   int iNumOfCVS = 0;
   String [] sCls = null;
   String [] sVen = null;
   String [] sSty = null;
   String [] sItmName = null;
   String [] sCost = null;
   String [] sRet = null;
   String [] sOrg = null;
   String [] sMdDate = null;
   String [] sFrtRct = null;
   String [] sLstRct = null;
   String sLastRRN = null;
   String [] sVST = null;
   String [] sCVSChainInv = null;
   String [] sCVSChainSls = null;

   String [] sEcomAttr = null;
   String [] sEcomCurQty = null;

   String sCVSJSA = null;
   String sCVSCellJSA = null;
   int iNumOfStr = 0;
   String [] sStr = null;

   String [][] sCVSInv = null;
   String [][] sCVSSls = null;
   String [][] sSellOff = null;
   String [] sTotSellOff = null;

   // Cls/Ven/Sty details
   int[] iNumOfItm = null;
   String [][] sClr = null;
   String [][] sSize = null;
   String [][] sSku = null;
   String [][] sChainInv = null;
   String [][] sChainSls = null;

   String [][][] sItmInv = null;
   String [][][] sItmSls = null;
   int iNumOfCell = 0;
   String sTrfCellJSA = null;
   String sTrfTypeJSA = null;
   String sTrfStsJSA = null;

   String sStrJSA = null;
   String sStrCls = null;

   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sAppl = "TRANSFER";
   String sStrAllowed = "";

   //System.out.println(session.getAttribute("USER") + " appl: " + session.getAttribute("APPLICATION"));
   if (session.getAttribute("USER")==null
    || session.getAttribute("APPLICATION") !=null
    && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     Enumeration  en = request.getParameterNames();
     String sParam =null;
     String sPrmValue = null;
     String sTarget = "PayrollSignOn.jsp?TARGET=ItemList.jsp&APPL=" + sAppl;
     StringBuffer sbQuery = new StringBuffer() ;

     while (en.hasMoreElements())
      {
        sParam = en.nextElement().toString();
        sPrmValue = request.getParameter(sParam);
          sbQuery.append("&" + sParam + "=" + sPrmValue);
      }

      response.sendRedirect(sTarget + sbQuery.toString());
   }
   else {
     sStrAllowed = session.getAttribute("STORE").toString().trim();
     if (!sStrAllowed.startsWith("ALL"))
     {
        response.sendRedirect("ItemSel.jsp");
     }

     //System.out.println(sDivision + "|" + sDepartment + "|" + sClass + "|" + sVendor + "|"
     //   + sSelSty + "|" + sBatch + "|" + sBComment + "|" + sRRN);
     itemLst = new ItemList(sDivision, sDepartment, sClass, sVendor, sSelSty, sBatch, sBComment, sRRN);

     iNumOfCVS = itemLst.getNumOfCVS();
     sCls = itemLst.getCls();
     sVen = itemLst.getVen();
     sSty = itemLst.getSty();
     sItmName = itemLst.getItmName();
     sCost = itemLst.getCost();
     sRet = itemLst.getRet();
     sOrg = itemLst.getOrg();
     sMdDate = itemLst.getMdDate();
     sFrtRct = itemLst.getFrtRct();
     sLstRct = itemLst.getLstRct();
     sLastRRN = itemLst.getLastRRN();
     sVST = itemLst.getVST();
     sCVSChainInv = itemLst.getCVSChainInv();
     sCVSChainSls = itemLst.getCVSChainSls();

     sEcomAttr = itemLst.getEcomAttr();
     sEcomCurQty = itemLst.getEcomCurQty();

     sCVSJSA = itemLst.getCVSJSA();
     sCVSCellJSA = itemLst.getCVSCellJSA();

     iNumOfStr = itemLst.getNumOfStr();
     sStr = itemLst.getStr();

     sCVSInv = itemLst.getCVSInv();
     sCVSSls = itemLst.getCVSSls();
     sSellOff = itemLst.getSellOff();
     sTotSellOff = itemLst.getTotSellOff();

   // Cls/Ven/Sty details
     iNumOfItm = itemLst.getNumOfItm();
     sClr = itemLst.getClr();
     sSize = itemLst.getSize();
     sSku = itemLst.getSku();
     sChainInv = itemLst.getChainInv();
     sChainSls = itemLst.getChainSls();

     sItmInv = itemLst.getItmInv();
     sItmSls = itemLst.getItmSls();
     iNumOfCell = itemLst.getNumOfCell();
     sTrfCellJSA = itemLst.getTrfCellJSA();
     sTrfTypeJSA = itemLst.getTrfTypeJSA();
     sTrfStsJSA = itemLst.getTrfStsJSA();

     sStrJSA = itemLst.getStrJSA();

     sBatch = itemLst.getBatch();

     itemLst.disconnect();
   }
   // color code for transfer items
   String [] sColor = new String[]{"255 255 0", "0 255 0",
                                   "255 105 180", "180 150 255",
                                   "255 69 0", "0 191 255"
                                   };
   boolean bTrfWhse = sBWhse.equals("W");
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:Cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable3 { background: #ccccff; font-family:Arial; font-size:10px }
        tr.DataTable4 { background: #ccffcc; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { cursor:hand; padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; text-align:left;}
        td.DataTable4 { padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: double darkred; border-right: darkred solid 1px;
                        text-align:left;}
        td.DataTable5 { cursor:hand; padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: double darkred; border-right: darkred solid 1px;
                        text-align:left;}
        td.DataTable6 { background:moccasin; cursor:hand; padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        text-align:left;}

        td.DataTable7 { background:moccasin; padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: double darkred; border-right: darkred solid 1px;
                        text-align:center;}
        td.DataTable8 { background:moccasin; cursor:hand; padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; text-align:left;}
        td.DataTable9 { background:moccasin; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable10 { padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        text-align:left;}

        td.DataTable11 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                         visibility:hidden;  text-align:right;}

        td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}

        td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}

        td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px; display: table-cell;  }

        <!-------- select another div/dpt/class pad ------->
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        input.Small1 {width:20; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }

        <!-------- transfer entry pad ------->
        div.fake { }
        div.dvTransfer { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvMenu { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; background-color:Azure; z-index:10;
              text-align:center; font-size:10px}

        td.Grid  { background:darkblue; color:white; text-align:center; font-family:Arial; font-size:11px; font-weight:bolder}
        td.Grid1 { text-align:left; font-family:Arial; font-size:10px;}
        td.Grid2  { background:darkblue; color:white; text-align:right;
                    font-family:Arial; font-size:11px; font-weight:bolder}
        td.Grid3 { text-align:center; font-family:Arial; font-size:10px;}

        td.Menu { cursor:hand; text-align:left; font-family:Arial; font-size:10px;}


        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:100; background-color:LemonChiffon; z-index:10;
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

        <!-------- end transfer entry pad ------->

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Division ="<%=sDivision%>";
var Department ="<%=sDepartment%>";


var Stores = [<%=sStrJSA%>];
var NumOfTrf = "<%=iNumOfCell%>";
var NumOfCVS = "<%=iNumOfCVS%>";
var TrfCell =[<%=sTrfCellJSA%>];
var TrfType = [<%=sTrfTypeJSA%>];
var TrfSts = [<%=sTrfStsJSA%>];
var CVSJSA = [<%=sCVSJSA%>];
var CVSCellJSA = [<%=sCVSCellJSA%>];

var trfFromCell = null;
var trfCls = null;
var trfVen = null;
var trfSty = null;
var trfClr = null;
var trfSize = null;
var trfFromStr = null;
var trfToStr = null;
var trfBegInv = 0;
var trfEndInv = 0;
var trfQty = 0;

var draged=false;
var disabledCell = new Array(1000);
var daCellMax = 0;

var TrfWhse = <%=bTrfWhse%>;
//--------------- End of Global variables ----------------
function bodyLoad()
{
   for(var i=0; i < NumOfTrf; i++)
   {
     if (TrfType[i]=="I" && TrfSts[i]=="O") { document.all[TrfCell[i]].style.backgroundColor="rgb(<%=sColor[0]%>)"; }
     else if (TrfType[i]=="D" && TrfSts[i]=="O"){ document.all[TrfCell[i]].style.backgroundColor="rgb(<%=sColor[1]%>)";}
     else if (TrfType[i]=="I" && TrfSts[i]=="A") { document.all[TrfCell[i]].style.backgroundColor="rgb(<%=sColor[2]%>)"; }
     else if (TrfType[i]=="D" && TrfSts[i]=="A") { document.all[TrfCell[i]].style.backgroundColor="rgb(<%=sColor[3]%>)"; }
     else if (TrfType[i]=="I" && TrfSts[i]=="I") { document.all[TrfCell[i]].style.backgroundColor="rgb(<%=sColor[4]%>)"; }
     else if (TrfType[i]=="D" && TrfSts[i]=="I") { document.all[TrfCell[i]].style.backgroundColor="rgb(<%=sColor[5]%>)"; }


     if (TrfType[i]=="D" || TrfSts[i]!="O")
     {
       document.all[TrfCell[i]].style.cursor="text";
       disabledCell[daCellMax++] = TrfCell[i];
     }
   }
   redispStrLine(1);
}


//---------------------------------------------------------------
//show next 30 Cls/Ven/Sty
//---------------------------------------------------------------
function showNextCVS()
{
  var url = "ItemList.jsp?"
          + "Div=<%=sDivision%>"
          + "&Dpt=<%=sDepartment%>"
          + "&Cls=<%=sClass%>"
          + "&Ven=<%=sVendor%>"
          + "&Batch=<%=sBatch%>"
          + "&BWhse=<%=sBWhse%>"
          + "&BComment=<%=sBComment%>"
          + "&RRN=<%=sLastRRN%>";
  window.location.href = url;
}

//--------------------------------------------------------------------------
// Show Item/CVS menue
//--------------------------------------------------------------------------
function showMenu(cls, ven, sty, clr, size, obj, ecomAttr, ecomQty)
{
  var pos = [0, 0];
  var menuHtml = "<table cellPadding='0' cellSpacing='0' width='100%'>"
         + "<tr align='center'>"
  if(clr == null){ menuHtml += "<td class='Grid' nowrap>" + cls  + "-" + ven + "-" + sty + "</td>"; }
  else { menuHtml += "<td class='Grid' nowrap>" + cls  + "-" + ven + "-" + sty + "-" + clr + "-" + size + "</td>"; }
  menuHtml +="<td  class='Grid2'>"
   + "<img src='CloseButton.bmp' onclick='hidedvTransfer();' alt='Close'>"
   + "</td></tr>"

   + "<tr><td class='Menu' onclick='displayTransfers(&#34;"
   + cls + "&#34;, &#34;" + ven + "&#34;, &#34;" + sty + "&#34;, &#34;"
   + clr + "&#34;, &#34;" + size + "&#34;)'>"
   + "<u>Display Transfers</u></td></tr>"

   + "<tr><td class='Menu' onclick='deleteTransfers(&#34;"
   + cls + "&#34;, &#34;" + ven + "&#34;, &#34;" + sty + "&#34;, &#34;"
   + clr + "&#34;, &#34;" + size + "&#34;)'>"
   + "<u>Delete Transfers</u></td></tr>"

   + "<tr><td class='Menu' onclick='addConsolidate(&#34;"
   + cls + "&#34;, &#34;" + ven + "&#34;, &#34;" + sty + "&#34;, &#34;"
   + clr + "&#34;, &#34;" + size + "&#34;)'>"
   + "<u>Consolidate Transfers</u></td></tr>"

   if(ecomAttr == "Y")
   {	   
      menuHtml += "<tr><td class='Menu' onclick='gotoVolusion(&#34;"
        + cls + "&#34;, &#34;" + ven + "&#34;, &#34;" + sty + "&#34;)'>"
        + "<u>ECOM in-stock(" + ecomQty + ")</u></td></tr>"
   }

   menuHtml += "<tr><td class='Menu' onclick='hidedvTransfer();'>"
   + "<u>Close Menu</u></td></tr>"


  pos = clcPosition(obj);

  document.all.dvTransfer.className="dvMenu";
  document.all.dvTransfer.innerHTML=menuHtml
  document.all.dvTransfer.style.width=150;
  document.all.dvTransfer.style.pixelLeft=pos[0];
  document.all.dvTransfer.style.pixelTop=pos[1];
  document.all.dvTransfer.style.visibility="visible"
}

function clcPosition(obj)
{
 var pos = [0, 0];

 if (obj.offsetParent) {
   while (obj.offsetParent){
     pos[0] += obj.offsetLeft
     pos[1] += obj.offsetTop
     obj = obj.offsetParent;
   }
 }
 else if (obj.x) {
    pos[0] += obj.x;
    pos[1] += obj.y;
 }

 pos[0] += 5;
 pos[1] += 20;
 return pos;
}

//---------------------------------------------------------
// Display list of transfers for selected item or CVS
//---------------------------------------------------------
function displayTransfers(cls, ven, sty, clr, size)
{
  var url = 'ItemTrfList.jsp?'
    + "DIVISION=" + Division
    + "&DEPARTMENT=" + Department
    + "&CLASS=" + cls
    + "&VENDOR=" + ven
    + "&STYLE=" + sty
 if(clr != "null")
 {
   url += "&COLOR=" + clr
       + "&SIZE=" + size
 }

  var WindowName = 'ItemTransferList';
  var WindowOptions =
   'width=700,height=300, left=100,top=50, resizable=yes , toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,menubar=no';

  //alert(url)
  window.open(url, WindowName, WindowOptions);
  hidedvTransfer();
}

//-------------------------------------------------------------
// Delete list of transfers for selected item or Cls/Ven/Sty
//-------------------------------------------------------------
function deleteTransfers(cls, ven, sty, clr, size)
{
  var url = 'ItemTrfEnt.jsp?'
    + "&CLASS=" + cls
    + "&VENDOR=" + ven
    + "&STYLE=" + sty
    + "&Batch=<%=sBatch%>"

 if(clr != "null")
 {
   url += "&COLOR=" + clr
       + "&SIZE=" + size
       + "&ACTION=DLTITM";
 }
 else url += "&ACTION=DLTCVS";

 // hide the panel
 hidedvTransfer();

 //alert(url);
 //window.location.href = url;
 window.frame1.location = url;
}

//-------------------------------------------------------------
// Add Consolidation transfers for selected item or Cls/Ven/Sty[/Clr/Siz]
//-------------------------------------------------------------
function addConsolidate(cls, ven, sty, clr, size)
{
  var trfHtml = null;

  trfCls = cls;
  trfVen = ven;
  trfSty = sty;
  trfClr = null;
  trfSize = null;

  trfHtml = "<table cellPadding='0' cellSpacing='0' width='100%'>"
         + "<tr align='center'>"
  if(clr == "null"){ trfHtml += "<td class='Grid'>Cls/Ven/Sty: " + cls  + "-" + ven + "-" + sty + "</td>"; }
  else {
         trfClr = clr;
         trfSize = size;
         trfHtml += "<td class='Grid'>Item:" + cls  + "-" + ven + "-" + sty + "-" + clr + "-" + size + "</td>"; }
  trfHtml +="<td  class='Grid2'>"
         + "<img src='CloseButton.bmp' onclick='javascript:hidedvTransfer();' alt='Close'>"
         + "</td></tr>"
         + "<tr><td class='Grid3' colsapn='2' nowrap>Destination store: <Select name='DestStr' class='Small'>"
         + "</Select><br>"
         + "<input name='Consolidate' type='button' class='Small' value='Consolidate' "
         + "onclick='javascript:consolidateTransfers(&#34;"
         + cls + "&#34;, &#34;" + ven + "&#34;, &#34;" + sty + "&#34;, &#34;"
         + clr + "&#34;, &#34;" + size + "&#34;);'>&nbsp;&nbsp;"
         + "<input name='Cancel' type='button' class='Small' value='Cancel' onclick='javascript:hidedvTransfer();'>"
         + "</td></tr>"

  trfHtml +="</table>"

  document.all.dvTransfer.className="dvTransfer";
  document.all.dvTransfer.innerHTML=trfHtml
  document.all.dvTransfer.style.width=200
  document.all.dvTransfer.style.pixelLeft=260
  document.all.dvTransfer.style.pixelTop=document.documentElement.scrollTop+20
  document.all.dvTransfer.style.visibility="visible"

  loadDestStr(0);

}
//-------------------------------------------------------------
// Consolidate transfers for selected item or Cls/Ven/Sty[/Clr/Siz]
//-------------------------------------------------------------
function consolidateTransfers(cls, ven, sty, clr, size)
{
  dst = document.all.DestStr.options[document.all.DestStr.selectedIndex].value
  var url = 'ItemTrfEnt.jsp?'
    + "&CLASS=" + cls
    + "&VENDOR=" + ven
    + "&STYLE=" + sty
  if(clr != "null")
  {
    url += "&COLOR=" + clr
       + "&SIZE=" + size
       + "&ACTION=CONITM";
  }
  else url += "&ACTION=CONCVS";

  url += "&ISTR=0"
     + "&DSTR=" + dst
     + "&QTY=0"
     + "&Batch=<%=sBatch%>"

 // hide the panel
 hidedvTransfer();

 //alert(url);
 //window.location.href = url;
 window.frame1.location = url;
}
//-------------------------------------------------------------
// goto Volusion
//-------------------------------------------------------------
function gotoVolusion(cls, ven, sty)
{
	var url ="http://www.sunandski.com/p/" + cls + ven + sty
    var WindowName = 'ECOM';
    var WindowOptions =
   'width=900,height=500, left=100,top=50, resizable=yes , toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,menubar=no';

  //alert(url)
  window.open(url, WindowName, WindowOptions);
  hidedvTransfer();
}
//--------------------------------------------------------------------------
// Transfer CVS to another store
//--------------------------------------------------------------------------
function transferCVS(str, cls, ven, sty, clr, size, inv, obj)
{
  var trfHtml = null;

  trfCls = cls;
  trfVen = ven;
  trfSty = sty;
  trfClr = clr;
  trfSize = size;
  trfFromCell = obj;
  trfBegInv = eval(inv);

  // return with error message if no inventory
  if(inv=="" ||  eval(inv) <= 0)
  {
    alert("No Items found in selected store");
    return;
  }

  trfHtml = "<table cellPadding='0' cellSpacing='0' width='100%'>"
         + "<tr align='center'>"
  if(clr == null){ trfHtml += "<td class='Grid'>Cls/Ven/Sty: " + cls  + "-" + ven + "-" + sty + "</td>"; }
  else { trfHtml += "<td class='Grid'>Item:" + cls  + "-" + ven + "-" + sty + "-" + clr + "-" + size + "</td>"; }
  trfHtml +="<td  class='Grid2'>"
         + "<img src='CloseButton.bmp' onclick='javascript:hidedvTransfer();' alt='Close'>"
         + "</td></tr>"
         + "<tr><td class='Grid1'>Issuing store: "
         + "<input name='IssStr' type='text' class='Small' value="
         + str + " maxlength='2' size='2' readonly></td></tr>"
         + "<tr><td class='Grid1'>Destination store: <Select name='DestStr' class='Small'>"
         + "</Select></td></tr>"
         + "<tr><td class='Grid1'>Quantity: "
         + "<input name='Quantity' type='text' class='Small' value="
         + inv + "  maxlength=9 size=9>&nbsp;&nbsp;"
         + "<input name='Add' type='button' class='Small' value='Add' onclick='javascript:addCVSTransfer();'>&nbsp;&nbsp;"
         + "<input name='Cancel' type='button' class='Small' value='Cancel' onclick='javascript:hidedvTransfer();'>"
         + "</td></tr>"

  trfHtml +="</table>"

  document.all.dvTransfer.className="dvTransfer";
  document.all.dvTransfer.innerHTML=trfHtml
  document.all.dvTransfer.style.width=250
  document.all.dvTransfer.style.pixelLeft=260
  document.all.dvTransfer.style.pixelTop=document.documentElement.scrollTop+20
  document.all.dvTransfer.style.visibility="visible"

  if(clr == null){ document.all.Quantity.readOnly=true; }
  loadDestStr(str);
}

//--------------------------------------------------------------------------
// Transfer Items to another store
//--------------------------------------------------------------------------
function transferItem(str, cls, ven, sty, clr, size, inv, obj)
{
  var trfHtml = null;

  trfCls = cls;
  trfVen = ven;
  trfSty = sty;
  trfClr = clr;
  trfSize = size;
  trfFromCell = obj;
  trfBegInv = eval(inv);

  // return with error message if no inventory
  if(inv=="" ||  eval(inv) <= 0)
  {
    alert("No Items found in selected store");
    return;
  }

  trfHtml = "<table cellPadding='0' cellSpacing='0' width='100%'>"
         + "<tr align='center'>"

  trfHtml += "<td class='Grid'>Item:" + cls  + "-" + ven + "-" + sty + "-" + clr + "-" + size + "</td>";
  trfHtml += "<td  class='Grid2'>"
         + "<img src='CloseButton.bmp' onclick='javascript:resetTransfer(" + str + ");hidedvTransfer();' alt='Close'>"
         + "</td></tr>"
         + "<tr><td class='Grid1'>Issuing store: "

         + "<input name='IssStr' type='text' class='Small' value="
         + str + " maxlength='2' size='2' readonly>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
         + "Qty: " + inv + "&nbsp;&nbsp;&nbsp;"

         + "Destributing: <input name='DestrInv' type='text' class='Small' value="
         + inv + " maxlength='5' size='5' onchange='chkDestrInv(" + inv + ")'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
         + "<span id='spnBalance'></span></td></tr>"

  trfHtml += "<tr><td>"
         + "<table class='DataTable1' cellPadding='0' cellSpacing='0'>"
         + "<tr class='DataTable2'><td class='DataTable' rowspan='2'>Destination stores:</td>"

  // Store numbers
  for(var i=0; i<Stores.length; i++)
  {
    if(Stores[i] != str)
    trfHtml += "<td class='DataTable'>" + Stores[i] + "</td>"
  }

  trfHtml += "</tr>"
         + "<tr class='DataTable2'>"
  // store check box
  for(var i=0; i<Stores.length; i++)
  {
    if(Stores[i] != str)
    trfHtml += "<td class='DataTable'><input name='DestStr" + i + "' class='Small' type=checkbox value='"
             + Stores[i] + "' onclick='dspQtyBox(" + i + ")'></td>"
  }

  trfHtml += "</tr>"
         + "<tr class='DataTable2'><td class='DataTable'>Quantity: "

  for(var i=0; i<Stores.length; i++)
  {
     if(Stores[i] != str)
     trfHtml += "<td class='DataTable11' id='Qty" + i +"'><input name='Quantity" + i + "' type='text' class='Small1'"
              + " maxlength=9 size=3 onkeyup='showBalance(" + str + ", this)'></td>"
  }
  trfHtml += "</tr>"

  trfHtml += "</table></td></tr>"

  trfHtml += "<tr><td><input name='Add' type='button' class='Small' value='Add' onclick='addItmTransfer(" + str + ");' disabled>&nbsp;&nbsp;"
         + "<input name='Cancel' type='button' class='Small' value='Cancel' onclick='resetTransfer(" + str + "); hidedvTransfer();'>&nbsp;&nbsp;"
         + "<input name='Reset' type='button' class='Small' value='Reset' onclick='resetTransfer(" + str + ");'>&nbsp;&nbsp;"
         + "<input name='Evenly' type='button' class='Small' value='Destribute Evenly' onclick='destrEvenly(" + str + ");' disabled>"
         + "</td></tr>"

  trfHtml +="</table>"

  document.all.dvTransfer.className="dvTransfer";
  document.all.dvTransfer.innerHTML=trfHtml
  document.all.dvTransfer.style.width=250
  document.all.dvTransfer.style.pixelLeft=260
  document.all.dvTransfer.style.pixelTop=document.documentElement.scrollTop+20
  document.all.dvTransfer.style.visibility="visible"

}

//-------------------------------------------------------------
// load destination Store select on transfer entry panel
//-------------------------------------------------------------
function  loadDestStr(str)
{
  for(var i=0, j=0; i < Stores.length; i++)
  {
    if (Stores[i] != str)
    {
      document.all.DestStr.options[j++] = new Option(Stores[i], Stores[i]);
    }
  }
}
//-------------------------------------------------------------
// check entered destributing value
//-------------------------------------------------------------
function chkDestrInv(inv)
{
  var dst = document.all.DestrInv.value;
  if(isNaN(dst) || dst < 1 || dst > inv || dst == "" || dst.substring(0, 3) == " ")
  {
     document.all.DestrInv.value=inv;
  }
}
//-------------------------------------------------------------
// display destributed quantity
//-------------------------------------------------------------
function showBalance(str, box)
{
  var sum=0;
  var inpbox = null;
  var chkbox = null;
  var spnHTML = null

  var inv = document.all.DestrInv.value;
  // return for empty box
  //if(box.value == "" || box.value.substring(0,1) == " ")  { return; }
  if(!isNaN(box.value))
  {
    for(var i=0; i < Stores.length; i++)
    {
      if(Stores[i] != str)
      {
        chkbox = "DestStr" + i;
        if(document.all[chkbox].checked)
        {
           inpbox = "Quantity" + i;
           if(!document.all[inpbox].value == "" && !document.all[inpbox].value.substring(0,1) == " ")
           {
             sum += eval(document.all[inpbox].value);
           }
        }
      }
    }
    //check if value is not grater than inventory
    spnHTML = "Destributed: " + sum;
    if (inv < sum)
    {
      spnHTML += "<font color=red> ==> is greater than destributing quantity!!!</font>";
      document.all.Add.disabled=true;
    }
    else { document.all.Add.disabled=false }
    document.all.spnBalance.innerHTML=spnHTML;
  }
  else
  {
    document.all.spnBalance.innerHTML= "&#34;" + box.value  + "&#34;"
      + "<font color=red> is not a valid number!!!</font>";
      document.all.Add.disabled=true;
  }

}

//-------------------------------------------------------------
// display/hide Quantity input fields for checked item
//-------------------------------------------------------------
function dspQtyBox(strIdx)
{
   var cell = "Qty" + strIdx;
   var inpbox = "Quantity" + strIdx;
   var chkbox = "DestStr" + strIdx;

   if(document.all[chkbox].checked)
   {
     document.all[cell].style.visibility = "visible";
     document.all.Evenly.disabled=false;
   }
   else
   {
     document.all[cell].style.visibility = "hidden";
     document.all[inpbox].value = "";
     document.all.spnBalance.innerHTML="";
   }
}

//-------------------------------------------------------------
// reset Transfer pannel
//-------------------------------------------------------------
function resetTransfer(str)
{
  var chkbox = null;
  var inpbox = null;
  var cell = null;
  for(var i=0; i < Stores.length; i++)
  {
    if (Stores[i] != str)
    {
      chkbox = "DestStr" + i;
      document.all[chkbox].checked = false;
      inpbox = "Quantity" + i;
      document.all[inpbox].value = "";
      cell = "Qty" + i;
      document.all[cell].style.visibility = "hidden";
    }
  }
  document.all.Add.disabled=true;
  document.all.Evenly.disabled=true;
  document.all.spnBalance.innerHTML="";
}


//-------------------------------------------------------------
// Add Item Transfers
//-------------------------------------------------------------
function destrEvenly(str)
{
  var inv = document.all.DestrInv.value;
  var qty = 0;
  var rmd = inv;
  var max=0;
  var boxes = new Array(Stores.length);
  var inpbox = null;
  var chkbox = null;
  var spnHTML = null;

  // get nuber of checked stores
  for(var i=0; i < Stores.length; i++)
  {
    if(Stores[i] != str)
    {
      chkbox = "DestStr" + i;
      if(document.all[chkbox].checked)
      {
         boxes[max]=document.all["Quantity" + i];
         boxes[max].value = 0;
         max++;
      }
    }
  }

  // destribute items
  if(max > 0)
  {
    qty = getQuantity(inv, max)
    var left = 0;
    if (qty * max < inv) left = inv - qty * max;
    var bx = 0;
    var current = 0;

    do
    {
      if(bx == max) { bx = 0; }

      if (rmd >= qty)
      {
        current = eval(boxes[bx].value)
        // destribute remainder
        if (left > 0)
        {
          current++;
          left = left - 1
          rmd = rmd - 1
        }
        boxes[bx].value = current + qty;
        rmd = rmd - qty;
      }
      if (rmd < qty && qty > 1)  { qty = 1; }
      bx++;
    } while(rmd > 0)
  }
  document.all.Add.disabled=false;
}

//--------------------------------------------------------------------------------
// calculate number of items per selected store for "Destribute Evenly" button
//--------------------------------------------------------------------------------
function getQuantity(inv, boxes)
{
  var qty = inv / boxes
  if (qty < 1) qty = 1;
  else if(Math.round(qty) * boxes > inv)  qty = Math.round(qty) - 1;
  else { qty = Math.round(qty) }
  return qty;
}
//-------------------------------------------------------------
// Add Item Transfers
//-------------------------------------------------------------
function addItmTransfer(str)
{
 var url = null;
 var ist = document.all.IssStr.value;
 var qty = new Array(Stores.length);
 var dst = new Array(Stores.length);
 var chkbox = null;
 var inpbox = null;
 var j = -1;

 for(var i=0; i < Stores.length; i++)
 {
    chkbox = "DestStr" + i;
    inpbox = "Quantity" + i;
    if(Stores[i] != str && document.all[chkbox].checked && document.all[inpbox].value > 0)
    {
      j++;
      qty[j] = document.all[inpbox].value;
      dst[j] = Stores[i];
    }
  }


 if (j < 0 ) { alert("There are no transfered items!!!") }
 else {
   url = "ItemTrfEnt.jsp?"
    + "CLASS=" + trfCls + "&VENDOR=" + trfVen + "&STYLE=" + trfSty + "&COLOR=" + trfClr
    + "&SIZE=" + trfSize
    + "&ISTR=" + ist
    + "&Batch=<%=sBatch%>";

   for(var i=0; i <= j; i++)
   {
     url += "&DSTRARR=" + dst[i]
      + "&QTYARR=" + qty[i];
   }

   url += "&ACTION=ADDITM";

   //alert(url);
   //window.location.href = url;
   window.frame1.location = url;
   // hide the panel
   resetTransfer(str);
   hidedvTransfer();
  }
}

//-------------------------------------------------------------
// Add CVS Transfer
//-------------------------------------------------------------
function addCVSTransfer()
{
 var ist = document.all.IssStr.value;
 var dst = document.all.DestStr.options[document.all.DestStr.selectedIndex].value;
 var qty = document.all.Quantity.value;

 trfToStr = dst;
 trfEndInv = eval(trfBegInv) - eval(qty);
 trfQty = eval(qty);

 var url = "ItemTrfEnt.jsp?"
         + "CLASS=" + trfCls
         + "&VENDOR=" + trfVen
         + "&STYLE=" + trfSty
 if(trfClr != null)
 {
   url += "&COLOR=" + trfClr
       + "&SIZE=" + trfSize
 }

 url += "&ISTR=" + ist
     + "&DSTR=" + dst
     + "&QTY=" + qty
     + "&Batch=<%=sBatch%>"
     + "&ACTION=ADD";

 // hide the panel
 hidedvTransfer();

 //alert(url);
 //window.location.href = url;
 window.frame1.location = url;
}

//------------------------------------------------------------------------
// drag data
//------------------------------------------------------------------------
function dragData(str, cls, ven, sty, clr, size, obj)
{
  var inv = 0;

  if(isNum(escape(obj.innerHTML))) { inv = eval(escape(obj.innerHTML));}
  // return with error message if no inventory
  if(eval(inv) <= 0)
  {
    alert("No Items found in selected store");
    return;
  }
  else if(TrfWhse && str != 1 && str != 70)
  {
    alert("Selected store is not warehouse.\nYou must select store 1 or 70 for this batch.");
    return;
  }
  else if(!TrfWhse && (str == 1 || str == 70))
  {
    alert("Selected Store is warehouse.\n You should not select store 1 or 70 for this batch.");
    return;
  }

  if(!isCellAvailable(obj.id))
  {
    alert("Operation is Unavailable");
    return;
  }

  draged=true;
  trfFromCell = obj;
  trfFromStr = str;
  trfCls = cls;
  trfVen = ven;
  trfSty = sty;
  trfClr = clr;
  trfSize = size;
  trfBegInv = eval(inv);
  trfQty = eval(inv);
}

//------------------------------------------------------------------------
// show  draged data in small panel
//------------------------------------------------------------------------
function showDragedCell()
{
  var dragHtml = "From: " + trfFromStr
      + " Qty: " + trfBegInv + " To: <span id=Dest></span>"
      + "&nbsp;<a href='javascript: releaseData()'>close</a>"
      + "<br><span id=Permission style='color:red'></span>"

  document.all.dvTransfer.className="dvTransfer";
  document.all.dvTransfer.innerHTML=dragHtml
  document.all.dvTransfer.style.width=200;
  document.all.dvTransfer.style.pixelLeft=260;
  document.all.dvTransfer.style.pixelTop=document.documentElement.scrollTop+20;
  document.all.dvTransfer.style.visibility="visible"
}

//------------------------------------------------------------------------
// drop data
//------------------------------------------------------------------------
function dropData(str, cls, ven, sty, clr, size, inv, obj)
{
  trfToStr=str;
  trfEndInv = 0;

  if (str != trfFromStr && cls==trfCls && ven==trfVen && sty==trfSty && clr==trfClr && size==trfSize)
  {
    var url = "ItemTrfEnt.jsp?"
           + "CLASS=" + trfCls
           + "&VENDOR=" + trfVen
           + "&STYLE=" + trfSty
    if(clr != null)  { url += "&COLOR=" + trfClr + "&SIZE=" + trfSize }

    url += "&ISTR=" + trfFromStr
        + "&DSTR=" + str
        + "&QTY=" + trfQty
        + "&Batch=<%=sBatch%>"
        + "&ACTION=ADD";

    // hide the panel
    hidedvTransfer();

    //alert(url);
    //window.location.href = url;
    window.frame1.location = url;
    draged=false;
  }
  else if(str == trfFromStr && cls==trfCls && ven==trfVen && sty==trfSty && clr==trfClr && size==trfSize)
  {
     releaseData();
     if(clr == null)
     {
       transferCVS(trfFromStr, trfCls, trfVen, trfSty, trfClr, trfSize, trfBegInv, trfFromCell);
     }
     else
     {
       transferItem(trfFromStr, trfCls, trfVen, trfSty, trfClr, trfSize, trfBegInv, trfFromCell);
     }
  }
  else releaseData();
}
//-------------------------------------------------------------
// Confirm entery of new Transfer
//-------------------------------------------------------------
function cnfAddTrf(NumOfCell, Cell, CellIO, CellSts, CellInv)
{
  //alert(NumOfCell + "\nIO: " + CellIO + "\nInv: "+ CellInv)
  chgDestStrCellForAllItems(NumOfCell, Cell, CellIO, CellSts, CellInv);
}

//-------------------------------------------------------------
// Confirm entery of new consolidate Transfer
//-------------------------------------------------------------
function cnfConTrf(NumOfCell, Cell, CellIO, CellSts, CellInv, Error)
{
  //alert(NumOfCell + "\n" + Cell + "\n" + CellIO + "\n" + CellSts + "\n"+ CellInv)
  var errmsg = "There is at least one transfer already exist for selected item(s)."
       + "\nPlease, delete all existing transfers before consolidation."
  if (Error == "1") alert(errmsg);
  else chgDestStrCellForAllItems(NumOfCell, Cell, CellIO, CellSts, CellInv);
}
//------------------------------------------------------------------------
// lock all color/size for this style
//------------------------------------------------------------------------
function  chgDestStrCellForAllItems(NumOfCell, Cell, CellIO, CellSts, CellInv)
{
  var csCell = null, csCellId = null, frmInv=null, toInv=null;

  for(var i=0; i < NumOfCell; i++)
  {
     if (CellIO[i]=="" && CellSts[i]=="" && Cell[i].substring(0,1)=="i")
          { document.all[Cell[i]].style.backgroundColor="lightgrey"; }
     if (CellIO[i]=="" && CellSts[i]=="" && Cell[i].substring(0,1)=="c")
          { document.all[Cell[i]].style.backgroundColor="seashell"; }
     else if (CellIO[i]=="I" && CellSts[i]=="O") { document.all[Cell[i]].style.backgroundColor="rgb(<%=sColor[0]%>)"; }
     else if (CellIO[i]=="D" && CellSts[i]=="O"){ document.all[Cell[i]].style.backgroundColor="rgb(<%=sColor[1]%>)";}
     else if (CellIO[i]=="I" && CellSts[i]=="A") { document.all[Cell[i]].style.backgroundColor="rgb(<%=sColor[2]%>)"; }
     else if (CellIO[i]=="D" && CellSts[i]=="A") { document.all[Cell[i]].style.backgroundColor="rgb(<%=sColor[3]%>)"; }
     else if (CellIO[i]=="I" && CellSts[i]=="I") { document.all[Cell[i]].style.backgroundColor="rgb(<%=sColor[4]%>)"; }
     else if (CellIO[i]=="D" && CellSts[i]=="I") { document.all[Cell[i]].style.backgroundColor="rgb(<%=sColor[5]%>)"; }

    // if(CellInv[i]!="") alert(CellInv[i])
    document.all[Cell[i]].innerHTML=CellInv[i];
    if (CellIO[i]=="D" || CellSts[i] != "O" && CellSts[i]!="")
    {
      document.all[Cell[i]].style.cursor="text";
      disabledCell[daCellMax++] = Cell[i];
    }
    else  document.all[Cell[i]].style.cursor="hand";


    setCellAvailable(Cell[i]);
  }

}


//------------------------------------------------------------------------
// realese drag data
//------------------------------------------------------------------------
function releaseData()
{
  hidedvTransfer();
  draged=false;
}
//------------------------------------------------------------------------
// close transfer entry panel
//------------------------------------------------------------------------
function hidedvTransfer(){
    document.all.dvTransfer.style.visibility="hidden"
}

//------------------------------------------------------------------------
// check if tested value is numeric
function isNum(str) {
  if(!str) return false;
  for(var i=0; i < str.length; i++){
    var ch=str.charAt(i);
    if ("0123456789".indexOf(ch) ==-1) return false;
  }
  return true;
}


function colapse()
{
  var style = document.styleSheets[0].rules[7].style.display;
  if(style != "none")
  {
    document.styleSheets[0].rules[7].style.display="none";
  }
  else
  {
    document.styleSheets[0].rules[7].style.display="block";
  }
}

//------------------------------------------------------------------------
// check if operation on cell allowed
//------------------------------------------------------------------------

function isCellAvailable(objId)
{
  var avail = true;
  for(var i=0; i < daCellMax; i++)
  {
    if(objId==disabledCell[i])
    {
      avail=false;
      break;
    }
  }
  return avail;
}

//------------------------------------------------------------------------
// set Cell available again
//------------------------------------------------------------------------
function setCellAvailable(objId)
{
  for(var i=0; i < daCellMax; i++)
  {
    if(objId==disabledCell[i])
    {
      disabledCell[i] = "";
    }
  }
}



// -------------------------------------------------------------------
//                       Move Boxes
//--------------------------------------------------------------------
var dragapproved=false
var z,x,y
function move(){
if (event.button==1&&dragapproved){
z.style.pixelLeft=temp1+event.clientX-x
z.style.pixelTop=temp2+event.clientY-y
return false
}
}
function drags()
{
  if (!document.all) return;
  var obj = event.srcElement

  if (event.srcElement.className=="Grid")
  {
    while (obj.offsetParent)
    {
      if (obj.id=="dvTransfer")
      {
        z=obj;
        break;
      }
      obj = obj.offsetParent;
    }
    dragapproved=true;
    temp1=z.style.pixelLeft
    temp2=z.style.pixelTop
    x=event.clientX
    y=event.clientY
    document.onmousemove=move
  }

  // move table cell data
  if ((event.srcElement.className=="StrInv"
    || event.srcElement.className=="StrInv1") && draged==true)
  {
    z=obj;
    dragapproved=true;
    temp1=z.style.pixelLeft
    temp2=z.style.pixelTop
    x=event.clientX
    y=event.clientY
    document.onmousemove=move
    showDragedCell();
  }
}


/* show store number that cursor is moving over to help
   user drop in right box */
function chgDragBox(str, cls, ven, sty, clr, size, inv, obj)
{
  document.all.Dest.innerHTML=str;
  //check if items can be droped in this shell
  if (cls==trfCls && ven==trfVen && sty==trfSty && clr==trfClr && size==trfSize)
        document.all.Permission.innerHTML="(!) OK (!)";
  else  document.all.Permission.innerHTML="(!) Do not drop (!)";
}

document.onmousedown=drags
document.onmouseup=new Function("dragapproved=false")
// ---------------- End of Move Boxes ---------------------------------------

// -------------------------------------------------------
// redisplay store headings with selected freaquency
// -------------------------------------------------------
function redispStrLine(idx)
{
  var stlId = null;

  for(var i=0, cnt=1 ; i < NumOfCVS; i++, cnt++)
  {
    stlId = "STRHDR"+i;
    if (cnt == idx)
    {   
      document.all[stlId].style.display = "table-row";
      cnt=0;
    }
    else document.all[stlId].style.display="none";
  }
}
//==============================================================================
// get PO List
//==============================================================================
function getPOList(cls, ven, sty, clr, siz)
{
   var url = "ItemPOList.jsp?Str=1"
     + "&Cls=" + cls
     + "&Ven=" + ven
     + "&Sty=" + sty
     + "&Clr=" + clr
     + "&Siz=" + siz

   //alert(url)
   //window.location.href = url
   window.frame1.location.href = url
}
//==============================================================================
// show PO List
//==============================================================================
function showPOList(ponum, antDt, poqty)
{
  var hdr = "PO List";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popPOList(ponum, antDt, poqty);

   html += "</td></tr></table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.width = 250;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 150;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";
}

//--------------------------------------------------------
// populate Column Panel for update
//--------------------------------------------------------
function popPOList(ponum, antDt, poqty)
{
  var dummy = "<table>";
  var panel = "<table border=1 width='100%' cellPadding='3' cellSpacing='0'>"

  panel += "<tr class='DataTable3'>"
          + "<th nowrap>PO Number</th>"
          + "<th nowrap>Anticipation<br>Delivery Date</th>"
          + "<th>Qty</th>"
        + "</tr>"

  for(var i=0; i < ponum.length; i++)
  {
     panel += "<tr class='DataTable4'>"
           + "<td nowrap>" + ponum[i] + "</td>"
           + "<td nowrap>" + antDt[i] + "</td>"
           + "<td nowrap>" + poqty[i] + "</td>"
         + "</tr>"
  }

  panel += "<tr class='DataTable4'><td class='Prompt1' colspan=3>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}

</SCRIPT>


</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe id="frame1" src=""  height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
  <div id="dvTransfer"></div>
<!-------------------------------------------------------------------->
  <div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">

      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Transfer Request Selection
      <br>Div: <%=sDivision%> &nbsp;&nbsp
          Dpt: <%=sDepartment%> &nbsp;&nbsp
          Class: <%=sClass%> &nbsp;&nbsp
      <br>Batch: <%=sBComment%><br><%if(sBWhse.equals("W")){%>(From Warehouse - Located Stock Only)<%} else {%>(From Stores)<%}%>
      </b>
     <tr bgColor="moccasin">
      <td ALIGN="left" VALIGN="TOP">


<!-- ------------ Legend -------------- -->
  <table border=0 cellPadding="0" cellSpacing="0">
   <tr>
     <td>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
       <tr><th class="DataTable">Status</th><th class="DataTable">From</th><th class="DataTable">&nbsp;&nbsp;To&nbsp;&nbsp;</th></tr>
        <tr class="DataTable">
          <td style="border-top: darkred solid 1px; border-right: darkred solid 1px">Pending</td>
          <td style="background: rgb(<%=sColor[0]%>); border-top: darkred solid 1px; border-right: darkred solid 1px" >&nbsp;</td>
          <td style="background: rgb(<%=sColor[1]%>); border-top: darkred solid 1px">&nbsp;</td>
       </tr>
        <tr class="DataTable">
          <td style="border-top: darkred solid 1px; border-right: darkred solid 1px">Approved</td>
          <td style="background: rgb(<%=sColor[2]%>); border-top: darkred solid 1px; border-right: darkred solid 1px" >&nbsp;</td>
          <td style="background: rgb(<%=sColor[3]%>); border-top: darkred solid 1px">&nbsp;</td>
        </tr>
        <tr class="DataTable">
          <td style="border-top: darkred solid 1px; border-right: darkred solid 1px">In Progress</td>
          <td style="background: rgb(<%=sColor[4]%>); border-top: darkred solid 1px; border-right: darkred solid 1px" >&nbsp;</td>
          <td style="background: rgb(<%=sColor[5]%>); border-top: darkred solid 1px">&nbsp;</td>
        </tr>

      </table >
    </td>
    <td style="font-size:10px;vertical-align: bottom;"> &nbsp; * - selloff percentage calculation does not include negative inventory.</td>
   </tr>
  </table >
   <!-- ----Aquamarine-------- End Legend -------------- -->

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="ItemSel.jsp">
         <font color="red" size="-1">Select Items</font></a>&#62;<font size="-1">
      This Page.
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

      <!-- Show Next 30 records buttons -->
      <%if(session.getAttribute("USER")!=null && !sLastRRN.trim().equals("EOF")){%>
         <a href="javascript: showNextCVS();">Next Items</a>
      <%}%>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

      <!-- Change number of visible store number lines -->
      Show store numbers on every
      <a href="javascript: redispStrLine(1)">1</a>,&nbsp;
      <a href="javascript: redispStrLine(2)">2</a>,&nbsp;
      <a href="javascript: redispStrLine(3)">3</a>,&nbsp;
      <a href="javascript: redispStrLine(4)">4</a>,&nbsp;
      <a href="javascript: redispStrLine(5)">5</a>&nbsp;
      style
      </font>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" rowspan="2" colspan="2">Item Number<br>
              <a href="javascript:colapse();">Fold/Unfold</a></th>
          <th class="DataTable" rowspan="2" colspan="2">Chain</th>
          <th class="DataTable" colspan="<%=iNumOfStr * 2 - 1%>">Stores</th>
          <th class="DataTable" rowspan="2" colspan="2">Item Number<br>
              <a href="javascript:colapse();">Fold/Unfold</a></th>
        </tr>

        <tr>
          <%for(int i=0; i<iNumOfStr; i++){%>
             <%if(sStr[i].equals("99")){%>
               <th class="DataTable"><%=sStr[i]%></th>
             <%}
             else {%>
               <th class="DataTable" colspan="2"><%=sStr[i]%></th>
             <%}%>
          <%}%>
        </tr>

        <tr>
          <th class="DataTable">Class-Ven-Sty</th>
          <th class="DataTable">Clr-Size</th>

          <th class="DataTable">Inv</th>
          <th class="DataTable">Sls</th>

          <%for(int i=0; i<iNumOfStr; i++){%>
             <%if(sStr[i].equals("99")){%>
                <th class="DataTable">Inv</th>
             <%}
               else {%>
                <th class="DataTable">Inv</th>
                <th class="DataTable">Sls</th>
             <%}%>
          <%}%>

          <th class="DataTable">Clr-Size</th>
          <th class="DataTable">Class-Ven-Sty</th>
        </tr>

<!------------------------------- Detail Data --------------------------------->
  <%for(int i=0; i < iNumOfCVS; i++) {%>
  <!-------------------------------Item Detail ---------------------------------->
  <%for(int j=0; j < iNumOfItm[i]; j++) {%>
    <tr  class="DataTable">
        <td class="DataTable1" nowrap
            onclick="showMenu('<%=sCls[i]%>', '<%=sVen[i]%>',  '<%=sSty[i]%>', '<%=sClr[i][j]%>', '<%=sSize[i][j]%>', this, '<%=sEcomAttr[i]%>', '<%=sEcomCurQty[i]%>' )">
            <%if(j==0){%><%=sCls[i] + "-" + sVen[i] + "-" + sSty[i]%><%} else {%>&nbsp;<%}%></td>

        <td class="DataTable1" nowrap><a href="javascript: getPOList('<%=sCls[i]%>', '<%=sVen[i]%>', '<%=sSty[i]%>', '<%=sClr[i][j]%>', '<%=sSize[i][j]%>')"><%=sClr[i][j] + "-" + sSize[i][j]%></a></td>
        <td class="DataTable8" nowrap>&nbsp;<%=sChainInv[i][j]%></td>
        <td class="DataTable9" nowrap>&nbsp;<%=sChainSls[i][j]%></td>
        <!-- store inv & dtl on item Level -->

        <%for(int k=0; k < iNumOfStr; k++){%>
            <!-- ----------------- -->
          <%if(sStr[k].equals("99")){%>
            <td class="StrInv1"  nowrap
                id="i<%=sCls[i]%><%=sVen[i]%><%=sSty[i]%><%=sClr[i][j]%><%=sSize[i][j]%>-<%=sStr[k]%>"
                onmouseup="dropData('<%=sStr[k]%>','<%=sCls[i]%>', '<%=sVen[i]%>',  '<%=sSty[i]%>', '<%=sClr[i][j]%>', '<%=sSize[i][j]%>', '<%=sItmInv[i][j][k]%>', this)"
                onmouseover="if(draged==true){chgDragBox('<%=sStr[k]%>','<%=sCls[i]%>', '<%=sVen[i]%>',  '<%=sSty[i]%>', '<%=sClr[i][j]%>', '<%=sSize[i][j]%>', '<%=sItmInv[i][j][k]%>', this)}"
                ><%=sItmInv[i][j][k]%></td>
            <%}
            else {%>
            <td class="StrInv" nowrap
                id="i<%=sCls[i]%><%=sVen[i]%><%=sSty[i]%><%=sClr[i][j]%><%=sSize[i][j]%>-<%=sStr[k]%>"
                onmousedown="dragData('<%=sStr[k]%>','<%=sCls[i]%>', '<%=sVen[i]%>',  '<%=sSty[i]%>', '<%=sClr[i][j]%>', '<%=sSize[i][j]%>', this)"
                onmouseup="dropData('<%=sStr[k]%>','<%=sCls[i]%>', '<%=sVen[i]%>',  '<%=sSty[i]%>', '<%=sClr[i][j]%>', '<%=sSize[i][j]%>', '<%=sItmInv[i][j][k]%>', this)"
                onmouseover="if(draged==true){chgDragBox('<%=sStr[k]%>','<%=sCls[i]%>', '<%=sVen[i]%>',  '<%=sSty[i]%>', '<%=sClr[i][j]%>', '<%=sSize[i][j]%>', '<%=sItmInv[i][j][k]%>', this)}"
                ><%=sItmInv[i][j][k]%></td>
          <%}%>

            <%if(!sStr[k].equals("99")){%>
               <td class="DataTable10" onmouseup="releaseData()">&nbsp;<%=sItmSls[i][j][k]%></td>
            <%}%>
        <%}%>

        <td class="DataTable1" nowrap><%=sClr[i][j] + "-" + sSize[i][j]%></td>
        <td class="DataTable1" nowrap
            onclick="showMenu('<%=sCls[i]%>', '<%=sVen[i]%>',  '<%=sSty[i]%>', '<%=sClr[i][j]%>', '<%=sSize[i][j]%>', this, '<%=sEcomAttr[i]%>', '<%=sEcomCurQty[i]%>')">
            <%if(j==0){%><%=sCls[i] + "-" + sVen[i] + "-" + sSty[i]%><%} else {%>&nbsp;<%}%></td>
    </tr>
  <%}%>
<!-------------------------------End Item Detail ------------------------------>
  <!------------------------------- CVS Detail --------------------------------->
    <tr class="DataTable1">
      <td class="DataTable5" nowrap rowspan="2" colspan="2"
          onclick="showMenu('<%=sCls[i]%>', '<%=sVen[i]%>',  '<%=sSty[i]%>', null, null, this, '<%=sEcomAttr[i]%>', '<%=sEcomCurQty[i]%>')">
        <span style="font-size:11px; font-weight:bolder"><%=sItmName[i]%></span><br>
        C: <%=sCost[i]%>&nbsp;&nbsp;R: <%=sRet[i]%>&nbsp;&nbsp;OR: <%=sOrg[i]%><br>
        M: <%=sMdDate[i]%>&nbsp;&nbsp;VST: <%=sVST[i]%><br>
        FR: <%=sFrtRct[i]%>&nbsp;&nbsp;LR: <%=sLstRct[i]%>
      </td>

      <td class="DataTable8" nowrap>&nbsp;<%=sCVSChainInv[i]%></td>
      <td class="DataTable9" nowrap>&nbsp;<%=sCVSChainSls[i]%></td>

      <!-- store inv & dtl on CVS Level -->
      <%for(int j=0; j < iNumOfStr; j++){%>
      <!-- ----------------- -->
       <%if(sStr[j].equals("99")){%>
         <td class="StrInv1"
           id="c<%=sCls[i]%><%=sVen[i]%><%=sSty[i]%>-<%=sStr[j]%>"
           onmouseup="dropData('<%=sStr[j]%>','<%=sCls[i]%>', '<%=sVen[i]%>', '<%=sSty[i]%>', null, '<%=iNumOfItm[i]%>', '<%=sCVSInv[i][j]%>', this)"
           onmouseover="if(draged==true){chgDragBox('<%=sStr[j]%>','<%=sCls[i]%>', '<%=sVen[i]%>', '<%=sSty[i]%>', null, <%=iNumOfItm[i]%>, '<%=sCVSInv[i][j]%>', this)}">
           <%=sCVSInv[i][j]%></td>
         <%}
         else {%>
           <td class="StrInv"
           id="c<%=sCls[i]%><%=sVen[i]%><%=sSty[i]%>-<%=sStr[j]%>"
           onmousedown="dragData('<%=sStr[j]%>','<%=sCls[i]%>', '<%=sVen[i]%>', '<%=sSty[i]%>', null, '<%=iNumOfItm[i]%>', this)"
           onmouseup="dropData('<%=sStr[j]%>','<%=sCls[i]%>', '<%=sVen[i]%>', '<%=sSty[i]%>', null, '<%=iNumOfItm[i]%>', '<%=sCVSInv[i][j]%>', this)"
           onmouseover="if(draged==true){chgDragBox('<%=sStr[j]%>','<%=sCls[i]%>', '<%=sVen[i]%>', '<%=sSty[i]%>', null, <%=iNumOfItm[i]%>, '<%=sCVSInv[i][j]%>', this)}">
           <%=sCVSInv[i][j]%></td>
         <%}%>
      <!-- ----------------- -->
        <%if(!sStr[j].equals("99")){%>
          <td class="DataTable" onmouseup="releaseData()">&nbsp;<%=sCVSSls[i][j]%></td>
        <%}%>
      <%}%>

      <td class="DataTable5" nowrap rowspan="2" colspan="2"
          onclick="showMenu('<%=sCls[i]%>', '<%=sVen[i]%>',  '<%=sSty[i]%>', null, null, this, '<%=sEcomAttr[i]%>', '<%=sEcomCurQty[i]%>')">
        <span style="font-size:11px; font-weight:bolder"><%=sItmName[i]%></span><br>
        C: <%=sCost[i]%>&nbsp;&nbsp;R: <%=sRet[i]%>&nbsp;&nbsp;OR: <%=sOrg[i]%><br>
        M: <%=sMdDate[i]%>&nbsp;&nbsp;VST: <%=sVST[i]%><br>
        FR: <%=sFrtRct[i]%>&nbsp;&nbsp;LR: <%=sLstRct[i]%>
      </td>
    </tr>

    <tr class="DataTable1">
      <td class="DataTable7" colspan="2">&nbsp;<%=sTotSellOff[i]%></td>
      <%for(int j=0; j < iNumOfStr; j++){%>
        <%if(!sStr[j].equals("99")){%>
           <td class="DataTable4" colspan="2" onmouseup="releaseData()">&nbsp;<%=sSellOff[i][j]%></td>
        <%}
        else {%>
           <td class="DataTable4">&nbsp;<%=sSellOff[i][j]%></td>
        <%}%>
      <%}%>
    </tr>

      <tr id="STRHDR<%=i%>">
        <td class="StrLst" colspan="4">Stores</td>
        <%for(int j=0; j < iNumOfStr; j++){%>
           <%if(!sStr[j].equals("99")){%>
           <td class="StrLst" colspan="2"><%=sStr[j]%></td>
           <%}
             else {%>
               <td class="StrLst"><%=sStr[j]%></td>
           <%}%>
        <%}%>
        <td class="StrLst" colspan="2">Stores</td>
      </tr>

   <%}%>
    <!----------------------- end of data ------------------------>
 </table>
 <!----------------------- end of table ------------------------>
      <font size="-1">
      <!-- Show Next 30 records buttons -->
      <%if(session.getAttribute("USER")!=null && !sLastRRN.trim().equals("EOF")){%>
         <a href="javascript: showNextCVS();">Next Items</a>
      <%}%>
      </font>


  </table>
 </body>
</html>
