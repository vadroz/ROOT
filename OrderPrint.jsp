<%
   String [] sOrder = request.getParameterValues("Ord");

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=OrderPrint.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
%>
<body>
<p align=center>
<b>
   Retail Concepts, Inc
   <br>Patio Furniture Sales:  Print Daily Order List
</b>
<!-------------------------------------------------------------------->
      <!-- iframe  id="frame0"  src=""  frameborder=1  width="100%"></iframe -->
<!-------------------------------------------------------------------->
   <%String sUrl = null;
     for(int i=0; i < sOrder.length; i++){
        sUrl = "OrderEntry.jsp?Order=" + sOrder[i] + "&List=Y&Stock=Y";
   %>
      <br><a href="<%=sUrl%>">Order: <%=sOrder[i]%></a>
   <%}%>
   <br>
   <button onclick="window.print()">Print</button>
</body>
 <%}%>














