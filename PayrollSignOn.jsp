<%@ page import="payrollreports.SignOn, java.util.*"%>
<%
   String sUser = request.getParameter("USER");
   String sPassword = request.getParameter("PASSWORD");
   String sSbmString = request.getParameter("SbmString");
   String sApplication = request.getParameter("APPL");
   String sErrorMsg= null;

   Enumeration  en = request.getParameterNames();
   String sPrmValue = null;
   String sParam = null;
   String sTarget = null;
   StringBuffer sbQuery = new StringBuffer() ;
   String sQstMrk = "?";

    if(sUser == null && sSbmString == null)
    {
      while (en.hasMoreElements())
      {
        sParam = en.nextElement().toString();
        sPrmValue = request.getParameter(sParam);
        if(sParam.equals("TARGET"))
        {
          sTarget = sPrmValue;
        }
        else
        {
          sbQuery.append(sQstMrk + sParam + "=" + sPrmValue);
          sQstMrk = "&";
        }
      }
      sSbmString = sTarget + sbQuery.toString();
     }

    //System.out.println(sSbmString);

   if(sUser!=null)
   {
     SignOn signon = new SignOn(sUser, sPassword, sApplication);
     String sAccess = signon.getAccess();
     String sStore = signon.getStore();

     if(sAccess.equals("E"))
     {
       sErrorMsg = "User Id or password is not valid, please enter again.";
     }
     else if(!sAccess.equals("1") &&
             sSbmString.startsWith("FiscalMonth"))
     {
       sErrorMsg = "Sorry, you are not authorized for the application. "
        + "If you've got this message in error - contact the HQ Help Desk.";
     }
     else
     {
       session.setAttribute("USER", sUser);
       session.setAttribute("ACCESS", sAccess);
       session.setAttribute("STORE", sStore);
       session.setAttribute("APPLICATION", sApplication);
       response.sendRedirect(sSbmString);
     }
     signon.disconnect();
   }

%>

<html>
<head>
<style>body {background:ivory;}");
       a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
       table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
       th.DataTable { padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;background:#FFE4C4;border-right: darkred solid 1px;text-align:center; font-family:Arial; font-size:10px }
       td.DataTable { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
       td.DataTable1 { background:cornsilk; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
</style>
<SCRIPT language="JavaScript">
function bodyLoad()
{
  document.forms[0].USER.focus()
}
</SCRIPT>
          </head>
 <body  onload="bodyLoad();">

  <table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2">
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Application Authorization</b><br>

       <!-- Dispaly Error Message -->
       <%if(sErrorMsg!=null){%>
       <p align=center><font color=red><%=sErrorMsg%></font>
       <%}%>

      <form name="getStore" action="PayrollSignOn.jsp?<%=request.getQueryString()%>" method="POST">
      <table>
      <tr>
         <td>User:</td>
         <td><input name="USER" type="TEXT" size="10" maxlength="10"></td>
      <tr>
        <td>Password:</td>
        <td><input name="PASSWORD" type="PASSWORD"  size="10" maxlength="10"></td>

      </tr>
      <tr>
         <td colspan="2" align="center"><input type="submit" value="Continue"></td>
      </tr>
      </table>

      <input name="SbmString" type="hidden" value="<%=sSbmString  %>">

      </form>
      <br>
      <a href="../"><font color="red" size="-1">Home</font></a>&#62;
    </td>
   </tr>
  </table>
 </body>
</html>
