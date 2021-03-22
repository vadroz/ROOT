<%@ page import="rciutility.ClassSelect"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("PLNAPPROVE") == null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PlanCopy_B_to_A_Sel.jsp&APPL=ALL");
   }
   else
   {

      ClassSelect divsel = null;
      String sDiv = null;
      String sDivName = null;

      //---------------------------------------------------

      divsel = new ClassSelect();
      sDiv = divsel.getDivNum();
      sDivName = divsel.getDivName();
%>

<style>
  .Small {font-family: times; font-size:10px }
  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var Div = [<%=sDiv%>];
var DivName = [<%=sDivName%>];
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  doDivSelect();
}

//==============================================================================
// popilate division selection
//==============================================================================
function doDivSelect()
{
   var box = document.all.tdDivBox
   var html = "";

   for(var i=0; i < Div.length-1; i++)
   {
      html += "<input name='Div' type='checkbox' value='"  + Div[i+1] + "'>"
            + Div[i+1] + "&nbsp; &nbsp; &nbsp; "
   }
   box.innerHTML = html;
}
//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = " ";

  //--------------------------
  // Check Division selection
  var box = document.all.Div;
  var div = new Array()
  var divsel = false;

  for(var i=0, j=0; i < box.length; i++)
  {
     if(box[i].checked) { divsel = true; div[j] = box[i].value; j++}
  }
  if(!divsel){ error = true; msg="Please, select at least 1 promoting division.\n"}

  //--------------------------
  // Check Year selection
  var yrbox = document.all.Year;
  var year = new Array()
  var yearsel = false;

  for(var i=0, j=0; i < yrbox.length; i++)
  {
     if(yrbox[i].checked) { yearsel = true; year[j] = yrbox[i].value; j++}
  }
  if(!yearsel){ error = true; msg+="Please, select at least 1 year."}



  if (error) alert(msg);
  else
  {
     if(confirm("Do you want to copy plan B to plan A for selected divisions?")) { sbmPlan(div, year) }
  }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(div, year)
{
  var url = "PlanCopy_B_to_A_Save.jsp?Store=ALL"

  // selected division
  for(var i=0; i < div.length; i++)
  {
     url += "&Div=" + div[i]
  }

  // selected year
  for(var i=0; i < year.length; i++)
  {
     url += "&Year=" + year[i]
  }

  document.all.btnSubmit.disabled = true;

  //alert(url)
  window.frame1.location.href=url;
}
//==============================================================================
// re-display plan copy page
//==============================================================================
function redisplayPlanCopy()
{
   frame1.close();
   document.all.btnSubmit.disabled = false;
   location.reload();
}
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<HTML><HEAD><meta http-equiv="refresh">

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>

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
        <BR>Copy Plan B to A - Selection</B>

      <TABLE>
        <TBODY>
        <!-- ------------- Division  --------------------------------- -->
        <TR>
          <TD class="Cell" >Division:</TD>
          <TD class="Cell1" id="tdDivBox">
          </TD>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>

        <!-- ------------- Year --------------------------------- -->
        <TR>
          <TD class="Cell" nowrap>Fiscal Year:</TD>
          <td class="Cell1">
             <input name="Year" type="checkbox" value="0" checked>Current Year &nbsp; &nbsp; &nbsp; &nbsp;
             <input name="Year" type="checkbox" value="1" checked>Next Year
          </td>
        </TD>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>

        <TR>
        <TR>
            <TD></TD>
            <TD align=center colSpan=2>
               <INPUT type=submit name="btnSubmit" value=Submit name=SUBMIT onClick="Validate()">
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