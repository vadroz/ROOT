<%@ page import="rciutility.ClassSelect"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null )
   {
     response.sendRedirect("SignOn1.jsp?TARGET=SlsSumRepSel.jsp&APPL=ALL");
   }
   else
   {

      ClassSelect divsel = null;

      String sDiv = null;
      String sDivName = null;
      String sDpt = null;
      String sDptName = null;
      String sDptGroup = null;
      String sCls = null;
      String sClsName = null;

      divsel = new ClassSelect();
      sDiv = divsel.getDivNum();
      sDivName = divsel.getDivName();
      sDpt = divsel.getDptNum();
      sDptName = divsel.getDptName();
      sDptGroup = divsel.getDptGroup();
%>

<style>
  .Small {font-family: times; font-size:10px; vertical-align:top;}
  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top}
  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
        width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  </style>

<script LANGUAGE="JavaScript" src="Calendar.js">
</script>


<script name="javascript">
var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";
var MaxVenSel=0;

var WeekDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  doDivSelect(null);
  document.all.tdDate1.style.display="block"
  document.all.tdDate2.style.display="none"
  document.all.tdDate3.style.display="none"

  showAllDates()
}

//==============================================================================
// populate class selection
//==============================================================================
function doClsSelect() {
    var df = document.all;
    var classes = [<%=sCls%>];
    var clsNames = [<%=sClsName%>];
    document.all.DivArg.value = 0;

    //  clear current classes
        for (idx = df.CLASS.length; idx >= 0; idx--)
            df.CLASS.options[idx] = null;
   //  populate the class list
        for (idx = 0; idx < classes.length; idx++)
        {
                df.CLASS.options[idx] = new Option(clsNames[idx], classes[idx]);
        }
}

//==============================================================================
// popilate division selection
//==============================================================================
function doDivSelect(id) {
    var df = document.all;
    var divisions = [<%=sDiv%>];
    var divisionNames = [<%=sDivName%>];
    var depts = [<%=sDpt%>];
    var deptNames = [<%=sDptName%>];
    var dep_div = [<%=sDptGroup%>];
    var chg = id;

    var allowed;

    if (id == null)
    {
        //  populate the division list
        for (idx = 0; idx < divisions.length; idx++)
        {
           df.selDiv.options[idx] = new Option(divisionNames[idx],divisions[idx]);
        }
        id = 0
        if (document.all.DivArg.value.trim() > 0) id = eval(document.all.DivArg.value.trim());
        df.selDiv.selectedIndex = id;
    }

    df.DivName.value = df.selDiv.options[id].text
    df.Div.value = df.selDiv.options[id].value
    df.DivArg.value = id

    allowed = dep_div[id].split(":");

    //  clear current depts
    for (idx = df.selDpt.length; idx >= 0; idx--)
    {
       df.selDpt.options[idx] = null;
    }

    //  if all are to be displayed
    if (allowed[0] == "all")
    {
       for (idx = 0; idx < depts.length; idx++)
            df.selDpt.options[idx] = new Option(deptNames[idx],depts[idx]);
    }
    //  else display the desired depts
    else
    {
       for (idx = 0; idx < allowed.length; idx++)
           df.selDpt.options[idx] = new Option(deptNames[allowed[idx]], depts[allowed[idx]]);
    }

    if(chg!=null)
    {
      showDptSelect(0);
      showClsSelect(0);
    }
}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showDptSelect(id)
{
   document.all.DptName.value = document.all.selDpt.options[id].text
   document.all.Dpt.value = document.all.selDpt.options[id].value

   // clear class
   for(var i = document.all.selCls.length; i >= 0; i--) {document.all.selCls.options[i] = null;}
   document.all.selCls.options[0] = new Option("All Classes", "ALL")
   document.all.selCls.options[0] = new Option("All Classes", "ALL")
   document.all.selCls.selectedIndex=0;
   document.all.selCls.size=1
}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showClsSelect(id)
{
   document.all.ClsName.value = document.all.selCls.options[id].text
   document.all.Cls.value = document.all.selCls.options[id].value
}
//==============================================================================
// retreive classes
//==============================================================================
function rtvClasses()
{
   var div = document.all.Div.value
   var dpt = document.all.Dpt.value

   var url = "RetreiveDivDptCls.jsp?"
           + "Division=" + div
           + "&Department=" + dpt;
   //alert(url);
   //window.location.href = url;
   window.frame1.location = url;
}
//==============================================================================
// show selected classes
//==============================================================================
function showClasses(cls, clsName)
{
   // clear
   for(var i = document.all.selCls.length; i >= 0; i--) {document.all.selCls.options[i] = null;}

   //popilate
   for(var i=0; i < cls.length; i++)
   {
     document.all.selCls.options[i] = new Option(clsName[i], cls[i]);
   }
   document.all.selCls.size=5
}
//==============================================================================
// retreive vendors
//==============================================================================
function rtvVendors()
{
   if (Vendor==null)
   {
      var url = "RetreiveVendorList.jsp"
      //alert(url);
      //window.location.href = url;
      window.frame1.location = url;
   }
   else { document.all.dvVendor.style.visibility = "visible"; }
}
//==============================================================================
// popilate division selection
//==============================================================================
function showVendors(ven, venName)
{
   Vendor = ven;
   VenName = venName;
   var html = "<input name='FndVen' class='Small' size=5 maxlength=5>&nbsp;"
     + "<input name='FndVenName' class='Small1' size=25 maxlength=25>&nbsp;"
     + "<button onclick='findSelVen()' class='Small'>Find</button>&nbsp;"
     + "<button onclick='document.all.dvVendor.style.visibility=&#34;hidden&#34;' class='Small'>Close</button><br>"
   var dummy = "<table>"

   html += "<div id='dvInt' class='dvInternal'>"
         + "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='font-size:10px;'>"
   for(var i=0; i < ven.length; i++)
   {
     html += "<tr id='trVen'><td style='cursor:default;' onclick='javascript: showVenSelect(&#34;" + ven[i] + "&#34;, &#34;" + venName[i] + "&#34;)'>" + venName[i] + "</td></tr>"
   }
   html += "</table></div>"
   var pos = objPosition(document.all.VenName)

   document.all.dvVendor.innerHTML = html;
   document.all.dvVendor.style.pixelLeft= pos[0];
   document.all.dvVendor.style.pixelTop= pos[1] + 70;
   document.all.dvVendor.style.visibility = "visible";
}
//==============================================================================
// find selected vendor
//==============================================================================
function findSelVen()
{
  var ven = document.all.FndVen.value.trim().toUpperCase();
  var vennm = document.all.FndVenName.value.trim().toUpperCase();
  var dvVen = document.all.dvVendor
  var fnd = false;

  // zeroed last search
  if(ven != "" && ven != " " || LastVen != vennm) LastTr=-1;
  LastVen = vennm;

  for(var i=LastTr+1; i < Vendor.length; i++)
  {
     if(ven != "" && ven != " " && ven == Vendor[i]) {  fnd = true; LastTr=i; break}
     else if(vennm != "" && vennm != " " && VenName[i].indexOf(vennm) >= 0) { fnd = true; LastTr=i; break}
     document.all.trVen[i].style.color="black";
  }

  // if found set value and scroll div to the found record
  if(fnd)
  {
     var pos = document.all.trVen[LastTr].offsetTop;
     document.all.trVen[LastTr].style.color="red";
     dvInt.scrollTop=pos;
  }
  else { LastTr=-1; }
}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showVenSelect(ven, vennm)
{
   var venall = false;
   var error = false;
   var msg = "";
   for(var i=0; i < MaxVenSel; i++)
   {
      if(document.all.VenName.options[i].value.trim() == "ALL"){ venall = true; }
   }
   if (venall && MaxVenSel > 0) { error = true; msg = "You already select 'All Vendors'.\nSelection is incorrect." }
   else if(ven == "ALL" && MaxVenSel > 0)
   {
      error = true; msg = "Your selection - 'All Vendors' cannot be added to current selection."
   }

   if (error) { alert(msg); }
   else
   {
      if(MaxVenSel < 5)
      {
         document.all.VenName.options[MaxVenSel] = new Option(vennm, ven);
         MaxVenSel++;
      }
   }
}
//==============================================================================
// clear vendor select field
//==============================================================================
function clrVendors()
{
  for(var i=MaxVenSel-1; i >= 0; i--)
  {
     document.all.VenName.options[i] = null;
  }
  MaxVenSel = 0;
}
//==============================================================================
// find object postition
//==============================================================================
function objPosition(obj)
{
   var pos = new Array(2);
   pos[0] = 0;
   pos[1] = 0;
   // position menu on the screen
   if (obj.offsetParent)
   {
     while (obj.offsetParent)
     {
       pos[0] += obj.offsetLeft
       pos[1] += obj.offsetTop
       obj = obj.offsetParent;
     }
   }
   else if (obj.x)
   {
     pos[0] += obj.x;
     pos[1] += obj.y;
   }
   return pos;
}
//==============================================================================
// show date selection
//==============================================================================
function showDates(type)
{
   if(type==1)
   {
     document.all.tdDate1.style.display="none"
     document.all.tdDate2.style.display="block"
     document.all.tdDate3.style.display="block"
   }
   else
   {
     document.all.tdDate1.style.display="none"
     document.all.tdDate2.style.display="block"
     document.all.tdDate3.style.display="block"
   }
}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates()
{
      document.all.tdDate1.style.display="block"
      document.all.tdDate2.style.display="none"
      document.all.tdDate3.style.display="none"
      var date = new Date(new Date() - 86400000);

      // to sales date
      document.all.SlsToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

      // from sales date
      var day = 0;
      for(var i=0; i < 7; i++)
      {
         day = date.getDay();
         if (date.getDay()==1){ break; }
         date = new Date(date.getTime() - 86400000);
      }
      document.all.SlsFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
      document.all.DatLvl[0].checked = false;
      document.all.DatLvl[1].checked = false;
      document.all.DatLvl[2].checked = false;
      document.all.DatLvl[3].checked = true;

}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(type)
{
  var df = document.all;
  var date = new Date(new Date() - 86400000);
  df.SlsFrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  df.SlsToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id, ymd)
{
  var button = document.all[id];
  var date = new Date(button.value);

  if(direction == "DOWN" && ymd=="DAY") { date = new Date(new Date(date) - 86400000); }
  else if(direction == "UP" && ymd=="DAY") { date = new Date(new Date(date) - -86400000); }

  if(direction == "DOWN" && ymd=="MON") { date.setMonth(date.getMonth()-1); }
  else if(direction == "UP" && ymd=="MON") { date.setMonth(date.getMonth()+1); }

  if(direction == "DOWN" && ymd=="YEAR") { date.setYear(date.getFullYear()-1); }
  else if(direction == "UP" && ymd=="YEAR") { date.setYear(date.getFullYear()+1); }

  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

//==============================================================================
// change Summary option depend on selection
//==============================================================================
function chgSumOpt(clear)
{
  var sumopt = document.all.SumOpt;
  var max = sumopt.length;

  // clear all option when NONE selected
  if(clear)
  {
     for(var i=0; i < max; i++ )
     {
        if(i < max-1) { sumopt[i].checked = false; }
     }
  }
  else
  {
     sumopt[sumopt.length - 1].checked = false;
  }
}

//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = " ";

  var div = document.all.Div.value.trim();
  var divnm = document.all.DivName.value.trim();
  var dpt = document.all.Dpt.value.trim();
  var dptnm = document.all.DptName.value.trim();
  var cls = document.all.Cls.value.trim();
  var clsnm = document.all.ClsName.value.trim();

  // retreive selected vendor
  var ven = new Array();
  var vennm = new Array();
  var venall = false;
  for(var i=0; i < MaxVenSel; i++)
  {
     ven[i] = document.all.VenName[i].value.trim();
     vennm[i] = document.all.VenName[i].text.trim();
     if (ven[i] == "ALL"){ venall = true;}
  }
  if(MaxVenSel==0){msg += "\n Please, select at least 1 vendor"; error = true;}
  else if(MaxVenSel > 1 && venall){msg += "\nYou already select 'All Vendors'. Selection is incorrect."; error = true;}

  // get item summary option
  var sumoptfld = document.all.SumOpt;
  var sumopt = new Array();
  // at least 1 store must be selected
  var sumoptsel = false;
  for(var i=0, j=0; i < sumoptfld.length; i++ )
  {
     if(sumoptfld[i].checked)
     {
        sumoptsel=true;
        sumopt[j] = sumoptfld[i].value;
        j++;
     }
  }

  if(!sumoptsel)
  {
    msg += "\n Please, check at least 1 Detail/Summary option";
    error = true;
  }

  // get date summary option
  var datoptfld = document.all.DatLvl;
  var datopt = null;
  for(var i=0; i < datoptfld.length; i++ )
  {
     if(datoptfld[i].checked) { datopt = datoptfld[i].value; break;}
  }

  // sales date
  var slsfrdate = document.all.SlsFrDate.value;
  var dayofweek = chkDate(slsfrdate, 1);
  if(dayofweek != 1 && datopt != "NONE"){ msg += "\n From Date is not Monday. Selected date is " + WeekDays[dayofweek];   error = true;}

  var slstodate = document.all.SlsToDate.value;
  var dayofweek = chkDate(slstodate, 2);
  if(dayofweek != 0 && datopt != "NONE"){ msg += "\n To Date is not Sunday. Selected date is " + WeekDays[dayofweek];   error = true;}

  var comment = document.all.Comment.value.trim();

  if (error) alert(msg);
  else{ sbmSlsRep(div, divnm, dpt, dptnm, cls, clsnm, ven, vennm, slsfrdate,
                  slstodate, sumopt, comment, datopt) }
  return error == false;
}

//==============================================================================
// check if date beginning or ending date of week
//==============================================================================
function chkDate(chkdate, type)
{
   var dayofweek = null;
   if (type == 1)
   {
      cvtdate = new Date(chkdate);
      cvtdate.setHours(18);
   }
   else if (type == 2)
   {
      cvtdate = new Date(chkdate);
      cvtdate.setHours(18);
   }
   dayofweek =  cvtdate.getDay();

   return dayofweek;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmSlsRep(div, divnm, dpt, dptnm, cls, clsnm, ven, vennm, slsfrdate,
                   slstodate, sumopt, comment, datopt)
{
  var url = null;
  url = "SlsRep03.jsp?"

  url += "Div=" + div
      + "&DivName=" + divnm
      + "&Dpt=" + dpt
      + "&DptName=" + dptnm
      + "&Cls=" + cls
      + "&ClsName=" + clsnm

  // populate selected vendor
  for(var i=0; i < ven.length; i++)
  {
     url += "&Ven=" + ven[i] + "&VenName=" + vennm[i]
  }

  url += "&SlsFr=" + slsfrdate
        + "&SlsTo=" + slstodate

  // selected item summary options
  for(var i=0; i < sumopt.length; i++)
  {
     url += "&SO=" + sumopt[i]
  }

  url += "&Comment=" + comment;

  // selected date summary options
  url += "&DatLvl=" + datopt

  //alert(url)
  //window.location.href=url;
  window.frame1.location.href=url;
}
//==============================================================================
// close Submitting frame
//==============================================================================
function closeFrame()
{
   window.frame1.close();
   alert("Report has been submitted")
}

</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<HTML><HEAD><meta http-equiv="refresh">

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <!--TR><TD height="20%"><IMG src="Sun_ski_logo4.png"></TD></TR -->

  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Vendor Sales Summary - Selection</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>&nbsp; &nbsp; &nbsp; &nbsp;
            <a href="SlsRepJobMon.jsp" target="_blank"><font color="blue" size="-1">Report Monitor</font></a>

      <TABLE>
        <TBODY>
        <!-- ------------- Division  --------------------------------- -->
        <TR>
          <TD class="Cell" >Division:</TD>
          <TD class="Cell1" >
             <input class="Small" name="DivName" size=50 readonly>
             <input class="Small" name="Div" type="hidden">
             <input class="Small" name="DivArg" type="hidden" value=0><br>
             <SELECT name="selDiv" class="Small" onchange="doDivSelect(this.selectedIndex);" size=5>
                <OPTION value="ALL">All Divisions</OPTION>
             </SELECT>
          </TD>
        <!-- ======================= Department ============================ -->
          <TD class="Cell">Department:</TD>
          <TD class="Cell1">
             <input class="Small" name="DptName" size=50 value="All Departments" readonly>
             <input class="Small" name="Dpt" type="hidden" value="ALL"><br>
             <SELECT class="Small" name=selDpt onchange="showDptSelect(this.selectedIndex);"  size=5>
                <OPTION value="ALL">All Departments</OPTION>
             </SELECT>
          </TD>
        </TR>
        <TR>
            <TD class="Cell" >&nbsp;</TD>
         </TR>
        <!-- ========================== Class ============================== -->
        <TR>
            <TD class="Cell" >Class:</TD>
            <TD class="Cell1">
              <input class="Small" name="ClsName" size=50 value="All Classes" readonly>
              <input class="Small" name="Cls" type="hidden" value="ALL">
              <button class="Small" value="Select Class" name=SUBMIT onClick="rtvClasses()">Select Class</button><br>
              <SELECT name="selCls" class="Small" onchange="showClsSelect(this.selectedIndex);">
                 <OPTION value="ALL">All Classes</OPTION>
              </SELECT>
            </TD>
        <!-- ========================== Vendor ============================== -->
            <TD class="Cell" >Vendor:</TD>
            <TD class="Cell1" nowrap>
              <select class="Small" name="VenName" multiple size=5 readonly></select> &nbsp; &nbsp; &nbsp;
              <button class="Small" name=GetVen onClick="rtvVendors()">Select Vendors</button>
              <button class="Small" name=ClrVen onClick="clrVendors()">Clear Vendors</button>
              <br>
            </TD>
        </TR>

        </TR>
        <!-- =============================================================== -->
        <!-- ============== select Shipping changes ========================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=4><b><u>Select Sales Dates</b></u> <br>If no date selected, defaulted dates are week-to-date</TD></tr>

        <TR>
          <TD id="tdDate1" colspan=4 align=center style="padding-top: 10px;" >
             <button id="btnSelDates" onclick="showDates(2)">Optional Date Selection</button>
          </td>
          <TD id="tdDate2" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date: </b>
             <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsFrDate', 'YEAR')">y-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsFrDate', 'MON')">m-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsFrDate', 'DAY')">d-</button>
              <input class="Small" name="SlsFrDate" type="text"  size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsFrDate', 'DAY')">d+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsFrDate', 'MON')">m+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsFrDate', 'YEAR')">y+</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.SlsFrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date: </b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsToDate', 'YEAR')">y-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsToDate', 'MON')">m-</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SlsToDate', 'DAY')">d-</button>
              <input class="Small" name="SlsToDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsToDate', 'DAY')">d+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsToDate', 'MON')">m+</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'SlsToDate', 'YEAR')">y+</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.SlsToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </td>
        </tr>
        <TR><TD class="Cell2" id="tdDate3" colspan=4>
              <p><u>Date Level Break</u></b><br>
              <input class="Small" name="DatLvl" type="radio" value='WEEK' > Week &nbsp;&nbsp;
              <input class="Small" name="DatLvl" type="radio" value='MONTH' > Month &nbsp;&nbsp;
              <input class="Small" name="DatLvl" type="radio" value='YEAR' > Year &nbsp;&nbsp;
              <input class="Small" name="DatLvl" type="radio" value='NONE' checked> None &nbsp;&nbsp;

              <p><button id="btnSelDates" onclick="showAllDates()">No Date Selection</button>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=4><b><u>Item Detail/Summary Options</b></u></TD></tr>

        <TR>
          <TD class="Cell2" colspan=4>
             <input name="SumOpt" type="checkbox" onClick="chgSumOpt(false)" value="DIV" checked>Divison &nbsp; &nbsp;
             <input name="SumOpt" type="checkbox" onClick="chgSumOpt(false)" value="DPT" checked>Department &nbsp; &nbsp;
             <input name="SumOpt" type="checkbox" onClick="chgSumOpt(false)" value="CLS" checked>Class &nbsp; &nbsp;
             <input name="SumOpt" type="checkbox" onClick="chgSumOpt(true)" value="NONE">None &nbsp; &nbsp;
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD></TD>
            <TD class="Cell2" colSpan=4>
               Comment: <input  name="Comment" size=100 maxlength=100><br>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate()">  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
           </TD>
          </TR>
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>