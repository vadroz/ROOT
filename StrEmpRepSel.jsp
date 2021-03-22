<%@ page import="rciutility.StoreSelect"%>
<% StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   StrSelect = new StoreSelect();
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();
%>

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script name="javascript">
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
	
  	// Populate division and department menus
      doStrSelect();
  	// populate date with yesterdate
      doSelDate();
  	// populate number of days included in report
      doNumOfDays();
}

// Load Stores
function doStrSelect(id) {
    var df = document.forms[0];
    var stores = [<%=sStr%>];
    var storeNames = [<%=sStrName%>];

    for (idx = 0; idx < stores.length; idx++)
                df.STORE.options[idx] = new Option(stores[idx] + " - " + storeNames[idx],stores[idx]);
}

// populate date with yesterdate
function  doSelDate(){
  var df = document.forms[0];
  var date = new Date(new Date() - 86400000);  
  df.selDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

function doNumOfDays()
{
  var df = document.forms[0];
  for (i = 0; i < 40; i++)
       df.Days.options[i] = new Option(i+1,i+1);
}

// Validate form
  function Validate(form){
    var msg;
    var vld = new Date(document.forms[0].selDate.value)
    var minYear=1999
    var maxYear= (new Date()).getFullYear();
    var error = false;


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
  td.DataTable { background:moccasin; padding-left:3px;padding-right:3px;
                 padding-top:3px;padding-bottom:3px; font-size:12px }
</style>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD colSpan=2 height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top width="15%" bgColor=#a7b5e8><FONT face=Arial color=#445193
      size=2>&nbsp;&nbsp;<A class=blue
      href="../">Home</A></FONT><FONT
      face=Arial color=#445193 size=1>
      <H5>&nbsp;&nbsp;Miscellaneous</H5>&nbsp;&nbsp;<A class=blue
      href="mailto:">Send e-mail</A> <BR>&nbsp;&nbsp;<A
      class=blue href="http://sunandski.com/">Our Internet</A> <BR></FONT></TD>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Salesperson By Date Report</B>

      <FORM  method="GET" action="servlet/strempslsrep.EmpSales" onSubmit="return Validate(this)">
      <TABLE>
        <TBODY>
        <TR>
          <td class=DataTable align=right >Store:</td>
          <td class=DataTable align=left>
             <SELECT name="STORE"></SELECT>
          </td>
        </TR>
        <TR>
          <TD class=DataTable align=right >Report Date:</TD>
          <TD class=DataTable>
              <input name="selDate" type="text" size=10 maxlength=10>
              <a href="javascript:showCalendar(1, null, null, 300, 250, document.forms[0].selDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </TD>
         </TR>
         <TR>
           <TD class=DataTable>
               Including prior days:
           </TD>
            <TD class=DataTable>
               <SELECT  name="Days"></SELECT>
           </TD>
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