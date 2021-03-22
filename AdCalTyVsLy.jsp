<%@ page import="advertising.AdCalTyVsLy,advertising.AdCalSel, rciutility.FormatNumericValue, java.util.*"%>
<%
   String sMonBeg = request.getParameter("MonBeg");
   String sMonName = request.getParameter("MonName");
   // promotion filter paramters
   String sFilterPromo = request.getParameter("FilterPromo");
   String sFilterAdType = request.getParameter("FilterAdType");
   String sFilterAdTypeDes = request.getParameter("FilterAdTypeDes");
   String sFilterAdName = request.getParameter("FilterAdName");
   // media filter parameter
   String sFilterMedia = request.getParameter("FilterMedia");
   String sFilterMedCode = request.getParameter("FilterMedCode");
   String sFilterMedIdx = request.getParameter("FilterMedIdx");
   String sFilterMedName = request.getParameter("FilterMedName");

   if(sFilterPromo==null) sFilterPromo="false";
   if(sFilterMedia==null) sFilterMedia="false";

   int iNumOfMkt = 0;
   String [] sMkt = null;
   String [] sMktName = null;
   int [] iNumOfStr = null;
   String sMktJsa = null;
   String sMktNameJsa = null;
   String sStrJsa = null;

   int iNumOfWk = 0;
   String [] sWkend = null;
   String sWkendJsa = null;

   String [] sPrvNxtMonth = null;
   String [] sPrvNxtMonName = null;

   String sMediaJsa = null;
   String sMedNameJsa = null;

   String sPromoJsa = null;
   String sEventJsa = null;
   String sNonEvtJsa = null;
   String sMedComJsa = null;


   //  market total
    String [][] sMTPlnCost = null;
    String [][] sMTActCost = null;
    String [][] sMTFinCost = null;
    String [][] sMTPlanPrc = null;
    String [][] sMTPlan = null;
    // report total
    String [] sRTPlnCost = null;
    String [] sRTActCost = null;
    String [] sRTFinCost = null;
    String [] sRTPlanPrc = null;
    String [] sRTPlan = null;


    //weekly plan total
    String [] sWkPlan = null;

   //----------------------------------
   // Application Authorization
   //----------------------------------


   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=AdCalTyVsLy.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
     String sAppl = null;
     if(session.getAttribute("ADVERTISES") != null) sAppl = session.getAttribute("ADVERTISES").toString();

     // Get Month list
     AdCalSel adCalSel = new AdCalSel();

     String sMonBegJsa = adCalSel.getMonBegJsa();
     String sMonNameJsa = adCalSel.getMonNameJsa();
     String sYearJsa = adCalSel.getYearJsa();
     String sCurMon = adCalSel.getCurMon();

     adCalSel.disconnect();


     AdCalTyVsLy adCal = new AdCalTyVsLy(sMonBeg);

     iNumOfMkt = adCal.getNumOfMkt();
     sMkt = adCal.getMkt();
     sMktName = adCal.getMktName();
     iNumOfStr = adCal.getNumOfStr();
     sMktJsa = adCal.getMktJsa();
     sMktNameJsa = adCal.getMktNameJsa();
     sStrJsa = adCal.getStr();

     iNumOfWk = adCal.getNumOfWk();
     sWkend = adCal.getWkend();
     sWkendJsa = adCal.getWkendJsa();

     sPrvNxtMonth = adCal.getPrvNxtMonth();
     sPrvNxtMonName = adCal.getPrvNxtMonName();

     sMediaJsa = adCal.getMediaJsa();
     sMedNameJsa = adCal.getMedNameJsa();

     sPromoJsa = adCal.getPromoJsa();
     sEventJsa = adCal.getEventJsa();
     sNonEvtJsa = adCal.getNonEvtJsa();
     sMedComJsa = adCal.getMedComJsa();

     //  market total
     sMTPlnCost = adCal.getMTPlnCost();
     sMTActCost = adCal.getMTActCost();
     sMTFinCost = adCal.getMTFinCost();
     sMTPlanPrc = adCal.getMTPlanPrc();
     sMTPlan = adCal.getMTPlan();
     // report total
     sRTPlnCost = adCal.getRTPlnCost();
     sRTActCost = adCal.getRTActCost();
     sRTFinCost = adCal.getRTFinCost();
     sRTPlanPrc = adCal.getRTPlanPrc();
     sRTPlan = adCal.getRTPlan();

     //weekly plan total
     sWkPlan = adCal.getWkPlan();

     // set selected month argument to use it in calendar
     int iMonth = Integer.parseInt(sMonBeg.substring(0, 2)) - 1;
     int iYear = Integer.parseInt(sMonBeg.substring(6));
       if (iMonth==11 && sMonName.substring(0, 3).equals("Jan")) iYear++;

     String [] sMon = new String[]{"January","February","March","April","May","June", "July",
                       "August", "September", "October", "November", "December"};
     for(int i=0, j=0; i < sMon.length; i++)
     {
        j = sMon[i].length();
        if(sMon[i].equals(sMonName.substring(0, j))) { iMonth = i;  break; }
     }

     String sEvtCalLink = adCal.getEvtCalLink();

     // format Numeric value
     FormatNumericValue fmt = new FormatNumericValue();

     StringBuffer sbWeeks = new StringBuffer();
     for(int i=0; i < iNumOfWk; i++) { sbWeeks.append("&Week=" + sWkend[i]); }
%>
<html>
<head>

</head>
<style>
@media screen
{
  div.Filter { background-attachment: scroll;
              border: black solid 2px; width:250; background-color:lightgrey; z-index:10;
              text-align:center; font-size:10px}
  div.Month {  background-color:cornsilk; background-attachment: scroll; border: black solid 2px; width:250;
                    padding-top:3px; padding-bottom:3px; z-index: 1; text-align:center; font-size:10px}
  .PageBreak1 {display:none;}
}
@media print
{
   div.Filter { display:none}
   div.Month { display:none}
   .PageBreak1 {display:none;}
}

        body {background:white;}
        a { color:blue} a:visited { color:blue}  a:hover { color:blue}

        table.DataTable { border: darkred solid 1px; background:#FFE4C4;text-align:center;}
        tr.split { text-align:right; font-family:Arial; font-size:10px }
        tr.split1 { text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center;
                       font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center;
                       font-family:Verdanda; font-size:12px }
        th.DataTable2 { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:right;
                       font-family:Verdanda; font-size:12px }
        th.DataTable3 { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-bottom: darkred solid 1px; text-align:center; font-family:Verdanda; font-size:12px }

        tr.TY { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.LY { background:azure; font-family:Arial; font-size:10px }

        td.DataTable { background:cornsilk; border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                       text-align:left; font-family:Arial; font-size:10px }
        td.DataTable1 { background:lightgrey; cursor: hand; border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                        border-right: darkred solid 1px; text-align:left; font-family:Arial;font-size:10px }
        td.DataTable2 { background:seashell; border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:20px; padding-right:3px; border-right: darkred solid 1px; text-align:left;
                        font-family:Arial; font-size:10px }
        td.DataTable2a { background:seashell; border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                        border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }


        td.DataTable3  { border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px; text-align:right;}
        td.DataTable3a { cursor: hand; border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:40px; padding-right:3px; border-right: darkred solid 1px;
                       text-align:left;}

        td.DataTable4 { background:cornsilk; border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable5 { background:cornsilk; border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable6 { background:cornsilk; border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }

        div.Menu { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:#EEEEEE; z-index:1;
              text-align:center; font-size:10px}
        td.Menu   {border-bottom: black solid 1px; cursor: hand; text-align:left; font-family:Arial; font-size:10px; }
        td.Menu1  {color:blue;border-bottom: black solid 1px; text-align:center; font-family:Arial; font-size:11px; font-weight:bold}

        div.Promo { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:900; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }

        td.Promo  {border-bottom: black solid 2px; text-align:center; font-family:Arial; font-size:10px;
                   padding-top:3px; padding-bottom:3px;}
        td.Promo1 {border-bottom: black solid 2px; border-right: black solid 1px; text-align:center;
                   font-family:Arial; font-size:10px; }
        td.Promo2 {border-bottom: black solid 2px; border-right: black solid 1px; padding-left:3px;
                   text-align:left; font-family:Arial; font-size:10px; }
        .small{ text-align:left; font-family:Arial; font-size:10px;}

        tr.Filter { text-align:left; font-family:Arial; font-size:10px;
                   padding-top:3px; padding-bottom:3px;}
        tr.Filter1 { text-align:center; font-family:Arial; font-size:12px;
                   font-weight:bold}
        .PageBreak {display:none; page-break-before:auto}

</style>
<SCRIPT language="JavaScript1.2">
//------------------------------------------------------------------------------
// global variables
//------------------------------------------------------------------------------
  var Wkend = [<%=sWkendJsa%>];
  var Market = [<%=sMktJsa%>];
  var MktName = [<%=sMktNameJsa%>];
  var Store = [<%=sStrJsa%>];
  var Media = [<%=sMediaJsa%>];
  var MedName = [<%=sMedNameJsa%>];
  var Promo  = [<%=sPromoJsa%>];
  var Event  = [<%=sEventJsa%>];
  var NonEvt = [<%=sNonEvtJsa%>];
  var MedCom = [<%=sMedComJsa%>];

  var MonBegs = [<%=sMonBegJsa%>];
  var MonName = [<%=sMonNameJsa%>];
  var Year = [<%=sYearJsa%>];
  var CurMon = <%=sCurMon%>;
  var scMonth = <%=iMonth%>;
  var scYear = <%=iYear%>;
  //------------------------------------------------------------------------------
  // save selected values
  var SelMedia = null;
  var SelAdType = null;
  var SelAdTypeDes = null;
  var SelAdName = null;
  var SelSeq = null;
  var SelPayee = null;
  var SelComment = null;
  var SelCombo = "";
  var SelComboType = "";
  var SelSize = null;
  var SelWDay = null;
  var SelRate = null;
  var SelSect = null;
  var SelZone = null;
  var SelSpot = null;
  var SelFrDate = null;
  var SelToDate = null;
  var SelStr = null;
  var SelNumWk = null;
  var SelTotPlnCost = null;
  var SelTotActCost = null;
  var SelTotFinCost = null;
  var SelMkt = null;
  var SelWk = null;
  var SelOrgWk = null;
  var SelObj = null;
  var SelAction = null;
  var SelLevel = null;
  var SelMonWk = false;
  var SelCoopA = null;
  var SelCoopP = null;

  // promotion filter variables
  var FilterPromo = <%=sFilterPromo%>;
  var FilterAdType = null;
  var FilterAdTypeDes = null;
  var FilterAdName = null;
  if (FilterPromo) {  FilterAdType = '<%=sFilterAdType%>'; FilterAdTypeDes = '<%=sFilterAdTypeDes%>'; FilterAdName = '<%=sFilterAdName%>';  }


  // media filter variables
  var FilterMedia = <%=sFilterMedia%>;
  var FilterMedCode = null;
  var FilterMedIdx = null;
  var FilterMedName = null;
  if (FilterMedia) { FilterMedCode = '<%=sFilterMedCode%>'; FilterMedIdx = '<%=sFilterMedIdx%>'; FilterMedName = '<%=sFilterMedName%>'; }
  var DtlMktLvl = true;
  var DtlGrpLvl = true;

  //Media Rate and rate type
  var RateType = null;
  var Rate = null;
  var PlanAmtVisible = false;
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
// body load
//------------------------------------------------------------------------------
function bodyLoad()
{
   dspGrpDtl()
   dspMktDtl()
   setMonth();
   showPlanAmt();

   // activate move box
   setBoxclasses(["BoxName",  "BoxClose"], ["promo", "menu"]);
}

//==============================================================================
// Setup Ad type list
//==============================================================================
function setAdType()
{
  var i = 0;
  if(Promo.length > 0) document.all.AdType.options[i++] = new Option( "Promotion", "P");
  if(Event.length > 0) document.all.AdType.options[i++] = new Option( "Event", "E");
  if(NonEvt.length > 0) document.all.AdType.options[i++] = new Option("Non-Event", "N" );
  if(MedCom.length > 0) document.all.AdType.options[i++] = new Option("Media Commitments", "M" );
  document.all.AdType.options[i] = new Option( "None", "X");
  document.all.AdType.selectedIndex=i;
  showAdList();
}

//==============================================================================
// Setup Adv List drop-menu
//==============================================================================
function showAdList()
{
  var adType = document.all.AdType[document.all.AdType.selectedIndex].value;
  var numOnList = document.all.AdList.length;

  for (var i = numOnList; i > 0; i--)  { document.all.AdList.options[i]=null; }

  if(adType=="P") { for (var i = 0; i < Promo.length; i++) { document.all.AdList.options[i] = new Option(Promo[i], Promo[i]); } }
  else if(adType=="E")  { for (var i = 0; i < Event.length; i++) { document.all.AdList.options[i] = new Option(Event[i], Event[i]); } }
  else if(adType=="N")  { for (var i = 0; i < NonEvt.length; i++) { document.all.AdList.options[i] = new Option(NonEvt[i], NonEvt[i]); } }
  else if(adType=="M")  { for (var i = 0; i < MedCom.length; i++) { document.all.AdList.options[i] = new Option(MedCom[i], MedCom[i]); } }
  else if(adType=="X")  { document.all.AdList.options[i] = new Option("None", "NONE" ); }
}

//==============================================================================
// Setup month drop-menu
//==============================================================================
function setMonth()
{
  var da = document.all;
  for (var i = 0; i < MonBegs.length; i++)
  {
    da.FiscMon.options[i] = new Option(MonName[i] + "  " + Year[i], MonBegs[i]);
  }
  da.FiscMon.selectedIndex = CurMon;
}

//------------------------------------------------------------------------------
// display Action Menu
//------------------------------------------------------------------------------
function dspActionMenu(obj, mkt, wk, media, adtype, adtypedes, adname, orgwk, seq, numwk, payee,
     size, wday, rate, sect, spot, coopa, coopp, comment, combo, combotype, zone, totplncost, totactcost, totfincost, frdate, todate, str,  exist)
{

   var curLeft = 0;
   var curTop = 0;
   var MenuName = "";
   var MenuOpt = "";

   var funcdsp = null;

   SelMkt = mkt;
   SelObj = obj;

   SelOrgWk = orgwk;
   SelWk = wk;
   SelAdType = adtype;
   SelAdTypeDes = adtypedes;
   SelAdName = adname;
   SelSeq = seq;
   SelPayee = payee;
   SelComment = comment;
   SelCombo = combo;
   SelComboType = combotype;
   SelSize = size;
   SelWDay = wday;
   SelRate = rate;
   SelSect = sect;
   SelZone = zone;
   SelSpot = spot;
   SelCoopA = coopa;
   SelCoopP = coopp;
   SelFrDate = frdate;
   SelToDate = todate;
   SelStr = str;
   SelNumWk = numwk;
   SelTotPlnCost = totplncost;
   SelTotActCost = totactcost;
   SelTotFinCost = totfincost;
   SelMedia = getMediaArg(media);
   dspPromoEntry("CHG");

}


//------------------------------------------------------------------------------
// display Argument of Media from Media Array
//------------------------------------------------------------------------------
function getMediaArg(medCode)
{
   var i=0;
   for(; i<Media.length;i++)
   {
      if(Media[i]==medCode)
      {
        break;
      }
   }
   return i;
}



//------------------------------------------------------------------------------
// Hilight menu options, when mouse moves over it.
//------------------------------------------------------------------------------
function hilightOption(obj, over)
{
  if(over)
  {
    obj.style.color = "darkred";
    obj.style.textDecoration="underline"
    obj.style.backgroundColor = "white";
  }
  else
  {
    obj.style.color = "black";
    obj.style.textDecoration="none"
    obj.style.backgroundColor = "#EEEEEE";
  }
}


//========================================================================
// display Promotion entry
//========================================================================
function dspPromoEntry(action)
{
  var MenuName = "";
  var MenuOpt = "";
  var week = null;

  week = SelOrgWk;
  hideMenu();

  var  mkt = "";
  if(SelLevel != "ALL") mkt = MktName[SelMkt];
  else mkt = "ALL";

  MenuName = "<td colspan='4'  class='BoxName' nowrap>" + mkt + "&nbsp;&nbsp;&nbsp;" + week + "&nbsp;&nbsp;&nbsp;"
        + "Media: " + MedName[SelMedia] + "&nbsp;&nbsp;&nbsp;" + SelAdTypeDes + ": " + SelAdName + "</td>";


  // add Detail entry headings
  MenuOpt += "<tr>"
  if (SelMonWk)  MenuOpt += " <td class='Promo1' align='center' >No of"
           + "<input type='radio' name='MonWk' checked value='M' readonly>Month / "
           + "<input type='radio' name='MonWk' value='W' readonly>Week</td>"

  else MenuOpt += " <td class='Promo1' align='center' >No of Weeks</td>"
  MenuOpt += " <td class='Promo1' align='center' >Payee</td>"
         + "<td class='Promo1' align='center' >Day of Week</td>"
         + "<td class='Promo1' align='center' >Ad Size / Cost</td>"
         + " <td class='Promo1' align='center' >Comment</td>"
       + "</tr>";

  // add Detail entry fields
  MenuOpt += "<tr>"
         + "<td class='Promo1' align='center' >"

  MenuOpt += "<input name='NumWk' class='Small' size=2 maxlength=2 value='1' readonly>"
              + "<input name='FrDate' type='hidden'>"
  MenuOpt += "<input name='FrDate' class='Small' size=10 maxlength=10 readonly>"
         + "<a href='javascript:showCalendar(1, "
         + scMonth + ", " + scYear + ", 300, 450, document.all.FrDate)' >"
         + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a>"
         + "<input name='NumWk' type='hidden' value='1' readonly>"

  MenuOpt += "</td>"

         + "<td class='Promo1' align='center' ><input name='Payee' class='Small' size=30 maxlength=30 readonly><br>"
         + "<select name='PayeeList' class='Small' onClick='getSelMedia(this)' disabled  readonly><option>Media List Loading Now</option></select></td>"
         + "<td class='Promo1' align='center' >"
            + "<input name='WkDay' type='radio' onClick='getSelWDayRate(0)' value='1' readonly>Mo &nbsp;"
            + "<input name='WkDay' type='radio' onClick='getSelWDayRate(1)' value='2' readonly>Tu &nbsp;"
            + "<input name='WkDay' type='radio' onClick='getSelWDayRate(2)' value='3' readonly>We &nbsp;"
            + "<input name='WkDay' type='radio' onClick='getSelWDayRate(3)' value='4' readonly>Th &nbsp;"
            + "<input name='WkDay' type='radio' onClick='getSelWDayRate(4)' value='5' readonly>Fr &nbsp;<br>"
            + "<input name='WkDay' type='radio' onClick='getSelWDayRate(5)' value='6' readonly>Sa &nbsp;"
            + "<input name='WkDay' type='radio' onClick='getSelWDayRate(6)' value='0' readonly>Su &nbsp;"
            + "<input name='WkDay' type='radio' onClick='getSelWDayRate(null)' value=' ' checked readonly>None &nbsp;"
         + "<input name='ToDate' type='hidden'>"
         + "</td>"
         + "<td class='Promo2' align='center' rowspan='4'>"
         + "&nbsp;&nbsp;&nbsp; # &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Inches<br>"
         + "Columns &nbsp;&nbsp; Height &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Rate<br>"
         + "<input name='AdCols' class='Small' size=3 maxlength=5 readonly> x <input name='AdRows' class='Small' size=3 maxlength=5 readonly>&nbsp;"
         + "x <input name='AdRate' class='Small' size=6 maxlength=6 readonly><br>"
         + "Other (eg., Full page)<br>"
         + "<input name='AdSize' class='Small' size=30 maxlength=30 readonly><br>"
         + "Discount %: <input name='AdDiscP' class='Small' size=6 maxlength=10 readonly><br>"
         + "Discount $: &nbsp;<input name='AdDiscA' class='Small' size=6 maxlength=10 readonly>&nbsp;&nbsp;"
         + "<button class='small' onclick='calcCost()'>Calc.</button>"
         + "</td>"
         + " <td class='Promo1'><input name='Comment' class='Small' size=30 maxlength=50></td>"
         + "</tr>";

  // add Detail entry headings
  MenuOpt += "<tr>"
         + " <td class='Promo1' align='center' >Type of<br>Charge</td>"
         + " <td class='Promo1' align='center' >Planned<br>Cost</td>"
         + " <td class='Promo1' align='center' >Actual/<br>Approved Cost</td>"
         + " <td class='Promo1' align='center' ><br>Section</td>"
       + "</tr>";

  // add Detail entry fields
  MenuOpt += "<tr>"
         + "<td class='Promo1'><input name='Spot' class='Small' size=30 maxlength=30 readonly><input name='SpotValue' type='hidden'><br>"
         + "<select name='SpotList' class='Small' onClick='getSelSpot(this)'></select></td>"
         + "<td class='Promo1'><input name='PlnCost' class='Small' size=9 maxlength=9></td>"
         + "<td class='Promo1'><input name='ActCost' class='Small' size=9 maxlength=9></td>"
         + "<td class='Promo1'><input name='Section' class='Small' size=30 maxlength=30>"
       + "</tr>";


  // add 3 Detail line headings
  MenuOpt += "<tr>"
         + " <td class='Promo1' align='center'"
  if (SelLevel != "ALL")  MenuOpt += "colspan='3'><br>Charged Stores"
  else MenuOpt += "colspan='3'><br>Charged Markets"
  MenuOpt += "</td>"
           + "<td class='Promo2' rowspan=2><div id='dvZone' style='visibility: hidden;'>"
             + "<input name='Zone' type='radio' class='Small' value='0'>Full&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
             + "<input name='Zone' type='radio' class='Small' value='1'>Zone<br>"
             + "<input name='Zone' type='radio' class='Small' value='2'>Zone/Combo&nbsp;&nbsp;"
             + "<input name='Zone' type='radio' class='Small' value='3'>Zone/Full&nbsp;&nbsp;"
      + "</div></td>"
           + "</td>"
         + "</tr>";

  // add section
  MenuOpt += "<tr>"

  // add market's store list
  if (SelLevel != "ALL")
  {
    MenuOpt += "<td class='Promo1' colspan='3'>"
    for(var i=0; i < Store[SelMkt].length; i++)
    {
       MenuOpt += "<input name='Store' type='checkbox' class='Small'  readonly value='" + Store[SelMkt][i] + "' checked >"
       + Store[SelMkt][i]
    }
  }
  else
  {
    MenuOpt += "<td class='Promo1' colspan='3'>"
    for(var i=0; i < Market.length; i++)
    {
       MenuOpt += "<input name='Store' type='checkbox' class='Small' readonly value='" + Market[i] + "' checked >"
       + MktName[i] + "&nbsp;&nbsp;"
    }
    MenuOpt += "<button class='small' onclick='unCheckMarkets();'>Deselect</button>&nbsp;&nbsp;&nbsp;"
  }
  MenuOpt += "</td>"
      + "<td class='Promo1'><span id='spCoop1'><a href='javascript: dspCoop()'>Coop ?</a></span>"
      + "<span id='spCoop2' style='display:none'>Coop Amount: <input name='CoopA' class='Small' size=10 maxlength=10><br>"
      + "Coop Percent: <input name='CoopP' class='Small' size=10 maxlength=6></span></td>"
      + "</tr>"

  // add close option on menu
  MenuOpt += "<tr><td colspan='5' class='Promo' align='center'>"
       + "<button class='small' onclick='hidePromoEntry();'>Close</button>&nbsp;&nbsp;&nbsp;"
       + "</td></tr>";

  var MenuHtml = "<table width='100%' cellPadding='0' cellSpacing='0'>"
  + "<tr>"
     + MenuName
     + "<td class='BoxClose' valign=top>"
     +  "<img src='CloseButton.bmp' onclick='javascript:hidePromoEntry();' alt='Close'>"
     + "</td>"
   + "</tr>"
   + MenuOpt
   + "</table>"

  document.all.promo.innerHTML=MenuHtml
  document.all.promo.style.pixelLeft= (document.documentElement.scrollLeft + screen.width - 900) / 2
  document.all.promo.style.pixelTop=document.documentElement.scrollTop + screen.height - 550;
  document.all.promo.style.visibility="visible"

  if (SelLevel != "ALL" && Store[SelMkt].length == 1) document.all.Store.disabled=true;
  if(action=="CHG") popAdvFld(action);
  if(action=="ADDTRL") popAdvFld(action);
  if(action!="DLT") popSpotList();
  if(action=="ADD") document.all.Spot.value = document.all.SpotList.options[0].text;
  setMediaPrompt();
  allowFieldEntry();

}
//========================================================================
// populate Promo entry menu fields for changing existing events
//========================================================================
function popAdvFld(action)
{
   document.all.NumWk.value = SelNumWk;
   document.all.Payee.value = SelPayee;
   document.all.Comment.value = SelComment;
   popColRow();
   document.all.AdRate.value = SelRate;
   // set week day
   if (SelWDay != null)
   {
     var weekDay  = document.all.WkDay;
     for(var i=0; i < weekDay.length; i++)
     {
        if (weekDay[i].value == SelWDay) weekDay[i].checked = true;
        else weekDay[i].checked = false;
     }
   }
   document.all.Section.value = SelSect;
   document.all.Spot.value = SelSpot;
   document.all.CoopA.value = SelCoopA;
   document.all.CoopP.value = SelCoopP;
   document.all.FrDate.value = SelFrDate;
   document.all.ToDate.value = SelToDate;
   document.all.PlnCost.value=SelTotPlnCost;
   document.all.ActCost.value=SelTotActCost;

   if (Store[SelMkt].length > 1)
   {
      for(var i=0; i < Store[SelMkt].length; i++)
      {
        document.all.Store[i].checked=false;
        for(var j=0; j < SelStr.length; j++)
        {
           if(SelStr[j]==Store[SelMkt][i])
           {
             document.all.Store[i].checked=true;
             break;
           }
        }
      }
   }

   if(SelComboType.trim()!="")
   {
      document.all.PayeeList.style.visibility="hidden"
      document.all.Combo.checked=true;
      document.all.Combo.readOnly=true;
   }

   if(SelZone.trim()=="") document.all.Zone[0].checked = true;
   else document.all.Zone[SelZone].checked = true;
   if(SelPayee.trim() !="Atlanta Journal Constitution")  document.all.dvZone.style.visibility="hidden"
   else document.all.dvZone.style.visibility="visible"
}
//========================================================================
// populate columns & rows
//========================================================================
function popColRow()
{
   var act = null;
   var cols = 0;
   var rows = 0;

   for(var i=0; i < SelSize.length; i++)
   {
     if(SelSize.substring(i, i+1)=="x") act = i;
   }

   if (i > 0)
   {
     cols = SelSize.substring(0, act);
     rows = SelSize.substring(act + 1).trim();
   }

   if (!isNaN(cols)) document.all.AdCols.value = cols;
   else document.all.AdSize.value = SelSize;
   if (!isNaN(rows)) document.all.AdRows.value = rows;
   else document.all.AdSize.value = SelSize;
}
//========================================================================
// display Coop
//========================================================================
function dspCoop()
{
   document.all.spCoop1.style.display="none"
   document.all.spCoop2.style.display="block"
}
//========================================================================
// populate Spot List
//========================================================================
function popSpotList()
{
   if(Media[SelMedia] == "RA")
   {
      document.all.SpotList[0] = new Option("Radio Spot", "SPOT");
      document.all.SpotList[1] = new Option("Talent Fees", "TALENT");
      document.all.SpotList[2] = new Option("Production Costs", "PRODUCTION");
      document.all.SpotList[3] = new Option("Remote Fees", "REMOTE");
      document.all.SpotList[4] = new Option("Other", "OTHER");
   }
   else if(Media[SelMedia] == "TV")
   {
      document.all.SpotList[0] = new Option("TV Spot", "SPOT");
      document.all.SpotList[1] = new Option("Talent Fees", "TALENT");
      document.all.SpotList[2] = new Option("Production Costs", "PRODUCTION");
      document.all.SpotList[3] = new Option("Remote Fees", "REMOTE");
      document.all.SpotList[4] = new Option("Other", "OTHER");
   }
   else
   {
      document.all.SpotList[0] = new Option(MedName[SelMedia] + " ADS", "AD");
      document.all.SpotList[1] = new Option("Other", "OTHER");
   }
}
//-------------------------------------------------------------
// get Selected spot from list and populate input field
//-------------------------------------------------------------
function getSelSpot(spot)
{
   document.all.Spot.value = spot.options[spot.selectedIndex].text
   document.all.SpotValue.value = spot.options[spot.selectedIndex].value
}
//========================================================================
// allow field entries
//========================================================================
function allowFieldEntry()
{
  if(Media[SelMedia] != "NP")
  {
     document.all.AdSize.disabled=true;
     document.all.AdSize.style.backgroundColor="lightgrey";
     document.all.AdCols.disabled=true;
     document.all.AdCols.style.backgroundColor="lightgrey";
     document.all.AdRows.disabled=true;
     document.all.AdRows.style.backgroundColor="lightgrey";
     document.all.AdRate.disabled=true;
     document.all.AdRate.style.backgroundColor="lightgrey";
     document.all.AdDiscA.disabled=true;
     document.all.AdDiscA.style.backgroundColor="lightgrey";
     document.all.AdDiscP.disabled=true;
     document.all.AdDiscP.style.backgroundColor="lightgrey";
  }
}

//========================================================================
// calculate Cost od newspaper ad
//========================================================================
function calcCost()
{
  var cols =  eval(document.all.AdCols.value)
  var rows =  eval(document.all.AdRows.value)
  var rate =  eval(document.all.AdRate.value)
  var disc = null;
  var cost = null;

  if(document.all.AdDiscP.value.trim() != "")
  {
    disc = 1 - eval(document.all.AdDiscP.value.trim()) / 100;
    cost = Math.round( (cols * rows * rate * disc) * 100 ) / 100 ;
  }
  else if(document.all.AdDiscA.value.trim() != "")
  {
     disc = eval(document.all.AdDiscA.value.trim());
     cost = Math.round( (cols * rows * rate - disc) * 100 ) / 100 ;
  }
  // discount default to 1
  else
  {
     cost = Math.round( (cols * rows * rate) * 100 ) / 100 ;
  }


  if(cost != null && !isNaN(cost)) { document.all.PlnCost.value = cost; }
  if(document.all.AdSize.value.trim()=="") document.all.AdSize.value = cols + " x " + rows;
}
//========================================================================
// uncheck markets ckeckbox
//========================================================================
function unCheckMarkets()
{
   for(var i=0; i < Market.length; i++)
   {
      document.all.Store[i].checked = false;
   }
}
//========================================================================
// retreive week day
//========================================================================
function rtvWeekDay()
{
   var weekDay  = document.all.WkDay;
   if (weekDay == null) return " ";
   for(var i=0; i < weekDay.length; i++)
   {
      if (weekDay[i].checked == true) return weekDay[i].value
   }
   return " ";
}

//========================================================================
// retreive zone
//========================================================================
function rtvZone()
{
   var zone  = document.all.Zone;
   if (zone == null) return " ";
   for(var i=0; i < zone.length; i++)
   {
      if (zone[i].checked == true) return zone[i].value
   }
   return " ";
}
//========================================================================
// close dropdown menu
//========================================================================
function hideMenu(){  document.all.menu.style.visibility="hidden"}
//========================================================================
// close dropdown menu
//========================================================================
function hidePromoEntry()
{
  document.all.promo.innerHTML="";
  document.all.promo.style.visibility="hidden";
  SelLevel = null;
  SelMonWk = false;
}
//========================================================================
// Fold/Unfold Market Group line
//========================================================================
function dspMktLine(mkt)
{
  var line = 0;
  var row = "m" + mkt + "g" + (line++);

  while(document.all[row] != null)
  {
    if ( document.all[row].style.display=="none") { document.all[row].style.display="block"; }
    else {document.all[row].style.display="none";}
    // try next object
    row = "m" + mkt + "g" + (line++);
  }

}

//========================================================================
// Fold/Unfold Market detail (all) lines
//========================================================================
function dspMktDtl()
{
  for(var i = 0; i < Market.length; i++)
  {
    var g = 0;
    var row = "m" + i + "g" + (g++);
    while(document.all[row] != null)
    {
      if (!DtlMktLvl) { document.all[row].style.display="block"; }
      else {document.all[row].style.display="none";}
      // try next object
      row = "m" + i + "g" + (g++);
    }
  }
  DtlMktLvl = !DtlMktLvl;
}
//========================================================================
// Fold/Unfold All Group detail (all) lines
//========================================================================
function dspGrpDtl()
{
  for(var i = 0; i < Market.length; i++)
  {
    var g = 0;
    var grp = "m" + i + "g" + g;
    while(document.all[grp] != null)
    {
      var l = 0;
      var line = "m" + i + "g" + g + "l" + l;

      while(document.all[line] != null)
      {
        if (!DtlGrpLvl) { document.all[line].style.display="block"; }
        else { document.all[line].style.display="none"; }

        l++;
        var line = "m" + i + "g" + g + "l" + l;
      }

      g++;
      grp = "m" + i + "g" + (g);
    }
  }

  var pgnum = 1;
  if (!DtlGrpLvl)
  {
    while(document.all["PB" + pgnum] != null)
    {
       document.all["PB" + pgnum].style.pageBreakBefore="always";
       document.styleSheets[0].rules[5].style.display="block"
       pgnum++;
    }
  }
  else
  {
    while(document.all["PB" + pgnum] != null)
    {
       document.all["PB" + pgnum].style.pageBreakBefore="auto";
       document.styleSheets[0].rules[5].style.display="none"
       pgnum++;
    }
  }
  DtlGrpLvl = !DtlGrpLvl;
}
//========================================================================
// Fold/Unfold Group Detail line
//========================================================================
function dspDtlLine(mkt)
{
  var g = 0;
  var grp = "m" + mkt + "g" + (g);

  while(document.all[grp] != null)
  {
    var l = 0;
    var dtl = "m" + mkt + "g" + (g) + "l" + (l);
    while(document.all[dtl] != null)
    {
      if ( document.all[dtl].style.display=="block") { document.all[dtl].style.display="none"; }
      else {document.all[dtl].style.display="block";}
      // try next object
      l++;
      dtl = "m" + mkt + "g" + (g) + "l" + (l);
    }
    g++;
    grp = "m" + mkt + "g" + (g);
  }

}
//---------------------------------------------------------
// Go to Selected Month
//---------------------------------------------------------
function gotoSelMonth()
{
   var sel = document.all.FiscMon.selectedIndex;
   var uri = "AdCalTyVsLy.jsp?MonBeg=" + document.all.FiscMon.options[sel].value
           + "&MonName=" + document.all.FiscMon.options[sel].text
   //alert(uri)
   window.location.href = uri;
}

//-------------------------------------------------------------
// Prompt for Media populate media list
//-------------------------------------------------------------
function setMediaPrompt()
{
  var url = 'AdGetMktMedList.jsp?'
    + "Market=" + Market[SelMkt]
    + "&Media=" + Media[SelMedia]

 //alert(url);
 //window.location.href = url;
 window.frame1.location = url;
}
//-------------------------------------------------------------
// show Multiple Market entry Totals
//-------------------------------------------------------------
function showMultEnt(mult)
{
  var url = 'AdMultEntry.jsp?' + "Mult=" + mult;
  var WindowName = 'MultipleEntry';
  var WindowOptions =
   'width=500,height=250, left=100,top=50, resizable=yes , toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,menubar=no';

  //alert(url)
  window.open(url, WindowName, WindowOptions);
}
//-------------------------------------------------------------
// Populate Media Prompt
//-------------------------------------------------------------
function popMediaPrompt(medList, rateType, rate)
{
   var payee = document.all.PayeeList;
   if(medList.length > 0 )
   {
      for(var i=0; i < payee.length; i++ )
      {
        payee.options[i] = null;
      }
      for(var i=0; i < medList.length; i++ )
      {
         payee.options[i] = new Option(medList[i], medList[i]);
      }
      payee.disabled=false;

      RateType = rateType;
      Rate = rate;
   }
   else
   {
      payee.options[0] = new Option("-- No media found --", "NONE");
   }
}
//-------------------------------------------------------------
// get Selected Media and populate Payy field
//-------------------------------------------------------------
function getSelMedia(med)
{
   document.all.Payee.value = med.options[med.selectedIndex].value;
   if(!document.all.AdRate.disabled)
   {
     for(var i=0; i < document.all.WkDay.length; i++)
     {
        if(document.all.WkDay[i].checked)
        {
           if  (Rate[med.selectedIndex] == null
             || Rate[med.selectedIndex][0] == null)  document.all.AdRate.value = 0;
           else if(i >= 0 && i <= 3) document.all.AdRate.value = Rate[med.selectedIndex][0];
           else if(i == 4) document.all.AdRate.value = Rate[med.selectedIndex][1];
           else if(i == 5) document.all.AdRate.value = Rate[med.selectedIndex][2];
           else if(i == 6) document.all.AdRate.value = Rate[med.selectedIndex][3];
           else document.all.AdRate.value = 0;
           break;
        }
     }
   }
  if(document.all.Payee.value.trim() !="Atlanta Journal Constitution") document.all.dvZone.style.visibility="hidden"
  else document.all.dvZone.style.visibility="visible"
}
//-------------------------------------------------------------
// get Selected Media and populate Payy field
//-------------------------------------------------------------
function getSelWDayRate(day)
{
   if(!document.all.AdRate.disabled)
   {
      if  (Rate[document.all.PayeeList.selectedIndex] == null
        || Rate[document.all.PayeeList.selectedIndex][0] == null)  document.all.AdRate.value = 0;
      else if(day == null) document.all.AdRate.value = 0;
      else if(day >= 0 && day <= 3) document.all.AdRate.value = Rate[document.all.PayeeList.selectedIndex][0];
      else if(day == 4) document.all.AdRate.value = Rate[document.all.PayeeList.selectedIndex][1];
      else if(day == 5) document.all.AdRate.value = Rate[document.all.PayeeList.selectedIndex][2];
      else if(day == 6) document.all.AdRate.value = Rate[document.all.PayeeList.selectedIndex][3];
   }
}

//---------------------------------------------------------
// launch calculator
//---------------------------------------------------------
function launchCalc()
{
  var url = "calc.html"
  var WindowName = 'Calculator';
  var WindowOptions =
   'width=150,height=150, left=100,top=50, resizable=yes , toolbar=no, location=no, directories=no, status=yes, scrollbars=no,menubar=no';

  //alert(url)
  window.open(url, WindowName, WindowOptions);
}

//---------------------------------------------------------
// launch fiscal Calendar
//---------------------------------------------------------
function launchFisCal()
{
  var url = "FisCal.jsp"
  var WindowName = 'FiscalCalendar';
  var WindowOptions =
   'width=150,height=150, left=100,top=50, resizable=yes , toolbar=no, location=no, directories=no, status=yes, scrollbars=no,menubar=no';

  //alert(url)
  window.open(url, WindowName, WindowOptions);
}
//---------------------------------------------------------
// show plan amount with percents
//---------------------------------------------------------
function showPlanAmt()
{
   var disp = "none";
   if(PlanAmtVisible)
   {
     disp = "inline";
   }

   for(var i=0; i < document.all.tdPlan.length; i++)
   {
     document.all.tdPlan[i].style.display=disp;
   }
   PlanAmtVisible = !PlanAmtVisible;
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
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

<!-------------------------------------------------------------------->
<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
  <div id="menu" class="Menu"></div>
  <div id="promo" class="Promo"></div>
<!-------------------------------------------------------------------->
  <table border="0" cellPadding="0" cellSpacing="0">
  <tr bgColor="white">
      <!-------------------------------------------------------------------->
      <!-- Calander Views -->
      <!-------------------------------------------------------------------->
       <td ALIGN="left" VALIGN="TOP">
         <div id="dvCalView" class="Month">Calendar View<br>
         <a href='javascript:showCalendar(1, <%=iMonth%>, <%=iYear%>, 50, 155, null)' >Regular</a><br>
         <a href='javascript:launchFisCal()' >Fiscal</a>
         </div></td>
      <!-------------------------------------------------------------------->
      <!-- Month selector -->
      <!-------------------------------------------------------------------->
       <td ALIGN="center" VALIGN="TOP">
         <div id="dvMonth" class="Month">
             Month: <SELECT class="small" name="FiscMon"></SELECT><br>
             <button name="GoMonth" onClick="gotoSelMonth()" >Go</button>
         </div>
       </td>
      <!-------------------------------------------------------------------->
      <!-- Ad Calendar -->
      <!-------------------------------------------------------------------->
       <td ALIGN="right" VALIGN="TOP">
          <div id="dvCalView" class="Month">Ad Calendar<br>
          <a href="<%=sEvtCalLink%>" target="_blank">Promotional Event Calendar</a><br>
         </div></td>
     <!-------------------------------------------------------------------->
     <!-- Headings -->
     <!-------------------------------------------------------------------->
     <tr bgColor="white">

       <!-------------------------------------------------------------------->
       <!-- Calendar View -->
       <!-------------------------------------------------------------------->
       <td ALIGN="center" VALIGN="TOP">&nbsp;</td>
       <!-------------------------------------------------------------------->
       <td ALIGN="center" VALIGN="TOP" >
         <b><font size="+2">Advertising Monthly Events</font>
         <br><a href="AdCalTyVsLy.jsp?MonBeg=<%=sPrvNxtMonth[0]%>&MonName=<%=sPrvNxtMonName[0]%>">
                   <IMG SRC="arrowLeft.gif" style="border=none" ALT="Previous Month"></a>
             &nbsp;&nbsp;&nbsp;
             <font size="+3"><%=sMonName%></font>
             &nbsp;&nbsp;&nbsp;
             <a href="AdCalTyVsLy.jsp?MonBeg=<%=sPrvNxtMonth[1]%>&MonName=<%=sPrvNxtMonName[1]%>">
                   <IMG SRC="arrowRight.gif" style="border=none" ALT="Next Month"></a></b>
       </td>
       <!-------------------------------------------------------------------->
       <!-- Ad Calendar -->
       <!-------------------------------------------------------------------->
       <td ALIGN="center" VALIGN="TOP">&nbsp;</td>
     <!-------------------------------------------------------------------->
     </tr>
     <tr bgColor="white">
       <td ALIGN="center" VALIGN="TOP" colspan="3"><br>
       <a href="../"><font color="red" size="-1">Home</font></a>&#62;
       <a href="AdCalSel.jsp"><font color="red" size="-1">Month Selection</font></a>&#62;<font size="-1">This Page</font>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
       <a href="AdPromoEntry.jsp" target="_blank"><font color="blue" size="-1">W/w Promotions</font></a>;
       <a href="AdMediaList.jsp" target="_blank"><font color="blue" size="-1">W/w Medias</font></a>;
       <a href="javascript: launchCalc();"><font color="blue" size="-1">Calculator</font></a>;
       <a href="AdPrintByGroup.jsp?Group=NP&MonBeg=<%=sMonBeg%>&MonName=<%=sMonName%>&NumOfWk=<%=iNumOfWk%><%=sbWeeks.toString()%>"
          target="_blank"><font color="blue" size="-1">Print Newspaper</font></a>;
       <a href="javascript: showPlanAmt();"><font color="blue" size="-1">Sales by Mkt</font></a>;
    <!-------------------------------------------------------------------->
    <!--                     start of ad table  -->
    <!-------------------------------------------------------------------->
    <table class="DataTable" cellPadding="0" cellSpacing="0">
         <thead>
           <tr>
              <th class="DataTable" rowspan="3" colspan="2" nowrap>Market/Media<br>
                 <a href="javascript:dspMktDtl()">Fold/Unfold Group</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 <a href="javascript:dspGrpDtl()">Fold/Unfold Details</a>
              </th>
              <th class="DataTable1" rowspan="5">C<br>a<br>l</th>
              <th class="DataTable1" rowspan="5">M<br>u<br>l<br>t</th>
              <%for(int i=0; i < iNumOfWk/2; i++){%>
                 <th class="DataTable" colspan="5">Week <%=i+1%></th>
                 <th class="DataTable1">&nbsp;</th>
              <%}%>
              <th class="DataTable" rowspan="4"  colspan="4">Advertising<br>Total</th>
              <th class="DataTable" rowspan="4"  colspan="4">Monthly<br>Sales/Plan</th>
           </tr>
           <tr>
              <%for(int i=0; i < iNumOfWk/2; i++){%>
                <th class="DataTable" colspan=2>TY</th>
                <th class="DataTable1" >&nbsp;</th>
                <th class="DataTable" colspan=2>LY</th>
                <th class="DataTable1" >&nbsp;</th>
              <%}%>
           </tr>
           <tr>
              <%for(int i=0; i < iNumOfWk; i++){%>
                <th class="DataTable" colspan="2"><%=sWkend[i]%></th>
                <th class="DataTable1" >&nbsp;</th>
              <%}%>
           </tr>
           <tr>
             <th class="DataTable2" rowspan="2" colspan="2">Plan/Actual Sales <IMG SRC="ArrowRight01.gif" style="border=none"></th>
              <%for(int i=0; i < iNumOfWk; i++){%>
                <th class="DataTable" colspan="2">$<%=sWkPlan[i]%></th>
                <th class="DataTable1" >&nbsp;</th>
              <%}%>
           </tr>
           <tr>
              <%for(int i=0; i < iNumOfWk; i++){%>
                <th class="DataTable" >Adv</th>
                <th class="DataTable" >
                  <table width="100%"><tr class="split1">
                    <th id="tdPlan" style="text-align:left;">Sales</th>
                    <th style="text-align:right">%</th></tr>
                  </table>
                  <th class="DataTable1" >&nbsp;</th>
                </th>
              <%}%>

              <th class="DataTable" colspan=2>TY</th>
              <th class="DataTable" colspan=2>LY</th>
              <th class="DataTable">TY</th>
              <th class="DataTable">LY</th>
           </tr>
         </thead>
           <% int iLine = 0, iPage=26, iPgNum = 1; %>
          <!-- ------------------------------------------------------------- -->
          <!-- Market Totals -->
          <!-- ------------------------------------------------------------- -->
           <%for(int i=0; i < iNumOfMkt; i++){
              adCal.setMarketGroups(i);
              int iNumOfGrp = adCal.getNumOfGrp();
              String [] sMGGrp = adCal.getMGGrp();
              String [] sMGGrpName = adCal.getMGGrpName();
              String [][] sMGPlnCost = adCal.getMGPlnCost();
              String [][] sMGActCost = adCal.getMGActCost();
              String [][] sMGFinCost = adCal.getMGFinCost();
              String [][] sMGPlanPrc = adCal.getMGPlanPrc();
              String [][] sMGPlan = adCal.getMGPlan();

              String [][] sMGTotPlnCost = adCal.getMGTotPlnCost();
              String [][] sMGTotActCost = adCal.getMGTotActCost();
              String [][] sMGTotFinCost = adCal.getMGTotFinCost();
              String [][] sMGTotPlanPrc = adCal.getMGTotPlanPrc();
              String [][] sMGTotPlan = adCal.getMGTotPlan();
              int [] iMGOrgArg = adCal.getMGOrgArg();
          %>
          <!-- ------------------------------------------------------------- -->
              <%if(iLine > iPage) {%>
                 <tr id="PB<%=iPgNum%>" class="PageBreak"><td><% iLine = 0; %></td></tr>
                 <tr id="PBA<%=iPgNum%>" class="PageBreak1">
                    <th class="DataTable" colspan="21"><font size="+2">Advertising Monthly Events</font><br>
                        <font size="+3"><%=sMonName%></font></th></tr>
                 <tr id="PBA<%=iPgNum%>" class="PageBreak1">
                    <th class="DataTable" rowspan="2" colspan="2">Market/Media</th>
                    <th class="DataTable1" rowspan="3">&nbsp;</th>
                    <%for(int x=0; x < (iNumOfWk / 2); x++){%>
                       <th class="DataTable" colspan="4">Week <%=x+1%></th>
                       <th class="DataTable1">&nbsp;</th>
                    <%}%>
                    <th class="DataTable" rowspan="3"  colspan="2">Advertising<br>Total</th>
                    <th class="DataTable" rowspan="3"  colspan="2">Sales/Plan</th>
                 </tr>
                 <tr id="PBB<%=iPgNum%>" class="PageBreak1">
                   <%for(int x=0; x < iNumOfWk; x++){%>
                     <th class="DataTable" colspan="2"><%=sWkend[x]%></th>
                     <th class="DataTable1" >&nbsp;</th>
                   <%}%>
                 </tr>
                 <tr id="PBC<%=iPgNum%>" class="PageBreak1">
                   <th class="DataTable2" colspan="2">Plan/Actual Sales <IMG SRC="ArrowRight01.gif" style="border=none"></th>
                     <%for(int x=0; x < iNumOfWk; x++){%>
                        <th class="DataTable" colspan="2">$<%=sWkPlan[x]%></th>
                        <th class="DataTable1" >&nbsp;</th>
                   <%}%>
                 </tr>

              <% iPage=31; iPgNum++;
                }%>
              <% iLine++; %>
              <!-- ------------------------------------------------------------- -->
              <tr>
                <td class="DataTable"><%=sMktName[i]%></td>
                <td class="DataTable5" nowrap><%if(iNumOfGrp > 0) {%><a href="javascript:dspMktLine(<%=i%>)">F/U Grp</a>
                         <a href="javascript:dspDtlLine(<%=i%>)">F/Un Dtl</a>
                    <%} else {%>&nbsp;<%}%></td>
                <th class="DataTable1"><a href="AdFisCal.jsp?MonBeg=<%=sMonBeg%>&MonName=<%=sMonName%>&Market=<%=sMkt[i]%>&MktName=<%=sMktName[i]%>" target="_blank">C</a></th>
                <th class="DataTable1">&nbsp;</th>
                <%for(int j=0; j < iNumOfWk; j++){%>
                   <td class="DataTable4" >
                       <%if(!sMTPlnCost[i][j].equals("0")){%>$<%=sMTPlnCost[i][j]%><%} else {%>&nbsp;<%}%>
                   </td>
                   <td class="DataTable4" >
                       <table width="100%"><tr class="split">
                                <td id="tdPlan" style="text-align:left"><%if(!sMTPlanPrc[i][j].equals(".0")){%>$<%=sMTPlan[i][j]%><%}%></td>
                                <td style="text-align:right"><%if(!sMTPlanPrc[i][j].equals(".0")){%><%=sMTPlanPrc[i][j]%>%<%} else {%>&nbsp;<%}%></td></tr>
                       </table>
                   </td>
                   <th class="DataTable1">&nbsp;</th>
                <%}%>

                <td class="DataTable4" >
                       <%if(!sMTPlnCost[i][12].equals("0")){%>$<%=sMTPlnCost[i][12]%><%} else {%>&nbsp;<%}%>
                <td class="DataTable4" >
                       <%if(!sMTPlanPrc[i][12].equals(".0")){%><%=sMTPlanPrc[i][12]%>%<%} else {%>&nbsp;<%}%>

                <td class="DataTable4" >
                       <%if(!sMTPlnCost[i][13].equals("0")){%>$<%=sMTPlnCost[i][13]%><%} else {%>&nbsp;<%}%>
                <td class="DataTable4" >
                       <%if(!sMTPlanPrc[i][13].equals(".0")){%><%=sMTPlanPrc[i][13]%>%<%} else {%>&nbsp;<%}%>

                <td class="DataTable4" >
                       <%if(!sMTPlan[i][12].equals("0")){%>$<%=sMTPlan[i][12]%><%} else {%>&nbsp;<%}%>
                <td class="DataTable4" >
                       <%if(!sMTPlan[i][13].equals("0")){%>$<%=sMTPlan[i][13]%><%} else {%>&nbsp;<%}%>
              </tr>
              <!-- --------------------------------------------------------- -->
              <!-- ---------------- Market Group -------------------------- -->
              <!-- --------------------------------------------------------- -->
              <%for(int j=0; j < iNumOfGrp; j++){

                  // get details for Market/Group
                  adCal.setMarketDetails(i, iMGOrgArg [j]);
                  int iNumOfLine = adCal.getNumOfMDMed();
                  String [] sMDMedia = adCal.getMDMedia();
                  String [] sMDMedName = adCal.getMDMedName();
                  String [] sMDPType = adCal.getMDPType();
                  String [] sMDPTypeDesc = adCal.getMDPTypeDesc();
                  String [] sMDPDesc = adCal.getMDPDesc();
                  String [] sMDOrgWk = adCal.getMDOrgWk();
                  String [] sMDSeq = adCal.getMDSeq();
                  String [] sMDPayee = adCal.getMDPayee();
                  String [] sMDSize = adCal.getMDSize();
                  String [] sMDWDay = adCal.getMDWDay();
                  String [] sMDRate = adCal.getMDRate();
                  String [] sMDSect = adCal.getMDSect();
                  String [] sMDZone = adCal.getMDZone();
                  String [] sMDTY = adCal.getMDTY();
                  String [] sMDSpot = adCal.getMDSpot();
                  String [] sMDCoopA = adCal.getMDCoopA();
                  String [] sMDCoopP = adCal.getMDCoopP();
                  String [] sMDMult = adCal.getMDMult();
                  String [] sMDCombo = adCal.getMDCombo();
                  String [] sMDComboType = adCal.getMDComboType();
                  String [] sMDComt = adCal.getMDComt();
                  String [] sMDFrDate = adCal.getMDFrDate();
                  String [] sMDToDate = adCal.getMDToDate();
                  String [] sMDStr = adCal.getMDStr();
                  String [] sMDTotPlnCost = adCal.getMDTotPlnCost();
                  String [] sMDTotActCost = adCal.getMDTotActCost();
                  String [] sMDTotFinCost = adCal.getMDTotFinCost();
                  String [] sMDNumWk = adCal.getMDNumWk();
                  String [][] sMDPlnCost = adCal.getMDPlnCost();
                  String [][] sMDActCost = adCal.getMDActCost();
                  String [][] sMDFinCost = adCal.getMDFinCost();
                  String [][] sMDPlanPrc = adCal.getMDPlanPrc();

                  //  line total
                  String [][] sLTPlnCost = adCal.getLTPlnCost();
                  String [][] sLTActCost = adCal.getLTActCost();
                  String [][] sLTFinCost = adCal.getLTFinCost();
                  String [][] sLTPlanPrc = adCal.getLTPlanPrc();

                  // convert numeric week day to literal
                  String [] sWkDay = new String[sMDWDay.length];
                  String [] swda = new String[]{"Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"};
                  for(int x=0; x < sMDWDay.length; x++)
                  {
                     if(!sMDWDay[x].trim().equals("")) sWkDay[x] = swda[Integer.parseInt(sMDWDay[x].trim())];
                     else sWkDay[x] = "None";
                  }
              %>
          <!-- ------------------------------------------------------------- -->
              <%if(iLine > iPage) {%>
                 <tr id="PB<%=iPgNum%>" class="PageBreak"><td><% iLine = 0; %></td></tr>
                 <tr id="PBA<%=iPgNum%>" class="PageBreak1">
                    <th class="DataTable" colspan="21"><font size="+2">Advertising Monthly Events</font><br>
                        <font size="+3"><%=sMonName%></font></th></tr>
                 <tr id="PBA<%=iPgNum%>" class="PageBreak1">
                    <th class="DataTable" rowspan="2" colspan="2">Market/Media</th>
                    <th class="DataTable1" rowspan="3">&nbsp;</th>
                    <%for(int x=0; x < iNumOfWk; x++){%>
                       <th class="DataTable" colspan="2">Week <%=x+1%></th>
                       <th class="DataTable1">&nbsp;</th>
                    <%}%>
                    <th class="DataTable" rowspan="3"  colspan="2">Advertising<br>Total</th>
                    <th class="DataTable" rowspan="3"  colspan="2">Sales/Plan</th>
                 </tr>
                 <tr id="PBB<%=iPgNum%>" class="PageBreak1">
                   <%for(int x=0; x < iNumOfWk; x++){%>
                     <th class="DataTable" colspan="2"><%=sWkend[x]%></th>
                     <th class="DataTable1" >&nbsp;</th>
                   <%}%>
                 </tr>
                 <tr id="PBC<%=iPgNum%>" class="PageBreak1">
                   <th class="DataTable2" colspan="2">Plan/Actual Sales <IMG SRC="ArrowRight01.gif" style="border=none"></th>
                     <%for(int x=0; x < iNumOfWk; x++){%>
                        <th class="DataTable" colspan="2">$<%=sWkPlan[x]%></th>
                        <th class="DataTable1" >&nbsp;</th>
                   <%}%>
                 </tr>
              <% iPgNum++; iPage=31;
                }%>
              <% iLine++; %>
              <!-- ------------------------------------------------------------- -->
                <tr id="m<%=i%>g<%=j%>" >
                   <td class="DataTable2" colspan="2"><%=sMGGrpName[j]%></td>
                   <th class="DataTable1">&nbsp;</th>
                   <th class="DataTable1">&nbsp;</th>
                   <%for(int k=0; k < iNumOfWk; k++){%>
                      <td class="DataTable2a">
                         <%if(!sMGPlnCost[j][k].equals("0")){%>$<%=sMGPlnCost[j][k]%><%} else {%>&nbsp;<%}%>
                      </td>
                      <td class="DataTable2a">
                         <%if(!sMGPlanPrc[j][k].equals(".0")){%><%=sMGPlanPrc[j][k]%>%<%} else {%>&nbsp;<%}%>
                      </td>
                      <th class="DataTable1">&nbsp;</th>
                   <%}%>
                   <td class="DataTable2a" >
                       <%if(!sMGTotPlnCost[j][0].equals("0")){%>$<%=sMGTotPlnCost[j][0]%><%} else {%>&nbsp;<%}%>
                   <td class="DataTable2a" nowrap>
                       <%if(!sMGTotPlanPrc[j][0].equals(".0")){%><%=sMGTotPlanPrc[j][0]%>%<%} else {%>&nbsp;<%}%>
                   <!-- Last Year Media total -->
                   <td class="DataTable2a" >
                       <%if(!sMGTotPlnCost[j][1].equals("0")){%>$<%=sMGTotPlnCost[j][1]%><%} else {%>&nbsp;<%}%>
                   <td class="DataTable2a" nowrap>
                       <%if(!sMGTotPlanPrc[j][1].equals(".0")){%><%=sMGTotPlanPrc[j][1]%>%<%} else {%>&nbsp;<%}%>
                   <td class="DataTable2a" colspan=2>&nbsp</td>
                </tr>

                <!-- --------------------------------------------------------- -->
                <!-- ---------------- Market Details -------------------------- -->
                <!-- --------------------------------------------------------- -->
                <%for(int k=0; k < iNumOfLine; k++){%>
          <!-- ------------------------------------------------------------- -->
              <%if(iLine > iPage) {%>
                 <tr id="PB<%=iPgNum%>" class="PageBreak"><td><% iLine = 0; %></td></tr>
                 <tr id="PBA<%=iPgNum%>" class="PageBreak1">
                    <th class="DataTable" colspan="21"><font size="+2">Advertising Monthly Events</font><br>
                        <font size="+3"><%=sMonName%></font></th></tr>
                 <tr id="PBA<%=iPgNum%>" class="PageBreak1">
                    <th class="DataTable" rowspan="2" colspan="2">Market/Media</th>
                    <th class="DataTable1" rowspan="3">&nbsp;</th>
                    <%for(int x=0; x < iNumOfWk; x++){%>
                       <th class="DataTable" colspan="2">Week <%=x+1%></th>
                       <th class="DataTable1">&nbsp;</th>
                    <%}%>
                    <th class="DataTable" rowspan="3"  colspan="2">Advertising<br>Total</th>
                    <th class="DataTable" rowspan="3"  colspan="2">Sales/Plan</th>
                 </tr>
                 <tr id="PBB<%=iPgNum%>" class="PageBreak1">
                   <%for(int x=0; x < iNumOfWk; x++){%>
                     <th class="DataTable" colspan="2"><%=sWkend[x]%></th>
                     <th class="DataTable1" >&nbsp;</th>
                   <%}%>
                 </tr>
                 <tr id="PBC<%=iPgNum%>" class="PageBreak1">
                   <th class="DataTable2" colspan="2">Plan/Actual Sales <IMG SRC="ArrowRight01.gif" style="border=none"></th>
                     <%for(int x=0; x < iNumOfWk; x++){%>
                        <th class="DataTable" colspan="2">$<%=sWkPlan[x]%></th>
                        <th class="DataTable1" >&nbsp;</th>
                   <%}%>
                 </tr>
              <% iPgNum++; iPage=31;
                 }%>
              <% iLine++; %>
         <!-- --------------------------------------------------------------------------------------------------------------- -->
                   <tr class="<%if(sMDTY[k].equals("1")){%>TY<%} else {%>LY<%}%>" id="m<%=i%>g<%=j%>l<%=k%>">
                   <td class="DataTable3a" colspan="2"
                      id="<%=sMDMedia[k]%>@<%=sMDPType[k]%>@<%=sMDPDesc[k]%>@<%=sMDOrgWk[k]%>@<%=sMDPayee[k]%>@<%=sMDWDay[k]%>"
                      onClick="dspActionMenu(this, <%=i%>, null, &#34;<%=sMDMedia[k]%>&#34;, &#34;<%=sMDPType[k]%>&#34;, &#34;<%=sMDPTypeDesc[k]%>&#34;,
                       &#34;<%=sMDPDesc[k]%>&#34;, &#34;<%=sMDOrgWk[k]%>&#34;, &#34;<%=sMDSeq[k]%>&#34;, &#34;<%=sMDNumWk[k]%>&#34;,
                       &#34;<%=sMDPayee[k]%>&#34;, &#34;<%=sMDSize[k]%>&#34;, &#34;<%=sMDWDay[k]%>&#34;, &#34;<%=sMDRate[k]%>&#34;, &#34;<%=sMDSect[k]%>&#34;,
                       &#34;<%=sMDSpot[k]%>&#34;, &#34;<%=sMDCoopA[k]%>&#34;, &#34;<%=sMDCoopP[k]%>&#34;, &#34;<%=sMDComt[k]%>&#34;,
                       &#34;<%=sMDCombo[k]%>&#34;, &#34;<%=sMDComboType[k]%>&#34;, &#34;<%=sMDZone[k]%>&#34;, &#34;<%=sMDTotPlnCost[k]%>&#34;,
                       &#34;<%=sMDTotActCost[k]%>&#34;, &#34;<%=sMDTotFinCost[k]%>&#34;,
                       &#34;<%=sMDFrDate[k]%>&#34;, &#34;<%=sMDToDate[k]%>&#34;, [<%=sMDStr[k]%>],true);">
                       <%if(!sMDPayee[k].trim().equals("")) {%>
                           <%if(sMDPayee[k].length() <= 15) {%><%=sMDPayee[k]%><%} else {%><%=sMDPayee[k].substring(0, 15)%><%}%> /
                       <%}
                         else {%>
                           <%if(sMDMedName[k].length() <= 15) {%><%=sMDMedName[k]%><%} else {%><%=sMDMedName[k].substring(0, 15)%><%}%> /
                       <%}%>
                       <%if(!sMDPType[k].equals("X")){%>
                         <%if(sMDPDesc[k].length() <= 15) {%><%=sMDPDesc[k]%><%} else {%><%=sMDPDesc[k].substring(0, 15)%><%}%>
                       <%}
                         else {%>
                             <%if(sMDSpot[k].length() <= 10) {%><%=sMDSpot[k]%><%} else {%><%=sMDSpot[k].substring(0, 10)%><%}%>
                       <%}%>
                       <%if(sMGGrp[j].equals("ZZ")) {%>/ <%if(sMDMedName[k].length() <= 10) {%><%=sMDMedName[k]%><%} else {%><%=sMDMedName[k].substring(0, 10)%><%}%><%}%>
                       <%if(sMDMedia[k].equals("NP")) {%>/ <%=sWkDay[k]%> / <%=sMDSize[k]%><%}%>
                       <%if(!sMDComt[k].trim().equals("")) {%>/ <%=sMDComt[k]%><%}%>
                       <%if(sMDComboType[k].trim().equals("L")) {%><font color="red"><sup>cl</sup></font><%}%>
                       <%if(sMDComboType[k].trim().equals("T")) {%><font color="red"><sup>ct</sup></font><%}%>
                   </td>

                   <th class="DataTable1">&nbsp;</th>
                   <th class="DataTable1"><%if(!sMDMult[k].equals("0000000")) {%><a href="javascript:showMultEnt(<%=sMDMult[k]%>)">M</a><%} else {%>&nbsp;<%}%></th>
                   <%for(int l=0; l < iNumOfWk; l++){%>
                       <%if(!sMDPlnCost[k][l].equals(".00")) {%>
                          <td class="DataTable3"><%if(!sMDPlnCost[k][l].equals("0")){%>$<%=fmt.getFormatedNum(sMDPlnCost[k][l], "#,###,###")%><%} else {%>&nbsp;<%}%></td>
                          <td class="DataTable3"><%if(!sMDPlnCost[k][l].equals("0")){%><%=sMDPlanPrc[k][l]%>%<%} else {%>&nbsp;<%}%></td>
                       <%}
                         else {%>
                            <td class="DataTable3" >&nbsp;</td>
                            <td class="DataTable3" >&nbsp;</td>
                       <%}%>
                       <th class="DataTable1">&nbsp;</th>
                   <%}%>

                    <%if(!sLTPlnCost[k][0].equals("0")) {%>
                        <td class="DataTable3">$<%=fmt.getFormatedNum(sLTPlnCost[k][0], "#,###,###")%></td>
                        <td class="DataTable3"><%=sLTPlanPrc[k][0]%>%</td>
                   <%}
                     else {%>
                        <td class="DataTable3" colspan=2>&nbsp;</td>
                       <%}%>

                   <%if(!sLTPlnCost[k][1].equals("0")) {%>
                        <td class="DataTable3">$<%=fmt.getFormatedNum(sLTPlnCost[k][1], "#,###,###")%></td>
                        <td class="DataTable3"><%=sLTPlanPrc[k][1]%>%</td>
                   <%}
                     else {%>
                        <td class="DataTable3" colspan=2>&nbsp;</td>
                       <%}%>

                     <td class="DataTable3" colspan=2>&nbsp;</td>
                   </tr>
                <%}%>
              <%}%>
           <%}%>
           <!-- ----------------------- Report total ----------------------- -->
           <tr>
              <td class="DataTable6" colspan="2">Total</td>
              <th class="DataTable1">&nbsp;</th>
              <th class="DataTable1">&nbsp;</th>
                  <%for(int i=0; i < iNumOfWk; i++){%>
                     <td class="DataTable4">
                         <%if(!sRTPlnCost[i].equals("0")){%>$<%=sRTPlnCost[i]%><%} else {%>&nbsp;<%}%>
                     </td>
                     <td class="DataTable4">
                         <table width="100%"><tr class="split">
                                <td id="tdPlan" style="text-align:left"><%if(!sRTPlanPrc[i].equals(".0")){%>$<%=sWkPlan[i]%><%}%></td>
                                <td style="text-align:right"><%if(!sRTPlanPrc[i].equals(".0")){%><%=sRTPlanPrc[i]%>%<%} else {%>&nbsp;<%}%></td></tr>
                          </table>
                     </td>
                     <th class="DataTable1">&nbsp;</th>
                  <%}%>

              <td class="DataTable4" >
                 <%if(!sRTPlnCost[12].equals("0")){%>$<%=sRTPlnCost[12]%><%} else {%>&nbsp;<%}%>
              </td>
              <td class="DataTable4" >
                 <%if(!sRTPlanPrc[12].equals(".0")){%><%=sRTPlanPrc[12]%>%<%} else {%>&nbsp;<%}%>
              </td>

              <td class="DataTable4" >
                 <%if(!sRTPlnCost[13].equals("0")){%>$<%=sRTPlnCost[13]%><%} else {%>&nbsp;<%}%>
              </td>
              <td class="DataTable4" >
                 <%if(!sRTPlanPrc[13].equals(".0")){%><%=sRTPlanPrc[13]%>%<%} else {%>&nbsp;<%}%>
              </td>


              <td class="DataTable4" >
                 <%if(!sRTPlan[12].equals("0")){%>$<%=sRTPlan[12]%><%} else {%>&nbsp;<%}%>
              </td>
              <td class="DataTable4" >
                 <%if(!sRTPlan[13].equals("0")){%>$<%=sRTPlan[13]%><%} else {%>&nbsp;<%}%>
              </td>
           </tr>
<!-- --------------- End Store Weekly Events ---------------- -->
  </table>
<!------------- end of data table ------------------------>
  </td>
 </tr>
 <tr>
  <td align=left>
    <font size="-1">
      <font color="red"><sup>cl</sup></font> - Combo package: leading record<br>
      <font color="red"><sup>ct</sup></font> - Combo package: trailer record
    </font>
 </td>
</tr>

</table>

</body>
</html>


<%
   adCal.disconnect();
 }
%>