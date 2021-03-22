<%@ page import="inventoryreports.ItemAvail, java.util.*"%>
<%
    String sSelStr = request.getParameter("Store");
    String sSelSku = request.getParameter("Sku");
    String sSelUpc = request.getParameter("Upc");
    String sSelCls = request.getParameter("Cls");
    String sSelVen = request.getParameter("Ven");
    String sSelSty = request.getParameter("Sty");



//-------------- Security ---------------------
if (session.getAttribute("USER")==null)
{
    response.sendRedirect("SignOn1.jsp?TARGET=ItemAvail.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    ItemAvail itmavl = new ItemAvail(sSelStr, sSelCls, sSelVen, sSelSty, sSelSku, sSelUpc, sUser);
%>

<html>
<head>

<style>
     body { background:ivory;}
        a.blue:link { color:blue; font-size:12px } a.blue:visited { color:blue; font-size:12px }  a.blue:hover { color:red; font-size:12px }
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}


        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:#EfEfEf; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable3 { background: #ccccff; font-family:Arial; font-size:10px }
        tr.DataTable4 { background: #ccffcc; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center;}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

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
</style>


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var MaxLine = 0;
//==============================================================================
// on time of body load
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   document.all.lnkExcl.style.display = "none";
}
//==============================================================================
// get PO List
//==============================================================================
function getPOList(cls, ven, sty, clr, siz)
{
   var url = "ItemPOList.jsp?Str=<%=sSelStr%>"
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
//==============================================================================
// get Pending distribution
//==============================================================================
function getDistroList(cls, ven, sty, clr, siz)
{
   var url = "ItemDistList.jsp?Str=<%=sSelStr%>"
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
function showDistroList(issStr, docNum, qty)
{
  var hdr = "Pending Distribution";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popDistroList(issStr, docNum, qty);

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
function popDistroList(issStr, docNum, qty)
{
  var dummy = "<table>";
  var panel = "<table border=1 width='100%' cellPadding='3' cellSpacing='0'>"

  panel += "<tr class='DataTable3'>"
          + "<th nowrap>Issuing<br>Store</th>"
          + "<th nowrap>Document<br>Number</th>"
          + "<th>Qty</th>"
        + "</tr>"

  for(var i=0; i < issStr.length; i++)
  {
     panel += "<tr class='DataTable4'>"
           + "<td nowrap>" + issStr[i] + "</td>"
           + "<td nowrap>" + docNum[i] + "</td>"
           + "<td nowrap>" + qty[i] + "</td>"
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
//==============================================================================
//==============================================================================
function setIntrans(type)
{
   for(var i=0; i < MaxLine; i++)
   {
      var exclnm = "tdOnh" + i;
      var inclnm = "tdOnhIntr" + i;
      var onlynm = "tdIntrans" + i;

      if(type=="I")
      {
         document.all[exclnm].style.display = "none";
         document.all[inclnm].style.display = "block";
         document.all[onlynm].style.display = "none";

         document.all.lnkIncl.style.display = "none";
         document.all.lnkOnly.style.display = "inline";
         document.all.lnkExcl.style.display = "inline";
      }
      else if(type=="O")
      {
         document.all[exclnm].style.display = "none";
         document.all[inclnm].style.display = "none";
         document.all[onlynm].style.display = "block";

         document.all.lnkIncl.style.display = "inline";
         document.all.lnkOnly.style.display = "none";
         document.all.lnkExcl.style.display = "inline";
      }
      else if(type=="E")
      {
         document.all[exclnm].style.display = "block";
         document.all[inclnm].style.display = "none";
         document.all[onlynm].style.display = "none";

         document.all.lnkIncl.style.display = "inline";
         document.all.lnkOnly.style.display = "inline";
         document.all.lnkExcl.style.display = "none";
      }
   }
}
</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>


</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
  <div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
        <b>Retail Concepts, Inc
        <br>Item Availability Report
        Store: <%=sSelStr%>
        <br>
        </b>
        <br>
          <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="ItemAvailSel.jsp?">
            <font color="red" size="-1">Selection</font></a>&#62;
          <font size="-1">This Page.</font>
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          In-Transit: <a id="lnkExcl" href="javascript: setIntrans('E')">Exclude</a> &nbsp;
                      <a id="lnkIncl" href="javascript: setIntrans('I')">Include</a> &nbsp;
                      <a id="lnkOnly" href="javascript: setIntrans('O')">Only</a> &nbsp;

      </td>
     </tr>

     <tr>
      <td ALIGN="Center" VALIGN="TOP" colspan=3>

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <%int i=0;%>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable">Div</th>
          <th class="DataTable">Dpt</th>
          <th class="DataTable">Long Item Sku</th>
          <th class="DataTable">Item Description</th>
          <th class="DataTable">Vendor<br>Style</th>
          <th class="DataTable">Color</th>
          <th class="DataTable">Size</th>
          <th class="DataTable">Sku</th>
          <th class="DataTable">UPC</th>
          <th class="DataTable">Warehouse<br>Qty<br>Available</th>
          <th class="DataTable">Warehouse<br>Qty<br>Unlocated</th>
          <th class="DataTable">Store<br>On<br>Hand</th>
          <th class="DataTable">Store<br>Basic<br>Stock</th>
          <th class="DataTable">PO<br>List</th>
          <th class="DataTable">Pending<br>Distribution</th>
          <th class="DataTable">Manufacturer<br>Name</th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%while(itmavl.getNext()) {
               itmavl.setItemProperty();
               String sDiv = itmavl.getDiv();
               String sDpt = itmavl.getDpt();
               String sCls = itmavl.getCls();
               String sVen = itmavl.getVen();
               String sSty = itmavl.getSty();
               String sClr = itmavl.getClr();
               String sSiz = itmavl.getSiz();
               String sSku = itmavl.getSku();
               String sVst = itmavl.getVst();
               String sUpd = itmavl.getUpd();
               String sDesc = itmavl.getDesc();
               String sOnHand = itmavl.getOnHand();
               String sBStock = itmavl.getBStock();
               String sMfgNm = itmavl.getMfgNm();
               String sQty01W = itmavl.getQty01P();
               String sQty01P = itmavl.getQty01W();
               String sClrNm = itmavl.getClrNm();
               String sSizNm = itmavl.getSizNm();
               String sOnhIntr = itmavl.getOnhIntr();
               String sIntrans = itmavl.getIntrans();
           %>
              <tr class="DataTable">
                <td class="DataTable2" nowrap><%=sDiv%></td>
                <td class="DataTable2" nowrap><%=sDpt%></td>
                <td class="DataTable2" nowrap><%=sCls + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz%></td>
                <td class="DataTable1" nowrap><%=sDesc%></td>
                <td class="DataTable1" nowrap><%=sVst%></td>
                <td class="DataTable1" nowrap><%=sClrNm%></td>
                <td class="DataTable1" nowrap><%=sSizNm%></td>
                <td class="DataTable2" nowrap><%=sSku%></td>
                <td class="DataTable2" nowrap><%=sUpd%></td>
                <td class="DataTable2" nowrap><%=sQty01W%></td>
                <td class="DataTable2" nowrap><%=sQty01P%></td>
                <td class="DataTable2" id="tdOnh<%=i%>" nowrap><%=sOnHand%></td>
                <td class="DataTable2" style="display:none;" id="tdOnhIntr<%=i%>" nowrap><%=sOnhIntr%></td>
                <td class="DataTable2" style="display:none;" id="tdIntrans<%=i%>" nowrap><%=sIntrans%></td>
                <td class="DataTable2" nowrap><%=sBStock%></td>
                <td class="DataTable2" nowrap><a href="javascript: getPOList('<%=sCls%>', '<%=sVen%>', '<%=sSty%>', '<%=sClr%>', '<%=sSiz%>')"> PO </a></td>
                <td class="DataTable2" nowrap><a href="javascript: getDistroList('<%=sCls%>', '<%=sVen%>', '<%=sSty%>', '<%=sClr%>', '<%=sSiz%>')">Distro</a></td>
                <td class="DataTable1" nowrap><%=sMfgNm%></td>
             </tr>
             <%i++;%>
          <%}%>
          <!-- ====================== Totals ======================== -->
          <%
             itmavl.setTotals();
             String sOnHand = itmavl.getOnHand();
             String sBStock = itmavl.getBStock();
             String sQty01W = itmavl.getQty01P();
             String sQty01P = itmavl.getQty01W();
             String sOnhIntr = itmavl.getOnhIntr();
             String sIntrans = itmavl.getIntrans();
          %>
          <tr class="DataTable1">
                <td class="DataTable1" nowrap colspan=9><span style="font-size:14px; font-weight:bold; color:darkred;">Totals</span></td>
                <td class="DataTable2" nowrap><%=sQty01W%></td>
                <td class="DataTable2" nowrap><%=sQty01P%></td>
                <td class="DataTable2" id="tdOnh<%=i%>" nowrap><%=sOnHand%></td>
                <td class="DataTable2" style="display:none;" id="tdOnhIntr<%=i%>" nowrap><%=sOnhIntr%></td>
                <td class="DataTable2" style="display:none;" id="tdIntrans<%=i%>" nowrap><%=sIntrans%></td>
                <td class="DataTable2" nowrap><%=sBStock%></td>
                <td class="DataTable2" colspan=4>&nbsp;</td>
             </tr>
          <%i++;%>
          <script>MaxLine = <%=i%></script>
      </table>
      <!----------------------- end of table ------------------------>
      </td>
     </tr>
          </table>
       </td>
     </tr>
  </table>
 </body>
</html>
<%}%>