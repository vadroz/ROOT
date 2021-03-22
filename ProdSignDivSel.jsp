<%@ page import="rciutility.ClassSelect, java.sql.*, java.util.*, java.text.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null )
{
     response.sendRedirect("SignOn1.jsp?TARGET=ProdSignDivSel.jsp&APPL=ALL");
}
else
{
	ClassSelect divsel = null;
    divsel = new ClassSelect();
    String sDiv = divsel.getDivNum();
    String sDivName = divsel.getDivName();
%>
<title>Product Signs - Selection</title>
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

<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script name="javascript">
var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";

var NewSku = "";
var NewPath = "";

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) 
	{  
	   isSafari = true;
	   setDraggable();
	}
	doDivSelect(null);
	rtvVendors()
}
//==============================================================================
//popilate division selection
//==============================================================================
function doDivSelect(id) 
{
 	var df = document.all;
 	var divisions = [<%=sDiv%>];
	var divisionNames = [<%=sDivName%>];
 	var chg = id;

 	var allowed;

 	if (id == null || id == 0)
 	{
     	//  populate the division list
     	var start = 1
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
}
//==============================================================================
//retreive vendors
//==============================================================================
function rtvVendors()
{
	if (Vendor==null)
	{
   		var url = "RetreiveVendorList.jsp"
   		if(isIE || isSafari){ window.frame1.location.href = url; }
   		else if(isChrome || isEdge) { window.frame1.src = url; }
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
var html = "<input name='FndVen' class='Small' size=5 maxlength=5>&nbsp;"
  + "<input name='FndVenName' class='Small1' size=25 maxlength=25>&nbsp;"
  + "<button onclick='findSelVen()' class='Small'>Find</button>&nbsp;" 
var dummy = "<table>"

html += "<div id='dvInt' class='dvInternal'>"
      + "<table border=0 width='100%' cellPadding=0 cellSpacing=0 style='font-size:10px;'>"
for(var i=0; i < ven.length; i++)
{
  html += "<tr id='trVen'><td style='cursor:default;' onclick='javascript: showVenSelect(&#34;" + ven[i] + "&#34;, &#34;" + venName[i] + "&#34;)'>" + venName[i] + "</td></tr>"
}
html += "</table></div>"
var pos = getObjPosition(document.all.VenName)

document.all.dvVendor.innerHTML = html;
document.all.dvVendor.style.left= pos[0];
document.all.dvVendor.style.top= pos[1] + 25;
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
  if(ven != "" && ven != " " && ven == Vendor[i]) { fnd = true; LastTr=i; break;}
  else if(vennm != "" && vennm != " " && VenName[i].indexOf(vennm) >= 0) { fnd = true; LastTr=i; break;}
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
// Validate form
//==============================================================================
function Validate(dwnl)
{
  var error = false;
  var msg = "";

  var sku = document.getElementsByName("Sku")[0].value.trim(); 
  if(sku != "")
  {
	  if(getScannedItem(sku))  
	  {
		  document.getElementsByName("Sku")[0].value = "";
		  
		  if(NewPath != "Not Found"){ window.open(NewPath); }
		  else { alert("Sign is not found"); }
	  }	
	  else { alert("UPS/SKU is not valid"); }
  }
  else 
  {
  	var div = document.all.Div.value.trim();
  	var ven = document.all.Ven.value.trim();

  	if(div==""){ error=true; msg="Please enter division." }

  	if (error) alert(msg);
  	else{ sbmSign(div, ven); }
  }
  return error == false;
}
//==============================================================================
// Submit sign list
//==============================================================================
function sbmSign(div, ven)
{
  var url = "ProdSignDiv.jsp?"
   + "Div=" + div
   + "&Ven=" + ven

  //alert(url)
  window.location.href=url;
}
//==============================================================================
// clear vendor selection 
//==============================================================================
function clearVen()
{
	document.getElementsByName("VenName")[0].value = "";
	document.getElementsByName("Ven")[0].value = "";
}
//==============================================================================
//check scanned item against order
//==============================================================================
function getScannedItem(item)
{
	var url = "ProdSignbySku.jsp?Item=" + item;
    var valid = true;
    
	var xmlhttp;
	// code for IE7+, Firefox, Chrome, Opera, Safari
	if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
	// code for IE6, IE5
	else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
  			var  resp = xmlhttp.responseText;  		
  			valid = parseElem(resp, "UPC_Valid") == "true";
			NewSku = parseElem(resp, "SKU");
  			NewPath = parseElem(resp, "PATH");    		
  		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return NewSku;
}
//==============================================================================
//parse XML elements
//==============================================================================
function parseElem(resp, tag )
{
	var taglen = tag.length + 2;
	var beg = resp.indexOf("<" + tag + ">") + taglen;
	var end = resp.indexOf("</" + tag+ ">");
	return resp.substring(beg, end);
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();" bgColor=moccasin>
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<div id="dvPoNum" class="dvVendor"></div>
<div id="dvMozuSandBox" class="dvMozuSandBox"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<TABLE width="100%" border=0>
  <TBODY>
  <TR>
    <TD vAlign=top align=middle colspan=4>
        <B>Retail Concepts Inc.
        <br>Product Information Signs</B>

        <br>
        <br><A class=blue href="/">Home</A></FONT><FONT face=Arial color=#445193 size=1>

        <!-- =============================================================== -->
        <TR valign="top">
        	<td align=center colspan=4>Scan (or Enter) the UPC/SKU to lookup a Product Sign</td>
        </TR>
        <TR valign="top">
            
            
        	<td align=right colspan=2>UPC/SKU: &nbsp; </td>
        	<td align=left colspan=2>
            	<input class="Small" name="Sku" size=18 maxlength=14>
            	<br><br><br> - or - 
            	<br><br><br>
            </td>	
        </TR>	
        <TR valign="top">
        	<td align=right>Division: &nbsp; </td>
            <td align=left >
            	<input class="Small" name="DivName" size=50 readonly>
             	<input class="Small" name="Div" type="hidden">
             	<input class="Small" name="DivArg" type="hidden" value=0><br>
             	<SELECT name="selDiv" class="Small" onchange="doDivSelect(this.selectedIndex);" size=22>
                	<OPTION value="ALL">All Divisions</OPTION>
             	</SELECT>
            </td>            
            <td align=right>Vendor &nbsp; </td>
            <td align=left >
              <input class="Small" name="VenName" size=50 value="All Vendors" readonly>
              <input class="Small" name="Ven" type="hidden" value="ALL"> 
              <button  class="Small" onclick="clearVen()">Clear</button>
            </td>
         </TR>
         <tr>
           <td align=center colspan=4>
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