<%@ page import="rciutility.StoreSelect"%>
<% StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   String sStore = request.getParameter("Store");
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


function bodyLoad(){
  doStrSelect();
}
// Load Stores
function doStrSelect(id) {
    var df = document.forms[0];
    var stores = [<%=sStr%>];
    var storeNames = [<%=sStrName%>];

    for (idx = 1; idx < stores.length; idx++)
                df.STORE.options[idx-1] = new Option(storeNames[idx],stores[idx]);
}
// change action on submit
function submitForm(){
   var SbmString = "AvgPayRep.jsp";
    SbmString = SbmString + "?STORE="
              + document.getStore.STORE.options[document.getStore.STORE.selectedIndex].value
              + "&STRNAME="
              + document.getStore.STORE.options[document.getStore.STORE.selectedIndex].text
    //alert(SbmString);
    window.location.href=SbmString;
}
</SCRIPT>
          </head>
 <body  onload="bodyLoad();">

         <div id="tooltip2" style="position:absolute;visibility:hidden; background-attachment: scroll;
              border: black solid 1px; width:150px;background-color:LemonChiffon; z-index:10"></div>
         <div align="CENTER" name="divTest" onMouseover="showtip2(this,event,' ');" onMouseout="hidetip2();" STYLE="cursor: hand">
         </div>

           <table border="0" width="100%" height="100%">
            <tr>
            <td height="20%" COLSPAN="2">
              <img src="Sun_ski_logo4.png" /></td>
             </tr>
             <tr bgColor="moccasin">
       <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>Average Pay Report</b><br>

      <form name="getStore" action="javascript:submitForm()">
      Select Store: <SELECT name="STORE"></SELECT>
      <input type="submit" value="GO">
      </form>
                </td>
            </tr>
       </table>

        </body>
      </html>
