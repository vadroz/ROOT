<%@ page import="salesreport3.StrTranSearch"%>
<%
  String sStore = request.getParameter("Store");
  String sStrName = request.getParameter("StrName");
  String sSelTran = request.getParameter("Tran");

  StrTranSearch strtran = new StrTranSearch(sStore, sSelTran);
  int iNumOfTrn = strtran.getNumOfTrn();
%>

<html>
<head>

<style> body {background:ivory;  vertical-align:bottom;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}

        th.DataTable { background:#FFCC99;padding-top:1px; padding-bottom:1px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99;padding-top:1px; padding-bottom:1px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;
                       border-top: darkred solid 1px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:#f7f7f7;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }
        td.DataTable1 { background:#f7f7f7;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:left; font-family:Arial; font-size:10px }
         td.DataTable2 { background:CornSilk;
                       padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:center; font-family:Arial; font-size:10px }
         td.DataTable3 { background:#f7f7f7;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       text-align:right; font-family:Arial; font-size:10px }

        div.dvTrans { position:absolute; visibility:hidden; background-attachment: scroll; border:ridge; width:300; background-color:LemonChiffon; z-index:100; text-align:left; font-size:16px }
        .Small{ text-align:left; font-family:Arial; font-size:10px;}
        tr.Detail { background: #e7e7e7; }
        tr.Total { background: cornsilk; }
        td.BoxName {cursor:move; filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec); color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec; color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { padding-right:3px; padding-left:3px; text-align:left; font-family:Arial; font-size:10px; }
        td.Prompt1 { padding-right:3px; padding-left:3px; text-align:center;font-family:Arial; font-size:10px; }
        td.Prompt2 { padding-right:3px; padding-left:3px; text-align:right; font-family:Arial; font-size:10px; }

</style>
<SCRIPT language="JavaScript">

function bodyLoad()
{
  setBoxclasses(["BoxName",  "BoxClose"], ["dvTrans"]);
}
//==============================================================================
// show transaction details
//==============================================================================
function showTrans(str, date, reg, trans)
{
   var url = "../UnautMDTran.jsp?Store=" + str
       + "&#38;Date=" + date
       + "&#38;Reg=" + reg
       + "&#38;Trans=" + trans
   //alert(url)
   //window.location.href = url;
   window.frame1.location.href = url;
}
//==============================================================================
// show transaction details
//==============================================================================
function showTransDetail(html)
{
   document.all.dvTrans.innerHTML = html;
   document.all.dvTrans.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvTrans.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvTrans.style.visibility = "visible";
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvTrans.innerHTML = " ";
   document.all.dvTrans.style.visibility = "hidden";
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

</head>
<!-- ==================================================================== -->
  <iframe id="frame1"  src=""  frameborder="0" height="0" width="0"></iframe>
<!-- ==================================================================== -->
  <div id="dvTrans" class="dvTrans"></div>
<!-- ==================================================================== -->

<body  onload="bodyLoad();">

   <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
    <tr bgColor="moccasin">
     <td style="vertical-align:top; text-align:center;">
      <b>Retail Concepts, Inc
      <br>Search Store Transactions
      <br>Store: <%=sStrName%></b>
      <br><a href="../" class="small"><font color="red">Home</font></a>&#62;
          <a href="StrTranSearchSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
<!------------- start of dollars table ------------------------>
      <table class="DataTable" align="center" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable">Str<br/>#</th>
          <th class="DataTable">Div<br/>#</th>
          <th class="DataTable">Dpt<br/>#</th>
          <th class="DataTable">Reg<br>#</th>
          <th class="DataTable">Trans<br>#</th>
          <th class="DataTable">Date</th>
          <th class="DataTable">Long Item Number</th>
          <th class="DataTable">Sku</th>
          <th class="DataTable">Description</th>
          <th class="DataTable">Retail</th>
          <th class="DataTable">Cost</th>
          <th class="DataTable">Cashier</th>
          <th class="DataTable">Sales Person</th>
        </tr>
        <!-- ---------------------- Detail Loop ----------------------- -->
        <%for(int i=0; i < iNumOfTrn; i++){%>
           <%
              strtran.setTran();
              String sStr = strtran.getStr();
              String sDiv = strtran.getDiv();
              String sDpt = strtran.getDpt();
              String sCls = strtran.getCls();
              String sVen = strtran.getVen();
              String sSty = strtran.getSty();
              String sClr = strtran.getClr();
              String sSiz = strtran.getSiz();
              String sSku = strtran.getSku();
              String sDesc = strtran.getDesc();
              String sRet = strtran.getRet();
              String sCost = strtran.getCost();
              String sReg = strtran.getReg();
              String sTran = strtran.getTran();
              String sDate = strtran.getDate();
              String sCashr = strtran.getCashr();
              String sCshName = strtran.getCshName();
              String sSlsMan = strtran.getSlsMan();
              String sSlsManName = strtran.getSlsManName();
           %>
           <tr>
             <td class="DataTable3"><%=sStr%></td>
             <td class="DataTable3"><%=sDiv%></td>
             <td class="DataTable3"><%=sDpt%></td>
             <td class="DataTable3"><%=sReg%></td>
             <td class="DataTable3"><a href="javascript: showTrans('<%=sStr%>', '<%=sDate%>', '<%=sReg%>', '<%=sTran%>')"><%=sTran%></a></td>
             <td class="DataTable3"><%=sDate%></td>
             <td class="DataTable1" nowrap><%=sCls + "-" + sVen + "-" + sSty + "-" + sClr + "-" + sSiz%></td>
             <td class="DataTable"><a href="SalesBySkuSel.jsp?Str=<%=sStr%>&Sku=<%=sSku%>&Date=<%=sDate%>"><%=sSku%></a></td>
             <td class="DataTable1" nowrap><%=sDesc%></td>
             <td class="DataTable3">$<%=sRet%></td>
             <td class="DataTable3">$<%=sCost%></td>
             <td class="DataTable1" nowrap><%=sCashr + " " + sCshName%></td>
             <td class="DataTable1" nowrap><%=sSlsMan + " " + sSlsManName%></td>
           </tr>
        <%}%>
       </table>

<!------------- end of data table ------------------------>

                </td>
            </tr>
       </table>

        </body>
      </html>
<%strtran.disconnect();%>