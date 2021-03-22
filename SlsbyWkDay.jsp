<%@ page import="payrollreports.SetDayHrSls, java.util.*"%>
<% String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sMonth = request.getParameter("MONBEG");
   String sWeekEnd = request.getParameter("WEEKEND");
   String sYear = request.getParameter("YEAR");

   String [] sDaysOfWeek = new String[]{"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" } ;
   String [][] sSales = new String[7][18];
   String [][] sSalesPrc = new String[7][18];
   String [][] sTran = new String[7][18];
   String [][] sItmPerTrn = new String[7][18];
   String [][] sCommSales = new String[7][18];

   String [] sSlsTot = new String[7];
   String [] sTotTran = new String[7];
   String [] sTotItmPerTrn = new String[7];
   String [] sWeek = new String[7];

   int iDay = 0;
   int iHrs = 0;

   SetDayHrSls setSls = new SetDayHrSls(sStore, sWeekEnd, sYear);
   sSales = setSls.getSales();
   sSalesPrc = setSls.getSalesPrc();
   sTran = setSls.getTran();
   sItmPerTrn = setSls.getItmPerTrn();
   sCommSales = setSls.getCommSales();

   sSlsTot = setSls.getSalesTot();
   sTotTran = setSls.getTotTran();
   sTotItmPerTrn = setSls.getTotItmPerTrn();
   sWeek = setSls.getWeekDays();

   String sSalesJsa = setSls.getSalesJsa();
   String sSalesPrcJsa = setSls.getSalesPrcJsa();
   String sTranJsa = setSls.getTranJsa();
   String sItmPerTrnJsa = setSls.getItmPerTrnJsa();
   String sCommSalesJsa = setSls.getCommSalesJsa();

   String sPlanJsa = setSls.getPlanJsa();
   String sPlanCommJsa = setSls.getPlanCommJsa();
   String sPlanVarJsa = setSls.getPlanVarJsa();

   String sTotPlanJsa = setSls.getTotPlanJsa();
   String sTotPlanCommJsa = setSls.getTotPlanCommJsa();
   String sTotPlanVarJsa = setSls.getTotPlanVarJsa();

   String sSlsTotJsa = setSls.getSalesTotJsa();
   String sTotTranJsa = setSls.getTotTranJsa();
   String sTotItmPerTrnJsa = setSls.getTotItmPerTrnJsa();

   iDay = 7;
   iHrs = 18;
   setSls.disconnect();


   String [] sHrsCol = new String[]{"7am","8am","9am","10am","11am","12pm",
      "1pm","2pm","3pm","4pm","5pm","6pm","7pm","8pm","9pm","10pm","11pm","12pm"};

%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:lightgrey; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable1 { background:cornsilk; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }

</style>
<SCRIPT language="JavaScript">
//--------------- Global variables -----------------------
var CurStore = <%=sStore%>;
var CurStrName = "<%=sThisStrName%>";
var Month = "<%=sMonth%>"
var WeekEnd = "<%=sWeekEnd%>"

var elmColor;
var colColor;

var Sales = [<%=sSalesJsa%>];
var SalesPrc = [<%=sSalesPrcJsa%>];
var Tran = [<%=sTranJsa%>];
var ItmPerTrn = [<%=sItmPerTrnJsa%>];
var CommSales = [<%=sCommSalesJsa%>];

var Plan = [<%=sPlanJsa%>];
var PlanComm = [<%=sPlanCommJsa%>];
var PlanVar = [<%=sPlanVarJsa%>];

var TotPlan = [<%=sTotPlanJsa%>];
var TotPlanComm = [<%=sTotPlanCommJsa%>];
var TotPlanVar = [<%=sTotPlanVarJsa%>];

var TotSls = [<%=sSlsTotJsa%>];
var TotTran = [<%=sTotTranJsa%>];
var TotItmPerTrn = [<%=sTotItmPerTrnJsa%>];

//--------------- End of Global variables -----------------------

// change text color on mouse moved over table row
function mouseOver (obj)
{
  elmColor = obj.style.color;
  obj.style.color = "red";
}

// change text color on mouse moved out table row
function mouseOut (obj)
{
  obj.style.color = elmColor;
}

// change text color on mouse moved over table row
function hilightCol(obj, inout)
{
  var col = obj.id.substring(0,6);

  // save old background color
  if (inout)
  {
    colColor = obj.style.backgroundColor;
  }


  for (i=0; i < 18; i++)
  {
    if (inout)
    {
      document.getElementById(col+i).style.backgroundColor = "yellow";
    }
    else
    {
      document.getElementById(col+i).style.backgroundColor = colColor;
    }
  }
}

//==============================================================================
// display all help texts
//==============================================================================
function showOneDay(iday, wkday, date)
{
   var html = "<body style='text-align:center;'><b>Sales Distribution by Hours/Daily</b><br>"
         + "<table border=1 cellPadding='0' cellSpacing='0' width=500>"
            + "<tr style='background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-size:12px'>"
               + "<th rowspan=3>Date/<br>Hours</th>"
               + "<th colspan=11>" + wkday + "<br>" + date + "</th>"
            + "</tr>"

            + "<tr style='background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-size:12px'>"
               + "<th colspan=5>LY Sales</th>"
               + "<th rowspan=2>&nbsp;</th>"
               + "<th colspan=3>This Year Plan</th>"
            + "</tr>"

            + "<tr style='background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-size:12px'>"
               + "<th>Sls<br>$</th>"
               + "<th>Cumulative<br>Sls $</th>"
               + "<th>Sls<br>%</th>"
               + "<th># of<br>Trn</th>"
               + "<th>IPT's</th>"

               + "<th>Sales<br>$</th>"
               + "<th>Cumulative<br> Plan $</th>"
               + "<th>Sls<br>%</th>"
            + "</tr>"
            + popDailyTable(iday)
           html += "</table>";

   var MyWindowName = "Daily_Sales_Distribution_by_Hours";
   var MyWindowOptions =
    "left=20, top=20, width=800,height=600, toolbar=yes, location=yes, directories=yes, status=yes, scrollbars=yes, menubar=yes, scrollbars=1, resizable=yes";

   window_help = window.open("", MyWindowName, MyWindowOptions);
   window_help.document.write(html);
   window_help.document.close();
}
//==============================================================================
// populate daily table
//==============================================================================
function popDailyTable(iday)
{
   var HrsCol = ["7am","8am","9am","10am","11am","12pm",
      "1pm","2pm","3pm","4pm","5pm","6pm","7pm","8pm","9pm","10pm","11pm","12pm"];
   var html = "";

   for(var i=0; i < 18; i++)
   {
     html += "<tr style='background:white; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px'>"
            + "<th>" + HrsCol[i] + "</th>"
            + "<td>$" + Sales[iday][i] + "</td>"
            + "<td>$" + CommSales[iday][i] + "</td>"
            + "<td>" + SalesPrc[iday][i] + "%</td>"
            + "<td>" + Tran[iday][i] + "</td>"
            + "<td>" + ItmPerTrn[iday][i] + "</td>"

            + "<th>&nbsp;</th>"

            + "<td>$" + Plan[iday][i] + "</td>"
            + "<td>$" + PlanComm[iday][i] + "</td>"
            + "<td>" + PlanVar[iday][i] + "%</td>"
          + "</tr>"
   }

   html += "<tr style='background:Cornsilk; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px'>"
            + "<th>Total</th>"
            + "<td>$" + TotSls[iday] + "</td>"
            + "<td>$" + TotSls[iday] + "</td>"
            + "<td>100%</td>"
            + "<td>" + TotTran[iday] + "</td>"
            + "<td>" + TotItmPerTrn[iday] + "</td>"

            + "<th>&nbsp;</th>"

            + "<td>$" + TotPlan[iday] + "</td>"
            + "<td>$" + TotPlanComm[iday] + "</td>"
            + "<td>" + TotPlanVar[iday] + "%</td>"
          + "</tr>"

   return html;
}
</SCRIPT>
</head>
<body>
    <table border="0" width="100%" height="100%">
             <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP" colspan=2>
      <b>Retail Concepts, Inc
      <br>Sales Distribution by Hours/Week</b><br>
<!-------------------------------------------------------------------->
        <b>Store:&nbsp;<%=sStore + " - " + sThisStrName%></b>
      <p>
        <a href="../index.html"><font color="red" size="-1">Home</font></a>&#62;
        <!--a href="StrScheduling.html"><font color="red" size="-1">Payroll</font></a -->
        <a href="SlsbyWkSel.jsp"><font color="red" size="-1">Store/Week Selector</font></a>&#62;
        <font size="-1">This page</font>
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
         <th class="DataTable" rowspan="2">Date/<br>Hours</th>
           <%for(int i=0; i < 7; i++ ){%>
             <th class="DataTable" colspan="4"><a href="javascript: showOneDay('<%=i%>', '<%=sDaysOfWeek[i]%>', '<%=sWeek[i]%>')"><%=sDaysOfWeek[i]%></a>
                 <br><%=sWeek[i]%></th>
             <th class="DataTable" >&nbsp;&nbsp;</th>
           <%}%>
           <th class="DataTable" rowspan="2">Date/<br>Hours</th>
         </tr>
         <tr>
           <%for(int i=0; i < 7; i++ ){%>
             <th class="DataTable">Sls<br>$</th>
             <th class="DataTable">Sls<br>%</th>
             <th class="DataTable"># of<br>Trn<br>&nbsp;</th>
             <th class="DataTable">IPT's</th>
             <th class="DataTable" >&nbsp;&nbsp;</th>
           <%}%>
         </tr>

         <!-------------- Data Detail ------------------------------>
         <%for(int i=0; i < iHrs; i++ ){%>
             <tr>
                <th class="DataTable" ><%=sHrsCol[i]%></th>
                <%for(int j=0; j < iDay; j++ ){%>
                  <td class="DataTable" nowrap>$<%=sSales[j][i]%></td>
                  <td class="DataTable" nowrap><%=sSalesPrc[j][i]%>%</td>
                  <td class="DataTable" nowrap><%=sTran[j][i]%></td>
                  <td class="DataTable" nowrap><%=sItmPerTrn[j][i]%></td>
                  <th class="DataTable" >&nbsp;&nbsp;</th>
               <%}%>
               <th class="DataTable" ><%=sHrsCol[i]%></th>
             </tr>
           <%}%>
         <!------------------- Total -------------------------------->

         <tr>
           <th class="DataTable" nowrap>Total</th>
           <%for(int i=0; i < iDay; i++ ){%>
                <td class="DataTable2" nowrap>$<%=sSlsTot[i]%></td>
                <td class="DataTable2" nowrap>100%</td>
                <td class="DataTable2" nowrap><%=sTotTran[i]%></td>
                <td class="DataTable2" nowrap><%=sTotItmPerTrn[i]%></td>
                <th class="DataTable" >&nbsp;&nbsp;</th>
           <%}%>
           <th class="DataTable" nowrap>Total</th>
         </tr>
      </table>
      <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
