<%@ page import="java.util.*, eventcalendar.EvtAdvLst, rciutility.StoreSelect"%>
<%

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EvtAdvLst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    boolean bAuth = session.getAttribute("EVTCALCHG") != null;

    String sUser = session.getAttribute("USER").toString();
    String sEvent = request.getParameter("Event");
    String sFrom = request.getParameter("From");

    //System.out.println(sEvent + "|" +sFrom);
    EvtAdvLst advlst = new EvtAdvLst(sEvent, sFrom);

    int iNumOfAdv = advlst.getNumOfAdv();

    String [] sAdvMkt = advlst.getAdvMkt();
    String [] sAdvMktName = advlst.getAdvMktName();
    String [] sAdvNewspr = advlst.getAdvNewspr();
    String [][] sAdvDate = advlst.getAdvDate();
    String [] sAdvComment = advlst.getAdvComment();
    String [] sAdvDoc = advlst.getAdvDoc();

    String sAdvMktJsa = advlst.getAdvMktJsa();
    String sAdvMktNameJsa = advlst.getAdvMktNameJsa();
    String sAdvNewsprJsa = advlst.getAdvNewsprJsa();
    String sAdvDateJsa = advlst.getAdvDateJsa();
    String sAdvCommentJsa = advlst.getAdvCommentJsa();
    String sAdvDocJsa = advlst.getAdvDocJsa();

    int iNumOfAmd = advlst.getNumOfAmd();
    String [] sAmdAdvId = advlst.getAmdAdvId();
    String [] sAmdType = advlst.getAmdType();
    String [] sAmdTypeNm = advlst.getAmdTypeNm();
    String [] sAmdMedId = advlst.getAmdMedId();
    String [] sAmdMedia = advlst.getAmdMedia();
    String [] sAmdFrDt = advlst.getAmdFrDt();
    String [] sAmdToDt = advlst.getAmdToDt();
    String [] sAmdCommt = advlst.getAmdCommt();
    String [] sAmdDoc = advlst.getAmdDoc();
    String [][] sAmdStr = advlst.getAmdStr();

    String sMarketJsa = advlst.getMarketJsa();
    String sMktNameJsa = advlst.getMktNameJsa();
    String sMediaJsa = advlst.getMediaJsa();

    advlst.disconnect();

    StoreSelect strsel = new StoreSelect();
    String sStrJsa = strsel.getStrNum();
    String sStrNameJsa = strsel.getStrName();
    int iNumOfStr = strsel.getNumOfStr();
    String [] sStrLst = strsel.getStrLst();
    String [] sStrRegLst = strsel.getStrRegLst();
    String sStrRegJsa = strsel.getStrReg();

    String [] sStrDistLst = strsel.getStrDistLst();
    String sStrDistJsa = strsel.getStrDist();
    String [] sStrDistNmLst = strsel.getStrDistNmLst();
    String sStrDistNmJsa = strsel.getStrDistNm();

    String [] sStrMallLst = strsel.getStrMallLst();
    String sStrMallJsa = strsel.getStrMall();
    strsel = null;

%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue;  font-size:12px;} a:visited { color:blue; font-size:12px;}  a:hover { color:blue; font-size:12px;}

  table.DataTable { border: darkred solid 1px; background:#e7e7e7; text-align:center;}
  tr.DataTable { background:#FFCC99; font-family:Verdanda; text-align:center;
                 font-size:12px; font-weight:bold}
  th.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px;}

  tr.DataTable2 { background:#e7e7e7; font-family:Arial; text-align:left; font-size:10px;}
  tr.DataTable21 { color: darkblue; background:cornsilk; font-family:Verdanda; text-align:left;
                   font-size:12px; font-weight:bold}

  td.DataTable { border-bottom: darkred solid 1px; border-right: darkred solid 1px;text-align:left;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable1 { border-bottom: darkred solid 1px;text-align:center;
                  padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                  border-right: darkred solid 1px;}

  div.dvPrompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:550; background-color:LemonChiffon;
              text-align:center; font-size:10px}

  .Small{ text-align:left; font-family:Arial; font-size:10px;}
  button.Small{ text-align:left; font-family:Arial; font-size:10px;}
  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
  td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
  td.Prompt { padding-top:3px; padding-bottom:3px; vertical-align: bottom; text-align:left; font-family:Arial; font-size:10px; }
  td.Prompt1 { padding-top:3px; padding-bottom:3px; vertical-align: bottom; text-align:left; vertical-align:bottom; font-family:Arial; font-size:10px; }
  td.Prompt2 { padding-top:3px; padding-bottom:3px; text-align:center; font-family:Arial; font-size:10px; }
  td.option { text-align:left; font-size:10px}
</style>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variable
//==============================================================================
var Event = "<%=sEvent%>".replaceSpecChar();
var From = "<%=sFrom%>";
var AdvMkt = [<%=sAdvMktJsa%>];
var AdvMktName = [<%=sAdvMktNameJsa%>];
var AdvNewspr = [<%=sAdvNewsprJsa%>];
var AdvDate = [<%=sAdvDateJsa%>];
var AdvComment = [<%=sAdvCommentJsa%>];
var AdvDoc = [<%=sAdvDocJsa%>];

var Market = [<%=sMarketJsa%>];
var MktName = [<%=sMktNameJsa%>];
var Media = [<%=sMediaJsa%>];

var StrLst = [<%=sStrJsa%>]
var ArrStr = [<%=sStrJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];


//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
  setBoxclasses(["BoxName",  "BoxClose"], ["dvPrompt"]);
  window.document.focus();
}

//==============================================================================
// Load initial value on page
//==============================================================================
function chgNewspaperAds(arg, action)
{
   var hdr = "Add New Advertising";
   if(action =='UPD') { hdr = "Update Advertising: "}
   else if(action == 'DLT') { hdr = "Delete Advertising: "}

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
   document.all.dvPrompt.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvPrompt.style.pixelTop= document.documentElement.scrollTop + 200;
   document.all.dvPrompt.style.visibility = "visible";

   popPanelValue(arg, action);
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popPanel(action)
{
  var panel = "<form name='Upload'  method='post'  enctype='multipart/form-data' action='EvtAdvEnt.jsp'>"
      + "<table width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr><td class='Prompt'>&nbsp;Market &nbsp;</td>"
        + "<td class='Prompt' nowrap><input name='Market' class='Small' size=15 maxlength=2 readOnly></td>"

      if(action=="ADD") panel += "<td class='Prompt' nowrap rowspan=2><select name='MarketLst' class='Small' onClick='chgMarket(this)' size=5></select></td>"
      else panel += "<td class='Prompt' nowrap rowspan=2><input type='hidden' name='MarketLst' class='Small' value='0'></td>"

      panel += "</tr>"
      + "<tr><td class='Prompt1' colspan=3>&nbsp;</td></tr>"

      + "<tr><td class='Prompt2'>&nbsp;Publishing dates &nbsp;</td>"
        + "<td class='Prompt'colspan=2>"

        panel += "<input name='Date1' class='Small' size=10 maxlength=10 readonly>"
                + "<a href='javascript:showCalendar(1, null, null, 400, 40, document.all.Date1)' >"
                + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a>&nbsp;"

        panel += "<input name='Date2' class='Small' size=10 maxlength=10 readonly>"
                + "<a href='javascript:showCalendar(1, null, null, 400, 40, document.all.Date2)' >"
                + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a>&nbsp;"

        panel += "<input name='Date3' class='Small' size=10 maxlength=10 readonly>"
                + "<a href='javascript:showCalendar(1, null, null, 400, 40, document.all.Date3)' >"
                + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a><br>"

        panel += "<input name='Date4' class='Small' size=10 maxlength=10 readonly>"
                + "<a href='javascript:showCalendar(1, null, null, 400, 40, document.all.Date4)' >"
                + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a>&nbsp;"

        panel += "<input name='Date5' class='Small' size=10 maxlength=10 readonly>"
                + "<a href='javascript:showCalendar(1, null, null, 400, 40, document.all.Date5)' >"
                + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a>&nbsp;"

        panel += "<input name='Date6' class='Small' size=10 maxlength=10 readonly>"
                + "<a href='javascript:showCalendar(1, null, null, 400, 40, document.all.Date6)' >"
                + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a><br>"

        panel += "<input name='Date7' class='Small' size=10 maxlength=10 readonly>"
                + "<a href='javascript:showCalendar(1, null, null, 400, 40, document.all.Date7)' >"
                + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a>&nbsp;"

        panel += "</td>"

      + "</tr>"

      + "<tr><td class='Prompt'>&nbsp;Newspaper &nbsp;</td>"
        + "<td class='Prompt'><input name='Newspr' class='Small' size=15 maxlength=50 readonly></td>"

      if(action=="ADD") panel += "<td class='Prompt' nowrap rowspan=2><select name='NewsprLst' class='Small' onClick='chgNewspaper(this)' size=3></select></td>"
      else panel += "<td class='Prompt' nowrap rowspan=2><input name='NewsprLst' type='hidden' class='Small' value='0'></td>"

      panel += "</tr>"
      + "<tr><td class='Prompt1' colspan=3>&nbsp;</td></tr>"
      + "<tr><td class='Prompt'>&nbsp;Comments &nbsp;</td>"
        + "<td class='Prompt'><input name='Comment' class='Small' size=50 maxlength=100></td>"
      + "<tr><td class='Prompt'>&nbsp;Document &nbsp;</td>"
        + "<td class='Prompt' colspan=2>"
        + "<input name='Event' type='hidden' value='" + Event +"'>"
        + "<input name='From' type='hidden' value='<%=sFrom%>'>"
        + "<input name='Action' type='hidden'>"
        + "<input name='User' type='hidden' value='<%=sUser%>'>"

      if(action=='ADD') panel += "<input type='File' name='Doc' class='Small' class='Small' size=50 maxlength=256>"
      else panel += "<input name='Doc' class='Small' class='Small' size=50 maxlength=256 readonly>"
      panel += "</tr>"

     if(action!='DLT') panel += "<tr><td class='Prompt2' colspan=4><button onClick='Validate(&#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"
     else panel += "<tr><td class='Prompt2' colspan=4><button onClick='submitAdv(&#34;DLT&#34;)' class='Small'>Delete</button>&nbsp;"

     panel += "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
   + "</table></form>"
  return panel;
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popPanelValue(arg, action)
{
  var market = document.all.Market;
  var date = [document.all.Date1,
              document.all.Date2,
              document.all.Date3,
              document.all.Date4,
              document.all.Date5,
              document.all.Date6,
              document.all.Date7 ];
  var media = document.all.Newspr;
  var doc = document.all.Doc;
  var mktlist = document.all.MarketLst;
  var newsprl = document.all.NewsprLst;

  if(action=="ADD")
  {
     for(var i=0; i < Market.length; i++)
     {
        mktlist.options[i] = new Option(Market[i] + " - " + MktName[i], Market[i])
     }

     // load first market newspaper list
     newsprl.options[0] = new Option("--- Select Market ---", 0)
  }
  else
  {
     market.value = AdvMkt[arg];
     media.value = AdvNewspr[arg];
     for(var i=0; i < 7; i++)
     {
       if(AdvDate[arg][i] != "") date[i].value = AdvDate[arg][i];
       else date[i].value = ""
     }
     doc.value = AdvDoc[arg];
  }
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvPrompt.innerHTML = " ";
   document.all.dvPrompt.style.visibility = "hidden";
}
//==============================================================================
// change market with selected from dropdown menu
//==============================================================================
function chgMarket(selmkt)
{
   var mktIdx = selmkt.selectedIndex;
   document.all.Market.value = selmkt.options[mktIdx].value;

   // remove all newspaper
   var newsprl = document.all.NewsprLst;
   for(var i=newsprl.length; i >= 0; i--) { newsprl.options[i] = null; }

   // load first market newspaper list
   for(var i=0; i < Media[mktIdx].length; i++)
   {
      newsprl.options[i] = new Option(Media[mktIdx][i], Media[mktIdx][i]);
   }
   document.all.Newspr.value = "";
}

//==============================================================================
// change newspaper selected from dropdown menu
//==============================================================================
function chgNewspaper(newspL)
{
   var newsIdx = newspL.selectedIndex;
   if(newspL.options[newsIdx].value != 0) { document.all.Newspr.value = newspL.options[newsIdx].value; }
   else { alert("Please, select market first") }
}
//==============================================================================
// Validate entry
//==============================================================================
function Validate(action)
{
  var msg = ""
  var error = false;

  var mkt = document.all.Market.value.trim();
  var med = document.all.Newspr.value.trim();
  var doc = document.all.Doc.value.trim();

  // Market cannot be blank
  if(mkt == "")
  {
     error = true;
     msg += "Please, enter Market\n"
  }
  // date cannot be blank
  if(med == "")
  {
     error = true;
     msg += "Please, enter Publishing Date\n"
  }
  // newspaper cannot be blank
  if(med == "")
  {
     error = true;
     msg += "Please, enter Newspaper Name\n"
  }
  // documentcannot be blank
  if(doc == "")
  {
     error = true;
     msg += "Please, enter Document\n"
  }

  if (error) alert(msg)
  else submitAdv(action);
}
//==============================================================================
// Load initial value on page
//==============================================================================
function submitAdv(action)
{
   document.all.Action.value=action;
   document.Upload.submit();
}
//==============================================================================
// add/delete advertisings by media/store
//==============================================================================
function chgAdsByMedia(advid, action, type, typenm, media, frdate, todate, doc)
{
   var hdr = "Add New Advertising by Media/Store";
   if(action == 'DLT') { hdr = "Delete Advertising: "}

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popAdsByMediaPanel(advid, action)
     + "</tr></td>"
   + "</table>"

   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvPrompt.style.pixelTop= document.documentElement.scrollTop + 50;
   document.all.dvPrompt.style.visibility = "visible";
   //populate selection fields
   if(action == "ADD"){getMedTypeSel();}
   if(action == "DLT")
   {
       document.all.MedTypeNm.value=typenm;
       document.all.MedType.value=type;
       document.all.Media.value=media;
       document.all.PubFrDate.value=frdate;
       document.all.PubToDate.value=todate;
       document.all.Doc.value=doc;

       document.all.selMedType.style.display="none";
       document.all.selMedia.style.display="none";
       document.all.trStr.style.display="none";
       document.all.trCommt.style.display="none";
   }
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popAdsByMediaPanel(advid, action)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr><td class='Prompt' nowrap>&nbsp; Media Type: &nbsp;</td>"
        + "<td class='Prompt' nowrap>"
           + "<input name='MedTypeNm' class='Small' size=30 maxlength=50 readOnly>"
           + "<input name='MedType' type='hidden'>"
        + "</td>"
        + "<td class='Prompt' nowrap rowspan=2><select name='selMedType' class='Small' onClick='chgMedType(this)' size=5></select></td>"
      + "</tr>"

      + "<tr><td class='Prompt1' colspan=3>&nbsp;</td></tr>"

      + "<tr><td class='Prompt' nowrap>&nbsp; Media: &nbsp;</td>"
        + "<td class='Prompt' nowrap>"
           + "<input name='Media' class='Small' size=30 maxlength=50 readonly>"
           + "<input name='MedId' type='hidden'>"
        + "</td>"
        + "<td class='Prompt' nowrap rowspan=2><select name='selMedia' class='Small' onClick='chgMedia(this)' size=3></select></td>"
      + "</tr>"

      + "<tr><td class='Prompt1' colspan=3>&nbsp;</td></tr>"

      + "<tr><td class='Prompt1' nowrap>&nbsp; Publishing date &nbsp;</td>"
        + "<td class='Prompt' nowrap colspan=2>"
           + "From:<input name='PubFrDate' class='Small' size=10 maxlength=10 readonly>"
           + "<a href='javascript:showCalendar(1, null, null, 450, 250, document.all.PubFrDate)' >"
           + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a>&nbsp;"
           + " &nbsp; &nbsp; &nbsp; &nbsp;"
           + "To:<input name='PubToDate' class='Small' size=10 maxlength=10 readonly>"
           + "<a href='javascript:showCalendar(1, null, null, 600, 250, document.all.PubToDate)' >"
           + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a>&nbsp;"
        + "</td>"
      + "</tr>"

     panel += "<tr id='trStr'><td class='Prompt' style='vertical-align: middle;'>&nbsp; Store: &nbsp;"
     panel += "<td class='Prompt' colspan=2>"
     for(var i=1; i < ArrStr.length; i++)
     {
         if( i > 0 && i % 14 == 0){ panel += "<br>"; }
         panel += "<input name='Str' type='checkbox' checked value='" + ArrStr[i] + "'>" + ArrStr[i] + "&nbsp;"
     }
     panel += "<br><button onclick='checkAll(true)' class='Small'>Check All</button> &nbsp; &nbsp;"
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
             + "<button onclick='checkAll(false)' class='Small'>Reset</button>"
     panel += "</td>";
     panel += "</tr>"

     panel += "<tr id='trCommt'><td class='Prompt' nowrap>&nbsp;Comments &nbsp;</td>"
        + "<td class='Prompt' nowrap colspan=2><input name='Comment' class='Small' size=30 maxlength=100></td>"
      + "<tr id='trDoc'><td class='Prompt' nowrap>&nbsp;Document &nbsp;</td>"
        + "<td class='Prompt' nowrap colspan=2>"
          + "<input name='Event' type='hidden' value='" + Event +"'>"
          + "<input name='From' type='hidden' value='<%=sFrom%>'>"
          + "<input name='AdvId' type='hidden' value='" + advid + "'>"
          + "<input name='Action' type='hidden'>"
          + "<input name='User' type='hidden' value='<%=sUser%>'>"
          + "<br>"

     panel += "<form name='UplByMedia'  method='post'  enctype='multipart/form-data' action='EvtAdvByMedSv.jsp'>"
        + "<input name='Params' type='hidden'>";
     
     if(action=='ADD'){ panel += "<input type='File' name='Doc' class='Small' class='Small' size=50 maxlength=256>" }
     else { panel +=  "<input name='Doc' class='Small' class='Small' size=50 maxlength=256 readonly>" }
    
     panel += "</form></td>"
      + "</tr>"

     if(action!='DLT') panel += "<tr><td class='Prompt2' colspan=4><button onClick='vldAdsByMedia(&#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"
     else panel += "<tr><td class='Prompt2' colspan=4><button onClick='sbmAdvByMed(&#34;DLT&#34;)' class='Small'>Delete</button>&nbsp;"

     panel += "<button class='Small' onClick='hidePanel();' class='Small'>Close</button></td></tr>"
   + "</table>"
  return panel;
}
//==============================================================================
// check all stores
//==============================================================================
function checkAll(chk)
{
  var str = document.all.Str

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk;
  }
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
// set media type selection
//==============================================================================
function getMedTypeSel()
{
   var url = "EvRtvMedia.jsp?Action=GETMEDTYPE";
   window.frame1.location.href=url;
}
//==============================================================================
// set media type selection
//==============================================================================
function setMedTypeSel(medTypeLst, medTypeNmLst)
{
   for(var i=0; i < medTypeLst.length;i++)
   {
      document.all.selMedType.options[i] = new Option(toTitleCase(medTypeNmLst[i]), medTypeLst[i]);
   }
}
//==============================================================================
// restart page after entry done
//==============================================================================
function chgMedType(sel)
{
   document.all.MedTypeNm.value = sel.options[sel.selectedIndex].text;
   document.all.MedType.value = sel.options[sel.selectedIndex].value;

   // get media list for selected type
   var url = "EvRtvMedia.jsp?Action=GETMEDIA"
     + "&Type=" + document.all.MedType.value;
   ;
   window.frame1.location.href=url;
}
//==============================================================================
// set meai selection
//==============================================================================
function setMediaSel(medIdLst, mediaLst)
{
   if(document.all.selMedia.length > 0)
   {
      for(var i=0; i < document.all.selMedia.length ;i++)
      {
         document.all.selMedia.options[0] = null;
      }
   }

   for(var i=0; i < mediaLst.length;i++)
   {
       document.all.selMedia.options[i] = new Option(mediaLst[i], medIdLst[i]);
   }

}
//==============================================================================
// set selected media name in the input fields
//==============================================================================
function chgMedia(sel)
{
   document.all.Media.value = sel.options[sel.selectedIndex].text;
   document.all.MedId.value = sel.options[sel.selectedIndex].value;
}
//==============================================================================
// capitalize first leter of each word
//==============================================================================
function toTitleCase(str)
{
    str = str.toLowerCase();
    return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
}
//==============================================================================
// Validate entry
//==============================================================================
function vldAdsByMedia(action)
{
  var msg = ""
  var error = false;

  var type = document.all.MedType.value.trim();
  var media = document.all.Media.value.trim();
  var medId = document.all.MedId.value.trim();
  var from = document.all.PubFrDate.value.trim();
  var to = document.all.PubToDate.value.trim();
  var doc = document.all.Doc.value.trim();
  var comment = document.all.Comment.value.trim();

  if(type == ""){error = true; msg += "Please select Media Type\n"}
  if(media == "") { error = true; msg += "Please select Media\n"}
  if(from == "") { error = true; msg += "Please select From Date\n"}
  if(to == "") { error = true; msg += "Please select To Date\n"}
  // documentcannot be blank
  if(doc == ""){ error = true; msg += "Please, enter Document\n" }

  var str = document.all.Str;
  var strfnd = false;
  var strArr = new Array();
  for(var i=0, j=0; i < str.length; i++)
  {
    if(str[i].checked){strArr[j] = str[i].value; j++; strfnd = true; }
  }
  if(!strfnd){error = true; msg += "Please select at least 1 Store\n"}

  if (error) alert(msg)
  else sbmAdvByMed(action);
}
//==============================================================================
// Load initial value on page
//==============================================================================
function sbmAdvByMed(action)
{    
    var params = "";
    var event = setparam(document.all.Event.value, 50);
    var from = setparam(document.all.From.value, 10);
    var advid = setparam(document.all.AdvId.value, 10);
    var medtype = setparam(document.all.MedType.value, 2);
    var medid = setparam(document.all.MedId.value, 10);
    var frdate = setparam(document.all.PubFrDate.value, 10);
    var todate = setparam(document.all.PubToDate.value, 10);

    var strlst = ""; 
    if(action=="ADD")
    {
       var str = document.all.Str;
       for(var i=0, j=0; i < 50; i++)
       {
    	 if(i < str.length && str[i].checked){ strlst += setparam(str[i].value, 5);}
    	 else{ strlst += setparam(" ", 5); }
       }
    }
    else
    {
    	var str = document.all.Str;
        for(var i=0, j=0; i < 50; i++)
        {
     	   strlst += setparam(" ", 5); 
        }
    }
    var commt = setparam(document.all.Comment.value, 100);
    var doc = document.all.Doc.value;
    if (doc) {
        var startIndex = (doc.indexOf('\\') >= 0 ? doc.lastIndexOf('\\') : doc.lastIndexOf('/'));
        var filename = doc.substring(startIndex);
        if (filename.indexOf('\\') === 0 || filename.indexOf('/') === 0) {
            filename = filename.substring(1);
        }
        doc = filename;
    }
    var doc = setparam(doc, 256);
    action = setparam(action, 10);
    var user = setparam(document.all.User.value, 10);
    params = event + from + advid + medtype + medid + frdate + todate 
       + strlst + commt + doc + action + user;  
       
    document.all.Params.value = params;
    if (action.trim() != "DLT" ||  action.trim() == "DLT" && confirm("Are You sure you want to delete event?"))
    {
    	document.UplByMedia.submit();
    }
} 
//==============================================================================
//restart page after entry done
//==============================================================================
function setparam(param, len)
{
	var space = ""; 
	for(var i=0; i < len; i++){ space += " "; }
	param += space;
	param = param.substring(0, len);
	return param;
}
//==============================================================================
// restart page after entry done
//==============================================================================
function reStart()
{

  var url = "EvtAdvLst.jsp?Event=" + Event
          + "&From=" + From;
  //alert(url + "\n" + Event + "\n<%=sEvent%>")
  window.location.href = url;
}
//==============================================================================
// display error for entry
//==============================================================================
function displayError(Error)
{
   window.frame1.close();
   alert(Error)
}
//==============================================================================
// Replace &, # signs on escape sequense;
//==============================================================================
function String.prototype.replaceSpecChar()
{
    var s = this;
    var newStr = "";
    var obj = ["'", "#", "&", "%"];
    for(var i=0; i < s.length; i++)
    {
       var l = s.substring(i,i+1);
       for(var j=0; j < obj.length; j++)
       {
          if(l == obj[j])  {  l = escape(obj[j]); break; }
       }
       newStr += l;
    }
    return newStr;
}
//==============================================================================
// show  ',  &, # charachters on screen
//==============================================================================
function String.prototype.showSpecChar()
{
    var s = this;
    var chk = ["&#39;", "&#38;", "&#35;", "&#37;"];
    var exc = ["%27", "%26", "%23", "%25"];
    for(var i=0; i < chk.length; i++)
    {
       while (s.match(chk[i])) { s = s.replace(chk[i], unescape(exc[i])); }
    }
    return s;
}

</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>

<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvPrompt" class="dvPrompt"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Event Calendar - Advertising List
       <br><%=sEvent%>&nbsp; From: <%=sFrom%>
       <br>
       </b>


        <a href="../"><font color="red" size="-1">Home</font></a>;&nbsp;&nbsp;&nbsp;
        <%if(bAuth) {%><a href="javascript:chgNewspaperAds(0, 'ADD')">Add Newspaper Ads</a><%}%>
        <!----------------- start of ad table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0">
           <thead style="overflow: visible;">
             <tr class="DataTable">
               <th class="DataTable">Market</th>
               <th class="DataTable">Publishing<br>Date</th>
               <th class="DataTable">Newspaper</th>
               <th class="DataTable">Documnets</th>
               <th class="DataTable">Comments</th>
               <%if(bAuth) {%>
                  <th class="DataTable">D<br>l<br>t</th>
               <%}%>
             </tr>
           </thead>


           <!--------------------- Event Detail ----------------------------->
           <tbody>
           <%for(int i=0; i < iNumOfAdv; i++){%>
              <tr class="DataTable2">
                <td class="DataTable" nowrap><%=sAdvMkt[i] + " - " + sAdvMktName[i]%></td>

                <td class="DataTable" nowrap>
                  <%for(int j=0; j < 7; j++){%>
                     <%if(!sAdvDate[i][j].trim().equals("01/01/0001")) {%><%=sAdvDate[i][j]%>&nbsp;<%}%>
                  <%}%>
                &nbsp;</td>

                <td class="DataTable" nowrap><%=sAdvNewspr[i]%></td>
                <td class="DataTable" nowrap>
                   <a target="_blank" href="Advertising/<%=sAdvDoc[i]%>"><%=sAdvDoc[i]%></a>
                </td>
                <td class="DataTable" nowrap><%=sAdvComment[i]%>&nbsp;</td>
                <%if(bAuth) {%>
                   <td class="DataTable" nowrap><a href="javascript:chgNewspaperAds(<%=i%>, 'DLT')">Dlt</a></td>
                <%}%>
              </tr>
           <%}%>

           </tbody>
         </table>
         <!----------------- end of ad table ------------------------>
         <!----------------- start of ads by media table ---------------------->
         <%if(bAuth) {%><a href="javascript:chgAdsByMedia(0, 'ADD')">Add Ads By Media</a><%}%>
        <!----------------- start of ad table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0">
           <thead style="overflow: visible;">
             <tr class="DataTable">
               <th class="DataTable">Type</th>
               <th class="DataTable">Media</th>
               <th class="DataTable">Publishing<br>Dates</th>
               <th class="DataTable">Documnets</th>
               <th class="DataTable">Str</th>
               <th class="DataTable">Comments</th>
               <%if(bAuth) {%>
                  <th class="DataTable">D<br>l<br>t</th>
               <%}%>
             </tr>
           </thead>

           <!--------------------- Event Detail ----------------------------->
           <tbody>
           <%for(int i=0; i < iNumOfAmd; i++){%>
              <tr class="DataTable2">
                <td class="DataTable" nowrap><%=sAmdTypeNm[i]%></td>
                <td class="DataTable" nowrap><%=sAmdMedia[i]%></td>
                <td class="DataTable" nowrap><%=sAmdFrDt[i]%> - <%=sAmdToDt[i]%></td>
                <td class="DataTable" nowrap>
                   <a target="_blank" href="Advertising/<%=sAmdDoc[i]%>"><%=sAmdDoc[i]%></a>
                </td>

                <td class="DataTable" nowrap>
                   &nbsp;
                </td>

                <td class="DataTable" nowrap><%=sAmdCommt[i]%>&nbsp;</td>
                <%if(bAuth) {%>
                   <td class="DataTable" nowrap>
                     <a href="javascript:chgAdsByMedia('<%=sAmdAdvId[i]%>', 'DLT', '<%=sAmdType[i]%>'
                        , '<%=sAmdTypeNm[i]%>', '<%=sAmdMedia[i]%>', '<%=sAmdFrDt[i]%>','<%=sAmdToDt[i]%>'
                        , '<%=sAmdDoc[i]%>')">Dlt</a>
                   </td>
                <%}%>
              </tr>

            <%}%>

           </tbody>
         </table>
      </td>
     </tr>
    </table>
  </body>
</html>
<%}%>