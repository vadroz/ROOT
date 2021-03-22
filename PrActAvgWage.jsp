<%@ page import="java.util.*, java.text.*, payrollreports.PrActAvgWage"%>
<%
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");
   String sShow = request.getParameter("Show");
   String sUser = session.getAttribute("USER").toString();

   String sAppl = "PAYROLL";

if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
 && !session.getAttribute("APPLICATION").equals(sAppl))
{
   response.sendRedirect("SignOn1.jsp?TARGET=PrActAvgWage.jsp&APPL=" + sAppl + "&" + request.getQueryString());
}
else
{
    PrActAvgWage actavg = new PrActAvgWage(sFrom, sTo, sUser);
    int iNumOfStr = actavg.getNumOfStr();
    String [] sStr = actavg.getStr();

    int iNumOfGrpBdg = actavg.getNumOfGrpBdg();
    String [] sSecBdg = actavg.getSecBdg();
    String [] sSecBdgNm = actavg.getSecBdgNm();
    String [] sGrpBdg = actavg.getGrpBdg();
    String [] sGrpBdgName = actavg.getGrpBdgName();

    String [] sActPayHrs = null;
    String [] sActPayAmt = null;
    String [] sActPayAvg = null;
    String [] sActPayPrc = null;
%>

<style>body {background:ivory;font-family: Verdanda}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}
                 a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}
                       a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }

        tr.DataTable { background: white; font-size:12px }
        tr.Divdr1 { background: darkred; font-size:1px }
        tr.DataTable2 { background: #ccccff; font-size:12px }
        tr.DataTable3 { background: #ccffcc; font-size:12px }
        tr.DataTable31 { background: #ffff99; font-size:12px }
        tr.DataTable32 { background: gold; font-size:10px }
        tr.DataTable33 { background: white; font-size:12px }
        tr.DataTable4 { color:Maroon; background: Khaki; font-size:12px }
        tr.DataTable5 { background: cornsilk; font-size:12px }


        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left;}
        td.DataTable11 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; font-weight:bold;font-size:12px }
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvSelWk { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:middle; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

        #tdAmt { display: none; }
        #tdAvg { display: none; }
        #tdPrc { display: none; }

</style>
<html>
<head><Meta http-equiv="refresh"></head>

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variables
//==============================================================================
var Show = "<%=sShow%>";
//==============================================================================
// initializing process
//==============================================================================
function bodyLoad()
{
   dispSelWk();
   if(Show == "Hrs") { dispCols(0); }
   if(Show == "Dlr") { dispCols(1); }
   if(Show == "Avg") { dispCols(2); }
   if(Show == "Prc") { dispCols(3); }
   setBoxclasses(["BoxName",  "BoxClose"], ["dvSelWk"]);
}
//==============================================================================
// populate week selection
//==============================================================================
function dispSelWk()
{

  var hdr = "Select Another Week";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popSelWk()

   html += "</td></tr></table>"

   document.all.dvSelWk.innerHTML = html;
   document.all.dvSelWk.style.pixelLeft= 1;
   document.all.dvSelWk.style.pixelTop= 1;
   document.all.dvSelWk.style.visibility = "visible";

   setSelWeek();
   setFrom_To_Dates();

   for(var i=0; i < document.all.td2Dates.length; i++){ document.all.td2Dates[i].style.display = "none"}
}
//--------------------------------------------------------
// populate Column Panel
//--------------------------------------------------------
function popSelWk()
{
  var panel = "<table border=0 cellPadding=0 cellSpacing=0>"
    + "<tr>"
       + "<td class='Prompt1' id='td1Date'>Week:</td>"
       + "<td class='Prompt1' id='td1Date' colspan=2><select name='selWeek' class='Small'></select>"
    + "</tr>"
    + "<tr>"
       + "<td class='Prompt1' id='td2Dates'>From:</td>"
       + "<td class='Prompt1' id='td2Dates'><input name='FrDate' class='Small' readonly></td>"
       + "<td class='Prompt1' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 255, 10, document.all.FrDate)'>"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
    + "</tr>"
    + "<tr>"
       + "<td class='Prompt1' id='td2Dates'>To:</td>"
       + "<td class='Prompt1' id='td2Dates'><input name='ToDate' class='Small' readonly></td>"
       + "<td class='Prompt1' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 255, 10, document.all.ToDate)'>"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
     + "</tr>"
  panel += "<tr><td class='Prompt1' colspan=3>"
        + "<button onClick='showAnotherWk()' class='Small'>Submit</button> &nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
        + "<button onClick='toggleDates()' class='Small'>Toggle Dates</button></td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// toggle between date options
//==============================================================================
function toggleDates()
{
  var oneday = "none";
  var twoday = "block";

  if(document.all.td2Dates[0].style.display == "block"){  oneday = "block";   twoday = "none"; }

  for(var i=0; i < document.all.td1Date.length; i++){ document.all.td1Date[i].style.display = oneday; }
  for(var i=0; i < document.all.td2Dates.length; i++){ document.all.td2Dates[i].style.display = twoday; }
}
//==============================================================================
// set weeks in dropdown menu
//==============================================================================
function setSelWeek()
{
   var date = new Date(new Date() - 86400000);
   date.setHours(18);
   if(date.getDay() > 0)
   {
     date = new Date(date - 86400000 * date.getDay());
     date = new Date(date - 86400000 * (-7));
   }


   for(var i=0; i < 15; i++)
   {
       cvtDt = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
       document.all.selWeek.options[i] = new Option(cvtDt, cvtDt);
       date = new Date(date - 86400000 * 7);
   }
}
//==============================================================================
// set From and to dates
//==============================================================================
function setFrom_To_Dates()
{
   var date = new Date(new Date() - 86400000);
   var cvtDt = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
   document.all.FrDate.value = cvtDt;
   document.all.ToDate.value = cvtDt;
}
//==============================================================================
// siplay selected Columns
//==============================================================================
function showAnotherWk()
{
   var week = document.all.selWeek.options[document.all.selWeek.selectedIndex].value;
   var frdate = document.all.FrDate.value.trim();
   var todate = document.all.ToDate.value.trim();

   var error = false;
   var msg = "";

   var url = "PrActAvgWage.jsp?"

   if(document.all.td2Dates[0].style.display != "block")
   {
     url += "From=BEGWEEK&To=" + week
   }
   else
   {
      if(frdate=="" || todate ==""){ error = true; msg="From or(and) To dates are not selected." }
      else { url += "From=" + frdate + "&To=" + todate; }
   }

   if(document.all.FldSel[0].checked) { url += "&Show=Hrs" }
   else if(document.all.FldSel[1].checked) { url += "&Show=Dlr" }
   else if(document.all.FldSel[2].checked) { url += "&Show=Avg" }
   else if(document.all.FldSel[3].checked) { url += "&Show=Prc" }

   if(error){ alert(msg); }
   else { window.location.href = url; }
}
//==============================================================================
// siplay selected Columns
//==============================================================================
function dispCols(arg)
{
   var col = new Array(4);
   col[0] = document.all.tdHrs;
   col[1] = document.all.tdAmt;
   col[2] = document.all.tdAvg;
   col[3] = document.all.tdPrc;

   var obj = document.all.FldSel[arg];

   for(var i=0; i < col.length; i++)
   {
      if(obj.value != i)
      {
         for(var j=0; j < col[i].length; j++) { col[i][j].style.display="none"; }
      }
      else
      {
         for(var j=0; j < col[i].length; j++) { col[i][j].style.display="block";}
      }
   }

   if(arg==0){ document.all.spnRepName.innerHTML = "Hours" }
   else if(arg==1){ document.all.spnRepName.innerHTML = "Dollars" }
   else if(arg==2){ document.all.spnRepName.innerHTML = "Average Rates" }
   else if(arg==3){ document.all.spnRepName.innerHTML = "Percents" }
}

//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvSelWk.innerHTML = " ";
   document.all.dvSelWk.style.visibility = "hidden";
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>



<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvSelWk" class="dvSelWk"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="ivory">
      <td ALIGN="center" VALIGN="TOP" colspan=3>
      <b>Retail Concepts Inc.
      <br>Actual Payroll by Position&nbsp;
          <span id="spnRepName">
            <%if(sShow.equals("Hrs")){%>Hours<%}
            else if(sShow.equals("Dlr")){%>Dollars<%}
            else if(sShow.equals("Avg")){%>Average Rates<%}
            else if(sShow.equals("Prc")){%>Percents<%}%>
          </span>
      <br>Weekending:  <%if(sFrom.equals("BEGWEEK")){%>Weekending date: <%=sTo%><%}
          else {%>From <%=sFrom%> &nbsp; To <%=sTo%><%}%>
      </b>

      <br><br><a href="../" class="small"><font color="red">Home</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 cellPadding="0" cellSpacing="0" >
        <tr>
          <th class="DataTable" rowspan=2>Budget Groups</th>
          <th class="DataTable" colspan="<%=(iNumOfStr + 1)%>">Stores
             <div style="background: cornsilk; width:500px; font-size:10px; border:1px solid black">
                Select Displaying Columns: &nbsp;
                <input type="radio" name="FldSel" value="0" onClick="dispCols('0')" <%if(sShow.equals("Hrs")){%>checked<%}%>>Hours &nbsp; &nbsp;
                <input type="radio" name="FldSel" value="1" onClick="dispCols('1')" <%if(sShow.equals("Dlr")){%>checked<%}%>>Dollars &nbsp; &nbsp;
                <input type="radio" name="FldSel" value="2" onClick="dispCols('2')" <%if(sShow.equals("Avg")){%>checked<%}%>>Average Rate &nbsp; &nbsp;
                <input type="radio" name="FldSel" value="3" onClick="dispCols('3')" <%if(sShow.equals("Prc")){%>checked<%}%>>Percents &nbsp; &nbsp;
             </div>
          </th>
        </tr>
        <tr>
          <%for(int i=0; i < iNumOfStr; i++){%><th class="DataTable"><%=sStr[i]%></th><%}%>
          <th class="DataTable">Total</th>
        </tr>
     <!------------------------- Budget Group --------------------------------------->
     <%
        String sSvBdgSec = "";

        for(int i=0; i < iNumOfGrpBdg; i++){%>
     <%
           actavg.setActPay(sGrpBdg[i]);
           sActPayHrs = actavg.getActPayHrs();
           sActPayAmt = actavg.getActPayAmt();
           sActPayAvg = actavg.getActPayAvg();
           sActPayPrc = actavg.getActPayPrc();
     %>
        <!-- Section Name -->
        <%if(!sSvBdgSec.equals(sSecBdg[i])){%>
            <tr class="DataTable2" id="thSecNm">
              <td class="DataTable11" colspan="<%=(iNumOfStr + 2)%>"><%=sSecBdgNm[i]%></td>
            </tr>
            <%sSvBdgSec = sSecBdg[i];%>
        <%}%>

        <!-- Store Details -->

        <tr class="DataTable" <%if(sSecBdg[i].equals("1")){%>style="display:none;"<%}%>>
          <td class="DataTable11" nowrap> &nbsp; &nbsp; &nbsp;<%=sGrpBdgName[i]%></th>

          <%for(int j=0; j < iNumOfStr + 1; j++){%>
              <td class="DataTable2" id="tdHrs" nowrap><%if(!sActPayHrs[j].equals("0")){%><%=sActPayHrs[j]%><%} else{%>&nbsp;<%}%></td>
              <td class="DataTable2" id="tdAmt" nowrap><%if(!sActPayAmt[j].equals("0")){%>$<%=sActPayAmt[j]%><%} else{%>&nbsp;<%}%></td>
              <td class="DataTable2" id="tdAvg" nowrap><%if(!sActPayAvg[j].equals(".00")){%>$<%=sActPayAvg[j]%><%} else{%>&nbsp;<%}%></td>
              <td class="DataTable2" id="tdPrc" nowrap><%if(!sActPayPrc[j].equals(".00")){%><%=sActPayPrc[j]%>%<%} else{%>&nbsp;<%}%></td>
          <%}%>
        </tr>

        <!--------------- Level Break on Section --------------------->
        <%if( i+1 == iNumOfGrpBdg || !sSvBdgSec.equals(sSecBdg[i + 1])){%>
        <%
           actavg.setSecTot(sSecBdg[i]);
           sActPayHrs = actavg.getActPayHrs();
           sActPayAmt = actavg.getActPayAmt();
           sActPayAvg = actavg.getActPayAvg();
           sActPayPrc = actavg.getActPayPrc();
        %>
             <tr class="DataTable3">
               <td class="DataTable11" nowrap>Subtotal</td>
                 <%for(int j=0; j < iNumOfStr + 1; j++){%>
                    <td class="DataTable2" id="tdHrs" nowrap><%if(!sActPayHrs[j].equals("0")){%><%=sActPayHrs[j]%><%} else{%>&nbsp;<%}%></td>
                    <td class="DataTable2" id="tdAmt" nowrap><%if(!sActPayAmt[j].equals("0")){%>$<%=sActPayAmt[j]%><%} else{%>&nbsp;<%}%></td>
                    <td class="DataTable2" id="tdAvg" nowrap><%if(!sActPayAvg[j].equals(".00")){%>$<%=sActPayAvg[j]%><%} else{%>&nbsp;<%}%></td>
                    <td class="DataTable2" id="tdPrc" nowrap><%if(!sActPayPrc[j].equals(".00")){%><%=sActPayPrc[j]%>%<%} else{%>&nbsp;<%}%></td>
                 <%}%>
                </td>
             </tr>
            <tr class="Divdr1"></td><td colspan=<%=iNumOfStr + 2%>>&nbsp;</td></tr>
         <%}%>
     <%}%>
     <!------------------------- Hourly Sub Total ----------------------------->
     <%
        actavg.setHourlyTot();
        sActPayHrs = actavg.getActPayHrs();
        sActPayAmt = actavg.getActPayAmt();
        sActPayAvg = actavg.getActPayAvg();
        sActPayPrc = actavg.getActPayPrc();
     %>
     <tr class="Divdr1"></td><td colspan=<%=iNumOfStr + 2%>>&nbsp;</td></tr>
     <tr class="DataTable5">
       <td class="DataTable11" nowrap>Hourly Subtotal</td>
         <%for(int j=0; j < iNumOfStr + 1; j++){%>
             <td class="DataTable2" id="tdHrs" nowrap><%if(!sActPayHrs[j].equals("0")){%><%=sActPayHrs[j]%><%} else{%>&nbsp;<%}%></td>
             <td class="DataTable2" id="tdAmt" nowrap><%if(!sActPayAmt[j].equals("0")){%>$<%=sActPayAmt[j]%><%} else{%>&nbsp;<%}%></td>
             <td class="DataTable2" id="tdAvg" nowrap><%if(!sActPayAvg[j].equals(".00")){%>$<%=sActPayAvg[j]%><%} else{%>&nbsp;<%}%></td>
             <td class="DataTable2" id="tdPrc" nowrap><%if(!sActPayPrc[j].equals(".00")){%><%=sActPayPrc[j]%>%<%} else{%>&nbsp;<%}%></td>
        <%}%>
     </tr>
     <!------------------------- TY Report Total --------------------------------->
     <%
        actavg.setRepTot(true);
        sActPayHrs = actavg.getActPayHrs();
        sActPayAmt = actavg.getActPayAmt();
        sActPayAvg = actavg.getActPayAvg();
        sActPayPrc = actavg.getActPayPrc();
     %>
     <tr class="Divdr1"></td><td colspan=<%=iNumOfStr + 2%>>&nbsp;</td></tr>
     <tr class="Divdr1"></td><td colspan=<%=iNumOfStr + 2%>>&nbsp;</td></tr>
     <tr class="DataTable5">
       <td class="DataTable11" nowrap>Grand Total</td>
         <%for(int j=0; j < iNumOfStr + 1; j++){%>
             <td class="DataTable2" id="tdHrs" nowrap><%if(!sActPayHrs[j].equals("0")){%><%=sActPayHrs[j]%><%} else{%>&nbsp;<%}%></td>
             <td class="DataTable2" id="tdAmt" nowrap><%if(!sActPayAmt[j].equals("0")){%>$<%=sActPayAmt[j]%><%} else{%>&nbsp;<%}%></td>
             <td class="DataTable2" id="tdAvg" nowrap><%if(!sActPayAvg[j].equals(".00")){%>$<%=sActPayAvg[j]%><%} else{%>&nbsp;<%}%></td>
             <td class="DataTable2" id="tdPrc" nowrap><%if(!sActPayPrc[j].equals(".00")){%><%=sActPayPrc[j]%>%<%} else{%>&nbsp;<%}%></td>
        <%}%>
     </tr>

     <!------------------------- LY Report Total --------------------------------->
     <%
        actavg.setRepTot(false);
        sActPayHrs = actavg.getActPayHrs();
        sActPayAmt = actavg.getActPayAmt();
        sActPayAvg = actavg.getActPayAvg();
        sActPayPrc = actavg.getActPayPrc();
     %>
     <tr class="Divdr1"></td><td colspan=<%=iNumOfStr + 2%>>&nbsp;</td></tr>
     <tr class="Divdr1"></td><td colspan=<%=iNumOfStr + 2%>>&nbsp;</td></tr>
     <tr class="DataTable5">
       <td class="DataTable11" nowrap>Last Year Grand Total</td>
         <%for(int j=0; j < iNumOfStr + 1; j++){%>
             <td class="DataTable2" id="tdHrs" nowrap><%if(!sActPayHrs[j].equals("0")){%><%=sActPayHrs[j]%><%} else{%>&nbsp;<%}%></td>
             <td class="DataTable2" id="tdAmt" nowrap><%if(!sActPayAmt[j].equals("0")){%>$<%=sActPayAmt[j]%><%} else{%>&nbsp;<%}%></td>
             <td class="DataTable2" id="tdAvg" nowrap><%if(!sActPayAvg[j].equals(".00")){%>$<%=sActPayAvg[j]%><%} else{%>&nbsp;<%}%></td>
             <td class="DataTable2" id="tdPrc" nowrap><%if(!sActPayPrc[j].equals(".00")){%><%=sActPayPrc[j]%>%<%} else{%>&nbsp;<%}%></td>
        <%}%>
     </tr>

   </table>
   <!----------------------- end of table ---------------------------------->

  </table>
 </body>

</html>
<%actavg.disconnect();%>

<%}%>






