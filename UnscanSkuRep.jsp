<%@ page import="unscanablesku.UnscanSkuRep"%>
<%
    String sStore = request.getParameter("Store");
    String sStrName = request.getParameter("StrName");
    String sFrom = request.getParameter("From");
    String sTo = request.getParameter("To");
    String sSort = request.getParameter("Sort");
    String sDetail = request.getParameter("Detail");
    if(sSort == null) sSort = "STR";

    if(sDetail == null) sDetail = "none";

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=VendorReportCard.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();

    UnscanSkuRep unscan = new UnscanSkuRep(sStore, sFrom, sTo, sSort, "vrozen");
    int iNumOfSls = unscan.getNumOfSls();
    int iNumOfStr = unscan.getNumOfStr();
%>
<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}

        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-size:10px }
        tr.DataTable2 { background: seashell; font-size:10px }

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

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        tr.Prompt { background-color:#F0F0F0; font-size:10px; }
        tr.Prompt1{ background-color:LemonChiffon; font-size:10px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1{ text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2{ text-align:right; font-family:Arial; font-size:10px; }
</style>


<script name="javascript1.2">
var NumOfSls = <%=iNumOfSls%>;
var NumOfStr = <%=iNumOfStr%>;
var Detail = "<%=sDetail%>";
var Store = "none";

var TransDtl = new Object();
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   foldDtl();
}
//==============================================================================
// fold/unfold Detail
//==============================================================================
function foldDtl()
{
   for(var i=0; i < NumOfSls; i++)
   {
      document.all.trItem[i].style.display = Detail;
   }
   if (Detail=="none") Detail = "block";
   else Detail = "none";
}
//==============================================================================
// fold/unfold Store total
//==============================================================================
function foldStr()
{
   for(var i=0; i < NumOfStr; i++)
   {
      document.all.trStr[i].style.display = Store;
   }
   if (Store=="none") Store = "block";
   else Store = "none";
}
//==============================================================================
// resort table
//==============================================================================
function resort(sort)
{
   if (Detail=="none") Detail = "block";
   else Detail = "none";

   //&From=8/4/2006&To=8/10/2006
   var url = "UnscanSkuRep.jsp?Store=<%=sStore%>"
           + "&StrName=<%=sStrName%>"
           + "&From=<%=sFrom%>"
           + "&To=<%=sTo%>"
           + "&Detail=" + Detail
           + "&Sort=" + sort
   //alert(url)
   window.location.href=url;
}
//==============================================================================
// get Transaction Details
//==============================================================================
function getTrans(str, date, reg, trans, cashier, time)
{
   TransDtl.str = str;
   TransDtl.date = date;
   TransDtl.time = time;
   TransDtl.cashier = cashier;

   var url = "UnscanTrans.jsp?Store=" + str
           + "&Date=" + date
           + "&Reg=" + reg
           + "&Trans=" + trans
   //alert(url)
   window.frame1.location.href=url;
   //window.location.href=url;
}

//==============================================================================
// show Transaction Details
//==============================================================================
function showTransDtl(sku, upc, emp, empName, venSty, ret, qty, desc, totret, totqty)
{
   //check if order is paid off
   var hdr = "Transaction Details";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   var dummy = "<table>";

   html += "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
   html += "<tr><th class='DataTable' nowrap>Store: " + TransDtl.str + "</th>"
           + "<th class='DataTable' nowrap>Date and Time: " + TransDtl.date + " " + TransDtl.time + "</th>"
           + "<th class='DataTable' nowrap>Cashier: " + TransDtl.cashier + "</th>"
         + "</tr>"
   html += "</table>";

   html += "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
         + "<tr><th class='DataTable' nowrap>Sku</th>"
         + "<th class='DataTable' nowrap>Description</th>"
         + "<th class='DataTable' nowrap>UPC</th>"
         + "<th class='DataTable' nowrap>Sales Person</th>"
         + "<th class='DataTable' nowrap>Vendor Style</th>"
         + "<th class='DataTable' nowrap>Retail</th>"
         + "<th class='DataTable' nowrap>Qty</th>"
         + "</tr>"

  for(var i=0; i < sku.length; i++)
  {
     html += "<tr class='Prompt'>"
           + "<td class='Prompt'>" + sku[i] + "</td>"
           + "<td class='Prompt' nowrap>" + desc[i] + "</td>"
           + "<td class='Prompt'>" + upc[i] + "</td>"
           + "<td class='Prompt' nowrap>" + emp[i] + " " + empName[i] + "</td>"
           + "<td class='Prompt' nowrap>" + venSty[i] + "</td>"
           + "<td class='Prompt2'>" + ret[i] + "</td>"
           + "<td class='Prompt2'>" + qty[i] + "</td>"
  }

  html += "<tr class='Prompt1'>"
           + "<td class='Prompt'>Total</td><td class='Prompt'>&nbsp;</td>"
           + "<td class='Prompt'>&nbsp;</td><td class='Prompt'>&nbsp;</td>"
           + "<td class='Prompt'>&nbsp;</td>"
           + "<td class='Prompt2'>" + totret + "</td>"
           + "<td class='Prompt2'>" + totqty + "</td>"
        + "</tr>"

  html += "<tr><td class='Prompt1' colspan='7'>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  html += "</table>";

  html += "</td></tr></table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.width = 250;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 80;
   document.all.dvItem.style.visibility = "visible";

   window.frame1.location.href=null;
   window.frame1.close();
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.style.visibility = "hidden";
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


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Unscannable SKU Report
        <br>From: <%=sFrom%> &nbsp;&nbsp;&nbsp; Through: <%=sTo%>
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="UnscanSkuRepSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript: foldDtl()">Fold/Unfold Details</a>&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript: foldStr()">Fold/Unfold Store Totals</a>
<!-- =================== Performance by Division =========================== -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbDetail">
         <tr class="DataTable">
             <th class="DataTable"><a href="javascript: resort('STR')">Store</a></th>
             <th class="DataTable"><a href="javascript: resort('CASHIER')">Cashier</a></th>
             <th class="DataTable"><a href="javascript: resort('DATE')">Date</a></th>
             <th class="DataTable">Time</th>
             <th class="DataTable"><a href="javascript: resort('RET')">Retail<br>(Net)</a></th>
             <th class="DataTable"><a href="javascript: resort('QTY')">Qty<br>(Net)</a></th>
             <th class="DataTable"><a href="javascript: resort('ABSRET')">Retail<br>(Absolute)</a></th>
             <th class="DataTable"><a href="javascript: resort('ABSQTY')">Qty<br>(Absolute)</a></th>
             <th class="DataTable"><a href="javascript: resort('TRANS')">Reg/Trans #</a></th>
          </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfSls; i++ )
         {
           unscan.setSkuSls();
           String sStr = unscan.getStr();
           String sDate = unscan.getDate();
           String sTime = unscan.getTime();
           String sCash = unscan.getCash();
           String sCshName = unscan.getCshName();
           String sRet = unscan.getRet();
           String sQty = unscan.getQty();
           String sAbsRet = unscan.getAbsRet();
           String sAbsQty = unscan.getAbsQty();
           String sReg = unscan.getReg();
           String sTrans = unscan.getTrans();
       %>
         <tr id="trItem" class="DataTable">
            <td class="DataTable2" nowrap><%=sStr%></td>
            <td class="DataTable1" nowrap><%=sCash + " " + sCshName%></td>
            <td class="DataTable1" nowrap><%=sDate%></td>
            <td class="DataTable1" nowrap><%=sTime%></td>
            <td class="DataTable2" nowrap>$<%=sRet%></td>
            <td class="DataTable2" nowrap><%=sQty%></td>
            <td class="DataTable2" nowrap>$<%=sAbsRet%></td>
            <td class="DataTable2" nowrap><%=sAbsQty%></td>
            <td class="DataTable" nowrap><a class="small" href="javascript: getTrans('<%=sStr%>', '<%=sDate%>', '<%=sReg%>', '<%=sTrans%>', '<%=sCash + " " + sCshName%>', '<%=sTime%>')"><%=sReg + " " + sTrans%></a></td>
          </tr>
       <%}%>

       <!-- ======================== Store Totals ========================== -->
       <%for(int i=0; i < iNumOfStr; i++ )
         {
           unscan.setStrTot();
           String sStr = unscan.getStr();
           String sRet = unscan.getRet();
           String sQty = unscan.getQty();
           String sAbsRet = unscan.getAbsRet();
           String sAbsQty = unscan.getAbsQty();
           String sTrans = unscan.getTrans();
       %>
         <tr id="trStr" class="DataTable2">
            <td class="DataTable2" nowrap><%=sStr%></td>
            <td class="DataTable1" nowrap>&nbsp;</td>
            <td class="DataTable1" nowrap>&nbsp;</td>
            <td class="DataTable1" nowrap>&nbsp;</td>
            <td class="DataTable2" nowrap>$<%=sRet%></td>
            <td class="DataTable2" nowrap><%=sQty%></td>
            <td class="DataTable2" nowrap>$<%=sAbsRet%></td>
            <td class="DataTable2" nowrap><%=sAbsQty%></td>
            <td class="DataTable2" nowrap><%=sTrans%></td>
          </tr>
       <%}%>

       <!-- ============================= Total ============================ -->
       <%
          unscan.setSkuTot();
          String sTotGrp = unscan.getTotGrp();
          String sRet = unscan.getRet();
          String sQty = unscan.getQty();
          String sAbsRet = unscan.getAbsRet();
          String sAbsQty = unscan.getAbsQty();
          String sTrans = unscan.getTrans();
       %>
         <tr id="trTotal" class="DataTable1">
            <td class="DataTable1" nowrap><%=sTotGrp%></td>
            <td class="DataTable1" nowrap>&nbsp;</td>
            <td class="DataTable1" nowrap>&nbsp;</td>
            <td class="DataTable1" nowrap>&nbsp;</td>
            <td class="DataTable2" nowrap>$<%=sRet%></td>
            <td class="DataTable2" nowrap><%=sQty%></td>
            <td class="DataTable2" nowrap>$<%=sAbsRet%></td>
            <td class="DataTable2" nowrap><%=sAbsQty%></td>
            <td class="DataTable2" nowrap><%=sTrans%></td>
          </tr>
     <!-- ================================================================== -->
     </table>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   unscan.disconnect();
   }
%>