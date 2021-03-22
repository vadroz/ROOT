<%@ page import="slscontests.ChristmasContest, java.util.*, java.text.*"%>
<%
   String sSort = request.getParameter("Sort");

   if(sSort==null) sSort="STR";
   ChristmasContest contest = new ChristmasContest(sSort);
   int iNumOfStr = contest.getNumOfStr();
   int [] iGrp = contest.getGrp();
   String [] sStr = contest.getStr();
   String [] sQty = contest.getQty();
   String [] sPlan = contest.getPlan();
   String [] sVar = contest.getVar();

   String [] sTotQty = contest.getTotQty();
   String [] sTotPlan = contest.getTotPlan();
   String [] sTotVar = contest.getTotVar();

   String sRepQty = contest.getRepQty();
   String sRepPlan = contest.getRepPlan();
   String sRepVar = contest.getRepVar();

   String sRepTotQty = contest.getRepTotQty();
   String sRepTotPlan = contest.getRepTotPlan();
   String sRepTotVar = contest.getRepTotVar();

   contest.disconnect();
   contest = null;
   Calendar cal = Calendar.getInstance();
   cal.add(Calendar.DATE, -1);
   SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
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
                 text-align:center; vertical-align:top; font-family:Verdanda; font-size:12px }

  tr.DataTable1 { background:lightgreen; font-family:Arial; font-size:10px }
  tr.DataTable2 { background:SkyBlue; font-family:Arial; font-size:10px }
  tr.DataTable3 { background:coral; font-family:Arial; font-size:10px }
  tr.DataTable4 { background:151b7e; color:white;font-family:Arial; font-size:10px }
  tr.DataTable5 { background:cornsilk; color:black; font-family:Arial; font-size:10px }

  td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:right;}

  td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center;}

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
}

//------------------------------------------------------
// show another selected week
//------------------------------------------------------
function sbmNewSort(sort)
{
   var url = "ChristmasContest.jsp?Sort=" + sort

   //alert(url);
   window.location.href=url
}

</SCRIPT>


</head>
<body onload="bodyload()">
<!-------------------------------------------------------------------->
    <div id="dvSelect" class="dvSelect"></div>
<!-------------------------------------------------------------------->
 <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
   <tr>
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Christmas Bike Sales Contest
      <br>From: 11/04/2007 Thru: 12/30/2007</b> <%/*=df.format(cal.getTime())*/%>
     <tr>
       <td ALIGN="center" VALIGN="TOP">
       <a href="/"><font color="red" size="-1">Home</font></a>&#62;
       <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp
      </td>
   </tr>
   <tr>
      <td ALIGN="center" VALIGN="TOP">
<!-------------------------------------------------------------------->
  <!----------------- beginning of table ------------------------>
  <table class="DataTable" width="40%" cellPadding="0" cellSpacing="0">
    <tr>
      <th class="DataTable" rowspan="2">Tier</th>
      <th class="DataTable" rowspan="2">Store</th>
      <th class="DataTable" colspan="3">W-T-D Sales</th>
      <th class="DataTable" colspan="3">Total</th>
    </tr>

    <tr>
      <th class="DataTable">Qty</th>
      <th class="DataTable">Weekly<br>Plan</th>
      <th class="DataTable">Var</th>

      <th class="DataTable">Qty</th>
      <th class="DataTable">Total<br>Plan</th>
      <th class="DataTable">Var</th>
    </tr>

<!------------------------------- Detail Data --------------------------------->
   <%for(int i=0, j=3; i < iNumOfStr; i++, j++){%>
         <tr class="DataTable<%=iGrp[i]%>">
           <%if(j >= 3){ j=0;%>
              <td class="DataTable1" rowspan=3 nowrap>#<%=iGrp[i]%> Tier</td>
           <%}%>
           <td class="DataTable1" nowrap><%=sStr[i]%></td>
           <td class="DataTable" nowrap><%=sQty[i]%></td>
           <td class="DataTable" nowrap><%=sPlan[i]%></td>
           <td class="DataTable" nowrap><%=sVar[i]%>%</td>
           <td class="DataTable" nowrap><%=sTotQty[i]%></td>
           <td class="DataTable" nowrap><%=sTotPlan[i]%></td>
           <td class="DataTable" nowrap><%=sTotVar[i]%>%</td>
        </tr>
   <%}%>
   <!------------------------------- Total Data --------------------------------->
   <tr class="DataTable5">
      <td class="DataTable" nowrap colspan=2>Total</td>
      <td class="DataTable" nowrap><%=sRepQty%></td>
      <td class="DataTable" nowrap><%=sRepPlan%></td>
      <td class="DataTable" nowrap><%=sRepVar%>%</td>
      <td class="DataTable" nowrap><%=sRepTotQty%></td>
      <td class="DataTable" nowrap><%=sRepTotPlan%></td>
      <td class="DataTable" nowrap><%=sRepTotVar%>%</td>
   </tr>
<!-------------------------- end of Report Totals ----------------------------->
 </table>
 <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
