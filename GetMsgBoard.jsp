<%@ page import="payrollreports.ChkMsgBoard, java.util.*"%>
<%
   String sStore = request.getParameter("STORE");
   String sWeekend = request.getParameter("WEEKEND");
   String sUser = request.getParameter("USER");
   String sSelf = request.getParameter("Self");

   String sAprvSts = null;
   String sAprvSnd = null;
   String sAprvDat = null;
   String sAprvTim = null;
   int iNumOfMsg = 0;
   String sMsgStrJSA = null;
   String sMsgStrNameJSA = null;
   String sMsgWkendJSA = null;
   String sNumOfReqJSA = null;
   String sNumOfRspJSA = null;

   if(sSelf != null) {
    ChkMsgBoard chkMsgBrd = new ChkMsgBoard(sStore, sWeekend, sUser);
    sAprvSts = chkMsgBrd.getAprvSts();
    sAprvSnd = chkMsgBrd.getAprvSnd();
    sAprvDat = chkMsgBrd.getAprvDat();
    sAprvTim = chkMsgBrd.getAprvTim();

    iNumOfMsg = chkMsgBrd.getNumOfMsg();
    sMsgStrJSA = chkMsgBrd.getMsgStrJSA();
    sMsgStrNameJSA = chkMsgBrd.getMsgStrNameJSA();
    sMsgWkendJSA = chkMsgBrd.getMsgWkendJSA();
    sNumOfReqJSA = chkMsgBrd.getNumOfReqJSA();
    sNumOfRspJSA = chkMsgBrd.getNumOfRspJSA();

    chkMsgBrd.disconnect();
   }
%>
<html>
<head>
<style>
 body {background:ivory;}
</style>
</head>

<SCRIPT language="JavaScript1.2">
var AprvSts = "<%=sAprvSts%>";
var AprvSnd = "<%=sAprvSnd%>";
var AprvDat = "<%=sAprvDat%>";
var AprvTim = "<%=sAprvTim%>";

var MsgStr = new Array(0);
var MsgStrName = new Array(0);
var MsgWkend = new Array(0);
var NumOfReq = new Array(0);
var NumOfRsp = new Array(0);

<%if(iNumOfMsg > 0){%>
  MsgStr = [<%=sMsgStrJSA%>];
  MsgStrName = [<%=sMsgStrNameJSA%>];
  MsgWkend = [<%=sMsgWkendJSA%>];
  NumOfReq = [<%=sNumOfReqJSA%>];
  NumOfRsp = [<%=sNumOfRspJSA%>];
<%}%>

<%if(sSelf == null) {%>
  redirect();
<%}
else {%>
  SendMsgBrd(AprvSts, AprvSnd, AprvDat, AprvTim, MsgStr, MsgStrName,
  MsgWkend, NumOfReq, NumOfRsp);
<%}%>

// resubmit to itself - it will display "wait..." message
function redirect()
{
  document.write("<font color='red'><marquee behavior='alternate'>&nbsp;&nbsp;&nbsp;&nbsp;Wait while check message board...<marquee></font>");
  var redir = window.location + "&Self=Yes"
  window.location.href=redir
}

// send employee availability to schedule
function SendMsgBrd(AprvSts, AprvSnd, AprvDat, AprvTim, MsgStr, MsgStrName,
                    MsgWkend, NumOfReq, NumOfRsp)
{
  parent.setMsgBrd(AprvSts, AprvSnd, AprvDat, AprvTim, MsgStr, MsgStrName,
                   MsgWkend, NumOfReq, NumOfRsp);
   //alert(MsgWkend[0] + "|" + NumOfReq[0] + "|" + NumOfRsp[0])
  window.close();
}
</SCRIPT>

</html>


