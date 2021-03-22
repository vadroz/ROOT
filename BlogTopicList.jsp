<%@ page import="miniblog.BlogTopicList, java.sql.* ,java.util.*, java.text.*, java.math.*"%>
<%
   String sBlogGrp = request.getParameter("BlogGrp");
   String sBlogGrpNm = request.getParameter("BlogGrpNm");
   // Blog hierarchy
   String [] sPrevGrp = request.getParameterValues("PrevGrp");
   String [] sPrevGrpNm = request.getParameterValues("PrevGrpNm");

  //-------------- Security ---------------------
  String sAppl = "MINIBLOG";

  if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
  {
     response.sendRedirect("SignOn1.jsp?TARGET=BlogGrpList.jsp&APPL=" + sAppl + "&BlogGrp=0");
  }
  else
  {
     boolean bAdmin = session.getAttribute("MIBLOGADM")!=null;

     String sUser = session.getAttribute("USER").toString();
     BlogTopicList topiclsit = new BlogTopicList(sBlogGrp);

     int iNumOfTopic = topiclsit.getNumOfTopic();
     BigDecimal [] bdTopicNum = topiclsit.getTopicNum();
     BigDecimal [] bdGrpNum = topiclsit.getGrpNum();
     String [] sTopicName = topiclsit.getTopicName();
     BigDecimal [] bdMsgPrtNum = topiclsit.getMsgPrtNum();
     String [] sTopicAuthor = topiclsit.getTopicAuthor();
     int [] iNumOfMsg = topiclsit.getNumOfMsg();
     Timestamp [] tsLastMsg = topiclsit.getLastMsg();
     String [] sLastUser = topiclsit.getLastUser();

     // reforamt timestamp
     SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy 'at' hh:mm");
%>

<html>
<head>

<style>body {background:#F0FFF0; font-family: Verdana, Arial, Helvetica, sans-serif;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}

        a.tdlnk:link { color:#2b7ebb; font-weight:bold}
        a.tdlnk:visited { color:#2b7ebb; font-weight:bold}
        a.tdlnk:hover { color: #ff6600; font-weight:bold}

        table.DataTable { border:#2b7ebb 2px solid; background:white; text-align:center;}

        th.HdrTable{ filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr=#2b7ebb, endColorStr=#1b9cc5,
                 gradientType=0);
                 padding-top:3px; padding-bottom:3px; border:white 1px solid;
                 color: #fbb117; vertical-align:top; text-align:center; font-size:12px; font-weight:900 }

        tr.DataTable  { background:#ececec; font-size:12px}

        td.DataTable  { padding-top:5px; padding-bottom:5px; text-align:left; font-weight:900 }
        td.DataTable1 { padding-top:5px; padding-bottom:5px; text-align:center; font-family: Arial; font-size:12px }
        td.DataTable2 { padding-top:5px; padding-bottom:5px; text-align:left; font-family: Arial; font-size:12px}

        input.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:left; font-size:10px;}
        select.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:left; font-size:10px;}
        button.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:center; font-size:10px;}
        textarea.small{ text-align:left; font-size:10px;}

        div.dvTopic { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:azure; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
</style>

<SCRIPT language="JavaScript">
PrevGrp = [<%=topiclsit.cvtToJavaScriptArray(sPrevGrp)%>];
PrevGrpNm = [<%=topiclsit.cvtToJavaScriptArray(sPrevGrpNm)%>];

//==============================================================================
// populate selection fields on page load
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvTopic"]);
}
//==============================================================================
// add new topoc
//==============================================================================
function addTopic()
{
  var hdr = "Enter Reply"

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popReplyPanel() + "</td></tr>"
   + "</table>"

   document.all.dvTopic.innerHTML = html;
   document.all.dvTopic.style.pixelLeft= document.documentElement.scrollLeft + 50;
   document.all.dvTopic.style.pixelTop= document.documentElement.scrollTop + 150;
   document.all.dvTopic.style.visibility = "visible";
}
//==============================================================================
// populate reply panel
//==============================================================================
function popReplyPanel()
{
  var panel = "<form onsubmit='return Validate(this);' action='BlogTopicSave.jsp' method='POST'>"
      + "<table border=0 width='100%' cellPadding='5' cellSpacing='0'>"
         + "<tr><td class='Prompt2' >Subject &nbsp; </td>"
           + "<td class='Prompt'><textarea name='txaSubj' cols=80 rows=2></textarea></td>"
         + "</tr>"
         + "<tr><td class='Prompt2' >Message &nbsp; </td>"
           + "<td class='Prompt'><textarea name='txaMsg' cols=80 rows=10></textarea></td>"
         + "</tr>"
         + "<tr><td class='Prompt1' colspan=2><input type='Submit' class='Small' value=' Post '>"
         + "&nbsp;<button onClick='hidePanel();' class='Small'>Close</button>"
         + "<input type='hidden' name='BlogGrp' value='<%=sBlogGrp%>'>"
         + "<input type='hidden' name='Topic' value='0'>"
         + "<input type='hidden' name='Action' value='NEWTOPIC'>"
         + "<input type='hidden' name='User' value='<%=sUser%>'>"
         + "<input type='hidden' name='Query' value='<%=request.getQueryString()%>'>"
         + "<input type='hidden' name='Uri' value='<%=request.getRequestURI().substring(1)%>'>"
         + "</td>"
         + "</tr>"
      + "</table></form>"

  return panel;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvTopic.innerHTML = " ";
   document.all.dvTopic.style.visibility = "hidden";
}
//==============================================================================
// populate selection fields on page load
//==============================================================================
function Validate(reply)
{
   var error = false;
   var errmsg = "";

   var subj = document.all.txaSubj.value.trim();
   if (subj.length == 0) { error = true; errmsg += "\nPlease type a subject of new topic."}

   var msg = reply.txaMsg.value.trim()
   if (msg.length == 0) { error = true; errmsg += "\nPlease type a topic text."}

   if (error){ alert(errmsg); }

   return !error;
}
//==============================================================================
// show Topic Messages
//==============================================================================
function showTopicMsg(topnum, subj)
{
   var url = "BlogTopic.jsp?BlogGrp=" + <%=sBlogGrp%>
    + "&Topic=" + topnum
    + "&Subj=" + subj.replaceSpecChar();

   PrevGrp[PrevGrp.length] = "<%=sBlogGrp%>";
   PrevGrpNm[PrevGrpNm.length] = "<%=sBlogGrpNm%>";

   // add current group to hierarchy of topics
   for(var i=0; i < PrevGrp.length; i++)
   {
      url += "&PrevGrp=" + PrevGrp[i]
      url += "&PrevGrpNm=" + PrevGrpNm[i]
   }

   window.location.href = url;
}

//==============================================================================
// delete topic
//==============================================================================
function dltTopic(topnum, subj)
{

   var response = confirm("Subject:  " + subj + "\n\nConfirm that you want delete selected topic?");
   if (response)
   {
      var html = "<form name='RmvTopic' action='BlogTopicSave.jsp' method='POST'>"
         + "<input type='hidden' name='BlogGrp' value='<%=sBlogGrp%>'>"
         + "<input type='hidden' name='Topic' value='" + topnum + "'>"
         + "<input type='hidden' name='Action' value='REMOVETOPIC'>"
         + "<input type='hidden' name='User' value='<%=sUser%>'>"
         + "<input type='hidden' name='Query' value='<%=request.getQueryString()%>'>"
         + "<input type='hidden' name='Uri' value='<%=request.getRequestURI().substring(1)%>'>"
      + "</form>"
   }
   document.all.dvTopic.innerHTML = html;
   document.RmvTopic.submit();
}
//==============================================================================
// go to prior group
//==============================================================================
function goPriorGrp(arg)
{
   var url = "BlogGrpList.jsp?"
   url += "BlogGrp=" + PrevGrp[arg] + "&BlogGrpNm=" + PrevGrpNm[arg]

   if(arg > 0)
   {
     for(var i=0; i < PrevGrp.length - 1; i++)
     {
        url += "&PrevGrp=" + PrevGrp[i]
        url += "&PrevGrpNm=" + PrevGrpNm[i]
     }
   }
   //alert(url)
   window.location.href=url
}
// ---------------- End of Move Boxes ---------------------------------------
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body  onload="bodyLoad();">
<!-- ======================================================================= -->
<div id="dvTopic" style="position:absolute;visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:150px;background-color:LemonChiffon; z-index:10"></div>
<!-- ======================================================================= -->

  <table border="0" width="100%"cellPadding="0" cellSpacing="0">
    <tr>
       <td ALIGN="center" VALIGN="TOP" colspan=3>
          <b>Retail Concepts, Inc
          <br>RCI Forum - Topic List</font>
          <br><font size="+2" color="#2b7ebb"><%=sBlogGrpNm%></font></b>
      </td>
    </tr>
    <tr>
      <td ALIGN="left" VALIGN="TOP" width="10%"><a href="javascript: addTopic()">New Topic</a></td>
      <td ALIGN="center" VALIGN="TOP">
          <a href="../"><font color="red">Home</font></a>
          <!-- Show prior group list -->
          <%for(int i=0; i < sPrevGrp.length; i++){%>
             &#62; <a href="javascript: goPriorGrp(<%=i%>)"><%=sPrevGrpNm[i]%></a>
          <%}%>
      </td>
      <td ALIGN="center" VALIGN="TOP" width="20%">&nbsp;</td>
    </tr>
    <tr>
     <td ALIGN="center" VALIGN="TOP" colspan=3>
<!------------- start of dollars table ------------------------>
      <table class="DataTable" width="100%" cellPadding="1" cellSpacing="1">
             <tr>
                <th class="HdrTable">Topics</th>
                <th class="HdrTable" width=10%>Author</th>
                <%if(bAdmin){%><th class="HdrTable" width="5%">remove</th><%}%>
                <th class="HdrTable" width="10%">Responces</th>
                <th class="HdrTable" width="30%">Last Message</th>
             </tr>

             <%for(int i=0; i < iNumOfTopic; i++){%>
                <tr class="DataTable">
                   <td class="DataTable">
                      <a class="tdlnk" href="javascript: showTopicMsg('<%=bdTopicNum[i]%>', '<%=topiclsit.cvtToASCIIHex(sTopicName[i])%>')"><%=sTopicName[i]%></a>
                   </td>
                   <td class="DataTable1"><%=sTopicAuthor[i]%></td>
                   <%if(bAdmin){%>
                       <td class="DataTable1"><a href="javascript: dltTopic('<%=bdTopicNum[i]%>', '<%=topiclsit.cvtToASCIIHex(sTopicName[i])%>')">rmv</a></td>
                   <%}%>
                   <td class="DataTable1"><%=iNumOfMsg[i]%></td>
                   <td class="DataTable2">
                     <%if(tsLastMsg[i] != null){%><%=formatter.format(tsLastMsg[i]) + " &nbsp;  modified by " + sLastUser[i]%>
                     <%} else {%>no messages<%}%>
                   </td>
               </tr>
             <%}%>
       </table>

       </td>
    </tr>
  </table>
</body>
</html>
<%}%>