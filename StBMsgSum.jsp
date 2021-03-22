<%@ page import="rciutility.StoreSelect,rciutility.ReceiveUserList,storetobuyers.StBMsgSum, java.util.*"%>
<%
   String sMsgRcv = request.getParameter("Receiver");
   String sMsgRcvNick = request.getParameter("RcvNick");

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;
   String sUser = " ";

   String [] sSender = null;
   String [] sDate = null;
   String [] sTime = null;
   String [] sRecepient = null;
   String [] sReqAnsw = null;
   String [] sReferTo = null;
   String [] sApprove = null;
   String [] sText = null;

   String sUserJSA = null;

   int iNumOfMsg = 0;
   String [] sMsgStr = null;
   String [] sMsgStrName = null;
   String [] sMsgWkend = null;
   String [] sNumOfReq = null;
   String [] sNumOfRsp = null;
   String [] sOldest = null;

   // user list
  int iNumOfUsr = 0;
  String [] sUsers = null;
  String [] sNicks = null;
  String sUsersJSA =  null;
  String sNicksJSA = null;
  String sStoreJSA = null;

  //-------------- Security ---------------------
  String sStrAllowed = null;
  String sAccess = null;

  if (session.getAttribute("USER")==null)
  {
     response.sendRedirect("SignOn1.jsp?TARGET=StBMsgSum.jsp&APPL=ALL&" + request.getQueryString());
  }
  else {
     sAccess = session.getAttribute("ACCESS").toString();
     sUser = session.getAttribute("USER").toString();
     sStrAllowed = session.getAttribute("STORE").toString();

  // -------------- End Security -----------------

   if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
   {
      StrSelect = new StoreSelect(4);
   }
   else
   {
      StrSelect = new StoreSelect(sStrAllowed);
   }
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();

   // get message board summary by stores and weekends
   if (sMsgRcv == null) sMsgRcv = sUser;

   StBMsgSum newmsg = new StBMsgSum(" ", " ", sMsgRcv);
   iNumOfMsg = newmsg.getNumOfMsg();
   sMsgStr = newmsg.getStr();
   sMsgStrName = newmsg.getStrName();
   sMsgWkend = newmsg.getWeekend();
   sNumOfReq = newmsg.getNumReq();
   sNumOfRsp = newmsg.getNumRsp();
   sOldest = newmsg.getOldest();
   newmsg.disconnect();

    // Set list of users
    ReceiveUserList rcvUsr = new ReceiveUserList();
    iNumOfUsr = rcvUsr.getNumOfUser();
    sUsers = rcvUsr.getUsers();
    sNicks = rcvUsr.getNicks();
    sUsersJSA = rcvUsr.getUsersJSA();
    sNicksJSA = rcvUsr.getNicksJSA();
    sStoreJSA = rcvUsr.getStoreJSA();
    rcvUsr.disconnect();

    // find nick for pending message receiver
    if (sMsgRcvNick == null)
    {
      for(int i=0; i < iNumOfUsr;  i++)
      {
        if(sMsgRcv.trim().equals(sUsers[i].trim())) sMsgRcvNick = sNicks[i];
      }
    }
  }
%>

<html>
<head>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable {background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable  { background: lightgrey; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: white; font-family:Arial; font-size:10px }
        tr.DataTable2 { background: pink; font-family:Arial; font-size:10px }
        tr.DataTable5 { font-family:Arial; font-size:10px }

        td.DataTable  { padding-top:3px; padding-bottom:3px; text-align:left }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; text-align:center }
        td.DataTable2 { padding-top:3px; padding-bottom:3px; text-align:left}

        input.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:left; font-family:Arial; font-size:10px;}
        select.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:left; font-family:Arial; font-size:10px;}
        button.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:center; font-family:Arial; font-size:10px;}
        textarea.small{ text-align:left; font-family:Arial; font-size:10px;}

        td.Grid  { background:darkblue; color:white; text-align:center; font-family:Arial; font-size:11px; font-weight:bolder}
        tr.Grid1 { text-align:center; font-family:Arial; font-size:10px;}
        td.Grid2  { background:darkblue; color:white; text-align:right; font-family:Arial; font-size:11px; font-weight:bolder}

        div.SelPanel { position:absolute; background-attachment: scroll;  border: black solid 1px; width:250;
                     background-color:cornsilk; z-index:10; padding-top:3px; padding-bottom:3px;
                     padding-right:3px; padding-left:3px; text-align:center; font-size:10px}
</style>

<SCRIPT language="JavaScript">
var StrAlllowed;
<%if(sStrAllowed!=null){%>
  StrAllowed = "<%=sStrAllowed.trim()%>";
<%}%>

var Stores = [<%=sStr%>];
var StrNames = [<%=sStrName%>];

var NumOfUsr = <%=iNumOfUsr%>;
var Users = [<%=sUsersJSA%>];
var Nicks = [<%=sNicksJSA%>];
var UsrStores = [<%=sStoreJSA%>];
//==============================================================================
// populate selection fields on page load
//==============================================================================
function bodyLoad()
{
  doStrSelect();
  doWeekendSelect();

  if (StrAllowed == "ALL")  doUserSelect();
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect() {
    var df = document.all;

    for (idx = 1; idx < Stores.length; idx++)
                df.STORE.options[idx-1] = new Option(Stores[idx] + " - " + StrNames[idx],Stores[idx]);
    df.STORE.selectedIndex=0;
}

//==============================================================================
// load weekends
//==============================================================================
function doWeekendSelect() {
    var df = document.all;
    var date = new Date();
    date.setHours(18);

    while(date.getDay() != 0) { date = new Date(date - (-1 * 86400000)); }

    for (var i = 0; i < 20; i++)
    {
      var usadt = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
      df.WEEK.options[i] = new Option(usadt, usadt);
      date = new Date(date - 86400000 * 7);
    }
}
//==============================================================================
// populate user list
//==============================================================================
function doUserSelect()
{
  var df = document.all;
  for (idx = 0; idx < NumOfUsr; idx++)
  {
    df.USER.options[idx] = new Option(UsrStores[idx] + " " + Nicks[idx], Users[idx]);
    if(Users[idx] == "<%=sUser.trim()%>")
    {
      df.USER.selectedIndex=idx;
    }
  }
}
//==============================================================================
// retreive selected store and week
//==============================================================================
function newStrWkSel()
{
 var strIdx = document.all.STORE.selectedIndex
 var str = document.all.STORE.options[strIdx].value
 var strnm = StrNames[strIdx+1];
 var wkIdx = document.all.WEEK.selectedIndex
 var week = document.all.WEEK.options[wkIdx].value

 var loc = "StrBuyerMsgBoard.jsp?Store=" + str + "&StrName=" + strnm
         + "&Weekend=" + week
 //alert(loc)
 window.location.href=loc;
}
//==============================================================================
// pending messages for another user
//==============================================================================
function newPendingMessages()
{
  var idx = document.all.USER.selectedIndex;
  var loc = "StBMsgSum.jsp?Receiver=" + Users[idx]
          + "&RcvNick=" + Nicks[idx]

  //alert(loc)
  window.location.href=loc;
}

// ---------------- Move Boxes ---------------------------------------
var dragapproved=false
var z,x,y
function move(){
if (event.button==1&&dragapproved){
z.style.pixelLeft=temp1+event.clientX-x
z.style.pixelTop=temp2+event.clientY-y
return false
}
}
function drags(){
if (!document.all)
return
var obj = event.srcElement

if (event.srcElement.className=="Grid"
    || event.srcElement.className=="Menu"
    || event.srcElement.className=="Menu1"){
   while (obj.offsetParent){
     if (obj.id=="menu" || obj.id=="MsgMenu")
     {
       z=obj;
       break;
     }
     obj = obj.offsetParent;
   }
  dragapproved=true;
  temp1=z.style.pixelLeft
  temp2=z.style.pixelTop
  x=event.clientX
  y=event.clientY
  document.onmousemove=move
}
}
document.onmousedown=drags
document.onmouseup=new Function("dragapproved=false")
// ---------------- End of Move Boxes ---------------------------------------
</SCRIPT>



</head>
<body  onload="bodyLoad();">
<div id="dvSelect" class="SelPanel">
         <table border="0" width="100%" cellPadding="0" cellSpacing="0">
           <tr class="DataTable5"><td colspan=2 nowrap ><b>Go to Message Board</b></td></tr>
           <tr class="DataTable5"><td>Store</td><td><SELECT name="STORE" class="small"></SELECT></td></tr>
           <tr class="DataTable5"><td>Weekend&nbsp;&nbsp;</td><td ><SELECT name="WEEK" class="small"></SELECT>&nbsp;
             <button class="small" name="Go" onclick="javascript:newStrWkSel();">Go</button></td></tr>
         </table>
       </div>

 <div id="MsgMenu" style="position:absolute;visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:150px;background-color:LemonChiffon; z-index:10"></div>

   <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>Pending Messages - <%=sMsgRcvNick%><br>

      </font></b>

      <%if(sStrAllowed != null && sStrAllowed.startsWith("ALL")){%>
        <br><br>User: <SELECT name="USER"></SELECT>&nbsp;&nbsp;&nbsp;
        <button name="Get" onclick="javascript:newPendingMessages();">Get</button>
      <%}%>
      <p><a href="../"><font color="red">Home</font></a>&#62;
        <a href="StrScheduling.html"><font color="red">Payroll</font></a>&#62;
        This page
<!------------- start of dollars table ------------------------>
      <table class="DataTable" align="center" >
             <tr>
                <th class="DataTable">Store<br>#</th>
                <th class="DataTable">Store Name</th>
                <th class="DataTable">Date of<br>Message</th>
                <th class="DataTable">Week Ending</th>
                <th class="DataTable">New</th>
                <th class="DataTable">Reply</th>
             </tr>

             <%for(int i=0; i < iNumOfMsg; i++){%>
               <tr class="DataTable">
                 <td class="DataTable"><%=sMsgStr[i]%></td>
                 <td class="DataTable"><%=sMsgStrName[i]%></td>
                 <td class="DataTable"><%=sOldest[i]%></td>
                 <td class="DataTable">
                    <a href="StrBuyerMsgBoard.jsp?Store=<%=sMsgStr[i]%>&StrName=<%=sMsgStrName[i]%>&Weekend=<%=sMsgWkend[i]%>">
                      <%=sMsgWkend[i]%></a></td>
                 <td class="DataTable"><%=sNumOfReq[i]%></td>
                 <td class="DataTable"><%=sNumOfRsp[i]%></td>
               </tr>
             <%}%>
       </table>
    <td></tr>
  </table>



</body>
</html>
