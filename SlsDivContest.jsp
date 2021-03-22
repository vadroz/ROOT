<%@ page import="rciutility.StoreSelect, rciutility.DivDptClsSelect"%>
<% StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;
   DivDptClsSelect DivSelect = null;
   String sDiv = null;
   String sDivName = null;
   // get store list
   StrSelect = new StoreSelect();
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();
   //get division list
   DivSelect = new DivDptClsSelect();
   sDiv = DivSelect.getDivNum();
   sDivName = DivSelect.getDivName();

%>

<script name="javascript">
//==============================================================================
// populate selection fields at load time
//==============================================================================
function bodyLoad(){
  var df = document.forms[0];
  var time=new Date(new Date().getTime() - 86400000); // get prior date
  var year = time.getFullYear();
  var month = time.getMonth();
  var day = time.getDate();

  // Populate division and department menus
      doStrSelect();
      doDivSelect(null);
      doNumOfDays()

  // load 7 years
  for (idx = 0; idx < 7; idx++){
       df.YEAR.options[idx] = new Option(year + '', year + '');
       year--;
  }
  df.YEAR.selectedIndex = 0; // select current year
  df.MONTH.selectedIndex = month; // select current month
  df.DAY.selectedIndex = day-1; // select current day

}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id) {
    var df = document.forms[0];
    var stores = [<%=sStr%>];
    var storeNames = [<%=sStrName%>];

    for (idx = 0; idx < stores.length; idx++)
    {
      df.STORE.options[idx] = new Option(stores[idx] + ' - ' + storeNames[idx],
                                           stores[idx]);
    }
    }

//==============================================================================
// Load Division
//==============================================================================
function doDivSelect(id) {
    var df = document.forms[0];
    var divisions = [<%=sDiv%>];
    var divisionNames = [<%=sDivName%>];
    var allowed;

    if (id == null || id == 0) {
        //  populate the division list
        for (idx = 1; idx < divisions.length; idx++)
            df.DIVISION.options[idx-1] = new Option(divisionNames[idx],divisions[idx]);
    }
}

//==============================================================================
// populate days selection menu
//==============================================================================
function doNumOfDays()
{
  var df = document.forms[0];
  for (i = 0; i < 31; i++)
       df.Days.options[i] = new Option(i+1,i+1);
}
//==============================================================================
// Validate form
//==============================================================================
function showRepBy(strsel)
{
  if (strsel.options[strsel.selectedIndex].value=="ALL") document.all.trRepBy.style.display="block";
  else
    {
      document.all.trRepBy.style.display="none";
      document.forms[0].repBy[0].checked=false;
      document.forms[0].repBy[1].checked=true;
    }

}
//==============================================================================
// Validate form
//==============================================================================
  function Validate(form){
    var msg;
    var error = false;

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
      size=2>&nbsp;&nbsp;<A class="blue" href="/">Home</A></FONT><FONT
      face=Arial color=#445193 size=1>
      <H5>&nbsp;&nbsp;Miscellaneous</H5>&nbsp;&nbsp;<A class=blue
      href="mailto:helpdesk@retailconcepts.cc">Mail to IT</A> <BR>&nbsp;&nbsp;<A
      class=blue href="http://sunandski.com/">Our Internet</A> <BR></FONT></TD>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Salesperson by Division Report</B>

      <FORM  method="GET" action="servlet/slscontests.DivSlsContest" onSubmit="return Validate(this)">
      <TABLE>
        <TBODY>
        <TR>
          <TD class=DataTable align=right >Store:</TD>
          <TD class=DataTable align=left>
             <SELECT name="STORE" onChange="showRepBy(this)"></SELECT>
          </TD>
        </TR>
        <TR>
          <TD class=DataTable1 align=right>Division:</TD>
          <TD class=DataTable1 align=left>
             <SELECT name="DIVISION"></SELECT>
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
         <!-- -----------------------------------------------------------    -->
         <TR>
           <TD class=DataTable>
               Including prior days:
           </TD>
            <TD class=DataTable>
               <SELECT  name="Days"></SELECT>
           </TD>
         </TR>
         <!-- -----------------------------------------------------------    -->
         <tr></tr>
         <TR id="trRepBy">
           <TD class=DataTable>
               Report By:
           </TD>
            <TD class=DataTable>
               <input  name="repBy" type="radio" value="S" checked>Store<br>
               <input  name="repBy" type="radio" value="E">Employee
           </TD>
         </TR>
         <!-- -----------------------------------------------------------    -->
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