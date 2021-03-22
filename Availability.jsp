<%@ page import="payrollreports.SetAvail, java.util.*"%>
<%
   String sStore = request.getParameter("STORE");
   String sThisStrName = request.getParameter("STRNAME");
   String [] sWkDay = new String[]{"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};

   SetAvail setAvl = null;
   setAvl =  new SetAvail(sStore);

   int iNumOfEmp = setAvl.getNumOfEmp();
   String [] sEmpNum = setAvl.getEmpNum();
   String [] sEmpName = setAvl.getEmpName();
   String [] sTitle = setAvl.getTitle();
   String sEmpNumJSA = setAvl.getEmpNumJSA();
   String sEmpNameJSA = setAvl.getEmpNameJSA();

   String [][] sDayAvail = setAvl.getDayAvail();
   String [][] sTimeAvail = setAvl.getTimeAvail();

   setAvl.disconnect();
   setAvl = null;

   // Hours/Minutes array
   String [] sHrsTxt = new String[]{"07","08","09","10","11","12",
                                 "01","02","03","04","05","06",
                                 "07","08","09","10","11","12"};
   String [] sHrs = new String[18];
   String [] sMin = new String[]{"00", "30"};
   for(int i=7; i<25;i++){
     sHrs[i-7] = Integer.toString(i);
     if (sHrs[i-7].length()== 1) {
        sHrs[i-7] = "0" + sHrs[i-7];
     }
   }
%>
<html>
<head>
<style>
 body {background:ivory;}
 a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
 a.Menu:link { color:black; text-decoration:none }
 a.Menu:visited { color:black; text-decoration:none }
 a.Menu:hover { color:red; text-decoration:none }

 table.DataTable { border: darkred solid 1px; background:#FFE4C4;text-align:center;}
 th.DataTable { background:#FFCC99; padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
 td.DataTable { background:lightgrey; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
 td.DataTable1 { background:cornsilk; border-top: darkred solid 1px; border-bottom: darkred solid 1px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }
 td.DataTable2 { background:white; border-top: darkred solid 1px; border-bottom: darkred solid 1px; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px }
 td.DataTable3 { background:lightgrey; cursor: hand; padding-top:3px; padding-bottom:3px; border-bottom: #FFE4C4 solid 1px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }

 td.Menu   {border-bottom: black solid 1px; cursor: hand; text-align:left; font-family:Arial; font-size:10px; }
 td.Menu2  {text-align:right; font-family:Arial; font-size:12px; }

 td.Grid  { background:darkblue; color:white; text-align:center; font-family:Arial; font-size:11px; font-weight:bolder}
 tr.Grid1 { text-align:center; font-family:Arial; font-size:10px;}
 td.Grid2  { background:darkblue; color:white; text-align:right; font-family:Arial; font-size:11px; font-weight:bolder}

 button.small{ padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:0px; text-align:center; font-family:Arial; font-size:10px;}

 th.EntTbl  { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; font-weight:bolder}
 td.EntTbl  { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }
 td.EntTbl1  { background:white; border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }
 td.EntTbl2  { background:red; border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:10px; }
 td.EntTbl3 { border-right: darkred solid 1px; border-bottom: darkred solid 1px; text-align:center; font-family:Arial; font-size:9px; }

 @media print {
 }

</style>
<SCRIPT language="JavaScript1.2">
var CurStore = <%=sStore%>;
var CurStrName = "<%=sThisStrName%>";
var CurStrName = "<%=sThisStrName%>";
var EmpNum = [<%=sEmpNumJSA%>];
var EmpName = [<%=sEmpNameJSA%>];
var WkDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

// selected employee and date
var selectedEmp;
var selEmpDays;

var savDate = new Array(7);
var savBegTim = new Array(7);
var savEndTim = new Array(7);
var savArg=-1;

// this variable use to keep selected time in hour entry table
var BegTime = null;
var EndTime = null;
var table = null;
var cells = null;

// Cell Menu - add delete selected employee / day of week
function CellMenu( obj, emp, day, dlt)
{
   var MenuName = null;
   var MenuDlt = " ";
   var MenuAdd = " ";
   var MenuOff = " ";
   var MenuClose = "<tr><td colspan='2' class='Menu' align='center' "
     + "onclick='hideMenu();'>Close"
     + "</td></tr>";

   if (day == null)
   {
     MenuName = "<td class='Menu' nowrap >" + EmpNum[emp] + " " + EmpName[emp] + "</td>";
     MenuDlt = "<tr><td class='Menu' onclick='dltAvlEntry(&#34;" + emp
      + "&#34;, null, &#34;EMPWEEK&#34;); hideMenu();'>Delete whole week</td></tr>";
     MenuAdd = "<tr><td class='Menu' onclick='selAvlDay(&#34;" +  emp
      + "&#34;); hideMenu();'>Add/Override</td></tr>";
   }
   else
   {
     MenuName = "<td class='Menu'  nowrap>" + EmpNum[emp] + " " + EmpName[emp] + " - "
       + WkDays[day] + " </td>";
     if(dlt != null){
       MenuDlt = "<tr><td class='Menu' onclick='dltAvlEntry(&#34;" + emp
         + "&#34;,&#34;" + (day) + "&#34;, &#34; &#34;); hideMenu();'>Delete</td></tr>";
     }
     MenuAdd = "<tr><td class='Menu' onclick='getDaySel(&#34;" + emp + "&#34;, "
      + "&#34;" + day + "&#34;); hideMenu();'>Add/Override</td></tr>";
     MenuOff = "<tr><td class='Menu' onclick='dayOffEntry(&#34;" + emp
         + "&#34;,&#34;" + (day) + "&#34;, &#34; &#34;); hideMenu();'>Not Available</td></tr>";
   }


   var curLeft = 0;
   var curTop = 0;

   var MenuHtml = "<table width='100%' cellPadding='0' cellSpacing='0'>"
   + "<tr>"
     + MenuName
     + "<td class='Menu2' valign=top>"
     +  "<img src='CloseButton.bmp' onclick='javascript:hideMenu();' alt='Close'>"
     + "</td>"
   + "</tr>"
   + MenuAdd
   + MenuOff
   + MenuDlt
   + MenuClose
   + "</table>";


   if (obj.offsetParent) {
   while (obj.offsetParent){
     curLeft += obj.offsetLeft
     curTop += obj.offsetTop
     obj = obj.offsetParent;
   }
 }
 else if (obj.x) {
    curLeft += obj.x;
    curTop += obj.y;
 }

 if (curTop > (document.documentElement.scrollTop + screen.height - 250))
    {
      curTop = document.documentElement.scrollTop + screen.height - 300;
    }
    curLeft += 70;
    if (curLeft > (document.documentElement.scrollLeft + screen.width - 200))
    {
      curLeft = document.documentElement.scrollLeft + screen.width - 200;
 }

 document.all.menu.innerHTML=MenuHtml
 document.all.menu.style.pixelLeft=curLeft
 document.all.menu.style.pixelTop=curTop
 document.all.menu.style.visibility="visible"
}

function selAvlDay(emp)
{
var MenuName = " ";
  var param = null;

  var MenuHtml = "<table cellPadding='0' cellSpacing='0' width='100%'>"

    param = "&#34;" + emp + "&#34;";
    MenuHtml += "<tr align='center'>"
      + "<td class='Grid'>"+ EmpNum[emp] + " " + EmpName[emp]
      + " - Select Date</td>"
      + "<td  class='Grid'>"
      + "<img src='CloseButton.bmp' onclick='javascript:hidemenu2();' alt='Close'>"
      + "</td></tr>"


  MenuHtml +=
      "<tr><td>Days:"
    + "<input name='DAY1' type='checkbox' value='0' >Mon"
    + "<input name='DAY2' type='checkbox' value='1' >Tue"
    + "<input name='DAY3' type='checkbox' value='2' >Wed"
    + "<input name='DAY4' type='checkbox' value='3' >Thu"
    + "<input name='DAY5' type='checkbox' value='4' >Fri"
    + "<input name='DAY6' type='checkbox' value='5' >Sat"
    + "<input name='DAY7' type='checkbox' value='6' >Sun"
    + "</td></tr>"
    + "<tr align='center'><td>"
    + "&nbsp;&nbsp;<button class='small' name='getEmp' onclick='getDaySel("
    + param + ", null)'>Continue</button>"
    + "&nbsp;&nbsp;<button class='small' name='chkDays' onclick='chgAlldays(true)'>All Days</button>"
    + "&nbsp;&nbsp;<button class='small' name='chkDays' onclick='chgAlldays(false)'>Reset</button>"
    + "&nbsp;&nbsp;<button class='small' name='close' onclick='hidemenu2()'>Close</button><br>&nbsp;</td></tr>"
    + "</table>"

    MenuHtml += "</table>"

    document.all.menu2.innerHTML=MenuHtml
    document.all.menu2.style.pixelLeft=150
    document.all.menu2.style.pixelTop=document.documentElement.scrollTop+20
    document.all.menu2.style.visibility="visible"

}

// get employee and days
function getDaySel(emp, day){

 if (day == null)
 {
   selectedEmp = emp;
   selEmpDays = [document.all('DAY1').checked, document.all('DAY2').checked,
          document.all('DAY3').checked, document.all('DAY4').checked,
          document.all('DAY5').checked, document.all('DAY6').checked,
          document.all('DAY7').checked]
 }
 else
 {
   hideMenu();
   selectedEmp = emp;
   selEmpDays = new Array(7)
   for(i=0; i<7; i++){
     if (i==day){ selEmpDays[i] = true; }
     else { selEmpDays[i] = false; }
   }
 }

 // Show event detail entry
 if (ValidateHdr()){
   for(i=0;i<7;i++)
   {
     if (selEmpDays[i]==true)
     {
        selEmpDays[i]=false;
        showEmpAvailEntry(selectedEmp, i);
        break;
     }
   }
 }
}

// Employee Availability Entry box
function showEmpAvailEntry(emp, day)
{
    var MenuHtml = "<table cellPadding='0' cellSpacing='0' width='100%'>"

    MenuHtml += "<tr align='center'>"
      + "<td class='Grid'>" + EmpNum[emp] + " " +EmpName[emp]
      + " - " + WkDays[day] + "</td>"
      + "<td class='Grid2'>"
      + "<img src='CloseButton.bmp' onclick='javascript:hidemenu2();' alt='Close'>"
      + "</td></tr>"


  MenuHtml +=
      "<tr class='Grid1'><td colspan='2'>"

    + "<table class='DataTable' cellPadding='0' cellSpacing='0' id='TbHrsEnt'>"
    + "<tr><td class='EntTbl' colspan='50' nowrap>"
    + "Hours Entry - click on white cells to select a time employee is available,<br>to change - click on reset button"
    + "</td></tr>"
    + "<tr>"
    + "<td class='EntTbl' rowspan='2'><button class='small' name='ResetEntry' type='button' DISABLED onclick='resetHrs();'>Reset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button></td>"
      <%for(int i=0; i < sHrs.length;i++){
             if(i == sHrs.length-1) {%>
              + "<td class='EntTbl'><%=sHrsTxt[i]%></td>"
      <%}
             else {%>
              + "<td class='EntTbl' colspan='<%=sMin.length%>'><%=sHrsTxt[i]%></td>"
           <%}%>
         <%}%>
     + "</tr>"
     + "<tr >"
         <%for(int i=0, k=0; i < (sHrs.length * sMin.length-1); i++, k++){
             if(k >= sMin.length) k=0; %>
           + "<td class='EntTbl3'><%=sMin[k]%></td>"
         <%}%>
      +  "</tr>"
      +  "<tr>"
      + "<td class='EntTbl'>"
      + "<button class='small' name='Available' disabled"
      + " onclick='if (ValidateDtl() ){ savSingleDay(&#34;"
      + day + "&#34;,false);}'>Available</button>"
      + "</td>"

       <% for(int i=0; i < sHrs.length; i++){ %>
         <% for(int k=0; k < sMin.length; k++){%>
      +  "<td class='EntTbl1' id='<%=sHrs[i]%><%=sMin[k]%>' onclick='enterTime(this);'>&nbsp;</td>"
             <%if(i == sHrs.length-1) break;
            }%>
        <%}%>
      + "</tr>"

      + "<tr>"
      + "<td class='EntTbl'><button class='small' name='DAYOFF' type='button'"
      + " onclick='WholeDay(&#34;" + day + "&#34;);'>Not Available</button></td>"
      + "<td class='EntTbl' colspan='35'>&nbsp;</td> "
      + "</tr>"

      + "<tr><td class='EntTbl'>&nbsp;</td>"
      + "<td class='EntTbl' colspan='9'>Beginning at:&nbsp;&nbsp;</td> "
      + "<td class='EntTbl' colspan='8'><div class='shwTime' id='dvBegTime' >&nbsp;</div></td>"
      + "<td class='EntTbl' colspan='9'>Ending at:&nbsp;&nbsp;</td>"
      + "<td class='EntTbl' colspan='9'><div class='shwTime' id='dvEndTime'>&nbsp;</div></td>"
      + "</tr>"
      + "</table>"

    + "</td></tr>"
    + "<tr class='Grid1' align='center'><td nowrap  colspan='2'>"
    + "&nbsp;&nbsp;<button class='small' name='close' "
    + "onclick='savSingleDay(&#34;" + day + "&#34;, true)'>Skip</button>"
    + "<input name='ApplyToAll' type='checkbox' value='APPLY'>"
    + "Apply to all days</td></tr>"

    MenuHtml += "</table>"

    document.all.menu2.innerHTML=MenuHtml
    document.all.menu2.style.pixelLeft=150
    document.all.menu2.style.pixelTop=document.documentElement.scrollTop+20
    document.all.menu2.style.visibility="visible"
}


// reset hours by resetentry button
function resetHrs(){
 if(cells!=null){
   for(var i=0; i < cells.length; i++){
     if (cells.item(i).id >= "0700" && cells.item(i).id <= "2400")
     cells.item(i).className="EntTbl1";
   }
 }

 BegTime = null;
 EndTime = null;
 table = null;
 cells = null;

 document.all.ResetEntry.disabled = true;
 document.all.Available.disabled = true;

 document.all.dvBegTime.innerHTML= null;
 document.all.dvBegTime.style.visibility="hidden"
 document.all.dvEndTime.innerHTML= null;
 document.all.dvEndTime.style.visibility="hidden"
}


// validate Employee Day Selection
function ValidateDtl()
{
  var msg = '';
  var error = false;
  var fnd = false;
  var sel = false;

  if(error) alert(msg);
  return error == false;
}

// validate Employee Day Selection
function ValidateHdr()
{
  var msg = '';
  var error = false;
  var fnd = false;
  var sel = false;

  // check selected days
  for(i=0;i<7;i++)
  {
    if(selEmpDays[i] == true)  sel=true;
  }

  if(!sel)
  {
      msg += "Please check at least one day. \n";
      error = true;
  }

  if(error) alert(msg);
  return error == false;
}


// Check / unckeck event dates
function chgAlldays(check)
{
  document.all('DAY1').checked=check; document.all('DAY2').checked=check
  document.all('DAY3').checked=check; document.all('DAY4').checked=check
  document.all('DAY5').checked=check; document.all('DAY6').checked=check;
  document.all('DAY7').checked=check;
}

// save entered availalble time
function enterTime(cur)
{
 var id = cur.id;
 document.all.ResetEntry.disabled = false;

 if (BegTime != null && EndTime != null){
  return; // do not allow to enter more then 2 cells
 }

 if(cur.className=="EntTbl1") {
    cur.className="EntTbl2"
    if (BegTime == null)
    {
        BegTime = cur.id;
    }
    else if(BegTime != cur.id ) {EndTime = cur.id; }
 }

 // initialized table and cells variables
 if(table == null)
 {
    table = document.getElementById("TbHrsEnt");
    cells = table.getElementsByTagName("td");
  }

 // change color for all cells includeed in working time
 if (BegTime != null && EndTime != null)
 {
  document.all.Available.disabled = false;
  var found = false;
  // fix error when in time greater than hout time
  if (BegTime > EndTime){
      var saveTime = BegTime;
      BegTime = EndTime;
      EndTime = saveTime;
  }
  // change cell b-colors - to include all ceels between selected hours
  for(var i=0; i < cells.length; i++){
    if (cells.item(i).id == BegTime){  found = true; }
    if (found){ cells.item(i).className="EntTbl2"; }
    if (cells.item(i).id == EndTime){ found = false; }
  }
 }
 popupWorkHours(cur);
}

// Update readonly field that show selected times
function popupWorkHours(cur){
  if (BegTime != null){
    var hrs  = BegTime.substring(0,2)
    var type = " AM"
    if (hrs > "12" && hrs < "24") {
        hrs = hrs - 12;
        type = " PM"
    }
    else if (hrs == "12") {
        hrs = 12;
        type = " PM"
    }
    else if (hrs == "24") {
        hrs = 12;
        type = " AM"
    }
    var min = BegTime.substring(2,4);
    document.all.dvBegTime.innerHTML= hrs + ":" + min + type
    document.all.dvBegTime.style.visibility="visible"
  }

  if (EndTime != null){
    var hrs  = EndTime.substring(0,2)
    var type = " AM"
    if (hrs > "12" && hrs < "24") {
        hrs = hrs - 12;
        type = " PM"
    }
    else if (hrs == "12") {
        hrs = 12;
        type = " PM"
    }
    else if (hrs == "24") {
        hrs = 12;
        type = " AM"
    }
    var min = EndTime.substring(2,4);
    document.all.dvEndTime.innerHTML= hrs + ":" + min + type
    document.all.dvEndTime.style.visibility="visible"

  }
}




// save single day time entry, show next selected day
function savSingleDay(day, skip)
{
  var found = false
  var apply = false;
  if (!skip)
  {
    savArg++;
    savDate[savArg] = day;
    savBegTim[savArg] = BegTime.substring(0,2) + ":" + BegTime.substring(2,4);
    savEndTim[savArg] = EndTime.substring(0,2) + ":" + EndTime.substring(2,4);

    // apply time for all selected days
    apply = document.all.ApplyToAll.checked;
     if(apply){
      for(i=0;i<7;i++){
        if (selEmpDays[i]==true){
            savArg++;
            savDate[savArg] = i;
            savBegTim[savArg] = BegTime.substring(0,2) + ":" + BegTime.substring(2,4);
            savEndTim[savArg] = EndTime.substring(0,2) + ":" + EndTime.substring(2,4);
            selEmpDays[i]=false;
        }
      }
    }
  }

  // show next selected day
  BegTime = null;
  EndTime = null;
  table = null;
  cells = null;



  for(i=0;i<7;i++){
    if (selEmpDays[i]==true){
        selEmpDays[i]=false;
        showEmpAvailEntry(selectedEmp, i);
        found = true;
        break;
    }
  }

  // submit hours entry requirements after schedule entered for all selected dates

  if (!found && savArg >=0){
    submit();
  }
  else if (!found) hidemenu2();
}

// Employee unavailable whloe day
function WholeDay(day)
{
var found = false
  var apply = false;

    savArg++;
    savDate[savArg] = day;
    savBegTim[savArg] = "00:00";
    savEndTim[savArg] = "00:00";

    // apply time for all selected days
    apply = document.all.ApplyToAll.checked;
    if(apply){
      for(i=0;i<7;i++){
        if (selEmpDays[i]==true){
            savArg++;
            savDate[savArg] = i;
            savBegTim[savArg] = "00:00";
            savEndTim[savArg] = "00:00";
            selEmpDays[i]=false;
        }
      }
    }

  // show next selected day
  BegTime = null;
  EndTime = null;
  table = null;
  cells = null;

  for(i=0;i<7;i++){
    if (selEmpDays[i]==true){
        selEmpDays[i]=false;
        showEmpAvailEntry(selectedEmp, i);
        found = true;
        break;
    }
  }

  // submit hours entry requirements after schedule entered for all selected dates
  if (!found && savArg >=0){
    submit();
  }
  else if (!found) hidemenu2();
}


// add/override entry
function submit(){
  var selEmpNum = EmpNum[selectedEmp]

  hidemenu2();

  // change action string
  SbmString = "SavAvlEnt.jsp?STORE=" + CurStore
                + "&STRNAME=" + CurStrName
                + "&EMPNUM=" + selEmpNum
                + "&ACTION=ADD";

for (i=0;i<=savArg;i++)
{
    SbmString = SbmString + "&WKDATE" + i + "=" + savDate[i]
              + "&BEGTIME" + i + "=" + savBegTim[i]
              + "&ENDTIME" + i + "=" + savEndTim[i];
}
  //alert(SbmString)
  window.location.href = SbmString;
}

// Delete availability entry
function dltAvlEntry(emp, day, range)
{
if(day==null) day="0";
if(range==null) range=" "
  SbmString = "SavAvlEnt.jsp?STORE=" + CurStore
                + "&STRNAME=" + CurStrName
                + "&EMPNUM=" + EmpNum[emp]
                + "&ACTION=DLT"
                + "&ACTRANGE=" + range
                + "&WKDATE0=" + day
                + "&BEGTIME0=00:00"
                + "&ENDTIME0=00:00";

  //alert(SbmString);
  window.location.href=SbmString;
}

// Day Off entry
function dayOffEntry(emp, day, range)
{
if(day==null) day="0";
if(range==null) range=" "
  SbmString = "SavAvlEnt.jsp?STORE=" + CurStore
                + "&STRNAME=" + CurStrName
                + "&EMPNUM=" + EmpNum[emp]
                + "&ACTION=ADD"
                + "&ACTRANGE=" + range
                + "&WKDATE0=" + day
                + "&BEGTIME0=00:00"
                + "&ENDTIME0=00:00";

  //alert(SbmString);
  window.location.href=SbmString;
}

//========================================================================
// close drop menu
function hideMenu(){
  BegTime = null;
  EndTime = null;
  table = null;
  cells = null;

    document.all.menu.style.visibility="hidden"
}
// close menu
function hidemenu2(){
    document.all.menu2.style.visibility="hidden"
}


</SCRIPT>
</head>
<!-------------------------------------------------------------------->
<body>
<!-------------------------------------------------------------------->
<div id="menu" style="position:absolute;visibility:hidden; background-attachment: scroll;
              border: black solid 3px; width:150px;background-color:Azure; z-index:10;
              text-align:center"></div>

<div id="menu2" style="position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:150px;background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px"></div>
<!-------------------------------------------------------------------->
  <table border="0" width="100%" height="100%" cellPadding="0" cellSpacing="0">
     <tr bgColor="moccasin" height="10%"><td ALIGN="center" VALIGN="TOP" colspan="3">
      <b>Employee Availability</b>
      <br><b>&nbsp;Store:&nbsp;<%=sStore + " - " + sThisStrName%></b>
      <br>
        <a href="mailto:"><font color="red" size="-1">E-mail</font></a>;&nbsp;
        <a href="/"><font color="red" size="-1">Home</font></a>&#62;
        <!--a href="StrScheduling.html"><font color="red" size="-1">Payroll</font></a -->
        <a href="AvailSel.jsp"><font color="red" size="-1">Store Selector</font></a>&#62;
         This page
         <br>Time - Available time;&nbsp;&nbsp;&nbsp;
             <img src="green_clr.bmp"> - Available;&nbsp;&nbsp;&nbsp;
             <img src="red_clr.bmp"> - Not available.
       </td>
     </tr>

     <!-------------------------- start data table ---------------------------->
     <tr bgColor="moccasin"><td ALIGN="center" VALIGN="TOP" colspan="3">
      <table class="DataTable" cellPadding="0" cellSpacing="0">
         <tr>
           <th class="DataTable" >Emp<br>#</th>
           <th class="DataTable" >Emp<br>Name</th>
           <th class="DataTable" >Title</th>
           <%for(int i=0; i < 7; i++){%>
              <th class="DataTable"><%=sWkDay[i]%></th>
           <%}%>
      <!-------------------------- details ------------------------------------>
          <%for(int i=0; i < iNumOfEmp; i++){%>
          <tr>
              <td class="DataTable" ><%=sEmpNum[i]%>&#160;</td>
              <td class="DataTable3" id="EMP<%=sEmpNum[i]%>"
                  onClick="CellMenu(this, <%=i%>, null, null);">&#160;<%=sEmpName[i]%>&#160;</td>
              <td class="DataTable" ><%=sTitle[i]%></td>

              <%System.out.print("\n" + sEmpName[i]);%>

              <%for(int k=0; k < 7; k++){%>
                <%System.out.print("\n   " + "A:" + sDayAvail[i][k] + " T:"  + sTimeAvail[i][k]);%>
                <%if(sDayAvail[i][k].equals("0")){%>
                  <td class="DataTable2" id="EMP<%=sEmpNum[i]+k%>"
                       onClick="CellMenu(this, <%=i%>, <%=k%>, null);">
                       <img src="green_clr.bmp"  WIDTH=60 HEIGHT=12 >
                  </td>
                <%}
                else if(sDayAvail[i][k].equals("1")){%>
                   <td class="DataTable2" id="EMP<%=sEmpNum[i]+k%>"
                        onClick="CellMenu(this, <%=i%>, <%=k%>, 1);">
                        <img src="red_clr.bmp"  WIDTH=60 HEIGHT=12></td>
                <%}
                else if(sDayAvail[i][k].equals("2")){%>
                   <td class="DataTable2" id="EMP<%=sEmpNum[i]+k%>"
                        onClick="CellMenu(this, <%=i%>, <%=k%>, 2);">
                        <%=sTimeAvail[i][k]%></td>
                <%}%>
              <%}%>
          </tr>
          <%}%>
      <!------------------- end of details ------------------------------------>
         </tr>
      </table>
     </tr>
     <!----------------------- end data table --------------------------------->
  </table>
</body>
</html>
