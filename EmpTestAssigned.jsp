<%@ page import="java.util.*, emptraining.EmpTestAssigned"%>
<%
    String sStore = request.getParameter("Store");
    String sStrName = request.getParameter("StrName");
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("TRAINCHG") == null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=TestQALst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   EmpTestAssigned empassign = new EmpTestAssigned(sStore);
   int iNumOfTst = empassign.getNumOfTst();
   int iNumOfEmp = empassign.getNumOfEmp();
%>
<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue;  font-size:12px;} a:visited { color:blue; font-size:12px;}  a:hover { color:blue; font-size:12px;}

  table.DataTable { border: darkred solid 1px; background:#e7e7e7; text-align:center;}
  tr.DataTable { background:#FFCC99; font-family:Verdanda; text-align:center;
                 font-size:12px; font-weight:bold}
  th.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px;}

  tr.DataTable1 { background:#f7f7f7; font-family:Verdanda; text-align:left; font-size:12px;}
  tr.DataTable2 { background:white; font-family:Verdanda; text-align:left; font-size:12px;}
  tr.DataTable3 { background:cornsilk; font-family:Verdanda; text-align:left; font-size:12px; font-weight:bold}
  tr.DataTable4 { background:darkred; font-family:Verdanda; text-align:left; font-size:2px;}
  tr.DataTable5 { background:yellow; font-family:Verdanda; text-align:left; font-size:12px; font-weight:bold}

  td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;text-align:left; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable1 { background:yellow; border-right: darkred solid 1px; border-bottom: darkred solid 1px;text-align:center; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable2 { background:lightgreen; cursor:hand; border-right: darkred solid 1px; border-bottom: darkred solid 1px;text-align:center; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable3 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;text-align:center; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable4 { background:pink; cursor:hand; border-right: darkred solid 1px; border-bottom: darkred solid 1px;text-align:center; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}

  div.dvQuest { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:600; background-color:LemonChiffon; z-index:100;
              text-align:left; font-size:16px }


  .Small{ text-align:left; font-family:Arial; font-size:10px;}
  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
  td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
  td.Prompt { text-align:left; font-family:Arial; font-size:10px; }
  td.Prompt1 { text-align:center;font-family:Arial; font-size:10px; }
  td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
  td.option { text-align:left; font-size:10px}

</style>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variable
//==============================================================================
var NumOfTst = <%=iNumOfTst%>;
var NumOfEmp = <%=iNumOfEmp%>;
var Test = new Array(<%=iNumOfTst%>);
var TstName = new Array(<%=iNumOfTst%>);
var EmpLst = new Array(<%=iNumOfEmp%>);
var EmpName = new Array(<%=iNumOfEmp%>);
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad(){ }
//==============================================================================
// mark attribute on Item Header
//==============================================================================
function markItem(row, col, cell)
{
  if (cell.innerHTML=="Y")
  {
    cell.innerHTML = "&nbsp;"
  }
  else
  {
    cell.innerHTML = "Y";
  }
  cell.className = "DataTable4";

   var url = "EmpTestAsgnSave.jsp?"
           + "Emp=" + EmpLst[row]
           + "&Test=" + Test[col]
           + "&Action=UPD";

   //alert(url);
   //window.location.href=url
   window.frame1.location.href=url
}
</SCRIPT>

<script LANGUAGE="JavaScript" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript" src="String_Trim_function.js"></script>
</head>

<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvQuest" class="dvQuest"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Employee Test Asignments
       <br>Store: <%=sStore + " - " + sStrName%>
       <br>
       </b>

       <a href="../"><font color="red" size="-1">Home</font></a>;&#62
       <a href="EmpTestAssignedSel.jsp"><font color="red" size="-1">Selection</font></a>;&#62
       <font size="-1">This page</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <!----------------- start of ad table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0" id="tblQuest">
           <thead style="overflow: visible;">
             <tr class="DataTable">
               <th class="DataTable" rowspan="2">Employee</th>
               <th class="DataTable" rowspan="2">Dept</th>
               <th class="DataTable" rowspan="2">Part Time<br>Full Time</th>
               <th class="DataTable" rowspan="2">Sesonal<br>Permanent</th>
               <th class="DataTable" colspan="<%=iNumOfTst%>">Tests</th>
             </tr>

             <tr class="DataTable">
               <%for(int i=0; i < iNumOfTst; i++){%>
               <%
                 empassign.setAvaialTest();
                 String sTest = empassign.getTest();
                 String sTstName = empassign.getTstName();
               %>
                 <th class="DataTable" rowspan="2"><%=sTstName%></th><script LANGUAGE="JavaScript">Test[<%=i%>] = <%=sTest%>; TstName[<%=i%>] = "<%=sTstName%>";</script>
               <%}%>
             </tr>
           </thead>
        <!--------------------- Group List ----------------------------->
         <tbody>
           <%for(int i=0; i < iNumOfEmp; i++){%>
               <%
                 empassign.setAvaialEmp();
                 String sEmp = empassign.getEmp();
                 String sDept = empassign.getDept();
                 String sPtFt = empassign.getPtFt();
                 String sSePe = empassign.getSePe();
                 String sEmpName = empassign.getEmpName();

                 // get employee test assignment
                 empassign.setEmpTestProperty();
                 String [] sAssignByDpt = empassign.getAssignByDpt();
                 String [] sAssignByEmp = empassign.getAssignByEmp();
               %>
               <tr class="DataTable1">
                 <td class="DataTable" nowrap><%=sEmp + " - " + sEmpName%></td><script LANGUAGE="JavaScript">EmpLst[<%=i%>] = <%=sEmp%>; EmpName[<%=i%>] = "<%=sEmpName%>";</script>
                 <td class="DataTable"><%=sDept%></td>
                 <td class="DataTable"><%=sPtFt%></td>
                 <td class="DataTable"><%=sSePe%></td>
                 <%for(int j=0; j < iNumOfTst; j++){%>
                   <%if(sAssignByDpt[j].equals("1")){%><td class="DataTable1" onclick="markItem(<%=i%>, <%=j%>, this)">Y</td>
                   <%} else if(sAssignByEmp[j].equals("1")){%><td class="DataTable2" onclick="markItem(<%=i%>, <%=j%>, this)">Y</td>
                   <%} else {%><td class="DataTable3" onclick="markItem(<%=i%>, <%=j%>, this)">&nbsp;</td><%}%>
                 <%}%>
               </tr>
           <%}%>
         </tbody>
       </table>
       <!----------------- start of ad table ------------------------>
      </td>
     </tr>
    </table>
  </body>
</html>
<%
  empassign.disconnect();
  empassign = null;
  }
%>
