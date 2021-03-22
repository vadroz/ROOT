<%@ page import="java.text.*, java.util.*, menu.CompMsgBoardMaint"%>
<%
      CompMsgBoardMaint msgblst = new CompMsgBoardMaint();
      String [] sMbCol = msgblst.getMbCol();
      Vector vMsgBoard = msgblst.getMsgBoard();

      String [] sAmCol = msgblst.getAmCol();
      Vector vAlarm = msgblst.getAlarm();

      Iterator it = null;
%>
<HTML>
<HEAD>
<title>RCI Message Board</title>
<META content="RCI, Inc." name="RCI_Message_Board">
</HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { padding-right:3px; padding-left:3px; padding-top:3px; padding-bottom:3px; text-align:left; font-family:Verdanda; font-size:12px }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; text-align:right; font-family:Verdanda; font-size:12px; font-weight:bold; }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:12px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:12px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:12px; }
        .small { font-size:10px; }
</style>


<script name="javascript1.2">
var MbName = new Array();
var MbText = new Array();
var MbFont = new Array();
var MbColor = new Array();
var MbBgClr = new Array();
var NumOfMB = 0;

var MaStrNm = new Array();
var MaStpNm = new Array();
var MaStrTxt = new Array();
var MaStpTxt = new Array();
var MaMsgDa = new Array();
var MaMsgTi = new Array();
var MaStrTm = new Array();
var MaStpTm = new Array();

var NumOfAM = 0;

var ColorArr = new Array();
ColorArr = ["red", "blue"]
//==============================================================================
// on loading
//==============================================================================
function bodyload()
{
  setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
  setClrArr();
}
//==============================================================================
// set color array
//==============================================================================
function setClrArr()
{
   var r=255, g=255, b=255;
   var iMax = 255 / 50;
   var iclr = 0;
   for(var i=0; i < iMax;i++)
   {
     if(r < 50) {r = 0;}
     g = 255;
     for(var j=0; j < iMax;j++)
     {
        if(g < 50) {g = 0;}
        b= 255
        for(var k=0; k < iMax;k++)
        {
           if(b < 50) {b = 0;}
           ColorArr[iclr++] = "#" + RGBtoHex(r,g,b);
           b = b - 50;
        }
        g = g - 50;
     }
     r = r - 50;
   }
   //alert(ColorArr)
}
//==============================================================================
// convert RGB to hex
//==============================================================================
function RGBtoHex(R,G,B) {return toHex(R)+toHex(G)+toHex(B)}
//==============================================================================
// to hex
//==============================================================================
function toHex(N)
{
 if (N==null) return "00";
 N=parseInt(N); if (N==0 || isNaN(N)) return "00";
 N=Math.max(0,N); N=Math.min(N,255); N=Math.round(N);
 return "0123456789ABCDEF".charAt((N-N%16)/16)
      + "0123456789ABCDEF".charAt(N%16);
}

//==============================================================================
// show message board detail record
//==============================================================================
function showMbDtl(action, arg)
{
   var hdr = "";
   if(action=="ADD"){ hdr = "Add Meassage"; }
   else if(action=="UPD"){ hdr = "Update: " + MbName[arg]; }
   else if(action=="DLT"){ hdr = "Delete: " + MbName[arg]; }

   var html = "<form name='frmMsgBrd' method='GET' action='CompMsgBoardSv.jsp'>"
     + "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
     + "<tr><td class='Prompt' colspan=2>"
        + popMBDtl(action, arg)
     + "</td></tr>"
    + "</table>"
   + "</form>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";

   // populate panel
   if(action != "ADD")
   {
      document.all.MbName.value = MbName[arg];
      document.all.MbText.value = MbText[arg];
      document.all.MbFont.value = MbFont[arg];
      document.all.MbColor.value = MbColor[arg];
      document.all.MbBgClr.value = MbBgClr[arg];
   }
   if(action != "DLT")
   {
      setSelClr();
      setSelBgClr();
   }
   if(action == "DLT")
   {
     document.all.MbName.readOnly = true;
     document.all.MbText.readOnly = true;
     document.all.MbFont.readOnly = true;
     document.all.MbColor.readOnly = true;
     document.all.MbBgClr.readOnly = true;
   }
   document.all.Action.value = action;
}
//==============================================================================
// populate message board detail panel
//==============================================================================
function popMBDtl(action, arg)
{
    var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"

    panel += "<tr><td class='Prompt' >Name:</td><td class='Prompt' ><input class='small' name='MbName'></td></tr>"
    panel += "<tr><td class='Prompt' >Text:</td><td class='Prompt' ><input class='small' name='MbText' size=50></td></tr>"
    panel += "<tr><td class='Prompt' >Font Size:</td><td class='Prompt' ><input class=' small' name='MbFont'></td></tr>"
    panel += "<tr><td class='Prompt' >Color:</td>"
        + "<td class='Prompt' ><input class='small' name='MbColor'>"
        + " &nbsp; <select name='selColor' class='small' onChange='chgSelColor(this)'></select></td></tr>"
    panel += "<tr><td class='Prompt' nowrap>Background Color:</td>"
        + "<td class='Prompt' ><input class='small' name='MbBgClr'>"
        + " &nbsp; <select name='selBgClr' class='small' onChange='chgSelBgClr(this)'></select></td></tr>"

    panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
        + "<input name='Action' type=hidden>"
        + "<button onClick='validateMBUpd()' "
        + "class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

     panel += "</table>";
     return panel;
}
//==============================================================================
// set color selection menu
//==============================================================================
function setSelClr()
{
   document.all.selColor.options[0] = new Option("--- Select color ---", "NOT SELECTED")
   for(var i=0; i < ColorArr.length;i++)
   {
     document.all.selColor.options[i+1] = new Option(ColorArr[i], ColorArr[i])
     document.all.selColor.options[i+1].style.backgroundColor = ColorArr[i];
   }
}
//==============================================================================
// set background color selection menu
//==============================================================================
function setSelBgClr()
{
   document.all.selBgClr.options[0] = new Option("--- Select color ---", "NOT SELECTED")
   for(var i=0; i < ColorArr.length;i++)
   {
     document.all.selBgClr.options[i+1] = new Option(ColorArr[i], ColorArr[i])
     document.all.selBgClr.options[i+1].style.backgroundColor = ColorArr[i];
   }
}
//==============================================================================
// populate color field when change is made on menu
//==============================================================================
function chgSelColor(menu)
{
   document.all.MbColor.value = menu.options[menu.selectedIndex].value;
}
//==============================================================================
// populate background color field when change is made on menu
//==============================================================================
function chgSelBgClr(menu)
{
   document.all.MbBgClr.value = menu.options[menu.selectedIndex].value;
}
//==============================================================================
// validate message board entries
//==============================================================================
function validateMBUpd()
{
   var error = false;
   var msg = "";
   var name = document.all.MbName.value.trim();
   var text = document.all.MbText.value.trim();
   var font = document.all.MbFont.value.trim();
   var color = document.all.MbColor.value.trim();
   var bgclr = document.all.MbBgClr.value.trim();

   if(name==""){ error = true; msg += "Please enter message name"; }
   if(text==""){ error = true; msg += "\nPlease enter message text"; }
   if(font==""){ error = true; msg += "\nPlease enter message font size"; }
   if(isNaN(font) || eval(font) <= 0){ error = true; msg += "\nFont size is invalid"; }
   if(color==""){ error = true; msg += "\nPlease enter text color"; }
   if(bgclr==""){ error = true; msg += "\nPlease enter text background color"; }

   if(error){ alert(msg); }
   else { sbmMBUpd(); }
}
//==============================================================================
// submit message board updated
//==============================================================================
function sbmMBUpd()
{
   document.frmMsgBrd.submit();
}

//==============================================================================
// start alarm
//==============================================================================
function startAlarm(action, arg)
{
   var hdr = "";
   if(action=="ADDALARM"){ hdr = "Add Alarm"; }
   else if(action=="UPDALARM"){ hdr = "Update Alarm "; }
   else if(action=="DLTALARM"){ hdr = "Delete Alarm"; }

   var html = "<form name='frmAlarm' method='GET' action='CompMsgBoardSv.jsp'>"
     + "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
     + "<tr><td class='Prompt' colspan=2>"
        + popAlarm(action, arg)
     + "</td></tr>"
    + "</table>"
   + "</form>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvItem.style.visibility = "visible";

   // populate panel
   if(action == "ADDALARM")
   {
      document.all.selStrMsg.options[0] = new Option("--- Select Message ---", "NOT_SELECTED");
      document.all.selStpMsg.options[0] = new Option("--- Select Message ---", "NOT_SELECTED");
      for(var i=0; i < MbName.length; i++)
      {
         document.all.selStrMsg.options[i+1] = new Option(MbName[i], MbName[i]);
         document.all.selStpMsg.options[i+1] = new Option(MbName[i], MbName[i]);
      }
      document.all.MaMsgDa.value = "";
      document.all.MaMsgTi.value = "";
      document.all.MaStrTm.value = "10";
      document.all.MaStpTm.value = "5";
   }
   else if(action == "UPDALARM" || action == "DLTALARM")
   {
      document.all.selStrMsg.style.display="none";
      document.all.selStpMsg.style.display="none";
      document.all.MaStrNm.value = MaStrNm[arg];
      document.all.MaStpNm.value = MaStpNm[arg];
      document.all.MaMsgDa.value = MaMsgDa[arg];
      document.all.MaMsgTi.value = MaMsgTi[arg];
      document.all.MaStrTm.value = MaStrTm[arg];
      document.all.MaStpTm.value = MaStpTm[arg];

      document.all.MaStrNm.readOnly = true;
      document.all.MaStpNm.readOnly = true;
      document.all.MaMsgDa.readOnly = true;
      document.all.MaMsgTi.readOnly = true;

   }
   document.all.Action.value = action;
}
//==============================================================================
// populate message board detail panel
//==============================================================================
function popAlarm(action, arg)
{
    var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"

    panel += "<tr><td class='Prompt' nowrap>Start Message Name: </td>"
       + "<td class='Prompt' nowrap><input class='small' name='MaStrNm' readonly>"
          + " &nbsp; <select name='selStrMsg' class='small' onchange='chgSelMsg(this, &#34;MaStrNm&#34;)'></select></td></tr>"
    panel += "<tr><td class='Prompt' nowrap>Stop Message Name: </td>"
          + "<td class='Prompt'  nowrap><input class='small' name='MaStpNm' readonly>"
       + " &nbsp; <select name='selStpMsg' class='small' onchange='chgSelMsg(this, &#34;MaStpNm&#34;)'></select></td></tr>"
    panel += "<tr><td class='Prompt' nowrap>Message Date (MM/DD/YYYY): </td>"
       + "<td class='Prompt'  nowrap><input class=' small' name='MaMsgDa'> leave blank for current date </td></tr>"
    panel += "<tr><td class='Prompt' nowrap>Message Time (HH:MM:SS): </td>"
       + "<td class='Prompt'  nowrap><input class=' small' name='MaMsgTi'> leave blank for current time </td></tr>"
    panel += "<tr><td class='Prompt' nowrap>Start Message Duration: </td>"
       + "<td class='Prompt' nowrap><input class=' small' name='MaStrTm'> min.</td></tr>"
    panel += "<tr><td class='Prompt' nowrap>Stop Message Duration: </td>"
       + "<td class='Prompt' nowrap><input class=' small' name='MaStpTm'> min.</td></tr>"

    panel += "<tr><td class='Prompt1' colspan='3'><br><br>"
        + "<input name='Action' type=hidden>"
        + "<button onClick='validateAlarm()' "
        + "class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

     panel += "</table>";
     return panel;
}
//==============================================================================
// get message name selection
//==============================================================================
function chgSelMsg(menu, fldnm)
{
    if(menu.options[menu.selectedIndex].value != "NOT_SELECTED")
    document.all[fldnm].value = menu.options[menu.selectedIndex].value;
}
//==============================================================================
// validate message board entries
//==============================================================================
function validateAlarm()
{
   var error = false;
   var msg = "";

   var strnm = document.all.MaStrNm.value.trim();
   var stpnm = document.all.MaStpNm.value.trim();
   var strdur= document.all.MaStrTm.value.trim();
   var stpdur= document.all.MaStrTm.value.trim();

   if(stpnm==""){ stpdur=0; document.all.MaStpTm.value = 0;}

   if(strnm==""){ error = true; msg += "Please enter start message name"; }
   if(strdur==""){ error = true; msg += "Please enter start message duration"; }
   if(stpnm!="" && stpdur==""){ error = true; msg += "Please enter stop message duration"; }
   if(isNaN(strdur) || eval(strdur) < 0 ){ error = true; msg += "Start message duration must be a positive number"; }
   if(stpnm!="" &&  (isNaN(stpdur) || eval(stpdur) < 0)){ error = true; msg += "Stop message duration must be 0 or positive"; }

   if(error){ alert(msg); }
   else { sbmAlarm(); }
}
//==============================================================================
// activate stop Alarm Message
//==============================================================================
function actStopAlarm(arg)
{
  var html = "<form name='frmAlarm' method='GET' action='CompMsgBoardSv.jsp'>"
   html += "<input class='small' name='MaStrNm'>"
   html += "<input class='small' name='MaStpNm'>"
   html += "<input class=' small' name='MaMsgDa'>"
   html += "<input class=' small' name='MaMsgTi'>"
   html += "<input class=' small' name='MaStrTm'>"
   html += "<input class=' small' name='MaStpTm'>"
   html += "<input name='Action' type=hidden>"
   html += "</form>"

   document.all.dvItem.innerHTML = html;
   document.all.MaStrNm.value = MaStrNm[arg];
   document.all.MaStpNm.value = MaStpNm[arg];
   document.all.MaMsgDa.value = MaMsgDa[arg];
   document.all.MaMsgTi.value = MaMsgTi[arg];
   document.all.MaStrTm.value = "0";
   document.all.MaStpTm.value = MaStpTm[arg];
   document.all.Action.value = "ACTSTOPALARM";

   sbmAlarm();
}
//==============================================================================
// submit message board updated
//==============================================================================
function sbmAlarm()
{
   document.frmAlarm.submit();
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

<BODY onload="bodyload()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

<TABLE width="100%" border=0>
  <TBODY>
  <TR>
    <TD vAlign=top align=middle colspan=4><B>Retail Concepts Inc.
        <BR>Message Board Maintenance
        </B><br>
        <a href="../"><font color="red">Home</font></a>
  <TR>
    <TD vAlign=top align=middle>
      <a href="javascript:startAlarm('ADDALARM', null)">Start Alarm</a>
      <!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSaS">
         <tr><th colspan=10>Alarm List</th></tr>
         <tr class="DataTable">
           <%for(int i=0; i < sAmCol.length; i++){%>
              <th class="DataTable"><%=sAmCol[i]%></th>
           <%}%>
             <th class="DataTable">Activate<br>Stop<br>Msg</th>
             <th class="DataTable">Upd</th>
             <th class="DataTable">Dlt</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <% int iNumOfAM = 0;
         it = vAlarm.iterator();
         while(it.hasNext()){
            String [] sData = (String []) it.next();
       %>
          <tr class="DataTable">
            <%for(int i=0; i < sAmCol.length; i++){%>
               <td class="DataTable"><%if(sData[i] != null && !sData[i].trim().equals("")){%><%=sData[i]%><%} else{%>&nbsp;<%}%></td>
            <%}%>
            <td class="DataTable"><a href="javascript:actStopAlarm('<%=iNumOfAM%>')">Stop</a></td>
            <td class="DataTable"><a href="javascript:startAlarm('UPDALARM', '<%=iNumOfAM%>')">Upd</a></td>
            <td class="DataTable"><a href="javascript:startAlarm('DLTALARM', '<%=iNumOfAM%>')">Dlt</a></td>
            <script name="javascript1.2">
                  MaStrNm[NumOfAM] = "<%=sData[0]%>"; MaStpNm[NumOfAM] = "<%=sData[1]%>";
                  MaStrTxt[NumOfAM] = "<%=sData[2]%>"; MaStpTxt[NumOfAM] = "<%=sData[3]%>";
                  MaMsgDa[NumOfAM] = "<%=sData[4]%>"; MaMsgTi[NumOfAM] = "<%=sData[5]%>";
                  MaStrTm[NumOfAM] = "<%=sData[6]%>"; MaStpTm[NumOfAM] = "<%=sData[7]%>";
                  NumOfAM++;
            </script>
          </tr>
          <%iNumOfAM++;%>
       <%}%>

     </table>
<br><br>
<!-- ======================================================================= -->
       <a href="javascript:showMbDtl('ADD', null)">Add Message</a>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSaS">
         <tr><th colspan=10>Message Board List</th></tr>
         <tr class="DataTable">
           <th class="DataTable">Update</th>
           <%for(int i=0; i < sMbCol.length; i++){%>
              <th class="DataTable"><%=sMbCol[i]%></th>
           <%}%>
             <th class="DataTable">Update</th>
             <th class="DataTable">Delete</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <% int iNumOfMB = 0;
         it = vMsgBoard.iterator();
         while(it.hasNext()){
            String [] sData = (String []) it.next();
       %>
          <tr class="DataTable">
            <%for(int i=0; i < sMbCol.length; i++){%>
               <td class="DataTable"><%=sData[i]%></td>
            <%}%>
            <td class="DataTable"><a href="javascript:showMbDtl('UPD', '<%=iNumOfMB%>')">Upd</a></td>
            <td class="DataTable"><a href="javascript:showMbDtl('DLT', '<%=iNumOfMB%>')">Dlt</a></td>

            <script name="javascript1.2">
                  MbName[NumOfMB] = "<%=sData[0]%>"; MbText[NumOfMB] = "<%=sData[1]%>";  MbFont[NumOfMB] = "<%=sData[2]%>"; MbColor[NumOfMB] = "<%=sData[3]%>"; MbBgClr[NumOfMB] = "<%=sData[4]%>";
                  NumOfMB++;
            </script>
          </tr>
          <%iNumOfMB++;%>
       <%}%>

     </table>


<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY>
</HTML>





