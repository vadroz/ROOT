<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EmpTestSel.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
%>

<html>
<head>

<style>
   body {background:ivory;}
   a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
   table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
   th.DataTable { padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;background:#FFE4C4;border-right: darkred solid 1px;text-align:center; font-family:Arial; font-size:10px }
   td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px; }
   td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
   td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }

   div.dvWarning { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:18px}
   div.dvWarn { position: absolute;  top: expression(this.offsetParent.scrollTop+20); left:20px; background-attachment: scroll;
              border: red solid 3px; width:300px;  z-index:50; padding:3px; background-color:white;
              text-align:center; font-size:14px}

</style>;


<SCRIPT language="JavaScript">
//==============================================================================
// initialize procedures
//==============================================================================
function bodyLoad()
{
}

//==============================================================================
// validate entry
//==============================================================================
function Validate(){
   var msg = "";
   var error = false;

   var emp = document.all.Emp.value.trim()
   var fname = document.all.FName.value.trim().toUpperCase()
   var lname = document.all.LName.value.trim().toUpperCase()

   if(emp != "" && isNaN(emp)) { error = true; msg = "Employee Number must be numeric.\n" }
   //else if( eval(emp) < 5000) { error = true; msg = "Incorrect Employee Number.\n" }

   if(fname == "" || fname.length < 2) { error = true; msg = "Enter your first name.\n" }
   if(lname == "" || lname.length < 2) { error = true; msg = "Enter your last name.\n" }

   // display error or check employee number
   if (error){alert(msg)}
   else { checkEmp(emp, fname, lname) }
}
//==============================================================================
// check if employee exist
//==============================================================================
function checkEmp(emp, fname, lname)
{
   var html = "<br><marquee><b>Wait! Employee name validation are in progress.</b></marquee><br><br>"

   document.all.dvWarning.innerHTML = html;
   document.all.dvWarning.style.pixelLeft= document.documentElement.scrollLeft + 200;
   document.all.dvWarning.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvWarning.style.visibility = "visible";

   SbmString = "EmpCheckName.jsp" + "?Emp=" + emp
       + "&FName=" + fname
       + "&LName=" + lname
   //alert(SbmString);
   //window.location.href=SbmString;
   window.frame1.location.href=SbmString;
}
//==============================================================================
// show the error
//==============================================================================
function displayError(error)
{
   hidePanel();
   window.frame1.location.href=null;
   window.frame1.close();
   alert(error);
}
//==============================================================================
// start testing
//==============================================================================
function submitForm(emp, fname, lname)
{
   hidePanel();
   SbmString = "EmpTest.jsp" + "?Emp=" + emp
       + "&FName=" + fname
       + "&LName=" + lname
   //alert(SbmString);
   window.location.href=SbmString;
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvWarning.innerHTML = " ";
   document.all.dvWarning.style.visibility = "hidden";
}

</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

</head>
<!-- ========================================================================= -->
 <body  onload="bodyLoad();">
 <!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvWarning" class="dvWarning"></div>

<!-------------------------------------------------------------------->
<div class="dvWarn">
      <span style="font-size:18px;"><b>ATTENTION!!!</b></span>
      <p style="text-align:left; ">You must notify Store Operations of all rehires by sending an ACTION 
          to the "Training(Training Tests,General)" Action Group.
          Failure to do so may result in inaccurate reporting.
</div>
<!-------------------------------------------------------------------->
  <table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2" align=center>
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Employee Test<br></b>

      <form name="getStore" action="javascript:Validate()">
      <table>
      <tr>
         <td>Employee Number:</td><td><input name="Emp" size="4" maxlength="4" autocomplete="off"></td>
      </tr>
      <tr>
         <td>First Name:</td><td><input name="FName" size="15" maxlength="15" autocomplete="off"></td>
      </tr>
      <tr>
         <td>Last Name:</td><td><input name="LName" size="15" maxlength="15" autocomplete="off"></td>
      </tr>
      <tr>
         <td colspan="2" align="center"><input type="submit" value="Submit" autocomplete="off"></td>
      </tr>
      </table>
      </form>
                </td>
            </tr>
       </table>

        </body>
      </html>
<%}%>