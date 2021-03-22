<%@ page import="payrollreports.PrMonBudgAllStr,  payrollreports.SetWeeks, java.util.*, java.text.*"%>
<%
   String sMonth = request.getParameter("MONBEG");
   String sWeekEnd = request.getParameter("WEEKEND");
   String sSort = request.getParameter("SORT");
   String sGroup = request.getParameter("GROUP");
   String sUpToCurr = request.getParameter("UPTOCURR");
   String sWkDate = null;
   String sExclude70 = request.getParameter("Exclude70");

   SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
   Calendar cal = Calendar.getInstance();
   cal.set(Integer.parseInt(sWeekEnd.substring(6, 10)),
           Integer.parseInt(sWeekEnd.substring(0, 2)) - 1,
           Integer.parseInt(sWeekEnd.substring(3, 5)));
   cal.add(Calendar.DATE, -6);
   Date date = cal.getTime();
   sWkDate = df.format(date);

   if (sSort==null) { sSort = "STR";}
   if (sGroup==null) { sGroup = "ALL";}
   if(sUpToCurr==null){sUpToCurr="N";}
   if(sExclude70 == null){sExclude70 = "Y";}

  //-------------- Security ---------------------
  String sStrAllowed = null;
  String sAccess = null;
  String sUser = " ";
  String sAppl = "PAYROLL";
  if   (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
    && !session.getAttribute("APPLICATION").equals(sAppl))
  {
     response.sendRedirect("SignOn1.jsp?TARGET=PrMonBudgAllStr.jsp&APPL=" + sAppl + "&" + request.getQueryString());
  }
   else {
     sAccess = session.getAttribute("ACCESS").toString();
     sStrAllowed = session.getAttribute("STORE").toString();
     sUser = session.getAttribute("USER").toString();

     if (sAccess != null && !sAccess.equals("1") &&
         sStrAllowed.startsWith("ALL"))
     {
       response.sendRedirect("StrScheduling.html");
     }
   }
  // -------------- End Security -----------------
  PrMonBudgAllStr setbud = null;
  int iNumOfStr = 0;

   String []  sStore = null;
   String []  sStoreName = null;
   int iNumOfReg = 0;
   String [] sReg = null;
   String [] sRegs = null;
   int [] iReg = null;

   String [][] sStrTot = null;
   String [] [] sRegTot = null;
   String [] sRepTot = null;

   String sSlrEmp = null;
   String sSlrHrs = null;
   String sSlrPay = null;

   String [] sApprvSts = null;
   String [] sNewReq = null;
   String [] sNewRsp = null;
   String [] sNewTot = null;

   String sActual= null;

   String sInclReg = "1";
   if(sGroup.equals("STR")) {sInclReg = "0";}


   setbud = new PrMonBudgAllStr(sWeekEnd, sSort, sInclReg, sUpToCurr, sExclude70, sUser);
   iNumOfStr = setbud.getNumOfStr();
   sStore = setbud.getStores();
   sStoreName = setbud.getStoreNames();
   iNumOfReg = setbud.getNumOfReg();
   sReg = setbud.getRegion();
   sRegs = setbud.getRegions();
   iReg = setbud.getRegStrQty();

   sStrTot = setbud.getStrTot();
   sRegTot = setbud.getRegTot();
   sRepTot = setbud.getRepTot();

   sSlrEmp = setbud.getSlrEmpJsa();
   sSlrHrs = setbud.getSlrHrsJsa();
   sSlrPay = setbud.getSlrPayJsa();

   sApprvSts = setbud.getApproveStatus();
   sNewReq = setbud.getNewReq();
   sNewRsp = setbud.getNewRsp();
   sNewTot = setbud.getNewTot();

   sActual = setbud.getActual();

   int iNumOfStrSG = setbud.getNumOfStrSG();
   int iNumOfRegSg = setbud.getNumOfRegSG();
   String [] sSGReg = setbud.getSGReg();
   String [][] sSGStr = setbud.getSGStr();
   String [] sSGStrNm = setbud.getSGStrNm();
   String [][] sSGProd = setbud.getSGProd();
   String [][] sSGHrs = setbud.getSGHrs();
   String [][] sSGHiLo = setbud.getSGHiLo();
   String [] sSGBdg = setbud.getSGBdg();
   String [] sSGVar = setbud.getSGVar();
   String [] sSGBdgSP = setbud.getSGBdgSP();
   String [] sSGGoal = setbud.getSGGoal();
   String [] sSGVarHrs = setbud.getSGVarHrs();

   String [][] sTotSGProd = setbud.getTotSGProd();
   String [][] sTotSGHrs = setbud.getTotSGHrs();
   String [][] sTotSGHiLo = setbud.getTotSGHiLo();
   String [] sTotSGBdg = setbud.getTotSGBdg();
   String [] sTotSGVar = setbud.getTotSGVar();
   String [] sTotSGBdgSP = setbud.getTotSGBdgSP();
   String [] sTotSGGoal = setbud.getTotSGGoal();
   String [] sTotSGVarHrs = setbud.getTotSGVarHrs();

   String sSGRegJsa = setbud.getSGRegJsa();
   String sSGStrJsa = setbud.getSGStrJsa();
   String sSGStrNmJsa = setbud.getSGStrNmJsa();
   String sSGProdJsa = setbud.getSGProdJsa();
   String sSGHrsJsa = setbud.getSGHrsJsa();
   String sSGHiLoJsa = setbud.getSGHiLoJsa();
   String sSGBdgJsa = setbud.getSGBdgJsa();
   String sSGVarJsa = setbud.getSGVarJsa();
   String sSGBdgSPJsa = setbud.getSGBdgSPJsa();
   String sSGGoalJsa = setbud.getSGGoalJsa();
   String sSGVarHrsJsa = setbud.getSGVarHrsJsa();

   String sTotSGProdJsa = setbud.getTotSGProdJsa();
   String sTotSGHrsJsa = setbud.getTotSGHrsJsa();
   String sTotSGHiLoJsa = setbud.getTotSGHiLoJsa();
   String sTotSGBdgJsa = setbud.getTotSGBdgJsa();
   String sTotSGVarJsa = setbud.getTotSGVarJsa();
   String sTotSGBdgSPJsa = setbud.getTotSGBdgSPJsa();
   String sTotSGGoalJsa = setbud.getTotSGGoalJsa();
   String sTotSGVarHrsJsa = setbud.getTotSGVarHrsJsa();

   // scores
   String [][] sStrScore = setbud.getStrScore();
   String [] sStrIdealArg = setbud.getStrIdealArg();
   String [][] sRegScore = setbud.getRegScore();
   String [] sRegIdealArg = setbud.getRegIdealArg();

   // Scores jsa
   String sStrProdJsa = setbud.getStrProdJsa();
   String sStrPrcToCompJsa = setbud.getStrPrcToCompJsa();
   String sStrScoreJsa = setbud.getStrScoreJsa();
   String sStrIdealArgJsa = setbud.getStrIdealArgJsa();

   String sRegProdJsa = setbud.getRegProdJsa();
   String sRegPrcToCompJsa = setbud.getRegPrcToCompJsa();
   String sRegScoreJsa = setbud.getRegScoreJsa();
   String sRegIdealArgJsa = setbud.getRegIdealArgJsa();

   String sCompProdJsa = setbud.getCompProdJsa();
   String sCompScoreJsa = setbud.getCompScoreJsa();
   String sCompIdealArg = setbud.getCompIdealArg();

   setbud.disconnect();

   // get 11 weeks
   SetWeeks SetWk = new SetWeeks("11WK");
   int iNumOfWeeks = SetWk.getNumOfWeeks();
   String sWeeksJSA = SetWk.getWeeksJSA();
   String sMonthsJSA = SetWk.getMonthBegJSA();

   String sBaseWkJSA = SetWk.getBaseWkJSA();
   String sBsWkNameJSA = SetWk.getBsWkNameJSA();
   String sBsMonBegJSA = SetWk.getBsMonBegJSA();

   SetWk.disconnect();

   int iPass = 0;
   int iFail = 0;

%>
<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}

        th.DataTable { background:#FFCC99;padding-top:1px; padding-bottom:1px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99;padding-top:1px; padding-bottom:1px; border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:1px; padding-bottom:1px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable3 { background:#FFCC99;padding-top:1px; padding-bottom:1px; border-right: darkred solid 4px;text-align:center; font-family:Verdanda; font-size:1px }
        th.DataTable4 { background:#FFCC99;  writing-mode: tb-rl; filter: flipv fliph; padding-top:3px;
                  border-top: darkred solid 1px; border-bottom: darkred solid 1px; border-left: darkred solid 1px;
                  text-align:center; font-family:Verdanda; font-size:12px }

        td.DataTable { background:#e7e7e7; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
	td.DataTable1 { background:#e7e7e7; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable1H { background:lightblue; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable1L { background:pink; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable2{ background:cornsilk; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable3{ background:cornsilk; border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable3H { background:lightblue; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable3L { background:pink; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable31{ background:cornsilk; border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable4 { background:#e7e7e7; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable5{ background:cornsilk; border-bottom: darkred solid 1px; border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable6 { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:10px }
        td.DataTable7 { background:seashell; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable8 { background:#e7e7e7; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }

        div.dvEmpList { position:absolute; visibility:hidden; background-attachment: scroll;
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

        tr.Score { background: #eeffee; font-size:10px; }
        tr.Score1 { background:#ffcc22; font-size:12px; }
        tr.Score2 { background:cornsilk; font-size:12px; font-weight:bold; text-align:center;}

        td.Score1 { background: #eeeeff; text-align:left; font-size:10px; }
        td.Score2 { text-align:right; font-size:10px; }
        td.Score21 { background: pink; text-align:right; font-size:10px; }
        td.Score22 { background: lightgreen; text-align:right; font-size:10px; }

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        #spAlwBdg { display: none; }

</style>
<SCRIPT language="JavaScript">

 var Weeks = [<%=sWeeksJSA%>];
 var MonthWks = [<%=sMonthsJSA%>];
 var Month = "<%=sMonth%>";
 var WeekEnd = "<%=sWeekEnd%>";

 var Exclude70 = "<%=sExclude70%>"

 var BaseWk = [<%=sBaseWkJSA%>];
 var BsMonBeg = [<%=sBsMonBegJSA%>];
 var BsWkName = [<%=sBsWkNameJSA%>];

 var Sort = "<%=sSort%>";
 var Group = "<%=sGroup%>"

 var RegNum = "<%=iNumOfReg%>"
 var Reg = new Array(RegNum);
<%for(int i=0; i<iNumOfReg; i++){%>
  Reg[<%=i%>] = [<%=sReg[i]%>]
<%}%>

SGReg = [<%=sSGRegJsa%>];
SGStr = [<%=sSGStrJsa%>];
SGStrNm = [<%=sSGStrNmJsa%>];
SGProd = [<%=sSGProdJsa%>];
SGHrs = [<%=sSGHrsJsa%>];
SGHiLo = [<%=sSGHiLoJsa%>];
SGBdg = [<%=sSGBdgJsa%>];
SGVar = [<%=sSGVarJsa%>];
SGBdgSP = [<%=sSGBdgSPJsa%>];
SGGoal = [<%=sSGGoalJsa%>];
SGVarHrs = [<%=sSGVarHrsJsa%>];

TotSGProd = [<%=sTotSGProdJsa%>];
TotSGHrs = [<%=sTotSGHrsJsa%>];
TotSGHiLo = [<%=sTotSGHiLoJsa%>];
TotSGBdg = ["<%=sTotSGBdg%>"];
TotSGVar = ["<%=sTotSGVar%>"];
TotSGVarHrs = ["<%=sTotSGVarHrs%>"];
TotSGBdgSP = ["<%=sTotSGBdgSP%>"];
TotSGGoal = ["<%=sTotSGGoal%>"];

var StrProd = [<%=sStrProdJsa%>];
var StrPrcToComp = [<%=sStrPrcToCompJsa%>];
var StrScore = [<%=sStrScoreJsa%>];
var StrIdealArg = [<%=sStrIdealArgJsa%>];

var RegProd = [<%=sRegProdJsa%>];
var RegPrcToComp = [<%=sRegPrcToCompJsa%>];
var RegScore = [<%=sRegScoreJsa%>];
var RegIdealArg = [<%=sRegIdealArgJsa%>];

var CompProd = [<%=sCompProdJsa%>];
var CompScore =  [<%=sCompScoreJsa%>];
var CompIdealArg = "<%=sCompIdealArg%>";

var SlrEmp = [<%=sSlrEmp%>];
var SlrHrs = [<%=sSlrHrs%>];
var SlrPay = [<%=sSlrPay%>];

var Actual = "<%=sActual%>"
//==============================================================================
// initialize on loading
//==============================================================================
function bodyLoad()
{
   foldCol('PayDlr', '2')
   foldCol('PayPrc', '2')
   foldCol('PayHrs', '2')
   foldCol('PayAvg', '2')

   setBoxclasses(["BoxName",  "BoxClose"], ["dvEmpList"]);
   doWeekSelect();
   doGroupSelect();
   switchOrigAllw();
}

//==============================================================================
// Weeks Stores
//==============================================================================
function doWeekSelect(id) {
    var df = document.forms[0];
    for (idx = 0; idx < Weeks.length; idx++)
    {
         df.WEEK.options[idx] =
            new Option(Weeks[idx], Weeks[idx]);
          if (WeekEnd==Weeks[idx])
          {
             df.WEEK.selectedIndex=idx;
          }
    }

    for (idy=0; idy < BaseWk.length; idy++, idx++)
    {
      df.WEEK.options[idx] =
            new Option(BsWkName[idy], BaseWk[idy]);
            if (WeekEnd==BaseWk[idy])
          {
             df.WEEK.selectedIndex=idx;
          }
    }
}
//==============================================================================
// Weeks Stores
//==============================================================================
function doGroupSelect() {
    var df = document.forms[0];
    df.GROUP.options[0] =  new Option("All Regions ", "ALL");
    if (Group=="ALL"){ df.GROUP.selectedIndex=0;}

    for (idx = 0; idx < Reg.length; idx++)
    {
         df.GROUP.options[idx+1] =  new Option("Region " + Reg[idx], Reg[idx]);
         if (Group==Reg[idx])
          {
             df.GROUP.selectedIndex=idx+1;
          }
    }

    df.GROUP.options[Reg.length + 1] =  new Option("All Stores" , "STR");
    if (Group=="STR"){ df.GROUP.selectedIndex=Reg.length+1;}
    df.GROUP.options[Reg.length + 2] =  new Option("Totals Only" , "TOTAL");
    if (Group=="TOTAL"){ df.GROUP.selectedIndex=Reg.length + 2;}
}

//==============================================================================
// resubmit this page for another week
//==============================================================================
function submitForm()
{
   var idx = document.getStore.WEEK.selectedIndex;
   var selMonth = null;

   // check if base schedule or regular schedule
   if (idx < MonthWks.length)
   {
     selMonth = MonthWks[idx]
   }
   else
   {
     selMonth = BsMonBeg[idx - MonthWks.length];
   }

   var SbmString = "PrMonBudgAllStr.jsp"
         + "?MONBEG=" + selMonth
         + "&WEEKEND="
         + document.getStore.WEEK.options[document.getStore.WEEK.selectedIndex].value
         + "&UPTOCURR=<%=sUpToCurr%>"
         + "&GROUP="
         + document.getStore.GROUP.options[document.getStore.GROUP.selectedIndex].value
         + "&Exclude70=<%=sExclude70%>"

   // alert(SbmString);
    window.location.href=SbmString;
}
//==============================================================================
// show schedule summary with or without 70
//==============================================================================
function inclExcl70()
{
  var url = "PrMonBudgAllStr.jsp"
         + "?MONBEG=" + Month
         + "&WEEKEND=" + WeekEnd
         + "&UPTOCURR=<%=sUpToCurr%>"
         + "&GROUP=<%=sGroup%>";
   if(Exclude70 == "Y")  { url += "&Exclude70=N"; }
   if(Exclude70 == "N")  { url += "&Exclude70=Y"; }

   // alert(SbmString);
    window.location.href=url;

}
//==============================================================================
// show schedule for whole week ot up to prior date
//==============================================================================
function showSchedUptoCurr(upto)
{
  var df = document.forms[0];
  var sbmString = "PrMonBudgAllStr.jsp?MONBEG=" + Month
                + "&WEEKEND=" + WeekEnd
                + "&SORT=<%=sSort%>"
                + "&UPTOCURR=" + upto
                + "&GROUP=<%=sGroup%>"
                + "&Exclude70=<%=sExclude70%>"
  window.location.href=sbmString;
}

//==============================================================================
// resort Sales goal table
//==============================================================================
function resortSGProd(sort)
{
   SortSGProd = sort;

   var html = "<table class='DataTable'  cellPadding='0' cellSpacing=0>"
     + "<tr>"
       + "<th class='DataTable' rowspan=3>Reg</th>"
       + "<th class='DataTable' rowspan=3><a href='javascript: resortSGProd(&#34;STORE&#34;)'>Store</a></th>"
       + "<th class='DataTable1' rowspan=3>&nbsp;</th>"
       + "<th class='DataTable' colspan=23>Sales Goal (85%)<br>&#34;SP&#34; - Productivity, Hrs=Schedule Selling Hrs.</th>"
       + "<th class='DataTable3' rowspan=3>&nbsp;</th>"
       + "<th class='DataTable' colspan=4>Weekly Schedule vs. Budget</th>"
     + "</tr>"
     + "<tr>"
       + "<th class='DataTable' colspan=2>Mon</th>"
       + "<th class='DataTable1' rowspan=2>&nbsp;</th>"
       + "<th class='DataTable' colspan=2>Tue</th>"
       + "<th class='DataTable1' rowspan=2>&nbsp;</th>"
       + "<th class='DataTable' colspan=2>Wed</th>"
       + "<th class='DataTable1' rowspan=2>&nbsp;</th>"
       + "<th class='DataTable' colspan=2>Thu</th>"
       + "<th class='DataTable1' rowspan=2>&nbsp;</th>"
       + "<th class='DataTable' colspan=2>Fri</th>"
       + "<th class='DataTable1' rowspan=2>&nbsp;</th>"
       + "<th class='DataTable' colspan=2>Sat</th>"
       + "<th class='DataTable1' rowspan=2>&nbsp;</th>"
       + "<th class='DataTable' colspan=2>Sun</th>"
       + "<th class='DataTable1' rowspan=2>&nbsp;</th>"
       + "<th class='DataTable' colspan=2>Total</th>"
       + "<th class='DataTable' colspan=2>Budget<br>Hrs</th>"
       + "<th class='DataTable' rowspan=2>Var<br>(Hrs)</th>"
       + "<th class='DataTable' rowspan=2>Var<br>(%)</th>"
      + "</tr>"
      + "<tr>"

      for(i=0; i < 8; i++)
      {
         html += "<th class='DataTable2'><a href='javascript: resortSGProd(&#34;" + i + "&#34;)'>SP</a></th>"
               + "<th class='DataTable2'>Hrs</th>"
      }
      html += "<th class='DataTable2'>SP</th>"
            + "<th class='DataTable2'>Hrs</th>"
   html += "</tr>"

   var sortBy = popSortArr(sort);
   html += rebuildTable(sortBy);

   html += "</table>"

   document.all.dvSGProd.innerHTML = html;
}
//==============================================================================
// populate sorting array
//==============================================================================
function rebuildTable(sortBy)
{
   var html = "";

   for(var i=0, reg=0, str=0; i < SGStrNm.length; i++)
   {
       var arg =  sortBy[i].substring(sortBy[i].indexOf("@") + 1);
       var strnum = sortBy[i].substring(10, 13);
       html += "<tr>";

       if(str==0) { html += "<td class='DataTable8' rowspan=" + SGStr[reg].length + ">" + SGReg[reg] + "</td>" }
       html += "<td class='DataTable8'>" + strnum + " - " + SGStrNm[arg] + "</td>"
       for(var j=0; j < 8; j++)
       {
          html += "<th class='DataTable1'>&nbsp;</th>"
                + "<td class='DataTable1" + SGHiLo[arg][j] + "'>$" + SGProd[arg][j] + "</td>"
                + "<td class='DataTable1'>" + SGHrs[arg][j] + "</td>"
       }

       html += "<th class='DataTable3'>&nbsp;</th>"
             + "<td class='DataTable1'>" + SGBdg[arg] + "</td>"
             + "<td class='DataTable1'>" + SGBdgSP[arg] + "</td>"
             + "<td class='DataTable1'>" + SGVarHrs[arg] + "</td>"
             + "<td class='DataTable1'>" + SGVar[arg] + "%</td>"

       html += "</tr>"
       str++;
       if(str == SGStr[reg].length)
       {
          reg++; str = 0;
          html += "<tr><td style='background:darkred; font-size:1px;' colspan=31>&nbsp;</td></tr>"
       }
   }

   // total line
   html += "<td class='DataTable31' colspan=2>Total</td>"
   for(var j=0; j < 8; j++)
   {
      html += "<th class='DataTable1'>&nbsp;</th>"
             + "<td class='DataTable3" + TotSGHiLo[j] + "'>$" + TotSGProd[SGReg.length][j] + "</td>"
             + "<td class='DataTable3'>" + TotSGHrs[SGReg.length][j] + "</td>"
   }

       html += "<th class='DataTable3'>&nbsp;</th>"
             + "<td class='DataTable3'>" + TotSGBdg[SGReg.length] + "</td>"
             + "<td class='DataTable3'>" + TotSGBdgSP[SGReg.length] + "</td>"
             + "<td class='DataTable3'>" + TotSGVarHrs[SGReg.length] + "</td>"
             + "<td class='DataTable3'>" + TotSGVar[SGReg.length] + "%</td>"

   return html
}
//==============================================================================
// populate sorting array
//==============================================================================
function popSortArr(sort)
{
   var sortby = new Array(SGStrNm.length);
   var elem = "";
   var reg = "";
   var str = "";
   var goal = "";

   for(var i=0, k=0; i < SGReg.length; i++)
   {
      for(var j=0; j < SGStr[i].length; j++)
      {
         reg = setNum(SGReg[i], 3);
         str = setNum(SGStr[i][j], 3);
         if(sort !="STORE") { goal = setNum(SGProd[k][sort], 7);}
         else { goal = "0000000"; }

         sortby[k] = reg + goal + str + "|" + sort + "@" + k;
         k++;
      }
   }

   if (sort !="STORE") { sortby.sort(sortTable); }

   return sortby;
}
//==============================================================================
// populate sorting array
//==============================================================================
function setNum(num, max)
{
   var string = "";
   var len = num.length;
   string = num;
   for(var i=0; i < max; i++)
   {
      if( i < max-len){ string = " " + string; }
      else { break; }
   }
   return string;
}
//==============================================================================
// populate sorting array
//==============================================================================
function sortTable(elm1, elm2)
{
   var sort = elm1.substring(elm1.indexOf("|"), elm1.indexOf("@"));
   var reg1 = eval(elm1.substring(0,3));
   var reg2 = eval(elm2.substring(0,3));
   var goal1 = eval(elm1.substring(3, 10));
   var goal2 = eval(elm2.substring(3, 10));
   var str1 = eval(elm1.substring(10, 13));
   var str2 = eval(elm2.substring(10, 13));

   var diff = 0;

   if(sort != "STORE")
   {
      diff = reg1 - reg2;
      if (diff == 0) { diff = goal2 - goal1;}
   }
   else
   {
      diff = reg1 - reg2;
      if (diff == 0) { diff = str1 - str2; }
   }

   return eval(diff);
}
//==============================================================================
// populate sorting array
//==============================================================================
function showStrSlsProdScore(arg, str)
{

  var hdr = "Sales Productivity Score. Store " + str;

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popStrSlsProdScore(arg)

   html += "</td></tr></table>"

   document.all.dvEmpList.innerHTML = html;
   document.all.dvEmpList.style.width = 250;
   document.all.dvEmpList.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvEmpList.style.pixelTop= document.documentElement.scrollTop + 10;
   document.all.dvEmpList.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Column Panel
//--------------------------------------------------------
function popStrSlsProdScore(arg)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
  panel += "<tr class='Score1'>"
             + "<th nowrap>&nbsp</th>"
             + "<th nowrap>Mon</th>"
             + "<th nowrap>Tue</th>"
             + "<th nowrap>Wed</th>"
             + "<th nowrap>Thu</th>"
             + "<th nowrap>Fri</th>"
             + "<th nowrap>Sat</th>"
             + "<th nowrap>Sun</th>"
             + "<th nowrap>Total</th>"
         + "</tr>"

  panel += "<tr class='Score2'><td colspan=9 nowrap>Company Total</td></tr>"
  panel += "<tr class='Score'><td class='Score1' nowrap>Sales Productivity</td>"

  for(var j=0; j < 7; j++)
  {
    if(CompIdealArg == j){panel += "<td class='Score22' nowrap>$" + CompProd[j] + "</td>" }
    else {panel += "<td class='Score2' nowrap>$" + CompProd[j] + "</td>" }
  }
  panel += "<td class='Score21' nowrap>" + CompProd[7] + "</td>"
  panel +="</tr>"

  panel += "<tr class='Score'><td class='Score1' nowrap>Sales Productivity Ratio</td>"

  for(var j=0; j < 7; j++){ panel += "<td class='Score2' nowrap>" + CompScore[j] + "%</td>"}
  panel +="</tr>"

  //--------------------  Store ------------------
  panel += "<tr class='Score2'><td colspan=9 nowrap>Store</td></tr>"
  panel += "<tr class='Score'><td class='Score1' nowrap>Sales Productivity</td>"
  for(var j=0; j < 7; j++)
  {
      if(StrIdealArg[arg] == j){ panel += "<td class='Score22' nowrap>$" + StrProd[arg][j] + "</td>" }
      else { panel += "<td class='Score2' nowrap>$" + StrProd[arg][j] + "</td>" }
  }
  panel += "<td class='Score21' nowrap>" + StrProd[arg][7] + "</td>"
  panel +="</tr>"

  panel += "<tr class='Score'><td class='Score1' nowrap>Sales Productivity Ratio</td>"
  for(var j=0; j < 7; j++){ panel += "<td class='Score2' nowrap>" + StrPrcToComp[arg][j] + "%</td>" }
  panel +="</tr>"

  panel += "<tr class='Score'><td class='Score1' nowrap>Scores</td>"
  for(var j=0; j < 7; j++){ panel += "<td class='Score2' nowrap>" + StrScore[arg][j] + "</td>" }
  panel += "<td class='Score21' nowrap>" + StrScore[arg][7] + "</td>"
  panel +="</tr>"

  panel += "<tr><td class='Prompt1' colspan=16>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}

//==============================================================================
// populate sorting array
//==============================================================================
function showRegSlsProdScore(arg)
{

  var hdr = "Sales Productivity Score";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popRegSlsProdScore(arg)

   html += "</td></tr></table>"

   document.all.dvEmpList.innerHTML = html;
   document.all.dvEmpList.style.width = 250;
   document.all.dvEmpList.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvEmpList.style.pixelTop= document.documentElement.scrollTop + 10;
   document.all.dvEmpList.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Column Panel
//--------------------------------------------------------
function popRegSlsProdScore(arg)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>";
  panel += "<tr class='Score1'>"
             + "<th nowrap>&nbsp</th>"
             + "<th nowrap>Mon</th>"
             + "<th nowrap>Tue</th>"
             + "<th nowrap>Wed</th>"
             + "<th nowrap>Thu</th>"
             + "<th nowrap>Fri</th>"
             + "<th nowrap>Sat</th>"
             + "<th nowrap>Sun</th>"
             + "<th nowrap>Total</th>"
         + "</tr>"

  panel += "<tr class='Score2'><td colspan=9 nowrap>Company Total</td></tr>"
  panel += "<tr class='Score'><td class='Score1' nowrap>Sales Productivity</td>"
  for(var j=0; j < 7; j++)
  {
      if(CompIdealArg == j){panel += "<td class='Score22' nowrap>$" + CompProd[j] + "</td>" }
      else {panel += "<td class='Score2' nowrap>$" + CompProd[j] + "</td>" }
  }
  panel += "<td class='Score21' nowrap>" + CompProd[7] + "</td>"
  panel +="</tr>"

  panel += "<tr class='Score'><td class='Score1' nowrap>Sales Productivity Ratio</td>"
  for(var j=0; j < 7; j++){ panel += "<td class='Score2' nowrap>" + CompScore[j] + "%</td>" }
  panel +="</tr>"

  //--------------------  Store ------------------
  panel += "<tr class='Score2'><td colspan=9 nowrap>Region Total</td></tr>"
  panel += "<tr class='Score'><td class='Score1' nowrap>Sales Productivity</td>"
  for(var j=0; j < 7; j++)
  {
     if(RegIdealArg[arg] == j){ panel += "<td class='Score22' nowrap>$" + RegProd[arg][j] + "</td>" }
     else { panel += "<td class='Score2' nowrap>$" + RegProd[arg][j] + "</td>" }
  }
  panel += "<td class='Score21' nowrap>" + RegProd[arg][7] + "</td>"
  panel +="</tr>"

  panel += "<tr class='Score'><td class='Score1' nowrap>Sales Productivity Ratio</td>"
  for(var j=0; j < 7; j++){ panel += "<td class='Score2' nowrap>" + RegPrcToComp[arg][j] + "%</td>" }
  panel +="</tr>"

  panel += "<tr class='Score'><td class='Score1' nowrap>Scores</td>"
  for(var j=0; j < 7; j++){ panel += "<td class='Score2' nowrap>" + RegScore[arg][j] + "</td>" }
  panel += "<td class='Score21' nowrap>" + RegScore[arg][7] + "</td>"
  panel +="</tr>"

  panel += "<tr><td class='Prompt1' colspan=16>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvEmpList.innerHTML = " ";
   document.all.dvEmpList.style.visibility = "hidden";
}
//==============================================================================
// fold/unfold columns
//==============================================================================
function foldCol(id, colNum)
{
   var line1 = "th" + id + "Ln1";
   var line2 = "th" + id + "Ln2";
   var line3 = "th" + id + "Ln3";

   var thLn1 = document.all[line1];
   var thLn2 = document.all[line2];
   var thLn3 = document.all[line3];

   // detail columns
   var bdgCol = "td" + id + "Bdg";
   var scdCol = "td" + id + "Scd";
   var actCol = "td" + id + "Act";

   var tdBdg = document.all[bdgCol];
   var tdScd = document.all[scdCol];
   var tdAct = null;

   if (Actual != "0") { tdAct = document.all[actCol]; }

   var colNumLn1 = 0;
   var colNumLn2 = colNum;

   var show = "block";
   if (thLn3[0].style.display != "none") { show = "none"; }

   if (Actual != "0"){ colNumLn1 = colNum * 3; }
   else { colNumLn1 = colNum * 2; }

   if ( show == "none") { colNumLn1 = colNumLn1 * (-1); colNumLn2 = colNumLn2 * (-1);}

   // fold/unfold column headers
   thLn1.colSpan = eval(thLn1.colSpan) + eval(colNumLn1);
   for(var i=0;  i < thLn2.length; i++ ) {  thLn2[i].colSpan = eval(thLn2[i].colSpan) + eval(colNumLn2); }
   for(var i=0;  i < thLn3.length; i++ ) { thLn3[i].style.display = show; }

   // f/u columns
   //alert(bdgCol + "|" +  scdCol + "|" + actCol)
   for(var i=0;  i < tdBdg.length; i++ ) { tdBdg[i].style.display = show; }
   for(var i=0;  i < tdScd.length; i++ ) { tdScd[i].style.display = show; }
   if (Actual != "0") { for(var i=0;  i < tdAct.length; i++ ) { tdAct[i].style.display = show; } }
}

//==============================================================================
// switch beetween Original and allowable budget
//==============================================================================
function switchOrigAllw()
{
   var spOrig = document.all.spOrig;
   var spAlwBdg = document.all.spAlwBdg;
   //var lnkOrig = document.all.lnkOrig;

   var spOrigLnk = document.all.spOrigLnk;
   var spAlwBdgLnk = document.all.spAlwBdgLnk;

   var dispOrig = "none";
   var dispAllw = "block";

   var dispOrigLnk = "none";
   var dispAllwLnk = "inline";

   if (spAlwBdg[0].style.display != "none")
   {
     dispOrig = "block"; dispAllw = "none";
     dispOrigLnk = "inline"; dispAllwLnk = "none";
   }

   for(var i=0; i < spOrig.length; i++)
   {
      spOrig[i].style.display = dispOrig;
      spAlwBdg[i].style.display = dispAllw;
   }

   spOrigLnk.style.display = dispOrigLnk;
   spAlwBdgLnk.style.display = dispAllwLnk;

   //for(var i=0; i < lnkOrig.length; i++) { lnkOrig[i].style.display = dispOrig; }
}

//==============================================================================
// show Actual Average Variances
//==============================================================================
function showActAvgVarAll()
{
   var allowb = "N";
   if (spOrig[0].style.display == "none"){ allowb = "Y"; }
   var url = "PrActAvgVarAllStr.jsp?&From=BEGWEEK&To=<%=sWeekEnd%>&AllwBdg=" + allowb;

   var MyWindowName = "Weekly_Budget";
   var MyWindowOptions =
    "left=20, top=20, width=800,height=600, toolbar=yes, location=yes, directories=yes, status=yes, scrollbars=yes, menubar=yes, scrollbars=1, resizable=yes";

   window.open(url, MyWindowName, MyWindowOptions);
}

//==============================================================================
// show salary hours credit for allowable budget
//==============================================================================
function showSlrEmpCred(group,cred, cell)
{
   if(document.all.spAlwBdgLnk.style.display != "none")
   {
      var credNm = "";
      var credPrefix = "";
      var credSuffix = "";
      if(group=="PAY"){ credNm = "Salary Employee Payroll Dollar Credit: "; credPrefix = "$"; credSuffix = "";}
      else if(group=="PRC"){ credNm = "Salary Employee Payroll Procent Credit: "; credPrefix = ""; credSuffix = "%";}
      else if(group=="HRS"){ credNm = "Salary Employee Hours Credit: "; credPrefix = ""; credSuffix = "";}
      else if(group=="AVG"){ credNm = "Salary Employee Hours Credit: "; credPrefix = "$"; credSuffix = "";}

      var pos = getObjPosition(cell);

      document.all.dvSlrCred.innerHTML = credNm + credPrefix + cred + credSuffix;
      document.all.dvSlrCred.style.display="inline";
      document.all.dvSlrCred.style.pixelLeft= pos[0] + 40;
      document.all.dvSlrCred.style.pixelTop= pos[1] - 1;
      document.all.dvSlrCred.style.visibility = "visible";
   }
}

//==============================================================================
// show salary hours credit for allowable budget (list of employee)
//==============================================================================
function showSlrEmpLstCred(arg, str, tothrs, totpay, orgBdgHrs, orgBdgPay, allwBdgHrs, allwBdgPay, cell)
{
   if(document.all.spAlwBdgLnk.style.display != "none")
   {
      var html = popSlrEmpLstCred(arg, str, tothrs, totpay, orgBdgHrs, orgBdgPay, allwBdgHrs, allwBdgPay);
      var pos = getObjPosition(cell);

      document.all.dvSlrCred.innerHTML = html;
      document.all.dvSlrCred.style.display="inline";
      document.all.dvSlrCred.style.pixelLeft= pos[0] + 40;
      document.all.dvSlrCred.style.pixelTop= pos[1] - 1;
      document.all.dvSlrCred.style.visibility = "visible";
   }
}
//==============================================================================
// populate table with salary hours credit for allowable budget (list of employee)
//==============================================================================
function popSlrEmpLstCred(arg, str, tothrs, totpay, orgBdgHrs, orgBdgPay, allwBdgHrs, allwBdgPay)
{
   var html = "<table border=1 style='font-size:10px; width: 100%;'>"
    + "<tr><th colspan=3>Store: " + str + "&nbsp;V/H/TMC Adjustment<br>Salaried Only</th></tr>"
    + "<tr><th>Employee</th><th>Hours</th><th>Payroll</th></tr>";

    // original budget total
    html += "<tr>"
              + "<th align=left>Original Budget</th>"
              + "<td align=right>" + orgBdgHrs + "</td>"
              + "<td align=right>$" + orgBdgPay + "</td>"
           + "</tr>"

   for(var i=0; i < SlrEmp[arg].length; i++)
   {
      html += "<tr>"
              + "<td align=left>&nbsp; &nbsp; &nbsp; " + SlrEmp[arg][i] + "</td>"
              + "<td align=right>&nbsp; &nbsp; &nbsp; " + SlrHrs[arg][i] + "</td>"
              + "<td align=right>&nbsp; &nbsp; &nbsp; $" + SlrPay[arg][i] + "</td>"
           + "</tr>"
   }

   //html += "<tr>"
   //       + "<th align=left>Total</th>"
   //       + "<td align=right>" + tothrs + "</td>"
   //       + "<td align=right>$" + totpay + "</td>"
   //     + "</tr>"

   // allowable budget total
   html += "<tr>"
              + "<th align=left>Allowable Budget</th>"
              + "<td align=right>" + allwBdgHrs + "</td>"
              + "<td align=right>$" + allwBdgPay + "</td>"
           + "</tr>"

   html += "</table>";

   return html;
}
//==============================================================================
// hide salary hours credit for allowable budget
//==============================================================================
function hideSlrHrsCred()
{
   document.all.dvSlrCred.style.visibility = "hidden";
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

</head>


<body  onload="bodyLoad();">
<!----------------------------------------------------------------------------->
<div id="dvEmpList" class="dvEmpList"></div>
<div id="dvSlrCred" style="position:absolute;visibility:hidden; background-attachment: scroll;
          border: black solid 1px; width:250px;background-color:LemonChiffon; z-index:10;
          visibility:hidden;font-size:10px">
</div>
<!----------------------------------------------------------------------------->
   <table border="0" width="100%" height="100%" cellSpacing="0" cellPadding="0">
    <tr bgColor="moccasin">
     <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>Total Payroll Budget Reviewed (Hourly & Salaried)<br>
      Weekending: <%=sWeekEnd%>
      <%if(sExclude70.equals("Y")){%>&nbsp;(Store 70 is excluded)<%}%>
      </b>
      <br>
<!------------- store selector ----------------------------->
      <form name="getStore" action="javascript:submitForm();">
      <table border="0">
       <tr>
        <td align="right">Weekending:</td>
        <td><SELECT name="WEEK"></SELECT></td>
        <td><input type="submit" name="NEWWEEK" value="GO"></td>
        <td>&nbsp;&nbsp;</td>
        <td align="right">Group by:</td>
        <td><SELECT name="GROUP"></SELECT></td>
        <td><input type="submit" name="NEWTOTAL" value="GO"></td>
       </tr>
      </table>
      </form>
<!------------- end of store selector ---------------------->

        <p align=left style="font-size:12px">
        * Actuals = Total Payroll  <%for(int i=0; i < 25; i++){%>&nbsp;<%}%>

        <a href="javascript:inclExcl70()"><%if(sExclude70.equals("Y")){%>Include Str 70<%} else {%>Exclude Str 70<%}%></a><%for(int i=0; i < 20; i++){%>&nbsp;<%}%>
        <a href="../"><font color="red">Home</font></a>&#62;
        <!--a href="StrScheduling.html"><font color="red">Payroll</font></a -->
        <a href="PrWkMonBdgSchSel.jsp"><font color="red">Week Selector</font></a>&#62;
        This page

        <%for(int i=0; i < 25; i++){%>&nbsp;<%}%>
        Actual Payroll by Position(
           <a href="PrActAvgWage.jsp?From=BEGWEEK&To=<%=sWeekEnd%>&Show=Dlr" target="_blank">Dollars,</a>
           <a href="PrActAvgWage.jsp?From=BEGWEEK&To=<%=sWeekEnd%>&Show=Prc" target="_blank">Percents,</a>
           <a href="PrActAvgWage.jsp?From=BEGWEEK&To=<%=sWeekEnd%>&Show=Avg" target="_blank">Avg.Wage,</a>
           <a href="PrActAvgWage.jsp?From=BEGWEEK&To=<%=sWeekEnd%>&Show=Hrs" target="_blank">Hours</a>
        )
        <%for(int i=0; i < 10; i++){%>&nbsp;<%}%>
        <a id="spOrigLnk" href="javascript: switchOrigAllw()">Allowable Budget</a>
        <a id="spAlwBdgLnk" href="javascript: switchOrigAllw()">Original Budget</a>

        <%for(int i=0; i < 25; i++){%>&nbsp;<%}%>
        <%if(sActual.equals("2")){%><a href="javascript: showSchedUptoCurr(<%if(sUpToCurr.equals("N")){%>'Y'<%} else {%>'N'<%}%>)">
        <%if(sUpToCurr.equals("N")){%>Get schedule upto prior date<%} else {%>Get schedule up to end of week<%}%></a><%}%>
<!------------- start of dollars table ------------------------>
      <table class="DataTable" align="center" >
             <tr>
               <th class="DataTable" rowspan="3">Reg<br/>#</th>
               <th class="DataTable" rowspan="3">Str<br/>#</th>
               <th class="DataTable" rowspan="3">S<br>t<br>a<br>t<br>u<br>s</th>
               <th class="DataTable" rowspan="3">P<br>a<br>s<br>s<br>or<br>F<br>a<br>i<br>l</th>
               <th class="DataTable" colspan="2" nowrap >My<br>Msg</th>
               <th class="DataTable" rowspan="3">T<br>o<br>t<br>a<br>l</th>

               <th class="DataTable" colspan="<%if(!sActual.equals("0")){%>3<%}%><%else{%>2<%}%>">Sales</th>

               <th class="DataTable1" rowspan="3">C<br>o<br>v</th>
               <th class="DataTable" id="thPayDlrLn1" nowrap colspan="<%if(!sActual.equals("0")){%>13<%}%><%else{%>9<%}%>">
                          Payroll Dollars &nbsp; &nbsp; <a id="lnkOrig" href="javascript: foldCol('PayDlr', '2')">fold/unfold</a></th>
               <th class="DataTable" rowspan="3">&nbsp;</th>
               <th class="DataTable" id="thPayPrcLn1" colspan="<%if(!sActual.equals("0")){%>10<%}%><%else{%>7<%}%>">
                          Payroll % &nbsp; &nbsp; <a id="lnkOrig" href="javascript: foldCol('PayPrc', '2')">fold/unfold</a></th>

               <th class="DataTable1"  rowspan="3">&nbsp;</th>

               <th class="DataTable" id="thPayHrsLn1" nowrap colspan="<%if(!sActual.equals("0")){%>11<%}%><%else{%>7<%}%>">
                          # of Hours &nbsp; &nbsp; <a id="lnkOrig" href="javascript: foldCol('PayHrs', '2')">fold/unfold</a></th>

               <%if(!sActual.equals("0")){%>
                 <th class="DataTable1" rowspan="3">V<br>a<br>r<br>i<br>a<br>n<br>c<br>e</th>
               <%}
                 else {%><th class="DataTable1" rowspan="3">&nbsp;</th><%}%>

               <th class="DataTable" id="thPayAvgLn1" nowrap colspan="<%if(!sActual.equals("0")){%>10<%}%><%else{%>7<%}%>">
                          Average Wage &nbsp; &nbsp; <a id="lnkOrig" href="javascript: foldCol('PayAvg', '2')">fold/unfold</a></th>

               <th class="DataTable1" rowspan=3>&nbsp;</th>
               <th class="DataTable" colspan="3">Sales Productivity</th>
             </tr>
             <!-- Header Line 2 -->
             <tr>
                <th class="DataTable" rowspan="2" nowrap>N<br>e<br>w</th>
                <th class="DataTable" rowspan="2" nowrap>R<br>p<br>l<br>y</th>

                <th class="DataTable" rowspan="2">Original<br>Sales<br>Plan</th>
                <th class="DataTable" rowspan="2">Forecast</th>
                <%if(!sActual.equals("0")){%>
                  <th class="DataTable" rowspan="2">Actual</th>
                <%}%>

                <th class="DataTable" id="thPayDlrLn2" colspan="3" nowrap><span id="spOrig">Original</span><span id="spAlwBdg">Allw.</span><br>Budget</th>
                <th class="DataTable" id="thPayDlrLn2" colspan="5">Calc<br>per Schedule</th>
                <th class="DataTable">Budg. vs.<br>Sched.</th>
                <%if(!sActual.equals("0")){%>
                  <th class="DataTable" id="thPayDlrLn2" colspan="4"><a href="PrActAvgWage.jsp?From=BEGWEEK&To=<%=sWeekEnd%>&Show=Dlr" target="_blank">Actual<br>by Position</a></th>
                <%}%>

                <th class="DataTable" id="thPayPrcLn2" colspan="3" nowrap><span id="spOrig">Original</span><span id="spAlwBdg">Allw.</span><br>Budget</th>
                <th class="DataTable" id="thPayPrcLn2" colspan="3">Calc per<br/>Schedule</th>
                <th class="DataTable">Budg. vs.<br>Sched.</th>

                <%if(!sActual.equals("0")){%>
                  <th class="DataTable" id="thPayPrcLn2" colspan="3"><a href="PrActAvgWage.jsp?From=BEGWEEK&To=<%=sWeekEnd%>&Show=Prc" target="_blank">Actual<br>by Position</a></th>
                <%}%>

                <th class="DataTable" colspan="3" id="thPayHrsLn2" nowrap><span id="spOrig">Original</span><span id="spAlwBdg">Allw.</span><br>Budget</th>

                <th class="DataTable" colspan="3" id="thPayHrsLn2">Calculated per Schedule</th>
                <th class="DataTable">Budg. vs.<br>Sched.</th>

                <%if(!sActual.equals("0")){%>
                  <th class="DataTable" colspan="3" id="thPayHrsLn2"><a href="PrActAvgWage.jsp?From=BEGWEEK&To=<%=sWeekEnd%>&Show=Hrs" target="_blank">Actual<br>by Position</a></th>
                  <th class="DataTable" rowspan="2">TMC</th>
                <%}%>

                <th class="DataTable" colspan="3" id="thPayAvgLn2" nowrap><span id="spOrig">Original</span><span id="spAlwBdg">Allw.</span><br>Budget</th>
                <th class="DataTable" colspan="3" id="thPayAvgLn2">Calculated per Schedule</th>
                 <th class="DataTable">Budg. vs.<br>Sched.</th>

                <%if(!sActual.equals("0")){%>
                   <th class="DataTable" colspan="3" id="thPayAvgLn2"><a href="PrActAvgWage.jsp?From=BEGWEEK&To=<%=sWeekEnd%>&Show=Avg" target="_blank">Actual<br>by Position</a></th>
                <%}%>

                <th class="DataTable" rowspan="2">Sell</th>
                <th class="DataTable" rowspan="2">Mgr/<br>Non-Sell/<br>Trn</th>
                <th class="DataTable" rowspan="2">Total</th>

             </tr>
             <tr>
                <!-- Payroll dollars -->
                <th class="DataTable" id="thPayDlrLn3">Salaried</th>
                <th class="DataTable" id="thPayDlrLn3">Hourly</th>
                <th class="DataTable">Total<br>$'s</th>

                <th class="DataTable" id="thPayDlrLn3">Salaried</th>
                <th class="DataTable" id="thPayDlrLn3">Hourly</th>
                <th class="DataTable4">Alw.Bdg</th>
                <th class="DataTable">Total<br>$'s</th>
                <th class="DataTable">Memo:<br>Overtime</th>
                <th class="DataTable">Over<br/>(Under)</th>

                <!-- Actual Payrol $ -->
                <%if(!sActual.equals("0")){%>
                   <th class="DataTable" id="thPayDlrLn3">Salaried</th>
                   <th class="DataTable" id="thPayDlrLn3">Hourly</th>
                   <th class="DataTable">Total<br>$'s</th>
                   <th class="DataTable">Memo:<br>Overtime</th>
                <%}%>

                <!-- Schedule Payroll to Sales % -->
                <th class="DataTable" id="thPayPrcLn3">Salaried<br>%</th>
                <th class="DataTable" id="thPayPrcLn3">Hourly<br>%</th>
                <th class="DataTable">Total<br>%</th>
                <th class="DataTable" id="thPayPrcLn3">Salaried<br>%</th>
                <th class="DataTable" id="thPayPrcLn3">Hourly<br>Subtotal<br>%</th>
                <th class="DataTable">Total<br>%</th>
                <th class="DataTable">Over<br/>(Under)</th>
                <!-- Actual Payroll to Sales % -->
                <%if(!sActual.equals("0")){%>
                   <th class="DataTable" id="thPayPrcLn3">Salaried<br>%</th>
                   <th class="DataTable" id="thPayPrcLn3">Hourly<br>Subtotal<br>%</th>
                   <th class="DataTable">Total<br>%</th>
                <%}%>

                <!-- # of Hours -->
                <th class="DataTable" id="thPayHrsLn3">Salaried</th>
                <th class="DataTable" id="thPayHrsLn3" nowrap>Hourly<br>Subtotal</th>
                <th class="DataTable">Total</th>

                <th class="DataTable" id="thPayHrsLn3">Salaried</th>
                <th class="DataTable"  id="thPayHrsLn3"nowrap>Hourly<br>Subtotal</th>
                <th class="DataTable">Total</th>
                <th class="DataTable">Over<br>(Under)</th>

                <!-- Actual Hours -->
                <%if(!sActual.equals("0")){%>
                   <th class="DataTable" id="thPayHrsLn3">Salaried</th>
                   <th class="DataTable" id="thPayHrsLn3">Hourly<br>Subtotal</th>
                   <th class="DataTable">Total</th>
                <%}%>

                <!-- Average Rate -->
                <th class="DataTable" id="thPayAvgLn3">Salaried</th>  <!-- Budget -->
                <th class="DataTable" id="thPayAvgLn3">Hourly<br>Subtotal</th>
                <th class="DataTable">Total</th>

                <th class="DataTable" id="thPayAvgLn3">Salaried</th>
                <th class="DataTable" id="thPayAvgLn3" nowrap>Hourly<br>Subtotal</th>
                <th class="DataTable">Total</th>
                <th class="DataTable">Over<br>(Under)</th>

                <!-- Actual Average Rate -->
                <%if(!sActual.equals("0")){%>
                   <th class="DataTable" id="thPayAvgLn3">Salaried</th>
                   <th class="DataTable" id="thPayAvgLn3">Hourly<br>Subtotal</th>
                   <th class="DataTable">Total</th>
                <%}%>

                <!-- th class="DataTable">Avr<br>Wage/<br>Hrs</th -->
             </tr>

           <!-- ************************************************************ -->
           <!-- ------------------------- Region Loop details -------------- -->
           <!-- ************************************************************ -->
           <%int i=0, k=0, iScArg=0;%>
           <%for(int j=0; j < iNumOfReg; j++){%>
             <%if(sGroup.equals("ALL") || sGroup.equals("STR") ||
                  sGroup.equals(sReg[j])){%>

           <tr>
            <% if(!sGroup.equals("STR")){%>
             <td class="DataTable4" nowrap rowspan="<%=iReg[j]+1%>">
                <%=sReg[j]%></td>
            <%}%>

             <!-- ---------------------- Store Loop ----------------------- -->
             <%for(k=0;  i < iNumOfStr && k < iReg[j]; i++, k++){%>
               <%if(k > 0){%>
                  <tr>
               <%}%>

               <% if(sGroup.equals("STR")){%>
                  <td class="DataTable1" nowrap>
                  <%=sRegs[i]%></td>
               <%}%>
                 <td class="DataTable" nowrap>
                    <a href="PrWkSched.jsp?STORE=<%=sStore[i]%>&STRNAME=<%=sStoreName[i]%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>">
                              <%=sStore[i]%></a></td>

                 <td class="DataTable6" nowrap>
                    <a href="Forum.jsp?STORE=<%=sStore[i]%>&STRNAME=<%=sStoreName[i]%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>"
                       target="_blank">
                      <%if(!sApprvSts[i].equals(" ")){%><%=sApprvSts[i]%><%} else {%>&nbsp;<%}%></a>
                 </td>
                 <td class="DataTable1" nowrap><%iScArg = setbud.getSelStrScore(sStore[i]);%>
                     <%if(iScArg >= 0){%>
                         <a href="javascript: showStrSlsProdScore('<%=iScArg%>' , '<%=sStore[i]%>')"><%=sStrScore[iScArg][7]%></a>
                     <%}%>
                 </td>
                 <td class="DataTable6" nowrap><%=sNewReq[i]%></td>
                 <td class="DataTable6" nowrap><%=sNewRsp[i]%></td>
                 <td class="DataTable6" nowrap><a href="Forum.jsp?STORE=<%=sStore[i]%>&STRNAME=<%=sStoreName[i]%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>"
                       target="_blank"><%=sNewTot[i]%></a></td>

                 <td class="DataTable1" nowrap>$<%=sStrTot[i][0]%></td>
                 <td class="DataTable1" nowrap>$<%=sStrTot[i][74]%></td>
                 <%if(!sActual.equals("0")){%>
                   <td class="DataTable1" nowrap>$<%=sStrTot[i][1]%></th>
                 <%}%>
                 <th class="DataTable1">
                    <a href="EmpNumbyHourWk.jsp?STORE=<%=sStore[i]%>&STRNAME=<%=sStoreName[i]%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&WKDATE=<%=sWkDate%>&FROM=BUDGET&WKDAY=Monday%>">
                    C</a>
                 </th>

                 <!-- Payroll $'s -->
                 <td class="DataTable1" id="tdPayDlrBdg" nowrap onmouseover="showSlrEmpLstCred('<%=i%>', '<%=sStore[i]%>', '<%=sStrTot[i][91]%>', '<%=sStrTot[i][92]%>', '<%=sStrTot[i][58]%>', '<%=sStrTot[i][62]%>', '<%=sStrTot[i][87]%>', '<%=sStrTot[i][88]%>', this)" onmouseout="hideSlrHrsCred()"><span id="spOrig">$<%=sStrTot[i][62]%></span><span id="spAlwBdg">$<%=sStrTot[i][88]%></span></td><!-- Salaried Budget -->
                 <td class="DataTable1" id="tdPayDlrBdg" nowrap><span id="spOrig">$<%=sStrTot[i][65]%></span><span id="spAlwBdg">$<%=sStrTot[i][77]%></span></td><!-- Hrl sub Budget -->
                 <td class="DataTable1" nowrap><span id="spOrig">$<%=sStrTot[i][2]%></span><span id="spAlwBdg">$<%=sStrTot[i][84]%></span></td><!-- Budget -->
                 <td class="DataTable1" id="tdPayDlrScd" nowrap>$<%=sStrTot[i][52]%></td> <!-- Schedule Salaried -->
                 <td class="DataTable1" id="tdPayDlrScd" nowrap>$<%=sStrTot[i][49]%></td><!-- Hrly Subtotal -->
                 <th class="DataTable"><a href="BdgSchActWk.jsp?Store=<%=sStore[i]%>&StrName=<%=sStoreName[i]%>&Wkend=<%=sWeekEnd%>" target="_blank">AB</a></h>

                 <td class="DataTable1" nowrap>$<%=sStrTot[i][3]%></td><!-- Sched total -->
                 <td class="DataTable1" nowrap>$<%=sStrTot[i][30]%></td> <!-- Overtime pay -->
                 <td class="DataTable3" nowrap ><span id="spOrig" <%if(sStrTot[i][4].indexOf("-") < 0){%>style="color:red;"<%}%>>$<%=sStrTot[i][4]%></span><span id="spAlwBdg" <%if(sStrTot[i][78].indexOf("-") < 0){%>style="color:red;"<%}%>>$<%=sStrTot[i][78]%></span></td> <!-- Over /under -->
                 <%if(!sActual.equals("0")){%>
                   <td class="DataTable1" id="tdPayDlrAct" nowrap>&nbsp;<%if(!sStore[i].equals("70")){%>$<%=sStrTot[i][36]%><%}%></th>
                   <td class="DataTable1" id="tdPayDlrAct" nowrap>&nbsp;<%if(!sStore[i].equals("70")){%>$<%=sStrTot[i][39]%><%}%></th>
                   <td class="DataTable1" nowrap><%if(!sStore[i].equals("70")){%>$<%=sStrTot[i][5]%><%}%></th>
                   <td class="DataTable1" nowrap>&nbsp;<%if(!sStore[i].equals("70")){%>$<%=sStrTot[i][31]%><%}%></th>
                 <%}%>

                 <th class="DataTable">&nbsp;</th>

                 <!-- Payroll % -->
                 <td class="DataTable1" nowrap onmouseover="showSlrEmpCred('PRC', '<%=sStrTot[i][93]%>',this)" onmouseout="hideSlrHrsCred()" id="tdPayPrcBdg"><span id="spOrig" nowrap><%=sStrTot[i][70]%>%</span><span id="spAlwBdg" nowrap><%=sStrTot[i][89]%>%</span></td>
                 <td class="DataTable1" nowrap id="tdPayPrcBdg"><span id="spOrig" nowrap><%=sStrTot[i][73]%>%</span><span id="spAlwBdg" nowrap><%=sStrTot[i][79]%>%</span></td>
                 <td class="DataTable1" nowrap><span id="spOrig" nowrap><%=sStrTot[i][6]%>%</span><span id="spAlwBdg" nowrap><%=sStrTot[i][85]%>%</span></td>
                 <td class="DataTable1" nowrap id="tdPayPrcScd"><%=sStrTot[i][55]%>%</td>
                 <td class="DataTable1" nowrap id="tdPayPrcScd"><%=sStrTot[i][51]%>%</td>
                 <td class="DataTable1" nowrap><%=sStrTot[i][7]%>%</span></td>
                 <td class="DataTable3" nowrap><span id="spOrig" nowrap><%=sStrTot[i][8]%>%</span><span id="spAlwBdg" nowrap><%=sStrTot[i][80]%>%</span></td>
                 <%if(!sActual.equals("0")){%>
                   <td class="DataTable1" id="tdPayPrcAct" nowrap>&nbsp;<%if(!sStore[i].equals("70")){%><%=sStrTot[i][44]%>%<%}%></th>
                   <td class="DataTable1" id="tdPayPrcAct" nowrap>&nbsp;<%if(!sStore[i].equals("70")){%><%=sStrTot[i][47]%>%<%}%></th>
                   <td class="DataTable1" nowrap><%if(!sStore[i].equals("70")){%><%=sStrTot[i][9]%>%<%}%></th>
                 <%}%>

                 <th class="DataTable1">&nbsp;</th>

                 <!-- # of Hours -->
                 <td class="DataTable1" nowrap id="tdPayHrsBdg" onmouseover="showSlrEmpLstCred('<%=i%>', '<%=sStore[i]%>', '<%=sStrTot[i][91]%>', '<%=sStrTot[i][92]%>', '<%=sStrTot[i][58]%>', '<%=sStrTot[i][62]%>', '<%=sStrTot[i][87]%>', '<%=sStrTot[i][88]%>', this)" onmouseout="hideSlrHrsCred()"><span id="spOrig"><%=sStrTot[i][58]%></span><span id="spAlwBdg"><%=sStrTot[i][87]%></span></td>
                 <td class="DataTable1" nowrap id="tdPayHrsBdg"><span id="spOrig"><%=sStrTot[i][61]%></span><span id="spAlwBdg"><%=sStrTot[i][75]%></span></td>
                 <td class="DataTable7" nowrap><span id="spOrig"><%=sStrTot[i][21]%></span><span id="spAlwBdg"><%=sStrTot[i][83]%></span></td>
                 <td class="DataTable1" nowrap id="tdPayHrsScd"><%=sStrTot[i][10]%></td>
                 <td class="DataTable1" nowrap id="tdPayHrsScd"><%=sStrTot[i][48]%></td>
                 <td class="DataTable3" nowrap><%=sStrTot[i][14]%></td>
                 <td class="DataTable7" nowrap ><span id="spOrig" <%if(sStrTot[i][22].indexOf("-") < 0){%>style="color:red;"<%}%>><%=sStrTot[i][22]%></span><span id="spAlwBdg" <%if(sStrTot[i][76].indexOf("-") < 0){%>style="color:red;"<%}%>><%=sStrTot[i][76]%></span></td>
                 <%if(!sActual.equals("0")){%>
                   <td class="DataTable1" nowrap id="tdPayHrsAct">&nbsp;<%if(!sStore[i].equals("70")){%><%=sStrTot[i][32]%><%}%></th>
                   <td class="DataTable1" nowrap id="tdPayHrsAct">&nbsp;<%if(!sStore[i].equals("70")){%><%=sStrTot[i][35]%><%}%></th>
                   <td class="DataTable1" nowrap><%if(!sStore[i].equals("70")){%><%=sStrTot[i][15]%><%}%></th>
                   <td class="DataTable1" nowrap><%if(!sStore[i].equals("70")){%><%=sStrTot[i][29]%><%}%></th>
                 <%}%>

                 <%if(!sActual.equals("0")){%>
                    <th class="DataTable"><a href="PrActAvgVar.jsp?Store=<%=sStore[i]%>&StrNm=<%=sStoreName[i]%>&From=BEGWEEK&To=<%=sWeekEnd%>" target="_blank">V</a></th>
                 <%}
                 else {%><th class="DataTable1" nowrap>&nbsp;</th><%}%>

                 <!-- Average Wage -->
                 <td class="DataTable1" nowrap onmouseover="showSlrEmpCred('AVG', '<%=sStrTot[i][94]%>',this)" onmouseout="hideSlrHrsCred()" id="tdPayAvgBdg"><span id="spOrig">$<%=sStrTot[i][66]%></span><span id="spAlwBdg">$<%=sStrTot[i][90]%></span></td><!-- Budget -->
                 <td class="DataTable1" nowrap id="tdPayAvgBdg"><span id="spOrig">$<%=sStrTot[i][69]%></span><span id="spAlwBdg">$<%=sStrTot[i][81]%></span></td>
                 <td class="DataTable7" nowrap><span id="spOrig">$<%=sStrTot[i][23]%></span><span id="spAlwBdg">$<%=sStrTot[i][86]%></span></td>
                 <td class="DataTable1" nowrap id="tdPayAvgScd">$<%=sStrTot[i][16]%></td><!-- Schedule -->
                 <td class="DataTable3" nowrap id="tdPayAvgScd">$<%=sStrTot[i][50]%></td>
                 <td class="DataTable1" nowrap>$<%=sStrTot[i][20]%></td>
                 <td class="DataTable7" nowrap><span id="spOrig">$<%=sStrTot[i][24]%></span><span id="spAlwBdg">$<%=sStrTot[i][82]%></span></td>
                 <%if(!sActual.equals("0")){%>
                   <td class="DataTable1" nowrap id="tdPayAvgAct">&nbsp;<%if(!sStore[i].equals("70")){%>$<%=sStrTot[i][40]%><%}%></th>
                   <td class="DataTable1" nowrap id="tdPayAvgAct">&nbsp;<%if(!sStore[i].equals("70")){%>$<%=sStrTot[i][43]%><%}%></th>
                   <td class="DataTable1" nowrap><%if(!sStore[i].equals("70")){%>$<%=sStrTot[i][28]%><%}%></th>
                 <%}%>

                 <th class="DataTable1" nowrap>&nbsp;</th>

                 <!-- Sales Productivity -->
                 <td class="DataTable1" nowrap>&nbsp;<%if(!sStore[i].equals("70")){%>$<%=sStrTot[i][25]%><%}%></td>
                 <td class="DataTable1" nowrap>&nbsp;<%if(!sStore[i].equals("70")){%>$<%=sStrTot[i][26]%><%}%></td>
                 <td class="DataTable3" nowrap>&nbsp;<%if(!sStore[i].equals("70")){%>$<%=sStrTot[i][27]%><%}%></td>
               </tr>
             <%}%>

             <!-- ----------------Region total------------------------- -->
             <% if(!sGroup.equals("STR")){%>
              <tr>
               <td class="DataTable5">Reg</td>
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5"><%iScArg = setbud.getSelRegScore(sReg[j]);%>
                  <%if(iScArg >= 0){%>
                      <a href="javascript: showRegSlsProdScore('<%=iScArg%>')"><%=sRegScore[iScArg][7]%></a></td>
                  <%}%>
               <th class="DataTable" colspan=3>&nbsp;</th>

               <td class="DataTable5">$<%=sRegTot[j][0]%></td>
               <td class="DataTable5">$<%=sRegTot[j][74]%></td>
               <%if(!sActual.equals("0")){%>
                 <td class="DataTable5"><%=sRegTot[j][1]%></td>
               <%}%>

               <th class="DataTable">&nbsp;</th>

               <!-- Pay $ -->
               <td class="DataTable5" id="tdPayDlrBdg" onmouseover="showSlrEmpCred('PAY', '<%=sRegTot[j][92]%>',this)" onmouseout="hideSlrHrsCred()" ><span id="spOrig">$<%=sRegTot[j][62]%></span><span id="spAlwBdg">$<%=sRegTot[j][88]%></span></td>
               <td class="DataTable5" id="tdPayDlrBdg" ><span id="spOrig">$<%=sRegTot[j][65]%></span><span id="spAlwBdg">$<%=sRegTot[j][77]%></span></td>
               <td class="DataTable5"><span id="spOrig">$<%=sRegTot[j][2]%></span><span id="spAlwBdg">$<%=sRegTot[j][84]%></span></td>
               <td class="DataTable5" id="tdPayDlrScd">$<%=sRegTot[j][52]%></td>
               <td class="DataTable5" id="tdPayDlrScd">$<%=sRegTot[j][49]%></td>
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5">$<%=sRegTot[j][3]%></td>
               <td class="DataTable5">$<%=sRegTot[j][30]%></td>
               <td class="DataTable5"><span id="spOrig">$<%=sRegTot[j][4]%></span><span id="spAlwBdg">$<%=sRegTot[j][78]%></span></td>
               <%if(!sActual.equals("0")){%>
                 <td class="DataTable5" id="tdPayDlrAct">$<%=sRegTot[j][36]%></td>
                 <td class="DataTable5" id="tdPayDlrAct">$<%=sRegTot[j][39]%></td>
                 <td class="DataTable5">$<%=sRegTot[j][5]%></td>
                 <td class="DataTable5">$<%=sRegTot[j][31]%></td>
               <%}%>

               <th class="DataTable">&nbsp;</th>

               <!-- Pay % -->
               <td class="DataTable5" id="tdPayPrcBdg" onmouseover="showSlrEmpCred('PRC', '<%=sRegTot[j][93]%>',this)" onmouseout="hideSlrHrsCred()"><span id="spOrig"><%=sRegTot[j][70]%>%</span><span id="spAlwBdg"><%=sRegTot[j][89]%>%</span></td>
               <td class="DataTable5" id="tdPayPrcBdg"><span id="spOrig"><%=sRegTot[j][73]%>%</span><span id="spAlwBdg"><%=sRegTot[j][79]%>%</span></td>
               <td class="DataTable5"><span id="spOrig"><%=sRegTot[j][6]%>%</span><span id="spAlwBdg"><%=sRegTot[j][85]%>%</span></td>
               <td class="DataTable5" id="tdPayPrcScd"><%=sRegTot[j][55]%>%</td>
               <td class="DataTable5" id="tdPayPrcScd"><%=sRegTot[j][51]%>%</td>
               <td class="DataTable5"><%=sRegTot[j][7]%>%</td>
               <td class="DataTable5"><span id="spOrig"><%=sRegTot[j][8]%>%</span><span id="spAlwBdg"><%=sRegTot[j][80]%>%</span></td>
               <%if(!sActual.equals("0")){%>
                 <td class="DataTable5" id="tdPayPrcAct"><%=sRegTot[j][44]%>%</td>
                 <td class="DataTable5" id="tdPayPrcAct"><%=sRegTot[j][47]%>%</td>
                 <td class="DataTable5"><%=sRegTot[j][9]%>%</td>
               <%}%>

               <th class="DataTable">&nbsp;</th>

               <!-- # of Hours -->
               <td class="DataTable5" id="tdPayHrsBdg" onmouseover="showSlrEmpCred('HRS', '<%=sRegTot[j][91]%>',this)" onmouseout="hideSlrHrsCred()"><span id="spOrig"><%=sRegTot[j][58]%></span><span id="spAlwBdg"><%=sRegTot[j][87]%></span></td>
               <td class="DataTable5" id="tdPayHrsBdg"><span id="spOrig"><%=sRegTot[j][61]%></span><span id="spAlwBdg"><%=sRegTot[j][75]%></span></td>
               <td class="DataTable5"><span id="spOrig"><%=sRegTot[j][21]%></span><span id="spAlwBdg"><%=sRegTot[j][83]%></span></td>
               <td class="DataTable5" id="tdPayHrsScd"><%=sRegTot[j][10]%></td>
               <td class="DataTable5" id="tdPayHrsScd"><%=sRegTot[j][48]%></td>
               <td class="DataTable5"><%=sRegTot[j][14]%></td>
               <td class="DataTable5"><span id="spOrig" <%if(sRegTot[j][22].indexOf("-") < 0){%>style="color:red;"<%}%>><%=sRegTot[j][22]%></span><span id="spAlwBdg" <%if(sRegTot[j][76].indexOf("-") < 0){%>style="color:red;"<%}%>><%=sRegTot[j][76]%></span></td>
               <%if(!sActual.equals("0")){%>
                 <td class="DataTable5" id="tdPayHrsAct"><%=sRegTot[j][32]%></td>
                 <td class="DataTable5" id="tdPayHrsAct"><%=sRegTot[j][35]%></td>
                 <td class="DataTable5"><%=sRegTot[j][15]%></td>
                 <td class="DataTable5"><%=sRegTot[j][29]%></td>
               <%}%>

               <th class="DataTable">&nbsp;</th>

               <!-- Avg Wage -->
               <td class="DataTable5" id="tdPayAvgBdg" onmouseover="showSlrEmpCred('AVG', '<%=sRegTot[j][94]%>',this)" onmouseout="hideSlrHrsCred()"><span id="spOrig">$<%=sRegTot[j][66]%></span><span id="spAlwBdg">$<%=sRegTot[j][90]%></span></td>
               <td class="DataTable5" id="tdPayAvgBdg"><span id="spOrig">$<%=sRegTot[j][69]%></span><span id="spAlwBdg">$<%=sRegTot[j][81]%></span></td>
               <td class="DataTable5"><span id="spOrig">$<%=sRegTot[j][23]%></span><span id="spAlwBdg">$<%=sRegTot[j][86]%></span></td>
               <td class="DataTable5" id="tdPayAvgScd">$<%=sRegTot[j][16]%></td>
               <td class="DataTable5" id="tdPayAvgScd">$<%=sRegTot[j][50]%></td>
               <td class="DataTable5">$<%=sRegTot[j][20]%></td>
               <td class="DataTable5"><span id="spOrig">$<%=sRegTot[j][24]%></span><span id="spAlwBdg">$<%=sRegTot[j][82]%></span></td>
               <%if(!sActual.equals("0")){%>
                 <td class="DataTable5" id="tdPayAvgAct"><%=sRegTot[j][40]%></td>
                 <td class="DataTable5" id="tdPayAvgAct"><%=sRegTot[j][43]%></td>
                 <td class="DataTable5"><%=sRegTot[j][28]%></td>
               <%}%>

               <th class="DataTable">&nbsp;</th>

               <!-- Productivity -->
               <td class="DataTable5">$<%=sRegTot[j][25]%></td>
               <td class="DataTable5">$<%=sRegTot[j][26]%></td>
               <td class="DataTable5">$<%=sRegTot[j][27]%></td>
              </tr>
             <%}%>
           <%}
           else { i += iReg[j]; }%>

          <%}%>


           <!-- ************************************************************ -->
           <!-- -------------------- Region Loop - totals only ------------- -->
           <!-- ************************************************************ -->

           <%for(int j=0; j < iNumOfReg; j++){%>
           <%if(sGroup.equals("TOTAL")){%>
            <tr>
              <td class="DataTable4" nowrap>
                 <%=sReg[j]%></td>
             <!-- Region total -->
              <td class="DataTable5">Reg</td>
              <th class="DataTable" colspan=5>&nbsp;</th>

               <td class="DataTable5">$<%=sRegTot[j][0]%></td>
               <td class="DataTable5">$<%=sRegTot[j][74]%></td>
               <%if(!sActual.equals("0")){%>
                 <td class="DataTable5">$<%=sRegTot[j][1]%></td>
               <%}%>
               <th class="DataTable">&nbsp;</th>

               <!-- Payrol $ -->
               <td class="DataTable5" id="tdPayDlrBdg" onmouseover="showSlrEmpCred('PAY', '<%=sRegTot[j][92]%>',this)" onmouseout="hideSlrHrsCred()"><span id="spOrig">$<%=sRegTot[j][62]%></span><span id="spAlwBdg">$<%=sRegTot[j][88]%></span></td>
               <td class="DataTable5" id="tdPayDlrBdg"><span id="spOrig">$<%=sRegTot[j][65]%></span><span id="spAlwBdg">$<%=sRegTot[j][77]%></span></td>
               <td class="DataTable5"><span id="spOrig">$<%=sRegTot[j][2]%></span><span id="spAlwBdg">$<%=sRegTot[j][84]%></span></td>
               <td class="DataTable5" id="tdPayDlrScd">$<%=sRegTot[j][52]%></td>
               <td class="DataTable5" id="tdPayDlrScd">$<%=sRegTot[j][49]%></td>
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5">$<%=sRegTot[j][3]%></td>
               <td class="DataTable5">$<%=sRegTot[j][30]%></td>
               <td class="DataTable5"><span id="spOrig">$<%=sRegTot[j][4]%></span><span id="spAlwBdg">$<%=sRegTot[j][49]%></span></td>
               <%if(!sActual.equals("0")){%>
                 <td class="DataTable5" id="tdPayDlrAct">$<%=sRegTot[j][36]%></td>
                 <td class="DataTable5" id="tdPayDlrAct">$<%=sRegTot[j][39]%></td>
                 <td class="DataTable5">$<%=sRegTot[j][5]%></td>
                 <td class="DataTable5">$<%=sRegTot[j][31]%></td>
               <%}%>

               <!-- Payroll % -->
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5" id="tdPayPrcBdg" onmouseover="showSlrEmpCred('PRC', '<%=sRegTot[j][93]%>',this)" onmouseout="hideSlrHrsCred()"><span id="spOrig"><%=sRegTot[j][70]%>%</span><span id="spAlwBdg"><%=sRegTot[j][89]%>%</span></td>
               <td class="DataTable5" id="tdPayPrcBdg"><span id="spOrig"><%=sRegTot[j][73]%>%</span><span id="spAlwBdg"><%=sRegTot[j][79]%>%</span></td>
               <td class="DataTable5"><span id="spOrig"><%=sRegTot[j][6]%>%</span><span id="spAlwBdg"><%=sRegTot[j][85]%>%</span></td>
               <td class="DataTable5" id="tdPayPrcScd"><%=sRegTot[j][55]%>%</td>
               <td class="DataTable5" id="tdPayPrcScd"><%=sRegTot[j][51]%>%</td>
               <td class="DataTable5"><%=sRegTot[j][7]%>%</td>
               <td class="DataTable5"><span id="spOrig"><%=sRegTot[j][8]%>%</span><span id="spAlwBdg"><%=sRegTot[j][80]%>%</span></td>
               <%if(!sActual.equals("0")){%>
                 <td class="DataTable5" id="tdPayPrcAct"><%=sRegTot[j][44]%>%</td>
                 <td class="DataTable5" id="tdPayPrcAct"><%=sRegTot[j][47]%>%</td>
                 <td class="DataTable5"><%=sRegTot[j][9]%>%</td>
               <%}%>

               <!-- # of Hours -->
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5" id="tdPayHrsBdg" onmouseover="showSlrEmpCred('HRS', '<%=sRegTot[j][91]%>',this)" onmouseout="hideSlrHrsCred()"><span id="spOrig"><%=sRegTot[j][58]%></span><span id="spAlwBdg"><%=sRegTot[j][87]%></span></td>
               <td class="DataTable5" id="tdPayHrsBdg"><span id="spOrig"><%=sRegTot[j][61]%></span><span id="spAlwBdg"><%=sRegTot[j][75]%></span></td>
               <td class="DataTable5"><span id="spOrig"><%=sRegTot[j][21]%></span><span id="spAlwBdg"><%=sRegTot[j][83]%></span></td>
               <td class="DataTable5" id="tdPayHrsScd"><%=sRegTot[j][10]%></td>
               <td class="DataTable5" id="tdPayHrsScd"><%=sRegTot[j][48]%></td>
               <td class="DataTable5"><%=sRegTot[j][14]%></td>
               <td class="DataTable5" nowrap><span id="spOrig" <%if(sRegTot[j][22].indexOf("-") < 0){%>style="color:red;"<%}%>><%=sRegTot[j][22]%></span><span id="spAlwBdg" <%if(sRegTot[j][76].indexOf("-") < 0){%>style="color:red;"<%}%>><%=sRegTot[j][76]%></span></td>
               <%if(!sActual.equals("0")){%>
                 <td class="DataTable5" id="tdPayHrsAct"><%=sRegTot[j][32]%></td>
                 <td class="DataTable5" id="tdPayHrsAct"><%=sRegTot[j][35]%></td>
                 <td class="DataTable5"><%=sRegTot[j][15]%></td>
                 <td class="DataTable5"><%=sRegTot[j][29]%></td>
               <%}%>

               <th class="DataTable">&nbsp;</th>

               <!-- Average Wage -->
               <td class="DataTable5" id="tdPayAvgBdg" onmouseover="showSlrEmpCred('AVG', '<%=sRegTot[j][94]%>',this)" onmouseout="hideSlrHrsCred()"><span id="spOrig">$<%=sRegTot[j][66]%></span><span id="spAlwBdg">$<%=sRegTot[j][90]%></span></td>
               <td class="DataTable5" id="tdPayAvgBdg"><span id="spOrig">$<%=sRegTot[j][69]%></span><span id="spAlwBdg">$<%=sRegTot[j][81]%></span></td>
               <td class="DataTable5"><span id="spOrig">$<%=sRegTot[j][23]%></span><span id="spAlwBdg">$<%=sRegTot[j][86]%></span></td>
               <td class="DataTable5" id="tdPayAvgScd">$<%=sRegTot[j][16]%></td>
               <td class="DataTable5" id="tdPayAvgScd">$<%=sRegTot[j][50]%></td>
               <td class="DataTable5">$<%=sRegTot[j][20]%></td>
               <td class="DataTable5"><span id="spOrig">$<%=sRegTot[j][24]%></span><span id="spAlwBdg">$<%=sRegTot[j][82]%></span></td>
               <%if(!sActual.equals("0")){%>
                 <td class="DataTable5" id="tdPayAvgAct">$<%=sRegTot[j][40]%></td>
                 <td class="DataTable5" id="tdPayAvgAct">$<%=sRegTot[j][43]%></td>
                 <td class="DataTable5">$<%=sRegTot[j][28]%></td>
               <%}%>

               <!-- Productivity -->
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5">$<%=sRegTot[j][25]%></td>
               <td class="DataTable5">$<%=sRegTot[j][26]%></td>
               <td class="DataTable5">$<%=sRegTot[j][27]%></td>
             </tr>
           <%}%>
          <%}%>

         <!-- ************************************************************ -->
         <!-- -------------------- Company totals ------------------------ -->
         <!-- ************************************************************ -->
            <tr>
               <td class="DataTable3" colspan="2">Total</td>

               <th class="DataTable1" colspan=5>&nbsp;</th>
               <td class="DataTable3" nowrap>$<%=sRepTot[0]%></td>
               <td class="DataTable5">$<%=sRepTot[74]%></td>
               <%if(!sActual.equals("0")){%>
                 <td class="DataTable3" nowrap>$<%=sRepTot[1]%></td>
               <%}%>
               <th class="DataTable1">&nbsp;</th>

               <!-- Payroll Dollars -->
               <td class="DataTable5" id="tdPayDlrBdg" onmouseover="showSlrEmpCred('PAY', '<%=sRepTot[92]%>',this)" onmouseout="hideSlrHrsCred()"><span id="spOrig">$<%=sRepTot[62]%></span><span id="spAlwBdg">$<%=sRepTot[88]%></span></td>
               <td class="DataTable5" id="tdPayDlrBdg"><span id="spOrig">$<%=sRepTot[65]%></span><span id="spAlwBdg">$<%=sRepTot[77]%></span></td>
               <td class="DataTable5"><span id="spOrig">$<%=sRepTot[2]%></span><span id="spAlwBdg">$<%=sRepTot[84]%></span></td>
               <td class="DataTable5" id="tdPayDlrScd">$<%=sRepTot[52]%></td>
               <td class="DataTable5" id="tdPayDlrScd">$<%=sRepTot[49]%></td>
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5">$<%=sRepTot[3]%></td>
               <td class="DataTable5">$<%=sRepTot[30]%></td>
               <td class="DataTable5"><span id="spOrig">$<%=sRepTot[4]%></span><span id="spAlwBdg">$<%=sRepTot[78]%></span></td>
               <%if(!sActual.equals("0")){%>
                 <td class="DataTable5" id="tdPayDlrAct">$<%=sRepTot[36]%></td>
                 <td class="DataTable5" id="tdPayDlrAct">$<%=sRepTot[39]%></td>
                 <td class="DataTable5">$<%=sRepTot[5]%></td>
                 <td class="DataTable5">$<%=sRepTot[31]%></td>
               <%}%>

               <!-- Payroll % -->
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5" id="tdPayPrcBdg" onmouseover="showSlrEmpCred('PRC', '<%=sRepTot[93]%>',this)" onmouseout="hideSlrHrsCred()"><span id="spOrig"><%=sRepTot[70]%>%</span><span id="spAlwBdg"><%=sRepTot[89]%>%</span></td>
               <td class="DataTable5" id="tdPayPrcBdg"><span id="spOrig"><%=sRepTot[73]%>%</span><span id="spAlwBdg"><%=sRepTot[79]%>%</span></td>
               <td class="DataTable5"><span id="spOrig"><%=sRepTot[6]%>%</span><span id="spAlwBdg"><%=sRepTot[85]%>%</span></td>
               <td class="DataTable5" id="tdPayPrcScd"><%=sRepTot[55]%>%</td>
               <td class="DataTable5" id="tdPayPrcScd"><%=sRepTot[51]%>%</td>
               <td class="DataTable5"><%=sRepTot[7]%>%</td>
               <td class="DataTable5"><span id="spOrig"><%=sRepTot[8]%>%</span><span id="spAlwBdg"><%=sRepTot[80]%>%</span></td>
               <%if(!sActual.equals("0")){%>
                 <td class="DataTable5" id="tdPayPrcAct"><%=sRepTot[44]%>%</td>
                 <td class="DataTable5" id="tdPayPrcAct"><%=sRepTot[47]%>%</td>
                 <td class="DataTable5"><%=sRepTot[9]%>%</td>
               <%}%>

               <!-- # of Hours -->
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5" id="tdPayHrsBdg" onmouseover="showSlrEmpCred('HRS', '<%=sRepTot[91]%>',this)" onmouseout="hideSlrHrsCred()"><span id="spOrig"><%=sRepTot[58]%></span><span id="spAlwBdg"><%=sRepTot[87]%></span></td>
               <td class="DataTable5" id="tdPayHrsBdg"><span id="spOrig"><%=sRepTot[61]%></span><span id="spAlwBdg"><%=sRepTot[75]%></span></td>
               <td class="DataTable5"><span id="spOrig"><%=sRepTot[21]%></span><span id="spAlwBdg"><%=sRepTot[83]%></span></td>
               <td class="DataTable5" id="tdPayHrsScd"><%=sRepTot[10]%></td>
               <td class="DataTable5" id="tdPayHrsScd"><%=sRepTot[48]%></td>
               <td class="DataTable5"><%=sRepTot[14]%></td>
               <td class="DataTable5" nowrap><span id="spOrig" <%if(sRepTot[22].indexOf("-") < 0){%>style="color:red;"<%}%>><%=sRepTot[22]%></span><span id="spAlwBdg" <%if(sRepTot[76].indexOf("-") < 0){%>style="color:red;"<%}%>><%=sRepTot[76]%></span></td>
               <%if(!sActual.equals("0")){%>
                 <td class="DataTable5" id="tdPayHrsAct"><%=sRepTot[32]%></td>
                 <td class="DataTable5" id="tdPayHrsAct"><%=sRepTot[35]%></td>
                 <td class="DataTable5"><%=sRepTot[15]%></td>
                 <td class="DataTable5"><%=sRepTot[29]%></td>
               <%}%>

               <th class="DataTable"><a href="javascript: showActAvgVarAll()">V</a></th>

               <!-- Avg Wage -->
               <td class="DataTable5" id="tdPayAvgBdg" onmouseover="showSlrEmpCred('AVG', '<%=sRepTot[94]%>',this)" onmouseout="hideSlrHrsCred()"><span id="spOrig">$<%=sRepTot[66]%></span><span id="spAlwBdg">$<%=sRepTot[90]%></span></td>
               <td class="DataTable5" id="tdPayAvgBdg"><span id="spOrig">$<%=sRepTot[69]%></span><span id="spAlwBdg">$<%=sRepTot[81]%></span></td>
               <td class="DataTable5"><span id="spOrig">$<%=sRepTot[23]%></span><span id="spAlwBdg">$<%=sRepTot[86]%></span></td>
               <td class="DataTable5" id="tdPayAvgScd">$<%=sRepTot[16]%></td>
               <td class="DataTable5" id="tdPayAvgScd">$<%=sRepTot[50]%></td>
               <td class="DataTable5">$<%=sRepTot[20]%></td>
               <td class="DataTable5"><span id="spOrig">$<%=sRepTot[24]%></span><span id="spAlwBdg">$<%=sRepTot[82]%></span></td>
               <%if(!sActual.equals("0")){%>
                 <td class="DataTable5" id="tdPayAvgAct">$<%=sRepTot[40]%></td>
                 <td class="DataTable5" id="tdPayAvgAct">$<%=sRepTot[43]%></td>
                 <td class="DataTable5">$<%=sRepTot[28]%></td>
               <%}%>

               <!-- Productivity -->
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5">$<%=sRepTot[25]%></td>
               <td class="DataTable5">$<%=sRepTot[26]%></td>
               <td class="DataTable5">$<%=sRepTot[27]%></td>

             </tr>


       </table>

<!------------- end of data table ------------------------>
<p style="text-align:left;font-size:10px">
* Budgeted, Scheduled and Actual payroll hours and dollars exclude holiday, vacation, sick pay and bonuses.<br>
<!--** Budgeted, Scheduled and Actual hours for salaried employees are limited to 45 hours.-->

<p style="text-align:left; font-size:10px">
<!--Number of stores pass correlation coefficient requirment: <%=iPass%>.<br>
Number of stores fail correlation coefficient requirment: <%=iFail%>.-->


<p style="text-align:left;font-size:10px">
</tr>
<tr bgColor="moccasin">
     <td ALIGN="left" VALIGN="TOP">
<!------------- Sales Goal per Store ------------------------>
<div id="dvSGProd">
<table class="DataTable"  cellPadding="0" cellSpacing="0">
    <tr>
      <th class="DataTable" rowspan=3>Reg</th>
      <th class="DataTable" rowspan=3>Store</th>
      <th class="DataTable1" rowspan=3>&nbsp;</th>
      <th class="DataTable" colspan=23>Sales Goal (85%)<br>"SP" - Productivity, Hrs=Schedule Selling Hrs.</th>
      <th class="DataTable3" rowspan=3>&nbsp;</th>
      <th class="DataTable" colspan=4>Weekly Schedule vs. Budget</th>
    </tr>
    <tr>
      <th class="DataTable" colspan=2>Mon</th>
      <th class="DataTable1" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan=2>Tue</th>
      <th class="DataTable1" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan=2>Wed</th>
      <th class="DataTable1" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan=2>Thu</th>
      <th class="DataTable1" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan=2>Fri</th>
      <th class="DataTable1" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan=2>Sat</th>
      <th class="DataTable1" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan=2>Sun</th>
      <th class="DataTable1" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan=2>Total</th>
      <th class="DataTable" colspan=2>Budget<br>Hrs</th>
      <th class="DataTable" rowspan=2>Var<br>(Hrs)</th>
      <th class="DataTable" rowspan=2>Var<br>(%)</th>
    </tr>
    <tr>
      <%for(int m=0; m < 8; m++){%>
         <th class="DataTable2"><a href="javascript: resortSGProd('<%=m%>')">SP</a></th>
         <th class="DataTable2">Hrs</th>
      <%}%>
      <th class="DataTable2">SP</th>
      <th class="DataTable2">Hrs</th>
    </tr>

    <%for(int l=0, reg=0, str=0; l < iNumOfStrSG; l++){%>
      <tr>
         <%if(str==0){%><td class="DataTable8" rowspan="<%=sSGStr[reg].length%>" ><%=sSGReg[reg]%></td><%}%>
         <td class="DataTable8"><%=sSGStr[reg][str] + " - " + sSGStrNm[l]%></td>
         <%for(int m=0; m < 8; m++){%>
            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable1<%=sSGHiLo[l][m]%>">$<%=sSGProd[l][m]%></td>
            <td class="DataTable1"><%=sSGHrs[l][m]%></td>
         <%}%>
         <th class="DataTable3">&nbsp;</th>
         <td class="DataTable1">$<%=sSGBdgSP[l]%></td>
         <td class="DataTable1"><%=sSGBdg[l]%></td>
         <td class="DataTable1"><%=sSGVarHrs[l]%></td>
         <td class="DataTable1"><%=sSGVar[l]%>%</td>
      </tr>
      <!------------- Break on Region ------------------------>
      <%str++;
        if(str == sSGStr[reg].length){%>
           <tr><td style="background:darkred; font-size:1px;" colspan=32>&nbsp;</td></tr>
           <tr>
             <td class="DataTable31" colspan=2>Reg <%=reg+1%> Totals</td>
             <%for(int m=0; m < 8; m++){%>
               <th class="DataTable1">&nbsp;</th>
               <td class="DataTable3<%=sTotSGHiLo[reg][m]%>">$<%=sTotSGProd[reg][m]%></td>
               <td class="DataTable3"><%=sTotSGHrs[reg][m]%></td>
             <%}%>
             <th class="DataTable3">&nbsp;</th>
             <td class="DataTable3">$<%=sTotSGBdgSP[reg]%></td>
             <td class="DataTable3"><%=sTotSGBdg[reg]%></td>
             <td class="DataTable3"><%=sTotSGVarHrs[reg]%></td>
             <td class="DataTable3"><%=sTotSGVar[reg]%>%</td>
         </tr>
           <!-- Divider -->
           <tr><td style="background:darkred; font-size:2px;" colspan=32>&nbsp;</td></tr>
      <%
           str=0; reg++;
        }
      %>
    <%}%>
    <!------------- Productivity Totals ------------------------>
    <tr>
         <td class="DataTable31" colspan=2>Total&nbsp;&nbsp;&nbsp;</td>
         <%for(int m=0; m < 8; m++){%>
            <th class="DataTable1">&nbsp;</th>
            <td class="DataTable3<%=sTotSGHiLo[iNumOfRegSg][m]%>">$<%=sTotSGProd[iNumOfRegSg][m]%></td>
            <td class="DataTable3"><%=sTotSGHrs[iNumOfRegSg][m]%></td>
         <%}%>
         <th class="DataTable3">&nbsp;</th>
         <td class="DataTable3">$<%=sTotSGBdgSP[iNumOfRegSg]%></td>
         <td class="DataTable3"><%=sTotSGBdg[iNumOfRegSg]%></td>
         <td class="DataTable3"><%=sTotSGVarHrs[iNumOfRegSg]%></td>
         <td class="DataTable3"><%=sTotSGVar[iNumOfRegSg]%>%</td>
    </tr>
</table>
</div>
<!------------- end of data table ------------------------>
                </td>
            </tr>
       </table>

        </body>
      </html>
