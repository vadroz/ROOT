<%@ page import="payrollreports.SetWkBdgHrs, java.util.*"%>
<%
   String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sWeekend = request.getParameter("WEEKEND");
   String sMonth = request.getParameter("MONBEG");

   String [] sBdgHrs = null;
   String [] sBdgGrpHrs = null;
   String [] sSchHrs = null;
   String [] sSchGrpHrs = null;

   SetWkBdgHrs wkBdg = new SetWkBdgHrs(sStore, sWeekend);

   sBdgHrs = wkBdg.getBdgHrs();
   sBdgGrpHrs = wkBdg.getBdgGrpHrs();
   sSchHrs = wkBdg.getSchHrs();
   sSchGrpHrs = wkBdg.getSchGrpHrs();
   String [] sActHrs = wkBdg.getActHrs();
   String [] sActGrpHrs = wkBdg.getActGrpHrs();

   String [] sBdgVar = wkBdg.getBdgVar();
   String [] sBdgGrpVar = wkBdg.getBdgGrpVar();
   String [] sActVar = wkBdg.getActVar();
   String [] sActGrpVar = wkBdg.getActGrpVar();

   String [] sBdgClr = wkBdg.getBdgClr();
    String [] sBdgGrpClr = wkBdg.getBdgGrpClr();
    String [] sActClr = wkBdg.getActClr();
    String [] sActGrpClr = wkBdg.getActGrpClr();

   wkBdg.disconnect();

%>
<html>
<head>
<style>
        body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        a.Menu:link { color:black; text-decoration:none }
        a.Menu:visited { color:black; text-decoration:none }
        a.Menu:hover { color:red; text-decoration:none }

        table.DataTable { border: darkred solid 1px; background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.Detail  { background:lightgrey; font-family:Arial; font-size:10px }
        tr.Total  { background:seashell; font-family:Arial; font-size:10px }
        tr.Total1  { background:cornsilk; font-family:Arial; font-size:10px }
        td.DataTable { padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left; }
        td.DataTable1 { padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px;
                       border-Bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right; }
        td.Group { background:cornsilk; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px;
                       border-Bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:left; }


</style>
<SCRIPT language="JavaScript1.2">
</SCRIPT>
</head>
<!-------------------------------------------------------------------->
<body >
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
  <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin"><td ALIGN="center" VALIGN="TOP" colspan="3">
      <b>Weekly Budget Hours</b>
     </tr>
     <tr bgColor="moccasin">
        <td ALIGN="center" VALIGN="TOP">
           <b>&nbsp;Store:&nbsp;<%=sStore + " - " + sThisStrName%></b><br>
           <b>Week Ending:&nbsp;<%=sWeekend%>&nbsp;<br>
           (Matches: Total Store Payroll (no exclusion)</b></td>
     </tr>
     <tr bgColor="moccasin">
        <td ALIGN="center" VALIGN="TOP" colspan="3">
        <a href="../"><font color="red" size="-1">Home</font></a>&#62;
         <font color="red" size="-1">This page</font><br>

<!------------- start of dollars table ------------------------>
   <table class="DataTable" cellPadding="0" cellSpacing="0">
     <tr>
       <th class="DataTable" rowspan="2">Group</th>
       <th class="DataTable" rowspan="2">&nbsp;</th>
       <th class="DataTable" colspan="2">Final Schedule</th>
       <th class="DataTable" rowspan="2">&nbsp;</th>
       <th class="DataTable" colspan="3">Original Budget</th>
       <th class="DataTable" rowspan="2">&nbsp;</th>
       <th class="DataTable" colspan="3">Actual</th>
     </tr>
     <tr>
       <th class="DataTable">Department</th>
       <th class="DataTable">Hours</th>
       <th class="DataTable">Department</th>
       <th class="DataTable">Hours</th>
       <th class="DataTable">Var</th>
       <th class="DataTable">Department</th>
       <th class="DataTable">Hours</th>
       <th class="DataTable">Var</th>
     </tr>

<!-------------------- Detail ---------------------------->
<!-------------------------------------------------------->
<!-------------------- Management ------------------------>
     <tr class="Detail">
       <td class="Group" rowspan="3">Management</td>
       <th class="DataTable">&nbsp;&nbsp;</th>
       <td class="DataTable" rowspan="2">Management</td>
       <td class="DataTable1" rowspan="2"><%=sSchHrs[0]%></td>
       <th class="DataTable">&nbsp;&nbsp;</th>
       <td class="DataTable">Management</td>
       <td class="DataTable1"><%=sBdgHrs[0]%></td>
       <td class="DataTable1" rowspan="2"><font color=<%=sBdgClr[0]%>><%=sBdgVar[0]%></font></td>
       <th class="DataTable">&nbsp;&nbsp;</th>
       <td class="DataTable" rowspan="2">Management</td>
       <td class="DataTable1" rowspan="2"><%=sActHrs[0]%></td>
       <td class="DataTable1" rowspan="2"><font color=<%=sActClr[0]%>><%=sActVar[0]%></font></td>
     </tr>

     <tr class="Detail">
       <th class="DataTable">&nbsp;</th>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Hourly Managers</td>
       <td class="DataTable1"><%=sBdgHrs[2]%></td>
       <th class="DataTable">&nbsp;&nbsp;</th>
     </tr>
     <tr class="Total">
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Total</td>
       <td class="DataTable1"><%=sSchGrpHrs[0]%></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Total</td>
       <td class="DataTable1"><%=sBdgGrpHrs[0]%></td>
       <td class="DataTable1"><font color=<%=sBdgGrpClr[1]%>><%=sBdgGrpVar[0]%></font></td>
       <th class="DataTable">&nbsp;&nbsp;</th>
       <td class="DataTable">Total</td>
       <td class="DataTable1"><%=sActGrpHrs[0]%></td>
       <td class="DataTable1"><font color=<%=sActGrpClr[0]%>><%=sActGrpVar[0]%></font></td>
     </tr>
<!-------------------- Selling ------------------------>
     <tr class="Detail">
       <td class="Group" rowspan="3">Selling</td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Regular</td>
       <td class="DataTable1"><%=sSchHrs[1]%></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable" >Selling</td>
       <td class="DataTable1"><%=sBdgHrs[3]%></td>
       <td class="DataTable1" rowspan="2"><font color=<%=sBdgClr[1]%>><%=sBdgVar[1]%></font></td>
       <th class="DataTable">&nbsp;&nbsp;</th>
       <td class="DataTable">Regular</td>
       <td class="DataTable1"><%=sActHrs[1]%></td>
       <td class="DataTable1"><font color=<%=sActClr[1]%>><%=sActVar[1]%></font></td>
     </tr>
     <tr class="Detail">
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Bike</td>
       <td class="DataTable1"><%=sSchHrs[2]%></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable" >Bike Manager</td>
       <td class="DataTable1"><%=sBdgHrs[1]%></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Bike</td>
       <td class="DataTable1"><%=sActHrs[2]%></td>
       <td class="DataTable1"><font color=<%=sActClr[2]%>><%=sActVar[2]%></font></td>
     </tr>
     <tr class="Total">
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Total</td>
       <td class="DataTable1"><%=sSchGrpHrs[1]%></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Total</td>
       <td class="DataTable1"><%=sBdgGrpHrs[1]%></td>
       <td class="DataTable1"><font color=<%=sBdgGrpClr[1]%>><%=sBdgGrpVar[1]%></font></td>
       <th class="DataTable">&nbsp;&nbsp;</th>
       <td class="DataTable">Total</td>
       <td class="DataTable1"><%=sActGrpHrs[1]%></td>
       <td class="DataTable1"><font color=<%=sActGrpClr[1]%>><%=sActGrpVar[1]%></font></td>
     </tr>
<!-------------------- Non-Selling ------------------------>
     <tr class="Detail">
       <td class="Group" rowspan="11">Non-Selling</td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Cashiers</td>
       <td class="DataTable1"><%=sSchHrs[3]%></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Ops/Cashiers</td>
       <td class="DataTable1"><%=sBdgHrs[4]%></td>
       <td class="DataTable1"><font color=<%=sBdgClr[2]%>><%=sBdgVar[2]%></font></td>
       <th class="DataTable">&nbsp;&nbsp;</th>
       <td class="DataTable">Cashiers</td>
       <td class="DataTable1"><%=sActHrs[3]%></td>
       <td class="DataTable1"><font color=<%=sActClr[3]%>><%=sActVar[3]%></font></td>
     </tr>
     <tr class="Detail">
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Receiving</td>
       <td class="DataTable1"><%=sSchHrs[4]%></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Shipping/Receiving</td>
       <td class="DataTable1"><%=sBdgHrs[5]%></td>
       <td class="DataTable1"><font color=<%=sBdgClr[3]%>><%=sBdgVar[3]%></font></td>
       <th class="DataTable">&nbsp;&nbsp;</th>
       <td class="DataTable">Receiving</td>
       <td class="DataTable1"><%=sActHrs[4]%></td>
       <td class="DataTable1"><font color=<%=sActClr[4]%>><%=sActVar[4]%></font></td>
     </tr>

     <!-- ================================================================== -->
     <!-- Bike shop -->
     <tr class="Detail">
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable" rowspan="3">Bike Shop</td>
       <td class="DataTable1" rowspan="3"><%=sSchHrs[5]%></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Bike Tech</td>
       <td class="DataTable1"><%=sBdgHrs[6]%></td>
       <td class="DataTable1" rowspan="3"><font color=<%=sBdgClr[4]%>><%=sBdgVar[4]%></font></td>
       <th class="DataTable">&nbsp;&nbsp;</th>
       <td class="DataTable" rowspan="3">Bike Shop</td>
       <td class="DataTable1" rowspan="3"><%=sActHrs[5]%></td>
       <td class="DataTable1" rowspan="3"><font color=<%=sActClr[5]%>><%=sActVar[5]%></font></td>
     </tr>
     <tr class="Detail">
       <th class="DataTable">&nbsp;</th>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Bike Builder</td>
       <td class="DataTable1"><%=sBdgHrs[7]%></td>
       <th class="DataTable">&nbsp;&nbsp;</th>
     </tr>
     <tr class="Detail">
       <th class="DataTable">&nbsp;</th>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Bike Service Manager</td>
       <td class="DataTable1"><%=sBdgHrs[9]%></td>
       <th class="DataTable">&nbsp;&nbsp;</th>
     </tr>

     <!-- ================================================================== -->
     <!-- Ohter -->
     <!--  0    1    2    3    4     5     6      7    8      9    10   11  12   -->
     <!--  1    2    3    4     5     6      7    8     9     10   11    12  13  -->
     <!-- MNGR SLSP CASH SHIP BKTCH BKBLD DRIVR BSRVM SKTCH INSTR MERCH TMC BACK -->
     <tr class="Detail">
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable" rowspan="5">Other</td>
       <td class="DataTable1" rowspan="5"><%=sSchHrs[6]%></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Ski Tech</td>
       <td class="DataTable1"><%=sBdgHrs[10]%></td>
       <td class="DataTable1" rowspan="5"><font color=<%=sBdgClr[5]%>><%=sBdgVar[5]%></font></td>
       <th class="DataTable">&nbsp;&nbsp;</th>
       <td class="DataTable" rowspan="5">Other</td>
       <td class="DataTable1" rowspan="5"><%=sActHrs[6]%></td>
       <td class="DataTable1" rowspan="5"><font color=<%=sActClr[6]%>><%=sActVar[6]%></font></td>
     </tr>
     <tr class="Detail">
       <th class="DataTable">&nbsp;</th>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Instructors</td>
       <td class="DataTable1"><%=sBdgHrs[11]%></td>
       <th class="DataTable">&nbsp;</th>
     </tr>

     <tr class="Detail">
       <th class="DataTable">&nbsp;</th>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Merchandisers</td>
       <td class="DataTable1"><%=sBdgHrs[12]%></td>
       <th class="DataTable">&nbsp;</th>
     </tr>
     <tr class="Detail">
       <th class="DataTable">&nbsp;</th>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Drivers</td>
       <td class="DataTable1"><%=sBdgHrs[8]%></td>
       <th class="DataTable">&nbsp;</th>
     </tr>
     <tr class="Detail">
       <th class="DataTable">&nbsp;</th>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Back Stock</td>
       <td class="DataTable1"><%=sBdgHrs[14]%></td>
       <th class="DataTable">&nbsp;</th>
     </tr>

     <tr class="Total">
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Total</td>
       <td class="DataTable1"><%=sSchGrpHrs[2]%></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Total</td>
       <td class="DataTable1"><%=sBdgGrpHrs[2]%></td>
       <td class="DataTable1"><font color=<%=sBdgGrpClr[2]%>><%=sBdgGrpVar[2]%></font></td>
       <th class="DataTable">&nbsp;&nbsp;</th>
       <td class="DataTable">Total</td>
       <td class="DataTable1"><%=sActGrpHrs[2]%></td>
       <td class="DataTable1"><font color=<%=sActGrpClr[2]%>><%=sActGrpVar[2]%></font></td>
     </tr>
<!-------------------- Training ------------------------->
     <tr class="Detail">
       <td class="Group" rowspan="2">Training</td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Training</td>
       <td class="DataTable1"><%=sSchHrs[7]%></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Training/Meeting/Clinicks</td>
       <td class="DataTable1"><%=sBdgHrs[13]%></td>
       <td class="DataTable1"><font color=<%=sBdgClr[6]%>><%=sBdgVar[6]%></font></td>
       <th class="DataTable">&nbsp;&nbsp;</th>
       <td class="DataTable">Training  (Memo) </td>
       <td class="DataTable1"><%=sActHrs[7]%></td>
       <td class="DataTable1"><font color=<%=sActClr[7]%>><%=sActVar[7]%></font></td>
     </tr>
     <tr class="Total">
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Total</td>
       <td class="DataTable1"><%=sSchGrpHrs[3]%></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Total</td>
       <td class="DataTable1"><%=sBdgGrpHrs[3]%></td>
       <td class="DataTable1"><font color=<%=sBdgGrpClr[3]%>><%=sBdgGrpVar[3]%></font></td>
       <th class="DataTable">&nbsp;&nbsp;</th>
       <td class="DataTable">Total</td>
       <td class="DataTable1"><%=sActGrpHrs[3]%></td>
       <td class="DataTable1"><font color=<%=sActGrpClr[3]%>><%=sActGrpVar[3]%></font></td>
     </tr>
<!-------------------- Totals ------------------------->
     <tr class="Total1">
       <td class="DataTable">Total</td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">&nbsp;</td>
       <td class="DataTable1"><%=sSchGrpHrs[4]%></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">&nbsp;</td>
       <td class="DataTable1"><%=sBdgGrpHrs[4]%></td>
       <td class="DataTable1"><font color=<%=sBdgGrpClr[4]%>><%=sBdgGrpVar[4]%></font></td>
       <th class="DataTable">&nbsp;&nbsp;</th>
       <td class="DataTable">&nbsp;</td>
       <td class="DataTable1"><%=sActGrpHrs[4]%></td>
       <td class="DataTable1"><font color=<%=sActGrpClr[4]%>><%=sActGrpVar[4]%></font></td>
     </tr>

     </table>
<!------------- end of data table ------------------------>
                </td>
            </tr>
       </table>


  </body>
</html>
