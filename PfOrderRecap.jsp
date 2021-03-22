<%@ page import="patiosales.OrderEntry, patiosales.PfsOrderComment, java.util.*, java.text.*"%>
<%
   String sOrder = request.getParameter("Order");
   String sStock = request.getParameter("Stock");

   SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
   Calendar cal = Calendar.getInstance();
   //cal.add(Calendar.DATE, 2);
   String sToday = sdf.format(cal.getTime());

   sdf = new SimpleDateFormat("h:mm a");
   String sCurTime = sdf.format(cal.getTime());

      String sUser = session.getAttribute("USER").toString();
      String sEntStore = session.getAttribute("STORE").toString();
      if(sEntStore.trim().equals("ALL")) sEntStore = "Home Office";

      // check if user is authotized to change a status
      boolean bAllowChgSts = false;
      if(session.getAttribute("PATIOSTS")!=null) bAllowChgSts = true;

      OrderEntry ordent = new OrderEntry();

      boolean bExist = false;

      ordent.serOrderInfo(sOrder.trim());
      String sOrdNum = ordent.getOrdNum();
      String sSts = ordent.getSts();
      String sSoSts = ordent.getSoSts();
      String sStr = ordent.getStr();
      String sCust = ordent.getCust();
      String sSlsper = ordent.getSlsper();
      String sSlpName = ordent.getSlpName();
      String sDelDate = ordent.getDelDate();
      String sEntUser = ordent.getEntUser();
      String sEntDate = ordent.getEntDate();
      String sEntTime = ordent.getEntTime();
      String sShipInstr = ordent.getShipInstr();
      String sLastName = ordent.getLastName();
      String sFirstName = ordent.getFirstName();
      String sAddr1 = ordent.getAddr1();
      String sAddr2 = ordent.getAddr2();
      String sCity = ordent.getCity();
      String sState = ordent.getState();
      String sZip = ordent.getZip();
      String sDayPhn = ordent.getDayPhn();
      String sExtWorkPhn = ordent.getExtWorkPhn();
      String sEvtPhn = ordent.getEvtPhn();
      String sCellPhn = ordent.getCellPhn();
      String sEMail = ordent.getEMail();
      String sReg = ordent.getReg();
      String sTrans = ordent.getTrans();

      String sOrdSubTot = ordent.getOrdSubTot();
      String sOrdShpPrc = ordent.getOrdShpPrc();
      String sOrdDscAmt = ordent.getOrdDscAmt();
      String sOrdAfterDsc = ordent.getOrdAfterDsc();
      String sOrdDlvPrc = ordent.getOrdDlvPrc();
      String sOrdTax = ordent.getOrdTax();
      String sOrdTotal = ordent.getOrdTotal();
      String sOrdPaid = ordent.getOrdPaid();

      String sStrAddr1 = ordent.getStrAddr1();
      String sStrAddr2 = ordent.getStrAddr2();
      String sStrCity = ordent.getStrCity();
      String sStrState = ordent.getStrState();
      String sStrZip = ordent.getStrZip();
      String sStrPhn = ordent.getStrPhn();

      int iNumOfErr = ordent.getNumOfErr();
      String sError = ordent.getError();
      bExist = true;

      // items
      int iNumOfItm = ordent.getNumOfItm();
      String [] sSku = ordent.getSku();
      String [] sVenSty = ordent.getVenSty();
      String [] sVen = ordent.getVen();
      String [] sVenName = ordent.getVenName();
      String [] sColor = ordent.getColor();
      String [] sUpc = ordent.getUpc();
      String [] sDesc = ordent.getDesc();
      String [] sQty = ordent.getQty();
      String [] sRet = ordent.getRet();
      String [] sTotal = ordent.getTotal();
      String [] sSet = ordent.getSet();

         // item str/qty
      String [] sQty35 = ordent.getQty35();
      String [] sQty46 = ordent.getQty46();
      String [] sQty50 = ordent.getQty50();
      String [] sQty86 = ordent.getQty86();
      String [] sQty63 = ordent.getQty63();
      String [] sQty64 = ordent.getQty64();
      String [] sQty68 = ordent.getQty68();
      String [] sQty55 = ordent.getQty55();
      String [] sQtyTaken = ordent.getQtyTaken();

      // item set
      int [] iNumOfSet = ordent.getNumOfSet();
      String [][] sSetSku = ordent.getSetSku();
      String [][] sSetVenSty = ordent.getSetVenSty();
      String [][] sSetVen = ordent.getSetVen();
      String [][] sSetVenNm = ordent.getSetVenNm();
      String [][] sSetColor = ordent.getSetColor();
      String [][] sSetUpc = ordent.getSetUpc();
      String [][] sSetDesc = ordent.getSetDesc();
      String [][] sSetQty = ordent.getSetQty();
      String [][] sSetQty35 = ordent.getSetQty35();
      String [][] sSetQty46 = ordent.getSetQty46();
      String [][] sSetQty50 = ordent.getSetQty50();
      String [][] sSetQty86 = ordent.getSetQty86();
      String [][] sSetQty63 = ordent.getSetQty63();
      String [][] sSetQty64 = ordent.getSetQty64();
      String [][] sSetQty68 = ordent.getSetQty68();
      String [][] sSetQty55 = ordent.getSetQty55();
      String [][] sSetRet = ordent.getSetRet();
      String [] sSugPrc = ordent.getSugPrc();
      String [][] sSetQtyTaken = ordent.getSetQtyTaken();

         // special order
      int iNumOfSpc = ordent.getNumOfSpc();
      String [] sSoVen = ordent.getSoVen();
      String [] sSoVenName = ordent.getSoVenName();
      String [] sSoVenSty = ordent.getSoVenSty();
      String [] sSoDesc = ordent.getSoDesc();
      String [] sSoSku = ordent.getSoSku();
      String [] sSoQty = ordent.getSoQty();
      String [] sSoRet = ordent.getSoRet();
      String [] sSoFrmClr = ordent.getSoFrmClr();
      String [] sSoFrmMat = ordent.getSoFrmMat();
      String [] sSoFabClr = ordent.getSoFabClr();
      String [] sSoFabNum = ordent.getSoFabNum();
      String [] sSoItmSiz = ordent.getSoItmSiz();
      String [] sSoComment = ordent.getSoComment();
      String [] sSoPoNum = ordent.getSoPoNum();
      String [] sSoTotal = ordent.getSoTotal();

      // error
      iNumOfErr = ordent.getNumOfErr();
      sError = ordent.getError();

      ordent.disconnect();

      String sShowSts = null;

      if(sSts == null) sShowSts = "New";
      else if(sSts.equals("O")) sShowSts = "Unpaid";
      else if(sSts.equals("Q")) sShowSts = "Quote";
      else if(iNumOfSpc == 0  || sSts.equals("F") && sOrdTotal.equals("sOrdPaid ")) { sShowSts = "Paid-in-Full"; }
      else if(iNumOfSpc > 0 && sSts.equals("F") && !sOrdTotal.equals("sOrdPaid ")) { sShowSts = "Partial-Paid"; }
      else if(sSts.equals("T")) { sShowSts = "In-Progress"; }
      else if(sSts.equals("R")) { sShowSts = "Ready-To-Delivery"; }
      else if(sSts.equals("C")) { sShowSts = "Completed"; }
      else if(sSts.equals("D")) { sShowSts = "Canceled"; }

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
        th.DataTable3 { background:white;padding-top:3px; padding-bottom:3px;
                       text-align:left; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:white; font-family:Arial; font-size:12px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:white; font-family:Arial; font-size:12px; font-weight: bold }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:#FFCC99; font-family:Arial; font-size:10px }
        tr.DataTable5 { background:LemonChiffon; font-family:Arial; font-size:10px }
        tr.DataTable6 { background:LemonChiffon; color:red; font-family:Arial; font-size:12px;
                        font-weight:bold}
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

        textarea.NoBorder {border:none; background:#E7E7E7; border-bottom: black solid 1px; font-family:Arial; font-size:10px }
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
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
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

<body>

    <table border="0" cellPadding="0"  cellSpacing="0" id="tblOrdRecap">
     <!-- ======================= Item List =================================-->
     <%if(iNumOfItm > 0){%>
     <tr class="DataTable">
        <td class="DataTable" nowrap colspan=2>
          <table border=1  cellPadding="0" cellSpacing="0">
            <tr class="DataTable">
             <th class="DataTable">Sold At: <%=sStr%></th>
             <th class="DataTable" colspan=6>Recap of Total Sales Order</th>
           </tr>
           <tr class="DataTable">
             <th class="DataTable">Inv From Str</th>
             <th class="DataTable">SKU</th>
             <th class="DataTable">Description - Style#</th>
             <th class="DataTable">Vendor</th>
             <th class="DataTable">Color</th>
             <th class="DataTable">Taken</th>
             <th class="DataTable">Qty</th>
           </tr>
            <%for(int i=0; i < iNumOfItm; i++) {%>
            <%
               int iStrMax = 0;
               Vector vStr = new Vector();
               Vector vQty = new Vector();
               if (!sQty35[i].equals("0")){ iStrMax++; vStr.add("35"); vQty.add(sQty35[i]); }
               if (!sQty46[i].equals("0")){ iStrMax++; vStr.add("46"); vQty.add(sQty46[i]); }
               if (!sQty50[i].equals("0")){ iStrMax++; vStr.add("50"); vQty.add(sQty50[i]); }
               if (!sQty86[i].equals("0")){ iStrMax++; vStr.add("86"); vQty.add(sQty86[i]); }
               if (!sQty55[i].equals("0")){ iStrMax++; vStr.add("55"); vQty.add(sQty55[i]); }
               if (!sQty63[i].equals("0")){ iStrMax++; vStr.add("63"); vQty.add(sQty63[i]); }
               if (!sQty64[i].equals("0")){ iStrMax++; vStr.add("64"); vQty.add(sQty64[i]); }
               if (!sQty68[i].equals("0")){ iStrMax++; vStr.add("68"); vQty.add(sQty68[i]); }
               if(sSet[i].equals("1")){ iStrMax = 1;}
              %>
              <%for(int k=0; k < iStrMax; k++) {%>
                <tr class="DataTable">
                  <td class="DataTable2">
                     <%if(sSet[i].equals("1")){%>&nbsp;<%} else {%><%=vStr.get(k)%><%}%>
                  </td>

                  <td class="DataTable"> &nbsp; &nbsp; &nbsp; <%=sSku[i]%>
                      <%if(sSet[i].equals("1")){%><font color="darkbrown">(Set)</font><%}%>&nbsp;
                  </td>
                  <td class="DataTable"><%=sDesc[i]%></td>
                  <td class="DataTable"><%=sVenName[i]%></td>
                  <td class="DataTable"><%=sColor[i]%></td>

                  <td class="DataTable1">
                     <%if(!sSet[i].equals("1") && sStr.equals(vStr.get(k))){%><%=sQtyTaken[i]%><%} else {%>&nbsp;<%}%>
                  </td>
                  <td class="DataTable1">
                    <%if(sSet[i].equals("1")){%>&nbsp;<%} else {%><%=vQty.get(k)%><%}%>
                  </td>
                </tr>
              <!-- =====  Set ===== -->
              <%if(iNumOfSet[i] > 0) { %>
                <%for(int j=0; j < iNumOfSet[i]; j++) {%>
                <%
                     int iSetStrMax = 0;
                     Vector vSetStr = new Vector();
                     Vector vSetQty = new Vector();
                     if (!sSetQty35[i][j].equals("0")){ iSetStrMax++; vSetStr.add("35"); vSetQty.add(sSetQty35[i][j]); }
                     if (!sSetQty46[i][j].equals("0")){ iSetStrMax++; vSetStr.add("46"); vSetQty.add(sSetQty46[i][j]); }
                     if (!sSetQty50[i][j].equals("0")){ iSetStrMax++; vSetStr.add("50"); vSetQty.add(sSetQty50[i][j]); }
                     if (!sSetQty86[i][j].equals("0")){ iSetStrMax++; vSetStr.add("86"); vSetQty.add(sSetQty86[i][j]); }
                     if (!sSetQty55[i][j].equals("0")){ iSetStrMax++; vSetStr.add("55"); vSetQty.add(sSetQty55[i][j]); }
                     if (!sSetQty63[i][j].equals("0")){ iSetStrMax++; vSetStr.add("63"); vSetQty.add(sSetQty63[i][j]); }
                     if (!sSetQty64[i][j].equals("0")){ iSetStrMax++; vSetStr.add("64"); vSetQty.add(sSetQty64[i][j]); }
                     if (!sSetQty68[i][j].equals("0")){ iSetStrMax++; vSetStr.add("68"); vSetQty.add(sSetQty68[i][j]); }
                %>
                <%for(int m=0; m < iSetStrMax; m++) {%>
                    <tr  class="DataTable">
                      <td class="DataTable2"> &nbsp; &nbsp; &nbsp; <%=vSetStr.get(m)%></td>
                      <td class="DataTable2"><%=sSetSku[i][j]%></td>
                      <td class="DataTable"> &nbsp; &nbsp; &nbsp; <%=sSetDesc[i][j]%></td>
                      <td class="DataTable"><%=sSetVenNm[i][j]%></td>
                      <td class="DataTable"><%=sSetColor[i][j]%></td>
                      <td class="DataTable1">
                         <%if(sStr.equals(vSetStr.get(m)) && !sSetQtyTaken[i][j].equals("0")){%><%=sSetQtyTaken[i][j]%><%} else {%>&nbsp;<%}%>
                      </td>
                      <td class="DataTable1"><%=vSetQty.get(m)%></td>
                    </tr>
                <%}%>
               <%}%>
              <%}%>
             <%}%>
            <%}%>


          </table>
        <%}%>

        <!-- ================ Special Order ================================ -->
        <%if(iNumOfSpc > 0){%>
     <tr class="DataTable">
        <td class="DataTable" nowrap colspan=2>
          <table border=1  cellPadding="0" cellSpacing="0">
            <tr class="DataTable">
             <th class="DataTable" colspan=5>Recap of Total Sales Order</th>
           </tr>
           <tr class="DataTable">
             <th class="DataTable">Vendor</th>
             <th class="DataTable">Description - Style#</th>
             <th class="DataTable">Frame<br>Color/Cast</th>
             <th class="DataTable">Fabric<br>Color/Cast</th>
             <th class="DataTable">Qty</th>
           </tr>

            <%for(int i=0; i < iNumOfSpc; i++) {%>
                <tr class="DataTable">
                  <td class="DataTable"><%=sSoVenName[i]%></td>
                  <td class="DataTable"><%=sSoDesc[i]%> - <%=sSoVenSty[i]%></td>
                  <td class="DataTable"><%=sSoFrmClr[i]%> / <%=sSoFrmMat[i]%></td>
                  <td class="DataTable"><%=sSoFabClr[i]%> / <%=sSoFabNum[i]%></td>
                  <td class="DataTable"><%=sSoQty[i]%></td>
                </tr>
            <%}%>
          </table>
        <%}%>
        <!-- ================ End of  Special Order ======================== -->
        </td>
     </tr>
   </table>
 </body>
</html>

<%
   ordent.disconnect();
   ordent = null;
%>
<script language="javascript">
  var html = document.all.tblOrdRecap.outerHTML;
  parent.getOrdRecap(html);
</script>






