<%@ page import="policy.FormLst, java.io.File"%>
<%
   String sGroup = request.getParameter("Group");
   String sGrpName = request.getParameter("GrpName");
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=FormLst.jsp&APPL=ALL");
   }
   else
   {
      FormLst fmgrp = new FormLst(sGroup, session.getAttribute("USER").toString());

      int iNumOfForm = fmgrp.getNumOfForm();
      String [] sForm = fmgrp.getForm();
      String [] sDesc = fmgrp.getDesc();
      String [] sSection = fmgrp.getSection();
      String [] sPolicy = fmgrp.getPolicy();

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
function sbmGroup(card, id)
{
   var url = "DiscountCard.jsp?Card=" + card.replaceSpecChar();
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
      <br>From Group List</b></td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr  class="DataTable">
         <th class="DataTable" nowrap>No.</th>
         <th class="DataTable" nowrap>From</th>
         <th class="DataTable" nowrap>Name</th>
         <th class="DataTable" nowrap>Section</th>
         <th class="DataTable" nowrap>Policy</th>
      </tr>
      <TBODY>

      <!----------------------- Order List ------------------------>
     <%for(int i=0; i < iNumOfForm; i++) {%>
         <tr  class="DataTable">
            <td class="DataTable"><%=i+1%></td>
         <% //String sPath = "/var/tomcat4/webapps/ROOT/PolicyAndForms/Form/" + sForm[i].trim() + ".pdf";
            String sPath = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT/PolicyAndForms/Form/" + sForm[i].trim() + ".pdf";
            File file = new File(sPath);
         %>
            <td class="DataTable" nowrap>
              <%if(file.exists()){%><a href="PolicyAndForms/Form/<%=sForm[i].trim()%>.pdf"><%=sForm[i]%></a>
              <%} else {%><%=sForm[i]%><%}%>
            </td>
            <td class="DataTable" nowrap><%=sDesc[i]%></td>
            <td class="DataTable"><%=sSection[i]%></td>
            <td class="DataTable"><%=sPolicy[i]%></td>
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