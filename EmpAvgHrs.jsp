<%@ page import="payrollreports.EmpAvgHrs,java.util.*, java.text.*, rciutility.StoreSelect, java.math.*"%>
<%
   String [] sStore = request.getParameterValues("Str");
   String sFrom = request.getParameter("FrWeek");
   String sTo = request.getParameter("ToWeek");
   String [] sIncl = request.getParameterValues("Incl");
   String [] sTtlExc = request.getParameterValues("TtlExc");
   String sActEmp = request.getParameter("ActEmp");
   String sNumOfHrs = request.getParameter("NumHrs");
   String sSort = request.getParameter("Sort");

   if(sSort==null) { sSort="NAMEASCN"; }
String sAppl="BASIC1";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EmpAvgHrs.jsp&APPL=" + sAppl + "&" + request.getQueryString());
}
else
{
   String sUser = session.getAttribute("USER").toString();

   String sStrAllowed = null;
   StoreSelect strsel = new StoreSelect();
   String sAllStr = strsel.getStrNum();
   String sReg = strsel.getStrReg();

   EmpAvgHrs empavg = new EmpAvgHrs(sStore, sFrom, sTo, sIncl, sActEmp, sNumOfHrs
          , sTtlExc, sSort, sUser);
   String sStrjsa = empavg.cvtToJavaScriptArray(sStore);
   String sIncljsa = empavg.cvtToJavaScriptArray(sIncl);
   String sTtlExcjsa = empavg.cvtToJavaScriptArray(sTtlExc);
%>

<html>
<head>
<title>Emp Avg Hrs</title>

<style>
  body {background:cornsilk; text-align:center;}
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

  tr.DataTable { background:#efefef; font-family:Arial; font-size:10px }
  tr.DataTable1 { background:cornsilk; font-family:Arial; font-size:10px }
  tr.Divider{ background:darkred; font-size:1px }

  td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}
  td.DataTabler { background:red; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}
  td.DataTable1{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;}
  td.DataTable2{ padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:left;
                 font-size:12px; font-weight:bold}

  td.TYCell { background:cornsilk; padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px; text-align:right;}

  div.dvSelect { position:absolute; top: expression(this.offsetParent.scrollTop + 10);
               left: expression(this.offsetParent.scrollLeft + 10); 
              background-attachment: scroll;
              border: black solid 2px; width:250px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}
              
  #dvNote1 { position:absolute; top: expression(this.offsetParent.scrollTop + 50);
               left: 10;
               background-attachment: scroll; border: MidnightBlue solid 2px; width:450px;
               background-color:LemonChiffon; text-align:center; font-size:12px}
               
  #dvNote2 { position:absolute; top: expression(this.offsetParent.scrollTop + 50);
               left: 900;
               background-attachment: scroll; border: MidnightBlue solid 2px; width:450px;
               background-color:LemonChiffon; text-align:center; font-size:12px}
              

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

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var ArrStr = [<%=sAllStr%>];
var ArrSelStr = [<%=sStrjsa%>];
var ArrIncl = [<%=sIncljsa%>];
var ArrTtlExc = [<%=sTtlExcjsa%>];
var FrWeek = "<%=sFrom%>";
var ToWeek = "<%=sTo%>";
var Sort = "<%=sSort%>";
var ActEmp = "<%=sActEmp%>";
var NumOfHrs = "<%=sNumOfHrs%>";
var strReg = [<%=sReg%>];

var TblWithFxd = "#tbl01";
var FixedHdrFtr = {hdr: ["#trTopHdr1", "#trTopHdr2", "#trTopHdr3"], footer:[] , bottom:[]};


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

   // populate from week with to week if litteral range selected
   if(FrWeek == "WTD" || FrWeek == "MTD" || FrWeek == "YTD" || FrWeek == "PMN")
   {
      document.all.FrWeek.value = ToWeek;
      document.all.ToWeek.value = ToWeek;
   }
   else
   {
     document.all.FrWeek.value = FrWeek;
     document.all.ToWeek.value = ToWeek;
   }
   // setup date range
   var grp = document.all.DtGrp;
   for(var i=0; i < grp.length; i++)
   {
      if(FrWeek == grp[i].value){ grp[i].checked = true; break; }
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

   var incl = document.all.Incl;
   for(var i=0; i < incl.length; i++)
   {
      if(ArrIncl[i]==incl[i].value){ incl[i].checked = true;}
      else{ incl[i].checked == false; }
   }

   var ttl = document.all.Title;
   for(var i=0; i < ttl.length; i++)
   {
      for(var j=0; j < ArrTtlExc.length; j++)
      {
         if(ArrTtlExc[j]==ttl[i].value){ ttl[i].checked = true;}
         else{ ttl[i].checked == false; }
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
     + "<tr id='trDt1'  style='background:azure'>"
        + "<td class='Prompt' colspan=3 style='display:none'>"
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

     + "<tr style='background:#ccffcc'>"
       + "<td class='Prompt1' colspan=3><u>Employee Groups</u></td>"
     + "</tr>"
     + "<tr style='background:#ccffcc'>"
       + "<td class='Prompt1' colspan=3>"
          + "<table border=0>"
              + "<tr>"
                  + "<td class='Small' nowrap><input type='checkbox' class='Small' name='Incl' value='H'>Hourly</td>"
                  + "<td class='Small' nowrap><input type='checkbox' class='Small' name='Incl' value='S'>Salaried</td>"
              + "</tr>"
            + "</table>"
       + "</td>"
     + "</tr>"

     + "<tr style='background:#ccffcc'>"
       + "<td class='Prompt1' colspan=3><u>Active/Inactive Employees</u></td>"
     + "</tr>"
     + "<tr style='background:#ccffcc; text-align:center;'>"
       + "<td class='Small' colspan=3><input type='radio' class='Small' name='Active' value='1' checked>Active &nbsp; &nbsp; "
       + "<input type='radio' class='Small' name='Active' value='2'>Inactive(termed) &nbsp; &nbsp; "
       + "<input type='radio' class='Small' name='Active' value='3'>Any</td>"
     + "</tr>"
     + "<tr style='background:#cccfff'>"
       + "<td class='Prompt2' nowrap colspan=2>Number Of Hours:</td>"
       + "<td class='Prompt' nowrap><input class='Small' name='NumOfHrs' value='30' size=4 maxlength=4></td>"
     + "</tr>"

     + "<tr style='background:#cccfff'>"
       + "<td class='Prompt2' colspan=2>Exclude:</td>"
       + "<td  class='Prompt'>"
       + "<table border=0>"
          + "<tr>"
             + "<td class='Small'><input type='checkbox' class='Small' name='Title' value='40'>40</td>"
             + "<td class='Small'><input type='checkbox' class='Small' name='Title' value='PT'>PT</td>"
             + "<td class='Small'><input type='checkbox' class='Small' name='Title' value='SE'>SE</td>"
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

   var grp = document.all.DtGrp;
   var grpnum = 0;
   for(var i=0; i < grp.length; i++)
   {
      if(grp[i].checked && i < grp.length-1)
      {
         grpnum=i;
         selFrWeek = grp[i].value;
         break;
      }
   }

   // get Included employees
   var incl = document.all.Incl;
   var selincl = new Array();
   var bIncl = false;
   for(var i=0, j=0; i < incl.length; i++)
   {
     if(incl[i].checked){ selincl[j] = incl[i].value; bIncl = true; }
     else { selincl[j] = "N"}
     j++;
   }
   if (!bIncl){ error=true; msg+="\nAt least 1 employee group must be selected."; }

   // get Included employees
   var active = document.all.Active;
   var selact = "1";
   for(var i=0; i < active.length; i++)
   {
     if(active[i].checked){ selact = active[i].value; }
   }

   var numhrs = document.all.NumOfHrs.value.trim()
   if(isNaN(numhrs) || eval(numhrs) < 0){ error=true; msg+="\nThe Number of Hours is invalid."; }

   // get Included employees
   var ttl = document.all.Title;
   var selttl = new Array();
   for(var i=0, j=0; i < ttl.length; i++)
   {
     if(ttl[i].checked){ selttl[j] = ttl[i].value; j++}
   }
   if(selttl.length == 0){url += "&TtlExc=NONE";}

   if(error){alert(msg)}
   else{ submitForm(selstr, selFrWeek, selToWeek, selincl, numhrs, selact, selttl) }
}
//==============================================================================
// change action on submit
//==============================================================================
function submitForm(selstr, selFrWeek, selToWeek, selincl, numhrs, selact, selttl){
   var url;

   url = "EmpAvgHrs.jsp?FrWeek=" + selFrWeek + "&ToWeek=" + selToWeek;
   for(var i=0; i < selstr.length; i++)
   {
     url += "&Str=" + selstr[i];
   }

   for(var i=0; i < selincl.length; i++)
   {
     url += "&Incl=" + selincl[i];
   }

   for(var i=0; i < selttl.length; i++)
   {
     url += "&TtlExc=" + selttl[i];
   }
   if(selttl.length == 0){url += "&TtlExc=NONE";}

   url += "&ActEmp=" + selact
     + "&NumHrs=" + numhrs;

   //alert(url);
   window.location.href=url;
}
//==============================================================================
// show another selected week
//==============================================================================
function resort(sort)
{
   //Incl=H Incl=N ActEmp=1 NumHrs=10 TtlExc=NONE
   //Incl=H Incl=N Sort=HRSASCN ActEmp=1 NumHrs=10
   var url = "EmpAvgHrs.jsp?"
    + "FrWeek=<%=sFrom%>"
    + "&ToWeek=<%=sTo%>"
    ;
   for(var i=0; i < ArrSelStr.length; i++) { url += "&Str=" + ArrSelStr[i]; }
   for(var i=0; i < ArrIncl.length; i++) { url += "&Incl=" + ArrIncl[i]; }
   for(var i=0; i < ArrTtlExc.length; i++) { url += "&TtlExc=" + ArrTtlExc[i]; }

   url += "&Sort=" + sort
        + "&ActEmp=" + ActEmp
        + "&NumHrs=" + NumOfHrs

   //alert(url)
   window.location.href=url;
}
</SCRIPT>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script src="scripts/TableFixedHeaderFooter/tbl_fixed_hdr_ftr.js"></script>

</head>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<body onload="bodyload()">
<!-------------------------------------------------------------------->
<div id="dvSelect" class="dvSelect"></div>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
 <table  id="tbl01" class="DataTable" border=1 cellPadding="0" cellSpacing="0">
   <tr id="trTopHdr1" style="background:cornsilk;">
      <td ALIGN="center" VALIGN="TOP" nowrap colspan=16>
      <b>Retail Concepts, Inc
      <br>Employee Average Hours
      <br>Store:
       <%String sComa="";%>
       <%for(int i=0; i < sStore.length; i++){%><%=sComa + sStore[i]%><%sComa=", ";%><%}%>
      <br>
          Weekending dates: <%=sFrom%> - <%=sTo%>
      <br>

      <a href="/"><font color="red" size="-1">Home</font></a>&#62;
      <a href="EmpAvgHrsSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
      <font size="-1">This Page.</font>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp
      </td>
   </tr>
 
  <!----------------- beginning of table ------------------------>
  
    <tr id="trTopHdr2">
      <th class="DataTable">Str</th>
      <th class="DataTable">Emp #</th>
      <th class="DataTable">Employee Name</th>
      <th class="DataTable" >Dept</th>
      <th class="DataTable">Title</th>
      <th class="DataTable">Hire<br>Date</th>
      <th class="DataTable">H or S</th>
      <th class="DataTable">Sales<br>Comm.</th>
      <th class="DataTable">Hrs</th>
      <th class="DataTable">ACA Avg<br>Hrs<br>Per Week<sup style="color:red;">*</sup></th>
      <th class="DataTable">Avg<br>Hrs<br>Per Week<sup style="color:red;">**</sup></th>
      <th class="DataTable">Days in<br>Measured<br>Period</th>
      <!-- th class="DataTable">Days<br>This Year</th -->
      <th class="DataTable">Last Week<br>Sched. Hrs</th>
      <th class="DataTable">Last Week<br>Actual Hrs</th>
      <th class="DataTable">Current Week<br>Sched. Hrs</th>
      <th class="DataTable">Next Week<br>Sched. Hrs</th>
    </tr>


    <tr  id="trTopHdr3">
      <th class="DataTable" nowrap>
        <a href="javascript: resort('STRDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('STRASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('EMPNDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('EMPNASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('NAMEDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('NAMEASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('DEPTDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('DEPTASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('TITLEDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('TITLEASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('HIREDTDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('HIREDTASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('HORSDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('HORSASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('SCOMDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('SCOMASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('HRSDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('HRSASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">&nbsp;
        <!-- a href="javascript: resort('AVGDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('AVGASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a-->
      </th>
      <th class="DataTable">&nbsp;</th>
      <th class="DataTable">
        <a href="javascript: resort('DAYSDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('DAYSASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <!-- th class="DataTable">
        <a href="javascript: resort('YTDDDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('YTDDASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th -->

      <th class="DataTable">
        <a href="javascript: resort('LWSCHDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('LWSCHASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      <th class="DataTable">
        <a href="javascript: resort('LWACTDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('LWACTASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
      
      <th class="DataTable">
        <a href="javascript: resort('CURRDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('CURRASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>

      <th class="DataTable">
        <a href="javascript: resort('NEXTDESC')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a>
        <a href="javascript: resort('NEXTASCN')"><img src="arrowUpGreen.png" style="border:none; width=10px; height=10px;"  alt="Ascending"></a>
      </th>
    </tr>
<!--------------------------------- Group Totals ----------------------------->
    <%boolean bRow = false;
      while(empavg.getNext())
    {
        empavg.setEmpLst();
        String sStr = empavg.getStr();
        String sEmp = empavg.getEmp();
        String sEmpNm = empavg.getEmpNm();
        String sDept = empavg.getDept();
        String sTitle = empavg.getTitle();
        String sHorS = empavg.getHorS();
        String sSCom = empavg.getSCom();
        String sHrs = empavg.getHrs();
        String sAvg = empavg.getAvg();
        String sDays = empavg.getDays();
        String sCurrWkSch = empavg.getCurrWkSch();
        String sNextWkSch = empavg.getNextWkSch();
        String sYtdDays = empavg.getYtdDays();
        String sHireDt = empavg.getHireDt();
        String sLastWkSch = empavg.getLastWkSch();
        String sLwActHrs = empavg.getLwActHrs();
        String sAcaAvg = empavg.getAcaAvg();
        
        BigDecimal bgLwSch = new BigDecimal(sLastWkSch);
        BigDecimal bgLwAct = new BigDecimal(sLwActHrs);
        String sLwClr = "";
        
        if(bgLwSch.compareTo(bgLwAct) < 0){sLwClr = "r";}        	
    %>
       <tr class="DataTable<%if(bRow){%>1<%}%><%bRow = !bRow;%>">
         <td class="DataTable" nowrap><%=sStr%></td>
         <td class="DataTable" nowrap><%=sEmp%></td>
         <td class="DataTable1" nowrap><%=sEmpNm%></td>
         <td class="DataTable1" nowrap><%=sDept%></td>
         <td class="DataTable1" nowrap><%=sTitle%></td>
         <td class="DataTable1" nowrap><%=sHireDt%></td>
         <td class="DataTable3" nowrap><%=sHorS%></td>
         <td class="DataTable3" nowrap>&nbsp;<%=sSCom%>&nbsp;</td>
         <td class="DataTable" nowrap><%=sHrs%></td>
         <td class="DataTable" nowrap><%=sAcaAvg%></td>
         <td class="DataTable" nowrap><%=sAvg%></td>
         <td class="DataTable" nowrap><%=sDays%></td>
         <!-- td class="DataTable" nowrap><%=sYtdDays%></td -->
         <td class="DataTable" nowrap><%=sLastWkSch%></td>
         <td class="DataTable<%=sLwClr%>" nowrap><%=sLwActHrs%></td>
         <td class="DataTable" nowrap><%=sCurrWkSch%></td>
         <td class="DataTable" nowrap><%=sNextWkSch%></td>
       </tr>
    <%}%>
<!-------------------------- end of Group Totals ----------------------------->
 </table>
 <!----------------------- end of table ------------------------>
  </table>
  
  <div  id="dvNote1">
    <sup style="color:red;">*</sup> - "ACA Avg Hrs per week" takes the hours worked in the date range of the report and divides it by the number of weeks in that date range. This INCLUDES weeks they may have not worked.
  </div>
  
  <div id="dvNote2">
    <sup style="color:red;">**</sup> - "Avg Hrs per week"" is the number of hours worked divided by ONLY the weeks worked
  </div>
   
  
 </body>
</html>
<%empavg.disconnect();
  empavg = null;
%>
<%}%>