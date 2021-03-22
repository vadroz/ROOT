<%@ page import="storetobuyers.StBNewMsgLst, java.util.*"%>
<%
   String sUser = request.getParameter("User");

   StBNewMsgLst setNewMsg = new StBNewMsgLst(sUser);

   String sStrJSA = setNewMsg.getStrJSA();
   String sStrNameJSA = setNewMsg.getStrNameJSA();
   String sRcpntJSA = setNewMsg.getRcpntJSA();
   String sRcpNameJSA = setNewMsg.getRcpNameJSA();
   String sNumOfReqJSA = setNewMsg.getNumOfReqJSA();
   String sNumOfRspJSA = setNewMsg.getNumOfRspJSA();
   String sOldDateJSA = setNewMsg.getOldDateJSA();
   String sWeekJSA = setNewMsg.getWeekJSA();

   setNewMsg.disconnect();

%>
<html>
<head>
<style>
 body {background:ivory;}
</style>
</head>

<SCRIPT language="JavaScript1.2">

var Store = [<%=sStrJSA%>];
var StrName = [<%=sStrNameJSA%>];
var Recept = [<%=sRcpntJSA%>];
var RcpName = [<%=sRcpNameJSA%>];
var NumOfReq = [<%=sNumOfReqJSA%>];
var NumOfRsp = [<%=sNumOfRspJSA%>];
var OldDate = [<%=sOldDateJSA%>];
var Week = [<%=sWeekJSA%>];

SendMsgBrd();

//==============================================================================
// send employee availability to schedule
//==============================================================================
function SendMsgBrd()
{
  var html = popTable();
  parent.setStBNewMsg(html);
}
// ------------------------------------------------------
// populate new mesage table
// ------------------------------------------------------
function popTable(){

  var html = "<table class='msg'>"
             + "<tr><td nowrap class='msg1' colspan=5 nowarp ><a class='blue' href='StBMsgSum.jsp'>Stores/Buyers Message board - Pending</a></td></tr>"
             + "<tr><td class='msg1'>Str</td>"
             + "<td class='msg1' >User</td>"
             + "<td class='msg1' >Oldest</td>"
             + "<td class='msg1'>New</td>"
             + "<td class='msg1'>Reply</td></tr>";
  for(i=0; i < Store.length; i++)
  {
    html += "<tr>"
           + "<td class='msg2'>" + Store[i] + "</td>"
           + "<td class='msg' nowrap><a href='javascript: showStrWkMsgB(" + i + ")'>" + Recept[i] + "</a></td>"
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