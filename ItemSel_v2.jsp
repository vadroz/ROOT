<%@ page import="rciutility.ClassSelect, rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*
, rciutility.CallAs400SrvPgmSup"%>
<%
   //----------------------------------   
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("TRANSFER") == null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=ItemSel_v2.jsp&APPL=TRANSFER");
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
      
      String sPrepStmt = "select ATTCCTI, ATTCCTD" 
    	+ " from iptsfil.ipattct"
    	+ " where attctpi=3 and substr(ATTCCTD,1,3) <> 'CP:'";       	
   	      	
   	  //System.out.println(sPrepStmt);
   	       	
   	  ResultSet rslset = null;
   	  RunSQLStmt runsql = new RunSQLStmt();
   	  runsql.setPrepStmt(sPrepStmt);		   
   	  runsql.runQuery();
   	    		   		   
   	  Vector<String> vAttr = new Vector<String>();
   	  Vector<String> vDesc = new Vector<String>();
   	  		   		   
   	  while(runsql.readNextRecord())
   	  {  		  
   		  vAttr.add(runsql.getData("ATTCCTI").trim());
   		  vDesc.add(runsql.getData("ATTCCTD").trim());   		   
   	  }  
   	     	  
   	  String [] sAttr = vAttr.toArray(new String[]{});
   	  String [] sDesc = vDesc.toArray(new String[]{});
   	  runsql.disconnect();
   	  
   	  CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
   	  String sAttrJsa = srvpgm.cvtToJavaScriptArray(sAttr);
   	  
%>
<html>
<head>
	<title>Item Transfer</title>
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

var Batch = null;
var BComment = null;
var BWhse = null;
var BCrtDate = null;
var BCrtByUser = null;
var NumOfAttr = "<%=sAttr.length%>";
var ArrAttr = [<%=sAttrJsa%>]
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  document.all.btnOpenWdw.style.visibility='hidden';
  document.all.btnDltBatch.style.visibility='hidden';
  sbmList.style.visibility = "hidden";

  doDivSelect(null);

  document.all.BComment.value = "";
  document.all.BWhse.checked = false;
  rtvBatchNumber();

  setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
  document.all.trWhsSel.style.display='none';
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
     if(ven != "" && ven != " " && ven == Vendor[i]) {  fnd = true; LastTr=i; break; }
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
   window.frame2.location = url;
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
  
  var whsqty = "0";
  var bsrlvl = "B";
  
  if(batch == "NEW")
  {
	  whsqty = document.all.WhsQtr.value.trim();
	  if(isNaN(whsqty)){ error=true; msg += "\nDC QTY is not numeric."; }	  
	  bsrlvl = document.all.SelBsr.options[document.all.SelBsr.selectedIndex].value;
  }
  
  var wgt0 = "A";
  if(document.all.inpWhsGt0[0].checked){ wgt0 = document.all.inpWhsGt0[0].value; }
  else if(document.all.inpWhsGt0[1].checked){ wgt0 = document.all.inpWhsGt0[1].value; }
  
  var bsrMin = "A"; 
  if(document.all.selBsrMin[0].checked){ bsrMin = "Y"; }
  else if(document.all.selBsrMin[1].checked){ bsrMin = "N"; }
  
  var bsrIdeal = "A"; 
  if(document.all.selBsrIdeal[0].checked){ bsrIdeal = "Y"; }
  else if(document.all.selBsrIdeal[1].checked){ bsrIdeal = "N"; }
  
  var bsrMax = "A"; 
  if(document.all.selBsrMax[0].checked){ bsrMax = "Y"; }
  else if(document.all.selBsrMax[1].checked){ bsrMax = "N"; }
   
  var frLastRcvDt = "NONE";
  var toLastRcvDt = "NONE";
  var frLastSlsDt = "NONE";
  var toLastSlsDt = "NONE";
  var frLastMdnDt = "NONE";
  var toLastMdnDt = "NONE";
  var permMdn = "B";
  var clearance = "B";
   
  if(batch == "NEW")
  {
	  frLastRcvDt = document.all.FrLastRcvDt.value.trim();
	  toLastRcvDt = document.all.ToLastRcvDt.value.trim();
	  frLastSlsDt = document.all.FrLastSlsDt.value.trim();
	  toLastSlsDt = document.all.ToLastSlsDt.value.trim();
	  frLastMdnDt = document.all.FrLastMdnDt.value.trim();
	  toLastMdnDt = document.all.ToLastMdnDt.value.trim();
	  
	  permMdn = document.all.SelMdn.options[document.all.SelMdn.selectedIndex].value;
	  clearance = document.all.SelClr.options[document.all.SelClr.selectedIndex].value;
	  
	  var attr = getAttr();
  }  
  

  if (error) alert(msg);
  else if(batch == "NEW" ){ genNewBatch(bcomm, bwhse, whsqty, bsrlvl
	, frLastRcvDt, toLastRcvDt, frLastSlsDt, toLastSlsDt, frLastMdnDt, toLastMdnDt
	, permMdn, attr, wgt0, bsrMin, bsrIdeal, bsrMax, clearance) }
  else 
  { 
	  sbmSlsRep(div, divnm, dpt, dptnm, cls, clsnm, ven, vennm, batch, bwhse, bcomm); 
  }
  return error == false;
}
//==============================================================================
// Submit list
//==============================================================================
function sbmSlsRep(div, divnm, dpt, dptnm, cls, clsnm, ven, vennm, batch, bwhse, bcomm)
{	
  var url = null;
  url = "ItemList_v2.jsp?"

  url += "Div=" + div
      + "&DivName=" + divnm
      + "&Dpt=" + dpt
      + "&DptName=" + dptnm
      + "&Cls=" + cls
      + "&ClsName=" + clsnm
      + "&Ven=" + ven
      + "&VenName=" + replaceChar(vennm)
      + "&Batch=" + batch
      + "&BWhse=" + bwhse
      + "&BComment=" + bcomm

  //alert(url)
  window.location.href=url;
}
//==============================================================================
//replace special character
//==============================================================================
function replaceChar(name)
{
	while( name.indexOf("&amp;") >= 0) { name = name.replace("&amp;", "XXXANDXXX" );	}
	while( name.indexOf("&") >= 0) { name = name.replace("&", "XXXANDXXX" );	}
	while( name.indexOf("'") >= 0) { name = name.replace("'", "XXXQUOTEXXX" );	}
	while( name.indexOf("`") >= 0) { name = name.replace("`", "XXXQUOTEXXX" );	}
	
	return name;
}
//==============================================================================
// get selected Attributes
//==============================================================================
function getAttr()
{ 
	var ArAttr = new Array();
	
	for(var i=0; i < NumOfAttr; i++)
	{
		var selfldnm = "selAttr" + i;
		var selfld = document.all[selfldnm];
		
		var attr = new Array();
		attr[0] = ArrAttr[i];		
		attr[1] = selfld.options[selfld.selectedIndex].value;
		ArAttr[i] = attr; 
	}
	return ArAttr;
}
//==============================================================================
// submit new batch creation process
//==============================================================================
function genNewBatch(bcomm, bwhse, whsqty, bsrlvl
	, frLastRcvDt, toLastRcvDt, frLastSlsDt, toLastSlsDt, frLastMdnDt, toLastMdnDt
	, permMdn, attr, wgt0, bsrMin, bsrIdeal, bsrMax, clearance)
{
  sbmList.style.visibility = "hidden";
  var url = "ItemTrfGenNewBatch.jsp?BWhse=" + bwhse + "&BComment=" + bcomm
	+ "&WhsQty=" + whsqty 
	+ "&BsrLvl=" + bsrlvl 
	+ "&FrLrd=" + frLastRcvDt
	+ "&ToLrd=" + toLastRcvDt
	+ "&FrLsd=" + frLastSlsDt 
	+ "&ToLsd=" + toLastSlsDt
	+ "&FrLmd=" + frLastMdnDt
	+ "&ToLmd=" + toLastMdnDt
	+ "&PermMdn=" + permMdn
	+ "&WGt0=" + wgt0
	+ "&BsrMin=" + bsrMin
	+ "&BsrIdeal=" + bsrIdeal
	+ "&BsrMax=" + bsrMax
	+ "&Clearance=" + clearance
	;
  
  for(var i=0; i < attr.length; i++)
  {
	  url += "&AttrN=" + attr[i][0];
	  url += "&AttrV=" + attr[i][1];
  }

  //alert(url)
  window.frame2.location.href=url;
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
      document.all.btnOpenWdw.style.visibility='visible';
      document.all.btnDltBatch.style.visibility='visible';
      document.all.tdComment.style.visibility='hidden';
      document.all.BWhse.style.visibility='hidden';
      var batch = sel.options[sel.selectedIndex].value;
      
      getBatchProp(batch);      
      
      document.all.BWhse.disabled = true;
  	  document.all.WhsQtr.disabled = true;
  	  document.all.NvrOut.disabled = true;
  	  document.all.SelMdn.disabled = true; 
  	  document.all.SelBsr.disabled = true; 
  	  document.all.NvrOut.disabled = true; 
  	  document.all.FrLastRcvDt.disabled = true;
  	  document.all.ToLastRcvDt.disabled = true;
  	  document.all.FrLastSlsDt.disabled = true;
  	  document.all.ToLastSlsDt.disabled = true;
  	  document.all.FrLastMdnDt.disabled = true;
  	  document.all.ToLastMdnDt.disabled = true;
   }
   else
   {
      document.all.btnOpenWdw.style.visibility='hidden'
      document.all.btnDltBatch.style.visibility='hidden'
      document.all.tdComment.style.visibility='visible';
      document.all.BWhse.style.visibility='visible';
      document.all.BWhse.checked = false;
      document.all.WhsQtr.value = "";
      document.all.NvrOut.disabled = false;
      document.all.NvrOut.checked = false;
      document.all.BWhse.disabled = false;
  	  document.all.WhsQtr.disabled = false;
  	  document.all.SelMdn.disabled = false; 
  	  document.all.SelBsr.disabled = false; 
  	  document.all.NvrOut.disabled = false; 
  	  document.all.FrLastRcvDt.disabled = false;
  	  document.all.ToLastRcvDt.disabled = false;
  	  document.all.FrLastSlsDt.disabled = false;
  	  document.all.ToLastSlsDt.disabled = false;
  	  document.all.FrLastMdnDt.disabled = false;
  	  document.all.ToLastMdnDt.disabled = false;
   }
}
//==============================================================================
// get batch properties
//==============================================================================
function getBatchProp(batch)
{
	var url ="ItemTrfBachProp.jsp?Batch=" + batch;
	window.frame1.location.href = url;
}
//==============================================================================
//set batch properties
//==============================================================================
function setBatchProp(batch, comm, whs, whsQty, bsrLvl, perm, never
		, frRcvDt, toRcvDt, frSlsDt, toSlsDt, frMkdwnDt, toMkdwnDt )
{
	// warehouse
	if(whs != "W")
	{ 
		document.all.BWhse.style.visibility='hidden'; 
		document.all.trWhsSel.style.display='none';
		document.all.WhsQtr.value = "";
	}
	else
	{ 
		document.all.BWhse.style.visibility='visible'; 
		document.all.BWhse.checked = true; 
		document.all.trWhsSel.style.display='inline';
		document.all.WhsQtr.value = whsQty;		
	}
	
	// permanent markdowns
	if(perm=="B"){ document.all.SelMdn.selectedIndex = 0; }
	else if(perm=="Y"){ document.all.SelMdn.selectedIndex = 1; }
	else if(perm=="N"){ document.all.SelMdn.selectedIndex = 2; }	
	
	// BSR Level
	if(bsrLvl=="B"){ document.all.SelBsr.selectedIndex = 0; }
	else if(bsrLvl=="Y"){ document.all.SelBsr.selectedIndex = 1; }
	else if(bsrLvl=="N"){ document.all.SelBsr.selectedIndex = 2; }	
	
	//Never Out
	if(never=="Y"){ document.all.NvrOut.checked = true; }
	else { document.all.NvrOut.checked = false; }
	
	// Last Received Date
	if(frRcvDt != ""){document.all.FrLastRcvDt.value = cvtDate(frRcvDt);}
	if(toRcvDt != ""){document.all.ToLastRcvDt.value = cvtDate(toRcvDt);}
	
	// Last Sale Date
	if(frSlsDt != ""){document.all.FrLastSlsDt.value = cvtDate(frSlsDt);}
	if(toSlsDt != ""){document.all.ToLastSlsDt.value = cvtDate(toSlsDt);}
		
	// Last Markdown Date
	if(frMkdwnDt != ""){document.all.FrLastMdnDt.value = cvtDate(frMkdwnDt);}
	if(toMkdwnDt != ""){document.all.ToLastMdnDt.value = cvtDate(toMkdwnDt);}	
}
//==============================================================================
//convert date
//==============================================================================
function cvtDate(fromdt)
{
	var cvtdt = fromdt.substring(5,7) + "/" + fromdt.substring(8) + "/" + fromdt.substring(0,4);
	return cvtdt
}
//==============================================================================
//show Warehouse new batch selection section
//==============================================================================
function showWhseSel(chk)
{
	if(chk.checked)
	{
		document.all.trWhsSel.style.display='inline';
	}
	else
	{
		document.all.trWhsSel.style.display='none';
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
      document.all.dvItem.style.pixelLeft=200;
      document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
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
       window.frame2.location = url;
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
//==============================================================================
// set correct Level DC OH
//==============================================================================
function setDcOh(type)
{
	var wgt0 = document.all.inpWhsGt0;
	
	if(type == "1")
	{
		if(document.all.WhsQtr.value != "")
		{
			wgt0[0].checked = false;
			wgt0[1].checked = false;
			wgt0[2].checked = true;
		}
	}
	else
	{		
		if(wgt0[0].checked || wgt0[1].checked)
		{
		   document.all.WhsQtr.value = "";	
		}		
	}
}
//==============================================================================
//set Attributes to default
//==============================================================================
function setAttr()
{
	for(var i=0; i < NumOfAttr; i++)
	{
		var selfld = "selAttr" + i;
		document.all[selfld].selectedIndex = 0;		
	}
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
        <BR>Transfer Request - Selection</B>
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
        <!-- ======================== Batch ================================ -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <tr>
        <TD class="Cell" nowrap>Batch Number: </TD>
            <TD class="Cell1" nowrap>
              <select class="Small"
                 onChange="showBatchButton(this)"
                 name="Batch"></select> &nbsp;
              <button class="Small" id="btnOpenWdw" onClick="openBatchItmWdw()">Batch Item List</button> &nbsp; &nbsp; &nbsp;
              <button class="Small" id="btnDltBatch" onClick="dltBatch()">Delete Batch</button>
         </td>
         <TD class="Cell1" id="tdComment" colspan=2>New Batch Name:
              <input class="Small" name="BComment" size=50 maxlength=50>              
          </TD>
        </TR>
        <tbody id="tbody1">
        <!-- ======================== Wharehouse Only ================================ -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <tr>
          <TD class="Cell2" colspan=4 nowrap>Transfer from DC (located stock)&nbsp;<input type="checkbox" onClick="showWhseSel(this)" class="Small" name="BWhse" value="W"></TD>   
        </tr>
        <tr id="trWhsSel">
        	<TD class="Cell1" nowrap colspan="4">With DC OH less than: 
        	   <input class="Small" name="WhsQtr" onblur="setDcOh('1')" size=7 maxlength=5> (leave blank for all)
        	    &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        	    &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        	    <b>- OR -</b>
        	    &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        	    &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        	    With DC OH > 0: &nbsp; &nbsp;  
        		<input class="Small" name="inpWhsGt0" type="radio" onclick="setDcOh('2')" value="Y">Yes &nbsp; &nbsp; &nbsp;
        		<input class="Small" name="inpWhsGt0" type="radio" onclick="setDcOh('2')" value="N">No &nbsp; &nbsp; &nbsp;
        		<input class="Small" name="inpWhsGt0" type="radio" onclick="setDcOh('2')" value="A" checked>Default &nbsp; &nbsp; &nbsp;
        		
        	  <br> <br>
        	  <u>DC - BSR Level Selection:</u> (Selections can be independent) &nbsp; &nbsp; &nbsp;
        	  <br> &nbsp; &nbsp; &nbsp; Minimum Level: 
        	     <input name="selBsrMin" type="radio" value="Y">Yes  &nbsp; &nbsp;
        	     <input name="selBsrMin" type="radio" value="N">No  &nbsp; &nbsp;
        	     <input name="selBsrMin" type="radio" value="A" checked>Default  &nbsp; &nbsp;
        	  <br> &nbsp; &nbsp; &nbsp; Ideal Level:  &nbsp; &nbsp; &nbsp;  &nbsp;
        	      <input name="selBsrIdeal" type="radio" value="Y">Yes &nbsp; &nbsp;
        	      <input name="selBsrIdeal" type="radio" value="N">No  &nbsp; &nbsp;
        	      <input name="selBsrIdeal" type="radio" value="A" checked>Default &nbsp; &nbsp;
        	  <br> &nbsp; &nbsp; &nbsp; Maximum Level: 
        	      <input name="selBsrMax" type="radio" value="Y">Yes &nbsp; &nbsp;
        	      <input name="selBsrMax" type="radio" value="N">No  &nbsp; &nbsp;
        	      <input name="selBsrMax" type="radio" value="A" checked>Default &nbsp; &nbsp;   
        	  <br><br>
        	      Y = A level is defined
			  <br>N = A level is Not defined
              <br>Default = Display items selection, regardless of whether BSR level exists, or not
        	  
        	           	    
        	</TD>
        </tr>
        <!-- ======================== All Item Only ================================ -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <tr id="trBatchSel">
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
        			
        			<TD class="Cell" nowrap>Basic Stock Item: </TD>
        			<TD class="Cell1" nowrap>
        			   	<select class="Small" name="SelBsr">
        		  			<option value="B">Both</option>
        		  			<option value="Y">Yes</option>
        		  			<option value="N">No</option>        		  
        				</select>Yes/No/Both
        			</TD>
        			
        			<TD class="Cell" nowrap>Clearance: </TD>
        			<TD class="Cell1" nowrap>
        			   	<select class="Small" name="SelClr">
        		  			<option value="B">Both</option>
        		  			<option value="Y">Yes</option>
        		  			<option value="N">No</option>        		  
        				</select>Yes/No/Both
        			</TD>        		
        		 
          		
        		<tr id="trBatchSel">
        			<TD class="Cell2" nowrap colspan="9">&nbsp;<br><u><b>Item Attribute Filter:</b></u>
        			 	&nbsp; <a class="Small" href="javascript: setAttr()">Reset</a>
        			</TD>
        		</TD>	
        		<tr id="trBatchSel">
        			<TD class="Cell2" nowrap colspan="9">        			
        				<table cellPadding="0" cellSpacing="0" border=1> 
        				  	<tr>
        				  		<th>Attribute</th>
        				  		<th>Name</th>
        				  		<th>Selection</th>
        				    </tr>
        					<%for(int i=0; i < sAttr.length; i++){
        						sPrepStmt = "select  ATTDCTI, ATTDDSI, ATTDDSD"
        						  + " from iptsfil.ipattds"
        						  + " where ATTDTPI=3 and ATTDDSI < 999 and ATTDCTI = " + sAttr[i]
        						  + " order by ATTDCTI, ATTDDSI"
        						;
        						runsql = new RunSQLStmt();
        					   	runsql.setPrepStmt(sPrepStmt);		   
        					   	runsql.runQuery();
        					%>
        						<tr id="trBatchSel">        		    
        							<TD class="Cell" nowrap><%=sAttr[i]%></TD>
        							<TD class="Cell1" nowrap><%=sDesc[i]%></TD>
        							<TD class="Cell1" nowrap>
        								<select name="selAttr<%=i%>">
        									<option value="999">Default</option>
        								<%while(runsql.readNextRecord())
        					   			 {
        									String sVal = runsql.getData("ATTDDSI");
        									String sText = runsql.getData("ATTDDSD");
        								%>
        									<option value="<%=sVal%>"><%=sText%></option>
        					   			<%}%> 
        								</select>
        							</TD>
                				</tr>
                			<%}%> 
                		</table>	
                	</td>	
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
        </tbody>
        <!-- =============================================================== -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
        <TR><TD class="Cell2" colSpan=4>
               <INPUT type=submit value=Submit name=sbmList onClick="Validate()">  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
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