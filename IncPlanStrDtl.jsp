<%@ page import="payrollreports.IncPlanStrDtl, java.util.*"%>
<%
   String sQtr = request.getParameter("Qtr");
   String sStr = request.getParameter("STORE");

   if(sStr.length()==1) sStr = "0" + sStr;

   IncPlanStrDtl incp = new IncPlanStrDtl(sQtr, sStr);

   String [] sMon = incp.getMon();
   int [] iNumOfWeek = incp.getNumOfWeek();
   String [][]sWeek = incp.getWeek();

   String [][]sMnPlan = incp.getMnPlan();
   String [] sQtdPlan = incp.getQtdPlan();

   String [][]sMnSales = incp.getMnSales();
   String [] sQtdSales = incp.getQtdSales();

   String [][]sMnPlnSlsVar = incp.getMnPlnSlsVar();
   String [][]sMnPsvClr = incp.getMnPsvClr();
   String [] sQtdPlnSlsVar = incp.getQtdPlnSlsVar();
   String [] sQtdPsvClr = incp.getQtdPsvClr();

   String [][] sMnSalHrs = incp.getMnSalHrs();
   String [][] sMnHrlHrs = incp.getMnHrlHrs();
   String [][] sMnOv45Hrs = incp.getMnOv45Hrs();
   String [][] sMnSicHrs = incp.getMnSicHrs();
   String [][] sMnVacHrs = incp.getMnVacHrs();
   String [][] sMnHolHrs = incp.getMnHolHrs();
   String [][] sMnTotHrs = incp.getMnTotHrs();
   String [][]sMnGrnTotHrs = incp.getMnGrnTotHrs();
   String [][]sMnActTotHrs = incp.getMnActTotHrs();

   String [] sQtdSalHrs = incp.getQtdSalHrs();
   String [] sQtdHrlHrs = incp.getQtdHrlHrs();
   String [] sQtdOv45Hrs = incp.getQtdOv45Hrs();
   String [] sQtdSicHrs = incp.getQtdSicHrs();
   String [] sQtdVacHrs = incp.getQtdVacHrs();
   String [] sQtdHolHrs = incp.getQtdHolHrs();
   String [] sQtdTotHrs = incp.getQtdTotHrs();
   String [] sQtdGrnTotHrs = incp.getQtdGrnTotHrs();
   String [] sQtdActTotHrs = incp.getQtdActTotHrs();

   String [][]sMnBdgOrgHrs = incp.getMnBdgOrgHrs();
   String [] sQtdBdgOrgHrs = incp.getQtdBdgOrgHrs();
   String [][]sMnAddHrs = incp.getMnAddHrs();
   String [] sQtdAddHrs = incp.getQtdAddHrs();
   String [][]sMnTmcHrs = incp.getMnTmcHrs();
   String [] sQtdTmcHrs = incp.getQtdTmcHrs();
   String [][]sMnBdgAdjHrs = incp.getMnBdgAdjHrs();
   String [] sQtdBdgAdjHrs = incp.getQtdBdgAdjHrs();

   String [][]sMnActTmc = incp.getMnActTmc();
   String [] sQtdActTmc = incp.getQtdActTmc();

   String [][]sMnBdAcHrVar = incp.getMnBdAcHrVar();
   String [][]sMnBavClr = incp.getMnBavClr();
   String [] sQtdBdAcHrVar = incp.getQtdBdAcHrVar();
   String [] sQtdBavClr = incp.getQtdBavClr();

   incp.disconnect();
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
  th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                 padding-left:2px; padding-right:2px; border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

  tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }
  tr.DataTable1 { background:cornsilk; font-family:Arial; font-size:10px }
  tr.DataTable2 { background:seashell; font-family:Arial; font-size:10px }

  td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:right;}
  td.DataTable1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:left;}
  td.Qtd { background:cornsilk; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:right;}

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Type = "ALL";
//--------------- End of Global variables ----------------
//---------------------------------------------
// initialize value on load
//---------------------------------------------
function  bodyload()
{
  document.all.AllDtl.style.display="block";
  document.all.ActOnly.style.display="none";
}

//---------------------------------------------------
// switch from All detail table to active Only Table
//---------------------------------------------------
function switchDtl()
{
  if(Type == "ALL")
  {
    document.all.AllDtl.style.display="none";
    document.all.ActOnly.style.display="block";
    Type = "ACTIVE";
  }
  else
  {
    document.all.AllDtl.style.display="block";
    document.all.ActOnly.style.display="none";
    Type = "ALL";
  }
}
</SCRIPT>


</head>
<body onload="bodyload()">
 <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
   <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Incentive Plan - Store Details
      <br>Store: <%=sStr%>
      </b></td>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="StrScheduling.html">
         <font color="red" size="-1">Store Scheduling</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp
      <a href="javascript:switchDtl()">
         <font color="red" size="-1">Actual Details Only</font></a>
      &nbsp;&nbsp;&nbsp;&nbsp;
      <a class="blue" href="servlet/payrollreports.BudgetvsActual?PosTo=STR<%=sStr%>&Month=1"><font color="red" size="-1">Go to: Total Store Payroll (with exclusions)</font></a>
      </td>
   </tr>
   <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
<!-------------------------------------------------------------------->
  <!----------------- beginning of table ------------------------>
  <table class="DataTable" cellPadding="0" cellSpacing="0" id="AllDtl">
    <tr>
      <th class="DataTable" rowspan="3">Weekending</th>
      <th class="DataTable" rowspan="3" >&nbsp;</th>
      <th class="DataTable" colspan="3">Sales vs. Plan</th>
      <th class="DataTable" rowspan="3" >&nbsp;</th>
      <th class="DataTable" colspan="13">Budget vs. Actual Hours</th>
    </tr>
    <tr>
      <th class="DataTable" rowspan="2">Plan<br>Sales</th>
      <th class="DataTable" rowspan="2">Actual<br>Sales</th>
      <th class="DataTable" rowspan="2">Var</th>
      <th class="DataTable" colspan="4">Actual<br>(Excl. S,V,H & Over 45)</th>
      <th class="DataTable" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="4">Budget</th>
      <th class="DataTable" rowspan="2" >&nbsp;</th>
      <th class="DataTable" rowspan="2">Var</th>
    </tr>
    <tr>
      <th class="DataTable">Sal</th>
      <th class="DataTable">Hrl</th>
      <th class="DataTable">T/M/C<br>(Memo)</th>
      <th class="DataTable" >Total</th>

      <th class="DataTable">Original<br>Budget</th>
      <th class="DataTable">T/M/C<br>(Memo)</th>
      <th class="DataTable">Excess<br>Sales Hrs</th>
      <th class="DataTable">Total</th>
    </tr>
<!------------------------------- Monthly loop --------------------------------->
   <%for(int i=0; i < 3; i++){%>
<!------------------------------- Weekly Loop  --------------------------------->
     <%for(int j=0; j < iNumOfWeek[i]; j++){%>
      <tr class="DataTable">
         <td class="DataTable1" nowrap><%=sWeek[i][j]%></td>
         <th class="DataTable">&nbsp;</th>
         <td class="DataTable" nowrap>$<%=sMnPlan[i][j]%></td>
         <td class="DataTable" nowrap>$<%=sMnSales[i][j]%></td>
         <td class="DataTable" nowrap>$<%=sMnPlnSlsVar[i][j]%></td>

         <th class="DataTable">&nbsp;</th>
         <td class="DataTable" nowrap><%=sMnSalHrs[i][j]%></td>
         <td class="DataTable" nowrap><%=sMnHrlHrs[i][j]%></td>
         <td class="DataTable" nowrap><%=sMnActTmc[i][j]%></td>
         <td class="DataTable" nowrap><%=sMnActTotHrs[i][j]%></td>

         <th class="DataTable">&nbsp;</th>
         <td class="DataTable" nowrap><%=sMnBdgOrgHrs[i][j]%></td>
         <td class="DataTable" nowrap><%=sMnTmcHrs[i][j]%></td>
         <td class="DataTable" nowrap><%=sMnAddHrs[i][j]%></td>
         <td class="DataTable" nowrap><%=sMnBdgAdjHrs[i][j]%></td>

         <th class="DataTable">&nbsp;</th>
         <td class="DataTable" nowrap><%=sMnBdAcHrVar[i][j]%></td>
      </tr>
     <%}%>
<!------------------------------- End Weekly Loop ------------------------------>
     <tr class="DataTable1">
       <td class="DataTable1" nowrap><%=sMon[i]%></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable" nowrap><%=sQtdPlan[i]%></td>
       <td class="DataTable" nowrap><%=sQtdSales[i]%></td>
       <td class="DataTable" nowrap><%=sQtdPlnSlsVar[i]%></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable" nowrap><%=sQtdSalHrs[i]%></td>
       <td class="DataTable" nowrap><%=sQtdHrlHrs[i]%></td>
       <td class="DataTable" nowrap><%=sQtdActTmc[i]%></td>
       <td class="DataTable" nowrap><%=sQtdActTotHrs[i]%></td>

       <th class="DataTable">&nbsp;</th>
       <td class="DataTable" nowrap><%=sQtdBdgOrgHrs[i]%></td>
       <td class="DataTable" nowrap><%=sQtdTmcHrs[i]%></td>
       <td class="DataTable" nowrap><%=sQtdAddHrs[i]%></td>
       <td class="DataTable" nowrap><%=sQtdBdgAdjHrs[i]%></td>

       <th class="DataTable">&nbsp;</th>
       <td class="DataTable" nowrap><%=sQtdBdAcHrVar[i]%></td>
     </tr>
   <%}%>
<!------------------------------- End Monthly loop ----------------------------->
<!---------------------------------- ReportTotal ------------------------------->
     <tr class="DataTable1"></tr><tr class="DataTable1"></tr>
     <tr class="DataTable1">
       <td class="DataTable1" nowrap>Q-T-D</td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable" nowrap><%=sQtdPlan[3]%></td>
       <td class="DataTable" nowrap><%=sQtdSales[3]%></td>
       <td class="DataTable" nowrap><%=sQtdPlnSlsVar[3]%></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable" nowrap><%=sQtdSalHrs[3]%></td>
       <td class="DataTable" nowrap><%=sQtdHrlHrs[3]%></td>
       <td class="DataTable" nowrap><%=sQtdActTmc[3]%></td>
       <td class="DataTable" nowrap><%=sQtdActTotHrs[3]%></td>

       <th class="DataTable">&nbsp;</th>
       <td class="DataTable" nowrap><%=sQtdBdgOrgHrs[3]%></td>
       <td class="DataTable" nowrap><%=sQtdTmcHrs[3]%></td>
       <td class="DataTable" nowrap><%=sQtdAddHrs[3]%></td>
       <td class="DataTable" nowrap><%=sQtdBdgAdjHrs[3]%></td>

       <th class="DataTable">&nbsp;</th>
       <td class="DataTable" nowrap><%=sQtdBdAcHrVar[3]%></td>
     </tr>
<!------------------------------- End Report Total ----------------------------->
    </table>
 <!----------------------- end of table ------------------------>
 <!-- ****************************************************************** ->
 <!-- ****************************************************************** ->
 <!-- ****************** Active Details Only *************************** ->
 <!-- ****************************************************************** ->
  <!----------------- beginning of table ------------------------>
  <table class="DataTable" cellPadding="0" cellSpacing="0" id="ActOnly">
    <tr>
      <th class="DataTable" rowspan="3">Weekending</th>
      <th class="DataTable" rowspan="3" >&nbsp;</th>
      <th class="DataTable" colspan="9">Total Actual Hours (No Exclusions)</th>
    </tr>
    <tr>
      <th class="DataTable" colspan="3"> Actual<br>(Excl. S,V,H & Over 45)</th>
      <th class="DataTable" rowspan="2">Sick</th>
      <th class="DataTable" rowspan="2">Vac</th>
      <th class="DataTable" rowspan="2">Hol</th>
      <th class="DataTable" rowspan="2">Over 45</th>
      <th class="DataTable" rowspan="2">T/M/C<br>(Memo)</th>
      <th class="DataTable" rowspan="2">Total<br>Hours</th>
    </tr>
    <tr>
      <th class="DataTable">Sal</th>
      <th class="DataTable">Hrl</th>
      <th class="DataTable">Sub-<br>Total</th>
    </tr>
<!------------------------------- Monthly loop --------------------------------->
   <%for(int i=0; i < 3; i++){%>
<!------------------------------- Weekly Loop  --------------------------------->
     <%for(int j=0; j < iNumOfWeek[i]; j++){%>
      <tr class="DataTable">
         <td class="DataTable1" nowrap><%=sWeek[i][j]%></td>
         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap><%=sMnSalHrs[i][j]%></td>
         <td class="DataTable" nowrap><%=sMnHrlHrs[i][j]%></td>
         <td class="DataTable" nowrap><%=sMnTotHrs[i][j]%></td>
         <td class="DataTable" nowrap><%=sMnSicHrs[i][j]%></td>
         <td class="DataTable" nowrap><%=sMnVacHrs[i][j]%></td>
         <td class="DataTable" nowrap><%=sMnHolHrs[i][j]%></td>
         <td class="DataTable" nowrap><%=sMnOv45Hrs[i][j]%></td>
         <td class="DataTable" nowrap><%=sMnActTmc[i][j]%></td>
         <td class="DataTable" nowrap><%=sMnGrnTotHrs[i][j]%></td>
      </tr>
     <%}%>
<!------------------------------- End Weekly Loop ------------------------------>
     <tr class="DataTable1">
       <td class="DataTable1" nowrap><%=sMon[i]%></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable" nowrap><%=sQtdSalHrs[i]%></td>
       <td class="DataTable" nowrap><%=sQtdHrlHrs[i]%></td>
       <td class="DataTable" nowrap><%=sQtdTotHrs[i]%></td>
       <td class="DataTable" nowrap><%=sQtdSicHrs[i]%></td>
       <td class="DataTable" nowrap><%=sQtdVacHrs[i]%></td>
       <td class="DataTable" nowrap><%=sQtdHolHrs[i]%></td>
       <td class="DataTable" nowrap><%=sQtdOv45Hrs[i]%></td>
       <td class="DataTable" nowrap><%=sQtdActTmc[i]%></td>
       <td class="DataTable" nowrap><%=sQtdGrnTotHrs[i]%></td>
     </tr>
   <%}%>
<!------------------------------- End Monthly loop ----------------------------->
<!---------------------------------- ReportTotal ------------------------------->
     <tr class="DataTable1"></tr><tr class="DataTable1"></tr>
     <tr class="DataTable1">
       <td class="DataTable1" nowrap>Q-T-D</td>
       <th class="DataTable">&nbsp;</th>

       <td class="DataTable" nowrap><%=sQtdSalHrs[3]%></td>
       <td class="DataTable" nowrap><%=sQtdHrlHrs[3]%></td>
       <td class="DataTable" nowrap><%=sQtdTotHrs[3]%></td>
       <td class="DataTable" nowrap><%=sQtdSicHrs[3]%></td>
       <td class="DataTable" nowrap><%=sQtdVacHrs[3]%></td>
       <td class="DataTable" nowrap><%=sQtdHolHrs[3]%></td>
       <td class="DataTable" nowrap><%=sQtdOv45Hrs[3]%></td>
       <td class="DataTable" nowrap><%=sQtdActTmc[3]%></td>
       <td class="DataTable" nowrap><%=sQtdGrnTotHrs[3]%></td>

     </tr>
<!------------------------------- End Report Total ----------------------------->
    </table>
 <!----------------------- end of table ------------------------>





  </table>
 </body>
</html>
