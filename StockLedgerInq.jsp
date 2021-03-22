<%@ page import="agedanalysis.StockLedgerInq, rciutility.FormatNumericValue, java.util.*, java.text.*"%>
<%
    long lStartTime = (new Date()).getTime();
   //Div=1 Dpt=1 Cls=ALL
   //Str=4 Str=5 Str=8 Str=10 Str=11 Str=20 Str=28 Str=30 Str=35 Str=40 Str=45 Str=46 Str=50 Str=55 Str=61 Str=82 Str=86 Str=88 Str=89 Str=98 Level=1 ByStr=0

   String [] sStore = request.getParameterValues("Str");
   String sDivision = request.getParameter("Div");
   String sDepartment = request.getParameter("Dpt");
   String sClass = request.getParameter("Cls");
   String sLevel = request.getParameter("Level");
   String sByStr = request.getParameter("ByStr");
   String sSort = request.getParameter("SORT");
   String sVendor = request.getParameter("Ven");
   String sVenName = request.getParameter("VenName");
   String sWkend = request.getParameter("Wkend");

   if(sDivision == null) sDivision = "ALL";
   if(sDepartment == null) sDepartment = "ALL";
   if(sClass == null) sClass = "ALL";
   if(sVendor == null) sVendor = "ALL";
   if(sVenName == null) sVenName = "ALL Vendor";
   if(sLevel == null) sLevel = "1";
   if(sByStr == null) sByStr = "1";
   if(sSort == null) sSort = "01";
   if(sWkend == null) { sWkend = "NONE"; }


   /*System.out.println(sDivision + " " + sDepartment + " " + sClass + " "
          + sStore[0]  + " " + sLevel + " " + sByStr + " " + sWkend);*/
   //StockLedgerInq stledger = new StockLedgerInq(sStore, sDivision, sDepartment, sClass,
   //     sLevel, sByStr, sSort); // old
   StockLedgerInq stledger = new StockLedgerInq(sStore, sDivision, sDepartment, sClass,
        sVendor, sLevel, sByStr, sSort, sWkend);

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
    String [] sLyGrsMrg = stledger.getLyGrsMrg();
    String [] sLyGmPrc = stledger.getLyGmPrc();
    String [] sLyUnAMd = stledger.getLyUnAMd();
    String [] sLyAutMd = stledger.getLyAutMd();
    String [] sLyGenMd = stledger.getLyGenMd();
    String [] sLyTotMd = stledger.getLyTotMd();
    String [] sLyNet = stledger.getLyNet();
    String [] sLyUnMdPrc = stledger.getLyUnMdPrc();
    String [] sInvRet = stledger.getInvRet();
    String [] sInvCst = stledger.getInvCst();
    String [] sInvUnt = stledger.getInvUnt();
    String [] sLyInvRet = stledger.getLyInvRet();
    String [] sLyInvCst = stledger.getLyInvCst();
    String [] sLyInvUnt = stledger.getLyInvUnt();

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
    String [] sRegLyGrsMrg = stledger.getRegLyGrsMrg();
    String [] sRegLyGmPrc = stledger.getRegLyGmPrc();
    String [] sRegLyUnAMd = stledger.getRegLyUnAMd();
    String [] sRegLyAutMd = stledger.getRegLyAutMd();
    String [] sRegLyGenMd = stledger.getRegLyGenMd();
    String [] sRegLyTotMd = stledger.getRegLyTotMd();
    String [] sRegLyNet = stledger.getRegLyNet();
    String [] sRegLyUnMdPrc = stledger.getRegLyUnMdPrc();
    String [] sRegInvRet = stledger.getRegInvRet();
    String [] sRegInvCst = stledger.getRegInvCst();
    String [] sRegInvUnt = stledger.getRegInvUnt();
    String [] sRegLyInvRet = stledger.getRegLyInvRet();
    String [] sRegLyInvCst = stledger.getRegLyInvCst();
    String [] sRegLyInvUnt = stledger.getRegLyInvUnt();

    // Division Group Totals
    String [] sDivLine = stledger.getDivLine();
    String [] sDivLineDsc = stledger.getDivLineDsc();
    String [] sDivUnAuthMkdwn = stledger.getDivUnAuthMkdwn();
    String [] sDivAutMkdwn = stledger.getDivAutMkdwn();
    String [] sDivGeneral = stledger.getDivGeneral();
    String [] sDivTotal = stledger.getDivTotal();
    String [] sDivUnAuthPrc = stledger.getDivUnAuthPrc();
    String [] sDivSales = stledger.getDivSales();
    String [] sDivReturn = stledger.getDivReturn();
    String [] sDivNet = stledger.getDivNet();
    String [] sDivRtnPrc = stledger.getDivRtnPrc();
    String [] sDivGrsMrg = stledger.getDivGrsMrg();
    String [] sDivGmPrc = stledger.getDivGmPrc();
    String [] sDivLyGrsMrg = stledger.getDivLyGrsMrg();
    String [] sDivLyGmPrc = stledger.getDivLyGmPrc();
    String [] sDivLyUnAMd = stledger.getDivLyUnAMd();
    String [] sDivLyAutMd = stledger.getDivLyAutMd();
    String [] sDivLyGenMd = stledger.getDivLyGenMd();
    String [] sDivLyTotMd = stledger.getDivLyTotMd();
    String [] sDivLyNet = stledger.getDivLyNet();
    String [] sDivLyUnMdPrc = stledger.getDivLyUnMdPrc();
    String [] sDivInvRet = stledger.getDivInvRet();
    String [] sDivInvCst = stledger.getDivInvCst();
    String [] sDivInvUnt = stledger.getDivInvUnt();
    String [] sDivLyInvRet = stledger.getDivLyInvRet();
    String [] sDivLyInvCst = stledger.getDivLyInvCst();
    String [] sDivLyInvUnt = stledger.getDivLyInvUnt();

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
    String sRepLyGrsMrg = stledger.getRepLyGrsMrg();
    String sRepLyGmPrc = stledger.getRepLyGmPrc();
    String sRepLyUnAMd = stledger.getRepLyUnAMd();
    String sRepLyAutMd = stledger.getRepLyAutMd();
    String sRepLyGenMd = stledger.getRepLyGenMd();
    String sRepLyTotMd = stledger.getRepLyTotMd();
    String sRepLyNet = stledger.getRepLyNet();
    String sRepLyUnMdPrc = stledger.getRepLyUnMdPrc();
    String sRepInvRet = stledger.getRepInvRet();
    String sRepInvCst = stledger.getRepInvCst();
    String sRepInvUnt = stledger.getRepInvUnt();
    String sRepLyInvRet = stledger.getRepLyInvRet();
    String sRepLyInvCst = stledger.getRepLyInvCst();
    String sRepLyInvUnt = stledger.getRepLyInvUnt();

    String sLyWkend = stledger.getLyWkend();

    stledger.disconnect();

    String sColName = null;
    if(sByStr.equals("1")) sColName= "Store";
    else if(!sClass.equals("ALL")) sColName= "Vendor";
    else if(sClass.equals("ALL") && !sDepartment.equals("ALL")) sColName= "Class";
    else if(sDepartment.equals("ALL") && !sDivision.equals("ALL")) sColName= "Department";
    else sColName= "Division";

    String sLevelName = null;
    if(sWkend.equals("NONE") && sLevel.equals("1")) sLevelName="Week-to-Date";
    else if(sWkend.equals("NONE") && sLevel.equals("2")) sLevelName="Month-to-Date";
    else if(sWkend.equals("NONE") && sLevel.equals("3")) sLevelName="Season-to-Date";
    else if(sWkend.equals("NONE") && sLevel.equals("4")) sLevelName="Year-to-Date";
    else if(!sWkend.equals("NONE") && sLevel.equals("1")) sLevelName="Week";
    else if(!sWkend.equals("NONE") && sLevel.equals("2")) sLevelName="Month";
    else if(!sWkend.equals("NONE") && sLevel.equals("4")) sLevelName="Year";


    String sLyLevelName = null;
    if(sLevel.equals("1")) sLyLevelName="Weekending";
    else if(sWkend.equals("NONE") && sLevel.equals("2")) sLyLevelName="Month-to-Weekend";
    else if(sWkend.equals("NONE") && sLevel.equals("3")) sLyLevelName="Season-to-Weekend";
    else if(sWkend.equals("NONE") && sLevel.equals("4")) sLyLevelName="Year-to-Weekend";
    else if(!sWkend.equals("NONE") && sLevel.equals("2")) sLyLevelName="Month";

    // format Numeric value
    FormatNumericValue fmt = new FormatNumericValue();

    //Calendar cal = Calendar.getInstance();
    SimpleDateFormat sdfNow = new SimpleDateFormat("MM/dd/yyyy");
    Date curdt = new Date((new Date()).getTime() - 86400000);
    String sTodate = sdfNow.format(curdt);
    if(!sWkend.equals("NONE")){ sTodate = sWkend; }
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
var Store = new Array(<%=sStore.length%>);
<%for(int i=0; i < sStore.length; i++) {%>Store[<%=i%>] = "<%=sStore[i]%>"; <%}%>

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
function drillDown(line, showByStr)
{
  if(line!=0)
  {
    if(ColName=="Store")
    {
       Store = [ line];
       ByStr = "0"
    }
    else if(ColName=="Division") Division = line;
    else if(ColName=="Department") Department = line;
    else if(ColName=="Class") Class = line;
  }

  if(showByStr) ByStr = "1";
  else ByStr = "0"

  var url = "StockLedgerInq.jsp?"
          + "Div=" + Division
          + "&Dpt=" + Department
          + "&Cls=" + Class
          + "&Level=" + Level
          + "&ByStr=" + ByStr
          + "&SORT=" + Sort
          + "&Wkend=<%=sWkend%>"

          for(var i = 0; i < Store.length; i++){ url += "&Str=" + Store[i]; }

  //alert(url);
  window.location.href = url;
}
//--------------------------------------------------------
// Sort by column
//--------------------------------------------------------
function sortBy(column)
{
   var url = "StockLedgerInq.jsp?"
          + "Div=" + Division
          + "&Dpt=" + Department
          + "&Cls=" + Class
          + "&Level=" + Level
          + "&ByStr=" + ByStr
          + "&SORT=" + column
          + "&Wkend=<%=sWkend%>"

          for(var i = 0; i < Store.length; i++){ url += "&Str=" + Store[i]; }
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

      <b>Store: <%String sComa = "";%>
      <%for(int i=0; i < sStore.length; i++) {%><%=sComa + sStore[i]%><%sComa = ", "; }%>
       <br>Division: <%=sDivision%> &nbsp;&nbsp;
           Department: <%=sDepartment%> &nbsp;&nbsp;
           Class: <%=sClass%><br>
           VenName: <%=sVenName%><br>
         </b>


<br><span style="font-size:10px"><u>Negative</u> amounts in UnAuth POS - is a result of items being sold for MORE THAN authorized selling price.</span><br>

      <%if(sByStr.equals("1") && sStore.length > 1 ){%>
           <a href="javascript: drillDown(0, false)">
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
	  <th class="DataTable"  rowspan="3"><a href="javascript: sortBy('01')"><%=sColName%></a></th>
          <th class="DataTable"  rowspan="3">
              <%if(!sByStr.equals("1") && sStore.equals("ALL")){%><a href="javascript: drillDown(0, true)">S<br>t<br>r</a><%}
                     else{%>&nbsp;&nbsp;<%}%>
          </th>
          <th class="DataTable"  colspan="12">This Year <%=sLevelName%><br><%=sTodate%></th>
          <th class="DataTable"  rowspan="3">&nbsp;&nbsp;</th>
          <%if(!sLevel.equals("3")){%><th class="DataTable"  colspan="12">Last Year <%=sLyLevelName%><br><%=sLyWkend%></th><%}%>
        </tr>

        <tr>
          <th class="DataTable"  colspan="5">Markdowns</th>
          <th class="DataTable"  rowspan="2">&nbsp;&nbsp;</th>
          <th class="DataTable"  rowspan="2"><a href="javascript: sortBy('09')">Sales</a></th>
          <th class="DataTable"  rowspan="2">&nbsp;&nbsp;</th>
          <th class="DataTable"  colspan="2">Gross Margin</th>
          <th class="DataTable"  rowspan="2">&nbsp;&nbsp;</th>
          <th class="DataTable"  >Inventory</th>
          <%if(!sLevel.equals("3")){%>
             <th class="DataTable"  colspan="5">Markdowns</th>
             <th class="DataTable"  rowspan="2">&nbsp;&nbsp;</th>
             <th class="DataTable"  rowspan="2"><a href="javascript: sortBy('19')">Sales</a></th>
             <th class="DataTable"  rowspan="2">&nbsp;&nbsp;</th>
             <th class="DataTable"  colspan="2">Gross Margin</th>
             <th class="DataTable"  rowspan="2">&nbsp;&nbsp;</th>
             <th class="DataTable"  >Inventory</th>
          <%}%>
        </tr>

        <tr>
          <th class="DataTable"><a href="javascript: sortBy('02')">UnAuth POS</a></th>
          <th class="DataTable"><a href="javascript: sortBy('03')">Auth POS</a></th>
          <th class="DataTable"><a href="javascript: sortBy('04')">General</a></th>
          <th class="DataTable"><a href="javascript: sortBy('05')">Total</a></th>
          <th class="DataTable"><a href="javascript: sortBy('06')">% of Sls</a></th>
          <th class="DataTable"><a href="javascript: sortBy('11')">$</a></th>
          <th class="DataTable"><a href="javascript: sortBy('12')">%</a></th>
          <th class="DataTable"><a href="javascript: sortBy('13')">At cost $</a></th>

          <%if(!sLevel.equals("3")){%>
             <th class="DataTable"><a href="javascript: sortBy('14')">UnAuth POS</a></th>
             <th class="DataTable"><a href="javascript: sortBy('15')">Auth POS</a></th>
             <th class="DataTable"><a href="javascript: sortBy('16')">General</a></th>
             <th class="DataTable"><a href="javascript: sortBy('17')">Total</a></th>
             <th class="DataTable"><a href="javascript: sortBy('18')">% of Sls</a></th>
             <th class="DataTable"><a href="javascript: sortBy('20')">$</a></th>
             <th class="DataTable"><a href="javascript: sortBy('21')">%</a></th>
             <th class="DataTable"><a href="javascript: sortBy('22')">At cost $</a></th>
          <%}%>
	 </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfDtl; i++) {%>
              <tr class="DataTable">
                <%if(sClass.equals("ALL")){%>
                    <td class="DataTable1" nowrap><a href="javascript: drillDown(<%=sLine[i]%>, false)"><%=sLineDsc[i]%></a></td>
                <%}
                  else{%><td class="DataTable1" nowrap><%=sLineDsc[i]%></td><%}%>
                <th class="DataTable" >
                   <%if(!sByStr.equals("1") && sStore.equals("ALL") && sClass.equals("ALL")){%>
                        <a href="javascript: drillDown(<%=sLine[i]%>, true)">S</a><%}
                     else{%>&nbsp;<%}%>
                </th>

                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sUnAuthMkdwn[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sAutMkdwn[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sGeneral[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sTotal[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap><%=fmt.getFormatedNum(sUnAuthPrc[i].trim(), "##,###,###.#")%>%</td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sNet[i].trim(), "##,###,###")%></td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sGrsMrg[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap><%=fmt.getFormatedNum(sGmPrc[i].trim(), "##,###,###.#")%>%</td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sInvCst[i].trim(), "##,###,###")%></td>
                <th class="DataTable" >&nbsp;</th>

                <%if(!sLevel.equals("3")){%>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sLyUnAMd[i].trim(), "##,###,###.#")%>&nbsp;</td>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sLyAutMd[i].trim(), "##,###,###.#")%>&nbsp;</td>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sLyGenMd[i].trim(), "##,###,###.#")%>&nbsp;</td>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sLyTotMd[i].trim(), "##,###,###.#")%>&nbsp;</td>
                   <td class="DataTable" nowrap><%=fmt.getFormatedNum(sLyUnMdPrc[i].trim(), "##,###,###.#")%>%&nbsp;</td>
                   <th class="DataTable" >&nbsp;</th>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sLyNet[i].trim(), "##,###,###.#")%>&nbsp;</td>
                   <th class="DataTable" >&nbsp;</th>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sLyGrsMrg[i].trim(), "##,###,###")%>&nbsp;</td>
                   <td class="DataTable" nowrap><%=fmt.getFormatedNum(sLyGmPrc[i].trim(), "##,###,###.#")%>%&nbsp;</td>
                   <th class="DataTable" >&nbsp;</th>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sLyInvCst[i].trim(), "##,###,###")%></td>
                <%}%>
              </tr>
           <%}%>
<!------------------- Company Total -------------------------------->

      <!------------------- Mall/Non-Mall Total -------------------------------->

      <!------------------- Non/-Ski Total -------------------------------->

      <!------------------- Merchandise / Non-Merchandise Total -------------------------------->
       <%if(sDivLineDsc != null){%>
           <%for(int i=0; i < 2; i++) {%>
              <tr class="DataTable2">
                <td class="DataTable1" nowrap><%=sDivLineDsc[i]%></td>
                <th class="DataTable" >&nbsp;</th>

                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sDivUnAuthMkdwn[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sDivAutMkdwn[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sDivGeneral[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sDivTotal[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap><%=fmt.getFormatedNum(sDivUnAuthPrc[i].trim(), "##,###,###.#")%>%</td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sDivNet[i].trim(), "##,###,###")%></td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sDivGrsMrg[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap><%=fmt.getFormatedNum(sDivGmPrc[i].trim(), "##,###,###.#")%>%</td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sDivInvCst[i].trim(), "##,###,###")%></td>
                <th class="DataTable" >&nbsp;</th>
                <%if(!sLevel.equals("3")){%>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sDivLyUnAMd[i].trim(), "##,###,###.#")%></td>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sDivLyAutMd[i].trim(), "##,###,###.#")%></td>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sDivLyGenMd[i].trim(), "##,###,###.#")%></td>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sDivLyTotMd[i].trim(), "##,###,###.#")%></td>
                   <td class="DataTable" nowrap><%=fmt.getFormatedNum(sDivLyUnMdPrc[i].trim(), "##,###,###.#")%>%</td>
                   <th class="DataTable" >&nbsp;</th>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sDivLyNet[i].trim(), "##,###,###.#")%></td>
                   <th class="DataTable" >&nbsp;</th>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sDivLyGrsMrg[i].trim(), "##,###,###")%></td>
                   <td class="DataTable" nowrap><%=fmt.getFormatedNum(sDivLyGmPrc[i].trim(), "##,###,###.#")%>%</td>
                   <th class="DataTable" >&nbsp;</th>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sDivLyInvCst[i].trim(), "##,###,###")%></td>
                <%}%>
              </tr>
           <%}%>
       <%}%>

      <!------------------- Regional Total -------------------------------->
      <!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfReg; i++) {%>
              <tr class="DataTable2">
                <td class="DataTable1" nowrap><%=sRegLineDsc[i]%></td>
                <th class="DataTable" >&nbsp;</th>

                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegUnAuthMkdwn[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegAutMkdwn[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegGeneral[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegTotal[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap><%=fmt.getFormatedNum(sRegUnAuthPrc[i].trim(), "##,###,###.#")%>%</td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegNet[i].trim(), "##,###,###")%></td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegGrsMrg[i].trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap><%=fmt.getFormatedNum(sRegGmPrc[i].trim(), "##,###,###.#")%>%</td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegInvCst[i].trim(), "##,###,###")%></td>
                <th class="DataTable" >&nbsp;</th>
                <%if(!sLevel.equals("3")){%>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegLyUnAMd[i].trim(), "##,###,###.#")%></td>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegLyAutMd[i].trim(), "##,###,###.#")%></td>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegLyGenMd[i].trim(), "##,###,###.#")%></td>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegLyTotMd[i].trim(), "##,###,###.#")%></td>
                   <td class="DataTable" nowrap><%=fmt.getFormatedNum(sRegLyUnMdPrc[i].trim(), "##,###,###.#")%>%</td>
                   <th class="DataTable" >&nbsp;</th>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegLyNet[i].trim(), "##,###,###.#")%></td>
                   <th class="DataTable" >&nbsp;</th>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegLyGrsMrg[i].trim(), "##,###,###")%></td>
                   <td class="DataTable" nowrap><%=fmt.getFormatedNum(sRegLyGmPrc[i].trim(), "##,###,###.#")%>%</td>
                   <th class="DataTable" >&nbsp;</th>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRegLyInvCst[i].trim(), "##,###,###")%></td>
                <%}%>
              </tr>
           <%}%>
      <!------------------- Report Total -------------------------------->
              <tr class="DataTable3">
                <td class="DataTable1" nowrap><%=sRepLineDsc%></td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepUnAuthMkdwn.trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepAutMkdwn.trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepGeneral.trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepTotal.trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap><%=fmt.getFormatedNum(sRepUnAuthPrc.trim(), "##,###,###.#")%>%</td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepNet.trim(), "##,###,###")%></td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepGrsMrg.trim(), "##,###,###")%></td>
                <td class="DataTable" nowrap><%=fmt.getFormatedNum(sRepGmPrc.trim(), "##,###,###.#")%>%</td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepInvCst.trim(), "##,###,###")%></td>
                <th class="DataTable" >&nbsp;</th>
                <%if(!sLevel.equals("3")){%>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepLyUnAMd.trim(), "##,###,###.#")%></td>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepLyAutMd.trim(), "##,###,###.#")%></td>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepLyGenMd.trim(), "##,###,###.#")%></td>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepLyTotMd.trim(), "##,###,###.#")%></td>
                   <td class="DataTable" nowrap><%=fmt.getFormatedNum(sRepLyUnMdPrc.trim(), "##,###,###.#")%>%</td>
                   <th class="DataTable" >&nbsp;</th>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepLyNet.trim(), "##,###,###.#")%></td>
                   <th class="DataTable" >&nbsp;</th>
                   <td class="DataTable" nowrap>$<%=fmt.getFormatedNum(sRepLyGrsMrg.trim(), "##,###,###")%></td>
                   <td class="DataTable" nowrap><%=fmt.getFormatedNum(sRepLyGmPrc.trim(), "##,###,###.#")%>%</td>
                   <th class="DataTable" >&nbsp;</th>
                   <td class="DataTable" nowrap><%=fmt.getFormatedNum(sRepLyInvCst.trim(), "##,###,###.#")%></td>
                <%}%>
              </tr>
      </table>
      <!----------------------- end of table ------------------------>
  </table>
  <%
      long lEndTime = (new Date()).getTime();
      long lElapse = (lEndTime - lStartTime) / 1000;
      if (lElapse==0) lElapse = 1;
%>
  <p style="font-size:10px;">Elapse: <%=lElapse%> sec
 </body>
</html>
