<%@ page import="java.util.*, java.text.*, classreports.ChallResult"%>
<%
    String sCode = request.getParameter("Code");
    String sName = request.getParameter("Name");
    String sDate = request.getParameter("Date");
    String sSort = request.getParameter("Sort");
    String sByPrc = request.getParameter("ByPrc");

    if (sDate==null)
    {
       SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
       Date dPriorDate = new Date((new Date()).getTime() - 86400000);
       sDate = sdf.format(dPriorDate);
    }
    if (sSort==null){sSort = "STR";}
    if (sByPrc==null){sByPrc = "Y";}

    String sUser = session.getAttribute("USER").toString();

    ChallResult chreslt = new ChallResult(sCode, sDate, sSort, sUser);

    String sWeek = chreslt.getWeek();

    int iNumOfStg = chreslt.getNumOfStg();
    String [] sBegDa = chreslt.getBegDa();
    String [] sEndDa = chreslt.getEndDa();

    int iNumOfStr = chreslt.getNumOfStr();
    String [] sStr = chreslt.getStr();
    String [][] sDayTySls = chreslt.getDayTySls();
    String [][] sDayLySls = chreslt.getDayLySls();
    String [][] sDayVar = chreslt.getDayVar();
    String [][] sDayVarPrc = chreslt.getDayVarPrc();

    String [] sWtdTySls = chreslt.getWtdTySls();
    String [] sWtdLySls = chreslt.getWtdLySls();
    String [] sWtdVar = chreslt.getWtdVar();
    String [] sWtdVarPrc = chreslt.getWtdVarPrc();
    String [] sWtdMin = chreslt.getWtdMin();
    String [] sReward = chreslt.getReward();

    String [][] sSumTySls = chreslt.getSumTySls();
    String [][] sSumLySls = chreslt.getSumLySls();
    String [][] sSumVar = chreslt.getSumVar();
    String [][] sSumVarPrc = chreslt.getSumVarPrc();
    String [][] sPlace = chreslt.getPlace();

    String [] sTotTySls = chreslt.getTotTySls();
    String [] sTotLySls = chreslt.getTotLySls();
    String [] sTotVar = chreslt.getTotVar();
    String [] sTotVarPrc = chreslt.getTotVarPrc();

    String [] sWkLySls = chreslt.getWkLySls();
    String [] sWkVar = chreslt.getWkVar();
    String [] sWkVarPrc = chreslt.getWkVarPrc();
    String [] sWkPlace = chreslt.getWkPlace();
    String [] sWtdPlace = chreslt.getWtdPlace();

    String sBronze = chreslt.getBronze();
    String sSilver = chreslt.getSilver();
    String sGold = chreslt.getGold();

    String [] sWkDays = new String[]{"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
%>

<style>body {background:white;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { text-align:center;}
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#FFCC99; font-family:Verdanda; font-size:10px }

        tr.DataTable  { background:white; font-family:Arial; font-size:10px }
        tr.DataTable8  { background: LightGreen; font-family:Arial; font-size:10px }
        tr.DataTable9  { background: LightBlue; font-family:Arial; font-size:10px }

        td.DataTable {  padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:center }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:right }
        td.DataTable11 { background:#af7817; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:right }
        td.DataTable12 { background:silver; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:right }
        td.DataTable13 { background:gold; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:right }
        td.DataTable14 { background:pink; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:right }
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px; text-align:left }

        div.dvBonus { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon;
              text-align:center; font-size:10px}
        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        .small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:center; font-family:Arial; font-size:10px;}
        #Var { display:none }
        #Prc { display:block }
        </style>

<script language="javascript">
var BegDa = "<%=sBegDa[0]%>";
var EndDa = "<%=sEndDa[iNumOfStg-1]%>";
var Week  = [<%=sWeek%>];
var ByPrc = "<%=sByPrc%>";

var NumOfStg = eval("<%=iNumOfStg%>");
var LastStage = true;
//==============================================================================
// initial page loads
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvBonus"]);
   popDateSelection();
   flipVarPrc();

   //showStages();
}
//==============================================================================
// populate date selection drop down menu
//==============================================================================
function popDateSelection()
{
   for(var i=0; i < Week.length; i++)
   {
     document.all.SelDate.options[i] = new Option(Week[i], Week[i])
   }
}
//==============================================================================
// show result of another day
//==============================================================================
function showAnotherDay()
{
   var sdate = document.all.SelDate.options[document.all.SelDate.selectedIndex].value
   if (ByPrc == "Y") {ByPrc = "N";}
   else{ ByPrc = "Y";}

   var url = "ChallResult.jsp?Code=<%=sCode%>&Name=<%=sName%>"
           + "&Date=" + sdate
           + "&ByPrc=" + ByPrc;
   window.location.href = url;
}
//==============================================================================
// show result of another day
//==============================================================================
function resortBy(sort)
{
   if (ByPrc == "Y") {ByPrc = "N";}
   else{ ByPrc = "Y";}

   var url = "ChallResult.jsp?Code=<%=sCode%>&Name=<%=sName%>"
           + "&Date=<%=sDate%>"
           + "&Sort=" + sort
           + "&ByPrc=" + ByPrc;
   window.location.href = url;
}

//==============================================================================
// flip between Variance and Percentage
//==============================================================================
function flipVarPrc()
{
   var vardsp = null;
   var prcdsp = null;
   var varid = document.all.Var;
   var prcid = document.all.Prc;

   if (ByPrc == "Y"){vardsp = "none"; prcdsp = "block"; ByPrc = "N";}
   else {vardsp = "block"; prcdsp = "none"; ByPrc = "Y";}

   for(var i=0; i < varid.length; i++)
   {
      document.all.Var[i].style.display = vardsp;
      document.all.Prc[i].style.display = prcdsp;
   }
}

//==============================================================================
// show/hide past stages
//==============================================================================
function showStages()
{
   var stgdsp = null;

   if (LastStage){stgdsp = "none"; }
   else {stgdsp = "block"; }

   for(var i=0; i < NumOfStg-1; i++)
   {
      var tdstg = "tdStg" + i
      var stg = document.all[tdstg];
      for(var j=0; j < stg.length; j++)  { stg[j].style.display = stgdsp; }
   }

   LastStage = !LastStage;
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

<html>
<head>
<title>
Challenge List
</title>
</head>
<body onload="bodyLoad();">

<!-------------------------------------------------------------------->
<div class="dvBonus" id="dvBonus"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD vAlign=top align=middle><b>Retail Concepts Inc.
        <BR><%=sName%>
        <br>Date: <%=sDate%>
        </b>

      <br><p><a href="../"><font color="red"  size="-1">Home</font></a>&#62;
         <font size="-1">This page</font> &nbsp; &nbsp; &nbsp;
         <select name="SelDate" class="small"></select>
         <button class="small" onclick="showAnotherDay()">Go</button> &nbsp; &nbsp; &nbsp;

         <a href="javascript:flipVarPrc()" style="font-size:12px">Variance / Percentage</a>
          &nbsp; &nbsp; &nbsp;
        <!--a href="javascript:showStages()" style="font-size:12px">Prior Stages</a -->

      <!------------- start Receipt table ------------------------>
      <table class="DataTable" border=1 cellPadding='0' cellSpacing='0'>
             <tr class="DataTable">
                <th class="DataTable" rowspan=2><a href="javascript: resortBy('STR')">Store</a></th>
                <%for(int i = 0; i < 7; i++){%>
                  <th class="DataTable1" rowspan=2>&nbsp;</th>
                  <th class="DataTable" colspan=3><%=sWkDays[i]%></th>
                <%}%>
                <th class="DataTable1" rowspan=2>&nbsp;</th>
                <th class="DataTable" colspan=3>Week-to-date</th>

                <th class="DataTable1" rowspan=2>&nbsp;</th>
                <th class="DataTable" colspan=3>Total Plan for Week</th>

                <th class="DataTable1" rowspan=2>P<br>a<br>y</th>

                <%for(int i = 0; i < iNumOfStg; i++){%>
                    <%if(i > 0){%><th class="DataTable1" rowspan=2>&nbsp;</th><%}%>
                    <th  id="tdStg<%=i%>" class="DataTable" colspan=4>
                       Stage (Cumulative)<br><%=sBegDa[i]%> - <%=sEndDa[i]%>
                     <!-- January-February Cumulative -->
                    </th>
                <%}%>

                <th class="DataTable1" rowspan=2>&nbsp;</th>
                <th class="DataTable" colspan=4>Stages Totals</th>
                <th class="DataTable" rowspan=2><a href="javascript: resortBy('STR')">Store</a></th>
             </tr>
             <tr class="DataTable">
             <%for(int i = 0; i < 7; i++){%>
                <th class="DataTable"><a href="javascript: resortBy('TYDAY<%=i+1%>')">TY</a></th>
                <th class="DataTable"><a href="javascript: resortBy('BMDAY<%=i+1%>')">Plan</a></th>
                <th class="DataTable" id="Var"><a href="javascript: resortBy('VARDAY<%=i+1%>')">Var</a></th>
                <th class="DataTable" id="Prc"><a href="javascript: resortBy('PRCDAY<%=i+1%>')">Var<br>%</a></th>
             <%}%>

             <th class="DataTable"><a href="javascript: resortBy('TYWTD')">TY</a></th>
             <th class="DataTable"><a href="javascript: resortBy('BMWTD')">Plan</a></th>
             <th class="DataTable" id="Var"><a href="javascript: resortBy('VARWTD')">Var</a></th>
             <th class="DataTable" id="Prc"><a href="javascript: resortBy('PRCWTD')">Var<br>%</a></th>

             <th class="DataTable"><a href="javascript: resortBy('TYWTD')">TY</a></th>
             <th class="DataTable"><a href="javascript: resortBy('BMWTD')">Plan</a></th>
             <th class="DataTable" id="Var"><a href="javascript: resortBy('VARWK')">Var</a></th>
             <th class="DataTable" id="Prc"><a href="javascript: resortBy('PRCWK')">Var<br>%</a></th>

                <%for(int i = 0; i < iNumOfStg; i++){%>
                   <th id="tdStg<%=i%>" class="DataTable"><a href="javascript: resortBy('TYSTG<%=i+1%>')">TY</a></th>
                   <th id="tdStg<%=i%>" class="DataTable"><a href="javascript: resortBy('BMSTG<%=i+1%>')">Plan</a></th>
                   <th id="tdStg<%=i%>" class="DataTable"><a href="javascript: resortBy('VARSTG<%=i+1%>')">Var</a></th>
                   <th id="tdStg<%=i%>" class="DataTable"><a href="javascript: resortBy('PRCSTG<%=i+1%>')">Var<br>%</a></th>
                <%}%>

             <th class="DataTable"><a href="javascript: resortBy('TYTOT')">TY</a></th>
             <th class="DataTable"><a href="javascript: resortBy('BMTOT')">Plan</a></th>
             <th class="DataTable" id="VarTot"><a href="javascript: resortBy('VARTOT')">Var</a></th>
             <th class="DataTable" id="PrcTot"><a href="javascript: resortBy('PRCTOT')">Var<br>%</a></th>
          </tr>
      <!-- ============= Details =========================================== -->
         <%for(int i = 0; i < iNumOfStr; i++){%>
              <tr class="DataTable<%if(sStr[i].equals("Total")){%>9<%} else if(sStr[i].indexOf("Reg")  >= 0 ){%>8<%}%>">
                 <td class="DataTable1"><%=sStr[i]%></td>

                 <%for(int j = 0; j < 7; j++){%>
                    <th class="DataTable1">&nbsp;</th>
                    <td class="DataTable1">$<%=sDayTySls[i][j]%></td>
                    <td class="DataTable1">$<%=sDayLySls[i][j]%></td>
                    <td class="DataTable1" id="Var">$<%=sDayVar[i][j]%></td>
                    <td class="DataTable1" id="Prc" nowrap><%=sDayVarPrc[i][j]%>%</td>
                 <%}%>

                 <th class="DataTable1">&nbsp;</th>

                 <td class="DataTable1<%=sWtdPlace[i]%>">$<%=sWtdTySls[i]%></td>
                 <td class="DataTable1<%=sWtdPlace[i]%>">$<%=sWtdLySls[i]%></td>
                 <td class="DataTable1<%=sWtdPlace[i]%>" id="Var">$<%=sWtdVar[i]%></td>
                 <td class="DataTable1<%=sWtdPlace[i]%>" id="Prc" nowrap><%=sWtdVarPrc[i]%>%</td>

                 <th class="DataTable1">&nbsp;</th>

                 <td class="DataTable1<%=sWkPlace[i]%>">$<%=sWtdTySls[i]%></td>
                 <td class="DataTable1<%=sWkPlace[i]%>">$<%=sWkLySls[i]%></td>
                 <td class="DataTable1<%=sWkPlace[i]%>" id="Var">$<%=sWkVar[i]%></td>
                 <td class="DataTable1<%=sWkPlace[i]%>" id="Prc" nowrap><%=sWkVarPrc[i]%>%</td>

                 <th class="DataTable1">&nbsp;</th>

                 <%for(int j = 0; j < iNumOfStg; j++){%>
                    <%if(j > 0){%><th class="DataTable1"><%if(sReward[i].equals("1")){%>$<%} else {%>&nbsp;<%}%></th><%}%>
                    <td id="tdStg<%=j%>" class="DataTable1<%=sPlace[i][j]%>">$<%=sSumTySls[i][j]%></td>
                    <td id="tdStg<%=j%>" class="DataTable1<%=sPlace[i][j]%>">$<%=sSumLySls[i][j]%></td>
                    <td id="tdStg<%=j%>" class="DataTable1<%=sPlace[i][j]%>">$<%=sSumVar[i][j]%></td>
                    <td id="tdStg<%=j%>" class="DataTable1<%=sPlace[i][j]%>" nowrap><%=sSumVarPrc[i][j]%>%</td>
                 <%}%>

                 <th class="DataTable1">&nbsp;</th>

                 <td class="DataTable1">$<%=sTotTySls[i]%></td>
                 <td class="DataTable1">$<%=sTotLySls[i]%></td>
                 <td class="DataTable1">$<%=sTotVar[i]%></td>
                 <td class="DataTable1" nowrap><%=sTotVarPrc[i]%>%</td>

                 <td class="DataTable1"><%=sStr[i]%></td>
              </tr>
         <%}%>

       </table>
       <p>
       <table border=0  cellPadding='0' cellSpacing='0'>
       <tr>
           <td style="background:gold; font-size:12px">&nbsp; &nbsp;</td>
           <td>&nbsp;</td>
        </tr>
       <tr>
           <td style="background:gold; font-size:12px">&nbsp; &nbsp;</td>
           <td style="background:silver; font-size:12px">&nbsp; &nbsp;</td>
           <td>&nbsp;</td>
        </tr>
        <tr>
           <td style="background:gold; font-size:12px">&nbsp; <%=sGold%>% &nbsp;</td>
           <td style="background:silver; font-size:12px">&nbsp; <%=sSilver%>% &nbsp;</td>
           <td style="background:#af7817; font-size:12px">&nbsp; <%=sBronze%>% &nbsp;</td>
        </tr>

        <tr>
           <td style="background:gold; font-size:12px; text-align:center">Gold</td>
           <td style="background:silver; font-size:12px; text-align:center">Silver</td>
           <td style="background:#af7817; font-size:12px; text-align:center">Bronze</td>
        </tr>

       </table>
      </TD>
     </TR>
     <TR>
       <TD align=left>
         <span style="font-size:12px;">
          A Store must have sales of at least $8,500 in challenge categories in a particular
          week in order to qualify for the extra pay incentive for that week.
         </span>
       </TD>
     </TR>
    </TBODY>
   </TABLE>
</body>
</html>
<%
  chreslt.disconnect();
  chreslt = null;
%>