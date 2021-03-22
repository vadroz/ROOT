<%@ page import="inventoryreports.PIStyleInv, java.util.*"%>
<%
   String sSelCls = request.getParameter("Cls");
   String sSelVen = request.getParameter("Ven");
   String sSelSty = request.getParameter("Sty");
   String sSortBy = request.getParameter("Sort");
   String sPiYearMo = request.getParameter("PICal");

   if(sSortBy == null) sSortBy = "STR";

//-------------- Security ---------------------
if (session.getAttribute("USER")==null)
{
    response.sendRedirect("SignOn1.jsp?TARGET=PIStyleInv.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    String sUser = session.getAttribute("USER").toString();
    PIStyleInv setPi = new PIStyleInv(sSelCls, sSelVen, sSelSty, sPiYearMo.substring(0, 4),  sPiYearMo.substring(4), sSortBy, sUser);

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
    int iNumOfItm = setPi.getNumOfItm();

    String [] sCls = setPi.getCls();
    String [] sVen = setPi.getVen();
    String [] sSty = setPi.getSty();
    String [] sClr = setPi.getClr();
    String [] sSiz = setPi.getSiz();
    String [] sSku = setPi.getSku();
    String [] sDesc = setPi.getDesc();
    String [] sVenSty = setPi.getVenSty();

    // Physical Count
    String [] sItmPhQty = setPi.getItmPhQty();
    String [] sItmPhRet = setPi.getItmPhRet();
    String [] sItmPhCst = setPi.getItmPhCst();
    // Computer On Hand
    String [] sItmOhQty = setPi.getItmOhQty();
    String [] sItmOhRet = setPi.getItmOhRet();
    String [] sItmOhCst = setPi.getItmOhCst();
    // Adjustment
    String [] sItmAdQty = setPi.getItmAdQty();
    String [] sItmAdRet = setPi.getItmAdRet();
    String [] sItmAdCst = setPi.getItmAdCst();

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
    
    boolean bByDiv = sSelCls.equals("ALL");
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
        tr.DataTable1 { background:cornsilk; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center;}



        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Cls = "<%=sSelCls%>";
var Ven = "<%=sSelVen%>";
var Sty = "<%=sSelSty%>";
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
  var url = "PIStyleInv.jsp?"
          + "Cls=" + Cls
          + "&Ven=" + Ven
          + "&Sty=" + Sty
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
      <br>Physical Inventory Adjustment Report for Selected Class/Vendor/Style
      <br>Class: <%=sSelCls%> &nbsp;  &nbsp; Vendor: <%=sSelVen%> &nbsp;  &nbsp; Style: <%=sSelSty%>
      <br>Inventory Period = <%=sPiYearMo.substring(0, 4) + "/" + sPiYearMo.substring(4)%>
      <br></b>
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="PIStyleInvSel.jsp?"><font color="red" size="-1">Select Report</font></a>&#62;
          <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;
      <a href="PIOnHand.jsp" style="font-size:12px;">PI Count vs. On Hand</a>
<!-------------------------------------------------------------------->
<br><br>
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
           <tr class="DataTable1">
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

      <br><br>

      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
          <%if(!bByDiv){%> 
	      	<th class="DataTable"  rowspan="2">Long Item Number<br>Cls-Ven-Sty-Clr-siz</th>
          	<th class="DataTable"  rowspan="2">Short SKU</th>
          	<th class="DataTable"  rowspan="2">Item Description</th>
          	<th class="DataTable"  rowspan="2">Vendor<br>Style</th>
          <%} else{%>
             <th class="DataTable"  rowspan="2">Division</th>
          <%} %>
          <th class="DataTable"  rowspan="2">&nbsp;&nbsp;</th>

          <th class="DataTable"  colspan="3">Physical Count</th>
          <th class="DataTable"  rowspan="2">&nbsp;&nbsp;</th>

          <th class="DataTable"  colspan="3">Computer On Hand</th>
          <th class="DataTable"  rowspan="2">&nbsp;&nbsp;</th>

          <th class="DataTable"  colspan="3">Total Adjustment</th>
        </tr>

        <tr>
            <th class="DataTable">Units</th>
            <th class="DataTable">Cost</th>
            <th class="DataTable">Retail</th>

            <th class="DataTable">Units</th>
            <th class="DataTable">Cost</th>
            <th class="DataTable">Retail</th>

            <th class="DataTable">Units</th>
            <th class="DataTable">Cost</th>
            <th class="DataTable">Retail</th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfItm; i++) {%>

              <tr class="DataTable">
                <%if(!bByDiv){%> 
                	<td class="DataTable" nowrap><%=sCls[i] + "-" + sVen[i] + "-" + sSty[i] + "-" + sClr[i] + "-" + sSiz[i]%></td>
                	<td class="DataTable2" nowrap><a href="PISkuInv.jsp?Sku=<%=sSku[i]%>&PICal=<%=sPiYearMo%>" target="_blank"><%=sSku[i]%></a></td>
                	<td class="DataTable1" nowrap><%=sDesc[i]%></td>
                	<td class="DataTable1" nowrap><%=sVenSty[i]%></td>
                <%} else {%>
                	<td class="DataTable1" nowrap><%=sCls[i]%> - <%=sDesc[i]%></td>
                <%} %>


                <th class="DataTable">&nbsp;&nbsp;</th>

                <td class="DataTable" nowrap><%=sItmPhQty[i]%></td>
                <td class="DataTable" nowrap>$<%=sItmPhCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sItmPhRet[i]%></td>

                <th class="DataTable">&nbsp;&nbsp;</th>

                <td class="DataTable" nowrap><%=sItmOhQty[i]%></td>
                <td class="DataTable" nowrap>$<%=sItmOhCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sItmOhRet[i]%></td>

                <th class="DataTable">&nbsp;&nbsp;</th>

                <td class="DataTable" nowrap><%=sItmAdQty[i]%></td>
                <td class="DataTable" nowrap>$<%=sItmAdCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sItmAdRet[i]%></td>
              </tr>
           <%}%>
      <!------------------- Company Total -------------------------------->
           <tr class="DataTable1">
              <td class="DataTable1" <%if(!bByDiv){%> colspan=4 <%} %>>Totals</td>
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