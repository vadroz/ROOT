<%@ page import="rciutility.RunSQLStmt, supplyorder.SupOrdSave, rciutility.StoreSelect, java.sql.*, java.util.*, java.text.*"%>
<%
   String sSelOrd = request.getParameter("Ord");
   String sSts = request.getParameter("Sts");
   String sStr = request.getParameter("Str");
   String sSku = request.getParameter("Sku");
   String sQty = request.getParameter("Qty");
   String sNext = request.getParameter("Next");

   if(sSku==null){sSku = "0"; }
   if(sQty==null){sQty = "0"; }

   String sAction = request.getParameter("Action");

   String sUser = session.getAttribute("USER").toString();

   SupOrdSave supordsv = new SupOrdSave();
   if(sAction.equals("OPEN_ORD"))
   {
      supordsv.openOrder(sSelOrd, sStr, sSts, sAction, sUser);
      sSelOrd = supordsv.getOrd();
   }

   //System.out.println(sSelOrd + "|" + sSts + sAction + "|" + sUser);

   if(sAction.equals("CHG_ORD_STS"))
   {
      supordsv.openOrder(sSelOrd, "SAME", sSts, sAction, sUser);
      sSelOrd = supordsv.getOrd();
   }

   if(sAction.equals("ADD_SKU") || sAction.equals("DLT_SKU") || sAction.equals("UPD_SKU"))
   {
      supordsv.saveSku(sSelOrd, sSku, sQty, sAction, sUser);
   }

   supordsv.disconnect();
   supordsv = null;
%>
Order = <%=sSelOrd%>
<br>

<SCRIPT language="JavaScript1.2">
  var Action = "<%=sAction%>"

  if(Action == "OPEN_ORD" || Action == "CHG_ORD_STS" || Action == "DLT_SKU" || Action == "UPD_SKU")
  {
     parent.restart("<%=sSelOrd%>");
  }
  else if(Action == "ADD_SKU"){parent.sbmSku("<%=sNext%>")}
</SCRIPT>





