<%@ page import="rciutility.StoreSelect, storetobuyers.StrBuyerMsgBoard, java.util.*"%>
<%
   String sStore = request.getParameter("Store");
   String sThisStrName = request.getParameter("StrName");
   String sWeekend = request.getParameter("Weekend");

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;
   String sUser = " ";

   int iNumOfMsg = 0;
   String [] sSender = null;
   String [] sNick = null;
   String [] sDate = null;
   String [] sTime = null;
   String [] sRecipient = null;
   String [] sRcpNick = null;
   String [] sReqAnsw = null;
   String [] sReferTo = null;
   String [] sReply = null;
   String [] sAlwCancel = null;
   String [] sCanceled = null;
   String [] sDateStamp = null;
   String [] sText = null;

   String sUserJSA = null;
   String sUserNameJSA = null;

  //-------------- Security ---------------------
  String sStrAllowed = null;
  String sAccess = null;

  if (session.getAttribute("USER")==null || session.getAttribute("STRBYRMSG")==null)
  {
     response.sendRedirect("SignOn1.jsp?TARGET=StrBuyerMsgBoard.jsp&APPL=STRBYRMSG" + "&" + request.getQueryString());
  }
  else {
     sAccess = session.getAttribute("ACCESS").toString();
     sUser = session.getAttribute("USER").toString();
     sStrAllowed = session.getAttribute("STORE").toString();

  // -------------- End Security -----------------

   if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
   {
      StrSelect = new StoreSelect();
   }
   else
   {
      StrSelect = new StoreSelect(sStrAllowed);
   }
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();

   StrBuyerMsgBoard msgboard = new StrBuyerMsgBoard(sStore, sWeekend, sUser);
   iNumOfMsg = msgboard.getNumOfMsg();
   sSender = msgboard.getSender();
   sNick = msgboard.getNick();
   sDate = msgboard.getDate();
   sTime = msgboard.getTime();
   sRecipient = msgboard.getRecipient();
   sRcpNick = msgboard.getRcpNick();
   sReqAnsw = msgboard.getReqAnswer();
   sReferTo = msgboard.getRefer();
   sReply = msgboard.getReply();
   sAlwCancel = msgboard.getAlwCancel();
   sCanceled = msgboard.getStatus();
   sDateStamp = msgboard.getDateStamp();
   sText = msgboard.getText();

   sUserJSA = msgboard.getUserJSA();
   sUserNameJSA = msgboard.getUserNameJSA();

   msgboard.disconnect();

%>

<html>
<head>

<style>body {background:white;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:blue; font-size:12px}
        table.DataTable {border: black solid 1px ;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable  { background: #e0e0e0; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: azure; font-family:Arial; font-size:10px }
        tr.DataTable2 { background: #B4EEB4; font-family:Arial; font-size:10px }
        tr.DataTable3 { background: LemonChiffon; font-family:Arial; font-size:10px }
        tr.DataTable4 { background: pink; font-family:Arial; font-size:10px }
        tr.DataTable5 { font-family:Arial; font-size:10px }

        td.DataTable  { padding-top:3px; padding-bottom:3px; text-align:left }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; text-align:center }

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
var RecepList;
var RcpNickList;
var StrAlllowed;
var AprvSts;
<%if(sStrAllowed!=null){%>
  StrAllowed = "<%=sStrAllowed.trim()%>";
  RecepList = [<%=sUserJSA%>];
  RcpNickList = [<%=sUserNameJSA%>];
<%}%>

var Stores = [<%=sStr%>];
var StrNames = [<%=sStrName%>];

//==============================================================================
// load page
//==============================================================================
function bodyLoad()
{
doStrSelect();
doWeekendSelect();
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect() {
    var df = document.all;

    for (idx = 1; idx < Stores.length; idx++)
    {
      df.STORE.options[idx-1] = new Option(Stores[idx] + " - " + StrNames[idx],Stores[idx]);
      if(Stores[idx] == <%=sStore%>)
      {
        df.STORE.selectedIndex=idx-1;
      }
    }
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
// Message Entry
//==============================================================================
function MsgEntryMenu(Recipient, Nick, ReferTo)
{
  var MsgHtml = "<table cellPadding='0' cellSpacing='0' width='100%'>"
      + "<form name='NEWMSG' action='StrBuyerMsgSave.jsp' onSubmit='return Validate(this)' method='Get'>";

  if (Recipient == null)
  {
    MsgHtml += "<tr align='center'>"
      + "<td class='Grid'>New Message</td>"
  }
  else
  {
    MsgHtml += "<tr align='center'>"
      + "<td class='Grid'>Reply</td>"
  }
  MsgHtml += "<td  class='Grid2'>"
      + "<img src='CloseButton.bmp' onclick='javascript:hideMsgMenu();' alt='Close'>"
      + "</td></tr>"
      + "<tr class='Grid1'><td colspan='2'>"
      + "<input name='Sender' type='hidden' value='<%=sUser%>'>"
      + "<input name='Store' type='hidden' value='<%=sStore%>'>"
      + "<input name='StrName' type='hidden' value='<%=sThisStrName%>'>"
      + "<input name='Weekend' type='hidden' value='<%=sWeekend%>'>"
      + "<b>To:</b>&nbsp;<Select class='small' name='To'></Select>"

      MsgHtml += "</td></tr>"
      + "<tr class='Grid1'><td>"
      + "&nbsp;&nbsp;<TextArea class='small' name='Text'  cols='80' rows='5'>"
      + "</TextArea>"
      + "</td></tr>"
      + "<tr class='Grid1' ><td>"
      + "<input class='small' name='Submit' type='Submit' value='Submit'>";

      if (Recipient == null)
      {
        MsgHtml += "<input name='ReqAnswer' type='hidden' value='Y'>";
      }
      else
      {
        MsgHtml += "<input name='ReferTo' type='hidden' value='" + ReferTo + "'>";
      }

      MsgHtml += "&nbsp;&nbsp;<input class='small' name='Reset' type='Reset'>"
      + "&nbsp;&nbsp;<button class='small' name='close' onclick='hideMsgMenu()'>Close</button><br>&nbsp;</td></tr>"
      + "</form>"
      + "</table>"

    document.all.MsgMenu.innerHTML=MsgHtml
    document.all.MsgMenu.style.pixelLeft=150
    document.all.MsgMenu.style.pixelTop=document.documentElement.scrollTop+160;
    document.all.MsgMenu.style.visibility="visible"

    loadRecep(Recipient, Nick);
}
//==============================================================================
// load recepient
//==============================================================================
function loadRecep(Recipient, Nick)
{
  for(i=0; i < RecepList.length; i++)
  {
    document.forms[0].To.options[i] = new Option(RcpNickList[i], RecepList[i]);

    if(Recipient == RecepList[i])
    {
      document.forms[0].To.selectedIndex=i;
     }
  }
}
//==============================================================================
// close employee selection window
//==============================================================================
function hideMsgMenu(){
    document.all.MsgMenu.style.visibility="hidden"
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
// validate entry parameters before submiting form
//==============================================================================
function Validate(form)
{
 var msg = " ";
 var error = false;
 var text = form.Text.value;
 var fnd = false;

 var rcp = form.To.options[form.To.selectedIndex].value;
 var snd = form.Sender.value;

 // sender and Recipient cannot be equal
 if(rcp == snd)
 {
   msg ="You cannot send message to yourself.\n"
   error = true;
 }

 // check if user enter the text in text area
 for(i=0; i < text.length; i++)
 {
   if(  text.substring(i, i+1) != " "
     && escape(text.substring(i, i+1)) != "%0D"
     && escape(text.substring(i, i+1)) != "%0A")
   {
     fnd = true;
     break;
   }
 }

 if(!fnd)
 {
   msg +="Please, enter a text of your message."
   error = true;
 }

 // show error messages or hide menu
 if(error) alert(msg)
 else hideMsgMenu();

 return error == false;
}
//==============================================================================
// ---------------- Move Boxes ---------------------------------------
//==============================================================================
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
<!-- ----------------------------------------------------------------------- -->
<div id="dvSelect" class="SelPanel">
  <table border="0" width="100%" cellPadding="0" cellSpacing="0">
    <tr class="DataTable5"><td>Store</td><td><SELECT name="STORE" class="small"></SELECT></td></tr>
    <tr class="DataTable5"><td>Weekend&nbsp;&nbsp;</td><td ><SELECT name="WEEK" class="small"></SELECT>&nbsp;
    <button class="small" name="Go" onclick="javascript:newStrWkSel();">Go</button></td></tr>
  </table>
</div>
<!-- ----------------------------------------------------------------------- -->

<!-- ----------------------------------------------------------------------- -->
 <div id="MsgMenu" style="position:absolute;visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:150px;background-color:LemonChiffon; z-index:10"></div>
<!-- ----------------------------------------------------------------------- -->
   <table border="0" width="100%" cellPadding="0" cellSpacing="0">
     <tr VALIGN="TOP">

     <td ALIGN="center">
      <b>Retail Concepts, Inc
      <br>Message Board<br>
      Store Selected: <%=sStore + " - " + sThisStrName%><br>
      Weekend: <%=sWeekend%><br></b>

    </tr>
    <tr  VALIGN="TOP">
    <td ALIGN="left">
      <button class="small" onClick="MsgEntryMenu(null, null)">New Message</button>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <a href="../"><font color="red" size="-1">Home</font></a>&#62;
        <font size="-1">This page;</font>

<!------------- start of dollars table ------------------------>
      <table class="DataTable" align="center" width="100%">
             <tr>
                <th class="DataTable">From</th>
                <th class="DataTable">To</th>
                <th class="DataTable">Message</th>
                <th class="DataTable">&nbsp;</th>
                <th class="DataTable">Date</th>
                <th class="DataTable">Time</th>
                <th class="DataTable">Cancel</th>
             </tr>

             <%for(int i=0; i < iNumOfMsg; i++){%>
               <tr class="<%if(sCanceled[i].equals("Y")) out.print("DataTable3");
                            else if(sReqAnsw[i].equals("Y")) out.print("DataTable");
                            else out.print("DataTable1");%>">
                 <td class="DataTable" nowrap><%=sNick[i]%></td>
                 <td class="DataTable" nowrap><%=sRcpNick[i]%></td>
                 <td class="DataTable">
                   <%=sText[i]%></td>
                 <td class="DataTable1">
                     <%if(!sCanceled[i].equals("Y") && sReqAnsw[i].equals("Y")){%>
                       <a href="javascript: MsgEntryMenu('<%=sSender[i]%>', '<%=sNick[i]%>','<%=sReferTo[i]%>')">
                          Reply</a>
                     <%}%>
                 </td>
                 <td class="DataTable1" nowrap><%=sDate[i]%></td>
                 <td class="DataTable1" nowrap><%=sTime[i]%></td>
                 <td class="DataTable1" nowrap>
                    <%if(sAlwCancel[i].equals("C")) {%>
                       <a href="StrBuyerMsgSave.jsp?Store=<%=sStore%>&StrName=<%=sThisStrName%>&Weekend=<%=sWeekend%>&Sender=<%=sSender[i]%>&User=<%=sUser%>&To=<%=sRecipient[i]%>&ReferTo=<%=sReferTo[i]%>&DateStamp=<%=sDateStamp[i]%>&Cancel=Y"><%=sAlwCancel[i]%></a>
                    <%}%>
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