<%@ page import=" posend.DivSel"%>
<%
 //----------------------------------
 // Application Authorization
 //----------------------------------

 if (session.getAttribute("USER")==null)
 {
   response.sendRedirect("SignOn1.jsp?TARGET=POListSel.jsp&APPL=ALL");
 }
 else
 {
     if(session.getAttribute("POSEND")==null){response.sendRedirect("index.jsp");}

     String sUser = session.getAttribute("USER").toString();

     DivSel select = new DivSel(sUser);
     String sDiv = select.getDiv();
     String sDivName = select.getDivName();
     String sUsrDiv = select.getUsrDiv();
     String sUsrDivName = select.getUsrDivName();
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
var AllDiv = <%=sDiv%>;
var AllDivNames = <%=sDivName%>;
var UsrDiv = <%=sUsrDiv%>;
var UsrDivNames = <%=sUsrDivName%>;

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   doDivSelect();
   doSelDate();
}

//==============================================================================
// popilate division selection
//==============================================================================
function doDivSelect(id)
{
   var html = "";
   var half = Math.round(AllDiv.length/2) - 1;
   for(var i=0; i < AllDiv.length; i++)
   {
      html += "<input name='Div' type='checkbox' value=" + AllDiv[i]
           + checkUsrDiv(AllDiv[i])
           + " onClick='checkDivSel(this)'>" + AllDiv[i] + "&nbsp;&nbsp;&nbsp;"
      if( i == half) html += "<BR>"

   }

   document.all.dvDivSel.innerHTML = html;
}
//==============================================================================
// check User Division
//==============================================================================
function checkUsrDiv(div)
{
   var found = "";
   for(var i=0; i < UsrDiv.length; i++)
   {
      if(UsrDiv[i] == div) found = " checked ";
   }
   return found;
}
//==============================================================================
// check Division Selection
//==============================================================================
function checkDivSel(div)
{
  if(div.value=="ALL" && div.checked)
  {
     for(var i=1; i <AllDiv.length ; i++) { document.all.Div[i].checked = false}
  }
  else { document.all.Div[0].checked = false }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  doSelDate()
{
  var df = document.forms[0];
  var date = new Date(new Date());
  df.FromDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
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

  // check if at least 1 division selected
  var sel = false;
  for(var i=0; i <AllDiv.length ; i++) { if(document.all.Div[i].checked) sel = true}
  if (!sel) document.all.Div[0].checked = true


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
        <BR>Available Purchase Order List - Selection</B>

        <br><a href="../"><font color="red">Home</font></a>


   <FORM  method="GET" action="POList.jsp" onSubmit="return Validate(this)">
      <TABLE>
       <TBODY>
       <!-- =============================================================== -->
        <TR id="trDDC">
          <TD align=left valign="top" colspan="2">Division:&nbsp;
             <div id="dvDivSel"></div>
          </TD>
        </TR>
       <!-- =============================================================== -->
       <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>

        <TR>
          <TD align=right >Vendor:</TD>
          <TD align=left>
             <input name="Vendor" size=5 maxlength=5>
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
        <TR>
          <TD align=center colspan=2><br>Date Type:&nbsp;
              <input name="DaType" type="radio" value="L" checked>Logging &nbsp;&nbsp;&nbsp;
              <input name="DaType" type="radio" value="S">Shipping&nbsp; &nbsp;&nbsp;
              <input name="DaType" type="radio" value="A">Anticipation &nbsp;&nbsp;&nbsp;
              <input name="DaType" type="radio" value="O">Ordering &nbsp;&nbsp;&nbsp;
          </TD>
        </TR>
         <!-- ======================== Open/Close ======================================= -->
         <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>
        <TR>
          <TD align=center colspan=2><br>Status:&nbsp;
              <input name="Sts" type="radio" value="O" checked>Open&nbsp;&nbsp;&nbsp;
              <input name="Sts" type="radio" value="C">Closed&nbsp;&nbsp;&nbsp;
              <input name="Sts" type="radio" value="B">Both
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
<%
  System.out.println(out.toString());
}%>