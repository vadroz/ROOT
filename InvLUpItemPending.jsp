<%@ page import="onhand01.InvLUpItemPending , java.util.*"%>
<%
   String sSelSku = request.getParameter("Sku");
   String sSelStr = request.getParameter("Str");


//----------------------------------
// Application Authorization
//----------------------------------
if  (session.getAttribute("USER")!=null && session.getAttribute("TRANSFER")!=null)
{

   InvLUpItemPending itmpend = new InvLUpItemPending(sSelSku, sSelStr);
   String sSku = itmpend.getSku();
   String sStr = itmpend.getStr();
   String sAllTran = itmpend.getAllTran();
   String sAllShip = itmpend.getAllShip();
   int iNumOfDate = itmpend.getNumOfDate();
   String sShipQtyJsa = itmpend.getShipQtyJsa();
   String sShipDateJsa = itmpend.getShipDateJsa();
   String sPick = itmpend.getPick();

   itmpend.disconnect();

%>

<SCRIPT language="JavaScript1.2">
<%if  (session.getAttribute("USER")!=null){%>
var Sku = "<%=sSku%>";
var Str = "<%=sStr%>";
var AllTran = "<%=sAllTran%>";
var AllShip = "<%=sAllShip%>";
var NumOfDate = <%=iNumOfDate%>;
var ShipQty = [<%=sShipQtyJsa%>];
var ShipDate = [<%=sShipDateJsa%>];
var Pick = "<%=sPick%>";
goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack()
{
    //alert(Sku + "\n" + Str + "\n" + AllTran + "\n" + AllShip + "\n" + NumOfDate + "\n" + ShipQty + "\n" + ShipDate)
   parent.showShipped(Sku, Str, AllTran, AllShip, NumOfDate, ShipQty, ShipDate, Pick);
}
<%}}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>
</SCRIPT>







