<%@ page import="rciutility.ClassSelect, rciutility.StoreSelect"%>
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
      StoreSelect strsel = null;

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

      strsel = new StoreSelect(4);
      int iNumOfStr = strsel.getNumOfStr();
      String [] sStr = strsel.getStrLst();
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
   document.all.VenName.value = vennm
   document.all.Ven.value = ven
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
// change Store selection
//==============================================================================
function chgStrSel(str)
{
  var stores =  document.all.STORE;
  var selstr = str.value;

  // unselect other store if ALL selected
  if (str.value=="ALL" && str.checked || str.value=="SAS" && str.checked
   || str.value=="SCH" && str.checked || str.value=="SAS70" && str.checked
   || str.value=="REG01" && str.checked || str.value=="REG02" && str.checked
   || str.value=="REG03" && str.checked
   )
  {
     for(var i=0; i < stores.length; i++ )
     {
        if(selstr != stores[i].value) stores[i].checked=false;
     }
  }
  else if (str.value!="ALL" && str.value!="SAS" && str.value!="SCH" && str.value!="SAS70"
        && str.value!="REG01" && str.value!="REG02" && str.value!="REG03")  {
     stores[0].checked=false;
     stores[1].checked=false;
     stores[2].checked=false;
     stores[3].checked=false;
  }
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
         if (date.getDay()==0){ break; }
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
  var ven = document.all.Ven.value.trim();
  var vennm = document.all.VenName.value.trim();
  var itemgrp = document.all.ItemGrp.value.trim();

  var stores = document.all.STORE;
  var str = new Array();
  // at least 1 store must be selected
  var strsel = false;
  for(var i=0, j=0; i < stores.length; i++ )
  {
     if(stores[i].checked)
     {
        strsel=true;
        str[j] = stores[i].value;
        j++;
     }
  }

  if(!strsel)
  {
    msg += "\n Please, check at least 1 store";
    error = true;
  }

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

  if(document.all.Age.checked) { sumopt[sumopt.length] = document.all.Age.value; }

  // get store summary option
  var stroptfld = document.all.StrOpt;
  var stropt = null;
  for(var i=0; i < stroptfld.length; i++ )
  {
     if(stroptfld[i].checked) { stropt = stroptfld[i].value; break;}
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
  var slstodate = document.all.SlsToDate.value;

  var comment = document.all.Comment.value.trim();

  if (error) alert(msg);
  else{ sbmSlsRep(div, divnm, dpt, dptnm, cls, clsnm, ven, vennm, str, slsfrdate,
                  slstodate, sumopt, stropt, comment, datopt, itemgrp) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmSlsRep(div, divnm, dpt, dptnm, cls, clsnm, ven, vennm, str, slsfrdate,
             slstodate, sumopt, stropt, comment, datopt, itemgrp)
{
  var url = null;
  url = "SlsRep01.jsp?"

  url += "Div=" + div
      + "&DivName=" + divnm
      + "&Dpt=" + dpt
      + "&DptName=" + dptnm
      + "&Cls=" + cls
      + "&ClsName=" + clsnm
      + "&Ven=" + ven
      + "&VenName=" + vennm

  // selected store
  for(var i=0; i < str.length; i++)
  {
     url += "&Str=" + str[i]
  }

  url += "&SlsFr=" + slsfrdate
        + "&SlsTo=" + slstodate

  // selected item summary options
  for(var i=0; i < sumopt.length; i++)
  {
     url += "&SO=" + sumopt[i]
  }

  // selected store summary options
  url += "&StrLvl=" + stropt

  url += "&Comment=" + comment;

  // selected date summary options
  url += "&DatLvl=" + datopt
  // seleted item group
  url += "&ItemGrp=" + itemgrp

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
//==============================================================================
// disable enter key
//==============================================================================
function disableEnterKey(e)
{
     var key;
     if(window.event)
     {
          key = window.event.keyCode; //IE
     }
     return (key != 13);
}
document.onkeypress = disableEnterKey;
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
        <BR>Sales Summary - Selection</B>
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
              <input class="Small" name="VenName" size=50 value="All Vendors" readonly>
              <input class="Small" name="Ven" type="hidden" value="ALL">
              <button class="Small" name=GetVen onClick="rtvVendors()">Select Vendors</button><br>
            </TD>
        </TR>

        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-top:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell">Store:</TD>
          <TD class="Cell1" colspan=3>
             <input name="STORE" type="checkbox" value="ALL" onclick="chgStrSel(this)" checked>Total Stores&nbsp;&nbsp;
             <input name="STORE" type="checkbox" value="SAS" onclick="chgStrSel(this)" >Sun & Ski&nbsp;&nbsp;
             <input name="STORE" type="checkbox" value="SCH" onclick="chgStrSel(this)" >Ski Chalet&nbsp;&nbsp;
             <input name="STORE" type="checkbox" value="SAS70" onclick="chgStrSel(this)" >Sun & Ski + 70&nbsp;&nbsp;
             <input name="STORE" type="checkbox" value="REG01" onclick="chgStrSel(this)" >Region 1&nbsp;&nbsp;
             <input name="STORE" type="checkbox" value="REG02" onclick="chgStrSel(this)" >Region 2&nbsp;&nbsp;
             <input name="STORE" type="checkbox" value="REG03" onclick="chgStrSel(this)" >Region 3&nbsp;&nbsp;
             <br>


             <%for(int i=0; i<iNumOfStr; i++) {%>
               <input name="STORE" type="checkbox" onclick="chgStrSel(this)" value="<%=sStr[i]%>"><%=sStr[i]%>&nbsp;&nbsp;
               <%if(i == 15 || i == 30) {%><br><%}%>
             <%}%>
          </TD>
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

              <p><button id="btnSelDates" onclick="showAllDates()">Week-To-Date</button>
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
             <input name="SumOpt" type="checkbox" onClick="chgSumOpt(false)" value="VEN">Vendor &nbsp; &nbsp;
             <input name="SumOpt" type="checkbox" onClick="chgSumOpt(false)" value="STY">Style &nbsp; &nbsp;
             <input name="SumOpt" type="checkbox" onClick="chgSumOpt(false)" value="SKU">SKU &nbsp; &nbsp;
             <input name="SumOpt" type="checkbox" onClick="chgSumOpt(false)" value="DTL" >Item Transaction Details &nbsp; &nbsp;
             <input name="SumOpt" type="checkbox" onClick="chgSumOpt(true)" value="NONE" >None &nbsp; &nbsp;<br>

             Show Only Aged Items<input name="Age" type="checkbox" value="AGE" >  &nbsp; &nbsp;
          </TD>
        </TR>

        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=4><b><u>Store Level Break Options</b></u></TD></tr>

        <TR>
          <TD class="Cell2" colspan=4>
             <input name="StrOpt" type="radio" value="STR" checked>Store &nbsp; &nbsp;
             <input name="StrOpt" type="radio" value="REG" >Region &nbsp; &nbsp;
             <input name="StrOpt" type="radio" value="NONE">None &nbsp; &nbsp;
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR><TD class="Cell2" colspan=4><b><u>Item Group Optional Selection</b></u></TD></tr>

        <TR>
          <TD class="Cell2" colspan=4>
             <input name="ItemGrp" maxlength=10 size=10> &nbsp; &nbsp;
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