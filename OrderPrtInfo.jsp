<%@ page import="patiosales.OrderEntry, patiosales.PfsOrderComment, rciutility.FormatNumericValue, java.util.*, java.text.*"%>
<%
   String sOrder = request.getParameter("Order");
   String sStock = request.getParameter("Stock");

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
      String sOrdAssmbPrc = ordent.getOrdAssmbPrc();
      String sAssmb_Delvry = ordent.getAssmb_Delvry();
      String sProtPlan = ordent.getProtPlan();
      String sOrdTax = ordent.getOrdTax();
      String sOrdTotal = ordent.getOrdTotal();
      String sOrdPaid = ordent.getOrdPaid();
      String sOrdMsrp = ordent.getOrdMsrp();
      String sOrdRet = ordent.getOrdRet();
      String sOrdMsrpDsc = ordent.getOrdMsrpDsc();
      String sOrdMsrpDscPrc = ordent.getOrdMsrpDscPrc();
      String sOrdRetDsc = ordent.getOrdRetDsc();
      String sOrdRetDscPrc = ordent.getOrdRetDscPrc();
      
      String sGrpItmDsc = ordent.getGrpItmDsc();
      String sOrdDscPrc = ordent.getOrdDscPrc();
      String sOrdAllDscAmt = sOrdAllDscAmt = ordent.getOrdAllDscAmt(); 
      String sSubAftMD = ordent.getSubAftMD();

      String sStrAddr1 = ordent.getStrAddr1();
      String sStrAddr2 = ordent.getStrAddr2();
      String sStrCity = ordent.getStrCity();
      String sStrState = ordent.getStrState();
      String sStrZip = ordent.getStrZip();
      String sStrPhn = ordent.getStrPhn();
      String sStrPhnFmt = sStrPhn.substring(0,3) + "-" + sStrPhn.substring(3, 6) + "-" + sStrPhn.substring(6); 
      
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

      // item set
      int [] iNumOfSet = ordent.getNumOfSet();
      String [][] sSetSku = ordent.getSetSku();
      String [][] sSetVenSty = ordent.getSetVenSty();
      String [][] sSetColor = ordent.getSetColor();
      String [][] sSetUpc = ordent.getSetUpc();
      String [][] sSetDesc = ordent.getSetDesc();
      String [][] sSetQty = ordent.getSetQty();
      String [][] sSetQty35 = ordent.getSetQty35();
      String [][] sSetQty46 = ordent.getSetQty46();
      String [][] sSetQty50 = ordent.getSetQty50();
      String [][] sSetQty86 = ordent.getSetQty86();
      String [][] sSetRet = ordent.getSetRet();
      String [] sSugPrc = ordent.getSugPrc();
      String [] sClcPrc = ordent.getClcPrc();
      String [][] sSetClcPrc = ordent.getSetClcPrc();


         // special order
      int iNumOfSpc = ordent.getNumOfSpc();
      String [] sSoVen = ordent.getSoVen();
      String [] sSoVenName = ordent.getSoVenName();
      String [] sSoVenSty = ordent.getSoVenSty();
      String [] sSoDesc = ordent.getSoDesc();
      String [] sSoSku = ordent.getSoSku();
      String [] sSoQty = ordent.getSoQty();
      String [] sSoRet = ordent.getSoRet();
      String [] sSoClcPrc = ordent.getSoClcPrc();
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

      // format Numeric value
      FormatNumericValue fmt = new FormatNumericValue();
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
                       
        th.DataTable4 { padding-left:5px; padding-right:5px; text-align:center; 
                        font-family:Verdanda; font-size:12px; text-decoration: underline; }               

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

<SCRIPT language="JavaScript1.2">
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<title>Patio_Furniture_Quote</title>

<body>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frameChkCalendar"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->
    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
       <img src="MainMenu/patio_logos1.jpg" height="50px">       
       <br><b>Patio Furniture - Quote
       </b>
       <br><span style="font-size:11px;"><%=sStrAddr1%>  <%=sStrAddr2%><br>Phone: <%=sStrPhnFmt%></span>

    </tr>
    <tr>
      <td ALIGN="left" VALIGN="TOP"   nowrap>
<!-------------------------------------------------------------------->
<!-- Order Header Information ->
<!-------------------------------------------------------------------->
   <table border=0 width="100%" cellPadding="0" cellSpacing="0" >
     <tr class="DataTable">
        <td class="DataTable" width="90%">
           Quote <b><%=sOrdNum%></b>
        <td class="DataTable" nowrap>
           <%if(sEntDate == null){%><%=sToday%><%} else  {%><%=sEntDate%><%}%>
        </td>
     <tr>

     <tr class="DataTable">
        <td class="DataTable2" nowrap colspan=2>
          This quote will expire at end of business on: <span style="font-size:14px;font-weight:bold"><%=sDelDate%></span>
        </td>
     </tr>

     <tr class="DataTable">
        <td class="DataTable" nowrap colspan=2>
          <table border=0  cellPadding="0" cellSpacing="0" width="100%" style="font-size:12px">
            <tr>
               <td colspan=2><!-- b>Customer Info</b -->
                  <%=sFirstName%> <%=sLastName%>
                  <%if(!sAddr1.equals("")){%><br><%=sAddr1%><%}%>
                  <%if(!sAddr2.equals("")){%><br><%=sAddr2%><%}%>
                  <br><%if(!sCity.equals("")){%><%=sCity%><%}%><%if(!sState.equals("")){%>, <%=sState%><%}%><%if(!sZip.equals("")){%>, <%=sZip%><%}%>
                  <br><%if(sDayPhn.length() > 6){%>
                       <%=sDayPhn.substring(0,3) + "-" + sDayPhn.substring(3, 6) + "-" + sDayPhn.substring(6)%>
                  <%}%> 
                  <%if(!sExtWorkPhn.equals("")){%>Ext:<%}%><%=sExtWorkPhn%> &nbsp; &nbsp; &nbsp;<%=sEMail%>
               </td>
            </tr>
          </table>
        </td>
     </tr>

     <!-- ======================= Item List =================================-->
     <tr class="DataTable">
        <td class="DataTable" nowrap colspan=2>
          <table border=0  cellPadding="0" cellSpacing="0" width="100%" style="border: black solid 1px;font-size:12px">
            <!-- >tr class="DataTable1">
               <th colspan=7>&nbsp;<br>&nbsp;</th>
            </tr -->
            <tr class="DataTable1">
               <th class="DataTable4">Item</th>
               <th class="DataTable4">Inventory</th>
               <%if(iNumOfSpc == 0){%><th class="DataTable4">MSRP</th><%}%>
               <th class="DataTable4">Price</th>
               <th class="DataTable4" nowrap>Net Price<br>w/Disc</th>
               <th class="DataTable4">Qty</th>
               <th class="DataTable4">Extended<br>Price</th>
            </tr>
            
            <tr><td colspan=7 style="border-bottom:black solid 1px;background:#e7e7e7;font-size:1px">&nbsp;</td></tr>

            <%for(int i=0; i < iNumOfItm; i++) {%>
              <tr class="DataTable">
                <td class="DataTable">
                    <%=sDesc[i]%> - <%=sSku[i]%>
                    <%if(sSet[i].equals("1")){%><font color="darkbrown">(Set)</font><%}%>
                    &nbsp;
                </td>
                <td class="DataTable2">In-Stock</td>
                <td class="DataTable1">$<%=fmt.getFormatedNum(sSugPrc[i], "#,###,###")%></td>
                <td class="DataTable1">$<%=fmt.getFormatedNum(sRet[i], "#,###,###")%></td>
                <td class="DataTable1"><b>$<%=fmt.getFormatedNum(sClcPrc[i], "#,###,###")%></b></td>
                <td class="DataTable1"><%=sQty[i]%></td>
                <td class="DataTable1">$<%=sTotal[i] %><!-- %=fmt.getFormatedNum(sTotal[i], "#,###,###")% --></td>
              </tr>
              <!-- =====  Set ===== -->
              <%if(iNumOfSet[i] > 0) { %>
                <%for(int j=0; j < iNumOfSet[i]; j++) {%>
                   <tr  class="DataTable1">
                     <td class="DataTable2"><%=sSetDesc[i][j]%> - <%=sSetSku[i][j]%></td>
                     <td class="DataTable1">&nbsp;</td>
                     <td class="DataTable1">&nbsp;</td>
                     <td class="DataTable1">$<%=fmt.getFormatedNum(sSetClcPrc[i][j], "#,###,###")%></td>
                     <td class="DataTable1">&nbsp;</td>
                     <td class="DataTable1"><%=sSetQty[i][j]%></td>
                     <td class="DataTable1">&nbsp;</td>
                   </tr>
                <%}%>
              <%}%>
            <%}%>
    

            <!-- ====== Special Order ===============-->
            <%if(iNumOfSpc > 0){%>
               <%for(int i=0; i < iNumOfSpc; i++) {%>
                  <tr class="DataTable">
                    <td class="DataTable2"><%=sSoDesc[i]%></td>
                   <td class="DataTable1">Special Order</td>
                   <td class="DataTable1">$<%=fmt.getFormatedNum(sSoRet[i], "#,###,###")%></td>
                   <td class="DataTable1">$<%=fmt.getFormatedNum(sSoClcPrc[i], "#,###,###")%></td>
                   <td class="DataTable1"><%=sSoQty[i]%></td>
                   <td class="DataTable1">$<%=sSoTotal[i]%><!--  >%=fmt.getFormatedNum(sSoTotal[i], "#,###,###")% --></td>
                  </tr>
               <%}%>
          </tr>
            <%}%>

            <%if(iNumOfSpc > 0){%>
             <tr class="DataTable1">
              <td class="DataTable2">Total</td>
              <td class="DataTable2">&nbsp;</td>
              <td class="DataTable2">&nbsp;</td>
              <td class="DataTable2">$<%=sOrdSubTot%></td>
              <td class="DataTable2">&nbsp;</td>
              <td class="DataTable2">$<%=sOrdSubTot%></td>
            </tr>
           <%}%>

          </table>
        </td>
     </tr>
   </table>
 <!----------------------- end of table ------------------------>
     </td>
   </tr>
   <tr>
     <td ALIGN="left" VALIGN="TOP"  colspan="3" nowrap>
  <!----------------------- Customer Data ------------------------------>
     </td>
  </tr>

  <!----------------------- Signature  ------------------------------>
  <tr>
  <!----------------------- Totals  ------------------------------>
     <td id="tdDetail4" align=left>
     <table border=0 width="100%">
       <tr>
         <td id="tdDetail4" align=right nowrap>
          <%if(iNumOfItm > 0) {%>
            <div style="border:1px solid black;font-weight:bold;font-size:12px; background:yellow;width=400px;text-align:left">
              Total MSRP $<%=sOrdMsrp%>, discounted by <%=sOrdMsrpDscPrc%>% saves $<%=sOrdMsrpDsc%>
            </div>
          <%}%>
         </td>
         <td id="tdDetail4" align=right>
     <%if(bExist) {%>
       <table border=0 cellPadding="0" cellSpacing="0" id="tbTotal">
       <tr  class="DataTable2">
         <td class="DataTable1" >Total Price</td>
         <td class="DataTable1" nowrap>$<%=sOrdSubTot%></td>
        </tr>

        <!-- ======== Discount =========== -->
        <%if(iNumOfItm > 0){%>        
          <tr  class="DataTable2">
             <td class="DataTable1" >Multiple Discounts - Calculator</td>
             <td class="DataTable1">&nbsp;<%if(!sGrpItmDsc.trim().equals(".00")){%>$<%=sGrpItmDsc%><%}%></td>
          </tr>
        <%}%>
        
        <tr  class="DataTable2">
         <td class="DataTable1" >Sub-Total</td>
         <td class="DataTable1" nowrap>$<%=sSubAftMD%></td>
        </tr>
        
        
        <tr class="DataTable2">
             <td class="DataTable1" >Single Discount</td>
             <td class="DataTable1">$<%=sOrdDscAmt%></td>             
           </td>
         </tr>
         
          <tr class="DataTable2">
             <td class="DataTable1" >All Discount</td>
             <td class="DataTable1" nowrap><%=sOrdDscPrc%>%  &nbsp; $<%=sOrdAllDscAmt%></td>             
           </td>
          </tr>
        
        <%if(!sGrpItmDsc.trim().equals(".00") || !sOrdDscAmt.trim().equals(".00")){%>
        <tr  class="DataTable2">
             <td class="DataTable1" >After discount</td>
             <td class="DataTable1" style="border:1px black solid">$<%=sOrdAfterDsc%></td>
        </tr>
        <%}%>

        <!-- Show shipping price for special order only -->
        <%if(iNumOfSpc > 0) {%>
           <tr  class="DataTable2">
              <td class="DataTable1" >Shipping</td>
              <td class="DataTable1" >$<%=sOrdShpPrc%></td>
           </tr>
        <%}%>
        <!-- ======== Delivery =========== -->
        <tr  class="DataTable2">
           <td class="DataTable1" >Assembly & Delivery</td>
           <td class="DataTable1" >$<%=sAssmb_Delvry%></td>
        </tr>
        
        <!-- ======== Tax =========== -->
        <tr  class="DataTable2">
           <td class="DataTable1" >Tax</td>
           <td class="DataTable1">$<%=sOrdTax%></td>
        </tr>
        
        <!-- ======== Protection Plan =========== -->
        <tr  class="DataTable2">
           <td class="DataTable1" >Protection Plan</td>
           <td class="DataTable1" >$<%=sProtPlan%></td>
        </tr>
        
        <tr  class="DataTable2">
           <td class="DataTable1" >Total</td>
           <td class="DataTable1">$<%=sOrdTotal%></td>
        </tr>
       </table>
     <%}%>
          </table>
         </td>
       </tr>
     </td>
    </tr>

    <tr class="DataTable">
        <td class="DataTable" nowrap colspan=2>
          <table border=0  cellPadding="0" cellSpacing="0" width="100%" style="font-size:12px">
            <tr>
               <td>Manager on Duty Signature:<br><br>___________________________________________________</td>
               <td style="font-size:10px;">Salesperson: <%=sSlsper%> <%=sSlpName%><br><br>&nbsp;</td>
            </tr>
          </table>
        </td>
     </tr>


   <%
          PfsOrderComment ordnote = new PfsOrderComment(sOrder, "NOT");
          String sComments = ordnote.getComments();
          ordnote.disconnect();
   %>
   <%if(!sComments.equals("")){%>
    <tr>
     <td colspan="3"><br>
       <table border=1 width="100%" cellPadding=0 cellSpacing=0>
         <tr class="DataTable2">
           <td class="DataTable"><%=sComments%></td>
         </tr>
       </table>
     </td>
    </tr>
   <%}%>

    <tr class="NonPrt">
      <td><button class="Small" onclick="window.print()">Print</button></td>
    </tr>

  </table>
<%if(sStock == null) {%>
<div class="PrintOnly" style="border: black solid 1px; font-size:9px; width:100%;">&nbsp;<br>
<b>
Quoted prices may reflect current advertised sales, so may be subject to change.
Quantities on this quote are limited to in-stock on hand at the time this quote becomes a sale.
And Special Order items are limited to inventory availability from the Manufacturer,
which would be re-verified at the time this quote becomes a sale.
</b><br><br>

<b>Patio Sale Policies</b>

Returns
<i>In-Stock sales</i>: Once your new furniture has been delivered or removed from a our showroom,
your furniture cannot be returned for a refund, store credit, exchange or otherwise. Please thoroughly examine all items before accepting them.
<i>Special Orders</i>: There can be no changes or cancellations to your special order 24 hours after
the order has been placed with a Sale representative. Your order cannot be returned for a refund,
store credit, exchange or otherwise.  Our Store considers a special order a binding agreement upon
which we make financial commitments.<br><br>

<b>Inspection</b><br>
Our Store takes great pride in the quality and condition of its products.  Every furniture product is
thoroughly inspected and tested before it is delivered to you or placed in one of our showrooms.
However, oversights can happen. Please inspect all merchandise for scratches, dents, or any other
defects prior to removing it from one of our showrooms. For deliveries, please inspect the merchandise
thoroughly for any of the above defects before our delivery personnel leave your home.
If you are unable to be present during delivery and notice any defects, contact your Patio Sale
representative the same day as the delivery.<br><br>

<b>Delivery</b><br>
There is a charge for all local deliveries and professional set up. Long-distance or custom
deliveries may incur additional charges which will be determined at the time of purchase.
If you are having merchandise delivered, you will be contacted the day prior to your
scheduled delivery date to confirm the time of delivery.
Please see above for inspection guidelines.<br><br>

<b>Special Orders</b><br>
If you are placing a special order, please realize that it is a <i>custom order, built especially for you</i>.
We will not place an order until 50% of the total order has been paid.  After 24 hours, this payment
is nonrefundable. If the merchandise that arrives from the factory is not the exact size, dimension or
color you expected it to be, it still cannot be returned. Please see above for information on Patio
Sale return policy. Once a special order has been placed with a Patio Sale representative there can
be no changes or cancellations. For special orders sent directly to you from the manufacturer
(cushions, umbrellas and accessories only), full payment must be received at the time the order is
placed. Please check your Patio Sale invoice with the manufacture’s model name and model number
to make sure we are ordering the exact item you intend. Also, please verify the "ship to" address.<br><br>

The <i>estimated</i> delivery time for your special order of __________________________ is _______
to _______ weeks from the time of purchase.  Our Store cannot be held responsible for any
manufacturing or shipping delays that may cause the delivery of your merchandise to exceed your
original quote time.<br><br>

<b>Payment</b><br>
Final payment will be due prior to the delivery of your merchandise. Your signature on the front of this
invoice authorizes our store to charge your credit card for any remaining balance remaining on your order.
<div>
<%}%>
 </body>
</html>

<%
   ordent.disconnect();
   ordent = null;
}%>






