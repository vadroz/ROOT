<%@ page import="rciutility.StoreSelect"%>
<%
   // get store list
   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;
   StrSelect = new StoreSelect();
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();
%>


<script name="JavaScript1.2">
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];


function bodyLoad(){
  // populate date with yesterdate
  doSelDate();
  doStrSelect();
}

// Load Stores
function doStrSelect() {
    var df = document.forms[0];

    for (idx = 0; idx < stores.length; idx++)
                df.STORE.options[idx] = new Option(stores[idx] + ' - ' + storeNames[idx],stores[idx]);
    df.STORE.selectedIndex=0;
}



// populate date with yesterdate
function  doSelDate(){
  var df = document.forms[0];
  var date = new Date(new Date() - 86400000);
  df.selDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}


// Open prompt window
function openPromptWdw(num, name) {
  var MyURL = "SelectEmployee.jsp?FORM=forms[0]&EMPNUM=" + num
            + "&EMPNAME=" + name;
  var MyWindowName = 'Test01';
  var MyWindowOptions =
   'width=600,height=400, toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,resize=no,menubar=no';
  window.open(MyURL, MyWindowName, MyWindowOptions);
}


// Validate form entry fields
function Validate() {
  var vld = new Date(document.forms[0].selDate.value)
  var minYear=2000
  var maxYear= (new Date()).getFullYear();
  var error = false;
  var msg;
  var rep
  var amt = document.forms[0].AMOUNT
  var days = document.forms[0].NUMDAYS

  if (document.forms[0].selDate.value == null
  || (new Date(vld)) == "NaN")
  {
    msg = " Please, enter report date\n"
    error = true;
  }
  else {document.forms[0].selDate.value = (vld.getMonth()+1) + "/" + vld.getDate() + "/" + vld.getFullYear()}

  if (vld.getFullYear() < minYear){
    msg = vld.getFullYear() + " is less that minimum year allowed\n"
    error = true;
  }
  if (vld.getFullYear() > maxYear){
    msg = vld.getFullYear() + " is greater that maximum year allowed\n"
    error = true;
  }
  if (amt.value <= 0 || !isNum(amt.value)){
    msg = "Enter start amount\n"
    error = true;
  }

  if (days.value <= 0 || !isNum(days.value)){
    msg = "Enter number of days\n"
    error = true;
  }

  if (error) alert(msg);
  return error == false;
}
// Validate numeric fields
  function isNum(str) {
  if(!str) return false;

  for(var i=0; i < str.length; i++){
    var ch=str.charAt(i);
    if ("0123456789".indexOf(ch) ==-1) return false;
  }
  return true;
}
</script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>
<SCRIPT language=JavaScript>
		document.write("<style>body {background:ivory;}");
		document.write("table.Tb1 { background:#FFE4C4;}");
		document.write("td.DTb1 { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }");
		document.write("</style>");
</SCRIPT>

<html>
<head>
<title>
Fright Bill Report
</title>
</head>
<body onload="bodyLoad();">

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD colSpan=2 height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top width="15%" bgColor=#a7b5e8><FONT face=Arial color=#445193
      size=2>&nbsp;&nbsp;<A class=blue
      href="/">Home</A></FONT><FONT
      face=Arial color=#445193 size=1>
      <H5>&nbsp;&nbsp;Miscellaneous</H5>&nbsp;&nbsp;<A class=blue
      href="mailto:helpdesk@retailconcepts.cc">Mail to IT</A> <BR>&nbsp;&nbsp;<A
      class=blue href="http://sunandski.com/">Our Internet</A> <BR></FONT></TD>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Credit Card Returns w/Negative Balance</B>

       <!-- -->
      <FORM  method="GET" onSubmit="return Validate(this)" action="servlet/negreturn.NegRtnRep" name="REPORT" >
      <TABLE>
        <TBODY>
        <TR>
          <TD class=DTb1 align=right >Date:</TD>
          <TD><input name="selDate" type="text" size=10 maxlength=10>
              <a href="javascript:showCalendar(1, null, null, 300, 250)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </TD>
        </TR>
        <TR>
            <TD>Include Previous Days:</TD>
              <TD class=DTb1 align=left>
                <INPUT type="text" name="NUMDAYS" value="7" size=3 maxlength=3>
        </TR>
        <tr>
         <td align=right >Select Store:</td><td><SELECT name="STORE" ></SELECT></td>
        </tr>
        <tr>
          <TD align=right >Salespeson:</TD>
          <td>
            <input name="EmpNum" type="text" size=4 maxlength=4 value="ALL">
            <input name="EmpName" type="text" size=25 maxlength=25 readonly>
            <a href='javascript:openPromptWdw("EmpNum", "EmpName")'><font size='-2'>Employee List</font></a>
          </td>
        </tr>
        <tr>
          <TD align=right >Cashier:</TD>
          <td>
            <input name="CshNum" type="text" size=4 maxlength=4 value="ALL">
            <input name="CshName" type="text" size=25 maxlength=25 readonly>
            <a href='javascript:openPromptWdw("CshNum", "CshName")'><font size='-2'>Employee List</font></a>
          </td>
        </tr>
        <TR>
          <TD class=DTb1 align=right >Negative Card<br/>Balance Exceeds:</TD>
          <TD><input name="AMOUNT" type="text" size=5 maxlength=5 value="100">
          </TD>
        </TR>
        <TR>
            <TD></TD>
            <TD class=DTb1 align=left colSpan=5>&nbsp;&nbsp;&nbsp;&nbsp;
               <INPUT type=submit value=Submit name=SUBMIT >
           </TD>
          </TR>
        </TBODY>
        </TABLE>
       </FORM>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</body>
</html>
