<%@ page import="agedanalysis.PlanSps, rciutility.FormatNumericValue, java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("PLAN") == null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PlanSps.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   String [] sStore = request.getParameterValues("STORE");
   String [] sDivision = request.getParameterValues("Div");
   String sDepartment = request.getParameter("DEPARTMENT");
   String sClass = request.getParameter("CLASS");
   String sChgPlan = request.getParameter("AlwChg");
   String sResult = request.getParameter("Result");

   if(sClass == null) sClass = "ALL";

   //System.out.println(sStore.length + " " + sDivision + " " + sDepartment + " " + sClass + " " + sChgPlan);
   PlanSps plans = new PlanSps(sStore, sDivision, sDepartment, sClass, sChgPlan);

int iNumOfYr = plans.getNumOfYr();
    int iNumOfMon = plans.getNumOfMon();

    String [] sMonName = plans.getMonName();
    String [] sYear = plans.getYear();
    String sCurMon = plans.getCurMon();
    String sCurYear = plans.getCurYear();
    String sPercent = plans.getPercent();
    String sNumWk = plans.getNumWk();

    String sDivName = plans.getDivName();
    String sDptName = plans.getDptName();
    String sClsName = plans.getClsName();

    // Javascript arrays
    String sMonNameJsa = plans.getMonNameJsa();
    String sYearJsa = plans.getYearJsa();

    // sales, inventory markdowns
    String sRetPlanSls = plans.getRetPlanSlsJsa(); // plan C
    String sRetPlanInv = plans.getRetPlanInvJsa();
    String sRetPlanMkd = plans.getRetPlanMkdJsa();
    String sCstPlanSls = plans.getCstPlanSlsJsa();
    String sCstPlanInv = plans.getCstPlanInvJsa();
    String sCstPlanMkd = plans.getCstPlanMkdJsa();
    String sUntPlanSls = plans.getUntPlanSlsJsa();
    String sUntPlanInv = plans.getUntPlanInvJsa();
    String sUntPlanMkd = plans.getUntPlanMkdJsa();

    String sRetPlanSlsA = plans.getRetPlanSlsAJsa(); // plan A
    String sRetPlanInvA = plans.getRetPlanInvAJsa();
    String sRetPlanMkdA = plans.getRetPlanMkdAJsa();
    String sCstPlanSlsA = plans.getCstPlanSlsAJsa();
    String sCstPlanInvA = plans.getCstPlanInvAJsa();
    String sCstPlanMkdA = plans.getCstPlanMkdAJsa();
    String sUntPlanSlsA = plans.getUntPlanSlsAJsa();
    String sUntPlanInvA = plans.getUntPlanInvAJsa();
    String sUntPlanMkdA = plans.getUntPlanMkdAJsa();

    String sRetPlanSlsB = plans.getRetPlanSlsBJsa(); // plan C
    String sRetPlanInvB = plans.getRetPlanInvBJsa();
    String sRetPlanMkdB = plans.getRetPlanMkdBJsa();
    String sCstPlanSlsB = plans.getCstPlanSlsBJsa();
    String sCstPlanInvB = plans.getCstPlanInvBJsa();
    String sCstPlanMkdB = plans.getCstPlanMkdBJsa();
    String sUntPlanSlsB = plans.getUntPlanSlsBJsa();
    String sUntPlanInvB = plans.getUntPlanInvBJsa();
    String sUntPlanMkdB = plans.getUntPlanMkdBJsa();

    // plan history
    String sRetPlanHstSls = plans.getRetPlanHstSlsJsa();
    String sRetPlanHstInv = plans.getRetPlanHstInvJsa();
    String sRetPlanHstMkd = plans.getRetPlanHstMkdJsa();
    String sCstPlanHstSls = plans.getCstPlanHstSlsJsa();
    String sCstPlanHstInv = plans.getCstPlanHstInvJsa();
    String sCstPlanHstMkd = plans.getCstPlanHstMkdJsa();
    String sUntPlanHstSls = plans.getUntPlanHstSlsJsa();
    String sUntPlanHstInv = plans.getUntPlanHstInvJsa();
    String sUntPlanHstMkd = plans.getUntPlanHstMkdJsa();

    // stock ledger
    String sLdgSls = plans.getLdgSls();
    String sLdgInv = plans.getLdgInv();
    String sLdgMkd = plans.getLdgMkd();
    // PO
    String sPurchOrd = plans.getPurchOrdJsa();
    String sRcvPOMTD = plans.getRcvPOMTD(); // Received PO in this month

    // PO  by vendor
    String sNumOfVen = plans.getNumOfVenJsa();
    String sPoVen = plans.getPoVenJsa();
    String sPoVenName = plans.getPoVenNameJsa();
    String sPoVenRet = plans.getPoVenRetJsa();
    String sPoVenCst = plans.getPoVenCstJsa();
    String sPoVenUnt = plans.getPoVenUntJsa();

    // PO by Div/Dpt/Class
    String sNumOfDdc = plans.getNumOfDdcJsa();
    String sPoDdc = plans.getPoDdcJsa();
    String sPoDdcName = plans.getPoDdcNameJsa();
    String sPoDdcRet = plans.getPoDdcRetJsa();
    String sPoDdcCst = plans.getPoDdcCstJsa();
    String sPoDdcUnt = plans.getPoDdcUntJsa();

    plans.disconnect();

    String sCSSCls = "DataTable";
    StringBuffer sbStr = new StringBuffer();
    for(int i=0; i < sStore.length; i++)
    {
       if(sStore[i].equals("SAS")) sbStr.append("Sun & Ski");
       else if(sStore[i].equals("SCH")) sbStr.append("Ski Chalet");
       else if(sStore[i].equals("SAS70")) sbStr.append("Sun & Ski + 70");
       else if(sStore[i].equals("SSC70")) sbStr.append("Sun & Ski + Ski Chalet + 70");
       else sbStr.append(sStore[i] + " ");
    }

    FormatNumericValue fmt = new FormatNumericValue();

    String sRetVal = "0";
    String sCstVal = "0";
    String sUntVal = "0";
    if(sChgPlan.equals("R")) sRetVal = "1";
    else if(sChgPlan.equals("C")) sCstVal = "1";
    else if(sChgPlan.equals("U")) sUntVal = "1";
 %>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px } a:visited { color:blue; font-size:10px }  a:hover { color:blue; font-size:10px }
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.Button { background:ivory; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        th.InvData { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.InvData { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}


        tr.DataTable { background:#E7E7E7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: Azure; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable3 { background: #deecec ; font-family:Arial; font-size:10px }
        tr.DataTable4 { background: #94e981 ; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center;}

        input.Cell {border:none; background:none; width:55; text-align:right; font-family:Arial; font-size:10px }

        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }

        div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt {border-bottom: black solid 2px; border-right: black solid 1px; text-align:center;
                   font-family:Arial; font-size:10px; }

        td.misc1{ filter:progid:DXImageTransform.Microsoft.Gradient(
                  startColorStr=#c3fdb8, endColorStr=#99c68e, gradientType=0);
                 padding-top:0px; border:darkgreen 1px solid;
                 color: darkblue; vertical-align:middle; text-align:center; font-size:12px; }
        td.misc2{ filter:progid:DXImageTransform.Microsoft.Gradient(
                  startColorStr=#c3fdb8, endColorStr=#99c68e, gradientType=0);
                 padding-top:0px; border:darkgreen 1px solid;
                 color: darkblue; vertical-align:middle; text-align:left; font-size:12px; }

        tr.MonCalc { background: blue; color:white; font-family:Arial; font-size:10px }
        tr.trButton {  text-align:center; }

@media screen
{
   table.MonCalc { border: darkred solid 1px;background:darkred;text-align:center;}
   tr.ManagmentLine { display:block;}
}
@media print
{
   table.MonCalc { display:none;}
   tr.ManagmentLine { display:none;}
   tr.trButton {  display:none; }
}
</style>


<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//report parameters
var Store = new Array();
<%for(int i=0; i < sStore.length; i++){%>Store[<%=i%>]="<%=sStore[i]%>";<%}%>

var SelStr = new Array(<%=sStore.length%>);
<%for(int i=0; i < sStore.length; i++) {%>  SelStr[<%=i%>] = "<%=sStore[i]%>"; <%}%>

var Division = new Array();
  <%for(int i=0; i < sDivision.length;i++){%> Division[<%=i%>] = "<%=sDivision[i]%>";<%}%>
var Department = "<%=sDepartment%>";
var Class = "<%=sClass%>";
var ChgPlan = "<%=sChgPlan%>";
var Result = "<%=sResult%>";
var New = 0;

//==============================================================================
// Set Report Values
var NumOfYr = <%=iNumOfYr%>; // number of month
var NumOfMon = <%=iNumOfMon%>; // required retail, cost or unit values
var CurMon = <%=sCurMon%>;
var CurYear = <%=sCurYear%>;
var Percent = <%=sPercent%>;
var NumWk = [<%=sNumWk%>];

var Year = [<%=sYearJsa%>];
var MonName = [<%=sMonNameJsa%>];

var SlsVal = null;
var InvVal = null;
var MkdVal = null;

var SlsValA = null;
var InvValA = null;
var MkdValA = null;

var SlsValB = null;
var InvValB = null;
var MkdValB = null;

// Save data to restore on reset
var SaveSlsVal = null;
var SaveInvVal = null;
var SaveMkdVal = null;


if(ChgPlan=='R')
{
   SlsVal = [<%=sRetPlanSls%>]; InvVal = [<%=sRetPlanInv%>]; MkdVal = [<%=sRetPlanMkd%>];
   SaveSlsVal = [<%=sRetPlanSls%>]; SaveInvVal = [<%=sRetPlanInv%>]; SaveMkdVal = [<%=sRetPlanMkd%>];
   SlsValA = [<%=sRetPlanSlsA%>]; InvValA = [<%=sRetPlanInvA%>]; MkdValA = [<%=sRetPlanMkdA%>];
   SlsValB = [<%=sRetPlanSlsB%>]; InvValB = [<%=sRetPlanInvB%>]; MkdValB = [<%=sRetPlanMkdB%>];
}

if(ChgPlan=='C')
{
   SlsVal = [<%=sCstPlanSls%>]; InvVal = [<%=sCstPlanInv%>]; MkdVal = [<%=sCstPlanMkd%>];
   SaveSlsVal = [<%=sCstPlanSls%>]; SaveInvVal = [<%=sCstPlanInv%>]; SaveMkdVal = [<%=sCstPlanMkd%>];
   SlsValA = [<%=sCstPlanSlsA%>]; InvValA = [<%=sCstPlanInvA%>]; MkdValA = [<%=sCstPlanMkdA%>];
   SlsValB = [<%=sCstPlanSlsB%>]; InvValB = [<%=sCstPlanInvB%>]; MkdValB = [<%=sCstPlanMkdB%>];
}

if(ChgPlan=='U')
{
   SlsVal = [<%=sUntPlanSls%>]; InvVal = [<%=sUntPlanInv%>]; MkdVal = [<%=sUntPlanMkd%>];
   SaveSlsVal = [<%=sUntPlanSls%>]; SaveInvVal = [<%=sUntPlanInv%>]; SaveMkdVal = [<%=sUntPlanMkd%>];
   SlsValA = [<%=sUntPlanSls%>]; InvValA = [<%=sUntPlanInvA%>]; MkdValA = [<%=sUntPlanMkdA%>];
   SlsValB = [<%=sUntPlanSls%>]; InvValB = [<%=sUntPlanInvB%>]; MkdValB = [<%=sUntPlanMkdB%>];
}

//--------------------- historical plan ----------------------------------------
var SlsHstCell = new Array(12);
var MkdHstCell = new Array(12);
var InvHstCell = new Array(12);

var SlsHstTotCell = null;
var MkdHstTotCell = null;
var InvHstTotCell = null;

var SlsHstTot = 0;
var MkdHstTot = 0;
var InvHstTot = 0;

if(ChgPlan=='R'){ SlsHstVal = [<%=sRetPlanHstSls%>]; InvHstVal = [<%=sRetPlanHstInv%>]; MkdHstVal = [<%=sRetPlanHstMkd%>];}
if(ChgPlan=='C'){ SlsHstVal = [<%=sCstPlanHstSls%>]; InvHstVal = [<%=sCstPlanHstInv%>]; MkdHstVal = [<%=sCstPlanHstMkd%>];}
if(ChgPlan=='U'){ SlsHstVal = [<%=sUntPlanHstSls%>]; InvHstVal = [<%=sUntPlanHstInv%>]; MkdHstVal = [<%=sUntPlanHstMkd%>];}
//==============================================================================----------------------
var RetSlsVal = [<%=sRetPlanSls%>];
var RetInvVal = [<%=sRetPlanInv%>];
var RetMkdVal = [<%=sRetPlanMkd%>];
var CstSlsVal = [<%=sCstPlanSls%>];
var CstInvVal = [<%=sCstPlanInv%>];
var CstMkdVal = [<%=sCstPlanMkd%>];
var UntSlsVal = [<%=sUntPlanSls%>];
var UntInvVal = [<%=sUntPlanInv%>];
var UntMkdVal = [<%=sUntPlanMkd%>];

var ApplySls = new Array();
var ApplyInv = new Array();
var ApplyMkd = new Array();

// Stock ledger
var LdgSls = <%=sLdgSls%>;
var LdgInv = <%=sLdgInv%>;
var LdgMkd = <%=sLdgMkd%>;

// POs
var POVal = [<%=sPurchOrd%>];
var RcvPOMTD = "<%=sRcvPOMTD%>";

//sales
var SlsCell = new Array();
var SlsTot = new Array();
var SlsTotCell = new Array();
var ChgSlsCell = new Array();
var ChgSlsTotCell = new Array();
var SlsLessCell = new Array();
var SlsLessTotCell = null;
var ActSlsCell = new Array();
var ActSlsTotCell = null;

// plan A
var ASlsCell = new Array();
var ASlsTot = new Array();
var ASlsTotCell = new Array();

var AMkdCell = new Array();
var AMkdTot = new Array();
var AMkdTotCell = new Array();

var AEmiCell = new Array();
var AEmiTot = new Array();
var AEmiTotCell = new Array();

// plan B
var BSlsCell = new Array();
var BSlsTot = new Array();
var BSlsTotCell = new Array();

var BMkdCell = new Array();
var BMkdTot = new Array();
var BMkdTotCell = new Array();

var BEmiCell = new Array();
var BEmiTot = new Array();
var BEmiTotCell = new Array();

// markdwns
var MkdCell = new Array();
var MkdTot = new Array();
var MkdTotCell = new Array();
var ChgMkdCell = new Array();
var ChgMkdTotCell = new Array();
var MkdLessCell = new Array();
var MkdLessTotCell = null;

var MkdSlsPrc = new Array(3);

// EOM Inventory
var EmiCell = new Array();
var EmiTot = new Array();
var EmiTotCell = new Array();
var ChgEmiCell = new Array();
var ChgEmiTotCell = new Array();

//sales
var POCell = new Array();
var POTot = new Array();
var POTotCell = new Array();

var BmiCell = new Array();// BOM Inventory
var BmiVal = new Array(3);// BOM Inventory
var SsrCell = new Array();// Stock to sales ration
var FcwCell = new Array();// fiscal weeks
var AswCell = new Array();// Average sales/week
var TurnCell = new Array();// Turn


var RfpCell = new Array();// Required for Plan
var RfpVal = new Array();// Required for Plan
var RfpTotCell = new Array();// Required for Plan
var RfpTot = new Array();// Required for Plan

var CbiCell = new Array();// Current Beginning Inventory
var CbiVal = new Array();// Current Beginning Inventory
var CbiTotCell = new Array();// Current Beginning Inventory

var OtrCell = new Array();// Open to receive
var OtrVal = new Array();// Open to receive
var OtrTotCell = new Array();// Open to receive
var OtrTot = new Array();// Open to receive

var AOtrCell = new Array();// Open to receive - plan A
var AOtrVal = new Array();// Open to receive
var AOtrTotCell = new Array();// Open to receive
var AOtrTot = new Array();// Open to receive

var BOtrCell = new Array();// Open to receive - plan B
var BOtrVal = new Array();// Open to receive
var BOtrTotCell = new Array();// Open to receive
var BOtrTot = new Array();// Open to receive

var OtbCell = new Array();// Open to buy
var OtbVal = new Array();// Open to buy
var OtbTotCell = new Array();// Open to buy
var OtbTot = new Array();// Open to buy

var OcfCell = new Array();// OTB Carry Forward
var OcfVal = new Array();// OTB Carry Forward
var OcfTotCell = new Array();// OTB Carry Forward
var OcfTot = new Array();// OTB Carry Forward

//==============================================================================
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

var ApplyHist = null;
//==============================================================================
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
//==============================================================================
var ShowHist = true;
var AllowChgCost = false;
<%if (session.getAttribute("USER").equals("fstanley")
   || session.getAttribute("USER").equals("vrozen")){%>AllowChgCost = true<%}%>

var ShowOtb = true;
var ShowStats = true;
//==============================================================================
var TotMargins = new Array(10);
for (var i=0; i < 10;  i++) { TotMargins[i] = new Array(2); TotMargins[i][0]=0; TotMargins[i][1]=0;}

var IntervalId;

var OtrCalc = "EOM";
var MkdCalc = "ASYNC";

var MonName = ["April", "May", "June", "July", "August", "September", "October", "November",
               "December", "Junuary", "February", "March"]
var OTBMonList = new Array(12);
var OTBYearList = new Array(12);
//--------------- End of Global variables ----------------
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
	
	setBoxclasses(["BoxName",  "BoxClose"], ["Prompt"]);
	
	
	setPrecision(Result); // set result precision 1/100/1k/10k

   document.all.Save[0].style.display="none"
   document.all.Save[1].style.display="none"

   saveCell(SlsCell, SlsTotCell, "SLS", NumOfYr); // actual and planned sales
   setCellVal(SlsVal, SlsTot, SlsCell, SlsTotCell);
   saveCell(ChgSlsCell, ChgSlsTotCell, "CHGSLS", NumOfYr-1); // actual and planned % change of sales
   setChgCellVal(SlsVal, SlsTot, ChgSlsCell, ChgSlsTotCell);

   saveCell(ASlsCell, ASlsTotCell, "ASLS", 2); // planned sales - plan A
   setCellValAB(SlsValA, ASlsTot, ASlsCell, ASlsTotCell);
   saveCell(BSlsCell, BSlsTotCell, "BSLS", 2); // planned sales - plan B
   setCellValAB(SlsValB, BSlsTot, BSlsCell, BSlsTotCell);

   saveCell(MkdCell, MkdTotCell, "MKD", NumOfYr); // actual and planned markdowns
   setCellVal(MkdVal, MkdTot, MkdCell, MkdTotCell);
   saveCell(ChgMkdCell, ChgMkdTotCell, "CHGMKD", 3); // actual and planned % change of markdowns
   setChgMkdCellVal();

   saveCell(AMkdCell, AMkdTotCell, "AMKD", 2); // planned markdowns - plan A
   setCellValAB(MkdValA, AMkdTot, AMkdCell, AMkdTotCell);
   saveCell(BMkdCell, BMkdTotCell, "BMKD", 2); // planned markdowns - plan B
   setCellValAB(MkdValB, BMkdTot, BMkdCell, BMkdTotCell);

   saveCell(EmiCell, EmiTotCell, "EMI", NumOfYr); // actual and planned EOM Inv.
   setCellVal(InvVal, EmiTot, EmiCell, EmiTotCell);
   saveCell(ChgEmiCell, ChgEmiTotCell, "CHGEMI", NumOfYr-1); // actual and planned % change of EOM Inv.
   setChgCellVal(InvVal, EmiTot, ChgEmiCell, ChgEmiTotCell);

   saveCell(AEmiCell, AEmiTotCell, "AEMI", 2); // EOM Inv - plan A
   setCellValAB(InvValA, AEmiTot, AEmiCell, AEmiTotCell);
   saveCell(BEmiCell, BEmiTotCell, "BEMI", 2); // EOM Inv - plan B
   setCellValAB(InvValB, BEmiTot, BEmiCell, BEmiTotCell);

   saveBmi(); // BOM Inv.
   setBmiVal();
   saveSsr(); // Stock to sales Ration
   setSsrVal();
   saveFcw(); // fiscal weeks
   setFcwVal();
   saveAsw(); // avg sls/weeks
   setAswVal();
   saveTurn(); // avg sls/weeks
   setTurnVal();

   savePOCell(POCell, POTotCell, "OPO", 3); // Open PO
   setPOCellVal(POVal, POTot, POCell, POTotCell);

   saveSlsLpp(); // Plan Sales - Less Period Passed
   setSlsLpp();
   saveActSls(); // Actual Sales MTD
   setActSls();
   saveMkdLpp(); // Markdown - Less Period Passed
   setMkdLpp();

   saveRfp(); // Required for Plan
   setRfpVal();
   saveCbi(); // Current Beginning Inventory
   setCbiVal();
   saveOtr(); // Open to receive
   setOtrVal();

   saveOtrAB(AOtrCell, AOtrTotCell, "AOTR"); // Open to receive - plan A
   setOtrValAB(AOtrVal, AOtrCell, AOtrTot, AOtrTotCell, SlsValA, MkdValA, InvValA);
   saveOtrAB(BOtrCell, BOtrTotCell, "BOTR"); // Open to receive - plan B
   setOtrValAB(BOtrVal, BOtrCell, BOtrTot, BOtrTotCell, SlsValB, MkdValB, InvValB);

   saveOtb(); // Open to buy
   setOtbVal();
   saveOcf(); // OTB carry forward
   setOcfVal();

   switchOTB();
   switchHist();
   switchStats();

   
   setResultSel();

   // set history
   //setHstCell();
   //SlsHstTot = setHstVal(SlsHstVal, SlsHstCell, SlsHstTotCell);
   //InvHstTot = setHstVal(InvHstVal, InvHstCell, InvHstTotCell);

   setPlannedTurnVal();

   popSelMonCalc();
   showOTBRep(CurMon-1, MonName[CurMon-1] + " " + Year[1])
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
// change Result selection reset screen
//==============================================================================
function chgResultSel()
{
  Result = (document.all.Result.selectedIndex) + 1;
  setPrecision(Result);
  setNewPlanValues();
}
//==============================================================================
// save cell objects in array
//==============================================================================
function saveCell(cells, totcell, cellName, max)
{
   for(var i=0; i < max; i++)
   {
      var amtc = new Array();
      for(var j=0; j < NumOfMon; j++) { amtc[j] = document.all[cellName + i + "M" + j]; }
      cells[i] = amtc;
      totcell[i] = document.all[cellName + i + "T"];
   }
}
//==============================================================================
// set history Cell array
//==============================================================================
function setHstCell()
{
   var amtc = new Array();
   for(var i=0; i < NumOfMon; i++)
   {
     //SlsHstCell[i] = document.all["HSLSM" + i];
     //MkdHstCell[i] = document.all["HMKDM" + i];
     //InvHstCell[i] = document.all["HINVM" + i];
   }
   //SlsHstTotCell = document.all.HSLST;
   //MkdHstTotCell = document.all.HMKDT;
   //InvHstTotCell = document.all.HINVT;
}
//==============================================================================
// set history value in cell
//==============================================================================
function setHstVal(amt, cells, totcells)
{
   var totamt = 0;
   alert()
   for(var i=0; i < NumOfMon; i++)
   {
      cells[i].innerHTML = format(amt[i]);
      totamt += eval(amt[i]);
   }
   totcells.innerHTML = format(totamt);
   return totamt;
}
//==============================================================================
// set cell value
//==============================================================================
function setCellVal(amt,tot, cells, totcell)
{
   var totamt;
   for(var i=0; i < NumOfYr; i++)
   {
      totamt = 0;
      for(var j=0; j < NumOfMon; j++)
      {
         cells[i][j].value = format(amt[i][j]);
         totamt += eval(amt[i][j]);
         if(i == 0 || i==1 && j >= CurMon-1)
         {
            cells[i][j].style.backgroundColor="white";
            cells[i][j].readOnly=false;
         }
      }
      totcell[i].value = format(totamt);
      tot[i] = totamt;
      if(i == 0 || i==1 && CurMon < 12)
      {
        totcell[i].style.backgroundColor="white";
        totcell[i].readOnly=false;
      }
   }
}


//==============================================================================
// set cell value for plan A and B
//==============================================================================
function setCellValAB(amt,tot, cells, totcell)
{
   var totamt;
   for(var i=0; i < 2; i++)
   {
      totamt = 0;
      for(var j=0; j < NumOfMon; j++)
      {
         cells[i][j].innerHTML = format(amt[i][j]);
         totamt += eval(amt[i][j]);
      }

      totcell[i].innerHTML = format(totamt);
      tot[i] = totamt;
   }
}


//==============================================================================
// set % change cell values
//==============================================================================
function setChgCellVal(amt, tot, cells, totcell)
{
   var prc = 0;
   for(var i=0; i < NumOfYr-1; i++)
   {
      totamt = 0;
      for(var j=0; j < NumOfMon; j++)
      {
         prc = 0;
         if(amt[i+1][j] != 0) prc = ( (amt[i][j] - amt[i+1][j])/ amt[i+1][j] * 100).toFixed(1)
         cells[i][j].innerHTML = prc + "%";
      }
      prc = 0;
      if(tot[i+1] != 0) prc = ((tot[i] - tot[i+1]) /  tot[i+1] * 100).toFixed(1)
      totcell[i].innerHTML = prc + "%";
   }
}
//==============================================================================
// set % To Total cell values for markdownds
//==============================================================================
function setChgMkdCellVal()
{
   //   MkdVal, MkdTot, ChgMkdCell, ChgMkdTotCell
   var prc = 0;
   for(var i=0; i < 3; i++)
   {
      totamt = 0;
      MkdSlsPrc[i] = new Array(NumOfMon);

      for(var j=0; j < NumOfMon; j++)
      {
         prc = 0;
         if(SlsVal[i][j] != 0) prc = ( (1 - (SlsVal[i][j] - MkdVal[i][j]) / SlsVal[i][j]) * 100).toFixed(1)
         ChgMkdCell[i][j].innerHTML = prc + "%";
         MkdSlsPrc[i][j] = prc;
      }
      prc = 0;
      if(SlsTot[i] != 0) prc = ( (1 - (SlsTot[i] - MkdTot[i]) / SlsTot[i]) * 100).toFixed(1)

      ChgMkdTotCell[i].innerHTML = prc + "%";
   }
}
//==============================================================================
// save BOM Inventory cell objects in array
//==============================================================================
function saveBmi()
{
   for(var i=0; i < 3; i++)
   {
      var cell = new Array(12);
      for(var j=0; j < NumOfMon; j++) { cell[j] = document.all["BMI" + i + "M" + j]; }
      BmiCell[i] = cell;
   }
}
//==============================================================================
// set BOM Inventory values
//==============================================================================
function setBmiVal()
{
   BmiVal[0] = new Array(12);
   BmiVal[1] = new Array(12);
   BmiVal[2] = new Array(12);

   // next Year
   BmiCell[0][0].innerHTML = format(InvVal[1][11]);
   BmiVal[0][0] = InvVal[1][11];
   // Current Year
   BmiCell[1][0].innerHTML = format(InvVal[2][11]);
   BmiVal[1][0] = InvVal[2][11];
   // prior year
   BmiCell[2][0].innerHTML = format(eval(InvVal[2][0]) + eval(SlsVal[2][0]) + eval(MkdVal[2][0]));
   BmiVal[2][0] = InvVal[2][0] + SlsVal[2][0] + MkdVal[2][0];

   for(var i=0; i < 3; i++)
   {
      for(var j=1; j < NumOfMon; j++)
      {
         BmiCell[i][j].innerHTML = format(InvVal[i][j-1]);
         BmiVal[i][j] = InvVal[i][j-1];
      }
   }
}

//==============================================================================
// save stock to sales ratio objects in array
//==============================================================================
function saveSsr(){ for(var i=0; i < NumOfMon; i++) { SsrCell[i] = document.all["SSR" + i]; } }
//==============================================================================
// set stock to sales ratio values
//==============================================================================
function setSsrVal()
{
   // formula BOM + EOM / Sales Plan -  for same month and year
   for(var i=0; i < NumOfMon; i++)
   {
     SsrCell[i].innerHTML = 0;
     if (SlsVal[1][i] != 0)
     {
         // change by Todd request
         // SsrCell[i].innerHTML = (((eval(BmiVal[1][i]) + eval(InvVal[1][i]))/ 2) / SlsVal[1][i]).toFixed(1);
         var bom = BmiVal[1][i];
         var ssl = SlsVal[1][i];
         var ssr = (bom / ssl).toFixed(1)
         SsrCell[i].innerHTML = ssr;
     }
   }
}
//==============================================================================
// save fiscal calendar week objects in array
//==============================================================================
function saveFcw(){ for(var i=0; i < NumOfMon; i++) { FcwCell[i] = document.all["FCW" + i]; } }
//==============================================================================
// set stock to sales ratio values
//==============================================================================
function setFcwVal()
{
   for(var i=0; i < NumOfMon; i++)  { FcwCell[i].innerHTML = NumWk[i]; }
}
//==============================================================================
// save stock to sales ratio objects in array
//==============================================================================
function saveAsw(){ for(var i=0; i < NumOfMon; i++) { AswCell[i] = document.all["ASW" + i]; } }
//==============================================================================
// set stock to sales ratio values
//==============================================================================
function setAswVal() { for(var i=0; i < NumOfMon; i++) { AswCell[i].innerHTML = format((SlsVal[1][i] / NumWk[i]).toFixed(0)); }}
//==============================================================================
// save turn objects in array
//==============================================================================
function saveTurn(){ for(var i=0; i < NumOfYr; i++) { TurnCell[i] = document.all["TRN" + i]; } }
//==============================================================================
// set Turn values
//==============================================================================
function setTurnVal()
{
   for(var i=0; i < NumOfYr; i++) { TurnCell[i].innerHTML = (SlsTot[i] / (EmiTot[i] / 12.000)).toFixed(2); }
}
//==============================================================================
// set Turn values
//==============================================================================
function setPlannedTurnVal()
{
   inv = 0;
   sls = 0;
   for(var i=0; i < 12; i++)
   {
      inv = eval(inv) + eval(InvValA[2][i]);
      sls = eval(sls) + eval(SlsValA[2][i])
   }

   inv = (inv / 12).toFixed(2);
   turn = (sls / inv).toFixed(2);
   document.all.TRNH.innerHTML = turn;
}
//==============================================================================
// save cell objects in array
//==============================================================================
function savePOCell(cells, totcell, cellName, max)
{
   for(var i=0; i < max; i++)
   {
      var amtc = new Array();
      for(var j=0; j < NumOfMon; j++) { amtc[j] = document.all[cellName + i + "M" + j]; }
      cells[i] = amtc;
      totcell[i] = document.all[cellName + i + "T"];
   }
}
//==============================================================================
// set cell value
//==============================================================================
function setPOCellVal(amt,tot, cells, totcell)
{
   var totamt;
   for(var i=0; i < 3; i++)
   {
      totamt = 0;
      for(var j=0; j < 12; j++)
      {
            cells[i][j].innerHTML = format(amt[i][j]);
            totamt += eval(amt[i][j]);
      }

      totcell[i].innerHTML = format(totamt);
      tot[i] = totamt;
   }

   document.all.RCVPOMTD.innerHTML = format(RcvPOMTD);
}
//==============================================================================
// Plan Sales - Less Period Passed
//==============================================================================
function saveSlsLpp()
{
   for(var i=0; i < NumOfMon; i++)
   {
      SlsLessCell[i] = document.all["PSLPP" + i];
   }
   SlsLessTotCell = document.all["PSLPPT"];
}
//==============================================================================
// set Plan Sales - Less Period Passed
//==============================================================================
function setSlsLpp()
{
   SlsLessCell[CurMon-1].innerHTML = format( (SlsVal[1][CurMon-1] * Percent).toFixed(0) );
   SlsLessTotCell.innerHTML = format( (SlsVal[1][CurMon-1] * Percent).toFixed(0) );
}
//==============================================================================
// save Actual Sales MTD cells in array
//==============================================================================
function saveActSls()
{
   for(var i=0; i < NumOfMon; i++)
   {
      ActSlsCell[i] = document.all["ASMTD" + i];
   }
   ActSlsTotCell = document.all["ASMTDT"];
}
//==============================================================================
// set Actual Sales MTD values
//==============================================================================
function setActSls()
{
   ActSlsCell[CurMon-1].innerHTML = format( LdgSls );
   ActSlsTotCell.innerHTML = format( LdgSls );
}

//==============================================================================
// save Markdown Less Period Passed in array
//==============================================================================
function saveMkdLpp()
{
   for(var i=0; i < NumOfMon; i++)
   {
      MkdLessCell[i] = document.all["MDLPP" + i];
   }
   MkdLessTotCell = document.all["MDLPPT"];
}
//==============================================================================
// set Markdown Less Period Passed value
//==============================================================================
function setMkdLpp()
{
   if (ChgPlan=="R" || ChgPlan=="C")
   {
     MkdLessCell[CurMon-1].innerHTML = format( (MkdVal[1][CurMon-1] * Percent).toFixed(0) )
        + "<br>" + format(LdgMkd.toFixed(0) ) + "*";
     //MkdLessTotCell.innerHTML = format(LdgMkd.toFixed(0) ) + " *";
   }
   else
   {
     MkdLessCell[CurMon-1].innerHTML = format( (MkdVal[1][CurMon-1] * Percent).toFixed(0) );
     MkdLessTotCell.innerHTML = format( (MkdVal[1][CurMon-1] * Percent).toFixed(0) );
   }
}

//==============================================================================
// save Required for plan cell objects in array
//==============================================================================
function saveRfp()
{
   for(var i=0; i < 2; i++)
   {
      RfpCell[i] = new Array();
      for(var j=0; j < NumOfMon; j++)
      {
         RfpCell[i][j] = document.all["RFP" + i + "M" + j];
      }
      RfpTotCell[i] = document.all["RFP" + i + "T"];
   }
}
//==============================================================================
// set Required for plan values
//==============================================================================
function setRfpVal()
{
   var amt = 0;
   for(var i=0; i < 2; i++)
   {
      var tot = 0;
      RfpVal[i] = new Array();
      for(var j=0; j < NumOfMon; j++)
      {
         if(i == 0 || i==1 && j >= CurMon-1)
         {
            amt = eval(SlsVal[i][j]) + eval(MkdVal[i][j]) + eval(InvVal[i][j]);
            if(i==1 && j == CurMon-1)
            {
              amt = eval(amt) - (eval(SlsVal[i][CurMon-1]) + eval(MkdVal[i][CurMon-1])) * Percent;
            }

            tot += eval(SlsVal[i][j]) + eval(MkdVal[i][j]);
            amt  = amt.toFixed(0);
            RfpVal[i][j] = amt;
            RfpCell[i][j].innerHTML = format(amt);
         }
      }

      tot += eval(InvVal[i][11]);
      if(i==1)
      {
         tot = tot - (eval(SlsVal[i][CurMon-1]) + eval(MkdVal[i][CurMon-1])) * Percent;
      }
      tot = tot.toFixed(0);
      RfpTotCell[i].innerHTML = format(tot);
      RfpTot[i] = tot;
   }
}
//==============================================================================
// save Required for plan cell objects in array
//==============================================================================
function saveCbi()
{
   for(var i=0; i < 2; i++)
   {
      CbiCell[i] = new Array();
      for(var j=0; j < NumOfMon; j++)
      {
         CbiCell[i][j] = document.all["CBI" + i + "M" + j];
      }
      CbiTotCell[i] = document.all["CBI" + i + "T"];
   }
}
//==============================================================================
// set Required for plan values
//==============================================================================
function setCbiVal()
{
   var amt = 0;
   for(var i=0; i < 2; i++)
   {
      CbiVal[i] = new Array();
      for(var j=1; j < NumOfMon; j++)
      {
         if(i == 0 || i==1 && j >= CurMon-1)
         {
            amt = eval(InvVal[i][j-1]);
            if(i==1 && j == CurMon-1) { amt = eval(LdgInv); }
            CbiVal[i][j] = amt;
            CbiCell[i][j].innerHTML = format(amt);
         }
      }
   }
   CbiCell[0][0].innerHTML = format(InvVal[1][11]);
   CbiVal[0][0] = InvVal[1][11];
}

//==============================================================================
// save Open to receive cell objects in array
//==============================================================================
function saveOtr()
{
   for(var i=0; i < 2; i++)
   {
      OtrCell[i] = new Array();
      for(var j=0; j < NumOfMon; j++)
      {
         OtrCell[i][j] = document.all["OTR" + i + "M" + j];
         if(i == 0 || i==1 && j >= CurMon-1)
         {
            OtrCell[i][j].style.backgroundColor="white";
            OtrCell[i][j].readOnly=false;
         }
      }

      OtrTotCell[i] = document.all["OTR" + i + "T"];
      if(i == 0 || i==1 && CurMon < 12)
      {
            OtrTotCell[i].style.backgroundColor="white";
            OtrTotCell[i].readOnly=false;
      }
   }
}
//==============================================================================
// set Open to receive values
//==============================================================================
function setOtrVal()
{
   var amt = 0;
   var bom = 0;
   for(var i=0; i < 2; i++)
   {
      var tot = 0;
      OtrVal[i] = new Array();
      for(var j=0; j < NumOfMon; j++)
      {
         if(i == 0 || i==1 && j >= CurMon-1)
         {
            if(j==0 ){ bom = InvVal[i+1][11] }
            else if(i==1 && j == CurMon-1) {bom = LdgInv; }
            else { bom = InvVal[i][j-1] };

            amt = eval(RfpVal[i][j]) - eval(bom);
            OtrVal[i][j] = amt;
            OtrCell[i][j].value = format(amt);
         }
      }

      tot = eval(RfpTot[i])
      if(i==0) tot = tot - eval(InvVal[1][11]);
      else if(i==1) tot = tot - LdgInv;
      OtrTotCell[i].value = format(tot);
      OtrTot[i] = tot;
   }
}
//==============================================================================
// save Open to receive cell objects in array for plan A & B
//==============================================================================
function saveOtrAB(cell, totcell, name)
{
   for(var i=0; i < 2; i++)
   {
      cell[i] = new Array();
      for(var j=0; j < NumOfMon; j++)
      {
         cell[i][j] = document.all[name + i + "M" + j];
      }
      totcell[i] = document.all[name + i + "T"];
   }
}
//==============================================================================
// set Open to receive values for plan A & B
//==============================================================================
function setOtrValAB(otr, cell, totamt, totcell, sls, mkd, inv)
{
   var amt = 0;
   var bom = 0;
   var rfp = 0;

   for(var i=0; i < 2; i++)
   {
      var tot = 0;
      otr[i] = new Array();
      for(var j=0; j < NumOfMon; j++)
      {
         if(i == 0 || i==1 && j >= CurMon-1)
         {
            // for future year 1st month BOM = last year 12 month EOM
            if(j==0) bom = inv[i+1][11];
            // for the current month BOM = Ledger Invnetory
            else if(i==1 && j == CurMon-1) bom = LdgInv;
            // the rest of current year BOM = the last month EOM
            else bom = inv[i][j-1];

            // calculate rfp - required for plan
            // rfp = sales paln + markdown plans + eom plans
            rfp = eval(sls[i][j]) + eval(mkd[i][j]) + eval(inv[i][j]);
            // for current month
            //rfp = calculated rfp - (sales + markdows) * less period pass %
            if(i==1 && j == CurMon-1)
            {
              rfp = eval(rfp) - (eval(sls[i][CurMon-1]) + eval(mkd[i][CurMon-1])) * Percent;
            }
            rfp = rfp.toFixed(0)

            //open to receive = RFP - BOM
            amt = eval(rfp) - eval(bom);
            otr[i][j] = amt;
            cell[i][j].innerHTML = format(amt);
         }
      }

      tot = eval(RfpTot[i])
      if(i==0) tot = tot - eval(inv[1][11]);
      else if(i==1) tot = tot - LdgInv;
      totcell[i].innerHTML = format(tot);
      totamt[i] = tot;
   }
}
//==============================================================================
// save Open to buy cell objects in array
//==============================================================================
function saveOtb()
{
   for(var i=0; i < 2; i++)
   {
      OtbCell[i] = new Array();
      for(var j=0; j < NumOfMon; j++)
      {
         OtbCell[i][j] = document.all["OTB" + i + "M" + j];
      }
      OtbTotCell[i] = document.all["OTB" + i + "T"];
   }
}
//==============================================================================
// set Open to buy values
//==============================================================================
function setOtbVal()
{
   var amt = 0;
   for(var i=0; i < 2; i++)
   {
      var tot = 0;
      OtbVal[i] = new Array();
      for(var j=0; j < NumOfMon; j++)
      {
         if(i == 0 || i==1 && j >= CurMon-1)
         {
            amt = eval(OtrVal[i][j]) - eval(POVal[i][j]);
            tot += amt;
            OtbVal[i][j] = amt;
            OtbCell[i][j].innerHTML = format(amt);
         }
      }

      OtbTotCell[i].innerHTML = format(tot);
      OtbTot[i] = tot;
   }
}

//==============================================================================
// save OTB Carry Forward cell objects in array
//==============================================================================
function saveOcf()
{
   for(var i=0; i < 2; i++)
   {
      OcfCell[i] = new Array();
      for(var j=0; j < NumOfMon; j++)
      {
         OcfCell[i][j] = document.all["OCF" + i + "M" + j];
      }
      OcfTotCell[i] = document.all["OCF" + i + "T"];
   }
}
//==============================================================================
// set OTB Carry Forward values
//==============================================================================
function setOcfVal()
{
   //if (i > 0) amt = amt + savocf;
   var amt = 0;
   for(var i=0; i < 2; i++)
   {
      var tot = 0;
      OcfVal[i] = new Array();

      // calculate last year OTB carry forward for april of next year
      var curyramt = 0;
      for(var j=0; j < NumOfMon; j++)
      {
         if(j >= CurMon-1) { curyramt += OtbVal[1][j]; }
      }

      for(var j=0; j < NumOfMon; j++)
      {
         if(i == 0 || i==1 && j >= CurMon-1)
         {
            amt = eval(OtbVal[i][j]);

            // add previous month carry forward
            if(i == 0 && j == 0) amt = amt + curyramt;
            else if(i == 0 || i == 1 && j > CurMon-1) amt = amt + eval(OcfVal[i][j-1]);

            tot += amt;
            OcfVal[i][j] = amt;
            OcfCell[i][j].innerHTML = format(amt);
         }
      }

      OcfTot[i] = tot;
   }
}
//==============================================================================
// apply Last Year Actual
//==============================================================================
function applyLYActual()
{
      var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap>Select applying type</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;Prompt&#34;);' alt='Close'>"
       + "</td>"
      + "</tr>"
   //vendor totals
   html += "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap colspan='2'><a href='javascript: chgPlanbyLYActual(true, 0); hidePanel(&#34;Prompt&#34;);'>Apply to all plans of Next Year</a></td>"
        + "</tr>"
        + "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap colspan='2'><a href='javascript: chgPlanbyLYActual(false, 0); hidePanel(&#34;Prompt&#34;);'>Apply to zero plans of Next Year</a></td>"
        + "</tr>"
        + "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap colspan='2'><a href='javascript: chgPlanbyLYActual(true, 1); hidePanel(&#34;Prompt&#34;);'>Apply to all plans of Current Year</a></td>"
        + "</tr>"
        + "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap colspan='2'><a href='javascript: chgPlanbyLYActual(false, 1); hidePanel(&#34;Prompt&#34;);'>Apply to zero plans of Current Year</a></td>"
        + "</tr>"

   html += "</table>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft= 200;
   document.all.Prompt.style.pixelTop= 200;
   document.all.Prompt.style.visibility = "visible";
}

//==============================================================================
// apply Last Year Actual
//==============================================================================
function chgPlanbyLYActual(applyAll, year)
{

   for(var j=0; j < NumOfMon; j++)
   {
      if(applyAll || SlsVal[year][j] <= 0)
      {
         if(year == 0 && j < CurMon-1) SlsVal[year][j] = SlsVal[1][j];
         else { SlsVal[year][j] = SlsVal[2][j]; }
         if(SlsVal[year][j]  < 0) SlsVal[year][j] = 0;
      }

      if(applyAll || MkdVal[year][j] <= 0)
      {
         if(year == 0 && j < CurMon-1) MkdVal[year][j] = MkdVal[1][j];
         else { MkdVal[year][j] = MkdVal[2][j]; }
         if(MkdVal[year][j]  < 0) MkdVal[year][j] = 0;
      }

      if(applyAll || InvVal[year][j] <= 0)
      {
         if(year == 0 && j < CurMon-1) InvVal[year][j] = InvVal[1][j];
         else { InvVal[year][j] = InvVal[2][j]; }
         if(InvVal[year][j]  < 0) InvVal[year][j] = 0;
      }
   }
   // update screen with new plan values recalculate derivative values
   setNewPlanValues();

   document.all.Calc[0].style.display="none";
   document.all.Calc[1].style.display="none";
   if(ChgPlan == "R" || AllowChgCost)
   {
     document.all.Save[0].style.display="inline";
     document.all.Save[1].style.display="inline";
   }

   if (!applyAll && year == 0) ApplyHist = 1;
   else if(applyAll && year == 0) ApplyHist = 2;
   else if(applyAll && year == 1) ApplyHist = 8;
   else if(!applyAll && year == 1) ApplyHist = 9;
}
//==============================================================================
// apply Current Year Plan to Next Year
//==============================================================================
function applyCurPlan()
{
      var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap>Select applying type</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;Prompt&#34;);' alt='Close'>"
       + "</td>"
      + "</tr>"
   //vendor totals
   html += "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap colspan='2'><a href='javascript: chgNextPlanbyCurrent(true); hidePanel(&#34;Prompt&#34;);'>Apply to all plans</a></td>"
        + "</tr>"
        + "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap colspan='2'><a href='javascript: chgNextPlanbyCurrent(false); hidePanel(&#34;Prompt&#34;);'>Apply to zero plans</a></td>"
        + "</tr>"

   html += "</table>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft= 200;
   document.all.Prompt.style.pixelTop= 200;
   document.all.Prompt.style.visibility = "visible";
}

//==============================================================================
// apply Next Year Plan by Current Plan
//==============================================================================
function chgNextPlanbyCurrent(applyAll)
{
   for(var j=0; j < NumOfMon; j++)
   {
      if(applyAll || SlsVal[0][j] <= 0)
      {
         if(SlsVal[0][j] >= 0) SlsVal[0][j] = SlsVal[1][j];
         else SlsVal[0][j] = 0;
      }

      if(applyAll || MkdVal[0][j] <= 0)
      {
         if(MkdVal[0][j] >= 0) MkdVal[0][j] = MkdVal[1][j];
         else MkdVal[0][j] = 0;
      }

      if(applyAll || InvVal[0][j] <= 0)
      {
         if(InvVal[0][j] >= 0) InvVal[0][j] = InvVal[1][j];
         else InvVal[0][j] = 0;
      }
   }
   // update screen with new plan values recalculate derivative values
   setNewPlanValues();

   document.all.Calc[0].style.display="none";
   document.all.Calc[1].style.display="none";
   if(ChgPlan == "R" || AllowChgCost)
   {
     document.all.Save[0].style.display="inline";
     document.all.Save[1].style.display="inline";
   }
   if (applyAll) ApplyHist = 6;
   else ApplyHist = 5;
}

//==============================================================================
// calculate new plan
//==============================================================================
function clcNewPlan()
{
   // validate entries - return if error
   if(validateEntry())
   {
      alert("Some of the entered values or percents are not valid numeric entries.")
      return;
   }

   var invChg = false;

   // check total
   for(var i=0; i < 2; i++)
   {
      var isTotalApplied = false;

      // initialize second demension of arrays
      if(ApplySls[i] == null) ApplySls[i] = new Array();
      if(ApplyInv[i] == null) ApplyInv[i] = new Array();
      if(ApplyMkd[i] == null) ApplyMkd[i] = new Array();

      // apply total
      if (SlsTotCell[i].value.trim() != format(SlsTot[i])) { clcAllPlanByPrc(i, SlsTotCell[i].value.trim(), SlsTot[i], SlsVal, ApplySls, true, true); isTotalApplied = true; }
      if (MkdTotCell[i].value.trim() != format(MkdTot[i])) { clcAllPlanByPrc(i, MkdTotCell[i].value.trim(), MkdTot[i], MkdVal, ApplyMkd, true, false); isTotalApplied = true; }
      if (EmiTotCell[i].value.trim() != format(EmiTot[i])) { clcAllPlanByPrc(i, EmiTotCell[i].value.trim(), EmiTot[i], InvVal, ApplyInv, false, false); isTotalApplied = true; }
      if (OtrTotCell[i].value.trim() != format(OtrTot[i])) { clcAllOtrPrc(i); isTotalApplied = true; invChg = true;}

      if( !isTotalApplied )
      {
         clcPlanByPrc(i, SlsCell, SlsVal, ApplySls, true, true);
         clcPlanByPrc(i, MkdCell, MkdVal, ApplyMkd, true, false);
         clcPlanByPrc(i, EmiCell, InvVal, ApplyInv, false, false);
         if(clcOtrByPrc(i)) { invChg = true; }
      }

   }

   // eliminate warning by Steave Rath request.
   // if(invChg) alert("Warning!!! By changing 'Open To Receive' You will change EOM Inventory.")


   // update screen with new plan values recalculate derivative values
   setNewPlanValues();

   document.all.Apply[0].style.display="none";
   document.all.Apply[1].style.display="none";
   if(ChgPlan == "R" || AllowChgCost)
   {
      document.all.Save[0].style.display="inline";
      document.all.Save[1].style.display="inline";
   }

   chgMonCalc();
}
//==============================================================================
// validate new entries
//==============================================================================
//==============================================================================
// apply Current Year Plan to Next Year
//==============================================================================
function applyBuck()
{
     var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap>Select applying type</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;Prompt&#34;);' alt='Close'>"
       + "</td>"
      + "</tr>"
   //vendor totals
   html += "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap colspan='2'><a href='javascript: applyBucktoAllPlan(); hidePanel(&#34;Prompt&#34;);'>Apply to all plans</a></td>"
        + "</tr>"
        + "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap colspan='2'><a href='javascript: applyBucktoZeroPlan(); hidePanel(&#34;Prompt&#34;);'>Apply to zero plans</a></td>"
        + "</tr>"

   html += "</table>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft= 200;
   document.all.Prompt.style.pixelTop= 200;
   document.all.Prompt.style.visibility = "visible";
}
//==============================================================================
// apply Current Year Plan to Next Year
//==============================================================================
function applyBucktoZeroPlan()
{

   for(var j=0; j < NumOfMon; j++)
   {
      if(SlsVal[0][j] <= 0) { SlsVal[0][j] = 1; }
      if(j >= CurMon-1 && SlsVal[1][j] <= 0) { SlsVal[1][j] = 1; }

      if(MkdVal[0][j] <= 0) { MkdVal[0][j] = 1; }
      if(j >= CurMon-1 && MkdVal[1][j] <= 0) { MkdVal[1][j] = 1; }

      if(InvVal[0][j] <= 0){ InvVal[0][j] = 1; }
      if(j >= CurMon-1 && InvVal[1][j] <= 0) InvVal[1][j] = 1;
   }
   // update screen with new plan values recalculate derivative values
   setNewPlanValues();

   document.all.Calc[0].style.display="none";
   document.all.Calc[1].style.display="none";
   if(ChgPlan == "R" || AllowChgCost)
   {
     document.all.Save[0].style.display="inline";
     document.all.Save[1].style.display="inline";
   }
   ApplyHist = 4;
}
//==============================================================================
// apply Current Year Plan to Next Year
//==============================================================================
function applyBucktoAllPlan()
{

   for(var j=0; j < NumOfMon; j++)
   {
      if(j >= CurMon-1) SlsVal[1][j] = 1;
      SlsVal[0][j] = 1;

      if(j >= CurMon-1) MkdVal[1][j] = 1;
      MkdVal[0][j] = 1;

      if(j >= CurMon-1) InvVal[1][j] = 1;
      InvVal[0][j] = 1;
   }

   // update screen with new plan values recalculate derivative values
   setNewPlanValues();

   document.all.Calc[0].style.display="none";
   document.all.Calc[1].style.display="none";
   if(ChgPlan == "R" || AllowChgCost)
   {
     document.all.Save[0].style.display="inline";
     document.all.Save[1].style.display="inline";
   }
   ApplyHist = 7;
}
//==============================================================================
// validate new entries
//==============================================================================
function validateEntry()
{
   var error = false;
   for(var i=0; i < 2; i++)
   {
      // validate totals
      if (SlsTotCell[i].value.trim() != format(SlsTot[i])
        && ( SlsTotCell[i].value.trim() && isNaN(SlsTotCell[i].value.trim().substring(1))
          || SlsTotCell[i].value.trim().substring(0, 1) != "%" && isNaN(SlsTotCell[i].value.trim())
           )
         ) { error = true; }

      if (MkdTotCell[i].value.trim() != format(MkdTot[i])
        && ( MkdTotCell[i].value.trim() && isNaN(MkdTotCell[i].value.trim().substring(1))
          || MkdTotCell[i].value.trim().substring(0, 1) != "%" && isNaN(MkdTotCell[i].value.trim())
           )
         ) { error = true; }

      if (EmiTotCell[i].value.trim() != format(EmiTot[i])
        && ( EmiTotCell[i].value.trim() && isNaN(EmiTotCell[i].value.trim().substring(1))
          || EmiTotCell[i].value.trim().substring(0, 1) != "%" && isNaN(EmiTotCell[i].value.trim())
           )
         ) { error = true; }



      for(var j=0; j < NumOfMon; j++)
      {
         if (SlsCell[i][j].value.trim() != format(SlsVal[i][j])
           && ( SlsCell[i][j].value.trim() && isNaN(SlsCell[i][j].value.trim().substring(1))
             || SlsCell[i][j].value.trim().substring(0, 1) != "%" && isNaN(SlsCell[i][j].value.trim())
              )
            ) { error = true; }

         if (MkdCell[i][j].value.trim() != format(MkdVal[i][j])
           && ( MkdCell[i][j].value.trim().substring(0, 1) == "%" && isNaN(MkdCell[i][j].value.trim().substring(1))
             || MkdCell[i][j].value.trim().substring(0, 1) != "%" && isNaN(MkdCell[i][j].value.trim())
              )
            ) { error = true; }

         if (EmiCell[i][j].value.trim() != format(InvVal[i][j])
           && ( EmiCell[i][j].value.trim().substring(0, 1) == "%" && isNaN(EmiCell[i][j].value.trim().substring(1))
             || EmiCell[i][j].value.trim().substring(0, 1) != "%" && isNaN(EmiCell[i][j].value.trim())
              )
            ) { error = true; }

        if (OtrCell[i][j].value.trim() != format(OtrVal[i][j])
           && ( OtrCell[i][j].value.trim().substring(0, 1) == "%" && isNaN(OtrCell[i][j].value.trim().substring(1))
             || OtrCell[i][j].value.trim().substring(0, 1) != "%" && isNaN(OtrCell[i][j].value.trim())
              )
            ) { error = true; }
      }
   }
   return error;
}
//==============================================================================
// calculate All future year plan by entered percenatage
//==============================================================================
function clcAllPlanByPrc(year, totcell, totamt, curamt, apply, clcEom, clcMkd)
{
   var prc = 1;
   if(totcell.substring(0, 1) == "%") { prc = 1 + totcell.substring(1)/100; }
   else { prc = eval(totcell) * 1000 / eval(totamt);}

   for(var j=0; j < NumOfMon; j++)
   {
      if(year==0 || year == 1 && j >= CurMon-1)
      {
        curamt[year][j] = ((curamt[year][j] * prc)).toFixed(0);
        apply[year][j] = (curamt[year][j]/1000).toFixed(3);

        // recalculate Markdown if synchronize with LY/Ty Sales selected
        if(clcMkd && MkdCalc != "ASYNC") clcMkdbySls(year, j, curamt[year][j])

      }
   }
}
//==============================================================================
// calculate All future year plan by entered percenatage
//==============================================================================
function clcPlanByPrc(year, cell, curamt, apply, clcEom, clcMkd)
{
   var prc=0;
   var diff = 0;
   for(var j=0; j < NumOfMon; j++)
   {
      if (cell[year][j].value.trim() != format(curamt[year][j]))
      {
         if(year==0 || year == 1 && j >= CurMon-1)
         {
            diff = eval(curamt[year][j]);
            if (cell[year][j].value.trim().substring(0,1) != "%")
            {
               curamt[year][j] = (eval(cell[year][j].value.trim()) * 1000).toFixed(0);
            }
            else
            {
               prc = 1 + cell[year][j].value.trim().substring(1)/100;
               curamt[year][j] = (curamt[year][j] * prc).toFixed(0);
            }
            apply[year][j] = cell[year][j].value.trim();

            // recalculate Markdown if synchronize with LY/Ty Sales selected
            if(clcMkd && MkdCalc != "ASYNC") clcMkdbySls(year, j, diff)

            // recalculate EOM
            diff = curamt[year][j] - diff; // different between new and old amount
            if(clcEom && OtrCalc != "EOM") clcEombySls(year, j, diff)
         }
      }
   }
}

//==============================================================================----------------------
// calculate all month Open to receive future year plan by entered percenatage
//==============================================================================----------------------
function clcAllOtrPrc(year)
{
   var prc = 1;
   if(OtrTotCell[year].value.trim().substring(0, 1) == "%") {prc = 1 + OtrTotCell[year].value.trim().substring(1)/100; }
   else { prc = eval(OtrTotCell[year].value.trim()) * 1000 / eval(OtrTot[year]); }

   for(var j=0; j < NumOfMon; j++)
   {
      if(year==0 || year == 1 && j >= CurMon-1)
      {
        InvVal[year][j] = (eval(InvVal[year][j]) + eval(OtrVal[year][j]) * (prc - 1)).toFixed(0);
        ApplyInv[year][j] = (InvVal[year][j]/1000).toFixed(4);
      }
   }
}
//==============================================================================----------------------
// calculate Open to Receive future year plan by entered percenatage
//==============================================================================----------------------
function clcOtrByPrc(year)
{
   var prc=0;
   var invChg = false;

   for(var j=0; j < NumOfMon; j++)
   {
      if (OtrCell[year][j].value.trim() != '' && OtrCell[year][j].value.trim() != format(OtrVal[year][j]))
      {
         invChg = true;
         if(year==0 || year == 1 && j >= CurMon-1)
         {
            if (OtrCell[year][j].value.trim().substring(0,1) != "%")
            {
               diff = eval(OtrCell[year][j].value.trim() * 1000);
               // EOM = EOM + (New_Opn_To_Rcv - Old_Opn_To_Rcv)
               InvVal[year][j] = (eval(InvVal[year][j])
                     + eval(OtrCell[year][j].value.trim() * 1000 - OtrVal[year][j])).toFixed(0);
               ApplyInv[year][j] = (InvVal[year][j]/1000).toFixed(4);
               diff = OtrVal[year][j] - diff; // different between new and old amount
            }
            else
            {
               diff = eval(InvVal[year][j]);
               prc = 1 + OtrCell[year][j].value.trim().substring(1)/100;
               InvVal[year][j] = (eval(InvVal[year][j]) + eval(OtrVal[year][j]) * (prc - 1)).toFixed(0);
               ApplyInv[year][j] = "%" + InvVal[year][j];
               diff = diff - eval(InvVal[year][j]); // different between new and old amount
            }

            // recalculate EOM
            if(OtrCalc != "EOM") clcEombyOtr(year, j, diff)
         }
      }
   }
   return invChg;
}
//==============================================================================----------------------
// calculate Markdown by synchronization with % of LY or TY Sales
//==============================================================================----------------------
function clcMkdbySls(year, mon, diff)
{
   var prc = 0;
   var sls = 0;
   var mkd = 0;

   if (MkdCalc == 'SYNCTY') { prc = MkdSlsPrc[year][mon]; }
   else { prc = MkdSlsPrc[year + 1][mon]; }

   var mkd = MkdVal[year][mon]
   MkdVal[year][mon] = (SlsVal[year][mon] * prc / 100).toFixed(1);
   MkdCell[year][mon].value = format(MkdVal[year][mon]);
}

//==============================================================================----------------------
// calculate New EMI by Open to Receive if fixed receipts calculation selected
//==============================================================================----------------------
function clcEombySls(year, mon, diff)
{
   for(var i=0; i < 2; i++)
   {
      if(i <= year)
      {
         for(var j=0; j < NumOfMon; j++)
         {
           if(i < year || j >= mon)
           {
              InvVal[i][j] = eval(InvVal[i][j]) - diff;
              EmiCell[i][j].value = format(InvVal[i][j]);
              ApplyInv[i][j] = (InvVal[i][j]/1000).toFixed(4);
           }
         }
      }
   }
}
//==============================================================================----------------------
// calculate New EMI by Open to Receive if fixed receipts calculation selected
//==============================================================================----------------------
function clcEombyOtr(year, mon, diff)
{
   for(var i=1; i >= 0; i--)
   {
      if(i <= year)
      {
         for(var j=0; j < NumOfMon; j++)
         {
           if(i < year || j > mon)
           {
              InvVal[i][j] = eval(InvVal[i][j]) - diff;
              EmiCell[i][j].value = format(InvVal[i][j]);
              ApplyInv[i][j] = (InvVal[i][j]/1000).toFixed(4);
           }
         }
      }
   }
}
//==============================================================================
// update screen with new plan values recalculate derivative values
//==============================================================================
function setNewPlanValues()
{
   setCellVal(SlsVal, SlsTot, SlsCell, SlsTotCell);
   setChgCellVal(SlsVal, SlsTot, ChgSlsCell, ChgSlsTotCell);
   setCellVal(MkdVal, MkdTot, MkdCell, MkdTotCell);
   setChgMkdCellVal();

   setCellVal(InvVal, EmiTot, EmiCell, EmiTotCell);
   setChgCellVal(InvVal, EmiTot, ChgEmiCell, ChgEmiTotCell);

   setBmiVal();
   setSsrVal();
   setFcwVal();
   setAswVal();
   setTurnVal();

   setRfpVal();
   setCbiVal();
   setOtrVal();

   setOtbVal();
   setOcfVal();
}
//==============================================================================
// save new Plans
//==============================================================================
function saveNewPlan()
{
   var url = "PlanSave.jsp?"
      + "DEPARTMENT=" + Department
      + "&CLASS=" + Class
      + "&ChgPlan=" + ChgPlan

   // check store selected for current inquiry
   for(var i=0; i < Division.length; i++) { url += "&Div=" + Division[i]; }


   // check store selected for current inquiry
   for(var i=0; i < SelStr.length; i++) { url += "&STORE=" + SelStr[i]; }

   // save plans applied from last year actual sales
   if(ApplyHist != null){ url += "&Hist=" + ApplyHist; }
   else
   {
      url += "&Hist=0";
      url += clcSendingPercent(ApplySls, SlsVal, SaveSlsVal, "Sls");
      url += clcSendingPercent(ApplyInv, InvVal, SaveInvVal, "Inv");
      url += clcSendingPercent(ApplyMkd, MkdVal, SaveMkdVal, "Mkd");
   }

   //alert(url)
   //window.location.href=url;
   window.frame1.location=url;
}
//==============================================================================
// calculate final sending percent of value changes
//==============================================================================
function clcSendingPercent(apply, newVal, amt, tag)
{
   var url = "";
   var allowAmt = SelStr.length == 1
                  && SelStr[0] != Store[0]
                  && SelStr[0] != Store[1]
                  && SelStr[0] != Store[2]
                  && SelStr[0] != Store[3]
                  && Class != "ALL";

   for(var i=0; i < 2; i++)
   {
      if(apply[i] == null) { apply[i] = new Array(); }
      for(var j=0; j < NumOfMon; j++)
      {
         if(apply[i][j] != null)
         {
            if (apply[i][j].substring(0, 1) != "%" && allowAmt) { apply[i][j] = "$" + (eval(apply[i][j]) * 1000).toFixed(0);}
            else if(apply[i][j].substring(0, 1) != "%" && amt[i][j] != 0) {  apply[i][j] = (apply[i][j] * 1000 / amt[i][j]).toFixed(4); }
            else if(apply[i][j].substring(0, 1) != "%" && amt[i][j] == 0) { apply[i][j] = 0; }
            else if(apply[i][j].substring(0, 1) == "%" && amt[i][j] != 0) { apply[i][j] = (newVal[i][j] / amt[i][j]).toFixed(4);}
            else if(amt[i][j] == 0) { apply[i][j] = "";}
         }
         else { apply[i][j] = "" };

         url += "&" + tag + "=" + apply[i][j];
      }
   }

   return url;
}
//==============================================================================
// re-display Planning screen
//==============================================================================
function redisplayPlanning()
{
   location.reload();
}
//==============================================================================
// reset new Plans
//==============================================================================
function resetNewPlan(grp)
{
   document.all.Calc[0].style.display="inline";
   document.all.Calc[1].style.display="inline";
   document.all.Apply[0].style.display="inline";
   document.all.Apply[1].style.display="inline";
   document.all.Save[0].style.display="none";
   document.all.Save[1].style.display="none";
   ApplyHist = null;

   // reset values
   for(var i=0; i < NumOfYr; i++)
   {
      for(var j=0; j < NumOfMon; j++)
      {
         if(grp=="SLS") SlsVal[i][j] = SaveSlsVal[i][j];
         if(grp=="MKD") MkdVal[i][j] = SaveMkdVal[i][j];
         if(grp=="INV" || grp=="OTR") InvVal[i][j] = SaveInvVal[i][j];
      }
   }

   ApplySls = new Array();
   ApplyInv = new Array();
   ApplyMkd = new Array();

   // update screen with new plan values recalculate derivative values
   setNewPlanValues();
}
//==============================================================================
// show selection screen
//==============================================================================
function selectPanel()
{
   var html = "<table border='0'>"
       + "<tr style='font-size:10px'>"
         + "<td style='text-align:right' nowrap>Division"

   if(Division.length == 1){ html += " (<a href='javascript: rtvDivDptCls(1)'>Prompt</a>)"; }

   html += ": </td><td>"

   if(Division.length == 1){ html += "<input name='DIVISION' value='" + Division[0] + "' class='Small' size='3' maxlength='3'><br>"; }
   else
   {
      for(var i=0; i < Division.length; i++)
      {
          html += "<input name='Div' type='checkbox' value='" + Division[i] + "' class='Small' checked>"
               +  Division[i] + " &nbsp; &nbsp; "
      }
      html += "<br>";
   }

   if(Division.length == 1)
   {
      html += "<select name='DivSel' onchange='doDivSelect(this.selectedIndex);' class='Small' style='visibility:hidden'></select></td>"
           + "<td style='text-align:right'>&nbsp;&nbsp; Department: </td>"
           + "<td><input name='DEPARTMENT' value='" + Department + "' class='Small' size='3' maxlength='3'><br>"
           + "<select name='DptSel' onchange= 'doDptSel(this.selectedIndex)' class='Small' style='visibility:hidden'></select></td>"
         + "</tr>"
         + "<tr style='font-size:10px'>"
           + "<td style='text-align:right' nowrap>Class (<a href='javascript: rtvDivDptCls(2)'>Prompt</a>): </td>"
           + "<td><input name='CLASS' value='" + Class + "' class='Small' size='4' maxlength='4'><br>"
           + "<select name='ClsSel' onchange= 'doClsSelect(this.selectedIndex)' class='Small' style='visibility:hidden'></select></td>"
   }
   html += "</tr>"
       + "<tr style='font-size:10px'>"
       + "<td style='text-align:right'>Store: </td>"
       + "<td colspan='3'>"

       html += "<button class='Small' onClick='chgStrSel(&#34;ALL&#34;)'>All</button>&nbsp;"
       html += "<button class='Small' onClick='chgStrSel(&#34;SAS&#34;)'>Sun & Ski</button>&nbsp;"
       html += "<button class='Small' onClick='chgStrSel(&#34;SCH&#34;)'>Ski Chalet</button>&nbsp;"
       html += "<button class='Small' onClick='chgStrSel(&#34;SSC&#34;)'>Sun & Ski + Ski Chalet</button>&nbsp; &nbsp;"
       html += "<button class='Small' onClick='chgStrSel(&#34;Clear&#34;)'>Clear</button><br>"

       for(var i=0; i < Store.length; i++)
       {
         html += "<input name='STORE' type='checkbox' value='" + Store[i] + "' class='Small'>" + Store[i]
         if(i == 15 || i== 30) html += "<br>";
       }

       html += "</td></tr>"
       + "<tr style='font-size:10px'>"
         + "<td style='text-align:right'>Value: </td>"
         + "<td ><input name='ChgPlan' type='radio' value='R' class='Small' >Retail</td>"
         + "<td ><input name='ChgPlan' type='radio' value='C' class='Small' >Cost</td>"
         + "<td ><input name='ChgPlan' type='radio' value='U' class='Small' >Unit</td>"
         + "</td>"
       + "</tr>"
       + "<tr style='font-size:10px'>"
         + "<td colspan='4' style='text-align:center' >"
           + "<button onClick='hidePanel(&#34;Prompt&#34;)' class='Small'>Close</button>&nbsp;"
           + "<button onClick='validateReport(false)' class='Small'>Submit</button>&nbsp;"
           + "<button onClick='validateReport(true)' class='Small'>Submit in New Window</button>"
         + "</td>"
       + "</tr>"

       + "</table>"
   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft= 20;
   document.all.Prompt.style.pixelTop= 20;
   document.all.Prompt.style.visibility = "visible";
   checkSelValues();
}
//==============================================================================
// change Store selection
//==============================================================================
function chgStrSel(selstr)
{
  var strchk = document.all.STORE;

  for(var i=0; i < strchk.length; i++)
   {
      strchk[i].checked = false;
      var numstr = strchk[i].value;

      if(selstr=="ALL") { strchk[i].checked = true}
      else if(selstr=="SAS" && numstr >= 3 && numstr <= 98 && numstr != 35 && numstr != 46 && numstr != 55
        && numstr != 70 && numstr != 86 && numstr != 89)
      { strchk[i].checked = true}
      else if(selstr=="SCH" && (numstr == 35 || numstr == 46 || numstr == 55))
      { strchk[i].checked = true}
      else if(selstr=="SSC" && numstr >= 3 && numstr <= 98
        && numstr != 86 && numstr != 89)
      { strchk[i].checked = true}
   }
}
//==============================================================================
// show POs by Vendor
//==============================================================================
function showPObyVen(obj)
{
   var yr = obj.substring(3, 4);
   var mon = obj.substring(5);
   ven = PoVen[yr][mon];
   vennm = PoVenName[yr][mon];
   ret = PoVenRet[yr][mon];
   cst = PoVenCst[yr][mon];
   unt = PoVenUnt[yr][mon];

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
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;Prompt&#34;);' alt='Close'>"
       + "</td>"
      + "</tr>"
      + "<tr>"
        + "<th class='DataTable' colspan='5' nowrap>Selected Month: " + MonName[mon] + " '" + Year[yr] + "</th>"
      + "</tr>"
      if (dptcls != null)
      {
        html += "<tr>"
          + "<th class='DataTable' colspan='5' nowrap><a href='javascript: showPObyDdc(&#34;" + obj + "&#34;)'>"
          + "PO's by " + dptcls + "</a>"
          + "</th>"
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

   //vendor totals
   html += "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap colspan='2'>Total</td>"
          + "<td class='DataTable' nowrap>" + format(totr) + "</td>"
          + "<td class='DataTable' nowrap>" + format(totc) + "</td>"
          + "<td class='DataTable' nowrap>" + format(totu) + "</td>"
        + "</tr>"
   html += "</table>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft= document.documentElement.scrollLeft + 200;
   document.all.Prompt.style.pixelTop= document.documentElement.scrollTop + 200;
   document.all.Prompt.style.visibility = "visible";
}

//==============================================================================
// show POs by Div/Dpt/Cls
//==============================================================================
function showPObyDdc(obj)
{
   var yr = obj.substring(3, 4);
   var mon = obj.substring(5);

   var code= PoDdc[yr][mon];
   var codenm = PoDdcName[yr][mon];
   var ret = PoDdcRet[yr][mon];
   var cst = PoDdcCst[yr][mon];
   var unt = PoDdcUnt[yr][mon];

   var totr = 0;
   var totc = 0;
   var totu = 0;

   var dptcls = "Department";
   if (Department != "ALL" && Class == "ALL") dptcls = "Class";

   var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td colspan='4' class='BoxName' nowrap>Purchase Orders by " + dptcls + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;Prompt&#34;);' alt='Close'>"
       + "</td>"
      + "</tr>"
      + "<tr>"
        + "<th class='DataTable' colspan='5' nowrap>Selected Month: " + MonName[mon] + " '" + Year[yr] + "</th>"
      + "</tr>"
      + "<tr>"
        + "<th class='DataTable' colspan='5' nowrap><a href='javascript: showPObyVen(&#34;" + obj + "&#34;)'>PO's by Vendor</a>&nbsp;&nbsp;&nbsp;"
        + "</th>"
      + "</tr>"

      + "<tr>"
        + "<th class='DataTable' nowrap>" + dptcls + "</th>"
        + "<th class='DataTable' nowrap>" + dptcls + " Name</th>"
        + "<th class='DataTable' nowrap>Retail</th>"
        + "<th class='DataTable' nowrap>Cost</th>"
        + "<th class='DataTable' nowrap>Unit</th>"
      + "</tr>";

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

   //Dpt/calss totals
   html += "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap colspan='2'>Total</td>"
          + "<td class='DataTable' nowrap>" + format(totr) + "</td>"
          + "<td class='DataTable' nowrap>" + format(totc) + "</td>"
          + "<td class='DataTable' nowrap>" + format(totu) + "</td>"
        + "</tr>"

   html += "</table>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft= document.documentElement.scrollLeft + 200;
   document.all.Prompt.style.pixelTop= document.documentElement.scrollTop + 200;
   document.all.Prompt.style.visibility = "visible";
}

//==============================================================================
// show margins parameters
//==============================================================================
function marginPanel()
{
   var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td colspan='14' class='BoxName' nowrap>Margins</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;Prompt&#34;);' alt='Close'>"
       + "</td>"
      + "</tr>"
      + "<tr>"
        + "<th class='DataTable' nowrap>&nbsp;</th>"
        + "<th class='DataTable' nowrap>Year</th>"
        + "<th class='DataTable' nowrap>Total</th>";

    for(var i=0; i < NumOfMon; i++) { html += "<th class='DataTable' nowrap>" + MonName[i] + "</th>" }
    html += "</tr>";

   html += calcMargins("GRSMRG", "DataTable2");//Gross Margin
   html += calcMargins("IMU", "DataTable2");//IMU
   html += calcMargins("CMU", "DataTable4");//CMU
   html += calcMargins("MRM", "DataTable2");//MRM
   html += calcMargins("MMU", "DataTable4");//MMU
   html += calcMargins("MKDSLS", "DataTable2");//Mkd/Sls
   html += calcMargins("SELLOFF", "DataTable4");//Selloff
   html += calcMargins("MVI", "DataTable2");//MVI
   html += calcMargins("GMROI", "DataTable4");//GMROI

   html += "</table>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft = 150;
   document.all.Prompt.style.pixelTop = -250;
   IntervalId = setInterval("movePanel()", 1);
   document.all.Prompt.style.visibility = "visible";

   // total
   for(var i=0; i < 9; i++)
   {
      for(var j=0; j < 2; j++) { document.all["TotMrg" + j][i].innerHTML = TotMargins[i][j]; }
   }
}
//==============================================================================
// Panel animation
//==============================================================================
function movePanel()
{
   var incrX=10, incrY= 40;

   if(document.all.Prompt.style.pixelTop > 100) { incrX = incrX * 2; }

   //document.all.Prompt.style.pixelLeft += incrX;
   document.all.Prompt.style.pixelTop += incrY;

   // stop movement
   if(document.all.Prompt.style.pixelTop >= 130){ clearInterval(IntervalId); }
}
//==============================================================================
// Calculate Margins
//==============================================================================
function calcMargins(mrg, csscls)
{
   var html ='';
   var amt = 0;
   tot = new Array(10);
   for(var i=0; i < 10; i++){ tot[i] = 0}; // initialize margin totals

   var rowname = mrg;
   if(mrg=="GRSMRG") rowname = "Gross Margin"
   if(mrg=="MKDSLS") rowname = "Mkd / Sls"
   if(mrg=="SELLOFF") rowname = "Selloff"

   for(var i=0; i < 2; i++)
   {
      html += "<tr class='" + csscls + "'>"
      if(i==0) html += "<td class='DataTable1' rowspan='2' nowrap>" + rowname + "</td>";
      html += "<td class='DataTable1' nowrap>" + Year[i] + "</td>"
            + "<td class='DataTable1' id='TotMrg"+ i + "' nowrap>&nbsp;</td>"

      for(var j=0; j < NumOfMon; j++)
      {
         html += "<td class='DataTable1' nowrap>&nbsp;&nbsp;"
         if(mrg=="GRSMRG")
         {
            amt = calcGrossMargin(RetSlsVal[i][j], CstSlsVal[i][j]);
            tot[0] += eval(RetSlsVal[i][j]); tot[1] += eval(CstSlsVal[i][j]);
         }
         else if(mrg=="IMU")
         {
            amt = calcIMU(CstInvVal[i][j], CstSlsVal[i][j], RetInvVal[i][j], RetSlsVal[i][j], RetMkdVal[i][j]);
            tot[0] += eval(CstInvVal[i][j]); tot[1] += eval(CstSlsVal[i][j]); tot[2] += eval(RetInvVal[i][j]); tot[3] += eval(RetSlsVal[i][j]); tot[4] += eval(RetMkdVal[i][j]);
         }
         else if(mrg=="CMU")
         {
            amt = calcCMU(CstInvVal[i][j], RetInvVal[i][j]);
            tot[0] += eval(CstInvVal[i][j]); tot[1] += eval(RetInvVal[i][j]);
         }
         else if(mrg=="MRM")
         {
            amt = calcMRM(CstInvVal[i][j], CstSlsVal[i][j], RetInvVal[i][j], RetSlsVal[i][j]);
            tot[0] += eval(CstInvVal[i][j]); tot[1] += eval(CstSlsVal[i][j]); tot[2] += eval(RetInvVal[i][j]); tot[3] += eval(RetSlsVal[i][j]);
         }
         else if(mrg=="MMU")
         {
           amt = calcMMU(CstSlsVal[i][j], RetSlsVal[i][j]);
           tot[0] += eval(CstSlsVal[i][j]); tot[1] += eval(RetSlsVal[i][j]);
         }
         else if(mrg=="MKDSLS")
         {
           amt = calcMkdSls(RetMkdVal[i][j], RetSlsVal[i][j]);
           tot[0] += eval(RetMkdVal[i][j]); tot[1] += eval(RetSlsVal[i][j]);
         }
         else if(mrg=="SELLOFF")
         {
           amt = calcSelloff(UntSlsVal[i][j], UntInvVal[i][j]);
           tot[0] += eval(UntSlsVal[i][j]); tot[1] += eval(UntInvVal[i][j]);
         }
         else if(mrg=="MVI")
         {
           amt = calcMVI(CstSlsVal[i][j], RetSlsVal[i][j], UntSlsVal[i][j], UntInvVal[i][j]);
           tot[0] += eval(CstSlsVal[i][j]); tot[1] += eval(RetSlsVal[i][j]); tot[2] += eval(UntSlsVal[i][j]); tot[3] += eval(UntInvVal[i][j]);
         }
         else if(mrg=="GMROI")
         {
           amt = calcGMROI(RetSlsVal[i][j], CstSlsVal[i][j], CstInvVal[i][j]);
           tot[0] += eval(RetSlsVal[i][j]); tot[1] += eval(CstSlsVal[i][j]); tot[2] += eval(CstInvVal[i][j]);
         }
         html += amt + "&nbsp;&nbsp;</td>"
      }
      html += "</tr>"
      // total
      if(mrg=="GRSMRG") { TotMargins[0][i] = calcGrossMargin(tot[0], tot[1]); }
      else if(mrg=="IMU") { TotMargins[1][i] = calcIMU(tot[0], tot[1], tot[2], tot[3], tot[4]); }
      else if(mrg=="CMU") { TotMargins[2][i] = calcCMU(tot[0], tot[1]); }
      else if(mrg=="MRM") { TotMargins[3][i] = calcMRM(tot[0], tot[1], tot[2], tot[3]); }
      else if(mrg=="MMU") { TotMargins[4][i] = calcMMU(tot[0], tot[1]); }
      else if(mrg=="MKDSLS") { TotMargins[5][i] = calcMkdSls(tot[0], tot[1]); }
      else if(mrg=="SELLOFF") { TotMargins[6][i] = calcSelloff(tot[0], tot[1]); }
      else if(mrg=="MVI") { TotMargins[7][i] = calcMVI(tot[0], tot[1], tot[2], tot[3]); }
      else if(mrg=="GMROI") { TotMargins[8][i] = calcGMROI(tot[0], tot[1], tot[2]); }
   }
   return html;
}
//==============================================================================
// Calculate GrossMargin
//==============================================================================
function calcGrossMargin(retSls, cstSls){ return format(( eval(retSls) - eval(cstSls) ).toFixed(0) ); }
//==============================================================================
// Calculate IMU
//==============================================================================
function calcIMU(cstInv, cstSls, retInv, retSls, retMkd)
{
  var amt = 0;
  if(eval(retInv) + eval(retSls) + eval(retMkd) != 0)
  {
    amt = (1 - (eval(cstInv) + eval(cstSls)) / (eval(retInv) + eval(retSls) + eval(retMkd))  ).toFixed(3);
  }
  return amt;
}
//==============================================================================
// Calculate CMU
//==============================================================================
function calcCMU(cstInv, retInv)
{
  var amt = 0;
  if(eval(retInv) != 0)
  {
    amt = (1 - eval(cstInv) / eval(retInv)  ).toFixed(3);
  }
   return amt;
}

//==============================================================================
// Calculate MRM
//==============================================================================
function calcMRM(cstInv, cstSls, retInv, retSls)
{
  var amt = 0;
  if(eval(retInv) + eval(retSls) != 0)
  {
    amt = (1 - (eval(cstInv) + eval(cstSls)) / (eval(retInv) + eval(retSls)) ).toFixed(3);
  }
   return amt;
}
//==============================================================================
// Calculate MMU
//==============================================================================
function calcMMU(cstSls, retSls)
{
  var amt = 0;
  if(eval(retSls) != 0)
  {
    amt = (1 - eval(cstSls) / eval(retSls) ).toFixed(3);
  }
   return amt;
}
//==============================================================================
// Calculate Mkd / Sls
//==============================================================================
function calcMkdSls(retMkd, retSls)
{
  var amt = 0;
  if(eval(retSls) != 0)
  {
    amt = (eval(retMkd) / eval(retSls) ).toFixed(3);
  }
   return amt;
}
//==============================================================================
// Calculate Selloff
//==============================================================================
function calcSelloff(untSls, untInv)
{
  var amt = 0;
  if(eval(untSls) + eval(untInv) != 0)
  {
    amt = (eval(untSls) / (eval(untSls) + eval(untInv)) ).toFixed(3);
  }
   return amt;
}
//==============================================================================
// Calculate MVI = mmu * selloff
 //==============================================================================
function calcMVI(cstSls, retSls, untSls, untInv)
{
   var amt = 0;
   amt = ( calcMMU(cstSls, retSls) * calcSelloff(untSls, untSls, untInv)).toFixed(3);
   return amt;
}
//==============================================================================
// Calculate GMROI
//==============================================================================
function calcGMROI(retSls, cstSls, cstInv)
{
  var amt = 0;
  if(eval(cstSls) + eval(cstInv) != 0)
  {
    amt = (eval(retSls) / (eval(cstSls) + eval(cstInv)) ).toFixed(3);
  }
   return amt;
}

//==============================================================================
// Check selected values
//==============================================================================
function checkSelValues()
{
   if(ChgPlan=="R") document.all.ChgPlan[0].checked=true;
   if(ChgPlan=="C") document.all.ChgPlan[1].checked=true;
   if(ChgPlan=="U") document.all.ChgPlan[2].checked=true;

   // check store selected for current inquiry
   for(var i=0; i < Store.length; i++)
   {
      for(var j=0; j < SelStr.length; j++)
      {
         if(SelStr[j] == Store[i]) { document.all.STORE[i].checked = true; }
      }
   }
}
//==============================================================================
// validate report with new selection
//==============================================================================
function validateReport(newwin)
{

  var msg = " ";
  var error = false;
  var div = new Array();

  if(Division.length == 1){ div[0] = document.all.DIVISION.value.toUpperCase(); }
  else
  {
    var seldiv = false;
    for(var i=0, j=0; i < Division.length; i++)
    {
      if(document.all.Div[i].checked) { div[j++] = document.all.Div[i].value; }
    }
    if (!seldiv) { msg += "\nPlease, check at least 1 division."; error = true; }
  }

  var dpt = document.all.DEPARTMENT.value.toUpperCase();
  var cls = document.all.CLASS.value.toUpperCase();
  var chg;
  var str = new Array();
  var strchk = false;

  if(Store.length > 1)
  {
     for(var i=0, j=0; i < document.all.STORE.length; i++)
     {
        if(document.all.STORE[i].checked) { str[j++] = document.all.STORE[i].value; strchk=true}
     }
  }
  else
  {
     if(document.all.STORE.checked) { str[0] = document.all.STORE.value; strchk=true}
  }

  if(document.all.ChgPlan[0].checked) chg = document.all.ChgPlan[0].value;
  if(document.all.ChgPlan[1].checked) chg = document.all.ChgPlan[1].value;
  if(document.all.ChgPlan[2].checked) chg = document.all.ChgPlan[2].value;

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

  // show error or submit report
  if(error) alert(msg);
  else submitReport(div, dpt, cls, str, chg, newwin);
}
//==============================================================================
// submit report with new selection
//==============================================================================
function submitReport(div, dpt, cls, str, chg, newwin)
{
   var url = "PlanSps.jsp?"
     + "&DEPARTMENT=" + dpt
     + "&CLASS=" + cls

   /*if(Division.length == 1) {url += "&Div=<%=sDivision[0]%>&DIVNAME=<%=sDivision[0] + "-" + sDivName.trim()%>";}
   else
   {
      for(var i=0; i < Division.length; i++)
      {
         url += "&Div=" +  Division[i];
      }
   }*/

   url += "&Div=" +  div;

   for(var i=0; i < str.length; i++) { url += "&STORE=" + str[i]; }

   url += "&AlwChg=" + chg
        + "&Result=" + Result;

   // close selection panel
   hidePanel("Prompt");


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
//==============================================================================
// Hide selection screen
//==============================================================================
function gotoOpenToBuy()
{
   var url="OpenToBuy.jsp?";
   if(Division.length == 1)
   {
      url += "&DIVISION=<%=sDivision[0]%>&DIVNAME=<%=sDivision + "-" + sDivName.trim()%>";
   }
   else
   {
      url += "Mult=Y&DIVISION=ALL&DIVNAME=All Divisions";
      for(var i=0; i < Division.length; i++)
      {
         url += "&Div=" +  Division[i];
      }
   }

   url += "&DEPARTMENT=<%=sDepartment%>&DPTNAME=<%=sDepartment + " - " + sDptName.trim()%>"
        + "<%if(!sClass.equals("ALL")){%>&CLASS=<%=sClass%>&CLSNAME=<%=sClass + " - " + sClsName.trim()%><%}%>"
        + "&STORE=<%=sStore[0]%>&RetVal=<%=sRetVal%>&CstVal=<%=sCstVal%>&UntVal=<%=sUntVal%>&NumMon=12"
        + "&Type=B";

   window.open(url);
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel(panel)
{
   document.all[panel].innerHTML = " ";
   document.all[panel].style.visibility = "hidden";
}
//==============================================================================
// retreive div, dpt, cls and str
//==============================================================================
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

//==============================================================================-
// populate Div, dpt, class list
//==============================================================================-
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

    if (id == null)
    {
        //  populate the division list
        for (var i = 0; i < divLst.length; i++)
        {
            df.DivSel.options[i] = new Option(divName[i],divLst[i]);
            if(divLst[i] == Division) { df.DivSel.selectedIndex=i; id = i; }
        }

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
         if(dptLst[i] == Department) { df.DptSel.selectedIndex=i;}
       }
    }
    //  else display the desired depts
    else
    {
       for (var i = 0; i < allowed.length; i++)
       {
         df.DptSel.options[i] = new Option(dptName[allowed[i]], dptLst[allowed[i]]);
         if(dptLst[allowed[i]] == Department) { df.DptSel.selectedIndex=i;}
       }
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
// fold/unfold History (1 years back )
//==============================================================================
function switchHist()
{
   ShowHist =! ShowHist;
   if(!ShowHist)
   {
      //document.all.PSAR2.style.display="none";
      //document.all.PSPR0.style.display="none";
      //document.all.PSPR1.style.display="none";

      for(var i=0; i < 2; i++)
      {
        document.all["PASAR" + i].style.display="none";
        document.all["PBSAR" + i].style.display="none";
        document.all["AMKDA" + i].style.display="none";
        document.all["BMKDA" + i].style.display="none";
        document.all["AEMIA" + i].style.display="none";
        document.all["BEMIA" + i].style.display="none";
        document.all["AOTRA" + i].style.display="none";
        document.all["BOTRA" + i].style.display="none";
      }

      //document.all.MKDA2.style.display="none";
      //document.all.MKDP0.style.display="none";
      //document.all.MKDP1.style.display="none";
      //document.all.MKDP2.style.display="none";

      //document.all["PORDA2"].style.display="none";

      //document.all.EMIA2.style.display="none";
      //document.all.PHINR.style.display="none";

      //document.all.EMIP0.style.display="none";
      //document.all.EMIP1.style.display="none";
   }
   else
   {
      //document.all.PSAR2.style.display="block";
      //document.all.PSPR0.style.display="block";
      //document.all.PSPR1.style.display="block";
      for(var i=0; i < 2; i++)
      {
         document.all["PASAR" + i].style.display="block";
         document.all["PBSAR" + i].style.display="block";
         document.all["AMKDA" + i].style.display="block";
         document.all["BMKDA" + i].style.display="block";
         document.all["AEMIA" + i].style.display="block";
         document.all["BEMIA" + i].style.display="block";
         document.all["AOTRA" + i].style.display="block";
         document.all["BOTRA" + i].style.display="block";
      }

      //document.all.MKDA2.style.display="block";
      //document.all.MKDP0.style.display="block";
      //document.all.MKDP1.style.display="block";
      //document.all.MKDP2.style.display="block";

      //document.all["PORDA2"].style.display="block";

      //document.all.EMIA2.style.display="block";
      //document.all.PHINR.style.display="block";
      //document.all.EMIP0.style.display="block";
      //document.all.EMIP1.style.display="block";
   }
}

//==============================================================================
// fold/unfold Open to Buy section
//==============================================================================
function switchOTB()
{
   ShowOtb =! ShowOtb;
   if(!ShowOtb)
   {
      for(var i=0; i < 4; i++)
      {
        document.all["RFPR" + i].style.display="none";
        document.all["CBIR" + i].style.display="none";
        document.all["OTBR" + i].style.display="none";
        document.all["OCFR" + i].style.display="none";
      }
      document.all["PSLPPR"].style.display="none";
      document.all["ASMTDR"].style.display="none";
      document.all["MDLPPR"].style.display="none";
   }
   else
   {
      for(var i=0; i < 4; i++)
      {
        document.all["RFPR" + i].style.display="block";
        document.all["CBIR" + i].style.display="block";
        document.all["OTBR" + i].style.display="block";
        document.all["OCFR" + i].style.display="block";
      }
      document.all["PSLPPR"].style.display="block";
      document.all["ASMTDR"].style.display="block";
      document.all["MDLPPR"].style.display="block";
   }
}
//==============================================================================
// fold/unfold Stats section
//==============================================================================
function switchStats()
{
   ShowStats =! ShowStats;
   if(!ShowStats)
   {
      for(var i=0; i < 3; i++)
      {
        document.all["TRNR" + i].style.display="none";

      }
      document.all["SSRR"].style.display="none";
      document.all["FCWR"].style.display="none";
      document.all["ASWR"].style.display="none";
      document.all["TRNR" + NumOfYr].style.display="none";
   }
   else
   {
      for(var i=0; i < 3; i++)
      {
        document.all["TRNR" + i].style.display="block";
      }
      document.all["SSRR"].style.display="block";
      document.all["FCWR"].style.display="block";
      document.all["ASWR"].style.display="block";
      document.all["TRNR" + NumOfYr].style.display="block";
   }
}
//==============================================================================-
// change Open to receive calculateion model
//==============================================================================-
function chgOtrCalc(otrcalc)
{
  OtrCalc = otrcalc.options[otrcalc.selectedIndex].value;
  document.all.OTR0M0.focus();
  document.all.OTR0M0.select();
}
//==============================================================================-
// change Open to receive calculateion model
//==============================================================================-
function chgMkdCalc(mkdcalc)
{
   MkdCalc = mkdcalc.options[mkdcalc.selectedIndex].value;
}
//==============================================================================-
// populate Month OTB calculation selector
//==============================================================================-
function popSelMonCalc()
{
  var selMon = document.all.selMonCalc;
  for(var i=0, j=CurMon-1, k=0; i < MonName.length; i++, j++, k=0)
  {
     if( j >= 12 ) { j=0;}
     if (j >= CurMon-1) { k = 1; }
     selMon.options[i] = new Option(MonName[j] + " " + Year[k], j);
     OTBMonList[i] = j;
     OTBYearList[i] = k;
  }
}
//==============================================================================-
// change selected month for OTB calculation
//==============================================================================-
function chgMonCalc()
{
   var selMon = document.all.selMonCalc;
   var i = selMon.selectedIndex;
   var mon = selMon[i].value;
   var monnm = selMon[i].text;

   showOTBRep(mon, monnm);
}

//==============================================================================
// show Montly Values and Calculation
//==============================================================================
function showOTBRep(mon, monnm)
{
   document.all.thMonCalc.innerHTML = "Month: " + monnm;
   var html = popOTBRep(mon, monnm);
   document.all.tdMonCalc.innerHTML = html;

   var year = 0;
   if (mon >= CurMon-1) { year = 1; }

   var whspc = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";

   // Inventory Plan
   document.all.tdINVP.innerHTML = format_as_is(InvVal[year][mon], 0);

   // Current Beginning Month Inventory
   var bom = LdgInv;
   document.all.tdCBI.innerHTML = format_as_is(bom, 0) + whspc;

   // Sales Plan and Less period passed
   var sls = sumMonAmt(SlsVal, mon);
   document.all.tdLNSP.innerHTML = "(" + format_as_is(sls, 0) + ")" + whspc;

   var lpsls = Percent * SlsVal[1][CurMon-1];
   document.all.tdANSP.innerHTML = format_as_is(lpsls, 0) + whspc;

   // Markdown and Less period passed
   var mkd = sumMonAmt(MkdVal, mon);
   document.all.tdLNMP.innerHTML = "(" + format_as_is(mkd, 0) + ")"  + whspc;
   var lpmkd = Percent * MkdVal[1][CurMon-1];
   document.all.tdALNMP.innerHTML = format_as_is(lpmkd, 0) + whspc;

   // Open Purchase order
   var opo = sumMonAmt(POVal, mon);
   document.all.tdAOPPO.innerHTML = format_as_is(opo, 0) + whspc;

   // sub-total
   var subtot = bom - sls + lpsls - mkd + lpmkd + opo
   document.all.tdSTOT.innerHTML = format_as_is(eval(subtot), 0);

   // Open to Buy Carry forward
   document.all.tdOPTOB.innerHTML = format_as_is(OcfVal[year][mon], 0);
}
//==============================================================================-
// print Monthly Calculation
//==============================================================================-
function prtMonCalc()
{
   try { prtWindow.close() } catch(err){}

   var html = "<style>body { text-align:center;}"
        + "table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}"
        + "th.DataTable { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }"
        + "th.DataTable1 { background:;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }"
        + "tr.Button { background:ivory; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px}"
        + "tr.DataTable2 { background:CornSilk; font-family:Arial; font-size:10px }"
        + "td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;"
        + "padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}"
        + "td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;"
        + "padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}"
        + "td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;"
        + "padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center;}"
        + " tr.MonCalc { color:black; font-family:Arial; font-size:12px; font-weight: bold }"
        + "</style><body onload='this.focus()'><table>"
        + "<tr>" + document.all.trTopHdr1.innerHTML + "</tr>"
        + "<tr>" + document.all.trTopHdr2.innerHTML + "</tr></table>"
        + "<table><tr class='MonCalc'><th colspan=2>" + document.all.thMonCalc.innerHTML + "</th></tr>"
        + "<tr><td>" + document.all.tdMonCalc.innerHTML + "</td></tr></table></body>"
   prtWindow = window.open('', 'prtCalc', 'toolbar=yes, directories=no, location=no, status=yes, menubar=no, resizable=yes, scrollbars=no,   width=500, height=300');
   prtWindow.document.write(html);
}
//==============================================================================-
// summarize amount from current month to selected
//==============================================================================-
function sumMonAmt(amt, mon)
{
  var sum = 0;

  for(var i=0, y=0, m=-1; i < 12 && m != mon;  i++)
  {
     y=OTBYearList[i];
     m=OTBMonList[i];
     sum += eval(amt[y][m]);
  }
   return sum;
}
//==============================================================================-
// populate Montly Values and Calculation table
//==============================================================================-
function popOTBRep(i, monnm)
{
   var period = MonName[CurMon - 1] + " " + Year[1] + " - " + monnm;
   var curper = MonName[CurMon - 1] + " " + Year[1];

   var html = "<table class='DataTable' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap>Inventory Plan (EOM " + monnm + ")</td>"
          + "<td class='DataTable' id='tdINVP' nowrap>0</td>"
      + "</tr>"
      + "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap>Current Inventory (Stock Ledger)</td>"
          + "<td class='DataTable' id='tdCBI' nowrap>0</td>"
      + "</tr>"
      + "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap>Less Net Sales Plan (" + period + ")</td>"
          + "<td class='DataTable' id='tdLNSP' nowrap>0</td>"
      + "</tr>"
      + "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap>Add Less Period Pass</td>"
          + "<td class='DataTable' id='tdANSP' nowrap>0</td>"
      + "</tr>"
      + "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap>Less Net Markdown Plan (" + period + ")</td>"
          + "<td class='DataTable' id='tdLNMP' nowrap>( 0 )</td>"
      + "</tr>"
      + "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap>Add Less Period Pass</td>"
          + "<td class='DataTable' id='tdALNMP' nowrap>0</td>"
      + "</tr>"
      + "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap>Add Open Purchase Order (" + period + ")</td>"
          + "<td class='DataTable' id='tdAOPPO' nowrap>0</td>"
      + "</tr>"
      + "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap>Sub-Total</td>"
          + "<td class='DataTable' id='tdSTOT' nowrap>0</td>"
      + "</tr>"
      + "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap>Open to Buy Carry Forward</td>"
          + "<td class='DataTable' id='tdOPTOB' nowrap>0</td>"
      + "</tr>"
   html += "</table>";

   return html;
}
//==============================================================================-
// show Month column values and calculation
//==============================================================================-
function showMonthValue(i, monnm)
{
   var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap>Month: " + monnm + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;Prompt&#34;);' alt='Close'>"
       + "</td>"
      + "</tr>"
   //
   html += "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap colspan='2'>" + popMonthValue(i) + "</td>"
        + "</tr>"
        + "<tr class='DataTable2'>"
          + "<td align=center nowrap colspan='2'>"
            + "<button onclick='javascript:hidePanel(&#34;Prompt&#34;);'>Close</button>"
          + "</td>"
        + "</tr>"

   html += "</table>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft= document.documentElement.scrollLeft + 200;
   document.all.Prompt.style.pixelTop= document.documentElement.scrollTop + 200;
   document.all.Prompt.style.visibility = "visible";
}
//==============================================================================-
// populate Month values table
//==============================================================================-
function popMonthValue(i)
{
   var html = "<table class='DataTable' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr class='DataTable2'>"
          + "<th class='DataTable' nowrap colspan='2'>Year " + Year[1] +"</th>"
          + "<th class='DataTable' nowrap colspan='2'>Year " + Year[0] +"</th>"
      + "</tr>"
      + "<tr class='DataTable2'>"
          + "<td nowrap valign=Top colspan='2'>" + popMonVal(1, i) + "</td>"
          + "<td nowrap valign=Top colspan='2'>" + popMonVal(0, i) + "</td>"
      + "</tr>"
   html += "</table>";

   return html;
}
//==============================================================================-
// populate Month value
//==============================================================================-
function popMonVal(i, j)
{
   var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
   if(i==1 && j == CurMon-1)
   {
      html += "<tr class='DataTable2'>"
            + "<td class='DataTable1' nowrap>Stock Ledger Inventory(Ledger) </td>"
            + "<td class='DataTable' nowrap>" + format(LdgInv) + "</td>"
         + "</tr>"
   }
   if(i==0 && j == CurMon-1)
   {
      html += "<tr class='DataTable2'>"
            + "<td class='DataTable1' nowrap  colspan='2'>&nbsp;</td>"
         + "</tr>"
   }
   html += "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap>Begining Of Month Inventory (BOM) </td>"
          + "<td class='DataTable' nowrap >" + format(BmiVal[i][j]) + "</td>"
      + "</tr>"
      + "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap >Planned Sales</td>"
          + "<td class='DataTable' nowrap>" + format(SlsVal[i][j]) + "</td>"
      + "</tr>"
      + "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap >Planned Markdowns</td>"
          + "<td class='DataTable' nowrap >" + format(MkdVal[i][j]) + "</td>"
      + "</tr>"
      + "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap>End Of Month Inventory (EOM) </td>"
          + "<td class='DataTable' nowrap >" + format(InvVal[i][j]) + "</td>"
      + "</tr>"
      + "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap >Purchase Orders</td>"
          + "<td class='DataTable' nowrap >" + format(POVal[i][j]) + "</td>"
      + "</tr>"


   if(i==1 && j == CurMon-1)
   {
      html += "<tr class='DataTable2'>"
            + "<td class='DataTable1' nowrap>Less Period Pass Percent(LSP%): </td>"
            + "<td class='DataTable' nowrap>" + (Percent * 100.00) + "%</td>"
         + "</tr>"
   }
   if(i==0 && j == CurMon-1)
   {
      html += "<tr class='DataTable2'>"
            + "<td class='DataTable1' nowrap  colspan='2'>&nbsp;</td>"
         + "</tr>"
   }


   var formula = "RFP = Sales + Mrkdown + EOM<br>&nbsp;"
   if(i==0 || i==1 && j > CurMon-1) { formula = "RFP = Sales + Mrkdown + EOM<br>RFP = " + SlsVal[i][j] + " + " + MkdVal[i][j] + " + " + InvVal[i][j] }
   if(i==1 && j == CurMon-1) { formula = "RFP = (Sales + Markdown) * (1 - LSP%) + EOM<br>RFP = ("
                 + SlsVal[i][j] + " + " + MkdVal[i][j] + ") * (1 - " + Percent + ") + " + InvVal[i][j] }

   var rfp = "&nbsp;";
   if(i==0 || i==1 && j >= CurMon-1) { rfp = format(RfpVal[i][j]); }

   html += "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap >Required for Plan(RFP)<br>" + formula + "</td>"
          + "<td class='DataTable' nowrap >" + rfp + "</td>"
      + "</tr>"

   var otr = "&nbsp;";
   if(i==0 || i==1 && j >= CurMon-1) { otr = format(OtrVal[i][j]); }
   formula = "OTR = RFP - BOM<br>&nbsp;";
   if(i==0 || i==1 && j > CurMon-1) formula = "OTR = RFP - BOM<br>OTR = " + RfpVal[i][j] + " - " + BmiVal[i][j];
   if(i==1 && j == CurMon-1) { formula = "OTR = RFP - Ledger<br>OTR = " + RfpVal[i][j] + " - " + LdgInv}

   html += "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap >Open to Receive<br>" + formula + "</td>"
          + "<td class='DataTable' nowrap >" + otr + "</td>"
      + "</tr>";

   var otb = "&nbsp;";
   if(i==0 || i==1 && j >= CurMon-1) { otb = format(OtbVal[i][j]); }
   formula = "OTB = OTR - PO<br>&nbsp;";
   if(i==0 || i==1 && j >= CurMon-1) formula = "OTB = OTR - PO<br>OTB = " + OtrVal[i][j] + " - " + POVal[i][j];
   html += "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap >Open to buy(OTB)<br>" + formula + "</td>"
          + "<td class='DataTable' nowrap>" + otb + "</td>"
      + "</tr>"

   amt = eval(OtbVal[i][j]);
   if(i == 0 && j == 0) amt = amt + eval(OtbVal[1][11]); // add previous month carry forward
   else if(i == 0 && j > 0) amt = amt + eval(OcfVal[0][j-1]);
   else if(i == 1 && j > CurMon-1) amt = amt + eval(OcfVal[0][j-1]);

   var ocf = "&nbsp;";
   if(i==0 || i==1 && j >= CurMon-1) { ocf = format(OcfVal[i][j]); }
   formula = "OCF = OTB(this Month) + OTB(Last Month)<br>&nbsp;";
   if(i == 0 && j == 0) formula = "OCF = OTB(this Month) + OCF(Last Month)<br>OCF = " + OtbVal[i][j] + " + " + OcfVal[1][11];
   else if(i == 0 || i == 1 && j > CurMon-1) formula = "OCF = OTB(this Month) + OCF(Last Month)<br>OCF = " + OtbVal[i][j] + " + " + OcfVal[i][j-1];
   else if(i == 1 && j == CurMon-1) formula = "OCF = OTB(this Month)<br>OCF = " + OtbVal[i][j];

   //if(i == 0 && j == 0) amt = amt + eval(OtbVal[1][11]) + eval(OtbVal[1][10]) ;

   html += "<tr class='DataTable2'>"
          + "<td class='DataTable1' nowrap >OTB Carry Forward(OCF)<br>" + formula + "</td>"
          + "<td class='DataTable' nowrap>" + ocf + "</td>"
      + "</tr>"

   html += "</table>";

   return html;
}
//==============================================================================-
// fold/unfold Monthly OTB calculation table
//==============================================================================-
function  switchOTBMonCalc()
{
   var tbl = document.all.tblMonCalc
   var disp = "none";
   if (tbl.style.display == "none") { disp = "block"; }
   tbl.style.display = disp;
}
 
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="FormatNumerics.js"></script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

</head>


<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
  <div id="Prompt" class="Prompt"></div>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr id="trTopHdr1">
      <td ALIGN="center" VALIGN="TOP" colspan=5>
        <b>Retail Concepts, Inc
        <br>OTB Planning - Plan C</b>
      </td>
     </tr>

     <tr id="trTopHdr2">
      <td ALIGN="Center" VALIGN="TOP" colspan=5>

      <b>Store: <%=sbStr.toString()%>
      <br>Division:
         <%String sComa="";%>
         <%if(sDivision.length == 1) {%><%=sDivision[0]%><%if(!sDivision.equals("ALL")){%><%=" - " + sDivName%><%}%><%}
          else {%><%for(int i=0; i < sDivision.length; i++) {%><%=sComa + sDivision[i]%><%sComa=",";%><%}%><%}%>
      <br>&nbsp;&nbsp; Department: <%=sDepartment%><%if(!sDepartment.equals("ALL")){%><%=" - " + sDptName%><%}%>
         &nbsp;&nbsp; Class: <%=sClass%><%if(!sClass.equals("ALL")){%><%=" - " + sClsName%><%}%>
      </b>
     </tr>
     <tr class="ManagmentLine">
      <td ALIGN="Center" VALIGN="TOP" colspan="4" style="padding-bottom:5px;">

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="PlanningSel.jsp">
            <font color="red" size="-1">Planning Selection</font></a>&#62;
          <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <a href="javascript: selectPanel();">Report Parameters</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <a href="javascript: marginPanel();">Margins</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <a href="javascript: gotoOpenToBuy();">Open to Buy</a>
      <br>
     </tr>

     <tr class="ManagmentLine">
      <td class="misc2" colspan=4>

        <table border="0" cellPadding="0" cellSpacing="0">
          <tr>
             <td  class="misc2">
               <span style="text-align:left;">&nbsp; Note: All dollars are shown at
               <%if(sChgPlan.equals("R")){%>Retail<%} else if(sChgPlan.equals("C")){%>Cost<%} else {%>Unit<%}%>
               <br>Saved changes on this screen are applied to plan C.&nbsp;</span>
          </td>
          <td class="misc2">
              <button name="Apply" onClick="applyLYActual()" class="Small">Apply LY<br>Actual</button>&nbsp;&nbsp;
              <button name="Apply" onClick="applyCurPlan()" class="Small">Apply Current<br>Plan</button>&nbsp;&nbsp;
              <button name="Apply" onClick="applyBuck()" class="Small">Apply<br>$1.00</button>&nbsp;&nbsp;
              <button name="Calc" onClick="clcNewPlan()" class="Small">Calc</button>&nbsp;&nbsp;
              <button name="Save" onClick="saveNewPlan()" class="Small">Save</button>
           </td>
           <td class="misc2" >&nbsp;&nbsp;
              Result Shows in<br>&nbsp;&nbsp;<select name="Result" class="Small"></select>&nbsp;
                        <button name="Reset" onClick="chgResultSel();" class="Small">Change</button>
           </td>

           <td class="misc2" >&nbsp;&nbsp;
               Open to Receive Calc<br>&nbsp;&nbsp;<select name="OtrCalc" class="Small" onChange="chgOtrCalc(this)">
                      <option value="EOM">Fixed EOM</option>
                      <option value="RCP">Fixed Receipts</option>
                    </select>&nbsp;
           </td>
           <td class="misc2" nowrap>&nbsp;&nbsp;
           Markdowns calculation<br>&nbsp;&nbsp;<select name="MkdCalc" class="Small" onChange="chgMkdCalc(this)">
                      <option value="ASYNC">Not Synchronize</option>
                      <option value="SYNCLY">Sync. w/LY % of sales</option>
                      <option value="SYNCTY">Sync. w/TY % of sales</option>
                    </select>&nbsp;
           </td>
           <td class="misc2" nowrap>&nbsp;&nbsp;<a href="javascript: switchOTBMonCalc()">Fold/Unfold</a> Month OTB<br> &nbsp; Calculation panel</td>
         </tr>
       </table>
     </tr>
     <tr>
      <td ALIGN="Center" VALIGN="TOP" colspan=5><br>
   <table cellPadding="5" cellSpacing="5">
    <tr><td>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0"  id="tblPlan">
        <tr>
	  <th class="DataTable" ><a href="javascript: switchHist()">Fold/Unfold Hist</a></th>
          <th class="DataTable" >Year</th>
          <th class="DataTable" >Total</th>
          <!-- Month Names -->
          <%for (int i=0; i < iNumOfMon; i++){%>
               <th class="DataTable"><a href="javascript: showMonthValue(<%=i%>, '<%=sMonName[i]%>')"><%=sMonName[i]%></a></th>
          <%}%>
        </tr>
       <!------------------------------- Data Detail --------------------------------->
       <!------------------------------- BOM Inventory --------------------------------->
       <%for(int i=0; i < 3; i++) {%>
           <tr class="<%=sCSSCls%>">
              <%if(i==0) {%><td class="DataTable" rowspan="3">BOM Inventory</td><%}%>
              <td class="DataTable"><%=sYear[i]%></td>
              <td class="DataTable">&nbsp;</td>
              <%for(int j=0; j < iNumOfMon; j++) {%>
                    <td class="DataTable" id="BMI<%=i%>M<%=j%>"></td>
              <%}%>
           </tr>
       <%}%>

           <tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
       <!------------------------------- Planned Sales --------------------------------->
           <%for(int i=0; i < iNumOfYr; i++) {%>
                <tr class="<%=sCSSCls%>" id="PSAR<%=i%>">
                   <%if(i==0) {%><td class="DataTable" rowspan="2" >Planned Sales<br>
                        <a href="javascript: resetNewPlan('SLS')">reset</a></td><%}%>
                   <%if(i==2) {%><td class="DataTable">Historical Sales</td><%}%>
                   <td class="DataTable"><%=sYear[i]%></td>
                   <td class="DataTable"><input class="Cell" name="SLS<%=i%>T" readonly maxsize=9
                      onClick="javascript:this.focus();this.select();"></td>

                   <%for(int j=0; j < iNumOfMon; j++) {%>
                       <td class="DataTable"><input class="Cell" name="SLS<%=i%>M<%=j%>" readonly maxsize=9
                          onClick="javascript:this.focus();this.select();"></td>
                   <%}%>
                </tr>
           <%}%>

           <!-- History Plan -->
           <!-- tr class="DataTable1" id="PHSAR">
              <td class="DataTable">History Sale Plans</td>
              <td class="DataTable"><%/*=sYear[2]*/%></td>
              <td class="DataTable" id="HSLST"></td>
              <%/*for(int i=0; i < iNumOfMon; i++) {*/%>
                   <td class="DataTable" id="HSLSM<%/*=i*/%>"></td>
              <%/*}*/%>
           </tr -->

           <!-- Plan A -->
           <%for(int i=0; i < 2; i++) {%>
                <tr class="DataTable1" id="PASAR<%=i%>">
                   <%if(i==0) {%><td class="DataTable" rowspan="2" >Planned Sales (A)</td><%}%>
                   <td class="DataTable"><%=sYear[i]%></td>
                   <td class="DataTable" id="ASLS<%=i%>T"></td>

                   <%for(int j=0; j < iNumOfMon; j++) {%>
                       <td class="DataTable" id="ASLS<%=i%>M<%=j%>"></td>
                   <%}%>
                </tr>
           <%}%>

           <!-- Plan B -->
           <%for(int i=0; i < 2; i++) {%>
                <tr class="DataTable3" id="PBSAR<%=i%>">
                   <%if(i==0) {%><td class="DataTable" rowspan="2" >Planned Sales (B)</td><%}%>
                   <td class="DataTable"><%=sYear[i]%></td>
                   <td class="DataTable" id="BSLS<%=i%>T"></td>

                   <%for(int j=0; j < iNumOfMon; j++) {%>
                       <td class="DataTable" id="BSLS<%=i%>M<%=j%>"></td>
                   <%}%>
                </tr>
           <%}%>

           <!-- % changes -->
           <%for(int i=0; i < iNumOfYr-1; i++) {%>
                <tr class="<%=sCSSCls%>"  id="PSPR<%=i%>">
                   <%if(i==0) {%><td class="DataTable" rowspan="2">% Changes</td><%}%>
                   <td class="DataTable"><%=sYear[i] + "/" + sYear[i+1]%></td>
                   <td class="DataTable" id="CHGSLS<%=i%>T"</td>

                   <%for(int j=0; j < iNumOfMon; j++) {%>
                       <td class="DataTable" id="CHGSLS<%=i%>M<%=j%>"></td>
                   <%}%>
                </tr>
           <%}%>

           <tr class="<%=sCSSCls%>" id="PSLPPR">
             <td class="DataTable" nowrap>Less Period Passed</td>
             <td class="DataTable">&nbsp;</td>
             <td class="DataTable" id="PSLPPT"></td>
             <%for(int j=0; j < iNumOfMon; j++) {%>
                  <td class="DataTable" id="PSLPP<%=j%>"></td>
             <%}%>
           </tr>

           <tr class="<%=sCSSCls%>" id="ASMTDR">
             <td class="DataTable" nowrap>Actual Sales M-T-D</td>
             <td class="DataTable">&nbsp;</td>
             <td class="DataTable" id="ASMTDT"></td>
             <%for(int j=0; j < iNumOfMon; j++) {%>
                  <td class="DataTable" id="ASMTD<%=j%>"></td>
             <%}%>
           </tr>
           <tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
           <!------------------------------- Markdowns --------------------------------->
           <%for(int i=0; i < iNumOfYr; i++) {%>
                <tr class="<%=sCSSCls%>" id="MKDA<%=i%>">
                   <%if(i==0) {%><td class="DataTable" rowspan="2">Planned Markdowns<br>
                        <a href="javascript: resetNewPlan('MKD')">reset</a></td><%}%>
                   <%if(i==2) {%><td class="DataTable">Historical Markdowns</td><%}%>
                   <td class="DataTable"><%=sYear[i]%></td>
                   <td class="DataTable"><input class="Cell" name="MKD<%=i%>T" readonly maxsize=9
                      onClick="javascript:this.focus();this.select();"></td>

                   <%for(int j=0; j < iNumOfMon; j++) {%>
                       <td class="DataTable"><input class="Cell" name="MKD<%=i%>M<%=j%>" readonly maxsize=9
                          onClick="javascript:this.focus();this.select();"></td>
                   <%}%>
                </tr>
           <%}%>

           <!-- History Plan -->
           <!--tr class="DataTable1" id="PHMKR">
              <td class="DataTable">History Markdown Plans</td>
              <td class="DataTable"><%/*=sYear[2]*/%></td>
              <td class="DataTable" id="HMKDT"></td>
              <%/*for(int i=0; i < iNumOfMon; i++) {*/%>
                   <td class="DataTable" id="HMKDM<%/*=i*/%>"></td>
              <%/*}*/%>
           </tr -->

           <!-- % Plan A -->
           <%for(int i=0; i < 2; i++) {%>
                <tr class="DataTable1" id="AMKDA<%=i%>">
                   <%if(i==0) {%><td class="DataTable" rowspan="2">Planned Markdowns (A) </td><%}%>
                   <td class="DataTable"><%=sYear[i]%></td>
                   <td class="DataTable" id="AMKD<%=i%>T"></td>

                   <%for(int j=0; j < iNumOfMon; j++) {%>
                       <td class="DataTable" id="AMKD<%=i%>M<%=j%>"></td>
                   <%}%>
                </tr>
           <%}%>

           <!-- % Plan B -->
           <%for(int i=0; i < 2; i++) {%>
                <tr class="DataTable3" id="BMKDA<%=i%>">
                   <%if(i==0) {%><td class="DataTable" rowspan="2">Planned Markdowns (B) </td><%}%>
                   <td class="DataTable"><%=sYear[i]%></td>
                   <td class="DataTable" id="BMKD<%=i%>T"></td>

                   <%for(int j=0; j < iNumOfMon; j++) {%>
                       <td class="DataTable" id="BMKD<%=i%>M<%=j%>"></td>
                   <%}%>
                </tr>
           <%}%>

           <!-- % changes -->
           <%for(int i=0; i < 3; i++) {%>
                <tr class="<%=sCSSCls%>" id="MKDP<%=i%>">
                   <%if(i==0) {%><td class="DataTable" rowspan="3">% To Sales</td><%}%>
                   <td class="DataTable"><%=sYear[i]%></td>
                   <td class="DataTable" id="CHGMKD<%=i%>T"</td>

                   <%for(int j=0; j < iNumOfMon; j++) {%>
                       <td class="DataTable" id="CHGMKD<%=i%>M<%=j%>"></td>
                   <%}%>
                </tr>
           <%}%>

           <tr class="<%=sCSSCls%>" id="MDLPPR">
             <td class="DataTable" nowrap>Less Period Passed<br>Actual M-T-D *</td>
             <td class="DataTable">&nbsp;</td>
             <td class="DataTable" id="MDLPPT"></td>
             <%for(int j=0; j < iNumOfMon; j++) {%>
                  <td class="DataTable" id="MDLPP<%=j%>"></td>
             <%}%>
           </tr>
           <tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
           <!------------------------------- Recepts --------------------------------->
           <!------------------------------- PO Details ------------------------------------->
           <%for(int i=0; i < 3; i++) {%>
                <tr class="<%=sCSSCls%>" id="PORDA<%=i%>">
                   <%if(i==0) {%><td class="DataTable" rowspan="2">Purchase Orders<br>
                      <a href="javascript: switchOTB()" style="font-size:10px">Fold/Unfold OTB</a></td><%}%>
                   <%if(i==2) {%><td class="DataTable">Historical P.O.</td><%}%>
                   <td class="DataTable"><%=sYear[i]%></td>
                   <td class="DataTable" id="OPO<%=i%>T"></td>

                   <%for(int j=0; j < 12; j++) {%>
                       <td class="DataTable" id="OPO<%=i%>M<%=j%>"
                          <%if(i==0 || i==1 && j+1 >= Integer.parseInt(sCurMon)){%>onClick="showPObyVen(this.id)"<%}%> >                          
                       </td>
                   <%}%>
                </tr>
                <%if(i==2) {%>
                   <tr class="<%=sCSSCls%>">
                      <td class="DataTable">Received M-T-D P.O.</td>
                      <td class="DataTable"><%=sYear[i]%></td>
                      <td class="DataTable" id="RCVPOMTD"></td>
                      <td class="DataTable" colspan=12>&nbsp;</td>
                   </tr>
                <%}%>

           <%}%>
           <!------------------------------- Open to Receive ------------------------------------->
           <%for(int i=0; i < 2; i++) {%>
                <tr class="<%=sCSSCls%>">
                   <%if(i==0) {%><td class="DataTable" rowspan="2">Open to Receive<br>
                      <a href="javascript: resetNewPlan('OTR')">reset</a></td><%}%>
                   <td class="DataTable"><%=sYear[i]%></td>
                   <td class="DataTable"><input class="Cell" name="OTR<%=i%>T" readonly maxsize=9
                       onClick="javascript:this.focus();this.select();"></td>

                   <%for(int j=0; j < iNumOfMon; j++) {%>
                       <td class="DataTable"><input class="Cell" name="OTR<%=i%>M<%=j%>" readonly maxsize=9
                          onClick="javascript:this.focus();this.select();"></td>
                   <%}%>
                </tr>
           <%}%>

           <!-- Plan A -->
           <%for(int i=0; i < 2; i++) {%>
                <tr class="DataTable1" id="AOTRA<%=i%>">
                   <%if(i==0) {%><td class="DataTable" rowspan="2">Open to Receive (A) </td><%}%>
                   <td class="DataTable"><%=sYear[i]%></td>
                   <td class="DataTable" id="AOTR<%=i%>T"></td>

                   <%for(int j=0; j < iNumOfMon; j++) {%>
                       <td class="DataTable" id="AOTR<%=i%>M<%=j%>"></td>
                   <%}%>
                </tr>
           <%}%>

           <!-- Plan B -->
           <%for(int i=0; i < 2; i++) {%>
                <tr class="DataTable3" id="BOTRA<%=i%>">
                  <%if(i==0) {%><td class="DataTable" rowspan="2">Open to Receive (B) </td><%}%>
                   <td class="DataTable"><%=sYear[i]%></td>
                   <td class="DataTable" id="BOTR<%=i%>T"></td>

                   <%for(int j=0; j < iNumOfMon; j++) {%>
                       <td class="DataTable" id="BOTR<%=i%>M<%=j%>"></td>
                   <%}%>
                </tr>
           <%}%>

           <tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
           <!------------------------------- EOM --------------------------------->
           <%for(int i=0; i < iNumOfYr; i++) {%>
                <tr class="<%=sCSSCls%>" id="EMIA<%=i%>">
                   <%if(i==0) {%><td class="DataTable" rowspan="2" nowrap>End Of Month Inventory<br>
                          <a href="javascript: resetNewPlan('INV')">reset</a></td><%}%>
                   <%if(i==2) {%><td class="DataTable">Historical EOM<br>Inventory</td><%}%>
                   <td class="DataTable"><%=sYear[i]%></td>
                   <td class="DataTable"><input class="Cell" name="EMI<%=i%>T" readonly maxsize=9
                       onClick="javascript:this.focus();this.select();"></td>

                   <%for(int j=0; j < iNumOfMon; j++) {%>
                       <td class="DataTable"><input class="Cell" name="EMI<%=i%>M<%=j%>" readonly maxsize=9
                           onClick="javascript:this.focus();this.select();"></td>
                   <%}%>
                </tr>
           <%}%>

           <!-- History Plan -->
           <!--tr class="DataTable1" id="PHINR">
              <td class="DataTable">History EOM Plans</td>
              <td class="DataTable"><%/*=sYear[2]*/%></td>
              <td class="DataTable" id="HINVT"></td>
              <%/*for(int i=0; i < iNumOfMon; i++) {*/%>
                   <td class="DataTable" id="HINVM<%/*=i*/%>"></td>
              <%/*}*/%>
           </tr -->

           <!-- Plan A -->
           <%for(int i=0; i < 2; i++) {%>
                <tr class="DataTable1" id="AEMIA<%=i%>">
                   <%if(i==0) {%><td class="DataTable" rowspan="2">End Of Month<br>Inventory (A) </td><%}%>
                   <td class="DataTable"><%=sYear[i]%></td>
                   <td class="DataTable" id="AEMI<%=i%>T"></td>

                   <%for(int j=0; j < iNumOfMon; j++) {%>
                       <td class="DataTable" id="AEMI<%=i%>M<%=j%>" readonly maxsize=9></td>
                   <%}%>
                </tr>
           <%}%>

           <!-- Plan B -->
           <%for(int i=0; i < 2; i++) {%>
                <tr class="DataTable3" id="BEMIA<%=i%>">
                   <%if(i==0) {%><td class="DataTable" rowspan="2">End Of Month<br>Inventory (B) </td><%}%>
                   <td class="DataTable"><%=sYear[i]%></td>
                   <td class="DataTable" id="BEMI<%=i%>T"></td>

                   <%for(int j=0; j < iNumOfMon; j++) {%>
                       <td class="DataTable" id="BEMI<%=i%>M<%=j%>" readonly maxsize=9></td>
                   <%}%>
                </tr>
           <%}%>

           <!-- % changes -->
           <%for(int i=0; i < iNumOfYr-1; i++) {%>
                <tr class="<%=sCSSCls%>"  id="EMIP<%=i%>">
                   <%if(i==0) {%><td class="DataTable" rowspan="2">% Changes</td><%}%>
                   <td class="DataTable"><%=sYear[i] + "/" + sYear[i+1]%></td>
                   <td class="DataTable" id="CHGEMI<%=i%>T"</td>

                   <%for(int j=0; j < iNumOfMon; j++) {%>
                       <td class="DataTable" id="CHGEMI<%=i%>M<%=j%>"></td>
                   <%}%>
                </tr>
           <%}%>
           <tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>

        <!------------------------------- Required for Plan ------------------------------------->
        <%for(int i=0; i < 2; i++) {%>
                <tr class="<%=sCSSCls%>" id="RFPR<%=i%>">
                   <%if(i==0) {%><td class="DataTable" rowspan="2">Required for Plan</td><%}%>
                   <td class="DataTable"><%=sYear[i]%></td>
                   <td class="DataTable" id="RFP<%=i%>T"></td>

                   <%for(int j=0; j < iNumOfMon; j++) {%>
                       <td class="DataTable" id="RFP<%=i%>M<%=j%>"></td>
                   <%}%>
                </tr>
           <%}%>
          <tr id="RFPR2"><td></td></tr><tr id="RFPR3"><td></td></tr>
        <!------------------------------- Current Beginning inventory ------------------------------------->
        <%for(int i=0; i < 2; i++) {%>
                <tr class="<%=sCSSCls%>" id="CBIR<%=i%>">
                   <%if(i==0) {%><td class="DataTable" rowspan="2">Current Beginning<br>Inventory</td><%}%>
                   <td class="DataTable"><%=sYear[i]%></td>
                   <td class="DataTable" id="CBI<%=i%>T"></td>

                   <%for(int j=0; j < iNumOfMon; j++) {%>
                       <td class="DataTable" id="CBI<%=i%>M<%=j%>"></td>
                   <%}%>
                </tr>
           <%}%>
          <tr id="CBIR2"><td></td></tr><tr id="CBIR3"><td></td></tr>
        <!------------------------------- Open to Buy Details ------------------------------------->
        <%for(int i=0; i < 2; i++) {%>
                <tr class="<%=sCSSCls%>" id="OTBR<%=i%>">
                   <%if(i==0) {%><td class="DataTable" rowspan="2">Open to buy</td><%}%>
                   <td class="DataTable"><%=sYear[i]%></td>
                   <td class="DataTable" id="OTB<%=i%>T"></td>


                   <%for(int j=0; j < iNumOfMon; j++) {%>
                       <td class="DataTable" id="OTB<%=i%>M<%=j%>"></td>
                   <%}%>
                </tr>
           <%}%>
           <tr id="OTBR2"><td></td></tr><tr id="OTBR3"><td></td></tr>
        <!------------------------------- OTB Carry Forward ------------------------------------->
        <%for(int i=0; i < 2; i++) {%>
                <tr class="<%=sCSSCls%>" id="OCFR<%=i%>">
                   <%if(i==0) {%><td class="DataTable" rowspan="2">OTB Carry Forward</td><%}%>
                   <td class="DataTable"><%=sYear[i]%></td>
                   <td class="DataTable" id="OCF<%=i%>T"></td>

                   <%for(int j=0; j < iNumOfMon; j++) {%>
                       <td class="DataTable" id="OCF<%=i%>M<%=j%>"></td>
                   <%}%>
                </tr>
           <%}%>
           <tr id="OCFR2"><td></td></tr><tr id="OCFR3"><td></td></tr>
           <!--------------------------------------------------------------------------->
           <tr class="<%=sCSSCls%>" id="SSRR">
              <td class="DataTable" nowrap>Stock to Sales Ratio</td>
              <td class="DataTable">&nbsp;</td>
              <td class="DataTable">&nbsp;</td>
              <%for(int j=0; j < iNumOfMon; j++) {%>
                    <td class="DataTable" id="SSR<%=j%>"></td>
              <%}%>
           </tr>
           <tr class="<%=sCSSCls%>" id="FCWR">
              <td class="DataTable"  nowrap>Fiscal Calendar Week</td>
              <td class="DataTable">&nbsp;</td>
              <td class="DataTable">&nbsp;</td>
              <%for(int j=0; j < iNumOfMon; j++) {%>
                    <td class="DataTable" id="FCW<%=j%>"></td>
              <%}%>
           </tr>
           <tr class="<%=sCSSCls%>" id="ASWR">
              <td class="DataTable"  nowrap>Average Sales/Week</td>
              <td class="DataTable">&nbsp;</td>
              <td class="DataTable">&nbsp;</td>
              <%for(int j=0; j < iNumOfMon; j++) {%>
                    <td class="DataTable" id="ASW<%=j%>"></td>
              <%}%>
           </tr>
           <tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
        <!------------------------------------------------------------------------------->
           <%for(int i=0; i < iNumOfYr; i++) {%>
              <tr class="<%=sCSSCls%>" id="TRNR<%=i%>">
                 <%if(i==0) {%><td class="DataTable" rowspan="3">Turn</td><%}%>
                 <td class="DataTable"><%=sYear[i]%></td>
                 <td class="DataTable" id="TRN<%=i%>"></td>
                 <td class="DataTable" colspan="12">&nbsp;</td>
              </tr>
           <%}%>
           <tr class="<%=sCSSCls%>" id="TRNR<%=iNumOfYr%>">
                 <td class="DataTable">Planned Turn</td>
                 <td class="DataTable"><%=sYear[iNumOfYr-1]%></td>
                 <td class="DataTable" id="TRNH"></td>
                 <td class="DataTable" colspan="12">&nbsp;</td>
              </tr>
      <!----------------- bottom headings of table ------------------------>
        <tr>
	  <th class="DataTable" >
             <a href="javascript: switchHist()">Fold/Unfold Hist</a><br>
             <a href="javascript: switchStats()">Fold/Unfold Stats</a>
          </th>
          <th class="DataTable" >Year</th>
          <th class="DataTable" >Total</th>
          <!-- Month Names -->
          <%for (int i=0; i < iNumOfMon; i++){%>
              <th class="DataTable"><a href="javascript: showMonthValue(<%=i%>, '<%=sMonName[i]%>')"><%=sMonName[i]%></a></th>
          <%}%>
        </tr>
      </table>
      <!--------------------- end of This Year table ----------------------->
      </td>
      <!------------------------- Month Calculations -------------------------------->
      <td valign=top>
         <table class="MonCalc" cellPadding="0" cellSpacing="0" id="tblMonCalc">
          <tr class="MonCalc" id="trHMonCalc">
            <th id="thMonCalc"></th>
          </tr>
          <tr class="DataTable2">
            <td nowrap>
               Select Month for OTB Calc:
               <select name="selMonCalc" class="Small"></select>&nbsp;
                 <button class="Small" onclick="chgMonCalc();">Go</button>
                 <button class="Small" onclick="prtMonCalc();">Prt</button>
            </td>
          </tr>
          <tr class="DataTable2" >
            <td id="tdMonCalc"></td>
          </tr>
         </table>
       </td>
       <!----------------------------------------------------------------------------->
    </tr>
   </table>
   <tr class="trButton">
     <td>
      <button name="Apply" onClick="applyLYActual()" class="Small">Apply LY Actual</button>&nbsp;&nbsp;
      <button name="Calc" onClick="clcNewPlan()" class="Small">Calc</button>&nbsp;&nbsp;
      <button name="Save" onClick="saveNewPlan()" class="Small">Save</button>
     </td>
   </tr>
  </table>
 </body>
</html>
<%}%>