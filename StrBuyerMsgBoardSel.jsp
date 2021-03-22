<%@ page import="rciutility.StoreSelect"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=StrBuyerMsgBoardSel.jsp&APPL=ALL");
}
else
{
   String sStrAllowed = null;

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;


    StrSelect = new StoreSelect();

    sStr = StrSelect.getStrNum();
    sStrName = StrSelect.getStrName();
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
var StrAllowed = "<%=sStrAllowed%>";
//==============================================================================
// initialize screen on load
//==============================================================================
function bodyLoad()
{
  doStrSelect();
  doWeekendSelect();
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id) {
    var df = document.forms[0];

    for (idx = 1; idx < stores.length; idx++)
    {
      df.Store.options[idx-1] = new Option(stores[idx] + " - " + storeNames[idx],
                                           stores[idx]);
    }
    document.getStore.Store.selectedIndex=0;
}
//==============================================================================
// load weekends
//==============================================================================
function doWeekendSelect() {
    var df = document.forms[0];
    var date = new Date();
    date.setHours(18);

    while(date.getDay() != 0) { date = new Date(date - (-1 * 86400000)); }

    for (var i = 0; i < 20; i++)
    {
      var usadt = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
      df.Weekend.options[i] = new Option(usadt, usadt);
      date = new Date(date - 86400000 * 7);
    }
    document.getStore.Store.selectedIndex=0;
}

//==============================================================================
// change action on submit
//==============================================================================
function submitForm(){
   var SbmString;
   var strIdx = document.getStore.Store.selectedIndex;
   var selStore = document.getStore.Store.options[strIdx].value;
   var selStoreName = storeNames[strIdx+1];

   var wkendIdx = document.getStore.Weekend.selectedIndex;
   var selWkend = document.getStore.Weekend.options[wkendIdx].value;

   SbmString = "StrBuyerMsgBoard.jsp"
        + "?Store=" + selStore
        + "&StrName=" + selStoreName
        + "&Weekend=" + selWkend;

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
       <br>Store Managers / Buyers Message Board<br>

      <form name="getStore" action="javascript:submitForm()">
      <table>
      <!-- ------------------------------------------------------------------- -->
      <tr>
         <td>Store:</td><td><SELECT name="Store"></SELECT></td>
      <tr>
      <!-- ------------------------------------------------------------------- -->
      <tr>
         <td>Weekend:</td><td><SELECT name="Weekend"></SELECT></td>
      <tr>
      <!-- ------------------------------------------------------------------- -->
         <td colspan="2" align="center"><input type="submit" value="Submit"></td>
      </tr>
      </table>
      </form>
      <p><a href="../"><font color="red">Home</font></a>&#62;
                </td>
            </tr>
       </table>

        </body>
      </html>
<%}%>