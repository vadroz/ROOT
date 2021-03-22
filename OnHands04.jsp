<%@ page import="rciutility.StoreSelect, rciutility.ClassSelect"%>
<%
   StoreSelect StrSelect = null;
   String sStr = null;
   String sStrName = null;

   //StrSelect = new StoreSelect();
   StrSelect = new StoreSelect(5);
   sStr = StrSelect.getStrNum();
   sStrName = StrSelect.getStrName();

   boolean bKiosk = session.getAttribute("USER") == null;
   String sUser = "KIOSK";
   if(!bKiosk) { sUser = session.getAttribute("USER").toString(); }

   // call from kiosk
   String sKioskStr = request.getParameter("KioskStr");
   String sKioskSrc = request.getParameter("KioskSrc");

   if(sKioskStr == null){sKioskStr = "NONE";}
   if(sKioskSrc == null){sKioskSrc = "NONE";}
   
   
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
  body {background:ivory;}
  table.DataTable { background:#FFE4C4;}
  .Small {font-family: times; font-size:10px }
  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top}
  td.DataTable1 { font-family:Verdanda; font-size:18px }
  td.DataTable2 { font-family:Verdanda; font-size:18px }
  td.DataTable3 { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px;
                  border-bottom: white solid 1px; border-right: white solid 1px;
                  border-top: white solid 1px;border-left: white solid 1px;}
  td.DataTable4 { padding-left:3px;padding-right:3px;padding-top:3px;padding-bottom:3px; }
  
  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
        width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}

  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}

  div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
  
</style> 

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script name="javascript1.2">
var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";


//====================================================================
// initialize process
//====================================================================
function bodyLoad()
{
  if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
  <%if(!bKiosk){%>doStrSelect();<%}%>
  
  doDivSelect(null);
  
}
//====================================================================
// Load Stores
//====================================================================
function doStrSelect(id) {
    var stores = [<%=sStr%>];
    var storeNames = [<%=sStrName%>];
    var store = null;

    for (idx = 1; idx < stores.length; idx++)
    {
      if (stores[idx].length == 1) store = "0" + stores[idx];
      else store = stores[idx];
      document.all.STORE.options[idx-1 ] = new Option(stores[idx] + " - " + storeNames[idx], store);
    }
}

//==============================================================================
//popilate division selection
//==============================================================================
function doDivSelect(id) {
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
    	 document.all.selDiv.options[idx] = new Option(divisionNames[idx],divisions[idx]);
     }
     id = 0
     if (document.all.DivArg.value.trim() > 0) id = eval(document.all.DivArg.value.trim());
     document.all.selDiv.selectedIndex = id;
 }

 document.all.DivName.value = document.all.selDiv.options[id].text
 document.all.Div.value = document.all.selDiv.options[id].value
 document.all.DivArg.value = id

 allowed = dep_div[id].split(":");

 //  clear current depts
 for (idx = document.all.selDpt.length; idx >= 0; idx--)
 {
	 document.all.selDpt.options[idx] = null;
 }

 //  if all are to be displayed
 if (allowed[0] == "all")
 {
    for (idx = 0; idx < depts.length; idx++)
    	document.all.selDpt.options[idx] = new Option(deptNames[idx],depts[idx]);
 }
 //  else display the desired depts
 else
 {
    for (idx = 0; idx < allowed.length; idx++)
    	document.all.selDpt.options[idx] = new Option(deptNames[allowed[idx]], depts[allowed[idx]]);
 }

 if(chg!=null)
 {
   showDptSelect(0);
   showClsSelect(0);
 }
}
//==============================================================================
//show selected Department Selected
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
//show selected Department Selected
//==============================================================================
function showClsSelect(id)
{
document.all.ClsName.value = document.all.selCls.options[id].text
document.all.Cls.value = document.all.selCls.options[id].value
}
//==============================================================================
//retreive classes
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
	//window.frame1.location = url;

	if(isIE || isSafari){ window.frame1.location.href = url; }
	else if(isChrome || isEdge) { window.frame1.src = url; }
}
//==============================================================================
//show selected classes
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
//retreive vendors
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
//popilate division selection
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
//find object postition
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
//find selected vendor
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
//show selected Department Selected
//==============================================================================
function showVenSelect(ven, vennm)
{
document.all.VenName.value = vennm
document.all.Ven.value = ven
}



//------------------------------------------------------------------------------
// Validate form entry
//------------------------------------------------------------------------------
  function Validate(form)
  {
    var error = false;
    var msg="";

    if(error) alert(msg);
    else(submit())    
  }
//------------------------------------------------------------------------------
// submit form
//------------------------------------------------------------------------------
function submit()
{  
  var str = "1";
  if(document.all.STORE != null)
  {
     str = document.all.STORE.options[document.all.STORE.selectedIndex].value;
  }

  var div = document.all.Div.value;
  var dpt = document.all.Dpt.value;
  var cls = document.all.Cls.value;
  var ven = document.all.Ven.value;
  var vst = document.all.VENSTY.value.toUpperCase();
  var desc = document.all.DESC.value.toUpperCase();
  var user = document.all.User.value;
  var kioskStr = document.all.KioskStr.value;
  var kioskSrc = document.all.KioskSrc.value;
  
  
  var url = "servlet/onhand01.OnHands03?STORE=" + str
  if(div != "" && div != "ALL") url += "&DIVISION=" + div;
  if(dpt != "" && dpt != "ALL") url += "&DEPARTMENT=" + dpt;
  if(cls != "" && cls != "ALL") url += "&CLASS=" + cls;
  if(ven != "" && ven != "ALL") url += "&VENDOR=" + ven;
  if(vst != "") url += "&VST=" + vst;
  if(desc != "") url += "&DESC=" + desc;
  url += "&User=" + user
    + "&KioskStr=" + kioskStr
    + "&KioskSrc=" + kioskSrc;

  url += "&OutSlt=HTML";
  

  /*var url = "servlet/onhand01.OnHands04?STORE=" + str
  if(div != "") url += "&DIV=" + div;
  if(dpt != "") url += "&DPT=" + dpt;
  if(cls != "") url += "&CLASS=" + cls;
  if(ven != "") url += "&VENDOR=" + ven;
  if(vst != "") url += "&VENSTY=" + vst;
  if(desc != "") url += "&DESC=" + desc;
  url += "&KioskStr=" + kioskStr;
  url += "&KioskSrc=" + kioskSrc;
  url += "&User=" + user;
*/

  //alert(url)
  window.location.href=url;

}

//------------------------------------------------------------------------------
// Open prompt window
//------------------------------------------------------------------------------
function openPromptWdw(search) {
  var URL = "ItmSearchProperties.jsp?Search=" + search;
  URL += "&DIV=" + document.forms[0].DIV.value;
  URL += "&DPT=" + document.forms[0].DPT.value;
  URL += "&CLS=" + document.forms[0].CLASS.value;

  var WindowName = search;
  var WindowOptions =
   'width=600,height=400, toolbar=no, location=no, directories=no, status=yes, scrollbars=yes,resize=no,menubar=no';

  //alert(URL)
  window.open(URL, WindowName, WindowOptions);
}
</script>

<HTML>
  <head>
	<title>Inventory Lookup</title>
	<meta http-equiv="refresh">
	<META content="Microsoft FrontPage 4.0" name=GENERATOR>
  </head>



<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript" src="Get_Object_Position.js"></script>

<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<iframe id="frame2" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->
<TABLE  border=0 width="100%">
  <TBODY>
  <TR>
    <TD colSpan=2 height="20%" vAlign=top align=center><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
    <BR>Inventory Lookup</B>

      <!-- FORM -->
            <input name="KioskStr" type="hidden" value="<%=sKioskStr%>">
            <input name="KioskSrc" type="hidden" value="<%=sKioskSrc%>">
            
      <TABLE border=0>
        <TBODY>
        <!-- =============================================================== -->
        <!--  Store Selection  -->
        <!-- =============================================================== -->
        <%if(!bKiosk){%>
            <TR>
              <TD class=DataTable align="right" colspan=2>Store Pricing:</TD>
              <TD class=DataTable colspan="2" align=left>
                <SELECT name="STORE"></SELECT>
              </TD>
            </TR>
        <%}%>
        
        
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
        
        <!-- =============================================================== -->
        <!-- Vendor style -->
        <!-- =============================================================== -->
        <tr>
          <TD class="Cell" align=right>Vendor style contains:</TD>
          <TD class="Cell1" align="left"><INPUT maxLength=15 size=15 name="VENSTY">        
        <!-- =============================================================== -->
        <!--  Search by Item description
        <!-- =============================================================== -->
          <TD class="Cell" align=right>Item description contains:</TD>
          <TD class="Cell1" align="left" colspan="3"><INPUT maxLength=25 size=25 name="DESC">
        </tr>
        <!-- =============================================================== -->
        <!--  Submit  -->
        <!-- =============================================================== -->
        <TR>
          <TD class=DataTable4 align=center colSpan=5>
            <INPUT type=hidden value="<%=sUser%>" name="User">
            <!-- INPUT type=submit value=Submit name=SUBMIT>&nbsp; -->
            <button onclick = 'Validate()' >Submit</button>
          </TD>  
        </TR>
        <!-- =============================================================== -->
        <%if(!bKiosk){%>
           <TR >
             <td colspan=3 valign=bottom align=center><a href="/"><font color="red" size="-1">Rci Home Page</font></a><td>
           </TR>
        <%} else {%>
          <td colspan=3 valign=bottom align=center><a href="/KioskMain.jsp?utm_medium=<%=sKioskStr%>&utm_source=<%=sKioskSrc%>"><font color="red" size="-1">Kiosk Main</font></a><td>
      <%}%>
        <!-- =============================================================== -->
       </TBODY>
      </TABLE>
     <!--  /FORM -->
    </TD>
   </TR>
  </TBODY>
</TABLE>
</BODY>
</HTML>
