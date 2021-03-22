<%@ page import="strempslsrep.EmpSlsPerformSum, java.util.*, rciutility.StoreSelect"%>
<%
   String sFrDate = request.getParameter("FrDate");
   String sToDate = request.getParameter("ToDate");
   String sNotSA = request.getParameter("NotSa");
   String sSort = request.getParameter("Sort");

   if(sSort==null) { sSort="SUMSCRDSC"; }
   if(sFrDate==null) { sFrDate="ONEWEEK"; }
   if(sToDate==null) { sToDate="LASTDATE"; }

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
    response.sendRedirect("SignOn1.jsp?TARGET=EmpSlsPerformSum.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   String sUser = session.getAttribute("USER").toString();
   EmpSlsPerformSum strrank = new EmpSlsPerformSum(sFrDate, sToDate, sSort, sUser);
   int  iNumOfStr = strrank.getNumOfStr();
%>

<html>
<head>

<style>
  body {background:cornsilk;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}

  tr.DataTable { background:#efefef; font-family:Arial; font-size:10px }
  tr.DataTable1 { background:cornsilk; font-family:Arial; font-size:10px }
  tr.Divider{ background:darkred; font-size:1px }

  td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}
  td.DataTable1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;}
  td.DataTable2{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;
                 font-size:12px; font-weight:bold}

  div.dvRange { position:absolute; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
  select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }


</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var DateRange = true;
//--------------- End of Global variables ----------------
<%if (sNotSA == null) {%>
//==============================================================================
// show sales performance for all store
//==============================================================================
function showSlsPerfAllStr()
{
   disp="block";
   if(document.all.tdSlsPerf[6].style.display=="block"){ disp="none"; }

   for(var i=0; i < document.all.tdSlsPerf.length; i++)
   {
      if(i > 5)
      {
          document.all.tdSlsPerf[i].style.display=disp;
      }
   }
}

//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);
  date.setHours(18);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000 * 7);
  else if(direction == "UP") date = new Date(new Date(date) - (-86400000 * 7));
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// switch frome date range to 1 date (WTD/MTD/YTD)
//==============================================================================
function switchDates()
{
  if(DateRange)
  {
    document.all.spnFrom.style.display = "none";
    document.all.btnDate.innerHTML = "Date Range";
  }
  else
  {
     document.all.spnFrom.style.display = "inline";
     document.all.btnDate.innerHTML = "One Date";
  }
  DateRange = !DateRange;
}
//==============================================================================
// submit with diferent date
//==============================================================================
function  sbmEmpPerform()
{
    var frdate = document.all.FrDate.value.trim()
    var todate = document.all.ToDate.value.trim()
    if(!DateRange){ frdate = "ONEWEEK";}

    var url = "EmpSlsPerformSum.jsp?FrDate=" + frdate
      + "&ToDate=" + todate

    window.location.href=url;
}
<%}%>
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

</head>

<body>
<!-- ======================================================================= -->
<div id="dvRange" class="dvRange">
<TABLE width="100%" border=0>
 <tr style='font-size:11px; font-weight:bold; text-align:center'>
   <td >Select Date Range</td>
</tr>
<TR style="font-size:11px;">
  <TD align=center nowrap>
              <span id="spnFrom">From:
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrDate')">&#60;</button>
              <input class="Small" name="FrDate" type="text" size=10 maxlength=10 readonly>
              <button class="Small" name="Up" onClick="setDate('UP', 'FrDate')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 500, 300, document.all.FrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a> &nbsp; &nbsp; &nbsp;
              </span>

              To:
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate')">&#60;</button>
              <input  class="Small" name="ToDate" type="text" size=10 maxlength=10  readonly>
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 800, 300, document.all.ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              <br><button class="Small" id="submit" onClick="sbmEmpPerform()">Submit</button>
               &nbsp; &nbsp; &nbsp;
              <button class="Small" id="btnDate" onClick="switchDates()">One Date</button>
          </TD>
  </TR>
  </table>
</div><br><br>

<!-- ======================================================================= -->

 <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0" id="tbStrSlsPerf">
   <tr>
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Winter Challenge 2013
      <%if (sNotSA == null) {%>
         <br>
         <%if(sFrDate.equals("ONEWEEK")){%>Weekending: <%=sToDate%> <%}
           else {%>Dates: <%=sFrDate%> - <%=sToDate%> <%}%>
         <br>
      <%}%>

      <a href="javascript: showSlsPerfAllStr()">Extend/Collapse</a>
           &nbsp; &nbsp; &nbsp; &nbsp;
           <a href="EmpSlsPerformSum.jsp">Date Selection</a>
      <%if (sNotSA == null) {%>
           &nbsp; &nbsp; &nbsp; &nbsp;
           <a href="index.jsp">Home</a>
      <%}%>

<!-------------------------------------------------------------------->
  <!----------------- beginning of table ------------------------>
  <table class="text-align:center;" border=1 cellPadding="0" cellSpacing="0">
    <tr style="background:#FFCC99;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
        text-align:center; font-family:Verdanda; font-size:12px">

      <th rowspan="2">Place</th>
      <th rowspan="2">Str</th>
      <th rowspan="2">&nbsp;</th>

      <th colspan="2">Sales per Hour</th>
      <th rowspan="2">TY to LY<br>Var</th>
      <th rowspan="2">&nbsp;</th>

      <th colspan="2">Item per Trans</th>
      <th rowspan="2">TY to LY<br>Var</th>
      <th rowspan="2">&nbsp;</th>

      <th rowspan="2">Score<br>Summary</th>
      <th rowspan="2">Rank</th>
    </tr>

    <tr style="background:#FFCC99;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
        text-align:center; font-family:Verdanda; font-size:12px">
      <th>TY</th>
      <th>LY</th>
      <th>TY</th>
      <th>LY</th>
    </tr>
<!------------------------------- Detail Data --------------------------------->
     <%int iPlace = 1;%>
     <%for(int i=0; i < iNumOfStr; i++)
     {
       strrank.setEmpSlsPerformSumance();
       String sStr = strrank.getStr();
       String sStrNm = strrank.getStrNm();
       String sTySls = strrank.getSls();
       String sTyHrs = strrank.getHrs();
       String sTyTrans = strrank.getTyTrans();
       String sTyQty = strrank.getTyQty();
       String sTySlsHr = strrank.getTySlsHr();
       String sTyItmTr = strrank.getTyItmTr();

       String sLySls = strrank.getLySls();
       String sLyHrs = strrank.getLyHrs();
       String sLyTrans = strrank.getLySls();
       String sLyQty = strrank.getLyQty();
       String sLySlsHr = strrank.getLySlsHr();
       String sLyItmTr = strrank.getSlsTr();

       String sVarSlsHr = strrank.getVarSlsHr();
       String sVarItmTr = strrank.getVarItmTr();
       String sVarSum = strrank.getVarSum();

       String sReg = strrank.getReg();
       String sRank = strrank.getRank();
     %>
         <tr style="background:<%if(iPlace <= 3){%>yellow<%} else if(iPlace <= 6){%>silver<%} else {%>white<%}%>;<%if(iPlace > 6){%>display:none;<%}%> font-family:Arial; font-size:10px" id="tdSlsPerf">
           <td nowrap><%=iPlace++%></td>
           <td style="padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;" nowrap><%=sStr%> - <%=sStrNm%></td>
           <th>&nbsp;</th>

           <td style="padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;" nowrap>$<%=sTySlsHr%></td>
           <td style="padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;" nowrap>$<%=sLySlsHr%></td>
           <td style="padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;" nowrap><%=sVarSlsHr%>%</td>
           <th>&nbsp;</th>

           <td style="padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;" nowrap><%=sTyItmTr%></td>
           <td style="padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;" nowrap><%=sLyItmTr%></td>
           <td style="padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;" nowrap><%=sVarItmTr%>%</td>
           <th>&nbsp;</th>

           <td style="padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;" nowrap><%=sVarSum%></td>
           <td style="padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;" nowrap><%=sRank%></td>

        </tr>
     <%}%>
<!-------------------------- end of Detail Totals ----------------------------->
 </table>
 <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%
   strrank.disconnect();
   strrank = null;
%>
<%if (sNotSA != null) {%>
<script language="javascript">
     var html = document.all.tbStrSlsPerf.outerHTML;
     parent.dvStrSlsPef.innerHTML = html;
</script>
<%}
else {%>
<SCRIPT language="JavaScript1.2">
SelDate();
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  SelDate()
{
  var todate = new Date(new Date() - 86400000);
  var dofw = todate.getDay();
  todate = new Date(todate - 86400000 * dofw);
  var frDate = new Date(todate - 86400000 * 6);

  document.all.FrDate.value = (frDate.getMonth()+1) + "/" + frDate.getDate() + "/" + frDate.getFullYear()
  document.all.ToDate.value = (todate.getMonth()+1) + "/" + todate.getDate() + "/" + todate.getFullYear()
}
</script>

<%}%>
<%}%>