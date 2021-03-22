<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*, java.math.BigDecimal"%>
<%
   String sOrd = request.getParameter("Ord");
   String sGrp = request.getParameter("Grp");
   String sGrpNm = request.getParameter("GrpNm");
   String sStr = request.getParameter("Str");

   String sStmt = "select icls, isku, ides, idqt, ivst, vnam"
      + ", (select clnm from IpTsFil.IpClass where icls=ccls) as clnm"
      + ", dec((select sum(sqrm) "
      + "  from IpWmFil.IpStock"
      + " where swhs = 1"
      + " and spnd = 'W' and scls = icls and sven = iven"
      + " and ssty = isty and sclr = iclr and ssiz = isiz),9,0) as sqrm";

   if(sOrd != null)
   {
      sStmt += ", dec((select sum(sdoqty) from Rci.SuOrdd"
         + " where isku=sdsku"
         + " and exists(select 1 from Rci.SuOrdH where sdord=soord and sostr = " + sStr
         + " and sosts in ('Open', 'Allocated', 'Submitted'))"
         + " and sdord <> " + sOrd + "),9,0) as sdoqty";
   }
   else { sStmt += ", 0 as sdoqty"; }

   sStmt += ", isud, irnk"

      + " from IpTsFil.IpItHdr inner join IpTsFil.IpMrVen on iven=vven"
      + " inner join Rci.SuGrpCls on GcGrp = '" + sGrp + "'"
      + " where icls = GcCls"
      + " and ihld <> '9'"
      ;

   sStmt += " order by icls, ides";

   System.out.println(sStmt);

   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   ResultSet rs = runsql.runQuery();
%>

<title>Supply Orders</title>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        th.DataTable { background:#FFCC99;padding-top:3px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:white; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right;}
        td.DataTable2 {padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
</style>
<body>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Supply Item List
        <br><%=sGrpNm%>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <br>
  <!----------------------- Order List ------------------------------>
     <table border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable">
          <th class="DataTable">Short Sku</th>
          <th class="DataTable">ID#</th>
          <th class="DataTable">Description</th>
          <th class="DataTable">In<br>Stock</th>
          <%if(sOrd != null){%>
             <th class="DataTable">On<br>Order</th>
          <%}%>
          <th class="DataTable">U/M</th>
          <th class="DataTable">U/M<br>Qty</th>
          <th class="DataTable">Maximum<br>Order<br>Qty</th>
          <th class="DataTable">Order<br>Qty</th>
<%
   String sSvCls = "";

   while(runsql.readNextRecord())
   {
      String sSku = runsql.getData("isku").trim();
      String sSkuDesc = runsql.getData("ides").trim();
      String sMaxQty = runsql.getData("idqt").trim();
      String sVenSty = runsql.getData("ivst").trim();
      String sVenNm = runsql.getData("vnam").trim();

      BigDecimal bgSqrm = rs.getBigDecimal("sqrm");
      if (bgSqrm == null){ bgSqrm = BigDecimal.valueOf(0) ; }
      String sStock = bgSqrm.toString();

      BigDecimal bgQty = rs.getBigDecimal("sdoqty");
      if (bgQty == null){ bgQty = BigDecimal.valueOf(0) ; }
      String sOnOrd = bgQty.toString();

      String sUnit = runsql.getData("isud").trim();

      BigDecimal bgUmQty = rs.getBigDecimal("irnk");
      if (bgUmQty == null){ bgUmQty = BigDecimal.valueOf(0) ; }
      String sUmQty = bgUmQty.toString();

      String sCls = runsql.getData("icls").trim();
      String sClsNm = runsql.getData("clnm").trim();
    %>
      <%if(!sSvCls.equals(sCls)){%>
         <tr class="DataTable">
            <td class="DataTable2" colspan=9><span style="font-size:12px;font-weight:bold;"><%=sClsNm%></span></td>
         </tr>
         <%sSvCls = sCls;%>
      <%}%>

      <tr class="DataTable">
        <td class="DataTable"><%=sSku%></td>
        <td class="DataTable"><%=sVenSty%></td>
        <td class="DataTable"><%=sSkuDesc%></td>
        <td class="DataTable"><%=sStock%></td>
        <%if(sOrd != null){%>
           <td class="DataTable"><%=sOnOrd%></td>
        <%}%>
        <td class="DataTable">&nbsp;<%=sUnit%></td>
        <td class="DataTable"><%=sUmQty%></td>
        <td class="DataTable"><%=sMaxQty%></td>
        <td class="DataTable">&nbsp;&nbsp;&nbsp;<%if(sStock.equals("0")){%>XXXXXX<%}%>&nbsp;&nbsp;&nbsp;</td>
   <%}%>
        <table>
      </td>
    </tr>
  </table>
</body>














