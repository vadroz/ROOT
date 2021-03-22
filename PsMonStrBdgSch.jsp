<%@ page import="rciutility.StoreSelect, payrollreports.PsMonStrBdgSch, java.util.*, java.text.*"%>
<%
   String sSelStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sMonth = request.getParameter("MONBEG");
   String sGroup = request.getParameter("GROUP");
   String sWkDate = null;
   String sExclude70 = request.getParameter("Exclude70");

   if (sGroup==null) { sGroup = "ALL";}
   if(sExclude70 == null){sExclude70 = "Y";}

   SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
   Calendar cal = Calendar.getInstance();
   cal.set(Integer.parseInt(sMonth.substring(6, 10)),
           Integer.parseInt(sMonth.substring(0, 2)) - 1,
           Integer.parseInt(sMonth.substring(3, 5)));
   cal.add(Calendar.DATE, -6);
   Date date = cal.getTime();
   sWkDate = df.format(date);

  //-------------- Security ---------------------
  String sStrAllowed = null;
  String sAccess = null;
  Vector vStr = null;
  Iterator iter = null;
  String [] sStrAlwLst = null;

  String sUser = " ";
  String sAppl = "PAYROLL";

  if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
  {
     response.sendRedirect("SignOn1.jsp?TARGET=PsMonStrBdgSch.jsp&APPL=" + sAppl + "&" + request.getQueryString());
  }
   else {
     sAccess = session.getAttribute("ACCESS").toString();
     sStrAllowed = session.getAttribute("STORE").toString();
     sUser = session.getAttribute("USER").toString();

     if (sAccess != null && !sAccess.equals("1") && sStrAllowed.startsWith("ALL"))
     {
       response.sendRedirect("StrScheduling.html");
     }
  // -------------- End Security -----------------

  int iPass = 0;
  int iFail = 0;

  PsMonStrBdgSch monsch  = new PsMonStrBdgSch("STR", "1", "N", sExclude70, sUser);
  monsch.setWeekOfMonth(sMonth);
  int iNumOfWk = monsch.getNumOfWk();
  String [] sWeek = monsch.getWeek();
  String [] sWkActual = monsch.getWkActual();
  String sMonActual = monsch.getMonActual();
  String sYear = monsch.getFullYear();
  String sMonNum = monsch.getMonNum();
  monsch.setStrBudget(sSelStore);

  String [] sMonName = new String[]{ "April", "May", "June", "July", "August", "September", "October", "November", "December", "January", "February", "March" };
  int iMonNum = Integer.parseInt(sMonNum.trim()) - 1;

  // -----------------------------------------
  // Store Selector
  // -----------------------------------------
   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;
   if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
   {
       StrSelect = new StoreSelect(4);
   }
   else
   {
      vStr = (Vector) session.getAttribute("STRLST");
      iter = vStr.iterator();
      int iStrAlwLst = 0;
      sStrAlwLst = new String[vStr.size()];
      while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next();iStrAlwLst++;}
      if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
      else StrSelect = new StoreSelect(new String[]{sStrAllowed});
   }
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();
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
</style>
<SCRIPT language="JavaScript">
//==============================================================================
// Global variables
//==============================================================================
var Access = "<%=sAccess%>";
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];
var StrAllowed;
var Exclude70 = "<%=sExclude70%>"

<%if (sStrAllowed != null) {%>StrAllowed = "<%=sStrAllowed.trim()%>"<%}%>
var StrBegIdx = 0;
if (StrAllowed !="ALL"){ StrBegIdx = 1; }

var Actual = "<%=sMonActual%>";
var CompProd = new Array(<%=iNumOfWk%>);
var CompScore = new Array(<%=iNumOfWk%>);
var CompIdealArg = new Array(<%=iNumOfWk%>);

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

   if (Access=="1") {  doStrSelect(); }
   else
   {
     alert("Sorry, you are not authorized for this page.\n"
         + "If you've got this message in error - contact the HQ Help Desk.");
     window.location.href="index.html";
   }

   //switchOrigAllw();
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id)
{
    var df = document.forms[0];
    for (var i=0; i+StrBegIdx < stores.length; i++)
    {
        df.STORE.options[i] = new Option(stores[i + StrBegIdx] + " - " + storeNames[i + StrBegIdx],stores[i + StrBegIdx]);
    }
}
//==============================================================================
function submitForm()
//==============================================================================
{
   var SbmString = "PsMonStrBdgSch.jsp";
       SbmString = SbmString + "?STORE="
              + document.getStore.STORE.options[document.getStore.STORE.selectedIndex].value
              + "&STRNAME="
              + storeNames[document.getStore.STORE.selectedIndex + StrBegIdx]
              + "&MONBEG=<%=sMonth%>"
              + "Exclude70=" + Exclude70;
   // alert(SbmString);
    window.location.href=SbmString;
}
//==============================================================================
// show schedule summary with or without 70
//==============================================================================
function inclExcl70()
{
  var url = "PsMonStrBdgSch.jsp?STORE=<%=sSelStore%>"
         + "&STRNAME=<%=sThisStrName%>"
         + "&MONBEG=<%=sMonth%>"

   if(Exclude70 == "Y")  { url += "&Exclude70=N"; }
   if(Exclude70 == "N")  { url += "&Exclude70=Y"; }

   // alert(SbmString);
    window.location.href=url;

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

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

</head>


<body  onload="bodyLoad();">
<!----------------------------------------------------------------------------->
<div id="tooltip2" style="position:absolute;visibility:hidden; background-attachment: scroll;
          border: black solid 1px; width:150px;background-color:LemonChiffon; z-index:10"></div>
    <div align="CENTER" name="divTest" onMouseover="showtip2(this,event,' ');" onMouseout="hidetip2();" STYLE="cursor: hand"></div>
<div id="dvEmpList" class="dvEmpList"></div>
<!----------------------------------------------------------------------------->
   <table border="0" width="100%" height="100%" cellSpacing="0" cellPadding="0">
    <tr bgColor="moccasin">
     <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
        <br>Store Monthly Budget
        <br>Store: <%=sSelStore + " - " + sThisStrName%>
        <%if(sSelStore.equals("ALL") && sExclude70.equals("Y")){%>&nbsp;(Store 70 is excluded)<%}%>
        <br>Month Begining: <%=sMonth%>
      </b><br>

    <!------------- store selector ----------------------------->
      <form name="getStore" action="javascript:submitForm();">
      Select Store <SELECT name="STORE" class="Small"></SELECT>
      <input type="submit" value="GO" class="Small">
      </form>
    <!------------- store selector ----------------------------->

        <p align=left style="font-size:12px">
        <%if(sSelStore.equals("ALL")){%>
           <a href="javascript:inclExcl70()"><%if(sExclude70.equals("Y")){%>Include Str 70<%} else {%>Exclude Str 70<%}%></a><%for(int i=0; i < 20; i++){%>&nbsp;<%}%>
        <%}%>
        <%for(int i=0; i < 45; i++){%>&nbsp;<%}%>
        <a href="../"><font color="red">Home</font></a>&#62;
        <!--a href="StrScheduling.html"><font color="red">Payroll</font></a -->
        <a href="PsWkMonBdgSchSel.jsp"><font color="red">Week Selector</font></a>&#62;
        This page
        <%for(int i=0; i < 10; i++){%>&nbsp;<%}%>
        <!--a id="spOrigLnk" href="javascript: switchOrigAllw()">Allowable Budget</a>
        <a id="spAlwBdgLnk" href="javascript: switchOrigAllw()">Original Budget</a -->
<!------------- start of dollars table ------------------------>
      <table class="DataTable" align="center" >
             <tr>
               <th class="DataTable" rowspan="3">Week<br>End</th>
               <th class="DataTable" rowspan="3">S<br>t<br>a<br>t<br>u<br>s</th>
               <!-- th class="DataTable" rowspan="3">P<br>a<br>s<br>s<br>or<br>F<br>a<br>i<br>l</th -->
               <th class="DataTable" colspan="2" nowrap >My<br>Msg</th>
               <th class="DataTable" rowspan="3">T<br>o<br>t<br>a<br>l</th>

               <th class="DataTable" colspan="<%if(!sMonActual.equals("0")){%>3<%}%><%else{%>2<%}%>">Sales</th>

               <th class="DataTable1" rowspan="3"><%if(!sSelStore.equals("ALL")){%>C<br>o<br>v<%} else {%>&nbsp;<%}%></th>
               <th class="DataTable" id="thPayDlrLn1" colspan="<%if(!sMonActual.equals("0")){%>13<%}%><%else{%>7<%}%>">
                          Payroll Dollars &nbsp; &nbsp; <a href="javascript: foldCol('PayDlr', '2')">fold/unfold</a></th>
               <th class="DataTable" rowspan="3">&nbsp;</th>
               <th class="DataTable" id="thPayPrcLn1" colspan="<%if(!sMonActual.equals("0")){%>10<%}%><%else{%>7<%}%>">
                          Payroll % &nbsp; &nbsp; <a href="javascript: foldCol('PayPrc', '2')">fold/unfold</a></th>

               <th class="DataTable1"  rowspan="3">&nbsp;</th>

               <th class="DataTable" id="thPayHrsLn1" colspan="<%if(!sMonActual.equals("0")){%>11<%}%><%else{%>7<%}%>">
                          # of Hours &nbsp; &nbsp; <a href="javascript: foldCol('PayHrs', '2')">fold/unfold</a></th>

               <%if(!sMonActual.equals("0")){%>
                 <th class="DataTable1" rowspan="3">V<br>a<br>r<br>i<br>a<br>n<br>c<br>e</th>
               <%}
                 else {%><th class="DataTable1" rowspan="3">&nbsp;</th><%}%>

               <th class="DataTable" id="thPayAvgLn1" colspan="<%if(!sMonActual.equals("0")){%>10<%}%><%else{%>7<%}%>">
                          Average Wage &nbsp; &nbsp; <a href="javascript: foldCol('PayAvg', '2')">fold/unfold</a></th>

               <th class="DataTable1" rowspan=3>&nbsp;</th>
               <th class="DataTable" colspan="3">Sales Productivity</th>
             </tr>
             <!-- Header Line 2 -->
             <tr>
                <th class="DataTable" rowspan="2" nowrap>N<br>e<br>w</th>
                <th class="DataTable" rowspan="2" nowrap>R<br>p<br>l<br>y</th>

                <th class="DataTable" rowspan="2">Original<br>Sales<br>Plan</th>
                <th class="DataTable" rowspan="2">Forecast</th>
                <%if(!sMonActual.equals("0")){%>
                  <th class="DataTable" rowspan="2">Actual</th>
                <%}%>

                <th class="DataTable" id="thPayDlrLn2" colspan="3">Original<br>Budget</th>
                <th class="DataTable" id="thPayDlrLn2" colspan="5">Calc<br>per Schedule</th>
                <th class="DataTable">Budg. vs.<br>Sched.</th>
                <%if(!sMonActual.equals("0")){%>
                  <th class="DataTable" id="thPayDlrLn2" colspan="4">Actual</th>
                <%}%>

                <th class="DataTable" id="thPayPrcLn2" colspan="3">Original<br>Budget</th>
                <th class="DataTable" id="thPayPrcLn2" colspan="3">Calc per<br/>Schedule</th>
                <th class="DataTable">Budg. vs.<br>Sched.</th>

                <%if(!sMonActual.equals("0")){%>
                  <th class="DataTable" id="thPayPrcLn2" colspan="3">Actual</th>
                <%}%>

                <th class="DataTable" colspan="3" id="thPayHrsLn2">Original<br>Budget</th>

                <th class="DataTable" colspan="3" id="thPayHrsLn2">Calculated per Schedule</th>
                <th class="DataTable">Budg. vs.<br>Sched.</th>

                <%if(!sMonActual.equals("0")){%>
                  <th class="DataTable" colspan="3" id="thPayHrsLn2">Actual</th>
                  <th class="DataTable" rowspan="2">TMC</th>
                <%}%>

                <th class="DataTable" colspan="3" id="thPayAvgLn2">Original<br>Budget</th>
                <th class="DataTable" colspan="3" id="thPayAvgLn2">Calculated per Schedule</th>
                 <th class="DataTable">Budg. vs.<br>Sched.</th>

                <%if(!sMonActual.equals("0")){%>
                   <th class="DataTable" colspan="3" id="thPayAvgLn2">Actual</th>
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
                <%if(!sMonActual.equals("0")){%>
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
                <%if(!sMonActual.equals("0")){%>
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
                <%if(!sMonActual.equals("0")){%>
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
                <%if(!sMonActual.equals("0")){%>
                   <th class="DataTable" id="thPayAvgLn3">Salaried</th>
                   <th class="DataTable" id="thPayAvgLn3">Hourly<br>Subtotal</th>
                   <th class="DataTable">Total</th>
                <%}%>

                <!-- th class="DataTable">Avr<br>Wage/<br>Hrs</th -->
             </tr>

           <!-- ************************************************************ -->
           <!-- ------------------------- Weekd of the month -------------- -->
           <!-- ************************************************************ -->
           <%int k=0;%>
           <%for(int i=0; i < iNumOfWk; i++){%>
           <%
               if(sSelStore.equals("ALL")) { monsch.setAllStrWeekly(sWeek[i]); }
               else
               {
                  monsch.setWeekly(sWeek[i], "N");
                  monsch.setPlans(sSelStore);
                  monsch.setBudget();
               }

               String [][] sStrTot = monsch.getStrTot();

               monsch.setMsgBoard(sUser);
               String sApprvSts = monsch.getApproveStatus();
               String sNewReq = monsch.getNewReq();
               String sNewRsp = monsch.getNewRsp();
               String sNewTot = monsch.getNewTot();
           %>
            <tr>

                 <td class="DataTable" nowrap>
                    <a href="PsWkSched.jsp?STORE=<%=sSelStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeek[i]%>" target="_blank">
                              <%=sWeek[i]%></a></td>

                 <td class="DataTable6" nowrap>
                    <a href="Forum.jsp?STORE=<%=sSelStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeek[i]%>"
                       target="_blank">
                      <%if(!sApprvSts.equals(" ")){%><%=sApprvSts%><%} else {%>&nbsp;<%}%></a>
                 </td>
                 <!--td class="DataTable1" nowrap><%/*=sStrScore[7]*/%></td -->
                 <td class="DataTable6" nowrap><%=sNewReq%></td>
                 <td class="DataTable6" nowrap><%=sNewRsp%></td>
                 <td class="DataTable6" nowrap><a href="Forum.jsp?STORE=<%=sSelStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeek[i]%>"
                       target="_blank"><%=sNewTot%></a></td>

                 <td class="DataTable1" nowrap>$<%=sStrTot[0][0]%></td>
                 <td class="DataTable1" nowrap>$<%=sStrTot[0][74]%></td>
                 <%if(!sMonActual.equals("0")){%>
                   <td class="DataTable1" nowrap>$<%=sStrTot[0][1]%></th>
                 <%}%>
                 <th class="DataTable1">
                    <%if(!sSelStore.equals("ALL")){%>
                       <a href="EmpNumbyHourWk.jsp?STORE=<%=sSelStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeek[i]%>&WKDATE=<%=sWkDate%>&FROM=BUDGET&WKDAY=Monday%>" target="_blank">C</a>
                    <%} else {%>&nbsp;<%}%>
                 </th>

                 <!-- Payroll $'s -->
                 <td class="DataTable1" id="tdPayDlrBdg" nowrap>$<%=sStrTot[0][62]%></td><!-- Salaried Budget -->
                 <td class="DataTable1" id="tdPayDlrBdg" nowrap>$<%=sStrTot[0][65]%></td><!-- Hrl sub Budget -->
                 <td class="DataTable1" nowrap>$<%=sStrTot[0][2]%></td><!-- Budget -->
                 <td class="DataTable1" id="tdPayDlrScd" nowrap>$<%=sStrTot[0][52]%></td> <!-- Schedule Salaried -->
                 <td class="DataTable1" id="tdPayDlrScd" nowrap>$<%=sStrTot[0][49]%></td><!-- Hrly Subtotal -->

                 <th class="DataTable">
                    <%if(!sSelStore.equals("ALL")){%><a href="BfdgSchActWk.jsp?Store=<%=sSelStore%>&StrName=<%=sThisStrName%>&Wkend=<%=sWeek[i]%>" target="_blank">AB</a><%}
                     else {%><a href="BfdgSchActWkAllStr.jsp?Wkend=<%=sWeek[i]%>" target="_blank">AB</a><%}%>
                 </th>


                 <td class="DataTable1" nowrap>$<%=sStrTot[0][3]%></td><!-- Sched total -->
                 <td class="DataTable1" nowrap>$<%=sStrTot[0][30]%></td> <!-- Overtime pay -->
                 <td class="DataTable3" nowrap <%if(sStrTot[0][4].indexOf("-") < 0){%>style="color:red;"<%}%>>$<%=sStrTot[0][4]%></td> <!-- Over /under -->
                 <%if(!sMonActual.equals("0")){%>
                   <td class="DataTable1" id="tdPayDlrAct" nowrap>&nbsp;<%if(!sSelStore.equals("70")){%>$<%=sStrTot[0][36]%><%}%></th>
                   <td class="DataTable1" id="tdPayDlrAct" nowrap>&nbsp;<%if(!sSelStore.equals("70")){%>$<%=sStrTot[0][39]%><%}%></th>
                   <td class="DataTable1" nowrap>&nbsp;<%if(!sSelStore.equals("70")){%>$<%=sStrTot[0][5]%><%}%></th>
                   <td class="DataTable1" nowrap>&nbsp;<%if(!sSelStore.equals("70")){%>$<%=sStrTot[0][31]%><%}%></th>
                 <%}%>

                 <th class="DataTable">&nbsp;</th>

                 <!-- Payroll % -->
                 <td class="DataTable1" nowrap id="tdPayPrcBdg"><%=sStrTot[0][70]%>%</td>
                 <td class="DataTable1" nowrap id="tdPayPrcBdg"><%=sStrTot[0][73]%>%</td>
                 <td class="DataTable1" nowrap><%=sStrTot[0][6]%>%</td>
                 <td class="DataTable1" nowrap id="tdPayPrcScd"><%=sStrTot[0][55]%>%</td>
                 <td class="DataTable1" nowrap id="tdPayPrcScd"><%=sStrTot[0][51]%>%</td>
                 <td class="DataTable1" nowrap><%=sStrTot[0][7]%>%</td>
                 <td class="DataTable3" nowrap><%=sStrTot[0][8]%>%</td>
                 <%if(!sMonActual.equals("0")){%>
                   <td class="DataTable1" id="tdPayPrcAct" nowrap>&nbsp;<%if(!sSelStore.equals("70")){%><%=sStrTot[0][44]%>%<%}%></th>
                   <td class="DataTable1" id="tdPayPrcAct" nowrap>&nbsp;<%if(!sSelStore.equals("70")){%><%=sStrTot[0][47]%>%<%}%></th>
                   <td class="DataTable1" nowrap>&nbsp;<%if(!sSelStore.equals("70")){%><%=sStrTot[0][9]%>%<%}%></th>
                 <%}%>

                 <th class="DataTable1">&nbsp;</th>

                 <!-- # of Hours -->
                 <td class="DataTable1" nowrap id="tdPayHrsBdg"><%=sStrTot[0][58]%></td>
                 <td class="DataTable1" nowrap id="tdPayHrsBdg"><%=sStrTot[0][61]%></td>
                 <td class="DataTable7" nowrap><%=sStrTot[0][21]%></td>
                 <td class="DataTable1" nowrap id="tdPayHrsScd"><%=sStrTot[0][10]%></td>
                 <td class="DataTable1" nowrap id="tdPayHrsScd"><%=sStrTot[0][48]%></td>
                 <td class="DataTable3" nowrap><%=sStrTot[0][14]%></td>
                 <td class="DataTable7" nowrap <%if(sStrTot[0][22].indexOf("-") < 0){%>style="color:red;"<%}%>><%=sStrTot[0][22]%></td>
                 <%if(!sMonActual.equals("0")){%>
                   <td class="DataTable1" nowrap id="tdPayHrsAct">&nbsp;<%if(!sSelStore.equals("70")){%><%=sStrTot[0][32]%><%}%></th>
                   <td class="DataTable1" nowrap id="tdPayHrsAct">&nbsp;<%if(!sSelStore.equals("70")){%><%=sStrTot[0][35]%><%}%></th>
                   <td class="DataTable1" nowrap>&nbsp;<%if(!sSelStore.equals("70")){%><%=sStrTot[0][15]%><%}%></th>
                   <td class="DataTable1" nowrap>&nbsp;<%if(!sSelStore.equals("70")){%><%=sStrTot[0][29]%><%}%></th>
                 <%}%>

                 <%if(sWkActual[i].equals("1")){%>
                     <%if(sSelStore.equals("ALL")){%><th class="DataTable"><a href="PsActAvgVarAllStr.jsp?From=BEGWEEK&To=<%=sWeek[i]%>" target="_blank">V</a></th><%}
                     else { %><th class="DataTable"><a href="PsActAvgVar.jsp?Store=<%=sSelStore%>&StrNm=<%=sThisStrName%>&From=BEGWEEK&To=<%=sWeek[i]%>" target="_blank">V</a></th><%}%>
                 <%}
                 else {%><th class="DataTable1" nowrap>&nbsp;</th><%}%>

                 <!-- Average Wage -->
                 <td class="DataTable1" nowrap id="tdPayAvgBdg">$<%=sStrTot[0][66]%></td><!-- Budget -->
                 <td class="DataTable1" nowrap id="tdPayAvgBdg">$<%=sStrTot[0][69]%></td>
                 <td class="DataTable7" nowrap>$<%=sStrTot[0][23]%></td>
                 <td class="DataTable1" nowrap id="tdPayAvgScd">$<%=sStrTot[0][16]%></td><!-- Schedule -->
                 <td class="DataTable3" nowrap id="tdPayAvgScd">$<%=sStrTot[0][50]%></td>
                 <td class="DataTable1" nowrap>$<%=sStrTot[0][20]%></td>
                 <td class="DataTable7" nowrap>$<%=sStrTot[0][24]%></td>
                 <%if(!sMonActual.equals("0")){%>
                   <td class="DataTable1" nowrap id="tdPayAvgAct">&nbsp;<%if(!sSelStore.equals("70")){%>$<%=sStrTot[0][40]%><%}%></th>
                   <td class="DataTable1" nowrap id="tdPayAvgAct">&nbsp;<%if(!sSelStore.equals("70")){%>$<%=sStrTot[0][43]%><%}%></th>
                   <td class="DataTable1" nowrap>&nbsp;<%if(!sSelStore.equals("70")){%>$<%=sStrTot[0][28]%><%}%></th>
                 <%}%>

                 <th class="DataTable1" nowrap>&nbsp;</th>

                 <!-- Sales Productivity -->
                 <td class="DataTable1" nowrap>&nbsp;<%if(!sSelStore.equals("70")){%>$<%=sStrTot[0][25]%><%}%></td>
                 <td class="DataTable1" nowrap>&nbsp;<%if(!sSelStore.equals("70")){%>$<%=sStrTot[0][26]%><%}%></td>
                 <td class="DataTable3" nowrap>&nbsp;<%if(!sSelStore.equals("70")){%>$<%=sStrTot[0][27]%><%}%></td>
               </tr>
          <%}%>

         <!-- ************************************************************ -->
         <!-- -------------------- Company totals ------------------------ -->
         <!-- ************************************************************ -->
            <%
                monsch.setRepTot(sSelStore);
                String [] sRepTot = monsch.getRepTot();
            %>
            <tr>
               <td class="DataTable3">Total</td>

               <th class="DataTable1" colspan=4>&nbsp;</th>
               <td class="DataTable3" nowrap>$<%=sRepTot[0]%></td>
               <td class="DataTable5">$<%=sRepTot[74]%></td>
               <%if(!sMonActual.equals("0")){%>
                 <td class="DataTable3" nowrap>$<%=sRepTot[1]%></td>
               <%}%>
               <th class="DataTable1">&nbsp;</th>

               <!-- Payroll Dollars -->
               <td class="DataTable5" id="tdPayDlrBdg">$<%=sRepTot[62]%></td>
               <td class="DataTable5" id="tdPayDlrBdg">$<%=sRepTot[65]%></td>
               <td class="DataTable5">$<%=sRepTot[2]%></td>
               <td class="DataTable5" id="tdPayDlrScd">$<%=sRepTot[52]%></td>
               <td class="DataTable5" id="tdPayDlrScd">$<%=sRepTot[49]%></td>
               <th class="DataTable">
                    <%if(!sSelStore.equals("ALL")){%><a href="BfdgSchActMn.jsp?Store=<%=sSelStore%>&StrName=<%=sThisStrName%>&Year=<%=sYear%>&Month=<%=sMonNum%>&MonName=<%=sMonName[iMonNum]%>" target="_blank">AB</a><%}
                     else {%><a href="BfdgSchActMonAllStr.jsp?Store=<%=sSelStore%>&StrName=<%=sThisStrName%>&Year=<%=sYear%>&Month=<%=sMonNum%>&MonName=<%=sMonName[iMonNum]%>" target="_blank">AB</a><%}%>
               </th>
               <td class="DataTable5">$<%=sRepTot[3]%></td>
               <td class="DataTable5">$<%=sRepTot[30]%></td>
               <td class="DataTable5">$<%=sRepTot[4]%></td>
               <%if(!sMonActual.equals("0")){%>
                 <td class="DataTable5" id="tdPayDlrAct">$<%=sRepTot[36]%></td>
                 <td class="DataTable5" id="tdPayDlrAct">$<%=sRepTot[39]%></td>
                 <td class="DataTable5">$<%=sRepTot[5]%></td>
                 <td class="DataTable5">$<%=sRepTot[31]%></td>
               <%}%>

               <!-- Payroll % -->
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5" id="tdPayPrcBdg" nowrap><%=sRepTot[70]%>%</td>
               <td class="DataTable5" id="tdPayPrcBdg" nowrap><%=sRepTot[73]%>%</td>
               <td class="DataTable5" nowrap><%=sRepTot[6]%>%</td>
               <td class="DataTable5" id="tdPayPrcScd" nowrap><%=sRepTot[55]%>%</td>
               <td class="DataTable5" id="tdPayPrcScd" nowrap><%=sRepTot[51]%>%</td>
               <td class="DataTable5" nowrap><%=sRepTot[7]%>%</td>
               <td class="DataTable5" nowrap><%=sRepTot[8]%>%</td>
               <%if(!sMonActual.equals("0")){%>
                 <td class="DataTable5" id="tdPayPrcAct" nowrap><%=sRepTot[44]%>%</td>
                 <td class="DataTable5" id="tdPayPrcAct" nowrap><%=sRepTot[47]%>%</td>
                 <td class="DataTable5" nowrap><%=sRepTot[9]%>%</td>
               <%}%>

               <!-- # ofHours -->
               <th class="DataTable">&nbsp;</th>
               <td class="DataTable5" id="tdPayHrsBdg"><%=sRepTot[58]%></td>
               <td class="DataTable5" id="tdPayHrsBdg"><%=sRepTot[61]%></td>
               <td class="DataTable5"><%=sRepTot[21]%></td>
               <td class="DataTable5" id="tdPayHrsScd"><%=sRepTot[10]%></td>
               <td class="DataTable5" id="tdPayHrsScd"><%=sRepTot[13]%></td>
               <td class="DataTable5"><%=sRepTot[14]%></td>
               <td class="DataTable5" <%if(sRepTot[22].indexOf("-") < 0){%>style="color:red;"<%}%> nowrap><%=sRepTot[22]%></td>
               <%if(!sMonActual.equals("0")){%>
                 <td class="DataTable5" id="tdPayHrsAct"><%=sRepTot[32]%></td>
                 <td class="DataTable5" id="tdPayHrsAct"><%=sRepTot[35]%></td>
                 <td class="DataTable5"><%=sRepTot[15]%></td>
                 <td class="DataTable5"><%=sRepTot[29]%></td>
               <%}%>

               <th class="DataTable">&nbsp;</th>

               <!-- Avg Wage -->
               <td class="DataTable5" id="tdPayAvgBdg">$<%=sRepTot[66]%></td>
               <td class="DataTable5" id="tdPayAvgBdg">$<%=sRepTot[69]%></td>
               <td class="DataTable5">$<%=sRepTot[23]%></td>
               <td class="DataTable5" id="tdPayAvgScd">$<%=sRepTot[16]%></td>
               <td class="DataTable5" id="tdPayAvgScd">$<%=sRepTot[50]%></td>
               <td class="DataTable5">$<%=sRepTot[20]%></td>
               <td class="DataTable5">$<%=sRepTot[24]%></td>
               <%if(!sMonActual.equals("0")){%>
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


    </td>
   </tr>
  </table>
 </body>
</html>
<%
monsch.disconnect();
monsch = null;
}%>