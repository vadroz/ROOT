<%@ page import=" rciutility.StoreSelect"%>
<%
    StoreSelect selstr = new StoreSelect();
    String sStr = selstr.getStrNum();
    String sStrName = selstr.getStrName();
%>
<!-- ================================================================================================================================ -->
<style>body {background:ivory;}
        button.Small {padding-top:1px; font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }
</style>
<!-- ================================================================================================================================ -->

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   doStrSelect();
   doSelDate();
}

//==============================================================================
// popilate Store selection
//==============================================================================
function doStrSelect(id)
{
    var df = document.forms[0];
    for (var i = 0; i < stores.length; i++)
    {
      df.STORE.options[i] = new Option(stores[i] + " - " + storeNames[i], stores[i]);
    }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  doSelDate()
{
  var df = document.forms[0];
  var date = new Date(new Date() - 7 * 86400000);
  df.FromDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

  date = new Date(new Date() - 86400000);
  df.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);


  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// Validate form
//==============================================================================
function Validate(){
  var form = document.forms[0];
  var error = false;
  var msg = " ";
  if (error) alert(msg);

  return error == false;
}

//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, ""); }
    return s;
}
</script>
<!-- import calendar functions -->
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Preferred Customer Number (PCN) Recap - Selection</B>

        <br><a href="../"><font color="red">Home</font></a>


   <FORM  method="GET" action="PCNRecap.jsp" onSubmit="return Validate(this)">
      <TABLE>
       <TBODY>
       <!-- =============================================================== -->
        <TR id="trDDC">
          <TD align=right valign="top">Store:</TD>
          <TD align=left>
             <SELECT name="STORE"></SELECT>
          </TD>
        </TR>
        <!-- ======================== From Date ======================================= -->
        <TR>
          <TD class=DTb1 align=right >From Date:</TD>
          <TD valign="middle">
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FromDate')">&#60;</button>
              <input name="FromDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FromDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 300, 250, document.forms[0].FromDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </TD>
        </TR>
        <!-- ======================== To Date ======================================= -->
        <TR>
          <TD class=DTb1 align=right >To Date:</TD>
          <TD>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate')">&#60;</button>
              <input name="ToDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 300, 250, document.forms[0].ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD></TD>
            <TD align=left colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT>
           </TD>
          </TR>
         </TBODY>
        </TABLE>
       </FORM>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
