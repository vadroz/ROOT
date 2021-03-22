<%@ page import="ecommerce.EcDailySum, java.util.*, java.sql.*"%>
<%
   String sShipDate = request.getParameter("ShipDate");

   //===========================================================================
   // check last date
   //===========================================================================
   EcDailySum dlysum = new EcDailySum(sShipDate);

   String [] sSite = dlysum.getSite();
   String [] sTax = dlysum.getTax();
   String [] sPay = dlysum.getPay();
   String [] sShpCost = dlysum.getShpCost();
   String [] sPayLog = dlysum.getPayLog();
   String [] sProcessed = dlysum.getProcessed();
   String [] sOrdCnt = dlysum.getOrdCnt();

   String [] sRtnTax = dlysum.getRtnTax();
   String [] sRtnPay = dlysum.getRtnPay();
   String [] sRtnShpCost = dlysum.getRtnShpCost();
   String [] sRtnPayLog = dlysum.getRtnPayLog();
   String [] sRtnProcessed = dlysum.getRtnProcessed();
   String [] sRtnOrdCnt = dlysum.getRtnOrdCnt();

   String [] sSumTax = dlysum.getSumTax();
   String [] sSumPay = dlysum.getSumPay();
   String [] sSumShpCost = dlysum.getSumShpCost();
   String [] sSumPayLog = dlysum.getSumPayLog();
   String [] sSumProcessed = dlysum.getSumProcessed();
   String [] sSumOrdCnt = dlysum.getSumOrdCnt();

   String sTotOrdCnt = dlysum.getTotOrdCnt();
   String sTotTax = dlysum.getTotTax();
   String sTotPay = dlysum.getTotPay();
   String sTotShpCost = dlysum.getTotShpCost();
   String sTotPayLog = dlysum.getTotPayLog();
   String sTotProcessed = dlysum.getTotProcessed();

   String sRtnTotOrdCnt = dlysum.getRtnTotOrdCnt();
   String sRtnTotTax = dlysum.getRtnTotTax();
   String sRtnTotPay = dlysum.getRtnTotPay();
   String sRtnTotShpCost = dlysum.getRtnTotShpCost();
   String sRtnTotPayLog = dlysum.getRtnTotPayLog();
   String sRtnTotProcessed = dlysum.getRtnTotProcessed();

   String sSumTotOrdCnt = dlysum.getSumTotOrdCnt();
   String sSumTotTax = dlysum.getSumTotTax();
   String sSumTotPay = dlysum.getSumTotPay();
   String sSumTotShpCost = dlysum.getSumTotShpCost();
   String sSumTotPayLog = dlysum.getSumTotPayLog();
   String sSumTotProcessed = dlysum.getSumTotProcessed();

   int iNumOfSite = dlysum.getNumOfSite();
%>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }

        tr.DataTable { background: #E7E7E7; font-size:12px }
        tr.DataTable1 { background: cornsilk; font-size:12px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}

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
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

</style>
<html>
<head><Meta http-equiv="refresh"></head>

<body>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
      <br>E-Commerce Daily Shipping Summary
      <br>Ship Date: <%=sShipDate%></b>
      <br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" rowspan=2>Site</th>
          <th class="DataTable" colspan=6 >Sales</th>
          <th class="DataTable" rowspan=2 >&nbsp;</th>
          <th class="DataTable" colspan=6 >Returns</th>
          <th class="DataTable" rowspan=2 >&nbsp;</th>
          <th class="DataTable" colspan=6 >Totals</th>
        </tr>
        <tr>
          <th class="DataTable" >Order<br>#</th>
          <th class="DataTable" >Pay<br>$</th>
          <th class="DataTable" >Tax<br>$</th>
          <th class="DataTable" >Ship<br>Cost</th>
          <th class="DataTable" nowrap># of Orders<br>in Payment File</th>
          <th class="DataTable" >Processed<br>in IP</th>

          <th class="DataTable" >Order<br>#</th>
          <th class="DataTable" >Pay<br>$</th>
          <th class="DataTable" >Tax<br>$</th>
          <th class="DataTable" >Ship<br>Cost</th>
          <th class="DataTable" nowrap># of Orders<br>in Payment File</th>
          <th class="DataTable" >Processed<br>in IP</th>

          <th class="DataTable" >Order<br>#</th>
          <th class="DataTable" >Pay<br>$</th>
          <th class="DataTable" >Tax<br>$</th>
          <th class="DataTable" >Ship<br>Cost</th>
          <th class="DataTable" nowrap># of Orders<br>in Payment File</th>
          <th class="DataTable" >Processed<br>in IP</th>
        </tr>
     <!------------------------------- Data Detail --------------------------------->
      <%for(int i=0; i < iNumOfSite; i++){%>
        <tr class="DataTable">
          <td class="DataTable1" nowrap><%=sSite[i]%></td>
          <td class="DataTable2">&nbsp;<%=sOrdCnt[i]%></td>
          <td class="DataTable2">$<%=sPay[i]%></td>
          <td class="DataTable2">$<%=sTax[i]%></td>
          <td class="DataTable2">$<%=sShpCost[i]%></td>
          <td class="DataTable2">&nbsp;<%=sPayLog[i]%></td>
          <td class="DataTable2">&nbsp;<%=sProcessed[i]%></td>

          <th class="DataTable" >&nbsp;</th>

          <td class="DataTable2">&nbsp;<%=sRtnOrdCnt[i]%></td>
          <td class="DataTable2">$<%=sRtnPay[i]%></td>
          <td class="DataTable2">$<%=sRtnTax[i]%></td>
          <td class="DataTable2">$<%=sRtnShpCost[i]%></td>
          <td class="DataTable2">&nbsp;<%=sRtnPayLog[i]%></td>
          <td class="DataTable2">&nbsp;<%=sRtnProcessed[i]%></td>

          <th class="DataTable" >&nbsp;</th>

          <td class="DataTable2">&nbsp;<%=sSumOrdCnt[i]%></td>
          <td class="DataTable2">$<%=sSumPay[i]%></td>
          <td class="DataTable2">$<%=sSumTax[i]%></td>
          <td class="DataTable2">$<%=sSumShpCost[i]%></td>
          <td class="DataTable2">&nbsp;<%=sSumPayLog[i]%></td>
          <td class="DataTable2">&nbsp;<%=sSumProcessed[i]%></td>
        </tr>
      <%}%>
      <!------------------------ End Details ---------------------------------->
      <!------------------------ Totals --------------------------------------->
      <tr class="DataTable1">
          <td class="DataTable1">Total</td>
          <td class="DataTable2">&nbsp;<%=sTotOrdCnt%></td>
          <td class="DataTable2">$<%=sTotPay%></td>
          <td class="DataTable2">$<%=sTotTax%></td>
          <td class="DataTable2">$<%=sTotShpCost%></td>
          <td class="DataTable2">&nbsp;<%=sTotPayLog%></td>
          <td class="DataTable2">&nbsp;<%=sTotProcessed%></td>

          <th class="DataTable" >&nbsp;</th>

          <td class="DataTable2">&nbsp;<%=sRtnTotOrdCnt%></td>
          <td class="DataTable2">$<%=sRtnTotPay%></td>
          <td class="DataTable2">$<%=sRtnTotTax%></td>
          <td class="DataTable2">$<%=sRtnTotShpCost%></td>
          <td class="DataTable2">&nbsp;<%=sRtnTotPayLog%></td>
          <td class="DataTable2">&nbsp;<%=sRtnTotProcessed%></td>

          <th class="DataTable" >&nbsp;</th>

          <td class="DataTable2">&nbsp;<%=sSumTotOrdCnt%></td>
          <td class="DataTable2">$<%=sSumTotPay%></td>
          <td class="DataTable2">$<%=sSumTotTax%></td>
          <td class="DataTable2">$<%=sSumTotShpCost%></td>
          <td class="DataTable2">&nbsp;<%=sSumTotPayLog%></td>
          <td class="DataTable2">&nbsp;<%=sSumTotProcessed%></td>
        </tr>

   </table>
    <!----------------------- end of table ---------------------------------->

  </table>
 </body>

</html>

<%
  dlysum.disconnect();
  dlysum = null;
%>
