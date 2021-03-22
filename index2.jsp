<%@ page import="menu.MainMenu, menu.MenuTableOfContent, java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=index2.jsp&APPL=ALL");
}

else {
    String sUser = session.getAttribute("USER").toString();
    MainMenu menu = new MainMenu("vrozen");
    int iNumOfMenu = menu.getNumOfMenu();
    String [] sMenu = menu.getMenu();
    String [] sUrl = menu.getUrl();
    String [] sType = menu.getType();

    int [] iNumOfChild = menu.getNumOfChild();
    String [][] sChildMenu = menu.getChildMenu();
    String [][] sChildUrl = menu.getChildUrl();
    String [][] sChildType = menu.getChildType();

    menu.disconnect();

    // All menu options
    MenuTableOfContent menuAll = new MenuTableOfContent("vrozen");
    int iNumOfAllMenu = menuAll.getNumOfMenu();
    String [] sAllMenu = menuAll.getMenu();
    int [] iAllLevel = menuAll.getLevel();
    String [] sAllUrl = menuAll.getUrl();
    String [] sAllType = menuAll.getType();

    menuAll.disconnect();


    boolean bMsgAuth = false;
    if(session.getAttribute("STRBMALL")!=null)  bMsgAuth = true;

%>
<HTML>
<TITLE>RCI Intranet Home Page</TITLE>
<HEAD>
 <style type="text/css">
       body {background:white;}

       a.blue:visited {  color: blue}
       a.blue:link {  bold; color: blue}
       a.blue:hover { color:red}

       a.white:visited {  font-weight: bold; color: white}
       a.white:link {  font-weight: bold; color: white}
       a.white:hover { color:yellow}

       th.sep1 { border: 1px; border-style: outset; background: #6699CF;
                 text-align:center; font-family:Verdanda; font-size:18px }
       td.sep1 { padding-left:95px; padding-bottom:5px; text-align:left; font-family:Verdanda; font-size:12px }
       td.sep2 { border-bottom: black solid 1px; padding-left:5px; text-align:left; font-family:Verdanda; font-size:12px }
       td.sep4 { background-image:url('Sun_ski_logo1.jpg'); filter:alpha(opacity=25);-moz-opacity:.25;opacity:.25;
                 padding-left:5px; font-size:26px; text-align:left; font-weight: bolder}

       table.panel { border-top: none;}

       td.panel0 {  background:ivory; border: 1px; border-style: outset; text-align:left; vertical-align:top}
       td.panel1 { background:ead0cc; border: 1px; border-style: outset; text-align:left; vertical-align:top}
       td.panel2 { background:addfff; border: 1px; border-style: outset; text-align:left; vertical-align:top}
       td.panel3 { background:salmon; border: 1px; border-style: outset; text-align:left; vertical-align:top}
       td.panel4 { background:fff380; border: 1px; border-style: outset; text-align:left; vertical-align:top}
       td.panel5 { background:8eebec; border: 1px; border-style: outset; text-align:left; vertical-align:top}
       td.panel6 { background:ccfb5d; border: 1px; border-style: outset; text-align:left; vertical-align:top}
       td.panel7 { background:yellow; border: 1px; border-style: outset; text-align:left; vertical-align:top}
       td.panel8 { background:fff9fa; border: 1px; border-style: outset; text-align:left; vertical-align:top}
       td.panel9 { background:e9cfec; border: 1px; border-style: outset; text-align:left; vertical-align:top}
       td.panel10 { background:ivory; border: 1px; border-style: outset; text-align:left; vertical-align:top}
       td.panel11 { background:ead0cc; border: 1px; border-style: outset; text-align:left; vertical-align:top}
       td.panel12 { background:addfff; border: 1px; border-style: outset; text-align:left; vertical-align:top}
       td.panel13 { background:salmon; border: 1px; border-style: outset; text-align:left; vertical-align:top}

       td.panel14 { background:fff380; border: 1px; border-style: outset; text-align:left; vertical-align:top}
       td.panel15 { background:8eebec; border: 1px; border-style: outset; text-align:left; vertical-align:top}
       td.panel16 { background:ccfb5d; border: 1px; border-style: outset; text-align:left; vertical-align:top}
       td.panel17 { background:f76541; border: 1px; border-style: outset; text-align:left; vertical-align:top}
       td.panel18 { background:fff9fa;border: 1px; border-style: outset; text-align:left; vertical-align:top}
       td.panel19 { background:e9cfec; border: 1px; border-style: outset; text-align:left; vertical-align:top}

       table.menu { border:none; }
       td.menu { cursor:hand; text-align:left; font-size:12px; font-weight: bold; }
       span.menu { cursor:hand; text-align:left; font-size:12px; font-weight: bold; text-decoration:underline}
       td.menu1 {  cursor:hand; text-align:left; font-size:12px; }
       td.menu2 {  cursor:hand; text-align:right; font-size:12px; }


       table.msg { border:2px; border-style: outset;  background:LightSteelBlue;}
       td.msg { text-align:left; font-size:10px; text-decoration:underline }
       td.msg1 { border:2px; border-style: ridge; text-align:center; font-size:10px }
       td.msg2 { text-align:center; font-size:10px }
       td.misc { background:eff7ff; border:2px; border-style: ridge; text-align:left; font-size:10px}

       td.misc1{ filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr=#1528a7, endColorStr=#0066ff,
                 gradientType=0);   padding-botton:5px; padding-top:5px; border:darkblue 1px solid;
                 color: white; text-align:center; font-size:12px; font-weight:bold }
       td.misc2{ filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr=#c3fdb8, endColorStr=lightgreen,
                 gradientType=0);
                 color: darkblue; text-align:center; font-size:12px; font-weight:bold }
       td.misc3{ filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr=ivory, endColorStr=#fff380,
                 gradientType=0);
                 color: darkblue; text-align:center; font-size:12px; font-weight:bold }

       td.img { border:white 2px; border-style: outset;text-align:left;}

       img.skier {border:0px;}
       div.dvBar  {background: #f1f1f1; border-right: lightgrey solid 5px; border-bottom: lightgrey solid 5px;
                   border-style: outset;
                   cursor:hand; background-attachment: scroll;
                   position:absolute; visibility: hidden;text-align:left; font-size:18px}

       div.Test  {background: gainsboro; border: #6699CF 1px; border-style: outset; cursor:hand; background-attachment: scroll;
                   position:absolute; text-align:left; font-size:10px}
</style>

</HEAD>

<script language="JavaScript1.2">
var SchStrLst;
var SchRcpLst;
var SchNumReq;
var SchNumRsp;
var SchOldest;

var StBStrLst;
var StBStrNameLst;
var StBRcpLst;
var StBNumReq;
var StBNumRsp;
var StBOldest;
var StBWeek;

var initNumMenu = <%=iNumOfMenu%>;
var Menu = new Array();
var Url = new Array();
var Type = new Array();
var Option = null;
var dvMenuId = 0;
var MenuArr = new Array();
var nextMenu=0;
var CurMenu = new Array();
// ------------------------------------------------------
// run for body on load
// ------------------------------------------------------
function bodyLoad()
{
  disp_Table_Of_Content(false);
  switch_Off_onload();
  chkSchMsgBoard();
  chkStBMsgBoard();
  chkTransfer();
}
// ------------------------------------------------------
// populate main menu - bar style
// ------------------------------------------------------
function popMainMenuBar(parent, root, obj)
{
  Option = obj;
  // if menu found get it from menu object, otherwise retreive it from server
  var arg = isMenuAlreadyRetreived(parent)
  if(arg > -1)
  {
     showMenuBar(root, MenuArr[arg].getOptions(), MenuArr[arg].getUrl(), MenuArr[arg].getType(), false);
  }
  else
  {
    var MyURL = "GetChieldMenu.jsp?Parent=";
    if (parent==null) MyURL += " " + "&Root=" + root;
    else MyURL += parent + "&Root=" + root;
    MyURL += "&User=<%=sUser%>";

    //alert(MyURL)
    window.frame3.location = MyURL;
  }
}

// ------------------------------------------------------
// check, if menu already saved
// ------------------------------------------------------
function isMenuAlreadyRetreived(parent)
{
   if (parent==null) parent="MAIN"
   var arg = -1;
   for(var i=0; i < MenuArr.length; i++)
   {
      if(MenuArr[i].name == parent)
      {
        arg=i;
        break;
      }
   }
   return arg;
}
// ------------------------------------------------------
// click on child menu
// ------------------------------------------------------
function click_On_Menu(menu, type, url, cell)
{
   if (type==0) {  popMainMenuBar(menu, true, cell); }
   else { window.location.href=url; }
}
// ------------------------------------------------------
// set main menu - bar style
// ------------------------------------------------------
function setMenuBar(parent, menu, url, type, save)
{
   MenuArr[nextMenu++] = new oMenu( parent, menu, type, url);
}
// ------------------------------------------------------
// show main menu - bar style
// ------------------------------------------------------
function showMenuBar(root, menu, url, type, close)
{
   Menu = menu;
   Url = url;
   Type = type;

  var main = "<table CELLSPACING='0' CELLPADDING='0' id='tbMain'>"
  var action = null;
  var size = "12px";

  // undisplay all menu if clicked from 1st level submenu
  if(root)
  {
     for(var i=0; i < 10; i++)
     {
      div = "dvBar" + i;
      document.all[div].style.visibility = "hidden";
     }
     dvMenuId = 0;
  }

  var i=0;
  for(i=0; i<Menu.length; i++)
  {
     main += "<tr><td style='padding-bottom:5px; color:black; font-size:" + size +"'"
          + " id='mb" + i + "'";

     if (Type[i]==0)
     {
       main += " onmouseover='hilightOpt(this, true);' "
            + " onClick='removeMenu(this, true); popMainMenuBar(&#34;" + Menu[i] + "&#34;, false, this)'";
     }
     else
     {
       main += " onmouseover='hilightOpt(this, true);'";
       main += " onClick='removeMenu(this, true); window.location.href=&#34;" + Url[i] + "&#34;'";
     }


     main += " onmouseout='hilightOpt(this, false)' nowrap>" + Menu[i] + "&nbsp;&nbsp;</td></tr>"
  }

  if(Menu.length==0)
  {
     main += "<tr><td style='padding-bottom:5px; color:black; font-size:12px'"
          + " id='mb" + i++ + "'>&nbsp;&nbsp;future use&nbsp;&nbsp;</td></tr>";
  }

  main += "<tr><td style='padding-bottom:5px; color:darkblue; font-size:12px; text-decoration:underline; text-align:center'"
          + " id='mb" + i + "' onClick='removeMenu(this, false);'>Close</td></tr>";

  main += "</table>"
  var div = "dvBar0";
  var pos = null;
  try  {
      div = "dvBar" + eval(dvMenuId+1);
      pos = clcPosition(Option);
      pos[0] += pos[2]+1;

      if(pos[1] + Menu.length * 27 > screen.height)
      {
         pos[1] = screen.height - Menu.length * 30;
         if(pos[1] <= 0)  pos[1] = 20;
      }
      dvMenuId = eval(dvMenuId) + 1;
     document.all[div].style.visibility="visible";
     document.all[div].style.width=100;
     document.all[div].style.pixelLeft=pos[0];
     document.all[div].style.pixelTop=pos[1] ;
     document.all[div].innerHTML=main

    if(close) window.frame3.location = null;
  }
  catch(e) { alert("showMenuBar\n Div="  + div + "\n" + e.name + "\n" + e.message) }
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
   while (obj.offsetParent)
   {
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
// ------------------------------------------------------
// hilight option
// ------------------------------------------------------
function hilightOpt(obj, on, url)
{
   //font-weight:bold
   if (on)
   {
     obj.style.color="darkred";
     if(url != null && url.trim() != "") self.status = url
     else if(url != null && url.trim() == "") self.status = "Menu"
   }
   else
   {
     obj.style.color="black";
     self.status = " ";
   }
}
// ------------------------------------------------------
// change look anfd feel of menu option on mouseover event.
// ------------------------------------------------------
function chgOptionLook(mn, op)
{
  for(var i=0; i<Content[mn].length; i++)
  {
    if(op==i)
    {
      document.all["op"+i].style.color="darkred"
      document.all["op"+i].style.textDecoration="underline"
    }
    else
    {
      document.all["op"+i].style.color="black"
      document.all["op"+i].style.textDecoration="none"
    }
  }
}
// ------------------------------------------------------
// display menu content
// ------------------------------------------------------
function dspOption(mn, i)
{
  var url = Link[mn][i];
  window.location.href=url
}
// ------------------------------------------------------
// load current transfer request
// ------------------------------------------------------
function chkTransfer()
{
 var MyURL = "StrTrfSum.jsp";

  //alert(MyURL)
  //window.location.href = MyURL;
  window.frame2.location = MyURL;
}
// ------------------------------------------------------
// set transfer summary
// ------------------------------------------------------
function setTrfSum(str, avl, avlDate, inp, inpDate, destDiv, destQty)
{
     //alert(str + "\n" + avl + "\n" + avlDate + "\n" + inp + "\n" + inpDate)
     var trfTbl = "<table class='msg'>"
             + "<tr><td class='msg1' colspan=7 nowarp ><a class='blue' "
             + "href='DivTrfReqSel.jsp'>Manage Item Transfers</a></td></tr>"
             + "<tr><td class='msg1' rowspan='2'>Str</td>"
             + "<td class='msg1' colspan='2'>Not Printed</td>"
             + "<td class='msg1' colspan='2'>Not Completed</td>"
             + "<td class='msg1' colspan='2'>Total<br>Incoming</td>"
             + "</tr>"
             + "<tr>"
             + "<td class='msg1'>#</td><td class='msg1'>Oldest<br>Date</td>"
             + "<td class='msg1'>#</td><td class='msg1'>Oldest<br>Date</td>"
             + "<td class='msg1'># of Div</td><td class='msg1'>Unit</td>"
             + "</tr>"

  for(var i=0; i < str.length; i++)
  {
    trfTbl += "<tr>"
    if(str[i] != "100")
    {
       trfTbl += "<td class='msg2'><a href='DivTrfGrpSum.jsp?DIVISION=ALL&STORE="
           + str[i] + "'>" + str[i] + "</a></td>"
    }
    else trfTbl += "<td class='msg2'>" + str[i] + "</td>"
    trfTbl += "<td class='msg2'>" + avl[i] + "</td>"
           + "<td class='msg2'>" + avlDate[i] + "</td>"
           + "<td class='msg2'>" + inp[i] + "</td>"
           + "<td class='msg2'>" + inpDate[i] + "</td>"
           + "<td class='msg2'>" + destDiv[i] + "</td>"
           + "<td class='msg2'>" + destQty[i] + "</td>"
           + "</tr>"
  }
  trfTbl += "</table>";

  document.all.ItemTrf.innerHTML=trfTbl
  document.all.linkItemTrf.style.display="block"
  window.frame2.location = null;
}
// ------------------------------------------------------
// display / hide Schedule Message Board
// ------------------------------------------------------
function display_hide_ItemTrf()
{
   if(document.all.ItemTrf.style.display=="block")  document.all.ItemTrf.style.display="none";
   else document.all.ItemTrf.style.display="block";
}
// ---------------------- Check Message board --------------------------------
function chkSchMsgBoard()
{
  var MyURL = "NewMsgLst.jsp?Self=Yes";
  //alert(MyURL)
  window.frame1.location = MyURL;
  this.focus();
}
// ------------------------------------------------------
// populate message board parameters
// ------------------------------------------------------
function setSchNewMsg(Store, Recepient, NumOfReq, NumOfRsp, OldDate)
{
  SchStrLst = Store;
  SchRcpLst = Recepient;
  SchNumReq = NumOfReq;
  SchNumRsp = NumOfRsp;
  SchOldest = OldDate;
  popNewSchMsgTbl();
  window.frame1.location = null;
}
// ------------------------------------------------------
// populate new mesage table
// ------------------------------------------------------
function popNewSchMsgTbl(){
  var msgTbl = "<table class='msg'>"
             + "<tr><td class='msg1' colspan=5 nowarp ><a class='blue' href='ForumSum.jsp'>Message board - Pending</a></td></tr>"
             + "<tr><td class='msg1'>Str</td>"
             + "<td class='msg1' >User</td>"
             + "<td class='msg1' >Oldest</td>"
             + "<td class='msg1'>New</td>"
             + "<td class='msg1'>Reply</td></tr>";
  for(i=0; i < SchStrLst.length; i++)
  {
    msgTbl += "<tr>"
           + "<td class='msg2'>" + SchStrLst[i] + "</td>"
           + "<td class='msg' nowrap>" + SchRcpLst[i] + "</td>"
           + "<td class='msg2'>" + SchOldest[i] + "</td>"
           + "<td class='msg2'>" + SchNumReq[i] + "</td>"
           + "<td class='msg2'>" + SchNumRsp[i] + "</td>"
           + "</tr>"
  }
  msgTbl += "</table>";
  document.all.SchMsgBoard.innerHTML=msgTbl
  document.all.linkSchMsgBoard.style.display="block"
}
// ------------------------------------------------------
// display / hide Schedule Message Board
// ------------------------------------------------------
function display_hide_SchMsgBoard()
{
   if(document.all.SchMsgBoard.style.display=="block")  document.all.SchMsgBoard.style.display="none";
   else document.all.SchMsgBoard.style.display="block";
}
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
// Check Store/Buyer Message board
// ----------------------------------------------------------------------------
function chkStBMsgBoard()
{
  <%if( !bMsgAuth ){%>  var URL = "StBNewUsrMsgLst.jsp?User=<%=sUser%>"; <%}
    else {%>  var URL = "StBNewMsgLst.jsp?User=<%=sUser%>"; <%}%>
  //alert(URL)
  //window.location = URL;
  window.frame4.location = URL;
}
// ------------------------------------------------------
// populate message board parameters
// ------------------------------------------------------
function setStBNewMsg(Store, StrName, Recepient, NumOfReq, NumOfRsp, OldDate, Week)
{
  StBStrLst = Store;
  StBStrNameLst = StrName;
  StBRcpLst = Recepient;
  StBNumReq = NumOfReq;
  StBNumRsp = NumOfRsp;
  StBOldest = OldDate;
  StBWeek = Week;

  popNewStBMsgTbl();
  window.frame4.location = null;
}
// ------------------------------------------------------
// populate new mesage table
// ------------------------------------------------------
function popNewStBMsgTbl(){
  var msgTbl = "<table class='msg'>"
             + "<tr><td class='msg1' colspan=5 nowarp ><a class='blue' href='StBMsgSum.jsp'>Message board - Pending</a></td></tr>"
             + "<tr><td class='msg1'>Str</td>"
             + "<td class='msg1' >User</td>"
             + "<td class='msg1' >Oldest</td>"
             + "<td class='msg1'>New</td>"
             + "<td class='msg1'>Reply</td></tr>";
  for(i=0; i < StBStrLst.length; i++)
  {
    msgTbl += "<tr>"
           + "<td class='msg2'>" + StBStrLst[i] + "</td>"
           + "<td class='msg' nowrap><a href='javascript: showStrWkMsgB(" + i + ")'>" + StBRcpLst[i] + "</a></td>"
           + "<td class='msg2'>" + StBOldest[i] + "</td>"
           + "<td class='msg2'>" + StBNumReq[i] + "</td>"
           + "<td class='msg2'>" + StBNumRsp[i] + "</td>"
           + "</tr>"
  }
  msgTbl += "</table>";
  document.all.StBMsgBoard.innerHTML=msgTbl
  document.all.linkStBMsgBoard.style.display="block"
}
// ------------------------------------------------------
// display / hide Schedule Message Board
// ------------------------------------------------------
function display_hide_StBMsgBoard()
{
   if(document.all.StBMsgBoard.style.display=="block")  document.all.StBMsgBoard.style.display="none";
   else document.all.StBMsgBoard.style.display="block";
}
// ------------------------------------------------------
// show Str/week message board
// ------------------------------------------------------
function showStrWkMsgB(arg)
{
   var url = "StrBuyerMsgBoard.jsp?Store=" + StBStrLst[arg]
           + "&StrName=" + StBStrNameLst[arg]
           + "&Weekend=" + StBWeek[arg]
   //alert(url)
   window.location.href = url;
}
// ------------------------------------------------------
// end store/buyer message board
// ------------------------------------------------------

// ------------------------------------------------------
// remove unused next menu
// ------------------------------------------------------
function removeMenu(obj, submenu)
{
   var div = null;
   var divnum = null;

   // retreive current div Id
   while (obj.offsetParent)
   {
     if (obj.id.substring(0, 5)=="dvBar")
     {
       divnum = eval(obj.id.substring(5));
       break;
     }
     obj = obj.offsetParent;
   }

   // remove unused
   try
   {
      if(submenu) divnum += 1;
      for(var i=divnum; i < 10; i++)
      {
         div = "dvBar" + i;
         document.all[div].style.visibility = "hidden";
      }
      dvMenuId = divnum;
   }
   catch (e) { alert("Div=" + div + "\n" + e.message) }
}
// ---------------------- End Message board -------------------------------
// ------------------------------------------------------
// Menu object
// ------------------------------------------------------
function oMenu( name, options, type, url)
{
  if(name==null) name="MAIN";
  this.name = name;
  this.options = options;
  this.type = type;
  this.url = url;
}
// ------------------------------------------------------
// Menu object - get URL
// ------------------------------------------------------
oMenu.prototype.show = function()
{
   alert("Menu: " + this.name + "\nOption: " + this.options + "\nType: " + this.type + "\nURL: " + this.url)
}
// ------------------------------------------------------
// Menu object - get Options
// ------------------------------------------------------
oMenu.prototype.getOptions= function()
{
  var arr = new Array();
  for(var i=0; i < this.options.length;i++)  {  arr[i] = this.options[i]  }
  return arr;
}
// ------------------------------------------------------
// Menu object - get Options Type - menu, link
// ------------------------------------------------------
oMenu.prototype.getType= function()
{
  var arr = new Array();
  for(var i=0; i < this.type.length;i++) { arr[i] = this.type[i]; }
  return arr;
}
// ------------------------------------------------------
// Menu object - get Url
// ------------------------------------------------------
oMenu.prototype.getUrl= function()
{
  var arr = new Array();
  for(var i=0; i < this.url.length; i++) { arr[i] = this.url[i]; }
  return arr;
}
// ------------------------------------------------------
// fold unfold submenu
// ------------------------------------------------------
function switch_On_Off_SubMenu(tbl)
{
   var tblId = "tblMenu" + tbl;
   var status = document.all[tblId].style.display
   if(status=="block") { document.all[tblId].style.display="none" }
   else { document.all[tblId].style.display="block" }
}
// ------------------------------------------------------
// fold unfold submenu
// ------------------------------------------------------
function switch_Off_onload()
{
   var tblId = "tblMenu";
   for(var i=0; i < initNumMenu; i++)
   {
      var tblId = "tblMenu" + i;
      document.all[tblId].style.display="none";
   }
}
// ------------------------------------------------------
// display initial submenu
// ------------------------------------------------------
function disp_All_SubMenu()
{
   for(var i=0; i < initNumMenu; i++)
   {
      var tblId = "tblMenu" + i;
      document.all[tblId].style.display="block";
   }
}

// ------------------------------------------------------
// colapse initial submenu
// ------------------------------------------------------
function colapse_All_SubMenu()
{
   for(var i=0; i < initNumMenu; i++)
   {
      var tblId = "tblMenu" + i;
      document.all[tblId].style.display="none";
   }
}

// ------------------------------------------------------
// display Table of content
// ------------------------------------------------------
function disp_Table_Of_Content(dsp)
{
   if(dsp)
   {
     document.all.tblMenu.style.display="none";
     document.all.spMenu.style.display="none";
     document.all.tdAllMenu.style.display="block";
   }
   else
   {
     document.all.tblMenu.style.display="block";
     document.all.spMenu.style.display="inline";
     document.all.tdAllMenu.style.display="none";
   }
}

</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

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
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame2"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame3"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame4"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<Table Border=0 CELLSPACING="5" CELLPADDING="0" width="100%" height="100%">
<tr>
    <td WIDTH="20%"  valign="top" rowspan="2" bgColor="deecec" class='msg1'>
    <table width="100%">
      <tr><td class='misc1'>Miscellaneous</td></tr>
      <tr>
        <td class='misc'>
          <a class="blue" href="MAILTO:">Send e-mail</a>
          <br><a class="blue" href="http://sunandski.com/">Our Internet</a>
          <br><a class="blue" href="JobList.jsp">Operator Panel</a>
          <br><a class="blue" href="FileUtilitySel.jsp">File Utility</a>
        </td>
      </tr>
    </table>
  <!-- World Cup -->
    <!-- a class="blue" href="ShowGame.jsp">
      <img class="skier" src="Skier.jpg" alt="World Cup" width="80" height="80">
      <br>World Cup Contest</a -->
    <!--   End World Cup -->


  <table width="100%" border=1>
   <!--tr><td class='misc1' nowarp-->
       <!-- ITSA Contest -->
        <!-- a class="blue" href="ItsaContest.jsp">
        <img class="skier" src="winning.jpg" alt="ITSA" width="40" height="40">
        <br>ITSA Contest</a -->
       <!--   End Itsa contest -->
      <!--/td-->
      <td class='misc1' nowarp>
       <!-- Hand and Toe Warmer Contest -->
        <!--a class="blue" href="HandToeWarmerContest.jsp">
        <img class="skier" src="Warmer.gif" alt="Hand and Toe Warmer" width="40" height="40">
        <br>Hand and Toe<br>Warmer Contest</a -->
       <!--   End Hand and Toe Warmer Contest -->
       <!--/td-->
       <!--/tr-->

       <tr><td class='misc2' nowarp>What's new?
             <br><a href="SalesBySkuSel.jsp">Return Validation</a>
             <br><a href="SlsRelSel.jsp">Sales Relation Report</a>
             <br><a href="FlashSalesSel.jsp">Flash Sales Reports</a><br>
         </td>
       </tr>

       <tr><td class='misc3' nowarp><b>Company Holidays</b>
             <br><a href="PolicyAndForms/Policy/Holiday Schedule 2005.htm">2005 Holidays</a>
             <br><a href="PolicyAndForms/Policy/Holiday Schedule 2006.htm">2006 Holidays</a>
            </td>
       </tr>

    </td></tr></table>

    <br><a id="linkSchMsgBoard" style="display:none;" class="blue" href="javascript: display_hide_SchMsgBoard()">Display/Hide Scheduale Message Board</a>
    <a class="blue" id="linkStBMsgBoard" style="display:none;" href="javascript: display_hide_StBMsgBoard()">Display/Hide Store/Buyer Message Board</a>
    <a class="blue" id="linkItemTrf" style="display:none;" href="javascript: display_hide_ItemTrf()">Display/Hide Item Transfers</a>

    <!-- ---------------------------------------------------------------------------------- -->
    <!-- Scheduale Message board -->
    <!-- ---------------------------------------------------------------------------------- -->
    <div id="SchMsgBoard" style="display:none;"></div>
    <!-- End New Message List Table -->
    <!-- ---------------------------------------------------------------------------------- -->
    <!-- Scheduale Message board -->
    <!-- ---------------------------------------------------------------------------------- -->
    <br><div id="StBMsgBoard" style="display:none;"></div>
    <!-- End New Message List Table -->
    <!-- ---------------------------------------------------------------------------------- -->
    <!-- Item transfer List-->
    <!-- ---------------------------------------------------------------------------------- -->
    <br><div id="ItemTrf" style="display:none;"></div>
    <!-- End Item Transfer List -->
    </font></td>

    <!-- ---------------------------------------------------------------------------------- -->
    <!--td COLSPAN=2 class='img' valign="top">
        <img src="Sun_ski_logo1.jpg"></td -->
    <td class="misc" nowrap valign="top">
        <Table Border=0 CELLSPACING="0" CELLPADDING="0" width="100%">
        <tr>
          <td class="sep4" colspan="2">
          <p style="text-align:justify;position:relative;top:-1px;color:black;" >
          RETAIL CONCEPTS, INC.</p><br><br></td>
        </tr>
<!-- ================================================================ -->
<!--          blue divider -->
<!-- ================================================================ -->
 <tr>
   <td class="misc1" valign="top" >
        <span id="spMenu">
           <a class="white" href="javascript:disp_All_SubMenu()">Display</a>/<a class="white" href="javascript:colapse_All_SubMenu()">Collapse</a> Sub-Menus &nbsp;&nbsp;&nbsp;
        </span>
        <a class="white" href="javascript:disp_Table_Of_Content(true)">Table of content</a>/
        <a class="white" href="javascript:disp_Table_Of_Content(false)">Menu</a>
   </td>
 </tr>
<!-- ================================================================ -->
<!--                 Main Panel -->
<!-- ================================================================ -->
 <tr>
   <td valign="top" id="tdMenu">

    <table class="panel"  id="tblMenu" CELLSPACING="10" CELLPADDING="0" width=100%>
      <%int iTd = 0;%>
      <%for(int i=0; i < iNumOfMenu; i++){%>
        <%if(iTd == 0){%><tr><%}%>
           <td  class="panel<%=i%>">
             <span class="menu" onClick="switch_On_Off_SubMenu(<%=i%>)"><%=sMenu[i]%></span>

             <table id="tblMenu<%=i%>" class="menu" CELLSPACING="0" CELLPADDING="0">
               <!-- -----------  menu option ------------------------------  -->
               <!-- if main menu option is URL duplicate as menu option -->
               <%if(iNumOfChild[i]==0 && sType[i].equals("1")){%>
                   <tr><td class="menu1" onmouseover="hilightOpt(this, true, '<%=sUrl[i]%>');" onmouseout="hilightOpt(this, false)"
                    onClick="click_On_Menu('<%=sMenu[i]%>', '<%=sType[i]%>', '<%=sUrl[i]%>', this)" nowrap>
                     &nbsp;&nbsp;<%=sMenu[i]%></td><tr>
               <%}
               else if(iNumOfChild[i]==0 && sType[i].equals("0")){%>
                    <tr><td class="menu1" onmouseover="hilightOpt(this, true);" onmouseout="hilightOpt(this, false)"  nowrap>
                     &nbsp;&nbsp;<i>future use</i></td><tr>
               <%}%>

               <!-- -----------  2nd level menu option ------------------------------  -->
               <%for(int j=0; j < iNumOfChild[i]; j++) {%>
                  <tr><td class="menu1" onmouseover="hilightOpt(this, true, '<%=sChildUrl[i][j]%>');" onmouseout="hilightOpt(this, false)"
                    onClick="click_On_Menu('<%=sChildMenu[i][j]%>', '<%=sChildType[i][j]%>', '<%=sChildUrl[i][j]%>', this)"  nowrap>
                     &nbsp;&nbsp;<%=sChildMenu[i][j]%></td><tr>
               <%}%>
             </table>
         </td>
       <%if(iTd == 3){ iTd = 0;%></tr><%} else iTd++;%>
      <%}%>
     <!-- ================================================================ -->
    </table>
  </td>
 </tr>
    <!-- ================================================================ -->
    <!--                 Table of Content -->
    <!-- ================================================================ -->
    <tr>
      <td valign="top" id="tdAllMenu">
       <u><b>Table of Content</b></u>
       <table id="tblAllMenu" class="menu" CELLSPACING="0" CELLPADDING="0">
         <%for(int i=0; i < iNumOfAllMenu; i++) {%>
            <tr>
              <td class="menu1">
                <%if(iAllLevel[i]==0) {%><br><%}%>
                <%for(int j=0; j < iAllLevel[i] * 10; j++) {%>&nbsp;<%}%>&nbsp;
                <%if(sAllType[i].equals("1")){%><a href="<%=sAllUrl[i]%>"><%=sAllMenu[i]%></a><%}
                  else {%><%=sAllMenu[i]%><%}%>
              </td>
            </tr>
         <%}%>
       </table>
    </td>
    </tr>
   <!-- ================================================================ -->


</Table>
</td>
</tr>
</TABLE>
</body>
</HTML>
<%}%>

