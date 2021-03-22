<%@ page import="policy.FormDocList, java.io.File"%>
<%
   String sSelStrType = request.getParameter("StrType");
   String sSelStrTypeDesc = request.getParameter("StrTypeDesc");
   String sSelFrmType = request.getParameter("FrmType");
   String sSort = request.getParameter("Sort");
   if(sSelStrType == null) { sSelStrType = "ALL"; sSelStrTypeDesc = "All Forms"; }
   if(sSelFrmType == null) { sSelFrmType = "ALL";}
   if(sSort == null) sSort = "FMTYP";

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=FormDocList.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();

      System.out.println(sSort);
      FormDocList formlst = new FormDocList(sSelStrType, sSelFrmType, sSort, sUser);
      int iNumOfType = formlst.getNumOfType();
      String sStrTypeLst = formlst.getStrTypeLst();
      String sStrTypeLstDesc = formlst.getStrTypeLstDesc();
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
        div.dvFrmTy { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150; background-color: white; z-index:10;
              text-align:center; font-size:10px}
        .Small {font-size:10px;}
        <!--------------------------------------------------------------------->
</style>




<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var StrTypeLst = [<%=sStrTypeLst%>];
var StrTypeLstDesc = [<%=sStrTypeLstDesc%>];
var SelStrType = "<%=sSelStrType%>";
var SelStrTypeDesc = "<%=sSelStrTypeDesc%>";
var Sort = "<%=sSort%>";
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setFormType();
}
//==============================================================================
// set form type table
//==============================================================================
function setFormType()
{
   for(var i = 0; i < StrTypeLst.length; i++)
   {
      document.all.slStrType.options[i] = new Option(StrTypeLstDesc[i], StrTypeLst[i]);
   }

   html = "</select>"
}
//==============================================================================
// submit with selected form types
//==============================================================================
function sbmFormType()
{
   var strty = document.all.slStrType.options[document.all.slStrType.selectedIndex].value.trim();
   var strtyDesc = document.all.slStrType.options[document.all.slStrType.selectedIndex].text.trim();

   if(strty == ""){strty="%20"}
   var url = "FormDocList.jsp?"
           + "StrType=" + strty
           + "&StrTypeDesc=" + strtyDesc
           + "&FrmType=<%=sSelFrmType%>"
           + "&Sort=" + Sort
   //alert(url)
   window.location.href = url;
}
//==============================================================================
// submit with selected form types
//==============================================================================
function reSort(sort)
{
   var url = "FormDocList.jsp?"
           + "StrType=" + SelStrType
           + "&StrTypeDesc=" + SelStrTypeDesc
           + "&FrmType=<%=sSelFrmType%>"
           + "&Sort=" + sort
   //alert(url)
   window.location.href = url;
}
//==============================================================================
// submit with selected form types
//==============================================================================
function showForm(form, sample)
{
   if (sample == "Y") { alert("Do not print this form -  it just a sample.");  }
   else if (sample == "1") { alert("Print this form on 4 x 6 sign paper.");  }
   var url = "/PolicyAndForms/Form/" + form +  ".pdf";

   //alert(url)
   window.location.href = url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvFrmTy" class="dvFrmTy"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>Selected Form Type: <%=sSelStrTypeDesc%>
        </b>
        <br><select class="Small" name="slStrType"></select>
            <button class="Small" onClick="sbmFormType('<%=sSort%>')">Go</button>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr  class="DataTable">
         <!-- th class="DataTable" nowrap><a href="javascript:sbmFormType('GROUP')">Group</a></th -->
         <th class="DataTable" nowrap><a href="javascript:reSort('FORM')">Form</a></th>
         <th class="DataTable" nowrap><a href="javascript:reSort('TYPE')">Store<br>Type</a></th>
         <th class="DataTable" nowrap><a href="javascript:reSort('FMTYP')">Form<br>Type</a></th>
         <th class="DataTable" nowrap><a href="javascript:reSort('DESC')">Name</a></th>
         <th class="DataTable" nowrap>Policy</th>
      </tr>
      <TBODY>
      <!----------------------- Order List ------------------------>
      <%
        while( formlst.getNextRecs() )
        {
           int iNumOfForm = formlst.getNumOfForm();

           if(iNumOfForm > 0)
           {
              formlst.setFormList();

              String [] sGroup = formlst.getGroup();
              String [] sForm = formlst.getForm();
              String [] sStrType = formlst.getStrType();
              String [] sFrmType = formlst.getFrmType();
              String [] sDesc = formlst.getDesc();
              String [] sSection = formlst.getSection();
              String [] sPolicy = formlst.getPolicy();
              String [] sPlcDesc = formlst.getPlcDesc();
              String [] sSample = formlst.getSample();
              int [] iNumOfStr = formlst.getNumOfStr();
              String [][] sStr = formlst.getStr();
      %>
            <%for(int i=0; i < iNumOfForm; i++) {%>
               <tr class="DataTable">
                 <td class="DataTable"><a href="javascript: showForm('<%=sForm[i]%>', '<%=sSample[i]%>')"><%=sForm[i]%></a></td>
                 <td class="DataTable"><%=sStrType[i]%></td>
                 <td class="DataTable"><%=sFrmType[i]%></td>
                <td class="DataTable" nowrap><%=sDesc[i]%></td>
                <td class="DataTable"><a href="/PolicyAndForms/Policy/<%=sSection[i]%>.<%=sPolicy[i]%>.pdf"><%=sPlcDesc[i]%></a></td>
              </tr>
            <%}%>
        <%}%>
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
<%
  formlst.disconnect();
  formlst = null;
%>
<%}%>