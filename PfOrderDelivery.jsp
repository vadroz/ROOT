<%@ page import="patiosales.OrderEntry, patiosales.PfsOrderComment, rciutility.BarcodeGen, java.util.*, java.text.*, java.io.*"%>
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
      String sStsNm = ordent.getStsNm();
      String sPySts = ordent.getPySts();
      String sPyStsNm = ordent.getPyStsNm();
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
      String sTotQty = ordent.getTotQty();

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
      String [] sQty55 = ordent.getQty55();
      String [] sQty63 = ordent.getQty63();
      String [] sQty64 = ordent.getQty64();
      String [] sQty68 = ordent.getQty68();
      String [] sQtyTaken = ordent.getQtyTaken();

      // item set
      int [] iNumOfSet = ordent.getNumOfSet();
      String [][] sSetSku = ordent.getSetSku();
      String [][] sSetVenSty = ordent.getSetVenSty();
      String [][] sSetVenNm = ordent.getSetVenNm();
      String [][] sSetColor = ordent.getSetColor();
      String [][] sSetUpc = ordent.getSetUpc();
      String [][] sSetDesc = ordent.getSetDesc();
      String [][] sSetQty = ordent.getSetQty();
      String [][] sSetQty35 = ordent.getSetQty35();
      String [][] sSetQty46 = ordent.getSetQty46();
      String [][] sSetQty50 = ordent.getSetQty50();
      String [][] sSetQty86 = ordent.getSetQty86();
      String [][] sSetQty55 = ordent.getSetQty55();
      String [][] sSetQty63 = ordent.getSetQty63();
      String [][] sSetQty64 = ordent.getSetQty64();
      String [][] sSetQty68 = ordent.getSetQty68();
      String [][] sSetRet = ordent.getSetRet();
      String [][] sSetQtyTaken = ordent.getSetQtyTaken();

      String [] sSugPrc = ordent.getSugPrc();

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


      // special order status name
      String sShowSoSts = null;
      if(sSoSts == null) sShowSoSts = "None";
      else if(sSoSts.equals("N")) sShowSoSts = "Non-Approved";
      else if(sSoSts.equals("A")) sShowSoSts = "Approved";
      else if(sSoSts.equals("V")) sShowSoSts = "Placed-w/Vendor";
      else if(sSoSts.equals("R")) sShowSoSts = "Receive-@-DC";

      //convert delivery date format
      SimpleDateFormat smpMDY = new SimpleDateFormat("MM/dd/yyyy");
      SimpleDateFormat smpWkDayMonDayYr = new SimpleDateFormat("EEEEEEEEEE - MMMMMMMMMMM, dd yyyy");

      // generate order number barcode
      try
         {
           String sFilePath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/Barcode/Patio_Order/" + sOrdNum + ".png";
           File f = new File(sFilePath);
           // not exists - generate picture
           if(!f.exists())
           {
              BarcodeGen bargen = new BarcodeGen();
              bargen.outputtingBarcodeAsPNG(sOrdNum, sFilePath);
           }
         }
         catch (Exception e) { System.out.println(e.getMessage()); }
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

        tr.DataTable { background:white; font-family:Arial; font-size:12px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:12px }
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
<title>Patio_Furniture_Delivery</title>

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
       <b>Patio Furniture - Delivery Ticket
       <br><img src="MainMenu/patio_logos1.jpg" height="50px">
       </b>
    </tr>

    <tr>
      <td ALIGN="left" VALIGN="TOP"   nowrap>

     <u>Delivery Date:</u> &nbsp;  &nbsp;  &nbsp;
         <b><span style="font-size:16px;width:70%; text-align:center; "><%=smpWkDayMonDayYr.format(smpMDY.parse(sDelDate))%></span></b>
<!-------------------------------------------------------------------->
<!-- Order Header Information ->
<!-------------------------------------------------------------------->
   <table border=1 width="100%" cellPadding="0" cellSpacing="0" >
     <tr class="DataTable">
        <td class="DataTable" width="90%">
           Order #: <br>
           <span style="width:100%;text-align:center;"><img width=200 src="/Barcode/Patio_Order/<%=sOrdNum%>.png"></span>
        <td class="DataTable" nowrap>
           Date of Order:<br>
           <span style="font-size:12px;width:100%;text-align:center;font-weight:bold">
             <%if(sEntDate == null){%><%=sToday%><%} else  {%><%=sEntDate%><%}%>
           </span>
        </td>
        <td class="DataTable" nowrap>
           Sold At:<br>
           <span style="font-size:12px;width:100%;text-align:center;font-weight:bold"><%=sStr%> - (<%=sStrPhn.substring(0,3)%>) <%=sStrPhn.substring(3,6)%>-<%=sStrPhn.substring(6)%></span>
           <br>By:<br><%=sSlsper%> - <%=sSlpName%>
        </td>
        <td class="DataTable" nowrap>
           Status of Order: <span style="font-size:12px;;text-align:center;font-weight:bold">&nbsp;<%=sStsNm%></span>
           <br>Payment Status: <span style="font-size:12px;text-align:center;font-weight:bold">&nbsp;<%=sPyStsNm%></span>
        </td>
     <tr>
     <!-- ======= Built by/Loaded by ========= -->
     <tr class="DataTable">
        <td class="DataTable" nowrap colspan=2>Built/Assembled by:</td>
        <td class="DataTable" nowrap colspan=2>Loaded on Truck by:</td>
     </tr>
     <tr class="DataTable1"><td class="DataTable" colspan="4">&nbsp;</td></tr>
     
     
     <!-- ======= Customer Name ========= -->
     <tr class="DataTable">
        <td class="DataTable" nowrap colspan=4>Customer Name(last, first):<br>
           <span style="font-size:12px;width:100%;text-align:center;font-weight:bold"><%=sLastName%>, <%=sFirstName%></span>
        </td>
     </tr>
     <!-- ======= Customer Address, city state zip ========= -->
     <tr class="DataTable">
        <td class="DataTable" nowrap>Street Address:<br>
           <span style="font-size:12px;width:100%;text-align:center;font-weight:bold">
              <%if(!sAddr1.equals("")){%><br><%=sAddr1%><%}%>
              <%if(!sAddr2.equals("")){%><br><%=sAddr2%><%}%>
           </span>
        </td>
        <td class="DataTable" nowrap>City:<br>
           <span style="font-size:12px;width:100%;text-align:center;font-weight:bold"><%=sCity%></span>
        </td>
        <td class="DataTable" nowrap>State:<br>
           <span style="font-size:12px;width:100%;text-align:center;font-weight:bold"><%=sState%></span>
        </td>
        <td class="DataTable" nowrap>Zip:<br>
           <span style="font-size:12px;width:100%;text-align:center;font-weight:bold"><%=sZip%></span>
        </td>
     </tr>

     <!-- ======= Customer day, evening and cell phone, email ========= -->
     <tr class="DataTable">
        <td class="DataTable" nowrap>Daytime Phone:<br>
           <span style="font-size:12px;width:100%;text-align:center;font-weight:bold"><%if(!sDayPhn.trim().equals("")){%>(<%=sDayPhn.substring(0,3)%>) <%=sDayPhn.substring(3,6)%>-<%=sDayPhn.substring(6)%> <%=sExtWorkPhn%><%}%></span>
        </td>
        <td class="DataTable" nowrap>Evening Phone:<br>
           <span style="font-size:12px;width:100%;text-align:center;font-weight:bold"><%if(!sEvtPhn.trim().equals("")){%>(<%=sEvtPhn.substring(0,3)%>) <%=sEvtPhn.substring(3,6)%>-<%=sEvtPhn.substring(6)%><%}%></span>
        </td>
        <td class="DataTable" nowrap>Cell Phone:<br>
           <span style="font-size:12px;width:100%;text-align:center;font-weight:bold"><%if(!sCellPhn.trim().equals("")){%>(<%=sCellPhn.substring(0,3)%>) <%=sCellPhn.substring(3,6)%>-<%=sCellPhn.substring(6)%><%}%></span>
        </td>
        <td class="DataTable" nowrap>E-Mail:<br>
           <span style="font-size:12px;width:100%;text-align:center;font-weight:bold"><%=sEMail%></span>
        </td>
     </tr>

     <tr class="DataTable1"><td class="DataTable" colspan="4">&nbsp;</td></tr>

     <!-- ======= Shipping instruction ========= -->
     <tr class="DataTable">
        <td class="DataTable" colspan="4">Special Shipping Instructions:<br>
           <span style="font-size:12px;width:100%;text-align:center;font-weight:bold"><%=sShipInstr%></span>
        </td>
     </tr>

    </table>
   </td>
  </tr>

     <!-- ======================= Item List =================================-->
     <tr class="DataTable">
        <td class="DataTable" nowrap colspan=2>&nbsp;<br>
          <table border=1  cellPadding="0" cellSpacing="0" width="100%" style="font-size:12px">
            <tr class="DataTable">
               <th class="DataTable" colspan=7 >Patio Sales Order - ITEM Details</th>
            </tr>
            <tr>
               <th>Short Sku</th>
               <th>Vendor Name/Style</th>
               <th>Item Description</th>
               <%if(iNumOfSpc == 0){%>
                 <th>Color</th>
                 <th>Inv @ Str</th>
                 <th>Taken</th>
               <%}
               else {%>
                 <th>Frame<br>Color/Material</th>
                 <th>Fabric<br>Color</th>
               <%}%>
               <th>Qty</th>
            </tr>

            <%int iNetTot = 0;
              for(int i=0; i < iNumOfItm; i++) {%>
            <%
                   String sStrInv = "";
                   String sComa = "";
                   if(!sQty35[i].equals("0")){sStrInv += "35: " + sQty35[i]; sComa = ", ";}
                   if(!sQty46[i].equals("0")){sStrInv += sComa + "46: " + sQty46[i]; sComa = ", ";}
                   if(!sQty50[i].equals("0")){sStrInv += sComa + "50: " + sQty50[i]; sComa = ", ";}
                   if(!sQty86[i].equals("0")){sStrInv += sComa + "86: " + sQty86[i]; sComa = ", ";}
                   if(!sQty55[i].equals("0")){sStrInv += sComa + "55: " + sQty55[i]; sComa = ", ";}
                   if(!sQty63[i].equals("0")){sStrInv += sComa + "63: " + sQty63[i]; sComa = ", ";}
                   if(!sQty64[i].equals("0")){sStrInv += sComa + "64: " + sQty64[i]; sComa = ", ";}
                   if(!sQty68[i].equals("0")){sStrInv += sComa + "68: " + sQty68[i]; sComa = ", ";}
                   int iNetQty = Integer.parseInt(sQty[i]) - Integer.parseInt(sQtyTaken[i]);
                   if(!sSet[i].equals("1")){ iNetTot += iNetQty; }
              %>
              <tr class="DataTable" <%if(iNetQty <= 0){%>style="background:lightgrey"<%}%>>
                <td class="DataTable">
                    <%=sSku[i]%>
                    <%if(sSet[i].equals("1")){%><font color="darkbrown">(Set)</font><%}%>
                    &nbsp;
                </td>
                <td class="DataTable"><%=sVenName[i]%></td>
                <td class="DataTable"><%=sDesc[i]%></td>
                <td class="DataTable"><%=sColor[i]%></td>
                <td class="DataTable">
                <%if(!sSet[i].equals("1")){%><%=sStrInv%><%}%>&nbsp;
                </td>
                <td class="DataTable1"><%if(!sSet[i].equals("1") && !sQtyTaken[i].equals("0") ){%><%=sQtyTaken[i]%><%}%>&nbsp</td>
                <td class="DataTable1"><%if(!sSet[i].equals("1")){%><%=iNetQty%><%}%>&nbsp</td>
              </tr>
              <!-- =====  Set ===== -->
              <%if(iNumOfSet[i] > 0) { %>
                <%for(int j=0; j < iNumOfSet[i]; j++) {%>
                <%
                   sStrInv = "";
                   sComa = "";
                   if(!sSetQty35[i][j].equals("0")){sStrInv +=         "35: " + sSetQty35[i][j]; sComa = ", ";}
                   if(!sSetQty46[i][j].equals("0")){sStrInv += sComa + "46: " + sSetQty46[i][j]; sComa = ", ";}
                   if(!sSetQty50[i][j].equals("0")){sStrInv += sComa + "50: " + sSetQty50[i][j]; sComa = ", ";}
                   if(!sSetQty86[i][j].equals("0")){sStrInv += sComa + "86: " + sSetQty86[i][j]; sComa = ", ";}
                   if(!sSetQty55[i][j].equals("0")){sStrInv += sComa + "55: " + sSetQty55[i][j]; sComa = ", ";}
                   if(!sSetQty63[i][j].equals("0")){sStrInv += sComa + "63: " + sSetQty63[i][j]; sComa = ", ";}
                   if(!sSetQty64[i][j].equals("0")){sStrInv += sComa + "64: " + sSetQty64[i][j]; sComa = ", ";}
                   if(!sSetQty68[i][j].equals("0")){sStrInv += sComa + "68: " + sSetQty68[i][j]; sComa = ", ";}
                   int iSetNetQty = Integer.parseInt(sSetQty[i][j]) - Integer.parseInt(sSetQtyTaken[i][j]);
                   iNetTot += iSetNetQty;
                %>
                   <tr class="DataTable" <%if(iSetNetQty <= 0){%>style="background:lightgrey"<%}%>>
                     <td class="DataTable"> &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;
                       <%=sSetSku[i][j]%>
                     </td>
                     <td class="DataTable"><%=sSetVenNm[i][j]%></td>
                     <td class="DataTable"><%=sSetDesc[i][j]%></td>
                     <td class="DataTable"><%=sSetColor[i][j]%></td>
                     <td class="DataTable"><%=sStrInv%></td>
                     <td class="DataTable1"><%if(!sSetQtyTaken[i][j].equals("0")){%><%=sSetQtyTaken[i][j]%><%} else {%>&nbsp;<%}%></td>
                     <td class="DataTable1"><%=iSetNetQty%></td>
                   </tr>
                <%}%>
              <%}%>
            <%}%>
            <%if(iNumOfSpc == 0){%>
            <tr class="DataTable">
               <td class="DataTable1" colspan=6>Total Quantity of Delivered Items</td>
               <td class="DataTable1"><%=iNetTot%></td>
            </tr>
            <%}%>

            <!-- ====== Special Order ===============-->
            <%if(iNumOfSpc > 0){%>
               <%for(int i=0; i < iNumOfSpc; i++) {%>
                  <tr class="DataTable">
                    <td class="DataTable1">Special Order</td>
                    <td class="DataTable"><%=sSoVenName[i]%><br>Style: <%=sSoVenSty[i]%></td>
                    <td class="DataTable"><%=sSoDesc[i]%></td>
                    <td class="DataTable">
                       <%String sBr = "";%>
                       <%if(!sSoFrmClr[i].equals("")){%><%=sSoFrmClr[i]%><%sBr="<br>"; }%>
                       <%if(!sSoFrmMat[i].equals("")){%><%=sBr%><%=sSoFrmMat[i]%><%sBr="<br>";}%>
                       &nbsp;
                    </td>
                    <td class="DataTable">
                       <%if(!sSoFabClr[i].equals("")){%><%=sBr%><%=sSoFabClr[i]%><%sBr="<br>";}%>
                       <%if(!sSoFabNum[i].equals("")){%><%=sBr%><%=sSoFabNum[i]%><%}%>
                       &nbsp;
                    </td>
                    <td class="DataTable1"><%=sSoQty[i]%></td>
                  </tr>
               <%}%>
             </tr>
            <%}%>
            <%if(iNumOfSpc > 0){%>
            <tr class="DataTable">
               <td class="DataTable1" colspan=5>Total Quantity of Delivered Items</td>
               <td class="DataTable1"><%=sTotQty%></td>
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

    <tr class="DataTable">
      <td class="DataTable" nowrap>
         <b><u>Customer Signature:</u></b><br><br>
         <span style="font-size:12px;width:100%;text-align:left;">
           Delivery Receipt: _______________________________________
           Date: _______________
         </span>
     </td>
   </tr>

   <tr class="DataTable">
     <td class="DataTable" nowrap>
       <span style="font-size:10px;width:100%;text-align:left;">&nbsp;<br>
       Sign to confirm that you have received and inspected all items on this order.
       </span>
     </td>
   </tr>

    <tr class="NonPrt">
      <td><br><br><button class="Small" onclick="window.print()">Print</button></td>
    </tr>

  </table>
<div class="PrintOnly" style="font-size:10px;width:100%;">&nbsp;<br>
<b>Patio Sale Policies</b>

Returns
<i>In-Store sales</i>: Once your new furniture has been delivered or removed from a Patio Sale showroom,
your furniture cannot be returned for a refund, store credit, exchange or otherwise. Please thoroughly examine all items before accepting them.
<i>Special Orders</i>: There can be no changes or cancellations to your special order 3 working days after
the order has been placed with a Patio Sale representative. Your order cannot be returned for a refund,
store credit, exchange or otherwise.  Patio Sale considers a special order a binding agreement upon
which we make financial commitments.<br><br>

<b>Inspection</b><br>
Patio Sale takes great pride in the quality and condition of its products.  Every furniture product is
thoroughly inspected and tested before it is delivered to you or placed in one of our showrooms.
However, oversights can happen. Please inspect all merchandise for scratches, dents, or any other
defects prior to removing it from one of our showrooms. For deliveries, please inspect the merchandise
thoroughly for any of the above defects before the Patio Sale delivery personnel leave your home.
If you are unable to be present during delivery and notice any defects, contact your Patio Sale
representative the same day as the delivery.<br><br>
<div>
 </body>
</html>

<%
   ordent.disconnect();
   ordent = null;
}%>






