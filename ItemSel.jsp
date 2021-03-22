<%@ page import="rciutility.ClassSelect"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("TRANSFER") == null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=ItemSel.jsp&APPL=TRANSFER");
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
	<title>Item Transfer</title>
	<meta http-equiv="refresh">
	<META content="Microsoft FrontPage 4.0" name=GENERATOR>
</head>
<style>
  .Small {font-family: times; font-size:10px }
  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top}

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

<script LANGUAGE="JavaScript1.2" src="Calendar.js">
</script>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script name="javascript">
var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";

var Batch = null;
var BComment = null;
var BWhse = null;
var BCrtDate = null;
var BCrtByUser = null;

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) 
    {  
	   isSafari = true;
	}
	
	document.all.btnOpenWdw.style.visibility='hidden';
  document.all.btnDltBatch.style.visibility='hidden';
  sbmList.style.visibility = "hidden";

  doDivSelect(null);

  document.all.BComment.value = "";
  document.all.BWhse.checked = false;
  rtvBatchNumber();

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
   if(isIE || isSafari){ window.frame1.location.href = url; }
   else if(isChrome || isEdge) { window.frame1.src = url; }
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
   	  if(isIE || isSafari){ window.frame1.location.href = url; }
      else if(isChrome || isEdge) { window.frame1.src = url; }
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
   document.all.dvVendor.style.left= pos[0];
   document.all.dvVendor.style.top= pos[1] + 25;
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
// set Batch Number selection menu
//==============================================================================
function rtvBatchNumber()
{
   var url = "ItemTrfBachList.jsp?Sts=O"

   //alert(url);
   //window.location.href = url;
   if(isIE || isSafari){ window.frame2.location.href = url; }
   else if(isChrome || isEdge) { window.frame2.src = url; }   
}

//==============================================================================
// set Batch Number selection menu
//==============================================================================
function showBatch(batch, bWhse, bComment, bCrtDate, bCrtByUser)
{
   var selbatch = document.all.Batch;
   for(var i = selbatch.length; i >= 0; i--) {selbatch.options[i] = null;} // clear batch numbers

   selbatch.options[0] = new Option("Generate NEW Batch", "NEW")
   for(var i=0; i < batch.length; i++)
   {
     var batchnm = batch[i] + " - " + bComment[i] + " - " + bCrtDate[i] + " - " + bCrtByUser[i];
     selbatch.options[i+1] = new Option(batchnm, batch[i])
   }
   selbatch.selectedIndex = 0;
   sbmList.style.visibility = "visible"


   Batch = batch;
   BComment = bComment;
   BCrtDate = bCrtDate;
   BCrtByUser = bCrtByUser;
   BWhse = bWhse;

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

  var batch = document.all.Batch.options[document.all.Batch.selectedIndex].value;
  var bcomm = document.all.BComment.value.trim();

  // Stores or warehouses?
  var bwhse = " ";
  if (document.all.BWhse.checked) { bwhse = document.all.BWhse.value.trim();}

  if (batch == "NEW" && bcomm == "") { error=true; msg += "Add comments for new batch number";}
  else if( batch != "NEW")
  {
    bcomm = document.all.Batch.options[document.all.Batch.selectedIndex].text;
    bwhse = BWhse[document.all.Batch.selectedIndex-1];
  }

  if (error) alert(msg);
  else if(batch == "NEW" ){ genNewBatch(bcomm, bwhse) }
  else { sbmSlsRep(div, divnm, dpt, dptnm, cls, clsnm, ven, vennm, batch, bwhse, bcomm) }
  return error == false;
}
//==============================================================================
// Submit list
//==============================================================================
function sbmSlsRep(div, divnm, dpt, dptnm, cls, clsnm, ven, vennm, batch, bwhse, bcomm)
{
  var url = null;
  url = "ItemList.jsp?"

  url += "Div=" + div
      + "&DivName=" + divnm
      + "&Dpt=" + dpt
      + "&DptName=" + dptnm
      + "&Cls=" + cls
      + "&ClsName=" + clsnm
      + "&Ven=" + ven
      + "&VenName=" + vennm
      + "&Batch=" + batch
      + "&BWhse=" + bwhse
      + "&BComment=" + bcomm

  //alert(url)
  window.location.href=url;
}

//==============================================================================
// submit new batch creation process
//==============================================================================
function genNewBatch(bcomm, bwhse)
{
  sbmList.style.visibility = "hidden";
  var url = "ItemTrfGenNewBatch.jsp?BWhse=" + bwhse + "&BComment=" + bcomm

  //alert(url)
  if(isIE || isSafari){ window.frame2.location.href = url; }
  else if(isChrome || isEdge) { window.frame2.src = url; }
}
//==============================================================================
// Set new batch number
//==============================================================================
function setNewBatchNumber(batch, bWhse, bComment)
{
  var selbatch = document.all.Batch;
  var nxtEnt = selbatch.length;
  selbatch.options[nxtEnt] = new Option(batch + " - " + bComment, batch);
  selbatch.selectedIndex = selbatch.length - 1;
  BWhse[BWhse.length] = bWhse;
  if (selbatch.selectedIndex > 0) {Validate(); }
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
// open Batch Item List in new Window
//==============================================================================
function openBatchItmWdw()
{
  var batch = document.all.Batch.options[document.all.Batch.selectedIndex].value.trim();
  var comment = document.all.Batch.options[document.all.Batch.selectedIndex].text.trim();
  var bwhse = BWhse[document.all.Batch.selectedIndex-1];

  var url = 'ItemTrfBachItemList.jsp?Batch=' + batch + "&BWhse=" + bwhse + "&BComment=" + comment;
  var WindowName = 'Batch_Item_List';
  var WindowOptions =
     'width=600,height=400, toolbar=yes, location=yes, directories=yes, status=yes, scrollbars=yes,resizable=yes, menubar=yes';

  //alert(url)
  window.open(url, WindowName, WindowOptions);
}
//==============================================================================
// show Batch Button
//==============================================================================
function showBatchButton(sel)
{
   if(sel.selectedIndex > 0)
   {
      document.all.btnOpenWdw.style.visibility='visible'
      document.all.btnDltBatch.style.visibility='visible'
   }
   else
   {
      document.all.btnOpenWdw.style.visibility='hidden'
      document.all.btnDltBatch.style.visibility='hidden'
   }
}
//==============================================================================
// delete Batch number and Items belong to batch
//==============================================================================
function dltBatch()
{
   if(BCrtByUser[document.all.Batch.selectedIndex - 1] == "<%=sUser%>"
      || "<%=sUser%>" == "vrozen" || "<%=sUser%>" == "phelfert")
   {

      var batch = document.all.Batch.options[document.all.Batch.selectedIndex].value.trim();
      var comment = document.all.Batch.options[document.all.Batch.selectedIndex].text.trim();

      var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
        + "<tr>"
          + "<td class='BoxName' nowrap>Batch:" + comment + "</td>"
          + "<td class='BoxClose' valign=top>"
             +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
          + "</td></tr>"
        + "<tr><td class='Prompt' colspan=2>" + popBatch(batch) + "</td></tr></table>"

      document.all.dvItem.innerHTML = html;
      document.all.dvItem.style.left=200;
      document.all.dvItem.style.top = getTopScreenPos() + 100;
      document.all.dvItem.style.visibility = "visible";
   }
   else { alert("This batch is not created by you.\nYou may to delete only your own batch.") }
}
//==============================================================================
// populate batch deletion panel
//==============================================================================
function popBatch(batch)
{
  var panel = "<table border=0 style='font-size:16px; font-weight:bold' width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr><td >Delete selected batch number and all items assign for this batch.</td></tr>"
         + "<tr><td style='color:red;'>Do you want to delete this batch?</td></tr>"

  panel += "<tr><td class='Prompt1' colspan='5'><br>"
        + "<button style='font-size:10px' onClick='sbmBatchDlt(&#34;" + batch + "&#34;);' >Delete</button> &nbsp; &nbsp;"
        + "<button style='font-size:10px' onClick='hidePanel();' >Close</button></td></tr>"

  panel += "</table>";

  return panel;
}
//==============================================================================
//==============================================================================
function sbmBatchDlt(batch)
{
  var url = 'ItemTrfEnt.jsp?'
    + "Batch=" + batch
    + "&ACTION=DLTBATCH";

    if(confirm("This is a last chance. Are You Sure?????"))
   {
       document.all.btnOpenWdw.style.visibility='hidden';
       document.all.btnDltBatch.style.visibility='hidden';

       //alert(url);
       //window.location.href = url;
       if(isIE || isSafari){ window.frame2.location.href = url; }
       else if(isChrome || isEdge) { window.frame2.src = url; }
       
       rtvBatchNumber();
   }

   hidePanel();
}

//--------------------------------------------------------
// Hide selection screen
//--------------------------------------------------------
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}
</script>


<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript" src="Get_Object_Position.js"></script>



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
  <TR>
    <TD height="20%"><IMG
    src="Sun_ski_logo1.jpg"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Transfer Request - Selection</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>

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
        <!-- ======================== Batch ================================ -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TD class="Cell" nowrap>Batch Number: </TD>
            <TD class="Cell1" nowrap>
              <select class="Small"
                 onChange="showBatchButton(this)"
                 name="Batch"></select> &nbsp;
              <button class="Small" id="btnOpenWdw" onClick="openBatchItmWdw()">Batch Item List</button> &nbsp; &nbsp; &nbsp;
              <button class="Small" id="btnDltBatch" onClick="dltBatch()">Delete Batch</button>
         </td>
         <TD class="Cell1" id="tdComment" colspan=2>New Batch Comments:
              <input class="Small" name="BComment" size=50 maxlength=50>
              <br>Warehouse?&nbsp;<input type="checkbox" class="Small" name="BWhse" value="W">
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
        <TR><TD class="Cell2" colSpan=4>
               <INPUT type=submit value=Submit name="sbmList" id="sbmList" onClick="Validate()">  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
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