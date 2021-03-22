<%@ page import="discountcard.DiscountCardLst, discountcard.CustomerLookup, java.util.*, java.text.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=CustomerLookup.jsp&APPL=ALL");
   }
   else
   {
      String sStrAllowed = session.getAttribute("STORE").toString();
      boolean bAllowChg = sStrAllowed != null && sStrAllowed.startsWith("ALL");

      String sSrchCode = request.getParameter("Code");
      String sSrchName = request.getParameter("Name");
      String sSrchTeam = request.getParameter("Team");
      String sSrchPhone1 = request.getParameter("Phone1");
      String sSrchPhone2 = request.getParameter("Phone2");
      String sSrchPhone3 = request.getParameter("Phone3");
      String sSrchEMail = request.getParameter("EMail");
      String sSrchRide = request.getParameter("Ride");
      String sSrchFrom = request.getParameter("From");
      String sSrchTo = request.getParameter("To");
      String sExcel = request.getParameter("Excel");

      if(sExcel != null) response.setContentType("application/vnd.ms-excel");

      if(sSrchCode==null) sSrchCode = " ";
      if(sSrchName==null) sSrchName = " ";
      if(sSrchTeam==null) sSrchTeam = " ";
      if(sSrchPhone1==null) sSrchPhone1 = " ";
      if(sSrchPhone2==null) sSrchPhone2 = " ";
      if(sSrchPhone3==null) sSrchPhone3 = " ";
      if(sSrchEMail==null) sSrchEMail = " ";
      if(sSrchRide==null) sSrchRide = " ";
      if(sSrchFrom==null) sSrchFrom = "01/01/2000";
      if(sSrchTo==null) sSrchTo = "01/01/2099";

      int iNumOfCust = 0;
      CustomerLookup custlup = new CustomerLookup();

      if  (!sSrchCode.trim().equals("") || !sSrchName.trim().equals("") || !sSrchTeam.trim().equals("")
        || !sSrchPhone1.trim().equals("") || !sSrchPhone2.trim().equals("") || !sSrchPhone3.trim().equals("")
        || !sSrchEMail.trim().equals("") || !sSrchRide.trim().equals(""))
      {
         custlup.searchCustomer(sSrchCode, sSrchName, sSrchTeam, sSrchPhone1, sSrchPhone2, sSrchPhone3, sSrchEMail,
            sSrchRide, sSrchFrom, sSrchTo, session.getAttribute("USER").toString());
         iNumOfCust = custlup.getNumOfCust();
      }

      // get list of available rides
      custlup.setAdvertising();
      String sAdvRide = custlup.getAdvRide();
      String sAdvDate = custlup.getAdvDate();
      String sRideActive = custlup.getRideActive();

      // get list of discount card programs
      DiscountCardLst dclist = new DiscountCardLst(session.getAttribute("USER").toString());
      String sDcName = dclist.getDcNameJsa();
      dclist.disconnect();
%>

<html>
<head>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }

        td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:right;}
        td.DataTable2 { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:center;}

        <!--------------------------------------------------------------------->
        .Small {font-family:Arial; font-size:10px }
        input.Small {font-family:Arial; font-size:10px }
        button.Small {font-family:Arial; font-size:10px }
        select.Small {font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }

        div.dvCust  { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:200; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; padding-left:3px; padding-right:3px; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
</style>


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var AdvRide = [<%=sAdvRide%>];
var AdvDate = [<%=sAdvDate%>];
var DscName = [<%=sDcName%>];
var RideActive = [<%=sRideActive%>];
var NumOfCust = <%=iNumOfCust%>
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvCust"]);
   setRideSelection()
}
//==============================================================================
// set Ride Selection menu
//==============================================================================
function setRideSelection()
{
   document.all.selRideLst.options[0] = new Option("<< Select Ride >>", "SELECT");
   for(var i=0, j=1; i < AdvRide.length; i++, j++)
   {
     document.all.selRideLst.options[j] = new Option(AdvRide[i], AdvRide[i]);
   }
}
//==============================================================================
// get selected ride and populate input menu
//==============================================================================
function getSelRide()
{
   var idx = document.all.selRideLst.selectedIndex;
   if(idx > 0)
   {
     document.all.Ride.value = document.all.selRideLst.options[idx].value
   }
}
//==============================================================================
// convert table to excel document
//==============================================================================
function startExcelApp()
{
   window.status="Loading Table to Excel spreadsheet."

   var url = "CustomerLookupExcel.jsp?"
      + "&Code=<%=sSrchCode%>"
      + "&Name=<%=sSrchName%>"
      + "&Team=<%=sSrchTeam%>"
      + "&Phone1=<%=sSrchPhone1%>"
      + "&Phone2=<%=sSrchPhone2%>"
      + "&Phone3=<%=sSrchPhone3%>"
      + "&EMail=<%=sSrchEMail%>"
      + "&Ride=<%=sSrchRide%>"
      + "&From=<%=sSrchFrom%>"
      + "&To=<%=sSrchTo%>"

   var WindowName = 'Preferred_Customer_List';
   var WindowOptions = 'height=500, width=900,left=10,top=10, resizable=yes , toolbar=no, location=yes, directories=no, status=yes, scrollbars=yes,menubar=yes';

   //alert(url);
   window.open(url, WindowName, WindowOptions);
   window.status="Table Loaded."
}
//==============================================================================
// populate Excel Header
//==============================================================================
function popExcelHdr()
{
   // Header Line
   var html = "";
   var tblHdr = document.all.thHdr
   for(var i=0; i < tblHdr.length; i++)
   {
      var cell = tblHdr[i].innerHTML.replace(/<br>/i, " ");
      html += cell;
   }
   return html;
}
//==============================================================================
//populate Excel Column Content
//==============================================================================
function popExcelDtl()
{
   // Header Line
   var html = "";
   var oCell = document.all.tdCell
   var oLink = document.all.tdCodeLnk
   for(var i=0, k=0; i < NumOfCust; i++)
   {
      window.status="Loading Table to Excel spreadsheet. Row: " + (i+1)
      for(var j=0; j < 12; j++, k++)
      {
         var cell = oCell[k].innerHTML.replace(/<br>/i, " ");
         // extract data from link
         if(j==0 && NumOfCust > 1){ cell = oLink[i].innerHTML.replace(/<br>/i, " "); }
         else if(j==0 && NumOfCust == 1){ cell = oLink.innerHTML.replace(/<br>/i, " "); }

         html += cell;
      }
   }


}
//==============================================================================
// change or enter new customer info
//==============================================================================
function chgCustInfo(code, fname, lname, addr1, addr2, city, state, zip, phone, email, ride, team, action)
{
   var hdr = "Tracking ID:&nbsp;";
   if (code=="0000") hdr += "None"
   else hdr += code

   var html = "<table border=0 width=100% cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
     + "<tr><td class='Prompt' colspan=2>" + popCustTable(code, action)
       + "</td></tr>"
   + "</table>"

   document.all.dvCust.innerHTML = html;
   document.all.dvCust.style.pixelLeft= document.documentElement.scrollLeft + 400;
   document.all.dvCust.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvCust.style.visibility = "visible";

   for(var i=0; i < AdvRide.length; i++)
   {
      //if(RideActive[i] == "1")
      //{
         document.all.SelRide.options[i] = new Option(AdvDate[i] + " - " + AdvRide[i], AdvRide[i]);
      //}
   }

   if(action != "ADD")
   {
      document.all.CstName.value = fname + " " + lname
      document.all.CstTeam.value = team;
      document.all.CstAddr1.value = addr1
      document.all.CstAddr2.value = addr2
      document.all.CstCity.value = city
      document.all.CstState.value = state
      document.all.CstZip.value = zip
      document.all.CstPhone.value = phone
      document.all.CstEMail.value = email
      document.all.CstRide.value = ride
   }
   if(action == "DLT")
   {
      document.all.CstName.readOnly = true;
      document.all.CstTeam.readOnly = true;
      document.all.CstAddr1.readOnly = true;
      document.all.CstAddr2.readOnly = true;
      document.all.CstCity.readOnly = true;
      document.all.CstState.readOnly = true;
      document.all.CstZip.readOnly = true;
      document.all.CstPhone.readOnly = true;
      document.all.CstEMail.readOnly = true;
      document.all.CstRide.readOnly = true;
   }
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popCustTable(code, action)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
          + "<tr><td class='Prompt' >Name:</td>"
           + "<td class='Prompt' colspan='2'>"
              + "<input name='CstName' class='Small' size=30 maxlength=30>"
         + "</td></tr>"
         + "<tr><td class='Prompt' >Team:</td>"
           + "<td class='Prompt' colspan='2'>"
              + "<input name='CstTeam' class='Small' size=30 maxlength=30>"
         + "</td></tr>"
         + "<tr><td class='Prompt' >Address:</td>"
           + "<td class='Prompt' colspan='2'>"
              + "<input name='CstAddr1' class='Small' size=25 maxlength=25>"
              + "<br><input name='CstAddr2' class='Small' size=25 maxlength=25>"
         + "</td></tr>"
         + "<tr><td class='Prompt' >City:</td>"
           + "<td class='Prompt' colspan='2'>"
              + "<input name='CstCity' class='Small' size=20 maxlength=20>"
         + "</td></tr>"
         + "<tr><td class='Prompt' >State:</td>"
           + "<td class='Prompt' colspan='2'>"
              + "<input name='CstState' class='Small' size=2 maxlength=2>"
         + "</td></tr>"
         + "<tr><td class='Prompt' >Zip:</td>"
           + "<td class='Prompt' colspan='2'>"
              + "<input name='CstZip' class='Small' size=10 maxlength=10>"
         + "</td></tr>"
         + "<tr><td class='Prompt'  nowrap>Phone Number:</td>"
           + "<td class='Prompt' colspan='2'>"
              + "<input name='CstPhone' class='Small' size=14 maxlength=14>"
         + "</td></tr>"
         + "<tr><td class='Prompt' nowrap>E-Mail Address:</td>"
           + "<td class='Prompt' colspan='2'>"
              + "<input name='CstEMail' class='Small' size=50 maxlength=50>"
         + "</td></tr>"
         + "<tr><td class='Prompt' nowrap>Ride:</td>"
           + "<td class='Prompt' colspan='2'>"
              + "<input name='CstRide' class='Small' size=30 maxlength=30 readOnly>"
         + "</td></tr>"
         + "<tr><td class='Prompt' nowrap>Select Ride:</td>"
           + "<td class='Prompt' colspan='2'>"
              + "<select name='SelRide' class='Small' onClick='popRide(this)'></select>"
         + "</td></tr>"
         + "<tr><td class='Prompt1' colspan='3'><br><br>"
        + "<button onClick='ValidateCust(&#34;" + code + "&#34;, &#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
       + "</table>";

  return panel;
}
//==============================================================================
// change or enter new customer info
//==============================================================================
function sendCard(code, fname, lname, addr1, addr2, city, state, zip, phone, email, ride, team)
{
   var hdr = "Customer:&nbsp;" + fname + " " + lname;

   var html = "<table border=0 width=100% cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
     + "<tr><td class='Prompt' colspan=2>" + popDiscList(code, fname, lname, addr1, addr2, city, state, zip, phone, email, ride, team)
       + "</td></tr>"
   + "</table>"

   document.all.dvCust.innerHTML = html;
   document.all.dvCust.style.pixelLeft= document.documentElement.scrollLeft + 400;
   document.all.dvCust.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvCust.style.visibility = "visible";
}
//--------------------------------------------------------
// populate Discount program List
//--------------------------------------------------------
function popDiscList(code, fname, lname, addr1, addr2, city, state, zip, phone, email, ride, team)
{

  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"

  for(var i=0; i < DscName.length; i++)
  {
      panel += "<tr><td class='Prompt' nowrap><a href='javascript: sbmDiscCard(&#34;"
         + DscName[i].replaceSpecChar() + "&#34;, &#34;" + code + "&#34;, &#34;" + fname.replaceSpecChar()
         + " " + lname.replaceSpecChar() + "&#34;, &#34;"
         + addr1.replaceSpecChar() + "&#34;, &#34;" + addr2.replaceSpecChar() + "&#34;, &#34;"
         + city.replaceSpecChar() + "&#34;, &#34;"
         + state + "&#34;, &#34;" + zip.replaceSpecChar() + "&#34;, &#34;" + phone.replaceSpecChar() + "&#34;, &#34;"
         + email.replaceSpecChar() + "&#34;, &#34;" + ride.replaceSpecChar()  + "&#34;, &#34;" + team.replaceSpecChar()
         + "&#34;)'>" + DscName[i].replaceSpecChar() + "</a></td>"
         + "</td></tr>"
  }

  panel += "<tr><td class='Prompt1' colspan='3'>"
        + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
       + "</table>";

  return panel;
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvCust.innerHTML = " ";
   document.all.dvCust.style.visibility = "hidden";
}
//==============================================================================
// populate  Ride
//==============================================================================
function popRide(sel)
{
   document.all.CstRide.value = sel.options[sel.selectedIndex].value
}
//==============================================================================
// submit Customer Entry
//==============================================================================
function ValidateCust(code, action)
{
   var error = false;
   var msg = "";
   var name = document.all.CstName.value.trim();
   var team = document.all.CstTeam.value.trim();
   var addr1 = document.all.CstAddr1.value.trim();
   var addr2 = document.all.CstAddr2.value.trim();
   var city = document.all.CstCity.value.trim();
   var state = document.all.CstState.value.trim();
   var zip = document.all.CstZip.value.trim();
   var phone = document.all.CstPhone.value.trim();
   var email = document.all.CstEMail.value.trim();
   var ride = document.all.CstRide.value.trim();

   if (name=="") {msg += "Please, Enter the name.\n"; error = true;}
   if (phone == "" && email == "" ) {msg += "Please, Enter the phone number or E-Mail address.\n"; error = true;}
   if (ride=="") {msg += "Please, select the ride.\n"; error = true;}

   if (error) {alert(msg)}
   else sbmCustEnt(code, name, addr1, addr2, city, state, zip, phone, email, ride, team, action)
}
//==============================================================================
// submit Customer Entry
//==============================================================================
function sbmCustEnt(code, name, addr1, addr2, city, state, zip, phone, email, ride, team, action)
{
   hidePanel();

   var url = "CustomerSave.jsp?Code=" + code
           + "&Name=" + name.replaceSpecChar()
           + "&Addr1=" + addr1.replaceSpecChar()
           + "&Addr2=" + addr2.replaceSpecChar()
           + "&City=" + city.replaceSpecChar()
           + "&State=" + state.replaceSpecChar()
           + "&Zip=" + zip.replaceSpecChar()
           + "&Phone=" + phone.replaceSpecChar()
           + "&EMail=" + email.replaceSpecChar()
           + "&Ride=" + ride.replaceSpecChar()
           + "&Team=" + team.replaceSpecChar()
           + "&Action=" + action
   //alert(url);
   //window.location.href=url;
   window.frame1.location.href=url;
}
//==============================================================================
// display error occured at entry time.
//==============================================================================
function displayError(error)
{
   var msg="";
   for(var i=0; i < error.length; i++)
   {
      msg += error[i] + "\n"
   }
   alert(msg)
}
//==============================================================================
// restart saved customer code
//==============================================================================
function reStart(code)
{
   var url = "CustomerLookup.jsp?Code=" + code;
   //alert(url)
   window.location.href=url;
}
//--------------------------------------------------------
// submit send Discount Card page
//--------------------------------------------------------
function sbmDiscCard(card, code, name, addr1, addr2, city, state, zip, phone, email, ride, team)
{
   var url = "DiscountCard.jsp?Card=" + card.replaceSpecChar()
           + "&Code=" + code
           + "&Name=" + name.replaceSpecChar()
           + "&Addr1=" + addr1.replaceSpecChar()
           + "&Addr2=" + addr2.replaceSpecChar()
           + "&City=" + city.replaceSpecChar()
           + "&State=" + state.replaceSpecChar()
           + "&Zip=" + zip.replaceSpecChar()
           + "&Phone=" + phone.replaceSpecChar()
           + "&EMail=" + email.replaceSpecChar()
           + "&Ride=" + ride.replaceSpecChar()
           + "&Team=" + team.replaceSpecChar()
   hidePanel();
   //alert(url);
   window.location.href=url;
}
//==============================================================================
// submit Card panel
//==============================================================================
function sbmCustomer(code, fname, lname)
{
   var url = "CustomerPurchase.jsp?Code=" + code
           + "&Customer=" + lname + ", " + fname
           + "&From=<%=sSrchFrom%>"
           + "&To=<%=sSrchTo%>"
   //alert(url)
   window.location.href=url;
}
//==============================================================================
// submit Customer Search
//==============================================================================
function sbmSearch()
{
   var url = "CustomerLookup.jsp?";

   if (document.all.Code.value.trim() != "") { url += "Code=" + document.all.Code.value.trim() }
   else if (document.all.Name.value.trim() != "") { url += "Name=" + document.all.Name.value.trim().toUpperCase() }
   else if (document.all.Team.value.trim() != "") { url += "Team=" + document.all.Team.value.trim().toUpperCase() }
   else if (document.all.Phone[0].value.trim() != "" || document.all.Phone[1].value.trim() != "" || document.all.Phone[2].value.trim() != "")
   {
      url += "Phone1=" + document.all.Phone[0].value.trim().toUpperCase()
          + "&Phone2=" + document.all.Phone[1].value.trim().toUpperCase()
          + "&Phone3=" + document.all.Phone[2].value.trim().toUpperCase()
   }
   else if (document.all.EMail.value.trim() != "") { url += "EMail=" + document.all.EMail.value.trim().toUpperCase() }
   else if (document.all.Ride.value.trim() != "") { url += "Ride=" + document.all.Ride.value.trim() }

   url += "&From=" + document.all.FromDate.value
        + "&To=" + document.all.ToDate.value

   //alert(url)
   window.location.href=url;
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
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvCust" class="dvCust"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
    <table border="0" cellPadding="0"  cellSpacing="0" id="tbData">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
      <b>Retail Concepts, Inc
      <br>Preferred Customer Lookup</b></td>
    </tr>
    <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>
        <table border="0" cellPadding="0"  cellSpacing="0">
          <tr><td colspan=2>Enter any of the following information:</td></tr>
          <tr ALIGN="left"><td>Code:</td><td><input name="Code" class="Small" maxlength=4 size=4></td></tr>
          <tr><td>Name:</td><td><input name="Name" class="Small" maxlength=30 size=30></td></tr>
          <tr><td>Team:</td><td><input name="Team" class="Small" maxlength=25 size=25></td></tr>
          <tr><td>Phone:</td><td>
              <input name="Phone" class="Small" maxlength=3 size=3> -
              <input name="Phone" class="Small" maxlength=3 size=3> -
              <input name="Phone" class="Small" maxlength=4 size=4>
          </td></tr>
          <tr><td>Email:</td><td><input name="EMail" class="Small" maxlength=50 size=50></td></tr>
          <tr><td>Ride:</td><td><input name="Ride" class="Small" maxlength=30 size=30>
          &nbsp; <select class="Small" name="selRideLst" onChange="getSelRide()"></select>
          </td></tr>

          <tr><td valign="bottom">Sales Dates:&nbsp;</td>
              <td>
                 <input class="Small" name="FromDate" type="text" value="01/01/2000" size=10 maxlength=10>&nbsp;
                 <%for(int i=0; i < 5; i++){%>&nbsp;<%}%>
                 <input class="Small" name="ToDate" type="text" value="01/01/2099" size=10 maxlength=10>&nbsp;
              </td>
          </tr>
          <tr>
              <td align=center><button class="Small" onClick="sbmSearch()">Search</button></td>
              <%if(bAllowChg){%>
                  <td align=center><button class="Small" onClick="chgCustInfo('0000','', '', '', '', '', '', '', '', '', '', '', 'ADD')">New Customer</button></td>
              <%}%>
          </tr>
        </table>
        </b><br><br>
      </td>
    </tr>
    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <%if(iNumOfCust > 0) {%><a href="javascript: startExcelApp()">Load to Excel</a><%}%>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr class="DataTable">
        <th class="DataTable" id="thHdr" nowrap>Tracking<br>Id</th>
        <th class="DataTable" nowrap>Discount</th>
        <th class="DataTable" id="thHdr" nowrap>First<br>Name</th>
        <th class="DataTable" id="thHdr" nowrap>Last<br>Name</th>
        <th class="DataTable" nowrap>U<br>p<br>d</th>
        <th class="DataTable" id="thHdr" nowrap>Address</th>
        <th class="DataTable" id="thHdr" nowrap>City</th>
        <th class="DataTable" id="thHdr" nowrap>State</th>
        <th class="DataTable" id="thHdr" nowrap>Zip</th>
        <th class="DataTable" id="thHdr" nowrap>Phone</th>
        <th class="DataTable" id="thHdr" nowrap>E-Mail</th>
        <th class="DataTable" id="thHdr" nowrap>Team</th>
        <th class="DataTable" id="thHdr" nowrap>Group</th>
        <th class="DataTable" id="thHdr" nowrap>Ride</th>
        <th class="DataTable" id="thHdr" nowrap>Sales</th>
        <th class="DataTable" id="thHdr" nowrap>5%</th>
        <th class="DataTable" nowrap>D<br>l<br>t</th>
      </tr>
      <TBODY>

     <!----------------------- Order List ------------------------>
     <%for(int i=0; i < iNumOfCust; i++) {
         custlup.setCustomer();
         String sCode = custlup.getCode();
         String sFName = custlup.getFName();
         String sLName = custlup.getLName();
         String sAddr1 = custlup.getAddr1();
         String sAddr2 = custlup.getAddr2();
         String sCity = custlup.getCity();
         String sState = custlup.getState();
         String sZip = custlup.getZip();
         String sPhone = custlup.getPhone();
         String sBusPhn = custlup.getBusPhn();
         String sHomePhn = custlup.getHomePhn();
         String sFax = custlup.getFax();
         String sEMail = custlup.getEMail();
         String sRide = custlup.getRide();
         String sTeam = custlup.getTeam();
         String sSales = custlup.getSales();
         String sSls5Prc = custlup.getSls5Prc();
         String sGroup = custlup.getGroup();
     %>
         <tr  class="DataTable" id="trDtl">
            <%if(bAllowChg){%>
                 <td class="DataTable" id="tdCell"><a  id="tdCodeLnk" href="javascript: sbmCustomer(&#34;<%=sCode%>&#34;, &#34;<%=sFName%>&#34;, &#34;<%=sLName%>&#34;)"><%=sCode%></a></td>
            <%} else {%><td class="DataTable" id="tdCell"><%=sCode%></td><%}%>
            <%if(bAllowChg){%>
               <td class="DataTable2"><a href="javascript: sendCard(&#34;<%=sCode%>&#34;, &#34;<%=sFName%>&#34;, &#34;<%=sLName%>&#34;, &#34;<%=sAddr1%>&#34;, &#34;<%=sAddr2%>&#34;, &#34;<%=sCity%>&#34;, &#34;<%=sState%>&#34;, &#34;<%=sZip%>&#34;, &#34;<%=sPhone%>&#34;, &#34;<%=sEMail%>&#34;, &#34;<%=sRide%>&#34;, &#34;<%=sTeam%>&#34;)">Card</a></td>
            <%} else {%><td class="DataTable">&nbsp;</td><%}%>
            <td class="DataTable" id="tdCell"><%=sFName%></td>
            <td class="DataTable" id="tdCell"><%=sLName%></td>
            <%if(bAllowChg){%>
                <td class="DataTable"><a href="javascript: chgCustInfo(&#34;<%=sCode%>&#34;, &#34;<%=sFName%>&#34;, &#34;<%=sLName%>&#34;, &#34;<%=sAddr1%>&#34;, &#34;<%=sAddr2%>&#34;, &#34;<%=sCity%>&#34;, &#34;<%=sState%>&#34;, &#34;<%=sZip%>&#34;, &#34;<%=sPhone%>&#34;, &#34;<%=sEMail%>&#34;, &#34;<%=sRide%>&#34;, &#34;<%=sTeam%>&#34;, &#34;UPD&#34;)">U</a></td>
            <%} else {%><td class="DataTable">&nbsp;</td><%}%>
            <td class="DataTable" id="tdCell"><%=sAddr1 + "<br>" + sAddr2%></td>
            <td class="DataTable" id="tdCell"><%=sCity%></td>
            <td class="DataTable" id="tdCell"><%=sState%></td>
            <td class="DataTable" id="tdCell" ><%=sZip%></td>
            <td class="DataTable" id="tdCell"><%=sPhone%></td>
            <td class="DataTable" id="tdCell"><%=sEMail%></td>
            <td class="DataTable" id="tdCell" nowrap><%=sTeam%></td>
            <td class="DataTable" id="tdCell" nowrap><%=sGroup%></td>
            <td class="DataTable" id="tdCell" nowrap><%=sRide%></td>
            <td class="DataTable1" id="tdCell" nowrap><%=sSales%></td>
            <td class="DataTable1" id="tdCell" nowrap><%=sSls5Prc%></td>
            <%if(bAllowChg){%>
               <td class="DataTable"><a href="javascript: chgCustInfo(&#34;<%=sCode%>&#34;, &#34;<%=sFName%>&#34;, &#34;<%=sLName%>&#34;, &#34;<%=sAddr1%>&#34;, &#34;<%=sAddr2%>&#34;, &#34;<%=sCity%>&#34;, &#34;<%=sState%>&#34;, &#34;<%=sZip%>&#34;, &#34;<%=sPhone%>&#34;, &#34;<%=sEMail%>&#34;, &#34;<%=sRide%>&#34;, &#34;<%=sTeam%>&#34;,&#34;DLT&#34;)">D</a></td>
            <%} else {%><td class="DataTable">&nbsp;</td><%}%>
         </tr>
     <%}%>
      <!---------------------------------------------------------------------->
      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>

  </table>
 </body>
</html>
<%
if(iNumOfCust > 0) custlup.disconnect();%>
<%}%>