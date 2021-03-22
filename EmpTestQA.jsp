<%@ page import="java.util.*, emptraining.EmpTestQA"%>
<%
    String sEmp = request.getParameter("Emp");
    String sFName = request.getParameter("FName");
    String sLName = request.getParameter("LName");
    String sTest = request.getParameter("Test");
    String sTstName = request.getParameter("TstName");

    EmpTestQA empQA = new EmpTestQA(sEmp, sTest);
    boolean bAvail = empQA.getAvail();
%>
<%if(bAvail){%>
<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue;  font-size:12px;} a:visited { color:blue; font-size:12px;}  a:hover { color:blue; font-size:12px;}

  table.DataTable { border: gray solid 1px; background:#e7e7e7; text-align:center;}
  tr.DataTable { background:#FFCC99; font-family:Verdanda; text-align:center;
                 font-size:12px; font-weight:bold}
  th.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: gray solid 1px; border-right: gray solid 1px;}

  tr.DataTable1 { background:azure; font-family:Verdanda; text-align:left; font-size:12px;}
  tr.DataTable2 { background:white; font-family:Verdanda; text-align:left; font-size:12px;}
  tr.DataTable3 { background:cornsilk; font-family:Verdanda; text-align:left; font-size:12px; font-weight:bold}
  tr.DataTable4 { background:gray; font-family:Verdanda; text-align:left; font-size:2px;}

  td.DataTable { border-right: gray solid 1px;text-align:left; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable1 { text-align:center; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                  border-right: gray solid 1px;}
  td.DataTable3 { border-right: gray solid 1px;text-align:left; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                 font-size:11px; font-weight:bold}
  td.DataTable4 { border-right: gray solid 1px;text-align:left; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable5 { background:white; text-align:center; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                  border-right: gray solid 1px; font-size:18px;font-weigth:bold}
  td.DataTable6 { color:green; background:white; text-align:center; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                  border-right: gray solid 1px; font-size:18px;font-weigth:bold}
  td.DataTable7 { color:blue; background:white; text-align:center; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                  border-right: gray solid 1px; font-size:18px;font-weigth:bold}

  div.dvPrompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:600; background-color:LemonChiffon; z-index:100;
              text-align:left; font-size:16px }


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

  @media print { body { display: none;} }
</style>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variable
//==============================================================================
var Quest = null;
var Answer = null;
var GoodAnswer = null;
var Reply = new Array();
var NumOfQst = 0;
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
   document.all.thYour.style.display="none"
   document.all.thCorrect.style.display="none"
   if (NumOfQst == 1 )
   {
      document.all.tdYour.style.display="none"
      document.all.tdCorrect.style.display="none"
   }
   else
   {
      for(var i = 0; i < NumOfQst; i++)
      {
         document.all.tdYour[i].style.display="none"
         document.all.tdCorrect[i].style.display="none"
      }
   }
}
//==============================================================================
// validate Answwers
//==============================================================================
function validate()
{
   Quest = new Array(NumOfQst);
   Answer = new Array(NumOfQst);
   GoodAnswer = new Array(NumOfQst);
   var error = false;

   for(var i = 0; i < NumOfQst; i++)
   {
      var qafld = "QA" + i
      var qa = document.all[qafld];

      Quest[i] = i;
      GoodAnswer[i] = false;
      for(var j=0; j < qa.length; j++)
      {
         if(qa[j].checked) { Answer[i] = j; GoodAnswer[i] = j > 0; }

      }

      // change collor for ununswered questions
      if(!GoodAnswer[i])
      {
        error = true;
        if(NumOfQst == 1){ document.all.tdQuest.style.background="white url('QuestMark.jpg') no-repeat center bottom"; }
        else { document.all.tdQuest[i].style.background="white url('QuestMark.jpg') no-repeat center bottom"; }
      }
      else
      {
         if(NumOfQst == 1) { document.all.tdQuest.style.background="white url('traffic_light_go.gif') no-repeat center bottom" }
         else { document.all.tdQuest[i].style.background="white url('traffic_light_go.gif') no-repeat center bottom" }
      }

   }

   if(error) { alert("Some questions are unanswered.") }
   else(submit())
}
//==============================================================================
// submit test unswered
//==============================================================================
function submit()
{
   var score = 0;
   for(var i=0; i < NumOfQst; i++)
   {
      if(Answer[i] == Reply[i]) { score++; }
   }

   var scrPrc = Math.round(score / NumOfQst * 10000) / 100;

   var msg = null;
   if(scrPrc >= 80) { msg = "Congratulation - you pass"; }
   else { msg = "Sorry - you did not pass. The Minimum is 80%"; }

   displayResult(NumOfQst, score, scrPrc, msg)

   // save result in file
   var url = "EmpTestQASave.jsp?Emp=<%=sEmp%>"
           + "&Test=<%=sTest%>"
           + "&Score=" + score
           + "&ScrPrc=" + scrPrc

   //alert(url)
   //window.location.href=url;
   window.frame1.location.href=url;

   document.all.btnSubmit.style.display="none";
}

//==============================================================================
// display result
//==============================================================================
function displayResult(totNumOfQst, score, scrPrc, msg)
{
   window.frame1.location.href=null;
   window.frame1.close();

   var html="<h3>Test Results</h3>"
           + "<br><b>Number of questions: " + totNumOfQst + "</b>"
           + "<br><b>Your scores: " + score + "</b>"
           + "<br><b>Percents of correct answeres: " + scrPrc + "%</b>"
           + "<br><b>" + msg + "</b>"
           + "<p align=center><button id='btnClose' onClick='window.close()'>Close</button>"

   document.all.thResult.innerHTML = html;
   document.all.thYour.style.display="block"
   document.all.thCorrect.style.display="block"


   // set correct result
   for(var i = 0; i < NumOfQst; i++)
   {
      if (NumOfQst == 1)
      {
         document.all.tdYour.style.display="block"
         document.all.tdCorrect.style.display="block"
      }
      else
      {
         document.all.tdYour[i].style.display="block"
         document.all.tdCorrect[i].style.display="block"
      }

      if (Answer[i] == Reply[i])
      {
         if (NumOfQst == 1) { document.all.tdYour.innerHTML=Answer[i] + "<br><font color=green>Correct</font>"; }
         else { document.all.tdYour[i].innerHTML=Answer[i] + "<br><font color=green>Correct</font>"; }
      }
      else
      {
         if (NumOfQst == 1) { document.all.tdYour.innerHTML=Answer[i] + "<br><font color=red>Wrong</font>"; }
         else { document.all.tdYour[i].innerHTML=Answer[i] + "<br><font color=red>Wrong</font>"; }
      }

      if (NumOfQst == 1)
      {
         document.all.tdQuest.style.background="white";
         document.all.tdCorrect.innerHTML = Reply[i];
      }
      else
      {
         document.all.tdQuest[i].style.background="white";
         document.all.tdCorrect[i].innerHTML = Reply[i];
      }
   }

   // show top of the document
   scrollTo(0,0);
}
//==============================================================================
//disable right click
//==============================================================================
function right(e)
{
   if (navigator.appName == 'Netscape' && (e.which == 3 || e.which == 2)) return false;
   else if (navigator.appName == 'Microsoft Internet Explorer' && (event.button == 2 || event.button == 3))
   {
       alert("Sorry, you do not have permission to right click.");
       return false;
   }
   return true;
}

document.onmousedown=right;
document.onmouseup=right;
window.onmousedown=right;
window.onmouseup=right;
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
</head>

<body  onload="bodyLoad();" onunload="window.close()">
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvPrompt" class="dvPrompt"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Employee Training
       <br>Employee: <%=sEmp%> - <%=sFName%> <%=sLName%>
       <br>Test: <%=sTstName%>
       <br>
       </b>

        <!----------------- start of ad table ------------------------>
         <table class="DataTable" width="100%" cellPadding="0" cellSpacing="0" id="tblTest">
           <thead style="overflow: visible;">
             <tr class="DataTable3"><th id="thResult" class="DataTable" colspan="5"></th>
             <tr class="DataTable">
               <th class="DataTable">No.</th>
               <th id="thYour" class="DataTable">Your Reply</th>
               <th id="thCorrect" class="DataTable">Correct</th>
               <th class="DataTable">Question / Answer</th>
             </tr>
           </thead>
        <!--------------------- Group List ----------------------------->
        <tbody>
        <% int iQuest = 0;%>
        <% while(empQA.Next()){%>
            <%
              // question property
              empQA.setQuestionProperty();
              String sQuest = empQA.getQuest();
              String sQstText = empQA.getQstText();

              // answer properties
              int iNumOfAns = empQA.getNumOfTst();
              String [] sAnswer = empQA.getAnswer();
              String sGood = empQA.getGood();
              String [] sAnsText = empQA.getAnsText();
            %>

              <!-- ------------ Division line ------------------------- -->
              <tr class="DataTable4"><td colspan="5">&nbsp;</td></tr>
              <tr class="DataTable1" id="trQuest">
                <td class="DataTable5" id="tdQuest" width="5%" rowspan="2"><%=iQuest + 1%></td>
                <td class="DataTable7" id="tdYour" width="10%" rowspan="2"></td>
                <td class="DataTable6" id="tdCorrect" width="10%" rowspan="2"></td>
                <td class="DataTable4"><%=sQstText%><SCRIPT language="JavaScript">Reply[<%=iQuest%>]=<%=sGood%></script></td>
              </tr>

              <tr class="DataTable2">
                <td class="DataTable"><input type="radio" name="QA<%=iQuest%>" value=0 checked>Not Answered
                  <%for(int j=0; j < iNumOfAns; j++){%>
                      <br><%=j+1%><input type="radio" name="QA<%=iQuest%>" value=<%=sAnswer[j]%>><%=sAnsText[j]%>
                  <%}%>
                </td>
              </tr>
              <%iQuest++;%>
          <%}%>
         </tbody>
       </table>
       <!----------------- start of ad table ------------------------>
       <button id="btnSubmit" onClick="validate()">Submit Answers</button>
      </td>
     </tr>
    </table>
  </body>
</html>

<SCRIPT language="JavaScript">
   NumOfQst = <%=iQuest%>;
</SCRIPT>

<%} // test available
  else {%><h1>This page is expired.</h1>
<%}%>

<%
  empQA.disconnect();
  empQA = null;
%>
