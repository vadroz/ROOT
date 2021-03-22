<%@ page import="payrollreports.StrProcPayByType,java.util.*, java.text.*, rciutility.StoreSelect"%>
<%
   String [] sStore = request.getParameterValues("Str");
   String sFrom = request.getParameter("FrWeek");
   String sTo = request.getParameter("ToWeek");
   String sSort = request.getParameter("Sort");

   if(sSort==null) { sSort="NAMEASCN"; }
String sAppl="BASIC1";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=StrProcPayByType.jsp&APPL=" + sAppl + "&" + request.getQueryString());
}
else
{
   String sUser = session.getAttribute("USER").toString();

   String sStrAllowed = null;
   StoreSelect strsel = new StoreSelect(16);
   String sAllStr = strsel.getStrNum();
   String sRegL = strsel.getStrReg();

   StrProcPayByType strpayty = new StrProcPayByType(sStore, sFrom, sTo, sSort, sUser);
   int iNumOfStr = strpayty.getNumOfStr();
   String sStrjsa = strpayty.cvtToJavaScriptArray(sStore);
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

  tr.DataTable { background: #efefef; font-family:Arial; font-size:10px }
  tr.DataTable1 { background: cornsilk; font-family:Arial; font-size:10px }
  tr.DataTable2 { background: #ccffcc; font-family:Arial; font-size:10px }
  tr.DataTable3 { background: NavajoWhite; font-family:Arial; font-size:10px }
  tr.Divider{ background:darkred; font-size:1px }

  td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}
  td.DataTable1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;}
  td.DataTable2{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;
                 font-size:12px; font-weight:bold}

  td.TYCell { background:cornsilk; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}

  div.dvSelect { position:absolute; background-attachment: scroll;
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
var ArrStr = [<%=sAllStr%>];
var ArrSelStr = [<%=sStrjsa%>];
var FrWeek = "<%=sFrom%>";
var ToWeek = "<%=sTo%>";
var Sort = "<%=sSort%>";
var strReg = [<%=sRegL%>];
//--------------- End of Global variables ----------------
//---------------------------------------------
// initialize value on load
//---------------------------------------------
function  bodyload()
{
  // set Weekly Selection Panel
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

   document.all.FrWeek.value = FrWeek;
   document.all.ToWeek.value = ToWeek;

   var str = document.all.Str;
   for(var i=0; i < str.length; i++)
   {
      for(var j=0; j < ArrStr.length; j++)
      {
         if(str[i].value == ArrSelStr[j]){ str[i].checked = true;}
         else{ str[i].checked == false; }
      }
   }

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
          + "<button onclick='checkReg(&#34;1&#34;)' class='Small'>Reg 1</button> &nbsp; &nbsp;"
          + "<button onclick='checkReg(&#34;2&#34;)' class='Small'>Reg 2</button> &nbsp; &nbsp;"
          + "<button onclick='checkReg(&#34;3&#34;)' class='Small'>Reg 3</button> &nbsp; &nbsp;"
          + "<button onclick='checkReg(&#34;99&#34;)' class='Small'>Reg 99</button> &nbsp; &nbsp;"
          + "<button onclick='checkAll(false)' class='Small'>Reset</button>"
       + "</td>"
     + "</tr>"

     + "<tr id='trDt1'  style='background:azure'>"
        + "<td class='Prompt' colspan=3>Date Selection:&nbsp</td>"
     + "</tr>"

    + "<tr id='trDt2' style='background:azure'>"
       + "<td class='Prompt' id='td2Dates' width='30px'>From:</td>"
       + "<td class='Prompt' id='td2Dates'>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;FrWeek&#34;)'>&#60;</button>"
          + "<input name='FrWeek' class='Small' size='10' readonly>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;FrWeek&#34;)'>&#62;</button>"
       + "</td>"
       + "<td class='Prompt' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 420, 10, document.all.FrWeek)'>"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
    + "</tr>"
    + "<tr id='trDt2' style='background:azure'>"
       + "<td class='Prompt' id='td2Dates' width='30px'>To:</td>"
       + "<td class='Prompt' id='td2Dates'>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;ToWeek&#34;)'>&#60;</button>"
          + "<input name='ToWeek' class='Small' size='10' readonly>"
          + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;ToWeek&#34;)'>&#62;</button>"
       + "</td>"
       + "<td class='Prompt' id='td2Dates'><a href='javascript:showCalendar(1, null, null, 420, 30, document.all.ToWeek)'>"
         + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a></td>"
     + "</tr>"
     + "<tr id='trDt2'>"
       + "<td class='Prompt'  style='background:azure' colspan=3>Selected dates must be a Sunday.</td>"
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
function checkReg(reg)
{
  var str = document.all.Str

  for(var i=1, j=0; i < str.length; i++, j++)
  {
     if(strReg[i] == reg){ str[j].checked = true; }
     else{ str[j].checked = false; }
  }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000 * 7);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000 * 7);
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

   // get selected stores
   var str = document.all.Str;
   var selstr = new Array();
   var numstr = 0
   for(var i=0; i < str.length; i++)
   {
     if(str[i].checked){ selstr[numstr] = str[i].value; numstr++;}
   }
   if (numstr == 0){ error=true; msg+="At least 1 store must be selected.";}

   var selFrWeek = document.all.FrWeek.value.trim();
   var selToWeek = document.all.ToWeek.value.trim();

   if(error){alert(msg)}
   else{ submitForm(selstr, selFrWeek, selToWeek) }
}
//==============================================================================
// change action on submit
//==============================================================================
function submitForm(selstr, selFrWeek, selToWeek){
   var url;

   url = "StrProcPayByType.jsp?FrWeek=" + selFrWeek + "&ToWeek=" + selToWeek;
   for(var i=0; i < selstr.length; i++)
   {
     url += "&Str=" + selstr[i];
   }

   //alert(url);
   window.location.href=url;
}
//==============================================================================
// show another selected week
//==============================================================================
function resort(sort)
{
   var url = "StrProcPayByType.jsp?"
    + "FrWeek=<%=sFrom%>"
    + "&ToWeek=<%=sTo%>"
    ;
   for(var i=0; i < ArrSelStr.length; i++) { url += "&Str=" + ArrSelStr[i]; }

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
      <br>Store Payroll Verification
      <br>Store:
       <%String sComa="";%>
       <%for(int i=0; i < sStore.length; i++){%><%=sComa + sStore[i]%><%sComa=", ";%><%}%>
      <br>
          Weekending dates: <%=sFrom%> - <%=sTo%>
      <br>

     <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="StrProcPayByTypeSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp
      </td>
   </tr>
   <tr>
      <td ALIGN="center" VALIGN="TOP">
<!-------------------------------------------------------------------->
  <!----------------- beginning of table ------------------------>
  <table class="DataTable" border=1 cellPadding="0" cellSpacing="0">
    <tr>
      <th class="DataTable" rowspan=2>Reg</th>
      <th class="DataTable" rowspan=2>Str</th>
      <th class="DataTable" rowspan=3>&nbsp;</th>
      <th class="DataTable" colspan=6>Salary</th>
      <th class="DataTable" rowspan=3>&nbsp;</th>
      <th class="DataTable" colspan=9>Hourly</th>
      <th class="DataTable" rowspan=3>&nbsp;</th>
      <th class="DataTable" colspan=6>Total</th>
    </tr>
    <tr>
      <th class="DataTable">Regular</th>
      <th class="DataTable">Benefit</th>
      <th class="DataTable">Bonus</th>
      <th class="DataTable">Comm</th>
      <th class="DataTable">Spiffs<br>Other</th>
      <th class="DataTable">Total</th>

      <th class="DataTable" >Regular<br>$</th>
      <th class="DataTable" >Regular<br>Hrs</th>
      <th class="DataTable">Benefit<br>$</th>
      <th class="DataTable">Benefit<br>Hrs</th>
      <th class="DataTable">Bonus</th>
      <th class="DataTable">Comm</th>
      <th class="DataTable">Spiffs<br>Other</th>
      <th class="DataTable">Total<br>$</th>
      <th class="DataTable">Total<br>Hrs</th>

      <th class="DataTable">Regular</th>
      <th class="DataTable">Benefit</th>
      <th class="DataTable">Bonus</th>
      <th class="DataTable">Comm</th>
      <th class="DataTable">Spiffs<br>Other</th>
      <th class="DataTable">Total</th>
    </tr>

    <tr>
      <th class="DataTable" nowrap>
        <a href="javascript: resort('REGDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('REGASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable" nowrap>
        <a href="javascript: resort('STRDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('STRASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>

      <th class="DataTable">
        <a href="javascript: resort('SLREGDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('SLREGASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('SLHSVDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('SLHSVASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('SLBFDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('SLBFASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('SLCOMDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('SLCOMASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('SLLMODESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('SLLMOASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('SLTOTDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('SLTOTASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>

      <th class="DataTable">
        <a href="javascript: resort('HRREGDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('HRREGASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('HRREGHDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('HRREGHASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('HRHSVDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('HRHSVASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>      
      <th class="DataTable">
        <a href="javascript: resort('HRHSVHDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('HRHSVHASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>      
      <th class="DataTable">
        <a href="javascript: resort('HRBFDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('HRBFASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('HRCOMDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('HRCOMASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('HRLMODESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('HRLMOASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('HRTOTDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('HRTOTASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('HRTOTHDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('HRTOTHASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('STRREGDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('STRREGASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('STRHSVDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('STRHSVASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('STRBFDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('STRBFASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('STRCOMDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('STRCOMASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('STRLMODESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('STRLMOASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('STRTOTDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('STRTOTASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>

      </th>
    </tr>
<!--------------------------------- Group Totals ----------------------------->
    <%boolean bRow = false;
    for(int i=0; i < iNumOfStr; i++)
    {
        strpayty.setStrPayList();
        String sStr = strpayty.getStr();
        String sReg = strpayty.getReg();
        String sSlReg = strpayty.getSlReg();
        String sSlCom = strpayty.getSlCom();
        String sSlHsv = strpayty.getSlHsv();
        String sSlBf = strpayty.getSlBf();
        String sSlLmo = strpayty.getSlLmo();
        String sSlTot = strpayty.getSlTot();

        String sHrReg = strpayty.getHrReg();
        String sHrCom = strpayty.getHrCom();
        String sHrHsv = strpayty.getHrHsv();
        String sHrBf = strpayty.getHrBf();
        String sHrLmo = strpayty.getHrLmo();
        String sHrTot = strpayty.getHrTot();
        
        String sHrHReg = strpayty.getHrHReg();
        String sHrHHsv = strpayty.getHrHHsv();
        String sHrHTot = strpayty.getHrHTot();

        String sStrReg = strpayty.getStrReg();
        String sStrCom = strpayty.getStrCom();
        String sStrHsv = strpayty.getStrHsv();
        String sStrBf = strpayty.getStrBf();
        String sStrLmo = strpayty.getStrLmo();
        String sStrTot = strpayty.getStrTot();
    %>
       <tr class="DataTable<%if(bRow){%>1<%}%><%bRow = !bRow;%>">
         <td class="DataTable" nowrap><%=sReg%></td>
         <td class="DataTable" nowrap><%=sStr%></td>

         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap><%=sSlReg%></td>
         <td class="DataTable" nowrap><%=sSlHsv%></td>
         <td class="DataTable" nowrap><%=sSlBf%></td>
         <td class="DataTable" nowrap><%=sSlCom%></td>
         <td class="DataTable" nowrap><%=sSlLmo%></td>
         <td class="DataTable" nowrap><%=sSlTot%></td>

         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap><%=sHrReg%></td>
         <td class="DataTable" nowrap><%=sHrHReg%></td>
         <td class="DataTable" nowrap><%=sHrHsv%></td>
         <td class="DataTable" nowrap><%=sHrHHsv%></td>
         <td class="DataTable" nowrap><%=sHrBf%></td>
         <td class="DataTable" nowrap><%=sHrCom%></td>
         <td class="DataTable" nowrap><%=sHrLmo%></td>
         <td class="DataTable" nowrap><%=sHrTot%></td>
         <td class="DataTable" nowrap><%=sHrHTot%></td>

         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap><%=sStrReg%></td>
         <td class="DataTable" nowrap><%=sStrHsv%></td>
         <td class="DataTable" nowrap><%=sStrBf%></td>
         <td class="DataTable" nowrap><%=sStrCom%></td>
         <td class="DataTable" nowrap><%=sStrLmo%></td>
         <td class="DataTable" nowrap><%=sStrTot%></td>
       </tr>
    <%}%>
<!-------------------------- end of Group Totals ----------------------------->
    <%
    strpayty.setNumReg();
    int iNumOfReg = strpayty.getNumOfReg();

    for(int i=0; i < iNumOfReg; i++)
    {
       strpayty.setRegTot();
       String sStr = strpayty.getStr();
       String sReg = strpayty.getReg();
       String sSlReg = strpayty.getSlReg();
       String sSlCom = strpayty.getSlCom();
       String sSlHsv = strpayty.getSlHsv();
       String sSlBf = strpayty.getSlBf();
       String sSlLmo = strpayty.getSlLmo();
       String sSlTot = strpayty.getSlTot();

       String sHrReg = strpayty.getHrReg();
       String sHrCom = strpayty.getHrCom();
       String sHrHsv = strpayty.getHrHsv();
       String sHrBf = strpayty.getHrBf();
       String sHrLmo = strpayty.getHrLmo();
       String sHrTot = strpayty.getHrTot();
       
       String sHrHReg = strpayty.getHrHReg();
       String sHrHHsv = strpayty.getHrHHsv();
       String sHrHTot = strpayty.getHrHTot();

       String sStrReg = strpayty.getStrReg();
       String sStrCom = strpayty.getStrCom();
       String sStrHsv = strpayty.getStrHsv();
       String sStrBf = strpayty.getStrBf();
       String sStrLmo = strpayty.getStrLmo();
       String sStrTot = strpayty.getStrTot();

    %>
      <tr class="DataTable2">
         <td class="DataTable1" nowrap colspan=2><%=sStr%></td>

         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap><%=sSlReg%></td>
         <td class="DataTable" nowrap><%=sSlHsv%></td>
         <td class="DataTable" nowrap><%=sSlBf%></td>
         <td class="DataTable" nowrap><%=sSlCom%></td>
         <td class="DataTable" nowrap><%=sSlLmo%></td>
         <td class="DataTable" nowrap><%=sSlTot%></td>

         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap><%=sHrReg%></td>
         <td class="DataTable" nowrap><%=sHrHReg%></td>
         <td class="DataTable" nowrap><%=sHrHsv%></td>
         <td class="DataTable" nowrap><%=sHrHHsv%></td>
         <td class="DataTable" nowrap><%=sHrBf%></td>
         <td class="DataTable" nowrap><%=sHrCom%></td>
         <td class="DataTable" nowrap><%=sHrLmo%></td>
         <td class="DataTable" nowrap><%=sHrTot%></td>
         <td class="DataTable" nowrap><%=sHrHTot%></td>

         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap><%=sStrReg%></td>
         <td class="DataTable" nowrap><%=sStrHsv%></td>
         <td class="DataTable" nowrap><%=sStrBf%></td>
         <td class="DataTable" nowrap><%=sStrCom%></td>
         <td class="DataTable" nowrap><%=sStrLmo%></td>
         <td class="DataTable" nowrap><%=sStrTot%></td>
    <%}%>
    <%
       strpayty.setRepTot();
       String sStr = strpayty.getStr();
       String sReg = strpayty.getReg();
       String sSlReg = strpayty.getSlReg();
       String sSlCom = strpayty.getSlCom();
       String sSlHsv = strpayty.getSlHsv();
       String sSlBf = strpayty.getSlBf();
       String sSlLmo = strpayty.getSlLmo();
       String sSlTot = strpayty.getSlTot();

       String sHrReg = strpayty.getHrReg();
       String sHrCom = strpayty.getHrCom();
       String sHrHsv = strpayty.getHrHsv();
       String sHrBf = strpayty.getHrBf();
       String sHrLmo = strpayty.getHrLmo();
       String sHrTot = strpayty.getHrTot();
       
       String sHrHReg = strpayty.getHrHReg();
       String sHrHHsv = strpayty.getHrHHsv();
       String sHrHTot = strpayty.getHrHTot();

       String sStrReg = strpayty.getStrReg();
       String sStrCom = strpayty.getStrCom();
       String sStrHsv = strpayty.getStrHsv();
       String sStrBf = strpayty.getStrBf();
       String sStrLmo = strpayty.getStrLmo();
       String sStrTot = strpayty.getStrTot();
    %>
    <tr class="DataTable3">
         <td class="DataTable1" nowrap colspan=2><%=sStr%></td>

         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap><%=sSlReg%></td>
         <td class="DataTable" nowrap><%=sSlHsv%></td>
         <td class="DataTable" nowrap><%=sSlBf%></td>
         <td class="DataTable" nowrap><%=sSlCom%></td>
         <td class="DataTable" nowrap><%=sSlLmo%></td>
         <td class="DataTable" nowrap><%=sSlTot%></td>

         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap><%=sHrReg%></td>
         <td class="DataTable" nowrap><%=sHrHReg%></td>
         <td class="DataTable" nowrap><%=sHrHsv%></td>
         <td class="DataTable" nowrap><%=sHrHHsv%></td>
         <td class="DataTable" nowrap><%=sHrBf%></td>
         <td class="DataTable" nowrap><%=sHrCom%></td>
         <td class="DataTable" nowrap><%=sHrLmo%></td>
         <td class="DataTable" nowrap><%=sHrTot%></td>
         <td class="DataTable" nowrap><%=sHrHTot%></td>

         <th class="DataTable">&nbsp;</th>

         <td class="DataTable" nowrap><%=sStrReg%></td>
         <td class="DataTable" nowrap><%=sStrHsv%></td>
         <td class="DataTable" nowrap><%=sStrBf%></td>
         <td class="DataTable" nowrap><%=sStrCom%></td>
         <td class="DataTable" nowrap><%=sStrLmo%></td>
         <td class="DataTable" nowrap><%=sStrTot%></td>
 </table>
 <!----------------------- end of table ------------------------>
 <!----------------------- legend ------------------------------>
 <br>
 <table style="border:1px solid black; font-size:12px">
   <tr>
      <td>Regular: SL, HL, OT</td>
   </tr>
   <tr>
      <td>Benefit: H, S, V</td>
   </tr>
   <tr>
      <td>Bonus: B, F</td>
   </tr>
   <tr>
      <td>Commission: C</td>
   </tr>
   <tr>
      <td>Spiffs + Other: L, M, O</td>
   </tr>
 </table>
 <!----------------------- end of table ------------------------>

  </table>
 </body>
</html>
<%strpayty.disconnect();
  strpayty = null;
%>
<%}%>