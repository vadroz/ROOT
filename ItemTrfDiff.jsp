<%@ page import="itemtransfer.ItemTrfDiff"%>
<%
   String sIssStr = request.getParameter("IssStr");
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");
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
    ItemTrfDiff itmdiff = new ItemTrfDiff(sIssStr, sFrom, sTo, sUser);
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
        <BR>Item Transfer Discrepancy Report
        </B>

        <br><a href="../" class="small"><font color="red">Home</font></a>&#62;
            <a href="ItemTrfDiffSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
             <th class="DataTable">Div</th>
             <th class="DataTable">Dpt</th>
             <th class="DataTable">Item Long Number</th>
             <th class="DataTable">Sku</th>
             <th class="DataTable">Description</th>
             <th class="DataTable">Dist<br>Str</th>
             <th class="DataTable">Doc<br>Num</th>
             <th class="DataTable">P.O.</th>
             <th class="DataTable">Date</th>
             <th class="DataTable">Qty</th>
             <th class="DataTable">Ackn.<br>Qty</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <% while(itmdiff.getNext()) {
            itmdiff.setItmTrfArr();

            int iNumOfItm = itmdiff.getNumOfItm();
            String [] sDiv = itmdiff.getDiv();
            String [] sDpt = itmdiff.getDpt();
            String [] sCls = itmdiff.getCls();
            String [] sVen = itmdiff.getVen();
            String [] sSty = itmdiff.getSty();
            String [] sClr = itmdiff.getClr();
            String [] sSiz = itmdiff.getSiz();
            String [] sSku = itmdiff.getSku();
            String [] sDesc = itmdiff.getDesc();
            String [] sDstStr = itmdiff.getDstStr();
            String [] sDocNum = itmdiff.getDocNum();
            String [] sRec = itmdiff.getRec();
            String [] sPoNum = itmdiff.getPoNum();
            String [] sDate = itmdiff.getDate();
            String [] sQty = itmdiff.getQty();
            String [] sAknQty = itmdiff.getAknQty();

            for(int i=0; i < iNumOfItm; i++ ) {
       %>
          <tr class="DataTable">
            <td class="DataTable2" nowrap><%=sDiv[i]%></td>
            <td class="DataTable2" nowrap><%=sDpt[i]%></td>
            <td class="DataTable1" nowrap><%=sCls[i] + "-" + sVen[i] + "-" + sSty[i] + "-" + sClr[i] + "-" + sSiz[i]%></td>
            <td class="DataTable2" nowrap><%=sSku[i]%></td>
            <td class="DataTable1" nowrap><%=sDesc[i]%></td>
            <td class="DataTable1" nowrap><%=sDstStr[i]%></td>
            <td class="DataTable1" nowrap><%=sDocNum[i]%></td>
            <td class="DataTable1" nowrap><%=sPoNum[i]%></td>
            <td class="DataTable1" nowrap><%=sDate[i]%></td>
            <td class="DataTable1" nowrap><%=sQty[i]%></td>
            <td class="DataTable1" nowrap><%=sAknQty[i]%></td>
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
   itmdiff.disconnect();
   itmdiff = null;
   }
%>