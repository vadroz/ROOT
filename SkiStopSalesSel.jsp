<%@ page import=" rciutility.ClassSelect"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=SkiStopSalesSel.jsp&APPL=ALL");
   }
   else
   {
      ClassSelect divsel = new ClassSelect();
      String sDiv = divsel.getDivNum();
      String sDivName = divsel.getDivName();
      String sDpt = divsel.getDptNum();
      String sDptName = divsel.getDptName();
      String sDptGroup = divsel.getDptGroup();
%>

<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}

  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}
  </style>

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  doDivSelect(null);
  doSelDate();
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate()
{
  var df = document.all;
  var date = new Date(new Date() - 86400000);

  // last ran
  var from = document.all.FrDateSv.value;
  var to = document.all.ToDateSv.value;
  if (from != null && from.trim() != ''){ df.FrDate.value = from }
  else { df.FrDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear() }

  if (from != null && from.trim() != ''){ df.ToDate.value = to }
  else { df.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear() }
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

    if (id == null || id == 0)
    {
        //  populate the division list
        var start = 0
        for (var i = start, j=0; i < divisions.length; i++, j++)
        {
           df.selDiv.options[j] = new Option(divisionNames[i],divisions[i]);
        }
        if (id == null && document.all.DivArg.value.trim() > 0) id = eval(document.all.DivArg.value.trim());
        if (id == null) id = 0;
        df.selDiv.selectedIndex = id;
    }

    df.DivName.value = df.selDiv.options[id].text
    df.Div.value = df.selDiv.options[id].value
    df.DivArg.value = id

    allowed = dep_div[id].split(":");

    //  clear current depts
    for (var i = df.selDpt.length; i >= 0; i--)
    {
       df.selDpt.options[i] = null;
    }

    //  if all are to be displayed
    if (allowed[0] == "all")
    {
       for (var i = 0; i < depts.length; i++)
            df.selDpt.options[i] = new Option(deptNames[i],depts[i]);
    }
    //  else display the desired depts
    else
    {
       for (var i = 0; i < allowed.length; i++)
           df.selDpt.options[i] = new Option(deptNames[allowed[i]], depts[allowed[i]]);
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
   var df = document.all;
   document.all.DptName.value = document.all.selDpt.options[id].text
   document.all.Dpt.value = document.all.selDpt.options[id].value

   // clear class
   for(var i = document.all.selCls.length; i >= 0; i--) {document.all.selCls.options[i] = null;}
   document.all.selCls.options[0] = new Option("All Classes", "ALL")
   document.all.selCls.options[0] = new Option("All Classes", "ALL")
   document.all.selCls.selectedIndex=0;
   document.all.selCls.size=1;
}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showClsSelect(id)
{
   var df = document.all;
   document.all.ClsName.value = document.all.selCls.options[id].text
   document.all.Cls.value = document.all.selCls.options[id].value
}
//==============================================================================
// show selected Department Selected
//==============================================================================
function showVenSelect(ven, vennm)
{
   document.all.VenName.value = vennm
   document.all.Ven.value = ven
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
// popilate division selection
//==============================================================================
function showVendors(ven, venName)
{
   Vendor = ven;
   VenName = venName;
   var html = "<input name='FndVen' class='Small' size=4 maxlength=4>&nbsp;"
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
   document.all.dvVendor.style.pixelTop= pos[1] + 25;
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
     if(ven != "" && ven != " " && ven == Vendor[i]) { fnd = true; LastTr=i; break}
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
// Validate form
//==============================================================================
function Validate(excel)
{
  var error = false;
  var msg = "";

  var div = document.all.Div.value.trim();
  var dpt = document.all.Dpt.value.trim();
  var cls = document.all.Cls.value.trim();
  var ven = document.all.Ven.value.trim();
  var from = document.all.FrDate.value.trim();
  var to = document.all.ToDate.value.trim();
  var itmlevel = null;
  var datlevel = null;


  for(var i=0; i < document.all.ItmLevel.length; i++)
  {
     if(document.all.ItmLevel[i].checked) { itmlevel = document.all.ItmLevel[i].value }
  }
  for(var i=0; i < document.all.DatLevel.length; i++)
  {
     if(document.all.DatLevel[i].checked) { datlevel = document.all.DatLevel[i].value }
  }

  if (error) alert(msg);
  else{ sbmPlan(div, dpt, cls, ven, from, to, itmlevel, datlevel, excel) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(div, dpt, cls, ven, from, to, itmlevel, datlevel, excel)
{
  // save date for next run
  document.all.FrDateSv.value = from;
  document.all.ToDateSv.value = to;

  var url = null;

  if (excel) { url = "SkiStopSlsExl.jsp?" }
  else { url = "SkiStopSales.jsp?" }

  url += "Div=" + div
      + "&Dpt=" + dpt
      + "&Cls=" + cls
      + "&Ven=" + ven
      + "&From=" + from
      + "&To=" + to
      + "&ItmLevel=" + itmlevel
      + "&DatLevel=" + datlevel
  //alert(url)
  window.location.href=url;
}
//==============================================================================
// reset sselection if season has been selected
//==============================================================================
function resetSeason()
{
   document.all.DivName.value = document.all.selDiv.options[0].text
   document.all.Div.value = document.all.selDiv.options[0].value
   document.all.DivArg.value = 0
   showDptSelect(0);
   showClsSelect(0);
}
</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD colSpan=2 height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top width="15%" bgColor=#a7b5e8><FONT face=Arial color=#445193
      size=2>&nbsp;&nbsp;<A class=blue
      href="/">Home</A></FONT><FONT
      face=Arial color=#445193 size=1>
      <H5>&nbsp;&nbsp;Miscellaneous</H5>&nbsp;&nbsp;<A class=blue
      href="mailto:">Send e-mail</A> <BR>&nbsp;&nbsp;<A
      class=blue href="http://sunandski.com/">Our Internet</A> <BR></FONT></TD>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Ski Stop Sales History - Selection</B>

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
             </SELECT><br>
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
            <TD class="Cell1" nowrap>
              <input class="Small" name="ClsName" size=50 value="All Classes" readonly>
              <input class="Small" name="Cls" type="hidden" value="ALL">
              <button class="Small" name=GetCls onClick="rtvClasses()">Select Class</button><br>
              <SELECT name="selCls" class="Small" onchange="showClsSelect(this.selectedIndex);" size=1>
                  <OPTION value="ALL">All Classes</OPTION>
              </SELECT>
            </TD>
        <!-- ========================== Vendor ============================== -->
            <TD class="Cell" >Vendor:</TD>
            <TD class="Cell1" nowrap>
              <input class="Small" name="VenName" size=50 value="All Vendors" readonly>
              <input class="Small" name="Ven" type="hidden" value="ALL">
              <button class="Small" name=GetVen onClick="rtvVendors()">Select Vendors</button><br>
            </TD>
        </TR>

        <!-- ========================Sales Date ============================= -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell" >From Date:</TD>
            <TD class="Cell1" nowrap>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FrDate')">&#60;</button>
              <input class="Small" name="FrDate" type="text" size=10 maxlength=10 readOnly>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FrDate')">&#62;</button>&nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 250, 420, document.all.FrDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              <input type="hidden" name="FrDateSv">&nbsp;
            </TD>
            <TD class="Cell" >To Date:</TD>
            <TD class="Cell1" nowrap>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate')">&#60;</button>
              <input class="Small" name="ToDate" type="text" size=10 maxlength=10 readOnly>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate')">&#62;</button>&nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 250, 420, document.all.ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              <input type="hidden" name="ToDateSv">&nbsp;
            </TD>
          </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
           <TD class="Cell1"  colSpan=5>
              <input class="Small" name="ItmLevel" type="radio" value="DIV" checked>By Division &nbsp;&nbsp;
              <input class="Small" name="ItmLevel" type="radio" value="ITEM">By Item &nbsp;&nbsp;
              <input class="Small" name="ItmLevel" type="radio" value="SUBCAT">By Sub-Category &nbsp;&nbsp;
              <input class="Small" name="ItmLevel" type="radio" value="NONE">None &nbsp;&nbsp;
           </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
           <TD class="Cell1"  colSpan=5>
              <input class="Small" name="DatLevel" type="radio" value="MONTH" checked>By Month &nbsp;&nbsp;
              <input class="Small" name="DatLevel" type="radio" value="WEEK">By Week &nbsp;&nbsp;
              <input class="Small" name="DatLevel" type="radio" value="DATE">By Date &nbsp;&nbsp;
              <input class="Small" name="DatLevel" type="radio" value="NONE">None &nbsp;&nbsp;
           </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate(false)">
               <INPUT type=submit value='Download to Excel' name=SUBMIT onClick="Validate(true)">
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