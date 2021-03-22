<%@ page import="payrollreports.StrDlyToDoList1, java.util.*, java.text.*"%>
<%
   String sStore = request.getParameter("Store");
   String sDate = request.getParameter("Date");

   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null )
   {
     response.sendRedirect("SignOn1.jsp?TARGET=StrDlyToDoList1.jsp&" + request.getQueryString());
   }
   else
   {
     boolean bChange = session.getAttribute(sAppl)!=null;
     String sUser = session.getAttribute("USER").toString();

     StrDlyToDoList1 schpay = new StrDlyToDoList1(sStore, sDate, sUser);

     String sPlan = schpay.getPlan();
     String sSlsPrc = schpay.getSlsPrc();
     String sGoal = schpay.getGoal();
     String sWtd = schpay.getWtd();
     String sLySls = schpay.getLySls();
     String sLyWtd = schpay.getLyWtd();
     String sPlanWtd = schpay.getPlanWtd();
     String sDayVar = schpay.getDayVar();
     String sWtdVar = schpay.getWtdVar();
     String sPlanWtdVar = schpay.getPlanWtdVar();
     String sTyPriorDate = schpay.getTyPriorDate();
     String sLyDate = schpay.getLyDate();
     String sL4WkDate = schpay.getL4WkDate();

     int iNumOfEmp = schpay.getNumOfEmp();
     String [] sEmp = schpay.getEmp();
     String [] sDept = schpay.getDept();
     String [] sGrpNm = schpay.getGrpNm();
     String [] sTitle = schpay.getTitle();
     String [] sBegTime = schpay.getBegTime();
     String [] sEndTime = schpay.getEndTime();
     String [] sWkHrs = schpay.getWkHrs();
     String [] sShift = schpay.getShift();
     String [] sHorS = schpay.getHorS();
     String [] sSlsGoal = schpay.getSlsGoal();

     String [] sLSftSls = schpay.getLSftSls();
     String [] sLSftItem = schpay.getLSftItem();
     String [] sLSftTran = schpay.getLSftTran();
     String [] sLSftAvg = schpay.getLSftAvg();
     String [] sLSftIPT = schpay.getLSftIPT();
     String [] sLSftSlsHr = schpay.getLSftSlsHr();

     String [] sL4WkSls = schpay.getL4WkSls();
     String [] sL4WkItem = schpay.getL4WkItem();
     String [] sL4WkTran = schpay.getL4WkTran();
     String [] sL4WkAvg = schpay.getL4WkAvg();
     String [] sL4WkIPT = schpay.getL4WkIPT();
     String [] sL4WkSlsHr = schpay.getL4WkSlsHr();

     String [] sLsYrSls = schpay.getLsYrSls();
     String [] sLsYrItem = schpay.getLsYrItem();
     String [] sLsYrTran = schpay.getLsYrTran();
     String [] sLsYrAvg = schpay.getLsYrAvg();
     String [] sLsYrIPT = schpay.getLsYrIPT();
     String [] sLsYrSlsHr = schpay.getLsYrSlsHr();
     String [] sLastShift = schpay.getLastShift();
     String [] sMoved = schpay.getMoved();

     String [] sHrsCol = new String[]{"7am","8am","9am","10am","11am","12pm",
      "1pm","2pm","3pm","4pm","5pm","6pm","7pm","8pm","9pm","10pm","11pm","12pm", "Total"};

     int iNumOfHrs = schpay.getNumOfHrs();
     String [] sHrsLySls = schpay.getHrsLySls();
     String [] sHrsLyItem = schpay.getHrsLyItem();
     String [] sHrsLyTran = schpay.getHrsLyTran();
     String [] sHrsLyAvg = schpay.getHrsLyAvg();
     String [] sHrsLyIPT = schpay.getHrsLyIPT();
     String [] sHrsLyPrc = schpay.getHrsLyPrc();
     String [] sHrsLyCom = schpay.getHrsLyCom();
     String [] sHrsTySls = schpay.getHrsTySls();
     String [] sHrsTyCom = schpay.getHrsTyCom();
     String [] sHrsTyPrc = schpay.getHrsTyPrc();
%>

<html>
<head>

<style>body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px; text-align:center;}
        th.DataTable { background:#FFCC99; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        td.GrpHdr { background:cornSilk; color: blue; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:11px; font-weight:bold; }
        td.StrAvg { background:cornSilk;  padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:12px; font-weight:bold; }
        td.StrAvg1 { background:cornSilk; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:12px; font-weight:bold; }

        th.ColBreak { border-left: darkred solid 4px; font-size:1px }
        th.DataTable1 { background:#cccfff; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        td.DataTable { background:white; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable1 { background:white; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
        td.DataTable2 { background:white; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.LineBreak { border-bottom: darkred solid 4px; font-size:1px }

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }


  @media print
  {
     .break { page-break-before: always;
             -webkit-transform: rotate(-90deg);
             -moz-transform:rotate(-90deg);
             filter:progid:DXImageTransform.Microsoft.BasicImage(rotation=3);
            }
  }
</style>
<SCRIPT language="JavaScript">
//--------------- Global variables -----------------------

//--------------- End of Global variables -----------------------
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
// change postion on report
//==============================================================================
function chgPosition(emp, curDept, moved)
{
 //check if order is paid off
   var hdr = emp;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
       + "<tr><td class='Prompt' colspan=2>" + popPositionPanel(emp, moved)
       + "</td></tr></table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.width = 250;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 150;
   document.all.dvItem.style.visibility = "visible";

   popGrpSelLst(curDept);
}
//==============================================================================
// Populate panel
//==============================================================================
function popPositionPanel(emp, moved)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt3' nowrap>Assigned Area: &nbsp; <select class='small' name='Group'></select></td>"
           + "<td class='Prompt' colspan='2'>"


  panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
        + "<button onClick='sbmPosition(&#34;" + emp + "&#34;, &#34;NEW&#34;)' class='Small'>Submit</button>&nbsp;"
  if(moved == "1") { panel += "<button onClick='sbmPosition(&#34;" + emp + "&#34;, &#34;DELETE&#34;)' class='Small'>Original</button>&nbsp;"}
  panel += "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// populate Group selection list
//==============================================================================
function popGrpSelLst(curDept)
{
   var selgrp = ["MNGR", "SALES", "BIKE SALES" , "CASHIER", "BIKE/SKI SHOP", "OTHER" ];
   var selgrpnm = ["Managers", "Sales", "Bike Department Sales" , "Cashier, Operations",
      "Bike Shop, Ski Shop", "Other" ];

   for(var i=0, j=0; i < selgrp.length; i++ )
   {
     if(curDept != selgrpnm[i])
     {
        document.all.Group.options[j] = new Option(selgrpnm[i], selgrp[i]);
        j++;
     }
   }
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
// submit position change
//==============================================================================
function sbmPosition(emp, action)
{
   var url = "StrDlyToDoSave.jsp?Store=<%=sStore%>"
     + "&Date=<%=sDate%>"
     + "&Emp=" + emp
     + "&Group=" + document.all.Group.options[document.all.Group.selectedIndex].value
     + "&Action=" + action
   //alert(url)
   //window.location.href=url;
   window.frame1.location.href=url;
}
//==============================================================================
// submit position change
//==============================================================================
function restart()
{
  window.location.reload();
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

</head>
<body>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->


    <table border="0" width="100%" height="100%">
             <tr>
       <td ALIGN="center" VALIGN="TOP" colspan=2>
      <b>Sun & Ski
      <br>Floor Leader Agenda - Daily Goals and Assignment</b><br>
<!-------------------------------------------------------------------->
      <b>Store:&nbsp;<%=sStore%> &nbsp; &nbsp; &nbsp; Date: <%=sDate%></b>
      <br>
      <table style="border:solid 1px blue" cellPadding="0" cellSpacing="0">
         <tr style="font-size:12px; font-weight:bold">
           <td align=center colspan=2><u>Daily</u></td>
           <td><%for(int i=0; i < 20; i++){%>&nbsp;<%}%></td>
           <td align=center colspan=2><u>WTD</u></td>
         <tr>

         <tr style="font-size:12px; font-weight:bold">
           <td>Today's Sales Forecast:&nbsp;</td><td align=right>$<%=sPlan%></td>
           <td><%for(int i=0; i < 20; i++){%>&nbsp;<%}%></td>
           <td>Total Sales WTD:&nbsp;</td><td align=right>$<%=sWtd%></td>
         <tr>
         <tr style="font-size:12px; font-weight:bold">
           <td>Times Sales Staff Ratio:&nbsp;</td><td align=right>85%</td>
           <td><%for(int i=0; i < 20; i++){%>&nbsp;<%}%></td>
           <td>LY Sales WTD:&nbsp;</td><td align=right>$<%=sLyWtd%></td>
         <tr>
         <tr style="font-size:12px; font-weight:bold">
           <td>Times Sales Staff Goal:&nbsp;</td><td align=right>$<%=sGoal%></td>
           <td><%for(int i=0; i < 20; i++){%>&nbsp;<%}%></td>
           <td>%Increase (Decrease):&nbsp;</td><td align=right><%=sWtdVar%>%</td>
         <tr>
         <tr style="font-size:12px; font-weight:bold">
           <td>LY Sales:&nbsp;</td><td align=right>$<%=sLySls%></td>
           <td>&nbsp;</td>
           <td>Sales Forecast WTD:&nbsp;</td><td align=right>$<%=sPlanWtd%></td>
         <tr>
         <tr style="font-size:12px; font-weight:bold">
           <td>%Increase (Decrease):&nbsp;</td><td align=right><%=sDayVar%>%</td>
           <td>&nbsp;</td>
           <td>%Increase (Decrease):&nbsp;</td><td align=right><%=sPlanWtdVar%>%</td>
         <tr>
      </table>
<!-------------------------------------------------------------------->
      <p style="text-align:left;">
        <span style="color:red; font-size:11px">9999 John Smith* - employee was moved from original section</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <a href="../index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        <a href="StrDlyToDoList1Sel.jsp"><font color="red" size="-1">Store/Date Selector</font></a>&#62;
        <font size="-1">This page</font>
    <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0" width=100%>
         <tr>
            <th class="DataTable">No.</th>
            <th class="DataTable">Employee</th>
            <th class="DataTable">Ttl</th>
            <th class="DataTable">Dept</th>
            <th class="DataTable">Schedule</th>
            <th class="DataTable">Hours</th>
            <th class="DataTable">Sales<br>Goals</th>
            <th class="DataTable">Shift</th>

            <th class="DataTable" >&nbsp;</th>
            <th class="DataTable" width=50%>Assignment</th>
          </tr>

         <!------------------------- Data Detail ------------------------------>
         <%String svGrpNm = "";%>
         <%for(int i=0; i < iNumOfEmp - 2; i++ ){
             if(!svGrpNm.equals(sGrpNm[i])){%>
               <%if( i > 0){%><tr><td class="LineBreak" colspan=14>&nbsp;</td></tr><%}%>
               <tr><td class="GrpHdr" colspan=14><%=sGrpNm[i]%></td></tr>
               <%svGrpNm = sGrpNm[i];%>
             <%}%>
             <tr>
                <td class="DataTable2" nowrap><%=(i+1)%></td>
                <td class="DataTable1" nowrap>
                   <%if(bChange){%><a <%if(sMoved[i].equals("1")){%>style="color:red"<%}%> href="javascript: chgPosition('<%=sEmp[i]%>', '<%=sGrpNm[i]%>', '<%=sMoved[i]%>')">
                      <%=sEmp[i]%><%if(sMoved[i].equals("1")){%>*<%}%>
                    </a><%}
                    else{%><%=sEmp[i]%><%if(sMoved[i].equals("1")){%>*<%}%><%}%>
                </td>
                <td class="DataTable1" nowrap><%=sTitle[i]%></td>
                <td class="DataTable1" nowrap><%=sDept[i]%></td>
                <td class="DataTable2" nowrap><%=sBegTime[i]%> - <%=sEndTime[i]%></td>
                <td class="DataTable2" ><%=sWkHrs[i]%></td>
                <td class="DataTable" ><%if(!sSlsGoal[i].equals("0")){%>$<%=sSlsGoal[i]%><%} else{%>&nbsp;<%}%></td>
                <td class="DataTable2" ><%=sShift[i]%></td>

                <th class="DataTable" >&nbsp;</th>

                <td class="DataTable" >&nbsp;</td>
             </tr>
           <%}%>
           <!-- --------------- Total -------------------------------------- -->
           <%int iLast = iNumOfEmp - 1;%>
           <tr><td class="LineBreak" colspan=14>&nbsp;</td></tr>
           <tr>
                <td class="DataTable1" colspan=4 nowrap><%=sEmp[iLast]%></td>
                <td class="DataTable2" nowrap>&nbsp;</td>
                <td class="DataTable2" ><%=sWkHrs[iLast]%></td>
                <td class="DataTable" >$<%=sSlsGoal[iLast]%></td>
                <td class="DataTable2" >&nbsp;</td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" >&nbsp;</td>
           </tr>

      </table>
      <!------------------------- footer -------------------------------------->
      <br>
      <table cellPadding="0" cellSpacing="0" width=100%>
        <tr>
          <td style="text-align:left; font-size:10px" nowrap>New Merch, Ads, Promo's Etc.:</td>
          <td style="border-bottom:solid 1px black" width=90%>&nbsp;</td>
        </tr>
        <tr><td colspan=2 style="padding-top:5px; border-bottom:solid 1px black" width=90%>&nbsp;</td></tr>
        <tr><td colspan=2 style="font-size:5px" width=90%>&nbsp;</td></tr>
      </table>
      <table cellPadding="0" cellSpacing="0" width=100%>
        <tr>
          <td style="text-align:left; font-size:10px" nowrap>Question of the day:</td>
          <td style="border-bottom:solid 1px black" width=95%>&nbsp;</td>
        </tr>
      </table>
      <!----------------------- end of table ------------------------>
      <!----------------------- Sales History ------------------------>
      <p class="break">
      <b>Retail Concepts, Inc
      <br>Sales Statistics</b><br>
      <!-------------------------------------------------------------------->
      <b>Store:&nbsp;<%=sStore%> &nbsp; &nbsp; &nbsp; Date: <%=sDate%></b>
      <br>
      <!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
            <th class="DataTable" rowspan=2>No.</th>
            <th class="DataTable" rowspan=2>Employee</th>
            <th class="DataTable" rowspan=2>Ttl</th>
            <th class="DataTable" rowspan=2>Dept</th>
            <th class="DataTable" rowspan=2>&nbsp;</th>
            <th class="DataTable" colspan=4>Last Shift</th>
            <th class="DataTable" rowspan=2>&nbsp;</th>
            <th class="DataTable" colspan=3>Last 4 Weeks<br><%=sL4WkDate%> - <%=sTyPriorDate%></th>
            <th class="DataTable" rowspan=2>&nbsp;</th>
            <th class="DataTable" colspan=3>Last Year<br><%=sLyDate%></th>
          </tr>

          <tr>
             <th class="DataTable">Date</th>
             <th class="DataTable">Total<br>Sales</th>
             <th class="DataTable">Sls<br>/Hr.</th>
             <th class="DataTable">IPT's</th>

             <th class="DataTable">Total<br>Sales</th>
             <th class="DataTable">Sls<br>/Hr.</th>
             <th class="DataTable">IPT's</th>

             <th class="DataTable">Total<br>Sales</th>
             <th class="DataTable">Sls<br>/Hr.</th>
             <th class="DataTable">IPT's</th>
          </tr>


          <!-- --------------- Store Average ------------------------------- -->
           <%iLast = iNumOfEmp - 2;%>
           <tr><td class="LineBreak" colspan=19>&nbsp;</td></tr>
           <tr>
                <td class="StrAvg" style="border-left:darkred solid 4px" colspan=4 nowrap><%=sEmp[iLast]%></td>
                <th class="DataTable" >&nbsp;</th>
                <td class="StrAvg" nowrap><%=sTyPriorDate%></td>
                <td class="StrAvg" nowrap>$<%=sLSftSls[iLast]%></td>
                <td class="StrAvg" nowrap>$<%=sLSftSlsHr[iLast]%></td>
                <td class="StrAvg" nowrap><%=sLSftIPT[iLast]%></td>
                <th class="DataTable" >&nbsp;</th>
                <td class="StrAvg" nowrap>$<%=sL4WkSls[iLast]%></td>
                <td class="StrAvg" nowrap>$<%=sL4WkSlsHr[iLast]%></td>
                <td class="StrAvg" nowrap><%=sL4WkIPT[iLast]%></td>
                <th class="DataTable" >&nbsp;</th>
                <td class="StrAvg" nowrap>$<%=sLsYrSls[iLast]%></td>
                <td class="StrAvg" nowrap>$<%=sLsYrSlsHr[iLast]%></td>
                <td class="StrAvg" style="border-right:darkred solid 4px" nowrap><%=sLsYrIPT[iLast]%></td>
           </tr>
           <tr><td class="LineBreak" colspan=19>&nbsp;</td></tr>
         <!------------------------- Data Detail ------------------------------>
         <%svGrpNm = "";%>
         <%for(int i=0; i < iNumOfEmp - 2; i++ ){
             if(!svGrpNm.equals(sGrpNm[i])){%>
               <%if( i > 0){%><tr><td class="LineBreak" colspan=19>&nbsp;</td></tr><%}%>
               <tr><td class="GrpHdr" colspan=19><%=sGrpNm[i]%></td></tr>
               <%svGrpNm = sGrpNm[i];%>
             <%}%>
             <tr>
                <td class="DataTable2" nowrap><%=(i+1)%></td>
                <td class="DataTable1" nowrap><%=sEmp[i]%></td>
                <td class="DataTable1" nowrap><%=sTitle[i]%></td>
                <td class="DataTable1" nowrap><%=sDept[i]%></td>

                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable2" nowrap><%=sLastShift[i]%></td>
                <td class="DataTable" nowrap>$<%=sLSftSls[i]%></td>
                <td class="DataTable" nowrap>$<%=sLSftSlsHr[i]%></td>
                <td class="DataTable" nowrap><%=sLSftIPT[i]%></td>

                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=sL4WkSls[i]%></td>
                <td class="DataTable" nowrap>$<%=sL4WkSlsHr[i]%></td>
                <td class="DataTable" nowrap><%=sL4WkIPT[i]%></td>

                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=sLsYrSls[i]%></td>
                <td class="DataTable" nowrap>$<%=sLsYrSlsHr[i]%></td>
                <td class="DataTable" nowrap><%=sLsYrIPT[i]%></td>
             </tr>
           <%}%>
           <!-- --------------- Total -------------------------------------- -->
           <%iLast = iNumOfEmp - 1;%>
           <tr><td class="LineBreak" colspan=19>&nbsp;</td></tr>
           <tr>
                <td class="DataTable1" colspan=4 nowrap><%=sEmp[iLast]%></td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>&nbsp;</td>
                <td class="DataTable" nowrap>$<%=sLSftSls[iLast]%></td>
                <td class="DataTable" nowrap>$<%=sLSftSlsHr[iLast]%></td>
                <td class="DataTable" nowrap><%=sLSftIPT[iLast]%></td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=sL4WkSls[iLast]%></td>
                <td class="DataTable" nowrap>$<%=sL4WkSlsHr[iLast]%></td>
                <td class="DataTable" nowrap><%=sL4WkIPT[iLast]%></td>
                <th class="DataTable" >&nbsp;</th>
                <td class="DataTable" nowrap>$<%=sLsYrSls[iLast]%></td>
                <td class="DataTable" nowrap>$<%=sLsYrSlsHr[iLast]%></td>
                <td class="DataTable" nowrap><%=sLsYrIPT[iLast]%></td>
           </tr>

      </table>

      <!----------------------- end of table ------------------------>
      <p class="break">
      <b>Retail Concepts, Inc
      <br>Sales Distribution by Hour
      <br>Store:&nbsp;<%=sStore%> &nbsp; &nbsp; &nbsp; Date: <%=sDate%></b>
      <br>
      <!------------------- Sales Distribution Table ------------------------->
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable" rowspan=2>Hrs</th>
           <th class="DataTable" colspan=6>Last Year Sales</th>
           <th class="DataTable" rowspan=2>&nbsp;</th>
           <th class="DataTable" colspan=4>This Year Plan</th>
         </tr>
         <tr>
           <th class="DataTable">Sls<br>$</th>
           <th class="DataTable">Sls<br>%</th>
           <th class="DataTable">Cumulative<br>$</th>
           <th class="DataTable"># of Trn</th>
           <th class="DataTable">IPT's</th>
           <th class="DataTable">Avg $<br>/Trans</th>

           <th class="DataTable">Sls<br>$</th>
           <th class="DataTable">Sls<br>%</th>
           <th class="DataTable">Cumulative<br>$</th>
         </tr>

          <%for(int j=0; j < sHrsCol.length; j++ ){%>
              <%if(j == sHrsCol.length - 1){%>
                 <tr><td class="LineBreak" colspan=14>&nbsp;</td></tr>
              <%}%>
              <tr>
                 <td class="DataTable" ><%=sHrsCol[j]%></td>

                 <td class="DataTable" >$<%=sHrsLySls[j]%></td>
                 <td class="DataTable" ><%=sHrsLyPrc[j]%>%</td>
                 <td class="DataTable" >$<%=sHrsLyCom[j]%></td>
                 <td class="DataTable" ><%=sHrsLyTran[j]%></td>
                 <td class="DataTable" ><%=sHrsLyIPT[j]%></td>
                 <td class="DataTable" >$<%=sHrsLyAvg[j]%></td>
                 <th class="DataTable">&nbsp;</th>
                 <td class="DataTable" >$<%=sHrsTySls[j]%></td>
                 <td class="DataTable" ><%=sHrsTyPrc[j]%>%</td>
                 <td class="DataTable" >$<%=sHrsTyCom[j]%></td>
           <%}%>
      </table>
        <!--------------------------------------------------------------------->
  </table>

<%
         SimpleDateFormat sdfMDY = new SimpleDateFormat("MM/dd/yyyy");
         SimpleDateFormat sdfISO = new SimpleDateFormat("yyyy-MM-dd");

         Date selDt = sdfMDY.parse(sDate);
         Date curDt = sdfISO.parse(sdfISO.format(new Date()));

         if(selDt.compareTo(curDt) >= 0)
         {
            selDt.setTime(curDt.getTime() - 24 * 60 * 60 * 1000 );
         }
         String flashDt = sdfMDY.format(selDt);
%>

<p class="break">
  <iframe SCROLLING=NO frameBorder="0"
        src="FlashSalesTyLy.jsp?Store=<%=sStore%>&Division=ALL&DivName=All%20Divisions&Department=ALL&DptName=All%20Departments&Class=ALL&clsName=All%20Classes&Date=<%=flashDt%>&Level=D&Period=MTDTYLY"
        width="100%" height="1000" ></iframe>
<p class="break">
  <iframe SCROLLING=NO frameBorder="0"
        src="FlashSalesTyLy.jsp?Store=ALL&Division=ALL&DivName=All%20Divisions&Department=ALL&DptName=All%20Departments&Class=ALL&clsName=All%20Classes&Date=<%=flashDt%>&Level=S&Period=MTDTYLY"
        width="100%" height="1000"></iframe>
<p class="break">
  <iframe SCROLLING=NO frameBorder="0"
        src="FlashSalesTyLy.jsp?Store=ALL&Division=ALL&DivName=All%20Divisions&Department=ALL&DptName=All%20Departments&Class=ALL&clsName=All%20Classes&Date=<%=flashDt%>&Level=S&Period=MTDTYPLAN"
        width="100%" height="1000"></iframe>
 </body>
</html>
<%
   schpay.disconnect();
   schpay = null;
}%>