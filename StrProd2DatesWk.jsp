<%@ page import="strempslsrep.StrProd2DatesWk, java.util.*"%>
<%
   String sStore = request.getParameter("STORE");
   String sEmployee = request.getParameter("EMP");
   String sStrName = request.getParameter("STRNAME");
   String sFrom = request.getParameter("FROMWKEND");
   String sTo = request.getParameter("TOWKEND");
   String sRank = request.getParameter("RANK");
   String sSort = request.getParameter("SORT");
   String sSlsPrsOnly = request.getParameter("ONLY");

   String sTyRank1 = request.getParameter("TyRank1");
   String sLyRank1 = request.getParameter("LyRank1");
   String sTyRank2 = request.getParameter("TyRank2");
   String sLyRank2 = request.getParameter("LyRank2");
   String sTyRank3 = request.getParameter("TyRank3");
   String sLyRank3 = request.getParameter("LyRank3");
   String sTyRank4 = request.getParameter("TyRank4");
   String sLyRank4 = request.getParameter("LyRank4");
   String sTyRank5 = request.getParameter("TyRank5");
   String sLyRank5 = request.getParameter("LyRank5");

   if(sRank==null) sRank="WEEK";
   if(sSlsPrsOnly==null) sSlsPrsOnly="N";

   StrProd2DatesWk rank = new StrProd2DatesWk(sStore, sEmployee, sFrom, sTo, sRank, sSlsPrsOnly);

    int iNumOfEmp = rank.getNumOfEmp();

    String [] sEmp = rank.getEmp();
    String [] sEmpName = rank.getEmpName();
    String [] sWeek = rank.getWeek();

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

    if(iNumOfEmp == 1)
    {
       sEmpTYRank1[0] = sTyRank1;
       sEmpLYRank1[0] = sLyRank1;
       sEmpTYRank2[0] = sTyRank2;
       sEmpLYRank2[0] = sLyRank2;
       sEmpTYRank3[0] = sTyRank3;
       sEmpLYRank3[0] = sLyRank3;
       sEmpTYRank4[0] = sTyRank4;
       sEmpLYRank4[0] = sLyRank4;
       sEmpTYRank5[0] = sTyRank5;
       sEmpLYRank5[0] = sLyRank5;
    }
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
   + "From: <select name='FROMWK' class='small'></select>&nbsp;&nbsp;"
   + "To: <select name='TOWK' class='small'></select>&nbsp;&nbsp;"
   + "<button id='GO' class='small' onClick='javascript:sbmNewWeek()'>&nbsp;Go&nbsp;</button><br><br>";
  document.all.dvSelect.innerHTML=html;
}

//------------------------------------------------------
// Weeks Stores
//------------------------------------------------------
function doWeekSelect()
{
    var idx = 0;
    var todate = new Date();
    var sunday = new Date(todate.getFullYear(), todate.getMonth(), todate.getDate()-todate.getDay(), 18);

    // from date
    for (var idx = 0; idx < 20; idx++)
    {
      sundayUSA = eval(sunday.getMonth()+1) + "/" + sunday.getDate() + "/" + sunday.getFullYear();
      document.all.FROMWK.options[idx] = new Option(sundayUSA, sundayUSA);
      sunday.setTime(sunday.getTime() - (7 * 86400000));
    }

    // to date
    sunday = new Date(todate.getFullYear(), todate.getMonth(), todate.getDate()-todate.getDay(), 18);
    for (var idx = 0; idx < 20; idx++)
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
   var SbmString = null;
   var frwkIdx = document.all.FROMWK.selectedIndex;
   var selFrWeek = document.all.FROMWK.options[frwkIdx].value;
   var towkIdx = document.all.TOWK.selectedIndex;
   var selToWeek = document.all.TOWK.options[towkIdx].value;

   SbmString = "StrProd2DatesWk.jsp?STORE=<%=sStore%>" + "&STRNAME=<%=sStrName%>"
             + "&EMP=<%=sEmployee%>"
             + "&FROMWKEND=" + selFrWeek
             + "&TOWKEND=" + selToWeek
             + "&RANK=<%=sRank%>"
             + "&SORT=<%=sSort%>";

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
      <br>Store: <%=sStore + " - " + sStrName%>
      <br>Employee: <font color="red"><%=sEmp[0]%> - <%=sEmpName[0]%></font>
      <br>Weekending dates: <font color="green"><%=sFrom%> - <%=sTo%></font>
      <br>Rank by <%if(sRank.equals("SLSHR")){%>Sales per Hours<%}
              else if(sRank.equals("SLSTR")){%>Sales per Transaction<%}
              else if(sRank.equals("ITMTR")){%>Items per Transaction<%}
              else if(sRank.equals("AMT")){%>Sales Amount<%}
              else if(sRank.equals("OVERALL")){%>Overall scores<%}
              else if(sRank.equals("WEEK")){%>Weeks<%}%>
          </b>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="StrProdReports.html"><font color="red" size="-1">Store Productivity Reports</font></a>&#62;
      <a href="StrProd2DatesWkSel.jsp"><font color="red" size="-1">Ranking Selection</font></a>&#62;
      <a href="StrProd2DatesWkSum.jsp?&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=<%=sRank%>&SORT=<%=sSort%>&ONLY=<%=sSlsPrsOnly%>"><font color="red" size="-1">All Store Ranking</font></a>&#62;
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
      <th class="DataTable" rowspan="2"><a href="StrProd2DatesWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&EMP=<%=sEmployee%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=WEEK&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>">
         Week</a></th></th>
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
         <a href="StrProd2DatesWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&EMP=<%=sEmployee%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=SLSHR&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProd2DatesWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&EMP=<%=sEmployee%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=SLSTR&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProd2DatesWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&EMP=<%=sEmployee%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=ITMTR&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProd2DatesWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&EMP=<%=sEmployee%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=AMT&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProd2DatesWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&EMP=<%=sEmployee%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=OVERALL&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>">TY</a></th>
      <th class="DataTable">LY</th>
    </tr>

<!------------------------------- Detail Data --------------------------------->
   <%for(int i=0; i < iNumOfEmp; i++){%>

         <tr class="DataTable">
           <td class="DataTable1" nowrap><%=sWeek[i]%></td>
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
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap><%=sEmpTYRank5[i]%></td>
           <td class="DataTable" nowrap><%=sEmpLYRank5[i]%></td>
        </tr>
   <%}%>
<!------------------------------- Store Total --------------------------------->
<tr class="DataTable2">
         <td class="DataTable1" nowrap>Total</td>
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
