<%@ page import="java.util.*, emptraining.TestLst, emptraining.GroupTest"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("TRAINCHG") == null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=TestLst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   TestLst tstlst = new TestLst();
   GroupTest grptst = new GroupTest();
   int iRow = 0;
%>

<html>
<head>

<style type="text/css">
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
  tr.DataTable3 { background:azure; font-family:Verdanda; text-align:left; font-size:12px;}



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
var NumOfTst = 0;
var Group = new Array();
var GrpName = new Array();
var NumOfGrp = 0;
<% while(grptst.Next()){%><%grptst.setGroupProperty();  String sGroup = grptst.getGroup(); String sGrpName = grptst.getGrpName();%> Group[NumOfGrp] = "<%=sGroup%>"; GrpName[NumOfGrp++] = "<%=sGrpName%>";<%}%>

var Action = null;
var SelctedRow = null;
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
   document.all.TstName.focus();
   document.all.selGroup.options[0] = new Option("--- Group is not assigned ----", 0)
   for(var i=0; i < NumOfGrp; i++)
   {
      document.all.selGroup.options[i+1] = new Option(GrpName[i], Group[i])
   }
}
//==============================================================================
// populate entry field for update and delete
//==============================================================================
function popEntryFld(test, sort, testnm, grp, grpnm, action, row)
{
   if(action=="UPD") { document.all.thAction.innerHTML = "Ready to <font color=green>UPDATE</font> existing test" }
   else { document.all.thAction.innerHTML = "Ready to <font style='color:red;'><blink>DELETE</blink></font> existing test" }

   document.all.Test.value = test;
   document.all.TstName.value = testnm;
   document.all.Sort.value = sort;
   document.all.Group.value = grp;
   document.all.GroupName.value = grpnm;
   Action = action;
   SelctedRow = row
   document.all.TstName.focus();
}

//==============================================================================
// populate group name field
//==============================================================================
function popGrpName(sel)
{
   document.all.Group.value = sel.options[sel.selectedIndex].value;
   document.all.GroupName.value = sel.options[sel.selectedIndex].text
}
//==============================================================================
// start test
//==============================================================================
function validate()
{
   var msg = "";
   var error = false;

   var test = document.all.Test.value;
   var testnm = document.all.TstName.value.replaceSpecChar();
   var testnm_ASIS = document.all.TstName.value;
   var grp = document.all.Group.value.trim();
   var grpnm = document.all.GroupName.value.trim().replaceSpecChar();
   var sort = document.all.Sort.value.trim();

   if(testnm==""){ error=true; msg += "Test Name is not entered.\n"}
   if(isNaN(sort)){ error=true; msg +="Sort value must be numeric.\n"}
   if(Action==null) { Action = "ADD"; }

   if(error){ alert(msg)}
   else {submitTest(test, testnm, grp, grpnm, sort, testnm_ASIS); }
}

//==============================================================================
// start test
//==============================================================================
function submitTest(test, testnm, grp, grpnm, sort, testnm_ASIS)
{
   var url = "TestEnt.jsp?"
           + "Test=" + test
           + "&TstName=" + testnm
           + "&Group=" + grp
           + "&Sort=" + sort
           + "&Action=" + Action
   //alert(url)
   //window.location.href=url
   window.frame1.location.href=url

   if (Action=="ADD") { addTable(test, testnm_ASIS, grp, grpnm, sort); }
   else { updTable(test, testnm_ASIS, grp, grpnm, sort); }
   reset();
}
//==============================================================================
// change table rows
//==============================================================================
function addTable(test, testnm, grp, grpnm, sort)
{
   var tbody = document.getElementById("tblTest").getElementsByTagName("TBODY")[0];
   var row = document.createElement("TR")
   row.className="DataTable3";
   row.id="trTest"; //add ID

   var td = new Array();
   td[0] = addTDElem(testnm, "tdTest" + NumOfTst, "DataTable")
   td[1] = addTDElem(sort, "tdSort" + NumOfTst, "DataTable")
   td[2] = addTDElem(grpnm, "tdGroup" + NumOfTst, "DataTable")
   td[3] = addTDElem("*** New ***", "tdDelete" + NumOfTst, "DataTable")
   td[4] = addTDElem("*** New ***", "tdQA" + NumOfTst, "DataTable")

   // add cell to row
   for(var i=0; i < td.length; i++) { row.appendChild(td[i]); }

   // add row to table
   tbody.appendChild(row);

   NumOfTst = eval(NumOfTst) + 1;
}
//---------------------------------------------------------
// add new TD element
//---------------------------------------------------------
function addTDElem(value, id, classnm)
{
  var td = document.createElement("TD") // Reason
  td.appendChild (document.createTextNode(value))
  td.className=classnm;
  td.id = id;
  return td;
}
//==============================================================================
// change table rows
//==============================================================================
function updTable(test, testnm, grp, grpnm, sort)
{
   var row = SelctedRow;

   if (Action=="UPD")
   {
     if(NumOfTst > 1)
     {
        document.all.tdTest[row].innerHTML = testnm;
        document.all.tdGroup[row].innerHTML = grpnm;
        document.all.tdDelete[row].innerHTML = "*** Updated ***";
        document.all.tdQA[row].innerHTML = "*** Updated ***";
     }
     else
     {
        document.all.tdTest.innerHTML = testnm;
        document.all.tdGroup.innerHTML = grpnm;
        document.all.tdDelete.innerHTML = "*** Updated ***";
        document.all.tdQA.innerHTML = "*** Updated ***";
     }
   }
   else
   {
      if(NumOfTst > 1)
      {
         document.all.tdTest[row].innerHTML = testnm;
         document.all.tdDelete[row].innerHTML = "*** Deleted ***";
         document.all.tdQA[row].innerHTML = "*** Deleted ***";
      }
      else
      {
         document.all.tdTest.innerHTML = testnm;
         document.all.tdDelete.innerHTML = "*** Deleted ***";
         document.all.tdQA.innerHTML = "*** Deleted ***";
      }
   }
}
//==============================================================================
// reset fields
//==============================================================================
function reset()
{
   document.all.thAction.innerHTML = "Ready to ADD a NEW test"
   document.all.Test.value="";
   document.all.TstName.value="";
   document.all.Group.value="";
   document.all.GroupName.value="";
   document.all.Sort.value="";
   Action = null;
   document.all.TstName.focus();
}
//==============================================================================
// set the question/Answer pool
//==============================================================================
function setQandA(test, testnm, grp, grpnm)
{
   var url = "TestQAList.jsp?"
           + "Test=" + test
           + "&TstName=" + testnm
           + "&Group=" + grp
           + "&GrpName=" + grpnm
   //alert(url)
   window.location.href=url
   reset();
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
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

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
       <br>Test Entry/List
       <br>
       </b>

        <a href="../"><font color="red" size="-1">Home</font></a>;&#62
        <font size="-1">This page</font>
        <!----------------- Entry form ------------------------>
         <table class="DataTable1" border=1 cellPadding="0" cellSpacing="0">
             <tr>
               <th id="thAction" style="text-align:center;" colspan="2">Ready to ADD a NEW test</th>
             </tr>
             <tr>
               <td>Test:</td>
               <td><input class="Small" name="TstName" maxlength=100 size=100>
                   <input class="Small" name="Test" type="hidden"></td>
             </tr>
             <tr>
               <td>Sort:</td>
               <td><input class="Small" name="Sort" maxlength=5 size=5></td>
             </tr>
             <tr>
               <td style="vertical-align:top;">Group:</td>
               <td><input class="Small" name="GroupName" maxlength=100 size=100 readOnly>
                   <input class="Small" name="Group" type="hidden"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   <select class="Small" name="selGroup" size="5" onclick="popGrpName(this);"></select>
                </td>
             </tr>
             <tr style="text-align:center">
               <td colspan=2><button class="Small" onClick="validate()">Submit</button>&nbsp;&nbsp;&nbsp;&nbsp;
               <button class="Small" onClick="reset()">Clear</button></td>
             </tr>
         </table>
         <br>
         <button class="Small" onClick="window.location.reload()">Refresh</button><br><br>
        <!----------------- start of table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0" id="tblTest">
           <thead style="overflow: visible;">
             <tr class="DataTable">
               <th class="DataTable">Test</th>
               <th class="DataTable">Sort</th>
               <th class="DataTable">Group</th>
               <th class="DataTable">D<br>l<br>t</th>
               <!-- th class="DataTable">Q & A</th -->
             </tr>
         </thead>
        <tbody>
        <!---------------------- Details -------------------------------------->
        <% while(tstlst.Next()){%>
        <%
              tstlst.setGroupProperty();
              String sTest = tstlst.getTest();
              String sTstSort = tstlst.getTstSort();
              String sTstName = tstlst.getTstName();
              String sGroup = tstlst.getGroup();
              String sGrpName = tstlst.getGrpName();
        %>
        <!-- --------------------------------------------------------------- -->
              <tr class="DataTable1" id="trTest">
                <td class="DataTable" id="tdTest"><a href="javascript: popEntryFld('<%=sTest%>','<%=sTstSort%>','<%=sTstName%>', '<%=sGroup%>','<%=sGrpName%>','UPD', <%=iRow%>)"><%=sTstName%></a></td>
                <td class="DataTable1" id="tdSort">&nbsp;<%=sTstSort%></td>
                <td class="DataTable" id="tdGroup"><%=sGrpName%></td>
                <td class="DataTable1" id="tdDelete"><a href="javascript: popEntryFld('<%=sTest%>','<%=sTstSort%>','<%=sTstName%>', '<%=sGroup%>','<%=sGrpName%>','DLT', <%=iRow++%>)">&nbsp;D&nbsp;</a></td>
                <!--td class="DataTable1" id="tdQA"><a href="javascript: setQandA('<%=sTest%>','<%=sTstName%>', '<%=sGroup%>','<%=sGrpName%>')">&nbsp;Q/A&nbsp;</a></td -->
                <script>NumOfTst++;</script>
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
  tstlst.disconnect();
  tstlst=null;
  grptst.disconnect();
  grptst=null;
}
%>