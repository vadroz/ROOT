<%@ page import="agedanalysis.SkuAgedAnalysis, java.util.*"%>
<%
   String sClass = request.getParameter("Cls");
   String sStore = request.getParameter("Str");
   SkuAgedAnalysis skuage = new SkuAgedAnalysis(sClass, sStore);
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        th.InvData { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.InvData { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}


        tr.DataTable { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:Honeydew; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:#cfcfcf; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:darkred;}
        tr.DataTable5 { background:Azure; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable2 { border-top: double darkred;}


        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
function bodyLoad()
{
}
</SCRIPT>


</head>
<body onload="bodyLoad()">

    <table border="0" width="100%"cellPadding="0" cellSpacing="0">
     <tr>
<!-------------------------------------------------------------------->

      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Sku Aged Inventory Analysis
      <br>Store: <%=sStore%> &nbsp;&nbsp
          Class: <%=sClass%>
          </b>
      </td>
     </tr>

     <tr>
      <td ALIGN="Center" VALIGN="TOP" colspan=3>

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="AgedAnalysisSel.jsp?mode=1"><font color="red" size="-1">Select Report</font></a>&#62;
          <font size="-1">This Page.</font>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
	  <th class="DataTable">Item Number</th>
          <th class="DataTable">Short SKU</th>
          <th class="DataTable">Description</th>
          <th class="DataTable">Vendor<br>Style</th>
          <th class="DataTable">Vendor Name</th>
          <th class="DataTable">Color Name</th>
          <th class="DataTable">Size Name</th>
          <th class="DataTable">Store<br>Qty</th>
          <th class="DataTable">Extended<br>Cost</th>
          <th class="DataTable">Extended<br>Retail</th>
          <th class="DataTable"><u>MU</u><br>(%)</th>
          <th class="DataTable">Cost</th>
          <th class="DataTable">Retail</th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
       <%while(skuage.getNext())
    {
        skuage.setItmList();
        int  iNumOfSku = skuage.getNumOfSku();
        String [] sCls = skuage.getCls();
        String [] sVen = skuage.getVen();
        String [] sSty = skuage.getSty();
        String [] sClr = skuage.getClr();
        String [] sSiz = skuage.getSiz();
        String [] sSku = skuage.getSku();
        String [] sDesc = skuage.getDesc();
        String [] sVenSty = skuage.getVenSty();
        String [] sClsNm = skuage.getClsNm();
        String [] sVenNm = skuage.getVenNm();
        String [] sClrNm = skuage.getClrNm();
        String [] sSizNm = skuage.getSizNm();
        String [] sQty = skuage.getQty();
        String [] sStrQty = skuage.getStrQty();
        String [] sCostEx = skuage.getCostEx();
        String [] sRetEx = skuage.getRetEx();
        String [] sPrc = skuage.getPrc();
        String [] sCost = skuage.getCost();
        String [] sRet = skuage.getRet();
    %>
           <%for(int i=0; i < iNumOfSku; i++) {%>

              <tr class="DataTable">
                <td class="DataTable1" nowrap><%=sCls[i]%>-<%=sVen[i]%>-<%=sSty[i]%>-<%=sClr[i]%>-<%=sSiz[i]%></td>
                <td class="DataTable" nowrap><%=sSku[i]%></td>
                <td class="DataTable1" nowrap><%=sDesc[i]%></td>
                <td class="DataTable1" nowrap><%=sVenSty[i]%></td>
                <td class="DataTable1" nowrap><%=sVenNm[i]%></td>
                <td class="DataTable1" nowrap><%=sClrNm[i]%></td>
                <td class="DataTable1" nowrap><%=sSizNm[i]%></td>
                <td class="DataTable" nowrap><%=sStrQty[i]%></td>
                <td class="DataTable" nowrap>$<%=sCostEx[i]%></td>
                <td class="DataTable" nowrap>$<%=sRetEx[i]%></td>
                <td class="DataTable" nowrap><%=sPrc[i]%>%</td>
                <td class="DataTable" nowrap>$<%=sCost[i]%></td>
                <td class="DataTable" nowrap>$<%=sRet[i]%></td>
              </tr>
           <%}%>
         <%}%>
<!------------------- Company Total -------------------------------->
      <%
         skuage.setTotal();

         String sTotQty = skuage.getTotQty();
         String sTotStrQty = skuage.getTotStrQty();
         String sTotCost = skuage.getTotCost();
         String sTotRet = skuage.getTotRet();
         String sTotPrc = skuage.getTotPrc();
      %>
      <tr class="DataTable1">
                <td class="DataTable" nowrap colspan=7><b>Total</b></td>
                <td class="DataTable" nowrap><%=sTotStrQty%></td>
                <td class="DataTable" nowrap>$<%=sTotCost%></td>
                <td class="DataTable" nowrap>$<%=sTotRet%></td>
                <td class="DataTable" nowrap><%=sTotPrc%>%</td>
                <td class="DataTable" nowrap colspan=2>&nbsp;</td>
              </tr>
      </table>
      <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>

