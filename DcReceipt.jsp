<%@ page import="dcfrtbill.DCReceipt"%>
<%
    String sToDate = request.getParameter("selDate");
    String sFromDate = request.getParameter("FromDate");
    String sRepType = request.getParameter("RepType");

    DCReceipt DCRcpt = new DCReceipt(sFromDate, sToDate, sRepType);
    int iNumOfEnt = DCRcpt.getNumOfEnt();
    String [] sDiv = DCRcpt.getDiv();
    String [] sDivName = DCRcpt.getDivName();
    String [] sDivByVen = DCRcpt.getDivByVen();
    String [] sVen = DCRcpt.getVen();
    String [] sVenName = DCRcpt.getVenName();
    String [] sQty = DCRcpt.getQty();
    String [] sCost = DCRcpt.getCost();
    String [] sRet = DCRcpt.getRet();

    String sTotQty = DCRcpt.getTotQty();
    String sTotCost = DCRcpt.getTotCost();
    String sTotRet = DCRcpt.getTotRet();

    String sDivJSA = DCRcpt.getDivJSA();
    String sVenJSA = DCRcpt.getVenJSA();
    DCRcpt.disconnect();

%>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable {background:#FFE4C4; border: darkred solid 1px; text-align:center;}
        th.hdr { background:#FFCC99; border-top: darkred solid 1px; border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }

        tr.row  { background: lightgrey; font-family:Arial; font-size:10px }
        tr.row1  { background: cornsilk; font-family:Arial; font-size:10px }
        td.cell { border-top: darkred solid 1px; border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px; padding-right:2px; padding-left:2px; text-align:left }
        td.cell1 { border-top: darkred solid 1px; border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px; padding-right:2px; padding-left:2px; text-align:right }

        input.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:left; font-family:Arial; font-size:10px;}
        select.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:left; font-family:Arial; font-size:10px;}
</style>

<!-- Calendar -->
<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<script language="javascript1.2">

function bodyLoad(){
}


</script>

<html>
<head>
<title>
DC Receipt
</title>
</head>
<body onload="bodyLoad();">
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>DC Receipts Summary
        <BR>Selected Dates:  <%=sFromDate%> - <%=sToDate%></B>

      <br><p><a href="../"><font color="red"  size="-1">Home</font></a>&#62;
        <a href="DcReceiptSel.jsp"><font color="red" size="-1">Select Receipt</font></a>&#62;
        <font size="-1">This page</font>

      <!------------- start Receipt table ------------------------>
      <table class="DataTable" align="center" cellPadding='0' cellSpacing='0'>
             <tr>
                <th class="hdr">Division</th>
                <th class="hdr">Vendor</th>
                <th class="hdr">Qty</th>
                <th class="hdr">Cost</th>
                <th class="hdr">Retail<br>Price</th>
             </tr>

             <%for(int i=0; i < iNumOfEnt; i++){%>
               <tr class="row">
                 <td class="cell">
                    <%if(sRepType.equals("D")){%>
                      <%=sDiv[i] + " - " + sDivName[i]%>
                    <%}
                    else {%>
                      <%=sDivByVen[i]%>
                    <%}%>
                 </td>
                 <td class="cell">
                 <a href="DcReceiptDtl.jsp?Ven=<%=sVen[i]%>&VenName=<%=sVenName[i]%>&Div=<%=sDiv[i]%>&DivName=<%=sDivName[i]%>&From=<%=sFromDate%>&To=<%=sToDate%>">
                 <%=sVen[i] + " - " + sVenName[i]%></a>
                 </td>
                 <td class="cell1"><%=sQty[i]%></td>
                 <td class="cell1">$<%=sCost[i]%></td>
                 <td class="cell1">$<%=sRet[i]%></td>
               </tr>
             <%}%>
             <!-- ---------------------- Total ----------------------------- -->
             <tr class="row1">
                 <td class="cell" colspan="2">Total</td>
                 <td class="cell1"><%=sTotQty%></td>
                 <td class="cell1">$<%=sTotCost%></td>
                 <td class="cell1">$<%=sTotRet%></td>
               </tr>
       </table>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</body>
</html>
