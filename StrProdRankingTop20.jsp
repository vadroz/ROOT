<%@ page import="strempslsrep.StrProdRankingTop20, java.util.*"%>
<%
   String sTopSlr = request.getParameter("TOPSLR");
   String sFrWkEnd = request.getParameter("FROMWK");
   String sToWkEnd = request.getParameter("TOWK");
   String sRank = request.getParameter("RANK");
   String sSlsPrsOnly = request.getParameter("ONLY");

   if(sRank==null) sRank="OVERALL";
   if(sSlsPrsOnly==null) sSlsPrsOnly="N";

   StrProdRankingTop20 rank = new StrProdRankingTop20(sTopSlr, sFrWkEnd, sToWkEnd, sRank, sSlsPrsOnly);

   int iNumOfEmp = rank.getNumOfEmp();

    String [] sEmp = rank.getEmp();
    String [] sEmpName = rank.getEmpName();
    String [] sEmpStr = rank.getEmpStr();
    String [] sEmpTitle = rank.getEmpTitle();
    String [] sEmpDept = rank.getEmpDept();

    String [] sEmpTYHour = rank.getEmpTYHour();
    String [] sEmpTYTran = rank.getEmpTYTran();
    String [] sEmpTYSlsHr = rank.getEmpTYSlsHr();
    String [] sEmpTYRank1 = rank.getEmpTYRank1();
    String [] sEmpTYSlsTr = rank.getEmpTYSlsTr();
    String [] sEmpTYRank2 = rank.getEmpTYRank2();
    String [] sEmpTYItmTr = rank.getEmpTYItmTr();
    String [] sEmpTYRank3 = rank.getEmpTYRank3();
    String [] sEmpTYAmt = rank.getEmpTYAmt();
    String [] sEmpTYRank4 = rank.getEmpTYRank4();
    String [] sEmpTYRank5 = rank.getEmpTYRank5();

    String [] sEmpLYHour = rank.getEmpLYHour();
    String [] sEmpLYTran = rank.getEmpLYTran();
    String [] sEmpLYSlsHr = rank.getEmpLYSlsHr();
    String [] sEmpLYRank1 = rank.getEmpLYRank1();
    String [] sEmpLYSlsTr = rank.getEmpLYSlsTr();
    String [] sEmpLYRank2 = rank.getEmpLYRank2();
    String [] sEmpLYItmTr = rank.getEmpLYItmTr();
    String [] sEmpLYRank3 = rank.getEmpLYRank3();
    String [] sEmpLYAmt = rank.getEmpLYAmt();
    String [] sEmpLYRank4 = rank.getEmpLYRank4();
    String [] sEmpLYRank5 = rank.getEmpLYRank5();

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


  tr.DataTable { background:#e7e7e7; font-family:Arial; font-size:10px }
  tr.DataTable1 { background:cornsilk; font-family:Arial; font-size:10px }
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

  td.TYCell1{ background:cornsilk; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:left;}


  div.dvSelect { position:absolute; background-attachment: scroll;
              border: black solid 2px; width:250px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}
 .small{ text-align:left; font-family:Arial; font-size:10px;}

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//---------------------------------------------
// initialize value on load
//---------------------------------------------
function  bodyload()
{
  // set Weekly Selection Panel
  setSelectPanel();
  //set selection for Week dropdown menu
  doWeekSelect()
}
//------------------------------------------------------
// set Weekly Selection Panel
//------------------------------------------------------
function setSelectPanel()
{
  var html= "<u><b>Select another week</b></u><br><br>"
   + "From:<select name='FROMWK' class='small'></select><br>"
   + " &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;&nbsp; To: <select name='TOWK' class='small'></select>"
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
    for (idx = 0; idx < 20; idx++)
    {
      sundayUSA = eval(sunday.getMonth()+1) + "/" + sunday.getDate() + "/" + sunday.getFullYear();
      document.all.FROMWK.options[idx] = new Option(sundayUSA, sundayUSA);
      document.all.TOWK.options[idx] = new Option(sundayUSA, sundayUSA);
      sunday.setTime(sunday.getTime() - (7 * 86400000));
    }
}

//------------------------------------------------------
// show another selected week
//------------------------------------------------------
function sbmNewWeek()
{
   var SbmString = null;
   var wkIdx = document.all.FROMWK.selectedIndex;
   var from = document.all.FROMWK.options[wkIdx].value;
   wkIdx = document.all.TOWK.selectedIndex;
   var to = document.all.TOWK.options[wkIdx].value;

   SbmString = "StrProdRankingTop20.jsp?TOPSLR=<%=sTopSlr%>"
             + "&FROMWK=" + from
             + "&TOWK=" + to
             + "&ONLY=<%=sSlsPrsOnly%>"
             +"&RANK=<%=sRank%>";

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
      <br>Top Sellers Report
      <br> From Weekending date: <font color="green"><%=sFrWkEnd%> &nbsp;  &nbsp;  &nbsp;  &nbsp;
           To Weekending date: <font color="green"><%=sToWkEnd%>
      </font>

      <br>Rank by <%if(sRank.equals("SLSHR")){%>Sales per Hours<%}
              else if(sRank.equals("SLSTR")){%>Sales per Transaction<%}
              else if(sRank.equals("ITMTR")){%>Items per Transaction<%}
              else if(sRank.equals("AMT")){%>Sales Amount<%}
              else if(sRank.equals("OVERALL")){%>Overall scores<%}%>
          </b>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
      <font size="-1">Click here to show <%if(sSlsPrsOnly.equals("N")){%><a href="StrProdRankingTop20.jsp?TOPSLR=<%=sTopSlr%>&FROMWK=<%=sFrWkEnd%>&TOWK=<%=sToWkEnd%>&RANK=<%=sRank%>&ONLY=Y">sales personnel only</a>;<%}
        else if(sSlsPrsOnly.equals("Y")){%><a href="StrProdRankingTop20.jsp?TOPSLR=<%=sTopSlr%>&FROMWK=<%=sFrWkEnd%>&TOWK=<%=sToWkEnd%>&RANK=<%=sRank%>&ONLY=N">all employees included</a>;<%}%></font>
      &nbsp;&nbsp;&nbsp;&nbsp;
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="StrProdReports.html"><font color="red" size="-1">Store Productivity Reports</font></a>&#62;
      <a href="StrProdRankingTop20Sel.jsp"><font color="red" size="-1">Store Productivity Reports</font></a>&#62;
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
      <th class="DataTable" rowspan="2">Dept<br>#</th>
      <th class="DataTable" rowspan="2">Emp<br>Title</th>
      <th class="DataTable" rowspan="2">Str<br>#</th>
      <th class="DataTable1" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="2">Overall<br>Rank</th>
      <th class="DataTable1" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="2">Hours<br>Worked</th>
      <th class="DataTable1" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="2"># of<br>Trans</th>
      <th class="DataTable1" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="2">Sales per<br>Hour</th>
      <th class="DataTable" colspan="2">Rank</th>
      <th class="DataTable1" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="2">Sales per<br>Trans</th>
      <th class="DataTable" colspan="2">Rank</th>
      <th class="DataTable1" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="2">Item per<br>Trans</th>
      <th class="DataTable" colspan="2">Rank</th>
      <th class="DataTable1" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="2">Total<br>Sales</th>
      <th class="DataTable" colspan="2">Rank</th>
    </tr>
    <tr>
      <th class="DataTable">
        <a href="StrProdRankingTop20.jsp?TOPSLR=<%=sTopSlr%>&FROMWK=<%=sFrWkEnd%>&TOWK=<%=sToWkEnd%>&RANK=OVERALL&ONLY=<%=sSlsPrsOnly%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
         <a href="StrProdRankingTop20.jsp?TOPSLR=<%=sTopSlr%>&FROMWK=<%=sFrWkEnd%>&TOWK=<%=sToWkEnd%>&RANK=SLSHR&ONLY=<%=sSlsPrsOnly%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProdRankingTop20.jsp?TOPSLR=<%=sTopSlr%>&FROMWK=<%=sFrWkEnd%>&TOWK=<%=sToWkEnd%>&RANK=SLSTR&ONLY=<%=sSlsPrsOnly%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProdRankingTop20.jsp?TOPSLR=<%=sTopSlr%>&FROMWK=<%=sFrWkEnd%>&TOWK=<%=sToWkEnd%>&RANK=ITMTR&ONLY=<%=sSlsPrsOnly%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProdRankingTop20.jsp?TOPSLR=<%=sTopSlr%>&FROMWK=<%=sFrWkEnd%>&TOWK=<%=sToWkEnd%>&RANK=AMT&ONLY=<%=sSlsPrsOnly%>">TY</a></th>
      <th class="DataTable">LY</th>
    </tr>

<!------------------------------- Detail Data --------------------------------->
   <%for(int i=0; i < iNumOfEmp; i++){%>


         <tr class="DataTable">
           <td class="DataTable1" nowrap><%=sEmp[i]%></td>
           <td class="DataTable1" nowrap><%=sEmpName[i]%></td>
           <td class="DataTable1" nowrap><%=sEmpDept[i]%></td>
           <td class="DataTable1" nowrap><%=sEmpTitle[i]%></td>
           <td class="DataTable1" nowrap><%=sEmpStr[i]%></td>

           <th class="DataTable1">&nbsp;</th>
           <td class="TYCell" nowrap><%=sEmpTYRank5[i]%></td>
           <td class="DataTable" nowrap><%=sEmpLYRank5[i]%></td>

           <th class="DataTable1">&nbsp;</th>
           <td class="TYCell" nowrap><%=sEmpTYHour[i]%></td>
           <td class="DataTable" nowrap><%=sEmpLYHour[i]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap><%=sEmpTYTran[i]%></td>
           <td class="DataTable" nowrap><%=sEmpLYTran[i]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sEmpTYSlsHr[i]%></td>
           <td class="DataTable" nowrap>$<%=sEmpLYSlsHr[i]%></td>
           <td class="TYCell" nowrap><%=sEmpTYRank1[i]%></td>
           <td class="DataTable" nowrap><%=sEmpLYRank1[i]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sEmpTYSlsTr[i]%></td>
           <td class="DataTable" nowrap>$<%=sEmpLYSlsTr[i]%></td>
           <td class="TYCell" nowrap><%=sEmpTYRank2[i]%></td>
           <td class="DataTable" nowrap><%=sEmpLYRank2[i]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap><%=sEmpTYItmTr[i]%></td>
           <td class="DataTable" nowrap><%=sEmpLYItmTr[i]%></td>
           <td class="TYCell" nowrap><%=sEmpTYRank3[i]%></td>
           <td class="DataTable" nowrap><%=sEmpLYRank3[i]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sEmpTYAmt[i]%></td>
           <td class="DataTable" nowrap>$<%=sEmpLYAmt[i]%></td>
           <td class="TYCell" nowrap><%=sEmpTYRank4[i]%></td>
           <td class="DataTable" nowrap><%=sEmpLYRank4[i]%></td>
        </tr>
   <%}%>
<!-------------------------- end of Report Totals ----------------------------->
 </table>
 <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
