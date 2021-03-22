<%@ page import="ecommerce.EComSndCustOrd"%>
<%
   String sOrder = request.getParameter("Ord");
   String sFrame = request.getParameter("Frame");
   String sUser = session.getAttribute("ECOMMERCE").toString();
   EComSndCustOrd cstord = new EComSndCustOrd(sOrder, sUser);
   String sDataSet = cstord.getDataSet();
   cstord.disconnect();
%>
<HTML>
<HEAD>
<title>E-Commerce_Send_Customer_Orders</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>
<style>
  body {background:ivory;}
</style>

<script name="javascript1.2">
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
    var html = parent.document.all.spSts.innerHTML
    parent.document.all.spSts.innerHTML = html + " <%=sOrder%>";
    parent.sbmXmlToELab();
    document.SendCstOrd.submit();
}

</script>
<body onload="bodyLoad()">

<form action="http://www.elabs7.com/API/mailing_list.html" method="Post" name="SendCstOrd">
 Type: <input name="type" value="record"><br>
 activity: <input name="activity" value="add"><br>
 Input: <textarea name="input" rows=10 cols=200><%=sDataSet%></textarea>
</form>
</body>



