<%@ page import="strempslsrep.StrProdDeptWk, java.util.*"%>
<%
   String sStore = request.getParameter("STORE");
   String sDepartment = request.getParameter("DPT");
   String sStrName = request.getParameter("STRNAME");
   String sFrom = request.getParameter("FROMWKEND");
   String sTo = request.getParameter("TOWKEND");
   String sRank = request.getParameter("RANK");
   String sSort = request.getParameter("SORT");
   String sSlsPrsOnly = request.getParameter("ONLY");

   if(sRank==null) sRank="WEEK";
   if(sSlsPrsOnly==null) sSlsPrsOnly="N";

   StrProdDeptWk rank = new StrProdDeptWk(sStore, sDepartment, sFrom, sTo, sRank, sSlsPrsOnly);
    int iNumOfDpt = rank.getNumOfDpt();

    String [] sDpt = rank.getDpt();
    String [] sDptName = rank.getDptName();

    String [] sDptTYHour = rank.getDptTYHour();
    String [] sDptTYTran = rank.getDptTYTran();
    String [] sDptTYSlsHr = rank.getDptTYSlsHr();
    String [] sDptTYRank1 = rank.getDptTYRank1();
    String [] sDptTYSlsTr = rank.getDptTYSlsTr();
    String [] sDptTYRank2 = rank.getDptTYRank2();
    String [] sDptTYItmTr = rank.getDptTYItmTr();
    String [] sDptTYRank3 = rank.getDptTYRank3();
    String [] sDptTYAmt = rank.getDptTYAmt();
    String [] sDptTYRank4 = rank.getDptTYRank4();
    String [] sDptTYRank5 = rank.getDptTYRank5();

    String [] sDptLYHour = rank.getDptLYHour();
    String [] sDptLYTran = rank.getDptLYTran();
    String [] sDptLYSlsHr = rank.getDptLYSlsHr();
    String [] sDptLYRank1 = rank.getDptLYRank1();
    String [] sDptLYSlsTr = rank.getDptLYSlsTr();
    String [] sDptLYRank2 = rank.getDptLYRank2();
    String [] sDptLYItmTr = rank.getDptLYItmTr();
    String [] sDptLYRank3 = rank.getDptLYRank3();
    String [] sDptLYAmt = rank.getDptLYAmt();
    String [] sDptLYRank4 = rank.getDptLYRank4();
    String [] sDptLYRank5 = rank.getDptLYRank5();
    String [] sWeek = rank.getWeek();

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

   SbmString = "StrProdDeptWk.jsp?STORE=<%=sStore%>" + "&STRNAME=<%=sStrName%>"
             + "&DPT=<%=sDepartment%>"
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
      <br>Department: <font color="red"><%=sDpt[0]%> - <%=sDptName[0]%></font>
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
      <th class="DataTable" rowspan="2"><a href="StrProdDeptWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&DPT=<%=sDepartment%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=WEEK&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>">
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
         <a href="StrProdDeptWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&DPT=<%=sDepartment%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=SLSHR&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProdDeptWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&DPT=<%=sDepartment%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=SLSTR&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProdDeptWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&DPT=<%=sDepartment%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=ITMTR&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProdDeptWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&DPT=<%=sDepartment%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=AMT&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProdDeptWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&DPT=<%=sDepartment%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=OVERALL&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>">TY</a></th>
      <th class="DataTable">LY</th>
    </tr>

<!------------------------------- Detail Data --------------------------------->
   <%for(int i=0; i < iNumOfDpt; i++){%>

         <tr class="DataTable">
           <td class="DataTable1" nowrap><%=sWeek[i]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap><%=sDptTYHour[i]%></td>
           <td class="DataTable" nowrap><%=sDptLYHour[i]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap><%=sDptTYTran[i]%></td>
           <td class="DataTable" nowrap><%=sDptLYTran[i]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sDptTYSlsHr[i]%></td>
           <td class="DataTable" nowrap>$<%=sDptLYSlsHr[i]%></td>
           <td class="TYCell" nowrap><%=sDptTYRank1[i]%></td>
           <td class="DataTable" nowrap><%=sDptLYRank1[i]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sDptTYSlsTr[i]%></td>
           <td class="DataTable" nowrap>$<%=sDptLYSlsTr[i]%></td>
           <td class="TYCell" nowrap><%=sDptTYRank2[i]%></td>
           <td class="DataTable" nowrap><%=sDptLYRank2[i]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap><%=sDptTYItmTr[i]%></td>
           <td class="DataTable" nowrap><%=sDptLYItmTr[i]%></td>
           <td class="TYCell" nowrap><%=sDptTYRank3[i]%></td>
           <td class="DataTable" nowrap><%=sDptLYRank3[i]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sDptTYAmt[i]%></td>
           <td class="DataTable" nowrap>$<%=sDptLYAmt[i]%></td>
           <td class="TYCell" nowrap><%=sDptTYRank4[i]%></td>
           <td class="DataTable" nowrap><%=sDptLYRank4[i]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap><%=sDptTYRank5[i]%></td>
           <td class="DataTable" nowrap><%=sDptLYRank5[i]%></td>
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
