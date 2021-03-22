<%@ page import="ecommerce.EcShopItmAvl, java.util.*, java.sql.*"%>
<%
   EcShopItmAvl itmavl = new EcShopItmAvl();
%>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }

        tr.DataTable { background: #E7E7E7; font-size:10px;  vertical-align:top;}
        tr.DataTable1 { background: gold; font-size:12px;}
        tr.DataTable2 { background: lightgreen; font-size:12px;}

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
<script language="javascript">
var Match = true;
//==============================================================================
// initialize
//==============================================================================
function bodyload()
{
   showMatch()
}
//==============================================================================
// show Matched or All orders
//==============================================================================
function showMatch()
{
   var row0 = document.all.trOrd;
   var row1 = document.all.trOrd1;
   var dsp = "none";

   if (!Match) { dsp = "block"; }

   for(var i=0; i < row0.length; i++)
   {
      row0[i].style.display = dsp;
   }
   Match = !Match;
}
</script>


<body onload="bodyload()">
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
      <br>E-Commerce Shopotron Todays Orders</b>
      <br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
      <a href="javascript: showMatch()">Match/All</a>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" >Order<br>#</th>
          <th class="DataTable" >Mfg<br>Id</th>
          <th class="DataTable" >Categ Id<br></th>
          <th class="DataTable" >Part<br>Id</th>
          <th class="DataTable" >Product<br>Name</th>
          <th class="DataTable" >Req<br>Color</th>
          <th class="DataTable" >Req<br>Size</th>
          <th class="DataTable" >Required<br>Qty</th>

          <th class="DataTable" >Vendor<br>Style</th>
          <th class="DataTable" >Long Sku</th>
          <th class="DataTable" >Short Sku</th>
          <th class="DataTable" >Desc</th>
          <th class="DataTable" >Ret</th>
          <th class="DataTable" >Avail<br>Qty</th>
          <th class="DataTable" >Color<br>Name</th>
          <th class="DataTable" >Size<br>Name</th>
          <th class="DataTable" >Island Pacific<br>UPC</th>
          <th class="DataTable" >Shopotron<br>UPC</th>
        </tr>
     <!------------------------------- Data Detail --------------------------------->
     <%while(itmavl.getNext()){
         itmavl.getShopOrd();
         int iNumOfOrd = itmavl.getNumOfOrd();
         String [] sOrd = itmavl.getOrd();
         String [] sMfgId = itmavl.getMfgId();
         String [] sCatId = itmavl.getCatId();
         String [] sPartId = itmavl.getPartId();
         String [] sProdNm = itmavl.getProdNm();
         String [] sReqQty = itmavl.getReqQty();
         String [] sReqColor = itmavl.getReqColor();
         String [] sReqSize = itmavl.getReqSize();

         int [] iNumOfSku = itmavl.getNumOfSku();
         String [][] sCls = itmavl.getCls();
         String [][] sVen = itmavl.getVen();
         String [][] sSty = itmavl.getSty();
         String [][] sClr = itmavl.getClr();
         String [][] sSiz = itmavl.getSiz();
         String [][] sSku = itmavl.getSku();
         String [][] sRet = itmavl.getRet();
         String [][] sCost = itmavl.getCost();
         String [][] sDesc = itmavl.getDesc();
         String [][] sAvlQty = itmavl.getAvlQty();
         String [][] sClrNm = itmavl.getClrNm();
         String [][] sSizNm = itmavl.getSizNm();
         String [][] sItmMatch = itmavl.getItmMatch();
         String [] sOrdMatch = itmavl.getOrdMatch();
         String [][] sIpUpc = itmavl.getIpUpc();
         String [][] sShUpc = itmavl.getShUpc();
         String [][] sVenSty = itmavl.getVenSty();
         %>

         <%for(int i=0; i < iNumOfOrd; i++){%>
           <tr class="DataTable<%=sOrdMatch[i]%>" id="trOrd<%=sOrdMatch[i]%>">
             <%
                String sRowspan = "1";
                if(iNumOfSku[i] > 1){ sRowspan = Integer.toString(iNumOfSku[i]); }
             %>
             <td class="DataTable1" rowspan="<%=sRowspan%>">
               <a href="https://www.shopatron.com/rtl/orders/place_bid?order_id=<%=sOrd[i]%>&lid=0&page=0&fb=filter&ob=orderid" target="_blank"><%=sOrd[i]%></a>
             </td>
             <td class="DataTable1" rowspan="<%=sRowspan%>">&nbsp;<%=sMfgId[i]%></td>
             <td class="DataTable1" rowspan="<%=sRowspan%>">&nbsp;<%=sCatId[i]%></td>
             <td class="DataTable1" rowspan="<%=sRowspan%>">&nbsp;<%=sPartId[i]%></td>
             <td class="DataTable1" rowspan="<%=sRowspan%>">&nbsp;<%=sProdNm[i]%></td>
             <td class="DataTable1" nowrap rowspan="<%=sRowspan%>">&nbsp;<%=sReqColor[i]%></td>
             <td class="DataTable1" nowrap rowspan="<%=sRowspan%>">&nbsp;<%=sReqSize[i]%></td>
             <td class="DataTable2" rowspan="<%=sRowspan%>">&nbsp;<%=sReqQty[i]%></td>
             <%for(int j=0; j < iNumOfSku[i] ; j++){%>
                <td class="DataTable1" nowrap><%=sVenSty[i][j]%></td>
                <td class="DataTable1" nowrap><%=sCls[i][j] + "-" + sVen[i][j] + "-" + sSty[i][j] + "-" + sClr[i][j] + "-" + sSiz[i][j]%></td>
                <td class="DataTable1" nowrap><%=sSku[i][j]%></td>
                <td class="DataTable1" nowrap><%=sDesc[i][j]%></td>
                <td class="DataTable2" nowrap><%=sRet[i][j]%></td>
                <td class="DataTable2" nowrap><%=sAvlQty[i][j]%></td>
                <td class="DataTable1" nowrap><%=sClrNm[i][j]%></td>
                <td class="DataTable1" nowrap><%=sSizNm[i][j]%></td>
                <td class="DataTable1" nowrap><%=sIpUpc[i][j]%></td>
                <td class="DataTable1" nowrap><%=sShUpc[i][j]%></td>
                <%if(iNumOfSku[i] > 1){%></tr><tr class="DataTable" id="trOrd<%=sOrdMatch[i]%>"><%}%>
             <%}%>
           </tr>
         <%}%>
      <%}%>
      <!------------------------ End Details ---------------------------------->
   </table>
    <!----------------------- end of table ---------------------------------->

  </table>
 </body>

</html>

<%
  itmavl.disconnect();
  itmavl = null;
%>
