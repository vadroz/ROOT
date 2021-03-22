<%@ page import="rciutility.ClassSelect"%>
<%
   //----------------------------------
   // Application Authorization   
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("TRANSFER") == null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=ItemBsrEditingSel_v2.jsp&APPL=TRANSFER");
   }
   else   
   {
      String sUser = session.getAttribute("USER").toString();

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
<html>
<head>
	<title>Item BSR Editing</title>
	<meta http-equiv="refresh">
	<META content="Microsoft FrontPage 4.0" name=GENERATOR>
</head>
<style>
  .Small {font-family: times; font-size:10px }
  td.Cell {font-size:12px; text-align:right; vertical-align: middle}
  td.Cell1 {font-size:12px; text-align:left; vertical-align: middle}
  td.Cell2 {font-size:12px; text-align:center; vertical-align: middle}

  div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
        width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}
  div.dvInternal { overflow: auto;border: none; width:300; height:220;
                   background-color:white; z-index:10; text-align:left; font-size:10px}

  div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}

  td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
  td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

  tr.Prompt { background: lavender; font-size:10px }
  tr.Prompt1 { background: seashell; font-size:10px }
  tr.Prompt2 { background: LightCyan; font-size:11px }

  th.Prompt { background:#FFCC99; text-align:ceneter; vertical-align:midle; font-family:Arial; font-size:11px; }
  td.Prompt { text-align:left; vertical-align:top; font-family:Arial;}
  td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial;}
  td.Prompt2 { text-align:right; font-family:Arial; }
  td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial;}
  </style>


<script name="javascript">
var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";

 
var BWhse = null;
var BCrtDate = null;
var BCrtByUser = null;

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
    
  doDivSelect(null);
 

  setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   
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
// show date selection
//==============================================================================
function showDates(type)
{
   if(type==1)
   {
     document.all.tdDate1.style.display="none"
     document.all.tdDate2.style.display="block"
   }
   else
   {
     document.all.tdDate1.style.display="none"
     document.all.tdDate2.style.display="block"
   }
}

//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";

  var div = document.all.Div.value.trim();
  var divnm = document.all.DivName.value.trim();
  var dpt = document.all.Dpt.value.trim();
  var dptnm = document.all.DptName.value.trim();
  var cls = document.all.Cls.value.trim();
  var clsnm = document.all.ClsName.value.trim();
  var ven = document.all.Ven.value.trim();
  var vennm = document.all.VenName.value.trim();
 
  var bsrlvl = document.all.SelBsr.options[document.all.SelBsr.selectedIndex].value;
  
  var frLastRcvDt = document.all.FrLastRcvDt.value.trim();
  var toLastRcvDt = document.all.ToLastRcvDt.value.trim();
  var frLastSlsDt = document.all.FrLastSlsDt.value.trim();
  var toLastSlsDt = document.all.ToLastSlsDt.value.trim();
  var frLastMdnDt = document.all.FrLastMdnDt.value.trim();
  var toLastMdnDt = document.all.ToLastMdnDt.value.trim();
  var permMdn = "B";
  var neverOut = " ";
 
  if(frLastRcvDt == ""){ frLastRcvDt = "NONE"; }
  if(toLastRcvDt == ""){ toLastRcvDt = "NONE"; } 
  if(frLastSlsDt == ""){ frLastSlsDt = "NONE"; } 
  if(toLastSlsDt == ""){ toLastSlsDt = "NONE"; } 
  if(frLastMdnDt == ""){ frLastMdnDt = "NONE"; }
  if(toLastMdnDt == ""){ toLastMdnDt = "NONE"; }
	  
  permMdn = document.all.SelMdn.options[document.all.SelMdn.selectedIndex].value;
  if(document.all.NvrOut.checked){ neverOut = "Y"; }
 
  if (error) { alert(msg); }
  else 
  { 
	  sbmSlsRep(div, divnm, dpt, dptnm, cls, clsnm, ven, vennm, bsrlvl
				, frLastRcvDt, toLastRcvDt, frLastSlsDt, toLastSlsDt, frLastMdnDt, toLastMdnDt
				, permMdn, neverOut); 
  }
  return error == false;
}
//==============================================================================
// Submit list
//==============================================================================
function sbmSlsRep(div, divnm, dpt, dptnm, cls, clsnm, ven, vennm
		, bsrlvl
		, frLastRcvDt, toLastRcvDt, frLastSlsDt, toLastSlsDt, frLastMdnDt, toLastMdnDt
		, permMdn, neverOuts)
{
  var url = null;
  url = "ItemBsrEdit_v2.jsp?"

  url += "Div=" + div
      + "&DivName=" + divnm
      + "&Dpt=" + dpt
      + "&DptName=" + dptnm
      + "&Cls=" + cls
      + "&ClsName=" + clsnm
      + "&Ven=" + ven
      + "&VenName=" + vennm
      + "&BsrLvl=" + bsrlvl
      + "&FrLastRcvDt=" + frLastRcvDt 
      + "&ToLastRcvDt=" + toLastRcvDt 
      + "&FrLastSlsDt=" + frLastSlsDt 
      + "&ToLastSlsDt=" + toLastSlsDt
      + "&FrLastMdnDt=" + frLastMdnDt
      + "&ToLastMdnDt=" + toLastMdnDt
      + "&PermMdn=" + permMdn  
      + "&NeverOuts=" + neverOuts 
   ;

  //alert(url)
  window.location.href=url;
} 
//==============================================================================
// close Submitting frame
//==============================================================================
function closeFrame()
{
   window.frame1.close();
   alert("Report has been submitted")
}


 


//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
//--------------------------------------------------------
// clear date field
//--------------------------------------------------------
function clearDt(dtobj)
{
	dtobj.value="";
}
//==============================================================================
//populate date with yesterdate
//==============================================================================
function  setDate(direction, id, ymd)
{
var dtobj = document.all[id];
if(dtobj.value == ""){dtobj.value = new Date();}
var date = new Date(dtobj.value);

if(direction == "DOWN" && ymd=="DAY") { date = new Date(new Date(date) - 86400000); }
else if(direction == "UP" && ymd=="DAY") { date = new Date(new Date(date) - -86400000); }

if(direction == "DOWN" && ymd=="MON") { date.setMonth(date.getMonth()-1); }
else if(direction == "UP" && ymd=="MON") { date.setMonth(date.getMonth()+1); }

if(direction == "DOWN" && ymd=="YEAR") { date.setYear(date.getFullYear()-1); }
else if(direction == "UP" && ymd=="YEAR") { date.setYear(date.getFullYear()+1); }

dtobj.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}
</script>


<script LANGUAGE="JavaScript" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript" src="Calendar.js"></script>



<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<iframe id="frame2" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<div id="dvVendor" class="dvVendor"></div>
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Item DR (BSR) Editing - Selection</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>

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
         
         
        <!-- ======================== All Item Only ================================ -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <tr id="trSel">
           <TD class="Cell2" nowrap colspan=4><b><u>Item Filter</u></b>
            <table border=0>
            
            	<tr>
        			<TD class="Cell" nowrap>Permanent Markdown:</TD>
        			<TD class="Cell1" nowrap>
        				<select class="Small" name="SelMdn">
        		  			<option value="B">Both</option>
        		  			<option value="Y">Yes</option>
        		  			<option value="N">No</option>        		  
        				</select>Yes/No/Both
        			</TD>
        			
        			<TD class="Cell" nowrap>BSR Level: </TD>
        			<TD class="Cell1" nowrap>
        			   	<select class="Small" name="SelBsr">
        		  			<option value="B">Both</option>
        		  			<option value="Y">Yes</option>
        		  			<option value="N">No</option>        		  
        				</select>Yes/No/Both
        			</TD>        		
        		 
          			<TD class="Cell2" colspan=4 nowrap>Never Out?&nbsp;<input type="checkbox" class="Small" name="NvrOut" value="Y"></TD>   
        		</tr>
        		
        		<tr><td>&nbsp;</td></tr>
        		            
            	<tr>          
        			<TD class="Cell2" colspan=3 nowrap><b>Last Received Date</b></TD>
        			<TD class="Cell2" colspan=3 nowrap><b>Last Sale Date</b></TD>
        			<TD class="Cell2" colspan=3 nowrap><b>Last Markdown Date</b></TD> 
        		</tr>
                <tr>          
        			<TD class="Cell" nowrap>From Date:</TD>
        			<TD class="Cell" nowrap>
        				<button class="Small" name="Down" onClick="setDate('DOWN', 'FrLastRcvDt', 'YEAR')">y-</button>
              			<button class="Small" name="Down" onClick="setDate('DOWN', 'FrLastRcvDt', 'MON')">m-</button>
              			<button class="Small" name="Down" onClick="setDate('DOWN', 'FrLastRcvDt', 'DAY')">d-</button>
        				<input class="Small" name="FrLastRcvDt" type="text" size=10 maxlength=10 readonly>
              			<button class="Small" name="Up" onClick="setDate('UP', 'FrLastRcvDt', 'DAY')">d+</button>
              			<button class="Small" name="Up" onClick="setDate('UP', 'FrLastRcvDt', 'MON')">m+</button>
              			<button class="Small" name="Up" onClick="setDate('UP', 'FrLastRcvDt', 'YEAR')">y+</button>
              			<a href="javascript:showCalendar(1, null, null, 300, 300, document.all.FrLastRcvDt)" >
              			<img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
        			</TD>
        			<TD class="Cell1" nowrap><a href="javascript: clearDt(document.all.FrLastRcvDt)">Clear</a></TD>
        		     
        		         
        			<TD class="Cell" nowrap>From Date:</TD>
        			<TD class="Cell" nowrap>
        			    <button class="Small" name="Down" onClick="setDate('DOWN', 'FrLastSlsDt', 'YEAR')">y-</button>
              			<button class="Small" name="Down" onClick="setDate('DOWN', 'FrLastSlsDt', 'MON')">m-</button>
              			<button class="Small" name="Down" onClick="setDate('DOWN', 'FrLastSlsDt', 'DAY')">d-</button>        				
        				<input class="Small" name="FrLastSlsDt" type="text" size=10 maxlength=10 readonly>
              			<button class="Small" name="Up" onClick="setDate('UP', 'FrLastSlsDt', 'DAY')">d+</button>
              			<button class="Small" name="Up" onClick="setDate('UP', 'FrLastSlsDt', 'MON')">m+</button>
              			<button class="Small" name="Up" onClick="setDate('UP', 'FrLastSlsDt', 'YEAR')">y+</button>
              			<a href="javascript:showCalendar(1, null, null, 500, 300, document.all.FrLastSlsDt)" >
              			<img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
        			</TD>
        			<TD class="Cell1" nowrap><a href="javascript: clearDt(document.all.FrLastSlsDt)">Clear</a></TD>
        		           
        			<TD class="Cell1" nowrap>From Date:</TD>
        			<TD class="Cell" nowrap>        			
        				<button class="Small" name="Down" onClick="setDate('DOWN', 'FrLastMdnDt', 'YEAR')">y-</button>
              			<button class="Small" name="Down" onClick="setDate('DOWN', 'FrLastMdnDt', 'MON')">m-</button>
              			<button class="Small" name="Down" onClick="setDate('DOWN', 'FrLastMdnDt', 'DAY')">d-</button>
        				<input class="Small" name="FrLastMdnDt" type="text" size=10 maxlength=10 readonly>
              			<button class="Small" name="Up" onClick="setDate('UP', 'FrLastMdnDt', 'DAY')">d+</button>
              			<button class="Small" name="Up" onClick="setDate('UP', 'FrLastMdnDt', 'MON')">m+</button>
              			<button class="Small" name="Up" onClick="setDate('UP', 'FrLastMdnDt', 'YEAR')">y+</button>
              			<a href="javascript:showCalendar(1, null, null, 900, 300, document.all.FrLastMdnDt)" >
              			<img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              			<TD class="Cell1" nowrap><a href="javascript: clearDt(document.all.FrLastMdnDt)">Clear</a>&nbsp;&nbsp;</TD>
        			</TD> 
        		</tr>
        		 
                <tr>          
        			<TD class="Cell" nowrap>To Date:</TD>
        			<TD class="Cell" nowrap>
        				<button class="Small" name="Down" onClick="setDate('DOWN', 'ToLastRcvDt', 'YEAR')">y-</button>
              			<button class="Small" name="Down" onClick="setDate('DOWN', 'ToLastRcvDt', 'MON')">m-</button>
              			<button class="Small" name="Down" onClick="setDate('DOWN', 'ToLastRcvDt', 'DAY')">d-</button>
        				<input class="Small" name="ToLastRcvDt" type="text" size=10 maxlength=10 readonly>
              			<button class="Small" name="Up" onClick="setDate('UP', 'ToLastRcvDt', 'DAY')">d+</button>
              			<button class="Small" name="Up" onClick="setDate('UP', 'ToLastRcvDt', 'MON')">m+</button>
              			<button class="Small" name="Up" onClick="setDate('UP', 'ToLastRcvDt', 'YEAR')">y+</button>
              			<a href="javascript:showCalendar(1, null, null, 300, 300, document.all.ToLastRcvDt)" >
              			<img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
        			</TD>
        			<TD class="Cell1" nowrap><a href="javascript: clearDt(document.all.ToLastRcvDt)">Clear</a>&nbsp;&nbsp;</TD>
        		     
        		         
        			<TD class="Cell" nowrap>To Date:</TD>
        			<TD class="Cell" nowrap>
        			    <button class="Small" name="Down" onClick="setDate('DOWN', 'ToLastSlsDt', 'YEAR')">y-</button>
              			<button class="Small" name="Down" onClick="setDate('DOWN', 'ToLastSlsDt', 'MON')">m-</button>
              			<button class="Small" name="Down" onClick="setDate('DOWN', 'ToLastSlsDt', 'DAY')">d-</button>        				
        				<input class="Small" name="ToLastSlsDt" type="text" size=10 maxlength=10 readonly>
              			<button class="Small" name="Up" onClick="setDate('UP', 'ToLastSlsDt', 'DAY')">d+</button>
              			<button class="Small" name="Up" onClick="setDate('UP', 'ToLastSlsDt', 'MON')">m+</button>
              			<button class="Small" name="Up" onClick="setDate('UP', 'ToLastSlsDt', 'YEAR')">y+</button>
              			<a href="javascript:showCalendar(1, null, null, 500, 300, document.all.ToLastSlsDt)" >
              			<img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
        			</TD>
        			<TD class="Cell1" nowrap><a href="javascript: clearDt(document.all.ToLastSlsDt)">Clear</a>&nbsp;&nbsp;</TD>
        		           
        			<TD class="Cell" nowrap>To Date:</TD>
        			<TD class="Cell1" nowrap>        			
        				<button class="Small" name="Down" onClick="setDate('DOWN', 'ToLastMdnDt', 'YEAR')">y-</button>
              			<button class="Small" name="Down" onClick="setDate('DOWN', 'ToLastMdnDt', 'MON')">m-</button>
              			<button class="Small" name="Down" onClick="setDate('DOWN', 'ToLastMdnDt', 'DAY')">d-</button>
        				<input class="Small" name="ToLastMdnDt" type="text" size=10 maxlength=10 readonly>
              			<button class="Small" name="Up" onClick="setDate('UP', 'ToLastMdnDt', 'DAY')">d+</button>
              			<button class="Small" name="Up" onClick="setDate('UP', 'ToLastMdnDt', 'MON')">m+</button>
              			<button class="Small" name="Up" onClick="setDate('UP', 'ToLastMdnDt', 'YEAR')">y+</button>
              			<a href="javascript:showCalendar(1, null, null, 900, 300, document.all.ToLastMdnDt)" >
              			<img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              			<TD class="Cell1" nowrap><a href="javascript: clearDt(document.all.ToLastMdnDt)">Clear</a></TD>
        			</TD> 
        		</tr>        		
        	</table>
           </td>		
        </tr>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
        <TR><TD class="Cell2" colSpan=4>
               <button onClick="Validate()">Submit</button>  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
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