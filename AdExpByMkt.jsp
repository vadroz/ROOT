<%@ page import="advertising.AdExpByMkt, java.util.*"%>
<%
   String sMonth = request.getParameter("Month");
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("ADVERTISES")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=AdExpense.jsp&APPL=ADVERTISES&" + request.getQueryString());
   }
   else
   {

    AdExpByMkt adexp = new AdExpByMkt(sMonth);

    int iNumOfMkt = adexp.getNumOfMkt();
    String [] sMktName = adexp.getMktName();
    String [] sMktNum = adexp.getMktNum();
    String [] sTYCost = adexp.getTYCost();
    String [] sTYSales = adexp.getTYSales();
    String [] sTYPrc = adexp.getTYPrc();

    String [] sLYCost = adexp.getLYCost();
    String [] sLYSales = adexp.getLYSales();
    String [] sLYPrc = adexp.getLYPrc();

    String sTotTYCost = adexp.getTotTYCost();
    String sTotTYSales = adexp.getTotTYSales();
    String sTotTYPrc = adexp.getTotTYPrc();

    String sTotLYCost = adexp.getTotLYCost();
    String sTotLYSales = adexp.getTotLYSales();
    String sTotLYPrc = adexp.getTotLYPrc();

    String sMonBegJsa = adexp.getMonBegJsa();
    String sMonEndJsa = adexp.getMonEndJsa();
    String sMonthJsa = adexp.getMonNameJsa();

    adexp.disconnect();
%>
<html>
<head>
<style>
        body {background:LemonChiffon; text-align:center;}
        a { color:blue} a:visited { color:blue}  a:hover { color:blue}

        table.DataTable { border: darkred solid 1px; background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center;
                       font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center;
                       font-family:Verdanda; font-size:12px }

        td.DataTable  { background:#E7E7E7; border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px; text-align:right; font-family:Arial;font-size:10px }

        td.DataTable1 { background:#E7E7E7; border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px; text-align:left; font-family:Arial;font-size:10px }

        td.DataTable2  { background:cornsilk; border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px; text-align:right; font-family:Arial;font-size:10px }

        td.DataTable3 { background:cornsilk; border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px; text-align:left; font-family:Arial;font-size:10px }

        .small{ text-align:left; font-family:Arial; font-size:10px;}

</style>
<SCRIPT language="JavaScript1.2">
//------------------------------------------------------------------------------
// global variables
//------------------------------------------------------------------------------
MonBeg = [<%=sMonBegJsa%>];
MonEnd = [<%=sMonEndJsa%>];
Month = [<%=sMonthJsa%>];
//---------------------------------------------------------
// work on loading time
//---------------------------------------------------------
function bodyLoad()
{
  loadMonth();
}
//---------------------------------------------------------
// load market in select fields
//---------------------------------------------------------
function loadMonth()
{
   document.all.SelMon.options[0] = new Option("Year-To-Date","Y-T-D");
   for(var i = 0; i < Month.length; i++)
   {
      document.all.SelMon.options[i+1] = new Option(Month[i], Month[i]);
   }
}
//---------------------------------------------------------
// get Result for selected Market
//---------------------------------------------------------
function getSelMarket()
{
   var mon = document.all.SelMon.options[document.all.SelMon.selectedIndex].value;

   var url = "AdExpByMkt.jsp?Month=" + mon;
   window.location.href = url;
}

//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, " "); }
    return s;
}
</SCRIPT>

</head>
<!-------------------------------------------------------------------->
<body onload="bodyLoad()" >
<!-------------------------------------------------------------------->
<div id="dvCalendar" class="Cal"></div>
<!-------------------------------------------------------------------->
   <b><font size="+2">Advertising Expense by Market</font><br>
   Month: <%=sMonth%></b><br><br>
   <select id="SelMon" class="small"></select>
   <button onClick = "getSelMarket()">Go</button><br>

   <a href="../"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This page.</font>
   <table class='DataTable' cellPadding="0" cellSpacing="0">
      <tr>
        <th class='DataTable' rowspan="2">Market</th>
        <th class='DataTable' colspan="3">This Year</th>
        <th class='DataTable' colspan="3">Last Year</th>
      </tr>
      <tr>
        <th class='DataTable' >Adv.<br>Expense</th>
        <th class='DataTable' >Actual<br>Sales</th>
        <th class='DataTable' >Adv<br>%</th>

        <th class='DataTable' >Adv.<br>Expense</th>
        <th class='DataTable' >Actual<br>Sales</th>
        <th class='DataTable' >Adv<br>%</th>
      </tr>
     <!---------------- Detail ---------------------------------------------------->
      <%for(int i=0; i < iNumOfMkt; i++) {%>
            <tr>
              <td class="DataTable1"><a href="AdExpense.jsp?Market=<%=sMktNum[i]%>&MktName=<%=sMktName[i]%>"><%=sMktName[i]%></a></td>

              <td class="DataTable">$<%=sTYCost[i]%></td>
              <td class="DataTable">$<%=sTYSales[i]%></td>
              <td class="DataTable"><%=sTYPrc[i]%>%</td>

              <td class="DataTable">$<%=sLYCost[i]%></td>
              <td class="DataTable">$<%=sLYSales[i]%></td>
              <td class="DataTable"><%=sLYPrc[i]%>%</td>
           </tr>
      <%}%>
      <tr>
         <td class="DataTable3"><a href="AdExpense.jsp?Market=ALL&MktName=All Markets">Year-To-Date</a></td>

         <td class="DataTable2">$<%=sTotTYCost%></td>
         <td class="DataTable2">$<%=sTotTYSales%></td>
         <td class="DataTable2"><%=sTotTYPrc%>%</td>

         <td class="DataTable2">$<%=sTotLYCost%></td>
         <td class="DataTable2">$<%=sTotLYSales%></td>
         <td class="DataTable2"><%=sTotLYPrc%>%</td>
      </tr>
    </table>
</body>
</html>

<%
   adexp.disconnect();
 }
%>

