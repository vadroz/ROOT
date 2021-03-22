<%@ page import="java.util.*, eventcalendar.EvtFisCal"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EvtFisCal.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    boolean bAll_EC_Auth = session.getAttribute("EVTCALCHG") != null;
    boolean bStr_EC_Auth = session.getAttribute("EVTCALSTR") != null;
    String sAuthStr = session.getAttribute("STORE").toString().trim();

    String sUser = session.getAttribute("USER").toString();
    String sYrMon = request.getParameter("YrMon");
    String [] sSelStore = new String[]{request.getParameter("Store")};

    EvtFisCal evtcal = new EvtFisCal(sYrMon, sSelStore, sUser);

    int iNumOfWeek = evtcal.getNumOfWeek();
    String [][] sDate = evtcal.getDate();
    int [] iNumOfWeekEvt = evtcal.getNumOfWeekEvt();
    int [][] iEvtArg = evtcal.getEvtArg();
    String [][][] sDayEvt = evtcal.getDayEvt();
    String sDateJsa = evtcal.getDateJsa();
    String sNumOfWeekEvtJsa = evtcal.getNumOfWeekEvtJsa();
    String sEvtArgJsa = evtcal.getEvtArgJsa();
    String sDayEvtJsa = evtcal.getDayEvtJsa();

    int iNumOfCol = evtcal.getNumOfCol();
    int [] iColSeq = evtcal.getColSeq();
    String [] sUsed = evtcal.getUsed();
    String [] sCol = evtcal.getCol();
    String sColJsa = evtcal.getColJsa();

    int iNumOfEvt = evtcal.getNumOfEvt();
    String [] sEvent = evtcal.getEvent();
    String [] sFrom = evtcal.getFrom();
    String [] sTo = evtcal.getTo();
    String [] sRemind = evtcal.getRemind();
    String [] sStrEvtTy = evtcal.getStrEvtTy();
    String [] sEvtTime = evtcal.getEvtTime();
    String [] sAuth = evtcal.getAuth();
    String [][] sEvtText = evtcal.getEvtText();
    String [][] sEvtStr = evtcal.getEvtStr();

    String sEvtStrJsa = evtcal.getEvtStrJsa();
    String sEventJsa = evtcal.getEventJsa();
    String sFromJsa = evtcal.getFromJsa();
    String sToJsa = evtcal.getToJsa();
    String sScopeJsa = evtcal.getScopeJsa();
    String sRemindJsa = evtcal.getRemindJsa();
    String sStrEvtTyJsa = evtcal.getStrEvtTyJsa();
    String sEvtTimeJsa = evtcal.getEvtTimeJsa();
    String sAuthJsa = evtcal.getAuthJsa();
    String sEvtTextJsa = evtcal.getEvtTextJsa();

    boolean [] bEvtMemo = evtcal.getEvtMemoExist();
    boolean [] bEvtSign = evtcal.getEvtSignExist();
    boolean [] bEvtAdv = evtcal.getEvtAdvExist();

    String sEvtMemo = evtcal.getEvtMemoJsa();
    String sEvtSign = evtcal.getEvtSignJsa();
    String sEvtOutPrt = evtcal.getEvtOutPrtJsa();
    String sEvtRciPrt = evtcal.getEvtRciPrtJsa();

    // Attached Advertising
    String sAdvMkt = evtcal.getAdvMktJsa();
    String sAdvMktName = evtcal.getAdvMktNameJsa();
    String sAdvNewspr = evtcal.getAdvNewsprJsa();
    String sAdvDate = evtcal.getAdvDateJsa();
    String sAdvComment = evtcal.getAdvCommentJsa();
    String sAdvDoc = evtcal.getAdvDocJsa();

    String sStrJsa = evtcal.getStrJsa(); // list of store selections

    evtcal.disconnect();
    String [] sMonth = {"April", "May", "June", "July", "August", "September", "October", "November",
      "December", "January", "February", "March"};
    int iMonth = Integer.parseInt(sYrMon.substring(4));

    // next Month
    int iNextMon = iMonth + 1;
    int iNextYear = Integer.parseInt(sYrMon.substring(0, 4));
    if (iMonth == 12) { iNextMon = 1; iNextYear++;}

    // next Month
    int iPrvMon = iMonth - 1;
    int iPrvYear = Integer.parseInt(sYrMon.substring(0, 4));
    if (iMonth == 1) { iPrvMon = 12; iPrvYear--;}
%>

<html>
<head>

<style>
  body {background:white;}
  a:link { color:blue;  font-size:10px;} a:visited { color:blue; font-size:10px;}  a:hover { color:blue; font-size:10px;}

  table.DataTable { border: darkred solid 1px; background:#e7e7e7; text-align:center;}
  tr.DataTable { background:ivory; font-family:Verdanda; text-align:center;
                 font-size:10px; font-weight:bold}
  th.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px;}

  tr.DataTable2 { background:white; font-family:Arial; vertical-align:top; text-align:left; font-size:10px;}
  tr.DataTable3 { background:ivory; font-family:Arial; vertical-align:top; text-align:left; font-size:10px;}
  td.DataTable { border-bottom: darkred solid 1px; border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px;
                 padding-right:3px; padding-left:3px;}
  td.DataTable1 { border-bottom: darkred solid 1px; border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px;
                 padding-right:3px; padding-left:3px; text-align:center;}
  tr.Divider { background:darkred; font-size:1px;}

  div.dvPrompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:350; background-color:LemonChiffon; z-index:100;
              text-align:center; font-size:10px}

  div.dvDoc { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:550; background-color:LemonChiffon; z-index:100;
              text-align:center; font-size:10px}

  div.dvStore { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:250; background-color:LemonChiffon; z-index:100;
              text-align:center; font-size:10px}

  .Colorbar0 { background:red;}
  .Colorbar1 { background:orange;}
  .Colorbar2 { background:yellow;}
  .Colorbar3 { background:green;}
  .Colorbar4 { background:blue;}
  .Colorbar5 { background:violet;}
  .Colorbar6 { background:salmon;}
  .Colorbar7 { background:lightblue; }
  .Colorbar8 { background:gold; }
  .Colorbar9 { background:brown; }

  .Small{ text-align:left; font-family:Arial; font-size:10px;}
  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
  td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
  td.Prompt { text-align:left; font-family:Arial; font-size:10px; }
  td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
  td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
@media screen
{
  th.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px;}
  td.PrintOnly { display:none}
}

@media print
{
   @page {size: 8.5in 14in landscape; }
   th.DataTable1 { display:none}
   td.PrintOnly { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px;}
}
</style>

<SCRIPT language="JavaScript">
var SelYrMon = ["<%=iPrvYear%>" + "<%=iPrvMon%>", "<%=iNextYear%>" + "<%=iNextMon%>"]
var SelStore = new Array();
<%for(int i=0; i < sSelStore.length; i++){%>SelStore[<%=i%>] = "<%=sSelStore[i]%>" <%}%>

var CalDate = [<%=sDateJsa%>];
var NumOfWeekEvt = [<%=sNumOfWeekEvtJsa%>];
var EvtArg = [<%=sEvtArgJsa%>];
var DayEvt = [<%=sDayEvtJsa%>];

var Column = [<%=sColJsa%>];

var ColHdg = ["Bike Focus", "Perm MD Dates - Effective", "Perm MD Dates - Packet", "Stores",
              "Outside Print 22 x 28 Major Hang", "Rci Produced 40 x 50 & 22 x 28 Store - Full Color",
              "PosterCreative and Buyer Turn-In", "Ship To Stores", "Release Price Chgs"];

var Event  = [<%=sEventJsa%>];
var From = [<%=sFromJsa%>];
var To = [<%=sToJsa%>];
var Scope = [<%=sScopeJsa%>];
var Remind = [<%=sRemindJsa%>];
var StrEvtTy = [<%=sStrEvtTyJsa%>];
var EvtTime = [<%=sEvtTimeJsa%>];
var EvtText = [<%=sEvtTextJsa%>];
var EvtStr = [<%=sEvtStrJsa%>];
var EvtMemo = [<%=sEvtMemo%>];
var EvtSign = [<%=sEvtSign%>];
var EvtOutPrt = [<%=sEvtOutPrt%>];
var EvtRciPrt = [<%=sEvtRciPrt%>];

// Advertising
var AdvMkt = [<%=sAdvMkt%>];
var AdvMktName = [<%=sAdvMktName%>];
var AdvDate = [<%=sAdvDate%>];
var AdvNewspr = [<%=sAdvNewspr%>];
var AdvComment = [<%=sAdvComment%>];
var AdvDoc = [<%=sAdvDoc%>];

var Stores = [<%=sStrJsa%>];
var AuthStr = "<%=sAuthStr%>";
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
  setBoxclasses(["BoxName",  "BoxClose"], ["dvPrompt", "dvStore", "dvDoc"]);
  window.document.focus();
}
//--------------------------------------------------------
// Add, Update, Delete Event
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
    + "<tr><td class='Prompt' colspan=2>" + popPanel(arg)
     + "</tr></td>"
   + "</table>"

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.pixelLeft= document.documentElement.scrollLeft + 10;
   document.all.dvPrompt.style.pixelTop= document.documentElement.scrollTop + 135;
   document.all.dvPrompt.style.visibility = "visible";

   popPanelValues(arg);

   //popStrEvent(arg)

}

//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popPanel(arg)
{
  var posX = document.documentElement.scrollLeft + 600;
  var posY = document.documentElement.scrollTop + 60;
  var dummy = "<table>"

  var panel = "<table class='DataTable' cellPadding='0' cellSpacing='0'>"
      + "<tr class='DataTable3'><td class='DataTable'>Event</td>" + "<td class='DataTable'>" + Event[arg] + "</td></tr>"
      + "<tr class='DataTable3'><td class='DataTable'>From</td>"+ "<td class='DataTable'>" + From[arg] + "</td></tr>"
      + "<tr class='DataTable3'><td class='DataTable'>To</td>" + "<td class='DataTable'>" + To[arg] + "</td></tr>"

      // store event
      if(AuthStr != "ALL")
      {
         panel += "<input type='hidden' name='StrEvtTy' value='None'>"
         + "<br>Event Time<br><input class='Small' name='EvtTime'>"
      }

    for(var i=0; i < 9; i++)
    {
       panel += "<tr id='trColumn' class='DataTable3'><td class='DataTable'>" + ColHdg[i] + "</td>"
              + "<td class='DataTable' id='" + Column[i] + "'></td></tr>"
    }

    // event scope
    panel += "<tr id='trScope' class='DataTable3'>"
        + "<td class='DataTable'>Event Scope</td>" + "<td id='tdScope' class='DataTable'></td>"
      + "</tr>"

    // event memo links
    panel += "<tr id='trScope' class='DataTable3'>"
        + "<td class='DataTable'>Memo Link</td>"
        + "<td class='DataTable' id='tdMemo'></td>"
      + "</tr>"

    // event sign links
    panel += "<tr id='trScope' class='DataTable3'>"
        + "<td class='DataTable'>Sign Link</td>"
        + "<td class='DataTable' id='tdSign'></td>"
      + "</tr>"

    // event advertising links
    panel += "<tr id='trScope' class='DataTable3'>"
        + "<td class='DataTable'>Advertising Link</td>"
        + "<td class='DataTable' id='tdAdvert'></td>"
      + "</tr>"

    // buttons
    panel += "<tr class='DataTable3'>"
        + "<td class='DataTable' colspan=3><button onClick='hidePanel();' class='Small'>Close</button></td>"
      + "</tr>"
     + "</table>";
  return panel;
}

//--------------------------------------------------------
// populate values on entry panel
//--------------------------------------------------------
function popPanelValues(arg)
{
   // all column exclude stores
   for(var i=0; i < Column.length; i++)
   {
      if (i != 3)
      {
         if(EvtText[arg][i].trim() != "") document.all[Column[i]].innerHTML = EvtText[arg][i];
         else document.all[Column[i]].innerHTML = "&nbsp;"
      }
   }

   for(var i=0; i < EvtStr[arg].length; i++)
   {
      document.all[Column[3]].innerHTML += EvtStr[arg][i] + " ";
   }

   if(Scope[arg].trim()=="") document.all.tdScope.innerHTML = "All"
   else document.all.tdScope.innerHTML = Scope[arg].trim()

   // memo links
   if(EvtMemo[arg].length > 0)
   {
     document.all.tdMemo.innerHTML = "<a href='javascript:showDoc("+ arg +", &#34;MEMO&#34;)'>" + EvtMemo[arg].length + "</a>"
   }
   else {document.all.tdMemo.innerHTML = "None"}

   // sign links
   if(EvtSign[arg].length > 0)
   {
     document.all.tdSign.innerHTML = "<a href='javascript:showDoc(" + arg + ", &#34;SIGN&#34;)'>" + EvtSign[arg].length + "</a>"
   }
   else {document.all.tdSign.innerHTML = "None"}

   // sign links
   if(AdvDoc[arg].length > 0)
   {
     document.all.tdAdvert.innerHTML = "<a href='javascript:showAdv(" + arg + ")'>" + AdvDoc[arg].length + "</a>"
   }
   else {document.all.tdAdvert.innerHTML = "None"}
}

//--------------------------------------------------------
// populate Store event type and event time
//--------------------------------------------------------
function popStrEvent(arg, action)
{
   // event type for store
   if(action =='ADD' && AuthStr != "ALL")
   {
      document.all.StrEvtTy.options[0] = new Option("NONE", "None");
      document.all.StrEvtTy.options[1] = new Option("MEETING", "Meeting");
      document.all.StrEvtTy.options[2] = new Option("CLINIC", "Clinic");
      document.all.StrEvtTy.options[3] = new Option("STREVT", "Store Event");

      for(var i=0; i < 3; i++) {document.all.Scope[i].checked = false;}
      document.all.Scope[2].checked = true;
   }
}
//--------------------------------------------------------
// Replace &, # signs on escape sequense;
//--------------------------------------------------------
function String.prototype.replaceSpecChar()
{
    var s = this;
    var newStr = "";
    var obj = ["'", "#", "&", "%"];
    for(var i=0; i < s.length; i++)
    {
       var l = s.substring(i,i+1);
       for(var j=0; j < obj.length; j++)
       {
          if(l == obj[j])  {  l = escape(obj[j]); break; }
       }
       newStr += l;
    }
    return newStr;
}
//--------------------------------------------------------
// show  ',  &, # charachters on screen
//--------------------------------------------------------
function String.prototype.showSpecChar()
{
    var s = this;
    var chk = ["&#39;", "&#38;", "&#35;", "&#37;"];
    var exc = ["%27", "%26", "%23", "%25"];
    for(var i=0; i < chk.length; i++)
    {
       while (s.match(chk[i])) { s = s.replace(chk[i], unescape(exc[i])); }
    }
    return s;
}

//--------------------------------------------------------
// Submit group
//--------------------------------------------------------
function sbmEvent(action, evt, from, to, scope, remind, strevtty, evttime, cols)
{
  var url = "EvtCalEnt.jsp?"
     + "Event=" + evt
     + "&From=" + from
     + "&To=" + to
     + "&Scope=" + scope
     + "&Remind=" + remind
     + "&StrEvtTy=" + strevtty
     + "&EvtTime=" + evttime;

  for(var i=0;  i < cols.length; i++)
  {
     url += "&Col=" + cols[i]
  }

  url += "&Action=" + action;

  //alert(url)
  //window.location = url;
  window.frame1.location = url;
}
//--------------------------------------------------------
// display error for entry
//--------------------------------------------------------
function displayError(Error)
{
   alert(Error)
}
//--------------------------------------------------------
// restart page after entry done
//--------------------------------------------------------
function reStart()
{
  window.location.reload();
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvPrompt.innerHTML = " ";
   document.all.dvPrompt.style.visibility = "hidden";
   hideStrPanel()
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hideStrPanel()
{
   document.all.dvStore.innerHTML = " ";
   document.all.dvStore.style.visibility = "hidden";
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hideDocPanel()
{
   document.all.dvDoc.innerHTML = " ";
   document.all.dvDoc.style.visibility = "hidden";
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

   html += "<tr><td class='Prompt1' colspan=2>&nbsp;</td></tr>"

   // load event documents
   for(var i=0, start = 0; i < doc[arg].length; i++)
   {
       start = doc[arg][i].lastIndexOf("/") + 1; // find where document name starts.
       html += "<tr><td class='Prompt1' colspan=2>"
            + "<a target='_blank' href='" + doc[arg][i] + "'>" + doc[arg][i].substring(start) + "</a></td></tr>"
   }

   if(doc[arg].length == 0) html += "<tr><td class='Prompt1' colspan=2>No documents attached to the event.</td></tr>"

   html += "<tr><td class='Prompt1' colspan=2>&nbsp;</td></tr>"
   html += "<tr><td class='Prompt1' colspan=2>"


   html += "<button onClick='hideDocPanel();' class='Small'>Close</button></td></tr>"
      + "</table>"

   if(doc[arg].length < 10) document.all.dvDoc.style.height = doc[arg].length * 25;

   document.all.dvDoc.innerHTML = html;
   document.all.dvDoc.style.pixelLeft= document.documentElement.scrollLeft + 400;
   document.all.dvDoc.style.pixelTop= document.documentElement.scrollTop + 130;
   document.all.dvDoc.style.visibility = "visible";
}
//--------------------------------------------------------
// show Advertising list
//--------------------------------------------------------
function showAdv(arg)
{
   var hdr = " Advertising List: " + Event[arg];

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"

   html += "<tr><td class='Prompt1' colspan=2>&nbsp;</td></tr>"
   html += "<tr><td class='Prompt1' colspan=2><table class='DataTable' width='100%' cellPadding=0 cellSpacing=0>"
   html += "<tr class='DataTable'><th class='DataTable'>Market</th>"
         + "<th class='DataTable'>Publishing<br>Date</th>"
         + "<th class='DataTable'>Newspaper</th>"
         + "<th class='DataTable'>Document</th>"
         + "<th class='DataTable'>Comment</th>"
         + "</tr>"

   // load event documents
   for(var i=0, start = 0; i < AdvMkt[arg].length; i++)
   {
       html += "<tr class='DataTable2' nowrap><td class='DataTable'>" + AdvMkt[arg][i] + " - " +AdvMktName[arg][i] +  "</td>"
       html += "<td class='DataTable'>&nbsp;"
       for(var j=0; j < 7; j++)
       {
          if(AdvDate[arg][i][j] !="" ) html += AdvDate[arg][i][j] + "&nbsp;"
       }

       html += "</td><td class='DataTable'>" + AdvNewspr[arg][i] + "</td>"
             + "<td class='DataTable' nowrap>";
       if(AdvDoc[arg][i].trim() != "")
       {
          html += "<a target='_blank' href='Advertising/" + AdvDoc[arg][i] + "'>" + AdvDoc[arg][i] + "</a>"
       }
       else { html += "&nbsp;"
       }
       html += "</td>"
            + "<td class='DataTable'>" + AdvDate[arg][i][0] + "&nbsp;</td>"
          + "</tr>"
   }

   if(AdvMkt[arg].length == 0) html += "<tr><td class='Prompt1' colspan=5>No Advertising attached to the event.</td></tr>"

   html += "</table></td></tr>"

   html += "<tr><td class='Prompt1' colspan=2>&nbsp;</td></tr>"
   html += "<tr><td class='Prompt1' colspan=2>"

   html += "<button onClick='hideDocPanel();' class='Small'>Close</button></td></tr>"
      + "</table>"

   if(AdvMkt[arg].length < 10) document.all.dvDoc.style.height = AdvMkt[arg].length * 25;

   document.all.dvDoc.innerHTML = html;
   document.all.dvDoc.style.pixelLeft= document.documentElement.scrollLeft + 400;
   document.all.dvDoc.style.pixelTop= document.documentElement.scrollTop + 130;
   document.all.dvDoc.style.visibility = "visible";
}
//--------------------------------------------------------
// show next or previous month
//--------------------------------------------------------
function showAnotherMonth(dir)
{
   var url = "EvtFisCal.jsp?YrMon=" + SelYrMon[dir]
   for(var i=0; i < SelStore.length; i++)
   {
       url += "&Store=" + SelStore[i]
   }
   //alert(url)
   window.location.href=url;
}
</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>

<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvPrompt" class="dvPrompt"></div>
<div id="dvDoc" class="dvDoc"></div>
<div id="dvStore" class="dvStore"></div>
<!-------------------------------------------------------------------->
  <table border="0" width="100%" height="100%">
     <tr bgColor="white">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Event Fiscal Calendar
       <br>
       <a href="javascript: showAnotherMonth(0)"><IMG SRC="arrowLeft.gif" style="border=none;" ALT="Previous Month"></a>
       Fiscal Year: <%=sYrMon.substring(0, 4)%> &nbsp; Month: <%=sMonth[iMonth-1]%>
       <a href="javascript: showAnotherMonth(1)"><IMG SRC="arrowRight.gif" style="border=none;" ALT="Next Month"></a><br>
       </b>

        <a href="../"><font color="red" size="-1">Home</font></a>;
        <a href="EvtFisCalSel.jsp"><font color="red" size="-1">Selection</font></a>;
        <!----------------- start of ad table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0" width="100%">
             <tr class="DataTable">
               <th class="DataTable" rowspan="2" >Event</th>
               <th class="DataTable" colspan="7" height="30">Calendar</th>
             </tr>
             <tr class="DataTable" height="30">
               <th class="DataTable">Monday</th>
               <th class="DataTable">Tuesday</th>
               <th class="DataTable">Wednesday</th>
               <th class="DataTable">Thursday</th>
               <th class="DataTable">Friday</th>
               <th class="DataTable">Saturday</th>
               <th class="DataTable">Sunday</th>
             </tr>
        <!--------------------- Event Detail ----------------------------->
        <%for(int i=0; i < iNumOfWeek; i++){%>
            <tr class="DataTable2">
              <td class="DataTable" width="20%" nowrap><br>
                  <%for(int j=0; j < iNumOfWeekEvt[i]; j++){%>
                     <a href="javascript: showEvent(<%=iEvtArg[i][j]-1%>)"><%=sEvent[iEvtArg[i][j]-1]%></a><br>
                  <%}%>
              </td>

              <%for(int j=0; j < 7; j++){%>
                  <td class="DataTable1"><%=sDate[i][j].substring(0, 5)%><br>
                      <%for(int k=0; k < iNumOfWeekEvt[i]; k++){%>
                         <%if(sDayEvt[i][k][j].equals("1")){%>
                            <span class="Colorbar<%=k%>"><%for(int l=0; l < 25; l++){%>&nbsp;<%}%></span><br>
                         <%}
                         else{%>&nbsp;<br><%}%>
                      <%}%>
                  </td>
              <%}%>
        <%}%>
       </table>
       <!----------------- start of ad table ------------------------>
      </td>
     </tr>
    </table>
  </body>
</html>
<%}%>