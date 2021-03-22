<%@ page import=" rciutility.ClassSelect, rciutility.StoreSelect,  java.util.*"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null )
   {
     response.sendRedirect("SignOn1.jsp?TARGET=EComUncondExclSel.jsp&APPL=ALL");
   }
   else
   {
      ClassSelect divsel = null;
      divsel = new ClassSelect();
      String sDiv = divsel.getDivNum();
      String sDivName = divsel.getDivName();
      String sDpt = divsel.getDptNum();
      String sDptName = divsel.getDptName();
      String sDptGroup = divsel.getDptGroup();

      StoreSelect StrSelect = null;

      int iStrAlwLst = 0;
      String sStrAllowed = session.getAttribute("STORE").toString();
      if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
      {
        StrSelect = new StoreSelect(5);
      }
      else
      {
        Vector vStr = (Vector) session.getAttribute("STRLST");
        String [] sStrAlwLst = new String[ vStr.size()];
        Iterator iter = vStr.iterator();

        while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }
        if (vStr.size() > 1) { StrSelect = new StoreSelect(sStrAlwLst); }
        else StrSelect = new StoreSelect(new String[]{sStrAllowed});
      }

      int iNumOfStr = StrSelect.getNumOfStr();
      String [] sStrLst = StrSelect.getStrLst();
      String [] sStrNameLst = StrSelect.getStrNameLst();
      String sStrJsa = StrSelect.getStrNum();
      String sStrNmJsa = StrSelect.getStrName();
%>

<style>
  .Small {font-family: times; font-size:10px }
  .Small1 {font-family: times; font-size:10px; text-transform:uppercase; }

  td.Cell {font-size:12px; text-align:right; vertical-align:top}
  td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
  td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}
  td.Cell3 {font-size:12px; text-align:center; vertical-align:top}


  div.dvInternal{ clear: both; overflow: AUTO; width: 300px; height: 220px; POSITION: relative; text-align:left;}
  div.dvInternal thead td, tfoot td { background-color: #1B82E6; Z-INDEX: 60; position:relative; }
  div.dvInternal table{ border:0px; cellspacing:1px; cellpading:1px; TEXT-ALIGN: left; }

  div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}


  tr.TblHdr { background:#FFCC99; padding-left:3px; padding-right:3px;
              text-align:center; vertical-align:middle; font-size:11px;
              position: relative; top: expression(this.offsetParent.scrollTop-3);}
  tr.TblRow { background:wite; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:middle; font-size:11px }

  th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; vertical-align:top ;font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        th.DataTable2 { padding- top:3px; padding-bottom:3px; text-align:center; font-size:11px;}

        tr.DataTable { background: #E7E7E7; font-size:11px }
        tr.DataTable0 { background: red; font-size:11px }
        tr.DataTable1 { background: CornSilk; font-size:11px }

        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space:}
        td.DataTable1 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space:}
        td.DataTable2 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space:}

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
var StrArr = [<%=sStrJsa%>];
var StrNmArr = [<%=sStrNmJsa%>];

//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
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
        var start = 0;
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

    allowed = dep_div[id + 0].split(":");

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

  var str = "ALL";
  str = document.all.SelStr.options[document.all.SelStr.selectedIndex].value;

  var sts = new Array();
  var stschk = false;
  for(var i=0; i < document.all.Sts.length; i++)
  {
      if(document.all.Sts[i].checked){ sts[sts.length] = document.all.Sts[i].value; stschk = true }
  }
  if(!stschk){error = true; msg = "Please select at least 1 status."}

  if (error) alert(msg);
  else{ sbmPlan(div, dpt, cls, ven, str, sts) }
  return error == false;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(div, dpt, cls, ven, str, sts)
{
  var url = null;
  url = "EComUncondExcl.jsp?"

  url += "Div=" + div
      + "&Dpt=" + dpt
      + "&Cls=" + cls
      + "&Ven=" + ven
      + "&Str=" + str
  for(var i=0; i < sts.length; i++)
  {
     url += "&Sts=" + sts[i];
  }
  //alert(url)
  window.location.href=url;
}
//==============================================================================
// validate single sku
//==============================================================================
function validateSngSku()
{
   var error = false;
   var msg = "";

   var sku = document.all.SelSku.value.trim();
   if(sku==""){error=true; msg = "Please enter the sku"}
   else if(isNaN(sku)){error=true; msg = "Please enter the valid numeric value for SKU."}

   str = document.all.SelStr.options[document.all.SelStr.selectedIndex].value;

   if (error){ alert(msg); }
   else{ sbmSngSku(sku, str) }
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmSngSku(sku, str)
{
  var url = null;
  url = "EComUncondExcl.jsp?Sku=" + sku
      + "&Str=" + str;
  //alert(url)
  window.location.href=url;
}
//==============================================================================
// add/chg/delete item entry
//==============================================================================
function chgItem(sku, qty, reason, expdt, emp, action)
{
   var hdr = "";
   if(action == "ADD") { hdr = "Add SKU " + sku +  " as Defected Items"; }

   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
       + "</td></tr>"
    + "<tr><td class='Prompt' colspan=2>" + popUncondItem(action)
     + "</td></tr>"
   + "</table>"

   document.all.dvItem.innerHTML = html;
   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 140;
   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 95;
   document.all.dvItem.style.visibility = "visible";

   if(action == "ADD")
   {
      var date = new Date(new Date() - -7 * 86400000);
      document.all.ExpDt.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
      document.all.NoExpDt.checked = true;
      setExpDt(document.all.NoExpDt);
      document.all.Qty.value = 1;

      document.all.StrLst.options[0] = new Option("---- Select Store ----", 0)
      for(var i=1; i < StrArr.length; i++)
      {
         document.all.StrLst.options[i] = new Option(StrArr[i] + " - " + StrNmArr[i], StrArr[i])
      }

      document.all.ReasLst.options[0] = new Option("---- Select Reason ----", 0)
      document.all.ReasLst.options[1] = new Option("RTV","RTV")
      document.all.ReasLst.options[2] = new Option("Damaged / used","Damaged / used")
      document.all.ReasLst.options[3] = new Option("Cannot Locate","Cannot Locate")
      document.all.ReasLst.options[4] = new Option("Intransit","Intransit")
      document.all.ReasLst.options[5] = new Option("Other","Other")
   }
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popUncondItem(action)
{
  var panel = "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
  panel += "<tr class='DataTable1'>"
           + "<td class='DataTable2' >SKU:</td>"
           + "<td class='DataTable1'><input name='Sku' size=8 maxlength=12></td>"
       + "</tr>"
       + "<tr class='DataTable1'>"
           + "<td class='DataTable2' >Quantity:</td>"
           + "<td class='DataTable1'><input name='Qty' size=3 maxlength=3></td>"
       + "</tr>"
       + "<tr class='DataTable1'>"
           + "<td class='DataTable2' >Store:</td>"
           + "<td class='DataTable1'>"
              + "<input name='Str' size=3 maxlength=3 readonly> &nbsp; "
              + "<select class='Small' onchange='setSelStr(this)' name='StrLst'></select>"
           + "</td>"
       + "</tr>"
       + "<tr class='DataTable1'>"
           + "<td class='DataTable2' >Reason:</td>"
           + "<td class='DataTable1'><input name='Reason' size=30 maxlength=30 readonly> &nbsp;  &nbsp;  &nbsp; "
              + "<select class='Small' onchange='setReasStr(this)' name='ReasLst'></select>"
           + "</td>"
       + "</tr>"
       + "<tr class='DataTable1'>"
           + "<td class='DataTable2' >Description:</td>"
           + "<td class='DataTable1'><input name='Desc' size=50 maxlength=50>"
           + "</td>"
       + "</tr>"
       + "<tr class='DataTable1'>"
           + "<td class='DataTable2' >Expiration Date:</td>"
           + "<td class='DataTable1'>"
              + "<span id='spnExpDt'>"
              + "<button class='Small' name='Down' onClick='setDate(&#34;DOWN&#34;, &#34;ExpDt&#34;)'>&#60;</button>"
              + "<input name='ExpDt' class='Small' size='10' readonly>"
              + "<button class='Small' name='Down' onClick='setDate(&#34;UP&#34;, &#34;ExpDt&#34;)'>&#62;</button>"
              + "<a href='javascript:showCalendar(1, null, null, 680, 170, document.all.ExpDt)'>"
              + "<img src='calendar.gif' alt='Calendar Prompt' width='34' height='21'></a> &nbsp; "
              + "</span>"
              + "<input name='NoExpDt' type='checkbox' value='Y' onclick='setExpDt(this)'>No Expiration Date"
           + "</td>"
       + "<tr class='DataTable1'>"
           + "<td class='DataTable2' >Employee Number:</td>"
           + "<td class='DataTable1'><input name='Emp'  size=4 maxlength=4 ></td>"
       + "</tr>"
       + "<tr class='DataTable1'>"
           + "<td class='DataTable1' style='color:red; font-weight:bold;' colspan=2 id='tdError'></td>"
       + "</tr>"

  panel += "<tr class='DataTable1'>";
  panel += "<td class='DataTable' colspan=2><br><br><button onClick='ValidateItm(&#34;" + action + "&#34;)' class='Small'>Submit</button>&nbsp;"
  panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  panel += "</table>";
  return panel;
}
//==============================================================================
// set selected store
//==============================================================================
function  setSelStr(selstr)
{
  if(selstr.options[selstr.selectedIndex].value != "0")
  {
     document.all.Str.value = selstr.options[selstr.selectedIndex].value;
  }
  else{document.all.Str.value = ""; }

}
//==============================================================================
// set selected reason
//==============================================================================
function  setReasStr(selReas)
{
  if(selReas.options[selReas.selectedIndex].value != "0")
  {
     document.all.Reason.value = selReas.options[selReas.selectedIndex].value;
     if (selReas.options[selReas.selectedIndex].value == "Intransit")
     {
        var expdt = document.all["ExpDt"];
        var date = new Date(new Date() - -86400000 * 3);
        expdt.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
        document.all.NoExpDt.checked = false;
        setExpDt(document.all.NoExpDt);
     }
  }
  else{document.all.Reason.value = ""; }
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function  setExpDt(noexp)
{
   if(noexp.checked) { document.all.spnExpDt.style.display = "none"; }
   else{ document.all.spnExpDt.style.display = "inline"; }
}
//==============================================================================
// populate date with prior aor future dates
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
// validate entries
//==============================================================================
function ValidateItm(action)
{
   var error = false;
   var msg = "";
   document.all.tdError.innerHTML = msg;

   var sku = document.all.Sku.value.trim();
   if(sku == ""){ error=true; msg += "<br>Please enter the SKU number." }
   if(isNaN(sku)){ error=true; msg += "<br>The SKU value is not a numeric." }

   var qty = document.all.Qty.value.trim();
   if(qty == ""){ error=true; msg += "<br>Please enter the Quantity of defected items." }
   if(isNaN(qty)){ error=true; msg += "<br>The Quantity value is not a numeric." }

   var str = document.all.Str.value.trim();
   if(str == ""){ error=true; msg += "<br>Please enter the Store number." }

   var reas = document.all.Reason.value.trim();
   var rdesc = document.all.Desc.value.trim();
   if(reas == ""){ error=true; msg += "<br>Please enter the Reason for defecting items." }
   if(reas == "Other" && rdesc == ""){ error=true; msg += "<br>Please enter the Reason description." }

   var expdt = document.all.ExpDt.value.trim();
   if(document.all.NoExpDt.checked) { expdt = "None"; }

   var emp = document.all.Emp.value.trim();
   if(emp == ""){ error=true; msg += "<br>Please enter the Employee RCI number." }
   if(isNaN(emp)){ error=true; msg += "<br>The Employee value is not a numeric." }

   if (error){ document.all.tdError.innerHTML = msg; }
   else{ sbmUncondSku(sku, qty, reas, rdesc, expdt, emp, str, action) }
}
//==============================================================================
// save changes
//==============================================================================
function sbmUncondSku(sku, qty, reas, rdesc, expdt, emp, str, action)
{
    reas = reas.replace(/\n\r?/g, '<br />');
    rdesc = rdesc.replace(/\n\r?/g, '<br />');

    var nwelem = window.frame1.document.createElement("div");
    nwelem.id = "dvSbmUncondSku"

    var html = "<form name='frmAddComment'"
       + " METHOD=Post ACTION='EComUncondExclSave.jsp'>"
       + "<input class='Small' name='Str'>"
       + "<input class='Small' name='Sku'>"
       + "<input class='Small' name='Qty'>"
       + "<input class='Small' name='Reason'>"
       + "<input class='Small' name='RDesc'>"
       + "<input class='Small' name='ExpDt'>"
       + "<input class='Small' name='Emp'>"
       + "<input class='Small' name='Action'>"
     + "</form>"

   nwelem.innerHTML = html;
   frmcommt = document.all.frmEmail;
   window.frame1.document.appendChild(nwelem);

   window.frame1.document.all.Str.value=str;
   window.frame1.document.all.Sku.value=sku;
   window.frame1.document.all.Qty.value=qty;
   window.frame1.document.all.Reason.value=reas;
   window.frame1.document.all.RDesc.value=rdesc;
   window.frame1.document.all.ExpDt.value=expdt;
   window.frame1.document.all.Emp.value=emp;
   window.frame1.document.all.Action.value=action;

   //alert(html)
   window.frame1.document.frmAddComment.submit();
}
//==============================================================================
// hide panel
//==============================================================================
function hidePanel()
{
   document.all.dvItem.innerHTML = "";
   document.all.dvItem.style.visibility = "hidden";
}

//==============================================================================
// refresh screen
//==============================================================================
function refresh()
{
   window.location.reload();
}
//==============================================================================
// show errors
//==============================================================================
function showError(error)
{
   document.all.tdError.innerHTML = "";
   var br = "";
   for(var i=0; i < error.length;i++)
   {
       document.all.tdError.innerHTML += br + error[i];
       br = "<br>";
   }
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
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle>
        <B>Retail Concepts Inc.
        <BR>Items Excluded from Available to Sell - Selection</B>

        <br><A class=blue href="/">Home</A></FONT><FONT face=Arial color=#445193 size=1>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <a style="font-size:12px" href="javascript: chgItem(null, null, null, null, null, 'ADD')">Add Item</a>

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
        <TR>
            <TD class="Cell" colSpan=2>Store:</TD>
            <td class="Cell1" colSpan=3>
                <select name="SelStr" class="Small">
                      <%for(int i=0; i < iNumOfStr; i++){%>
                        <option value="<%=sStrLst[i]%>"><%=sStrLst[i]%> - <%=sStrNameLst[i]%></option>
                      <%}%>
                    </select>
                </td>
          </td>
        </tr>
        <!-- =============================================================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" ></TD></TR>
        <TR>
            <td class="Cell2" colSpan=5><b><u>Status</u></b></td>
        </tr>
        <TR>
            <td class="Cell3" colSpan=5>
                <input name="Sts" class="Small" type="checkbox" value="Active" checked> Active
                &nbsp; &nbsp;  &nbsp;
                <input name="Sts" class="Small" type="checkbox" value="Expired"> Expired

            </td>
          </td>
        </tr>
        <!-- =============================================================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" ></TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <button onClick="Validate()">Submit</button>
           </TD>
          </TR>
          <!-- =============================================================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" ></TD></TR>
        <TR>
            <TD  class="Cell3" align=center colSpan=5>Short SKU:
               <INPUT class="Small" name="SelSku" maxlength=10 size=12 onkeypress="if (window.event.keyCode == 13) { validateSngSku(); }">
               <button class="Small" onclick="validateSngSku()">Go</button>
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