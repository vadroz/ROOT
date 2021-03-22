<%@ page import="menu.*, rciutility.CheckUpdateStatus, rciutility.FormatNumericValue, java.util.*, java.io.*, java.text.*"%>
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
    if (//sUser.length() == 7 && sUser.trim().substring(0, 5).equals("cashr")
       //||
       session.getAttribute("BASIC")==null) { bSecure = true;  }
   

    String sStrAllowed = session.getAttribute("STORE").toString();
    String sOpsCentrCust = "sunskispo";
    if (sStrAllowed == null || sStrAllowed.startsWith("ALL")) {sStrAllowed = "0000"; sOpsCentrCust = "retcon";}
    if(sStrAllowed.length() == 1){ sStrAllowed = "0" + sStrAllowed; }


    MainMenu menu = new MainMenu(sUser);
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
    MenuTableOfContent menuAll = new MenuTableOfContent(sUser);
    int iNumOfAllMenu = menuAll.getNumOfMenu();
    String [] sAllMenu = menuAll.getMenu();
    int [] iAllLevel = menuAll.getLevel();
    String [] sAllUrl = menuAll.getUrl();
    String [] sAllType = menuAll.getType();
    menuAll.disconnect();

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
    boolean bEComAuth = false;
    if(session.getAttribute("ECOMDWNL")!=null)  bEComAuth = true;

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

        String sImagePath = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/ROOT/Charts/Div1Chart.jpg";
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

    SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
    Calendar cal = Calendar.getInstance();
    cal.add(Calendar.DATE, -1);
    Date date = cal.getTime();
    String sLastDate = df.format(date);

    boolean bITDepartment = sUser.equals("vrozen") 
   		|| sUser.equals("psnyder")
   		|| sUser.equals("srutherfor")
   		|| sUser.equals("kkoo")
   		|| sUser.equals("ptownsend")
   		|| sUser.equals("criley")
   		|| sUser.equals("hkoulavo")
    ;
    boolean bBasicExcl = sUser.startsWith("cashr") || 
    		sUser.startsWith("w7")
    ; 
%> 
<HTML>

<LINK href="style/main.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<TITLE>RCI Intranet Home Page</TITLE>
<HEAD>
  

</HEAD>

<script language="JavaScript">
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

var initNumMenu = <%=iNumOfMenu%>;
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

var isOpera = (!!window.opr && !!opr.addons) || !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0;
//Firefox 1.0+
var isFirefox = typeof InstallTrigger !== 'undefined';
//Safari 3.0+ "[object HTMLElementConstructor]" 
var isSafari = /constructor/i.test(window.HTMLElement) || (function (p) { return p.toString() === "[object SafariRemoteNotification]"; })(!window['safari'] || safari.pushNotification);
//Internet Explorer 6-11
var isIE = /*@cc_on!@*/false || !!document.documentMode;
//Edge 20+
var isEdge = !isIE && !!window.StyleMedia;
//Chrome 1+
var isChrome = !!window.chrome && !!window.chrome.webstore;
//Blink engine detection
var isBlink = (isChrome || isOpera) && !!window.CSS;

if (window.navigator.userAgent.match(/iPad/i) || window.navigator.userAgent.match(/iPhone/i)) {  isSafari = true; }
var ua = window.navigator.userAgent;
//==============================================================================
// run for body on load
//==============================================================================
function bodyLoad()
{  
  checkAlarm();

  var tblcnt = false;
  if (getCookie("LastUser") == "<%=sUser%>")
  {
     tblcnt = getCookie("TblContnent")=="Y";
  }

  //setLastUsed();

  disp_Table_Of_Content(tblcnt);
  switch_Off_onload();

  <%if(!bSecure){%>

  //chkSchMsgBoard();
  //chkStBMsgBoard();
  <%if(session.getAttribute("TRANSFER") != null){%>chkStrIncShip();<%}%>
  chkTransfer();
  //chkClinicApprovalReq();
  chkPOWoBsrUpc();

  <%}%>  
  <%if(!bSecure && !bBasicExcl){%>
  <%/*if(!bSecure){*/%>
    //rtvDiv1Sls("VAR");
    //rtvSkiBootSls("VAR");      
    buildFlashSls();
    //buildAgedInvContest(new Date(new Date() - 86400000));
    //get current contest list
    //getCurrContests();
    <%if(sUser.equals("mparker") || sUser.equals("vrozen")){%>/* get2012WinterChallenge();*/<%}%> //xgame 2012
    //getKioskSlsContest();
    //getStrSlsPerfContest(); //2013 winter challenge  
    
    
    getConversionVar(); 
    
  
  <%}%>
  getCompMsgBoard();
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
   //chkStBMsgBoard();
   chkStrIncShip();
   chkTransfer();
   //chkClinicApprovalReq();
   chkPOWoBsrUpc();

   rtvDiv1Sls("VAR");
   //rtvSkiBootSls();
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
      
    if(isIE || isSafari){ window.frame3.location.href = MyURL; }
    else if(isChrome || isEdge) { window.frame3.src = MyURL; }
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
	for(var i=0; i < 9; i++)
	{
		var frmNm = "frame" + (i+1);	
		setFrameText(frmNm, "");	
	}
}
//=====================================================================
//write into frame
//=====================================================================
function setFrameText(frmNm, text)
{
	var ifrm = document.getElementById(frmNm);
	ifrm = (ifrm.contentWindow) ? ifrm.contentWindow : (ifrm.contentDocument.document) ? ifrm.contentDocument.document : ifrm.contentDocument;
	ifrm.document.open();
	ifrm.document.write(text);
	ifrm.document.close();
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
      if(i==1){document.all[div].style.backgroundColor = "#e6ffff";}
      if(i==2){document.all[div].style.backgroundColor = "#e6e6ff";}
      if(i==3){document.all[div].style.backgroundColor = "#ffffcc";}
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
     var menubar = document.getElementById(div);
     
     menubar.innerHTML=main
     
     if(isIE || isSafari)
     {
     	menubar.style.pixelLeft=pos[0];
     	menubar.style.pixelTop=pos[1] ;
     }
     else if(isChrome || isEdge) 
     {
    	menubar.style.left=pos[0];
      	menubar.style.top=pos[1] ;
     }
     menubar.style.width="200px";
     menubar.style.visibility="visible";     

    if(close)
    {     	 
    	if(isIE || isSafari){ window.frame3.location.href = null; }
        else if(isChrome || isEdge) { window.frame3.src = ""; }
    }
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
   saveUsage(url, menu);
   window.location.href=url;
}
// ------------------------------------------------------
// save menu usage
// ------------------------------------------------------
function saveUsage(svurl, menu)
{	
	clearIframeContent("frame1");
 	var nwelem = "";
 	
 	if(isIE){ nwelem = window.frame1.document.createElement("div"); }
 	else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
 	else{ nwelem = window.frame1.contentDocument.createElement("div");}
 	nwelem.id = "dvSbmStrSts"

    var html = "<form name='frmSaveUsage'"
        + " METHOD=Post ACTION='MenuUsgSav.jsp'>"
        + "<input name='Url'>"
        + "<input name='Menu'>"
        + "<input name='User'>"
    html += "</form>"

    nwelem.innerHTML = html;	
	  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
	  else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
	  else if(isSafari){ window.frame1.document.body.appendChild(nwelem); }
	  else{ window.frame1.contentDocument.body.appendChild(nwelem); }
   
	if(isIE || isSafari)
	{
   		window.frame1.document.all.Url.value = svurl;
   		window.frame1.document.all.Menu.value = menu;
   		window.frame1.document.all.User.value = "<%=sUser%>";   
   		window.frame1.document.frmSaveUsage.submit();
	}
	else
	{
		window.frame1.contentDocument.forms[0].Url.value = svurl;
		window.frame1.contentDocument.forms[0].Menu.value = menu;
		window.frame1.contentDocument.forms[0].User.value = "<%=sUser%>";
	    window.frame1.contentDocument.forms[0].submit();
	}
}
//==============================================================================
//clear  iframe content
//==============================================================================
function clearIframeContent(id) 
{
    var iframe = document.getElementById(id);
    try 
    {
    	var doc = (iframe.contentDocument)? iframe.contentDocument: iframe.contentWindow.document;
	      doc.body.innerHTML = "";
	}
	catch(e) 
	{
	      // alert(e.message);
    }
    return false;
}
// ------------------------------------------------------
// load current transfer request
// ------------------------------------------------------
function chkTransfer()
{
	var url = "StrTrfSum.jsp";   	 
  	if(isIE || isSafari){ window.frame2.location.href = url; }
    else if(isChrome || isEdge) { window.frame2.src = url; }
}
// ------------------------------------------------------
// set transfer summary
// ------------------------------------------------------
function setTrfSum(html)
{
  	document.all.ItemTrf.innerHTML=html
  	document.all.linkItemTrf.style.display="block"
	if(isIE || isSafari){ window.frame2.location.href = null; }
	else if(isChrome || isEdge) { window.frame2.src = ""; }
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
  
  if(isIE || isSafari){ window.frame1.location.href = MyURL; }
  else if(isChrome || isEdge) { window.frame1.src = MyURL; }
  
  this.focus();
}
// ------------------------------------------------------
// populate message board parameters
// ------------------------------------------------------
function setSchNewMsg(html)
{
  document.all.SchMsgBoard.innerHTML=html
  document.all.linkSchMsgBoard.style.display="block"

  if(isIE || isSafari){ window.frame1.location.href = null; }
  else if(isChrome || isEdge) { window.frame1.src = ""; }
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
   
  window.frame4.location = URL;
  if(isIE || isSafari){ window.frame4.location.href = URL; }
  else if(isChrome || isEdge) { window.frame4.src = URL; }
}

// ------------------------------------------------------
// populate message board parameters
// ------------------------------------------------------
function setStBNewMsg(html)
{
  	document.all.StBMsgBoard.innerHTML=html
  	document.all.linkStBMsgBoard.style.display="block"
  	
  	if(isIE || isSafari){ window.frame4.location.href = null; }
  	else if(isChrome || isEdge) { window.frame4.src = ""; }
}

//==============================================================================
// retreive Store Incoming shippments
//==============================================================================
function chkStrIncShip()
{
  	var URL = "StrIncomingShip.jsp?";   
   
  	if(isIE || isSafari){ window.frame4.location.href = URL; }
  	else if(isChrome || isEdge) { window.frame4.src = URL; }
}
//==============================================================================
// populate incoming shipments panel
//==============================================================================
function setStrIncShip(html)
{
  	document.all.StBMsgBoard.innerHTML=html
  	document.all.linkStBMsgBoard.style.display="block"
  	
  	if(isIE || isSafari){ window.frame4.location.href = null; }
	else if(isChrome || isEdge) { window.frame4.src = ""; }
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
// display / hide Schedule Message Board
// ------------------------------------------------------
function display_hide_StrIncShip()
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
  	 
  	if(isIE || isSafari){ window.frame6.location.href = url; }
 	else if(isChrome || isEdge) { window.frame6.src = url; }
}
// ------------------------------------------------------
// show list of clinics approval request
// ------------------------------------------------------
function showClinicApprReq(store, date, brand)
{
  window.frame6.close(); 
  if(isIE || isSafari){ window.frame6.location.href = null; }
  else if(isChrome || isEdge) { window.frame6.src = ""; }

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
   
  	if(isIE || isSafari){ window.frame8.location.href = url; }
	else if(isChrome || isEdge) { window.frame8.src = url; }
}
// ------------------------------------------------------
// creat table of PO w/o BSR and UPC
// ------------------------------------------------------
function showPOWoBsrUpc(div, divnm, nobsr, noupc)
{
  //window.frame8.close();
  if(isIE || isSafari){ window.frame8.location.href = null; }
  else if(isChrome || isEdge) { window.frame8.src = ""; }

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
<%/*if(!bSecure || sUser.trim().substring(0, 5).equals("cashr")){*/%>
<%if(!bSecure){%>
// ------------------------------------------------------
// retreive Thermometer Chart - Division 1 challenge
// ------------------------------------------------------
function rtvDiv1Sls(sort)
{
   	if(isIE || isSafari){ window.frame5.location.href = "Div1Challenge.jsp?Sort=" + sort; }
	else if(isChrome || isEdge) { window.frame5.src = "Div1Challenge.jsp?Sort=" + sort; }
}

// ------------------------------------------------------
// retreive Thermometer Chart - Ski Boot Sales
// ------------------------------------------------------
function rtvSkiBootSls(sort)
{   	 
   	if(isIE || isSafari){ window.frame9.location.href = "SkiBootChallenge.jsp?Sort=" + sort; }
	else if(isChrome || isEdge) { window.frame9.src = "SkiBootChallenge.jsp?Sort=" + sort; }
}

// ------------------------------------------------------
// build Flash sales Report
// ------------------------------------------------------
function buildFlashSls()
{
	if(isIE || isSafari){ window.frame7.location.href = "FlashSalesTyLyHP.jsp" }
	else if(isChrome || isEdge) { window.frame7.src = "FlashSalesTyLyHP.jsp" }
}
// ------------------------------------------------------
// show Flash sales Report
// ------------------------------------------------------
function showFlashSls()
{
   var flashsls = "";
   if(isIE || isSafari){ flashsls = window.frame7.document.body.innerHTML; }
   else if(isChrome || isEdge){flashsls = window.frame7.contentDocument.body.innerHTML;}
   
   document.all.tdFlash.innerHTML = flashsls;
   var elapse = (new Date()).getTime() - StartDate
   document.all.dvElapse.innerHTML = (elapse / 1000) + " sec."   
}
// ------------------------------------------------------
//get current contest list
// ------------------------------------------------------
function getCurrContests()
{    
   if(isIE || isSafari){ window.frame10.location.href = "ChallCurrLst.jsp" }
   else if(isChrome || isEdge) { window.frame10.src = "ChallCurrLst.jsp" }
}
//==============================================================================
//get 2012 Winter Challenge - result will be displayed in dvWinterChall
//==============================================================================
function get2012WinterChallenge()
{
   	var url = "XGame2012Daily.jsp?Date=LASTDATE"
    
   	if(isIE || isSafari){ window.frame10.location.href = url; }
	else if(isChrome || isEdge) { window.frame10.src = url; }
}
//==============================================================================
//get kiosk Sales contest
//==============================================================================
function getKioskSlsContest()
{
   	var url = "EComKioskSlsCont.jsp?Return=Yes"
   	 
   	if(isIE || isSafari){ window.frame10.location.href = url; }
	else if(isChrome || isEdge) { window.frame10.src = url; }
}
//==============================================================================
//get kiosk Sales contest
//==============================================================================
function getConversionVar()
{	
	var url = "HCDlySum1.jsp";
	if(isIE || isSafari){ window.frame9.location.href = "HCDlySum1.jsp"; }
    else if(isChrome || isEdge) { window.frame9.src = "HCDlySum1.jsp"; }
}
//==============================================================================
//get comapny message board content
//==============================================================================
function getCompMsgBoard()
{
	var url = "MainPageMsgBoard.jsp"
	
	if(isIE || isSafari){ window.frame10.location.href = url; }
	else if(isChrome || isEdge) { window.frame10.src = url; }
}
//==============================================================================
//get Sales contest
//==============================================================================
function getStrSlsPerfContest()
{
   	var url = "EmpSlsPerformSum.jsp?NotSa=Y"
    
   	if(isIE || isSafari){ window.frame5.location.href = url; }
	else if(isChrome || isEdge) { window.frame5.src = url; }
}

// ------------------------------------------------------
// show Flash sales Report
// ------------------------------------------------------
function showCurrContests(code, name)
{
   var html = "";
   var brk = "";
   for(var i=0; i < code.length; i++)
   {
      html += brk + "<a href='ChallResult.jsp?Code=" + code[i] + "&Name=" + name[i] + "'>" + name[i] + "</a>"
      brk = "<br>";
   }
   html += brk + "<a href='ChallResultDeux.jsp?Code=" + code[0] + "&Name=" + name[0] + " Part Deux'>Part Deux - The DMM challenge</a>"
   document.all.dvCurrCont.innerHTML = html;
}
// ------------------------------------------------------
// build Aged Inventory Contest panel
// ------------------------------------------------------
function buildAgedInvContest(date)
{
   	usadate = (date.getMonth() + 1) + "/" + date.getDate() + "/" + date.getFullYear();
   	var url = "AgedInvContDly.jsp?Date=" + usadate;
   	if(isIE || isSafari){ window.frame9.location.href = url; }
	else if(isChrome || isEdge) { window.frame9.src = url; }
}
// ------------------------------------------------------
// show Flash sales Report
// ------------------------------------------------------
function showAgedInvContest(contest)
{
   document.all.tdAic.innerHTML = contest;
   dispTotContDtl()
}
// ------------------------------------------------------
// fold/unfold
// ------------------------------------------------------
function dispTotContDtl()
{
   var show = "block";
   if (document.all.TotAge[0].style.display != "none") { show = "none";  }
   for(var i=0; i < document.all.TotAge.length; i++)
   {
      document.all.TotAge[i].style.display = show;
   }
}
// ------------------------------------------------------
// build Flash sales Report
// ------------------------------------------------------
function flashSlsSortBy(sort)
{
   	var url = "FlashSalesTyLyHP.jsp?Sort=" + sort
   	if(isIE || isSafari){ window.frame7.location.href = url; }
	else if(isChrome || isEdge) { window.frame7.src = url; }
}
// ------------------------------------------------------
// set Thermometer Chart - Division 1 challenge
// ------------------------------------------------------
function showThermometer(html)
{
   try
   {
      document.all.tdThermometer.innerHTML = html;
   }
   catch(err) { }

}
// ------------------------------------------------------
// set Thermometer Chart - Division 1 challenge
// ------------------------------------------------------
function showDiv1Sls(html)
{
   try
   {
   document.all.tdTyLyVar.innerHTML = html;
   }
   catch(err) { }
}

// ------------------------------------------------------
// set Thermometer Chart - Ski Boot challenge
// ------------------------------------------------------
function showSkiBootSls(html)
{
   document.all.tdSkiBootTyLyVar.innerHTML = html;
}
// ------------------------------------------------------
// set required Sales increase
// ------------------------------------------------------
function showSlsIncrease(html)
{
   document.all.tdSlsIncr.innerHTML = html;
}

// ------------------------------------------------------
// set Thermometer Chart - Ski Boot
// ------------------------------------------------------
function showSkiBootChart(html)
{
   document.all.tdSkiBootChart.innerHTML = html;
}

// ------------------------------------------------------
// set required Ski Boot Sales increase
// ------------------------------------------------------
function showSkiBootIncrease(html)
{
   document.all.tdSkiBootIncr.innerHTML = html;
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
   'width=600,height=500, left=100,top=10, resizable=yes , toolbar=yes, location=yes, directories=yes, status=yes, scrollbars=yes,menubar=yes';

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

   OpenWindow.document.write("<a href='http://www.snocountry.com/ski-reports/california?tmpl=component&print=1&page='>California<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/ski-reports/colorado?tmpl=component&print=1&page='>Colorado<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/ski-reports/indiana?tmpl=component&print=1&page='>Indiana<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/ski-reports/maine?tmpl=component&print=1&page='>Maine<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/ski-reports/massachusetts?tmpl=component&print=1&page='>Massachusetts<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/ski-reports/new-hampshire?tmpl=component&print=1&page='>New Hampshire<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/ski-reports/new-jersey?tmpl=component&print=1&page='>New Jersey<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/ski-reports/new-mexico?tmpl=component&print=1&page='>New Mexico<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/ski-reports/nevada?tmpl=component&print=1&page='>Nevada<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/ski-reports/new-york?tmpl=component&print=1&page='>New York<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/ski-reports/north-carolina?tmpl=component&print=1&page='>North Carolina<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/ski-reports/rhode-island?tmpl=component&print=1&page='>Rhode Island<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/ski-reports/vermont?tmpl=component&print=1&page='>Vermont<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/ski-reports/virginia?tmpl=component&print=1&page='>Virginia<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/ski-reports/washington?tmpl=component&print=1&page='>Washington<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/ski-reports/west-virginia?tmpl=component&print=1&page='>West Virginia<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/ski-reports/wyoming?tmpl=component&print=1&page='>Wyoming<a><br>")
   OpenWindow.document.write("<a href='http://www.snocountry.com/ski-reports/utah?tmpl=component&print=1&page='>Utah<a><br>")
   OpenWindow.document.write("</BODY>")
   OpenWindow.document.write("</HTML>")

OpenWindow.document.close()

}

//==============================================================================
// show Productivity Ranking report
//==============================================================================
function showProdRank()
{
   var date = new Date(new Date() - 86400000);
   for(var i=0; i < 7; i++)
   {
      if(date.getDay() == 0) { break; }
      else { date = new Date(date.getTime() - 86400000) }
   }

   var wkend = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

   var url = "StrProd2DatesSum.jsp?FROMWKEND=" + wkend
    + "&TOWKEND=" + wkend
    + "&Str=3&Str=4&Str=5&Str=8&Str=10&Str=11&Str=20&Str=28&Str=30&Str=35&Str=40&Str=45&Str=46&Str=50&Str=61&Str=66&Str=75&Str=82&Str=86&Str=88&Str=92&Str=96&Str=98";

   var WindowName = 'Prod_Ranking_Report';
   var WindowOptions =
   'width=900,height=500, left=100,top=10, resizable=yes , toolbar=yes, location=yes, directories=no, status=yes, scrollbars=yes,menubar=yes';
   var OpenWindow = window.open(url, WindowName, WindowOptions);
}
//==============================================================================
// show Productivity Ranking report
//==============================================================================
function showITContactInfo()
{

var html = "<table style='background:#e7e7e7;font-size=12px' border='0' width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr>"
       + "<td class='BoxName' nowrap>IT Help Desk Contact Info</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td>"
      + "</tr>"
  // Comment line
   html += "<tr>"
          + "<td nowrap colspan='2'>"
          + "For process/Procedural issues, check with your Manager or contact your "
          + "District Manager for assistance.<br><br>"
          + "For urgent IT issues, call:<br><br>"
          + "Home office <b><font color=red size=+1>281-207-3606</font></b><br>"
          + "Or<br>"       
          + "If your problem is not urgent, please create an action in RIDE to the &#34;IT Support Request&#34; group." 
          + "</b>"
          + "</td>"
        + "</tr>"
   // buttons
   html += "<tr>"
          + "<td nowrap colspan='2' align=center>"
          + "<button class='Small' onClick='hidePanel();'>Cancel</button>"
          + "</td>"
        + "</tr>"

   html += "</table>"

   document.all.dvInfo.innerHTML = html;
   document.all.dvInfo.style.pixelLeft= 200;
   document.all.dvInfo.style.pixelTop= 200;
   document.all.dvInfo.style.visibility = "visible";
}
<%}%>
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvInfo.innerHTML = " ";
   document.all.dvInfo.style.visibility = "hidden";
}
//==============================================================================
// set sales trend
//==============================================================================
function setSlsTrend()
{
  var date = new Date(new Date() - 86400000);
  var dofw = date.getDay();
  date = new Date(date - 86400000 * dofw);

  var lastwk = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

   var url="WkSlsTrend.jsp?DIVISION=ALL&DEPARTMENT=ALL&CLASS=ALL&VENDOR=ALL&Str=3&Str=4&Str=5&Str=8&Str=10&Str=11&Str=12&Str=13&Str=20&Str=28&Str=29&Str=30&Str=35&Str=40&Str=42&Str=45&Str=46&Str=50&Str=55&Str=56&Str=59&Str=61&Str=63&Str=64&Str=66&Str=70&Str=72&Str=75&Str=82&Str=86&Str=87&Str=88&Str=89&Str=90&Str=92&Str=93&Str=96&Str=98&FromDt=NONE&LEVEL=D&SORT=GROUP&selAmtType=R"
     + "&ToDt=" + lastwk
   //alert(url)
   window.location.href=url
}

//==============================================================================
//  check Alarm
//==============================================================================
function checkAlarm()
{
   var xhttp = null;
   if (window.XMLHttpRequest)
   {
      // code for IE7+, Firefox, Chrome, Opera, Safari
      xhttp = new XMLHttpRequest();
   }
   else
   {
      // code for IE6, IE5
      xhttp = new ActiveXObject("Microsoft.XMLHTTP");
   }
   xhttp.open("GET","CompMsgBoard2.jsp", true);
   xhttp.send();

   xhttp.onreadystatechange=function()
   {
     if (xhttp.readyState==4 && xhttp.status==200)
     {
       var html = xhttp.responseText;
       if(html.indexOf("[[@!#NONE#!@]]") < 0)
       {
          document.all.dvAlarm.style.display="block";
          document.all.dvAlarm.innerHTML = html;
          if(!StartBlink) { setInterval("blinkIt()",500); StartBlink = true; }
       }
       else
       {
          document.all.dvAlarm.style.display="none";
          document.all.dvAlarm.innerHTML = "";
          StartBlink = false;
       }
     }
   }

   setTimer()
}
//==============================================================================
//  set Timer
//==============================================================================
function setTimer()
{
	setTimeout("checkAlarm()", 5000);
	return false;
}
//==============================================================================
// blink it
//==============================================================================
function blinkIt() {
 if (!document.all) return;
 else {
   for(i=0;i<document.all.tags('blink').length;i++)
   {
      s=document.all.tags('blink')[i];
      s.style.visibility=(s.style.visibility=='visible')  ?'hidden':'visible';
   }
 }
}

//==============================================================================
//hilight row on Flash sales 
//==============================================================================
function setHiliFlashSls(row, hi)
{
	var color = "#ede5d3";
	if(!hi){ color="#efefef"; }
	
	row.style.backgroundColor = color;
}   
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

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
<div id="dvInfo" class="Prompt" ></div>

<div id="dvAlarm"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame2"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame3"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame4"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame5"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame6"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame7"  src=""  frameborder=1 height="0" width="0"></iframe>
<iframe  id="frame8"  src=""  frameborder=1 height="0" width="0"></iframe>
<iframe  id="frame9"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame10"  src=""  frameborder=1 height="0" width="0"></iframe>
<iframe  id="frmUsg"  src=""  frameborder=1 height="0" width="0"></iframe>

<!-- frame  id="frameFlash"  src=""  frameborder=1 height="200" width="100%"></iframe -->
<!--iframe  id="frmAlarm"  src="CompMsgBoard.jsp?User=<%=sUser%>"  frameborder=1 height="100" width="100%"></iframe -->
<!-------------------------------------------------------------------->
<Table Border=0 CELLSPACING="5" CELLPADDING="0" height="100%">
<%if(!bSecure) {%>
<tr><td class="sep41" style="border:1px grey solid" colspan="2"><img src="Sun_ski_logo4.png"/><td></td>

    
<tr>
    <td WIDTH="20%"  valign="top" rowspan="2" bgColor="ivory" class='msg1'>

  <table border=1 width="100%">
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
           <br>2009 Aged Inventory Contest</a>
        </td>
    </tr -->
    <!--  End Aged Inventory Contest -->

    <!-- World Cup -->
    <!--tr><td class='misc3' nowarp>
           <a class="blue" href="ShowGame.jsp">
              <img class="skier" src="Skier.jpg" alt="World Cup" width="80" height="80">
           <br>March Madness</a>
        </td>
     </tr -->
    <!--  End World Cup -->
    
    
    

    <tr><td class='misc1'>COVID-19 Update</td></tr-->
    <tr><td class='misc3' nowarp>
           <!-- img class="skier" src="winning.jpg" alt="Current Contests" width="40" height="40"-->
           <!--div id=dvCurrCont></div>
           <a href="/Contest/2011-Wunder Winter Challenge List.html">2011 Winter Challenge</a-->
           <!-- br><a href="SkiContSel.jsp">Peak Season Skiing Contest</a>           
           <br><a href="/Contest/Weekly_Contest.pdf">Contest</a -->
           <a href="/MainMenu/COVID Safety Update.pdf" target="_blank">**COVID-19 Safety Update**</a> 
        </td>
     </tr>


    <!-- Christmas Bike Contest -->
    <!-- tr><td class='misc3' nowarp>
        <a class="blue" href="ChristmasContest.jsp">Christmas Bike Sales Contest</a>
      </td>
     </tr -->
   <!-- End contest -->

   <!-- Item per Transaction Contests -->
       <tr><td class='misc3' nowarp>
        <!-- a class="blue" href="StrProd2DatesSum.jsp?FROMWKEND=12/03/2007&TOWKEND=03/23/2008&Str=3&Str=4&Str=5&Str=8&Str=10&Str=11&Str=20&Str=28&Str=30&Str=35&Str=40&Str=45&Str=46&Str=50&Str=61&Str=66&Str=75&Str=82&Str=86&Str=88&Str=92&Str=96&Str=98" target="_blank">
          Packing List/IPT</a -->
        <!--a class="blue" href="javascript: showProdRank()">
          Packing List/IPT</a-->
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
        <%if(!bBasicExcl){%>
             <%if(bAvail){%>
                 <a href="FlashSalesSel.jsp">Flash Sales Reports</a>
                 <br><a href="FlashSalesTyLy.jsp?Str=ALL&Division=ALL&DivName=All%20Divisions&Department=ALL&DptName=All%20Departments&Class=ALL&clsName=All%20Classes&Date=<%=sLastDate%>&Level=S&Period=MTDTYLY">TY vs. LY</a>
                 &nbsp; &nbsp
                 <a href="FlashSalesTyLy.jsp?Str=ALL&Division=ALL&DivName=All%20Divisions&Department=ALL&DptName=All%20Departments&Class=ALL&clsName=All%20Classes&Date=<%=sLastDate%>&Level=S&Period=MTDTYPLAN">TY vs. Target</a>
             <%} else {%>Flash Sales Reports is not available now,<br>please try it later.<%}%>

             <%if(bITDepartment){%>
                <br><a href="FlashSalesUpto5PrYrSel.jsp">Flash Sales Reports(Up to 5Yrs)</a>
                <br><a href="FlashSalesUpto5PrYr.jsp?Store=ALL&Division=ALL&DivName=All%20Divisions&Department=ALL&DptName=All%20Departments&Class=ALL&clsName=All%20Classes&Date=<%=sLastDate%>&Level=S&Period=MTDTYLY2A">TY vs. LY (Up to 5 Yrs)</a>
             <%}%>
        <%}%>   
      </td>
   </tr>
     <!-- ****deleted*** tr><td class='misc2' nowarp><a href="BfdgSchActWkSel.jsp">Allowable Budget Review(Weekly)</a></td>
     <tr  ****deleted**** ><td class='misc2' nowarp><a href="javascript: setSlsTrend()">Sales Trend Report</a></td -->
   <!--tr><td class='misc2' nowarp><a href="HCDlyLst.jsp">Conversion</a>
       <br><!-- a href="HC52wkGraph.jsp">52 wk Graph</a --></td>
   </tr -->
   
   <tr><td class='misc3' nowarp> 
   			<a href="WkSlsTrendVen.jsp?&Dpt=ALL&Cls=ALL&Ven=ALL&Div=ALL&Str=3&Str=4&Str=5&Str=6&Str=8&Str=10&Str=11&Str=16&Str=17&Str=20&Str=22&Str=28&Str=29&Str=30&Str=35&Str=40&Str=42&Str=45&Str=46&Str=50&Str=55&Str=61&Str=63&Str=64&Str=66&Str=68&Str=70&Str=75&Str=82&Str=86&Str=87&Str=88&Str=89&Str=90&Str=91&Str=92&Str=93&Str=96&Str=98&FromDt=NONE&ToDt=<%=sLastDate%>&Level=S&Sort=Grp&selAmtType=R&InclClrSls=Y">Clearance Sales/Inventory</a>
   		</td>
   </tr>
       <tr><td class='misc3' nowarp> 
             <!-- a href="javascript: snowReportList()">Snow Report</a -->
             <a href="http://www.snocountry.com/" target="_blank">Snow Report</a>
            </td>
       </tr>
   <%if(sUser.length() != 7 || sUser.trim().substring(0, 5).equals("cashr") == false) {%>
       <tr><td class='misc3' nowarp>
             <a href="SlsRepJobMon.jsp">Report Monitor</a>
            </td>
       </tr>
   <%}%>
    </td></tr></table>

    <br><!--a id="linkSchMsgBoard" style="display:none;" class="blue" href="javascript: display_hide_SchMsgBoard()">Display/Hide Scheduale Message Board</a-->
    <!-- a class="blue" id="linkStBMsgBoard" style="display:none;" href="javascript: display_hide_StBMsgBoard()">Display/Hide Store/Buyer Message Board</a -->
    <a class="blue" id="linkStBMsgBoard" style="display:none;" href="javascript: display_hide_StrIncShip()">Display/Hide Store Incoming Shipments</a>
    <a class="blue" id="linkItemTrf" style="display:none;" href="javascript: display_hide_ItemTrf()">Display/Hide Item Transfers</a>
    <!--a class="blue" id="linkClinicApprReq" style="display:none;" href="javascript: display_hide_ClnApprReq()">Display/Hide ClinicApproval Request</a -->
    <a class="blue" id="linkPOWoBsrUpc" style="display:none;" href="javascript: display_hide_POWoBsrUpc()">Display/Hide PO w/o BSR and USR</a>

    <!-- ---------------------------------------------------------------------------------- -->
    <!-- Scheduale Message board -->
    <!-- ---------------------------------------------------------------------------------- -->
    <!--  div id="SchMsgBoard" style="display:block;"></div -->
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
        
          <td colspan="3">
             <table CELLSPACING="0" CELLPADDING="0" id="tblQuick" width="100%">
                <tr><td class='misc1' colspan=7>Quick Links</td></tr>                
                <tr>
                    <th class='misc1' colspan=2 nowrap>All</th>
                    <th class='misc1' colspan=2 nowrap>Stores</th>
                    <th class='misc1' nowrap>HO</th>
                    <%if(bITDepartment){%>
                       <th class='misc1' colspan=2 nowrap>IT</th>
                    <%}%>
                </tr>

                <tr>
                   <!--td class='misc' nowrap>&nbsp;<a class="blue" href="https://webmail.retailconcepts.cc">Check E-mail</a></td -->
                   <td class='misc' nowrap>&nbsp;<a class="blue" href="https://ops-center.opterus.net/?customer=sunskispo">RIDE</a></td>
                   <td class='misc' nowrap>&nbsp;<a href="MainMenu/holidayschedule.pdf">Company Holidays</a></td>
                   <td class='misc' nowrap>&nbsp;<a class="blue" href="javascript: showITContactInfo()">IT Support Info</a></td>
                   <td class='misc' nowrap>&nbsp;<a class="blue" href="MainMenu/Store Listing.pdf" target="_blank">Store List</a></td>
                   <td class='misc' nowrap>&nbsp;<a class="blue" href="MainMenu/Extension Listing.pdf" target="_blank">H.O. Extensions</a></td>
                   <%if(bITDepartment){%>
                      <td class='misc' nowrap>&nbsp;<a class="blue" href="AlertServer.jsp" target="_blank">Start Alert Server</a></td>
                      <td class='misc' nowrap>&nbsp;<a class="blue" href="JobList.jsp">Operator Panel</a></td>
                   <%}%>
                </tr>
                <tr>
                   <td class='misc' nowrap>&nbsp;<a class="blue" href="http://sunandski.com/">SunAndSki.com</a></td>
                   <td class='misc' nowrap>&nbsp;<a class="blue" href="https://workforcenow.adp.com/public/index.htm ">HR/Payroll Portal</a></td>
                   <td class='misc' nowrap>&nbsp;<a class="blue" href="MainMenu/Maintenance Companies.pdf" target="_blank">Maintenance Co's</a></td>
                   <td class='misc' nowrap>&nbsp;<a class="blue" href="MainMenu/Emergency Phone Numbers.pdf" target="_blank">Emergency Contacts</a></td>
                   <td class='misc' nowrap>&nbsp;<a class="blue" href="DivBuyerList.jsp" target="_blank">&nbsp;Division by Buyers</a></td>
                   <%if(bITDepartment){%>
                      <td class='misc' nowrap>&nbsp;<a class="blue" href="CompMsgBoardMaint.jsp" target="_blank">IT Msg_Board</a></td>
                      <td class='misc' nowrap>&nbsp;<a class="blue" href="WrkQuery.jsp">File Utility</a></td>
                   <%}%>
                </tr>
                <tr>
                   <td class='misc' nowrap>&nbsp;<a class="blue" href="http://sunandskipatio.com/">SunAndSkiPatio.com</a></td>
                   <td class='misc' nowrap>&nbsp;<a href="MainMenu/Benefit Summarys.pdf">Benefits Summary</a></td>
                   <td class='misc' nowrap><a href="SignOn1.jsp?TARGET=index.jsp&APPL=ALL">Sign On</a></td>
                   <td class='misc' nowrap><a class="blue" href="MainMenu/Store Hours.pdf" target="_blank">Store Operating Hours</a></td>
                   <td class='misc' nowrap><a class="blue" href="MainMenu/Distribution Center Related Stores.pdf" target="_blank">Distribution Center Related Stores</a></td>
                   <%if(bITDepartment){%>
                      <td class='misc' nowrap>&nbsp;<a class="blue" href="AlertServerStop.jsp">Stop Alert Server</a></td>
                      <td class='misc' nowrap>&nbsp;<a class="blue" href="FileQueryLst.jsp">File List</a></td>
                   <%}%>
                </tr>

                <%if(sUser.equals("vrozen")){%>
                   <tr>
                       <td class='misc' colspan=6 nowrap>&nbsp;</td>
                       <td class='misc' nowrap>&nbsp;<a class="blue" href="PgmSrcUtilitySel.jsp">Source_Listing</a></td>
                   </tr>
                <%}%>
              </table>
          </td>
        </tr>
<td><div id="dvConv"></div></td>
</tr>	
<tr><td style="font-size:3px">&nbsp;</td></tr>

<!-- ================================================================ -->
<!--          blue divider -->
<!-- ================================================================ -->
 <tr>
   <td class="misc1" colspan=2>

      <span id="spMenu">&nbsp;|&nbsp;
           <a class="white" href="javascript:disp_All_SubMenu()">Display Sub-Menus</a> &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
           <a class="white" href="javascript:colapse_All_SubMenu()">Collapse Sub-Menus</a> &nbsp;&nbsp;&nbsp;
        </span>
      &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <a class="white" href="javascript:disp_Table_Of_Content(true)">Table of Contents</a>
      &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp; <a class="white" href="javascript:disp_Table_Of_Content(false)">Menu</a>
      &nbsp;&nbsp;&nbsp;
      &nbsp;&nbsp;&nbsp;
         <!-- SELECT name="LastMenu"
           onchange='runUrl(this.options[this.selectedIndex].value, this.options[this.selectedIndex].text)' style="font-size:10px;">
           <option>-- Select used link ---</option>
         </SELECT -->
         &nbsp;&nbsp;&nbsp;|
      </span>
   </td>
 </tr>
<!-- ================================================================ -->
<!--                 Main Panel -->
<!-- ================================================================ -->
 <tr>
   <td valign="top" id="tdMenu">

    <table class="panel"  id="tblMenu" CELLSPACING="10" CELLPADDING="0">
      <%int iTd = 0;%>
      <%for(int i=0; i < iNumOfMenu; i++){
      		int ipanel = i;
    	  	if(i > 19){ ipanel = i-20; }  
    	  	if (!sUser.equals("vrozen")){ ipanel=2; }
      %>
        <%if(iTd == 0){%><tr><%}%>
           <td nowrap class="panel<%=ipanel%>">
             <span class="menu" onClick="switch_On_Off_SubMenu(<%=i%>)"><%=sMenu[i]%></span>

             <table id="tblMenu<%=i%>" class="menu" CELLSPACING="0" CELLPADDING="0">
               <!-- -----------  menu option ------------------------------  -->
               <!-- if main menu option is URL duplicate as menu option -->
               <%if(iNumOfChild[i]==0 && sType[i].equals("1")){%>
                   <tr><td class="menu1"  nowrap onmouseover="hilightOpt(this, true, '<%=sUrl[i]%>');" onmouseout="hilightOpt(this, false)"
                    onClick="click_On_Menu('<%=sMenu[i]%>', '<%=sType[i]%>', '<%=sUrl[i]%>', this)">
                    &nbsp;&nbsp;<%=sMenu[i]%></td><tr>
               <%}
               else if(iNumOfChild[i]==0 && sType[i].equals("0")){%>
                    <tr><td class="menu1" nowrap onmouseover="hilightOpt(this, true);" onmouseout="hilightOpt(this, false)">
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
        <%if(!sUser.equals("vrozen")) {%>  
        	<%if(iTd == 6){ iTd = 0;%></tr><%} else iTd++;%>
        <%} else {%>
           <%if(iTd == 4){ iTd = 0;%></tr><%} else iTd++;%>
        <%}%>	
      <%}%>
     <!-- ================================================================ -->
    </table>
  </td>
  <!-- td><div id="dvConv"></div></td -->
 </tr>
    <!-- ================================================================ -->
    <!--                 Table of Contents -->
    <!-- ================================================================ -->
    <tr>
      <td valign="top" id="tdAllMenu">
       <u><b>Table of Contents</b></u>
       <table id="tblAllMenu" class="menu" CELLSPACING="0" CELLPADDING="0">
         <%for(int i=0; i < iNumOfAllMenu; i++) {%>
            <tr>
              <td class="menu1">
                <%if(iAllLevel[i]==0) {%><br><%}%>
                <%for(int j=0; j < iAllLevel[i] * 10; j++) {%>&nbsp;<%}%>&nbsp;
                <%if(sAllType[i].equals("1")){%><a href="javascript:runUrl('<%=sAllUrl[i]%>','<%=sAllMenu[i]%>')"><%=sAllMenu[i]%></a><%}
                  else {%><%=sAllMenu[i]%><%}%>
              </td>
            </tr>
         <%}%>
       </table>
    </td>
    </tr>
<!-- ================================================================ -->
<!--       Company Message -->
<!-- ================================================================ -->
 <tr><td class="misc" colspan=2><div id="dvCompMsg">Company Message: (none)</div></td></tr>
<!-- ================================================================ -->
<!--       2012 Winter Challenge -->
<!-- ================================================================ -->
 <tr><td class="misc" colspan=2><div id="dvStrSlsPef"></div></td></tr>

 <tr><td class="misc" colspan=2><div id="dvWinterChall"></div></td></tr>
   <!-- ================================================================ -->
   <!--                 Sales Challenge -->
   <!-- ================================================================ -->
   <%/*if(!bSecure || sUser.trim().substring(0, 5).equals("cashr")) {*/%>
   <%if(!bSecure) {%>
   <tr>
     <td align=center valign=top colspan=2>
       <table border=2 width="100%">
       <!-- Aged inventory Contest -->
        <!--tr>
          <td class="Div1SlsHdr" nowrap>Aged Inventory Contest</td>
          <td class="Div1SlsHdr" nowrap colspan=2>&nbsp;</td>
        </tr-->
        <!-- tr>
           <td id="tdAic" valign="top" nowrap>&nbsp;</td>
        </tr -->

        <!-- Flash Sales -->
        <tr>
          <td class="misc1" nowrap>Store Ranking - Flash Sales Report <span id="spAsOfDate"></span></td>
          <!--td class="Div1SlsHdr" nowrap colspan=2>Packing List Challenge</td-->
        </tr>
        <tr>
           <td id="tdFlash" valign="top" rowspan=2 nowrap>&nbsp;</td>
           <!--td  id="tdSlsIncr" valign="top" colspan=2></td -->
        </tr>

        <!--tr>
           <td  id="tdTyLyVar" valign="top"></td>
           <td style="vertical-align:top" id="tdThermometer">
             <img src="thermometer.jpg">
             <img src="Charts/Div1Chart.jpg">
          </td>
        </tr-->
      </table>
     </td>
   </tr>
   <!-- ==================================================================== -->
   <!-- ski Boot Sales -->
   <!-- ==================================================================== -->
   <!--tr>
       <td class="Div1SlsHdr" nowrap>Ski Boot Sales Challenge</span></td>
       </tr>
   <tr>
     <td align=center valign=top>
        <table border=2 width="100%">
         <tr>
           <td  id="tdSkiBootTyLyVar" valign="top"></td>
           <td  id="tdSkiBootIncr" valign="top" colspan=2></td>
           <td style="vertical-align:top" id="tdSkiBootChart"></td>
         </tr -->
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
