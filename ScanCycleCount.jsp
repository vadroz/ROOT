<%@ page import="inventoryreports.ScanCycleCount, java.util.*"%>
<%
    String sSelStr = request.getParameter("Store");

//-------------- Security ---------------------
if (session.getAttribute("USER")==null)
{
    response.sendRedirect("SignOn1.jsp?TARGET=ScanCycleCount.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    ScanCycleCount cyclecnt = new ScanCycleCount(sSelStr);
%>

<html>
<head>

<style>
     body { background:ivory;}
        a.blue:link { color:blue; font-size:12px } a.blue:visited { color:blue; font-size:12px }  a.blue:hover { color:red; font-size:12px }
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}


        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:#EfEfEf; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable3 { background: #ccccff; font-family:Arial; font-size:10px }
        tr.DataTable4 { background: #ccffcc; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                        border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                        text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center;}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:100; background-color:LemonChiffon; z-index:10;
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


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------

//==============================================================================
// on time of body load
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}


</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>


</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
  <div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
        <b>Retail Concepts, Inc
        <br>Scanner Cycle Count Inquiry
        Store: <%=sSelStr%>
        <br>
        </b>
        <br>
          <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="ScanCycleCountSel.jsp?">
            <font color="red" size="-1">Selection</font></a>&#62;
          <font size="-1">This Page.</font>
      </td>
     </tr>

     <tr>
      <td ALIGN="Center" VALIGN="TOP" colspan=3>

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable">Long Item Sku</th>
          <th class="DataTable">Item Description</th>
          <th class="DataTable">Color</th>
          <th class="DataTable">Size</th>
          <th class="DataTable">Vendor<br>Style</th>
          <th class="DataTable">Sku</th>
          <th class="DataTable">UPC</th>
          <th class="DataTable">Store<br>On<br>Hand</th>
          <th class="DataTable">Manufacturer<br>Name</th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%while(cyclecnt.getNext()) {
               cyclecnt.setItemCnt();
               int iNumOfCnt = cyclecnt.getNumOfCnt();
               String [] sCls = cyclecnt.getCls();
               String [] sVen = cyclecnt.getVen();
               String [] sSty = cyclecnt.getSty();
               String [] sClr = cyclecnt.getClr();
               String [] sSiz = cyclecnt.getSiz();
               String [] sSku = cyclecnt.getSku();
               String [] sUpc = cyclecnt.getUpc();
               String [] sVst = cyclecnt.getVst();
               String [] sOnHand = cyclecnt.getOnHand();
               String [] sRet = cyclecnt.getRet();
               String [] sSeq = cyclecnt.getSeq();
               String [] sDesc = cyclecnt.getDesc();
               String [] sMfgNm = cyclecnt.getMfgNm();
               String [] sClrNm = cyclecnt.getClrNm();
               String [] sSizNm = cyclecnt.getSizNm();

             for(int i=0; i < iNumOfCnt; i++)
             {
           %>
              <tr class="DataTable">
                <td class="DataTable2" nowrap><%=sCls[i] + "-" + sVen[i] + "-" + sSty[i] + "-" + sClr[i] + "-" + sSiz[i]%></td>
                <td class="DataTable1" nowrap><%=sDesc[i]%></td>
                <td class="DataTable1" nowrap><%=sClrNm[i]%></td>
                <td class="DataTable1" nowrap><%=sSizNm[i]%></td>
                <td class="DataTable1" nowrap><%=sVst[i]%></td>
                <td class="DataTable2" nowrap><%=sSku[i]%></td>
                <td class="DataTable2" nowrap><%=sUpc[i]%></td>
                <td class="DataTable2" nowrap><%=sOnHand[i]%></td>
                <td class="DataTable1" nowrap><%=sMfgNm[i]%></td>
             </tr>
           <%}%>
          <%}%>
      </table>
      <!----------------------- end of table ------------------------>
      </td>
     </tr>
          </table>
       </td>
     </tr>
  </table>
 </body>
</html>
<%}%>