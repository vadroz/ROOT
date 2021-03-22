<%@ page import="inventoryreports.ItemPOList, java.util.*"%>
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
    response.sendRedirect("SignOn1.jsp?TARGET=ItemPOList.jsp");
}
else
{    
	String sUser = session.getAttribute("USER").toString();
	//System.out.println(sSelStr + "|" +  sSelCls + "|" +  sSelVen + "|" + sSelSty + "|" + sSelClr + "|" 
	//   + sSelSiz + "|" + sUser);
    ItemPOList itmpol = new ItemPOList(sSelStr, sSelCls, sSelVen, sSelSty, sSelClr, sSelSiz, sUser);
    String sPoNum = itmpol.getPoNum();
    String sAntDate = itmpol.getAntDate();
    String sPoQty = itmpol.getPoQty();
    itmpol.disconnect();
%>


<SCRIPT language="JavaScript">
//--------------- Global variables -----------------------
var PoNum = [<%=sPoNum%>];
var AntDate = [<%=sAntDate%>];
var PoQty = [<%=sPoQty%>];

goback();

//==============================================================================
// go back
//==============================================================================
function goback()
{
   parent.showPOList(PoNum, AntDate, PoQty);
}
</script>
<%}%>