<%@ page import="patiosales.OrderEntry ,java.util.*, java.text.*"%>
<%
   String sOrder = request.getParameter("Order");
   String sStock = request.getParameter("Stock");
   String sList = request.getParameter("List");
   if (sList==null) sList="N";

   SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
   Calendar cal = Calendar.getInstance();
   //cal.add(Calendar.DATE, 2);
   String sToday = sdf.format(cal.getTime());

   sdf = new SimpleDateFormat("h:mm a");
   String sCurTime = sdf.format(cal.getTime());

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=OrderEntry.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();
      String sEntStore = session.getAttribute("STORE").toString();
      if(sEntStore.trim().equals("ALL")) sEntStore = "Home Office";

      // check if user is authotized to change a status
      boolean bAllowChgSts = false;
      if(session.getAttribute("PATIOSTS")!=null) bAllowChgSts = true;

      OrderEntry ordent = null;
      String sOrdNum = null;
      String sSts = null;
      String sSoSts = null;
      String sStr = null;
      String sCust = null;
      String sSlsper = null;
      String sSlpName = null;
      String sDelDate = null;
      String sShipInstr = null;
      String sLastName = null;
      String sFirstName = null;
      String sAddr1 = null;
      String sAddr2 = null;
      String sCity = null;
      String sState = null;
      String sZip = null;
      String sDayPhn = null;
      String sExtWorkPhn = null;
      String sEvtPhn = null;
      String sCellPhn = null;
      String sEMail = null;
      String sReg = null;
      String sTrans = null;
      String sOrdSubTot = null;
      String sOrdShpPrc = null;
      String sOrdDlvPrc = null;
      String sOrdTax = null;
      String sOrdTotal = null;
      String sOrdPaid = null;
      String sEntUser = null;
      String sEntDate = null;
      String sEntTime = null;

      // items
      int iNumOfItm = 0;
      String [] sSku = null;
      String [] sUpc = null;
      String [] sDesc = null;
      String [] sQty = null;
      String [] sRet = null;
      String [] sTotal = null;
      String [] sSet = null;

      // item str/qty
      String [] sQty55 = null;
      String [] sQty35 = null;
      String [] sQty46 = null;
      String [] sQty50 = null;

      // item set
      int [] iNumOfSet = null;
      String [][] sSetSku = null;
      String [][] sSetUpc = null;
      String [][] sSetDesc = null;
      String [][] sSetQty = null;
      String [][] sSetRet = null;
      String [][] sSetQty55 = null;
      String [][] sSetQty35 = null;
      String [][] sSetQty46 = null;
      String [][] sSetQty50 = null;

      // special order
      int iNumOfSpc = 0;
      String [] sSoVen = null;
      String [] sSoVenName = null;
      String [] sSoVenSty = null;
      String [] sSoDesc = null;
      String [] sSoSku = null;
      String [] sSoQty = null;
      String [] sSoRet = null;
      String [] sSoFrmClr = null;
      String [] sSoFrmMat = null;
      String [] sSoFabClr = null;
      String [] sSoFabNum = null;
      String [] sSoItmSiz = null;
      String [] sSoComment = null;
      String [] sSoPoNum = null;
      String [] sSoTotal = null;

      // items as javascript arrays
      String sSkuJsa = null;
      String sUpcJsa = null;
      String sDescJsa = null;
      String sQtyJsa = null;
      String sRetJsa = null;
      String sTotalJsa = null;
      String sSetJsa = null;
      String sQty55Jsa = null;
      String sQty35Jsa = null;
      String sQty46Jsa = null;
      String sQty50Jsa = null;

      String sSetSkuJsa = null;
      String sSetUpcJsa = null;
      String sSetDescJsa = null;
      String sSetQtyJsa = null;
      String sSetQty55Jsa = null;
      String sSetQty35Jsa = null;
      String sSetQty46Jsa = null;
      String sSetQty50Jsa = null;
      String sSetRetJsa = null;

      String [] sSugPrc = null;
      String sSugPrcJsa = null;

      String sSoVenJsa = null;
      String sSoVenNameJsa = null;
      String sSoVenStyJsa = null;
      String sSoDescJsa = null;
      String sSoSkuJsa = null;
      String sSoQtyJsa = null;
      String sSoRetJsa = null;
      String sSoFrmClrJsa = null;
      String sSoFrmMatJsa = null;
      String sSoFabClrJsa = null;
      String sSoFabNumJsa = null;
      String sSoItmSizJsa = null;
      String sSoCommentJsa = null;
      String sSoPoNumJsa = null;
      String sSoTotalJsa = null;

      // error
      int iNumOfErr = 0;
      String sError = null;

      boolean bExist = false;

      // generate new job number
      if (sOrder.trim().equals("0"))
      {
         ordent = new OrderEntry();
         sOrdNum = ordent.getOrdNum();
      }
      // retreive Order info
      else
      {
         ordent = new OrderEntry(sOrder.trim());
         sOrdNum = ordent.getOrdNum();
         sSts = ordent.getSts();
         sSoSts = ordent.getSoSts();
         sStr = ordent.getStr();
         sCust = ordent.getCust();
         sSlsper = ordent.getSlsper();
         sSlpName = ordent.getSlpName();
         sDelDate = ordent.getDelDate();
         sEntUser = ordent.getEntUser();
         sEntDate = ordent.getEntDate();
         sEntTime = ordent.getEntTime();
         sShipInstr = ordent.getShipInstr();
         sLastName = ordent.getLastName();
         sFirstName = ordent.getFirstName();
         sAddr1 = ordent.getAddr1();
         sAddr2 = ordent.getAddr2();
         sCity = ordent.getCity();
         sState = ordent.getState();
         sZip = ordent.getZip();
         sDayPhn = ordent.getDayPhn();
         sExtWorkPhn = ordent.getExtWorkPhn();
         sEvtPhn = ordent.getEvtPhn();
         sCellPhn = ordent.getCellPhn();
         sEMail = ordent.getEMail();
         sReg = ordent.getReg();
         sTrans = ordent.getTrans();

         sOrdSubTot = ordent.getOrdSubTot();
         sOrdShpPrc = ordent.getOrdShpPrc();
         sOrdDlvPrc = ordent.getOrdDlvPrc();
         sOrdTax = ordent.getOrdTax();
         sOrdTotal = ordent.getOrdTotal();
         sOrdPaid = ordent.getOrdPaid();

         iNumOfErr = ordent.getNumOfErr();
         sError = ordent.getError();
         bExist = true;

         // items
         iNumOfItm = ordent.getNumOfItm();
         sSku = ordent.getSku();
         sUpc = ordent.getUpc();
         sDesc = ordent.getDesc();
         sQty = ordent.getQty();
         sRet = ordent.getRet();
         sTotal = ordent.getTotal();
         sSet = ordent.getSet();

         // item str/qty
         sQty55 = ordent.getQty55();
         sQty35 = ordent.getQty35();
         sQty46 = ordent.getQty46();
         sQty50 = ordent.getQty50();

         // item set
         iNumOfSet = ordent.getNumOfSet();
         sSetSku = ordent.getSetSku();
         sSetUpc = ordent.getSetUpc();
         sSetDesc = ordent.getSetDesc();
         sSetQty = ordent.getSetQty();
         sSetQty55 = ordent.getSetQty55();
         sSetQty35 = ordent.getSetQty35();
         sSetQty46 = ordent.getSetQty46();
         sSetQty50 = ordent.getSetQty50();
         sSetRet = ordent.getSetRet();
         sSugPrc = ordent.getSugPrc();

         // special order
         iNumOfSpc = ordent.getNumOfSpc();
         sSoVen = ordent.getSoVen();
         sSoVenName = ordent.getSoVenName();
         sSoVenSty = ordent.getSoVenSty();
         sSoDesc = ordent.getSoDesc();
         sSoSku = ordent.getSoSku();
         sSoQty = ordent.getSoQty();
         sSoRet = ordent.getSoRet();
         sSoFrmClr = ordent.getSoFrmClr();
         sSoFrmMat = ordent.getSoFrmMat();
         sSoFabClr = ordent.getSoFabClr();
         sSoFabNum = ordent.getSoFabNum();
         sSoItmSiz = ordent.getSoItmSiz();
         sSoComment = ordent.getSoComment();
         sSoPoNum = ordent.getSoPoNum();
         sSoTotal = ordent.getSoTotal();

         // item as js arrays
         sSkuJsa = ordent.getSkuJsa();
         sUpcJsa = ordent.getUpcJsa();
         sDescJsa = ordent.getDescJsa();
         sQtyJsa = ordent.getQtyJsa();
         sRetJsa = ordent.getRetJsa();
         sSugPrcJsa = ordent.getSugPrcJsa();
         sTotalJsa = ordent.getTotalJsa();
         sSetJsa = ordent.getSetJsa();
         sQty55Jsa = ordent.getQty55Jsa();
         sQty35Jsa = ordent.getQty35Jsa();
         sQty46Jsa = ordent.getQty46Jsa();
         sQty50Jsa = ordent.getQty50Jsa();
         sSetSkuJsa = ordent.getSetSkuJsa();
         sSetUpcJsa = ordent.getSetUpcJsa();
         sSetDescJsa = ordent.getSetDescJsa();
         sSetQtyJsa = ordent.getSetQtyJsa();
         sSetQty55Jsa = ordent.getSetQty55Jsa();
         sSetQty35Jsa = ordent.getSetQty35Jsa();
         sSetQty46Jsa = ordent.getSetQty46Jsa();
         sSetQty50Jsa = ordent.getSetQty50Jsa();
         sSetRetJsa = ordent.getSetRetJsa();

         sSoVenJsa = ordent.getSoVenJsa();
         sSoVenNameJsa = ordent.getSoVenNameJsa();
         sSoVenStyJsa = ordent.getSoVenStyJsa();
         sSoDescJsa = ordent.getSoDescJsa();
         sSoSkuJsa = ordent.getSoSkuJsa();
         sSoQtyJsa = ordent.getSoQtyJsa();
         sSoRetJsa = ordent.getSoRetJsa();
         sSoFrmClrJsa = ordent.getSoFrmClrJsa();
         sSoFrmMatJsa = ordent.getSoFrmMatJsa();
         sSoFabClrJsa = ordent.getSoFabClrJsa();
         sSoFabNumJsa = ordent.getSoFabNumJsa();
         sSoItmSizJsa = ordent.getSoItmSizJsa();
         sSoCommentJsa = ordent.getSoCommentJsa();
         sSoPoNumJsa = ordent.getSoPoNumJsa();
         sSoTotalJsa = ordent.getSoTotalJsa();

         // error
         iNumOfErr = ordent.getNumOfErr();
         sError = ordent.getError();
      }

      ordent.disconnect();

      String sShowSts = null;
      if(sSts == null) sShowSts = "New";
      else if(sSts.equals("O")) sShowSts = "Unpaid";
      else if(iNumOfSpc == 0  || sSts.equals("F") && sOrdTotal.equals("sOrdPaid ")) sShowSts = "Paid-in-Full";
      else if(iNumOfSpc > 0 && sSts.equals("F") && !sOrdTotal.equals("sOrdPaid ")) sShowSts = "Partial-Paid";
      else if(sSts.equals("T")) sShowSts = "In-Progress";
      else if(sSts.equals("R")) sShowSts = "Ready-To-Delivery";
      else if(sSts.equals("C")) sShowSts = "Completed";
      else if(sSts.equals("D")) sShowSts = "Canceled";

      // special order status name
      String sShowSoSts = null;
      if(sSoSts == null) sShowSoSts = "None";
      else if(sSoSts.equals("N")) sShowSoSts = "Non-Approved";
      else if(sSoSts.equals("A")) sShowSoSts = "Approved";
      else if(sSoSts.equals("V")) sShowSoSts = "Placed-w/Vendor";
      else if(sSoSts.equals("R")) sShowSoSts = "Receive-@-DC";
%>

<html>
<head>

<style>body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}

        a.Small:link { color:blue; font-size:10px} a.Small:visited { color:blue; font-size:10px}  a.Small:hover { color:blue; font-size:10px}

        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:white;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                        text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                        text-align:center; font-family:Verdanda; font-size:10px }
        th.DataTable21 { padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px;
                        border-bottom: darkred solid 1px;border-right: darkred solid 3px;
                        text-align:center; font-family:Verdanda; font-size:10px }

        tr.DataTable { background:white; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:white; font-family:Arial; font-size:12px; font-weight: bold }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:#FFCC99; font-family:Arial; font-size:10px }
        tr.DataTable5 { background:LemonChiffon; font-family:Arial; font-size:10px }
        tr.Divider { background:black; font-family:Arial; font-size:1px }


        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.DataTable3 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable31 { border-bottom: darkred solid 1px;border-right: darkred solid 3px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable4 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable5 { border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; text-align:left;}

        td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                    border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}

        td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}

        .Small {font-family:Arial; font-size:10px }
        input.Small1 {background:LemonChiffon; font-family:Arial; font-size:10px }
        input {border:none; border-bottom: black solid 1px; font-family:Arial; font-size:12px; font-weight:bold}
        input.radio {border:none; font-family:Arial; font-size:10px }
        input.Menu {border: ridge 2px; background:white; font-family:Arial; font-size:10px }

        textarea {border:none; background:#E7E7E7; border-bottom: black solid 1px; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }
        select.selSts {display:none;font-size:10px; }
        button.selSts {display:none;font-size:10px; }
        input.selSts {display:none;font-size:10px; }

        div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }

@media screen
{
    span.spnAster {color:red;}
   .NonPrt { font-size:10px}
   .PrintOnly {display:none }
}
@media print
{
   span.spnAster {display:none}
   .NonPrt { display:none}
   .PrintOnly {color:black;}
}
</style>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
// orser header info
var Order = "<%=sOrdNum%>";
var Sts = "<%=sSts%>";
var SoSts = "<%=sSoSts%>";
var Str = "<%=sStr%>";
var Cust = "<%=sCust%>";
var Slsper = "<%=sSlsper%>";
var SlpName = "<%=sSlpName%>";
var DelDate = "<%=sDelDate%>";
var ShipInstr = "<%=sShipInstr%>";
var ShpPrc = "<%=sOrdShpPrc%>"
var DlvPrc = "<%=sOrdDlvPrc%>"
var Tax = "<%=sOrdTax%>"
var List = "<%=sList%>"

// customer info
var LastName = "<%=sLastName%>";
var FirstName = "<%=sFirstName%>";
var Addr1 = "<%=sAddr1%>";
var Addr2 = "<%=sAddr2%>";
var City = "<%=sCity%>";
var State = "<%=sState%>";
var Zip = "<%=sZip%>";
var DayPhn = "<%=sDayPhn%>";
var ExtWorkPhn = "<%=sExtWorkPhn%>";
var EvtPhn = "<%=sEvtPhn%>";
var CellPhn = "<%=sCellPhn%>";
var EMail = "<%=sEMail%>";
var Reg = "<%=sReg%>";
var Trans = "<%=sTrans%>";

var Exist = <%=bExist%>;

var NumOfItm = <%=iNumOfItm%>;
var Sku = [<%=sSkuJsa%>];
var Upc = [<%=sUpcJsa%>];
var Desc = [<%=sDescJsa%>];
var SkuQty = [<%=sQtyJsa%>];
var Ret = [<%=sRetJsa%>];
var SugPrc = [<%=sSugPrcJsa%>];
var SkuTotal = [<%=sTotalJsa%>];
var Set = [<%=sSetJsa%>];
var Qty55 = [<%=sQty55Jsa%>];
var Qty35 = [<%=sQty35Jsa%>];
var Qty46 = [<%=sQty46Jsa%>];
var Qty50 = [<%=sQty50Jsa%>];
var UpdSetSku = [<%=sSetSkuJsa%>];
var UpdSetUpc = [<%=sSetUpcJsa%>];
var UpdSetDesc = [<%=sSetDescJsa%>];
var UpdSetQty = [<%=sSetQtyJsa%>];
var UpdSetQty55 = [<%=sSetQty55Jsa%>];
var UpdSetQty35 = [<%=sSetQty35Jsa%>];
var UpdSetQty46 = [<%=sSetQty46Jsa%>];
var UpdSetQty50 = [<%=sSetQty50Jsa%>];
var UpdSetRet = [<%=sSetRetJsa%>];
var Status = "<%=sShowSts%>";

var NumOfSpc = <%=iNumOfSpc%>

var SoVen = [<%=sSoVenJsa%>];
var SoVenName = [<%=sSoVenNameJsa%>];
var SoVenSty = [<%=sSoVenStyJsa%>];
var SoDesc = [<%=sSoDescJsa%>];
var SoSku = [<%=sSoSkuJsa%>];
var SoQty = [<%=sSoQtyJsa%>];
var SoRet = [<%=sSoRetJsa%>];
var SoFrmClr = [<%=sSoFrmClrJsa%>];
var SoFrmMat = [<%=sSoFrmMatJsa%>];
var SoFabClr = [<%=sSoFabClrJsa%>];
var SoFabNum = [<%=sSoFabNumJsa%>];
var SoComment = [<%=sSoCommentJsa%>];
var SoPoNum = [<%=sSoPoNumJsa%>];
var SoItmSiz = [<%=sSoItmSizJsa%>];
var SoTotal = [<%=sSoTotalJsa%>];

var NumOfErr = <%=iNumOfErr%>;
var Error = [<%=sError%>] ;

var NumOfSet=0;
var SetSku = null;
var SetUpc = null;
var SetDesc = null;
var SetQty55 = null;
var SetQty35 = null;
var SetQty46 = null;
var SetQty50 = null;
var SetTot = null;

var SpoVen = new Array();
var SpoVenName = new Array();
var SpoVenAddr1 = new Array();
var SpoVenAddr2 = new Array();
var SpoVenCity = new Array();
var SpoVenState = new Array();
var SpoVenZip = new Array();
var SpoVenPhn = new Array();

var OrdTotal = 0;
var OrdPaid = 0;
<%if(sOrdTotal != null){%>OrdTotal = "<%=sOrdTotal%>"; OrdPaid = "<%=sOrdPaid%>";<%}%>

var NextSts = null;
var NextSoSts = null;
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   // return to selection screen
   if(NumOfErr > 0)
   {
      displayError(Error);
      window.location.href = "OrderEntrySel.jsp";
   }


   setBoxclasses(["BoxName",  "BoxClose"], ["dvStatus"]);
}
//==============================================================================
// set Order/Customer Header Information
//==============================================================================
function setOrderHeader()
{
   document.all.Slsper.value = Slsper;
   document.all.spnSlpName.innerHTML = SlpName;
   document.all.DelDate.value = DelDate;
   document.all.ShpInstr.value = ShipInstr;
   document.all.LastName.value = LastName;
   document.all.FirstName.value = FirstName
   document.all.Addr1.value = Addr1;
   document.all.Addr2.value = Addr2;
   document.all.City.value = City;
   document.all.State.value = State;
   document.all.Zip.value = Zip;
   document.all.DayPhn[0].value = DayPhn.substring(0, 3);
   document.all.DayPhn[1].value = DayPhn.substring(3, 6);
   document.all.DayPhn[2].value = DayPhn.substring(6, 10);
   document.all.ExtWorkPhn.value = ExtWorkPhn;

   document.all.EvtPhn[0].value = EvtPhn.substring(0, 3);
   document.all.EvtPhn[1].value = EvtPhn.substring(3, 6);
   document.all.EvtPhn[2].value = EvtPhn.substring(6, 10);

   document.all.CellPhn[0].value = CellPhn.substring(0, 3);
   document.all.CellPhn[1].value = CellPhn.substring(3, 6);
   document.all.CellPhn[2].value = CellPhn.substring(6, 10)

   document.all.EMail.value = EMail;

   if(Sts == "C" || Sts == "D")
   {
      document.all.Slsper.readOnly = true;
      document.all.DelDate.readOnly = true;
      document.all.ShpInstr.readOnly = true;
      document.all.LastName.readOnly = true;
      document.all.FirstName.readOnly = true;
      document.all.Addr1.readOnly = true;
      document.all.Addr2.readOnly = true;
      document.all.City.readOnly = true;
      document.all.State.readOnly = true;
      document.all.Zip.readOnly = true;
      document.all.DayPhn[0].readOnly = true;
      document.all.DayPhn[1].readOnly = true;
      document.all.DayPhn[2].readOnly = true;
      document.all.ExtWorkPhn.readOnly = true;
      document.all.EvtPhn[0].readOnly = true;
      document.all.EvtPhn[1].readOnly = true;
      document.all.EvtPhn[2].readOnly = true;
      document.all.CellPhn[0].readOnly = true;
      document.all.CellPhn[1].readOnly = true;
      document.all.CellPhn[2].readOnly = true;
      document.all.EMail.readOnly = true;

      document.all.SaveOrder.style.display="none";
      document.all.tdDetail.style.display = "none";
      document.all.tdSpecOrder.style.display = "none";
   }
   else
   {
     if(NumOfItm > 0) document.all.Sku.focus();
     // Make Set Lines hidden
      for(var i=0; i < document.all.trSet.length; i++)
      {
         document.all.trSet[i].style.display="none";
      }
   }
   document.all.tbAddSpcOrd.style.display="none";
}
//==============================================================================
// set Change Order Status button
//==============================================================================
function setChgStatusButton()
{
   var chgsts = document.all.btnChgOrdSts;
   var chgsosts = document.all.btnChgSpcOrdSts;

   // show next status on button,
   if(Sts=="O" && (NumOfSpc == 0 || eval(OrdPaid) > 0 ))
   { chgsts.innerHTML="Confirm Order"; NextSts="F"; chgsts.onclick= function(){ setNewSts();};}
   else { chgsts.style.display="none"; chgsosts.style.display="none" }

   // special order
   if(NumOfSpc > 0 && Sts=="T")
   {
       if(SoSts=="N" || SoSts.trim()=="") { chgsosts.innerHTML="Approved"; NextSoSts="A"; chgsosts.onclick= function(){ sbmNewSoSts();};}
       else if(SoSts=="A") { chgsosts.innerHTML="Placed-w/Vendor"; NextSoSts="V"; chgsosts.onclick= function(){ sbmNewSoSts();};}
       else if(SoSts=="V") { chgsosts.innerHTML="Receive-@-DC"; NextSoSts="R"; chgsosts.onclick= function(){ sbmNewSoSts();};}
       else if(SoSts=="R") { chgsosts.style.display = "none"}
   }
   else {  chgsosts.style.display="none"; }
}

//==============================================================================
// validate Order/Customer Header Information
//==============================================================================
function ValidateHdr()
{
   var slsp = document.all.Slsper.value;
   var deldate = document.all.DelDate.value;
   var str = document.all.Store.value;
   var shpins = document.all.ShpInstr.value;
   var last = document.all.LastName.value;
   var first = document.all.FirstName.value;
   var addr1 = document.all.Addr1.value;
   var addr2 = document.all.Addr2.value;
   var city = document.all.City.value;
   var state = document.all.State.value;
   var zip = document.all.Zip.value;
   var dayphn = cvtPhnNum(document.all.DayPhn);
   var ext = document.all.ExtWorkPhn.value;
   var evtphn = cvtPhnNum(document.all.EvtPhn)
   var cellphn = cvtPhnNum(document.all.CellPhn)
   var email = document.all.EMail.value;

   var msg = "";
   var error = false;

   // check if cashier select Sunday or Saturday. Only manager is allowed to do it
   <%if(sUser.trim().length()==7 && sUser.trim().substring(0, 5).equals("cashr")){%>
   var date = new Date(deldate);
   date.setHours(18)
   var day = date.getDay();
   if (day == 0 || day == 6) { error = true; msg += "Only manager is allowed to use Sunday or Saturday as Delivery Date.\n"}
   <%}%>

   if (slsp.trim() == "" || isNaN(slsp.trim()) || eval(slsp.trim()) <= 0){ error = true; msg += "Invalid Salesperson number.\n"}
   if (str.trim() != "35" && str.trim() != "46" && str.trim() != "50"){ error = true; msg += "Invalid store number.\n"}
   if (last.trim() == "" || first.trim() == ""){ error = true; msg += "Enter last and first name.\n"}
   if (addr1.trim() == "" && addr2.trim() == ""){ error = true; msg += "Enter street address.\n"}
   if (city.trim() == "" || state.trim() == "" || zip.trim() == "") { error = true; msg += "Enter city, state & zip code.\n"}
   if (dayphn.trim() == "" && evtphn.trim() == ""
     && cellphn.trim() == "") { error = true; msg += "Enter phone number(s).\n"}

   if (dayphn.trim() != "" && dayphn.trim().length < 10) { error = true; msg += "Day phone number has less than 10 digits.\n"}
   if (evtphn.trim() != "" && evtphn.trim().length < 10) { error = true; msg += "Evening phone number has less than 10 digits.\n"}
   if (cellphn.trim() != "" && cellphn.trim().length < 10) { error = true; msg += "Cell phone number has less than 10 digits.\n"}


   if(error) alert(msg)
   else saveOrderHdr();
}
//==============================================================================
// convert phone number in 1 string
//==============================================================================
function cvtPhnNum(phnobj)
{
   var phn = phnobj[0].value + phnobj[1].value + phnobj[2].value;
   var phnnospace = "";

   for(var i=0, j=0; i < phn.length; i++)
   {
     if(phn.substring(i, i+1) != " ") { phnnospace += phn.substring(i, i+1); j++ }
   }

   return phnnospace;
}
//==============================================================================
// save Order/Customer Header Information
//==============================================================================
function saveOrderHdr()
{
   var url = "OrderHdrSave.jsp?Order=" + Order
           + "&Slsper=" + document.all.Slsper.value
           + "&DelDate=" + document.all.DelDate.value
           + "&Store=" + document.all.Store.value
           + "&ShpInstr=" + document.all.ShpInstr.value
           + "&LastName=" + document.all.LastName.value.toUpperCase()
           + "&FirstName=" + document.all.FirstName.value.toUpperCase()
           + "&Addr1=" + document.all.Addr1.value.toUpperCase()
           + "&Addr2=" + document.all.Addr2.value.toUpperCase()
           + "&City=" + document.all.City.value.toUpperCase()
           + "&State=" + document.all.State.value.toUpperCase()
           + "&Zip=" + document.all.Zip.value
           + "&DayPhn=" + document.all.DayPhn[0].value + document.all.DayPhn[1].value + document.all.DayPhn[2].value
           + "&EvtPhn=" + document.all.EvtPhn[0].value + document.all.EvtPhn[1].value + document.all.EvtPhn[2].value
           + "&ExtWorkPhn=" + document.all.ExtWorkPhn.value
           + "&CellPhn=" + document.all.CellPhn[0].value + document.all.CellPhn[1].value + document.all.CellPhn[2].value
           + "&EMail=" + document.all.EMail.value

   if(Exist)
   {
     url += "&Cust=" + Cust
          + "&Action=UPD";
   }
   else
   {
      url += "&Cust=0"
      + "&Action=ADD";
   }
   //alert(url)
   //window.location.href=url
   window.frame1.location.href=url
}
//==============================================================================
// Change order status
//==============================================================================
function setNewSts()
{
   var hdr = "Change Order Status";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popStsPanel()
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 200;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 400;
   document.all.dvStatus.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popStsPanel()
{
  var posX = document.documentElement.scrollLeft + 600;
  var posY = document.documentElement.scrollTop + 60;

  var panel = "<table width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr id='trReg'><td class='Prompt'>Register:</td>"
         + "<td class='Prompt'><input class='Small1' name='Reg' size=2 maxsize=2 value='" + Reg + "'></td>"
       + "</tr>"
       + "<tr id='trTrans'><td class='Prompt'>Transaction:</td>"
            + "<td class='Prompt'><input class='Small1' name='Trans' size=5 maxsize=5 value='" + Trans + "'></td>"
       + "</tr>"

      panel += "<tr><td class='Prompt1' colspan='2'><br><br><button onClick='sbmNewSts()' class='Small'>Submit</button>&nbsp;"
      + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

     panel += "</table>";
  return panel;
}
//==============================================================================
// submit new status
//==============================================================================
function sbmNewSts()
{
   var reg = "";
   var trans = "";
   var error = false;
   if (NextSts=="F")
   {
      reg = document.all.Reg.value.trim()
      trans = document.all.Trans.value.trim()
      if(reg=="" || trans=="") { alert("Please populate Register and Transaction."); error=true;}
      else if(isNaN(reg)) { alert("Register must be numeric."); error=true;}
      else if(isNaN(trans)) { alert("Transaction number must be numeric."); error=true;}
   }

   if(!error)
   {
      var url = "OrderHdrSave.jsp?Order=" + Order
              + "&Sts=" + NextSts
              + "&Action=CHGSTS"
      if (NextSts=="F") url += "&Reg=" + reg + "&Trans=" + trans
      //alert(url)
      //window.location.href=url
      window.frame1.location.href=url
      hidePanel();
   }
}

//==============================================================================
// submit new special order status
//==============================================================================
function sbmNewSoSts()
{
   var error = false;

   if(!error)
   {
      var url = "OrderHdrSave.jsp?Order=" + Order
              + "&Sts=" + NextSoSts
              + "&Action=CHGSOSTS"
      //alert(url)
      //window.location.href=url
      window.frame1.location.href=url
      hidePanel();
   }
}
//==============================================================================
// Change Register / Transaction number
//==============================================================================
function setRegTran()
{
   var hdr = "Change Register/Transaction";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popRegTranPanel()
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 200;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 400;
   document.all.dvStatus.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popRegTranPanel()
{
  var posX = document.documentElement.scrollLeft + 600;
  var posY = document.documentElement.scrollTop + 60;

  var panel = "<table width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr id='trReg'><td class='Prompt'>Register:</td>"
         + "<td class='Prompt'><input class='Small1' name='Reg' size=2 maxsize=2 value='" + Reg + "'></td>"
       + "</tr>"
       + "<tr id='trTrans'><td class='Prompt'>Transaction:</td>"
            + "<td class='Prompt'><input class='Small1' name='Trans' size=5 maxsize=5 value='" + Trans + "'></td>"
       + "</tr>"

      panel += "<tr><td class='Prompt1' colspan='2'><br><br><button onClick='sbmRegTran()' class='Small'>Submit</button>&nbsp;"
      + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

     panel += "</table>";
  return panel;
}
//==============================================================================
// submit Reg# / Trans#
//==============================================================================
function sbmRegTran()
{
   var reg = "";
   var trans = "";
   var error = false;

   reg = document.all.Reg.value.trim()
   trans = document.all.Trans.value.trim()
   if(reg=="" || trans=="") { alert("Please populate Register and Transaction."); error=true;}
   else if(isNaN(reg)) { alert("Register must be numeric."); error=true;}
   else if(isNaN(trans)) { alert("Transaction number must be numeric."); error=true;}
   else if(eval(reg) <= 0) { alert("Register must be grater than 0."); error=true;}
   else if(eval(trans) <= 0) { alert("Transaction number must be grater than 0."); error=true;}

   if(!error)
   {
      var url = "OrderHdrSave.jsp?Order=" + Order
              + "&Sts=NOCHG"
              + "&Action=CHGREGTRN"
      url += "&Reg=" + reg + "&Trans=" + trans
      //alert(url)
      //window.location.href=url
      window.frame1.location.href=url
      hidePanel();
   }
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvStatus.innerHTML = " ";
   document.all.dvStatus.style.visibility = "hidden";
}

//==============================================================================
// Change Shipping Price
//==============================================================================
function setShpPrc(shp)
{
   document.all.ShpPrc.style.display="inline";
   document.all.sbmShpPrc.style.display="inline";

   if(shp==1)
   {
      document.all.ShpPrc.value = ShpPrc.trim();
      document.all.sbmShpPrc.innerHTML="Shipping";
      document.all.ShpType.value = "S";
   }
   else if(shp==2)
   {
      document.all.ShpPrc.value = DlvPrc.trim();
      document.all.sbmShpPrc.innerHTML="Delivery";
      document.all.ShpType.value = "D";
   }
   else if(shp==3)
   {
      document.all.ShpPrc.value = Tax.trim();
      document.all.sbmShpPrc.innerHTML="Tax";
      document.all.ShpType.value = "T";
   }
   else if(shp==4)
   {
      document.all.ShpPrc.value = "";
      document.all.sbmShpPrc.innerHTML="Paid";
      document.all.ShpType.value = "P";
   }

   document.all.ShpPrc.select();
   document.all.ShpPrc.focus();
}

//==============================================================================
// save Shipping Price
//==============================================================================
function sbmShpPrc()
{
   var type = document.all.ShpType.value;
   var shpprc = document.all.ShpPrc.value.trim();
   var error = false;

   var tot = OrdTotal;
   // remove coma from total amount
   if(OrdTotal.indexOf(",") >0)
   {
      tot = OrdTotal.substring(0, OrdTotal.indexOf(",")) + OrdTotal.substring(OrdTotal.indexOf(",") + 1 )
   }

   if(shpprc.trim()=="") shpprc = "75";
   else if(isNaN(shpprc.trim())) { alert("Amount is not numreic"); error=true; }
   else if(shpprc < 0 ) { alert("Amount cannot be negative"); error=true; }
   else if(type == "P" && eval(shpprc) > eval(tot) ) { alert("Customer cannot pay more than total price."); error=true; }

   if (!error)
   {
      var url = "OrderHdrSave.jsp?Order=" + Order
           + "&ShpPrc=" + shpprc
      if(type == "S") url += "&Action=SHPPRC";
      else if(type == "D") url += "&Action=DLVPRC";
      else if(type == "T") url += "&Action=OVRTAX";
      else if(type == "P") url += "&Action=PAIDBYCST";

      //alert(url)
      //window.location.href=url
      window.frame1.location.href=url
   }
}
//==============================================================================
// display error
//==============================================================================
function displayError(err)
{
   window.frame1.location.href="";
   window.frame1.close();
   msg = "";
   for(var i=0; i < err.length; i++)  {  msg += err[i] + "\n"; }
   alert(msg);

}
//==============================================================================
// restart application after heading entry
//==============================================================================
function reStart()
{
   var url = "OrderEntry.jsp?Order=" + Order
   window.location.href=url;
}

//==============================================================================
// get item by SKU
//==============================================================================
function getSku(sku, action)
{
   var url = "PsOrdGetItem.jsp?Order=" + Order
   if(action=="ADD") url += "&Sku=" + sku.value + "&Action=" + action
   else url += "&Sku=" + sku + "&Action=" + action
   if(action=="UPD"  || document.all.Sku.value.trim() != "" && !document.all.Sku.readOnly)
   {
      //window.location.href=url
      window.frame1.location.href=url
      document.all.Qty55.select();
   }
}

//==============================================================================
// get item by UPC
//==============================================================================
function getUpc(upc, action)
{
   var url = "PsOrdGetItem.jsp?Order=" + Order + "&Upc=" + upc.value + "&Action=" + action
   if(upc.value.trim() != "" && !document.all.Upc.readOnly)
   {
      //alert(url)
      //window.location.href=url
      window.frame1.location.href=url
      document.all.Qty55.select();
   }
}
//==============================================================================
// check P.O. Number
//==============================================================================
function checkPON(ponum)
{
   var url = "PfsChkPO.jsp?PoNum=" + ponum.value.trim();
   if(ponum.value.trim() != "" && !ponum.readOnly)
   {
      //alert(url)
      //window.location.href=url
      window.frame1.location.href=url
   }
}
//==============================================================================
// populate "Adding line" row.
//==============================================================================
function savePONum()
{
   document.all.thSoChg.style.display="block";
   document.all.tdSoChg.style.display="block"

   document.all.SoDesc.readOnly = true;
   document.all.SoQty.readOnly = true;
   document.all.SoPrice.readOnly = true;
   document.all.SoFrmClr.readOnly = true;
   document.all.SoFrmMat.readOnly = true;
   document.all.SoFabClr.readOnly = true;
   document.all.SoFabNum.readOnly = true;
   document.all.SoComment.readOnly = true;

   window.frame1.close();
}
//==============================================================================
// populate "Adding line" row.
//==============================================================================
function popAddLine(desc, sku, upc, set, price, group, qty55, qty35, qty46, qty50, sugprc, action)
{
   if(action=="ADD")
   {
     document.all.tdDesc.innerHTML = desc;
     document.all.Sku.value = sku;
     document.all.Upc.value = upc;
     document.all.Sku.readOnly = true;
     document.all.Upc.readOnly = true;
     document.all.Price.value = price;
   }
   document.all.tdGroup.innerHTML = group;

   if(set=="0")
   {
      document.all.tdQty55.innerHTML = qty55;
      document.all.tdQty35.innerHTML = qty35;
      document.all.tdQty46.innerHTML = qty46;
      document.all.tdQty50.innerHTML = qty50;
      document.all.SetQty.readOnly = true;
      document.all.Qty55.readOnly = false;
      document.all.Qty35.readOnly = false;
      document.all.Qty46.readOnly = false;
      document.all.Qty50.readOnly = false;
   }
   else
   {
      document.all.SetQty.readOnly = false;
      document.all.Qty55.readOnly = true;
      document.all.Qty35.readOnly = true;
      document.all.Qty46.readOnly = true;
      document.all.Qty50.readOnly = true;
      document.all.SetQty.focus();
   }
   document.all.tdSugPrc.innerHTML = sugprc;
}

//==============================================================================
// populate "Adding line" row.
//==============================================================================
function popAddSetLines(numofset, setdesc, setsku, setupc, setprice, setgroup, setqty55,
                        setqty35, setqty46, setqty50, setsugprc, settot, action)
{
   NumOfSet = numofset;
   SetSku = setsku;
   SetUpc = setupc;
   SetDesc = setdesc;
   SetQty55 = setqty55;
   SetQty35 = setqty35;
   SetQty46 = setqty46;
   SetQty50 = setqty50;
   SetTot = settot;

   for(var i=0; i < numofset; i++)
   {
      if(action=="ADD")
      {
         document.all.trSet[i].style.display="block";
         document.all.tdSetDesc[i].innerHTML = setdesc[i];
         document.all.tdSetSku[i].innerHTML = setsku[i] + " / " + setupc[i];
      }
      document.all.tdSetGroup[i].innerHTML = setgroup[i];
      document.all.tdSetQty55[i].innerHTML = setqty55[i];
      document.all.tdSetQty35[i].innerHTML = setqty35[i];
      document.all.tdSetQty46[i].innerHTML = setqty46[i];
      document.all.tdSetQty50[i].innerHTML = setqty50[i];
      document.all.tdSetTot[i].innerHTML = settot[i];
      // document.all.tdSetPrice[i].innerHTML = setprice[i];
      document.all.tdSetSugPrc[i].innerHTML = setsugprc[i];
   }

   window.frame1.close();
   window.frame1.location.href=null;
}
//==============================================================================
// populate "Adding line" row.
//==============================================================================
function popAddSpecOrd(desc, sku, upc, action)
{
   showSoTbl(true);

   if(action=="ADD")
   {
     document.all.tdSoSku.innerHTML = sku;
     document.all.SoPrice.value = "";
     document.all.SoFrmClr.value = "";
     document.all.SoFrmMat.value = "";
     document.all.SoFabClr.value = "";
     document.all.SoFabNum.value = "";
     document.all.SoComment.value = "";
     document.all.SoPoNum.value = "";
     document.all.SoQty.value = "1";
     document.all.SoVen.select();

     // changes to add item line
     document.all.tdDesc.innerHTML = desc;
     document.all.Sku.value = sku;
     document.all.Upc.value = upc;
     document.all.Sku.readOnly = true;
     document.all.Upc.readOnly = true;
     document.all.SetQty.readOnly = true;
     document.all.Qty55.readOnly = true;
     document.all.Qty35.readOnly = true;
     document.all.Qty46.readOnly = true;
     document.all.Qty50.readOnly = true;
     document.all.Price.readOnly = true;

     document.all.thAdd.style.display = "none";
     document.all.tdAdd.style.display = "none";
   }
   if(SpoVen.length > 0)
   {
     window.frame1.close();
     window.frame1.location.href=null;
     showVenLst();
   }
   else { getVen(); } // get list of vendor for special order
}
//==============================================================================
// get Vendor information
//==============================================================================
function getVen()
{
   var url = "PsOrdGetVen.jsp?"
   //window.location.href=url
   window.frame1.location.href=url
   document.all.SoVenSty.select();
}
//==============================================================================
// populate vendor information
//==============================================================================
function popVenInfo(ven, venname, addr1, addr2, city, state, zip, phone)
{
   SpoVen = ven;
   SpoVenName = venname;
   SpoVenAddr1 = addr1;
   SpoVenAddr2 = addr2;
   SpoVenCity = city;
   SpoVenState = state;
   SpoVenPhn = phone;

   showVenLst();

   window.frame1.close();
   window.frame1.location.href=null;
}
//==============================================================================
// show panel of vendor information
//==============================================================================
function showVenLst()
{
   var hdr = "Vendor List for Special Order";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popVenPanel()
     + "</td></tr>"
   + "</table>"

   document.all.dvStatus.innerHTML = html;
   document.all.dvStatus.style.pixelLeft= document.documentElement.scrollLeft + 200;
   document.all.dvStatus.style.pixelTop= document.documentElement.scrollTop + 135;
   document.all.dvStatus.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popVenPanel()
{
  var posX = document.documentElement.scrollLeft + 600;
  var posY = document.documentElement.scrollTop + 60;

  var panel = "<table class='DataTable' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr class='DataTable4'><th class='DataTable2'>Vendor<br>Number</th>"
        + "<th class='DataTable2'>Vendor<br>Name</th>"
        + "<th class='DataTable2'>Phone Number</th>"
      + "</tr>"
      + "<tr>"
   for(var i=0; i < SpoVen.length; i++)
   {
      panel += "<tr class='DataTable1'>"
             + "<td class='DataTable3'><a href='javascript:setSelVendor(" + i + ")'>" + SpoVen[i] + "</a></td>"
             + "<td class='DataTable3' nowrap>" + SpoVenName[i] + "</td>"
             + "<td class='DataTable3' nowrap>" + SpoVenPhn[i] + "</td>"
            + "</tr>"
   }

   panel += "&nbsp;" + "<tr class='DataTable5'><td class='DataTable2' colspan=3><button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

     panel += "</table>";
  return panel;
}
//==============================================================================
// set selected Vendor
//==============================================================================
function setSelVendor(arg)
{
  document.all.SoVen.value = SpoVen[arg];
  document.all.tdSoVenInfo.innerHTML = SpoVenName[arg];
  hidePanel();
}
//==============================================================================
// process Item: add/update/delete
//==============================================================================
function processLine(action)
{
   var sku = document.all.Sku.value;
   var upc = document.all.Upc.value;

   var desc = document.all.tdDesc.innerHTML;
   var qty55 = document.all.Qty55.value;
   var qty35 = document.all.Qty35.value;
   var qty46 = document.all.Qty46.value;
   var qty50 = document.all.Qty50.value;
   var setqty = document.all.SetQty.value;
   var price = document.all.Price.value;
   var group = document.all.tdGroup.innerHTML;
   var set = NumOfSet > 0;

   // set components
   var setqty55 = new Array(NumOfSet);
   var setqty35 = new Array(NumOfSet);
   var setqty46 = new Array(NumOfSet);
   var setqty50 = new Array(NumOfSet);

   for(var i=0; i < NumOfSet; i++)
   {
      setqty55[i] = document.all.SetQty55[i].value;
      setqty35[i] = document.all.SetQty35[i].value;
      setqty46[i] = document.all.SetQty46[i].value;
      setqty50[i] = document.all.SetQty50[i].value;
   }

   // validate entry - return without adding if any error
   if( Validate(sku, upc, set, qty55, qty35, qty46, qty50, setqty, price, group)
      || (set && ValidateSet(setqty55, setqty35, setqty46, setqty50, setqty)) )
   {  return;  }
   else
   {
      if(isNaN(qty55) || qty55.trim()=="") qty55 = 0;
      if(isNaN(qty35) || qty35.trim()=="") qty35 = 0;
      if(isNaN(qty46) || qty46.trim()=="") qty46 = 0;
      if(isNaN(qty50) || qty50.trim()=="") qty50 = 0;

      var total = (price * (eval(qty55) + eval(qty35) + eval(qty46) + eval(qty50))).toFixed(2)

      // add line to file
      var url= "OrderDtlSave.jsp?Order=<%=sOrdNum%>"
            + "&Sku=" + sku
            + "&Qty55=" + qty55
            + "&Qty35=" + qty35
            + "&Qty46=" + qty46
            + "&Qty50=" + qty50
            + "&SetQty=" + setqty

       if(set) url += "&Set=Y";
       else url += "&Set=N";

       // save component
       for(var i=0; i < NumOfSet; i++)
       {
          url += "&SetSku=" + SetSku[i]
               + "&SetQty55=" + setqty55[i] + "&SetQty35=" + setqty35[i]
               + "&SetQty46=" + setqty46[i] + "&SetQty50=" + setqty50[i]
       }

       url += "&Price=" + price
            + "&Action=" + action

      //alert(url)
      //window.location.href=url
      window.frame1.location.href=url

     // clear line
     clrLine();
  }
}

//==============================================================================
// process Special orders Items
//==============================================================================
function processSoLine(action)
{
   var sku = document.all.tdSoSku.innerHTML;
   var ven = document.all.SoVen.value.replaceSpecChar();
   var vensty = document.all.SoVenSty.value.replaceSpecChar();
   var desc = document.all.SoDesc.value.replaceSpecChar();
   var qty = document.all.SoQty.value;
   var price = document.all.SoPrice.value;
   var frmclr = document.all.SoFrmClr.value.replaceSpecChar();
   var frmmat = document.all.SoFrmMat.value.replaceSpecChar();
   var fabclr = document.all.SoFabClr.value.replaceSpecChar();
   var fabnum = document.all.SoFabNum.value.replaceSpecChar();
   var comment = document.all.SoComment.value.replaceSpecChar();
   var ponum = document.all.SoPoNum.value;

   // validate entry - return without adding if any error
   if( ValidateSpc(sku, ven, vensty, desc, qty, price, frmclr, frmmat, fabclr, fabnum, comment, ponum)) {  return;  }
   else
   {
      // add line to file
      var url= "OrderDtlSave.jsp?Order=<%=sOrdNum%>"
            + "&Ven=" + ven
            + "&VenSty=" + vensty
            + "&Desc=" + desc
            + "&Sku=" + sku
            + "&SetQty=" + qty
            + "&Price=" + price
            + "&FrmClr=" + frmclr
            + "&FrmMat=" + frmmat
            + "&FabClr=" + fabclr
            + "&FabNum=" + fabnum
            + "&Comment=" + comment
            + "&PoNum=" + ponum
            + "&Action=" + action

      //alert(url)
      //window.location.href=url
      window.frame1.location.href=url

     // clear line
     clrLine();
  }
}

//---------------------------------------------------------
// update/detlete Item
//---------------------------------------------------------
function updLine(arg)
{
   clrLine();
   document.all.tdDetail.style.display="block"

   document.all.tdDesc.innerHTML = Desc[arg];
   document.all.Sku.value = Sku[arg];
   document.all.Upc.value = Upc[arg];
   document.all.Sku.readOnly = true;
   document.all.Upc.readOnly = true;

   document.all.Qty55.value = Qty55[arg];
   document.all.Qty35.value = Qty35[arg];
   document.all.Qty46.value = Qty46[arg];
   document.all.Qty50.value = Qty50[arg];
   document.all.SetQty.value = SkuQty[arg]; //total sku quantity

   document.all.Price.value = Ret[arg];

   document.all.thAdd.style.display="none";
   document.all.tdAdd.style.display="none";
   if(Sts == "O")
   {
      document.all.thChg.style.display="block";
      document.all.thApplGrp.style.display="block";
      document.all.thDlt.style.display="block";
      document.all.tdChg.style.display="block";
      document.all.tdApplGrp.style.display="block";
      document.all.tdDlt.style.display="block";
   }
   else
   {
      document.all.thChg.style.display="none";
      document.all.thApplGrp.style.display="none";
      document.all.thDlt.style.display="none";
      document.all.tdChg.style.display="none";
      document.all.tdApplGrp.style.display="none";
      document.all.tdDlt.style.display="none";
   }

   for(var i=0; i < UpdSetSku[arg].length; i++)
   {
      document.all.trSet[i].style.display="block";
      document.all.tdSetDesc[i].innerHTML = UpdSetDesc[arg][i];
      document.all.tdSetSku[i].innerHTML = UpdSetSku[arg][i] + " / " + UpdSetUpc[arg][i];
      document.all.SetQty55[i].value = UpdSetQty55[arg][i];
      document.all.SetQty35[i].value = UpdSetQty35[arg][i];
      document.all.SetQty46[i].value = UpdSetQty46[arg][i];
      document.all.SetQty50[i].value = UpdSetQty50[arg][i];
   }

   getSku(Sku[arg], "UPD");
}
//---------------------------------------------------------
// update/detlete Special Order Items
//---------------------------------------------------------
function updSoLine(arg)
{
   clrLine();
   document.all.tdSpecOrder.style.display="block"
   showSoTbl(true);

   document.all.tdSoSku.innerHTML = SoSku[arg];
   document.all.SoVen.value = SoVen[arg];
   document.all.tdSoVenInfo.innerHTML = SoVenName[arg];
   document.all.SoVenSty.value = SoVenSty[arg];
   document.all.SoVen.readOnly = true;
   if(Sts != "O") document.all.SoVenSty.readOnly = true;
   document.all.SoDesc.value = SoDesc[arg];
   document.all.SoQty.value = SoQty[arg];
   document.all.SoPrice.value = SoRet[arg];
   document.all.SoFrmClr.value = SoFrmClr[arg];
   document.all.SoFrmMat.value = SoFrmMat[arg];
   document.all.SoFabClr.value = SoFabClr[arg];
   document.all.SoFabNum.value = SoFabNum[arg];
   document.all.SoComment.value = SoComment[arg];
   document.all.SoPoNum.value = SoPoNum[arg];

   document.all.thSoAdd.style.display="none";
   document.all.tdSoAdd.style.display="none";

   if(Sts == "O" || Sts == "F" || Sts == "T")
   {
      document.all.thSoChg.style.display="block";
      document.all.tdSoChg.style.display="block";
   }
   else
   {
      document.all.tdSoChg.style.display="none";
      document.all.thSoChg.style.display="none";
   }

   if(Sts == "O")
   {
      document.all.thSoDlt.style.display="block";
      document.all.tdSoDlt.style.display="block";
   }
   else
   {
      document.all.tdSoDlt.style.display="none";
      document.all.thSoDlt.style.display="none";
      document.all.SoVenSty.readOnly = true;
      document.all.SoDesc.readOnly = true;
      document.all.SoQty.readOnly = true;
      document.all.SoPrice.readOnly = true;
      document.all.SoFrmClr.readOnly = true;
      document.all.SoFrmMat.readOnly = true;
      document.all.SoFabClr.readOnly = true;
      document.all.SoFabNum.readOnly = true;
      document.all.SoComment.readOnly = true;
   }
}
//---------------------------------------------------------
// validate line entry
//---------------------------------------------------------
function Validate(sku, upc, set, qty55, qty35, qty46, qty50, setqty, price, group)
{
   var error = false;
   var msg = "";
   if(sku.trim()=="")
   {
      msg += "Sku is not entered.\n";
      document.all.Sku.select();
      error = true;
   }

   // check entered quantity
   if(isNaN(qty55))
   {
      msg += "Quantity for store 55 is not numeric.\n";
      document.all.Qty55.select();
      error = true;
   }
   // check entered quantity
   if(isNaN(qty35))
   {
      msg += "Quantity for store 35 is not numeric.\n";
      document.all.Qty35.select();
      error = true;
   }
   // check entered quantity
   if(isNaN(qty46))
   {
      msg += "Quantity for store 46 is not numeric.\n";
      document.all.Qty46.select();
      error = true;
   }
   // check entered quantity
   if(isNaN(qty50))
   {
      msg += "Quantity for store 50 is not numeric.\n";
      document.all.Qty50.select();
      error = true;
   }
   // check entered quantity
   if(isNaN(setqty))
   {
      msg += "Quantity for set is not numeric.\n";
      document.all.SetQty.select();
      error = true;
   }
   // check entered quantity
   if(isNaN(price))
   {
      msg += "Price is not numeric.\n";
      document.all.Price.select();
      error = true;
   }

   // check entered quantity
   if(!error && !set && (qty55 + qty35 + qty46 + qty50) <=0 )
   {
      msg += "You must select at least 1 item.\n";
      error = true;
   }
   else if(!error && set && setqty <=0 )
   {
      msg += "You must select at least 1 set.\n";
      error = true;
   }

   if (error) alert(msg);
   return error;
}
//---------------------------------------------------------
// validate line entry
//---------------------------------------------------------
function ValidateSet(setqty55, setqty35, setqty46, setqty50, setqty)
{
   var error = false;
   var errors = new Array(10);
   var msg = "";
   var sumqty = new Array(NumOfSet);

   for(var i=0; i < NumOfSet; i++)
   {
      if(sumqty[i]==null) sumqty[i]=0;
      // check entered quantity
      if(isNaN(setqty55[i]))  { document.all.SetQty55[i].select(); errors[0] = true; }
      else if(setqty55[i].trim() !="" && setqty55[i].trim() !=" ") {sumqty[i] += eval(setqty55[i].trim()); }

      if(isNaN(setqty35[i]))  { document.all.SetQty35[i].select(); errors[1] = true; }
      else if(setqty35[i].trim() !="" && setqty35[i].trim() !=" "){sumqty[i] += eval(setqty35[i].trim()) }

      if(isNaN(setqty46[i]))  { document.all.SetQty46[i].select(); errors[2] = true; }
      else if(setqty46[i].trim() !="" && setqty46[i].trim() !=" "){sumqty[i] += eval(setqty46[i].trim()) }

      if(isNaN(setqty50[i]))  { document.all.SetQty50[i].select(); errors[3] = true; }
      else if(setqty50[i].trim() !="" && setqty50[i].trim() !=" "){sumqty[i] += eval(setqty50[i].trim()) }
   }

   if (errors[0]) { msg += "Quantity for store 55 is not numeric.\n"; error = true; }
   if (errors[1]) { msg += "Quantity for store 35 is not numeric.\n"; error = true; }
   if (errors[2]) { msg += "Quantity for store 46 is not numeric.\n"; error = true; }
   if (errors[3]) { msg += "Quantity for store 50 is not numeric.\n"; error = true; }

   // check if number of required component is equal set quantity
   if(!error)
   {
      for(var i=0; i < NumOfSet; i++)
      {
         if(sumqty[i] != SetTot[i] * setqty)
         {
           msg += "Total number of " + SetSku[i] + " - " + sumqty[i]
                + ", must be " + SetTot[i] * setqty + "\n";
           document.all.tdSetSku[i].style.backgroundColor="yellow";
           error = true;
         }
         else { document.all.tdSetSku[i].style.backgroundColor="#e7e7e7";  }
      }
   }

   if (error) alert(msg);
   return error;
}
//---------------------------------------------------------
// validate line special order item entry
//---------------------------------------------------------
function ValidateSpc(sku, ven, vensty, desc, qty, price, frmclr, frmmat, fabclr, fabnum, comment, ponum)
{
   var error = false;
   var msg = "";
   if(sku.trim()=="")
   {
      msg += "Sku is not entered.\n";
      error = true;
   }
   if(ven.trim()=="")
   {
      msg += "Vendor is not entered.\n";
      document.all.SoVen.select();
      error = true;
   }
   if(vensty.trim()=="")
   {
      msg += "Vendor Style is not entered.\n";
      document.all.SoVenSty.select();
      error = true;
   }
   if(desc.trim()=="")
   {
      msg += "Description is not entered.\n";
      document.all.SoDesc.select();
      error = true;
   }

   // check entered quantity
   if(isNaN(qty))
   {
      msg += "Quantity is not numeric.\n";
      document.all.SoQty.select();
      error = true;
   }
   // check entered quantity
   if(isNaN(price))
   {
      msg += "Price is not numeric.\n";
      document.all.SoPrice.select();
      error = true;
   }
   // check entered quantity
   if(price.trim()=="")
   {
      msg += "Price is not entered.\n";
      document.all.SoPrice.select();
      error = true;
   }

   // check entered quantity
   if(!error && qty <=0 )
   {
      msg += "You must select at least 1 item.\n";
      error = true;
   }

   if (error) alert(msg);
   return error;
}
//==============================================================================
// clear "Adding line" row.
//==============================================================================
function clrLine()
{
   document.all.tdDesc.innerHTML = "&nbsp;";
   document.all.Sku.value = "";
   document.all.Upc.value = "";
   document.all.Sku.readOnly = false;
   document.all.Upc.readOnly = false;

   document.all.tdQty55.innerHTML = "&nbsp;";
   document.all.Qty55.value = "";
   document.all.tdQty35.innerHTML = "&nbsp;";
   document.all.Qty35.value = "";
   document.all.tdQty46.innerHTML = "&nbsp;";
   document.all.Qty46.value = "";
   document.all.tdQty50.innerHTML = "&nbsp;";
   document.all.Qty50.value = "";
   document.all.SetQty.value = "";
   document.all.Price.value = "";
   document.all.tdGroup.innerHTML = "&nbsp;";

   document.all.thAdd.style.display="block";
   document.all.tdAdd.style.display="block";
   document.all.thChg.style.display="none";
   document.all.thApplGrp.style.display="none";
   document.all.thDlt.style.display="none";
   document.all.tdChg.style.display="none";
   document.all.tdApplGrp.style.display="none";
   document.all.tdDlt.style.display="none";

   document.all.thSoAdd.style.display="block";
   document.all.tdSoAdd.style.display="block";
   document.all.thSoChg.style.display="none";
   document.all.thSoDlt.style.display="none";
   document.all.tdSoChg.style.display="none";
   document.all.tdSoDlt.style.display="none";

   document.all.tdSoSku.innerHTML = "&nbsp;";
   document.all.SoVen.value = "";
   document.all.SoVenSty.value = "";
   document.all.SoDesc.value = "";
   document.all.SoQty.value = "";
   document.all.SoPrice.value = "";
   document.all.SoFrmClr.value = "";
   document.all.SoFrmMat.value = "";
   document.all.SoFabClr.value = "";
   document.all.SoFabNum.value = "";
   document.all.SoComment.value = "";
   document.all.SoPoNum.value = "";

   if(Sts=="O" && NumOfItm > 0) document.all.Sku.focus();
   // Make Set Lines hidden
   for(var i=0; i < document.all.trSet.length; i++)
   {
      document.all.trSet[i].style.display="none";
   }
   showSoTbl(false);

    if(Sts!="O") document.all.tdDetail.style.display="none"
}

//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction)
{
  var button = document.all.DelDate;
  var date = new Date(button.value);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// show spec ord entry table
//==============================================================================
function  showSoTbl(show)
{
   if(show) document.all.tbAddSpcOrd.style.display="block";
   else document.all.tbAddSpcOrd.style.display="none";
}
//==============================================================================
// show Delivery Date Inquery screen
//==============================================================================
function showDelDateInq()
{
   var url = "OrderDelInq.jsp?Date=" + document.all.DelDate.value.trim();
   var WindowName = 'Delivery_Date_Inquiry';
   var WindowOptions = 'resizable=yes , toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,menubar=yes';

  //alert(url);
  window.open(url, WindowName, WindowOptions);

}

//==============================================================================
// apply Group Price
//==============================================================================
function applyGroupPrice()
{
   var group = document.all.tdGroup.innerHTML.trim();
   if (group != "&nbsp;")
   {
      document.all.Price.value = document.all.tdGroup.innerHTML;
   }
}

//==============================================================================
// get Searched Item
//==============================================================================
function getSearchedItem(sku)
{
   document.all.Sku.value = sku;
   document.all.Sku.focus();
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<title>Patio_Furniture_Order_Entry</title>

<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->
    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="left" VALIGN="TOP" nowrap>
         <b><font size="-1">
            Store: <%=sEntStore%><br>
            User: <%=sUser%></font></b>
      </td>

      <td ALIGN="center" VALIGN="TOP"nowrap>
      <b>Ski Chalet
      <br>Patio Furniture Sales Order Entry
      <br>Status: <%=sShowSts%>
      <%if(sSoSts != null && !sSoSts.trim().equals("")){%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         Special Order Status: <%=sShowSoSts%><%}%></b></td>

      <td ALIGN="right" VALIGN="TOP" nowrap>
         <b><font size="-1">Date: <%if(sEntDate == null){%><%=sToday%><%} else  {%><%=sEntDate%><%}%>
         <br>Time: <%if(sEntTime==null){%><%=sCurTime%><%} else {%><%=sEntTime%><%}%></font></b></td>
    </tr>
    <tr class="NonPrt">
      <td ALIGN="left" VALIGN="TOP" colspan="3">
        <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        <a href="OrderEntrySel.jsp"><font color="red" size="-1">Selection</font></a>&#62;This Page.<br>
      </td>
    </tr>
    <tr>
      <td ALIGN="left" VALIGN="TOP"  colspan="3" nowrap>
<!-------------------------------------------------------------------->
<!-- Order Header Information ->
<!-------------------------------------------------------------------->
   <table border=0 cellPadding="0" cellSpacing="0" >
     <tr  class="DataTable">
        <td class="DataTable" nowrap>Order Number <%=sOrdNum%></td>
        <td class="DataTable" nowrap>
            <span class="spnAster">*</span>Salesperson <input type="text" name="Slsper" size=4 maxlength=4 >&nbsp;<span id="spnSlpName"></span>
        </td>
         <td class="DataTable" nowrap><a href="javascript:showDelDateInq();">Delivery Date</a> &nbsp;
              <button class="NonPrt" name="Down" onClick="setDate('DOWN')">&#60;</button></span>
              <input type="text" name="DelDate" readonly size=10 maxlength=10>
              <button class="NonPrt" name="Up" onClick="setDate('UP')">&#62;</button>
              &nbsp;&nbsp;
              <a class="NonPrt" href="javascript:showCalendar(1, null, null, 700, 100, document.all.DelDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>&nbsp;&nbsp;
              <span class="spnAster">*</span>Store <input type="text" name="Store"
                      <%if(bExist){%>readonly value="<%=sStr%>"<%}
                        else if(!sEntStore.equals("Home Office")){%>value="<%=sEntStore%>"<%}%> size=5 maxlength=5>
         </td>
     </tr>
     <tr  class="DataTable">
         <td class="DataTable" nowrap colspan=3>Special Shipping Instruction
                 <input type="text" name="ShpInstr" size=100 maxlength=100></td>
      </tr>
   </table>
 <!----------------------- end of table ------------------------>
     </td>
   </tr>
   <tr>
     <td ALIGN="left" VALIGN="TOP"  colspan="3" nowrap>
  <!----------------------- Customer Data ------------------------------>
     <table border=0 cellPadding="0" cellSpacing="0" id="tbCustInfo">
      <tr  class="DataTable">
        <td class="DataTable" nowrap><span class="spnAster">*</span>Last Name <input type="text" name="LastName" size=50 maxlength=50></td>
        <td class="DataTable" nowrap colspan="2"><span class="spnAster">*</span>First Name <input type="text" name="FirstName" size=50 maxlength=50></td>
      </tr>
      <tr  class="DataTable">
        <td class="DataTable" colspan="3" nowrap>
           <span class="spnAster">*</span>Address <input type="text" name="Addr1" size=75 maxlength=75><br><%for(int n=0; n < 12; n++){%>&nbsp;<%}%>
                   <input type="text" name="Addr2" size=75 maxlength=75>
        </td>
      </tr>
      <tr  class="DataTable">
        <td class="DataTable" nowrap><span class="spnAster">*</span>City <input type="text" name="City" size=50 maxlength=50></td>
        <td class="DataTable" nowrap><span class="spnAster">*</span>State <input type="text" name="State"  size=2 maxlength=2></td>
        <td class="DataTable" nowrap><span class="spnAster">*</span>Zip <input type="text" name="Zip" size=10 maxlength=10></td>
      </tr>
      <tr  class="DataTable">
        <td class="DataTable" nowrap>Daytime Phone x (Ext.)
          (<input type="text" name="DayPhn" size=3 maxlength=3>)
          <input type="text" name="DayPhn" size=3 maxlength=3> -
          <input type="text" name="DayPhn" size=4 maxlength=4>
          x <input type="text" name="ExtWorkPhn" size=5 maxlength=5></td>

        <td class="DataTable" colspan="2" nowrap>Evening Phone
          (<input type="text" name="EvtPhn" size=3 maxlength=3>)
          <input type="text" name="EvtPhn" size=3 maxlength=3> -
          <input type="text" name="EvtPhn" size=4 maxlength=4>
        </td>

      </tr>
      <tr  class="DataTable">
        <td class="DataTable" colspan="3" nowrap>Cell Phone
          (<input type="text" name="CellPhn" size=3 maxlength=3>)
          <input type="text" name="CellPhn" size=3 maxlength=3> -
          <input type="text" name="CellPhn" size=4 maxlength=4>
          &nbsp;&nbsp;&nbsp;
        E-Mail <input type="text" name="EMail" size=65 maxlength=65></td>
      </tr>
   </table><br>
     </td>
  </tr>
  <!----------------------- end of table ------------------------>
   <tr class="NonPrt">
     <td colspan="3"><span class="spnAster">*</span> = Requred Fields<br>
       <button class="Small" id="SaveOrder" onClick="ValidateHdr()">Save Order Header</button>&nbsp;&nbsp;
    </td>
  </tr>

  <!--------------------------------------------------------------------------------->
  <!----------------------- Add/Update/Delete New line ------------------------------>
  <!--------------------------------------------------------------------------------->
  <tr class="NonPrt">
     <td colspan="3" id="tdDetail">

     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbAddLine">

       <tr class="DataTable1"><th class="DataTable2" colspan=17>Order Item Entry<th></tr>
       <tr class="DataTable1">
        <th class="DataTable2" rowspan=2 nowrap>Short Sku / UPC<br>
             <a target="_blank" class="Small" href="UpcSearch.jsp">Search Items</a><br>
        </th>
        <th class="DataTable21" rowspan=2 nowrap>Description</th>
        <th class="DataTable21" colspan=2 id="thStr55" nowrap>Store 55</th>
        <th class="DataTable21" colspan=2 id="thStr55" nowrap>Store 35</th>
        <th class="DataTable21" colspan=2 id="thStr55" nowrap>Store 46</th>
        <th class="DataTable21" colspan=2 id="thStr55" nowrap>Store 50</th>
        <th class="DataTable2" rowspan=2 id="thSetTot" nowrap>Complete<br>Set <br>Quantity</th>

        <th class="DataTable2" rowspan=2 nowrap>Price</th>
        <th class="DataTable2" rowspan=2 nowrap>Group</th>
        <th class="DataTable2" rowspan=2 nowrap>MSRP</th>

        <th class="DataTable2" rowspan=2 id="thAdd" nowrap>A<br>d<br>d</th>
        <th class="DataTable2" rowspan=2 id="thChg" nowrap>U<br>p<br>d</th>
        <th class="DataTable2" rowspan=2 id="thApplGrp" nowrap>G<br>r<br>p</th>
        <th class="DataTable2" rowspan=2 nowrap>C<br>x<br>l</th>
        <th class="DataTable2" rowspan=2 id="thDlt"nowrap>D<br>l<br>t</th>

       </tr>
       <tr class="DataTable1">
        <th class="DataTable2" id="thStr55" nowrap>Inv</th>
        <th class="DataTable21" id="thRcv55" nowrap>Order<br>Quantity</th>
        <th class="DataTable2" id="thStr35" nowrap>Inv</th>
        <th class="DataTable21" id="thRcv35"nowrap>Order<br>Quantity</th>
        <th class="DataTable2" id="thStr46" nowrap>Inv</th>
        <th class="DataTable21" id="thRcv46"nowrap>Order<br>Quantity</th>
        <th class="DataTable2" id="thStr50" nowrap>Inv</th>
        <th class="DataTable21" id="thRcv50" nowrap>Order<br>Quantity</th>
      </tr>

      <tr  class="DataTable3">
        <td class="DataTable5" nowrap>
           <input class="Small" type="text" name="Sku" onBlur="getSku(this, 'ADD')" size=10 maxlength=10> /
           <input class="Small" type="text" name="Upc" onBlur="getUpc(this, 'ADD')" size=12 maxlength=12><br>
        </td>
        <td class="DataTable31" id="tdDesc" nowrap>&nbsp;</td>
        <td class="DataTable3" id="tdQty55" nowrap>&nbsp;</td>
        <td class="DataTable31" nowrap><input type="text" name="Qty55" size=5 maxlength=5></td>
        <td class="DataTable3" id="tdQty35" nowrap>&nbsp;</td>
        <td class="DataTable31" nowrap><input type="text" name="Qty35" size=5 maxlength=5></td>
        <td class="DataTable3" id="tdQty46" nowrap>&nbsp;</td>
        <td class="DataTable31" nowrap><input type="text" name="Qty46" size=5 maxlength=5></td>
        <td class="DataTable3" id="tdQty50" nowrap>&nbsp;</td>
        <td class="DataTable31" nowrap><input type="text" name="Qty50" size=5 maxlength=5></td>
        <td class="DataTable3" nowrap><input type="text" name="SetQty" size=5 maxlength=5></td>
        <td class="DataTable3" id="tdPrice" nowrap><input type="text" name="Price" size=10 maxlength=10></td>
        <td class="DataTable3" id="tdGroup" nowrap>&nbsp;</td>
        <td class="DataTable3" id="tdSugPrc" nowrap>&nbsp;</td>
        <td class="DataTable3" id="tdAdd" nowrap><a href="javascript: processLine('ADD')">A</a></td>
        <td class="DataTable3" id="tdChg" nowrap><a href="javascript: processLine('UPD')">U</a></td>
        <td class="DataTable3" id="tdApplGrp" nowrap><a href="javascript: applyGroupPrice()">G</a></td>
        <td class="DataTable3" nowrap><a href="javascript:clrLine()">C</a></td>
        <td class="DataTable3" id="tdDlt" nowrap><a href="javascript: processLine('DLT')">D</a></td>
      </tr>
      <!-- --------------------- New Set Components ------------------------ -->
      <%for(int i=0; i < 20; i++) {%>
         <tr  class="DataTable1" id="trSet">
           <td class="DataTable3" id="tdSetSku" nowrap>&nbsp;</td>
           <td class="DataTable31" id="tdSetDesc" nowrap>&nbsp;</td>
           <td class="DataTable3" id="tdSetQty55" nowrap>&nbsp;</td>
           <td class="DataTable31" nowrap><input type="text" name="SetQty55" size=5 maxlength=5></td>
           <td class="DataTable3" id="tdSetQty35" nowrap>&nbsp;</td>
           <td class="DataTable31" nowrap><input type="text" name="SetQty35" size=5 maxlength=5></td>
           <td class="DataTable3" id="tdSetQty46" nowrap>&nbsp;</td>
           <td class="DataTable31" nowrap><input type="text" name="SetQty46" size=5 maxlength=5></td>
           <td class="DataTable3" id="tdSetQty50" nowrap>&nbsp;</td>
           <td class="DataTable31" nowrap><input type="text" name="SetQty50" size=5 maxlength=5></td>
           <td class="DataTable3" id="tdSetTot" nowrap>&nbsp;</td>
           <td class="DataTable3" id="tdSetPrice" nowrap>&nbsp;</td>
           <td class="DataTable3" id="tdSetGroup" nowrap>&nbsp;</td>
           <td class="DataTable3" id="tdSetSugPrc" nowrap>&nbsp;</td>
           <td class="DataTable3" colspan=4 nowrap>&nbsp;</td>
         </tr>
      <%}%>
      <!-- ------------------- End of Set Components ----------------------- -->
    </table>
    </td>
  </tr>
  <!--------------------------------------------------------------------------->
  <!------------------- Add/Update/Delete Special Order ----------------------->
  <!--------------------------------------------------------------------------->
  <tr class="NonPrt">
   <td colspan="3" id="tdSpecOrder"> Test
   </td>
  </tr>
  <!----------------------- end of table ------------------------>
  <!----------------------- Already Entered Items ------------------------------>
  <tr>
     <td colspan="3"  id="tdEntItems">
    <br><span style="font-size:11px; font-weight:bold">Reg / Trans#: <%=sReg%> / <%=sTrans%></span>
    <%if(iNumOfItm > 0) {%>
     <table border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable"><th class="DataTable" colspan=7>Order Details<th></tr>
       <tr  class="DataTable">
        <th class="DataTable" nowrap>Short Sku</th>
        <th class="DataTable" nowrap>UPC</th>
        <th class="DataTable" nowrap>Description</th>
        <th class="DataTable" nowrap>Price</th>
        <th class="DataTable" nowrap>MSRP</th>
        <th class="DataTable" nowrap>Total<br>Qty</th>
        <th class="DataTable" nowrap>Total<br>Price</th>
      </tr>
      <TBODY>

      <!----------------------- Items ------------------------>
      <%for(int i=0; i < iNumOfItm; i++) {%>
          <tr  class="DataTable">
            <td class="DataTable2">
              <a href="javascript:updLine(<%=i%>)"><%=sSku[i]%></a>
              <%if(sSet[i].equals("1")){%><font color="darkbrown">(Set)</font><%}%>
            </td>
            <td class="DataTable2"><%=sUpc[i]%></td>
            <td class="DataTable"><%=sDesc[i]%></td>
            <td class="DataTable1">$<%=sRet[i]%></td>
            <td class="DataTable1">$<%=sSugPrc[i]%></td>
            <td class="DataTable1"><%=sQty[i]%></td>
            <td class="DataTable1">$<%=sTotal[i]%></td>
          </tr>
          <%if(sStock != null && iNumOfSet[i] == 0){%>
            <tr  class="DataTable">
               <td class="DataTable2">Store 55: <%=sQty55[i]%></td>
               <td class="DataTable2">Store 35: <%=sQty35[i]%></td>
               <td class="DataTable2">Store 46: <%=sQty46[i]%></td>
               <td class="DataTable2">Store 50: <%=sQty50[i]%></td>
               <td class="DataTable2" colspan="3">&nbsp;</td>
            </tr>
          <%}%>
          <%if(iNumOfSet[i] > 0 && sList.equals("Y")) { %>
              <%for(int j=0; j < iNumOfSet[i]; j++) {%>
                 <tr  class="DataTable1">
                   <td class="DataTable2"><%=sSetSku[i][j]%></td>
                   <td class="DataTable2"><%=sSetUpc[i][j]%></td>
                   <td class="DataTable"><%=sSetDesc[i][j]%></td>
                   <td class="DataTable1">&nbsp;</td>
                   <td class="DataTable1">&nbsp;</td>
                   <td class="DataTable1"><%=sSetQty[i][j]%></td>
                   <td class="DataTable1">&nbsp;</td>
                 </tr>
                 <%if(sStock != null){%>
                   <tr  class="DataTable">
                     <td class="DataTable2">Store 55: <%=sSetQty55[i][j]%></td>
                     <td class="DataTable2">Store 35: <%=sSetQty35[i][j]%></td>
                     <td class="DataTable2">Store 46: <%=sSetQty46[i][j]%></td>
                     <td class="DataTable2">Store 50: <%=sSetQty50[i][j]%></td>
                     <td class="DataTable2" colspan="3">&nbsp;</td>
            </tr>
          <%}%>
              <%}%>
            <%}%>
      <%}%>
      <!---------------------------------------------------------------------->

      </TBODY>
    </table><br>
   <%}%>
  <!----------------------- end of table ------------------------>

  <!-------------------------- Special Order ---------------------------------->
  <%if(iNumOfSpc > 0){%>
  <table border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbDetail1">
      <tr  class="DataTable">
        <th class="DataTable" nowrap colspan="7">Special Orders</th>
      </tr>
       <tr  class="DataTable">
        <th class="DataTable" nowrap>Vendor</th>
        <th class="DataTable" nowrap>Vendor Style</th>
        <th class="DataTable" nowrap>Description/<br>Frame Color</th>
        <th class="DataTable" nowrap>Short Sku/<br>Frame Material</th>
        <th class="DataTable" nowrap>Price/<br>Fabric Color</th>
        <th class="DataTable" nowrap>Qty/<br>Fabric #</th>
        <th class="DataTable" nowrap>Total<br>Price/<br>Comment</th>
      </tr>
      <%for(int i=0; i < iNumOfSpc; i++) {%>
          <tr  class="DataTable">
            <td class="DataTable2" rowspan=2>
              <a href="javascript:updSoLine(<%=i%>)"><%=sSoVen[i]%></a>
            </td>
            <td class="DataTable2" rowspan=2><%=sSoVenSty[i]%></td>
            <td class="DataTable"><%=sSoDesc[i]%></td>
            <td class="DataTable2"><%=sSoSku[i]%></td>
            <td class="DataTable1">$<%=sSoRet[i]%></td>
            <td class="DataTable1"><%=sSoQty[i]%></td>
            <td class="DataTable1">$<%=sSoTotal[i]%></td>
          </tr>
          <tr  class="DataTable">
            <td class="DataTable"><%=sSoFrmClr[i]%>&nbsp;</td>
            <td class="DataTable"><%=sSoFrmMat[i]%>&nbsp;</td>
            <td class="DataTable"><%=sSoFabClr[i]%>&nbsp;</td>
            <td class="DataTable"><%=sSoFabNum[i]%>&nbsp;</td>
            <td class="DataTable"><%=sSoComment[i]%>&nbsp;</td>
          </tr>
      <%}%>
   </table>
  <%}%>
    </td>
  </tr>

  <!----------------------- Signiture  ------------------------------>
  <tr>
     <td colspan="2"  id="tdSigniture" style="font-size:10px; vertical-align:top">
        Customer Signatures<br>
        <br>Order Confirmation <b><%for(int i=0; i < 40; i++) {%>_<%}%></b>&nbsp;&nbsp;&nbsp;
        Date: <b><%for(int i=0; i < 20; i++) {%>_<%}%></b><br>
        Sign to confirm that you have reviewed the details of this order and the Patio Place Policies.<br><br>

        Delivery Receipt &nbsp;&nbsp;&nbsp;<b><%for(int i=0; i < 40; i++) {%>_<%}%></b>&nbsp;&nbsp;&nbsp;
        Date: <b><%for(int i=0; i < 20; i++) {%>_<%}%></b><br>
        Sign to confirm that you have received and inspected all items on this order.
      </td>
  <!----------------------- Totals  ------------------------------>
     <td id="tdTotals" align=left>
     <%if(bExist) {%>
       <input class="selSts" name="ShpPrc" size="10" maxlength="10">
       <input class="selSts" name="ShpType" type="hidden">
       <button class="selSts" id="sbmShpPrc" onClick="sbmShpPrc()">Shipping</button>
       <table border=0 cellPadding="0" cellSpacing="0" id="tbTotal">
       <tr  class="DataTable2">
         <td class="DataTable1" >Sub-Total</td>
         <td class="DataTable1">$<%=sOrdSubTot%></td>
        </tr>
        <!-- Show shipping price for special order only -->
        <%if(iNumOfSpc > 0) {%>
           <tr  class="DataTable2">
              <td class="DataTable1" >Shipping</td>
              <td class="DataTable1" >
                <%if(sSts.equals("O")) {%><a href="javascript:setShpPrc(1)">$<%=sOrdShpPrc%></a>
                <%} else {%>$<%=sOrdShpPrc%><%}%>
              </td>
           </tr>
        <%}%>
        <tr  class="DataTable2">
           <td class="DataTable1" >Delivery</td>
           <td class="DataTable1" >
              <%if(sSts.equals("O")) {%><a href="javascript:setShpPrc(2)">$<%=sOrdDlvPrc%></a>
              <%} else {%>$<%=sOrdDlvPrc%><%}%>
           </td>
        </tr>
        <tr  class="DataTable2">
           <td class="DataTable1" >Tax</td>
           <td class="DataTable1">
             <%if(sSts.equals("O")) {%><a href="javascript:setShpPrc(3)">$<%=sOrdTax%></a>
             <%} else {%>$<%=sOrdTax%><%}%>
           </td>
        </tr>
        <tr  class="DataTable2">
           <td class="DataTable1" >Total</td>
           <td class="DataTable1">$<%=sOrdTotal%></td>
        </tr>
        <!-- for special order only -->
        <%if(!sSts.equals("R") && !sSts.equals("C") && !sSts.equals("D") && iNumOfSpc > 0) {%>
           <tr  class="DataTable2">
              <td class="DataTable1" >Paid by customer</td>
              <td class="DataTable1">
                <a href="javascript:setShpPrc(4)">$<%=sOrdPaid%></a>
              </td>
           </tr>
        <%}%>
       </table>
     <%}%>
     </td>
    </tr>

    <tr class="NonPrt">
      <td><button class="Small" onclick="window.print()">Print</button></td>
      <td>
          <%if(bExist && !(sUser.trim().length()==7 && sUser.trim().substring(0, 5).equals("cashr")
                           && !sSts.equals("O")) ){%>
             <button class="Small" id="btnChgOrdSts"></button>&nbsp;&nbsp;
             <button class="Small" id="btnChgSpcOrdSts"></button>
          <%}%>
          <%if(!sSts.equals("O")){%>
              <button class="Small" onClick="setRegTran()" id="btnChgRegTran">Change Reg/Trans</button>&nbsp;&nbsp;
          <%}%>
          <button class="Small" id="btnClose"></button>
      </td>
    </tr>
  </table>
<%if(sStock == null) {%>
<div class="PrintOnly" style="width:100%;page-break-before:always">
<b>Patio Place Policies</b>

Returns
<i>In-Store sales</i>: Once your new furniture has been delivered or removed from a Patio Place showroom,
your furniture cannot be returned for a refund, store credit, exchange or otherwise. Please thoroughly examine all items before accepting them.
<i>Special Orders</i>: There can be no changes or cancellations to your special order 3 working days after
the order has been placed with a Patio Place representative. Your order cannot be returned for a refund,
store credit, exchange or otherwise.  Patio Place considers a special order a binding agreement upon
which we make financial commitments.<br><br>

<b>Inspection</b><br>
Patio Place takes great pride in the quality and condition of its products.  Every furniture product is
thoroughly inspected and tested before it is delivered to you or placed in one of our showrooms.
However, oversights can happen. Please inspect all merchandise for scratches, dents, or any other
defects prior to removing it from one of our showrooms. For deliveries, please inspect the merchandise
thoroughly for any of the above defects before the Patio Place delivery personnel leave your home.
If you are unable to be present during delivery and notice any defects, contact your Patio Place
representative the same day as the delivery.<br><br>

<b>Delivery</b><br>
There is a charge for any delivery in the Washington DC Area. For deliveries outside the Washington
DC Area additional charges may apply. If you are having merchandise delivered, you will be contacted
the evening prior to your scheduled delivery day, at which time an approximate delivery time will be
arranged. Please see above for inspection guidelines.<br><br>

<b>Special Orders</b><br>
If you are placing a special order, please realize that it is a <i>custom order, built especially for you</i>.
We will not place an order until 50% of the total order has been paid.  After 3 working days, this payment
is nonrefundable. If the merchandise that arrives from the factory is not the exact size, dimension or
color you expected it to be, it still cannot be returned. Please see above for information on Patio
Place's return policy. Once a special order has been placed with a Patio Place representative there can
be no changes or cancellations. For special orders sent directly to you from the manufacturer
(cushions, umbrellas and accessories only), full payment must be received at the time the order is
placed. Please check your Patio Place invoice with the manufacture’s model name and model number
to make sure we are ordering the exact item you intend. Also, please verify the "ship to" address.<br><br>

The <i>estimated</i> delivery time for your special order of __________________________ is _______
to _______ weeks from the time of purchase.  Patio Place cannot be held responsible for any
manufacturing or shipping delays that may cause the delivery of your merchandise to exceed your
original quote time.<br><br>

<b>Payment</b><br>
Final payment will be due prior to the delivery of your merchandise. Your signature on the front of this
invoice authorizes Patio Place to charge your credit card for any remaining balance remaining on your order.
<div>
<%}%>
 </body>
</html>
<%}%>






