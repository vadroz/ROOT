<%@ page import="java.util.*, vendorsupport.VendorClinics"%>
<%
    String sStore = request.getParameter("Store");
    String sStrName = request.getParameter("StrName");
    String sMonYr = request.getParameter("MonYr");

    String sStrHdrName = sStore;
    if (sStrName==null || sStrName.equals("")) { sStrName = "";}
    else {sStrHdrName += " - " + sStrName;}
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("VENDOR") == null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=VendorClinics.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
    boolean bSecure = !(session.getAttribute("BASIC")==null);

    String sMonth = sMonYr.substring(0, sMonYr.indexOf("/"));
    String sYear = sMonYr.substring(sMonYr.indexOf("/")+1);
    String sUser = session.getAttribute("USER").toString();

    VendorClinics vencal = new VendorClinics(sStore, sMonth, sYear, sUser);
    int iMinCal = vencal.getMinCal();
    int iMaxCal = vencal.getMaxCal();

    // user data
    String sUsrName = vencal.getUsrName();
    String sUsrAddr = vencal.getUsrAddr();
    String sUsrCity = vencal.getUsrCity();
    String sUsrState = vencal.getUsrState();
    String sUsrZip = vencal.getUsrZip();
    String sUsrPhone = vencal.getUsrPhone();
    String sUsrCell = vencal.getUsrCell();
    String sUsrEMail = vencal.getUsrEMail();

    String [] sMonArr = new String[]{"January","February","March","April","May","June", "July",
                       "August", "September", "October", "November", "December"};
    String sMonName = sMonArr[Integer.parseInt( sMonYr.substring(0, sMonYr.indexOf("/")).trim()) - 1];

    Calendar cal = Calendar.getInstance();
    int iYear = Integer.parseInt(sMonYr.substring(sMonYr.indexOf("/") + 1));
    int iMonth = Integer.parseInt(sMonYr.substring(0, sMonYr.indexOf("/")));

    // Prior month calculation
    String sPrevMonYr = null;
    String sNextMonYr = null;
    if(iMonth == 1){ sPrevMonYr = "12/" + Integer.toString(iYear - 1); }
    else { sPrevMonYr =  Integer.toString(iMonth - 1) + "/" + Integer.toString(iYear); }
    // next month calculation
    if(iMonth == 12){ sNextMonYr = "1/" + Integer.toString(iYear + 1); }
    else { sNextMonYr =  Integer.toString(iMonth + 1) + "/" + Integer.toString(iYear); }
%>

<html>
<head>

<style>
  body {background:white;}
  a:link { color:blue;  font-size:12px;} a:visited { color:blue; font-size:12px;}  a:hover { color:blue; font-size:12px;}
  a.link1:link { color:#8afb17;  font-size:10px;} a.link1:visited { color:#8afb17;  font-size:10px;} a.link1:hover { color:yellow;  font-size:10px;}

  table.DataTable { border: darkred solid 1px; background:#e7e7e7; text-align:center;}
  table.AvlTime { cursor:hand; border: darkred solid 1px; background:#e7e7e7; text-align:center;}
  tr.DataTable { background:#FFCC99; font-family:Verdanda; text-align:center;
                 font-size:12px; font-weight:bold}
  th.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px;}

  tr.DataTable1 { background:white; font-family:Verdanda; text-align:left;vertical-align:top;font-size:12px;}
  tr.DataTable2 { background:white; font-family:Verdanda; text-align:left;vertical-align:top;font-size:10px;}
  tr.DataTable3 { background:white; font-family:Verdanda; text-align:center;vertical-align:top;font-size:10px;}
  tr.UsrProfile { text-align:left; vertical-align:top; font-size:10px;}

  td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;text-align:left; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable1 { background:grey; border-right: darkred solid 1px; border-bottom: darkred solid 1px;text-align:left; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable2 { background:#c3fdb8; text-align:left; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable3 { background:#fdd017; text-align:left; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable11 { background:grey; border-right: darkred solid 1px; border-bottom: darkred solid 1px;text-align:left; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}
  td.DataTable4 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;text-align:center;}
  td.DataTable5 { text-align:left; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;}

  td.AvlTime { background:white; border-right: darkred solid 1px; border-bottom: darkred solid 1px; font-size: 5px;}
  td.AvlTime0{ background:#fdd017; border-right: darkred solid 1px; border-bottom: darkred solid 1px; font-size: 5px;}
  td.AvlTime1{ background:red; border-right: darkred solid 1px; border-bottom: darkred solid 1px; font-size: 5px;}

  th.TimeChart { background:white; border-right: darkred solid 1px; border-bottom: darkred solid 1px; font-size: 10px;}
  td.TimeChart { cursor:hand; background:white; border-right: darkred solid 1px; border-bottom: darkred solid 1px; font-size: 10px;}

  div.dvClinic { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:600; background-color:LemonChiffon; z-index:100;
              text-align:left; font-size:10px }

   div.dvUser { position:absolute; visibility:hidden; background-attachment: scroll;
              border:ridge; width:250; background-color:Azure; z-index:100;
              text-align:left; font-size:10px }


  .Small{ text-align:left; font-family:Arial; font-size:10px;}
  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
  td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
  td.Prompt { text-align:left; vertical-align: top; font-family:Arial; font-size:12px; }
  td.Prompt1 { text-align:center;font-family:Arial; font-size:12px; }
  td.Prompt2 { text-align:right; font-family:Arial; font-size:120px; }
  td.option { text-align:left; font-size:10px}

</style>

<SCRIPT language="JavaScript">
//==============================================================================
// Global variable
//==============================================================================
var Month = <%=sMonth%>;
var Year = <%=sYear%>;
var MonDates = new Array();
var NumDates = 0;
var Closed = new Array();
var ChkDates = false;
var Closed_dates_URL = null;
var Closed_dates_Available = false;

var UsrName = "<%=sUsrName%>";
var UsrAddr = "<%=sUsrAddr%>";
var UsrCity = "<%=sUsrCity%>";
var UsrState = "<%=sUsrState%>";
var UsrZip = "<%=sUsrZip%>";
var UsrPhone = "<%=sUsrPhone%>";
var UsrCell = "<%=sUsrCell%>";
var UsrEMail = "<%=sUsrEMail%>";
//==============================================================================
// Load initial value on page
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvClinic", "dvUser"]);
   <%if(!bSecure){%>showUserProfile()<%}%>
}
//==============================================================================
// show User Profile
//==============================================================================
function showUserProfile()
{
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>Hi, " + UsrName + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
          + "<a class='link1' href='VenRegistration.jsp?User=<%=sUser%>&Exist=Y' target='_blank'>Change</a>"
       + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hideUsrPrf();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popUsrPrfPanel()
     + "</td></tr>"
   + "</table>"

   document.all.dvUser.innerHTML = html;
   document.all.dvUser.style.pixelLeft= 1;
   document.all.dvUser.style.pixelTop= 1;
   document.all.dvUser.style.visibility = "visible";
}
//--------------------------------------------------------
// populate User Profile Panel
//--------------------------------------------------------
function popUsrPrfPanel()
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='UsrProfile'><td nowrap>" + UsrAddr + "</td></tr>"
  panel += "<tr class='UsrProfile'><td  nowrap >" + UsrCity + ", " + UsrState + " " + UsrZip + "</td></tr>"
  panel += "<tr class='UsrProfile'><td nowrap>Phone 1: " + UsrPhone + "</td></tr>"
  panel += "<tr class='UsrProfile'><td nowrap >Phone 2: " + UsrCell + "</td></tr>"
  panel += "<tr class='UsrProfile'><td nowrap >EMail: " + UsrEMail + "</td></tr>"
  panel += "</table>";
  return panel;
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hideUsrPrf()
{
   document.all.dvUser.innerHTML = " ";
   document.all.dvUser.style.visibility = "hidden";
}

//==============================================================================
// show Clinic
//==============================================================================
function chgAvailability(date, avlTime)
{
   var hdr = "Change Avalability on " + date;
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"
        + popAvailPanel(date)
     + "</td></tr>"
   + "</table>"

   document.all.dvClinic.innerHTML = html;
   document.all.dvClinic.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvClinic.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvClinic.style.visibility = "visible";

   var color = null;
   for(var i=0; i < 30; i++)
   {
      color = "white";
      if(avlTime[i]=="1" || avlTime[i]=="0") { color="red"}
      else { color="white"}
      document.all.cellAT[i].style.backgroundColor=color;
      //document.all.cellAT[i].innerHTML=avlTime[i];
   }
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popAvailPanel(date, ven)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"

  // Time
  panel += "<tr><td class='Prompt' nowrap>Available Time:</td>"
         + "<td class='Prompt'>"
             + "<table border=1 cellPadding='0' cellSpacing='0'>"

  var hrs = [8,9,10,11,12,1,2,3,4,5,6,7,8,9,10]

  // Hour line
  panel += "<tr>"
  for(var i=0; i < 15; i++){ panel += "<th class='TimeChart' colspan=2>" + hrs[i] + "</th>"  }
  panel += "</tr>"
  // Minute line
  panel += "<tr>"
  for(var i=0, bEven=false, min="00" ; i < 30; i++, bEven=!bEven){ panel += "<th class='TimeChart' >" + min +"</th>"; if(!bEven){ min=30 } else { min="00" }}
  panel += "</tr>"

  // mark time
  panel += "<tr>"
  for(var i=0; i < 30; i++)
  {
    panel += "<td id='cellAT' onClick='markAvlTime(this)' class='TimeChart' >&nbsp;</td>";
  }
  panel += "</tr>"

  panel += "</table><br><br>"
           + "</td>"
           + "</tr>"

  // buttons
  panel += "<tr><td class='Prompt1' colspan='2'>"
        + "<button onClick='ValidateAvail(&#34;" + date + "&#34;, &#34;CHGAVL&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;&nbsp;&nbsp;"
        + "<button onClick='ValidateAvail(&#34;" + date + "&#34;, &#34;BLOCKAVL&#34;)' class='Small'>Block Date</button>&nbsp;"
  panel += "</td></tr></table>";

  return panel;
}
//--------------------------------------------------------
// mark cell for clinic time
//--------------------------------------------------------
function markAvlTime(cell)
{
   if(cell.style.backgroundColor=="red") { cell.style.backgroundColor = "white"; }
   else { cell.style.backgroundColor = "red"; }
}
//==============================================================================
// show Clinic
//==============================================================================
function showClinic(date, avlTime, clnTime, ven, vennm, location, apprv, exist, available, disponly, phn, cell, email)
{
   if(ven==null) { ven = "<%=sUser%>"}
   retriveComment(date, ven, available, disponly);

   var hdr = "New Clinic. " + date;
   if(exist){ hdr = "Clinic. " + ven + " - " + vennm + ", " + date; }

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>"

    if(available && !disponly) { html += popClinicPanel(date, ven, exist, phn, cell, email) }
    else { html += popClinicPanel_DispOnly(date, avlTime, clnTime, ven, vennm, location, apprv, phn, cell, email) }

    html += "</td></tr>"
   + "</table>"

   document.all.dvClinic.innerHTML = html;
   document.all.dvClinic.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvClinic.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvClinic.style.visibility = "visible";

   if(available && !disponly)
   {
     document.all.Location.options[0] = new Option("Store", "STORE");
     if(location=="STORE") { document.all.Location.options[0].selected=true}
     //document.all.Location.options[1] = new Option("Corporate Office", "CORPOFFICE");
     //if(location=="CORPOFFICE") { document.all.Location.options[1].selected=true}
     document.all.Location.options[2] = new Option("Other", "OTHER");
     if(location=="OTHER") { document.all.Location.options[2].selected=true}


     var color = null;
     for(var i=0; i < 30; i++)
     {
        color = "white";
        if(avlTime[i]=="1") { color="red"}
        else if(clnTime != null && clnTime[i]=="1") { color="#fdd017"}
        document.all.cellTc[i].style.backgroundColor=color;
     }
     <%if(bSecure){%>
       if(exist && apprv=="Y") {  document.all.Approve.checked = true; }
       if(exist)
       {
          document.all.Location.disabled = true;
          document.all.Brand.disabled = true;
       }
     <%}%>
   }
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popClinicPanel(date, ven, exist, phn, cell, email)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"

  // Location
  panel += "<tr><td class='Prompt' nowrap >Location:&nbsp;</td>"
           + "<td class='Prompt'>"
              + "<select name=Location class='Small'></select><br><br>"
           + "</td>"
           + "</tr>"

  // Time
  panel += "<tr><td class='Prompt' nowrap>Mark Time:</td>"
         + "<td class='Prompt'>"
             + "<table border=1 cellPadding='0' cellSpacing='0'>"

  var hrs = [8,9,10,11,12,1,2,3,4,5,6,7,8,9,10]

  // Hour line
  panel += "<tr>"
  for(var i=0; i < 15; i++){ panel += "<th class='TimeChart' colspan=2>" + hrs[i] + "</th>"  }
  panel += "</tr>"
  // Minute line
  panel += "<tr>"
  for(var i=0, bEven=false, min="00" ; i < 30; i++, bEven=!bEven){ panel += "<th class='TimeChart' >" + min +"</th>"; if(!bEven){ min=30 } else { min="00" }}
  panel += "</tr>"

  // mark time
  panel += "<tr>"
  for(var i=0; i < 30; i++)
  {
    panel += "<td id='cellTc' <%if(!bSecure){%>onClick='markTime(this)'<%}%> class='TimeChart' >&nbsp;</td>";
  }
  panel += "</tr>"

  // marked time slots
  panel += "<tr>"
           + "<td class='TimeChart' colspan=10>Selected:</td>"
           + "<td id='cellMarked' class='TimeChart' colspan='20'>&nbsp;</td>"
         + "</tr>"

  panel += "</table><br><br>"
           + "</td>"
           + "</tr>"


  // Brand
  panel += "<tr><td class='Prompt'>Brand:</td>"
           + "<td class='Prompt'>"
           + "<select name='Brand' class='Small' multiple=true></select><br><br>"
          + "</td>"
         + "</tr>"

  // Comment
  panel += "<tr><td class='Prompt'>Comment (such as SWAG, discount specials,<br> or details of the clinic):</td>"
           + "<td class='Prompt'>"
           + "<textArea name='Comment' class='Small' rows=5 cols=100></textArea>"
          + "</td>"
         + "</tr>"

  // buttons
  var action = "ADDCLN";
  if (exist) { action = "UPDCLN"; }

  panel += "<tr><td class='Prompt1' colspan='2'>"
        + "<button onClick='ValidateClinic(&#34;" + date + "&#34;, &#34;" + ven + "&#34;, &#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"
  <%if(bSecure){%>
     if(exist) {  panel += "<input type='checkbox' id='Approve' onClick='ValidateClinic(&#34;" + date + "&#34;, &#34;" + ven + "&#34;, &#34;APPROVE&#34;);' class='Small'>Approve &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" }
  <%}%>
  panel += "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;&nbsp;&nbsp;"

  // delete and approve button exist only for store manager
  <%if(bSecure){%>
  if(exist)
  {
    panel += "<button onClick='ValidateClinic(&#34;" + date + "&#34;, &#34;" + ven + "&#34;, &#34;DLTCLN&#34;);' class='Small'>Delete</button>"
  }
  <%}%>

  panel += "</td></tr></table>";

  return panel;
}

//--------------------------------------------------------
// populate Entry Panel - display only for unavailable days
//--------------------------------------------------------
function popClinicPanel_DispOnly(date, avlTime, clnTime, ven, vennm, location, apprv, phn, cell, email)
{
  var dummy = "<table>"
  var panel = "<table class='Datatable' width='100%' cellPadding='0' cellSpacing='0'>"

  // Location
  panel += "<tr class='Datatable2'><td class='Datatable' nowrap >Location:&nbsp;</td>"
           + "<td class='Datatable' >" + location + "</td>"
           + "</tr>"

  // Marked Time
  panel += "<tr class='Datatable2'><td class='Datatable' nowrap >Time:&nbsp;</td>"
           + "<td class='Datatable' >"
  var coma = "";
  var hrs = "", min = ""; hrmn = "";
  for(var i=0, j=0, h=true; i < 30; i++, h = !h)
  {
      if(h && i <= 10) { hrs = (8 + j); min = "00am";}
      else if(h && i > 10) { hrs = (8 + j - 12); min = "00pm";}
      else if(i <= 10) { min = "30am";}
      else if(i > 10) { min = "30pm";}
      if(h){ j++; }
      hrmn = hrs + ":" + min;

      if(clnTime != null && clnTime[i]=="1") { panel += coma + hrmn; coma = ", "; }
  }
  panel += "</td></tr>"

  // Brand
  panel += "<tr class='Datatable2'><td class='Datatable' nowrap >Brand:&nbsp;</td>"
           + "<td class='Datatable' ><span id='spBrand'>&nbsp;</span></td>"
           + "</tr>"

  // Comment
  panel += "<tr class='Datatable2'><td class='Datatable' nowrap >"
         + "Comment (such as SWAG, discount specials,<br> or details of the clinic):&nbsp;</td>"
         + "<td class='Datatable'><span id='spComment'>&nbsp;</span></td>"
         + "</tr>"

  // Vendor contact information
  panel += "<tr class='Datatable2'>"
           + "<td class='Datatable' nowrap colspan=2 >"
           + "<b>Contact Information</b><br>"
           + "Pnone: " + phn + " &nbsp;  &nbsp; &nbsp;"
           + "Cell: " + cell + " &nbsp;  &nbsp; &nbsp;"
           + "E-Mail: " + email
           + "</td>"
         + "</tr>"

  // buttons
  panel += "<tr class='Datatable3' ><td colspan=2><button onClick='hidePanel();' class='Small'>Close</button>&nbsp;&nbsp;&nbsp;"
  panel += "</td></tr></table>";
  return panel;
}


//--------------------------------------------------------
// mark cell for clinic time
//--------------------------------------------------------
function markTime(cell)
{
   if(cell.style.backgroundColor=="red") { cell.style.backgroundColor = "#fdd017"; }
   else if(cell.style.backgroundColor=="#fdd017") { cell.style.backgroundColor = "red"; }

   var html = "";
   var coma = "";
   var hrs = "", min = ""; hrmn = "";

   for(var i=0, j=0, h=true; i < 30; i++, h = !h)
   {
      if(h && i <= 10) { hrs = (8 + j); min = "00am";}
      else if(h && i > 10) { hrs = (8 + j - 12); min = "00pm";}
      else if(i <= 10) { min = "30am";}
      else if(i > 10) { min = "30pm";}
      hrmn = hrs + ":" + min;
      if(h){ j++; }

      if(document.all.cellTc[i].style.backgroundColor=="#fdd017")
      {
          html += coma + hrmn; coma = ", ";
      }
   }
   document.all.cellMarked.innerHTML = html;
}
//--------------------------------------------------------
// submit clinick for add update or delete
//--------------------------------------------------------
function ValidateAvail(date, action)
{
  var error = false;
  var msg = "";

  var avltime = "";

  // get available time
  for(var i=0; i < 30; i++)
  {
     if(document.all.cellAT[i].style.backgroundColor=="red") { avltime +='1'}
     else{ avltime +='0'; }
  }

  if (error) alert(msg);
  else{ sbmAvail(date, avltime, action) }

  return error == false;
}
//--------------------------------------------------------
// submit clinick for add update or delete
//--------------------------------------------------------
function sbmAvail(date, avltime, action)
{
  var url = "VendClnSave.jsp?Store=<%=sStore%>"
        + "&Date=" + date
        + "&AvlTime=" + avltime
        + "&Action=" + action
        + "&User=<%=sUser%>"

   //alert(url)
   //window.location.href = url;
   window.frame1.location.href = url;
}
//--------------------------------------------------------
// submit clinick for add update or delete
//--------------------------------------------------------
function ValidateClinic(date, ven, action)
{
  var error = false;
  var msg = "";

  var loc = document.all.Location.options[document.all.Location.selectedIndex].value;
  var clntime = "";

  // get clinic time
  for(var i=0; i < 30; i++)
  {
     if(document.all.cellTc[i].style.backgroundColor=="#fdd017") { clntime +='1'}
     else{ clntime +='0'; }
  }

  var brandcell = document.all.Brand;
  var brand = new Array();
  // get clinic time
  for(var i=0, j=0; i < brandcell.length; i++)
  {
     if(brandcell.options[i].selected) { brand[j] = brandcell.options[i].value; j++ }
  }

  if(action != "DLTCLN" && brand.length==0){error=true; msg += "Please, select at least one brand.\n";}

  var comment = document.all.Comment.value.trim(" ");
  if(action != "DLTCLN" && comment.length > 500){error=true; msg += "Comments are too big.\n";}

  if (error) alert(msg);
  else{ sbmClinic(date, ven, loc, clntime, brand, comment, action) }

  return error == false;
}
//--------------------------------------------------------
// submit clinick for add update or delete
//--------------------------------------------------------
function sbmClinic(date, ven, loc, clntime, brand, comment, action)
{
  var url = "VendClnSave.jsp?Store=<%=sStore%>"
        + "&Date=" + date
        + "&Ven=" + ven
        + "&Loc=" + loc
        + "&ClnTime=" + clntime
   for(var i=0; i < brand.length; i++) { url += "&Brand=" + brand[i]; }
   url += "&Comment=" + comment
        + "&Action=" + action
        + "&User=<%=sUser%>"

   //alert(url)
   //window.location.href = url;
   window.frame1.location.href = url;
}
//--------------------------------------------------------
// show error or restart
//--------------------------------------------------------
function showSaveResults(num, error)
{
    msg = "";
    if(num > 0)
    {
       for(var i=0; i < num; i++) {  msg += error[i] + "\n" }
       hidePanel();
       alert(msg)
    }
    else { document.location.reload(); }
}
//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvClinic.innerHTML = " ";
   document.all.dvClinic.style.visibility = "hidden";
}
//==============================================================================
// retreive Comment
//==============================================================================
function retriveComment(date, ven, available, disponly)
{
   var url = "VendClnComment.jsp?Store=<%=sStore%>"
           + "&Vendor=" + ven
           + "&Date=" + date
           + "&Available=" + available
           + "&Disponly=" + disponly
   //alert(url)
   //window.location.href = url;
   window.frame1.location.href = url;
}
//==============================================================================
// retreive Comment
//==============================================================================
function popComment(comment, brand, brandSel, available, disponly)
{
   if(available && !disponly)
   {
     if(document.all.Comment != null){ document.all.Comment.value=comment; }
     for(var i=0; i < brand.length; i++)
     {
        if(document.all.Brand == null) { break; }
        document.all.Brand.options[i] = new Option(brand[i], brand[i]);
        if (brandSel[i]=="1"){ document.all.Brand.options[i].selected = true; }
     }
   }
   else
   {
     if(document.all.spComment != null)
     {
        document.all.spComment.innerHTML=comment;
        var brandlist = "", coma = "";
        for(var i=0; i < brand.length; i++)
        {
           if (brandSel[i]=="1"){ brandlist += coma + brand[i]; coma = ", ";}
        }
        if(document.all.spBrand != null) { document.all.spBrand.innerHTML = brandlist; }
     }
   }

   window.frame1.close();
}
</SCRIPT>

<script LANGUAGE="JavaScript" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript" src="String_Trim_function.js"></script>
</head>

<body  onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvClinic" class="dvClinic"></div>
<!-------------------------------------------------------------------->
<div id="dvUser" class="dvUser"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Vendor Clinic Schedule
       <br>Store: <%=sStrHdrName%>

       <!------------------- Month Navigation  -------------------------------->
       <br><a href="VendorClinics.jsp?Store=<%=sStore%>&StrName=<%=sStrName%>&MonYr=<%=sPrevMonYr%>">
                   <IMG SRC="arrowLeft.gif" style="border=none" ALT="Previous Month"></a>
        <%=sMonName + " " + sYear%>
        <a href="VendorClinics.jsp?Store=<%=sStore%>&StrName=<%=sStrName%>&MonYr=<%=sNextMonYr%>">
                   <IMG SRC="arrowRight.gif" style="border=none" ALT="Next Month"></a>

       <br>
       </b>
       <a href="../"><font color="red" size="-1">Home</font></a>  &#62;
       <a href="VendorClinicsSel.jsp"><font color="red" size="-1">Selection</font></a> &#62;
       <font size="-1">This page</font>

      <!----------------- start of ad table ------------------------>
      <table class="DataTable" cellPadding="0" cellSpacing="0" id="tblQuest">
           <thead style="overflow: visible;">
             <tr class="DataTable">
               <th class="DataTable">Sunday</th>
               <th class="DataTable">Monday</th>
               <th class="DataTable">Tuesday</th>
               <th class="DataTable">Wednesday</th>
               <th class="DataTable">Thursday</th>
               <th class="DataTable">Friday</th>
               <th class="DataTable">Saturday</th>
             </tr>
           </thead>
        <!--------------------- Group List ----------------------------->
         <tbody>
           <%for(int i=0, j=0; i < 35; i++){%>
               <%
                  vencal.setCalDate();
                  String sDate = vencal.getDate();
                  String sWkDay = vencal.getWkDay();
                  String sDay = vencal.getDay();
                  String [] sAvlTime = vencal.getAvlTime();
                  String sAvlTimeJsp = vencal.getAvlTimeJsp();
                  String sAvl = vencal.getAvl();

                  int iNumOfCln = vencal.getNumOfCln();
                  String [] sVen = vencal.getVen();
                  String [] sVenName = vencal.getVenName();
                  String [] sClnTime = vencal.getClnTime();
                  String [] sLocation = vencal.getLocation();
                  String [] sApprv = vencal.getApprv();
                  String [] sBrands = vencal.getBrands();
                  boolean [] bDispOnly = vencal.getDispOnly();
                  String [] sVenPhn = vencal.getVenPhn();
                  String [] sVenCell = vencal.getVenCell();
                  String [] sVenEMail = vencal.getVenEMail();

                  boolean bAvl = false;
                  if(sAvl.trim().equals("Y")){bAvl = true;}
               %>
               <%if(j==0) {%><tr class="DataTable1"><%}%>
                 <!--------------------- Unavailable day ----------------------------->
                 <%if(sDay.equals("")){%>
                      <td class="DataTable1">&nbsp;</td>
                 <%}
                   else {%>
                      <!--------------------- Available day ----------------------------->
                      <td class="DataTable">
                       <table border=0 cellPadding="0" width="100%" cellSpacing="0" id="tblDate">
                          <!--------------------- Day of Month ----------------------------->
                          <%if(sAvl.trim().equals("Y")){%>
                             <tr class="DataTable1">
                                 <td class="DataTable2"><%if(bSecure) {%><a href="javascript: chgAvailability('<%=sDate%>', [<%=sAvlTimeJsp%>])"><b><%=sDay%></b></a><%}
                                  else {%><%=sDay%><%}%></td></tr>
                          <%}
                          else {%><tr class="DataTable1"><td class="DataTable5"><b><%=sDay%></b></td></tr>
                          <%}%>
                          <!--------------------- Available time chart ----------------------------->
                          <%if(sAvl.trim().equals("Y")){%>
                             <tr class="DataTable1"><td class="DataTable2">
                                <table class="<%if(bSecure){%>AvlTime<%} else {%>DataTable<%}%>" cellPadding="0" cellSpacing="0" id="tblAvlTime" <%if(bSecure){%>onclick="chgAvailability('<%=sDate%>', [<%=sAvlTimeJsp%>])"<%}%>>
                                  <tr class="DataTable2">
                                    <td class="DataTable4">8am</td>
                                     <%for(int l=0; l < 30; l++){%><td class="AvlTime<%=sAvlTime[l].trim()%>">&nbsp;&nbsp;</td><%}%>
                                    <td  class="DataTable4">10pm</td>
                                  </tr>
                               </table>
                              </td>
                            </tr>
                          <%}%>
                          <!--------------------- Marked Cliniks ----------------------------->
                            <tr class="DataTable"><td class="DataTable3">
                              <%if(!bSecure && sAvl.trim().equals("Y")){%><a href="javascript: showClinic('<%=sDate%>', [<%=sAvlTimeJsp%>], null, null, null, null, null, false, true, false, null, null, null);">Add Clinics</a><br><%}%>

                              <%for(int k=0; k < iNumOfCln; k++){%>
                                 <br><a href="javascript: showClinic('<%=sDate%>', [<%=sAvlTimeJsp%>], [<%=vencal.cvtToJavaScriptArray(vencal.parseArray(sClnTime[k], 30, 1, false))%>], '<%=sVen[k]%>', '<%=sVenName[k]%>', '<%=sLocation[k]%>', '<%=sApprv[k]%>', true, <%=bAvl%>, <%=bDispOnly[k]%>, '<%=sVenPhn[k]%>', '<%=sVenCell[k]%>', '<%=sVenEMail[k]%>');"><%=sBrands[k]%></a>
                                 <%if(sApprv[k].equals("Y")){%><sup><b><i><font color="red">A!</font></i></b></sup><%}%>
                              <%}%>
                           </td>
                          </tr>

                       </table>
                       <!--------------------- End of Day panel ----------------------------->
                      </td>
                 <%}%>


               <%if(j==6) { j=0;%></tr><%}
                 else { j++; }%>
           <%}%>
        </table>
        <p align=left>
        <span style="border: black solid 1px; background:#c3fdb8;">&nbsp;&nbsp;&nbsp;</span> - Available Day,
        &nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp
        <span style="border: black solid 1px; background:#fdd017;">&nbsp;&nbsp;&nbsp;</span> - Marked for Clinics
        &nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp
        <span style="border: black solid 1px; background:red">&nbsp;&nbsp;&nbsp;</span> - Available Time
        &nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp
        <sup><b><i><font color="red">A!</font></i></b></sup> - Approved<br>
        <font size="-1">Click <a href="memopool/Vendor Rep Clinic Request Instructions.doc" target="_blank">here</a> to get a Vendor Rep Clinic Request Instructions</font>
        <p>
        </td>
     </tr>
     <tr>
       <td style="border-top: black solid 1px;">
        <table border=0 width="100%">
        <tr  style="font-size:10px">
          <td colspan=4>* Note: Please contact RCI  for any questions in regards of the clinics:</td></tr>
        <tr  style="font-size:10px">
          <td>Karl Salz 281-340-5000 ext 155</td>
          <td>Mike Parker 281-340-5000 ext 158</td>
          <td>Kelly Knight 703-472-8510</td>
        </tr>
        </table>
      </td>
     </tr>
   </table>
  </body>
</html>
<%
  vencal.disconnect();
  vencal = null;
}%>
