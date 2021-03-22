<%@ page import="ecommerce.EComNegInv"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComNegInv.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    EComNegInv itemlst = new EComNegInv(sUser);

%>
<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { padding- top:3px; padding-bottom:3px; text-align:center; font-size:11px;}

        tr.DataTable { background: #E7E7E7; font-size:10px }
        tr.DataTable0 { background: red; font-size:10px }
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

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
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

</style>


<script name="javascript1.3">
//------------------------------------------------------------------------------
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
        <BR>E-Commerce Item with Negative Inventory
        </B>

        <br><a href="../" class="small"><font color="red">Home</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
             <th class="DataTable" rowspan=2>Div</th>
             <th class="DataTable" rowspan=2>Dpt</th>
             <th class="DataTable" rowspan=2>Item Long Number</th>
             <th class="DataTable" rowspan=2>Sku</th>
             <th class="DataTable" rowspan=2>Description</th>
             <th class="DataTable" rowspan=2>Vendor Style</th>
             <th class="DataTable" rowspan=2>Inventory</th>
             <th class="DataTable" rowspan=2>Stock</th>
             <th class="DataTable" rowspan=2>&nbsp;</th>
             <th class="DataTable" colspan=2>1</th>
             <th class="DataTable" rowspan=2>&nbsp;</th>
             <th class="DataTable" colspan=2>2</th>
             <th class="DataTable" rowspan=2>&nbsp;</th>
             <th class="DataTable" colspan=2>3</th>
         </tr>
         <tr class="DataTable">
            <%for(int i=0; i < 3; i++){%>
              <th class="DataTable">Order</th>
              <th class="DataTable">Shipped</th>
            <%}%>
         </tr>
       <!-- ============================ Details =========================== -->
       <% while(itemlst.getNext()) {
            itemlst.setItemList();
            int iNumOfItm = itemlst.getNumOfItm();
            String [] sDiv = itemlst.getDiv();
            String [] sDpt = itemlst.getDpt();
            String [] sCls = itemlst.getCls();
            String [] sVen = itemlst.getVen();
            String [] sSty = itemlst.getSty();
            String [] sClr = itemlst.getClr();
            String [] sSiz = itemlst.getSiz();
            String [] sSku = itemlst.getSku();
            String [] sDesc = itemlst.getDesc();
            String [] sVenSty = itemlst.getVenSty();
            String [] sInv70 = itemlst.getInv70();
            String [] sStock70 = itemlst.getStock70();
            String [][] sOrd = itemlst.getOrd();
            String [][] sShipDt = itemlst.getShipDt();

            for(int i=0; i < iNumOfItm; i++ ) {
       %>
          <tr class="DataTable">
            <td class="DataTable2" nowrap><%=sDiv[i]%></td>
            <td class="DataTable2" nowrap><%=sDpt[i]%></td>
            <td class="DataTable2" nowrap><%=sCls[i] + "-" + sVen[i] + "-" + sSty[i] + "-" + sClr[i] + "-" + sSiz[i]%></td>
            <td class="DataTable2" nowrap><%=sSku[i]%></td>
            <td class="DataTable1" nowrap><%=sDesc[i]%></td>
            <td class="DataTable1" nowrap><%=sVenSty[i]%></td>
            <td class="DataTable2" nowrap><%=sInv70[i]%></td>
            <td class="DataTable2" nowrap><%=sStock70[i]%></td>
            <%for(int j=0; j < 3; j++){%>
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable" nowrap><%=sOrd[i][j]%></td>
               <td class="DataTable" nowrap><%=sShipDt[i][j]%></td>
            <%}%>
          </tr>
          <%}%>
       <%}%>
       <!---------------------------- Total ------------------------------- -->
     </table>

      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   itemlst.disconnect();
   itemlst = null;
   }
%>