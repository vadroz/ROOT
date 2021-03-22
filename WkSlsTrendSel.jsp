<%@ page import=" rciutility.ClassSelect, rciutility.StoreSelect"%>
<% ClassSelect select = null;
   String sLevel = request.getParameter("LEVEL");
   if(sLevel==null) sLevel="S";

   String sDiv = null;
   String sDivName = null;
   String sDpt = null;
   String sDptName = null;
   String sDptGroup = null;
   String sCls = null;
   String sClsName = null;
   String sWkDate = null;
   String sWkDateDsc = null;
   String sMnDate = null;
   String sMnDateDsc = null;
   String sYrDate = null;
   String sYrDateDsc = null;


   select = new ClassSelect();
   sDiv = select.getDivNum();
   sDivName = select.getDivName();
   String [] sDivArr = select.getDivArr();

   sDpt = select.getDptNum();
   sDptName = select.getDptName();
   sDptGroup = select.getDptGroup();
   sWkDate = select.getWkDate();
   sWkDateDsc = select.getWkDateDsc();
   sMnDate = select.getMnDate();
   sMnDateDsc = select.getMnDateDsc();
   sYrDate = select.getYrDate();
   sYrDateDsc = select.getYrDateDsc();

   StoreSelect strlst = new StoreSelect(22);
   int iNumOfStr = strlst.getNumOfStr();
   String [] sStr = strlst.getStrLst();
   String [] sStrName = strlst.getStrNameLst();
   
   String [] sStrLst = strlst.getStrLst();
   String sStrJsa = strlst.getStrNum();

   String [] sStrRegLst = strlst.getStrRegLst();
   String sStrRegJsa = strlst.getStrReg();

   String [] sStrDistLst = strlst.getStrDistLst();
   String sStrDistJsa = strlst.getStrDist();
   String [] sStrDistNmLst = strlst.getStrDistNmLst();
   String sStrDistNmJsa = strlst.getStrDistNm();

   String [] sStrMallLst = strlst.getStrMallLst();
   String sStrMallJsa = strlst.getStrMall();

   boolean bKiosk = session.getAttribute("USER") == null;
   String sUser = "KIOSK";
   if(!bKiosk) { sUser = session.getAttribute("USER").toString(); }
%>

<style>
  .Small {font-family:Arial; font-size:10px }

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
var DateRange = true;

var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";

var ArrStr = [<%=sStrJsa%>];
var ArrStrReg = [<%=sStrRegJsa%>];
var ArrStrDist = [<%=sStrDistJsa%>];
var ArrStrDistNm = [<%=sStrDistNmJsa%>];
var ArrStrMall = [<%=sStrMallJsa%>];
var ArrNonStr = ["1", "2", "55", "56", "59", "72", "99", "100", "101", "102", "199"];


var Multiple = false;

//==============================================================================
// on load
//==============================================================================
function bodyLoad(){
  var df = document.forms[0];
  var sel_Str= "<%=request.getParameter("STORE")%>";
  var str_opt;

  // populate date with yesterdate
  doSelDate();

  // populate hierarchy
  doDivSelect(null);

  setMultiple(false);
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  doSelDate(){
  var date = new Date(new Date() - 86400000);
  var dofw = date.getDay();
  date = new Date(date - 86400000 * dofw);

  document.all.FromDt.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  document.all.ToDt.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
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
        var start = 0;
        for (var i = start, j=0; i < divisions.length; i++, j++)
        {
           df.selDiv.options[j] = new Option(divisionNames[i],divisions[i]);
        }
        if (id == null && document.all.DivArg.value.trim() > 0)
        {
          id = eval(document.all.DivArg.value.trim());
        }
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
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";

  // select division
  var dpt = document.all.Dpt.value.trim();
  var cls = document.all.Cls.value.trim();
  var ven = document.all.Ven.value.trim();
  var vennm = document.all.VenName.value.trim();

  var div = new Array();
  if(!Multiple)
  {
    div[0] = document.all.Div.value.trim();
  }
  else
  {
      var mdiv = document.all.mDiv;
      for(var i=0, j=0; i < mdiv.length; i++)
      {
         if(mdiv[i].checked){ div[j++] = mdiv[i].value; }
      }
      if(div.length == 0){msg +="\nCheck at least 1 division."; error = true;}
      dpt = "ALL";
      cls = "ALL";
      ven = "ALL";
      vennm = "All Vendors";
  }

  var frdate =  document.all.FromDt.value;
  var todate =  document.all.ToDt.value;

  var strbox = document.all.Str
  var str = new Array();
  var chkstr = false;
  for(var i=0, j=0; i < strbox.length; i++)
  {
     if(strbox[i].checked){ str[j] = strbox[i].value; chkstr = true; j++}
  }
  
  if(!chkstr){ msg +="\nCheck at least 1 store."; error = true; }

  // validate date range
  if(DateRange)
  {
      var from = new Date(frdate)
      var to = new Date(todate)
      if(from > to){ error = true; msg += "\nFrom date greater than to date."}
  }
  else
  {
    frdate = "NONE";
  }
  var type = document.all.selAmtType[0].value;
  if(document.all.selAmtType[1].checked){ type = document.all.selAmtType[1].value; }

  var lvl = getLevel(str, div, dpt, cls)

  if (error) alert(msg);
  else { sbmReport(div, dpt, cls, ven, vennm, str, frdate, todate, lvl, type) }

  return error == false;
}
//==============================================================================
// submit report
//==============================================================================
function sbmReport(div, dpt, cls, ven, vennm, str, frdate, todate, lvl, type)
{
   url = "WkSlsTrend.jsp?"
    + "&DEPARTMENT=" + dpt
    + "&CLASS=" + cls
    + "&VENDOR=" + ven


   for(var i=0; i < div.length; i++) {  url += "&Div=" + div[i]; }
   for(var i=0; i < str.length; i++) {  url += "&Str=" + str[i]; }
   url += "&FromDt=" + frdate
        + "&ToDt=" + todate
        + "&LEVEL=" + lvl
        + "&SORT=GROUP"
        + "&selAmtType=" + type

   //alert(url)
   window.location.href = url;
}
//==============================================================================
// is numeric
//==============================================================================
function isNum(str) {
  if(!str) return false;
  for(var i=0; i < str.length; i++){
    var ch=str.charAt(i);
    if ("0123456789".indexOf(ch) ==-1) return false;
  }
  return true;
}
//==============================================================================
// get level
//==============================================================================
function  getLevel(selStr, selDiv, selDpt, selCls)
{
  var Level = null;

  if((selDiv[0]=="ALL" || selDiv.length > 1) && selDpt=="ALL" && selCls=="ALL") Level = "D";
  else if((selDiv[0] !="ALL" && selDiv.length == 1) && selDpt=="ALL" && selCls=="ALL") Level = "P";
  else if(selDpt!="ALL" && selCls=="ALL") Level = "C";
  else if(selCls!="ALL") Level = "S";

  return Level;
}
//==============================================================================
// set all store or unmark
//==============================================================================
function setAll(on)
{
   var str = document.all.Str;
   for(var i=0; i < str.length; i++) { str[i].checked = on; }
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
// set all non-store location or unmark
//==============================================================================
function setNonStr(on)
{
	ArrNonStr
	var str = document.all.Str
	var chk1 = true;
	var chk2 = false;

	for(var i=0; i < str.length; i++)
	{	   
	   for(var j=0; j < ArrNonStr.length; j++)
	   {
	      if(str[i].value == ArrNonStr[j])
	      {
	         str[i].checked = chk1;
	      };
	   }
	}
}
//==============================================================================
// switch frome date range to 1 date (WTD/MTD/YTD)
//==============================================================================
function switchDates()
{
  if(DateRange)
  {
    document.all.spnFrom.style.display = "none";
    document.all.btnDate.innerHTML = "Date Range";
  }
  else
  {
     document.all.spnFrom.style.display = "inline";
     document.all.btnDate.innerHTML = "One Date<br>(displays inventory information)";
  }
  DateRange = !DateRange;
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
  var button = document.all[id];
  var date = new Date(button.value);
  date.setHours(18);

  if(direction == "DOWN") date = new Date(new Date(date) - 86400000 * 7);
  else if(direction == "UP") date = new Date(new Date(date) - (-86400000 * 7));
  button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

//==============================================================================
// set Multiple/Single selection mode
//==============================================================================
function setMultiple(mult)
{
   Multiple = mult;

   var sng = document.all.trSingle;
   var dspsng = "none";
   var dspmlt = "block";
   if(!mult){dspsng = "block"; dspmlt = "none";}

   for(var i=0; i < sng.length; i++) {sng[i].style.display=dspsng;}
   document.all.trMult.style.display=dspmlt;
}

</script>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

<!-------------------------------------------------------------------->
<HTML><HEAD>
<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<!-------------------------------------------------------------------->
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Sales Trend Comparison - Selection</B>
        <br><A class=blue href="<%if(!bKiosk) {%>index.jsp<%} else {%>Outsider.jsp<%}%>">Home</A>

      <TABLE>
        <TBODY>
        <!-- ------------- Multiple Divisions  ----------------------------- -->
        <TR id="trMult">
           <TD class="Cell" >Division: &nbsp;  &nbsp; &nbsp;</TD>
           <TD class="Cell1" nowrap>
             <%for(int i=0; i < sDivArr.length; i++){%>
               <input name="mDiv" type="checkbox" value="<%=sDivArr[i]%>"><%=sDivArr[i]%>
               <%if(i == 14 || i > 15 && i % 14 == 0){%><br><%}%>
               &nbsp; &nbsp; &nbsp;
             <%}%>
             <br><button class="Small" onclick="setMultiple(false)">Single</button>
           </TD>
        </tr>
        <!-- ------------- Division  --------------------------------- -->
        <TR id="trSingle">
          <TD class="Cell" >Division:</TD>
          <TD class="Cell1" >
             <input class="Small" name="DivName" size=50 readonly>
             <input class="Small" name="Div" type="hidden">
             <input class="Small" name="DivArg" type="hidden" value=0><br>
             <SELECT name="selDiv" class="Small" onchange="doDivSelect(this.selectedIndex);" size=5>
                <OPTION value="ALL">All Divisions</OPTION>
             </SELECT>
             <button class="Small" onclick="setMultiple(true)">Multiple</button>
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
        <TR id="trSingle">
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
        <tr style="background:red; font-size:1px"><td colspan=4>&nbsp;</td></tr>
        <TR><TD align=center colspan=4><u><b>Store</b></u></TD></tr>
        <tr>
          <TD align=center colspan=4>
              <%for(int i=0; i < iNumOfStr; i++){%>
                  <input name="Str" type="checkbox" value="<%=sStr[i]%>"><%=sStr[i]%>&nbsp;
                  <%if(i > 0 && i % 15 == 0){%><br><%}%>
              <%}%>
              <br><button class="Small" onClick="setAll(true)">All Store</button> &nbsp;

              <button onclick='checkReg(&#34;1&#34;)' class='Small'>Dist 1</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;2&#34;)' class='Small'>Dist 2</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;3&#34;)' class='Small'>Dist 3</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;99&#34;)' class='Small'>Dist 99</button> &nbsp; &nbsp;
              <button onclick='checkReg(&#34;PATIO&#34;)' class='Small'>Patio</button> &nbsp; &nbsp;
              <br>
              <button onclick='checkDist(&#34;9&#34;)' class='Small'>Houston</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;20&#34;)' class='Small'>Dallas/FtW</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;35&#34;)' class='Small'>Ski Chalet</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;38&#34;)' class='Small'>Boston</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;41&#34;)' class='Small'>Okla</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;52&#34;)' class='Small'>Charl</button> &nbsp; &nbsp;
              <button onclick='checkDist(&#34;53&#34;)' class='Small'>Nash</button> &nbsp; &nbsp;
              <br>
              <button onclick='checkMall(&#34;&#34;)' class='Small'>Mall</button> &nbsp; &nbsp;
              <button onclick='checkMall(&#34;NOT&#34;)' class='Small'>Non-Mall</button> &nbsp; &nbsp;
              <button onclick='setNonStr(true)' class='Small'>Non-Store</button> &nbsp; &nbsp;

              <button class="Small" onClick="setAll(false)">Reset</button><br><br>
           </TD>
        </TR>
        <!-- =============================================================== -->
        <tr style="background:red; font-size:1px"><td colspan=4>&nbsp;</td></tr>
        <TR>
          <TD align=center colspan=4>
              <span id="spnFrom">From Weekending Date:
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FromDt')">&#60;</button>
              <input name="FromDt" type="text" size=10 maxlength=10>
              <button class="Small" name="Up" onClick="setDate('UP', 'FromDt')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 500, 300, document.all.FromDt)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a> &nbsp; &nbsp; &nbsp;
              </span>

           To Weekending Date:
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDt')">&#60;</button>
              <input name="ToDt" type="text" size=10 maxlength=10>
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDt')">&#62;</button>
              <a href="javascript:showCalendar(1, null, null, 800, 300, document.all.ToDt)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
            <br><button class="Small" id="btnDate" onClick="switchDates()">One Date<br>(displays inventory information)</button> &nbsp;

          </TD>
        </TR>
        <!-- =============================================================== -->
        <tr style="background:red; font-size:1px"><td colspan=4>&nbsp;</td></tr>
        <TR>
          <TD align=center colspan=4>
              <input name="selAmtType" type="radio" value="R" checked>Retail
              <input name="selAmtType" type="radio" value="U">Units
          </TD>
        </TR>
        <TR>
            <TD align=center colSpan=4>
               <button onClick="Validate()">Submit</button>
           </TD>
          </TR>
         </TBODY>
        </TABLE>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
