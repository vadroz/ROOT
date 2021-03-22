<%@ page import="payrollreports.PsEmpCov"%>
<% String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sWeekDay = request.getParameter("WKDATE");
   String sMonth = request.getParameter("MONBEG");
   String sWeekEnd = request.getParameter("WEEKEND");
   String sFrom = request.getParameter("FROM");
   String sDayOfWeek = request.getParameter("WKDAY");
   String sSchOrSls = request.getParameter("SchOrSls");

   String sSelSec = request.getParameter("SELSEC");
   String sSelGrp = request.getParameter("SELGRP");
   String sAllEmp = request.getParameter("AllEmp");
   String sCalc = request.getParameter("Calc");

   if(sAllEmp == null){ sAllEmp = "SLS";}
   if(sCalc == null){ sCalc = "PERCENT";}
   if(sSchOrSls == null){ sSchOrSls = "P";}

   //if(sSelSec == null) sSelSec = "NONE";

   String [] sDaysOfWeek = new String[]{"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" } ;
   String [] sColSfx = new String[]{"MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN" } ;


   String sPosition = request.getParameter("POS");
   if(sPosition == null) sPosition="LIST";

   // get employee number by hours
   //System.out.println(sStore + "|" + sWeekDay + "|" + "WEEK" + "|" + sAllEmp + "|" + sCalc);
   PsEmpCov EmpNum = new PsEmpCov(sStore, sWeekDay, "WEEK", sAllEmp, sCalc, sSchOrSls);

   int iNumOfSec = EmpNum.getNumOfSec();
   int iNumOfGrp = EmpNum.getNumOfGrp();
   int [] iNumSecGrp = EmpNum.getNumSecGrp();
   String [] sSecLst = EmpNum.getSecLst();
   String [] sSecName = EmpNum.getSecName();
   String [] sSecType = EmpNum.getSecType();
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
   String [] sScrSdh = EmpNum.getScrSdh();

   String sMonThuPrcJSA = EmpNum.getMonThuPrcJSA();
   String sFriPrcJSA = EmpNum.getFriPrcJSA();
   String sSatPrcJSA = EmpNum.getSatPrcJSA();
   String sSunPrcJSA = EmpNum.getSunPrcJSA();

   String sScrStdDev = EmpNum.getScrStdDev();
   String sScrNumHrs = EmpNum.getScrNumHrs();
   String sScrAvg = EmpNum.getScrAvg();
   String sScrAbove = EmpNum.getScrAbove();
   String sScrUnder = EmpNum.getScrUnder();
   String sScrGood = EmpNum.getScrGood();
   String sScrGoodPrc = EmpNum.getScrGoodPrc();
   String sScrClrJsa = EmpNum.getScrClrJsa();
   String sScrMonFriAvg = EmpNum.getScrMonFriAvg();
   String sScrSatSunAvg = EmpNum.getScrSatSunAvg();

   String sDlyScrJsa = EmpNum.getDlyScrJsa();
   String sDlyTotJsa = EmpNum.getDlyTotJsa();
   String sDlyPntJsa = EmpNum.getDlyPntJsa();
   String sDlyAmtJsa = EmpNum.getDlyAmtJsa();

   String sTotGoal85 = EmpNum.getTotGoal85();
   String sTotHrs = EmpNum.getTotHrs();
   String sTotSlsHrs = EmpNum.getTotSlsHrs();

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

   int [] iStoreOpen = { 4, 4, 4, 4, 4, 4, 5};
   int [] iStoreClose = {12, 12, 12, 12, 12, 12, 9};
%>
<html>
<head>
<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:white;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:left; font-family:Verdanda; font-size:12px }
        th.DataTable2 { background:white;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:right; font-family:Verdanda; font-size:12px }
        td.DataTable { background: lightgrey; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable1 { background: white; padding-right:4px; padding-left:4px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable2 { border-right: darkred solid 1px; }
        td.DataTable3 { background: Linen; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable4 { background: LavenderBlush; padding-right:2px; padding-left:2px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable5 { background: LavenderBlush ; padding-right:2px; padding-left:2px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable6 { background: #FFA500; padding-right:4px; padding-left:4px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable7 { background: cornsilk; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }

        div.PrcTbl { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        tr.BSVar { font-size:10px; }
        tr.BSVar1 { background:azure; font-size:10px; }
        tr.BSVar2 { background:#e7e7e7;  font-size:10px; }
        td.BSVar { text-align:left; }
        td.BSVar1 { text-align:right; }
        td.BSVar11 { color: red; text-align:right; }
        td.BSVar2 { text-align:center; }

        div.dvBdgVsSchedVar { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon;
              text-align:center; font-size:10px}

        td.Grid  { background:darkblue; color:white; text-align:center; font-family:Arial; font-size:11px;
                   padding-left:3px; padding-right:3px; font-weight:bolder}
        tr.Grid1 { text-align:center; font-family:Arial; font-size:10px;}
        td.Grid2  { background:darkblue; color:white; text-align:right; font-family:Arial; font-size:11px; font-weight:bolder}
        .Small { font-size:12px;}

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

var DlyScr = [<%=sDlyScrJsa%>];
var DlyTot = [<%=sDlyTotJsa%>];
var DlyPnt = [<%=sDlyPntJsa%>];
var DlyAmt = [<%=sDlyAmtJsa%>];
var DlyClr = [<%=sScrClrJsa%>];

var StdDev = "<%=sScrStdDev%>";
var StrAvg = "<%=sScrAvg%>";
var StrMFAvg = "<%=sScrMonFriAvg%>";
var StrSSAvg = "<%=sScrSatSunAvg%>";

//--------------- End of Global variables -----------------------
//==============================================================================
// initialize processes
//==============================================================================
function bodyLoad()
{
   if(SelSec == "SELL"){markHiSlsPerHrs("SPH");}
   if(SelSec == "SELL"){ setDlyScr();}

   rtvBdgVsSched();
}
//==============================================================================
// retreive budget vs schedule variances
//==============================================================================
function rtvBdgVsSched()
{
   var url="PsBdgSchedVar.jsp?Store=<%=sStore%>"
       + "&Wkend=<%=sWeekEnd%>"

   //alert(url)
   //window.location = url;
   window.frame1.location = url;
}

//==============================================================================
// show budget vs schedule variances
//==============================================================================
function showBdgSchedVar(BdgHrs, SchHrs, HrsVar, PrcVar, GrpName, GrpBdgHrs, GrpSchHrs, GrpHrsVar)
{
  var html = "<table cellPadding='0' cellSpacing='0' width='100%'>"
      html += "<tr align='center'>"
         + "<td class='Grid' nowrap>Budget vs. Schedule</td>"
         + "<td  class='Grid2'>"
         + "<img src='MinimizeButton.bmp' onclick='javascript:hidedvBdgVsSchedVar();' alt='Close'>"
         + "</td></tr>"
         + "<tr>"
         + "<td colspan=2 id='tdBdgVsSch'>" + popBdgVsSchedVarPanel(BdgHrs, SchHrs, HrsVar, GrpName, GrpBdgHrs, GrpSchHrs, GrpHrsVar) + "</td></tr>"

  html += "</table>"

  document.all.dvBdgVsSchedVar.innerHTML=html
  document.all.dvBdgVsSchedVar.style.pixelLeft=12;
  document.all.dvBdgVsSchedVar.style.pixelTop=5;
  document.all.dvBdgVsSchedVar.style.visibility="visible"

  window.frame1.close();
}
//==============================================================================
// populate clinic panel
//==============================================================================
function popBdgVsSchedVarPanel(BdgHrs, SchHrs, HrsVar, GrpName, GrpBdgHrs, GrpSchHrs, GrpHrsVar)
{
   var html = "<table border=1 cellPadding='0' cellSpacing='0' width='100%'>"
            + "<tr class='DataTable'>"
              + "<th class='DataTable'>&nbsp;</th>"
              + "<th class='DataTable'>Budget</th>"
              + "<th class='DataTable'>Sched</th>"
              + "<th class='DataTable'>Var</th>"
            + "</tr>";

   var color = "";

   for(var i=0; i < GrpBdgHrs.length; i++)
   {
      color = "";
      var name = "<input style='padding-bottom:none; padding-top:none; padding-left:0px; font-family:Arial; font-size:10px; border:none; background:#e7e7e7;' size=15 value='" + GrpName[i] + "' readonly>";
      if(GrpName[i].length > 17)
      {
         //name = "<marquee behavior='alternate' scrollamount='1'>" + GrpName[i] + "</marquee>";
      }

      if (GrpHrsVar[i].indexOf("-") > 0){ color = "1"; NegativeBdgVar = true;} // show negative variance in red
      html += "<tr class='BSVar2'>"
           + "<td class='BSVar' nowrap>" + name + "</td>"
           + "<td nowrap class='BSVar1'>" + GrpBdgHrs[i] + "</td>"
           + "<td nowrap class='BSVar1'>" + GrpSchHrs[i] + "</td>"
           + "<td nowrap class='BSVar1" + color + "'>" + GrpHrsVar[i] + "</td>"
         + "</tr>";
   }

   color = "";
   if (HrsVar.indexOf("-") > 0){ color = "1"; NegativeBdgVar = true;} // show negative variance in red

   html += "<tr class='BSVar'>"
           + "<th class='BSVar' nowrap>Allowable Budget</th>"
           + "<td nowrap class='BSVar1'>" + BdgHrs + "</td>"
           + "<td nowrap class='BSVar1'>" + SchHrs + "</td>"
           + "<td nowrap class='BSVar1" + color + "'>" + HrsVar + "</td>"
         + "</tr>";
   // show budget and schedule amount only to managers
   html += "<tr class='BSVar1'>"
           + "<td colspan=4 nowrap >Note: Exclude salaried employees and H,S,V,B.</td>"
         + "</tr>";

   html += "</tr></table>"
   return html
}
//==============================================================================
// close clinic list panel
//==============================================================================
function hidedvBdgVsSchedVar()
{
   var hdr = "Budget vs. Schedule";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='Grid' nowrap>" + hdr + "</td>"
       + "<td class='Grid2' valign=top>"
         +  "<img src='RestoreButton.bmp' onclick='javascript:rtvBdgVsSched();' alt='Restore'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"
   html += "</td></tr></table>"

   document.all.dvBdgVsSchedVar.innerHTML=html
   document.all.dvBdgVsSchedVar.style.pixelLeft=12;
   document.all.dvBdgVsSchedVar.style.pixelTop=5;
}

//==============================================================================
// show daily scores
//==============================================================================
function setDlyScr()
{
   var scr = document.all.tdDlyScr;
   for(var i=0; i < scr.length; i++)
   {
      scr[i].innerHTML = DlyScr[i] + "%";
   }
}
//==============================================================================
// mark highest sales per hours
//==============================================================================
function markHiSlsPerHrs(col)
{
   var sph = document.all[col];
   for(var i=0; i < sph.length; i++)
   {
         if(DlyClr[i] == "A"){sph[i].style.background = "orange";}
         if(DlyClr[i] == "U"){sph[i].style.background = "yellow";}
         if(DlyClr[i] == "R"){sph[i].style.background = "red";}
   }
}
//==============================================================================
// remove dollar sign
//==============================================================================
function removeDollar(number)
{
   var number1 = "";
   try
   {
      var pos = number.indexOf("$");
      if(pos >= 0){ number1 = number.substring(pos + 1);}
      else{ number1 = number;}
   }
   catch(err){ number1 = 0; }
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
// show daily percent calulation
//==============================================================================
function showDlyScrClc(day, obj)
{
   var html = "<table cellPadding='0' cellSpacing='0' width='100%'>"
      + "<tr align='left'>"
        + "<td class='DataTable7' nowrap>Percents = "

   var plus = "";
   html += "(";
   for(var i=0; i < DlyPnt[day].length; i++)
   {
      if(DlyPnt[day][i] != "0")
      {
         html += plus + DlyPnt[day][i];
         plus = " + ";
      }
   }

   plus = "";
   html += ")<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/ <br>(";
   for(var i=0; i < DlyAmt[day].length; i++)
   {
      if(DlyAmt[day][i] != "0")
      {
         html += plus + DlyAmt[day][i];
         plus = " + ";
      }
   }
   html += ") * 100 = " + DlyScr[day] + "%";

   html += "</td>"
      + "</tr>"

  html += "</table>";

  var pos = getObjPosition(obj);

  document.all.dvCalc.innerHTML=html
  document.all.dvCalc.style.pixelLeft=pos[0] - 50;
  document.all.dvCalc.style.pixelTop=pos[1] + 20
  document.all.dvCalc.style.visibility="visible"
}
//==============================================================================
// hide daily score calculation
//==============================================================================
function hideDlyScrClc()
{
   document.all.dvCalc.style.visibility="hidden";
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
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="PrcTbl" class="PrcTbl"></div>
<div id="dvCalc" class="PrcTbl"></div>
<div id="dvBdgVsSchedVar" class="dvBdgVsSchedVar"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

    <table border="0" width="100%" height="100%">
             <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP" colspan=2>
      <b>Retail Concepts, Inc
      <br>Daily Store Schedule</b><br>
<!-------------------------------------------------------------------->
        <b>Store:&nbsp;<%=sStore + " - " + sThisStrName%>
           <br>Week Ending:&nbsp;<%=sWeekEnd%>
           <br><%if(sAllEmp.equals("ALL")){%>All Employees<%} else {%>Sales Persons Only<%}%>
        </b>
      <p>
        <a href="../"><font color="red" size="-1">Home</font></a>&#62;
        <%if(sFrom.equals("AVGPAYREP")){%>
          <a href="APRSelector.jsp"><font color="red"  size="-1">Store Selector</font></a>&#62;
          <a href="AvgPayRep.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>">
            <font color="red" size="-1">Average Pay Report</font></a>&#62;
        <%}%>
        <a href="PsWkSchedSel.jsp"><font color="red" size="-1">Store/Week Selector</font></a>&#62;
        <a href="PsWkSched.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&FROM=<%=sFrom%>">
          <font color="red"  size="-1">Weekly Schedule</font></a>&#62;
         <font size="-1">This page;</font>

        <a href="javascript: showProdPrc()">
          <font color="red"  size="-1">Daily SDH %</font></a>

 &nbsp; &nbsp;
        <%if(!sAllEmp.equals("ALL")){%>
             <a href="PsEmpNum.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWeekDay%>&FROM=<%=sFrom%>&WKDAY=<%=sDayOfWeek%>&SELSEC=<%=sSelSec%>&AllEmp=ALL&Calc=<%=sCalc%>"><font size="-1">All Employees</font></a>
        <%}
          else {%>
             <a href="PsEmpNum.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWeekDay%>&FROM=<%=sFrom%>&WKDAY=<%=sDayOfWeek%>&SELSEC=<%=sSelSec%>&AllEmp=SLS&Calc=<%=sCalc%>"><font size="-1">Sales Persons Only</font></a>
        <%}%>

 &nbsp; &nbsp;
        <%if(!sCalc.equals("STDDEV")){%>
             <a href="PsEmpNum.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWeekDay%>&FROM=<%=sFrom%>&WKDAY=<%=sDayOfWeek%>&SELSEC=<%=sSelSec%>&AllEmp=<%=sAllEmp%>&Calc=STDDEV"><font size="-1">Standard Deviation</font></a>
        <%}
          else {%>
             <a href="PsEmpNum.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWeekDay%>&FROM=<%=sFrom%>&WKDAY=<%=sDayOfWeek%>&SELSEC=<%=sSelSec%>&AllEmp=<%=sAllEmp%>&Calc=PERCENT"><font size="-1">Percent Deviation</font></a>
        <%}%>

        &nbsp;        &nbsp;
        <%if(sSchOrSls.equals("P")){%><a class="Small" href="PsEmpNum.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWeekDay%>&FROM=<%=sFrom%>&WKDAY=<%=sDayOfWeek%>&SELSEC=<%=sSelSec%>&AllEmp=<%=sAllEmp%>&Calc=<%=sCalc%>&SchOrSls=S">Calc Base on Actual Sales</a><%}
        else {%><a class="Small" href="PsEmpNum.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWeekDay%>&FROM=<%=sFrom%>&WKDAY=<%=sDayOfWeek%>&SELSEC=<%=sSelSec%>&AllEmp=<%=sAllEmp%>&Calc=<%=sCalc%>&SchOrSls=P">Calc Base On Plan</a><%}%>

      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable" rowspan="1">&nbsp;</th>
           <%for(int i=0; i < 7; i++ ){%>
             <th class="DataTable" colspan="<%=iColSpan%>"><%=sWeek[i]%>
                <br><%=sDaysOfWeek[i]%></th>
             <th class="DataTable" >&nbsp;</th>
           <%}%>
           <th class="DataTable">Total</th>

         <%if(sSelSec != null && sSelSec.equals("SELL")) {%>
         <tr>
           <th class="DataTable" rowspan="1">Sls/Hr</th>
           <%for(int i=0; i < 7; i++ ){%>
             <th class="DataTable" colspan="<%=iColSpan%>">$<%=sTotSlsGoal[i]%></th>
             <th class="DataTable" >&nbsp;</th>
           <%}%>
           <th class="DataTable">$<%=sTotSlsHrs%></th>
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
             <th class="DataTable" >$<%=sTotGoal85%></th>
           </tr>

         <!------------------------------------------------------------->
         <!----------------------- Hours--------------------------->
           <tr><th class="DataTable" rowspan="1">Hours</th>
             <%for(int i=0; i < 7; i++ ){%>
               <th class="DataTable" colspan="<%=iColSpan%>"><%=sDayHrs[i]%></th>
               <th class="DataTable" >&nbsp;</th>
             <%}%>
             <th class="DataTable" ><%=sTotHrs%></th>
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
           <th class="DataTable" rowspan=19>&nbsp;</th>
         </tr>

        <%for(int i=0; i < sHours.length; i++ ){%>
           <tr onmouseover="mouseOver(this)" onmouseout="mouseOut(this)">
             <td class="DataTable"><%=sHours[i]%></td>


           <%for(int j=0; j < 7; j++){%>

               <!----------------------- sections  --------------------------->
               <%if(sSelSec != null && (sSelSec.equals("ALL") || sSelSec.equals("SELL"))){%>
                  <%for(int k=0; k < iNumOfSec; k++ ){%>
                     <%if(sSelSec.equals("ALL") || sSelSec.equals(sSecLst[k]) || sSelSec.equals("SELL") && k==0 ){%>
                        <td class="DataTable1"
                           style="<%if(i >= iStoreOpen[j] && i <= iStoreClose[j] ){%>background:#e7e7e7"<%}
                           else {%>opacity:0.1; filter:Alpha(opacity=40); <%}%>"
                          id="<%=sSecLst[k] + j%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)">
                           <%if(sSelSec.equals("SELL")) {
                               int iSell = 0;
                               for(int n=1; n < iNumOfSec; n++)
                               {
                                 try{iSell += Integer.parseInt(sSecNum[n][j][i]);}
                                 catch(Exception e){  }
                               }
                           %>
                               <%if(!sAllEmp.equals("ALL")){%><%=iSell%><%} else {%><%=sTotNum[j][i]%><%}%>
                           <%}
                           else {%><%=sSecNum[k][j][i]%><%}%>
                        </td>
                        <%if(sSelSec.equals("SELL")){%>
                          <td class="DataTable4" id="<%= "SDH" + k + j%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"
                              style="<%if(i >= iStoreOpen[j] && i <= iStoreClose[j] ){%>background:#e7e7e7<%}
                              else {%>opacity:0.1; filter:Alpha(opacity=40); <%}%>">$<%=sHrSlsGoal[j][i]%></td>
                          <td class="DataTable5" id="SPH<%if(i < iStoreOpen[j] || i > iStoreClose[j]){%>Closed<%}%>" onmouseover="hilightCol(this, true)" onmouseout="hilightCol(this, false)"
                             style="<%if(i >= iStoreOpen[j] && i <= iStoreClose[j] ){%>background:#e7e7e7<%}
                              else {%>opacity:0.1; filter:Alpha(opacity=40); <%}%>">$<%=sSlsHrs[j][i]%></td>
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

               <th class="DataTable"
                 style="<%if(i >= iStoreOpen[j] && i <= iStoreClose[j] ){%>background:#e7e7e7<%}
                        else {%>opacity:0.1; filter:Alpha(opacity=40); <%}%>" >&nbsp;</th>
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

         <!----------------------- SalesGoal 100%--------------------------->
         <%if(sSelSec != null && sSelSec.equals("SELL")) {%>
           <tr><th class="DataTable" rowspan="1">Daily Score<sup>(1)</sup></th>
             <%for(int i=0; i < 7; i++ ){%>
               <th class="DataTable" id="tdDlyScr" colspan="<%=iColSpan%>"
                 onmouseover="showDlyScrClc('<%=i%>', this)" onmouseout="hideDlyScrClc()">&nbsp;</th>
               <th class="DataTable" >&nbsp;</th>
             <%}%>
             <th class="DataTable"><%=sScrGoodPrc%>%</th>
           </tr>
         <%}%>
         <!------------------------------------------------------------->
      </table>
      <!----------------------- end of table ------------------------>

      </td>
    </tr>

   <!----------------------- sdh comments ------------------------>
    <tr bgColor="moccasin">
     <td align=left colspan='2'>
       <font size="-1">
         SDH = Sales distribution by hour is based on Last 3 years entire fiscal month for the same days (M-Thu, Fri, Sat, Sun).
         <br><span style="border:1px solid darkred; background:#e7e7e7;">&nbsp; &nbsp;</span> - Hours used in score measurements.
         <br><span style="border:1px solid darkred; background:orange;">&nbsp; &nbsp;</span> - Percent of hourly sales per employee more than 20% above average.
         <br><span style="border:1px solid darkred; background:yellow;">&nbsp; &nbsp;</span> - Percent of hourly sales per employee more than 20% below average.
         <br><sup>(1)</sup> Daily Scores are calculated by adding the amount of projected sales for those hours within
              the acceptable range and dividing that amount into the total projected sales for the day
              (limited to hours used in score measurements).
       </font>
      </td>
    </tr>

    <!----------------------- Schedule scores ------------------------>
    <tr bgColor="moccasin">
     <td align=center colspan='2'><font size="-1">
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
          <th class="DataTable" colspan="2">Schedule Score</th>
        </tr>
        <tr>
          <th class="DataTable1">Number Of Selling Hours</th>
          <th class="DataTable2"><%=sScrNumHrs%></th>
        </tr>
        <tr>
          <th class="DataTable1">Average $/Hour</th>
          <th class="DataTable2">$<%=sScrAvg%></th>
        </tr>
        <%if(sCalc.equals("PERCENT")){%>
           <tr>
             <th class="DataTable1">Monday-Friday Average $/Hour</th>
             <th class="DataTable2">$<%=sScrMonFriAvg%></th>
           </tr>
           <tr>
             <th class="DataTable1">Saturday-Sunday Average $/Hour</th>
             <th class="DataTable2">$<%=sScrSatSunAvg%></th>
           </tr>
        <%}
          else {%>
            <tr>
              <th class="DataTable1">Standard Deviation</th>
              <th class="DataTable2">$<%=sScrStdDev%></th>
            </tr>
        <%}%>
        <tr>
          <th class="DataTable1">Percent of hours significantly above average $/H</th>
          <th class="DataTable2" style="background:orange;"><%=sScrAbove%>%</th>
        </tr>
        <tr>
          <th class="DataTable1">Percent of hours significantly below average $/H</th>
          <th class="DataTable2" style="background:yellow;"><%=sScrUnder%>%</th>
        </tr>
       <tr>
          <th class="DataTable1">Percent of hours within acceptable range</th>
          <th class="DataTable2"><%=sScrGoodPrc%>%</th>
        </tr>
      </table>
   </td>
  </tr>

      <!----------------------- end Schedule scores ------------------------>


   <!------------------------------------------------------------->
       </font>
    </td>
   </tr>
  </table>
 </body>
</html>
