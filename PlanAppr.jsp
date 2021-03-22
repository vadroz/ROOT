<%@ page import="agedanalysis.PlanAppr, rciutility.FormatNumericValue, java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("PLNAPPROVE") == null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PlanSps.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   String [] sStore = request.getParameterValues("STORE");
   String sDivision = request.getParameter("Div");
   String sDepartment = request.getParameter("DEPARTMENT");
   String sClass = request.getParameter("CLASS");
   String sChgPlan = request.getParameter("AlwChg");

   if(sClass == null) sClass = "ALL";

   System.out.println(sDivision + "|" + sDepartment + "|" + sClass);
   PlanAppr plans = new PlanAppr(sDivision, sDepartment, sClass);

   String sDivName = plans.getDivName();
   String sDptName = plans.getDptName();
   String sClsName = plans.getClsName();

   plans.disconnect();

   StringBuffer sbStr = new StringBuffer();
    for(int i=0; i < sStore.length; i++)
    {
       sbStr.append(sStore[i] + " ");
    }
 %>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px } a:visited { color:blue; font-size:10px }  a:hover { color:blue; font-size:10px }
        table.DataTable { border: darkred solid 1px; background:CornSilk;text-align:center;}
        tr.DataTable { background:CornSilk; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px;
                       text-align:left; font-size:12px; font-weight:bold}
        .Small {font-family:Arial; font-size:10px }

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//report parameters
var Store = ["ALL", "1", "2", "3", "4", "5", "8", "10", "11", "12", "20", "28",
             "30", "40", "45", "61", "82", "88", "98", "99" , "100", "101", "199"];
var SelStr = new Array(<%=sStore.length%>);
<%for(int i=0; i < sStore.length; i++) {%>  SelStr[<%=i%>] = "<%=sStore[i]%>"; <%}%>

var Division = "<%=sDivision%>";
var Department = "<%=sDepartment%>";
var Class = "<%=sClass%>";
//--------------- End of Global variables ----------------
function bodyLoad()
{
}

//---------------------------------------------------------
// submit Plan Approving
//---------------------------------------------------------
function Validate()
{
  var error = false;
  var msg = " ";

   //--------------------------
  // Check Year selection
  var yrbox = document.all.Year;
  var year = new Array()
  var yearsel = false;

  for(var i=0, j=0; i < yrbox.length; i++)
  {
     if(yrbox[i].checked) { yearsel = true; year[j] = yrbox[i].value;}
     else{ year[j] = "0"; }
     j++;
  }
  if(!yearsel){ error = true; msg+="Please, select at least 1 year."}



  if (error) alert(msg);
  else
  {
     if(confirm("Do you want approve selected plans?")) { sbmApprove( year) }
  }
  return error == false;
}
//---------------------------------------------------------
// submit Plan Approving
//---------------------------------------------------------
function sbmApprove( year )
{
   var url = "PlanApprSave.jsp"
      + "?DIVISION=" + Division
      + "&DEPARTMENT=" + Department
      + "&CLASS=" + Class
      + "&ChgPlan=<%=sChgPlan%>"

   // check store selected for current inquiry
   for(var i=0; i < SelStr.length; i++) { url += "&STORE=" + SelStr[i]; }

   // selected year
  for(var i=0; i < year.length; i++) { url += "&Year=" + year[i] }

   //alert(url)
   //window.location.href=url;
   window.frame1.location=url;
}

//--------------------------------------------------------
// re-display Planning screen
//--------------------------------------------------------
function returnToSelection()
{
   window.frame1.close();
   javascript:history.back();
}

//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, " "); }
    return s;
}
</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="FormatNumerics.js"></script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

</head>


<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
  <div id="Prompt" class="Prompt"></div>
<!-------------------------------------------------------------------->
    <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP" colspan=3>
        <b>Retail Concepts, Inc
        <br>Planning - Approval</b>
      </td>
     </tr>

     <tr>
      <td ALIGN="Center" VALIGN="TOP" colspan=3><br><br>

      <table class="DataTable" cellPadding="0" cellSpacing="0">
        <tr><td class="DataTable">Store:</td><td class="DataTable"><%=sbStr.toString()%></td></tr>
        <tr><td class="DataTable">Division:</td><td class="DataTable"><%=sDivision%><%if(!sDivision.equals("ALL")){%><%=" - " + sDivName%><%}%></td></tr>
        <tr><td class="DataTable">Department:</td><td class="DataTable"><%=sDepartment%><%if(!sDepartment.equals("ALL")){%><%=" - " + sDptName%><%}%></td></tr>
        <tr><td class="DataTable">Class:</td><td class="DataTable"><%=sClass%><%if(!sClass.equals("ALL")){%><%=" - " + sClsName%><%}%></td></tr>
        <tr><td nowrap>Fiscal Year:</td>
            <td><input name="Year" type="checkbox" value="1" checked>Current Year &nbsp; &nbsp; &nbsp; &nbsp;
                <input name="Year" type="checkbox" value="1" checked>Next Year
            </td>
        </tr>
      </table>

      <br><br>
     </tr>
     <tr>
      <td ALIGN="Center" VALIGN="TOP" colspan="3">
        <a href="/"><font color="red" size="-1">Home</font></a>&#62;
        <a href="PlanningSel.jsp?mode=1"><font color="red" size="-1">Planning Selection</font></a>&#62;
        <font size="-1">This Page.</font>
     </tr>

     <tr>
      <td ALIGN="Center" VALIGN="TOP"  width="20%">
      <button name="Approve" onClick="Validate()" class="Small">Approve</button>&nbsp;&nbsp;
      <button name="Hist" onClick="javascript:history.back()" class="Small">Cancel</button>&nbsp;&nbsp;
   </tr>

  </table>
 </body>
</html>
<%}%>