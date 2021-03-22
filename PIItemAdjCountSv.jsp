<%@ page import="inventoryreports.PIItemAdjCountSv, java.util.*"%>
<%
    String sCls = request.getParameter("Cls");
    String sVen = request.getParameter("Ven");
    String sSty = request.getParameter("Sty");
    String sClr = request.getParameter("Clr");
    String sSiz = request.getParameter("Siz");
    String sOnHand = request.getParameter("OnHand");
    String sTransit = request.getParameter("Transit");
    String sActOnh = request.getParameter("ActOnh");
    String sAction = request.getParameter("Action");

//-------------- Security ---------------------
if (session.getAttribute("USER")==null)
{
    response.sendRedirect("SignOn1.jsp?TARGET=PIItemAdjCountSv.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    PIItemAdjCountSv picountsv = new PIItemAdjCountSv();
    if(sAction.equals("SAVE"))
    {
       picountsv.saveCount(sCls, sVen, sSty,sClr, sSiz, sOnHand, sTransit, sActOnh, sUser);
    }
    else if(sAction.equals("SEND")) {  picountsv.sendCountByEMail(sUser); }
%>
<script language="JavaScript">
<%if(sAction.equals("SAVE")){%> parent.sendNext(); <%}%>
</script>

<%
picountsv.disconnect();
picountsv = null;
}%>