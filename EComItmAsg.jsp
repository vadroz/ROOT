<%@ page import="rciutility.StoreSelect, ecommerce.EComItmAsg, inventoryreports.PiCalendar, java.util.*"%>
<%
    String [] sSelStr = request.getParameterValues("Str");
    String [] sStatus = request.getParameterValues("Sts");
    String sStsFrDate = request.getParameter("StsFrDate");
    String sStsToDate = request.getParameter("StsToDate");
    String sSelSku = request.getParameter("Sku");
    String sSelOrd = request.getParameter("Ord");
    String sSort = request.getParameter("Sort");  
    String sTop = request.getParameter("Top");

    if(sSort==null && sSelStr.length == 1 ) { sSort = "ORD"; }
    if(sSort==null && sSelStr.length > 1 ) { sSort = "STR"; }
    if(sTop==null) { sTop = "0"; }
    if(sSelSku==null){sSelSku=" ";}
    if(sSelOrd==null){sSelOrd=" ";}

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null && session.getAttribute("ECOMSECURE")!=null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComItmAsg.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    String sAuthStr = session.getAttribute("STORE").toString().trim();
    String sUser = session.getAttribute("USER").toString();

    EComItmAsg itmasgn = new EComItmAsg(sSelStr, sStatus, sStsFrDate, sStsToDate
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

    String sStrJsa = strlst.getStrNum();
    String sStrNameJsa = strlst.getStrName();


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

        table.DataTable { font-size:10px }

        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px;
                       padding-bottom:3px; text-align:center; font-size:11px; text-decoration: underline;}

        tr.DataTable0 { background: #E7E7E7; font-size:10px }
        tr.DataTable1 { background: yellow; font-size:10px }
        tr.DataTable2 { background: darkred; font-size:1px}
        tr.DataTable3 { background: LemonChiffon; font-size:10px}

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTableR { background: red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTableY { background: yellow; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTableC { cursor:hand; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable1C { cursor:hand; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable2C { cursor:hand; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}

        .Small {font-size:10px }
        .Medium {font-size:11px }
        .btnSmall {font-size:8px; display:none;}
        .Warning {font-size:12px; font-weight:bold; color:red; }

        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:50; background-color:LemonChiffon; z-index:10;
              text-align:center; vertical-align:top; font-size:10px}

        div.dvSelect { position:absolute; background-attachment: scroll;
              border: black solid 2px; width:250px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Cell {font-size:12px; text-align:right; vertical-align:top}
        td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
        td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}
</style>


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
var aSite = new Array();
var aOrd = new Array();
var aSku = new Array();
var aUpc = new Array();
var aStr = new Array();
var aSts = new Array();
var aOrdQty = new Array();
var aAsgQty = new Array();
var aAvlQty = new Array();
var aPckQty = new Array();
var aShpQty = new Array();
var aAsgDate = new Array();
var aPrtDate = new Array();
var aPackDate = new Array();
var aShipDate = new Array();
var aDesc = new Array();
var aVenNm = new Array();
var aCnl1User = new Array();
var aCnl1Date = new Array();
var aCnl1Time = new Array();
var aCnl2User = new Array();
var aCnl2Date = new Array();
var aCnl2Time = new Array();

var aLine = new Array(); // save all sju for selected orders
var aSelOrd = new Array();

document.onkeyup=catchEscape

var StrTime = new Date();
var EndTime = null;

var aSelStr = [<%=sSelStrJsa%>];

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   setSelectPanelShort();
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
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
              + "<input class='Small' name='Sts' type='checkbox' value='Shipped'>Shipped &nbsp;"
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
      df.Store.options[i] = new Option(ArrStr[j] + " - " + ArrStrNm[j],ArrStr[j]);
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
       for(var j=0; j < aSelStr.length; j++)
       {
          if(str[i].value == aSelStr[j]){ str[i].checked=true; }
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
  var selstr = new Array();
  if (ArrStr.length < 3){ selstr[0] = document.all.Store.value; }
  else
  {
     var str = document.all.Str;
     selstr = new Array();
     var numstr = 0
     for(var i=0; i < str.length; i++)
     {
       if(str[i].checked){ selstr[numstr] = str[i].value; numstr++; }
     }
     if (numstr == 0){ error=true; msg+="At least 1 store must be selected.";}
  }

  // order date
  var stsfrdate = document.all.StsFrDate.value;
  var ststodate = document.all.StsToDate.value;

  var sku = document.all.Sku.value.trim();
  var ord = document.all.Order.value.trim();

  if (error) alert(msg);
  else{ sbmPlan(sts, stsfrdate, ststodate, selstr, sku, ord) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(sts, stsfrdate, ststodate, selstr, sku, ord)
{
  var url = null;
  url = "EComItmAsg.jsp?"
      + "StsFrDate=" + stsfrdate
      + "&StsToDate=" + ststodate
      + "&Sku=" + sku
      + "&Ord=" + ord

  for(var i=0; i < sts.length; i++) { url += "&Sts=" + sts[i] }
  for(var i=0; i < selstr.length; i++){ url += "&Str=" + selstr[i]; }

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
// set selected Quantity
//==============================================================================
function setQtySel(line, newSts)
{
   var error = false;
   var msg = "";

   if(aSts[line] == "Assigned"){ error = true; msg = "You must print this order/sku."; }
   else if(aSts[line] == "Printed" && newSts != "Picked" && newSts != "CNL1" && newSts != "CNL2") { error = true; msg = "The next status must be 'Picked' or 'CNL'."; }
   else if(newSts == "Problem" && aSts[line] != "Picked") { error = true; msg = "The 'Problem' status is not allowed."; }

   if(!error) {setStsQtySel(line, newSts);}
   else { alert(msg); }
}
//==============================================================================
// set selected Quantity
//==============================================================================
function setStsQtySel(line, newSts)
{
  objnm = "tdStrSts" + line
  SelObj = document.all[objnm];

  var qsnm = "Assign Qty & Status &nbsp; ";
  if(newSts == "Picked"){ qsnm = "Picked Qty & Status &nbsp; ";}
  else if(newSts == "Shipped"){ qsnm = "Shipped/Packed/Final &nbsp; ";}
  else if(newSts == "Problem"){ qsnm = "Problem on Order &nbsp; ";}

  var hdr = qsnm + "Order: " + aOrd[line];
  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popStsQtyPanel(line, newSts)
     + "</td></tr>"
   + "</table>"

  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 400;
  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
  document.all.dvItem.style.visibility = "visible";

  //populate quantity
  popQtyFld(newSts);

  document.all.ScanSku.focus();
  chkSkuSts(line, newSts);
}
//==============================================================================
// check sku status
//==============================================================================
function chkSkuSts(line, newSts)
{
   for(var i=0; i < aLine.length; i++)
   {
      if(newSts == "Picked" && aSts[aLine[i]] != "Printed"
         || newSts == "Shipped"
         && (aSts[aLine[i]] != "Picked" && aSts[aLine[i]] != "Problem" && aSts[aLine[i]] != "Resolve"))
      {
        var cellnm = "tdSkuEnt" + i; document.all[cellnm].style.background="grey";
        cellnm = "tdSkuInp" + i; document.all[cellnm].style.background="grey";
        cellnm = "selQty" + i; document.all[cellnm].disabled=true;
        cellnm = "Emp" + i; document.all[cellnm].disabled=true;
        cellnm = "txaNote" + i; document.all[cellnm].disabled=true;

        if (newSts == "Shipped")
        {
           cellnm = "Reason" + i; document.all[cellnm].disabled=true;
           cellnm = "Excl" + i; document.all[cellnm].disabled=true;
        }
      }
   }
}
//==============================================================================
// populate quantity
//==============================================================================
function popStsQtyPanel(line, newSts)
{
  aLine = searchOrd(line, newSts);
  var pos = getPosition(SelObj);
  var qtynm = "Assign Qty: ";
  if(newSts == "Picked"){qtynm = "Picked Qty: ";}
  else if(newSts == "Shipped"){qtynm = "Shipped Qty: ";}
  else if(newSts == "Problem"){qtynm = "Problem Qty: ";}

  var panel = "Scan Item: <input id='ScanSku' onkeypress='if (window.event.keyCode == 13) { searchScan(this.value.trim()); }' class='Small' maxlength=12 size=12>"

  if(newSts == "Problem"){ panel += "&nbsp; &nbsp; <span class='Warning'>Please report a problem here!</span>";}

  panel += "<table cellPadding='0' cellSpacing='0' border=1>"

  for(var i=0; i < aLine.length;i++)
  {
    panel += "<tr>"
      + "<td nowrap class='Medium' id='tdSkuEnt" + i + "'><b>"
        + "SKU: " + aSku[aLine[i]]
        + "<br>UPC: " + aUpc[aLine[i]]
        + "<br>Desc: " + aDesc[aLine[i]]
        + "<br>Vendor: " + aVenNm[aLine[i]]

    panel += "</b></td>"
      + " <td nowrap class='Small' id='tdSkuInp" + i + "'>" + popSngOrd(i, qtynm, newSts) + "</td></tr>"
     + "<tr><td colspan=2 style='font-size:1px; background: darkred'>&nbsp;</td></tr>"
  }

  panel += "<tr>"
       + "<td id='tdErrorAll' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
    + "</tr>"

  panel += "<tr>"
         + "<td nowrap class='Small' colspan=2><button onClick='ValidateStrPickSendQty("
            + "&#34;" + line + "&#34;"
            + ",&#34;" + newSts + "&#34;"
            + ")' class='Small' id='btnSbmStsQty'>Submit</button>"
       + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
    + "</td></tr>"

  panel += "</table>"

  return panel;
}
//==============================================================================
// populate single item for selected order
//==============================================================================
function popSngOrd(i, qtynm, newSts)
{
   var panel = "<table cellPadding='0' cellSpacing='0' border=1>"
     + "<tr>"
       + "<td nowrap class='Small'>" + qtynm + "</td>"
       + "<td nowrap><select class='Small' name='selQty" + i
       + "' onchange='chkExclSku(&#34;" + i + "&#34;,&#34;" + newSts + "&#34;)'></select></td>"
     + "</tr>"

   if(newSts == "Shipped")
   {
     panel += "<tr>"
       + "<td nowrap class='Small' colspan=2>"
         + "<input type='checkbox' name='Excl" + i + "' value='" + i + "' disabled>Add Sku to Exclusion"
         + "<br>Click&nbsp;"
           + "<a href='EComUncondExcl.jsp?Sku=" + aSku[aLine[i]] + "&Str=<%=sSelStr[0]%>' target='_blank'>&nbsp;here</a>"
           + " to see a sku in unconditional page"
       + "</td>"
     + "</tr>"
    }
    panel += "<tr>"
       + "<td nowrap class='Small'>Employee Number: </td>"
       + "<td nowrap class='Small'>"
          + "<input class='Small' name='Emp" + i + "' size=4 maxlength=4>"
       + "</td>"
     + "</tr>"

   if(newSts == "Shipped")
   {
      panel += "<tr>"
           + "<td nowrap class='Small'>Reason: </td>"
           + "<td nowrap class='Small'>"
              + "<select class='Small' name='Reason" + i + "'>"
                 + "<option value='None'>-- select reason --</option>"
                 + "<option value='Fulfilled'>Completed</option>"
                 + "<option value='Cannot Locate'>Cannot Locate</option>"
                 + "<option value='RTV'>RTV</option>"
                 + "<option value='Soiled/Damaged'>Soiled/Damaged</option>"
                 + "<option value='Missing Pieces'>Missing Pieces</option>"
              + "</select>"
           + "</td>"
        + "</tr>"
   }

   panel += "<tr>"
       + "<td nowrap class='Small'>Comment: </td>"
       + "<td nowrap class='Small'><TextArea class='Small' name='txaNote" + i + "' cols=30 rows=3></TextArea></td>"
    + "</tr>"
    + "<tr>"
       + "<td id='tdError" + i + "' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
    + "</tr>"
 + "</table>"

   return panel;
}
//==============================================================================
// check if item must be excluded
//==============================================================================
function chkExclSku(arg, newSts)
{
   var selnm = "selQty" + arg;
   var qty = document.all[selnm].options[document.all[selnm].selectedIndex].value;
   var asgqty = aAsgQty[aLine[arg]];
   if(newSts == "Shipped")
   {
      var exclnm = "Excl" + arg;
      if(eval(qty) > -1 && eval(qty) < eval(asgqty)){ document.all[exclnm].checked = true; document.all[exclnm].disabled = false;}
      else{ document.all[exclnm].checked = false; document.all[exclnm].disabled = true;}
   }
}
//==============================================================================
// search all sku for selected order
//==============================================================================
function searchScan(search)
{
   document.all.tdErrorAll.innerHTML = "";
   var sku = null;
   var upc = null;
   var arg = -1;
   var cellnm;
   for(var i=0; i < aLine.length; i++)
   {
      if(eval(aSku[aLine[i]]) == eval(search)){ sku = aSku[aLine[i]]; arg = i; break; }
      if(aUpc[aLine[i]] == search){ upc = aUpc[aLine[i]];  arg = i; break; }
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
         sku = sresult;
      }
   }
   // scanned item is found
   if(sku || upc)
   {
      // mark found item
      cellnm = "tdSkuEnt" + arg;
      document.all[cellnm].style.background="khaki";

      // increment selected quantity if less than assinged
      cellnm = "selQty" + arg;
      var sel = document.all[cellnm];
      var cur = sel.selectedIndex;
      var max = sel.length;
      if(cur < (max - 1) && !sel.disabled)
      {
         if(cur==0){sel.selectedIndex = 2;}
         else{sel.selectedIndex += 1;}
         document.all.tdErrorAll.innerHTML = " ";
      }
      else if(sel.disabled){ document.all.tdErrorAll.innerHTML = "This item is not in right status."; }
      else{ document.all.tdErrorAll.innerHTML = "The assigned quantity were reached."; }
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
         sku = resp.substring(beg, end);
      }
   }
   xmlhttp.open("GET",url,false); // synchronize with this apps
   xmlhttp.send();

   //alert(sku.trim());
   return sku.trim();
}
//==============================================================================
// search all sku for selected order
//==============================================================================
function searchOrd(line, newSts)
{
   var search = aOrd[line];
   var sel = new Array();
   for(var i=0; i < aOrd.length; i++)
   {
      if(aOrd[i] == search){ sel[sel.length] = i;}
   }
   return sel;
}
//==============================================================================
// populate quantity
//==============================================================================
function popQtyFld(newSts)
{
   for(var i=0; i < aLine.length; i++)
   {
      var ordqty = aOrdQty[aLine[i]];
      var asgqty = aAsgQty[aLine[i]];
      var avlqty = aAvlQty[aLine[i]];
      var pckqty = aPckQty[aLine[i]];
      var shpqty = aShpQty[aLine[i]];
      var max = eval(ordqty);

      var asg = null;

      var selnm = "selQty" + i;
      document.all[selnm].options[0] = new Option("-- not include --", "-1");
      if(newSts == "Problem"){ document.all[selnm].options[1] = new Option(max,max) }
      else
      {
        for(var j=1, k=0; k <= max; j++, k++)
        {
           document.all[selnm].options[j] = new Option(k,k)
           if(newSts == "Picked" && eval(aPckQty[aLine[i]]) > 0 && k == eval(aPckQty[aLine[i]])){document.all[selnm].selectedIndex = j;}
           else if(newSts == "Shipped" && eval(aShpQty[aLine[i]]) > 0 && k == eval(aShpQty[aLine[i]])){document.all[selnm].selectedIndex = j;}
        }
      }
   }
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

    for(var i=0; i < aLine.length; i++)
    {
       var qtynm = "selQty" + i;
       var selqty = document.all[qtynm];
       if(selqty.selectedIndex > 0 && !selqty.disabled)
       {
          numsel++;
          if (vldSngSku(line, i, newSts)){ error = true; }
       }
    }

    if(numsel == 0){ error=true; document.all.tdErrorAll.innerHTML = "Please include at least 1 item in update." }
    else if(!error){ sbmStrPickSendQty(-1); }

    if(error){ document.all.btnSbmStsQty.disabled = false; }
}
//==============================================================================
// validate assigned send  and
//==============================================================================
function vldSngSku(line, i, newSts)
{
    var error = false;
    var msg = "";
    var tderrnm = "tdError" + i;
    document.all[tderrnm].innerHTML="";

    var qtynm = "selQty" + i;
    var qty = document.all[qtynm].options[document.all[qtynm].selectedIndex].value;
    if(qty== -1){ error = true; msg += "<br>Please enter SKU quantity."; }

    var empnm = "Emp" + i;
    var emp = document.all[empnm].value.trim();
    if(emp==""){error = true; msg += "<br>Please enter your employee number"; }
    else if(isNaN(emp)){error = true; msg += "<br>The employee number is not numeric"; }
    else if (!isEmpNumValid(emp)){error = true; msg += "<br>Employee number is invalid."; }

    var reas = " ";
    if(newSts == "Shipped")
    {
       var reasnm = "Reason" + i;
       var reas  = document.all[reasnm].options[document.all[reasnm].selectedIndex].value;
       var reasIdx = document.all[reasnm].selectedIndex;
       if(reasIdx != 1 && qty == aAsgQty[aLine[i]]){error = true; msg += "<br>Please select complete status."; }
       if(reasIdx < 2 && qty < aAsgQty[aLine[i]]){error = true; msg += "<br>Please select incomplete reason."; }

       var exclnm = "Excl" + i;
       var excl = "N";
       if ( document.all[exclnm].checked ){ excl = "Y"; }
    }

    var notenm = "txaNote" + i
    var note = document.all[notenm].value.trim();
    if(newSts == "Problem" && note == ""){error = true; msg += "<br>Please leave a comment."; }

    if(error){ document.all[tderrnm].innerHTML=msg; }
    else
    {
        aSelOrd[aSelOrd.length] = [aSite[aLine[i]],aOrd[aLine[i]],aSku[aLine[i]]
                     ,aStr[aLine[i]], newSts, qty, emp, reas, note, "CHGSTRSTS", excl];

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
    arg++;
    if(arg < aSelOrd.length)
    {
        var sel = aSelOrd[arg];

        var nwelem = window.frame1.document.createElement("div");
        nwelem.id = "dvSbmStrSts"

        var html = "<form name='frmChgStrSts'"
           + " METHOD=Post ACTION='EComItmAsgSave.jsp'>"
           + "<input name='Site'>"
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
         html += "</form>"

      nwelem.innerHTML = html;
      window.frame1.document.appendChild(nwelem);

      window.frame1.document.all.Site.value = sel[0];
      window.frame1.document.all.Order.value = sel[1];
      window.frame1.document.all.Sku.value = sel[2];
      window.frame1.document.all.Str.value = sel[3];
      window.frame1.document.all.Sts.value = sel[4];
      window.frame1.document.all.Qty.value = sel[5];
      window.frame1.document.all.Emp.value = sel[6];

      note = sel[8].replace(/\n\r?/g, '<br />');
      window.frame1.document.all.Note.value = "<REASON>" + sel[7] + "</REASON>" + note;
      window.frame1.document.all.Action.value=sel[9];
      window.frame1.document.all.Arg.value=arg;
      window.frame1.document.all.Excl.value=sel[10];
      window.frame1.document.all.Reas.value=sel[7];

      window.frame1.document.frmChgStrSts.submit();
   }
}
//==============================================================================
// set Cannot locate note
//==============================================================================
function setCnlNote(line, newSts)
{
  objnm = "tdStrSts" + line
  SelObj = document.all[objnm];

  var hdr = "Cannot Locate Note. Order: " + aOrd[line];
  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popCnlNote(line, newSts)
     + "</td></tr>"
   + "</table>"

  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 400;
  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
  document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate quantity
//==============================================================================
function popCnlNote(line, newSts)
{
  var qtynm = "Cannot Locate";
  var panel = "<table cellPadding='0' cellSpacing='0' border=1>"
  panel += "<tr>"
      + "<td nowrap class='Medium' id='tdSkuEnt'><b>"
        + "SKU: " + aSku[line]
        + "<br>UPC: " + aUpc[line]
        + "<br>Desc: " + aDesc[aLine[line]]
        + "<br>Vendor: " + aVenNm[line]
    panel += "</b></td>"
      + " <td nowrap class='Small'>" + popCnlNoteEnt(line, qtynm, newSts) + "</td></tr>"
     + "<tr><td colspan=2 style='font-size:1px; background: darkred'>&nbsp;</td></tr>"

  panel += "<tr>"
         + "<td nowrap class='Small' colspan=2><button onClick='vldCnlNote("
            + "&#34;" + line + "&#34;"
            + ",&#34;" + newSts + "&#34;"
            + ")' class='Small' id='btnSbmStsQty'>Submit</button>"
       + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
    + "</td></tr>"

  panel += "</table>"

  return panel;
}
//==============================================================================
// populate single item for selected order
//==============================================================================
function popCnlNoteEnt(line, qtynm, newSts)
{
   var panel = "<table cellPadding='0' cellSpacing='0' border=1>"
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
function vldCnlNote(line, newSts)
{
    var error = false;
    var msg = "";
    var tderrnm = "tdError0";
    document.all[tderrnm].innerHTML="";

    var empnm = "Emp";
    var emp = document.all[empnm].value.trim();
    if(emp==""){error = true; msg += "<br>Please enter your employee number"; }
    else if(isNaN(emp)){error = true; msg += "<br>The employee number is not numeric"; }
    else if (!isEmpNumValid(emp)){error = true; msg += "<br>Employee number is invalid."; }
    else if (aCnl1User[line].indexOf(emp) == 0){error = true; msg += "<br>Employee number is already used."; }

    var notenm = "txaNote"
    var note = document.all[notenm].value.trim();

    if(error){ document.all[tderrnm].innerHTML=msg; }
    else { sbmCnlNote(line, emp, note) }
}
//==============================================================================
// submit store status changes
//==============================================================================
function sbmCnlNote(line, emp, note)
{
   var nwelem = window.frame1.document.createElement("div");
   nwelem.id = "dvSbmStrSts"
   aSelOrd = new Array();

   var html = "<form name='frmChgStrSts'"
    + " METHOD=Post ACTION='EComItmAsgSave.jsp'>"
    + "<input name='Site'>"
    + "<input name='Order'>"
    + "<input name='Sku'>"
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

  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 400;
  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
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
       + " METHOD=Post ACTION='EComItmAsgSave.jsp'>"
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

  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 400;
  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
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
       + " METHOD=Post ACTION='EComItmAsgSave.jsp'>"
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

  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 400;
  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
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
       + " METHOD=Post ACTION='EComItmAsgSave.jsp'>"
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

   url = "EComItmAsgCommt.jsp?"
      + "Site=" + aSite[line]
      + "&Order=" + aOrd[line]
      + "&Sku=" + aSku[line]
      + "&Str=" + aStr[line]
      + "&Action=GETSTRCMMT"


   window.frame1.location.href = url;
}

//==============================================================================
// display comment for selected store
//==============================================================================
function showComments(site, order, sku, str, type,emp, commt, recusr, recdt, rectm)
{
   var hdr = "Logging Information. Order:" + aOrd[aLine[0]] ;
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popLog(type,emp, commt, recusr, recdt, rectm, str)
     + "</td></tr>"
   + "</table>"

  document.all.dvItem.style.width=600;
  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 300;
  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
  document.all.dvItem.style.visibility = "visible";

}
//==============================================================================
// populate log andcomments panel
//==============================================================================
function popLog(type,emp, commt, recusr, recdt, rectm, str)
{
   var panel = "<table border=1 style='font-size:12px' cellPadding='0' cellSpacing='0' width='100%'>"
    + "<tr style='background:#FFCC99'>"
       + "<th>Type</th>"
       + "<th>Store</th>"
       + "<th nowrap>Emp #</th>"
       + "<th>Comment</th>"
       + "<th>Recorded by</th>"
    + "</tr>"
   for(var i=0; i < commt.length; i++)
   {
      panel += "<tr>"
        + "<td nowrap>" + type[i] + "</td>"
      if(str[i] != "0") { panel += "<td style='text-align:right' nowrap>" + str[i] + "&nbsp;</td>" }
      else{ panel += "<td style='text-align:right' nowrap>H.O.&nbsp;</td>" }

      panel += "<td nowrap>&nbsp;" + emp[i] + "</td>"
        + "<td>" + commt[i] + "</td>"
        + "<td nowrap>" + recusr[i] + " " + recdt[i] + " " + rectm[i] + "</td>"
   }

   panel += "<tr>"
    + "<td nowrap class='Small' style='text-align:center' colspan=5>"
       + "<button onClick='hidePanel();' class='Small'>Close</button>"
    + "</td></tr></table>"

  return panel;
}
//==============================================================================
// display return error from save process
//==============================================================================
function rtnWithError(arg, err)
{
   var errnm = "tdError" + arg
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
  url = "EComItmAsg.jsp?Sort=" + sort

  for(var i=0; i < aSelStr.length;  i++) { url += "&Str=" + aSelStr[i]; }
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
   // do not restart page until item is not added to excluded list
   if(arg < aSelOrd.length - 1)
   {
      sbmStrPickSendQty(arg);
   }
   else
   {
      url = "EComItmAsg.jsp?Sort=<%=sSort%>"
          + "&Str=<%=sSelStr[0]%>"
      for(var i=0; i < Sts.length;  i++)
      {
         url += "&Sts=" + Sts[i];
      }
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
  window.frame1.location.href=url
}
//==============================================================================
// set selected Quantity
//==============================================================================
function setStrSts(site, ord, sku, str, sts, obj)
{
  SelObj = obj;

  var pos = getPosition(obj);

  var hdr = "Print. Order: " + ord;
  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popStrStsPanel(site, ord, sku, str, sts)
     + "</td></tr>"
   + "</table>"

  document.all.dvItem.innerHTML = html;
  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 400;
  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
  document.all.dvItem.style.visibility = "visible";

  // populate quantity
  document.all.selSts.options[0] = new Option(sts, sts);
}
//==============================================================================
// validate store status changes
//==============================================================================
function popStrStsPanel(site, ord, sku, str, sts)
{
   var panel = "<table cellPadding='0' cellSpacing='0'>"
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
    var emp = document.all.Emp.value.trim();
    if(emp==""){error = true; msg += "<br>Please enter your employee number"; }
    else if(isNaN(emp)){error = true; msg += "<br>The employee number is not numeric"; }

    var note = document.all.txaNote.value.trim();

    if(error){ document.all.tdError.innerHTML=msg; }
    else{ sbmStrSts(site,ord,sku,str, sts, emp, note, asite, aord); }
}
//==============================================================================
// submit store status changes
//==============================================================================
function sbmStrSts(site,ord,sku,str, sts, emp, note, asite, aord)
{
    note = note.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmStrSts"

    var html = "<form name='frmChgStrSts'"
       + " METHOD=Post ACTION='EComItmAsgSave.jsp'>"
       + "<input name='Site'>"
       + "<input name='Order'>"
       + "<input name='Sku'>"
       + "<input name='Str'>"
       + "<input name='Sts'>"
       + "<input name='Emp'>"
       + "<input name='Note'>"
       + "<input name='Action'>"

     for(var i=0; i < aord.length ;i++)
     {
        html += "<input name='OrdL'>";
        html += "<input name='SiteL'>";
     }

     html += "</form>"

   nwelem.innerHTML = html;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Site.value = site;
   window.frame1.document.all.Order.value = ord;
   window.frame1.document.all.Sku.value = sku;
   window.frame1.document.all.Str.value = str;
   window.frame1.document.all.Sts.value = sts;
   window.frame1.document.all.Emp.value = emp;
   window.frame1.document.all.Note.value = note;
   window.frame1.document.all.Action.value="CHGSTRSTS";

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
//==============================================================================
// link to Return Validation page
//==============================================================================
function getSlsBySku(sku)
{
   var date = new Date(new Date() - 30 * 86400000);
   var from = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
   date = new Date(new Date() - 86400000);
   var to = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();

   var iEoY = 0;
   for(var i=0; i < PiYear.length; i++)
   {
       if(PiDesc[i].indexOf("End of Year PI") >= 0) { iEoY = i; break; }
   }
   var lastPI = PiYear[iEoY] + PiMonth[iEoY];

   url ="PIItmSlsHst.jsp?Sku=" + sku
       + "&SlsOnTop=1"
       + "&STORE=<%=sSelStr[0]%>"
       + "&FromDate=" + from
       + "&ToDate=" + to
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
   if(col[0].style.display=="none"){ disp = "block"; }
   for(var i=0; i < col.length; i++)
   {
       col[i].style.display = disp;
   }
}
//==============================================================================
// add/chg/delete item entry
//==============================================================================
function chgItem(sku, qty, reason, expdt, emp, action)
{
   var hdr = "";
   hdr = "Add SKU " + sku +  " as Defected Items";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popUncondItem(sku, action)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 140;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 95;
   document.all.dvItem.style.visibility = "visible";
   document.all.dvItem.width = "300";

   document.all.Sku.value = sku;
   var date = new Date(new Date() - -7 * 86400000);
   document.all.ExpDt.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
   document.all.NoExpDt.checked = true;
   setExpDt(document.all.NoExpDt);
   document.all.Qty.value = 1;

   document.all.ReasLst.options[0] = new Option("---- Select Reason ----", 0)
   document.all.ReasLst.options[1] = new Option("RTV","RTV")
   document.all.ReasLst.options[2] = new Option("Damaged / used","Damaged / used")
   document.all.ReasLst.options[3] = new Option("Cannot Locate","Cannot Locate")
   document.all.ReasLst.options[4] = new Option("Intransit","Intransit")
   document.all.ReasLst.options[5] = new Option("Other","Other")
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popUncondItem(sku, action)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable3'>"
           + "<td class='DataTable2' >SKU:</td>"
           + "<td class='DataTable1'><input name='Sku' size=10 maxlength=10></td>"
       + "</tr>"
       + "<tr class='DataTable3'>"
           + "<td class='DataTable2' >Quantity:</td>"
           + "<td class='DataTable1'><input name='Qty' size=3 maxlength=3></td>"
       + "</tr>"
       + "<tr class='DataTable3'>"
           + "<td class='DataTable2' >Reason:</td>"
           + "<td class='DataTable1' nowrap><input name='Reason' size=30 maxlength=30 readonly> &nbsp;  &nbsp;  &nbsp; "
              + "<select class='Small' onchange='setReasStr(this)' name='ReasLst'></select>"
           + "</td>"
       + "</tr>"
       + "<tr class='DataTable3'>"
           + "<td class='DataTable2' >Description:</td>"
           + "<td class='DataTable1'><input name='Desc' size=50 maxlength=50>"
           + "</td>"
       + "</tr>"
       + "<tr class='DataTable3'>"
           + "<td class='DataTable2' nowrap>Expiration Date:</td>"
           + "<td class='DataTable1'>"
              + "<span id='spnExpDt'>"
              + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;ExpDt&#34;)'>&#60;</button>"
              + "<input name='ExpDt' class='Small' size='10' readonly>"
              + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;ExpDt&#34;)'>&#62;</button>"
              + "<a href='javascript:showCalendar(1, null, null, 680, 170, document.all.ExpDt)'>"
              + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a> &nbsp; "
              + "</span>"
              + "<input name='NoExpDt' type='checkbox' value='Y' onclick='setExpDt(this)'>No Expiration Date"
           + "</td>"
       + "<tr class='DataTable3'>"
           + "<td class='DataTable2' nowrap >Employee Number:</td>"
           + "<td class='DataTable1'><input name='Emp'  size=4 maxlength=4 ></td>"
       + "</tr>"
       + "<tr class='DataTable3'>"
           + "<td class='DataTable1' style='color:red; font-weight:bold;' colspan=2 id='tdError'></td>"
       + "</tr>"

       + "<tr class='DataTable3'>"
           + "<td class='DataTable1' colspan=2 id='tdLink'>Click&nbsp;"
           + "<a href='EComUncondExcl.jsp?Sku=" + sku + "&Str=<%=sSelStr[0]%>' target='_blank'>&nbsp;"
           + " to see a sku in unconditional page</td>"
       + "</tr>"

  panel += "<tr class='DataTable3'>";
  panel += "<td class='DataTable' colspan=2><br><br><button onClick='ValidateItm(&#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
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
// validate entries
//==============================================================================
function ValidateItm(action)
{
   var error = false;
   var msg = "";
   document.all.tdError.innerHTML = msg;

   var sku = document.all.Sku.value.trim();
   if(sku == ""){ error=true; msg += "<br>Please enter the SKU number." }
   if(isNaN(sku)){ error=true; msg += "<br>The SKU value is not a numeric." }

   var qty = document.all.Qty.value.trim();
   if(qty == ""){ error=true; msg += "<br>Please enter the Quantity of defected items." }
   if(isNaN(qty)){ error=true; msg += "<br>The Quantity value is not a numeric." }

   var reas = document.all.Reason.value.trim();
   var rdesc = document.all.Desc.value.trim();
   if(reas == ""){ error=true; msg += "<br>Please enter the Reason for defecting items." }
   if(reas == "Other" && rdesc == ""){ error=true; msg += "<br>Please enter the Reason description." }

   var expdt = document.all.ExpDt.value.trim();
   if(document.all.NoExpDt.checked) { expdt = "None"; }

   var emp = document.all.Emp.value.trim();
   if(emp == ""){ error=true; msg += "<br>Please enter the Employee RCI number." }
   if(isNaN(emp)){ error=true; msg += "<br>The Employee value is not a numeric." }

   if (error){ document.all.tdError.innerHTML = msg; }
   else{ sbmUncondSku(sku, qty, reas, rdesc, expdt, emp, action) }
}
//==============================================================================
// save changes
//==============================================================================
function sbmUncondSku(sku, qty, reas, rdesc, expdt, emp, action)
{
    reas = reas.replace(/\n\r?/g, '<br />');
    rdesc = rdesc.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmUncondSku"

    var html = "<form name='frmAddComment'"
       + " METHOD=Post ACTION='EComUncondExclSave.jsp'>"
       + "<input class='Small' name='Str'>"
       + "<input class='Small' name='Sku'>"
       + "<input class='Small' name='Qty'>"
       + "<input class='Small' name='Reason'>"
       + "<input class='Small' name='RDesc'>"
       + "<input class='Small' name='ExpDt'>"
       + "<input class='Small' name='Emp'>"
       + "<input class='Small' name='Action'>"
       + "<input class='Small' name='Restart'>"
     + "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Str.value="<%=sSelStr[0]%>";
   window.frame1.document.all.Sku.value=sku;
   window.frame1.document.all.Qty.value=qty;
   window.frame1.document.all.Reason.value=reas;
   window.frame1.document.all.RDesc.value=rdesc;
   window.frame1.document.all.ExpDt.value=expdt;
   window.frame1.document.all.Emp.value=emp;
   window.frame1.document.all.Action.value=action;
   window.frame1.document.all.Restart.value="Y";

   //alert(html)
   window.frame1.document.frmAddComment.submit();
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
       if(aSts[line] == "Assigned") { setStrSts(aSite[line], aOrd[line], aSku[line], aStr[line], 'Printed', obj); }
       else if(aSts[line] == "Printed") { setQtySel(line, 'Picked'); }
       else if(aSts[line] == "Picked") { setQtySel(line, 'Shipped'); }
    }
    else{ alert("Order is not found on the list"); }

}
//==============================================================================
// retreive Federal Express Tracking number
//==============================================================================
function rtvFedExTrack(str)
{
  var file = str + "-live.csv";
  if(str == "3") {file = "03.csv"; }
  else if( str == "4"){ file = "04-live.csv";}
  else if( str == "29"){ file = "029-live.csv";}
  else if( str == "86"){ file = "086-live.csv";}
  else if( str == "90"){ file = "090-live.csv";}
  file = "&#34;" + file + "&#34;";

  var url = "EComUPS_GetTrack.jsp?"
      + "Str=" + str;

  window.frame2.location.href=url;
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
  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 400;
  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
  document.all.dvToolTip.style.visibility = "visible";
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<iframe  id="frame2"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvToolTip" class="dvItem"></div>
<div id="dvSelect" class="dvSelect"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor="moccasin">
    <TD vAlign=top align=left><B>Retail Concepts Inc.
        <BR>E-Commerce Store Fulfillments
        <br>Store:
        <%String coma="";
          for(int i=0; i < sSelStr.length;i++){%>
           <%=coma%><%=sSelStr[i]%><%coma=", ";%>
        <%}%>
        </B><br>

        <a href="../" class="small"><font color="red">Home</font></a>&#62;
        <a href="EComItmAsgSel.jsp" class="small"><font color="red">Select</font></a>&#62;
        <font size="-1">This Page.</font>&nbsp;&nbsp;
        &nbsp;&nbsp;
        <a href="javascript: foldColmn('cellFold1')">fold/unfold order info</a>
        &nbsp; &nbsp; &nbsp; &nbsp;
        <a href="javascript: foldColmn('cellFold2')">fold/unfold item info</a>
        &nbsp; &nbsp; &nbsp; &nbsp;
        <%if(bSend && sSelStr.length == 1){%>
            <a href="javascript: setStrSts('ALL' , 'ALL', 'ALL', '<%=sSelStr[0]%>', 'Printed', document.all.spnPrtAll);"><span id="spnPrtAll">Print All</span></a>
            &nbsp; &nbsp; &nbsp; &nbsp;
            <a href="javascript: setStrSts('ALL' , 'MARKED', 'ALL', '<%=sSelStr[0]%>', 'Printed', document.all.spnPrtAll)">Print Marked</a>
            &nbsp; &nbsp; &nbsp; &nbsp;

            <a href="EComItmAsgUnPick.jsp?Str=<%=sSelStr[0]%>&Sort=Div">Print Non-Picked</a>
             &nbsp; &nbsp; &nbsp; &nbsp;
            <a href="javascript: rtvFedExTrack('<%=sSelStr[0]%>')">Get FedEx Tracking</a>
        <%}%>
    </td>
    </tr>
    <TR bgColor=moccasin>
    <TD vAlign=top align=middle colspan=2>
<!-- ======================================================================= -->
       <table class="DataTable" cellPadding="0" cellSpacing="0" border=1>
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

             <th class="DataTable">Assign<br>Date</th>
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
             <th class="DataTable">Problems</th>
             <th class="DataTable">Resolution</th>

             <th class="DataTable">FedEx<br>Tracking</th>

             <th class="DataTable">Shipped<br>/Packed<br>Qty</th>
             <th class="DataTable">Shipped<br>/Packed<br>Date/Time</th>
             <th class="DataTable">Shipped<br>/Packed<br>by</th>
             <th class="DataTable">Shipping Completed<br>All Items<br>As Requested</th>
             <th class="DataTable">Reason Not<br>Shipped Complete</th>
          </tr>
       <!-- ============================ Details =========================== -->
       <%String SvOrd = null;%>
       <%boolean bOrdClr = false;%>
       <%for(int i=0, iHdg=0; i < iNumOfItm; i++, iHdg++ )
         {
            itmasgn.setItmList();
            String sOrd = itmasgn.getOrd();
            String sSite = itmasgn.getSite();
            String sOrdSts = itmasgn.getOrdSts();
            String sSku = itmasgn.getSku();
            String sQty = itmasgn.getQty();
            String sPickSts = itmasgn.getPickSts();
            String sPStsDate = itmasgn.getPStsDate();
            String sPStsUser = itmasgn.getPStsUser();
            String sUserName = itmasgn.getUserName();
            String sAsgQty = itmasgn.getAsgQty();
            String sSndQty = itmasgn.getSndQty();
            String sAvlQty = itmasgn.getAvlQty();
            String sPckQty = itmasgn.getPckQty();
            String sMail = itmasgn.getMail();
            String sAsgNote = itmasgn.getAsgNote();
            String sStrNote = itmasgn.getStrNote();
            String sStrSts = itmasgn.getStrSts();
            String sShipNm = itmasgn.getShipNm();
            String sShipCity = itmasgn.getShipCity();
            String sShipState = itmasgn.getShipState();
            String sShipMeth = itmasgn.getShipMeth();
            String sShipMethNm = itmasgn.getShipMethNm();
            String sOrdDate = itmasgn.getOrdDate();
            String sAsgDate = itmasgn.getAsgDate();
            String sPrtUser = itmasgn.getPrtUser();
            String sPrtDate = itmasgn.getPrtDate();
            String sPrtTime = itmasgn.getPrtTime();
            String sPckUser = itmasgn.getPckUser();
            String sPckDate = itmasgn.getPckDate();
            String sPckTime = itmasgn.getPckTime();
            String sSndUser = itmasgn.getSndUser();
            String sSndDate = itmasgn.getSndDate();
            String sSndTime = itmasgn.getSndTime();
            String sPkgUser = itmasgn.getPkgUser();
            String sPkgDate = itmasgn.getPkgDate();
            String sPkgTime = itmasgn.getPkgTime();
            String sAsgTime = itmasgn.getAsgTime();
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
            String sReason = itmasgn.getReason();
            String sRet = itmasgn.getRet();
            String sCnl1User = itmasgn.getCnl1User();
            String sCnl1Date = itmasgn.getCnl1Date();
            String sCnl1Time = itmasgn.getCnl1Time();
            String sCnl2User = itmasgn.getCnl2User();
            String sCnl2Date = itmasgn.getCnl2Date();
            String sCnl2Time = itmasgn.getCnl2Time();
            String sFedExTrId = itmasgn.getFedExTrId();
            String sStr = itmasgn.getStr();
            String sCommt = itmasgn.getCommt();
            String sWarn = itmasgn.getWarn();

            String sPrblUser = itmasgn.getPrblUser();
            String sPrblDate = itmasgn.getPrblDate();
            String sPrblTime = itmasgn.getPrblTime();

            String sRslvUser = itmasgn.getRslvUser();
            String sRslvDate = itmasgn.getRslvDate();
            String sRslvTime = itmasgn.getRslvTime();

            String sComa = "";

            String sOrdClr = "";
            if (i==0) { SvOrd = sOrd; }
            if(!SvOrd.equals(sOrd)){ bOrdClr = !bOrdClr;}
            if(bOrdClr){ sOrdClr = "lightgray"; }
            else { sOrdClr = "Cornsilk"; }

            boolean bExpedited = sShipMeth.equals("151") || sShipMeth.equals("152")
                              || sShipMeth.equals("153") || sShipMeth.equals("154");
       %>
         <script language="javascript">
           aSite[<%=i%>] = "<%=sSite%>"; aOrd[<%=i%>] =  "<%=sOrd%>"; aSku[<%=i%>] = "<%=sSku%>";
           aUpc[<%=i%>] = "<%=sUpc%>"; aStr[<%=i%>] = "<%=sStr%>"; aSts[<%=i%>] = "<%=sStrSts%>";
           aOrdQty[<%=i%>] = "<%=sQty%>"; aAsgQty[<%=i%>] = "<%=sAsgQty%>"; aAvlQty[<%=i%>] = "<%=sAvlQty%>";
           aAsgDate[<%=i%>] = "<%=sAsgDate%>"; aPrtDate[<%=i%>] = "<%=sPrtDate%>"; aPackDate[<%=i%>] = "<%=sPckDate%>";
           aShipDate[<%=i%>] = "<%=sSndDate%>"; aDesc[<%=i%>] = "<%=sDesc%>"; aVenNm[<%=i%>] = "<%=sVenNm%>";
           aPckQty[<%=i%>] = "<%=sPckQty%>"; aShpQty[<%=i%>] = "<%=sSndQty%>";
           aCnl1User[<%=i%>] = "<%=sCnl1User%>"; aCnl1Date[<%=i%>] = "<%=sCnl1Date%>"; aCnl1Time[<%=i%>] = "<%=sCnl1Time%>";
           aCnl2User[<%=i%>] = "<%=sCnl2User%>"; aCnl2Date[<%=i%>] = "<%=sCnl2Date%>"; aCnl2Time[<%=i%>] = "<%=sCnl2Time%>";
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

             <th class="DataTable">Assign<br>Date</th>
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

             <th class="DataTable">Problems</th>
             <th class="DataTable">Resolution</th>

             <th class="DataTable">FedEx<br>Tracking</th>

             <th class="DataTable">Shipped<br>/Packed<br>Qty</th>
             <th class="DataTable">Shipped<br>/Packed<br>Date/Time</th>
             <th class="DataTable">Shipped<br>/Packed<br>by</th>
             <th class="DataTable">Shipping Completed<br>All Items<br>As Requested</th>
             <th class="DataTable">Reason Not<br>Shipped Complete</th>
          </tr>
         <%}%>
         <tr class="DataTable0" <%if(!sOrdClr.equals("")){%>style="background:<%=sOrdClr%>"<%}%>>
            <td class="DataTable1" nowrap><%=sStr%></td>
            <td class="DataTable" id="tdOrd<%=i%>" nowrap><%=sOrd%></td>
            <td class="DataTable1" id="cellFold1" nowrap><%=sOrdDate%></td>
            <td class="DataTable1" id="cellFold1" nowrap><%=sShipNm%></td>
            <td class="DataTable1" id="cellFold1" nowrap><%=sShipCity%>, <%=sShipState%></td>
            <td class="DataTable1" <%if(bExpedited){%>style="font-weight:bold;"<%}%> nowrap><%=sShipMeth%> - <%=sShipMethNm%></td>
            <td class="DataTable1" id="cellFold1" nowrap><%=sOrdSts%></td>
            <td class="DataTable1" nowrap><%=sAsgDate%> <%=sAsgTime%></td>


            <td class="DataTable" id="cellFold2" nowrap><%=sDiv%></td>
            <td class="DataTable" id="cellFold2" nowrap><%=sCls%>-<%=sVen%>-<%=sSty%>-<%=sClr%>-<%=sSiz%></td>
            <td class="DataTable1" id="cellFold2" nowrap><%=sDesc%></td>
            <td class="DataTable1" id="cellFold2" nowrap><%=sVenNm%></td>
            <td class="DataTable2" nowrap><a href="javascript: getSlsBySku('<%=sSku%>')"><%=sSku%></a></td>
            <td class="DataTable2" nowrap><%=sUpc%></td>
            <td class="DataTable2" nowrap>$<%=sRet%></td>

            <th class="DataTable" style="vertical-align:middle;" id="thLog<%=i%>">
                <a href="javascript: getStrCommt('<%=i%>');">&nbsp;L<%=sCommt%>&nbsp;</a>
            </th>
            <!--th class="DataTable" style="vertical-align:middle;" id="thEmail<%=i%>">
                <a href="javascript: sendEmail('<%=i%>');">&nbsp;E&nbsp;</a>
            </th-->

            <td class="DataTable2" nowrap><%=sQty%></td>
            <td class="DataTable2" nowrap><%=sAvlQty%></td>
            <td class="DataTable2C" id="tdAsg" nowrap>
               <%if(bAssign){%><a href="javascript: setQtySel('<%=i%>', 'Assigned');"><%=sAsgQty%></a><%}
               else{%><%=sAsgQty%><%}%>
            </td>
            <td class="DataTable<%=sWarn%>" nowrap id="tdStrSts<%=i%>"><%=sStrSts%></td>

            <!--===== Print === -->
            <td class="DataTable" nowrap id="tdPrtGrp<%=i%>">
               <%if(!sAsgQty.equals("0") && !sAsgQty.equals("")){%>
                    <%if(bSend && (i==0 || !SvOrd.equals(sOrd))){%>
                    <input name="PrtGrp<%=i%>" type="checkbox" value="<%=sOrd%>">
                    <input name="PrtSite<%=i%>" type="hidden" value="<%=sSite%>">
                    <%} else {%>&nbsp;<%}%>
               <%} else{%>&nbsp;<%}%>
           </td>
            <td class="DataTable" nowrap id="tdPrint<%=i%>">
               <%if(!sAsgQty.equals("0") && !sAsgQty.equals("")){%>
                    <%if(bSend && (sStrSts.equals("Assigned"))){%>
                       <a href="javascript: setStrSts('<%=sSite%>' , '<%=sOrd%>', '<%=sSku%>', '<%=sSelStr[0]%>', 'Printed', document.all.tdStrSts<%=i%>);">P</a>
                    <%} else {%>&nbsp;<%}%>
               <%} else{%>&nbsp;<%}%>
           </td>
           <td class="DataTable" nowrap><%=sPrtDate%> <%=sPrtTime%></td>
           <td class="DataTable" nowrap><%=sPrtUser%></td>


           <%if(bSend && sCnl1User.equals("") && !sStrSts.equals("Shipped")){%>
               <td class="DataTable2C" id="tdCnl1<%=i%>">
                  <a href="javascript: setCnlNote('<%=i%>', 'CNL1');">CNL1</a>
              </td>
           <%} else {%><td class="DataTable2" onmouseover="showCnl('<%=sCnl1User%>', '<%=sCnl1Date%>','<%=sCnl1Time%>', this)"
                id="tdCnl1<%=i%>" ><%if(sCnl1User.length() > 4){%><%=sCnl1User.substring(0,4)%><%} else {%>&nbsp;<%}%></td><%}%>

           <%if(bSend && sCnl2User.equals("") && !sStrSts.equals("Shipped")){%>
               <td class="DataTable2C" id="tdCnl2<%=i%>">
                  <a href="javascript: setCnlNote('<%=i%>', 'CNL2');">CNL2</a>
              </td>
           <%} else {%><td class="DataTable2"  onmouseover="showCnl('<%=sCnl2User%>', '<%=sCnl2Date%>','<%=sCnl2Time%>', this)"
                id="tdCnl2<%=i%>" ><%if(sCnl2User.length() > 4){%><%=sCnl2User.substring(0,4)%><%} else {%>&nbsp;<%}%></td><%}%>

           <!-- ========= Pick ========== -->
           <%if(bSend && sStrSts.equals("Printed")){%><td class="DataTable2C" id="tdPck<%=i%>">
                  <a href="javascript: setQtySel('<%=i%>', 'Picked');"><%=sPckQty%></a>
              </td>
           <%} else {%><td class="DataTable2" id="tdPck<%=i%>" ><%=sPckQty%></td><%}%>
           <td class="DataTable" nowrap><%=sPckDate%> <%=sPckTime%></td>
           <td class="DataTable" nowrap><%=sPckUser%></td>

           <!-- ========= Problem ========== -->
           <td class="DataTable" nowrap>
              <%if(bSend && sStrSts.equals("Picked")){%>
                 <a href="javascript: setQtySel('<%=i%>', 'Problem');">Problem</a>
              <%} else{%><%=sPrblUser%><br><%=sPrblDate%> <%=sPrblTime%><%}%>
           </td>
           <!-- ========= Resolution ========== -->
           <td class="DataTable" nowrap>
            <%if(!sRslvDate.trim().equals("")){%>Resolved  - See log for details<%}%>&nbsp;
           </td>

           <td class="DataTable1" id="tdMail<%=i%>" nowrap><%=sFedExTrId%></td>

           <!-- ========= Shipping ========== -->
           <%if(bSend && (sStrSts.equals("Picked") || sStrSts.equals("Problem") || sStrSts.equals("Resolve") )){%><td class="DataTable2C" id="tdSnd<%=i%>">
                 <a href="javascript: setQtySel('<%=i%>', 'Shipped');"><%=sSndQty%></a>
              </td><%}
             else {%><td class="DataTable2" id="tdSnd<%=i%>" ><%=sSndQty%></td><%}%>
           <td class="DataTable" nowrap><%=sSndDate%> <%=sSndTime%></td>
           <td class="DataTable" nowrap><%=sSndUser%></td>

           <td class="DataTable" nowrap><%=sCompl%></td>
           <td class="DataTable" nowrap><%=sReason%></td>
          </tr>
          <% SvOrd = sOrd; %>
       <%}%>
     </table>
<!-- ======================================================================= -->
      </TD>
     </TR>
     <tr>
       <td>
         M A N U A L &nbsp; T R A N S F E R S  &nbsp; ARE NO LONGER NECESSARY !
         <br>Marking an order as shipped on this screen automatically transfers the
         product from your store to store 70
      </TD>
     </TR>

    </TBODY>
   </TABLE>
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