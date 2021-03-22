<%@ page import=" rciutility.ClassSelect, rciutility.StoreSelect,java.text.*, java.util.*
    , rciutility.RunSQLStmt, java.sql.ResultSet"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("ECOMMERCE")==null )
   {
     response.sendRedirect("SignOn1.jsp?TARGET=MozuParentLstSel.jsp&APPL=ALL");
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

      StoreSelect strlst = new StoreSelect(5);
      int iNumOfStr = strlst.getNumOfStr();
      String [] sStrLst = strlst.getStrLst();
      String [] sStrNameLst = strlst.getStrNameLst();
      
      String sStmt = "Select BXSITE, BXNAME, BXPROD"
		  + " from RCI.MOSNDBX"
		  + " order by BXSITE"		      
	   ;
   	  RunSQLStmt runsql = new RunSQLStmt();
   	  runsql.setPrepStmt(sStmt);
   	  ResultSet rs = runsql.runQuery();
   	  
   	  Vector<String> vSbId = new Vector();
   	  Vector<String> vSbName = new Vector();
   	  Vector<String> vSbProdTest = new Vector();
   	  while(runsql.readNextRecord())
   	  {
   		  vSbId.add(runsql.getData("BXSITE").trim());
   		  vSbName.add(runsql.getData("BXNAME").trim());
   		  vSbProdTest.add(runsql.getData("BXPROD").trim());
	  }
	  rs.close();
	  runsql.disconnect();
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

  tr.TblHdr { background:#FFCC99; padding-left:3px; padding-right:3px;
              text-align:center; vertical-align:middle; font-size:11px;
              position: relative; top: expression(this.offsetParent.scrollTop-3);}
  tr.TblRow { background:wite; padding-left:3px; padding-right:3px;
                       text-align:center; vertical-align:middle; font-size:11px }


  td.BoxName {cursor:move; background: #016aab; color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand; background: #016aab; color:white; text-align:right; font-family:Arial; font-size:12px; }
        td.Prompt { text-align:left; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt1 { text-align:center; vertical-align:top; font-family:Arial; font-size:10px; }
        td.Prompt2 { text-align:right; font-family:Arial; font-size:10px; }
        td.Prompt3 { text-align:left; vertical-align:midle; font-family:Arial; font-size:10px; }
  
  div.dvMozuSandBox { position:absolute; background-attachment: scroll;
              border:ridge; width:250; background-color:#cccfff; z-index:10;
              text-align:center; font-size:10px}
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

var SbId = new Array();
<%for(int i=0; i < vSbId.size(); i++){%>SbId[<%=i%>] = "<%=vSbId.get(i)%>";<%}%>
var SbName = new Array();
<%for(int i=0; i < vSbName.size(); i++){%>SbName[<%=i%>] = "<%=vSbName.get(i)%>";<%}%>
var SbProdTest = new Array();
<%for(int i=0; i < vSbProdTest.size(); i++){%>SbProdTest[<%=i%>] = "<%=vSbProdTest.get(i)%>";<%}%>

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
	else{setBoxclasses(["BoxName",  "BoxClose"], ["dvPoNum"]);}
  
  
  document.all.tdDate1.style.display="block"
  document.all.tdDate2.style.display="none"
  document.all.tdDate3.style.display="block"
  document.all.tdDate4.style.display="none"

  doDivSelect(null);
  
  showMozuSandBox();  
}

//==============================================================================
//link to PO info
//==============================================================================
function showMozuSandBox()
{
	var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
	  + "<tr class='DataTable1'>"
	     + "<td class='DataTable' nowrap>Sandbox:</td>"
	     + "<td class='DataTable' nowrap>&nbsp;"
	        + "<input name='SandBox' readOnly><br>"
	  + "</tr>"
	  + "<tr class='DataTable1'>"
		 + "<td class='DataTable' nowrap>&nbsp;</td>"
		 + "<td class='DataTable' nowrap>&nbsp;"
	        + "<select name='selSandBox' onchange='setSandBox(this)'> &nbsp; "	        
	     + "</td>"
	  + "</tr>"
	html += "</table>"

	document.all.dvMozuSandBox.style.left= 10;
	document.all.dvMozuSandBox.innerHTML = html;	
	
	// populate with sandbox
	document.all.selSandBox.options[0] = new Option("--- Select Sandbox ---","");
	for(var i=0, j=1; i < SbId.length; i++, j++)
	{
		document.all.selSandBox.options[j] = 
			new Option(SbId[i] + " - " + SbName[i], SbId[i]);
	}
	document.all.SandBox.value = SbId[0];
}
//==============================================================================
// set sandbox id
//==============================================================================
function setSandBox(sel)
{
	document.all.SandBox.value = sel.options[sel.selectedIndex].value;
}
//==============================================================================
// show date selection
//==============================================================================
function showWebDates(show)
{
   document.all.tdDate1.style.display="none"
   document.all.tdDate2.style.display="block"
   doSelDate("WEB")
}
//==============================================================================
// show date selection
//==============================================================================
function showIPDates(show)
{
   document.all.tdDate3.style.display="none"
   document.all.tdDate4.style.display="block"
   doSelDate("IP")
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
// show optional date selection button
//==============================================================================
function showAllIPDates()
{
   document.all.tdDate3.style.display="block"
   document.all.tdDate4.style.display="none"
   document.all.FromIPDate.value = "ALL"
   document.all.ToIPDate.value = "ALL"
}
//==============================================================================
// populate date with yesterdate
//==============================================================================
function doSelDate(type){
  var df = document.all;
  var date = new Date(new Date() - 86400000);
  if(type=="WEB")
  {
     df.FromDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
     df.ToDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  }
  else
  {
     df.FromIPDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
     df.ToIPDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
  }
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
   if(isIE || isSafari){ window.frame1.location.href = url; }
   else if(isChrome || isEdge) { window.frame1.src = url; }
}
//==============================================================================
// retreive vendors
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
// retreive POs
//==============================================================================
function rtvPoNum()
{
    var ven = document.all.Ven.value
    var div = document.all.Div.value.trim();

    var url = "RtvPoList.jsp"
    var sep = "?";
    if(ven.trim() != "" && ven.trim() != "ALL")
    {
       url += sep + "Ven=" + ven;
       sep = "&";
    }

    if(div.trim() != "" && div.trim() != "ALL")
    {
       url += sep + "Div=" + div;
       sep = "&";
    }

    if(isIE || isSafari){ window.frame1.location.href = url; }
    else if(isChrome || isEdge) { window.frame1.src = url; }
}
//==============================================================================
// popilate division selection
//==============================================================================
function showPoNum(PoNum, AntDlvDt, Ven, VenName, Div, Bsr70, InStock, TotRet)
{
   var hdr = "Select P.O. Number";

  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
     + "<tr>"
       + "<td class='BoxName' nowrap>" + hdr + "</td>"
       + "<td class='BoxClose' valign=top>"
         +  "<img src='CloseButton.bmp' onclick='javascript:hidePoNumPanel();' alt='Close'>"
       + "</td></tr>"
   html += "<tr><td class='Prompt' colspan=2>"

   html += popSelPoNum(PoNum, AntDlvDt, Ven, VenName, Div, Bsr70, InStock, TotRet)

   html += "</td></tr></table>"


   document.all.dvPoNum.innerHTML = html;
   var dvWidth = document.all.thHdr1.offsetWidth + document.all.thHdr2.offsetWidth
               + document.all.thHdr3.offsetWidth + document.all.thHdr4.offsetWidth
               + document.all.thHdr1.offsetWidth
   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvInt1.style.width = "550";}
   else 
   { 
	   document.all.dvInt1.style.width = "auto";	   
   }   
   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvPoNum.style.width = "550";}
   else 
   { 
	   document.all.dvPoNum.style.width = "auto";
	   document.all.dvPoNum.style.height = "250px";
   } 
   
   document.all.dvPoNum.style.left= getLeftScreenPos() + 100;
   document.all.dvPoNum.style.top= getTopScreenPos() + 100;
   document.all.dvPoNum.style.background = "LemonChiffon";
   document.all.dvPoNum.style.visibility = "visible";
}

//==============================================================================
// populate Seletion of P.O. Number
//==============================================================================
function popSelPoNum(PoNum, AntDlvDt, Ven, VenName, Div, Bsr70, InStock, TotRet)
{
   // filter input
   var panel = "<table cellPadding=0 cellSpacing=0 style='background:#e9e9e9; border:2px outset; width=100%; font-size:10px;'>"
       + "<tr>"
       + "<td>P.O.&nbsp;<td><input name='spoPoNum' class='Small' size=10 maxlength=10> &nbsp; "
       + "<td><button class='Small' onClick='searchPoNum()'>Find</button>"

       + "<tr><td colspan=3 style='border-bottom:#e9e9e9 ridge 2px;font-size:3px;'>&nbsp;</td>"
       + "<tr><td colspan=3 style='font-size:3px;'>&nbsp;</td>"

       + "<tr><td>Vendor&nbsp;<td><input name='spoVen' class='Small' size=5 maxlength=5>"
       + "<td rowspan=2><button class='Small' onClick='rtvPoNumWithFilter()'>Filter</button>"
       + "<tr><td>Div&nbsp;<td><input name='spoDiv' class='Small' size=5 maxlength=5>"
       + "</table>"

   panel += "<br><div id='dvInt1' style='height: 210px; overflow: visible; z-index:50;'>"
         + "<table border=1 cellPadding=0 cellSpacing=0 style='font-size:10px;'>"

   panel += "<thead><tr class='TblHdr' >"
         + "<th id='thHdr1'>P.O.<br>Num</th>"
         + "<th id='thHdr2'>Anticip<br>Delivery<br>Date</th>"
         + "<th id='thHdr3'>Vendor</th>"
         + "<th id='thHdr4'>Vendor Name</th>"
         + "<th id='thHdr5'>Div</th>"
         + "<th id='thHdr6'>BSR<br>70</th>"
         + "<th id='thHdr7'>In<br>Stock</th>"
         + "<th id='thHdr8'>Total<br>Retail</th>"
   panel += "</thead>"

   panel += "<tbody>"

   for(var i=0; i < PoNum.length; i++)
   {
     panel += "<tr class='TblRow' id='trPon'><td id='tdCol1' style='cursor:hand;' onclick='javascript: showPonSelect(&#34;" + PoNum[i] + "&#34;)'>" + PoNum[i] + "</td>"
        + "<td id='tdCol2'>&nbsp;&nbsp;" + AntDlvDt[i] + "&nbsp;&nbsp;</td>"
        + "<td id='tdCol3'>" + Ven[i] + "</td>"
        + "<td id='tdCol4' style='text-align:left' nowrap>" + VenName[i] + "</td>"
        + "<td id='tdCol5'>" + Div[i] + "</td>"
        + "<td id='tdCol6' style='text-align:right'>" + Bsr70[i] + "</td>"
        + "<td id='tdCol7' style='text-align:right'>" + InStock[i] + "</td>"
        + "<td id='tdCol8' style='text-align:right'>" + TotRet[i] + "</td>"
        + "</tr>"
   }

   panel += "</tbody></table></div>"
        + "<div align=center><button class='Small' onclick='hidePoNumPanel();'>Close</button></div>"

   return panel;
}
//==============================================================================
// search Po Number in list
//==============================================================================
function searchPoNum()
{
   var pon = document.all.spoPoNum.value.trim();
   var tdpon = document.all.tdCol1;
   var selind = 0;
   var fnd = false;

   for(var i=0; i < tdpon.length; i++)
   {
      if(tdpon[i].innerHTML.indexOf(pon) >= 0)  { selind = i;  tdpon[i].style.color="red"; fnd=true;}
      else { tdpon[i].style.color="black"; }
   }

   if(fnd)
   {
      var pos = document.all.tdCol1[selind].offsetTop;
      dvInt1.scrollTop=pos-70;
   }
}
//==============================================================================
// retreive  PO Number with filter
//==============================================================================
function rtvPoNumWithFilter()
{
    var ven = document.all.spoVen.value.trim()
    var div = document.all.spoDiv.value.trim();

    var url = "RtvPoList.jsp"
    var sep = "?";
    if(ven != "" && ven != "ALL")
    {
       url += sep + "Ven=" + ven;
       sep = "&";
    }

    if(div != "" && div != "ALL")
    {
       url += sep + "Div=" + div;
       sep = "&";
    }

    if(isIE || isSafari){ window.frame1.location.href = url; }
    else if(isChrome || isEdge) { window.frame1.src = url; }
}
//==============================================================================
// show PO Number selected
//==============================================================================
function showPonSelect(pon)
{
   document.all.PON.value = pon;
}
//==============================================================================
// hide panel
//==============================================================================
function hidePoNumPanel(){document.all.dvPoNum.style.visibility = "hidden";}

//==============================================================================
// Validate form
//==============================================================================
function Validate(dwnl)
{
  var error = false;
  var msg = "";

  var div = document.all.Div.value.trim();
  var dpt = document.all.Dpt.value.trim();
  var cls = document.all.Cls.value.trim();
  var ven = document.all.Ven.value.trim();
  var frdate = document.all.FromDate.value;
  var todate = document.all.ToDate.value;  
  var fripdate = document.all.FromIPDate.value;
  var toipdate = document.all.ToIPDate.value;
  var mark = 0;
  var site = document.all.SandBox.value.trim();
  
  if(site == ""){ msg += "Select the Sandbox\n"; error=true; }

  if(document.all.MarkDwn[0].checked) { mark = document.all.MarkDwn[0].value }
  else if(document.all.MarkDwn[1].checked) { mark = document.all.MarkDwn[1].value }

  var parent = document.all.Parent.value.trim();
  parent = setParent(parent);
  document.all.Parent.value = parent; 
  if(isNaN(parent)){ msg += "Parent must be numeric\n"; error=true; }
  else if(eval(parent) > 0 && parent.length < 11){ msg +=  " Parent must contains at least 11 digits.\n"; error=true; }

  var pon = document.all.PON.value.trim();
  if(isNaN(pon)){ msg += "P.O. number must be numeric\n"; error=true; }

  var modelyr = document.all.ModelYr.value.trim();
  if(isNaN(modelyr)){ msg += "Model year number must be numeric\n"; error=true; }

  var mapexpdt = document.all.MapExpDt.value.trim();

  if(eval(parent) > 0 && eval(pon) > 0 && pon != "" && parent != ""){ msg += "Select only Parent or P.O. number.\n"; error=true; }

  // items with available inventory
  var invavl = null;
  for(var i=0; i < document.all.InvAvl.length; i++)
  {
     if(document.all.InvAvl[i].checked) { invavl = document.all.InvAvl[i].value; }
  }
  var invstr = "ALL";
  if(invavl=="STR")
  {
     invstr = document.all.SelStr.options[document.all.SelStr.selectedIndex].value;
  }

  // new items marked for web
  var markedweb = null;
  for(var i=0; i < document.all.MarkedWeb.length; i++)
  {
     if(document.all.MarkedWeb[i].checked) { markedweb = document.all.MarkedWeb[i].value; }
  }

  var action;
  var excel = "N"
  if (document.all.Excel.checked) { excel = "Y"; }

  if (error) alert(msg);
  else{ sbmPlan(div, dpt, cls, ven, site, frdate, todate, mark, dwnl, excel,
        parent, pon, modelyr, mapexpdt, invavl, markedweb, fripdate, toipdate, invstr) }
  return error == false;
}
//==============================================================================
// set parent  - remove deshes 
//==============================================================================
function setParent(parent)
{
	var newpar = "";
	var apar = new Array();
	var j=0;
	
	var hasChar = false;
	for(var i=0; i < parent.length; i++)
	{
		if(parent.substring(i, i+1) < "0"  && parent.substring(i, i+1) > "9"){ hasChar = true; }		
	}
	
	if(!hasChar && parent.length == 13)
	{
		apar[0] = parent.substring(0, 4);
		apar[1] = parent.substring(4, 9);
		apar[2] = parent.substring(9);
		j=2;
	}	
	else 
	{
		for(var i=0; i < parent.length; i++)
		{
			if(parent.substring(i, i+1) >= "0"  && parent.substring(i, i+1) <= "9")
			{
				if(apar[j] == null){ apar[j] = ""; }			
				apar[j] += parent.substring(i, i+1);
			}		
			else if(parent.substring(i, i+1) != " ") 
			{ 
				j++; 
			}
		}
	}	
	
	if(j == 2) 
	{ 
		newpar += setLeadZero(apar[0], 4) + setLeadZero(apar[1], 6) + setLeadZero(apar[2], 7);
	}
	else
	{
		newpar = parent;
	}
	
	
	return newpar; 	
}
//==============================================================================
//Submit OTB Planning
//==============================================================================
function setLeadZero(part, req)
{
	var l = part.length;
	var newpart = "";
	var z = 0;
	if(l < req)	
	{ 
		z = req - l;
		for(var i=0; i < z; i++ )
		{
			newpart += "0"; 
		}
		newpart += part; 
	} 
	else if( l >= req ) { newpart = part; }
		
	return newpart;
}
//==============================================================================
// Submit OTB Planning
//==============================================================================
function sbmPlan(div, dpt, cls, ven, site, frdate, todate, mark, dwnl, excel,
                 parent, pon, modelyr, mapexpdt, invavl, markedweb, fripdate, toipdate, invstr)
{
  var url = null;
  url = "MozuParentLst.jsp?"

  url += "Div=" + div
      + "&Dpt=" + dpt
      + "&Cls=" + cls
      + "&Ven=" + ven

  url += "&From=" + frdate
       + "&To=" + todate
       + "&FromIP=" + fripdate
       + "&ToIP=" + toipdate

       + "&Site=" + site
  url += "&MarkDownl=" + mark
       + "&Excel=" + excel
       + "&Parent=" + parent
       + "&Pon=" + pon
       + "&ModelYr=" + modelyr
       + "&MapExpDt=" + mapexpdt
       + "&InvAvl=" + invavl
       + "&MarkedWeb=" + markedweb
       + "&InvStr=" + invstr

  //alert(url)
  window.location.href=url;
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
<div id="dvMozuSandBox" class="dvMozuSandBox"></div>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>   
    <TD vAlign=top align=middle>
        <B>Retail Concepts Inc.
        <BR>E-Commerce List - Selection</B>

        <br><A class=blue href="/">Home</A></FONT><FONT face=Arial color=#445193 size=1>

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

        <!-- ============== select latest changes ========================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" ></TD></TR>
        <TR><TD class="Cell2" colspan=5>Select dates when item was added or modified</TD></tr>

        <TR>
          <TD id="tdDate1" colspan=4 align=center style="padding-top: 10px;" >
             <button id="btnSelWebDt" onclick="showWebDates()">Optional Date Selection</button>
          </td>
          <TD id="tdDate2" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FromDate')">&#60;</button>
              <input class="Small" name="FromDate" type="text" value="ALL" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FromDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.FromDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToDate')">&#60;</button>
              <input class="Small" name="ToDate" type="text" value="ALL" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.ToDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelWebDt" onclick="showAllDates()">All Date</button>
          </TD>
        </TR>
        <!-- ============== select latest changes ========================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" ></TD></TR>
        <TR><TD class="Cell2" colspan=5>Select dates when item was created in IP</TD></tr>

        <TR>
          <TD id="tdDate3" colspan=4 align=center style="padding-top: 10px;" >
             <button id="btnSelIPDt" onclick="showIPDates()">Optional Date Selection</button>
          </td>
          <TD id="tdDate4" colspan=4 align=center style="padding-top: 10px;" >
             <b>From Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'FromIPDate')">&#60;</button>
              <input class="Small" name="FromIPDate" type="text" value="ALL" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'FromIPDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.FromIPDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>

              <%for(int i=0; i < 20; i++){%>&nbsp;<%}%>

              <b>To Date:</b>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'ToIPDate')">&#60;</button>
              <input class="Small" name="ToIPDate" type="text" value="ALL" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'ToIPDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 200, 400, document.all.ToIPDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a><br>
              <button id="btnSelIPDt" onclick="showAllIPDates()">All Date</button>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" ></TD></TR>
        <TR>
            <TD colspan="4">
              <table border=0 width="100%">
               <TR>
                 <TD class="Cell2">Marked to Download</TD>
                 <TD class="Cell2">Inventory Availability</td>
                 <TD class="Cell2">Marked for Web</td>
              </tr>
              <tr>
                <TD class="Cell1">
                   <input class="Small" name="MarkDwn" type="radio" value="2">Marked<br>
                   <input class="Small" name="MarkDwn" type="radio" value="1">Unmarked<br>
                   <input class="Small" name="MarkDwn" type="radio" value="0" checked>Both
                </td>
                <td class="Cell1">
                  <input class="Small" type="radio" name="InvAvl" value="NONE" checked> Don't check inventory<br>
                  <input class="Small" type="radio" name="InvAvl" value="AVAIL">Available<br>
                  <!-- input class="Small" type="radio" name="InvAvl" value="STR"> Select Inventory from selected store:
                  <br><select name="SelStr" class="Small">
                      <%for(int i=0; i < iNumOfStr; i++){%>
                        <option value="<%=sStrLst[i]%>"><%=sStrLst[i]%> - <%=sStrNameLst[i]%></option>
                      <%}%>
                    </select -->
                </td>
                <td class="Cell1">
                   &nbsp; &nbsp; &nbsp; <input class="Small" type="radio" name="MarkedWeb" value="3">Unattributed Web Items<br>
                   &nbsp; &nbsp; &nbsp; <input class="Small" type="radio" name="MarkedWeb" value="2">Attributed Web Items<br>
                   &nbsp; &nbsp; &nbsp; <input class="Small" type="radio" name="MarkedWeb" value="0">Non-Web Items<br>
                   &nbsp; &nbsp; &nbsp; <input class="Small" type="radio" name="MarkedWeb" value="9" checked>All Items
               </td>
             </tr>
            </table>
          </td>
        </tr>
        <!-- =============================================================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" ></TD></TR>
        <TR>
            <TD class="Cell2" colspan=5>Alternative Selection:</TD>
        </tr>
        <tr>
            <TD class="Cell1" colspan=3>Parent: &nbsp;<input class="Small" name="Parent" size=25 maxlength=22></TD>
            <TD class="Cell1" colspan=2>P.O. number: &nbsp;<input class="Small" name="PON" size=10 maxlength=10>
                &nbsp;<button class="Small" name=GetPONum onClick="rtvPoNum()">Select P.O.</button></TD>

        </tr>
        <tr>
            <TD class="Cell1" colspan=3>Model Year: &nbsp;<input class="Small" name="ModelYr" size=4 maxlength=4> &nbsp; &nbsp; - and / or - </TD>
            <TD class="Cell1" colspan=2>Map Expiration Date: &nbsp;<input class="Small" name="MapExpDt" size=10 maxlength=10></TD>
        </tr>
        <!-- =============================================================== -->
        <TR><TD style="background: darkred; font-size:1px;" colspan="4" ></TD></TR>
        <TR>
            <TD align=center colSpan=5>
               <INPUT type=submit value=Submit name=SUBMIT onClick="Validate(<%=bDwnLoad%>)">
               <input class="Small" name="Excel" type="checkbox" value="Y">as Excel
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