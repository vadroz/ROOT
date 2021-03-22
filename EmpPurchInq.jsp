<%@ page import="rciutility.StoreSelect, rciutility.EmployeeSelect"%>
<% StoreSelect StrSelect = null;
   EmployeeSelect empSel = null;
   String sStr = null;
   String sStrName = null;
   String sEmp = null;

   StrSelect = new StoreSelect();
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();

   empSel = new EmployeeSelect();
   sEmp = empSel.getStrNum();
%>

<script name="javascript">
function bodyLoad(){
  var df = document.forms[0];
  var time=new Date(new Date().getTime() - 86400000); // get prior date
  var year = time.getFullYear();
  var month = time.getMonth();
  var day = time.getDate();

  doStrSelect();

  // load 7 years
  for (idx = 0; idx < 7; idx++){
       df.FYEAR.options[idx] = new Option(year + '', year + '');
       df.TYEAR.options[idx] = new Option(year + '', year + '');
       year--;
  }
  df.FYEAR.selectedIndex = 0; // select current year
  df.FMONTH.selectedIndex = month; // select current month
  df.FDAY.selectedIndex = day-1; // select current day
  df.TYEAR.selectedIndex = 0; // select current year
  df.TMONTH.selectedIndex = month; // select current month
  df.TDAY.selectedIndex = day-1; // select current day
}
// Load Stores
function doStrSelect(id) {
    var df = document.forms[0];
    var stores = [<%=sStr%>];
    var storeNames = [<%=sStrName%>];

    for (idx = 0; idx < stores.length; idx++)
    {
      df.STORE.options[idx] = new Option(stores[idx] + " - " + storeNames[idx],
                                         stores[idx]);
     }
}
//==============================================================================
// Validate form
//==============================================================================
  function Validate(form){
    var msg;
    var error = false;
    var emp = [<%=sEmp%>];
    var found = false;

    var num = 0;

    // correct entry before validation
    // convert to uppercase
    form.EMPLOYEE.value = form.EMPLOYEE.value.toUpperCase();
    // put "all" if empty
      var empty = true;
      for(i=0; i < form.EMPLOYEE.value.length; i++){
         if(form.EMPLOYEE.value.substring(i,i) != " "){
            empty = false;
         }
      }
      if(empty) {
         form.EMPLOYEE.value = "ALL" ;
      }



    if (form.EMPLOYEE.value != "ALL" && !isNum(form.EMPLOYEE.value)){
        error = true;
        msg = "Invalid Employee Number";
    }
    else {
       if (form.EMPLOYEE.value != "ALL"){
           //num = padZeros(form.EMPLOYEE.value);
           num = form.EMPLOYEE.value;
           for (i=1; i < emp.length; i++){
             if (eval(emp[i]) == eval(num)){
               found = true;
             }
           if (eval(num) < eval(emp[i])) break;
          }

          if (!found) {
             msg = "Employee Number " + num + " is not found";
             error = true;
          }
       }
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

 // pad zero in string
 function padZeros(num){
  var len = num.length;
  for(i=0; i<(4 - len);i++){
    num = "0" + num;
  }
  return num;
 }
</script>


<HTML><HEAD>
<SCRIPT language=JavaScript>
		document.write("<style>body {background:ivory;}");
		document.write("table.DataTable { background:#FFE4C4;}");
		document.write("td.DataTable { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }");
		document.write("</style>");
           </SCRIPT>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-- saved from url=(0088)http://192.168.20.64:8080/servlet/formgenerator.FormGenerator?FormGrp=TICKETS&Form=BBT01 -->
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
        <BR>Employee Purchase Inquiry</B>

      <FORM  method="GET" action="servlet/emppurchinq.EmpPurchInq" onSubmit="return Validate(this)">
      <TABLE>
        <TBODY>
        <TR>
          <TD class=DataTable align=right >Store:</TD>
          <TD class=DataTable align=left>
             <SELECT name="STORE"></SELECT>
          </TD>
        </TR>
        <TR>
          <TD class=DataTable align=right >Employee:</TD>
          <TD class=DataTable align=left>
             <INPUT name="EMPLOYEE" size="10" maxlength="10"> (optional)
          </TD>
        </TR>
        <TR>
          <TD class=DataTable align=right >SKU:</TD>
          <TD class=DataTable align=left>
             <INPUT name="SKU" size="10" maxlength="10"> (optional)
          </TD>
        </TR>
        <TR>
          <TD class=DataTable align=right >Searching:</TD>
          <TD class=DataTable align=left>
             <INPUT name="EMPTYPE" type="radio" value="BUYER" checked>Sold To
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <INPUT name="EMPTYPE" type="radio" value="SELLER">Sold By
          </TD>
        </TR>
        <TR>
          <TD class=DataTable align=right >From Date:</TD>
          <TD class=DataTable align=left>
           <SELECT name="FMONTH">
                <OPTION value="01">January</OPTION><OPTION value="02">February</OPTION>
                <OPTION value="03">March</OPTION><OPTION value="04">April</OPTION>
                <OPTION value="05">May</OPTION><OPTION value="06">June</OPTION>
                <OPTION value="07">July</OPTION><OPTION value="08">August</OPTION>
                <OPTION value="09">September</OPTION><OPTION value="10">October</OPTION>
                <OPTION value="11">November</OPTION><OPTION value="12">December</OPTION>
             </SELECT>
             <SELECT name="FDAY">
                <OPTION value="01">1</OPTION><OPTION value="02">2</OPTION>
                <OPTION value="03">3</OPTION><OPTION value="04">4</OPTION>
                <OPTION value="05">5</OPTION><OPTION value="06">6</OPTION>
                <OPTION value="07">7</OPTION><OPTION value="08">8</OPTION>
                <OPTION value="09">9</OPTION><OPTION value="10">10</OPTION>
                <OPTION value="11">11</OPTION><OPTION value="12">12</OPTION>
                <OPTION value="13">13</OPTION><OPTION value="14">14</OPTION>
                <OPTION value="15">15</OPTION><OPTION value="16">16</OPTION>
                <OPTION value="17">17</OPTION><OPTION value="18">18</OPTION>
                <OPTION value="19">19</OPTION><OPTION value="20">20</OPTION>
                <OPTION value="21">21</OPTION><OPTION value="22">22</OPTION>
                <OPTION value="23">23</OPTION><OPTION value="24">24</OPTION>
                <OPTION value="25">25</OPTION><OPTION value="26">26</OPTION>
                <OPTION value="27">27</OPTION><OPTION value="28">28</OPTION>
                <OPTION value="29">29</OPTION><OPTION value="30">30</OPTION>
                <OPTION value="31">31</OPTION>
              </SELECT>
              <SELECT name="FYEAR">
              </SELECT>
          </TD>
         </TR>
         <TR>
          <TD class=DataTable align=right >To Date:</TD>
          <TD class=DataTable align=left>
           <SELECT name="TMONTH">
                <OPTION value="01">January</OPTION><OPTION value="02">February</OPTION>
                <OPTION value="03">March</OPTION><OPTION value="04">April</OPTION>
                <OPTION value="05">May</OPTION><OPTION value="06">June</OPTION>
                <OPTION value="07">July</OPTION><OPTION value="08">August</OPTION>
                <OPTION value="09">September</OPTION><OPTION value="10">October</OPTION>
                <OPTION value="11">November</OPTION><OPTION value="12">December</OPTION>
             </SELECT>
             <SELECT name="TDAY">
                <OPTION value="01">1</OPTION><OPTION value="02">2</OPTION>
                <OPTION value="03">3</OPTION><OPTION value="04">4</OPTION>
                <OPTION value="05">5</OPTION><OPTION value="06">6</OPTION>
                <OPTION value="07">7</OPTION><OPTION value="08">8</OPTION>
                <OPTION value="09">9</OPTION><OPTION value="10">10</OPTION>
                <OPTION value="11">11</OPTION><OPTION value="12">12</OPTION>
                <OPTION value="13">13</OPTION><OPTION value="14">14</OPTION>
                <OPTION value="15">15</OPTION><OPTION value="16">16</OPTION>
                <OPTION value="17">17</OPTION><OPTION value="18">18</OPTION>
                <OPTION value="19">19</OPTION><OPTION value="20">20</OPTION>
                <OPTION value="21">21</OPTION><OPTION value="22">22</OPTION>
                <OPTION value="23">23</OPTION><OPTION value="24">24</OPTION>
                <OPTION value="25">25</OPTION><OPTION value="26">26</OPTION>
                <OPTION value="27">27</OPTION><OPTION value="28">28</OPTION>
                <OPTION value="29">29</OPTION><OPTION value="30">30</OPTION>
                <OPTION value="31">31</OPTION>
              </SELECT>
              <SELECT name="TYEAR">
              </SELECT>
          </TD>
         </TR>

         <TR>
            <TD></TD>
            <TD class=DataTable align=left colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT>
               &nbsp;&nbsp;&nbsp;&nbsp;
           </TD>
          </TR>
         </TBODY>
        </TABLE>
       </FORM>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
  </BODY>
</HTML>