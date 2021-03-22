<%@ page import="advertising.AdFisCal, java.util.*"%>
<%
   String sMonBeg = request.getParameter("MonBeg");
   String sMonName = request.getParameter("MonName");
   String sMarket = request.getParameter("Market");
   String sMktName = request.getParameter("MktName");
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=AdFisCal.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
     String sAppl = null;
     if(session.getAttribute("ADVERTISES") != null) sAppl = session.getAttribute("ADVERTISES").toString();

   AdFisCal adfisc = new AdFisCal(sMarket, sMonBeg);

   int iNumOfDay = adfisc.getNumOfDay();
   String [] sDay = adfisc.getDay();
   String [] sDate = adfisc.getDate();
   String [] sWkBeg = adfisc.getWkBeg();
   String [] sWkEnd = adfisc.getWkEnd();

   int iNumOfWk = adfisc.getNumOfWk();
   int [] iNumOfAdv = adfisc.getNumOfAdv();
   String [][] sGroup = adfisc.getGroup();
   String [][] sMedType = adfisc.getMedType();
   String [][] sMedia = adfisc.getMedia();
   String [][] sPayee = adfisc.getPayee();
   int [][] iDocMx = adfisc.getDocMx();
   String [][][] sDocNm = adfisc.getDocNm();

   String sDateJsa = adfisc.getDateJsa();
   String sWkBegJsa = adfisc.getWkBegJsa();
   String sWkEndJsa = adfisc.getWkEndJsa();

   String sGroupJsa = adfisc.getGroupJsa();
   String sMedTypeJsa = adfisc.getMedTypeJsa();
   String sMediaJsa = adfisc.getMediaJsa();
   String sPayeeJsa = adfisc.getPayeeJsa();
   String sPromTypeJsa = adfisc.getPromTypeJsa();
   String sPromDescJsa = adfisc.getPromDescJsa();
   String sOrgWkJsa = adfisc.getOrgWkJsa();
   String sWkDayJsa = adfisc.getWkDayJsa();
   String sCommentJsa = adfisc.getCommentJsa();
   String sSeqJsa = adfisc.getSeqJsa();
   String sDocNmJsa = adfisc.getDocNmJsa();

   String [] sPrvNxtMonth = adfisc.getPrvNxtMonth();
   String [] sPrvNxtMonName = adfisc.getPrvNxtMonName();

   adfisc.disconnect();
%>
<html>
<head>
<style>
        body {background:LemonChiffon; text-align:center;}
        a { color:blue} a:visited { color:blue}  a:hover { color:blue}

        table.Cal { background:LemonChiffon; text-align:center;}
        th.CalH { background-color:lightgrey; height: 5%;text-align:center; font-size:12px}
        th.CalH1 { background-color:lightgrey; height: 5%;text-align:center; font-size:16px}
        td.Cal { border-bottom: black solid 1px; border-left: black solid 1px; background-color:white; width: 13.5%; height: 20%;
                 text-align:left; vertical-align: top; font-size:12px;  font-weight:bold}
        td.Cal1 { border-bottom: black solid 1px; background-color:azure; height: 20%; text-align:left; vertical-align: top; font-size:12px;}
        td.Cal2 { cursor: hand; background-color:azure; text-align:left; vertical-align: top; font-size:12px;}

        .Graph01 { border-bottom: white solid 1px; background-color:lightpink; width: 100%; height: 10; text-align:left; vertical-align: top; font-size:12px; }
        .Graph02 { border-bottom: white solid 1px; background-color:lightgreen; width: 100%; height: 10; text-align:left; vertical-align: top; font-size:12px; }
        .Graph03 { border-bottom: white solid 1px; background-color:lightblue; width: 100%; height: 10; text-align:left; vertical-align: top; font-size:12px; }
        .Graph04 { border-bottom: white solid 1px; background-color:yellow; width: 100%; height: 10; text-align:left; vertical-align: top; font-size:12px; }
        .Graph05 { border-bottom: white solid 1px; background-color:orange; width: 100%; height: 10; text-align:left; vertical-align: top; font-size:12px; }
        .Graph06 { border-bottom: white solid 1px; background-color:white; width: 100%; height: 10; text-align:left; vertical-align: top; font-size:12px; }


        div.Cal { position:absolute; visibility:hidden; background-attachment: scroll;
                    border: black solid 2px; width:300; background-color:cornsilk; z-index:10;
                    text-align:left; font-size:10px}
        td.Dtl   {text-align:left; font-family:Arial; font-size:12px; }
        td.Dtl1  {background-color: blue; color:white; border-bottom: black solid 1px; text-align:center; font-family:Arial; font-size:11px; font-weight:bold}
        td.Dtl2  {background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.Dtl3   {text-align:center; font-family:Arial; font-size:12px; }

        div.Menu { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:#EEEEEE; z-index:1;
              text-align:center; font-size:10px}

        div.dvFile { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:bottom; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }

        td.Doc { border-bottom: black solid 1px; border-right: black solid 1px; text-align:left; font-family:Arial; font-size:10px; }
        td.Doc1 { border-bottom: black solid 1px; border-right: black solid 1px; text-align:center; font-family:Arial; font-size:10px; }

        td.Menu   {border-bottom: black solid 1px; cursor: hand; text-align:left; font-family:Arial; font-size:10px; }
        td.Menu1  {color:blue;border-bottom: black solid 1px; text-align:center; font-family:Arial; font-size:11px; font-weight:bold}
        td.Menu2  {border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }


        .small{ text-align:left; font-family:Arial; font-size:10px;}

</style>
<SCRIPT language="JavaScript1.2">
//------------------------------------------------------------------------------
// global variables
//------------------------------------------------------------------------------
var  Market = "<%=sMarket%>";
var  MktName = "<%=sMktName%>";
var  MonBeg = "<%=sMonBeg%>";
var  MonName = "<%=sMonName%>";


var  Date = [<%=sDateJsa%>]
var  WkBeg = [<%=sWkBegJsa%>]
var  WkEnd = [<%=sWkEndJsa%>]

var  Group = [<%=sGroupJsa%>]
var  MedType = [<%=sMedTypeJsa%>]
var  Media = [<%=sMediaJsa%>]
var  Payee = [<%=sPayeeJsa%>]
var  PromType = [<%=sPromTypeJsa%>]
var  PromDesc = [<%=sPromDescJsa%>]
var  OrgWk = [<%=sOrgWkJsa%>];
var  WkDay = [<%=sWkDayJsa%>];
var  Comment = [<%=sCommentJsa%>];
var  Sequence = [<%=sSeqJsa%>];
var  Document = [<%=sDocNmJsa%>];
//---------------------------------------------------------
// work on loading time
//---------------------------------------------------------
function bodyLoad()
{
   showEvt();
   setBoxclasses(["BoxName",  "BoxClose"], ["dvFile"]);
}
//---------------------------------------------------------
// show events
//---------------------------------------------------------
function showEvt()
{
   var cell = new Array();
   var  c = 0;
   var ads = null;
   var wkd = null;
   var pye = null;
   var cmt = null;

   // paintCell(cell, className);

   for(var i=0, j=0, l=0; i < Date.length; i++)
   {
      // Week begining
      if(Date[i] == WkBeg[i])
      {
         ads = new Array();
         wkd = new Array();
         pye = new Array();
         cmt = new Array();

         for(var k=0; k < MedType[j].length; k++)
         {
            ads[k] = MedType[j][k].trim();
            wkd[k] = WkDay[j][k].trim();
            pye[k] = Payee[j][k].trim();
            cmt[k] = Comment[j][k].trim();
         }
         cell = new Array();
         l=0;
         j++;
      }

      cell[l++] = "c" + i;
      // end of week - add color bars
      if(Date[i] == WkEnd[i])
      {
         paintCell(cell, ads, wkd, pye, cmt);
         l=0;
      }
   }
}

//---------------------------------------------------------
// show events
//---------------------------------------------------------
function paintCell(cell, ads, wkd, pye, cmt)
{
   var inner = null;
   var className = null;
   var text = null;

   for(var i=0; i < cell.length; i++)
   {
      inner = document.all[cell[i]].innerHTML;
      for(var j=0; j < ads.length; j++)
      {
         text = "&nbsp;";
         if(ads[j]=="NP")
         {
            if(wkd[j]==i)
            {
              className = "Graph01";
              text = pye[j].substring(0, 15);
            }
            else className = "Graph06";
         }
         else if(ads[j]=="DM") {className = "Graph02"}
         else if(ads[j]=="RA") {className = "Graph03"}
         else if(ads[j]=="TV") {className = "Graph04"}
         else {className = "Graph05"}

         if(ads[j] != "NP" && i == 0)
         {
           text = pye[j].substring(0, 15);
         }
         else if(ads[j] != "NP" && i == 1 && cmt[j] != "")
         {
           text = cmt[j].substring(0, 17);
         }


         inner += "<br><span class='" + className + "'>" + text + "</span>";
      }
      document.all[cell[i]].innerHTML = inner;
   }
}
//---------------------------------------------------------
// show Menu
//---------------------------------------------------------
function showMenu(wk, adv)
{
   var MenuName = "";
   var MenuOpt = "";
   var curLeft = 0;
   var curTop = 0;


   // menu panel name
   MenuName = "<td class='Menu1' nowrap>Select</td>";

   // show details
   MenuOpt += "<tr><td colspan='2' class='Menu' onmouseOver='hilightOption(this, true)' onmouseOut='hilightOption(this, false)' align='center' "
          + "onclick='showAdsDtl(&#34;" + wk + "&#34;, &#34;" + adv + "&#34;)'>Details"
          + "</td></tr>";

   // upload file
<% // secure from unauthoruized user - they can only look at ads but not change
   if(sAppl != null) {%>

   MenuOpt += "<tr><td colspan='2' class='Menu' onmouseOver='hilightOption(this, true)' onmouseOut='hilightOption(this, false)' align='center' "
          + "onclick='uploadAds(&#34;" + wk + "&#34;, &#34;" + adv + "&#34;)'>Upload Ads"
          + "</td></tr>";
<%}%>

   if(Document[wk][adv].length > 0)
   {
      // open document with advertising
      MenuOpt += "<tr><td colspan='2' class='Menu' onmouseOver='hilightOption(this, true)' onmouseOut='hilightOption(this, false)' align='center' "
          + "onclick='showAdsList(&#34;" + wk + "&#34;, &#34;" + adv + "&#34;); hideMenu();'>Show Ads"
          + "</td></tr>";
   }

   // add close option on menu
   MenuOpt += "<tr><td colspan='2' class='Menu' onmouseOver='hilightOption(this, true)' onmouseOut='hilightOption(this, false)' align='center' "
       + "onclick='hideMenu();'>Close"
       + "</td></tr>";

   var MenuHtml = "<table width='100%' cellPadding='0' cellSpacing='0'>"
   + "<tr>"
     + MenuName
     + "<td class='Menu2' valign=top>"
     +  "<img src='CloseButton.bmp' onclick='javascript:hideMenu();' alt='Close'>"
     + "</td>"
   + "</tr>"
   + MenuOpt
   + "</table>"



   if (curTop > (document.documentElement.scrollTop + screen.height - 250))
   {
      curTop = document.documentElement.scrollTop + screen.height - 300;
   }
      curLeft += 70;
   if (curLeft > (document.documentElement.scrollLeft + screen.width - 200))
   {
      curLeft = document.documentElement.scrollLeft + screen.width - 200;
   }

   document.all.menu.innerHTML=MenuHtml
   document.all.menu.style.pixelLeft=curLeft
   document.all.menu.style.pixelTop=curTop
   document.all.menu.style.visibility="visible"

}
//---------------------------------------------------------
// show Advertisment lists
//---------------------------------------------------------
function showAdsList(wk, adv)
{
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>File List</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popPanel(wk, adv)
     + "</tr></td>"
   + "</table>"

   document.all.dvFile.innerHTML=html;
   document.all.dvFile.style.pixelLeft=document.documentElement.scrollLeft + 200;
   document.all.dvFile.style.pixelTop=document.documentElement.scrollTop + 50;
   document.all.dvFile.style.visibility="visible"

}
//---------------------------------------------------------
// show Advertisment lists
//---------------------------------------------------------
function popPanel(wk, adv)
{
   var dummy = "<table>";
   var panel = "<table width='100%' cellPadding='0' cellSpacing='0'>"
      + "<tr><td class='Doc1'>File Name</td>"
          + "<td class='Doc1'>Delete</td>"
      + "</tr>"
   for(var i=0; i < Document[wk][adv].length; i++)
   {
      panel += "<tr><td class='Doc'><a href='javascript: showAdsFile(" + wk + ", " + adv + ", " + i + ")'>" + Document[wk][adv][i] + "</a></td>"
             + "<td class='Doc1'><a href='javascript: dltDoc(" + wk + ", " + adv + ", " + i + ")'>D</a></td><tr>"
   }

   panel += "<tr><td class='Prompt1' colspan=4><button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
   panel += "</table>";
   return panel;
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvFile.innerHTML = " ";
   document.all.dvFile.style.visibility = "hidden";
}
//---------------------------------------------------------
// show Advertisment Document (picture, mp3 , e.t.c.)
//---------------------------------------------------------
function showAdsFile(wk, adv, doc)
{
  hideMenu();
  var url = "Advertising/" + Document[wk][adv][doc];
  var WindowName = 'Advertising';
  var WindowOptions =
   'width=800,height=500, left=100,top=50, resizable=yes, toolbar=yes, location=yes, directories=yes, status=yes, scrollbars=yes,';

  //alert("|" + url + "|")
  window.open(url, WindowName, WindowOptions);
}

//---------------------------------------------------------
// show Advertisment Document (picture, mp3 , e.t.c.)
//---------------------------------------------------------
function dltDoc(wk, adv, doc)
{
   url = "AdFileDlt.jsp?"
       + "Market=" + Market
       + "&Media=" + MedType[wk][adv]
       + "&PromoType=" + PromType[wk][adv]
       + "&PromoDesc=" + PromDesc[wk][adv]
       + "&OrigWk=" + OrgWk[wk][adv]
       + "&Seq=" + Sequence[wk][adv]
       + "&Doc=" + Document[wk][adv][doc]
       + "&MktName=" + MktName
       + "&MonBeg=" + MonBeg
       + "&MonName=" + MonName
       + "&Action=DLT"
    //alert(url)
    window.location.href=url;
}
//---------------------------------------------------------
// show Advertisment details
//---------------------------------------------------------
function showAdsDtl(wk, adv)
{
   hideMenu();
   var promty = null;
   var grp = null;
   if (Group[wk][adv]=="DM") grp = "Direct Mail"
   else if (Group[wk][adv]=="NP") grp = "Newspaper"
   else if (Group[wk][adv]=="RA") grp = "Radio"
   else if (Group[wk][adv]=="TV") grp = "TV"
   else grp = "Other"

   if (PromType[wk][adv]=="P") promty = "Promotion"
   else if (PromType[wk][adv] =="E") promty = "Event"
   else if (PromType[wk][adv] =="N") promty = "Non-Event"
   else if (PromType[wk][adv] =="X") promty = "None"
   else if (PromType[wk][adv] =="M") promty = "Media"

   var wkdy = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday","Sunday"]

   var ads = "<table width='100%' cellPadding='0' cellSpacing='0'>"
           + "<tr>"
           + "<td class='Dtl1' nowrap>Advertising Details</td>"
           + "<td class='Dtl2' valign=top>"
           +  "<img src='CloseButton.bmp' onclick='javascript:document.all.dvCalendar.style.visibility=&#34;hidden&#34;' alt='Close'>"
           + "</td></tr>"
           + "<tr>"
           + "<td class='Dtl'>"
           + "Group: <font color=blue>" + grp + "</font><br>"
           + "Media: <font color=blue>" + Media[wk][adv].trim() + "</font><br>"
           + "Type: <font color=blue>" + promty + "</font><br>"
           + "Promotion: <font color=blue>" + PromDesc[wk][adv].trim() + "</font><br>"
           + "Payee: <font color=blue>" + Payee[wk][adv].trim() + "</font><br>"
           + "Originating week: <font color=blue>" + OrgWk[wk][adv].trim() + "</font><br>"

   if (MedType[wk][adv]=="NP") ads += "Day: <font color=blue>" + wkdy[WkDay[wk][adv]] + "</font><br>" ;
   if (Comment[wk][adv].trim() !=" ") ads += "Comment: <font color=blue>" + Comment[wk][adv].trim() + "</font>";

   ads += "</td></tr>"
        + "<td class='Dtl3'>"
        + "<button class='small' onClick='document.all.dvCalendar.style.visibility=&#34;hidden&#34;'>Close</button>"
        + "</td></tr>"
        + "</table>"


  // alert(ads)
  document.all.dvCalendar.innerHTML=ads;
  document.all.dvCalendar.style.pixelLeft= (document.documentElement.scrollLeft + screen.width - 700) / 2
  document.all.dvCalendar.style.pixelTop=document.documentElement.scrollTop + screen.height - 650;
  document.all.dvCalendar.style.visibility="visible"

}
//---------------------------------------------------------
// upload file with ads
//---------------------------------------------------------
<% // secure from unauthoruized user - they can only look at ads but not change
   if(sAppl != null) {%>

function uploadAds(wk, adv)
{
   hideMenu();
   var ads = ""
         + "<table width='100%' cellPadding='0' cellSpacing='0'>"
           + "<tr>"
           + "<td class='Dtl1' nowrap>Upload Advertising File</td>"
           + "<td class='Dtl2' valign=top>"
           +  "<img src='CloseButton.bmp' onclick='javascript:document.all.dvCalendar.style.visibility=&#34;hidden&#34;' alt='Close'>"
           + "</td></tr>"
           + "<tr colspan='2'>"
           + "<td class='Dtl3'>"
           + "<form name='Upload'  method='post'  enctype='multipart/form-data' action='AdFileUpload1.jsp'>"
             + "<input type='hidden' name='Market' class='small' value='" + Market + "'>"
             + "<input type='hidden' name='Media' class='small' value='" + MedType[wk][adv] + "'>"
             + "<input type='hidden' name='PromoType' class='small' value='" + PromType[wk][adv] + "'>"
             + "<input type='hidden' name='PromoDesc' class='small' value='" + PromDesc[wk][adv] + "'>"
             + "<input type='hidden' name='OrigWk' class='small' value='" + OrgWk[wk][adv] + "'>"
             + "<input type='hidden' name='Seq' class='small' value='" + Sequence[wk][adv] + "'>"
             + "<input type='hidden' name='MktName' class='small' value='" + MktName + "'>"
             + "<input type='hidden' name='MonBeg' class='small' value='" + MonBeg + "'>"
             + "<input type='hidden' name='MonName' class='small' value='" + MonName + "'>"
             + "<input type='hidden' name='Action' class='small' value='ADD'>"
             + "<input type='File' name='Ads' class='small' size=100><br>"
             + "</form>"
           + "<button name='Submit' class='small' onClick='sbmUpload()'>Upload</button>"
           + "</td></tr>"
        + "</table>"

  // alert(ads)
  document.all.dvCalendar.innerHTML=ads;
  document.all.dvCalendar.style.pixelLeft= (document.documentElement.scrollLeft + screen.width - 700) / 2
  document.all.dvCalendar.style.pixelTop=document.documentElement.scrollTop + screen.height - 650;
  document.all.dvCalendar.style.visibility="visible"

}

<%}%>
//------------------------------------------------------------------------------
// Hilight menu options, when mouse moves over it.
//------------------------------------------------------------------------------
function sbmUpload()
{
  var form = document.Upload;
  var error = false;
  var msg = "";
  var file = form.Ads.value.trim();
  if(file == "")
  {
     error = true;
     msg = "Please type full file path"
  }
  if (error) { alert(msg);}
  else
  {
    form.submit();
    hideMenu();
  }
}
//------------------------------------------------------------------------------
// Hilight menu options, when mouse moves over it.
//------------------------------------------------------------------------------
function hilightOption(obj, over)
{
  if(over)
  {
    obj.style.color = "darkred";
    obj.style.textDecoration="underline"
    obj.style.backgroundColor = "white";
  }
  else
  {
    obj.style.color = "black";
    obj.style.textDecoration="none"
    obj.style.backgroundColor = "#EEEEEE";
  }
}

//========================================================================
// close dropdown menu
//========================================================================
function hideMenu(){  document.all.menu.style.visibility="hidden"}

</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

</head>
<!-------------------------------------------------------------------->
<body onload="bodyLoad()" >
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="menu" class="Menu"></div>
<div id="dvCalendar" class="Cal"></div>
<div id="dvFile" class="dvFile"></div>
<!-------------------------------------------------------------------->

   <table class='Cal' width="100%" height="100%" cellPadding="0" cellSpacing="0">
      <tr>
        <th class='CalH' rowspan='2'>Media/<br>Events</th>
        <th class='CalH1' colspan='7'>
            <a href="AdFisCal.jsp?MonBeg=<%=sPrvNxtMonth[0]%>&MonName=<%=sPrvNxtMonName[0]%>&Market=<%=sMarket%>&MktName=<%=sMktName%>">
            <IMG SRC="arrowLeft.gif" style="border=none;" ALT="Previous Month"></a>
              <%=sMktName%> Advertising Calendar - <%=sMonName%>
            <a href="AdFisCal.jsp?MonBeg=<%=sPrvNxtMonth[1]%>&MonName=<%=sPrvNxtMonName[1]%>&Market=<%=sMarket%>&MktName=<%=sMktName%>">
            <IMG SRC="arrowRight.gif" style="border=none;" ALT="Previous Month"></a>
        </th>
      </tr>
      <tr>
         <th class='CalH'>Mo</th><th class='CalH'>Tu</th><th class='CalH'>We</th><th class='CalH'>Th</th><th class='CalH'>Fr</th><th class='CalH'>Sa</th><th class='CalH'>Su</th>
      </tr>
      <%for(int i=0, j=0; i < iNumOfDay; i++) {%>
          <%if(sDate[i].equals(sWkBeg[i])) {%>
            <tr>
              <td class='Cal1'>
                 <table class='Cal' cellPadding="0" cellSpacing="0">
                   <tr><td class='Cal2'>&nbsp;</td></tr>
                     <%for(int k=0; k < iNumOfAdv[j]; k++) {%>
                         <tr>
                            <td class='Cal2' onClick="showMenu(<%=j%>, <%=k%>)">
                               <u><%=sMedia[j][k].substring(0,1)+sMedia[j][k].substring(1, 15).toLowerCase()%>
                               <%if(iDocMx[j][k] > 0){%>*<%}%>
                               </u>
                            </td>
                        </tr>
                     <%}
                       j++;%>
                 </table>
              </td>
          <%}%>
            <td id="c<%=i%>" class='Cal'><%=sDay[i]%></td>
          <%if(sDate[i].equals(sWkEnd[i])) {%></tr><%}%>
      <%}%>
    </table>
</body>
</html>

<%}%>
