<%

%>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<script name="javascript">
function bodyLoad(){
  // populate date with yesterdate
      doSelDate();
}


// populate date with yesterdate
function  doSelDate(){
  var df = document.all;
  var date = new Date(new Date() - 86400000);
  while( date.getDay()!=0 )
  {
     date = new Date(date - 86400000);
  }
  df.selDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

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


  if (!error)
  {
    //var days = parseFloat(form.selDate.value) - 1;
    var from = new Date(vld.getFullYear(), vld.getMonth(), vld.getDate());
    form.selDate.value = (from.getMonth()+1) + "/" + from.getDate() + "/" + from.getFullYear()
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
  td.DataTable { background:moccasin; vertical-align:top;padding-left:3px;padding-right:3px;
                 padding-top:3px;padding-bottom:3px; font-size:12px }
  td.DataTable1 { background:moccasin; border-bottom: darkred solid 1px; }
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
        <BR>Store Payroll by Department - Store Summary</B>

      <FORM  method="GET" action="AvgPayCons.jsp" onSubmit="return Validate(this)">
      <TABLE>
        <TBODY>
        <!-- --------------------- Select Report Day ----------------------- -->
        <TR>
          <TD class=DataTable align=right >Week ending:</TD>
          <TD class=DataTable>
              <input name="selDate" type="text" size=10 maxlength=10>
              <a href="javascript:showCalendar(1, null, null, 300, 250)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </TD>
         </TR>
         <!-- ----------- Number of day prior to selected day ------------- -->
         <TR><td colspan="2" class="DataTable1">&nbsp;</td></tr>
         <TR>
           <TD class=DataTable>
               Show:
           </TD>
            <TD class=DataTable>
               <input name="Info" type="radio" value="D" checked>Dollars<br>
               <input name="Info" type="radio" value="H" >Hours<br>
               <input name="Info" type="radio" value="A" >Average Pay
           </TD>
         </TR>
         <!-- ----------------- Average Pay Groups ------------------------ -->
         <TR><td colspan="2" class="DataTable1">&nbsp;</td></tr>
         <TR>
            <TD colspan="2" class=DataTable>
              <table>
                <TR>
                  <TD class=DataTable><b><u>Consolidate:</u></b></TD>
                  <TD class=DataTable><b><u>Average Pay Groups:</u></b></TD>
                </TR>
                <TR>
                  <TD class=DataTable>
                    <input name="Cons" type="radio" value="C" checked>Selling Commision<br>
                    <input name="Cons" type="radio" value="N" >Selling Non-Commision<br>
                    <input name="Cons" type="radio" value="M" >Manager Assistants<br>
                    <input name="Cons" type="radio" value="B" >Bike Managers<br>
                    <input name="Cons" type="radio" value="O" >Non-Selling Other Department &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
                    <input name="Cons" type="radio" value="H" >Total Hourly<br>
                    <input name="Cons" type="radio" value="T" >Total Pay<br>
                  </TD>
                  <TD class=DataTable>
                    <input name="Cons" type="radio" value="0">Management<br>
                    <input name="Cons" type="radio" value="1" >Sales<br>
                    <input name="Cons" type="radio" value="2" >Cashiers/Oper.Coor.<br>
                    <input name="Cons" type="radio" value="3" >Shipping/Receiving<br>
                    <input name="Cons" type="radio" value="4" >BikeTech<br>
                    <input name="Cons" type="radio" value="5" >Climbing Wall<br>
                    <input name="Cons" type="radio" value="6" >Ski Instructor<br>
                    <input name="Cons" type="radio" value="7" >Ski Tech<br>
                    <input name="Cons" type="radio" value="8" >Merchandise<br>
                 </TD>
                </TR>
              </table>
            </TD>
         </TR>
         <!-- ----------------------- Submit button ------------------------ -->
         <TR><td colspan="2" class="DataTable1">&nbsp;</td></tr>
         <TR>
            <TD></TD>
            <TD class=DataTable align=left colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT>
               &nbsp;&nbsp;&nbsp;&nbsp;
           </TD>
          </TR>
          <!-- -------------------------------------------------------------- -->
         </TBODY>
        </TABLE>
       </FORM>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
  </BODY>
</HTML>