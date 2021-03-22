<%@ page import="java.util.*"%>
<%
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
</style>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
}
//==============================================================================
// validate entries
//==============================================================================
function validate()
{
   var error = null;
   var msg = "";
   var file = document.all.File.value.trim(" ").toUpperCase();
   var lib = document.all.Lib.value.trim(" ").toUpperCase();
   var mbr = document.all.Mbr.value.trim(" ").toUpperCase();

   if (file==" " || file == "") {error=true; msg="Enter file name.\n"}
   if (lib==" " || lib == "") {error=true; msg +="Enter library name."}
   if (mbr==" " || mbr == "") {error=true; msg +="Enter member name."}

   if(error) { alert(msg); }
   else { sbmPgmSrc(file, lib, mbr); }
}
//==============================================================================
// validate entries
//==============================================================================
function sbmPgmSrc(file, lib, mbr)
{
    var url = "PgmSrcUtility.jsp?"
            + "File=" + file
            + "&Lib=" + lib
            + "&Mbr=" + mbr
    //alert(url)
    window.location.href = url;
}
</SCRIPT>
<script LANGUAGE="JavaScript" src="String_Trim_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------------------->
    <table ALIGN="Center" border="0" cellPadding="0" cellSpacing="0">
<!-------------------------------------------------------------------------------->
     <tr>
      <td  VALIGN="TOP" colspan="2" nowrap>
           <b><u>Select Program Source</u></b><br><br>
      </td>
    </tr>
      <tr>
        <td ALIGN="right" width="45%">File:&nbsp; </td>
        <td ALIGN="left" ><input name="File" type="text" value="QRPGLESRC" maxlength="10" size="12">
      </tr>
      <tr>
        <td ALIGN="right">Library:&nbsp;</td>
        <td ALIGN="left"><input name="Lib" type="text" maxlength="10" size="12" value="*LIBL"></td>
      </tr>
      <tr>
        <td ALIGN="right">Member:&nbsp;</td>
        <td ALIGN="left"><input name="Mbr" type="text" maxlength="10" size="12"></td>
      </tr>
      <tr>
        <td ALIGN="right">&nbsp;</td>
        <td ALIGN="center" ><button onclick="validate()">Submit</button></td>
      </tr>

<!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
