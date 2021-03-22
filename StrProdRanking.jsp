<%@ page import="strempslsrep.StrProdRanking, java.util.*"%>
<%
   String sStore = request.getParameter("STORE");
   String sStrName = request.getParameter("STRNAME");
   String sWeekend = request.getParameter("WEEKEND");
   String sRank = request.getParameter("RANK");
   String sSort = request.getParameter("SORT");
   String sSlsPrsOnly = request.getParameter("ONLY");
   String sInclude = request.getParameter("Include");

   if(sRank==null) sRank="OVERALL";
   if(sSlsPrsOnly==null) sSlsPrsOnly="N";
   if(sInclude==null) sInclude="Y";

   StrProdRanking rank = new StrProdRanking(sStore, sWeekend, sRank, sSlsPrsOnly, sInclude);
    int  iNumOfDpt = rank.getNumOfDpt();
    String [] sDpt = rank.getDpt();
    String [] sDptName = rank.getDptName();

    String [] sDptTYHour = rank.getDptTYHour();
    String [] sDptTYTran = rank.getDptTYTran();
    String [] sDptTYSlsHr = rank.getDptTYSlsHr();
    String [] sDptTYSlsTr = rank.getDptTYSlsTr();
    String [] sDptTYItmTr = rank.getDptTYItmTr();
    String [] sDptTYAmt = rank.getDptTYAmt();

    String [] sDptLYHour = rank.getDptLYHour();
    String [] sDptLYTran = rank.getDptLYTran();
    String [] sDptLYSlsHr = rank.getDptLYSlsHr();
    String [] sDptLYSlsTr = rank.getDptLYSlsTr();
    String [] sDptLYItmTr = rank.getDptLYItmTr();
    String [] sDptLYAmt = rank.getDptLYAmt();

    int [] iNumOfEmp = rank.getNumOfEmp();

    String [][] sEmp = rank.getEmp();
    String [][] sEmpName = rank.getEmpName();
    String [][] sEmpSepr = rank.getEmpSepr();

    String [][] sEmpTYHour = rank.getEmpTYHour();
    String [][] sEmpTYTran = rank.getEmpTYTran();
    String [][] sEmpTYSlsHr = rank.getEmpTYSlsHr();
    String [][] sEmpTYRank1 = rank.getEmpTYRank1();
    String [][] sEmpTYSlsTr = rank.getEmpTYSlsTr();
    String [][] sEmpTYRank2 = rank.getEmpTYRank2();
    String [][] sEmpTYItmTr = rank.getEmpTYItmTr();
    String [][] sEmpTYRank3 = rank.getEmpTYRank3();
    String [][] sEmpTYAmt = rank.getEmpTYAmt();
    String [][] sEmpTYRank4 = rank.getEmpTYRank4();
    String [][] sEmpTYRank5 = rank.getEmpTYRank5();

    String [][] sEmpLYHour = rank.getEmpLYHour();
    String [][] sEmpLYTran = rank.getEmpLYTran();
    String [][] sEmpLYSlsHr = rank.getEmpLYSlsHr();
    String [][] sEmpLYRank1 = rank.getEmpLYRank1();
    String [][] sEmpLYSlsTr = rank.getEmpLYSlsTr();
    String [][] sEmpLYRank2 = rank.getEmpLYRank2();
    String [][] sEmpLYItmTr = rank.getEmpLYItmTr();
    String [][] sEmpLYRank3 = rank.getEmpLYRank3();
    String [][] sEmpLYAmt = rank.getEmpLYAmt();
    String [][] sEmpLYRank4 = rank.getEmpLYRank4();
    String [][] sEmpLYRank5 = rank.getEmpLYRank5();

    String sStrTYHour = rank.getStrTYHour();
    String sStrTYTran = rank.getStrTYTran();
    String sStrTYSlsHr = rank.getStrTYSlsHr();
    String sStrTYSlsTr = rank.getStrTYSlsTr();
    String sStrTYItmTr = rank.getStrTYItmTr();
    String sStrTYAmt = rank.getStrTYAmt();

    String sStrLYHour = rank.getStrLYHour();
    String sStrLYTran = rank.getStrLYTran();
    String sStrLYSlsHr = rank.getStrLYSlsHr();
    String sStrLYSlsTr = rank.getStrLYSlsTr();
    String sStrLYItmTr = rank.getStrLYItmTr();
    String sStrLYAmt = rank.getStrLYAmt();
   rank.disconnect();
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
  th.DataTable { background:#FFCC99; border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px;
                 padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 text-align:center; font-family:Verdanda; font-size:12px }
  th.DataTable1 { background:#FFCC99; border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px;
                 text-align:center; font-family:Verdanda; font-size:12px }


  tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }
  tr.DataTable1 { background:azure; font-family:Arial; font-size:10px }
  tr.DataTable2 { background:seashell; font-family:Arial; font-size:10px }

  td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:right;}

  td.DataTable1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:left;}

  td.TYCell { background:cornsilk; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:right;}

  div.dvSelect { position:absolute; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}
 .small{ text-align:left; font-family:Arial; font-size:10px;}

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var include = false;
//--------------- End of Global variables ----------------
//---------------------------------------------
// initialize value on load
//---------------------------------------------
function  bodyload()
{
  // set Weekly Selection Panel
  setSelectPanel();
  //set selection for Week dropdown menu
  doWeekSelect();

  // switch all/current employees.
  showSeparated();
}
//------------------------------------------------------
// set Weekly Selection Panel
//------------------------------------------------------
function setSelectPanel()
{
  var html= "<u><b>Select another week</b></u><br><br>"
   + "<select name='WEEK' class='small'></select>&nbsp;&nbsp;"
   + "<button id='GO' class='small' onClick='javascript:sbmNewWeek()'>&nbsp;Go&nbsp;</button><br><br>";
  document.all.dvSelect.innerHTML=html;
}

//------------------------------------------------------
// Weeks Stores
//------------------------------------------------------
function doWeekSelect() {
    var idx = 0;

    var todate = new Date();
    // find 1st sunday
    sunday = new Date(todate.getFullYear(), todate.getMonth(), todate.getDate()-todate.getDay());

    // populate array with 10 previous sundays
    for (idx = 0; idx < 10; idx++)
    {
      sundayUSA = eval(sunday.getMonth()+1) + "/" + sunday.getDate() + "/" + sunday.getFullYear();
      document.all.WEEK.options[idx] = new Option(sundayUSA, sundayUSA);
      sunday.setTime(sunday.getTime() - (7 * 86400000));
    }
}
//------------------------------------------------------
// show all or only current employee only
//------------------------------------------------------
function showSeparated()
{
   var sep = document.all.SepY;
   include = !include;
   if(include)
   {
      document.all.spanSep.innerHTML="current employees only";
      for(var i=0; i < sep.length; i++) { sep[i].style.display="block"; }
   }
   else
   {
      document.all.spanSep.innerHTML="all employees";
      for(var i=0; i < sep.length; i++) { sep[i].style.display="none"; }
   }
}
//------------------------------------------------------
// show another selected week
//------------------------------------------------------
function sbmNewWeek()
{
   var SbmString = null;
   var wkIdx = document.all.WEEK.selectedIndex;
   var selWeek = document.all.WEEK.options[wkIdx].value;

   SbmString = "StrProdRanking.jsp?STORE=<%=sStore%>" + "&STRNAME=<%=sStrName%>"
             + "&WEEKEND=" + selWeek
             + "&RANK=<%=sRank%>"
             + "&SORT=<%=sSort%>"
             + "&Include=<%=sInclude%>"
             ;

   //alert(SbmString);
   window.location.href=SbmString;
}

</SCRIPT>


</head>
<body onload="bodyload()">
<!-------------------------------------------------------------------->
    <div id="dvSelect" class="dvSelect"></div>
<!-------------------------------------------------------------------->
 <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
   <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Sales Productivity Ranking Report
      <br>Store:<%=sStore + " - " + sStrName%>
      <br>Weekending date:<%=sWeekend%>
      <br>Rank by <%if(sRank.equals("SLSHR")){%>Sales per Hours<%}
              else if(sRank.equals("SLSTR")){%>Sales per Transaction<%}
              else if(sRank.equals("ITMTR")){%>Items per Transaction<%}
              else if(sRank.equals("AMT")){%>Sales Amount<%}
              else if(sRank.equals("OVERALL")){%>Overall scores<%}%>
          </b>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">

      <font size="-1">Click here to show <%if(sSlsPrsOnly.equals("N")){%><a href="StrProdRanking.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&WEEKEND=<%=sWeekend%>&RANK=<%=sRank%>&SORT=<%=sSort%>&ONLY=Y&Include=<%=sInclude%>">sales personnel only</a>;<%}
        else if(sSlsPrsOnly.equals("Y")){%><a href="StrProdRanking.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&WEEKEND=<%=sWeekend%>&RANK=<%=sRank%>&SORT=<%=sSort%>&ONLY=N&Include=<%=sInclude%>">all employees included</a>;<%}%></font>
        &nbsp;&nbsp;&nbsp;&nbsp;
      <font size="-1">Click here to show <a href="javascript: showSeparated()"><span id="spanSep"></span></a>;<br>

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="StrProdReports.html"><font color="red" size="-1">Store Productivity Reports</font></a>&#62;
      <a href="StrProdRankingSel.jsp"><font color="red" size="-1">Ranking Selection</font></a>&#62;
      <a href="StrProdRankingSum.jsp?&WEEKEND=<%=sWeekend%>&RANK=<%=sRank%>&SORT=<%=sSort%>&ONLY=<%=sSlsPrsOnly%>"><font color="red" size="-1">All Store Ranking</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp
      <span style="font-family:Arial; font-size:11px">Excludes: Sick, Vacation and Holiday</span>
      </td>
   </tr>
   <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
<!-------------------------------------------------------------------->
  <!----------------- beginning of table ------------------------>
  <table class="DataTable" cellPadding="0" cellSpacing="0">
    <tr>
      <th class="DataTable" rowspan="2">Emp<br>#</th>
      <th class="DataTable" rowspan="2">Emp<br>Name</th>
      <th class="DataTable1" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="2">Hours<br>Worked</th>
      <th class="DataTable1" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="2"># of<br>Trans</th>
      <th class="DataTable1" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="2">Sales per<br>Hour</th>
      <th class="DataTable" colspan="2">Rank</th>
      <th class="DataTable1" rowspan="2"><%for(int i=0; i < 15; i++){%>&nbsp;<%}%></th>
      <th class="DataTable" colspan="2">Sales per<br>Trans</th>
      <th class="DataTable" colspan="2">Rank</th>
      <th class="DataTable1" rowspan="2"><%for(int i=0; i < 15; i++){%>&nbsp;<%}%></th>
      <th class="DataTable" colspan="2">Item per<br>Trans</th>
      <th class="DataTable" colspan="2">Rank</th>
      <th class="DataTable1" rowspan="2"><%for(int i=0; i < 15; i++){%>&nbsp;<%}%></th>
      <th class="DataTable" colspan="2">Total<br>Sales</th>
      <th class="DataTable" colspan="2">Rank</th>
      <th class="DataTable1" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="2">Overall<br>Rank</th>
    </tr>
    <tr>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
         <a href="StrProdRanking.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&WEEKEND=<%=sWeekend%>&RANK=SLSHR&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>&Include=<%=sInclude%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProdRanking.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&WEEKEND=<%=sWeekend%>&RANK=SLSTR&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>&Include=<%=sInclude%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProdRanking.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&WEEKEND=<%=sWeekend%>&RANK=ITMTR&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>&Include=<%=sInclude%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProdRanking.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&WEEKEND=<%=sWeekend%>&RANK=AMT&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>&Include=<%=sInclude%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProdRanking.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&WEEKEND=<%=sWeekend%>&RANK=OVERALL&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>&Include=<%=sInclude%>">TY</a></th>
      <th class="DataTable">LY</th>
    </tr>

<!------------------------------- Detail Data --------------------------------->
   <%for(int i=0; i < iNumOfDpt; i++){%>

     <%for(int j=0; j < iNumOfEmp[i]; j++){%>
         <tr class="DataTable" id="Sep<%=sEmpSepr[i][j]%>" >
           <td class="DataTable1"nowrap><%=sEmp[i][j]%></td>
           <td class="DataTable1" nowrap><%=sEmpName[i][j]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap><%=sEmpTYHour[i][j]%></td>
           <td class="DataTable" nowrap><%=sEmpLYHour[i][j]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap><%=sEmpTYTran[i][j]%></td>
           <td class="DataTable" nowrap><%=sEmpLYTran[i][j]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sEmpTYSlsHr[i][j]%></td>
           <td class="DataTable" nowrap>$<%=sEmpLYSlsHr[i][j]%></td>
           <td class="TYCell" nowrap><%=sEmpTYRank1[i][j]%></td>
           <td class="DataTable" nowrap><%=sEmpLYRank1[i][j]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sEmpTYSlsTr[i][j]%></td>
           <td class="DataTable" nowrap>$<%=sEmpLYSlsTr[i][j]%></td>
           <td class="TYCell" nowrap><%=sEmpTYRank2[i][j]%></td>
           <td class="DataTable" nowrap><%=sEmpLYRank2[i][j]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap><%=sEmpTYItmTr[i][j]%></td>
           <td class="DataTable" nowrap><%=sEmpLYItmTr[i][j]%></td>
           <td class="TYCell" nowrap><%=sEmpTYRank3[i][j]%></td>
           <td class="DataTable" nowrap><%=sEmpLYRank3[i][j]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sEmpTYAmt[i][j]%></td>
           <td class="DataTable" nowrap>$<%=sEmpLYAmt[i][j]%></td>
           <td class="TYCell" nowrap><%=sEmpTYRank4[i][j]%></td>
           <td class="DataTable" nowrap><%=sEmpLYRank4[i][j]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap><%=sEmpTYRank5[i][j]%></td>
           <td class="DataTable" nowrap><%=sEmpLYRank5[i][j]%></td>
        </tr>
     <%}%>
<!------------------------------- Department Totals---------------------------->
      <tr class="DataTable1">
         <td class="DataTable1" colspan="2" nowrap>Dept: <%=sDpt[i]%> - <%=sDptName[i]%></td>
         <th class="DataTable1">&nbsp;</th>

         <td class="DataTable" nowrap><%=sDptTYHour[i]%></td>
         <td class="DataTable" nowrap><%=sDptLYHour[i]%></td>
         <th class="DataTable1">&nbsp;</th>

         <td class="DataTable" nowrap><%=sDptTYTran[i]%></td>
         <td class="DataTable" nowrap><%=sDptLYTran[i]%></td>
         <th class="DataTable1">&nbsp;</th>

         <td class="DataTable" nowrap>$<%=sDptTYSlsHr[i]%></td>
         <td class="DataTable" nowrap>$<%=sDptLYSlsHr[i]%></td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <th class="DataTable1">&nbsp;</th>

         <td class="DataTable" nowrap>$<%=sDptTYSlsTr[i]%></td>
         <td class="DataTable" nowrap>$<%=sDptLYSlsTr[i]%></td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <th class="DataTable1">&nbsp;</th>

         <td class="DataTable" nowrap><%=sDptTYItmTr[i]%></td>
         <td class="DataTable" nowrap><%=sDptLYItmTr[i]%></td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <th class="DataTable1">&nbsp;</th>

         <td class="DataTable" nowrap>$<%=sDptTYAmt[i]%></td>
         <td class="DataTable" nowrap>$<%=sDptLYAmt[i]%></td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <th class="DataTable1">&nbsp;</th>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
      </tr>
   <%}%>
<!------------------------------- Store Total --------------------------------->
<tr class="DataTable2">
         <td class="DataTable1" colspan="2" nowrap>Store: <%=sStore%></td>
         <th class="DataTable1">&nbsp;</th>

         <td class="DataTable" nowrap><%=sStrTYHour%></td>
         <td class="DataTable" nowrap><%=sStrLYHour%></td>
         <th class="DataTable1">&nbsp;</th>

         <td class="DataTable" nowrap><%=sStrTYTran%></td>
         <td class="DataTable" nowrap><%=sStrLYTran%></td>
         <th class="DataTable1">&nbsp;</th>

         <td class="DataTable" nowrap>$<%=sStrTYSlsHr%></td>
         <td class="DataTable" nowrap>$<%=sStrLYSlsHr%></td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <th class="DataTable1">&nbsp;</th>

         <td class="DataTable" nowrap>$<%=sStrTYSlsTr%></td>
         <td class="DataTable" nowrap>$<%=sStrLYSlsTr%></td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <th class="DataTable1">&nbsp;</th>

         <td class="DataTable" nowrap><%=sStrTYItmTr%></td>
         <td class="DataTable" nowrap><%=sStrLYItmTr%></td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <th class="DataTable1">&nbsp;</th>

         <td class="DataTable" nowrap>$<%=sStrTYAmt%></td>
         <td class="DataTable" nowrap>$<%=sStrLYAmt%></td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <th class="DataTable1">&nbsp;</th>

         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
      </tr>
<!-------------------------- end of Report Totals ----------------------------->
 </table>
 <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
