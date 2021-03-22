<%@ page import="payrollreports.PrWkPay, java.util.*"%>
<%
   String sStore = request.getParameter("STORE");
   String sStrName = request.getParameter("STRNAME");
   String sWeekend = request.getParameter("WEEKEND");
   String sMonth = request.getParameter("MONBEG");
   String sSort = request.getParameter("SORT");

   if(sSort == null) sSort = "SGEMP";
   String sGrpType = sSort.substring(0,2);
   String sReverse = null;
   if(sGrpType.equals("SG")) sReverse = "GP" + sSort.substring(2);
   else sReverse = "SG" + sSort.substring(2);

  //-------------- Security ---------------------
   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
  {
     response.sendRedirect("SignOn1.jsp?TARGET=PrWkPay.jsp&APPL=" + sAppl + "&" + request.getQueryString());
  }

  // -------------- End Security -----------------
   else
   {
     PrWkPay wkpay = new PrWkPay(sStore, sWeekend, sSort);

     int iNumOfSec = wkpay.getNumOfSec();
     int iNumOfGrp = wkpay.getNumOfGrp();
     int [] iNumSecGrp = wkpay.getNumSecGrp();
     String [] sSecLst = wkpay.getSecLst();
     String [] sSecName = wkpay.getSecName();
     String [] sGrpLst = wkpay.getGrpLst();
     String [] sGrpName = wkpay.getGrpName();
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

        td.DataTable2 { color:brown;  background: Linen; border-top: darkred solid 1px; border-bottom: darkred solid 1px; padding-top:0px; padding-bottom:0px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }

        td.Total  { background:cornsilk; border-top: darkred solid 1px; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
        td.Total1 { background:cornsilk; border-top: darkred solid 1px; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.Total2 { background:cornsilk; border-top: darkred solid 1px; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.Total3 { color:red; background:cornsilk; border-right: darkred solid 1px; border-top: double darkred; border-bottom: darkred solid 1px; padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:11px; font-weight:bold }
        td.Total4 { background:cornsilk; border-top: double darkred; padding-right:3px; border-bottom: darkred solid 1px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.Total5 { background:cornsilk; border-top: double darkred; border-bottom: darkred solid 1px; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }

        td.SecDiv { color:red; background:darkred; border-right: darkred solid 1px; border-top: double darkred; border-bottom: darkred solid 1px; font-size:1px; }

        div.ActPayDtl { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.SchPayDtl { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.PayDtl {text-align:left; font-family:Arial; font-size:10px; }



@media screen
{
        td.DataTable { background:lightgrey; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
        td.DataTable3 { background:lightgrey; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable4 { background:lightgrey; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
}

@media print {
        td.DataTable {   border-bottom: darkred solid 1px; background:lightgrey; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
        td.DataTable3 {   border-bottom: darkred solid 1px; background:lightgrey; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable4 {   border-bottom: darkred solid 1px; background:lightgrey; padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
}

</style>
<SCRIPT language="JavaScript1.2">
var Store = "<%=sStore%>"
var StrName = "<%=sStrName%>"
var SelEmp = null;
var SelEmpName = null;

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   // activate move box
   setBoxclasses(["BoxName",  "BoxClose"], ["ActPayDtl", "SchPayDtl"]);
}
//==============================================================================
// resort by selected column
//==============================================================================
function sortBy(sort)
{
  var uri = "PrWkPay.jsp?STORE=<%=sStore%>"
          + "&STRNAME=<%=sStrName%>"
          + "&WEEKEND=<%=sWeekend%>"
          + "&MONBEG=<%=sMonth%>"
          + "&SORT=" + sort;
  window.location.href = uri;
}
//==============================================================================
// resort by selected column
//==============================================================================
function rtvActPayDtl(emp)
{
   SelEmp = emp.substr(0, 4);
   SelEmpName = emp.substr(5);

   var url = "ActWkPay.jsp?STORE=<%=sStore%>"
       + "&EmpNum=" + SelEmp
       + "&WEEKEND=<%=sWeekend%>"
   //alert(url)
   //window.location.href = url;
   window.frame1.location = url;
}
//==============================================================================
// resort by selected column
//==============================================================================
function showEmpPay(hrs, pay, type, tothrs, totpay)
{
  var curLeft = 0;
  var curTop = 0;

  var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap>Actual Payroll Details</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
   // Employee Number & Name
   html += "<tr>"
          + "<td class='PayDtl' nowrap colspan='2'>Store: " + Store + "</td>"
        + "</tr>"
        + "<tr>"
          + "<td class='PayDtl' nowrap colspan='2'>Employee: " + SelEmp + " " + SelEmpName + "</td>"
        + "</tr>"

   // payroll detail table
   html += "<tr><td class='PayDtl' nowrap colspan='2'>"
      + "<table border='1' width='100%' cellPadding='0' cellSpacing='0'>"
        + popPayDtlTable(hrs, pay, type, tothrs, totpay)
      + "</table></td></tr>"
   html += "</table>"


   curTop = document.documentElement.scrollTop + screen.height/2 - 200;
   curLeft = document.documentElement.scrollLeft + screen.width/2- 150;


   document.all.ActPayDtl.innerHTML = html;
   document.all.ActPayDtl.style.pixelLeft= curLeft;
   document.all.ActPayDtl.style.pixelTop= curTop;
   document.all.ActPayDtl.style.visibility = "visible";

   window.frame1.close();
}
//--------------------------------------------------------
// payroll detail table
//--------------------------------------------------------
function popPayDtlTable(hrs, pay, type, tothrs, totpay)
{
   var html = "<tr>"
          + "<th class='DataTable' >Type</th>"
          + "<th class='DataTable' >Hours</th>"
          + "<th class='DataTable' >Dollars</th>"
      + "</tr>"

   for(var i=0; i < hrs.length; i++)
   {
      html += "<tr>"
          + "<td class='Total' nowrap >" + type[i] + "</td>"
          + "<td class='Total1' nowrap >" + hrs[i] + "</td>"
          + "<td class='Total1' nowrap >" + pay[i] + "</td>"
        + "</tr>"
   }

   html += "<tr>"
          + "<td class='Total1' nowrap >Total</td>"
          + "<td class='Total1' nowrap >" + tothrs + "</td>"
          + "<td class='Total1' nowrap >" + totpay + "</td>"
        + "</tr>"

   return html;
}


//==============================================================================
// resort by selected column
//==============================================================================
function rtvSchPayDtl(emp)
{
   SelEmp = emp.substr(0, 4);
   SelEmpName = emp.substr(5);

   var url = "EmpSchWkPay.jsp?STORE=<%=sStore%>"
       + "&EmpNum=" + emp
       + "&WEEKEND=<%=sWeekend%>"
   //alert(url)
   //window.location.href = url;
   window.frame2.location = url;
}
//==============================================================================
// resort by selected column
//==============================================================================
function showEmpSchPay(schHrs, schReg, schVac, schHol, schRegPay, schCom, schAllPay,
               schAvg, empRate, empRate3, schSlsHrs, empHorS, empComTy, empOrgStr)
{
  var curLeft = 0;
  var curTop = 0;

  var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap>Schedule Payroll Details</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
   // Employee Number & Name
   html += "<tr>"
          + "<td class='PayDtl' nowrap colspan='2'>Store: " + Store + "</td>"
        + "</tr>"
        + "<tr>"
          + "<td class='PayDtl' nowrap colspan='2'>Employee: " + SelEmp + " " + SelEmpName + "</td>"
        + "</tr>"

   // payroll detail table
   html += "<tr><td class='PayDtl' nowrap colspan='2'>"
      + "<table border='1' width='100%' cellPadding='0' cellSpacing='0'>"
        + popSchPayDtlTable(schHrs, schReg, schVac, schHol, schRegPay, schCom, schAllPay,
               schAvg, empRate, empRate3, schSlsHrs, empHorS, empComTy, empOrgStr)
      + "</table></td></tr>"
   html += "</table>"


   curTop = document.documentElement.scrollTop + screen.height/2 - 200;
   curLeft = document.documentElement.scrollLeft + screen.width/2 + 150;


   document.all.SchPayDtl.innerHTML = html;
   document.all.SchPayDtl.style.pixelLeft= curLeft;
   document.all.SchPayDtl.style.pixelTop= curTop;
   document.all.SchPayDtl.style.visibility = "visible";

   window.frame2.close();
}

//--------------------------------------------------------
// payroll detail table
//--------------------------------------------------------
function popSchPayDtlTable(schHrs, schReg, schVac, schHol, schRegPay, schCom, schAllPay,
               schAvg, empRate, empRate3, schSlsHrs, empHorS, empComTy, empOrgStr)
{
   var html = "<tr>"
          + "<td class='Total' >Total Paid Hours</td>"
          + "<td class='Total' >" + schHrs + "</td>"
      + "</tr>"
      + "<tr>"
          + "<td class='Total' >Working Hours</td>"
          + "<td class='Total' >" + schReg + "</td>"
      + "</tr>"
      + "<tr>"
          + "<td class='Total' >Vacation Hours</td>"
          + "<td class='Total' >" + schVac + "</td>"
      + "</tr>"
      + "<tr>"
          + "<td class='Total' >Holiday Hours</td>"
          + "<td class='Total' >" + schHol + "</td>"
      + "</tr>"
      + "<tr>"
          + "<td class='Total' >Rate</td>"
          + "<td class='Total' >$" + empRate + "</td>"
      + "</tr>"
      + "<tr>"
          + "<td class='Total' >Additional Rate</td>"
          + "<td class='Total' >$" + empRate3 + "</td>"
      + "</tr>"
      + "<tr>"
          + "<td class='Total' >Hourly or Salary</td>"
          + "<td class='Total' >" + empHorS + "</td>"
      + "</tr>"
      + "<tr>"
          + "<td class='Total' >Sales Commission Type</td>"
          + "<td class='Total' >" + empComTy + "</td>"
      + "</tr>"
      + "<tr>"
          + "<td class='Total' >Original store</td>"
          + "<td class='Total' >" + empOrgStr + "</td>"
      + "</tr>"

      + "<tr>"
          + "<td class='Total' >Commissions</td>"
          + "<td class='Total' >$" + schCom + "</td>"
      + "</tr>"
      + "<tr>"
          + "<td class='Total' >Total Payment</td>"
          + "<td class='Total' >$" + schAllPay + "</td>"
      + "</tr>"

   return html;
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.ActPayDtl.innerHTML = " ";
   document.all.ActPayDtl.style.visibility = "hidden";
   document.all.SchPayDtl.innerHTML = " ";
   document.all.SchPayDtl.style.visibility = "hidden";
}

</SCRIPT>

<!-------------------------------------------------------------------->
<!-- Drag & Drop objects on the page. This featur is initialize by setBoxclasses()  -->
<!-------------------------------------------------------------------->
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

</head>
<!-------------------------------------------------------------------->
<body onLoad="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0">
<iframe id="frame2" src="" frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
  <div id="ActPayDtl" class="ActPayDtl"></div>
  <div id="SchPayDtl" class="SchPayDtl"></div>
<!-------------------------------------------------------------------->
  <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin"><td ALIGN="center" VALIGN="TOP" colspan="3">
      <b>Budget Weekly Pay Details</b>
     </tr>
     <tr bgColor="moccasin">
        <td ALIGN="left" VALIGN="TOP"><b>&nbsp;Store:&nbsp;<%=sStore + " - " + sStrName%></b></td>
        <td ALIGN="center" VALIGN="TOP">&nbsp;</td>
        <td ALIGN="right" VALIGN="TOP"><b>Week Ending:&nbsp;<%=sWeekend%>&nbsp;</b></td>
     </tr>
     <tr bgColor="moccasin">
        <td ALIGN="center" VALIGN="TOP" colspan="3">
        <a href="mailto:"><font color="red" size="-1">E-mail</font></a>;&#62;
        <a href="../"><font color="red" size="-1">Home</font></a>&#62;
        <a href="StrScheduling.html"><font color="red" size="-1">Payroll</font></a>&#62;
        <a href="PrMonBdgSel.jsp"><font color="red" size="-1">Store Selector</font></a>&#62;
        <a href="PrMonBdg.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&MONBEG=<%=sMonth%>">
          <font color="red" size="-1">Budget</font></a>&#62;
         <font color="red" size="-1">This page</font><br>
         <%if(sGrpType.equals("SG")){%>
            <font size="-1">Click <a href="javascript: sortBy('<%=sReverse%>');"><font size="-1">
              here</font></a> to remove subgroups</font>.
         <%}
         else {%><font size="-1">Click <a href="javascript: sortBy('<%=sReverse%>');"><font color="red">
              here</font></a> to add subgroups</font>.
         <%}%>
        <!------------- start of dollars table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable" rowspan="2"><a href="javascript:sortBy('<%=sGrpType%>EMP')">Employee</a></th>
           <%if(!sGrpType.equals("SG")){%>
              <th class="DataTable" rowspan="2">Subgroup</th>
           <%}%>
           <th class="DataTable" rowspan="2">Title</th>
           <th class="DataTable" colspan="5">Schedule</th>
           <th class="DataTable" rowspan="2">&nbsp;&nbsp;</th>
           <th class="DataTable" colspan="5">Actual Pay</th>
           <th class="DataTable" rowspan="2">&nbsp;&nbsp;</th>
           <th class="DataTable" colspan="3">Variance</th>
         </tr>
         <tr>
           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>HRS')">Total<br>hours</a></th>
           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>PAY')">Total<br>Pay $</a></th>
           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>AVG')">Avg<br>wage</a></th>
           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>PRC')">% to<br>Grp</a></th>
           <th class="DataTable" >% of<br>Total</th>

           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>ACTHRS')">Total<br>hours</a></th>
           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>ACTPAY')">Total<br>Pay $</a></th>
           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>ACTAVG')">Avg<br>wage</a></th>
           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>ACTPRC')">% to<br>Grp</a></th>
           <th class="DataTable" >% of<br>Total</th>

           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>VARHRS')">Hours</a></th>
           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>VARPAY')">Pay $</a></th>
           <th class="DataTable" ><a href="javascript:sortBy('<%=sGrpType%>VARAVG')">Avg</a></th>
         </tr>
         <!----------------- Managers ------------------------>
         <%for(int i=0, k=0; i < iNumOfSec; i++){%>
            <tr>
              <td class="Total3" colspan="18"><%=sSecName[i]%></td>
            </tr>

            <%if(!sGrpType.equals("SG")){ iNumSecGrp[i] = 1;}

              for(int j=0; j < iNumSecGrp[i]; j++){%>

              <%if(sGrpType.equals("SG")){%>
                 <tr>
                    <td class="DataTable2" colspan="18">&nbsp; &nbsp;<%=sGrpName[k]%></td>
                 </tr>
              <%}%>

               <%
                  // Get employee for selected group
                  if(!sGrpType.equals("SG")){ sGrpLst[k] = sSecLst[i];}
                  wkpay.setGrpEmp(sGrpLst[k]);

                  int iNumOfEmp = wkpay.getNumOfEmp();
                  String [] sEmp = wkpay.getEmp();
                  String [] sEmpSchHrs = wkpay.getEmpSchReg();
                  String [] sEmpSchWage = wkpay.getEmpSchWage();
                  String [] sEmpSchAvg = wkpay.getEmpSchAvg();
                  String [] sEmpSchPrc = wkpay.getEmpSchPrc();
                  String [] sEmpActHrs = wkpay.getEmpActHrs();
                  String [] sEmpActAmt = wkpay.getEmpActAmt();
                  String [] sEmpActAvg = wkpay.getEmpActAvg();
                  String [] sEmpActPrc = wkpay.getEmpActPrc();
                  String [] sEmpVarHrs = wkpay.getEmpVarHrs();
                  String [] sEmpVarAmt = wkpay.getEmpVarAmt();
                  String [] sEmpVarAvg = wkpay.getEmpVarAvg();
                  String [] sEmpTitle = wkpay.getEmpTitle();
                  String [] sEmpGrp = wkpay.getEmpGrp();

                  for(int l = 0; l < iNumOfEmp; l++)
                  {
               %>
                   <tr>
                      <td class="DataTable" nowrap><a href="javascript:rtvActPayDtl('<%=sEmp[l]%>');rtvSchPayDtl('<%=sEmp[l]%>')"><%=sEmp[l]%></a></td>
                      <%if(!sGrpType.equals("SG")){%>
                           <td class="DataTable"><%=sEmpGrp[l]%></td>
                      <%}%>
                      <td class="DataTable"><%=sEmpTitle[l]%></td>
                      <td class="DataTable3"><%=sEmpSchHrs[l]%></td>
                      <td class="DataTable3">$<%=sEmpSchWage[l]%></td>
                      <td class="DataTable3">$<%=sEmpSchAvg[l]%></td>
                      <td class="DataTable3"><%=sEmpSchPrc[l]%>%</td>
                      <td class="DataTable3">--%</td>

                      <th class="DataTable">&nbsp;</th>

                      <td class="DataTable3"><%=sEmpActHrs[l]%></td>
                      <td class="DataTable3"><%=sEmpActAmt[l]%></td>
                      <td class="DataTable3"><%=sEmpActAvg[l]%></td>
                      <td class="DataTable3"><%=sEmpActPrc[l]%></td>
                      <td class="DataTable3">--%</td>

                      <th class="DataTable">&nbsp;</th>

                      <td class="DataTable3"><%=sEmpVarHrs[l]%></td>
                      <td class="DataTable3"><%=sEmpVarAmt[l]%></td>
                      <td class="DataTable3"><%=sEmpVarAvg[l]%></td>
                   </tr>
               <% }%>

               <%
                 // Group Total
                 wkpay.setGrpTotal();
                 String sGrpTot = wkpay.getGrpTot();
                 String sGrpSchHrs = wkpay.getGrpSchReg();
                 String sGrpSchWage = wkpay.getGrpSchWage();
                 String sGrpSchAvg = wkpay.getGrpSchAvg();
                 String sGrpSchPrc = wkpay.getGrpSchPrc();
                 String sGrpActHrs = wkpay.getGrpActHrs();
                 String sGrpActAmt = wkpay.getGrpActAmt();
                 String sGrpActAvg = wkpay.getGrpActAvg();
                 String sGrpActPrc = wkpay.getGrpActPrc();
                 String sGrpVarHrs = wkpay.getGrpVarHrs();
                 String sGrpVarAmt = wkpay.getGrpVarAmt();
                 String sGrpVarAvg = wkpay.getGrpVarAvg();
               %>

               <tr>
                  <td class="Total"><%=sGrpTot%></td>
                  <%if(!sGrpType.equals("SG")){%>
                      <td class="Total">&nbsp;</td>
                  <%}%>
                  <td class="Total">&nbsp;</td>
                  <td class="Total1"><%=sGrpSchHrs%></td>
                  <td class="Total1">$<%=sGrpSchWage%></td>
                  <td class="Total1">$<%=sGrpSchAvg%></td>
                  <td class="Total1">100%</td>
                  <td class="Total1"><%=sGrpSchPrc%>%</td>

                  <th class="DataTable">&nbsp;</th>

                  <td class="Total1"><%=sGrpActHrs%></td>
                  <td class="Total1"><%=sGrpActAmt%></td>
                  <td class="Total1"><%=sGrpActAvg%></td>
                  <td class="Total1">100%</td>
                  <td class="Total1"><%=sGrpActPrc%>%</td>

                  <th class="DataTable">&nbsp;</th>

                  <td class="Total1"><%=sGrpVarHrs%></td>
                  <td class="Total1"><%=sGrpVarAmt%></td>
                  <td class="Total1"><%=sGrpVarAvg%></td>
               </tr>
               <%k++;%>
            <%}%>
         <%}%>
   <!-- =============== Store Totals ======================================= -->
   <tr><td class="SecDiv" colspan=17>&nbsp</td></tr>
         <%
                 // Store Total
                 wkpay.setStrTotal();
                 String sGrpTot = wkpay.getGrpTot();
                 String sGrpSchHrs = wkpay.getGrpSchReg();
                 String sGrpSchWage = wkpay.getGrpSchWage();
                 String sGrpSchAvg = wkpay.getGrpSchAvg();
                 String sGrpSchPrc = wkpay.getGrpSchPrc();
                 String sGrpActHrs = wkpay.getGrpActHrs();
                 String sGrpActAmt = wkpay.getGrpActAmt();
                 String sGrpActAvg = wkpay.getGrpActAvg();
                 String sGrpActPrc = wkpay.getGrpActPrc();
                 String sGrpVarHrs = wkpay.getGrpVarHrs();
                 String sGrpVarAmt = wkpay.getGrpVarAmt();
                 String sGrpVarAvg = wkpay.getGrpVarAvg();
               %>

               <tr>
                  <td class="Total"><%=sGrpTot%></td>
                  <td class="Total">&nbsp;</td>
                  <td class="Total1"><%=sGrpSchHrs%></td>
                  <td class="Total1">$<%=sGrpSchWage%></td>
                  <td class="Total1">$<%=sGrpSchAvg%></td>
                  <td class="Total1">100%</td>
                  <td class="Total1"><%=sGrpSchPrc%>%</td>

                  <th class="DataTable">&nbsp;</th>

                  <td class="Total1"><%=sGrpActHrs%></td>
                  <td class="Total1"><%=sGrpActAmt%></td>
                  <td class="Total1"><%=sGrpActAvg%></td>
                  <td class="Total1">100%</td>
                  <td class="Total1"><%=sGrpActPrc%>%</td>

                  <th class="DataTable">&nbsp;</th>

                  <td class="Total1"><%=sGrpVarHrs%></td>
                  <td class="Total1"><%=sGrpVarAmt%></td>
                  <td class="Total1"><%=sGrpVarAvg%></td>
               </tr>
     </table>
<!------------- end of data table ------------------------>
                </td>
            </tr>
       </table>


  </body>
</html>
<%
   wkpay.disconnect();
}
%>