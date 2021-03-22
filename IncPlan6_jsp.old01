<%@ page import="payrollreports.IncPlan6, rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*
  , java.util.*, java.math.*"%>
<%
   String sQtr = request.getParameter("Qtr");
   String sGrp = request.getParameter("Grp");

   if(sQtr==null) sQtr = "0";
   if(sGrp==null) sGrp = "MGR";
   
   long lStartTime = (new java.util.Date()).getTime();
   
   
   IncPlan6 incp = new IncPlan6(sQtr, "MGR");
   int  iNumOfStr = incp.getNumOfStr();
   String [] sStr = incp.getStr();
   String [] sStrName = incp.getStrName();
   String [] sReg = incp.getReg();
   String [] sRegStrCnt = incp.getRegStrCnt();

   String [][] sPlan = incp.getPlan();
   String [][] sSales = incp.getSales();
   String [][] sActHrs = incp.getActHrs();
   String [][] sBdgHrs = incp.getBdgHrs();

   String [][] sPlanVar = incp.getPlanVar();
   String [][] sHrsVar = incp.getHrsVar();
   String [][] sMstScr = incp.getMstShpScr();
   int [] iMstScrCnt = incp.getMstScrCnt();
   String sMstScrDtl = incp.getMstScrDtl();

   String [][] sStaScr = incp.getStaShpScr();
   int [] iStaScrCnt = incp.getStaScrCnt();
   String sStaScrDtl = incp.getStaScrDtl();

   String [][] sTmcNet = incp.getTmcNet();
   String [][] sTmcHrs = incp.getTmcHrs();
   String [][] sBonus = incp.getBonus();
   String [][] sBonusClr = incp.getBonusClr();
   String [][] sBonusScr = incp.getBonusScr();
   String [] sMon = incp.getMon();
   boolean [] bLink = incp.getLink();
   String [][][] sRepTotVal = incp.getRepTotVal();
   String [][][] sRepTot = incp.getRepTot();
   String [][] sRepBonus = incp.getRepBonus();
   String [][] sRepBonusClr = incp.getRepBonusClr();
   String [][] sRepBonusScr = incp.getRepBonusScr();
   int iPercentSet = incp.getPercentSet();

   // Actual Payroll and Allowable Budget vs Actual Sales.
   String [][] sStrActPayVsSlsPrc = incp.getStrActPayVsSlsPrc();
   String [][] sStrAlwBdgPayVsSlsPrc = incp.getStrAlwBdgPayVsSlsPrc();
   String [][] sStrAlwVsActPayOver = incp.getStrAlwVsActPayOver();

   String [][] sStrAlwBdgHrs = incp.getStrAlwBdgHrs();
   String [][] sStrActHrs = incp.getStrActHrs();
   String [][] sStrActPay = incp.getStrActPay();
   String [][] sStrOverHrs = incp.getStrOverHrs();
   String [][] sStrAlwBdgPay = incp.getStrAlwBdgPay();
   String [][] sStrOverPay = incp.getStrOverPay();

   String [][] sStrAlwTmcHrs = incp.getStrAlwTmcHrs();
   String [][] sStrAlwTmcPay = incp.getStrAlwTmcPay();
   String [][] sStrTmcHrs = incp.getStrTmcHrs();
   String [][] sStrTmcPay = incp.getStrTmcPay();

   String [][] sRegActPayVsSlsPrc = incp.getRegActPayVsSlsPrc();
   String [][] sRegAlwBdgPayVsSlsPrc = incp.getRegAlwBdgPayVsSlsPrc();
   String [][] sRegAlwVsActPayOver = incp.getRegAlwVsActPayOver();

   String [][] sRegAlwBdgHrs = incp.getRegAlwBdgHrs();
   String [][] sRegActHrs = incp.getRegActHrs();
   String [][] sRegActPay = incp.getRegActPay();
   String [][] sRegOverHrs = incp.getRegOverHrs();
   String [][] sRegAlwBdgPay = incp.getRegAlwBdgPay();
   String [][] sRegOverPay = incp.getRegOverPay();

   String [][] sRegAlwTmcHrs = incp.getRegAlwTmcHrs();
   String [][] sRegAlwTmcPay = incp.getRegAlwTmcPay();
   
   System.out.println("sRegAlwTmcPay 4, 0 = " + sRegAlwTmcPay[4][0]);
   System.out.println("sRegAlwTmcPay 4, 3 = " + sRegAlwTmcPay[4][3]);
   
   String [][] sRegTmcHrs = incp.getRegTmcHrs();
   String [][] sRegTmcPay = incp.getRegTmcPay();

   String [][] sStrSKStr = incp.getStrSKStr();
   String [][] sStrSKKio = incp.getStrSKKio();
   String [][] sStrSKSls = incp.getStrSKSls();
   String [][] sStrSKEcom = incp.getStrSKEcom();
   String [][] sStrSKEcPrc = incp.getStrSKEcPrc();

   String [][] sRegSKStr = incp.getRegSKStr();
   String [][] sRegSKKio = incp.getRegSKKio();
   String [][] sRegSKSls = incp.getRegSKSls();
   String [][] sRegSKEcom = incp.getRegSKEcom();
   String [][] sRegSKEcPrc = incp.getRegSKEcPrc();

   String [] sRepSKStr = incp.getRepSKStr();
   String [] sRepSKKio = incp.getRepSKKio();
   String [] sRepSKSls = incp.getRepSKSls();
   String [] sRepSKEcom = incp.getRepSKEcom();
   String [] sRepSKEcPrc = incp.getRepSKEcPrc();   

   String [] sStrPvo = incp.getStrPvo();
   String [] sRegPvo = incp.getRegPvo();
   String [] sStrSurv = incp.getStrSurv();
   String [] sRegSurv = incp.getRegSurv();

   incp.disconnect();

   String [][] sProcent = new String[2][5];
   sProcent[0] = new String[]{"2.5%", "%1", "0.5%", "0.5%", "4.5%"};
   sProcent[1] = new String[]{"3%", "1%", "0.5%", "0.5%", "5%"};

//==============================================================================
// Get current Fyscal Year and Month
//==============================================================================
   java.util.Date dCurDate = new java.util.Date();
   SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
   String sCurDate = sdf.format(dCurDate);

   String sPrepStmt = "select pyr#, pmo#, pime from rci.fsyper" + " where pida='" + sCurDate + "'";
   //System.out.println(sPrepStmt);
   ResultSet rslset = null;
   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sPrepStmt);
   runsql.runQuery();
   runsql.readNextRecord();
   int iCurYear = Integer.parseInt(runsql.getData("pyr#"));
   int iCurMonth = Integer.parseInt(runsql.getData("pmo#"));
   runsql.disconnect();
   runsql = null;

   int iReqQtr = Integer.parseInt(sQtr);
   int iCurQtr = 0;
   int iAlwBdgQtr = 0;
   int iAlwBdgYear = 0;

   if(iCurMonth < 4){ iCurQtr = 1; }
   else if(iCurMonth < 7){ iCurQtr = 2; }
   else if(iCurMonth < 10){ iCurQtr = 3; }
   else { iCurQtr = 4; }

   if (iCurQtr > iReqQtr)
   {
      iAlwBdgYear= iCurYear;
      iAlwBdgQtr = iCurQtr - iReqQtr;
   }
   else
   {
      iAlwBdgYear = iCurYear - 1;
      iAlwBdgQtr = iCurQtr + 4  - iReqQtr;
   }

   String sQtdWkend = incp.getQtdWkend();

   int iQtrAlw = 2;
   /*if (iCurYear == 2013 && iCurQtr == 3){ iQtrAlw = 1;}
   else if (iCurYear == 2013 && iCurQtr == 4){ iQtrAlw = 2;}
   else if (iCurYear == 2014 && iCurQtr == 1){ iQtrAlw = 3;}
   else if (iCurYear == 2014 && iCurQtr == 2){ iQtrAlw = 4;}
   else if (iCurYear == 2014 && iCurQtr > 2){ iQtrAlw = 5;}*/
   
   double [] dRepTotScr = { 0,0,0, 0,0,0, 0,0,0};
   
   //System.out.print(" ");
   for(int i=0; i < iNumOfStr; i++)
   {
	   //System.out.print("|" + sBonusClr[i][8] + "|" + sBonus[i][8]);
	   for(int j=0; j < 9; j++)
	   {
	   		if(sBonusClr[i][j].toLowerCase().indexOf("green") >= 0)
	   		{
	   			if(j != 3)
	   			{
		   		   dRepTotScr[j] += Double.parseDouble(sBonus[i][j]);		   		   
	   			}
	   		}
	   }
	   
   }
   
   for(int j=0; j < 9; j++)
   {
	   BigDecimal bd = new BigDecimal(dRepTotScr[j]);
	   bd = bd.setScale(2, RoundingMode.HALF_UP);
	   dRepTotScr[j] = bd.doubleValue();
   }
%>
<html>
<head>
<title>Incentive Plan(new)</title>
<style>
  body {background:ivory;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  table.DataTable { border: darkred solid 1px;background: white;text-align:center;}
  th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px; 
                 vertical-align: text-bottom; }
  th.DataTable1 { background:#FFCC99;  writing-mode: tb-rl; filter: flipv fliph; padding-top:3px;
                  border-top: darkred solid 1px; border-bottom: darkred solid 1px; border-left: darkred solid 1px;
                  text-align:center; font-family:Verdanda; font-size:12px }

  th.DataTable2 { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px;text-align: center; vertical-align: text-bottom; 
                 font-family: Verdanda; font-size: 12px }
  
  th.Divdr { background: white; border-right: darkred solid 1px;font-size:1px }


  tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }
  tr.DataTable1 { background:cornsilk; font-family:Arial; font-size:10px }
  tr.DataTable2 { background:seashell; font-family:Arial; font-size:10px }


  td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:right;}
  td.DataTable1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:left;}
  td.DataTable2{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:center;}
  td.DataTable3 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; font-weight:bold;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}

  td.QTD { background:cornsilk; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;

                 border-right: darkred solid 1px; text-align:right;}
  td.QTD1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:right; font-size:11px; font-weight:bold}
  td.QTD2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:center; font-size:11px; font-weight:bold}

  td.DataTable1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:left;}

  div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt {border-bottom: black solid 2px; border-right: black solid 1px; text-align:center;
                   font-family:Arial; font-size:10px; }

   #colPayPrc { display:none; }
   #colPayHrs { display:none; }
</style>

<SCRIPT>
//--------------- Global variables -----------------------
var NumOfStr = <%=iNumOfStr%>;


//var NumOfReg = 3 - <%=sQtr%>;
// remove after 2012 fiscal year
var NumOfReg = 3;
var SelQtr = <%=sQtr%>;
if(SelQtr > 2){NumOfReg = NumOfReg - 1;}


var triggerPS = false;
var triggerBA = false;

var MstScrDtl = [<%=sMstScrDtl%>];
var StaScrDtl = [<%=sStaScrDtl%>];
var PrcHrsPay = 2;

//--------------- End of Global variables ----------------
//---------------------------------------------
// initialize value on load
//---------------------------------------------
function  bodyload()
{
  switchValFld('PS');
  switchValFld('BA');
  // activate move box
  setBoxclasses(["BoxName",  "BoxClose"], ["Prompt"]);
  hideUnused("Unused01");

}

//==============================================================================
// hide unused elements 
//==============================================================================
function hideUnused(objnm)
{
	var obj = document.all[objnm];
	for(var i=0; i < obj.length; i++)
	{
		obj[i].style.display="none";
		//obj[i].style.color="darkred";
	}
}

//==============================================================================
// switch between Percentage and Hours
//==============================================================================
function switchHrsPrc()
{
   var hrs = document.all.colPayHrs;
   var prc = document.all.colPayPrc;
   var pay = document.all.colPayAmt;

   var dispHrs = null;
   var dispPrc = null;
   var dispPay = null;

   if(PrcHrsPay < 2){ PrcHrsPay += 1; }
   else{ PrcHrsPay = 0; }

   if(PrcHrsPay == 0) { dispHrs = "none"; dispPrc = "block"; dispPay = "none";}
   else if(PrcHrsPay == 1) { dispHrs = "block"; dispPrc = "none"; dispPay = "none";}
   else if(PrcHrsPay == 2) { dispHrs = "none"; dispPrc = "none"; dispPay = "block";}

   pay[0].style.display = "block";

   for(var i=0; i < prc.length; i++)
   {
      hrs[i].style.display = dispHrs;
      prc[i].style.display = dispPrc;
      if(i < pay.length) { pay[i].style.display = dispPay; }
   }
}
//---------------------------------------------
// show selected quarter
//---------------------------------------------
function switchValFld(type)
{
  var hdr1 = type + "Head1";
  var hdr2 = type + "Head2";

  var shdr01 = type + "Mn01";
  var shdr02 = type + "Mn02";
  var shdr11 = type + "Mn11";
  var shdr12 = type + "Mn12";
  var shdr21 = type + "Mn21";
  var shdr22 = type + "Mn22";
  var shdr31 = type + "Mn31";
  var shdr32 = type + "Mn32";

  var sshdr01 = type + "Mn0" + type.substring(0,1);
  var sshdr02 = type + "Mn0" + type.substring(1);
  var sshdr11 = type + "Mn1" + type.substring(0,1);
  var sshdr12 = type + "Mn1" + type.substring(1);
  var sshdr21 = type + "Mn2" + type.substring(0,1);
  var sshdr22 = type + "Mn2" + type.substring(1);
  var sshdr31 = type + "Mn3" + type.substring(0,1);
  var sshdr32 = type + "Mn3" + type.substring(1);

  var mfld01 = type + "Mn0" + type.substring(0, 1) + "0";
  var mfld02 = type + "Mn0" + type.substring(1) + "0";
  var mfld11 = type + "Mn1" + type.substring(0, 1) + "0";
  var mfld12 = type + "Mn1" + type.substring(1) + "0";
  var mfld21 = type + "Mn2" + type.substring(0, 1) + "0";
  var mfld22 = type + "Mn2" + type.substring(1) + "0";
  var mfld31 = type + "Mn3" + type.substring(0, 1) + "0";
  var mfld32 = type + "Mn3" + type.substring(1) + "0";

  var rfld01 = type + "Mn0" + type.substring(0, 1) + "R";
  var rfld02 = type + "Mn0" + type.substring(1) + "R";
  var rfld11 = type + "Mn1" + type.substring(0, 1) + "R";
  var rfld12 = type + "Mn1" + type.substring(1) + "R";
  var rfld21 = type + "Mn2" + type.substring(0, 1) + "R";
  var rfld22 = type + "Mn2" + type.substring(1) + "R";
  var rfld31 = type + "Mn3" + type.substring(0, 1) + "R";
  var rfld32 = type + "Mn3" + type.substring(1) + "R";

  var pfld01 = type + "Mn0" + type.substring(0, 1) + "T";
  var pfld02 = type + "Mn0" + type.substring(1) + "T";
  var pfld11 = type + "Mn1" + type.substring(0, 1) + "T";
  var pfld12 = type + "Mn1" + type.substring(1) + "T";
  var pfld21 = type + "Mn2" + type.substring(0, 1) + "T";
  var pfld22 = type + "Mn2" + type.substring(1) + "T";
  var pfld31 = type + "Mn3" + type.substring(0, 1) + "T";
  var pfld32 = type + "Mn3" + type.substring(1) + "T";

  var dspType1 = "block";
  var dspType2 = "none";
  if (type == "PS" && !triggerPS || type == "BA" && !triggerBA)
  {
    dspType1 = "none";
    dspType2 = "block";
  }

  if(type == "PS") triggerPS = !triggerPS;
  else if(type == "BA") triggerBA = !triggerBA;

  document.all[hdr1].style.display=dspType2;
  document.all[hdr2].style.display=dspType1;

  document.all[shdr01].style.display=dspType1;
  document.all[shdr02].style.display=dspType2;
  document.all[shdr11].style.display=dspType1;
  document.all[shdr12].style.display=dspType2;
  document.all[shdr21].style.display=dspType1;
  document.all[shdr22].style.display=dspType2;
  document.all[shdr31].style.display=dspType1;
  document.all[shdr32].style.display=dspType2;

  document.all[sshdr01].style.display=dspType1;
  document.all[sshdr02].style.display=dspType1;
  document.all[sshdr11].style.display=dspType1;
  document.all[sshdr12].style.display=dspType1;
  document.all[sshdr21].style.display=dspType1;
  document.all[sshdr22].style.display=dspType1;
  document.all[sshdr31].style.display=dspType1;
  document.all[sshdr32].style.display=dspType1;


  if(type=="BA")
  {
    //document.all["BAMn0T"].style.display=dspType1;
    //document.all["BAMn1T"].style.display=dspType1;
    //document.all["BAMn2T"].style.display=dspType1;
    //document.all["BAMn3T"].style.display=dspType1;
    //document.all["BATm"].style.display=dspType1;
  }
  for(var i=0; i < NumOfStr; i++)
  {

    document.all[mfld01 + i].style.display=dspType1;
    document.all[mfld02 + i].style.display=dspType1;
    document.all[mfld11 + i].style.display=dspType1;
    document.all[mfld12 + i].style.display=dspType1;
    document.all[mfld21 + i].style.display=dspType1;
    document.all[mfld22 + i].style.display=dspType1;
    document.all[mfld31 + i].style.display=dspType1;
    document.all[mfld32 + i].style.display=dspType1;
    if(type=="BA")
    {
      //document.all["BAMn0T0" + i].style.display=dspType1;
      //document.all["BAMn1T0" + i].style.display=dspType1;
      //document.all["BAMn2T0" + i].style.display=dspType1;
      //document.all["BAMn3T0" + i].style.display=dspType1;
    }
  }

  // !!!!!!
  for(var i=0; i < NumOfReg; i++)
  {    
	document.all[rfld01 + i].style.display=dspType1;
    document.all[rfld02 + i].style.display=dspType1;
    document.all[rfld11 + i].style.display=dspType1;
    document.all[rfld12 + i].style.display=dspType1;
    document.all[rfld21 + i].style.display=dspType1;
    document.all[rfld22 + i].style.display=dspType1;
    document.all[rfld31 + i].style.display=dspType1;
    document.all[rfld32 + i].style.display=dspType1;

    if(type=="BA")
    {
      //document.all["BAMn0TR" + i].style.display=dspType1;
      //document.all["BAMn1TR" + i].style.display=dspType1;
      //document.all["BAMn2TR" + i].style.display=dspType1;
      //document.all["BAMn3TR" + i].style.display=dspType1;
    }
  }

  document.all[pfld01].style.display=dspType1;
  document.all[pfld02].style.display=dspType1;
  document.all[pfld11].style.display=dspType1;
  document.all[pfld12].style.display=dspType1;
  document.all[pfld21].style.display=dspType1;
  document.all[pfld22].style.display=dspType1;
  document.all[pfld31].style.display=dspType1;
  document.all[pfld32].style.display=dspType1;


  if(type=="BA")
  {
    //document.all["BAMn0TR"].style.display=dspType1;
    //document.all["BAMn1TR"].style.display=dspType1;
    //document.all["BAMn2TR"].style.display=dspType1;
    //document.all["BAMn3TR"].style.display=dspType1;
  }
}

//---------------------------------------------
// show selected quarter
//---------------------------------------------
function showSelQtr(qtr)
{
  var qtrNum = qtr.options[qtr.selectedIndex].value
  var url = "IncPlanPreProc.jsp?Grp=<%=sGrp%>"
          + "&Qtr=" + qtrNum
  window.location.href=url;
}

//---------------------------------------------
// show Store Mistery shop Details
//---------------------------------------------
function showStrMsDtl(str, tot, strname)
{
    var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap colspan=4>&nbsp;Mistery Shop Details: " + strname + "&nbsp;</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
      + "<tr class='DataTable'>"
           + "<th class='DataTable' width='30%' nowrap>No.</th>"
           + "<th class='DataTable' width='30%' nowrap>Scores</th>"
           + "<th class='DataTable' nowrap>Date</th>"
           + "<th class='DataTable' nowrap colspan=2>Comments</th>"
         + "</tr>"


     for(var i=0; i < MstScrDtl[0][str].length; i++)
     {
       html +=
          "<tr class='DataTable'>"
           + "<td class='DataTable2' width='10%' nowrap>" + (i+1) + "</td>"
           + "<td class='DataTable2' width='30%' nowrap>" + MstScrDtl[0][str][i]+ "</td>"
           + "<td class='DataTable2' nowrap>" + MstScrDtl[1][str][i]+ "</td>"
           + "<td class='DataTable' nowrap colspan=2>" + MstScrDtl[2][str][i]+ "</td>"
         + "</tr>"
     }

     html +=
          "<tr class='DataTable1'>"
           + "<td class='DataTable2' width='10%' nowrap>Average</td>"
           + "<td class='DataTable2' width='30%' nowrap>" + tot + "</td>"
           + "<td class='DataTable2'> - - - </td>"
           + "<td class='DataTable2' nowrap colspan=2> - - - </td>"
         + "</tr>"

   html += "</table>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft= 300;
   document.all.Prompt.style.pixelTop= 200;
   document.all.Prompt.style.visibility = "visible";
}
//==============================================================================
// shows Allowable Budget and TMC
//==============================================================================
function showAlwTmc(obj, athrs,  abhrs, thrs, atpay,  abpay, tpay)
{
   var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr style='font-size:10px'>"
           + "<td>Allowable & TMC Hours:</td>"
           + "<td align=right>" + athrs + "</td>"
      + "</tr>"
      + "<tr style='font-size:10px'>"
           + "<td>Allowable Budget Hours:</td>"
           + "<td align=right>" + abhrs + "</td>"
      + "</tr>"
      + "<tr style='font-size:10px'>"
           + "<td>TMC Hours:</td>"
           + "<td align=right>" + thrs + "</td>"
      + "</tr>"

      // pay
      + "<tr style='font-size:10px'>"
           + "<td>Allowable & TMC Amount:</td>"
           + "<td align=right>$" + atpay + "</td>"
      + "</tr>"
      + "<tr style='font-size:10px'>"
           + "<td>Allowable Budget Amount:</td>"
           + "<td align=right>$" + abpay + "</td>"
      + "</tr>"
      + "<tr style='font-size:10px'>"
           + "<td>TMC Amount:</td>"
           + "<td align=right>$" + tpay + "</td>"
      + "</tr>"

   html += "</table>"

   var pos = getObjPosition(obj)

   document.all.dvAlwTmc.innerHTML = html;
   document.all.dvAlwTmc.style.width = 200;
   document.all.dvAlwTmc.style.border = "gray ridge 2px;";
   document.all.dvAlwTmc.style.pixelLeft= pos[0] + 45;
   document.all.dvAlwTmc.style.pixelTop= pos[1] - 5;
   document.all.dvAlwTmc.style.visibility = "visible";
}
//==============================================================================
//shows Allowable Budget and TMC
//==============================================================================
function showTotScore(scr, hdr, obj)
{
   var html = "<span style='font-size:10px;'>" + hdr 
     + " Projected Percent Payout: " + scr + "</span>"
   
   var pos = getObjPosition(obj);

   document.all.dvAlwTmc.innerHTML = html;
   document.all.dvAlwTmc.style.width = 200;
   document.all.dvAlwTmc.style.border = "gray ridge 2px;";
   document.all.dvAlwTmc.style.pixelLeft= pos[0] + 45;
   document.all.dvAlwTmc.style.pixelTop= pos[1] - 5;
   document.all.dvAlwTmc.style.visibility = "visible";

}
//==============================================================================
// shows Store and Kiosk sales
//==============================================================================
function showStrKioSls(obj, stronly, kiosk, strkio, ecomsls, ecomprc)
{
	/*
    var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr style='font-size:10px'>"
           + "<td>Store Sales:</td>"
           + "<td align=right>" + stronly + "</td>"
      + "</tr>"
      + "<tr style='font-size:10px'>"
           + "<td>Kiosk Sales:</td>"
           + "<td align=right>" + kiosk + "</td>"
      + "</tr>"
       + "<tr style='font-size:10px'>"
           + "<td>Ecom Sales:</td>"
           + "<td align=right>" + ecomsls + "</td>"
      + "</tr>"      
      + "<tr style='font-size:10px'>"
           + "<td>Store,Kiosk,Ecom:</td>"
           + "<td align=right>" + strkio + "</td>"
      + "</tr>"      

   html += "</table>"

   var pos = getObjPosition(obj)

   document.all.dvAlwTmc.innerHTML = html;
   document.all.dvAlwTmc.style.width = 200;
   document.all.dvAlwTmc.style.border = "gray ridge 2px;";
   document.all.dvAlwTmc.style.pixelLeft= pos[0] + 65;
   document.all.dvAlwTmc.style.pixelTop= pos[1] - 5;
   document.all.dvAlwTmc.style.visibility = "visible";
   */
}
//==============================================================================
//shows comments
//==============================================================================
function showComment(obj, disp)
{
	if(disp)
	{ 
		var html = "The Store 25 is not included for Q3/2018.";

		var pos = getObjPosition(obj)

	   document.all.dvAlwTmc.innerHTML = html;
	   document.all.dvAlwTmc.style.width = 200;
	   document.all.dvAlwTmc.style.border = "gray ridge 2px;";
	   document.all.dvAlwTmc.style.pixelLeft= pos[0] + 65;
	   document.all.dvAlwTmc.style.pixelTop= pos[1] - 5;
	   document.all.dvAlwTmc.style.visibility = "visible"; 
	}
	else { document.all.dvAlwTmc.style.visibility = "hidden"; }
}
//==============================================================================
// hide Allowable Budget and TMC panel
//==============================================================================
function hideAlwTmc()
{
   document.all.dvAlwTmc.style.visibility = "hidden";
}

//---------------------------------------------
// show Store Audit Score Details
//---------------------------------------------
function showStrAudDtl(str, tot, strname)
{
    var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap colspan=4>&nbsp;store Audit Details: " + strname + "&nbsp;</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
      + "<tr class='DataTable'>"
           + "<th class='DataTable' width='30%' nowrap>No.</th>"
           + "<th class='DataTable' width='30%' nowrap>Scores</th>"
           + "<th class='DataTable' nowrap>Date</th>"
           + "<th class='DataTable' nowrap colspan=2>Comments</th>"
         + "</tr>"


     for(var i=0; i < StaScrDtl[0][str].length; i++)
     {
       html +=
          "<tr class='DataTable'>"
           + "<td class='DataTable2' width='10%' nowrap>" + (i+1) + "</td>"
           + "<td class='DataTable2' width='30%' nowrap>" + StaScrDtl[0][str][i]+ "</td>"
           + "<td class='DataTable2' nowrap>" + StaScrDtl[1][str][i]+ "</td>"
           + "<td class='DataTable' nowrap colspan=2>" + StaScrDtl[2][str][i]+ "</td>"
         + "</tr>"
     }

     html +=
          "<tr class='DataTable1'>"
           + "<td class='DataTable2' width='10%' nowrap>Average</td>"
           + "<td class='DataTable2' width='30%' nowrap>" + tot + "</td>"
           + "<td class='DataTable2'> - - - </td>"
           + "<td class='DataTable2' nowrap colspan=2> - - - </td>"
         + "</tr>"

   html += "</table>"

   document.all.Prompt.innerHTML = html;
   document.all.Prompt.style.pixelLeft= 300;
   document.all.Prompt.style.pixelTop= 200;
   document.all.Prompt.style.visibility = "visible";
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.Prompt.innerHTML = " ";
   document.all.Prompt.style.visibility = "hidden";
}
//==============================================================================
// show Allowable Dudgeted Details
//==============================================================================
function showAlwBdgDtl()
{
   var shows = "block";
   if (document.all.trAlwBdgDtl.style.display == "block") { shows = "none"; }
   document.all.trAlwBdgDtl.style.display = shows;
}


 //window.onbeforeunload = function (e) {}
</SCRIPT>
<script src="MoveBox.js"></script>
<script src="Get_Object_Position.js"></script>

</head>
<body onload="bodyload()">
<!-------------------------------------------------------------------->
<div id="Prompt" class="Prompt"></div>
<div id="dvAlwTmc" class="Prompt"></div>
<!-------------------------------------------------------------------->

 <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
   <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br><%if(sGrp.equals("MGR6")){%>Store Manager and Assistant Manager<%}
            else if(sGrp.equals("MGRPI")){%>Area Manager <%}
            else {%>Floor Supervisor<%}%> Incentive Plan Board
          </b>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="StrScheduling.html">
         <font color="red" size="-1">Store Scheduling</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp
      Select Quarter:
      <select onchange="showSelQtr(this)">
        <option value="0" <%if(sQtr.equals("0")){%>selected<%}%>>This quarter</option>
        <%if(iQtrAlw >= 1){%><option value="1" <%if(sQtr.equals("1")){%>selected<%}%>>Previous quarter</option><%}%>
        <%if(iQtrAlw >= 2){%><option value="2" <%if(sQtr.equals("2")){%>selected<%}%>>-2 quarters</option><%}%>
        <%if(iQtrAlw >= 3){%><option value="3" <%if(sQtr.equals("3")){%>selected<%}%>>-3 quarters</option><%}%>
        <%if(iQtrAlw >= 4){%><option value="4" <%if(sQtr.equals("4")){%>selected<%}%>>-4 quarters</option><%}%>
        <%if(iQtrAlw >= 5){%><option value="5" <%if(sQtr.equals("5")){%>selected<%}%>>-5 quarters</option><%}%>
      </select>&nbsp;&nbsp;
      <a class="blue" href="servlet/payrollreports.BudgetvsActual?PosTo=CMP00&Month=1"><font color="red" size="-1">Go to: Total Store Payroll (with exclusions)</font></a>&nbsp; &nbsp;
      <a style="font-size:12px" href="javascript: showAlwBdgDtl()">Allowable Budget Details</a>
      </td>
   </tr>
   <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">

  <!----------------- beginning of table ------------------------>
  <table class="DataTable" cellPadding="0" cellSpacing="0">
    <tr>
      <th class="DataTable" rowspan="3">Dst</th>
      <th class="DataTable" rowspan="3">Store</th>
      <th class="DataTable" rowspan="3" >&nbsp;</th>

      <th class="DataTable" colspan="9" id="PSHead1" nowrap><a href="javascript:switchValFld('PS')">Actual Sales vs. Original Sales Variance</a></th>
      <th class="DataTable" colspan="17" id="PSHead2" nowrap><a href="javascript:switchValFld('PS')">Actual Sales vs. Original Sales Variance</a></th>
      
      <th class="DataTable" rowspan="3" >&nbsp;</th>
      <th class="DataTable" colspan="8"  id="BAHead1" nowrap>
         <a href="javascript:switchValFld('BA')">Allowable Budget vs. Actual Payroll %(Hrs)</a><br>
         <a href="javascript:switchHrsPrc()">(Percents/Hours/Pay)</a> <sup>***)</sup>
      </th>
      <th class="DataTable" colspan="16"  id="BAHead2" nowrap>
         <a href="javascript:switchValFld('BA')">Allowable Budget vs. Actual Payroll %(Hrs)</a><br>
         <a href="javascript:switchHrsPrc()">(Percents/Hours/$)</a> <sup>***)</sup>
      </th>
      
      <th class="DataTable" rowspan="3" >&nbsp;</th>
      <th class="DataTable" rowspan="3" >Allw<br>Bdg</th>
      <th class="DataTable" id="Unused01">Mystery Shop</th>
      <th class="DataTable" rowspan="3" >&nbsp;</th>
      <th class="DataTable" rowspan="2" colspan=2>Mktg</th>
      <th class="DataTable" rowspan="3" >&nbsp;</th>
      <th class="DataTable" rowspan="2" colspan=2 >ECOMM</th>
      <th class="DataTable" rowspan="3" >&nbsp;</th>
      <th class="DataTable" rowspan="2" >Total</th>
      <th class="DataTable" rowspan="3" >&nbsp;</th>
      <th class="DataTable" rowspan="3">Store</th>
    </tr>
    
    
    <tr>
      <th class="DataTable" colspan="3" id="PSMn01"><%=sMon[0]%></th>
      <th class="DataTable" colspan="1" id="PSMn02"><%=sMon[0]%></th>
      <th class="Divdr" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan="3" id="PSMn11"><%=sMon[1]%></th>
      <th class="DataTable" colspan="1" id="PSMn12"><%=sMon[1]%></th>
      <th class="Divdr" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan="3" id="PSMn21"><%=sMon[2]%></th>
      <th class="DataTable" colspan="1" id="PSMn22"><%=sMon[2]%></th>
      <th class="Divdr" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan="4" id="PSMn31">Q-T-D W/E <%=sQtdWkend%></th>
      <th class="DataTable" colspan="2" id="PSMn32">Q-T-D<br>W/E <%=sQtdWkend%></th>
      <th class="DataTable2" rowspan="2">Sales<br>%<br>&nbsp;Bonus&nbsp;<br>3%<br>(max)</th>

      <th class="DataTable" colspan="3" id="BAMn01"><%=sMon[0]%></th>
      <th class="DataTable" colspan="1" id="BAMn02"><%=sMon[0]%></th>
      <th class="Divdr" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan="3" id="BAMn11"><%=sMon[1]%></th>
      <th class="DataTable" colspan="1" id="BAMn12"><%=sMon[1]%></th>
      <th class="Divdr" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan="3" id="BAMn21"><%=sMon[2]%></th>
      <th class="DataTable" colspan="1" id="BAMn22"><%=sMon[2]%></th>
      <th class="Divdr" rowspan=2>&nbsp;</th>
      <th class="DataTable" colspan="3" id="BAMn31">Q-T-D W/E <%=sQtdWkend%></th>
      <th class="DataTable" colspan="1" id="BAMn32">Q-T-D<br>W/E <%=sQtdWkend%></th>
      <th class="DataTable" rowspan="2">Bonus<br>$'s<br>P/R Sav</th>

      <th class="DataTable" id="Unused01" rowspan="2">Average <br>Scores</th>
    </tr>
    <tr>
      <th class="DataTable" id="PSMn0P">Plan</th>
      <th class="DataTable" id="PSMn0S">Sales</th>
      <th class="DataTable">Var</th>
      <th class="DataTable" id="PSMn1P">Plan</th>
      <th class="DataTable" id="PSMn1S">Sales</th>
      <th class="DataTable">Var</th>
      <th class="DataTable" id="PSMn2P">Plan</th>
      <th class="DataTable" id="PSMn2S">Sales</th>
      <th class="DataTable">Var</th>
      <th class="DataTable" id="PSMn3P">Plan</th>
      <th class="DataTable" id="PSMn3S">Sales</th>
      <th class="DataTable">Var</th>
      <th class="DataTable">%</th>

      <th class="DataTable" id="BAMn0B">Allw<br>Budget<br><span id="colPayPrc">(%)</span><span id="colPayHrs">(H)</span><span id="colPayAmt">($) </span></th>
      <th class="DataTable" id="BAMn0A">Actual<br><span id="colPayPrc">(%)</span><span id="colPayHrs">(H)</span><span id="colPayAmt">($)</span></th>
      <th class="DataTable">Var<br><span id="colPayPrc">(%)</span><span id="colPayHrs">(H)</span><span id="colPayAmt">($)</span></th>
      <!--th class="DataTable" id="BAMn0T">TMC</th -->

      <th class="DataTable" id="BAMn1B">Allw<br>Budget<br><span id="colPayPrc">(%)</span><span id="colPayHrs">(H)</span><span id="colPayAmt">($)</span></th>
      <th class="DataTable" id="BAMn1A">Actual<br><span id="colPayPrc">(%)</span><span id="colPayHrs">(H)</span><span id="colPayAmt">($)</span></th>
      <th class="DataTable">Var<br><span id="colPayPrc">(%)</span><span id="colPayHrs">(H)</span><span id="colPayAmt">($)</span></th>
      <!--th class="DataTable" id="BAMn1T">TMC</th -->

      <th class="DataTable" id="BAMn2B">Allw<br>Budget<br><span id="colPayPrc">(%)</span><span id="colPayHrs">(H)</span><span id="colPayAmt">($)</span></th>
      <th class="DataTable" id="BAMn2A">Actual<br><span id="colPayPrc">(%)</span><span id="colPayHrs">(H)</span><span id="colPayAmt">($)</span></th>
      <th class="DataTable">Var<br><span id="colPayPrc">(%)</span><span id="colPayHrs">(H)</span><span id="colPayAmt">($)</span></th>
      <!-- th class="DataTable" id="BAMn2T">TMC</th -->

      <th class="DataTable" id="BAMn3B">Allw<br>Budget<br><span id="colPayPrc">(%)</span><span id="colPayHrs">(H)</span><span id="colPayAmt">($)</span></th>
      <th class="DataTable" id="BAMn3A">Actual<br><span id="colPayPrc">(%)</span><span id="colPayHrs">(H)</span><span id="colPayAmt">($)</span></th>
      <th class="DataTable">Var<br><span id="colPayPrc">(%)</span><span id="colPayHrs">(H)</span><span id="colPayAmt">($)</span></th>
      <!--th class="DataTable">%</th-->
      <!--th class="DataTable" id="BAMn3T">TMC</th -->

      <!--th class="DataTable">MS</th-->
      <%if(sGrp.equals("MGR6") || sGrp.equals("MGRPI")){%>
        <th class="DataTable2">&nbsp;Chat&nbsp;</th>
        <th class="DataTable2">&nbsp;0.75%&nbsp;<br>(max)</th>
        <th class="DataTable2">&nbsp;% Ship&nbsp;</th>
        <th class="DataTable2">&nbsp;0.75%&nbsp;<br>(max)</th>         
      <%}%>
      <th class="DataTable2">Total<br>4.5%<br>(max)</th>
    </tr>
<!------------------------------- Detail Data --------------------------------->

    <%String sSvReg = " ";
      int iRow = 0;
      for(int i=0; i < iNumOfStr; i++){%>

      <tr class="DataTable">
         <%if(!sSvReg.equals(sReg[i])) {%>
             <td class="DataTable1" rowspan="<%=sRegStrCnt[iRow]%>"><%=sReg[i]%></td>
         <%  sSvReg = sReg[i];
                      iRow++;
           }%>

         <td class="DataTable1" nowrap>
               <!-- a href="IncPlanStrDtl.jsp?Qtr=<%=sQtr%>&STORE=<%=sStr[i]%>"><%=sStr[i] + " - " + sStrName[i]%></a -->
               <%=sStr[i] + " - " + sStrName[i]%>
         </td>
         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" id="PSMn0P0<%=i%>" nowrap>$<%=sPlan[0][i]%></td>
         <td class="DataTable" id="PSMn0S0<%=i%>" onMouseOver="showStrKioSls(this, '<%=sStrSKStr[i][0]%>', '<%=sStrSKKio[i][0]%>', '<%=sStrSKSls[i][0]%>', '<%=sStrSKEcom[i][0]%>', '<%=sStrSKEcPrc[i][0]%>');" onMouseOut="hideAlwTmc();" nowrap>$<%=sSales[0][i]%></td>
         <td class="DataTable" nowrap>$<%=sPlanVar[0][i]%></td>         
         <th class="Divdr">&nbsp;</th>
         <td class="DataTable" id="PSMn1P0<%=i%>" nowrap>$<%=sPlan[1][i]%></td>
         <td class="DataTable" id="PSMn1S0<%=i%>" onMouseOver="showStrKioSls(this, '<%=sStrSKStr[i][1]%>', '<%=sStrSKKio[i][1]%>', '<%=sStrSKSls[i][1]%>', '<%=sStrSKEcom[i][1]%>', '<%=sStrSKEcPrc[i][1]%>');" onMouseOut="hideAlwTmc();" nowrap>$<%=sSales[1][i]%></td>
         <td class="DataTable" nowrap>$<%=sPlanVar[1][i]%></td>
         <th class="Divdr">&nbsp;</th>
         <td class="DataTable" id="PSMn2P0<%=i%>" nowrap>$<%=sPlan[2][i]%></td>
         <td class="DataTable" id="PSMn2S0<%=i%>" onMouseOver="showStrKioSls(this, '<%=sStrSKStr[i][2]%>', '<%=sStrSKKio[i][2]%>', '<%=sStrSKSls[i][2]%>', '<%=sStrSKEcom[i][2]%>', '<%=sStrSKEcPrc[i][2]%>');" onMouseOut="hideAlwTmc();" nowrap>$<%=sSales[2][i]%></td>
         <td class="DataTable" nowrap>$<%=sPlanVar[2][i]%></td>
         <th class="Divdr">&nbsp;</th>
         <td class="DataTable" id="PSMn3P0<%=i%>" nowrap>$<%=sPlan[3][i]%></td>
         <td class="DataTable" id="PSMn3S0<%=i%>" onMouseOver="showStrKioSls(this, '<%=sStrSKStr[i][3]%>', '<%=sStrSKKio[i][3]%>', '<%=sStrSKSls[i][3]%>', '<%=sStrSKEcom[i][3]%>', '<%=sStrSKEcPrc[i][3]%>');" onMouseOut="hideAlwTmc();" nowrap>$<%=sSales[3][i]%></td>
         <td class="DataTable" >$<%=sPlanVar[3][i]%></td>
         <td class="QTD1" nowrap><%=sPlanVar[4][i]%>%</td>
         
         <td class="DataTable" bgcolor="<%=sBonusClr[i][0]%>"><%=sBonus[i][0]%></td>

         <th class="DataTable">&nbsp;</th>
         <td class="DataTable" id="BAMn0A0<%=i%>" onMouseOver="showAlwTmc(this, '<%=sStrAlwTmcHrs[i][0]%>', '<%=sStrAlwBdgHrs[i][0]%>', '<%=sStrTmcHrs[i][0]%>', '<%=sStrAlwTmcPay[i][0]%>', '<%=sStrAlwBdgPay[i][0]%>', '<%=sStrTmcPay[i][0]%>')" onMouseOut="hideAlwTmc();" nowrap><span id="colPayPrc"><%=sStrAlwBdgPayVsSlsPrc[i][0]%>%</span><span id="colPayHrs"><%=sStrAlwTmcHrs[i][0]%></span><span id="colPayAmt">$<%=sStrAlwTmcPay[i][0]%></span></td>
         <td class="DataTable" id="BAMn0B0<%=i%>" nowrap><span id="colPayPrc"><%=sStrActPayVsSlsPrc[i][0]%>%</span><span id="colPayHrs"><%=sStrActHrs[i][0]%></span><span id="colPayAmt">$<%=sStrActPay[i][0]%></span></td>
         <td class="DataTable" id="net" nowrap><span id="colPayPrc"><%=sStrAlwVsActPayOver[i][0]%>%</span><span id="colPayHrs"><%=sStrOverHrs[i][0]%></span><span id="colPayAmt">$<%=sStrOverPay[i][0]%></span></td>
         <th class="Divdr">&nbsp;</th>
         <!-- td class="DataTable" id="BAMn0T0<%=i%>" nowrap><%=sTmcHrs[0][i]%></td -->

         <td class="DataTable" id="BAMn1A0<%=i%>" onMouseOver="showAlwTmc(this, '<%=sStrAlwTmcHrs[i][1]%>', '<%=sStrAlwBdgHrs[i][1]%>', '<%=sStrTmcHrs[i][1]%>', '<%=sStrAlwTmcPay[i][1]%>', '<%=sStrAlwBdgPay[i][1]%>', '<%=sStrTmcPay[i][1]%>')" onMouseOut="hideAlwTmc();" nowrap><span id="colPayPrc"><%=sStrAlwBdgPayVsSlsPrc[i][1]%>%</span><span id="colPayHrs"><%=sStrAlwTmcHrs[i][1]%></span><span id="colPayAmt">$<%=sStrAlwTmcPay[i][1]%></span></td>
         <td class="DataTable" id="BAMn1B0<%=i%>" nowrap><span id="colPayPrc"><%=sStrActPayVsSlsPrc[i][1]%>%</span><span id="colPayHrs"><%=sStrActHrs[i][1]%></span><span id="colPayAmt">$<%=sStrActPay[i][1]%></span></td>
         <td class="DataTable" id="net" nowrap><span id="colPayPrc"><%=sStrAlwVsActPayOver[i][1]%>%</span><span id="colPayHrs"><%=sStrOverHrs[i][1]%></span><span id="colPayAmt">$<%=sStrOverPay[i][1]%></span></td>
         <th class="Divdr">&nbsp;</th>
         <!--td class="DataTable" id="BAMn1T0<%=i%>" nowrap><%=sTmcHrs[1][i]%></td -->

         <td class="DataTable" id="BAMn2A0<%=i%>" onMouseOver="showAlwTmc(this, '<%=sStrAlwTmcHrs[i][2]%>', '<%=sStrAlwBdgHrs[i][2]%>', '<%=sStrTmcHrs[i][2]%>', '<%=sStrAlwTmcPay[i][2]%>', '<%=sStrAlwBdgPay[i][2]%>', '<%=sStrTmcPay[i][2]%>')" onMouseOut="hideAlwTmc();" nowrap><span id="colPayPrc"><%=sStrAlwBdgPayVsSlsPrc[i][2]%>%</span><span id="colPayHrs"><%=sStrAlwTmcHrs[i][2]%></span><span id="colPayAmt">$<%=sStrAlwTmcPay[i][2]%></span></td>
         <td class="DataTable" id="BAMn2B0<%=i%>" nowrap><span id="colPayPrc"><%=sStrActPayVsSlsPrc[i][2]%>%</span><span id="colPayHrs"><%=sStrActHrs[i][2]%></span><span id="colPayAmt">$<%=sStrActPay[i][2]%></span></td>
         <td class="DataTable" id="net" nowrap><span id="colPayPrc"><%=sStrAlwVsActPayOver[i][2]%>%</span><span id="colPayHrs"><%=sStrOverHrs[i][2]%></span><span id="colPayAmt">$<%=sStrOverPay[i][2]%></span></td>
         <th class="Divdr">&nbsp;</th>
         <!-- td class="DataTable" id="BAMn2T0<%=i%>" nowrap><%=sTmcHrs[2][i]%></td -->

         <td class="DataTable" id="BAMn3A0<%=i%>" onMouseOver="showAlwTmc(this, '<%=sStrAlwTmcHrs[i][3]%>', '<%=sStrAlwBdgHrs[i][3]%>', '<%=sStrTmcHrs[i][3]%>', '<%=sStrAlwTmcPay[i][3]%>', '<%=sStrAlwBdgPay[i][3]%>', '<%=sStrTmcPay[i][3]%>')" onMouseOut="hideAlwTmc();"nowrap><span id="colPayPrc"><%=sStrAlwBdgPayVsSlsPrc[i][3]%>%</span><span id="colPayHrs"><%=sStrAlwTmcHrs[i][3]%></span><span id="colPayAmt">$<%=sStrAlwTmcPay[i][3]%></span></td>
         <td class="DataTable" id="BAMn3B0<%=i%>" nowrap><span id="colPayPrc"><%=sStrActPayVsSlsPrc[i][3]%>%</span><span id="colPayHrs"><%=sStrActHrs[i][3]%></span><span id="colPayAmt">$<%=sStrActPay[i][3]%></span></td>
         <td class="DataTable3"  nowrap><span id="colPayPrc" ><%=sStrAlwVsActPayOver[i][3]%>%</span><span id="colPayHrs"><%=sStrOverHrs[i][3]%></span><span id="colPayAmt">$<%=sStrOverPay[i][3]%></span></td>
         <!--td class="QTD1" nowrap><%=sHrsVar[4][i]%>%</td -->
         <!-- td class="DataTable" id="BAMn3T0<%=i%>" nowrap><%=sTmcHrs[3][i]%></td -->

         <td class="DataTable" <%if(!sBonus[i][3].equals("0")){%>style="background: MediumSeaGreen;"<%}%>>&nbsp;<%if(!sBonus[i][3].equals("0") ){%>$<%=sBonus[i][3]%><%}%></td>
         <th class="DataTable">&nbsp;</th>
         <th class="DataTable"><a  target="_blank" href="BfdgSchActQtr.jsp?Store=<%=sStr[i]%>&Year=<%=iAlwBdgYear%>&Qtr=<%=iAlwBdgQtr%>">Q</a></th>
         
         <td class="QTD1" id="Unused01"><a href="javascript:showStrMsDtl(<%=i%>, '<%=sMstScr[0][i]%>', '<%=sStr[i] + " - " + sStrName[i]%>')"><%=sMstScr[0][i]%></a></td>
         <th class="DataTable">&nbsp;</th>
         <td class="QTD1" id="Unused01"><a href="javascript:showStrAudDtl(<%=i%>, '<%=sStaScr[0][i]%>', '<%=sStr[i] + " - " + sStrName[i]%>')"><%=sStaScr[0][i]%></a></td>
         <!-- td class="QTD1"><%=sStrPvo[i]%></td -->
         <!-- td class="QTD1"><%=sStrSurv[i]%></td -->


         <%if(sGrp.equals("MGR6") || sGrp.equals("MGRPI")){%>
             <td class="DataTable"><%=sBonusScr[i][1]%></td>
             <td class="DataTable" bgcolor="<%=sBonusClr[i][1]%>"><%=sBonus[i][1]%></td>
             <th class="DataTable">&nbsp;</th>
             <td class="DataTable"><%=sBonusScr[i][2]%>%</td>
             <td class="DataTable" bgcolor="<%=sBonusClr[i][2]%>"><%=sBonus[i][2]%></td>                          
         <%}%>
         <th class="DataTable">&nbsp;</th>
         <td class="DataTable" bgcolor="<%=sBonusClr[i][8]%>" ><%=sBonus[i][8]%></td> 
         <th class="DataTable">&nbsp;</th>        
         <td class="DataTable1" nowrap><%=sStr[i] + " - " + sStrName[i]%></td>
      </tr>

<!-------------------------------- Region Totals --------------------------------->
      <%if(i+1 == iNumOfStr || !sSvReg.equals(sReg[i+1])) {%>
        <tr class="DataTable1">
          <td class="DataTable1" colspan="2">DM Payout</td>
          <%for(int j=0; j < 7; j++ ) {%>
            <%if(j==6) j++;%>

            <%if(j==3) {%>
            	<td class="DataTable" bgcolor="<%=sRepBonusClr[iRow-1][0]%>"><%=sRepBonus[iRow-1][0]%></td>            	
            <%}%>
            
            <%if(j==4) {%>
              <td class="DataTable" <%if(!sRepBonus[iRow-1][3].equals("0")){%>style="background: MediumSeaGreen;"<%}%> >&nbsp;<%if(!sRepBonus[iRow-1][3].equals("0")){%>$<%=sRepBonus[iRow-1][3]%><%}%></td>
              <th class="DataTable">&nbsp;</th>
            <%}%>
            
            <%if(j < 7) {%>            
              <th class="DataTable">&nbsp;</th>
            <%}%>
            
            <%for(int k=0; k < 4; k++ ) {%>

              <%if(j==0) {%>
                <td class="DataTable" id="PSMn<%=k%>PR<%=iRow-1%>">$<%=sRepTotVal[k][iRow-1][0]%></td>
                <td class="DataTable" onMouseOver="showStrKioSls(this, '<%=sRegSKStr[iRow-1][k]%>', '<%=sRegSKKio[iRow-1][k]%>', '<%=sRegSKSls[iRow-1][k]%>', '<%=sRegSKEcom[iRow-1][k]%>', '<%=sRegSKEcPrc[iRow-1][k]%>');" onMouseOut="hideAlwTmc();" id="PSMn<%=k%>SR<%=iRow-1%>">$<%=sRepTotVal[k][iRow-1][1]%></td>                               
              <%}%>
              <%if(j==3) {%>
                <td class="DataTable" onMouseOver="showAlwTmc(this, '<%=sRegAlwTmcHrs[iRow-1][k]%>', '<%=sRegAlwBdgHrs[iRow-1][k]%>', '<%=sRegTmcHrs[iRow-1][k]%>', '<%=sRegAlwTmcPay[iRow-1][k]%>', '<%=sRegAlwBdgPay[iRow-1][k]%>', '<%=sRegTmcPay[iRow-1][k]%>')" onMouseOut="hideAlwTmc();" nowrap id="BAMn<%=k%>AR<%=iRow-1%>">
                <span id="colPayPrc"><%=sRegAlwBdgPayVsSlsPrc[iRow-1][k]%>%</span><span id="colPayHrs"><%=sRegAlwTmcHrs[iRow-1][k]%></span><span id="colPayAmt">$<%=sRegAlwTmcPay[iRow-1][k]%></span></td>
                <td class="DataTable" nowrap id="BAMn<%=k%>BR<%=iRow-1%>"><span id="colPayPrc"><%=sRegActPayVsSlsPrc[iRow-1][k]%>%</span><span id="colPayHrs"><%=sRegActHrs[iRow-1][k]%></span><span id="colPayAmt">$<%=sRegActPay[iRow-1][k]%></span></td>                
              <%}%>
              
              <%if(j < 4 ){%>                
                <td class="DataTable" nowrap  
                  <%if(k==3 && (j==0 || j>=3)){%><%}%>
                  id="<%if(j==2 && k < 3){%>tmc<%} else if(j==3 && k < 3){%>net<%} else {%>all<%}%>">
                  <%if(j==0){%>$<%=sRepTot[0][iRow-1][k]%><%} else {%><span id="colPayPrc"><%=sRegAlwVsActPayOver[iRow-1][k]%>%</span><span id="colPayHrs"><%=sRegOverHrs[iRow-1][k]%></span><span id="colPayAmt">$<%=sRegOverPay[iRow-1][k]%></span><%}%></td><!-- Budget Varieance -->
                  <%if(k < 3 ){%><th class="Divdr">&nbsp;</th><%}%>
              <%}%>

              

             <%if(j==4 && k==0) {%>
                  <td class="QTD1" nowrap id="Unused01"> 
                   <%=sRepTot[4][iRow-1][k]%></td>
            <%}%>
             <%if(j==5 && k==0) {%>
                  <td class="QTD1" nowrap  id="Unused01"><%=sRepTot[6][iRow-1][k]%></td>
             <%}%>
             

            <%}%>

            <%if(j==0) {%>
                <td class="QTD1" nowrap  >
                		<%=sRepTot[5][iRow-1][3]%>%
                </td>
            <%}%>

            <%if(j==0) j=+ 2; /* skip removed column total */%>
          <%}%>
          
          <%if(sGrp.equals("MGR6") || sGrp.equals("MGRPI")){%>
             <td class="DataTable">&nbsp;<%=sRepBonusScr[iRow-1][1]%></td>
             <td class="DataTable" bgcolor="<%=sRepBonusClr[iRow-1][1]%>"><%=sRepBonus[iRow-1][1]%></td>
             <th class="DataTable">&nbsp;</th>
             <td class="DataTable" <%if(iRow-1 == 0){%>style="background: pink;" onMouseOver="showComment(this, true)" onMouseOut="showComment(this, false)"<%}%>><%=sRepBonusScr[iRow-1][2]%>%</td>
             <td class="DataTable" bgcolor="<%=sRepBonusClr[iRow-1][2]%>"><%=sRepBonus[iRow-1][2]%></td>
          <%}%>
          <th class="DataTable">&nbsp;</th>
          <td class="DataTable" bgcolor="<%=sRepBonusClr[iRow-1][8]%>"><%=sRepBonus[iRow-1][8]%></td>
          <th class="DataTable">&nbsp;</th>          
          <td class="DataTable">DM Payout</td>
        </tr>
      <%}%>
<!---------------------------- end of Region Totals ------------------------------>
    <%}%>
<!-------------------------------- Report Totals --------------------------------->
    <tr class="DataTable2">
      <td class="DataTable1" colspan="2">Report Totals</td>
       <%for(int j=0; j < 7; j++ ) {%>
         <%if(j==5) j++;%>
         
         <%if(j==4) {%>
         	<td class="DataTable" <%if(!sRepBonus[3][3].equals("0")){%>style="background: MediumSeaGreen;"<%}%>>&nbsp;<%if(!sRepBonus[3][3].equals("0")){%>$<%=sRepBonus[3][3]%><%}%></td>
         	<th class="DataTable">&nbsp;</th>
         <%}%>
         <th class="DataTable"><%if(j==4){%><a  target="_blank" href="BfdgSchActQtrAllStr.jsp?Year=<%=iAlwBdgYear%>&Qtr=<%=iAlwBdgQtr%>">Q</a><%} else {%>&nbsp;<%}%></th>
         
         <%for(int k=0; k < 4; k++ ) {%>

            <%if(j==0) {%>
                <td class="DataTable" id="PSMn<%=k%>PT"><%=sRepTotVal[k][4][0]%></td>
                <td class="DataTable" onMouseOver="showStrKioSls(this, '<%=sRepSKStr[k]%>', '<%=sRepSKKio[k]%>', '<%=sRepSKSls[k]%>', '<%=sRepSKEcom[k]%>', '<%=sRepSKEcPrc[k]%>');" onMouseOut="hideAlwTmc();" id="PSMn<%=k%>ST"><%=sRepTotVal[k][4][1]%></td>
            <%}%>
            <%if(j==3) {%>                
                <td class="DataTable" id="BAMn<%=k%>AT" onMouseOver="showAlwTmc(this, '<%=sRegAlwTmcHrs[4][k]%>', '<%=sRegAlwBdgHrs[4][k]%>', '<%=sRegTmcHrs[4][k]%>', '<%=sRegAlwTmcPay[4][k]%>', '<%=sRegAlwBdgPay[4][k]%>', '<%=sRegTmcPay[4][k]%>')" onMouseOut="hideAlwTmc();">
                  <span id="colPayPrc"><%=sRegAlwBdgPayVsSlsPrc[4][k]%>%</span><span id="colPayHrs"><%=sRegAlwBdgHrs[4][k]%></span><span id="colPayAmt">$<%=sRegAlwTmcPay[4][k]%></span></td>
                <td class="DataTable" id="BAMn<%=k%>BT"><span id="colPayPrc"><%=sRegActPayVsSlsPrc[4][k]%>%</span><span id="colPayHrs"><%=sRegActHrs[4][k]%></span><span id="colPayAmt">$<%=sRegActPay[4][k]%></span></td>
              <%}%>

          <%if(j < 4) {%>
            <td class="DataTable" nowrap
                id="<%if(j==2 && k < 3){%>tmc<%} else  if(j==3 && k < 3){%>net<%} else{%>all<%}%>">
                  <%if(j==0){%>$<%=sRepTot[0][4][k]%><%} else {%><span id="colPayPrc"><%=sRegAlwVsActPayOver[4][k]%>%</span><span id="colPayHrs"><%=sRegOverHrs[4][k]%></span><span id="colPayAmt">$<%=sRegOverPay[4][k]%></span><%}%></td>
             <%if(k < 3 ){%><th class="Divdr">&nbsp;</th><%}%>
          <%}%>
            <%if(j==3) {%>
                <!--td class="DataTable" nowrap id="BAMn<%=k%>TR"><%=sRepTot[1][4][k]%></td-->
                <%if(k==3) {%>
                    <!--td class="QTD1" nowrap><%=sRepTot[7][4][k]%>%</td-->
                  <%}%>
            <%}%>
          <%if(j==4 && k==0) {%>
                <td class="QTD1" nowrap id="Unused01"> <!-- id="Scr<%=k%>TR" -->
                      <%=sRepTot[4][4][k]%></td>
          <%}%>
          <!-- store audit -->
          <%if(j==6 && k==0) {%>
                <td class="QTD1" nowrap id="Unused01"> <!-- id="SaScr<%=k%>TR" -->
                     <%=sRepTot[6][4][k]%></td>
          <%}%>

          
          <%}%>
            <%if(j==0) {%>
                <td class="QTD1"><%=sRepTot[5][4][3]%>%</td>
                <td class="DataTable" bgcolor="<%=sRepBonusClr[3][0]%>" onmouseover="showTotScore('<%=dRepTotScr[0]%>', 'Sls', this)" onMouseOut="hideAlwTmc();"><%=sRepBonus[3][0]%></td>
            <%}%>
         <%if(j==0) j=+ 2; /* skip removed column total */%>
       <%}%>
       
       
       <%if(sGrp.equals("MGR6") || sGrp.equals("MGRPI")){%>
           <td class="DataTable">&nbsp;</td>
           <td class="DataTable" bgcolor="<%=sRepBonusClr[3][1]%>" onmouseover="showTotScore('<%=dRepTotScr[1]%>', 'Marketing', this)" onMouseOut="hideAlwTmc();"><%=sRepBonus[3][1]%></td>
           <th class="DataTable">&nbsp;</th>
           <td class="DataTable"><%=sRepBonusScr[3][2]%>%</td>
           <td class="DataTable" bgcolor="<%=sRepBonusClr[3][2]%>" onmouseover="showTotScore('<%=dRepTotScr[2]%>', 'ECOMM', this)" onMouseOut="hideAlwTmc();"><%=sRepBonus[3][2]%></td>
       <%}%>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable" bgcolor="<%=sRepBonusClr[3][8]%>" onmouseover="showTotScore('<%=dRepTotScr[8]%>', 'Total', this)" onMouseOut="hideAlwTmc();"><%=sRepBonus[3][8]%></td>       
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable1" colspan="2">Report Totals</td>
    </tr>

<!---------------------------- end of Report Totals ------------------------------>
 </table>
 <p  align="left" style="font-size:12px"> 
  ***  On Monday's the Allowable Budget amount will include last weeks budget, BUT until payroll is processed the actuals will not. This will result in store showing under until payroll actuals are updated by about 3-4 PM Monday.   
 <br>  *Marketing (Chatmeter) Scores are ONLY updated weekly.
   
   <%if(sGrp.equals("MGR6")) {%><br>*To see Incentive Plan Table click <a href="IncPlanArchive/Incentive_Plan_Table_Q3_2019.pdf" target="_blank">here</a><%}
     else if(sGrp.equals("MGRPI")) {%><br>*To see Incentive Plan Table click <a href="IncPlanArchive/Pilot Structure Bonus.xls" target="_blank">here</a><%}
     else {%><br>*To see Incentive Plan Table click <a href="IncPlanArchive/Floor_Supervisor_Quarterly_Incentive(2007-08).xls" target="_blank">here</a><%}%>
     
   <br>*To see - Customer Chatmeter Survey Score - click 
   <a href="http://live.chatmeter.com/#/" target="_blank">here</a>   
 </span>
 <!----------------------- end of table ------------------------>
 <tr id="trAlwBdgDtl" style="display:none">
 <p style="page-break-before: always;">
     <td>
       <table border=1 cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable" rowspan=4>Store</th>
           <th class="DataTable" colspan=28>Allowable Budget</th>
         </tr>
         <tr>
           <th class="DataTable" rowspan="3">&nbsp;</th>
           <th class="DataTable" colspan="6"><%=sMon[0]%></th>
           <th class="DataTable" rowspan="3">&nbsp;</th>
           <th class="DataTable" colspan="6"><%=sMon[1]%></th>
           <th class="DataTable" rowspan="3">&nbsp;</th>
           <th class="DataTable" colspan="6"><%=sMon[2]%></th>
           <th class="DataTable" rowspan="3">&nbsp;</th>
           <th class="DataTable" colspan="6">Q-T-D &nbsp; W/E <%=sQtdWkend%></th>
         </tr>
         <tr style="vertical-align:top;">
           <th class="DataTable">Allowable Budgeted</th>
           <th class="DataTable">TMC<br>Hrs</th>
           <th class="DataTable">Allowable<br>&<br>TMC</th>
           <th class="DataTable">Allowable<br>Budgeted</th>
           <th class="DataTable">TMC</th>
           <th class="DataTable">Allowable<br>&<br>TMC</th>

           <th class="DataTable">Allowable Budgeted Hrs</th>
           <th class="DataTable">TMC<br>Hrs</th>
           <th class="DataTable">Allowable<br>&<br>TMC</th>
           <th class="DataTable">Allowable<br>Budgeted</th>
           <th class="DataTable">TMC</th>
           <th class="DataTable">Allowable<br>&<br>TMC</th>

           <th class="DataTable">Allowable Budgeted</th>
           <th class="DataTable">TMC</th>
           <th class="DataTable">Allowable<br>&<br>TMC</th>
           <th class="DataTable">Allowable<br>Budgeted</th>
           <th class="DataTable">TMC</th>
           <th class="DataTable">Allowable<br>&<br>TMC</th>

           <th class="DataTable">Allowable Budgeted</th>
           <th class="DataTable">TMC</th>
           <th class="DataTable">Allowable<br>&<br>TMC</th>
           <th class="DataTable">Allowable<br>Budgeted</th>
           <th class="DataTable">TMC</th>
           <th class="DataTable">Allowable<br>&<br>TMC</th>
         </tr>

         <tr>
           <th class="DataTable" colspan="3">Hours</th>
           <th class="DataTable" colspan="3">$'s</th>
           <th class="DataTable" colspan="3">Hours</th>
           <th class="DataTable" colspan="3">$'s</th>
           <th class="DataTable" colspan="3">Hours</th>
           <th class="DataTable" colspan="3">$'s</th>
           <th class="DataTable" colspan="3">Hours</th>
           <th class="DataTable" colspan="3">$'s</th>
         </tr>



      <%sSvReg = " ";
      iRow = 0;
      for(int i=0; i < iNumOfStr; i++){%>
         <tr class="DataTable">
           <%if(!sSvReg.equals(sReg[i]))
           {
                sSvReg = sReg[i]; iRow++;
           }%>

           <td class="DataTable"><%=sStr[i]%></td>

           <th class="DataTable">&nbsp;</th>
           <td class="DataTable"><%=sStrAlwBdgHrs[i][0]%></td>
           <td class="DataTable"><%=sStrTmcHrs[i][0]%></td>
           <td class="DataTable"><%=sStrAlwTmcHrs[i][0]%></td>
           <td class="DataTable">$<%=sStrAlwBdgPay[i][0]%></td>
           <td class="DataTable">$<%=sStrTmcPay[i][0]%></td>
           <td class="DataTable">$<%=sStrAlwTmcPay[i][0]%></td>

           <th class="DataTable">&nbsp;</th>
           <td class="DataTable"><%=sStrAlwBdgHrs[i][1]%></td>
           <td class="DataTable"><%=sStrTmcHrs[i][1]%></td>
           <td class="DataTable"><%=sStrAlwTmcHrs[i][1]%></td>
           <td class="DataTable">$<%=sStrAlwBdgPay[i][1]%></td>
           <td class="DataTable">$<%=sStrTmcPay[i][1]%></td>
           <td class="DataTable">$<%=sStrAlwTmcPay[i][1]%></td>

           <th class="DataTable">&nbsp;</th>
           <td class="DataTable"><%=sStrAlwBdgHrs[i][2]%></td>
           <td class="DataTable"><%=sStrTmcHrs[i][2]%></td>
           <td class="DataTable"><%=sStrAlwTmcHrs[i][2]%></td>
           <td class="DataTable">$<%=sStrAlwBdgPay[i][2]%></td>
           <td class="DataTable">$<%=sStrTmcPay[i][2]%></td>
           <td class="DataTable">$<%=sStrAlwTmcPay[i][2]%></td>

           <th class="DataTable">&nbsp;</th>
           <td class="DataTable"><%=sStrAlwBdgHrs[i][3]%></td>
           <td class="DataTable"><%=sStrTmcHrs[i][3]%></td>
           <td class="DataTable"><%=sStrAlwTmcHrs[i][3]%></td>
           <td class="DataTable">$<%=sStrAlwBdgPay[i][3]%></td>
           <td class="DataTable">$<%=sStrTmcPay[i][3]%></td>
           <td class="DataTable">$<%=sStrAlwTmcPay[i][3]%></td>
         </tr>

        <%if(i+1 == iNumOfStr || !sSvReg.equals(sReg[i+1])) {%>
           <tr class="DataTable1">
             <td class="DataTable1" nowrap>DM Payout</td>

             <%for(int k=0; k < 4; k++ ) {%>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable1"><%=sRegAlwBdgHrs[iRow-1][k]%></td>
                <td class="DataTable1"><%=sRegTmcHrs[iRow-1][k]%></td>
                <td class="DataTable1"><%=sRegAlwTmcHrs[iRow-1][k]%></td>
                <td class="DataTable1">$<%=sRegAlwBdgPay[iRow-1][k]%></td>
                <td class="DataTable1">$<%=sRegTmcPay[iRow-1][k]%></td>
                <td class="DataTable1">$<%=sRegAlwTmcPay[iRow-1][k]%></td>
             <%}%>
        <%}%>
      <%}%>
        <tr class="DataTable1">
          <td class="DataTable1" nowrap>Report Totals</td>
            <%for(int k=0; k < 4; k++ ) {%>
                <th class="DataTable">&nbsp;</th>
                <td class="DataTable1"><%=sRegAlwBdgHrs[4][k]%></td>
                <td class="DataTable1"><%=sRegTmcHrs[4][k]%></td>
                <td class="DataTable1"><%=sRegAlwTmcHrs[4][k]%></td>
                <td class="DataTable1">$<%=sRegAlwBdgPay[4][k]%></td>
                <td class="DataTable1">$<%=sRegTmcPay[4][k]%></td>
                <td class="DataTable1">$<%=sRegAlwTmcPay[4][k]%></td>
            <%}%>
        </tr>
       </table>
     </td>
   </tr>

  </table>
  
  <%
long lEndTime = (new java.util.Date()).getTime();
long lElapse = (lEndTime - lStartTime) / 1000;
if (lElapse==0) {lElapse = 1;}
//System.out.println("B/Item X-fer loading Elapse time=" + lElapse + " second(s)");
%>
<p  style="text-align: left; font-size:10px; font-weigth:bold;">Elapse: <%=lElapse%> sec.</td>
  
  
 </body>
</html>
