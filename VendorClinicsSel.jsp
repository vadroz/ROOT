<%@ page import="rciutility.StoreSelect"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("VENDOR") == null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=VendorClinics.jsp.jsp&APPL=ALL");
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

//==============================================================================
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];
var StrAllowed = "<%=sStrAllowed%>";
//==============================================================================
// initializing
//==============================================================================
function bodyLoad()
{
  doStrSelect();
  // populate date with future day
  doSelDate();
}
//==============================================================================
// populate date with future day
//==============================================================================
function  doSelDate()
{
  var date = new Date(new Date() - (-1 * 86400000));
  var Month = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
  var mon = date.getMonth();
  var year = date.getFullYear();

  for(var i=0; i < 7; i++)
  {
     if(mon < 12){ document.all.Month.options[i] = new Option(Month[mon], (mon+1) + "/" + year ); }
     else { document.all.Month.options[i] = new Option(Month[mon-12], (mon-11) + "/" + (year+1)); }
     mon++;
  }
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id)
{
    var df = document.forms[0];

    for (idx = 1; idx < stores.length; idx++)
    {
      df.Store.options[idx-1] = new Option(stores[idx] + " - " + storeNames[idx],
                                           stores[idx]);
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

   var mon = document.all.Month.options[document.all.Month.selectedIndex].value;

   SbmString = "VendorClinics.jsp"
        + "?Store=" + selStore
        + "&StrName=" + selStoreName
        + "&MonYr=" + mon

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
       <br>Store/Employee Test Results<br>


      <!-- =========================== Form ==================================== -->
      <form name="getStore" action="javascript:submitForm()">
         <a href="../"><font color="red" size="-1">Home</font></a>&#62
         <font size="-1">This page</font>
      <table>
      <!-- ======================== Store ====================================== -->
      <tr>
         <td>Select Store:</td><td><SELECT name="Store"></SELECT></td>
         <td colspan="2" align="center"></td>
      </tr>

      <!-- ======================== Date ======================================= -->
        <TR>
          <TD class=DTb1 align=right >Select Month:</TD>
          <TD><select name="Month" type="text"><select>
          </TD>
        </TR>
        <!-- ======================== Date ======================================= -->
        <TR>
          <TD class=DTb1 align=center>&nbsp;</td>
          <td><input type="submit" value="Submit"></TD>
        </TR>
      <!-- ==========================++++++===================================== -->
      </table>
      </form>
                </td>
            </tr>
       </table>

        </body>
      </html>
<%}%>