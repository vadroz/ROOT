<%@ page import="aim.AmCouponLst"%>
<%
   String [] sSelSts = request.getParameterValues("Sts");
   String sFrDate = request.getParameter("From");
   String sToDate = request.getParameter("To");
   String sSort = request.getParameter("Sort");

   if (sSort == null) { sSort = "NAME"; }
   if(sSelSts == null){ sSelSts = new String[]{"Active"}; }
   if (sFrDate == null) { sFrDate = "01/01/0001"; }
   if (sToDate == null) { sToDate = "12/31/2999"; }

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=AimCouponLst.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();

      AmCouponLst evtlst = new AmCouponLst(sSelSts, sFrDate, sToDate, sSort, sUser);

      String sSelStsJsa = evtlst.cvtToJavaScriptArray(sSelSts);
%>

<html>
<head>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { background:#ccffcc;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable2 { background:red;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable3 { background:#cccfff;padding-top:3px; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#efefef; font-family:Arial; font-size:10px }
        tr.DataTable2 { background:#ccffcc; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left; vertical-align:top}
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
var SelSts = [<%=sSelStsJsa%>];
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
// resort report
//==============================================================================
function resort(sort)
{
   var url = "AmEvtLst.jsp?"

   for(var i=0; i < SelSts.length; i++)  { url += "&Sts=" + SelSts[i] }

   url += "&From=<%=sFrDate%>"
   url += "&To=<%=sToDate%>"
   url += "&Sort=" + sort

   //alert(url)
   window.location.href = url;
}

//==============================================================================
// get comments
//==============================================================================
function getComments(str, ord)
{
   var url = "SpecOrdCommt.jsp?Store=" + str + "&Order=" + ord

   //alert(url)
   window.frame1.location.href = url;
}

//==============================================================================
// show comments
//==============================================================================
function showComments(str, ord, type, commt, cmtUser, cmtDate, cmtTime)
{
   var hdr = "Store &nbsp;" + str + ", Order " + ord;

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popComment(type, commt, cmtUser, cmtDate, cmtTime)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.width = 800;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 10;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 80;
   document.all.dvItem.style.visibility = "visible";

}
//==============================================================================
// populate comments panel
//==============================================================================
function popComment(type, commt, cmtUser, cmtDate, cmtTime)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable2'>"
         + "<td class='Prompt1' rowspan=2 width='5%'>Type</td>"
         + "<td class='Prompt1' rowspan=2 >Comments</td>"
         + "<td class='Prompt1' colspan=3 width='10%'>Created</td>"
       + "</tr>"
       + "<tr class='DataTable2'>"
         + "<td class='Prompt1'>User</td>"
         + "<td class='Prompt1'>Date</td>"
         + "<td class='Prompt1'>Time</td>"
       + "</tr>"

  for(var i=0; i < commt.length; i++)
  {
    panel += "<tr class='Prompt'>"
          + "<td class='Prompt1'>" + type[i] + "</td>"
          + "<td class='Prompt'>" + commt[i] + "</td>"
          + "<td class='Prompt1' nowrap>" + cmtUser[i] + "</td>"
          + "<td class='Prompt1' nowrap>" + cmtDate[i] + "</td>"
          + "<td class='Prompt1' nowrap>" + cmtTime[i] + "</td>"
       + "</tr>"
  }

  panel += "<tr><td class='Prompt1' colspan='5'><br><br>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// add new coupon
//==============================================================================
function chgCoupon(cpn, name, begdt, expdt, sts, scr, action)
{
   var hdr = null;
   if(action=="ADDCPN"){ hdr = "Add Coupon" }
   else { hdr = "Update Coupon"; }

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popChgCoupon(action)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";
   document.all.Coupon.focus();

   setDate("UP", document.all.BegDt);
   date = new Date(new Date() - -86400000 * 365);
   document.all.ExpDt.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();

   document.all.Sts.options[0] = new Option("Active", "Active");
   document.all.Sts.options[1] = new Option("Postponed", "Postponed");
   document.all.Sts.options[2] = new Option("Cancel", "Cancel");

   if(action=="ADDCPN"){ document.all.Score.value = "10"; }
   else
   {
      document.all.Coupon.value = cpn;
      document.all.Name.value = name;
      document.all.BegDt.value = begdt;
      document.all.ExpDt.value = expdt;
      document.all.Score.value = scr;
      for(var i=0; i < document.all.Sts.length;i++)
      {
         if(document.all.Sts.options[i] == sts){ document.all.Sts.selectedIndex = i; break; }
      }
   }
}
//==============================================================================
// populate comments panel
//==============================================================================
function popChgCoupon(action)
{
  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable2'>"
         + "<td class='Prompt1' nowrap>Coupon Number</td>"
         + "<td class='Prompt' nowrap><input name='Coupon' size=10 maxlength=10></td>"
       + "</tr>"
       + "<tr class='DataTable2'>"
         + "<td class='Prompt1' nowrap>Name</td>"
         + "<td class='Prompt' nowrap><input name='Name' size=50 maxlength=50></td>"
       + "</tr>"
       + "<tr class='DataTable2'>"
         + "<td class='Prompt1' nowrap>Status</td>"
         + "<td class='Prompt' nowrap><select name='Sts'></select></td>"
       + "</tr>"
       + "<tr class='DataTable2'>"
         + "<td class='Prompt1' nowrap>Beginning Date</td>"
         + "<td  class='Prompt' nowrap>"
           + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, document.all.BegDt)'>&#60;</button>"
           + "<input class='Small' name='BegDt' type='text' size=10 maxlength=10 readonly>&nbsp;"
           + "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, document.all.BegDt)'>&#62;</button>"
           + "&nbsp;&nbsp;&nbsp;"
           + "<a href='javascript:showCalendar(1, null, null, 750, 100, document.all.BegDt)' >"
           + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>"
        + "</td>"
      + "</tr>"

      + "<tr class='DataTable2'>"
         + "<td class='Prompt1' nowrap>Expiration Date</td>"
         + "<td  class='Prompt' nowrap>"
           + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, document.all.ExpDt)'>&#60;</button>"
           + "<input class='Small' name='ExpDt' type='text' size=10 maxlength=10 readonly>&nbsp;"
           + "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, document.all.ExpDt)'>&#62;</button>"
           + "&nbsp;&nbsp;&nbsp;"
           + "<a href='javascript:showCalendar(1, null, null, 750, 200, document.all.ExpDt)' >"
           + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a><br>"
         + "</td>"
       + "</tr>"
       + "<tr class='DataTable2'>"
         + "<td class='Prompt1' nowrap>Required Score</td>"
         + "<td class='Prompt' nowrap><input name='Score' size=5 maxlength=5></td>"
       + "</tr>"
       + "<tr class='DataTable2'>"
         + "<td style='color:red; font-size:12px;' id='tdError' nowrap colspan=2></td>"
       + "</tr>"

  panel += "<tr><td class='Prompt1' colspan='5'>"
          + "<button onClick='vldCpn(&#34;" + action + "&#34;);' class='Small'>Add</button>"
          + "<button onClick='hidePanel();' class='Small'>Close</button>"
        + "</td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
// validate new coupon
//==============================================================================
function vldCpn(action)
{
   var error = false;
   var msg = "";

   var cpn = document.all.Coupon.value.trim();
   var br = "";
   if(isNaN(cpn)){ error=true; msg += br + "The Coupon is not numeric "; br = "<br>";}
   else if(eval(cpn) <= 0){ error=true; msg += br + "The Coupon must be positive number"; br = "<br>";}

   var name = document.all.Name.value.trim();
   if(name == ""){ error=true; msg += br + "Please enter the coupon Name"; br = "<br>";}

   var stsobj = document.all.Sts;
   var sts = document.all.Sts.options[document.all.Sts.selectedIndex].value;

   var begdt = document.all.BegDt.value.trim();
   var expdt = document.all.ExpDt.value.trim();

   var score = document.all.Score.value.trim();
   if(isNaN(score)){ error=true; msg += br + "Scores are not numeric "; br = "<br>";}
   else if(eval(score) <= 0){ error=true; msg += br + "Scores must be positive number"; br = "<br>";}

   if(error){ document.all.tdError.innerHTML=msg; }
   else { sbmCpn(cpn, name, sts, begdt, expdt, score, action); }
}
//==============================================================================
// submit new coupon
//==============================================================================
function sbmCpn( cpn, name, sts, begdt, expdt, score, action )
{
    name = name.replace(/\n\r?/g, '<br />');
    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSubmit"

    var html = "<form name='frmAddUpdCpn'"
       + " METHOD=Post ACTION='AimEvtSv.jsp'>"
       + "<input name='coupon'>"
       + "<input name='name'>"
       + "<input name='sts'>"
       + "<input name='begdt'>"
       + "<input name='expdt'>"
       + "<input name='sngscr'>"
       + "<input name='action'>"

    html += "</form>"

    nwelem.innerHTML = html;
    window.frame1.document.appendChild(nwelem);

    window.frame1.document.all.coupon.value = cpn;
    window.frame1.document.all.name.value=name;
    window.frame1.document.all.sts.value=sts;
    window.frame1.document.all.begdt.value=begdt;
    window.frame1.document.all.expdt.value=expdt;
    window.frame1.document.all.sngscr.value=score;
    window.frame1.document.all.action.value=action;

    window.frame1.document.frmAddUpdCpn.submit();
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.style.visibility = "hidden";
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
// restart
//==============================================================================
function restart()
{
   window.location.reload();
}
//==============================================================================
// show errors
//==============================================================================
function showError(err)
{
   var br = "";
   for(var i=0; i < err.length; i++)
   {
     document.all.tdError.innerHTML= br + err[i];
     br = "<br>"
   }
}

</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="200" width="100%"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>AIM Coupon List
        </b>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
      <a href="AimEvtLstSel.jsp"><font color="red" size="-1">Select Orders</font></a>&#62;
      <font size="-1">This Page</font> &nbsp; &nbsp; &nbsp; &nbsp;

      <a href="javascript: chgCoupon(null, null, null, null, null, null,'ADDCPN')">Add Coupon</a>
  <!----------------------- Order List ------------------------------>
     <table border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable">
         <th class="DataTable"><a href="javascript: resort('STR')">Evt<br>ID</a></th>
         <th class="DataTable"><a href="javascript: resort('NAME')">Event Name</a></th>
         <th class="DataTable" rowspan=2><a href="javascript: resort('BEGDT')">Beginning<br>Date</a></th>
         <th class="DataTable" rowspan=2><a href="javascript: resort('EXPDT')">Expiration<br>Date</a></th>
         <th class="DataTable" rowspan=2><a href="javascript: resort('STS')">Status</a></th>
         <th class="DataTable" rowspan=2><a href="javascript: resort('SNGSCR')">Required<br>Scores</a></th>
         <th class="DataTable" rowspan=2>Last<br>Time Updated</th>
      <TBODY>

      <!----------------------- Order List ------------------------>
 <%
    while( evtlst.getNext() )
    {
      evtlst.setAmCouponLst();
      String sCoupon = evtlst.getCoupon();
      String sName = evtlst.getName();
      String sBegDt = evtlst.getBegDt();
      String sExpDt = evtlst.getExpDt();
      String sSts = evtlst.getSts();
      String sSngScr = evtlst.getSngScr();
      String sRecUs = evtlst.getRecUs();
      String sRecDt = evtlst.getRecDt();
      String sRecTm = evtlst.getRecTm();
      String sComa = "";
  %>
     <tr class="DataTable1">
       <td class="DataTable2"><a href="javascript: chgCoupon('<%=sCoupon%>', '<%=sName%>', '<%=sBegDt%>', '<%=sExpDt%>', '<%=sSts%>', '<%=sSngScr%>', 'UPDCPN')"><%=sCoupon%></a></td>
       <td class="DataTable" nowrap><%=sName%></td>
       <td class="DataTable"><%=sBegDt%></td>
       <td class="DataTable"><%=sExpDt%></td>
       <td class="DataTable2"><%=sSts%></td>
       <td class="DataTable2"><%=sSngScr%></td>
       <td class="DataTable" nowrap><%=sRecUs%> <%=sRecDt%> <%=sRecTm%></td>
       </tr>
  <%}%>

      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>
  <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%
    evtlst.disconnect();
    evtlst = null;
%>
<%}%>