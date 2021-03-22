<%@ page import="payrollreports.SetNewMsgLst, java.util.*"%>
<%
   SetNewMsgLst setNewMsg = new SetNewMsgLst();

   String sStrJSA = setNewMsg.getStrJSA();
   String sRecepientJSA = setNewMsg.getRecepientJSA();
   String sNumOfReqJSA = setNewMsg.getNumOfReqJSA();
   String sNumOfRspJSA = setNewMsg.getNumOfRspJSA();
   String sOldDateJSA = setNewMsg.getOldDateJSA();

   setNewMsg.disconnect();
%>
<html>
<head>
<style>
 body {background:ivory;}
</style>
</head>

<SCRIPT language="JavaScript1.2">
var Store = new Array(0);
var Recepient = new Array(0);
var NumOfReq = new Array(0);
var NumOfRsp = new Array(0);
var OldDate = new Array(0);

  Store = [<%=sStrJSA%>];
  Recepient = [<%=sRecepientJSA%>];
  NumOfReq = [<%=sNumOfReqJSA%>]
  NumOfRsp = [<%=sNumOfRspJSA%>]
  OldDate = [<%=sOldDateJSA%>]
  SendMsgBrd( Store, Recepient, NumOfReq, NumOfRsp, OldDate );

// send employee availability to schedule
function SendMsgBrd()
{
  var html = popNewSchMsgTbl();
  window.parent.setSchNewMsg(html);  
}
// ------------------------------------------------------
// populate new mesage table
// ------------------------------------------------------
function popNewSchMsgTbl(){
  var html = "<table class='msg'>"
             + "<tr><td class='msg1' colspan=5 nowarp ><a class='blue' href='ForumSum.jsp'>Schedule Message board - Pending</a></td></tr>"
             + "<tr><td class='msg1'>Str</td>"
             + "<td class='msg1' >User</td>"
             + "<td class='msg1' >Oldest</td>"
             + "<td class='msg1'>New</td>"
             + "<td class='msg1'>Reply</td></tr>";
  for(i=0; i < Store.length; i++)
  {
    html += "<tr>"
           + "<td class='msg2'>" + Store[i] + "</td>"
           + "<td class='msg' nowrap>" + Recepient[i] + "</td>"
           + "<td class='msg2'>" + OldDate[i] + "</td>"
           + "<td class='msg2'>" + NumOfReq[i] + "</td>"
           + "<td class='msg2'>" + NumOfRsp[i] + "</td>"
           + "</tr>"
  }
  html += "</table>";
  return html;
}
</SCRIPT>
</html>





