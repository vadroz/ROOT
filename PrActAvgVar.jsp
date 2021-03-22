<%@ page import="java.util.*, java.text.*, payrollreports.PrActAvgVar"%>
<%
   String sStore = request.getParameter("Store");
   String sStrNm = request.getParameter("StrNm");
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");
   String sUser = session.getAttribute("USER").toString();

   String sAppl = "PAYROLL";

if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
 && !session.getAttribute("APPLICATION").equals(sAppl))
{
   response.sendRedirect("SignOn1.jsp?TARGET=PrActAvgVar.jsp&APPL=" + sAppl + "&" + request.getQueryString());
}
else
{
     String sStrAllowed = session.getAttribute("STORE").toString();
     sUser = session.getAttribute("USER").toString();

     boolean bStrAlwed = false;
     if (sStrAllowed != null && (sStrAllowed.startsWith("ALL") || sStrAllowed.equals(sStore)))
     {
       bStrAlwed = true;
     }
     else
     {
       Vector vStr = (Vector) session.getAttribute("STRLST");
       Iterator iter = vStr.iterator();
       while (iter.hasNext())
       {
          if (((String)iter.next()).equals(sStore)){ bStrAlwed = true; }
       }
     }
     if(!bStrAlwed){ response.sendRedirect("PrWkMonBdgSchSel.jsp"); }

    PrActAvgVar actvar = new PrActAvgVar(sStore, sFrom, sTo, sUser);

    int iNumOfGrpBdg = actvar.getNumOfGrpBdg();
    String [] sSecBdg = actvar.getSecBdg();
    String [] sSecBdgNm = actvar.getSecBdgNm();
    String [] sGrpBdg = actvar.getGrpBdg();
    String [] sGrpBdgName = actvar.getGrpBdgName();

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

    boolean bUnfold = sFrom.equals("BEGWEEK");
%>

<style>body {background:ivory;font-family: Verdanda}
         a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }

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

</style>
<html>
<head><Meta http-equiv="refresh"></head>

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variables
//==============================================================================
//==============================================================================
// initializing process
//==============================================================================
function bodyLoad()
{
   dispSelWk();
   dispCols('Avg')
   dispCols('Pay')
   setBoxclasses(["BoxName",  "BoxClose"], ["dvSelWk"]);
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
       + "<td class='Prompt1' id='td1Date'>Week:</td>"
       + "<td class='Prompt1' id='td1Date' colspan=2><select name='selWeek' class='Small'></select>"
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
   var week = document.all.selWeek.options[document.all.selWeek.selectedIndex].value;
   var frdate = document.all.FrDate.value.trim();
   var todate = document.all.ToDate.value.trim();

   var url = "PrActAvgVar.jsp?Store=<%=sStore%>&StrNm=<%=sStrNm%>"

   if(document.all.td2Dates[0].style.display != "block")
   {
     url += "&From=BEGWEEK&To=" + week
   }
   else
   {
      if(frdate=="" || todate ==""){ error = true; msg="From or(and) To dates are not selected." }
      else { url += "&From=" + frdate + "&To=" + todate; }
   }

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

   var colSpanLn1 = 17;
   var colSpanLn2 = 5;
   if (show == "block") { colSpanLn1 *= -1; colSpanLn2 *= -1;}

   colHdLn1.colSpan -= colSpanLn1; //line1
   for(var i=0; i < colHdLn2.length; i++){ colHdLn2[i].colSpan -= colSpanLn2; } // line2
   for(var i=0; i < colHdLn2b.length; i++) {  colHdLn2b[i].style.display = show; } // Line 2 blank cell
   for(var i=0; i < colHdLn3.length; i++){ colHdLn3[i].style.display = show; } // line3

   // fold / unfold colomn cells
   for(var i=0; i < cols.length; i++)
   {
      cols[i].style.display = show;
   }


}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>



<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvSelWk" class="dvSelWk"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
      <br>Budget vs. Actual Variances
      <br>Store: <%=sStore + " - " + sStrNm%>
      <br>Weekending date:&nbsp;
      <%if(!bUnfold){%> From <%=sFrom%> Through <%=sTo%><%} else {%><%=sTo%><%}%>
      </b>

      <br><br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0" >
        <tr>
          <th class="DataTable" rowspan=3>Budget Groups</th>
          <th class="DataTable" rowspan=3>&nbsp;</th>
          <th class="DataTable" colspan="3"># of Hours</th>
          <th class="DataTable" rowspan=3>&nbsp;</th>
          <th class="DataTable" id="thAvgLn1" colspan="20">
             <%if(bUnfold){%><a href="javascript: dispCols('Avg')">Avg. Wage</a><%} else {%>Avg. Wage<%}%>
          </th>
          <th class="DataTable" rowspan=3>&nbsp;</th>
          <th class="DataTable"  id="thPayLn1" colspan="20">
              <%if(bUnfold){%><a href="javascript: dispCols('Pay')">Payroll Dollars</a><%} else {%>Payroll Dollars<%}%>
          </th>
          <th class="DataTable" rowspan=3>&nbsp;</th>
          <th class="DataTable" colspan=7>Variance Due To</th>
        </tr>
        <tr>
          <th class="DataTable" rowspan=2>Original Budget</th>
          <th class="DataTable" rowspan=2>Actual</th>
          <th class="DataTable" rowspan=2>Var</th>

          <th class="DataTable" id="thAvgLn2" colspan=6>Original Budget</th>
          <th class="DataTable" id="thAvgLn2b" rowspan=2>&nbsp;</th>
          <th class="DataTable" id="thAvgLn2" colspan=6>Actual</th>
          <th class="DataTable" id="thAvgLn2b" rowspan=2>&nbsp;</th>
          <th class="DataTable" id="thAvgLn2" colspan=6>Var</th>

          <th class="DataTable" id="thPayLn2" colspan=6>Original Budget</th>
          <th class="DataTable" id="thPayLn2b" rowspan=2>&nbsp;</th>
          <th class="DataTable" id="thPayLn2" colspan=6>Actual</th>
          <th class="DataTable" id="thPayLn2b" rowspan=2>&nbsp;</th>
          <th class="DataTable" id="thPayLn2" colspan=6>Var</th>

          <th class="DataTable" rowspan=2>Salaried</th>
          <th class="DataTable" colspan=5>Hourly</th>
          <th class="DataTable" rowspan=2>Total</th>
        </tr>
        <tr>
          <th class="DataTable" id="thAvgLn3">Pay</th>
          <th class="DataTable" id="thAvgLn3">Com</th>
          <th class="DataTable" id="thAvgLn3">Labor<br>Spiff</th>
          <th class="DataTable" id="thAvgLn3">Pay<br>Spiff</th>
          <th class="DataTable" id="thAvgLn3">Other</th>
          <th class="DataTable">Total</th>

          <th class="DataTable" id="thAvgLn3">Pay</th>
          <th class="DataTable" id="thAvgLn3">Com</th>
          <th class="DataTable" id="thAvgLn3">Labor<br>Spiff</th>
          <th class="DataTable" id="thAvgLn3">Pay<br>Spiff</th>
          <th class="DataTable" id="thAvgLn3">Other</th>
          <th class="DataTable">Total</th>

          <th class="DataTable" id="thAvgLn3">Pay</th>
          <th class="DataTable" id="thAvgLn3">Com</th>
          <th class="DataTable" id="thAvgLn3">Labor<br>Spiff</th>
          <th class="DataTable" id="thAvgLn3">Pay<br>Spiff</th>
          <th class="DataTable" id="thAvgLn3">Other</th>
          <th class="DataTable">Total</th>

          <th class="DataTable" id="thPayLn3">Pay</th>
          <th class="DataTable" id="thPayLn3">Com</th>
          <th class="DataTable" id="thPayLn3">Labor<br>Spiff</th>
          <th class="DataTable" id="thPayLn3">Pay<br>Spiff</th>
          <th class="DataTable" id="thPayLn3">Other</th>
          <th class="DataTable">Total</th>

          <th class="DataTable" id="thPayLn3">Pay</th>
          <th class="DataTable" id="thPayLn3">Com</th>
          <th class="DataTable" id="thPayLn3">Labor<br>Spiff</th>
          <th class="DataTable" id="thPayLn3">Pay<br>Spiff</th>
          <th class="DataTable" id="thPayLn3">Other</th>
          <th class="DataTable">Total</th>

          <th class="DataTable" id="thPayLn3">Pay</th>
          <th class="DataTable" id="thPayLn3">Com</th>
          <th class="DataTable" id="thPayLn3">Labor<br>Spiff</th>
          <th class="DataTable" id="thPayLn3">Pay<br>Spiff</th>
          <th class="DataTable" id="thPayLn3">Other</th>
          <th class="DataTable">Total</th>

          <th class="DataTable">Hours</th>
          <th class="DataTable">Avg. Wage</th>
          <th class="DataTable">Bike<br>Builder</th>
          <th class="DataTable">Other</th>
          <th class="DataTable">Total Hourly</th>
        </tr>
     <!------------------------- Budget Group --------------------------------------->
     <%
        String sSvBdgSec = "";

        for(int i=0; i < iNumOfGrpBdg; i++){%>
     <%
        actvar.setActPay(sGrpBdg[i]);
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
        sVarAvgMSpiff = actvar.getVarAvgMSpiff();
        sVarAvgOther = actvar.getVarAvgOther();
        sVarAvgTotPay = actvar.getVarAvgTotPay();

        sVaHrSlr = actvar.getVaHrSlr();
        sVaHrHrs = actvar.getVaHrHrs();
        sVaHrAvg = actvar.getVaHrAvg();
        sVaHrTotHrl = actvar.getVaHrTotHrl();
        sVaHrTotal = actvar.getVaHrTotal();
        sVaBkBld = actvar.getVaBkBld();
        sVaOther = actvar.getVaOther();
     %>
        <!-- Section Name -->
        <%if(!sSvBdgSec.equals(sSecBdg[i])){%>
            <tr class="DataTable2" id="thSecNm">
              <td class="DataTable11" colspan="54"><%=sSecBdgNm[i]%></td>
            </tr>
            <%sSvBdgSec = sSecBdg[i];%>
        <%}%>

        <!-- Store Details -->
        <tr class="DataTable" <%if(sSecBdg[i].equals("1")){%>style="display:none;"<%}%>>
          <td class="DataTable11" nowrap> &nbsp; &nbsp; &nbsp;<%=sGrpBdgName[i]%></th>
          <th class="DataTable">&nbsp;</th>

          <td class="DataTable2" id="tdHrs" nowrap>&nbsp;<%=sBdgHrs%></td>
          <td class="DataTable2" id="tdHrs" nowrap>&nbsp;<%=sActHrs%></td>
          <td class="DataTable2" id="tdHrs" nowrap>&nbsp;<%=sVarHrs%></td>
          <th class="DataTable">&nbsp;</th>

          <!-- Average Wage -->
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sBdgAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sActAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVarAvgTotPay%></td>
          <th class="DataTable">&nbsp;</th>

          <!-- Total $'s -->
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sBdgTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sActTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVarTotPay%></td>
          <th class="DataTable">&nbsp;</th>

          <!-------- Variance Due To Hourly -------->
          <td class="DataTable2<%if(!sSecBdg[i].equals("1")){%>p<%}%>">&nbsp;</td>
          <td class="DataTable2<%if(sGrpBdg[i].equals("BKBLD")){%>p<%}%>" nowrap>&nbsp;<%if(!sGrpBdg[i].equals("BKBLD")){%>$<%=sVaHrHrs%><%}%></td>
          <td class="DataTable2<%if(sGrpBdg[i].equals("BKBLD")){%>p<%}%>" nowrap>&nbsp;<%if(!sGrpBdg[i].equals("BKBLD")){%>$<%=sVaHrAvg%><%}%></td>
          <td class="DataTable2<%if(!sGrpBdg[i].equals("BKBLD")){%>p<%}%>" nowrap>&nbsp;<%if(sGrpBdg[i].equals("BKBLD")){%>$<%=sVaBkBld%><%}%></td>
          <td class="DataTable2<%if(sGrpBdg[i].equals("BKBLD")){%>p<%}%>" nowrap>&nbsp;<%if(!sGrpBdg[i].equals("BKBLD")){%>$<%=sVaOther%><%}%></td>

          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrTotHrl%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrTotal%></td>
        </tr>

        <!--------------- Level Break on Section --------------------->
        <%if( i+1 == iNumOfGrpBdg || !sSvBdgSec.equals(sSecBdg[i + 1])){%>
        <%
           actvar.setSecTot(sSecBdg[i]);
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
        sVarAvgMSpiff = actvar.getVarAvgMSpiff();
        sVarAvgOther = actvar.getVarAvgOther();
        sVarAvgTotPay = actvar.getVarAvgTotPay();

        sVaHrSlr = actvar.getVaHrSlr();
        sVaHrHrs = actvar.getVaHrHrs();
        sVaHrAvg = actvar.getVaHrAvg();
        sVaHrTotHrl = actvar.getVaHrTotHrl();
        sVaHrTotal = actvar.getVaHrTotal();
        sVaBkBld = actvar.getVaBkBld();
        sVaOther = actvar.getVaOther();
        %>
             <tr class="DataTable3">
               <td class="DataTable11" nowrap>Subtotal</td>
               <th class="DataTable">&nbsp;</th>

               <td class="DataTable2" id="tdHrs" nowrap>&nbsp;<%=sBdgHrs%></td>
               <td class="DataTable2" id="tdHrs" nowrap>&nbsp;<%=sActHrs%></td>
               <td class="DataTable2" id="tdHrs" nowrap>&nbsp;<%=sVarHrs%></td>
               <th class="DataTable">&nbsp;</th>

               <!-- Average Wage -->
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sBdgAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sActAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVarAvgTotPay%></td>
          <th class="DataTable">&nbsp;</th>

          <!-- Total $'s -->
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sBdgTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sActTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVarTotPay%></td>
          <th class="DataTable">&nbsp;</th>

          <td class="DataTable2<%if(!sSecBdg[i].equals("1")){%>p<%}%>" nowrap>&nbsp;<%if(sSecBdg[i].equals("1")){%>$<%=sVaHrSlr%><%}%></td>
          <td class="DataTable2<%if(sSecBdg[i].equals("1")){%>p<%}%>" nowrap>&nbsp;<%if(!sSecBdg[i].equals("1")){%>$<%=sVaHrHrs%><%}%></td>
          <td class="DataTable2<%if(sSecBdg[i].equals("1")){%>p<%}%>" nowrap>&nbsp;<%if(!sSecBdg[i].equals("1")){%>$<%=sVaHrAvg%><%}%></td>
          <td class="DataTable2<%if(!sSecBdg[i].equals("3")){%>p<%}%>" nowrap>&nbsp;<%if(sSecBdg[i].equals("3")){%>$<%=sVaBkBld%><%}%></td>
          <td class="DataTable2<%if(sSecBdg[i].equals("1")){%>p<%}%>" nowrap>&nbsp;<%if(!sSecBdg[i].equals("1")){%>$<%=sVaOther%><%}%></td>
          <td class="DataTable2<%if(sSecBdg[i].equals("1")){%>p<%}%>" nowrap>&nbsp;<%if(!sSecBdg[i].equals("1")){%>$<%=sVaHrTotHrl%><%}%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrTotal%></td>

            </tr>
            <tr class="Divdr1"></td><td colspan=54>&nbsp;</td></tr>
         <%}%>
     <%}%>
     <!------------- Hourly Sub Total w/o bike builders ----------------------->
     <%
        actvar.setHourlyWOBkbldTot();
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
        sVarAvgMSpiff = actvar.getVarAvgMSpiff();
        sVarAvgOther = actvar.getVarAvgOther();
        sVarAvgTotPay = actvar.getVarAvgTotPay();

        sVaHrSlr = actvar.getVaHrSlr();
        sVaHrHrs = actvar.getVaHrHrs();
        sVaHrAvg = actvar.getVaHrAvg();
        sVaHrTotHrl = actvar.getVaHrTotHrl();
        sVaHrTotal = actvar.getVaHrTotal();
        sVaBkBld = actvar.getVaBkBld();
        sVaOther = actvar.getVaOther();
     %>
     <tr class="Divdr1"></td><td colspan=54>&nbsp;</td></tr>
     <tr class="DataTable5">
       <td class="DataTable11" nowrap>Hourly Total W/o Bike Builders</td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable2" id="tdHrs" nowrap>&nbsp;<%=sBdgHrs%></td>
       <td class="DataTable2" id="tdHrs" nowrap>&nbsp;<%=sActHrs%></td>
       <td class="DataTable2" id="tdHrs" nowrap>&nbsp;<%=sVarHrs%></td>
       <th class="DataTable">&nbsp;</th>
            <!-- Average Wage -->
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sBdgAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sActAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVarAvgTotPay%></td>
          <th class="DataTable">&nbsp;</th>

          <!-- Total $'s -->
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sBdgTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sActTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVarTotPay%></td>
          <th class="DataTable">&nbsp;</th>

          <td class="DataTable2p" nowrap>&nbsp;</td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrHrs%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrAvg%></td>
          <td class="DataTable2p" nowrap>&nbsp;</td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrTotHrl%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrTotal%></td>
     </tr>

     <!--------------------- Hourly Sub Total --------------------------------->
     <%
        actvar.setHourlyTot();
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
        sVarAvgMSpiff = actvar.getVarAvgMSpiff();
        sVarAvgOther = actvar.getVarAvgOther();
        sVarAvgTotPay = actvar.getVarAvgTotPay();

        sVaHrSlr = actvar.getVaHrSlr();
        sVaHrHrs = actvar.getVaHrHrs();
        sVaHrAvg = actvar.getVaHrAvg();
        sVaHrTotHrl = actvar.getVaHrTotHrl();
        sVaHrTotal = actvar.getVaHrTotal();
        sVaBkBld = actvar.getVaBkBld();
        sVaOther = actvar.getVaOther();
     %>
     <tr class="Divdr1"></td><td colspan=54>&nbsp;</td></tr>
     <tr class="DataTable5">
       <td class="DataTable11" nowrap>Hourly Total</td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable2" id="tdHrs" nowrap>&nbsp;<%=sBdgHrs%></td>
       <td class="DataTable2" id="tdHrs" nowrap>&nbsp;<%=sActHrs%></td>
       <td class="DataTable2" id="tdHrs" nowrap>&nbsp;<%=sVarHrs%></td>
       <th class="DataTable">&nbsp;</th>
            <!-- Average Wage -->
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sBdgAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sActAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVarAvgTotPay%></td>
          <th class="DataTable">&nbsp;</th>

          <!-- Total $'s -->
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sBdgTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sActTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVarTotPay%></td>
          <th class="DataTable">&nbsp;</th>

          <td class="DataTable2p" nowrap>&nbsp;</td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrHrs%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrAvg%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaBkBld%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrTotHrl%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrTotal%></td>
     </tr>


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
        sVarAvgMSpiff = actvar.getVarAvgMSpiff();
        sVarAvgOther = actvar.getVarAvgOther();
        sVarAvgTotPay = actvar.getVarAvgTotPay();

        sVaHrSlr = actvar.getVaHrSlr();
        sVaHrHrs = actvar.getVaHrHrs();
        sVaHrAvg = actvar.getVaHrAvg();
        sVaHrTotHrl = actvar.getVaHrTotHrl();
        sVaHrTotal = actvar.getVaHrTotal();
        sVaBkBld = actvar.getVaBkBld();
        sVaOther = actvar.getVaOther();
     %>
     <tr class="Divdr1"></td><td colspan=54>&nbsp;</td></tr>
     <tr class="Divdr1"></td><td colspan=54>&nbsp;</td></tr>
     <tr class="DataTable5">
       <td class="DataTable11" nowrap>Grand Total</td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable2" id="tdHrs" nowrap>&nbsp;<%=sBdgHrs%></td>
       <td class="DataTable2" id="tdHrs" nowrap>&nbsp;<%=sActHrs%></td>
       <td class="DataTable2" id="tdHrs" nowrap>&nbsp;<%=sVarHrs%></td>
       <th class="DataTable">&nbsp;</th>
            <!-- Average Wage -->
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sBdgAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sActAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVarAvgTotPay%></td>
          <th class="DataTable">&nbsp;</th>

          <!-- Total $'s -->
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sBdgTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActOther%></td>
          <td class="DataTable2" nowrap>&nbsp;<%=sActTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVarTotPay%></td>
          <th class="DataTable">&nbsp;</th>

          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrSlr%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrHrs%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrAvg%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaBkBld%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrTotHrl%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrTotal%></td>
     </tr>
   </table>
   <!----------------------- end of table ---------------------------------->

  </table>

  <p style="font-size:12px">
  Note: Budgeted and Actual payroll hours and dollars exclude holiday, vacation,
  sick pay and bonuses.

 </body>

</html>
<%actvar.disconnect();%>

<%}%>






