<%@ page import="dcfrtbill.DCReceiptDtl"%>
<%
    String sVen = request.getParameter("Ven");
    String sVenName = request.getParameter("VenName");
    String sDiv = request.getParameter("Div");
    String sDivName = request.getParameter("DivName");
    String sFrom = request.getParameter("From");
    String sTo = request.getParameter("To");

    if(sDiv==null || sDiv.equals("")) sDiv="0";

    DCReceiptDtl DCRcpt = new DCReceiptDtl(sVen, sDiv, sFrom, sTo);
    int iNumOfEnt = DCRcpt.getNumOfEnt();
    String [] sStr = DCRcpt.getStr();
    String [] sPono = DCRcpt.getPono();
    String [] sTCd = DCRcpt.getTCd();
    String [] sTerm = DCRcpt.getTerm();
    String [] sQty = DCRcpt.getQty();
    String [] sCost = DCRcpt.getCost();
    String [] sRet = DCRcpt.getRet();
    String [] sOrdDate = DCRcpt.getOrdDate();
    String [] sAntDate = DCRcpt.getAntDate();
    String [] sCnlDate = DCRcpt.getCnlDate();

    DCRcpt.disconnect();

%>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable {background:#FFE4C4; border: darkred solid 1px; text-align:center;}
        th.DataTable { background:#FFCC99; border-top: darkred solid 1px; border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable  { background: lightgrey; font-family:Arial; font-size:10px }
        td.DataTable { border-top: darkred solid 1px; border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px; padding-right:2px; padding-left:2px; text-align:center }
        td.DataTable1 { border-top: darkred solid 1px; border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px; padding-right:2px; padding-left:2px; text-align:right }

        input.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:left; font-family:Arial; font-size:10px;}
        select.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:left; font-family:Arial; font-size:10px;}
</style>

<script language="javascript1.2">

</script>

<html>
<head>
<title>
DC Receipt Details
</title>
</head>
<body>
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>DC Receipts Details
        <%if(!sDiv.equals("0")){%>
          <BR>Selected Division: <font color="brown"><%=sDiv + " - " + sDivName%></font>
        <%}%>
                   <br>Vendor: <font color="brown"><%=sVen + " - " + sVenName%></font>
                   <br>From: <font color="brown"><%=sFrom%>&nbsp;&nbsp;&nbsp;</font>
                   To: <font color="brown"><%=sTo%></font></B>

      <br><p><a href="../"><font color="red"  size="-1">Home</font></a>&#62;
        <a href="DcReceiptSel.jsp"><font color="red" size="-1">Select Receipt</font></a>&#62;
        <font size="-1">This page</font>
      <!------------- start Receipt table ------------------------>
      <table class="DataTable" align="center" width="60%"  cellPadding='0' cellSpacing='0'>
             <tr class="DataTable">
                <th class="DataTable">Str</th>
                <th class="DataTable">Purchase<br>Order #</th>

                <th class="DataTable">Order<br>Date</th>
                <th class="DataTable">Anticipate<br>Date</th>
                <th class="DataTable">Cancel<br>Date</th>

                <th class="DataTable">Term<br>Code</th>
                <th class="DataTable">Term</th>
                <th class="DataTable">Qty</th>
                <th class="DataTable">Cost</th>
                <th class="DataTable">Retail<br>Price</th>
             </tr>

             <%for(int i=0; i < iNumOfEnt; i++){%>
               <tr class="DataTable">
                 <td class="DataTable"><%=sStr[i]%></td>
                 <td class="DataTable"><%=sPono[i]%></td>
                 <td class="DataTable"><%=sOrdDate[i]%></td>
                 <td class="DataTable"><%=sAntDate[i]%></td>
                 <td class="DataTable"><%=sCnlDate[i]%></td>
                 <td class="DataTable"><%=sTCd[i]%></td>
                 <td class="DataTable"><%=sTerm[i]%></td>
                 <td class="DataTable1"><%=sQty[i]%></td>
                 <td class="DataTable1">$<%=sCost[i]%></td>
                 <td class="DataTable1">$<%=sRet[i]%></td>
               </tr>
             <%}%>
       </table>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</body>
</html>
