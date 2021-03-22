<%@ page import="strempslsrep.StrProd2DatesExt, java.util.*"%>
<%
   String sStore = request.getParameter("STORE");
   String sStrName = request.getParameter("STRNAME");
   String sFrom = request.getParameter("FROMWKEND");
   String sTo = request.getParameter("TOWKEND");
   String sRank = request.getParameter("RANK");
   String sSort = request.getParameter("SORT");
   String sSlsPrsOnly = request.getParameter("ONLY");
   String sNoDept = request.getParameter("NODEPT");

   if(sRank==null) { sRank="OVERALL"; }
   if(sSlsPrsOnly==null) { sSlsPrsOnly="N"; }
   if(sNoDept == null) { sNoDept = "N"; }

   StrProd2DatesExt rank = new StrProd2DatesExt(sStore, sFrom, sTo, sRank, sSlsPrsOnly, sNoDept);
   int  iNumOfEmp = rank.getNumOfEmp();
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
//==============================================================================
// set Weekly Selection Panel
//==============================================================================
function setSelectPanel()
{
  var html= "<u><b>Select another week</b></u><br><br>"
   + "From: <select name='FROMWK' class='small'></select>&nbsp;&nbsp;"
   + "To: <select name='TOWK' class='small'></select>&nbsp;&nbsp;"
   + "<button id='GO' class='small' onClick='javascript:sbmNewWeek()'>&nbsp;Go&nbsp;</button><br><br>";
  document.all.dvSelect.innerHTML=html;
}

//==============================================================================
// Weeks Stores
//==============================================================================
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

//==============================================================================
// show another selected week
//==============================================================================
function sbmNewWeek()
{
   var SbmString = null;
   var frwkIdx = document.all.FROMWK.selectedIndex;
   var selFrWeek = document.all.FROMWK.options[frwkIdx].value;
   var towkIdx = document.all.TOWK.selectedIndex;
   var selToWeek = document.all.TOWK.options[towkIdx].value;

   SbmString = "StrProd2DatesExt.jsp?STORE=<%=sStore%>" + "&STRNAME=<%=sStrName%>"
             + "&FROMWKEND=" + selFrWeek
             + "&TOWKEND=" + selToWeek
             + "&RANK=<%=sRank%>"
             + "&SORT=<%=sSort%>"
             + "&NODEPT=<%=sNoDept%>";

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
      <br>Weekending dates:<%=sFrom%> - <%=sTo%>
      <br>Rank by <%if(sRank.equals("SLSHR")){%>Sales per Hours<%}
              else if(sRank.equals("SLSTR")){%>Sales per Transaction<%}
              else if(sRank.equals("ITMTR")){%>Items per Transaction<%}
              else if(sRank.equals("AMT")){%>Sales Amount<%}
              else if(sRank.equals("OVERALL")){%>Overall scores<%}%>
          </b>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="StrProd2DatesExtSel.jsp"><font color="red" size="-1">Store Productivity Selection</font></a>&#62;
      <a href="StrProd2DatesSumExt.jsp?&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=<%=sRank%>&SORT=<%=sSort%>&ONLY=<%=sSlsPrsOnly%>"><font color="red" size="-1">All Store Ranking</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp
      <span style="font-family:Arial; font-size:11px">Excludes: Sick, Vacation and Holiday</span>


      <br><font size="-1">Click here to show <%if(sSlsPrsOnly.equals("N")){%><a href="StrProd2DatesExt.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=<%=sRank%>&SORT=<%=sSort%>&ONLY=Y&NODEPT=<%=sNoDept%>">sales personnel only</a>;<%}
        else if(sSlsPrsOnly.equals("Y")){%><a href="StrProd2DatesExt.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=<%=sRank%>&SORT=<%=sSort%>&ONLY=N&NODEPT=<%=sNoDept%>">all employees included</a>;<%}%></font>
      &nbsp;&nbsp;&nbsp;&nbsp;
      <font size="-1">Click here to show <%if(sNoDept.equals("N")){%><a href="StrProd2DatesExt.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=<%=sRank%>&SORT=<%=sSort%>&ONLY=<%=sSlsPrsOnly%>&NODEPT=Y">w/o Department Totals</a>;<%}
        else {%><a href="StrProd2DatesExt.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=<%=sRank%>&SORT=<%=sSort%>&ONLY=<%=sSlsPrsOnly%>&NODEPT=N">with Department Totals</a>;<%}%></font>

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
      <th class="DataTable1" rowspan="2">&nbsp;</th>
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
         <a href="StrProd2DatesExt.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=SLSHR&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>&NODEPT=<%=sNoDept%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProd2DatesExt.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=SLSTR&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>&NODEPT=<%=sNoDept%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProd2DatesExt.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=ITMTR&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>&NODEPT=<%=sNoDept%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProd2DatesExt.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=AMT&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>&NODEPT=<%=sNoDept%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProd2DatesExt.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=OVERALL&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>&NODEPT=<%=sNoDept%>">TY</a></th>
      <th class="DataTable">LY</th>

      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProd2DatesExt.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=MULTCNT&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>&NODEPT=<%=sNoDept%>">TY</a></th>
      <th class="DataTable">LY</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">
        <a href="StrProd2DatesExt.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&RANK=MULTAMT&ONLY=<%=sSlsPrsOnly%>&SORT=<%=sSort%>&NODEPT=<%=sNoDept%>">TY</a></th>
      <th class="DataTable">LY</th>
    </tr>

<!------------------------------- Detail Data --------------------------------->
     <%for(int i=0; i < iNumOfEmp; i++)
     {
       rank.setEmpRank();
       String sEmp = rank.getEmp();
       String sName = rank.getName();
       String sTotal = rank.getTotal();
       String sStr = rank.getStr();
       String sDpt = rank.getDpt();

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
     %>
         <tr class="DataTable<%=sTotal%>">
           <%if(sTotal.equals("")){%>
              <td class="DataTable1" nowrap> <%=sEmp%></td>
              <td class="DataTable1" nowrap>
                  <a href="StrProd2DatesWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&EMP=<%=sEmp%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&ONLY=<%=sSlsPrsOnly%>&RANK=<%=sRank%>&TyRank1=<%=sTyRank1%>&LyRank1=<%=sLyRank1%>&TyRank2=<%=sTyRank2%>&LyRank2=<%=sLyRank2%>&TyRank3=<%=sTyRank3%>&LyRank3=<%=sLyRank3%>&TyRank4=<%=sTyRank4%>&LyRank4=<%=sLyRank4%>&TyRank5=<%=sTyRank5%>&LyRank5=<%=sLyRank5%>&SORT=<%=sSort%>">
                    <%=sName%></a></td>
           <%}
             else{%>
               <td class="DataTable1" nowrap colspan=2>
                  <a href="StrProd2DatesWk.jsp?STORE=<%=sStore%>&STRNAME=<%=sStrName%>&EMP=<%=sEmp%>&FROMWKEND=<%=sFrom%>&TOWKEND=<%=sTo%>&ONLY=<%=sSlsPrsOnly%>&RANK=<%=sRank%>&TyRank1=<%=sTyRank1%>&LyRank1=<%=sLyRank1%>&TyRank2=<%=sTyRank2%>&LyRank2=<%=sLyRank2%>&TyRank3=<%=sTyRank3%>&LyRank3=<%=sLyRank3%>&TyRank4=<%=sTyRank4%>&LyRank4=<%=sLyRank4%>&TyRank5=<%=sTyRank5%>&LyRank5=<%=sLyRank5%>&SORT=<%=sSort%>">
                      <%if(sTotal.equals("1")){%><%=sDpt%> - <%}%><%=sName%></a></td>
           <%}%>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap><%=sTyHrs%></td>
           <td class="DataTable" nowrap><%=sLyHrs%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap><%=sTyTran%></td>
           <td class="DataTable" nowrap><%=sLyTran%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sTySlsHr%></td>
           <td class="DataTable" nowrap>$<%=sLySlsHr%></td>
           <td class="TYCell" nowrap><%=sTyRank1%></td>
           <td class="DataTable" nowrap><%=sLyRank1%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sTySlsTr%></td>
           <td class="DataTable" nowrap>$<%=sLySlsTr%></td>
           <td class="TYCell" nowrap><%=sTyRank2%></td>
           <td class="DataTable" nowrap><%=sLyRank2%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap><%=sTyItmTr%></td>
           <td class="DataTable" nowrap><%=sLyItmTr%></td>
           <td class="TYCell" nowrap><%=sTyRank3%></td>
           <td class="DataTable" nowrap><%=sLyRank3%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sTyAmt%></td>
           <td class="DataTable" nowrap>$<%=sLyAmt%></td>
           <td class="TYCell" nowrap><%=sTyRank4%></td>
           <td class="DataTable" nowrap><%=sLyRank4%></td>

           <th class="DataTable1">&nbsp;</th>
           <td class="TYCell" nowrap><%=sTyRank5%></td>
           <td class="DataTable" nowrap><%=sLyRank5%></td>

           <th class="DataTable1">&nbsp;</th>
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
<!-------------------------- end of Report Totals ----------------------------->
 </table>
 <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%rank.disconnect();%>