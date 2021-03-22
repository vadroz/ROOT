<%@ page import="rciutility.StoreSelect, java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=ScanCycleCountSel.jsp&APPL=ALL");
}
else
{
    StoreSelect StrSelect = null;
    String sStr = null;
    String sStrName = null;
    String sStrCtn = null;

    String sStrAllowed = session.getAttribute("STORE").toString();
    String sUser = session.getAttribute("USER").toString();

    if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
    {
      StrSelect = new StoreSelect(5);
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
    sStrCtn = StrSelect.getStrCtn();
%>

<style>
  .Small {font-family: times; font-size:10px }
  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top}
  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
        width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<script name="javascript">
var Stores = [<%=sStr%>]
var StoreNames = [<%=sStrName%>]
var StrCtn = [<%=sStrCtn%>]
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  doIstStrSelect();
}
//==============================================================================
// Load Issuing Stores
//==============================================================================
function doIstStrSelect()
{
   var str = document.all.Store;

   for (i = 1; i < Stores.length; i++)
   {
     str.options[i-1] = new Option(Stores[i] + " - " + StoreNames[i],Stores[i]);
   }
   str.selectedIndex=0;
}
//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = " ";
  var str = document.all.Store.options[document.all.Store.selectedIndex].value

  if (error) alert(msg);
  else{ sbmItmScan(str) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmItmScan(str)
{
  var url = null;
  url = "ScanCycleCount.jsp?Store=" + str

  //alert(url)
  window.location.href=url;
}

</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<HTML><HEAD><meta http-equiv="refresh">

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();" style="text-align:center">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->

<table border="0" width="100%" height="100%">
     <tr>
      <td height="20%" COLSPAN="2">
        <img src="Sun_ski_logo4.png" /></td>
     </tr>
     <tr bgColor="moccasin">
      <td ALIGN="center" VALIGN="TOP">
       <b>Retail Concepts, Inc
       <br>Select Store For Cycle Count Inquiry</b><br>

      <table>
      <!-- ================================================================= -->
      <tr>
         <td>Store:</td><td><SELECT name="Store" class="Small"></SELECT></td>
      <tr>
      <tr>
        <td colspan=2  ALIGN="center">
          <button name="submit" onClick="Validate()">Submit</button>
        </td>
      </table>
                </td>
            </tr>
       </table>

</BODY></HTML>
<%}%>







