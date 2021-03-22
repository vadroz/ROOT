<%@ page import="java.util.*, java.text.*,ecommerce.EComShopOrdReq"%>
<%
      EComShopOrdReq ecshopr = new EComShopOrdReq();
      String sResponse = ecshopr.getResponse();
      ecshopr = null;
      System.out.println("\nThe order request have been sent to Shopotron.");
%>
<html>
<body>
<h2>Get Shopotron Order List</h2>

  <br><h3>The order request have been sent to Shopotron.</h3>
  <br><a href="../" class="small"><font color="red">Home</font></a>

  <br><pre><%="Shopotron response:<br>" + sResponse%></pre></br>

</body>
</html>


