<%@ page import="rciutility.StoreSelect, payrollreports.SetWeeks"%>
<%
   // Authenticate user
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=SlsbyWkSel.jsp&APPL=ALL");
   }


   // get store list
   StoreSelect StrSelect = new StoreSelect(4);
   String sStr = StrSelect.getStrNum();
   String sStrName = StrSelect.getStrName();

   // get list of week
   SetWeeks SetWk = new SetWeeks("11WK");
   String sWeeksJSA = SetWk.getWeeksJSA();
   int iNumOfWeeks = SetWk.getNumOfWeeks();
   String sMonthBegJSA = SetWk.getMonthBegJSA();
   String sBaseWkJSA = SetWk.getBaseWkJSA();
   String sBsWkNameJSA = SetWk.getBsWkNameJSA();
   String sBsMonBegJSA = SetWk.getBsMonBegJSA();

   SetWk.disconnect();
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
var BaseWk = [<%=sBaseWkJSA%>];
var BsMonBeg = [<%=sBsMonBegJSA%>]
var BsWkName = [<%=sBsWkNameJSA%>];
var NumBase = <%=iNumOfWeeks%>

function bodyLoad(){
  doStrSelect();
  doWeekSelect();
  document.forms[0].WEEK.disabled=false;
  doYearSelect();
}

// Load Stores
function doStrSelect(id) {
    var df = document.forms[0];

    for (idx = 1; idx < stores.length; idx++)
                df.STORE.options[idx-1] = new Option(stores[idx] + " - " + storeNames[idx],stores[idx]);
    document.getStore.STORE.selectedIndex=0;
}

// Weeks Stores
function doWeekSelect(id) {
    var df = document.forms[0];
    var idx = 0;
    for (idx = 0; idx < Weeks.length; idx++)
    {
      df.WEEK.options[idx] =
            new Option(Weeks[idx], Weeks[idx]);
      document.getStore.WEEK.selectedIndex=5;
    }

    for (idy=0; idy < NumBase; idy++, idx++)
    {
      df.WEEK.options[idx] =
            new Option(BsWkName[idy], BaseWk[idy]);
    }
}

// Year selection
function doYearSelect()
{
   var date = new Date();
   var year = date.getFullYear() + 1;
   for(i=0; i < 3; i++)
   {
     document.getStore.YEAR.options[i] = new Option(year-i,year-i);
   }
}


// change action on submit
function submitForm(){
   var SbmString;
   var strIdx = document.getStore.STORE.selectedIndex;
   var selStore = document.getStore.STORE.options[strIdx].value;
   var selStoreName = storeNames[strIdx+1];
   var wkIdx = document.getStore.WEEK.selectedIndex;
   var selWeek = document.getStore.WEEK.options[wkIdx].value;
   var yrIdx = document.getStore.YEAR.selectedIndex;
   var selYear = document.getStore.YEAR.options[yrIdx].value;

   if (wkIdx < MonthBeg.length)
   {
      var selMonth = MonthBeg[wkIdx];
   }
   else
   {
     selMonth = BsMonBeg[wkIdx - MonthBeg.length];
   }


   SbmString = "SlsbyWkDay.jsp"
        + "?STORE=" + selStore
        + "&STRNAME=" + selStoreName
        + "&MONBEG=" + selMonth
        + "&WEEKEND=" + selWeek
        + "&YEAR=" + selYear;
   

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
       <br>Sales Distribution By Hour<br>
       <br>Select Store and Week Ending</b><br>

      <form name="getStore" action="javascript:submitForm()">
      <table>
      <tr>
         <td>Select Store:</td><td><SELECT name="STORE"></SELECT></td>
      <tr>
        <td>Select Weekending:</td><td><SELECT name="WEEK"></SELECT></td>
      </tr>

      <tr>
        <td>Select Fiscal Year:</td><td><SELECT name="YEAR"></SELECT></td>
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
