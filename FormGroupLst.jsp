<%@ page import="policy.FormGroupLst ,java.util.*, java.text.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=FormGroupLst.jsp&APPL=ALL");
   }
   else
   {
      FormGroupLst fmgrp = new FormGroupLst(session.getAttribute("USER").toString());

      int iNumOfForm = fmgrp.getNumOfForm();
      String [] sGroup = fmgrp.getGroup();
      String [] sDesc = fmgrp.getDesc();

      fmgrp.disconnect();
%>

<html>
<head>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }

        td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}

        <!--------------------------------------------------------------------->
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
// submit Card panel
//==============================================================================
function sbmGroup(group, grpname)
{
   var url = "FormLst.jsp?Group=" + group.replaceSpecChar()
           + "&GrpName=" + grpname;
   //alert(url)
   window.location.href=url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvStatus" class="dvStatus"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
      <b>Retail Concepts, Inc
      <br>Form Group List</b></td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr  class="DataTable">
         <th class="DataTable" nowrap>No.</th>
         <th class="DataTable" nowrap>Form Group</th>
      </tr>
      <TBODY>

      <!----------------------- Order List ------------------------>
     <%for(int i=0; i < iNumOfForm; i++) {%>
         <tr  class="DataTable">
            <td class="DataTable"><%=i+1%></td>
            <td class="DataTable"><a href="javascript: sbmGroup('<%=sGroup[i].trim()%>', '<%=sDesc[i]%>')"><%=sDesc[i]%></a></td>
         </tr>
     <%}%>
      <!---------------------------------------------------------------------->
      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>

  </table>
 </body>
</html>
<%}%>