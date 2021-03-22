<%@ page import="rciutility.StoreSelect, payrollreports.SetWeeks"%>
<%
   String sStrAllowed = null;
   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;
   String  sWeeksJSA = null;
   String  sMonthBegJSA = null;

   // --------- signon ------------------------
   String sAppl = "PAYROLL";
   if (session.getAttribute("USER")==null
    || session.getAttribute("APPLICATION") !=null
    && !session.getAttribute("APPLICATION").equals(sAppl))
   {
     response.sendRedirect("PayrollSignOn.jsp?TARGET=ScoreSel.jsp&APPL=" + sAppl);
   }
   // -------------------------------------------
   else {
     sStrAllowed = session.getAttribute("STORE").toString();

     if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
     {
       StrSelect = new StoreSelect(4);
     }
     else
     {
       StrSelect = new StoreSelect(sStrAllowed);
     }
     sStr = StrSelect.getStrNum();
     sStrName = StrSelect.getStrName();

     SetWeeks SetWk = new SetWeeks("11WK");
     sWeeksJSA = SetWk.getWeeksJSA();
     sMonthBegJSA = SetWk.getMonthBegJSA();
     SetWk.disconnect();
   }
%>

<html>
<head>
<SCRIPT language="JavaScript">
		document.write("<style>body {background:ivory;}");
                document.write("a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}" );
                document.write("table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}");
                document.write("th.DataTable { padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;background:#FFE4C4;border-right: darkred solid 1px;text-align:center; font-family:Arial; font-size:10px }");
                document.write("td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px; }");
		document.write("td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }");
                document.write("td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }");
		document.write("</style>");


var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];
var Weeks = [<%=sWeeksJSA%>];
var MonthBeg = [<%=sMonthBegJSA%>];
var StrAllowed = "<%=sStrAllowed%>";

//==============================================================================
// initialize process
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

    for (idx = 1; idx < stores.length; idx++)
                df.STORE.options[idx-1] = new Option(stores[idx] + "-" + storeNames[idx],stores[idx]);
    document.getStore.STORE.selectedIndex=0;
}
//==============================================================================
// Weeks Stores
//==============================================================================
function doWeekSelect(id) {
    var df = document.forms[0];
    for (idx = 0; idx < Weeks.length; idx++)
         df.WEEK.options[idx] =
            new Option(Weeks[idx], Weeks[idx]);
    document.getStore.WEEK.selectedIndex=5;
}

//==============================================================================
// change action on submit
//==============================================================================
function submitForm(){
   var SbmString;
   var strIdx = document.getStore.STORE.selectedIndex;
   var selStore = document.getStore.STORE.options[strIdx].value;
   var selStoreName = document.getStore.STORE.options[strIdx].text;
   var wkIdx = document.getStore.WEEK.selectedIndex;
   var selWeek = document.getStore.WEEK.options[wkIdx].value;
   var selMonth = MonthBeg[wkIdx];

   SbmString = "Scoring.jsp"
        + "?STORE=" + selStore
        + "&STRNAME=" + selStoreName
        + "&MONBEG=" + selMonth
        + "&WEEKEND=" + selWeek;

    //alert(SbmString);
    window.location.href=SbmString;
}
</SCRIPT>
          </head>
 <body  onload="bodyLoad();">
  <table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2">
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Select Week for Weekly Scoring<br>
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
         <td colspan="2" align="center"><input type="submit" value="Submit"></td>
      </tr>
      </table>
      </form>
                </td>
            </tr>
       </table>

        </body>
      </html>
