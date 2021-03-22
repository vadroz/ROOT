<%@ page import="rciutility.StoreSelect, java.util.*"%>
<%
 //----------------------------------
 // Application Authorization
 //----------------------------------

 if (session.getAttribute("USER")==null)
 {
   response.sendRedirect("SignOn1.jsp?TARGET=POListSel.jsp&APPL=ALL");
 }
 else
 {
     String sUser = session.getAttribute("USER").toString();

     StoreSelect StrSelect = null;
     String sStr = null;
     String sStrName = null;

     String sStrAllowed = session.getAttribute("STORE").toString();

     if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
     {
       StrSelect = new StoreSelect(10);
     }
     else
     {
       Vector vStr = (Vector) session.getAttribute("STRLST");
       String [] sStrAlwLst = new String[ vStr.size()];
       Iterator iter = vStr.iterator();

       int iStrAlwLst = 0;
       while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

       if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
       else StrSelect = new StoreSelect(new String[]{sStrAllowed});
    }

    sStr = StrSelect.getStrNum();
    sStrName = StrSelect.getStrName();

%>
<!-- ================================================================================================================================ -->
<style>
  body {background:ivory;}
        button.Small {padding-top:1px; font-family:Arial; font-size:10px }
        textarea.Small {font-family:Arial; font-size:10px }
  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal{ clear: both; overflow: AUTO; width: 300px; height: 220px; POSITION: relative; text-align:left;}
  div.dvInternal thead td, tfoot td { background-color: #1B82E6; Z-INDEX: 60; position:relative; }
  div.dvInternal table{ border:0px; cellspacing:1px; cellpading:1px; TEXT-ALIGN: left; }
        
</style>
<!-- ================================================================================================================================ -->

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>


<script name="javascript">
var stores = [<%=sStr%>];
var storeNames = [<%=sStrName%>];
var Vendor = null;
var VenName = null;
var LastVen = "";

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   doStrSelect();
   doSelDate();
}
//==============================================================================
// Load Stores
//==============================================================================
function doStrSelect(id)
{
    var df = document.all;
    var j = 0;
    if(stores.length == 2) { j=1; }

    for (var i=0; j < stores.length; i++, j++)
    {
      df.Store.options[i] = new Option(stores[j] + " - " + storeNames[j],stores[j]);
    }
    document.all.Store.selectedIndex=0;
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  doSelDate()
{
  var df = document.forms[0];
  var date = new Date(new Date() -  14 * 86400000);
  date.setHours(18)
  df.FromDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()

  var date = new Date(new Date() -  -14 * 86400000);
  date.setHours(18)
  df.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
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
	else 
	{ 
		document.all.dvVendor.style.visibility = "visible"; 
	}
}
//==============================================================================
//popilate division selection
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
document.all.dvVendor.style.pixelLeft=pos[0] + 200;
document.all.dvVendor.style.pixelTop= pos[1] + 25;
document.all.dvVendor.style.visibility = "visible";
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
//show selected Department Selected
//==============================================================================
function showVenSelect(ven, vennm)
{
	document.all.VenName.value = vennm
	document.all.Ven.value = ven
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
// Validate form
//==============================================================================
function Validate(){
  var form = document.forms[0];
  var error = false;
  var msg = " ";
  
  if (error) alert(msg);

  return error == false;
}

//---------------------------------------------------------
//create String method Trim
//---------------------------------------------------------
function String.prototype.trim()
{ //trim leading and trailing spaces
    var s = this;
    var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
    if (obj.test(s)) { s = s.replace(obj, '$2'); }
    var obj = /  /g;
    while (s.match(obj)) { s = s.replace(obj, ""); }
    return s;
}
</script>
<!-- import calendar functions -->
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Available Purchase Order List - Selection</B>

        <br><a href="../"><font color="red">Home</font></a>


   <FORM  method="GET" action="POWorksheetList.jsp" onSubmit="return Validate(this)">
      <TABLE>
       <TBODY>
       <!-- ================== Store List ============================================= -->
      <tr style="background:darkred; font-size:1px"><td colspan=2>&nbsp;</td></tr>
      <tr>
         <td><br>Select Store:<br><br></td><td><br><SELECT name="Store"></SELECT><br><br></td>
      </tr>
      <!-- ================== Vendor List ============================================= -->
      <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>
      <tr>
          <td>Vendor:</TD>
          <td>
              <input class="Small" name="VenName" size=30 value="All Vendors" readonly>
              <input class="Small" name="Ven" type="hidden" value="ALL">
              <button class="Small" name=GetVen onClick="rtvVendors()">Select Vendors</button><br>
            </TD>
        </TR>
        <!-- ======================== From Date ======================================= -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>
        <TR>
          <TD class=DTb1 align=center colspan=2><u><b>Select Ship or Anticipate Dates:</b></u></TD>
        </tr>
        <TR>
          <TD class=DTb1 align=right >From Date:</TD>
          <TD valign="middle">
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FromDate')">&#60;</button>
              <input name="FromDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FromDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 300, 250, document.forms[0].FromDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </TD>
        </TR>
        <!-- ======================== To Date ======================================= -->
        <TR>
          <TD class=DTb1 align=right >To Date:</TD>
          <TD>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate')">&#60;</button>
              <input name="ToDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 300, 250, document.forms[0].ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
          </TD>
        </TR>
         <!-- ======================== Open/Close ======================================= -->
         <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>
        <TR>
          <TD align=center colspan=2><br>Status:&nbsp;
              <input name="Sts" type="radio" value="O" checked>Open&nbsp;&nbsp;&nbsp;
              <input name="Sts" type="radio" value="C">Closed&nbsp;&nbsp;&nbsp;
              <input name="Sts" type="radio" value="B">Both
          </TD>
        </TR>
        <TR>
          <TD align=center colspan=2><br>Include SO POs:&nbsp;
              <input name="InclSO" type="checkbox" value="Y">&nbsp;&nbsp;&nbsp;
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="2" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD></TD>
            <TD align=left colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT>
           </TD>
          </TR>
         </TBODY>
        </TABLE>
       </FORM>
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
  System.out.println(out.toString());
}%>