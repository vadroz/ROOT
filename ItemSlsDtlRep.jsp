<%@ page import="salesreport.ItemSlsDtlRep"%>
<%
    String sSku = request.getParameter("Sku");
    String [] sSrchStr = request.getParameterValues("Str");
    String sFrom = request.getParameter("From");
    String sTo = request.getParameter("To");

   //----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=ItemSlsDtlRep.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    ItemSlsDtlRep itmsls = new ItemSlsDtlRep(sSku, sSrchStr, sFrom, sTo, sUser);
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
   //setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}

</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


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
        <BR>Item Sales Details
        <br>Sku:<%=sSku%>
        <%String sComa = "";%>
        <br>Stores:
          <%for(int i=0; i < sSrchStr.length; i++){%>
             <%=sComa%>
             <%if(i > 0 && i % 23 == 0){%><br><%}%>
             <%=sSrchStr[i]%><%sComa=", ";%>
          <%}%>

        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="ItemSlsDtlRepSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr class="DataTable">
           <th class="DataTable" nowrap>Item Number</th>
           <th class="DataTable" nowrap>Description</th>
           <th class="DataTable" nowrap>Vendor Style</th>
           <th class="DataTable" nowrap>Str</th>
           <th class="DataTable" nowrap>Date</th>
           <th class="DataTable" nowrap>Sales</th>
           <th class="DataTable" nowrap>Quantity</th>
       <!-- ============================ Details =========================== -->
       <%
         while(itmsls.getNext())
         {
            itmsls.setItmSls();
            int iNumOfSls = itmsls.getNumOfSls();
            String [] sDiv = itmsls.getDiv();
            String [] sDpt = itmsls.getDpt();
            String [] sCls = itmsls.getCls();
            String [] sVen = itmsls.getVen();
            String [] sSty = itmsls.getSty();
            String [] sClr = itmsls.getClr();
            String [] sSiz = itmsls.getSiz();
            String [] sDesc = itmsls.getDesc();
            String [] sVst = itmsls.getVst();
            String [] sStr = itmsls.getStr();
            String [] sDate = itmsls.getDate();
            String [] sRet = itmsls.getRet();
            String [] sQty = itmsls.getQty();

            for(int i=0; i < iNumOfSls; i++) {
            %>
               <tr class="DataTable">
                 <td class="DataTable1" nowrap><%=sCls[i]%>-<%=sVen[i]%>-<%=sSty[i]%>-<%=sClr[i]%>-<%=sSiz[i]%></td>
                 <td class="DataTable1" nowrap><%=sDesc[i]%></td>
                 <td class="DataTable" nowrap><%=sVst[i]%></td>
                 <td class="DataTable" nowrap><%=sStr[i]%></td>
                 <td class="DataTable" nowrap><%=sDate[i]%></td>
                 <td class="DataTable2" nowrap><%=sRet[i]%></td>
                 <td class="DataTable2" nowrap><%=sQty[i]%></td>
              </tr>
           <%}%>
     <%}%>
     <!-- ======================== Totals ============================== -->
     <%
       itmsls.setTotals();
       String sTotRet = itmsls.getTotRet();
       String sTotQty = itmsls.getTotQty();
     %>
        <tr class="DataTable1">
           <td class="DataTable1" nowrap>Total</td>
           <td class="DataTable" colspan=4>&nbsp;</td>
           <td class="DataTable2" nowrap><%=sTotRet%></td>
           <td class="DataTable2" nowrap><%=sTotQty%></td>
        </tr>
     </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   itmsls.disconnect();
   itmsls = null;
   }
%>