<%@ page import="inventoryreports.PITopAdjDiff, java.util.*"%>
<%
   Date dStart = new Date();

   String sSrchDiv = request.getParameter("Div");
   String sSrchDpt = request.getParameter("Dpt");
   String sSrchCls = request.getParameter("Cls");
   String [] sSrchStr = request.getParameterValues("Str");
   String sNumItm = request.getParameter("NumItm");
   String sPiYearMo = request.getParameter("PICal");
   String sSortBy = request.getParameter("Sort");
   String sStartTime = request.getParameter("StartTime");



   if(sSortBy == null) sSortBy = "Unit";

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=PITopAdjDiff.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    String sUser = session.getAttribute("USER").toString();
    PITopAdjDiff itmlst = new PITopAdjDiff(sSrchDiv, sSrchDpt, sSrchCls, sSrchStr,
           sNumItm, sPiYearMo.substring(0, 4), sPiYearMo.substring(4), sSortBy, sUser);
    int iNumOfItm = itmlst.getNumOfItm();

    String [] sDiv = itmlst.getDiv();
    String [] sDpt = itmlst.getDpt();
    String [] sCls = itmlst.getCls();
    String [] sVen = itmlst.getVen();
    String [] sSty = itmlst.getSty();
    String [] sClr = itmlst.getClr();
    String [] sSiz = itmlst.getSiz();
    String [] sSku = itmlst.getSku();
    String [] sDesc = itmlst.getDesc();
    String [] sVenName = itmlst.getVenName();

    String [] sAdjQty = itmlst.getAdjQty();
    String [] sAdjRet = itmlst.getAdjRet();
    String [] sAdjCst = itmlst.getAdjCst();

    String [] sPhyQty = itmlst.getPhyQty();
    String [] sPhyRet = itmlst.getPhyRet();
    String [] sPhyCst = itmlst.getPhyCst();

    String [] sOnHQty = itmlst.getOnHQty();
    String [] sOnHRet = itmlst.getOnHRet();
    String [] sOnHCst = itmlst.getOnHCst();
    String [] sStr = itmlst.getStr();
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        th.InvData { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.InvData { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}


        tr.DataTable { background:#eeeeee; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:Honeydew; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:darkred;}
        tr.DataTable5 { background:Azure; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable2 { border-top: double darkred;}

        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Store = new Array();
<%for(int i=0; i < sSrchStr.length; i++){%>Store[<%=i%>] = "<%=sSrchStr[i]%>";<%}%>
var SortBy = "<%=sSortBy%>";

var StartDate = new Date(<%=dStart.getTime()%>);

//--------------- End of Global variables ----------------
//==============================================================================
// initialize on load
//==============================================================================
function bodyLoad()
{
  var elapse = (new Date()).getTime() - StartDate
  document.all.spElapse.innerHTML = Math.round((elapse / 1000)) + " sec."
}
</SCRIPT>


</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

  <table border="0" width="100%"cellPadding="0" cellSpacing="0">
     <tr>
<!-------------------------------------------------------------------->
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Physical Inventory Top Adjustment Difference
      <br>Store:
      <%String sComa = "";
        for(int i=0; i < sSrchStr.length; i++) {%><%=sComa + sSrchStr[i]%><%sComa=", ";%><%}%>
        <br>
          Div: <%=sSrchDiv%> &nbsp;&nbsp
          Dpt: <%=sSrchDpt%> &nbsp;&nbsp
          Class: <%=sSrchCls%>
         </b><br>

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="PITopAdjDiffSel.jsp?mode=1">
            <font color="red" size="-1">Select Report</font></a>&#62;
          <font size="-1">This Page. &nbsp;&nbsp;&nbsp;&nbsp; </font>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
            <th class="DataTable" rowspan=2>Str</th>
            <th class="DataTable" rowspan=2>Div</th>
            <th class="DataTable" rowspan=2>Dpt</th>
            <th class="DataTable" rowspan=2>Long Item Number</th>
            <th class="DataTable" rowspan=2>SKU</th>
            <th class="DataTable" rowspan=2>Item Description</th>
            <th class="DataTable" rowspan=2>Vendor Name</th>
            <th class="DataTable" rowspan=2>&nbsp;</th>
            <th class="DataTable" colspan=3>Phisical Count</th>
            <th class="DataTable" rowspan=2>&nbsp;</th>
            <th class="DataTable" colspan=3>Onhands</th>
            <th class="DataTable" rowspan=2>&nbsp;</th>
            <th class="DataTable" colspan=3>Adjustment</th>
        </tr>
        <tr>
            <th class="DataTable">Unit</th>
            <th class="DataTable">Cost</th>
            <th class="DataTable">Retail</th>

            <th class="DataTable">Unit</th>
            <th class="DataTable">Cost</th>
            <th class="DataTable">Retail</th>

            <th class="DataTable">Unit</th>
            <th class="DataTable">Cost</th>
            <th class="DataTable">Retail</th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfItm; i++) {%>
              <tr class="DataTable">
                <td class="DataTable1" nowrap><%=sStr[i]%></td>
                <td class="DataTable1" nowrap><%=sDiv[i]%></td>
                <td class="DataTable1" nowrap><%=sDpt[i]%></td>
                <td class="DataTable1" nowrap><%=sCls[i] + "-" + sVen[i] + "-" + sSty[i] + "-" + sClr[i] + "-" + sSiz[i]%></td>
                <td class="DataTable1" nowrap><%=sSku[i]%></td>
                <td class="DataTable1" nowrap><%=sDesc[i]%></td>
                <td class="DataTable1" nowrap><%=sVenName[i]%></td>

                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" nowrap><%=sPhyQty[i]%></td>
                <td class="DataTable" nowrap>$<%=sPhyCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sPhyRet[i]%></td>

                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" nowrap><%=sOnHQty[i]%></td>
                <td class="DataTable" nowrap>$<%=sOnHCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sOnHRet[i]%></td>

                <th class="DataTable">&nbsp;</th>
                <td class="DataTable" nowrap><%=sAdjQty[i]%></td>
                <td class="DataTable" nowrap>$<%=sAdjCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sAdjRet[i]%></td>
              </tr>
           <%}%>
      </table>
      <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%
    itmlst.disconnect();
    itmlst = null;
}
%>

<span id="spElapse" style="font-size=9px">0</span>



