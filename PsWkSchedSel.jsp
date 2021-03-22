<%@ page import="rciutility.StoreSelect, payrollreports.SetWeeks,  java.util.*"%>
<%
   String sStrAllowed = null;

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   String  sWeeksJSA = null;
   int iNumOfWeeks = 0;
   String  sMonthBegJSA = null;
   String  sBaseWkJSA = null;
   String  sBsWkNameJSA = null;
   String sBsMonBegJSA = null;
   SetWeeks SetWk = null;

   String sUser = null;
   int iStrAlwLst = 0;

   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PsWkSchedSel.jsp");
   }
   else {
     sStrAllowed = session.getAttribute("STORE").toString();
     sUser = session.getAttribute("USER").toString();

    if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
    {
      StrSelect = new StoreSelect(4);
    }
    else
    {
     Vector vStr = (Vector) session.getAttribute("STRLST");
     String [] sStrAlwLst = new String[ vStr.size()];
     Iterator iter = vStr.iterator();

     while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

     if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
     else StrSelect = new StoreSelect(new String[]{sStrAllowed});
    }

    sStr = StrSelect.getStrNum();
    sStrName = StrSelect.getStrName();

    SetWk = new SetWeeks("11WK");
    sWeeksJSA = SetWk.getWeeksJSA();
    iNumOfWeeks = SetWk.getNumOfWeeks();
    sMonthBegJSA = SetWk.getMonthBegJSA();
    sBaseWkJSA = SetWk.getBaseWkJSA();
    sBsWkNameJSA = SetWk.getBsWkNameJSA();
    sBsMonBegJSA = SetWk.getBsMonBegJSA();

    SetWk.disconnect();
   }
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
  th.DataTable { padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;background:#FFE4C4;border-right: darkred solid 1px;text-align:center; font-family:Arial; font-size:10px }
  td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px; }
  td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
  td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }

  div.Menu { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
  tr.Grid1 { text-align:center; font-family:Arial; font-size:10px;}
  td.Grid  { background:darkblue; color:white; text-align:center;
             font-family:Arial; font-size:11px; font-weight:bolder}
  td.Grid2  { background:darkblue; color:white; text-align:right;
              font-family:Arial; font-size:11px; font-weight:bolder}
  .small{ text-align:left; font-family:Arial; font-size:10px;}
</style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<SCRIPT language="JavaScript">
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];
var Weeks = [<%=sWeeksJSA%>];
var MonthBeg = [<%=sMonthBegJSA%>];
var BaseWk = [<%=sBaseWkJSA%>];
var BsMonBeg = [<%=sBsMonBegJSA%>]
var BsWkName = [<%=sBsWkNameJSA%>];
var NumBase = <%=iNumOfWeeks%>
var StrAllowed = "<%=sStrAllowed%>";
var User = "<%=sUser%>";
var NumOfStrAllw = '<%=iStrAlwLst%>';
//==============================================================================
// initial processes
//==============================================================================
function bodyLoad(){
  doStrSelect();
  doWeekSelect();
  document.forms[0].WEEK.disabled=false;
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id) {
    var df = document.forms[0];

    // allow store 100 to enter event (Karl Salz, Mike Parker, Kelly)
    if (NumOfStrAllw = 1 && StrAllowed != "ALL") {
        stores[stores.length] = "75";
        storeNames[storeNames.length] = "Special Events Only";
    }

    for (idx = 1; idx < stores.length; idx++)
    {
      df.STORE.options[idx-1] = new Option(stores[idx] + " - " + storeNames[idx],stores[idx]);
    }
    document.getStore.STORE.selectedIndex=0;
}
//==============================================================================
// Weeks Stores
//==============================================================================
function doWeekSelect(id) {
    var df = document.forms[0];
    var idx = 0;
    for (idx = 0; idx < Weeks.length; idx++)
    {
      df.WEEK.options[idx] =
            new Option(Weeks[idx], Weeks[idx]);
      document.getStore.WEEK.selectedIndex=15;
    }

    var max = <%if(sUser.equals("mparker") || sUser.equals("vrozen")){%> NumBase; <%} else {%>4<%}%>
    for (idy=0; idy < max; idy++, idx++)
    {
      df.WEEK.options[idx] =
            new Option(BsWkName[idy], BaseWk[idy]);
    }
}

//==============================================================================
// change action on submit
//==============================================================================
function submitForm(){
   var SbmString;
   var strIdx = document.getStore.STORE.selectedIndex;
   var selStore = document.getStore.STORE.options[strIdx].value;
   var selStoreName = storeNames[strIdx+1];
   var wkIdx = document.getStore.WEEK.selectedIndex;
   var selWeek = document.getStore.WEEK.options[wkIdx].value;
   if (wkIdx < MonthBeg.length)
   {
      var selMonth = MonthBeg[wkIdx];
   }
   else
   {
     selMonth = BsMonBeg[wkIdx - MonthBeg.length];
   }


   SbmString = "PsWkSched.jsp"
        + "?STORE=" + selStore
        + "&STRNAME=" + selStoreName
        + "&MONBEG=" + selMonth
        + "&WEEKEND=" + selWeek;

    //alert(SbmString);
    window.location.href=SbmString;
}

//--------------------------------------------------------------------
// build panel to specified new date
//--------------------------------------------------------------------
function getOldDate()
{
   var menuHtml = "<table cellPadding='0' cellSpacing='0' width='100%'>"
         + "<tr align='center'>"
         + "<td class='Grid'>Type another date</td>"
         + "<td  class='Grid'>"
         + "<img src='CloseButton.bmp' onclick='javascript:hideMenu();' alt='Close'>"
         + "</td></tr>"
         + "<tr><td align='center' colspan=2>"
         + "<input class='small' name='selDate' maxlength='10' size='10'>&nbsp;&nbsp;"
         + "<a href='javascript:showCalendar(1, null, null, 300, 300, document.all.selDate)'>"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a>"
         + "</td></tr>"
         + "<tr align='center'><td colspan=2>"
         + "<button class='small' name='getDate' onclick='getWeekend()'>Get</button>"
         + "&nbsp;&nbsp;<button class='small' name='close' onclick='hideMenu()'>Close</button><br>&nbsp;</td></tr>"
         + "</table>"

   document.all.menu.innerHTML=menuHtml
   document.all.menu.style.pixelLeft=320
   document.all.menu.style.pixelTop=document.documentElement.scrollTop+130
   document.all.menu.style.visibility="visible"
}

//--------------------------------------------------------------------
// run another jsp to get a date
//--------------------------------------------------------------------
function getWeekend()
{
  var date = document.all.selDate.value

  if (date == null || (new Date(date)) == "NaN")
  {
    alert("Please, enter new Weekending date")
  }
  else {
    var good = new Date(date)
    if(good.getDay() !=0 ) alert("Selected date is not a Sunday")
    else {
      document.getStore.WEEK.options[0] = new Option(date, date);
      document.getStore.WEEK.selectedIndex=0;
      hideMenu();
    }
  }
}
//----------------------------------------------------------------------
// close employee selection window
//----------------------------------------------------------------------
function hideMenu(){
    document.all.menu.style.visibility="hidden"
}

</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

</head>
<body  onload="bodyLoad();">

 <!-------------------------------------------------------------------->
<iframe
  id="frame1"
  src=""
  frameborder=0 height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
<div id="menu" class="Menu"></div>
<!--div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>
<!-------------------------------------------------------------------->

  <table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2">
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Select Week for Weekly Labor Scheduler<br>
       <br>Select Store and Week Ending</b><br>

      <form name="getStore" action="javascript:submitForm()">
      <table>
      <tr>
         <td>Select Store:</td><td><SELECT name="STORE"></SELECT></td>
      <tr>
        <td>Select Weekending:</td><td><SELECT name="WEEK">
            </SELECT></td>
      </tr>
      <tr>
         <td align="center" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <input type="submit" value="Submit">&nbsp;&nbsp;&nbsp;&nbsp;
         <button name="GetDate" onClick="getOldDate()">Prior Week Ending</button></td  >
      </tr>
      </table>
      </form>
                </td>
            </tr>
       </table>

        </body>
      </html>
