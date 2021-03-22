<%@ page import="java.util.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PatioSalesFYAnalysisSel.jsp&APPL=ALL");
   }
   else
   {
%>

<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:bottom}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:middle}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:middle; font-weight:bold;text-decoration:underline}

  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  doSelDate();
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate()
{
  var df = document.all;
  var date = new Date(new Date());
  date.setHours(18)
  var year = date.getFullYear();
  if (date.getMonth() >= 3) { year += 1; }

  df.Year.value = year;
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var year = eval(document.all[id].value);

  if(direction == "DOWN") year += -1;
  else if(direction == "UP") year++;
  document.all[id].value = year;
}
//==============================================================================
// Validate form
//==============================================================================
function Validate(excel)
{
  var error = false;
  var msg = "";

  var year = document.all.Year.value.trim();
  var mon = "ALL";
  var week = "ALL";

  var type = document.all.Type[0].value;
  if (document.all.Type[1].checked) {type =  document.all.Type[1].value}

  if (error) alert(msg);
  else{ sbmPlan(year, mon, week, type) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(year, mon, week, type)
{
  var url = "PatioSalesFYAnalysis.jsp?Year=" + year
    + "&Mon=" + mon
    + "&Week=" + week
    + "&Type=" + type

  //alert(url)
  window.location.href=url;
}
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
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
        <BR>Patio Furniture Flash Sales - Selection</B>

      <TABLE>
        <TBODY>
        <!-- ========================Fiscal Year ============================= -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell" >Fiscal Year:</TD>
            <TD class="Cell1" nowrap>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'Year')">&#60;</button>
              <input class="Small" name="Year" type="text" size=4 maxlength=4 readOnly>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'Year')">&#62;</button>&nbsp;&nbsp;&nbsp;
            </TD>
          </TR>
        <!-- ========================Sales Date ============================= -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colspan=2>Date Type Selection</TD>
        <TR>
            <TD class="Cell1"  colspan=2 nowrap>
              <input class="Small" name="Type" type="radio" value="O" checked>By Order Date &nbsp; &nbsp; &nbsp;
              <input class="Small" name="Type" type="radio" value="D">By Delivery Date
            </TD>
          </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate(false)">
           </TD>
          </TR>
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>