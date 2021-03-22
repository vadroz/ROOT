<%@ page import="employeecenter.EmpReview_SPAP103"%>
<%
    String sEmp = request.getParameter("Emp");
    String sEmpName = request.getParameter("EmpName");
    String sYear = request.getParameter("Year");
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("EMPSALARY")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EmpReview_SPAP103.jsp");
}
else
{
    String sUser = session.getAttribute("USER").toString();

    EmpReview_SPAP103 empform = new EmpReview_SPAP103(sEmp, sYear, sUser);
    empform.setFormData();
    int iNumOfFld = empform.getNumOfFld();
    String [] sFld = empform.getFld();
    String [] sLng = empform.getLng();
    String [] sValue = empform.getValue();
    empform.disconnect();

    int iNum = 0;
%>
<HTML>
<HEAD>
<title>Annual_Review</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:white;}
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

        span.spnHdr { border: black solid 1px; background:azure; padding-left:3px;
                      padding-right:3px;  font-size:14px; font-weight:bold }
        span.spnHdr1 { border: black solid 1px; background:azure; padding-left:3px;
                      padding-right:3px;  font-size:16px; font-weight:bold }

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

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvEmp"]);
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
  <TR>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>ASSISTANT STORE MANAGER PERFORMANCE APPRAISAL
        <br> Year: <%=sYear%>
        </B><br>

        <a href="index.jsp" class="small"><font color="red">Home</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-- ======================================================================= -->
<p align=left>
      Name: <u><b><%=sEmp%> <%=sEmpName%></b></u> &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Store: <%=sValue[2]%>
      <br>Review period from <input class="Small" name="<%=sFld[3]%>" size=<%=sLng[3]%> maxlength=<%=sLng[3]%>  value="<%=sValue[3]%>">
                 to <input class="Small" name="<%=sFld[4]%>" size=<%=sLng[4]%> maxlength=<%=sLng[4]%> value="<%=sValue[4]%>">
      <br><br>
      <b>INSTRUCTIONS:</b> Enter the appropriate rating for each area. Provide comments at the end of each section to support the rating.

      <br><br>
      <span class="spnHdr">PERFORMANCE RATING DEFINITION:</span>
<br>5, Outstanding: Performance demonstrates superior results and abilities in all aspects of this skill.
<br>4, Excellent: Performance consistently exceeds the standards and expectations in this skill.
<br>3, Satisfactory: Performance consistently meets the standards and expectations in this skill.
<br>2, Needs Improvement: Performance demonstrates a need for more training in this skill.
<br>1, Unsatisfactory: Performance is consistently below expectations in this skill.


<p align=center><span class="spnHdr1">ASSISTANT MANAGER STATISTICAL REVIEW</span>
<!-- -------------------------- Page 2 Group 1--------------------------------- -->
<p align=left>
<table width="100%" border=1>
 <tr><td>
  <table width="100%">
     <tr><th colspan=2><u>Total Store Sales</u></th><th colspan=2></tr>
     <tr>
        <td>Last Year Ending</td><%iNum = 5;%>
        <td>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>This Year Ending</td><%iNum = 6;%>
        <td>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>%Variance (+/-)</td><%iNum = 7;%>
        <td>%<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>This Year Goal</td><%iNum = 8;%>
        <td>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>%Variance (+/-)</td><%iNum = 9;%>
        <td>%<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>Next Year Goal</td><%iNum = 10;%>
        <td>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
  </table>
 </td>
 <td>
  <table width="100%">
     <tr><th colspan=2><u>Payroll Percent</u></th><th colspan=2></tr>
     <tr>
        <td>Last Year Ending</td><%iNum = 11;%>
        <td>%<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>This Year Ending</td><%iNum = 12;%>
        <td>%<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>%Variance (+/-)</td><%iNum = 13;%>
        <td>%<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>This Year's Goal</td><%iNum = 14;%>
        <td>%<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>%Variance (+/-)</td><%iNum = 15;%>
        <td>%<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>Next Year's Goal</td><%iNum = 16;%>
        <td>%<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
  </table>
 </td></tr>
</table>


<!-- ------------------------- Page 2 Group 2 --------------------------------------- -->
<p align=left>
<table width="100%" border=1>
 <tr><td>
  <table width="100%">
     <tr><th colspan=2><u>Shrinkage Percent (at retail)</u></th><th colspan=2></tr>
     <tr>
        <td>Last Year Ending</td><%iNum = 17;%>
        <td>%<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>This Year Ending</td><%iNum = 18;%>
        <td>%<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>%Variance (+/-)</td><%iNum = 19;%>
        <td>%<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>This Year's Goal</td><%iNum = 20;%>
        <td>%<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>%Variance (+/-)</td><%iNum = 21;%>
        <td>%<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>Next Year's Goal</td><%iNum = 22;%>
        <td>%<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
  </table>
 </td>
 <td>
  <table width="100%">
     <tr><th colspan=2><u>Operating Income</u></th><th colspan=2></tr>
     <tr>
        <td>Last Year Ending</td><%iNum = 23;%>
        <td>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>This Year Ending</td><%iNum = 24;%>
        <td>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>%Variance (+/-)</td><%iNum = 25;%>
        <td>%<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>This Year's Goal</td><%iNum = 26;%>
        <td>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>%Variance (+/-)</td><%iNum = 27;%>
        <td>%<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>Next Year's Goal</td><%iNum = 28;%>
        <td>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
  </table>
 </td></tr>
</table>


<!-- ------------------------- Page 2 Group 3 --------------------------------------- -->
<p align=left>
<table width="100%" border=1>
 <tr><td>
  <table width="100%">
     <tr>
       <th><u>Sales Productivity (total store)</u></th>
       <th  align=center><u>Store</u></th><th align=center><u>Region</u></th><th align=center><u>Difference</u></th>
     </tr>
     <tr>
        <td>Average Hourly Sales</td>
        <td align=center><%iNum = 29;%>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
        <td align=center><%iNum = 32;%>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
        <td align=center><%iNum = 35;%>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>Average Items Per Transaction</td>
        <td align=center><%iNum = 30;%>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
        <td align=center><%iNum = 33;%>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
        <td align=center><%iNum = 36;%>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>Average Dollars Per Transaction</td>
        <td align=center><%iNum = 31;%>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
        <td align=center><%iNum = 34;%>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
        <td align=center><%iNum = 37;%>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
  </table>
</table>

<!-- ------------------------- Page 2 Group 4 --------------------------------------- -->
<p align=left>
<table width="100%" border=1>
 <tr><td>
  <table width="100%">
     <tr>
       <th><u>Personal Sales Productivity</u></th>
       <th  align=center><u>Store</u></th><th align=center><u>Region</u></th><th align=center><u>Difference</u></th>
     </tr>
     <tr>
        <td>Average Hourly Sales</td>
        <td align=center><%iNum = 38;%>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
        <td align=center><%iNum = 41;%>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
        <td align=center><%iNum = 44;%>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>Average Items Per Transaction</td>
        <td align=center><%iNum = 39;%>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
        <td align=center><%iNum = 42;%>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
        <td align=center><%iNum = 45;%>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
     <tr>
        <td>Average Dollars Per Transaction</td>
        <td align=center><%iNum = 40;%>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
        <td align=center><%iNum = 43;%>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
        <td align=center><%iNum = 46;%>$<input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>"></td>
     </tr>
  </table>
</table>


<p align=center><span class="spnHdr1">I. SELLING SKILLS/CUSTOMER SERVICE &nbsp;  &nbsp;  &nbsp; 25% of Total</span>
<!-- ------------------------- Page 3 Group 1 --------------------------------------- -->
<p align=left>
<table width="100%" border=1>
 <tr><td>
  <table width="100%" border=0>
    <tr><td width="30%"><span class="spnHdr">A. Floor Supervision and Floating</span><td>
     <td>
       <table border=1>
         <tr><td rowspan=3><b>POINT VALUE 3</b></td></tr>
         <tr style="font-size:8px;text-align:center">
           <td>1<br>Unsatisfactory</td><td>2<br>&nbsp;</td><td>3<br>Satisfactory</td><td>4<br>&nbsp;</td><td>5<br>Outstanding</td>
         </tr>
         <tr style="font-size:8px; text-align:center">
           <td><%iNum = 47;%><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="1"></td>
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="2">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="3">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="4">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="5">
        </tr>
      </table>
     </td><tr>
   </table>
   <br>- Ensures that all customers are greeted and matched with sales people per company standards
   <br>- Ensures that all employees are being productive on the sales floor
   <br>- Ensures that employees are floating and delivering great customer service to more than one customer at a time, when needed
 </td><tr>
</table>


<!-- ------------------------- Page 3 Group 2 --------------------------------------- -->
<p align=left>
<table width="100%" border=1>
 <tr><td>
  <table width="100%" border=0>
    <tr><td width="30%"><span class="spnHdr">B. GUPOC-AM</span><td>
     <td>
       <table border=1>
         <tr><td rowspan=3><b>POINT VALUE 2</b></td></tr>
         <tr style="font-size:8px;text-align:center">
           <td>1<br>Unsatisfactory</td><td>2<br>&nbsp;</td><td>3<br>Satisfactory</td><td>4<br>&nbsp;</td><td>5<br>Outstanding</td>
         </tr>
         <tr style="font-size:8px;text-align:center">
           <td><%iNum = 48;%><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="1"></td>
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="2">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="3">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="4">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="5">
        </tr>
      </table>
     </td><tr>
   </table>
   <br>- Demonstrates the seven steps of selling
   <br>- Has a staff that is trained and uses the seven steps of GUPOC-AM
   <br>- Coaches sales people in the steps of GUPOC-AM on a consistent basis
   <br>- Has a staff that knows and uses the different payment plans our company offers
   </td><tr>
</table>

<!-- ------------------------- Page 3 Group 3 --------------------------------------- -->
<p align=left>
<table width="100%" border=1>
 <tr><td>
  <table width="100%" border=0>
    <tr><td width="30%"><span class="spnHdr">C. Daily Goal Sheet</span><td>
     <td>
       <table border=1>
         <tr><td rowspan=3><b>POINT VALUE 2</b></td></tr>
         <tr style="font-size:8px;text-align:center">
           <td>1<br>Unsatisfactory</td><td>2<br>&nbsp;</td><td>3<br>Satisfactory</td><td>4<br>&nbsp;</td><td>5<br>Outstanding</td>
         </tr>
         <tr style="font-size:8px;text-align:center">
           <td><%iNum = 49;%><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="1"></td>
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="2">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="3">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="4">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="5">
        </tr>
      </table>
     </td><tr>
   </table>
   <br>- Goal sheets are posted and the goals filled out for the current week before opening of business every Monday
   <br>- Employees are filling our goal sheet with their sales at the end of each shift and coloring in their dot at end of week
   <br>- Weekly coaching conversations on dot color
   </td><tr>
</table>


<!-- ------------------------- Page 3 Group 4 --------------------------------------- -->
<p align=left>
<table width="100%" border=1>
 <tr><td>
  <table width="100%" border=0>
    <tr><td width="30%"><span class="spnHdr">D. Productivity Reports</span><td>
     <td>
       <table border=1>
         <tr><td rowspan=3><b>POINT VALUE 2</b></td></tr>
         <tr style="font-size:8px;text-align:center">
           <td>1<br>Unsatisfactory</td><td>2<br>&nbsp;</td><td>3<br>Satisfactory</td><td>4<br>&nbsp;</td><td>5<br>Outstanding</td>
         </tr>
         <tr style="font-size:8px;text-align:center">
           <td><%iNum = 50;%><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="1"></td>
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="2">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="3">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="4">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="5">
        </tr>
      </table>
     </td><tr>
   </table>
   <br>- Productivity reports are used for documented coaching conversations on stats, on a weekly basis
   <br>- Management staff and sales floor supervisors are aware of what stat each sales person is working on for the week
   </td><tr>
</table>

<!-- ------------------------- Page 3 Group 5 --------------------------------------- -->
<p align=left>
<table width="100%" border=1>
 <tr><td>
  <table width="100%" border=0>
    <tr><td width="30%"><span class="spnHdr">E. Customer Complaints</span><td>
     <td>
       <table border=1>
         <tr><td rowspan=3><b>POINT VALUE 1</b></td></tr>
         <tr style="font-size:8px;text-align:center">
           <td>1<br>Unsatisfactory</td><td>2<br>&nbsp;</td><td>3<br>Satisfactory</td><td>4<br>&nbsp;</td><td>5<br>Outstanding</td>
         </tr>
         <tr style="font-size:8px;text-align:center">
           <td><%iNum = 50;%><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="1"></td>
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="2">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="3">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="4">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="5">
        </tr>
      </table>
     </td><tr>
   </table>
   <br>- Handles customer complaints in a professional manner and is successful in satisfying customer needs
   <br>- Has a staff that lives the culture that the customer is the boss
   </td><tr>
</table>


<!-- ------------------------- Page 3 Group 6 --------------------------------------- -->
<p align=left>
<table width="100%" border=1>
 <tr>
   <td>
     <b>SCORING INSTRUCTIONS:</b>
     <br>For each section, multiply the "Point Value" listed in that particular section by the rating value to calculate “Total Points.” Add the total point values within this section. Divide the “total points” by the number of “maximum points” available in this section. Round the result up or down and record in the box labeled "score". Transfer the "score" to the Performance.
     <br>Total Point: <%iNum = 51;%><input class="Small" name="<%=sFld[iNum]%>" size=<%=sLng[iNum]%> maxlength=<%=sLng[iNum]%>  value="<%=sValue[iNum]%>">
   </td>
 <tr>
</table>


<!-- -------------------------------------------------------------------------------- -->
<!-- ------------------------- Page 4 ----------------------------------------------- -->
<!-- -------------------------------------------------------------------------------- -->
<p align=center><span class="spnHdr1">II. PERSONNEL &nbsp;  &nbsp;  &nbsp; 25% of Total</span>
<!-- ------------------------- Page 4 Group 1 --------------------------------------- -->
<p align=left>
<table width="100%" border=1>
 <tr><td>
  <table width="100%" border=0>
    <tr><td width="30%"><span class="spnHdr">A. Hiring</span><td>
     <td>
       <table border=1>
         <tr><td rowspan=3><b>POINT VALUE 3</b></td></tr>
         <tr style="font-size:8px;text-align:center">
           <td>1<br>Unsatisfactory</td><td>2<br>&nbsp;</td><td>3<br>Satisfactory</td><td>4<br>&nbsp;</td><td>5<br>Outstanding</td>
         </tr>
         <tr style="font-size:8px; text-align:center">
           <td><%iNum = 47;%><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="1"></td>
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="2">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="3">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="4">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="5">
        </tr>
      </table>
     </td><tr>
   </table>
   <br>- Utilizes the application flow system to effectively staff the store; participates in the planning and interview process
   <br>- Conducts interviews in a professional manner; uses second interviews before hiring applicant; uses all surveys required and adheres to scoring limitations unless supervisor is notified and consulted; checks all references of form employers before hiring
   <br>- Advises all applicants of the company’s philosophy, benefits available, job description and individual expectations, rate of pay and other compensation
   <br>- Is thorough and timely with all new hire/rehire paperwork
   </td><tr>
</table>

<!-- ------------------------- Page 4 Group 2 --------------------------------------- -->
<p align=left>
<table width="100%" border=1>
 <tr><td>
  <table width="100%" border=0>
    <tr><td width="30%"><span class="spnHdr">A. Hiring</span><td>
     <td>
       <table border=1>
         <tr><td rowspan=3><b>POINT VALUE 3</b></td></tr>
         <tr style="font-size:8px;text-align:center">
           <td>1<br>Unsatisfactory</td><td>2<br>&nbsp;</td><td>3<br>Satisfactory</td><td>4<br>&nbsp;</td><td>5<br>Outstanding</td>
         </tr>
         <tr style="font-size:8px; text-align:center">
           <td><%iNum = 47;%><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="1"></td>
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="2">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="3">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="4">
           <td><input class="Small" type="radio" name="<%=sFld[iNum]%>" value="5">
        </tr>
      </table>
     </td><tr>
   </table>
   <br>- Utilizes the application flow system to effectively staff the store; participates in the planning and interview process
   <br>- Conducts interviews in a professional manner; uses second interviews before hiring applicant; uses all surveys required and adheres to scoring limitations unless supervisor is notified and consulted; checks all references of form employers before hiring
   <br>- Advises all applicants of the company’s philosophy, benefits available, job description and individual expectations, rate of pay and other compensation
   <br>- Is thorough and timely with all new hire/rehire paperwork
   </td><tr>
</table>




      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
   }
%>