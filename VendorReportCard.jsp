<%@ page import="vendorcard.VendorReportCard"%>
<%
    String sVen = request.getParameter("Ven");
    String sVenName = request.getParameter("VenName");
    String sFromMon = request.getParameter("From");
    String sToMon = request.getParameter("To");
    String sFromDt = request.getParameter("FromDt");
    String sToDt = request.getParameter("ToDt");
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=VendorReportCard.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();

    VendorReportCard vencard = new VendorReportCard(sVen, sFromMon, sToMon, sFromDt, sToDt, "vrozen");
    int iNumOfDiv = vencard.getNumOfDiv();

    int iNumOfPO = vencard.getNumOfPO();
    String [] sRtvCost = vencard.getRtvCost();
    String [] sRtvPrcCost = vencard.getRtvPrcCost();

    int iNumOfVcl = vencard.getNumOfVcl();
    String sTckByVen = vencard.getTckByVen();
    String sTckByRci = vencard.getTckByRci();
%>
<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:white;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}

        tr.DataTable { background: white; font-size:10px }
        tr.DataTable1 { background: CornSilk; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

</style>


<script name="javascript1.2">
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
}

</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Vendor Performance Card
        <br>Vendor: <%=sVenName%>
        <br>From <%=sFromDt%> Trough <%=sToDt%>
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="VendorReportCardSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-- =================== Performance by Division =========================== -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
             <th class="DataTable" rowspan=2>Division</th>
             <th class="DataTable" colspan=2>Sales</th>
             <th class="DataTable" colspan=2>Purchase @ Cost</th>
             <th class="DataTable" colspan=2>Ending Inv @ Cost</th>
             <th class="DataTable" rowspan=2>MMU</th>
             <th class="DataTable" rowspan=2>IMU</th>
             <th class="DataTable" rowspan=2>GMROI</th>
             <th class="DataTable" rowspan=2>Selloff</th>
         </tr>
         <tr class="DataTable">
             <th class="DataTable">$</th>
             <th class="DataTable">% of Tot</th>
             <th class="DataTable">$</th>
             <th class="DataTable">% of Tot</th>
             <th class="DataTable">$</th>
             <th class="DataTable">% of Tot</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfDiv; i++ )
         {
           vencard.setDivDetail(true);
           String sDiv = vencard.getDiv();
           String sDivName = vencard.getDivName();
           String sDivSls = vencard.getDivSls();
           String sDivSlsPrc = vencard.getDivSlsPrc();
           String sDivPurchCost = vencard.getDivPurchCost();
           String sDivPOPrc = vencard.getDivPOPrc();
           String sDivCost = vencard.getDivCost();
           String sDivCostPrc = vencard.getDivCostPrc();
           String sDivMarkdwn = vencard.getDivMarkdwn();
           String sDivEIC = vencard.getDivEIC();
           String sDivEICPrc = vencard.getDivEICPrc();
           String sDivEIR = vencard.getDivEIR();
           String sDivMMU = vencard.getDivMMU();
           String sDivIMU = vencard.getDivIMU();
           String sDivGMROI = vencard.getDivGMROI();
           String sDivSelloff = vencard.getDivSelloff();
       %>
         <tr id="trItem" class="DataTable">
            <td class="DataTable1" nowrap><%=sDiv + " - " + sDivName%></td>
            <td class="DataTable2" nowrap>$<%=sDivSls%></td>
            <td class="DataTable2" nowrap><%=sDivSlsPrc%>%</td>
            <td class="DataTable2" nowrap>$<%=sDivPurchCost%></td>
            <td class="DataTable2" nowrap><%=sDivPOPrc%>%</td>
            <td class="DataTable2" nowrap>$<%=sDivEIC%></td>
            <td class="DataTable2" nowrap><%=sDivEICPrc%>%</td>
            <td class="DataTable2" nowrap><%=sDivMMU%></td>
            <td class="DataTable2" nowrap><%=sDivIMU%></td>
            <td class="DataTable2" nowrap><%=sDivGMROI%></td>
            <td class="DataTable2" nowrap><%=sDivSelloff%></td>
          </tr>
       <%}%>

       <!-- ============================= Total ============================ -->
       <%
           vencard.setDivDetail(false);
           String sDiv = vencard.getDiv();
           String sDivName = vencard.getDivName();
           String sDivSls = vencard.getDivSls();
           String sDivSlsPrc = vencard.getDivSlsPrc();
           String sDivPurchCost = vencard.getDivPurchCost();
           String sDivPOPrc = vencard.getDivPOPrc();
           String sDivCost = vencard.getDivCost();
           String sDivCostPrc = vencard.getDivCostPrc();
           String sDivMarkdwn = vencard.getDivMarkdwn();
           String sDivEIC = vencard.getDivEIC();
           String sDivEICPrc = vencard.getDivEICPrc();
           String sDivEIR = vencard.getDivEIR();
           String sDivMMU = vencard.getDivMMU();
           String sDivIMU = vencard.getDivIMU();
           String sDivGMROI = vencard.getDivGMROI();
           String sDivSelloff = vencard.getDivSelloff();
       %>
         <tr id="trItem" class="DataTable1">
            <td class="DataTable1" nowrap>Total</td>
            <td class="DataTable2" nowrap>$<%=sDivSls%></td>
            <td class="DataTable2" nowrap>&nbsp;</td>
            <td class="DataTable2" nowrap>$<%=sDivPurchCost%></td>
            <td class="DataTable2" nowrap>&nbsp;</td>
            <td class="DataTable2" nowrap>$<%=sDivEIC%></td>
            <td class="DataTable2" nowrap>&nbsp;</td>
            <td class="DataTable2" nowrap><%=sDivMMU%></td>
            <td class="DataTable2" nowrap><%=sDivIMU%></td>
            <td class="DataTable2" nowrap><%=sDivGMROI%></td>
            <td class="DataTable2" nowrap><%=sDivSelloff%></td>
          </tr>

     </table>
<!-- ======================================================================= -->
<br>
   <!-- =================== Performance by PO =========================== -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbPO">
         <tr class="DataTable">
             <th class="DataTable" rowspan=2>PO #</th>
             <th class="DataTable" colspan=2>Purchase Order</th>
             <th class="DataTable" colspan=2>Received</th>
             <th class="DataTable" colspan=2>Rec'd % to PO</th>
             <th class="DataTable" rowspan=2># of Received</th>
             <th class="DataTable" colspan=3>Freight Cost</th>
             <th class="DataTable" colspan=3>Chargebacks</th>
         </tr>
         <tr class="DataTable">
             <th class="DataTable">Cost</th>
             <th class="DataTable">Units</th>
             <th class="DataTable">Cost</th>
             <th class="DataTable">Units</th>
             <th class="DataTable">Cost</th>
             <th class="DataTable">Units</th>
             <th class="DataTable">Free</th>
             <th class="DataTable">Prpaid</th>
             <th class="DataTable">Cost</th>
             <th class="DataTable">% to PO</th>
             <th class="DataTable">Charged</th>
             <th class="DataTable">Refund</th>
         </tr>
   <!-- ========================= Purchase Order =========================== -->
       <%for(int i=0; i < iNumOfPO; i++ )
         {
           vencard.setPODetail(true);
           String sPONum = vencard.getPONum();
           String sPOCost = vencard.getPOCost();
           String sPOUnit = vencard.getPOUnit();
           String sPORcvCost = vencard.getPORcvCost();
           String sPORcvUnit = vencard.getPORcvUnit();
           String sPOPrcCost = vencard.getPOPrcCost();
           String sPOPrcUnit = vencard.getPOPrcUnit();
           String sPOReceived = vencard.getPOReceived();
           String sPOFree = vencard.getPOFree();
           String sPOPrepaid = vencard.getPOPrepaid();
       %>
         <tr id="trItem" class="DataTable">
            <td class="DataTable1" nowrap><%=sPONum%></td>
            <td class="DataTable2" nowrap>$<%=sPOCost%></td>
            <td class="DataTable2" nowrap><%=sPOUnit%></td>
            <td class="DataTable2" nowrap>$<%=sPORcvCost%></td>
            <td class="DataTable2" nowrap><%=sPORcvUnit%></td>
            <td class="DataTable2" nowrap><%=sPOPrcCost%>%</td>
            <td class="DataTable2" nowrap><%=sPOPrcUnit%>%</td>
            <td class="DataTable2" nowrap><%=sPOReceived%></td>
            <td class="DataTable" nowrap><%=sPOFree%></td>
            <td class="DataTable" nowrap><%=sPOPrepaid%></td>
            <td class="DataTable" nowrap>&nbsp;</td>
            <td class="DataTable" nowrap>&nbsp;</td>
            <td class="DataTable" nowrap>&nbsp;</td>
            <td class="DataTable" nowrap>&nbsp;</td>
          </tr>
       <%}%>

       <!-- ============================= Total ============================ -->
       <%
           vencard.setPODetail(false);
           String sPONum = vencard.getPONum();
           String sPOCost = vencard.getPOCost();
           String sPOUnit = vencard.getPOUnit();
           String sPORcvCost = vencard.getPORcvCost();
           String sPORcvUnit = vencard.getPORcvUnit();
           String sPOPrcCost = vencard.getPOPrcCost();
           String sPOPrcUnit = vencard.getPOPrcUnit();
           String sPOReceived = vencard.getPOReceived();
           String sPOFree = vencard.getPOFree();
           String sPOPrepaid = vencard.getPOPrepaid();
           String sPOFrtCost = vencard.getPOFrtCost();
           String sPOPrcFrtCost = vencard.getPOPrcFrtCost();
           String sPORefund = vencard.getPORefund();
           String sPOCharged = vencard.getPOCharged();
       %>
         <tr id="trItem" class="DataTable1">
            <td class="DataTable1" nowrap>Total</td>
            <td class="DataTable2" nowrap>$<%=sPOCost%></td>
            <td class="DataTable2" nowrap><%=sPOUnit%></td>
            <td class="DataTable2" nowrap>$<%=sPORcvCost%></td>
            <td class="DataTable2" nowrap><%=sPORcvUnit%></td>
            <td class="DataTable2" nowrap><%=sPOPrcCost%>%</td>
            <td class="DataTable2" nowrap><%=sPOPrcUnit%>%</td>
            <td class="DataTable2" nowrap><%=sPOReceived%></td>
            <td class="DataTable" nowrap>&nbsp;</td>
            <td class="DataTable" nowrap>&nbsp;</td>
            <td class="DataTable" nowrap>$<%=sPOFrtCost%></td>
            <td class="DataTable" nowrap><%=sPOPrcFrtCost%>%</td>
            <td class="DataTable" nowrap>$<%=sPOCharged%></td>
            <td class="DataTable" nowrap>$<%=sPORefund%></td>
          </tr>

     </table>
<!-- ======================================================================= -->
<br>
  <!-- =================== Violation code List  =========================== -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbPO">
         <tr class="DataTable">
             <th class="DataTable" colspan=3>Violation Code Counts</th>
         </tr>
         <tr class="DataTable">
             <th class="DataTable">Code</th>
             <th class="DataTable">Desc</th>
             <th class="DataTable">Qty</th>
         </tr>
   <!-- ========================= Purchase Order =========================== -->
       <%for(int i=0; i < iNumOfVcl; i++ )
         {
           vencard.setVCLDetail();
           String sVclCode = vencard.getVclCode();
           String sVclDesc = vencard.getVclDesc();
           String sVclQty = vencard.getVclQty();
       %>
         <tr id="trItem" class="DataTable">
            <td class="DataTable1" nowrap><%=sVclCode%></td>
            <td class="DataTable1" nowrap><%=sVclDesc%></td>
            <td class="DataTable1" nowrap><%=sVclQty%></td>
          </tr>
       <%}%>
      </table>
<br>
    <!-- =================== Performance by RTV =========================== -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtv">
         <tr class="DataTable">
             <th class="DataTable" rowspan=2>Defectives</th>
             <th class="DataTable" colspan=2>Cost</th>
         </tr>
         <tr class="DataTable">
             <th class="DataTable">$</th>
             <th class="DataTable">% of purchase</th>
         </tr>
       <!-- ================================================================ -->
       <tr id="trItem" class="DataTable">
            <td class="DataTable1" nowrap>Return To Vendor</td>
            <td class="DataTable2" nowrap>$<%=sRtvCost[0]%></td>
            <td class="DataTable2" nowrap><%=sRtvPrcCost[0]%>%</td>
       </tr>
       <tr id="trItem" class="DataTable">
            <td class="DataTable1" nowrap>Mark Out of Stock</td>
            <td class="DataTable2" nowrap>$<%=sRtvCost[1]%></td>
            <td class="DataTable2" nowrap><%=sRtvPrcCost[1]%>%</td>
       </tr>
       <tr id="trItem" class="DataTable">
            <td class="DataTable1" nowrap>Administrative Charges</td>
            <td class="DataTable2" nowrap>$<%=sRtvCost[2]%></td>
            <td class="DataTable2" nowrap><%=sRtvPrcCost[2]%>%</td>
       </tr>
       <tr id="trItem" class="DataTable1">
            <td class="DataTable1" nowrap>Total</td>
            <td class="DataTable2" nowrap>$<%=sRtvCost[3]%></td>
            <td class="DataTable2" nowrap><%=sRtvPrcCost[3]%>%</td>
       </tr>
     </table>
     <br>
     <!-- ======================= Ticketing ================================ -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtv">
         <tr class="DataTable">
             <th class="DataTable" colspan=2>Ticketing</th>
         </tr>
         <tr class="DataTable">
             <td class="DataTable1">By Vendor</td>
             <td class="DataTable"><%=sTckByVen%></td>
         </tr>
         <tr class="DataTable">
             <td class="DataTable1">By RCI</td>
             <td class="DataTable"><%=sTckByRci%></td>
         </tr>
       </table>
     <!-- ================================================================== -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   vencard.disconnect();
   }
%>