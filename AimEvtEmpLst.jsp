<%@ page import="aim.AmEvtEmpLst, aim.AmEvt"%>
<%
   String sEvtId = request.getParameter("id");
   String sEvtName = request.getParameter("name");
   String sSort = request.getParameter("sort");

   if (sSort == null) { sSort = "NAME"; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=AmEvtLst.jsp&APPL=ALL");
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();

      AmEvtEmpLst emplst = new AmEvtEmpLst(sEvtId, sSort, sUser);

      AmEvt evtinf = new AmEvt(sEvtId, sUser);
      evtinf.setAmEvt();
      String sBegDt = evtinf.getBegDt();
      String sExpDt = evtinf.getExpDt();
      String sSts = evtinf.getSts();
      String sSngScr = evtinf.getSngScr();
      String sPrizeLvl = evtinf.getPrizeLvl();
      String sFreq = evtinf.getFreq();
      int iWeekday = evtinf.getWeekday();
      int iNumOfLvl = evtinf.getNumOfLvl();
      String [] sEvtScrLvl = evtinf.getEvtScrLvl();
      String sEvtScrLvlJsa = evtinf.getEvtScrLvlJsa();

      boolean bAllowAddScr = session.getAttribute("AIMSCR") != null;

      String [] sWkDayNm = new String[]{"&nbsp;", "Monday", "Tuesday", "Wednesday", "Thursday"
      , "Friday", "Saturday", "Sunday"};
%>

<html>
<head>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#ccffcc;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { background:red;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable3 { background:#cccfff;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#efefef; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:#ccffcc; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:#cccfff; font-family:Arial; font-size:11px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left; vertical-align:top}
        td.DataTable1 {padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top}
        td.DataTable1p {background:gray;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:right; vertical-align:top}

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150; background-color: white; z-index:10;
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

        .Small {font-size:10px;}
        <!--------------------------------------------------------------------->
</style>


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var EvtId = "<%=sEvtId%>";
var EvtName = "<%=sEvtName%>";

var SelEmp=null;
var SelName=null;
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);

}
//==============================================================================
// delete employee
//==============================================================================
function dltEmp(emp, name)
{
   var hdr = emp + " " + name;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popDltEmp(emp, name)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 400;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 80;
   document.all.dvItem.style.visibility = "visible";

}
//==============================================================================
// populate delete employee panel
//==============================================================================
function popDltEmp(emp, name)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable2'>"
         + "<td style='color:blue;font-size:14px' nowrap>&nbsp;<br><b>Are you sure you want to delete this employee?</b><br>&nbsp;</td>"
       + "</tr>"

  panel += "<tr><td class='Prompt1'><br><br>"
        + "<button onClick='sbmDltEmp(&#34;" + emp + "&#34;)' class='Small'>Delete</button>"
        + "<button onClick='hidePanel();' class='Small'>Close</button>"
        + "</td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// submit employee deletion
//==============================================================================
function sbmDltEmp(emp)
{
   var url = "AimEvtSv.jsp?id=" + EvtId + "&emp=" + emp + "&action=DLTEMP";
   window.frame1.location.href=url;
}
//==============================================================================
// show employee scores selection
//==============================================================================
function addEmpScr(emp, name)
{
   var hdr = emp + " " + name;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popAddEmpScr(emp, name)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 400;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 80;
   document.all.dvItem.style.visibility = "visible";

   getEvtScr();
   setDate("DOWN", document.all.ScrDt)
}
//==============================================================================
// populate delete employee panel
//==============================================================================
function popAddEmpScr(emp, name)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable2'>"
            + "<td class='Prompt1' nowrap>Select Score Level</td>"
            + "<td class='Prompt1' nowrap>Volunteer</td>"
            + "<td class='Prompt1' nowrap>Participate</td>"
       + "</tr>"
       + "<tr class='DataTable2'>"
            + "<td class='Prompt1' nowrap>Score Date</td>"
            + "<td class='Prompt1' id='tdScrLvl' nowrap>"
            + "<td class='Prompt1' id='tdScrLvl' nowrap>"
            + "</td>"
       + "</tr>"
       + "<tr class='DataTable2'>"
         + "<td class='Prompt1' nowrap>Score Level</td>"
            + "<td class='Prompt1' id='tdScrDate' colspan=2 nowrap>"
              + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, document.all.ScrDt)'>&#60;</button>"
              + "<input class='Small' type='text' name='ScrDt' readonly size=10 maxlength=10>"
              + "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, document.all.ScrDt)'>&#62;</button> &nbsp;&nbsp;"
              + "<a class='Small' id='shwCal' href='javascript:showCalendar(1, null, null, 680, 100, document.all.ScrDt, null, null)' >"
              + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>"
            + "</td>"
       + "</tr>"
       + "<tr><td style='color:red;font-size:12px' colspan=3 id='tdError' nowrap></td>"
       + "</tr>"

  panel += "<tr><td class='Prompt1' colspan=3>"
        + "<button onClick='vldAddEmpScr(&#34;" + emp + "&#34;)' class='Small'>Add Single Score</button>"
        + "<button onClick='hidePanel();' class='Small'>Close</button>"
        + "</td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function setDate(direction, obj)
{
  var date = new Date();
  if(obj.value.trim() != "") { date = new Date(obj.value); }

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  obj.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

//==============================================================================
// get event score list
//==============================================================================
function getEvtScr()
{
   var url = "AimEvtScrLst.jsp?id=" + EvtId;
   window.frame1.location.href=url;
}
//==============================================================================
// get event score list
//==============================================================================
function setEvtScr(lvl, scr)
{
   var cell = document.all.tdScrLvl;
   cell[0].innerHTML += "<input name='Lvl' type='radio' value='" + lvl[0] + "'>" + scr[0] + " &nbsp; ";
   cell[1].innerHTML += "<input name='Lvl' type='radio' value='" + lvl[1] + "'>" + scr[1] + " &nbsp; ";
}
//==============================================================================
// submit employee score for participating in event
//==============================================================================
function vldAddEmpScr(emp)
{
   var error=false;
   var msg="";
   document.all.tdError.innerHTML=msg;

   var lvl = null;
   for(var i=0; i < document.all.Lvl.length; i++)
   {
      if(document.all.Lvl[i].checked){ lvl=document.all.Lvl[i].value; break; }
   }
   if(lvl==null){ error=true; msg="Select Score Level";}

   var scrdt = document.all.ScrDt.value.trim();

   if(error){ document.all.tdError.innerHTML=msg; }
   else{ sbmAddEmpScr(emp, lvl, scrdt) }
}
//==============================================================================
// submit employee score for participating in event
//==============================================================================
function sbmAddEmpScr(emp, lvl, scrdt)
{
   var url = "AimEvtSv.jsp?id=" + EvtId
      + "&emp=" + emp
      + "&lvl=" + lvl
      + "&scrdt=" + scrdt
      + "&action=ADDEMPSCR";
   //alert(url)
   window.frame1.location.href=url;
}
//==============================================================================
// restart
//==============================================================================
function restart()
{
   window.location.reload();
}
//==============================================================================
// add employee on event
//==============================================================================
function addEmp()
{
   var url = "AimEmpOnPgmLst.jsp?id=" + EvtId
   window.frame1.location.href=url;
}
//==============================================================================
// add employee on event
//==============================================================================
function showEmpLst(emp, name, str, email)
{
   var hdr = "Add New Employee";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popAddEmp(emp, name, str, email)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 400;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 80;
   document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate delete employee panel
//==============================================================================
function popAddEmp(emp, name, str, email)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable3'>"
           + "<th class='DataTable' style='vertical-align:middle;' nowrap>Emp<br>Num</th>"
           + "<th class='DataTable' style='vertical-align:middle;' nowrap>Name</th>"
           + "<th class='DataTable' style='vertical-align:middle;' nowrap>Str</th>"
           + "<th class='DataTable' style='vertical-align:middle;' nowrap>EMail</th>"
         + "</tr>"
  for(var i=0; i < emp.length; i++)
  {
     panel += "<tr class='DataTable2'>"
         + "<td class='Prompt1' style='vertical-align:middle;' nowrap>"
            + "<a href='javascript: sbmAddEmp(&#34;" + emp[i] + "&#34;)'>" + emp[i] + "</a>"
         + "</td>"
         + "<td class='Prompt' style='vertical-align:middle;' nowrap>" + name[i] + "</td>"
         + "<td class='Prompt' style='vertical-align:middle;' nowrap>" + str[i] + "</td>"
         + "<td class='Prompt' style='vertical-align:middle;' nowrap>" + email[i] + "</td>"
       + "</tr>"
  }

  panel += "<tr><td style='color:red;font-size:12px' colspan4 id='tdError' nowrap></td>"
       + "</tr>"

  panel += "<tr><td class='Prompt1' colspan=4><br><br>"
        + "<button onClick='hidePanel();' class='Small'>Close</button>"
        + "</td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// submit new employee entry
//==============================================================================
function sbmAddEmp(emp)
{
   var url = "AimEvtSv.jsp?id=" + EvtId + "&emp=" + emp + "&action=ADDEMP";
   window.frame1.location.href=url;
}
//==============================================================================
// show errors
//==============================================================================
function showError(err)
{
   var br = "";
   for(var i=0; i < err.length; i++)
   {
     document.all.tdError.innerHTML= br + err[i];
     br = "<br>"
   }
}

//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.style.visibility = "hidden";
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>AIM Event Employee List
        <br><%=sEvtName%>
        <br>Beginning Date: <%=sBegDt%> &nbsp; Expiration date: <%=sExpDt%>
        <br>Frequency: <%=sFreq%>
        <%if(sFreq.equals("Weekly")){%> - <%=sWkDayNm[iWeekday]%><%}%>
        </b>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="AimEvtLstSel.jsp"><font color="red" size="-1">Select Orders</font></a>&#62;
      <font size="-1">This Page</font> &nbsp; &nbsp; &nbsp; &nbsp;

      <a href="javascript:addEmp()">Add Employee</a>

  <!----------------------- Order List ------------------------------>
     <table border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable">
         <th class="DataTable">Emp<br>Number</th>
         <th class="DataTable">Employee Name</th>
         <th class="DataTable">Add<br>Scores</th>
         <th class="DataTable">Earned<br>Scores</th>
         <th class="DataTable">Level 1<br>Scores</th>
         <th class="DataTable">Level 2<br>Scores</th>
         <th class="DataTable">Number<br>of Scores<br>Entries</th>
         <th class="DataTable">Hourly/<br>Salary</th>
         <th class="DataTable">Dept</th>
         <th class="DataTable">Title</th>
         <th class="DataTable">Separated?</th>
         <th class="DataTable">Participated<br>Date/Time</th>
         <th class="DataTable">Delete</th>
      <TBODY>

      <!----------------------- Order List ------------------------>
 <%
    while( emplst.getNext() )
    {
      emplst.setAmEvtEmpLst();
      String sEmp = emplst.getEmp();
      String sRecUs = emplst.getRecUs();
      String sRecDt = emplst.getRecDt();
      String sRecTm = emplst.getRecTm();
      String sName = emplst.getName();
      String sHorS = emplst.getHorS();
      String sDept = emplst.getDept();
      String sTitle = emplst.getTitle();
      String sSepr = emplst.getSepr();
      String sScore = emplst.getScore();
      String sNumScr = emplst.getNumScr();
      String sL1Scr = emplst.getL1Scr();
      String sL2Scr = emplst.getL2Scr();
  %>
     <tr class="DataTable1">
       <td class="DataTable2"><a href="AimEmpScrLst.jsp?emp=<%=sEmp%>&empnm=<%=sName%>"><%=sEmp%></a></td>
       <td class="DataTable"><%=sName%></td>
       <td class="DataTable1">&nbsp;
          <%if(bAllowAddScr) {%><a href="javascript:addEmpScr('<%=sEmp%>', '<%=sName%>')">Add</a><%}%>
       </td>
       <td class="DataTable2"><%=sScore%></td>
       <td class="DataTable2"><%=sL1Scr%></td>
       <td class="DataTable2"><%=sL2Scr%></td>
       <td class="DataTable2"><%=sNumScr%></td>
       <td class="DataTable1"><%=sHorS%></td>
       <td class="DataTable1"><%=sDept%></td>
       <td class="DataTable"><%=sTitle%></td>
       <td class="DataTable1">&nbsp;<%=sSepr%>&nbsp;</td>
       <td class="DataTable"><%=sRecDt%> <%=sRecTm%></td>
       <td class="DataTable1">
         <%if(sNumScr.equals("0")) {%>
            <a href="javascript:dltEmp('<%=sEmp%>', '<%=sName%>')">D</a>
         <%} else {%>&nbsp;<%}%>
       </td>
       </tr>
  <%}%>

      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>
  <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%
    emplst.disconnect();
    emplst = null;
%>
<%}%>