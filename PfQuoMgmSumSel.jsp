<!DOCTYPE html>	
<%@ page import="java.util.*, java.text.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PfQuoMgmSumSel.jsp&APPL=ALL");
   }
   else
   {
      int iSpace = 6;
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>PF-QuoMgmSum</title>



<script name="javascript">
var CstProp = null;
var Cust = null;
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
  document.all.tdDate1.style.display="block"
  document.all.tdDate2.style.display="none"

  setBoxclasses(["BoxName",  "BoxClose"], ["dvStatus"]);
}
//==============================================================================
// show date selection
//==============================================================================
function showDates(datety)
{
   if(datety == "ORD" || datety == "TODAY" || datety == "SEASON")
   {
      document.all.tdDate1.style.display="none"
      document.all.tdDate2.style.display="block"
   }

   doSelDate(datety)
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates(datety)
{
   if(datety == 'ORD')
   {
      document.all.tdDate1.style.display="block"
      document.all.tdDate2.style.display="none"
      document.all.FrOrdDate.value = "01/01/0001"
      document.all.ToOrdDate.value = "12/31/2999"
   }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(datety)
{  
  var date = new Date(new Date() - 7 * 86400000);
  if(datety == "TODAY") { date = new Date(); }
  if(datety == "SEASON") 
  { 
	  date = new Date(); document.all.FrOrdDate.value = "01/01/" + date.getFullYear()
	  date = new Date(); document.all.ToOrdDate.value = "12/31/" + date.getFullYear()
  }

  if(datety == "ORD" || datety == "TODAY") { document.all.FrOrdDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear() }

  date = new Date(new Date());
  if(datety == "ORD" || datety == "TODAY") { document.all.ToOrdDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear() }
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
function Validate()
{
  var error = false;
  var msg = "";

  if (error) alert(msg);
  return error == false;
}
//==============================================================================
// submit form
//==============================================================================
function submitForms()
{
   var frorddt = document.all.FrOrdDate.value
   var toorddt = document.all.ToOrdDate.value

   var url = "PfQuoMgmSum.jsp?FrDate=" +  frorddt
     + "&ToDate=" + toorddt

   //alert(url)
   window.location.href=url
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvStatus.innerHTML = " ";
   document.all.dvStatus.style.visibility = "hidden";
}

window.onbeforeunload = unload_function;

//==============================================================================
// show selected order on the list view
//==============================================================================
function unload_function()
{
    window.onbeforeunload = function()
    {
      //document.all.Order.value = "";
      //document.all.SlsPer.value = "";
    }
}

</script>

<!-- import calendar functions -->
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<body onload="bodyLoad();" class="body">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->


<TABLE class="tbl05">
  <TBODY>
  <TR>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Patio Furniture - All Quote Recap Selection</B>

       <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>

       <!-- -->
      <TABLE  border="0">
        <TBODY>
        <!-- ======================== From Date ======================================= -->
        <TR>
          <TD class=DTb1 id="tdDate1" colspan=6 align=center style="border-top: darkred solid 1px; padding-top: 10px;" >
             <button class="Small" id="btnSelOrdToday" onclick="showDates('SEASON')">This Season</button> &nbsp
             <button class="Small" id="btnSelOrdDates" onclick="showDates('ORD')">Optional Quote Date Selection</button> &nbsp;
          </td>
          <TD class=DTb1 id="tdDate2" colspan=6 align=center style="border-top: darkred solid 1px; padding-top: 10px;" >
             <b>Quote Date From:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrOrdDate')">&#60;</button>
              <input class="Small" name="FrOrdDate" type="text" value="01/01/0001" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrOrdDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 300, 150, document.all.FrOrdDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < iSpace * 2; i++){%>&nbsp;<%}%>

              <b>Quote Date To:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToOrdDate')">&#60;</button>
              <input class="Small" name="ToOrdDate" type="text" value="12/31/2999" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToOrdDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 700, 150, document.all.ToOrdDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelOrdDates" onclick="showAllDates('ORD')">All Date</button>
          </TD>
        </TR>


        <!-- =============================================================== -->
        <TR>
           <TD style="border-top: darkred solid 1px; padding-top: 10px;" class=DTb1 align=center colSpan=6>&nbsp;&nbsp;&nbsp;&nbsp;
               <button type=submit onclick="submitForms()" name=SUBMIT >Submit</button>
           </TD>
        </TR>
       <!-- =============================================================== -->
        </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</body>
</html>
<%}%>