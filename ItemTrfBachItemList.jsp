<%@ page import="itemtransfer.ItemTrfBachItemList, java.util.*"%>
<%
   String sBatch = request.getParameter("Batch");
   String sBWhse = request.getParameter("BWhse");
   String sBComment = request.getParameter("BComment");
   String sUser = session.getAttribute("USER").toString();
   String sSort = request.getParameter("Sort");
   
   if(sUser==null){sUser = "Unknown";}
   if(sSort==null){sSort = "Item";}


   ItemTrfBachItemList batchitm = new ItemTrfBachItemList(sBatch, sSort, sUser);

%>

<html>
<head>

<style>body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { background:white;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        table.DataTable2 { background:white;text-align:center; font-size:10px; text-align:left;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:lightgrey; font-family:Arial; font-size:12px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:Cornsilk; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;  text-align:center;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;  text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;  text-align:right;}
        td.DataTable2r { background:pink; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;  text-align:right;}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
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
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial;}
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial;}
        td.Prompt2 { text-align:right; font-family:Arial; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial;}

        <!-------- end transfer entry pad ------->

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Div = new Array();
var Dpt = new Array();
var Cls = new Array();
var Ven = new Array();
var Sty = new Array();
var Clr = new Array();
var Siz = new Array();
var Sku = new Array();
var IssStr = new Array();
var DstStr = new Array();
var Qty = new Array();
var Sts = new Array();
var ApprvUser = new Array();
var ApprvDate = new Array();
var PrintUser = new Array();
var PrintDate = new Array();
var CompUser = new Array();
var CompSate = new Array();
var CompType = new Array();
var SentQty = new Array();
var DivNm = new Array();
var DptNm = new Array();
var ClsNm = new Array();
var ClrNm = new Array();
var SizNm = new Array();
var VenNm = new Array();
var Desc = new Array();
var WhsTrf = new Array();
var Onhand = new Array();
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   dispWhsQty();
}
//==============================================================================
// display warehouse quantity column
//==============================================================================
function dispWhsQty()
{
   if(WhsTrf[0] != "1")
   {
      for(var i=0; i < document.all.colWhs.length; i++)
      {
         document.all.colWhs[i].style.display="none";
      }
   }
}
//==============================================================================
// show Detail for each transfered item
//==============================================================================
function showDtl(i)
{
   cell = "tdDiv" + i
   var obj = document.all[cell];
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>Item Details</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
     + "<tr><td class='Prompt' colspan=2>" + popItem(i) + "</td></tr></table>"

   document.all.dvItem.innerHTML = html;
   var pos = getObjPosition(obj);
   document.all.dvItem.style.pixelLeft= pos[0] - 20;
   document.all.dvItem.style.pixelTop= pos[1] + 25;
   document.all.dvItem.style.visibility = "visible";
}
//--------------------------------------------------------
// populate No Map Column Panel
//--------------------------------------------------------
function popItem(i)
{
  var panel = "<table border=1 class='DataTable2' width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td nowrap>Division:</td><td nowrap>" + Div[i] + " - " + DivNm[i] + "</td><td>&nbsp;</td>"
           + "<td>Department:</td><td nowrap>" + Dpt[i] + " - " + DptNm[i] + "</td></tr>"
        + "<tr><td>Class:</td><td nowrap>" + Cls[i] + " - " + ClsNm[i] + "</td><td>&nbsp;</td>"
           + "<td>Division:</td><td nowrap>" + Ven[i] + " - " + VenNm[i] + "</td></tr>"
        + "<tr><td>Long Item SKU</td><td nowrap>" + Cls[i] + "-" + Ven[i] + "-" + Sty[i] + "-" + Clr[i] + "-" + Siz[i] + "</td><td>&nbsp;</td>"
           + "<td>Color:</td><td nowrap>" + ClrNm[i] + "</td></tr>"
        + "<tr><td>Size:</td><td nowrap>" + SizNm[i] + "</td><td>&nbsp;</td>"
           + "<td>Description:</td><td nowrap>" + Desc[i] + "</td></tr>"
        + "<tr><td>Issuing Store:</td><td nowrap>" + IssStr[i] + "</td><td>&nbsp;</td>"
           + "<td>Destination Store:</td><td nowrap>" + DstStr[i] + "</td></tr>"
        + "<tr><td>Quantity:</td><td nowrap>" + Qty[i] + "</td><td>&nbsp;</td>"        
           + "<td>Status:</td><td nowrap>" + Sts[i] + "</td></tr>"
        + "<tr><td>Onhand:</td><td nowrap>" + Onhand[i] + "</td><td>&nbsp;</td>"
           + "<td>&nbsp;</td><td nowrap>&nbsp;</td></tr>"
        + "<tr><td>Approved by user:</td><td nowrap>" + ApprvUser[i] + "</td><td>&nbsp;</td>"
           + "<td>Approved by date:</td><td nowrap>" + ApprvDate[i] + "</td></tr>"
        + "<tr><td>Printed by user:</td><td nowrap>" + PrintUser[i] + "</td><td>&nbsp;</td>"
           + "<td>Printed by date:</td><td nowrap>" + PrintDate[i] + "</td></tr>"
        + "<tr><td>Status:</td><td nowrap>" + Sts[i] + "</td><td>&nbsp;</td>"        
           + "<td>&nbsp;</td><td nowrap>&nbsp;</td></tr>"   

  panel += "<tr><td class='Prompt1' colspan='5'><br>"
        + "<button style='font-size:10px' onClick='hidePanel();' >Close</button></td></tr>"

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
//==============================================================================
// show on parent window selected items group
//==============================================================================
function showItmList(div, dpt, cls, ven, sty)
{
  //var url = "ItemList.jsp?"
  var url = "ItemList_v2.jsp?"
      + "Div=" + div
      + "&Dpt=" + dpt
      + "&Cls=" + cls
      + "&Ven=" + ven
      + "&Sty=" + sty 
      + "&Batch=<%=sBatch%>"
      + "&BWhse=<%=sBWhse%>"
      + "&BComment=<%=sBComment%>"
  //alert(url)
  //window.opener.document.location.href = url;
  window.open(url);    
}
//==============================================================================
// re-sort page
//==============================================================================
function resort(sort)
{
	var url = "ItemTrfBachItemList.jsp?Batch=" + <%=sBatch%>
	 + "&BWhse=<%=sBWhse%>"   
	 + "&BComment=<%=sBComment%>"
	 + "&Sort=" + sort
	window.location.href = url;
}
</SCRIPT>
<script LANGUAGE="JavaScript" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript" src="Get_Object_Position.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr>

      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Transfer Request - Batch Item List
      <br>Batch: <%=sBComment%>
      </b><br>


<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable">Div</th>
          <th class="DataTable">Dpt</th>
          <th class="DataTable">Cls</th>
          <th class="DataTable"><a href="javascript: resort('Item')">Long SKU</a></th>
          <th class="DataTable">Short SKU</th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable"><a href="javascript: resort('IStr')">Issuing<br>Store</a></th>
          <th class="DataTable"><a href="javascript: resort('DStr')">Destination<br>Store</a></th>
          <th class="DataTable">&nbsp;</th>
          <th class="DataTable">Qty</th>
          <th class="DataTable">Onhand</th>
          <th class="DataTable" id="colWhs">Whs<br>Qty</th>
          <th class="DataTable">Item Description</th>
          <th class="DataTable">D<br>t<br>l</th>
          <th class="DataTable">S<br>t<br>s</th>
        </tr>
  <!----------------------- Detail ------------------------>
  <% int iItm = 0;
     while(batchitm.getNext()){%>
      <%
         batchitm.setBatchArr();
         int iNumOfItm = batchitm.getNumOfItm();
         String [] sDiv = batchitm.getDiv();
         String [] sDpt = batchitm.getDpt();
         String [] sCls = batchitm.getCls();
         String [] sVen = batchitm.getVen();
         String [] sSty = batchitm.getSty();
         String [] sClr = batchitm.getClr();
         String [] sSiz = batchitm.getSiz();
         String [] sSku = batchitm.getSku();
         String [] sIssStr = batchitm.getIssStr();
         String [] sDstStr = batchitm.getDstStr();
         String [] sQty = batchitm.getQty();
         String [] sSntQty = batchitm.getQty();
         String [] sSts = batchitm.getSts();
         String [] sApprvUser = batchitm.getApprvUser();
         String [] sApprvDate = batchitm.getApprvDate();
         String [] sPrintUser = batchitm.getPrintUser();
         String [] sPrintDate = batchitm.getPrintDate();
         String [] sCompUser = batchitm.getCompUser();
         String [] sCompSate = batchitm.getCompDate();
         String [] sCompType = batchitm.getCompType();
         String [] sSentQty = batchitm.getSentQty();
         String [] sDivNm = batchitm.getDivNm();
         String [] sDptNm = batchitm.getDptNm();
         String [] sClsNm = batchitm.getClsNm();
         String [] sClrNm = batchitm.getClrNm();
         String [] sSizNm = batchitm.getSizNm();
         String [] sVenNm = batchitm.getVenNm();
         String [] sDesc = batchitm.getDesc();
         String [] sWhsTrf = batchitm.getWhsTrf();
         String [] sWhsQty = batchitm.getWhsQty();
         String [] sWhsWarn = batchitm.getWhsWarn();
         String [] sOnhand = batchitm.getOnhand();                 
      %>
    <%for(int i=0; i < iNumOfItm; i++) {    	
        int iqty = 0;
        int ionh = 0;
        iqty = Integer.parseInt(sQty[i]);
       	ionh = Integer.parseInt(sOnhand[i]);
       	boolean bWarn = iqty > ionh;       	 
    %>
      <tr class="DataTable1">
        <td class="DataTable"  id="tdDiv<%=iItm%>" nowrap><a href="javascript: showItmList('<%=sDiv[i]%>', 'ALL', 'ALL', 'ALL', 'ALL')"><%=sDiv[i]%></a></td>
        <td class="DataTable" nowrap><a href="javascript: showItmList('<%=sDiv[i]%>', '<%=sDpt[i]%>', 'ALL', 'ALL', 'ALL')"><%=sDpt[i]%></a></td>
        <td class="DataTable" nowrap><a href="javascript: showItmList('<%=sDiv[i]%>', '<%=sDpt[i]%>', '<%=sCls[i]%>', 'ALL', 'ALL')"><%=sCls[i]%></a></td>
        <td class="DataTable" nowrap><a href="javascript: showItmList('<%=sDiv[i]%>', '<%=sDpt[i]%>', '<%=sCls[i]%>', '<%=sVen[i]%>', '<%=sSty[i]%>')"><%=sCls[i] + "-" + sVen[i] + "-" + sSty[i] + "-" + sClr[i] + "-" + sSiz[i]%></a></td>
        <td class="DataTable" nowrap><%=sSku[i]%></td>

        <th class="DataTable">&nbsp;</th>
        <td class="DataTable" nowrap><%=sIssStr[i]%></td>
        <td class="DataTable" nowrap><%=sDstStr[i]%></td>
        <th class="DataTable">&nbsp;</th>
        <td class="DataTable2" <%if(bWarn){%>style="background:pink;"<%}%> nowrap><%=sQty[i]%></td>
        <td class="DataTable2" <%if(bWarn){%>style="background:pink;"<%}%> nowrap><%=sOnhand[i]%></td>
        <td class="DataTable2<%if(sWhsWarn[i].equals("1")){%>r<%}%>" id="colWhs" nowrap><%=sWhsQty[i]%></td>
        <td class="DataTable1" nowrap><%=sDesc[i]%></td>
        <td class="DataTable1" nowrap><a href="javascript: showDtl('<%=iItm%>')">D</a></td>
        <td class="DataTable1" nowrap><%=sSts[i]%></td>

        <script>Div[<%=iItm%>] = "<%=sDiv[i]%>"; Dpt[<%=iItm%>] = "<%=sDpt[i]%>"; Cls[<%=iItm%>] = "<%=sCls[i]%>";
           Ven[<%=iItm%>] = "<%=sVen[i]%>"; Sty[<%=iItm%>] = "<%=sSty[i]%>"; Clr[<%=iItm%>] = "<%=sClr[i]%>"; Siz[<%=iItm%>] = "<%=sSiz[i]%>";
           Sku[<%=iItm%>] = "<%=sSku[i]%>"; IssStr[<%=iItm%>] = "<%=sIssStr[i]%>"; DstStr[<%=iItm%>] = "<%=sDstStr[i]%>"; Qty[<%=iItm%>] = "<%=sQty[i]%>";
           Sts[<%=iItm%>] = "<%=sSts[i]%>"; ApprvUser[<%=iItm%>] = "<%=sApprvUser[i]%>"; ApprvDate[<%=iItm%>] = "<%=sApprvDate[i]%>";
           PrintUser[<%=iItm%>] = "<%=sPrintUser[i]%>"; PrintDate[<%=iItm%>] = "<%=sPrintDate[i]%>"; CompUser[<%=iItm%>] = "<%=sCompUser[i]%>";
           CompSate[<%=iItm%>] = "<%=sCompSate[i]%>"; CompType[<%=iItm%>] = "<%=sCompType[i]%>"; SentQty[<%=iItm%>] = "<%=sSentQty[i]%>";
           DivNm[<%=iItm%>] = "<%=sDivNm[i]%>"; DptNm[<%=iItm%>] = "<%=sDptNm[i]%>"; ClsNm[<%=iItm%>] = "<%=sClsNm[i]%>"; ClrNm[<%=iItm%>] = "<%=sClrNm[i]%>";
           SizNm[<%=iItm%>] = "<%=sSizNm[i]%>"; VenNm[<%=iItm%>] = "<%=sVenNm[i]%>"; Desc[<%=iItm%>] = "<%=sDesc[i]%>";
           WhsTrf[<%=iItm%>] = "<%=sWhsTrf[i]%>"; Onhand[<%=iItm%>] = "<%=sOnhand[i]%>";
        </script>
        <%iItm++;%>
     <%}%>
   <%}%>
   <!----------------------- end of data ------------------------>

 </table>
 <!----------------------- end of table ------------------------>
  </table>
  <p style="text-align:center">
  <button onClick="window.close()">Close</button>
 </body>
</html>
<%batchitm.disconnect();%>