<%@ page import="ecommerce.EcSTSSum, java.util.*, java.sql.*"%>
<%
   String sFrom = request.getParameter("FrDate");
   String sTo = request.getParameter("ToDate");

   //===========================================================================
   // check last date
   //===========================================================================
   EcSTSSum stssum = new EcSTSSum(sFrom, sTo);

   String [] sStr = stssum.getStr();
   String [] sShipped = stssum.getShipped();
   String [] sReceived = stssum.getReceived();
   String [] sHandled = stssum.getHandled();
   String [] sRowTot = stssum.getRowTot();

   int iNumOfStr = stssum.getNumOfStr();

   String sTotShipped = stssum.getTotShipped();
   String sTotReceived = stssum.getTotReceived();
   String sTotHandled = stssum.getTotHandled();
   String sTotRowTot = stssum.getTotRowTot();
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
      <br>E-Commerce Ship-To-Store Summary
      <br>Date Range: <%=sFrom%> - <%=sTo%></b>
      <br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" >Store</th>
          <th class="DataTable" >Shipped</th>
          <th class="DataTable" >Received</th>
          <th class="DataTable" >Handled</th>
          <th class="DataTable" >Total</th>
        </tr>
     <!------------------------------- Data Detail --------------------------------->
      <%for(int i=0; i < iNumOfStr; i++){%>
        <tr class="DataTable">
          <td class="DataTable2">&nbsp;<%=sStr[i]%></td>
          <td class="DataTable2">&nbsp;<%=sShipped[i]%></td>
          <td class="DataTable2">&nbsp;<%=sReceived[i]%></td>
          <td class="DataTable2">&nbsp;<%=sHandled[i]%></td>
          <td class="DataTable2">&nbsp;<%=sRowTot[i]%></td>
        </tr>
      <%}%>
      <!------------------------ End Details ---------------------------------->

      <!------------------------ Total ---------------------------------->
      <tr class="DataTable1">
          <td class="DataTable2">Total</td>
          <td class="DataTable2">&nbsp;<%=sTotShipped%></td>
          <td class="DataTable2">&nbsp;<%=sTotReceived%></td>
          <td class="DataTable2">&nbsp;<%=sTotHandled%></td>
          <td class="DataTable2">&nbsp;<%=sTotRowTot%></td>
        </tr>

   </table>
    <!----------------------- end of table ---------------------------------->

  </table>
 </body>

</html>

<%
  stssum.disconnect();
  stssum = null;
%>
