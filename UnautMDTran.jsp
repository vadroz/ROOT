<%@ page import="unautmdreport.UnautMDTran , java.util.*"%>
<%
    String sStore = request.getParameter("Store");
    String sDate = request.getParameter("Date");
    String sReg = request.getParameter("Reg");
    String sTrans = request.getParameter("Trans");
    String sFolder = request.getParameter("Folder");

    //System.out.println("1 " + sStore + " 2 " + sReg + " 3 " + sTrans);
    UnautMDTran unauttran = new UnautMDTran(sStore, sDate, sReg, sTrans);
    int iNumOfTrn = unauttran.getNumOfTrn();
    String sDiv = unauttran.getDiv();
    String sDpt = unauttran.getDpt();
    String sCls = unauttran.getCls();
    String sVen = unauttran.getVen();
    String sSty = unauttran.getSty();
    String sClr = unauttran.getClr();
    String sSiz = unauttran.getSiz();
    String sSku = unauttran.getSku();
    String sDesc = unauttran.getDesc();
    String sRet = unauttran.getRet();
    String sCost = unauttran.getCost();
    String sDisc = unauttran.getDisc();
    String sDiscPrc = unauttran.getDiscPrc();
    String sPrice = unauttran.getPrice();
    String sUpc = unauttran.getUpc();
    String sQty = unauttran.getQty();
    String sVenSty = unauttran.getVenSty();
    String sVenNm = unauttran.getVenNm();
    String sClrNm = unauttran.getVenNm();
    String sSizNm = unauttran.getVenNm();

    String sTotRet = unauttran.getTotRet();
    String sTotCost = unauttran.getTotCost();
    String sTotTax = unauttran.getTotTax();
    String sTotTnd = unauttran.getTotTnd();
    String sTotDisc = unauttran.getTotDisc();
    String sTotDiscPrc = unauttran.getTotDiscPrc();
    String sTotAmt = unauttran.getTotAmt();
    String sPhone = unauttran.getPhone();
    String sCrdCard = unauttran.getCrdCard();
    String sOrigReg = unauttran.getOrigReg();
    String sOrigTrn = unauttran.getOrigTrn();
    String sTndName = unauttran.getTndName();
    String sOrdNum = unauttran.getOrdNum();
    String sCoupon = unauttran.getCoupon();
	String sTrackId = unauttran.getTrackId();
	String sReason = unauttran.getReason();
	String sReasonNm = unauttran.getReasonNm();
	String sTotPrc = unauttran.getTotPrc();

    unauttran.disconnect();
    unauttran = null;
%>
<SCRIPT language="JavaScript1.2">
goBack(<%=iNumOfTrn%>, [<%=sDiv%>],[<%=sDpt%>],[<%=sCls%>],[<%=sVen%>],
      [<%=sSty%>], [<%=sClr%>],[<%=sSiz%>],[<%=sSku%>],[<%=sDesc%>],[<%=sRet%>], [<%=sCost%>],
      [<%=sDisc%>], [<%=sDiscPrc%>],[<%=sPrice%>],[<%=sUpc%>],[<%=sQty%>],
      "<%=sTotRet%>", "<%=sTotCost%>", "<%=sTotTax%>", "<%=sTndName%>", "<%=sTotDisc%>", "<%=sTotDiscPrc%>",
      "<%=sTotAmt%>", "<%=sPhone%>", "<%=sCrdCard%>", "<%=sOrigReg%>", "<%=sOrigTrn%>", "<%=sOrdNum%>",
      "<%=sCoupon%>","<%=sTrackId%>", "<%=sReason%>", "<%=sReasonNm%>", "<%=sTotPrc%>"
      ,[<%=sVenSty%>], [<%=sVenNm%>], [<%=sClrNm%>], [<%=sSizNm%>]

      );
//==============================================================================
// send employee availability to schedule
//==============================================================================
function goBack(num, div, dpt, cls, ven, sty, clr, siz, sku, desc, ret, cost, disc, discprc
    , sbprice, upc, qty        		  
    ,  totret, totcost, tottax, tottnd, totdisc, totdiscprc, totamt, phone, crdcard, origreg
    , origtrn, ordnum, coupon, trackid, reason, reasonnm, totprc, vensty, vennm, clrnm, siznm)
{

   var hdr = "Transaction Details. Str: <%=sStore%>, <%=sDate%>, Reg/Tran: <%=sReg%> / <%=sTrans%>";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='../CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popTransPanel(num, div, dpt, cls, ven, sty, clr, siz, sku, desc, ret, cost, disc, discprc, sbprice, upc, qty  
               ,totret, totcost, tottax, tottnd, totdisc, totdiscprc, totamt, phone, crdcard, origreg, origtrn, ordnum
               , coupon, trackid, reason, reasonnm, totprc, vensty, vennm, clrnm, siznm)
     + "</td></tr>"
   + "</table>";

   parent.showTransDetail(html)
}

//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popTransPanel(num, div, dpt, cls, ven, sty, clr, siz, sku, desc, ret, cost, disc, discprc
		, sbprice, upc, qty  
		, totret, totcost, tottax, tottnd, totdisc, totdiscprc, totamt, phone, crdcard , origreg, origtrn, ordnum
		, coupon, trackid, reason, reasonnm, totprc, vensty, vennm, clrnm, siznm)
{
  var dummy = "<table>"

 var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  // Column header
  panel += "<tr><th class='DataTable' rowspan=2>Div</th>"
         + "<th class='DataTable' rowspan=2>Dpt</th>"
         + "<th class='DataTable' rowspan=2 nowrap>Long Sku</th>"
         + "<th class='DataTable' rowspan=2 nowrap>Short Sku</th>"
         + "<th class='DataTable' rowspan=2 nowrap>UPC</th>"
         + "<th class='DataTable' rowspan=2 nowrap>Description</th>"
         + "<th class='DataTable' rowspan=2 nowrap>Vendor<br>Style</th>"
         + "<th class='DataTable' rowspan=2 nowrap>Vendor Name</th>"
         + "<th class='DataTable' rowspan=2 nowrap>Color<br>Name</th>"
         + "<th class='DataTable' rowspan=2 nowrap>Size<br>Name</th>"
         + "<th class='DataTable' rowspan=2>Auth<br>Price</th>"
         + "<th class='DataTable' rowspan=2>Qty</th>"
         + "<th class='DataTable' rowspan=2>Sold For</th>"
         //+ "<th class='DataTable' rowspan=2>Cost</th>"
         + "<th class='DataTable' colspan=2>Discount</th>"
        + "</tr>"
        + "<tr><th class='DataTable'>Amount</th>"
        + "<th class='DataTable'>%</th>"
        + "</tr>"

  for(var i=0; i < num; i++)
  {
     panel += "<tr class='Detail'><td class='Prompt'>" + div[i] + "</td>"
            + "<td class='Prompt'>" + dpt[i] + "</td>"
            + "<td class='Prompt' nowrap>" + cls[i] + "-" + ven[i] + "-" + sty[i] + "-" + clr[i] + "-" + siz[i] + "</td>"
            + "<td class='Prompt'>" + sku[i] + "</td>"
            + "<td class='Prompt'>" + upc[i] + "</td>"
            + "<td class='Prompt' nowrap>" + desc[i] + "</td>"
            + "<td class='Prompt' nowrap>" + vensty[i] + "</td>"
            + "<td class='Prompt' nowrap>" + vennm[i] + "</td>"
            + "<td class='Prompt' nowrap>" + clrnm[i] + "</td>"
            + "<td class='Prompt' nowrap>" + siznm[i] + "</td>"
            + "<td class='Prompt2' nowrap>" + sbprice[i] + "</td>"
            + "<td class='Prompt2' nowrap>" + qty[i] + "</td>"
            + "<td class='Prompt2' nowrap>" + ret[i] + "</td>"
            + "<td class='Prompt2'>" + disc[i] + "</td>"
            + "<td class='Prompt2'>" + discprc[i] + "%</td>"
           + "</tr>"
  }

  panel += "<tr class='Total'>"
            + "<td class='Prompt2' colspan=12>Subtotal</td>"
            + "<td class='Prompt2' colspan=2>" + totprc + "</td>"
            + "<td class='Prompt'>&nbsp;</td>"
           + "</tr>"
           
           + "<tr class='Total'>"
           + "<td class='Prompt2' colspan=12>Discount</td>"
           + "<td class='Prompt2' colspan=2>" + totdisc + "</td>"
           + "<td class='Prompt2' nowrap>" + totdiscprc + "%</td>"
          + "</tr>"
          
          + "<tr class='Total'>"
         	+ "<td class='Prompt2' colspan=10>Reason: " + reason + "-" + reasonnm 
         	     + "&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Coupon: " + coupon + " - " + trackid
         	+ "</td>"
         	+ "<td class='Prompt' colspan=2>&nbsp;</td>"
         	+ "<td class='Prompt' colspan=3>&nbsp;</td>"          	
          + "</tr>"
          
          + "<tr class='Total'>"
          + "<td class='Prompt2' colspan=12>Net Sales</td>"
          + "<td class='Prompt2' colspan=2>" + totret + "</td>"
          + "<td class='Prompt'>&nbsp;</td>"
         + "</tr>"
         
           + "<tr class='Total'>"
            + "<td class='Prompt2' colspan=12>Tax</td>"
            + "<td class='Prompt2' colspan=2>" + tottax + "</td>"
            + "<td class='Prompt'>&nbsp;</td>"
           + "</tr>"

           + "<tr class='Total'>"
            + "<td class='Prompt2' colspan=12>Total</td>"
            + "<td class='Prompt2' colspan=2>" + totamt + "</td>"
            + "<td class='Prompt'>&nbsp;</td>"
           + "</tr>"

           + "<tr class='Total'>"
            + "<td class='Prompt2' colspan=12>Tender Type</td>"
            + "<td class='Prompt' colspan=2>" + tottnd + "</td>"
            + "<td class='Prompt'>&nbsp;</td>"
           + "</tr>"
           
          /* + "<tr class='Total'>"
           + "<td class='Prompt2' colspan=12>Account Number:</td>"
           + "<td class='Prompt' colspan=2>" + crdcard + "</td>"
           + "<td class='Prompt'>&nbsp;</td>"
          + "</tr>"
           */
           + "<tr class='Total'>"
            + "<td class='Prompt2' colspan=12>CP POS Order/Layaway #</td>"
            + "<td class='Prompt' colspan=2>" + ordnum + "</td>"
            + "<td class='Prompt'>&nbsp;</td>"
           + "</tr>"

           + "<tr class='Total'>"
            + "<td class='Prompt2' colspan=12>Phone Number:</td>"
           ; 
            
   <%if(sFolder == null){%>panel += "<td class='Prompt' colspan=2><a href='searchcust.SrchCustPurchase?PHONE="+ phone + "&SUBMIT=Submit'>" + phone + "</a></td>"<%}
   else {%>panel += "<td class='Prompt' colspan=2><a href='servlet/searchcust.SrchCustPurchase?PHONE="+ phone + "&SUBMIT=Submit'>" + phone + "</a></td>"<%}%>
   panel += "<td class='Prompt'>&nbsp;</td>"
           + "</tr>"

           

           + "<tr class='Total'>"
            + "<td class='Prompt2' colspan=12>Original Register:</td>"
            + "<td class='Prompt' colspan=2>" + origreg + "</td>"
            + "<td class='Prompt'>&nbsp;</td>"
           + "</tr>"

           + "<tr class='Total'>"
            + "<td class='Prompt2' colspan=12>Original Transaction:</td>"
            + "<td class='Prompt' colspan=2>" + origtrn + "</td>"
            + "<td class='Prompt'>&nbsp;</td>"
           + "</tr>"

  // buttons
  panel += "<tr><td class='Prompt1' colspan='15'>"
        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;&nbsp;&nbsp;"

  panel += "</td></tr></table>";

  return panel;
}
</SCRIPT>







