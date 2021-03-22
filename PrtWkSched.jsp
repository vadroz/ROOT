<%@ page import="payrollreports.SetWkSchedPrt"%>
<%
   String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sWeekEnd = request.getParameter("WEEKEND");

 // get employee number by hours
   SetWkSchedPrt wkprt = new SetWkSchedPrt(sStore, sWeekEnd);

   String [] sWeek = wkprt.getWeeks();
   int iNumOfEmp = wkprt.getNumOfEmp();
   String [] sEmpName = wkprt.getEmpName();
   String [][] sHrsType = wkprt.getHrsType();
   String [][] sBegTime = wkprt.getBegTime();
   String [][] sEndTime = wkprt.getEndTime();
   String [] sEmpTotHr = wkprt.getEmpTotHr();

   wkprt.disconnect();
%>

<html>
<head>

<style>body {background:white;}
    a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
    table.DataTable { border: darkred solid 1px;background:white;text-align:center;}
    th.DataTable { background:#FFCC99;padding-top:3px; padding-left:3px;padding-right:3px; padding-bottom:3px; border-bottom: darkred solid 1px;
                   border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
    td.DataTable { background:white; padding-top:3px; padding-bottom:3px; padding-left:3px;padding-right:3px;
                   border-bottom: darkred solid 1px;
                   border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
    td.DataTable1 {padding-left:3px;padding-right:3px; padding-top:3px; padding-bottom:3px;
                    border-bottom: darkred solid 1px;
                   border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
    td.DataTable2 {background: gold; padding-left:3px;padding-right:3px; padding-top:3px; padding-bottom:3px;
                    border-bottom: darkred solid 1px;
                   border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
    td.DataTable3 {background: #afdcec;padding-left:3px;padding-right:3px; padding-top:3px; padding-bottom:3px;
                    border-bottom: darkred solid 1px;
                   border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
    td.DataTable4 {background: #99c68e;padding-left:3px;padding-right:3px; padding-top:3px; padding-bottom:3px;
                    border-bottom: darkred solid 1px;
                   border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }

</style>
<SCRIPT language="JavaScript">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
</SCRIPT>
</head>
<body>

    <table border="0" width="100%" height="100%">
             <tr bgColor="White">
       <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc</b>
      <br><h1>Employee Work Schedule</h1><br>
<!-------------------------------------------------------------------->
        <b>Store:&nbsp;<%=sThisStrName%>
           <br>Week Ending:&nbsp;<%=sWeekEnd%>
        </b>
      <p>
        <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        <a href="StrScheduling.html"><font color="red" size="-1">Payroll</font></a>&#62;
        <font size="-1">This page</font>
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable" rowspan="2">Employee</th>
           <th class="DataTable" colspan="7">Days</th>
           <th class="DataTable" rowspan="2">Total<br>Hours</th>
         </tr>
             <%for(int i=0; i < 7; i++){%>
                <th class="DataTable" ><%=sWeek[i]%></th>
             <%}%>
         <tr>
         </tr>
         <%for(int i=0; i < iNumOfEmp; i++ ){%>
           <tr>
             <td class="DataTable" ><%=sEmpName[i]%></td>

             <%for(int j=0; j < 7; j++){%>
                <%if(sHrsType[i][j].trim().equals("REG")) {%>
                      <td class="DataTable1" ><%=sBegTime[i][j]%> - <%=sEndTime[i][j]%></td><%}
                  else if(sHrsType[i][j].trim().equals("OFF")) {%>
                      <td class="DataTable2" >Request Off</td><%}
                  else if(sHrsType[i][j].trim().equals("VAC")) {%>
                       <td class="DataTable3" >Vacation</td><%}
                  else if(sHrsType[i][j].trim().equals("HOL")) {%>
                       <td class="DataTable4" >Holiday</td><%}
                  else if(sHrsType[i][j].trim().equals("")) {%>
                       <td class="DataTable1" >&nbsp;</td><%}%>

             <%}%>
             <td class="DataTable1" ><%=sEmpTotHr[i]%></td>
           </tr>
         <%}%>
      </table>
      <!----------------------- end of table ------------------------>
    </td>
   </tr>
  </table>
 </body>
</html>
