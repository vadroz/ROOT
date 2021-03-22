<%@ page import="inventoryreports.PiCalendar"%>
<%
//-------------- Security ---------------------
if (session.getAttribute("USER")==null)
{
    response.sendRedirect("SignOn1.jsp?TARGET=PISkuInvSel.jsp");
}
else
{
   // get PI Calendar
   PiCalendar setcal = new PiCalendar();
   String sYear = setcal.getYear();
   String sMonth = setcal.getMonth();
   String sDesc = setcal.getDesc();
   setcal.disconnect();
%>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var PiYear = [<%=sYear%>];
var PiMonth = [<%=sMonth%>];
var PiDesc =  [<%=sDesc%>];
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
  popPICal();
}
//==============================================================================
// change Store selection
//==============================================================================
function popPICal()
{
   for(var i=0; i < PiYear.length; i++)
   {
      document.all.PICal.options[i] = new Option(PiDesc[i], PiYear[i] + PiMonth[i]);
   }
}
//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
   var error = false;
   var msg ="";

   var sku = document.all.Sku.value.trim();
   if (isNaN(sku)){ error = true; msg += "Sku must be numeric.\n"}
   else if (eval(sku) <= 0){ error = true; msg += "Sku must be greater than 0.\n"}

   if (error) { alert(msg); }

   return error == false;
}
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<!-- ======================================================================= -->
<HTML><HEAD>

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
      href="/">Home</A></FONT><FONT
      face=Arial color=#445193 size=1>
      <H5>&nbsp;&nbsp;Miscellaneous</H5>&nbsp;&nbsp;<A class=blue
      href="mailto:">Send e-mail</A> <BR>&nbsp;&nbsp;<A
      class=blue href="http://sunandski.com/">Our Internet</A> <BR></FONT></TD>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Sku Physical Inventory Report - Selection</B>

      <FORM  method="GET" action="PISkuInv.jsp" onSubmit="return Validate(this)">
      <TABLE>
        <TBODY>
       <!-- =============================================================== -->
       <TR>
          <TD class="Cell" nowrap>Short SKU:</TD>
          <TD class="Cell1">
             <input name="Sku" maxlength=10 size=10>
          </td>
       </tr>
       <!-- =============================================================== -->
       <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
       <TR>
          <TD class="Cell" nowrap>PI Calendar:</TD>
          <TD class="Cell1">
             <select name="PICal"></select>
          </td>
       </tr>
       <!-- =============================================================== -->
       <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
           <td></td>
            <TD align=left colSpan=2>
               <INPUT type=submit value="Submit" name="Submit">
           </TD>
          </TR>
          <!-- --------------------------------------- -->
         </TBODY>
        </TABLE>
       </FORM>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>