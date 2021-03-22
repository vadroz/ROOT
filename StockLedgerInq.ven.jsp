<%@ page import="agedanalysis.StockLedgerInq, rciutility.FormatNumericValue, java.util.*"%>
<% String sStore = request.getParameter("STORE");
   String sDivision = request.getParameter("DIVISION");
   String sDepartment = request.getParameter("DEPARTMENT");
   String sClass = request.getParameter("CLASS");
   String sLevel = request.getParameter("LEVEL");
   String sByStr = request.getParameter("BYSTR");
   String sSort = request.getParameter("SORT");
   String sByVen = request.getParameter("BYVEN");

   if(sStore == null) sStore = "ALL";
   if(sDivision == null) sDivision = "ALL";
   if(sDepartment == null) sDepartment = "ALL";
   if(sClass == null) sClass = "ALL";
   if(sLevel == null) sLevel = "1";
   if(sByStr == null) sByStr = "1";
   if(sSort == null) sSort = "01";
   if(sByVen == null && sClass.equals("ALL")) sByVen = "0";
   else if(sByVen == null && !sClass.equals("ALL")) sByVen = "1";


   /*System.out.println(sDivision + " " + sDepartment + " " + sClass + " "
          + sStore  + " " + sLevel + " " + sByStr);*/
   StockLedgerInq stledger = new StockLedgerInq(sStore, sDivision, sDepartment, sClass, sLevel, sByStr, sSort, sByStr);

    int iNumOfDtl = stledger.getNumOfDtl();

    String [] sLine = stledger.getLine();
    String [] sLineDsc = stledger.getLineDsc();
    String [] sUnAuthMkdwn = stledger.getUnAuthMkdwn();
    String [] sAutMkdwn = stledger.getAutMkdwn();
    String [] sGeneral = stledger.getGeneral();
    String [] sTotal = stledger.getTotal();
    String [] sUnAuthPrc = stledger.getUnAuthPrc();
    String [] sSales = stledger.getSales();
    String [] sReturn = stledger.getReturn();
    String [] sNet = stledger.getNet();
    String [] sRtnPrc = stledger.getRtnPrc();
    String [] sGrsMrg = stledger.getGrsMrg();
    String [] sGmPrc = stledger.getGmPrc();

    int iNumOfReg = stledger.getNumOfReg();
    String [] sRegLine = stledger.getRegLine();
    String [] sRegLineDsc = stledger.getRegLineDsc();
    String [] sRegUnAuthMkdwn = stledger.getRegUnAuthMkdwn();
    String [] sRegAutMkdwn = stledger.getRegAutMkdwn();
    String [] sRegGeneral = stledger.getRegGeneral();
    String [] sRegTotal = stledger.getRegTotal();
    String [] sRegUnAuthPrc = stledger.getRegUnAuthPrc();
    String [] sRegSales = stledger.getRegSales();
    String [] sRegReturn = stledger.getRegReturn();
    String [] sRegNet = stledger.getRegNet();
    String [] sRegRtnPrc = stledger.getRegRtnPrc();
    String [] sRegGrsMrg = stledger.getRegGrsMrg();
    String [] sRegGmPrc = stledger.getRegGmPrc();

    String sRepLine = stledger.getRepLine();
    String sRepLineDsc = stledger.getRepLineDsc();
    String sRepUnAuthMkdwn = stledger.getRepUnAuthMkdwn();
    String sRepAutMkdwn = stledger.getRepAutMkdwn();
    String sRepGeneral = stledger.getRepGeneral();
    String sRepTotal = stledger.getRepTotal();
    String sRepUnAuthPrc = stledger.getRepUnAuthPrc();
    String sRepSales = stledger.getRepSales();
    String sRepReturn = stledger.getRepReturn();
    String sRepNet = stledger.getRepNet();
    String sRepRtnPrc = stledger.getRepRtnPrc();
    String sRepGrsMrg = stledger.getRepGrsMrg();
    String sRepGmPrc = stledger.getRepGmPrc();

    stledger.disconnect();


    String sColName = null;
    if(sByStr.equals("1")) sColName= "Store";
    else if(!sClass.equals("ALL")) sColName= "Vendor";
    else if(sClass.equals("ALL") && !sDepartment.equals("ALL")) sColName= "Class";
    else if(sDepartment.equals("ALL") && !sDivision.equals("ALL")) sColName= "Department";
    else sColName= "Division";

    String sLevelName = null;
    if(sLevel.equals("1")) sLevelName="Week-to-Date";
    else if(sLevel.equals("2")) sLevelName="Month-to-Date";
    else if(sLevel.equals("3")) sLevelName="Season-to-Date";
    else if(sLevel.equals("4")) sLevelName="Year-to-Date";

    // format Numeric value
    FormatNumericValue fmt = new FormatNumericValue();
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


        tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:Honeydew; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable5 { background:Azure; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable2 { border-top: double darkred;}


        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }

</style>
<SCRIPT language="JavaScript1.2">
//report parameters
var Store = "<%=sStore%>";
var Division = "<%=sDivision%>";
var Department = "<%=sDepartment%>";
var Class = "<%=sClass%>";
var Level = "<%=sLevel%>";
var ByStr = "<%=sByStr%>";
var Sort = "<%=sSort%>";
var ColName = "<%=sColName%>";
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
function bodyLoad()
{
}

//--------------------------------------------------------
// Show data by Store
//--------------------------------------------------------
function drillDown(line, showByStr, showByVen)
{
  if(line!=0)
  {
    if(ColName=="Store")
    {
       Store = line;
       ByStr = "0"
    }
    else if(ColName=="Division") Division = line;
    else if(ColName=="Department") Department = line;
    else if(ColName=="Class") Class = line;
  }

  if(showByStr) ByStr = "1";
  else ByStr = "0"

  var url = "StockLedgerInq.jsp"
          + "?STORE=" + Store
          + "&DIVISION=" + Division
          + "&DEPARTMENT=" + Department
          + "&CLASS=" + Class
          + "&LEVEL=" + Level
          + "&BYSTR=" + ByStr
          + "&SORT=" + Sort

  //alert(url);
  window.location.href = url;
}
//--------------------------------------------------------
// Sort by column
//--------------------------------------------------------
function sortBy(column)
{
   var url = "StockLedgerInq.jsp"
          + "?STORE=" + Store
          + "&DIVISION=" + Division
          + "&DEPARTMENT=" + Department
          + "&CLASS=" + Class
          + "&LEVEL=" + Level
          + "&BYSTR=" + ByStr
          + "&SORT=" + column

  //alert(url);
  window.location.href = url;
}
</SCRIPT>


</head>
<body onload="bodyLoad()">

    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
        <b>Retail Concepts, Inc
        <br>Stock Ledger Inquiry (<%=sLevelName%>)</b>
      </td>
     </tr>

     <tr>
      <td ALIGN="Center" VALIGN="TOP" colspan=3>

      <b>Store: <%=sStore%>
       &nbsp;&nbsp; Division: <%=sDivision%>
       &nbsp;&nbsp; Department: <%=sDepartment%>
      &nbsp;&nbsp; Class: <%=sClass%></b><br>


      <%if(sByStr.equals("1") && sStore.equals("ALL")){%>
           <a href="javascript: drillDown(0, false, false)">
              <font color="red" size="-1">Div/Dpt/Cls/Ven Level</font></a><%}%>
      &nbsp;&nbsp;&nbsp;&nbsp;

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="StockLedgerInqSel.jsp?mode=1">
            <font color="red" size="-1">Select Report</font></a>&#62;
          <font size="-1">This Page.</font>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
	  <th class="DataTable"  rowspan="2"><a href="javascript: sortBy('01')"><%=sColName%></a></th>
          <th class="DataTable"  rowspan="2">
              <%if(!sByStr.equals("1") && sStore.equals("ALL")){%><a href="javascript: drillDown(0, true, false)">S<br>t<br>r</a><%}
                     else{%>&nbsp;&nbsp;<%}%>
          </th>
          <th class="DataTable"  rowspan="2">
              <%if(!sByVen.equals("1") && !sByStr.equals("1") && sStore.equals("ALL")){%><a href="javascript: drillDown(0, true, true)">V<br>e<br>n</a><%}
                else if(!sByVen.equals("1")){%><a href="javascript: drillDown(0, false, true)">V<br>e<br>n</a><%}
                else {%>&nbsp;&nbsp;<%}%>
          </th>
          <th class="DataTable"  colspan="5">Markdowns</th>
          <th class="DataTable"  rowspan="2">&nbsp;&nbsp;</th>
          <th class="DataTable"  colspan="4">Retail Sales / Returns</th>
          <th class="DataTable"  colspan="2">Gross Margin</th>
        </tr>

        <tr>
          <th class="DataTable"><a href="javascript: sortBy('02')">UnAuth POS</a></th>
          <th class="DataTable"><a href="javascript: sortBy('03')">Auth POS</a></th>
          <th class="DataTable"><a href="javascript: sortBy('04')">General</a></th>
          <th class="DataTable"><a href="javascript: sortBy('05')">Total</a></th>
          <th class="DataTable"><a href="javascript: sortBy('06')">% of Sls</a></th>

          <th class="DataTable"><a href="javascript: sortBy('07')">Sales</a></th>
          <th class="DataTable"><a href="javascript: sortBy('08')">Return</a></th>
          <th class="DataTable"><a href="javascript: sortBy('09')">Net</a></th>
          <th class="DataTable"><a href="javascript: sortBy('10')">% of Sls</a></th>
          <th class="DataTable">$</th>
          <th class="DataTable">%</th>
	 </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfDtl; i++) {%>
              <tr class="DataTable">
                <%if(sClass.equals("ALL")){%>
                    <td class="DataTable1" nowrap><a href="javascript: drillDown(<%=sLine[i]%>, false, false)"><%=sLineDsc[i]%></a></td>
                <%}
                  else{%><td class="DataTable1" nowrap><%=sLineDsc[i]%></td><%}%>
                <th class="DataTable" >
                   <%if(!sByStr.equals("1") && sStore.equals("ALL") && sClass.equals("ALL")){%>
                        <a href="javascript: drillDown(<%=sLine[i]%>, true, false)">S</a><%}
                     else{%>&nbsp;<%}%>
                </th>
                <th class="DataTable" >
                   <%if(!sByVen.equals("1") && !sByStr.equals("1") && sStore.equals("ALL") && sClass.equals("ALL")){%>
                        <a href="javascript: drillDown(<%=sLine[i]%>, true, true)">S</a><%}
                     else if(!sByVen.equals("1")){%>
                        <a href="javascript: drillDown(<%=sLine[i]%>, false, true)">V</a><%}
                     else{%>&nbsp;<%}%>
                </th>

                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sUnAuthMkdwn[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sAutMkdwn[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sGeneral[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sTotal[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap><%=fmt.getFormatedNum(sUnAuthPrc[i].trim(), "##,###,###")%>%</td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sSales[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sReturn[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sNet[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap><%=fmt.getFormatedNum(sRtnPrc[i].trim(), "##,###,###")%>%</td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sGrsMrg[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap><%=fmt.getFormatedNum(sGmPrc[i].trim(), "##,###,###.#")%>%</td>
              </tr>
           <%}%>
<!------------------- Company Total -------------------------------->

      <!------------------- Mall/Non-Mall Total -------------------------------->

      <!------------------- Non/-Ski Total -------------------------------->

      <!------------------- Regional Total -------------------------------->
      <!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfReg; i++) {%>
              <tr class="DataTable2">
                <td class="DataTable1" nowrap><%=sRegLineDsc[i]%></td>
                <th class="DataTable" >&nbsp;</th>
                <th class="DataTable" >&nbsp;</th>

                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegUnAuthMkdwn[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegAutMkdwn[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegGeneral[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegTotal[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap><%=fmt.getFormatedNum(sRegUnAuthPrc[i].trim(), "##,###,###")%>%</td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegSales[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegReturn[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegNet[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap><%=fmt.getFormatedNum(sRegRtnPrc[i].trim(), "##,###,###")%>%</td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegGrsMrg[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap><%=fmt.getFormatedNum(sRegGmPrc[i].trim(), "##,###,###")%>%</td>
              </tr>
           <%}%>
      <!------------------- Report Total -------------------------------->
              <tr class="DataTable3">
                <td class="DataTable1" nowrap><%=sRepLineDsc%></td>
                <th class="DataTable" >&nbsp;</th>
                <th class="DataTable" >&nbsp;</th>

                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepUnAuthMkdwn.trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepAutMkdwn.trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepGeneral.trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepTotal.trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap><%=fmt.getFormatedNum(sRepUnAuthPrc.trim(), "##,###,###")%>%</td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepSales.trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepReturn.trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepNet.trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap><%=fmt.getFormatedNum(sRepRtnPrc.trim(), "##,###,###")%>%</td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepGrsMrg.trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap><%=fmt.getFormatedNum(sRepGmPrc.trim(), "##,###,###.#")%>%</td>
              </tr>
      </table>
      <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
