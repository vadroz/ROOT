<%@ page import="flashreps.SkiStopPFODtl ,java.util.*, java.text.*"%>
<%
   String sOrd = request.getParameter("Ord");
   String sOrdDate = request.getParameter("Date");
   String sTotRet = request.getParameter("Ret");
   String sTotCost = request.getParameter("Cost");
   String sTotGrsMrg = request.getParameter("GrsMrg");
   String sTotGMPrc = request.getParameter("GMPrc");
   String sUser = session.getAttribute("USER").toString();

   SkiStopPFODtl sstPfoItm = new SkiStopPFODtl(sOrd, "vrozen");
   int iNumOfItm = sstPfoItm.getNumOfItm();

%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue;  font-size:12px;} a:visited { color:blue; font-size:12px;}  a:hover { color:blue; font-size:12px;}
  a.Small:link { color:blue;  font-size:10px;} a.Small:visited { color:purple; font-size:10px;}  a.Small:hover { color:darkblue; font-size:10px;}

  table.DataTable { border: gray solid 1px; background:#e7e7e7; text-align:center;}
  tr.DataTable { background:#FFCC99; font-family:Verdanda; text-align:center;
                 font-size:12px; font-weight:bold}
  th.DataTable {  padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: gray solid 1px; border-right: gray solid 1px;}

  tr.DataTable0 { background:white; font-family:Verdanda; text-align:left; font-size:10px;}
  tr.DataTable1 { background:cornsilk; font-family:Verdanda; text-align:left; font-size:10px;}
  tr.DataTable11 { background:azure; font-family:Verdanda; text-align:left; font-size:10px;}
  tr.DataTable2 { background:#e7e7e7; font-family:Verdanda; text-align:left; font-size:10px;}
  tr.DataTable3 { background:cornsilk; font-family:Verdanda; text-align:left; font-size:12px; font-weight:bold}

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
</SCRIPT>

</head>

<body  onload="bodyLoad();">
  <table border="0" width="100%" height="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Ski Stop Patio Furniture Order Details
       <br>
       </b>

        <a href="../"><font color="red" size="-1">Home</font></a>&#62;
        <a href="SkiStopPFOSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
        <font size="-1">This page</font>
        <!----------------- Order totals ------------------------>
        <table class="DataTable" cellPadding="0" cellSpacing="0" width="30%">
           <tr class="DataTable3"><td class="DataTable">Order</td><td class="DataTable2"><%=sOrd%></td></tr>
           <tr class="DataTable3"><td class="DataTable">Order Date</td><td class="DataTable2"><%=sOrdDate%></td></tr>
           <tr class="DataTable3"><td class="DataTable">Retail</td><td class="DataTable1">$<%=sTotRet%></td></tr>
           <tr class="DataTable3"><td class="DataTable">Cost</td><td class="DataTable1">$<%=sTotCost%></td></tr>
           <tr class="DataTable3"><td class="DataTable">Gross Margin</td><td class="DataTable1">$<%=sTotGrsMrg%></td></tr>
           <tr class="DataTable3"><td class="DataTable">GM %</td><td class="DataTable1"><%=sTotGMPrc%>%</td></tr>
        </table>
        <br>

        <!----------------- start of table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0">
           <thead style="overflow: visible;">
             <tr class="DataTable">
                <th class="DataTable">Item</th>
                <th class="DataTable">Desc</th>
                <th class="DataTable">Category</th>
                <th class="DataTable">Sub-Category</th>
                <th class="DataTable">Primery<br>Vendor</th>
                <th class="DataTable">Vendor<br>Name</th>
                <th class="DataTable">Extended Retail</th>
                <th class="DataTable">Extended Cost</th>
                <th class="DataTable">Qty</th>
                <th class="DataTable">Gross Margin</th>
                <th class="DataTable">GM%</th>
             </tr>

           </thead>
        <!--------------------- Group List ----------------------------->
        <tbody>
        <%for(int j=0; j < iNumOfItm; j++){%>
          <%
            sstPfoItm.setOrderInfo();
            String sItem = sstPfoItm.getItem();
            String sCateg = sstPfoItm.getCateg();
            String sSubCat = sstPfoItm.getSubCat();
            String sPrimVend = sstPfoItm.getPrimVend();
            String sVenName = sstPfoItm.getVenName();
            String sDesc = sstPfoItm.getDesc();
            String sRet = sstPfoItm.getRet();
            String sCost = sstPfoItm.getCost();
            String sQty = sstPfoItm.getQty();
            String sGrsMrg = sstPfoItm.getGrsMrg();
            String sGrsMrgPrc = sstPfoItm.getGrsMrgPrc();
            String sSet = sstPfoItm.getSet();
          %>
           <tr class="DataTable<%=sSet%>">
             <td class="DataTable"><%=sItem%></td>
             <td class="DataTable"><%=sDesc%></td>
             <td class="DataTable"><%=sCateg%>&nbsp;</td>
             <td class="DataTable"><%=sSubCat%>&nbsp;</td>
             <td class="DataTable"><%=sPrimVend%>&nbsp;</td>
             <td class="DataTable"><%=sVenName%>&nbsp;</td>
             <td class="DataTable1">$<%=sRet%></td>
             <td class="DataTable1">$<%=sCost%></td>
             <td class="DataTable1"><%=sQty%></td>
             <td class="DataTable1">$<%=sGrsMrg%></td>
             <td class="DataTable1"><%=sGrsMrgPrc%>%</td>
           </tr>
        <%}%>
         </tbody>
       </table>
       <!----------------- start of ad table ------------------------>
      </td>
     </tr>
    </table>
  </body>
</html>




<%
   sstPfoItm.disconnect();
   sstPfoItm = null;
%>