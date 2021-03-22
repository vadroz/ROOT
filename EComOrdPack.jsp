<%@ page import="ecommerce.EComOrdPack"%>
<%
   String sSelSite = request.getParameter("Site");
   String sSelOrd = request.getParameter("Order");

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=EComOrdPack.jsp&APPL=ALL");
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();

      EComOrdPack orpack = new EComOrdPack(sSelSite, sSelOrd);
      String sSite = orpack.getSite();
      String sOrd = orpack.getOrd();
      String sBComp = orpack.getBComp();
      String sBFirstName = orpack.getBFirstName();
      String sBLastName = orpack.getBLastName();
      String sBAddr1 = orpack.getBAddr1();
      String sBAddr2 = orpack.getBAddr2();
      String sBCity = orpack.getBCity();
      String sBState = orpack.getBState();
      String sBZip = orpack.getBZip();
      String sBCntry = orpack.getBCntry();
      String sBPhn = orpack.getBPhn();
      String sPayAmt = orpack.getPayAmt();
      String sPayMethod = orpack.getPayMethod();
      String sOrdDate  = orpack.getOrdDate ();
      String sCredCardlast = orpack.getCredCardlast();
      String sComment = orpack.getComment();

      int iNumOfItm = orpack.getNumOfItm();
      String [] sCls = orpack.getCls();
      String [] sVen = orpack.getVen();
      String [] sSty = orpack.getSty();
      String [] sClr = orpack.getClr();
      String [] sSiz = orpack.getSiz();
      String [] sSku = orpack.getSku();
      String [] sDesc = orpack.getDesc();
      String [] sOrdQty = orpack.getOrdQty();
      String [] sSent = orpack.getSent();
      String [] sSentQty = orpack.getSentQty();
      String [] sCarton = orpack.getCarton();
%>

<html>
<head>

<style>body {background:white; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable {border: none}

        th.DataTable { background:lightgrey; border-right:1px solid white;
                       padding-top:5px; padding-top:5px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { text-align:left; font-size:12px; font-weight:bolder }
        th.DataTable2 { text-align:left; font-size:16px; font-weight:bolder }

        tr.DataTable {  font-family:Arial; font-size:10px }
        tr.DataTable1 {  font-family:Arial; font-size:12px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left; vertical-align:top}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:right; vertical-align:top}
        <!--------------------------------------------------------------------->
</style>


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
}

</SCRIPT>

</head>
<body onload="bodyLoad()">
<div style="position:absolute;">
 <%if(sSite.equals("SASS")){%><img src="/Logo/sns.bmp" width="170px" height="50px">
 <%} else if(sSite.equals("SKCH")){%><img src="/Logo/sc.bmp" width="160px" height="50px">
 <%} else if(sSite.equals("SSTP")){%><img src="/Logo/ss.bmp" width="160px" height="50px">
 <%} else if(sSite.equals("RLHD")){%><img src="/Logo/railhead.bmp" width="160px" height="50px">
 <%}%>
</div>

    <table border="0" cellPadding="0"  cellSpacing="0" height=100%>
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>Order Pack Slip
        <br>Order: <%=sSite%> <%=sOrd%>
        </b>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">

     <!------------------ order date, Payment, Comments ----------------------->
     <table border=0 cellPadding="0" width="100%" cellSpacing="0">
       <tr class="DataTable">
         <th class="DataTable1" nowrap>Order Date:</th><td><%=sOrdDate%></td>
         <th class="DataTable1" rowspan=2>Order Comments: </th><td rowspan=2><%=sComment%></td>
      </tr>
      <tr class="DataTable">
         <th class="DataTable1" nowrap>Payment Method</th><td><%=sPayMethod%> ****<%=sCredCardlast%></td>
     </table>
     <br>
     <!-------------------- Bill to name and address--------------------------->
     <table border=0 cellPadding="0"  cellSpacing="0">
       <tr class="DataTable1"><th class="DataTable2" ><%=sBFirstName%> <%=sBLastName%></th></tr>
       <tr class="DataTable1"><th class="DataTable2" ><%=sBAddr1%></th></tr>
       <tr class="DataTable1"><th class="DataTable2" ><%=sBAddr2%></th></tr>
       <tr class="DataTable1"><th class="DataTable2" ><%=sBCity%>, <%=sBState%> <%=sBZip%></th></tr>
       <tr class="DataTable1"><th class="DataTable2" ><%=sBCntry%></th></tr>
       <tr class="DataTable1"><th class="DataTable2" ><%=sBPhn%></th></tr>
     </table>
     <br>

  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable">
         <th class="DataTable" nowrap>Product Name/ Color / Size </th>
         <th class="DataTable" nowrap>Long SKU</th>
         <th class="DataTable" nowrap>Short SKU</th>
         <th class="DataTable" nowrap>Qty</th>
         <th class="DataTable" nowrap>Carton</th>
      </tr>

      <!----------------------- Order Item List ------------------------>
      <%for(int i=0; i < iNumOfItm; i++){%>
          <tr  class="DataTable1">
            <td class="DataTable"><%=sDesc[i]%></td>
            <td class="DataTable1"><%=sCls[i] + "-" + sVen[i] + "-" + sSty[i] + "-" + sClr[i] + "-" + sSiz[i]%></td>
            <td class="DataTable1"><%=sSku[i]%></td>
            <td class="DataTable2"><%if(sSent[i].equals("1")){%><%=sSentQty[i]%><%} else {%><%=sOrdQty[i]%><%}%></td>
            <td class="DataTable1"><%if(sSent[i].equals("1")){%><%=sCarton[i]%><%} else {%>Not sent from DC<%}%></td>
          </tr>
      <%}%>

      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>
   <tr>
     <td style="vertical-align: bottom; font-size=10px">
         <b>Thank you for shopping at
           <%if(sSite.equals("SASS")){%>Sun & Ski Sports!
           <%} else if(sSite.equals("SKCH")){%>Ski Chalet!
           <%} else if(sSite.equals("SSTP")){%>Ski Stop
           <%} else if(sSite.equals("RLHD")){%>RailHead Board Sports
           <%}%>

         </b>.
         <br>RETURN / EXCHANGE INSTRUCTIONS
         <br>1. Visit
           <%if(sSite.equals("SASS")){%>http://www.sunandski.com/returns
           <%} else if(sSite.equals("SKCH")){%>http://www.skichalet.com/returns
           <%} else if(sSite.equals("SSTP")){%>http://www.skistop.com/returns
           <%} else if(sSite.equals("RLHD")){%> http://www.railheadboards.com/returns
           <%}%>

          to access the return form on our website. 2. Click the PDF icon on the page and print the form to your printer. (You will need Adobe Acrobat) 3. Fill out the return form including your order number and the items to be returned. 4. Put the return form in the box with your item(s) to return.
         <br>5. Send your return package insured using your choice of package carrier. 6. Send to: Returns Department, 10560 Bissonnet St. Suite 100, Houston, TX 77099 USA
         <br>We process returns within 7 business days of receipt. In order to make an exchange, please follow the above returns process, then place a new order for the items you would like. We handle all exchanges as separate invoices. Your return will be credited to your credit card and any new order will be a new charge. If you received a product that was damaged in shipping or misshipped, please call 866-786-3869, contact us on live chat or send an email to customerservice@retailconcepts.cc. Please include your order number found on this packing slip on all correspondence.
         <br>NOTE: Your order may be shipped in multiple boxes.
     </td>
   </tr>
  </table>
 </body>
</html>
<%
    orpack.disconnect();
    orpack = null;
%>
<%}%>