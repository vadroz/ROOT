<%@ page import=" rciutility.ClassSelect"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null )
   {
     response.sendRedirect("SignOn1.jsp?TARGET=ItemPriceAnalysisSel.jsp&APPL=ALL");
   }
   else
   {
      boolean bDwnLoad = session.getAttribute("ECOMDWNL") != null;
      ClassSelect divsel = null;
      divsel = new ClassSelect();
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
  td.Cell3 {font-size:12px; text-align:center; vertical-align:top}

  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}


  div.dvInternal{ clear: both; overflow: AUTO; width: 300px; height: 220px; POSITION: relative; text-align:left;}
  div.dvInternal thead td, tfoot td { background-color: #1B82E6; Z-INDEX: 60; position:relative; }
  div.dvInternal table{ border:0px; cellspacing:1px; cellpading:1px; TEXT-ALIGN: left; }

  tr.TblHdr { background:#FFCC99; padding-left:3px; padding-right:3px;
              text-align:center; vertical-align:middle; font-size:11px;
              position: relative; top: expression(this.offsetParent.scrollTop-3);}
  tr.TblRow { background:wite; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:middle; font-size:11px }


  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#0000CD, endColorStr=#4169E1);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#0000CD, endColorStr=#4169E1);
              color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
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
  setBoxclasses(["BoxName",  "BoxClose"], ["dvPoNum"]);

  doDivSelect(null);
  doSelDate()
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
        var start = <%if(bDwnLoad) {%>0<%} else {%>1<%}%>
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

    allowed = dep_div[id + <%if(bDwnLoad) {%>0<%} else {%>1<%}%>].split(":");

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
// retreive POs
//==============================================================================
function rtvPoNum()
{
    var ven = document.all.Ven.value
    var div = document.all.Div.value.trim();

    var url = "RtvPoList.jsp"
    var sep = "?";
    if(ven.trim() != "" && ven.trim() != "ALL")
    {
       url += sep + "Ven=" + ven;
       sep = "&";
    }

    if(div.trim() != "" && div.trim() != "ALL")
    {
       url += sep + "Div=" + div;
       sep = "&";
    }

    //window.location.href = url;
    window.frame1.location = url;
}
//==============================================================================
// popilate division selection
//==============================================================================
function showPoNum(PoNum, AntDlvDt, Ven, VenName, Div, Bsr70, InStock, TotRet)
{
   var hdr = "Select P.O. Number";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePoNumPanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popSelPoNum(PoNum, AntDlvDt, Ven, VenName, Div, Bsr70, InStock, TotRet)

   html += "</td></tr></table>"


   document.all.dvPoNum.innerHTML = html;
   var dvWidth = document.all.thHdr1.offsetWidth + document.all.thHdr2.offsetWidth
               + document.all.thHdr3.offsetWidth + document.all.thHdr4.offsetWidth
               + document.all.thHdr1.offsetWidth
   document.all.dvInt1.style.width=550;
   document.all.dvPoNum.style.pixelLeft= document.documentElement.scrollLeft + 100;
   document.all.dvPoNum.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvPoNum.style.visibility = "visible";
}

//==============================================================================
// populate Seletion of P.O. Number
//==============================================================================
function popSelPoNum(PoNum, AntDlvDt, Ven, VenName, Div, Bsr70, InStock, TotRet)
{
   // filter input
   var panel = "<table cellPadding=0 cellSpacing=0 style='background:#e9e9e9; border:2px outset; width=100%; font-size:10px;'>"
       + "<tr>"
       + "<td>P.O.&nbsp;<td><input name='spoPoNum' class='Small' size=10 maxlength=10> &nbsp; "
       + "<td><button class='Small' onClick='searchPoNum()'>Find</button>"

       + "<tr><td colspan=3 style='border-bottom:#e9e9e9 ridge 2px;font-size:3px;'>&nbsp;</td>"
       + "<tr><td colspan=3 style='font-size:3px;'>&nbsp;</td>"

       + "<tr><td>Vendor&nbsp;<td><input name='spoVen' class='Small' size=5 maxlength=5>"
       + "<td rowspan=2><button class='Small' onClick='rtvPoNumWithFilter()'>Filter</button>"
       + "<tr><td>Div&nbsp;<td><input name='spoDiv' class='Small' size=5 maxlength=5>"
       + "</table>"

   panel += "<br><div id='dvInt1' class='dvInternal'>"
         + "<table border=1 cellPadding=0 cellSpacing=0 style='font-size:10px;'>"

   panel += "<thead><tr class='TblHdr' >"
         + "<th id='thHdr1'>P.O.<br>Num</th>"
         + "<th id='thHdr2'>Anticip<br>Delivery<br>Date</th>"
         + "<th id='thHdr3'>Vendor</th>"
         + "<th id='thHdr4'>Vendor Name</th>"
         + "<th id='thHdr5'>Div</th>"
         + "<th id='thHdr6'>BSR<br>70</th>"
         + "<th id='thHdr7'>In<br>Stock</th>"
         + "<th id='thHdr8'>Total<br>Retail</th>"
   panel += "</thead>"

   panel += "<tbody>"

   for(var i=0; i < PoNum.length; i++)
   {
     panel += "<tr class='TblRow' id='trPon'><td id='tdCol1' style='cursor:hand;' onclick='javascript: showPonSelect(&#34;" + PoNum[i] + "&#34;)'>" + PoNum[i] + "</td>"
        + "<td id='tdCol2'>&nbsp;&nbsp;" + AntDlvDt[i] + "&nbsp;&nbsp;</td>"
        + "<td id='tdCol3'>" + Ven[i] + "</td>"
        + "<td id='tdCol4' style='text-align:left' nowrap>" + VenName[i] + "</td>"
        + "<td id='tdCol5'>" + Div[i] + "</td>"
        + "<td id='tdCol6' style='text-align:right'>" + Bsr70[i] + "</td>"
        + "<td id='tdCol7' style='text-align:right'>" + InStock[i] + "</td>"
        + "<td id='tdCol8' style='text-align:right'>" + TotRet[i] + "</td>"
        + "</tr>"
   }

   panel += "</tbody></table></div>"
        + "<div align=center><button class='Small' onclick='hidePoNumPanel();'>Close</button></div>"

   return panel;
}
//==============================================================================
// search Po Number in list
//==============================================================================
function searchPoNum()
{
   var pon = document.all.spoPoNum.value.trim();
   var tdpon = document.all.tdCol1;
   var selind = 0;
   var fnd = false;

   for(var i=0; i < tdpon.length; i++)
   {
      if(tdpon[i].innerHTML.indexOf(pon) >= 0)  { selind = i;  tdpon[i].style.color="red"; fnd=true;}
      else { tdpon[i].style.color="black"; }
   }

   if(fnd)
   {
      var pos = document.all.tdCol1[selind].offsetTop;
      dvInt1.scrollTop=pos-70;
   }
}
//==============================================================================
// retreive  PO Number with filter
//==============================================================================
function rtvPoNumWithFilter()
{
    var ven = document.all.spoVen.value.trim()
    var div = document.all.spoDiv.value.trim();

    var url = "RtvPoList.jsp"
    var sep = "?";
    if(ven != "" && ven != "ALL")
    {
       url += sep + "Ven=" + ven;
       sep = "&";
    }

    if(div != "" && div != "ALL")
    {
       url += sep + "Div=" + div;
       sep = "&";
    }

    //alert(url)
    //window.location.href = url;
    window.frame1.location = url;
}
//==============================================================================
// show PO Number selected
//==============================================================================
function showPonSelect(pon)
{
   document.all.PON.value = pon;
}
//==============================================================================
// hide panel
//==============================================================================
function hidePoNumPanel(){document.all.dvPoNum.style.visibility = "hidden";}

//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";

  var div = document.all.Div.value.trim();
  var dpt = document.all.Dpt.value.trim();
  var cls = document.all.Cls.value.trim();
  var ven = document.all.Ven.value.trim();

  var reg = document.all.Reg.checked;
  var clr4 = document.all.Clrx4.checked;
  var clr6 = document.all.Clrx6.checked;
  var clr7 = document.all.Clrx7.checked;
  var sty = "ALL";
  if( !reg && !clr4 && !clr6 && !clr7 ){ msg += "Select at least 1 price type\n"; error=true; }

  var days = document.all.NumOfDays.value.trim();
  if(isNaN(days)){ msg += "Number Of days must be numeric\n"; error=true; }

  var units = document.all.NumOfUnits.value.trim();
  if(isNaN(units)){ msg += "Number Of units must be numeric\n"; error=true; }
  else if(eval(units) <= 0){ msg += "Number Of days must be greater than 0\n"; error=true; }

  var parent = document.all.Parent.value.trim();
  if(isNaN(parent)){ msg += "Cls-Ven-Sty must be numeric\n"; error=true; }
  else if(eval(parent) > 0 && parent.length < 9){ msg +=  "Cls-Ven-Sty must contains at least 9 digits.\n"; error=true; }

  if(parent != "")
  {
     div="ALL";
     dpt="ALL";
     cls = parent.substring(0,4).trim();
     ven = parent.substring(4,9).trim();
     sty = parent.substring(9).trim();
     if(sty == ""){sty = "ALL";}
  }

  var lrdate = document.all.LstRctDt.value;


  if (error) alert(msg);
  else{ sbmPlan(div, dpt, cls, ven, sty, reg, clr4, clr6, clr7, days, parent, units, lrdate) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(div, dpt, cls, ven, sty, reg, clr4, clr6, clr7, days, parent, units, lrdate)
{
  var url = null;
  url = "ItemPriceAnalysis.jsp?"

  url += "Div=" + div + "&Dpt=" + dpt + "&Cls=" + cls + "&Ven=" + ven + "&Sty=" + sty;

  if(reg){ url += "&Reg=Y"; } else { url += "&Reg=N"; }
  if(clr4){ url += "&Clrx4=Y"; } else { url += "&Clrx4=N"; }
  if(clr6){ url += "&Clrx6=Y"; } else { url += "&Clrx6=N"; }
  if(clr7){ url += "&Clrx7=Y"; } else { url += "&Clrx7=N"; }

  url += "&NumOfDays=" + days
    + "&NumOfUnits=" + units
    + "&LstRctDt=" + lrdate

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id, numdays)
{
  var button = document.all[id];
  var date = new Date(button.value);


  if(direction == "DOWN") date = new Date(new Date(date) - 86400000 * numdays);
  else if(direction == "UP") date = new Date(new Date(date) - -86400000 * numdays);
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate()
{
  var df = document.all;
  var date = new Date(new Date() - 86400000);
  date.setHours(18);

  df.LstRctDt.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>


<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<div id="dvPoNum" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle>
        <B>Retail Concepts Inc.
        <BR>Item Price Analysis - Selection</B>

        <br><A class=blue href="/">Home</A></FONT><FONT face=Arial color=#445193 size=1>

      <TABLE border=0>
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


        <!-- =============================================================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" ></TD></TR>
        <TR><TD class="Cell2" colspan=5><br><u><b>Retail Price Selection</b></u></td></tr>
        <TR>
            <TD class="Cell3"  colspan="5">
               Regular &nbsp; <input name="Reg" type="checkbox" value="Y" checked>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
               Clearance &nbsp;
               <input name="Clrx4" type="checkbox" value="Y" checked> x4 cents &nbsp; &nbsp; &nbsp;
               <input name="Clrx6" type="checkbox" value="Y" checked> x6 cents &nbsp; &nbsp; &nbsp;
               <input name="Clrx7" type="checkbox" value="Y" checked> x7 cents &nbsp; &nbsp; &nbsp;
            </td>
        </tr>

        <!-- =============================================================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" ></TD></TR>
        <TR>
           <TD class="Cell2" colspan=1><br><u><b>Age (in Days)</b></u></td>
           <TD class="Cell2" colspan=1><br><u><b>Last Receipt Date<br>Prior to</b></u></td>
           <TD class="Cell2" colspan=2><br><u><b>Number of Units on Hand</b></u></td>
        </tr>

        <TR>
            <TD class="Cell3"  colspan="1">
               Number Of Days: &nbsp; <input name="NumOfDays" value="90" size=3 maxlength=3>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            </td>
            <TD class="Cell3"  colspan="1">
                Date: &nbsp;
              <button class="Small" name="Down" onClick="setDate('DOWN', 'LstRctDt', 10)">&#60;&#60;</button>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'LstRctDt', 1)">&#60;</button>
              <input class="Small" name="LstRctDt" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'LstRctDt', 1)">&#62;</button>
              <button class="Small" name="Up" onClick="setDate('UP', 'LstRctDt', 10)">&#62;&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 500, 360, document.all.LstRctDt)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
            </td>
            <TD class="Cell3"  colspan="2">
               On Hand Units Greater Than: &nbsp; <input name="NumOfUnits" value="1" size=3 maxlength=3>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            </td>
        </tr>
        <!-- =============================================================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" ></TD></TR>
        <TR>
            <TD class="Cell2" colspan=5><br>Alternative Selection:</TD>
        </tr>
        <tr>
            <TD class="Cell3" colspan=5>Class-Vendor-Style: &nbsp;<input class="Small" name="Parent" size=13 maxlength=13>
              No dashes or spaces
            </TD>
        </tr>
        <!-- =============================================================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" ></TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate()">
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