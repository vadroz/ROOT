<%@ page import="flashreps.SkiStopPFO ,java.util.*, java.text.*"%>
<%
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");
   String sUser = session.getAttribute("USER").toString();

   SkiStopPFO sstPfo = new SkiStopPFO(sFrom, sTo, sUser);
   int iNumOfOrd = sstPfo.getNumOfOrd();
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue;  font-size:12px;} a:visited { color:blue; font-size:12px;}  a:hover { color:blue; font-size:12px;}
  a.Small:link { color:blue;  font-size:10px;} a.Small:visited { color:purple; font-size:10px;}  a.Small:hover { color:darkblue; font-size:10px;}

  table.DataTable { border: gray solid 1px; background:#e7e7e7; text-align:center;}
  tr.DataTable { font-family:Verdanda; text-align:center;
                 font-size:12px; font-weight:bold}
  th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: gray solid 1px; border-right: gray solid 1px;}

  tr.DataTable1 { background:#e7e7e7; font-family:Verdanda; text-align:left; font-size:10px;}
  tr.DataTable11 { background:azure; font-family:Verdanda; text-align:left; font-size:10px;}
  tr.DataTable2 { background:cornsilk; font-family:Verdanda; text-align:left; font-size:10px;}

  td.DataTable { border-bottom: gray solid 1px; border-right: gray solid 1px;text-align:left;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable1 { border-bottom: gray solid 1px; border-right: gray solid 1px;text-align:right;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable11 { border-bottom: gray solid 1px; border-right: gray solid 2px;text-align:right;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable2 { border-bottom: gray solid 1px; border-right: gray solid 1px; text-align:center;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable21 { cursor: hand; border-bottom: gray solid 1px; border-right: gray solid 1px; text-align:center;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
</style>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variable
//==============================================================================
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
}
//==============================================================================
// load Order Detail page
//==============================================================================
function showOrder(ord, date, ret, cost, grsmrg, gmprc)
{
   url = "SkiStopPFODtl.jsp?"
       + "Ord=" + ord
       + "&Date=" + date
       + "&Ret=" + ret
       + "&Cost=" + cost
       + "&GrsMrg=" + grsmrg
       + "&GMPrc=" + gmprc
   //alert(url)
   window.location.href = url
}
</SCRIPT>

</head>

<body  onload="bodyLoad();">
  <table border="0" width="100%" height="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Ski Stop Patio Furniture Order List
       <br>From: <%=sFrom%> &nbsp;&nbsp; Through: <%=sTo%>
       <br>
       </b>

        <a href="../"><font color="red" size="-1">Home</font></a>&#62;
        <a href="SkiStopPFOSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
        <font size="-1">This page</font>
        <!----------------- start of table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0">
           <thead style="overflow: visible;">
             <tr class="DataTable">
                <th class="DataTable">Order</th>
                <th class="DataTable">Order<br>Date</th>
                <th class="DataTable">Extended Retail</th>
                <th class="DataTable">Extended Cost</th>
                <th class="DataTable">Qty</th>
                <th class="DataTable">Gross Margin</th>
                <th class="DataTable">GM %</th>
             </tr>

           </thead>
        <!--------------------- Group List ----------------------------->
        <tbody>
        <%for(int j=0; j < iNumOfOrd; j++){%>
          <%
            sstPfo.setOrderInfo();
            String sOrd = sstPfo.getOrd();
            String sOrdDate = sstPfo.getOrdDate();
            String sRet = sstPfo.getRet();
            String sCost = sstPfo.getCost();
            String sQty = sstPfo.getQty();
            String sGrsMrg = sstPfo.getGrsMrg();
            String sGMPrc = sstPfo.getGMPrc();
          %>
           <tr class="DataTable1">
           <td class="DataTable1"><a class="Small" href="javascript: showOrder('<%=sOrd%>', '<%=sOrdDate%>','<%=sRet%>', '<%=sCost%>','<%=sGrsMrg%>','<%=sGMPrc%>')"><%=sOrd%></a></td>
           <td class="DataTable1"><%=sOrdDate%></td>
             <td class="DataTable1">$<%=sRet%></td>
             <td class="DataTable1">$<%=sCost%></td>
             <td class="DataTable1"><%=sQty%></td>
             <td class="DataTable1">$<%=sGrsMrg%></td>
             <td class="DataTable1"><%=sGMPrc%>%</td>
           </tr>
        <%}%>
        <!----------------- Report Total ------------------------>
        <%
           sstPfo.setTotal();
           String sRet = sstPfo.getRet();
           String sCost = sstPfo.getCost();
           String sQty = sstPfo.getQty();
           String sGrsMrg = sstPfo.getGrsMrg();
           String sGMPrc = sstPfo.getGMPrc();
        %>
           <tr class="DataTable2">
             <td class="DataTable" colspan=2>Total</td>
             <td class="DataTable1">$<%=sRet%></td>
             <td class="DataTable1">$<%=sCost%></td>
             <td class="DataTable1"><%=sQty%></td>
             <td class="DataTable1">$<%=sGrsMrg%></td>
             <td class="DataTable1"><%=sGMPrc%>%</td>
           </tr>
         </tbody>
       </table>
       <!----------------- start of ad table ------------------------>
      </td>
     </tr>
    </table>
  </body>
</html>




<%
   sstPfo.disconnect();
   sstPfo = null;
%>