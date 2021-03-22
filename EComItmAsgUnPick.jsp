<%@ page import="ecommerce.EComItmAsgUnPick"%>
<%
    String sSelStr = request.getParameter("Str");
    String sSort = request.getParameter("Sort");

    if(sSort==null) sSort = "ORD";
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComItmAsgUnPick.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    String sAuthStr = session.getAttribute("STORE").toString().trim();
    String sUser = session.getAttribute("USER").toString();

    EComItmAsgUnPick itmasgn = new EComItmAsgUnPick(sSelStr, sSort, sUser);

    int iNumOfItm = itmasgn.getNumOfItm();
%>
<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:green; font-size:10px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}

        table.DataTable { font-size:10px }

        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        tr.DataTable0 { background: #E7E7E7; font-size:10px }
        tr.DataTable1 { background: yellow; font-size:10px }
        tr.DataTable2 { background: darkred; font-size:1px}
        tr.DataTable3 { background: LemonChiffon; font-size:10px}

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

        .Small {font-size:10px }
        .btnSmall {font-size:8px; display:none;}

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:50; background-color:LemonChiffon; z-index:10;
              text-align:center; vertical-align:top; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

</style>


<script name="javascript1.2">
//==============================================================================
// Global variables
//==============================================================================

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
// hide panel
//==============================================================================
function hidePanel()
{
   document.all.dvItem.innerHTML = "";
   document.all.dvItem.style.visibility = "hidden";
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


<TABLE height="100%" width="100%" border=0 cellPadding="0" cellSpacing="0">
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=center><B>Retail Concepts Inc.
        <BR>E-Commerce: Items w/o Inventory ==> Non-Picked Item
        <br>Store: <%=sSelStr%>
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="EComItmAsgUnPickSel.jsp" class="small"><font color="red">Select</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;
        &nbsp;&nbsp;
    </td>
  </tr>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle colspan=2>
<!-- ======================================================================= -->
       <table border=1 class="DataTable" cellPadding="0" cellSpacing="0">
         <tr class="DataTable">
             <th class="DataTable">Div<br>#</th>
             <th class="DataTable">SKU</th>
             <th class="DataTable">UPC</th>
             <th class="DataTable">Long Item Number</th>
             <th class="DataTable">Description</th>
             <th class="DataTable">Vendor Name</th>
             <th class="DataTable">Color</th>
             <th class="DataTable">Size</th>
             <th class="DataTable">Ret</th>
             <th class="DataTable">Clearance?</th>
             <th class="DataTable">Order<br>#</th>
             <th class="DataTable">Qty</th>
             <th class="DataTable">Note</th>
          </tr>
       <!-- ============================ Details =========================== -->
       <%String SvOrd = null;%>
       <%boolean bOrdClr = false;%>
       <%for(int i=0; i < iNumOfItm; i++ )
         {
            itmasgn.setItmList();

            String sSite = itmasgn.getSite();
            String sOrd = itmasgn.getOrd();
            String sSku = itmasgn.getSku();
            String sDiv = itmasgn.getDiv();
            String sCls = itmasgn.getCls();
            String sVen = itmasgn.getVen();
            String sSty = itmasgn.getSty();
            String sClr = itmasgn.getClr();
            String sSiz = itmasgn.getSiz();
            String sDesc = itmasgn.getDesc();
            String sVenNm = itmasgn.getVenNm();
            String sClrNm = itmasgn.getClrNm();
            String sSizNm = itmasgn.getSizNm();
            String sUpc = itmasgn.getUpc();
            String sRet = itmasgn.getRet();
            String sQty = itmasgn.getQty();
            String sMkd = itmasgn.getMkd();

            String sComa = "";

            String sOrdClr = "";
            if (i==0) { SvOrd = sOrd; }
            if(!SvOrd.equals(sOrd)){ bOrdClr = !bOrdClr; SvOrd = sOrd;}
            if(bOrdClr){ sOrdClr = "#E7E7E7"; }
            else { sOrdClr = "Cornsilk"; }
       %>
         <tr class="DataTable0" <%if(!sOrdClr.equals("")){%>style="background:<%=sOrdClr%>"<%}%>>
            <td class="DataTable" nowrap><%=sDiv%></td>
            <td class="DataTable2" nowrap><%=sSku%></td>
            <td class="DataTable2" nowrap><%=sUpc%></td>
            <td class="DataTable" nowrap><%=sCls%>-<%=sVen%>-<%=sSty%>-<%=sClr%>-<%=sSiz%></td>
            <td class="DataTable1" nowrap><%=sDesc%></td>
            <td class="DataTable1" nowrap><%=sVenNm%></td>
            <td class="DataTable1" nowrap><%=sClrNm%></td>
            <td class="DataTable1" nowrap><%=sSizNm%></td>
            <td class="DataTable2" nowrap>$<%=sRet%></td>

            <td class="DataTable" nowrap><%=sMkd%></td>
            <td class="DataTable" nowrap>
               <a href="EComOrdInfo.jsp?Site=<%=sSite%>&Order=<%=sOrd%>" target="_blank"><%=sOrd%></a><br>
            </td>
            <td class="DataTable2" nowrap><%=sQty%></td>
            <td class="DataTable2" nowrap><%for(int j=0; j < 20;j++){%>&nbsp;<%}%></td>
          </tr>
       <%}%>
     </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   itmasgn.disconnect();
   itmasgn = null;
   }
%>