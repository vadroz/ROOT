    <%@ page import="java.util.*, java.text.*, com.test.api.MozuOrders"%>
<%
   String sSite = request.getParameter("Site");
   String sOrder = request.getParameter("Order");
   
   String sFilter = "OrderNumber eq " + sOrder;
     
	MozuOrders morder = new MozuOrders(sSite);	
	System.out.println("Retrieving Orders for Site = " + sSite 
	  + ", \nFilter = " + sFilter + " ==>");
	morder.getOrdersByFilter(sFilter);
	 

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





