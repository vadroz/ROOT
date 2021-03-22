<%@ page import="java.util.*, advertising.AdMediaList"%>
<%

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("ADVERTISES")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=" + request.getRequestURI() + "&APPL=ADVERTISES");
   }
   else
   {

     AdMediaList adMedia = new AdMediaList();

     //get market list
     adMedia.setAllMarket();
     String sAllMktJsa = adMedia.getAllMktJsa();
     String sAllMktNameJsa = adMedia.getAllMktNameJsa();

     adMedia.setMediaList();

     int iNumOfMed = adMedia.getNumOfMed();
     String [] sGrp = adMedia.getGrp();
     String [] sGrpName = adMedia.getGrpName();
     String [] sMedia = adMedia.getMedia();
     String [] sMedName= adMedia.getMedName();

     adMedia.disconnect();
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}

  table.DataTable { border: darkred solid 1px; background:#FFE4C4; text-align:center;}
  tr.DataTable { background:#FFCC99; font-family:Verdanda; text-align:center; font-size:12px; font-weight:bold}
  th.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px;}
  tr.DataTable1 { color: red; background:cornsilk; font-family:Verdanda; font-size:12px; font-weight:bold}
  tr.DataTable2 { background:lightgrey; font-family:Arial; text-align:left; font-size:10px;}
  td.DataTable { border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; padding-top:3px; padding-bottom:3px;
                 padding-right:3px; padding-left:3px;}
  td.DataTable1 { border-top: darkred solid 1px; border-bottom: darkred solid 1px;
                 padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;
                 border-right: darkred solid 1px;}

  div.Media { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:400; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
  tr.Media  {background-color: blue; color:white; text-align:center; font-family:Arial;
                   font-size:12px; font-weight:bold}
  td.Media  {text-align:center; font-family:Arial; font-size:10px;
                   padding-top:3px; padding-bottom:3px;}
  td.Media1 {padding-right:3px; padding-left:3px; text-align:center; font-family:Arial; font-size:10px; }
  td.Media2 {padding-right:3px; padding-left:3px; text-align:left; font-family:Arial; font-size:10px; }
  td.Menu2  {border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }

  .small{ text-align:left; font-family:Arial; font-size:10px;}


</style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<SCRIPT language="JavaScript">
var Market = [<%=sAllMktJsa%>];
var MktName = [<%=sAllMktNameJsa%>];

var Error = null;
var SelMedType = null;
var SelMedTypeName = null;
var SelMedia = null;
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
   window.outerHeight = 800;
   window.outerWidth = 600;
   showError();
}
//==============================================================================
// Show entry errors
//==============================================================================
function showError()
{
   var msg = "";
   if(Error != null)
   {
      for(var i=0; i < Error.length;  i++)
      {
         msg += Error[i] + "\n";
      }
      alert(msg)
   }
}

//==============================================================================
// get Market Media arrays
//==============================================================================
function getMktMedia(med, medname)
{
   var url = 'AdMktMedList.jsp?'
    + "&Media=" + med;
   SelMedType = med;
   SelMedTypeName = medname;
   //alert(url);
   //window.location.href = url;
   window.frame1.location = url;
}
//==============================================================================
// popup Market Media arrays
//==============================================================================
function popMktMedia(mkt, mktname, media, dlyrate, frirate, satrate, sunrate)
{
  var MenuName = "";
  var MenuOpt = "";
  var prtype= null;
  var rows = 1

  if(SelMedType=="NP") rows = 2

  MenuName = "<td nowrap>Show Media by Market</td>";

  MenuOpt += "<tr><td colspan='2' nowrap align='center'>"
          + "<b><u>Selected Media Type: " + SelMedTypeName + "</u></b>"

  var hgt = 300;
  if(media.length * 33 + 30 < hgt) hgt = media.length * 35 + 30
  // internal srollable table
  MenuOpt += "<div style='height:" + hgt + "; overflow:auto;'>"
  MenuOpt += "<table class='DataTable' width='100%' cellPadding='0' cellSpacing='0'>"
  MenuOpt += "<tr class='DataTable'>"
             + "<th class='DataTable' rowspan=" + rows + ">Market</th>"
             + "<th class='DataTable' rowspan=" + rows + ">Media &nbsp; <a href='javascript:addMktMedia()'>Add</a></th>"

  if(SelMedType=="NP") MenuOpt += "<th class='DataTable' colspan='5'>Price</th>"

  MenuOpt += "<th class='DataTable' rowspan=" + rows + ">Dlt</th>"
           +  "</tr>"
    // show newspaper price
  if(SelMedType=="NP")
  {
      MenuOpt += "<tr class='DataTable'>"
                 + "<th class='DataTable'>Daily</th>" + "<th class='DataTable'>Firday</th>"
                 + "<th class='DataTable'>Saturday</th>" + "<th class='DataTable'>Sunday</th>"
                 + "<th class='DataTable'>Update</th>"
               + "</tr>"
  }


  MenuOpt += crtMktMediaTable(mkt, mktname, media, dlyrate, frirate, satrate, sunrate);
  MenuOpt += "</table></div>"

  MenuOpt += "</td></tr>"
  // add close option on menu
  MenuOpt += "<tr ><td colspan='2' align='center'>"
       + "<button class='small' onclick='hideMediaEntry();'>Close</button>"
       + "</td></tr>";

  var MenuHtml = "<table width='100%' cellPadding='0' cellSpacing='0'>"
  + "<tr class='Media'>"
     + MenuName
     + "<td class='Menu2' valign=top>"
     +  "<img src='CloseButton.bmp' onclick='javascript:hideMediaEntry();' alt='Close'>"
     + "</td>"
   + "</tr>"
   + MenuOpt
   + "</table>"

  document.all.dvMedia.innerHTML=MenuHtml
  document.all.dvMedia.style.pixelLeft= document.documentElement.scrollLeft + 15
  document.all.dvMedia.style.pixelTop=document.documentElement.scrollTop + screen.height - 700;
  document.all.dvMedia.style.visibility="visible"

  window.frame1.location = null;
}
//========================================================================
// load Group
//========================================================================
function crtMktMediaTable(mkt, mktname, media, dlyrate, frirate, satrate, sunrate)
{
  var MenuOpt = "";
  for(var i=0; i < media.length; i++) {
     MenuOpt += "<tr class='DataTable2'>"
                + "<td class='DataTable' nowrap >" + mktname[i] + "</td>"
                + "<td class='DataTable' nowrap >" + media[i].trim() + "</td>"
     // show newspaper price
     if(SelMedType=="NP")
     {
        MenuOpt += "<td class='DataTable'>" + dlyrate[i] + "</td>"
                 + "<td class='DataTable'>" + frirate[i] + "</td>"
                 + "<td class='DataTable'>" + satrate[i] + "</td>"
                 + "<td class='DataTable'>" + sunrate[i] + "</td>"
                 + "<td class='DataTable'><a href='javascript:chgRate(&#34;" + mkt[i]
                 + "&#34;, &#34;" + mktname[i] + "&#34;, &#34;" + SelMedType + "&#34;, &#34;" + media[i].trim()
                 + "&#34;," + dlyrate[i] + "," + frirate[i] + "," + satrate[i] + "," + sunrate[i] + ")'>Update</a></td>"
     }
     MenuOpt += "<td class='DataTable' nowrap ><a href='javascript:sbmMktMedia(&#34;" + mkt[i]  + "&#34;, &#34;" + SelMedType + "&#34;, &#34;" + media[i].trim() + "&#34;, null, null, null, null, &#34;DLT&#34;)'>Delete</a></td>"
              + "</tr>"
   }
   return MenuOpt;
}
//==============================================================================
// Add Media
//==============================================================================
function addMktMedia()
{
  var MenuName = "";
  var MenuOpt = "";
  var prtype= null;
  var cols = 1;
  if(SelMedType=="NP") cols=4;

  MenuName = "<td colspan='10' nowrap>Add New " + SelMedTypeName + "</td>";


  MenuOpt += "<tr>"
             + "<td class='Media2' colspan=" + cols + " nowrap >Market: <select name='Market' class='Small'></select></td>"
          +  "</tr>"
  MenuOpt += "<tr>"
             + "<td class='Media2' colspan=" + cols + " nowrap >Media: <input name='Media' class='Small' size=50 maxlength=50></td>"
          +  "</tr>"
  // add price for newspaper
  if(SelMedType=="NP")
  {
     MenuOpt += "<tr>"
                + "<td class='Media2' nowrap >Mon-Thur: "
                  + "<input name='DlyRate' class='Small' size=10 maxlength=10></td>"
                + "<td class='Media2' nowrap >Friday: "
                  + "<input name='FriRate' class='Small' size=10 maxlength=10></td>"
            +  "</tr>"
            +  "<tr>"
                + "<td class='Media2' nowrap >Saturday: "
                  + "<input name='SatRate' class='Small' size=10 maxlength=10></td>"
                + "<td class='Media2' nowrap >Sunday:   "
                  + "<input name='SunRate' class='Small' size=10 maxlength=10></td>"
            +  "</tr>"

  }
  // add close option on menu
  MenuOpt += "<tr><td colspan='10' class='Media' align='center'>"
       + "<button class='small' onclick='validateMktMedia(&#34;ADD&#34;);'>Save</button>&nbsp;&nbsp;&nbsp;"
       + "<button class='small' onclick='resetMktMedia();'>Reset</button>&nbsp;&nbsp;&nbsp;"
       + "<button class='small' onclick='hideMktMediaEntry();'>Close</button>"
       + "</td></tr>";

  var MenuHtml = "<table width='100%' cellPadding='0' cellSpacing='0'>"
  + "<tr class='Media'>"
     + MenuName
     + "<td class='Menu2' valign=top>"
     +  "<img src='CloseButton.bmp' onclick='javascript:hideMktMediaEntry();' alt='Close'>"
     + "</td>"
   + "</tr>"
   + MenuOpt
   + "</table>"

  document.all.dvMktMedia.innerHTML=MenuHtml
  document.all.dvMktMedia.style.pixelLeft= document.documentElement.scrollLeft + 500
  document.all.dvMktMedia.style.pixelTop=document.documentElement.scrollTop + screen.height - 700;
  document.all.dvMktMedia.style.visibility="visible"
  loadMarket();
}

//==============================================================================
// Change rate
//==============================================================================
function chgRate(mkt, mktname, medtype, media, dly, fri, sat, sun)
{
  var MenuName = "";
  var MenuOpt = "";
  var prtype= null;
  SelMedia = media;

  MenuName = "<td colspan='10' nowrap>Change Rate</td>";

  MenuOpt += "<tr>"
             + "<td class='Media2' colspan=4 nowrap >Market: " + mktname + "</td>"
          +  "</tr>"
  MenuOpt += "<tr>"
             + "<td class='Media2' colspan=4 nowrap >Media: " + media + "</td>"
          +  "</tr>"
          + "<tr>"
             + "<td class='Media2' nowrap >Mon-Thur: "
             + "<input name='DlyRate' class='Small' size=10 maxlength=10 value='" + dly + "'></td>"
             + "<td class='Media2' nowrap >Friday: "
             + "<input name='FriRate' class='Small' size=10 maxlength=10 value='" + fri + "'></td>"
          +  "</tr>"
          +  "<tr>"
             + "<td class='Media2' nowrap >Saturday: "
             + "<input name='SatRate' class='Small' size=10 maxlength=10 value='" + sat + "'></td>"
             + "<td class='Media2' nowrap >Sunday:   "
             + "<input name='SunRate' class='Small' size=10 maxlength=10 value='" + sun + "'></td>"
          +  "</tr>"

  // add close option on menu
  MenuOpt += "<tr><td colspan='10' class='Media' align='center'>"
       + "<button class='small' onclick='validateMktMedia(&#34;CHG&#34;);'>Save</button>&nbsp;&nbsp;&nbsp;"
       + "<button class='small' onclick='hideMktMediaEntry();'>Close</button>"
       + "</td></tr>";

  var MenuHtml = "<table width='100%' cellPadding='0' cellSpacing='0'>"
  + "<tr class='Media'>"
     + MenuName
     + "<td class='Menu2' valign=top>"
     +  "<img src='CloseButton.bmp' onclick='javascript:hideMktMediaEntry();' alt='Close'>"
     + "</td>"
   + "</tr>"
   + MenuOpt
   + "</table>"

  document.all.dvMktMedia.innerHTML=MenuHtml
  document.all.dvMktMedia.style.pixelLeft= document.documentElement.scrollLeft + 500
  document.all.dvMktMedia.style.pixelTop=document.documentElement.scrollTop + screen.height - 700;
  document.all.dvMktMedia.style.visibility="visible"
}

//========================================================================
// load market in dropdown menu
//========================================================================
function loadMarket()
{
   for(var i=0; i < Market.length; i++)
   {
      document.all.Market.options[i] = new Option(MktName[i], Market[i]);
   }
}
//========================================================================
// reset Promotion menu entry fields
//========================================================================
function resetMktMedia()
{
  document.all.Media.value = "";
  document.all.DlyRate.value = "";
  document.all.FriRate.value = "";
  document.all.SatRate.value = "";
  document.all.SunRate.value = "";
}
//========================================================================
// close dropdown menu
//========================================================================
function hideMediaEntry(){document.all.dvMedia.style.visibility="hidden"}
//========================================================================
// close dropdown menu
//========================================================================
function hideMktMediaEntry(){document.all.dvMktMedia.style.visibility="hidden"}
//========================================================================
// validate entry
//========================================================================
function validateMktMedia(action)
{
  var error = false;
  var msg = "";

  var mkt = null;
  var media = null;
  var dly = null;
  var fri = null;
  var sat = null;
  var sun = null;


  if(action == "ADD" )
  {
     mkt = document.all.Market.options[document.all.Market.selectedIndex].value
     media = document.all.Media.value.trim();

     if(document.all.Media.value.trim() =="")
     {
        error = true;
        msg += "Please, enter media name\n";
     }
  }
  else { media = SelMedia }

  // validate rate entry
  if(document.all.DlyRate != null)
  {
     dly = document.all.DlyRate.value.trim();
     fri = document.all.FriRate.value.trim();
     sat = document.all.SatRate.value.trim();
     sun = document.all.SunRate.value.trim();

     if(isNaN(dly)) { error = true; msg += "Mon-Thu Rate is not numeric.\n"; }
     if(isNaN(fri)) { error = true; msg += "Friday Rate is not numeric.\n"; }
     if(isNaN(sat)) { error = true; msg += "Saturday Rate is not numeric.\n"; }
     if(isNaN(sun)) { error = true; msg += "Sunday Rate is not numeric.\n"; }
  }

  if(error) { alert(msg); }
  else { sbmMktMedia(mkt, SelMedType, media, dly, fri, sat, sun, action); }
}
//========================================================================
// validate entry
//========================================================================
function sbmMktMedia(mkt, medtype, media, dly, fri, sat, sun, action)
{
   var url = 'AdMktMedEntry.jsp?'

   url += "Market=" + mkt
          + "&MedType=" + medtype
          + "&Media=" + media

   // get prices for newspaper
   if((action=="ADD" || action=="CHG") && dly != null )
   {
      url += "&DlyRate=" + dly + "&FriRate=" + fri + "&SatRate=" + sat + "&SunRate=" + sun
   }

   url += "&Action=" + action

   //alert(url);
   window.location.href = url;
}
//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, " "); }
    return s;
}
</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


</head>

<body  onload="bodyLoad();">

 <!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
<div id="dvMedia" class="Media"></div>
<div id="dvMktMedia" class="Media"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Advertising - Work With Medias</b><br>
        <a href="../"><font color="red" size="-1">Home</font></a>;
        <a href="javascript: window.close();"><font color="red" size="-1">Close</font></a>
        <!----------------- start of ad table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0">
           <thead style="overflow: visible;">
             <tr class="DataTable">
               <th class="DataTable" >Group</th>
               <th class="DataTable" nowrap>Media</th>
               <th class="DataTable" nowrap>Description</th>
             </tr>
           </thead>
           <tbody style="overflow: visible;">
             <!--------------------- Media Detail ----------------------------->
             <%for(int i=0; i < iNumOfMed; i++){%>
                 <tr class="DataTable2">
                   <td class="DataTable1"><%=sGrpName[i]%></td>
                   <td class="DataTable1"><%=sMedia[i]%></td>
                   <td class="DataTable1"><a href="javascript:getMktMedia('<%=sMedia[i]%>', '<%=sMedName[i]%>')"><%=sMedName[i]%></a></td>
                 </tr>
             <%}%>
           </tbody>
         </table>
         <!----------------- start of ad table ------------------------>
      </td>
     </tr>
    </table>
  </body>
</html>
<%}%>