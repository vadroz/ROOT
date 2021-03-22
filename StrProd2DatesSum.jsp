<%@ page import="strempslsrep.StrProd2DatesSum, java.util.*"%>
<%
   String sFromWk = request.getParameter("FROMWKEND");
   String sToWk = request.getParameter("TOWKEND");
   String sSort = request.getParameter("SORT");
   String sRank = request.getParameter("RANK");
   String [] sSelStr = request.getParameterValues("Str");
   String sSlsPrsOnly = request.getParameter("ONLY");

   if(sSort==null) sSort="REGION";
   if(sRank==null) sRank="ITTRVAR";
   if(sSlsPrsOnly==null) sSlsPrsOnly="N";

   for(int i=0; i < sSelStr.length; i++){ System.out.print(" " + sSelStr[i]);}

   StrProd2DatesSum rank = new StrProd2DatesSum(sSelStr, sFromWk, sToWk, sSort, sRank, sSlsPrsOnly);

    int  iNumOfReg = rank.getNumOfReg();
    String [] sReg = rank.getReg();
    String [] sRegName = rank.getRegName();

    String [] sRegTYHour = rank.getRegTYHour();
    String [] sRegTYTran = rank.getRegTYTran();
    String [] sRegTYSlsHr = rank.getRegTYSlsHr();
    String [] sRegTYSlsTr = rank.getRegTYSlsTr();
    String [] sRegTYItmTr = rank.getRegTYItmTr();
    String [] sRegTYAmt = rank.getRegTYAmt();

    String [] sRegLYHour = rank.getRegLYHour();
    String [] sRegLYTran = rank.getRegLYTran();
    String [] sRegLYSlsHr = rank.getRegLYSlsHr();
    String [] sRegLYSlsTr = rank.getRegLYSlsTr();
    String [] sRegLYItmTr = rank.getRegLYItmTr();
    String [] sRegLYAmt = rank.getRegLYAmt();
    String [] sRegItTrVar = rank.getRegItTrVar();

    int [] iNumOfStr = rank.getNumOfStr();
    String [][] sStr = rank.getStr();
    String [][] sStrName = rank.getStrName();

    String [][] sStrTYHour = rank.getStrTYHour();
    String [][] sStrTYTran = rank.getStrTYTran();
    String [][] sStrTYSlsHr = rank.getStrTYSlsHr();
    String [][] sStrTYRank1 = rank.getStrTYRank1();
    String [][] sStrTYSlsTr = rank.getStrTYSlsTr();
    String [][] sStrTYRank2 = rank.getStrTYRank2();
    String [][] sStrTYItmTr = rank.getStrTYItmTr();
    String [][] sStrTYRank3 = rank.getStrTYRank3();
    String [][] sStrTYAmt = rank.getStrTYAmt();
    String [][] sStrTYRank4 = rank.getStrTYRank4();
    String [][] sStrTYRank5 = rank.getStrTYRank5();

    String [][] sStrLYHour = rank.getStrLYHour();
    String [][] sStrLYTran = rank.getStrLYTran();
    String [][] sStrLYSlsHr = rank.getStrLYSlsHr();
    String [][] sStrLYRank1 = rank.getStrLYRank1();
    String [][] sStrLYSlsTr = rank.getStrLYSlsTr();
    String [][] sStrLYRank2 = rank.getStrLYRank2();
    String [][] sStrLYItmTr = rank.getStrLYItmTr();
    String [][] sStrLYRank3 = rank.getStrLYRank3();
    String [][] sStrLYAmt = rank.getStrLYAmt();
    String [][] sStrLYRank4 = rank.getStrLYRank4();
    String [][] sStrLYRank5 = rank.getStrLYRank5();

    String [][] sStrItTrVar = rank.getStrItTrVar();
    String [][] sStrItTrRank = rank.getStrItTrRank();

    String sRepTYHour = rank.getRepTYHour();
    String sRepTYTran = rank.getRepTYTran();
    String sRepTYSlsHr = rank.getRepTYSlsHr();
    String sRepTYSlsTr = rank.getRepTYSlsTr();
    String sRepTYItmTr = rank.getRepTYItmTr();
    String sRepTYAmt = rank.getRepTYAmt();

    String sRepLYHour = rank.getRepLYHour();
    String sRepLYTran = rank.getRepLYTran();
    String sRepLYSlsHr = rank.getRepLYSlsHr();
    String sRepLYSlsTr = rank.getRepLYSlsTr();
    String sRepLYItmTr = rank.getRepLYItmTr();
    String sRepLYAmt = rank.getRepLYAmt();

    String sRepItTrVar = rank.getRepItTrVar();

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
                 padding-top:3px; padding-bottom:3px;padding-left:3px; padding-right:3px;
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
              border: black solid 2px; width:250px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}
 .small{ text-align:left; font-family:Arial; font-size:10px;}

</style>
<SCRIPT language="JavaScript1.2">
SelStr = new Array();
<%for(int i=0; i < sSelStr.length; i++){%>SelStr[<%=i%>] = "<%=sSelStr[i]%>"; <%}%>
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
   + "From: <select name='FROMWK' class='small'></select>&nbsp;&nbsp;"
   + "To: <select name='TOWK' class='small'></select>&nbsp;&nbsp;"
   + "<button id='GO' class='small' onClick='javascript:sbmNewWeek()'>&nbsp;Go&nbsp;</button><br><br>";
  document.all.dvSelect.innerHTML=html;
}
//------------------------------------------------------
// Weeks Stores
//------------------------------------------------------
function doWeekSelect() {
    var idx = 0;

    var todate = new Date();
    var sunday = new Date(todate.getFullYear(), todate.getMonth(), todate.getDate()-todate.getDay(), 18);

    // from date
    for (var idx = 0; idx < 90; idx++)
    {
      sundayUSA = eval(sunday.getMonth()+1) + "/" + sunday.getDate() + "/" + sunday.getFullYear();
      document.all.FROMWK.options[idx] = new Option(sundayUSA, sundayUSA);
      sunday.setTime(sunday.getTime() - (7 * 86400000));
    }

    // to date
    sunday = new Date(todate.getFullYear(), todate.getMonth(), todate.getDate()-todate.getDay(), 18);
    for (var idx = 0; idx < 90; idx++)
    {
      sundayUSA = eval(sunday.getMonth()+1) + "/" + sunday.getDate() + "/" + sunday.getFullYear();
      document.all.TOWK.options[idx] = new Option(sundayUSA, sundayUSA);
      sunday.setTime(sunday.getTime() - (7 * 86400000));
    }
}
//------------------------------------------------------
// show another selected week
//------------------------------------------------------
function sbmNewWeek()
{
   var url = null;
   var frwkIdx = document.all.FROMWK.selectedIndex;
   var selFrWeek = document.all.FROMWK.options[frwkIdx].value;
   var towkIdx = document.all.TOWK.selectedIndex;
   var selToWeek = document.all.TOWK.options[towkIdx].value;

   url = "StrProd2DatesSum.jsp?FROMWKEND=" + selFrWeek
   + "&TOWKEND=" + selToWeek
   + "&SORT=<%=sSort%>"
   + "&RANK=<%=sRank%>"
   + "&ONLY=<%=sSlsPrsOnly%>";

   for(var i=0; i < SelStr.length; i++){ url += "&Str=" + SelStr[i] }

   //alert(url);
   window.location.href=url;
}

//------------------------------------------------------
// change selected rank or type of store
//------------------------------------------------------
function reSort(sort, rank, slsOnly)
{
   url = "StrProd2DatesSum.jsp?FROMWKEND=<%=sFromWk%>"
   + "&TOWKEND=<%=sToWk%>"
   + "&SORT=" + sort
   + "&RANK=" + rank
   + "&ONLY=" + slsOnly;

   for(var i=0; i < SelStr.length; i++){ url += "&Str=" + SelStr[i] }

   //alert(url);
   window.location.href=url;
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
      <br>Sales Productivity Ranking Report - All Stores
      <br>Weekending date:<%=sFromWk%> - <%=sToWk%>
      <br>Sort By <%if(sSort.equals("REGION")){%>Region<%}
               else if(sSort.equals("MALL")){%>Mall/Non-Mall<%}%>,
               &nbsp;
      Rank by <%if(sRank.equals("SLSHR")){%>Sales per Hours<%}
              else if(sRank.equals("SLSTR")){%>Sales per Transaction<%}
              else if(sRank.equals("ITMTR")){%>Items per Transaction<%}
              else if(sRank.equals("AMT")){%>Sales Amount<%}
              else if(sRank.equals("OVERALL")){%>Overall scores<%}%>
          </b>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
      <font size="-1">Click here to change sorting by <%if(sSort.equals("REGION")){%><a href="javascript: reSort('MALL', '<%=sRank%>', '<%=sSlsPrsOnly%>');">Mall/Non-Mall</a>;<%}
        else if(sSort.equals("MALL")){%><a href="javascript: reSort('REGION', '<%=sRank%>', '<%=sSlsPrsOnly%>');">Regions</a>;<%}%></font>
      &nbsp;&nbsp;&nbsp;&nbsp;
      <font size="-1">Click here to show <%if(sSlsPrsOnly.equals("N")){%><a href="javascript: reSort('<%=sSort%>', '<%=sRank%>', 'Y');">sales personnel only</a>;<%}
        else if(sSlsPrsOnly.equals("Y")){%><a href="javascript: reSort('<%=sSort%>', '<%=sRank%>', 'N'); ">all employees included</a>;<%}%></font>
      &nbsp;&nbsp;&nbsp;&nbsp;<br>
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="StrProdReports.html"><font color="red" size="-1">Store Productivity Reports</font></a>&#62;
      <a href="StrProd2DatesSel.jsp"><font color="red" size="-1">Ranking Selection</font></a>&#62;
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
      <th class="DataTable" rowspan="2">Store</th>
      <th class="DataTable" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="2">Hours<br>Worked</th>
      <th class="DataTable" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="2"># of<br>Trans</th>
      <th class="DataTable" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="2">Sales per<br>Hour</th>
      <th class="DataTable" colspan="2">Rank</th>
      <th class="DataTable" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="2">Sales per<br>Trans</th>
      <th class="DataTable" colspan="2">Rank</th>
      <th class="DataTable" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="2">Item per<br>Trans</th>
      <th class="DataTable" colspan="2">Rank</th>
      <th class="DataTable" rowspan="2">TY vs. LY<br>Item per<br>Trans<br>Var</th>
      <th class="DataTable" rowspan="2"><a href="javascript: reSort('<%=sSort%>', 'ITTRVAR', '<%=sSlsPrsOnly%>');">Rank</a></th>
      <th class="DataTable" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="2">Total<br>Sales</th>
      <th class="DataTable" colspan="2">Rank</th>
      <th class="DataTable" rowspan="2">&nbsp;</th>
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
        <a href="javascript: reSort('<%=sSort%>', 'SLSHR', '<%=sSlsPrsOnly%>');">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="javascript: reSort('<%=sSort%>', 'SLSTR', '<%=sSlsPrsOnly%>');">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="javascript: reSort('<%=sSort%>', 'ITMTR', '<%=sSlsPrsOnly%>');">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="javascript: reSort('<%=sSort%>', 'AMT', '<%=sSlsPrsOnly%>');">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="javascript: reSort('<%=sSort%>', 'OVERALL', '<%=sSlsPrsOnly%>');">TY</a></th>
      <th class="DataTable">LY</th>
    </tr>

<!------------------------------- Detail Data --------------------------------->
   <%for(int i=0; i < iNumOfReg; i++){%>

     <%for(int j=0; j < iNumOfStr[i]; j++){%>

         <tr class="DataTable">
           <td class="DataTable1" nowrap>
                 <a href="StrProd2Dates.jsp?STORE=<%=sStr[i][j].trim()%>&STRNAME=<%=sStrName[i][j]%>&FROMWKEND=<%=sFromWk%>&TOWKEND=<%=sToWk%>&SORT=<%=sSort%>&RANK=<%=sRank%>&ONLY=<%=sSlsPrsOnly%>">
                      <%=sStr[i][j] + " - " + sStrName[i][j]%></a></td>
           <th class="DataTable">&nbsp;</th>

           <td class="TYCell" nowrap><%=sStrTYHour[i][j]%></td>
           <td class="DataTable" nowrap><%=sStrLYHour[i][j]%></td>
           <th class="DataTable">&nbsp;</th>

           <td class="TYCell" nowrap><%=sStrTYTran[i][j]%></td>
           <td class="DataTable" nowrap><%=sStrLYTran[i][j]%></td>
           <th class="DataTable">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sStrTYSlsHr[i][j]%></td>
           <td class="DataTable" nowrap>$<%=sStrLYSlsHr[i][j]%></td>
           <td class="TYCell" nowrap><%=sStrTYRank1[i][j]%></td>
           <td class="DataTable" nowrap><%=sStrLYRank1[i][j]%></td>
           <th class="DataTable">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sStrTYSlsTr[i][j]%></td>
           <td class="DataTable" nowrap>$<%=sStrLYSlsTr[i][j]%></td>
           <td class="TYCell" nowrap><%=sStrTYRank2[i][j]%></td>
           <td class="DataTable" nowrap><%=sStrLYRank2[i][j]%></td>
           <th class="DataTable">&nbsp;</th>

           <td class="TYCell" nowrap><%=sStrTYItmTr[i][j]%></td>
           <td class="DataTable" nowrap><%=sStrLYItmTr[i][j]%></td>
           <td class="TYCell" nowrap><%=sStrTYRank3[i][j]%></td>
           <td class="DataTable" nowrap><%=sStrLYRank3[i][j]%></td>
           <td class="DataTable" nowrap><%=sStrItTrVar[i][j].trim()%>%</td>
           <td class="DataTable" nowrap><%=sStrItTrRank[i][j]%></td>
           <th class="DataTable">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sStrTYAmt[i][j]%></td>
           <td class="DataTable" nowrap>$<%=sStrLYAmt[i][j]%></td>
           <td class="TYCell" nowrap><%=sStrTYRank4[i][j]%></td>
           <td class="DataTable" nowrap><%=sStrLYRank4[i][j]%></td>
           <th class="DataTable">&nbsp;</th>

           <td class="TYCell" nowrap><%=sStrTYRank5[i][j]%></td>
           <td class="DataTable" nowrap><%=sStrLYRank5[i][j]%></td>
        </tr>

   <%}%>
<!----------------------------- Region/Mall Totals ---------------------------->
      <tr class="DataTable1">
         <td class="DataTable1" nowrap>
           <%if(sSort.equals("REGION")){%>Region: <%=sReg[i]%><%}
             else if(sSort.equals("MALL") && sReg[i].trim().equals("0")){%>Mall<%}
             else if(sSort.equals("MALL") && sReg[i].trim().equals("1")){%>Non-Mall<%}%>
         </td>
         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap><%=sRegTYHour[i]%></td>
         <td class="DataTable" nowrap><%=sRegLYHour[i]%></td>
         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap><%=sRegTYTran[i]%></td>
         <td class="DataTable" nowrap><%=sRegLYTran[i]%></td>
         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap>$<%=sRegTYSlsHr[i]%></td>
         <td class="DataTable" nowrap>$<%=sRegLYSlsHr[i]%></td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap>$<%=sRegTYSlsTr[i]%></td>
         <td class="DataTable" nowrap>$<%=sRegLYSlsTr[i]%></td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap><%=sRegTYItmTr[i]%></td>
         <td class="DataTable" nowrap><%=sRegLYItmTr[i]%></td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap><%=sRegItTrVar[i].trim()%>%</td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap>$<%=sRegTYAmt[i]%></td>
         <td class="DataTable" nowrap>$<%=sRegLYAmt[i]%></td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <th class="DataTable">&nbsp;</th>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
      </tr>
   <%}%>
<!------------------------------ Report Total --------------------------------->
<tr class="DataTable2">
         <td class="DataTable1" nowrap>Report Total</td>
         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap><%=sRepTYHour%></td>
         <td class="DataTable" nowrap><%=sRepLYHour%></td>
         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap><%=sRepTYTran%></td>
         <td class="DataTable" nowrap><%=sRepLYTran%></td>
         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap>$<%=sRepTYSlsHr%></td>
         <td class="DataTable" nowrap>$<%=sRepLYSlsHr%></td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap>$<%=sRepTYSlsTr%></td>
         <td class="DataTable" nowrap>$<%=sRepLYSlsTr%></td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap><%=sRepTYItmTr%></td>
         <td class="DataTable" nowrap><%=sRepLYItmTr%></td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap><%=sRepItTrVar.trim()%>%</td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap>$<%=sRepTYAmt%></td>
         <td class="DataTable" nowrap>$<%=sRepLYAmt%></td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap>&nbsp;</td>
         <td class="DataTable" nowrap>&nbsp;</td>
      </tr>
<!-------------------------- end of Report Totals ----------------------------->
 </table>
 <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
