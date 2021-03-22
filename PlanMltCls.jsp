<%@ page import="agedanalysis.PlanMltCls, rciutility.FormatNumericValue, java.util.*"%>
<%
   //----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("PLAN") == null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PlanMltCls.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   String [] sStore = request.getParameterValues("STORE");
   String sDivision = request.getParameter("DIVISION");
   String sDivName = request.getParameter("DIVNAME");
   String sDepartment = request.getParameter("DEPARTMENT");
   String sDptName = request.getParameter("DPTNAME");
   String sClass = request.getParameter("CLASS");
   String sClassName = request.getParameter("CLSNAME");
   String sChgPlan = request.getParameter("AlwChg");
   String sSelYear = request.getParameter("Year");
   String sCateg = request.getParameter("Categ");
   String sResult = "3";

   if(sClass == null) sClass = "ALL";

   //System.out.println(sDivision + " " + sDepartment + " " + sClass
   // + " " + sSelYear+ " " + sCateg + " " + sChgPlan);
   PlanMltCls planexp = new PlanMltCls(sStore, sDivision, sDepartment, sClass, sSelYear, sCateg, sChgPlan);
   int iNumOfCls = planexp.getNumOfCls();
   String [] sCls = planexp.getCls();
   String [] sClsName = planexp.getClsName();
   String [][] sPlan = planexp.getPlan();
   String [][] sLySls = planexp.getLySls();

   String sStrJsa = planexp.getStrJsa();
   String sClsJsa = planexp.getClsJsa();
   String sClsNameJsa = planexp.getClsNameJsa();
   String sPlanJsa = planexp.getPlanJsa();
   String sLySlsJsa = planexp.getLySlsJsa();
   String sYear = planexp.getYear();
   String sCurMon = planexp.getCurMon();

   StringBuffer sbStr = new StringBuffer();
    for(int i=0; i < sStore.length; i++)
    {
       if(sStore[i].equals("SAS")) sbStr.append("Sun & Ski");
       else if(sStore[i].equals("SCH")) sbStr.append("Ski Chalet");
       else sbStr.append(sStore[i] + " ");
    }

   planexp.disconnect();
   planexp = null;

   // format Numeric value
   FormatNumericValue fmt = new FormatNumericValue();

   String [] sMonth = {"Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar"};
   String sChgPlanBy = "Retail";
   if (sChgPlan.equals("C")){ sChgPlanBy = "Cost"; }
   else if (sChgPlan.equals("U")){ sChgPlanBy = "Unit"; }

   String sPlanCategory = "Sales";
   if (sCateg.equals("M")){ sPlanCategory = "Markdown"; }
   else if (sCateg.equals("I")){ sPlanCategory = "Ending Inventory"; }
%>
<html>
<head>
<style>
        body { background:white; text-align:center;}
        a { color:blue} a:visited { color:blue}  a:hover { color:blue}

        table.DataTable { border: darkred solid 1px; background: darkred; text-align:center;}
        tr.DataTable { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:CornSilk; font-family:Arial; font-size:10px }

        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center;
                       font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99; border-bottom: darkred solid 1px;
                        border-right: darkred solid 1px; font-size:1px }

        th.DataTable1 { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        td.DataTable  { border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px; text-align:left; font-family:Arial; }

        td.DataTable1  { border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px; text-align:right;}

        input.Small{ text-align:left; font-family:Arial; font-size:10px;}
        select.Small{ text-align:left; font-family:Arial; font-size:10px;}
        .Small{ text-align:left; font-family:Arial; font-size:10px;}

        div.CoorGoal { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:800; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }

        td.misc1{ filter:progid:DXImageTransform.Microsoft.Gradient(
                  startColorStr=#c3fdb8, endColorStr=#99c68e, gradientType=0);
                 padding-top:0px; border:darkgreen 1px solid;
                 color: darkblue; vertical-align:middle; text-align:center; font-size:12px; }
</style>
<SCRIPT language="JavaScript1.2">
//==============================================================================
// global variables
//==============================================================================
var NumOfCls = <%=iNumOfCls%>;
var NumOfMon = 12;
var Store = [<%=sStrJsa%>];
var Class = [<%=sClsJsa%>];
var ClsName = [<%=sClsNameJsa%>];
var Plan = [<%=sPlanJsa%>];
var LySls = [<%=sLySlsJsa%>];
var Result = "<%=sResult%>";
var CalcSel = 1;
var CurMon = <%=sCurMon%>;
var SelYear = <%=sSelYear%>;
var Categ = "<%=sCateg%>";

// calculated totals
var TotMonLY = new Array(NumOfMon); // Column LY Monthly Total
var TotMonPlan = new Array(NumOfMon); // Column Plan Monthly Total
var TotYrLY = new Array(NumOfCls); // Row (Class) LY Total
var TotYrPlan = new Array(NumOfCls); // Row (Class) Plan Total
var TotAllYrLY = 0; // All Classes/Year LY Total
var TotAllYrPlan = 0; // All Classes/Year Plan Total

var NewPlan = new Array(NumOfCls);
for(var i=0; i < NumOfCls; i++) { NewPlan[i] = new Array(NumOfMon);}
var PrcChg = new Array(NumOfCls);
for(var i=0; i < NumOfCls; i++) { PrcChg[i] = new Array(NumOfMon);}

var SbmClass = 0; // submitting class counter

//==============================================================================
// work at loading time
//==============================================================================
function bodyLoad()
{
   window.status = "OTB Planning is loading now."
   setResultSel();
   setPrecision(Result); // set result precision 1/100/1k/10k
   setPlan();
   setCalcSel();
   chgMonVis(false);
   if(Categ == "I") undispYrChg();
   window.status = "";
}
//==============================================================================
// change Month Visability
// make passed month invisible
//==============================================================================
function chgMonVis(vis)
{
   window.status = "Fold/unfold passed month column."
   var hdrow1 = NumOfMon * 5; // header 1 line
   var hdrow2 = 0; // header: 2nd line
   if( !vis )
   {
     hdrow1 = NumOfMon * 5 - (CurMon - 1) * 5;
     hdrow2 = CurMon-1;
   }
   document.all.thMonth.colSpan = hdrow1;
   // header: 2nd line visability
   for(var i = 0; i < NumOfMon; i++)
   {
      var dsp = "block"
      var col;
      if(i < hdrow2) dsp = "none";

      document.all.thMonName[i].style.display = dsp;
      document.all.thLine2[i].style.display = dsp;
      document.all.thLine31[i].style.display = dsp;
      document.all.thLine32[i].style.display = dsp;
      document.all.thLine33[i].style.display = dsp;
      document.all.thLine34[i].style.display = dsp;
      document.all.thLine35[i].style.display = dsp;

      col = "TLYM" + i; document.all[col].style.display = dsp;
      col = "TNPM" + i; document.all[col].style.display = dsp;
      col = "TINM" + i; document.all[col].style.display = dsp;
      col = "TPRC" + i; document.all[col].style.display = dsp;
      col = "TDIV" + i; document.all[col].style.display = dsp;
      window.status = "";
   }

   // detail line
   var col;

   for(var i=0; i < NumOfCls; i++)
   {
      for(var j=0; j < NumOfMon; j++)
      {
         var dsp = "block"
         if(j < hdrow2) dsp = "none";

         col = "LY" + i + "M" + j;
         document.all[col].style.display = dsp;
         col = "NP" + i + "M" + j;
         document.all[col].style.display = dsp;
         col = "IN" + i + "M" + j;
         document.all[col].style.display = dsp;
         col = "PRC" + i + "M" + j;
         document.all[col].style.display = dsp;
         col = "DIV" + i + "M" + j;
         document.all[col].style.display = dsp;
      }
   }
}
//==============================================================================
// make Year changes column un visible for Ending inventory
//==============================================================================
function undispYrChg()
{
   var hdr = document.all.thYrChg;
   for(var i=0; i < hdr.length; i++)
   {
      hdr[i].style.display = "none";
   }
   var col;
   for(var i=0; i < NumOfCls; i++)
   {
      col = "TLY" + [i]; document.all[col].style.display = "none";
      col = "TINP" + [i]; document.all[col].style.display = "none";
      col = "CNP" + [i]; document.all[col].style.display = "none";
      col = "CPRC" + [i]; document.all[col].style.display = "none";
      col = "CDIV" + [i]; document.all[col].style.display = "none";
   }
   // change for all
   col = "TOTYRLY"; document.all[col].style.display = "none";
   col = "TOTIN";   document.all[col].style.display = "none";
   col = "TOTNP";   document.all[col].style.display = "none";
   col = "TOTPRC";  document.all[col].style.display = "none";
   col = "TOTDIV";  document.all[col].style.display = "none";
}
//==============================================================================
// set Result selection
//==============================================================================
function setResultSel()
{
   document.all.Result.options[0] = new Option("ones", 1);
   document.all.Result.options[1] = new Option("hundreds", 2);
   document.all.Result.options[2] = new Option("thousands", 3);
   document.all.Result.options[3] = new Option("10 thousands", 4);
   document.all.Result.selectedIndex = eval(Result) - 1;
}
//==============================================================================
// set Result selection
//==============================================================================
function setCalcSel()
{
   document.all.CalcSel[0].checked = CalcSel;
}
//==============================================================================
// change Result selection reset screen
//==============================================================================
function chgResultSel()
{
  Result = (document.all.Result.selectedIndex) + 1;
  setPrecision(Result);
  setPlan();
}
//==============================================================================
// change Result selection reset screen
//==============================================================================
function chgCalcSel(type)
{
  CalcSel = type;
}
//==============================================================================
// set Plan input field values
//==============================================================================
function setPlan()
{
   var lysls;
   var plan;
   var prc;
   var prcchg = 0;

   for(var j=0; j < NumOfMon; j++) { TotMonLY[j] = 0; TotMonPlan[j] = 0; }
   for(var i=0; i < NumOfCls; i++) { TotYrLY[i] = 0; TotYrPlan[i] = 0; }

   for(var i=0; i < NumOfCls; i++)
   {
      for(var j=0; j < NumOfMon; j++)
      {
         lysls = "LY" + i + "M" + j;
         document.all[lysls].innerHTML = format(LySls[i][j]);
         plan = "NP" + i + "M" + j;
         document.all[plan].innerHTML = format(Plan[i][j]);
         TotMonLY[j] += eval(LySls[i][j]);
         TotMonPlan[j] += eval(Plan[i][j]);

         // calculate current LY Sales/plan %
         if(eval(LySls[i][j]) != 0)
         {
           prc = "PRC" + i + "M" + j;
           prcchg = ((eval(Plan[i][j]) - eval(LySls[i][j])) / eval(LySls[i][j]) * 100).toFixed(1);
           document.all[prc].innerHTML = prcchg + "%";
         }

         TotYrLY[i] += eval(LySls[i][j]);
         TotYrPlan[i] += eval(Plan[i][j]);
         TotAllYrLY += eval(LySls[i][j]);
         TotAllYrPlan += eval(Plan[i][j]);
      }

      // calculate class/year total percentage
      plan = "CNP" + i;
      document.all[plan].innerHTML = format(TotYrPlan[i]);
      if(TotYrLY[i] != 0)
      {
         prc = "CPRC" + i
         prcchg = ((TotYrPlan[i] - TotYrLY[i]) / TotYrLY[i] * 100).toFixed(1);
         document.all[prc].innerHTML = prcchg + "%";
      }
   }

   plan = "TOTNP";
   document.all[plan].innerHTML = format(TotAllYrPlan);
   if(TotAllYrLY != 0)
   {
      prc = "TOTPRC"
      prcchg = ((TotAllYrPlan - TotAllYrLY) / TotAllYrLY * 100).toFixed(1);
      document.all[prc].innerHTML = prcchg + "%";
   }

   // populate month total
   for(var j=0; j < NumOfMon; j++)
   {
      lysls = "TLYM" + j; document.all[lysls].innerHTML = format(TotMonLY[j]);

      // calculate total/month total percentage
      plan = "TNPM" + j;
      document.all[plan].innerHTML = format(TotMonPlan[j]);
      if(TotMonLY[j] != 0)
      {
         prc = "TPRC" + j
         prcchg = ((TotMonPlan[j] - TotMonLY[j]) / TotMonLY[j] * 100).toFixed(1);
         document.all[prc].innerHTML = prcchg + "%";
      }
   }

   // populate class/year total
   for(var i=0; i < NumOfCls; i++) { lysls = "TLY" + i; document.all[lysls].innerHTML = format(TotYrLY[i]); }

   // total for all screen
   lysls = "TOTYRLY";
   document.all[lysls].innerHTML = format(TotAllYrLY);
}
//==============================================================================
// Calculate New Plan
//==============================================================================
function calcPlan()
{
  window.status = "Wait! New Plan is calculating."
  calcAllPlan();
  calcRowPlan();
  calcColPlan();
  calcCellPlan();
  calcPrcOfChg();
  window.status = "New Plan calculated.";
}
//==============================================================================
// Calculate All Plans ( column / row )
//==============================================================================
function calcAllPlan()
{
   var inp; var prc; var amt=0; var plan;
   calc = "TCY";
   prc = document.all[calc].value.trim(" ");

   if (!isNaN(prc) && eval(prc) != 0)
   {
      for(var i=0; i < NumOfCls; i++)
      {

         for(var j=0; j < NumOfMon; j++)
         {
            if (SelYear==0 || j >= CurMon-1)
            {
               if(NewPlan[i][j]==null) { amt = setAmtByType(i, j); } // use LY sales
               else { amt = eval(NewPlan[i][j]) } // use already Calculated Amount

               amt = calcAmtByType(amt, prc);
               NewPlan[i][j] = amt;
               plan = "NP" + i + "M" + j;
               document.all[plan].innerHTML = format(amt);
               document.all[calc].value = "";
            }
         }
      }
   }
}
//==============================================================================
// Calculate Plan for each month in class (row)
//==============================================================================
function calcRowPlan()
{
   var inp; var prc; var amt=0; var plan;

   for(var i=0; i < NumOfCls; i++)
   {
      calc = "CY" + i;
      prc = document.all[calc].value.trim(" ");
      if (!isNaN(prc) && eval(prc) != 0)
      {
         for(var j=0; j < NumOfMon; j++)
         {
            if (SelYear==0 || j >= CurMon-1)
            {
               if(NewPlan[i][j]==null) { amt = setAmtByType(i, j); } // use LY sales
               else { amt = eval(NewPlan[i][j]) } // use already Calculated Amount

               amt = calcAmtByType(amt, prc);
               NewPlan[i][j] = amt;
               plan = "NP" + i + "M" + j;
               document.all[plan].innerHTML = format(amt);
               document.all[calc].value = "";
            }
         }
      }
   }
}
//==============================================================================
// Calculate Plan for all classes for selected month ( column )
//==============================================================================
function calcColPlan()
{
   var inp; var prc; var amt=0; var plan;

   for(var i=0; i < NumOfCls; i++)
   {
       for(var j=0; j < NumOfMon; j++)
       {
          calc = "TCM" + j;
          if (SelYear==0 || j >= CurMon-1) { prc = document.all[calc].value.trim(" ");}
          if (!isNaN(prc) && eval(prc) != 0)
          {
             if(NewPlan[i][j]==null) { amt = setAmtByType(i, j); } // use LY sales
             else { amt = eval(NewPlan[i][j]) } // use already Calculated Amount

             amt = calcAmtByType(amt, prc);
             NewPlan[i][j] = amt;
             plan = "NP" + i + "M" + j;
             document.all[plan].innerHTML = format(amt);
          }
       }
   }

   //reset  column
   for(var j=0; j < NumOfMon; j++) { calc = "TCM" + j; if (SelYear==0 || j >= CurMon-1) {document.all[calc].value = "";} }
}
//==============================================================================
// Calculate New Plan
//==============================================================================
function calcCellPlan()
{
   var inp; var prc; var amt=0; var plan;

   for(var i=0; i < NumOfCls; i++)
   {
      calcMonPlan(i);
   }
}

//==============================================================================
// Calculate Monthly Plan
//==============================================================================
function calcMonPlan(i)
{
   var inp; var prc; var amt=0; var plan;

   for(var j=0; j < NumOfMon; j++)
   {
      calc = "C" + i + "M" + j;
      prc = 0;
      if (SelYear==0 || j >= CurMon-1) { prc = document.all[calc].value.trim(" "); }
      if (!isNaN(prc) && eval(prc) != 0)
      {

         if(NewPlan[i][j] == null) {amt = setAmtByType(i, j); } // use LY sales
         else { amt = eval(NewPlan[i][j]) } // use already Calculated Amount

         amt = calcAmtByType(amt, prc);
         NewPlan[i][j] = amt;
         plan = "NP" + i + "M" + j;
         document.all[plan].innerHTML = format(amt);
         document.all[calc].value = "";
      }
      else
      {
           plan = "NP" + i + "M" + j;
           if(NewPlan[i][j] != null) { document.all[plan].innerHTML = format(NewPlan[i][j]); }
           else { document.all[plan].innerHTML = format(Plan[i][j]); }
      }
   }
}
//==============================================================================
// set amount based on calculation type
//==============================================================================
function setAmtByType(i, j)
{
   var amt = 0;
   if (CalcSel < 4) { amt = eval(LySls[i][j]); }
   else { amt = eval(Plan[i][j]); }
   return amt;
}
//==============================================================================
// Calculate Amount by calculation type
//==============================================================================
function calcAmtByType(amt, prc)
{
   var unfmt = 1; // use to restore amount to unformated value
   if (Result==2){ unfmt = 100; }
   else if (Result==3){ unfmt = 1000; }
   else if (Result==4){ unfmt = 10000; }

   if (CalcSel==1 || CalcSel==4){ prc =  1 + eval(prc) / 100;  amt = amt * prc; }
   else if (CalcSel==2 || CalcSel==5){  amt = eval(amt) + eval(prc) * unfmt;}
   else if (CalcSel==3 || CalcSel==6){ amt = eval(prc) * unfmt; }


   return amt;
}
//==============================================================================
// Calculate percent of changes
//==============================================================================
function calcPrcOfChg()
{
   var prc;
   TotAllYrPlan = 0;
   for(var j=0; j < NumOfMon; j++) {TotMonPlan[j] = 0; }

   for(var i=0; i < NumOfCls; i++)
   {
      TotYrPlan[i] = 0;
      for(var j=0; j < NumOfMon; j++)
      {
         prc = "PRC" + i + "M" + j;
         if (NewPlan[i][j] != null)
         {
            TotYrPlan[i] += eval(NewPlan[i][j]);
            TotMonPlan[j] += eval(NewPlan[i][j]);
            TotAllYrPlan += eval(NewPlan[i][j]);
            if(eval(LySls[i][j]) != 0)
            {
               PrcChg[i][j] = ((eval(NewPlan[i][j]) - eval(LySls[i][j])) / eval(LySls[i][j]) * 100).toFixed(1);
            }
            else { PrcChg[i][j] = 0; }
            document.all[prc].innerHTML = PrcChg[i][j] + "%";
         }
         else
         {
            TotYrPlan[i] += eval(Plan[i][j]);
            TotMonPlan[j] += eval(Plan[i][j]);
            TotAllYrPlan[i] += eval(Plan[i][j]);
         }
      }

      // calculate class/year total percentage
      plan = "CNP" + i;
      document.all[plan].innerHTML = format(TotYrPlan[i]);
      if(TotYrLY[i] != 0)
      {
         prc = "CPRC" + i
         var prcchg = ((TotYrPlan[i] - TotYrLY[i]) / TotYrLY[i] * 100).toFixed(1);
         document.all[prc].innerHTML = prcchg + "%";
      }
   }

   plan = "TOTNP";
   document.all[plan].innerHTML = format(TotAllYrPlan);
   if(TotAllYrLY != 0)
   {
      prc = "TOTPRC"
      prcchg = ((TotAllYrPlan - TotAllYrLY) / TotAllYrLY * 100).toFixed(1);
      document.all[prc].innerHTML = prcchg + "%";
   }

   // populate month total
   for(var j=0; j < NumOfMon; j++)
   {
      // calculate total/month total percentage
      plan = "TNPM" + j;
      document.all[plan].innerHTML = format(TotMonPlan[j]);
      if(TotMonLY[j] != 0)
      {
         prc = "TPRC" + j
         prcchg = ((TotMonPlan[j] - TotMonLY[j]) / TotMonLY[j] * 100).toFixed(1);
         document.all[prc].innerHTML = prcchg + "%";
      }
   }
}
//==============================================================================
// Reset Plans
//==============================================================================
function resetAll()
{
   var calc;  var plan; var prc;

   for(var i=0; i < NumOfCls; i++)
   {
      for(var j=0; j < NumOfMon; j++)
      {
         if (SelYear==0 || j >= CurMon-1)
         {
            calc = "C" + i + "M" + j;
            document.all[calc].value = "";
            plan = "NP" + i + "M" + j;
            document.all[plan].innerHTML = format(Plan[i][j]);
            NewPlan[i][j] = null;
            PrcChg[i][j] = null;
            prc = "PRC" + i + "M" + j;
            document.all[prc].innerHTML = "&nbsp;";
         }
      }
   }
}
//==============================================================================
// save Plan
//==============================================================================
function savePlan()
{
   SbmClass = 0;
   sbmPlan();
}

//==============================================================================
// submit plan Plan
//==============================================================================
function sbmPlan()
{
   // refresh window when last class was updated
   if (SbmClass >= NumOfCls) { window.location.reload(); return;}

   var clcbase;

   if(CalcSel < 4) { clcbase = '1'; }
   else { clcbase = '0'; }

   var url = "PlanMltClcSave.jsp?"
           + "AlwChg=<%=sChgPlan%>"
           + "&Categ=" + Categ
           + "&Year=<%=sSelYear%>"
           + "&ClcBase=" + clcbase;

   for(var i=0; i < Store.length; i++ ) { url += "&Str=" + Store[i];}

   setPrecision(1); // set result precision 1/100/1k/10k

   var save = false; var prc = " ";

   for(var j=0; j < NumOfMon; j++)
   {
      if(NewPlan[SbmClass][j]!=null && !isNaN(NewPlan[SbmClass][j]))
      {
         if (CalcSel < 4 && LySls[SbmClass][j] != 0)
         {
            prc += "&Prc=" + (eval(NewPlan[SbmClass][j]) / eval(LySls[SbmClass][j])).toFixed(2);
         }
         else if (Plan[SbmClass][j] != 0)
         {
            prc += "&Prc=" + (eval(NewPlan[SbmClass][j]) / eval(Plan[SbmClass][j])).toFixed(2);
            //alert(prc + "\n" + NewPlan[SbmClass][j] + "\n" + Plan[SbmClass][j])
         }

         save = true;
      }
      else { prc += "&Prc=0";}
   }

   // check if class has any changes
   url += "&Cls=" + Class[SbmClass] + prc;

   SbmClass += 1;

   if(save)
   {
     //alert(url)
     //window.location.href = url;
     window.frame1.location.href = url;
   }
   else { skipClass();}
}
//==============================================================================
// Skip Class which has not been changed
//==============================================================================
function skipClass()
{
  //alert("Counter:" + SbmClass);
  sbmPlan();
}
//==============================================================================
// Key down
//==============================================================================
function jumpToNext(cls, mon)
{
  k = window.event.keyCode
  if(k == 13)
  {
      if(cls < NumOfCls-1){ cls = eval(cls) + 1}
      else if(cls == NumOfCls-1 && mon < NumOfMon-1){ cls = 0; mon = eval(mon) + 1}
      var next = "C" + cls + "M" + mon;
      document.all[next].focus();
  }
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="FormatNumerics.js"></script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

</head>
<!-------------------------------------------------------------------->
<body onload="bodyLoad()" >
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvCoorGoal" class="CoorGoal"></div>
<!-------------------------------------------------------------------->
   <b><font size="+2">OTB Planning - Express Method (Plan C)</font></b><br>

   <b>Store: <%=sbStr.toString()%><br>
      &nbsp;&nbsp; Division: <%=sDivName%>
      &nbsp;&nbsp; Department: <%=sDptName%><br>
      &nbsp;&nbsp; Class: <%=sClassName%>
      &nbsp;&nbsp; Fiscal Year: <%=sYear%><br>
      Change Plan by <%=sChgPlanBy%> &nbsp; &nbsp; &nbsp; &nbsp;
      Plan Category: <%=sPlanCategory%>
   </b><br>

   <a href="../"><font color="red" size="-1">Home</font></a>&#62;
   <a href="PlanMltClsSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
   <font size="-1">This page.</font>;

   <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr>
       <td class="misc1">

          <span style="text-align:left;">Saved changes on this screen are applied to plan C.</span>
      </td>
      <td class="misc1">
          <button name="Calc" class="Small" onClick="calcPlan()">Calc</button>&nbsp;&nbsp;&nbsp;&nbsp;
          <button name="Save" class="Small" onClick="savePlan()">Save</button>&nbsp;&nbsp;&nbsp;&nbsp;
          <button name="Reset" class="Small" onClick="resetAll()">Reset</button>
      </td>
      <td class="misc1">
        Result Shows in &nbsp;<select name="Result" class="Small"></select>&nbsp;
                        <button onClick="chgResultSel();" class="Small">Change</button>
      </td>
      <td class="misc1">
        Calculaton Types:<br>
        Based on LY<input type=radio name="CalcSel" onClick="chgCalcSel(1)" class="Small" value=1>+/- % &nbsp;
                   <input type=radio name="CalcSel" onClick="chgCalcSel(2)" class="Small" value=2>+/- $ &nbsp;
                   <input type=radio name="CalcSel" onClick="chgCalcSel(3)" class="Small" value=3>$ <br>

        Based on Plan<input type=radio name="CalcSel" onClick="chgCalcSel(4)" class="Small" value=5>+/- % &nbsp;
                     <input type=radio name="CalcSel" onClick="chgCalcSel(5)" class="Small" value=6>+/- $ &nbsp;
                     <input type=radio name="CalcSel" onClick="chgCalcSel(6)" class="Small" value=7>$

      </td>
   </table>
<!-------------------------------------------------------------------->
   <table class='DataTable' cellPadding="0" cellSpacing="0">
      <tr>
        <th class='DataTable' rowspan="3">Class</th>
        <th class='DataTable1' rowspan="3">&nbsp;</th>
        <th class='DataTable' colspan="4" id="thYrChg">Year<br>Changes</th>
        <th class='DataTable1' rowspan="3" id="thYrChg">&nbsp;</th>
        <th id="thMonth" class='DataTable' colspan="60">Month
            <a href="javascript: chgMonVis(false);">Fold</a> /
            <a href="javascript: chgMonVis(true);">Unfold</a></th>
      </tr>

      <tr>
        <th class='DataTable' colspan=4 id="thYrChg"><%=sYear%></th>
        <%for(int i=0; i < 12; i++){%><th id="thMonName" class='DataTable' colspan=4><%=sMonth[i]%></th><th id="thLine2" class='DataTable1'>&nbsp;</th><%}%>
      </tr>

      <tr>
        <th class='DataTable' id="thYrChg">LY</th>
        <th class='DataTable' id="thYrChg">+/-</th>
        <th class='DataTable' id="thYrChg">Plan</th>
        <th class='DataTable' id="thYrChg">% of<br>Chg</th>

        <%for(int i=0; i < 12; i++){%>
           <th id="thLine31" class='DataTable'>LY</th>
           <th id="thLine32" class='DataTable'>+/-</th>
           <th id="thLine33" class='DataTable'>Plan</th>
           <th id="thLine34" class='DataTable'>% of<br>Chg</th>
           <th id="thLine35" class='DataTable1'>&nbsp;</th>
        <%}%>
      </tr>
     <!--------------------------- Classes ------------------------------------>
     <%for(int i=0; i < iNumOfCls; i++) {%>
         <tr class="DataTable">
            <td class="DataTable" nowrap><%=sCls[i] + " - " + sClsName[i].toLowerCase()%></td>
            <th class='DataTable1'>&nbsp;</th>

            <td class="DataTable1" id="TLY<%=i%>"></td>
            <td class="DataTable1" id="TINP<%=i%>">
               <input class="small"  size=3 maxlength=10 name="CY<%=i%>">
            </td>
            <td class="DataTable1" id="CNP<%=i%>" nowrap></td>
            <td class="DataTable1" id="CPRC<%=i%>" nowrap></td>
            <th class='DataTable1' id="CDIV<%=i%>">&nbsp;</th>

            <!--------------------- Class/Month entry ----------------------------->
            <%for(int j=0; j < 12; j++) {%>
               <td class="DataTable1" id="LY<%=i%>M<%=j%>"></td>
               <td id="IN<%=i%>M<%=j%>" class="DataTable1">
                  <%if(sSelYear.equals("0") || sSelYear.equals("1") && j >= Integer.parseInt(sCurMon)-1){%>
                    <input class="small"  size=3 maxlength=10 name="C<%=i%>M<%=j%>" onKeyDown="jumpToNext(<%=i%>,<%=j%>)"><%}%>
               </td>
               <td class="DataTable1" id="NP<%=i%>M<%=j%>" nowrap></td>
               <td class="DataTable1" id="PRC<%=i%>M<%=j%>" nowrap></td>
               <th class='DataTable1' id="DIV<%=i%>M<%=j%>">&nbsp;</th>
            <%}%>
         </tr>
     <%}%>
     <!------------------------ Changes For Column ---------------------------->
         <tr class="DataTable1">
            <td class="DataTable" nowrap>Changes For All Classes</td>
            <th class="DataTable1"></th>
            <td class="DataTable1" id="TOTYRLY"></td>
            <td class="DataTable1" id="TOTIN">
               <input class="small"  size=3 maxlength=10 name="TCY">
            </td>
            <td class="DataTable1" id="TOTNP">&nbsp;</td>
            <td class="DataTable1" id="TOTPRC" nowrap>&nbsp;</td>
            <th class='DataTable1' id="TOTDIV">&nbsp;</th>
            <!--------------------- Store Goal details ----------------------------->
            <%for(int j=0; j < 12; j++) {%>
               <td class="DataTable1" id="TLYM<%=j%>">&nbsp;</td>
               <td class="DataTable1" id="TINM<%=j%>">
                  <%if(sSelYear.equals("0") || sSelYear.equals("1") && j >= Integer.parseInt(sCurMon)-1){%>
                    <input class="small"  size=3 maxlength=10 name="TCM<%=j%>"><%}%>
               </td>
               <td class="DataTable1" id="TNPM<%=j%>">&nbsp;</td>
               <td class="DataTable1" id="TPRC<%=j%>" nowrap></td>
               <th class='DataTable1' id="TDIV<%=j%>">&nbsp;</th>
            <%}%>
         </tr>
    </table>
    <br>
    <button name="Calc" class="Small" onClick="calcPlan()">Calc</button>&nbsp;&nbsp;&nbsp;&nbsp;
    <button name="Save" class="Small" onClick="savePlan()">Save</button>&nbsp;&nbsp;&nbsp;&nbsp;
    <button name="Reset" class="Small" onClick="resetAll()">Reset</button>
    <br><br>
</body>
</html>

<%}%>

