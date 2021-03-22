<%@ page import="agedanalysis.ItemPriceAnalysis,java.util.*, java.text.*"%>
<%
   String sSelDiv = request.getParameter("Div");
   String sSelDpt = request.getParameter("Dpt");
   String sSelCls = request.getParameter("Cls");
   String sSelVen = request.getParameter("Ven");
   String sSelSty = request.getParameter("Sty");
   String sNumOfDays = request.getParameter("NumOfDays");
   String sReg = request.getParameter("Reg");
   String sClrx4 = request.getParameter("Clrx4");
   String sClrx6 = request.getParameter("Clrx6");
   String sClrx7 = request.getParameter("Clrx7");
   String sSort = request.getParameter("Sort");
   String sNumOfUnits = request.getParameter("NumOfUnits");
   String sLstRctDt = request.getParameter("LstRctDt");

   if(sSort==null) { sSort="DESCRASCN"; }

String sAppl="BASIC1";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=ItemPriceAnalysis.jsp&APPL=" + sAppl + "&" + request.getQueryString());
}
else
{
   String sUser = session.getAttribute("USER").toString();

   String sStrAllowed = null;

   ItemPriceAnalysis itmanl = new ItemPriceAnalysis(sSelDiv, sSelDpt, sSelCls, sSelVen
       , sSelSty, sNumOfDays, sReg, sClrx4, sClrx6, sClrx7, sNumOfUnits, sLstRctDt, sSort, sUser);
%>

<html>
<head>

<style>
  body {background:cornsilk;}
  a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
  table.DataTable { text-align:center;}
  th.DataTable { background:#FFCC99;
                 padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                 text-align:center; font-family:Verdanda; font-size:12px }
  th.DataTable1 { background:#FFCC99; text-align:center; font-family:Verdanda; font-size:12px }
  th.DataTable2 { background:#FFCC99; padding-top:3px; padding-bottom:3px;
                 text-align:center; font-family:Verdanda; font-size:12px }
  th.DataTable3 { background:salmon; padding-top:3px; padding-bottom:3px;
                 text-align:center; font-family:Verdanda; font-size:12px }
  th.DataTable4 { background:#FFCC99; text-align:center; font-family:Verdanda; font-size:10px }
  th.DataTable5 { background:salmon; text-align:center; font-family:Verdanda; font-size:10px }

  tr.DataTable { background: #efefef; font-family:Arial; font-size:11px }
  tr.DataTable1 { background: cornsilk; font-family:Arial; font-size:11px }
  tr.DataTable2 { background: #ccffcc; font-family:Arial; font-size:11px }
  tr.DataTable3 { background: NavajoWhite; font-family:Arial; font-size:11px }
  tr.Divider{ background:darkred; font-size:1px }

  td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}
  td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:center;}
  td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;}

  td.TYCell { background:cornsilk; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}

  div.dvSelect { position:absolute; background-attachment: scroll; display:none;
              border: black solid 2px; width:250px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}

  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
  .Small { font-size:10px;}

</style>
<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Sort = "<%=sSort%>";
//--------------- End of Global variables ----------------
//---------------------------------------------
// initialize value on load
//---------------------------------------------
function  bodyload()
{
}
//==============================================================================
// set Short form of select parameters
//==============================================================================
function setSelectPanelShort()
{
   var hdr = "Select Report Parameters";

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='RestoreButton.bmp' onclick='javascript:setSelectPanel();' alt='Restore'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"
   html += "</td></tr></table>"
   document.all.dvSelect.innerHTML=html;
}
//==============================================================================
// set Weekly Selection Panel
//==============================================================================
function setSelectPanel()
{
  var hdr = "Select Report Parameters";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='MinimizeButton.bmp' onclick='javascript:setSelectPanelShort();' alt='Minimize'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popItemSel()

   html += "</td></tr></table>"

   document.all.dvSelect.innerHTML=html;
}
//==============================================================================
// populate Column Panel
//==============================================================================
function popItemSel()
{
  var panel = "<table border=0 cellPadding=0 cellSpacing=0>"

     + "<tr id='trDt1'  style='background:azure'>"
        + "<td class='Prompt' colspan=3>Date Selection:&nbsp</td>"
     + "</tr>"


  panel += "<tr><td class='Prompt1' colspan=3>"
        + "<button onClick='Validate()' class='Small'>Submit</button> &nbsp;"
        + "<button onClick='setSelectPanelShort();' class='Small'>Close</button>&nbsp;</td></tr>"

  panel += "</table>";

  return panel;
}

//==============================================================================
// Validate entry
//==============================================================================
function Validate()
{
   var error = false;
   var msg = "";

   if(error){alert(msg)}
   else{ submitForm(selstr, selFrWeek, selToWeek) }
}
//==============================================================================
// change action on submit
//==============================================================================
function submitForm(selstr, selFrWeek, selToWeek){
   var url;

   url = "ItemPriceAnalysis.jsp?FrWeek=" + selFrWeek + "&ToWeek=" + selToWeek;

   //alert(url);
   window.location.href=url;
}
//==============================================================================
// show another selected week
//==============================================================================
function resort(sort)
{
   //Div=40&Dpt=ALL&Cls=ALL&Ven=ALL&Sty=ALL&Reg=Y&Clrx4=Y&Clrx6=Y&Clrx7=Y&NumOfDays=90
   //Div=40&Dpt=ALL&Cls=ALL&Ven=ALL&Sty=ALL&Reg=Y&Clrx4=Y&Clrx6=Y&Clrx7=YNumOfDays=90&Sort=SKUASCN

   var url = "ItemPriceAnalysis.jsp?Div=<%=sSelDiv%>&Dpt=<%=sSelDpt%>"
    + "&Cls=<%=sSelCls%>&Ven=<%=sSelVen%>&Sty=<%=sSelSty%>"
    + "&Reg=<%=sReg%>&Clrx4=<%=sClrx4%>&Clrx6=<%=sClrx6%>&Clrx7=<%=sClrx7%>"
    + "&NumOfDays=<%=sNumOfDays%>"
    + "&NumOfUnits=<%=sNumOfUnits%>"

   url += "&Sort=" + sort

   //alert(url)
   window.location.href=url;
}
</SCRIPT>


</head>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<body onload="bodyload()">

<!-------------------------------------------------------------------->
<div id="dvSelect" class="dvSelect"></div>
<!-------------------------------------------------------------------->
 <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
   <tr>
      <td ALIGN="center" VALIGN="TOP" nowrap>
      <b>Retail Concepts, Inc
      <br>Item Price Analysis

     <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="ItemPriceAnalysisSel.jsp"><font color="red" size="-1">Select</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp
      </td>
   </tr>
   <tr>
      <td ALIGN="center" VALIGN="TOP">
<!-------------------------------------------------------------------->
  <!----------------- beginning of table ------------------------>
  <table class="DataTable" border=1 cellPadding="0" cellSpacing="0">
    <tr>
      <th class="DataTable">Div</th>
      <th class="DataTable">Dpt</th>
      <th class="DataTable">Item Number</th>
      <th class="DataTable">Short SKU</th>
      <th class="DataTable">Description</th>
      <th class="DataTable">Vendor<br>Style</th>
      <th class="DataTable">Retail</th>
      <th class="DataTable">Qty</th>
      <th class="DataTable"># of Days<br>at This<br>Price</th>
      <th class="DataTable">Last<br>Receipt<br>Date</th>
      <th class="DataTable">Last<br>Sales<br>Date</th>
    </tr>

    <tr>
      <th class="DataTable" nowrap>
        <a href="javascript: resort('DIVDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('DIVASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable" nowrap>
        <a href="javascript: resort('DPTDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('DPTASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable" nowrap>
        <a href="javascript: resort('ITMNUMDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('ITMNUMASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable" nowrap>
        <a href="javascript: resort('SKUDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('SKUASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable" nowrap>
        <a href="javascript: resort('DESCRDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('DESCRASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable" nowrap>
        <a href="javascript: resort('VSTYDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('VSTYASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable" nowrap>
        <a href="javascript: resort('RETDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('RETASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable" nowrap>
        <a href="javascript: resort('QTYDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('QTYASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable" nowrap>
        <a href="javascript: resort('DAYSDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('DAYSASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable" nowrap>
        <a href="javascript: resort('LRCTDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('LRCTASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable" nowrap>
        <a href="javascript: resort('LSLSDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('LSLSASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
    </tr>
<!--------------------------------- Group Totals ----------------------------->

    <%boolean bRow = false;
    while(itmanl.getNext())
    {
        itmanl.setItmList();
        String sDiv = itmanl.getDiv();
        String sDpt = itmanl.getDpt();
        String sCls = itmanl.getCls();
        String sVen = itmanl.getVen();
        String sSty = itmanl.getSty();
        String sClr = itmanl.getClr();
        String sSiz = itmanl.getSiz();
        String sSku = itmanl.getSku();
        String sDesc = itmanl.getDesc();
        String sVenSty = itmanl.getVenSty();
        String sClsNm = itmanl.getClsNm();
        String sVenNm = itmanl.getVenNm();
        String sRet = itmanl.getRet();
        String sQty = itmanl.getQty();
        String sClrNm = itmanl.getClrNm();
        String sSizNm = itmanl.getSizNm();
        String sNumDy = itmanl.getNumDy();
        String sLastRctDt = itmanl.getLastRctDt();
        String sLastSlsDt = itmanl.getLastSlsDt();
    %>
       <tr class="DataTable<%if(bRow){%>1<%}%><%bRow = !bRow;%>">
         <td class="DataTable" nowrap><%=sDiv%></td>
         <td class="DataTable" nowrap><%=sDpt%></td>
         <td class="DataTable" nowrap><%=sCls%>-<%=sVen%>-<%=sSty%>-<%=sClr%>-<%=sSiz%></td>
         <td class="DataTable1" nowrap><%=sSku%></td>
         <td class="DataTable2" nowrap><%=sDesc%></td>
         <td class="DataTable2" nowrap><%=sVenSty%></td>
         <td class="DataTable" nowrap>$<%=sRet%></td>
         <td class="DataTable" nowrap><%=sQty%></td>
         <td class="DataTable" nowrap><%=sNumDy%></td>
         <td class="DataTable" nowrap><%if(sLastRctDt.equals("01/01/0001")){%>None<%} else {%><%=sLastRctDt%><%}%></td>
         <td class="DataTable" nowrap><%if(sLastSlsDt.equals("01/01/0001")){%>None<%} else {%><%=sLastSlsDt%><%}%></td>
       </tr>
    <%}%>
 </table>
 <!----------------------- end of table ------------------------>

 <!----------------------- end of table ------------------------>

  </table>
 </body>
</html>
<%itmanl.disconnect();
  itmanl = null;
%>
<%}%>