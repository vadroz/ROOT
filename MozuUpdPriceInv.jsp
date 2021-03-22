    <%@ page import="java.util.*, java.text.*, com.test.api.MozuUpdPriceInv"%>
<%
   String sSite = request.getParameter("Site");
   
   System.out.println("Start price inventory updates for " + sSite);
   MozuUpdPriceInv volall  = new MozuUpdPriceInv(sSite);
   
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





