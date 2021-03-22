<%@ page import="payrollreports.PrEmpNum"%>
<% String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sWeekDay = request.getParameter("WKDATE");
   String sMonth = request.getParameter("MONBEG");
   String sWeekEnd = request.getParameter("WEEKEND");
   String sFrom = request.getParameter("FROM");
   String sDayOfWeek = request.getParameter("WKDAY");

   String sSelSec = request.getParameter("SELSEC");
   String sSelGrp = request.getParameter("SELGRP");

   //if(sSelSec == null) sSelSec = "NONE";

   String [] sDaysOfWeek = new String[]{"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" } ;
   String [] sColSfx = new String[]{"MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN" } ;


   String sPosition = request.getParameter("POS");
   if(sPosition == null) sPosition="LIST";

 // get employee number by hours
   PrEmpNum EmpNum = new PrEmpNum(sStore, sWeekDay, "WEEK");

   int iNumOfSec = EmpNum.getNumOfSec();
   int iNumOfGrp = EmpNum.getNumOfGrp();
   int [] iNumSecGrp = EmpNum.getNumSecGrp();
   String [] sSecLst = EmpNum.getSecLst();
   String [] sSecName = EmpNum.getSecName();
   String [] sGrpLst = EmpNum.getGrpLst();
   String [] sGrpName = EmpNum.getGrpName();
   String [] sGrpSecLst = EmpNum.getGrpSecLst();
   String [] sGrpSecName = EmpNum.getGrpSecName();

   String [] sHours = EmpNum.getHours();
   String sHoursJSA = EmpNum.getHoursJSA();
   String [] sWeek = EmpNum.getWeeks();

   String [] sTotSlsGoal = EmpNum.getSlsGoal();

   String [][][] sSecNum = EmpNum.getSecNum();
   String [][][] sGrpNum = EmpNum.getGrpNum();
   String [][] sHrSlsGoal = EmpNum.getHrSlsGoal();
   String [][] sSlsHrs = EmpNum.getSlsHrs();
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

   int iSelSec = 0;
   int iColSpan = 4;

   if(sSelSec != null && sSelSec.equals("SELL")) iColSpan = 3;
   else if(sSelGrp != null && sSelGrp.equals("SLBK")) iColSpan = 3;
   else if(sSelGrp != null && !sSelGrp.equals("SLBK")) iColSpan = 1;
   else if(sSelSec != null && !sSelSec.equals("SELL"))
   {
      for(int i=0; i < iNumOfSec; i++)
      {
         if(sSecLst[i].equals(sSelSec)) { iColSpan = iNumSecGrp[i]; iSelSec = i; break; }
      }
      iColSpan++;
   }

   int [] iStoreOpen = {3, 3, 3, 3, 3, 3, 4};
   int [] iStoreClose = {13, 13, 13, 13, 13, 13, 10};
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
var SelSec = "<%=sSelSec%>";
var SelGrp = null;
<%if(sSelGrp != null){%>SelGrp = "<%=sSelGrp%>";<%}%>

//--------------- End of Global variables -----------------------
//==============================================================================
// initialize processes
//==============================================================================
function bodyLoad()
{
   if(SelSec == "SELL"){markHiSlsPerHrs("SPH");}
   if(SelGrp == "SLBK") { markHiSlsPerHrs("SBH"); }
}
//==============================================================================
// mark highest sales per hours
//==============================================================================
function markHiSlsPerHrs(col)
{
   var HiSlsHr = [0, 0, 0, 0, 0];
   var HiCell = new Array(5);

   var sph = document.all[col];

   for(var i=0; i < sph.length; i++)
   {
       var curSph = eval(removeDollar(removeComas(sph[i].innerHTML)));
       for(var j=0; j < HiSlsHr.length; j++)
       {
          if(HiSlsHr[j] < curSph)
          {

             for(var k=HiSlsHr.length-1; k > j; k--)
             {
                HiSlsHr[k] = HiSlsHr[k-1];
                HiCell[k] = HiCell[k-1];
             }

             HiSlsHr[j] = curSph;
             HiCell[j] = sph[i];
             break;
          }
       }
   }

   for(var k=0; k < HiCell.length; k++)
   {
      HiCell[k].style.background = "tomato";
   }
}
//==============================================================================
// remove dollar sign
//==============================================================================
function removeDollar(number)
{
   var number1 = "";
   var pos = number.indexOf("$");
   if(pos >= 0){ number1 = number.substring(pos + 1);}
   else{ number1 = number;}
   return number1;
}
//==============================================================================
// calculate payroll hours
//==============================================================================
function removeComas(number)
{
   var number1 = "";
   var neg = false
   for(var i=0; i < number.length; i++)
   {
      if (number.substring(i, i+1) != "," && number.substring(i, i+1) != "-")
      {
        number1 += number.substring(i, i+1);
      }
      else if(number.substring(i, i+1) == "-"){neg = true;}
   }

   if(neg) { number1 = number1 * (-1) };
   return number1;
}

//==============================================================================
// move over the cell
//==============================================================================
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
//==============================================================================
// change text color on mouse moved over table row
//==============================================================================
function hilightCol(obj, inout)
{
  var col = document.all[obj.id];

  // save old background color
  if (inout){ colColor = obj.style.backgroundColor; }

  var clr = null;
  if (inout){ clr = "yellow"; }
  else { clr = colColor; }

  //for (i=0; i < col.length; i++)
  //{
  //   col[i].style.backgroundColor = clr
  //}
}

//==============================================================================
// show one group only
//==============================================================================
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
<body onload="bodyLoad()">
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
        <%if(sFrom.equals("AVGPAYREP")){%>
          <a href="APRSelector.jsp"><font color="red"  size="-1">Store Selector</font></a>&#62;
          <a href="AvgPayRep.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>">
            <font color="red" size="-1">Average Pay Report</font></a>&#62;
        <%}%>
        <a href="PrWkSchedSel.jsp"><font color="red" size="-1">Store/Week Selector</font></a>&#62;
        <a href="PrWkSched.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&FROM=<%=sFrom%>">
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

         <%if(sSelSec != null && sSelSec.equals("SELL")) {%>
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
         <%if(sSelSec != null && sSelSec.equals("SELL")) {%>
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
         <%if(sSelGrp != null && sSelGrp.equals("SLBK")) {%>
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
             if (sSelSec != null && (sSelSec.equals("MNGR") || sSelSec.equals("ALL"))){%>
                <th class="DataTable" >M</th>
             <%}
             if(sSelSec != null && sSelSec.equals("ALL")) {%>
                <th class="DataTable" >S</th>
             <%}

             if(sSelSec != null && sSelSec.equals("SELL") || sSelGrp != null && sSelGrp.equals("SLBK")) {%>
                <th class="DataTable" >S</th>
                <th class="DataTable" >SDH</th>
                <th class="DataTable" >$/H</th>
             <%}

             if(sSelSec != null && sSelSec.equals("ALL")) {%>
                <th class="DataTable" >NS</th>
             <%}
             if(sSelSec != null && sSelSec.equals("ALL")) {%>
                <th class="DataTable" >Tr</th>
             <%}

             if(sSelSec != null && !sSelSec.equals("SELL")) {%>

                <%for(int j=0; j < iNumOfGrp; j++){%>
                   <%if(sGrpSecLst[j].equals(sSelSec)) {%>
                     <th class="DataTable"><%=sGrpName[j].substring(0,1)%></th>
                   <%}%>
                <%}%>
                <th class="DataTable" >T</th>
             <%}%>

             <%if(sSelGrp != null && !sSelGrp.equals("SLBK")) {%>
                <%for(int j=0; j < iNumOfGrp; j++){%>
                   <%if(sGrpLst[j].equals(sSelGrp)) {%>
                     <th class="DataTable"><%=sGrpName[j].substring(0,1)%></th>
                   <%}%>
                <%}%>
             <%}%>

             <th class="DataTable" >&nbsp;&nbsp;&nbsp;</th>
           <%}%>
         </tr>

        <%for(int i=0; i < sHours.length; i++ ){%>
           <tr onmouseover="mouseOver(this)" onmouseout="mouseOut(this)">
             <td class="DataTable"><%=sHours[i]%></td>


           <%for(int j=0; j < 7; j++){%>

               <!----------------------- sections  --------------------------->
               <%if(sSelSec != null && (sSelSec.equals("ALL") || sSelSec.equals("SELL"))){%>
                  <%for(int k=0; k < iNumOfSec; k++ ){%>
                     <%System.out.println(sSelSec.equals(sSecLst[k]) + "|" + sSecLst[k]);%>
                     <%if(sSelSec.equals("ALL") || sSelSec.equals(sSecLst[k])){%>
                        <td class="DataTable1" <%if(i >= iStoreOpen[j] && i <= iStoreClose[j] && sSecNum[k][j][i].trim().equals("0")){%>style="background:pink"<%}%>
                          id="<%=sSecLst[k] + j%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sSecNum[k][j][i]%></td>
                        <%if(sSelSec.equals("SELL")){%>
                          <td class="DataTable4" id="<%= "SDH" + k + j%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)">$<%=sHrSlsGoal[j][i]%></td>
                          <td class="DataTable5" id="<%= "SPH"%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)">$<%=sSlsHrs[j][i]%></td>
                        <%}%>

                        <!-- Non-selling personal  -->
                     <%}%>
                  <%}%>
                  <%if(sSelSec.equals("ALL") || !sSelSec.equals("SELL")){%><td class="DataTable3"  id="<%="Tot" + j%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sTotNum[j][i]%></td><%}%>
               <%}%>
               <!---------------------- end sections -------------------------->

               <!------------------------- groups ----------------------------->
               <%if(sSelSec != null && !sSelSec.equals("ALL") && !sSelSec.equals("SELL")){%>
                  <!-- Non-selling personal  -->
                  <%for(int k=0; k < iNumOfGrp; k++ ){%>
                       <%if(sGrpSecLst[k].equals(sSelSec)) {%>
                            <td class="DataTable1"  id="<%=sGrpLst[k] + j%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sGrpNum[k][j][i]%></td>
                       <%}%>
                  <%}%>
                  <td class="DataTable3" <%if(i >= iStoreOpen[j] && i <= iStoreClose[j] && sSecNum[iSelSec][j][i].trim().equals("0")){%>style="background:pink"<%}%>
                     id="<%="Tot" + j%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sSecNum[iSelSec][j][i]%></td>
               <%}%>
               <!---------------------- end groups ---------------------------->

               <!------------------------- groups ----------------------------->
               <%if(sSelGrp != null){%>
                  <!-- Non-selling personal  -->
                  <%for(int k=0; k < iNumOfGrp; k++ ){%>
                       <%if(sGrpLst[k].equals(sSelGrp)) {%>
                            <td class="DataTable1" <%if(i >= iStoreOpen[j] && i <= iStoreClose[j] && sGrpNum[k][j][i].trim().equals("0")){%>style="background:pink"<%}%>
                                id="<%=sGrpLst[k] + j%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"><%=sGrpNum[k][j][i]%></td>
                            <%if(sSelGrp.equals("SLBK")) {%>
                              <td class="DataTable4" id="<%="SBS" + j%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)">$<%=sSBkSls[j][i]%></td>
                              <td class="DataTable5" id="SBH" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)">$<%=sSBkHrs[j][i]%></td>
                            <%}%>
                       <%}%>
                  <%}%>
               <%}%>
               <!---------------------- end groups ---------------------------->

               <th class="DataTable" >&nbsp;</th>
           <%}%>
      <%}%>

         <!----------------------- SalesGoal 100%--------------------------->
         <%if(sSelSec != null && sSelSec.equals("SLSP")) {%>
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
       </font>
    </td>
   </tr>
  </table>
 </body>
</html>
