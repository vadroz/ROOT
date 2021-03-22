<%@ page import="aim.AmEvt, rciutility.StoreSelect"%>
<%
   String sEvtId = request.getParameter("id");

   String sStrAllowed = null;

   int iSpace = 6;

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=AimEvt.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();

      AmEvt evtinf = null;
      String sName = "";
      String sBegDt = "";
      String sExpDt = "";
      String sSts = "New";
      String sSngScr = "";
      String sPrizeLvl = "";
      String sFreq = "";
      String sRecUs = "";
      String sRecDt = "";
      String sRecTm = "";
      int iNumOfLvl = 0;
      String [] sEvtScrLvl = null;
      String sEvtScrLvlJsa = null;
      int iWeekday = 0;
      int iNumOfEvtStr = 0;
      String [] sEvtStr = null;
      String sEvtStrJsa = null;

      if( !sEvtId.equals("0") )
      {
         evtinf = new AmEvt(sEvtId, sUser);
         evtinf.setAmEvt();
         sEvtId = evtinf.getEvtId();
         sName = evtinf.getName();
         sBegDt = evtinf.getBegDt();
         sExpDt = evtinf.getExpDt();
         sSts = evtinf.getSts();
         sSngScr = evtinf.getSngScr();
         sPrizeLvl = evtinf.getPrizeLvl();
         sFreq = evtinf.getFreq();
         iWeekday = evtinf.getWeekday();
         sRecUs = evtinf.getRecUs();
         sRecDt = evtinf.getRecDt();
         sRecTm = evtinf.getRecTm();
         iNumOfLvl = evtinf.getNumOfLvl();
         sEvtScrLvl = evtinf.getEvtScrLvl();
         sEvtScrLvlJsa = evtinf.getEvtScrLvlJsa();
         iNumOfEvtStr = evtinf.getNumOfStr();
         sEvtStr = evtinf.getEvtStr();
         sEvtStrJsa = evtinf.getEvtStrJsa();
      }
      boolean bAlwApprove = session.getAttribute("AIMAPPRV") != null;

      StoreSelect strlst = new StoreSelect(5);
      int iNumOfStr = strlst.getNumOfStr();
      String [] sStr = strlst.getStrLst();
      String [] sStrName = strlst.getStrNameLst();

      String [] sStrLst = strlst.getStrLst();
      String sStrJsa = strlst.getStrNum();

      String [] sStrRegLst = strlst.getStrRegLst();
      String sStrRegJsa = strlst.getStrReg();

      String [] sStrDistLst = strlst.getStrDistLst();
      String sStrDistJsa = strlst.getStrDist();
      String [] sStrDistNmLst = strlst.getStrDistNmLst();
      String sStrDistNmJsa = strlst.getStrDistNm();

      String [] sStrMallLst = strlst.getStrMallLst();
      String sStrMallJsa = strlst.getStrMall();
%>
<html>
<head>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        th.DataTable { background:white;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#ccffcc;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { background:red;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable3 { background:#cccfff;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:white; font-family:Arial; font-size:12px }
        tr.DataTable1 { background:white; color:red; font-family:Arial; font-size:12px; font-wieght:bold; }
        tr.DataTable2 { background:#ccffcc; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:white; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left; vertical-align:middle}
        td.DataTable1 {padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top}
        td.DataTable1p {background:gray;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:top}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:right; vertical-align:top}

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150; background-color: white; z-index:10;
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

        .Small {font-size:10px;}
        <!--------------------------------------------------------------------->
</style>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var EvtId = "<%=sEvtId%>"
var EvtSts = "<%=sSts%>"
var EvtFreq = "<%=sFreq%>"
var EvtWkDy = "<%=iWeekday%>"
var EvtScrLvl = null;
<%if(iNumOfLvl > 0) {%>
EvtScrLvl = [<%=sEvtScrLvlJsa%>];
<%}%>

var EvtStr = null;
<%if(iNumOfEvtStr > 0) {%>
EvtStr = [<%=sEvtStrJsa%>];
<%}%>

var ArrStr = [<%=sStrJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   if(EvtId != "0")
   {
     setEvtFreq();  // set frequency
     rtvCommt(); // retreive comments
     setEvtStr();  // set stores
   }
   else
   {
      setDate("UP", document.all.BegDt);
      date = new Date(document.all.BegDt.value);
      date.setYear(date.getFullYear() + 1);
      document.all.ExpDt.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
   }
}
//==============================================================================
// set frequency for existed event
//==============================================================================
function setEvtFreq()
{
   var freq = document.all.Freq;
   document.all.trWkday.style.display = "none";
   for(var i=0; i < freq.length; i++)
   {
      if(freq[i].value == EvtFreq)
      {
         freq[i].checked = true;
         if(EvtFreq == "Weekly")
         {
            document.all.trWkday.style.display = "block";
            setWeekday();
         }
         break;
      }
   }
}
//==============================================================================
// set stores
//==============================================================================
function setEvtStr()
{
   var freq = document.all.Str;
   for(var i=0; i < Str.length; i++)
   {
      for(var j=0; j < EvtStr.length; j++)
      {
         if(freq[i].value == EvtStr[j]){ freq[i].checked = true; }
      }
   }
}
//==============================================================================
// set frequency for existed event
//==============================================================================
function setWeekday()
{
   var wkday = document.all.Wkday;
   wkday[EvtWkDy - 1].checked = true;
}
//==============================================================================
// retreive comments
//==============================================================================
function rtvCommt()
{
   var url = "AimLogLst.jsp?id=" + EvtId
           + "&grp=EVENT"
           + "&type=ALL"
   window.frame1.location.href=url;
}
//==============================================================================
// show comments
//==============================================================================
function showComments(html)
{
   document.all.tdCommtLst.innerHTML = html;
   window.frame1.document.body.innerHTML = "";
   window.frame1.document.close();
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function setDate(direction, obj)
{
  var date = new Date();
  if(obj.value.trim() != "") { date = new Date(obj.value); }

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  obj.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// validate entries
//==============================================================================
function Validate()
{
   var error=false;
   var msg="";
   var br = "";
   document.all.tdError.innerHTML="";

   var name = document.all.Name.value.trim();
   if(name == ""){ error=true; msg += br + "Please enter Name of Event"; br = "<br>";}

   var sts = "New";
   if(EvtId != 0){ sts = EvtSts; }

   var begdt = document.all.BegDt.value.trim();
   if(begdt == ""){ error=true; msg += br + "Please enter Beginning Date"; br = "<br>";}

   var expdt = document.all.ExpDt.value.trim();
   if(expdt == ""){ error=true; msg += br + "Please enter Expiration Date"; br = "<br>";}

   if(begdt != "" && expdt != "")
   {
      var bDt = new Date(begdt);
      var eDt = new Date(expdt);
      if(bDt > eDt ){ error=true; msg += br + "The Expiration Date is greater than Beginning Date"; br = "<br>";}
   }

   // get selected stores
   var scr = document.all.SngScr;
   var sngscr = new Array();
   var numscr = 0
   for(var i=0; i < scr.length; i++)
   {
     if(scr[i].value.trim())
     {
        if(isNaN(scr[i].value.trim())){ error=true; msg+= br + "Score must be positive numeric value.";  br = "<br>";}
        else if(eval(scr[i].value.trim()) < 0){ error=true; msg+= br + "Score must be positive numeric value.";  br = "<br>";}
        else
        {
           if(eval(scr[i].value.trim()) > 0){ sngscr[numscr] = scr[i].value.trim(); numscr++; }
        }
     }
   }
   if (numscr == 0){ error=true; msg+= br + "At least 1 score level must be selected.";}

   var freq = null;
   for(var i=0; i < document.all.Freq.length; i++)
   {
      if(document.all.Freq[i].checked){freq = document.all.Freq[i].value.trim(); break;}
   }
   if (freq == null){ error=true; msg+= br + "Please select Frequency."; br = "<br>";}

   var wkday = 0;
   if(freq == "Weekly")
   {
      for(var i=0; i < document.all.Wkday.length; i++)
      {
         if(document.all.Wkday[i].checked){wkday = document.all.Wkday[i].value.trim(); break;}
      }
      if (wkday == 0){ error=true; msg+= br + "Please select Weekday."; br = "<br>";}
   }

   var strbox = document.all.Str
   var str = new Array();
   var chkstr = false;
   for(var i=0, j=0; i < strbox.length; i++)
   {
      if(strbox[i].checked){ str[j] = strbox[i].value; chkstr = true; j++}
   }
   if(!chkstr){ msg += br + "Check at least 1 store."; error = true;  br = "<br>";}

   if(error){ document.all.tdError.innerHTML=msg;}
   else { sbmEvtInfo(name, sts, begdt, expdt, sngscr, freq, wkday, str);}
}
//==============================================================================
// submit entries
//==============================================================================
function sbmEvtInfo(name, sts, begdt, expdt, sngscr, freq, wkday, str)
{
    name = name.replace(/\n\r?/g, '<br />');
    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmEvt"

    var html = "<form name='frmAddUpdEvt'"
       + " METHOD=Post ACTION='AimEvtSv.jsp'>"
       + "<input name='id'>"
       + "<input name='name'>"
       + "<input name='sts'>"
       + "<input name='begdt'>"
       + "<input name='expdt'>"
       + "<input name='freq'>"
       + "<input name='wkday'>"
       + "<input name='action'>"

     for(var i=0; i < sngscr.length; i++) { html += "<input name='scrlvl' value='" + sngscr[i] + "'>" }
     for(var i=0; i < str.length; i++) { html += "<input name='str' value='" + str[i] + "'>" }

     html += "</form>"

     nwelem.innerHTML = html;
     window.frame1.document.appendChild(nwelem);

     window.frame1.document.all.id.value = EvtId;
     window.frame1.document.all.name.value=name;
     window.frame1.document.all.sts.value=sts;
     window.frame1.document.all.begdt.value=begdt;
     window.frame1.document.all.expdt.value=expdt;
     window.frame1.document.all.freq.value=freq;
     window.frame1.document.all.wkday.value=wkday;

   if(EvtId==0){ window.frame1.document.all.action.value="ADDEVT"; }
   else{ window.frame1.document.all.action.value="UPDEVT"; }

   window.frame1.document.frmAddUpdEvt.submit();
}
//==============================================================================
// set all store or unmark
//==============================================================================
function setAll(on)
{
   var str = document.all.Str;
   for(var i=0; i < str.length; i++) { str[i].checked = on; }
}
//==============================================================================
// check by regions
//==============================================================================
function checkReg(dist)
{
  var str = document.all.Str
  var chk1 = false;
  var chk2 = false;

  // check 1st selected group check status and save it
  var find = false;
  for(var i=0; i < str.length; i++)
  {
     for(var j=0; j < ArrStr.length; j++)
     {
        if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist
          || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
          || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
          || str[i].value == "68" || str[i].value == "86")))
        {
          chk1 = !str[i].checked;
          find = true;
          break;
        };
     }
     if (find){ break;}
  }
  chk2 = !chk1;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist
          || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
          || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
          || str[i].value == "68" || str[i].value == "86")))
        {
           str[i].checked = chk1;
        };
     }
  }
}

//==============================================================================
// check by districts
//==============================================================================
function checkDist(dist)
{
  var str = document.all.Str
  var chk1 = false;
  var chk2 = false;

  // check 1st selected group check status and save it
  var find = false;
  for(var i=0; i < str.length; i++)
  {
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrDist[j] == dist)
        {
          chk1 = !str[i].checked;
          find = true;
          break;
        };
     }
     if (find){ break;}
  }
  chk2 = !chk1;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrDist[j] == dist)
        {
           str[i].checked = chk1;
        };
     }
  }
}

//==============================================================================
// check mall
//==============================================================================
function checkMall(type)
{
  var str = document.all.Str
  var chk1 = true;
  var chk2 = false;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrMall[j] == type)
        {
           str[i].checked = chk1;
        };
     }
  }
}
//==============================================================================
// restart for new event
//==============================================================================
function restartNewEvt(id)
{
   var url = "AimEvt.jsp?id=" + id
   window.location.href=url;
}

//==============================================================================
// restart
//==============================================================================
function restart()
{
   window.location.reload();
}
//==============================================================================
// change event status
//==============================================================================
function chgSts()
{
   var hdr = "Change Status";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popChgSts()
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 150;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";

   var iSts = 0;
   <%if(bAlwApprove){%>
      if(EvtSts != "Active"){ document.all.Sts.options[iSts] = new Option("Active", "Active"); iSts++; }
   <%}%>
   if(EvtSts != "Postponed"){ document.all.Sts.options[iSts] = new Option("Postponed", "Postponed"); iSts++; }
   if(EvtSts != "Completed"){ document.all.Sts.options[iSts] = new Option("Completed", "Completed"); iSts++; }
   if(EvtSts != "Canceled"){ document.all.Sts.options[iSts] = new Option("Canceled", "Canceled"); iSts++; }
}
//==============================================================================
// populate delete employee panel
//==============================================================================
function popChgSts()
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable2'>"
         + "<td class='Prompt1' nowrap>"
           + "<select name='Sts' class='Small' ></select>"
         + "</td>"
       + "</tr>"
       + "<tr><td style='color:red;font-size:12px' id='tdErrSts' nowrap></td>"
       + "</tr>"

  panel += "<tr><td class='Prompt1' ><br><br>"
        + "<button onClick='sbmChgSts()' class='Small'>Change</button>"
        + "<button onClick='hidePanel();' class='Small'>Close</button>"
        + "</td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// submit status changes
//==============================================================================
function sbmChgSts()
{
   var sts = document.all.Sts.options[document.all.Sts.selectedIndex].value;
   var url = "AimEvtSv.jsp?id=" + EvtId
    + "&sts=" + sts
    + "&action=CHGEVTSTS"
   window.frame1.location.href = url;
}
//==============================================================================
// add comments
//==============================================================================
function addCommt()
{
   var hdr = "Add New Comments";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popAddComment()
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 50;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 80;
   document.all.dvItem.style.visibility = "visible";

   document.all.Comment.focus();
}
//==============================================================================
// populate delete employee panel
//==============================================================================
function popAddComment()
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable2'>"
         + "<td class='Prompt1' nowrap>"
           + "<textarea name='Comment' class='Small' cols=100 rows=5></textarea>"
         + "</td>"
       + "</tr>"
       + "<tr><td style='color:red;font-size:12px' id='tdErrCmt' nowrap></td>"
       + "</tr>"

  panel += "<tr><td class='Prompt1' ><br><br>"
        + "<button onClick='vldAddComment()' class='Small'>Add</button>"
        + "<button onClick='hidePanel();' class='Small'>Close</button>"
        + "</td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// validate new comments
//==============================================================================
function vldAddComment()
{
   var error= false;
   var msg = "";
   document.all.tdErrCmt.innerHTML="";

   var comment = document.all.Comment.value.trim();
   if(comment == ""){ error=true; msg += "Please enter comment"}

   if(error){ document.all.tdErrCmt.innerHTML=msg; }
   else { sbmAddComment(comment); }
}

//==============================================================================
// submit new comments
//==============================================================================
function sbmAddComment(comment)
{
    comment = comment.replace(/\n\r?/g, '<br />');
    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmEvt"

    var html = "<form name='frmAddUpdEvt'"
       + " METHOD=Post ACTION='AimEvtSv.jsp'>"
       + "<input name='id'>"
       + "<input name='comment'>"
       + "<input name='grp'>"
       + "<input name='type'>"
       + "<input name='action'>"
     html += "</form>"

   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.id.value = EvtId;
   window.frame1.document.all.comment.value=comment;
   window.frame1.document.all.grp.value="EVENT";
   window.frame1.document.all.type.value="USER";
   window.frame1.document.all.action.value="ADDCMT";

   window.frame1.document.frmAddUpdEvt.submit();
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.style.visibility = "hidden";
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>AIM Event Information
        </b>
      </td>
     </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="AimEvtLstSel.jsp"><font color="red" size="-1">Select Orders</font></a>&#62;
      <font size="-1">This Page</font> &nbsp; &nbsp; &nbsp; &nbsp;
      <br>&nbsp;
      <br>

  <!----------------------- Order List ------------------------------>
     <table border=0 cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">

      <!----------------------- Order List ------------------------>
     <tr class="DataTable">
       <td class="DataTable">Event ID: <b><%=sEvtId%></b></td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Status: <b>
         <%if(sEvtId.equals("0")){%>New<%}
         else{%>
            <%=sSts%> &nbsp; <a href="javascript: chgSts()">Change Status</a>
         <%}%>
         </b>
       </td>
     </tr>
     <tr class="DataTable">
       <td class="DataTable" colspan=3>Name:
          <input name="Name" size=50 maxlength=50 value="<%=sName%>">
       </td>
     </tr>

     <!-- ====== Beginning/Expired Date ======== -->
     <tr class="DataTable">
       <td class="DataTable">Beginning Date:
           <button class="Small" name="Down" onClick="setDate('DOWN', document.all.BegDt)">&#60;</button>
           <input class="Small" type="text" name="BegDt" readonly size=10 maxlength=10 value="<%=sBegDt%>">
           <button class="Small" name="Up" onClick="setDate('UP', document.all.BegDt)">&#62;</button> &nbsp;&nbsp;
           <a class="Small" id="shwCal" href="javascript:showCalendar(1, null, null, 600, 100, document.all.BegDt, null, null)" >
           <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
       </td>
       <th class="DataTable">&nbsp;</th>
       <td class="DataTable">Expired Date:
           <button class="Small" name="Down" onClick="setDate('DOWN', document.all.ExpDt)">&#60;</button>
           <input class="Small" type="text" name="ExpDt" readonly size=10 maxlength=10 value="<%=sExpDt%>">
           <button class="Small" name="Up" onClick="setDate('UP', document.all.ExpDt)">&#62;</button> &nbsp;&nbsp;
           <a class="Small" id="shwCal" href="javascript:showCalendar(1, null, null, 800, 100, document.all.ExpDt, null, null)" >
           <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
       </td>
     </tr>

     <!-- ====== Scores/Prize ========== -->
     <tr class="DataTable">
       <td class="DataTable" colspan=3>
         <table border=0>
         <tr class="DataTable">
            <td class="DataTable" rowspan=3>Score Levels:</td>
            <td  class="DataTable">Volunteer</td>
            <td class="DataTable">Participate</td>
         <tr>
         <tr class="DataTable">
         <%for(int i=0; i < 2; i++) {%>
            <td class="DataTable">
            <input name="SngScr" size=5 maxlength=5 <%if(i < iNumOfLvl){%>value="<%=sEvtScrLvl[i]%>"<%}%>>
            </td>
         <%}%>
         <tr>
         </table>
       </td>
     </tr>

     <!-- ====== Frequency ========== -->
     <tr class="DataTable">
       <td class="DataTable" colspan=3>Frequency:
         <input type="radio" name="Freq" onClick="document.all.trWkday.style.display='none';" value="Daily">Daily &nbsp; &nbsp;
         <input type="radio" name="Freq" onClick="document.all.trWkday.style.display='block';" value="Weekly">Weekly &nbsp; &nbsp;
         <input type="radio" name="Freq" onClick="document.all.trWkday.style.display='none';" value="Monthly">Monthly &nbsp; &nbsp;
         <input type="radio" name="Freq" onClick="document.all.trWkday.style.display='none';" value="Yearly">Yearly &nbsp; &nbsp;
       </td>
     </tr>
     <!-- ====== Week Day ========== -->
     <tr class="DataTable" style="display:none;" id="trWkday">
       <td class="DataTable" colspan=3>Weekday:
         <input type="radio" name="Wkday" value="1">Mon &nbsp; &nbsp;
         <input type="radio" name="Wkday" value="2">Tue &nbsp; &nbsp;
         <input type="radio" name="Wkday" value="3">Wed &nbsp; &nbsp;
         <input type="radio" name="Wkday" value="4">Thu &nbsp; &nbsp;
         <input type="radio" name="Wkday" value="5">Fri &nbsp; &nbsp;
         <input type="radio" name="Wkday" value="6">Sat &nbsp; &nbsp;
         <input type="radio" name="Wkday" value="7">Sun &nbsp; &nbsp;
       </td>
     </tr>


     <!-- ====== Week Day ========== -->
     <tr class="DataTable" style="display:block;" id="trStore">
       <td class="DataTable" colspan=3 nowrap><br>Store(s):
          <input name="Str" type="checkbox" value="0">Home Office
          <%for(int i=0; i < iNumOfStr; i++){%>
                  <input name="Str" type="checkbox" value="<%=sStr[i]%>"><%=sStr[i]%>&nbsp;
                  <%if(i == 13 || i > 15 && i % 15 == 0){%><br><%}%>
              <%}%>
              <br><button class="Small" onClick="setAll(true)">All Store</button> &nbsp;

              <button onclick='checkReg(&#34;1&#34;)' class='Small'>Dist 1</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;2&#34;)' class='Small'>Dist 2</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;3&#34;)' class='Small'>Dist 3</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;99&#34;)' class='Small'>Dist 99</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;PATIO&#34;)' class='Small'>Patio</button> &nbsp; &nbsp;
              <br>
              <button onclick='checkDist(&#34;9&#34;)' class='Small'>Houston</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;20&#34;)' class='Small'>Dallas/FtW</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;35&#34;)' class='Small'>Ski Chalet</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;38&#34;)' class='Small'>Boston</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;41&#34;)' class='Small'>Okla</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;52&#34;)' class='Small'>Charl</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;53&#34;)' class='Small'>Nash</button> &nbsp; &nbsp;
              <br>
              <button onclick='checkMall(&#34;&#34;)' class='Small'>Mall</button> &nbsp; &nbsp;
              <button onclick='checkMall(&#34;NOT&#34;)' class='Small'>Non-Mall</button> &nbsp; &nbsp;

              <button class="Small" onClick="setAll(false)">Reset</button><br><br>
        </td>
     </tr>
     <!-- ====== Error ========== -->
     <tr class="DataTable1">
       <td class="DataTable" id="tdError" colspan=3></td>
     </tr>
    </table>
    <button onclick="Validate()">Submit</button>
      <!----------------------- end of table ------------------------>
     </td>
   </tr>
   <%if( !sEvtId.equals("0") ){%>
     <tr>
        <td ALIGN="left" VALIGN="TOP" nowrap><a href="javascript: addCommt()">Add Comment</a></td>
     </tr>
   <%}%>
   <tr>
      <td ALIGN="left" VALIGN="TOP" id="tdCommtLst" nowrap></td>
   </tr>
  <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%}%>