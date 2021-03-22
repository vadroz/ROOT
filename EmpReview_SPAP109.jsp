<%@ page import="employeecenter.AnnualSalaryReview"%>
<%
    String sStore = request.getParameter("Store");
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("EMPSALARY")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=AnnualSalaryReview.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();
    AnnualSalaryReview salrev = new AnnualSalaryReview(sStore, sUser);
    int iNumOfEmp = salrev.getNumOfEmp();
%>
<HTML>
<HEAD>
<title>Annual_Review</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:green; font-size:10px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}

        tr.DataTable { background: #E7E7E7; font-size:11px }
        tr.DataTable1 { background: yellow; font-size:11px }
        tr.DataTable2 { background: red; font-size:11px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvEmp { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

</style>


<script name="javascript1.2">
var NumOfEmp = <%=iNumOfEmp%>;

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvEmp"]);
}
//==============================================================================
// update selected colimn cells
//==============================================================================
function RevUpdate(emp, empname, prc, rate)
{
   var colnm = null
   var size = 0;

   //check if order is paid off
   var hdr = "New Rate for: " + emp + " " + empname;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>" + popRevPanel(emp)

   html += "</td></tr></table>"

   document.all.dvEmp.innerHTML = html;
   document.all.dvEmp.style.width = 250;
   document.all.dvEmp.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvEmp.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvEmp.style.visibility = "visible";

   if(prc != "0") { document.all.NewRate.value = "%" + prc; }
   else if(rate != "0") { document.all.NewRate.value = rate; }
   document.all.NewRate.focus()
}
//--------------------------------------------------------
// populate Column Panel
//--------------------------------------------------------
function popRevPanel(emp)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt3' nowrap>Pay Increase Rate/Percentage</td>"
           + "<td class='Prompt' colspan='2'>"
  panel += "<input name=NewRate class='Small' size='10' maxlength='10'>"
  panel += "</td>" + "</tr>"

  panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
        + "<button onClick='Validate(&#34;" + emp + "&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//--------------------------------------------------------
// save new rate
//--------------------------------------------------------
function Validate(emp)
{
   var newrate = document.all.NewRate.value.trim();
   var error=false;
   var msg = "";
   var newprc = null;

   if (newrate.substring(0,1)== "%")   // percent of increase
   {
      newprc = newrate.substring(1);
      if (isNaN(newprc)) { error = true; msg = "Percent of Increase is not a numeric value."}
      else if (eval(newprc) < 0) { error = true; msg = "Percent of Increase cannot be negative."}
   }
   else // new rate
   {
      if (isNaN(newrate)) { error = true; msg = "New Rate is not a numeric value."}
      else if (eval(newrate) < 0) { error = true; msg = "New Rate cannot be negative."}
   }

   if(error) { alert(msg) }
   else { sbmNewRate(emp, newrate); }
}
//--------------------------------------------------------
// save new rate
//--------------------------------------------------------
function sbmNewRate(emp, rate)
{
   hidePanel();
   var url = "NewRateSave.jsp?Emp=" + emp
           + "&Rate=" + rate.replaceSpecChar()
           + "&Action=ADD";

   //alert(url)
   //window.location.href=url;
   window.frame1.location.href=url;

}
//--------------------------------------------------------
// save new rate
//--------------------------------------------------------
function restart()
{
   window.location.reload();
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvEmp.innerHTML = " ";
   document.all.dvEmp.style.visibility = "hidden";
}

//--------------------------------------------------------
// resort table
//--------------------------------------------------------
function resort(sort)
{
  url = "AnnualSalaryReview.jsp?Store=<%=sStore%>"

  window.location.href=url;
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvEmp" class="dvEmp"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Annual Salary Review Worksheet Summary
        </B><br>

        <a href="index.jsp" class="small"><font color="red">Home</font></a>&#62;
        <a href="AnnualSalaryReviewSel.jsp" class="small"><font color="red">Selection Screen</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0">
         <tr class="DataTable">
             <th class="DataTable" rowspan=2>Rci#</th>
             <th class="DataTable" rowspan=2>Employee Name</th>
             <th class="DataTable" rowspan=2>Store</th>
             <th class="DataTable" rowspan=2>Dept</th>
             <th class="DataTable" rowspan=2>Title</th>
             <th class="DataTable" rowspan=2>Hire Date</th>
             <th class="DataTable" rowspan=2>H/S</th>
             <th class="DataTable" colspan=2>Average Rate</th>
             <th class="DataTable" rowspan=2>Current<br>Rate</th>
             <th class="DataTable" rowspan=2>Effective<br>Date</th>
             <th class="DataTable" rowspan=2>Commission<br>Hourly Rate</th>
             <th class="DataTable" rowspan=2>Non-Commission<br>Hourly Rate</th>
             <th class="DataTable" rowspan=2>ADP#</th>
             <th class="DataTable" colspan=2>Pay Increase</th>
         </tr>
         <tr class="DataTable">
             <th class="DataTable">LLY</th>
             <th class="DataTable">LY</th>
             <th class="DataTable">%</th>
             <th class="DataTable">Rate</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfEmp; i++ )
         {
            salrev.setEmpList();
            String sEmp = salrev.getEmp();
            String sEmpName = salrev.getEmpName();
            String sStr = salrev.getStr();
            String sTitle = salrev.getTitle();
            String sRate = salrev.getRate();
            String sHireDate = salrev.getSalary();
            String sCommission = salrev.getCommission();
            String sAdp = salrev.getAdp();
            String sDept = salrev.getDept();
            String sHorS = salrev.getHorS();
            String sAvgRate1 = salrev.getAvgRate1();
            String sAvgRate2 = salrev.getAvgRate2();
            String sRate3 = salrev.getRate3();
            String sRatEffDt = salrev.getRatEffDt();
            String sNewPrc = salrev.getNewPrc();
            String sNewRate = salrev.getNewRate();

            // commission flag literal
            String sComType = "";
            if(sCommission.equals("R")) sComType = "Regular";
            else if(sCommission.equals("S")) sComType = "Special";
       %>
         <tr class="DataTable">
            <td class="DataTable" nowrap><a href="javascript: RevUpdate('<%=sEmp%>', '<%=sEmpName%>', '<%=sNewPrc%>', '<%=sNewRate%>')"><%=sEmp%></a></td>
            <td class="DataTable1" nowrap><%=sEmpName%></td>
            <td class="DataTable" nowrap><%=sStr%></td>
            <td class="DataTable" nowrap><%=sDept%></td>
            <td class="DataTable" nowrap><%=sTitle%></td>
            <td class="DataTable" nowrap><%=sHireDate%></td>
            <td class="DataTable" nowrap><%=sHorS%></td>
            <td class="DataTable" nowrap><%=sAvgRate1%></td>
            <td class="DataTable" nowrap><%=sAvgRate2%></td>
            <td class="DataTable" nowrap><%=sRate%></td>
            <td class="DataTable" nowrap><%=sRatEffDt%></td>
            <td class="DataTable" nowrap><%if(sCommission.equals("R")){%><%=sRate3%><%}%></td>
            <td class="DataTable" nowrap><%if(!sCommission.equals("R")){%><%=sRate%><%}%></td>
            <td class="DataTable" nowrap><%=sAdp%></td>
            <td class="DataTable" nowrap><%=sNewPrc%>%</td>
            <td class="DataTable" nowrap>$<%=sNewRate%></td>
          </tr>
       <%}%>
     </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
     salrev.disconnect();
   }
%>