<%@ page import="rciutility.StoreSelect"%>
<% StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   StrSelect = new StoreSelect(4);
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();
%>

<script name="javascript">
function bodyLoad(){
  var df = document.forms[0];
  var time=new Date(new Date().getTime() - 86400000); // get prior date
  var year = time.getFullYear();
  var month = time.getMonth();
  var day = time.getDate();

  // Populate division and department menus
      doStrSelect();

  // load 7 years
  for (idx = 0; idx < 7; idx++){
       df.YEAR.options[idx] = new Option(year + '', year + '');
       year--;
  }
  df.YEAR.selectedIndex = 0; // select current year
  df.MONTH.selectedIndex = month; // select current month
  df.DAY.selectedIndex = day-1; // select current day
}
// Load Stores
function doStrSelect(id) {
    var df = document.forms[0];
    var stores = [<%=sStr%>];
    var storeNames = [<%=sStrName%>];

    for (idx = 0; idx < stores.length-1; idx++)
                df.STORE.options[idx] = new Option(stores[idx+1] + " - " + storeNames[idx+1],stores[idx+1]);
}

// Validate form
  function Validate(form){
    var msg;
    var error = false;

    if (error) alert(msg);
    if(form.NUMDAYS[1].checked == true) form.action = "TimeTblLst1.jsp"

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
      href="mailto:">Send e-mail</A> <BR>&nbsp;&nbsp;<A
      class=blue href="http://sunandski.com/">Our Internet</A> <BR></FONT></TD>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Historical Daily Clocking/Salesperson Inquiry</B>

      <FORM  method="GET" action="TimeTblLst.jsp" onSubmit="return Validate(this)">
      <TABLE>
        <TBODY>
        <TR>
          <TD class=DataTable align=right >Store:</TD>
          <TD class=DataTable align=left>
             <SELECT name="STORE"></SELECT>
          </TD>
        </TR>
        <TR>
          <TD class=DataTable align=right >Report Date:</TD>
          <TD class=DataTable align=left>
           <SELECT name="MONTH">
                <OPTION value="01">January</OPTION><OPTION value="02">February</OPTION>
                <OPTION value="03">March</OPTION><OPTION value="04">April</OPTION>
                <OPTION value="05">May</OPTION><OPTION value="06">June</OPTION>
                <OPTION value="07">July</OPTION><OPTION value="08">August</OPTION>
                <OPTION value="09">September</OPTION><OPTION value="10">October</OPTION>
                <OPTION value="11">November</OPTION><OPTION value="12">December</OPTION>
             </SELECT>
             <SELECT name="DAY">
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
              <SELECT name="YEAR">
              </SELECT>
          </TD>
         </TR>
         <TR>
            <TD class=DataTable align=right >Select 1/7 Days report</TD>
            <TD class=DataTable align=left colSpan=5>
               <INPUT type="radio" name="NUMDAYS" value="1" checked>1 Day
               &nbsp;&nbsp;&nbsp;&nbsp;
               <INPUT type="radio" name="NUMDAYS" value="7" >7 Days
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