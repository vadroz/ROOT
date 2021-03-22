<%@ page import="patiosales.PfOrdDeliveryCal ,java.util.*, java.text.*"%>
<%
   String [] sSelStr = request.getParameterValues("Store");
   String sDate = request.getParameter("Date");
   String sRtnDt = request.getParameter("RtnDt");

   SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
   Calendar cal = Calendar.getInstance();
   if (sDate == null)
   {
      if(cal.get(Calendar.DAY_OF_WEEK) != 2)
      {
         for(int i=0; i < 7; i++)
         {
            cal.add(Calendar.DATE, -1);
            if (cal.get(Calendar.DAY_OF_WEEK) == 2){ break; }
         }
      }
      sDate = sdf.format(cal.getTime());
   }

   if(sRtnDt == null){sRtnDt = "N";}

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PfOrdDeliveryCal.jsp&APPL=ALL&" + request.getQueryString());
   }
   else
   {
      String sUser = session.getAttribute("USER").toString();

      String [] sWeek = new String[]{"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
      String [] sMonth = new String[]{"January","February","March","April", "May", "June", "July", "August", "September", "October", "November", "December"};

      String sStrAllowed = session.getAttribute("STORE").toString();

      if (sStrAllowed != null && (sStrAllowed.startsWith("ALL")))
      {
         if (sSelStr == null) { sSelStr = new String[]{"35", "46", "50", "86", "63", "64", "68"}; }
      }
      else
      {
         if (sSelStr == null) { sSelStr = new String[]{sStrAllowed}; }
      }

      PfOrdDeliveryCal delivcal = new PfOrdDeliveryCal(sSelStr, sDate, sUser);
      String [] sCalendar = delivcal.getCalendar();
      String [] sWkDay = delivcal.getWkDay();
      String [] sDlyNumOfDlv = delivcal.getDlyNumOfDlv();
      String [] sCloseDate = delivcal.getCloseDate();
      int iNumOfCal = delivcal.getNumOfCal();

      // region for close date
      int iReg = 0;
      int [][] iRegArr = new int[][]{ new int[]{35,46,50}, new int[]{86}, new int[]{63,64,68}};

      boolean bAlwCloseDt = true;
      for(int i=0; i < iRegArr.length; i++)
      {
          for(int j=0; j < iRegArr[i].length; j++)
          {
             for(int k=0; k < sSelStr.length; k++)
             {
                if(iRegArr[i][j] == Integer.parseInt(sSelStr[k]))
                {
                   // if more than 1 store group used - do not allow close date
                   if(iReg > 0 && i+1 != iReg){bAlwCloseDt = false;}
                   iReg = i+1;
                   break;
                }
             }
          }
      }

%>
<html>
<head>

<style>body { text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        
        table.tbl01 { border:none; background-color:LemonChiffon; padding: 0px; border-spacing: 0; border-collapse: collapse; width:100%}
 		table.tbl02 { border: lightblue ridge 2px; margin-left: auto; margin-right: auto; 
         padding: 0px; border-spacing: 0; border-collapse: collapse; }
         
        table.DataTable { text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda;}
        th.DataTable1 { background:#ccffcc;padding-top:3px; padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda;}
        th.DataTable2 { background:salmon;padding-top:3px; padding-top:3px; padding-bottom:3px;
                       padding-left:3px; padding-right:3px;
                       text-align:center; font-family:Verdanda; }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:12px }
        tr.DataTable1 { background:#ccffcc; font-family:Arial; font-size:12px }
        tr.DataTable2 { background:cornsilk; font-family:Arial; font-size:16px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                        padding-right:3px; text-align:right;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; vertical-align:text-top;
                       padding-right:3px; text-align:center;}
        td.DataTable21 { background: pink; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center;}

        div.dvSelect { position:absolute; background-attachment: scroll;
              border: black solid 1px; width:175; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}

        div.dvDelDate { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:175; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}

        td.BoxName {cursor:move; background: #016aab;
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background: #016aab;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
  .Small { font-size:10px;}

</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------

var ArrStr = ["35", "46", "50", "86", "63", "64", "68"]
var ArrSelStr = [<%=delivcal.cvtToJavaScriptArray(sSelStr)%>];

var CellSts = new Array();
var CellSoSts = new Array();
var CellPick = new Array();

var ArrOrd = new Array();
var ArrOrdDt = new Array();
var ArrOrdSts = new Array();
var ArrPySts = new Array();
//--------------- End of Global variables ----------------
//==============================================================================
// Initial process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	
  	window.focus();
   	// set Weekly Selection Panel
  	setSelectPanelShort();
  	setBoxclasses(["BoxName",  "BoxClose"], ["dvDelDate"]);
}
//==============================================================================
// set Short form of select parameters
//==============================================================================
function setSelectPanelShort()
{
   var hdr = "Select Report Parameters";

   var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='RestoreButton.bmp' onclick='javascript:setSelectPanel();' alt='Restore'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"
   html += "</td></tr></table>"
   document.all.dvSelect.innerHTML=html;
   document.all.dvSelect.style.pixelLeft= 10;
   document.all.dvSelect.style.pixelTop= 10;
}
//==============================================================================
// set Weekly Selection Panel
//==============================================================================
function setSelectPanel()
{
  var hdr = "Select Report Parameters";

  var html = "<table class='tbl01'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='MinimizeButton.bmp' onclick='javascript:setSelectPanelShort();' alt='Minimize'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popSelWk()

   html += "</td></tr></table>"
   document.all.dvSelect.innerHTML=html;

   document.all.DelDate.value = "<%=sDate%>";

   var str = document.all.Str;
   for(var i=0; i < str.length; i++)
   {
      for(var j=0; j < ArrStr.length; j++)
      {
         if(str[i].value == ArrSelStr[j]){ str[i].checked = true;}
         else{ str[i].checked == false; }
      }
   }
}

//==============================================================================
// populate Column Panel
//==============================================================================
function popSelWk()
{
  var panel = "<table class='tbl02'>"
    + "<tr>"
       + "<td class='Prompt1' colspan=3><u>Stores</u></td>"
     + "</tr>"
     + "<tr>"
       + "<td class='Prompt1' colspan=3>"
          + "<table border=0>"
              + "<tr>"

  for(var i=0, j=0; i < ArrStr.length; i++, j++)
  {
     if(j > 0 && j % 11 == 0){ panel += "<tr>"}
     panel += "<td class='Small' nowrap>"
          + "<input type='checkbox' class='Small' name='Str' value='" + ArrStr[i] + "'>" + ArrStr[i]
        + "</td>"
  }

  panel += "</table>"
          + "<button onclick='checkAll(&#34;ALL&#34;)' class='Small'>Check All</button> &nbsp; &nbsp;"
          + "<button onclick='checkAll(&#34;DC&#34;)' class='Small'>DC</button> &nbsp; &nbsp;"
          + "<button onclick='checkAll(&#34;NY&#34;)' class='Small'>NY</button> &nbsp; &nbsp;"
          + "<button onclick='checkAll(&#34;NE&#34;)' class='Small'>NE</button> &nbsp; &nbsp;"
          + "<button onclick='checkAll(&#34;CLEAR&#34;)' class='Small'>Reset</button>"
       + "</td>"
     + "</tr>"

     + "<tr id='trDt1'  style='background:azure'>"
        + "<td class='Prompt1' colspan=3><u>Date Selection</u>&nbsp</td>"
     + "</tr>"

    + "<tr id='trDt2' style='background:azure'>"
       + "<td class='Prompt' id='td2Dates' width='30px'>Beginning Date:</td>"
       + "<td class='Prompt' id='td2Dates'>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;DelDate&#34;)'>&#60;</button>"
          + "<input name='DelDate' class='Small' size='10' readonly>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;DelDate&#34;)'>&#62;</button>"
       + "</td>"
       + "<td class='Prompt' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 420, 10, document.all.DelDate)'>"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
    + "</tr>"

  panel += "<tr><td class='Prompt1' colspan=3>"
        + "<button onClick='Validate()' class='Small'>Submit</button> &nbsp;"
        + "<button onClick='setSelectPanelShort();' class='Small'>Close</button>&nbsp;</td></tr>"

  panel += "</table>";

  return panel;
}

//==============================================================================
// validate entries
//==============================================================================
function  Validate()
{
  var error = false;
  var msg = "";

  var date = document.all.DelDate.value.trim();

  var str = new Array();
  var strsel = false;

  var strobj = document.all.Str;
  for(var i=0; i < strobj.length; i++)
  {
     if(strobj[i].checked){strsel = true; str[str.length] = strobj[i].value; }
  }
  if(!strsel){ error=true; msg += "Select at least 1 store.";}

  if(error){ alert(msg);}
  else{ sbmReport(date, str) }
}
//==============================================================================
// submit report with different parameters
//==============================================================================
function  sbmReport(date, str)
{
   var url = "PfOrdDeliveryCal.jsp?RtnDt=<%=sRtnDt%>&Date=" + date
   //var str = document.all.Store;
   for(var i=0; i < str.length; i++)
   {
      url += "&Store=" + str[i];
   }
   window.location.href = url;
}
//==============================================================================
// check all stores
//==============================================================================
function checkAll(action)
{
  var str = document.all.Str

  for(var i=0; i < str.length; i++)
  {
     if(action == "ALL"){ str[i].checked = true; }
     else if(action == "DC" && (str[i].value=="35" || str[i].value=="46" || str[i].value=="50") ){ str[i].checked = true; }
     else if(action == "NY" && str[i].value=="86"){ str[i].checked = true; }
     else if(action == "NE" && (str[i].value=="63" || str[i].value=="64" || str[i].value=="68")){ str[i].checked = true; }
     else{ str[i].checked = false; }
  }
}

//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, objnm)
{
  var obj = document.all[objnm];
  var date = new Date(obj.value);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  obj.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function showOthDays(dir, dt)
{
  var date = new Date(dt);

  if(dir == "DOWN") date = new Date(new Date(date) - 7 * 86400000);
  else if(dir == "UP") date = new Date(new Date(date) - -7 * 86400000);
  dt = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

  var url = "PfOrdDeliveryCal.jsp?RtnDt=<%=sRtnDt%>&Date=" + dt
  for(var i=0; i < ArrSelStr.length; i++)
  {
     url += "&Store=" + ArrSelStr[i];
  }

  window.location.href = url;
}
//==============================================================================
// set selected statuses
//==============================================================================
function setSelSts(box)
{
   var spnCal = document.all.spnCal;
   var disp = "hidden";

   for(var i=0; i < spnCal.length; i++)
   {
      disp = "hidden";
      if(box.value == "A" || box.value == "R"
          && (CellSts[i] == "S" || CellSts[i] == "Z" || CellSts[i] == "R")){ disp="visible"; }
      spnCal[i].style.visibility = disp;
   }
}
//==============================================================================
//set selected statuses
//==============================================================================
function setCustPick(pick)
{
	 var spnCal = document.all.spnCal;	 
	 var disp = "hidden";
	 if(!pick.checked){ disp = "visible";  }

	 for(var i=0; i < spnCal.length; i++)
	 {	    
	    if(CellPick[i] == "Y"){ spnCal[i].style.visibility = disp; }
	 }
}
//==============================================================================
// cahnge delivery date status - Close / Open
//==============================================================================
function chgDelDateSts(date, cursts)
{
   var sts = "CLOSE";
   if(cursts == "Y"){ sts = "OPEN"; }
   var msg = "Press OK, for NO more deliveries on " + date;
   if(cursts == "Y"){ msg = "Press OK, to allow deliveries on " + date; }

   if(confirm(msg))
   {
      var url = "PfDelDateChgSts.jsp?Action=" + sts
         + "&Reg=<%=iReg%>"
         + "&Date=" + date
      //alert(url)
      window.frame1.location.href=url
   }
}
//==============================================================================
// display error
//==============================================================================
function displayError(err)
{
   window.frame1.location.href="";
   window.frame1.close();
   msg = "";

   for(var i=0; i < err.length; i++)  {  msg += err[i] + "\n"; }
   hidePanel();

   alert(msg);
}
//==============================================================================
// restart
//==============================================================================
function restart()
{
   window.location.reload();
}
//==============================================================================
// return date
//==============================================================================
function rtnDate(deldt)
{
   window.opener.document.all.DelDate.value = deldt;
   window.close();
}
//==============================================================================
// show Multiple delivery tikets
//==============================================================================
function showMultTkt(deldt)
{
   var url = "PfOrderDeliveryMult.jsp?FrDelDt=" + deldt;
   var imax = 0;
   for(var i=0; i < ArrOrd.length; i++)
   {
      if(ArrOrdDt[i] == deldt && ArrPySts[i]!="O"){  url += "&Ord=" + ArrOrd[i]; imax++;}
   }

   if(imax > 0)
   {
      var WindowName = 'Delivery_Tikets';
      var WindowOptions = 'resizable=yes , toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,menubar=yes';
      window.open(url, WindowName, WindowOptions);
   }
   else { alert("There is no order to show."); }
}

//==============================================================================
// show Delivery Date Link
//==============================================================================
function showDelDtMenu(cell, ord, deldt)
{
   var pos = getObjPosition(cell);
   var html = "<a href='javascript: chgDelDate(&#34;" + ord + "&#34;, &#34;" + deldt + "&#34;,&#34;" + pos[0] + "&#34;, &#34;" + pos[1] + "&#34; )'>Change Delivery Date?</a>"

   document.all.dvToolTip.innerHTML = html;
   document.all.dvToolTip.style.pixelLeft= pos[0] + 5;
   document.all.dvToolTip.style.pixelTop= pos[1] + 35;
   document.all.dvToolTip.style.visibility = "visible";

}
//==============================================================================
// change delivery date
//==============================================================================
function chgDelDate(ord, deldt, xPos, yPos)
{
    var hdr = "Changed Delivery Date";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popDelDatePanel(ord, deldt, xPos, yPos)
     + "</td></tr>"
   + "</table>"

   document.all.dvDelDate.innerHTML = html;
   document.all.dvDelDate.style.pixelLeft = xPos - -90;
   document.all.dvDelDate.style.pixelTop = yPos - 20;
   document.all.dvDelDate.style.visibility = "visible";

   document.all.NewDelDate.value = deldt;
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popDelDatePanel(ord, deldt, xPos, yPos)
{
  xPos -= -320;
  yPos -= -10;
  var panel = "<table width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr style='color:blue; background:#ccffcc;font-size:12px;font-weight:bold;text-align:center'>"
         + "<td colspan=3 nowrap>Order Number:</td>"
         + "<td colspan=3 nowrap>" + ord + "</td>"
       + "</tr>"
       + "<tr id='trDt2' style='background:azure'>"
       + "<td class='Prompt' id='td2Dates' width='30px'>New Delivery Date:</td>"
       + "<td class='Prompt' id='td2Dates'>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;NewDelDate&#34;)'>&#60;</button>"
          + "<input name='NewDelDate' class='Small' size='10' readonly>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;NewDelDate&#34;)'>&#62;</button>"
       + "</td>"
       + "<td class='Prompt' id='td2Dates'><a href='javascript:showCalendar(1, null, null, &#34;" + xPos + "&#34;, &#34;" + yPos + "&#34;, document.all.NewDelDate)'>"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
    + "</tr>"

      panel += "<tr><td class='Prompt1' colspan='3'><br><br><button onClick='validDelDate(&#34;" + ord + "&#34;)' class='Small'>Submit</button>&nbsp;"
      + "<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"

     panel += "</table>";
  return panel;
}
//==============================================================================
// hide menu
//==============================================================================
function validDelDate(ord)
{
   var error = false;
   var msg = "";

   deldt = document.all.NewDelDate.value.trim();
   var dldate = new Date(deldt);
   dldate.setHours(18);
   var curdate = new Date();
   curdate.setHours(17);

   if(dldate < curdate){error=true; msg += "Delivery date cannot be changed to passed dates."}

   if (error){ alert(msg)}
   else{ sbmDelDate(ord, deldt)}
}
//==============================================================================
// submit change delivery date
//==============================================================================
function sbmDelDate(ord, deldt)
{
   var url="OrderHdrSave.jsp?Order=" + ord
      + "&DelDate=" + deldt
      + "&Action=CHGORDDELDT"
   //alert(url)
   window.frame1.location.href=url
}
//==============================================================================
// hide menu
//==============================================================================
function hidePanel()
{
   document.all.dvDelDate.style.visibility = "hidden";
}
//==============================================================================
// hide menu
//==============================================================================
function hideMenu()
{
   document.all.dvToolTip.style.visibility = "hidden";
}
//==============================================================================
// restart application after heading entry
//==============================================================================
function reStart()
{
   window.location.reload();
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvSelect" class="dvSelect"></div>
<div id="dvToolTip" class="dvDelDate"></div>
<div id="dvDelDate" class="dvDelDate"></div>
<!-------------------------------------------------------------------->

   <table border="0" cellPadding="0"  cellSpacing="0" >
    <tr>
     <td ALIGN="center" VALIGN="TOP"nowrap>
      <b>Retail Concepts, Inc
      <br>Patio Furniture Sales Order Delivery Calendar
      <br>
         <button class="Small" name="Down" onClick="showOthDays(&#34;DOWN&#34;, &#34;<%=sCalendar[0]%>&#34;)">&#60;</button>
          Delivery Date: <%=sCalendar[0]%> - <%=sCalendar[6]%>
         <button class="Small" name="Up" onClick="showOthDays(&#34;UP&#34;, &#34;<%=sCalendar[0]%>&#34;)">&#62;</button>
      <br>Store(s):
        <% String coma = "";
           for(int i=0; i < sSelStr.length; i++){%><%=coma + sSelStr[i]%><%coma=", ";}%>
           <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>
      </b>
      <table border="0" cellPadding="0"  cellSpacing="0">
        <tr ><th colspan=5>Order Statuses</th>
          <td style="font-size:11px"><input type="radio" name="SelSts" value="A" onclick="setSelSts(this);"  checked>Any Status</td>
          <td style="font-size:11px"><input type="radio" name="SelSts" value="R" onclick="setSelSts(this);">Ready for Staging/Delivery &nbsp; &nbsp;&nbsp;&nbsp;</td>
          <td style="font-size:11px"><input type="checkbox" name="SelCustPick" value="Y" onclick="setCustPick(this);">Exclude Customer Pickup</td>
        </tr>
      </table>
     </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" border=1 cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr  class="DataTable">
         <th class="DataTable" nowrap>&nbsp;</th>
         <th class="DataTable" nowrap colspan=8>Patio Delivery Schedule</th>
       </tr>

       <tr  class="DataTable2">
         <th class="DataTable" nowrap>&nbsp;</th>
         <%for(int i=0; i < 7; i++){%>
            <th class="DataTable<%if(sCloseDate[i].equals("Y")){%>2<%}%>" nowrap>
                <%=sMonth[Integer.parseInt(sCalendar[i].substring(0,2))-1]%>
                <br><%if(sRtnDt.equals("Y")){%>
                       <a href="javascript: rtnDate('<%=sCalendar[i]%>')"><%=sCalendar[i].substring(3,5)%></a>
                    <%} else {%><%=sCalendar[i].substring(3,5)%><%}%>

                <br><a href="javascript: showMultTkt('<%=sCalendar[i]%>')"><%=sWeek[Integer.parseInt(sWkDay[i])]%></a>
            </th>
         <%}%>
         <th class="DataTable" nowrap>&nbsp;</th>
       </tr>

       <tr  class="DataTable">
         <th class="DataTable" nowrap>&nbsp;</th>
         <%for(int i=0; i < 7; i++){%>
            <th class="DataTable<%if(sCloseDate[i].equals("Y")){%>2<%}%>" nowrap>
               <%if(sCloseDate[i].equals("Y")){%>Close<%} else {%>Open<%}%>
               <%if(bAlwCloseDt){%>
                  &nbsp;/&nbsp
                  <a href="javascript: chgDelDateSts('<%=sCalendar[i]%>','<%=sCloseDate[i]%>')" style="font-size:10px"><%if(sCloseDate[i].equals("N")){%>Close<%} else {%>Open<%}%></a>
               <%}%>
            </th>
         <%}%>
         <th class="DataTable" nowrap>Total</th>
       </tr>

       <tr  class="DataTable">
         <th class="DataTable1" nowrap># of<br>Deliveries</th>
         <% int iTotDly = 0;
            for(int i=0; i < 7; i++){
               iTotDly += Integer.parseInt(sDlyNumOfDlv[i]);
            %>
            <th class="DataTable1" style="font-size:20px;" nowrap><%=sDlyNumOfDlv[i]%></th>
         <%}%>
           <th class="DataTable1" style="font-size:20px;" nowrap><%=iTotDly%></th>
       </tr>

      <TBODY>
      <!----------------------- Order List ------------------------>
       <%int [] iItmDay = new int[]{0,0,0,0,0,0,0,0};%>
       <%for(int i=0, j=0, k=1; i < iNumOfCal; i++){
         delivcal.getOrderInfo();
         String sOrder = delivcal.getOrder();
         String sDelDate = delivcal.getDelDate();
         String sCust = delivcal.getCust();
         String sLastNm = delivcal.getLastNm();
         String sFirstNm = delivcal.getFirstNm();
         String sAddr1 = delivcal.getAddr1();
         String sAddr2 = delivcal.getAddr2();
         String sCity = delivcal.getCity();
         String sState = delivcal.getState();
         String sZip = delivcal.getZip();
         String sDayNum = delivcal.getDayNum();
         String sStr = delivcal.getStr();
         String sNumOfItm = delivcal.getNumOfItm();
         String sSts = delivcal.getSts();
         String sPySts = delivcal.getPySts();
         String sPyStsNm = delivcal.getPyStsNm();
         String sCustPick = delivcal.getCustPick();
         String sSoSts = delivcal.getSoSts();
         String sStsNm = delivcal.getStsNm();
         String sSoStsNm = delivcal.getSoStsNm();

         if(!sNumOfItm.equals(""))
         {
           iItmDay[j] += Integer.parseInt(sNumOfItm);
           iItmDay[7] += Integer.parseInt(sNumOfItm);
         }
       %>
       <script>CellSts[CellSts.length] = "<%=sSts%>"; CellSoSts[CellSoSts.length] = "<%=sSoSts%>";
        <%if(!sOrder.equals("")){%>
           ArrOrd[ArrOrd.length] = "<%=sOrder%>";
           ArrOrdDt[ArrOrdDt.length] = "<%=sCalendar[j]%>";
           ArrOrdSts[ArrOrdSts.length] = "<%=sSts%>";
           ArrPySts[ArrPySts.length] = "<%=sPySts%>";
        <%}%>
        CellPick[CellPick.length] = "<%=sCustPick%>"
       </script>

         <%if(j==0){%><tr  class="DataTable"><td class="DataTable2" nowrap><%=k++%></td><%}%>
            <td class="DataTable2"
              <%if(!sOrder.equals("")){%>onmouseover="showDelDtMenu(this, '<%=sOrder%>', '<%=sCalendar[j]%>')"<%}%>
              <%if(sOrder.equals("")){%>onmouseout="hideMenu()"<%}%>>

              <div  id="spnCal" style="<%if(!sOrder.equals("") && (!sPySts.equals("F") && !sPySts.equals("E") || sSts.equals("Q"))){%>background:pink<%}%>">
                <%if(sCustPick.equals("Y")){%>
                   <span style="background:yellow"><b>** Customer Pickup **</b></span><br>
                <%}%> 
                <%if(!sOrder.equals("")){%>
                   <%=sStr%>: <a href="OrderEntry.jsp?Order=<%=sOrder%>" target="_blank"><%=sOrder%></a> - <%=sLastNm%><br>
                   <%=sCity%>, <%=sState%> <%=sZip%>
                   <br><%=sPyStsNm%>
                   <br><b>*<%=sStsNm%>*</b>
                   <br>Qty: <b><%=sNumOfItm%></b>
                   <br><a href="PfOrderDelivery.jsp?Order=<%=sOrder%>" target="_blank">Print</a>
                <%} else {%>&nbsp;<%}%>
              </div>
            </td>
         <%if(j==6){%><td class="DataTable2" nowrap onmouseover="" onmouseout="">&nbsp;</td></tr><%}%>
         <%if(j==6){ j=0; } else { j++; }%>
       <%}%>
       <tr class="DataTable1">
          <td class="DataTable2" nowrap>Total Qty</td>
          <%for(int i=0; i < 8; i++){%>
             <td class="DataTable2" nowrap><%if(iItmDay[i] > 0){%><b><%=iItmDay[i]%></b><%} else {%>&nbsp;<%}%></td>
          <%}%>
       </tr>
      <!---------------------------------------------------------------------->
      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>

  </table>
  <br>
  <span style="background:pink;">Payment Alert</span>:  This order has not been fully paid.
 </body>
</html>
<%
   delivcal.disconnect();
   delivcal = null;
%>
<%}%>