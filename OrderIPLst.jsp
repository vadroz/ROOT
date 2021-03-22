<%@ page import="patiosales.OrderIPLst ,java.util.*, java.text.*"%>
<%
   String sOrder = request.getParameter("Order");

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=OrderIPLst.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      OrderIPLst ordlst = new OrderIPLst(sOrder, session.getAttribute("USER").toString());
      int iNumOfSls = ordlst.getNumOfSls();
      int iNumOfOrd = ordlst.getNumOfOrd();
%>

<html>
<head>
<title>Patio_Furniture_Trial_List</title>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: MistyRose; font-family:Arial; font-size:10px }
        tr.Divider { background:darkred; font-family:Arial; font-size:1px }

        td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right;}
        td.DataTable2 {border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        td.DataTable3 { color: red; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left; font-weight:bold; font-size:12px }

        td.DataTable20 {cursor: hand; background: MistyRose; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable21 {cursor: hand; background: Lavender; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

         td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:left;}
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
//==============================================================================
// found sku in IP sales data
//==============================================================================
function foundSku(sku)
{
   ipsku = document.all.tdIpSku;
   ipchk = document.all.tdIpChk;

   for(var i=0; i < ipsku.length; i++)
   {
      if(ipsku[i].innerHTML == sku)  {ipchk[i].innerHTML="==>"}
      else {ipchk[i].innerHTML=""}
   }
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
      <b>Retail Concepts, Inc
      <br>Patio Furniture - Island Pacific Sales
      <br>Order: <%=sOrder%></b></td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<br>
    <!----------------------- ECommerce Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbECItem">
       <tr  class="DataTable">
        <th class="DataTable" nowrap colspan=4>E-Commerce</th>
      </tr>

      <tr class="DataTable">
        <th class="DataTable" nowrap>SKU</th>
        <th class="DataTable" nowrap>Item<br>Qty</th>
        <th class="DataTable" nowrap>Item<br>Retail</th>
        <th class="DataTable" nowrap>Description</th>
      </tr>
      <TBODY>

      <!----------------------- ECommerce Order List ------------------------>
  <%for(int i=0; i < iNumOfOrd; i++) {%>
    <%
       ordlst.setECSls();
       String sOrdSku = ordlst.getOrdSku();
       String sOrdQty = ordlst.getOrdQty();
       String sOrdRet = ordlst.getOrdRet();
       String sOrdDesc = ordlst.getOrdDesc();
       String sOrdMatch = ordlst.getOrdMatch();
    %>
        <tr  class="DataTable">
           <td id="tdPfSku" onclick="foundSku('<%=sOrdSku%>')" class="DataTable2<%=sOrdMatch%>" nowrap><%=sOrdSku%></td>
           <td class="DataTable2" nowrap><%=sOrdQty%></td>
           <td class="DataTable2" nowrap><%=sOrdRet%></td>
           <td class="DataTable"><%=sOrdDesc%></td>
        </tr>
      <%}%>
      <!---------------------------------------------------------------------->
      </TBODY>
    </table><br>
  <!----------------------- end of table ------------------------>
  </tr>
  <tr><td nowrap style="text-align:left; font-size:12px">
    <span style="background: Lavender; border: darkred solid 1px; width:20px;
       text-align:left">0001234567</span> - A Matching SKU is found. &nbsp;&nbsp;&nbsp;
    <span style="background: MistyRose; border: darkred solid 1px; width:20px;
       text-align:left">0001234567</span> - A Matching SKU is not found.
  </tr>
  <!----------------------- IP Order List ------------------------------>
  <tr>
      <td ALIGN="center" VALIGN="TOP"><br>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbIPItem">
       <tr  class="DataTable">
        <th class="DataTable" nowrap rowspan=2>&nbsp;</th>
        <th class="DataTable" nowrap colspan=9>Island Pacific Information</th>
      </tr>

      <tr class="DataTable">
        <th class="DataTable" nowrap>SKU</th>
        <th class="DataTable" nowrap>Reg<br>#</th>
        <th class="DataTable" nowrap>Trans<br>#</th>
        <th class="DataTable" nowrap>Item<br>Qty</th>
        <th class="DataTable" nowrap>Item<br>Retail</th>
        <th class="DataTable" nowrap>Cashier</th>
        <th class="DataTable" nowrap>Salesperson</th>
        <th class="DataTable" nowrap>Sales<br>Time</th>
        <th class="DataTable" nowrap>Description</th>
      </tr>
      <TBODY>

      <!----------------------- Order List ------------------------>
  <%for(int i=0; i < iNumOfSls; i++) {%>
    <%
      ordlst.setIpSls();
      String sIpeSku = ordlst.getIpeSku();
       String sIpeReg = ordlst.getIpeReg();
       String sIpeTran = ordlst.getIpeTran();
       String sIpeQty = ordlst.getIpeQty();
       String sIpeRet = ordlst.getIpeRet();
       String sIpeCsh = ordlst.getIpeCsh();
       String sIpeCshName = ordlst.getIpeCshName();
       String sIpeSlsman = ordlst.getIpeSlsman();
       String sIpeSlsName = ordlst.getIpeSlsName();
       String sIpeTime = ordlst.getIpeTime();
       String sIpeDesc = ordlst.getIpeDesc();
       String sIpeMatch = ordlst.getIpeMatch();
    %>
        <tr  class="DataTable">
           <td id="tdIpChk" class="DataTable3" nowrap></td>
           <td id="tdIpSku" class="DataTable2<%=sIpeMatch%>" nowrap><%=sIpeSku%></td>
           <td class="DataTable2" nowrap><%=sIpeReg%></td>
           <td class="DataTable2" nowrap><%=sIpeTran%></td>
           <td class="DataTable2" nowrap><%=sIpeQty%></td>
           <td class="DataTable2" nowrap><%=sIpeRet%></td>
           <td class="DataTable" nowrap><%=sIpeCsh + " " + sIpeCshName%></td>
           <td class="DataTable" nowrap><%=sIpeSlsman + " " + sIpeSlsName%></td>
           <td class="DataTable"><%=sIpeTime%></td>
           <td class="DataTable"><%=sIpeDesc%></td>
        </tr>
      <%}%>
      <!---------------------------------------------------------------------->
      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
        <button onclick="window.close()">Close</button>
     </td>
   </tr>

  </table>
 </body>
</html>
<%
   ordlst.disconnect();
}%>