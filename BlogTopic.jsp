<%@ page import="miniblog.BlogTopic, java.sql.* ,java.util.*, java.text.*, java.math.*"%>
<%
   String sBlogGrp = request.getParameter("BlogGrp");
   String sBlogGrpNm = request.getParameter("BlogGrpNm");
   String sTopic = request.getParameter("Topic");
   String sSubj = request.getParameter("Subj");

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

     BlogTopic bltopic = new BlogTopic(sTopic);

     int iNumOfMsg = bltopic.getNumOfMsg();
     BigDecimal [] bdTopicNum = bltopic.getTopicNum();
     String [] sTopicName = bltopic.getTopicName();
     BigDecimal [] bdMsgPrtNum = bltopic.getMsgPrtNum();
     Timestamp [] tsCrtTime = bltopic.getCrtTime();
     String [] sCrtUser = bltopic.getCrtUser();
     Timestamp [] tsLstTime = bltopic.getLstTime();

     // reforamt timestamp
     SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy 'at' hh:mm");
     String sUser = session.getAttribute("USER").toString();
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

        tr.DataTable  { background:#ecece0; text-align:left; font-size:12px}
        tr.DataTable1 { background:#ececec; text-align:left; font-size:12px}

        tr.Divider { background:#d7d7d7; text-align:left; font-size:5px}

        td.DataTable  { padding-top:5px; padding-bottom:5px; text-align:left;font-family: Arial; font-size:10px}
        td.DataTable1 { padding-top:5px; padding-bottom:5px; text-align:center; font-family: Arial;  }
        td.DataTable2 { padding-top:5px; padding-bottom:5px; text-align:left; font-family: Arial;}
        td.DataTable3 { padding-bottom:15px;}
        td.DataTable30 { background: white; padding-bottom:15px;}

        div.dvReply { position:absolute; visibility:hidden; background-attachment: scroll;
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

        .small { font-size:10px; }
</style>

<SCRIPT language="JavaScript">
var Topic = "<%=sTopic%>"

PrevGrp = [<%=bltopic.cvtToJavaScriptArray(sPrevGrp)%>];
PrevGrpNm = [<%=bltopic.cvtToJavaScriptArray(sPrevGrpNm)%>];

//==============================================================================
// populate selection fields on page load
//==============================================================================
function bodyLoad()
{
  setBoxclasses(["BoxName",  "BoxClose"], ["dvReply"]);
}
//==============================================================================
// show reply panel
//==============================================================================
function showReplyPanel()
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

   document.all.dvReply.innerHTML = html;
   document.all.dvReply.style.pixelLeft= document.documentElement.scrollLeft + 50;
   document.all.dvReply.style.pixelTop= document.documentElement.scrollTop + 150;
   document.all.dvReply.style.visibility = "visible";
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
         + "<input type='hidden' name='Topic' value='<%=sTopic%>'>"
         + "<input type='hidden' name='Action' value='REPLY'>"
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
   document.all.dvReply.innerHTML = " ";
   document.all.dvReply.style.visibility = "hidden";
}
//==============================================================================
// populate selection fields on page load
//==============================================================================
function Validate(reply)
{
   var error = false;
   var errmsg = "";

   var msg = reply.txaMsg.value.trim()
   if (msg.length == 0) { error = true; errmsg += "\nPlease type a reply."}

   if (error){ alert(errmsg); }

   return !error;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function restart()
{
   window.location.reload();
}
//==============================================================================
// delete topic
//==============================================================================
function dltTopic(topnum, subj)
{

   var response = confirm("Subject:  " + subj + "\n\nConfirm that you want delete selected reply?");
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
   document.all.dvReply.innerHTML = html;
   document.RmvTopic.submit();
}

//==============================================================================
// go to prior group
//==============================================================================
function goPriorGrp(arg)
{
   var url = null;
   if(arg == PrevGrp.length - 1) { url = "BlogTopicList.jsp?"; }
   else { url = "BlogGrpList.jsp?"; }

   url += "BlogGrp=" + PrevGrp[arg] + "&BlogGrpNm=" + PrevGrpNm[arg]

   if(arg > 0)
   {
     for(var i=0; i < arg; i++)
     {
        url += "&PrevGrp=" + PrevGrp[i]
        url += "&PrevGrpNm=" + PrevGrpNm[i]
     }
   }
   //alert(url)
   window.location.href=url
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>


</head>
<body onload="bodyLoad();">
<!-- ======================================================================= -->
<div id="dvReply" style="position:absolute;visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:150px;background-color:LemonChiffon; z-index:10"></div>
<!-- ======================================================================= -->

   <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr>
       <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>RCI Forum - Topic List</font>
      <br><font color="#2b7ebb"><%=sSubj%></font>
      </b>
      <br><a href="../"><font color="red">Home</font></a>
          <!-- Show prior group list -->
          <%for(int i=0; i < sPrevGrp.length; i++){%>
             &#62; <a href="javascript: goPriorGrp(<%=i%>)"><%=sPrevGrpNm[i]%></a>
          <%}%>
<!------------- start of message table ------------------------>
      <table class="DataTable" width="100%" cellPadding="1" cellSpacing="1">
             <tr>
                <th class="HdrTable" width=20>Author</th>
                <th class="HdrTable" <%if(bAdmin){%>colspan=2<%}%> >Messages</th>
             </tr>

             <%for(int i=0; i < iNumOfMsg; i++)
             {
                bltopic.setTopicText(bdTopicNum[i].toString());
                String sText = bltopic.getText();
             %><tr class="DataTable<%if(i%2 == 0){%>1<%}%>">
                   <td class="DataTable" rowspan=2><%=sCrtUser[i]%></td>
                   <td class="DataTable">Added: <%=formatter.format(tsCrtTime[i])%>&nbsp; &nbsp; &nbsp; Subject: <%=sTopicName[i]%></td>

                   <%if(bAdmin){%>
                      <td class="DataTable" width="5%">
                         <%if(!bdMsgPrtNum[i].equals(BigDecimal.valueOf(0))) {%>
                            <a href="javascript: dltTopic('<%=bdTopicNum[i]%>', '<%=bltopic.cvtToASCIIHex(sTopicName[i])%>')">Remove</a></td>
                         <%}
                           else {%>&nbsp;<%}%>
                      </td>
                   <%}%>
               </tr>
               <tr class="DataTable<%if(i%2 == 0){%>1<%}%>">
                   <td class="DataTable3<%if(bdMsgPrtNum[i].equals(BigDecimal.valueOf(0))) {%>0<%}%>" <%if(bAdmin){%>colspan=2<%}%> ><%=sText%>&nbsp;</td>
               </tr>
               <tr class="Divider"><td colspan=<%if(bAdmin){%>3<%} else {%>2<%}%>>&nbsp;</td></tr>

             <%}%>
       <!------------------------------------------------------------------>
       </table>

       <button class="small" onclick="showReplyPanel()">Reply</button>


       </td>
    </tr>
  </table>
</body>
</html>
<%}%>