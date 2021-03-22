<%@ page import="dcfrtbill.DCCtnItem, java.util.*"%>
<%

   String sAppl = null;

   if(session.getAttribute("DCFRTBILL") != null) sAppl = session.getAttribute("DCFRTBILL").toString();

   String sCarton = request.getParameter("Carton");
   String sStore = request.getParameter("STORE");
   String sFromDate = request.getParameter("FromDate");
   String sToDate = request.getParameter("ToDate");
   String sSort = request.getParameter("Sort");
   String sFrtBill = request.getParameter("FrtBill");
   String sAllowToClose = request.getParameter("AllowToClose");

   System.out.println(sStore + " " + sFromDate + " " + sToDate + " " + sCarton + " " + sFrtBill + " " + sSort);

   if (sCarton==null) sCarton = " ";
   if (sFrtBill==null) sFrtBill = " ";
   else { sFrtBill.trim(); }
   if (sStore==null) sStore = " ";
   if (sFromDate==null) sFromDate = " ";
   if (sToDate==null) sToDate = " ";
   if (sSort==null) sSort = "CARTON";
   if (sAllowToClose==null) sAllowToClose="N";

   System.out.println(sStore + " " + sFromDate + " " + sToDate + " " + sCarton + " " + sFrtBill + " " + sSort);

   DCCtnItem ctnItm = new DCCtnItem(sStore, sFromDate, sToDate, sCarton, sFrtBill, sSort);
   int iNumOfItm = ctnItm.getNumOfItm();


%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.Row { background:lightgrey; font-family:Arial; font-size:10px }
        tr.Row1 { background:Cornsilk; font-family:Arial; font-size:10px }
        tr.Row2 { background:Azure; font-family:Arial; font-size:10px }

        td.Cell { padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:left;}
        td.Cell1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:right;}

        td.Cell2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                 padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                 text-align:Center;}

        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
function bodyLoad()
{
   window.focus();
}
</SCRIPT>


</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------------------->
    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
<!-------------------------------------------------------------------------------->
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>
         <%if(sStore.trim().equals("")){%>Item List for Carton <%=sCarton%><%}
         else {%>Item List for Store <%=sStore%><%}%>
          </b>
     </tr>
<!-------------------------------------------------------------------->
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" colspan=4>

      <%if(sAllowToClose.equals("Y")){%><a href="javascript:window.close()">Close</a>&nbsp;&nbsp;&nbsp;<%}%>
      <a href="javascript:window.print()">Print</a>


<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
            <th class="DataTable">Issuing<br>Store</th>
            <th class="DataTable">Destination<br>Store</th>
            <th class="DataTable">Pick<br>Sheet<br>Number</th>
            <th class="DataTable">Date of<br>Distribution</th>

            <%if(!sStore.trim().equals("")){%>
               <th class="DataTable"><a href="DstCtnItem.jsp?Sort=CARTON&Carton=<%=sCarton%>&FrtBill=<%=sFrtBill%>&STORE=<%=sStore%>&FromDate=<%=sFromDate%>&ToDate=<%=sToDate%>&AllowToClose=<%=sAllowToClose%>">Carton<br>#</a></th>
            <%}%>
            <th class="DataTable"><a href="DstCtnItem.jsp?Sort=DIVISION&Carton=<%=sCarton%>&FrtBill=<%=sFrtBill%>&STORE=<%=sStore%>&FromDate=<%=sFromDate%>&ToDate=<%=sToDate%>&AllowToClose=<%=sAllowToClose%>">Div<br>#</a></th>
            <th class="DataTable">Dpt<br>#</th>
            <th class="DataTable">Class Name</th>
            <th class="DataTable">Class-Ven-Sty</th>
            <th class="DataTable">Item<br>Description</th>
            <th class="DataTable">Color</th>
            <th class="DataTable">Size</th>
            <th class="DataTable"><a href="DstCtnItem.jsp?Sort=VENDOR&Carton=<%=sCarton%>&FrtBill=<%=sFrtBill%>&STORE=<%=sStore%>&FromDate=<%=sFromDate%>&ToDate=<%=sToDate%>&AllowToClose=<%=sAllowToClose%>">Vendor Name</a></th>
            <th class="DataTable">Vendor Style</th>

            <th class="DataTable">Short<br>SKU</th>
            <th class="DataTable">UPC</th>
            <th class="DataTable">Picked<br>Qty</th>
            <%if(sAppl != null) {%>
               <!-- th class="DataTable">Item<br>Cost</th -->
               <!--  th class="DataTable">Extended<br>Cost</th -->
               <th class="DataTable">Item<br>Ret</th>
               <th class="DataTable">Extended<br>Ret</th>
            <%}%>
        </tr>
<!------------------------------- Data Detail --------------------------------->
        <%if(sStore.trim().equals("")) iNumOfItm += -1;
          for(int i=0; i < iNumOfItm; i++) {
            ctnItm.setItems();

            String sDiv = ctnItm.getDiv();
            String sDpt = ctnItm.getDpt();
            String sCls = ctnItm.getCls();
            String sVen = ctnItm.getVen();
            String sSty = ctnItm.getSty();
            String sClr = ctnItm.getClr();
            String sSiz = ctnItm.getSiz();
            String sDesc = ctnItm.getDesc();
            String sSku = ctnItm.getSku();
            String sUpc = ctnItm.getUpc();
            String sVenName = ctnItm.getVenName();
            String sVenSty = ctnItm.getVenSty();
            String sQty = ctnItm.getQty();
            String sClrName = ctnItm.getClrName();
            String sSizName = ctnItm.getSizName();
            String sDetail = ctnItm.getDetail();
            String sCtn = ctnItm.getCtn();
            String sClsName = ctnItm.getClsName();
            String sCost = ctnItm.getCost();
            String sXCost = ctnItm.getXCost();
            String sRet = ctnItm.getRet();
            String sXRet = ctnItm.getXRet();
            String sIStr = ctnItm.getIStr();
            String sDStr = ctnItm.getDStr();
            String sPick = ctnItm.getPick();
            String sDsDate = ctnItm.getDsDate();

        %>
             <tr class="<%if(sDetail.equals("0")){%>Row<%} else if(sDetail.equals("1")) {%>Row1<%} else {%>Row2<%}%>">

               <td class="Cell1" nowrap><%=sIStr%></td>
               <td class="Cell1" nowrap><%=sDStr%></td>
               <td class="Cell1" nowrap><%=sPick%></td>
               <td class="Cell1" nowrap><%=sDsDate%></td>

               <%if(!sStore.trim().equals("")){%>
                  <td class="Cell" nowrap><%=sCtn%></td>
               <%}%>
               <td class="Cell" nowrap><%=sDiv%></td>
               <td class="Cell" nowrap><%=sDpt%></td>
               <td class="Cell" nowrap><%=sClsName%></td>
               <td class="Cell" nowrap>
                   <%if(sDetail.equals("0")){%><%=sCls%>-<%=sVen%>-<%=sSty%><%}%></td>
               <td class="Cell" nowrap><%=sDesc%></td>
               <td class="Cell" nowrap><%=sClrName%></td>
               <td class="Cell" nowrap><%=sSizName%></td>
               <td class="Cell" nowrap><%=sVenName%></td>
               <td class="Cell" nowrap><%=sVenSty%></td>
               <td class="Cell" nowrap><%=sSku%></td>
               <td class="Cell" nowrap><%=sUpc%></td>
               <td class="Cell1" nowrap><%=sQty%></td>
               <%if(sAppl != null) {%>
                  <!-- td class="Cell1" nowrap><%=sCost%></td -->
                  <!-- td class="Cell1" nowrap><%=sXCost%></td -->
                  <td class="Cell1" nowrap><%=sRet%></td>
                  <td class="Cell1" nowrap><%=sXRet%></td>
               <%}%>
            </tr>
        <%}%>
        </tr>
     </table>
<!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%ctnItm.disconnect();%>