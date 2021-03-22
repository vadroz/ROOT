<%@ page import="strempslsrep.ItsaContest, java.util.*"%>
<%
   String sTopSlr = "50";
   String sRank = "ITSA";
   String sSlsPrsOnly = "Y";

   ItsaContest rank = new ItsaContest(sTopSlr, sRank, sSlsPrsOnly);

   int iNumOfEmp = rank.getNumOfEmp();

    String [] sEmp = rank.getEmp();
    String [] sEmpName = rank.getEmpName();
    String [] sEmpStr = rank.getEmpStr();

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

    String [] sEmpTYPoint = rank.getEmpTYPoint();
    String [] sEmpTYItsa = rank.getEmpTYItsa();
    String [] sEmpLYPoint = rank.getEmpLYPoint();
    String [] sEmpLYItsa = rank.getEmpLYItsa();

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

  td.TYCell2 { background:yellow; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:right; font-size:11px; font-weight:bold}


  div.dvSelect { position:absolute; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon; z-index:10;
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
    var todate = new Date();
    sunday = new Date(todate.getFullYear(), todate.getMonth(), todate.getDate()-todate.getDay());
    var sundayUSA = eval(sunday.getMonth()+1) + "/" + sunday.getDate() + "/" + sunday.getFullYear();
    document.all.spnToDate.innerHTML = sundayUSA;
}

</SCRIPT>


</head>
<body onload="bodyload()">
<!-------------------------------------------------------------------->
    <!-- div id="dvSelect" class="dvSelect"></div -->
<!-------------------------------------------------------------------->
 <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
   <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>ITSA Contest
      <br>From: 1/16/2006 -  To: <span id="spnToDate"></span>
      </b>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;

      <span style="font-family:Arial; font-size:11px">Includes: Sales persons only</span>

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
      <th class="DataTable" rowspan="2">Str<br>#</th>
      <th class="DataTable1" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="2"> ITSA</th>
      <th class="DataTable1" rowspan="2">&nbsp;</th>
      <th class="DataTable" colspan="17">Sales data for last weekending date</th>
    </tr>
    <tr>
      <th class="DataTable">Points</th>
      <th class="DataTable">Rank</th>
      <th class="DataTable" >Overall<br>Rank</th>
      <th class="DataTable1">&nbsp;</th>
      <th class="DataTable" >Hours<br>Worked</th>
      <th class="DataTable1">&nbsp;</th>
      <th class="DataTable" ># of<br>Trans</th>
      <th class="DataTable1">&nbsp;</th>
      <th class="DataTable" >Sales per<br>Hour</th>
      <th class="DataTable" >Rank</th>
      <th class="DataTable1">&nbsp;</th>
      <th class="DataTable" >Sales per<br>Trans</th>
      <th class="DataTable" >Rank</th>
      <th class="DataTable1">&nbsp;</th>
      <th class="DataTable" >Item per<br>Trans</th>
      <th class="DataTable" >Rank</th>
      <th class="DataTable1">&nbsp;</th>
      <th class="DataTable" >Total<br>Sales</th>
      <th class="DataTable" >Rank</th>
    </tr>

<!------------------------------- Detail Data --------------------------------->
   <%for(int i=0; i < iNumOfEmp; i++){%>


         <tr class="DataTable">
           <td class="DataTable1" nowrap><%=sEmp[i]%></td>
           <td class="DataTable1" nowrap><%=sEmpName[i]%></td>
           <td class="DataTable1" nowrap><%=sEmpStr[i]%></td>

           <th class="DataTable1">&nbsp;</th>
           <td class="TYCell2" nowrap><%=sEmpTYPoint[i]%></td>
           <td class="TYCell" nowrap><%=sEmpTYItsa[i]%></td>
           <th class="DataTable1">&nbsp;</th>
           <td class="TYCell" nowrap><%=sEmpTYRank5[i]%></td>

           <th class="DataTable1">&nbsp;</th>
           <td class="TYCell" nowrap><%=sEmpTYHour[i]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap><%=sEmpTYTran[i]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sEmpTYSlsHr[i]%></td>
           <td class="TYCell" nowrap><%=sEmpTYRank1[i]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sEmpTYSlsTr[i]%></td>
           <td class="TYCell" nowrap><%=sEmpTYRank2[i]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap><%=sEmpTYItmTr[i]%></td>
           <td class="TYCell" nowrap><%=sEmpTYRank3[i]%></td>
           <th class="DataTable1">&nbsp;</th>

           <td class="TYCell" nowrap>$<%=sEmpTYAmt[i]%></td>
           <td class="TYCell" nowrap><%=sEmpTYRank4[i]%></td>
        </tr>
   <%}%>
<!-------------------------- end of Report Totals ----------------------------->
 </table>
 <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
