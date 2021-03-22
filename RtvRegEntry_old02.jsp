<%@ page import="rciutility.StoreSelect, rtvregister.RtvReasonCode, rtvregister.RtvRegEntry"%>
<%
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("RTVREG") == null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=RtvRegEntry.jsp&APPL=ALL");
   }
   else
   {
      StoreSelect StrSelect = null;
      String sStr = null;  
      String sStrName = null;

      StrSelect = new StoreSelect(2);
      sStr = StrSelect.getStrNum();
      sStrName = StrSelect.getStrName();

      RtvReasonCode reasCode = new RtvReasonCode();
      String sReason = reasCode.getReasonCode();
      String sReasonDesc = reasCode.getReasonDesc();

      RtvRegEntry rtvreg = new RtvRegEntry(session.getAttribute("USER").toString());
      int iNumOfItm = rtvreg.getNumOfItm();
      String [] sStrLst = rtvreg.getStr();
      String [] sCls = rtvreg.getCls();
      String [] sVen = rtvreg.getVen();
      String [] sSty = rtvreg.getSty();
      String [] sClr = rtvreg.getClr();
      String [] sSiz = rtvreg.getSiz();
      String [] sSeq = rtvreg.getSeq();
      String [] sReasonName = rtvreg.getReason();
      String [] sSku = rtvreg.getSku();
      String [] sUpc = rtvreg.getUpc();
      String [] sDesc = rtvreg.getDesc();
      String [] sClrName = rtvreg.getClrName();
      String [] sSizName = rtvreg.getSizName();
      String [] sVenName = rtvreg.getVenName();
      String [] sVenSty = rtvreg.getVenSty();
      String [] sDocNum = rtvreg.getDocNum();
      String [] sComment = rtvreg.getComment();
      String [] sDefect = rtvreg.getDefect();

      rtvreg.disconnect();
%>

<style>body {background:ivory;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px }
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding-top:3px; padding-bottom:3px;
                       text-align:center; font-family:Verdanda; font-size:12px; text-decoration: underline;}

        tr.DataTable { background: #E7E7E7; font-family:Arial; font-size:10px }
        tr.DataTable1 { background: MistyRose; font-family:Arial; font-size:10px }
        td.DataTable { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space: nowrap;}
        td.DataTable1{ padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:right; white-space: nowrap;}
        td.DataTable2 { cursor:hand; color: blue; padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:left; white-space: nowrap; text-decoration: underline;}
        span.spInpFld {color:green; text-decoration: underline; font-weight:bolder }
   
        td.DataTable3 { padding-top:3px; padding-bottom:3px; padding-left:3px;
                       padding-right:3px; text-align:center; white-space: nowrap;}
        
        div.dvVendor { position:absolute; visibility:hidden; border: gray solid 1px;
                 width:300; height:250;background-color:white; z-index:10; text-align:left; font-size:10px}


  		div.dvInternal{ clear: both; overflow: AUTO; width: 300px; height: 220px; POSITION: relative; text-align:left;}
  		div.dvInternal thead td, tfoot td { background-color: #1B82E6; Z-INDEX: 60; position:relative; }
  		div.dvInternal table{ border:0px; cellspacing:1px; cellpading:1px; TEXT-ALIGN: left; }
        div.dvItem { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
        .Small {font-size:10px; text-align: center;}  
        
        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }     
        
</style>

<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<script name="javascript">

var User = "<%=session.getAttribute("USER").toString()%>";
var Reason = [<%=sReason%>];
var ReasonDesc = [<%=sReasonDesc%>];
var NewRow = <%=iNumOfItm%>;
var AddUpd = 0;
var SaveSeq = 0;
var SelRow = null; 

var Vendor = null;
var VenName = null;
var LastTr = -1;
var LastVen = "";
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
   reset();
   popStrSelect();
   popReasCode();
   document.all.trComment.style.display = "none";
   
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
// Load Stores
//==============================================================================
function popStrSelect()
{
    var stores = [<%=sStr%>];
    var storeNames = [<%=sStrName%>];
    for (idx = 1; idx < stores.length; idx++)
    {
      document.all.Store.options[idx-1] = new Option(stores[idx] + " - " + storeNames[idx],stores[idx]);
    }
}
//==============================================================================
// populate Reason code/desc
//==============================================================================
function popReasCode()
{
    document.all.Reason.options[0] = new Option("None", "NONE");
    for (var i = 0; i < Reason.length; i++)
    {
      document.all.Reason.options[i+1] = new Option(ReasonDesc[i], Reason[i]);
    }
}
//==============================================================================
// display comment for other reason code
//==============================================================================
function chgSelReason(reas)
{
   if(reas.value == "P")
   {
     document.all.trComment.style.display="block";
     document.all.Comment.focus();
   }
   else
   {
     document.all.trComment.style.display="none";
   }
}
//==============================================================================
// Validate form
//==============================================================================
function Validate(skuOrDoc)
{
  var error = false;
  var msg = " ";
  var stridx = document.all.Store.selectedIndex;
  var str = document.all.Store.options[stridx].value;
  var strnm = document.all.Store.options[stridx].text;
  var search;
  var rcidx = document.all.Reason.selectedIndex;
  var reason = (document.all.Reason.options[rcidx].value).trim();
  var comment = (document.all.Comment.value).trim();
  var defect = " ";
  if (document.all.Defect.checked) defect = document.all.Defect.value;

  if(skuOrDoc) { search = (document.all.Search.value).trim(); }
  else { search = (document.all.DocNum.value).trim(); }

  // search by sku

  if(search=="")
  {
     if(skuOrDoc) { msg = "The search is empty. Please, enter valid SKU or UPC number.\n" }
     else { msg = "The search is empty. Please, enter valid Distribution Document number.\n" }
     error = true;
  }
  else if(isNaN(search))
  {
     msg = "The search is invalid. The value must be numeric.\n"
     error = true;
  }

  if (error) alert(msg);
  else
  {
    saveRtventry(str, strnm, search, reason, comment, defect, skuOrDoc);
  }
}
//-------------------------------------------------------------
// Prompt for Media populate media list
//-------------------------------------------------------------
function saveRtventry(str, strnm, search, reason, comment, defect, skuOrDoc)
{
   var url = 'RtvRegSave.jsp?'
    + "Store=" + str
    + "&StrName=" + strnm
    + "&Search=" + search
    + "&Reason=" + reason
    + "&Comment=" + comment
    + "&Defect=" + defect
    + "&User=" + User

    if(skuOrDoc && AddUpd==0) { url += "&Action=ADD&Seq=0" }
    else if(skuOrDoc && AddUpd==1) { url += "&Action=UPD&Seq=" + SaveSeq}
    else if(skuOrDoc && AddUpd==2) { url += "&Action=DLT&Seq=" + SaveSeq}
    else { url += "&Action=POST&Seq=0" }

   //alert(url);
   //window.location.href = url;
   window.frame1.location = url;
   reset()
}

//---------------------------------------------------------
// display found errors
//---------------------------------------------------------
function displayError(NumOfErr, Error)
{
  var msg = "";
  for(var i = 0; i < NumOfErr; i++)
  {
    msg += Error[i] + "\n";
  }

  alert(msg);
  window.frame1.close();
}
//---------------------------------------------------------
// populate Table with entry made to rtvreg file
//---------------------------------------------------------
function popTable(Str, Cls, Ven, Sty, Clr, Siz, Seq, Reason, Sku, Upc, Desc, ClrName,
                       SizName, VenName, VenSty, DocNum, RaNum, Markout, Recall, Comment, Defect, Action)
{
   window.frame1.close();
   document.all.tbRtvEnt.style.visibility="visible"

   if(Action == 'ADD' || Action == 'POST' )
   {
      for(var i=0; i < Cls.length; i++)
      {
         addLine("tbRtvEnt", Str[i], Cls[i], Ven[i], Sty[i], Clr[i], Siz[i], Seq[i], Reason[i], Comment[i],
            Defect[i], Sku[i], Upc[i], Desc[i], ClrName[i], SizName[i], VenName[i], VenSty[i], DocNum[i])
      }

    }
    else if(Action == 'UPD')
    {
       updLine(Str[0], Cls[0], Ven[0], Sty[0], Clr[0], Siz[0], Seq[0], Reason[0], Comment[0],
            Defect[0], Sku[0], Upc[0], Desc[0], ClrName[0], SizName[0], VenName[0], VenSty[0],
           DocNum[0])
    }
    else if(Action == 'DLT')
    {
       dltLine(Str[0], Cls[0], Ven[0], Sty[0], Clr[0], Siz[0], Seq[0], Reason[0], Comment[0],
           Defect[0], Sku[0], Upc[0], Desc[0], ClrName[0], SizName[0], VenName[0], VenSty[0],
           DocNum[0])
    }
}

//------------------------------------------------------------------------
// add entry line in table
//------------------------------------------------------------------------
function addLine(id, Str, Cls, Ven, Sty, Clr, Siz, Seq, Reason, Comment, Defect,
                 Sku, Upc, Desc, ClrName, SizName, VenName, VenSty, DocNum)
{
   var tbody = document.getElementById(id).getElementsByTagName("TBODY")[0];
   var row = document.createElement("TR")
   if(Reason.trim() != "") row.className="DataTable";
   else row.className="DataTable1";
   row.id="trItm" + NewRow; //add ID

   var td = new Array();
   td[0] = addTDElem(Str, "tdStr" + NewRow, "DataTable") // store
   td[1] = addTDElem(Cls + "-" + Ven  + "-" + Sty + "-" + Clr + "-" + Siz, "tdItm" + NewRow, "DataTable") // long item number
   td[2] = addTDElem(Sku, "tdSku" + NewRow, "DataTable") // short SKU
   td[3] = addTDElem(Upc, "tdUpc" + NewRow, "DataTable") // UPC
   td[4] = addTDElem(Desc, "tdDesc" + NewRow, "DataTable") // Description

   td[5] = addTDElem(Reason, "tdReason" + NewRow, "DataTable2") // Reason
   td[5].onclick= function(){ rtvItem(Str, Sku, Seq, Reason, Comment, Defect, NewRow, 'UPD');};

   td[6] = addTDElem(Defect, "tdDefect" + NewRow, "DataTable") // defect item
   td[7] = addTDElem(Comment, "tdComment" + NewRow, "DataTable") // Comment
   td[8] = addTDElem(ClrName, "tdClrNm" + NewRow, "DataTable") // color name
   td[9] = addTDElem(SizName, "tdSizNm" + NewRow, "DataTable") // size name
   td[10] = addTDElem(VenName, "tdVenNm" + NewRow, "DataTable") // vendor name
   td[11] = addTDElem(VenSty, "tdVenSty" + NewRow, "DataTable") // vendor style

   td[12] = addTHElem("D", "tdDlt" + NewRow, "DataTable1") // Delete
   var rownum = eval(NewRow)
   td[12].onclick= function(){ rtvItem(Str, Sku, Seq, Reason, Comment, Defect, rownum, 'DLT');};
   // add cell to row
   for(var i=0; i < td.length; i++) { row.appendChild(td[i]); }

   // add row to table
   tbody.appendChild(row);

   NewRow = eval(NewRow) + 1;
}
//---------------------------------------------------------
// add new TD element
//---------------------------------------------------------
function addTDElem(value, id, classnm)
{
  var td = document.createElement("TD") // Reason
  td.appendChild (document.createTextNode(value))
  td.className=classnm;
  td.id = id;
  return td;
}
//---------------------------------------------------------
// add new TH element
//---------------------------------------------------------
function addTHElem(value, id, classnm)
{
  var td = document.createElement("TH") // Reason
  td.appendChild (document.createTextNode(value))
  td.className=classnm;
  td.id = id;
  return td;
}
//------------------------------------------------------------------------
// update rows in line
//------------------------------------------------------------------------
function updLine(Str, Cls, Ven, Sty, Clr, Siz, Seq, Reason, Comment, Defect,
                 Sku, Upc, Desc, ClrName, SizName, VenName, VenSty, DocNum)
{
   // update reason code
   var cell = "tdReason" + SelRow
   var row = "trItm" + SelRow
   if(Reason.trim()=="") document.all[cell].innerHTML = "None";
   else document.all[cell].innerHTML = Reason;
   if(Reason.trim() != "") { document.all[row].className="DataTable"; }
   else  {  document.all[row].className="DataTable1";  }
   document.all[cell].setAttribute("onclick", function(){ rtvItem(Str, Sku, Seq, Reason, Comment, Defect, SelRow, "UPD")});

   // update comment
   var cell = "tdComment" + SelRow
   var row = "trItm" + SelRow
   if(Comment.trim()=="") document.all[cell].innerHTML = "&nbsp;";
   else document.all[cell].innerHTML = Comment;

   // update defective flag
   var cell = "tdDefect" + SelRow
   var row = "trItm" + SelRow
   if(Defect.trim()=="") document.all[cell].innerHTML = "&nbsp;";
   else document.all[cell].innerHTML = Defect;
}

//------------------------------------------------------------------------
// delete rows
//------------------------------------------------------------------------
function dltLine(Str, Cls, Ven, Sty, Clr, Siz, Seq, Reason, Comment, Defect,
                 Sku, Upc, Desc, ClrName, SizName, VenName, VenSty, DocNum)
{
   var cell = "trItm" + SelRow
   document.all[cell].style.display="none";
}


//---------------------------------------------------------
// retreive Item for update or remove
//---------------------------------------------------------
function rtvItem(str, sku, seq, reason, comment, defect, row, action)
{
   var strLst = document.all.Store;

   for(var i=0; i < strLst.length; i++)
   {
      if(strLst.options[i].value == str ) { strLst.selectedIndex=i; }
   }
   document.all.Search.value=sku;

   var reasLst = document.all.Reason;
   if(reason.trim() == "") reasLst.selectedIndex=0;
   else
   {
      for(var i=0; i < reasLst.length; i++)
      {
         if((reasLst.options[i].text).trim() == reason.trim() )
         {
            reasLst.selectedIndex=i;
            if(reasLst.options[i].value=="P")
            {
               document.all.trComment.style.display="block";
               document.all.Comment.value=comment;
            }
            else
            {
               document.all.trComment.style.display="none";
               document.all.Comment.value="";
            }
         }

      }
   }

   if(defect=="Y") document.all.Defect.checked=true;

   if(action=="DLT")
   {
     document.all.Delete.style.display = "inline";
     document.all.Submit.style.display = "none";
   }
   else
   {
     document.all.Delete.style.display = "none";
     document.all.Submit.style.display = "inline";
   }

   document.all.Store.style.display = "none";
   document.all.Search.style.display = "none";
   document.all.spComment.style.display = "none";

   document.all.spStore.style.display = "inline";
   document.all.spStore.innerHTML = str;
   document.all.spSearch.style.display = "inline";
   document.all.spSearch.innerHTML = sku;

   document.all.trDocNum.style.display = "none";
   document.all.Post.style.display = "none";

   AddUpd = 1;
   if(action=="DLT") AddUpd = 2;
   SaveSeq = seq;
   SelRow = eval(row);
}
//---------------------------------------------------------
// reset entry fields
//---------------------------------------------------------
function reset()
{
   document.all.Store.selectedIndex=0;
   document.all.Search.value="";
   document.all.Reason.selectedIndex=0;
   document.all.DocNum.value="";

   document.all.Store.style.display = "inline";
   document.all.Search.style.display = "inline";
   document.all.spComment.style.display = "inline";

   document.all.spStore.style.display = "none";
   document.all.spSearch.style.display = "none";
   document.all.Comment.value="";
   document.all.trComment.style.display = "none";
   document.all.Defect.checked = false;

   document.all.Delete.style.display = "none";
   document.all.Submit.style.display = "inline";
   document.all.Post.style.display = "inline";
   document.all.trDocNum.style.display = "inline";
   AddUpd = 0;
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
// get sku for selected vendor
//==============================================================================
function getVenSku()
{
	var stridx = document.all.Store.selectedIndex;
	var str = document.all.Store.options[stridx].value;
	var ven = document.all.Ven.value;
	if(ven != "" && ven != "ALL")
	{
		document.all.dvVendor.style.visibility="hidden";
		
		var url = "RtvSkuVenLst.jsp?Str=" + str + "&Ven=" + ven;
		window.frame1.location.href = url;
	}
	else{ alert("Vendor is not selected."); }	
}
//==============================================================================
//get sku for selected vendor
//==============================================================================
function showVenSku(cls, ven, sty, clr, siz, desc, vst, sku, inv)
{
	var hdr = "Item List";
	    
	   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popItem(cls, ven, sty, clr, siz, desc, vst, sku, inv)
	     + "</td></tr>"
	   + "</table>"

	   document.all.dvItem.innerHTML = html;
	   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 140;
	   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 205;
	   document.all.dvItem.style.visibility = "visible";	      
}
//==============================================================================
// populate Entry Panel
//==============================================================================
function popItem( cls, ven, sty, clr, siz, desc, vst, sku, inv )
{
  	var panel =  "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
  	panel += "<tr class='DataTable1'>"
      + "<th class='DataTable' >&nbsp;</th>"
      + "<th class='DataTable' >Long Item Number</th>"
      + "<th class='DataTable' >Short SKU</th>"
      + "<th class='DataTable' >Description</th>"
      + "<th class='DataTable' >Vendor Style</th>"
      + "<th class='DataTable' >On-Hand</th>"
      + "<th class='DataTable' >Rtv Qty</th>"
      + "<th class='DataTable' >Reason</th>"
      + "<th class='DataTable' >Deffective</th>"
    + "</tr>"
    
    for(var i=0; i < sku.length; i++)
    {
    	panel += "<tr class='DataTable'>"
    	  + "<td class='DataTable' >" 
    	  	+ "<input name='SelSku" + i + "' value='"+ sku[i] +"' type='checkbox'"
    	  	+ " onclick='setReason(&#34;" + i + "&#34;)'>"
    	  + "</td>"
    	  + "<td class='DataTable' >" + cls[i] + "-" + ven[i] + "-" + sty[i]  + "-" + clr[i]  + "-" + siz[i] + "</td>"
    	  + "<td class='DataTable' >" + sku[i] + "</td>"
    	  + "<td class='DataTable' >" + desc[i] + "</td>"
    	  + "<td class='DataTable' >" + vst[i] + "</td>"
    	  + "<td class='DataTable' >" + inv[i] + "</td>"
    	  + "<td class='DataTable' ><input name='Qty" + i + "' value='1' size=5 maxlength=3"    	  
    	  ;
    	  
    	  if(inv[i]=="1"){ panel += " type='hidden'"; }
    	  
    	  panel += ">&nbsp;</td>"
    		+ "<td class='DataTable' ><input name='SelItmReas" + i + "' size=20 maxlength=20 readonly></td>"
    		+ "<td class='DataTable' ><input name='SelDeff" + i + "' size=1 maxlength=1 readonly></td>"
    	   + "</tr>";
    }
    
              
  	panel += "<tr class='DataTable'>" 
  	   + "<td class='DataTable3' colspan=7><br><br><button onClick='vldVenSku(&#34;" + sku.length + "&#34;)' class='Small'>Submit</button>&nbsp;"
  	panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
  	panel += "</table>";
  	   
 	panel += "</form>";
  	return panel;
}
//==============================================================================
// validate selected sku from Vendor SKU list
//==============================================================================
function vldVenSku(numofsku)
{
	var error=false;
	var msg="";
	var sku = new Array();
	var qty = new Array();
	
	for(var i=0; i < numofsku; i++)
	{
		var skuobjnm = "SelSku" + i; 
		var skuobj = document.all[skuobjnm];
		if( skuobj.checked )
		{
			sku[sku.length] = skuobj.value;
			
			var qtyobjnm = "Qty" + i; 
			var qtyobj = document.all[qtyobjnm];
			if(isNaN(qtyobj.value.trim()) || eval(qtyobj.value.trim()) <= 0){ qty[qty.length] = "1"; }
			else{qty[qty.length] = qtyobj.value.trim(); }
		}
		
	}
	
	if(error){alert(msg);}
	else{ alert(sku + "\nqty= " + qty); }
}
//==============================================================================
// set reason
//==============================================================================
function setReason(i)
{
	
}
//==============================================================================
//hide panel
//==============================================================================
function hidePanel()
{
	document.all.dvItem.innerHTML = "";
	document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
//get sku for selected vendor
//==============================================================================
function showReason()
{
	var hdr = "RTV Attribute";
	    
	   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel1();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popReason()
	     + "</td></tr>"
	   + "</table>"

	   document.all.dvReason.innerHTML = html;
	   document.all.dvReason.style.pixelLeft= document.documentElement.scrollLeft + 220;
	   document.all.dvReason.style.pixelTop= document.documentElement.scrollTop + 180;
	   document.all.dvReason.style.visibility = "visible";
	   
	   document.all.SelReas.options[0] = new Option("None", "NONE");
	   for (var i = 0; i < Reason.length; i++)
	   {
	     document.all.SelReas.options[i+1] = new Option(ReasonDesc[i], Reason[i]);
	   }
}
//==============================================================================
//populate Entry Panel
//==============================================================================
function popReason()
{
	var panel =  "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>"
	panel += "<tr class='DataTable2'>"
   		+ "<td class='DataTable' >Reason:</td>"
   		+ "<td class='DataTable' ><select name='SelReas'></select></td>"   		
 	 + "</tr>"
 	 + "<tr class='DataTable2'>"
		+ "<td class='DataTable' >Defective Item:</td>"
		+ "<td class='DataTable' ><input name='Defect' type='checkbox' value='Y'></td>"   		
	 + "</tr>"
	 ; 
            
	panel += "<tr class='DataTable'>" 
	   + "<td class='DataTable3' colspan=7><br><br><button onClick='setSelReas()' class='Small'>Set</button>&nbsp;"
	panel += " &nbsp;  &nbsp; &nbsp;<button onClick='hidePanel1();' class='Small'>Close</button></td></tr>"
	panel += "</table>";
	   
	panel += "</form>";
	return panel;
}
//==============================================================================
//hide panel
//==============================================================================
function hidePanel1()
{
	document.all.dvReason.innerHTML = "";
	document.all.dvReason.style.visibility = "hidden";
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>

<HTML><HEAD>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe id="frame1" src=""  height="0" width="0">
</iframe>
<!-------------------------------------------------------------------->
<div id="tooltip2" style="position:absolute;visibility:hidden;background-color:LemonChiffon; z-index:10"></div>
<div id="dvVendor" class="dvVendor"></div>
<div id="dvItem" class="dvItem"></div>
<div id="dvReason" class="dvItem"></div>
<!-------------------------------------------------------------------->

<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR bgColor=moccasin>
    <TD vAlign=top align=middle><B>Retail Concepts Inc.
        <BR>RTV DC Entry - Add new Item</B>

      <TABLE border=0>
        <TBODY>

        <!-- =============================================================== -->
        <TR>
          <TD align=right >Store:</TD>
          <TD align=left colspan="3" nowrap>
             <SELECT name="Store"></SELECT><span id="spStore" class="spInpFld"></span>
          </TD>
        </TR>

        <!-- =============================================================== -->
        <TR>
          <TD align=right >SKU / UPC:</TD>
          <TD align=left colspan="3" nowrap>
             <input name="Search" maxlength=12; size=12 onblur="showReason()">
             <span id="spSearch" class="spInpFld"></span>&nbsp;&nbsp;&nbsp;
             <span id="spComment" style="font-size:12px">Only 12 characters code will be accepted as UPC.</span>
          </TD>
        </TR>
        <TR>
          <TD align=right >Vendor:</TD>
          <TD class="Cell1" nowrap>
              <input name="VenName" size=50 value="All Vendors" readonly>
              <input name="Ven" type="hidden" value="ALL">
              <button class="Small" name=GetVen onClick="rtvVendors()">Select Vendors</button>&nbsp;&nbsp;
              <button class="Small" name=GetVenSku onClick="getVenSku()">Select Vendors Sku</button>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <!-- TR>
          <TD align=right >Reason:</TD>
          <TD align=left colspan="3" nowrap>
             <select name="Reason" onChange="chgSelReason(this)"></select>
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR id="trDefect">
          <TD align=right >Defective Item:</TD>
          <TD align=left colspan="3" nowrap>
               <input name="Defect" type="checkbox" value="Y">
          </TD>
        </TR -->
        <!-- =============================================================== -->
        <TR id="trComment">
          <TD align=right >Comment:</TD>
          <TD align=left colspan="3" nowrap>
               <input name="Comment" maxlength="50" size="50">
          </TD>
        </TR>
        <!-- =============================================================== -->
        <TR id="trDocNum">
          <TD align=right >Distributing Document:</TD>
          <TD align=left colspan="3">
             <input name="DocNum" maxlength=5 size=5> &nbsp;&nbsp;&nbsp;
          </TD>
        </TR>
        <TR>
          <TD align=center colspan="4" nowrap>
            <button id=Submit onClick="Validate(true)">Submit</button>&nbsp;
            <button id="Delete" onClick="Validate(true)">Delete</button>&nbsp;
            <button id="Post" onClick="Validate(false)">Add Doc</button>&nbsp;&nbsp;
            <button id="Reset" onClick="reset();">Reset</button></TD>
        </TR>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <!-- =============================================================== -->
        </TBODY>
       </TABLE>
       <p>
       <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page.</font>
       &nbsp;&nbsp;&nbsp;
       <a href="OnHands03.jsp" class="blue" target="_blank">Item Lookup</a>
       &nbsp;&nbsp;&nbsp;
       <a href="RtvRegListSel.jsp" class="blue" target="_blank">RTV - Review</a>

<!-- ======================================================================= -->
     <div style="border-style: inset; height: 500px; overflow: auto;">
       <table border=1 cellPadding="0" cellSpacing="0" id="tbRtvEnt">
         <tr  class="DataTable">
            <th class="DataTable" colspan="12">Current Entry</th>
         </tr>

         <tr  class="DataTable">
           <th class="DataTable" >From<br>Store</th>
           <th class="DataTable" >Class-Ven-Sty-Clr-Size</th>
           <th class="DataTable" >Short<br>Sku</th>
           <th class="DataTable" >UPC</th>
           <th class="DataTable" >Description</th>
           <th class="DataTable" >Reason</th>
           <th class="DataTable" >Defective<br>Item</th>
           <th class="DataTable" >Comment</th>
           <th class="DataTable" >Color<br>Name</th>
           <th class="DataTable" >Size<br>Name</th>
           <th class="DataTable" >Vendor<br>Name</th>
           <th class="DataTable" >Vendor<br>Style</th>
           <th class="DataTable" >D<br>l<br>t</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < iNumOfItm; i++ ){%>
          <tr id="trItm<%=i%>" class="DataTable<%if(sReasonName[i].trim().equals("")){%>1<%}%>">
            <td class="DataTable"id="tdStr<%=i%>"><%=sStrLst[i]%></td>
            <td class="DataTable" id="tdItm<%=i%>"><%=sCls[i] + "-" + sVen[i] + "-" + sSty[i] + "-" + sClr[i] + "-" + sSiz[i]%></td>
            <td class="DataTable"><%=sSku[i]%></td>
            <td class="DataTable"><%=sUpc[i]%></td>
            <td class="DataTable"><%=sDesc[i]%></td>
            <td class="DataTable2" id="tdReason<%=i%>"
                  onClick="rtvItem(<%=sStrLst[i]%>, '<%=sSku[i]%>', '<%=sSeq[i]%>', '<%=sReasonName[i]%>', '<%=sComment[i]%>', '<%=sDefect[i]%>', '<%=i%>', 'ADD');">
                <%if(sReasonName[i].trim().equals("")){%>None<%} else {%><%=sReasonName[i]%><%}%></td>
            <td class="DataTable" id="tdDefect<%=i%>" ><%=sDefect[i]%>&nbsp;</td>
            <td class="DataTable" id="tdComment<%=i%>" ><%=sComment[i]%>&nbsp;</td>
            <td class="DataTable" id="tdClrName<%=i%>"><%=sClrName[i]%></td>
            <td class="DataTable" id="tdSizName<%=i%>"><%=sSizName[i]%></td>
            <td class="DataTable" id="tdVenrName<%=i%>"><%=sVenName[i]%></td>
            <td class="DataTable" id="tdVenSty<%=i%>"><%=sVenSty[i]%></td>
            <th class="DataTable1" onClick="rtvItem(<%=sStrLst[i]%>, '<%=sSku[i]%>', '<%=sSeq[i]%>', '<%=sReasonName[i]%>', '<%=sComment[i]%>', '<%=sDefect[i]%>', '<%=i%>', 'DLT');">D</th>
          </tr>
       <%}%>
       </table>
     </div>
<!-- ======================================================================= -->

      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>