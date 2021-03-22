<%@ page import="flashreps.SkiStopInv ,java.util.*, java.text.*"%>
<%
   String sDiv = request.getParameter("Div");
   String sDpt = request.getParameter("Dpt");
   String sCls = request.getParameter("Cls");
   String sVendor = request.getParameter("Ven");
   String sItmLevel = request.getParameter("ItmLevel");
   String sUser = session.getAttribute("USER").toString();

   SkiStopInv strSstSls = new SkiStopInv(sDiv, sDpt, sCls, sVendor, sItmLevel, sUser);
   int iNumOfGrp = strSstSls.getNumOfGrp();

   String sColName = null;
   if(sItmLevel.equals("DIV")){ sColName = "Division";}
   else if(sItmLevel.equals("DPT")){ sColName = "Department";}
   else if(sItmLevel.equals("CLS")){ sColName = "Class";}
   else if(sItmLevel.equals("VEN")){ sColName = "Vendor";}
   else if(sItmLevel.equals("ITEM")){ sColName = "Item";}
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
       <br>Store 86 Inventory Summary
       <br>Selection - Division: <%=sDiv%> &nbsp;&nbsp;
           Department: <%=sDpt%> &nbsp;&nbsp;
           Class: <%=sCls%> &nbsp;&nbsp;
           Vendor: <%=sVendor%> &nbsp;&nbsp;
       <br>
       </b>

        <a href="../"><font color="red" size="-1">Home</font></a>&#62;
        <a href="SkiStopInvSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
        <font size="-1">This page</font>
        <!----------------- start of table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0">
           <thead style="overflow: visible;">
             <tr class="DataTable">
               <%if(!sItmLevel.equals("NONE")){%>
                  <th class="DataTable" rowspan=2><%=sColName%></th>
                  <%if(sItmLevel.equals("ITEM")){%>
                     <th class="DataTable" rowspan=2>Vendor</th>
                     <th class="DataTable" rowspan=2>Category</th>
                     <th class="DataTable" rowspan=2>Sub-Category</th>
                     <th class="DataTable" rowspan=2>Ski Stop<br>Vendor</th>
                  <%}%>
               <%}%>
               <th class="DataTable" rowspan=2>&nbsp;</th>
               <th class="DataTable" colspan=3>Inventory</th>
             </tr>

             <tr class="DataTable">
                <th class="DataTable">Retail</th>
                <th class="DataTable">Cost</th>
                <th class="DataTable">Qty</th>
             </tr>
           </thead>
        <!--------------------- Group List ----------------------------->
        <tbody>
        <%for(int j=0; j < iNumOfGrp; j++){%>
          <%
             strSstSls.setSalesInfo();
             String sGrp = strSstSls.getGrp();
             String sGrpName = strSstSls.getGrpName();
             String sVen = strSstSls.getVen();
             String sVenName = strSstSls.getVenName();
             String sCateg = strSstSls.getCateg();
             String sSubCateg = strSstSls.getSubCateg();
             String sInvQty = strSstSls.getInvQty();
             String sInvRet = strSstSls.getInvRet();
             String sInvCost = strSstSls.getInvCost();
             String sSstVen = strSstSls.getSstVen();
             String sSstVenName = strSstSls.getSstVenName();
          %>
           <tr class="DataTable1">
             <%if(!sItmLevel.equals("NONE")){%>
                <td class="DataTable" nowrap>&nbsp;<%=sGrp%><%=" - " + sGrpName%></td>
             <%}%>

             <%if(sItmLevel.equals("ITEM")){%>
                 <td class="DataTable" nowrap><%=sVen + " - " + sVenName%></td>
                 <td class="DataTable"><%=sCateg%>&nbsp;</td>
                 <td class="DataTable"><%=sSubCateg%>&nbsp;</td>
                 <td class="DataTable" nowrap><%=sSstVen + " - " + sSstVenName%></td>
             <%}%>

             <th class="DataTable">&nbsp;</th>
             <td class="DataTable1">$<%=sInvRet%></td>
             <td class="DataTable1">$<%=sInvCost%></td>
             <td class="DataTable1"><%=sInvQty%></td>
        <%}%>
        <%
           // Report Total
           strSstSls.setTotal();
           String sInvQty = strSstSls.getInvQty();
           String sInvRet = strSstSls.getInvRet();
           String sInvCost = strSstSls.getInvCost();
        %>
        <tr class="DataTable2">
             <td class="DataTable" <%if(sItmLevel.equals("ITEM")){%>colspan=5<%}%>>Report total</td>
             <th class="DataTable">&nbsp;</th>
             <td class="DataTable1">$<%=sInvRet%></td>
             <td class="DataTable1">$<%=sInvCost%></td>
             <td class="DataTable1"><%=sInvQty%></td>
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