<%@ page import="salesvelocity.HeadCountWk, java.util.*, java.text.*"%>
<%
   String [] sStr = request.getParameterValues("Str");
   String sFrom = request.getParameter("FrWeek");
   String sTo = request.getParameter("ToWeek");
   String sYear = request.getParameter("Year");
   String sMonth = request.getParameter("Month");
   String sMissOpt = request.getParameter("MissOpt");
   String sSort = request.getParameter("Sort");

   if(sSort == null){sSort = "STR";}

   SimpleDateFormat smp = new SimpleDateFormat("MM/dd/yyyy");

if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=HeadCountWk.jsp?" + request.getQueryString());
}
else
{
   String sUser = session.getAttribute("USER").toString();

   //System.out.println(sStr[0] + "|" + sStr[1] + "|" + sFrom + "|" + sTo + "|" + sYear
   // + "|" + sMonth + "|" + sSort + "|" + sUser);
   HeadCountWk hcweek = new HeadCountWk(sStr, sFrom, sTo, sYear, sMonth, sMissOpt, sSort, sUser);

   int iNumOfWk = hcweek.getNumOfWk();
    String [] sTyWeek = hcweek.getTyWeek();
    String [] sLyWeek = hcweek.getLyWeek();
    String [] sMonNm = hcweek.getMonNm();
    String [] sWeek = hcweek.getWeek();

    int iNumOfStr = hcweek.getNumOfStr();

    String [] sTyTraf = null;
    String [] sTyTran = null;
    String [] sTyConv = null;
    String [] sTyAsp = null;
    String [] sTySls = null;

    String [] sLyTraf = null;
    String [] sLyTran = null;
    String [] sLyConv = null;
    String [] sLyAsp = null;
    String [] sLySls = null;

   String [] sVaTraf = null;
   String [] sVaTran = null;
   String [] sVaConv = null;
   String [] sVaAsp = null;
   String [] sVaSls = null;

   String [] sPerf = null;
   String [] sMissed = null;

   String [] sTyTemp = null;
   String [] sLyTemp = null;
   String [] sVaTemp = null;

   String [] sMonArr = new String[]{"April", "May", "June", "July", "August", "September", "October", "November", "December", "January", "February", "March"};
%>

<html>
<head>

<style>
  body {background:cornsilk;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  table.DataTable { text-align:center;}
  th.DataTable { background:#FFCC99;
                 padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 text-align:center; font-family:Verdanda; font-size:12px }
  th.DataTable1 { background:#FFCC99; text-align:center; font-family:Verdanda; font-size:12px }
  th.DataTable2 { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                 text-align:center; font-family:Verdanda; font-size:12px }
  th.DataTable3 { background:salmon; padding-top:3px; padding-bottom:3px;
                 text-align:center; font-family:Verdanda; font-size:12px }
  th.DataTable4 { background:#FFCC99; text-align:center; font-family:Verdanda; font-size:10px }
  th.DataTable5 { background:salmon; text-align:center; font-family:Verdanda; font-size:10px }

  tr.DataTable { background:#efefef; font-family:Arial; font-size:10px }
  tr.DataTable1 { background:cornsilk; font-family:Arial; font-size:10px }
  tr.DataTable2 { background:#ccffcc; font-family:Arial; font-size:10px }
  tr.DataTable3 { background:grey; color:white; font-family:Arial; font-size:10px }

  tr.Divider{ background:darkred; font-size:1px }

  td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}
  td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;}
  td.DataTable1d { border-bottom:blue solid  1px ; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;}
  td.DataTable2{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;
                 font-size:12px; font-weight:bold}
  td.DataTable3d { border-bottom:blue solid 1px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}
  td.DataTable4a { background:#cccfff; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}
  td.DataTable4b { background:grey; color:white; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}

  td.TYCell { background:cornsilk; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}

  div.dvSelect { position:absolute; background-attachment: scroll;
              border: black solid 2px; width:250px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}

  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
  .Small { font-size:10px;}

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Total = false;
var Variance = false;
//--------------- End of Global variables ----------------
//==============================================================================
// initialize value on load
//==============================================================================
function  bodyload()
{
}
//==============================================================================
// set week/totals only
//==============================================================================
function  setWkTot()
{
   Total = !Total;
   var cellw = document.all.cellWeek;
   var cellv = document.all.cellVar;
   var cellm = document.all.thWeek;

   var disp = "block";
   if(Total){ disp = "none"; }

   for(var i=0; i < cellw.length; i++)
   {
      cellw[i].style.display=disp;
   }
   for(var i=0; i < cellv.length; i++)
   {
      cellv[i].style.display=disp;
   }

   for(var i=0; i < cellm.length; i++)
   {
      cellm[i].style.display=disp;
   }
   if(Total){ document.all.lnkVar.style.display="none"; }
   else
   {
      var cellw = document.all.cellWeek;
      var cellv = document.all.cellVar;
      var cellm = document.all.thWeek;
      var disp = "block";
      for(var i=0; i < cellv.length; i++) { cellv[i].style.display=disp; }
      for(var i=0; i < cellm.length; i++) { if(cellm[i].colSpan == 2){ cellm[i].colSpan = 3;} }
      Variance = false;
      document.all.lnkVar.style.display="inline";
   }
}
//==============================================================================
// set week/totals only
//==============================================================================
function  setVar()
{
   Variance = !Variance;
   var cellw = document.all.cellWeek;
   var cellv = document.all.cellVar;
   var cellm = document.all.thWeek;

   var disp = "block";
   if(Variance){ disp = "none"; }

   for(var i=0; i < cellv.length; i++)
   {
      cellv[i].style.display=disp;
   }

   for(var i=0; i < cellm.length; i++)
   {
     if(cellm[i].colSpan == 3) { cellm[i].colSpan = 2; }
     else if(cellm[i].colSpan == 2){ cellm[i].colSpan = 3; }
   }
}
</SCRIPT>


</head>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<body onload="bodyload()">
<!-------------------------------------------------------------------->
<div style="clear: both; overflow: AUTO; width: 100%; height: 100%; POSITION: relative; color:black;">

 <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
   <tr style="z-index: 60; position: relative; top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);">
      <td ALIGN="left" bgcolor="cornsilk" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Weekly Headcount Report
      <br>
          <%if(!sFrom.equals("NONE")){%>Weekending dates: <%=sFrom%> - <%=sTo%><%}
            else {%>Fiscal Month: <%=sYear%>/<%=sMonArr[Integer.parseInt(sMonth)-1]%><%}%>
      <br>

     <tr style="z-index: 60; position: relative; top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);">
      <td ALIGN="left"  bgcolor="cornsilk" VALIGN="TOP">
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="HeadCountWkSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;
      <a href="javascript: setWkTot()">Weeks/Total Only</a>&nbsp; &nbsp; &nbsp;
      <a href="javascript: setVar()" id="lnkVar">Hide/Show Var</a>
      </td>
   </tr>
   <tr>
      <td ALIGN="left"  bgcolor="cornsilk" VALIGN="TOP">
<!-------------------------------------------------------------------->
  <!----------------- beginning of table ------------------------>
  <table class="DataTable" border=1 cellPadding="0" cellSpacing="0">
    <tr style="z-index: 60; position: relative; top: expression(this.offsetParent.scrollTop - 3);">
      <th class="DataTable">Store</th>
      <th class="DataTable">Type</th>
      <%for(int i=0; i < iNumOfWk; i++){%>
         <th class="DataTable1" id="cellWeek">&nbsp;</th>
         <th class="DataTable" id="thWeek" colspan="3"><%=sMonNm[i]%><br>Wk <%=sWeek[i]%></th>
      <%}%>
      <th class="DataTable1">&nbsp;</th>
      <th class="DataTable" colspan="3">Total</th>
    </tr>
    <tr style="z-index: 60; position: relative; top: expression(this.offsetParent.scrollTop - 3);">
      <th class="DataTable1">&nbsp;</th>
      <th class="DataTable1">&nbsp;</th>
      <%for(int i=0; i < iNumOfWk; i++){%>
        <th class="DataTable1" id="cellWeek">&nbsp;</th>
        <th class="DataTable" id="thWeek">TY</th>
        <th class="DataTable" id="thWeek">LY</th>
        <th class="DataTable" id="cellVar">Var</th>
      <%}%>
      <th class="DataTable1">&nbsp;</th>
      <th class="DataTable">TY</th>
      <th class="DataTable">LY</th>
      <th class="DataTable">Var</th>
    </tr>
<!--------------------------------- store ----------------------------->
    <%
      for(int i=0; i < iNumOfStr; i++)
      {
          hcweek.setConvLst();
          sTyTraf = hcweek.getTyTraf();
          sTyTran = hcweek.getTyTran();
          sTyConv = hcweek.getTyConv();
          sTyAsp = hcweek.getTyAsp();
          sTySls = hcweek.getTySls();
          sLyTraf = hcweek.getLyTraf();
          sLyTran = hcweek.getLyTran();
          sLyConv = hcweek.getLyConv();
          sLyAsp = hcweek.getLyAsp();
          sLySls = hcweek.getLySls();

          sVaTraf = hcweek.getVaTraf();
          sVaTran = hcweek.getVaTran();
          sVaConv = hcweek.getVaConv();
          sVaAsp = hcweek.getVaAsp();
          sVaSls = hcweek.getVaSls();

          sPerf = hcweek.getPerf();
          sMissed = hcweek.getMissed();
          sTyTemp = hcweek.getTyTemp();
          sLyTemp = hcweek.getLyTemp();
          sVaTemp = hcweek.getVaTemp();

          String [] sCssCls = new String [iNumOfWk + 1];
          for(int j=0; j < iNumOfWk + 1; j++)
          {
             sCssCls[j] = "DataTable";
             if(sMissed[j].equals("Y") && !sTyTraf[j].equals("0") && !sLyTraf[j].equals("0")){ sCssCls[j] += "4a"; }
             else if(sMissed[j].equals("Y") && (sTyTraf[j].equals("0") || sLyTraf[j].equals("0"))){ sCssCls[j] += "4b"; }

          }
    %>
          <tr class="DataTable">
            <td class="DataTable1" nowrap rowspan=7><%=sStr[i]%></td>
            <td class="DataTable1" nowrap>Sales</td>
            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <th class="DataTable1" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> rowspan=7>&nbsp;</th>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap>$<%=sTySls[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap>$<%=sLySls[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap><%=sVaSls[j]%>%</td>
            <%}%>
          </tr>

          <tr class="DataTable">
            <td class="DataTable1" nowrap>Traffic</td>
            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <td class="<%=sCssCls[j]%>" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sTyTraf[j]%></td>
                <td class="<%=sCssCls[j]%>" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sLyTraf[j]%></td>
                <td class="<%=sCssCls[j]%>" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap><%=sVaTraf[j]%>%</td>
            <%}%>
          </tr>
          <tr class="DataTable">
            <td class="DataTable1" nowrap>Transaction</td>
            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sTyTran[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sLyTran[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap><%=sVaTran[j]%>%</td>
            <%}%>
          </tr>
          <tr class="DataTable">
            <td class="DataTable1" nowrap>Conversion</td>
            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sTyConv[j]%>%</td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sLyConv[j]%>%</td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap><%=sVaConv[j]%>%</td>
            <%}%>
          </tr>

          <tr class="DataTable">
            <td class="DataTable1" nowrap>ASP</td>
            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap>$<%=sTyAsp[j]%>%</td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap>$<%=sLyAsp[j]%>%</td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap>$<%=sVaAsp[j]%>%</td>
            <%}%>
          </tr>

          <tr class="DataTable">
            <td class="DataTable1" nowrap>Performance vs. Opportunity</td>
            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap>&nbsp;</td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap>&nbsp;</td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap><%=sPerf[j]%>%</td>
            <%}%>
          </tr>

          <tr class="DataTable">
            <td class="DataTable1" nowrap>Temperature</td>
            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sTyTemp[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sLyTemp[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap>&nbsp;<%=sVaTemp[j]%></td>
            <%}%>
          </tr>

          <tr style="background:darkred;font-size:1px"><td colspan=<%=(iNumOfWk +1) * 4 + 2%>>&nbsp;</td></tr>
          <%if(sStr.equals("99999")){%>
            <tr style="background:darkred;font-size:1px"><td colspan=<%=(iNumOfWk +1) * 4 + 2%>>&nbsp;</td></tr>
            <tr style="background:darkred;font-size:1px"><td colspan=<%=(iNumOfWk +1) * 4 + 2%>>&nbsp;</td></tr>
          <%}%>
       <%}%>

    <!-- =================== Report Totals ===================================== -->
    <%
          hcweek.setConvLst();
          sTyTraf = hcweek.getTyTraf();
          sTyTran = hcweek.getTyTran();
          sTyConv = hcweek.getTyConv();
          sTyAsp = hcweek.getTyAsp();
          sTySls = hcweek.getTySls();
          sLyTraf = hcweek.getLyTraf();
          sLyTran = hcweek.getLyTran();
          sLyConv = hcweek.getLyConv();
          sLyAsp = hcweek.getLyAsp();
          sLySls = hcweek.getLySls();

          sVaTraf = hcweek.getVaTraf();
          sVaTran = hcweek.getVaTran();
          sVaConv = hcweek.getVaConv();
          sVaAsp = hcweek.getVaAsp();
          sVaSls = hcweek.getVaSls();

          sPerf = hcweek.getPerf();
          sMissed = hcweek.getMissed();

          sTyTemp = hcweek.getTyTemp();
          sLyTemp = hcweek.getLyTemp();
          sVaTemp = hcweek.getVaTemp();
    %>
          <tr class="DataTable1">
            <td class="DataTable1" nowrap rowspan=7>Total</td>
            <td class="DataTable1" nowrap>Sales</td>

            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <th class="DataTable1" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> rowspan=7>&nbsp;</th>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap>$<%=sTySls[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap>$<%=sLySls[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap>$<%=sVaSls[j]%>%</td>
            <%}%>
          </tr>

          <tr class="DataTable1">
            <td class="DataTable1" nowrap>Traffic</td>
            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sTyTraf[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sLyTraf[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap><%=sVaTraf[j]%>%</td>
            <%}%>
          </tr>
          <tr class="DataTable1">
            <td class="DataTable1" nowrap>Transaction</td>
            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sTyTran[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sLyTran[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap><%=sVaTran[j]%>%</td>
            <%}%>
          </tr>
          <tr class="DataTable1">
            <td class="DataTable1" nowrap>Conversion</td>
            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sTyConv[j]%>%</td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sLyConv[j]%>%</td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap><%=sVaConv[j]%>%</td>
            <%}%>
          </tr>
          <tr class="DataTable1">
            <td class="DataTable1" nowrap>ASP</td>
            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap>$<%=sTyAsp[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap>$<%=sLyAsp[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap>$<%=sVaAsp[j]%>%</td>
            <%}%>
          </tr>

          <tr class="DataTable1">
            <td class="DataTable1" nowrap>Performance vs. Opportunity</td>
            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap>&nbsp;</td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap>&nbsp;</td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap>$<%=sPerf[j]%>%</td>
            <%}%>
          </tr>

          <tr class="DataTable1">
            <td class="DataTable1" nowrap>Temperature</td>
            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sTyTemp[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sLyTemp[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap>&nbsp;<%=sVaTemp[j]%></td>
            <%}%>
          </tr>

 </table>
 <!----------------------- end of table ------------------------>
   </table>
  </div>
 </body>
</html>
<%hcweek.disconnect();
%>
<%}%>