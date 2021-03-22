<%@ page import="agedanalysis.PlanApprStsLst, rciutility.FormatNumericValue, java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("PLAN") == null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PlanApprStsLst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   String [] sStore = request.getParameterValues("STORE");
   String sDivision = request.getParameter("DIVISION");
   String sDepartment = request.getParameter("DEPARTMENT");
   String sClass = request.getParameter("CLASS");

   PlanApprStsLst apprsts = new PlanApprStsLst(sStore, sDivision, sDepartment, sClass);

   int iNumOfStr = apprsts.getNumOfStr();
   String [] sStr = apprsts.getStr();

   int iNumOfGrp = apprsts.getNumOfGrp();
   String [] sGrp = apprsts.getGrp();
   String [] sGrpName = apprsts.getGrpName();
   String [][] sSts = apprsts.getSts();

   String sDivName = apprsts.getDivName();
   String sDptName = apprsts.getDptName();
   String sClsName = apprsts.getClsName();

   String sGrpJsa = apprsts.getGrpJsa();
   String sGrpNameJsa = apprsts.getGrpNameJsa();
   String sStsJsa = apprsts.getStsJsa();

   apprsts.disconnect();

   StringBuffer sbStr = new StringBuffer();
   for(int i=0; i < sStore.length; i++)
   {
      sbStr.append(sStore[i] + " ");
   }

   String sColHdg = null;
   if(!sClass.equals("ALL") || !sDepartment.equals("ALL")) sColHdg = "Class";
   else if(!sDivision.equals("ALL")) sColHdg = "Department";
   else sColHdg = "Division";
 %>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px } a:visited { color:blue; font-size:10px }  a:hover { color:blue; font-size:10px }
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        th.DataTable { background:#FFCC99;padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        tr.Button { background:ivory; padding-left:3px; padding-right:3px; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        th.InvData { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.InvData { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:right;}


        tr.DataTable { background:#EfEfEf; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
              border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}

        td.DataTable0 { background:red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable1 { background:yellow; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}
        td.DataTable2 { background:green; color:white; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:left;}

        input.Cell {border:none; background:none; width:55; text-align:right; font-family:Arial; font-size:10px }

        div.dvForm {background:Khaki; border: darkblue solid 2px; padding-top:3px; height:30px;
                    font-family:Arial; font-size:10px; text-align:center;}
        select.Small {font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }

        div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt {border-bottom: black solid 2px; border-right: black solid 1px; text-align:center;
                   font-family:Arial; font-size:10px; }

        td.misc1{ filter:progid:DXImageTransform.Microsoft.Gradient(
                  startColorStr=#c3fdb8, endColorStr=#99c68e, gradientType=0);
                 padding-top:0px; border:darkgreen 1px solid;
                 color: darkblue; vertical-align:middle; text-align:center; font-size:12px; }


</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
//report parameters
var Grp = [<%=sGrpJsa%>];
var GrpName = [<%=sGrpNameJsa%>];
var Status = [<%=sStsJsa%>];

var Store = new Array(<%=sStore.length%>);
<%for(int i=0; i < sStore.length; i++) {%>  Store[<%=i%>] = "<%=sStore[i]%>"; <%}%>

var Division = "<%=sDivision%>";
var Department = "<%=sDepartment%>";
var Class = "<%=sClass%>";

//--------------- End of Global variables ----------------
function bodyLoad()
{
}
//--------------------------------------------------------
// re-display Planning screen
//--------------------------------------------------------
function drillDown(arg)
{
   var url = "PlanApprStsLst.jsp?STORE=" + Store;

   if(Department != "ALL")
   {
      url += "&DIVISION=" + Division
           + "&DEPARTMENT=" + Department
           + "&CLASS=" + Grp[arg]
   }
   else if(Division != "ALL")
   {
      url += "&DIVISION=" + Division
           + "&DEPARTMENT=" + Grp[arg]
           + "&CLASS=ALL"
   }
   else
   {
      url += "&DIVISION="  + Grp[arg]
           + "&DEPARTMENT=ALL"
           + "&CLASS=ALL"
   }

   //alert(url)
   window.location.href=url;
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
      <td ALIGN="center" VALIGN="TOP">
        <b>Retail Concepts, Inc
        <br>Plan Approval Status Report
        <br>Division: <%=sDivision%><%if(!sDivision.equals("ALL")){%><%=" - " + sDivName%><%}%>
        Department: <%=sDepartment%><%if(!sDepartment.equals("ALL")){%><%=" - " + sDptName%><%}%>
        Class: <%=sClass%><%if(!sClass.equals("ALL")){%><%=" - " + sClsName%><%}%></b>
      <br><br>
     </tr>
     <tr>
      <td ALIGN="Center" VALIGN="TOP">
        <a href="/"><font color="red" size="-1">Home</font></a>&#62;
        <a href="PlanApprStsSel.jsp?mode=1"><font color="red" size="-1">Selection</font></a>&#62;
        <font size="-1">This Page.</font>
     </tr>

     <tr>
         <td ALIGN="Center" VALIGN="TOP">
         <table class="DataTable" cellPadding="0" cellSpacing="0">
            <tr><th class="DataTable">Status Color Code</th></tr>
            <tr class="DataTable"><td class="DataTable0">None is approved</td></tr>
            <tr class="DataTable"><td class="DataTable1">Some of the classes are approved</td></tr>
            <tr class="DataTable"><td class="DataTable2">All classes are approved</td></tr>
         </table><br><br>


     <table class="DataTable" cellPadding="0" cellSpacing="0">
      <tr>
        <th class="DataTable" rowspan="2"><%=sColHdg%></th>
        <th class="DataTable" colspan="<%=iNumOfStr%>">Store</th>
      </tr>
      <tr>
        <%for(int i=0; i < iNumOfStr; i++) {%><th class="DataTable"><%=sStr[i]%></th><%}%>
      </tr>
     <!---------------- Detail ---------------------------------------------------->
      <%for(int i=0; i < iNumOfGrp; i++) {%>
          <tr class="DataTable">
             <%if(!sColHdg.equals("Class")) {%>
                  <td class="DataTable"><a href="javascript: drillDown(<%=i%>)">
                      <%=sGrp[i] + " - " + sGrpName[i]%></a>
                  </td>
             <%}
               else {%><td class="DataTable"><%=sGrp[i] + " - " + sGrpName[i]%></td>
             <%}%>

             <%for(int j=0; j < iNumOfStr; j++) {%>
                <td class="DataTable<%=sSts[i][j]%>">&nbsp;&nbsp;&nbsp;&nbsp;</td>
              <%}%>
          </tr>
      <%}%>
    </table>
    </td>
   </tr>

   <tr>
      <td ALIGN="Center" VALIGN="TOP"  width="20%">
      <button name="Hist" onClick="javascript:history.back()" class="Small">Back</button>&nbsp;&nbsp;
  </tr>

  </table>
 </body>
</html>
<%}%>