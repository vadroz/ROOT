<% // Get query string parameters
   String sStore = request.getParameter("STORE");
   String sStrName = request.getParameter("STRNAME");
   String sWeek = request.getParameter("WEEK");
   String sSllAvgPay = request.getParameter("SELLAVGPAY");
   String sNSlAvgPay = request.getParameter("NONSAVGPAY");
   String sSllPrc = request.getParameter("SELLPRC");
   String sNSlPrc = request.getParameter("NONSPRC");
%>

<html>
<head>
<SCRIPT language="JavaScript">
 document.write("<style>body {background:ivory;}");
 document.write("a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}" );
 document.write("table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}");
 document.write("</style>");

 var CurStore = <%=sStore%>;
 var CurStrName = "<%=sStrName%>";
 var Week = "<%=sWeek%>";

function bodyLoad(){

}

// change action on submit
function Validate(){
var msg = null;
var error = false;
var SllAvg = document.forms[0].SELLAVGPAY.value
var NSlAvg = document.forms[0].NONSAVGPAY.value
var SllPrc = document.forms[0].SELLPRC.value
var NSlPrc = document.forms[0].NONSPRC.value
//--------------------- Validate Average Pay -------------------------------
if (SllAvg <= "     "){
   msg = " Please, enter Average Wage for selling personnel\n"
   error = true;
}
if (SllAvg > 99.99){
   msg = "Average Wage for selling personnel cannot be greater $99.99 \n"
   error = true;
}

if (NSlAvg <= "     "){
   msg = " Please, enter Average Wage for non-selling personnel\n"
   error = true;
}
if (NSlAvg > 99.99){
   msg = "Average Wage for non-selling personnel cannot be greater $99.99 \n"
   error = true;
}
//--------------------- Validate Percentage ---------------------------------

if (SllPrc <= "     "){
   msg = " Please, enter Payroll Percents for selling personnel\n"
   error = true;
}
if (SllPrc > 99.99){
   msg = "Payroll Percents for selling personnel cannot be greater $99.99 \n"
   error = true;
}

//--------------------- Check for Non-numeric values -----------------------
if (!isNum(SllAvg) || !isNum(NSlAvg) || !isNum(SllPrc) || !isNum(NSlPrc)){
   msg = " Entered amount must contains only digits\n"
   error = true;
}

  if (error) alert(msg);

return error == false;
}

 function isNum(str) {
  if(!str) return false;
  for(var i=0; i < str.length; i++){
    var ch=str.charAt(i);
    if ("0123456789.".indexOf(ch) ==-1) return false;
  }
  return true;
}

// change action on submit
function submitForm(){
  var sbmString = "SaveAvgPay.jsp?STORE=" + CurStore
                + "&STRNAME=" + CurStrName
                + "&WEEK=" + Week
                + "&SELLAVGPAY=" + document.forms[0].SELLAVGPAY.value
                + "&NONSAVGPAY=" + document.forms[0].NONSAVGPAY.value
                + "&SELLPRC=" + document.forms[0].SELLPRC.value
                + "&NONSPRC=" + document.forms[0].NONSPRC.value;
  window.location.href = sbmString;
}
</SCRIPT>
          </head>
 <body  onload="bodyLoad();">

 <table border="0" width="100%" height="100%">
   <tr>
     <td height="20%" COLSPAN="2">
       <img src="Sun_ski_logo4.png" /></td>
   </tr>
   <tr bgColor="moccasin">
     <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>Average Pay Entry</b><br>

      <font size="+1" >
        <b>Store:&nbsp; <%=sStrName%><br>
        Week Ending Date: <%=sWeek%></b></font><br/>

       <form name="getAvgPay" onsubmit="return Validate();" action="javascript:submitForm()">
       <table border=0 >
        <tr><td colspan="6" align="left"><b>Enter Average Wage</b></td></tr>
        <tr><td align="right">&nbsp;&nbsp;&nbsp;Selling personnel: </td>
            <td align="left"><input type="text" name="SELLAVGPAY" value="<%=sSllAvgPay%>" size="10" maxlength="5"></td>
            <td> = $<%=sSllAvgPay%></td></tr>
        <tr><td align="right">&nbsp;&nbsp;&nbsp;Non-Selling personnel: </td>
            <td align="left"><input type="text" name="NONSAVGPAY" value="<%=sNSlAvgPay%>" size="10" maxlength="5"></td>
            <td> = $<%=sNSlAvgPay%></td>
        <tr><td colspan="6" align="left"><b>Enter Payroll Percents</b></td></tr>
        <tr><td align="right">&nbsp;&nbsp;&nbsp;Selling personnel: </td>
            <td align="left"><input type="text" name="SELLPRC" value="<%=sSllPrc%>" size="10" maxlength="5"></td>
            <td> = $<%=sSllPrc%></td></tr>
        <tr><td align="right">&nbsp;&nbsp;&nbsp;Non-Selling personnel: </td>
            <td align="left"><input type="text" name="NONSPRC" value="<%=sNSlPrc%>" size="10" maxlength="5"></td>
            <td> = $<%=sNSlPrc%></td></tr>
       </table>
         <input type="submit" value="Save">
         <input type="BUTTON" name="Back" value="Back" onClick="javascript:history.back()">
       </form>
    </td>
   </tr>
 </table>

        </body>
      </html>
