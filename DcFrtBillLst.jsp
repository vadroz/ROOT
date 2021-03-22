<%@ page import="dcfrtbill.DcFrtBillLst"%>
<%
    String sStore  = request.getParameter("STORE");
    String sFromDate = request.getParameter("FromDate");
    String sToDate = request.getParameter("ToDate");
    String sType = request.getParameter("repType");
    String sFilter = request.getParameter("filter");
    String sFrtBill = request.getParameter("FrtB");

    if (sFrtBill == null) { sFrtBill = " ";}

    //System.out.println(sStore + "|" + sFromDate + "|" + sToDate + "|" + sType + "|" + sFilter + "|" + sFrtBill);
    DcFrtBillLst frblist = new DcFrtBillLst(sStore, sFromDate, sToDate, sType, sFilter, sFrtBill);
%>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px; text-align:center;}
        th.DataTable { background:#FFCC99; border-top: darkred solid 1px; border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable  { background:cornsilk; font-family:Arial; font-size:10px }
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
    <TD vAlign=top align=middle><b>Retail Concepts Inc.
        <BR>Daily Freight Bill Report
        <BR>Selected Store: <%=sStore%> &nbsp; &nbsp;
            Selected Ship Dates: <%=sFromDate%>  - <%=sToDate%>
        </b>

      <br><p><a href="../"><font color="red"  size="-1">Home</font></a>&#62;
        <a href="DcFrtBills.jsp"><font color="red" size="-1">Select Freght Bill</font></a>&#62;
        <font size="-1">This page</font>
      <!------------- start Receipt table ------------------------>
      <table class="DataTable" align="center" cellPadding='0' cellSpacing='0'>
             <tr class="DataTable">
                <th class="DataTable" rowspan=2>Whse</th>
                <th class="DataTable" rowspan=2>Str</th>
                <th class="DataTable" rowspan=2>Freight<br>Bill</th>
                <th class="DataTable" rowspan=2>Ship Date</th>
                <th class="DataTable" rowspan=2># of Pallet</th>
                <th class="DataTable" rowspan=2># of Cartons</th>
                <th class="DataTable" rowspan=2>Carton<br>with<br>Non-Merch<br>Content</th>
                <th class="DataTable" rowspan=2>I<br>t<br>e<br>m<br>s</th>
                <th class="DataTable" rowspan=2>Tot<br>Qty</th>
                <th class="DataTable" rowspan=2>Wght</th>
                <th class="DataTable" rowspan=2>Carrier</th>
                <th class="DataTable" rowspan=2>R<br>c<br>v<br>d</th>
                <th class="DataTable" colspan=4>Store Acknowledge</th>
                <th class="DataTable" rowspan=2>C<br>l<br>e<br>a<br>r</th>
                <th class="DataTable" colspan=4>DC Acknowledge</th>
                <th class="DataTable" rowspan=2>A<br>k<br>n<br>w<br>l</th>
                <th class="DataTable" colspan=3>Audit</th>
                <th class="DataTable" rowspan=2>A<br>u<br>d<br>i<br>t</th>
             </tr>
             <tr class="DataTable">
                <th class="DataTable">Date</th>
                <th class="DataTable">User</th>
                <th class="DataTable">Distro#</th>
                <th class="DataTable">Comments</th>

                <th class="DataTable">Date</th>
                <th class="DataTable">User</th>
                <th class="DataTable">Distro#</th>
                <th class="DataTable">Comments</th>

                <th class="DataTable">FB</th>
                <th class="DataTable">PM</th>
                <th class="DataTable">PWR</th>
             </tr>
      <!-- ============= Details =========================================== -->
      <%
         while(frblist.getNextFrtBill())
         {
           frblist.getFrtBillList();
           int iNumOfFrt = frblist.getNumOfFrt();
           String [] sFrtB = frblist.getFrtB();
           String [] sCarrier = frblist.getCarrier();
           String [] sStr = frblist.getStr();
           String [] sSts = frblist.getSts();
           String [] sShipDt = frblist.getShipDt();
           String [] sShipTm = frblist.getShipTm();
           String [] sUser = frblist.getUser();
           String [] sComment = frblist.getComment();
           String [] sWhse = frblist.getWhse();
           String [] sNumPlt = frblist.getNumPlt();
           String [] sNumCtn = frblist.getNumCtn();
           String [] sWgt = frblist.getWgt();

           for(int i = 0; i < iNumOfFrt; i++)
           {%>
              <tr class="DataTable">
                 <td class="DataTable"><%=sWhse[i]%></td>
                 <td class="DataTable"><%=sStr[i]%></td>
                 <td class="DataTable"><%=sFrtB[i]%></td>
                 <td class="DataTable"><%=sShipDt[i]%></td>
                 <td class="DataTable"><%=sNumPlt[i]%></td>
                 <td class="DataTable"><%=sNumPlt[i]%></td>
                 <td class="DataTable">&nbsp;</td>
                 <td class="DataTable"><a href="">D</a></td>
                 <td class="DataTable">&nbsp;</td>
                 <td class="DataTable"><%=sWgt[i]%></td>
                 <td class="DataTable"><%=sCarrier[i]%></td>
                 <td class="DataTable"><a href="">R</a></td>
                 <td class="DataTable">&nbsp;</td>
                 <td class="DataTable">&nbsp;</td>
                 <td class="DataTable">&nbsp;</td>
                 <td class="DataTable">&nbsp;</td>
                 <td class="DataTable"><a href="">C</a></td>
                 <td class="DataTable">&nbsp;</td>
                 <td class="DataTable">&nbsp;</td>
                 <td class="DataTable">&nbsp;</td>
                 <td class="DataTable">&nbsp;</td>
                 <td class="DataTable"><a href="">A</a></td>
                 <td class="DataTable">&nbsp;</td>
                 <td class="DataTable">&nbsp;</td>
                 <td class="DataTable">&nbsp;</td>
                 <td class="DataTable"><a href="">A</a></td>
              </tr>
         <%}
    }
      %>


       </table>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</body>
</html>
<%
  frblist.disconnect();
  frblist = null;
%>