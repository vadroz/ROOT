<%@ page import="java.util.*, java.text.*, layaway.LwItemLst"%>
<%
    String sInpStr = request.getParameter("Str");
    String sFrDate = request.getParameter("FrDate");
    String sToDate = request.getParameter("ToDate");

    String sUser = session.getAttribute("USER").toString();

    LwItemLst lwitm = new LwItemLst(sInpStr, sFrDate, sToDate, sUser);
%>

<style>body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { text-align:center;}
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99; font-family:Verdanda; font-size:10px }

        tr.DataTable  { background:white; font-family:Arial; font-size:10px }
        tr.DataTable1  { background: LightGreen; font-family:Arial; font-size:10px }
        tr.DataTable2  { background: LightBlue; font-family:Arial; font-size:10px }

        td.DataTable {  padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:center }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:right }
        td.DataTable11 { background:#af7817; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:right }
        td.DataTable12 { background:silver; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:right }
        td.DataTable13 { background:gold; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:right }
        td.DataTable14 { background:pink; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:right }
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:left }

        div.dvBonus { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon;
              text-align:center; font-size:10px}
        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        .small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:center; font-family:Arial; font-size:10px;}
        #Var { display:none }
        #Prc { display:block }
        </style>

<script language="javascript">
Store = "<%=sInpStr%>";
FrDate = "<%=sFrDate%>";
ToDate = "<%=sToDate%>";

//==============================================================================
// initial page loads
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvBonus"]);
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

<html>
<head>
<title>Layway Store Item List</title>
</head>
<body onload="bodyLoad();">

<!-------------------------------------------------------------------->
<div class="dvBonus" id="dvBonus"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD vAlign=top align=middle><b>Retail Concepts Inc.
        <BR>Layway Store Item List
        <br>Store: <%=sInpStr%>
        <br><%if(!sFrDate.equals("NONE")){%>From Weekending Date: <%=sFrDate%> &nbsp; &nbsp;
                                           Through Weekending Date: <%=sToDate%><%}
              else {%>Weekending Date: <%=sToDate%><%}%>
        </b>

      <br><p><a href="../"><font color="red"  size="-1">Home</font></a>&#62;
         <font size="-1">This page</font> &nbsp; &nbsp; &nbsp;
      <!------------- start Receipt table ------------------------>
      <table class="DataTable" border=1 cellPadding='0' cellSpacing='0'>
             <tr class="DataTable">
                <th class="DataTable">Store</th>
                <th class="DataTable">Document</th>
                <th class="DataTable">Ticket</th>
                <th class="DataTable">Seq</th>
                <th class="DataTable">SKU</th>
                <th class="DataTable">Long Item Number</th>
                <th class="DataTable">Customer<br>Number</th>
                <th class="DataTable">Date</th>
                <th class="DataTable">Description</th>
                <th class="DataTable">Vendor Style</th>
                <th class="DataTable">Vendor Name</th>
                <th class="DataTable">Qty</th>
                <th class="DataTable">Retail</th>
                <th class="DataTable">Cost</th>
              </tr>
      <!-- ============= Details =========================================== -->
         <%while(lwitm.getNext())
         {
            lwitm.setLayaway();
            int iNumOfItm = lwitm.getNumOfItm();
            String [] sStr = lwitm.getStr();
            String [] sDoc = lwitm.getDoc();
            String [] sTkt = lwitm.getTkt();
            String [] sSeq = lwitm.getSeq();
            String [] sQty = lwitm.getQty();
            String [] sRet = lwitm.getRet();
            String [] sCost = lwitm.getCost();
            String [] sSku = lwitm.getSku();
            String [] sCls = lwitm.getCls();
            String [] sVen = lwitm.getVen();
            String [] sSty = lwitm.getSty();
            String [] sClr = lwitm.getClr();
            String [] sSiz = lwitm.getSiz();
            String [] sCustNum = lwitm.getCustNum();
            String [] sDate = lwitm.getDate();
            String [] sDesc = lwitm.getDesc();
            String [] sVenSty = lwitm.getVenSty();
            String [] sVenName = lwitm.getVenName();
          %>
            <%for(int i = 0; i < iNumOfItm; i++){%>
                 <tr class="DataTable">
                    <td class="DataTable1"><%=sStr[i]%></td>
                    <td class="DataTable1"><%=sDoc[i]%></td>
                    <td class="DataTable1"><%=sTkt[i]%></td>
                    <td class="DataTable1"><%=sSeq[i]%></td>
                    <td class="DataTable1"><%=sSku[i]%></td>
                    <td class="DataTable1"><%=sCls[i]%>-<%=sVen[i]%>-<%=sSty[i]%>-<%=sClr[i]%>-<%=sSiz[i]%></td>
                    <td class="DataTable1"><%=sCustNum[i]%></td>
                    <td class="DataTable1"><%=sDate[i]%></td>
                    <td class="DataTable2"><%=sDesc[i]%></td>
                    <td class="DataTable2"><%=sVenSty[i]%></td>
                    <td class="DataTable2"><%=sVenName[i]%></td>
                    <td class="DataTable1"><%=sQty[i]%></td>
                    <td class="DataTable1">$<%=sRet[i]%></td>
                    <td class="DataTable1">$<%=sCost[i]%></td>

              </tr>
            <%}%>
         <%}%>

         <%
           lwitm.setTotal();
           String sTotQty = lwitm.getTotQty();
           String sTotRet = lwitm.getTotRet();
           String sTotCost = lwitm.getTotCost();
         %>

         <tr class="DataTable1">
            <td class="DataTable2">Total</td>
            <td class="DataTable" colspan=10>&nbsp;</td>
            <td class="DataTable1"><%=sTotQty%></td>
            <td class="DataTable1">$<%=sTotRet%></td>
            <td class="DataTable1">$<%=sTotCost%></td>
         </tr>

       </table>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</body>
</html>
<%
  lwitm.disconnect();
  lwitm = null;
%>