<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*, java.math.BigDecimal"%>
<%
   String sOrd = request.getParameter("Ord");
   String sCls = request.getParameter("Cls");
   String sClsNm = request.getParameter("ClsNm");
   String sStr = request.getParameter("Str");

   String sStmt = "select isku, ides, idqt, ivst, vnam"
      + ", dec((select sum(sqrm) from IpWmFil.IpStock"
      + " where swhs = 1"
      + " and spnd = 'W' and scls = icls and sven = iven"
      + " and ssty = isty and sclr = iclr and ssiz = isiz),9,0) as sqrm"

      + ", dec((select sum(sdoqty) from Rci.SuOrdd"
      + " where isku=sdsku"
      + " and exists(select 1 from Rci.SuOrdH where sdord=soord and sostr = " + sStr
      + " and sosts in ('Open', 'Allocated', 'Submitted'))"
      + " and sdord <> " + sOrd + "),9,0) as sdoqty"
      + ", isud, irnk"

      + " from IpTsFil.IpItHdr inner join IpTsFil.IpMrVen on iven=vven"
      + " where icls = " + sCls
      + " and ihld <> '9'"
      ;

   sStmt += " order by ides";

   //System.out.println(sStmt);

   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   ResultSet rs = runsql.runQuery();

   int j=0;

   String sSkuJsa = "";
   String sSkuDescJsa = "";
   String sStockJsa = "";
   String sOnOrdJsa = "";
   String sMaxQtyJsa = "";
   String sVenStyJsa = "";
   String sVenNmJsa = "";
   String sUnitJsa = "";
   String sUmQtyJsa = "";
   String sComa= "";

   while(runsql.readNextRecord())
   {
      sSkuJsa += sComa + "\"" + runsql.getData("isku").trim() + "\"";
      sSkuDescJsa += sComa + "\"" + runsql.getData("ides").trim() + "\"";
      sMaxQtyJsa += sComa + "\"" + runsql.getData("idqt").trim() + "\"";

      String vst = runsql.getData("ivst").trim();
      vst = vst.replaceAll("\"", "&#34");
      sVenStyJsa += sComa + "\"" + vst + "\"";
      sVenNmJsa += sComa + "\"" + runsql.getData("vnam").trim() + "\"";

      BigDecimal bgSqrm = rs.getBigDecimal("sqrm");
      if (bgSqrm == null){ bgSqrm = BigDecimal.valueOf(0) ; }
      sStockJsa += sComa + "\"" + bgSqrm + "\"";

      BigDecimal bgQty = rs.getBigDecimal("sdoqty");
      if (bgQty == null){ bgQty = BigDecimal.valueOf(0) ; }
      sOnOrdJsa += sComa + "\"" + bgQty + "\"";

      sUnitJsa += sComa + "\"" + runsql.getData("isud").trim() + "\"";

      BigDecimal bgUmQty = rs.getBigDecimal("irnk");
      if (bgUmQty == null){ bgUmQty = BigDecimal.valueOf(0) ; }
      sUmQtyJsa += sComa + "\"" + bgUmQty + "\"";

      j++;
      sComa=",";
   }

%>

<script language="JavaScript1.2">
var Sku = [<%=sSkuJsa%>];
var SkuDesc = [<%=sSkuDescJsa%>];
var MaxQty = [<%=sMaxQtyJsa%>];
var VenSty = [<%=sVenStyJsa%>];
var VenNm = [<%=sVenNmJsa%>];
var Stock = [<%=sStockJsa%>];
var OnOrd = [<%=sOnOrdJsa%>];
var sUnitJsa = [<%=sUnitJsa%>];
var UmQty = [<%=sUmQtyJsa%>];

parent.setSkuLst("<%=sCls%>", "<%=sClsNm%>", Sku, SkuDesc, Stock, OnOrd, MaxQty, VenSty, VenNm, sUnitJsa, UmQty);
</script>















