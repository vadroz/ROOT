<%@ page import=" rciutility.DivDptClsSelect, rciutility.StoreSelect"%>
<% DivDptClsSelect ItmSelect = null;
   StoreSelect StrSelect = null;
   String sDiv = null;
   String sDivName = null;
   String sDpt = null;
   String sDptName = null;
   String sDptGroup = null;
   String sStr = null;
   String sStrName = null;

   ItmSelect = new DivDptClsSelect();
   sDiv = ItmSelect.getDivNum();
   sDivName = ItmSelect.getDivName();
   sDpt = ItmSelect.getDptNum();
   sDptName = ItmSelect.getDptName();
   sDptGroup = ItmSelect.getDptGroup();

   StrSelect = new StoreSelect();
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();
%>
<!- -------------------------------------------------------------
 Calendar
--------------------------------------------------------------- ->
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<!- ------------------------------------------------------------ ->
<script name="JavaScript1.2">
//--------------------------------------------------------------
// Global variables
//--------------------------------------------------------------
var amtSwitch

//--------------------------------------------------------------
function bodyLoad(){
  var df = document.forms[0];

  // Populate division and department menus
  doDivSelect(null);
  // populate Store menu
  doStrSelect();
  // populate date with yesterday
  doSelDate();

  switchAmtPct();
}

//-----------------------------------------------------
// Load Stores
//-----------------------------------------------------
function doStrSelect(id) {
    var df = document.forms[0];
    var stores = [<%=sStr%>];
    var storeNames = [<%=sStrName%>];

    for (idx = 0; idx < stores.length; idx++)
    {
      df.STORE.options[idx] = new Option(stores[idx] + ' - ' + storeNames[idx],stores[idx]);
    }
}
//-----------------------------------------------------
// Load Division
//-----------------------------------------------------
function doDivSelect(id) {
    var df = document.forms[0];
    var divisions = [<%=sDiv%>];
    var divisionNames = [<%=sDivName%>];
    var depts = [<%=sDpt%>];
    var deptNames = [<%=sDptName%>];
    var dep_div = [<%=sDptGroup%>];

    var allowed;

    if (id == null || id == 0) {
        //  populate the division list
        for (idx = 0; idx < divisions.length; idx++)
            df.DIVISION.options[idx] = new Option(divisionNames[idx],divisions[idx]);
        id = 0;

    }
        allowed = dep_div[id].split(":");

        //  clear current depts
        for (idx = df.DEPARTMENT.length; idx >= 0; idx--)
            df.DEPARTMENT.options[idx] = null;

        //  if all are to be displayed
        if (allowed[0] == "all")
            for (idx = 0; idx < depts.length; idx++)
                df.DEPARTMENT.options[idx] = new Option(deptNames[idx],depts[idx]);

        //  else display the desired depts
        else
            for (idx = 0; idx < allowed.length; idx++)
                df.DEPARTMENT.options[idx] = new Option(deptNames[allowed[idx]],
                                                          depts[allowed[idx]]);
    }

//---------------------------------------------------------------
// populate date with yesterdate
//---------------------------------------------------------------
function  doSelDate(){
  var df = document.forms[0];
  var date = new Date(new Date() - 86400000);
  df.FromDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  df.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}


//--------------------------------------------------------------
// Switch text on criteria from percentage to amount
//--------------------------------------------------------------
  function switchAmtPct()
  {
     if(amtSwitch)
     {
       amtSwitch = false;
       document.all.CrtName.innerHTML="Dollar Amount off between";
       document.all.SwitchLnk.innerHTML=
          "<a href='javascript: switchAmtPct()'>Switch</a> to Percents";
       document.all.AMTTYPE.value = "A";
     }
     else
     {
       amtSwitch = true;
       document.all.CrtName.innerHTML="Discount % off between";
       document.all.SwitchLnk.innerHTML=
          "<a href='javascript: switchAmtPct()'>Switch</a> to Amount";
       document.all.AMTTYPE.value = "P";
     }
  }
//--------------------------------------------------------------
// Validate form
//--------------------------------------------------------------
  function Validate(form){
    var msg=" ";
    var error = false;

    if (!isNum(form.MIN.value)){
        error = true;
        msg = "Minimum Amount is not numeric\n";
    }

    if (!isNum(form.MAX.value)){
        error = true;
        msg += "Maximum Amount is not numeric\n";
    }

    if (!error && eval(form.MIN.value) > eval(form.MAX.value)){
        error = true;
        msg += "Minimum Amount is greater than Maximum amount";
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


<HTML><HEAD>
<style>
       body {background:ivory;}
       a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
       table.DataTable { background:#FFE4C4;}
       td.DataTable { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }
</style>

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
        <BR>Unauthorized Mardown Report</B>

      <FORM  method="GET" action="UnautMDToExel.jsp" onSubmit="return Validate(this)">
      <TABLE>
        <TBODY>
        <TR>
          <TD class=DataTable align=right >Store:</TD>
          <TD class=DataTable align=left>
             <SELECT name="STORE"></SELECT>
          </TD>
        </TR>
        <TR>
          <TD class=DataTable1 align=right>Division:</TD>
          <TD class=DataTable1 align=left>
             <SELECT name="DIVISION" onchange="doDivSelect(this.selectedIndex);">
               <OPTION value="ALL">All Division</OPTION>
             </SELECT>
             <INPUT type=hidden  name=DIVNAME>
          </TD>
        </TR>
        <TR>
          <TD class=DataTable align=right>Department:</TD>
          <TD class=DataTable align=left>
             <SELECT name=DEPARTMENT >
                <OPTION value="ALL">All Department</OPTION>
             </SELECT>
          </TD>
        </TR>
        <TR>
          <TD class=DataTable align=right >Report Dates:</TD>
          <TD class=DataTable align=left>
             <input name="FromDate" type="text" size=10 maxlength=10>
                <a href="javascript:showCalendar(1, null, null, 510, 270, document.forms[0].FromDate)" >
                <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
             &nbsp; &nbsp;- through -&nbsp;&nbsp;&nbsp;
             <input name="ToDate" type="text" size=10 maxlength=10>
                <a href="javascript:showCalendar(1, null, null, 510, 270, document.forms[0].ToDate)" >
                <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </TD>
         </TR>
         <TR>
            <TD><span id="CrtName"></span></TD>
            <TD><INPUT name="MIN" size=5 value=10>
                 &nbsp;-&nbsp;
                <INPUT name="MAX" size=5 value=25>
              &nbsp;&nbsp;&nbsp;<span id="SwitchLnk"></span>
              <INPUT name="AMTTYPE" type="hidden" size=1>
            </TD>
         </TR>
         <!-- ============================================================== -->
         <!-- Exclude Employee Purchases -->
         <!-- ============================================================== -->
         <TR>
          <TD class=DataTable1 align=right>Exclude Employee Purchases</TD>
          <TD class=DataTable1 align=left>
             <SELECT name="EMPPURCH">
               <OPTION value="Y">Yes</OPTION>
               <OPTION value="N">No</OPTION>
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