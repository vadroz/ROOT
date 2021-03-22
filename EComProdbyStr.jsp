<%@ page import="ecommerce.EComProdbyStr"%>
<%
    String sSelStr = request.getParameter("Str");
    String sSelDiv = request.getParameter("Div");
    String sSelDpt = request.getParameter("Dpt");
    String sSelCls = request.getParameter("Cls");
    String sSelVen = request.getParameter("Ven");
    String sMinQty = request.getParameter("MinQty");
    String sSort = request.getParameter("Sort");

    if(sSort == null){ sSort = "SKUASCN"; }

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComProdbyStr.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    //System.out.println(sSelStr + "|" + sSelDiv + "|" + sSelDpt + "|" + sSelCls + "|" + sSelVen + "|" + sMinQty + "|" + sSort + "|" + sUser);
    EComProdbyStr prodlst = new EComProdbyStr(sSelStr, sSelDiv, sSelDpt, sSelCls
                    , sSelVen, sMinQty, sSort, sUser);

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
        <BR>E-Commerce Attributed Products w/o StockList
        </B>

        <br><a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="EComProdbyStrSel.jsp" class="small"><font color="red">Select</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
             <th class="DataTable">Div</th>
             <th class="DataTable">Dpt</th>
             <th class="DataTable">Item Long Number</th>
             <th class="DataTable">Store<br>Inventory</th>
             <th class="DataTable">Product<br>Price</th>
             <th class="DataTable">Sales<br>Price</th>
             <th class="DataTable">Vendor Name</th>
             <th class="DataTable">Name</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%while(prodlst.getNext())
         {
            prodlst.setProdList();
            String sDiv = prodlst.getDiv();
            String sDpt = prodlst.getDpt();
            String sCls = prodlst.getCls();
            String sVen = prodlst.getVen();
            String sSty = prodlst.getSty();
            String sClr = prodlst.getClr();
            String sSiz = prodlst.getSiz();
            String sStrInv = prodlst.getStrInv();
            String sProdPrice = prodlst.getProdPrice();
            String sSlsPrice = prodlst.getSlsPrice();
            String sVenNm = prodlst.getVenNm();
            String sProdName = prodlst.getProdName();
       %>
          <tr class="DataTable">
            <td class="DataTable1" nowrap><%=sDiv%></td>
            <td class="DataTable1" nowrap><%=sDpt%></td>
            <td class="DataTable1" nowrap><%=sCls + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz%></td>
            <td class="DataTable1" nowrap><%=sStrInv%></td>
            <td class="DataTable2" nowrap><%=sProdPrice%></td>
            <td class="DataTable2" nowrap><%=sSlsPrice%></td>
            <td class="DataTable1" nowrap><%=sVenNm%></td>
            <td class="DataTable1" nowrap><%=sProdName%></td>
          </tr>
       <%}%>
       <!---------------------------- Total ------------------------------- -->
       <%
         prodlst.setTotal();
         String sTotInv = prodlst.getTotInv();
         String sTotSku = prodlst.getTotSku();
         String sTotCvs = prodlst.getTotCvs();
       %>
       <tr class="DataTable1">
          <td class="DataTable1" nowrap colspan=3>Total</td>
          <td class="DataTable1" nowrap><%=sTotInv%></td>
          <td class="DataTable1" nowrap colspan=4>
             Number of SKUs: <%=sTotSku%>
             &nbsp; &nbsp; &nbsp; &nbsp;
             Number of Parents(Cls-Ven-Sty): <%=sTotCvs%>
          </td>
       </tr>

     </table>

      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   prodlst.disconnect();
   prodlst = null;
   }
%>