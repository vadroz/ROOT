<%@ page import="rciutility.StoreSelect"%>
<%
   String sStrAllowed = null;

   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;


    StrSelect = new StoreSelect(4);

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

function bodyLoad(){
  doStrSelect();
}

// Load Stores
function doStrSelect(id) {
    var df = document.forms[0];

    for (idx = 1; idx < stores.length; idx++)
    {
      df.STORE.options[idx-1] = new Option(stores[idx] + " - " + storeNames[idx],
                                           stores[idx]);
    }
    document.getStore.STORE.selectedIndex=0;
}


// change action on submit
function submitForm(){
   var SbmString;
   var strIdx = document.getStore.STORE.selectedIndex;
   var selStore = document.getStore.STORE.options[strIdx].value;
   var selStoreName = storeNames[strIdx+1];

   SbmString = "Availability.jsp"
        + "?STORE=" + selStore
        + "&STRNAME=" + selStoreName;

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
       <br>Select Store for Employee Availability<br>
       <br>Select Store</b><br>

      <form name="getStore" action="javascript:submitForm()">
      <table>
      <tr>
         <td>Select Store:</td><td><SELECT name="STORE"></SELECT></td>
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
