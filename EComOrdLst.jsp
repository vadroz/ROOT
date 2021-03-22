<%@ page import="ecommerce.EComOrdLst"%>
<%
    String [] sStatus = request.getParameterValues("Sts");
    String sOrdFrDate = request.getParameter("OrdFrDate");
    String sOrdToDate = request.getParameter("OrdToDate");
    String sShpFrDate = request.getParameter("ShpFrDate");
    String sShpToDate = request.getParameter("ShpToDate");
    String sSort = request.getParameter("Sort");

    if(sSort==null) sSort = "ORDER";
//----------------------------------
// Application Authorization
//----------------------------------
//if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComOrdLst.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    EComOrdLst ordLst = new EComOrdLst(sStatus, sOrdFrDate, sOrdToDate, sShpFrDate, sShpToDate, sSort, sUser);
    int iNumOfOrd = ordLst.getNumOfOrd();
%>
<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:green; font-size:10px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}

        tr.DataTable0 { background: #E7E7E7; font-size:10px }
        tr.DataTable1 { background: yellow; font-size:10px }
        tr.DataTable2 { background: red; font-size:10px }
        tr.DataTable3 { background: cornsilk; font-size:10px }

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

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

</style>


<script name="javascript1.2">
var NumOfOrd = <%=iNumOfOrd%>;
var Used = false;
var SbmCmd = new Array();
var SbmLoop = 0;
var SbmQty = 0;
var SelCol=null;
var SelCell = new Array(NumOfOrd);

var Sts = new Array();
<%for(int i=0; i < sStatus.length; i++){%>Sts[<%=i%>]= "<%=sStatus[i]%>";<%}%>

var OrdFrDate = "<%=sOrdFrDate%>";
var OrdToDate = "<%=sOrdToDate%>";
var ShpFrDate = "<%=sShpFrDate%>";
var ShpToDate = "<%=sShpToDate%>";
//------------------------------------------------------------------------------


//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
//--------------------------------------------------------
// resort table
//--------------------------------------------------------
function resort(sort)
{
  url = "EComOrdLst.jsp?Sort=" + sort
  for(var i=0; i < Sts.length;  i++)
  {
     url += "&Sts=" + Sts[i];
  }
  url += "&OrdFrDate=" + OrdFrDate;
  url += "&OrdToDate=" + OrdToDate;
  url += "&ShpFrDate=" + ShpFrDate;
  url += "&ShpToDate=" + ShpToDate;

  window.location.href=url;
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
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>E-Commerce Order List
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="EComOrdLstSel.jsp" class="small"><font color="red">Select</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0">
         <tr class="DataTable">
             <th class="DataTable" rowspan=2><a href="javascript: resort('ORD')">Order<br>#</a></th>
             <th class="DataTable"rowspan=2>Cust<br>#</th>
             <th class="DataTable" colspan=4>Billing</th>
             <th class="DataTable"rowspan=2><a href="javascript: resort('PAYAMT')">Payment<br>Amount</a></th>
             <th class="DataTable"rowspan=2><a href="javascript: resort('SHPCOST')">Shipping<br>Cost</a></th>
             <th class="DataTable"rowspan=2><a href="javascript: resort('PAYRCV')">Total<br>Payment<br>Received</a></th>
             <th class="DataTable"rowspan=2><a href="javascript: resort('PAYAUTH')">Total<br>Payment<br>Authorized</a></th>
             <th class="DataTable"rowspan=2><a href="javascript: resort('TAX')">Tax</a></th>
             <th class="DataTable"rowspan=2><a href="javascript: resort('TENDER')">Tender</a></th>
             <th class="DataTable"rowspan=2><a href="javascript: resort('ORDSTS')">Order<br>Status</a></th>
             <th class="DataTable"rowspan=2><a href="javascript: resort('SHPDATE')">Shiping<br>Date</a></th>
             <th class="DataTable"rowspan=2><a href="javascript: resort('SHIPPED')">Shipped</a></th>
             <th class="DataTable"rowspan=2><a href="javascript: resort('SHPRES')">Ship<br>Residential</a></th>
             <th class="DataTable"rowspan=2><a href="javascript: resort('ORDDATE')">Order<br>Date</a></th>
             <th class="DataTable"rowspan=2><a href="javascript: resort('PICK')">Pick<br>Ticket<br>Created</a></th>
             <th class="DataTable"rowspan=2><a href="javascript: resort('IPENT')">IP<br>Entry</a></th>
             <th class="DataTable"rowspan=2><a href="javascript: resort('SHPSTATE')">Ship<br>State</a></th>
          </tr>
          <tr class="DataTable">
             <th class="DataTable"><a href="javascript: resort('BCOMP')">Company</a></th>
             <th class="DataTable"><a href="javascript: resort('BFIRST')">First<br>Name</a></th>
             <th class="DataTable"><a href="javascript: resort('BLAST')">Last<br>Name</a></th>
             <th class="DataTable"><a href="javascript: resort('BPHN')">Phone<br>Number</a></th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfOrd; i++ )
         {
            ordLst.setDetail();
            String sOrd = ordLst.getOrd();
            String sCust = ordLst.getCust();
            String sBillComp = ordLst.getBillComp();
            String sBillFNam = ordLst.getBillFNam();
            String sBillLNam = ordLst.getBillLNam();
            String sBillPhn = ordLst.getBillPhn();
            String sTotPayRcv = ordLst.getTotPayRcv();
            String sTotPayAuth = ordLst.getTotPayAuth();
            String sTax = ordLst.getTax();
            String sOrdSts = ordLst.getOrdSts();
            String sShipDate = ordLst.getShipDate();
            String sShipped = ordLst.getShipped();
            String sShipRes = ordLst.getShipRes();
            String sOrdDate = ordLst.getOrdDate();
            String sPickTick = ordLst.getPickTick();
            String sIPSls = ordLst.getIPSls();
            String sLineClr = ordLst.getLineClr();
            String sPayAmt = ordLst.getPayAmt();
            String sShipCost = ordLst.getShipCost();
            String sTender = ordLst.getTender();
            String sShipSt = ordLst.getShipSt();
            String sSite = ordLst.getSite();
       %>
         <tr class="DataTable<%=sLineClr%>">
            <td class="DataTable2" nowrap><a href="EComOrdInfo.jsp?Site=<%=sSite%>&Order=<%=sOrd%>"><%=sOrd%></a></td>
            <td class="DataTable2" nowrap><%=sCust%></td>
            <td class="DataTable1" nowrap><%=sBillComp%></td>
            <td class="DataTable1" nowrap><%=sBillFNam%></td>
            <td class="DataTable1" nowrap><%=sBillLNam%></td>
            <td class="DataTable1" nowrap><%=sBillPhn%></td>
            <td class="DataTable2" nowrap><%=sPayAmt%></td>
            <td class="DataTable2" nowrap><%=sShipCost%></td>
            <td class="DataTable2" nowrap><%=sTotPayRcv%></td>
            <td class="DataTable2" nowrap><%=sTotPayAuth%></td>
            <td class="DataTable2" nowrap><%=sTax%></td>
            <td class="DataTable2" nowrap><%=sTender%></td>
            <td class="DataTable1" nowrap><%=sOrdSts%></td>
            <td class="DataTable" nowrap><%=sShipDate%></td>
            <td class="DataTable" nowrap><%=sShipped%></td>
            <td class="DataTable" nowrap><%=sShipRes%></td>
            <td class="DataTable" nowrap><%=sOrdDate%></td>
            <td class="DataTable" nowrap><%=sPickTick%></td>
            <td class="DataTable" nowrap><%=sIPSls%></td>
            <td class="DataTable" nowrap><%=sShipSt%></td>
          </tr>
       <%}%>
       <!-- ========================= Total ================================ -->
       <%
          ordLst.setTotal();
          String sOrdNum = ordLst.getOrdNum();
          String sRepPayAmt = ordLst.getRepPayAmt();
          String sRepShipCost = ordLst.getRepShipCost();
          String sRepTax = ordLst.getRepTax();
          String sProcSls = ordLst.getProcSls();
       %>
       <tr class="DataTable3">
          <td class="DataTable" nowrap># of Ord<br><%=sOrdNum%></td>
          <td class="DataTable" colspan=5>&nbsp;</td>
          <td class="DataTable" nowrap>$<%=sRepPayAmt%></td>
          <td class="DataTable" nowrap>$<%=sRepShipCost%></td>
          <td class="DataTable" colspan=2>&nbsp;</td>
          <td class="DataTable" nowrap>$<%=sRepTax%></td>
          <td class="DataTable" colspan=7>&nbsp;</td>
          <td class="DataTable" nowrap># of Proc<br><%=sProcSls%></td>
          <td class="DataTable">&nbsp;</td>
       </tr>
     </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   ordLst.disconnect();
   }
%>