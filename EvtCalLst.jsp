<%@ page import="rciutility.StoreSelect,java.util.*, eventcalendar.EvtCalLst"%>
<%

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EvtCalLst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    boolean bAll_EC_Auth = session.getAttribute("EVTCALCHG") != null;
    boolean bBuyer_EC_Auth = session.getAttribute("EVTCALBYR") != null;
    boolean bStr_EC_Auth = session.getAttribute("EVTCALSTR") != null;
    String sAuthStr = session.getAttribute("STORE").toString().trim();
    String [] sSelType = request.getParameterValues("Type");

    String sUser = session.getAttribute("USER").toString();
    String [] sQtr = request.getParameterValues("Qtr");
    String [] sSelStore = request.getParameterValues("Str");

    if (sSelStore==null) sSelStore = new String[]{" "};

    EvtCalLst evtcal = new EvtCalLst(sQtr, sSelStore, sSelType, sUser);
    int iNumOfCol = evtcal.getNumOfCol();
    int [] iColSeq = evtcal.getColSeq();
    String [] sUsed = evtcal.getUsed();
    String [] sCol = evtcal.getCol();
    String sColJsa = evtcal.getColJsa();

    int iNumOfEvt = evtcal.getNumOfEvt();
    String [] sMon = evtcal.getMon();
    String [] sEvent = evtcal.getEvent();
    String [] sFrom = evtcal.getFrom();
    String [] sTo = evtcal.getTo();
    String [] sRemind = evtcal.getRemind();
    String [] sStrEvtTy = evtcal.getStrEvtTy();
    String [] sEvtTime = evtcal.getEvtTime();
    String [] sAuth = evtcal.getAuth();
    String [][] sEvtText = evtcal.getEvtText();
    String [][] sEvtStr = evtcal.getEvtStr();
    String [] sType = evtcal.getType();

    String sEvtStrJsa = evtcal.getEvtStrJsa();
    String sEventJsa = evtcal.getEventJsa();
    String sFromJsa = evtcal.getFromJsa();
    String sToJsa = evtcal.getToJsa();
    String sScopeJsa = evtcal.getScopeJsa();
    String sRemindJsa = evtcal.getRemindJsa();
    String sStrEvtTyJsa = evtcal.getStrEvtTyJsa();
    String sEvtTimeJsa = evtcal.getEvtTimeJsa();
    String sAuthJsa = evtcal.getAuthJsa();
    String sEvtTextJsa = evtcal.getEvtTextJsa();
    String sTypeJsa = evtcal.getTypeJsa();

    boolean [] bEvtMemo = evtcal.getEvtMemoExist();
    boolean [] bEvtSign = evtcal.getEvtSignExist();
    boolean [] bEvtAdv = evtcal.getEvtAdvExist();

    // Attached Advertising, Memo, Sign Posts
    int [] iAdv = evtcal.getAdv();
    int [] iMemo = evtcal.getMemo();
    int [] iSign = evtcal.getSign();
    int [] iTrack = evtcal.getTrack();

    int iNumOfMon = evtcal.getNumOfMon();
    String [] sYear = evtcal.getYear();
    String sYearJsa = evtcal.getYearJsa();
    String [] sMonName = evtcal.getMonName();
    String [] sMonBeg = evtcal.getMonBeg();
    String [] sMonEnd = evtcal.getMonEnd();
    String [] sMonCnt = evtcal.getMonCnt();

    //String sStrJsa = evtcal.getStrJsa(); // list of store selections
    evtcal.disconnect();
    
    String sStrAllowed = session.getAttribute("STORE").toString();
  	 
  	StoreSelect strlst = null;     

    if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
    {
      strlst = new StoreSelect(20);
    }
    else if (sStrAllowed != null && sStrAllowed.trim().equals("70"))
    {
      strlst = new StoreSelect(21);
    }
    else
    {
      Vector vStr = (Vector) session.getAttribute("STRLST");
      String [] sStrAlwLst = new String[ vStr.size()];
      Iterator iter = vStr.iterator();

      int iStrAlwLst = 0;
      while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

      if (vStr.size() > 1) { strlst = new StoreSelect(sStrAlwLst); }
      else strlst = new StoreSelect(new String[]{sStrAllowed});
   }

   String sStrJsa = strlst.getStrNum();
   String sStrNameJsa = strlst.getStrName();

   int iNumOfStr = strlst.getNumOfStr();
   String [] sStr = strlst.getStrLst();

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
<title>Event Calendar</title>

<style>
  body {background:ivory;}
  a:link { color:blue;  font-size:10px;} a:visited { color:blue; font-size:10px;}  a:hover { color:blue; font-size:10px;}

  table.DataTable { border: darkred solid 1px; background:#e7e7e7; text-align:center;}
  tr.DataTable { background:#FFCC99; font-family:Verdanda; text-align:center;
                 font-size:10px; font-weight:bold}
  th.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px;}
  tr.DataTable1 { color: red; background:cornsilk; font-family:Verdanda; font-size:12px; font-weight:bold}
  tr.DataTable2 { background:#e7e7e7; font-family:Arial; text-align:left; font-size:10px;}
  td.DataTable { border-bottom: darkred solid 1px; border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px;
                 padding-right:3px; padding-left:3px;}
  td.DataTable1 { border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                 border-right: darkred solid 1px;}
  tr.Divider { background:darkred; font-size:1px;}

  div.dvPrompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:550; background-color:LemonChiffon; z-index:100;
              text-align:center; font-size:10px}

  div.dvStore { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:250; background-color:LemonChiffon; z-index:100;
              text-align:center; font-size:10px}


  .Small{ text-align:left; font-family:Arial; font-size:10px;}
  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
  td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
  td.Prompt { text-align:left; font-family:Arial; font-size:10px; }
  td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
  td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
  
  td.td01 { border-bottom: #ececec ridge 4px; text-align:center; vertical-align: bottom; font-family:Arial; font-size:10px; 
            padding-bottom:5px;}
  td.td02 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; 
            padding-top:5px;}
  
@media screen
{
  th.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px;}
  td.PrintOnly { display:none}
}

@media print
{
   @page {size: 8.5in 14in landscape; }
   th.DataTable1 { display:none}
   td.PrintOnly { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px;}
}
</style>

<SCRIPT language="JavaScript">
var SelYear = [<%=sYearJsa%>];
var Qtr = [<%=evtcal.cvtToJavaScriptArray(sQtr)%>];
var AuthStr = "<%=sAuthStr%>";
var SelType = new Array(); 
<%for(int i=0; i < sSelType.length; i++){%>SelType[SelType.length] = "<%=sSelType[i]%>"; <%}%>

var Column = [<%=sColJsa%>];
var Event  = [<%=sEventJsa%>];
var From = [<%=sFromJsa%>];
var To = [<%=sToJsa%>];
var Scope = [<%=sScopeJsa%>];
var Remind = [<%=sRemindJsa%>];
var StrEvtTy = [<%=sStrEvtTyJsa%>];
var EvtTime = [<%=sEvtTimeJsa%>];
var EvtText = [<%=sEvtTextJsa%>];
var EvtStr = [<%=sEvtStrJsa%>];
var Type = [<%=sTypeJsa%>];

var Stores = [<%=sStrJsa%>];
var aBikeStr = ["3","4","5","6","8","10","11","16","20","22","42","82","87","88","90","91","92","93","96","98"];
var aPatioStr = ["35","46","50","63","64","68","86"];

var ArrStrNm = [<%=sStrNameJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];

//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
  setBoxclasses(["BoxName",  "BoxClose"], ["dvPrompt", "dvStore"]);
  window.document.focus();
  setSelEvtType();
}
//--------------------------------------------------------
// Add, Update, Delete Event
//--------------------------------------------------------
function chgEvent(arg, action)
{
   var hdr = "Create New Event";
   if(action =='UPD') { hdr = "Update Event: " + Event[arg]}
   else if(action == 'DLT') { hdr = "Delete Event: " + Event[arg]}


   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popPanel(action)
     + "</tr></td>"
   + "</table>"

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.left= document.body.scrollLeft + 10;
   document.all.dvPrompt.style.top= document.body.scrollTop + 135;
   document.all.dvPrompt.style.visibility = "visible";

   if(action !='ADD') popPanelValues(arg);
   if(action !='DLT' && AuthStr == "ALL") showStrPnl(false);
   // limit only to one store
   if(AuthStr != "ALL")
   {
      document.all[Column[4]].value = AuthStr;
      document.all[Column[4]].readOnly = true;
   }

   // hide all columns for reminder
   if(action !='ADD' && Remind[arg]=="Y")
   {
     for(var i=0; i < document.all.trColumn.length; i++)
     {
        document.all.trColumn[i].style.display="none"; hideStrPanel();
     }
   }

   // check if event is store meeting/clinix
   if(action != "ADD" && AuthStr != "ALL")  { chgStrEvtType(action) }

   popStrEvent(arg, action)   
   
}
 
//--------------------------------------------------------
// rename Event
//--------------------------------------------------------
function renameEvent(arg)
{
   var posX = document.body.scrollLeft + 600;
   var posY = document.body.scrollTop + 60;

   var hdr = "Rename Event";
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
       + "Current Event >>> &nbsp;" + Event[arg].showSpecChar() + "&nbsp;&nbsp;"
       + From[arg].showSpecChar() + " - " + To[arg].showSpecChar()
    + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
       + "New Event:  <input class='Small' name='Event' size=50 maxsize=50 value='" + Event[arg].showSpecChar() + "'>"
    + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>From: "
     + "<input class='Small' name='From' size=10 maxsize=10 value='" + From[arg] + "'>&nbsp;"
     + "<a href='javascript:showCalendar(1, null, null, " + posX + ", " + posY + ", document.all.From)' >"
     + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a>"
     + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
     + "To: <input class='Small' name='To' size=10 maxsize=10 value='" + To[arg] + "'>&nbsp;"
     + "<a href='javascript:showCalendar(1, null, null, " + posX + ", " + posY + ", document.all.To)' >"
     + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a>"

    + "</td></tr>"
    + "<tr><td class='Prompt1' colspan=4><button onClick='ValidateRnm(" + arg + ")' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
   + "</table>"

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.width = 350;
   document.all.dvPrompt.style.pixelLeft= document.body.scrollLeft + 10;
   document.all.dvPrompt.style.pixelTop= document.body.scrollTop + 135;
   document.all.dvPrompt.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popPanel(action)
{
  var posX = document.body.scrollLeft + 600;
  var posY = document.body.scrollTop + 60;

  var panel = "<table width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr><td class='td02'>Event Description</td>"
          + "<td class='td02'>From</td>"
          + "<td class='td02'>To</td>"
      + "</tr>"

   if(action == "ADD")
   {
      panel += "<tr>"
          + "<td class='td01'><input class='Small' name='Event' size=25 maxsize=100>"

      if(AuthStr != "ALL")
      {
         panel += "<br><select class='Small' name='StrEvtTy' onChange='chgStrEvtType(&#34;"
               + action + "&#34;)'></select>"
               + "<br>Event Time<br><input class='Small' name='EvtTime'>"
      }

      panel += "</td>"
          + "<td class='td01'><input class='Small' name='From' size=10 maxsize=10 >&nbsp;"
            + "<a href='javascript:showCalendar(1, null, null, " + posX + ", " + posY + ", document.all.From)' >"
            + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a></td>"
          + "<td class='td01'><input class='Small' name='To' size=10 maxsize=10 >&nbsp;"
            + "<a href='javascript:showCalendar(1, null, null, " + posX + ", " + posY + ", document.all.To)' >"
            + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a></td>"
      + "</tr>"
    }
    else
    {
      panel += "<tr>"
          + "<td class='td02'><input class='Small' name='Event' size=25 maxsize=100 readonly>"
      // store event
      if(AuthStr != "ALL")
      {
         panel += "<input type='hidden' name='StrEvtTy' value='None'>"
         + "<br>Event Time<br><input class='Small' name='EvtTime'>"
      }
      panel +="</td>"
          + "<td class='td02'><input class='Small' name='From' size=10 maxsize=10 readonly></td>"
          + "<td class='td02'><input class='Small' name='To' size=10 maxsize=10 readonly></td>"
      + "</tr>"
    }

    // line 2
    panel += "<tr id='trColumn'>"
          + "<td class='td02'>Event Type: Instore Sale Event</td>"
          + "<td class='td02'>Grassroots</td>"
          + "<td class='td02'>Training</td>"
          + "<td class='td02'>Store Ops</td>"
      + "</tr>"

      + "<tr id='trColumn'>"
          + "<td class='td01'><input type='radio' class='Small' name='Type' value='GENERIC' checked></td>"
          + "<td class='td01'><input type='radio' class='Small' name='Type' value='GRASSROOT'></td>"
          + "<td class='td01'><input type='radio' class='Small' name='Type' value='TRAINING'></td>"
          + "<td class='td01'><input type='radio' class='Small' name='Type' value='STROPS'></td>"
      + "</tr>"

    // line 3
    panel += "<tr id='trColumn'><td class='td02' colspan=3>Effective Date</td>"          
      + "</tr>"
      + "<tr id='trColumn'>"
          //+ "<td class='td01'><input class='Small' name='" + Column[1] + "' size=25 maxsize=100>"
          //+ "<a href='javascript:showCalendar(1, null, null, " + posX + ", " + posY + ", document.all." + Column[0] + ")' >"
          //  + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a></td>"
          + "<td class='td01' colspan=3><input class='Small' name='" + Column[2] + "' size=10 maxsize=10>"
          + "<a href='javascript:showCalendar(1, null, null, " + posX + ", " + posY + ", document.all." + Column[2] + ")' >"
            + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a>"
            + "<input type='hidden' name='" + Column[1] + "'>"
            + "<input type='hidden' name='" + Column[3] + "'>"
          + "</td>"
          //+ "<td class='td01'><input class='Small' name='" + Column[3] + "' size=10 maxsize=10>"
          //+ "<a href='javascript:showCalendar(1, null, null, " + posX + ", " + posY + ", document.all." + Column[3] + ")' >"
          //  + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a></td>"
      + "</tr>"

      + "<tr id='trColumn'>"
          + "<td class='td02' colspan=3>&nbsp;<br>&nbsp;Stores</td>"
          //+ "<td class='td02'>Outside Print<br>22 x 28<br>Major Hang</td>"
          //+ "<td class='td02'>Rci Produced<br>40 x 50 & 22 x 28<br>RCI Produced</td>"          
      + "</tr>"

      + "<tr id='trColumn'>"
          + "<td class='td01' colspan=3><input class='Small' name='" + Column[4] + "' size=30 maxsize=100 readonly></td>"
         // + "<td class='td01'><input class='Small' name='" + Column[5] + "' size=25 maxsize=100></td>"
         // + "<td class='td01'><input class='Small' name='" + Column[6] + "' size=25 maxsize=100></td>"
      + "</tr>"
/*
      + "<tr id='trColumn'>"
          + "<td class='td02'>PosterCreative<br>and Buyer<br>Turn-In</td>"
          + "<td class='td02'>Ship To Stores</td>"
          + "<td class='td02'>Release<br>Price Chgs</td>"
      + "</tr>"
      
      + "<tr id='trColumn'>"
          + "<td class='td01'><input class='Small' name='" + Column[7] + "' size=25 maxsize=100>"
          + "<a href='javascript:showCalendar(1, null, null, " + posX + ", " + posY + ", document.all." + Column[7] + ")' >"
            + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a></td>"
          + "<td class='td01'><input class='Small' name='" + Column[8] + "' size=25 maxsize=100>"
          + "<a href='javascript:showCalendar(1, null, null, " + posX + ", " + posY + ", document.all." + Column[8] + ")' >"
            + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a></td>"
          + "<td class='td01'><input class='Small' name='" + Column[9] + "' size=25 maxsize=100>"
          + "<a href='javascript:showCalendar(1, null, null, " + posX + ", " + posY + ", document.all." + Column[9] + ")' >"
            + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a></td>"
      + "</tr>"
      
      + "<tr id='trScope'>"
        + "<td class='td02'>Web Event</td>"
        + "<td class='td02'>Event Scope</td>"
      
      if(action == 'ADD') panel += "<td class='td02'>Reminder only</td>"

      panel +=  "</tr>"
        + "<tr id='trScope'>"
          + "<td class='td01'><input class='Small' type='checkbox' name='" + Column[0] + "' value='Y' >Y/N</td>"
          + "<td class='td01'>Personal<input class='Small' name='Scope' type='radio' value='1'>"
            + "Office<input class='Small' name='Scope' type='radio' value='2'>"
            + "All<input class='Small' name='Scope' type='radio' value='3' checked></td>"
      if(action == 'ADD') panel += "<td class='td01'><input class='Small' name='Remind' type='checkbox' onClick='chgEvtToRminder(this)' value='Y'>Reminder</td>"
      else panel += "<td class='td01'><input class='Small' name='Remind' type='hidden' value=''>&nbsp;</td>"
      panel += "</tr>"
*/

      if(action!='DLT') panel += "<tr><td class='td02' colspan=4><button onClick='Validate(&#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"
      else panel += "<tr><td class='td02' colspan=4><button onClick='Validate(&#34;" + action + "&#34;)' class='Small'>Delete</button>&nbsp;"

     panel += "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
     panel += "</table>";

  return panel;
}

//--------------------------------------------------------
// populate values on entry panel
//--------------------------------------------------------
function popPanelValues(arg)
{
   var event = Event[arg].showSpecChar();

   document.all.Event.value = event;
   document.all.From.value = From[arg];
   document.all.To.value = To[arg];

   document.all.Event.style.background = "#e7e7e7";
   document.all.From.style.background = "#e7e7e7";
   document.all.To.style.background = "#e7e7e7";

   document.all.Event.style.border = "none";
   document.all.From.style.border = "none";
   document.all.To.style.border = "none";

   // Event type
   for(var i=0; i < document.all.Type.length; i++)
   {
       if(document.all.Type[i].value == Type[arg]){ document.all.Type[i].checked = true; }
   }

   if (document.all.StrEvtTy != null)
   {
     document.all.StrEvtTy.value = StrEvtTy[arg];
     document.all.EvtTime.value = EvtTime[arg];
   }

   // all column exclude stores
   for(var i=0; i < Column.length; i++)
   {
	  var colobj = document.all[Column[i]]; 
      if (i==0 &&  EvtText[arg][i]=="Y" && colobj != null)  { document.all[Column[i]].checked=true; }
      if (i != 4 && i != 0 && colobj != null)  { document.all[Column[i]].value = EvtText[arg][i].showSpecChar(); }
   }

   for(var i=0; i < EvtStr[arg].length; i++)
   {
      document.all[Column[4]].value += EvtStr[arg][i].showSpecChar() + " ";
   }

   // Event Scope
   /*for(var i=0; i < 3; i++) 
   {
	   var scope = document.all.Scope[i];
	   if(scope != null){ document.all.Scope[i].checked = false; }
   }
   
   
   if(document.all.Scope[2] != null && Scope[arg].trim()==""){ document.all.Scope[2].checked = true; }
   else if(document.all.Scope[1] != null && Scope[arg].trim()=="OFFICE") { document.all.Scope[1].checked = true; }
   else if(document.all.Scope[0] != null){document.all.Scope[0].checked = true;}
   */
   
   if(AuthStr != "ALL")
   {
      for(var i=0; i < 3; i++) {document.all.Scope[i].checked = false; }
      document.all.Scope[2].checked = true;
      document.all.trScope[0].style.display="none";
      document.all.trScope[1].style.display="none";
   }
}
//--------------------------------------------------------
// change Event to reminder
//--------------------------------------------------------
function chgEvtToRminder(chkbox)
{
  var cols = document.all.trColumn;
  for(var i=0; i < cols.length; i++)
  {
     if(chkbox.checked) { cols[i].style.display="none"; hideStrPanel();}
     else { cols[i].style.display ="inline"; showStrPnl(false); }
  }
}
//--------------------------------------------------------
// populate Store event type and event time
//--------------------------------------------------------
function popStrEvent(arg, action)
{
   // event type for store
   if(action =='ADD' && AuthStr != "ALL")
   {
      document.all.StrEvtTy.options[0] = new Option("NONE", "None");
      document.all.StrEvtTy.options[1] = new Option("MEETING", "Meeting");
      document.all.StrEvtTy.options[2] = new Option("CLINIC", "Clinic");
      document.all.StrEvtTy.options[3] = new Option("STREVT", "Store Event");

      for(var i=0; i < 3; i++) {document.all.Scope[i].checked = false;}
      document.all.Scope[2].checked = true;
   }
}
//--------------------------------------------------------
// change Store event Type
//--------------------------------------------------------
function chgStrEvtType(action)
{
   var strEvt = null;
   if(action == "ADD") strEvt = document.all.StrEvtTy.options[document.all.StrEvtTy.selectedIndex].text;
   else strEvt = document.all.StrEvtTy.value;

   if(strEvt!="None")
   {
      if(action == "ADD") document.all.Event.value = strEvt;
      // Remove all columns
      var cols = document.all.trColumn;
      for(var i=0; i < cols.length; i++) { cols[i].style.display="none"; hideStrPanel();  }
      document.all.trScope[0].style.display="none";
      document.all.trScope[1].style.display="none";
   }
   else
   {
      // Remove all columns
      var cols = document.all.trColumn;
      for(var i=0; i < cols.length; i++) { cols[i].style.display ="inline"; }
      document.all.trScope[0].style.display="block";
      document.all.trScope[1].style.display="block";
   }
}

//--------------------------------------------------------
// Show Stores Panel
//--------------------------------------------------------
function showStrPnl(sel)
{
   var hdr = "Store Selection List";

   var html = "<table width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hideStrPanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popStrPnl() + "</tr></td>"

    if(sel) html += "<tr><td class='Prompt1' colspan=2><button onClick='sbmSelStr()' class='Small'>Select</button>&nbsp;"
    else html += "<tr><td class='Prompt1' colspan=2><button onClick='selStr()' class='Small'>Select</button>&nbsp;"
    html +=  "<button onClick='clrStrSel()' class='Small'>Clear</button>&nbsp;"
         +  "<button onClick='hideStrPanel();' class='Small'>Close</button></td></tr>"

    html += "<tr><td class='Prompt1' colspan=2><button onClick='preSelectedStr(1)' class='Small'>All</button>&nbsp;"    	 
    	  + "<button onclick='checkReg(&#34;PATIO&#34;)' class='Small'>Patio</button> &nbsp; &nbsp;"
    	  + "<button onclick='checkReg(&#34;BIKE&#34;)' class='Small'>Bike</button> &nbsp; &nbsp;<br>"
         
         + "<button onclick='checkReg(&#34;1&#34;)' class='Small'>Dist 1</button> &nbsp; &nbsp;"
    	 + "<button onclick='checkReg(&#34;2&#34;)' class='Small'>Dist 2</button> &nbsp; &nbsp;"
    	 + "<button onclick='checkReg(&#34;3&#34;)' class='Small'>Dist 3</button> &nbsp; &nbsp;"
    	 + "<button onclick='checkReg(&#34;99&#34;)' class='Small'>Dist 99</button> &nbsp; &nbsp;"    	 
    	 + "<button onclick='checkReg(&#34;PATIO&#34;)' class='Small'>Patio</button> &nbsp; &nbsp;"
    	 + "<button onclick='checkReg(&#34;BIKE&#34;)' class='Small'>Bike</button> &nbsp; &nbsp;<br>"
    	 
    	 + "<button onclick='checkDist(&#34;9&#34;)' class='Small'>Houston</button> &nbsp; &nbsp;"
    	 + "<button onclick='checkDist(&#34;20&#34;)' class='Small'>Dallas/FtW</button> &nbsp; &nbsp;"
    	 + "<button onclick='checkDist(&#34;35&#34;)' class='Small'>Ski Chalet</button> &nbsp; &nbsp;"
    	 + "<button onclick='checkDist(&#34;38&#34;)' class='Small'>Boston</button> &nbsp; &nbsp;"
    	 + "<button onclick='checkDist(&#34;41&#34;)' class='Small'>OKC</button> &nbsp; &nbsp;"
    	 + "<button onclick='checkDist(&#34;52&#34;)' class='Small'>Charl</button> &nbsp; &nbsp;"
    	 + "<button onclick='checkDist(&#34;53&#34;)' class='Small'>Nash</button> &nbsp; &nbsp;<br>"
    	 
    	 + "<button onclick='checkMall(&#34;&#34;)' class='Small'>Mall</button> &nbsp; &nbsp;"
    	 + "<button onclick='checkMall(&#34;NOT&#34;)' class='Small'>Non-Mall</button> &nbsp; &nbsp;"
         
    	 + "</td></tr>"

   + "</table>"

   document.all.dvStore.innerHTML = html;
   document.all.dvStore.style.pixelLeft= document.body.scrollLeft + 600;
   document.all.dvStore.style.pixelTop= document.body.scrollTop + 220;
   document.all.dvStore.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popStrPnl()
{
  var panel = "<div style='height:auto;'>"
            + "<table width='100%' cellPadding='0' cellSpacing='0'>"


  for(var i=0, j=0; i < Stores.length; i++, j++ )
  {
     if(j==0) panel += "<tr>"
     panel += "<td class='Prompt'><input type='checkbox' class='Small' name='SelStr' value='"
           + Stores[i] + "' onClick='chkSelStr(this)'>"
           + Stores[i] +"</td>"
     if(j == 9) {panel += "</tr>"; j=0;}
  }

  panel += "</table></div>";
  return panel;
}
//--------------------------------------------------------
// checked as selected group of stores
//--------------------------------------------------------
function preSelectedStr(grp)
{
   var max = document.all.SelStr.length
   for(var i=0; i < max; i++ )
   {
	 document.all.SelStr[i].checked = false;
	   
	 var str = document.all.SelStr[i].value
     if(grp==1){ document.all.SelStr[i].checked = true; }     
     else { document.all.SelStr[i].checked = false; }
   }
}
//==============================================================================
//check by regions
//==============================================================================
function checkReg(dist)
{
var str = document.all.SelStr;
var chk1 = false;
var chk2 = false;

//check 1st selected group check status and save it
var find = false;
for(var i=0; i < str.length; i++)
{
for(var j=0; j < Stores.length; j++)
{
   if(dist != "PATIO" && str[i].value == Stores[j] && ArrStrReg[j] == dist
     || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
     || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
     || str[i].value == "68" || str[i].value == "86"))
     
     || (dist == "BIKE" && (str[i].value == "3" || str[i].value == "4" || str[i].value == "6" 
     || str[i].value == "8" || str[i].value == "10" || str[i].value == "16" || str[i].value == "20" 
     || str[i].value == "22" || str[i].value == "42" || str[i].value == "82" || str[i].value == "87"       
     || str[i].value == "88" || str[i].value == "90" || str[i].value == "91" || str[i].value == "93" 
     || str[i].value == "96" || str[i].value == "98"))
     
     )
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
for(var j=0; j < Stores.length; j++)
{
   if(dist != "PATIO" && str[i].value == Stores[j] && ArrStrReg[j] == dist
     || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
     || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
     || str[i].value == "68" || str[i].value == "86"))
     
     || (dist == "BIKE" && (str[i].value == "3" || str[i].value == "4" || str[i].value == "6" 
     || str[i].value == "8" || str[i].value == "10" || str[i].value == "16" || str[i].value == "20" 
     || str[i].value == "22" || str[i].value == "42" || str[i].value == "82" || str[i].value == "87"       
     || str[i].value == "88" || str[i].value == "90" || str[i].value == "91" || str[i].value == "93" 
     || str[i].value == "96" || str[i].value == "98"))
   )
   {
      str[i].checked = chk1;
   };
}
}
}
//==============================================================================
//check by districts
//==============================================================================
function checkDist(dist)
{
var str = document.all.SelStr;
var chk1 = false;
var chk2 = false;

//check 1st selected group check status and save it
var find = false;
for(var i=0; i < str.length; i++)
{
for(var j=0; j < Stores.length; j++)
{
   if(str[i].value == Stores[j] && ArrStrDist[j] == dist)
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
for(var j=0; j < Stores.length; j++)
{
   if(str[i].value == Stores[j] && ArrStrDist[j] == dist)
   {
      str[i].checked = chk1;
   };
}
}
}

//==============================================================================
//check mall
//==============================================================================
function checkMall(type)
{
	var str = document.all.SelStr;
	var chk1 = true;
	var chk2 = false;

	for(var i=0; i < str.length; i++)
	{
		str[i].checked = chk2;
		for(var j=0; j < Stores.length; j++)
		{
   			if(str[i].value == Stores[j] && ArrStrMall[j] == type)
   			{
   				str[i].checked = chk1;
   			};
		}
	}
}

//--------------------------------------------------------
// check selected Store number
//--------------------------------------------------------
function chkSelStr(str)
{
  var val = str.value
  if (str.checked && val == "Hou"
   || str.checked && val == "All Bike"
   || str.checked && val == "Sun & Ski"
   || str.checked && val == "Ski Chalet"
   || str.checked && val == "All")
   { rmvSelStr(val, "ALL") }
   else { rmvSelStr(val, "CHAR") }
}
//--------------------------------------------------------
// uncheck selected Store number
//--------------------------------------------------------
function rmvSelStr(val, type)
{
    var max = document.all.SelStr.length
    for(var i=0; i < max; i++ )
    {
       var str = document.all.SelStr[i].value
       if  (str != val && type == "ALL" || type == "CHAR" && isNaN(str))
       {
          document.all.SelStr[i].checked = false;
       }
    }
}
//--------------------------------------------------------
// put select Store in main panel
//--------------------------------------------------------
function selStr()
{
  document.all.STORE.value = "";
  var max = document.all.SelStr.length
  for(var i=0; i < max; i++ )
  {
     if (document.all.SelStr[i].checked)
     {
        document.all.STORE.value += document.all.SelStr[i].value + " "
     }
  }
}

//--------------------------------------------------------
// submit report with selected stores
//--------------------------------------------------------
function sbmSelStr()
{
  var url = 'EvtCalLst.jsp?submit=strsel'
  for(var i=0; i < Qtr.length; i++) { url += "&Qtr=" + Qtr[i]}

  var max = document.all.SelStr.length
  for(var i=0; i < max; i++ )
  {
     if (document.all.SelStr[i].checked)
     {
        url += "&Str=" + document.all.SelStr[i].value;
     }
  }
  
  for(var i=0; i < SelType.length; i++ )
  {
	  url += "&Type=" + SelType[i];
  }

  //alert(url)
  window.location.href=url;
}
//--------------------------------------------------------
// Clear Store Selection
//--------------------------------------------------------
function clrStrSel()
{
  for(var i=0; i < Stores.length; i++ )
  {
     document.all.SelStr[i].checked = false;
  }
}
//--------------------------------------------------------
// Validate entry
//--------------------------------------------------------
function Validate(action)
{
  var msg = ""
  var error = false;

  var evt = document.all.Event.value.replaceSpecChar();

  var from = document.all.From.value.trim();
  var to = document.all.To.value.trim();

  var type = null;
  for(var i=0; i < document.all.Type.length; i++)
  {
     if(document.all.Type[i].checked) { type = document.all.Type[i].value}
  }


  var cols = new Array(Column.length);
  for(var i=0; i < Column.length; i++)
  {
	 var colobj = document.all[Column[i]];
     if(i != 0 && colobj != null) { cols[i] = document.all[Column[i]].value.trim().replaceSpecChar();}
     else if(colobj != null && document.all[Column[i]].checked){  cols[i] = "Y"}
     else if(colobj != null) {  cols[i] = " "}
  }

  // get document scope
  var scope = "1";
  /*for(var i=0; i < 3; i++)
  {
    if(document.all.Scope[i].checked) scope = document.all.Scope[i].value;
  }
  */

  // Event or Reminder only
  var remind = " ";
  //if(action=="ADD" && document.all.Remind.checked) remind = "Y";

  // Store Event Type
  var strevtty = " ";
  if(action=="ADD" && AuthStr != "ALL")
  {
     var setId = document.all.StrEvtTy.selectedIndex;
     if(setId > 0) strevtty = document.all.StrEvtTy[document.all.StrEvtTy.selectedIndex].value;
  }

  var evttime = " ";
  if(AuthStr != "ALL") evttime = document.all.EvtTime.value;

  // Event cannot be blank
  if(evt == "")
  {
     error = true;
     msg += "Please, enter Event\n"
  }
  if(from == "")
  {
     error = true;
     msg += "Please, enter From Date\n"
  }

  if (error) alert(msg)
  else sbmEvent(action, evt, from, to, scope, remind, strevtty, evttime, cols, type);
}

//--------------------------------------------------------
// Validate entry
//--------------------------------------------------------
function ValidateRnm(arg)
{
  var msg = ""
  var error = false;

  var evt = Event[arg].showSpecChar().replaceSpecChar();
  var from = From[arg];
  var to = To[arg];
  // new name
  var cols = new Array(Column.length);
  cols[0] = document.all.Event.value.replaceSpecChar();
  cols[1] = document.all.From.value;
  cols[2] = document.all.To.value;

  // Event cannot be blank
  if(cols[0] == "")
  {
     error = true;
     msg += "Please, enter Event\n"
  }
  if(cols[1] == "")
  {
     error = true;
     msg += "Please, enter From Date\n"
  }


  if (error) alert(msg)
  else sbmEvent("RENAME", evt, from, to, " ", " ", " ", " ", cols, " ");
}

//--------------------------------------------------------
// Submit group
//--------------------------------------------------------
function sbmEvent(action, evt, from, to, scope, remind, strevtty, evttime, cols, type)
{
  if (action != "DLT" ||  action == "DLT" && confirm("Are You sure you want to delete event?"))
  {
	  var url = "EvtCalEnt.jsp?"
  
     + "Event=" + evt
     + "&From=" + from
     + "&To=" + to
     + "&Scope=" + scope
     + "&Remind=" + remind
     + "&StrEvtTy=" + strevtty
     + "&EvtTime=" + evttime
     + "&Type=" + type;

  	for(var i=0;  i < Column.length; i++)
  	{
        if(cols[i] != null){ url += "&Col=" + cols[i] }
        else{ url += "&Col="; }
  	}

  	url += "&Action=" + action;

    //alert(url)
    //window.location = url;
    window.frame1.location = url;
  }
}
//--------------------------------------------------------
// display error for entry
//--------------------------------------------------------
function displayError(Error)
{
   alert(Error)
}
//--------------------------------------------------------
// restart page after entry done
//--------------------------------------------------------
function reStart()
{
  window.location.reload();
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvPrompt.innerHTML = " ";
   document.all.dvPrompt.style.visibility = "hidden";
   hideStrPanel()
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hideStrPanel()
{
   document.all.dvStore.innerHTML = " ";
   document.all.dvStore.style.visibility = "hidden";
}
//--------------------------------------------------------
// update document link
//--------------------------------------------------------
function updLink(arg, type)
{
  var url = 'EvtDocLst.jsp?' + "Event=" + Event[arg].showSpecChar().replaceSpecChar()
          + "&From=" + From[arg]
          + "&Type=" + type;
  var WindowName = 'EvtDocLink';
  var WindowOptions =
   'width=900,height=600, left=10,top=50, resizable=yes , toolbar=yes, location=yes, directories=no, status=yes, scrollbars=yes,menubar=yes';

  //alert(url)
  window.open(url, WindowName, WindowOptions);
}

//--------------------------------------------------------
// update advertising
//--------------------------------------------------------
function updAdv(arg)
{
  var url = 'EvtAdvLst.jsp?' + "Event=" + Event[arg].trim().showSpecChar().replaceSpecChar()
          + "&From=" + From[arg]
  var WindowName = 'EvtAdvLink';
  var WindowOptions =
   'width=900,height=600, left=10,top=10, resizable=yes , toolbar=yes, location=yes, directories=no, status=yes, scrollbars=yes,menubar=yes';

  //alert(url)
  window.open(url, WindowName, WindowOptions);
}
//---------------------------------------------------------
// launch fiscal Calendar
//---------------------------------------------------------
function launchFisCal(monend)
{
  var url = "FisCal.jsp?Action=GETMON&MonEnd=" + monend
  var WindowName = 'FiscalCalendar';
  var WindowOptions =
   'width=150,height=150, left=100,top=50, resizable=yes , toolbar=no, location=no, directories=no, status=yes, scrollbars=no,menubar=no';

  //alert(url)
  window.open(url, WindowName, WindowOptions);
}
//=====================================================================
//set check box  - event type selection 
//=====================================================================	
function setSelEvtType()
{
	for(var i=0; i < document.all.SelType.length;i++)
	{
		for(var j=0; j < SelType.length;j++)
		{
			if(document.all.SelType[i].value == SelType[j])
			{
				document.all.SelType[i].checked = true;
			}
		}
	}
}
//=================================================================
// set event selection
//=================================================================
function setEvtType()
{
	var url = "EvtCalLst.jsp?";
	var selty = false;
	
	for(var i=0; i < Qtr.length;i++)
	{
		url += "&Qtr=" + Qtr[i];
	}
	
	for(var i=0; i < document.all.SelType.length;i++)
	{
		if(document.all.SelType[i].checked)
		{
			url += "&Type=" + document.all.SelType[i].value;
			selty = true;
		}
	}
	
	if(selty){ window.location.href=url; }
	else{ alert("Select at least 1 type."); }
}
</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>

<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvPrompt" class="dvPrompt"></div>
<div id="dvStore" class="dvStore"></div>
<!-------------------------------------------------------------------->
  <table border="0" width="100%" height="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Event Calendar
       <br>Quarter(s): <%for(int i=0; i< sQtr.length; i++){%>
                        <%=sQtr[i]%><%if(i<sQtr.length-1){%>, <%} else {%>.<%}%>
                    <%}%></b><br>

        <a href="../"><font color="red" size="-1">Home</font></a> &#62
        <a href="EvtCalSel.jsp"><font color="red" size="-1">Selection</font></a>
        &nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="checkbox" id="SelType" value="GENERIC" onclick="setEvtType()"> Store Sale Event
            &nbsp;&nbsp;&nbsp; 
            <input type="checkbox" id="SelType" onclick="setEvtType()" value="GRASSROOT"> Grassroots/Events
            &nbsp;&nbsp;&nbsp; 
            <input type="checkbox" id="SelType" onclick="setEvtType()" value="TRAINING"> Training
            &nbsp;&nbsp;&nbsp; 
            <input type="checkbox" id="SelType" onclick="setEvtType()" value="STROPS"> Store Ops
        <!----------------- start of ad table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0">
           <thead style="overflow-y: visible;">
             <tr class="DataTable">
               <th class="DataTable" rowspan=2 >Month</th>
               <th class="DataTable" rowspan=2 >Primary Event
                 <%if(bAll_EC_Auth || bStr_EC_Auth){%><br><a href="javascript: chgEvent(-1, 'ADD');">Add Event</a><%}%>
               </th>
               <th class="DataTable1" rowspan=2 >D<br>e<br>l<br>e<br>t<br>e</th>
               <th class="DataTable1" rowspan=2 >R<br>e<br>n<br>a<br>m<br>e</th>
               <th class="DataTable" rowspan=2 >Event Dates</th>
               <th class="DataTable1" rowspan=2 >D<br>i<br>r<br>e<br>c<br>t<br>i<br>v<br>e<br>s</th>
               <th class="DataTable1" rowspan=2 >M<br>a<br>n<br>i<br>f<br>e<br>s<br>t</th>
               <th class="DataTable1" rowspan=2 >A<br>d<br>v</th>
               <th class="DataTable1" rowspan=2 >T<br>r<br>a<br>c<br>k<br>i<br>n<br>g</th>

               <!-- th class="DataTable" rowspan=2 nowrap>Web<br>Event</th -->
               <!-- th class="DataTable" rowspan=2 nowrap>Bike Focus</th -->
               <th class="DataTable" colspan=1 nowrap>Perm MD Dates</th>
               <th class="DataTable" rowspan=2 nowrap><a href="javascript: showStrPnl(true)">Stores</a></th>
               <!-- th class="DataTable" rowspan=2 nowrap>Major<br>Hang</th>
               <th class="DataTable" rowspan=2 nowrap>RCI<br>Produced</th>
               <%if(bAll_EC_Auth || bBuyer_EC_Auth){%><th class="DataTable" rowspan=2 nowrap>Turn-In</th><%}%>
               <th class="DataTable" rowspan=2 nowrap>Ship To<br>Stores</th -->
               <!--<%if(bAll_EC_Auth){%><th class="DataTable" rowspan=2 nowrap>Release<br>Price Chgs</th><%}%>-->
               <!--td class="PrintOnly" rowspan=2 >Primary Event</td -->
             </tr>

             <tr class="DataTable">
                <th class="DataTable">Effective</th>
                <!-- th class="DataTable">Packet</th -->
             </tr>
           </thead>

           <!--------------------- Event Detail ----------------------------->
           <tbody overflow-y: visible;>
           <%
             String sSvMon = null;
             String [] sMonProp = new String[]{"", ""};
             for(int i=0; i < iNumOfEvt; i++){%>
             <%if(sSvMon == null || !sSvMon.equals(sMon[i])){%>
                <tr class="Divider"><td colspan=18>&nbsp;</td></tr>
             <%}%>
              <tr class="DataTable2">
                <%if(sSvMon == null || !sSvMon.equals(sMon[i])){
                     sMonProp = evtcal.getSelMon(sMon[i]); %>
                     <td class="DataTable" rowspan="<%=sMonProp[1]%>"><a href="javascript:launchFisCal('<%=sMonEnd[Integer.parseInt(sMon[i]) - 1]%>')" ><%=sMonProp[0]%></a></td>
                <%}%>

                 <%if(sAuth[i].equals("1")){%>
                    <td class="DataTable" nowrap>
                       <a href="javascript: chgEvent(<%=i%>, 'UPD');"><%=sEvent[i]%></a>
                       <%if(!sStrEvtTy[i].trim().equals("")){%> &nbsp; Time: <%=sEvtTime[i]%><%}%>
                    </td>
                 <%}
                   else {%><td class="DataTable" nowrap><%=sEvent[i]%></td><%}%>

                 <th class="DataTable1" nowrap><%if(sAuth[i].equals("1")){%><a href="javascript: chgEvent(<%=i%>, 'DLT');">D</a><%} else{%>&nbsp;<%}%></th>
                 <th class="DataTable1" nowrap><%if(sAuth[i].equals("1")){%><a href="javascript: renameEvent(<%=i%>);">R</a><%} else{%>&nbsp;<%}%></th>

                 <td class="DataTable" nowrap><%=sFrom[i] + " - " + sTo[i]%></td>
           <%if(sRemind[i].equals("Y")){%><td class="DataTable" colspan="<%=iNumOfCol+3%>" nowrap>&nbsp;</td><%}
             else {%>
                 <th class="DataTable1" nowrap><%if(bAll_EC_Auth || bEvtMemo[i]){%><a href="javascript:updLink(<%=i%>, &#34;MEMO&#34;)"><%=iMemo[i]%></a><%} else{%>&nbsp;<%}%></th>
                 <th class="DataTable1" nowrap><%if(bAll_EC_Auth || bEvtSign[i]){%><a href="javascript:updLink(<%=i%>, &#34;SIGN&#34;)"><%=iSign[i]%></a><%} else{%>&nbsp;<%}%></th>
                 <th class="DataTable1" nowrap><%if(bAll_EC_Auth || bEvtAdv[i]){%><a href="javascript:updAdv(<%=i%>)"><%=iAdv[i]%></a><%} else{%>&nbsp;<%}%></th>
                 <th class="DataTable1" nowrap><%if(bAll_EC_Auth || bEvtSign[i]){%><a href="javascript:updLink(<%=i%>, &#34;TRACK&#34;)"><%=iTrack[i]%></a><%} else{%>&nbsp;<%}%></th>

                <%for(int j=0; j < iNumOfCol; j++){%>
                  <!-- Store -->
                  <%if(j == 4){%><td class="DataTable" nowrap>&nbsp;
                     <%for(int k=0, l=0; k < sEvtStr[i].length; k++, l++){%>
                          <%if(k > 0){%> <%}%><%if(l > 11){ l=0;%><br><%}%><%=sEvtStr[i][k]%>
                     <%}%></td>
                  <%}
                    // Postres
                    else {%>
                         <%if(j == 5){%>
                             <!-- td class="DataTable" <%if(j != 1){%>nowrap<%}%>><a href="javascript:updLink(<%=i%>, &#34;OUTPOST&#34;)"><%=sEvtText[i][j]%></a>&nbsp;</td -->
                         <%}
                            else if(j == 6){%>
                              <!-- td class="DataTable" <%if(j != 1){%>nowrap<%}%>><a href="javascript:updLink(<%=i%>, &#34;RCIPOST&#34;)"><%=sEvtText[i][j]%></a>&nbsp;</td -->
                         <%}
                            else if( bAll_EC_Auth && (j==7) || bBuyer_EC_Auth && j==7) {%>
                              <!-- td class="DataTable" <%if(j != 1){%>nowrap<%}%>><%=sEvtText[i][j]%>&nbsp;</td-->
                         <%}
                             else if(j!=7 && j!=9 && j!=0 && j!=1 && j!=3 && j!=8) {%>
                             <td class="DataTable" <%if(j != 1){%>nowrap<%}%>><%=sEvtText[i][j]%>&nbsp;</td>
                      <%}%>
                  <%}%>
                <%}%>
              <%}%>
                 <!--td class="PrintOnly" nowrap><%=sEvent[i]%></td -->
              </tr>
              <%sSvMon = sMon[i];%>
           <%}%>
           </tbody>
         </table>
         <!----------------- start of ad table ------------------------>
      </td>
     </tr>
    </table>
  </body>
</html>
<%}%>