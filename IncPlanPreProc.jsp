<%@ page import="java.sql.*, java.util.*"%>
<%
String sQtr = request.getParameter("Qtr");
String sGrp = request.getParameter("Grp");

if(sQtr==null) sQtr = "0";
if(sGrp==null) sGrp = "MGR";
%>
<html>
<head>
<title>Incentive Plan Warning</title>
<style>
  body {background:ivory;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
  th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
  th.DataTable1 { background:#FFCC99;  writing-mode: tb-rl; filter: flipv fliph; padding-top:3px;
                  border-top: darkred solid 1px; border-bottom: darkred solid 1px; border-left: darkred solid 1px;
                  text-align:center; font-family:Verdanda; font-size:12px }

  tr.DataTable { background:lightgrey; font-family:Arial; font-size:10px }

  td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:right;}
  marquee.wait01 { background:salmon; font-family:Arial; font-size:24px; width:70%;}              

</style>

<SCRIPT>
//--------------- Global variables -----------------------
var Grp = "<%=sGrp%>";
//--------------- End of Global variables ----------------
//---------------------------------------------
// initialize value on load
//---------------------------------------------
function  bodyload()
{
	var url = "IncPlan5.jsp";
	if(Grp == "MGR6"){ url = "IncPlan6.jsp"; }
	else if(Grp == "MGR"){ url = "IncPlan1.jsp"; }
	url += "?Grp=<%=sGrp%>&Qtr=<%=sQtr%>";
	
    if(document.all.inpRtn.value == "Yes") { url="index.jsp"; }
	window.location.href=url;
}
	
window.onbeforeunload = function() {  document.all.inpRtn.value = "Yes"; }
</SCRIPT>
<script src="MoveBox.js"></script>
<script src="Get_Object_Position.js"></script>

</head>
<body onload="bodyload()">

 <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
   <tr>
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br><%if(sGrp.equals("MGR")){%>Store Manager and Assistant Manager<%}
            else if(sGrp.equals("MGR5")){%>Store Manager and Assistant Manager<%}
            else if(sGrp.equals("MGRPI")){%>Area Manager <%}
            else {%>Floor Supervisor<%}%> Incentive Plan Board
          </b>
      <br><br><br><marquee class="wait01">Wait!!! The Incentive Plan is loading.</marquee>
      <input type="hidden" name="inpRtn" value="0">            
      </td>
     </tr>
     
           
     
  </table>
 </body>
</html>
