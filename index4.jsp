<%@ page import="menu.*, rciutility.CheckUpdateStatus, rciutility.FormatNumericValue, java.util.*, java.awt.Color, java.io.*, java.math.BigDecimal"%>
<%
  Date dStart = new Date();
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=index.jsp&APPL=ALL");
}

else {
    String sUser = session.getAttribute("USER").toString();
    boolean bSecure = false;
    if (sUser.length() == 7 && sUser.trim().substring(0, 5).equals("cashr")
       || session.getAttribute("BASIC")==null) { bSecure = true;  }

    // Check if Flash Sales is Available now
    boolean bAvail = false;


    if(!bSecure)
    {
       FlashSalesAvailable flashavail = new FlashSalesAvailable();
       bAvail = flashavail.getAvail();
       flashavail.disconnect();
    }

    boolean bMsgAuth = false;
    if(session.getAttribute("STRBMALL")!=null)  bMsgAuth = true;

    // check status of chart creating process
    CheckUpdateStatus chksts = new CheckUpdateStatus("D1SCHART");
    String sStatus = chksts.getStatus();
    if(sStatus.equals("CREATE")) { chksts.setNewStatus("D1SCHART","SKIP","0", sUser); }
    chksts.disconnect();
    chksts = null;

    // Division 1 Sales Bar chart
    if(sStatus.equals("CREATE")) {
        // Charts and table for div 1 challenage
        SalesChallenge slschell = new SalesChallenge("STR");
        slschell.setGraph();
        String sGraphTySales = slschell.getGraphTySales();
        String sGraphLySales = slschell.getGraphLySales();
        String sGraphVar = slschell.getGraphVar();
        slschell.disconnect();
        slschell = null;

        String sImagePath = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT/Charts/Div1Chart.jpg";
        //String sImagePath = "/var/tomcat4/webapps/ROOT/Charts/Div1Chart.jpg";
        /*if(new File("c:/").isDirectory()){ sImagePath = "C:/Program Files/Apache Group/Tomcat 4.1/webapps/ROOT/Charts/Div1Chart.jpg"; }

        // format Numeric value
        FormatNumericValue fmt = new FormatNumericValue();
        fmt.getFormatedNum(sGraphTySales, "#,###,###");

        Div1BarChartGenerator graphGen = new Div1BarChartGenerator(150, 450);
        graphGen.setAxleY(new String[]{"$1M", "$2M","$3M","$4M","$5M","$6M","$7M","$8M","$9M","$10M"}, new int[]{1000000, 10000000}  );
        graphGen.setBarValues(new int[]{ Integer.parseInt(sGraphTySales), Integer.parseInt(sGraphLySales)}, new String[]{"TY", "LY"} );
        graphGen.setAdditionalText(new String[]{
              "TY = $" + fmt.getFormatedNum(sGraphTySales, "#,###,###"),
              "LY = $" + fmt.getFormatedNum(sGraphLySales, "#,###,###"),
              "Var = " + fmt.getFormatedNum(sGraphVar, "###.##") + "%"});
        graphGen.setBackground(new Color(231, 231, 231));
        graphGen.setBarColor(new Color[]{ new Color(0, 187, 0), new Color(255, 255, 0)});
        graphGen.createChart();
        graphGen.createFileFromGraphics(sImagePath);
        graphGen = null;
        */
    }
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
       td.sep41 { background:white; padding-left:5px; font-size:26px; text-align:left; font-weight: bolder}

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

       table.Therm { border:2px; border-style: outset;  background:#e7e7e7;}
       tr.Therm {  text-align:center; font-size:3px;}
       td.Therm1 {  background:green;}
       td.Therm2 {  background:yellow;}
       td.Therm3 {  background:#e7e7e7;}
       td.Therm41 { vertical-align:top; font-size:10px; border-bottom: red solid 5px; }
       td.Therm42 { vertical-align:top; font-size:10px; border-top: black solid 1px; }
       td.Therm5 { vertical-align:top; font-size:10px;
                   border-top: black solid 1px; border-left: black solid 1px }
       td.Therm51 { vertical-align:top; font-size:10px; border-left: black solid 1px }


       tr.Div1Sls {  text-align:right; font-size:10px;}
       tr.Div1Sls1 { background:#FFCC99; text-align:center; font-size:12px;}
       tr.Div1Sls2 { background:cornsilk; text-align:right; font-size:12px;}
       tr.Div1Sls21 { background:cornsilk; color:red; text-align:right; font-size:14px; font-weight: bold}
       tr.Div1Sls3 { background:pink; text-align:right; font-size:10px;}
       th.Div1Sls { border-bottom: black solid 1px; border-right: black solid 1px;
                    padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;}
       th.Div1Sls1 { border-bottom: black solid 1px; border-right: black solid 1px; text-align:left;
                    padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;}
       td.Div1Sls { border-bottom: black solid 1px; border-right: black solid 1px;
                    padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;}
       td.Div1Sls1 { color:darkred; border-top: black solid 2px; border-right: black solid 2px;  border-left: black solid 2px;
                    padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;}
       td.Div1Sls11 { color:darkred; border-top: black solid 2px; border-right: black solid 2px;
                      border-bottom: black solid 2px; border-left: black solid 2px;
                    padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;}
       td.Div1SlsHdr { filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr=ivory, endColorStr=red,
                 gradientType=0); border: 3px; border-style: outset;
                 color: darkblue; text-align:center; font-size:14px; font-weight:bold }


       table.msg { border:2px; border-style: outset;  background:LightSteelBlue;}
       td.msg { text-align:left; font-size:10px; text-decoration:underline }
       td.msg1 { border:2px; border-style: ridge; text-align:center; font-size:10px }
       td.msg2 { text-align:center; font-size:10px }
       td.msg3 { text-align:left; font-size:10px;}
       td.misc { background:eff7ff; border:2px; border-style: ridge; text-align:left; font-size:10px}

       td.misc1{ filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr=#1528a7, endColorStr=#0066ff,
                 gradientType=0);
                 padding-top:0px; border:darkblue 1px solid;
                 color: white; vertical-align:top; text-align:center; font-size:16px; font-weight:bold }
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

<script language="JavaScript1.3">
var StartDate = new Date(<%=dStart.getTime()%>);

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


var Menu = new Array();
var Url = new Array();
var Type = new Array();
var MOption = null;
var dvMenuId = 0;
var MenuArr = new Array();
var nextMenu=0;
var CurMenu = new Array();
var OnlyMenu = <%=sUser.equals("vrozen")%>

var LastUsedMenu = new Array(5);
var LastUsedUrl = new Array(5);

//==============================================================================
// run for body on load
//==============================================================================
function bodyLoad()
{
  var tblcnt = false;
  if (getCookie("LastUser") == "<%=sUser%>")
  {
     tblcnt = getCookie("TblContnent")=="Y";
  }

  setLastUsed();

  disp_Table_Of_Content(tblcnt);
  switch_Off_onload();

  <%if(!bSecure){%>

  chkSchMsgBoard();
  chkStBMsgBoard();
  chkTransfer();
  chkClinicApprovalReq();
  chkPOWoBsrUpc();

  <%}%>
  <%if(!bSecure || sUser.trim().substring(0, 5).equals("cashr")){%>
    rtvDiv1Sls("VAR");
    buildFlashSls();
  <%}%>
}
// ------------------------------------------------------
// run for body on unload
// ------------------------------------------------------
function bodyUnload()
{
   setCookie("LastUser", "<%=sUser%>");
   if (document.all.tdAllMenu.style.display == "block") { setCookie("TblContnent", "Y"); }
   else { setCookie("TblContnent", "N"); }
}
// ------------------------------------------------------
// show Hiden tables
// ------------------------------------------------------
function refreshHidenPanel()
{
   chkSchMsgBoard();
   chkStBMsgBoard();
   chkTransfer();
   chkClinicApprovalReq();
   chkPOWoBsrUpc();

   rtvDiv1Sls("VAR");
   buildFlashSls();
}
// ------------------------------------------------------
// set Last Used Menu
// ------------------------------------------------------
function setLastUsed()
{
   var df = document.all;

   for(var i=0, j=1; i < 5; i++)
   {
      var menu = getCookie("Option" + i);
      var url = getCookie("OptUrl" + i);
      if(menu != null)
      {
         LastUsedMenu[j] = menu;
         LastUsedUrl[j] = url;
         document.all.LastMenu.options[j++]=new Option(menu, url)
      }
   }
   if(document.all.LastMenu.length < 2) { document.all.spnLastMenu.style.display="none" }
}
// ------------------------------------------------------
// set sookies
// ------------------------------------------------------
function setCookie(cookie,value)
{
   var diedate=new Date(new Date() - (-10) * 86400000);
   document.cookie=cookie + "=" + value + ";expires=" + diedate
}
// ------------------------------------------------------
// get sookies
// ------------------------------------------------------
function getCookie(cookie_name)
{
  var pos = document.cookie.indexOf(cookie_name);
  var c_val = null;
  var c_end = null;
  if(pos >= 0)
  {
     pos = document.cookie.indexOf("=", pos) + 1;
     end = document.cookie.indexOf(";", pos);
     if(end > 0) c_val = document.cookie.substring(pos, end);
     else c_val = document.cookie.substring(pos);
  }
  return c_val;
}
// ------------------------------------------------------
// populate main menu - bar style
// ------------------------------------------------------
function popMainMenuBar(parent, root, obj)
{
  MOption = obj;
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
   else { runUrl(url, menu); }
}
// ------------------------------------------------------
// stop loading process to speed up menu works
// ------------------------------------------------------
function stopLoad()
{
  window.frame1.document.write("");
  window.frame2.document.write("");
  window.frame4.document.write("");
  window.frame5.document.write("");
  window.frame6.document.write("");
  window.frame7.document.write("");
  window.frame8.document.write("");

  window.frame1.close(); // Schedule Meassage boards
  window.frame2.close(); // Item transfer
  window.frame4.close(); // chkStBMsgBoard
  window.frame5.close(); // Division 1 Sales
  window.frame6.close(); // Clinick Approval Status
  window.frame7.close(); // Flash Sales Report
  window.frame8.close(); // load PO w/o BSR and UPC
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
       main += " onClick='removeMenu(this, true); runUrl(&#34;" + Url[i] + "&#34;, &#34;" + Menu[i] + "&#34;)'";
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
      pos = clcPosition(MOption);
      pos[0] += pos[2]+1;

      if(pos[0] > 800) pos[0] = 800

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
// run link
// ------------------------------------------------------
function runUrl(url, menu)
{
   LastUsedMenu[0] = menu;
   LastUsedUrl[0] = url;

   for(var i=0, j=0; i < LastUsedMenu.length && i < 5; i++)
   {
      if (LastUsedMenu[i]!=null && (i == 0 || LastUsedMenu[i] != menu))
      {
         setCookie("Option" + j, LastUsedMenu[i]);
         setCookie("OptUrl" + j, LastUsedUrl[i]);
         j++;
      }
   }

   window.location.href=url;
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
function setTrfSum(html)
{
  document.all.ItemTrf.innerHTML=html
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
function setSchNewMsg(html)
{
  document.all.SchMsgBoard.innerHTML=html
  document.all.linkSchMsgBoard.style.display="block"

  window.frame1.location = null;
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
function setStBNewMsg(html)
{
  document.all.StBMsgBoard.innerHTML=html
  document.all.linkStBMsgBoard.style.display="block"

  window.frame4.location = null;
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
// load clinics approval request
// ------------------------------------------------------
function chkClinicApprovalReq()
{
  var url = "ClinicApprovalReq.jsp";

  //alert(url)
  //window.location.href = url;
  window.frame6.location = url;
}
// ------------------------------------------------------
// show list of clinics approval request
// ------------------------------------------------------
function showClinicApprReq(store, date, brand)
{
  window.frame6.close();
  window.frame6.location = null;

  var html = "<table class='msg'>"
             + "<tr><td class='msg1' colspan=5 nowarp >Clinic Approval Requests</td></tr>"
             + "<tr><td class='msg1'>Str</td>"
             + "<td class='msg1' >Date</td>"
             + "<td class='msg1' >Brand</td>";

  for(i=0; i < store.length; i++)
  {
    html += "<tr>"
           + "<td class='msg2' nowrap><a href='javascript: showStrClinic(" + store[i] + ", &#34;" + date[i] + "&#34;)'>" + store[i] + "</a></td>"
           + "<td class='msg2'>" + date[i] + "</td>"
           + "<td class='msg'>" + brand[i] + "</td>"
           + "</tr>"
  }

  html += "</table>";
  document.all.ClinicApprReq.innerHTML = html;
  document.all.linkClinicApprReq.style.display="block"
}
// ------------------------------------------------------
// display / hide Clinic Aproval requsts
// ------------------------------------------------------
function display_hide_ClnApprReq()
{
   if(document.all.ClinicApprReq.style.display=="block") { document.all.ClinicApprReq.style.display="none"; }
   else document.all.ClinicApprReq.style.display="block";
}
// ------------------------------------------------------
// load PO w/o BSR and UPC
// ------------------------------------------------------
function chkPOWoBsrUpc()
{
  var url = "POWoBsrUpcList.jsp";

  //alert(url)
  //window.location.href = url;
  window.frame8.location = url;
}
// ------------------------------------------------------
// creat table of PO w/o BSR and UPC
// ------------------------------------------------------
function showPOWoBsrUpc(div, divnm, nobsr, noupc)
{
  window.frame8.close();
  window.frame8.location = null;

  var html = "<table class='msg'>"
             + "<tr><td class='msg1' colspan=5 nowarp><a href='POwoBSRandUPCSel.jsp'>PO w/o BSR and UPC</a></td></tr>"
             + "<tr><td class='msg1'>Div</td>"
             + "<td class='msg1' ># of<br>w/o BSR</td>"
             + "<td class='msg1' ># of<br>w/o UPC</td>"

  for(i=0; i < div.length; i++)
  {
    html += "<tr>"
           + "<td class='msg' nowrap><a href='POwoBSRandUPC.jsp?Div=" + div[i] + "&Vendor='>" + div[i] + " - " + divnm[i] + "</a></td>"
           + "<td class='msg2'>" + nobsr[i] + "</td>"
           + "<td class='msg2'>" + noupc[i] + "</td>"
           + "</tr>"
  }

  html += "</table>";
  document.all.POWoBsrUpc.innerHTML = html;
  document.all.linkPOWoBsrUpc.style.display="block"
  var elapse = (new Date()).getTime() - StartDate
  document.all.dvElapse.innerHTML = (elapse / 1000) + " sec."
}

// ------------------------------------------------------
// display / hide Clinic Aproval requsts
// ------------------------------------------------------
function display_hide_POWoBsrUpc()
{
   if(document.all.POWoBsrUpc.style.display=="block") { document.all.POWoBsrUpc.style.display="none"; }
   else document.all.POWoBsrUpc.style.display="block";
}
// ------------------------------------------------------
// show list of clinics approval request
// ------------------------------------------------------
function showStrClinic(str, date)
{
   var mon = date.substring(0, date.indexOf("/") + 1);
   var year = date.substring(date.indexOf("/", date.indexOf("/") + 1) + 1);

   var url = "VendorClinics.jsp?Store=" + str
           + "&MonYr=" + mon + year
   //alert(url)
   window.location.href = url;
}
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
   stopLoad();
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
<%if(!bSecure || sUser.trim().substring(0, 5).equals("cashr")){%>
// ------------------------------------------------------
// retreive Thermometer Chart - Division 1 challenge
// ------------------------------------------------------
function rtvDiv1Sls(sort)
{
   window.frame5.location.href="Div1Challenge.jsp?Sort=" + sort
}
// ------------------------------------------------------
// build Flash sales Report
// ------------------------------------------------------
function buildFlashSls()
{
   window.frame7.location.href= "FlashSalesTyLyHP.jsp"
}
// ------------------------------------------------------
// show Flash sales Report
// ------------------------------------------------------
function showFlashSls()
{
   var flashsls = window.frame7.document.body.innerHTML
   document.all.tdFlash.innerHTML = flashsls;
   var elapse = (new Date()).getTime() - StartDate
   document.all.dvElapse.innerHTML = (elapse / 1000) + " sec."
}
// ------------------------------------------------------
// build Flash sales Report
// ------------------------------------------------------
function flashSlsSortBy(sort)
{
   window.frame7.location.href= "FlashSalesTyLyHP.jsp?Sort=" + sort
}
// ------------------------------------------------------
// set Thermometer Chart - Division 1 challenge
// ------------------------------------------------------
function showThermometer(html)
{
   document.all.tdThermometer.innerHTML = html;
}
// ------------------------------------------------------
// set Thermometer Chart - Division 1 challenge
// ------------------------------------------------------
function showDiv1Sls(html)
{
   document.all.tdTyLyVar.innerHTML = html;
}
// ------------------------------------------------------
// set required Sales increase
// ------------------------------------------------------
function showSlsIncrease(html)
{
   document.all.tdSlsIncr.innerHTML = html;
}
// ------------------------------------------------------
// set Sales data retreiving date
// ------------------------------------------------------
function showAsOfDate(html)
{
   window.frame5.close();
   document.all.spAsOfDate.innerHTML = html;
}
// ------------------------------------------------------
// set Store Division 1 sales and variances
// ------------------------------------------------------
function showStoreScores(type)
{
   var str = "ALL";
   var week = "ALL";

   if(type=="S") { str = document.all.selStr.options[document.all.selStr.selectedIndex].text; }
   else { week = document.all.selWeek.options[document.all.selWeek.selectedIndex].text; }

   var url = "Div1StrChall.jsp?Store=" + str + "&Week=" + week;
   var WindowName = 'Div_1_Store_Challenge';
   var WindowOptions =
   'width=600,height=500, left=100,top=10, resizable=yes , toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,menubar=no';

  //alert(url)
  window.open(url, WindowName, WindowOptions);
}
//==============================================================================
// snow report list
//==============================================================================
function snowReportList()
{
   var WindowName = 'SnowReport';
   var WindowOptions =
   'width=900,height=500, left=100,top=10, resizable=yes , toolbar=no, location=yes, directories=no, status=yes, scrollbars=yes,menubar=no';

   var OpenWindow = window.open("", WindowName, WindowOptions);
   OpenWindow.document.write("<TITLE>Title Goes Here</TITLE>")
   OpenWindow.document.write("<BODY BGCOLOR=ivory>")
   OpenWindow.document.write("<h1>Snow Report Site List</h1>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/snowclient/srlist.php?state=CO&from=statelist'>Colorado<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/snowclient/srlist.php?state=VT&from=statelist'>Vermont<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/snowclient/srlist.php?state=NY&from=statelist'>New York<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/snowclient/srlist.php?state=NJ&from=statelist'>New Jersey<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/snowclient/srlist.php?state=WV&from=statelist'>West Virginia<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/snowclient/srlist.php?state=VA&from=statelist'>Virginia<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/snowclient/srlist.php?state=NC&from=statelist'>North Carolina<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/snowclient/srlist.php?state=IN&from=statelist'>Indiana<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/snowclient/srlist.php?state=UT&from=statelist'>Utah<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/snowclient/srlist.php?state=NM&from=statelist'>New Mexico<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/snowclient/srlist.php?state=CA&from=statelist'>California<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/snowclient/srlist.php?state=NV&from=statelist'>Nevada<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/snowclient/srlist.php?state=WY&from=statelist'>Wyoming<a><br>")
   OpenWindow.document.write("</BODY>")
   OpenWindow.document.write("</HTML>")

OpenWindow.document.close()

}
<%}%>
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<body id="Body" onload="bodyLoad();"  onUnload="bodyUnload()">

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
<iframe  id="frame5"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame6"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame7"  src=""  frameborder=1 height="0" width="0"></iframe>
<iframe  id="frame8"  src=""  frameborder=1 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<Table Border=0 CELLSPACING="5" CELLPADDING="0" width="100%" height="100%">
<%if(!bSecure) {%>
<tr>
    <td WIDTH="20%"  valign="top" rowspan="2" bgColor="deecec" class='msg1'>
    <table width="100%">
      <tr><td class='misc1'>Miscellaneous</td></tr>
      <tr>
        <td class='misc'>
          <a class="blue" href="https://webmail.retailconcepts.cc">Check e-mail</a>&nbsp;&nbsp;&nbsp;
          <a class="blue" href="MAILTO:">Send e-mail</a>
          <br><a class="blue" href="http://sunandski.com/">Our Internet</a>&nbsp;&nbsp;&nbsp;
          <a class="blue" href="JobList.jsp">Operator Panel</a>&nbsp;&nbsp;&nbsp;
          <a class="blue" href="MainMenu/Emergency Phone Numbers.pdf" target="_blank"> Emergency Phones</a>&nbsp;&nbsp;&nbsp;
          <a class="blue" href="MainMenu/Airports, Rental Cars & Hotels.pdf" target="_blank">Airports, Cars, Hotels</a>&nbsp;&nbsp;&nbsp;
          <a class="blue" href="MainMenu/Maintenance Companies.pdf" target="_blank"> Maintenance Companies</a>&nbsp;&nbsp;&nbsp;

          <%if(sUser.equals("vrozen")){%><a class="blue" href="WrkQuery.jsp">File Utility</a><%}%><br>
          <%if(sUser.equals("vrozen") || sUser.equals("snixon")){%><a class="blue" href="FileQueryLst.jsp">File List</a><%}%>&nbsp;&nbsp;&nbsp;
          <%if(sUser.equals("vrozen") || sUser.equals("snixon")){%><a class="blue" href="PgmSrcUtilitySel.jsp">Source Listing</a><%}%>
          <%if(sUser.equals("vrozen")){%><br><a class="blue" href="javascript: refreshHidenPanel()">Show Hiden Tables</a><%}%>

          <br><a href="Antivirus/avg70f_308a466.exe">Antivirus program</a>
        </td>
      </tr>
    </table>

  <table width="100%" border=1>
  <!--tr><td class='misc3' nowarp><a href="http://jobsearch.monster.com/jobsearch.asp?q=sun+and+ski+sports&fn=&lid=&re=130&cy=us">
  Career Opportunity</a></td></tr-->
   <!-- ITSA Contest -->
    <!--tr><td class='misc3' nowarp>
        <a class="blue" href="ItsaContest.jsp">
        <img class="skier" src="winning.jpg" alt="ITSA" width="40" height="40">
        <br>ITSA Contest</a>
      <td>
    </tr -->
   <!--   End Itsa contest -->

      <!--td class='misc1' nowarp -->
       <!-- Hand and Toe Warmer Contest -->
        <!--a class="blue" href="HandToeWarmerContest.jsp">
        <img class="skier" src="Warmer.gif" alt="Hand and Toe Warmer" width="40" height="40">
        <br>Hand and Toe<br>Warmer Contest</a -->
       <!--   End Hand and Toe Warmer Contest -->
       <!--/td-->
       <!--/tr-->

    <!-- Water Contest -->
    <!--tr><td class='misc3' nowarp>
           <a class="blue" href="ShowGameTS_LW.jsp">
              <img class="skier" src="WaterContest/WaterContest.jpg" alt="Water Contest" width="110" height="110">
           <br>2006 King Water Contest</a>
        </td>
     </tr -->
    <!--  End Water contest -->

    <!-- Aged Inventory Contest -->
    <!--tr><td class='misc3' nowarp>
           <a class="blue" href="ShowGameAC.jsp">
              <img class="skier" src="Antique1.jpg" alt="Aged Inventory Contest" width="110" height="90">
           <br>2006 Aged Inventory Contest</a>
        </td>
    </tr -->
    <!--  End Aged Inventory Contest -->

    <!-- World Cup -->
    <!-- tr><td class='misc3' nowarp>
           <a class="blue" href="ShowGame.jsp">
              <img class="skier" src="Skier.jpg" alt="World Cup" width="80" height="80">
           <br>World Cup Contest</a>
        </td>
     </tr -->
    <!--  End World Cup -->

    <!-- Christmas Bike Contest -->
       <!--tr><td class='misc3' nowarp>
        <a class="blue" href="ChristmasContest.jsp">
        <img class="skier" src="winning.jpg" alt="Christmas Bike Sales" width="40" height="40">
        <br>Christmas Bike Sales Contest</a>
      </td>
     </tr -->
   <!-- End contest -->

   <!-- 10 Million Challenge -->
       <tr><td class='misc3' nowarp>
        <a class="blue" href="WaterContest/10_Million_Challenge.doc" target="_blank">
        <img class="skier" src="winning.jpg" alt="10 Million Challenge" width="40" height="40">
        <br>10 Million Challenge</a>
        <!-- span id="spOld10MChal"></span -->
      </td>
     </tr>
   <!-- End contest -->

   <!--tr><td class='misc2' nowarp>What's new?
         <br><a href="SalesBySkuSel.jsp">Return Validation</a>
          <br><a href="SlsRelSel.jsp">Sales Relation Report</a>
     </td -->

    <!-- Tour de Sun & Ski -->
    <!-- tr><td class='misc2' nowarp>
    <a class="blue" href="ShowGameTS.jsp">
      <img class="skier" src="TourDeSS.bmp" alt="Tour de Sun & Ski" width="90" height="80">
      <br>Tour de Sun & Ski</a>
    </td></tr -->
    <!--   End Tour de Sun & Ski -->
   <tr><td class='misc2' nowarp>
             <%if(bAvail){%><a href="FlashSalesSel.jsp">Flash Sales Reports</a><%}
               else {%>Flash Sales Reports is not available now,<br>please try it later.<%}%>
             <br>
         </td>
       </tr>
       <tr><td class='misc3' nowarp><b>Company Holidays</b>
             <br><a href="PolicyAndForms/Policy/Holiday Schedule 2007.htm">2007 Holidays</a>
            </td>
       </tr>
       <tr><td class='misc3' nowarp>
             <a href="javascript: snowReportList()">Snow Report</a>
            </td>
       </tr>
       <tr><td class='misc3' nowarp>
             <a href="SlsRepJobMon.jsp">Report Monitor</a>
            </td>
       </tr>
    </td></tr></table>

    <br><a id="linkSchMsgBoard" style="display:none;" class="blue" href="javascript: display_hide_SchMsgBoard()">Display/Hide Scheduale Message Board</a>
    <a class="blue" id="linkStBMsgBoard" style="display:none;" href="javascript: display_hide_StBMsgBoard()">Display/Hide Store/Buyer Message Board</a>
    <a class="blue" id="linkItemTrf" style="display:none;" href="javascript: display_hide_ItemTrf()">Display/Hide Item Transfers</a>
    <a class="blue" id="linkClinicApprReq" style="display:none;" href="javascript: display_hide_ClnApprReq()">Display/Hide ClinicApproval Request</a>
    <a class="blue" id="linkPOWoBsrUpc" style="display:none;" href="javascript: display_hide_POWoBsrUpc()">Display/Hide PO w/o BSR and USR</a>

    <!-- ---------------------------------------------------------------------------------- -->
    <!-- Scheduale Message board -->
    <!-- ---------------------------------------------------------------------------------- -->
    <div id="SchMsgBoard" style="display:block;"></div>
    <!-- End New Message List Table -->
    <!-- ---------------------------------------------------------------------------------- -->
    <!-- Scheduale Message board -->
    <!-- ---------------------------------------------------------------------------------- -->
    <br><div id="StBMsgBoard" style="display:block;"></div>
    <!-- End New Message List Table -->
    <!-- ---------------------------------------------------------------------------------- -->
    <!-- Item transfer List-->
    <!-- ---------------------------------------------------------------------------------- -->
    <br><div id="ItemTrf" style="display:block;"></div>
    <!-- End Item Transfer List -->
    <!-- ---------------------------------------------------------------------------------- -->
    <!-- Clinic Approval request list -->
    <!-- ---------------------------------------------------------------------------------- -->
    <br><div id="ClinicApprReq" style="display:block;"></div>
    <!-- End Clinic Approval request List -->
    <!-- ---------------------------------------------------------------------------------- -->
    <!-- PO w/o BSR and USP by division -->
    <!-- ---------------------------------------------------------------------------------- -->
    <br><div id="POWoBsrUpc" style="display:block;"></div>
    <!-- End PO w/o BSR and USP by division -->
    </font></td>
<%}%>

    <!-- ---------------------------------------------------------------------------------- -->
    <td class="misc" nowrap valign="top">
        <Table Border=0 CELLSPACING="0" CELLPADDING="0" width="100%">
        <tr>
          <td class="sep41" colspan="2"><img src="Sun_ski_logo1.jpg" width="96%"></td>
        </tr>
<!-- ================================================================ -->
<!--          blue divider -->
<!-- ================================================================ -->
 <tr>
   <td class="misc1" >
      <span id="spMenu">&nbsp;|&nbsp;
           <a class="white" href="javascript:disp_All_SubMenu()">Display Sub-Menus</a> &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
           <a class="white" href="javascript:colapse_All_SubMenu()">Collapse Sub-Menus</a> &nbsp;&nbsp;&nbsp;
        </span>
      &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <a class="white" href="javascript:disp_Table_Of_Content(true)">Table of Contents</a>
      &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <a class="white" href="javascript:disp_Table_Of_Content(false)">Menu</a>
      &nbsp;&nbsp;&nbsp;
      <span id="spnLastMenu">|&nbsp;&nbsp;&nbsp;
         <SELECT name="LastMenu"
           onchange='runUrl(this.options[this.selectedIndex].value, this.options[this.selectedIndex].text)' style="font-size:10px;">
           <option>-- Select used link ---</option>
         </SELECT>
         &nbsp;&nbsp;&nbsp;|
      </span>
   </td>
 </tr>
<!-- ================================================================ -->
<!--                 Main Panel -->
<!-- ================================================================ -->
 <tr>
   <td valign="top">
    <jsp:include page="Menu_Group/MainMenu_Group_00001.html"></jsp:include>

    </td>
  </tr>
   <!-- ================================================================ -->
   <!--                 Sales Challenge -->
   <!-- ================================================================ -->
   <%if(!bSecure || sUser.trim().substring(0, 5).equals("cashr")) {%>
   <tr>
     <td align=center valign=top>
       <table border=2 width="100%">
        <tr>
          <td class="Div1SlsHdr" nowrap>Store Ranking - Flash Sales Report <span id="spAsOfDate"></span></td>
          <td class="Div1SlsHdr" nowrap colspan=2>$6 Million Challenge</td>
        </tr>
         <tr>
           <td id="tdFlash" valign="top" rowspan=2 nowrap>&nbsp;</td>
           <td  id="tdSlsIncr" valign="top" colspan=2></td>
         </tr>
         <tr>
           <td  id="tdTyLyVar" valign="top"></td>
           <td style="vertical-align:top" id="tdThermometer">
             <img src="thermometer.jpg">
             <!--img src="Charts/Div1Chart.jpg" -->
           </td>
         </tr>
       </table>
     </td>
   </tr>
   <%}%>
   <!-- ================================================================ -->
</Table>
</td>
</tr>
</TABLE>
<div id="dvElapse" style="font-size:8px"></div>
</body>
</HTML>



<%}%>

