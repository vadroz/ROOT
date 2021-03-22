<%@ page import="posend.POPrint"%>
<%
 //----------------------------------
 // Application Authorization
 //----------------------------------

 if (session.getAttribute("USER")==null)
 {
   response.sendRedirect("SignOn1.jsp?TARGET=POPrint.jsp&APPL=ALL&" + request.getQueryString());
 }
 else
 {
    if(session.getAttribute("POSEND")==null){response.sendRedirect("index.jsp");}

    String sPONum = request.getParameter("PO");
    String sUser = session.getAttribute("USER").toString();

    POPrint poprint = new POPrint(sPONum, sUser);
    String sPages = poprint.getPages();
    String sOrdDt = poprint.getOrdDt();
    String sShipDt = poprint.getShipDt();
    String sAntcDt = poprint.getAntcDt();
    String sCnclDt = poprint.getCnclDt();
    String sOrigPO = poprint.getOrigPO();
    String sVia = poprint.getVia();
    String sTerms = poprint.getTerms();
    String sCommod = poprint.getCommod();
    String [] sVenAddr = poprint.getVenAddr();
    String [] sTopCmt = poprint.getTopCmt();
    String [] sBotCmt = poprint.getBotCmt();
    String sPORet = poprint.getPORet();
    String sPOCost = poprint.getPOCost();
    String sPOQty = poprint.getPOQty();
    String sDisc = poprint.getDisc();
    String sStatus = poprint.getStatus();
    String sRevNum = poprint.getRevNum();
    String [] sShipTo = poprint.getShipTo();

    int iNumOfItm = poprint.getNumOfItm();
    String [] sCls = poprint.getCls();
    String [] sVen = poprint.getVen();
    String [] sSty = poprint.getSty();
    String [] sClr = poprint.getClr();
    String [] sSiz = poprint.getSiz();
    String [] sSku = poprint.getSku();
    String [] sCost = poprint.getCost();
    String [] sRet = poprint.getRet();
    String [] sQty = poprint.getQty();
    String [] sDesc = poprint.getDesc();
    String [] sVenSty = poprint.getVenSty();
    String [] sUpc = poprint.getUpc();
    String [] sClrName = poprint.getClrName();
    String [] sSizName = poprint.getSizName();
    String [] sLvlBreak = poprint.getLvlBreak();

    int iNumOfPages = poprint.getNumOfPages();
    int [] iNumOfItemsOnPage = poprint.getNumOfItemsOnPage();

    poprint.disconnect();
    poprint = null;
%>

<style>
   @media screen{ body {background:white;}  }

        table.DataTable { border: black solid 1px; text-align:center;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { border-bottom: black solid 1px; border-right: black solid 1px; padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:10px }

        th.DataTable1 { border-bottom: black solid 1px; border-right: black solid 1px; padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background: #E7E7E7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: white; font-family:Arial; font-size:10px }
        tr.DataTable2 { background: white; font-family:Arial; font-size:11px; font-weight:bold }

        td.DataTable { border-bottom: black solid 1px; border-right: black solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { border-bottom: black solid 1px; border-right: black solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px; vertical-align:top;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { border-bottom: black solid 1px; border-right: black solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}

        td.DataTable3 { border-bottom: black solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.Page { border: black solid 1px; vertical-align:top;
                  padding-top:3px; padding-bottom:3px; padding-left:3px;
                  padding-right:3px; text-align:left; white-space:}


        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

@media print
{
   @page {size: landscape}
}

</style>

<!-- script language="JavaScript1.2" src="http://192.168.20.64:2001/?jsEmbedder"></script--!>
<!-- script name="javascript1.2">
   myImage = new CordaEmbedder();
   myImage.loadDoc("http://www.yahoo.com");
   document.writeln(myImage.getEmbeddingHTML()); -->

<script name="javascript1.2">
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
}
//==============================================================================
//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, ""); }
    return s;
}

</script>

<HTML><HEAD>

<META content="RCI, Inc." name=POPrint></HEAD>
<BODY onload="bodyLoad();">

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
  <!-- ======================= PO Heading =============================== -->
    <TD vAlign=top align=left width="35%" height="30%">
       <table class="DataTable" cellPadding="0" cellSpacing="0" width="100%" height="100%">
       <!-- ----------Line 1 left box --------------------- -->
         <tr  class="DataTable">
           <th class="DataTable" colspan=4>Vendor</th>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable1" colspan=4><span style="font-size:16px; font-weight:bold"><%=sVenAddr[0]%></span><br>
           <%for(int i=1; i < 4; i++){%><%=sVenAddr[i]%><br><%}%></td>
         </tr>

         <!-- ----------Line 2 left box --------------------- -->
         <tr  class="DataTable">
           <th class="DataTable">P.O.#</th>
           <th class="DataTable">Buyer Ref. No.</th>
           <th class="DataTable">Page</th>
           <th class="DataTable">Original/Confirmation</th>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable"><%=sPONum%></td>
           <td class="DataTable"><%=sOrigPO%></td>
           <td class="DataTable">1 of <%=sPages%></td>
           <td class="DataTable"><%=sStatus%> <%=sRevNum%></td>
         </tr>
        <!-- ----------Line 2 left box --------------------- -->
         <tr  class="DataTable">
           <th class="DataTable">Ordered</th>
           <th class="DataTable">Ship On</th>
           <th class="DataTable">Anticipate</th>
           <th class="DataTable">Cancel After</th>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable"><%=sOrdDt%></td>
           <td class="DataTable"><%=sShipDt%></td>
           <td class="DataTable"><%=sAntcDt%></td>
           <td class="DataTable"><%=sCnclDt%></td>
         </tr>
         <!-- ----------Line 3 left box --------------------- -->
         <tr  class="DataTable">
           <th class="DataTable" colspan=2>Discount</th>
           <th class="DataTable" colspan=2>Terms</th>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable" colspan=2><%=sDisc%>%</td>
           <td class="DataTable" colspan=2><%=sTerms%></td>
         </tr>
         <!-- ----------Line 4 left box --------------------- -->
         <tr  class="DataTable">
           <th class="DataTable" colspan=2>Commodity</th>
           <th class="DataTable" colspan=2>&nbsp;</th>
         </tr>
         <tr class="DataTable1">
           <td class="DataTable" colspan=2><%=sCommod%></td>
           <td class="DataTable" colspan=2>&nbsp;</td>
         </tr>

       </table>

      </TD>
      <!-- ==================== Company name box - center =================== -->
      <TD vAlign=top align=left width="27%">
       <table class="DataTable" cellPadding="0" cellSpacing="0" width="100%" height="100%">
         <!-- ----------Line 1 left box --------------------- -->
         <tr  class="DataTable1">
           <td class="DataTable1"><span style="font-size:16px; font-weight:bold">RETAIL<br>&nbsp;&nbsp;CONCEPTS</span>, Inc

             <br><br>4001 Greenbriar Suite 100 <br>Stafford, Tx 77477<br>281/340-5000
             <br>Fax 281/340-5020
           </td>
         </tr>
         <tr  class="DataTable">
           <th class="DataTable">*INSTRUCTION*</th>
         </tr>
         <tr  class="DataTable1">
           <td class="DataTable1">
            Go to: <a href="http://www.retailconcepts.cc">www.retailconcepts.cc</a>
            <br>Place P.O. on each carton, Bill of Lading and Invoice.Separate invoice
            for each shipment and each purchase order within shipment. Thisorder is
            given subject to the terms and conditions herewith set forth.
            (See reverse side of Purchase Order for Terms of Purchase Agreement).
            All defective merchandise, substitutions and overages will be subject to return.
           </td>
         </tr>
       </table>
      </TD>
      <!-- ==================== Company address box - right ================ -->
      <TD vAlign=top align=left>
       <table class="DataTable" cellPadding="0" cellSpacing="0" width="100%" height="100%">
         <!-- ----------Line 1 left box --------------------- -->
         <tr  class="DataTable1">
           <td class="DataTable1" colspan=2>
              <span style="font-size:16px; font-weight:bold">
                  For Vendor Compliance Guidelines<br>and Shipping Instructions
                  <br>Go to: <a href="http://www.retailconcepts.cc" target="_blank">www.retailconcepts.cc</a></span>
           </td>
         </tr>
         <tr  class="DataTable1">
            <td class="DataTable3" width="7%" valign=top>Ship To:</td>
            <td class="DataTable1"><br><span style="font-size:16px; font-weight:bold">
                 <%=sShipTo[0]%><br><%=sShipTo[1]%><br><%=sShipTo[2]%><br>
                 <%if(!sShipTo[3].trim().equals("")) {%><%=sShipTo[3]%><%}%></span></td>
         </tr>
         <tr  class="DataTable">
           <th class="DataTable" colspan=2>VENDOR COMMENTS</th>
         </tr>
          <tr  class="DataTable1">
           <td class="DataTable1" colspan=2><%for(int i=0; i < 4; i++){%><%=sTopCmt[i]%><br><%}%></td>
       </table>
      </TD>
      <!-- ==================== Company address box - right ================ -->
     </TR>

   <!-- ======================= Details =============================== -->
     <TR>
       <TD vAlign=top align=left colspan=3>
       <!-- ==================== Company name box - center =================== -->
       <table class="DataTable" cellPadding="0" cellSpacing="0" width="100%">
         <!-- ----------Detail box --------------------- -->
         <tr  class="DataTable">
           <th class="DataTable1">Vendor Style</th>
           <th class="DataTable1">UPC</th>
           <!--th class="DataTable1">Description / Long Item Number / Color / Short Sku</th -->
           <th class="DataTable1">Description</th>
           <th class="DataTable1">Long Item Number</th>
           <th class="DataTable1">Color</th>
           <th class="DataTable1">Size</th>
           <th class="DataTable1">Short Sku</th>
           <th class="DataTable1">Retail</th>
           <th class="DataTable1">Cost</th>
           <th class="DataTable1">Quantity</th>
         </tr>
         <%int iCurrentPage = 0;
           for(int i=0, j=0; i < iNumOfItm; i++, j++){%>

       <!-- ======================= Header for page break =============================== -->
       <%// page break  - show next page header
         if (j > iNumOfItemsOnPage[iCurrentPage]) { iCurrentPage++; j=1; %>
          </table></TD></TR>
          <TR><TD vAlign=top align=left colspan=3><div style="page-break-before:always"></div>
          <table class="DataTable" cellPadding="0" cellSpacing="0" width="100%">
           <tr  class="DataTable1"><td colspan=10>
             <table class="DataTable" cellPadding="0" cellSpacing="0" width="100%" height="100%">
                <!-- ----------Line 1 left box --------------------- -->
                <tr  class="DataTable">
                  <th class="DataTable1">P.O.# <%=sPONum%></th>
                  <th class="DataTable1">Page <%=iCurrentPage+1%> of <%=sPages%></th>
                  <td class="DataTable1"><span style="font-size:16px; font-weight:bold">RETAIL CONCEPTS</span>, Inc
                    <br><br>4001 Greenbriar Suite 100 <br>Stafford, Tx 77477<br>281/340-5000
                    <br>Fax 281/340-5020
                </td>
                <td class="DataTable1">Ship To:<br>
                    <span style="font-size:16px; font-weight:bold;">
                       <%=sShipTo[0]%><br><%=sShipTo[1]%><br><%=sShipTo[2]%><br>
                       <%if(!sShipTo[3].trim().equals("")) {%><%=sShipTo[3]%><%}%>
                    </span></td>
               </tr>
             </table>
           </td>
         </tr>
         <tr  class="DataTable">
           <th class="DataTable1">Vendor Style</th>
           <th class="DataTable1">UPC</th>
           <!--th class="DataTable1">Description / Long Item Number / Color / Short Sku</th -->
           <th class="DataTable1">Description</th>
           <th class="DataTable1">Long Item Number</th>
           <th class="DataTable1">Color</th>
           <th class="DataTable1">Size</th>
           <th class="DataTable1">Short Sku</th>
           <th class="DataTable1">Retail</th>
           <th class="DataTable1">Cost</th>
           <th class="DataTable1">Quantity</th>
         </tr>
       <%}%>
       <!-- ======================= End Header for page break =============================== -->
           <tr  class="DataTable1">
             <td class="DataTable1"><%=sVenSty[i]%></td>
             <td class="DataTable"><%=sUpc[i]%></td>
             <td class="DataTable1"><%if(sLvlBreak[i].equals("Y")){%><%=sDesc[i]%><%} else{%>&nbsp;<%}%></td>
             <td class="DataTable"><%if(sLvlBreak[i].equals("Y")){%><%=sCls[i] + "-" + sVen[i] + "-" + sSty[i]%><%} else{%>&nbsp;<%}%></td>
             <td class="DataTable"><%=sClrName[i] + " - " + sClr[i]%></td>
             <td class="DataTable"><%=sSizName[i] + " - " + sSiz[i]%></td>
             <td class="DataTable"><%=sSku[i]%></td>
             <td class="DataTable2">$<%=sRet[i]%></td>
             <td class="DataTable2">$<%=sCost[i]%></td>
             <td class="DataTable2">&nbsp;<%=sQty[i]%></td>
           </tr>
         <%}%>
       </table>
       </TD>
    </TR>
    <!-- ======================= Footer =============================== -->
     <TR class="DataTable1" height="60">
       <TD class="Page" colspan=3>
       <!-- ====================  =================== -->
       <table border=0 cellPadding="0" cellSpacing="0" width="100%" height="100%">
       <tr>
         <td align=left width="20%">
            <!-- ==================== Company name box - center =================== -->
            <table class="DataTable" cellPadding="0" cellSpacing="0" height="100%">
            <!-- ----------Detail box --------------------- -->
              <tr  class="DataTable">
                <th class="DataTable1">Total Units</th>
                <th class="DataTable1">&nbsp;</th>
                <th class="DataTable1">Total Amount</th>
              </tr>
              <tr  class="DataTable1">
                <th class="DataTable1"><%=sPOQty%></th>
                <th class="DataTable1">cost</th>
                <th class="DataTable1">$<%=sPOCost%></th>
              </tr>
            </table>
          </td>
          <td align=left>
            <!-- ==================== Company name box - center =================== -->
            <table class="DataTable" cellPadding="0" cellSpacing="0" width="90%" height="100%">
            <!-- ----------Detail box --------------------- -->
              <tr  class="DataTable">
                <th class="DataTable1">Internal Comments</th>
              </tr>
              <tr  class="DataTable1">
                <td class="DataTable1"><%for(int i=0; i < 3; i++){%><%=sBotCmt[i]%>&nbsp;&nbsp;<%}%></td>
              </tr>
            </table>
          </td>
          <td align=left valign=bottom width="11%"><b>Vendor Copy</b></td>
        </tr>
       </table>
       </TD>
    </TR>
   </TBODY>
   </TABLE>
</script>

</BODY>
</HTML>

<%}%>

