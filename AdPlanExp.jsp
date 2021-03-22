<%@ page import="advertising.AdPlanExp, java.util.*, java.text.*"%>
<%
   String [] sMarket = request.getParameterValues("Mrk");
   String [] sMedia = request.getParameterValues("Med");
   String [] sSelType = request.getParameterValues("Type");
   String sFrom = request.getParameter("FrWeek");
   String sTo = request.getParameter("ToWeek");
   String sYear = request.getParameter("Year");
   String sMonth = request.getParameter("Month");
   String sMissOpt = request.getParameter("MissOpt");
   String sSort = request.getParameter("Sort");

   if(sSort == null){sSort = "MARKET";}

if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=AdPlanExp.jsp?" + request.getQueryString());
}
else
{
   String sUser = session.getAttribute("USER").toString();

   AdPlanExp adexp = new AdPlanExp(sMarket, sMedia, sSelType, sFrom, sTo, sYear, sMonth
                                 , sMissOpt, sSort, sUser);

   int iNumOfWk = adexp.getNumOfWk();
   String [] sTyWeek = adexp.getTyWeek();
   String [] sLyWeek = adexp.getLyWeek();
   String [] sMonNm = adexp.getMonNm();
    String [] sWeek = adexp.getWeek();

   int iNumOfExp = adexp.getNumOfExp();
   int iNumOfRow = adexp.getNumOfRow();
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

   String [] sTySpnP = null;
   String [] sLySpnP = null;
   String [] sVaSpnP = null;

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
  tr.Divider{ background:darkred; font-size:1px }

  td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}
  td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;}
  td.DataTable1d { border-bottom:blue solid  1px ; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;}
  td.DataTable2{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;
                 font-size:12px; font-weight:bold}

  td.DataTable3d { border-bottom:blue solid 1px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}

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
      <br>Weekly Ad Spend
      <br>
          <%if(!sFrom.equals("NONE")){%>Weekending dates: <%=sFrom%> - <%=sTo%><%}
            else {%>Fiscal Month: <%=sYear%>/<%=sMonArr[Integer.parseInt(sMonth)-1]%><%}%>
      <br>

     <tr style="z-index: 60; position: relative; top: expression(this.offsetParent.scrollTop); left: expression(this.offsetParent.scrollLeft);">
      <td ALIGN="left"  bgcolor="cornsilk" VALIGN="TOP">
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="AdPlanExpSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
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
      <th class="DataTable">Market</th>
      <th class="DataTable">Media</th>
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
<!--------------------------------- Group Totals ----------------------------->
    <%boolean bRow = false;
      String sSvMrk = null;
      boolean bMrk = true;
      boolean bColor = false;
      for(int i=0; i < iNumOfExp; i++)
      {
        adexp.setExpLst();
        String sMrk = adexp.getMrk();
        String sMed = adexp.getMed();
        String sType = adexp.getType();
        String [] sTyAmt = adexp.getTyAmt();
        String [] sLyAmt = adexp.getLyAmt();
        String [] sVarAmt = adexp.getVarAmt();

        if(sSvMrk == null){sSvMrk = sMrk;}

        // level break on market
        if(!sMrk.equals(sSvMrk))
        {
          adexp.setConvLst();
          sTyTraf = adexp.getTyTraf();
          sTyTran = adexp.getTyTran();
          sTyConv = adexp.getTyConv();
          sTyAsp = adexp.getTyAsp();
          sTySls = adexp.getTySls();
          sLyTraf = adexp.getLyTraf();
          sLyTran = adexp.getLyTran();
          sLyConv = adexp.getLyConv();
          sLyAsp = adexp.getLyAsp();
          sLySls = adexp.getLySls();

          sVaTraf = adexp.getVaTraf();
          sVaTran = adexp.getVaTran();
          sVaConv = adexp.getVaConv();
          sVaAsp = adexp.getVaAsp();
          sVaSls = adexp.getVaSls();

          sTySpnP = adexp.getTySpnP();
          sLySpnP = adexp.getLySpnP();
          sVaSpnP = adexp.getVaSpnP();

          sTyTemp = adexp.getTyTemp();
          sLyTemp = adexp.getLyTemp();
          sVaTemp = adexp.getVaTemp();

          sSvMrk = sMrk;
          bMrk = true;
        }
    %>
    <!-- =================== Totals ===================================== -->
       <%if(i > 0 && bMrk){%>
          <tr class="DataTable1">
            <td class="DataTable1" nowrap>Sales</td>
            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <th class="DataTable1" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> rowspan=7>&nbsp;</th>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap>$<%=sTySls[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap>$<%=sLySls[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap><%=sVaSls[j]%>%</td>
            <%}%>
          </tr>

          <tr class="DataTable1">
            <td class="DataTable1" nowrap>Total Ad Spend % of Sales</td>
            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sTySpnP[j]%>%</td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sLySpnP[j]%>%</td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap><%=sVaSpnP[j]%>%</td>
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
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap><%=sVaAsp[j]%>%</td>
            <%}%>
          </tr>

          <tr class="DataTable1">
            <td class="DataTable1" nowrap>Temperature</td>
            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sTyTemp[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sLyTemp[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap><%=sVaTemp[j]%></td>
            <%}%>
          </tr>

          <%if(sMrk.equals("TOTAL")){%>
            <tr style="background:darkred;font-size:1px"><td colspan=<%=(iNumOfWk +1) * 4 + 2%>>&nbsp;</td></tr>
            <tr style="background:darkred;font-size:1px"><td colspan=<%=(iNumOfWk +1) * 4 + 2%>>&nbsp;</td></tr>
            <tr style="background:darkred;font-size:1px"><td colspan=<%=(iNumOfWk +1) * 4 + 2%>>&nbsp;</td></tr>
          <%}%>
       <%}%>

    <!-- =================== Details ===================================== -->
       <%if(bMrk){%>
           <tr style="background:darkred;font-size:1px"><td colspan=<%=(iNumOfWk +1) * 4 + 2%>>&nbsp;</td></tr>
       <%}%>
       <tr class="DataTable<%if(sMed.equals("TOTAL")){%>1<%} else if(bColor){%>2<%}%><%bRow = !bRow;%>">
         <%
           if(sType.equals("Gross Spend")){ bColor = !bColor; }
           else if(sType.equals("TOTAL")){ bColor = false; }
         %>
         <%if(bMrk){%>
             <td class="DataTable1" style="background:<%if(sMrk.equals("TOTAL")){%>lightsalmon<%} else {%>khaki;<%}%> font-size:12px;"
                nowrap rowspan="<%=iNumOfRow + 8%>"><%=sMrk%>
             </td>
             <%bMrk = false;%>
         <%}%>

         <td class="DataTable1<%if(sMed.equals("TOTAL")){%>d<%}%>" nowrap><%if(sMed.equals("TOTAL")){%>Total Ad Spend<%} else {%><%=sMed%><%}%><%if(!sMed.equals("TOTAL") && !sType.equals("TOTAL")){%> - <%=sType%><%}%></td>
         <%for(int j=0; j < iNumOfWk + 1; j++){%>
            <th class="DataTable1" <%if(j < iNumOfWk){%>id="cellWeek"<%}%>>&nbsp;</th>
            <td class="DataTable<%if(sMed.equals("TOTAL")){%>3d<%}%>" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap>$<%=sTyAmt[j]%></td>
            <td class="DataTable<%if(sMed.equals("TOTAL")){%>3d<%}%>" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap>$<%=sLyAmt[j]%></td>
            <td class="DataTable<%if(sMed.equals("TOTAL")){%>3d<%}%>" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap><%=sVarAmt[j]%>%</td>
         <%}%>
       </tr>
    <%}%>


    <!-- =================== Report Totals ===================================== -->
    <%
          adexp.setConvLst();
          sTyTraf = adexp.getTyTraf();
          sTyTran = adexp.getTyTran();
          sTyConv = adexp.getTyConv();
          sTyAsp = adexp.getTyAsp();
          sTySls = adexp.getTySls();
          sLyTraf = adexp.getLyTraf();
          sLyTran = adexp.getLyTran();
          sLyConv = adexp.getLyConv();
          sLyAsp = adexp.getLyAsp();
          sLySls = adexp.getLySls();

          sVaTraf = adexp.getVaTraf();
          sVaTran = adexp.getVaTran();
          sVaConv = adexp.getVaConv();
          sVaAsp = adexp.getVaAsp();
          sVaSls = adexp.getVaSls();

          sTySpnP = adexp.getTySpnP();
          sLySpnP = adexp.getLySpnP();
          sVaSpnP = adexp.getVaSpnP();

          sTyTemp = adexp.getTyTemp();
          sLyTemp = adexp.getLyTemp();
          sVaTemp = adexp.getVaTemp();
    %>
          <tr class="DataTable1">
            <td class="DataTable1" nowrap>Sales</td>
            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <th class="DataTable1" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> rowspan=7>&nbsp;</th>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap>$<%=sTySls[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap>$<%=sLySls[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap>$<%=sVaSls[j]%>%</td>
            <%}%>
          </tr>

          <tr class="DataTable1">
            <td class="DataTable1" nowrap>Total Ad Spend % of Sales</td>
            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sTySpnP[j]%>%</td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sLySpnP[j]%>%</td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap><%=sVaSpnP[j]%>%</td>
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
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap><%=sVaAsp[j]%>%</td>
            <%}%>
          </tr>

          <tr class="DataTable1">
            <td class="DataTable1" nowrap>Temperature</td>
            <%for(int j=0; j < iNumOfWk + 1; j++){%>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sTyTemp[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellWeek"<%}%> nowrap><%=sLyTemp[j]%></td>
                <td class="DataTable" <%if(j < iNumOfWk){%>id="cellVar"<%}%> nowrap><%=sVaTemp[j]%></td>
            <%}%>
          </tr>

 </table>
 <!----------------------- end of table ------------------------>
   </table>
  </div>
 </body>
</html>
<%adexp.disconnect();
%>
<%}%>