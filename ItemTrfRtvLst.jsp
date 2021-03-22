<%@ page import="itemtransfer.ItemTrfRtvLst, rciutility.ClassSelect, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
//String sSelStr, String sSelDiv, String sSelSts, String sFrom, String sTo
//      , String sDirection, String sDetail, String sSort, String sUser
   String sSelStr = request.getParameter("Str");
   String sSelDiv = request.getParameter("Div");
   String sSelBch = request.getParameter("Batch");
   String sSelSts = request.getParameter("Sts");
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");
   String sDirection = request.getParameter("Direct");
   String sDetail = request.getParameter("Detail");
   String sSort = request.getParameter("Sort");

   SimpleDateFormat smp = new SimpleDateFormat("MM/dd/yyyy");
   boolean bUnselect = sSelStr == null;

   if(sSelStr == null){ sSelStr = ""; }
   if(sSelDiv == null){ sSelDiv = "ALL"; }
   if(sSelBch == null){ sSelBch = "ALL"; }
   if(sSelSts == null){ sSelSts = "S"; }

   if(sFrom == null)
   {
      Date dtPrior  = new Date(new Date().getTime() - 24 * 60 * 60 * 1000);
      sFrom = smp.format(dtPrior);
   }
   if(sTo == null)
   {
      Date dtPrior  = new Date(new Date().getTime() - 24 * 60 * 60 * 1000);
      sTo = smp.format(dtPrior);
   }

   if(sDirection == null){ sDirection = "I"; }
   if(sDetail == null){ sDetail = "DIVBCH"; }
   if(sSort == null){ sSort = "DIV"; }

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=ItemTrfRtvLst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{
   StoreSelect strsel = new StoreSelect(16);
   String sStrJsa = strsel.getStrNum();
   String sStrNameJsa = strsel.getStrName();
   int iNumOfStr = strsel.getNumOfStr();
   String [] sStrLst = strsel.getStrLst();
   String [] sStrRegLst = strsel.getStrRegLst();
   String sStrRegJsa = strsel.getStrReg();

   String [] sStrDistLst = strsel.getStrDistLst();
   String sStrDistJsa = strsel.getStrDist();
   String [] sStrDistNmLst = strsel.getStrDistNmLst();
   String sStrDistNmJsa = strsel.getStrDistNm();

   String [] sStrMallLst = strsel.getStrMallLst();
   String sStrMallJsa = strsel.getStrMall();

   int iSpace = 6;
   String sUser = session.getAttribute("USER").toString();

   ClassSelect divlst = new ClassSelect();
   String sDivLst = divlst.getDivNum();
   String sDivNameLst = divlst.getDivName();

   //System.out.println(sSelSts + "|" + sSort + "|" + sUser);
   ItemTrfRtvLst itmtrfl = null;
   int iNumOfGrp = 0;
   itmtrfl = new ItemTrfRtvLst(sSelStr, sSelDiv, sSelBch, sSelSts, sFrom, sTo
          , sDirection, sDetail, sSort, sUser);
   iNumOfGrp = itmtrfl.getNumOfItm();
%>
<html>
<head>

<style>body {background:ivory;text-align:center; }
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { background:#FFE4C4;text-align:center;}

        th.DataTable  { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1  { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:14px }


        tr.DataTable  { background:#e7e7e7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:CornSilk; font-family:Arial; font-size:10px }
        tr.DataTable2  { background:gray; color:white; font-family:Arial; font-size:10px }
        tr.DataTable3 { background:#F6CEF5; font-family:Arial; font-size:10px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:right;}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:left;}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px;  text-align:left;}

        td.DataTable3 { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:10px }
        td.DataTable4 { background:red; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right;}

        .Small {font-size:10px }
        select.Small {margin-top:3px; font-family:Arial; font-size:10px }
        input.Small {margin-top:3px; font-family:Arial; font-size:10px }
        button.Small {margin-top:3px; font-family:Arial; font-size:10px }

        div.dvStyle { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:900; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px; overflow:none;}

       div.dvSelect { position:absolute; background-attachment: scroll;
              border: black solid 2px; width:250px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec; vertical-align:bottom;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
</style>
<SCRIPT language="JavaScript1.2">

//--------------- Global variables -----------------------
var Unselect = <%=bUnselect%>;
var SelDiv = "<%=sSelDiv%>";
var From = "<%=sFrom%>";
var To = "<%=sTo%>";
var SelSts = "<%=sSelSts%>";
var Direction = "<%=sDirection%>";
var Detail = "<%=sDetail%>";
var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];

var ArrDiv = [<%=sDivLst%>];
var ArrDivNm = [<%=sDivNameLst%>];

var ArrSelStr = new Array();
ArrSelStr[0] = "<%=sSelStr%>";


//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvStyle"]);

   if(!Unselect) { setSelectPanelShort(); }
   else { setSelectPanel(); }
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
         +  "<img src='RestoreButton.bmp' onclick='javascript:setSelectPanel();' alt='Resvtore'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"
   html += "</td></tr></table>"

   document.all.dvSelect.innerHTML=html;
   document.all.dvSelect.style.pixelLeft= document.documentElement.scrollLeft + 10;
   document.all.dvSelect.style.pixelTop= document.documentElement.scrollTop + 20;
   document.all.dvSelect.style.width=200;
}
//==============================================================================
// set Weekly Selection Panel
//==============================================================================
function setSelectPanel()
{
  var hdr = "Select Report Parameters";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='padding-left:3px; padding-right:3px;'>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='MinimizeButton.bmp' onclick='javascript:setSelectPanelShort();' alt='Minimize'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popSelWk()

   html += "</td></tr></table>"
   document.all.dvSelect.innerHTML=html;

   // populate from week with to week if litteral range selected
   document.all.From.value = From;
   document.all.To.value = To;

   // populate store dropdown menu
   var str = document.all.Str;
   for(var i=1; i < ArrStr.length; i++)
   {
       str.options[i-1] = new Option(ArrStr[i] + " - " + ArrStrNm[i], ArrStr[i]);
       if(ArrSelStr[0]==ArrStr[i]){ str.selectedIndex= i-1; }
   }

   // populate division dropdown menu
   var div = document.all.Div;
   div.options[0] = new Option("All Divisions", "ALL");
   for(var i=1; i < ArrDiv.length; i++)
   {
       div.options[i] = new Option(ArrDivNm[i], ArrDiv[i]);
       if(SelDiv==ArrDiv[i]){ div.selectedIndex= i; }
   }

   // populate status dropdown menu
   var sts = document.all.Sts;
   sts.options[0] = new Option("Approved", "A");
   sts.options[1] = new Option("In-Transfer", "I");
   sts.options[2] = new Option("Sent", "S");
   sts.selectedIndex = 2;
   if(SelSts == "A"){ sts.selectedIndex = 0; }
   else if(SelSts == "I"){ sts.selectedIndex = 1; }

   var dir = document.all.Direction;
   for(var i=0; i < dir.length; i++)
   {
       if(Direction==dir[i].value){ dir[i].checked = true; }
   }

   var dtl = document.all.Detail;
   for(var i=0; i < dtl.length; i++)
   {
       if(Detail==dtl[i].value){ dtl[i].checked = true; }
   }
   document.all.dvSelect.style.pixelLeft= document.documentElement.scrollLeft + 10;
   document.all.dvSelect.style.pixelTop= document.documentElement.scrollTop + 20;
   document.all.dvSelect.style.width=200;

}
//==============================================================================
// populate Column Panel
//==============================================================================
function popSelWk()
{
  var panel = "<table border=0 cellPadding=0 cellSpacing=0>"
    + "<tr>"
       + "<td class='Prompt1' colspan=3><u>Stores</u></td>"
     + "</tr>"
     + "<tr>"
       + "<td class='Prompt1' colspan=3>"
         + "<select class='Small' name='Str'></select>"
       + "</td>"
     + "</tr>"

     + "<tr>"
       + "<td class='Prompt1' colspan=3><u>Divisions</u></td>"
     + "</tr>"
     + "<tr>"
       + "<td class='Prompt1' colspan=3>"
         + "<select class='Small' name='Div'></select>"
       + "</td>"
     + "</tr>"

     + "<tr>"
       + "<td class='Prompt1' colspan=3><u>Statuses</u></td>"
     + "</tr>"
     + "<tr>"
       + "<td class='Prompt1' colspan=3>"
         + "<select type='checkbox' class='Small' name='Sts' value='A'></select>"
       + "</td>"
     + "</tr>"

     + "<tr id='trDt1'  style='background:azure'>"
        + "<td class='Prompt1' colspan=3><u>Date Selection:</u>&nbsp</td>"
     + "</tr>"

    + "<tr id='trDt2' style='background:azure'>"
       + "<td class='Prompt' id='td2Dates' width='30px'>From:</td>"
       + "<td class='Prompt' id='td2Dates'>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;From&#34;)'>&#60;</button>"
          + "<input name='From' class='Small' size='10' readonly>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;From&#34;)'>&#62;</button>"
       + "</td>"
       + "<td class='Prompt' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 320, 150, document.all.From)'>"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
    + "</tr>"
    + "<tr id='trDt2' style='background:azure'>"
       + "<td class='Prompt' id='td2Dates' width='30px'>To:</td>"
       + "<td class='Prompt' id='td2Dates'>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;To&#34;)'>&#60;</button>"
          + "<input name='To' class='Small' size='10' readonly>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;To&#34;)'>&#62;</button>"
       + "</td>"
       + "<td class='Prompt' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 320, 200, document.all.To)'>"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
     + "</tr>"

     + "<tr style='background:#ccffcc'>"
       + "<td class='Prompt1' colspan=3><u>Report Option:</u></td>"
     + "</tr>"
     + "<tr style='background:#ccffcc'>"
       + "<td class='Prompt1' colspan=3>"
          + "<table border=0>"
              + "<tr>"
                  + "<td class='Small' nowrap><input type='radio' class='Small' name='Direction' value='I'>Issuing</td>"
                  + "<td class='Small' nowrap><input type='radio' class='Small' name='Direction' value='D'>Destination</td>"
              + "</tr>"
              + "<tr>"
                  + "<td class='Small' nowrap><input type='radio' class='Small' name='Detail' value='DIVBCHITM'>Detail</td>"
                  + "<td class='Small' nowrap><input type='radio' class='Small' name='Detail' value='DIVBCH'>Div/Batch</td>"
              + "</tr>"

              + "<tr>"
                + "<td style='color:red; font-weight:bold; font-size:12px;' id='tdError' nowrap></td>"
              + "</tr>"
            + "</table>"
       + "</td>"
     + "</tr>"

  panel += "<tr><td class='Prompt1' colspan=3>"
        + "<button onClick='Validate()' class='Small'>Submit</button> &nbsp;"
        + "<button onClick='setSelectPanelShort();' class='Small'>Close</button>&nbsp;</td></tr>"

  panel += "</table>";

  return panel;
}

//==============================================================================
// check all stores
//==============================================================================
function checkAll(chk)
{
  var str = document.all.Str

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk;
  }
}
//==============================================================================
// check by regions
//==============================================================================
function checkReg(dist)
{
  var str = document.all.Str
  var chk1 = false;
  var chk2 = false;

  // check 1st selected group check status and save it
  var find = false;
  for(var i=0; i < str.length; i++)
  {
     for(var j=0; j < ArrStr.length; j++)
     {
        if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist
          || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
          || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
          || str[i].value == "68" || str[i].value == "86")))
        {
          chk1 = !str[i].checked;
          find = true;
          break;
        };
     }
     if (find){ break;}
  }
  chk2 = !chk1;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(dist != "PATIO" && str[i].value == ArrStr[j] && ArrStrReg[j] == dist
          || (dist == "PATIO" && (str[i].value == "35" || str[i].value == "46"
          || str[i].value == "50" || str[i].value == "63" || str[i].value == "64"
          || str[i].value == "68" || str[i].value == "86")))
        {
           str[i].checked = chk1;
        };
     }
  }
}

//==============================================================================
// check by districts
//==============================================================================
function checkDist(dist)
{
  var str = document.all.Str
  var chk1 = false;
  var chk2 = false;

  // check 1st selected group check status and save it
  var find = false;
  for(var i=0; i < str.length; i++)
  {
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrDist[j] == dist)
        {
          chk1 = !str[i].checked;
          find = true;
          break;
        };
     }
     if (find){ break;}
  }
  chk2 = !chk1;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrDist[j] == dist)
        {
           str[i].checked = chk1;
        };
     }
  }
}

//==============================================================================
// check mall
//==============================================================================
function checkMall(type)
{
  var str = document.all.Str
  var chk1 = true;
  var chk2 = false;

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = chk2;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrMall[j] == type)
        {
           str[i].checked = chk1;
        };
     }
  }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

//==============================================================================
// Validate entry
//==============================================================================
function Validate()
{
   var error = false;
   var msg = "";
   var br = "";

   // get selected stores
   var selstr = document.all.Str.options[document.all.Str.selectedIndex].value;

   // get division
   var seldiv = document.all.Div.options[document.all.Div.selectedIndex].value;

   // get selected status
   var selsts = document.all.Sts.options[document.all.Sts.selectedIndex].value;

   var selFrom = document.all.From.value.trim();
   var selTo = document.all.To.value.trim();

   // get transfer direction
   var direct = null;
   var directobj = document.all.Direction;
   for(var i=0; i < directobj.length; i++)
   {
      if(directobj[i].checked){  direct = directobj[i].value; break; }
   }

   // get report options
   var detail = null;
   var detailobj = document.all.Detail;
   for(var i=0; i < detailobj.length; i++)
   {
      if(detailobj[i].checked){  detail = detailobj[i].value; break; }
   }

   if(error){alert(msg)}
   else{ submitForm(selstr, seldiv, selsts, selFrom, selTo, direct, detail) }
}
//==============================================================================
// change action on submit
//==============================================================================
function submitForm(selstr, seldiv, selsts, selFrom, selTo, direct, detail)
{
   var url;
   url = "ItemTrfRtvLst.jsp?"
   url += "Str=" + selstr;
   url += "&Div=" + seldiv;
   url += "&Sts=" + selsts;
   url += "&From=" + selFrom + "&To=" + selTo;
   url += "&Direct=" + direct;
   url += "&Detail=" + detail;
   url += "&Sort=<%=sSort%>";

   //alert(url);
   window.location.href=url;
}
//==============================================================================
// select new report parameters
//==============================================================================
function selRep(str, date)
{
   var url;
   url = "ItemTrfRtvLst.jsp?";

   if(str != null) { url += "&Str=" + str; }
   else
   {
     for(var i=0; i < ArrSelStr.length; i++)
     {
        url += "&Str=" + ArrSelStr[i];
     }
   }

   if(date != null) { url += "&From=" + date + "&To=" + date; }
   else { url += "&From=" + From + "&To=" + To; }

   url += "&Sort=<%=sSort%>";

   //alert(url);
   window.location.href=url;
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvStyle.innerHTML = " ";
   document.all.dvStyle.style.visibility = "hidden";
}

//==============================================================================
// show selected div/batch
//==============================================================================
function getDivTrf(div, batch)
{
   var url;
   url = "ItemTrfRtvLst.jsp?From=<%=sFrom%>&To=<%=sTo%>"
       + "&Str=<%=sSelStr%>"
       + "&Div=" + div
       + "&Sts=<%=sSelSts%>"
       + "&Batch=" + batch
       + "&Direct=<%=sDirection%>"
       + "&Detail=DIVBCHITM"
       + "&Sort=<%=sSort%>";

   //alert(url);
   window.location.href=url;
}
//==============================================================================
// resort curerent report
//==============================================================================
function resort(sort)
{
   var url;
   url = "ItemTrfRtvLst.jsp?From=<%=sFrom%>&To=<%=sTo%>"
       + "&Str=<%=sSelStr%>"
       + "&Div=<%=sSelDiv%>"
       + "&Sts=<%=sSelSts%>"
       + "&Batch=<%=sSelBch%>"
       + "&Direct=<%=sDirection%>"
       + "&Detail=<%=sDetail%>"
       + "&Sort=" + sort;

   //alert(url);
   window.location.href=url;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvSelect" class="dvSelect"></div>
<div id="dvStyle" class="dvStyle"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
 <div style="clear: both; overflow: AUTO; width: 100%; height: 94%; POSITION: relative; color:black;" >

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 class="DataTable" cellPadding="0" cellSpacing="0">
        <thead>
        <tr style="z-index: 60; position: relative; left: -1; top: expression(this.offsetParent.scrollTop-2);">
          <th class="DataTable1" style="border-right:none" colspan=31>
            <b>Retail Concepts, Inc
            <br>Item Transfer
            <br><%if(sDirection.equals("I")){%>Issuing<%} else{%>Destination<%}%> Stores: <%=sSelStr%>
            <br>Division: <%=sSelDiv%>

              <br>From: <%=sFrom%> &nbsp;&nbsp;&nbsp;&nbsp;
                  To: <%=sTo%> &nbsp;&nbsp;&nbsp;&nbsp;
            </b>
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp;
          </th>
        </tr>


        <tr style="z-index: 60; position: relative; left: -1; top: expression(this.offsetParent.scrollTop-2);">
          <th class="DataTable"><a href="javascript: resort('DIV')">Div</a></th>
          <th class="DataTable"><a href="javascript: resort('BATCH')">Batch</a></th>

          <%if(sDetail.equals("DIVBCHITM")){%>
             <th class="DataTable"><a href="javascript: resort('ITEM')">Long Item Number</a></th>
             <th class="DataTable"><a href="javascript: resort('SKU')">Short SKU</a></th>
             <th class="DataTable">UPC</th>
             <th class="DataTable"><a href="javascript: resort('DESC')">Item Description</a></th>
             <th class="DataTable">Iss<br>Str</th>
             <th class="DataTable">Dest<br>Str</th>
          <%}%>

          <th class="DataTable">Req<br>Qty</th>
          <th class="DataTable">Send<br>Qty</th>

          <th class="DataTable">Iss<br>Str<br>Inv</th>
          <th class="DataTable">Dest<br>Str<br>Inv</th>

          <th class="DataTable">Approved</th>
          <th class="DataTable">Printed</th>
          <th class="DataTable">Completed</th>

          <%if(sDetail.equals("DIVBCHITM")){%>
             <th class="DataTable">Class Name</th>
             <th class="DataTable">Vendor Name</th>
             <th class="DataTable">Color Name</th>
             <th class="DataTable">Size Name</th>
          <%}%>
        </tr>

        </thead>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfGrp; i++) {
              itmtrfl.setItemProperty();
              String sBatch = itmtrfl.getBatch();
              String sCls = itmtrfl.getCls();
              String sVen = itmtrfl.getVen();
              String sSty = itmtrfl.getSty();
              String sClr = itmtrfl.getClr();
              String sSiz = itmtrfl.getSiz();
              String sIssStr = itmtrfl.getIssStr();
              String sDstStr = itmtrfl.getDstStr();
              String sReqQty = itmtrfl.getReqQty();
              String sApprUs = itmtrfl.getApprUs();
              String sApprDt = itmtrfl.getApprDt();
              String sSts = itmtrfl.getSts();
              String sPrtUs = itmtrfl.getPrtUs();
              String sPrtDt = itmtrfl.getPrtDt();
              String sComplUs = itmtrfl.getComplUs();
              String sComplDt = itmtrfl.getComplDt();
              String sComplTy = itmtrfl.getComplTy();
              String sSndQty = itmtrfl.getSndQty();
              String sDiv = itmtrfl.getDiv();
              String sDivNm = itmtrfl.getDivNm();
              String sSku = itmtrfl.getSku();
              String sDesc = itmtrfl.getDesc();
              String sClsNm = itmtrfl.getClsNm();
              String sVenNm = itmtrfl.getVenNm();
              String sClrNm = itmtrfl.getClrNm();
              String sSizNm = itmtrfl.getSizNm();
              String sBatchNm = itmtrfl.getBatchNm();
              String sUpc = itmtrfl.getUpc();
              String sIssStrInv = itmtrfl.getIssStrInv();
              String sDstStrInv = itmtrfl.getDstStrInv();
           %>
              <tr class="DataTable<%if(!sDetail.equals("DIVBCHITM")){%>1<%}%>">
                <td class="DataTable1" nowrap><%=sDiv%> - <%=sDivNm%></td>
                <td class="DataTable1" nowrap>
                   <%if(sDetail.equals("DIVBCH")){%>
                      <a href="javascript: getDivTrf('<%=sDiv%>', '<%=sBatch%>')"><%=sBatch%> - <%=sBatchNm%></a>
                   <%} else{%><%=sBatch%> - <%=sBatchNm%><%}%>
                </td>

                <%if(sDetail.equals("DIVBCHITM")){%>
                   <td class="DataTable1" nowrap><%=sCls%>-<%=sVen%>-<%=sSty%>-<%=sClr%>-<%=sSiz%></td>
                   <td class="DataTable"><%=sSku%></td>
                   <td class="DataTable"><%=sUpc%></td>
                   <td class="DataTable1" nowrap><%=sDesc%></td>
                   <td class="DataTable1" nowrap><%=sIssStr%></td>
                   <td class="DataTable1" nowrap><%=sDstStr%></td>
                <%}%>

                <td class="DataTable"><%=sReqQty%></td>
                <td class="DataTable"><%=sSndQty%></td>

                <td class="DataTable"><%=sIssStrInv%></td>
                <td class="DataTable"><%=sDstStrInv%></td>

                <td class="DataTable1" nowrap><%=sApprUs%> <%=sApprDt%></td>
                <td class="DataTable1" nowrap>
                   <%if(!sPrtUs.equals("")){%><%=sPrtUs%> <%=sPrtDt%><%}%>&nbsp;
                </td>
                <td class="DataTable1" nowrap>
                   <%if(!sComplUs.equals("")){%><%=sComplUs%> <%=sComplDt%> <%=sComplTy%><%}%>&nbsp;
                </td>

                <%if(sDetail.equals("DIVBCHITM")){%>
                   <td class="DataTable1" nowrap><%=sClsNm%></td>
                   <td class="DataTable1" nowrap><%=sVenNm%></td>
                   <td class="DataTable1" nowrap><%=sClrNm%></td>
                   <td class="DataTable1" nowrap><%=sSizNm%></td>
                <%}%>
              </tr>
           <%}%>
      </table>
      <!----------------------- end of table ------------------------>
 </div>
 <%if(sDetail.equals("DIVBCHITM")){%>
    <span style="font-size:12px;">Note:  Issuing and Destination Str Inventory is Current on hand.</span>
 <%}%>
 </body>
</html>
<%
  itmtrfl.disconnect();
  itmtrfl = null;
}
%>