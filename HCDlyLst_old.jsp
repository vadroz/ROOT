
<%@ page import="salesvelocity.HCDlyLst, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String sFrom = request.getParameter("From");
   String sTo = request.getParameter("To");
   String sStrOpt = request.getParameter("StrOpt");
   String sDatOpt = request.getParameter("DatOpt");
   String sSort = request.getParameter("Sort");

   SimpleDateFormat smp = new SimpleDateFormat("MM/dd/yyyy");

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
   if(sStrOpt == null){ sStrOpt = "STR"; }
   if(sDatOpt == null){ sDatOpt = "NONE"; }
   if(sSort == null){ sSort = "STR"; }

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=HCDlyLst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{


   StoreSelect strsel = new StoreSelect();
   String sStrJsa = strsel.getStrNum();
   String sStrNameJsa = strsel.getStrName();
   int iNumOfStr = strsel.getNumOfStr();
   String [] sStrLst = strsel.getStrLst();
   String [] sStrRegLst = strsel.getStrRegLst();
   String sStrRegJsa = strsel.getStrReg();
   int iSpace = 6;

   if(sSelStr ==null)
   {
      Vector vStr = new Vector();
      for(int i=0; i < iNumOfStr; i++)
      {
         if(!sStrLst[i].equals("55") && !sStrLst[i].equals("89"))
         {
           vStr.add(sStrLst[i]);
         }
      }

      sSelStr = (String [])vStr.toArray(new String[vStr.size()]);;
   }

   String sUser = session.getAttribute("USER").toString();

   //System.out.println(sFrom + "|" + sTo + "|" + sStrOpt + "|" + sDatOpt + "|" + sSort + "|" + sUser);
   HCDlyLst hcdly = new HCDlyLst(sSelStr, sFrom, sTo, sStrOpt, sDatOpt, sSort, sUser);
   int iNumOfGrp = hcdly.getNumOfGrp();
%>
<html>
<meta http-equiv="X-UA-Compatible" content="IE=7">
<head>

<style>body {background:white;text-align:center; }
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { text-align:center;}


        tr.DataTable  { font-family:Arial; font-size:10px }
        tr.DataTable1  { font-family:Arial; font-size:12px }
        tr.DataTable2 { background:CornSilk; font-family:Arial; font-size:10px }

        .Divider{ background:#FFCC99; font-size:1px; padding:none }

        .DataTable { background:#e7e7e7; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;  text-align:right;}
        .DataTable1{ background:#FFCC99; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;  text-align:right;}
        .DataTable1c{ background:#FFCC99; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;  text-align:Center;}
        .DataTable2 { background:gold; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;  text-align:right;}
        .DataTable2c { background:gold; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;  text-align:center;}
        .DataTable3 { background:#ccffcc; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;  text-align:right;}
        .DataTable3c { background:#ccffcc; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;  text-align:center;}
        .DataTable4 { background:#cccfff; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;  text-align:right;}
        .DataTable4c { background:#cccfff; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;  text-align:center;}
        .DataTable5 { background:khaki; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;  text-align:right;}
        .DataTable5c { background:khaki; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;  text-align:center;}

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
var From = "<%=sFrom%>"
var To = "<%=sTo%>"
var StrOpt = "<%=sStrOpt%>"
var DatOpt = "<%=sDatOpt%>"
var ArrStr = [<%=sStrJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];

var ArrSelStr = new Array();
<%for(int i=0; i < sSelStr.length; i++){%>
   ArrSelStr[<%=i%>] = "<%=sSelStr[i]%>";
<%}%>

//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvStyle"]);
   setSelectPanelShort();
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

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
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
   if(From == "WTD" || From == "MTD" || From == "YTD" || From == "PMN")
   {
      document.all.From.value = To;
      document.all.To.value = To;
   }
   else
   {
     document.all.From.value = From;
     document.all.To.value = To;
   }
   // setup date range
   var grp = document.all.DtGrp;
   for(var i=0; i < grp.length; i++)
   {
      if(From == grp[i].value){ grp[i].checked = true; break; }
   }
   setDtRange();

   var str = document.all.Str;
   for(var i=0; i < str.length; i++)
   {
      for(var j=0; j < ArrStr.length; j++)
      {
         if(str[i].value == ArrSelStr[j]){ str[i].checked = true;}
         else{ str[i].checked == false; }
      }
   }

   if(StrOpt == "STR"){ document.all.StrOpt[0].checked = true };
   else{ document.all.StrOpt[1].checked = true };

   if(DatOpt == "DATE"){ document.all.DatOpt[0].checked = true };
   else{ document.all.DatOpt[1].checked = true };

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
          + "<table border=0>"
              + "<tr>"

  for(var i=1, j=0; i < ArrStr.length; i++, j++)
  {
     if(j > 0 && j % 11 == 0){ panel += "<tr>"}
     panel += "<td class='Small' nowrap>"
          + "<input type='checkbox' class='Small' name='Str' value='" + ArrStr[i] + "'>" + ArrStr[i]
        + "</td>"
  }

  panel += "</table>"
          + "<button onclick='checkAll(true)' class='Small'>Check All</button> &nbsp; &nbsp;"
          + "<button onclick='checkDist(&#34;1&#34;)' class='Small'>Dist 1</button> &nbsp; &nbsp;"
          + "<button onclick='checkDist(&#34;2&#34;)' class='Small'>Dist 2</button> &nbsp; &nbsp;"
          + "<button onclick='checkDist(&#34;3&#34;)' class='Small'>Dist 3</button> &nbsp; &nbsp;"
          + "<button onclick='checkDist(&#34;99&#34;)' class='Small'>Dist 99</button> &nbsp; &nbsp;"
          + "<button onclick='checkAll(false)' class='Small'>Reset</button>"
       + "</td>"
     + "</tr>"

     + "<tr id='trDt1'  style='background:azure'>"
        + "<td class='Prompt' colspan=3><u>Date Selection:</u>&nbsp</td>"
     + "</tr>"
     + "<tr id='trDt1'  style='background:azure'>"
        + "<td class='Prompt' colspan=3>"
           + "<input type='radio' name='DtGrp' value='WTD' onclick='setDtRange()'>W-T-D &nbsp; &nbsp;"
           + "<input type='radio' name='DtGrp' value='MTD' onclick='setDtRange()'>M-T-D &nbsp; &nbsp;"
           + "<input type='radio' name='DtGrp' value='YTD' onclick='setDtRange()'>Y-T-D &nbsp; &nbsp;"
           + "<input type='radio' name='DtGrp' value='PMN' onclick='setDtRange()'>Prior Month &nbsp; &nbsp;"
           + "<input type='radio' name='DtGrp' value='RANGE' onclick='setDtRange()' checked>Date Range"
        + "</td>"
      + "</tr>"

    + "<tr id='trDt2' style='background:azure'>"
       + "<td class='Prompt' id='td2Dates' width='30px'>From:</td>"
       + "<td class='Prompt' id='td2Dates'>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;From&#34;)'>&#60;</button>"
          + "<input name='From' class='Small' size='10' readonly>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;From&#34;)'>&#62;</button>"
       + "</td>"
       + "<td class='Prompt' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 420, 170, document.all.From)'>"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
    + "</tr>"
    + "<tr id='trDt2' style='background:azure'>"
       + "<td class='Prompt' id='td2Dates' width='30px'>To:</td>"
       + "<td class='Prompt' id='td2Dates'>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;To&#34;)'>&#60;</button>"
          + "<input name='To' class='Small' size='10' readonly>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;To&#34;)'>&#62;</button>"
       + "</td>"
       + "<td class='Prompt' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 420, 250, document.all.To)'>"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
     + "</tr>"
     + "<tr id='trDt2'>"
       + "<td class='Prompt'  style='background:azure' colspan=3>Selected dates must be a Sunday.</td>"
     + "</tr>"

     + "<tr style='background:#ccffcc'>"
       + "<td class='Prompt1' colspan=3><u>Report Options:</u></td>"
     + "</tr>"
     + "<tr style='background:#ccffcc'>"
       + "<td class='Prompt1' colspan=3>"
          + "<table border=0>"
              + "<tr>"
                  + "<td class='Small' nowrap><input type='radio' class='Small' name='StrOpt' value='STR'>Store</td>"
                  + "<td class='Small' nowrap><input type='radio' class='Small' name='StrOpt' value='NONE'>None</td>"
              + "</tr>"
              + "<tr>"
                  + "<td class='Small' nowrap><input type='radio' class='Small' name='DatOpt' value='DATE'>Date</td>"
                  + "<td class='Small' nowrap><input type='radio' class='Small' name='DatOpt' value='NONE'>None</td>"
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
// check all stores
//==============================================================================
function checkDist(dist)
{
  var str = document.all.Str

  for(var i=0; i < str.length; i++)
  {
     str[i].checked = false;
     for(var j=0; j < ArrStr.length; j++)
     {
        if(str[i].value == ArrStr[j] && ArrStrReg[j] == dist){ str[i].checked = true; };
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
// set date ranges
//==============================================================================
function setDtRange()
{
   var grp = document.all.DtGrp;
   for(var i=0; i < grp.length; i++)
   {
      if(grp[i].checked && i < grp.length-1)
      {
         document.all.trDt2[0].style.display="none";
         document.all.trDt2[1].style.display="none";
         document.all.trDt2[2].style.display="none";
         break;
      }
      else if(grp[i].checked)
      {
         document.all.trDt2[0].style.display="block";
         document.all.trDt2[1].style.display="block";
         document.all.trDt2[2].style.display="block";
         break;
      }
   }
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
   var str = document.all.Str;
   var selstr = new Array();
   var numstr = 0
   for(var i=0; i < str.length; i++)
   {
     if(str[i].checked){ selstr[numstr] = str[i].value; numstr++;}
   }
   if (numstr == 0){ error=true; msg+="At least 1 store must be selected."; br = "<br>";}

   var selFrom = document.all.From.value.trim();
   var selTo = document.all.To.value.trim();

   var grp = document.all.DtGrp;
   var grpnum = 0;
   for(var i=0; i < grp.length; i++)
   {
      if(grp[i].checked && i < grp.length-1)
      {
         grpnum=i;
         selFrom = grp[i].value;
         break;
      }
   }

   // get store options
   var stropt = null;
   var stroptobj = document.all.StrOpt;
   for(var i=0; i < stroptobj.length; i++)
   {
      if(stroptobj[i].checked){  stropt = stroptobj[i].value; break; }
   }

   // get date options
   var datopt = null;
   var datoptobj = document.all.DatOpt;
   for(var i=0; i < datoptobj.length; i++)
   {
      if(datoptobj[i].checked){  datopt = datoptobj[i].value; break; }
   }

   if(error){alert(msg)}
   else{ submitForm(selstr, selFrom, selTo, stropt, datopt) }
}
//==============================================================================
// change action on submit
//==============================================================================
function submitForm(selstr, selFrom, selTo, stropt, datopt)
{
   var url;
   url = "HCDlyLst.jsp?From=" + selFrom + "&To=" + selTo;
   for(var i=0; i < selstr.length; i++)
   {
     url += "&Str=" + selstr[i];
   }

   url += "&StrOpt=" + stropt;
   url += "&DatOpt=" + datopt;
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
   url = "HCDlyLst.jsp?";

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

   url += "&DatOpt=DATE";
   url += "&StrOpt=STR";
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
 <div style="clear: both; overflow: AUTO; width: 100%; height: 100%; POSITION: relative; color:black;" >

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table border=1 class="DataTable" cellPadding="0" cellSpacing="0">
        <thead>
        <tr style="z-index: 60; position: relative; left: -1; top: expression(this.offsetParent.scrollTop-2);">
          <th class="DataTable1c" style="border-right:none" colspan=29>
            <b>Retail Concepts, Inc
            <br>Headcount Statistics
            <br>Stores:
               <%String sComa = "";%>
               <%for(int i=0; i < sSelStr.length;i++){%>
                  <%if(i > 0 && i%20 == 0){%><br><%}%>
                  <%=sComa%><%=sSelStr[i]%>
                  <%sComa = ", ";%>
               <%}%>

              <br><%if(sFrom.equals("WTD")){%>Week-To-Date<%}
                    else if(sFrom.equals("MTD")){%>Month-To-Date<%}
                    else if(sFrom.equals("YTD")){%>Year-To-Date<%}
                    else if(sFrom.equals("PMN")){%>Prior Month<%}
                    else {%>
                       From: <%=sFrom%> &nbsp;&nbsp;&nbsp;&nbsp;
                       To: <%=sTo%> &nbsp;&nbsp;&nbsp;&nbsp;
                    <%}%>
            </b>
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp;
          </th>
        </tr>


        <tr class="DataTable1" style="z-index: 60; position: relative; left: -1; top: expression(this.offsetParent.scrollTop-2);">
          <%if(sStrOpt.equals("STR")){%><th class="DataTable1c">Str</th><%}%>
          <%if(sDatOpt.equals("DATE")){%><th class="DataTable1c">Date</th><%}%>

          <th class="DataTable2c" colspan=3>Trafffic</th>
          <th class="Divider">&nbsp;</th>
          <th class="DataTable3c" colspan=3>Transactions</th>
          <th class="Divider">&nbsp;</th>
          <th class="DataTable4c" colspan=3>Conversion<br>Rate</th>
          <th class="Divider">&nbsp;</th>
          <th class="DataTable5c" colspan=3>Average<br>Sales<br>Price</th>
          <th class="Divider">&nbsp;</th>
          <th class="DataTable2c" colspan=3>Total<br>Sales</th>
          <th class="Divider">&nbsp;</th>
          <th class="DataTable3c" colspan=3>Returnes</th>
          <th class="Divider">&nbsp;</th>
          <th class="DataTable4c" colspan=3>Net<br>Sales</th>
        </tr>

        <tr class="DataTable1" style="z-index: 60; position: relative; left: -1; top: expression(this.offsetParent.scrollTop-2);">
          <%if(sStrOpt.equals("STR")){%><th class="DataTable1c">&nbsp;</th><%}%>
          <%if(sDatOpt.equals("DATE")){%><th class="DataTable1c">&nbsp;</th><%}%>
          <th class="DataTable2c">TY</th>
          <th class="DataTable2c">LY</th>
          <th class="DataTable2c">Var</th>
          <th class="Divider">&nbsp;</th>
          <th class="DataTable3c">TY</th>
          <th class="DataTable3c">LY</th>
          <th class="DataTable3c">Var</th>
          <th class="Divider">&nbsp;</th>
          <th class="DataTable4c">TY</th>
          <th class="DataTable4c">LY</th>
          <th class="DataTable4c">Var</th>
          <th class="Divider">&nbsp;</th>
          <th class="DataTable5c">TY</th>
          <th class="DataTable5c">LY</th>
          <th class="DataTable5c">Var</th>

          <th class="Divider">&nbsp;</th>
          <th class="DataTable2c">TY</th>
          <th class="DataTable2c">LY</th>
          <th class="DataTable2c">Var</th>
          <th class="Divider">&nbsp;</th>
          <th class="DataTable3c">TY</th>
          <th class="DataTable3c">LY</th>
          <th class="DataTable3c">Var</th>
          <th class="Divider">&nbsp;</th>
          <th class="DataTable4c">TY</th>
          <th class="DataTable4c">LY</th>
          <th class="DataTable4c">Var</th>
        </tr>

        </thead>
<!------------------------------- Data Detail --------------------------------->
           <%for(int i=0; i < iNumOfGrp; i++) {
              hcdly.setHeadCounts();
              String sStr = hcdly.getStr();
              String sDate = hcdly.getDate();
              String sTyTraf = hcdly.getTyTraf();
              String sTyTrans = hcdly.getTyTrans();
              String sTyConv = hcdly.getTyConv();
              String sTyAsp = hcdly.getTyAsp();
              String sTyTotSls = hcdly.getTyTotSls();
              String sTyTotRet = hcdly.getTyTotRet();
              String sTyTotNet = hcdly.getTyTotNet();

              String sLyTraf = hcdly.getLyTraf();
              String sLyTrans = hcdly.getLyTrans();
              String sLyConv = hcdly.getLyConv();
              String sLyAsp = hcdly.getLyAsp();
              String sLyTotSls = hcdly.getLyTotSls();
              String sLyTotRet = hcdly.getLyTotRet();
              String sLyTotNet = hcdly.getLyTotNet();

              String sVaTraf = hcdly.getVaTraf();
              String sVaTrans = hcdly.getVaTrans();
              String sVaConv = hcdly.getVaConv();
              String sVaAsp = hcdly.getVaAsp();
              String sVaTotSls = hcdly.getVaTotSls();
              String sVaTotRet = hcdly.getVaTotRet();
              String sVaTotNet = hcdly.getVaTotNet();
           %>
              <tr class="DataTable">
                <%if(sStrOpt.equals("STR")){%>
                  <td class="DataTable">
                     <%if(!sDatOpt.equals("DATE")){%>
                     <a href="javascript: selRep('<%=sStr%>', null)"><%=sStr%></a>
                     <%} else{%><%=sStr%><%}%>
                  </td>
                <%}%>
                <%if(sDatOpt.equals("DATE")){%>
                   <td class="DataTable">
                     <%if(!sStrOpt.equals("STR")){%>
                      <a href="javascript: selRep(null, '<%=sDate%>')"><%=sDate%></a>
                     <%} else {%><%=sDate%><%}%>
                   </td>
                <%}%>
                <td class="DataTable"><%=sTyTraf%></td>
                <td class="DataTable"><%=sLyTraf%></td>
                <td class="DataTable"><%=sVaTraf%></td>
                <th class="Divider">&nbsp;</th>
                <td class="DataTable"><%=sTyTrans%></td>
                <td class="DataTable"><%=sLyTrans%></td>
                <td class="DataTable"><%=sVaTrans%></td>
                <th class="Divider">&nbsp;</th>
                <td class="DataTable"><%=sTyConv%>%</td>
                <td class="DataTable"><%=sLyConv%>%</td>
                <td class="DataTable"><%=sVaConv%></td>
                <th class="Divider">&nbsp;</th>
                <td class="DataTable">$<%=sTyAsp%></td>
                <td class="DataTable">$<%=sLyAsp%></td>
                <td class="DataTable"><%=sVaAsp%>%</td>
                <th class="Divider">&nbsp;</th>
                <td class="DataTable">$<%=sTyTotSls%></td>
                <td class="DataTable">$<%=sLyTotSls%></td>
                <td class="DataTable"><%=sVaTotSls%>%</td>
                <th class="Divider">&nbsp;</th>
                <td class="DataTable">$<%=sTyTotRet%></td>
                <td class="DataTable">$<%=sLyTotRet%></td>
                <td class="DataTable"><%=sVaTotRet%>%</td>
                <th class="Divider">&nbsp;</th>
                <td class="DataTable">$<%=sTyTotNet%></td>
                <td class="DataTable">$<%=sLyTotNet%></td>
                <td class="DataTable"><%=sVaTotNet%>%</td>
           <%}%>
           <!-- ============== Totals =======================================-->
           <%
              hcdly.setTotal();
              String sStr = hcdly.getStr();
              String sDate = hcdly.getDate();
              String sTyTraf = hcdly.getTyTraf();
              String sTyTrans = hcdly.getTyTrans();
              String sTyConv = hcdly.getTyConv();
              String sTyAsp = hcdly.getTyAsp();
              String sTyTotSls = hcdly.getTyTotSls();
              String sTyTotRet = hcdly.getTyTotRet();
              String sTyTotNet = hcdly.getTyTotNet();

              String sLyTraf = hcdly.getLyTraf();
              String sLyTrans = hcdly.getLyTrans();
              String sLyConv = hcdly.getLyConv();
              String sLyAsp = hcdly.getLyAsp();
              String sLyTotSls = hcdly.getLyTotSls();
              String sLyTotRet = hcdly.getLyTotRet();
              String sLyTotNet = hcdly.getLyTotNet();

              String sVaTraf = hcdly.getVaTraf();
              String sVaTrans = hcdly.getVaTrans();
              String sVaConv = hcdly.getVaConv();
              String sVaAsp = hcdly.getVaAsp();
              String sVaTotSls = hcdly.getVaTotSls();
              String sVaTotRet = hcdly.getVaTotRet();
              String sVaTotNet = hcdly.getVaTotNet();
           %>
              <tr class="DataTable">
                <%if(sStrOpt.equals("STR")){%>
                  <td class="DataTable">
                     <%if(!sDatOpt.equals("DATE")){%>
                     <a href="javascript: selRep('<%=sStr%>', null)"><%=sStr%></a>
                     <%} else{%><%=sStr%><%}%>
                  </td>
                <%}%>
                <%if(sDatOpt.equals("DATE")){%>
                   <td class="DataTable">
                     <%if(!sStrOpt.equals("STR")){%>
                      <a href="javascript: selRep(null, '<%=sDate%>')"><%=sDate%></a>
                     <%} else {%><%=sDate%><%}%>
                   </td>
                <%}%>
                <td class="DataTable"><%=sTyTraf%></td>
                <td class="DataTable"><%=sLyTraf%></td>
                <td class="DataTable"><%=sVaTraf%></td>
                <th class="Divider">&nbsp;</th>
                <td class="DataTable"><%=sTyTrans%></td>
                <td class="DataTable"><%=sLyTrans%></td>
                <td class="DataTable"><%=sVaTrans%></td>
                <th class="Divider">&nbsp;</th>
                <td class="DataTable"><%=sTyConv%>%</td>
                <td class="DataTable"><%=sLyConv%>%</td>
                <td class="DataTable"><%=sVaConv%></td>
                <th class="Divider">&nbsp;</th>
                <td class="DataTable">$<%=sTyAsp%></td>
                <td class="DataTable">$<%=sLyAsp%></td>
                <td class="DataTable"><%=sVaAsp%>%</td>
                <th class="Divider">&nbsp;</th>
                <td class="DataTable">$<%=sTyTotSls%></td>
                <td class="DataTable">$<%=sLyTotSls%></td>
                <td class="DataTable"><%=sVaTotSls%>%</td>
                <th class="Divider">&nbsp;</th>
                <td class="DataTable">$<%=sTyTotRet%></td>
                <td class="DataTable">$<%=sLyTotRet%></td>
                <td class="DataTable"><%=sVaTotRet%>%</td>
                <th class="Divider">&nbsp;</th>
                <td class="DataTable">$<%=sTyTotNet%></td>
                <td class="DataTable">$<%=sLyTotNet%></td>
                <td class="DataTable"><%=sVaTotNet%>%</td>

      </table>
      <!----------------------- end of table ------------------------>
 </div>
 </body>
</html>
<%
  hcdly.disconnect();
  hcdly = null;
}
%>