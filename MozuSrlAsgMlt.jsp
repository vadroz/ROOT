<%@ page import="rciutility.StoreSelect, mozu_com.MozuSrlAsg, inventoryreports.PiCalendar, java.util.*"%>
<%
    String [] sSelStr = request.getParameterValues("Str");
    String [] sStatus = request.getParameterValues("Sts");
    String sStsFrDate = request.getParameter("StsFrDate");
    String sStsToDate = request.getParameter("StsToDate");
    String sSelSku = request.getParameter("Sku");
    String sSelOrd = request.getParameter("Ord");
    String sSort = request.getParameter("Sort");
    String sTop = request.getParameter("Top");

    if(sSort==null) sSort = "ORD";
    if(sTop==null) sTop = "0";
    if(sSelSku==null){sSelSku=" ";}
    if(sSelOrd==null){sSelOrd=" ";}

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=MozuSrlAsgMlt.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    String sAuthStr = session.getAttribute("STORE").toString().trim();
    String sUser = session.getAttribute("USER").toString();
    MozuSrlAsg itmasgn = new MozuSrlAsg(sSelStr, sStatus, sStsFrDate, sStsToDate
             , sSelSku, sSelOrd, sSort, sUser);
    int iNumOfItm = itmasgn.getNumOfItm();

    // authorized to changed assign store and notes
    boolean bAssign = sAuthStr.equals("ALL");
    // authorized to changed send str and notes
    boolean bSend = !sAuthStr.equals("ALL");
    
    String sStrAllowed = session.getAttribute("STORE").toString();
    String sPrinter = "QPRINT4";
    if(!sStrAllowed.equals("ALL"))
    {
       sPrinter = "S" + sStrAllowed + "OUTQ";
    }

    // get PI Calendar
    PiCalendar setcal = new PiCalendar();
    String sYear = setcal.getYear();
    String sMonth = setcal.getMonth();
    String sMonName = setcal.getDesc();
    setcal.disconnect();

    StoreSelect strlst = null;
    String sStrJsa = null;
    String sStrNameJsa = null;

    if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
     {
       strlst = new StoreSelect(10);
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

    sStrJsa = strlst.getStrNum();
    sStrNameJsa = strlst.getStrName();

    String [] sStrRegLst = strlst.getStrRegLst();
    String sStrRegJsa = strlst.getStrReg();

    String [] sStrDistLst = strlst.getStrDistLst();
    String sStrDistJsa = strlst.getStrDist();
    String [] sStrDistNmLst = strlst.getStrDistNmLst();
    String sStrDistNmJsa = strlst.getStrDistNm();

    String [] sStrMallLst = strlst.getStrMallLst();
    String sStrMallJsa = strlst.getStrMall();

    String sSelStrJsa = itmasgn.cvtToJavaScriptArray(sSelStr);
    
%>
<HTML>
<HEAD>
<title>E-Commerce</title>
<META content="RCI, Inc." name="E-Commerce"></HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:10px} a:visited { color:blue; font-size:10px}  a:hover { color:green; font-size:10px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}

        table.DataTable { padding: 0px; border-spacing: 0; border-collapse: collapse; width:100%
             ; border: grey solid 1px; font-size:10px }
        table.DataTable1 { padding: 0px; border-spacing: 0; border-collapse: collapse; width:100%; 
                background: LemonChiffon; border: grey solid 1px; font-size:10px }

        th.DataTable { border-bottom: grey solid 1px; border-left: grey solid 1px; background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { border-bottom: grey solid 1px; border-left: grey solid 1px; cursor:hand; color: blue; background:#FFCC99;padding- top:3px;
                       padding-bottom:3px; text-align:center; font-size:11px; text-decoration: underline;}

        tr.DataTable0 { background: #E7E7E7; font-size:10px }
        tr.DataTable01 { background: #E7E7E7; font-size:10px }
        tr.DataTable02 { background: LemonChiffon; font-size:10px }
        tr.DataTable011 { background: Chartreuse; font-size:10px }
        tr.DataTable021 { background: GreenYellow; font-size:10px }
        tr.DataTable1 { background: yellow; font-size:10px }
        tr.DataTable2 { background: darkred; font-size:1px}
        tr.DataTable3 { background: LemonChiffon; font-size:10px}
        tr.DataTable4 { background: white; font-size:12px}

        td.DataTable { border-bottom: grey solid 1px; border-left: grey solid 1px;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTableC { border-bottom: grey solid 1px; border-left: grey solid 1px; cursor:hand; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { border-bottom: grey solid 1px; border-left: grey solid 1px;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable1R { border-bottom: grey solid 1px; border-left: grey solid 1px; background: red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable1Y { border-bottom: grey solid 1px; border-left: grey solid 1px; background: yellow; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable11 { border-bottom: grey solid 1px; border-left: grey solid 1px; background: pink; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; font-weight:bold }
        td.DataTable12 { border-bottom: grey solid 1px; border-left: grey solid 1px; background: lightgreen; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; font-weight:bold }               

        td.DataTable1C { border-bottom: grey solid 1px; border-left: grey solid 1px; cursor:hand; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { border-bottom: grey solid 1px; border-left: grey solid 1px; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable2C { border-bottom: grey solid 1px; border-left: grey solid 1px; cursor:hand; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { border-bottom: grey solid 1px; border-left: grey solid 1px; cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.tdWarn01 { background: gold; color:blue; font-size:14px; font-weight:bold;  text-align:center;}

        .Small {font-size:10px }
        .Small1 {font-size:10px; text-align:center; }
        .Small2 {font-size:10px; text-align:center; vertical-align:top ;}
        .Medium {font-size:11px }
        .btnSmall {font-size:8px; display:none;}
        .Warning {font-size:12px; font-weight:bold; color:red; }

        div.draggable { position:absolute; visibility:hidden; background-attachment: scroll;
              width: 50px; padding-top:10px; z-index:10;
              text-align:center; vertical-align:top; font-size:10px}

        div.dvSelect { position:absolute; background-attachment: scroll;
              border: black solid 2px; width:250px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}

        td.BoxName {cursor:move; background: #016aab; color:white; text-align:center; font-family:Arial; 
                     font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background: #016aab;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Cell {font-size:12px; text-align:right; vertical-align:top}
        td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
        td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}
</style>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script name="javascript1.2">
//==============================================================================
// Global variables
//==============================================================================
var Sts = new Array();
<%for(int i=0; i < sStatus.length; i++){%>Sts[<%=i%>]= "<%=sStatus[i]%>";<%}%>
var StsFrDate = "<%=sStsFrDate%>"
var StsToDate = "<%=sStsToDate%>"

var NumOfItm = <%=iNumOfItm%>;

var SelObj = null;
var ChgOrder = new Array(NumOfItm);

var StrAllowed = "<%=sStrAllowed%>";

var PiYear = [<%=sYear%>];
var PiMonth = [<%=sMonth%>];
var PiDesc =  [<%=sMonName%>];

var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];

var User = "<%=sUser%>";

var Top = "<%=sTop%>";

// save line
var aSite = new Array(<%=iNumOfItm%>);
var aOrd = new Array(<%=iNumOfItm%>);
var aSku = new Array(<%=iNumOfItm%>);
var aUpc = new Array(<%=iNumOfItm%>);
var aStr = new Array(<%=iNumOfItm%>);
var aSrln = new Array(<%=iNumOfItm%>);
var aSts = new Array(<%=iNumOfItm%>);
var aOrdQty = new Array(<%=iNumOfItm%>);
var aAsgQty = new Array(<%=iNumOfItm%>);
var aAvlQty = new Array(<%=iNumOfItm%>);
var aPckQty = new Array(<%=iNumOfItm%>);
var aShpQty = new Array(<%=iNumOfItm%>);
var aShipMeth = new Array(<%=iNumOfItm%>);
var aAsgDate = new Array(<%=iNumOfItm%>);
var aPrtDate = new Array(<%=iNumOfItm%>);
var aPackDate = new Array(<%=iNumOfItm%>);
var aShipDate = new Array(<%=iNumOfItm%>);
var aDesc = new Array(<%=iNumOfItm%>);
var aVenNm = new Array(<%=iNumOfItm%>);
var aCnl1User = new Array(<%=iNumOfItm%>);
var aCnl1Date = new Array(<%=iNumOfItm%>);
var aCnl1Time = new Array(<%=iNumOfItm%>);
var aCnl2User = new Array(<%=iNumOfItm%>);
var aCnl2Date = new Array(<%=iNumOfItm%>);
var aCnl2Time = new Array(<%=iNumOfItm%>);

var aLine = new Array(); // save all sku for selected orders
var aLineSn = new Array(); // save all sku/serial numbers for selected orders
var aSelOrd = new Array();

document.onkeyup=catchEscape

var StrTime = new Date();
var EndTime = null;

var SelStr = [<%=sSelStrJsa%>];
var PackId = 0;
var SbmFunc = "";

var frameNum = 100;

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   if (ua.match(/iPad/i) || ua.match(/iPhone/i)) 
   {  
	   isSafari = true;
	   setDraggable();
   }
   else
   {
	   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   }
   
	
   setSelectPanelShort();   
   foldColmn("cellFold1");
   foldColmn("cellFold2");

   window.scroll(0, Top);
}
//==============================================================================
// set Short form of select parameters
//==============================================================================
function setSelectPanelShort()
{
   var hdr = "Select Report Parameters";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='RestoreButton.bmp' onclick='javascript:setSelectPanel();' alt='Restore'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"
   html += "</td></tr></table>"
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0)
   {
	   document.all.dvSelect.style.width = "250";
   }
   else 
   {
	   document.all.dvSelect.style.width = "auto";
   }
   
   document.all.dvSelect.innerHTML=html;
}
//==============================================================================
// set Weekly Selection Panel
//==============================================================================
function setSelectPanel()
{
  var hdr = "Select Report Parameters";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='MinimizeButton.bmp' onclick='javascript:setSelectPanelShort();' alt='Minimize'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popSelPanel();

   html += "</td></tr></table>"
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0)
   {
	   document.all.dvSelect.style.width = "250";
   }
   else 
   {
	   document.all.dvSelect.style.width = "auto";
   }
  
   document.all.dvSelect.innerHTML=html;
   if(ArrStr.length == 1) { doStrSelect(); }
    else{ setStrSel(); }

   document.all.tdDate1.style.display="block"
   document.all.tdDate2.style.display="none"
   doSelDate(1);
}
//==============================================================================
// populate selection panel
//==============================================================================
function popSelPanel()
{
   var panel = "<TABLE class='DataTable'>"
        + "<TR>"
           + "<TD class='Cell2' colspan=5>Order Store Assigning Statuses</TD>"
        + "</tr>"
        + "<tr>"
            + "<TD class='Cell1' colspan=5>"
              + "<a href='javascript: chkStsAll(this, true)'>All</a> &nbsp;"
              + "<a href='javascript: chkStsAll(this, false)'>Reset</a> &nbsp;"
        + "<tr>"
           + "<TD class='Cell1' nowrap>"
              + "<input class='Small' name='Sts' type='checkbox' value='Assigned' checked>Assigned &nbsp;"
              + "<input class='Small' name='Sts' type='checkbox' value='Printed' checked>Printed &nbsp;"
              + "<input class='Small' name='Sts' type='checkbox' value='Picked' checked>Picked &nbsp;"
              + "<input class='Small' name='Sts' type='checkbox' value='Shipped' checked>Shipped &nbsp;"
              + "<input class='Small' name='Sts' type='checkbox' value='Cannot Fill'>Cannot Fill &nbsp;"
              + "<input class='Small' name='Sts' type='checkbox' value='Canceled'>Canceled"
            + "</td>"
        + "</TR>"

     //  store selection
   if(ArrStr.length == 1)
   {
     panel += "<tr>"
        + "<td  colspan='5' ><br>Select Store: <SELECT class='Small' name='Store'></SELECT><br><br></td>"
        + "</tr>"
   }
   else
   {
      // Multiple Store selection
      panel += "<tr>"
            + "<td colspan='5' class='Small' nowrap>"

      for(var i=0; i < ArrStr.length; i++)
      {
        panel  += "<input class='Small' name='Str' type='checkbox' value='" + ArrStr[i] + "'>"  + ArrStr[i] + "&nbsp;"
        if(i > 0 && i % 14 == 0){ panel += "<br>" }
      }
      panel  += "<br><button class='Small' onClick='setAll(true)'>All Store</button> &nbsp;"
             + "<button onclick='checkReg(&#34;1&#34;)' class='Small'>Dist 1</button> &nbsp; &nbsp;"
             + "<button onclick='checkReg(&#34;2&#34;)' class='Small'>Dist 2</button> &nbsp; &nbsp;"
             + "<button onclick='checkReg(&#34;3&#34;)' class='Small'>Dist 3</button> &nbsp; &nbsp;"
             + "<button onclick='checkReg(&#34;99&#34;)' class='Small'>Dist 99</button> &nbsp; &nbsp;"
             + "<button onclick='checkReg(&#34;PATIO&#34;)' class='Small'>Patio</button> &nbsp; &nbsp;"
             + "<br>"
             + "<button onclick='checkDist(&#34;9&#34;)' class='Small'>Houston</button> &nbsp; &nbsp;"
             + "<button onclick='checkDist(&#34;20&#34;)' class='Small'>Dallas/FtW</button> &nbsp; &nbsp;"
             + "<button onclick='checkDist(&#34;35&#34;)' class='Small'>Ski Chalet</button> &nbsp; &nbsp;"
             + "<button onclick='checkDist(&#34;38&#34;)' class='Small'>Boston</button> &nbsp; &nbsp;"
             + "<button onclick='checkDist(&#34;41&#34;)' class='Small'>OKC</button> &nbsp; &nbsp;"
             + "<button onclick='checkDist(&#34;52&#34;)' class='Small'>Charl</button> &nbsp; &nbsp;"
             + "<button onclick='checkDist(&#34;53&#34;)' class='Small'>Nash</button> &nbsp; &nbsp;"
             + "<br>"
             + "<button onclick='checkMall(&#34;&#34;)' class='Small'>Mall</button> &nbsp; &nbsp;"
             + "<button onclick='checkMall(&#34;NOT&#34;)' class='Small'>Non-Mall</button> &nbsp; &nbsp;"
             + "<button class='Small' onClick='setAll(false)'>Reset</button><br><br>"
         + "</td>"
        + "</tr>"
     }

    // date selection
    panel += "<TR><TD class='Cell2' colspan=5>Select status changed dates</TD></tr>"
        + "<TR>"
          + "<TD id='tdDate1' colspan=4 align=center style='padding-top: 10px;' >"
             + "<button id='btnSelDates' onclick='showDates(1,1)'>Optional Order Date Selection</button>&nbsp;"
             + "<button id='btnSelDates' onclick='showDates(1,2)'>Today</button>&nbsp;"
             + "<button id='btnSelDates' onclick='showDates(1,3)'>Last 3 Days</button>"
          + "</td>"
          + "<TD id='tdDate2' colspan=4 align=center style='padding-top: 10px;' nowrap>"
             + "<b>From Date:</b>"
              + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;StsFrDate&#34;)'>&#60;</button>"
              + "<input class='Small' name='StsFrDate' type='text' size=10 maxlength=10>&nbsp;"
              + "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, &#34;StsFrDate&#34;)'>&#62;</button>"
              + "&nbsp;&nbsp;&nbsp;"
              + "<a href='javascript:showCalendar(1, null, null, 200, 400, document.all.StsFrDate)' >"
              + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>"

    for(var i=0; i < 20; i++)
    {
       panel += "&nbsp;";
    }

    panel += "<b>To Date:</b>"
              + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;StsToDate&#34;)'>&#60;</button>"
              + "<input class='Small' name='StsToDate' type='text' size=10 maxlength=10>&nbsp;"
              + "<button class='Small' name='Up' onClick='setDate(&#34;UP&#34;, &#34;StsToDate&#34;)'>&#62;</button>"
              + "&nbsp;&nbsp;&nbsp;"
              + "<a href='javascript:showCalendar(1, null, null, 200, 400, document.all.StsToDate)' >"
              + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a><br>"
              + "<button id='btnSelDates' onclick='showAllDates(1)'>Prior 7 days</button>"
          + "</TD>"
        + "</TR>"
        + "<TR>"
          + "<TD class='Cell2' align=center colSpan=5>Optional Selection</TD>"
        + "</TR>"
        + "<TR>"
          + "<TD align=center colSpan=5>"
             + "Select SKU: <INPUT name=Sku class='Small' maxlength=10 size=10>"
             + "&nbsp; - or -  &nbsp;"
             + "Select Order: <INPUT name=Order class='Small' maxlength=10 size=10>"
          + "</TD>"
        + "</TR>"
        + "<TR>"
          + "<TD align=center colSpan=5>"
               + "<INPUT type=submit value=Submit name=SUBMIT onClick='Validate()'>"
         + "</TD>"
        + "</TR>"

    panel += "</table>"
    return panel;
}
//==============================================================================
// check All Status
//==============================================================================
function chkStsAll(chko, check)
{
   var sts = document.all.Sts;
   for(var i=0; i < sts.length; i++) { sts[i].checked = check; }
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id)
{
    var df = document.all;
    var j = 0;
    j=1;

    for (var i=0; j < ArrStr.length; i++, j++)
    {
      df.Store.options[i] = new Option(ArrStr[j] + " - " + ArrStrNm[j], ArrStr[j]);
    }
    document.all.Store.selectedIndex=0;
}
//==============================================================================
// set selected multiple stores
//==============================================================================
function setStrSel()
{
   var str = document.all.Str;
   for(var i=0; i < str.length; i++)
   {
       for(var j=0; j < SelStr.length; j++)
       {
          if(str[i].value == SelStr[j]){ str[i].checked=true; }
       }
   }
}
//==============================================================================
// check All Status
//==============================================================================
function chkStsAll(chko, check)
{
   var sts = document.all.Sts;
   for(var i=0; i < sts.length; i++) { sts[i].checked = check; }
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
// show date selection
//==============================================================================
function showDates(type, optdt)
{
   if(type==1)
   {
     document.all.tdDate1.style.display="none"
     document.all.tdDate2.style.display="block"
   }
   else
   {
     document.all.tdDate3.style.display="none"
     document.all.tdDate4.style.display="block"
   }
   doSelDate(optdt)
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates(type)
{
   if(type==1)
   {
      document.all.tdDate1.style.display="block"
      document.all.tdDate2.style.display="none"
      doSelDate(1);
   }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(type)
{
  var df = document.all;
  var date = new Date();

  df.StsToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
  date = new Date(new Date() - 7 * 86400000);
  if (type==2){ date = new Date(); }
  else if (type==3){ date = new Date(new Date() - 3 * 86400000); }

  df.StsFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";

  // selected status
  var sts = new Array();
  var sel = false;
  for (var i=0, j=0; i < document.all.Sts.length; i++)
  {
     if(document.all.Sts[i].checked) { sts[j++] = document.all.Sts[i].value; sel = true; }
  }
  if(!sel) {error = true; msg += "Select at least 1 status"}

  // store
  var str = document.all.Store.value;

  // order date
  var stsfrdate = document.all.StsFrDate.value;
  var ststodate = document.all.StsToDate.value;

  var sku = document.all.Sku.value.trim();
  var ord = document.all.Order.value.trim();

  if (error) alert(msg);
  else{ sbmPlan(sts, stsfrdate, ststodate, str, sku, ord) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(sts, stsfrdate, ststodate, str, sku, ord)
{
  var url = null;
  url = "MozuSrlAsgMlt.jsp?"
      + "StsFrDate=" + stsfrdate
      + "&StsToDate=" + ststodate
      + "&Str=" + str
      + "&Sku=" + sku
      + "&Ord=" + ord

  for(var i=0; i < sts.length; i++) { url += "&Sts=" + sts[i] }

  //alert(url)  
  window.location.href=url;
}

//==============================================================================
// run on loading
//==============================================================================
function catchEscape()
{
   var key = window.event
   if (key.keyCode=="27"){ hidePanel(); }
}

//==============================================================================
//set Packing ID
//==============================================================================
function rtvPickedItem(line)  
{ 
  	  var hdr = "Order: " + aOrd[line];
	  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popPickedItem(line)
	     + "</td></tr>"
	   + "</table>"

	  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "250";}
	  else { document.all.dvItem.style.width = "auto";}
	   
	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.left=getLeftScreenPos() + 30;
	  document.all.dvItem.style.top=getTopScreenPos() + 100;
	  document.all.dvItem.style.visibility = "visible";
	  
	  if(User.indexOf("w7")==0){ document.all.Emp.readOnly = true; } 
}
//==============================================================================
//populate picked Item
//==============================================================================
function popPickedItem(line)
{
	searchOrd(line, "Shipped");
	
	var panel = "<table cellPadding='0' cellSpacing='0' border=1>";
	panel += "<tr class='DataTable4'>"
		 + "<td nowrap class='Medium'colspan=10>Employee: "
		    + "<input class='Small' name='Emp' size=4 maxlength=4>"
		 + "</td>"
	  + "</tr>"
		  
	for(var i=0; i < aLine.length;i++)
	{
	    panel += "<tr class='DataTable4'>"
	      + "<td nowrap class='Medium' id='tdSkuEnt" + i + "'><b>"
	         + "SKU: " + aSku[aLine[i]]
	         + "<br>UPC: " + aUpc[aLine[i]]
	         + "<br>Desc: " + aDesc[aLine[i]]
	         + "<br>Vendor: " + aVenNm[aLine[i]]

	    panel += "</b></td>"
		for(var j=0; j < aLineSn[i].length;j++)
		{	      		
		  panel += " <td nowrap id='tdSkuInp" + i + "'>"		       
		         + "Picked Qty: <b>" + aPckQty[aLine[i]][aLineSn[i][j]] + "<b>"
		  if(aPckQty[aLine[i]][aLineSn[i][j]] == '1')
		  {
			  panel += "<br>Packing now<input type='checkbox' value='Y' id='GenId" + i + "S" + j + "'>"
		  }
		  panel += "</td>"
		}
    
	    var icol = aSts[aLine[i]].length + 1;
	    panel += "</tr><tr><td colspan='" + icol + "' style='font-size:1px; background: darkred'>&nbsp;</td></tr>"
    }

	panel += "</tr>";
	
    panel += "<tr class='DataTable4'>"
	      + "<td id='tdErrorAll' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
	    + "</tr>"

	panel += "<tr class='DataTable4'>"
	      + "<td nowrap class='Small' colspan=10><button onClick='vldPacking("
	         + "&#34;" + line + "&#34;"
	         + ")' class='Small' id='btnPostPackId'>Submit</button>"
	         + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
		  + "</td></tr>"
	
	return panel;	  
}
//==============================================================================
//validate sts and qty changes
//==============================================================================
function vldPacking(line)
{
 var error = false;
 var msg = "";
 var numsel = 0;
 var br = "";
 document.all.tdErrorAll.innerHTML = "";
 document.all.btnPostPackId.disabled = true;
 aSelOrd = new Array();
 
 var empnm = "Emp";
 var emp = document.all[empnm].value.trim();
 if(!User.indexOf("w7")==0)
 {
 	if(emp==""){error = true; msg += br + "Please enter your employee number"; br = "<br>"; }
 	else if(isNaN(emp)){error = true; msg += br + "<br>The employee number is not numeric"; br = "<br>"; }
 	else if (!isEmpNumValid(emp)){error = true; msg += br + "Employee number is invalid."; br = "<br>"; }
 }
 else{ emp=User; }
  

 for(var i=0; i < aLine.length; i++)
 {
    // check if order has at least 1 sku/serial number with requered status
    for(var j=0; j < aLineSn[i].length;j++)
    {
       if(aPckQty[aLine[i]][aLineSn[i][j]] > 0)
       {
           var genid = "GenId" + i + "S" + j;
           var chkgenid = document.all[genid];
           if( chkgenid.checked )
           {
              numsel++;
              aSelOrd[aSelOrd.length] = [aSite[aLine[i]],aOrd[aLine[i]],aSku[aLine[i]]
               ,aStr[aLine[i]], emp, "PostPackId", aSrln[aLine[i]][aLineSn[i][j]]];
           }
       }
    }
 } 
 if(numsel == 0){ error=true; msg += br + "Please select at least one item."; br = "<br>"; }
 
 if(error)
 { 
	 document.all.tdErrorAll.innerHTML = msg; 
	 document.all.btnPostPackId.disabled = false; 
 }
 else if(!error)
 {
	 PackId = getPackId();
	 if(PackId !="" && PackId != "0")
	 {
	 	sbmPostPackId(-1);
	 }
	 else 
	 {
		alert("The Packing Id was not generated. Please try again."); 
	 }
 }
}
//==============================================================================
//submit store status changes
//==============================================================================
function sbmPostPackId(arg)
{  
     if(isIE){ nwelem = window.frame1.document.createElement("div"); }
 	 else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
 	 else{ nwelem = window.frame1.contentDocument.createElement("div");}
     
     nwelem.id = "dvSbmPostPackId";
   	 var html = "<form name='frmPostPackId'"
       + " METHOD=Post ACTION='MozuSrlAsgMltSave.jsp'>";
    	        
	 for(var i=0; i < aSelOrd.length;i++)
     {
		html += "<input name='Site'>"
        + "<input name='Order'>"
        + "<input name='Sku'>"
        + "<input name='Str'>"
        + "<input name='Emp'>"
        + "<input name='Action'>"
        + "<input name='Arg'>"
        + "<input name='Srn'>"
        + "<input name='PackId'>"
        + "<input name='LastArg'>"
        ;       
     }
	 
	 html += "</form>"
     
     nwelem.innerHTML = html;
     
     if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
     else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
     else if(isSafari){ window.frame1.document.body.appendChild(nwelem); }
     else{ window.frame1.contentDocument.body.appendChild(nwelem); }

     for(var i=0; i < aSelOrd.length;i++)
     {     
    	var sel = aSelOrd[i];
    	 
     	if(isIE || isSafari)
 	 	{
     		if(aSelOrd.length == 1){setPostPack_IeSngFld(sel); }
  			else{ setPostPack_IeMltFld(sel, i); }  
 	 	}
     	else
     	{
     		if(aSelOrd.length == 1){setPostPack_ChromeSngFld(sel); }
  			else{ setPostPack_ChromeMltFld(sel, i); }  
   	  	}
     } 
     
     if(isIE || isSafari) {window.frame1.document.frmPostPackId.submit(); }
     else { window.frame1.contentDocument.forms[0].submit(); }
}
//==============================================================================
// set Packing for IE, single line
//==============================================================================
function setPostPack_IeSngFld(sel)
{
	window.frame1.document.all.Site.value = sel[0]; 	 
	window.frame1.document.all.Order.value = sel[1];
    window.frame1.document.all.Sku.value = sel[2];
    window.frame1.document.all.Str.value = sel[3];
    window.frame1.document.all.Emp.value = sel[4];
	window.frame1.document.all.Action.value= sel[5];
	window.frame1.document.all.Arg.value="0";
	window.frame1.document.all.Srn.value=sel[6];
	window.frame1.document.all.PackId.value=PackId;}
//==============================================================================
// set Packing for IE, multiple line 
//==============================================================================
function setPostPack_IeMltFld(sel, i)
{
	window.frame1.document.all.Site[i].value = sel[0]; 	 
	window.frame1.document.all.Order[i].value = sel[1];
    window.frame1.document.all.Sku[i].value = sel[2];
    window.frame1.document.all.Str[i].value = sel[3];
    window.frame1.document.all.Emp[i].value = sel[4];
	window.frame1.document.all.Action[i].value= sel[5];
	window.frame1.document.all.Arg[i].value=i;
	window.frame1.document.all.Srn[i].value=sel[6];
	window.frame1.document.all.PackId[i].value=PackId;
}
//==============================================================================
//set Packing for Chrome, single line
//==============================================================================
function setPostPack_ChromeSngFld(sel)
{
	window.frame1.contentDocument.forms[0].Str.value = sel[0]; 	
	window.frame1.contentDocument.forms[0].Order.value = sel[1];
    window.frame1.contentDocument.forms[0].Sku.value = sel[2];
    window.frame1.contentDocument.forms[0].Str.value = sel[3];
    window.frame1.contentDocument.forms[0].Emp.value = sel[4];
	window.frame1.contentDocument.forms[0].Action.value= sel[5];
	window.frame1.contentDocument.forms[0].Arg.value=arg;
	window.frame1.contentDocument.forms[0].Srn.value=sel[6];
	window.frame1.contentDocument.forms[0].PackId.value=PackId;	  
}
//==============================================================================
//set Packing for Chrome, multiple line 
//==============================================================================
function setPostPack_ChromeMltFld(sel, i)
{
	window.frame1.contentDocument.forms[0].Str[i].value = sel[0]; 	
	window.frame1.contentDocument.forms[0].Order[i].value = sel[1];
    window.frame1.contentDocument.forms[0].Sku[i].value = sel[2];
    window.frame1.contentDocument.forms[0].Str[i].value = sel[3];
    window.frame1.contentDocument.forms[0].Emp[i].value = sel[4];
	window.frame1.contentDocument.forms[0].Action[i].value= sel[5];
	window.frame1.contentDocument.forms[0].Arg[i].value=arg;
	window.frame1.contentDocument.forms[0].Srn[i].value=sel[6];
	window.frame1.contentDocument.forms[0].PackId[i].value=PackId;
}
//==============================================================================
// reprint by PackID
//==============================================================================
function rePrintByPackId(packid)
{
	var hdr = "Pack Id: " + packid;
  	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popReprintByPackId(packid)
	     + "</td></tr>"
	   + "</table>"

	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "250";}
	else { document.all.dvItem.style.width = "auto";}
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.left=getLeftScreenPos() + 30;
	document.all.dvItem.style.top=getTopScreenPos() + 100;
	document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate picked Item
//==============================================================================
function popReprintByPackId(packid)
{	
	var panel = "<table cellPadding='0' cellSpacing='0' border=1>";
	panel += "<tr class='DataTable4'>"
		 + "<td nowrap >&nbsp;<br>&nbsp;Press 'Submit' button to re-print this pack id.&nbsp;<br>&nbsp;</td>"
	  + "</tr>"
    
	panel += "<tr class='DataTable4'>"
	  + "<td nowrap class='Small1' colspan=10><button onClick='sbmReprintByPackId("
	        + "&#34;" + packid + "&#34;"
	        + ")' class='Small' id='btnPostPackId'>Submit</button>"
	        + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
	  + "</td>" 
	+ "</tr>";
	return panel;
}
//==============================================================================
//submit reprint by pack id
//==============================================================================
function sbmReprintByPackId(packid)
{
	url = "MozuSrlAsgMltSave.jsp?PackId=" + packid
	 + "&Action=RePrtPackId"
	;
	if(isIE || isSafari){ window.frame1.location.href = url; }
    else if(isChrome || isEdge) { window.frame1.src = url; }
}
//==============================================================================
//get pack id
//==============================================================================
function reSendToFx(str, ord, packid)
{
	url = "MozuSendToFx.jsp?Str=" + str + "&Order=" + ord + "&PackId=" + packid;
	if(isIE || isSafari){ window.frame1.location.href = url; }
    else if(isChrome || isEdge) { window.frame1.src = url; }
}
//==============================================================================
// get pack id
//==============================================================================
function getPackId()
{
   var sel = aSelOrd[0];
   
   var packid = "0";	 
   var url = "MozuGetFedExPackId.jsp?Site=" + sel[0] + "&Order=" + sel[1] + "&Action=PostPackId";
   var xmlhttp;
   // code for IE7+, Firefox, Chrome, Opera, Safari
   if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
   // code for IE6, IE5
   else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

   xmlhttp.onreadystatechange=function()  
   {
      if (xmlhttp.readyState==4 && xmlhttp.status==200)
      {
    	  packid = xmlhttp.responseText.trim();
      }
   }
   xmlhttp.open("GET",url,false); // synchronize with this apps
   xmlhttp.send();

return packid;
}
//==============================================================================
// set selected Quantity
//==============================================================================
function setQtySel(line, newSts, pickqty)
{
   var error = false;
   var msg = "";

   if(!error) {setStsQtySel(line, newSts, pickqty);}
   else { alert(msg); }
}   
//==============================================================================
// set selected Quantity
//==============================================================================
function setStsQtySel(line, newSts, pickqty)
{
  objnm = "tdStrSts" + line
  SelObj = document.all[objnm];

  var qsnm = "Assign Qty & Status &nbsp; ";
  if(newSts == "Picked"){ qsnm = "Picked Qty & Status &nbsp; ";}
  else if(newSts == "Shipped"){ qsnm = "Shipped/Packed/Final &nbsp; ";}
  else if(newSts == "Problem"){ qsnm = "Problem on Order &nbsp; ";}

  var hdr = qsnm + "Order: " + aOrd[line];
  var html = "<table class='DataTable1'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popStsQtyPanel(line, newSts, pickqty)
     + "</td></tr>"
   + "</table>"

  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "250"; }
  else if(isSafari) { document.all.dvItem.style.width = "auto"; }
  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.left=getLeftScreenPos() + 30;
  document.all.dvItem.style.top=getTopScreenPos() + 115;
  document.all.dvItem.style.visibility = "visible";

  //populate quantity
  document.all.ScanSku.focus();
}
//==============================================================================
// populate quantity
//==============================================================================
function popStsQtyPanel(line, newSts, pickqty)
{
  searchOrd(line, newSts);
  var pos = getPosition(SelObj);
  var qtynm = "Assign Qty: ";
  if(newSts == "Picked"){qtynm = "Picked Qty: ";}
  else if(newSts == "Shipped"){qtynm = "Shipped Qty: ";}
  else if(newSts == "Problem"){qtynm = "Problem Qty: ";}

  var panel = "Scan Item: <input id='ScanSku' onkeypress='if (window.event.keyCode == 13) { searchScan(this.value.trim()); }' class='Small' maxlength=12 size=12>"
  if(newSts == "Problem"){ panel += "&nbsp; &nbsp; <span class='Warning'>Please report a problem here!</span>";}

  panel += "<table class='DataTable' >"
  
  for(var i=0; i < aLine.length;i++)
  {
     panel += "<tr class='DataTable'>"
        + "<td nowrap  class='DataTable1' id='tdSkuEnt" + i + "'><b>"
          + "SKU: " + aSku[aLine[i]]
          + "<br>UPC: " + aUpc[aLine[i]]
          + "<br>Desc: " + aDesc[aLine[i]]
          + "<br>Vendor: " + aVenNm[aLine[i]]

      panel += "</b></td>"
      for(var j=0; j < aLineSn[i].length;j++)
      {
         panel += " <td nowrap class='Small2' id='tdSkuInp" + i + "'>"
               + popSngSku(i, qtynm, newSts, aSts[aLine[i]][aLineSn[i][j]],j, pickqty ) + "</td>"

      }
      var icol = aSts[aLine[i]].length + 1;
      panel += "</tr><tr><td colspan='" + icol + "' style='font-size:1px; background: darkred'>&nbsp;</td></tr>"
  }

  panel += "<tr>"
       + "<td id='tdErrorAll' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
    + "</tr>"

  panel += "<tr>"
         + "<td nowrap class='Small' colspan=10><button onClick='ValidateStrPickSendQty("
            + "&#34;" + line + "&#34;"
            + ",&#34;" + newSts + "&#34;"
            + ")' class='Small' id='btnSbmStsQty'>Submit</button>"
       + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
    + "</td></tr>"
    
  if(aShipMeth[aLine[0]] == "905")
  {
	  panel += "<tr>"
	         + "<td class='tdWarn01' colspan=10>&nbsp;<br>Put" 
	         + " <span style='color:green; font-size:24px; text-shadow: 5px 5px 2px #ffff00;'>A GREEN STICKER</span>" 
	         + " on the box.<br>&nbsp;</button>"
	    + "</td></tr>"
  }

  panel += "</table>"

  return panel;
}
//==============================================================================
// populate single item for selected order
//==============================================================================
function popSngSku(i, qtynm, newSts, snsts, j, pickqty)
{
   var panel = "<table  class='DataTable1'>"
     + "<tr><td nowrap  class='DataTable1' colspan=2>Status: " + snsts + " &nbsp; &nbsp; Str: " + aStr[aLine[i]] + " </td></tr>"
     + "<tr class='DataTable'>"
       + "<td nowrap class='DataTable1'>" + qtynm + "</td>"
       + "<td nowrap class='DataTable1'>"
          + "<select class='Small' name='selQty" + i + "S" + j + "' id='selQty" + i + "S" + j + "'"
             + " onchange='chkExclSku(&#34;" + i + "&#34;,&#34;" + newSts + "&#34;,&#34;" + j + "&#34;)'>"
             + "<option value='-1'>-- not include --</option><option value='0'>0</option>"
   if(pickqty != 0){ panel += "<option value='1'>1</option>" }

   panel += "</select>"
       + "</td>"
     + "</tr>"
   panel += "</td></tr>"

   
   //if(newSts == "Shipped" || newSts == "Picked" && ( aStr[aLine[i]] == 1 || aStr[aLine[i]] == 70) )
   if(newSts == "Picked")
   {
     panel += "<tr class='DataTable'>"
       + "<td nowrap class='DataTable1' colspan=2>"
         + "<input type='checkbox' name='Excl" + i + "S" + j + "' id='Excl" + i + "S" + j + "' value='" + i + "' disabled>Add Sku to Exclusion"
         + "<br>Click&nbsp;"
           + "<a href='EComUncondExcl.jsp?Sku=" + aSku[aLine[i]] + "&Str=" + aStr[aLine[i]] + "' target='_blank'>&nbsp;here</a>"
           + " to see a sku in unconditional page"
       + "</td>"
     + "</tr>"
   }
   panel += "<tr class='DataTable'>"
       + "<td nowrap class='DataTable1'>Employee Number: </td>"
       + "<td nowrap  class='DataTable1'>"
          + "<input class='Small' name='Emp" + i + "S" + j + "' id='Emp" + i + "S" + j + "' size=4 maxlength=4"
   
   //disable employee number button for warehouse pickers
   if (User.indexOf("w7") == 0){ panel += " readonly "; }       
   
   panel += ">"
       + "</td>"
     + "</tr>"

   //if(newSts == "Shipped" || newSts == "Picked" && ( aStr[aLine[i]] == 1 || aStr[aLine[i]] == 70) )  
   if(newSts == "Picked")
   {
      panel += "<tr class='DataTable'>"
           + "<td nowrap class='DataTable1'>Reason: </td>"
           + "<td nowrap class='DataTable1'>"
              + "<select class='Small' name='Reason" + i + "S" + j + "' id='Reason" + i + "S" + j + "' onchange='setRtvStr(this," + i + "," + j + ")'>"
                 + "<option value='None'>-- select reason --</option>"
                 + "<option value='Fulfilled'>Completed</option>"
                 + "<option value='Cannot Locate'>Cannot Locate</option>"
                 + "<option value='RTV'>RTV</option>"
                 + "<option value='Soiled/Damaged'>Soiled/Damaged</option>"
                 + "<option value='Missing Pieces'>Missing Pieces</option>"
              + "</select>"
              + "<span id='spnRtvStr' style='display:none;'>To Store:&nbsp;"
                  + "<select class='Small' name='RtvStr" + i + "S" + j + "' id='RtvStr" + i + "S" + j + "'>"
                  	+ "<option value='45'>45</option>"
                  	+ "<option value='59'>59</option>"
                  	+ "<option value='99'>99</option>"
                  + "</select>"
              + "</span>"
           + "</td>"
        + "</tr>"
   }

   panel += "<tr class='DataTable'>"
       + "<td nowrap class='DataTable1'>Comment: </td>"
       + "<td nowrap class='DataTable1'><TextArea class='Small' name='txaNote" + i + "S" + j + "' id='txaNote" + i + "S" + j + "' cols=30 rows=3></TextArea></td>"
    + "</tr>"
    + "<tr>"
       + "<td id='tdError" + i + "S" + j + "' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
    + "</tr>"
   + "</table>"

   return panel;
}
//==============================================================================
// check if item must be excluded
//==============================================================================
function chkExclSku(arg, newSts, j)
{
   var selnm = "selQty" + arg + "S" + j;
   var qty = document.all[selnm].options[document.all[selnm].selectedIndex].value;
   if(newSts == "Shipped" || newSts == "Picked")
   {
      var exclnm = "Excl" + arg + "S" + j;
      if(qty == 0)
      {
    	  if(User.indexOf("w7") < 0)
    	  {    	  
    		  document.all[exclnm].checked = true; 
    	  }
    	  document.all[exclnm].disabled = false;
      }
      else{ document.all[exclnm].checked = false; document.all[exclnm].disabled = true;}
   }
}
//==============================================================================
// set RTV store 
//==============================================================================
function setRtvStr(sel,i,j)
{
	var reas = sel.options[sel.selectedIndex].value;
	var span = document.all.spnRtvStr;
	
    if(User.indexOf("w7") >=0 && (reas=="RTV" || reas == "Soiled/Damaged" || reas == "Missing Pieces"))
    {
    	span.style.display = "block";
    }
    else{ span.style.display = "none"; }
}
//==============================================================================
// search all sku for selected order
//==============================================================================
function searchScan(search)
{
   document.all.tdErrorAll.innerHTML = "";
   var sku = null;
   var upc = null;
   var arg = new Array();
   var cellnm;
   for(var i=0; i < aLine.length; i++)
   {      
	  if(aSku[aLine[i]] == eval(search)){ sku = aSku[aLine[i]]; arg[arg.length] = i;  }
      if(aUpc[aLine[i]] == search){ upc = aUpc[aLine[i]];  arg[arg.length] = i; }
   }

   // check against IP database - if UPC code is previously exists in order SKUs
   if(!sku && !upc)
   {
      var sresult = getScannedItem(search);
      if( sresult == "")
      {
         for(var i=0; i < aLine.length; i++)
         {
             if(aSku[aLine[i]].substring(3) == search){ sku = aSku[aLine[i]]; break; }
         }
         if(!sku){ document.all.tdErrorAll.innerHTML = "Item is not found on Order."; }
      }
      else
      {
    	 search = sresult;
         for(var i=0; i < aLine.length; i++)
         {      
      	    if(aSku[aLine[i]] == eval(search)){ sku = aSku[aLine[i]]; arg[arg.length] = i;  }
            if(aUpc[aLine[i]] == search){ upc = aUpc[aLine[i]];  arg[arg.length] = i; }
         }
      }
   }
   
   // scanned item is found
   if(sku || upc)
   {   
	   var found = false;
	   for(var i=0; i < arg.length;i++)
	   {    	  
	      
	   	// mark found item
      	cellnm = "tdSkuEnt" + arg[i];
      	document.all[cellnm].style.background="khaki";
      
      	for(var j=0; j < aLineSn[arg[i]].length;j++)
      	{      
      		// increment selected quantity if less than assinged
      		cellnm = "selQty" + arg[i] + "S" + j;
      		var sel = document.all[cellnm];
      		var cur = sel.selectedIndex;
      		var max = sel.length;
      
      		if(cur < (max - 1) && !sel.disabled)
      		{
         		if(cur==0){sel.selectedIndex = 2;}
         		else{sel.selectedIndex += 1;}
         		document.all.tdErrorAll.innerHTML = " ";
         		found = true;
         		break;
      		}
      		else if(sel.disabled){ document.all.tdErrorAll.innerHTML = "This item is not in right status."; }
      		else{ document.all.tdErrorAll.innerHTML = "The assigned quantity were reached."; }
      	}
      	if(found){ break;}
      }
   }
   document.all.ScanSku.value="";
}
//==============================================================================
// check scanned item against order
//==============================================================================
function getScannedItem(item)
{
   var valid = true;
   var sku = null;
   var url = "EComItmAsgValidItem.jsp?Item=" + item;

   var xmlhttp;
   // code for IE7+, Firefox, Chrome, Opera, Safari
   if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
   // code for IE6, IE5
   else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

   xmlhttp.onreadystatechange=function()
   {
      if (xmlhttp.readyState==4 && xmlhttp.status==200)
      {
         var  resp = xmlhttp.responseText;
         var beg = resp.indexOf("<UPC_Valid>") + 11;
         var end = resp.indexOf("</UPC_Valid>");
         valid = resp.substring(beg, end) == "true";

         var beg = resp.indexOf("<SKU>") + 5;
         var end = resp.indexOf("</SKU>");
         sku = resp.substring(beg, end).trim();
      }
   }
   xmlhttp.open("GET",url,false); // synchronize with this apps
   xmlhttp.send();

   //alert(sku.trim());
   return sku;
}
//==============================================================================
// search all sku for selected order
//==============================================================================
function searchOrd(line, newSts)
{
   var search = aOrd[line];
   var sel = new Array();
   var sn = new Array();
   for(var i=0; i < aOrd.length; i++)
   {
      if(aOrd[i] == search)
      {
         // check if order has at least 1 sku/serial number with requered status
         var vldStsSku = false;
         var sns = new Array();
         for(var j=0; j < aSrln[i].length;j++)
         {
            if(newSts == "Picked" && aSts[i][j] == "Printed"
               || newSts == "Problem" && aSts[i][j] == "Picked"
               || newSts == "Shipped"
                 && (aSts[i][j] == "Picked" /*|| aSts[i][j] == "Problem"*/ || aSts[i][j] == "Resolve"))
               {
                  vldStsSku = true;
                  sns[sns.length] = j;
               }
         }
         if(vldStsSku)
         {
            sel[sel.length] = i;
            sn[sn.length] = sns;
         }
      }
   }
   aLine = sel;
   aLineSn = sn;
}
//==============================================================================
// validate sts and qty changes
//==============================================================================
function ValidateStrPickSendQty(line, newSts)
{
    var error = false;
    var msg = "";
    var numsel = 0;
    document.all.tdErrorAll.innerHTML = "";
    document.all.btnSbmStsQty.disabled = true;
    aSelOrd = new Array();

    for(var i=0; i < aLine.length; i++)
    {
       // check if order has at least 1 sku/serial number with requered status
       var vldStsSku = false;
       for(var j=0; j < aLineSn[i].length;j++)
       {
          var qtynm = "selQty" + i + "S" + j;
          var selqty = document.all[qtynm];
          if(selqty.selectedIndex > 0 && !selqty.disabled)
          {
             numsel++;
             if (vldSngSku(line, i, newSts, j)){ error = true; }
          }
       }
    }

    if(numsel == 0){ error=true; document.all.tdErrorAll.innerHTML = "Please include at least 1 item in update." }
    else if(!error)
    { 
    	sbmStrPickSendQty(-1); 
    }

    if(error){ document.all.btnSbmStsQty.disabled = false; }
}
//==============================================================================
// validate assigned send  and
//==============================================================================
function vldSngSku(line, i, newSts, j)
{
    var error = false;
    var msg = "";
    var tderrnm = "tdError" + i + "S" + j;
    document.getElementById(tderrnm).innerHTML="";

    var qtynm = "selQty" + i + "S" + j;
    var qty = document.getElementById(qtynm).options[document.getElementById(qtynm).selectedIndex].value;
    if(qty== -1){ error = true; msg += "<br>Please enter SKU quantity."; }

    var empnm = "Emp" + i + "S" + j;
    var emp = document.getElementById(empnm).value.trim();
    if (!User.indexOf("w7") == 0)
    {
    	if(emp==""){error = true; msg += "<br>Please enter your employee number"; }
    	else if(isNaN(emp)){error = true; msg += "<br>The employee number is not numeric"; }
    	else if (!isEmpNumValid(emp)){error = true; msg += "<br>Employee number is invalid."; }
    }
    else{ emp = User; }
    
    var reas = " ";
    var rtvstr = " ";
    //if(newSts == "Shipped" || newSts == "Picked" && ( aStr[aLine[i]] == 1 || aStr[aLine[i]] == 70))
    if(newSts == "Picked")
    {
       var reasnm = "Reason" + i + "S" + j;
       var reas  = document.getElementById(reasnm).options[document.getElementById(reasnm).selectedIndex].value;
       var reasIdx = document.all[reasnm].selectedIndex;
       if(reasIdx != 1 && qty == 1){error = true; msg += "<br>Please select complete status."; }
       else if(reasIdx < 2 && qty == 0){error = true; msg += "<br>Please select incomplete reason."; }

       var exclnm = "Excl" + i + "S" + j;
       var excl = "N";
       if ( document.getElementById(exclnm).checked ){ excl = "Y"; }
       
       if(reas=="RTV" || reas == "Soiled/Damaged" || reas == "Missing Pieces")
       {
    	   var rtvnm = "RtvStr" + i + "S" + j;
    	   rtvstr = document.getElementById(rtvnm).options[document.getElementById(rtvnm).selectedIndex].value 
       } 	   
    }

    var notenm = "txaNote" + i + "S" + j;
    var noteobj = document.getElementById(notenm);
    var note = noteobj.value.trim();
    
    
    if(newSts == "Problem" && note == ""){error = true; msg += "<br>Please leave a comment."; }

    if(error){ document.getElementById(tderrnm).innerHTML=msg; }
    else
    {
        aSelOrd[aSelOrd.length] = [aSite[aLine[i]],aOrd[aLine[i]],aSku[aLine[i]]
        ,aStr[aLine[i]], newSts, qty, emp, reas, note, "CHGSTRSTS", excl, aSrln[aLine[i]][aLineSn[i][j]]
        , rtvstr ];
    }
    return error;
}
//==============================================================================
// check employee number
//==============================================================================
function isEmpNumValid(emp)
{
   var valid = true;
   var url = "EComItmAsgValidEmp.jsp?Emp=" + emp;
   var xmlhttp;
   // code for IE7+, Firefox, Chrome, Opera, Safari
   if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
   // code for IE6, IE5
   else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

   xmlhttp.onreadystatechange=function()
   {
      if (xmlhttp.readyState==4 && xmlhttp.status==200)
      {
         valid = xmlhttp.responseText.indexOf("true") >= 0;
      }
  }
  xmlhttp.open("GET",url,false); // synchronize with this apps
  xmlhttp.send();

  return valid;
}
//==============================================================================
// submit store status changes
//==============================================================================
function sbmStrPickSendQty(arg)
{
	  SbmFunc = "sbmStrPickSendQty";
       	   
      var nwelem = "";
    	
      if(isIE){ nwelem = window.frame1.document.createElement("div"); }
      else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
      else{ nwelem = window.frame1.contentDocument.createElement("div");}
      nwelem.id = "dvSbmStrSts"

      var html = "<form name='frmChgStrSts'"
           + " METHOD=Post ACTION='MozuSrlAsgMltSave.jsp'>";
      for(var i=0; i < aSelOrd.length;i++)
      {      
         html += "<input name='Site'>"
           + "<input name='Order'>"
           + "<input name='Sku'>"
           + "<input name='Str'>"
           + "<input name='Sts'>"
           + "<input name='Qty'>"
           + "<input name='Emp'>"
           + "<input name='Note'>"
           + "<input name='Action'>"
           + "<input name='Arg'>"
           + "<input name='Excl'>"
           + "<input name='Reas'>"
           + "<input name='Srn'>"
           + "<input name='RtvStr'>"
      }
      html += "</form>"

      nwelem.innerHTML = html;	
  	  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
  	  else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
  	  else if(isSafari){window.frame1.document.body.appendChild(nwelem);}
  	  else{ window.frame1.contentDocument.body.appendChild(nwelem); }
         	
  	  for(var i=0; i < aSelOrd.length;i++)
      {
  		var sel = aSelOrd[i];
  		if(isIE || isSafari)
		{
  			if(aSelOrd.length == 1){setStsChg_IeSngFld(sel); }
  			else{ setStsChg_IeMltFld(sel, i); }       		
		}
  		else
		{
  			if(aSelOrd.length == 1){setStsChg_ChromeSngFld(sel); }
  			else{ setStsChg_ChromeMltFld(sel, i); }	
        }
     }
  	  
     if(isIE || isSafari) { window.frame1.document.frmChgStrSts.submit(); }
     else{ window.frame1.contentDocument.forms[0].submit(); }
}
//==============================================================================
//set Status Change for IE / Safari browser if 1 serail number selected
//==============================================================================
function setStsChg_IeSngFld(sel)
{
	note = sel[8].replace(/\n\r?/g, '<br />');
	
	window.frame1.document.all.Site.value = sel[0];
	window.frame1.document.all.Order.value = sel[1];
	window.frame1.document.all.Sku.value = sel[2];
	window.frame1.document.all.Str.value = sel[3];
	window.frame1.document.all.Sts.value = sel[4];
	window.frame1.document.all.Qty.value = sel[5];
	window.frame1.document.all.Emp.value = sel[6];
	window.frame1.document.all.Note.value = "<REASON>" + sel[7] + "</REASON>" + note;
	window.frame1.document.all.Action.value=sel[9];
	window.frame1.document.all.Arg.value="0";
	window.frame1.document.all.Excl.value=sel[10];
	window.frame1.document.all.Reas.value=sel[7];
	window.frame1.document.all.Srn.value=sel[11];

  	if(User.indexOf("w7")>=0)
 	{
		window.frame1.document.all.RtvStr.value=sel[12];
	}
}
//==============================================================================
//set Status Change for IE / Safari browser if  > 1 serail number selected
//==============================================================================
function setStsChg_IeMltFld(sel, i)
{
	note = sel[8].replace(/\n\r?/g, '<br />');
	
	window.frame1.document.all.Site[i].value = sel[0];
	window.frame1.document.all.Order[i].value = sel[1];
	window.frame1.document.all.Sku[i].value = sel[2];
	window.frame1.document.all.Str[i].value = sel[3];
	window.frame1.document.all.Sts[i].value = sel[4];
	window.frame1.document.all.Qty[i].value = sel[5];
	window.frame1.document.all.Emp[i].value = sel[6];
	window.frame1.document.all.Note[i].value = "<REASON>" + sel[7] + "</REASON>" + note;
	window.frame1.document.all.Action[i].value=sel[9];
	window.frame1.document.all.Arg[i].value=i;
	window.frame1.document.all.Excl[i].value=sel[10];
	window.frame1.document.all.Reas[i].value=sel[7];
	window.frame1.document.all.Srn[i].value=sel[11];

	if(User.indexOf("w7")>=0)
	{
		window.frame1.document.all.RtvStr[i].value=sel[12];
	}
}
//==============================================================================
//set Status Change for Chrome browser if 1 serail number selected
//==============================================================================
function setStsChg_ChromeSngFld(sel)
{
	note = sel[8].replace(/\n\r?/g, '<br />');
	
	window.frame1.contentDocument.forms[0].Site.value = sel[0];
    window.frame1.contentDocument.forms[0].Order.value = sel[1];
    window.frame1.contentDocument.forms[0].Sku.value = sel[2];
    window.frame1.contentDocument.forms[0].Str.value = sel[3];
    window.frame1.contentDocument.forms[0].Sts.value = sel[4];
    window.frame1.contentDocument.forms[0].Qty.value = sel[5];
    window.frame1.contentDocument.forms[0].Emp.value = sel[6];
    window.frame1.contentDocument.forms[0].Note.value = "<REASON>" + sel[7] + "</REASON>" + note;
    window.frame1.contentDocument.forms[0].Action.value=sel[9];
    window.frame1.contentDocument.forms[0].Arg.value="0";
    window.frame1.contentDocument.forms[0].Excl.value=sel[10];
    window.frame1.contentDocument.forms[0].Reas.value=sel[7];
    window.frame1.contentDocument.forms[0].Srn.value=sel[11];
    
    if(User.indexOf("w7")>=0)
    {
  	  window.frame1.contentDocument.forms[0].RtvStr.value=sel[12];
    }
}
//==============================================================================
//set Status Change for Chrome browser if > 1 serail number selected
//==============================================================================
function setStsChg_ChromeMltFld(sel, i)
{
	note = sel[8].replace(/\n\r?/g, '<br />');
	
	window.frame1.contentDocument.forms[0].Site[i].value = sel[0];
  	window.frame1.contentDocument.forms[0].Order[i].value = sel[1];
  	window.frame1.contentDocument.forms[0].Sku[i].value = sel[2];
  	window.frame1.contentDocument.forms[0].Str[i].value = sel[3];
  	window.frame1.contentDocument.forms[0].Sts[i].value = sel[4];
  	window.frame1.contentDocument.forms[0].Qty[i].value = sel[5];
  	window.frame1.contentDocument.forms[0].Emp[i].value = sel[6];
  	window.frame1.contentDocument.forms[0].Note[i].value = "<REASON>" + sel[7] + "</REASON>" + note;
  	window.frame1.contentDocument.forms[0].Action[i].value=sel[9];
  	window.frame1.contentDocument.forms[0].Arg[i].value=i;
  	window.frame1.contentDocument.forms[0].Excl[i].value=sel[10];
  	window.frame1.contentDocument.forms[0].Reas[i].value=sel[7];
  	window.frame1.contentDocument.forms[0].Srn[i].value=sel[11];
  
  	if(User.indexOf("w7")>=0)
  	{
		window.frame1.contentDocument.forms[0].RtvStr.value=sel[12];
  	}
}
//==============================================================================
// set Cannot locate note
//==============================================================================
function setCnlNote(line, srln, newSts, str)
{
  objnm = "tdStrSts" + line
  SelObj = document.all[objnm];

  var hdr = "Cannot Locate Note. Order: " + aOrd[line];
  var html = "<table class='DataTable1'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popCnlNote(line, srln, newSts, str)
     + "</td></tr>"
   + "</table>"
  
  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "250"; }
  else { document.all.dvItem.style.width = "auto"; }
  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.left=getLeftScreenPos() + 400;
  document.all.dvItem.style.top=getTopScreenPos() + 100;
  document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate quantity
//==============================================================================
function popCnlNote(line, srln, newSts, str)
{
  var qtynm = "Cannot Locate";
  var panel = "<table  class='DataTable1'>"
  panel += "<tr>"
      + "<td nowrap class='Medium' id='tdSkuEnt'><b>"
        + "SKU: " + aSku[line]
        + "<br>UPC: " + aUpc[line]
        + "<br>Desc: " + aDesc[aLine[line]]
        + "<br>Vendor: " + aVenNm[line]
    panel += "</b></td>"
      + " <td nowrap class='Small'>" + popCnlNoteEnt(line, srln, qtynm, newSts) + "</td></tr>"
     + "<tr><td colspan=2 style='font-size:1px; background: darkred'>&nbsp;</td></tr>"

  panel += "<tr>"
         + "<td nowrap class='Small' colspan=2><button onClick='vldCnlNote("
            + "&#34;" + line + "&#34;"
            + ",&#34;" + srln + "&#34;"
            + ",&#34;" + newSts + "&#34;"
            + ",&#34;" + str + "&#34;"
            + ")' class='Small' id='btnSbmStsQty'>Submit</button>"
       + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
    + "</td></tr>"

  panel += "</table>"

  return panel;
}
//==============================================================================
// populate single item for selected order
//==============================================================================
function popCnlNoteEnt(line, srln, qtynm, newSts)
{
   var panel = "<table  class='DataTable1'>"
     + "<tr>"
       + "<td nowrap class='Medium' colspan=2>" + qtynm + "</td>"
     + "</tr>"

    panel += "<tr>"
       + "<td nowrap class='Small'>Employee Number: </td>"
       + "<td nowrap class='Small'>"
          + "<input class='Small' name='Emp' size=4 maxlength=4>"
       + "</td>"
     + "</tr>"

   panel += "<tr>"
       + "<td nowrap class='Small'>Comment: </td>"
       + "<td nowrap class='Small'><TextArea class='Small' name='txaNote' cols=30 rows=3></TextArea></td>"
    + "</tr>"
    + "<tr>"
       + "<td id='tdError0' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
    + "</tr>"
 + "</table>"

   return panel;
}
//==============================================================================
// set Note Text Area
//==============================================================================
function vldCnlNote(line, srln, newSts)
{
    var error = false;
    var msg = "";
    var tderrnm = "tdError0";
    document.all[tderrnm].innerHTML="";

    if(!User.indexOf("w7")==0)
    {
    	var empnm = "Emp";
    	var emp = document.all[empnm].value.trim();
    	if(emp==""){error = true; msg += "<br>Please enter your employee number"; }
    	else if(isNaN(emp)){error = true; msg += "<br>The employee number is not numeric"; }
    	else if (!isEmpNumValid(emp)){error = true; msg += "<br>Employee number is invalid."; }
    	else if(!chkCnlUser(line, srln, emp)){ error = true; msg += "<br>Employee number is already used."; }
    }
    else{ emp=User; }

    var notenm = "txaNote"
    var note = document.all[notenm].value.trim();

    if(error){ document.all[tderrnm].innerHTML=msg; }
    else { sbmCnlNote(line, srln, emp, note) }
}
//==============================================================================
// check CNL user
//==============================================================================
function chkCnlUser(line, srln, emp)
{
   var valid=true;
   for(var i=0; i < aSrln[line].length; i++)
   {
      if(aSrln[line][i] == srln)
      {
         if( aCnl1User[line][i] != "" &&  aCnl1User[line][i] == emp)
         {
             valid=false; break;
         }
      }
   }
   return valid;
}
//==============================================================================
// submit store status changes
//==============================================================================
function sbmCnlNote(line, srln, emp, note)
{
   var nwelem = window.frame1.document.createElement("div");
   nwelem.id = "dvSbmStrSts"
   aSelOrd = new Array();

   var html = "<form name='frmChgStrSts'"
    + " METHOD=Post ACTION='MozuSrlAsgMltSave.jsp'>"
    + "<input name='Site'>"
    + "<input name='Order'>"
    + "<input name='Sku'>"
    + "<input name='Srn'>"
    + "<input name='Str'>"
    + "<input name='Emp'>"
    + "<input name='Note'>"
    + "<input name='Action'>"
   html += "</form>"

   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Site.value = aSite[line];
   window.frame1.document.all.Order.value = aOrd[line];
   window.frame1.document.all.Sku.value = aSku[line];
   window.frame1.document.all.Str.value = aStr[line];
   window.frame1.document.all.Srn.value = srln;
   window.frame1.document.all.Emp.value = emp;

   note = note.replace(/\n\r?/g, '<br />');
   window.frame1.document.all.Note.value = note;
   window.frame1.document.all.Action.value="ADDCNL";

   window.frame1.document.frmChgStrSts.submit();
}
//==============================================================================
// set Note Text Area
//==============================================================================
function sendEmail(line)
{
  objnm = "tdStrSts" + line
  SelObj = document.all[objnm];

  var hdr = "E-Mail. Order: " + aOrd[line];
  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popEmail(line)
     + "</td></tr>"
   + "</table>"

  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "250"; }
  else { document.all.dvItem.style.width = "auto"; } 
  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.left=getLeftScreenPos() + 400;
  document.all.dvItem.style.top=getTopScreenPos() + 100;
  document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// Populate email apanel
//==============================================================================
function popEmail(line)
{
   var panel = "<table cellPadding='0' cellSpacing='0'>"
    + "<tr>"
       + "<td nowrap colspan=2><b>Sku: " + aSku[line] + "&nbsp;" + aDesc[line] +  "<b></td>"
    + "</tr>"
    + "<tr>"
       + "<td class='Small' nowrap>Send To:</td>"
       + "<td class='Small' nowrap><input class='Small' id='Addr' maxlength=50 size=50></td>"
    + "</tr>"
    + "<tr>"
       + "<td class='Small' nowrap>Note:</td>"
       + "<td class='Small' nowrap><TextArea class='Small' id='txaNote' cols=30 rows=3></TextArea></td>"
    + "</tr>"
    + "<tr>"
       + "<td id='tdError0' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
    + "</tr>"

    + "<tr>"
       + "<td nowrap>"
         + "<button onClick='vldSndEmail(&#34;" + line + "&#34;)' class='Small'>Submit</button>"
         + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
    + "</td></tr></table>"

   return panel;
}
//==============================================================================
// validate assigned send  and
//==============================================================================
function vldSndEmail(line)
{
    var error = false;
    var msg = "";
    document.all.tdError0.innerHTML="";

    var addr = document.all.Addr.value.trim();
    if(addr==""){error = true; msg += "Please enter email address."; }

    var note = document.all.txaNote.value.trim();
    if(note==""){error = true; msg += "Please enter note."; }

    if(error){ document.all.tdError0.innerHTML=msg; }
    else{ sbmSndEmail(line, addr, note); }
}
//==============================================================================
// submit store status changes
//==============================================================================
function sbmSndEmail(line, addr, note)
{
    note = note.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvEmail"

    var html = "<form name='frmEmail'"
       + " METHOD=Post ACTION='MozuSrlAsgMltSave.jsp'>"
       + "<input name='Site'>"
       + "<input name='Order'>"
       + "<input name='Sku'>"
       + "<input name='Str'>"
       + "<input name='Addr'>"
       + "<input name='Note'>"
       + "<input name='Action'>"
     html += "</form>"

   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Site.value = aSite[line];
   window.frame1.document.all.Order.value = aOrd[line];
   window.frame1.document.all.Sku.value = aSku[line];
   window.frame1.document.all.Str.value = aStr[line];
   window.frame1.document.all.Addr.value = addr;
   window.frame1.document.all.Note.value = note;
   window.frame1.document.all.Action.value="SENDEMAIL";

   window.frame1.document.frmEmail.submit();
}
//==============================================================================
// set Mail Tracking ID
//==============================================================================
function setMail(site, ord, sku, str, text, action, obj)
{
  SelObj = obj;

  var pos = getPosition(obj);
  var html = "<table cellPadding='0' cellSpacing='0'>"
    + "<tr>"
       + "<td nowrap>Mail #: <input class='Small' id='inpMail' size=30 maxlength=30></td>"
    + "</tr>"
    + "<tr>"
       + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
    + "</tr>"

    + "<tr>"
       + "<td nowrap><button onClick='ValidateMail("
         + "&#34;" + site + "&#34;,&#34;" + ord + "&#34;,&#34;" + sku + "&#34;"
         + ",&#34;" + str + "&#34;"
         + ",&#34;" + action + "&#34;"
         + ")' class='Small'>Chg</button>"
         + "<button onClick='hidePanel();' class='Small'>Close</button>"
    + "</td></tr></table>"

  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "250"; }
  else { document.all.dvItem.style.width = "auto"; }    
  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.left=getLeftScreenPos() + 400;
  document.all.dvItem.style.top=getTopScreenPos() + 100;
  document.all.dvItem.style.visibility = "visible";

  // populate quantity
  document.all.inpMail.value = text;
}
//==============================================================================
// validate assigned send  and
//==============================================================================
function ValidateMail(site,ord,sku,str,action)
{
    var error = false;
    var msg = "";
    document.all.tdError.innerHTML="";

    var note = document.all.inpMail.value.trim();
    if(note==""){error = true; msg += "Please enter mail number."; }

    if(error){ document.all.tdError.innerHTML=msg; }
    else{ sbmMail(site, ord, sku, str, note, action); }
}
//==============================================================================
// submit store status changes
//==============================================================================
function sbmMail(site, ord, sku, str, note, action)
{
    note = note.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmStrSts"

    var html = "<form name='frmChgStrSts'"
       + " METHOD=Post ACTION='MozuSrlAsgMltSave.jsp'>"
       + "<input name='Site'>"
       + "<input name='Order'>"
       + "<input name='Sku'>"
       + "<input name='Str'>"
       + "<input name='Note'>"
       + "<input name='Action'>"
     html += "</form>"

   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Site.value = site;
   window.frame1.document.all.Order.value = ord;
   window.frame1.document.all.Sku.value = sku;
   window.frame1.document.all.Str.value = str;
   window.frame1.document.all.Note.value = note;
   window.frame1.document.all.Action.value=action;

   window.frame1.document.frmChgStrSts.submit();
}
//==============================================================================
// set selected Quantity
//==============================================================================
function setStatus(site, ord, sku, sts, obj)
{
  SelObj = obj;

  var pos = getPosition(obj);
  var html = "<table cellPadding='0' cellSpacing='0'>"
    + "<tr>"
       + "<td nowrap class='Small'>Status: </td>"
       + "<td nowrap class='Small'><select class='Small' id='selSts'></select></td>"
    + "</tr>"

    + "<tr>"
       + "<td nowrap class='Small'>Employee Number: </td>"
       + "<td nowrap class='Small'><input class='Small' id='Emp' size=4 maxlength=4></td>"
    + "</tr>"

    + "<tr>"
       + "<td nowrap class='Small'>Comment: </td>"
       + "<td nowrap class='Small'><TextArea class='Small' id='txaNote' cols=30 rows=3></TextArea></td>"
    + "</tr>"

    + "<tr>"
       + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
    + "</tr>"

    + "<tr>"
       + "<td nowrap class='Small'><button onClick='ValidateSts(&#34;" + site + "&#34;,&#34;" + ord + "&#34;,&#34;" + sku + "&#34;)' class='Small'>Chg</button>"
       + "<button onClick='hidePanel();' class='Small'>Close</button>"
    + "</td></tr></table>"

  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "250"; }
  else { document.all.dvItem.style.width = "auto"; }
  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.left=getLeftScreenPos() + 400;
  document.all.dvItem.style.top=getTopScreenPos() + 100;
  document.all.dvItem.style.visibility = "visible";

  // populate quantity
  popStatus(site, ord, sku, sts);
}
//==============================================================================
// populate quantity
//==============================================================================
function popStatus(site, ord, sku, sts)
{
   var arg = 0;
   var sel = document.all.selSts;

   if(sts != "Open"){ sel.options[arg++] = new Option("Open", "Open"); }
   if(sts != "Assign"){ sel.options[arg++] = new Option("Assign", "Assign"); }
   if(sts != "Sent") {sel.options[arg++] = new Option("Sent", "Sent"); }
   if(sts != "Cancel"){ sel.options[arg++] = new Option("Cancel ", "Cancel"); }
}
//==============================================================================
// validate store status changes
//==============================================================================
function ValidateSts(site,ord,sku)
{
    var error = false;
    var msg = "";
    document.all.tdError.innerHTML="";

    var sts = document.all.selSts.options[document.all.selSts.selectedIndex].value;
    var emp = document.all.Emp.value.trim();
    if(emp==""){error = true; msg += "<br>Please enter your employee number"; }
    else if(isNaN(emp)){error = true; msg += "<br>The employee number is not numeric"; }

    var note = document.all.txaNote.value.trim();
    if(note==""){error = true; msg += "<br>Please enter note to explain statsus changes."; }

    if(error){ document.all.tdError.innerHTML=msg; }
    else{ sbmSts(site,ord,sku, sts, emp, note); }
}
//==============================================================================
// submit store status changes
//==============================================================================
function sbmSts(site,ord,sku, sts, emp, note)
{
    note = note.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmStrSts"

    var html = "<form name='frmChgStrSts'"
       + " METHOD=Post ACTION='MozuSrlAsgMltSave.jsp'>"
       + "<input name='Site'>"
       + "<input name='Order'>"
       + "<input name='Sku'>"
       + "<input name='Sts'>"
       + "<input name='Emp'>"
       + "<input name='Note'>"
       + "<input name='Action'>"
     html += "</form>"

   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Site.value = site;
   window.frame1.document.all.Order.value = ord;
   window.frame1.document.all.Sku.value = sku;
   window.frame1.document.all.Sts.value = sts;
   window.frame1.document.all.Emp.value = emp;
   window.frame1.document.all.Note.value = note;
   window.frame1.document.all.Action.value="CHGSTS";

   window.frame1.document.frmChgStrSts.submit();
}

//==============================================================================
// retreive comment for selected store
//==============================================================================
function getStrCommt(line)
{
   aLine = new Array();
   aLine[0] = line;

   url = "MozuSrlAsgMltCommt.jsp?"
      + "Site=" + aSite[line]
      + "&Order=" + aOrd[line]
      + "&Sku=" + aSku[line]
      + "&Str=" + aStr[line]
      + "&Action=GETSTRCMMT"
    
   if(isIE){ window.frame1.location.href = url; }
   else if(isChrome || isEdge) { window.frame1.src = url; }
   else if(isSafari){ window.frame1.location.href = url; }
}

//==============================================================================
// display comment for selected store
//==============================================================================
function showComments(site, order, sku, serial, str, type, emp, commt, recusr, recdt, rectm)
{
   var hdr = "Logging Information. Order:" + aOrd[aLine[0]] ;
   var html = "<table class='DataTable'>"
     + "<tr class='DataTable'>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popLog(type,emp, commt, recusr, recdt, rectm, str, serial)
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "650";}
   else { document.all.dvItem.style.width = "auto";} 
   
  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.left = getLeftScreenPos() + 300;
  document.all.dvItem.style.top = getTopScreenPos() + 100;
  document.all.dvItem.style.visibility = "visible";

}
//==============================================================================
// populate log andcomments panel
//==============================================================================
function popLog(type,emp, commt, recusr, recdt, rectm, str, serial)
{
   var panel = "<table class='DataTable1' id='tblLog'>"
    + "<tr  class='DataTable'>"
       + "<th class='DataTable'>Type</th>"
       + "<th class='DataTable'>S/N</th>"
       + "<th class='DataTable'>Store</th>"
       + "<th  class='DataTable' nowrap>Emp #</th>"
       + "<th class='DataTable'>Comment</th>"
       + "<th class='DataTable'>Recorded by</th>"
    + "</tr>"
   for(var i=0; i < commt.length; i++)
   {
      panel += "<tr class='DataTable'>"
        + "<td class='DataTable' nowrap>" + type[i] + "</td>"
        + "<td class='DataTable' nowrap>" + serial[i] + "</td>"
      if(str[i] != "0") { panel += "<td  class='DataTable' nowrap>" + str[i] + "&nbsp;</td>" }
      else{ panel += "<td  class='DataTable' nowrap>H.O.&nbsp;</td>" }

      panel += "<td  class='DataTable' nowrap>&nbsp;" + emp[i] + "</td>"
        + "<td class='DataTable'>" + commt[i] + "</td>"
        + "<td class='DataTable' nowrap>" + recusr[i] + " " + recdt[i] + " " + rectm[i] + "</td>"
   }

   panel += "</table>"
    + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
    + "<button onClick='printLog();' class='Small'>Print</button>"
    

  return panel;
}
//==============================================================================
//open new window with Log 
//==============================================================================
function printLog()
{
	var tbl = document.all.tblLog.outerHTML;
	  var WindowOptions =
	   'width=600,height=500, left=100,top=50, resizable=yes , toolbar=yes, location=yes, directories=no, status=yes, scrollbars=yes,menubar=yes';
	var win = window.open("", "PrintLog", WindowOptions);
	win.document.write(tbl);
	hidePanel();
}
//==============================================================================
// display return error from save process
//==============================================================================
function rtnWithError(arg, err)
{
   //var errnm = "tdError" + arg
   var errnm = "tdErrorAll"
   
   document.all[errnm].innerHTML = "";

   var br = "";
   for(var i=0; i < err.length; i++)
   {
      document.all[errnm].innerHTML = br + err[i];
      br = "<br>";
   }
}
//==============================================================================
// get object coordinats
//==============================================================================
function getPosition(obj)
{
   var pos = [0, 0];

   // position menu on the screen
   if (obj.offsetParent)
   {
     while (obj.offsetParent)
     {
       pos[0] += obj.offsetLeft
       pos[1] += obj.offsetTop
       obj = obj.offsetParent;
     }
   }
   else if (obj.x)
   {
     pos[0] += obj.x;
     pos[1] += obj.y;
   }
   return pos;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
   SelObj = null;
}
//==============================================================================
// resort table
//==============================================================================
function resort(sort)
{
  url = "MozuSrlAsgMlt.jsp?Sort=" + sort

  for(var i=0; i < SelStr.length;  i++) { url += "&Str=" + SelStr[i]; }
  for(var i=0; i < Sts.length;  i++) { url += "&Sts=" + Sts[i]; }

  url += "&StsFrDate=" + StsFrDate;
  url += "&StsToDate=" + StsToDate;

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// show error
//==============================================================================
function showError(err)
{
   var text = "";
   for(var i=0; i < err.length; i++){ text += "\n" + err[i]; }
   alert(text);
}
//==============================================================================
// update store quantity cell
//==============================================================================
function updStrProp(sku, sts, qty, action)
{
   SelObj.innerHTML = sts;
   SelObj.style.backgroundColor = "yellow";
   hidePanel();
}
//==============================================================================
// reload page
//==============================================================================
function restart(arg)
{
    url = "MozuSrlAsgMlt.jsp?Sort=<%=sSort%>"
    for(var i=0; i < SelStr.length;  i++) { url += "&Str=" + SelStr[i]; }
    for(var i=0; i < Sts.length;  i++) { url += "&Sts=" + Sts[i]; }
    url += "&StsFrDate=" + StsFrDate;
    url += "&StsToDate=" + StsToDate;

    var pos = [0,0];
    if(SelObj != null)
    {
       pos = getPosition(SelObj);
       pos[1] -= 2
    }
    url += "&Top=" + pos[1];
    url += "&Sku=<%=sSelSku%>" + "&Ord=<%=sSelOrd%>"

    window.location.href=url;
}
//==============================================================================
// re-use frame
//==============================================================================
function reuseFrame()
{
  window.frame1.close();
}
//==============================================================================
// print pick slip
//==============================================================================
function prtPackSlip(site, ord, str, printer, outq, outqlib, whsOrStr, str)
{
  var url = "EComOrdReprint.jsp?Site=" + site
      + "&Order=" + ord
  if (printer != null) { url += "&Printer=" + printer }
  if (outq != null) { url += "&Outq=" + outq + "&OutqLib=" + outqlib}
  url += "&WhsOrStr=" + whsOrStr
  url += "&Str=" + str

  //alert(url)
  //window.location.href=url
  if(isIE || isSafari){ window.frame1.location.href = url; }
  else if(isChrome || isEdge) { window.frame1.src = url; }
}
//==============================================================================
// set selected Quantity
//==============================================================================
function setStrSts(site, ord, sku, str, sts, obj)
{
  SelObj = obj;

  var pos = getPosition(obj);

  var hdr = "Print. Order: " + ord;
  var html = "<table class='DataTable1'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popStrStsPanel(site, ord, sku, str, sts)
     + "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "250"; }
   else { document.all.dvItem.style.width = "auto"; }
  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.left=getLeftScreenPos() + 400;
  document.all.dvItem.style.top=getTopScreenPos() + 100;
  document.all.dvItem.style.visibility = "visible";

  // populate quantity
  document.all.selSts.options[0] = new Option(sts, sts);
  
  }
//==============================================================================
// validate store status changes
//==============================================================================
function popStrStsPanel(site, ord, sku, str, sts)
{
   var panel = "<table class='DataTable1'>"
    + "<tr class='DataTable'>"
       + "<td nowrap class='Small'>Status: </td>"
       + "<td nowrap class='Small'><select class='Small' id='selSts'></select></td>"
    + "</tr>"
    + "<tr>"
       + "<td nowrap class='Small'>Employee Number: </td>"
       + "<td nowrap class='Small'><input class='Small' id='Emp' size=4 maxlength=4></td>"
    + "</tr>"
    + "<tr>"
       + "<td nowrap class='Small'>Comment: </td>"
       + "<td nowrap class='Small'><TextArea class='Small' id='txaNote' cols=30 rows=3></TextArea></td>"
    + "</tr>"

    + "<tr>"
       + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
    + "</tr>"

    + "<tr>"
         + "<td nowrap class='Small'><button onClick='ValidateStrSts(&#34;" + site + "&#34;,&#34;" + ord + "&#34;,&#34;" + sku + "&#34;,&#34;" + str + "&#34;)' class='Small'>Submit</button>"
       + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
    + "</td></tr></table>"

  return panel;
}

//==============================================================================
// validate store status changes
//==============================================================================
function ValidateStrSts(site,ord,sku,str)
{
    var error = false;
    var msg = "";
    document.all.tdError.innerHTML="";

    var aord = new Array();
    var asite = new Array();
    if(ord=="MARKED")
    {
       for(var i=0; i < NumOfItm; i++)
       {
          var ordnm = "PrtGrp" + i
          var sitenm = "PrtSite" + i
          if(document.all[ordnm] != null)
          {
            if(document.all[ordnm].checked)
            {
               aord[aord.length] = document.all[ordnm].value;
               asite[asite.length] = document.all[sitenm].value;
            }
          }
       }
       if(aord.length == 0){ error = true; msg += "<br>At least one order mast be marked for print."; }
    }

    var sts = document.all.selSts.options[document.all.selSts.selectedIndex].value;
    
    if(!User.indexOf("w7")==0)
    {
       var emp = document.all.Emp.value.trim();
       if(emp==""){error = true; msg += "<br>Please enter your employee number"; }
       else if(isNaN(emp)){error = true; msg += "<br>The employee number is not numeric"; }
    }    
    else{ emp = User; }
    

    var note = document.all.txaNote.value.trim();

    if(error){ document.all.tdError.innerHTML=msg; }
    else{ sbmStrSts(site,ord,sku,str, sts, emp, note, asite, aord); }
}
//==============================================================================
// submit store status changes
//==============================================================================
function sbmStrSts(site,ord,sku,str, sts, emp, note, asite, aord)
{
	clearIframeContent("frame1");
	var nwelem = "";
	
	note = note.replace(/\n\r?/g, '<br />');

	if(isIE){ nwelem = window.frame1.document.createElement("div"); }
	else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
	else{ nwelem = window.frame1.contentDocument.createElement("div");}
	
    nwelem.id = "dvSbmStrSts"

    var html = "<form name='frmChgStrSts'"
       + " METHOD=Post ACTION='MozuSrlAsgMltSave.jsp'>"
       + "<input name='Site'>"
       + "<input name='Order'>"
       + "<input name='Sku'>"
       + "<input name='Str'>"
       + "<input name='Sts'>"
       + "<input name='Emp'>"
       + "<input name='Note'>"
       + "<input name='Action'>"
       + "<input name='Srn'>"

     for(var i=0; i < aord.length ;i++)
     {
        html += "<input name='OrdL'>";
        html += "<input name='SiteL'>";
     }

     html += "</form>"

   nwelem.innerHTML = html;
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
   else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
   else if(isSafari){ window.frame1.document.body.appendChild(nwelem); }
   else{ window.frame1.contentDocument.body.appendChild(nwelem); }

   	if(isIE || isSafari)
	{
   		window.frame1.document.all.Site.value = site;	
   		window.frame1.document.all.Order.value = ord;
   		window.frame1.document.all.Sku.value = sku;
   		window.frame1.document.all.Str.value = str;
   		window.frame1.document.all.Sts.value = sts;
   		window.frame1.document.all.Emp.value = emp;
  		window.frame1.document.all.Note.value = note;
   		window.frame1.document.all.Action.value="CHGSTRSTS";
   		window.frame1.document.all.Srn.value = "0";

	    if(aord.length == 1)
   	    {
      		window.frame1.document.all.OrdL.value = aord[0];
      		window.frame1.document.all.SiteL.value = asite[0];
   	    }
   	    else
   	    {
      		for(var i=0; i < aord.length ;i++)
      		{
         		window.frame1.document.all.OrdL[i].value = aord[i];
         		window.frame1.document.all.SiteL[i].value = asite[i];
      		}
   	    }
   	    window.frame1.document.frmChgStrSts.submit();
	}
   	else
   	{
   		window.frame1.contentDocument.forms[0].Site.value = site;	
   		window.frame1.contentDocument.forms[0].Order.value = ord;
   		window.frame1.contentDocument.forms[0].Sku.value = sku;
   		window.frame1.contentDocument.forms[0].Str.value = str;
   		window.frame1.contentDocument.forms[0].Sts.value = sts;
   		window.frame1.contentDocument.forms[0].Emp.value = emp;
  		window.frame1.contentDocument.forms[0].Note.value = note;
   		window.frame1.contentDocument.forms[0].Action.value="CHGSTRSTS";
   		window.frame1.contentDocument.forms[0].Srn.value = "0";
   		
   		if(aord.length == 1)
   	    {
      		window.frame1.contentDocument.forms[0].OrdL.value = aord[0];
      		window.frame1.contentDocument.forms[0].SiteL.value = asite[0];
   	    }
   	    else
   	    {
      		for(var i=0; i < aord.length ;i++)
      		{
         		window.frame1.contentDocument.forms[0].OrdL[i].value = aord[i];
         		window.frame1.contentDocument.forms[0].SiteL[i].value = asite[i];
      		}
   	    }
   	    window.frame1.contentDocument.forms[0].submit();
   	}
}
//==============================================================================
//clear  iframe content
//==============================================================================
function clearIframeContent(id) 
{    
    try 
    {    	
    	if(isSafari)
    	{    		
    		try 
      	    {   
    			if(window.frame1.document.body == null)
    			{
    				var iframe = document.getElementById(id);
    				document.body.removeChild(iframe)
    				var frame = $("#frame0").clone();    			
    				document.appenChild(frame);
    			}
      		}
      		catch(e)
      		{
      			alert(e.message)
      		}
    	}
    	else
    	{
    		var iframe = document.getElementById(id);
    		var doc = (iframe.contentDocument)? iframe.contentDocument: iframe.contentWindow.document;
	    	doc.body.innerHTML = "";
    	}
	}
	catch(e) 
	{
	    //alert(e.message);
    }
    return false;
}
//==============================================================================
//show iframe content
//==============================================================================
function showIframeContent(id) 
{
	var iframe = document.getElementById(id);
    try 
    {
	      var doc = (iframe.contentDocument)? iframe.contentDocument: iframe.contentWindow.document;
	      alert(doc.body.innerHTML);
	}
	catch(e) {
	   alert(e.message);
	}
    return false;
}
//==============================================================================
// link to Return Validation page
//==============================================================================
function getSlsBySku(sku, str)
{
   //var date = new Date(new Date() - 30 * 86400000);
   //var from = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
   //date = new Date(new Date() - 86400000);
   //var to = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();

   var iEoY = 0;
   for(var i=0; i < PiYear.length; i++)
   {
       if(PiDesc[i].indexOf("End of Year PI") >= 0) { iEoY = i; break; }
   }
   var lastPI = PiYear[iEoY] + PiMonth[iEoY];

   url ="PIItmSlsHst.jsp?Sku=" + sku
       + "&SlsOnTop=1"
       + "&STORE=" + str
       + "&FromDate=01/01/0001"
       + "&ToDate=12/31/2999"
       + "&PICal=" + lastPI

   //alert(url)
   window.open(url, "_blank");
}
//==============================================================================
// fold/unfold columns
//==============================================================================
function foldColmn(objnm)
{
   var col = document.all[objnm];
   var disp = "none";
   if(col[0].style.display=="none"){ disp = "table-cell"; }
   for(var i=0; i < col.length; i++)
   {
       col[i].style.display = disp;
   }
}

//==============================================================================
// set selected reason
//==============================================================================
function  setReasStr(selReas)
{
  if(selReas.options[selReas.selectedIndex].value != "0")
  {
     document.all.Reason.value = selReas.options[selReas.selectedIndex].value;
     if (selReas.options[selReas.selectedIndex].value == "Intransit")
     {
        var expdt = document.all["ExpDt"];
        var date = new Date(new Date() - -86400000 * 3);
        expdt.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
        document.all.NoExpDt.checked = false;
        setExpDt(document.all.NoExpDt);
     }
  }
  else{document.all.Reason.value = ""; }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setExpDt(noexp)
{
   if(noexp.checked) { document.all.spnExpDt.style.display = "none"; }
   else{ document.all.spnExpDt.style.display = "inline"; }
}
//==============================================================================
// populate date with prior aor future dates
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// hide panel
//==============================================================================
function hidePanel()
{
   document.all.dvItem.innerHTML = "";
   document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
// reset checkbox for order printing
//==============================================================================
function resetPrtMrk()
{
   for(var i=0; i < NumOfItm; i++)
   {
      var objnm = "PrtGrp" + i
      if(document.all[objnm] != null)
      {
        document.all[objnm].checked = false;
      }
   }
}
//==============================================================================
// reset checkbox for order printing
//==============================================================================
function searchOrder(scanobj)
{
    var ord = scanobj.value.trim();
    scanobj.value = "";
    var fld = null;
    var line = 0;
    
    for(var i=0; i < aOrd.length; i++)
    {
        if(aOrd[i].indexOf(ord) >= 0){ line = i; fld = "tdOrd" + i; break; }
    }
    // order found
    if(fld != null)
    {
       var obj = document.all[fld];
       pos = getPosition(obj);
       obj.style.background = "yellow";
       //obj.select();
       window.scroll(0, pos[1] - 5);
       for(var i=0; i < aSts[line].length; i++)
       {	   
          if(aSts[line][i] == "Assigned") { setStrSts(aSite[line], aOrd[line], aSku[line], aStr[line], 'Printed', obj); break;}
          else if(aSts[line][i] == "Printed") { setQtySel(line, 'Picked');  break;}
          else if(aSts[line][i] == "Picked") { rtvPickedItem(line);  break;}
       }
    }
    else{ alert("Order is not found on the list"); }

}
//==============================================================================
// retreive Federal Express Tracking number
//==============================================================================
function rtvFedExTrack(str)
{  
  var url = "EComUPS_GetTrack.jsp?"
      + "Str=" + str;

  if(isIE || isSafari){ window.frame2.location.href = url; }
  else if(isChrome || isEdge) { window.frame2.src = url; }
}
//==============================================================================
// show CNL notes
//==============================================================================
function showCnl(user, date, time, obj)
{
  var pos = getPosition(obj);

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='Small' nowrap onmouseout='document.all.dvToolTip.style.visibility = &#34;hidden&#34;'>"
       + user + "&nbsp;" + date + "&nbsp;" + time
       + "</td></tr>"
   + "</table>"

  document.all.dvToolTip.innerHTML = html;
  document.all.dvToolTip.style.width= 150;
  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "250"; }
  else { document.all.dvItem.style.width = "auto"; }
  document.all.dvItem.style.left=getLeftScreenPos() + 400;
  document.all.dvItem.style.top=getTopScreenPos() + 100;
  document.all.dvToolTip.style.visibility = "visible";
}

$(document).unbind('keydown').bind('keydown', function (event) {
    var doPrevent = false;
    if (event.keyCode === 8) {
        var d = event.srcElement || event.target;
        if ((d.tagName.toUpperCase() === 'INPUT' && 
             (
                 d.type.toUpperCase() === 'TEXT' ||
                 d.type.toUpperCase() === 'PASSWORD' || 
                 d.type.toUpperCase() === 'FILE' || 
                 d.type.toUpperCase() === 'SEARCH' || 
                 d.type.toUpperCase() === 'EMAIL' || 
                 d.type.toUpperCase() === 'NUMBER' || 
                 d.type.toUpperCase() === 'DATE' )
             ) || 
             d.tagName.toUpperCase() === 'TEXTAREA') {
            doPrevent = d.readOnly || d.disabled;
        }
        else {
            doPrevent = true;
        }
    }

    if (doPrevent) {
        event.preventDefault();
    }
});
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<BODY onload="bodyLoad();">
<!--------------------------------------------------------------------> 
<iframe  id="frame1" src=""  height="0" width="0"></iframe>
<iframe  id="frame2" src=""  height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="draggable"></div>
<div id="dvToolTip" class="dvItem"></div>
<div id="dvSelect" class="dvSelect"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor="moccasin">
    <TD vAlign=top align=left><B>Retail Concepts Inc.
        <BR>E-Commerce Store Fulfillments
        <br>Store: <%String sComa="";
        for(int i=0; i < sSelStr.length; i++){%>
          <%=sComa%><%=sSelStr[i]%><%sComa=", ";%>
        <%}%>
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="MozuSrlAsgMltSel.jsp" class="small"><font color="red">Select</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;
        &nbsp;&nbsp;
        <a href="javascript: foldColmn('cellFold1')">fold/unfold order info</a>
        &nbsp; &nbsp; &nbsp; &nbsp;
        <a href="javascript: foldColmn('cellFold2')">fold/unfold item info</a>
        &nbsp; &nbsp; &nbsp; &nbsp;
        <%if(bSend 
        		&& (sAuthStr.trim().equals(sSelStr[0].trim()) 
        				|| sAuthStr.trim().equals("70") && sSelStr[0].trim().equals("1")
        		    )
        	){%>
            <a href="javascript: setStrSts('ALL' , 'ALL', 'ALL', '<%=sSelStr[0]%>', 'Printed', document.all.spnPrtAll);"><span id="spnPrtAll">Print All</span></a>
            &nbsp; &nbsp; &nbsp; &nbsp;
            <a href="javascript: setStrSts('ALL' , 'MARKED', 'ALL', '<%=sSelStr[0]%>', 'Printed', document.all.spnPrtAll)">Print Marked</a>
            &nbsp; &nbsp; &nbsp; &nbsp;
            <a href="MozuSrlAsgUnPick.jsp?Str=<%=sSelStr[0]%>&Sort=Div">Print Non-Picked</a>
            &nbsp; &nbsp; &nbsp; &nbsp;
            <a href="javascript: rtvFedExTrack('<%=sSelStr[0]%>')">Get FedEx Tracking</a>
        <%}%>

    </td>
    </tr>
    <TR bgColor=moccasin>
    <TD vAlign=top align=middle colspan=2>
<!-- ======================================================================= -->
       <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr class="DataTable">
             <th class="DataTable"><a href="javascript: resort('STR')">Str</a></th>
             <th class="DataTable"><a href="javascript: resort('ORD')">Order #</a>
                <br>Scan:<br><input name="ScanOrd" onkeypress="if (window.event.keyCode == 13) { searchOrder(this); }" maxlength=10 size=10>
             </th>
             <th class="DataTable" id="cellFold1">Order<br>Date</th>
             <th class="DataTable" id="cellFold1">Customer<br>Name</th>
             <th class="DataTable" id="cellFold1">Ship To<br>City/State</th>
             <th class="DataTable"><a href="javascript: resort('SHIP')">Ship Method</a></th>
             <th class="DataTable" id="cellFold1">Order<br>Status</th>

             <th class="DataTable" id="cellFold2">Div<br>#</th>
             <th class="DataTable" id="cellFold2">Long Item Number</th>
             <th class="DataTable" id="cellFold2">Item<br>Description</th>
             <th class="DataTable" id="cellFold2">Vendor Name</th>
             <th class="DataTable" >SKU</th>
             <th class="DataTable" >UPC</th>
             <th class="DataTable" >Ret</th>

             <th class="DataTable">L<br>o<br>g</th>
             <!--th class="DataTable">E<br>M<br>a<br>i<br>l</th-->
             <th class="DataTable">Ord<br>Qty</th>
             <th class="DataTable">Avl<br>Qty</th>
             <th class="DataTable">Asg<br>Qty</th>
             <th class="DataTable">Assign<br>Date</th>
             <th class="DataTable">Sku<br>Sts</th>
             <th class="DataTable">Mark<br>to<br>Prt<br><a href="javascript:resetPrtMrk()" style="font-size:8px">Reset</a></th>
             <th class="DataTable">P<br>r<br>i<br>n<br>t</th>
             <th class="DataTable">Printed<br>Date/Time</th>
             <th class="DataTable">Printed by</th>
             <th class="DataTable">CNL1</th>
             <th class="DataTable">CNL2</th>
             <th class="DataTable">Pick<br>Qty</th>
             <th class="DataTable">Picked &<br>Inspected<br>Date/Time</th>
             <th class="DataTable">Picked &<br>Inspected<br>by</th>
             
             <th class="DataTable">Packing<br>Packed ID</th>

             <th class="DataTable">Problems</th>
             <th class="DataTable">Resolution</th>
             
             <th class="DataTable">Shipped<br>/Packed<br>Qty</th>
             <th class="DataTable">Shipped<br>/Packed<br>Date/Time</th>
             <th class="DataTable">Shipped<br>/Packed<br>by</th>

             <th class="DataTable">FedEx<br>Tracking</th>
             <th class="DataTable">Shipping Completed<br>All Items<br>As Requested</th>
             <th class="DataTable">Reason Not<br>Shipped Complete</th>
          </tr>
       <!-- ============================ Details =========================== -->
       <%String SvOrd = null;%>
       <%boolean bOrdClr = false;%>
       <%for(int i=0, iHdg=0; i < iNumOfItm; i++, iHdg++ )
         {
            itmasgn.setItmList();
            String sSite = itmasgn.getSite();
            String sOrd = itmasgn.getOrd();
            String sOrdSts = itmasgn.getOrdSts();
            String sSku = itmasgn.getSku();
            String sQty = itmasgn.getQty();
            String sPickSts = itmasgn.getPickSts();
            String sPStsDate = itmasgn.getPStsDate();
            String sPStsUser = itmasgn.getPStsUser();
            String sAvlQty = itmasgn.getAvlQty();
            String sMail = itmasgn.getMail();
            String sUpc = itmasgn.getUpc();
            String sDiv = itmasgn.getDiv();
            String sCls = itmasgn.getCls();
            String sVen = itmasgn.getVen();
            String sSty = itmasgn.getSty();
            String sClr = itmasgn.getClr();
            String sSiz = itmasgn.getSiz();
            String sDesc = itmasgn.getDesc();
            String sVenNm = itmasgn.getVenNm();
            String sCompl = itmasgn.getCompl();
            String sRet = itmasgn.getRet();

            String sShipNm = itmasgn.getShipNm();
            String sShipCity = itmasgn.getShipCity();
            String sShipState = itmasgn.getShipState();
            String sShipMeth = itmasgn.getShipMeth();
            String sShipMethNm = itmasgn.getShipMethNm();
            String sOrdDate = itmasgn.getOrdDate();
            String sOpId = itmasgn.getOpId();            
            String sStr = itmasgn.getStr();
            String sCommt = itmasgn.getCommt();


            itmasgn.setSrnList(sStr, sOpId, sUser);
            int iNumOfSrn = itmasgn.getNumOfSrn();

            sComa = "";

            String sOrdClr = "";
            if (i==0) { SvOrd = sOrd; }
            if(!SvOrd.equals(sOrd)){ bOrdClr = !bOrdClr;}
            
            if(bOrdClr)
            { 
               sOrdClr = "1";
               if(sShipMeth.equals("905")){sOrdClr = "11";}
            }
            else 
            { 
            	sOrdClr = "2";
            	if(sShipMeth.equals("905")){sOrdClr = "21";}
            }
            

            String sClrSts = "";
            if ( sShipMeth.equals("fedex_FEDEX_2_DAY") 
            	|| sShipMeth.equals("fedex_FEDEX_EXPRESS_SAVER")                 
                || sShipMeth.equals("fedex_FEDEX_PRTY_OVERNIGHT")
                || sShipMeth.equals("fedex_PRIORITY_OVERNIGHT")
                || sShipMeth.equals("fedex_STANDARD_OVERNIGHT"))
            {
            	sClrSts = "1";
            }
            else if(sShipMeth.equals("ship-to-store"))
            {
            	sClrSts = "2";
            }
       %>
         <script language="javascript">
           aSite[<%=i%>] = "<%=sSite%>"; aOrd[<%=i%>] = "<%=sOrd%>"; aSku[<%=i%>] = "<%=sSku%>" * 1;
           aShipMeth[<%=i%>] = "<%=sShipMeth%>";
           aUpc[<%=i%>] = "<%=sUpc%>"; aStr[<%=i%>] = "<%=sStr%>";
           aOrdQty[<%=i%>] = "<%=sQty%>";  aAvlQty[<%=i%>] = "<%=sAvlQty%>";
           aDesc[<%=i%>] = "<%=sDesc%>"; aVenNm[<%=i%>] = "<%=sVenNm%>";
           aSrln[<%=i%>] = new Array(<%=iNumOfSrn%>);  
           aSts[<%=i%>] = new Array(<%=iNumOfSrn%>); aAsgQty[<%=i%>] = new Array(<%=iNumOfSrn%>);
           aPckQty[<%=i%>] = new Array(); aShpQty[<%=i%>] = new Array();
           aCnl1User[<%=i%>] = new Array(); aCnl2User[<%=i%>] = new Array();
         </script>
         <%if(iHdg > 15 && !SvOrd.equals(sOrd) ){
              iHdg = 0;
         %>
         <tr class="DataTable">
             <th class="DataTable">Str</th>
             <th class="DataTable">Order #
                 <br>Scan:<br><input name="ScanOrd" onkeypress="if (window.event.keyCode == 13) { searchOrder(this); }" maxlength=10 size=10>
             </th>
             <th class="DataTable" id="cellFold1">Order<br>Date</th>
             <th class="DataTable" id="cellFold1">Customer<br>Name</th>
             <th class="DataTable" id="cellFold1">Ship To<br>City/State</th>
             <th class="DataTable">Ship Method</th>
             <th class="DataTable" id="cellFold1">Order<br>Status</th>


             <th class="DataTable" id="cellFold2">Div<br>#</th>
             <th class="DataTable" id="cellFold2">Long Item Number</th>
             <th class="DataTable" id="cellFold2">Item<br>Description</th>
             <th class="DataTable" id="cellFold2">Vendor Name</th>
             <th class="DataTable" >SKU</th>
             <th class="DataTable" >UPC</th>
             <th class="DataTable" >Ret</th>

             <th class="DataTable">L</th>
             <!--th class="DataTable">E</th-->
             <th class="DataTable">Ord<br>Qty</th>
             <th class="DataTable">Avl<br>Qty</th>
             <th class="DataTable">Asg<br>Qty</th>
             <th class="DataTable">Assign<br>Date</th>
             <th class="DataTable">Sku<br>Sts</th>
             <th class="DataTable">M</th>
             <th class="DataTable">P</th>
             <th class="DataTable">Printed<br>Date/Time</th>
             <th class="DataTable">Printed by</th>
             <th class="DataTable">CNL1</th>
             <th class="DataTable">CNL2</th>
             <th class="DataTable">Pick<br>Qty</th>
             <th class="DataTable">Picked &<br>Inspected<br>Date/Time</th>
             <th class="DataTable">Picked &<br>Inspected<br>by</th>

             <th class="DataTable">Packing</th>
             
             <th class="DataTable">Problems</th>
             <th class="DataTable">Resolution</th>
             
             <th class="DataTable">Shipped<br>/Packed<br>Qty</th>
             <th class="DataTable">Shipped<br>/Packed<br>Date/Time</th>
             <th class="DataTable">Shipped<br>/Packed<br>by</th>
             <th class="DataTable">FedEx<br>Tracking</th>
             <th class="DataTable">Shipping Completed<br>All Items<br>As Requested</th>
             <th class="DataTable">Reason Not<br>Shipped Complete</th>
          </tr>
         <%}%>

         <tr class="DataTable0<%=sOrdClr%>">
            <td class="DataTable" id="tdStr<%=i%>" nowrap rowspan=<%=iNumOfSrn%>><%=sStr%></td>
            <td class="DataTable" id="tdOrd<%=i%>" nowrap rowspan=<%=iNumOfSrn%>><%=sOrd%></td>
            <td class="DataTable1" id="cellFold1" nowrap rowspan=<%=iNumOfSrn%>><%=sOrdDate%></td>
            <td class="DataTable1" id="cellFold1" nowrap rowspan=<%=iNumOfSrn%>><%=sShipNm%></td>
            <td class="DataTable1" id="cellFold1" nowrap rowspan=<%=iNumOfSrn%>><%=sShipCity%>, <%=sShipState%></td>
            <td class="DataTable1<%=sClrSts%>"  nowrap rowspan=<%=iNumOfSrn%>><b><%=sShipMethNm%></b></td>
            <td class="DataTable1" id="cellFold1" nowrap rowspan=<%=iNumOfSrn%>><%=sOrdSts%></td>


            <td class="DataTable" id="cellFold2" nowrap rowspan=<%=iNumOfSrn%>><%=sDiv%></td>
            <td class="DataTable" id="cellFold2" nowrap rowspan=<%=iNumOfSrn%>><%=sCls%>-<%=sVen%>-<%=sSty%>-<%=sClr%>-<%=sSiz%></td>
            <td class="DataTable1" id="cellFold2" nowrap rowspan=<%=iNumOfSrn%>><%=sDesc%></td>
            <td class="DataTable1" id="cellFold2" nowrap rowspan=<%=iNumOfSrn%>><%=sVenNm%></td>
            <td class="DataTable2" nowrap rowspan=<%=iNumOfSrn%>><a href="javascript: getSlsBySku('<%=sSku%>', '<%=sStr%>')"><%=sSku%></a></td>
            <td class="DataTable2" nowrap rowspan=<%=iNumOfSrn%>><%=sUpc%></td>
            <td class="DataTable2" nowrap rowspan=<%=iNumOfSrn%>>$<%=sRet%></td>

            <th class="DataTable" style="vertical-align:middle;" id="thLog<%=i%>" rowspan=<%=iNumOfSrn%>>
                <a href="javascript: getStrCommt('<%=i%>');">&nbsp;L&nbsp;<%=sCommt%></a>
            </th>

            <td class="DataTable2" nowrap rowspan=<%=iNumOfSrn%>><%=sQty%></td>
            <td class="DataTable2" nowrap rowspan=<%=iNumOfSrn%>><%=sAvlQty%></td>

        <!-- ===== Serial Number lines ======== -->
        <%for(int j=0; j < iNumOfSrn; j++)
        {
           itmasgn.getSrnList();
           String sSrln = itmasgn.getSrln();
           //System.out.println("srln=" + sSrln);
           String sSnSts = itmasgn.getSnSts();
           String sAsgDt = itmasgn.getAsgDt();
           String sAsgEmp = itmasgn.getAsgEmp();
           String sPrtDt = itmasgn.getPrtDt();
           String sPrtEmp = itmasgn.getPrtEmp();
           String sPickDt = itmasgn.getPickDt();
           String sPickEmp = itmasgn.getPickEmp();
           String sShipDt = itmasgn.getShipDt();
           String sShipEmp = itmasgn.getShipEmp();
           String sCnfDt = itmasgn.getCnfDt();
           String sCnfEmp = itmasgn.getCnfEmp();
           String sCnf1Dt = itmasgn.getCn1Dt();
           String sCnf1Emp = itmasgn.getCn1Emp();
           String sCnf2Dt = itmasgn.getCn2Dt();
           String sCnf2Emp = itmasgn.getCn2Emp();
           String sReas = itmasgn.getReas();
           String sPickQty = itmasgn.getPickQty();
           String sWarn = itmasgn.getWarn();
           String sPblDt = itmasgn.getPblDt();
           String sPblEmp = itmasgn.getPblEmp();
           String sRslDt = itmasgn.getRslDt();
           String sRslEmp = itmasgn.getRslEmp();

           String sAsgTm = itmasgn.getAsgTm();
           String sPrtTm = itmasgn.getPrtTm();
           String sPickTm = itmasgn.getPickTm();
           String sShipTm = itmasgn.getShipTm();
           String sCnfTm = itmasgn.getCnfTm();
           String sCnf1Tm = itmasgn.getCn1Tm();
           String sCnf2Tm = itmasgn.getCn2Tm();
           String sPblTm = itmasgn.getPblTm();
           String sRslTm = itmasgn.getRslTm();
           String sPackId = itmasgn.getPackId();
           String sFedExTrId = itmasgn.getFedExTrId();
           
           boolean bSngStr = sStrAllowed != null && !sStrAllowed.startsWith("ALL");

           boolean bPrt = bSngStr && !sAsgDt.equals("") && sPrtDt.equals("01/01/0001") && sPickDt.equals("01/01/0001")
             && sShipDt.equals("01/01/0001") && sCnfDt.equals("01/01/0001");

           // allow CNL1,2 for store, skip it for warehouse 
           boolean bCnl1 = bSngStr && !sStr.equals("1") && !sStr.equals("70") && !sAsgDt.equals("") && !sPrtDt.equals("01/01/0001") && sPickDt.equals("01/01/0001")
             && sShipDt.equals("01/01/0001") && sCnf1Dt.equals("01/01/0001");
           boolean bCnl2 = bSngStr && !sStr.equals("1") && !sStr.equals("70") && !sAsgDt.equals("") && !sPrtDt.equals("01/01/0001") && sPickDt.equals("01/01/0001")
             && sShipDt.equals("01/01/0001") && !sCnf1Dt.equals("01/01/0001") && sCnf2Dt.equals("01/01/0001");
           
           boolean bPick = bSngStr && !sAsgDt.equals("") && !sPrtDt.equals("01/01/0001") && sPickDt.equals("01/01/0001")
             && sShipDt.equals("01/01/0001");

           boolean bProblem = bSngStr && !sStr.equals("1") && !sStr.equals("70") && !sAsgDt.equals("") && !sPrtDt.equals("01/01/0001") && !sPickDt.equals("01/01/0001")
             && sPblDt.equals("01/01/0001") && sShipDt.equals("01/01/0001") && sCnfDt.equals("01/01/0001");

           boolean bPack = bSngStr && !sAsgDt.equals("") && !sPrtDt.equals("01/01/0001") && !sPickDt.equals("01/01/0001")
                   && sShipDt.equals("01/01/0001") && sCnfDt.equals("01/01/0001");
           
           if(sPackId.equals("0"))
           { 
        	   if(bPack){ sPackId = "Packing" ; }
        	   else { sPackId = "&nbsp;"; }
           }
           
                   
        %>
           <script language="javascript">
              aSrln[<%=i%>][<%=j%>] = "<%=sSrln%>";              
              aSts[<%=i%>][<%=j%>] = "<%=sSnSts%>";
              aAsgQty[<%=i%>][<%=j%>] = "1";
              aCnl1User[<%=i%>][<%=j%>] = "";
              <%if(!sCnf1Emp.equals("")){%>
                  aCnl1User[<%=i%>][<%=j%>] = <%=sCnf1Emp.substring(0,4)%>;
              <%}%>
              aPckQty[<%=i%>][<%=j%>] = "<%=sPickQty%>";
           </script>

           <%if(j > 0){%>
            <tr class="DataTable0<%=sOrdClr%>">
           <%}%>
            <td class="DataTable2C" id="tdAsg" nowrap>1</td>
            <td class="DataTable2C" id="tdAsgDt" nowrap><%=sAsgDt%> <%=sAsgTm%></td>
            <td class="DataTable1<%=sWarn%>" nowrap id="tdStrSts<%=i%>"><%=sSnSts%>&nbsp;</td>

            <!--===== Print === -->
            <td class="DataTable" nowrap id="tdPrtGrp<%=i%>">
                <%if(bSend && ((i==0 || !SvOrd.equals(sOrd))) && j==0){%>
                <input name="PrtGrp<%=i%>" type="checkbox" value="<%=sOrd%>">
                <input name="PrtSite<%=i%>" type="hidden" value="<%=sSite%>">
                <%} else {%>&nbsp;<%}%>
                &nbsp;
            </td>
            <td class="DataTable" nowrap id="tdPrint<%=i%>">
              <%if(bSend && bPrt){%><a href="javascript: setStrSts('<%=sSite%>', '<%=sOrd%>', '<%=sSku%>', '<%=sStr%>', 'Printed', document.all.tdStrSts<%=i%>);">P</a><%}%>&nbsp;
            </td>
            <td class="DataTable" nowrap><%if(!sPrtDt.equals("01/01/0001")){%><%=sPrtDt%> <%=sPrtTm%><%}%></td>
            <td class="DataTable" nowrap><%=sPrtEmp%></td>

           <!--===== CNL 1 === -->
           <td class="DataTable2" id="tdCnl1<%=i%>" nowrap>              
              <%if(!sCnf1Dt.equals("01/01/0001")){%><%if(!sCnf1Emp.equals("")){%><%=sCnf1Emp.substring(0, 4)%><%}%><%}
              else if(bCnl1){%><a href="javascript: setCnlNote('<%=i%>', '<%=sSrln%>', 'CNL1', '<%=sStr%>');">CNL1</a><%}%>
              &nbsp;
           </td>

           <!--===== CNL 2 === -->
           <td class="DataTable2C" id="tdCnl2<%=i%>" nowrap>
              <%if(!sCnf2Dt.equals("01/01/0001")){%><%if(!sCnf2Emp.equals("")){%><%=sCnf2Emp.substring(0, 4)%><%}%><%}
              else if(bCnl2){%><a href="javascript: setCnlNote('<%=i%>', '<%=sSrln%>', 'CNL2', '<%=sStr%>');">CNL2</a><%}%>
              &nbsp;
           </td>

           <!--===== Pick === -->
           <td class="DataTable2C" id="tdPck<%=i%>">
              <%if(bPick){%><a href="javascript: setQtySel('<%=i%>', 'Picked');">Pick</a><%}
              else if(!sPickDt.equals("01/01/0001")){%><%=sPickQty%><%}%>
           </td>
           <td class="DataTable" nowrap><%if(!sPickDt.equals("01/01/0001")){%><%=sPickDt%> <%=sPickTm%><%}%>&nbsp;</td>
           <td class="DataTable" nowrap><%=sPickEmp%></td>
           
           <!--===== Packing === -->
           <td class="DataTable" nowrap>              
             <%if(bPack && !sPickQty.equals("") && !sPickQty.equals("0") && !sSnSts.equals("Problem")){%><a href="javascript: rtvPickedItem('<%=i%>');"><%=sPackId%></a><%}
             else{%><%=sPackId%><%}%>
             <%if(!sPackId.equals("&nbsp;") && !sPackId.equals("Packing")) {%> (<a href="javascript: rePrintByPackId('<%=sPackId%>')">P</a>)<%}%>
             <%if(!sPackId.equals("&nbsp;") && !sPackId.equals("Packing") && bAssign) {%> (<a href="javascript: reSendToFx('<%=sStr%>','<%=sOrd%>', '<%=sPackId%>')">FX</a>)<%}%>             
           </td>

           <!-- ========= Problem ========== -->
           <td class="DataTable" nowrap>
              <%if(bProblem){%>
                 <a href="javascript: setQtySel('<%=i%>', 'Problem');">Problem</a>
              <%} else if(!sPblDt.equals("01/01/0001")){%><%=sPblDt%><%=sPblEmp%><br><%=sPblDt%> <%=sPblTm%><%
                } else {%>&nbsp;<%}%>
           </td>
           <!-- ========= Resolution ========== -->
           <td class="DataTable" nowrap>
            <%if(!sRslDt.trim().equals("01/01/0001")){%>Resolved  - See log for details<%}%>&nbsp;
           </td>
           

           <!--===== Ship === -->
           <td class="DataTable2C" id="tdSnd<%=i%>">
              <%if(!sShipDt.equals("01/01/0001")){%>1<%}
              else if(!sCnfDt.equals("01/01/0001")){%>0<%}%>
           </td>
           <td class="DataTable" nowrap>
              <%if(!sShipDt.equals("01/01/0001")){%><%=sShipDt%> <%=sShipTm%><%}
              else if(!sCnfDt.equals("01/01/0001")){%><%=sCnfDt%> <%=sCnfTm%><%}%>
              &nbsp;
           </td>           
           <td class="DataTable" nowrap>
           <%=sShipEmp%><%=sCnfEmp%>
           </td>
           
           <!--===== Federal express === -->
           <td class="DataTable2C" id="tdSnd<%=i%>">
               <a href="http://fedex.com/Tracking?action=track&language=english&cntry_code=us&tracknumbers=<%=sFedExTrId%>" target="_blank">
                  <%=sFedExTrId%>
               </a>
           </td>
           

           <td class="DataTable" nowrap>
                 <%if(!sShipDt.equals("01/01/0001")){%>Y<%}
                  else if(!sCnfDt.equals("01/01/0001")){%>N<%}
                  else{%>&nbsp;<%}%>
              </td>
              <td class="DataTable" nowrap><%=sReas%>&nbsp;</td>
          <%}%>
          </tr>
          <%SvOrd = sOrd; %>
       <%}%>
     </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
   <%for(int i=0; i < 50; i++){%><br><%}%>
</BODY></HTML>
<span style="font-size:10px" id="spnTime"></span>
<script language="javascript">
EndTime = new Date();
var diff = (EndTime.getTime() - StrTime.getTime()) / 1000;
document.all.spnTime.innerHTML = diff;
</script>
<%
   itmasgn.disconnect();
   itmasgn = null;
   }
%>