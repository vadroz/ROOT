<%@ page import="specialorder.SpecOrdList"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String [] sSelType = request.getParameterValues("Type");
   String [] sSelSts = request.getParameterValues("Sts");
   String sPOSts = request.getParameter("POSts");
   String sFrDate = request.getParameter("From");
   String sToDate = request.getParameter("To");
   String sSelAckn = request.getParameter("Ackn");
   String sEmpSls = request.getParameter("EmpSls");
   String [] sSelIss = request.getParameterValues("IssFlg");
   String sSort = request.getParameter("Sort");

   if (sSort == null) { sSort = "STR"; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=SpecOrdLst.jsp&APPL=ALL");
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();

      SpecOrdList spcordl = new SpecOrdList(sSelStr, sSelType, sSelSts, sPOSts, sFrDate
          , sToDate, sSelAckn, sSelIss, sEmpSls, sSort, sUser);

      String sSelStrJsa = spcordl.cvtToJavaScriptArray(sSelStr);
      String sSelTypeJsa = spcordl.cvtToJavaScriptArray(sSelType);
      String sSelStsJsa = spcordl.cvtToJavaScriptArray(sSelSts);
      String sSelIssJsa = spcordl.cvtToJavaScriptArray(sSelIss);
%>

<html>
<head>
<title>Spec Ord List</title>
<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#ccffcc;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { background:red;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable3 { background:#cccfff;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable4 { background:grey; text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#efefef; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:#ccffcc; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left; vertical-align:top}
        td.DataTable1 {padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top}
        td.DataTable1p {background:gray;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:right; vertical-align:top}
        td.DataTable2y {background:#F2F5A9; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:right; vertical-align:top}
        td.DataTable2x {background:yellow; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:right; vertical-align:top}

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150; background-color: white; z-index:10;
              text-align:center; font-size:10px}
                td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}

        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

        .Small {font-size:10px;}
        <!--------------------------------------------------------------------->
</style>




<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var SelStr = [<%=sSelStrJsa%>];
var SelType = [<%=sSelTypeJsa%>];
var SelSts = [<%=sSelStsJsa%>];
var SelIss = [<%=sSelIssJsa%>];
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   setIssFlagDsp();
}
//==============================================================================
// fold/ unfold issue flags
//==============================================================================
function setIssFlagDsp()
{
   var dispFlag = "none";
   var dispAny = "block";

   // fold / unfold top header cell Issue flag
   if(document.all.thIssFlags.colSpan > 1)
   {
      document.all.thIssFlags.colSpan = 1;
      document.all.spnIssFlags.innerHTML = "Issue<br>Flags";
   }
   else
   {
      document.all.thIssFlags.colSpan = 4;
      document.all.spnIssFlags.innerHTML = "Issue Flags <a href='javascript: setIssFlagDsp();'>fold</a>";
      dispFlag = "block";
      dispAny = "none";
   }

   // f/unf flag 1-4
   var cell = document.all.Flag;
   for(var i=0; i < cell.length; i++)
   {
       cell[i].style.display = dispFlag;
   }

   // f-unf substitute flag any
   cell = document.all.FlagAny;
   for(var i=0; i < cell.length; i++)
   {
       cell[i].style.display = dispAny;
   }
}
//==============================================================================
// resort report
//==============================================================================
function resort(sort)
{
   //&POSts=A From=ALLDAYS To=ALLDAYS Ackn=3 EmpSls=B&Str=3&Str=4&Str=5&Str=8&Str=10&Str=11&Str=12&Str=13&Str=20&Str=28&Str=29&Str=30&Str=35&Str=40&Str=42&Str=45&Str=46&Str=50&Str=55&Str=56&Str=59&Str=61&Str=63&Str=64&Str=66&Str=68&Str=70&Str=72&Str=75&Str=76&Str=82&Str=86&Str=87&Str=88&Str=89&Str=90&Str=92&Str=93&Str=96&Str=98&Type=SO&Type=BSSO&Sts=O&IssFlg=N&IssFlg=N&IssFlg=N&IssFlg=N
   var url = "SpecOrdLst.jsp?"

   for(var i=0; i < SelStr.length; i++)  { url += "&Str=" + SelStr[i] }
   for(var i=0; i < SelType.length; i++)  { url += "&Type=" + SelType[i] }
   for(var i=0; i < SelSts.length; i++)  { url += "&Sts=" + SelSts[i] }

   url += "&POSts=<%=sPOSts%>"
   url += "&From=<%=sFrDate%>"
   url += "&To=<%=sToDate%>"
   url += "&Sort=" + sort
   for(var i=0; i < SelIss.length; i++)  { url += "&IssFlg=" + SelIss[i] }
   url += "&Ackn=<%=sSelAckn%>"
   url += "&EmpSls=<%=sEmpSls%>"


   //alert(url)
   window.location.href = url;
}

//==============================================================================
// get comments
//==============================================================================
function getComments(str, ord)
{
   var url = "SpecOrdCommt.jsp?Store=" + str + "&Order=" + ord

   //alert(url)
   window.frame1.location.href = url;
}

//==============================================================================
// show comments
//==============================================================================
function showComments(str, ord, type, commt, cmtUser, cmtDate, cmtTime)
{
   var hdr = "Store &nbsp;" + str + ", Order " + ord;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popComment(type, commt, cmtUser, cmtDate, cmtTime)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.width = 800;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 10;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 80;
   document.all.dvItem.style.visibility = "visible";

}
//==============================================================================
// populate comments panel
//==============================================================================
function popComment(type, commt, cmtUser, cmtDate, cmtTime)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable2'>"
         + "<td class='Prompt1' rowspan=2 width='5%'>Type</td>"
         + "<td class='Prompt1' rowspan=2 >Comments</td>"
         + "<td class='Prompt1' colspan=3 width='10%'>Created</td>"
       + "</tr>"
       + "<tr class='DataTable2'>"
         + "<td class='Prompt1'>User</td>"
         + "<td class='Prompt1'>Date</td>"
         + "<td class='Prompt1'>Time</td>"
       + "</tr>"

  for(var i=0; i < commt.length; i++)
  {
    panel += "<tr class='Prompt'>"
          + "<td class='Prompt1'>" + type[i] + "</td>"
          + "<td class='Prompt'>" + commt[i] + "</td>"
          + "<td class='Prompt1' nowrap>" + cmtUser[i] + "</td>"
          + "<td class='Prompt1' nowrap>" + cmtDate[i] + "</td>"
          + "<td class='Prompt1' nowrap>" + cmtTime[i] + "</td>"
       + "</tr>"
  }

  panel += "<tr><td class='Prompt1' colspan='5'><br><br>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.style.visibility = "hidden";
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>CP POS Order List
        <br>
        <%if(!sFrDate.equals("ALLDAYS")){%>From: <%=sFrDate%>&nbsp;Thru: <%=sToDate%><%}
        else {%>All Days<%}%>
        </b>
      </td>
    </tr>

    <tr>
      <td ALIGN="left" VALIGN="TOP"><%for(int i=0; i < 40; i++){%> &nbsp; <%}%>
      
      <span style="background:red; text-align:center; font-size:12px">&nbsp;*&nbsp;</span>
      <span style="font-size:12px"> - There is a problem with one or more items on this order, click 'D' to display detail items on order.</span>
      <br><%for(int i=0; i < 40; i++){%> &nbsp; <%}%>
      
      <span style="background: #ccffcc; text-align:center; font-size:12px">&nbsp;C&nbsp;</span>
      <span style="font-size:12px"> - There is a new Comment added on this Order (<4 days old).</span>      
    </tr>  
    <tr>
      <td ALIGN="center" VALIGN="TOP"> &nbsp; &nbsp;
     
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="SpecOrdLstSel.jsp?<%=request.getQueryString()%>"><font color="red" size="-1">Select Orders</font></a>&#62;
      <font size="-1">This Page</font> &nbsp; &nbsp; &nbsp; &nbsp;

      <!--a href="javascript: markAll()">Mark All</a -->
  <!----------------------- Order List ------------------------------>
     <table border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable">
         <th class="DataTable" rowspan=2>#</th>
         <th class="DataTable" rowspan=2><a href="javascript: resort('STR')">Str</a></th>
         <th class="DataTable" rowspan=2><a href="javascript: resort('ORD')">Order</a></th>
         <th class="DataTable" rowspan=2><a href="javascript: resort('CUSTID')">Customer Id</a></th>
         <th class="DataTable" rowspan=2><a href="javascript: resort('CUSTNM')">Customer Name</a></th>
         <th class="DataTable" rowspan=2>D<br>t<br>l</th>
         <th class="DataTable" rowspan=2><a href="javascript: resort('ORDDAT')">Order<br>Date</a></th>
         <!--th class="DataTable" rowspan=2>Ticket</th -->
         <th class="DataTable" rowspan=2><a href="javascript: resort('ORDSTS')">Sts</a></th>
         <th class="DataTable" rowspan=2>Div</th>
         <th class="DataTable" rowspan=2>Date<br>Required</th>
         <th class="DataTable" rowspan=2><a href="javascript: resort('ORDTYPE')">Order<br>Type</a></th>
         <th class="DataTable" rowspan=2>Xfer<br>From</th>
         <th class="DataTable" rowspan=2><a href="javascript: resort('ORDTOT')">Order<br>Total</a></th>
         <th class="DataTable4" rowspan=2>&nbsp;</th>
         <th class="DataTable" colspan=2>Customer Paid</th>
         <th class="DataTable4" rowspan=2>&nbsp;</th>
         <th class="DataTable" colspan=2>Vendor Invoiced</th>
         <th class="DataTable4" rowspan=2>&nbsp;</th>

         <th class="DataTable" colspan=2>With Shipping</th>
         <th class="DataTable" colspan=2>Without Shipping</th>

         <th class="DataTable" rowspan=2>C<br>o<br>m<br>m<br>t</th>
         <th class="DataTable" id="thIssFlags" colspan=5><span id="spnIssFlags">Issue Flags</span></th>
         <th class="DataTable2" rowspan=2>A<br>l<br>e<br>r<br>t</th>
         <th class="DataTable2" rowspan=2>Reason</th>
         <th class="DataTable1" colspan=3 nowrap>Order Placed By Buyer</th>
         <th class="DataTable3">DC/ECOM</th>
      </tr>

      <tr class="DataTable">
         <th class="DataTable"><a href="javascript: resort('ORDPAID')">Total<br>Amount<br>Paid</a></th>
         <th class="DataTable" >Shipping<br>(memo)</th>

         <th class="DataTable"><a href="javascript: resort('VENCOST')">Total<br>Cost</a></th>
         <th class="DataTable"><a href="javascript: resort('VENSHIP')">Shipping<br>Charges<br>(memo)</a></th>

         <th class="DataTable"><a href="javascript: resort('GMAMT1')">GM<br>$</a></th>
         <th class="DataTable"><a href="javascript: resort('GMPRC1')">GM<br>%</a></th>
         <!--th class="DataTable"><a href="javascript: resort('GMAMT2')">GM<br>$</a></th>
         <th class="DataTable"><a href="javascript: resort('GMPRC2')">GM<br>%</a></th-->
         <th class="DataTable"><a href="javascript: resort('GMAMT3')">GM<br>$</a></th>
         <th class="DataTable"><a href="javascript: resort('GMPRC3')">GM<br>%</a></th>
         <!--th class="DataTable"><a href="javascript: resort('GMAMT4')">GM<br>$</a></th>
         <th class="DataTable"><a href="javascript: resort('GMPRC4')">GM<br>%</a></th-->

         <th class="DataTable" id="Flag">Cancel</th>
         <th class="DataTable" id="Flag" nowrap>No Shipping</th>
         <th class="DataTable" id="Flag" nowrap>GM% &#60; 40</th>

         <th class="DataTable" id="Flag">Discount</th>
         <th class="DataTable" id="FlagAny"><a href="javascript: setIssFlagDsp();">unfold</a></th>

         <th class="DataTable1" nowrap>Order</th>
         <th class="DataTable1" nowrap>Vendor<br>Order<br>Date</th>
         <th class="DataTable1" nowrap>Shipping<br>Date</th>
         <th class="DataTable3">Carton #</th>
      </tr>
      <TBODY>

      <!----------------------- Order List ------------------------>
 <%
    int iNum = 1;
    while( spcordl.getNext() )
    {
       spcordl.setOrderList();
       int iNumOfOrd = spcordl.getNumOfOrd();
       String [] sStr = spcordl.getStr();
       String [] sOrd = spcordl.getOrd();
       String [] sOrDate = spcordl.getOrDate();
       String [] sTicket = spcordl.getTicket();
       String [] sType = spcordl.getType();
       String [] sStatus = spcordl.getStatus();
       String [] sRevision = spcordl.getRevision();
       int [] iNumOfDiv = spcordl.getNumOfDiv();
       String [][] sDiv = spcordl.getDiv();
       String [] sOrdTotAmt = spcordl.getOrdTotAmt();
       String [] sOrdAmt = spcordl.getOrdAmt();
       String [] sPONum = spcordl.getPONum();
       String [] sAntDate = spcordl.getAntDate();
       String [] sReqDate = spcordl.getReqDate();
       String [] sFromStr = spcordl.getFromStr();
       String [] sCustId = spcordl.getCustId();
       String [] sCustNm = spcordl.getCustNm();
       String [] sShipDt = spcordl.getShipDt();
       String [] sCarton = spcordl.getCarton();
       String [] sAlert = spcordl.getAlert();
       String [] sAlertNm = spcordl.getAlertNm();
       String [] sVenTot = spcordl.getVenTot();
       String [] sVenShpAmt = spcordl.getVenShpAmt();
       String [] sFlag1 = spcordl.getFlag1();
       String [] sFlag2 = spcordl.getFlag2();
       String [] sFlag3 = spcordl.getFlag3();
       String [] sFlag4 = spcordl.getFlag4();
       String [] sShpCost = spcordl.getShpCost();
       String [] sGmPrc1 = spcordl.getGmPrc1();
       String [] sGmAmt1 = spcordl.getGmAmt1();
       String [] sGmPrc2 = spcordl.getGmPrc2();
       String [] sGmAmt2 = spcordl.getGmAmt2();
       String [] sGmPrc3 = spcordl.getGmPrc3();
       String [] sGmAmt3 = spcordl.getGmAmt3();
       String [] sGmPrc4 = spcordl.getGmPrc4();
       String [] sGmAmt4 = spcordl.getGmAmt4();

       String [] sAckn = spcordl.getAckn();
       String [] sFreshCmt = spcordl.getFreshCmt();
  %>
       <%for(int i=0; i < iNumOfOrd; i++, iNum++){%>
       <%boolean bAlert = sAlert[i].equals("1");%>

           <tr  class="DataTable1">
             <td class="DataTable2"><%=iNum%></td>
             <td class="DataTable2"><%=sStr[i]%></td>
             <td class="DataTable2"><%=sOrd[i]%></td>
             <td class="DataTable"><%=sCustId[i]%></td>
             <td class="DataTable"><%=sCustNm[i]%></td>
             <th class="DataTable"><a href="SpecOrdInfo.jsp?Str=<%=sStr[i]%>&Ord=<%=sOrd[i]%>" target="_blank">D</a></th>
             <td class="DataTable"><%=sOrDate[i]%></td>
             <!--td class="DataTable2"><%=sTicket[i]%></td -->
             <td class="DataTable1"><%=sStatus[i]%></td>
             <td class="DataTable">
                <%for(int j=0; j < iNumOfDiv[i]; j++){%><%=sDiv[i][j] + " " %><%}%>
                <%if(iNumOfDiv[i] == 0){%>&nbsp;<%}%>
             </td>
             <td class="DataTable1"><%=sReqDate[i]%></td>
             <td class="DataTable1"><%=sType[i]%></td>
             <td class="DataTable1"><%=sFromStr[i]%></td>
             <td class="DataTable2<%if(sOrdAmt[i].equals(".00")){%>y<%}%>">$<%=sOrdTotAmt[i]%></td>
             <th class="DataTable4">&nbsp;</th>
             <td class="DataTable2<%if(!sOrdAmt[i].equals(".00")){%>x<%}%>">$<%=sOrdAmt[i]%></td>
             <td class="DataTable2">$<%=sShpCost[i]%></td>
             <th class="DataTable4">&nbsp;</th>
             <td class="DataTable2">$<%=sVenTot[i]%></td>
             <td class="DataTable2">$<%=sVenShpAmt[i]%></td>
             <th class="DataTable4">&nbsp;</th>
             <td class="DataTable2<%if(sOrdAmt[i].equals(".00")){%>y<%} else {%>x<%}%>">$<%=sGmAmt1[i]%></td>
             <td class="DataTable2<%if(sOrdAmt[i].equals(".00")){%>y<%} else {%>x<%}%>" nowrap><%=sGmPrc1[i]%>%</td>
             <!--td class="DataTable2<%if(!sOrdAmt[i].equals(".00")){%>x<%}%>">$<%=sGmAmt2[i]%></td>
             <td class="DataTable2<%if(!sOrdAmt[i].equals(".00")){%>x<%}%>" nowrap><%=sGmPrc2[i]%>%</td-->
             <td class="DataTable2<%if(sOrdAmt[i].equals(".00")){%>y<%} else {%>x<%}%>">$<%=sGmAmt3[i]%></td>
             <td class="DataTable2<%if(sOrdAmt[i].equals(".00")){%>y<%} else {%>x<%}%>" nowrap><%=sGmPrc3[i]%>%</td>
             <!--td class="DataTable2<%if(!sOrdAmt[i].equals(".00")){%>x<%}%>">$<%=sGmAmt4[i]%></td>
             <td class="DataTable2<%if(!sOrdAmt[i].equals(".00")){%>x<%}%>" nowrap><%=sGmPrc4[i]%>%</td -->

             <th class="DataTable" <%if(sFreshCmt[i].equals("1")){%>style="background:#ccffcc;"<%}%> ><a href="javascript: getComments('<%=sStr[i]%>','<%=sOrd[i]%>')">C</a></th>

             <td class="DataTable1" id="Flag"><%=sFlag1[i]%></td>
             <td class="DataTable1" id="Flag"><%=sFlag2[i]%></td>
             <td class="DataTable1" id="Flag"><%=sFlag3[i]%></td>
             <td class="DataTable1" id="Flag"><%=sFlag4[i]%></td>
             <td class="DataTable1" id="FlagAny" <%if(sAckn[i].equals("0")){%>style="background:lightpink"<%}%>>
                <%if(sFlag1[i].equals("Y")
                  || sFlag2[i].equals("Y")
                  || sFlag3[i].equals("Y")
                  || sFlag4[i].equals("Y")){%>Y<%}%>
             </td>

             <th class="DataTable" <%if(bAlert){%>style="background:red"<%}%>><%if(bAlert){%>*<%} else {%>&nbsp;<%}%></th>
             <td class="DataTable1"><%=sAlertNm[i]%>&nbsp;</td>
             <td class="DataTable1<%if(sType[i].equals("ST") && sPONum[i].equals("")){%>p<%}%>"><%=sPONum[i]%></td>
             <td class="DataTable1<%if(sType[i].equals("ST") && sAntDate[i].equals("")){%>p<%}%>"><%=sAntDate[i]%></td>
             <td class="DataTable1<%if(sType[i].equals("ST") && sShipDt[i].equals("")){%>p<%}%>"><%=sShipDt[i]%></td>
             <td class="DataTable1"><%=sCarton[i]%></td>
          </tr>
       <%}%>
  <%}%>
     <%
     // repoirt totals
    spcordl.setTotal();
    String sRepOrdAmt = spcordl.getRepOrdAmt();
    String sRepTotAmt = spcordl.getRepTotAmt();
    String sRepShip = spcordl.getRepShip();
    String sRepCost = spcordl.getRepCost();
    String sRepShipCharge = spcordl.getRepShipCharge();
    String sRepGmAmt1 = spcordl.getRepGmAmt1();
    String sRepGmAmt2 = spcordl.getRepGmAmt2();
    String sRepGmAmt3 = spcordl.getRepGmAmt3();
    String sRepGmAmt4 = spcordl.getRepGmAmt4();
     %>
     <tr  class="DataTable">
        <td class="DataTable2">Total</td>
        <td class="DataTable2">&nbsp;</td>
        <td class="DataTable2">&nbsp;</td>
        <td class="DataTable2">&nbsp;</td>
        <td class="DataTable2">&nbsp;</td>
        <th class="DataTable">&nbsp;</th>
        <td class="DataTable2">&nbsp;</td>
        <td class="DataTable2">&nbsp;</td>
        <td class="DataTable2">&nbsp;</td>
        <td class="DataTable2">&nbsp;</td>
        <td class="DataTable2">&nbsp;</td>
        <td class="DataTable2">&nbsp;</td>
        <td class="DataTable2"><%=sRepTotAmt%></td>
        <th class="DataTable4">&nbsp;</th>
        <td class="DataTable2"><%=sRepOrdAmt%></td>
        <td class="DataTable2"><%=sRepShipCharge%></td>
        <th class="DataTable4">&nbsp;</th>
        <td class="DataTable2"><%=sRepCost%></td>
        <td class="DataTable2"><%=sRepShip%></td>
        <th class="DataTable4">&nbsp;</th>
        <td class="DataTable2"><%=sRepGmAmt1%></td>
        <td class="DataTable2">&nbsp;</td>
        <td class="DataTable2"><%=sRepGmAmt3%></td>
        <td class="DataTable2">&nbsp;</td>
        <th class="DataTable">&nbsp;</th>
        <td class="DataTable2">&nbsp;</td>
        <th class="DataTable">&nbsp;</th>
        <td class="DataTable2">&nbsp;</td>
        <td class="DataTable2">&nbsp;</td>
        <td class="DataTable2">&nbsp;</td>
        <td class="DataTable2">&nbsp;</td>
     </tr>

      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>
   <tr>
     <td><br>
  <!------------------------ Acronims --------------------------->
     <table border=1 cellPadding="0" cellSpacing="0" style="background:cornsilk; font-size:12px;">
       <tr>
           <th style="background:#FFCC99;" colspan=2>Order Types</th><th style="background:#FFCC99;" >&nbsp;</th>
           <th style="background:#FFCC99;" colspan=2>Order Statuses</th>
       </tr>
       <tr>
           <th>SO</th><td>Special Order</td><th style="background:#FFCC99;" >&nbsp;</th>
           <th>O</th><td>Open</td>
       </tr>
       <tr>
           <th>BSSO</th><td>Bike Shop Special Order</td><th style="background:#FFCC99;" >&nbsp;</th>
           <th>C</th><td>Closed</td>
       </tr>
       <tr>
           <th>ST</th><td>Special Transfer</td><th style="background:#FFCC99;" >&nbsp;</th>
           <th>X</th><td>Cancelled</td>
       </tr>
       </td>
     </table>
   </tr>
  <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%
    spcordl.disconnect();
    spcordl = null;
%>
<%}%>