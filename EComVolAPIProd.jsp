    <%@ page import="java.util.*, java.text.*, ecommerce.EComVolAPIAllProd, ecommerce.EComVolAPIProd, ecommerce.EComVolAPI, ecommerce.EComRtvProdLst"%>
<%
   String sGroup = request.getParameter("Group");
   String sSite = request.getParameter("Site");
   String sCustomerId = request.getParameter("CustomerId");
   String sOrder = request.getParameter("Order");

   //System.out.println(sGroup + "|" + sSite + "|" + sOrder);

   if (sGroup.equals("PAYLOG"))
   {
      EComVolAPI volapi = new EComVolAPI();
      volapi.getByGroup(sGroup, sSite);
      volapi.disconnect();
      volapi = null;
   }
   else if (sGroup.equals("ORDERSNG"))
   {
      EComVolAPI volapi = new EComVolAPI();
      volapi.getSingleOrder(sGroup, sSite, sOrder);
      volapi.disconnect();
      volapi = null;
   }
   else if (sGroup.equals("PROD_CHG"))
   {
      EComRtvProdLst rtvprod = new EComRtvProdLst();
      rtvprod.disconnect();
      rtvprod = null;
   }
   else if (sGroup.indexOf("PROD_AA") >= 0)
   {
      EComVolAPIAllProd volall  = new EComVolAPIAllProd();
      volall.getByGrp(sGroup, sSite);
      volall.disconnect();
      volall = null;
   }
   else if (sCustomerId == null)
   {
      EComVolAPIProd volapi  = new EComVolAPIProd();
      volapi.getByGrp(sGroup, sSite);
      volapi.disconnect();
      volapi = null;
   }
   else
   {
      EComVolAPIProd volapi  = new EComVolAPIProd();
      volapi.getByCustomId(sGroup, sSite, sCustomerId);
      volapi.disconnect();
      volapi = null;
   }
%>
<script language="javascript">
try{
    parent.refresh();
   }
catch(err)
{
   //alert(err)
}
</script>





