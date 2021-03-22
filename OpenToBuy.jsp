<%@ page import="agedanalysis.OpenToBuy, java.util.*"%>
<%
   //Mult=on&Div=1&Div=2&Div=88&DIVISION=1&DIVNAME=1+-+SKI+ACCESSORIES++++++++++&DEPARTMENT=8&DPTNAME=8+-+BASIC+TURTLENECKS++++++++&CLASS=ALL&STORE=ALL&mode=2&RetVal=1&NumMon=12&Type=B&SUBMIT=Submit

   String sStore = request.getParameter("STORE");
   String sDivision = request.getParameter("DIVISION");
   String sDivName = request.getParameter("DIVNAME");
   String sDepartment = request.getParameter("DEPARTMENT");
   String sDptName = request.getParameter("DPTNAME");
   String sClass = request.getParameter("CLASS");
   String sClsName = request.getParameter("CLSNAME");
   String sNumMon = request.getParameter("NumMon");
   String sType = request.getParameter("Type");
   String sRetVal = request.getParameter("RetVal");
   String sCstVal = request.getParameter("CstVal");
   String sUntVal = request.getParameter("UntVal");
   String sNav = request.getParameter("Nav");

   String sMult = request.getParameter("Mult");
   String [] sMultDiv = request.getParameterValues("Div");

   if(sStore == null) sStore = "ALL";
   if(sDivision == null) sDivision = "ALL";
   if(sDivName == null) sDivName = "All Divisions";
   if(sDepartment == null) sDepartment = "ALL";
   if(sDptName == null) sDptName = "All Departments";
   if(sClass == null) sClass = "ALL";
   if(sClsName == null) sClsName = "All Classes";
   if(sNumMon == null) sNumMon = "12";
   if(sRetVal == null) sRetVal = "0";
   if(sCstVal == null) sCstVal = "0";
   if(sUntVal == null) sUntVal = "0";
   if(sNav == null) sNav = "N";

   if(sMult == null || !sMult.equals("Y"))
   {
      sMult = "N";
      sMultDiv = new String[]{ sDivision };
   }

   //System.out.println(sStore  + " " + sDivision + " " + sDepartment + " " + sClass
   //       + " " + sNumMon + " " + sRetVal + " " + sCstVal + " " + sUntVal + " " + sType);

   OpenToBuy opnbuy = new OpenToBuy(sStore, sMult, sMultDiv, sDepartment, sClass, sNumMon,
                                          sRetVal, sCstVal, sUntVal, sType);

    int iNumOfMon = opnbuy.getNumOfMon();
    String [] sMonBeg = opnbuy.getMonBeg();
    String [] sMonEnd = opnbuy.getMonEnd();
    String [] sMonName = opnbuy.getMonName();
    String sMonNameJsa = opnbuy.getMonNameJsa();

    int iNumOfVal = opnbuy.getNumOfVal();
    String [] sValue = opnbuy.getValue();
    String [][] sPlanRet = opnbuy.getSlsPlanRet();
    String [][] sPlanInv = opnbuy.getSlsPlanInv();
    String [][] sPlanMkd = opnbuy.getSlsPlanMkd();
    String [] sPlanSlsLpRet = opnbuy.getSlsPlanLpRet();
    String [] sPlanSlsLpInv = opnbuy.getSlsPlanLpInv();
    String [] sPlanSlsLpMkd = opnbuy.getSlsPlanLpMkd();
    String [] sPlanMkdLp = opnbuy.getMkdPlanLp();
    String [][] sPlanReqForPln = opnbuy.getPlanReqForPln();
    String [] sActSlsMtd = opnbuy.getActSlsMtd();
    String [][] sCurBegInv = opnbuy.getCurBegInv();
    String [][] sOpenToRcv = opnbuy.getOpenToRcv();
    String [][] sOpenPO = opnbuy.getOpenPO();
    String [][] sOpenToBuy = opnbuy.getOpenToBuy();
    String [][] sOpenCarryFwd = opnbuy.getOpenCarryFwd();

    // Totals
    String [] sTotPlanRet = opnbuy.getTotPlanRet();
    String [] sTotPlanMkd = opnbuy.getTotPlanMkd();
    String [] sTotPlanSlsLpRet = opnbuy.getTotPlanLpRet();
    String [] sTotPlanMkdLp = opnbuy.getTotMkdPlanLp();
    String [] sTotReqForPlan = opnbuy.getTotReqForPlan();
    String [] sTotOpenToRcv = opnbuy.getTotOpenToRcv();
    String [] sTotOpenPO = opnbuy.getTotOpenPO();
    String [] sTotOpenToBuy = opnbuy.getTotOpenToBuy();

    // Navigation
    String sNavigCls = opnbuy.getNavigCls();
    String sNavigDpt = opnbuy.getNavigDpt();
    String sNavigDiv = opnbuy.getNavigDiv();
    String sNavigClsName = opnbuy.getNavigClsName();
    String sNavigDptName = opnbuy.getNavigDptName();
    String sNavigDivName = opnbuy.getNavigDivName();


    //========== Ven/Div/Dpt/Cls ==========================

    String sNumOfVen = opnbuy.getNumOfVenJsa();
    String sPoVen = opnbuy.getPoVenJsa();
    String sPoVenName = opnbuy.getPoVenNameJsa();
    String sPoVenRet = opnbuy.getPoVenRetJsa();
    String sPoVenCst = opnbuy.getPoVenCstJsa();
    String sPoVenUnt = opnbuy.getPoVenUntJsa();

    String sNumOfDdc = opnbuy.getNumOfDdcJsa();
    String sPoDdc = opnbuy.getPoDdcJsa();
    String sPoDdcName = opnbuy.getPoDdcNameJsa();
    String sPoDdcRet = opnbuy.getPoDdcRetJsa();
    String sPoDdcCst = opnbuy.getPoDdcCstJsa();
    String sPoDdcUnt = opnbuy.getPoDdcUntJsa();

    int iNumOfVenSum = opnbuy.getNumOfVenSum();
    String sSumPoVen = opnbuy.getSumPoVenJsa();
    String sSumPoVenName = opnbuy.getSumPoVenNameJsa();
    String sSumPoVenRet = opnbuy.getSumPoVenRetJsa();
    String sSumPoVenCst = opnbuy.getSumPoVenCstJsa();
    String sSumPoVenUnt = opnbuy.getSumPoVenUntJsa();

    int iNumOfDdc = opnbuy.getNumOfDdcSum();
    String sSumPoDdc = opnbuy.getSumPoDdcJsa();
    String sSumPoDdcName = opnbuy.getSumPoDdcNameJsa();
    String sSumPoDdcRet = opnbuy.getSumPoDdcRetJsa();
    String sSumPoDdcCst = opnbuy.getSumPoDdcCstJsa();
    String sSumPoDdcUnt = opnbuy.getSumPoDdcUntJsa();
    //=====================================================

    opnbuy.disconnect();

    String sCSSCls = "DataTable";
 %>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue; font-size:12px } a:visited { color:blue; font-size:12px }  a:hover { color:blue; font-size:12px }
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        th.InvData { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.InvData { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}


        tr.DataTable { background:#E7E7E7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:white; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:CornSilk; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center;}
        td.DataTable3 {color:blue; cursor: hand; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:right; text-decoration: underline;}


        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }

        button.Smallest {background:gainsboro; height: 18px; margin-top:5px; font-family:Arial;
                         font-size:10px }

        div.Prompt { background-image: url(Navigate.bmp); background-repeat: no-repeat; position:absolute; visibility:hidden;
                    background-attachment: scroll; width:350; height: 90px; z-index:10; text-align:center; font-size:10px}
        div.dvPO { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt {border-bottom: black solid 2px; border-right: black solid 1px; text-align:center;
                   font-family:Arial; font-size:10px; }

</style>


<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//report parameters
var Store = "<%=sStore%>";
var Division = "<%=sDivision%>";
var Department = "<%=sDepartment%>";
var Class = "<%=sClass%>";
var NumMon = "<%=sNumMon%>";
var RetVal = "<%=sRetVal%>";
var CstVal = "<%=sCstVal%>";
var UntVal = "<%=sUntVal%>";
var PlanType = "<%=sType%>";
var New = 0;

var MonName = [<%=sMonNameJsa%>];

// prompt arrays
var strLst = null;
var strName = null;
var divLst = null;
var divName = null;
var dptLst = null;
var dptName = null;
var dptGrpLst = null;
var clsLst = null;
var clsName = null;

var NavigCls = [<%=sNavigCls%>];
var NavigDpt = [<%=sNavigDpt%>];
var NavigDiv = [<%=sNavigDiv%>];
var NavigClsName = [<%=sNavigClsName%>];
var NavigDptName = [<%=sNavigDptName%>];
var NavigDivName = [<%=sNavigDivName%>];

//--------------------------------------------------------
// Open Purchase Orders by vendors
var NumOfVen = [<%=sNumOfVen%>];
var PoVen = [<%=sPoVen%>];
var PoVenName = [<%=sPoVenName%>];
var PoVenRet = [<%=sPoVenRet%>];
var PoVenCst = [<%=sPoVenCst%>];
var PoVenUnt = [<%=sPoVenUnt%>];

// Open Purchase Orders by div/Dpt/Cls
var NumOfDdc = [<%=sNumOfDdc%>];
var PoDdc = [<%=sPoDdc%>];
var PoDdcName = [<%=sPoDdcName%>];
var PoDdcRet = [<%=sPoDdcRet%>];
var PoDdcCst = [<%=sPoDdcCst%>];
var PoDdcUnt = [<%=sPoDdcUnt%>];

//--------------------------------------------------------
// Open Purchase Orders by vendors current + 3 months summary

var NumOfVenSum = <%=iNumOfVenSum%>;
var SumPoVen = [<%=sSumPoVen%>];
var SumPoVenName = [<%=sSumPoVenName%>];
var SumPoVenRet = [<%=sSumPoVenRet%>];
var SumPoVenCst = [<%=sSumPoVenCst%>];
var SumPoVenUnt = [<%=sSumPoVenUnt%>];

// Open Purchase Orders by div/Dpt/Cls current + 3 months summary
var NumOfDdcSum = <%=iNumOfDdc%>;
var SumPoDdc = [<%=sSumPoDdc%>];
var SumPoDdcName = [<%=sSumPoDdcName%>];
var SumPoDdcRet = [<%=sSumPoDdcRet%>];
var SumPoDdcCst = [<%=sSumPoDdcCst%>];
var SumPoDdcUnt = [<%=sSumPoDdcUnt%>];
//---------------------------------------------------------


//--------------- End of Global variables ----------------
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvPO"]);
	
   selectPanel();
   
}
//--------------------------------------------------------
// show selection screen
//--------------------------------------------------------
function selectPanel()
{
   var html = "<table border='0'>"
       + "<tr style='font-size:10px'>"
         + "<td style='background: gold1; text-align:center; padding-top:10px;' nowrap><u>Div</u></td>"
         + "<td style='background: gold1; text-align:center; padding-top:10px;' nowrap><u>Dpt</u></td>"
         + "<td style='background: gold1; text-align:center; padding-top:10px;' nowrap><u>Cls</u></td>"
         + "<td style='text-align:right; padding-top:10px;' nowrap>&nbsp; <u>New Window</u> &nbsp;</td>"
         + "<td style='background: gold1; text-align:center; padding-top:10px;' nowrap><u>Cls</u></td>"
         + "<td style='background: gold1; text-align:center; padding-top:10px;' nowrap><u>Dpt</u></td>"
         + "<td style='background: gold1; text-align:center; padding-top:10px;' nowrap><u>Div</u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>"
       + "</tr>"

       + "<tr style='font-size:10px'>"
         + "<td><button onClick='goToNextPrv(&#34;PRVDIV&#34;)' onmouseover='showDesc(&#34;PRVDIV&#34;)' class='Smallest'>&#60;&#60;&#60;</button></td>"
         + "<td><button onClick='goToNextPrv(&#34;PRVDPT&#34;)' onmouseover='showDesc(&#34;PRVDPT&#34;)' class='Smallest'>&#60;&#60;</button></td>"
         + "<td><button onClick='goToNextPrv(&#34;PRVCLS&#34;)' onmouseover='showDesc(&#34;PRVCLS&#34;)' class='Smallest'>&#60;</button></td>"
         + "<td style='text-align:center' nowrap><input name='NewWin' type='checkbox'></td>"
         + "<td><button onClick='goToNextPrv(&#34;NXTCLS&#34;)' onmouseover='showDesc(&#34;NXTCLS&#34;)' class='Smallest'>&#62;</button></td>"
         + "<td><button onClick='goToNextPrv(&#34;NXTDPT&#34;)' onmouseover='showDesc(&#34;NXTDPT&#34;)' class='Smallest'>&#62;&#62;</button></td>"
         + "<td><button onClick='goToNextPrv(&#34;NXTDIV&#34;)' onmouseover='showDesc(&#34;NXTDIV&#34;)' class='Smallest'>&#62;&#62;&#62;</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>"
       + "</tr>"
       + "<tr style='color=lightgreen; font-size:10px'>" + "<td id='tdDesc' style=' padding-top:8px;' colspan=7></td>" + "</tr>"
     + "</table><br>"
   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft= 1;
   document.all.Prompt.style.pixelTop= 10;
   document.all.Prompt.style.visibility = "visible";
}
//--------------------------------------------------------
// show selected class description
//--------------------------------------------------------
function showDesc(direction)
{
   var desc;
   if(direction == "NXTCLS") { desc = "Class: " + NavigCls[0] + " - " + NavigClsName[0]; }
   else if(direction == "NXTDPT") { desc = "Department: " + NavigDpt[1] + " - " + NavigDptName[1]; }
   else if(direction == "NXTDIV") { desc = "Division: " + NavigDiv[2] + " - " + NavigDivName[2]; }
   else if(direction == "PRVCLS") { desc = "Class: " + NavigCls[3] + " - " + NavigClsName[3]; }
   else if(direction == "PRVDPT") { desc = "Department: " + NavigDpt[4] + " - " + NavigDptName[4]; }
   else if(direction == "PRVDIV") { desc = "Division: " + NavigDiv[5] + " - " + NavigDivName[5]; }

   document.all.tdDesc.innerHTML= desc;
}
//--------------------------------------------------------
// go to next/previous Cls/Dpt/Div
//--------------------------------------------------------
function goToNextPrv(direction)
{
  var div, divnm, dpt, dptnm, cls, clsnm
  if(direction == "NXTCLS") // Next Class
  {
     div = NavigDiv[0]; dpt = NavigDpt[0]; cls = NavigCls[0];
     divnm = NavigDivName[0]; dptnm = NavigDptName[0]; clsnm = NavigClsName[0];
  }
  else if(direction == "NXTDPT") // Next Department
  {
     div = NavigDiv[1]; dpt = NavigDpt[1]; cls = "ALL";
     divnm = NavigDivName[1]; dptnm = NavigDptName[1]; clsnm = "All Classes";
  }
  else if(direction == "NXTDIV") // Next Division
  {
     div = NavigDiv[2]; dpt = "ALL";       cls = "ALL";
     divnm = NavigDivName[2]; dptnm = "All Departments"; clsnm = "All Classes";
  }
  else if(direction == "PRVCLS") // previous class
  {
     div = NavigDiv[3]; dpt = NavigDpt[3]; cls = NavigCls[3];
     divnm = NavigDivName[3]; dptnm = NavigDptName[3]; clsnm = NavigClsName[3];
  }
  else if(direction == "PRVDPT") // previous Department
  {
     div = NavigDiv[4]; dpt = NavigDpt[4]; cls = "ALL";
     divnm = NavigDivName[4]; dptnm = NavigDptName[4]; clsnm = "All Classes";
  }
  else if(direction == "PRVDIV") // previous Division
  {
     div = NavigDiv[5]; dpt = "ALL";       cls = "ALL";
     divnm = NavigDivName[5]; dptnm = "All Departments"; clsnm = "All Classes";
  }

  submitReport(Store, div, divnm, dpt, dptnm, cls, clsnm, RetVal, CstVal, UntVal, NumMon, document.all.NewWin.checked);

}

//--------------------------------------------------------
// submit report with new selection
//--------------------------------------------------------
function submitReport(str, div, divnm, dpt, dptnm, cls, clsnm, ret, cst, unt, mon, newwin)
{
   var url = "OpenToBuy.jsp"
     + "?DIVISION=" + div
     + "&DIVNAME=" + divnm
     + "&DEPARTMENT=" + dpt
     + "&DPTNAME=" + dptnm
     + "&CLASS=" + cls
     + "&CLSNAME=" + clsnm
     + "&STORE=" + str
     + "&NumMon=" + mon
     + "&RetVal=" + ret
     + "&CstVal=" + cst
     + "&UntVal=" + unt
     + "&Type=" + PlanType
     + "&Nav=Y"


   //alert(url);
   if (newwin)
   {
     var WindowName = 'OpenToBuy' + New++;
     var WindowOptions =
     'resizable=yes , toolbar=yes, location=yes, directories=yes, status=yes, scrollbars=yes,menubar=yes';
      window.open(url, WindowName, WindowOptions);
   }
   else window.location.href=url;
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvPO.innerHTML = " ";
   document.all.dvPO.style.visibility = "hidden";
}

//---------------------------------------------------------
// populate Div, dpt, class list
//---------------------------------------------------------
function popDivDptCls(mode, div, divNames, dpt, dptNames, dep_div, cls, clsNames, str, strNames)
{
    window.frame1.location = null;
    strLst = str;
    strName = strNames;
    divLst = div;
    divName = divNames;
    dptLst = dpt;
    dptName = dptNames;
    dptGrpLst = dep_div;
    clsLst= cls;
    clsName = clsNames;

    // load div/dpt
    if(mode==1)
    {
       doDivSelect(null);
       document.all.DivSel.style.visibility="visible";
       document.all.DptSel.style.visibility="visible";
       document.all.ClsSel.style.visibility="hidden";
    }
    // load classes
    else
    {
       doClsSelect(null);
       document.all.DivSel.style.visibility="hidden";
       document.all.DptSel.style.visibility="hidden";
       document.all.ClsSel.style.visibility="visible";
    }

    // load stores
    doStrSelect(null);
    document.all.StrSel.style.visibility="visible";
    document.all.DIVISION.readOnly=true;
    document.all.DEPARTMENT.readOnly=true;
}

//==============================================================================
// popilate division selection
//==============================================================================
function doDivSelect(id) {
    var df = document.all;
    var allowed;

    if (id == null || id == 0)
    {
        //  populate the division list
        for (var i = 0; i < divLst.length; i++)
            df.DivSel.options[i] = new Option(divName[i],divLst[i]);
        id = 0;
    }
    else
    {
      df.DIVISION.value = df.DivSel.options[df.DivSel.selectedIndex].value
      df.DEPARTMENT.value = "ALL";
    }

    allowed = dptGrpLst[id].split(":");

    //  clear current depts
    for (var i = df.DptSel.length; i >= 0; i--) df.DptSel.options[i] = null;

    //  if all are to be displayed
    if (allowed[0] == "all")
    {
       for (var i = 0; i < dptLst.length; i++)
       {
         df.DptSel.options[i] = new Option(dptName[i],dptLst[i]);
       }
    }
    //  else display the desired depts
    else
    {
       for (var i = 0; i < allowed.length; i++)
                df.DptSel.options[i] = new Option(dptName[allowed[i]],
                                                        dptLst[allowed[i]]);
    }
}
//==============================================================================
// populate class selection
//==============================================================================
function doClsSelect(id) {
  var df = document.all;
  if(id==null)
  {
     //  clear current classes
     for (var i = df.ClsSel.length; i >= 0; i--)  df.ClsSel.options[i] = null;

     //  populate the class list
     for (var i = 0; i < clsLst.length; i++)  { df.ClsSel.options[i] = new Option(clsName[i], clsLst[i]); }
  }
  else
  {
     document.all.CLASS.value = document.all.ClsSel.options[id].value;
  }
}
//==============================================================================
// Copy selected department to input department field
//==============================================================================
function doDptSel(id)
{
   document.all.DEPARTMENT.value = document.all.DptSel.options[id].value;
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id) {
    var df = document.all;

    if (id==null)
    {
       df.StrSel.options[0] = new Option(strLst[0] + " - " + strName[0],strLst[0]);
       df.StrSel.options[1] = new Option(1 +  " - DISTRIBUTION CENTER", 1);

       for (var i = 1; i < strLst.length; i++)
       {
          df.StrSel.options[i] = new Option(strLst[i] + " - " + strName[i],strLst[i]);
       }
    }
    else
    {
       document.all.STORE.value = document.all.StrSel.options[id].value;
    }
}
//--------------------------------------------------------
// show POs by Vendor
//--------------------------------------------------------
function showPObyVen(mon, val)
{
   ven = PoVen[mon];
   vennm = PoVenName[mon];
   ret = PoVenRet[mon];
   cst = PoVenCst[mon];
   unt = PoVenUnt[mon];
   var skip = 0;

   var totr = 0;
   var totc = 0;
   var totu = 0;

   var dptcls = "Department";
   if (Department != "ALL" && Class == "ALL") dptcls = "Class";
   if (Class != "ALL") dptcls = null;



   var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td colspan='4' class='BoxName' nowrap>Purchase Orders by Vendor</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
      + "<tr>"
        + "<th class='DataTable' colspan='5' nowrap>Selected Month: " + MonName[mon] + "</th>"
      + "</tr>"

      if (dptcls != null)
      {
        html += "<tr>"
          + "<th class='DataTable' colspan='5' nowrap><a href='javascript: showPObyDdc(" + mon + ", " + val + ")'>"
          + "PO's by " + dptcls + "</a>&nbsp;&nbsp;&nbsp;&nbsp;"
          + "<a href='javascript: showVenSum(" + mon + ", " + val + ")'>PO Summary</a></th>"
        + "</tr>"
      }

      html += "<tr>"
        + "<th class='DataTable' nowrap>Vendor</th>"
        + "<th class='DataTable' nowrap>Vendor Name</th>"
        + "<th class='DataTable' nowrap>Retail</th>"
        + "<th class='DataTable' nowrap>Cost</th>"
        + "<th class='DataTable' nowrap>Unit</th>"
      + "</tr>";

   // set vendor detailes
   if(mon == 3)
   {
     skip = eval(mon);
     ven = PoVen[skip];
     vennm = PoVenName[skip];
     ret = PoVenRet[skip];
     cst = PoVenCst[skip];
     unt = PoVenUnt[skip];
     html += "<tr class='DataTable2'><td class='DataTable1' nowrap colspan='5'>Current Month</td></tr>"
   }

   // vendor details
   for(var i=0; i < ven.length; i++)
   {
      html += "<tr class='DataTable1'>"
          + "<td class='DataTable1' nowrap>" + ven[i] + "</td>"
          + "<td class='DataTable1' nowrap>" + vennm[i] + "</td>"
          + "<td class='DataTable' nowrap>" + format(ret[i]) + "</td>"
          + "<td class='DataTable' nowrap>" + format(cst[i]) + "</td>"
          + "<td class='DataTable' nowrap>" + format(unt[i]) + "</td>"
        + "</tr>"

      if(ret[i].trim()!='') { totr += eval(ret[i]); }
      if(cst[i].trim()!='') { totc += eval(cst[i]); }
      if(unt[i].trim()!='') { totu += eval(unt[i]); }
   }

   // 1 month back
   if(mon == 3)
   {
      skip = eval(mon) - 1;
      ven = PoVen[skip];
      vennm = PoVenName[skip];
      ret = PoVenRet[skip];
      cst = PoVenCst[skip];
      unt = PoVenUnt[skip];

      html += "<tr class='DataTable2'><td class='DataTable1' nowrap colspan='5'>1 month back</td></tr>"
      // vendor details
      for(var i=0; i < ven.length; i++)
      {
         html += "<tr class='DataTable1'>"
          + "<td class='DataTable1' nowrap>" + ven[i] + "</td>"
          + "<td class='DataTable1' nowrap>" + vennm[i] + "</td>"
          + "<td class='DataTable' nowrap>" + format(ret[i]) + "</td>"
          + "<td class='DataTable' nowrap>" + format(cst[i]) + "</td>"
          + "<td class='DataTable' nowrap>" + format(unt[i]) + "</td>"
          + "</tr>"

          if(ret[i].trim()!='') { totr += eval(ret[i]); }
          if(cst[i].trim()!='') { totc += eval(cst[i]); }
          if(unt[i].trim()!='') { totu += eval(unt[i]); }
      }
   }

   // 2 month back
   if(mon == 3)
   {
      skip = eval(mon) - 2;
      ven = PoVen[skip];
      vennm = PoVenName[skip];
      ret = PoVenRet[skip];
      cst = PoVenCst[skip];
      unt = PoVenUnt[skip];

      html += "<tr class='DataTable2'><td class='DataTable1' nowrap colspan='5'>2 months back</td></tr>"
      // vendor details
      for(var i=0; i < ven.length; i++)
      {
         html += "<tr class='DataTable1'>"
          + "<td class='DataTable1' nowrap>" + ven[i] + "</td>"
          + "<td class='DataTable1' nowrap>" + vennm[i] + "</td>"
          + "<td class='DataTable' nowrap>" + format(ret[i]) + "</td>"
          + "<td class='DataTable' nowrap>" + format(cst[i]) + "</td>"
          + "<td class='DataTable' nowrap>" + format(unt[i]) + "</td>"
          + "</tr>"

          if(ret[i].trim()!='') { totr += eval(ret[i]); }
          if(cst[i].trim()!='') { totc += eval(cst[i]); }
          if(unt[i].trim()!='') { totu += eval(unt[i]); }
      }
   }

   // 3 month back
   if(mon == 3)
   {
      skip = eval(mon) - 3;
      ven = PoVen[skip];
      vennm = PoVenName[skip];
      ret = PoVenRet[skip];
      cst = PoVenCst[skip];
      unt = PoVenUnt[skip];

      html += "<tr class='DataTable2'><td class='DataTable1' nowrap colspan='5'>3 months and earlier</td></tr>"
      // vendor details
      for(var i=0; i < ven.length; i++)
      {
         html += "<tr class='DataTable1'>"
          + "<td class='DataTable1' nowrap>" + ven[i] + "</td>"
          + "<td class='DataTable1' nowrap>" + vennm[i] + "</td>"
          + "<td class='DataTable' nowrap>" + format(ret[i]) + "</td>"
          + "<td class='DataTable' nowrap>" + format(cst[i]) + "</td>"
          + "<td class='DataTable' nowrap>" + format(unt[i]) + "</td>"
          + "</tr>"

          if(ret[i].trim()!='') { totr += eval(ret[i]); }
          if(cst[i].trim()!='') { totc += eval(cst[i]); }
          if(unt[i].trim()!='') { totu += eval(unt[i]); }
      }
   }

   //vendor totals
   html += "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap colspan='2'>Total</td>"
          + "<td class='DataTable' nowrap>" + format(totr) + "</td>"
          + "<td class='DataTable' nowrap>" + format(totc) + "</td>"
          + "<td class='DataTable' nowrap>" + format(totu) + "</td>"
        + "</tr>"

   html += "</table>"
   
	   if(isIE && ua.indexOf("MSIE 7.0") >= 0)
	   {
		   document.all.dvPO.style.width = "250";
	   }
	   else 
	   {
		   document.all.dvPO.style.width = "auto";
	   }

   document.all.dvPO.innerHTML = html;
   document.all.dvPO.style.pixelLeft= 200;
   document.all.dvPO.style.pixelTop= 200;
   document.all.dvPO.style.visibility = "visible";
}

//--------------------------------------------------------
// show POs by Vendor summary
//--------------------------------------------------------
function showVenSum(mon, val)
{
   ven = SumPoVen;
   vennm = SumPoVenName;
   ret = SumPoVenRet;
   cst = SumPoVenCst;
   unt = SumPoVenUnt;
   var skip = 0;

   var totr = 0;
   var totc = 0;
   var totu = 0;

   var dptcls = "Department";
   if (Department != "ALL" && Class == "ALL") dptcls = "Class";
   if (Class != "ALL") dptcls = null;

   var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td colspan='4' class='BoxName' nowrap>Purchase Orders by Vendor</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
      + "<tr>"
        + "<th class='DataTable' colspan='5' nowrap>Selected Month: " + MonName[mon] + "</th>"
      + "</tr>"
      if (dptcls != null)
      {
        html += "<tr>"
          + "<th class='DataTable' colspan='5' nowrap><a href='javascript: showPObyDdc(" + mon + ", " + val + ")'>"
          + "PO's by " + dptcls + "</a>&nbsp;&nbsp;&nbsp;&nbsp;"
          + "<a href='javascript: showPObyVen(" + mon + ", " + val + ")'>PO Details</a></th>"
        + "</tr>"
      }

      html += "<tr>"
        + "<th class='DataTable' nowrap>Vendor</th>"
        + "<th class='DataTable' nowrap>Vendor Name</th>"
        + "<th class='DataTable' nowrap>Retail</th>"
        + "<th class='DataTable' nowrap>Cost</th>"
        + "<th class='DataTable' nowrap>Unit</th>"
      + "</tr>";

   // vendor details
   for(var i=0; i < NumOfVenSum; i++)
   {
      html += "<tr class='DataTable1'>"
          + "<td class='DataTable1' nowrap>" + ven[i] + "</td>"
          + "<td class='DataTable1' nowrap>" + vennm[i] + "</td>"
          + "<td class='DataTable' nowrap>" + format(ret[i]) + "</td>"
          + "<td class='DataTable' nowrap>" + format(cst[i]) + "</td>"
          + "<td class='DataTable' nowrap>" + format(unt[i]) + "</td>"
        + "</tr>"

      if(ret[i].trim()!='') { totr += eval(ret[i]); }
      if(cst[i].trim()!='') { totc += eval(cst[i]); }
      if(unt[i].trim()!='') { totu += eval(unt[i]); }
   }

   //vendor totals
   html += "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap colspan='2'>Total</td>"
          + "<td class='DataTable' nowrap>" + format(totr) + "</td>"
          + "<td class='DataTable' nowrap>" + format(totc) + "</td>"
          + "<td class='DataTable' nowrap>" + format(totu) + "</td>"
        + "</tr>"

   html += "</table>"

   document.all.dvPO.innerHTML = html;
   document.all.dvPO.style.pixelLeft= 200;
   document.all.dvPO.style.pixelTop= 200;
   document.all.dvPO.style.visibility = "visible";

}

//--------------------------------------------------------
// show POs by Div/Dpt/Cls
//--------------------------------------------------------
function showPObyDdc(mon, val)
{
   var code= PoDdc[mon];
   var codenm = PoDdcName[mon];
   var ret = PoDdcRet[mon];
   var cst = PoDdcCst[mon];
   var unt = PoDdcUnt[mon];
   var skip = 0;

   var totr = 0;
   var totc = 0;
   var totu = 0;

   var dptcls = "Department";
   if (Department != "ALL" && Class == "ALL") dptcls = "Class";

   var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td colspan='4' class='BoxName' nowrap>Purchase Orders by " + dptcls + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
      + "<tr>"
        + "<th class='DataTable' colspan='5' nowrap>Selected Month: " + MonName[mon] +  "</th>"
      + "</tr>"
      + "<tr>"
        + "<th class='DataTable' colspan='5' nowrap><a href='javascript: showPObyVen(" + mon + ", " + val + ")'>PO's by Vendor</a>&nbsp;&nbsp;&nbsp;"
        + "<a href='javascript: showDdcSum(" + mon + ", " + val + ")'>PO Summary</a></th>"
      + "</tr>"

      + "<tr>"
        + "<th class='DataTable' nowrap>" + dptcls + "</th>"
        + "<th class='DataTable' nowrap>" + dptcls + " Name</th>"
        + "<th class='DataTable' nowrap>Retail</th>"
        + "<th class='DataTable' nowrap>Cost</th>"
        + "<th class='DataTable' nowrap>Unit</th>"
      + "</tr>";


   // Dpt/class details
   if(mon == 3)
   {
     skip = eval(mon);
     code = PoDdc[skip];
     codenm = PoDdcName[skip];
     ret = PoDdcRet[skip];
     cst = PoDdcCst[skip];
     unt = PoDdcUnt[skip];
     html += "<tr class='DataTable2'><td class='DataTable1' nowrap colspan='5'>Current Month</td></tr>"
   }

   for(var i=0; i < code.length; i++)
   {
      html += "<tr class='DataTable1'>"
          + "<td class='DataTable1' nowrap>" + code[i] + "</td>"
          + "<td class='DataTable1' nowrap>" + codenm[i] + "</td>"
          + "<td class='DataTable' nowrap>" + format(ret[i]) + "</td>"
          + "<td class='DataTable' nowrap>" + format(cst[i]) + "</td>"
          + "<td class='DataTable' nowrap>" + format(unt[i]) + "</td>"
        + "</tr>"

      if(ret[i].trim()!='') { totr += eval(ret[i]); }
      if(cst[i].trim()!='') { totc += eval(cst[i]); }
      if(unt[i].trim()!='') { totu += eval(unt[i]); }
   }

   // Dpt/class details 1 Month Back
   if(mon == 3)
   {
     skip = eval(mon) - 1;
     code = PoDdc[skip];
     codenm = PoDdcName[skip];
     ret = PoDdcRet[skip];
     cst = PoDdcCst[skip];
     unt = PoDdcUnt[skip];
     html += "<tr class='DataTable2'><td class='DataTable1' nowrap colspan='5'>1 month back</td></tr>"

     for(var i=0; i < code.length; i++)
     {
        html += "<tr class='DataTable1'>"
            + "<td class='DataTable1' nowrap>" + code[i] + "</td>"
            + "<td class='DataTable1' nowrap>" + codenm[i] + "</td>"
            + "<td class='DataTable' nowrap>" + format(ret[i]) + "</td>"
            + "<td class='DataTable' nowrap>" + format(cst[i]) + "</td>"
            + "<td class='DataTable' nowrap>" + format(unt[i]) + "</td>"
          + "</tr>"

        if(ret[i].trim()!='') { totr += eval(ret[i]); }
        if(cst[i].trim()!='') { totc += eval(cst[i]); }
        if(unt[i].trim()!='') { totu += eval(unt[i]); }
     }
   }

   // Dpt/class details 2 Month Back
   if(mon == 3)
   {
     skip = eval(mon) - 2;
     code = PoDdc[skip];
     codenm = PoDdcName[skip];
     ret = PoDdcRet[skip];
     cst = PoDdcCst[skip];
     unt = PoDdcUnt[skip];
     html += "<tr class='DataTable2'><td class='DataTable1' nowrap colspan='5'>2 months back</td></tr>"

     for(var i=0; i < code.length; i++)
     {
        html += "<tr class='DataTable1'>"
            + "<td class='DataTable1' nowrap>" + code[i] + "</td>"
            + "<td class='DataTable1' nowrap>" + codenm[i] + "</td>"
            + "<td class='DataTable' nowrap>" + format(ret[i]) + "</td>"
            + "<td class='DataTable' nowrap>" + format(cst[i]) + "</td>"
            + "<td class='DataTable' nowrap>" + format(unt[i]) + "</td>"
          + "</tr>"

        if(ret[i].trim()!='') { totr += eval(ret[i]); }
        if(cst[i].trim()!='') { totc += eval(cst[i]); }
        if(unt[i].trim()!='') { totu += eval(unt[i]); }
     }
   }

   // Dpt/class details 3 Month Back and earlier
   if(mon == 3)
   {
     skip = eval(mon) - 3;
     code = PoDdc[skip];
     codenm = PoDdcName[skip];
     ret = PoDdcRet[skip];
     cst = PoDdcCst[skip];
     unt = PoDdcUnt[skip];
     html += "<tr class='DataTable2'><td class='DataTable1' nowrap colspan='5'>3 months back and earlier</td></tr>"

     for(var i=0; i < code.length; i++)
     {
        html += "<tr class='DataTable1'>"
            + "<td class='DataTable1' nowrap>" + code[i] + "</td>"
            + "<td class='DataTable1' nowrap>" + codenm[i] + "</td>"
            + "<td class='DataTable' nowrap>" + format(ret[i]) + "</td>"
            + "<td class='DataTable' nowrap>" + format(cst[i]) + "</td>"
            + "<td class='DataTable' nowrap>" + format(unt[i]) + "</td>"
          + "</tr>"

        if(ret[i].trim()!='') { totr += eval(ret[i]); }
        if(cst[i].trim()!='') { totc += eval(cst[i]); }
        if(unt[i].trim()!='') { totu += eval(unt[i]); }
     }
   }


   //Dpt/calss totals
   html += "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap colspan='2'>Total</td>"
          + "<td class='DataTable' nowrap>" + format(totr) + "</td>"
          + "<td class='DataTable' nowrap>" + format(totc) + "</td>"
          + "<td class='DataTable' nowrap>" + format(totu) + "</td>"
        + "</tr>"

   html += "</table>"

   document.all.dvPO.innerHTML = html;
   document.all.dvPO.style.pixelLeft= 250;
   document.all.dvPO.style.pixelTop= 200;
   document.all.dvPO.style.visibility = "visible";
}
//--------------------------------------------------------
// show POs by Div/Dpt/Cls summary
//--------------------------------------------------------
function showDdcSum(mon, val)
{
   code = SumPoDdc;
   codenm = SumPoDdcName;
   ret = SumPoDdcRet;
   cst = SumPoDdcCst;
   unt = SumPoDdcUnt;
   var skip = 0;

   var totr = 0;
   var totc = 0;
   var totu = 0;

   var dptcls = "Department";
   if (Department != "ALL" && Class == "ALL") dptcls = "Class";
   if (Class != "ALL") dptcls = null;

   var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td colspan='4' class='BoxName' nowrap>Purchase Orders by Departments</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
      + "<tr>"
        + "<th class='DataTable' colspan='5' nowrap>Selected Month: " + MonName[mon] + "</th>"
      + "</tr>"
      if (dptcls != null)
      {
        html += "<tr>"
          + "<th class='DataTable' colspan='5' nowrap><a href='javascript: showPObyVen(" + mon + ", " + val + ")'>"
          + "PO's by Vendor</a>&nbsp;&nbsp;&nbsp;&nbsp;"
          + "<a href='javascript: showPObyDdc(" + mon + ", " + val + ")'>PO Details</a></th>"
        + "</tr>"
      }

      html += "<tr>"
        + "<th class='DataTable' nowrap>" + dptcls + "</th>"
        + "<th class='DataTable' nowrap>" + dptcls + " Name</th>"
        + "<th class='DataTable' nowrap>Retail</th>"
        + "<th class='DataTable' nowrap>Cost</th>"
        + "<th class='DataTable' nowrap>Unit</th>"
      + "</tr>";

   // vendor details
   for(var i=0; i < NumOfDdcSum; i++)
   {
      html += "<tr class='DataTable1'>"
          + "<td class='DataTable1' nowrap>" + code[i] + "</td>"
          + "<td class='DataTable1' nowrap>" + codenm[i] + "</td>"
          + "<td class='DataTable' nowrap>" + format(ret[i]) + "</td>"
          + "<td class='DataTable' nowrap>" + format(cst[i]) + "</td>"
          + "<td class='DataTable' nowrap>" + format(unt[i]) + "</td>"
        + "</tr>"

      if(ret[i].trim()!='') { totr += eval(ret[i]); }
      if(cst[i].trim()!='') { totc += eval(cst[i]); }
      if(unt[i].trim()!='') { totu += eval(unt[i]); }
   }

   //vendor totals
   html += "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap colspan='2'>Total</td>"
          + "<td class='DataTable' nowrap>" + format(totr) + "</td>"
          + "<td class='DataTable' nowrap>" + format(totc) + "</td>"
          + "<td class='DataTable' nowrap>" + format(totu) + "</td>"
        + "</tr>"

   html += "</table>"

   document.all.dvPO.innerHTML = html;
   document.all.dvPO.style.pixelLeft= 200;
   document.all.dvPO.style.pixelTop= 200;
   document.all.dvPO.style.visibility = "visible";

}

</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="FormatNumerics.js"></script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>


</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
  <div id="Prompt" class="Prompt"></div>
  <div id="dvPO" class="dvPO"></div>
<!-------------------------------------------------------------------->

    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
        <b>Retail Concepts, Inc
        <br>OTB Calculation (Plan B)</b>
      </td>
     </tr>

     <tr>
      <td ALIGN="Center" VALIGN="TOP" colspan=3>

      <b>&nbsp;&nbsp;Store: <%=sStore%>
         &nbsp;&nbsp; Division:

         <%if(sMult.equals("Y")){%>
             <%String sComa =""; %>
             <%for(int i=0; i < sMultDiv.length; i++){%>
                <%=sComa + sMultDiv[i]%>
                <%sComa = ", "; %>
             <%}%>
         <%}
         else if(sNav.equals("Y")){%><%=sDivision%> - <%}%>

         <%if(!sMult.equals("Y")){%><%=sDivName%><%}%>


         <br>

         Department: <%if(sNav.equals("Y")){%><%=sDepartment%> - <%}%><%=sDptName%><br>
         &nbsp;&nbsp; Class: <%if(sNav.equals("Y")){%><%=sClass%> - <%}%><%=sClsName%><br>
         Plan: <%=sType%></b><br>

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="OpenToBuySel.jsp?mode=1">
            <font color="red" size="-1">Open to Buy Selection</font></a>&#62;
          <font size="-1">This Page.</font>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
	  <th class="DataTable">Month</th>
          <th class="DataTable">R<br>C<br>U</th>
          <th class="DataTable">Net<br>Sales<br>Plan</th>
          <th class="DataTable">Less<br>Period<br>Passed</th>
          <th class="DataTable">Actual<br>Sales<br>MTD</th>
          <th class="DataTable">Net<br>Markdown<br>Plan</th>
          <th class="DataTable">Less<br>Period<br>Passed</th>
          <th class="DataTable">Net<br>Inventory<br>Plan</th>
          <th class="DataTable">Required<br>For<br>Plan</th>
          <th class="DataTable">Current<br>Beginning<br>Inventory</th>
          <th class="DataTable">Open<br>To<br>Receive</th>
          <th class="DataTable">Open<br>Purchase<br>Orders</th>
          <th class="DataTable">Open<br>To<br>Buy</th>
          <th class="DataTable">OTB<br>Carry<br>Forward</th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfMon; i++) {%>

             <%for(int j=0; j < iNumOfVal; j++) {%>
                <tr class="<%=sCSSCls%>">
                   <%if(j==0) {%>
                     <td class="DataTable" rowspan="<%=iNumOfVal%>"><%=sMonName[i+3]%></td>
                   <%}%>
                   <td class="DataTable"><%=sValue[j]%></td>
                   <td class="DataTable"><%=sPlanRet[j][i]%></td>
                   <td class="DataTable"><%if(i==0) {%><%=sPlanSlsLpRet[j]%><%} else {%>&nbsp;<%}%></td>
                   <td class="DataTable"><%if(i==0) {%><%=sActSlsMtd[j]%><%} else {%>&nbsp;<%}%></td>
                   <td class="DataTable"><%=sPlanMkd[j][i]%></td>
                   <td class="DataTable"><%if(i==0) {%><%=sPlanMkdLp[j]%><%} else {%>&nbsp;<%}%></td>
                   <td class="DataTable"><%=sPlanInv[j][i]%></td>
                   <td class="DataTable"><%=sPlanReqForPln[j][i]%></td>
                   <td class="DataTable"><%=sCurBegInv[j][i]%></td>
                   <td class="DataTable"><%=sOpenToRcv[j][i]%></td>
                   <td class="DataTable3" id="OPO<%=j%>V<%=i%>" onClick="showPObyVen(<%=i+3%>, <%=j%>)"><%=sOpenPO[j][i]%></td>
                   <td class="DataTable"><%=sOpenToBuy[j][i]%></td>
                   <td class="DataTable"><%=sOpenCarryFwd[j][i]%></td>
                </tr>
             <%}%>

             <% // change line color
               if (sCSSCls.equals("DataTable")) sCSSCls = "DataTable1";
               else sCSSCls = "DataTable";
            %>
           <%}%>
<!------------------- Company Total -------------------------------->
      <!------------------- Report Total -------------------------------->
           <%for(int i=0; i < iNumOfVal; i++) {%>
              <tr class="DataTable2">
                <td class="DataTable1" nowrap>Total</td>
                <td class="DataTable"><%=sValue[i]%></td>
                <td class="DataTable"><%=sTotPlanRet[i]%></td>
                <td class="DataTable"><%=sTotPlanSlsLpRet[i]%></td>
                <td class="DataTable">&nbsp;</td>
                <td class="DataTable"><%=sTotPlanMkd[i]%></td>
                <td class="DataTable"><%=sTotPlanMkdLp[i]%></td>
                <td class="DataTable">&nbsp;</td>
                <td class="DataTable"><%=sTotReqForPlan[i]%></td>
                <td class="DataTable">&nbsp;</td>
                <td class="DataTable"><%=sTotOpenToRcv[i]%></td>
                <td class="DataTable"><%=sTotOpenPO[i]%></td>
                <td class="DataTable"><%=sTotOpenToBuy[i]%></td>

                <td class="DataTable">&nbsp;</td>
              </tr>
           <%}%>
      </table>
      <!----------------------- end of table ------------------------>
  </table>
  <span><sup>*</sup> - Actual markdowns exceed planned markdowns</span>
 </body>
</html>
