<%@ page import="ecommerce.EComOrdInfo"%>
<%
    String sSite = request.getParameter("Site");
    String sOrder = request.getParameter("Order");
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null && session.getAttribute("ECOMMERCE")!=null)
{
    String sUser = session.getAttribute("USER").toString();
    EComOrdInfo ordLst = new EComOrdInfo(sSite, sOrder, sUser);
    boolean bOrdFound = ordLst.getOrdFound();
    boolean bAllowCancel = session.getAttribute("ECOMMCNL")!= null;

    String sOrd = ordLst.getOrd();
    String sCust = ordLst.getCust();

    String sBillComp = ordLst.getBillComp();
    String sBillFNam = ordLst.getBillFNam();
    String sBillLNam = ordLst.getBillLNam();
    String sBillAddr1 = ordLst.getBillAddr1();
    String sBillAddr2 = ordLst.getBillAddr2();
    String sBillCity = ordLst.getBillCity();
    String sBillState = ordLst.getBillState();
    String sBillZip = ordLst.getBillZip();
    String sBillCountry = ordLst.getBillCountry();
    String sBillPhn = ordLst.getBillPhn();
    String sBillFax = ordLst.getBillFax();

    String sShipComp = ordLst.getShipComp();
    String sShipFNam = ordLst.getShipFNam();
    String sShipLNam = ordLst.getShipLNam();
    String sShipAddr1 = ordLst.getShipAddr1();
    String sShipAddr2 = ordLst.getShipAddr2();
    String sShipCity = ordLst.getShipCity();
    String sShipState = ordLst.getShipState();
    String sShipZip = ordLst.getShipZip();
    String sShipCountry = ordLst.getShipCountry();
    String sShipPhn = ordLst.getShipPhn();
    String sShipFax = ordLst.getShipFax();

    String sShipMthId = ordLst.getShipMthId();
    String sShipCost = ordLst.getShipCost();
    String sTaxRate = ordLst.getTaxRate();
    String sPayAmt = ordLst.getPayAmt();
    String sPayMth = ordLst.getPayMth();
    String sPayDecline = ordLst.getPayDecline();
    String sCashTender = ordLst.getCashTender();
    String sPoNum = ordLst.getPoNum();
    String sLocked = ordLst.getLocked();
    String sShipped = ordLst.getShipped();
    String sOrdVen = ordLst.getOrdVen();
    String sOrdDate = ordLst.getOrdDate();
    String sShipDate = ordLst.getShipDate();
    String sLstModDate = ordLst.getLstModDate();
    String sStatus = ordLst.getStatus();
    String sTotPayRcv = ordLst.getTotPayRcv();
    String sTotPayAuth = ordLst.getTotPayAuth();
    String sTax = ordLst.getTax();
    String sShipRes = ordLst.getShipRes();
    String sTender = ordLst.getTender();
    String sEmail = ordLst.getEmail();
    String sEmailSubscriber = ordLst.getEmailSubscriber();

    int iNumOfDtl = ordLst.getNumOfDtl();
    int iNumOfCtn = ordLst.getNumOfCtn();
%>

<script language="javascript">
  var Order = "<%=sOrder%>";
  var Site = "<%=sSite%>";
  var Cust = <%=sCust%>;
  var DtlId = new Array();
  var Cls = new Array();
  var Ven = new Array();
  var Sty = new Array();
  var Clr = new Array();
  var Siz = new Array();
  var Sku = new Array();
  var Desc = new Array();
  var Ret = new Array();
  var QtyOnShip = new Array();
  var Upc = new Array();

  <%for(int i=0; i < iNumOfDtl; i++ )
  {
      ordLst.setDetail();
  %>
      DtlId[<%=i%>] = "<%=ordLst.getDtlId()%>";
      Cls[<%=i%>] = "<%=ordLst.getCls()%>";
      Ven[<%=i%>] = "<%=ordLst.getVen()%>";
      Sty[<%=i%>] = "<%=ordLst.getSty()%>";
      Clr[<%=i%>] = "<%=ordLst.getClr()%>";
      Siz[<%=i%>] = "<%=ordLst.getSiz()%>";
      Sku[<%=i%>] = "<%=ordLst.getSku()%>";
      Desc[<%=i%>] = "<%=ordLst.getDesc()%>";
      Ret[<%=i%>] = "<%=ordLst.getRet()%>";
      QtyOnShip[<%=i%>] = "<%=ordLst.getQtyOnShip()%>";
      Upc[<%=i%>] = "<%=ordLst.getUpc()%>";
  <%}%>
  parent.setOrdInfo(Site, Order, DtlId, Cls, Ven, Sty, Clr, Siz, Sku, Desc, QtyOnShip, Upc, Ret);
</script>

<%     ordLst.disconnect();
    } else {%>
<script language="javascript">
  alert("Your session is expired or you are not authorized touse this page.")
</script>
<%}%>


