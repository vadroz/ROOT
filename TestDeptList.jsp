<%@ page import="java.util.*, emptraining.TestDeptList"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("TRAINCHG") == null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=TestQALst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    //System.out.println(0);
    TestDeptList dpttestl = new TestDeptList();
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

  tr.DataTable1 { background:white; font-family:Verdanda; text-align:left; font-size:12px;}
  tr.DataTable2 { background:cornsilk; font-family:Verdanda; text-align:left; font-size:12px;}

  td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;text-align:left; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable1 { text-align:center; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                  border-right: darkred solid 1px;  border-bottom: darkred solid 1px;}
  td.DataTable3 { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:left; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                 font-size:11px; font-weight:bold}

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

</style>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variable
//==============================================================================
var Action = "ADD";
var SelRow = 0;
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
   window.frame1.location.href="EmpDeptLst.jsp";
   window.frame2.location.href="RtvTestLst.jsp";
   //setBoxclasses(["BoxName",  "BoxClose"], ["dvQuest"]);
}
//==============================================================================
// set department list
//==============================================================================
function setDeptList(dept, dptName)
{
   window.frame1.location.href=null;
   window.frame1.close()
   for(var i=0; i < dept.length; i++)
   {
      document.all.selDept.options[i] = new Option(dept[i] + "-" + dptName[i], dept[i])
   }
}
//==============================================================================
// set Test list
//==============================================================================
function setTestList(test, tstName)
{
   window.frame2.location.href=null;
   window.frame2.close()
   for(var i=0; i < test.length; i++)
   {
      document.all.selTest.options[i] = new Option(test[i] + "-" + tstName[i], test[i])
   }
}

//==============================================================================
// populate input Depratment field from selection
//==============================================================================
function selectDept(sel)
{
   document.all.Dept.value = sel.options[sel.selectedIndex].value
   document.all.DptName.value = sel.options[sel.selectedIndex].text
}
//==============================================================================
// populate input Select field from selection
//==============================================================================
function selectTest(sel)
{
   document.all.Test.value = sel.options[sel.selectedIndex].value
   document.all.TstName.value = sel.options[sel.selectedIndex].text
}

//==============================================================================
// populate input Select field from selection
//==============================================================================
function dltDeptTest(dept, deptnm, test, testnm, row)
{
   Action = "DLT";
   SelRow = row;
   document.all.Dept.value = dept;
   document.all.DptName.value = deptnm;
   document.all.Test.value = test;
   document.all.TstName.value = testnm;
   document.all.btnSubmit.innerHTML = "Delete"
   document.all.selDept.disabled=true;
   document.all.selTest.disabled=true;

   submit(dept, deptnm, test, testnm)
}
//==============================================================================
// validate Answwers
//==============================================================================
function validate()
{
   var error = false;
   var msg = '';
   var dept = document.all.Dept.value;
   var deptnm = document.all.DptName.value;
   var test = document.all.Test.value;
   var testnm = document.all.TstName.value;

   if(dept==""){error=true; msg +="Department is not selected.\n"}
   if(test==""){error=true; msg +="Test is not selected.\n"}

   if(error) { alert(msg) }
   else(submit(dept, deptnm, test, testnm))
}
//==============================================================================
// submit test unswered
//==============================================================================
function submit(dept, deptnm, test, testnm)
{
   var url = "TestDeptSave.jsp?"
      + "Dept=" + dept
      + "&DptName=" + deptnm
      + "&Test=" + test
      + "&TstName=" + testnm
      + "&Action=" + Action

   //alert(url)
   //window.location.href=url;
   window.frame1.location.href=url;
}
//==============================================================================
// display error
//==============================================================================
function displayError(msg)
{
   reset();
   alert(msg);
}
//==============================================================================
// update old record
//==============================================================================
function updOldRecord()
{
   if(NumOdDptTst > 1) document.all.tdDelete[SelRow].innerHTML = "*** Deleted ***"
   else { document.all.tdDelete.innerHTML = "*** Deleted ***" }
   reset();
}
//==============================================================================
// change table rows
//==============================================================================
function addNewRecord(dept, deptnm, test, testnm)
{
   var tbody = document.getElementById("tblDptTst").getElementsByTagName("TBODY")[0];
   var row = document.createElement("TR")
   row.className="DataTable2";
   row.id="trDptTest"; //add ID

   NumOdDptTst = eval(NumOdDptTst) + 1;

   var td = new Array();
   td[0] = addTDElem(deptnm, "tdDept" + NumOdDptTst, "DataTable")
   td[1] = addTDElem(testnm, "tdTest" + NumOdDptTst, "DataTable")
   td[2] = addTDElem("*** New ***", "tdDelete" + NumOdDptTst, "DataTable")

   // add cell to row
   for(var i=0; i < td.length; i++) { row.appendChild(td[i]); }

   // add row to table
   tbody.appendChild(row);
   reset();
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
// reset entry fields
//==============================================================================
function reset()
{
   document.all.Test.value = "";
   document.all.TstName.value = "";
   document.all.Dept.value = "";
   document.all.DptName.value = "";
   document.all.btnSubmit.innerHTML = "Add"
   Action = "ADD";
   document.all.selDept.disabled=false;
   document.all.selTest.disabled=false;
   SelRow = 0;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
</head>

<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<iframe id="frame2"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvQuest" class="dvQuest"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Department/Test List
       <br>
       </b>

       <!----------------- Add / Delete  Dpt/test records --------------------->
       <table style="background:#F5DEB3;" border=1 cellPadding="0" cellSpacing="0" id="tblChg">
         <tr style="font-size:12px">
           <td class="DataTable5">&nbsp; Department: &nbsp;&nbsp;</td>
           <td class="DataTable5"><input name="DptName" class="Small" readonly size=70>
             <input name="Dept" type="hidden"><br>
             <select name="selDept" class="Small" onClick="selectDept(this)"></select>
           </td>
           <td>< ==== ></td>
           <td class="DataTable5">&nbsp; Test: &nbsp;&nbsp;</td>
           <td class="DataTable5"><input name="TstName" class="Small" readonly size=100>
             <input name="Test" type="hidden"><br>
             <select name="selTest" class="Small" onClick="selectTest(this)"></select>
           </td>
         </tr>
         <tr style="text-align:center;">
           <td colspan=5><button id="btnSubmit" onClick="validate()">Add</button>
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <button onClick="reset()">Clear</button>
           </td>
         </tr>
       </table>
       <!---------------------------------------------------------------------->

       <a href="../"><font color="red" size="-1">Home</font></a>;&#62
       <font size="-1">This page</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <a href="javascript: window.location.reload()">Refresh</a>
        <!----------------- start of ad table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0" id="tblDptTst">
           <thead style="overflow: visible;">
             <tr class="DataTable">
               <th class="DataTable">Department</th>
               <th class="DataTable">Test</th>
               <th class="DataTable">Delete</th>
             </tr>
           </thead>
        <!--------------------- Group List ----------------------------->
        <tbody>
        <% int iDptTst = 0;%>
        <% while(dpttestl.Next()){%>
            <%
              // question property
              dpttestl.setDeptTestProp();
              String sDept = dpttestl.getDept();
              String sDptName = dpttestl.getDptName();
              String sTest = dpttestl.getTest();
              String sTstName = dpttestl.getTstName();
            %>
              <!-- ---------------------------------------------------- -->
              <tr class="DataTable1" id="trDptTest">
                <td id="tdDept" class="DataTable"><%=sDept + " - " + sDptName%></td>
                <td id="tdTest" class="DataTable"><%=sTstName%></td>
                <td id="tdDelete" class="DataTable"><a href="javascript: dltDeptTest('<%=sDept%>', '<%=sDptName%>', <%=sTest%>, '<%=sTstName%>', <%=iDptTst%>)">Delete</a></td>
              </tr>
              <%iDptTst++;%>
          <%}%>
         </tbody>
       </table>
       <!----------------- start of ad table ------------------------>
      </td>
     </tr>
    </table>
  </body>
</html>

<SCRIPT language="JavaScript">
var NumOdDptTst = <%=iDptTst%>;
</SCRIPT>

<%
  dpttestl.disconnect();
  dpttestl = null;
  }
%>
