<%@ page import="java.util.*, eventcalendar.EvtDocLst, memopool.MemoMenu, java.io.*"%>
<%

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EvtDocLst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    boolean bAuth = session.getAttribute("MEMOADD") != null;

    String sEvent = request.getParameter("Event");
    String sFrom = request.getParameter("From");
    String sType = request.getParameter("Type");

    EvtDocLst evtdoc = new EvtDocLst(sEvent, sFrom, sType);

    int iNumOfDoc = evtdoc.getNumOfDoc();
    String [] sEvtDoc = evtdoc.getEvtDoc();
    String sEvtDocJsa = evtdoc.getEvtDocJsa();

    evtdoc.disconnect();

    //--------------------------------------------------------------------------
    // retreive merchandise memo
    String sMenuGroup = "MERCH";
    if (sType.trim().equals("SIGN")) { sMenuGroup = "SIGNS"; }
    if (sType.trim().equals("TRACK")) { sMenuGroup = "TRACK"; }
  
    MemoMenu menu = new MemoMenu(sMenuGroup);
    int iNumOfMenu = menu.getNumOfMenu();
    String sKey = menu.getKey();
    String sMenu = menu.getMenu();
    String sHasSubMenu = menu.getHasSubMenu();

    menu.disconnect();
%>

<html>
<head>
<title>Event Docs</title>
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

  div.dvPrompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:550; background-color:LemonChiffon; z-index:100;
              text-align:center; font-size:10px}

  div.dvBar  {background: #f0fff0; border-right: lightgrey solid 5px; border-bottom: lightgrey solid 5px;
                   border-style: outset;
                   cursor:hand; background-attachment: scroll;
                   position:absolute; visibility: hidden;text-align:left; font-size:10px}

  .Small{ text-align:left; font-family:Arial; font-size:10px;}
  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
  td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
  td.Prompt { text-align:left; font-family:Arial; font-size:10px; }
  td.Prompt1 { text-align:center; vertical-align:bottom; font-family:Arial; font-size:10px; }
  td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
  td.option { text-align:left; font-size:10px}
</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variable
//==============================================================================
var Event = "<%=sEvent%>"
var From = "<%=sFrom%>"
var Type = "<%=sType%>"
var EvtDoc = [<%=sEvtDocJsa%>]

var NumOfMenu = <%=iNumOfMenu%>;
var Keys = [<%=sKey%>];
var Menu = [<%=sMenu%>];
var HasSubMenu = [<%=sHasSubMenu%>];

var PanelHi = new Array(10);

//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){isSafari = true;}
	
  	setBoxclasses(["BoxName",  "BoxClose"], ["dvPrompt"]);
  	//window.document.focus();
  	<%if(bAuth) {%>showMenu(-1, 0, tbMenu);<%}%>
}
// ------------------------------------------------------
// show main menu - bar style
// ------------------------------------------------------
function showMenu(sel, panel, obj)
{
   var start = 0;
   var div = "dvBar" + panel;

   if(sel >= 0)
   {
     // retrun to initial look and feel
     if(PanelHi[panel] != null)
     {
        PanelHi[panel].style.color ="black";
        PanelHi[panel].style.borderBottom ="none";
     }
     // save selected parent option
     PanelHi[panel] = obj;
     obj.style.color ="red";
     obj.style.borderBottom ="black solid 1px";
   }

   // menu position. calculate position only for not a root menu
   var pos = [100, 100 ];
   pos = clcPosition(obj);
   if(panel > 0) pos[0] += pos[2] + 10
   else pos[0] = 100;

   panel = panel + 1;

   if(sel > 0) start = eval(sel)+1;

   var html = "<table>"

   for(var i = start; i < NumOfMenu; i++)
   {
      if(chkMenu(i, sel))
      {
         if (HasSubMenu[i] == "1") func = "showMenu";
         else func = "getDocs";
         html += "<tr><td class='option' nowrap onClick='" + func + "(" + i + ","
              + panel + ", this)'>" + Menu[i] + "</td></tr>"
      }
   }
   html += "</table>";

   document.all[div].innerHTML=html;
   document.all[div].style.visibility="visible";
   document.all[div].style.width=100;
   document.all[div].style.pixelLeft=pos[0];
   document.all[div].style.pixelTop=pos[1] ;

   hidePanels(panel);
}
//========================================================================
// receive documents
//========================================================================
function getDocs(sel, panel, obj)
{
  // retrun to initial look and feel
  if(PanelHi[panel] != null)
  { 
     PanelHi[panel].style.color ="black";
     PanelHi[panel].style.borderBottom ="none";
  }
  // save selected parent option
  PanelHi[panel] = obj;
  obj.style.color ="red";
  obj.style.borderBottom ="black solid 1px";
  //-------------------------------------------
  var key = Keys[sel];
  
  var url = "EvtServerDoc.jsp?Path=C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/memopool"
  
  for(var i=0; i < key.length; i++)
  {
     if(Type=="SIGN" && key[i] == "DEPART") url += "/Departmental";
     else if(Type=="SIGN" && i == key.length-1) url += "/" + Menu[sel];
     else url += "/" + key[i];
  }

  //alert(url)
  //window.location = url;
  window.frame1.location = url;
}
//========================================================================
// show selected folder documents
//========================================================================
function showDocs(path, num, file)
{
   window.frame1.close();
   var hdr = "Found documents";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"

   html += "<tr><td class='Prompt1' colspan=2>&nbsp;</td></tr>"

   // load event documents
   for(var i=0; i < num; i++)
   {
       html += "<tr><td class='Prompt' colspan=2>" + file[i] + "&nbsp;&nbsp;"
            + "<a href='javascript: addDoc(&#34;" + path + "/" + file[i] + "&#34;)'>Add</a></td></tr>"
   }

   if(num == 0) html += "<tr><td class='Prompt1' colspan=2>No Files was found in folder</td></tr>"

   html += "<tr><td class='Prompt1' colspan=2>&nbsp;</td></tr>"
   html += "<tr><td class='Prompt1' colspan=2>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
        + "</table>"

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvPrompt.style.pixelTop= document.documentElement.scrollTop + 10;
   document.all.dvPrompt.style.visibility = "visible";
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvPrompt.innerHTML = " ";
   document.all.dvPrompt.style.visibility = "hidden";
}
//========================================================================
// attach document to event
//========================================================================
function addDoc(file)
{
   file =  file.replaceSpecChar();

   var url = "EvtDocEnt.jsp?"
           + "Event=" + Event.replaceSpecChar()
           + "&From=" + From
           + "&Type=" + Type;


   if(Type=="SIGN") url += "&Path=" + file.substring(file.lastIndexOf("memopool/"))
   else if(Type=="MEMO") url += "&Path=" + file.substring(file.lastIndexOf("memopool/"))
   else if(Type=="TRACK") url += "&Path=" + file.substring(file.lastIndexOf("memopool/"))

   url += "&Action=ADD";

   //alert(url)
   //window.location.href = url;
   window.frame1.location = url;
}
//========================================================================
// attach document to event
//========================================================================
function dltDoc(arg)
{
	if (confirm("Are You sure you want to delete this document?"))
	{
	  var url = "EvtDocEnt.jsp?"
           + "Event=" + Event.replaceSpecChar()
           + "&From=" + From
           + "&Type=" + Type
           + "&Path=" + EvtDoc[arg].showSpecChar().replaceSpecChar()
           + "&Action=DLT";
   	  //alert(url)
      //window.location.href = url;
      window.frame1.location.href = url;
	}
}
//========================================================================
// check if menu must be shown now
//========================================================================
function chkMenu(chk, sel)
{
   var selkey = null;
   var curkey = Keys[chk];
   var found = false;


   if (sel >= 0)
   {
     selkey = Keys[sel];
     var max = curkey.length-1;
     if(selkey.length < curkey.length)
     {
        for(var i=0; i < curkey.length-1; i++)
        {
           if(curkey[i] != selkey[i]) { found = false; break; }
           else  found = true;
        }
     }
   }
   else
   {
     found = (curkey.length == 1);
   }
   return found;
}
//========================================================================
// check if menu must be shown now
//========================================================================
function hidePanels(start)
{
   var div = "dvBar";
   for(var i = start; i < 10; i++)
   {
     document.all[div+i].style.visibility="hidden";
   }
}
//========================================================================
// Calculate Offset
//========================================================================
function clcPosition(obj)
{
 // object x ,y, w, h.
 var pos = [0, 0, 0, 0];
 pos[2] = obj.offsetWidth
 pos[3] = obj.offsetHeight

 if (obj.offsetParent) {
   while (obj.offsetParent){
     pos[0] += obj.offsetLeft
     pos[1] += obj.offsetTop
     obj = obj.offsetParent;
   }
 }
 else if (obj.x) {
    pos[0] += obj.x;
    pos[1] += obj.y;
 }

 return pos;
}
//--------------------------------------------------------
// restart page after entry done
//--------------------------------------------------------
function reStart()
{
  window.location.reload();
}
//--------------------------------------------------------
// display error for entry
//--------------------------------------------------------
function displayError(Error)
{
   alert(Error)
}
//--------------------------------------------------------
// show document on link
//--------------------------------------------------------
function showUrl(url)
{
  url = url.replaceSpecChar();
  var WindowName = 'MultipleEntry';
  var WindowOptions =
   'width=600,height=500, left=100,top=50, resizable=yes , toolbar=yes, location=yes, directories=no, status=yes, scrollbars=yes,menubar=yes';
  //alert(url)
  window.open(url, WindowName, WindowOptions);
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
<!-------------------------------------------------------------------->
<div id="dvBar0" class="dvBar" ></div>
<div id="dvBar1" class="dvBar" ></div>
<div id="dvBar2" class="dvBar" ></div>
<div id="dvBar3" class="dvBar" ></div>
<div id="dvBar4" class="dvBar" ></div>
<div id="dvBar5" class="dvBar" ></div>
<div id="dvBar6" class="dvBar" ></div>
<div id="dvBar7" class="dvBar" ></div>
<div id="dvBar8" class="dvBar" ></div>
<div id="dvBar9" class="dvBar" ></div>
<div id="dvBar10" class="dvBar" ></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Event Calendar - Attached Document List
       <br><%=sEvent%>&nbsp; From: <%=sFrom%>
       <br>Document type: <%=sType%><br>
       </b>

        <a href="../"><font color="red" size="-1">Home</font></a>;
        <!----------------- start of ad table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0">
           <thead style="overflow: visible;">
             <tr class="DataTable">
               <th class="DataTable" rowspan=2 >Document</th>
               <%if(bAuth) {%><th class="DataTable" rowspan=2 >D<br>l<br>t</th><%}%>
             </tr>
           </thead>

           <!--------------------- Event Detail ----------------------------->
           <tbody>
           <%for(int i=0; i < iNumOfDoc; i++){%>
              <%
                 String sPath = sEvtDoc[i];
              	 if(sPath.indexOf("ROOT") < 0)
                 {
             	    sPath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/" + sPath.trim();
                 } 
                 File f = new File(sPath);
                 
                 String sRelPath = sPath.trim(); 
                 if(sPath.indexOf("ROOT") >= 0)
                 {
                	 sRelPath = sPath.substring(sPath.indexOf("ROOT") + 5).trim();
                 }
                 System.out.println("path=" + sRelPath + "\nexists=" + f.exists());
              %>
              <tr class="DataTable2">
                <td class="DataTable" nowrap>
                  <%if(f.exists()){%><a href="javascript:showUrl('<%=sRelPath%>')"><%=sEvtDoc[i].substring(sEvtDoc[i].lastIndexOf("/") + 1)%><%}
                    else {%><%=sEvtDoc[i].substring(sEvtDoc[i].lastIndexOf("/") + 1)%>(not exists)<%}%>
                </td>
                <%if(bAuth) {%>
                    <td class="DataTable" nowrap><a href="javascript:dltDoc(<%=i%>)">D</a></td>
                <%}%>
              </tr>
           <%}%>
           <%if(iNumOfDoc==0) {%>
              <tr class="DataTable2"><td class="DataTable" nowrap colspan=2>No documents attached to the event.</td></tr>
           <%}%>
           </tbody>
         </table>
         <!----------------- start of ad table ------------------------>
         <br><br><table id="tbMenu"><tr><td></td></tr></table>

      </td>
     </tr>
    </table>
  </body>
</html>
<%}%>