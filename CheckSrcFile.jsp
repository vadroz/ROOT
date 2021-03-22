<%@ page import="java.io.*"%>
<%
%>


<script name="JavaScript1.2">


function bodyLoad()
{
}

// Validate form entry fields
function Validate() {

  if (error) alert(msg);
  return error == false;
}
</script>
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
<title>
Fright Bill Report
</title>
</head>
<body onload="bodyLoad();">

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD colSpan=2 height="20%"><IMG
    src="Sun_ski_logo1.jpg"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top width="15%" bgColor=#a7b5e8><FONT face=Arial color=#445193
      size=2>&nbsp;&nbsp;<A class=blue
      href="/">Home</A></FONT><FONT
      face=Arial color=#445193 size=1>
      <H5>&nbsp;&nbsp;Miscellaneous</H5>&nbsp;&nbsp;<A class=blue
      href="mailto:helpdesk@retailconcepts.cc">Mail to IT</A> <BR>&nbsp;&nbsp;<A
      class=blue href="http://sunandski.com/">Our Internet</A> <BR></FONT></TD>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Source File Backup</B>

       <!-- -->
      <TABLE>
        <TBODY>
        <TR>
          <TD class=DTb1 align=right >Date:</TD>
          <TD><input name="NewFile" type="file" size=80>
          </TD>
        </TR>
        <TR>
            <TD></TD>
            <TD class=DTb1 align=left colSpan=5>&nbsp;&nbsp;&nbsp;&nbsp;
               <button onClick="javascript:Validate()" >Submit</button>
           </TD>
          </TR>
        </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</body>
</html>
