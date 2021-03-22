<%@ page import="payrollreports.SetDaySched"%>
<% String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sWeekDay = request.getParameter("WKDATE");
   String sMonth = request.getParameter("MONBEG");
   String sWeekEnd = request.getParameter("WEEKEND");
   String sFrom = request.getParameter("FROM");
   String sDayOfWeek = request.getParameter("WKDAY");

    //-------------- Security ---------------------
   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     response.sendRedirect("SignOn1.jsp?TARGET=SchedbyDay.jsp&APPL=" + sAppl + "&" + request.getQueryString());
   }
  //-------------- End Security -----------------


   SetDaySched DaySch = new SetDaySched(sStore, sWeekDay);
   int iMgr = DaySch.getNumOfMgr();
   String [] sMgr = DaySch.getMgr();
   String [] sMgrDpt = DaySch.getMgrDpt();
   String [] sMgrTtl = DaySch.getMgrTtl();
   String [] sMgrTime = DaySch.getMgrTime();
   String [] sMgrTot = DaySch.getMgrTot();
   String [] sMgrHTyp = DaySch.getMgrHrsTyp();

   int iSls = DaySch.getNumOfSls();
   String [] sSls = DaySch.getSls();
   String [] sSlsDpt = DaySch.getSlsDpt();
   String [] sSlsTtl = DaySch.getSlsTtl();
   String [] sSlsTime = DaySch.getSlsTime();
   String [] sSlsTot = DaySch.getSlsTot();
   String [] sSlsGoal = DaySch.getSlsGoal();
   String [] sSlsHTyp = DaySch.getSlsHrsTyp();

   int iSBk = DaySch.getNumOfSBk();
   String [] sSBk = DaySch.getSBk();
   String [] sSBkDpt = DaySch.getSBkDpt();
   String [] sSBkTtl = DaySch.getSBkTtl();
   String [] sSBkTime = DaySch.getSBkTime();
   String [] sSBkTot = DaySch.getSBkTot();
   String [] sSBkGoal = DaySch.getSBkGoal();
   String [] sSBkHTyp = DaySch.getSBkHrsTyp();

   String [] sTotSales = DaySch.getTotSales();
   String [] sTotHours = DaySch.getTotHours();
   String [] sMgrNumHr = DaySch.getMgrNumHr();
   String [] sSlsNumHr = DaySch.getSlsNumHr();
   String [] sNSlNumHr = DaySch.getNSlNumHr();
   String [] sTotNumHr = DaySch.getTotNumHr();

   int iNSl = DaySch.getNumOfNSls();
   String [] sNSl = DaySch.getNSls();
   String [] sNSlDpt = DaySch.getNSlsDpt();
   String [] sNSlTtl = DaySch.getNSlsTtl();
   String [] sNSlTime = DaySch.getNSlsTime();
   String [] sNSlTot = DaySch.getNSlsTot();
   String [] sNSlHTyp = DaySch.getNSlHrsTyp();

   int iNRc = DaySch.getNumOfNRcv();
   String [] sNRc = DaySch.getNRcv();
   String [] sNRcDpt = DaySch.getNRcvDpt();
   String [] sNRcTtl = DaySch.getNRcvTtl();
   String [] sNRcTime = DaySch.getNRcvTime();
   String [] sNRcTot = DaySch.getNRcvTot();
   String [] sNRcHTyp = DaySch.getNRcHrsTyp();

   int iNBk = DaySch.getNumOfNBik();
   String [] sNBk = DaySch.getNBik();
   String [] sNBkDpt = DaySch.getNBikDpt();
   String [] sNBkTtl = DaySch.getNBikTtl();
   String [] sNBkTime = DaySch.getNBikTime();
   String [] sNBkTot = DaySch.getNBikTot();
   String [] sNBkHTyp = DaySch.getNBkHrsTyp();

   int iNOt = DaySch.getNumOfNOth();
   String [] sNOt = DaySch.getNOth();
   String [] sNOtDpt = DaySch.getNOthDpt();
   String [] sNOtTtl = DaySch.getNOthTtl();
   String [] sNOtTime = DaySch.getNOthTime();
   String [] sNOtTot = DaySch.getNOthTot();
   String [] sNOtHTyp = DaySch.getNOtHrsTyp();

   int iNTr = DaySch.getNumOfNTrn();
   String [] sNTr = DaySch.getNTrn();
   String [] sNTrDpt = DaySch.getNTrnDpt();
   String [] sNTrTtl = DaySch.getNTrnTtl();
   String [] sNTrTime = DaySch.getNTrnTime();
   String [] sNTrTot = DaySch.getNTrnTot();
   String [] sNTrHTyp = DaySch.getNTrHrsTyp();

   int iNumOfEvt = DaySch.getNumOfEvt();
   String [] sEvent = DaySch.getEvent();
   String [] sEvtTime = DaySch.getEvtTime();
   String [] sEvtComt = DaySch.getEvtComt();

   // Get employy list that already scheduled for this day and store
   String sAll = DaySch.getAllEmp();

   DaySch.disconnect();

   // Hours/Minutes array
   String [] sHrsTxt = new String[]{"07","08","09","10","11","12",
                                 "01","02","03","04","05","06",
                                 "07","08","09","10","11","12"};
   String [] sHrs = new String[18];
   String [] sMin = new String[]{"00", "30"};
   for(int i=7; i<25;i++){
     sHrs[i-7] = Integer.toString(i);
     if (sHrs[i-7].length()== 1) {
        sHrs[i-7] = "0" + sHrs[i-7];
     }
   }

   // Hours/Minutes array
   String [] sHrsDsp = new String[]{"07<br>am","08<br>am","09<br>am","10<br>am",
                                 "11<br>am","12<br>pm", "01<br>pm","02<br>pm",
                                 "03<br>pm","04<br>pm","05<br>pm","06<br>pm",
                                 "07<br>pm","08<br>pm","09<br>pm","10<br>pm",
                                 "11<br>pm", "12<br>am"};
   String sClrBox = null;
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:lightgrey; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
        td.DataTable2 { color:red; background:cornsilk; cursor: hand; border-top: double darkred; border-bottom: darkred solid 1px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px ;}
        td.DataTable3 { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:8px; }
        td.DataTable4 { background:#FFCC99; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable5 { background:white;border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:8px; }
        td.DataTable6 { background:gold;border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }
        td.DataTable7 { color:red; background:cornsilk; border-top: double darkred; border-bottom: darkred solid 1px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px;}
        td.DataTable8 { color:brown; background: Linen; border-top: darkred solid 1px; border-bottom: darkred solid 1px; padding-top:0px; padding-bottom:0px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable9 { color:red; background:cornsilk; border-top: double darkred; border-bottom: darkred solid 1px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:11px; font-weight:bold}
        td.DataTable10 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
        td.DataTable11 { background:lightgrey; cursor: hand; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }

        td.EntTbl  { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }
        td.EntTbl1  { background:white; border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }
        td.EntTbl2  { background:red; border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }
        td.EntTbl3 { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:8px; }

        td.Menu   {border-bottom: black solid 1px; cursor: hand; text-align:left; font-family:Arial; font-size:10px; }
        td.Menu1  {border-bottom: black solid 1px; text-align:left; font-family:Arial; font-size:12px; }
        td.Menu2  {text-align:right; font-family:Arial; font-size:12px; }
        td.Menu3  {border-bottom: black solid 1px; text-align:left; font-family:Arial; font-size:10px; }

        td.Grid  { background:darkblue; color:white; text-align:center; font-family:Arial; font-size:11px; font-weight:bolder}
        tr.Grid1 { text-align:center; font-family:Arial; font-size:10px;}
        button.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:center; font-family:Arial; font-size:10px;}
</style>
<SCRIPT language="JavaScript">
//--------------- Global variables -----------------------
var CurStore = <%=sStore%>;
var CurStrName = "<%=sThisStrName%>";
var Month = "<%=sMonth%>"
var WeekEnd = "<%=sWeekEnd%>"
var CurDate = "<%=sWeekDay%>";
var From = "<%=sFrom%>";
var DayOfWeek = "<%=sDayOfWeek%>"

var AllEmp = null;
<%if(sAll != null && sAll.length() != 0){%>
     AllEmp = [<%=sAll%>];
<%}%>

var Events = new Array(<%=iNumOfEvt%>);
var EvtComts = new Array(<%=iNumOfEvt%>);
var EvtTimes = new Array(<%=iNumOfEvt%>);
<%for(int i=0; i < iNumOfEvt; i++){%>
  Events[<%=i%>] = "<%=sEvent[i]%>";
  EvtTimes[<%=i%>] = "<%=sEvtTime[i]%>";
  EvtComts[<%=i%>] = "<%=sEvtComt[i]%>";
<%}%>

var BegTime = null;
var EndTime = null;
var table = null;
var cells = null;


//--------------- End of Global variables -----------------------


function ShowMenu(obj, goal){
 var prefx = obj.id.substring(0,4);
 var emp = obj.id.substring(4,43);
 var day;
 var grp;
 var grpname;
 var subgrp=null;
 var curLeft = 0;
 var curTop = 0;
 var MenuHtml;

 var MenuEmp = "<td class='Menu1' nowrap><b>" + emp.substring(5) + "</b>" + "</td>";
 var MenuGrp = " ";
 var MenuGoal= " ";
 var MenuSub = " ";
 var MenuAdd = " ";
 var MenuVac = " ";
 var MenuHol = " ";

 var MenuDel = " ";
 var MenuMov = " ";

  // customize menu options depend on selected employee group
 if(prefx.substring(0,1) == "M")
 {
     grp = 'MNGR';
     MenuGrp = "<tr><td class='Menu3' colspan='2' align='center'>Group: Manager</td></tr>";
     grpname='Managers';
 }
 else if(prefx.substring(0,2) == "SL")
 {
     grp = 'SLSP'
     MenuGrp="<tr><td class='Menu3' colspan='2' align='center'>Group: Sales personnel</td></tr>";
     grpname='Sales personnel';
     subgrp='Regular Sales';
     MenuSub = "<tr><td class='Menu3' colspan='2' align='center'>Sub-Group: Salesman</td></tr>";
 }
 else if(prefx.substring(0,2) == "SB")
 {
     grp = 'SLBK'
     MenuGrp="<tr><td class='Menu3' colspan='2' align='center'>Group: Sales personnel</td></tr>";
     grpname='Sales personnel';
     subgrp='Bike Sales';
     MenuSub = "<tr><td class='Menu3' colspan='2' align='center'>Sub-Group: Bike Department</td></tr>";
 }
 else if(prefx.substring(0,2) == "NC")
  {
     grp = 'NSLSP';
     MenuGrp="<tr><td class='Menu3' colspan='2' align='center'>Group: Non-sales personnel</td></tr>";
     grpname='Non-sales personnel';
     subgrp='Cashiers';
     MenuSub = "<tr><td class='Menu3' colspan='2' align='center'>Sub-Group: Cashiers</td></tr>";
  }
  else if(prefx.substring(0,2) == "NR")
  {
     grp = 'NSLRC';
     MenuGrp="<tr><td class='Menu3' colspan='2' align='center'>Group: Non-sales personnel</td></tr>";
     grpname='Non-sales personnel';
     subgrp='Receiving';
     MenuSub = "<tr><td class='Menu3' colspan='2' align='center'>Sub-Group: Receiving</td></tr>";
  }
  else if(prefx.substring(0,2) == "NB")
  {
     grp = 'NSLBK';
     MenuGrp="<tr><td class='Menu3' colspan='2' align='center'>Group: Non-sales personnel</td></tr>";
     grpname='Non-sales personnel';
     subgrp='Bike Sales';
     MenuSub = "<tr><td class='Menu3' colspan='2' align='center'>Sub-Group: Bike Shop</td></tr>";
  }
  else if(prefx.substring(0,2) == "NO")
  {
     grp = 'NSLOT';
     MenuGrp="<tr><td class='Menu3' colspan='2' align='center'>Group: Non-sales personnel</td></tr>";
     grpname='Non-sales personnel';
     subgrp='Other';
     MenuSub = "<tr><td class='Menu3' colspan='2' align='center'>Sub-Group: Other</td></tr>";
  }
  else if(prefx.substring(0,2) == "NT")
  {
     grp = 'NSLTR';
     MenuGrp="<tr><td class='Menu3' colspan='2' align='center'>Group: Non-sales personnel</td></tr>";
     grpname='Non-sales personnel';
     subgrp='Training';
     MenuSub = "<tr><td class='Menu3' colspan='2' align='center'>Sub-Group: Training</td></tr>";
  }

 // customize menu options for selected employee day
 if(prefx.substring(2,4) == "DS"){
   day = obj.id.substring(44);
   MenuAdd = "<tr><td class='Menu' colspan='2' align='center' "
           + "onclick='showTimeEntry(&#34;" + emp + "&#34;,&#34;" + grp + "&#34;, &#34;"
           + grpname + "&#34;, &#34;" + day + "&#34;, &#34;" + DayOfWeek
           + "&#34;);hideMenu();'>Override"
           + "</td></tr>";

   MenuDel = "<tr><td colspan='2' class='Menu' align='center' "
           + "onclick='dltEntry(&#34;"
           + emp + "&#34;, &#34;" + grp + "&#34;, &#34;" + day + "&#34;,null); hideMenu();'>Delete"
           + "</td></tr>"
 }
 // customize menu options for selected group
 else if(prefx.substring(2,4) == "GP"){
   MenuAdd = "<tr><td class='Menu' colspan='2' align='center' "
           + "onclick='addHrs(&#34;" + grp + "&#34;,null);hideMenu();'>Add/Override"
           + "</td></tr>";
   MenuEmp = "<td class='Menu1' nowrap><b>" + grpname + "</b></td>";
   MenuGrp = " " ;
   MenuDel = "<tr><td colspan='2' class='Menu' align='center' "
           + "onclick='dltEntry(&#34;"
           + "GRP&#34;, &#34;" + grp + "&#34;, null, &#34;GRPDAY&#34;);hideMenu();'>Delete whole group"
           + "</td></tr>"
 }

 if (obj.offsetParent) {
   while (obj.offsetParent){
     curLeft += obj.offsetLeft
     curTop += obj.offsetTop
     obj = obj.offsetParent;
   }
 }
 else if (obj.x) {
    curLeft += obj.x;
    curTop += obj.y;
 }

 if(grp == 'SLSP')
 {
   //MenuGoal= "<tr><td class='Menu' colspan='2' align='center'>" + "Sales Goal: $" + goal + "</td></tr>";
 }

 MenuHtml = "<table width='100%' cellPadding='0' cellSpacing='0'>"
   + "<tr>"
   + MenuEmp
   + "<td class='Menu2' valign=top>"
   +  "<img src='CloseButton.bmp' onclick='javascript:hideMenu();' alt='Close'>"
   + "</td></tr>"
   + MenuGrp + MenuSub + MenuGoal + MenuAdd + MenuVac + MenuHol
   + MenuMov + MenuDel
   + "<tr><td colspan='2' class='Menu' align='center' "
   + "onclick='hideMenu();'>Close"
   + "</td></tr>"
   + "</table>"

    if (curLeft > (screen.width - 250)) curLeft = screen.width - 250;
    //if (curTop > (screen.height - 250)) curTop = screen.height - 250;


    document.all.menu.innerHTML=MenuHtml
    document.all.menu.style.pixelLeft=curLeft
    document.all.menu.style.pixelTop=curTop
    document.all.menu.style.visibility="visible"
}

// add time for selected employee and date
function showTimeEntry(emp, grp, grpname, day, dayofWeek){

 var entryTimeHtml = "<form name='HRSENTRY' method='GET' >"
    + "<table width='100%' cellPadding='0' cellSpacing='0'>"
    + "<tr><td class='Grid'>&nbsp;&nbsp;&nbsp;</td>"
    + "<td class='Grid' colspan='4'>" + emp
    + " - " + grpname
    + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + dayofWeek + ", " + day
    + "</td>"
    +  "<td class='Grid' align=right valign=top>"
    +  "<img src='CloseButton.bmp' onclick='javascript:hidetip2();' alt='Close'>"
    + "</td></tr>"
    + "<tr class='Grid1'></tr>"
    + "<tr class='Grid1'><td>&nbsp;</td>"
    + "<td colspan='4'>"
    + "<table class='DataTable' cellPadding='0' cellSpacing='0' id='TbHrsEnt'>"
    + "<tr><td class='EntTbl' colspan='50' nowrap>"
    + "Hours Entry - click on white cells to select a time, to change - click on reset button"
    + "</td></tr>"
    + "<tr>"
    + "<td class='EntTbl' rowspan='2'><button class='small' name='ResetEntry' type='button' DISABLED onclick='resetHrs();'>Reset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button></td>"
      <%for(int i=0; i < sHrs.length;i++){
             if(i == sHrs.length-1) {%>
              + "<td class='EntTbl'><%=sHrsTxt[i]%></td>"
      <%}
             else {%>
              + "<td class='EntTbl' colspan='<%=sMin.length%>'><%=sHrsTxt[i]%></td>"
           <%}%>
         <%}%>
     + "</tr>"
     + "<tr >"
         <%for(int i=0, k=0; i < (sHrs.length * sMin.length-1); i++, k++){
             if(k >= sMin.length) k=0; %>
           + "<td class='EntTbl3'><%=sMin[k]%></td>"
         <%}%>
      +  "</tr>"
      +  "<tr>"
      + "<td class='EntTbl'>"
      + "<button class='small' name='Regular'"
      + " onclick='if (Validate(&#34;"+ emp + "&#34;)){ submitEntry(&#34;"
      + emp + "&#34;, &#34;" + grp + "&#34;, &#34;REG&#34;);}'>Regular&nbsp;&nbsp;</button>"
      + "</td>"

       <% for(int i=0; i < sHrs.length; i++){ %>
         <% for(int k=0; k < sMin.length; k++){%>
      +  "<td class='EntTbl1' id='<%=sHrs[i]%><%=sMin[k]%>' onclick='enterTime(this);'>&nbsp;</td>"
             <%if(i == sHrs.length-1) break;
            }%>
        <%}%>
      + "</tr>"

      + "<tr><td class='EntTbl'>&nbsp;</td>"
      + "<td class='EntTbl' colspan='9'>Beginning at:&nbsp;&nbsp;</td> "
      + "<td class='EntTbl' colspan='8'><div class='shwTime' id='dvBegTime' >&nbsp;</div></td>"
      + "<td class='EntTbl' colspan='9'>Ending at:&nbsp;&nbsp;</td>"
      + "<td class='EntTbl' colspan='9'><div class='shwTime' id='dvEndTime'>&nbsp;</div></td>"
      + "</tr>"

      +  "<tr>"
      + "<td class='EntTbl'>"
      + "<button class='small' name='Vacation' "
      + "onclick='enterOutTime(&#34;VAC&#34;);"
      + "if (Validate(&#34;"+ emp + "&#34;)){"
      + "submitEntry(&#34;"+ emp + "&#34;, &#34;" + grp + "&#34;, &#34;VAC&#34;);}'>"
      + "Vacation</button>"
      + "</td>"
      + "<td class='EntTbl' id='VAC4HRS' colspan='17'>"
      + "<input name='VACHRS' type='radio' value='4H' onclick='chgBtnSts(&#34;VAC&#34;)'>1/2 of day"
      + "</td>"
      + "<td class='EntTbl' id='VAC8HRS' colspan='18'>"
      + "<input name='VACHRS' type='radio' value='8H' checked onclick='chgBtnSts(&#34;VAC&#34;)'>Whole day"
      + "</td>"
      + "</tr>"

      + "<tr><td class='EntTbl' colspan='50'>&nbsp;</td></td></tr>"

      +  "<tr>"
      + "<td class='EntTbl'>"
      + "<button class='small' name='Holiday' "
      + "onclick='enterOutTime(&#34;HOL&#34;);"
      + "if (Validate(&#34;"+ emp + "&#34;)){"
      + "submitEntry(&#34;"+ emp + "&#34;, &#34;" + grp + "&#34;, &#34;HOL&#34;);}'>"
      + "Holiday&nbsp;&nbsp;</button>"
      + "</td>"
      + "<td class='EntTbl' id='HOL4HRS' colspan='17'>"
      + "<input name='HOLHRS' type='radio' value='4H' onclick='chgBtnSts(&#34;HOL&#34;)'>1/2 of day"
      + "</td>"
      + "<td class='EntTbl' id='HOL8HRS' colspan='18'>"
      + "<input name='HOLHRS' type='radio' value='8H' checked onclick='chgBtnSts(&#34;HOL&#34;)'>Whole day"
      + "</td>"
      + "</tr>"

      +  "<tr>"
      + "<td class='EntTbl'>"
      + "<button class='small' name='ReqOff' "
      + "onclick='enterOutTime(&#34;VAC&#34;);"
      + "if (Validate(&#34;"+ emp + "&#34;)){"
      + "submitEntry(&#34;"+ emp + "&#34;, &#34;" + grp + "&#34;, &#34;OFF&#34;);}'>"
      + "Request Off</button>"
      + "</td>"
      + "<td class='EntTbl' colspan='35'>"
      + "</td>"
      + "</table>"

      + "</td></tr>"
      + "<tr  class='Grid1'>"
      + "<td>&nbsp;</td><td colspan='4'>"
      + "<button class='small' name='close' onclick='hidetip2()'>Close</button>"
      + "</td></tr>"
      + "</table>"
      + "</form>"

    document.all.tooltip2.innerHTML=entryTimeHtml
    document.all.tooltip2.style.pixelLeft=screen.width/2-200
    document.all.tooltip2.style.pixelTop=document.documentElement.scrollTop+10
    document.all.tooltip2.style.visibility="visible"
}

//--------------------------------------------------------------------------
//------------------------- Events -----------------------------------------
//--------------------------------------------------------------------------
function ShowEvtMenu(obj){
 var prefx = obj.id.substring(0,3);
 var num = obj.id.substring(3);
 var curLeft = 0;
 var curTop = 0;
 var MenuHtml;

 var MenuEmp = "<td class='Menu1' nowrap><b>" + Events[num] + "</b>" + "</td>";
 var MenuDel = " ";
 var MenuDsp = " ";

 MenuDel = "<tr><td colspan='2' class='Menu' align='center' "
           + "onclick='dltEvtEntry(&#34;"
           + num + "&#34;); hideMenu();'>Delete"
           + "</td></tr>"

 MenuHtml = "<table width='100%' cellPadding='0' cellSpacing='0'>"
   + "<tr>"
   + MenuEmp
   + "<td class='Menu2' valign=top>"
   +  "<img src='CloseButton.bmp' onclick='javascript:hideMenu();' alt='Close'>"
   + "</td></tr>"
   + MenuDel
   + "<tr><td colspan='2' class='Menu' align='center' "
   + "onclick='hideMenu();'>Close"
   + "</td></tr>"
   + "</table>"

// position menu on the screen
  if (obj.offsetParent) {
   while (obj.offsetParent){
     curLeft += obj.offsetLeft
     curTop += obj.offsetTop
     obj = obj.offsetParent;
   }
 }
 else if (obj.x) {
    curLeft += obj.x;
    curTop += obj.y;
 }

 if (curTop > (document.documentElement.scrollTop + screen.height - 250))
    {
      curTop = document.documentElement.scrollTop + screen.height - 300;
    }
    curLeft += 70;
    if (curLeft > (document.documentElement.scrollLeft + screen.width - 200))
    {
      curLeft = document.documentElement.scrollLeft + screen.width - 200;
 }



    document.all.menu.innerHTML=MenuHtml
    document.all.menu.style.pixelLeft=curLeft
    document.all.menu.style.pixelTop=curTop
    document.all.menu.style.visibility="visible"
}

function dltEvtEntry(num)
{
  SbmString = "SavEvtEnt.jsp?STORE=" + CurStore
                + "&STRNAME=" + CurStrName
                + "&MONBEG=" + Month
                + "&WEEKEND=" + WeekEnd
                + "&EVENT=" + Events[num]
                + "&ACTION=DLT"
                + "&FROM=" + From
                + "&POS=LIST"
                + "&DOC=DAY"
                + "&WKDATE=" + CurDate
                + "&DAYTIME=NONE"
                + "&EVTINF=NONE"

 //alert(SbmString);
 window.location.href=SbmString;

}
//--------------------------------------------------------------------------


// close employee selection window
function hidetip2(){
    document.all.tooltip2.style.visibility="hidden"
}

// close drop menu
function hideMenu(){
    document.all.menu.style.visibility="hidden"
}

// save entered vacation/holiday/request off time
function enterOutTime(TimeType){

  if(TimeType=="VAC" || TimeType=="HOL"){
    if(document.HRSENTRY.VACHRS[0].checked)
    {
      BegTime = "0800";
      EndTime = "1200";
    }
    else
    {
      BegTime = "0800";
      EndTime = "1600";
    }
  }
  else
  {
    BegTime = "0800";
    EndTime = "0900";
  }
}

//change vac, hol button status when radio button was clicked clicked
function chgBtnSts(TimeType)
{
  resetHrs();
  if (TimeType=="VAC")
  {
    document.forms[0].ResetEntry.disabled = false;
    document.forms[0].Vacation.disabled = false;
    document.forms[0].Holiday.disabled = true;
    document.forms[0].Regular.disabled = true;
    document.forms[0].ReqOff.disabled = true;

  }
  else if (TimeType=="HOL")
  {
    document.forms[0].ResetEntry.disabled = false;
    document.forms[0].Vacation.disabled = true;
    document.forms[0].Holiday.disabled = false;
    document.forms[0].Regular.disabled = true;
    document.forms[0].ReqOff.disabled = true;
  }
}


// delete employee schedule
function dltEntry(emp, grp, act){
  SbmString = "SavHrsEnt.jsp?STORE=" + CurStore
                + "&STRNAME=" + CurStrName
                + "&MONBEG=" + Month
                + "&WEEKEND=" + WeekEnd
                + "&WKDATE0=" + CurDate
                + "&GRP=" + grp
                + "&EMPNUM=" + emp.substring(0, 4)
                + "&EMPNAME=" + emp.substring(5)
                + "&BEGTIME0=00:00"
                + "&ENDTIME0=00:00"
                + "&HRSTYP0=ALL"
                + "&ACTION=DLT"
                + "&FROM=" + From
                + "&POS=LIST"
                + "&DOC=DAY";
  //alert(SbmString);
 window.location.href=SbmString;
}

// check entered time
function enterTime(cur){
 var id = cur.id;

 document.forms[0].ResetEntry.disabled = false;
 document.forms[0].Regular.disabled = false;
 document.forms[0].Vacation.disabled = true;
 document.forms[0].Holiday.disabled = true;
 document.forms[0].ReqOff.disabled = true;

 if (BegTime != null && EndTime != null){
  return; // do not allow to enter more then 2 cells
 }

 if(cur.className=="EntTbl1") {
    cur.className="EntTbl2"
    if (BegTime == null) {
        BegTime = cur.id;
    }
    else if(BegTime != cur.id ) {EndTime = cur.id; }
 }
 // initialized table and cells variables

 if(table == null){
    table = document.getElementById("TbHrsEnt");
    cells = table.getElementsByTagName("td");
  }

 // change color for all cells includeed in working time
 if (BegTime != null && EndTime != null){
  var found = false;
  // fix error when in time greater than hout time
  if (BegTime > EndTime){
      var saveTime = BegTime;
      BegTime = EndTime;
      EndTime = saveTime;
  }

  for(var i=0; i < cells.length; i++){
   if (cells.item(i).id == BegTime){  found = true; }
   if (found){ cells.item(i).className="EntTbl2"; }
   if (cells.item(i).id == EndTime){ found = false; }
  }
 }
 showTime(cur);
}

// Update readonly field that show selected times
function showTime(cur){
  if (BegTime != null){
    var hrs  = BegTime.substring(0,2)
    var type = " AM"
    if (hrs > "12") {
        hrs = hrs - 12;
        type = " PM"
    }
    var min = BegTime.substring(2,4);
    document.all.dvBegTime.innerHTML= hrs + ":" + min + type
    document.all.dvBegTime.style.visibility="visible"
  }
  if (EndTime != null){
    var hrs  = EndTime.substring(0,2)
    var type = " AM"
    if (hrs > "12") {
        hrs = hrs - 12;
        type = " PM"
    }
    var min = EndTime.substring(2,4);
    document.all.dvEndTime.innerHTML= hrs + ":" + min + type
    document.all.dvEndTime.style.visibility="visible"

  }
}

// reset hours by resetentry button
function resetHrs(){
 if(cells!=null){
   for(var i=0; i < cells.length; i++){
     if (cells.item(i).id >= "0700" && cells.item(i).id <= "2400")
     cells.item(i).className="EntTbl1";
   }
 }

 BegTime = null;
 EndTime = null;
 table = null;
 cells = null;

 document.forms[0].ResetEntry.disabled = true;
 document.forms[0].Regular.disabled = false;
 document.forms[0].Vacation.disabled = false;
 document.forms[0].Holiday.disabled = false;
 document.forms[0].ReqOff.disabled = false;

 document.all.dvBegTime.innerHTML= null;
 document.all.dvBegTime.style.visibility="hidden"
 document.all.dvEndTime.innerHTML= null;
 document.all.dvEndTime.style.visibility="hidden"
}
// Validate form entry values
function Validate(emp){
  var EmpNum = emp.substring(0,4);
  var EmpName = emp.substring(5);
  var msg = '';
  var error = false;

  if (BegTime <= " ") { msg += "Please enter beginning time. \n"; }
  // check Employee Ending Time
  if (EndTime <= " ") { msg += "Please enter ending time. \n";  }

  // show error messages
  if (msg != ''){
      error = true;
      alert(msg);
  }

  return error == false;
}

function submitEntry(emp, grp, HrsTyp){
  // change action string
  SbmString = "SavHrsEnt.jsp?STORE=" + CurStore
                + "&STRNAME=" + CurStrName
                + "&MONBEG=" + Month
                + "&WEEKEND=" + WeekEnd
                + "&GRP=" + grp
                + "&EMPNUM=" + emp.substring(0,4)
                + "&EMPNAME=" + emp.substring(5)
                + "&ACTION=ADD"
                + "&HRSTYP0=" + HrsTyp
                + "&FROM=" + From
                + "&POS=ENTRY"
                + "&DOC=DAY"
                + "&WKDATE0=" + CurDate
                + "&BEGTIME0=" + BegTime.substring(0,2) + ":" + BegTime.substring(2,4)
                + "&ENDTIME0=" + EndTime.substring(0,2) + ":" + EndTime.substring(2,4);;
  //alert(SbmString)
  window.location.href = SbmString;
}

// Open prompt window
function openPromptWdw() {
  var MyURL = 'SelectEmployee.jsp';
  var MyWindowName = 'Test01';
  var MyWindowOptions =
   'width=600,height=400, toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,resize=no,menubar=no';
  window.open(MyURL, MyWindowName, MyWindowOptions);
}
</SCRIPT>
</head>
<!-------------------------------------------------------------------->
<body>
<!-------------------------------------------------------------------->
<div id="tooltip2" style="position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px;background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px"></div>


<div id="menu" style="position:absolute;visibility:hidden; background-attachment: scroll;
              border: black solid 3px; width:150px;background-color:Azure; z-index:10;
              text-align:center"></div>


    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP" colspan="3"><b>Daily Store Schedule</b></td>
     </tr>
     <tr bgColor="moccasin">
       <td ALIGN="left" VALIGN="TOP"><b>&nbsp;Store:&nbsp;<%=sThisStrName%></b></td>
       <td ALIGN="center" VALIGN="TOP">&nbsp;</td>
       <td ALIGN="right" VALIGN="TOP"><b>Date: <%=sDayOfWeek%>, <%=sWeekDay%>&nbsp;</b></td>
     </tr>
     <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP" colspan="3"><b>Daily Sales Goal:&nbsp;$<%=sTotSales[0]%></b></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" colspan="3">
        <a href="../"><font color="red" size="-1">Home</font></a>&#62;
        <a href="StrScheduling.html"><font color="red" size="-1">Payroll</font></a>&#62;
        <%if(sFrom.equals("AVGPAYREP")){%>
          <a href="APRSelector.jsp"><font color="red"  size="-1">Store Selector</font></a>&#62;
          <a href="AvgPayRep.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>">
            <font color="red" size="-1">Average Pay Report</font></a>&#62;
        <%}
        else {%>
          <a href="SchedbyWkSel.jsp"><font color="red" size="-1">Store/Week Selector</font></a>&#62;
        <%}%>
        <a href="SchedbyWeek.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekEnd%>&FROM=<%=sFrom%>">
          <font color="red"  size="-1">Weekly Schedule</font></a>&#62;
         <font size="-1">This page</font>
      <!------------- start of dollars table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable" colspan="3">Employee</th>
           <th class="DataTable" colspan="36">In/Out Time</th>
           <th class="DataTable" rowspan="3">Hours</th>
           <th class="DataTable" rowspan="3">Sales<br>Goals</th>
         </tr>
         <tr>
           <th class="DataTable" rowspan="2">Name</th>
           <th class="DataTable" rowspan="2">Dpt</th>
           <th class="DataTable" rowspan="2"> Title </th>

           <%for(int i=0; i < sHrsDsp.length; i++) {%>
             <td class="DataTable4" colspan="<%=sMin.length%>"><%=sHrsDsp[i]%></td>
           <%}%>
         </tr>
         <tr >
         <%for(int i=0, k=0; i < (sHrsDsp.length * sMin.length); i++, k++){
          if(k >= sMin.length) k=0; %>
          <td class="DataTable3"><%=sMin[k]%></td>
         <%}%>
         </tr>

   <!-- ----------------------  Managers ---------------------- -->
         <tr>
           <td class="DataTable9" colspan="3" id="MNGP" >Managers</td>
           <%for(int i=0; i < sHrsDsp.length; i++) {%>
             <td class="DataTable7" colspan="<%=sMin.length%>"><%=sMgrNumHr[i]%></td>
           <%}%>
           <td class="DataTable2"><%=sTotHours[0]%></td>
           <td class="DataTable2">&nbsp;</td>
         </tr>
     <%for(int i=0; i < iMgr; i++){%>
         <tr>
           <td class="DataTable11" id="MNDS<%=sMgr[i]+sWeekDay%>" onclick="ShowMenu(this, '0')" nowrap>&nbsp;&nbsp;&nbsp;
                <%=sMgr[i].substring(4)%></td>
           <td class="DataTable" >&nbsp;<%=sMgrDpt[i]%>&nbsp;</td>
           <td class="DataTable">&nbsp;<%=sMgrTtl[i]%>&nbsp;</td>

           <%if (sMgrHTyp[i].equals("VAC")) sClrBox = "blue_clr.bmp";
             else if (sMgrHTyp[i].equals("HOL")) sClrBox = "green_clr.bmp";
             else if (sMgrHTyp[i].equals("OFF")) sClrBox = "yellow_clr.bmp";
             else sClrBox = "red_clr.bmp";%>

           <%if (!sMgrHTyp[i].equals("OFF")) {%>
             <%for(int j=0; j<36; j++){
                 if(sMgrTime[i].substring(j,j+1).equals("1")) {%>
                   <td class="DataTable5"><img src="<%=sClrBox%>"></td>
               <%}
                 else {%>
                  <td class="DataTable5">&nbsp;</td>
               <%}
              }%>
                <td class="DataTable"><%=sMgrTot[i]%></td>
                <td class="DataTable">&nbsp;</td>
           <% }
            else {%>
              <td class="DataTable6" colspan="38">Request Off</td>
            <%}%>

         </tr>
     <%}%>
  <!-- ------------------    Selling personnel  ------------------- -->
         <tr>
           <td class="DataTable9" colspan="3">Selling</td>
           <%for(int i=0; i < sHrsDsp.length; i++) {%>
             <td class="DataTable7" colspan="<%=sMin.length%>"><%=sSlsNumHr[i]%></td>
           <%}%>
           <td class="DataTable2"><%=sTotHours[1]%></td>
           <td class="DataTable2">$<%=sTotSales[1]%>*</td>
         </tr>
     <!-- ------------------ Selling personnel - salesmen ------------------- -->
     <tr>
           <td class="DataTable8" colspan="3" id="SLGP" >Salesmen</td>
           <td class="DataTable8" colspan="38">&nbsp;</td>
     </tr>
     <%for(int i=0; i < iSls; i++){%>
         <tr>
           <td class="DataTable11" id="SLDS<%=sSls[i]+sWeekDay%>" onclick="ShowMenu(this, '0')">&nbsp;&nbsp;&nbsp;<%=sSls[i].substring(4)%></td>
           <td class="DataTable">&nbsp;<%=sSlsDpt[i]%>&nbsp;</td>
           <td class="DataTable">&nbsp;<%=sSlsTtl[i]%>&nbsp;</td>

           <%if (sSlsHTyp[i].equals("VAC")) sClrBox = "blue_clr.bmp";
             else if (sSlsHTyp[i].equals("HOL")) sClrBox = "green_clr.bmp";
             else if (sSlsHTyp[i].equals("OFF")) sClrBox = "yellow_clr.bmp";
             else sClrBox = "red_clr.bmp";%>

           <%if (!sSlsHTyp[i].equals("OFF")) {%>
             <%for(int j=0; j<36; j++){
                 if(sSlsTime[i].substring(j,j+1).equals("1")) {%>
                    <td class="DataTable5"><img src="<%=sClrBox%>" ></td>
                 <%}
                 else {%>
                    <td class="DataTable5">&nbsp;</td>
                 <%}
               }%>
               <td class="DataTable"><%=sSlsTot[i]%></td>
               <td class="DataTable"><%=sSlsGoal[i]%></td>
            <%}
            else {%>
              <td class="DataTable6" colspan="38">Request Off</td>
            <%}%>
         </tr>
     <%}%>
     <!-- --------------- Selling personnel - bike sales ----------------- -->
     <tr>
           <td class="DataTable8" colspan="3" id="SBGP" >Bike Sales</td>
           <td class="DataTable8" colspan="38">&nbsp;</td>
     </tr>
     <%for(int i=0; i < iSBk; i++){%>
         <tr>
           <td class="DataTable11" id="SBDS<%=sSBk[i]+sWeekDay%>" onclick="ShowMenu(this, '0')">&nbsp;&nbsp;&nbsp;<%=sSBk[i].substring(4)%></td>
           <td class="DataTable">&nbsp;<%=sSBkDpt[i]%>&nbsp;</td>
           <td class="DataTable">&nbsp;<%=sSBkTtl[i]%>&nbsp;</td>

           <%if (sSBkHTyp[i].equals("VAC")) sClrBox = "blue_clr.bmp";
             else if (sSBkHTyp[i].equals("HOL")) sClrBox = "green_clr.bmp";
             else if (sSBkHTyp[i].equals("OFF")) sClrBox = "yellow_clr.bmp";
             else sClrBox = "red_clr.bmp";%>

           <%if (!sSBkHTyp[i].equals("OFF")) {%>
             <%for(int j=0; j<36; j++){
                 if(sSBkTime[i].substring(j,j+1).equals("1")) {%>
                    <td class="DataTable5"><img src="<%=sClrBox%>" ></td>
                 <%}
                 else {%>
                    <td class="DataTable5">&nbsp;</td>
                 <%}
               }%>
               <td class="DataTable"><%=sSBkTot[i]%></td>
               <td class="DataTable"><%=sSBkGoal[i]%></td>
            <%}
            else {%>
              <td class="DataTable6" colspan="38">Request Off</td>
            <%}%>
         </tr>
     <%}%>
     <!-- ------------------  Non-Selling personnel -------------------- -->
         <tr>
           <td class="DataTable9" colspan="3">Non-Selling</td>
           <%for(int i=0; i < sHrsDsp.length; i++) {%>
             <td class="DataTable7" colspan="<%=sMin.length%>"><%=sNSlNumHr[i]%></td>
           <%}%>
           <td class="DataTable2"><%=sTotHours[2]%></td>
           <td class="DataTable2">&nbsp;</td>
         </tr>
    <!-- --------------- Non-Selling personnel - Cashiers ----------------- -->
         <tr>
           <td class="DataTable8" colspan="3" id="NCGP" >Cashiers</td>
           <td class="DataTable8" colspan="38">&nbsp;</td>
         </tr>


     <%for(int i=0; i < iNSl; i++){%>
         <tr>
           <td class="DataTable11" id="NCDS<%=sNSl[i]+sWeekDay%>" onclick="ShowMenu(this, '0')">&nbsp;&nbsp;&nbsp;<%=sNSl[i].substring(4)%></td>
           <td class="DataTable">&nbsp;<%=sNSlDpt[i]%>&nbsp;</td>
           <td class="DataTable">&nbsp;<%=sNSlTtl[i]%>&nbsp;</td>

           <%if (sNSlHTyp[i].equals("VAC")) sClrBox = "blue_clr.bmp";
             else if (sNSlHTyp[i].equals("HOL")) sClrBox = "green_clr.bmp";
             else if (sNSlHTyp[i].equals("OFF")) sClrBox = "yellow_clr.bmp";
             else sClrBox = "red_clr.bmp";%>

           <%if (!sNSlHTyp[i].equals("OFF")) {%>
             <%for(int j=0; j<36; j++){
                 if(sNSlTime[i].substring(j,j+1).equals("1")) {%>
                   <td class="DataTable5"><img src="<%=sClrBox%>" ></td>
                 <%}
                 else {%>
                   <td class="DataTable5">&nbsp;</td>
                 <%}
               }%>
               <td class="DataTable"><%=sNSlTot[i]%></td>
               <td class="DataTable">&nbsp;</td>
            <%}
            else {%>
              <td class="DataTable6" colspan="38">Request Off</td>
            <%}%>
         </tr>
     <%}%>
     <!-- --------------- Non-Selling personnel - Receiving ----------------- -->
         <tr>
           <td class="DataTable8" colspan="3" id="NRGP" >Receiving</td>
           <td class="DataTable8" colspan="38">&nbsp;</td>
         </tr>


     <%for(int i=0; i < iNRc; i++){%>
         <tr>
           <td class="DataTable11"  id="NRDS<%=sNRc[i]+sWeekDay%>" onclick="ShowMenu(this, '0')">&nbsp;&nbsp;&nbsp;<%=sNRc[i].substring(4)%></td>
           <td class="DataTable">&nbsp;<%=sNRcDpt[i]%>&nbsp;</td>
           <td class="DataTable">&nbsp;<%=sNRcTtl[i]%>&nbsp;</td>

           <%if (sNRcHTyp[i].equals("VAC")) sClrBox = "blue_clr.bmp";
             else if (sNRcHTyp[i].equals("HOL")) sClrBox = "green_clr.bmp";
             else if (sNRcHTyp[i].equals("OFF")) sClrBox = "yellow_clr.bmp";
             else sClrBox = "red_clr.bmp";%>

           <%if (!sNRcHTyp[i].equals("OFF")) {%>
             <%for(int j=0; j<36; j++){
                 if(sNRcTime[i].substring(j,j+1).equals("1")) {%>
                   <td class="DataTable5"><img src="<%=sClrBox%>" ></td>
                 <%}
                 else {%>
                   <td class="DataTable5">&nbsp;</td>
                 <%}
               }%>
               <td class="DataTable"><%=sNRcTot[i]%></td>
               <td class="DataTable">&nbsp;</td>
            <%}
            else {%>
              <td class="DataTable6" colspan="38">Request Off</td>
            <%}%>
         </tr>
     <%}%>
     <!-- --------------- Non-Selling personnel - Bikers ----------------- -->
         <tr>
           <td class="DataTable8" colspan="3" id="NBGP" >Bike Shop</td>
           <td class="DataTable8" colspan="38">&nbsp;</td>
         </tr>


     <%for(int i=0; i < iNBk; i++){%>
         <tr>
           <td class="DataTable11" id="NBDS<%=sNBk[i]+sWeekDay%>" onclick="ShowMenu(this, '0')">&nbsp;&nbsp;&nbsp;<%=sNBk[i].substring(4)%></td>
           <td class="DataTable">&nbsp;<%=sNBkDpt[i]%>&nbsp;</td>
           <td class="DataTable">&nbsp;<%=sNBkTtl[i]%>&nbsp;</td>

           <%if (sNBkHTyp[i].equals("VAC")) sClrBox = "blue_clr.bmp";
             else if (sNBkHTyp[i].equals("HOL")) sClrBox = "green_clr.bmp";
             else if (sNBkHTyp[i].equals("OFF")) sClrBox = "yellow_clr.bmp";
             else sClrBox = "red_clr.bmp";%>

           <%if (!sNBkHTyp[i].equals("OFF")) {%>
             <%for(int j=0; j<36; j++){
                 if(sNBkTime[i].substring(j,j+1).equals("1")) {%>
                   <td class="DataTable5"><img src="<%=sClrBox%>" ></td>
                 <%}
                 else {%>
                   <td class="DataTable5">&nbsp;</td>
                 <%}
               }%>
               <td class="DataTable"><%=sNBkTot[i]%></td>
               <td class="DataTable">&nbsp;</td>
            <%}
            else {%>
              <td class="DataTable6" colspan="38">Request Off</td>
            <%}%>
         </tr>
     <%}%>
     <!-- --------------- Non-Selling personnel - Other ----------------- -->
         <tr>
           <td class="DataTable8" colspan="3" id="NOGP" >Other</td>
           <td class="DataTable8" colspan="38">&nbsp;</td>
         </tr>


     <%for(int i=0; i < iNOt; i++){%>
         <tr>
           <td class="DataTable11" id="NODS<%=sNOt[i]+sWeekDay%>" onclick="ShowMenu(this, '0')">&nbsp;&nbsp;&nbsp;<%=sNOt[i].substring(4)%></td>
           <td class="DataTable">&nbsp;<%=sNOtDpt[i]%>&nbsp;</td>
           <td class="DataTable">&nbsp;<%=sNOtTtl[i]%>&nbsp;</td>

           <%if (sNOtHTyp[i].equals("VAC")) sClrBox = "blue_clr.bmp";
             else if (sNOtHTyp[i].equals("HOL")) sClrBox = "green_clr.bmp";
             else if (sNOtHTyp[i].equals("OFF")) sClrBox = "yellow_clr.bmp";
             else sClrBox = "red_clr.bmp";%>

           <%if (!sNOtHTyp[i].equals("OFF")) {%>
             <%for(int j=0; j<36; j++){
                 if(sNOtTime[i].substring(j,j+1).equals("1")) {%>
                   <td class="DataTable5"><img src="<%=sClrBox%>" ></td>
                 <%}
                 else {%>
                   <td class="DataTable5">&nbsp;</td>
                 <%}
               }%>
               <td class="DataTable"><%=sNOtTot[i]%></td>
               <td class="DataTable">&nbsp;</td>
            <%}
            else {%>
              <td class="DataTable6" colspan="38">Request Off</td>
            <%}%>
         </tr>
     <%}%>
     <!-- ------------------ Non-Selling personnel - Training--------------- -->
         <tr>
           <td class="DataTable8" colspan="3" id="NTGP" >Training</td>
           <td class="DataTable8" colspan="38">&nbsp;</td>
         </tr>


     <%for(int i=0; i < iNTr; i++){%>
         <tr>
           <td class="DataTable11" id="NTDS<%=sNTr[i]+sWeekDay%>" onclick="ShowMenu(this, '0')">&nbsp;&nbsp;&nbsp;<%=sNTr[i].substring(4)%></td>
           <td class="DataTable">&nbsp;<%=sNTrDpt[i]%>&nbsp;</td>
           <td class="DataTable">&nbsp;<%=sNTrTtl[i]%>&nbsp;</td>

           <%if (sNTrHTyp[i].equals("VAC")) sClrBox = "blue_clr.bmp";
             else if (sNTrHTyp[i].equals("HOL")) sClrBox = "green_clr.bmp";
             else if (sNTrHTyp[i].equals("OFF")) sClrBox = "yellow_clr.bmp";
             else sClrBox = "red_clr.bmp";%>

           <%if (!sNTrHTyp[i].equals("OFF")) {%>
             <%for(int j=0; j<36; j++){
                 if(sNTrTime[i].substring(j,j+1).equals("1")) {%>
                   <td class="DataTable5"><img src="<%=sClrBox%>" ></td>
                 <%}
                 else {%>
                   <td class="DataTable5">&nbsp;</td>
                 <%}
               }%>
               <td class="DataTable"><%=sNTrTot[i]%></td>
               <td class="DataTable">&nbsp;</td>
            <%}
            else {%>
              <td class="DataTable6" colspan="38">Request Off</td>
            <%}%>
         </tr>
     <%}%>

     <!-- ------------------------- Totals ------------------------- -->
         <tr>
           <td class="DataTable9" colspan="3">Totals</td>

           <%for(int i=0; i < sHrsDsp.length; i++) {%>
             <td class="DataTable7" colspan="<%=sMin.length%>"><%=sTotNumHr[i]%></td>
           <%}%>

           <td class="DataTable2"><%=sTotHours[3]%></td>
           <td class="DataTable2">&nbsp;</td>
         </tr>
          <tr>
            <td class="DataTable4" colspan="3">&nbsp;</td>
           <%for(int i=0; i < sHrsDsp.length; i++) {%>
             <td class="DataTable4" colspan="<%=sMin.length%>"><%=sHrsDsp[i]%></td>
        <%}%>
            <td class="DataTable4" colspan="2" rowspan="2">&nbsp;</td>
         </tr>
     <!-- ---------------------------------------------------------------- -->
     <!-- ---------------------------- Events ---------------------------- -->
     <!-- ---------------------------------------------------------------- -->
         <tr>
           <td class="DataTable9" colspan="41">Events</td>
         </tr>
         <%for(int i=0; i < iNumOfEvt; i++) {%>
           <tr>
            <td class="DataTable11" id="EVT<%=i%>" onclick="ShowEvtMenu(this)">
                 <%=sEvent[i]%></td>
            <td class="DataTable10" id="EVD<%=i%>" colspan='2'><%=sEvtTime[i]%></td>
            <td class="DataTable11" colspan='38'
               id="EVD<%=i%>" onclick="ShowEvtMenu(this)"><%=sEvtComt[i]%></td>
           <tr>
         <%}%>

       </table>

<!------------- end of data table ------------------------>
<tr bgColor="moccasin">
       <td ALIGN="right" VALIGN="TOP" colspan="3">
       <font size="-1">* - The amount of sales goal for selling personnel is 85% of store total sales goal.</font>
       </td>
</tr>
<tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP" colspan="3">
<a name="HoursEntry"></a>

    </td>
   </tr>
  </table>
 </body>
</html>
