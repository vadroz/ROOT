<%@ page import="dcfrtbill.WhsUnlocItem ,java.util.*, java.text.*"%>
<%
   String sSelDiv = request.getParameter("Div");
   String sSelDpt = request.getParameter("Dpt");
   String sSelCls = request.getParameter("Cls");
   String sSelVen = request.getParameter("Ven");
   String sSelWhs = request.getParameter("Whs");
   String sSort = request.getParameter("Sort");
   String sUser = session.getAttribute("USER").toString();

   if(sSort == null) { sSort = "Grp";}

   WhsUnlocItem unlocItem = new WhsUnlocItem(sSelDiv, sSelDpt, sSelCls, sSelVen, sSelWhs, sSort, sUser);
   int iNumOfItm = unlocItem.getNumOfItm();

   String sColName = null;
   String sLevel = null;
   if(sSelDiv.equals("ALL") && sSelDpt.equals("ALL") && sSelCls.equals("ALL")){ sColName = "Division"; sLevel = "DIV";}
   else if(sSelDpt.equals("ALL") && sSelCls.equals("ALL")){ sColName = "Department"; sLevel = "DPT";}
   else if(sSelCls.equals("ALL")){ sColName = "Class";  sLevel = "CLS";}
   else { sColName = "Item Number";  sLevel = "ITEM";}
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
// drill down to next level of classification
//==============================================================================
function drillDown(grp, level)
{
  var url = "WhsUnlocItem.jsp?"
  if(level=="DIV") { url += "Div=" + grp + "&Dpt=<%=sSelDpt%>&Cls=<%=sSelCls%>&Ven=<%=sSelVen%>&Whs=<%=sSelWhs%>&Sort=<%=sSort%>"}
  else if(level=="DPT") { url += "Div=<%=sSelDiv%>&Dpt=" + grp + "&Cls=<%=sSelCls%>&Ven=<%=sSelVen%>&Whs=<%=sSelWhs%>&Sort=<%=sSort%>"}
  else if(level=="CLS") { url += "Div=<%=sSelDiv%>&Dpt=<%=sSelDpt%>&Cls=" + grp + "&Ven=<%=sSelVen%>&Whs=<%=sSelWhs%>&Sort=<%=sSort%>"}

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// sort by 
//==============================================================================
function sortBy(sort)
{
	var url = "WhsUnlocItem.jsp?"
      + "Div=<%=sSelDiv%>&Dpt=<%=sSelDpt%>&Cls=<%=sSelCls%>&Ven=<%=sSelVen%>&Whs=<%=sSelWhs%>"
      + "&Sort=" + sort;			 
	
	window.location.href=url;	
}
</SCRIPT>
</head>

<body  onload="bodyLoad();">
  <table border="0" width="100%" height="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Items Unlocated in Warehouse
       <br>Selection - Division: <%=sSelDiv%> &nbsp;&nbsp;
           Department: <%=sSelDpt%> &nbsp;&nbsp;
           Class: <%=sSelCls%> &nbsp;&nbsp;
           Vendor: <%=sSelVen%> &nbsp;&nbsp;
       <br>
       </b>

        <a href="../"><font color="red" size="-1">Home</font></a>&#62;
        <a href="WhsUnlocItemSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
        <font size="-1">This page</font>
        <!----------------- start of table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0">
           <thead style="overflow: visible;">
             <tr class="DataTable">
               <th class="DataTable"><a href="javascript: sortBy('Grp')"><%=sColName%></a></th>
               <%if(sLevel.equals("ITEM")){%>
                  <th class="DataTable"><a href="javascript: sortBy('Desc')">Description</a></th>
                  <th class="DataTable"><a href="javascript: sortBy('Sku')">Short Sku</a></th>
                  <th class="DataTable"><a href="javascript: sortBy('Ven')">Vendor Name</a></th>
                  <th class="DataTable"><a href="javascript: sortBy('RcvDt')">Received<br>Date</a></th>
               <%}%>

               <th class="DataTable">&nbsp;</th>
               <th class="DataTable"><a href="javascript: sortBy('QtyEnt')">Qty<br>Entered</a></th>
               <th class="DataTable"><a href="javascript: sortBy('QtyRem')">Qty<br>Remaining</a></th>
               <th class="DataTable"><a href="javascript: sortBy('ExtRet')">Extended<br>Retail</a></th>
               <th class="DataTable"><a href="javascript: sortBy('ExtCst')">Extended<br>Cost</a></th>
               <th class="DataTable"><a href="javascript: sortBy('BSRLvl')">BSR<br>Level</a></th>
               <th class="DataTable"><a href="javascript: sortBy('OnHand')">On-Hand</a></th>
             </tr>
           </thead>
        <!--------------------- Group List ----------------------------->
        <tbody>
        <%for(int j=0; j < iNumOfItm; j++){%>
          <%
             unlocItem.setItemList();
             String sGrp = unlocItem.getGrp();
             String sGrpName = unlocItem.getGrpName();
             String sWhs = unlocItem.getWhs();
             String sDiv = unlocItem.getDiv();
             String sDpt = unlocItem.getDpt();
             String sCls = unlocItem.getCls();
             String sVen = unlocItem.getVen();
             String sSty = unlocItem.getSty();
             String sClr = unlocItem.getClr();
             String sSiz = unlocItem.getSiz();
             String sUpc = unlocItem.getUpc();
             String sDate = unlocItem.getDate();
             String sQin = unlocItem.getQin();
             String sQrm = unlocItem.getQrm();
             String sSku = unlocItem.getSku();
             String sRet = unlocItem.getRet();
             String sCost = unlocItem.getCost();
             String sVenName = unlocItem.getVenName();
             String sBsrLvl = unlocItem.getBsrLvl();
             String sOnHand = unlocItem.getOnHand();
          %>
           <tr class="DataTable1">
             <%if(!sLevel.equals("ITEM")){%>
             <td class="DataTable" nowrap>
                <a class="Small" href="javascript: drillDown('<%=sGrp%>', '<%=sLevel%>')"><%=sGrp%><%=" - " + sGrpName%><%}%></a>
             </td>
             <%if(sLevel.equals("ITEM")){%>
                <td class="DataTable" nowrap><%=sCls + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz %></td>
                <td class="DataTable" nowrap><%=sGrpName%></td>
                <td class="DataTable" nowrap><%=sSku%></td>
                <td class="DataTable" nowrap><%=sVenName%></td>
                <td class="DataTable" nowrap><%=sDate%></td>
             <%}%>

             <th class="DataTable">&nbsp;</th>
             <td class="DataTable1"><%=sQin%></td>
             <td class="DataTable1"><%=sQrm%></td>
             <td class="DataTable1">$<%=sRet%></td>
             <td class="DataTable1">$<%=sCost%></td>
             <td class="DataTable1"><%=sBsrLvl%></td>
             <td class="DataTable1"><%=sOnHand%></td>
        <%}%>
         <!----------------- Table Totals ------------------------>
         <%
           unlocItem.setTotals();
           String sQin = unlocItem.getQin();
           String sQrm = unlocItem.getQrm();
           String sRet = unlocItem.getRet();
           String sCost = unlocItem.getCost();
         %>
         <tr class="DataTable2">
           <td class="DataTable">Total</td>
           <th class="DataTable">&nbsp;</th>
           <td class="DataTable1"><%=sQin%></td>
           <td class="DataTable1"><%=sQrm%></td>
           <td class="DataTable1">$<%=sRet%></td>
           <td class="DataTable1">$<%=sCost%></td>
           <td class="DataTable1">&nbsp;</td>
           <td class="DataTable1">&nbsp;</td>
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
   unlocItem.disconnect();
   unlocItem = null;
%>