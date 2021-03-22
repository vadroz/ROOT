<%@ page import="payrollreports.SetAvail, java.util.*"%>
<%
   String sEmpNum = request.getParameter("EMPNUM");
   String sFunction = request.getParameter("FUNCTION");
   String sSelf = request.getParameter("Self");

   String sEmpDayAvail = null;
   String sEmpTimeAvail = null;

   if(sSelf != null) {
     SetAvail setAvl = new SetAvail();
     setAvl.setEmpAvail(sEmpNum.substring(0,4));
     sEmpDayAvail = setAvl.getEmpDayAvailJSA();
     sEmpTimeAvail = setAvl.getEmpTimeAvailJSA();
   }
%>
<html>
<head>
<style>
 body {background:ivory;}
 a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
 a.Menu:link { color:black; text-decoration:none }
 a.Menu:visited { color:black; text-decoration:none }
 a.Menu:hover { color:red; text-decoration:none }
</style>
</head>

<SCRIPT language="JavaScript1.2">
var EmpDayAvail = [<%=sEmpDayAvail%>];
var EmpTimeAvail = [<%=sEmpTimeAvail%>];

<%if(sSelf == null) {%>
  redirect("<%=sEmpNum%>");
<%}
else {%>
  sendAvail("<%=sEmpNum%>");
<%}%>

// resubmit to itself - it will display "wait..." message
function redirect()
{
  document.write("<font color='red'><marquee behavior='alternate'>Wait while retreiving employee availability...<marquee></font>");
  var redir = window.location + "&Self=Yes"
  window.location.href=redir
}

// send employee availability to schedule
function sendAvail(emp)
{
  opener.<%=sFunction%>(emp, EmpDayAvail, EmpTimeAvail);
  window.close();
}
</SCRIPT>

</html>


