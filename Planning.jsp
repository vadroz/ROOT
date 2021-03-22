<%@ page import="agedanalysis.Planning, rciutility.FormatNumericValue, java.util.*"%>
<%
   String [] sStore = request.getParameterValues("STORE");
   String sDivision = request.getParameter("DIVISION");
   String sDepartment = request.getParameter("DEPARTMENT");
   String sClass = request.getParameter("CLASS");
   String sNumMon = request.getParameter("NumMon");
   String sStartMon = request.getParameter("StartMon");
   String sRetVal = request.getParameter("RetVal");
   String sCstVal = request.getParameter("CstVal");
   String sUntVal = request.getParameter("UntVal");
   String sAlwChg = request.getParameter("AlwChg");

   if(sClass == null) sClass = "ALL";
   if(sRetVal == null) sRetVal = "0";
   if(sCstVal == null) sCstVal = "0";
   if(sUntVal == null) sUntVal = "0";

   //System.out.println(sStore  + " " + sDivision + " " + sDepartment + " " + sClass
   //       + " " + sNumMon + " " + sRetVal + " " + sCstVal + " " + sUntVal);
   Planning plans = new Planning(sStore, sDivision, sDepartment, sClass, sStartMon, sNumMon,
                                          sRetVal, sCstVal, sUntVal);

    int iNumOfMon = plans.getNumOfMon();
    String [] sMonBeg = plans.getMonBeg();
    String [] sMonEnd = plans.getMonEnd();
    String [] sMonName = plans.getMonName();
    String [] sTyMon = plans.getTyMon();
    String [] sLyMon = plans.getLyMon();
    String sPercent = plans.getPercent();

    int iNumOfVal = plans.getNumOfVal();
    String [] sValue = plans.getValue();
    String sValueJsa = plans.getValueJsa();

    // plan
    String [][] sPlanRet = plans.getSlsPlanRet();
    String [][] sPlanInv = plans.getSlsPlanInv();
    String [][] sPlanMkd = plans.getSlsPlanMkd();
    String [][] sPlanGrm = plans.getSlsPlanGrm();
    String [][] sPlanAvr = plans.getSlsPlanAvr();
    String [][] sPlanImu = plans.getSlsPlanImu();
    String [][] sPlanCmu = plans.getSlsPlanCmu();
    String [][] sPlanMrm = plans.getSlsPlanMrm();
    String [][] sPlanMmu = plans.getSlsPlanMmu();
    String [][] sPlanMkdSls = plans.getSlsPlanMkdSls();
    String [][] sPlanSellOff = plans.getSlsPlanSellOff();
    String [][] sPlanMvi = plans.getSlsPlanMvi();
    String [][] sPlanGmroi = plans.getSlsPlanGmroi();

    String [][] sActSls = plans.getActSls();
    String [][] sActInv = plans.getActInv();
    String [][] sActMkd = plans.getActMkd();

    // TY history
    String [][] sTySls = plans.getTySls();
    String [][] sTyEin = plans.getTyEin();
    String [][] sTyMkd = plans.getTyMkd();
    String [][] sTyGrm = plans.getTyGrm();
    String [][] sTyPrh = plans.getTyPrh();
    String [][] sTyAvr = plans.getTyAvr();
    String [][] sTyImu = plans.getTyImu();
    String [][] sTyCmu = plans.getTyCmu();
    String [][] sTyMrm = plans.getTyMrm();
    String [][] sTyMmu = plans.getTyMmu();
    String [][] sTyMkdSls = plans.getTyMkdSls();
    String [][] sTySellOff = plans.getTySellOff();
    String [][] sTyMvi = plans.getTyMvi();
    String [][] sTyGmroi = plans.getTyGmroi();

    // LY history
    String [][] sLySls = plans.getLySls();
    String [][] sLyEin = plans.getLyEin();
    String [][] sLyMkd = plans.getLyMkd();
    String [][] sLyGrm = plans.getLyGrm();
    String [][] sLyPrh = plans.getLyPrh();
    String [][] sLyAvr = plans.getLyAvr();
    String [][] sLyImu = plans.getLyImu();
    String [][] sLyCmu = plans.getLyCmu();
    String [][] sLyMrm = plans.getLyMrm();
    String [][] sLyMmu = plans.getLyMmu();
    String [][] sLyMkdSls = plans.getLyMkdSls();
    String [][] sLySellOff = plans.getLySellOff();
    String [][] sLyMvi = plans.getLyMvi();
    String [][] sLyGmroi = plans.getLyGmroi();

    String [][] sPurchOrd = plans.getPurchOrd();

    // Totals
    String [] sTotPlnRet = plans.getTotPlnRet();
    String [] sTotPlnInv = plans.getTotPlnInv();
    String [] sTotPlnMkd = plans.getTotPlnMkd();
    String [] sTotPlnGrm = plans.getTotPlnGrm();
    String [] sTotPlnAvr = plans.getTotPlnAvr();
    String [] sTotPlnImu = plans.getTotPlnImu();
    String [] sTotPlnCmu = plans.getTotPlnCmu();
    String [] sTotPlnMrm = plans.getTotPlnMrm();
    String [] sTotPlnMmu = plans.getTotPlnMmu();
    String [] sTotPlnMkdSls = plans.getTotPlnMkdSls();
    String [] sTotPlnSellOff = plans.getTotPlnSellOff();
    String [] sTotPlnMvi = plans.getTotPlnMvi();
    String [] sTotPlnGmroi = plans.getTotPlnGmroi();

    String [] sTotActSls = plans.getTotActSls();
    String [] sTotActInv = plans.getTotActInv();
    String [] sTotActMkd = plans.getTotActMkd();

    String [] sTotTyRet = plans.getTotTyRet();
    String [] sTotTyInv = plans.getTotTyInv();
    String [] sTotTyMkd = plans.getTotTyMkd();
    String [] sTotTyGrm = plans.getTotTyGrm();
    String [] sTotTyPrh = plans.getTotTyPrh();
    String [] sTotTyAvr = plans.getTotTyAvr();
    String [] sTotTyImu = plans.getTotTyImu();
    String [] sTotTyCmu = plans.getTotTyCmu();
    String [] sTotTyMrm = plans.getTotTyMrm();
    String [] sTotTyMmu = plans.getTotTyMmu();
    String [] sTotTyMkdSls = plans.getTotTyMkdSls();
    String [] sTotTySellOff = plans.getTotTySellOff();
    String [] sTotTyMvi = plans.getTotTyMvi();
    String [] sTotTyGmroi = plans.getTotTyGmroi();

    String [] sTotLyRet = plans.getTotLyRet();
    String [] sTotLyInv = plans.getTotLyInv();
    String [] sTotLyMkd = plans.getTotLyMkd();
    String [] sTotLyGrm = plans.getTotLyGrm();
    String [] sTotLyPrh = plans.getTotLyPrh();
    String [] sTotLyAvr = plans.getTotLyAvr();
    String [] sTotLyImu = plans.getTotLyImu();
    String [] sTotLyCmu = plans.getTotLyCmu();
    String [] sTotLyMrm = plans.getTotLyMrm();
    String [] sTotLyMmu = plans.getTotLyMmu();
    String [] sTotLyMkdSls = plans.getTotLyMkdSls();
    String [] sTotLySellOff = plans.getTotLySellOff();
    String [] sTotLyMvi = plans.getTotLyMvi();
    String [] sTotLyGmroi = plans.getTotLyGmroi();

    String [] sTotPurchOrd = plans.getTotPurchOrd();

    // Javascript arrays
    String sPlanRetJsa = plans.getPlanRetJsa();
    String sPlanMkdJsa = plans.getPlanMkdJsa();
    String sPlanInvJsa = plans.getPlanInvJsa();

    String sActSlsJsa = plans.getActSlsJsa();
    String sActMkdJsa = plans.getActMkdJsa();
    String sActInvJsa = plans.getActInvJsa();

    String sLdgSlsJsa = plans.getLdgSlsJsa();
    String sLdgInvJsa = plans.getLdgInvJsa();
    String sLdgMkdJsa = plans.getLdgMkdJsa();

    String sPurchOrdJsa = plans.getPurchOrdJsa();

    plans.disconnect();

    String sCSSCls = "DataTable";
    StringBuffer sbStr = new StringBuffer();
    for(int i=0; i < sStore.length; i++)
    {
       sbStr.append(sStore[i] + " ");
    }

    FormatNumericValue fmt = new FormatNumericValue();
 %>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue; font-size:12px } a:visited { color:blue; font-size:12px }  a:hover { color:blue; font-size:12px }
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

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


        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }

        div.Promo { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//report parameters
var Store = ["ALL", "1", "2", "3", "4", "5", "8", "10", "11", "12", "20", "28",
             "30", "40", "45", "61", "82", "88", "98", "99" , "100", "101", "199"];
var SelStr = new Array(<%=sStore.length%>);
<%for(int i=0; i < sStore.length; i++) {%>  SelStr[<%=i%>] = "<%=sStore[i]%>"; <%}%>

var Values = [<%=sValueJsa%>]
var Division = "<%=sDivision%>";
var Department = "<%=sDepartment%>";
var Class = "<%=sClass%>";
var NumMon = "<%=sNumMon%>";
var StartMon = <%=sStartMon.trim()%>;
var RetVal = "<%=sRetVal%>";
var CstVal = "<%=sCstVal%>";
var UntVal = "<%=sUntVal%>";
var AlwChg = "<%=sAlwChg%>";
var New = 0;

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

var NumOfMon = <%=iNumOfMon%>; // number of month
var NumOfVal = <%=iNumOfVal%>; // required retail, cost or unit values
//--------------------------------------------------
// populate input object name array
var SlsInp = new Array(); // sales details
var MkdInp = new Array(); // markdown details
var InvInp = new Array(); // inventory details

var TotSlsInp = new Array(); // total sales details
var TotMkdInp = new Array(); // total markdown details
var TotInvInp = new Array(); // total inventory details
//--------------------------------------------------
// populate table plan cell names
var SlsCell = new Array(); // sales details
var MkdCell = new Array(); // sales details
var InvCell = new Array(); // sales details

var TotSlsCell = new Array(); // sales details
var TotMkdCell = new Array(); // sales details
var TotInvCell = new Array(); // sales details
//--------------------------------------------------
// populate table Percent cell names
var SlsPrcCell = new Array(); // sales details
var MkdPrcCell = new Array(); // sales details
var InvPrcCell = new Array(); // sales details

var TotSlsPrcCell = new Array(); // sales details
var TotMkdPrcCell = new Array(); // sales details
var TotInvPrcCell = new Array(); // sales details
//--------------------------------------------------
// plan details
var PlanSls = [<%=sPlanRetJsa%>];
var PlanMkd = [<%=sPlanMkdJsa%>];
var PlanInv = [<%=sPlanInvJsa%>];

var SavePlanSls = [<%=sPlanRetJsa%>];
var SavePlanMkd = [<%=sPlanMkdJsa%>];
var SavePlanInv = [<%=sPlanInvJsa%>];

// Actual details
var ActSls = [<%=sActSlsJsa%>];
var ActMkd = [<%=sActMkdJsa%>];
var ActInv = [<%=sActInvJsa%>];
var Percent = <%=sPercent.trim()%>;

var ApplyHist = false;
//--------------------------------------------------
var fold = false;

var ImuCell = new Array(); // last 8 columns
var CmuCell = new Array(); // last 8 columns
var MrmCell = new Array(); // last 8 columns
var MmuCell = new Array(); // last 8 columns
var MdsCell = new Array(); // last 8 columns
var SofCell = new Array(); // last 8 columns
var MviCell = new Array(); // last 8 columns
var GriCell = new Array(); // last 8 columns


var TotImuCell = new Array(); // last 8 columns
var TotCmuCell = new Array(); // last 8 columns
var TotMrmCell = new Array(); // last 8 columns
var TotMmuCell = new Array(); // last 8 columns
var TotMdsCell = new Array(); // last 8 columns
var TotSofCell = new Array(); // last 8 columns
var TotMviCell = new Array(); // last 8 columns
var TotGriCell = new Array(); // last 8 columns

//--------------------------------------------------
// Stock ledger
var LdgSls = [<%=sLdgSlsJsa%>];
var LdgInv = [<%=sLdgInvJsa%>];
var LdgMkd = [<%=sLdgMkdJsa%>];

var BomCell = new Array(); // begining of month inventory
var BomVal = new Array(); // begining of month inventory value
//--------------------------------------------------
// Purchase order
var PurchOrd = [<%=sPurchOrdJsa%>];
//--------------- End of Global variables ----------------
function bodyLoad()
{
   setLast8ColArrays();
   showTYPLANS();

   document.all.Save.style.visibility="hidden"
   // populate input object array
   setInpArrays();

   // calculate Plan vs Actual
   clcPlanVsActual();

   // set BOM inventory
   setBOMInvArrays();

   // set Required for Plan inventory
   setRfp_Otr_Otb_Ocf();

   // do not allow to entry for current month
   setCurMonInpInvisible();
}
//--------------------------------------------------------
// populate input object array
//--------------------------------------------------------
function setInpArrays()
{
   for(var i=0; i < NumOfMon; i++)
   {
      var slsi = new Array();
      var mkdi = new Array();
      var invi = new Array();
      var slsc = new Array();
      var mkdc = new Array();
      var invc = new Array();

      var slsp = new Array();
      var mkdp = new Array();
      var invp = new Array();

      for(var j=0; j < NumOfVal; j++)
      {
         if(AlwChg==Values[j])
         {
           // input fields
           slsi[j] = document.all["S" + i + "V" + j];
           mkdi[j] = document.all["M" + i + "V" + j];
           invi[j] = document.all["I" + i + "V" + j];
         }

         // details table plan cells
         slsc[j] = document.all["S" + i + "V" + j + "A"];
         mkdc[j] = document.all["M" + i + "V" + j + "A"];
         invc[j] = document.all["I" + i + "V" + j + "A"];

         // details table percent cells
         slsp[j] = document.all["S" + i + "V" + j + "P"];
         mkdp[j] = document.all["M" + i + "V" + j + "P"];
         invp[j] = document.all["I" + i + "V" + j + "P"];
      }

         SlsInp[i] = slsi;
         MkdInp[i] = mkdi;
         InvInp[i] = invi;

         // details table plan cells
         SlsCell[i] = slsc;
         MkdCell[i] = mkdc;
         InvCell[i] = invc;

         // details table percent cells
         SlsPrcCell[i] = slsp;
         MkdPrcCell[i] = mkdp;
         InvPrcCell[i] = invp;
   }

   // total input fields
   for(var i=0; i < NumOfVal; i++)
   {
     if(AlwChg==Values[i])
     {
        // total input fields
        TotSlsInp[i] = document.all["TS" + i];
        TotMkdInp[i] = document.all["TM" + i];
        TotInvInp[i] = document.all["TI" + i];
     }

      // total table plan cells
      TotSlsCell[i] = document.all["TS" + i + "A"];
      TotMkdCell[i] = document.all["TM" + i + "A"];
      TotInvCell[i] = document.all["TI" + i + "A"];

      // total table percent cells
      TotSlsPrcCell[i] = document.all["TS" + i + "P"];
      TotMkdPrcCell[i] = document.all["TM" + i + "P"];
      TotInvPrcCell[i] = document.all["TI" + i + "P"];
   }
}
//--------------------------------------------------------
// populate last  8  column cells objects in array
//--------------------------------------------------------
function setLast8ColArrays()
{
   for(var i=0; i < NumOfMon; i++)
   {
      var imu = new Array();
      var cmu = new Array();
      var mrm = new Array();
      var mmu = new Array();
      var mds = new Array();
      var sof = new Array();
      var mvi = new Array();
      var gri = new Array();

      for(var j=0; j < NumOfVal; j++)
      {
         imu[j] = document.all["IMU" + i + "V" + j];
         cmu[j] = document.all["CMU" + i + "V" + j];
         mrm[j] = document.all["MRM" + i + "V" + j];
         mmu[j] = document.all["MMU" + i + "V" + j];
         mds[j] = document.all["MDS" + i + "V" + j];
         sof[j] = document.all["SOF" + i + "V" + j];
         mvi[j] = document.all["MVI" + i + "V" + j];
         gri[j] = document.all["GRI" + i + "V" + j];
      }
         ImuCell[i] = imu;
         CmuCell[i] = cmu;
         MrmCell[i] = mrm;
         MmuCell[i] = mmu;
         MdsCell[i] = mds;
         SofCell[i] = sof;
         MviCell[i] = mvi;
         GriCell[i] = gri;
   }

   // total input fields
   for(var i=0; i < NumOfVal; i++)
   {
      // total input fields
      TotImuCell[i] = document.all["TIMU" + i];
      TotCmuCell[i] = document.all["TCMU" + i];
      TotMrmCell[i] = document.all["TMRM" + i];
      TotMmuCell[i] = document.all["TMMU" + i];
      TotMdsCell[i] = document.all["TMDS" + i];
      TotSofCell[i] = document.all["TSOF" + i];
      TotMviCell[i] = document.all["TMVI" + i];
      TotGriCell[i] = document.all["TGRI" + i];
   }

}

//--------------------------------------------------------
// populate BOM fields
//--------------------------------------------------------
function setBOMInvArrays()
{
   for(var i=0; i < NumOfMon; i++)
   {
      var bom = new Array();
      var bomv = new Array();

      for(var j=0; j < NumOfVal; j++)
      {
        bom[j] = document.all["BOM" + i + "V" + j];
        if(i==0)
        {
           bom[j].innerHTML = format(LdgInv[j]);
           bomv[j] = LdgInv[j];
        }
        else
        {
          bom[j].innerHTML = format(PlanInv[j][i-1]);
          bomv[j] = PlanInv[j][i-1];
        }
      }

      BomCell[i] = bom;
      BomVal[i] = bomv;
   }
}
//--------------------------------------------------------
// populate Required for plan, Open to receive
//--------------------------------------------------------
function setRfp_Otr_Otb_Ocf()
{
   var rfp = null;
   var totr = new Array(NumOfVal);
   var otr = null;
   var toto = new Array(NumOfVal);
   var otb = null;
   var totb = new Array(NumOfVal);
   var ocf = null;
   var savocf = null;
   var amt = 0;

   for(var i=0; i < NumOfVal; i++) { totr[i] = 0; toto[i] = 0; totb[i] = 0;}

   for(var i=0; i < NumOfMon; i++)
   {
      for(var j=0; j < NumOfVal; j++)
      {
        //req for plan
        rfp = document.all["RFP" + i + "V" + j];
        amt = eval(PlanSls[j][i]) + eval(PlanMkd[j][i]) + eval(PlanInv[j][i]);
        if(StartMon==1 && i==0) amt = amt - PlanSls[j][0] * Percent  - LdgMkd[j];
        amt = eval(amt.toFixed(0));
        rfp.innerHTML = format(amt);
        totr[j] += amt;

        //open to receive
        otr = document.all["OTR" + i + "V" + j];
        amt = amt - eval(BomVal[i][j]);
        otr.innerHTML = format(amt);
        toto[j] += amt;

        //open to buy
        otb = document.all["OTB" + i + "V" + j];
        amt = amt - eval(PurchOrd[j][i]);
        otb.innerHTML = format(amt);
        totb[j] += amt;

        //open to buy carry forward
        ocf = document.all["OCF" + i + "V" + j];
        if (i > 0) amt = amt + savocf;
        ocf.innerHTML = format(amt);
        savocf = amt;
      }
   }

   //total
   for(var i=0; i < NumOfVal; i++)
   {
      document.all["TRFP" + i].innerHTML = format(totr[i]);
      document.all["TOTR" + i].innerHTML = format(toto[i]);
      document.all["TOTB" + i].innerHTML = format(totb[i]);
   }
}
//--------------------------------------------------------
// calculate Plan vs Actual
//--------------------------------------------------------
function clcPlanVsActual()
{
   var totps = new Array(NumOfVal);
   var totpm = new Array(NumOfVal);
   var totpi = new Array(NumOfVal);
   var totts = new Array(NumOfVal);
   var tottm = new Array(NumOfVal);
   var totti = new Array(NumOfVal);

   // calculate percentage for details
   for(var i=0; i < NumOfMon; i++)
   {
      for(var j=0; j < NumOfVal; j++)
      {
        if(ActSls[j][i] != 0) SlsPrcCell[i][j].innerHTML = ((PlanSls[j][i] / ActSls[j][i] - 1) * 100).toFixed(1) + "%";
        else SlsPrcCell[i][j].innerHTML = 0;
        if(ActMkd[j][i] != 0) MkdPrcCell[i][j].innerHTML = ((PlanMkd[j][i] / ActMkd[j][i] - 1) * 100).toFixed(1) + "%";
        else MkdPrcCell[i][j].innerHTML = 0;
        if(ActInv[j][i] != 0) InvPrcCell[i][j].innerHTML = ((PlanInv[j][i] / ActInv[j][i] - 1) * 100).toFixed(1) + "%";
        else InvPrcCell[i][j].innerHTML = 0;

        // initialize totals
        if (isNaN(totps[j])) { totps[j]=0; totts[j]=0; totpm[j]=0; tottm[j]=0; totpi[j]=0; totti[j]=0; }

        totps[j] = eval(totps[j]) + eval(PlanSls[j][i]);
        totpm[j] = eval(totpm[j]) + eval(PlanMkd[j][i]);
        totpi[j] = eval(totpi[j]) + eval(PlanInv[j][i]);

        totts[j] = eval(totts[j]) + eval(ActSls[j][i]);
        tottm[j] = eval(tottm[j]) + eval(ActMkd[j][i]);
        totti[j] = eval(totti[j]) + eval(ActInv[j][i]);
      }
   }


  for(var i=0; i < NumOfVal; i++)
  {
      if(totts[i] != 0) TotSlsPrcCell[i].innerHTML = ((totps[i] / totts[i] - 1) * 100).toFixed(1) + "%";
      else TotSlsPrcCell[i].innerHTML = 0;
      if(tottm[i] != 0) TotMkdPrcCell[i].innerHTML = ((totpm[i] / tottm[i] - 1) * 100).toFixed(1) + "%";
      else TotMkdPrcCell[i].innerHTML = 0;
      if(totti[i] != 0) TotInvPrcCell[i].innerHTML = ((totpi[i] / totti[i] - 1) * 100).toFixed(1) + "%";
      else TotInvPrcCell[i].innerHTML = 0;
  }
}
//--------------------------------------------------------
// fold/unfold last  8 columns
//--------------------------------------------------------
function showTYPLANS()
{
   var visio;
   if(fold) { visio = "block"; }
   else { visio = "none"; }

   document.all.TYPLANS.style.display=visio;
   document.all.THIMU.style.display=visio;
   document.all.THCMU.style.display=visio;
   document.all.THMRM.style.display=visio;
   document.all.THMMU.style.display=visio;
   document.all.THMDS.style.display=visio;
   document.all.THSOF.style.display=visio;
   document.all.THMVI.style.display=visio;
   document.all.THGRI.style.display=visio;

   for(var i=0; i < NumOfMon; i++)
   {
      for(var j=0; j < NumOfVal; j++)
      {
        ImuCell[i][j].style.display = visio;
        CmuCell[i][j].style.display = visio;
        MrmCell[i][j].style.display = visio;
        MmuCell[i][j].style.display = visio;
        MdsCell[i][j].style.display = visio;
        SofCell[i][j].style.display = visio;
        MviCell[i][j].style.display = visio;
        GriCell[i][j].style.display = visio;
      }
   }

   for(var i=0; i < NumOfVal; i++)
   {
      TotImuCell[i].style.display = visio;
      TotCmuCell[i].style.display = visio;
      TotMrmCell[i].style.display = visio;
      TotMmuCell[i].style.display = visio;
      TotMdsCell[i].style.display = visio;
      TotSofCell[i].style.display = visio;
      TotMviCell[i].style.display = visio;
      TotGriCell[i].style.display = visio;
   }

   fold = !fold;
}
//--------------------------------------------------------
// do not allow to entry for current month
//--------------------------------------------------------
function setCurMonInpInvisible()
{
   if(StartMon == 1)
   {
      for(var j=0; j < NumOfVal; j++)
      {
         if(AlwChg==Values[j])
         {
            // details table plan cells
            SlsInp[0][j].style.visibility = "hidden";
            MkdInp[0][j].style.visibility = "hidden";
            InvInp[0][j].style.visibility = "hidden";
         }
      }
   }
}
//--------------------------------------------------------
// calculate new Plans
//--------------------------------------------------------
function clcNewPlan()
{
   // check total
   for(var i=0; i < NumOfVal; i++)
   {
     if(AlwChg==Values[i])
     {
         if(TotSlsInp[i].value.trim()!="") setAllNewPlan(TotSlsInp[i].value.trim(), SlsCell, PlanSls, TotSlsCell);

         if(TotMkdInp[i].value.trim()!="") setAllNewPlan(TotMkdInp[i].value.trim(), MkdCell, PlanMkd, TotMkdCell);
         if(TotInvInp[i].value.trim()!="") setAllNewPlan(TotInvInp[i].value.trim(), InvCell, PlanInv, TotInvCell);
     }
   }
}
//--------------------------------------------------------
// apply Last Year Actual
//--------------------------------------------------------
function applyLYActual()
{
   document.all.Calc.style.visibility="hidden"
   if(document.all.Save.style.visibility=="hidden") document.all.Save.style.visibility="visible"

   var totps = new Array(NumOfVal);
   var totpm = new Array(NumOfVal);
   var totpi = new Array(NumOfVal);

   // check monthly plans
   for(var i=0; i < NumOfMon; i++)
   {
      for(var j=0; j < NumOfVal; j++)
      {
        if(AlwChg==Values[j] && (StartMon==1 && i > 0 || StartMon > 1))
        {
          SlsInp[i][j].disabled = true;
          MkdInp[i][j].disabled = true;
          InvInp[i][j].disabled = true;

          SlsCell[i][j].innerHTML = format(ActSls[j][i]);
          MkdCell[i][j].innerHTML = format(ActMkd[j][i]);
          InvCell[i][j].innerHTML = format(ActInv[j][i]);

          // set percents to 0
          SlsPrcCell[i][j].innerHTML = "0%";
          MkdPrcCell[i][j].innerHTML = "0%";
          InvPrcCell[i][j].innerHTML = "0%";

          // total
          if (isNaN(totps[j])) { totps[j]=0; totpm[j]=0; totpi[j]=0;}
          totps[j] = eval(totps[j]) + eval(ActSls[j][i]);
          totpm[j] = eval(totpm[j]) + eval(ActMkd[j][i]);
          totpi[j] = eval(totpi[j]) + eval(ActInv[j][i]);
        }
      }
   }

   for(var i=0; i < NumOfVal; i++)
   {
     if(AlwChg==Values[j])
     {
        TotSlsCell[i].innerHTML = totps[i];
        TotMkdCell[i].innerHTML = totpm[i];
        TotInvCell[i].innerHTML = totpi[i];
        // set percents to 0
        TotSlsPrcCell[i].innerHTML = "0%";
        TotMkdPrcCell[i].innerHTML = "0%";
        TotInvPrcCell[i].innerHTML = "0%";
     }
   }

   ApplyHist = true;
}

//--------------------------------------------------------
// reset new Plans
//--------------------------------------------------------
function saveNewPlan()
{

   var url = "PlanSave.jsp"
      + "?DIVISION=" + Division
      + "&DEPARTMENT=" + Department
      + "&CLASS=" + Class
      + "&StartMon=" + StartMon
      + "&NumMon=" + NumMon
      + "&RetVal=" + RetVal
      + "&CstVal=" + CstVal
      + "&UntVal=" + UntVal

   // check store selected for current inquiry
   for(var i=0; i < SelStr.length; i++) { url += "&STORE=" + SelStr[i]; }


   // save plans applied from last year actual sales
   if(ApplyHist){ url += "&Hist=1"; }
   else
   {
      for(var i=0; i < NumOfMon; i++)
      {
        for(var j=0; j < NumOfVal; j++)
        {
          if(AlwChg==Values[j])
          {
             url += "&Sls=" + SlsCell[i][j].innerHTML
                 + "&Mkd=" + MkdCell[i][j].innerHTML
                 + "&Inv=" + InvCell[i][j].innerHTML
          }
        }
      }
   }

   //alert(url)
   //window.location.href=url;
   window.frame1.location=url;

}
//--------------------------------------------------------
// re-display Planning screen
//--------------------------------------------------------
function redisplayPlanning()
{
   alert("here")
   location.reload();
}
//--------------------------------------------------------
// reset new Plans
//--------------------------------------------------------
function resetNewPlan()
{
   document.all.Calc.style.visibility="visible"
   document.all.Save.style.visibility="hidden"

   PlanSls = SavePlanSls;
   PlanInv = SavePlanInv;
   PlanMkd = SavePlanMkd;

   // check total
   for(var i=0; i < NumOfVal; i++)
   {
         TotSlsInp[i].value = "";
         TotMkdInp[i].value = "";
         TotInvInp[i].value = "";
   }

   // check monthly plans
   for(var i=0; i < NumOfMon; i++)
   {
      for(var j=0; j < NumOfVal; j++)
      {
        SlsInp[i][j].value = "";
        MkdInp[i][j].value = "";
        InvInp[i][j].value = "";
        SlsInp[i][j].disabled = false;
        MkdInp[i][j].disabled = false;
        InvInp[i][j].disabled = false;
        SlsCell[i][j].innerHTML = format(PlanSls[j][i]);
        InvCell[i][j].innerHTML = format(PlanInv[j][i]);
        MkdCell[i][j].innerHTML = format(PlanMkd[j][i]);
      }
   }

   // calculate Plan vs Actual
   clcPlanVsActual();

   // set BOM inventory
   setBOMInvArrays();

   // set Required for Plan inventory
   setRfp_Otr_Otb_Ocf();

   ApplyHist = false;
}
//--------------------------------------------------------
// set All new plans
//--------------------------------------------------------
function setAllNewPlan(inc, planCell, planAmt, totCell)
{
   if(document.all.Save.style.visibility=="hidden") document.all.Save.style.visibility="visible"

   for(var i=0; i < NumOfVal; i++)
   {
      if(inc.trim().substring(0, 1) != "$" ) clcAllPlanByPercent(eval(inc.trim()), planCell, planAmt, totCell);
   }
}

//--------------------------------------------------------
// set All new plans
//--------------------------------------------------------
function clcAllPlanByPercent(prc, planCell, planAmt, totCell)
{
   var tot = new Array(NumOfVal);
   var amt = 0;

   if (prc >= 0 ) prc = 1 + prc/100;
   else prc = 1 - prc * (-1)/100;

   for(var i=0; i < NumOfMon; i++)
   {
      if (StartMon==1 && i > 0 || StartMon > 1)
      {
         for(var j=0; j < NumOfVal; j++)
         {
            amt = (planAmt[j][i] * prc).toFixed(0);
            planCell[i][j].innerHTML = format(amt);
            if(isNaN(tot[j])) tot[j] = 0;
            tot[j] = eval(tot[j]) + eval(amt);
         }
      }
   }

   // populate new total
   for(var j=0; j < NumOfVal; j++)
   {
     totCell[j].innerHTML = tot[j];
   }
}
//--------------------------------------------------------
// show selection screen
//--------------------------------------------------------
function selectPanel()
{
   var html = "<table border='0'>"
       + "<tr style='font-size:10px'>"
         + "<td style='text-align:right' nowrap>Division (<a href='javascript: rtvDivDptCls(1)'>Prompt</a>): </td>"
         + "<td><input name='DIVISION' value='" + Division + "' class='Small' size='3' maxlength='3'><br>"
         + "<select name='DivSel' onchange='doDivSelect(this.selectedIndex);' class='Small' style='visibility:hidden'></select></td>"
         + "<td style='text-align:right'>&nbsp;&nbsp; Department: </td>"
         + "<td><input name='DEPARTMENT' value='" + Department + "' class='Small' size='3' maxlength='3'><br>"
         + "<select name='DptSel' onchange= 'doDptSel(this.selectedIndex)' class='Small' style='visibility:hidden'></select></td>"
       + "</tr>"
       + "<tr style='font-size:10px'>"
         + "<td style='text-align:right' nowrap>Class (<a href='javascript: rtvDivDptCls(2)'>Prompt</a>): </td>"
         + "<td><input name='CLASS' value='" + Class + "' class='Small' size='4' maxlength='4'><br>"
         + "<select name='ClsSel' onchange= 'doClsSelect(this.selectedIndex)' class='Small' style='visibility:hidden'></select></td>"
       + "</tr>"
       + "<tr style='font-size:10px'>"
       + "<td style='text-align:right'>Store: </td>"
       + "<td colspan='3'>"

       for(var i=0; i < Store.length; i++)
       {
         html += "<input name='STORE' type='checkbox' value='" + Store[i] + "' class='Small'>" + Store[i]
         if(i == 7 || i == 14) html += "<br>";
       }

       html += "</td></tr>"
       + "<tr style='font-size:10px'>"
         + "<td style='text-align:right' rowspan='2'>Value: </td>"
         + "<td rowspan='2'>"
           + "<input name='RetVal' type='checkbox' value='1' class='Small' size='4' maxlength='4'>Retail<br>"
           + "<input name='CstVal' type='checkbox' value='1' class='Small' size='4' maxlength='4'>Cost<br>"
           + "<input name='UntVal' type='checkbox' value='1' class='Small' size='4' maxlength='4'>Unit<br>"
         + "</td>"
         + "<td style='text-align:right;' nowrap>Start Month:</td>"
         + "<td><input name='StartMon' value='" + StartMon + "' class='Small' size='2' maxlength='2'></td>"
       + "</tr>"
       + "<tr style='font-size:10px'>"
         + "<td style='text-align:right;' nowrap>Number of Months:</td>"
         + "<td><input name='NumMon' value='" + NumMon + "' class='Small' size='2' maxlength='2'></td>"
       + "</tr>"

       + "<tr style='font-size:10px'>"
         + "<td colspan='4' style='text-align:center' >"
           + "<button onClick='hidePanel()' class='Small'>Close</button>&nbsp;"
           + "<button onClick='validateReport(false)' class='Small'>Submit</button>&nbsp;"
           + "<button onClick='validateReport(true)' class='Small'>Submit in New Window</button>"
         + "</td>"
       + "</tr>"

       + "</table>"
   document.all.promo.innerHTML = html;
   document.all.promo.style.pixelLeft= 20;
   document.all.promo.style.pixelTop= 20;
   document.all.promo.style.visibility = "visible";
   checkSelValues();
}
//--------------------------------------------------------
// Check selected values
//--------------------------------------------------------
function checkSelValues()
{
   if(RetVal=="1") document.all.RetVal.checked=true;
   if(CstVal=="1") document.all.CstVal.checked=true;
   if(UntVal=="1") document.all.UntVal.checked=true;

   // check store selected for current inquiry
   for(var i=0; i < Store.length; i++)
   {
      for(var j=0; j < SelStr.length; j++)
      {
         if(SelStr[j] == Store[i]) { document.all.STORE[i].checked = true; }
      }
   }
}
//--------------------------------------------------------
// validate report with new selection
//--------------------------------------------------------
function validateReport(newwin)
{
  var msg = " ";
  var error = false;
  var div = document.all.DIVISION.value.toUpperCase();
  var dpt = document.all.DEPARTMENT.value.toUpperCase();
  var cls = document.all.CLASS.value.toUpperCase();
  var ret = document.all.RetVal.checked;
  var cst = document.all.CstVal.checked;
  var unt = document.all.UntVal.checked;
  var start = document.all.StartMon.value;
  var mon = document.all.NumMon.value;
  var str = new Array();
  var strchk = false;

  for(var i=0, j=0; i < document.all.STORE.length; i++)
  {
     if(document.all.STORE[i].checked) { str[j++] = document.all.STORE[i].value; strchk=true}
  }

  // validate division
  if (div!="ALL" && isNaN(div) || div!="ALL" && (div < 1 || div > 99))
  {
     msg += "\nPlease, enter correct division number."
     error = true;
  }
  // validate department
  if (dpt!="ALL" && isNaN(dpt) || dpt!="ALL" && (dpt < 1 || dpt > 999))
  {
     msg += "\nPlease, enter correct department number."
     error = true;
  }
  // validate class
  if (cls!="ALL" && isNaN(cls) || cls!="ALL" && (cls < 1 || cls > 9999))
  {
     msg += "\nPlease, enter correct class number."
     error = true;
  }

  // validate store
  if (!strchk)
  {
     msg += "\nPlease, check at least 1 store."
     error = true;
  }

  // validate values
  if (!ret && !cst && !unt)
  {
     msg += "\nPlease, check at least 1 value."
     error = true;
  }

  // validate start month
  if (isNaN(start) || eval(start) < 1 || eval(start) > 12)
  {
     msg += "\nPlease, enter correct number of month: from 1 to 12."
     error = true;
  }
  // validate number of months
  if (isNaN(start) || eval(start) < 1 || eval(start) > 12)
  {
     msg += "\nPlease, enter correct number of month: from 1 to 12."
     error = true;
  }


  // show error or submit report
  if(error) alert(msg);
  else submitReport(div, dpt, cls, str, ret, cst, unt, start, mon, newwin);
}
//--------------------------------------------------------
// submit report with new selection
//--------------------------------------------------------
function submitReport(div, dpt, cls, str, ret, cst, unt, start, mon, newwin)
{
   var url = "Planning.jsp"
     + "?DIVISION=" + div
     + "&DEPARTMENT=" + dpt
     + "&CLASS=" + cls

     for(var i=0; i < str.length; i++) { url += "&STORE=" + str[i]; }

   url += "&StartMon=" + start
     + "&NumMon=" + mon
   if(ret) url += "&RetVal=1"
   if(cst) url += "&CstVal=1"
   if(unt) url += "&UntVal=1"

   // close selection panel
   hidePanel();

   //alert(url);
   if (newwin)
   {
     var WindowName = 'Planning' + New++;
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
   document.all.promo.innerHTML = " ";
   document.all.promo.style.visibility = "hidden";
}
//--------------------------------------------------------
// retreive div, dpt, cls and str
//--------------------------------------------------------
function rtvDivDptCls(mode)
{
  var div = document.all.DIVISION.value.toUpperCase();
  var dpt = document.all.DEPARTMENT.value.toUpperCase();

  if(div.trim()=="") div ="ALL";
  if(dpt.trim()=="") dpt ="ALL";

  var url = 'DivDptClsSel.jsp?'
  if (mode==2)
  {
     url += "mode=" + mode
       + "&DIVISION=" + div
       + "&DEPARTMENT=" + dpt
  }
  else  { url += "mode=" + mode }

 //alert(url);
 //window.location.href = url;
 window.frame1.location = url;
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

//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, " "); }
    return s;
}
</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="FormatNumerics.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
  <div id="promo" class="Promo"></div>
<!-------------------------------------------------------------------->

    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
        <b>Retail Concepts, Inc
        <br>Planning</b>
      </td>
     </tr>

     <tr>
      <td ALIGN="Center" VALIGN="TOP" colspan=3>

      <b>Store: <%=sbStr.toString()%>
         &nbsp;&nbsp; Division: <%=sDivision%>
         &nbsp;&nbsp; Department: <%=sDepartment%>
         &nbsp;&nbsp; Class: <%=sClass%></b><br>

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="PlanningSel.jsp?mode=1">
            <font color="red" size="-1">Planning Selection</font></a>&#62;
          <font size="-1">This Page.</font>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <a href="javascript: selectPanel();">Report Parameters</a>
      &nbsp;&nbsp;
      <a href="javascript: showTYPLANS();">Fold/Unfold</a>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <p><h5>This Year Plan</h5>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
	  <th class="DataTable" rowspan="2">Month</th>
          <th class="DataTable" rowspan="2">R<br>C<br>U</th>
          <th class="DataTable" colspan="4">Sales<br>Plan</th>
          <th class="DataTable" colspan="4">Markdown<br>Plan</th>
          <th class="DataTable" colspan="4">EOM Inventory<br>Plan</th>
          <th class="DataTable" rowspan="2">Required<br>For<br>Plan</th>
          <th class="DataTable" rowspan="2">BOM<br>Inventory<br>Plan</th>
          <th class="DataTable" rowspan="2">Open<br>To<br>Receive</th>
          <th class="DataTable" rowspan="2">Purchase<br>Orders</th>
          <th class="DataTable" rowspan="2">Open<br>To<br>Buy</th>
          <th class="DataTable" rowspan="2">OTB<br>Carry<br>Forward</th>

          <th class="DataTable" rowspan="2">Gross<br>Profit</th>
          <th class="DataTable" rowspan="2">Average<br>Price</th>
          <th class="DataTable" colspan="8" id="TYPLANS">TY Plans</th>

        </tr>
        <tr>
          <th class='DataTable'>LY Actual</th>
	  <th class='DataTable'>%/+/-</th>
          <th class='DataTable'>TY Plan</th>
          <th class='DataTable'>Plan vs.<br>Act</th>

          <th class='DataTable'>LY Actual</th>
	  <th class='DataTable'>%/+/-</th>
          <th class='DataTable'>TY Plan</th>
          <th class='DataTable'>Plan vs.<br>Act</th>

          <th class='DataTable'>LY Actual</th>
	  <th class='DataTable'>%/+/-</th>
          <th class='DataTable'>TY Plan</th>
          <th class='DataTable'>Plan vs.<br>Act</th>

          <th class="DataTable" id="THIMU">IMU</th>
          <th class="DataTable" id="THCMU">CMU</th>
          <th class="DataTable" id="THMRM">MRM</th>
          <th class="DataTable" id="THMMU">MMU</th>
          <th class="DataTable" id="THMDS">Mkd/<br>Sls</th>
          <th class="DataTable" id="THSOF">Sell<br>Off</th>
          <th class="DataTable" id="THMVI">MVI</th>
          <th class="DataTable" id="THGRI">GMROI</th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfMon; i++) {%>

             <%for(int j=0; j < iNumOfVal; j++) {%>
                <tr class="<%=sCSSCls%>">
                   <%if(j==0) {%>
                     <td class="DataTable2" rowspan="<%=iNumOfVal%>" nowrap><%=sMonName[i]%></td>
                   <%}%>
                   <td class="DataTable"><%=sValue[j]%></td>
                   <td class="DataTable"><%=fmt.getFormatedNum(sActSls[j][i], "###,###,###")%></td>
                   <td class="DataTable">
                     <%if(sAlwChg.equals(sValue[j])){%><input name="S<%=i%>V<%=j%>" class="Small" size=10 maxlength=10><%}%></td>
                   <td class="DataTable" id="S<%=i%>V<%=j%>A" ><%=fmt.getFormatedNum(sPlanRet[j][i].trim(), "###,###,###")%></td>
                   <td class="DataTable" id="S<%=i%>V<%=j%>P" nowrap>&nbsp;</td>

                   <td class="DataTable"><%=fmt.getFormatedNum(sActMkd[j][i], "###,###,###")%></td>
                   <td class="DataTable" ><%if(sAlwChg.equals(sValue[j])){%><input name="M<%=i%>V<%=j%>" class="Small" size=10 maxlength=10><%}%></td>
                   <td class="DataTable" id="M<%=i%>V<%=j%>A"><%=fmt.getFormatedNum(sPlanMkd[j][i], "###,###,###")%></td>
                   <td class="DataTable" id="M<%=i%>V<%=j%>P" nowrap>&nbsp;</td>
                   <td class="DataTable"><%=fmt.getFormatedNum(sActInv[j][i], "###,###,###")%></td>
                   <td class="DataTable"><%if(sAlwChg.equals(sValue[j])){%><input name="I<%=i%>V<%=j%>" class="Small" size=10 maxlength=10><%}%></td>
                   <td class="DataTable" id="I<%=i%>V<%=j%>A"><%=fmt.getFormatedNum(sPlanInv[j][i], "###,###,###")%></td>
                   <td class="DataTable" id="I<%=i%>V<%=j%>P" nowrap>&nbsp;</td>

                   <td class="DataTable" id="RFP<%=i%>V<%=j%>"></td>
                   <td class="DataTable" id="BOM<%=i%>V<%=j%>"></td>
                   <td class="DataTable" id="OTR<%=i%>V<%=j%>"></td>
                   <td class="DataTable"><%=sPurchOrd[j][i]%></td>
                   <td class="DataTable" id="OTB<%=i%>V<%=j%>"></td>
                   <td class="DataTable" id="OCF<%=i%>V<%=j%>"></td>

                   <td class="DataTable"><%=sPlanGrm[j][i]%></td>
                   <td class="DataTable"><%=sPlanAvr[j][i]%></td>
                   <td class="DataTable" id="IMU<%=i%>V<%=j%>"><%=sPlanImu[j][i]%></td>
                   <td class="DataTable" id="CMU<%=i%>V<%=j%>"><%=sPlanCmu[j][i]%></td>
                   <td class="DataTable" id="MRM<%=i%>V<%=j%>"><%=sPlanMrm[j][i]%></td>
                   <td class="DataTable" id="MMU<%=i%>V<%=j%>"><%=sPlanMmu[j][i]%></td>
                   <td class="DataTable" id="MDS<%=i%>V<%=j%>"><%=sPlanMkdSls[j][i]%></td>
                   <td class="DataTable" id="SOF<%=i%>V<%=j%>"><%=sPlanSellOff[j][i]%></td>
                   <td class="DataTable" id="MVI<%=i%>V<%=j%>"><%=sPlanMvi[j][i]%></td>
                   <td class="DataTable" id="GRI<%=i%>V<%=j%>"><%=sPlanGmroi[j][i]%></td>
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

                <td class="DataTable"><%=sTotActSls[i]%></td>
                <td class="DataTable"><%if(sAlwChg.equals(sValue[i])){%><input id="TS<%=i%>" class="Small" size=10 maxlength=10><%}%></td>
                <td class="DataTable" id="TS<%=i%>A"><%=sTotPlnRet[i]%></td>
                <td class="DataTable" id="TS<%=i%>P" nowrap >&nbsp;</td>

                <td class="DataTable"><%=sTotActMkd[i]%></td>
                <td class="DataTable"><%if(sAlwChg.equals(sValue[i])){%><input id="TM<%=i%>" class="Small" size=10 maxlength=10><%}%></td>
                <td class="DataTable" id="TM<%=i%>A"><%=sTotPlnMkd[i]%></td>
                <td class="DataTable" id="TM<%=i%>P" nowrap>&nbsp;</td>

                <td class="DataTable"><%=sTotActInv[i]%></td>
                <td class="DataTable"><%if(sAlwChg.equals(sValue[i])){%><input id="TI<%=i%>" class="Small" size=10 maxlength=10><%}%></td>                <td class="DataTable" id="TI<%=i%>A"><%=sTotPlnInv[i]%></td>
                <td class="DataTable" id="TI<%=i%>P" nowrap>&nbsp;</td>

                <td class="DataTable" id="TRFP<%=i%>"></td>
                <td class="DataTable">&nbsp;</td>
                <td class="DataTable" id="TOTR<%=i%>"></td>
                <td class="DataTable"><%=sTotPurchOrd[i]%></td>
                <td class="DataTable" id="TOTB<%=i%>"></td>
                <td class="DataTable" id="TOCF<%=i%>"></td>

                <td class="DataTable"><%=sTotPlnGrm[i]%></td>
                <td class="DataTable"><%=sTotPlnAvr[i]%></td>
                <td class="DataTable" id="TIMU<%=i%>"><%=sTotPlnImu[i]%></td>
                <td class="DataTable" id="TCMU<%=i%>"><%=sTotPlnCmu[i]%></td>
                <td class="DataTable" id="TMRM<%=i%>"><%=sTotPlnMrm[i]%></td>
                <td class="DataTable" id="TMMU<%=i%>"><%=sTotPlnMmu[i]%></td>
                <td class="DataTable" id="TMDS<%=i%>"><%=sTotPlnMkdSls[i]%></td>
                <td class="DataTable" id="TSOF<%=i%>"><%=sTotPlnSellOff[i]%></td>
                <td class="DataTable" id="TMVI<%=i%>"><%=sTotPlnMvi[i]%></td>
                <td class="DataTable" id="TGRI<%=i%>"><%=sTotPlnGmroi[i]%></td>
              </tr>
           <%}%>
      </table>
      <br>
        <button name="Apply" onClick="applyLYActual()">Apply LY Actual</button>&nbsp;&nbsp;
        <button name="Calc" onClick="clcNewPlan()">Calc</button>&nbsp;&nbsp;
        <button name="Reset" onClick="resetNewPlan()">Reset</button>&nbsp;&nbsp;
        <button name="Save" onClick="saveNewPlan()">Save</button>

      <!-------------------------------------------------------------------->
      <!----------------------- end of plan table -------------------------->
      <!-------------------------------------------------------------------->
      <!----------------- beginning of Last Year table --------------------->
      <!-------------------------------------------------------------------->
      <p><h5>Prior 13 - 24 Months Actual</h5>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
	  <th class="DataTable">Month</th>
          <th class="DataTable">R<br>C<br>U</th>
          <th class="DataTable">Monthly<br>Sales</th>
          <th class="DataTable">Monthly<br>Markdown</th>
          <th class="DataTable">Monthly<br>Inventory</th>
          <th class="DataTable">Gross<br>Profit</th>
          <th class="DataTable">Monthly<br>Purchases</th>
          <th class="DataTable">Average<br>Price</th>
          <th class="DataTable">IMU</th>
          <th class="DataTable">CMU</th>
          <th class="DataTable">MRM</th>
          <th class="DataTable">MMU</th>
          <th class="DataTable">Mkd/<br>Sls</th>
          <th class="DataTable">Sell<br>Off</th>
          <th class="DataTable">MVI</th>
          <th class="DataTable">GMROI</th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfMon; i++) {%>

             <%for(int j=0; j < iNumOfVal; j++) {%>
                <tr class="<%=sCSSCls%>">
                   <%if(j==0) {%>
                     <td class="DataTable2" rowspan="<%=iNumOfVal%>"><%=sLyMon[i]%></td>
                   <%}%>
                   <td class="DataTable"><%=sValue[j]%></td>
                   <td class="DataTable"><%=sLySls[j][i]%></td>
                   <td class="DataTable"><%=sLyMkd[j][i]%></td>
                   <td class="DataTable"><%=sLyEin[j][i]%></td>
                   <td class="DataTable"><%=sLyGrm[j][i]%></td>
                   <td class="DataTable"><%=sLyPrh[j][i]%></td>
                   <td class="DataTable"><%=sLyAvr[j][i]%></td>
                   <td class="DataTable"><%=sLyImu[j][i]%></td>
                   <td class="DataTable"><%=sLyCmu[j][i]%></td>
                   <td class="DataTable"><%=sLyMrm[j][i]%></td>
                   <td class="DataTable"><%=sLyMmu[j][i]%></td>
                   <td class="DataTable"><%=sLyMkdSls[j][i]%></td>
                   <td class="DataTable"><%=sLySellOff[j][i]%></td>
                   <td class="DataTable"><%=sLyMvi[j][i]%></td>
                   <td class="DataTable"><%=sLyGmroi[j][i]%></td>
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
                <td class="DataTable"><%=sTotLyRet[i]%></td>
                <td class="DataTable"><%=sTotLyMkd[i]%></td>
                <td class="DataTable"><%=sTotLyInv[i]%></td>
                <td class="DataTable"><%=sTotLyGrm[i]%></td>
                <td class="DataTable"><%=sTotLyPrh[i]%></td>
                <td class="DataTable"><%=sTotLyAvr[i]%></td>
                <td class="DataTable"><%=sTotLyImu[i]%></td>
                <td class="DataTable"><%=sTotLyCmu[i]%></td>
                <td class="DataTable"><%=sTotLyMrm[i]%></td>
                <td class="DataTable"><%=sTotLyMmu[i]%></td>
                <td class="DataTable"><%=sTotLyMkdSls[i]%></td>
                <td class="DataTable"><%=sTotLySellOff[i]%></td>
                <td class="DataTable"><%=sTotLyMvi[i]%></td>
                <td class="DataTable"><%=sTotLyGmroi[i]%></td>
              </tr>
           <%}%>
      </table>
      <!-------------------------------------------------------------------->
      <!--------------------- end of Last Year table ----------------------->
      <!-------------------------------------------------------------------->
      <!----------------- beginning of This Year table --------------------->
      <!-------------------------------------------------------------------->
      <p><h5>Prior 1 - 12 Months Actual</h5>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
	  <th class="DataTable">Month</th>
          <th class="DataTable">R<br>C<br>U</th>
          <th class="DataTable">Monthly<br>Sales</th>
          <th class="DataTable">Monthly<br>Markdown</th>
          <th class="DataTable">Monthly<br>Inventory</th>
          <th class="DataTable">Gross<br>Profit</th>
          <th class="DataTable">Monthly<br>Purchases</th>
          <th class="DataTable">Average<br>Price</th>
          <th class="DataTable">IMU</th>
          <th class="DataTable">CMU</th>
          <th class="DataTable">MRM</th>
          <th class="DataTable">MMU</th>
          <th class="DataTable">Mkd/<br>Sls</th>
          <th class="DataTable">Sell<br>Off</th>
          <th class="DataTable">MVI</th>
          <th class="DataTable">GMROI</th>
        </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfMon; i++) {%>

             <%for(int j=0; j < iNumOfVal; j++) {%>
                <tr class="<%=sCSSCls%>">
                   <%if(j==0) {%>
                     <td class="DataTable2" rowspan="<%=iNumOfVal%>"><%=sTyMon[i]%></td>
                   <%}%>
                   <td class="DataTable"><%=sValue[j]%></td>
                   <td class="DataTable"><%=fmt.getFormatedNum(sTySls[j][i], "###,###,###")%></td>
                   <td class="DataTable"><%=fmt.getFormatedNum(sTyMkd[j][i], "###,###,###")%></td>
                   <td class="DataTable"><%=fmt.getFormatedNum(sTyEin[j][i], "###,###,###")%></td>
                   <td class="DataTable"><%=sTyGrm[j][i]%></td>
                   <td class="DataTable"><%=sTyPrh[j][i]%></td>
                   <td class="DataTable"><%=sTyAvr[j][i]%></td>
                   <td class="DataTable"><%=sTyImu[j][i]%></td>
                   <td class="DataTable"><%=sTyCmu[j][i]%></td>
                   <td class="DataTable"><%=sTyMrm[j][i]%></td>
                   <td class="DataTable"><%=sTyMmu[j][i]%></td>
                   <td class="DataTable"><%=sTyMkdSls[j][i]%></td>
                   <td class="DataTable"><%=sTySellOff[j][i]%></td>
                   <td class="DataTable"><%=sTyMvi[j][i]%></td>
                   <td class="DataTable"><%=sTyGmroi[j][i]%></td>
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
                <td class="DataTable"><%=sTotTyRet[i]%></td>
                <td class="DataTable"><%=sTotTyMkd[i]%></td>
                <td class="DataTable"><%=sTotTyInv[i]%></td>
                <td class="DataTable"><%=sTotTyGrm[i]%></td>
                <td class="DataTable"><%=sTotTyPrh[i]%></td>
                <td class="DataTable"><%=sTotTyAvr[i]%></td>
                <td class="DataTable"><%=sTotTyImu[i]%></td>
                <td class="DataTable"><%=sTotTyCmu[i]%></td>
                <td class="DataTable"><%=sTotTyMrm[i]%></td>
                <td class="DataTable"><%=sTotTyMmu[i]%></td>
                <td class="DataTable"><%=sTotTyMkdSls[i]%></td>
                <td class="DataTable"><%=sTotTySellOff[i]%></td>
                <td class="DataTable"><%=sTotTyMvi[i]%></td>
                <td class="DataTable"><%=sTotTyGmroi[i]%></td>
              </tr>
           <%}%>
      </table>
 <!--------------------- end of This Year table ----------------------->

  </table>
 </body>
</html>
