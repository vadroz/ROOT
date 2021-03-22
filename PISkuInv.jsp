<%@ page import="inventoryreports.PISkuInv, java.util.*"%>
<%
   String sSelSku = request.getParameter("Sku");
   String sSortBy = request.getParameter("Sort");
   String sPiYearMo = request.getParameter("PICal");

   if(sSortBy == null) sSortBy = "STR";

//-------------- Security ---------------------
if (session.getAttribute("USER")==null)
{
    response.sendRedirect("SignOn1.jsp?TARGET=PISkuInvSel.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    String sUser = session.getAttribute("USER").toString();
    PISkuInv setPi = new PISkuInv(sSelSku, sPiYearMo.substring(0, 4),  sPiYearMo.substring(4), sSortBy, sUser);

    String sCls = setPi.getCls();
    String sVen = setPi.getVen();
    String sSty = setPi.getSty();
    String sClr = setPi.getClr();
    String sSiz = setPi.getSiz();
    String sSku = setPi.getSku();
    String sItmDsc = setPi.getItmDsc();

    int iNumOfStr = setPi.getNumOfStr();

    String [] sStr = setPi.getStr();

    // Physical Count
    String [] sPhQty = setPi.getPhQty();
    String [] sPhRet = setPi.getPhRet();
    String [] sPhCst = setPi.getPhCst();
    // Computer On Hand
    String [] sOhQty = setPi.getOhQty();
    String [] sOhRet = setPi.getOhRet();
    String [] sOhCst = setPi.getOhCst();
    // Adjustment
    String [] sAdQty = setPi.getAdQty();
    String [] sAdRet = setPi.getAdRet();
    String [] sAdCst = setPi.getAdCst();

    //--------------------------------------------------------------------------
    //------------------------ Report Totals ---------------------------------
    // Physical Count
    String sRepPhQty = setPi.getRepPhQty();
    String sRepPhRet = setPi.getRepPhRet();
    String sRepPhCst = setPi.getRepPhCst();
    // Computer On Hand
    String sRepOhQty = setPi.getRepOhQty();
    String sRepOhRet = setPi.getRepOhRet();
    String sRepOhCst = setPi.getRepOhCst();
    // Adjustment
    String sRepAdQty = setPi.getRepAdQty();
    String sRepAdRet = setPi.getRepAdRet();
    String sRepAdCst = setPi.getRepAdCst();
    //--------------------------------------------------------------------------

    setPi.disconnect();
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


        tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:Honeydew; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }
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
var Sku = [<%=sSelSku%>];
var SortBy = "<%=sSortBy%>";
var PiYearMo = <%=sPiYearMo%>;


//--------------- End of Global variables ----------------
function bodyLoad()
{
}

//-------------------------------------------------------------
// Re-Sort table
//-------------------------------------------------------------
function reSort(sort)
{
  var url = "PISkuInv.jsp?"
          + "Sku=" + Sku
          + "&Sort=" + sort
          + "&PICal=" + PiYearMo
  window.location.href = url;
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body onload="bodyLoad()">

    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">
<!-------------------------------------------------------------------->
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Physical Inventory Adjustment Report for Selected SKU
      <br>Inventory Period = <%=sPiYearMo.substring(0, 4) + "/" + sPiYearMo.substring(4)%>
      <br></b>
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="PISkuInvSel.jsp?"><font color="red" size="-1">Select Report</font></a>&#62;
          <font size="-1">This Page.</font>
<!-------------------------------------------------------------------->
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr class="DataTable3">
           <td class="DataTable1" nowrap>Item:</td>
           <td class="DataTable1" nowrap><%=sCls + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz%></td>
         </tr>
         <tr class="DataTable3">
           <td class="DataTable1" nowrap>Sku:</td>
           <td class="DataTable1" nowrap><%=sSelSku%></td>
         </tr>
         <tr class="DataTable3">
           <td class="DataTable1" nowrap>Description:</td>
           <td class="DataTable1" nowrap><%=sItmDsc%></td>
         </tr>
      </table>
<!-------------------------------------------------------------------->
<br><br>
      <a href="PIOnHand.jsp?Vendor=<%=sVen%>&Class=<%=sCls%>&PICal=<%=sPiYearMo%>" style="font-size:12px;">PI Count vs. On Hand</a>

      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
	  <th class="DataTable"  rowspan="2"><a href="javascript: reSort('STR')">Store</a></th>
          <th class="DataTable"  rowspan="2">&nbsp;&nbsp;</th>

          <th class="DataTable"  colspan="3">Physical Count</th>
          <th class="DataTable"  rowspan="2">&nbsp;&nbsp;</th>

          <th class="DataTable"  colspan="3">Computer On Hand</th>
          <th class="DataTable"  rowspan="2">&nbsp;&nbsp;</th>

          <th class="DataTable"  colspan="3">Total Adjustment</th>
        </tr>

        <tr>
            <th class="DataTable"><a href="javascript: reSort('PHQTY')">Units</a></th>
            <th class="DataTable"><a href="javascript: reSort('PHCST')">Cost</a></th>
            <th class="DataTable"><a href="javascript: reSort('PHRET')">Retail</a></th>

            <th class="DataTable"><a href="javascript: reSort('OHQTY')">Units</a></th>
            <th class="DataTable"><a href="javascript: reSort('OHCST')">Cost</a></th>
            <th class="DataTable"><a href="javascript: reSort('OHRET')">Retail</a></th>

            <th class="DataTable"><a href="javascript: reSort('ADQTY')">Units</a></th>
            <th class="DataTable"><a href="javascript: reSort('ADCST')">Cost</a></th>
            <th class="DataTable"><a href="javascript: reSort('ADRET')">Retail</a></th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfStr; i++) {%>

              <tr class="DataTable">
                <td class="DataTable" nowrap><%=sStr[i]%></td>
                <th class="DataTable">&nbsp;&nbsp;</th>

                <td class="DataTable" nowrap><%=sPhQty[i]%></td>
                <td class="DataTable" nowrap>$<%=sPhCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sPhRet[i]%></td>

                <th class="DataTable">&nbsp;&nbsp;</th>

                <td class="DataTable" nowrap><%=sOhQty[i]%></td>
                <td class="DataTable" nowrap>$<%=sOhCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sOhRet[i]%></td>

                <th class="DataTable">&nbsp;&nbsp;</th>

                <td class="DataTable" nowrap><%=sAdQty[i]%></td>
                <td class="DataTable" nowrap>$<%=sAdCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sAdRet[i]%></td>
              </tr>
           <%}%>
      <!------------------- Company Total -------------------------------->
           <tr class="DataTable3">
              <td class="DataTable1" nowrap>Totals</td>
              <th class="DataTable">&nbsp;</th>

              <td class="DataTable" nowrap><%=sRepPhQty%></td>
              <td class="DataTable" nowrap>$<%=sRepPhCst%></td>
              <td class="DataTable" nowrap>$<%=sRepPhRet%></td>

              <th class="DataTable">&nbsp;&nbsp;</th>

              <td class="DataTable" nowrap><%=sRepOhQty%></td>
              <td class="DataTable" nowrap>$<%=sRepOhCst%></td>
              <td class="DataTable" nowrap>$<%=sRepOhRet%></td>

              <th class="DataTable">&nbsp;&nbsp;</th>

              <td class="DataTable" nowrap><%=sRepAdQty%></td>
              <td class="DataTable" nowrap>$<%=sRepAdCst%></td>
              <td class="DataTable" nowrap>$<%=sRepAdRet%></td>
           </tr>
      </table>
     </td>
    </tr>
  <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%}%>