<%
   //----------------------------------
   // Application Authorization
   //----------------------------------

   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=FrtBillPrtSel.jsp&APPL=ALL");
   }
   else
   {
   }
%>
<script name="javascript">
function bodyLoad(){ }

</script>

<!-- import calendar functions -->
<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<SCRIPT language=JavaScript>
		document.write("<style>body {background:ivory;}");
		document.write("table.Tb1 { background:#FFE4C4;}");
		document.write("td.DTb1 { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }");
		document.write("</style>");
</SCRIPT>

<html>
<head>
<title>Fright Bill - Print Manifest</title>
</head>
<body onload="bodyLoad();">

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
      href="mailto:helpdesk@retailconcepts.cc">Mail to IT</A> <BR>&nbsp;&nbsp;<A
      class=blue href="http://sunandski.com/">Our Internet</A> <BR></FONT></TD>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Freight Bill - Print Manifest</B>

       <!-- -->
      <FORM  method="GET" action="FrtBillPrt.jsp" name="REPORT" >
      <TABLE>
        <TBODY>
        <!-- =============================================================== -->
        <TR>
          <TD class=DTb1 align=right >Fright Bill:</TD>
          <TD class=DTb1 align=left><input name="FrtB" maxlength=10 size=10></TD>
        </TR>
        <!-- =============================================================== -->
        <TR>
            <TD style="border-bottom: darkred solid 1px;" colspan="2">&nbsp;</TD>
        </TR>
        <TR>
            <TD class=DTb1 align=center colSpan=5>&nbsp;&nbsp;&nbsp;&nbsp;
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
