<%@ page import="rciutility.StoreSelect, payrollreports.SetWeeks"%>
<%
   // get store list
   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;
   StrSelect = new StoreSelect(4);
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();

   // get 5 privious, current and 5 future weeks
   SetWeeks SetWk = new SetWeeks("11WK");
   String  sWeeksJSA = SetWk.getWeeksJSA();
   int iNumOfWeeks = SetWk.getNumOfWeeks();
   String  sMonthBegJSA = SetWk.getMonthBegJSA();
   String  sBaseWkJSA = SetWk.getBaseWkJSA();
   String  sBsWkNameJSA = SetWk.getBsWkNameJSA();
   String sBsMonBegJSA = SetWk.getBsMonBegJSA();

   SetWk.disconnect();
%>


<script name="JavaScript1.2">
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];
var Weeks = [<%=sWeeksJSA%>];
var MonthBeg = [<%=sMonthBegJSA%>];
var BaseWk = [<%=sBaseWkJSA%>];
var BsMonBeg = [<%=sBsMonBegJSA%>]
var BsWkName = [<%=sBsWkNameJSA%>];
var NumBase = <%=iNumOfWeeks%>

function bodyLoad(){
  // populate date with yesterdate
  doStrSelect();
  doWeekSelect();
}

// Load Stores
function doStrSelect() {
    var df = document.forms[0];

    for (idx = 1; idx < stores.length; idx++)
    {
      df.STORE.options[idx-1] = new Option(stores[idx] + " - " + storeNames[idx],
                                           stores[idx]);
    }
    df.STORE.selectedIndex=0;
}

// Weeks Stores
function doWeekSelect(id) {
    var df = document.forms[0];
    var idx = 0;
    for (idx = 0; idx < Weeks.length; idx++)
    {
      df.WEEK.options[idx] =
            new Option(Weeks[idx], Weeks[idx]);
      df.WEEK.selectedIndex=5;
    }

    for (idy=0; idy < NumBase; idy++, idx++)
    {
      df.WEEK.options[idx] =
            new Option(BsWkName[idy], BaseWk[idy]);
    }
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
function Validate(form) {
  var error = false;
  var msg;
  var rep

  if  (form.EmpNum.value != "ALL"
    && !isNum(form.EmpNum.value)){
    msg = "Enter employee number\n"
    error = true;
  }

  if (error) alert(msg);
  else
  {
    form.STRNAME.value = storeNames[form.STORE.selectedIndex+1];
  }

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
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div></div>

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
        <BR>Payroll Budget History Log</B>

       <!-- -->
      <FORM  method="GET" onSubmit="return Validate(this)" action="PayBdgScript.jsp" name="REPORT" >
      <TABLE>
        <TBODY>
        <tr>
         <td align=right >Select Store:</td>
         <td><SELECT name="STORE" ></SELECT>
             <input name="STRNAME" type="hidden">
         </td>
        </tr>
        <tr>
          <td>Select Weekending:</td>
          <td><SELECT name="WEEK"></SELECT></td>
        </tr>
        <tr>
          <td align=right >Employee:</td>
          <td>
            <input name="EmpNum" type="text" size=4 maxlength=4 value="ALL">
            <input name="EmpName" type="text" size=35 maxlength=35 readonly>
            <a href='javascript:openPromptWdw("EmpNum", "EmpName")'><font size='-2'>Employee List</font></a>
          </td>
        </tr>
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
