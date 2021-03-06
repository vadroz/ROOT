<%@ page import="java.util.*, advertising.AdPromoEntry"%>
<%
   String sAdType = request.getParameter("AdType");
   String sAdName = request.getParameter("AdName");
   String sAdFrom = request.getParameter("AdFrom");
   String sAdTo = request.getParameter("AdTo");
   String sAction = request.getParameter("Action");

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("ADVERTISES")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=" + request.getRequestURI() + "&APPL=ADVERTISES");
   }
   else
   {
     AdPromoEntry adpromo = new AdPromoEntry();

     if(sAction != null && sAction.equals("ADD")) adpromo.addPromoEntry(sAdType, sAdName, sAdFrom, sAdTo);
     else if(sAction != null && sAction.equals("DLT")) adpromo.dltPromoEntry(sAdType, sAdName, sAdFrom, sAdTo);
     String sErrorJSA = adpromo.getErrorJSA();

     adpromo.setPromoList();

     int iNumOfPromo = adpromo.getNumOfPromo();
     String [] sPromo = adpromo.getPromo();
     String [] sPFrom = adpromo.getPFrom();
     String [] sPTo = adpromo.getPTo();

     int iNumOfEvent = adpromo.getNumOfEvent();
     String [] sEvent = adpromo.getEvent();
     String [] sEFrom = adpromo.getEFrom();
     String [] sETo = adpromo.getETo();

     int iNumOfNonEvt = adpromo.getNumOfNonEvt();
     String [] sNonEvt = adpromo.getNonEvt();
     String [] sNFrom = adpromo.getNFrom();
     String [] sNTo = adpromo.getNTo();

     int iNumOfMedCom = adpromo.getNumOfMedCom();
     String [] sMedCom = adpromo.getMedCom();
     String [] sMFrom = adpromo.getMFrom();
     String [] sMTo = adpromo.getMTo();

     adpromo.disconnect();
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

  div.Promo { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:265; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
  tr.Promo  {background-color: blue; color:white; text-align:center; font-family:Arial;
                   font-size:12px; font-weight:bold}
  td.Promo  {text-align:center; font-family:Arial; font-size:10px;
                   padding-top:3px; padding-bottom:3px;}
  td.Promo1 {padding-right:3px; padding-left:3px; text-align:center; font-family:Arial; font-size:10px; }
  td.Promo2 {padding-right:3px; padding-left:3px; text-align:left; font-family:Arial; font-size:10px; }
  td.Menu2  {border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }

  .small{ text-align:left; font-family:Arial; font-size:10px;}


</style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<SCRIPT language="JavaScript">
var Error = null;
<%if(sErrorJSA !=null && !sErrorJSA.trim().equals("") ) {%>
  Error = [<%=sErrorJSA%>]
<%}%>
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
// Add Promotion
//==============================================================================
function addPromo(type, promo, from, to, action)
{
  var MenuName = "";
  var MenuOpt = "";
  var prtype= null;
  if(type=="P") prtype="Promotion";
  else if(type=="E") prtype="Event";
  else if(type=="N") prtype="Non-Event";
  else if(type=="M") prtype="Nedia Commitments";

  MenuName = "<td colspan='10' nowrap>Update Promotion</td>";


  // Promotion type as constant
     MenuOpt += "<tr>"
             + "<td class='Promo1' nowrap >Promotion type:</td>"
             + "<td class='Promo2' nowrap ><font color=red>" + prtype + "</font>"
             + "<input type='hidden' name='AdType' value='" + type + "'></td>"
          +  "</tr>";

  // Promotion Name
  MenuOpt += "<tr>"
             + "<td class='Promo2' nowrap >Promotion Name:</td>"
             + "<td class='Promo2' nowrap ><input name='AdName' class='Small' size=30 maxlength=50></td>"
          +  "</tr>"
          + "<tr>"
             + "<td class='Promo2' nowrap>From Weekending:</td>"
             + "<td class='Promo2' nowrap><input name='AdFrom' class='Small' size=10 maxlength=10 readonly>"
                 + "<a href='javascript:showCalendar(1, null, null, 100, 300, document.all.AdFrom)' >"
                 + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a>"
             + "</td>"
          +  "</tr>"
          + "<tr>"
             + "<td class='Promo2' nowrap >To Weekending:</td>"
             + "<td class='Promo2' nowrap ><input name='AdTo' class='Small' size=10 maxlength=10 readonly>"
                 + "<a href='javascript:showCalendar(1, null, null, 100, 300, document.all.AdTo)' >"
                 + "<img src='calendar.gif' style='border=none' alt='Calendar Prompt' width='34' height='21'></a>"
             + "</td>"
          +  "</tr>";

  // add close option on menu
  MenuOpt += "<tr><td colspan='10' class='Promo' align='center'>"
       + "<button class='small' onclick='validatePromoEntry(&#34;" + action + "&#34;);'>Save</button>&nbsp;&nbsp;&nbsp;"
       + "<button class='small' onclick='resetPromoEntry();'>Reset</button>&nbsp;&nbsp;&nbsp;"
       + "<button class='small' onclick='hidePromoEntry();'>Close</button>"
       + "</td></tr>";

  var MenuHtml = "<table width='100%' cellPadding='0' cellSpacing='0'>"
  + "<tr class='Promo'>"
     + MenuName
     + "<td class='Menu2' valign=top>"
     +  "<img src='CloseButton.bmp' onclick='javascript:hidePromoEntry();' alt='Close'>"
     + "</td>"
   + "</tr>"
   + MenuOpt
   + "</table>"

  document.all.dvPromo.innerHTML=MenuHtml
  document.all.dvPromo.style.pixelLeft= document.documentElement.scrollLeft + 15
  document.all.dvPromo.style.pixelTop=document.documentElement.scrollTop + screen.height - 700;
  document.all.dvPromo.style.visibility="visible"

  if(action=="CHG")
  {
    document.all.AdName.value = promo;
    document.all.AdFrom.value = from;
    document.all.AdTo.value = to;
  }
  else
  if(action=="ADD")
  {
    document.all.AdName.value = "";
    document.all.AdFrom.value = "01/01/0001";
    document.all.AdTo.value = "01/01/0001";
  }
}
//==============================================================================
// Delete Promotion
//==============================================================================
function dltPromo(type, promo, from, to)
{
  var MenuName = "";
  var MenuOpt = "";
  var prtype= null;
  if(type=="P") prtype="Promotion";
  else if(type=="E") prtype="Event";
  else if(type=="N") prtype="Non-Event";
  else if(type=="M") prtype="Nedia Commitments";

  MenuName = "<td colspan='10' nowrap>Update Promotion</td>";


  // Promotion type as constant
  MenuOpt += "<tr>"
          + "<td class='Promo1' nowrap >Promotion type:</td>"
          + "<td class='Promo2' nowrap ><font color=red>" + prtype + "</font>"
          + "<input type='hidden' name='AdType' value='" + type + "'></td>"
       +  "</tr>";

  // Promotion Name
  MenuOpt += "<tr>"
             + "<td class='Promo2' nowrap >Promotion Name:</td>"
             + "<td class='Promo2' nowrap ><input name='AdName' class='Small' size=30 maxlength=50 readonly></td>"
          +  "</tr>"
          + "<tr>"
             + "<td class='Promo2' nowrap>From Weekending:</td>"
             + "<td class='Promo2' nowrap><input name='AdFrom' class='Small' size=10 maxlength=10 readonly>"
             + "</td>"
          +  "</tr>"
          + "<tr>"
             + "<td class='Promo2' nowrap >To Weekending:</td>"
             + "<td class='Promo2' nowrap ><input name='AdTo' class='Small' size=10 maxlength=10 readonly>"
             + "</td>"
          +  "</tr>";



  // add close option on menu
  MenuOpt += "<tr><td colspan='10' class='Promo' align='center'>"
       + "<button class='small' onclick='sbmPromoEntry(&#34;DLT&#34;);'>Delete</button>&nbsp;&nbsp;&nbsp;"
       + "<button class='small' onclick='hidePromoEntry();'>Close</button>"
       + "</td></tr>";

  var MenuHtml = "<table width='100%' cellPadding='0' cellSpacing='0'>"
  + "<tr class='Promo'>"
     + MenuName
     + "<td class='Menu2' valign=top>"
     +  "<img src='CloseButton.bmp' onclick='javascript:hidePromoEntry();' alt='Close'>"
     + "</td>"
   + "</tr>"
   + MenuOpt
   + "</table>"

  document.all.dvPromo.innerHTML=MenuHtml
  document.all.dvPromo.style.pixelLeft= document.documentElement.scrollLeft + 15
  document.all.dvPromo.style.pixelTop=document.documentElement.scrollTop + screen.height - 500;
  document.all.dvPromo.style.visibility="visible"

  // Populate Entry fields
  document.all.AdName.value = promo;
  document.all.AdFrom.value = from;
  document.all.AdTo.value = to;
}
//========================================================================
// reset Promotion menu entry fields
//========================================================================
function resetPromoEntry()
{
  document.all.AdName.value = "";
  document.all.AdFrom.value = "01/01/0001";
  document.all.AdTo.value = "01/01/0001";
}
//========================================================================
// close dropdown menu
//========================================================================
function hidePromoEntry(){document.all.dvPromo.style.visibility="hidden"}
//==============================================================================
// validate Promotion entry
//==============================================================================
function validatePromoEntry(action)
{
   var msg = "";
   var error = false
   var adName = document.all.AdName.value.trim();
   var adFrom = new Date(document.all.AdFrom.value);
   var adTo = new Date(document.all.AdTo.value);

   // promotion name cannot be empty
   if(adName == "")
   {
     msg += "Promotion name cannot be empty.\n";
     error = true;
   }

   // check, if from date is sunday
   if(adFrom.getDay() != "0")
   {
     msg += "From date is not a weekending.\n";
     error = true;
   }

   // check, if from date is sunday
   if(adTo.getDay() != "0")
   {
     msg += "To date is not a weekending.\n";
     error = true;
   }

   if(!error)
   {
      sbmPromoEntry(action);
   }
   else { alert(msg) }
}
//==============================================================================
// submit Advertising List Page
//==============================================================================
function sbmPromoEntry(action)
{
  var url = "AdPromoEntry.jsp?"
          + "AdType=" + document.all.AdType.value
          + "&AdName=" + document.all.AdName.value.trim()
          + "&AdFrom=" + document.all.AdFrom.value.trim()
          + "&AdTo=" + document.all.AdTo.value.trim()
          + "&Action=" + action;

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
<div id="dvPromo" class="Promo"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Advertising - Work With Promotions</b><br>
        <a href="../"><font color="red" size="-1">Home</font></a>;
        <a href="javascript: window.close();"><font color="red" size="-1">Close</font></a>
        <!----------------- start of ad table ------------------------>
         <table class="DataTable" cellPadding="0" cellSpacing="0">
           <thead>
             <tr class="DataTable">
               <th class="DataTable" >Name</th>
               <th class="DataTable"  nowrap>From Week</th>
               <th class="DataTable"  nowrap>To Week</th>
               <th class="DataTable"  nowrap>Delete</th>
             </tr>
           </thead>
           <tfoot><tr><td></td></tr></tfoot>
           <tbody style="overflow: visible;">
             <!----------------------------- Promotion --------------------------------->
             <tr class="DataTable1">
               <td class="DataTable" colspan="3">Promotion</td>
               <td class="DataTable1"><a href="javascript:addPromo('P', '', '', '', 'ADD')">Add</a></td>
             </tr>
             <%for(int i=0; i < iNumOfPromo; i++){%>
                  <tr class="DataTable2">
                    <td class="DataTable1"><%=sPromo[i]%></td>
                    <td class="DataTable1"><%=sPFrom[i]%></td>
                    <td class="DataTable1"><%=sPTo[i]%></td>
                    <td class="DataTable1"><a href="javascript:dltPromo('P', '<%=sPromo[i]%>', '<%=sPFrom[i]%>', '<%=sPTo[i]%>')">Delete</a></td>
                 </tr>
             <%}%>
             <!----------------------------- Event ------------------------------>
             <tr class="DataTable1">
                <td class="DataTable" colspan="3">Event</td>
                <td class="DataTable1"><a href="javascript:addPromo('E', '', '', '', 'ADD')">Add</a></td>
             </tr>
             <%for(int i=0; i < iNumOfEvent; i++){%>
                 <tr class="DataTable2">
                   <td class="DataTable1"><%=sEvent[i]%></td>
                   <td class="DataTable1"><%=sEFrom[i]%></td>
                   <td class="DataTable1"><%=sETo[i]%></td>
                   <td class="DataTable1"><a href="javascript:dltPromo('E', '<%=sEvent[i]%>', '<%=sEFrom[i]%>', '<%=sETo[i]%>')">Delete</a></td>
                 </tr>
             <%}%>
             <!------------------------- Non-Event ----------------------------->
             <tr class="DataTable1">
                <td class="DataTable" colspan="3">Non-Event</td>
                <td class="DataTable1"><a href="javascript:addPromo('N', '', '', '', 'ADD')">Add</a></td>
             </tr>
             <%for(int i=0; i < iNumOfNonEvt; i++){%>
                  <tr class="DataTable2">
                    <td class="DataTable1"><%=sNonEvt[i]%></td>
                    <td class="DataTable1"><%=sNFrom[i]%></td>
                    <td class="DataTable1"><%=sNTo[i]%></td>
                   <td class="DataTable1"><a href="javascript:dltPromo('N', '<%=sNonEvt[i]%>', '<%=sNFrom[i]%>', '<%=sNTo[i]%>')">Delete</a></td>
                  </tr>
             <%}%>
             <!------------------------- Media Commitments---------------------->
             <tr class="DataTable1"><td class="DataTable" colspan="5">Media Commitments</td></tr>
             <%for(int i=0; i < iNumOfMedCom; i++){%>
                 <tr class="DataTable2">
                   <td class="DataTable1"><%=sMedCom[i]%></td>
                   <td class="DataTable1"><%=sMFrom[i]%></td>
                   <td class="DataTable1"><%=sMTo[i]%></td>
                   <td class="DataTable1">&nbsp;</td>
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