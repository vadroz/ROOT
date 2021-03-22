<%@ page import="java.util.*, java.text.*, payrollreports.PsActAvgVarAllStr"%>
<%
   String sStore = request.getParameter("Store");
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");
   String sAllwBdg = request.getParameter("AllwBdg");
   String sUser = session.getAttribute("USER").toString();

   if(sAllwBdg == null){ sAllwBdg = "Y"; }

   String sAppl = "PRBGACVAR";

if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
 && !session.getAttribute("APPLICATION").equals(sAppl))
{
   response.sendRedirect("SignOn1.jsp?TARGET=PsActAvgVarAllStr.jsp&APPL=" + sAppl + "&" + request.getQueryString());
}
else
{
     String sStrAllowed = session.getAttribute("STORE").toString();
     boolean bStrAlwed = false;
     if (sStrAllowed != null && sStrAllowed.startsWith("ALL") ) { bStrAlwed = true; }
     boolean bReg1Alw = session.getAttribute(sAppl + "1") != null;
     boolean bReg2Alw = session.getAttribute(sAppl + "2") != null;
     boolean bReg3Alw = session.getAttribute(sAppl + "3") != null;

     if( sStore.equals("ALL") && !bStrAlwed
         || sStore.equals("Reg 1") && !bReg1Alw
         || sStore.equals("Reg 2") && !bReg2Alw
         || sStore.equals("Reg 3") && !bReg3Alw){ response.sendRedirect("index.jsp"); }


    PsActAvgVarAllStr actvar = new PsActAvgVarAllStr(sStore, sFrom, sTo, sUser);

    int iNumOfStr = actvar.getNumOfStr();
    String [] sStr = actvar.getStr();
    String [] sStrName = actvar.getStrName();

    // hours
    String sBdgHrs = null;
    String sActHrs = null;
    String sVarHrs = null;

    // payments
    String sBdgPay = null;
    String sBdgCom = null;
    String sBdgLSpiff = null;
    String sBdgMSpiff = null;
    String sBdgOther = null;
    String sBdgTotPay = null;

    String sActPay = null;
    String sActCom = null;
    String sActLSpiff = null;
    String sActMSpiff = null;
    String sActOther = null;
    String sActTotPay = null;

    String sVarPay = null;
    String sVarCom = null;
    String sVarLSpiff = null;
    String sVarMSpiff = null;
    String sVarOther = null;
    String sVarTotPay = null;

  // Average wages
    String sBdgAvgPay = null;
    String sBdgAvgCom = null;
    String sBdgAvgLSpiff = null;
    String sBdgAvgMSpiff = null;
    String sBdgAvgOther = null;
    String sBdgAvgTotPay = null;

    String sActAvgPay = null;
    String sActAvgCom = null;
    String sActAvgLSpiff = null;
    String sActAvgMSpiff = null;
    String sActAvgOther = null;
    String sActAvgTotPay = null;

    String sVarAvgPay = null;
    String sVarAvgCom = null;
    String sVarAvgLSpiff = null;
    String sVarAvgMSpiff = null;
    String sVarAvgOther = null;
    String sVarAvgTotPay = null;

    String sVaHrSlr = null;
    String sVaHrHrs = null;
    String sVaHrAvg = null;
    String sVaHrTotHrl = null;
    String sVaHrTotal = null;
    String sVaBkBld = null;
    String sVaOther = null;

    String sActIncPay = null;
    String sVarIncPay = null;
    String sActAvgIncPay = null;
    String sVarAvgIncPay = null;
    String sVaIncPay = null;

    String sBdgSlrHrs = null;
    String sBdgHrlHrs = null;
    String sBdgSlrPay = null;
    String sBdgHrlPay = null;
    String sBdgAvgSlrPay = null;
    String sBdgAvgHrlPay = null;

    String sActSlrHrs = null;
    String sActHrlHrs = null;
    String sActSlrPay = null;
    String sActHrlPay = null;
    String sActAvgSlrPay = null;
    String sActAvgHrlPay = null;

    String sSlrHrsVar = null;
    String sHlrHrsVar = null;
    String sSlrPayVar = null;
    String sHrlPayVar = null;
    String sAvgSlrVar = null;
    String sAvgHrlVar = null;

    //------ allowable budget ----------------
    // hours
    String sABBdgHrs = null;
    String sABActHrs = null;
    String sABVarHrs = null;

    // payments
    String sABBdgPay = null;
    String sABBdgCom = null;
    String sABBdgLSpiff = null;
    String sABBdgMSpiff = null;
    String sABBdgOther = null;
    String sABBdgTotPay = null;

    String sABActPay = null;
    String sABActCom = null;
    String sABActLSpiff = null;
    String sABActMSpiff = null;
    String sABActOther = null;
    String sABActTotPay = null;

    String sABVarPay = null;
    String sABVarCom = null;
    String sABVarLSpiff = null;
    String sABVarMSpiff = null;
    String sABVarOther = null;
    String sABVarTotPay = null;

  // Average wages
    String sABBdgAvgPay = null;
    String sABBdgAvgCom = null;
    String sABBdgAvgLSpiff = null;
    String sABBdgAvgMSpiff = null;
    String sABBdgAvgOther = null;
    String sABBdgAvgTotPay = null;

    String sABActAvgPay = null;
    String sABActAvgCom = null;
    String sABActAvgLSpiff = null;
    String sABActAvgMSpiff = null;
    String sABActAvgOther = null;
    String sABActAvgTotPay = null;

    String sABVarAvgPay = null;
    String sABVarAvgCom = null;
    String sABVarAvgLSpiff = null;
    String sABVarAvgMSpiff = null;
    String sABVarAvgOther = null;
    String sABVarAvgTotPay = null;

    String sABVaHrSlr = null;
    String sABVaHrHrs = null;
    String sABVaHrAvg = null;
    String sABVaHrTotHrl = null;
    String sABVaHrTotal = null;

    String sABBdgSlrHrs = null;
    String sABBdgHrlHrs = null;
    String sABBdgSlrPay = null;
    String sABBdgHrlPay = null;
    String sABBdgAvgSlrPay = null;
    String sABBdgAvgHrlPay = null;

    String sABActSlrHrs = null;
    String sABActHrlHrs = null;
    String sABActSlrPay = null;
    String sABActHrlPay = null;
    String sABActAvgSlrPay = null;
    String sABActAvgHrlPay = null;

    String sABSlrHrsVar = null;
    String sABHlrHrsVar = null;
    String sABSlrPayVar = null;
    String sABHrlPayVar = null;
    String sABAvgSlrVar = null;
    String sABAvgHrlVar = null;

    String sVhtEmp = null;
    String sVhtEmpNm = null;
    String sVacHrs = null;
    String sVacPay = null;
    String sHolHrs = null;
    String sHolPay = null;
    String sTmcHrs = null;
    String sTmcPay = null;
    String sVhtHrs = null;
    String sVhtPay = null;

    boolean bUnfold = true; //sFrom.equals("BEGWEEK");
%>

<style>body {background:ivory;font-family: Verdanda}
         a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:middle; font-size:12px }

        tr.DataTable { background: white; font-size:12px }
        tr.Divdr1 { background: darkred; font-size:1px }
        tr.DataTable2 { background: #ccccff; font-size:12px }
        tr.DataTable3 { background: #ccffcc; font-size:12px }
        tr.DataTable31 { background: #ffff99; font-size:12px }
        tr.DataTable32 { background: gold; font-size:10px }
        tr.DataTable33 { background: white; font-size:12px }
        tr.DataTable4 { color:Maroon; background: Khaki; font-size:12px }
        tr.DataTable5 { background: LemonChiffon; font-size:12px }


        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable11 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; font-weight:bold;font-size:12px }
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2p { background: gray; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvSelWk { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
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

        #tdAmt { display: none; }
        #tdAvg { display: none; }
        #tdPrc { display: none; }

        #spOrig { display: none; }
        #spAlwBdg { display: block; }

        #spOrigLnk { display: none; }
        #spAlwBdgLnk { display: inline; }

        #lnkOrig { display: none; }
        #trOrig { display: none; }
</style>
<html>
<head><Meta http-equiv="refresh"></head>

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variables
//==============================================================================
var CurrStr = "<%=sStore%>";
var ArrStr = new Array();
var ArrStrNm = new Array();
var CurrFrWk = "<%=sFrom%>";
var CurrToWk = "<%=sTo%>";

var AllwBdg = <%=sAllwBdg.equals("Y")%>;
var Unfold = "<%=bUnfold%>";

var VhAbSlr = 0;
var VhAbHrs = 0;
var VhAbAvg = 0;
var VhAbTotHrly = 0;
var VhAbTot = 0;
//==============================================================================
// initializing process
//==============================================================================
function bodyLoad()
{
   dispSelWk();
   dispCols('Hrs')
   dispCols('Avg')
   setBoxclasses(["BoxName",  "BoxClose"], ["dvSelWk"]);

   if(!AllwBdg) {  switchOrigAllw(); dispCols('Pay') }
   else
   {
     spAlwBdg[0].style.display = "none";
     switchOrigAllw(); dispCols('Pay');
   }
}
//==============================================================================
// switch beetween Original and allowable budget
//==============================================================================
function switchOrigAllw()
{
   var spOrig = document.all.spOrig;
   var spAlwBdg = document.all.spAlwBdg;
   var colOrig = document.all.colOrig;
   //var lnkOrig = document.all.lnkOrig;
   var dispOrig, dispAllw, dispOrigLnk, dispAllwLnk;

   if (spAlwBdg[0].style.display != "none")
   {
     dispOrig = "block"; dispAllw = "none";
     dispOrigLnk = "inline"; dispAllwLnk = "none";
   }
   else
   {
      dispOrig = "none";
      dispAllw = "block";
      dispOrigLnk = "none";
      dispAllwLnk = "inline";
   }

   for(var i=0; i < spOrig.length; i++)
   {
      spOrig[i].style.display = dispOrig;
      spAlwBdg[i].style.display = dispAllw;
   }

   /*for(var i=0; i < colOrig.length; i++)
   {
      try
      {
         colOrig[i].style.display = dispOrig;
      }
      catch(err)
      {
         alert("element: " + i + "\nContent: " + colOrig[i].innerHTML + "\nerr:" + err.description )
      }
   }
   */

   //if (dispAllw == "block" && document.all.thPayLn1.colSpan <= 3){ alert(); dispCols('Pay', "block") }

   //document.all.trOrig.style.display = dispOrig;

   spOrigLnk.style.display = dispOrigLnk;
   spAlwBdgLnk.style.display = dispAllwLnk;

   //if(!Unfold) {  for(var i=0; i < lnkOrig.length; i++) { lnkOrig[i].style.display = dispOrig; } }
}
//==============================================================================
// populate week selection
//==============================================================================
function dispSelWk()
{

  var hdr = "Select Another Week";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popSelWk()

   html += "</td></tr></table>"

   document.all.dvSelWk.innerHTML = html;
   document.all.dvSelWk.style.pixelLeft= 1;
   document.all.dvSelWk.style.pixelTop= 1;
   document.all.dvSelWk.style.visibility = "visible";

   setSelStr();
   setSelWeek();
   setFrom_To_Dates();

   for(var i=0; i < document.all.td2Dates.length; i++){ document.all.td2Dates[i].style.display = "none"}
}
//--------------------------------------------------------
// populate Column Panel
//--------------------------------------------------------
function popSelWk()
{
  var panel = "<table border=0 cellPadding=0 cellSpacing=0>"
    + "<tr>"
       + "<td class='Prompt1'>Store:</td>"
       + "<td class='Prompt' colspan=2><select name='selStr' class='Small'></select>"
    + "</tr>"
    + "<tr>"
       + "<td class='Prompt1' id='td1Date'>Week:</td>"
       + "<td class='Prompt' id='td1Date' colspan=2><select name='selWeek' class='Small'></select>"
    + "</tr>"
    + "<tr>"
       + "<td class='Prompt1' id='td2Dates'>From:</td>"
       + "<td class='Prompt1' id='td2Dates'><input name='FrDate' class='Small' readonly></td>"
       + "<td class='Prompt1' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 255, 10, document.all.FrDate)'>"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
    + "</tr>"
    + "<tr>"
       + "<td class='Prompt1' id='td2Dates'>To:</td>"
       + "<td class='Prompt1' id='td2Dates'><input name='ToDate' class='Small' readonly></td>"
       + "<td class='Prompt1' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 255, 10, document.all.ToDate)'>"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
     + "</tr>"
  panel += "<tr><td class='Prompt1' colspan=3>"
        + "<button onClick='showAnotherWk()' class='Small'>Submit</button> &nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
        + "<button onClick='toggleDates()' class='Small'>Toggle Dates</button></td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// set store list
//==============================================================================
function setSelStr()
{
   <%if(bStrAlwed){%>ArrStr[ArrStr.length] = "ALL"; ArrStrNm[ArrStrNm.length] = "All Stores";<%}%>
   <%if(bReg1Alw){%>ArrStr[ArrStr.length] = "Reg 1"; ArrStrNm[ArrStrNm.length] = "Region 1";<%}%>
   <%if(bReg2Alw){%>ArrStr[ArrStr.length] = "Reg 2"; ArrStrNm[ArrStrNm.length] = "Region 2";<%}%>
   <%if(bReg3Alw){%>ArrStr[ArrStr.length] = "Reg 3"; ArrStrNm[ArrStrNm.length] = "Region 3";<%}%>

   var i = 0;
   for(var j=0; i < ArrStr.length; i++, j++)
   {
     document.all.selStr.options[j] = new Option(ArrStrNm[i], ArrStr[i]);
     if(ArrStr[i] == CurrStr){ document.all.selStr.selectedIndex = j; }
   }
}

//==============================================================================
// toggle between date options
//==============================================================================
function toggleDates()
{
  var oneday = "none";
  var twoday = "block";

  if(document.all.td2Dates[0].style.display == "block"){  oneday = "block";   twoday = "none"; }

  for(var i=0; i < document.all.td1Date.length; i++){ document.all.td1Date[i].style.display = oneday; }
  for(var i=0; i < document.all.td2Dates.length; i++){ document.all.td2Dates[i].style.display = twoday; }
}
//==============================================================================
// set weeks in dropdown menu
//==============================================================================
function setSelWeek()
{
   var date = new Date(new Date() - 86400000);
   date.setHours(18);
   if(date.getDay() > 0)
   {
     date = new Date(date - 86400000 * date.getDay());
     date = new Date(date - 86400000 * (-7));
   }


   for(var i=0; i < 15; i++)
   {
       cvtDt = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
       document.all.selWeek.options[i] = new Option(cvtDt, cvtDt);
       date = new Date(date - 86400000 * 7);
   }
}
//==============================================================================
// set From and to dates
//==============================================================================
function setFrom_To_Dates()
{
   var date = new Date(new Date() - 86400000);
   var cvtDt = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
   document.all.FrDate.value = cvtDt;
   document.all.ToDate.value = cvtDt;
}

//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvSelWk.innerHTML = " ";
   document.all.dvSelWk.style.visibility = "hidden";
}
//==============================================================================
// siplay selected Columns
//==============================================================================
function showAnotherWk()
{
   var str = document.all.selStr.options[document.all.selStr.selectedIndex].value;
   var week = document.all.selWeek.options[document.all.selWeek.selectedIndex].value;
   var frdate = document.all.FrDate.value.trim();
   var todate = document.all.ToDate.value.trim();

   var url = "PsActAvgVarAllStr.jsp?Store=" + str;

   if(document.all.td2Dates[0].style.display != "block")
   {
     url += "&From=BEGWEEK&To=" + week
   }
   else
   {
      if(frdate=="" || todate ==""){ error = true; msg="From or(and) To dates are not selected." }
      else { url += "&From=" + frdate + "&To=" + todate; }
   }

   //alert(url)
   window.location.href = url;
}
//==============================================================================
// siplay selected Columns
//==============================================================================
function dispCols(col)
{
   var HdLn1 = "th" + col + "Ln1";
   var HdLn2 = "th" + col + "Ln2";
   var HdLn3 = "th" + col + "Ln3";

   var colHdLn1 = document.all[HdLn1];
   var colHdLn2 = document.all[HdLn2];
   var colHdLn3 = document.all[HdLn3];

   var HdLn2b = "th" + col + "Ln2b"; // line 2 blank divider
   var colHdLn2b = document.all[HdLn2b];

   //tdBkpAvg
   var cellNm = "tdBkp" + col;
   var cols = document.all[cellNm];

   // fold or unfold
   var show = "block";
   if (cols[0].style.display != "none") { show = "none"; }

   var colSpanLn1 = 26;
   var colSpanLn2 = 8;
   if(col=="Hrs")
   {
      colSpanLn1 = 8;
      colSpanLn2 = 2;
   }

   if (show == "block") { colSpanLn1 *= -1; colSpanLn2 *= -1;}
   colHdLn1.colSpan -= colSpanLn1; //line1
   for(var i=0; i < colHdLn2.length; i++){ colHdLn2[i].colSpan -= colSpanLn2; } // line2
   for(var i=0; i < colHdLn2b.length; i++) {  colHdLn2b[i].style.display = show; } // Line 2 blank cell
   for(var i=0; i < colHdLn3.length; i++){ colHdLn3[i].style.display = show; } // line4

   // fold / unfold colomn cells
   for(var i=0; i < cols.length; i++)
   {
      cols[i].style.display = show;
   }
}
//==============================================================================
// show salary hours credit for allowable budget (list of employee)
//==============================================================================
function showSlrEmpLstCred(str, emp, empnm, vachrs, vacpay, holhrs, holpay, tmchrs, tmcpay, tothrs, totpay, cell)
{
   if(document.all.spAlwBdgLnk.style.display != "none")
   {
      var html = popSlrEmpLstCred(str, emp, empnm, vachrs, vacpay, holhrs, holpay, tmchrs, tmcpay, tothrs, totpay);
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
function popSlrEmpLstCred(str, emp, empnm, vachrs, vacpay, holhrs, holpay, tmchrs, tmcpay, tothrs, totpay)
{
   var html = "<table border=1 cellPadding='0' cellSpacing='0' style='font-size:10px; width: 100%;'>"
    + "<tr><th colspan=12>Store: " + str + "&nbsp;V/H/TMC Adjustment</th></tr>"
    + "<tr style='background: #ccffcc;'><th>Employee</th>"
    + "<th>Vac<br>Hours</th><th>Vac<br>Pay</th><th>&nbsp;</th>"
    + "<th>Hol<br>Hours</th><th>Hol<br>Pay</th><th>&nbsp;</th>"
    + "<th>TMC<br>Hours</th><th>TMC<br>Pay</th><th>&nbsp;</th>"
    + "<th>Total<br>Hours</th><th>Total<br>Pay</th>"
    + "</tr>";

   for(var i=0; i < emp.length; i++)
   {
      if(emp[i]=="TOTL")
      {
         html += "<tr style='background: #ccffcc;'>"
               + "<td align=left nowrap>" + empnm[i] + "</td>"
      }
      else
      {
         html += "<tr style='background: #ccccff;'>"
               + "<td align=left nowrap>" + emp[i] + " - " + empnm[i] + "</td>"
      }



       html += "<td align=right nowrap>" + vachrs[i] + "</td>"
              + "<td align=right nowrap>$" + vacpay[i] + "</td>"
              + "<th>&nbsp;</th>"
              + "<td align=right nowrap>" + holhrs[i] + "</td>"
              + "<td align=right nowrap>$" + holpay[i] + "</td>"
              + "<th>&nbsp;</th>"
              + "<td align=right nowrap>" + tmchrs[i] + "</td>"
              + "<td align=right nowrap>$" + tmcpay[i] + "</td>"
              + "<th>&nbsp;</th>"
              + "<td align=right nowrap>" + tothrs[i] + "</td>"
              + "<td align=right nowrap>$" + totpay[i] + "</td>"
           + "</tr>"
   }

   return html;
}
//==============================================================================
// hide salary hours credit for allowable budget
//==============================================================================
function hideSlrHrsCred()
{
   document.all.dvSlrCred.style.visibility = "hidden";
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

</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>



<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvSelWk" class="dvSelWk"></div>

<div id="dvSlrCred" style="position:absolute;visibility:hidden; background-attachment: scroll;
          border: black solid 1px; width:350px;background-color:LemonChiffon; z-index:10;
          visibility:hidden;font-size:10px"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts Inc.
      <br><span id="spOrig">Original Budget vs. Actual Variances</span>
          <span id="spAlwBdg">Allowable Budget vs. Actual Variances</span>
      <%if(sStore.equals("ALL")){%>All Stores<%}%>
          <%if(sStore.equals("Reg 1")){%>Region 1 Stores<%}%>
          <%if(sStore.equals("Reg 2")){%>Region 2 Stores<%}%>
          <%if(sStore.equals("Reg 3")){%>Region 3 Stores<%}%>
      <br>Weekending date:
      <br>Weekending date:&nbsp;
      <%if(bUnfold){%> From <%=sFrom%> Through <%=sTo%><%} else {%><%=sTo%><%}%>
      </b>

    <tr bgColor="ivory">
      <td ALIGN="left" VALIGN="TOP">
        <br><br><a href="../" class="small"><font color="red">Home</font></a>&#62;
                <a href="PsActAvgVarSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
        <font size="-1">This Page.</font>

        <%for(int i=0; i < 10; i++){%>&nbsp;<%}%>
        <a id="spOrigLnk" href="javascript: switchOrigAllw()">Allowable Budget</a> &nbsp; &nbsp;
        <a id="spAlwBdgLnk" href="javascript: switchOrigAllw()">Original Budget</a>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <a href="PsActAvgVarCmpByGrp.jsp?Store=<%=sStore%>&From=<%=sFrom%>&To=<%=sTo%>">Store Summary by Budget Group</a>

    <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP">
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0" >
        <tr>
          <th class="DataTable" rowspan=4>Budget Groups</th>
          <th class="DataTable" rowspan=4>&nbsp;</th>
          <th class="DataTable" id="thHrsLn1" colspan="11">
             <%if(bUnfold){%><a href="javascript: dispCols('Hrs')"># of Hours</a><%} else {%># of Hours<%}%>
          </th>
          <th class="DataTable" rowspan=4>&nbsp;</th>
          <th class="DataTable" id="thAvgLn1" colspan="29">
             <%if(bUnfold){%><a href="javascript: dispCols('Avg')">Avg. Wage</a><%} else {%>Avg. Wage<%}%>
          </th>
          <th class="DataTable" rowspan=4>&nbsp;</th>
          <th class="DataTable"  id="thPayLn1" colspan="29">
             <%if(bUnfold){%><a href="javascript: dispCols('Pay')">Payroll Dollars</a><%} else {%>Payroll Dollars<%}%>
          </th>
          <th class="DataTable" rowspan=4>&nbsp;</th>
          <th class="DataTable" id="colOrig" colspan=7>Variance Due To &nbsp; ((Favorable) or Unfavorable)</th>
        </tr>
        <tr>
          <th class="DataTable" id="thHrsLn2" rowspan=2 colspan=3><span id="spOrig">Original<br>Budget</span><span id="spAlwBdg">Allowable<br>Budget</span></th>
          <th class="DataTable" id="thHrsLn2b" rowspan=3>&nbsp;</th>
          <th class="DataTable" id="thHrsLn2" rowspan=2 colspan=3>Actual</th>
          <th class="DataTable" id="thHrsLn2b" rowspan=3>&nbsp;</th>
          <th class="DataTable" id="thHrsLn2" rowspan=2 colspan=3>Var</th>

          <th class="DataTable" id="thAvgLn2" colspan=9><span id="spOrig">Original<br>Budget</span><span id="spAlwBdg">Allowable<br>Budget</span></th>
          <th class="DataTable" id="thAvgLn2b" rowspan=3>&nbsp;</th>
          <th class="DataTable" id="thAvgLn2" colspan=9>Actual</th>
          <th class="DataTable" id="thAvgLn2b" rowspan=3>&nbsp;</th>
          <th class="DataTable" id="thAvgLn2" colspan=9>Var</th>

          <th class="DataTable" id="thPayLn2" colspan=9><span id="spOrig">Original<br>Budget</span><span id="spAlwBdg">Allowable<br>Budget</span></th>
          <th class="DataTable" id="thPayLn2b" rowspan=3>&nbsp;</th>
          <th class="DataTable" id="thPayLn2" colspan=9>Actual</th>
          <th class="DataTable" id="thPayLn2b" rowspan=3>&nbsp;</th>
          <th class="DataTable" id="thPayLn2" colspan=9>Var</th>

          <th class="DataTable" id="colOrig" rowspan=3>Salaried</th>
          <th class="DataTable" id="colOrig" colspan=5>Hourly</th>
          <th class="DataTable" id="colOrig" rowspan=3>Total</th>
        </tr>

        <tr>
           <th class="DataTable" rowspan=2 id="thAvgLn3">Slr</th>
           <th class="DataTable" id="thAvgLn3" colspan=7>Hourly</th>
           <th class="DataTable" rowspan=2>Total</th>
           <th class="DataTable" rowspan=2 id="thAvgLn3">Slr</th>
           <th class="DataTable" id="thAvgLn3" colspan=7>Hourly</th>
           <th class="DataTable" rowspan=2>Total</th>
           <th class="DataTable" rowspan=2 id="thAvgLn3">Slr</th>
           <th class="DataTable" id="thAvgLn3" colspan=7>Hourly</th>
           <th class="DataTable" rowspan=2>Total</th>

           <th class="DataTable" rowspan=2 id="thPayLn3">Slr</th>
           <th class="DataTable" id="thPayLn3" colspan=7>Hourly</th>
           <th class="DataTable" rowspan=2>Total</th>
           <th class="DataTable" rowspan=2 id="thPayLn3">Slr</th>
           <th class="DataTable" id="thPayLn3" colspan=7>Hourly</th>
           <th class="DataTable" rowspan=2>Total</th>
           <th class="DataTable" rowspan=2 id="thPayLn3">Slr</th>
           <th class="DataTable" id="thPayLn3" colspan=7>Hourly</th>
           <th class="DataTable" rowspan=2>Total</th>

           <th class="DataTable" id="colOrig" rowspan=2>Hours</th>
           <th class="DataTable" id="colOrig" rowspan=2>Avg. Wage</th>
           <th class="DataTable" id="colOrig" rowspan=2>"F" Code</th>
           <th class="DataTable" id="colOrig" rowspan=2>Other</th>
           <th class="DataTable" id="colOrig" rowspan=2>Total Hourly</th>
        </tr>

        <tr>
          <th class="DataTable" id="thHrsLn3">Slr</th>
          <th class="DataTable" id="thHrsLn3">Hrly</th>
          <th class="DataTable">Tot</th>
          <th class="DataTable" id="thHrsLn3">Slr</th>
          <th class="DataTable" id="thHrsLn3">Hrly</th>
          <th class="DataTable">Tot</th>
          <th class="DataTable" id="thHrsLn3">Slr</th>
          <th class="DataTable" id="thHrsLn3">Hrly</th>
          <th class="DataTable">Tot</th>

          <!-- Average -->
          <th class="DataTable" id="thAvgLn3">Pay</th>
          <th class="DataTable" id="thAvgLn3">Com</th>
          <th class="DataTable" id="thAvgLn3">Labor<br>Spiff</th>
          <th class="DataTable" id="thAvgLn3">Pay<br>Spiff</th>
          <th class="DataTable" id="thAvgLn3">"F" Code</th>
          <th class="DataTable" id="thAvgLn3">Other</th>
          <th class="DataTable" id="thAvgLn3">Total</th>

          <th class="DataTable" id="thAvgLn3">Pay</th>
          <th class="DataTable" id="thAvgLn3">Com</th>
          <th class="DataTable" id="thAvgLn3">Labor<br>Spiff</th>
          <th class="DataTable" id="thAvgLn3">Pay<br>Spiff</th>
          <th class="DataTable" id="thAvgLn3">"F" Code</th>
          <th class="DataTable" id="thAvgLn3">Other</th>
          <th class="DataTable" id="thAvgLn3">Total</th>

          <th class="DataTable" id="thAvgLn3">Pay</th>
          <th class="DataTable" id="thAvgLn3">Com</th>
          <th class="DataTable" id="thAvgLn3">Labor<br>Spiff</th>
          <th class="DataTable" id="thAvgLn3">Pay<br>Spiff</th>
          <th class="DataTable" id="thAvgLn3">"F" Code</th>
          <th class="DataTable" id="thAvgLn3">Other</th>
          <th class="DataTable" id="thAvgLn3">Total</th>

          <!-- Dollars -->
          <th class="DataTable" id="thPayLn3">Pay</th>
          <th class="DataTable" id="thPayLn3">Com</th>
          <th class="DataTable" id="thPayLn3">Labor<br>Spiff</th>
          <th class="DataTable" id="thPayLn3">Pay<br>Spiff</th>
          <th class="DataTable" id="thPayLn3">"F" Code</th>
          <th class="DataTable" id="thPayLn3">Other</th>
          <th class="DataTable" id="thPayLn3">Total</th>

          <th class="DataTable" id="thPayLn3">Pay</th>
          <th class="DataTable" id="thPayLn3">Com</th>
          <th class="DataTable" id="thPayLn3">Labor<br>Spiff</th>
          <th class="DataTable" id="thPayLn3">Pay<br>Spiff</th>
          <th class="DataTable" id="thPayLn3">"F" Code</th>
          <th class="DataTable" id="thPayLn3">Other</th>
          <th class="DataTable" id="thPayLn3">Total</th>

          <th class="DataTable" id="thPayLn3">Pay</th>
          <th class="DataTable" id="thPayLn3">Com</th>
          <th class="DataTable" id="thPayLn3">Labor<br>Spiff</th>
          <th class="DataTable" id="thPayLn3">Pay<br>Spiff</th>
          <th class="DataTable" id="thPayLn3">"F" Code</th>
          <th class="DataTable" id="thPayLn3">Other</th>
          <th class="DataTable" id="thPayLn3">Total</th>
        </tr>
     <!------------------------- Budget Group --------------------------------------->
     <%
        String sSvBdgSec = "";

        for(int i=0; i < iNumOfStr; i++){%>
     <%
        actvar.setActPay(i);
        sBdgHrs = actvar.getBdgHrs();
        sActHrs = actvar.getActHrs();
        sVarHrs = actvar.getVarHrs();

        // payments
        sBdgPay = actvar.getBdgPay();
        sBdgCom = actvar.getBdgCom();
        sBdgLSpiff = actvar.getBdgLSpiff();
        sBdgMSpiff = actvar.getBdgMSpiff();
        sBdgOther = actvar.getBdgOther();
        sBdgTotPay = actvar.getBdgTotPay();

        sActPay = actvar.getActPay();
        sActCom = actvar.getActCom();
        sActLSpiff = actvar.getActLSpiff();
        sActMSpiff = actvar.getActMSpiff();
        sActOther = actvar.getActOther();
        sActTotPay = actvar.getActTotPay();

        sVarPay = actvar.getVarPay();
        sVarCom = actvar.getVarCom();
        sVarLSpiff = actvar.getVarLSpiff();
        sVarMSpiff = actvar.getVarMSpiff();
        sVarOther = actvar.getVarOther();
        sVarTotPay = actvar.getVarTotPay();

        // averages
        sBdgAvgPay = actvar.getBdgAvgPay();
        sBdgAvgCom = actvar.getBdgAvgCom();
        sBdgAvgLSpiff = actvar.getBdgAvgLSpiff();
        sBdgAvgMSpiff = actvar.getBdgAvgMSpiff();
        sBdgAvgOther = actvar.getBdgAvgOther();
        sBdgAvgTotPay = actvar.getBdgAvgTotPay();

        sActAvgPay = actvar.getActAvgPay();
        sActAvgCom = actvar.getActAvgCom();
        sActAvgLSpiff = actvar.getActAvgLSpiff();
        sActAvgMSpiff = actvar.getActAvgMSpiff();
        sActAvgOther = actvar.getActAvgOther();
        sActAvgTotPay = actvar.getActAvgTotPay();

        sVarAvgPay = actvar.getVarAvgPay();
        sVarAvgCom = actvar.getVarAvgCom();
        sVarAvgLSpiff = actvar.getVarAvgLSpiff();
        sVarAvgMSpiff = actvar.getVarMSpiff();
        sVarAvgOther = actvar.getVarAvgOther();
        sVarAvgTotPay = actvar.getVarAvgTotPay();

        sVaHrSlr = actvar.getVaHrSlr();
        sVaHrHrs = actvar.getVaHrHrs();
        sVaHrAvg = actvar.getVaHrAvg();
        sVaHrTotHrl = actvar.getVaHrTotHrl();
        sVaHrTotal = actvar.getVaHrTotal();
        sVaBkBld = actvar.getVaBkBld();
        sVaOther = actvar.getVaOther();

        sActIncPay = actvar.getActIncPay();
        sVarIncPay = actvar.getVarIncPay();
        sActAvgIncPay = actvar.getActAvgIncPay();
        sVarAvgIncPay = actvar.getVarAvgIncPay();
        sVaIncPay = actvar.getVaIncPay();

        // salary, hourly
        sBdgSlrHrs = actvar.getBdgSlrHrs();
        sBdgHrlHrs = actvar.getBdgHrlHrs();
        sBdgSlrPay = actvar.getBdgSlrPay();
        sBdgHrlPay = actvar.getBdgHrlPay();
        sBdgAvgSlrPay = actvar.getBdgAvgSlrPay();
        sBdgAvgHrlPay = actvar.getBdgAvgHrlPay();

        sActSlrHrs = actvar.getActSlrHrs();
        sActHrlHrs = actvar.getActHrlHrs();
        sActSlrPay = actvar.getActSlrPay();
        sActHrlPay = actvar.getActHrlPay();
        sActAvgSlrPay = actvar.getActAvgSlrPay();
        sActAvgHrlPay = actvar.getActAvgHrlPay();

        sSlrHrsVar = actvar.getSlrHrsVar();
        sHlrHrsVar = actvar.getHrlHrsVar();
        sSlrPayVar = actvar.getSlrPayVar();
        sHrlPayVar = actvar.getHrlPayVar();
        sAvgSlrVar = actvar.getAvgSlrVar();
        sAvgHrlVar = actvar.getAvgHrlVar();


        // ------ allowable budget ------------------
        actvar.setAlwBdgPay(i);
        sABBdgHrs = actvar.getBdgHrs();
        sABActHrs = actvar.getActHrs();
        sABVarHrs = actvar.getVarHrs();

        // payments
        sABBdgPay = actvar.getBdgPay();
        sABBdgCom = actvar.getBdgCom();
        sABBdgLSpiff = actvar.getBdgLSpiff();
        sABBdgMSpiff = actvar.getBdgMSpiff();
        sABBdgOther = actvar.getBdgOther();
        sABBdgTotPay = actvar.getBdgTotPay();

        sABActPay = actvar.getActPay();
        sABActCom = actvar.getActCom();
        sABActLSpiff = actvar.getActLSpiff();
        sABActMSpiff = actvar.getActMSpiff();
        sABActOther = actvar.getActOther();
        sABActTotPay = actvar.getActTotPay();

        sABVarPay = actvar.getVarPay();
        sABVarCom = actvar.getVarCom();
        sABVarLSpiff = actvar.getVarLSpiff();
        sABVarMSpiff = actvar.getVarMSpiff();
        sABVarOther = actvar.getVarOther();
        sABVarTotPay = actvar.getVarTotPay();

        // averages
        sABBdgAvgPay = actvar.getBdgAvgPay();
        sABBdgAvgCom = actvar.getBdgAvgCom();
        sABBdgAvgLSpiff = actvar.getBdgAvgLSpiff();
        sABBdgAvgMSpiff = actvar.getBdgAvgMSpiff();
        sABBdgAvgOther = actvar.getBdgAvgOther();
        sABBdgAvgTotPay = actvar.getBdgAvgTotPay();

        sABActAvgPay = actvar.getActAvgPay();
        sABActAvgCom = actvar.getActAvgCom();
        sABActAvgLSpiff = actvar.getActAvgLSpiff();
        sABActAvgMSpiff = actvar.getActAvgMSpiff();
        sABActAvgOther = actvar.getActAvgOther();
        sABActAvgTotPay = actvar.getActAvgTotPay();

        sABVarAvgPay = actvar.getVarAvgPay();
        sABVarAvgCom = actvar.getVarAvgCom();
        sABVarAvgLSpiff = actvar.getVarAvgLSpiff();
        sABVarAvgMSpiff = actvar.getVarMSpiff();
        sABVarAvgOther = actvar.getVarAvgOther();
        sABVarAvgTotPay = actvar.getVarAvgTotPay();

        sABVaHrSlr = actvar.getVaHrSlr();
        sABVaHrHrs = actvar.getVaHrHrs();
        sABVaHrAvg = actvar.getVaHrAvg();
        sABVaHrTotHrl = actvar.getVaHrTotHrl();
        sABVaHrTotal = actvar.getVaHrTotal();

        // salary, hourly
        sABBdgSlrHrs = actvar.getBdgSlrHrs();
        sABBdgHrlHrs = actvar.getBdgHrlHrs();
        sABBdgSlrPay = actvar.getBdgSlrPay();
        sABBdgHrlPay = actvar.getBdgHrlPay();
        sABBdgAvgSlrPay = actvar.getBdgAvgSlrPay();
        sABBdgAvgHrlPay = actvar.getBdgAvgHrlPay();

        sABActSlrHrs = actvar.getActSlrHrs();
        sABActHrlHrs = actvar.getActHrlHrs();
        sABActSlrPay = actvar.getActSlrPay();
        sABActHrlPay = actvar.getActHrlPay();
        sABActAvgSlrPay = actvar.getActAvgSlrPay();
        sABActAvgHrlPay = actvar.getActAvgHrlPay();

        sABSlrHrsVar = actvar.getSlrHrsVar();
        sABHlrHrsVar = actvar.getHrlHrsVar();
        sABSlrPayVar = actvar.getSlrPayVar();
        sABHrlPayVar = actvar.getHrlPayVar();
        sABAvgSlrVar = actvar.getAvgSlrVar();
        sABAvgHrlVar = actvar.getAvgHrlVar();

        actvar.setVacHolTMC();

        sVhtEmp = actvar.getVhtEmp();
        sVhtEmpNm = actvar.getVhtEmpNm();
        sVacHrs = actvar.getVacHrs();
        sVacPay = actvar.getVacPay();
        sHolHrs = actvar.getHolHrs();
        sHolPay = actvar.getHolPay();
        sTmcHrs = actvar.getTmcHrs();
        sTmcPay = actvar.getTmcPay();
        sVhtHrs = actvar.getVhtHrs();
        sVhtPay = actvar.getVhtPay();

     %>
        <!-- Store Details -->
          <tr class="DataTable">
          <td class="DataTable11" nowrap><span id="spOrig"><a href="PsActAvgVar.jsp?Store=<%=sStr[i]%>&StrNm=<%=sStrName[i]%>&From=BEGWEEK&To=<%=sTo%>" target="_blank"><%=sStr[i] + " - " + sStrName[i]%></a></span><span id="spAlwBdg"><%=sStr[i] + " - " + sStrName[i]%></span></th>
          <th class="DataTable">&nbsp;</th>

          <!-- Hours -->
          <td class="DataTable2" id="tdBkpHrs" nowrap onmouseover="showSlrEmpLstCred('<%=sStr[i]%>', [<%=sVhtEmp%>], [<%=sVhtEmpNm%>], [<%=sVacHrs%>], [<%=sVacPay%>], [<%=sHolHrs%>], [<%=sHolPay%>], [<%=sTmcHrs%>], [<%=sTmcPay%>], [<%=sVhtHrs%>], [<%=sVhtPay%>],this)" onmouseout="hideSlrHrsCred()"><span id="spOrig"><%=sBdgSlrHrs%></span><span id="spAlwBdg"><%=sABBdgSlrHrs%></span></td>
          <td class="DataTable2" id="tdBkpHrs" nowrap><span id="spOrig"><%=sBdgHrlHrs%></span><span id="spAlwBdg"><%=sABBdgHrlHrs%></span></td>
          <td class="DataTable2" nowrap><span id="spOrig"><%=sBdgHrs%></span><span id="spAlwBdg"><%=sABBdgHrs%></span></td>
          <th class="DataTable" id="tdBkpHrs">&nbsp;</th>
          <td class="DataTable2" id="tdBkpHrs" nowrap>&nbsp;<%=sActSlrHrs%></td>
          <td class="DataTable2" id="tdBkpHrs" nowrap>&nbsp;<%=sActHrlHrs%></td>
          <td class="DataTable2" nowrap><%=sActHrs%></td>
          <th class="DataTable" id="tdBkpHrs">&nbsp;</th>
          <td class="DataTable2" id="tdBkpHrs" nowrap><span id="spOrig"><%=sSlrHrsVar%></span><span id="spAlwBdg"><%=sABSlrHrsVar%></span></td>
          <td class="DataTable2" id="tdBkpHrs" nowrap><span id="spOrig"><%=sHlrHrsVar%></span><span id="spAlwBdg"><%=sABHlrHrsVar%></span></td>
          <td class="DataTable2" nowrap><span id="spOrig"><%=sVarHrs%></span><span id="spAlwBdg"><%=sABVarHrs%></span></td>
          <th class="DataTable">&nbsp;</th>

          <!-- Average Wage -->
          <td class="DataTable2" id="tdBkpAvg" nowrap><span id="spOrig">$<%=sBdgAvgSlrPay%></span><span id="spAlwBdg">$<%=sABBdgAvgSlrPay%></span></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$.00</td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgOther%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap><span id="spOrig">$<%=sBdgAvgHrlPay%></span><span id="spAlwBdg">$<%=sABBdgAvgHrlPay%></span></td>
          <td class="DataTable2" nowrap><span id="spOrig">$<%=sBdgAvgTotPay%></span><span id="spAlwBdg">$<%=sABBdgAvgTotPay%></span></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgSlrPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgIncPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgOther%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>$<%=sActAvgHrlPay%></td>
          <td class="DataTable2" nowrap>$<%=sActAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap><span id="spOrig">$<%=sAvgSlrVar%></span><span id="spAlwBdg">$<%=sABAvgSlrVar%></span></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgIncPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgOther%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap><span id="spOrig">$<%=sAvgHrlVar%></span><span id="spAlwBdg">$<%=sABAvgHrlVar%></span></td>
          <td class="DataTable2" nowrap><span id="spOrig">$<%=sVarAvgTotPay%></span><span id="spAlwBdg">$<%=sABVarAvgTotPay%></span></td>
          <th class="DataTable">&nbsp;</th>

          <!-- Payments $'s -->
          <td class="DataTable2" id="tdBkpPay" nowrap onmouseover="showSlrEmpLstCred('<%=sStr[i]%>', [<%=sVhtEmp%>], [<%=sVhtEmpNm%>], [<%=sVacHrs%>], [<%=sVacPay%>], [<%=sHolHrs%>], [<%=sHolPay%>], [<%=sTmcHrs%>], [<%=sTmcPay%>], [<%=sVhtHrs%>], [<%=sVhtPay%>],this)" onmouseout="hideSlrHrsCred()">
              <span id="spOrig">$<%=sBdgSlrPay%></span><span id="spAlwBdg">$<%=sABBdgSlrPay%></span></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$0</td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgOther%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap><span id="spOrig">$<%=sBdgHrlPay%></span><span id="spAlwBdg">$<%=sABBdgHrlPay%></span></td>
          <td class="DataTable2" nowrap><span id="spOrig">$<%=sBdgTotPay%></span><span id="spAlwBdg">$<%=sABBdgTotPay%></span></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActSlrPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActIncPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActOther%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActHrlPay%></td>
          <td class="DataTable2" nowrap>$<%=sActTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap><span id="spOrig">$<%=sSlrPayVar%></span><span id="spAlwBdg">$<%=sABSlrPayVar%></span></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarIncPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarOther%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap><span id="spOrig">$<%=sHrlPayVar%></span><span id="spAlwBdg">$<%=sABHrlPayVar%></span></td>
          <td class="DataTable2" nowrap><span id="spOrig">$<%=sVarTotPay%></span><span id="spAlwBdg">$<%=sABVarTotPay%></span></td>
          <th class="DataTable">&nbsp;</th>

          <!-------- Variance Due To Hourly -------->
          <td class="DataTable2" id="colOrig" nowrap><span id="spOrig">$<%=sVaHrSlr%></span><span id="spAlwBdg">$<%=sABVaHrSlr%></span></td>
          <td class="DataTable2" id="colOrig" nowrap><span id="spOrig">$<%=sVaHrHrs%></span><span id="spAlwBdg">$<%=sABVaHrHrs%></span></td>
          <td class="DataTable2" id="colOrig" nowrap><span id="spOrig">$<%=sVaHrAvg%></span><span id="spAlwBdg">$<%=sABVaHrAvg%></span></td>
          <td class="DataTable2" id="colOrig" nowrap><span id="spOrig">$<%=sVaIncPay%></span><span id="spAlwBdg">$0</span></td>
          <td class="DataTable2" id="colOrig" nowrap><span id="spOrig">$<%=sVaOther%></span><span id="spAlwBdg">$0</span></td>
          <td class="DataTable2" id="colOrig" nowrap><span id="spOrig">$<%=sVaHrTotHrl%></span><span id="spAlwBdg">$<%=sABVaHrTotHrl%></span></td>
          <td class="DataTable2" id="colOrig" nowrap><span id="spOrig">$<%=sVaHrTotal%></span><span id="spAlwBdg">$<%=sABVaHrTotal%></span></td>
        </tr>
        <script language="javascript">
          VhAbSlr += eval(removeComas("<%=sABVaHrSlr%>"));
          VhAbHrs += eval(removeComas("<%=sABVaHrHrs%>"));
          VhAbAvg += eval(removeComas("<%=sABVaHrAvg%>"));
          VhAbTotHrly += eval(removeComas("<%=sABVaHrTotHrl%>"));
          VhAbTot += eval(removeComas("<%=sABVaHrTotal%>"));
        </script>
     <%}%>

     <!------------------------- Report Total --------------------------------->
     <%
        actvar.setRepTot();
        sBdgHrs = actvar.getBdgHrs();
        sActHrs = actvar.getActHrs();
        sVarHrs = actvar.getVarHrs();
        // payments
        sBdgPay = actvar.getBdgPay();
        sBdgCom = actvar.getBdgCom();
        sBdgLSpiff = actvar.getBdgLSpiff();
        sBdgMSpiff = actvar.getBdgMSpiff();
        sBdgOther = actvar.getBdgOther();
        sBdgTotPay = actvar.getBdgTotPay();

        sActPay = actvar.getActPay();
        sActCom = actvar.getActCom();
        sActLSpiff = actvar.getActLSpiff();
        sActMSpiff = actvar.getActMSpiff();
        sActOther = actvar.getActOther();
        sActTotPay = actvar.getActTotPay();

        sVarPay = actvar.getVarPay();
        sVarCom = actvar.getVarCom();
        sVarLSpiff = actvar.getVarLSpiff();
        sVarMSpiff = actvar.getVarMSpiff();
        sVarOther = actvar.getVarOther();
        sVarTotPay = actvar.getVarTotPay();

        // averages
        sBdgAvgPay = actvar.getBdgAvgPay();
        sBdgAvgCom = actvar.getBdgAvgCom();
        sBdgAvgLSpiff = actvar.getBdgAvgLSpiff();
        sBdgAvgMSpiff = actvar.getBdgAvgMSpiff();
        sBdgAvgOther = actvar.getBdgAvgOther();
        sBdgAvgTotPay = actvar.getBdgAvgTotPay();

        sActAvgPay = actvar.getActAvgPay();
        sActAvgCom = actvar.getActAvgCom();
        sActAvgLSpiff = actvar.getActAvgLSpiff();
        sActAvgMSpiff = actvar.getActAvgMSpiff();
        sActAvgOther = actvar.getActAvgOther();
        sActAvgTotPay = actvar.getActAvgTotPay();

        sVarAvgPay = actvar.getVarAvgPay();
        sVarAvgCom = actvar.getVarAvgCom();
        sVarAvgLSpiff = actvar.getVarAvgLSpiff();
        sVarAvgMSpiff = actvar.getVarMSpiff();
        sVarAvgOther = actvar.getVarAvgOther();
        sVarAvgTotPay = actvar.getVarAvgTotPay();

        sVaHrSlr = actvar.getVaHrSlr();
        sVaHrHrs = actvar.getVaHrHrs();
        sVaHrAvg = actvar.getVaHrAvg();
        sVaHrTotHrl = actvar.getVaHrTotHrl();
        sVaHrTotal = actvar.getVaHrTotal();
        sVaBkBld = actvar.getVaBkBld();
        sVaOther = actvar.getVaOther();

        sActIncPay = actvar.getActIncPay();
        sVarIncPay = actvar.getVarIncPay();
        sActAvgIncPay = actvar.getActAvgIncPay();
        sVarAvgIncPay = actvar.getVarAvgIncPay();
        sVaIncPay = actvar.getVaIncPay();

        // salary, hourly
        sBdgSlrHrs = actvar.getBdgSlrHrs();
        sBdgHrlHrs = actvar.getBdgHrlHrs();
        sBdgSlrPay = actvar.getBdgSlrPay();
        sBdgHrlPay = actvar.getBdgHrlPay();
        sBdgAvgSlrPay = actvar.getBdgAvgSlrPay();
        sBdgAvgHrlPay = actvar.getBdgAvgHrlPay();

        sActSlrHrs = actvar.getActSlrHrs();
        sActHrlHrs = actvar.getActHrlHrs();
        sActSlrPay = actvar.getActSlrPay();
        sActHrlPay = actvar.getActHrlPay();
        sActAvgSlrPay = actvar.getActAvgSlrPay();
        sActAvgHrlPay = actvar.getActAvgHrlPay();

        sSlrHrsVar = actvar.getSlrHrsVar();
        sHlrHrsVar = actvar.getHrlHrsVar();
        sSlrPayVar = actvar.getSlrPayVar();
        sHrlPayVar = actvar.getHrlPayVar();
        sAvgSlrVar = actvar.getAvgSlrVar();
        sAvgHrlVar = actvar.getAvgHrlVar();

        // ------ allowable budget ------------------
        actvar.setAlwRepTot();
        sABBdgHrs = actvar.getBdgHrs();
        sABActHrs = actvar.getActHrs();
        sABVarHrs = actvar.getVarHrs();

        // payments
        sABBdgPay = actvar.getBdgPay();
        sABBdgCom = actvar.getBdgCom();
        sABBdgLSpiff = actvar.getBdgLSpiff();
        sABBdgMSpiff = actvar.getBdgMSpiff();
        sABBdgOther = actvar.getBdgOther();
        sABBdgTotPay = actvar.getBdgTotPay();

        sABActPay = actvar.getActPay();
        sABActCom = actvar.getActCom();
        sABActLSpiff = actvar.getActLSpiff();
        sABActMSpiff = actvar.getActMSpiff();
        sABActOther = actvar.getActOther();
        sABActTotPay = actvar.getActTotPay();

        sABVarPay = actvar.getVarPay();
        sABVarCom = actvar.getVarCom();
        sABVarLSpiff = actvar.getVarLSpiff();
        sABVarMSpiff = actvar.getVarMSpiff();
        sABVarOther = actvar.getVarOther();
        sABVarTotPay = actvar.getVarTotPay();

        // averages
        sABBdgAvgPay = actvar.getBdgAvgPay();
        sABBdgAvgCom = actvar.getBdgAvgCom();
        sABBdgAvgLSpiff = actvar.getBdgAvgLSpiff();
        sABBdgAvgMSpiff = actvar.getBdgAvgMSpiff();
        sABBdgAvgOther = actvar.getBdgAvgOther();
        sABBdgAvgTotPay = actvar.getBdgAvgTotPay();

        sABActAvgPay = actvar.getActAvgPay();
        sABActAvgCom = actvar.getActAvgCom();
        sABActAvgLSpiff = actvar.getActAvgLSpiff();
        sABActAvgMSpiff = actvar.getActAvgMSpiff();
        sABActAvgOther = actvar.getActAvgOther();
        sABActAvgTotPay = actvar.getActAvgTotPay();

        sABVarAvgPay = actvar.getVarAvgPay();
        sABVarAvgCom = actvar.getVarAvgCom();
        sABVarAvgLSpiff = actvar.getVarAvgLSpiff();
        sABVarAvgMSpiff = actvar.getVarMSpiff();
        sABVarAvgOther = actvar.getVarAvgOther();
        sABVarAvgTotPay = actvar.getVarAvgTotPay();

        sABVaHrSlr = actvar.getVaHrSlr();
        sABVaHrHrs = actvar.getVaHrHrs();
        sABVaHrAvg = actvar.getVaHrAvg();
        sABVaHrTotHrl = actvar.getVaHrTotHrl();
        sABVaHrTotal = actvar.getVaHrTotal();

        // salary, hourly
        sABBdgSlrHrs = actvar.getBdgSlrHrs();
        sABBdgHrlHrs = actvar.getBdgHrlHrs();
        sABBdgSlrPay = actvar.getBdgSlrPay();
        sABBdgHrlPay = actvar.getBdgHrlPay();
        sABBdgAvgSlrPay = actvar.getBdgAvgSlrPay();
        sABBdgAvgHrlPay = actvar.getBdgAvgHrlPay();

        sABActSlrHrs = actvar.getActSlrHrs();
        sABActHrlHrs = actvar.getActHrlHrs();
        sABActSlrPay = actvar.getActSlrPay();
        sABActHrlPay = actvar.getActHrlPay();
        sABActAvgSlrPay = actvar.getActAvgSlrPay();
        sABActAvgHrlPay = actvar.getActAvgHrlPay();

        sABSlrHrsVar = actvar.getSlrHrsVar();
        sABHlrHrsVar = actvar.getHrlHrsVar();
        sABSlrPayVar = actvar.getSlrPayVar();
        sABHrlPayVar = actvar.getHrlPayVar();
        sABAvgSlrVar = actvar.getAvgSlrVar();
        sABAvgHrlVar = actvar.getAvgHrlVar();

        actvar.setRepVacHolTMC();

        sVhtEmp = actvar.getVhtEmp();
        sVhtEmpNm = actvar.getVhtEmpNm();
        sVacHrs = actvar.getVacHrs();
        sVacPay = actvar.getVacPay();
        sHolHrs = actvar.getHolHrs();
        sHolPay = actvar.getHolPay();
        sTmcHrs = actvar.getTmcHrs();
        sTmcPay = actvar.getTmcPay();
        sVhtHrs = actvar.getVhtHrs();
        sVhtPay = actvar.getVhtPay();
     %>
     <tr class="Divdr1"></td><td colspan=81>&nbsp;</td></tr>
     <tr class="Divdr1"></td><td colspan=81>&nbsp;</td></tr>
     <tr class="DataTable5">
       <td class="DataTable11" nowrap>Grand Total</td>
       <th class="DataTable">&nbsp;</th>
          <td class="DataTable2" id="tdBkpHrs" nowrap onmouseover="showSlrEmpLstCred('All', [<%=sVhtEmp%>], [<%=sVhtEmpNm%>], [<%=sVacHrs%>], [<%=sVacPay%>], [<%=sHolHrs%>], [<%=sHolPay%>], [<%=sTmcHrs%>], [<%=sTmcPay%>], [<%=sVhtHrs%>], [<%=sVhtPay%>],this)" onmouseout="hideSlrHrsCred()">
          <span id="spOrig"><%=sBdgSlrHrs%></span><span id="spAlwBdg"><%=sABBdgSlrHrs%></span></td>
          <td class="DataTable2" id="tdBkpHrs" nowrap><span id="spOrig"><%=sBdgHrlHrs%></span><span id="spAlwBdg"><%=sABBdgHrlHrs%></span></td>
          <td class="DataTable2" nowrap><span id="spOrig"><%=sBdgHrs%></span><span id="spAlwBdg"><%=sABBdgHrs%></span></td>
          <th class="DataTable" id="tdBkpHrs">&nbsp;</th>
          <td class="DataTable2" id="tdBkpHrs" nowrap>&nbsp;<%=sActSlrHrs%></td>
          <td class="DataTable2" id="tdBkpHrs" nowrap>&nbsp;<%=sActHrlHrs%></td>
          <td class="DataTable2" nowrap><%=sActHrs%></td>
          <th class="DataTable" id="tdBkpHrs">&nbsp;</th>
          <td class="DataTable2" id="tdBkpHrs" nowrap><span id="spOrig"><%=sSlrHrsVar%></span><span id="spAlwBdg"><%=sABSlrHrsVar%></span></td>
          <td class="DataTable2" id="tdBkpHrs" nowrap><span id="spOrig"><%=sHlrHrsVar%></span><span id="spAlwBdg"><%=sABHlrHrsVar%></span></td>
          <td class="DataTable2" nowrap><span id="spOrig"><%=sVarHrs%></span><span id="spAlwBdg"><%=sABVarHrs%></span></td>
          <th class="DataTable">&nbsp;</th>

          <!-- Average Wage -->
          <td class="DataTable2" id="tdBkpAvg" nowrap><span id="spOrig">$<%=sBdgAvgSlrPay%></span><span id="spAlwBdg">$<%=sABBdgAvgSlrPay%></span></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$.00</td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgOther%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap><span id="spOrig">$<%=sBdgAvgHrlPay%></span><span id="spAlwBdg">$<%=sABBdgAvgHrlPay%></span></td>
          <td class="DataTable2" nowrap><span id="spOrig">$<%=sBdgAvgTotPay%></span><span id="spAlwBdg">$<%=sABBdgAvgTotPay%></span></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgSlrPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgIncPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgOther%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>$<%=sActAvgHrlPay%></td>
          <td class="DataTable2" nowrap>$<%=sActAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap><span id="spOrig">$<%=sAvgSlrVar%></span><span id="spAlwBdg">$<%=sABAvgSlrVar%></span></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgIncPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgOther%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap><span id="spOrig">$<%=sAvgHrlVar%></span><span id="spAlwBdg">$<%=sABAvgHrlVar%></span></td>
          <td class="DataTable2" nowrap><span id="spOrig">$<%=sVarAvgTotPay%></span><span id="spAlwBdg">$<%=sABVarAvgTotPay%></span></td>
          <th class="DataTable">&nbsp;</th>

          <!-- Payments $'s -->
          <td class="DataTable2" id="tdBkpPay" nowrap onmouseover="showSlrEmpLstCred('All', [<%=sVhtEmp%>], [<%=sVhtEmpNm%>], [<%=sVacHrs%>], [<%=sVacPay%>], [<%=sHolHrs%>], [<%=sHolPay%>], [<%=sTmcHrs%>], [<%=sTmcPay%>], [<%=sVhtHrs%>], [<%=sVhtPay%>],this)" onmouseout="hideSlrHrsCred()">
              <span id="spOrig">$<%=sBdgSlrPay%></span><span id="spAlwBdg">$<%=sABBdgSlrPay%></span></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$0</td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgOther%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap><span id="spOrig">$<%=sBdgHrlPay%></span><span id="spAlwBdg">$<%=sABBdgHrlPay%></span></td>
          <td class="DataTable2" nowrap><span id="spOrig">$<%=sBdgTotPay%></span><span id="spAlwBdg">$<%=sABBdgTotPay%></span></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActSlrPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActIncPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActOther%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActHrlPay%></td>
          <td class="DataTable2" nowrap>$<%=sActTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap><span id="spOrig">$<%=sSlrPayVar%></span><span id="spAlwBdg">$<%=sABSlrPayVar%></span></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarIncPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarOther%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap><span id="spOrig">$<%=sHrlPayVar%></span><span id="spAlwBdg">$<%=sABHrlPayVar%></span></td>
          <td class="DataTable2" nowrap><span id="spOrig">$<%=sVarTotPay%></span><span id="spAlwBdg">$<%=sABVarTotPay%></span></td>
          <th class="DataTable">&nbsp;</th>

          <!-------- Variance Due To Hourly -------->
          <td class="DataTable2" id="colOrig" nowrap><span id="spOrig">$<%=sVaHrSlr%></span><span id="spAlwBdg">$<%=sABVaHrSlr%></span></td>
          <td class="DataTable2" id="colOrig" nowrap><span id="spOrig">$<%=sVaHrHrs%></span><span id="spAlwBdg">$<%=sABVaHrHrs%></span></td>
          <td class="DataTable2" id="colOrig" nowrap><span id="spOrig">$<%=sVaHrAvg%></span><span id="spAlwBdg">$<%=sABVaHrAvg%></span></td>
          <td class="DataTable2" id="colOrig" nowrap><span id="spOrig">$<%=sVaIncPay%></span><span id="spAlwBdg">$0</span></td>
          <td class="DataTable2" id="colOrig" nowrap><span id="spOrig">$<%=sVaOther%></span><span id="spAlwBdg">$0</span></td>
          <td class="DataTable2" id="colOrig" nowrap><span id="spOrig">$<%=sVaHrTotHrl%></span><span id="spAlwBdg">$<%=sABVaHrTotHrl%></span></td>
          <td class="DataTable2" id="colOrig" nowrap><span id="spOrig">$<%=sVaHrTotal%></span><span id="spAlwBdg">$<%=sABVaHrTotal%></span></td>
        </tr>
   </table>
   <!----------------------- end of table ---------------------------------->

  </table>
  <p style="font-size:12px">
  <!--Note: Budgeted and Actual payroll hours and dollars exclude holiday, vacation,
  sick pay and bonuses.-->

  <p style="font-size:12px">
  Note: Salaried employees - H, S, V is <b>included</b> in budgeted and actual payroll hours and dollars.
  <br>&nbsp; &nbsp; &nbsp; &nbsp; : Hourly employees - H, S, V is <b>excluded</b> in budgeted and actual payroll hours and dollars.
  <br>&nbsp; &nbsp; &nbsp; &nbsp; : # of hours budgeted for each salaried employee is 45 hours per week.
  <br>&nbsp; &nbsp; &nbsp; &nbsp; : Hours and dollars for TMC are not budgeted but are included in "Actual".

  <div id="dvSum"></div>

 </body>
<script language="JavaScript">
// Test
 var html = "<table border=1>"
  + "<tr>"
  + "<th>Slr</th>"
  + "<th>Hrs</th>"
  + "<th>Avg</th>"
  + "<th>TotHrly</th>"
  + "<th>Total</th>"
  + "</tr>"

    html += "<tr>"
    html += "<td>" + VhAbSlr + "</td>"
    html += "<td>" + VhAbHrs + "</td>"
    html += "<td>" + VhAbAvg + "</td>"
    html += "<td>" + VhAbTotHrly + "</td>"
    html += "<td>" + VhAbTot + "</td>"
    html += "<tr>"
 html += "</table>"
 //document.all.dvSum.innerHTML = html;
</script>

</html>
<%actvar.disconnect();%>

<%}%>






