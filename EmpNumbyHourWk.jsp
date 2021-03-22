<%@ page import="payrollreports.SetEmpNum"%>
<% String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sWeekDay = request.getParameter("WKDATE");
   String sMonth = request.getParameter("MONBEG");
   String sWeekEnd = request.getParameter("WEEKEND");
   String sFrom = request.getParameter("FROM");
   String sGrp = request.getParameter("GRP");
   String sDayOfWeek = request.getParameter("WKDAY");
   String sShowGrp = request.getParameter("SHWGRP");
   String [] sDaysOfWeek = new String[]{"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" } ;
   String [] sColSfx = new String[]{"MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN" } ;
   int iColSpan = 5;

   if(sGrp == null) sGrp="SLSP";
   String sPosition = request.getParameter("POS");
   if(sPosition == null) sPosition="LIST";
   if ( sShowGrp == null) sShowGrp = "ALL";

   if(sShowGrp.equals("SLSP")) iColSpan = 3;
   else if(sShowGrp.equals("SLSBK")) iColSpan = 3;
   else if(sShowGrp.equals("NSLSP")) iColSpan = 5;
   else if(sShowGrp.equals("MNSLS")) iColSpan = 4;
   else if(!sShowGrp.equals("ALL")) iColSpan = 1;

   System.out.println("Grp: " + sGrp + "  ShowGrp: " + sShowGrp);

 // get employee number by hours
   SetEmpNum EmpNum = new SetEmpNum(sStore, sWeekDay, "WEEK");
   String [] sHours = EmpNum.getHours();
   String sHoursJSA = EmpNum.getHoursJSA();
   String [] sWeek = EmpNum.getWeeks();

   String [] sTotSlsGoal = EmpNum.getSlsGoal();

   String [][] sMgrNum = EmpNum.getMgrNum();
   String [][] sSlsNum = EmpNum.getSlsNum();
   String [][] sSlsHrs = EmpNum.getSlsHrs();
   String [][] sHrSlsGoal = EmpNum.getHrSlsGoal();
   String [][] sNSlNum = EmpNum.getNSlNum();
   String [][] sNCsNum = EmpNum.getNCsNum();
   String [][] sNRcNum = EmpNum.getNRcNum();
   String [][] sNBkNum = EmpNum.getNBkNum();
   String [][] sNOtNum = EmpNum.getNOtNum();
   String [][] sTrnNum = EmpNum.getTrnNum();
   String [][] sTotNum = EmpNum.getTotNum();
   String [][] sSBkNum = EmpNum.getSBkNum();
   String [][] sSBkSls = EmpNum.getSBkSls();
   String [][] sSBkHrs = EmpNum.getSBkHrs();
   String [] sSBkDly = EmpNum.getSBkDly();

   String [] sDayGoal85 = EmpNum.getGoal85();
   String [] sDayGoalTot = EmpNum.getGoalTot();
   String [] sDayHrs = EmpNum.getDayHrs();

   String sMonThuPrcJSA = EmpNum.getMonThuPrcJSA();
   String sFriPrcJSA = EmpNum.getFriPrcJSA();
   String sSatPrcJSA = EmpNum.getSatPrcJSA();
   String sSunPrcJSA = EmpNum.getSunPrcJSA();

   EmpNum.disconnect();
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background: lightgrey; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable1 { background: white; padding-right:4px; padding-left:4px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable2 { border-right: darkred solid 1px; }
        td.DataTable3 { background: Linen; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable4 { background: LavenderBlush; padding-right:2px; padding-left:2px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable5 { background: PowderBlue ; padding-right:2px; padding-left:2px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable6 { background: #FFA500; padding-right:4px; padding-left:4px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }

        div.PrcTbl { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.Grid  { cursor:move; background:darkblue; color:white; text-align:center; font-family:Arial; font-size:11px; font-weight:bolder}
        td.Grid1 { background:darkblue; color:white; text-align:center; font-family:Arial; font-size:11px; font-weight:bolder}
        td.Grid2  { background:white; color:red; text-align:center; font-family:Arial; font-size:10px; }
</style>
<SCRIPT language="JavaScript">
//--------------- Global variables -----------------------
var CurStore = <%=sStore%>;
var CurStrName = "<%=sThisStrName%>";
var Month = "<%=sMonth%>"
var WeekEnd = "<%=sWeekEnd%>"
var CurDate = "<%=sWeekDay%>";
var From = "<%=sFrom%>";
var elmColor;
var colColor;

var MonThuPrc = [<%=sMonThuPrcJSA%>];
var FriPrc = [<%=sFriPrcJSA%>];
var SatPrc = [<%=sSatPrcJSA%>];
var SunPrc = [<%=sSunPrcJSA%>];
var Hours = [<%=sHoursJSA%>]
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


function oneGrpOnly(selGrp)
{
  var sbmString = "EmpNumbyHourWk.jsp?STORE=<%=sStore%>"
                + "&STRNAME=<%=sThisStrName%>"
                + "&MONBEG=<%=sMonth%>"
                + "&WEEKEND=<%=sWeekEnd%>"
                + "&WKDATE=<%=sWeekDay%>"
                + "&FROM=<%=sFrom%>"
                + "&WKDAY=<%=sDayOfWeek%>"
                + "&SHWGRP=" + selGrp;
     window.location.href=sbmString;
}

// show Distribution percentage
function showProdPrc()
{
  var prcHtml = "<table cellPadding='0' cellSpacing='0' width='100%'>"
      + "<tr align='center'>"
      + "<td class='Grid' nowrap>Sales Distribution Percentage</td>"
      + "<td  class='Grid1'>"
      + "<img src='CloseButton.bmp' onclick='javascript:hidePrcTbl();' alt='Close'>"
      + "</td></tr>"
      + "<tr align='center'>"
      + "<td class='Grid2' colspan='2' nowrap>based on LY actual for fiscal month</td>"
      + "</tr>"

  prcHtml += "<tr><td colspan='2'>" + popPrcTbl() + "</td></tr>";

  prcHtml += "</table>";

  document.all.PrcTbl.innerHTML=prcHtml
  document.all.PrcTbl.style.pixelLeft=150
  document.all.PrcTbl.style.pixelTop=document.documentElement.scrollTop+120
  document.all.PrcTbl.style.visibility="visible"
}

// populate distribution percantage table
function popPrcTbl()
{
  var prctbl = "<table class='DataTable' cellPadding='0' cellSpacing='0' width='100%'>";
  // "</table>"
  prctbl += "<tr><th class='DataTable'>Hours</th>";
  prctbl += "<th class='DataTable'>M-Thu</th>";
  prctbl += "<th class='DataTable'>Fri</th>";
  prctbl += "<th class='DataTable'>Sat</th>";
  prctbl += "<th class='DataTable'>Sun</th>";
  prctbl += "</tr>";

  for(i=0; i<18; i++)
  {
    prctbl += "<tr><td class='DataTable'>" + Hours[i] + "</td>"
      + "<td class='DataTable'>" + MonThuPrc[i] + "</td>"
      + "<td class='DataTable'>" + FriPrc[i] + "</td>"
      + "<td class='DataTable'>" + SatPrc[i] + "</td>"
      + "<td class='DataTable'>" + SunPrc[i] + "</td>"
    prctbl += "</tr>";
  }
  prctbl +=  "</table>";
  return prctbl;
}

// close employee selection window
function hidePrcTbl()
{
   document.all.PrcTbl.style.visibility="hidden"
}

/**------------------------------------------------------------------**/

// ---------------- Move Boxes ---------------------------------------
var dragapproved=false
var z,x,y
function move(){
if (event.button==1&&dragapproved){
z.style.pixelLeft=temp1+event.clientX-x
z.style.pixelTop=temp2+event.clientY-y
return false
}
}
function drags(){
if (!document.all)
return
var obj = event.srcElement

if (event.srcElement.className=="Grid"
    || event.srcElement.className=="Menu"
    || event.srcElement.className=="Menu1"){
   while (obj.offsetParent){
     if (obj.id=="menu" || obj.id=="PrcTbl")
     {
       z=obj;
       break;
     }
     obj = obj.offsetParent;
   }
  dragapproved=true;
  temp1=z.style.pixelLeft
  temp2=z.style.pixelTop
  x=event.clientX
  y=event.clientY
  document.onmousemove=move
}
}
document.onmousedown=drags
document.onmouseup=new Function("dragapproved=false")
// ---------------- End of Move Boxes ---------------------------------------

</SCRIPT>
</head>
<body>
<!-------------------------------------------------------------------->
<div id="PrcTbl" class="PrcTbl"></div>
<!-------------------------------------------------------------------->

    <table border="0" width="100%" height="100%">
             <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP" colspan=2>
      <b>Retail Concepts, Inc
      <br>Daily Store Schedule</b><br>
<!-------------------------------------------------------------------->
        <b>Store:&nbsp;<%=sStore + " - " + sThisStrName%>
           <br>Week Ending:&nbsp;<%=sWeekEnd%>
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
         <font size="-1">This page;</font>

        <a href="javascript: showProdPrc()">
          <font color="red"  size="-1">Daily SDH %</font></a>
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable" rowspan="1">&nbsp;</th>
           <%for(int i=0; i < 7; i++ ){%>
             <th class="DataTable" colspan="<%=iColSpan%>"><%=sWeek[i]%>
                <br><%=sDaysOfWeek[i]%></th>
             <th class="DataTable" >&nbsp;</th>
           <%}%>

         <%if(sShowGrp.equals("SLSP") || sShowGrp.equals("MNSLS")) {%>
         <tr>
           <th class="DataTable" rowspan="1">Sls/Hr</th>
           <%for(int i=0; i < 7; i++ ){%>
             <th class="DataTable" colspan="<%=iColSpan%>">$<%=sTotSlsGoal[i]%></th>
             <th class="DataTable" >&nbsp;</th>
           <%}%>
         <tr>
         <%}%>
         </tr>
         <!----------------------- SalesGoal 85%--------------------------->
         <%if(sShowGrp.equals("SLSP")) {%>
           <tr><th class="DataTable" rowspan="1">Sales Goal (85%) </th>
             <%for(int i=0; i < 7; i++ ){%>
               <th class="DataTable" colspan="<%=iColSpan%>">$<%=sDayGoal85[i]%></th>
               <th class="DataTable" >&nbsp;</th>
             <%}%>
           </tr>

         <!------------------------------------------------------------->
         <!----------------------- Hours--------------------------->
           <tr><th class="DataTable" rowspan="1">Hours</th>
             <%for(int i=0; i < 7; i++ ){%>
               <th class="DataTable" colspan="<%=iColSpan%>"><%=sDayHrs[i]%></th>
               <th class="DataTable" >&nbsp;</th>
             <%}%>
           </tr>
         <%}%>
         <!------------------------------------------------------------------>
         <!----------------------- Bike SalesGoal --------------------------->
         <%if(sShowGrp.equals("SLSBK")) {%>
           <tr><th class="DataTable" rowspan="1">LY Bike Sales</th>
             <%for(int i=0; i < 7; i++ ){%>
               <th class="DataTable" colspan="<%=iColSpan%>">$<%=sSBkDly[i]%></th>
               <th class="DataTable" >&nbsp;</th>
             <%}%>
           </tr>
         <%}%>
         <!------------------------------------------------------------->



         <tr><th class="DataTable" rowspan="1">Time</th>
           <%for(int i=0; i < 7; i++ ){
             if (sShowGrp.equals("MNGR") || sShowGrp.equals("ALL")){%>
                <th class="DataTable" >M</th>
             <%}
             if(sShowGrp.equals("ALL")) {%>
                <th class="DataTable" >S</th>
             <%}
             if(sShowGrp.equals("SLSP") || sShowGrp.equals("SLSBK")) {%>
                <th class="DataTable" >S</th>
                <th class="DataTable" >SDH</th>
                <th class="DataTable" >$/H</th>
             <%}
             if(sShowGrp.equals("MNSLS")) {%>
                <th class="DataTable" >M</th>
                <th class="DataTable" >S</th>
                <th class="DataTable" >SDH</th>
                <th class="DataTable" >$/H</th>
             <%}
             if(sShowGrp.equals("ALL")) {%>
                <th class="DataTable" >NS</th>
             <%}
             if(sShowGrp.equals("ALL")) {%>
                <th class="DataTable" >Tr</th>
             <%}

             if(sShowGrp.equals("NSLSP")) {%>
                <th class="DataTable" >C</th>
                <th class="DataTable" >R</th>
                <th class="DataTable" >B</th>
                <th class="DataTable" >O</th>
                <th class="DataTable" >T</th>
             <%}

             if(sShowGrp.equals("NSLCS")) {%>
                <th class="DataTable" >C</th>
             <%}
             if(sShowGrp.equals("NSLRC")) {%>
                <th class="DataTable" >R</th>
             <%}
             if(sShowGrp.equals("NSLBK")) {%>
                <th class="DataTable" >B</th>
             <%}
             if(sShowGrp.equals("NSLOT")) {%>
                <th class="DataTable" >O</th>
             <%}

             if(sShowGrp.equals("TRAIN")) {%>
                <th class="DataTable" >Tr</th>
             <%}

             if(sShowGrp.equals("TOTAL") || sShowGrp.equals("ALL")) {%>
                <th class="DataTable" >T</th>
             <%}%>

             <th class="DataTable" >&nbsp;</th>
           <%}%>
         </tr>

        <%for(int i=0; i < sHours.length; i++ ){%>
           <tr onmouseover="mouseOver(this)" onmouseout="mouseOut(this)">
             <td class="DataTable"><%=sHours[i]%></td>

           <%for(int j=0; j < 7; j++){%>
            <% if (sShowGrp.equals("MNGR") || sShowGrp.equals("MNSLS") || sShowGrp.equals("ALL")){%>
               <td class="DataTable1" id="MGR<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sMgrNum[j][i]%></td><%}%>

            <% if (sShowGrp.equals("ALL")){%>
               <td class="DataTable1" id="SLS<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sSlsNum[j][i]%></td>
               <td class="DataTable1" id="NSL<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sNSlNum[j][i]%></td>
               <td class="DataTable1" id="TRN<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sTrnNum[j][i]%></td>
            <%}%>

            <% if (sShowGrp.equals("SLSP")){%>
                  <td class="DataTable6" id="SLS<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sSlsNum[j][i]%></td>
                  <td class="DataTable4" id="SBG<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)">$<%=sHrSlsGoal[j][i]%></td>
                  <td class="DataTable5" id="SBK<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)">$<%=sSlsHrs[j][i]%></td>
            <%}%>

            <% if (sShowGrp.equals("MNSLS")){%>
                  <td class="DataTable6" id="SLS<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sSlsNum[j][i]%></td>
                  <td class="DataTable4" id="SBG<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)">$<%=sHrSlsGoal[j][i]%></td>
                  <td class="DataTable5" id="SBK<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)">$<%=sSlsHrs[j][i]%></td>
            <%}%>

            <% if (sShowGrp.equals("NSLSP")){%>
               <td class="DataTable1" id="NCS<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sNCsNum[j][i]%></td>
               <td class="DataTable1" id="NRC<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sNRcNum[j][i]%></td>
               <td class="DataTable1" id="NBK<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sNBkNum[j][i]%></td>
               <td class="DataTable1" id="NOT<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sNOtNum[j][i]%></td>
               <td class="DataTable3" id="NSL<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sNSlNum[j][i]%></td><%}%>

            <% if (sShowGrp.equals("SLSBK")){%>
                <td class="DataTable1" id="SLS<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sSBkNum[j][i]%></td>
                <td class="DataTable4" id="SBG<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)">$<%=sSBkSls[j][i]%></td>
                  <td class="DataTable5" id="SBK<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)">$<%=sSBkHrs[j][i]%></td>
            <%}%>

            <% if (sShowGrp.equals("NSLCS")){%>
               <td class="DataTable1" id="NSL<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sNCsNum[j][i]%></td>
            <%}%>
            <% if (sShowGrp.equals("NSLRC")){%>
               <td class="DataTable1" id="NSL<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sNRcNum[j][i]%></td>
            <%}%>
            <% if (sShowGrp.equals("NSLBK")){%>
               <td class="DataTable1" id="NSL<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sNBkNum[j][i]%></td>
            <%}%>
            <% if (sShowGrp.equals("NSLOT")){%>
               <td class="DataTable1" id="NSL<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sNOtNum[j][i]%></td>
            <%}%>
            <% if (sShowGrp.equals("TRAIN")){%>
               <td class="DataTable1" id="TRN<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sTrnNum[j][i]%></td>
            <%}%>

            <% if (sShowGrp.equals("TOTAL") || sShowGrp.equals("ALL")){%>
               <td class="DataTable3" id="TOT<%=sColSfx[j]%><%=i%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sTotNum[j][i]%></td><%}%>
               <th class="DataTable">&nbsp;&nbsp;&nbsp;</th>

          <%}%>
      <%}%>
         <!----------------------- SalesGoal 100%--------------------------->
         <%if(sShowGrp.equals("SLSP")) {%>
           <tr><th class="DataTable" rowspan="1">Sales Goal </th>
             <%for(int i=0; i < 7; i++ ){%>
               <th class="DataTable" colspan="<%=iColSpan%>"><%=sDayGoalTot[i]%></th>
               <th class="DataTable" >&nbsp;</th>
             <%}%>
           </tr>
         <%}%>
         <!------------------------------------------------------------->
      </table>
      <!----------------------- end of table ------------------------>
      </td>
    </tr>

   <!----------------------- sdh comments ------------------------>
    <tr bgColor="moccasin">
     <td align=left colspan='2'><font size="-1">
       SDH = Sales distribution by hour is based on LY's entire fiscal month for the same days (M-Thu, Fri, Sat, Sun).
       </font>
          </td>
    </tr>

   <!------------------------------------------------------------->

    <tr bgColor="moccasin">
     <td align=left>
       <font size="-1">
       <% if(!sShowGrp.equals("MNGR")){%>
           Click <a href="javascript:oneGrpOnly('MNGR')">here</a> to see the management only.<br>
       <%}%>
       <% if(!sShowGrp.equals("MNGSLS")){%>
           Click <a href="javascript:oneGrpOnly('MNSLS')">here</a> to see the management and selling personnel.<br>
       <%}%>
       <% if(!sShowGrp.equals("SLSP")){%>
           Click <a href="javascript:oneGrpOnly('SLSP')">here</a> to see the selling personnel only.<br>
       <%}%>
       <% if(!sShowGrp.equals("SLSBK")){%>
           Click <a href="javascript:oneGrpOnly('SLSBK')">here</a> to see the bike selling personnel only.<br>
       <%}%>
       <% if(!sShowGrp.equals("NSLSP")){%>
           Click <a href="javascript:oneGrpOnly('NSLSP')">here</a> to see the non-selling personnel only.<br>
       <%}%>

       <% if(!sShowGrp.equals("TOTAL")){%>
           Click <a href="javascript:oneGrpOnly('TOTAL')">here</a> to see the day totals only.<br>
       <%}%>
       <% if(!sShowGrp.equals("ALL")){%>
           Click <a href="javascript:oneGrpOnly('ALL')">here</a> to see the all employee groups.
       <%}%>
      </font>
     </td>
     <td align=left>
      <font size="-1">
       <% if(!sShowGrp.equals("NSLCS")){%>
           Click <a href="javascript:oneGrpOnly('NSLCS')">here</a> to see the cashiers only.<br>
       <%}%>
       <% if(!sShowGrp.equals("NSLRC")){%>
           Click <a href="javascript:oneGrpOnly('NSLRC')">here</a> to see the receiving only.<br>
       <%}%>
       <% if(!sShowGrp.equals("NSLBK")){%>
           Click <a href="javascript:oneGrpOnly('NSLBK')">here</a> to see the bikeshop only.<br>
       <%}%>
       <% if(!sShowGrp.equals("NSLOT")){%>
           Click <a href="javascript:oneGrpOnly('NSLOT')">here</a> to see the other only.<br>
       <%}%>
       <% if(!sShowGrp.equals("TRAIN")){%>
           Click <a href="javascript:oneGrpOnly('TRAIN')">here</a> to see the training only.<br>
       <%}%>

       </font>
    </td>
   </tr>
  </table>
 </body>
</html>
