<%@ page import="coordinators.CoorGoalComp, java.util.*"%>
<%
   String sCoordinator = request.getParameter("Coordinator");
   String sMonthYear = request.getParameter("MonthYear");
   String sMonthName = request.getParameter("MonthName");
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=CoorGoalComp.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      CoorGoalComp goal = new CoorGoalComp(sMonthYear, sCoordinator);

      int iNumOfWk = goal.getNumOfWk();
      String [] sWeek = goal.getWeek();
      int iNumOfStr = goal.getNumOfStr();
      String [] sStr = goal.getStr();

      String [][] sLYSls = goal.getLYSls();
      String [][] sTYSls = goal.getTYSls();
      String [][] sPrc = goal.getPrc();
      String [][] sGoal = goal.getGoal();
      String [][] sVar = goal.getVar();

      String [] sTotLYSls = goal.getTotLYSls();
      String [] sTotTYSls = goal.getTotTYSls();
      String [] sTotGoal = goal.getTotGoal();
      String [] sTotVar = goal.getTotVar();

      String [] sRepLYSls = goal.getRepLYSls();
      String [] sRepTYSls = goal.getRepTYSls();
      String [] sRepGoal = goal.getRepGoal();
      String [] sRepVar = goal.getRepVar();

      String sRepTotLYSls = goal.getRepTotLYSls();
      String sRepTotTYSls = goal.getRepTotTYSls();
      String sRepTotGoal = goal.getRepTotGoal();
      String sRepTotVar = goal.getRepTotVar();

      int iNumOfCls = goal.getNumOfCls();
      String [] sDiv = goal.getDiv();
      String [] sDpt = goal.getDpt();
      String [] sCls = goal.getCls();
      String [] sClsName = goal.getClsName();

      goal.disconnect();
%>
<html>
<head>
<style>
        body {background:lemonChiffon; text-align:center;}
        a { color:blue} a:visited { color:blue}  a:hover { color:blue}

        table.DataTable { border: darkred solid 1px; background: darkred; text-align:center;}

        tr.DataTable  { background: Gainsboro; text-align:right; font-family:Arial;font-size:10px }
        tr.DataTable1  { background: CornSilk; text-align:right; font-family:Arial;font-size:10px }
        tr.DataTable2  { background: seashell; text-align:right; font-family:Arial;font-size:10px }

        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center;
                       font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center;
                       font-family:Verdanda; font-size:12px }

        td.DataTable  { border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px; }

        td.DataTable1 { border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px;}

        .small{ text-align:left; font-family:Arial; font-size:10px;}

        div.CoorGoal { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:800; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }


</style>
<SCRIPT language="JavaScript1.2">
//------------------------------------------------------------------------------
// global variables
//------------------------------------------------------------------------------
var LySlsFld = true;

//---------------------------------------------------------
// work at loading time
//---------------------------------------------------------
function bodyLoad()
{
  setWeekSelection();
  setCoordinatorSelection();
  showLYSales()
}
//==============================================================================
// Fold / Unfold LY Sales columns
//==============================================================================
function showLYSales()
{
  var lywksls =  document.all.LYWKSLS;
  var nolywksls =  document.all.NOLYWKSLS;

  for(var i=0; i < lywksls.length; i++)
  {
     if(LySlsFld) lywksls[i].style.display="none";
     else lywksls[i].style.display="block";
  }
  for(var i=0; i < nolywksls.length; i++)
  {
     if(LySlsFld) nolywksls[i].style.display="block";
     else nolywksls[i].style.display="none";
  }

  LySlsFld = !LySlsFld;
}
//==============================================================================
// populate week selection field
//==============================================================================
function setWeekSelection()
{
   var curdate = new Date();
   curdate.setMonth(curdate.getMonth() + 3); // add 3 month to current one

   var mon = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October","November", "December"]
   for(var i=0; i < 12 ; i++)
   {
     document.all.MonthYear[i] = new Option(mon[curdate.getMonth()] + " " + curdate.getFullYear(),
                                              curdate.getFullYear() + "-" + (curdate.getMonth()+1) + "-1");
     curdate.setMonth(curdate.getMonth() - 1)
   }
}
//==============================================================================
// populate week selection field
//==============================================================================
function setCoordinatorSelection()
{
   var coor = ["Cycle","Water", "Snow", "Skate", "Outdoor", "Footwear"]
   for(var i=0; i < coor.length ; i++)
   {
     document.all.Coordinator[i] = new Option(coor[i], coor[i].toUpperCase());
   }
}

//==============================================================================
// change action on submit
//==============================================================================
function submitForm(){
   var SbmString;
   var selWeek = document.all.MonthYear.options[document.all.MonthYear.selectedIndex];
   var selCoor = document.all.Coordinator.options[document.all.Coordinator.selectedIndex].value;
   SbmString = "CoorGoalComp.jsp"
        + "?MonthYear=" + selWeek.value
        + "&MonthName=" + selWeek.text
        + "&Coordinator=" + selCoor

    //alert(SbmString);
    window.location.href=SbmString;
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
    while (s.match(obj)) { s = s.replace(obj, ""); }
    return s;
}
</SCRIPT>

</head>
<!-------------------------------------------------------------------->
<body onload="bodyLoad()" >
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvCoorGoal" class="CoorGoal"></div>
<!-------------------------------------------------------------------->
   <b><font size="+2">Coordinators Goals<br>
      Coordinator: <%=sCoordinator%>&nbsp; &nbsp; &nbsp;<%=sMonthName%></font></b><br>
      <SELECT name="MonthYear" class="small"></SELECT><br>
      <SELECT name="Coordinator" class="small"></SELECT>&nbsp;&nbsp;
      <button onclick="submitForm()">Go</button><br>


   <a href="../"><font color="red" size="-1">Home</font></a>&#62;
   <a href="StrScheduling.html"><font color="red" size="-1">Schedule Menu</font></a>&#62;
   <a href="CoorGoalCompSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
   <font size="-1">This page.</font>&nbsp;&nbsp;
   <%if(session.getAttribute("COORGOAL")!=null) {%>
      <a class="blue" href="CoorGoal.jsp?Coordinator=<%=sCoordinator%>&MonthYear=<%=sMonthYear%>&MonthName=<%=sMonthName%>"><font size="-1">Enter Coordinator Goals</font></a>&nbsp;&nbsp;
   <%}%>
   <font size="-1"><a href="javascript: showLYSales()">Fold/Unfold LY Sales</a></font>&nbsp;&nbsp;

   <table class='DataTable' cellPadding="0" cellSpacing="0">
      <tr>
        <th class='DataTable' rowspan="3">Store<br>#</th>
        <th class='DataTable' rowspan="3"></th>
        <%for(int j=0; j < iNumOfWk; j++) {%>
            <th class='DataTable' colspan=4  id="LYWKSLS">Week <%=j+1%></th>
            <th class='DataTable' colspan=3  id="NOLYWKSLS">Week <%=j+1%></th>
            <th class='DataTable' rowspan="3"></th>
        <%}%>
        <th class='DataTable' rowspan=2 colspan=4 id="LYWKSLS">Month Total</th>
        <th class='DataTable' rowspan=2 colspan=4 id="NOLYWKSLS">Month Total</th>
      </tr>

      <tr>
         <%for(int j=0; j < iNumOfWk; j++) {%>
            <th class='DataTable' colspan=4  id="LYWKSLS"><%=sWeek[j]%></th>
            <th class='DataTable' colspan=3  id="NOLYWKSLS"><%=sWeek[j]%></th>
         <%}%>
      </tr>

      <tr>
        <%for(int j=0; j < iNumOfWk; j++) {%>
           <th class='DataTable'>Goal</th>
           <th class='DataTable'>TY Sales</th>
           <th class='DataTable' id="LYWKSLS">LY Sales</th>
           <th class='DataTable'>Var</th>
        <%}%>
           <th class='DataTable'>Goal</th>
           <th class='DataTable'>TY Sales</th>
           <th class='DataTable' id="LYWKSLS">LY Sales</th>
           <th class='DataTable'>Var</th>
      </tr>

     <!---------------- Stores ---------------------------------------------------->
     <%boolean bClass=false;%>
     <%for(int i=0; i < iNumOfStr; i++) {%>
         <%if(bClass) {%><tr class="DataTable"><%}
         else {%><tr class="DataTable1"><%} bClass = !bClass;%>


            <td class="DataTable1"><%=sStr[i]%></td>
            <th class='DataTable'></th>
            <!--------------------- Store Goal details ----------------------------->
            <%for(int j=0; j < iNumOfWk; j++) {%>
                <td class="DataTable">$<%=sGoal[i][j]%></td>
                <td class="DataTable1">$<%=sTYSls[i][j]%></td>
                <td class="DataTable1" id="LYWKSLS">$<%=sLYSls[i][j]%></td>
                <td class="DataTable">
                    <font color="<%if(sVar[i][j].indexOf("-") > 0){%>red<%} else {%>black<%}%>">
                        $<%=sVar[i][j]%></font></td>
                <th class="DataTable"></th>
            <%}%>
            <td class="DataTable">$<%=sTotGoal[i]%></td>
            <td class="DataTable1">$<%=sTotTYSls[i]%></td>
            <td class="DataTable1" id="LYWKSLS">$<%=sTotLYSls[i]%></td>
            <td class="DataTable">
               <font color="<%if(sTotVar[i].indexOf("-") > 0){%>red<%} else {%>black<%}%>">$<%=sTotVar[i]%></font></td>
         </tr>
     <%}%>
     <!--------------------- Store Goal totals----------------------------->
     <tr class="DataTable2">
        <td class="DataTable1">Totals</td>
        <th class="DataTable"></th>

        <%for(int j=0; j < iNumOfWk; j++) {%>
            <td class="DataTable">$<%=sRepGoal[j]%></td>
            <td class="DataTable1">$<%=sRepTYSls[j]%></td>
            <td class="DataTable" id="LYWKSLS">$<%=sRepLYSls[j]%></td>
            <td class="DataTable">
               <font color="<%if(sRepVar[j].indexOf("-") > 0){%>red<%} else {%>black<%}%>">$<%=sRepVar[j]%></font></td>
            <th class="DataTable"></th>
        <%}%>

        <td class="DataTable">$<%=sRepTotGoal%></td>
        <td class="DataTable">$<%=sRepTotTYSls%></td>
        <td class="DataTable" id="LYWKSLS">$<%=sRepTotLYSls%></td>
        <td class="DataTable">
           <font color="<%if(sRepTotVar.indexOf("-") > 0){%>red<%} else {%>black<%}%>">$<%=sRepTotVar%></font></td>
      </tr>
    </table>
    <font color="red">* Current Week sales are week-to-date.</font><br><br><br>

    <!---------------- Classes -------------------------------------------->
    <b>List of Coordinator Classes</b>

    <table class='DataTable' cellPadding="0" cellSpacing="0">
      <tr>
        <th class='DataTable'>Div<br>#</th>
        <th class='DataTable'>Dpt<br>#</th>
        <th class='DataTable'>Class</th>
      </tr>
      <%for(int i=0; i < iNumOfCls; i++) {%>
         <tr class="DataTable">
            <td class="DataTable"><%=sDiv[i]%></td>
            <td class="DataTable"><%=sDpt[i]%></td>
            <td class="DataTable"><%=sCls[i] + " - " + sClsName[i] %></td>
         </tr>
      <%}%>
    </table>

</body>
</html>

<%}%>

