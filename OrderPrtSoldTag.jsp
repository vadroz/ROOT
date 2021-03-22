<%@ page import="patiosales.OrderEntry, patiosales.PfsOrderComment, rciutility.BarcodeGen, java.util.*, java.text.*, java.io.*"%>
<%
   String sOrder = request.getParameter("Order");
   String sPrtStore = request.getParameter("Store");
   String sPrtByEmp = request.getParameter("Emp");
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
      String sStrAllowed = session.getAttribute("STORE").toString();
      String sUser = session.getAttribute("USER").toString();
      String sEntStore = session.getAttribute("STORE").toString();
      if(sEntStore.trim().equals("ALL")) sEntStore = "Home Office";

      // check if user is authotized to change a status
      boolean bAllowChgSts = false;
      if(session.getAttribute("PATIOSTS")!=null) bAllowChgSts = true;

      OrderEntry ordent = new OrderEntry();

      boolean bExist = false;

      //ordent.serOrderInfo(sOrder.trim());
      ordent.setSoldTag(sOrder, sPrtStore, sPrtByEmp, sUser);

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
      int iNumOfSoldItm = ordent.getNumOfSoldItm();

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
      
      /*for(int i=0; i < iNumOfItm; i++)
      {
    	  System.out.println("i=" + i +  "  ==> sQty35[i]=" +  sQty35[i] );
      }*/
     

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
      String [][] sSetQty63 = ordent.getSetQty63();
      String [][] sSetQty64 = ordent.getSetQty64();
      String [][] sSetQty68 = ordent.getSetQty68();
      String [][] sSetQty55 = ordent.getSetQty55();
      String [][] sSetRet = ordent.getSetRet();
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
      
      

      // check if barcode exists or generate new barcode as .png file
      for(int i=0; i < iNumOfItm; i++)
      {
         try
         {
           String sFilePath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/Barcode/" + sSku[i] + ".png";
           if(!sSku[i].trim().equals(""))
           {
           		File f = new File(sFilePath);
           		// not exists - generate picture
           		if(!f.exists())
           		{
        	  		System.out.println(sFilePath);
              		BarcodeGen bargen = new BarcodeGen();
              		bargen.outputtingBarcodeAsPNG(sSku[i], sFilePath);
           		}
           }
         }
         catch (Exception e) { System.out.println(e.getMessage()); }
      }

      // generate order number barcode  
      try
         {
           String sFilePath = "C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps\\ROOT\\Barcode\\Patio_Order\\" + sOrdNum + ".png";
           File f = new File(sFilePath);
           System.out.println(sFilePath);
           // not exists - generate picture
           if(!f.exists())
           {
              BarcodeGen bargen = new BarcodeGen();
              bargen.outputtingBarcodeAsPNG(sOrdNum, sFilePath);
           }
         }
         catch (Exception e) { System.out.println(e.getMessage()); }


      SimpleDateFormat smpMDY = new SimpleDateFormat("MM/dd/yyyy");
      SimpleDateFormat smpWkDayMonDayYr = new SimpleDateFormat("EEEEEEEEEE - MMMMMMMMMMM, dd yyyy");
      
      String sSlpArr[] = sSlpName.split(" ", 2);      
%>


<html>
<head>

<style>body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}

        a.Small:link { color:blue; font-size:10px} a.Small:visited { color:blue; font-size:10px}  a.Small:hover { color:blue; font-size:10px}

        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#e7e7e7;padding-top:3px; padding-bottom:3px;
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
        tr.DataTable1 { font-family:Arial; font-size:16px }
        tr.DataTable2 { font-family:Arial; font-size:18px }
        tr.DataTable3 { font-family:Arial; font-size:10px }


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

        td.BoxName {cursor:move;background: blue;
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:blue;
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
//==============================================================================
// run on body load
//==============================================================================
function bodyload()
{
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<title>PF_SOLD_Tag</title>

<body onload="bodyload()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frameChkCalendar"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->
 
<%for(int i=0, isold=1; i < iNumOfItm; i++) {
   int iStrQty = 0;
   if (sPrtStore.equals("35")){ iStrQty += Integer.parseInt(sQty35[i]); }
   if (sPrtStore.equals("46")){ iStrQty += Integer.parseInt(sQty46[i]); }
   if (sPrtStore.equals("50")){ iStrQty += Integer.parseInt(sQty50[i]); }
   if (sPrtStore.equals("86")){ iStrQty += Integer.parseInt(sQty86[i]); }
   if (sPrtStore.equals("55")){ iStrQty += Integer.parseInt(sQty55[i]); }
   if (sPrtStore.equals("63")){ iStrQty += Integer.parseInt(sQty63[i]); }
   if (sPrtStore.equals("64")){ iStrQty += Integer.parseInt(sQty64[i]); }
   if (sPrtStore.equals("68")){ iStrQty += Integer.parseInt(sQty68[i]); }   
    
   for(int j=0; j < iStrQty; j++) {%>
    <%if(i > 0 || j > 0){%><p style="page-break-before:always;font-size:1px;"/>&nbsp;<%}%>
    <table border="0" cellPadding="0"  cellSpacing="0">
      <tr>
       <td ALIGN="center" valign="bottom"  width="15%"  nowrap>
         <span style="font-family:Arial;font-size:72px; border: solid 3px black; width:70px; text-align:center;">
           <span style="font-family:Arial;font-size:8px;"><b>Sold At:</b></span><br><%=sStr%>
         </span>
      </td>

      <td ALIGN="center" VALIGN="TOP" nowrap>
         <img src="images/SOLD Tag.JPG">
      </td>

      <td ALIGN="center" valign="bottom" nowrap> &nbsp;  &nbsp; &nbsp;
         <span style="font-family:Arial;font-size:36px; border: solid 3px black; width:70px; text-align:center;">
           <span style="font-family:Arial;font-size:8px;"><b>Inventory from:</b></span><br><%=sPrtStore%>
         </span>
          &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;
      </td>

     </tr>
    <tr>
      <td ALIGN="left" VALIGN="TOP" nowrap colspan=3>
      <br><br>

<!-------------------------------------------------------------------->
<!-- Order Header Information ->
<!-------------------------------------------------------------------->
   <table border=0 width="100%" cellPadding="0" cellSpacing="0" >
     <tr class="DataTable1">
        <td class="DataTable" width="60%">
           <u>Patio Order #</u>  &nbsp;  &nbsp;  &nbsp;
             <img width=200 src="/Barcode/Patio_Order/<%=sOrdNum%>.png">
        </td>
        <td class="DataTable" nowrap>
           <u>Sale Date:</u>  &nbsp;  &nbsp;  &nbsp; <%if(sEntDate == null){%><%=sToday%><%} else  {%><%=sEntDate%><%}%>
        </td>
     </tr>

     <tr class="DataTable1">
        <td class="DataTable"><br>
           <u>Customer:</u>  &nbsp;  &nbsp;  &nbsp; <%=sFirstName%> <%=sLastName%>
        </td>
        <td class="DataTable" nowrap>
           <u>Sold At Store:</u>  &nbsp; <%=sStr%>   &nbsp;  &nbsp;
           <u>By: </u> &nbsp;  <%=sSlsper%> - <%=sSlpArr[0]%>
        </td>
     </tr>


     <tr class="DataTable1">
        <td class="DataTable"><br>
           <u>Delivery Date:</u> &nbsp;  &nbsp;  &nbsp;
              <b><span style="font-size:18px;width:70%; text-align:center; "><%=smpWkDayMonDayYr.format(smpMDY.parse(sDelDate))%></span></b>
        </td>
        <td class="DataTable" nowrap>
           <u>Units from <%=sPrtStore%>:</u>  &nbsp;  &nbsp;  &nbsp; <%=iNumOfSoldItm%>
        </td>
     </tr>

     <tr class="DataTable2">
        <td class="DataTable2" colspan=2><br>
           <b><%=sCity%>, <%=sState%></b>
        </td>
     </tr>
   </table>
    </td>
   </tr>

   <tr>
      <td style="font-size:1px; border-top:solid 1px black;" colspan=3>&nbsp;</td>
   </tr>

   <tr class="DataTable">
      <td class="DataTable2" colspan=3>Total Units of inventory to Transfer from Store <%=sPrtStore%> to fulfill this order =
         <%if(!sStr.equals(sPrtStore)){%><%=iNumOfSoldItm%><%} else {%>0<%}%></td>
   </tr>
   <tr class="DataTable2">
      <td class="DataTable2" colspan=3>
         <span style="font-family:Arial;font-size:72px; border: solid 3px black; width:70px; text-align:center;white-space:nowrap;">
           <span style="font-family:Arial;font-size:36px; text-align:center;">Item:</span>
           <%=isold++%>
           <span style="font-family:Arial;font-size:36px; text-align:center;">of</span>
           <%=iNumOfSoldItm%>
         </span>
      </td>
   </tr>

   <!-- === Vendor === -->
   <tr class="DataTable2">
      <td class="DataTable2" colspan=3><b><%=sVenName[i]%></b></td>
   </tr>

   <!-- === Vendor Style and RCI description === -->
   <tr class="DataTable2">
      <td class="DataTable2" colspan=3><b><%=sVenSty[i]%> - <%=sDesc[i]%> - <%=sColor[i]%></b></td>
   </tr>

   <!-- === Sku and barcode === -->
   <tr class="DataTable">
      <td class="DataTable2" nowrap>
          SKU: &nbsp; &nbsp;
          <img width=200 src="/Barcode/<%=sSku[i]%>.png">
      </td>
      <td class="DataTable2" nowrap>Total Qty of this SKU = <%=iStrQty%></td>
      <td class="DataTable2" nowrap>
        <span style="font-family:Arial;font-size:10px; border: solid 1px black; width:70px; text-align:center;white-space:nowrap; padding-left:3px; padding-right:3px;">
          Transfer Date:<br><br>
          _____/_____/_____<br>&nbsp;
        </span>
      </td>
   </tr>

   <!-- === order recap table === -->
   <tr class="DataTable2">
      <td class="DataTable2" colspan=3>
         <span id="spnRecap"></span>
      </td>
   </tr>

   <!-- === divider === -->
   <tr>
      <td style="font-size:1px; border-top:solid 2px brown;" colspan=3>&nbsp;</td>
   </tr>
  </table>

  <!----------------------- end of items loop ------------------------>
   <%}%>
  <%}%>

<button class="NonPrt" onclick="window.print()">Print</button></td>

 </body>

<SCRIPT language="JavaScript1.2">
  var NumOfSoldItm = "<%=iNumOfSoldItm%>";

 setOrdRecap();

//==============================================================================
// retrieve order recap info
//==============================================================================
function setOrdRecap()
{
  var url = "PfOrderRecap.jsp?Order=<%=sOrder%>"
  window.frame1.location.href=url;
}
//==============================================================================
// save order recap info
//==============================================================================
function getOrdRecap(html)
{
   var recap = document.all.spnRecap;
   if(NumOfSoldItm > 1)
   {
      for(var i=0; i < recap.length; i++)
      {
        document.all.spnRecap[i].innerHTML = html;
      }
   }
   else
   {
       recap.innerHTML = html;
   }
}

</SCRIPT>

</html>

<%
   ordent.disconnect();
   ordent = null;
}%>
