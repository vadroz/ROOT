<%@ page import="java.util.*, java.text.*, java.io.*"%>
<%
   String [] sOrder = request.getParameterValues("Ord");
%>

<html>
<head>

</style>

<SCRIPT language="JavaScript1.2">
var Order = new Array();
 <%for(int i=0; i < sOrder.length; i++){%>Order[<%=i%>] = "<%=sOrder[i]%>";<%}%>
//==============================================================================
// to od on-load
//==============================================================================
function bodyload()
{
   for(var i=0; i < Order.length; i++)
   {
      var frame="frame" + i;
      url = "PfOrderDelivery.jsp?Order=" + Order[i];
      window[frame].location = url;
   }
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<title>PF_Delivery_Tickets</title>

 <body onload="bodyload()">
 <%for(int i=0; i < sOrder.length; i++){%>
    <iframe  id="frame<%=i%>"  src="" frameborder=0 height="100%" width="100%"></iframe>
 <%}%>
 </body>
</html>







