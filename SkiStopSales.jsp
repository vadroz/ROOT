<%@ page import="flashreps.SkiStopSales ,java.util.*, java.text.*"%>
<%
   String sDiv = request.getParameter("Div");
   String sDpt = request.getParameter("Dpt");
   String sCls = request.getParameter("Cls");
   String sVendor = request.getParameter("Ven");
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");
   String sItmLevel = request.getParameter("ItmLevel");
   String sDatLevel = request.getParameter("DatLevel");
   String sUser = session.getAttribute("USER").toString();

   SkiStopSales strSstSls = new SkiStopSales(sDiv, sDpt, sCls, sVendor, sFrom, sTo, sItmLevel, sDatLevel, sUser);
   int iNumOfGrp = strSstSls.getNumOfGrp();
   String sSelFrom = strSstSls.getSelFrom();
   String sSelTo = strSstSls.getSelTo();

   String sColName = null;
   if(sItmLevel.equals("DIV")){ sColName = "Division";}
   else if(sItmLevel.equals("DPT")){ sColName = "Department";}
   else if(sItmLevel.equals("CLS")){ sColName = "Class";}
   else if(sItmLevel.equals("VEN")){ sColName = "Vendor";}
   else if(sItmLevel.equals("ITEM")){ sColName = "Item";}
   else if(sItmLevel.equals("SUBCAT")){ sColName = "Sub-Category";}
   else { sColName = "&nbsp;";}
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
</SCRIPT>

</head>

<body  onload="bodyLoad();">
  <table border="0" width="100%" height="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Store 86 Sales Summary
       <br>Selection - Division: <%=sDiv%> &nbsp;&nbsp;
           Department: <%=sDpt%> &nbsp;&nbsp;
           Class: <%=sCls%> &nbsp;&nbsp;
           Vendor: <%=sVendor%> &nbsp;&nbsp;
       <br>Dates &nbsp;&nbsp; From: <%=sSelFrom%> &nbsp;&nbsp; Through: <%=sSelTo%>
       <br>
       </b>

        <a href="../"><font color="red" size="-1">Home</font></a>&#62;
        <a href="SkiStopSalesSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
        <font size="-1">This page</font>
        <!----------------- start of table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0">
           <thead style="overflow: visible;">
             <tr class="DataTable">
               <%if(!sDatLevel.equals("NONE")){%>
                    <th class="DataTable" rowspan=2>Period</th>
               <%}%>
               <%if(!sItmLevel.equals("NONE")){%>
                  <%if(!sItmLevel.equals("SUBCAT")){%>
                     <th class="DataTable" rowspan=2><%=sColName%></th>
                  <%}
                  else {%>
                     <th class="DataTable" rowspan=2>Category</th>
                     <th class="DataTable" rowspan=2>Sub-Category</th>
                  <%}%>
                  <%if(sItmLevel.equals("ITEM")){%>
                     <th class="DataTable" rowspan=2>Category</th>
                     <th class="DataTable" rowspan=2>Sub-Category</th>
                     <th class="DataTable" rowspan=2>Vendor</th>
                     <th class="DataTable" rowspan=2>Ski Stop<br>Vendor</th>
                  <%}%>
               <%}%>
               <th class="DataTable" rowspan=2>&nbsp;</th>
               <th class="DataTable" colspan=3>Sales</th>
               <th class="DataTable" rowspan=2>&nbsp;</th>
               <th class="DataTable" colspan=3>P.O.</th>
               <th class="DataTable" rowspan=2>&nbsp;</th>
               <th class="DataTable" colspan=2>Gross Margin</th>
             </tr>

             <tr class="DataTable">
                <th class="DataTable">Retail</th>
                <th class="DataTable">Cost</th>
                <th class="DataTable">Qty</th>

                <th class="DataTable">Retail</th>
                <th class="DataTable">Cost</th>
                <th class="DataTable">Qty</th>

                <th class="DataTable">Amount</th>
                <th class="DataTable">%</th>
             </tr>
           </thead>
        <!--------------------- Group List ----------------------------->
        <tbody>
        <%for(int j=0; j < iNumOfGrp; j++){%>
          <%
             strSstSls.setSalesInfo();
             String sPeriod = strSstSls.getPeriod();
             String sGrp = strSstSls.getGrp();
             String sGrpName = strSstSls.getGrpName();
             String sQty = strSstSls.getQty();
             String sRet = strSstSls.getRet();
             String sCost = strSstSls.getCost();
             String sPeriodBreak = strSstSls.getPeriodBreak();
             String sPoQty = strSstSls.getPoQty();
             String sPoRet = strSstSls.getPoRet();
             String sPoCost = strSstSls.getPoCost();
             String sVen = strSstSls.getVen();
             String sVenName = strSstSls.getVenName();
             String sCateg = strSstSls.getCateg();
             String sSubCateg = strSstSls.getSubCateg();
             String sGrsMrg = strSstSls.getGrsMrg();
             String sGrsMrgPrc = strSstSls.getGrsMrgPrc();
             String sInvQty = strSstSls.getInvQty();
             String sInvRet = strSstSls.getInvRet();
             String sInvCost = strSstSls.getInvCost();
             String sSstVen = strSstSls.getSstVen();
             String sSstVenName = strSstSls.getSstVenName();
          %>
           <tr class="DataTable1<%if(sPeriodBreak.equals("1")){%>1<%}%>">
             <%if(!sDatLevel.equals("NONE")){%>
                <td class="DataTable">&nbsp;<%=sPeriod%></td>
             <%}%>
             <%if(!sItmLevel.equals("NONE") && !sItmLevel.equals("SUBCAT")){%>
                <td class="DataTable" nowrap>&nbsp;<%=sGrp%><%if(sPeriodBreak.equals("0")){%><%=" - " + sGrpName%><%}%></td>
             <%}
             else if(sItmLevel.equals("SUBCAT")){%>
                <td class="DataTable"><%=sCateg%>&nbsp;</td>
                <td class="DataTable"><%=sSubCateg%>&nbsp;</td>
             <%}%>


             <%if(sItmLevel.equals("ITEM")){%>
                 <td class="DataTable"><%=sCateg%>&nbsp;</td>
                 <td class="DataTable"><%=sSubCateg%>&nbsp;</td>
                 <td class="DataTable" nowrap><%=sVen + " - " + sVenName%></td>
                 <td class="DataTable" nowrap><%=sSstVen + " - " + sSstVenName%></td>
             <%}%>

             <th class="DataTable">&nbsp;</th>
             <td class="DataTable1">$<%=sRet%></td>
             <td class="DataTable1">$<%=sCost%></td>
             <td class="DataTable1"><%=sQty%></td>
             <th class="DataTable">&nbsp;</th>
             <td class="DataTable1">$<%=sPoRet%></td>
             <td class="DataTable1">$<%=sPoCost%></td>
             <td class="DataTable1"><%=sPoQty%></td>
             <th class="DataTable">&nbsp;</th>
             <td class="DataTable1">$<%=sGrsMrg%></td>
             <td class="DataTable1"><%=sGrsMrgPrc%>%</td>
        <%}%>
        <%
           // Report Total
           strSstSls.setTotal();
           String sQty = strSstSls.getQty();
           String sRet = strSstSls.getRet();
           String sCost = strSstSls.getCost();
           String sPoQty = strSstSls.getPoQty();
           String sPoRet = strSstSls.getPoRet();
           String sPoCost = strSstSls.getPoCost();
           String sGrsMrg = strSstSls.getGrsMrg();
           String sGrsMrgPrc = strSstSls.getGrsMrgPrc();
           String sInvQty = strSstSls.getInvQty();
           String sInvRet = strSstSls.getInvRet();
           String sInvCost = strSstSls.getInvCost();
        %>
        <tr class="DataTable2">
             <td class="DataTable"
                 <%if(sItmLevel.equals("ITEM") && !sDatLevel.equals("NONE")){%>colspan=6
                 <%} else if(sItmLevel.equals("ITEM") && sDatLevel.equals("NONE")){%>colspan=5
                 <%} else if(sItmLevel.equals("SUBCAT") && sDatLevel.equals("NONE")){%>colspan=2
                 <%} else if(sItmLevel.equals("SUBCAT") && !sDatLevel.equals("NONE")){%>colspan=3
                 <%} else if(!sItmLevel.equals("NONE") && !sDatLevel.equals("NONE")){%>colspan=2<%}%>
                 >
                 Report total</td>
             <th class="DataTable">&nbsp;</th>
             <td class="DataTable1">$<%=sRet%></td>
             <td class="DataTable1">$<%=sCost%></td>
             <td class="DataTable1"><%=sQty%></td>
             <th class="DataTable">&nbsp;</th>
             <td class="DataTable1">$<%=sPoRet%></td>
             <td class="DataTable1">$<%=sPoCost%></td>
             <td class="DataTable1"><%=sPoQty%></td>
             <th class="DataTable">&nbsp;</th>
             <td class="DataTable1">$<%=sGrsMrg%></td>
             <td class="DataTable1"><%=sGrsMrgPrc%>%</td>
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
   strSstSls.disconnect();
   strSstSls = null;
%>