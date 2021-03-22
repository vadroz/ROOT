<%@ page import="java.util.*, emptraining.TestQAList"%>
<%
    String sFName = request.getParameter("FName");
    String sLName = request.getParameter("LName");
    String sTest = request.getParameter("Test");
    String sTstName = request.getParameter("TstName");
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("TRAINCHG") == null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=TestQALst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    TestQAList tstqal = new TestQAList(sTest);
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

  tr.DataTable1 { background:azure; font-family:Verdanda; text-align:left; font-size:12px;}
  tr.DataTable2 { background:white; font-family:Verdanda; text-align:left; font-size:12px;}
  tr.DataTable3 { background:cornsilk; font-family:Verdanda; text-align:left; font-size:12px; font-weight:bold}
  tr.DataTable4 { background:darkred; font-family:Verdanda; text-align:left; font-size:2px;}
  tr.DataTable5 { background:yellow; font-family:Verdanda; text-align:left; font-size:12px; font-weight:bold}

  td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;text-align:left; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable1 { text-align:center; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                  border-right: darkred solid 1px;  border-bottom: darkred solid 1px;}
  td.DataTable3 { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:left; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                 font-size:11px; font-weight:bold}
  td.DataTable4 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;text-align:left; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable5 { background:white; text-align:center; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                  border-right: darkred solid 1px;  border-bottom: darkred solid 1px;font-size:18px;font-weigth:bold}
  td.DataTable6 { text-align:left; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable7 { text-align:center; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}

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
var NumOfQst = 0;
var NumOfAns = 0;

var SelctedQRow = null;
var SelctedARow = null;
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvQuest"]);
}
//==============================================================================
//  Change Question
//==============================================================================
function chgQuestion(qst, qtext, action, row)
{
   var hdr = "New Question";
   if(action=="UPD") { hdr = "Update Question" }
   else if(action=="DLT") { hdr = "Delete Question" }

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popQstPanel(action)
     + "</td></tr>"
   + "</table>"

   document.all.dvQuest.innerHTML = html;
   document.all.dvQuest.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvQuest.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvQuest.style.visibility = "visible";

   if(action != "ADD")
   {
      document.all.QstText.value = qtext;
      document.all.Quest.value = qst;
   }
   if(action == "DLT") { document.all.QstText.readOnly = true; }
   SelctedQRow = row
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popQstPanel(action)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt'>Question: </td>"
           + "<td class='Prompt' colspan='2'>"
           + "<textarea class='Small' name='QstText' cols=100 rows=5></textarea>"
           + "<input name='Quest' type='hidden'>"
           + "</td>"
         + "</tr>"

  panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
        + "<button onClick='validate(&#34;Q&#34;, &#34;" + action + "&#34;)' "
        + "class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

     panel += "</table>";

  return panel;
}


//==============================================================================
// change answere
//==============================================================================
function chgAnswer(qst, qsttx, answ, answtx, answTrue, action, qrow, arow, numarow)
{
   var hdr = "New Answer";
   if(action=="UPD") { hdr = "Update Answer" }
   else if(action=="DLT") { hdr = "Delete Answer" }

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popAnswPanel(action)
     + "</td></tr>"
   + "</table>"

   document.all.dvQuest.innerHTML = html;
   document.all.dvQuest.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvQuest.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvQuest.style.visibility = "visible";

   document.all.spmQstText.innerHTML = qsttx;
   document.all.Quest.value = qst;
   if(action != "ADD")
   {
      document.all.Answer.value = answ;
      document.all.AnswText.value = answtx;
      if(answTrue=="Y") document.all.True.checked = true;
   }
   if(action == "DLT")
   {
     //document.all.QstText.readOnly = true;
   }

   NumOfAns = numarow;
   SelctedQRow = qrow
   SelctedARow = arow
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popAnswPanel(action)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td class='Prompt'><br>Question:<br><br></td>"
           + "<td class='Prompt'><br>"
           + "<span id='spmQstText'></span><br><br>"
           + "<input name='Quest' type='hidden'>"
           + "</td>"
           + "<tr><td class='Prompt'>Answer: </td>"
           + "<td class='Prompt'>"
           + "<textarea class='Small' name='AnswText' cols=100 rows=3></textarea>"
           + "<input name='Answer' type='hidden'>"
           + "</td>"
           + "<tr><td class='Prompt'>Is it true?: </td>"
           + "<td class='Prompt'>"
           + "<input name='True' type='checkbox' value=Y>"
           + "</td>"
         + "</tr>"

  panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
        + "<button onClick='validate(&#34;A&#34;, &#34;" + action + "&#34;)' "
        + "class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

     panel += "</table>";

  return panel;
}
//==============================================================================
// validate Answwers
//==============================================================================
function validate(QorA, action)
{
   var error = false;
   var msg = '';
   var qst = document.all.Quest.value;
   var qsttx = "";
   var answ = 0;
   var answtx = "";
   var answTrue = "N";

   if(QorA=="Q") { qsttx = document.all.QstText.value.trim(" "); }

   if(QorA=="A")
   {
      if(action!="ADD") answ = document.all.Answer.value;
      answtx = document.all.AnswText.value.trim(" ");
      if(document.all.True.checked) answTrue = 'Y'
   }

   if(QorA=="Q" && action!="DLT" && (qsttx == "" || qsttx == " ")) {error=true; msg="Enter Question Text.\n"}
   if(QorA=="A" && action!="DLT" && (answtx == "" || answtx == " ")) {error=true; msg="Enter Answer Text.\n"}

   if(error) { alert(msg) }
   else(submit(qst, qsttx, answ, answtx, answTrue, QorA, action))
}
//==============================================================================
// submit test unswered
//==============================================================================
function submit(qst, qsttx, answ, answtx, answTrue, QorA, action)
{
   var url = "TestQASave.jsp?"
           + "&Test=<%=sTest%>"
           + "&Quest=" + qst
           + "&QstText=" + qsttx
           + "&Answer=" + answ
           + "&AnswText=" + answtx
   // set action
   if(QorA=="Q" && action == "ADD") { url += "&Action=ADDQST"}
   else if(QorA=="Q" && action == "UPD") { url += "&Action=UPDQST"}
   else if(QorA=="Q" && action == "DLT") { url += "&Action=DLTQST"}

   if(QorA=="A") { url += "&True=" + answTrue}

   if(QorA=="A" && action == "ADD") { url += "&Action=ADDANSW"}
   else if(QorA=="A" && action == "UPD") { url += "&Action=UPDANSW"}
   else if(QorA=="A" && action == "DLT") { url += "&Action=DLTANSW"}

   //alert(url)
   //window.location.href=url;
   window.frame1.location.href=url;

   if(QorA=="Q" && action=="ADD") { addQuestion(qst, qsttx); }
   else if(QorA=="Q") { updQuestion(qst, qsttx, action); }
   else if(QorA=="A" && action=="ADD") { addAnswer(qst, answ, answtx, answTrue); }
   else if(QorA=="A") { updAnswer(qst, answ, answtx, answTrue, action ); }
   hidePanel();
}

//==============================================================================
// change table rows
//==============================================================================
function addQuestion(qst, qsttx)
{
   var tbody = document.getElementById("tblQuest").getElementsByTagName("TBODY")[0];
   var row = document.createElement("TR")
   row.className="DataTable3";
   row.id="trQuest"; //add ID

   NumOfQst = eval(NumOfQst) + 1;

   var td = new Array();
   td[0] = addTDElem(NumOfQst, "tdQuest" + NumOfQst, "DataTable")
   td[1] = addTDElem("-", "tdChange" + NumOfQst, "DataTable")
   td[2] = addTDElem(qsttx, "tdQstTxt" + NumOfQst, "DataTable")
   td[3] = addTDElem("-", "tdDelete" + NumOfQst, "DataTable")

   // add cell to row
   for(var i=0; i < td.length; i++) { row.appendChild(td[i]); }

   // add row to table
   tbody.appendChild(row);
}
//==============================================================================
// change table rows
//==============================================================================
function addAnswer(qst, answ, answtx, answTrue)
{
   var tbl = null;
   if(NumOfQst > 1) { tbl = document.all.tblAnswer[SelctedQRow]; }
   else { tbl = document.all.tblAnswer; }
   var tbody = tbl.getElementsByTagName("TBODY")[0];
   var row = document.createElement("TR")
   row.className="DataTable3";
   row.id="trAnswer"; //add ID

   SelctedARow = eval(SelctedARow) + 1;

   var td = new Array();
   td[0] = addTDElem("NEW", "tdAnswNum" + SelctedARow, "DataTable")
   td[1] = addTDElem("-", "tdAnswChg" + SelctedARow, "DataTable")
   td[2] = addTDElem(answtx, "tdAnswText" + SelctedARow, "DataTable")
   td[3] = addTDElem(answTrue, "tdAnswTrue" + SelctedARow, "DataTable")
   td[4] = addTDElem("-", "tdAnswDlt" + SelctedARow, "DataTable")

   // add cell to row
   for(var i=0; i < td.length; i++) { row.appendChild(td[i]); }

   // add row to table
   tbody.appendChild(row);
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
function updQuestion(qst, qsttx, action)
{
   var row = SelctedQRow;

   if(NumOfQst > 1)
     {
       document.all.tdQstText[row].innerHTML = qsttx;
       document.all.tdChange[row].innerHTML = "-";
       document.all.tdDelete[row].innerHTML = "-";
     }
     else
     {
       document.all.tdQstText.innerHTML = qsttx;
       document.all.tdChange.innerHTML = action;
       document.all.tdDelete.innerHTML = action;
     }

}
//==============================================================================
// change table rows
//==============================================================================
function updAnswer(qst, answ, answtx, answTrue, action)
{
   var tbl = null;
   if(NumOfQst > 1) { tbl = document.all.tblAnswer[SelctedQRow]; }
   else { tbl = document.all.tblAnswer; }

   var row = SelctedARow;
   if(NumOfAns > 1)
     {
       document.all.tdAnswChg[row].innerHTML = action;
       document.all.tdAnswText[row].innerHTML = answtx;
       document.all.tdAnswTrue[row].innerHTML = answTrue;
       document.all.tdAnswDlt[row].innerHTML = action;
     }
     else
     {
       document.all.tdAnswChg.innerHTML = action;
       document.all.tdAnswText.innerHTML = answtx;
       document.all.tdAnswTrue.innerHTML = answTrue;
       document.all.tdAnswDlt.innerHTML = action;
     }

}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvQuest.innerHTML = " ";
   document.all.dvQuest.style.visibility = "hidden";
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
<div id="dvQuest" class="dvQuest"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Question and Answer List
       <br>Test: <%=sTstName%>
       <br>
       </b>

       <a href="../"><font color="red" size="-1">Home</font></a>;&#62
       <a href="TestLst.jsp"><font color="red" size="-1">Test List</font></a>;&#62
       <font size="-1">This page</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <a href="javascript: chgQuestion(null, null, 'ADD', 0)">Add New Question</a>
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <a href="javascript: window.location.reload()">Refresh</a>
        <!----------------- start of ad table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0" id="tblQuest" width="100%">
           <thead style="overflow: visible;">
             <tr class="DataTable3"><th id="thResult" class="DataTable" colspan="5"></th>
             <tr class="DataTable">
               <th class="DataTable" width="3%">No.</th>
               <th class="DataTable" width="3%">Change</th>
               <th class="DataTable">Question / Answer</th>
               <th class="DataTable" width="3%">Delete</th>
             </tr>
           </thead>
        <!--------------------- Group List ----------------------------->
        <tbody>
        <% int iQuest = 0;%>
        <% while(tstqal.Next()){%>
            <%
              // question property
              tstqal.setQuestionProperty();
              String sQuest = tstqal.getQuest();
              String sQstText = tstqal.getQstText();

              // answer properties
              int iNumOfAns = tstqal.getNumOfAns();
              String [] sAnswer = tstqal.getAnswer();
              String [] sTrue = tstqal.getTrue();
              String [] sAnsText = tstqal.getAnsText();
            %>
              <!-- ------------ Question line ------------------------- -->
              <tr class="DataTable4"><td colspan="5">&nbsp;</td></tr>
              <tr class="DataTable1" id="trQuest">
                <td id="tdQuest" class="DataTable5" rowspan="2"><%=iQuest + 1%></td>
                <td id="tdChange" class="DataTable1"><a href="javascript: chgQuestion(<%=sQuest%>, '<%=sQstText%>', 'UPD', <%=iQuest%>)">C</a></td>
                <td id="tdQstText" class="DataTable4"><%=sQstText%></td>
                <td id="tdDelete" class="DataTable1"><a href="javascript: chgQuestion(<%=sQuest%>, '<%=sQstText%>', 'DLT', <%=iQuest%>)">D</a></td>
                <script>NumOfQst++;</script>
              </tr>

              <tr class="DataTable2">

                <td class="DataTable" colspan=3><br>
                <!-- ------------ Answer line ------------------------- -->
                <table border=1 cellPadding="0" cellSpacing="0" id="tblAnswer" width="100%">
                  <tr class="DataTable3">
                    <td class="DataTable7" width="3%">No.</td>
                    <td class="DataTable7" width="3%">Chg</td>
                    <td class="DataTable7"><a href="javascript: chgAnswer(<%=sQuest%>, '<%=sQstText%>', null, null, 'N', 'ADD', <%=iQuest%>, 0, <%=iNumOfAns%>)">Add Answer</a></td>
                    <td class="DataTable7" width="3%">True</td>
                    <td class="DataTable7" width="3%">Dlt</td>
                  </tr>
                  <%for(int j=0; j < iNumOfAns; j++){%>
                    <tr class="DataTable2">
                      <td id="tdAnswNum" class="DataTable7"><%=j+1%></td>
                      <td id="tdAnswChg" class="DataTable7"><a href="javascript: chgAnswer(<%=sQuest%>, '<%=sQstText%>', <%=sAnswer[j]%>, '<%=sAnsText[j]%>', '<%=sTrue[j]%>', 'UPD', <%=iQuest%>, <%=j%>, <%=iNumOfAns%>)">C</a></td>
                      <td id="tdAnswText" class="DataTable6"><%=sAnsText[j]%></td>
                      <td id="tdAnswTrue" class="DataTable7">&nbsp;<%if(sTrue[j].equals("Y")){%>True<%}%></td>
                      <td id="tdAnswDlt" class="DataTable7"><a href="javascript: chgAnswer(<%=sQuest%>, '<%=sQstText%>', <%=sAnswer[j]%>, '<%=sAnsText[j]%>', '<%=sTrue[j]%>', 'DLT', <%=iQuest%>, <%=j%>, <%=iNumOfAns%>)">D</a></td>
                   </tr>
                 <%}%>
                </table><p>
                <!-- ------------ End Answer line ------------------------- -->
                </td>
              </tr>
              <%iQuest++;%>
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
var NumOfQst = <%=iQuest%>;
</SCRIPT>

<%
  tstqal.disconnect();
  tstqal = null;
  }
%>
