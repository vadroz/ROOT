<%@ page import="payrollreports.StrTmcLst, java.util.*, java.text.*"%>
<%
   String sStore = request.getParameter("Store");
   String sStrName = request.getParameter("StrName");
   String sWeekend = request.getParameter("Week");
   String sCurrwk = request.getParameter("Currwk");
   boolean bCurWk = sCurrwk.equals("true");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=StrTmcLst.jsp&APPL=ALL");
}
else
{
   SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
   Date date = sdf.parse(sWeekend);
   date = new Date(date.getTime() - 86400000 * 7);
   String [] sDateOfWk = new String[7];

   for(int i=0; i < 7; i++)
   {
      date = new Date(date.getTime() + 86400000);
      sDateOfWk[i] = sdf.format(date);
   }

    String sUser = session.getAttribute("USER").toString();

    StrTmcLst payent = new StrTmcLst(sStore, sWeekend, sUser);

    int iNumOfTmcType = payent.getNumOfTmcType();
    String [] sTmcType = payent.getTmcType();
    String [] sTmcTypeNm = payent.getTmcTypeNm();

    // store employees
    int iNumOfStrEmp = payent.getNumOfStrEmp();
    String [] sStrEmp = payent.getStrEmp();
    String [] sStrEmpName = payent.getStrEmpName();
    String sStrEmpJsa = payent.getStrEmpJsa();
    String sStrEmpNameJsa = payent.getStrEmpNameJsa();

    String [] sDayOfWk = new String[]{"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  
  table.DataTable { padding: 0px; border-spacing: 0; border-collapse: collapse;
             ; border: grey solid 1px; font-size:10px }
  table.DataTable1 { padding: 0px; border-spacing: 0; border-collapse: collapse; 
                background: LemonChiffon; border: grey solid 1px; font-size:10px }
  
  th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
  th.DataTable1 { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;font-size:10px }

  tr.DataTable { background: cornsilk; font-family:Arial; font-size:10px }
  tr.DataTable1 { background:white; font-family:Arial; font-size:10px }
  tr.DataTable2 { background:#e7e7e7; font-family:Arial; font-size:10px }
  tr.DataTable3 { background:Azure; font-family:Arial; font-size:10px }
  tr.Divider { font-size:3px }


  td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:left;}
  td.DataTable1{ cursor: hand; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:right;}
  td.DataTable2{ background: seashell;  padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:center;}
  td.DataTable3 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
  td.DataTable4 { background: lightgreen; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:right;}

  table.Help { background:white;text-align:center; font-size:12px;}

  div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
               width:250; background-color:LemonChiffon; z-index:10;
               text-align:center; font-size:10px}

        td.BoxName {cursor:move; background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left;font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center;font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
   .Small {font-family: times; font-size:10px }
</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript1.2">
var Stores = "<%=sStore%>"
var StoreNames = "<%=sStrName%>"

var StrEmp = [<%=sStrEmpJsa%>]
var StrEmpName = [<%=sStrEmpNameJsa%>]

var TmcNum = new Array();
var TmcDay = new Array();
var TmcDur = new Array();
var TmcCom = new Array();
var TmcEmp = new Array();
var TmcEmpNm = new Array();
var MaxTmc = 0;

//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//---------------------------------------------
// initialize value on load
//---------------------------------------------
function  bodyload()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvPrompt"]);
    //showError();
}
//==============================================================================
// show Item change panel
//==============================================================================
function setEvent(evtType, evtTypeNm, tmc, action)
{
   var hdr = null;
   if (action=="ADD"){ hdr = "Create " + evtTypeNm + " Event" }
   else if (action=="DLTEVT"){ hdr = "Delete " + evtTypeNm + " Event" }
   else if (action=="UPDEVT"){ hdr = "Update " + evtTypeNm + " Event" }

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
     + "<tr><td class='Prompt' colspan=2>"

    if(action=="ADD" || action=="UPDEVT"){ html += popEventPanel(evtType, tmc, action) }
    else if(action=="DLTEVT"){ html += popDltEvent(evtType, tmc, action)}


    html += "</td></tr></table>"

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvPrompt.style.pixelTop= document.documentElement.scrollTop + 65;
   document.all.dvPrompt.style.visibility = "visible";

   if (action=="UPDEVT")
   {
      var tmcarg = getTmcArg(tmc);
      document.all.Comment.value = getComment(tmcarg);
      document.all.Day[getEventDay(tmcarg)].checked = true;
      document.all.EvtDur.value = getEventDur(tmcarg);
      searchSelEmp(tmcarg);
   }
}
//==============================================================================
// populate Event Entry Panel
//==============================================================================
function popEventPanel(evtType, tmc, action)
{
  var panel = "<table class='DataTable1'>"

  // Event comment
  panel += "<tr><td class='Prompt2' nowrap>Event Heading:&nbsp;&nbsp;</td>"
         + "<td class='Prompt' nowrap><textarea class='Small' name='Comment' id='Comment' cols=80 rows=4></textarea>"
         + "<input type='hidden' name='Type' value='" + evtType + "'>"
         + "<input type='hidden' name='TmcNum' value='" + tmc + "'>"
         + "</td></tr>";

  // Day
  panel += "<tr><td class='Prompt2' nowrap>Day:&nbsp;&nbsp;</td>"
         + "<td class='Prompt' nowrap>"
           + "<input type='radio' class='Small' name='Day' value='0'>Mon &nbsp; "
           + "<input type='radio' class='Small' name='Day' value='1'>Tue &nbsp; "
           + "<input type='radio' class='Small' name='Day' value='2'>Wed &nbsp; "
           + "<input type='radio' class='Small' name='Day' value='3'>Thu &nbsp; "
           + "<input type='radio' class='Small' name='Day' value='4'>Fri &nbsp; "
           + "<input type='radio' class='Small' name='Day' value='5'>Sat &nbsp; "
           + "<input type='radio' class='Small' name='Day' value='6'>Sun&nbsp;"
         + "</td></tr>";

  // Event duration
  panel += "<tr><td class='Prompt2' nowrap>Event Duration (in hours):&nbsp;&nbsp;</td>"
         + "<td class='Prompt' nowrap><input class='Small' name='EvtDur' size='11' maxlength='11'></textarea>"
         + "</td></tr>";


     panel += "<tr>"
           + "<td style='border: ridge 2px; background:Azure; font-size:10px ' colspan=2 nowrap>"
              + "<table width='100%' cellPadding='0' cellSpacing='0'>"
              + popEmpList()
             + "</table></textarea>"
           + "</td></tr>";

  // buttons
  panel += "<tr><td class='Prompt1' colspan='2'>"
        + "<button id='Submit' onClick='ValidateEvtEnt(&#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;&nbsp;&nbsp;"
  panel += "</td></tr></table>";

  return panel;
}
//==============================================================================
// populate Employee List for Event
//==============================================================================
function popEmpList()
{
   var panel = "";
   for(var i=0, j=0; i < StrEmp.length; i++)
   {
      if(j==0){ panel += "<tr>"; }

      panel += "<td class='Prompt' nowrap><input name='EmpSel' type='checkbox' value='"
        + StrEmp[i] + "'>" + StrEmp[i] + " " + StrEmpName[i] + "</td>"
      if(j==3){ panel += "</tr>"; j=0;}
      else {   j++; }
   }
   return panel;
}
//==============================================================================
// populate Delete event Panel
//==============================================================================
function popDltEvent(evtType, tmc, action)
{
  var panel = "<tr><td class='Prompt1' colspan='2'>"
        + "<textarea class='Small' cols=80 rows=4 readonly>" + getComment(getTmcArg(tmc)) + "</textarea></td></tr>"
  // buttons
  panel += "<tr><td class='Prompt1' colspan='2'>Do you want to delete this event?<br>"
        + "<button id='Delete' onClick='ValidateDltEvt(&#34;" + evtType + "&#34;,&#34;"
           + tmc + "&#34;, &#34;" + action + "&#34;)' class='Small'>Delete</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;&nbsp;&nbsp;"
  panel += "</td></tr></table>";

  return panel;
}

//==============================================================================
// change Employee participation in array
//==============================================================================
function chgEvtEmp(type, typenm, tmc, emp, dur, action)
{
   var hdr = null;
   if (action=="DLTEMP"){ hdr = "Remove Employee From Event" }
   else if (action=="UPDEMP"){ hdr = "Update Employee For Event" }

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
     + "<tr><td class='Prompt' colspan=2>"

    html += popEvtEmp(type, tmc, emp, dur, action)

    html += "</td></tr></table>"

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvPrompt.style.pixelTop= document.documentElement.scrollTop + 65;
   document.all.dvPrompt.style.visibility = "visible";
}
//==============================================================================
// populate delete Employee
//==============================================================================
function popEvtEmp(type, tmc, emp, dur, action)
{
  var tmcarg = getTmcArg(tmc)

  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"

  // Event comment
  panel += "<tr><td class='Prompt'>Event Heading: </td>"
        + "<td class='Prompt'>" + getComment(tmcarg) + "</td></tr>"

  // Employee name and number
  panel += "<tr><td class='Prompt'>Employee: </td>"
        + "<td class='Prompt'>"
        + "<input class='Small' size=30 readonly value='" + emp + " " + getEvtEmpName(emp, tmcarg) + "'></td></tr>"

  // allow update event participation duration time
  if(action == "UPDEMP")
  {
     panel += "<tr><td class='Prompt' nowrap>Event Duration (in hours): </td>"
            + "<td class='Prompt'>"
            + "<input class='Small' name='EvtDur' size='11' maxlength='11' value='" + dur + "'></td></tr>"
     // buttons
     panel += "<tr><td class='Prompt1' colspan='2'>"
        + "<button id='Delete' onClick='ValidateUpdEmp(&#34;" + type + "&#34;,&#34;"
            + tmc + "&#34;, &#34;" + emp + "&#34;, &#34;" + action + "&#34;)' class='Small'>Update</button>&nbsp;"
  }
  else
  {
     // cancel
     panel += "<tr><td class='Prompt1' colspan='2'>Do you want to remove employee from this event?<br>"
             + "<button id='Delete' onClick='ValidateDltEmp(&#34;" + type + "&#34;,&#34;"
           + tmc + "&#34;, &#34;" + emp + "&#34;, &#34;" + action + "&#34;)' class='Small'>Delete</button>&nbsp;"
  }

  // cancel button
  panel += "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;&nbsp;&nbsp;"
  panel += "</td></tr></table>";

  return panel;
}
//==============================================================================
// find TMC in array
//==============================================================================
function getTmcArg(tmc)
{
  var arg = 0;
  for(var i=0; i < MaxTmc; i++)
  {
    if(TmcNum[i] == tmc){ arg = i; break}
  }
  return arg;
}
//==============================================================================
// retreive comment
//==============================================================================
function getComment(arg)
{
  return TmcCom[arg];
}
//==============================================================================
// retreive event day
//==============================================================================
function getEventDay(arg)
{
  return TmcDay[arg];
}
//==============================================================================
// retreive event duration
//==============================================================================
function getEventDur(arg)
{
  return TmcDur[arg];
}
//==============================================================================
// mark checkbox for selected employees
//==============================================================================
function searchSelEmp(arg)
{
   var emp = TmcEmp[arg];
   for(var i=0; i < emp.length; i++)
   {
       markSelEmp(emp[i]);
   }
}
//==============================================================================
// mark checkbox for selected employees
//==============================================================================
function markSelEmp(emp)
{
   for(var i=0; i < StrEmp.length; i++)
   {
      if(emp == StrEmp[i]){document.all.EmpSel[i].checked = true; break}
   }
}
//==============================================================================
// retrieve  event employee name
//==============================================================================
function getEvtEmpName(emp, tmcarg)
{
   var evtempall = TmcEmp[tmcarg];
   var empnum = null;
   var empnam = null;

   for(var i=0; i < evtempall.length; i++)
   {
       if(evtempall[i] == emp){ empnam = TmcEmpNm[tmcarg][i]; break; }
   }
   return empnam;
}
//==============================================================================
// hide panel
//==============================================================================
function hidePanel()
{
   document.all.dvPrompt.style.visibility = "hidden";
   SelItem = null;
   NewQty = null;
}
//==============================================================================
// validate payemnt entry screen
//==============================================================================
function ValidateEvtEnt(action)
{
   var msg ="";
   var error = false;

   // retrieve section type(T/M/C)
   var type = document.all.Type.value.trim();
   // retrieve T/M/C unique number (for update or delete)
   var tmcnum = document.all.TmcNum.value.trim();

   // check if comment entered
   var comment = document.all.Comment.value.trim().replaceSpecChar();
   if(comment == ""){ error = true; msg += "Enter event comment.\n" }

   // checked if day selected
   var dayfld = document.all.Day;
   var day = null;
   for(var i=0; i < dayfld.length; i++)
   {
      if(dayfld[i].checked){ day = dayfld[i].value; break}
   }
   if(day == null){ error = true; msg += "Check day of week.\n" }

   // check if event duration
   var evtdur = document.all.EvtDur.value.trim();
   if(evtdur == ""){ error = true; msg += "Enter event duration.\n" }
   else if( isNaN(evtdur)){ error = true; msg += "Event duration is not numeric.\n" }
   else if( eval(evtdur) <= 0){ error = true; msg += "Event duration must be grater than 0.\n" }

   // checked if employee selected
   var empfld = document.all.EmpSel;
   var emp = new Array();
   for(var i=0, j=0; i < empfld.length; i++)
   {
      if(empfld[i].checked){ emp[j] = empfld[i].value; j++;}
   }

   if(error){ alert(msg) }
   else { sbmPayEnt(type,tmcnum, comment, day, evtdur, emp, action)  }
}
//==============================================================================
// validate event deletion
//==============================================================================
function ValidateDltEvt(evtType, tmc, action)
{
   var msg ="";
   var error = false;

   if(error){ alert(msg) }
   else { sbmPayEnt(evtType, tmc, '*SAME', 0, '0', null, action)  }
}
//==============================================================================
// validate event deletion
//==============================================================================
function ValidateDltEmp(evtType, tmc, emp, action)
{
   var msg ="";
   var error = false;
   var emparr = [emp];

   if(error){ alert(msg) }
   else { sbmPayEnt(evtType, tmc, '*SAME', 0, '0', emparr, action)  }
}

//==============================================================================
// validate event deletion
//==============================================================================
function ValidateUpdEmp(evtType, tmc, emp, action)
{
   var msg ="";
   var error = false;
   var emparr = [emp];

   // check if event duration
   var evtdur = document.all.EvtDur.value.trim();
   if(evtdur == ""){ error = true; msg += "Enter event duration.\n" }
   else if( isNaN(evtdur)){ error = true; msg += "Event duration is not numeric.\n" }
   else if( eval(evtdur) <= 0){ error = true; msg += "Event duration must be grater than 0.\n" }

   if(error){ alert(msg) }
   else { sbmPayEnt(evtType, tmc, '*SAME', 0, evtdur, emparr, action)  }
}

//==============================================================================
// show Carton details
//==============================================================================
function sbmPayEnt(type,tmcnum, comment, day, evtdur, emp, action)
{
   var url = "StrTmcSav.jsp?Store=<%=sStore%>"
           + "&Week=<%=sWeekend%>"
           + "&Type=" + type
           + "&TmcNum=" + tmcnum
           + "&Cmt=" + comment
           + "&Day=" + day
           + "&Dur=" + evtdur

   if(emp != null) { for(var i=0; i < emp.length; i++) { url += "&Emp=" + emp[i] } }

   url += "&Action=" + action

   //alert(url)
   //window.location.href = url
   window.frame1.location.href = url
}
//==============================================================================
// restart after item entry
//==============================================================================
function reStart(err)
{
   msg = "";
   if(err != null && err.length > 0 )
   {
      for(var i=0; i < err.length; i++) { msg += err[i] + "\n"}
      alert(msg)
   }
   else { window.location.reload() }
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

</head>
<body onload="bodyload()">
<!-------------------------------------------------------------------->
  <div id="dvPrompt" class="Prompt"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

 <table border="0" width="100%" cellPadding="0" cellSpacing="0">
   <tr>
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Employee Training/Meeting/Clinic Entry
      <br>Store: <%=sStrName%> &nbsp;  &nbsp; &nbsp; &nbsp; Week: <%=sWeekend%>
      </b>
     <tr>
      <td ALIGN="center" VALIGN="TOP">

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="StrTmcLstSel.jsp"><font color="red" size="-1">Select Store/Week</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp<br><br>

      </td>
   </tr>

   <tr>
      <td ALIGN="center" VALIGN="TOP">

  <!----------------- beginning of table ------------------------>
  <table class="DataTable" cellPadding="0" cellSpacing="0">
    <tr>
      <th class="DataTable" rowspan=4>Event</th>
      <th class="DataTable1" rowspan=4>&nbsp;</th>
      <th class="DataTable" rowspan=4>D<br>e<br>l<br>e<br>t<br>e</th>
      <th class="DataTable1" rowspan=4>&nbsp;</th>
      <th class="DataTable" rowspan=4>U<br>p<br>d<br>a<br>t<br>e</th>
      <th class="DataTable1" rowspan=4>&nbsp;</th>
      <th class="DataTable" colspan=14>Days of Week</th>
      <th class="DataTable1" rowspan=4>&nbsp;</th>
      <th class="DataTable" rowspan=4>Total<br>Num<br>Emp</th>
      <th class="DataTable" rowspan=4>Total<br>Num<br>Hrs</th>
    </tr>

    <tr>
      <%for(int i=0; i < 7; i++){%>
         <th class="DataTable" colspan=2><%=sDayOfWk[i]%></th>
      <%}%>
    </tr>
    <tr>
      <%for(int i=0; i < 7; i++){%>
         <th class="DataTable" colspan=2><%=sDateOfWk[i]%></th>
      <%}%>
    </tr>
    <tr>
      <%for(int i=0; i < 7; i++){%>
         <th class="DataTable">Emp</th>
         <th class="DataTable">Hrs</th>
      <%}%>
    </tr>
<!------------------------------- Detail Data --------------------------------->
    <%
      for(int i=0; i<iNumOfTmcType; i++)
      {
        payent.setSecTot(sTmcType[i]);
        String [] sSecDayEmp = payent.getSecDayEmp();
        String [] sSecDayHrs = payent.getSecDayHrs();
        String sSecTotEmp = payent.getSecTotEmp();
        String sSecTotHrs = payent.getSecTotHrs();

        payent.setTMCArr(sTmcType[i]);
        int iNumOfTmc = payent.getNumOfTmc();
        String [] sTmcDate = payent.getTmcDate();
        String [] sTmcDay = payent.getTmcDay();
        String [] sTmcNum = payent.getTmcNum();
        String [] sTmcDur = payent.getTmcDur();
        String [] sTotEmp = payent.getTotEmp();
        String [] sTotHrs = payent.getTotHrs();
        String [] sComment = payent.getComment();
    %>
         <tr class="DataTable">
           <td class="DataTable"><%if(bCurWk){%>
              <a href="javascript: setEvent('<%=sTmcType[i]%>', '<%=sTmcTypeNm[i]%>', '0', 'ADD');"><%=sTmcTypeNm[i]%></a><%} else {%><%=sTmcTypeNm[i]%><%}%></td>

           <th class="DataTable1">&nbsp;</th>
           <td class="DataTable">&nbsp;</td>
           <th class="DataTable1">&nbsp;</th>
           <td class="DataTable">&nbsp;</td>
           <th class="DataTable1">&nbsp;</th>

           <%for(int k=0; k < 7; k++){%>
                <td class="DataTable3"><%=sSecDayEmp[k]%></td>
                <td class="DataTable3"><%if(!sSecDayEmp[k].equals("")){%><%=sSecDayHrs[k]%><%}%></td>
             <%}%>
           <th class="DataTable1">&nbsp;</th>
           <td class="DataTable3"><%=sSecTotEmp%></td>
           <td class="DataTable3"><%=sSecTotHrs%></td>
         </tr>

         <!---------------------------- T/M/C Loop ---------------------------->
         <%for(int j=0; j < iNumOfTmc; j++){%>
           <tr class="DataTable1">
             <td class="DataTable">&nbsp; &nbsp; &nbsp; &nbsp;<%=sComment[j]%>
                <script>TmcNum[MaxTmc] = "<%=sTmcNum[j]%>";
                     TmcDay[MaxTmc] = "<%=sTmcDay[j].trim()%>";
                     TmcDur[MaxTmc] = "<%=sTmcDur[j]%>";
                     TmcCom[MaxTmc] = "<%=sComment[j]%>";
                 </script>
             </td>

             <th class="DataTable1">&nbsp;</th>
             <td class="DataTable">
                <%if(bCurWk){%><a href="javascript: setEvent('<%=sTmcType[i]%>', '<%=sTmcTypeNm[i]%>', '<%=sTmcNum[j]%>' ,'DLTEVT');">D</a><%} else {%><%=sTmcTypeNm[i]%><%}%>
             </td>
             <th class="DataTable1">&nbsp;</th>
             <td class="DataTable">
                <%if(bCurWk){%><a href="javascript: setEvent('<%=sTmcType[i]%>', '<%=sTmcTypeNm[i]%>', '<%=sTmcNum[j]%>' ,'UPDEVT');">U</a><%} else {%><%=sTmcTypeNm[i]%><%}%>
             </td>
             <th class="DataTable1">&nbsp;</th>

             <%for(int k=0; k < 7; k++){%>
                <td class="DataTable<%if(Integer.parseInt(sTmcDay[j].trim()) == k ){%>4<%}%>" colspan=2>&nbsp;</td>
             <%}%>

             <th class="DataTable1">&nbsp;</th>
             <td class="DataTable3"><%=sTotEmp[j]%></td>
             <td class="DataTable3"><%=sTotHrs[j]%></td>
           </tr>

           <!------------------- Event Employee List -------------------------->
           <%// Event details
           payent.setEmpEvtArr(sTmcType[i], sTmcNum[j]);
           int iNumOfEmp = payent.getNumOfEmp();
           String [] sEmp = payent.getEmp();
           String [] sEmpNm = payent.getEmpNm();
           String [] sDur = payent.getDur();
           String sEmpJsa = payent.getEmpJsa();
           String sEmpNmJsa = payent.getEmpNmJsa();
           %>
              <script>TmcEmp[MaxTmc] = [<%=sEmpJsa%>]; TmcEmpNm[MaxTmc] = [<%=sEmpNmJsa%>]</script>
           <%
           for(int l=0; l < iNumOfEmp; l++)
           {%>
              <tr class="DataTable2">
                <td class="DataTable">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  <%=sEmp[l] + " " + sEmpNm[l]%>
                </td>

                <th class="DataTable1">&nbsp;</th>
                <td class="DataTable">
                    <%if(bCurWk){%><a href="javascript: chgEvtEmp('<%=sTmcType[i]%>', '<%=sTmcTypeNm[i]%>', '<%=sTmcNum[j]%>', '<%=sEmp[l]%>', 0, 'DLTEMP');">D</a><%} else {%><%=sTmcTypeNm[i]%><%}%>
                </td>
                <th class="DataTable1">&nbsp;</th>
                <td class="DataTable">
                    <%if(bCurWk){%><a href="javascript: chgEvtEmp('<%=sTmcType[i]%>', '<%=sTmcTypeNm[i]%>', '<%=sTmcNum[j]%>', '<%=sEmp[l]%>', '<%=sDur[l]%>','UPDEMP');">U</a><%} else {%><%=sTmcTypeNm[i]%><%}%>
                </td>
                <th class="DataTable1">&nbsp;</th>

             <%for(int k=0; k < 7; k++){%>
                <td class="DataTable<%if(Integer.parseInt(sTmcDay[j].trim()) == k ){%>4<%}%>" colspan=2>
                  <%if(Integer.parseInt(sTmcDay[j].trim()) == k ){%><%=sDur[l]%><%}%></td>
             <%}%>

             <th class="DataTable1">&nbsp;</th>
             <td class="DataTable">&nbsp;</td>
             <td class="DataTable">&nbsp;</td>
           </tr>
         <%}%>
         <script>MaxTmc++;</script>
       <%}%>
    <%}%>
    <%
       payent.setStrTot();
       String [] sStrDayEmp = payent.getStrDayEmp();
       String [] sStrDayHrs = payent.getStrDayHrs();
       String sStrTotEmp = payent.getStrTotEmp();
       String sStrTotHrs = payent.getStrTotHrs();
    %>

    <!---------------------------- Report Totals ------------------------------>
    <tr class="DataTable3">
      <td class="DataTable">Weekly Total</td>

      <th class="DataTable1">&nbsp;</th>
      <td class="DataTable">&nbsp;</td>
      <th class="DataTable1">&nbsp;</th>
      <td class="DataTable">&nbsp;</td>
      <th class="DataTable1">&nbsp;</th>

        <%for(int k=0; k < 7; k++){%>
                <td class="DataTable3"><%=sStrDayEmp[k]%></td>
                <td class="DataTable3"><%if(!sStrDayEmp[k].equals("")){%><%=sStrDayHrs[k]%><%}%></td>
             <%}%>

           <th class="DataTable1">&nbsp;</th>

           <td class="DataTable3"><%=sStrTotEmp%></td>
           <td class="DataTable3"><%=sStrTotHrs%></td>
    </tr>
<!---------------------------- end of Report Totals ------------------------------>
 </table>
 <!----------------------- end of table ------------------------>


  </table>
 </body>
</html>
<%
payent.disconnect();
payent = null;
}%>