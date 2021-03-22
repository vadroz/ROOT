<%@ page import="rciutility.StoreSelect, payrollreports.SetMsgBrd, payrollreports.SetWeeks, java.util.*"%>
<%
   String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String sWeekend = request.getParameter("WEEKEND");
   String sMonth = request.getParameter("MONBEG");
   if(sMonth==null) sMonth = " ";

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;
   String sUser = " ";

   SetWeeks SetWk = null;
   int iNumOfWeeks = 0;
   String  sWeeksJSA = null;
   String [] sWeeks = null;
   String  sMonthBegJSA = null;
   String [] sMonthBeg = null;
   String  sBaseWkJSA = null;
   String  sBsWkNameJSA = null;
   String sBsMonBegJSA = null;

   int iNumOfMsg = 0;
   String [] sSender = null;
   String [] sNick = null;
   String [] sDate = null;
   String [] sTime = null;
   String [] sRecepient = null;
   String [] sRcpNick = null;
   String [] sReqAnsw = null;
   String [] sReferTo = null;
   String [] sApprove = null;
   String [] sAlwCancel = null;
   String [] sCanceled = null;
   String [] sDateStamp = null;
   String [] sText = null;

   String sAprvSts = null;
   String sAprvSnd = null;
   String sAprvDat = null;
   String sAprvTim = null;

   String sUserJSA = null;
   String sUserNameJSA = null;

  //-------------- Security ---------------------
  String sStrAllowed = null;
  String sAccess = null;
  String sAppl = "PAYROLL";

  if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
  {
     response.sendRedirect("SignOn1.jsp?TARGET=Forum.jsp&APPL=" + sAppl + "&" + request.getQueryString());
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

   if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
   {
      StrSelect = new StoreSelect(4);
   }
   else
   {
      if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst);}
      else StrSelect = new StoreSelect(new String[]{sStrAllowed});
   }
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();

   SetWk = new SetWeeks("11WK");
   sWeeksJSA = SetWk.getWeeksJSA();
   sWeeks = SetWk.getWeeks();
   iNumOfWeeks = SetWk.getNumOfWeeks();
   sMonthBegJSA = SetWk.getMonthBegJSA();
   sMonthBeg = SetWk.getMonthBeg();
   sBaseWkJSA = SetWk.getBaseWkJSA();
   sBsWkNameJSA = SetWk.getBsWkNameJSA();
   sBsMonBegJSA = SetWk.getBsMonBegJSA();
   SetWk.disconnect();

   SetMsgBrd setMsgBrd = new SetMsgBrd(sStore, sWeekend, sUser);
   iNumOfMsg = setMsgBrd.getNumOfMsg();
   sSender = setMsgBrd.getSender();
   sNick = setMsgBrd.getNick();
   sDate = setMsgBrd.getDate();
   sTime = setMsgBrd.getTime();
   sRecepient = setMsgBrd.getRecepient();
   sRcpNick = setMsgBrd.getRecepientNick();
   sReqAnsw = setMsgBrd.getReqAnsw();
   sReferTo = setMsgBrd.getReply();
   sApprove = setMsgBrd.getApprove();
   sAlwCancel = setMsgBrd.getAllowCancel();
   sCanceled = setMsgBrd.getCanceled();
   sDateStamp = setMsgBrd.getDateStamp();
   sText = setMsgBrd.getText();

   sAprvSts = setMsgBrd.getAprvSts();
   sAprvSnd = setMsgBrd.getAprvSnd();
   sAprvDat = setMsgBrd.getAprvDat();
   sAprvTim = setMsgBrd.getAprvTim();
   sUserJSA = setMsgBrd.getUserJSA();
   sUserNameJSA = setMsgBrd.getUserNameJSA();

   setMsgBrd.disconnect();

   // populate month begining date
   if(sMonth.equals(" "))
   {
     for(int i=0; i < sWeeks.length; i++)
     {
       if(sWeeks[i].equals(sWeekend))
       {
         sMonth = sMonthBeg[i];
         break;
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
        tr.DataTable2 { background: #B4EEB4; font-family:Arial; font-size:10px }
        tr.DataTable3 { background: LemonChiffon; font-family:Arial; font-size:10px }
        tr.DataTable4 { background: pink; font-family:Arial; font-size:10px }

        td.DataTable  { padding-top:3px; padding-bottom:3px; text-align:left }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; text-align:center }

        input.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:left; font-family:Arial; font-size:10px;}
        select.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:left; font-family:Arial; font-size:10px;}
        button.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:center; font-family:Arial; font-size:10px;}
        textarea.small{ text-align:left; font-family:Arial; font-size:10px;}

        td.Grid  { background:darkblue; color:white; text-align:center; font-family:Arial; font-size:11px; font-weight:bolder}
        tr.Grid1 { text-align:center; font-family:Arial; font-size:10px;}
        td.Grid2  { background:darkblue; color:white; text-align:right; font-family:Arial; font-size:11px; font-weight:bolder}
</style>

<SCRIPT language="JavaScript">
var RecepList;
var RcpNickList;
var StrAlllowed;
var AprvSts;
var RegManager = false;
<%if(sStrAllowed!=null){%>
  StrAllowed = "<%=sStrAllowed.trim()%>";
  RecepList = [<%=sUserJSA%>];
  RcpNickList = [<%=sUserNameJSA%>];
  AprvSts = "<%=sAprvSts.trim()%>";
  RegManager = <%=(vStr.size() > 1)%>
<%}%>

var Stores = [<%=sStr%>];
var StrNames = [<%=sStrName%>];
var Weeks = [<%=sWeeksJSA%>];
var MonthBeg = [<%=sMonthBegJSA%>];
var BaseWk = [<%=sBaseWkJSA%>];
var BsMonBeg = [<%=sBsMonBegJSA%>]
var BsWkName = [<%=sBsWkNameJSA%>];
var NumBase = <%=iNumOfWeeks%>



function bodyLoad()
{
doStrSelect();
doWeekSelect();
}

// Load Stores
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

// Message Entry
function MsgEntryMenu(Recepient, Nick, ReferTo)
{
  var MsgHtml = "<table cellPadding='0' cellSpacing='0' width='100%'>"
      + "<form name='NEWMSG' action='SaveMsgEnt.jsp' onSubmit='return Validate(this)' method='Get'>";

  if (Recepient == null)
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
      + "<input name='STORE' type='hidden' value='<%=sStore%>'>"
      + "<input name='STRNAME' type='hidden' value='<%=sThisStrName%>'>"
      + "<input name='MONBEG' type='hidden' value='<%=sMonth%>'>"
      + "<input name='WEEKEND' type='hidden' value='<%=sWeekend%>'>"
      + "<input name='APRVSTS' type='hidden'"
      + "<b>To:</b>&nbsp;<Select class='small' name='To'></Select>"

      if(StrAllowed=="ALL" || RegManager)
      {
        MsgHtml += "&nbsp;&nbsp;Approve: <input class='small' name='Approve' type='checkbox'"
        if(AprvSts == "*APPROVED"){ MsgHtml += "checked";}
        MsgHtml += " onclick='chgApprvSts(this)' >";
      }

      MsgHtml += "</td></tr>"
      + "<tr class='Grid1'><td>"
      + "&nbsp;&nbsp;<TextArea class='small' name='Text'  cols='80' rows='5'>"
      + "</TextArea>"
      + "</td></tr>"
      + "<tr class='Grid1' ><td>"
      + "<input class='small' name='Submit' type='Submit' value='Submit'>";

      if (Recepient == null)
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

    loadRecep(Recepient, Nick);
}

//
function loadRecep(Recepient, Nick)
{
  for(i=0; i < RecepList.length; i++)
  {
    document.forms[0].To.options[i] = new Option(RcpNickList[i], RecepList[i]);

    if(Recepient == RecepList[i])
    {
      document.forms[0].To.selectedIndex=i;
     }
  }
}

// close employee selection window
function hideMsgMenu(){
    document.all.MsgMenu.style.visibility="hidden"
}

function chgApprvSts(obj)
{
  if(obj.checked == true && AprvSts != "*APPROVED") document.forms[0].APRVSTS.value = "Y";
  else if(obj.checked == true && AprvSts == "*APPROVED") document.forms[0].APRVSTS.value = " ";
  else if(obj.checked == false && AprvSts == "*APPROVED") document.forms[0].APRVSTS.value = "N";
  else if(obj.checked == false && AprvSts != "*APPROVED") document.forms[0].APRVSTS.value = " ";
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

// validate entry parameters before submiting form
function Validate(form)
{
 var msg = " ";
 var error = false;
 var text = form.Text.value;
 var fnd = false;

 var rcp = form.To.options[form.To.selectedIndex].value;
 var snd = form.Sender.value;

 // sender and recepient cannot be equal
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
      <br>Message Board<br>
      Store Selected: <%=sStore + " - " + sThisStrName%>&nbsp;&nbsp;&nbsp;&nbsp;
      Weekend: <%=sWeekend%><br>
      <font color="blue">Approval Status:
      <%if(!sAprvSts.trim().equals("*POSTPONED")){%><font color="green"><%=sAprvSts%></font><%}
        else {%><font color="magenta"><%=sAprvSts%></font><%}%>

      <%if(!sAprvSts.startsWith("*NONE")){%>
         &#160;&#160;by: <%=sAprvSnd%>
         &#160;&#160;Date: <%=sAprvDat%>
         &#160;&#160;Time: <%=sAprvTim%>
      <%}%>
      </font></b>
      <div class="ovr">
        <br>Store: <SELECT name="STORE"></SELECT>&nbsp;&nbsp;&nbsp;
          Weekend: <SELECT name="WEEK"></SELECT>&nbsp;
          <button name="Go" onclick="javascript:newStrWkSel();">Go</button>
      </div>
      <p><a href="../"><font color="red">Home</font></a>&#62;
        <a href="StrScheduling.html"><font color="red">Payroll</font></a>&#62;
        <a href="ForumSum.jsp"><font color="red">Message Pending</font></a>&#62;
        This page;&nbsp;
        <a href="SchedbyWeek.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&MONBEG=<%=sMonth%>&WEEKEND=<%=sWeekend%>" target="_blank">
          <font color="red">Go to Schedule</font></a>

      <p align="Left"><a href="javascript: MsgEntryMenu(null, null)">New Message</a>

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
                            else if(sApprove[i].equals("Y")
                                 && sText[i].trim().indexOf("POSTPONED") < 0) out.print("DataTable2");
                            else if(sApprove[i].equals("Y")
                                 && sText[i].trim().indexOf("POSTPONED") >= 0) out.print("DataTable4");
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
                   <a href="SaveMsgEnt.jsp?STORE=<%=sStore%>&STRNAME=<%=sThisStrName%>&WEEKEND=<%=sWeekend%>&MONBEG=<%=sMonth%>&Sender=<%=sSender[i]%>&User=<%=sUser%>&To=<%=sRecepient[i]%>&ReferTo=<%=sReferTo[i]%>&DateStamp=<%=sDateStamp[i]%>&Cancel=<%=sAlwCancel[i]%>">
                      <%=sAlwCancel[i]%></a></td>
               </tr>
             <%}%>
       </table>

       </td>
    </tr>
  </table>

</body>
</html>

<%}%>