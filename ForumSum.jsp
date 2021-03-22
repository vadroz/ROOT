<%@ page import="rciutility.StoreSelect,rciutility.ReceiveUserList, payrollreports.ChkMsgBoard, payrollreports.SetWeeks, java.util.*"%>
<%
   String sMsgRcv = request.getParameter("Receiver");
   String sMsgRcvNick = request.getParameter("RcvNick");

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;
   String sUser = " ";

   SetWeeks SetWk = null;
   int iNumOfWeeks = 0;
   String  sWeeksJSA = null;
   String  sMonthBegJSA = null;
   String  sBaseWkJSA = null;
   String  sBsWkNameJSA = null;
   String sBsMonBegJSA = null;

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
   String [] sOldDate = null;

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
  String sAppl = "PAYROLL";

  if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
  {
     response.sendRedirect("SignOn1.jsp?TARGET=ForumSum.jsp&APPL=" + sAppl + "&" + request.getQueryString());
  }
  else {
     sAccess = session.getAttribute("ACCESS").toString();
     sUser = session.getAttribute("USER").toString();
     sStrAllowed = session.getAttribute("STORE").toString();
  // -------------- End Security -----------------
  Vector vStr = (Vector) session.getAttribute("STRLST");
  String [] sStrAlwLst = new String[ vStr.size()];
  Iterator iter = vStr.iterator();

  int iStrAlwLst = 0;
  while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

   if (sStrAllowed != null) {
     if (sStrAllowed.startsWith("ALL"))
     {
       StrSelect = new StoreSelect(5);
     }
     else
     {
       if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
       else StrSelect = new StoreSelect(new String[]{sStrAllowed});
     }
   }

   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();

   SetWk = new SetWeeks("11WK");
   sWeeksJSA = SetWk.getWeeksJSA();
   iNumOfWeeks = SetWk.getNumOfWeeks();
   sMonthBegJSA = SetWk.getMonthBegJSA();
   sBaseWkJSA = SetWk.getBaseWkJSA();
   sBsWkNameJSA = SetWk.getBsWkNameJSA();
   sBsMonBegJSA = SetWk.getBsMonBegJSA();
   SetWk.disconnect();

   // get message board summary by stores and weekends
   if (sMsgRcv == null) sMsgRcv = sUser;
   ChkMsgBoard chkMsgBrd = new ChkMsgBoard(sMsgRcv);
   iNumOfMsg = chkMsgBrd.getNumOfMsg();
   sMsgStr = chkMsgBrd.getMsgStr();
   sMsgStrName = chkMsgBrd.getMsgStrName();
   sMsgWkend = chkMsgBrd.getMsgWkend();
   sNumOfReq = chkMsgBrd.getNumOfReq();
   sNumOfRsp = chkMsgBrd.getNumOfRsp();
   sOldDate = chkMsgBrd.getOldDate();

    chkMsgBrd.disconnect();

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
</style>

<SCRIPT language="JavaScript">
var StrAlllowed;
<%if(sStrAllowed!=null){%>
  StrAllowed = "<%=sStrAllowed.trim()%>";
<%}%>

var Stores = [<%=sStr%>];
var StrNames = [<%=sStrName%>];
var Weeks = [<%=sWeeksJSA%>];
var MonthBeg = [<%=sMonthBegJSA%>];
var BaseWk = [<%=sBaseWkJSA%>];
var BsMonBeg = [<%=sBsMonBegJSA%>]
var BsWkName = [<%=sBsWkNameJSA%>];
var NumBase = <%=iNumOfWeeks%>

var NumOfUsr = <%=iNumOfUsr%>;
var Users = [<%=sUsersJSA%>];
var Nicks = [<%=sNicksJSA%>];
var UsrStores = [<%=sStoreJSA%>];

// populate selection fields on page load
function bodyLoad()
{
  doStrSelect();
  doWeekSelect();
  if (StrAllowed == "ALL")  doUserSelect();
}

// Load Stores
function doStrSelect() {
    var df = document.all;

    for (idx = 1; idx < Stores.length; idx++)
                df.STORE.options[idx-1] = new Option(Stores[idx] + " - " + StrNames[idx],Stores[idx]);
    df.STORE.selectedIndex=0;
}

// Weeks Stores
function doWeekSelect() {
    var df = document.all;
    var idx = 0;
    for (idx = 0; idx < Weeks.length; idx++)
    {
      df.WEEK.options[idx] =
            new Option(Weeks[idx], Weeks[idx]);
      df.WEEK.selectedIndex=5;
    }

    for (idy=0; idy < NumBase; idy++, idx++)
    {
      df.WEEK.options[idx] =
            new Option(BsWkName[idy], BaseWk[idy]);
    }
}

// populate user list
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

// retreive selected store and week
function newStrWkSel()
{
 var strIdx = document.all.STORE.selectedIndex
 var str = document.all.STORE.options[strIdx].value
 var strnm = StrNames[strIdx+1];
 var wkIdx = document.all.WEEK.selectedIndex
 var week = document.all.WEEK.options[wkIdx].value

 var loc = "Forum.jsp?STORE=" + str + "&STRNAME=" + strnm
         + "&WEEKEND=" + week
 //alert(loc)
 window.location.href=loc;
}

function newPendingMessages()
{
  var idx = document.all.USER.selectedIndex;
  var loc = "ForumSum.jsp?Receiver=" + Users[idx]
          + "&RcvNick=" + Nicks[idx];
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

 <div id="MsgMenu" style="position:absolute;visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:150px;background-color:LemonChiffon; z-index:10"></div>

   <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>Pending Messages - <%=sMsgRcvNick%><br>

      </font></b>

      <br>Store: <SELECT name="STORE"></SELECT>&nbsp;&nbsp;&nbsp;
          Weekend: <SELECT name="WEEK"></SELECT>&nbsp;
          <button name="Go" onclick="javascript:newStrWkSel();">Go</button>

      <%if(sStrAllowed != null && sStrAllowed.startsWith("ALL")){%>
        <br><br>User: <SELECT name="USER"></SELECT>&nbsp;&nbsp;&nbsp;
        <button name="Get" onclick="javascript:newPendingMessages();">Get</button>
      <%}%>

      <p><a href="../"><font color="red">Home</font></a>&#62;
        <!-- a href="StrScheduling.html"><font color="red">Payroll</font></a-->
        This page
<!------------- start of dollars table ------------------------>
      <table class="DataTable" align="center" >
             <tr>
                <th class="DataTable">Store<br>#</th>
                <th class="DataTable">Store Name</th>
                <th class="DataTable">Date of<br>Message</th>
                <th class="DataTable">Schedule for<br>Week Ending</th>
                <th class="DataTable">New</th>
                <th class="DataTable">Reply</th>
             </tr>

             <%for(int i=0; i < iNumOfMsg; i++){%>
             <%System.out.println(i);%>
               <tr class="DataTable">
                 <td class="DataTable"><%=sMsgStr[i]%></td>
                 <td class="DataTable"><%=sMsgStrName[i]%></td>
                 <td class="DataTable"><%=sOldDate[i]%></td>
                 <td class="DataTable">
                    <a href="Forum.jsp?STORE=<%=sMsgStr[i]%>&STRNAME=<%=sMsgStrName[i]%>&WEEKEND=<%=sMsgWkend[i]%>">
                      <%=sMsgWkend[i]%></a></td>
                 <td class="DataTable"><%=sNumOfReq[i]%></td>
                 <td class="DataTable"><%=sNumOfRsp[i]%></td>
               </tr>
             <%}%>
       </table>

       </td>
    </tr>
  </table>

</body>
</html>
