<%@ page import=" rciutility.ClassSelect"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=EComItmStsSel.jsp&APPL=ALL");
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

  var div = document.all.Div.value.trim();
  var dpt = document.all.Dpt.value.trim();
  var ven = "ALL";
  var cls = "ALL";
  var dtl = document.all.Dtl[0].value.trim();
  if (document.all.Dtl[1].checked) { dtl = document.all.Dtl[1].value.trim(); }

  /* var site = null;
  for(var i=0; i < document.all.Site.length; i++)
  {
    if (document.all.Site[i].checked) { site = document.all.Site[i].value.trim(); break;}
  } */

  var action;

  if (error) alert(msg);
  else{ sbmPlan(div, dpt, cls, ven, dtl) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(div, dpt, cls, ven, dtl )
{
  var url = null;
  url = "EComUnAttrSts.jsp?"

  url += "Div=" + div
      + "&Dpt=" + dpt
      + "&Cls=" + cls
      + "&Ven=" + ven
      + "&Dtl=" + dtl

  //alert(url)
  window.location.href=url;
}
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>

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
    src="Sun_ski_logo1.jpg"></TD></TR>
  <TR bgColor=moccasin>
    <TD vAlign=top width="15%" bgColor=#a7b5e8><FONT face=Arial color=#445193
      size=2>&nbsp;&nbsp;<A class=blue
      href="/">Home</A></FONT><FONT
      face=Arial color=#445193 size=1>
      <H5>&nbsp;&nbsp;Miscellaneous</H5>&nbsp;&nbsp;<A class=blue
      href="mailto:">Send e-mail</A> <BR>&nbsp;&nbsp;<A
      class=blue href="http://sunandski.com/">Our Internet</A> <BR></FONT></TD>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>Status Of Items In Store 70 - Selection</B>

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
         <!-- =============================================================== -->

        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
            <TD class="Cell1" colSpan=4>
               <INPUT type="radio" name="Dtl" value="P" checked>Class-Vendor-Style<br>
               <INPUT type="radio" name="Dtl" value="I">Items
           </TD>
          </TR>
       <!-- =============================================================== -->
        <!-- TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <tr>
            <TD class="Cell1" colspan=5>Site:&nbsp;
              <input class="Small" name="Site" type="radio" value="SASS" checked>Sun and Ski Sports &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <input class="Small" name="Site" type="radio" value="SKCH">Ski Chalet &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <input class="Small" name="Site" type="radio" value="SSTP">Ski Stop &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <input class="Small" name="Site" type="radio" value="REBEL">Rebel &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <input class="Small" name="Site" type="radio" value="RACK">Total Car Rack &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

              </select>
            </td>
        </tr -->

        <!-- =============================================================== -->

        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
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