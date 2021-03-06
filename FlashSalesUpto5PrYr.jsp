<%@ page import="flashreps.FlashSalesUpto5PrYr, flashreps.RcvSalesDate, java.util.*, java.text.SimpleDateFormat"%>
<%
   long lStartTime = (new Date()).getTime();

   String sStore = request.getParameter("Store");
   String sDivision = request.getParameter("Division");
   String sDepartment = request.getParameter("Department");
   String sClass = request.getParameter("Class");
   String sLevel = request.getParameter("Level");
   String sDate = request.getParameter("Date");
   String sPeriod = request.getParameter("Period");
   String sSort = request.getParameter("Sort");
   String sChall = request.getParameter("Chall");

   if(sStore == null) sStore = "ALL";
   if(sDivision == null) sDivision = "ALL";
   if(sDepartment == null) sDepartment = "ALL";
   if(sClass == null) sClass = "ALL";
   if(sLevel == null) sLevel = "S";
   if(sSort == null) sSort = "GRP";
   if(sChall == null) sChall = " ";

   /* check if flash sales already exists for selected date, when user sent requiest for
      all store and division */
   RcvSalesDate rcvdat = new RcvSalesDate(sDate);
   boolean bAvail = rcvdat.getDateAvailability();
   rcvdat = null;

   if (bAvail)
   {

      if(sDivision.length() < 2) sDivision += " ";
      if(sDepartment.length() < 3) sDepartment += "  ";


      // Set yesturday as default date
      SimpleDateFormat sdfNow = new SimpleDateFormat("MM/dd/yyyy");
      Date curdt = new Date((new Date()).getTime() - 86400000);
      String sYesturday = sdfNow.format(curdt);
      if(sDate == null) sDate = sYesturday;
      if(sPeriod == null) sPeriod = "MTDTYLY";

      /*System.out.println(sDivision + " " + sDepartment + " " + sClass + " "
          + sStore + " " + sDate + " " + sLevel + " " + sPeriod + " " + sSort);*/

      FlashSalesUpto5PrYr slsTyLy = new FlashSalesUpto5PrYr(sDivision, sDepartment, sClass, sStore, sDate,
                                      sPeriod, sLevel, sSort, sChall);
      int iNumOfGrp = slsTyLy.getNumOfGrp();
      String [] sGrp = slsTyLy.getGrp();
      String [] sGrpName = slsTyLy.getGrpName();
      String [] sGrpReg = slsTyLy.getGrpReg();

      String [] sTyDate = slsTyLy.getTyDate();
      String [] sLyDate = slsTyLy.getLyDate();
      String [] sTyHol = slsTyLy.getTyHol();
      String [] sLyHol = slsTyLy.getLyHol();

      int iNumOfReg = slsTyLy.getNumOfReg();
      String [] sReg = slsTyLy.getReg();
      int [] iNumOfStrInReg = slsTyLy.getNumStrInReg();
      String [][] sStr = slsTyLy.getStr();

      String [][] sTySls = slsTyLy.getTySls();
      String [][] sLySls = slsTyLy.getLySls();
      String [][] sDlyPrc = slsTyLy.getDlyPrc();
      String [][] sComPrc = slsTyLy.getComPrc();
      String [][] sTyKio = slsTyLy.getTyKio();
      String [][] sLyKio = slsTyLy.getLyKio();
      String [][] sTyStrKio = slsTyLy.getTyStrKio();
      String [][] sLyStrKio = slsTyLy.getLyStrKio();


      String [][] sBrkLyDt = slsTyLy.getBrkLyDt();
      String [][] sBrkLyNm = slsTyLy.getBrkLyNm();
      String [][] sBrkTyDt = slsTyLy.getBrkTyDt();
      String [][] sBrkTyNm = slsTyLy.getBrkTyNm();

      // Mall / Ski totals
      String [] sMall = slsTyLy.getMall();
      String [][] sMallTySls = slsTyLy.getMallTySls();
      String [][] sMallLySls = slsTyLy.getMallLySls();
      String [][] sMallDlyPrc = slsTyLy.getMallDlyPrc();
      String [][] sMallComPrc = slsTyLy.getMallComPrc();
      String [][] sMallTyKio = slsTyLy.getMallTyKio();
      String [][] sMallLyKio = slsTyLy.getMallLyKio();
      String [][] sMallTyStrKio = slsTyLy.getMallTyStrKio();
      String [][] sMallLyStrKio = slsTyLy.getMallLyStrKio();

      int iNumOfDmm = slsTyLy.getNumOfDmm();
      String [] sDmmCat = slsTyLy.getDmmCat();
      String [][] sDmmTySls = slsTyLy.getDmmTySls();
      String [][] sDmmLySls = slsTyLy.getDmmLySls();
      String [][] sDmmDlyPrc = slsTyLy.getDmmDlyPrc();
      String [][] sDmmComPrc = slsTyLy.getDmmComPrc();

      String [] sDmmGrp = slsTyLy.getDmmGrp();
      String [] sDmmName = slsTyLy.getDmmName();
      String [] sDmmCode = slsTyLy.getDmmCode();
      String [] sDmmSepr = slsTyLy.getDmmSepr();
      String [] sDmmColor = slsTyLy.getDmmColor();
      String sDmmGrpJsa = slsTyLy.getDmmGrpJsa();
      String sDmmNameJsa = slsTyLy.getDmmNameJsa();
      String sDmmDivJsa = slsTyLy.getDmmDivJsa();

      // Region totals
      String [][] sRegTySls = slsTyLy.getRegTySls();
      String [][] sRegLySls = slsTyLy.getRegLySls();
      String [][] sRegDlyPrc = slsTyLy.getRegDlyPrc();
      String [][] sRegComPrc = slsTyLy.getRegComPrc();
      String [][] sRegTyKio = slsTyLy.getRegTyKio();
      String [][] sRegLyKio = slsTyLy.getRegLyKio();
      String [][] sRegTyStrKio = slsTyLy.getRegTyStrKio();
      String [][] sRegLyStrKio = slsTyLy.getRegLyStrKio();

      // Region totals
      String [][] sRegCompTySls = slsTyLy.getRegCompTySls();
      String [][] sRegCompLySls = slsTyLy.getRegCompLySls();
      String [][] sRegCompDlyPrc = slsTyLy.getRegCompDlyPrc();
      String [][] sRegCompComPrc = slsTyLy.getRegCompComPrc();
      String [][] sRegCompTyKio = slsTyLy.getRegCompTyKio();
      String [][] sRegCompLyKio = slsTyLy.getRegCompLyKio();
      String [][] sRegCompTyStrKio = slsTyLy.getRegCompTyStrKio();
      String [][] sRegCompLyStrKio = slsTyLy.getRegCompLyStrKio();

      // Report totals
      String [] sRepTySls = slsTyLy.getRepTySls();
      String [] sRepLySls = slsTyLy.getRepLySls();
      String [] sRepDlyPrc = slsTyLy.getRepDlyPrc();
      String [] sRepComPrc = slsTyLy.getRepComPrc();
      String [] sRepTyKio = slsTyLy.getRepTyKio();
      String [] sRepLyKio = slsTyLy.getRepLyKio();
      String [] sRepTyStrKio = slsTyLy.getRepTyStrKio();
      String [] sRepLyStrKio = slsTyLy.getRepLyStrKio();

      // Selected Parameters Names
      String sSelDivName = slsTyLy.getSelDivName();
      String sSelDptName = slsTyLy.getSelDptName();
      String sSelClsName = slsTyLy.getSelClsName();
      String sSelStrName = slsTyLy.getSelStrName();

      // Temperature outside store
      int iNumOfStr = slsTyLy.getNumOfStr();
      String [] sTempStr = slsTyLy.getTempStr();
      String [][] sTyTempMin = slsTyLy.getTyTempMin();
      String [][] sTyTempMax = slsTyLy.getTyTempMax();
      String [][] sLyTempMin = slsTyLy.getLyTempMin();
      String [][] sLyTempMax = slsTyLy.getLyTempMax();
      String [] sTyTempAvg = slsTyLy.getTyTempAvg();
      String [] sLyTempAvg = slsTyLy.getLyTempAvg();
      // company total of temperature outside store
      String [] sTyTotTempMin = slsTyLy.getTyTotTempMin();
      String [] sTyTotTempMax = slsTyLy.getTyTotTempMax();
      String [] sLyTotTempMin = slsTyLy.getLyTotTempMin();
      String [] sLyTotTempMax = slsTyLy.getLyTotTempMax();
      String sTyTotTempAvg = slsTyLy.getTyTotTempAvg();
      String sLyTotTempAvg = slsTyLy.getLyTotTempAvg();

      String sArchv = slsTyLy.getArchvJsa();
      String sFutur = slsTyLy.getFuturJsa();

      int iNumOfCompStr = 0;
      String [] sCompStr = null;

      String sColName = "Str";
      if (sLevel.equals("D")) { sColName = "Div"; }
      if (sLevel.equals("P")) { sColName = "Dpt"; }
      if (sLevel.equals("C")) { sColName = "Cls"; }

      String sLyCol = "LY";
      if (sPeriod.substring(5).equals("PLAN")){ sLyCol = "Plan"; }
      else if(sPeriod.substring(5).equals("LY2")){ sLyCol = "LLY"; }
      else if(!sPeriod.substring(5).equals("LY")){ sLyCol = "Avg"; }

      String sDispBy = null;

      if (!sLevel.equals("S") && !sLevel.equals("T")) sDispBy = "Str";
      else if ((sDivision.equals("ALL") || sDivision.substring(0, 2).equals("SK"))&& sDepartment.equals("ALL") && sClass.equals("ALL")) sDispBy = "Div";
      else if (!sDivision.equals("ALL") && sDepartment.equals("ALL") && sClass.equals("ALL")) sDispBy = "Dpt";
      else if (!sDepartment.equals("ALL") || !sClass.equals("ALL")) sDispBy = "Cls";

      long lEndTime = (new Date()).getTime();
      long lElapse = (lEndTime - lStartTime) / 1000;
      if (lElapse==0) lElapse = 1;

      boolean bPrcAllows = sPeriod.equals("MTDTYLY");
      boolean bKioskAllows = (sPeriod.equals("MTDTYLY") || sPeriod.equals("YTDTYLY"))
        && sLevel.equals("S") && sDivision.equals("ALL") && sDepartment.equals("ALL") && sClass.equals("ALL");

      boolean bKiosk = session.getAttribute("USER") == null;
      String sUser = "KIOSK";
      if(!bKiosk) { sUser = session.getAttribute("USER").toString(); }

      String sCompName = "LY";
      if(sPeriod.substring(5).equals("LY2")){ sCompName = "LLY"; }
      else if (sPeriod.substring(5).equals("LY2A")){ sCompName = "2 LY Average"; }
      else if (sPeriod.substring(5).equals("LY3A")){ sCompName = "3 LY Average"; }
      else if (sPeriod.substring(5).equals("LY4A")){ sCompName = "4 LY Average"; }
      else if (sPeriod.substring(5).equals("LY5A")){ sCompName = "5 LY Average"; }
%>
<html>
<head>
<Meta http-equiv="refresh">
<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        table.Prompt { border: gray groove 1px;}

        tr.TblHdr { background:#FFE4C4; font-family:Verdanda; font-size:10px; )}

        tr.DataTable { background:#efefef; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:PaleTurquoise; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:#efefef; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:cornsilk; font-size:1px}
        tr.DataTable5 { background:khaki; font-family:Arial; font-size:10px }
        tr.DataTable6 { background:#cccfff; font-family:Arial; font-size:10px;}


        td.DataTable { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                        border-bottom: #FFCC99 solid 1px; border-right: darkred solid 1px;
                        text-align:right;}
        td.DataTable1 { padding-top:2px; padding-bottom:2px; padding-left:2px;
                       padding-right:2px; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:left;}
        td.DataTable2 { padding-top:1px; padding-right:1px;
                        border-bottom: darkred solid 1px; border-right: darkred solid 1px;}

        td.DataTable3 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center;}
        td.DataTable31 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 2px;
                       text-align:center;}
        td.DataTable312 { color:red; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 2px;
                       text-align:center; }
        td.DataTable313 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: darkred solid 1px; border-right: blue solid 2px;
                       text-align:center;}

        td.DataTable32 { color:red; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                       text-align:center; }

        td.DataTable4 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 1px;
                       text-align:right;}
        td.DataTable41 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 2px;
                       text-align:right;}
        td.DataTable413 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: blue solid 2px;
                       text-align:right;}
        td.DataTable44 { padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 1px;
                       text-align:left;}

        td.DataTable5 { cursor:hand; color:blue; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 1px;
                       text-align:left; text-decoration:underline;}
        td.DataTable6 { cursor:hand; color:blue; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 1px;
                       text-align:left; text-decoration:underline;}

        td.DataTable7 { color: blue; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 1px;
                       text-align:center;}
        td.DataTable71 { color: red; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 2px;
                       text-align:center;}
        td.DataTable712 { background:white; color: blue; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 1px;
                       text-align:center;}
        td.DataTable713 { background:white; color: red; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: blue solid 2px;
                       text-align:center;}
        td.DataTable714 { color: blue; padding-top:2px; padding-bottom:2px; padding-left:2px; padding-right:2px;
                       border-bottom: #FFCC99 solid 1px; border-right: darkred solid 2px;
                       text-align:center;}


        div.dvPrompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvHoliday { position:absolute; visibility:hidden; background-attachment: scroll;
               width:auto; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        div.dvEcom { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:250; background-color:LemonChiffon; z-index:11;
              text-align:center; font-size:10px}

        div.selBox {cursor:hand; background:cornsilk; border: darkblue solid 2px; padding-top:2px; height:30px;
                    font-family:Arial; font-size:11px; text-align:left;}
        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt {border: lightgrey outset 1px; text-align:left; font-family:Arial; font-size:10px; }
        td.Prompt1 {border: lightgrey outset 1px; text-align:center; font-family:Arial; font-size:10px; }

        td.Prompt2{ text-align:left; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:center; vertical-align:bottom; font-family:Arial; font-size:10px; }
        td.Prompt4 { text-align:right; font-family:Arial; font-size:10px; }

        .Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:2px; font-family:Arial; font-size:10px }

        #tdPrc { display:none; }
        #tdKioskMemo { display:none; }
        #trDivider { display:none; }
</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Store = "<%=sStore%>";
var Division = "<%=sDivision%>";
var Department = "<%=sDepartment%>";
var Class = "<%=sClass%>";
var Level = "<%=sLevel%>";
var SelectedDate = "<%=sDate%>";
var Period = "<%=sPeriod%>";
var Sort = "<%=sSort%>";

var Archv = [<%=sArchv%>]
var Futur = [<%=sFutur%>]

var Div = null;
var DivName = null;
var Dpt = null;
var DptName = null;
var DptGroup = null;
var Str = null;
var StrName = null;

// Event Calendar
var Column = null;
var Event  = null;
var From = null;
var To = null;
var EvtText = null;
var EvtMemo = null;
var EvtSign = null;
var EvtOutPrt = null;
var EvtRciPrt = null;

// Advertising
var AdvMkt = null;
var AdvOrgWk = null;
var AdvMedia = null;
var AdvMedDesc = null;
var AdvPType =  null;
var AdvPDesc = null;
var AdvSeq = null;
var AdvPayee =  null;
var AdvMktName =  null;
var AdvDoc =  null;
var Year =  null;

var PriorFuture = "A";
var Row = 1;

var DmmGrp = [<%=sDmmGrpJsa%>];
var DmmName = [<%=sDmmNameJsa%>];
var DmmDiv = [<%=sDmmDivJsa%>];

var rowColor = "#efefef";

var KioDisp = false;
var KioStrDisp = false;
var PrcDisp = false;
//--------------- End of Global variables ----------------
function bodyLoad()
{
  showTemp();

  setBoxclasses(["BoxName",  "BoxClose"], ["dvPrompt", "dvEcom"]);
  window.document.focus();

  for(var i=0; i < document.all.tdGrp.length; i++) { document.all.tdGrp[i].rowSpan = 1; }

  for(var i=0; i < document.all.trGrp.length; i++) { document.all.trGrp[i].style.backgroundColor = "#efefef"; }

  // retreive Event Calendar
  if(Division=="ALL" && Store == "ALL" &&  Level == "S") { rtvEvtCal(); }
}
//==============================================================================
// retreive event calendar  data
//==============================================================================
function rtvEvtCal()
{
   var url = "EvtCalOnFlashSls.jsp?" + "Date=" + SelectedDate;
   //alert(url);
   //window.location.href = url;
   window.frame3.location = url;
}
//==============================================================================
// set Event Calendar arrays
//==============================================================================
function popEvtCalArr(Column, Event, From, To, EvtText, EvtMemo, EvtSign, EvtOutPrt, EvtRciPrt,
       AdvMkt, AdvOrgWk, AdvMedia, AdvMedDesc, AdvSeq, AdvPayee, AdvMktName, AdvDoc, Year)
{
   this.Column = Column
   this.Event = Event
   this.From = From
   this.To = To
   this.EvtText = EvtText
   this.EvtMemo = EvtMemo
   this.EvtSign = EvtSign
   this.EvtOutPrt = EvtOutPrt
   this.EvtRciPrt = EvtRciPrt
   this.AdvMkt = AdvMkt
   this.AdvOrgWk = AdvOrgWk
   this.AdvMedia = AdvMedia
   this.AdvMedDesc = AdvMedDesc
   this.AdvSeq = AdvSeq
   this.AdvPayee = AdvPayee
   this.AdvMktName = AdvMktName
   this.AdvDoc = AdvDoc
   this.Year = Year
   window.frame3.close;
   buildEvtCal();
}
//==============================================================================
// build Event Calendar table
//==============================================================================
function buildEvtCal()
{
   var html = "<p style='font-size:12px; font-weight:bold'>Event Calendar for this week<br>"
   html += "<table class='DataTable' cellPadding='0' cellSpacing='0'>"
          + "<tr class='TblHdr'>"
            + "<td class='DataTable2'>Event</td>"
            + "<td class='DataTable2'>From</td>"
            + "<td class='DataTable2'>To</td>"
            + "<td class='DataTable2'>Stores</td>"
            + "<td class='DataTable2'>M<br>e<br>m<br>o</td>"
            + "<td class='DataTable2'>S<br>i<br>g<br>n</td>"
            + "<td class='DataTable2'>A<br>d<br>v</td>"

          + "</tr>"

   var ly = false;
   html += "<tr class='DataTable2'><td class='DataTable1' colspan=7>This Year</td></tr>"
   for(var i=0; i < Event.length; i++)
   {
      if(Year[i]=="0" && !ly)
      {
         html += "<tr class='DataTable2'><td class='DataTable1' colspan=7>Last Year</td></tr>";
         ly = true;
      }

      html += "<tr class='DataTable'>"
               + "<td class='DataTable1'><a href='javascript:showEvent(" + i + ")'>" + Event[i] + "</a></td>"
               + "<td class='DataTable1'>" + From[i] + "</td>"
               + "<td class='DataTable1'>" + To[i] + "</td>"
               + "<td class='DataTable1'>" + EvtText[i][3] + "</td>"
               + "<td class='DataTable1'><a href='javascript:showDoc(" + i + ",&#34;MEMO&#34;)'>M</a></td>"
               + "<td class='DataTable1'><a href='javascript:showDoc(" + i + ",&#34;SIGN&#34;)'>S</a></td>"
               + "<td class='DataTable1'><a href='javascript:showAdv(" + i + ")'>A</a></td>"
           + "</tr>"
    }
   html += "</table>";

   document.all.dvEvtCal.innerHTML = html;
   document.all.dvEvtCal.style.width = "auto";
   document.all.dvEvtCal.style.border = "none";
   document.all.dvEvtCal.style.backgroundColor = "transparent";
   document.all.dvEvtCal.style.pixelLeft= 10;
   document.all.dvEvtCal.style.visibility = "visible";
}
//==============================================================================
// sort feature
//==============================================================================
function sortBy(sort)
{
   url = "FlashSalesUpto5PrYr.jsp?"
     + "Store=" + Store
     + "&Division=" + Division
     + "&Department=" + Department
     + "&Class=" + Class
     + "&Date=" + SelectedDate
     + "&Period=" + Period
     + "&Level=" + Level
     + "&Sort=" + sort
     + "&Chall=<%=sChall%>"

   //alert(url);
   window.location.href=url;
}
//==============================================================================
// Drilldown feature
//==============================================================================
function reverseLevel()
{
   url = "FlashSalesUpto5PrYr.jsp?"
       + "Store=" + Store.trim()
       + "&Division=" + Division.trim()
       + "&Department=" + Department
       + "&Class=" + Class
       + "&Date=" + SelectedDate
       + "&Period=" + Period
       + "&Sort=" + Sort
       + "&Chall=<%=sChall%>"


       if (Level == "S") url += "&Level=D"
       else if (Level=="T") url += "&Level=V"
       else if (Level=="V") url += "&Level=T"
       else url += "&Level=S"

   //alert(url);
   window.location.href=url;
}

//==============================================================================
// reverse level of report from Store to Division or vice versa
//==============================================================================
function drillDown(grp)
{
   url = "FlashSalesUpto5PrYr.jsp?"
   if (grp=="ALL")
   {
     url += "Store=" + Store.trim()
         + "&Division=" + Division.trim()
         + "&Department=" + Department
         + "&Class=" + Class;
   }
   else if (Level=="S" && grp.substring(0,2)=="DM")
   {
     url += "Store=" + Store.trim()
         + "&Division=" + grp
         + "&Department=" + Department
         + "&Class=" + Class;
   }
   else if (Level=="S")
   {
     url += "Store=" + grp
         + "&Division=" + Division.trim()
         + "&Department=" + Department
         + "&Class=" + Class;
   }
   else if (Level=="D")
   {
     url += "Store=" + Store.trim()
         + "&Division=" + grp.trim()
         + "&Department=" + Department
         + "&Class=" + Class;
   }
   else if (Level=="P")
   {
     url += "Store=" + Store.trim()
         + "&Division=" + Division.trim()
         + "&Department=" + grp.trim()
         + "&Class=" + Class;
   }
   else if (Level=="C")
   {
     url += "Store=" + Store.trim()
         + "&Division=" + Division.trim()
         + "&Department=" + Department
         + "&Class=" + grp.trim();
   }

   url += "&Date=" + SelectedDate
       + "&Period=" + Period
       + "&Level=" + setNextLvl(grp)
       + "&Sort=" + Sort
       + "&Chall=<%=sChall%>"

   //alert(url);
   window.location.href=url;

}
//==============================================================================
// set level for drilldown report
//==============================================================================
function setNextLvl(grp)
{
  var lvl = null;

  if (Level=="S")
  {
    if (grp.substring(0, 3)=="REG") lvl = "S";
    else if (grp.substring(0, 3)=="RCS") lvl = "S";
    else if (grp.substring(0, 4)=="MALL") lvl = "S";
    else if (grp.substring(0, 4)=="COMP") lvl = "S";
    else if ( (Division=="ALL" || Division.substring(0, 2)=="SK" || Division.substring(0, 2)=="DM")
         && Department=="ALL" && Class=="ALL") lvl = "D";
    else if (Division!="ALL" && Class=="ALL") lvl = "P";
    else if (Department!="ALL" || Class!="ALL") lvl = "C";
  }
  else if (grp.substring(0, 2)=="SK") { lvl="D"; }
  else if (grp.substring(0, 2)=="DM") { lvl="D"; }
  else if (grp!="ALL" && Level == "D") { lvl="P";}
  else if (grp!="ALL" && Level == "P") { lvl="C";  }
  else if (grp!="ALL" && Level == "C" && Store=="ALL") { lvl="S";  }
  else if (Store.substring(0, 4)=="MALL" && grp=="ALL") { lvl="S";}
  else if (Division.substring(0, 2)=="SK" && grp=="ALL") { lvl="S";}
  return lvl;
}
//==============================================================================
// change selection
//==============================================================================
function chgSelection()
{
   var html = "<TABLE border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>" + "<td class='BoxName' nowrap>Select Another Report</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popPanel() + "</tr></td>"
   + "</TABLE>"

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.pixelLeft= document.documentElement.scrollLeft + 400;
   document.all.dvPrompt.style.pixelTop= document.documentElement.scrollTop + 130;
   document.all.dvPrompt.style.visibility = "visible";

   // retreive division and department
   rtvDivDptCls("ALL", "ALL", "DIVDPT");
   rtvStores();
   setDates();
   setLyRepSel();
}
//--------------------------------------------------------
// populate panel
//--------------------------------------------------------
function popPanel()
{
   var dummy = "<table>"
   var panel = "<table cellPadding='0' cellSpacing='0'  width='100%'>"
          + "<tr><td class='Prompt'>Div:</td>"
          + "<td class='Prompt'><select class='Small' name='Division' onchange='doDivSelect(this.selectedIndex);'></select></td></tr>"
      + "<tr><td class='Prompt'>Dpt:</td>"
          + "<td class='Prompt'><select class='Small' name='Department' onChange='clearClassSel()'></select>"
            + "&nbsp;<button onClick='rtvClasses()' class='Small'>Classes</button></td></tr>"
      + "<tr><td class='Prompt'>Class:</td>"
         + "<td class='Prompt'><select class='Small' name='Class'></select></td></tr>"
      + "<tr><td class='Prompt'>Store:</td>"
         + "<td class='Prompt'><select class='Small' name='Store' onChange='onStrChg(this)'></select>"
         + "<span id='spChain'><input name='Chain' type='checkbox' value='S'>By Chain</span></td></tr>"
      + "<tr><td class='Prompt'' nowrap colspan=2>Report:</td></tr>"
         + "<table style='font-size:10px;' cellPadding=0 cellSpacing=0>"
         + "<tr>"
         + "<th style='border-bottom:darkred 1px solid;' colspan=3>Month-To-Date<br>TY vs.</th>"
         + "<th style='border-left:darkred 1px solid; border-right:darkred 1px solid'>&nbsp;</th>"
         + "<th style='border-bottom:darkred 1px solid;'colspan=3>Year-To-Date<br>TY vs.</th>"
         + "</tr>"

         + "<tr style='font-size:10px;'>"
         + "<td><input name='Report' type='radio' value='MTDTYLY'>LY</td>"
         + "<td nowrap><input name='Report' type='radio' value='MTDTYLY2' checked>LLY</td>"
         + "<td nowrap><input name='Report' type='radio' value='MTDTYLY2A'>2LY Avg.</td>"

         + "<th style='border-left:darkred 1px solid; border-right:darkred 1px solid'>&nbsp;</th>"

         + "<td nowrap><input name='Report' type='radio' value='YTDTYLY'> LY</td>"
         + "<td nowrap><input name='Report' type='radio' value='YTDTYLY2'>LLY</td>"
         + "<td nowrap><input name='Report' type='radio' value='YTDTYLY2A'>2LY Avg.</td>"

         + "<tr style='font-size:10px;'>"
         + "<td nowrap><input name='Report' type='radio' value='MTDTYLY3A'>3LY Avg.</td>"
         + "<td nowrap><input name='Report' type='radio' value='MTDTYLY4A'>4LY Avg.</td>"
         + "<td nowrap><input name='Report' type='radio' value='MTDTYLY5A'>5LY Avg.</td>"

         + "<th style='border-left:darkred 1px solid; border-right:darkred 1px solid'>&nbsp;</th>"

         + "<td nowrap><input name='Report' type='radio' value='YTDTYLY3A'>3LY Avg.</td>"
         + "<td nowrap><input name='Report' type='radio' value='YTDTYLY4A'>4LY Avg.</td>"
         + "<td nowrap><input name='Report' type='radio' value='YTDTYLY5A'>5LY Avg.</td>"
         + "</tr>"
         + "<tr><td style='border-top:darkred 1px solid; text-align:center;' colspan=3><input name='Report' type='radio' value='MTDTYPLAN'>Plan</td>"
         + "<th style='border-left:darkred 1px solid; border-right:darkred 1px solid'>&nbsp;</th>"
         + "<td style='border-top:darkred 1px solid; text-align:center;' colspan=3><input name='Report' type='radio' value='YTDTYPLAN'>Plan</td>"
         + "</tr>"
         + "</table>"
      + "</td></tr>"


      + "<tr><td class='Prompt'>Prior:"
         + "<td class='Prompt'><select class='Small' onclick='chgSelDate(1);' name='Date'></select></td></tr>"
      + "<tr><td class='Prompt'>Future:"
         + "<td class='Prompt'><select class='Small' onclick='chgSelDate(2);' name='Futur'></select></td></tr>"
      + "<tr><td class='Prompt1' colspan=2><button onClick='submitReport()' class='Small'>Submit</button>&nbsp;"
      + "<span id='spSelDate'>Prior date selected<span></td></tr>"
     + "</table>";
   return panel;
}
//==============================================================================
// set ly report selection
//==============================================================================
function setLyRepSel()
{

  var lysel = document.all.LYSeL;
  if (Level.length == 1)
  {
       lysel[0].checked = true;
  }
  else
  {
     var levelsel = Level.substring(1);
     for(var i=0; i < lysel.length; i++)
     {
        if(lysel[i].value == levelsel){ lysel[i].checked = true; break; }
     }
  }
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvPrompt.innerHTML = " ";
   document.all.dvPrompt.style.visibility = "hidden";
}
//==============================================================================
// retreive classes
//==============================================================================
function rtvClasses()
{
   var div = document.all.Division.options[document.all.Division.selectedIndex].value
   var dpt = document.all.Department.options[document.all.Department.selectedIndex].value
   rtvDivDptCls(div, dpt, "CLASS");
}
//==============================================================================
// retreive div/dpt/classes
//==============================================================================
function rtvDivDptCls(div, dpt, info)
{
   var url = "RetreiveDivDptCls.jsp?"
           + "Division=" + div
           + "&Department=" + dpt
           + "&Info=" + info;

   //alert(url);
   //window.location.href = url;
   window.frame1.location = url;
}
//==============================================================================
// retreive Stores
//==============================================================================
function rtvStores()
{
   var url = "RetreiveStore.jsp?";
   //alert(url);
   //window.location.href = url;
   window.frame2.location = url;
}
//==============================================================================
// set Date array
//==============================================================================
function  setDates()
{
   for(var i=0; i < Archv.length; i++)
   {
      document.all.Date.options[i] = new Option(Archv[i], Archv[i])
   }
   for(var i=0; i < Futur.length; i++)
   {
      document.all.Futur.options[i] = new Option(Futur[i], Futur[i])
   }
}

//==============================================================================
// show selected classes
//==============================================================================
function showClasses(cls, clsName)
{
   if(document.all.Class != null)
   {
      // clear
      for(var i = document.all.Class.length; i >= 0; i--) {document.all.Class.options[i] = null;}

      //popilate
      for(var i=0; i < cls.length; i++)
      {
        document.all.Class.options[i] = new Option(clsName[i], cls[i]);
      }
      window.frame1.close();
   }
}
//==============================================================================
// show selected Division/ department
//==============================================================================
function showDivDpt(div, divName, dpt, dptName, dptGroup)
{
   window.frame1.close();
   Div = div;
   DivName = divName;
   Dpt = dpt;
   DptName = dptName;
   DptGroup = dptGroup;
   // populate division and department
   if(document.all.Division != null) doDivSelect(null);
}
//==============================================================================
// show selected Division/ department
//==============================================================================
function showStores(str, strName)
{
   Str = str;
   StrName = strName;
   window.frame2.close();
   if(document.all.Store != null) doStrSelect();
}
//==============================================================================
// populate division dropdown menu
//==============================================================================
function doDivSelect(id) {
    var df = document.all;

    var allowed;

    if (id == null || id == 0) {
        //  populate the division list
        for (var i = 0; i < Div.length; i++)
            df.Division.options[i] = new Option(DivName[i], Div[i]);
        id = 0;
    }
        allowed = DptGroup[id].split(":");

        //  clear current depts
        for (var i = df.Department.length; i >= 0; i--) df.Department.options[i] = null;

        //  if all are to be displayed
        if (allowed[0] == "all")
            for (var i = 0; i < Dpt.length; i++)
                df.Department.options[i] = new Option(DptName[i],Dpt[i]);

        //  else display the desired depts
        else
            for (var i = 0; i < allowed.length; i++)
                df.Department.options[i] = new Option(DptName[allowed[i]], Dpt[allowed[i]]);
        clearClassSel();
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect() {
    var df = document.all;
    df.Store.options[0] = new Option(Str[0] + " - " + StrName[0], Str[0]);
    df.Store.options[1] = new Option("Compare Stores","COMP");
    df.Store.options[2] = new Option("Ski Chalet Stores","SCH");
    for (i = 3, j=1; j < Str.length; i++, j++)
    {
      df.Store.options[i] = new Option(Str[j] + " - " + StrName[j],Str[j]);
    }


}
//==============================================================================
// clear Class dropdown menu
//==============================================================================
function clearClassSel()
{
   //  clear current classes
   for (var i = document.all.Class.length; i >= 0; i--)
   {
      document.all.Class.options[i] = null;
   }
   document.all.Class.options[0] = new Option("All Classes","ALL");
}
//==============================================================================
// check, if level must be set visible or not depend on store selection
//==============================================================================
function onStrChg(str)
{
   if (str.value != "ALL"){ document.all.spChain.style.visibility = "hidden" }
   else { document.all.spChain.style.visibility = "visible" }
}
//==============================================================================
// submit report
//==============================================================================
function chgSelDate(dt)
{
  if (dt==1)
  {
     document.all.spSelDate.innerHTML="Prior date selected"
     PriorFuture="A";
  }
  else
  {
     document.all.spSelDate.innerHTML="Future date selected"
     PriorFuture="F";
  }
}
//==============================================================================
// submit report
//==============================================================================
function submitReport()
{
  var form = document.all;
  var error = false;
  var msg;
  var divIdx = form.Division.selectedIndex;
  var dptIdx = form.Department.selectedIndex;
  var clsIdx = form.Class.selectedIndex;
  var strIdx = form.Store.selectedIndex;
  var dateIdx = form.Date.selectedIndex;

  var div = form.Division.options[divIdx].value;
  var dpt = form.Department.options[dptIdx].value;
  var cls = form.Store.options[clsIdx].value;
  var str = form.Store.options[strIdx].value;
  var divnm = form.Division.options[divIdx].text;
  var dptnm = form.Department.options[dptIdx].text;
  var clsnm = form.Class.options[clsIdx].text;
  var date = form.Date.options[dateIdx].value;
  if(PriorFuture=="F")
  {
     dateIdx = form.Futur.selectedIndex;
     date = form.Futur.options[dateIdx].value;
  }
  var level = null;
  var period = null;

  // Report Level
  if(str == "ALL" && !document.all.Chain.checked) level = "S";
  else if(cls != "ALL" || dpt != "ALL") level = "C";
  else if(div != "ALL" ) level = "P";
  else level = "D";

  // Report type
  // Report type
  var reptype = document.all.Report;
  for(var i=0; i < reptype.length; i++)
  {
     if(reptype[i].checked){ period = reptype[i].value; break;}
  }

  var url = "FlashSalesUpto5PrYr.jsp?"
     + "Store=" + str
     + "&Division=" + div
     + "&DivName=" + divnm
     + "&Department=" + dpt
     + "&DptName=" + dptnm
     + "&Class=" + cls
     + "&clsName=" + clsnm
     + "&Date=" + date
     + "&Level=" + level
     + "&Period=" + period
     + "&Chall=<%=sChall%>"

   //alert(url)
   window.location.href=url
}
//==============================================================================
// submit report for prior years or plan
//==============================================================================
function sbmLyAvg(pryear)
{
   pryear.checked = true;
   for(var i=0; i < SelRepType.length; i++)
   {
      SelRepType[i].disabled = true;
   }

   url = "FlashSalesUpto5PrYr.jsp?"
     + "Store=" + Store
     + "&Division=" + Division
     + "&Department=" + Department
     + "&Class=" + Class
     + "&Date=" + SelectedDate
     + "&Period=" + Period.substring(0, 5) + pryear.value
     + "&Level=" + Level
     + "&Sort=" + Sort

   //alert(url)
   window.location.href=url
}
//--------------------------------------------------------
// show document list
//--------------------------------------------------------
function showDoc(arg, type)
{
   var hdr = " Memo List";
   var doc = EvtMemo;
   if(type =='SIGN') { hdr = "Sign List";  doc = EvtSign; }
   else if(type =='OUTPOST') { hdr = "Outside Printed Posters";  doc = EvtOutPrt; }
   else if(type =='RCIPOST') { hdr = "Rci Produced Posters";  doc = EvtRciPrt; }

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"

   html += "<tr><td class='Prompt3' colspan=2>&nbsp;</td></tr>"

   // load event documents
   for(var i=0, start = 0; i < doc[arg].length; i++)
   {
       start = doc[arg][i].lastIndexOf("/") + 1; // find where document name starts.
       html += "<tr><td class='Prompt2' colspan=2>"
            + "<a target='_blank' href='" + doc[arg][i] + "'>" + doc[arg][i].substring(start) + "</a></td></tr>"
   }

   if(doc[arg].length == 0) html += "<tr><td class='Prompt3' colspan=2>No documents attached to the event.</td></tr>"

   html += "<tr><td class='Prompt3' colspan=2>&nbsp;</td></tr>"
   html += "<tr><td class='Prompt3' colspan=2>"

   html += "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
      + "</table>"

   if(doc[arg].length < 10) document.all.dvPrompt.style.height = doc[arg].length * 25;

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.pixelLeft= document.documentElement.scrollLeft + 400;
   document.all.dvPrompt.style.pixelTop= document.documentElement.scrollTop + 130;
   document.all.dvPrompt.style.visibility = "visible";
}
//--------------------------------------------------------
// show Advertising list
//--------------------------------------------------------
function showAdv(arg)
{
   var hdr = " Advertising List";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"

   html += "<tr><td class='Prompt3' colspan=2>&nbsp;</td></tr>"
   html += "<tr><td class='Prompt3' colspan=2><table class='DataTable' width='100%' cellPadding=0 cellSpacing=0>"
   html += "<tr class='TblHdr'><td class='DataTable'>Market</td>"
         + "<td class='DataTable'>Originating<br>Week</td>"
         + "<td class='DataTable'>Media</td>"
         + "<td class='DataTable'>Payee</td>"
         + "<td class='DataTable'>Description<br>Week</td>"
         + "<td class='DataTable'>Attached<br>Document</td>"
         + "</tr>"

   // load event documents
   for(var i=0, start = 0; i < AdvMkt[arg].length; i++)
   {
       html += "<tr class='DataTable2'><td class='DataTable'>" + AdvMkt[arg][i] + " - " +AdvMktName[arg][i] +  "</td>"
             + "<td class='DataTable'>" + AdvOrgWk[arg][i] + "</td>"
             + "<td class='DataTable'>" + AdvMedDesc[arg][i] + "</td>"
             + "<td class='DataTable'>" + AdvPayee[arg][i] + "</td>"
             + "<td class='DataTable'>" + AdvPDesc[arg][i] + "</td>"
             + "<td class='DataTable'>";
       if(AdvDoc[arg][i].trim() != "")
       {
          html += "<a target='_blank' href='Advertising/" + AdvDoc[arg][i] + "'>" + AdvDoc[arg][i] + "</a>"
       }
       else { html += "&nbsp;"
       }
       html += "</td></tr>"
   }

   if(AdvMkt[arg].length == 0) html += "<tr class='DataTable2'><td class='Prompt1' colspan=6>No Advertising attached to the event.</td></tr>"

   html += "</table></td></tr>"

   html += "<tr><td class='Prompt2' colspan=2>&nbsp;</td></tr>"
   html += "<tr><td class='Prompt3' colspan=2>"

   html += "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
      + "</table>"

   if(AdvMkt[arg].length < 10) document.all.dvPrompt.style.height = AdvMkt[arg].length * 25;

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.pixelLeft= document.documentElement.scrollLeft + 400;
   document.all.dvPrompt.style.pixelTop= document.documentElement.scrollTop + 130;
   document.all.dvPrompt.style.visibility = "visible";
}
//--------------------------------------
// show Event DetailsAdd, Update, Delete Event
//--------------------------------------------------------
function showEvent(arg)
{
   var hdr = Event[arg];

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popEvtPanel(arg)
     + "</tr></td>"
   + "</table>"

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.pixelLeft= document.documentElement.scrollLeft + 250;
   document.all.dvPrompt.style.pixelTop= document.documentElement.scrollTop + 120;
   document.all.dvPrompt.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popEvtPanel(arg)
{
  var posX = document.documentElement.scrollLeft + 100;
  var posY = document.documentElement.scrollTop + 140;

  var panel = "<table width='100%' cellPadding='0' cellSpacing='0'>"

  panel += "<tr><td class='Prompt2' nowrap>Event:</td><td class='Prompt2' nowrap>" + Event[arg] + "</td><tr>"
          + "<tr><td class='Prompt2' nowrap>From: </td><td class='Prompt2' nowrap>" + From[arg] + "</td></tr>"
          + "<tr><td class='Prompt2' nowrap>To: </td><td class='Prompt2' nowrap>" + To[arg] + "</td></tr>"

  panel += "<tr><td class='Prompt2' nowrap>Bike Focus:</td><td class='Prompt2' nowrap>" + EvtText[arg][0] + "</td></tr>"
          + "<tr><td class='Prompt2' nowrap>Perm MD Dates Effective:&nbsp;&nbsp;</td><td class='Prompt2'>" + EvtText[arg][1] + "</td></tr>"
          + "<tr><td class='Prompt2' nowrap>Perm MD Dates Packet:</td><td class='Prompt2' nowrap>" + EvtText[arg][2] + "</td></tr>"
          + "<tr><td class='Prompt2' nowrap>Stores:</td><td class='Prompt2' nowrap>" + EvtText[arg][3] + "</td></tr>"
          + "<tr><td class='Prompt2' nowrap>Outside Print Major Hang:&nbsp;&nbsp;</td><td class='Prompt2' nowrap>" + EvtText[arg][4] + "</td></tr>"
          + "<tr><td class='Prompt2' nowrap>Rci Produced:</td><td class='Prompt2' nowrap>" + EvtText[arg][5] + "</td></tr>"
          + "<tr><td class='Prompt2' nowrap>Ship To Stores:</td><td class='Prompt2' nowrap>" + EvtText[arg][7] + "</td></tr>"

  panel += "<tr><td class='Prompt3' colspan=6><button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}
//--------------------------------------------------------
// show Holiday
//--------------------------------------------------------
function showHol(hol, obj)
{
   var html = hol
   if (hol == "") document.all.dvHoliday.style.visibility = "hidden";
   else
   {
     var pos = getObjPosition(obj)
     document.all.dvHoliday.innerHTML = html;
     document.all.dvHoliday.style.pixelLeft= pos[0] + 10;
     document.all.dvHoliday.style.pixelTop= pos[1] - 10;
     document.all.dvHoliday.style.visibility = "visible";
   }
}
//--------------------------------------------------------
// get object position
//--------------------------------------------------------
function getObjPosition(obj)
{
   var pos = [0, 0]
   // position on the screen
   if (obj.offsetParent)
   {
     while (obj.offsetParent)
     {
       pos[0] += obj.offsetLeft
       pos[1] += obj.offsetTop
       obj = obj.offsetParent;
     }
   }
   else if (obj.x)
   {
     pos[0] += obj.x;
     pos[1] += obj.y;
   }
   return pos;
}
//--------------------------------------------------------
// show / hide Temerature
//--------------------------------------------------------
function showTemp()
{
    if(document.all.tblTemp.style.display!="none") document.all.tblTemp.style.display="none";
    else document.all.tblTemp.style.display="block";

}
//--------------------------------------------------------
// hilight temperature
//--------------------------------------------------------
function hiliDtlLine(line, hili)
{
   if(hili)
   {
     rowColor = line.style.backgroundColor;
     line.style.backgroundColor="white";
   }
   else line.style.backgroundColor=rowColor;
}
//--------------------------------------------------------
// hilight temperature
//--------------------------------------------------------
function hiliTempTbl(line, hili)
{
   if(hili) line.style.backgroundColor="white";
   else line.style.backgroundColor="#efefef";
}
//==============================================================================
// fold / unfold dayly and commulative percents
//==============================================================================
function showDlyComPrc(rowId, kioOnly)
{
  var grp = document.all.tdGrp;
  var line = document.all[rowId];
  var divdr = document.all.trDivider;

  var grp = 0;
  if(rowId=="tdPrc"){ grp=1; }
  else if(rowId=="tdKioskMemo" && kioOnly){ grp=2; }
  else if(rowId=="tdKioskMemo" && !kioOnly){ grp=3; }

  var disp = "none";
  Row = 1;

  //alert(grp + "\nPrcDisp: " + PrcDisp + "\nKioDisp: " + KioDisp + "\nKioStrDisp: " + KioStrDisp)

  if(grp==1 && !PrcDisp) { disp = "block"; PrcDisp = !PrcDisp; }
  else if(grp==1 && PrcDisp) { disp = "none"; PrcDisp = !PrcDisp; }
  else if(grp==2 && !KioDisp){ disp = "block"; KioDisp = !KioDisp;}
  else if(grp==2 && KioDisp){ disp = "none"; KioDisp = !KioDisp; KioStrDisp = false;}
  else if(grp==3 && !KioStrDisp){ disp = "block"; KioStrDisp = !KioStrDisp;}
  else if(grp==3 && KioStrDisp){ disp = "none"; KioStrDisp = !KioStrDisp; KioDisp = false; }

  //alert(grp + "\nPrcDisp: " + PrcDisp + "\nKioDisp: " + KioDisp + "\nKioStrDisp: " + KioStrDisp + "\n" + disp)

  // show/hide percentage
  for(var i=0; i < line.length; i++) { line[i].style.display = disp; }

  // show/hide store divider
  for(var i=0; i < divdr.length; i++) { divdr[i].style.display = disp; }

  // change row span for group column
  if  ( disp =="block" || document.all.tdPrc[0].style.display == "block"
       || document.all.tdKioskMemo[0].style.display == "block") { Row = 3;}
  for(var i=0; i < document.all.tdGrp.length; i++)
  {
    if(document.all.tdGrp[i].innerHTML.indexOf("DMM") < 0)
    {
       document.all.tdGrp[i].rowSpan = Row;
    }
    else if(document.all.tdGrp[i].innerHTML.indexOf("DMM") >= 0
         && document.all.tdPrc[0].style.display == "block" && Row > 1)
    {
       document.all.tdGrp[i].rowSpan = 2;
    }
    else if(document.all.tdGrp[i].innerHTML.indexOf("DMM") >= 0)
    {
       document.all.tdGrp[i].rowSpan = 1;
    }
  }


  for(var i=0; i < document.all.spKiosk.length; i++)
  {
     if(kioOnly)
     {
         document.all.spKiosk[i].style.display="block";
         document.all.spStrKiosk[i].style.display="none";
     }
     else
     {
         document.all.spKiosk[i].style.display="none";
         document.all.spStrKiosk[i].style.display="block";
     }
  }


}
//==============================================================================
// set ECOM Sales by sites
//==============================================================================
function setEcomSlsBySites()
{
   var url = "FlashSlsEcomDtl.jsp?Date=<%=sDate%>";

   //window.location.href = url
   window.frame4.location.href = url
}
//==============================================================================
// set ECOM Sales by sites
//==============================================================================
function showEComSlsBysite(site, tyamt, lyamt, prc)
{
   window.frame4.close();

   var hdr = "ECOM Sales By Sites";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hideEcomPanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popEcomSls(site, tyamt, lyamt, prc)
     + "</tr></td>"
   + "</table>"

   document.all.dvEcom.innerHTML = html;
   document.all.dvEcom.style.pixelLeft = document.documentElement.scrollLeft + 20;
   document.all.dvEcom.style.pixelTop = document.documentElement.scrollTop + 120;
   document.all.dvEcom.style.visibility = "visible";
}

//==============================================================================
// populate panel with ECOM sales by site
//==============================================================================
function popEcomSls(site, tyamt, lyamt, prc)
{
   var panel = "<table  class='DataTable' width='100%' cellPadding='0' cellSpacing='0'>"

   panel += "<tr class='TblHdr'><td class='DataTable31' rowspan=2>Site</td>"

   panel += "<td class='DataTable31' colspan=2>Monday</td>"
           + "<td class='DataTable31' colspan=2>Tuesday</td>"
           + "<td class='DataTable31' colspan=2>Wednesday</td>"
           + "<td class='DataTable31' colspan=2>Thursday</td>"
           + "<td class='DataTable31' colspan=2>Friday</td>"
           + "<td class='DataTable31' colspan=2>Saturday</td>"
           + "<td class='DataTable31' colspan=2>Sunday</td>"
           + "<td class='DataTable31' colspan=3 nowrap>Week To Date</td>"
           + "<td class='DataTable31' rowspan=2>LY<br>Week<br>Ending</td>"
           + "<td class='DataTable31' colspan=3 nowrap>Month To Date</td>"
           + "<td class='DataTable31' rowspan=2>LY<br>Month<br>Ending</td>"
           + "<td class='DataTable31' colspan=3 nowrap>Quater To Date</td>"
           + "<td class='DataTable31' colspan=3 nowrap>Year To Date</td>"
         + "</tr>"
         + "<tr class='TblHdr'>"
          + "<td class='DataTable3'>TY</td><td class='DataTable31'>LY</td>"
          + "<td class='DataTable3'>TY</td><td class='DataTable31'>LY</td>"
          + "<td class='DataTable3'>TY</td><td class='DataTable31'>LY</td>"
          + "<td class='DataTable3'>TY</td><td class='DataTable31'>LY</td>"
          + "<td class='DataTable3'>TY</td><td class='DataTable31'>LY</td>"
          + "<td class='DataTable3'>TY</td><td class='DataTable31'>LY</td>"
          + "<td class='DataTable3'>TY</td><td class='DataTable31'>LY</td>"
          + "<td class='DataTable3'>TY</td><td class='DataTable31'>LY</td><td class='DataTable31'>Var</td>"
          + "<td class='DataTable3'>TY</td><td class='DataTable31'>LY</td><td class='DataTable31'>Var</td>"
          + "<td class='DataTable3'>TY</td><td class='DataTable31'>LY</td><td class='DataTable31'>Var</td>"
          + "<td class='DataTable3'>TY</td><td class='DataTable31'>LY</td><td class='DataTable31'>Var</td>"
        + "<tr>"

   for(var i=0; i < site.length; i++)
   {
       if(site[i] != "Total") { panel += "<tr class='DataTable'>"; }
       else { panel += "<tr class='DataTable2'>"; }
       panel += "<td class='DataTable1' nowrap>" + site[i] + "</td>"

       for(var j=0; j < 13; j++)
       {
          if(j != 8 && j != 10) { panel += "<td class='DataTable4'>" + tyamt[i][j] + "</td>" }
          panel += "<td class='DataTable41'>" + lyamt[i][j] + "</td>"

          if(j == 7 || j == 9 || j == 11 || j == 12)
          {
             panel += "<td class='DataTable4' nowrap>" + prc[i][j] + "%</td>"
          }
       }
   }

   panel += "<tr><td class='Prompt3' colspan=30><button onClick='hideEcomPanel();' class='Small'>Close</button></td></tr>"
   panel += "</table>";
   return panel
}
//==============================================================================
// hide ecom panel
//==============================================================================
function hideEcomPanel()
{
   document.all.dvEcom.style.visibility = "hidden";
}

//==============================================================================
// get tool box
//==============================================================================
function getTool(obj, arg)
{
   var html = "Click here to <a href='javascript: hiliDiv(" + arg + ")'>hilight divisions</a>"
   document.all.dvTool.innerHTML = html;

   var pos = getObjPosition(obj)

   document.all.dvTool.style.pixelLeft = pos[0] - (-50);
   document.all.dvTool.style.pixelTop =  pos[1] - (-3);
   document.all.dvTool.style.visibility = "visible";
}
//==============================================================================
// hilight division
//==============================================================================
function hiliDiv(arg)
{
   //var cell = document.all.tdGrp;
   var row = document.all.trGrp;

   for(var i=0; i < row.length; i++)
   {
      var found = false;
      cell = row[i].childNodes[0];

      for(var j=0; j < DmmDiv[arg].length; j++)
      {
         var k = cell.innerHTML.indexOf("-");
         if (cell.innerHTML.substring(0, k-1).trim() == DmmDiv[arg][j])
         {
            cell.parentNode.style.background="wheat";
            found=true;
            break;
         }
      }
      if (!found){ row[i].style.background="#efefef"; }
   }
}
//==============================================================================
// hide ecom panel
//==============================================================================
function hideToolPanel()
{
   document.all.dvTool.style.visibility = "hidden";
}

</SCRIPT>

<!-------------------------------------------------------------------->
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<!-------------------------------------------------------------------->
</head>


<!-------------------------------------------------------------------->
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame2"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe id="frame3"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe id="frame4"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvPrompt" class="dvPrompt"></div>
<div id="dvHoliday" class="dvHoliday"></div>
<div id="dvEcom" class="dvEcom"></div>
<div id="dvTool" class="dvHoliday"></div>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
      <td ALIGN="left" VALIGN="TOP" width="10%" style="padding-left:10px;padding-top:3px; padding-right:10px;" nowrap>
        <div id="selBox" class="selBox" onClick="chgSelection()">
           <a href="javascript:chgSelection()">Report Selections</a>
           <br>Store: <b><%=sSelStrName%></b>
           <br>Div: <b><%=sSelDivName%></b>
           <br>Dpt: <b><%=sSelDptName%></b>
           <br>Class: <b><%=sSelClsName%></b>
           <br>Date: <b><%=sDate%></b></div>
      </td>
<!-------------------------------------------------------------------->

      <td ALIGN="center" VALIGN="TOP" nowrap>
        <b>Retail Concepts, Inc
        <br>Flash Sales Comparison Report: TY vs. <%=sCompName%>
        <br>Compare date Range <%=sTyDate[0]%> thru <%=sTyDate[6]%>
            to Range <%=sLyDate[0]%> thru <%=sLyDate[6]%>
        <br></b>
      </td>

      <td nowrap width="10%" style="text-align:right;font-size:10px; font-weigth:bold;">Elapse: <%=lElapse%> sec.</td>
    </tr>

     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>

      <a href="<%if(!bKiosk){%>index.jsp<%} else {%>Outsider.jsp<%}%>"><font color="red" size="-1">Home</font></a>&#62;
          <a href="FlashSalesUpto5PrYrSel.jsp"><font color="red" size="-1">Select Report</font></a>&#62;
          <font size="-1">This Page.</font> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

          <%if(bPrcAllows){%><a href="javascript: showDlyComPrc('tdPrc')"><font size="-1">fold/unfold daily/cumulative %</font></a><%}%>
          &nbsp; &nbsp; &nbsp; &nbsp;
          <%if(bKioskAllows){%>
            <!--a href="javascript: showDlyComPrc('tdKioskMemo', true)"><font size="-1">Kiosk Memo</font></a>
            <a href="javascript: showDlyComPrc('tdKioskMemo', false)"><font size="-1">Kiosk+Str Memo</font></a -->
          <%}%>
          <span  class="Small">
          <input class="Small" name="SelRepType" type="radio" onclick="sbmLyAvg(this)" value="LY">LY &nbsp;
          <input class="Small" name="SelRepType" type="radio" onclick="sbmLyAvg(this)" value="LY2">LY2 &nbsp;
          <input class="Small" name="SelRepType" type="radio" onclick="sbmLyAvg(this)" value="LY2A">LY2A &nbsp;
          <input class="Small" name="SelRepType" type="radio" onclick="sbmLyAvg(this)" value="LY3A">LY3A &nbsp;
          <input class="Small" name="SelRepType" type="radio" onclick="sbmLyAvg(this)" value="LY4A">LY4A &nbsp;
          <input class="Small" name="SelRepType" type="radio" onclick="sbmLyAvg(this)" value="LY5A">LY5A &nbsp;
          <%if ((sStore.equals("ALL")
                 || sStore.length() > 2 && sStore.substring(0, 3).equals("REG")
                 || sStore.length() > 2 && sStore.substring(0, 3).equals("RCS")
                 || sStore.length() > 3 && sStore.substring(0, 4).equals("MALL")
                 || sStore.length() > 3 && sStore.substring(0, 4).equals("COMP"))
                 && sDivision.equals("ALL") && sDepartment.equals("ALL") && sClass.equals("ALL"))
            {%>
             <input class="Small" name="SelRepType" type="radio" onclick="sbmLyAvg(this)" value="PLAN">Plan &nbsp;
          <%}%>
          </span>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0" width="100%">
        <tr class="TblHdr">
	  <td class="DataTable3"  rowspan="3">
            <a href="javascript:sortBy('GRP')"><%=sColName%></a><br><br>
             <%if  (sStore.equals("ALL")
                 || sStore.length() > 2 && sStore.substring(0, 3).equals("REG")
                 || sStore.length() > 2 && sStore.substring(0, 3).equals("RCS")
                 || sStore.length() > 3 && sStore.substring(0, 4).equals("MALL")
                 || sStore.length() > 3 && sStore.substring(0, 4).equals("COMP")){%>
                    <a href="javascript:reverseLevel()">(by <%=sDispBy%>)</a>
             <%}%>
          </td>
          <%if(sPeriod.substring(0, 3).equals("MTD")){%>
             <td class="DataTable31" colspan="2">Monday</td>
             <td class="DataTable31" colspan="2">Tuesday</td>
             <td class="DataTable31" colspan="2">Wednesday</td>
             <td class="DataTable31" colspan="2">Thursday</td>
             <td class="DataTable31" colspan="2">Friday</td>
             <td class="DataTable31" colspan="2">Saturday</td>
             <td class="DataTable31" colspan="2">Sunday</td>
             <td class="DataTable31" colspan="3">Week To Date</td>
             <td class="DataTable31" rowspan="3"><a href="javascript:sortBy('WKENDLY')"><%=sLyCol%><br>Week<br>Ending</a></td>
          <%}%>
          <td class="DataTable31" colspan="3">Month To Date</td>
          <td class="DataTable31" rowspan="3"><a href="javascript:sortBy('MNENDLY')"><%=sLyCol%><br>Month<br>Ending</a></td>

          <%if(sPeriod.substring(0, 3).equals("YTD")){%>
            <td class="DataTable31" colspan="3">Quarter To Date</td>
            <td class="DataTable31" colspan="3">Year To Date</td>
          <%}%>
          <td class="DataTable3"  rowspan="3"><%=sColName%></td>
        </tr>
        <tr class="TblHdr">
          <%if(sPeriod.substring(0, 3).equals("MTD")){%>
             <td class="DataTable3">TY</td>
             <td class="DataTable31"><%=sLyCol%></td>
             <td class="DataTable3">TY</td>
             <td class="DataTable31"><%=sLyCol%></td>
             <td class="DataTable3">TY</td>
             <td class="DataTable31"><%=sLyCol%></td>
             <td class="DataTable3">TY</td>
             <td class="DataTable31"><%=sLyCol%></td>
             <td class="DataTable3">TY</td>
             <td class="DataTable31"><%=sLyCol%></td>
             <td class="DataTable3">TY</td>
             <td class="DataTable31"><%=sLyCol%></td>
             <td class="DataTable3">TY</td>
             <td class="DataTable31"><%=sLyCol%></td>

             <td class="DataTable3" rowspan="2"><a href="javascript:sortBy('WTDTY')">TY</a></td>
             <td class="DataTable3" rowspan="2"><a href="javascript:sortBy('WTDLY')"><%=sLyCol%></a></td>
             <td class="DataTable31" rowspan="2"><a href="javascript:sortBy('WTDVAR')">Var</a></td>
          <%}%>
          <td class="DataTable3" rowspan="2"><a href="javascript:sortBy('MTDTY')">TY</a></td>
          <td class="DataTable3" rowspan="2"><a href="javascript:sortBy('MTDLY')"><%=sLyCol%></a></td>
          <td class="DataTable31" rowspan="2"><a href="javascript:sortBy('MTDVAR')">Var</a></td>
          <%if(sPeriod.substring(0, 3).equals("YTD")){%>
             <td class="DataTable3" rowspan="2"><a href="javascript:sortBy('QTDTY')">TY</a></td>
             <td class="DataTable3" rowspan="2"><a href="javascript:sortBy('QTDLY')"><%=sLyCol%></a></td>
             <td class="DataTable31" rowspan="2"><a href="javascript:sortBy('QTDVAR')">Var</a></td>
             <td class="DataTable3" rowspan="2"><a href="javascript:sortBy('YTDTY')">TY</a></td>
             <td class="DataTable3" rowspan="2"><a href="javascript:sortBy('YTDLY')"><%=sLyCol%></a></td>
             <td class="DataTable31" rowspan="2"><a href="javascript:sortBy('YTDVAR')">Var</a></td>
          <%}%>
        </tr>
        <tr class="TblHdr">
         <%if(sPeriod.substring(0, 3).equals("MTD")){%>
            <td class="DataTable3<%if(!sTyHol[0].equals("")){%>2<%}%>" onmouseover="showHol(&#34;<%=sTyHol[0]%>&#34;, this)"><%=sTyDate[0].substring(0,5)%></td>
            <td class="DataTable31<%if(!sLyHol[0].equals("")){%>2<%}%>" onmouseover="showHol(&#34;<%=sLyHol[0]%>&#34;, this)"><%=sLyDate[0].substring(0,5)%></td>
            <td class="DataTable3<%if(!sTyHol[1].equals("")){%>2<%}%>" onmouseover="showHol(&#34;<%=sTyHol[1]%>&#34;, this)"><%=sTyDate[1].substring(0,5)%></td>
            <td class="DataTable31<%if(!sLyHol[1].equals("")){%>2<%}%>" onmouseover="showHol(&#34;<%=sLyHol[1]%>&#34;, this)"><%=sLyDate[1].substring(0,5)%></td>
            <td class="DataTable3<%if(!sTyHol[2].equals("")){%>2<%}%>" onmouseover="showHol(&#34;<%=sTyHol[2]%>&#34;, this)"><%=sTyDate[2].substring(0,5)%></td>
            <td class="DataTable31<%if(!sLyHol[2].equals("")){%>2<%}%>" onmouseover="showHol(&#34;<%=sLyHol[2]%>&#34;, this)"><%=sLyDate[2].substring(0,5)%></td>
            <td class="DataTable3<%if(!sTyHol[3].equals("")){%>2<%}%>" onmouseover="showHol(&#34;<%=sTyHol[3]%>&#34;, this)"><%=sTyDate[3].substring(0,5)%></td>
            <td class="DataTable31<%if(!sLyHol[3].equals("")){%>2<%}%>" onmouseover="showHol(&#34;<%=sLyHol[3]%>&#34;, this)"><%=sLyDate[3].substring(0,5)%></td>
            <td class="DataTable3<%if(!sTyHol[4].equals("")){%>2<%}%>" onmouseover="showHol(&#34;<%=sTyHol[4]%>&#34;, this)"><%=sTyDate[4].substring(0,5)%></td>
            <td class="DataTable31<%if(!sLyHol[4].equals("")){%>2<%}%>" onmouseover="showHol(&#34;<%=sLyHol[4]%>&#34;, this)"><%=sLyDate[4].substring(0,5)%></td>
            <td class="DataTable3<%if(!sTyHol[5].equals("")){%>2<%}%>" onmouseover="showHol(&#34;<%=sTyHol[5]%>&#34;, this)"><%=sTyDate[5].substring(0,5)%></td>
            <td class="DataTable31<%if(!sLyHol[5].equals("")){%>2<%}%>" onmouseover="showHol(&#34;<%=sLyHol[5]%>&#34;, this)"><%=sLyDate[5].substring(0,5)%></td>
            <td class="DataTable3<%if(!sTyHol[6].equals("")){%>2<%}%>" onmouseover="showHol(&#34;<%=sTyHol[6]%>&#34;, this)"><%=sTyDate[6].substring(0,5)%></td>
            <td class="DataTable31<%if(!sLyHol[6].equals("")){%>2<%}%>" onmouseover="showHol(&#34;<%=sLyHol[6]%>&#34;, this)"><%=sLyDate[6].substring(0,5)%></td>
          <%}%>
        </tr>
<!------------------------------- Data Detail --------------------------------->
      <%for(int i=0, str=0, reg=0; i < iNumOfGrp; i++) {%>
        <tr class="DataTable" id="trGrp" onmouseover="hiliDtlLine(this, true)" onmouseout="hiliDtlLine(this, false)">
           <%if(!sLevel.equals("T") && !sLevel.equals("V") && sPeriod.indexOf("PLAN") < 0  && (!sLevel.substring(0, 1).equals("C") || sStore.equals("ALL")) ) {%>
               <td class="DataTable5" id="tdGrp" rowspan=3 onClick="drillDown('<%=sGrp[i]%>')"  nowrap>
                <%=sGrp[i] + " - " + sGrpName[i].substring(0, 15)%></td>
           <%}
           else {%><td class="DataTable1" id="tdGrp" rowspan=3 nowrap><%=sGrp[i] + " - " + sGrpName[i].substring(0, 8)%></td><%}%>

         <%if(sPeriod.substring(0, 3).equals("MTD")){%>
           <td class="DataTable4" <%if(sBrkTyDt[i][0].equals("1")){%>style="color:red"<%}%>><%=sTySls[i][0]%></td>
           <td class="DataTable41" <%if(sBrkLyDt[i][0].equals("1")){%>style="color:red"<%}%>><%=sLySls[i][0]%></td>
           <td class="DataTable4" <%if(sBrkTyDt[i][1].equals("1")){%>style="color:red"<%}%>><%=sTySls[i][1]%></td>
           <td class="DataTable41" <%if(sBrkLyDt[i][1].equals("1")){%>style="color:red"<%}%>><%=sLySls[i][1]%></td>
           <td class="DataTable4" <%if(sBrkTyDt[i][2].equals("1")){%>style="color:red"<%}%>><%=sTySls[i][2]%></td>
           <td class="DataTable41" <%if(sBrkLyDt[i][2].equals("1")){%>style="color:red"<%}%>><%=sLySls[i][2]%></td>
           <td class="DataTable4" <%if(sBrkTyDt[i][3].equals("1")){%>style="color:red"<%}%>><%=sTySls[i][3]%></td>
           <td class="DataTable41" <%if(sBrkLyDt[i][3].equals("1")){%>style="color:red"<%}%>><%=sLySls[i][3]%></td>
           <td class="DataTable4" <%if(sBrkTyDt[i][4].equals("1")){%>style="color:red"<%}%>><%=sTySls[i][4]%></td>
           <td class="DataTable41" <%if(sBrkLyDt[i][4].equals("1")){%>style="color:red"<%}%>><%=sLySls[i][4]%></td>
           <td class="DataTable4" <%if(sBrkTyDt[i][5].equals("1")){%>style="color:red"<%}%>><%=sTySls[i][5]%></td>
           <td class="DataTable41" <%if(sBrkLyDt[i][5].equals("1")){%>style="color:red"<%}%>><%=sLySls[i][5]%></td>
           <td class="DataTable4" <%if(sBrkTyDt[i][6].equals("1")){%>style="color:red"<%}%>><%=sTySls[i][6]%></td>
           <td class="DataTable41" <%if(sBrkLyDt[i][6].equals("1")){%>style="color:red"<%}%>><%=sLySls[i][6]%></td>

           <td class="DataTable4"><%=sTySls[i][7]%></td>
           <td class="DataTable4"><%=sLySls[i][7]%></td>
           <td class="DataTable41" nowrap><%=sDlyPrc[i][7]%>%</td>
           <td class="DataTable41"><%=sLySls[i][8]%></td>
         <%}%>

           <td class="DataTable4"><%=sTySls[i][9]%></td>
           <td class="DataTable4"><%=sLySls[i][9]%></td>
           <td class="DataTable41" nowrap><%=sDlyPrc[i][9]%>%</td>
           <td class="DataTable41"><%=sLySls[i][10]%></td>

        <%if(sPeriod.substring(0, 3).equals("YTD")){%>
           <td class="DataTable4"><%=sTySls[i][11]%></td>
           <td class="DataTable4"><%=sLySls[i][11]%></td>
           <td class="DataTable41" nowrap><%=sDlyPrc[i][11]%>%</td>

           <td class="DataTable4"><%=sTySls[i][12]%></td>
           <td class="DataTable4"><%=sLySls[i][12]%></td>
           <td class="DataTable41" nowrap><%=sDlyPrc[i][12]%>%</td>
        <%}%>

           <td class="DataTable41" id="tdGrp" rowspan=3><%=sGrp[i]%></td>
        </tr>

        <!-- Percents is allowed  -->
           <tr class="DataTable">
              <%if(sPeriod.substring(0, 3).equals("MTD")){%>
                <td class="DataTable4" id="tdPrc" nowrap><%=sDlyPrc[i][0]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sComPrc[i][0]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sDlyPrc[i][1]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sComPrc[i][1]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sDlyPrc[i][2]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sComPrc[i][2]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sDlyPrc[i][3]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sComPrc[i][3]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sDlyPrc[i][4]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sComPrc[i][4]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sDlyPrc[i][5]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sComPrc[i][5]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sDlyPrc[i][6]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sComPrc[i][6]%>%</td>
                <td class="DataTable41" id="tdPrc" colspan=8>&nbsp;</td>
              <%}%>
           </tr>

        <!-- Kiosk -->
        <tr class="DataTable">
           <%if(sPeriod.substring(0, 3).equals("MTD")){%>
              <%for(int j=0; j < 7; j++){%>
                 <td class="DataTable4" id="tdKioskMemo" nowrap><span id="spKiosk">$<%=sTyKio[i][j]%></span><span id="spStrKiosk">$<%=sTyStrKio[i][j]%></span></td>
                 <td class="DataTable41" id="tdKioskMemo" nowrap><span id="spKiosk">$<%=sLyKio[i][j]%></span><span id="spStrKiosk">$<%=sLyKio[i][j]%></span></td>
              <%}%>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sTyKio[i][7]%></span><span id="spStrKiosk"><%=sTyStrKio[i][7]%></span></td>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sLyKio[i][7]%></span><span id="spStrKiosk"><%=sLyStrKio[i][7]%></span></td>
              <td class="DataTable41" id="tdKioskMemo">&nbsp;</td>

              <td class="DataTable41" id="tdKioskMemo"><span id="spKiosk"><%=sLyKio[i][8]%></span><span id="spStrKiosk"><%=sLyStrKio[i][8]%></span></td>
           <%}%>
           <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sTyKio[i][9]%></span><span id="spStrKiosk"><%=sTyStrKio[i][9]%></span></td>
           <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sLyKio[i][9]%></span><span id="spStrKiosk"><%=sLyStrKio[i][9]%></span></td>
           <td class="DataTable41" id="tdKioskMemo">&nbsp;</td>

           <td class="DataTable41" id="tdKioskMemo"><span id="spKiosk"><%=sLyKio[i][10]%></span><span id="spStrKiosk"><%=sLyStrKio[i][10]%></span></td>
           <%if(sPeriod.substring(0, 3).equals("YTD")){%>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sTyKio[i][11]%></span><span id="spStrKiosk"><%=sTyStrKio[i][11]%></span></td>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sLyKio[i][11]%></span><span id="spStrKiosk"><%=sLyStrKio[i][11]%></span></td>
              <td class="DataTable41" id="tdKioskMemo" nowrap>&nbsp;</td>

              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sTyKio[i][12]%></span><span id="spStrKiosk"><%=sTyStrKio[i][12]%></span></td>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sLyKio[i][12]%></span><span id="spStrKiosk"><%=sLyStrKio[i][12]%></span></td>
              <td class="DataTable41" id="tdKioskMemo" nowrap>&nbsp;</td>
           <%}%>
        </tr>

        <!-- Store Divider -->
           <tr class="DataTable4" id="trDivider"><td class="DataTable2" colspan="24">&nbsp;</td></tr>

        <%if(sLevel.equals("S") && sSort.equals("GRP")) {%>
           <%//if(reg < iNumOfReg-1 && iNumOfStrInReg[reg] == str+1)
             if(reg < iNumOfReg-1 && i < iNumOfGrp-1 && !sGrpReg[i].equals(sGrpReg[i + 1])) {
           %>
              <tr class="DataTable4"><td class="DataTable2" colspan="24">&nbsp;</td></tr>
           <%  str = 0; reg++;
             } else { str++; }
           %>

        <%}%>
      <%}%>
      <!------------------------ End Details ---------------------------------->
      <!------------------- Mall/Non-Mall Total or Non/-Ski Total ------------->
    <%if(sStore.equals("ALL") && sLevel.equals("S")){%>
      <%for(int i=0; i < 2; i++) {%>
        <tr class="DataTable5">
           <%if(sStore.equals("ALL") && sLevel.equals("S")){%>
                 <td class="DataTable6" id="tdGrp" rowspan=3  onClick="drillDown('<%if(i==0){%>MALLY<%} else {%>MALLN<%}%>')"><%=sMall[i]%></td>
           <%} else {%>
                 <td class="DataTable4" id="tdGrp" rowspan=3><%=sMall[i]%></td>
           <%}%>
         <%if(sPeriod.substring(0, 3).equals("MTD")){%>
           <td class="DataTable4"><%=sMallTySls[i][0]%></td>
           <td class="DataTable41"><%=sMallLySls[i][0]%></td>
           <td class="DataTable4"><%=sMallTySls[i][1]%></td>
           <td class="DataTable41"><%=sMallLySls[i][1]%></td>
           <td class="DataTable4"><%=sMallTySls[i][2]%></td>
           <td class="DataTable41"><%=sMallLySls[i][2]%></td>
           <td class="DataTable4"><%=sMallTySls[i][3]%></td>
           <td class="DataTable41"><%=sMallLySls[i][3]%></td>
           <td class="DataTable4"><%=sMallTySls[i][4]%></td>
           <td class="DataTable41"><%=sMallLySls[i][4]%></td>
           <td class="DataTable4"><%=sMallTySls[i][5]%></td>
           <td class="DataTable41"><%=sMallLySls[i][5]%></td>
           <td class="DataTable4"><%=sMallTySls[i][6]%></td>
           <td class="DataTable41"><%=sMallLySls[i][6]%></td>

           <td class="DataTable4"><%=sMallTySls[i][7]%></td>
           <td class="DataTable4"><%=sMallLySls[i][7]%></td>
           <td class="DataTable41"><%=sMallDlyPrc[i][7]%>%</td>
           <td class="DataTable41"><%=sMallLySls[i][8]%></td>
         <%}%>

           <td class="DataTable4"><%=sMallTySls[i][9]%></td>
           <td class="DataTable4"><%=sMallLySls[i][9]%></td>
           <td class="DataTable41"><%=sMallDlyPrc[i][9]%>%</td>
           <td class="DataTable41"><%=sMallLySls[i][10]%></td>

         <%if(sPeriod.substring(0, 3).equals("YTD")){%>
           <td class="DataTable4"><%=sMallTySls[i][11]%></td>
           <td class="DataTable4"><%=sMallLySls[i][11]%></td>
           <td class="DataTable41"><%=sMallDlyPrc[i][11]%>%</td>
           <td class="DataTable4"><%=sMallTySls[i][12]%></td>
           <td class="DataTable4"><%=sMallLySls[i][12]%></td>
           <td class="DataTable41"><%=sMallDlyPrc[i][12]%>%</td>
         <%}%>

           <td class="DataTable41" id="tdGrp" rowspan=3 ><%=sMall[i]%></td>
        </tr>

        <!-- Percents is allowed  -->
           <tr class="DataTable5">
              <%if(sPeriod.substring(0, 3).equals("MTD")){%>
                <td class="DataTable4" id="tdPrc" nowrap><%=sMallDlyPrc[i][0]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sMallComPrc[i][0]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sMallDlyPrc[i][1]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sMallComPrc[i][1]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sMallDlyPrc[i][2]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sMallComPrc[i][2]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sMallDlyPrc[i][3]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sMallComPrc[i][3]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sMallDlyPrc[i][4]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sMallComPrc[i][4]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sMallDlyPrc[i][5]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sMallComPrc[i][5]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sMallDlyPrc[i][6]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sMallComPrc[i][6]%>%</td>
                <td class="DataTable41" id="tdPrc" colspan=8>&nbsp;</td>
              <%}%>
           </tr>
        <!-- Kiosk -->
        <tr class="DataTable5">
           <%if(sPeriod.substring(0, 3).equals("MTD")){%>
              <%for(int j=0; j < 7; j++){%>
                 <td class="DataTable4" id="tdKioskMemo" nowrap><span id="spKiosk">$<%=sMallTyKio[i][j]%></span><span id="spStrKiosk">$<%=sMallTyStrKio[i][j]%></td>
                 <td class="DataTable41" id="tdKioskMemo" nowrap><span id="spKiosk">$<%=sMallLyKio[i][j]%></span><span id="spStrKiosk">$<%=sMallLyStrKio[i][j]%></span></td>
              <%}%>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sMallTyKio[i][7]%></span><span id="spStrKiosk"><%=sMallTyStrKio[i][7]%></span></td>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sMallLyKio[i][7]%></span><span id="spStrKiosk"><%=sMallLyStrKio[i][7]%></span></td>
              <td class="DataTable41" id="tdKioskMemo">&nbsp;</td>

              <td class="DataTable41" id="tdKioskMemo"><span id="spKiosk"><%=sMallLyKio[i][8]%></span><span id="spStrKiosk"><%=sMallLyStrKio[i][8]%></span></td>
           <%}%>

           <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sMallTyKio[i][9]%></span><span id="spStrKiosk"><%=sMallTyStrKio[i][9]%></span></td>
           <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sMallLyKio[i][9]%></span><span id="spStrKiosk"><%=sMallLyStrKio[i][9]%></span></td>
           <td class="DataTable41" id="tdKioskMemo">&nbsp;</td>

           <td class="DataTable41" id="tdKioskMemo"><span id="spKiosk"><%=sMallLyKio[i][10]%></span><span id="spStrKiosk"><%=sMallLyStrKio[i][10]%></span></td>
           <%if(sPeriod.substring(0, 3).equals("YTD")){%>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sMallTyKio[i][11]%></span><span id="spStrKiosk"><%=sMallTyStrKio[i][11]%></span></td>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sMallLyKio[i][11]%></span><span id="spStrKiosk"><%=sMallLyStrKio[i][11]%></span></td>
              <td class="DataTable41" id="tdKioskMemo" nowrap>&nbsp;</td>

              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sMallTyKio[i][12]%></span><span id="spStrKiosk"><%=sMallTyStrKio[i][12]%></span></td>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sMallLyKio[i][12]%></span><span id="spStrKiosk"><%=sMallLyStrKio[i][12]%></span></td>
              <td class="DataTable41" id="tdKioskMemo" nowrap>&nbsp;</td>
           <%}%>

        </tr>
      <%}%>
    <%}%>
    <!------------------- End  Non/-Ski Total ------------------------------->


    <!------------------- DMM Category Totals --------------------------------->
    <%if(!sPeriod.substring(5).equals("PLAN")  && sDivision.equals("ALL") && !sLevel.equals("T") && !sLevel.equals("V")){%>
      <%for(int i=0; i < iNumOfDmm; i++) {%>
        <tr class="DataTable6" style="background:<%=sDmmColor[i]%>;">

         <td class="DataTable6" <%if(sLevel.equals("D")) {%> onMouseOver="getTool(this, '<%=i%>')"<%}%>
           id="tdGrpDMM" onClick="drillDown('DM<%=sDmmCode[i]%>')"><%=sDmmCat[i]%></td>
         <%if(sPeriod.substring(0, 3).equals("MTD")){%>
           <td class="DataTable4"><%=sDmmTySls[i][0]%></td>
           <td class="DataTable41"><%=sDmmLySls[i][0]%></td>
           <td class="DataTable4"><%=sDmmTySls[i][1]%></td>
           <td class="DataTable41"><%=sDmmLySls[i][1]%></td>
           <td class="DataTable4"><%=sDmmTySls[i][2]%></td>
           <td class="DataTable41"><%=sDmmLySls[i][2]%></td>
           <td class="DataTable4"><%=sDmmTySls[i][3]%></td>
           <td class="DataTable41"><%=sDmmLySls[i][3]%></td>
           <td class="DataTable4"><%=sDmmTySls[i][4]%></td>
           <td class="DataTable41"><%=sDmmLySls[i][4]%></td>
           <td class="DataTable4"><%=sDmmTySls[i][5]%></td>
           <td class="DataTable41"><%=sDmmLySls[i][5]%></td>
           <td class="DataTable4"><%=sDmmTySls[i][6]%></td>
           <td class="DataTable41"><%=sDmmLySls[i][6]%></td>

           <td class="DataTable4"><%=sDmmTySls[i][7]%></td>
           <td class="DataTable4"><%=sDmmLySls[i][7]%></td>
           <td class="DataTable41"><%=sDmmDlyPrc[i][7]%>%</td>
           <td class="DataTable41"><%=sDmmLySls[i][8]%></td>
         <%}%>

           <td class="DataTable4"><%=sDmmTySls[i][9]%></td>
           <td class="DataTable4"><%=sDmmLySls[i][9]%></td>
           <td class="DataTable41"><%=sDmmDlyPrc[i][9]%>%</td>
           <td class="DataTable41"><%=sDmmLySls[i][10]%></td>

         <%if(sPeriod.substring(0, 3).equals("YTD")){%>
           <td class="DataTable4"><%=sDmmTySls[i][11]%></td>
           <td class="DataTable4"><%=sDmmLySls[i][11]%></td>
           <td class="DataTable41"><%=sDmmDlyPrc[i][11]%>%</td>
           <td class="DataTable4"><%=sDmmTySls[i][12]%></td>
           <td class="DataTable4"><%=sDmmLySls[i][12]%></td>
           <td class="DataTable41"><%=sDmmDlyPrc[i][12]%>%</td>
         <%}%>

         <td class="DataTable41" id="tdGrpDMM"><%=sDmmCat[i]%></td>
        </tr>

        <!-- Percents is allowed  -->
           <!--tr class="DataTable6" id="tdPrc" style="background:<%=sDmmColor[i]%>;">
              <%if(sPeriod.substring(0, 3).equals("MTD")){%>
                <td class="DataTable4" nowrap><%=sDmmDlyPrc[i][0]%>%</td>
                <td class="DataTable41" nowrap><%=sDmmComPrc[i][0]%>%</td>
                <td class="DataTable4" nowrap><%=sDmmDlyPrc[i][1]%>%</td>
                <td class="DataTable41"nowrap><%=sDmmComPrc[i][1]%>%</td>
                <td class="DataTable4" nowrap><%=sDmmDlyPrc[i][2]%>%</td>
                <td class="DataTable41"nowrap><%=sDmmComPrc[i][2]%>%</td>
                <td class="DataTable4" nowrap><%=sDmmDlyPrc[i][3]%>%</td>
                <td class="DataTable41"nowrap><%=sDmmComPrc[i][3]%>%</td>
                <td class="DataTable4" nowrap><%=sDmmDlyPrc[i][4]%>%</td>
                <td class="DataTable41" nowrap><%=sDmmComPrc[i][4]%>%</td>
                <td class="DataTable4" nowrap><%=sDmmDlyPrc[i][5]%>%</td>
                <td class="DataTable41" nowrap><%=sDmmComPrc[i][5]%>%</td>
                <td class="DataTable4" nowrap><%=sDmmDlyPrc[i][6]%>%</td>
                <td class="DataTable41" nowrap><%=sDmmComPrc[i][6]%>%</td>
                <td class="DataTable41" colspan=8>&nbsp;</td>
              <%}%>
           </tr-->
      <%}%>
    <%}%>
    <!------------------- End  Non/-Ski Total ------------------------------->

    <!------------------- Regional Total ------------------------------------>
    <%if(sLevel.equals("S") && !sStore.substring(0, 3).equals("RCS")) {%>
      <%for(int i=0; i < iNumOfReg; i++) {%>
        <tr class="DataTable1">
           <%if(sStore.substring(0, 3).equals("ALL") || sStore.substring(0, 4).equals("COMP")){%>
              <td class="DataTable6" id="tdGrp" nowrap rowspan=3  onClick="drillDown('REG<%=sReg[i]%>')">District <%=sReg[i]%></td>
           <%} else {%>
               <td class="DataTable44" id="tdGrp" nowrap rowspan=3>District <%=sReg[i]%></td>
           <%}%>
         <%if(sPeriod.substring(0, 3).equals("MTD")){%>
           <td class="DataTable4"><%=sRegTySls[i][0]%></td>
           <td class="DataTable41"><%=sRegLySls[i][0]%></td>
           <td class="DataTable4"><%=sRegTySls[i][1]%></td>
           <td class="DataTable41"><%=sRegLySls[i][1]%></td>
           <td class="DataTable4"><%=sRegTySls[i][2]%></td>
           <td class="DataTable41"><%=sRegLySls[i][2]%></td>
           <td class="DataTable4"><%=sRegTySls[i][3]%></td>
           <td class="DataTable41"><%=sRegLySls[i][3]%></td>
           <td class="DataTable4"><%=sRegTySls[i][4]%></td>
           <td class="DataTable41"><%=sRegLySls[i][4]%></td>
           <td class="DataTable4"><%=sRegTySls[i][5]%></td>
           <td class="DataTable41"><%=sRegLySls[i][5]%></td>
           <td class="DataTable4"><%=sRegTySls[i][6]%></td>
           <td class="DataTable41"><%=sRegLySls[i][6]%></td>

           <td class="DataTable4"><%=sRegTySls[i][7]%></td>
           <td class="DataTable4"><%=sRegLySls[i][7]%></td>
           <td class="DataTable41"><%=sRegDlyPrc[i][7]%>%</td>
           <td class="DataTable41"><%=sRegLySls[i][8]%></td>
         <%}%>

           <td class="DataTable4"><%=sRegTySls[i][9]%></td>
           <td class="DataTable4"><%=sRegLySls[i][9]%></td>
           <td class="DataTable41"><%=sRegDlyPrc[i][9]%>%</td>
           <td class="DataTable41"><%=sRegLySls[i][10]%></td>

         <%if(sPeriod.substring(0, 3).equals("YTD")){%>
           <td class="DataTable4"><%=sRegTySls[i][11]%></td>
           <td class="DataTable4"><%=sRegLySls[i][11]%></td>
           <td class="DataTable41"><%=sRegDlyPrc[i][11]%>%</td>

           <td class="DataTable4"><%=sRegTySls[i][12]%></td>
           <td class="DataTable4"><%=sRegLySls[i][12]%></td>
           <td class="DataTable41"><%=sRegDlyPrc[i][12]%>%</td>
         <%}%>

           <td class="DataTable4" id="tdGrp" nowrap rowspan=3 >District <%=sReg[i]%></td>
        </tr>

        <!-- Percents is allowed  -->
           <tr class="DataTable1">
              <%if(sPeriod.substring(0, 3).equals("MTD")){%>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRegDlyPrc[i][0]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sRegComPrc[i][0]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRegDlyPrc[i][1]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sRegComPrc[i][1]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRegDlyPrc[i][2]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sRegComPrc[i][2]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRegDlyPrc[i][3]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sRegComPrc[i][3]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRegDlyPrc[i][4]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sRegComPrc[i][4]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRegDlyPrc[i][5]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sRegComPrc[i][5]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRegDlyPrc[i][6]%>%</td>
                <td class="DataTable41" id="tdPrc"><%=sRegComPrc[i][6]%>%</td>
                <td class="DataTable41" id="tdPrc" colspan=8>&nbsp;</td>
              <%}%>
           </tr>
        <!-- Kiosk -->
        <tr class="DataTable1">
          <%if(sPeriod.substring(0, 3).equals("MTD")){%>
              <%for(int j=0; j < 7; j++){%>
                 <td class="DataTable4" id="tdKioskMemo" nowrap><span id="spKiosk">$<%=sRegTyKio[i][j]%></span><span id="spStrKiosk">$<%=sRegTyStrKio[i][j]%></span></td>
                 <td class="DataTable41" id="tdKioskMemo" nowrap><span id="spKiosk">$<%=sRegLyKio[i][j]%></span><span id="spStrKiosk">$<%=sRegLyStrKio[i][j]%></span></td>
              <%}%>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRegTyKio[i][7]%></span><span id="spStrKiosk"><%=sRegTyStrKio[i][7]%></span></td>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRegLyKio[i][7]%></span><span id="spStrKiosk"><%=sRegLyStrKio[i][7]%></span></td>
              <td class="DataTable41" id="tdKioskMemo">&nbsp;</td>

             <td class="DataTable41" id="tdKioskMemo"><span id="spKiosk"><%=sRegLyKio[i][8]%></span><span id="spStrKiosk"><%=sRegLyStrKio[i][8]%></span></td>
           <%}%>

           <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRegTyKio[i][9]%></span><span id="spStrKiosk"><%=sRegTyStrKio[i][9]%></span></td>
           <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRegLyKio[i][9]%></span><span id="spStrKiosk"><%=sRegLyStrKio[i][9]%></span></td>
           <td class="DataTable41" id="tdKioskMemo">&nbsp;</td>

           <td class="DataTable41" id="tdKioskMemo"><span id="spKiosk"><%=sRegLyKio[i][10]%></span><span id="spStrKiosk"><%=sRegLyStrKio[i][10]%></span></td>
           <%if(sPeriod.substring(0, 3).equals("YTD")){%>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRegTyKio[i][11]%></span><span id="spStrKiosk"><%=sRegTyStrKio[i][11]%></span></td>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRegLyKio[i][11]%></span><span id="spStrKiosk"><%=sRegLyStrKio[i][11]%></span></td>
              <td class="DataTable41" id="tdKioskMemo" nowrap>&nbsp;</td>

              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRegTyKio[i][12]%></span><span id="spStrKiosk"><%=sRegTyStrKio[i][12]%></span></td>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRegLyKio[i][12]%></span><span id="spStrKiosk"><%=sRegLyStrKio[i][12]%></span></td>
              <td class="DataTable41" id="tdKioskMemo" nowrap>&nbsp;</td>
           <%}%>
        </tr>
      <%}%>
    <%}%>


    <!------------------ Regional Total for Comp Store ------------------------>
    <%if(sLevel.equals("S")) {%>
      <%for(int i=0; i < iNumOfReg; i++) {%>
        <tr class="DataTable1">

         <%if(sStore.substring(0, 3).equals("ALL")){%>
              <td class="DataTable6" id="tdGrp" rowspan=3 nowrap onClick="drillDown('RCS<%=sReg[i]%>')">District <%=sReg[i]%>(Comp Str)</td>
           <%} else {%>
               <td class="DataTable44" id="tdGrp" nowrap rowspan=3>District <%=sReg[i]%>(Comp Str)</td>
           <%}%>

         <%if(sPeriod.substring(0, 3).equals("MTD")){%>
           <td class="DataTable4"><%=sRegCompTySls[i][0]%></td>
           <td class="DataTable41"><%=sRegCompLySls[i][0]%></td>
           <td class="DataTable4"><%=sRegCompTySls[i][1]%></td>
           <td class="DataTable41"><%=sRegCompLySls[i][1]%></td>
           <td class="DataTable4"><%=sRegCompTySls[i][2]%></td>
           <td class="DataTable41"><%=sRegCompLySls[i][2]%></td>
           <td class="DataTable4"><%=sRegCompTySls[i][3]%></td>
           <td class="DataTable41"><%=sRegCompLySls[i][3]%></td>
           <td class="DataTable4"><%=sRegCompTySls[i][4]%></td>
           <td class="DataTable41"><%=sRegCompLySls[i][4]%></td>
           <td class="DataTable4"><%=sRegCompTySls[i][5]%></td>
           <td class="DataTable41"><%=sRegCompLySls[i][5]%></td>
           <td class="DataTable4"><%=sRegCompTySls[i][6]%></td>
           <td class="DataTable41"><%=sRegCompLySls[i][6]%></td>

           <td class="DataTable4"><%=sRegCompTySls[i][7]%></td>
           <td class="DataTable4"><%=sRegCompLySls[i][7]%></td>
           <td class="DataTable41"><%=sRegCompDlyPrc[i][7]%>%</td>
           <td class="DataTable41"><%=sRegCompLySls[i][8]%></td>
         <%}%>

           <td class="DataTable4"><%=sRegCompTySls[i][9]%></td>
           <td class="DataTable4"><%=sRegCompLySls[i][9]%></td>
           <td class="DataTable41"><%=sRegCompDlyPrc[i][9]%>%</td>
           <td class="DataTable41"><%=sRegCompLySls[i][10]%></td>

         <%if(sPeriod.substring(0, 3).equals("YTD")){%>
           <td class="DataTable4"><%=sRegCompTySls[i][11]%></td>
           <td class="DataTable4"><%=sRegCompLySls[i][11]%></td>
           <td class="DataTable41"><%=sRegCompDlyPrc[i][11]%>%</td>

           <td class="DataTable4"><%=sRegCompTySls[i][12]%></td>
           <td class="DataTable4"><%=sRegCompLySls[i][12]%></td>
           <td class="DataTable41"><%=sRegCompDlyPrc[i][12]%>%</td>
         <%}%>

           <td class="DataTable4" id="tdGrp" nowrap rowspan=3 nowrap>District <%=sReg[i]%>(Comp Str)</td>
        </tr>

        <!-- Percents is allowed  -->
           <tr class="DataTable1">
              <%if(sPeriod.substring(0, 3).equals("MTD")){%>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRegCompDlyPrc[i][0]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sRegCompComPrc[i][0]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRegCompDlyPrc[i][1]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sRegCompComPrc[i][1]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRegCompDlyPrc[i][2]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sRegCompComPrc[i][2]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRegCompDlyPrc[i][3]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sRegCompComPrc[i][3]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRegCompDlyPrc[i][4]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sRegCompComPrc[i][4]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRegCompDlyPrc[i][5]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sRegCompComPrc[i][5]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRegCompDlyPrc[i][6]%>%</td>
                <td class="DataTable41" id="tdPrc"><%=sRegCompComPrc[i][6]%>%</td>
                <td class="DataTable41" id="tdPrc" colspan=8>&nbsp;</td>
              <%}%>
           </tr>
        <!-- Kiosk -->
        <tr class="DataTable1">
          <%if(sPeriod.substring(0, 3).equals("MTD")){%>
              <%for(int j=0; j < 7; j++){%>
                 <td class="DataTable4" id="tdKioskMemo" nowrap><span id="spKiosk">$<%=sRegTyKio[i][j]%></span><span id="spStrKiosk">$<%=sRegTyStrKio[i][j]%></span></td>
                 <td class="DataTable41" id="tdKioskMemo" nowrap><span id="spKiosk">$<%=sRegLyKio[i][j]%></span><span id="spStrKiosk">$<%=sRegLyStrKio[i][j]%></span></td>
              <%}%>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRegTyKio[i][7]%></span><span id="spStrKiosk"><%=sRegTyStrKio[i][7]%></span></td>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRegLyKio[i][7]%></span><span id="spStrKiosk"><%=sRegLyStrKio[i][7]%></span></td>
              <td class="DataTable41" id="tdKioskMemo">&nbsp;</td>

             <td class="DataTable41" id="tdKioskMemo"><span id="spKiosk"><%=sRegLyKio[i][8]%></span><span id="spStrKiosk"><%=sRegLyStrKio[i][8]%></span></td>
           <%}%>

           <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRegTyKio[i][9]%></span><span id="spStrKiosk"><%=sRegTyStrKio[i][9]%></span></td>
           <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRegLyKio[i][9]%></span><span id="spStrKiosk"><%=sRegLyStrKio[i][9]%></span></td>
           <td class="DataTable41" id="tdKioskMemo">&nbsp;</td>

           <td class="DataTable41" id="tdKioskMemo"><span id="spKiosk"><%=sRegLyKio[i][10]%></span><span id="spStrKiosk"><%=sRegLyStrKio[i][10]%></span></td>
           <%if(sPeriod.substring(0, 3).equals("YTD")){%>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRegTyKio[i][11]%></span><span id="spStrKiosk"><%=sRegTyStrKio[i][11]%></span></td>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRegLyKio[i][11]%></span><span id="spStrKiosk"><%=sRegLyStrKio[i][11]%></span></td>
              <td class="DataTable41" id="tdKioskMemo" nowrap>&nbsp;</td>

              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRegTyKio[i][12]%></span><span id="spStrKiosk"><%=sRegTyStrKio[i][12]%></span></td>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRegLyKio[i][12]%></span><span id="spStrKiosk"><%=sRegLyStrKio[i][12]%></span></td>
              <td class="DataTable41" id="tdKioskMemo" nowrap>&nbsp;</td>
           <%}%>
        </tr>
      <%}%>
    <%}%>



    <!------------------- Comp Store Totals -------------------------------------->
    <%if(!sStore.equals("COMP") && !sStore.equals("COMPE") && sLevel.equals("S"))
    {
        for(int i=0; i < 2; i++)
        {
          slsTyLy.setCompStrArr(Integer.toString(i));
          // Comp Store totals
          String [] sCompTySls = slsTyLy.getCompTySls();
          String [] sCompLySls = slsTyLy.getCompLySls();
          String [] sCompDlyPrc = slsTyLy.getCompDlyPrc();
          String [] sCompComPrc = slsTyLy.getCompComPrc();
          String [] sCompTyKio = slsTyLy.getCompTyKio();
          String [] sCompLyKio = slsTyLy.getCompLyKio();
          String [] sCompTyStrKio = slsTyLy.getCompTyStrKio();
          String [] sCompLyStrKio = slsTyLy.getCompLyStrKio();
          sCompStr = slsTyLy.getCompStr();
          iNumOfCompStr = slsTyLy.getNumOfCompStr();
    %>
        <tr class="DataTable2">
           <td class="DataTable6"  id="tdGrp" rowspan=3 onClick="drillDown('COMP<%if(i==0){%>E<%}%>')">Comp Str <%if(i==0){%>(exclude 70)<%}%></td>
         <%if(sPeriod.substring(0, 3).equals("MTD")){%>
           <td class="DataTable4"><%=sCompTySls[0]%></td>
           <td class="DataTable41"><%=sCompLySls[0]%></td>
           <td class="DataTable4"><%=sCompTySls[1]%></td>
           <td class="DataTable41"><%=sCompLySls[1]%></td>
           <td class="DataTable4"><%=sCompTySls[2]%></td>
           <td class="DataTable41"><%=sCompLySls[2]%></td>
           <td class="DataTable4"><%=sCompTySls[3]%></td>
           <td class="DataTable41"><%=sCompLySls[3]%></td>
           <td class="DataTable4"><%=sCompTySls[4]%></td>
           <td class="DataTable41"><%=sCompLySls[4]%></td>
           <td class="DataTable4"><%=sCompTySls[5]%></td>
           <td class="DataTable41"><%=sCompLySls[5]%></td>
           <td class="DataTable4"><%=sCompTySls[6]%></td>
           <td class="DataTable41"><%=sCompLySls[6]%></td>

           <td class="DataTable4"><%=sCompTySls[7]%></td>
           <td class="DataTable4"><%=sCompLySls[7]%></td>
           <td class="DataTable41"><%=sCompDlyPrc[7]%>%</td>
           <td class="DataTable41"><%=sCompLySls[8]%></td>
         <%}%>

           <td class="DataTable4"><%=sCompTySls[9]%></td>
           <td class="DataTable4"><%=sCompLySls[9]%></td>
           <td class="DataTable41"><%=sCompDlyPrc[9]%>%</td>
           <td class="DataTable41"><%=sCompLySls[10]%></td>

         <%if(sPeriod.substring(0, 3).equals("YTD")){%>
           <td class="DataTable4"><%=sCompTySls[11]%></td>
           <td class="DataTable4"><%=sCompLySls[11]%></td>
           <td class="DataTable41"><%=sCompDlyPrc[11]%>%</td>
           <td class="DataTable4"><%=sCompTySls[12]%></td>
           <td class="DataTable4"><%=sCompLySls[12]%></td>
           <td class="DataTable41"><%=sCompDlyPrc[12]%>%</td>
         <%}%>

           <td class="DataTable4" id="tdGrp" rowspan=3>Comp Str <%if(i==0){%>(exclude 70)<%}%></td>
        </tr>

        <!-- Percents is allowed  -->
           <tr class="DataTable2">
              <%if(sPeriod.substring(0, 3).equals("MTD")){%>
                <td class="DataTable4" id="tdPrc" nowrap><%=sCompDlyPrc[0]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sCompComPrc[0]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sCompDlyPrc[1]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sCompComPrc[1]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sCompDlyPrc[2]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sCompComPrc[2]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sCompDlyPrc[3]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sCompComPrc[3]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sCompDlyPrc[4]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sCompComPrc[4]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sCompDlyPrc[5]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sCompComPrc[5]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sCompDlyPrc[6]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sCompComPrc[6]%>%</td>
                <td class="DataTable41" id="tdPrc" colspan=8>&nbsp;</td>
              <%}%>
           </tr>
        <!-- Kiosk -->
        <tr class="DataTable2">
          <%if(sPeriod.substring(0, 3).equals("MTD")){%>
              <%for(int j=0; j < 7; j++){%>
                 <td class="DataTable4" id="tdKioskMemo" nowrap><span id="spKiosk">$<%=sCompTyKio[j]%></span><span id="spStrKiosk">$<%=sCompTyStrKio[j]%></span></td>
                 <td class="DataTable41" id="tdKioskMemo" nowrap><span id="spKiosk">$<%=sCompLyKio[j]%></span><span id="spStrKiosk">$<%=sCompLyStrKio[j]%></span></td>
              <%}%>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sCompTyKio[7]%></span><span id="spStrKiosk"><%=sCompTyStrKio[7]%></span></td>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sCompLyKio[7]%></span><span id="spStrKiosk"><%=sCompLyStrKio[7]%></span></td>
              <td class="DataTable41" id="tdKioskMemo">&nbsp;</td>

              <td class="DataTable41" id="tdKioskMemo"><span id="spKiosk"><%=sCompLyKio[8]%></span><span id="spStrKiosk"><%=sCompLyStrKio[8]%></span></td>
           <%}%>

           <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sCompTyKio[9]%></span><span id="spStrKiosk"><%=sCompTyStrKio[9]%></span></td>
           <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sCompLyKio[9]%></span><span id="spStrKiosk"><%=sCompLyStrKio[9]%></span></td>
           <td class="DataTable41" id="tdKioskMemo">&nbsp;</td>

           <td class="DataTable41" id="tdKioskMemo"><span id="spKiosk"><%=sCompLyKio[10]%></span><span id="spStrKiosk"><%=sCompLyStrKio[10]%></span></td>
           <%if(sPeriod.substring(0, 3).equals("YTD")){%>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sCompTyKio[11]%></span><span id="spStrKiosk"><%=sCompTyStrKio[11]%></span></td>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sCompLyKio[11]%></span><span id="spStrKiosk"><%=sCompLyStrKio[11]%></span></td>
              <td class="DataTable41" id="tdKioskMemo" nowrap>&nbsp;</td>

              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sCompTyKio[12]%></span><span id="spStrKiosk"><%=sCompTyStrKio[12]%></span></td>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sCompLyKio[12]%></span><span id="spStrKiosk"><%=sCompLyStrKio[12]%></span></td>
              <td class="DataTable41" id="tdKioskMemo" nowrap>&nbsp;</td>
           <%}%>
        </tr>
     <%}%>
    <%}%>
    <!------------------- Report Total -------------------------------------->
        <tr class="DataTable2">
           <td class="DataTable4" id="tdGrp" rowspan=3>Report&nbsp;</td>
         <%if(sPeriod.substring(0, 3).equals("MTD")){%>
           <td class="DataTable4"><%=sRepTySls[0]%></td>
           <td class="DataTable41"><%=sRepLySls[0]%></td>
           <td class="DataTable4"><%=sRepTySls[1]%></td>
           <td class="DataTable41"><%=sRepLySls[1]%></td>
           <td class="DataTable4"><%=sRepTySls[2]%></td>
           <td class="DataTable41"><%=sRepLySls[2]%></td>
           <td class="DataTable4"><%=sRepTySls[3]%></td>
           <td class="DataTable41"><%=sRepLySls[3]%></td>
           <td class="DataTable4"><%=sRepTySls[4]%></td>
           <td class="DataTable41"><%=sRepLySls[4]%></td>
           <td class="DataTable4"><%=sRepTySls[5]%></td>
           <td class="DataTable41"><%=sRepLySls[5]%></td>
           <td class="DataTable4"><%=sRepTySls[6]%></td>
           <td class="DataTable41"><%=sRepLySls[6]%></td>

           <td class="DataTable4"><%=sRepTySls[7]%></td>
           <td class="DataTable4"><%=sRepLySls[7]%></td>
           <td class="DataTable41"><%=sRepDlyPrc[7]%>%</td>
           <td class="DataTable41"><%=sRepLySls[8]%></td>
         <%}%>

           <td class="DataTable4"><%=sRepTySls[9]%></td>
           <td class="DataTable4"><%=sRepLySls[9]%></td>
           <td class="DataTable41"><%=sRepDlyPrc[9]%>%</td>
           <td class="DataTable41"><%=sRepLySls[10]%></td>

         <%if(sPeriod.substring(0, 3).equals("YTD")){%>
           <td class="DataTable4"><%=sRepTySls[11]%></td>
           <td class="DataTable4"><%=sRepLySls[11]%></td>
           <td class="DataTable41"><%=sRepDlyPrc[11]%>%</td>
           <td class="DataTable4"><%=sRepTySls[12]%></td>
           <td class="DataTable4"><%=sRepLySls[12]%></td>
           <td class="DataTable41"><%=sRepDlyPrc[12]%>%</td>
         <%}%>

           <td class="DataTable4" id="tdGrp" rowspan=3>Report&nbsp;</td>
        </tr>

        <!-- Percents is allowed  -->
           <tr class="DataTable2">
              <%if(sPeriod.substring(0, 3).equals("MTD")){%>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRepDlyPrc[0]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sRepComPrc[0]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRepDlyPrc[1]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sRepComPrc[1]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRepDlyPrc[2]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sRepComPrc[2]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRepDlyPrc[3]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sRepComPrc[3]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRepDlyPrc[4]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sRepComPrc[4]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRepDlyPrc[5]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sRepComPrc[5]%>%</td>
                <td class="DataTable4" id="tdPrc" nowrap><%=sRepDlyPrc[6]%>%</td>
                <td class="DataTable41" id="tdPrc" nowrap><%=sRepComPrc[6]%>%</td>
                <td class="DataTable41" id="tdPrc" colspan=8>&nbsp;</td>
              <%}%>
           </tr>
        <!-- Kiosk -->
        <tr class="DataTable2">
          <%if(sPeriod.substring(0, 3).equals("MTD")){%>
              <%for(int j=0; j < 7; j++){%>
                 <td class="DataTable4" id="tdKioskMemo" nowrap><span id="spKiosk">$<%=sRepTyKio[j]%></span><span id="spStrKiosk">$<%=sRepTyStrKio[j]%></span></td>
                 <td class="DataTable41" id="tdKioskMemo" nowrap><span id="spKiosk">$<%=sRepLyKio[j]%></span><span id="spStrKiosk">$<%=sRepLyStrKio[j]%></span></td>
              <%}%>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRepTyKio[7]%></span><span id="spStrKiosk"><%=sRepTyStrKio[7]%></span></td>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRepLyKio[7]%></span><span id="spStrKiosk"><%=sRepLyStrKio[7]%></span></td>
              <td class="DataTable41" id="tdKioskMemo">&nbsp;</td>

              <td class="DataTable41" id="tdKioskMemo"><span id="spKiosk"><%=sRepLyKio[8]%></span><span id="spStrKiosk"><%=sRepLyStrKio[8]%></span></td>
           <%}%>

           <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRepTyKio[9]%></span><span id="spStrKiosk"><%=sRepTyStrKio[9]%></span></td>
           <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRepLyKio[9]%></span><span id="spStrKiosk"><%=sRepLyStrKio[9]%></span></td>
           <td class="DataTable41" id="tdKioskMemo">&nbsp;</td>

           <td class="DataTable41" id="tdKioskMemo"><span id="spKiosk"><%=sRepLyKio[10]%></span><span id="spStrKiosk"><%=sRepLyStrKio[10]%></span></td>
           <%if(sPeriod.substring(0, 3).equals("YTD")){%>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRepTyKio[11]%></span><span id="spStrKiosk"><%=sRepTyStrKio[11]%></span></td>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRepLyKio[11]%></span><span id="spStrKiosk"><%=sRepLyStrKio[11]%></span></td>
              <td class="DataTable41" id="tdKioskMemo" nowrap>&nbsp;</td>

              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRepTyKio[12]%></span><span id="spStrKiosk"><%=sRepTyStrKio[12]%></span></td>
              <td class="DataTable4" id="tdKioskMemo"><span id="spKiosk"><%=sRepLyKio[12]%></span><span id="spStrKiosk"><%=sRepLyStrKio[12]%></span></td>
              <td class="DataTable41" id="tdKioskMemo" nowrap>&nbsp;</td>
           <%}%>
        </tr>
   </table>
    <!----------------------- end of table ---------------------------------->
    <p align="left">
    <%if ((sStore.equals("ALL") || sStore.equals("COMP")) && sDivision.equals("ALL")){%>
        <span style="color:brown; font-size:12px">&nbsp;Click <a href="javascript: setEcomSlsBySites()">here</a> to see ECOM sales by sites.</span><br>
    <%}%>

    <%if (sStore.equals("ALL") || sStore.equals("COMP")){%>
        <span style="font-size:10px">*Comp Store totals include <%=iNumOfCompStr%> stores<br>
         &nbsp;Comp Stores: <%String coma=""; for(int i=0; i < iNumOfCompStr; i++){%><%=coma + sCompStr[i]%><%coma=", ";}%>
        </span><br>
    <%}%>

    <!-- =================================================================== -->
    <!-- Temerature -->
    <!-- =================================================================== -->
    <a class="blue" href="javascript: showTemp()">Temperature around Stores</a><br>
    <table class="DataTable" id="tblTemp" cellPadding="0" cellSpacing="0">
        <tr class="TblHdr">
          <td class="DataTable313" rowspan="4">Str</td>
          <td class="DataTable313" colspan="4">Monday</td>
          <td class="DataTable313" colspan="4">Tuesday</td>
          <td class="DataTable313" colspan="4">Wednesday</td>
          <td class="DataTable313" colspan="4">Thursday</td>
          <td class="DataTable313" colspan="4">Friday</td>
          <td class="DataTable313" colspan="4">Saturday</td>
          <td class="DataTable313" colspan="4">Sunday</td>
          <td class="DataTable313" colspan="2">Week</td>
          <td class="DataTable313" rowspan="4">Str</td>
        </tr>
        <tr class="TblHdr">
          <%for(int i=0; i < 7; i++) {%><td class="DataTable31" colspan="2">TY</td><td class="DataTable313" colspan="2">LY</td><%}%>
          <td class="DataTable31" rowspan="2">TY</td><td class="DataTable313" rowspan="2">LY</td>
        </tr>
        <tr class="TblHdr">
          <%for(int i=0; i < 7; i++) {%>
             <td class="DataTable31" colspan="2"><%=sTyDate[i]%></td>
             <td class="DataTable313" colspan="2"><%=sLyDate[i]%></td><%}%>
        </tr>
        <tr class="TblHdr">
          <%for(int i=0; i < 7; i++) {%>
              <td class="DataTable3">Min</td><td class="DataTable31">Max</td>
              <td class="DataTable3">Min</td><td class="DataTable313">Max</td>
          <%}%>
          <td class="DataTable31">Avg</td><td class="DataTable313">Avg</td>
        </tr>

        <%for(int i=0; i < iNumOfStr; i++) {%>
          <%if(!sTempStr[i].trim().equals("89")){%>
            <tr class="DataTable3" onmouseover="hiliTempTbl(this, true)" onmouseout="hiliTempTbl(this, false)">
               <td class="DataTable413">&nbsp;<%=sTempStr[i]%></td>
               <%for(int j=0; j < 7; j++) {%>
                 <td class="DataTable7" >&nbsp;<%=sTyTempMin[i][j]%></td>
                 <td class="DataTable71">&nbsp;<%=sTyTempMax[i][j]%></td>
                 <td class="DataTable712" >&nbsp;<%=sLyTempMin[i][j]%></td>
                 <td class="DataTable713" >&nbsp;<%=sLyTempMax[i][j]%></td>
               <%}%>
               <td class="DataTable714" style="color:black">&nbsp;<%=sTyTempAvg[i]%></td>
               <td class="DataTable713" style="color:black">&nbsp;<%=sLyTempAvg[i]%></td>
               <td class="DataTable413">&nbsp;<%=sTempStr[i]%></td>
            </tr>
          <%}%>
        <%}%>
        <!-- company Total -->
        <tr class="DataTable2">
             <td class="DataTable413" style="border-top: darkred solid 3px;">Total</td>
             <%for(int i=0; i < 7; i++) {%>
               <td class="DataTable7" style="border-top: darkred solid 3px;">&nbsp;<%=sTyTotTempMin[i]%></td>
               <td class="DataTable71" style="border-top: darkred solid 3px;">&nbsp;<%=sTyTotTempMax[i]%></td>
               <td class="DataTable712" style="border-top: darkred solid 3px;">&nbsp;<%=sLyTotTempMin[i]%></td>
               <td class="DataTable713" style="border-top: darkred solid 3px;">&nbsp;<%=sLyTotTempMax[i]%></td>
             <%}%>
             <td class="DataTable714" style="color:black; border-top: darkred solid 3px;">&nbsp;<%=sTyTotTempAvg%></td>
             <td class="DataTable713" style="color:black; border-top: darkred solid 3px;">&nbsp;<%=sLyTotTempAvg%></td>
             <td class="DataTable413" style="border-top: darkred solid 3px;">Total</td>
          </tr>
      </table>
      <br>
    <!-- =================================================================== -->
    <!-- Event Calendar for this week  -->
    <!-- =================================================================== -->
    <div id="dvEvtCal" class="dvPrompt"></div>
    <!-- =================================================================== -->
  </table>
  <br><br><br><br><br><br><br><br><br><br><br><br>
 </body>
</html>
<%slsTyLy.disconnect();%>

<%} else{%>

  <table border="0" width="100%" cellPadding="0" cellSpacing="0">
    <tr bgColor="ivory">
       <td ALIGN="center" VALIGN="TOP" nowrap>
         <b>Retail Concepts, Inc
           <br>Flash Sales Comparison Report: TY vs. LY
           <br>
         </b>
       </td>
    </tr>
  </table>
<script>
   alert("The Flash Sales Report for the selected date is not available");
   window.location.href = "FlashSalesUpto5PrYrSel.jsp";
</script>
<%}%>