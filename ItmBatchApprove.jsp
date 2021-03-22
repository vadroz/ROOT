<%@ page import="itemtransfer.ItmBatchApprove, java.util.*"%>
<%
   String sBatch = request.getParameter("Batch");
   String sBComment = request.getParameter("BComment");
   String sSts = request.getParameter("Sts");

   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sStrAllowed = "";

   if (session.getAttribute("USER")==null || session.getAttribute("TRANSFER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=ItmBatchApprove.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {

     sStrAllowed = session.getAttribute("STORE").toString().trim();
     if (!sStrAllowed.startsWith("ALL"))
     {
        response.sendRedirect("index.jsp");
     }

     String sUser = session.getAttribute("USER").toString();
     ItmBatchApprove itrfapprv = new ItmBatchApprove(sBatch, sSts, sUser);

     int iNumOfStr = itrfapprv.getNumOfStr();
     String [] sStr = itrfapprv.getStr();

     int iNumOfCls = itrfapprv.getNumOfCls();
     String [] sDiv = itrfapprv.getDiv();
     String [] sDivNm = itrfapprv.getDivNm();
     String [] sCls = itrfapprv.getCls();
     String [] sClsNm = itrfapprv.getClsNm();
     String [][] sInQty = itrfapprv.getInQty();
     String [][] sOutQty = itrfapprv.getOutQty();
     String [][] sInStock = itrfapprv.getInStock();
     String [][] sLess = itrfapprv.getLess();

     String [] sTotInQty = itrfapprv.getTotInQty();
     String [] sTotOutQty = itrfapprv.getTotOutQty();
     String [] sTotInRet = itrfapprv.getTotInRet();
     String [] sTotOutRet = itrfapprv.getTotOutRet();
     boolean bAllow = itrfapprv.getAllow();
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                        border-top: darkred double; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:seashell; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable01 { background:pink; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px;
                        padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                        border-top: darkred double; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        text-align:right;}
        td.DataTable3 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                        border-top: darkred double; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        text-align:left;}
        <!------------------------------------------------->
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {font-size:10px; }
        <!------------------------------------------------->

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
function bodyLoad()
{
}
//--------------------------------------------------------
// Change Transfers Status to approved
//--------------------------------------------------------
function chgStatus(sts)
{
   var url = "ItemTrfEnt.jsp?"
    + "Batch=<%=sBatch%>"

    if(sts=="A") url += "&ACTION=APPROVE";
    if(sts=="S") url += "&ACTION=SENT";


   if(confirm("Are You Sure?????"))
   {
     //alert(url)
     //window.location.href = url;
     window.frame1.location = url;
   }
   else
   {
     document.all.APPROVE.checked=false;
   }
}

//==============================================================================
// show number in stock
//==============================================================================
function showStock(stock)
{
   msg = "The inventory summary for this class is " + stock + " - less than must be distributed."
       + "\nThe number of transfered items must be less or equal number in warehouse."
   alert(msg)
}
</SCRIPT>


</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">

      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Transfer Request Approvals
      <br>Batch: <%=sBComment%> &nbsp;&nbsp;&nbsp;&nbsp;
          Status:
            <%if(sSts.equals("O")){%>Pending<%}
            else if(sSts.equals("A")){%>Approve<%}
            else if(sSts.equals("S")){%>Sent<%}%>
          </b>
     <tr bgColor="moccasin">
      <td ALIGN="left" VALIGN="TOP">

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="ItmBatchApproveSel.jsp">
         <font color="red" size="-1">Select Report</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp
      <!-------------------------------------------------------------------->
      <%if(sSts.equals("O") && session.getAttribute("TRFAPPRV")!=null && bAllow){%>
          <input name="APPROVE" type="checkbox" onclick="chgStatus('A')"> Approve
      <%}%>

      <!-------------------------------------------------------------------->
      </td>
     </tr>


     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
<!-------------------------------------------------------------------->
  <!----------------- beginning of table ------------------------>
  <table class="DataTable" cellPadding="0" cellSpacing="0" width="100%">
    <tr>
      <th class="DataTable" rowspan="3">Class</th>
      <th class="DataTable" rowspan="3">&nbsp;</th>
      <th class="DataTable" colspan="<%=(iNumOfStr * 2)%>">Stores</th>
    </tr>

      <tr>
        <%for(int i=0; i<iNumOfStr; i++){%>
           <th class="DataTable" colspan="2"><%=sStr[i]%></th>
       <%}%>
     </tr>
     <tr>
        <%for(int i=0; i<iNumOfStr; i++){%>
           <th class="DataTable">&nbsp;&nbsp;In&nbsp;&nbsp;</th>
           <th class="DataTable">Out</th>
       <%}%>
     </tr>
<!------------------------------- Detail Data --------------------------------->
    <%for(int i=0; i<iNumOfCls; i++){%>
      <tr class="DataTable">
         <td class="DataTable1" rowspan="2" nowrap width="10%">
               <%=sCls[i] + " - " + sClsNm[i]%>
         </td>
         <th class="DataTable">+</th>
      <!-- Class In count-->
        <%for(int j=0; j<iNumOfStr; j++) {%>
          <td class="DataTable1" colspan="2"><%if(!sInQty[i][j].equals("0")){%><%=sInQty[i][j]%><%}%>&nbsp;</td>
        <%}%>
      </tr>

      <!-- Class Out count-->
      <tr class="DataTable">
      <th class="DataTable">-</th>
        <%for(int j=0; j<iNumOfStr; j++) {%>
           <td class="DataTable<%if(sLess[i][j].equals("1")){%>01<%}%>" colspan="2">
             <%if(sLess[i][j].equals("1")){%>
                 <a href="javascript: showStock('<%=sInStock[i][j]%>')"><%=sOutQty[i][j]%></a><%}
               else{%>
                 <%if(!sOutQty[i][j].trim().equals("0")){%><%=sOutQty[i][j]%><%}%><%}%>
           </td>
        <%}%>
      </tr>
    <%}%>
<!---------------------------- end of Detail data ----------------------------->
<!-------------------------------- Total data --------------------------------->
   <tr class="DataTable1">
     <td class="DataTable2" rowspan="2" nowrap width="10%">Unit Totals</td>
        <th class="DataTable1">+</th>
      <!-- Class In count-->
        <%for(int i=0; i<iNumOfStr; i++) {%>
          <td class="DataTable3" colspan="2"><%=sTotInQty[i]%></td>
        <%}%>
   </tr>
   <!-- Class Out count-->
   <tr class="DataTable1">
     <th class="DataTable">-</th>
     <%for(int i=0; i<iNumOfStr; i++) {%>
        <td class="DataTable"  colspan="2"><%=sTotOutQty[i]%></td>
     <%}%>
   </tr>
   <tr class="DataTable2">
     <td class="DataTable2" rowspan="2" nowrap width="10%">Retail Totals</td>
        <th class="DataTable1">+</th>
      <!-- Class In count-->
        <%for(int i=0; i<iNumOfStr; i++) {%>
          <td class="DataTable3"  colspan="2"><%if(!sTotInRet[i].equals("")){%>$<%}%><%=sTotInRet[i]%></td>
        <%}%>
   </tr>
   <!-- Class Out count-->
   <tr class="DataTable2">
     <th class="DataTable">-</th>
     <%for(int i=0; i<iNumOfStr; i++) {%>
        <td class="DataTable"  colspan="2"><%if(!sTotOutRet[i].equals("")){%>$<%}%><%=sTotOutRet[i]%></td>
     <%}%>
   </tr>
<!---------------------------- end of Total data ------------------------------>
 </table>
 <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%
    itrfapprv.disconnect();
   } %>