<%@ page import="rciutility.StoreSelect, java.util.*, java.text.*, payrollreports.PsActAvgVar, rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*"%>
<%
   String sStore = request.getParameter("Store");
   String sStrNm = request.getParameter("StrNm");
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");
   String sUser = session.getAttribute("USER").toString();

   java.util.Date sessDate = null;
   long lElapse = 99999;
   long lRefresh = 10 * 60;
   if(session.getAttribute("DATE")!=null)
   {
      sessDate = (java.util.Date)session.getAttribute("DATE");
      lElapse = (new java.util.Date()).getTime() -   sessDate.getTime();
   }

   if(session.getAttribute("USER")!=null
       && (session.getAttribute("USER").toString().equals("vrozen")
        || session.getAttribute("USER").toString().equals("fstanley")
        || session.getAttribute("USER").toString().equals("mparker")
        || session.getAttribute("USER").toString().equals("bswann"))
   )
   {
      lElapse = 0;
      lRefresh = 60 * 60;
   }

   String sAppl = "PRBGACVAR";

if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
 && !session.getAttribute("APPLICATION").equals(sAppl)  || lElapse > 5 * 1000 * 60 )
{
   response.sendRedirect("SignOn1.jsp?TARGET=PsActAvgVar.jsp&APPL=" + sAppl + "&" + request.getQueryString());
}
else
{
     StoreSelect StrSelect = null;
     String sArrStr = null;
     String sArrStrName = null;

     String sStrAllowed = session.getAttribute("STORE").toString();
     sUser = session.getAttribute("USER").toString();
     boolean bReg1Alw = session.getAttribute(sAppl + "1") != null;
     boolean bReg2Alw = session.getAttribute(sAppl + "2") != null;
     boolean bReg3Alw = session.getAttribute(sAppl + "3") != null;

     boolean bStrAlwed = false;
     if (sStrAllowed != null && sStrAllowed.startsWith("ALL") )
     {
        bStrAlwed = true;
        StrSelect = new StoreSelect(5);
     }
     else
     {
       Vector vStr = (Vector) session.getAttribute("STRLST");
       String [] sStrAlwLst = new String[ vStr.size()];
       int iStrAlwLst = 0;

       Iterator iter = vStr.iterator();
       while (iter.hasNext())
       {
          sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++;
          if (!bStrAlwed){ bStrAlwed = sStore.equals(sStrAlwLst[iStrAlwLst-1]); }
       }

       if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst);}
       else { StrSelect = new StoreSelect(new String[]{sStrAllowed}); bStrAlwed = sStrAllowed.equals(sStore);}
     }

     if( !bStrAlwed ){ response.sendRedirect("index.jsp"); }

     boolean bSlrDtl = sStrAllowed.startsWith("ALL")
                   || bReg1Alw
                   || bReg2Alw
                   || bReg3Alw;

    sArrStr = StrSelect.getStrNum();
    sArrStrName = StrSelect.getStrName();

    PsActAvgVar actvar = new PsActAvgVar(sStore, sFrom, sTo, sUser);

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
    String sVaTMC = null;

    String sOth1Avg = null;
    String sOth2Avg = null;
    String sOth1Pay = null;
    String sOth2Pay = null;
    String sOth1Var = null;
    String sOth2Var = null;

    boolean bUnfold = true; // sFrom.equals("BEGWEEK");


    java.util.Date dCurDate = new java.util.Date();
    SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
    String sCurDate = sdf.format(dCurDate);

    String sPrepStmt = "select pyr#, pmo#, pime from rci.fsyper"
      + " where pida='" + sTo + "'";
    //System.out.println(sPrepStmt);
    ResultSet rslset = null;
    RunSQLStmt runsql = new RunSQLStmt();
    runsql.setPrepStmt(sPrepStmt);
    runsql.runQuery();
    runsql.readNextRecord();
    String sYear = runsql.getData("pyr#");
    String sMonth = runsql.getData("pmo#");
    String sMnend = runsql.getData("pime");
    String sMonBeg = runsql.getData("pimb");
    runsql.disconnect();
    runsql = null;

    String [] sMonName =  new String[]{ "April", "May", "June", "July", "August", "September", "October", "November", "December", "January", "February", "March"};
    String sColor = "";
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
        td.DataTable2g { background: limegreen; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}
        td.DataTable2r { background: orangered; padding-top:3px; padding-bottom:3px; padding-left:3px;
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
<head><meta http-equiv="refresh" content="<%=lRefresh%>; url=index.jsp"/></head>

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variables
//==============================================================================
var CurrStr = "<%=sStore%>";
var ArrStr = [<%=sArrStr%>];
var ArrStrNm = [<%=sArrStrName%>];
var CurrFrWk = "<%=sFrom%>";
var CurrToWk = "<%=sTo%>";
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
  var hdr = "Select Another Store/Week";

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

   if(CurrFrWk == "BEGWEEK")
   {
      for(var i=0; i < document.all.td2Dates.length; i++){ document.all.td2Dates[i].style.display = "none"}
      for(var i=0; i < document.all.td1Date.length; i++){ document.all.td1Date[i].style.display = "block"}
   }
   else
   {
      for(var i=0; i < document.all.td2Dates.length; i++){ document.all.td2Dates[i].style.display = "block"}
      for(var i=0; i < document.all.td1Date.length; i++){ document.all.td1Date[i].style.display = "none"}
   }
}
//--------------------------------------------------------
// populate Column Panel
//--------------------------------------------------------
function popSelWk()
{
  var panel = "<table border=0 cellPadding=0 cellSpacing=0>"
    + "<tr>"
       + "<td class='Prompt1'>Store:</td>"
       + "<td class='Prompt1' colspan=2><select name='selStr' class='Small'></select>"
    + "</tr>"
    + "<tr>"
       + "<td class='Prompt1' id='td1Date'>Week:</td>"
       + "<td class='Prompt' id='td1Date' colspan=2><select name='selWeek' class='Small'></select>"
    + "</tr>"
    + "<tr>"
       + "<td class='Prompt1' id='td2Dates'>From:</td>"
       + "<td class='Prompt1' id='td2Dates'>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;FrDate&#34;)'>&#60;</button>"
          + "<input name='FrDate' class='Small' readonly>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;FrDate&#34;)'>&#62;</button>"
       + "</td>"
       + "<td class='Prompt1' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 255, 10, document.all.FrDate)'>"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
    + "</tr>"
    + "<tr>"
       + "<td class='Prompt1' id='td2Dates'>To:</td>"
       + "<td class='Prompt1' id='td2Dates'>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;ToDate&#34;)'>&#60;</button>"
          + "<input name='ToDate' class='Small' readonly>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;ToDate&#34;)'>&#62;</button>"
       + "</td>"
       + "<td class='Prompt1' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 255, 10, document.all.ToDate)'>"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
     + "</tr>"
     + "<tr>"
       + "<td class='Prompt1' id='td2Dates' colspan=3>Selected dates must be a Sunday.</td>"
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
   <%if(bReg1Alw){%>ArrStr[ArrStr.length] = "Reg 1"; ArrStrNm[ArrStrNm.length] = "";<%}%>
   <%if(bReg2Alw){%>ArrStr[ArrStr.length] = "Reg 2"; ArrStrNm[ArrStrNm.length] = "";<%}%>
   <%if(bReg3Alw){%>ArrStr[ArrStr.length] = "Reg 3"; ArrStrNm[ArrStrNm.length] = "";<%}%>

   var i = 0;
   <%if(!sStrAllowed.startsWith("ALL")){%>i=1;<%}%>

   for(var j=0; i < ArrStr.length; i++, j++)
   {
     document.all.selStr.options[j] = new Option(ArrStr[i] + "-" + ArrStrNm[i], ArrStr[i]);
     if(ArrStr[i] == CurrStr){ document.all.selStr.selectedIndex = j; }
   }
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
       if(cvtDt == CurrToWk){ document.all.selWeek.selectedIndex = i; }
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
   if(CurrFrWk == "BEGWEEK")
   {
      document.all.FrDate.value = CurrToWk;
      document.all.ToDate.value = CurrToWk;
   }
   else
   {
      document.all.FrDate.value = CurrFrWk;
      document.all.ToDate.value = CurrToWk;
   }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000 * 7);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000 * 7);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
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
   var error = false;
   var msg = "";
   var str = document.all.selStr.options[document.all.selStr.selectedIndex].value;

   var strid = 0;
   for(var i=0; i < ArrStr.length; i++)
   {
      if(ArrStr[i] == str){ strid = i; break; }
   }
   var strnm = ArrStrNm[strid];

   var week = document.all.selWeek.options[document.all.selWeek.selectedIndex].value;
   var frdate = document.all.FrDate.value.trim();
   var todate = document.all.ToDate.value.trim();

   if(document.all.td2Dates[0].style.display != "none")
   {
      var cdate = new Date(frdate);
      cdate.setHours(18);
      if(cdate.getDay() > 0)
      {
         error = true;
         msg += "Selected From Date is not a Sunday";
      }

      var cdate = new Date(todate);
      cdate.setHours(18);
      if(cdate.getDay() > 0)
      {
         error = true;
         msg += "\nSelected To Date is not a Sunday";
      }
   }

   var url = "PsActAvgVar.jsp?Store=" + str + "&StrNm=" + strnm;
   if(str == "ALL" || str == "Reg 1" || str == "Reg 2" || str == "Reg 3")
   {
      url = "PsActAvgVarCmpByGrp.jsp?Store=" + str + "&StrNm=" + strnm;
   }

   if(document.all.td2Dates[0].style.display != "block")
   {
     url += "&From=BEGWEEK&To=" + week
   }
   else
   {
      if(frdate=="" || todate ==""){ error = true; msg="From or(and) To dates are not selected." }
      else { url += "&From=" + frdate + "&To=" + todate; }
   }

   if(error){ alert(msg); }
   else { window.location.href = url; }
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

   var colSpanLn1 = 20;
   var colSpanLn2 = 6;
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

   var abhide = null;
   if(col=="Avg") { abhide = document.all.tdAbAvgHide; }
   if(col=="Pay") { abhide = document.all.tdAbPayHide; }

   // fold / unfold colomn cells
   for(var i=0; i < abhide.length; i++)
   {
      abhide[i].style.display = show;
   }


}
//==============================================================================
// set salaried detail linevisible
//==============================================================================
function setSlrDisp()
{
   var disp = "block";
   if(document.all.trDtl1[0].style.display == "block") { disp = "none"; }
   for(var i=0; i < document.all.trDtl1.length; i++)
   {
      document.all.trDtl1[i].style.display = disp;
   }
}
//==============================================================================
// get next or prior store
//==============================================================================
function getStore(dir)
{
   var strid = 0;
   for(var i=0; i < ArrStr.length; i++)
   {
      if(ArrStr[i] == CurrStr){ strid = i; break; }
   }
   var str = null;
   var strnm = null;

   if (dir == "UP"){ str = ArrStr[strid + 1];  strnm = ArrStrNm[strid + 1]; }
   if (dir == "DOWN"){ str = ArrStr[strid - 1]; strnm = ArrStrNm[strid - 1]; }

   var url = "PsActAvgVar.jsp?Store=" + str + "&StrNm=" + strnm;
   if(str == "ALL" || str == "Reg 1" || str == "Reg 2" || str == "Reg 3")
   {
      url = "PsActAvgVarCmpByGrp.jsp?Store=" + str + "&StrNm=" + strnm;
   }

   if(document.all.td2Dates[0].style.display != "block")
   {
     url += "&From=BEGWEEK&To=" + CurrToWk
   }
   else
   {
      url += "&From=" + CurrFrWk + "&To=" + CurrToWk;
   }

   window.location.href = url;
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
      <br>Store: <button onclick="getStore('DOWN')">&#60;</button><%=sStore + " - " + sStrNm%><button onclick="getStore('UP')">&#62;</button>
      <br>Weekending date:&nbsp;
      <%if(!sFrom.equals("BEGWEEK")){%> From <%=sFrom%> Through <%=sTo%><%} else {%><%=sTo%><%}%>
      </b>

      <br><br><a href="../" class="small"><font color="red">Home</font></a>&#62;
              <a href="PsActAvgVarSel.jsp" class="small"><font color="red">Selection</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;

      <a href="BfdgAvgWage.jsp?Year=<%=sYear%>&Month=<%=sMonth%>&MonName=<%=sMonName%>&Str=<%=sStore%>&Over=10&Under=10">Budget Average entries</a>
       &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      <a href="PsWkSched.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrNm%>&MONBEG=<%=sMonBeg%>&WEEKEND=<%=sTo%>">Weekly Schedule</a>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0" >
        <tr>
          <th class="DataTable" rowspan=3>N<br>o<br.></th>
          <th class="DataTable" rowspan=3>Budget Groups</th>
          <th class="DataTable" rowspan=3>&nbsp;</th>
          <th class="DataTable" colspan="3"># of Hours</th>
          <th class="DataTable" rowspan=3>&nbsp;</th>
          <th class="DataTable" id="thAvgLn1" colspan="23">
             <%if(bUnfold){%><a href="javascript: dispCols('Avg')">Avg. Wage</a><%} else {%>Avg. Wage<%}%>
          </th>
          <th class="DataTable" rowspan=3>&nbsp;</th>
          <th class="DataTable"  id="thPayLn1" colspan="23">
              <%if(bUnfold){%><a href="javascript: dispCols('Pay')">Payroll Dollars</a><%} else {%>Payroll Dollars<%}%>
          </th>
          <th class="DataTable" rowspan=3>&nbsp;</th>
          <th class="DataTable" colspan=7>Variance Due To &nbsp; ((Favorable) or Unfavorable)</th>
        </tr>
        <tr>
          <th class="DataTable" rowspan=2>Original Budget</th>
          <th class="DataTable" rowspan=2>Actual</th>
          <th class="DataTable" rowspan=2>Var<br>((Fav) or Unfav)</th>

          <th class="DataTable" id="thAvgLn2" colspan=7>Original Budget</th>
          <th class="DataTable" id="thAvgLn2b" rowspan=2>&nbsp;</th>
          <th class="DataTable" id="thAvgLn2" colspan=7>Actual</th>
          <th class="DataTable" id="thAvgLn2b" rowspan=2>&nbsp;</th>
          <th class="DataTable" id="thAvgLn2" colspan=7>Var<br>((Fav) or Unfav)</th>

          <th class="DataTable" id="thPayLn2" colspan=7>Original Budget</th>
          <th class="DataTable" id="thPayLn2b" rowspan=2>&nbsp;</th>
          <th class="DataTable" id="thPayLn2" colspan=7>Actual</th>
          <th class="DataTable" id="thPayLn2b" rowspan=2>&nbsp;</th>
          <th class="DataTable" id="thPayLn2" colspan=7>Var<br>((Fav) or Unfav)</th>

          <th class="DataTable" rowspan=2>Salaried</th>
          <th class="DataTable" colspan=5>Hourly</th>
          <th class="DataTable" rowspan=2>Total</th>
        </tr>
        <tr>
          <th class="DataTable" id="thAvgLn3">Pay</th>
          <th class="DataTable" id="thAvgLn3">Com</th>
          <th class="DataTable" id="thAvgLn3">Labor<br>Spiff</th>
          <th class="DataTable" id="thAvgLn3">Pay<br>Spiff</th>
          <th class="DataTable" id="thAvgLn3">"F" Code</th>
          <th class="DataTable" id="thAvgLn3">Other</th>
          <th class="DataTable">Total</th>

          <th class="DataTable" id="thAvgLn3">Pay</th>
          <th class="DataTable" id="thAvgLn3">Com</th>
          <th class="DataTable" id="thAvgLn3">Labor<br>Spiff</th>
          <th class="DataTable" id="thAvgLn3">Pay<br>Spiff</th>
          <th class="DataTable" id="thAvgLn3">"F" Code</th>
          <th class="DataTable" id="thAvgLn3">Other</th>
          <th class="DataTable">Total</th>

          <th class="DataTable" id="thAvgLn3">Pay</th>
          <th class="DataTable" id="thAvgLn3">Com</th>
          <th class="DataTable" id="thAvgLn3">Labor<br>Spiff</th>
          <th class="DataTable" id="thAvgLn3">Pay<br>Spiff</th>
          <th class="DataTable" id="thAvgLn3">"F" Code</th>
          <th class="DataTable" id="thAvgLn3">Other</th>
          <th class="DataTable">Total</th>

          <th class="DataTable" id="thPayLn3">Pay</th>
          <th class="DataTable" id="thPayLn3">Com</th>
          <th class="DataTable" id="thPayLn3">Labor<br>Spiff</th>
          <th class="DataTable" id="thPayLn3">Pay<br>Spiff</th>
          <th class="DataTable" id="thPayLn3">"F" Code</th>
          <th class="DataTable" id="thPayLn3">Other</th>
          <th class="DataTable">Total</th>

          <th class="DataTable" id="thPayLn3">Pay</th>
          <th class="DataTable" id="thPayLn3">Com</th>
          <th class="DataTable" id="thPayLn3">Labor<br>Spiff</th>
          <th class="DataTable" id="thPayLn3">Pay<br>Spiff</th>
          <th class="DataTable" id="thPayLn3">"F" Code</th>
          <th class="DataTable" id="thPayLn3">Other</th>
          <th class="DataTable">Total</th>

          <th class="DataTable" id="thPayLn3">Pay</th>
          <th class="DataTable" id="thPayLn3">Com</th>
          <th class="DataTable" id="thPayLn3">Labor<br>Spiff</th>
          <th class="DataTable" id="thPayLn3">Pay<br>Spiff</th>
          <th class="DataTable" id="thPayLn3">"F" Code</th>
          <th class="DataTable" id="thPayLn3">Other</th>
          <th class="DataTable">Total</th>

          <th class="DataTable">Hours</th>
          <th class="DataTable">Avg. Wage</th>
          <!--th class="DataTable">Bike<br>Builder</th -->
          <th class="DataTable">"F" Code</th>
          <th class="DataTable">Other</th>
          <!-- th class="DataTable">T/M/C</th -->
          <th class="DataTable">Total Hourly</th>
        </tr>
     <!------------------------- Budget Group --------------------------------------->
     <%
        String sSvBdgSec = "";
        int iSlr = 0;
        int iHrl = 1;
        String [] sSlrRow = new String[]{"1a", "1b", "1c"};

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
        sVaTMC = actvar.getVaTMC();

        sOth1Avg = actvar.getOth1Avg();
        sOth2Avg = actvar.getOth2Avg();
        sOth1Pay = actvar.getOth1Pay();
        sOth2Pay = actvar.getOth2Pay();
        sOth1Var = actvar.getOth1Var();
        sOth2Var = actvar.getOth2Var();
     %>
        <!-- Section Name -->
        <%if(!sSvBdgSec.equals(sSecBdg[i])){%>
            <!-- Section  Group Name -->
            <%if(sSecBdgNm[i].equals("Salaried")){%>
                <tr class="DataTable2" id="thSecNm">
                  <th class="DataTable">&nbsp;</th>
                  <td class="DataTable11" colspan="62">
                     Salaried
                     <%if(bSlrDtl){%>(<a href="javascript:setSlrDisp()">fold/unfold</a>)<%}%>
                  </td>
                </tr>
            <%}
              else if(sSecBdgNm[i].equals("Selling")){%>
                <tr class="DataTable2" id="thSecNm">
                  <th class="DataTable">&nbsp;</th>
                  <td class="DataTable11" colspan="62">Hourly</td>
                </tr>
            <%}%>

            <%if(!sSecBdgNm[i].equals("Salaried")){%>
                <tr class="DataTable3" id="thSecNm">
                  <td class="DataTable11" colspan="62"><%=sSecBdgNm[i]%></td>
                </tr>
            <%}%>
            <%sSvBdgSec = sSecBdg[i];%>
        <%}%>

        <!-- Store Details -->
        <tr class="DataTable" id="trDtl<%if(sSecBdg[i].equals("1")){%>1<%} else{%>2<%}%>"  <%if(sSecBdg[i].equals("1")){%>style="display:none;"<%}%>>
          <th class="DataTable">
             <%if(sSecBdg[i].equals("1")){%>
                <%=sSlrRow[iSlr]%><%iSlr++;%>
             <%}
             else{%><%=iHrl++%><%}%>

          </th>
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
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$.00</td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sBdgAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sOth1Avg%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sOth2Avg%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sActAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sOth1Avg%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sOth2Avg%></td>
          <td class="DataTable2" nowrap><%if(!sVarAvgTotPay.equals("N/A")){%>$<%}%><%=sVarAvgTotPay%></td>
          <th class="DataTable">&nbsp;</th>

          <!-- Total $'s -->
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$0</td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sBdgTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sOth1Pay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sOth2Pay%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sActTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sOth1Pay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sOth2Pay%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVarTotPay%></td>
          <th class="DataTable">&nbsp;</th>

          <!-------- Variance Due To Hourly -------->
          <td class="DataTable2<%if(!sSecBdg[i].equals("1")){%>p<%}%>">&nbsp;</td>
          <td class="DataTable2<%if(sSecBdg[i].equals("1")){%>p<%}%>" nowrap>&nbsp;<%if(!sSecBdg[i].equals("1")){%>$<%=sVaHrHrs%><%}%></td>
          <td class="DataTable2<%if(sSecBdg[i].equals("1")){%>p<%}%>" nowrap>&nbsp;<%if(!sSecBdg[i].equals("1")){%>$<%=sVaHrAvg%><%}%></td>
          <!-- td class="DataTable2<%if(!sGrpBdg[i].equals("BKBLD")){%>p<%}%>" nowrap>&nbsp;<%if(sGrpBdg[i].equals("BKBLD")){%>$<%=sVaBkBld%><%}%></td -->
          <td class="DataTable2<%if(sSecBdg[i].equals("1")){%>p<%}%>" nowrap>&nbsp;<%if(!sSecBdg[i].equals("1")){%>$<%=sOth1Var%><%}%></td>
          <td class="DataTable2<%if(sSecBdg[i].equals("1")){%>p<%}%>" nowrap>&nbsp;<%if(!sSecBdg[i].equals("1")){%>$<%=sVaOther%><%}%></td>
          <!-- td class="DataTable2<%if(!sGrpBdg[i].equals("TMC")){%>p<%}%>">&nbsp;<%if(sGrpBdg[i].equals("TMC")){%>$<%=sVaTMC%><%}%></td -->


          <td class="DataTable2<%if(sSecBdg[i].equals("1")){%>p<%}%>" nowrap>&nbsp;<%if(!sSecBdg[i].equals("1")){%>$<%=sVaHrTotHrl%><%}%></td>
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
        sVaTMC = actvar.getVaTMC();

        sOth1Avg = actvar.getOth1Avg();
        sOth2Avg = actvar.getOth2Avg();
        sOth1Pay = actvar.getOth1Pay();
        sOth2Pay = actvar.getOth2Pay();
        sOth1Var = actvar.getOth1Var();
        sOth2Var = actvar.getOth2Var();
        %>
        <tr class="DataTable3">
          <th class="DataTable"><%=iHrl++%></th>

          <td class="DataTable11" nowrap><%if(sSecBdgNm[i].equals("Salaried")){%>Total<%} else {%>Subtotal<%}%> <%=sSecBdgNm[i]%>
          <%if(sSecBdgNm[i].equals("Salaried")){%><sup>(1)</sup><%}%>
          </td>
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
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$.00</td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sBdgAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sOth1Avg%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sOth2Avg%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sActAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sOth1Avg%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sOth2Avg%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVarAvgTotPay%></td>
          <th class="DataTable">&nbsp;</th>

          <!-- Total $'s -->
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$0</td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sBdgTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sOth1Pay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sOth2Pay%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sActTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sOth1Pay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sOth2Pay%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVarTotPay%></td>
          <th class="DataTable">&nbsp;</th>

          <td class="DataTable2<%if(!sSecBdg[i].equals("1")){%>p<%}%>" nowrap>&nbsp;<%if(sSecBdg[i].equals("1")){%>$<%=sVaHrSlr%><%}%></td>
          <td class="DataTable2<%if(sSecBdg[i].equals("1")){%>p<%}%>" nowrap>&nbsp;<%if(!sSecBdg[i].equals("1")){%>$<%=sVaHrHrs%><%}%></td>
          <td class="DataTable2<%if(sSecBdg[i].equals("1")){%>p<%}%>" nowrap>&nbsp;<%if(!sSecBdg[i].equals("1")){%>$<%=sVaHrAvg%><%}%></td>
          <!-- td class="DataTable2<%if(!sSecBdg[i].equals("3")){%>p<%}%>" nowrap>&nbsp;<%if(sSecBdg[i].equals("3")){%>$<%=sVaBkBld%><%}%></td -->
          <td class="DataTable2<%if(sSecBdg[i].equals("1")){%>p<%}%>" nowrap>&nbsp;<%if(!sSecBdg[i].equals("1")){%>$<%=sOth1Var%><%}%></td>
          <td class="DataTable2<%if(sSecBdg[i].equals("1")){%>p<%}%>" nowrap>&nbsp;<%if(!sSecBdg[i].equals("1")){%>$<%=sOth2Var%><%}%></td>
          <!-- td class="DataTable2<%if(sSecBdg[i].equals("1")){%>p<%}%>" nowrap>&nbsp;<%if(!sSecBdg[i].equals("1")){%>$<%=sVaTMC%><%}%></td -->
          <td class="DataTable2<%if(sSecBdg[i].equals("1")){%>p<%}%>" nowrap>&nbsp;<%if(!sSecBdg[i].equals("1")){%>$<%=sVaHrTotHrl%><%}%></td>

          <%sColor="";%>
          <%if(sSecBdgNm[i].equals("Salaried") && sVaHrTotal.indexOf("(") >= 0 || sVaHrTotal.equals("0")){ sColor = "g"; }%>
          <%if(sSecBdgNm[i].equals("Salaried") && sVaHrTotal.indexOf("(") < 0 || sVaHrTotal.equals("0")){ sColor = "r"; }%>
          <td class="DataTable2<%=sColor%>" nowrap>&nbsp;$<%=sVaHrTotal%></td>

        </tr>
        <%if(sSecBdgNm[i].equals("Salaried") && (sFrom.equals(sTo) || sFrom.equals("BEGWEEK"))){%>
            <%
               actvar.setEmpCount();
               String sSlrBdgEmp = actvar.getSlrBdgEmp();
               String sSlrActEmp = actvar.getSlrActEmp();
               String sSlrVarEmp = actvar.getSlrVarEmp();
            %>

            <tr class="DataTable31">
              <th class="DataTable"><%=iHrl++%></th>
              <td class="DataTable11" nowrap>&nbsp;Memo: # of salaried employees</td>
              <th class="DataTable" nowrap>&nbsp;</th>
              <td class="DataTable2" nowrap><%=sSlrBdgEmp%></td>
              <td class="DataTable2" nowrap><%=sSlrActEmp%></td>
              <td class="DataTable2" nowrap><%=sSlrVarEmp%></td>
              <th class="DataTable">&nbsp;</th>

              <!-- Average Wage -->
          <td class="DataTable2p" id="tdBkpAvg" colspan=6 nowrap>&nbsp;</td>
          <td class="DataTable2p" nowrap>&nbsp;</td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2p" id="tdBkpAvg" colspan=6 nowrap>&nbsp;</td>
          <td class="DataTable2p" nowrap>&nbsp;</td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2p" id="tdBkpAvg" colspan=6 nowrap>&nbsp;</td>
          <td class="DataTable2p" nowrap>&nbsp;</td>
          <th class="DataTable">&nbsp;</th>

          <!-- Total $'s -->
          <td class="DataTable2p" id="tdBkpPay" colspan=6 nowrap>&nbsp;</td>
          <td class="DataTable2p" nowrap>&nbsp;</td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2p" id="tdBkpPay" colspan=6 nowrap>&nbsp;</td>
          <td class="DataTable2p" nowrap>&nbsp;</td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2p" id="tdBkpPay" colspan=6 nowrap>&nbsp;</td>
          <td class="DataTable2p" nowrap>&nbsp;</td>
          <th class="DataTable">&nbsp;</th>

          <td class="DataTable2p" colspan=8 nowrap>&nbsp;</td>
            </tr>
        <%}%>

            <tr class="Divdr1"></td><td colspan=62>&nbsp;</td></tr>
         <%}%>
     <%}%>


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
        sVaTMC = actvar.getVaTMC();

        sOth1Avg = actvar.getOth1Avg();
        sOth2Avg = actvar.getOth2Avg();
        sOth1Pay = actvar.getOth1Pay();
        sOth2Pay = actvar.getOth2Pay();
        sOth1Var = actvar.getOth1Var();
        sOth2Var = actvar.getOth2Var();
     %>
     <tr class="Divdr1"></td><td colspan=62>&nbsp;</td></tr>
     <tr class="DataTable5">
       <th class="DataTable"><%=iHrl++%></th>

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
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$.00</td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sBdgAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sOth1Avg%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sOth2Avg%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sActAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sOth1Avg%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sOth2Avg%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVarAvgTotPay%></td>
          <th class="DataTable">&nbsp;</th>

          <!-- Total $'s -->
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$0</td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sBdgTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sOth1Pay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sOth2Pay%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sActTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sOth1Pay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sOth2Pay%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVarTotPay%></td>
          <th class="DataTable">&nbsp;</th>

          <td class="DataTable2p" nowrap>&nbsp;</td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrHrs%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrAvg%></td>
          <!-- td class="DataTable2" nowrap>&nbsp;$<%=sVaBkBld%></td -->
          <td class="DataTable2" nowrap>&nbsp;$<%=sOth1Var%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sOth2Var%></td>
          <!-- td class="DataTable2" nowrap>&nbsp;$<%=sVaTMC%></td -->
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrTotHrl%></td>
          <%sColor = "r";
            if(sVaHrTotal.indexOf("(") >= 0 || sVaHrTotal.equals("0")){ sColor = "g"; }%>
          <td class="DataTable2<%=sColor%>" nowrap>&nbsp;$<%=sVaHrTotal%></td>
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
        sVaTMC = actvar.getVaTMC();

        sOth1Avg = actvar.getOth1Avg();
        sOth2Avg = actvar.getOth2Avg();
        sOth1Pay = actvar.getOth1Pay();
        sOth2Pay = actvar.getOth2Pay();
        sOth1Var = actvar.getOth1Var();
        sOth2Var = actvar.getOth2Var();
     %>
     <tr class="Divdr1"></td><td colspan=62>&nbsp;</td></tr>
     <tr class="Divdr1"></td><td colspan=62>&nbsp;</td></tr>
     <tr class="DataTable5">
       <th class="DataTable"><%=iHrl++%></th>
       <td class="DataTable11" nowrap>Grand Total(Sal + Hrly)</td>
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
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$.00</td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sBdgAvgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sBdgAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sActAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sOth1Avg%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sOth2Avg%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sActAvgTotPay%></td>
          <th class="DataTable" id="tdBkpAvg">&nbsp;</th>

          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgPay%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgCom%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgLSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sVarAvgMSpiff%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sOth1Avg%></td>
          <td class="DataTable2" id="tdBkpAvg" nowrap>&nbsp;$<%=sOth2Avg%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVarAvgTotPay%></td>
          <th class="DataTable">&nbsp;</th>

          <!-- Total $'s -->
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$0</td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sBdgOther%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sBdgTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sActMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sOth1Pay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sOth2Pay%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sActTotPay%></td>
          <th class="DataTable" id="tdBkpPay">&nbsp;</th>

          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarPay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarCom%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarLSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sVarMSpiff%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sOth1Pay%></td>
          <td class="DataTable2" id="tdBkpPay" nowrap>&nbsp;$<%=sOth2Pay%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVarTotPay%></td>
          <th class="DataTable">&nbsp;</th>

          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrSlr%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrHrs%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrAvg%></td>
          <!-- td class="DataTable2" nowrap>&nbsp;$<%=sVaBkBld%></td -->
          <td class="DataTable2" nowrap>&nbsp;$<%=sOth1Var%></td>
          <td class="DataTable2" nowrap>&nbsp;$<%=sOth2Var%></td>
          <!-- td class="DataTable2" nowrap>&nbsp;$<%=sVaTMC%></td -->
          <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrTotHrl%></td>
          <%sColor = "r";
            if(sVaHrTotal.indexOf("(") >= 0 || sVaHrTotal.equals("0")){ sColor = "g"; }%>
          <td class="DataTable2<%=sColor%>" nowrap>&nbsp;$<%=sVaHrTotal%></td>
     </tr>

   <!--------------------- Alowable Budget Table --------------------------- -->
   <%
       actvar.setAlwBdgTot();
       String sAbEarnSlsHrs = actvar.getAbEarnSlsHrs();
       String sAbEarnSlsPay = actvar.getAbEarnSlsPay();
       String sAbEarnHSVHrs = actvar.getAbEarnHSVHrs();
       String sAbEarnHSVPay = actvar.getAbEarnHSVPay();
       String sAbHrs = actvar.getAbHrs();
       String sAbVarHrs = actvar.getAbVarHrs();
       String sAbAvg = actvar.getAbAvg();
       String sAbVarAvg = actvar.getAbVarAvg();
       String sAbPay = actvar.getAbPay();
       String sAbVarPay = actvar.getAbVarPay();
       String sAbVhHrs = actvar.getAbVhHrs();
       String sAbVhTotal = actvar.getAbVhTotal();
       String sAbVhTotHrl = actvar.getAbVhTotHrl();
       String sAbVhDiff = actvar.getAbVhDiff();
       String sAbSlrAvg = actvar.getAbSlrAvg();

       String sAbEarnSlsHrsVar = actvar.getAbEarnSlsHrsVar();
       String sAbEarnSlsPayVar = actvar.getAbEarnSlsPayVar();
       String sAbEarnHSVHrsVar = actvar.getAbEarnHSVHrsVar();
       String sAbEarnHSVPayVar = actvar.getAbEarnHSVPayVar();
       String sAbEarnAvgVar = actvar.getAbEarnAvgVar();
   %>
     <tr class="Divdr1"><td colspan=62>&nbsp;</td></tr>
     <tr class="Divdr1"><td colspan=62>&nbsp;</td></tr>

     <tr style="border:none;">
        <td colspan=62 style="color:blue; background:gold; text-align:center;">
         Add Adjustments (to Hourly) from Allowable Budget<!--sup>(2)</sup-->
        </td>
     </tr>

     <tr class="DataTable5">
       <th class="DataTable"><%=iHrl++%></th>
       <td class="DataTable11" nowrap>$'s earned(lost) based on change<br> in allowable budgeted avg. hourly<br>rate (line 19)</td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2p" id="tdAbAvgHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <th class="DataTable" id="tdAbAvgHide">&nbsp;</th>
       <td class="DataTable2p" id="tdAbAvgHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <th class="DataTable" id="tdAbAvgHide">&nbsp;</th>
       <td class="DataTable2p" id="tdAbAvgHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>

       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2p" id="tdAbPayHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbEarnAvgVar%></td>
       <th class="DataTable" id="tdAbPayHide">&nbsp;</th>
       <td class="DataTable2p" id="tdAbPayHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <th class="DataTable" id="tdAbPayHide">&nbsp;</th>
       <td class="DataTable2p" id="tdAbPayHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbVhDiff%></td>

       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2p " id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbVhDiff%></td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbVhDiff%></td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbVhDiff%></td>
     </tr>

     <tr class="DataTable5">
       <th class="DataTable"><%=iHrl++%></th>
       <td class="DataTable11" nowrap>Hours/$'s Earned(lost) based on Sales</td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;<%=sAbEarnSlsHrs%></td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;<%=sAbEarnSlsHrsVar%></td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2p" id="tdAbAvgHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <th class="DataTable" id="tdAbAvgHide">&nbsp;</th>
       <td class="DataTable2p" id="tdAbAvgHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <th class="DataTable" id="tdAbAvgHide">&nbsp;</th>
       <td class="DataTable2p" id="tdAbAvgHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2p" id="tdAbPayHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbEarnSlsPayVar%></td>
       <th class="DataTable" id="tdAbPayHide">&nbsp;</th>
       <td class="DataTable2p" id="tdAbPayHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <th class="DataTable" id="tdAbPayHide">&nbsp;</th>
       <td class="DataTable2p" id="tdAbPayHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbEarnSlsPayVar%></td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbEarnSlsPayVar%></td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbEarnSlsPay%></td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbEarnSlsPay%></td>
     </tr>

     <tr class="DataTable5">
       <th class="DataTable"><%=iHrl++%></th>
       <td class="DataTable11" nowrap>Hours/$'s Earned based on Salaried H,V, TMC</td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;<%=sAbEarnHSVHrs%></td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;<%=sAbEarnHSVHrsVar%></td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2p" id="tdAbAvgHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <th class="DataTable" id="tdAbAvgHide">&nbsp;</th>
       <td class="DataTable2p" id="tdAbAvgHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <th class="DataTable" id="tdAbAvgHide">&nbsp;</th>
       <td class="DataTable2p" id="tdAbAvgHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2p" id="tdAbPayHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbEarnHSVPay%></td>
       <th class="DataTable" id="tdAbPayHide">&nbsp;</th>
       <td class="DataTable2p" id="tdAbPayHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <th class="DataTable" id="tdAbPayHide">&nbsp;</th>
       <td class="DataTable2p" id="tdAbPayHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbEarnHSVPayVar%></td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbEarnHSVPayVar%></td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbEarnHSVPayVar%></td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbEarnHSVPayVar%></td>
     </tr>

     <tr class="DataTable5">
       <th class="DataTable"><%=iHrl++%></th>
       <td class="DataTable11" nowrap>Grand Total (Sal+Hrly) After Adjustment</td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;<%=sAbHrs%></td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;<%=sActHrs%></td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;<%=sAbVarHrs%></td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2" id="tdAbAvgHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbSlrAvg%></td>
       <th class="DataTable" id="tdAbAvgHide">&nbsp;</th>
       <td class="DataTable2" id="tdAbAvgHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sActAvgTotPay%></td>
       <th class="DataTable" id="tdAbAvgHide">&nbsp;</th>
       <td class="DataTable2" id="tdAbAvgHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbVarAvg%></td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2" id="tdAbPayHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbPay%></td>
       <th class="DataTable" id="tdAbPayHide">&nbsp;</th>
       <td class="DataTable2" id="tdAbPayHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sActTotPay%></td>
       <th class="DataTable" id="tdAbPayHide">&nbsp;</th>
       <td class="DataTable2" id="tdAbPayHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbVarPay%></td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sVaHrSlr%></td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbVhHrs%></td>
       <td class="DataTable2" nowrap>&nbsp;$<%=sVaHrAvg%></td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbVhTotHrl%></td>
       <%sColor = "r";
         if(sAbVhTotal.indexOf("(") >= 0 || sAbVhTotal.equals("0")){ sColor = "g"; }%>
       <td class="DataTable2<%=sColor%>" id="tdAlwBdg" nowrap>&nbsp;$<%=sAbVhTotal%></td>
     </tr>

     <%
       actvar.setTmcMemo();
       String [] sTmcHrs = actvar.getTmcHrs();
       String [] sTmcHrsVar = actvar.getTmcHrsVar();
       String [] sTmcAvg = actvar.getTmcAvg();
       String [] sTmcAvgVar = actvar.getTmcAvgVar();
       String [] sTmcPay = actvar.getTmcPay();
       String [] sTmcPayVar = actvar.getTmcPayVar();
       String [] sTmcVaHrs = actvar.getTmcVaHrs();
       String [] sTmcVaTotHrl = actvar.getTmcVaTotHrl();
       String [] sTmcVaTotal = actvar.getTmcVaTotal();
     %>
     <tr class="Divdr1"><td colspan=62>&nbsp;</td></tr>
     <tr class="Divdr1"><td colspan=62>&nbsp;</td></tr>

     <tr style="border:none;">
        <td colspan=62 style="color:blue; background:gold; text-align:center;">
         Memo: Training/Meetings/Clinics
        </td>
     </tr>

    <!--tr class="DataTable5">
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable11" nowrap>Salaried</td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;<%=sTmcHrs[1]%></td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;<%=sTmcHrsVar[1]%></td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2p" id="tdAbAvgHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <th class="DataTable" id="tdAbAvgHide">&nbsp;</th>
       <td class="DataTable2p" id="tdAbAvgHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sTmcAvg[1]%></td>
       <th class="DataTable" id="tdAbAvgHide">&nbsp;</th>
       <td class="DataTable2p" id="tdAbAvgHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sTmcAvgVar[1]%></td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2p" id="tdAbPayHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <th class="DataTable" id="tdAbPayHide">&nbsp;</th>
       <td class="DataTable2" id="tdAbPayHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sTmcPay[1]%></td>
       <th class="DataTable" id="tdAbPayHide">&nbsp;</th>
       <td class="DataTable2p" id="tdAbPayHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sTmcPayVar[1]%></td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sTmcVaHrs[1]%></td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2p" nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sTmcVaTotHrl[1]%></td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sTmcVaTotal[1]%></td>
     </tr -->

     <tr class="DataTable5">
       <th class="DataTable"><%=iHrl++%></th>
       <td class="DataTable11" nowrap>Hourly TMC</td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;<%=sTmcHrs[0]%></td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;<%=sTmcHrsVar[0]%></td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2p" id="tdAbAvgHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <th class="DataTable" id="tdAbAvgHide">&nbsp;</th>
       <td class="DataTable2p" id="tdAbAvgHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sTmcAvg[0]%></td>
       <th class="DataTable" id="tdAbAvgHide">&nbsp;</th>
       <td class="DataTable2p" id="tdAbAvgHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sTmcAvgVar[0]%></td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2p" id="tdAbPayHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <th class="DataTable" id="tdAbPayHide">&nbsp;</th>
       <td class="DataTable2p" id="tdAbPayHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sTmcPay[0]%></td>
       <th class="DataTable" id="tdAbPayHide">&nbsp;</th>
       <td class="DataTable2p" id="tdAbPayHide" colspan=6 nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sTmcPayVar[0]%></td>
       <th class="DataTable" id="tdAlwBdg">&nbsp;</th>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sTmcVaHrs[0]%></td>
       <td class="DataTable2p" nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2p" id="tdAlwBdg" nowrap>&nbsp;</td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sTmcVaTotHrl[0]%></td>
       <td class="DataTable2" id="tdAlwBdg" nowrap>&nbsp;$<%=sTmcVaTotal[0]%></td>
     </tr>


   </table>


  </table>

  <p style="font-size:12px">
  Note: Salaried employees - H, S, V is <b>included</b> in budgeted and actual payroll hours and dollars.
  <br>&nbsp; &nbsp; &nbsp; &nbsp; : Hourly employees - H, S, V is <b>excluded</b> in budgeted and actual payroll hours and dollars.

  <br><br><sup>(1)</sup># of hours budgeted for each salaried employee is 45 hours per week.
  <br><sup>(2)</sup>Hours and dollars for TMC are not budgeted but are included in "Actual".
  <!-- <br><sup>(2)</sup>
   Adjustment from Allowable Budget pertaining to hours/$'s earned due to coverage
   for salaried H, S, V are excluded  from this worksheet as the actual amount included
   above for salaried employees already exclude the hours/$'s for salaried H,S,V. Most
   likely, we will always see a favorable variance in the salaried section as we do not budget for H,S,V.
  -->
 </body>

</html>
<%actvar.disconnect();%>

<%}%>






