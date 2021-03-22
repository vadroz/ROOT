<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("BASIC1")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=ChgUsrPwd.jsp");
}
else
{
  String sUser = session.getAttribute("USER").toString();
%>
<HTML>
<HEAD>
<title>Change_User_Password</title>
<META content="RCI, Inc." name="Employee_Center"></HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:green; font-size:10px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}

        tr.DataTable { background: #E7E7E7; font-size:11px }
        tr.DataTable1 { background: cornsilk; font-size:11px }
        tr.DataTable2 { background: red; font-size:11px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }

        div.dvEmp { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }

</style>


<script name="javascript1.2">

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   document.all.NewPwd.focus()
}

//==============================================================================
// validate new password
//==============================================================================
function Validate()
{
   var error = false;
   var msg = "";
   var newpwd = document.all.NewPwd.value;
   var cnfpwd = document.all.CnfPwd.value;

   if(newpwd == ""){ error = true; msg = "Please, enter new password."}
   else if(newpwd != cnfpwd){ error = true; msg = "New and Confirm passwords are not the same."}
   else if(!isValid(newpwd)){ error = true; msg = "Password cannot contains special characters."}

   if (error) { alert(msg); }
   else { sbmChgPwd(newpwd) }
}

//==============================================================================
//validate stringn for special characters
//==============================================================================
function isValid(str) 
{
    var iChars = "~`!#$%^&*+=-[]\\\';,/{}|\":<>?";
    var valid = true; 
    for (var i = 0; i < str.length; i++) {
       if (iChars.indexOf(str.charAt(i)) != -1) 
       {   
    	   valid = false;
    	   break;
       }
    }
    return valid;
}
//==============================================================================
// validate new password
//==============================================================================
function sbmChgPwd(newpwd)
{
  document.all.btnSbm.disabled = true; // disable submit button

  var html = "<form method='POST' name='ChgPwd' action='SaveNewPwd.jsp'>"
           + "<input name='User'>"
           + "<input name='Pwd'>"
           + "</form>"

  document.all.dvEmp.innerHTML = html;
  document.all.dvEmp.style.width = 250;
  document.all.User.value = "<%=sUser%>"
  document.all.Pwd.value = newpwd

  document.ChgPwd.submit();
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<!-- ======================================================================= -->
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvEmp" class="dvEmp"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Change Your Password
        </B><br>

        <a href="index.jsp" class="small"><font color="red">Home</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;&nbsp;&nbsp;
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0">
         <tr>
           <td>User Id &nbsp; &nbsp; &nbsp;</td><td><%=sUser%></td>
         <tr>
           <td>Enter New Password &nbsp;</td><td><input name="NewPwd" type="password" size=10 mazlength=10></td>
         </tr>
         <tr>
         </tr>
           <td>Confirm New Password &nbsp;</td><td><input name="CnfPwd" type="password" size=10 mazlength=10></td>
         </tr>
       </table>
<!-- ======================================================================= -->
       <button id="btnSbm" onClick="Validate()">Submit</button>
       
       <br> 
       <span>Passwords cannot be greater than 10 (digits) and can only contain letters and numbers (and NO special characters).
       </span>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>