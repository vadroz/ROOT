<%@ page import="java.util.*, emptraining.StrTestResult"%>
<%
    String sStore = request.getParameter("Store");
    String sStrName = request.getParameter("StrName");
//------------------------------------------------------------------------------
// Application Authorization
//------------------------------------------------------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("TRAINING") == null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=StrTestResult.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   boolean bChgDate = session.getAttribute("TRNCHGDT") != null ;

   StrTestResult strresult = new StrTestResult(sStore);
   int iNumOfTst = strresult.getNumOfTst();
   int iNumOfGrp = strresult.getNumOfGrp();
   boolean bAllStr = false;
   if (sStore.equals("ALL")) { bAllStr = true; }
%>
<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue;  font-size:12px;} a:visited { color:blue; font-size:12px;}  a:hover { color:blue; font-size:12px;}

  table.DataTable { border: darkred solid 1px; background:#e7e7e7; text-align:center;}
  tr.DataTable { background:#FFCC99; font-family:Verdanda; text-align:center;
                 font-size:12px; font-weight:bold}
  th.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px;}

  tr.DataTable1 { background:#f7f7f7; font-family:Verdanda; text-align:left; font-size:12px;}
  tr.DataTable2 { background:white; font-family:Verdanda; text-align:left; font-size:12px;}
  tr.DataTable3 { background:cornsilk; font-family:Verdanda; text-align:left; font-size:12px; font-weight:bold}
  tr.DataTable4 { background:darkred; font-family:Verdanda; text-align:left; font-size:2px;}
  tr.DataTable5 { background:yellow; font-family:Verdanda; text-align:left; font-size:12px; font-weight:bold}

  td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;text-align:left; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable1 { border-bottom: darkred solid 1px;text-align:left; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable2 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;text-align:right; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}

  div.dvEmpNewDt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:300; background-color:LemonChiffon; z-index:100;
              text-align:left; font-size:10px }

  div.dvWarn { position: absolute;  top: expression(this.offsetParent.scrollTop+10); left:20px; background-attachment: scroll;
              border: red solid 3px; width:300px;  z-index:50; padding:3px; background-color:white;
              text-align:center; font-size:14px}

  .Small{ text-align:left; font-family:Arial; font-size:10px;}
  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
  td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
  td.Prompt { text-align:left; font-family:Arial; font-size:10px; }
  td.Prompt1 { text-align:center;font-family:Arial; font-size:10px; }
  td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
  td.option { text-align:left; font-size:10px}

</style>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variable
//==============================================================================
var Store = "<%=sStore%>";
var NumOfTst = <%=iNumOfTst%>;
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
    var cell = document.all.cellHireDt;
    if (Store == "ALL")
    {
       for(var i=0; i < cell.length; i++){cell[i].style.display="none"}
    }
    setBoxclasses(["BoxName",  "BoxClose"], ["dvEmpNewDt"]);
    // colapse test results
    showTest();
}
//==============================================================================
// drill down - report on next level
//==============================================================================
function drilldown(grp, grpnm, allstr)
{
  var url = null;
  if(allstr)
  {
     url = "StrTestResult.jsp?Store=" + grp
         + "&StrName=" + grpnm
  }
  else
  {
     //EmpTest.jsp?Emp=7118&FName=BILLY&LName=CARR
     url = "EmpTest.jsp?Emp=" + grp
     var last = grpnm.substring(0, grpnm.indexOf(",")+1)
     var first = grpnm.substring(grpnm.indexOf(",") + 1)

     url += "&FName=" + last
          + "&LName=" + first
          + "&Test=Yes"

  }
  //alert(url)
  window.location.href=url;

}

//==============================================================================
// drill down - report on next level
//==============================================================================
function chgEmpStartTestDate(emp, empnm, hiredt, newdt, reason)
{
   var hdr = "Employee:&nbsp;" + emp + " - " + empnm;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popEmpPanel(emp, hiredt, newdt, reason) + "</td></tr>"
   + "</table>"

   document.all.dvEmpNewDt.innerHTML = html;
   document.all.dvEmpNewDt.style.pixelLeft= document.documentElement.scrollLeft + 200;
   document.all.dvEmpNewDt.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvEmpNewDt.style.visibility = "visible";

   doSelDate(newdt, reason);
}
//==============================================================================
// drill down - report on next level
//==============================================================================
function popEmpPanel(emp, hiredt, newdt, reason)
{
   var posx = document.documentElement.scrollLeft + 250;
   var posy = document.documentElement.scrollTop + 200;

   var panel = "<table>"
       + "<tr><td class='Prompt' nowrap>Hire Date</td><td class='Prompt'>" + hiredt + "</td></tr>"
       + "<tr><td class='Prompt' nowrap>Rehired or Promotion Date </td><td>"
         + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;NewDate&#34;)'>&#60;</button>"
         + "<input class='Small' name='NewDate' type='text' size=10 maxlength=10>&nbsp;"
         + "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, &#34;NewDate&#34;)'>&#62;</button>"
         + "&nbsp;&nbsp;&nbsp;"
         + "<a href='javascript:showCalendar(1, null, null, " + posx + ", " + posy + ", document.all.NewDate)' >"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>"
         + "</td></tr>"
       + "<tr><td class='Prompt'>Reason</td>"
         + "<td><input class='Small' name='Reason' maxlength=50 size=50></td></tr>"
         + "<tr><td class='Prompt1' colspan=2>"
         + "<button class='Small' onClick='sbmNewDate(&#34;" + emp + "&#34;, &#34;UPD&#34;)'>Submit</button>&nbsp;&nbsp;&nbsp;&nbsp;"
         + "<button class='Small' onClick='sbmNewDate(&#34;" + emp + "&#34;, &#34;DLT&#34;)'>Remove</button>"
         + "</td></tr>"
      + "</table>"
   return panel;
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(newdt, reason){
  var df = document.all;
  var date = new Date();
  if(newdt.trim() == "") df.NewDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
  else
  {
    df.NewDate.value = newdt;
    df.Reason.value = reason.trim();
  }

}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);


  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvEmpNewDt.innerHTML = " ";
   document.all.dvEmpNewDt.style.visibility = "hidden";
}
//==============================================================================
// submit new hire date or promotion date for selected employee
//==============================================================================
function sbmNewDate(emp, action)
{
  var newdate = document.all.NewDate.value;
  var reason = document.all.Reason.value.trim();
  var url = "TrnEmpNewDateSave.jsp?"
       + "Emp=" + emp
       + "&NewDate=" + newdate
       + "&Action=" + action
       + "&Reason=" + reason

  //alert(url);
  //window.location.href=url
  window.frame1.location.href=url
  hidePanel();
}

//==============================================================================
// referesh this page
//==============================================================================
function restart()
{
   window.location.reload();
}
//==============================================================================
// show/colapse test colums
//==============================================================================
function showTest()
{
    var dsp = null;
    var col = document.all.colTest;
    if (col[0].style.display != "none"){ dsp = "none"; }
    else { dsp = "block"; }

    for(var i=0; i < col.length; i++) { col[i].style.display = dsp; }
}

</SCRIPT>

<script LANGUAGE="JavaScript" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
</head>

<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvEmpNewDt" class="dvEmpNewDt"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Store/Employee Test Result
       <br>Store: <%=sStore + " - " + sStrName%>
       <br>
       </b>

       <a href="../"><font color="red" size="-1">Home</font></a>;&#62
       <a href="StrTestResultSel.jsp"><font color="red" size="-1">Selection</font></a>;&#62
       <font size="-1">This page</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <a href="javascript: showTest()">Fold/Unfold</a>
       <!----------------- start of ad table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0" id="tblQuest">
           <thead style="overflow: visible;">
             <tr class="DataTable">
               <th class="DataTable" rowspan="2">Employee</th>
               <%if(!bAllStr && bChgDate) {%><th class="DataTable" id="chgEmp" rowspan="2">C<br>h<br>g</th><%}%>
               <th class="DataTable" id="cellHireDt" rowspan="2">Hire Date</th>
               <th class="DataTable" id="cellHireDt" rowspan="2">Rehire /<br>Promotion<br>Date</th>
               <th class="DataTable" id="cellHireDt" rowspan="2">Days<br>Left</th>
               <th class="DataTable" id="colTest" colspan="<%=iNumOfTst * 2%>">Tests</th>
               <th class="DataTable" rowspan="2" colspan="2">Total</th>
             </tr>

             <tr class="DataTable">
               <%for(int i=0; i < iNumOfTst; i++){%>
               <%
                 strresult.setAvaialTest();
                 String sTest = strresult.getTest();
                 String sTstName = strresult.getTstName();
               %>
                 <th class="DataTable" id="colTest" colspan="2"><%=sTstName%></th>
               <%}%>
             </tr>
           </thead>
        <!--------------------- Group List ----------------------------->
         <tbody>
           <%for(int i=0; i < iNumOfGrp; i++){%>
               <%
                 strresult.setAvaialGrp();
                 String sGrp = strresult.getGrp();
                 String sGrpName = strresult.getGrpName();
                 String sEmpHireDt = strresult.getEmpHireDt();
                 String sEmpDaysLeft = strresult.getEmpDaysLeft();
                 String sEmpNSDate = strresult.getEmpNSDate();
                 String sEmpNSReason = strresult.getEmpNSReason();
               %>
               <tr class="DataTable1">
                 <td class="DataTable" nowrap><a href="javascript: drilldown('<%=sGrp%>', '<%=sGrpName%>', <%=bAllStr%>)"><%=sGrp + " - " + sGrpName%></a></td>
                 <%if(!bAllStr && bChgDate) {%>
                    <td class="DataTable" nowrap><a href="javascript: chgEmpStartTestDate('<%=sGrp%>', '<%=sGrpName%>', '<%=sEmpHireDt%>', '<%=sEmpNSDate%>', '<%=sEmpNSReason%>')">C</a></td>
                 <%}%>
                 <td class="DataTable" id="cellHireDt"><%=sEmpHireDt%></td>
                 <td class="DataTable" id="cellHireDt"><%=sEmpNSDate%>&nbsp;</td>
                 <td class="DataTable2" id="cellHireDt">&nbsp;<%=sEmpDaysLeft%></td>
                 <%
                    strresult.setGrpTestProperty();
                    String [] sGrpTest = strresult.getGrpTest();
                    String [] sGrpPass = strresult.getGrpPass();
                    String [] sGrpPrc = strresult.getGrpPrc();

                    String sGrpTot = strresult.getGrpTot();
                    String sGrpTotPass = strresult.getGrpTotPass();
                    String sGrpTotPrc = strresult.getGrpTotPrc();
                 %>
                 <%for(int j=0; j < iNumOfTst; j++){%>
                   <td class="DataTable1" id="colTest"><sup><%=sGrpPass[j]%></sup>/<sub><%=sGrpTest[j]%></sub></td>
                   <td class="DataTable2" id="colTest">&nbsp;<%if(!sGrpPrc[j].equals(".0000")) {%><%=sGrpPrc[j]%>%<%}%></td>
                 <%}%>
                 <td class="DataTable1"><sup><%=sGrpTotPass%></sup>/<sub><%=sGrpTot%></sub></td>
                 <td class="DataTable2">&nbsp;<%if(!sGrpTotPrc.equals(".0000")) {%><%=sGrpTotPrc%>%<%}%></td>
               </tr>
           <%}%>
           <!---------------------------- Report total ------------------------>
           <tr class="DataTable3">
             <td class="DataTable" nowrap>Total</td>
             <td class="DataTable" id="cellHireDt" colspan=4>&nbsp;</td>
             <%
                strresult.setReportTotal();
                String [] sRepTest = strresult.getRepTest();
                String [] sRepPass = strresult.getRepPass();
                String [] sRepPrc = strresult.getRepPrc();

                String sRepTot = strresult.getRepTot();
                String sRepTotPass = strresult.getRepTotPass();
                String sRepTotPrc = strresult.getRepTotPrc();
             %>
             <%for(int j=0; j < iNumOfTst; j++){%>
                <td class="DataTable1" id="colTest"><sup><%=sRepPass[j]%></sup>/<sub><%=sRepTest[j]%></sub></td>
                <td class="DataTable2" id="colTest">&nbsp;<%if(!sRepPrc[j].equals(".0000")) {%><%=sRepPrc[j]%>%<%}%></td>
             <%}%>
                 <td class="DataTable1"><sup><%=sRepTotPass%></sup>/<sub><%=sRepTot%></sub></td>
                 <td class="DataTable2">&nbsp;<%if(!sRepTotPrc.equals(".0000")) {%><%=sRepTotPrc%>%<%}%></td>
           </tr>
         </tbody>
       </table>
       <!----------------- start of ad table ------------------------>
      </td>
     </tr>
    </table>
    <div class="dvWarn">
      <span style="font-size:18px;"><b>ATTENTION!!!</b></span>
      <p style="text-align:left; ">You must notify Store Operations of all rehires by sending an ACTION 
          to the "Training(Training Tests,General)" Action Group.
          Failure to do so may result in inaccurate reporting.
    </div>
  </body>
</html>
<%
  strresult.disconnect();
  strresult = null;
  }
%>
