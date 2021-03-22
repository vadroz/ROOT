<%@ page import="supplyorder.SupOrderList ,java.util.*, java.text.*"%>
<%
   String [] sSelSts = request.getParameterValues("Sts");
   String [] sSelStr = request.getParameterValues("Str");
   String sFrDate = request.getParameter("FrDate");
   String sToDate = request.getParameter("ToDate");
   String sSort = request.getParameter("Sort");

   if (sSort == null){ sSort = "ORD_DSC"; }
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=SupOrderList.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {

   String sUser = session.getAttribute("USER").toString();
   SupOrderList supord = new SupOrderList(sSelSts, sSelStr, sFrDate, sToDate, sSort, sUser);
   String sStsLst = supord.cvtToJavaScriptArray(sSelSts);
   String sStrLst = supord.cvtToJavaScriptArray(sSelStr);
%>
<html>
<head>
<title>Supply Orders</title>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable9 { background: LemonChiffon; font-family:Arial; font-size:10px; text-align:center;}

        td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right;}
        td.DataTable2 {border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.DataTable21 {background:pink; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable3 {background:#e7e7e7; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable31 {background:green; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}
        td.DataTable32 {background:red; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:center;}

        td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}

        td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}

        td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}
        #tdAllInv { display: none; }
        #tdAvlInv { display: block; }

        <!--------------------------------------------------------------------->
        .Small {font-family:Arial; font-size:10px }
        input.Small {font-family:Arial; font-size:10px }
        button.Small {font-family:Arial; font-size:10px }
        select.Small {font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
</style>




<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var SelSts = [<%=sStsLst%>];
var SelStr = [<%=sStrLst%>];
var Sort = "<%=sSort%>";
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvStatus"]);
}
//==============================================================================
// re-sort table
//==============================================================================
function resort(column)
{
   direction = "ASC";
   if(Sort.indexOf("ASC") > 0)
   {
	   direction = "DSC";
   }
   	
   var url ="SupOrderList.jsp?";
   for(var i=0; i < SelStr.length; i++) { url += "&Str=" + SelStr[i]; }
   for(var i=0; i < SelSts.length; i++) { url += "&Sts=" + SelSts[i]; }
   url += "&Sort=" + column + "_" + direction
     + "&FrDate=<%=sFrDate%>"
     + "&ToDate=<%=sToDate%>";
   window.location.href = url;
}

//==============================================================================
// change status
//==============================================================================
function chgSts(ord, cursts)
{
   var hdr = "Order: " + ord;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popStatusPanel(ord, cursts)
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 140;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 95;
   document.all.dvStatus.style.visibility = "visible";

   document.all.selSts.options[0] = new Option("Open","Open");
   document.all.selSts.options[1] = new Option("Submitted","Submitted");
   document.all.selSts.options[2] = new Option("Cancelled","Cancelled");
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popStatusPanel(ord, cursts)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable9'>"
           + "<td colspan=2>Current Status: <u><b>" + cursts + "</b></u><br>&nbsp;</td>"
       + "</tr>"
       + "<tr class='DataTable9'>"
          + "<td style='text-align:right;'>Status </td>"
          + "<td style='text-align:left;' nowrap><select name='selSts' class='Small' onchange='chkSelSts(this)'></select>"
          + "</td>"
        + "</tr>"


  panel += "<tr class='DataTable9'>";
  panel += "<td colspan=2 ><br><br><button onClick='ValidateSts(&#34;" + ord + "&#34;)' class='Small'>Change</button>&nbsp;"
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// check selected status
//==============================================================================
function chkSelSts(sel)
{
   if(sel.options[sel.selectedIndex].value=="CANCELLED")
   {
     document.all.tdUnrel.style.display="block";
   }
}

//==============================================================================
// hide panel
//==============================================================================
function hidePanel()
{
   document.all.dvStatus.innerHTML = "";
   document.all.dvStatus.style.visibility = "hidden";
}
//==============================================================================
// validate new status
//==============================================================================
function ValidateSts(ord)
{
   var error=false;
   var msg = "";

   var sts = document.all.selSts[document.all.selSts.selectedIndex].value;

   if(error){ alert(msg); }
   else { sbmNewSts(ord, sts) }
}
//==============================================================================
// submit new status
//==============================================================================
function sbmNewSts(ord, sts)
{
   var url = "SupOrdSave.jsp?"
     + "&Ord=" + ord
     + "&Sts=" + sts
     + "&Action=CHG_ORD_STS"

   //alert(url)
   window.frame1.location.href = url;
}
//==============================================================================
// reload after save new status
//==============================================================================
function restart(ord)
{
   var url ="SupOrderList.jsp?";
   for(var i=0; i < SelStr.length; i++) { url += "&Str=" + SelStr[i]; }
   for(var i=0; i < SelSts.length; i++) { url += "&Sts=" + SelSts[i]; }
   url += "&Sort=<%=sSort%>"
     + "&FrDate=<%=sFrDate%>"
     + "&ToDate=<%=sToDate%>";
   window.location.href = url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Supply Order List
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="SupOrdListSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page.
      &nbsp; &nbsp; <a href="SupOrderInfo.jsp" target="_blank">Add Order</a>
      <br>
      <br>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable">
          <th class="DataTable" rowspan=2><a href="javascript: resort('ORD')">Order</a></th>
          <th class="DataTable" rowspan=2><a href="javascript: resort('STR')">Store</a></th>
          <th class="DataTable" rowspan=2><a href="javascript: resort('STS')">Status</a></th>
          <th class="DataTable" colspan=3>Open by</th>
          <th class="DataTable" rowspan=2>Qty<br>on<br>Order</th>
          <th class="DataTable" colspan=4>Items Allocated</th>
        </tr>
        <tr class="DataTable">
          <th class="DataTable">User</th>
          <th class="DataTable">Date</th>
          <th class="DataTable">Time</th>

          <th class="DataTable">Qty</th>
          <th class="DataTable">Alloc#</th>
          <th class="DataTable">Date</th>
          <th class="DataTable">Status</th>
       </tr>
  <!-------------------------- Order List ------------------------------->
      <%
       while(supord.getNext())
       {
         supord.setOrdInfo();
         String sOrd = supord.getOrd();
         String sStr = supord.getStr();
         String sSts = supord.getSts();
         String sRecUs = supord.getRecUs();
         String sRecDt = supord.getRecDt();
         String sRecTm = supord.getRecTm();
         String sRecUsNm = supord.getRecUsNm();
         String sNumOpr = supord.getNumOpr();
         String sNumVis = supord.getNumVis();
         String sNumBik = supord.getNumBik();
         String sNumSki = supord.getNumSki();
         String sNumBoo = supord.getNumBoo();
         String sTotQty = supord.getTotQty();
         String sAlcQty = supord.getAlcQty();
         String sAlcSts = supord.getAlcSts();
         String sAlcNum = supord.getAlcNum();
         String sAlcDate = supord.getAlcDate();
         String sAckDate = supord.getAckDate();
      %>
         <tr class="DataTable1">
           <td class="DataTable1"><a href="SupOrderInfo.jsp?Ord=<%=sOrd%>" target="_blank"><%=sOrd%></a></td>
           <td class="DataTable1"><%=sStr%></td>
           <%if(sSts.equals("Open") || sSts.equals("Submitted") || sSts.equals("Cancelled")){%>
           <td class="DataTable"><a href="javascript: chgSts('<%=sOrd%>', '<%=sSts%>')"><%=sSts%></a></td>
           <%} else{%><td class="DataTable"><%=sSts%></td><%}%>
           <td class="DataTable"><%=sRecUs%></td>
           <td class="DataTable2"><%=sRecDt%></td>
           <td class="DataTable2"><%=sRecTm%></td>
           <td class="DataTable1"><%=sTotQty%></td>
           <td class="DataTable1"><%=sAlcQty%></td>
           <td class="DataTable1"><%=sAlcNum%></td>
           <td class="DataTable1"><%=sAlcDate%></td>
           <td class="DataTable"><%=sAlcSts%></td>
         </tr>
      <%}%>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>
   <tr>
     <td style="font-size:12px"><br>
       <br><u><b>Order Statuses:</b></u>
         <br> &nbsp; &nbsp; -&nbsp; Open:   The order is still open, additional items can be added.
         <br> &nbsp; &nbsp; -&nbsp; Submitted: The order has been "submitted" for fullfillment.
         <br> &nbsp; &nbsp; -&nbsp; Cancelled:  The order has been cancelled by the store.
         <br> &nbsp; &nbsp; -&nbsp; Allocated:  The order has been processed, and the DC will begin fullfilling.
         <br> &nbsp; &nbsp; -&nbsp; Closed:  The order has been acknowledged as received at the store.

       <br><br><u><b>Item Allocation Statuses:</b></u>
         <br> &nbsp; &nbsp; -&nbsp; Ready to Pick:  The items are waiting to be "picked" from DC stock.
         <br> &nbsp; &nbsp; -&nbsp; Being Picked: The items are currently being "picked" and prepared for shipment in the DC.
         <br> &nbsp; &nbsp; -&nbsp; In-Transit: The item has been shipped to your store.
         <br> &nbsp; &nbsp; -&nbsp; Not Shipped:  The item ordered could not be fullfilled, re-ordered when inventory is available.
         <br> &nbsp; &nbsp; -&nbsp; *Multiple Statuses: There is more than one item status, click the order # to view item details.
         <br> &nbsp; &nbsp; -&nbsp; Ackn as Received - The item  has been acknowledged as received at the store.


     </td>
   </tr>

  </table>
 </body>
</html>


<%
   supord.disconnect();
  }%>