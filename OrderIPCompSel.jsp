<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=OrderIPCompSel.jsp&APPL=ALL");
   }
   else
   {
      int iSpace = 6;
%>

<style>
 body {background:ivory;}
 table.Tb1 { background:#FFE4C4;}
 td.DTb1 { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }
 td.DTb11 { border-right: darkred solid 1px; align:left;
            padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }
 .Small { font-size: 10px }
</style>


<script name="javascript">
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
  document.all.tdDate1.style.display="block"
  document.all.tdDate2.style.display="none"

  // check all open statuses
  document.all.AllOpnSts.checked = true;
  chkAllSts(document.all.AllOpnSts, true);
}
//==============================================================================
// show date selection
//==============================================================================
function showDates(show)
{
   document.all.tdDate1.style.display="none"
   document.all.tdDate2.style.display="block"
   doSelDate()
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates()
{
   document.all.tdDate1.style.display="block"
   document.all.tdDate2.style.display="none"
   document.all.FromDate.value = "01/01/0001"
   document.all.ToDate.value = "12/31/2999"
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(){
  var df = document.forms[0];
  var date = new Date(new Date() - 7 * 86400000);
  df.FromDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

  date = new Date(new Date());
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
// Validate form entry fields
//==============================================================================
function Validate() {
  var error = false;
  var msg;
  var sts = false

  // validate status
  for(var i=0; i < document.forms[0].Status.length; i++)
  {
     if(document.forms[0].Status[i].checked) sts = true;
  }
  // validate from date
  if (!sts)
  {
    msg = " Please, check at least 1 status\n"
    error = true;
  }

  if (error) alert(msg);
  return error == false;
}
//==============================================================================
// submit form
//==============================================================================
function submitForms()
{
   var from = document.forms[0].FromDate.value
   var to = document.forms[0].ToDate.value

   var url = "OrderIPComp.jsp?From=" +  from
           + "&To=" + to;
   // set requered statuses
   for(var i=0; i < document.forms[0].Status.length; i++)
   {
      if(document.forms[0].Status[i].checked) url += "&Status=" + document.forms[0].Status[i].value
   }

   // set requered special order statuses
   for(var i=0; i < document.forms[0].InclSO.length; i++)
   {
      if(document.forms[0].InclSO[i].checked) url += "&InclSO=" + document.forms[0].InclSO[i].value
   }

   // set requered special order statuses
   for(var i=0; i < document.forms[0].SoStatus.length; i++)
   {
      if(document.forms[0].SoStatus[i].checked) url += "&SoStatus=" + document.forms[0].SoStatus[i].value
   }

   //alert(url)
   window.location.href=url
}
//==============================================================================
// Show Special Order Statuses
//==============================================================================
function showSoSts(inprog)
{
  if(inprog.checked){ document.all.divSpcOrd.style.display = "block"; }
  else { document.all.divSpcOrd.style.display = "none"; }
  for(var i=0; i < document.all.SoStatus.length;i++)
  {
    document.all.SoStatus[i].checked=false;
  }
}
//==============================================================================
// check all open order statuses
//==============================================================================
function chkAllSts(allsts, type)
{
    var mark = allsts.checked;
   // set requered statuses
   for(var i=0; i < document.forms[0].Status.length; i++)
   {
      // Check/uncheck open orders
      if(type && document.forms[0].Status[i].value != "O" && document.forms[0].Status[i].value != "C" && document.forms[0].Status[i].value != "D")
      {
         document.forms[0].Status[i].checked = mark;
      }
      // Check/uncheck closed orders
      else if(!type && (document.forms[0].Status[i].value == "C" || document.forms[0].Status[i].value == "D"))
      {
         document.forms[0].Status[i].checked = mark;
      }
   }

   // Check/uncheck special order statuses
   if(type)
   {
      for(var i=0; i < document.all.SoStatus.length;i++)
      {
          document.all.SoStatus[i].checked=mark;
      }
      if (mark) document.all.divSpcOrd.style.display = "block";
      else document.all.divSpcOrd.style.display = "none";
   }
}
//==============================================================================
// uncheck all open
//==============================================================================
function unChkAll(chkbox, type)
{
   if(type && !chkbox.checked) document.all.AllOpnSts.checked=false;
   else document.all.AllClsSts.checked=false;
}
</script>

<!-- import calendar functions -->
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>


<html>
<head>
<title>
Patio Furniture Order List
</title>
</head>
<body onload="bodyLoad();">

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Patio Furniture - Order List Selection</B>

       <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>

       <!-- -->
      <FORM  method="GET" onSubmit="return Validate(this)" action="javascript:submitForms()" name="REPORT" >
      <TABLE>
        <TBODY>
        <!-- =============================================================== -->
        <TR >
            <TD valign=top align=center colspan=4><b><u>Select Order Type</u></b></TD>
        </tr>
        <TR >
            <td colspan=1>&nbsp;</td>
            <TD class=DTb1 align=left><%for(int i=0; i < iSpace*5; i++){%>&nbsp;<%}%>
              <INPUT type="radio" name="InclSO" value="N" >In-Stock Orders Only<br><%for(int i=0; i < iSpace*5; i++){%>&nbsp;<%}%>
              <INPUT type="radio" name="InclSO" value="O" >Special Orders Only<br><%for(int i=0; i < iSpace*5; i++){%>&nbsp;<%}%>
              <INPUT type="radio" name="InclSO" value="B" checked>Both<br>
            </TD>
        </TR>
        <!-- =============================================================== -->
        <TR>
            <TD style="border-top: darkred solid 1px; padding-top: 10px; border-bottom: darkred solid 1px; padding-bottom: 10px;" align=center valign=top colspan=4>
              <b><u>Select Order Status</u></b>
            </TD>
        </TR>
        <TR>
            <TD align=right valign=top>
                <b>Open Orders:</b>
            </TD>
              <TD class=DTb11>
                <INPUT type="checkbox" name="AllOpnSts" onclick="chkAllSts(this, true)" value="ALL">All Open Orders<br><br>
                <b>Payment Status:</b><br>
                <INPUT type="checkbox" name="Status" onclick="unChkAll(this, true)" value="O" >Unpaid<br>
                <INPUT type="checkbox" name="Status" onclick="unChkAll(this, true)" value="F" >Paid-In-Full<br>

                <b>In-Progress:</b><br><%for(int i=0; i < iSpace; i++){%>&nbsp;<%}%>
                <INPUT type="checkbox" name="Status" onClick="unChkAll(this, true)" value="T" >In-Stock Orders<br><%for(int i=0; i < iSpace; i++){%>&nbsp;<%}%>
                <INPUT type="checkbox" name="Status" onClick="showSoSts(this); unChkAll(this, true)" value="T" >Special Orders<br>

                <div id="divSpcOrd"><%for(int i=0; i < iSpace * 2; i++){%>&nbsp;<%}%>
                <b>Special Order Status:</b><br><%for(int i=0; i < iSpace * 2; i++){%>&nbsp;<%}%>
                <INPUT type="checkbox" name="SoStatus" value="N">Non-Approved<br><%for(int i=0; i < iSpace * 2; i++){%>&nbsp;<%}%>
                <INPUT type="checkbox" name="SoStatus" value="A">Approved<br><%for(int i=0; i < iSpace * 2; i++){%>&nbsp;<%}%>
                <INPUT type="checkbox" name="SoStatus" value="V">Placed-w/Vendor<br><%for(int i=0; i < iSpace * 2; i++){%>&nbsp;<%}%>
                <INPUT type="checkbox" name="SoStatus" value="R">Received-@-DC<br>
                </div>
                <INPUT type="checkbox" name="Status" onclick="unChkAll(this, true)" value="R">Ready-To-Deliver
            </TD>
            <TD valign=top>
                <b>Closed Orders:</b>
            </TD>
              <TD class=DTb1 valign=top align=left>
                <INPUT type="checkbox" name="AllClsSts" onclick="chkAllSts(this, false)" value="ALL">All Closed Orders<br><br>
                <INPUT type="checkbox" name="Status" onclick="unChkAll(this, false)" value="C">Completed<br>
                <INPUT type="checkbox" name="Status" onclick="unChkAll(this, false)" value="D">Canceled
        </TR>
        <!-- ======================== From Date ======================================= -->
        <TR>
          <TD class=DTb1 id="tdDate1" colspan=4 align=center style="border-top: darkred solid 1px; padding-top: 10px;" >
             <button id="btnSelDates" onclick="showDates()">Optional Date Selection</button>
          </td>
          <TD class=DTb1 id="tdDate2" colspan=4 align=center style="border-top: darkred solid 1px; padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FromDate')">&#60;</button>
              <input class="Small" name="FromDate" type="text" value="01/01/0001" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FromDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 300, 250, document.forms[0].FromDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < iSpace * 2; i++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate')">&#60;</button>
              <input class="Small" name="ToDate" type="text" value="12/31/2999" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 300, 250, document.forms[0].ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelDates" onclick="showAllDates()">All Date</button>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR>
            <TD style="border-top: darkred solid 1px; padding-top: 10px;" class=DTb1 align=center colSpan=5>&nbsp;&nbsp;&nbsp;&nbsp;
               <INPUT type=submit value=Submit name=SUBMIT >
           </TD>
          </TR>
       <!-- =============================================================== -->
        </TBODY>
        </TABLE>
       </FORM>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</body>
</html>
<%}%>