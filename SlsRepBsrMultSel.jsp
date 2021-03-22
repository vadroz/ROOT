<%@ page import="rciutility.ClassSelect"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null )
   {
     response.sendRedirect("SignOn1.jsp?TARGET=SlsRepBsrAnalysisSel.jsp&APPL=ALL");
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

var divisions = [<%=sDiv%>];
var divisionNames = [<%=sDivName%>];
var depts = [<%=sDpt%>];
var deptNames = [<%=sDptName%>];
var dep_div = [<%=sDptGroup%>];

var SelDiv = new Array();
var SelDpt = new Array();
var SelCls = new Array();
var SelClsNm = new Array();
var SelVen = new Array();
var CurDpt = 0;
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  doDivSelect();
}

//==============================================================================
// populate class selection
//==============================================================================
function doClsSelect() {
    var df = document.all;
    var classes = [<%=sCls%>];
    var clsNames = [<%=sClsName%>];

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
function doDivSelect() {
    var df = document.all;

    var dvId = document.all.selDiv.selectedIndex;
    var allowed;

    if (dvId == 0)
    {
        //  populate the division list
        for (idx = 1; idx < divisions.length; idx++)
        {
           df.selDiv.options[idx-1] = new Option(divisionNames[idx],divisions[idx]);
        }
        id = 0
        df.selDiv.selectedIndex = dvId;
    }

    //  clear current depts
    for (idx = df.selDpt.length; idx >= 0; idx--)
    {
       df.selDpt.options[idx] = null;
    }
}

//==============================================================================
// get selected division
//==============================================================================
function getSelDiv()
{
   var df = document.all;
   var allowed;
   var arg = 0;

   //  clear current depts
   for (idx = df.selDpt.length; idx >= 0; idx--)
   {
      df.selDpt.options[idx] = null;
   }

   for(var i=0; i < df.selDiv.options.length; i++)
   {
       if(df.selDiv.options[i].selected) //check for multiple seletions
       {
          allowed = dep_div[i+1].split(":");
          for (var j=1; j < allowed.length; j++, idx++)
          {
             df.selDpt.options[arg] = new Option(deptNames[allowed[j]], depts[allowed[j]]);
             arg++;
          }
       }
   }
}

//==============================================================================
// show selected Department Selected
//==============================================================================
function showDptSelect(id)
{
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
// get selected department
//==============================================================================
function getSelDpt()
{
   var dpt = document.all.selDpt;
   SelDpt = new Array();
   SelCls = new Array();
   SelClsNm = new Array();
   CurDpt = 0;

   for(var i=0; i < dpt.options.length; i++)
   {
      if(dpt.options[i].selected){ SelDpt[SelDpt.length] = dpt.options[i].value; }
   }

   // class retreival process
   if(SelDpt.length > 0){ rtvClasses(CurDpt); }
   else { alert("No department selected."); }
}

//==============================================================================
// retreive classes
//==============================================================================
function rtvClasses(arg)
{
   var url = "RetreiveDivDptCls.jsp?"
           + "Division=ALL"
           + "&Department=" + SelDpt[arg];
   //alert(url);
   //window.location.href = url;
   window.frame1.location = url;
}
//==============================================================================
// show selected classes
//==============================================================================
function showClasses(cls, clsName)
{
    // save returned classes
    for(var i=1; i < cls.length; i++)
    {
       var j = SelCls.length;
       SelCls[j] = cls[i];
       SelClsNm[j] = clsName[i];
    }

    // retreive classes for next selected department
    CurDpt++;
    if(CurDpt < SelDpt.length){ rtvClasses(CurDpt); }
    else { popClasses(); }
}
//==============================================================================
// populate classes in drop down menu
//==============================================================================
function popClasses()
{
   // clear
   for(var i = document.all.selCls.length; i >= 0; i--) {document.all.selCls.options[i] = null;}

   //popilate
   for(var i=0; i < SelCls.length; i++)
   {
     document.all.selCls.options[i] = new Option(SelClsNm[i], SelCls[i]);
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


   document.all.dvVendor.innerHTML = html;
   var pos = objPosition(document.all.selVen)
   document.all.dvVendor.style.pixelLeft= pos[0];
   var pos = objPosition(document.all.GetVen)
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
   if(document.all.selVen.options[0].value == "ALL"){ document.all.selVen.options[0] = null; }
   var imax = document.all.selVen.length;

   // check if vendor is not selected yet
   var found = false;
   for(var i=0; i < imax; i++)
   {
      if(document.all.selVen.options[i].value == ven){ found = true; break;}
   }

   if(!found)
   {
      document.all.selVen.options[imax] = new Option(vennm, ven);
      imax++;
      if(imax <= 5){ document.all.selVen.size = imax; }

      // move down selection fields
      var pos = objPosition(document.all.GetVen)
      document.all.dvVendor.style.pixelTop= pos[1] + 25;
   }
}
//==============================================================================
// clear selected vendors
//==============================================================================
function clrSelVen()
{
    for(var i = document.all.selVen.length; i >= 0; i--) {document.all.selVen.options[i] = null;}
    document.all.selVen.options[0] = new Option("All Vendors", "ALL");
    document.all.selVen.size = 1
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

  var cls = new Array();
  var clsobj = document.all.selCls;
  var clsfnd = false;
  for(var i=0; i < clsobj.length; i++)
  {
     if(clsobj.options[i].selected)
     {
        cls[cls.length] = clsobj.options[i].value; clsfnd = true;
     }
  }
  if(!clsfnd){ error = true; msg +="Please, select at least 1 class." }

  var ven = new Array();
  var venobj = document.all.selVen;
  var venfnd = false;
  for(var i=0; i < venobj.length; i++)
  {
     ven[ven.length] = venobj.options[i].value; venfnd = true;
  }
  if(!venfnd){ error = true; msg +="Please, select at least 1 vendor." }

  var itemgrp = document.all.ItemGrp.value.trim();

  var comment = document.all.Comment.value.trim();
  if(comment == ""){ error = true; msg +="\nComments requered."}

  var year = document.all.Year[0].value.trim();
  if(document.all.Year[1].checked){ year = document.all.Year[1].value.trim(); }

  if (error) alert(msg);
  else{ sbmSlsRep(cls, ven, year, itemgrp,comment) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmSlsRep(cls, ven, year, itemgrp, comment)
{
  var url = null;
  url = "SlsRep05.jsp?"
      + "Comment=" + comment
      + "&Year=" + year
      + "&ItemGrp=" + itemgrp

  for(var i=0; i < cls.length; i++)
  {
     url +="&Cls=" + cls[i]
  }

  for(var i=0; i < ven.length; i++)
  {
     url +="&Ven=" + ven[i]
  }

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
  <TR>
    <TD height="20%"><IMG
    src="Sun_ski_logo4.png"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Sales Summary - Selection</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>&nbsp; &nbsp; &nbsp; &nbsp;
            <a href="SlsRepJobMon.jsp" target="_blank"><font color="blue" size="-1">Report Monitor</font></a>
      <TABLE border=0>
        <TBODY>
        <!-- ------------- Division  --------------------------------- -->
        <TR>
          <TD class="Cell" >Division:</TD>
          <TD class="Cell1" >
             <SELECT name="selDiv" class="Small" size=5 multiple="multiple">
                <OPTION value="ALL" selected>All Divisions</OPTION>
             </SELECT>
          </TD>
          <td>
             <button onclick="getSelDiv();" class="Small"> ==> </button>
          </td>
        <!-- ======================= Department ============================ -->
          <TD class="Cell">Department:</TD>
          <TD class="Cell1">
             <SELECT class="Small" name=selDpt size=5 multiple="multiple">
             </SELECT>
          </TD>

          <td>
             <button class="Small" value="Select Classes" name=SUBMIT onClick="getSelDpt()"> ==> </button>
          </td>
           <!-- ========================== Class ============================== -->
            <TD class="Cell" >Class:</TD>
            <TD class="Cell1">
              <SELECT name="selCls" class="Small" size=5 multiple="multiple"></SELECT>
            </TD>
        <tr><td colspan=10><br></td></tr>
        <!-- ========================== Vendor ============================== -->
        <TR>
            <TD class="Cell" >Vendor:</TD>
            <TD class="Cell1" nowrap colspan=9>
              <select class="Small" name="selVen">
                 <option value="ALL">All Vendors</option>
              </select>
              &nbsp;
              <button class="Small" name="GetVen" onClick="rtvVendors()">Select Vendors</button>
              &nbsp; &nbsp;
              <button class="Small" name=ClrVen onClick="clrSelVen()">Clear</button>
              <br>
            </TD>
        </TR>

        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="10" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colSpan=10>
               Sales History: &nbsp; &nbsp; &nbsp;
               <input  name="Year" value="1" type="radio" checked>1 Year &nbsp; &nbsp; &nbsp;
               2 Year: <input  name="Year" value="2" type="radio">
               <br>
        </tr>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="10" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell2" colSpan=10>
               Item Groups: &nbsp; &nbsp; &nbsp;
               <input class="Small" name="ItemGrp" maxlength=10 size=10> &nbsp; &nbsp; &nbsp;
        </tr>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="10" >&nbsp;</TD></TR>
        <TR>
        <TR>
            <TD></TD>
            <TD class="Cell2" colSpan=10>
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
   <br><br><br><br>
</BODY></HTML>
<%}%>