<%@ page import="agedanalysis.AgedAnalysis, java.util.*"%>
<%
   long lStartTime = (new Date()).getTime();

   String sStore = request.getParameter("STORE");
   String sDivision = request.getParameter("DIVISION");
   String sDepartment = request.getParameter("DEPARTMENT");
   String sClass = request.getParameter("CLASS");
   String sCompDate = request.getParameter("selDate");
   String sLevel = request.getParameter("LEVEL");
   String sSortBy = request.getParameter("SORT");

   if(sStore == null) sStore = "ALL";
   if(sDivision == null) sDivision = "ALL";
   if(sDepartment == null) sDepartment = "ALL";
   if(sClass == null) sClass = "ALL";
   if(sLevel == null) sLevel = "000";
   if(sCompDate == null) sCompDate = " ";
   if(sSortBy == null) sSortBy = "GROUP";

   String sSortTitle = null;
   if ((sLevel.equals("200") || !sStore.equals("ALL") && (sLevel.equals("100") || sLevel.equals("000")))
     && sSortBy.equals("GROUP")) sSortTitle = "Sorted by Divisions";
   else if((sLevel.equals("020") || !sStore.equals("ALL") && sLevel.equals("010"))
     && sSortBy.equals("GROUP")) sSortTitle = "Sorted by Departments";
   else if((sLevel.equals("002") || !sStore.equals("ALL") && sLevel.equals("001"))
     && sSortBy.equals("GROUP")) sSortTitle = "Sorted by Classes";
   else if(sStore.equals("ALL") && sSortBy.equals("GROUP")) sSortTitle = "Sorted by Store";

   else if(sSortBy.equals("TCS")) sSortTitle = "Sorted by This Year Cost";
   else if(sSortBy.equals("TRT")) sSortTitle = "Sorted by This Year Retail";
   else if(sSortBy.equals("LCS")) sSortTitle = "Sorted by Last Year Cost";
   else if(sSortBy.equals("LRT")) sSortTitle = "Sorted by Last Year Retail";
   else if(sSortBy.equals("TMV")) sSortTitle = "Sorted by This Year Markup Percents";
   else if(sSortBy.equals("LMV")) sSortTitle = "Sorted by Last Year Markup Percents";
   else if(sSortBy.equals("CDD")) sSortTitle = "Sorted by Cost Variance Dollars";
   else if(sSortBy.equals("CDV")) sSortTitle = "Sorted by Cost Variance Percents";

   /*System.out.println(sDivision + " " + sDepartment + " " + sClass + " "
          + sStore + " " + sCompDate + " " + sLevel + " " + sSortBy);*/
   AgedAnalysis goodAnl = new AgedAnalysis(sDivision, sDepartment, sClass, sStore,
                                      sCompDate, sLevel, sSortBy);

    String [] sGrp = goodAnl.getGroup();
    sCompDate = goodAnl.getCompDate();


    String sGrpJSA = goodAnl.getGrpJSA();
    String sDivJSA = goodAnl.getDivJSA();
    String sDptJSA = goodAnl.getDptJSA();
    String sClsJSA = goodAnl.getClsJSA();

    String sDivNameJSA = goodAnl.getDivNameJSA();
    String sDptNameJSA = goodAnl.getDptNameJSA();
    String sClsNameJSA = goodAnl.getClsNameJSA();

    int iNumOfSls = goodAnl.getNumOfSls();
    String [] sTyWkRet = goodAnl.getTyWkRet();
    String [] sLyWkRet = goodAnl.getLyWkRet();
    String [] sTyWkCst = goodAnl.getTyWkCst();
    String [] sLyWkCst = goodAnl.getLyWkCst();
    String [] sTyWkMUp = goodAnl.getTyWkMUp();
    String [] sLyWkMUp = goodAnl.getLyWkMUp();
    String [] sCstDif = goodAnl.getCstDif();
    String [] sCstVar = goodAnl.getCstVar();

    //------------------------ Mall/Non-Mall Totals ---------------------------------
    String [] sMallTyWkRet = goodAnl.getMallTyWkRet();
    String [] sMallLyWkRet = goodAnl.getMallLyWkRet();
    String [] sMallTyWkCst = goodAnl.getMallTyWkCst();
    String [] sMallLyWkCst = goodAnl.getMallLyWkCst();
    String [] sMallTyWkMUp = goodAnl.getMallTyWkMUp();
    String [] sMallLyWkMUp = goodAnl.getMallLyWkMUp();
    String [] sMallCstDif = goodAnl.getMallCstDif();
    String [] sMallCstVar = goodAnl.getMallCstVar();

    //------------------------ Non/Ski Totals ---------------------------------
    String [] sSkiTyWkRet = goodAnl.getSkiTyWkRet();
    String [] sSkiLyWkRet = goodAnl.getSkiLyWkRet();
    String [] sSkiTyWkCst = goodAnl.getSkiTyWkCst();
    String [] sSkiLyWkCst = goodAnl.getSkiLyWkCst();
    String [] sSkiTyWkMUp = goodAnl.getSkiTyWkMUp();
    String [] sSkiLyWkMUp = goodAnl.getSkiLyWkMUp();
    String [] sSkiCstDif = goodAnl.getSkiCstDif();
    String [] sSkiCstVar = goodAnl.getSkiCstVar();

    //------------------------ Region Totals ---------------------------------
    String [] sRegTyWkRet = goodAnl.getRegTyWkRet();
    String [] sRegLyWkRet = goodAnl.getRegLyWkRet();
    String [] sRegTyWkCst = goodAnl.getRegTyWkCst();
    String [] sRegLyWkCst = goodAnl.getRegLyWkCst();
    String [] sRegTyWkMUp = goodAnl.getRegTyWkMUp();
    String [] sRegLyWkMUp = goodAnl.getRegLyWkMUp();
    String [] sRegCstDif = goodAnl.getRegCstDif();
    String [] sRegCstVar = goodAnl.getRegCstVar();

    //------------------------ Report Totals ---------------------------------
    String [] sRepTyWkRet = goodAnl.getRepTyWkRet();
    String [] sRepLyWkRet = goodAnl.getRepLyWkRet();
    String [] sRepTyWkCst = goodAnl.getRepTyWkCst();
    String [] sRepLyWkCst = goodAnl.getRepLyWkCst();
    String [] sRepTyWkMUp = goodAnl.getRepTyWkMUp();
    String [] sRepLyWkMUp = goodAnl.getRepLyWkMUp();
    String [] sRepCstDif = goodAnl.getRepCstDif();
    String [] sRepCstVar = goodAnl.getRepCstVar();

    goodAnl.disconnect();

    String sColName = "Store";
    if(!sStore.equals("ALL") || sLevel.indexOf('2') >= 0)
    {
      if(sLevel.equals("100") || sLevel.equals("200")) { sColName = "Division"; }
      else if(sLevel.equals("010") || sLevel.equals("020")) { sColName = "Department"; }
      else if(sLevel.equals("001") || sLevel.equals("002")) { sColName = "Class"; }
    }

%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        th.InvData { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.InvData { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}


        tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:Seashell; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:Honeydew; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:lightgrey; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:darkred;}
        tr.DataTable5 { background:Azure; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable2 { border-top: double darkred;}


        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Level = "<%=sLevel%>";
var Combined = <%=sLevel.indexOf('2') >= 0%>;
var Store = "<%=sStore%>";
var Div = null;
var Dpt = null;
var Cls = null;
var Str = null;

var DivName = null;
var DptName = null;
var ClsName = null;
var Grp = [<%=sGrpJSA%>];

if(Store == "ALL" && !Combined)
{
  Str = [<%=sGrpJSA%>]
  if(Level=="000" ) { Div = [<%=sDivJSA%>]; DivName = [<%=sDivNameJSA%>];}
  else if(Level=="100") { Dpt = [<%=sDptJSA%>]; DptName = [<%=sDptNameJSA%>]; }
  else if(Level=="010") { Cls = [<%=sClsJSA%>]; ClsName = [<%=sClsNameJSA%>]; }
}
else if(Store == "ALL" && Combined)
{
  if(Level=="200") { Div = [<%=sDivJSA%>]; DivName = [<%=sDivNameJSA%>];}
  else if(Level=="020") { Dpt = [<%=sDptJSA%>]; DptName = [<%=sDptNameJSA%>]; }
  else if(Level=="002") { Cls = [<%=sClsJSA%>]; ClsName = [<%=sClsNameJSA%>]; }
}
else
{
  if(Level=="100") { Div = [<%=sDivJSA%>]; DivName = [<%=sDivNameJSA%>];}
  else if(Level=="010") { Dpt = [<%=sDptJSA%>]; DptName = [<%=sDptNameJSA%>]; }
  else if(Level=="001") { Cls = [<%=sClsJSA%>]; ClsName = [<%=sClsNameJSA%>]; }
}
//--------------- End of Global variables ----------------
function bodyLoad()
{
  if(Store == "ALL" && !Combined) doSelectGrp();
  else
  {
    document.all.dvForm.style.visibility="hidden";
  }
}


//
function doSelectGrp()
{
    formHtml = "<Form name='LevelDown' >"
    if (Store == "ALL" && (Level == "000" || Level == "200") || Level == "100" && Store != "ALL")
    {
      formHtml += "Select Division: <Select name='DIVISION' class='Small'></Select><br>"
      if (Store == "ALL" && Level == "000") formHtml += "<input name='LEVEL' value='100' type='hidden' >"
      else if (Store == "ALL" && Level == "200") formHtml += "<input name='LEVEL' value='020' type='hidden' >"
      else formHtml += "<input name='LEVEL' value='010' type='hidden'>"
    }
    else if (Store == "ALL" && (Level == "100" || Level == "020") || Level == "010" && Store != "ALL")
    {
      formHtml += "Select Department: <Select name='DEPARTMENT' class='Small'></Select><br>"
      if (Store == "ALL"  && Level == "100") formHtml += "<input  name='LEVEL' value='010' type='hidden'>"
      else if (Store == "ALL"  && Level == "020") formHtml += "<input  name='LEVEL' value='002' type='hidden'>"
      else formHtml += "<input  name='LEVEL' value='001' type='hidden'>"
    }
    else if (Store == "ALL" && Level == "010")
    {
      formHtml += "Select Class: <Select name='CLASS' class='Small'></Select><br>"
      formHtml += "<input name='LEVEL' value='001' type='hidden'>"
    }

    formHtml += "<input name='STORE' value='<%=sStore%>' type='hidden'>"
    formHtml += "<input name='selDate' value='<%=sCompDate%>' type='hidden'>"

    // show submit button for next level down
    if (Level != "001" && Level != "002")
    {
      formHtml += "<input type='Submit' name='submit' value='  Go  ' class='Small'>"
    }

        // show submit button to get for this level and by store
    if(Combined)
    {
      formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<input type='Submit' name='ByStore' value='SbmByStore' onclick='checkLevel();' class='Small'>"
    }

    formHtml += "&nbsp;&nbsp;&nbsp;&nbsp;<input type='BUTTON' name='Back' value='Back' onClick='javascript:history.back()' class='Small'>"
      + "</Form>"

    document.all.dvForm.innerHTML=formHtml
    document.all.dvForm.style.visibility="visible";

    if( Store == "ALL" && (Level == "000" || Level == "200")
     || Level == "100" && Store != "ALL")
             for(var i=0; i < Div.length;i++){ document.LevelDown.DIVISION.options[i] = new Option(Div[i] + " - " + unescape(DivName[i]), Div[i]); }
    else if( Store == "ALL" && (Level == "100" || Level == "020")
          || Level == "010" && Store != "ALL")
             for(var i=0; i < Dpt.length;i++){ document.LevelDown.DEPARTMENT.options[i] = new Option(Dpt[i] + " - " + unescape(DptName[i]), Dpt[i]); }
    else if( Store == "ALL" && (Level == "010" || Level == "002")
          || Level == "001" && Store != "ALL")
             for(var i=0; i < Cls.length;i++){ document.LevelDown.CLASS.options[i] = new Option(Cls[i] + " - " + unescape(ClsName[i]), Cls[i]); }
}


// Drill down on next div/dpt/class level
function drillDown(arg)
{
  var url = "AgedAnalysis.jsp?STORE=<%=sStore%>"
  var group = "";
  var idx = 0;
  for (i=0; i<Grp[arg].length; i++)
  {
    if(Grp[arg].substring(i, i+1) != "-") group += Grp[arg].substring(i, i+1);
    else break;
  }

  if (Store =="ALL")
  {
    if(Level == "000") url += "&DIVISION=" + group + "&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&LEVEL=100"
    else if(Level == "100") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=" + group + "&CLASS=<%=sClass%>&LEVEL=010"
    else if(Level == "010") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=" + group + "&LEVEL=001"

    else if(Level == "200") url += "&DIVISION=" + group + "&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&LEVEL=020"
    else if(Level == "020") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=" + group + "&CLASS=<%=sClass%>&LEVEL=002"
    else if(Level == "002") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=" + group + "&LEVEL=001"
  }
  else
  {
    if(Level == "100") url += "&DIVISION=" + group + "&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&LEVEL=010"
    else if(Level == "010") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=" + group + "&CLASS=<%=sClass%>&LEVEL=001"
  }

    url += "&selDate=<%=sCompDate%>"
      + "&SORT=<%=sSortBy%>";
  //alert(url);
  window.location.href = url;
}

// Show data by Store
function showByStore(drill, arg)
{
  var url = "AgedAnalysis.jsp?STORE=<%=sStore%>"

  if (drill)
  {
    if(Level == "200") url += "&DIVISION=" + Div[arg] + "&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&LEVEL=100"
    else if(Level == "020") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=" + Dpt[arg] + "&CLASS=<%=sClass%>&LEVEL=010"
    else if(Level == "002") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=" + Cls[arg] + "&LEVEL=001"
  }
  else
  {
    if(Level == "200") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&LEVEL=000"
    else if(Level == "020") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&LEVEL=100"
    else if(Level == "002") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&LEVEL=010"
  }
  url += "&selDate=<%=sCompDate%>"
      + "&SORT=<%=sSortBy%>";
  //alert(url);
  window.location.href = url;
}

function showByDivision(arg)
{
  var url = "AgedAnalysis.jsp?STORE=" + Str[arg]

  if(Level == "000") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&LEVEL=100"
  else if(Level == "100") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&LEVEL=010"
  else if(Level == "010") url += "&DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>&CLASS=<%=sClass%>&LEVEL=001"

  url += "&selDate=<%=sCompDate%>"
      + "&SORT=<%=sSortBy%>";
  //alert(url);
  window.location.href = url;
}

function reSort(sort)
{
  var url = "AgedAnalysis.jsp?STORE=" + Store
          + "&DIVISION=<%=sDivision%>&DEPARTMENT=<%=sDepartment%>"
          + "&CLASS=<%=sClass%>&LEVEL=<%=sLevel%>"
          + "&selDate=<%=sCompDate%>"
          + "&SORT=" + sort;
  //alert(url);
  window.location.href = url;
}

</SCRIPT>


</head>
<body onload="bodyLoad()">

    <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">
<!-------------------------------------------------------------------->
      <td ALIGN="left" width="300">
       <div id="dvForm" class="dvForm"></div>
      </td>
<!-------------------------------------------------------------------->

      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Aged Inventory Analysis
      <br>Compare Date: <%=sCompDate%>&nbsp;&nbsp
          Store: <%=sStore%> &nbsp;&nbsp
          Div: <%=sDivision%> &nbsp;&nbsp
          Dpt: <%=sDepartment%> &nbsp;&nbsp
          Class: <%=sClass%>
         <br><%=sSortTitle%></b>
      </td>
      <td ALIGN="left" width="500">&nbsp;</td>
     </tr>

     <tr bgColor="moccasin">
      <td ALIGN="Center" VALIGN="TOP" colspan=3>

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
          <a href="rciWeeklyReports.html"><font color="red" size="-1">Flash Reports</font></a>&#62;
          <a href="AgedAnalysisSel.jsp?mode=1">
            <font color="red" size="-1">Select Report</font></a>&#62;
          <font size="-1">This Page.</font>
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr>
	  <th class="DataTable"  rowspan="2"><a href="javascript: reSort('GROUP')"><%=sColName%></a></th>
          <th class="DataTable"  rowspan="2">
            <%if(sLevel.indexOf('2') >= 0){%>
                <a href="javascript: showByStore(false, 0)">B<br>y<br>S<br>t<br>r</a><%}
              else{%>&nbsp;&nbsp;<%}%></th>

          <th class="DataTable"  colspan="3">This Year</th>
          <th class="DataTable"  rowspan="2">&nbsp;&nbsp;</th>
          <th class="DataTable"  colspan="3">Last Year</th>
          <th class="InvData"  rowspan="2">&nbsp;&nbsp;</th>
          <th class="InvData"  colspan="2">Cost<br>Increase - Decrease</th>
        </tr>

        <tr>
          <th class="DataTable"><a href="javascript: reSort('TCS')">Cost</a></th>
          <th class="DataTable"><a href="javascript: reSort('TRT')">Retail</a></th>
          <th class="DataTable"><a href="javascript: reSort('TMV')">MU</a><br>(%)</th>

          <th class="DataTable"><a href="javascript: reSort('LCS')">Cost</a></th>
          <th class="DataTable"><a href="javascript: reSort('LRT')">Retail</a></th>
          <th class="DataTable"><a href="javascript: reSort('LMV')">MU</a><br>(%)</th>

          <th class="DataTable"><a href="javascript: reSort('CDD')">&nbsp;($)&nbsp;</a></th>
          <th class="DataTable"><a href="javascript: reSort('CDV')">&nbsp;(%)&nbsp;</a></th>
	 </tr>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfSls; i++) {%>

           <%if(sStore.equals("ALL") && sLevel.indexOf('2') < 0){%>
              <tr class="DataTable">
                <td class="DataTable1" nowrap>
                  <%if(sLevel.substring(2).equals("0")){%>
                     <a href="javascript: showByDivision(<%=i%>)"><%=sGrp[i]%></a>
                  <%} else {%><%=sGrp[i]%><%}%></td>
                <th class="DataTable">&nbsp;</th>
            <%}
              else {%>
              <tr class="DataTable">
                <td class="DataTable1" nowrap>
                  <%if(sLevel.substring(2).equals("0")){%>
                     <a href="javascript:drillDown('<%=i%>')"><%=sGrp[i]%></a>
                  <%}
                    else {%><a href="SkuAgedAnalysis.jsp?Cls=<%=sGrp[i].substring(0, sGrp[i].indexOf("-"))%>&Str=<%=sStore%>"><%=sGrp[i]%><%}%></a></td>
                <th class="DataTable">
                  <%if(sStore.equals("ALL")) {%><a href="javascript: showByStore(true, <%=i%>)">S</a><%} else{%>&nbsp;<%}%></th>
            <%}%>

                <td class="DataTable" nowrap>$<%=sTyWkCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sTyWkRet[i]%></td>
                <td class="DataTable" nowrap><%=sTyWkMUp[i]%>%</td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable" nowrap>$<%=sLyWkCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sLyWkRet[i]%></td>
                <td class="DataTable" nowrap><%=sLyWkMUp[i]%>%</td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable" nowrap>$<%=sCstDif[i]%></td>
                <td class="DataTable" nowrap><%=sCstVar[i]%>%</td>
              </tr>
           <%}%>
<!------------------- Company Total -------------------------------->
      <%if(sStore.equals("ALL") && sDivision.equals("ALL")){%>
       <tr><td class="DataTable2"></td></tr>
       <%for(int i=0; i < 1; i++) {%>
              <tr class="DataTable3">
                <td class="DataTable1" nowrap>Totals</td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable" nowrap>$<%=sRepTyWkCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sRepTyWkRet[i]%></td>
                <td class="DataTable" nowrap><%=sRepTyWkMUp[i]%>%</td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable" nowrap>$<%=sRepLyWkCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sRepLyWkRet[i]%></td>
                <td class="DataTable" nowrap><%=sRepLyWkMUp[i]%>%</td>
                <th class="InvData">&nbsp;</th>

                <td class="DataTable" nowrap>$<%=sRepCstDif[i]%></td>
                <td class="DataTable" nowrap><%=sRepCstVar[i]%>%</td>
              </tr>
           <%}%>
      <%}%>

      <!------------------- Mall/Non-Mall Total -------------------------------->
      <%if(sStore.equals("ALL")){%>
         <tr class="DataTable4"><td class="DataTable2"></td></tr>
         <%for(int i=0; i < 2; i++) {%>
              <tr class="DataTable2">
                <td class="DataTable1" nowrap><%if(i==0){  out.print("Mall"); } else { out.print("Non-Mall"); }%></td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable" nowrap>$<%=sMallTyWkCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sMallTyWkRet[i]%></td>
                <td class="DataTable" nowrap><%=sMallTyWkMUp[i]%>%</td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable" nowrap>$<%=sMallLyWkCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sMallLyWkRet[i]%></td>
                <td class="DataTable" nowrap><%=sMallLyWkMUp[i]%>%</td>
                <th class="InvData">&nbsp;</th>

                <td class="DataTable" nowrap>$<%=sMallCstDif[i]%></td>
                <td class="DataTable" nowrap><%=sMallCstVar[i]%>%</td>
              </tr>
           <%}%>
         <%}%>

      <!------------------- Non/-Ski Total -------------------------------->
      <%if(sStore.equals("ALL")){%>
         <tr class="DataTable4"><td class="DataTable2"></td></tr>
         <%for(int i=0; i < 2; i++) {%>
              <tr class="DataTable5">
                <td class="DataTable1" nowrap><%if(i==0){  out.print("Ski"); } else { out.print("Non-Ski"); }%></td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable" nowrap>$<%=sSkiTyWkCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sSkiTyWkRet[i]%></td>
                <td class="DataTable" nowrap><%=sSkiTyWkMUp[i]%>%</td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable" nowrap>$<%=sSkiLyWkCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sSkiLyWkRet[i]%></td>
                <td class="DataTable" nowrap><%=sSkiLyWkMUp[i]%>%</td>
                <th class="InvData">&nbsp;</th>

                <td class="DataTable" nowrap>$<%=sSkiCstDif[i]%></td>
                <td class="DataTable" nowrap>%<%=sSkiCstVar[i]%></td>
              </tr>
           <%}%>
         <%}%>


      <!------------------- Regional Total -------------------------------->
      <%if(sStore.equals("ALL")){%>
         <tr><td class="DataTable2"></td></tr>
         <%for(int i=0; i < 4; i++) {%>
              <tr class="DataTable1">
                <td class="DataTable1" nowrap>Region <%if(i==3){%>99 (DC Only)<%} else {%><%=i+1%><%}%></td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable" nowrap>$<%=sRegTyWkCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sRegTyWkRet[i]%></td>
                <td class="DataTable" nowrap><%=sRegTyWkMUp[i]%>%</td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable" nowrap>$<%=sRegLyWkCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sRegLyWkRet[i]%></td>
                <td class="DataTable" nowrap><%=sRegLyWkMUp[i]%>%</td>
                <th class="InvData">&nbsp;</th>

                <td class="DataTable" nowrap>$<%=sRegCstDif[i]%></td>
                <td class="DataTable" nowrap><%=sRegCstVar[i]%>%</td>
              </tr>
           <%}%>
         <%}%>
      <!------------------- Report Total -------------------------------->
         <tr><td class="DataTable2"></td></tr>
         <%for(int i=0; i < 1; i++) {%>
              <tr class="DataTable3">
                <td class="DataTable1" nowrap>Totals</td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable" nowrap>$<%=sRepTyWkCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sRepTyWkRet[i]%></td>
                <td class="DataTable" nowrap><%=sRepTyWkMUp[i]%>%</td>
                <th class="DataTable">&nbsp;</th>

                <td class="DataTable" nowrap>$<%=sRepLyWkCst[i]%></td>
                <td class="DataTable" nowrap>$<%=sRepLyWkRet[i]%></td>
                <td class="DataTable" nowrap><%=sRepLyWkMUp[i]%>%</td>
                <th class="InvData">&nbsp;</th>

                <td class="DataTable" nowrap>$<%=sRepCstDif[i]%></td>
                <td class="DataTable" nowrap><%=sRepCstVar[i]%>%</td>
              </tr>
           <%}%>

      </table>
      <!----------------------- end of table ------------------------>
      <font size="-1">* Note: "This Year" data may not be available until Tuesday of each week.</font>

  </table>
<%
      long lEndTime = (new Date()).getTime();
      long lElapse = (lEndTime - lStartTime) / 1000;
      if (lElapse==0) lElapse = 1;
%>
  <p style="font-size:10px;">Elapse: <%=lElapse%> sec
 </body>
</html>
