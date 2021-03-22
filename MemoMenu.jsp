<%@ page import="memopool.MemoMenu, java.util.*"%>
<%
    String sMemoGroup = request.getParameter("Group");

    MemoMenu menu = new MemoMenu(sMemoGroup);
    int iNumOfMenu = menu.getNumOfMenu();
    String sKey = menu.getKey();
    String sMenu = menu.getMenu();
    String sHasSubMenu = menu.getHasSubMenu();

    menu.disconnect();
%>


<HTML>
<TITLE>RCI Intranet Home Page</TITLE>
<HEAD>
     <style type="text/css">
       body {background:ivory;}
       a.blue:visited {  font-weight: bold; color: #663399}
       a.blue:link {  font-weight: bold; color: #0000FF}

       td.option { text-align:left; font-size:12px}

       div.dvBar  {background: #f0fff0; border-right: lightgrey solid 5px; border-bottom: lightgrey solid 5px;
                   border-style: outset;
                   cursor:hand; background-attachment: scroll;
                   position:absolute; visibility: hidden;text-align:left; font-size:18px}

     </style>
</HEAD>
<script language="JavaScript1.2">
var MemoGroup = "<%=sMemoGroup%>";
var NumOfMenu = <%=iNumOfMenu%>;
var Keys = [<%=sKey%>];
var Menu = [<%=sMenu%>];
var HasSubMenu = [<%=sHasSubMenu%>];

var PanelHi = new Array(10);
// ------------------------------------------------------
// run for body on load
// ------------------------------------------------------
function bodyLoad()
{
    showMenu(-1, 0, null);
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
   var pos = [100, 100];
   if(panel > 0)
   {
     pos = clcPosition(obj);
     pos[0] += pos[2] + 10
   }

   panel = panel + 1;

   if(sel > 0) start = eval(sel)+1;

   var html = "<table>"

   for(var i = start; i < NumOfMenu; i++)
   {
      if(chkMenu(i, sel))
      {
         if (HasSubMenu[i] == "1") func = "showMenu";
         else func = "showDocs";
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
// Show documents
//========================================================================
function showDocs(sel, panel, obj)
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
  var url = "MemoDoc.jsp?Path=C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/"
  //var url = "MemoDoc.jsp?Path=/var/tomcat4/webapps/ROOT/"

  url += "&Folder=memopool"; 
  

  for(var i=0; i < key.length; i++)
  {
     url += "&Key=" + key[i];
  }

  var WindowName = 'Memo_Documents';
  var WindowOptions =
   'width=900,height=600, left=20,top=50, resizable=yes , toolbar=yes, location=yes, directories=yes, status=yes, scrollbars=yes,menubar=yes';

  //alert(url)
  window.open(url, WindowName, WindowOptions);
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

</script>



<body id="Body" onload="bodyLoad();">
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


<!-------------------------------------------------------------------->
<Table Border=0 CELLSPACING="0" CELLPADDING="0" width="100%">
  <tr>
    <td colspan="2" align="center">
        <b>RETAIL CONCEPTS, INC.
        <br>
        <%if(sMemoGroup.equals("MERCH")){%>Directives Uploading Document<%}
          else if(sMemoGroup.equals("MANIFEST")){%>Manifest Uploading Document<%}           
          else if(sMemoGroup.equals("TRACK")){%>Track Uploading Document<%}%>
        </b>
    </td>
  <tr>
      <td valign="top" align="center"><a href="../"><font color="red" size="-1">Home</font></a></td>
  </tr>
  <tr>
      <td valign="top" align="left"><font size="-1">Click on Menu option to see subfolder or documents list.</td>
  </tr>
</TABLE>
</body>
</HTML>
