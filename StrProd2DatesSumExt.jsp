<%@ page import="strempslsrep.StrProd2DatesSumExt, java.util.*"%>
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

   //for(int i=0; i < sSelStr.length; i++){ System.out.print(" " + sSelStr[i]);}

   StrProd2DatesSumExt rank = new StrProd2DatesSumExt(sSelStr, sFromWk, sToWk, sSort, sRank, sSlsPrsOnly);

   int  iNumOfStr = rank.getNumOfStr();


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

   url = "StrProd2DatesSumExt.jsp?FROMWKEND=" + selFrWeek
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
   url = "StrProd2DatesSumExt.jsp?FROMWKEND=<%=sFromWk%>"
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
      <a href="StrProd2DatesExtSel.jsp"><font color="red" size="-1">Ranking Selection</font></a>&#62;
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
      <th class="DataTable" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="2">Mult<br>Tran #</th>
      <th class="DataTable" colspan="2">Rank</th>
      <th class="DataTable" colspan="2">Mult<br>Tran $</th>
      <th class="DataTable" colspan="2">Rank</th>
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

      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="javascript: reSort('<%=sSort%>', 'MULTCNT', '<%=sSlsPrsOnly%>')">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="javascript: reSort('<%=sSort%>', 'MULTAMT', '<%=sSlsPrsOnly%>')">TY</a></th>
      <th class="DataTable">LY</th>
    </tr>

<!------------------------------- Detail Data --------------------------------->
     <%for(int j=0; j < iNumOfStr; j++)
     {
       rank.setStrRank();
       String sStr = rank.getStr();
       String sName = rank.getName();
       String sTotal = rank.getTotal();
       String sReg = rank.getReg();

       String sTyAmt = rank.getTyAmt();
       String sTyHrs = rank.getTyHrs();
       String sTyTran = rank.getTyTran();
       String sTyItem = rank.getTyItem();
       String sTySlsHr = rank.getTySlsHr();
       String sTySlsTr = rank.getTySlsTr();
       String sTyItmTr = rank.getTyItmTr();
       String sTySngCntPrc = rank.getTySngCntPrc();
       String sTyMltCntPrc = rank.getTyMltCntPrc();
       String sTySngAmtPrc = rank.getTySngCntPrc();
       String sTyMltAmtPrc = rank.getTyMltCntPrc();
       String sTyRank1 = rank.getTyRank1();
       String sTyRank2 = rank.getTyRank2();
       String sTyRank3 = rank.getTyRank3();
       String sTyRank4 = rank.getTyRank4();
       String sTyRank5 = rank.getTyRank5();
       String sTyRank6 = rank.getTyRank6();
       String sTyRank7 = rank.getTyRank7();

       String sLyAmt = rank.getLyAmt();
       String sLyHrs = rank.getLyHrs();
       String sLyTran = rank.getLyTran();
       String sLyItem = rank.getLyItem();
       String sLySlsHr = rank.getLySlsHr();
       String sLySlsTr = rank.getLySlsTr();
       String sLyItmTr = rank.getLyItmTr();
       String sLySngCntPrc = rank.getLySngCntPrc();
       String sLyMltCntPrc = rank.getLyMltCntPrc();
       String sLySngAmtPrc = rank.getLySngCntPrc();
       String sLyMltAmtPrc = rank.getLyMltCntPrc();
       String sLyRank1 = rank.getLyRank1();
       String sLyRank2 = rank.getLyRank2();
       String sLyRank3 = rank.getLyRank3();
       String sLyRank4 = rank.getLyRank4();
       String sLyRank5 = rank.getLyRank5();
       String sLyRank6 = rank.getLyRank6();
       String sLyRank7 = rank.getLyRank7();

       String sItmTrVar = rank.getItmTrVar();
       String sRank8 = rank.getRank8();
     %>

         <tr class="DataTable<%=sTotal%>">
           <td class="DataTable1" nowrap>
              <%if(sTotal.equals("")){%>
                 <a href="StrProd2DatesExt.jsp?STORE=<%=sStr.trim()%>&STRNAME=<%=sName%>&FROMWKEND=<%=sFromWk%>&TOWKEND=<%=sToWk%>&SORT=<%=sSort%>&RANK=<%=sRank%>&ONLY=<%=sSlsPrsOnly%>">
                 <%=sStr%> - <%=sName%></a>
              <%}
                else {%><%=sName%><%}%>
            </td>
           <th class="DataTable">&nbsp;</th>

           <td class="TYCell" nowrap><%=sTyHrs%></td>
           <td class="DataTable" nowrap><%=sLyHrs%></td>
           <th class="DataTable">&nbsp;</th>

           <td class="TYCell" nowrap><%=sTyTran%></td>
           <td class="DataTable" nowrap><%=sLyTran%></td>
           <th class="DataTable">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sTySlsHr%></td>
           <td class="DataTable" nowrap>$<%=sLySlsHr%></td>
           <td class="TYCell" nowrap><%=sTyRank1%></td>
           <td class="DataTable" nowrap><%=sLyRank1%></td>
           <th class="DataTable">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sTySlsTr%></td>
           <td class="DataTable" nowrap>$<%=sLySlsTr%></td>
           <td class="TYCell" nowrap><%=sTyRank2%></td>
           <td class="DataTable" nowrap><%=sLyRank2%></td>
           <th class="DataTable">&nbsp;</th>

           <td class="TYCell" nowrap><%=sTyItmTr%></td>
           <td class="DataTable" nowrap><%=sLyItmTr%></td>
           <td class="TYCell" nowrap><%=sTyRank3%></td>
           <td class="DataTable" nowrap><%=sLyRank3%></td>
           <td class="DataTable" nowrap><%=sItmTrVar%>%</td>
           <td class="DataTable" nowrap><%=sRank8%></td>
           <th class="DataTable">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sTyAmt%></td>
           <td class="DataTable" nowrap>$<%=sLyAmt%></td>
           <td class="TYCell" nowrap><%=sTyRank4%></td>
           <td class="DataTable" nowrap><%=sLyRank4%></td>
           <th class="DataTable">&nbsp;</th>

           <td class="TYCell" nowrap><%=sTyRank5%></td>
           <td class="DataTable" nowrap><%=sLyRank5%></td>

           <th class="DataTable">&nbsp;</th>
           <td class="TYCell" nowrap><%=sTyMltCntPrc%>%</td>
           <td class="DataTable" nowrap><%=sLyMltCntPrc%>%</td>
           <td class="TYCell" nowrap><%=sTyRank6%></td>
           <td class="DataTable" nowrap><%=sLyRank6%></td>

           <td class="TYCell" nowrap><%=sTyMltAmtPrc%>%</td>
           <td class="DataTable" nowrap><%=sLyMltAmtPrc%>%</td>
           <td class="TYCell" nowrap><%=sTyRank7%></td>
           <td class="DataTable" nowrap><%=sLyRank7%></td>
        </tr>
   <%}%>
 </table>
 <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%rank.disconnect();%>