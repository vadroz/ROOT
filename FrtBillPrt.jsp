<%@ page import="dcfrtbill.FrtBillPrt, java.util.*, java.text.*"%>
<%
    String sFrtB = request.getParameter("FrtB").trim();

    FrtBillPrt frbPrt = new FrtBillPrt(sFrtB);
    int iNumOfPlt = frbPrt.getNumOfPlt();
    int iNumOfCtn = frbPrt.getNumOfCtn();

    String sStr = frbPrt.getStr();
    String sCarrier = frbPrt.getCarrier();
    String sSts = frbPrt.getSts();
    String sShipDt = frbPrt.getShipDt();
    String sComment = frbPrt.getComment();
    String sFbNumPlt = frbPrt.getFbNumPlt();
    String sFbNumCtn = frbPrt.getFbNumCtn();
    String sFbNumItm = frbPrt.getFbNumItm();
    int iNumOfFbDiv = frbPrt.getNumOfFbDiv();
    String [] sFbDiv = frbPrt.getFbDiv();
    String [] sFbDivName = frbPrt.getFbDivName();

    String [] sPlt = frbPrt.getPlt();
    String [] sNumCtn = frbPrt.getNumCtn();
    int [] iFrArg = frbPrt.getFrArg();
    int [] iToArg = frbPrt.getToArg();
    String [] sPltWgt = frbPrt.getPltWgt();

    String [] sCtn = frbPrt.getCtn();
    String [] sWgt = frbPrt.getWgt();
    String [] sItmQty = frbPrt.getItmQty();
    String [] sDesc = frbPrt.getDesc();
    int [] iNumOfDiv = frbPrt.getNumOfDiv();
    String [][] sDiv = frbPrt.getDiv();
    String [] sFrom = frbPrt.getFrom();

    frbPrt.disconnect();
    String sStatus = "Shipped";
    if(sSts.equals("O")) sStatus = "Opened";
%>

<html>
<head>

<!-- --------------- Date Selection prompt ----------------------- -->
<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<style>body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: black solid 1px; text-align:center; font-size:12px; font-family:Arial;}
        table.DataTable1 { border: none; text-align:center; font-size:12px; font-family:Arial;}
        th.DataTable { padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                       border-bottom: black solid 1px;border-right: black solid 1px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                       text-align:left; font-family:Verdanda; font-size:12px }

        th.DataTable2 { padding-top:0px; padding-bottom:0px; padding-right:0px; padding-left:0px;
                        border-right: black solid 5px;
                       font-size:1px }

        td.DataTable { border-bottom: black solid 1px;border-right: black solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                       text-align:left;}
        td.DataTable1 { border-bottom: black solid 1px;border-right: black solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                       text-align:center;}
        td.DataTable2 { border-bottom: black solid 1px;border-right: black solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                       text-align:right;}


        td.Grid { text-align:center;}


        p.reg {text-align:center; font-family:Arial; font-size:10px}

</style>


<SCRIPT language="JavaScript">
//--------------- Global variables -----------------------
//--------------- End of Global variables -----------------------
function bodyLoad()
{
}
</SCRIPT>

</head>
<!-------------------------------------------------------------------->
<body onload="bodyLoad();">
<div id="tooltip2" style="border: black solid 3px; position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>

    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
       <b>Sun & Ski Sports<br>
        <br><font size="+1">Freight Bill Manifest</font>
        <br>Freight Bill: <%=sFrtB%><br><br>
       </b>
       <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
       <a href="DcFrtBill.jsp"><font color="red" size="-1">Selection</font></a>&#62;
       <font size="-1">This Page.</font><br>
     </tr>
     <tr>
      <td ALIGN="center" VALIGN="TOP">
      <%if(!sStr.trim().equals("")){%>
      <!----------------- Palets ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
           <td class="DataTable">Store</th>
           <td class="DataTable1"><%=sStr%></th>
           <td class="DataTable">Carrier</th>
           <td class="DataTable1"><%=sCarrier%></th>
         </tr>
         <tr>
           <td class="DataTable">Status</th>
           <td class="DataTable1"><%=sStatus%></th>
           <td class="DataTable">Shipping Date</th>
           <td class="DataTable1"><%=sShipDt%></th>
         </tr>
         <tr>
           <td class="DataTable">Comment:&nbsp;</th>
           <td class="DataTable" colspan="3"><%=sComment%>&nbsp;&nbsp;</th>
         </tr>
         <tr>
           <td class="DataTable">Number of Pallets</td>
           <td class="DataTable1"><%=sFbNumPlt%></td>
           <td class="DataTable">Number of Cartons</td>
           <td class="DataTable1"><%=sFbNumCtn%></td>
         </tr>
         <tr>
           <td class="DataTable">Total Qty:&nbsp;</td>
           <td class="DataTable1" colspan="3"><%=sFbNumItm%>&nbsp;</td>
         </tr>
         <tr>
           <td class="DataTable">Divisions:</td>
           <td class="DataTable1" colspan="3">
             <%for(int l=0; l < iNumOfFbDiv; l++){%><%=sFbDiv[l] + " "%><%}%>&nbsp;
           </td>
         </tr>
      </table>
      <br><br>
      <!----------------- ----- ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <%for(int i=0; i < iNumOfPlt; i++ ){%>
           <tr>
             <!----------------- Palets ------------------------>
             <th class="DataTable" colspan="6">Pallet</th>
             <th class="DataTable" colspan="3">Number of<br>Cartons</th>
             <th class="DataTable" colspan="2">Weight</th>
           </tr>
           <tr>
             <th class="DataTable" colspan="6"><%=sPlt[i]%></th>
             <td class="DataTable1" colspan="3"><%=sNumCtn[i]%></td>
             <th class="DataTable" colspan="2"><%=sPltWgt[i]%></th>
           </tr>
           <tr><th class="DataTable" colspan="11">Cartons</th></tr>
           <!----------------- Cartons ------------------------>
            <tr>
                  <th class="DataTable">Carton</th>
                  <th class="DataTable">From</th>

                  <th class="DataTable">Item<br>Quantity</th>
                  <th class="DataTable">Description</th>
                  <th class="DataTable">Divisions</th>
                  <th class="DataTable2">&nbsp;</th>
                  <th class="DataTable">Carton</th>
                  <th class="DataTable">From</th>
                  <th class="DataTable">Item<br>Quantity</th>
                  <th class="DataTable">Description</th>
                  <th class="DataTable">Divisions</th>
               </tr>

               <%
                  boolean bNext = true;
                  for(int j=iFrArg[i]-1; j < iToArg[i]; j++)
                  {
               %>
                  <%if(bNext){%><tr><%}%>
                    <td class="DataTable"><%=sCtn[j]%></td>
                    <td class="DataTable"><%=sFrom[j]%></td>
                    <td class="DataTable2">&nbsp;<%=sItmQty[j]%></td>
                    <td class="DataTable"><%=sDesc[j]%>&nbsp;</td>
                    <td class="DataTable"><%for(int l=0; l < iNumOfDiv[j]; l++){%><%=sDiv[j][l] + " "%><%}%>&nbsp;</td>
                    <%if(bNext) {%><th class="DataTable2">&nbsp;</th><%}%>

                  <%if(bNext && j==iToArg[i]-1) {%><td class="DataTable1" colspan="5">---</td><%}%>
                  <%if(!bNext || j==iToArg[i]-1) {%></tr><%}%>
                  <%bNext = !bNext;%>
                  <%}%>
                  <tr><td class="DataTable1" colspan="11">&nbsp;</td></tr>
              <%}%>
              </table>
            </td>
           </tr>

           <tr><th class="DataTable1"><u>Division List:</u>
                 <%for(int l=0; l < iNumOfFbDiv; l++){%><%="<br>" + sFbDiv[l] + " - " + sFbDivName[l]%><%}%>
               </th>
           </tr>
      <%}
      else {%><br><b>Not Found</b><%}%>


  </table>
 </body>
</html>
