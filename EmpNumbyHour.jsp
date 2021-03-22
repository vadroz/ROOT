<%@ page import="payrollreports.SetEmpNum"%>
<% String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sWeekDay = request.getParameter("WKDATE");
   String sMonth = request.getParameter("MONBEG");
   String sWeekEnd = request.getParameter("WEEKEND");
   String sFrom = request.getParameter("FROM");
   String sGrp = request.getParameter("GRP");
   String sDayOfWeek = request.getParameter("WKDAY");
   if(sGrp == null) sGrp="SLSP";
   String sPosition = request.getParameter("POS");
   if(sPosition == null) sPosition="LIST";

 // get employee number by hours
   SetEmpNum EmpNum = new SetEmpNum(sStore, sWeekDay, "Day");
   String [] sHours = EmpNum.getHours();
   String [] sMgrNum = EmpNum.getMgrNum();
   String [] sSlsNum = EmpNum.getSlsNum();
   String [] sNSlNum = EmpNum.getNSlNum();
   String [] sTotNum = EmpNum.getTotNum();
   EmpNum.disconnect();
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:lightgrey; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }

</style>
<SCRIPT language="JavaScript">
//--------------- Global variables -----------------------
var CurStore = <%=sStore%>;
var CurStrName = "<%=sThisStrName%>";
var Month = "<%=sMonth%>"
var WeekEnd = "<%=sWeekEnd%>"
var CurDate = "<%=sWeekDay%>";
var From = "<%=sFrom%>";
//--------------- End of Global variables -----------------------

</SCRIPT>
</head>
<body>

    <table border="0" width="100%" height="100%">
             <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>Daily Store Schedule</b><br>
<!-------------------------------------------------------------------->
        <b>Store:&nbsp;<%=sThisStrName%>
           <br>Date:&nbsp;<%=sDayOfWeek + ", " + sWeekDay%>
        </b>
      <p>
        <a href="../"><font color="red" size="-1">Home</font></a>&#62;
        <a href="StrScheduling.html"><font color="red" size="-1">Payroll</font></a>&#62;
        <%if(sFrom.equals("AVGPAYREP")){%>
          <a href="APRSelector.jsp"><font color="red"  size="-1">Store Selector</font></a>&#62;
          <a href="AvgPayRep.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>">
            <font color="red" size="-1">Average Pay Report</font></a>&#62;
        <%}%>
        <a href="SchedbyWkSel.jsp"><font color="red" size="-1">Store/Week Selector</font></a>&#62;
        <a href="SchedbyWeek.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&FROM=<%=sFrom%>">
          <font color="red"  size="-1">Weekly Schedule</font></a>&#62;
         <font size="-1">This page</font>
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable" >Hours</th>
           <th class="DataTable" >Management</th>
           <th class="DataTable" >Selling<br>Personnel</th>
           <th class="DataTable" >Non-Selling<br>Personnel</th>
           <th class="DataTable" >Total</th>
         </tr>
         <%for(int i=0; i < sHours.length; i++ ){%>
           <tr>
             <td class="DataTable" ><%=sHours[i]%></td>
             <td class="DataTable" ><%=sMgrNum[i]%></td>
             <td class="DataTable" ><%=sSlsNum[i]%></td>
             <td class="DataTable" ><%=sNSlNum[i]%></td>
             <td class="DataTable" ><%=sTotNum[i]%></td>
           </tr>
         <%}%>
      </table>
      <!----------------------- end of table ------------------------>
    </td>
   </tr>
  </table>
 </body>
</html>
