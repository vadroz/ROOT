<%@ page import="payrollreports.IncPlanBikeMgr, java.util.*, java.text.SimpleDateFormat"%>
<%
   String sQtr = request.getParameter("Qtr");

   if(sQtr==null) sQtr = "0";

   IncPlanBikeMgr incp = new IncPlanBikeMgr(sQtr);

   String [] sMonName = incp.getMonName();
   int  iNumOfReg = incp.getNumOfReg();
   String [] sTotReg = incp.getTotReg();
   int [] iRegStrCnt = incp.getRegStrCnt();

   int  iNumOfStr = incp.getNumOfStr();
   String [] sStr = incp.getStr();
   String [] sStrName = incp.getStrName();
   String [][] sTyMonSls = incp.getTyMonSls();
   String [][] sLyMonSls = incp.getLyMonSls();
   String [][] sLyMonPlan = incp.getLyMonPlan();
   String [][] sTyLyVar = incp.getTyLyVar();
   String [] sTyPlanVar = incp.getTyPlanVar();
   String [] sBonus = incp.getBonus();

   String [][] sTotTyMonSls = incp.getTotTyMonSls();
   String [][] sTotLyMonSls = incp.getTotLyMonSls();
   String [][] sTotLyMonPlan = incp.getTotLyMonPlan();
   String [][] sTotTyLyVar = incp.getTotTyLyVar();
   String [] sTotTyPlanVar = incp.getTotTyPlanVar();
   String [] sTotBonus = incp.getTotBonus();

   incp.disconnect();
   incp = null;
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
  th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

  tr.DataTable { background:#e7e7e7; font-family:Arial; font-size:10px }
  tr.DataTable1 { background:cornsilk; font-family:Arial; font-size:10px }
  tr.DataTable2 { background:seashell; font-family:Arial; font-size:10px }
  tr.Divider { font-size:3px }

  td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:right;}
  td.DataTable1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:left;}
  td.DataTable2{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:center;}

  td.DataTable21{ background:seashell;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center;}

  td.DataTable1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:left;}

  table.Help { background:white;text-align:center; font-size:12px;}

  div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt {border-bottom: black solid 2px; border-right: black solid 1px; text-align:center;
                   font-family:Arial; font-size:10px; }
</style>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//---------------------------------------------
// initialize value on load
//---------------------------------------------
function  bodyload()
{
}
//---------------------------------------------
// show selected quarter
//---------------------------------------------
function showSelQtr(qtr)
{
  var qtrNum = qtr.options[qtr.selectedIndex].value
  var url = "IncPlanBikeMgr.jsp?Qtr=" + qtrNum;
  window.location.href=url;
}


</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

</head>
<body onload="bodyload()">
<!-------------------------------------------------------------------->
  <div id="Prompt" class="Prompt"></div>
<!-------------------------------------------------------------------->

 <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
   <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Bike Manager Incentive Plan Bulletin Board
          </b>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp

      Select Quarter:
      <select onchange="showSelQtr(this)">
        <option value="0" <%if(sQtr.equals("0")){%>selected<%}%>>This quarter</option>
        <option value="1" <%if(sQtr.equals("1")){%>selected<%}%>>Previous quarter</option>
        <option value="2" <%if(sQtr.equals("2")){%>selected<%}%>>-2 quarters</option>
        <option value="3" <%if(sQtr.equals("3")){%>selected<%}%>>-3 quarters</option>
        <option value="4" <%if(sQtr.equals("4")){%>selected<%}%>>-4 quarters</option>
        <option value="5" <%if(sQtr.equals("5")){%>selected<%}%>>-5 quarters</option>
      </select>&nbsp;&nbsp;
      </td>
   </tr>

   <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">

  <!----------------- beginning of table ------------------------>
  <table class="DataTable" cellPadding="0" cellSpacing="0">
    <tr>
      <th class="DataTable" rowspan="2">Reg</th>
      <th class="DataTable" rowspan="2">Store</th>
      <th class="DataTable" rowspan="2" >&nbsp;</th>
      <%for(int i=0; i < 3; i++){%>
         <th class="DataTable" colspan="3" ><%=sMonName[i]%></th>
         <th class="DataTable" rowspan="2" >&nbsp;</th>
      <%}%>
      <th class="DataTable" colspan="3" >Q-T-D</th>
      <th class="DataTable" rowspan="2" >&nbsp;</th>
      <th class="DataTable" colspan="3" >% Var to LY + 5%</th>
      <th class="DataTable" rowspan="2" >&nbsp;</th>
      <th class="DataTable" rowspan="2">Sales<br> Commission<br>Bonus</th>
    </tr>

    <!-- Header line 2 -->
    <tr>
      <%for(int i=0; i < 5; i++){%>
         <th class="DataTable">TY</th>
         <th class="DataTable">LY</th>
         <th class="DataTable">Var</th>
      <%}%>
    </tr>
<!------------------------------- Detail Data --------------------------------->
    <%
      int iReg = 0;
      for(int i=0, iRegCnt = 0 ; i < iNumOfStr; i++){%>
      <tr class="DataTable">
         <%if(iRegCnt == 0){%>
            <td class="DataTable21" rowspan="<%=iRegStrCnt[iReg]%>"><%=sTotReg[iReg]%></td>
         <%}%>

         <td class="DataTable1" nowrap><%=sStr[i] + "-" + sStrName[i]%></td>
         <th class="DataTable">&nbsp;</th>

         <%for(int j=0; j < 4; j++){%>
            <td class="DataTable">$<%=sTyMonSls[i][j]%></td>
            <td class="DataTable">$<%=sLyMonSls[i][j]%></td>
            <td class="DataTable" nowrap><%=sTyLyVar[i][j]%>%</td>
            <th class="DataTable">&nbsp;</th>
         <%}%>
         <td class="DataTable">$<%=sTyMonSls[i][3]%></td>
         <td class="DataTable">$<%=sLyMonPlan[i][3]%></td>
         <td class="DataTable" nowrap><%=sTyPlanVar[i]%></td>
         <th class="DataTable">&nbsp;</th>
         <td class="DataTable">$<%=sBonus[i]%></td>
      </tr>

      <!-- ===================== Region totals ============================= -->
      <%
         iRegCnt++;
         if(iRegCnt == iRegStrCnt[iReg]){
      %>
          <!-- tr class="DataTable1">
            <td class="DataTable1" colspan="2">Region <%/*=sTotReg[iReg]*/%> Total</td>
            <th class="DataTable">&nbsp;</th>

            <%//for(int j=0; j < 4; j++){
            %>
              <td class="DataTable">$<%/*=sTotTyMonSls[iReg][j]*/%></td>
              <td class="DataTable">$<%/*=sTotLyMonSls[iReg][j]*/%></td>
              <td class="DataTable" nowrap><%/*=sTotTyLyVar[iReg][j]*/%>%</td>
              <th class="DataTable">&nbsp;</th>
            <%/*}*/%>
            <td class="DataTable">$<%/*=sTotTyMonSls[iReg][3]*/%></td>
            <td class="DataTable">$<%/*=sTotLyMonPlan[iReg][3]*/%></td>
            <td class="DataTable" nowrap><%/*=sTotTyPlanVar[iReg]*/%>%</td>
            <th class="DataTable">&nbsp;</th>
            <td class="DataTable">&nbsp;</td>
          </tr>

          <tr class="Divider"><td colspan=24>&nbsp;</td></tr -->
      <%  iRegCnt = 0; iReg++; /* reset count for next region*/
        }
      %>

    <%}%>
<!-------------------------------- Report Totals --------------------------------->
    <tr class="DataTable2">
       <td class="DataTable1" colspan="2">Bike Store Total</td>
       <th class="DataTable">&nbsp;</th>
       <%for(int j=0; j < 4; j++){%>
          <td class="DataTable">$<%=sTotTyMonSls[iReg][j]%></td>
          <td class="DataTable">$<%=sTotLyMonSls[iReg][j]%></td>
          <td class="DataTable" nowrap><%=sTotTyLyVar[iReg][j]%>%</td>
          <th class="DataTable">&nbsp;</th>
       <%}%>
       <td class="DataTable">$<%=sTotTyMonSls[iReg][3]%></td>
       <td class="DataTable">$<%=sTotLyMonPlan[iReg][3]%></td>
       <td class="DataTable" nowrap><%=sTotTyPlanVar[iReg]%></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable"><%=sTotBonus[iReg]%></td>
    </tr>

<!---------------------------- end of Report Totals ------------------------------>
 </table>
 <p>
 <table class="Help" border=1 cellPadding="3" cellSpacing="0">
    <tr><th colspan=2><u>Sales Commission Bonus</u></th></tr>
    <tr>
       <th>% Compare vs. LY</th>
       <th>Bonus %<br></th>
    </tr>
    <tr>
       <td>Less than 104.99%</td>
       <td>-</td>
    </tr>
    <tr>
       <td>105% - 114.99%</td>
       <td>1.0%</td>
    </tr>
    <tr>
       <td>115% +</td>
       <td>2.0%</td>
    </tr>
    <tr>
      <td colspan=2 align="left">
        Example: If a store reaches sales of 116% of LY, the Bike Manager would receive a Sales commission bonus equal to 2.0% of the<br>
        excess sales above LY sales plus 5%.
      </td>
    </tr>
    <tr>
      <td colspan=2 style="text-align:left; color: red">
        Note: RCI may adjust figures based on shift in the promotional calendar, new
        sale events or other circumstances.
      </td>
    </tr>
     <tr>
      <td colspan=2 style="text-align:left; color: red">
        Note: The Minimum bonus amount is $50.00, if a bike manager qualified for a bonus less than
        $50.00, he/she will receive $50.00
      </td>
    </tr>
 </table>

 <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
