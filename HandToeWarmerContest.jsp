<%@ page import="strempslsrep.HandToeWarmerContest, java.util.*"%>
<%
    HandToeWarmerContest htwcont = new HandToeWarmerContest();

    int iNumOfStr = htwcont.getNumOfStr();

    String [] sStr = htwcont.getStr();
    String [] sStrName = htwcont.getStrName();
    String [] sStrRet = htwcont.getStrRet();
    String [] sStrQty = htwcont.getStrQty();

    int iNumOfSku = htwcont.getNumOfSku();
    String [] sSku = htwcont.getSku();
    String [] sSkuName = htwcont.getSkuName();
    String [] sSkuRet = htwcont.getSkuRet();
    String [] sSkuQty = htwcont.getSkuQty();

    String sTotRet = htwcont.getTotRet();
    String sTotQty = htwcont.getTotQty();

    htwcont.disconnect();
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
  th.DataTable { background:#FFCC99; border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px;
                 padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 text-align:center; font-family:Verdanda; font-size:12px }

  tr.DataTable  { background: #E7E7E7; font-family:Arial; font-size:10px }
  tr.DataTable1 { background: cornsilk; font-family:Arial; font-size:10px }

  td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:right;}

  td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:left;}
 .small{ text-align:left; font-family:Arial; font-size:10px;}

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//---------------------------------------------
// initialize value on load
//---------------------------------------------
function  bodyload(){}
</SCRIPT>


</head>
<body onload="bodyload()">
 <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
   <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Hand and Toe Warmer Contest
      <br>Sales from 02/28/2005 through yesterday
      </b>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <font size="-1">This Page.</font>
      </td>
   </tr>
   <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
<!-------------------------------------------------------------------->
  <!----------------- beginning of table ------------------------>
  <table class="DataTable" cellPadding="0" cellSpacing="0">
    <tr>
      <th class="DataTable" >Store</th>
      <th class="DataTable" >Retail</th>
      <th class="DataTable" >Quantity</th>
    </tr>

<!------------------------------- Detail Data --------------------------------->
   <%for(int i=0; i < iNumOfStr; i++){%>
         <tr class="DataTable">
           <td class="DataTable1" nowrap><%=sStr[i]%> - <%=sStrName[i]%></td>
           <td class="DataTable" nowrap>$<%=sStrRet[i]%></td>
           <td class="DataTable" nowrap><%=sStrQty[i]%></td>
        </tr>
   <%}%>
<!------------------------------- Total --------------------------------->
   <tr class="DataTable1">
      <td class="DataTable1" nowrap>Total</td>
      <td class="DataTable" nowrap>$<%=sTotRet%></td>
      <td class="DataTable" nowrap><%=sTotQty%></td>
    </tr>
 </table>

<!-------------------------------------------------------------------->
<p><b>Total by Sku</b>
  <!----------------- beginning of table ------------------------>
  <table class="DataTable" cellPadding="0" cellSpacing="0">
    <tr>
      <th class="DataTable" >Item</th>
      <th class="DataTable" >Retail</th>
      <th class="DataTable" >Quantity</th>
    </tr>


<!------------------------------- Detail Data by SKU -------------------------->
   <%for(int i=0; i < iNumOfSku; i++){%>
         <tr class="DataTable">
           <td class="DataTable1" nowrap><%=sSku[i]%> - <%=sSkuName[i]%></td>
           <td class="DataTable" nowrap>$<%=sSkuRet[i]%></td>
           <td class="DataTable" nowrap><%=sSkuQty[i]%></td>
        </tr>
   <%}%>
 <!------------------------------- Total --------------------------------->
   <tr class="DataTable1">
      <td class="DataTable1" nowrap>Total</td>
      <td class="DataTable" nowrap>$<%=sTotRet%></td>
      <td class="DataTable" nowrap><%=sTotQty%></td>
    </tr>
 </table>
 <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
