<%@ page import="inventoryreports.PiWiRep"%>
<%
  String sStore = request.getParameter("STORE");
  String sArea = request.getParameter("AREA");
  String sSortBy = request.getParameter("SORT");
  String sPiYearMo = request.getParameter("PICal");
  String sSum = request.getParameter("Sum");

  if (sSortBy==null) sSortBy = "R";
  if (sSum==null) sSum = "Y";

  PiWiRep invrep = new PiWiRep(sStore, sArea, sSortBy, sPiYearMo.substring(0, 4),  sPiYearMo.substring(4), sSum);

%>

<html>
<head>
<title>Physical Inventory by Area</title>
<style> body {background:ivory;  vertical-align:bottom;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}

        th.DataTable { background:#FFCC99;padding-top:1px; padding-bottom:1px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99;padding-top:1px; padding-bottom:1px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       border-top: darkred solid 1px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:#e7e7e7;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }
        td.DataTablep { background:pink;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }
        td.DataTableg { background: lightgreen;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }               
                                      
        td.DataTable1 { background: #e7e7e7;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:left; font-family:Arial; font-size:10px }
         td.DataTable2 { background:CornSilk;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }
         td.DataTable3 { background: #e7e7e7;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:8px }
         td.DataTable4 { background: #e7e7e7;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:right; font-family:Arial; font-size:10px }
                       
    @media screen
    {
        tr.Hdr {display:none; }
    }
    @media print
    {
        tr.Hdr {display:block }
    }
</style>
<SCRIPT language="JavaScript">

function bodyLoad()
{
}
</SCRIPT>
</head>
<body  onload="bodyLoad();">

   <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
    <tr bgColor="moccasin">
     <td style="vertical-align:top; text-align:center;">
      <b>Retail Concepts, Inc
      <br>Physical Inventory by Area
      <br>Store:<%=sStore%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          Area: <%=sArea%></b>
<!------------- end of store selector ---------------------->
        <br><a href="../"><font color="red" size="-1">Home</font></a>&#62;
        <font size="-1">This page</font><br><br>
        <span style="font-size:11px">
            *The initial display of this report is in the
            <a href="PIWIRep.jsp?STORE=<%=sStore%>&AREA=<%=sArea%>&SORT=R&PICal=<%=sPiYearMo%>&Sum=N">
            EXACT order that RGIS counted</a>
            this area, you can click on SHORT SKU to re-rank the listing by Short Sku.
       </span>

       <br>
       <%if(sSum.equals("N")){%><a href="PIWIRep.jsp?STORE=<%=sStore%>&AREA=<%=sArea%>&SORT=R&PICal=<%=sPiYearMo%>&Sum=Y" style="font-size:11px">Total Qty by SKU</a><%}
       else {%><a href="PIWIRep.jsp?STORE=<%=sStore%>&AREA=<%=sArea%>&SORT=R&PICal=<%=sPiYearMo%>&Sum=N" style="font-size:11px">All Entires</a><%}%>

<!------------- start of dollars table ------------------------>
      <table class="DataTable" align="center" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" rowspan="2">Div<br/>#</th>
          <th class="DataTable" rowspan="2">Dpt<br/>#</th>
          <th class="DataTable" rowspan="2">Item<br/>Number</th>
          <th class="DataTable" colspan="2">Vendor Information</th>
          <th class="DataTable" colspan="4">Item Information</th>
          <th class="DataTable" rowspan="2">RGIS Scanned<br>UPC</th>
          <th class="DataTable" rowspan="2">
              <a href="PIWIRep.jsp?STORE=<%=sStore%>&AREA=<%=sArea%>&SORT=S&PICal=<%=sPiYearMo%>">
                 Short<br>SKU</a></th>
          <th class="DataTable" rowspan="2">Q<br>t<br>y</th>
          <%if(sSum.equals("Y")){%>
          		<th class="DataTable" rowspan="2">Recounts</th>
          		<th class="DataTable" colspan="4">PI Unit Adjustments<br>(Total results for SKU)</th>
          		<th class="DataTable" rowspan="2">&nbsp;</th>
          		<th class="DataTable" colspan="4">All Count Corrections</th>
          <%}%>          
        </tr>
        <tr>
          <th class="DataTable">Name</th>
          <th class="DataTable">Style</th>

          <th class="DataTable">Description</th>
          <th class="DataTable">Color</th>
          <th class="DataTable">Size</th>
          <th class="DataTable">Item<br>Ret</th>
          
          <%if(sSum.equals("Y")){%>
          <th class="DataTable">PI Counts</th>
          <th class="DataTable">On Hand</th>
          <th class="DataTable">Adjustment</th>
          <th class="DataTable">Area</th>
          <th class="DataTable">Qty</th>
          <th class="DataTable">User</th>
          <th class="DataTable">Date/Time</th>
          <%} %>          
        </tr>
     <!-- ---------------------- Detail Loop ----------------------- -->
     <% int iOverFlow = 1;%>

     <%while(invrep.getNext())
     {
        invrep.setItemProp();
        int iNumOfItm = invrep.getNumOfItm();
        String [] sDiv = invrep.getDiv();
        String [] sDpt = invrep.getDpt();
        String [] sCls = invrep.getCls();
        String [] sVen = invrep.getVen();
        String [] sSty = invrep.getSty();
        String [] sClr = invrep.getClr();
        String [] sSiz = invrep.getSiz();
        String [] sDesc = invrep.getDesc();
        String [] sClrNm = invrep.getClrNm();
        String [] sSizNm = invrep.getSizNm();
        String [] sVenSty = invrep.getVenSty();
        String [] sVenNm = invrep.getVenNm();
        String [] sSku = invrep.getSku();
        String [] sUpc = invrep.getUpc();
        String [] sQty = invrep.getQty();
        String [] sRet = invrep.getRet();
        String [] sBookQty = invrep.getBookQty();
        String [] sPhyQty = invrep.getPhyQty();
        String [] sAdjQty = invrep.getAdjQty();
        String [] sCorQty = invrep.getCorQty();
        String [] sCorBy = invrep.getCorBy();
        String [] sCorDt = invrep.getCorDt();
        String [] sCorTm = invrep.getCorTm();


        for(int i=0; i < iNumOfItm; i++) {%>

   <%if(iOverFlow++ > 29){%>
       <tr>
         <td colspan="11">
            <div style="page-break-before:always"></div>
            <% iOverFlow = 1; %>
         <tr class="Hdr">
          <th class="DataTable1" rowspan="2">Div<br/>#</th>
          <th class="DataTable1" rowspan="2">Dpt<br/>#</th>
          <th class="DataTable1" rowspan="2">Item<br/>Number</th>
          <th class="DataTable1" colspan="2">Vendor Information</th>
          <th class="DataTable1" colspan="3">Item Information</th>
          <th class="DataTable1" colspan="2">RGIS Scanned</th>
          <th class="DataTable1" rowspan="2">Qty</th>
        </tr>
        <tr class="Hdr">
          <th class="DataTable">Name</th>
          <th class="DataTable">Style</th>
          <th class="DataTable">Description</th>
          <th class="DataTable">Color</th>
          <th class="DataTable">Size</th>
          <th class="DataTable1" >UPC</th>
          <th class="DataTable" >Short<br>SKU</th>
        </tr>
             </td>
           </tr>
          <%}%>

           <tr>
             <td class="DataTable"><%=sDiv[i]%></td>
             <td class="DataTable"><%=sDpt[i]%></td>
             <td class="DataTable3" nowrap>
                <%=sCls[i] + "-" +sVen[i] + "-" +sSty[i] + "-" +sClr[i] + "-" +sSiz[i]%></td>

             <td class="DataTable1" nowrap><%=sVenNm[i]%></td>
             <td class="DataTable1" nowrap><%=sVenSty[i]%></td>

             <td class="DataTable1" nowrap><%=sDesc[i]%></td>
             <td class="DataTable1" nowrap><%=sClrNm[i]%></td>
             <td class="DataTable1" nowrap><%=sSizNm[i]%></td>   
             <td class="DataTable4" nowrap>$<%=sRet[i]%></td>

             <td class="DataTable"><%=sUpc[i]%></td>
             <td class="DataTable"> 
                <a class="Small" href="PIItmSlsHst.jsp?STORE=<%=sStore%>&Sku=<%=sSku[i]%>&FromDate=01/01/0001&ToDate=12/31/2099&PICal=<%=sPiYearMo%>" target="_blank"><%=sSku[i]%></a>
             </td>

             <td class="DataTable"><%=sQty[i]%></td>
             <%if(sSum.equals("Y")){%>
                <td class="DataTable"><input size=10 maxlength=10 readonly></td>
             	<td class="DataTable"><%=sPhyQty[i]%></td>
             	<td class="DataTable"><%=sBookQty[i]%></td>
             	<td class="DataTable<%if(!sAdjQty[i].equals("0") && sAdjQty[i].indexOf("-") >= 0){%>p<%}
             	 else if(!sAdjQty[i].equals("0") && sAdjQty[i].indexOf("-") < 0){%>g<%}%>">
             		<%=sAdjQty[i]%>
             	</td>
             	<td class="DataTable">
             		<%if(!sAdjQty[i].equals("0")){%>
             			<a href="UpcInvSearch.jsp?UPC=&SKU=<%=sSku[i]%>&STORE=<%=sStore%>&PICal=<%=sPiYearMo%>" target="_blank">A</a>
             	    <%}%> 
             	</td>             	
             
             	<th class="DataTable">&nbsp;</th>
             	<td class="DataTable"><%if(!sCorQty[i].equals("0")){%><%=sCorQty[i]%><%}%></td>
             	<td class="DataTable"><%if(!sCorBy[i].equals("")){%><%=sCorBy[i]%><%}%></td>
             	<td class="DataTable"><%if(!sCorBy[i].equals("")){%><%=sCorDt[i]%><%}%></td>
             <%} %>
           </tr>
        <%}%>
      <%}%>
      <%
        invrep.setTotQty();
        String sTotQty = invrep.getTotQty();
      %>
           <tr>
            <td class="DataTable2" colspan='11'>Total</td>
            <td class="DataTable2"><%=sTotQty%></td>
            <%if(sSum.equals("Y")){%>
            	<td class="DataTable2" colspan=9>&nbsp;</td>
            <%}%>
           </tr>

       </table>

<!------------- end of data table ------------------------>

                </td>
            </tr>
       </table>

        </body>
      </html>
<%invrep.disconnect();%>