<%@ page import="java.util.*, emptraining.GroupTest"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("TRAINCHG") == null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=GroupTest.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   GroupTest grptst = new GroupTest();
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue;  font-size:12px;} a:visited { color:blue; font-size:12px;}  a:hover { color:blue; font-size:12px;}

  table.DataTable { border: darkred solid 1px; background:#e7e7e7; text-align:center;}
  table.DataTable1 { background:#e7e7e7; text-align:left; font-size:12px;}

  tr.DataTable { background:#FFCC99; font-family:Verdanda; text-align:center;
                 font-size:12px; font-weight:bold}
  th.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px;}

  tr.DataTable1 { background:#f7f7f7; font-family:Verdanda; text-align:left; font-size:12px;}
  tr.DataTable2 { background:white; font-family:Verdanda; text-align:left; font-size:12px;}
  tr.DataTable3 { background:cornsilk; font-family:Verdanda; text-align:left; font-size:12px; font-weight:bold}



  td.DataTable { border-bottom: darkred solid 1px; border-right: darkred solid 1px;text-align:left;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable1 { border-bottom: darkred solid 1px;text-align:center;
                  padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                  border-right: darkred solid 1px;}
  td.DataTable3 { border-bottom: darkred solid 1px; border-right: darkred solid 1px;text-align:left;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                 font-size:11px; font-weight:bold}

  div.dvPrompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:300; background-color:LemonChiffon; z-index:100;
              text-align:center; font-size:10px }


  .Small{ text-align:left; font-family:Arial; font-size:10px;}
  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
  td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
  td.Prompt { text-align:left;font-family:Arial; font-size:10px; }
  td.Prompt1 { text-align:center;font-family:Arial; font-size:10px; }
  td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
  td.option { text-align:left; font-size:10px}
</style>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variable
//==============================================================================
var Action = null;
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
   document.all.GroupName.focus();
}
//==============================================================================
// populate entry field for update and delete
//==============================================================================
function popEntryFld(grp, grpnm, sort, action)
{
   if(action=="UPD") { document.all.thAction.innerHTML = "Ready to UPDATE existing group" }
   else { document.all.thAction.innerHTML = "Ready to DELETE existing group" }

   document.all.Group.value = grp;
   document.all.GroupName.value = grpnm;
   document.all.Sort.value = sort;
   Action = action;
   document.all.GroupName.focus();
}
//==============================================================================
// start test
//==============================================================================
function validate()
{
   var msg = "";
   var error = false;
   var grp = document.all.Group.value.trim();
   var grpnm = document.all.GroupName.value.trim();
   var sort = document.all.Sort.value.trim();

   if(grpnm==""){ error=true; msg += "Group Name is not entered.\n"}
   if(isNaN(sort)){ error=true; msg +="Sort value must be numeric.\n"}
   if(Action==null) { Action = "ADD"; }

   if(error){ alert(msg)}
   else {submitGroup(grp, grpnm, sort); }
}

//==============================================================================
// start test
//==============================================================================
function submitGroup(grp, grpnm, sort)
{
   var url = "GroupTestEnt.jsp?"
           + "Group=" + grp
           + "&GroupName=" + grpnm
           + "&Sort=" + sort
           + "&Action=" + Action
   //alert(url)
   window.frame1.location.href=url
}
//==============================================================================
// reset fields
//==============================================================================
function reset()
{
   document.all.thAction.innerHTML = "Ready to ADD a NEW group"
   document.all.Group.value="";
   document.all.GroupName.value="";
   document.all.Sort.value="";
   Action = null;
   document.all.GroupName.focus();
}
//==============================================================================
// restart application after heading entry
//==============================================================================
function reStart()
{
   window.location.reload();
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>

<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvPrompt" class="dvPrompt"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Group Test Entry/List
       <br>
       </b>

        <a href="../"><font color="red" size="-1">Home</font></a>;&#62
        <font size="-1">This page</font>
        <!----------------- Entry form ------------------------>
         <table class="DataTable1" border=1 cellPadding="0" cellSpacing="0">
             <tr>
               <th id="thAction" style="text-align:center;" colspan="2">Ready to ADD a NEW group</th>
             </tr>
             <tr>
               <td>Group Name:</td>
               <td><input class="Small" name="GroupName" maxlength=100 size=100>
                   <input class="Small" name="Group" type="hidden"></td>
             </tr>
             <tr>
               <td>Sort:</td>
               <td><input class="Small" name="Sort" maxlength=5 size=5></td>
             </tr>
             <tr style="text-align:center">
               <td colspan=2><button class="Small" onClick="validate()">Submit</button>&nbsp;&nbsp;&nbsp;&nbsp;
               <button class="Small" onClick="reset()">Clear</button></td>
             </tr>
         </table>
         <br><br>
        <!----------------- start of table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0">
           <thead style="overflow: visible;">
             <tr class="DataTable">
               <th class="DataTable">Group</th>
               <th class="DataTable">Sort</th>
               <th class="DataTable">D<br>l<br>t</th>
             </tr>
         </thead>
        <tbody>
        <!----------------- Details ----------------------------------------->
        <% while(grptst.Next()){%>
            <%
              grptst.setGroupProperty();
              String sGroup = grptst.getGroup();
              String sSort = grptst.getSort();
              String sGrpName = grptst.getGrpName();
            %>
            <!-- ----------------------------------------------------------- -->
              <tr class="DataTable1" id="trGroup">
                <td class="DataTable" id="tdGroup"><a href="javascript: popEntryFld('<%=sGroup%>','<%=sGrpName%>','<%=sSort%>','UPD')"><%=sGrpName%></a></td>
                <td class="DataTable1">&nbsp;<%=sSort%></td>
                <td class="DataTable1"><a href="javascript: popEntryFld('<%=sGroup%>','<%=sGrpName%>','<%=sSort%>','DLT')">&nbsp;D&nbsp;</a></td>
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
  grptst.disconnect();
}
%>