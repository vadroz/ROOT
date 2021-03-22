<%@ page import="rciutility.StoreSelect, java.util.*"%>
<%
   String sStrAllowed = null;

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   String sUser = null;

   //----------------------------------
   // Application Authorization
   //----------------------------------
   String sAppl = "LABOR";
   if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null
   && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     response.sendRedirect("SignOn1.jsp?TARGET=StrTmcLstSel.jsp&APPL=" + sAppl);
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

     int iStrAlwLst = 0;
     while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

     if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
     else StrSelect = new StoreSelect(new String[]{sStrAllowed});
    }

    sStr = StrSelect.getStrNum();
    sStrName = StrSelect.getStrName();
   }
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  table.DataTable { border: gray solid 1px;background: #LemonChiffon; text-align:center;}
  th.DataTable { padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;background:#FFE4C4;border-right: darkred solid 1px;text-align:center; font-family:Arial; font-size:10px }
  td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px; }
  td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
  td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }

  div.Menu { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px; background-color: LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
  tr.Grid1 { text-align:center; font-family:Arial; font-size:10px;}
  td.Grid  { background:darkblue; color:white; text-align:center;
             font-family:Arial; font-size:11px; font-weight:bolder}
  td.Grid2  { background:darkblue; color:white; text-align:right;
              font-family:Arial; font-size:11px; font-weight:bolder}
  .small{ text-align:left; font-family:Arial; font-size:10px;}
</style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript">
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];
var StrAllowed = "<%=sStrAllowed%>";
var User = "<%=sUser%>";
//==============================================================================
// initial processes
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
	
  	doStrSelect();
  	setWeekSel();
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id) {
    var df = document.all;

    // allow store 100 to enter event (Karl Salz, Mike Parker, Kelly)
    stores[stores.length] = "100";
    storeNames[storeNames.length] = "Special Events Only";

    for (idx = 1; idx < stores.length; idx++)
    {
      df.STORE.options[idx-1] = new Option(stores[idx] + " - " + storeNames[idx],stores[idx]);
    }
    document.all.STORE.selectedIndex=0;
}
//==============================================================================
// set week for selection
//==============================================================================
function setWeekSel()
{
   var date = new Date();
   date.setHours(18);
   var day = date.getDay();
   if (day != 0)
   {
      date = new Date(date.getTime() - 86400000 * (day - 7))
   }

   var week = document.all.Week;
   for(var i=0; i < 10; i++)
   {
      var usaDate = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
      week.options[i] = new Option(usaDate, usaDate)
      date = new Date(date.getTime() - 86400000 * 7)
   }
}
//==============================================================================
// submit application
//==============================================================================
function submitApplication()
{
   var str = document.all.STORE.options[document.all.STORE.selectedIndex].value
   var strname = document.all.STORE.options[document.all.STORE.selectedIndex].text
   var week = document.all.Week.options[document.all.Week.selectedIndex].value
   var cwflag = document.all.Week.selectedIndex == 0;

   var url = "StrTmcLst.jsp?Store=" + str
           + "&StrName=" + strname
           + "&Week=" + week
           + "&Currwk=" + cwflag

   //alert(url);
   window.location.href=url;
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
       <br>Employee Training/Meeting/Clinic Entry - Selection</b><br>
       <a href="/"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font><br><br>

      <table>
      <tr>
         <td>Select Store:</td><td><SELECT name="STORE"></SELECT></td>
      <tr>
      <tr>
         <td>Weekending Date:</td><td><SELECT name="Week"></SELECT></td>
      <tr>
         <td align="center" colspan=2>
         <button onclick="submitApplication()">Submit</button>
      </tr>
      </table>
                </td>
            </tr>
       </table>

        </body>
      </html>
