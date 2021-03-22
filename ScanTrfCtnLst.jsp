<%@ page import="rciutility.StoreSelect, itemtransfer.ScanTrfCtnLst, java.util.*, java.text.SimpleDateFormat"%>
<%
   String sIssStr = request.getParameter("IssStr");
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=ScanTrfCtnLst.jsp&APPL=ALL");
}
else
{
    String sUser = session.getAttribute("USER").toString();

    ScanTrfCtnLst ctnlist = new ScanTrfCtnLst(sIssStr, sUser);
    int iNumOfCtn = ctnlist.getNumOfCtn();

    int iNumOfErr = ctnlist.getNumOfErr();
    String sError = ctnlist.getErrorJSA();

    StoreSelect StrSelect = null;
    String sStr = null;
    String sStrName = null;
    String sStrAllowed = session.getAttribute("STORE").toString();
    StrSelect = new StoreSelect(9);

    sStr = StrSelect.getStrNum();
    sStrName = StrSelect.getStrName();
%>

<html>
<head>

<style>
  body {background:ivory;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
  th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
   

  tr.DataTable { background:#e7e7e7; font-family:Arial; font-size:10px }
  tr.DataTable1 { background:cornsilk; font-family:Arial; font-size:10px }
  tr.DataTable2 { background:seashell; font-family:Arial; font-size:10px }
  tr.Divider { font-size:3px }

  td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:right;}
  td.DataTable1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:left;}
  td.DataTable2{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:center;}

  td.DataTable21{ background:seashell;padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px; border-right: darkred solid 1px; text-align:center;}

  td.DataTable1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 border-bottom: darkred solid 1px;
                 border-right: darkred solid 1px; text-align:left;}

  table.Help { background:white;text-align:center; font-size:12px;}

  div.Prompt { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:250; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move; background-color: blue; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background-color: blue; color:white; border-bottom: black solid 1px; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left;font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center;font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
   .Small {font-family: times; font-size:10px }
</style>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT language="JavaScript1.2">
var Error = [<%=sError%>];
var Stores = [<%=sStr%>]
var StoreNames = [<%=sStrName%>]
//--------------- Global variables -----------------------
//--------------- End of Global variables ----------------
//---------------------------------------------
// initialize value on load
//---------------------------------------------
function  bodyload()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvPrompt"]);
   showError();   
}
//==============================================================================
// show errors
//==============================================================================
function showError()
{
   var msg = "";
   for(var i=0; i < Error.length; i++)
   {
      msg += Error[i];
   }
   if( msg != "" ) { alert(msg) }
   Error = null;
}
//==============================================================================
// show Item change panel
//==============================================================================
function newCarton()
{
   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>Start New Carton</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popCartonPanel()+ "</td></tr>"
   + "</table>"

   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvPrompt.style.width = "250";}
   else { document.all.dvPrompt.style.width = "auto";}
   document.all.dvPrompt.innerHTML = html;
   document.all.dvPrompt.style.left=getLeftScreenPos() + 300;
   document.all.dvPrompt.style.top=getTopScreenPos() + 60;
   document.all.dvPrompt.style.visibility = "visible";

   // load destination store
   doDestStrSelect();
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function popCartonPanel(sku, desc, qty)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"

  // Destination Store
  panel += "<tr><td class='Prompt2' nowrap>Destination Store:&nbsp;&nbsp;</td>"
         + "<td class='Prompt' nowrap><select class='Small' name='DestStr'></select>"
         + "</tr>";
  // buttons
  panel += "<tr><td class='Prompt1' colspan='2'>"
        + "<button id='Submit' onClick='sbmCtnDtl(null, &#34;NEW&#34;)' class='Small'>Submit</button>&nbsp;"
        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;&nbsp;&nbsp;"
  panel += "</td></tr></table>";

  return panel;
}
//==============================================================================
// Load Issuing Stores
//==============================================================================
function doDestStrSelect()
{
   var str = document.all.DestStr;

   for (var i = 1, j=0; i < Stores.length; i++)
   {
     if(Stores[i] != <%=sIssStr%>)
     {
        str.options[j++] = new Option(Stores[i] + " - " + StoreNames[i],Stores[i]);
     }
   }
   str.selectedIndex=0;
}
//--------------------------------------------------------
// populate Entry Panel
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvPrompt.style.visibility = "hidden";
   SelItem = null;
   NewQty = null;
}
//==============================================================================
// delete item from transfer file
//==============================================================================
function dltCtn(dst, ctn)
{
   if (confirm('Please confirm that carton must be deleted?'))
   {
      sbmCarton(dst, ctn, "DLTCTN")
   }
}
//==============================================================================
// show Carton details
//==============================================================================
function sbmCtnDtl(dst, ctn)
{
   if (ctn=="NEW")
   {
      dst = document.all.DestStr.options[document.all.DestStr.selectedIndex].value;
   }
   var url = "ScanItem.jsp?IssStr=<%=sIssStr%>"
        + "&DstStr=" + dst
        + "&Ctn=" + ctn
   //alert(url)
   window.location.href = url
}
//==============================================================================
// submit entered UPC or SKU
//==============================================================================
function sbmCarton(dst, ctn, action)
{
   var url = "ScanItemSave.jsp?IssStr=<%=sIssStr%>"
        + "&DstStr=" + dst
        + "&Ctn=" + ctn
        + "&Item=ALL"
        + "&Qty=0"
        + "&Action=" + action

   //alert(url)
   //window.location.href=url;
   if(isIE || isSafari){ window.frame1.location.href = url; }
   else if(isChrome || isEdge) { window.frame1.src = url; }
}
//==============================================================================
// restart after item entry
//==============================================================================
function reStart(err)
{
   msg = "";
   if(err != null && err.length > 0 )
   {
      for(var i=0; i < err.length; i++) { msg += err[i] + "\n"}
      alert(msg)
   }
   else { window.location.reload() }
}
</SCRIPT>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>

</head>
<body onload="bodyload()">
<!-------------------------------------------------------------------->
  <div id="dvPrompt" class="Prompt"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

 <table border="0" width="100%" cellPadding="0" cellSpacing="0">
   <tr>
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Item Transfer - Carton List</b>
     <tr>
      <td ALIGN="center" VALIGN="TOP">

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="ScanItemSel.jsp"><font color="red" size="-1">Select Store</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp<br><br>

      </td>
   </tr>
   <!-- -------------------------------------------------------------------- -->
   <!--  New Items -->
   <!-- -------------------------------------------------------------------- -->
   <tr>
      <td ALIGN="center">
        <table  cellPadding="0" cellSpacing="0">
          <tr>
             <td ALIGN="center"><button onClick="newCarton()">New Carton</button><br><br>
          </tr>
        </table>
      </td>
   </tr>

   <tr>
      <td ALIGN="center" VALIGN="TOP">
     <div style="color:darkred;font-size:12px;">* Click on carton # to see Detail.</div>
  <!----------------- beginning of table ------------------------>
  <table class="DataTable" cellPadding="0" cellSpacing="0">
    <tr>
      <th class="DataTable">Dest<br>Store</th>
      <th class="DataTable">Carton</th>
      <th class="DataTable">Date</th>
      <th class="DataTable">Number of SKUs</th>
      <th class="DataTable">Total<br>Qty</th>
      <th class="DataTable">Delete</th>
    </tr>
<!------------------------------- Detail Data --------------------------------->
    <%
      for(int i=0; i<iNumOfCtn; i++)
      {
         ctnlist.setNextCtn();
         String sDestStr = ctnlist.getDestStr();
         String sCtn = ctnlist.getCtn();
         String sDate = ctnlist.getDate();
         String sNumSku = ctnlist.getNumSku();
         String sTotQty = ctnlist.getTotQty();
    %>
         <tr class="DataTable">
           <td class="DataTable"><%=sDestStr%></td>
           <td class="DataTable"><a class="Small" href="javascript: sbmCtnDtl('<%=sDestStr%>', '<%=sCtn%>')"><%=sCtn%></a></td>
           <td class="DataTable"><%=sDate%></td>
           <td class="DataTable"><%=sNumSku%></td>
           <td class="DataTable"><%=sTotQty%></td>
           <th class="DataTable" nowrap><a class="Small" href="javascript: dltCtn('<%=sDestStr%>', '<%=sCtn%>')">Delete</a></th>
         </tr>
    <%}%>
<!---------------------------- end of Report Totals ------------------------------>
 </table>
 <!----------------------- end of table ------------------------>
  </table>
 </body>
</html>
<%
ctnlist.disconnect();
ctnlist = null;
}%>