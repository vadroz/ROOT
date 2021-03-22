<%@ page import="java.util.*, emptraining.EmpTest"%>
<%
    String sEmp = request.getParameter("Emp");
    String sFName = request.getParameter("FName");
    String sLName = request.getParameter("LName");
    String sView = request.getParameter("Test");

    String sUser = session.getAttribute("USER").toString();

    EmpTest emptst = new EmpTest(sEmp);
    int iNumOfGrp = emptst.getNumOfGrp();
    boolean bChgTest = sUser.equals("vrozen")
       || sUser.equals("agiles") || sUser.equals("srutherfor") 
       || sUser.equals("jlegaspi") || sUser.equals("jparks") 
       || sUser.equals("awright"); //sView != null;
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
              
  div.dvWarn { position: absolute;  top: expression(this.offsetParent.scrollTop+20); left:20px; background-attachment: scroll;
              border: red solid 3px; width:300px;  z-index:50; padding:3px; background-color:white;
              text-align:center; font-size:14px}

  .Small{ text-align:left; font-family:Arial; font-size:10px;}
  td.BoxName {cursor:move; background: #016aab; 
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
  td.BoxClose {cursor:hand; background: #016aab;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
  td.Prompt { text-align:left;font-family:Arial; font-size:10px; }
  td.Prompt1 { text-align:center;font-family:Arial; font-size:10px; }
  td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
  td.option { text-align:left; font-size:10px}
</style> 

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>
<SCRIPT language="JavaScript">
//==============================================================================
// Global variable
//==============================================================================
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
    setBoxclasses(["BoxName",  "BoxClose"], ["dvPrompt"]);
}
//==============================================================================
// start test
//==============================================================================
function setTestResult(test, testnm, attdt)
{
   var hdr = "Test:&nbsp;" + test + " - " + testnm;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popTestResPanel(test) + "</td></tr>"
   + "</table>"

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.left=getLeftScreenPos() + 50;
   document.all.dvPrompt.style.top=getTopScreenPos() + 100;
   
   document.all.dvPrompt.style.visibility = "visible";

   var date = new Date();
   if(attdt.trim() == "Not taken") { document.all.AttDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();}
   else{ document.all.AttDate.value = attdt; }

   document.all.ScrPrc.select();
}
//==============================================================================
// drill down - report on next level
//==============================================================================
function popTestResPanel(test)
{
   var posx = document.documentElement.scrollLeft + 200;
   var posy = document.documentElement.scrollTop + 250;

   var panel = "<table>"
       + "<tr><td class='Prompt' nowrap>Attempt Date </td><td>"
         + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;AttDate&#34;)'>&#60;</button>"
         + "<input class='Small' name='AttDate' type='text' size=10 maxlength=10>&nbsp;"
         + "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, &#34;AttDate&#34;)'>&#62;</button>"
         + "&nbsp;&nbsp;&nbsp;"
         + "<a href='javascript:showCalendar(1, null, null, " + posx + ", " + posy + ", document.all.AttDate)' >"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>"
         + "</td></tr>"
       + "<tr><td class='Prompt'>Score</td>"
         + "<td><input class='Small' name='Score' maxlength=3 size=3 value='1'>"
         + "</td>"
       + "</tr>"

       + "<tr><td class='Prompt'>Score Percent</td>"
         + "<td><input class='Small' name='ScrPrc' maxlength=6 size=6 value='100'>%"
         + "</td>"
       + "</tr>"

       + "<tr><td class='Prompt' colspan=2><span id='spnError' style='color:red;'></span></td>"
       + "</tr>"

       + "<tr><td class='Prompt1' colspan=2>"
         + "<button class='Small' onClick='ValidateRes(&#34;" + test + "&#34;, &#34;ADD&#34;)'>Add/Update</button>&nbsp;&nbsp;&nbsp;&nbsp;"
         + "<button class='Small' onClick='hidePanel()'>Cancel</button>&nbsp;&nbsp;&nbsp;&nbsp;"
         + "<button class='Small' onClick='ValidateRes(&#34;" + test + "&#34;, &#34;DLT&#34;)'>Remove</button>"
         + "</td></tr>"
      + "</table>"
   return panel;
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

//--------------------------------------------------------
// Validate new test result
//--------------------------------------------------------
function ValidateRes(test, action)
{
   var error = false;
   var msg = "";

   var attdate = document.all.AttDate.value.trim();
   var score = document.all.Score.value.trim();
   var scrprc = document.all.ScrPrc.value.trim();

   if(score==""){ error=true; msg+="<br>Please enter score."}
   else if(isNaN(score)){ error=true; msg+="<br>Score is not numeric"; }

   if(scrprc==""){ error=true; msg+="<br>Please enter score percents."; }
   else if(isNaN(scrprc)){ error=true; msg+="<br>Score percents is not numeric"; }
   else if(eval(scrprc) > 100){ error=true; msg+="<br>Score percents cannot be gretater then 100%."; }

   if(error){ document.all.spnError.innerHTML = msg; }
   else{ sbmTestResult(test, attdate, score, scrprc, action); }
}
//--------------------------------------------------------
// Validate new test result
//--------------------------------------------------------
function sbmTestResult(test, attdate, score, scrprc, action)
{
   var url = "EmpTestSv.jsp?Emp=<%=sEmp%>"
    + "&Test=" + test
    + "&AttDate=" + attdate
    + "&Score=" + score
    + "&ScrPrc=" + scrprc
    + "&Action=" + action
  
   //alert(url)
   if(isIE || isSafari){ window.frame1.location.href = url; }
   else if(isChrome || isEdge) { window.frame1.src = url; }
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvPrompt.innerHTML = " ";
   document.all.dvPrompt.style.visibility = "hidden";
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>

<body id="Body" onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvPrompt" class="dvPrompt"></div>
<!-------------------------------------------------------------------->
<div class="dvWarn">
      <span style="font-size:18px;"><b>ATTENTION!!!</b></span>
      <p style="text-align:left; ">You must notify Store Operations of all rehires by sending an ACTION 
          to the "Training(Training Tests,General)" Action Group.
          Failure to do so may result in inaccurate reporting.
</div>
<!-------------------------------------------------------------------->
  <table border="0" width="100%" height="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Employee Training - Test List
       <br>Employee: <%=sEmp%> - <%=sFName%> <%=sLName%>
       <br>
       </b>

        <a href="../"><font color="red" size="-1">Home</font></a>;&#62
        <a href="EmpTestSel.jsp"><font color="red" size="-1">Selection</font></a>;&#62
        <font size="-1">This page</font>
        <!----------------- start of ad table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0">
           <thead style="overflow: visible;">
             <tr class="DataTable">
               <th class="DataTable" rowspan="2">Group</th>
               <th class="DataTable" rowspan="2">Test</th>
               <th class="DataTable" colspan="4">Results</th>
             </tr>
             <tr class="DataTable">
               <th class="DataTable">Date</th>
               <th class="DataTable">Score</th>
               <th class="DataTable">%</th>
               <th class="DataTable">Pass</th>
           </thead>
        <!--------------------- Group List ----------------------------->
        <tbody>
        <%for(int i=0; i < iNumOfGrp; i++){%>
            <%
              emptst.setGroupArr();
              String sGroup = emptst.getGroup();
              String sGrpName = emptst.getGrpName();
              int iNumOfTst = emptst.getNumOfTst();
            %>

              <!-- ------------ Division line ------------------------- -->
              <tr class="DataTable1">
                <td class="DataTable" rowspan=<%=iNumOfTst%>><%=sGrpName%></td>

                <%for(int j=0; j < iNumOfTst; j++){%>
                <%
                    emptst.setTestArr();
                    String sTest = emptst.getTest();
                    String sTstName = emptst.getTstName();
                    String sTstDate = emptst.getTstDate();
                    String sTstTime = emptst.getTstTime();
                    String sTstScore = emptst.getTstScore();
                    String sTstScrPrc = emptst.getTstScrPrc();
                    String sTstPass = emptst.getTstPass();
                    String sTstAvail = emptst.getTstAvail();
                %>
                  <%if(j > 0){%><tr class="DataTable1"><%}%>
                     <%if(bChgTest){%>
                         <td class="DataTable"><a href="javascript: setTestResult('<%=sTest%>', '<%=sTstName%>', '<%=sTstDate%>')"><%=sTstName%></a></td>
                     <%}
                       else {%> <td class="DataTable"><%=sTstName%></td>
                     <%}%>

                     <%if(!sTstDate.equals("Not taken")){%>
                        <td class="DataTable"><%=sTstDate%></td>
                        <td class="DataTable1">&nbsp;<%=sTstScore%></td>
                        <td class="DataTable1"><%=sTstScrPrc%>%</td>
                        <td class="DataTable1"><%if(sTstPass.equals("1")){%>Yes<%} else {%>No<%}%></td>
                     <%}
                     else {%><td class="DataTable" colspan="4">&nbsp</td>
                     <%}%>
                <%}%>
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
  emptst.disconnect();
  emptst = null;
%>