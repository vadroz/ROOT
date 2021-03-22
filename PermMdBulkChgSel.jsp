<%@ page import="rciutility.ClassSelect, rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*
, rciutility.CallAs400SrvPgmSup"%>
<%
   //----------------------------------   
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null || session.getAttribute("TRANSFER") == null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=PermMdBulkChgSel.jsp&APPL=TRANSFER");
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
      
      String sStmt = "select ATTCCTI, ATTCCTD" 
    	+ " from iptsfil.ipattct"
    	+ " where attctpi=3 and substr(ATTCCTD,1,3) <> 'CP:'";       	
   	      	
   	  //System.out.println(sStmt);
   	       	
   	  ResultSet rslset = null;
   	  RunSQLStmt runsql = new RunSQLStmt();
   	  runsql.setPrepStmt(sStmt);		   
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
   	  
   	  sStmt = "select pecent" 
   	    	+ " from rci.MDPRCEND"
   	    	+ " where pegrp='CLEAR'";       	
   	   	      	
   	  runsql = new RunSQLStmt();
   	  runsql.setPrepStmt(sStmt);		   
   	  runsql.runQuery();
   	   	    		   		   
   	  Vector<String> vCent = new Vector<String>();
   	   	  		   		   
   	  while(runsql.readNextRecord())
   	  {
   		  vCent.add(runsql.getData("pecent").trim());   		   
   	  }  
   	   	     	  
   	  String [] sClearCent = vCent.toArray(new String[]{});
   	  runsql.disconnect();
   	  String sClearCentJsa = srvpgm.cvtToJavaScriptArray(sClearCent);
   	  
%>
<html>
<head>
	<title>Perm MD Change</title>
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

var NumOfAttr = "<%=sAttr.length%>";
var ArrAttr = [<%=sAttrJsa%>]
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
  //document.all.btnOpenWdw.style.visibility='hidden';
  document.all.btnDltBatch.style.visibility='hidden';
  sbmList.style.visibility = "hidden";

  doDivSelect(null);

  document.all.ShortNm.value = "";
  document.all.LongNm.value = "";
  
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
   var url = "PermMdGrpList.jsp?"

   window.frame2.location = url;
}

//==============================================================================
// set Batch Number selection menu
//==============================================================================
function showBatch(shortnm, longNm, batch, crtDat,crtUsr)
{
   var selbatch = document.all.Batch;
   for(var i = selbatch.length; i >= 0; i--) {selbatch.options[i] = null;} // clear batch numbers

   selbatch.options[0] = new Option("Create or Select", "NEW")
   for(var i=0; i < batch.length; i++)
   {
     var batchnm = batch[i] + " - " + shortnm[i] + " - " + crtDat[i] + " - " + crtUsr[i];
     selbatch.options[i+1] = new Option(batchnm, batch[i])
   }
   selbatch.selectedIndex = 0;
   sbmList.style.visibility = "visible"


   

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
   
  	var batch = document.all.Batch.options[document.all.Batch.selectedIndex].value;
  	var shortnm = document.all.ShortNm.value.trim().toUpperCase();
  	var longnm = document.all.LongNm.value.trim().toUpperCase();

  
  	if (batch == "NEW" && shortnm == "") { error=true; msg += "Add Short Name for new group";}
  	else if ( !shortnm.substring(0,1).match(/[a-z]/i) ) { error=true; msg += "The Short Name must start from letter";}
  	else if ( shortnm.indexOf(' ') >= 0 ) { error=true; msg += "The Short Name should not have a white space";}
  	
  	var mdprc = document.getElementsByName("inpPrc")[0].value; 
  	if(mdprc==""){ mdprc=="0";}
  	
  	var mdcent = document.getElementsByName("inpCent")[0].value; 
  	if(mdcent==""){ mdcent="0" }
  	
  	var bsrlvl = "B";
	   
  	var frLastRcvDt = "NONE";
  	var toLastRcvDt = "NONE";
  	var frLastSlsDt = "NONE";
  	var toLastSlsDt = "NONE";
  	var frLastMdnDt = "NONE";
  	var toLastMdnDt = "NONE";
  	var permMdn = "B";
  	var clearance = "B";
  
  	//bsrlvl = document.all.SelBsr.options[document.all.SelBsr.selectedIndex].value;
  	
  	frLastRcvDt = document.all.FrLastRcvDt.value.trim();
  	toLastRcvDt = document.all.ToLastRcvDt.value.trim();
  	frLastSlsDt = document.all.FrLastSlsDt.value.trim();
  	toLastSlsDt = document.all.ToLastSlsDt.value.trim();
  	frLastMdnDt = document.all.FrLastMdnDt.value.trim();
  	toLastMdnDt = document.all.ToLastMdnDt.value.trim();
	  
  	permMdn = document.all.SelMdn.options[document.all.SelMdn.selectedIndex].value;
  	clearance = document.all.SelClr.options[document.all.SelClr.selectedIndex].value;
	  
  	var clear = document.getElementsByName("inpCCent"); 
  	var clearChk = Array();
  	for(var i=0, j=0 ; i <  clear.length; i++)
  	{
  		if(clear[i].checked)
	  	{
  			clearChk[j] = clear[i].value; j++; 
	  	}
  	}
  	if((clearance == "B" || clearance == "Y") && clearChk.length == 0) { error=true; msg += "\nCheck at least one Clearance Price End";}
  
  	var attr = getAttr();
  
  	if(div == "ALL" && dpt == "ALL" && cls == "ALL")
  	{
  		error=true; msg += "\nSelect at least 1 Div or Dpt or Cls ";
  	}
  
  	var minret = document.getElementsByName("inpMin")[0].value; 
  	if(minret==""){ error=true; msg += "\nPlease Enter the Minimum Retail Price"; }
  	else if(isNaN(minret)){ error=true; msg += "\nThe Minimum Retail Price is not a numeric value."; }
  	
  	var maxret = document.getElementsByName("inpMax")[0].value; 
  	if(maxret==""){ error=true; msg += "\nPlease Enter the Maximum Retail Price"; }
  	else if(isNaN(maxret)){ error=true; msg += "\nThe Maximum Retail Price is not a numeric value."; }
  
  	 
  	var inpVenTypeObj = document.getElementsByName("inpVenType");
  	var inpVenType = "N";
  	for(var i=0; i < inpVenTypeObj.length; i++)
  	{
  		if(inpVenTypeObj[i].checked)
	  	{
  			inpVenType = inpVenTypeObj[i].value;
		  	break;
	  	}
  	}  
  
  	var inpVenArr = Array();	  
	  
  	if(inpVenType=="I" || inpVenType=="E")
  	{
  		for(var i=0; i < 10; i++)
	  	{
  			var inpVen = document.getElementById("inpVen" + i).value.trim();
		  	if(inpVen != "")
		  	{
		  		inpVenArr[inpVenArr.length] = inpVen;
		  	}
	  	}
	  	if(inpVenArr.length == 0){ error=true; msg += "\nType at least 1 vendor."; } 
	  	else
	  	{
		  for(var i=0; i < inpVenArr.length; i++)
		  {
			  if(!checkVen(inpVenArr[i]))
			  {
				  error=true; msg += "\nThe Vendor " + inpVenArr[i] + " is invalid.";
			  }
		  }
	  	}
  	}
  
  	if(batch == "NEW" && checkShortNm(shortnm))
  	{
  		error=true; msg += "\nThe '" + shortnm + "' is already exists.";
  	}
     
  	if (error) alert(msg);
 	else 
 	{ 
  		genNewBatch(batch, shortnm, longnm, bsrlvl
		, frLastRcvDt, toLastRcvDt, frLastSlsDt, toLastSlsDt, frLastMdnDt, toLastMdnDt
		, permMdn, attr, clearance
		, div, dpt, cls 
		, clearChk, inpVenType, inpVenArr
		, mdprc, mdcent, minret, maxret
		); 	  
 	}
  	return error == false;
}	  
//==============================================================================
//Submit list
//==============================================================================
function checkVen(ven)
{
	var url = "PermMdVenCheck.jsp?Ven=" + ven 
		
	var valid = false;

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
			valid = parseElem(resp, "Ven_Valid") == "true";
		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return valid;
}
//==============================================================================
//Submit list
//==============================================================================
function checkShortNm(shortnm)
{
	var url = "PermMdGrpNmCheck.jsp?ShortNm=" + shortnm 
		
	var valid = false;

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
			valid = parseElem(resp, "Name_Valid") == "true";
		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return valid;
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
function genNewBatch(batch, shortnm, longnm, bsrlvl
		, frLastRcvDt, toLastRcvDt, frLastSlsDt, toLastSlsDt, frLastMdnDt, toLastMdnDt
		, permMdn, attr, clearance
		, div, dpt, cls 
		, clearChk
		, inpVenType, inpVenArr
		, mdprc, mdcent, minret, maxret
)
{
  sbmList.style.visibility = "hidden";
  var url = "PermMdGenGroup.jsp?ShortNm=" + shortnm
    + "&Batch=" + batch
    + "&LongNm=" + longnm
	+ "&BsrLvl=" + bsrlvl 
	+ "&FrLrd=" + frLastRcvDt
	+ "&ToLrd=" + toLastRcvDt
	+ "&FrLsd=" + frLastSlsDt 
	+ "&ToLsd=" + toLastSlsDt
	+ "&FrLmd=" + frLastMdnDt
	+ "&ToLmd=" + toLastMdnDt
	+ "&PermMdn=" + permMdn
	+ "&Clearance=" + clearance
	+ "&Div=" + div
	+ "&Dpt=" + dpt
	+ "&Cls=" + cls
	+ "&MdPrc=" + mdprc
	+ "&MdCent=" + mdcent
	+ "&MinRet=" + minret
	+ "&MaxRet=" + maxret
  ;
  
  for(var i=0; i < attr.length; i++)
  {
	  url += "&AttrN=" + attr[i][0];
	  url += "&AttrV=" + attr[i][1];
  }
  
  for(var i=0; i < clearChk.length; i++)
  {
	  url += "&ClearPrcEnd=" + clearChk[i];
  }
  
  url += "&VenType=" + inpVenType;
  if(inpVenType == "E" || inpVenType == "I")
  {
	  for(var i=0; i < inpVenArr.length; i++)
	  {
		  url += "&VenA=" + inpVenArr[i];
	  }
  }
  url += "&Action=GenBatch"; 
  
  //alert(url)
  window.frame2.location.href=url;
}
//==============================================================================
// Set new batch number
//==============================================================================
function setNewBatchNumber(batch, shortNm, longNm)
{
  var selbatch = document.all.Batch;
  var nxtEnt = selbatch.length;
  selbatch.options[nxtEnt] = new Option(batch + " - " + shortNm, batch);
  selbatch.selectedIndex = selbatch.length - 1;
  if (selbatch.selectedIndex > 0)
  {
	  sbmSlsRep(batch, shortNm, longNm); 
  }
}
//==============================================================================
//Submit list
//==============================================================================
function sbmSlsRep( batch)
{	
	var url = "PermMdBulkChg.jsp?"

	url += "&Batch=" + batch

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

 
//==============================================================================
// show Batch Button
//==============================================================================
function showBatchButton(sel)
{
   if(sel.selectedIndex > 0)
   {
      document.all.btnDltBatch.style.visibility='visible';
      var batch = sel.options[sel.selectedIndex].value;
      
      getBatchProp(batch);   
   }
   else
   {
      document.all.btnDltBatch.style.visibility='hidden'
      document.all.FrLastRcvDt.value = "";
  	  document.all.ToLastRcvDt.value = "";
  	  document.all.FrLastSlsDt.value = "";
  	  document.all.ToLastSlsDt.value = "";
  	  document.all.FrLastMdnDt.value = "";
  	  document.all.ToLastMdnDt.value = "";
   }
}
//==============================================================================
// get batch properties
//==============================================================================
function getBatchProp(batch)
{
	var url ="PermMdGrpProp.jsp?Batch=" + batch;
	window.frame1.location.href = url;
}
//==============================================================================
//set batch properties
//==============================================================================
function setBatchProp(batch, shortnm, longnm, bsrLvl, perm, clear  
  , frRcvDt, toRcvDt, frSlsDt, toSlsDt, frMkdwnDt, toMkdwnDt, hierTy, hier, hierNm, cent
  , venTy, ven, attr, attrVal, mdPrc,mdCent,minRet,maxRet)
{	
	
	document.getElementsByName("ShortNm")[0].value = shortnm;
	document.getElementsByName("LongNm")[0].value = longnm;
	
	document.getElementsByName("ShortNm")[0].readOnly = true;
	
	// permanent markdowns
	if(perm=="B"){ document.all.SelMdn.selectedIndex = 0; }
	else if(perm=="Y"){ document.all.SelMdn.selectedIndex = 1; }
	else if(perm=="N"){ document.all.SelMdn.selectedIndex = 2; }	
	
	// permanent markdowns
	if(clear=="B"){ document.all.SelClr.selectedIndex = 0; }
	else if(clear=="Y"){ document.all.SelClr.selectedIndex = 1; }
	else if(clear=="N"){ document.all.SelClr.selectedIndex = 2; }	
	
	// BSR Level
	/*
	if(bsrLvl=="B"){ document.all.SelBsr.selectedIndex = 0; }
	else if(bsrLvl=="Y"){ document.all.SelBsr.selectedIndex = 1; }
	else if(bsrLvl=="N"){ document.all.SelBsr.selectedIndex = 2; }	
	*/
	
	// Last Received Date
	if(frRcvDt != ""){document.all.FrLastRcvDt.value = cvtDate(frRcvDt);}
	if(toRcvDt != ""){document.all.ToLastRcvDt.value = cvtDate(toRcvDt);}
	
	// Last Sale Date
	if(frSlsDt != ""){document.all.FrLastSlsDt.value = cvtDate(frSlsDt);}
	if(toSlsDt != ""){document.all.ToLastSlsDt.value = cvtDate(toSlsDt);}
		
	// Last Markdown Date
	if(frMkdwnDt != ""){document.all.FrLastMdnDt.value = cvtDate(frMkdwnDt);}
	if(toMkdwnDt != ""){document.all.ToLastMdnDt.value = cvtDate(toMkdwnDt);}
	
	document.getElementsByName("inpPrc")[0].value = mdPrc;
	document.getElementsByName("inpCent")[0].value = mdCent;
	document.getElementsByName("inpMin")[0].value = minRet;
	document.getElementsByName("inpMax")[0].value = maxRet;
	
	// set selected Div/Dpt/Cls
	setBatchHierarchy(hierTy, hier, hierNm);
	
	// set selected price endings
	setBatchPriceEndings(cent);
	
	// set selected vendors
	setBatchVen(venTy, ven);
	
	// set selected attributes
	setBatchAttr(attr, attrVal);
}
//==============================================================================
// set batch hierarchy
//==============================================================================
function setBatchHierarchy(hierTy, hier, hierNm)
{
	document.getElementsByName("SelDiv")[0].selectedIndex=0;
	document.getElementsByName("SelDpt")[0].selectedIndex=0;
	document.getElementsByName("SelCls")[0].selectedIndex=0;
	
	doDivSelect(0); 
	
	var div = document.getElementsByName("Div")[0];
	var divnm = document.getElementsByName("DivName")[0];
	var dpt = document.getElementsByName("Dpt")[0];
	var dptnm = document.getElementsByName("DptName")[0];
	var cls = document.getElementsByName("Cls")[0];
	var clsnm = document.getElementsByName("ClsName")[0];
	
	
	
	for(var i=0; i < hierTy.length; i++)
	{
		if(hierTy[i] == "D")
		{
			div.value= hier[i];
			divnm.value= hier[i] + "-" + hierNm[i];
		}
		
		if(hierTy[i] == "P")
		{
			dpt.value= hier[i];
			dptnm.value= hier[i] + "-" + hierNm[i];
		}
		
		if(hierTy[i] == "C")
		{			
			cls.value= hier[i];
			clsnm.value= hier[i] + "-" + hierNm[i];
		}
	}
}
//==============================================================================
//set selected price endings
//==============================================================================
function setBatchPriceEndings(cent)
{
	var inpCent = document.getElementsByName("inpCCent");
	for(var i=0 ; i <  inpCent.length; i++)
	{	
		inpCent[i].checked = false;
		
		for(var j=0; j < cent.length; j++)
		{					
			if(inpCent[i].value == cent[j])
			{
				inpCent[i].checked = true; 
			}		  
		}
	}
}
//==============================================================================
//set selected vendors
//==============================================================================
function setBatchVen(venTy, ven)
{
	// set 'Include/Exclude Vendors' radio buttons
	var inpVenTypeObj = document.getElementsByName("inpVenType");
	for(var i=0; i < inpVenTypeObj.length; i++)
	{
		if(inpVenTypeObj[i].value == venTy)
		{
			inpVenTypeObj[i].checked = true;
			break;
		}
	}  
	
	// clear selected vendor
	for(var i=0; i < 10; i++)
	{
		var inpVenObj = document.getElementById("inpVen" + i);
		inpVenObj.value=""; 
	}		
	// set vendors
	if(venTy != "N")
	{
		for(var i=0; i < ven.length; i++)
		{
			var inpVenObj = document.getElementById("inpVen" + i);
			inpVenObj.value= ven[i]; 
		}
	}		
}
//==============================================================================
//set selected attributes
//==============================================================================
function setBatchAttr(attr, attrVal)
{
	for(var i=0; i < NumOfAttr; i++)
	{
		var selfld = document.getElementById("selAttr" + i);
		selfld.selectedIndex = 0;
		
		for(var j=0; j < attr.length; j++)
		{
			if(ArrAttr[i] == attr[j])
			{
				selfld.selectedIndex = attrVal[j];
				break;
			}
		}
	}
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
  var url = 'PermMdBulkChg.jsp?'
    + "Batch=" + batch
    + "&ACTION=DLTBATCH";

    if(confirm("This is a last chance. Are You Sure?????"))
   {
       //document.all.btnOpenWdw.style.visibility='hidden';
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
 
//==============================================================================
//dispaly/hide promo price end selection 
//==============================================================================
function chgCEnd(sel)
{
	var clearSel = sel.options[sel.selectedIndex].value;
	var tdccent = document.getElementById("tdCCent");
	if(clearSel == "N") { tdccent.style.display = "none"; setAllCCent(false);}
	else { tdccent.style.display = "table-cell"; setAllCCent(true);}
}
//==============================================================================
//set Promo cent to checked or reset
//==============================================================================
function setAllPCent(mark)
{
	var promo = document.getElementsByName("inpPCent"); 
	for(var i=0; i <  promo.length; i++)
	{
		promo[i].checked = mark;
	}
}
//==============================================================================
//set clearance cent to checked or reset
//==============================================================================
function setAllCCent(mark)
{
	var clear = document.getElementsByName("inpCCent"); 
	for(var i=0; i <  clear.length; i++)
	{
		clear[i].checked = mark;
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
        <BR>Permanent Markdown Bulk Price Change - Selection</B>
        <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>

      <TABLE border=0>
        <TBODY>
         <!-- ======================== Batch ================================ -->
        
        <tr>
        <TD class="Cell" nowrap>Item Group Name (Short): </TD>
            <TD class="Cell1" nowrap>
              <select class="Small"
                 onChange="showBatchButton(this)"
                 name="Batch"></select> &nbsp;
              <button class="Small" id="btnDltBatch" onClick="dltBatch()">Delete Item Group</button>
         </td>
         <TD class="Cell1" id="tdComment" colspan=2>
              <table>
              	<tr>
              		<td class="Cell">New Group Name:</td>
              		<td class="Cell1"><input class="Small" style="text-transform: uppercase;" name="ShortNm" size=12 maxlength=10>(Short)</td>
                </tr> 
              	<tr>
              		<td class="Cell">&nbsp;</td>
              		<td class="Cell1"><input class="Small" style="text-transform: uppercase;" name="LongNm" size=30 maxlength=25>(Long)</td>
              <tr>
              </table>              
          </TD>
        </TR>
        
        <tr style="display:none;">
          <td class="Cell">Percents:</td>
          <TD class="Cell1" nowrap>
            <input class="Small" name="inpPrc" size=6 maxlength=5>%            
          </TD>
          <TD class="Cell1" nowrap>Price Ending Cents:
            <input class="Small" name="inpCent" size=3 maxlength=2> cents            
          </TD>
        </tr>  
        <!-- ------------- Division  --------------------------------- -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <TR>
          <TD class="Cell" >Division:</TD>
          <TD class="Cell1" width="35%">
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
            <TD class="Cell" style="visibility:hidden;">Vendor:</TD>
            <TD class="Cell1" style="visibility:hidden;">
              <input class="Small" name="VenName" size=50 value="All Vendors" readonly>
              <input class="Small" name="Ven" type="hidden" value="ALL">
              <button class="Small" name=GetVen onClick="rtvVendors()">Select Vendors</button><br>
            </TD>
        </TR>

        </TR>
        
        <!-- ======================== Include/Exclude Vendors ================================ -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <tr>
        <TD class="Cell" nowrap>Include/Exclude Vendors: </TD>
            <TD class="Cell1" nowrap colspan=4>
               <input class="Small" name="inpVenType" id="inpVenType0" type="radio" value="N" checked>All &nbsp;
               <input class="Small" name="inpVenType" id="inpVenType1" type="radio" value="E">Exclude &nbsp; 
               <input class="Small" name="inpVenType" id="inpVenType2" type="radio" value="I">Include 
              &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; Vendors:
              <%for(int i=0; i < 10; i++){%>
              	&nbsp; <input class="Small" name="inpVen" id="inpVen<%=i%>" size="7" maxlength="6">
              <%}%>
            </TD>
        </tr>
        
       
        <tbody id="tbody1">
         
        <!-- ======================== All Item Only ================================ -->
        <TR><TD style="border-bottom:darkred solid 1px" colspan="4" >&nbsp;</TD></TR>
        <tr id="trBatchSel">
           <TD class="Cell2" nowrap colspan=4><b><u>Item Filter</u></b>
            <table border=0>
            	<tr>
        			<TD class="Cell" nowrap>Minimum Retail Price: </TD>
        			<TD class="Cell1" nowrap>$<input class="Small" name="inpMin" value="0" size=7 maxlength=5>
        			<TD class="Cell" nowrap>&nbsp; Maximum Retail Price: </TD>
        			<TD class="Cell1" nowrap>$<input class="Small" name="inpMax" value="99999"  size=7 maxlength=5>
            </table>
            <br>&nbsp;
            <table border=0>
            
            	<tr>
        			<TD class="Cell" nowrap>Permanent Markdown:</TD>
        			<TD class="Cell1">
        				<select class="Small" name="SelMdn">
        		  			<option value="B">Both</option>
        		  			<option value="Y">Yes</option>
        		  			<option value="N">No</option>        		  
        				</select>Yes/No/Both
        				
        			</TD>
        			
        			<!-- TD class="Cell" nowrap>Basic Stock Item: </TD>
        			<TD class="Cell1" nowrap>
        			   	<select class="Small" name="SelBsr">
        		  			<option value="B">Both</option>
        		  			<option value="Y">Yes</option>
        		  			<option value="N">No</option>        		  
        				</select>Yes/No/Both
        			</TD -->
        			<TD class="Cell1" nowrap colspan=4>&nbsp;</TD>
        			
        			<TD class="Cell" width="10%">Clearance: </TD>
        			<TD class="Cell1" nowrap>
        			   	<select class="Small" name="SelClr" onchange="chgCEnd(this)">
        		  			<option value="B">Both</option>
        		  			<option value="Y">Yes</option>
        		  			<option value="N">No</option>        		  
        				</select>Yes/No/Both
        			</TD>        		
        		</tr>
        		
        		<tr> 
        		<td colspan=5>&nbsp;</td>         		
        		<td colspan=6  id="tdCCent">
        			<table cellPadding="0" cellSpacing="0" border=1>
        				 <tr>
        				    <td class="Cell" nowrap>Clearance Price End</td>
        				    <%for(int i=0; i < sClearCent.length; i++){%>
        				       <td class="Cell"><%=sClearCent[i]%></td>
        				    <%}%>
        				 </tr> 
        				 <tr>
        				   <td class="Cell1" nowrap>
        				     <a href="javascript: setAllCCent(true)">All</a> &nbsp;
        				     <a href="javascript: setAllCCent(false)">Rest</a> 
						   </td>
        				    <%for(int i=0; i < sClearCent.length; i++){%>
        				       <td class="Cell"><input class="Small" type="checkbox" name="inpCCent" id="inpCCent<%=i%>" value="<%=sClearCent[i]%>" checked></td>
        				    <%}%>
        				 </tr>        				 
        			</table>
        		</td> 
        		
        		</tr>
          		
        		
        		<tr><td>&nbsp;</td></tr>
        		
        		<tr>
        		<TD class="Cell2" colspan=9 nowrap><b><u>Last Date Range</u></b></TD>  
        		</tr>            
            	<tr>          
        			<TD class="Cell2" colspan=3 nowrap><b>Last Received Date</b></TD>
        			<TD class="Cell2" colspan=3 nowrap><b>Last Sale Date</b></TD>
        			<TD class="Cell2" colspan=3 nowrap><b>Last Markdown Date</b></TD> 
        		</tr>
                <tr>          
        			<TD class="Cell" nowrap>From Date:</TD>
        			<TD class="Cell1" nowrap>
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
        			<TD class="Cell1" nowrap>
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
        		           
        			<TD class="Cell" nowrap>From Date:</TD>
        			<TD class="Cell1" nowrap>        			
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
        			<TD class="Cell1" nowrap>
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
        			<TD class="Cell1" nowrap>
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
        
        <!-- ======================== Item Attribute filter ============================ -->
        <tr id="trBatchSel">
        			<TD class="Cell2" nowrap colspan="9">&nbsp;<br><u><b>Item Attribute Filter:</b></u>
        			 	&nbsp; <a class="Small" href="javascript: setAttr()">Reset</a>
        			</TD>
        		</TD>	
        		<tr id="trBatchSel">
        			<TD class="Cell2" nowrap colspan="9">        			
        				<table cellPadding="0" cellSpacing="0" border=1> 
        				  	<tr>
        				  		<%for(int i=0; i < 4; i++){%> 
        				  		<th>Attribute</th>
        				  		<th>Name</th>
        				  		<th>Selection</th>
        				  		<th>&nbsp;</th>
        				  		<%}%>
        				    </tr>
        					<%for(int i=0, j=0; i < sAttr.length; i++, j++){
        						sStmt = "select  ATTDCTI, ATTDDSI, ATTDDSD"
        						  + " from iptsfil.ipattds"
        						  + " where ATTDTPI=3 and ATTDDSI < 999 and ATTDCTI = " + sAttr[i]
        						  + " order by ATTDCTI, ATTDDSI"
        						;
        						runsql = new RunSQLStmt();
        					   	runsql.setPrepStmt(sStmt);		   
        					   	runsql.runQuery();        					   	
        					%>
        					    <%if(j % 4 == 0){%>
        							</tr>
        						<%}%>
        					    <%if(j==0 || j % 4 == 0){%>
        							<tr id="trBatchSel">
        						<%}%>        		    
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
        							<td class="Cell">&nbsp</td>                				        		    
                			<%}%> 
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