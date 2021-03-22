<%@ page import="salesreport3.SlsTrendByClass, java.util.*"%>
<% String sStore = request.getParameter("STORE");
   String sDivision = request.getParameter("DIVISION");
   String sCompDate = request.getParameter("DATE");
   String sSortBy = request.getParameter("SORT");

   if(sSortBy == null) sSortBy = "CLASS";

   String sSortTitle = "Sorted by Classes";
   if(sSortBy.equals("WK")) sSortTitle = "Sorted by Week Variances";
   if(sSortBy.equals("MON")) sSortTitle = "Sorted by Month Variances";
   if(sSortBy.equals("QTR")) sSortTitle = "Sorted by Quater Variances";
   if(sSortBy.equals("YR")) sSortTitle = "Sorted by Year Variances";

   SlsTrendByClass setSls = new SlsTrendByClass(sDivision, sStore, sCompDate, sSortBy);
   int iNumOfCls = setSls.getNumOfCls();
   String [] sCls = setSls.getCls();
   String [] sClsName = setSls.getClsName();
   String [] sDpt = setSls.getDpt();
   String [] sDptName = setSls.getDptName();

   String [] sWkTySls = setSls.getWkTySls();
   String [] sWkLySls = setSls.getWkLySls();
   String [] sWkDiff = setSls.getWkDiff();
   String [] sWkVar = setSls.getWkVar();

   String [] sMnTySls = setSls.getMnTySls();
   String [] sMnLySls = setSls.getMnLySls();
   String [] sMnDiff = setSls.getMnDiff();
   String [] sMnVar = setSls.getMnVar();

   String [] sQtTySls = setSls.getQtTySls();
   String [] sQtLySls = setSls.getQtLySls();
   String [] sQtDiff = setSls.getQtDiff();
   String [] sQtVar = setSls.getQtVar();

   String [] sYrTySls = setSls.getYrTySls();
   String [] sYrLySls = setSls.getYrLySls();
   String [] sYrDiff = setSls.getYrDiff();
   String [] sYrVar = setSls.getYrVar();

   setSls.disconnect();

%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable2 { color: brown; background:cornsilk; font-family:Arial; font-size:11px; font-weight:bold}

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-top: double darkred; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}

</style>
<SCRIPT language="JavaScript">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
</SCRIPT>
</head>
<body>
    <table border="0" width="100%" height="100%">
             <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP" colspan=2>
      <b>Retail Concepts, Inc
      <br>Sales Trend by Class Report
      <br>Store: <%=sStore%> &nbsp;&nbsp;&nbsp;&nbsp;
          Compare Date: <%=sCompDate%> &nbsp;&nbsp;&nbsp;&nbsp;
          <%=sSortTitle%></b>
      <br><a href="../"><font color="red" size="-1">Home</font></a>&#62;
          <a href="../rciWeeklyReports.html"><font color="red" size="-1">Flash Reports</font></a>&#62;
          <a href="servlet/salesreport3.Salesreport03?ReportId=11&PosTo=<%=sDivision%>">
            <font color="red" size="-1">Sales Trend Comparison by Division</font></a>&#62;
          <font size="-1">This Page.</font>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
	  <th class="DataTable"  rowspan="2">
            <a href="SlsTrendByClass.jsp?STORE=<%=sStore%>&DIVISION=<%=sDivision%>&DATE=<%=sCompDate%>">Class</a></th>
          <th class="DataTable"  rowspan="2">&nbsp;&nbsp;</th>
          <th class="DataTable"  colspan="4">Week To Date</th>
          <th class="DataTable"  rowspan="2">&nbsp;&nbsp;</th>
          <th class="DataTable"  colspan="4">Month To Date</th>
          <th class="DataTable"  rowspan="2">&nbsp;&nbsp;</th>
          <th class="DataTable"  colspan="4">Quater To Date</th>
          <th class="DataTable"  rowspan="2">&nbsp;&nbsp;</th>
          <th class="DataTable"  colspan="4">Year To Date</th>
        </tr>
        <tr>
          <th class="DataTable">TY</th>
          <th class="DataTable">LY</th>
          <th class="DataTable"><a href="SlsTrendByClass.jsp?STORE=<%=sStore%>&DIVISION=<%=sDivision%>&DATE=<%=sCompDate%>&SORT=WKD">Var</a><br>($)</th>
          <th class="DataTable">
            <a href="SlsTrendByClass.jsp?STORE=<%=sStore%>&DIVISION=<%=sDivision%>&DATE=<%=sCompDate%>&SORT=WK">Var</a><br>(%)</th>
          <th class="DataTable">TY</th>
          <th class="DataTable">LY</th>
          <th class="DataTable"><a href="SlsTrendByClass.jsp?STORE=<%=sStore%>&DIVISION=<%=sDivision%>&DATE=<%=sCompDate%>&SORT=MOND">Var</a><br>($)</th>
          <th class="DataTable">
            <a href="SlsTrendByClass.jsp?STORE=<%=sStore%>&DIVISION=<%=sDivision%>&DATE=<%=sCompDate%>&SORT=MON">Var</a><br>(%)</th>
          <th class="DataTable">TY</th>
	  <th class="DataTable">LY</th>
          <th class="DataTable"><a href="SlsTrendByClass.jsp?STORE=<%=sStore%>&DIVISION=<%=sDivision%>&DATE=<%=sCompDate%>&SORT=QTRD">Var</a><br>($)</th>
          <th class="DataTable">
            <a href="SlsTrendByClass.jsp?STORE=<%=sStore%>&DIVISION=<%=sDivision%>&DATE=<%=sCompDate%>&SORT=QTR">Var</a><br>(%)</th>
          <th class="DataTable">TY</th>
          <th class="DataTable">LY</th>
          <th class="DataTable"><a href="SlsTrendByClass.jsp?STORE=<%=sStore%>&DIVISION=<%=sDivision%>&DATE=<%=sCompDate%>&SORT=YRD">Var</a><br>($)</th>
          <th class="DataTable">
            <a href="SlsTrendByClass.jsp?STORE=<%=sStore%>&DIVISION=<%=sDivision%>&DATE=<%=sCompDate%>&SORT=YR">Var</a></th>
	 </tr>
         <!-------------- Data Detail ------------------------------>

         <%String sSvDpt = null;
           for(int i=0; i < iNumOfCls; i++ ){%>
         <!-- Department Name -->
           <%if(sSvDpt == null || !sSvDpt.equals(sDpt[i])) {%>
              <tr  class="DataTable2">
                <td class="DataTable2" colspan="21" nowrap>Department:&nbsp;&nbsp;<%=sDpt[i] + " - " + sDptName[i]%></td>
              </tr>
              <%sSvDpt = sDpt[i];%>
           <%}%>


             <tr  class="<%if(sCls[i].equals("")){%>DataTable1<%} else {%>DataTable<%}%>">

             <%if(sCls[i].equals("")) {%>
                <td class="DataTable1">Department Total</td>
             <%}
             else {%>
                <td class="DataTable1" nowrap><%=sCls[i] + " - " + sClsName[i]%></td>
             <%}%>


                <th class="DataTable">&nbsp;</th>

                <td class="DataTable">$<%=sWkTySls[i]%></td>
                <td class="DataTable">$<%=sWkLySls[i]%></td>
                <td class="DataTable">$<%=sWkDiff[i]%></td>
                <td class="DataTable" nowrap><%=sWkVar[i]%>%</td>

                <th class="DataTable">&nbsp;</th>

                <td class="DataTable">$<%=sMnTySls[i]%></td>
                <td class="DataTable">$<%=sMnLySls[i]%></td>
                <td class="DataTable">$<%=sMnDiff[i]%></td>
                <td class="DataTable" nowrap><%=sMnVar[i]%>%</td>

                <th class="DataTable">&nbsp;</th>

                <td class="DataTable">$<%=sQtTySls[i]%></td>
                <td class="DataTable">$<%=sQtLySls[i]%></td>
                <td class="DataTable">$<%=sQtDiff[i]%></td>
                <td class="DataTable" nowrap><%=sQtVar[i]%>%</td>

                <th class="DataTable">&nbsp;</th>

                <td class="DataTable">$<%=sYrTySls[i]%></td>
                <td class="DataTable">$<%=sYrLySls[i]%></td>
                <td class="DataTable">$<%=sYrDiff[i]%></td>
                <td class="DataTable" nowrap><%=sYrVar[i]%>%</td>
             </tr>
           <%}%>
         <!------------------- Total -------------------------------->
      </table>
      <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
