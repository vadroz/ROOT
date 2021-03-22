<%@ page import="coordinators.CoorGoal, rciutility.FormatNumericValue, java.util.*"%>
<%
   String sCoordinator = request.getParameter("Coordinator");
   String sMonthYear = request.getParameter("MonthYear");
   String sMonthName = request.getParameter("MonthName");
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("COORGOAL")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=CoorGoal.jsp&APPL=COORGOAL&" + request.getQueryString());
   }
   else
   {
      CoorGoal goal = new CoorGoal(sMonthYear, sCoordinator);

      int iNumOfWk = goal.getNumOfWk();
      String [] sWeek = goal.getWeek();
      int iNumOfStr = goal.getNumOfStr();

      String [] sStr = goal.getStr();
      String [][] sSales = goal.getSales();
      String [] sTotSls = goal.getTotSls();
      String [][] sPrc = goal.getPrc();
      String [][] sGoal = goal.getGoal();
      String [] sTotGoal = goal.getTotGoal();

      int iNumOfCls = goal.getNumOfCls();
      String [] sDiv = goal.getDiv();
      String [] sDpt = goal.getDpt();
      String [] sCls = goal.getCls();
      String [] sClsName = goal.getClsName();

      String sStrJsa = goal.getStrJsa();
      String sWeekJsa = goal.getWeekJsa();
      String sSalesJsa = goal.getSalesJsa();
      String sTotSlsJsa = goal.getTotSlsJsa();

      goal.disconnect();
      // format Numeric value
      FormatNumericValue fmt = new FormatNumericValue();
%>
<html>
<head>
<style>
        body {background:lemonChiffon; text-align:center;}
        a { color:blue} a:visited { color:blue}  a:hover { color:blue}

        table.DataTable { border: darkred solid 1px; background: darkred; text-align:center;}
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center;
                       font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center;
                       font-family:Verdanda; font-size:12px }

        td.DataTable  { background:Gainsboro; border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px; text-align:left; font-family:Arial;font-size:10px }

        td.DataTable1  { background:Gainsboro; border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                        padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                        border-right: darkred solid 1px; text-align:right; font-family:Arial;font-size:10px }

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
var NumOfStr = <%=iNumOfStr%>;
var NumOfWk = <%=iNumOfWk%>;
var Store = [<%=sStrJsa%>];
var Week = [<%=sWeekJsa%>];
var Sales = [<%=sSalesJsa%>];
var TotSls = [<%=sTotSlsJsa%>];
var msg = "";

var Percent = new Array(NumOfStr);
var Goal = new Array(NumOfStr);
for(var i=0; i < NumOfStr; i++ ) { Percent[i] = new Array(NumOfWk); Goal[i] = new Array(NumOfWk); }

var WeekGoal = new Array(NumOfWk);
var WeekSales = new Array(NumOfWk);

//---------------------------------------------------------
// work at loading time
//---------------------------------------------------------
function bodyLoad()
{
  for(var i=0; i < NumOfWk; i++ ) { WeekGoal[i] = 0;  WeekSales[i] = 0; }
  calcAllGoal()
  document.all.Save.style.visibility = "hidden";
  setWeekSelection();
  setCoordinatorSelection();
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
   SbmString = "CoorGoal.jsp"
        + "?MonthYear=" + selWeek.value
        + "&MonthName=" + selWeek.text
        + "&Coordinator=" + selCoor

    //alert(SbmString);
    window.location.href=SbmString;
}

//---------------------------------------------------------
// reset all input fields
//---------------------------------------------------------
function resetAll()
{
  document.all.PrcAll.value = "";
  for(var i=0; i < NumOfStr; i++ )
  {
    document.all["Prc" + i + "T"].value = "";
    for(var j=0; j < NumOfWk; j++ )
    {
       obj = "Prc" + i + "W" + j;
       document.all[obj].value="";
       obj = "Goal" + i + "W" + j;
       document.all[obj].innerHTML="";
    }
    document.all["Goal" + i + "T"].innerHTML = "";
  }

  for(var i=0; i < NumOfWk; i++ ) { document.all["TGoalW" + i].innerHTML = ""; }
  document.all.Save.style.visibility = "hidden";
}
//---------------------------------------------------------
// calculate All Store Goal
//---------------------------------------------------------
function calcAllGoal()
{
  var prc = document.all.PrcAll.value.trim()
  document.all.PrcAll.value = "";
  var prcwk = new Array(NumOfWk);
  var sales = 0;
  var goal = 0;
  // reset total
  for(var i=0; i < NumOfWk; i++ )
  {
    WeekGoal[i] = 0;  WeekSales[i] = 0;
    if(prc == null || prc == "" || prc ==0) prcwk[i] = document.all["PrcW" + i].value;
    document.all["PrcW" + i].value="";
  }

  for(var i=0; i < NumOfStr; i++ ) { calcStrGoal(i, prc, prcwk); }
  for(var i=0; i < NumOfWk; i++ )
  {
    document.all["TSalesW" + i].innerHTML = "$"+ format(WeekSales[i]);
    document.all["TGoalW" + i].innerHTML = "$"+ format(WeekGoal[i]);
    sales += eval(WeekSales[i]);
    goal += eval(WeekGoal[i]);
  }

  document.all["TSalesT"].innerHTML = "$"+ format(sales);
  document.all["TGoalT"].innerHTML = "$"+ format(goal);

  // display error
  if(msg!="") alert(msg)
  else document.all.Save.style.visibility = "visible";
  msg = "";

}
//---------------------------------------------------------
// calculate seleted Store Goal
//---------------------------------------------------------
function calcStrGoal(str, prc, prcwk)
{
  if (prc == null || prc == "" || prc ==0) prc = document.all["Prc" + str + "T"].value;
  document.all["Prc" + str + "T"].value = "";

  var goal = null;
  var total = 0;
  var ovrPrice = prc;
  for(var i=0; i < NumOfWk; i++ )
  {
    if (prcwk[i] != null && prcwk[i] != "" && prcwk[i] != 0) ovrPrice = prcwk[i];
    else {ovrPrice = prc; }

    goal = calcWkGoal(str, i, ovrPrice);
    if(!isNaN(goal) && goal.trim() != "")
    {
      total += eval(goal);
      WeekGoal[i] += eval(goal);
      WeekSales[i] += eval(Sales[str][i]);
    }
  }
  document.all["Goal" + str + "T"].innerHTML = "$" + format(total);
}

//---------------------------------------------------------
// calculate seleted week Goal
//---------------------------------------------------------
function calcWkGoal(str, wk, prc)
{
   if (prc == null || prc == "" || prc ==0) prc = document.all["Prc" + str + "W" + wk].value;
   else document.all["Prc" + str + "W" + wk].value = prc;
   var goal = document.all["Goal" + str + "W" + wk];
   var goalv = document.all["Goal" + str + "W" + wk].innerHTML;

   var type = "%";
   if (prc.trim() != " " && prc.substring(0,1)=="$")
   {
     type = "$"; prc =  prc.substring(1);
   }

   // validate entry
   if(isNaN(prc) )
   {
      if(msg=="") msg += "Percent entry is not numeric"
   }
   else if(prc.trim() == "") {prc = 0;}

   //calculate goal based on percentage
   if(msg=="" && type == "%")
   {
     goalv = clcPrc(prc, Sales[str][wk]);
     goal.innerHTML = "$" + format(eval(goalv));
     Percent[str][wk] = prc;
     Goal[str][wk] = goalv;
   }
   //calculate goal based on percentage
   else if(msg=="" && type == "$")
   {
     goalv = clcAmt(prc, Sales[str][wk]);
     goal.innerHTML = "$" + format(eval(goalv));
     Percent[str][wk] = prc;
     Goal[str][wk] = goalv;
   }

   return goalv;
}
//---------------------------------------------------------
// calculate goal by applying percent to salses
//---------------------------------------------------------
function clcPrc( prc, sls )
{
  if(sls < 0) sls=0
  var goal = eval(sls) * (1 + eval(prc) / 100 );
  return goal.toFixed(0);
}

//---------------------------------------------------------
// save all goals
//---------------------------------------------------------
function saveStrGoal(str)
{
  var url = "CoorGoalEntry.jsp?Coordinator=<%=sCoordinator%>&MonthYear=<%=sMonthYear%>"
          + "&MonthName=<%=sMonthName%>&Store=" + Store[str].trim() + "&StrIdx=" + str

    for(var j=0; j < NumOfWk; j++ )
    {
       url += "&Week=" + Week[j]
            + "&Prc=" + Percent[str][j]
            + "&Goal=" + Goal[str][j]
            + "&Sales=" + Sales[str][j]
    }

    document.all.Save.style.visibility = "hidden";
    //alert(url)
    window.frame1.location = url;

}
//---------------------------------------------------------
// save next goals
//---------------------------------------------------------
function saveNextStrGoal(str)
{
   if(str+1 < NumOfStr)
   {
      saveStrGoal(str+1);
   }
}
//---------------------------------------------------------
// calculate goal by adding amount to salses
//---------------------------------------------------------
function clcAmt( amt, sls)
{
  var goal = eval(amt);
  return goal.toFixed(0);
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
//---------------------------------------------------------
// format numeric values
//---------------------------------------------------------
function format(num)
{
  return num.toString().split('').reverse().join('').replace(/(?=\d*\.?)(\d{3})/g,'$1,').split('').reverse().join('').replace(/^[\,]/,'')
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
   <b><font size="+2">Enter Coordinators Goals<br>
      Coordinator: <%=sCoordinator%>&nbsp; &nbsp; &nbsp;<%=sMonthName%></font></b><br>
      <SELECT name="MonthYear" class="small"></SELECT><br>
      <SELECT name="Coordinator" class="small"></SELECT>&nbsp;&nbsp;
      <button onclick="submitForm()">Go</button><br>

   <a href="../"><font color="red" size="-1">Home</font></a>&#62;
   <a href="StrScheduling.html"><font color="red" size="-1">Schedule Menu</font></a>&#62;
   <a href="CoorGoalSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
   <font size="-1">This page.</font>&nbsp;&nbsp;
   <a class="blue" href="CoorGoalComp.jsp?Coordinator=<%=sCoordinator%>&MonthYear=<%=sMonthYear%>&MonthName=<%=sMonthName%>"><font size="-1">Coordinator Goals</font></a>&nbsp;&nbsp;

   <table class='DataTable' cellPadding="0" cellSpacing="0">
      <tr>
        <th class='DataTable' rowspan="3">Store<br>#</th>
        <th class='DataTable' rowspan="3"></th>
        <%for(int j=0; j < iNumOfWk; j++) {%>
            <th class='DataTable' colspan=3>Week <%=j+1%></th>
        <%}%>
        <th class='DataTable' rowspan="3"></th>
        <th class='DataTable' rowspan=2 colspan=3>Month Total</th>
      </tr>

      <tr>
         <%for(int j=0; j < iNumOfWk; j++) {%>
            <th class='DataTable' colspan=3><%=sWeek[j]%></th>
         <%}%>
      </tr>

      <tr>
        <%for(int j=0; j < iNumOfWk; j++) {%>
           <th class='DataTable'>LY<br>Sales</th>
           <th class='DataTable'>%<br>+/-</th>
           <th class='DataTable'>Calc<br>Goal</th>
        <%}%>
           <th class='DataTable'>LY<br>Sales</th>
           <th class='DataTable'>%<br>+/-</th>
           <th class='DataTable'>Calc<br>Goal</th>
      </tr>

     <!---------------- Store ---------------------------------------------------->
     <%for(int i=0; i < iNumOfStr; i++) {%>
         <tr>
            <td class="DataTable1"><%=sStr[i]%></td>
            <th class='DataTable'></th>
            <!--------------------- Store Goal details ----------------------------->
            <%for(int j=0; j < iNumOfWk; j++) {%>
                <td class="DataTable1">
                  $<%=fmt.getFormatedNum(sSales[i][j].trim(), "#,###,###")%></td>
                <td class="DataTable">
                   <input class="small"  size=3 maxlength=7 name="Prc<%=i%>W<%=j%>"
                         value="<%=sPrc[i][j].trim()%>"></td>
                <td class="DataTable1" id="Goal<%=i%>W<%=j%>">$<%=fmt.getFormatedNum(sGoal[i][j].trim(), "#,###,###")%></td>
            <%}%>
            <th class='DataTable'></th>
            <td class="DataTable1">
               $<%=fmt.getFormatedNum(sTotSls[i], "#,###,###")%></td>
               <td class="DataTable1"><input class="small"  size=3 maxlength=7 name="Prc<%=i%>T"></td>
            <td class="DataTable1" id="Goal<%=i%>T"></td>
         </tr>
     <%}%>
     <!--------------------- Store Goal totals----------------------------->
     <tr>
        <td class="DataTable1">Totals</td>
        <th class='DataTable'></th>

        <%for(int j=0; j < iNumOfWk; j++) {%>
            <td class="DataTable1" id="TSalesW<%=j%>"></td>
            <td class="DataTable"><input class="small"  size=3 maxlength=7 name="PrcW<%=j%>"></td>
            <td class="DataTable" id="TGoalW<%=j%>"></td>
        <%}%>

        <th class='DataTable'></th>
        <td class="DataTable1" id="TSalesT"></td>
        <td class="DataTable"><input class="small"  size=3 maxlength=7 name="PrcAll"></td>
        <td class="DataTable" id="TGoalT"></td>
      </tr>

    </table>
    <button name="Calc" onClick="calcAllGoal()">Calc</button>&nbsp;&nbsp;&nbsp;&nbsp;
    <button name="Save" onClick="saveStrGoal(0)">Save</button>&nbsp;&nbsp;&nbsp;&nbsp;
    <button name="Reset" onClick="resetAll()">Reset All</button>
    <br><br>


    <!---------------- Classes -------------------------------------------->
    <b>List of Coordinator Classes</b>
    <table class='DataTable' cellPadding="0" cellSpacing="0">
      <tr>
        <th class='DataTable'>Div<br>#</th>
        <th class='DataTable'>Dpt<br>#</th>
        <th class='DataTable'>Class</th>
      </tr>
      <%for(int i=0; i < iNumOfCls; i++) {%>
         <tr>
            <td class="DataTable"><%=sDiv[i]%></td>
            <td class="DataTable"><%=sDpt[i]%></td>
            <td class="DataTable"><%=sCls[i] + " - " + sClsName[i] %></td>
         </tr>
      <%}%>
    </table>
</body>
</html>

<%}%>

