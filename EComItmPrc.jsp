<%@ page import="ecommerce.EComItmPrc , java.util.*"%>
<%
   String sCls = request.getParameter("Cls");
   String sVen = request.getParameter("Ven");
   String sSty = request.getParameter("Sty");
   String sClr = request.getParameter("Clr");
   String sSiz = request.getParameter("Siz");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
    EComItmPrc itmprc = new EComItmPrc(sCls, sVen,  sSty, sClr, sSiz,
                                         session.getAttribute("USER").toString());
    String sItem = itmprc.getItem();
    String sSku = itmprc.getSku();
    String sMap = itmprc.getMap();
    String sMapExpDt = itmprc.getMapExpDt();
    String sIpSug = itmprc.getIpSug();
    String sIpRet = itmprc.getIpRet();
    String sIpS70Prc = itmprc.getIpS70Prc();
    String sIpS70Alt = itmprc.getIpS70Alt();
    String sIpS70AltFrom = itmprc.getIpS70AltFrom();
    String sIpS70AltTo = itmprc.getIpS70AltTo();
    String sIpTmp = itmprc.getIpTmp();
    String sIpTmpFrom = itmprc.getIpTmpFrom();
    String sIpTmpTo = itmprc.getIpTmpTo();
    String sEcMsrp = itmprc.getEcMsrp();
    String sEcRet = itmprc.getEcRet();
    String sEcPrice = itmprc.getEcPrice();
    String sEcSales = itmprc.getEcSales();

    itmprc.disconnect();
    itmprc = null;

%>

<SCRIPT language="JavaScript1.2">

var Item = "<%=sItem%>";
var Sku = "<%=sSku%>";
var Map = "<%=sMap%>";
var MapExpDt = "<%=sMapExpDt%>";
var IpSug = "<%=sIpSug%>";
var IpRet = "<%=sIpRet%>";
var IpS70Prc = "<%=sIpS70Prc%>";
var IpS70Alt = "<%=sIpS70Alt%>";
var IpS70AltFrom = "<%=sIpS70AltFrom%>";
var IpS70AltTo = "<%=sIpS70AltTo%>";
var IpTmp = "<%=sIpTmp%>";
var IpTmpFrom = "<%=sIpTmpFrom%>";
var IpTmpTo = "<%=sIpTmpTo%>";
var EcMsrp = "<%=sEcMsrp%>";
var EcRet = "<%=sEcRet%>";
var EcPrice = "<%=sEcPrice%>";
var EcSales = "<%=sEcSales%>";

goBack();
//==============================================================================
// send employee availability to schedule
//==============================================================================
   function goBack()
   {
      parent.showPrc(Item, Sku, Map, MapExpDt, IpSug, IpRet, IpS70Prc, IpS70Alt, IpS70AltFrom,
                     IpS70AltTo, IpTmp, IpTmpFrom, IpTmpTo, EcMsrp, EcRet, EcPrice, EcSales);
   }

</SCRIPT>
<%}
  else {%>
     alert("Your internet session is expired.\nPlease refresh the screen and enter your ID and pasword.\nThe data you entered was not saved.");
  <%}%>