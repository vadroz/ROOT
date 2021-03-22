<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PfQuoteSumSel.jsp&APPL=ALL");
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
 input.Small1 {background:LemonChiffon; font-family:Arial; font-size:10px }

 tr.DataTable { background:white; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:white; font-family:Arial; font-size:12px; font-weight: bold }
        tr.DataTable3 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable4 { background:#FFCC99; font-family:Arial; font-size:10px }
        tr.DataTable5 { background:LemonChiffon; font-family:Arial; font-size:10px }

 th.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center; }

 td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;  padding-right:3px; text-align:left;}
 td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}
 td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:center;}


 div.dvStatus  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }

      td.StrInv { cursor:hand; padding-top:3px; padding-bottom:3px;
                    padding-left:3px; padding-right:3px; border-bottom: darkred solid 1px; text-align:left;}
      td.StrInv1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:left;}
      td.StrLst { background:#FFCC99; border-bottom: darkred solid 1px; border-right: darkred solid 1px;
                    text-align:center; font-size:9px}

</style>


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
function doSelDate(datety){
  var df = document.forms[0];
  var date = new Date(new Date() - 7 * 86400000);
  if(datety == "TODAY") { date = new Date(); }
  if(datety == "SEASON") { date = new Date(); df.FrOrdDate.value = "01/01/" + date.getFullYear()}

  if(datety == "ORD" || datety == "TODAY") { df.FrOrdDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear() }

  date = new Date(new Date());
  if(datety == "ORD" || datety == "TODAY" || datety == "SEASON") { df.ToOrdDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear() }
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
   var frorddt = document.forms[0].FrOrdDate.value
   var toorddt = document.forms[0].ToOrdDate.value

   var url = "PfQuoteSum.jsp?FrOrdDt=" +  frorddt
     + "&ToOrdDt=" + toorddt

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

<html>
<head>
<title>
Patio Furniture Order List
</title>
</head>
<body onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Patio Furniture - All Quote Recap Selection</B>

       <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>

       <!-- -->
      <FORM  method="GET" onSubmit="return Validate(this); " action="javascript:submitForms()" name="REPORT" >
      <TABLE  border=0>
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
              <a href="javascript:showCalendar(1, null, null, 300, 150, document.forms[0].FrOrdDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < iSpace * 2; i++){%>&nbsp;<%}%>

              <b>Quote Date To:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToOrdDate')">&#60;</button>
              <input class="Small" name="ToOrdDate" type="text" value="12/31/2999" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToOrdDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 700, 150, document.forms[0].ToOrdDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelOrdDates" onclick="showAllDates('ORD')">All Date</button>
          </TD>
        </TR>


        <!-- =============================================================== -->
        <TR>
           <TD style="border-top: darkred solid 1px; padding-top: 10px;" class=DTb1 align=center colSpan=6>&nbsp;&nbsp;&nbsp;&nbsp;
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