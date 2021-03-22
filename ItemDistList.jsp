<%@ page import="inventoryreports.ItemDistList, java.util.*"%>
<%
    String sSelStr = request.getParameter("Str");
    String sSelCls = request.getParameter("Cls");
    String sSelVen = request.getParameter("Ven");
    String sSelSty = request.getParameter("Sty");
    String sSelClr = request.getParameter("Clr");
    String sSelSiz = request.getParameter("Siz");


//-------------- Security ---------------------
if (session.getAttribute("USER")==null)
{
    response.sendRedirect("SignOn1.jsp?TARGET=ItemDistList.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    ItemDistList itmpnd = new ItemDistList(sSelStr, sSelCls, sSelVen, sSelSty, sSelClr, sSelSiz, sUser);
    String sIssStr = itmpnd.getIssStr();
    String sDocNum = itmpnd.getDocNum();
    String sQty = itmpnd.getQty();
    itmpnd.disconnect();
%>


<SCRIPT language="JavaScript">
//--------------- Global variables -----------------------
var IssStr = [<%=sIssStr%>];
var DocNum = [<%=sDocNum%>];
var Qty = [<%=sQty%>];

goback();

//==============================================================================
// go back
//==============================================================================
function goback()
{
   parent.showDistroList(IssStr, DocNum, Qty);
}
</script>
<%}%>