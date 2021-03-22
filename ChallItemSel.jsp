<%@ page import="classreports.ChallItemLst, rciutility.ClassSelect"%>
<%
   String sCode = request.getParameter("Code");
   String sName = request.getParameter("Name");
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=EComItmLstSel.jsp&APPL=ALL");
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

      //  get already selected and saved items
      ChallItemLst chiteml = new ChallItemLst(sCode, "vrozen");

      String sSvDiv = chiteml.getDiv();
      String sSvDivNm = chiteml.getDivNm();
      String sSvDpt = chiteml.getDpt();
      String sSvDptNm = chiteml.getDptNm();
      String sSvCls = chiteml.getCls();
      String sSvClsNm = chiteml.getClsNm();
      String sSvVen = chiteml.getVen();
      String sSvVenNm = chiteml.getVenNm();
%>

<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}

  div.dvVendor { display:none; border: gray solid 1px;
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

var SaveCls = new Array();

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  doDivSelect(null);
  popSelectedItems();
}
//==============================================================================
// show date selection
//==============================================================================
function showDates(show)
{
   document.all.tdDate1.style.display="none"
   document.all.tdDate2.style.display="block"

}
//==============================================================================
// show optional date selection button
//==============================================================================
function showAllDates()
{
   document.all.tdDate1.style.display="block"
   document.all.tdDate2.style.display="none"
   document.all.FromDate.value = "ALL"
   document.all.ToDate.value = "ALL"
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
   else { document.all.dvVendor.style.display = "block"; }
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
   var html = "<input name='FndVen' class='Small' size=4 maxlength=4>&nbsp;"
     + "<input name='FndVenName' class='Small1' size=25 maxlength=25>&nbsp;"
     + "<button onclick='findSelVen()' class='Small'>Find</button>&nbsp;"
     + "<button onclick='document.all.dvVendor.style.display=&#34;none&#34;' class='Small'>Close</button><br>"
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
   document.all.dvVendor.style.display = "block";
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
// Select items
//==============================================================================
function popSelectedItems()
{
   var div = [<%=sSvDiv%>];
   var divnm = [<%=sSvDivNm%>];
   var dpt = [<%=sSvDpt%>];
   var dptnm = [<%=sSvDptNm%>];
   var cls = [<%=sSvCls%>];
   var clsnm = [<%=sSvClsNm%>];
   var ven = [<%=sSvVen%>];
   var vennm = [<%=sSvVenNm%>];

   for(var i=0; i < div.length ;i++) { document.all.SavDiv.options[i] = new Option(divnm[i].showSpecChar(), div[i]); }
   for(var i=0; i < dpt.length ;i++) { document.all.SavDpt.options[i] = new Option(dptnm[i].showSpecChar(), dpt[i]); }
   for(var i=0; i < cls.length ;i++) { document.all.SavCls.options[i] = new Option(clsnm[i].showSpecChar(), cls[i]); }
   for(var i=0; i < ven.length ;i++) { document.all.SavVen.options[i] = new Option(vennm[i].showSpecChar(), ven[i]); }
}
//==============================================================================
// Select items
//==============================================================================
function SelectItem()
{
  var div = document.all.Div.value.trim();
  var divnm = document.all.DivName.value.trim();
  var dpt = document.all.Dpt.value.trim();
  var dptnm = document.all.DptName.value.trim();
  var cls = document.all.Cls.value.trim();
  var clsnm = document.all.ClsName.value.trim();
  var ven = document.all.Ven.value.trim();
  var vennm = document.all.VenName.value.trim();
  var i = 0;

  if(clsnm != "All Classes")
  {
     if(isGrpNew(document.all.SavCls, cls))
     {
        i = document.all.SavCls.length;
        document.all.SavCls.options[i] = new Option(clsnm, cls);
     }
  }
  else if(dptnm != "All Departments")
  {
     if(isGrpNew(document.all.SavDpt, dpt))
     {
        i = document.all.SavDpt.length;
        document.all.SavDpt.options[i] = new Option(dptnm, dpt);
     }
  }
  else if(divnm != "All Divisions")
  {
     if(isGrpNew(document.all.SavDiv, div))
     {
        i = document.all.SavDiv.length;
        document.all.SavDiv.options[i] = new Option(divnm, div);
     }
  }

  if(vennm != "All Vendors")
  {
     if(isGrpNew(document.all.SavVen, ven))
     {
        i = document.all.SavVen.length;
        document.all.SavVen.options[i] = new Option(vennm, ven);
     }
  }

}

//==============================================================================
// is division new - add to array
//==============================================================================
function isGrpNew(aObj, elem)
{
   var isnew = true;
   for(var i=0; i < aObj.length; i++)  {   if(aObj.options[i].value == elem) { isnew = false;  break;  }  }

   return isnew;
}
//==============================================================================
// Validate form
//==============================================================================
function Validate()
{
  var error = false;
  var msg = "";

  var divln = document.all.SavDiv.length;
  var dptln = document.all.SavDpt.length;
  var clsln = document.all.SavCls.length;
  var venln = document.all.SavVen.length;

  var div = document.all.SavDiv;
  var dpt = document.all.SavDpt;
  var cls = document.all.SavCls;
  var ven = document.all.SavVen;

  // no selections
  if (divln == 0 &&  dptln == 0 && clsln == 0 && venln == 0){ msg += "There is no selection to save."; error = true; }

  if (error) alert(msg);
  else
  {
     sbmItemGrp(div, dpt, cls, ven, "ADDITMGRP");
  }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmItemGrp(div, dpt ,cls, ven, action)
{
  html = "<div id='dvItmGrp' style='border:darkred solid 1px;display:block;'>xxxx</div>";
  top.frame1.document.write(html);

  html = "<form name='AddItmGrp' action='ChallItmSave.jsp'>"
       + "<input name='Code' value='<%=sCode%>'>"
       + "<select name='AddDiv' MULTIPLE></select>"
       + "<select name='AddDpt' MULTIPLE></select>"
       + "<select name='AddCls' MULTIPLE></select>"
       + "<select name='AddVen' MULTIPLE></select>"
       + "<input name='Action' value='ADDITMGRP'>"
       + "</form>"

   top.frame1.document.all.dvItmGrp.innerHTML = html;

   for(var i=0; i < div.length ;i++)
   {
       top.frame1.document.AddItmGrp.AddDiv.options[i] = new Option(div.options[i].value,div.options[i].value);
       top.frame1.document.AddItmGrp.AddDiv.options[i].selected=true;
   }
   for(var i=0; i < dpt.length ;i++)
   {
       top.frame1.document.AddItmGrp.AddDpt.options[i] = new Option(dpt.options[i].value,dpt.options[i].value);
       top.frame1.document.AddItmGrp.AddDpt.options[i].selected=true;
   }
   for(var i=0; i < cls.length ;i++)
   {
       top.frame1.document.AddItmGrp.AddCls.options[i] = new Option(cls.options[i].value,cls.options[i].value);
       top.frame1.document.AddItmGrp.AddCls.options[i].selected=true;
   }
   for(var i=0; i < ven.length ;i++)
   {
       top.frame1.document.AddItmGrp.AddVen.options[i] = new Option(ven.options[i].value,ven.options[i].value);
       top.frame1.document.AddItmGrp.AddVen.options[i].selected=true;
   }

   top.frame1.document.AddItmGrp.submit();
}
//==============================================================================
// clear all groups in selected item group
//==============================================================================
function clearAll(grp)
{
    for (var i = grp.length; i >= 0; i--)
    {
       grp.options[i] = null;
    }
}
//==============================================================================
// clear single group in selected item group
//==============================================================================
function clearSel(grp)
{
    if(grp.selectedIndex >= 0) {  grp.options[grp.selectedIndex] = null; }
}

function redisplay(){ window.location.reload(); }
</script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>


<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<!--div id="dvItmGrp" style="border:darkred solid 1px;display:block;"></div-->
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <br>Challenge - Item Groups Selection</B>
        <br><font color="red"><%=sName%></font>
    <br><p><a href="../"><font color="red"  size="-1">Home</font></a>&#62;
         <font size="-1">This page</font>

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
              <div id="dvVendor" class="dvVendor"></div>
            </TD>
        </TR>
        <!-- =============================================================== -->
        <TR>
            <TD align=center colSpan=5>
               <INPUT class=small type=submit value=Select name=Select onClick="SelectItem()">
           </TD>
          </TR>
        <!-- =============================================================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" ></TD></TR>
        <TR>
            <td colspan="4" align="center"><b><u>Selected Item Groups</u></b></td>
        </TR>
        <TR>
           <td colspan = 4 align=center>
             <table border=0>
               <tr>
                  <TD class="Cell" >Division<span style="color:red; font-size:60%; vertical-align: super;">*</span>:
                     <br><a href="javascript: clearSel(document.all.SavDiv)">Clear</a>
                     <br><br><a href="javascript: clearAll(document.all.SavDiv)">Clear All</a>
                  </td>
                    <TD class="Cell1" ><SELECT name="SavDiv" class="Small" size=5></TD>
                  <TD class="Cell" ><%for(int i=0; i < 10; i++){%>&nbsp;<%}%>Department<span style="color:red; font-size:60%;vertical-align: super;">*</span>:
                     <br><a href="javascript: clearSel(document.all.SavDpt)">Clear</a>
                     <br><br><a href="javascript: clearAll(document.all.SavDpt)">Clear All</a>
                  </td>
                    <TD class="Cell1" ><SELECT name="SavDpt" class="Small" size=5></TD>
                  <TD class="Cell" ><%for(int i=0; i < 10; i++){%>&nbsp;<%}%>Class:
                     <br><a href="javascript: clearSel(document.all.SavCls)">Clear</a>
                     <br><br><a href="javascript: clearAll(document.all.SavCls)">Clear All</a>
                  </td>
                    <TD class="Cell1"><SELECT name="SavCls" class="Small" size=5></TD>
                  <TD class="Cell" ><%for(int i=0; i < 10; i++){%>&nbsp;<%}%>Vendor:
                     <br><a href="javascript: clearSel(document.all.SavVen)">Clear</a>
                     <br><br><a href="javascript: clearAll(document.all.SavVen)">Clear All</a>
                  </td>
                    <TD class="Cell1" ><SELECT name="SavVen" class="Small" size=5></TD>
               </tr>
             </table>
           </TD>
        </TR>
        <TR>
            <td colspan="4"><span style="color:red; font-size:60%; vertical-align: super;">*</span><span style="font-size:12px">Includes all classes belong to the group</td>
        </TR>

        <!-- =============================================================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" ></TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <INPUT class=small type=submit value=Save name=Save onClick="Validate()">
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