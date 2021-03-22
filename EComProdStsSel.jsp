<%@ page import=" rciutility.ClassSelect, rciutility.StoreSelect, java.util.*"%>
<%
   StoreSelect strlst = null;

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=EComProdStsSel.jsp&APPL=ALL");
   }
   else
   {
      ClassSelect divsel = new ClassSelect();
      String sDiv = divsel.getDivNum();
      String sDivName = divsel.getDivName();
      String sDpt = divsel.getDptNum();
      String sDptName = divsel.getDptName();
      String sDptGroup = divsel.getDptGroup();

      String sStrAllowed = null;
      String sUser = null;

     sStrAllowed = session.getAttribute("STORE").toString();
     sUser = session.getAttribute("USER").toString();


     if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
     {
       strlst = new StoreSelect(20);
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

<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}

  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}

  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#0000CD, endColorStr=#4169E1);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#0000CD, endColorStr=#4169E1);
              color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];

var StrAllowed = "<%=sStrAllowed%>";
var User = "<%=sUser%>";

var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  doDivSelect(null);
}
//==============================================================================
// popilate division selection
//==============================================================================
function doDivSelect(id) {
    var df = document.all;
    var divisions = [<%=sDiv%>];
    var divisionNames = [<%=sDivName%>];
    var depts = [<%=sDpt%>];
    var deptNames = [<%=sDptName%>];
    var dep_div = [<%=sDptGroup%>];
    var chg = id;

    var allowed;

    if (id == null || id == 0)
    {
        //  populate the division list
        var start = 0
        for (var i = start, j=0; i < divisions.length; i++, j++)
        {
           df.selDiv.options[j] = new Option(divisionNames[i],divisions[i]);
        }
        if (id == null && document.all.DivArg.value.trim() > 0) id = eval(document.all.DivArg.value.trim());
        if (id == null) id = 0;
        df.selDiv.selectedIndex = id;
    }

    df.DivName.value = df.selDiv.options[id].text
    df.Div.value = df.selDiv.options[id].value
    df.DivArg.value = id

    allowed = dep_div[id].split(":");

    //  clear current depts
    for (var i = df.selDpt.length; i >= 0; i--)
    {
       df.selDpt.options[i] = null;
    }

    //  if all are to be displayed
    if (allowed[0] == "all")
    {
       for (var i = 0; i < depts.length; i++)
            df.selDpt.options[i] = new Option(deptNames[i],depts[i]);
    }
    //  else display the desired depts
    else
    {
       for (var i = 0; i < allowed.length; i++)
           df.selDpt.options[i] = new Option(deptNames[allowed[i]], depts[allowed[i]]);
    }

    if(chg!=null)
    {
      showDptSelect(0);
    }

    df.Season[0].checked=true;
    for(var i=1; i < df.Season.length;i++)
    {
       df.Season[i].checked=false;
    }

}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showDptSelect(id)
{
   var df = document.all;
   document.all.DptName.value = document.all.selDpt.options[id].text
   document.all.Dpt.value = document.all.selDpt.options[id].value

   if(id != 0) { df.Season[0].checked=true; df.Season[1].checked=false; df.Season[2].checked=false; }
}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showVenSelect(ven, vennm)
{
   document.all.VenName.value = vennm
   document.all.Ven.value = ven
}
//==============================================================================
// retreive vendors
//==============================================================================
function rtvVendors()
{
   if (Vendor==null)
   {
      var url = "RetreiveVendorList.jsp"
      //alert(url);
      //window.location.href = url;
      window.frame1.location = url;
   }
   else { document.all.dvVendor.style.visibility = "visible"; }
}

//==============================================================================
// popilate division selection
//==============================================================================
function showVendors(ven, venName)
{
   Vendor = ven;
   VenName = venName;
   var html = "<input name='FndVen' class='Small' size=4 maxlength=4>&nbsp;"
     + "<input name='FndVenName' class='Small1' size=25 maxlength=25>&nbsp;"
     + "<button onclick='findSelVen()' class='Small'>Find</button>&nbsp;"
     + "<button onclick='document.all.dvVendor.style.visibility=&#34;hidden&#34;' class='Small'>Close</button><br>"

   var dummy = "<table>"

   html += "<div id='dvInt' class='dvInternal'>"
         + "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='font-size:10px;'>"
   for(var i=0; i < ven.length; i++)
   {
     html += "<tr id='trVen'><td style='cursor:default;' onclick='javascript: showVenSelect(&#34;" + ven[i] + "&#34;, &#34;" + venName[i] + "&#34;)'>" + venName[i] + "</td></tr>"
   }
   html += "</table></div>"
   var pos = objPosition(document.all.VenName)

   document.all.dvVendor.innerHTML = html;
   document.all.dvVendor.style.pixelLeft= pos[0];
   document.all.dvVendor.style.pixelTop= pos[1] + 25;
   document.all.dvVendor.style.visibility = "visible";
}
//==============================================================================
// find selected vendor
//==============================================================================
function findSelVen()
{
  var ven = document.all.FndVen.value.trim().toUpperCase();
  var vennm = document.all.FndVenName.value.trim().toUpperCase();
  var dvVen = document.all.dvVendor
  var fnd = false;

  // zeroed last search
  if(ven != "" && ven != " " || LastVen != vennm) LastTr=-1;
  LastVen = vennm;

  for(var i=LastTr+1; i < Vendor.length; i++)
  {
     if(ven != "" && ven != " " && ven == Vendor[i]) { fnd = true; LastTr=i; break}
     else if(vennm != "" && vennm != " " && VenName[i].indexOf(vennm) >= 0) { fnd = true; LastTr=i; break}
     document.all.trVen[i].style.color="black";
  }

  // if found set value and scroll div to the found record
  if(fnd)
  {
     var pos = document.all.trVen[LastTr].offsetTop;
     document.all.trVen[LastTr].style.color="red";
     dvInt.scrollTop=pos;
  }
  else { LastTr=-1; }
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
// find object postition
//==============================================================================
function objPosition(obj)
{
   var pos = new Array(2);
   pos[0] = 0;
   pos[1] = 0;
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
// retreive POs
//==============================================================================
function rtvPoNum()
{
    var ven = document.all.Ven.value
    var div = document.all.Div.value.trim();

    var url = "RtvPoList.jsp"
    var sep = "?";
    if(ven.trim() != "" && ven.trim() != "ALL")
    {
       url += sep + "Ven=" + ven;
       sep = "&";
    }

    if(div.trim() != "" && div.trim() != "ALL")
    {
       url += sep + "Div=" + div;
       sep = "&";
    }

    //window.location.href = url;
    window.frame1.location = url;
}
//==============================================================================
// popilate division selection
//==============================================================================
function showPoNum(PoNum, AntDlvDt, Ven, VenName, Div)
{
   var hdr = "Select P.O. Number";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePoNumPanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popSelPoNum(PoNum, AntDlvDt, Ven, VenName, Div)

   html += "</td></tr></table>"


   document.all.dvPoNum.innerHTML = html;
   var dvWidth = document.all.thHdr1.offsetWidth + document.all.thHdr2.offsetWidth
               + document.all.thHdr3.offsetWidth + document.all.thHdr4.offsetWidth
               + document.all.thHdr1.offsetWidth
   document.all.dvInt1.style.width=400;
   document.all.dvPoNum.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvPoNum.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvPoNum.style.visibility = "visible";
}

//==============================================================================
// populate Seletion of P.O. Number
//==============================================================================
function popSelPoNum(PoNum, AntDlvDt, Ven, VenName, Div)
{
   // filter input
   var panel = "<table cellPadding=0 cellSpacing=0 style='background:#e9e9e9; border:2px outset; width=100%; font-size:10px;'>"
       + "<tr>"
       + "<td>P.O.&nbsp;<td><input name='spoPoNum' class='Small' size=10 maxlength=10> &nbsp; "
       + "<td><button class='Small' onClick='searchPoNum()'>Find</button>"

       + "<tr><td colspan=3 style='border-bottom:#e9e9e9 ridge 2px;font-size:3px;'>&nbsp;</td>"
       + "<tr><td colspan=3 style='font-size:3px;'>&nbsp;</td>"

       + "<tr><td>Vendor&nbsp;<td><input name='spoVen' class='Small' size=5 maxlength=5>"
       + "<td rowspan=2><button class='Small' onClick='rtvPoNumWithFilter()'>Filter</button>"
       + "<tr><td>Div&nbsp;<td><input name='spoDiv' class='Small' size=5 maxlength=5>"
       + "</table>"

   panel += "<br><div id='dvInt1' class='dvInternal'>"
         + "<table border=1 cellPadding=0 cellSpacing=0 style='font-size:10px;'>"

   panel += "<thead><tr class='TblHdr' >"
         + "<th id='thHdr1'>P.O.<br>Num</th>"
         + "<th id='thHdr2'>Anticip<br>Delivery<br>Date</th>"
         + "<th id='thHdr3'>Vendor</th>"
         + "<th id='thHdr4'>Vendor Name</th>"
         + "<th id='thHdr5'>Div</th>"
   panel += "</thead>"

   panel += "<tbody>"

   for(var i=0; i < PoNum.length; i++)
   {
     panel += "<tr class='TblRow' id='trPon'><td id='tdCol1' style='cursor:hand;' onclick='javascript: showPonSelect(&#34;" + PoNum[i] + "&#34;)'>" + PoNum[i] + "</td>"
        + "<td id='tdCol2'>&nbsp;&nbsp;" + AntDlvDt[i] + "&nbsp;&nbsp;</td>"
        + "<td id='tdCol3'>" + Ven[i] + "</td>"
        + "<td id='tdCol4' style='text-align:left' nowrap>" + VenName[i] + "</td>"
        + "<td id='tdCol5'>" + Div[i] + "</td>"
        + "</tr>"
   }

   panel += "</tbody></table></div>"
        + "<div align=center><button class='Small' onclick='hidePoNumPanel();'>Close</button></div>"

   return panel;
}
//==============================================================================
// search Po Number in list
//==============================================================================
function searchPoNum()
{
   var pon = document.all.spoPoNum.value.trim();
   var tdpon = document.all.tdCol1;
   var selind = 0;
   var fnd = false;

   for(var i=0; i < tdpon.length; i++)
   {
      if(tdpon[i].innerHTML.indexOf(pon) >= 0)  { selind = i;  tdpon[i].style.color="red"; fnd=true;}
      else { tdpon[i].style.color="black"; }
   }

   if(fnd)
   {
      var pos = document.all.tdCol1[selind].offsetTop;
      dvInt1.scrollTop=pos-70;
   }
}
//==============================================================================
// retreive  PO Number with filter
//==============================================================================
function rtvPoNumWithFilter()
{
    var ven = document.all.spoVen.value.trim()
    var div = document.all.spoDiv.value.trim();

    var url = "RtvPoList.jsp"
    var sep = "?";
    if(ven != "" && ven != "ALL")
    {
       url += sep + "Ven=" + ven;
       sep = "&";
    }

    if(div != "" && div != "ALL")
    {
       url += sep + "Div=" + div;
       sep = "&";
    }

    //alert(url)
    //window.location.href = url;
    window.frame1.location = url;
}
//==============================================================================
// show PO Number selected
//==============================================================================
function showPonSelect(pon)
{
   document.all.PON.value = pon;
   document.all.Parent.value = "";
}
//==============================================================================
// hide panel
//==============================================================================
function hidePoNumPanel(){document.all.dvPoNum.style.visibility = "hidden";}


//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";

  var div = document.all.Div.value.trim();
  var dpt = document.all.Dpt.value.trim();
  var ven = document.all.Ven.value.trim();

  // store
  var selstr = new Array();
  var str = document.all.Str;
  selstr = new Array();
  var numstr = 0
  for(var i=0; i < str.length; i++)
  {
     if(str[i].checked){ selstr[numstr] = str[i].value; numstr++; }
  }
  if (numstr == 0){ error=true; msg+="At least 1 store must be selected.";}

  var season = 0;
  var ready = 0;
  var approved = 0;
  var cls = "ALL";
  var site = null;
  for(var i=0; i < document.all.Site.length; i++)
  {
     if (document.all.Site[i].checked) { site = document.all.Site[i].value; }
  }

  for(var i=0; i < document.all.Season.length; i++)
  {
    if(document.all.Season[i].checked) { season = document.all.Season[i].value; break; }
  }


  var parent = document.all.Parent.value.trim();
  if(isNaN(parent)){ msg += "Parent must be numeric\n"; error=true; }
  else if(eval(parent) > 0 && parent.length < 9){ msg +=  " Parent must contains at least 9 digits.\n"; error=true; }

  var pon = document.all.PON.value.trim();
  if(isNaN(pon)){ msg += "P.O. number must be numeric\n"; error=true; }

  if (season != 0) {div="ALL"; dpt="ALL"; }

  var level = null;
  for(var i=0; i < document.all.Level.length; i++)
  {
     if (document.all.Level[i].checked) { level = document.all.Level[i].value; }
  }

  var marked = "1";
  var mrkobj = document.all.MarkedWeb;
  for(var i=0; i < mrkobj.length;i++)
  {
    if(document.all.MarkedWeb[i].checked){ marked=document.all.MarkedWeb[i].value; break;}
  }

  var action;

  if (error) alert(msg);
  else{ sbmPlan(div, dpt, cls, ven, season, pon, parent, site, level, selstr, marked) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(div, dpt, cls, ven, season, pon, parent, site, level, selstr, marked)
{
  if(parent.trim() != ""){ div = "ALL"; dpt="ALL"; cls="ALL"; ven="ALL"; }
  if(pon.trim() != ""){ div = "ALL"; dpt="ALL"; cls="ALL"; ven="ALL"; parent=""; }

  var url = null;
  url = "EComProdSts.jsp?"

  url += "Div=" + div
      + "&Dpt=" + dpt
      + "&Cls=" + cls
      + "&Ven=" + ven
      + "&Season=" + season
      + "&Site=" + site
      + "&Pon=" + pon
      + "&Parent=" + parent
      + "&Level=" + level
      + "&Web=" + marked

  for(var i=0; i < selstr.length; i++)
  {
     url += "&Str=" + selstr[i]
  }

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// reset selection if season has been selected
//==============================================================================
function resetSeason()
{
   document.all.DivName.value = document.all.selDiv.options[0].text
   document.all.Div.value = document.all.selDiv.options[0].value
   document.all.DivArg.value = 0
   showDptSelect(0);
}
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<div id="dvPoNum" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>E-Commerce Production Status Report - Selection</B>
        <br><a href="../" class="small"><font color="red">Home</font></a>

      <TABLE>
        <TBODY>
        <!-- ------------- Division  --------------------------------- -->
        <TR>
          <TD class="Cell" >Division:</TD>
          <TD class="Cell1" >
             <input class="Small" name="DivName" size=50 readonly>
             <input class="Small" name="Div" type="hidden">
             <input class="Small" name="DivArg" type="hidden" value=0><br>
             <SELECT name="selDiv" class="Small" onchange="doDivSelect(this.selectedIndex);" size=5>
                <OPTION value="ALL">All Divisions</OPTION>
             </SELECT><br>
              <input class="Small" name="Season" type="radio" value="0" checked>All &nbsp;&nbsp;
              <input class="Small" name="Season" type="radio" value="1" onclick="resetSeason()">Winter &nbsp;&nbsp;&nbsp;&nbsp;
              <input class="Small" name="Season" type="radio" value="2" onclick="resetSeason()">Running/Footwear &nbsp;&nbsp;&nbsp;&nbsp;
          <br><input class="Small" name="Season" type="radio" value="3" onclick="resetSeason()">Summer &nbsp;&nbsp;&nbsp;&nbsp;
              <input class="Small" name="Season" type="radio" value="4" onclick="resetSeason()">Cycling &nbsp;&nbsp;&nbsp;&nbsp;
              <input class="Small" name="Season" type="radio" value="5" onclick="resetSeason()">Outdoor &nbsp;&nbsp;&nbsp;&nbsp;
              <input class="Small" name="Season" type="radio" value="6" onclick="resetSeason()">Other &nbsp;&nbsp;&nbsp;&nbsp;

          <br><input class="Small" name="MarkedWeb" type="radio" value="1" checked>Marked for Web&nbsp;&nbsp;&nbsp;&nbsp;
              <input class="Small" name="MarkedWeb" type="radio" value="2">Not Marked for Web &nbsp;&nbsp;&nbsp;&nbsp;
              <input class="Small" name="MarkedWeb" type="radio" value="3">Both &nbsp;&nbsp;&nbsp;&nbsp;
          </TD>
        <!-- ======================= Department ============================ -->
          <TD class="Cell">Department:</TD>
          <TD class="Cell1">
             <input class="Small" name="DptName" size=50 value="All Departments" readonly>
             <input class="Small" name="Dpt" type="hidden" value="ALL"><br>
             <SELECT class="Small" name=selDpt onchange="showDptSelect(this.selectedIndex);"  size=5>
                <OPTION value="ALL">All Departments</OPTION>
             </SELECT>
          </TD>
        </TR>
        <TR>
            <TD class="Cell" >&nbsp;</TD>
         </TR>
        <!-- ========================== Vendor ============================== -->
        <TR>
            <TD class="Cell" >Vendor:</TD>
            <TD class="Cell1" nowrap>
              <input class="Small" name="VenName" size=50 value="All Vendors" readonly>
              <input class="Small" name="Ven" type="hidden" value="ALL">
              <button class="Small" name=GetVen onClick="rtvVendors()">Select Vendors</button><br>
            </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <tr>
            <TD class="Cell1" colspan=5>Report Level: &nbsp;
               <input class="Small" name="Level" type="radio" value="S" checked>Parent &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <input class="Small" name="Level" type="radio" value="I">Child &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </tr>

        <!-- ============== Multiple Store selection ======================= -->
        <tr id="trMult">
         <td colspan="5" class="Small" nowrap>

         <%for(int i=0; i < iNumOfStr; i++){%>
                  <input class="Small" name="Str" type="checkbox" value="<%=sStr[i]%>" checked><%=sStr[i]%>&nbsp;
                  <%if(i > 0 && i % 14 == 0){%><br><%}%>
              <%}%>
              <%if(iNumOfStr > 1) {%>
              <br><button class="Small" onClick="setAll(true)">All Store</button> &nbsp;

              <!--button onclick='checkReg(&#34;1&#34;)' class='Small'>Dist 1</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;2&#34;)' class='Small'>Dist 2</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;3&#34;)' class='Small'>Dist 3</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;99&#34;)' class='Small'>Dist 99</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;PATIO&#34;)' class='Small'>Patio</button> &nbsp; &nbsp;
              <br>
              <button onclick='checkDist(&#34;9&#34;)' class='Small'>Houston</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;20&#34;)' class='Small'>Dallas/FtW</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;35&#34;)' class='Small'>Ski Chalet</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;38&#34;)' class='Small'>Boston</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;41&#34;)' class='Small'>OKC</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;52&#34;)' class='Small'>Charl</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;53&#34;)' class='Small'>Nash</button> &nbsp; &nbsp;
              <br>
              <button onclick='checkMall(&#34;&#34;)' class='Small'>Mall</button> &nbsp; &nbsp;
              <button onclick='checkMall(&#34;NOT&#34;)' class='Small'>Non-Mall</button --> &nbsp; &nbsp;

              <button class="Small" onClick="setAll(false)">Reset</button><br><br>
              <%}%>

         </td>
        </tr>


        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <tr>
            <TD class="Cell1" colspan=5>Site:&nbsp;
              <input class="Small" name="Site" type="radio" value="SASS" checked>Sun and Ski Sports &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <span style="display:none;">
              <input class="Small" name="Site" type="radio" value="SKCH">Ski Chalet &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <input class="Small" name="Site" type="radio" value="SSTP">Ski Stop &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <input class="Small" name="Site" type="radio" value="REBEL">Railhead
              <input class="Small" name="Site" type="radio" value="JOJO">Joe Johnes
              </span>

            </td>
        </tr>
        <!-- =============================================================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" ></TD></TR>
        <TR>
            <TD class="Cell2" colspan=3>Alternative Selection:</TD>
        </tr>
        <tr>
            <TD class="Cell1" colspan=2>Parent: &nbsp;<input class="Small" name="Parent" size=13 maxlength=13></TD>
            <TD class="Cell1" colspan=2>P.O. number: &nbsp;<input class="Small" name="PON" size=10 maxlength=10>
                &nbsp;<button class="Small" name=GetPONum onClick="rtvPoNum()">Select P.O.</button></TD>
        </tr>
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <!-- =============================================================== -->
        <TR>
            <TD align=center colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate()">
           </TD>
          </TR>
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>