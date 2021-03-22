<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.text.*, java.util.*, rciutility.CallAs400SrvPgmSup"%>
<%
String sUserId = request.getParameter("User");  
String sLogSize = request.getParameter("LogSize");
String sPosTo = request.getParameter("PosTo");

if(sLogSize==null) { sLogSize = "0"; }
if(sPosTo==null){ sPosTo = " "; }

//----------------------------------
//Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
  response.sendRedirect("SignOn1.jsp?TARGET=MozuSoldOutLst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	
	String sStmt = " select PAATTR,	PAFQN" 
	    + ", case when PAIPATT='Y' then 'Y' else ' ' end as PAIPATT"
		+ " from RCI.MoAttrH"  
	 	+ " where pasite='11961'"
	 	+ " and PAHIDEM <> 'Y'"
	 	+ " order by PAATTR, PAFQN"
	;
	System.out.println(sStmt);
	
	RunSQLStmt runsql = new RunSQLStmt();
	runsql.setPrepStmt(sStmt);
	ResultSet rs = runsql.runQuery();
	Vector<String> vAttr = new Vector<String>();
	Vector<String> vAttrFQN = new Vector<String>();
	Vector<String> vAttrType = new Vector<String>();
	
	while(runsql.readNextRecord())
	{
		vAttr.add(runsql.getData("PAATTR").trim());
		vAttrFQN.add(runsql.getData("PAFQN").trim());
		vAttrType.add(runsql.getData("PAIPATT").trim());
	}
	
	String [] sAttr = vAttr.toArray(new String[]{});
	String [] sAttrFQN = vAttrFQN.toArray(new String[]{});
	String [] sAttrType = vAttrType.toArray(new String[]{});
	 
	//rs.close();
	runsql.disconnect();
	
	CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
	
%>
	
<HTML>
<HEAD>
<title>Attribute Maintenance</title>
 </HEAD>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css"> 

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script src="XX_Set_Browser.js"></script>
<script src="XX_Get_Visible_Position.js"></script>

 
<script>
//==============================================================================
// Global variables
//==============================================================================
var PosTo = "<%=sPosTo%>";

var Attr = null;
var AttrFQN = null;
var AttrOpt = new Array();
var AttrOptVal = new Array();
var AttrType = null;

var ProdTypeId = null;
var ProdType = null;

var arrAttr = [<%=srvpgm.cvtToJavaScriptArray(sAttr)%>];
var arrAttrFQN = [<%=srvpgm.cvtToJavaScriptArray(sAttrFQN)%>];
var arrAttrType = [<%=srvpgm.cvtToJavaScriptArray(sAttrType)%>];

var arrProdTyId = new Array();
var arrProdTy = new Array();

var ColPos = [0,0];
var LogSize = "<%=sLogSize%>";

var progressIntFunc = null;
var progressTime = 0;

var DownHistRefreshFunc = null;
var IdleTimeFunc = null;
var IdleTime = 0; 
var draged=false;

var OptAction = null;
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvHist", "dvOpt"]);
	
	getDownLog();
	
	setTableonSelPgm();
}
//==============================================================================
//set table on selected position
//==============================================================================
function setTableonSelPgm()
{
	var w = $(window);
	
	var search = "trId" + PosTo;
	var row = document.getElementById(search);
	
	if(row != null)
	{
		row.style.backgroundColor = "#f7f4c5";
	
		var top = row.offsetTop;
		var winh = w.height()/2;
		var pos = top - winh;
		w.scrollTop( pos );
	}
}
//==============================================================================
//check scanned item against order
//==============================================================================
function getDownLog()
{
	var url = "MozuAttrUplLog.jsp?User=<%=sUser%>";
	
	var action = new Array();
	var param = new Array();
	var time = new Array();
	var errflg = new Array();
	var error = new Array();

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
		   action = parseElemArr(resp, "Action");
		   param = parseElemArr(resp, "Param");
		   time = parseElemArr(resp, "Time");
		   errflg = parseElemArr(resp, "ErrFlg");
		   error = parseElemArr(resp, "Error");  	
		   showHistDownLog(action, param, time, errflg, error); 
		}
	}
	xmlhttp.open("POST",url,false); // asynchronize with this apps
	xmlhttp.send();

	//alert(sku.trim());
	return item.length > 0;
}
//==============================================================================
//parse XML elements into array
//==============================================================================
function parseElemArr(resp, tag )
{
	var arr = new Array();	
	var taglen = tag.length + 2;
	var beg = resp.indexOf("<" + tag + ">") + taglen;
	var end = resp.indexOf("</" + tag+ ">");
	
	while(beg >= 0)
	{
		arr[arr.length] = resp.substring(beg, end);
		resp = resp.substring(end + taglen);
		beg = resp.indexOf("<" + tag + ">") + taglen;
		end = resp.indexOf("</" + tag+ ">");
		if(arr.length > 50 || end < 0){ break; }
	}
	return arr;	
}
//==============================================================================
//show historical log of item downloading
//==============================================================================
function showHistDownLog(action, param, time, errflg, error)
{
	var hdr = "Your Today Downloading Log";

	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0 id='tblLog1'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "&nbsp;</td>"
	       + "<td class='BoxClose' valign='top'>"
	       		+  "<img src='MinimizeButton.bmp' id='imgMin' onclick='javascript: setHistLog(&#34;0&#34;);' alt='Minimize'>&nbsp;"  
	       		+  "<img src='RestoreButton.bmp'  id='imgMed' onclick='javascript: setHistLog(&#34;1&#34;);' alt='Restore'>&nbsp;"
	       		+  "<img src='MaxButton.bmp'  id='imgMax' onclick='javascript: setHistLog(&#34;2&#34;);' alt='Restore'>"
	       + "</td></tr>"
	     + "</tr>"
	     + "<tr><td class='Small' id='tdLog' colspan='2'>"
	        + popHistDownLog(action, param, time, errflg, error)
	     + "</td></tr>"
	   + "</table>"

	document.all.dvLog.innerHTML = html;
	document.all.dvLog.style.visibility = "visible";
	
	setHistLog(LogSize);
	
	clearInterval( DownHistRefreshFunc );
	DownHistRefreshFunc = setInterval(function() { getDownLog() }, 1000 * 30);
}
//==============================================================================
//populate panel of historical log of items downloaded
//==============================================================================
function popHistDownLog(action, param, time, errflg, error)
{
	var panel = "<table class='tbl02' id='tblLog2' width='100%' >"
	panel += "<tr class='trHdr01'>" 
		 + "<th class='th01'>Action</th>"
		 + "<th class='th01'>Param</th>"
	     + "<th class='th01'>Time</th>"
	     + "<th class='th01'>Err</th>"
	     + "<th class='th01'>Error Log</th>"
	  + "</tr>"
 	for(var i=0; i < action.length; i++)
 	{
 		panel += "<tr class='trDtl04'>"
 	     	+ "<td class='td11' nowrap width='100'>" + action[i] + "</td>"
 	     	+ "<td class='td11' nowrap width='500'>" + setParam(action[i], param[i]) + "</td>"
 	        + "<td class='td11' nowrap width='60'>" + time[i] + "</td>"
 	     	+ "<td class='td11' nowrap width='20'>&nbsp;" + errflg[i] + "&nbsp;</td>"
 	    	+ "<td class='td11'>" + error[i] + "&nbsp;</td>"
 	  	 + "</tr>"
 	}  		
	  
	panel += "</table>";
	
	
	panel = "<div id='dvHistInt' class='dvInternal' style='height:120px'>" + panel + "</div>";
	
	var today = new Date();
	var h = today.getHours();
  var m = today.getMinutes();
  var s = today.getSeconds();
  var time = h + ":" + m + ":" + s; 
	
	panel += "<table border=0 width='100%' cellPadding='0' cellSpacing='0'>";
	panel += "<tr class='trDtl04'>"	
	    	+ "<td class='td11'><button class='Small1' onclick='getDownLog()'>Refresh</button></td>"
	    	+ "<td class='td11'>Last Time Updated: " + time + "</td>"
	    + "</tr>";
	panel += "</table>";
	
	return panel;
}
//==============================================================================
// parse parameters
//==============================================================================
function setParam(action, param)
{
	var info = "";
	if(action == "SaveNewAttr")
	{
	   	if(param.length >= 50){info = "<b>Attribute:</b> " + param.substring(0, 50).trim(); } else { info = "<b>Attribute:</b> " + param.substring(0).trim(); }	   	
	   	if(param.length >= 120){info += "  <b>Type:</b> " + param.substring(50, 70).trim(); } else { info += "  <b>Type:</b> " + param.substring(50).trim(); }
	   	if(param.length >= 71){info += "  <b>Propety:</b> " + param.substring(70, 71).trim(); } else {info += "  <b>Propety?</b> " + param.substring(70).trim(); }
	}
	else if(action == "SaveNewAttrOpt")
	{
		if(param.length >= 50){info = "<b>Attribute:</b> " + param.substring(0, 50).trim(); } else { info = "<b>Attribute:</b> " + param.substring(0).trim(); }	   	
	   	if(param.length >= 150){info += "  <b>Option:</b> " + param.substring(50, 100).trim(); } else { info += "  <b>Type:</b> " + param.substring(50).trim(); }	   	
	}
	else if(action == "SavePtAttrOpt")
	{
		if(param.length >= 50){info = "<b>Attribute:</b> " + param.substring(0, 50).trim(); } else { info = "<b>Attribute:</b> " + param.substring(0).trim(); }	   	
	   	if(param.length >= 150){info += "  <b>Option:</b> " + param.substring(50, 150).trim(); } else { info += "  <b>Option:</b> " + param.substring(50).trim(); }
	   	if(param.length >= 200){info += "  <b>ProductType :</b> " + param.substring(150, 200).trim(); } else { info += "  <b>Product Type:</b> " + param.substring(150).trim(); }	   	
	}	
	else if(action == "DltAttr")
	{
		if(param.length >= 50){info = "<b>Attribute:</b> " + param.substring(0, 50).trim(); } else { info = "<b>Attribute:</b> " + param.substring(0).trim(); }
	}
	else if(action == "DltPtAttrOpt")
	{
		if(param.length >= 50){info = "<b>Attribute:</b> " + param.substring(0, 50).trim(); } else { info = "<b>Attribute:</b> " + param.substring(0).trim(); }
		if(param.length >= 150){info += "  <b>Option:</b> " + param.substring(50, 150).trim(); } else { info += "  <b>Option:</b> " + param.substring(50).trim(); }
	   	if(param.length >= 200){info += "  <b>ProductType :</b> " + param.substring(150, 200).trim(); } else { info += "  <b>Product Type:</b> " + param.substring(150).trim(); }
	}
	else if(action == "DltPtAttr")
	{
		if(param.length >= 50){info = "<b>Attribute:</b> " + param.substring(0, 50).trim(); } else { info = "<b>Attribute:</b> " + param.substring(0).trim(); }
		if(param.length >= 100){info += "  <b>ProductType :</b> " + param.substring(50, 100).trim(); } else { info += "  <b>Product Type:</b> " + param.substring(50).trim(); }
	}
	return info;
}
//==============================================================================
//switch history box size
//==============================================================================
function setHistLog(size)
{
	if(size == "0" )
	{  
		document.all.tdLog.style.display= "none";
		document.all.imgMin.style.display= "none";
		document.all.imgMed.style.display= "inline";
		document.all.imgMax.style.display= "inline";
		document.all.dvLog.style.width = "250";	
		document.all.dvLog.style.height = "auto";
		document.all.dvHistInt.style.display= "none";
	}
	else if(size == "1")
	{  
		document.all.tdLog.style.display= "block";
		document.all.imgMin.style.display= "inline";
		document.all.imgMed.style.display= "none";
		document.all.imgMax.style.display= "inline";
		document.all.dvHistInt.style.display= "block";
		document.all.dvLog.style.width = "400";
		document.all.dvLog.style.height = "50";
		document.all.dvHistInt.style.width = "400";
		document.all.dvHistInt.style.height = "100";
	}
	else if(size == "2")
	{  
		document.all.tdLog.style.display= "block";
		document.all.imgMin.style.display= "inline";
		document.all.imgMed.style.display= "inline";
		document.all.imgMax.style.display= "none";	
		document.all.dvHistInt.style.display= "block";
		document.all.dvLog.style.width = "1000";
		document.all.dvLog.style.height = "500";
		document.all.dvHistInt.style.width = "100%";
		document.all.dvHistInt.style.height = "100%";
	}
	
	LogSize = size;
}


//==============================================================================
//update Attribute values
//==============================================================================
function updAttrVal(attr, fqn, row, action, type)
{
	OptAction = action;
	PosTo = row;
	Attr = attr;
	AttrFQN = fqn;
	AttrType = type;
	
	var url = "KiboAttrUpd.jsp?Site=11961"
		+ "&Attr=" + fqn
		+ "&Action=GetAttrList"
	;
	window.frame1.location.href = url;
}
//==============================================================================
//update Attribute values
//==============================================================================
function getPtAttr(ptid, pt)
{
	ProdTypeId = ptid;
	ProdType = pt;
	
	var url = "KiboAttrUpd.jsp?Site=11961"
		+ "&Attr=" + fqn
		+ "&Action=GetPtAttrList"
	;
	window.frame1.location.href = url;
}
//==============================================================================
//update Attribute values
//==============================================================================
function showAttrVal(opt, optval)
{
	// save attribute options
	AttrOpt = new Array();
	AttrOptVal = new Array();
	
	for(var i=0; i < opt.length;i++)
	{ 
		AttrOpt[i] = opt[i];
		AttrOptVal[i] = optval[i];
	}
	
	var hdr = "Attribute: " + Attr;
	var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Small' style='text-align: center' colspan=2>" 
	         + popAttrVal(opt, optval)
	     + "</td></tr>"
	   + "</table>"

	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "450";}
	else { document.all.dvItem.style.width = "auto";}
	
	document.all.dvItem.style.height = "300";
	   
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.left=getLeftScreenPos() + 330;
	document.all.dvItem.style.top=getTopScreenPos() + 10;
	document.all.dvItem.style.zIndex = "50";
	document.all.dvItem.style.visibility = "visible";
	
	for(var i=0; i < opt.length; i++)
	{
		document.getElementById("tdOpt" + i).innerHTML = optval[i];
	}
}
//==============================================================================
//populate order list for selected status
//==============================================================================
function popAttrVal(opt, optval)
{
	var panel = "";
	
	if(OptAction == "Opt Maint")
	{
		panel +=  "Add New Option: <input class='Small' size='55' maxlength='50' id='AddOpt' name='AddOpt'>"
		 + "&nbsp;<button class='Small' onclick='vldOpt(null, &#34;SaveNewAttrOpt&#34;);'>Add</button><br><br>"
	}
	
	panel += "Search: <input class='Small' size='55' maxlength='50' id='FndOpt' name='FndOpt'>"
		+ "&nbsp;<button class='Small' onclick='findSelOpt(true);'>Find</button>"
		+ "&nbsp;<button class='Small' onclick='findSelOpt(false);'>All</button>";

	if(OptAction == "To PT") 
	{
		panel += "<br><a href='javascript: setMarkOpt(true)'>Mark All</a> &nbsp; "
		 + "<a href='javascript: setMarkOpt(false)'>Unmarked All</a>";
	}	
    panel += "<div id='dvAttrOpt' class='dvInternal' style='height:250px; width: 100%; scrollbar-width: thin;'>"     	
    	+ "<table class='tbl01'>"
	    + "<tr class='trHdr02'>"
  			+ "<th class='th01'>Option</th>"
  	
  	if(OptAction == "Opt Maint"){ panel += "<th class='th01' style='width: 15%'>Remove</th>"}
  	else { panel += "<th class='th01' style='width: 15%'>Attach<br>To<br>PT</th>"; }
  		
  	panel += "</tr>"
  	   
  	for(var i=0; i < opt.length; i++)
  	{
  		panel += "<tr class='trDtl06' id='trOpt" + i + "'>"
  			+ "<td class='td11' id='tdOpt" + i + "'></td>"
  			+ "<td class='td11'>";
  			
  		if(OptAction == "Opt Maint")	
  		{
  			panel += "<a class='Small' href='javascript: vldOpt(&#34;" + i + "&#34;, &#34;DltAttrOpt&#34;)'>Remove</a>";
  		}		
  		else 
  		{ 
  			panel += "<input class='Small' type='checkbox' id='inpToPT" + i + "' value='Y'>" 
  		}
  		panel += "</td>";
  		panel +=  "</tr>";	
  	} 
  	panel += "</table>";  	     
	panel += "</div>";
	 
	  //-----------------------------------------------------------
	  //   Product type list
	  //-----------------------------------------------------------
	  
	if(OptAction == "To PT") 
	{ 
		panel += "<br><a href='javascript: setMarkPty(true)'>Mark All</a> &nbsp; "
			 + "<a href='javascript: setMarkPty(false)'>Unmarked All</a>"
		 + "<br><div id='dvProdTy' class='dvInternal' style='height:350px; width: 100%'>"     	
    	 + "<table class='tbl01'>"
	     + "<tr class='trHdr02'>"
	        + "<th class='th01'>Product<br>Type<br>Id</th>"
  			+ "<th class='th01'>Product Type</th>"
  			+ "<th class='th01'>Rcv<br>Attr</th>"
  		;  			
  		panel += "</tr>"
  		  	   
  		for(var i=0; i < arrProdTyId.length; i++)
  		{
  			panel += "<tr class='trDtl04' id='trOpt" + i + "'>"
  			 + "<td class='td12' style='width: 10%' id='tdPtId" + i + "'>" + arrProdTyId[i] + "</td>"
  			 + "<td class='td11' id='tdPt" + i + "'>" + arrProdTy[i] + "</td>"
  			 + "<td class='td11'>"
  	  			+ "<input class='Small' type='checkbox' id='inpPTRcv" + i + "' value='Y'>" 
  	  		 + "</td>";
   			panel += "</tr>";	
   		} 		
  			
  		panel += "</table>";
  		panel += "</div>";
	}
  	
	panel += "<span style='color:red;text-align:left; vertical-align:middle; padding: 3px; width: 100%' id='spnError'></span><br>"  
	  
	if(OptAction == "To PT") 
	{ 
		panel += "<button onClick='vldPtAtr(&#34;SavePtAttrOpt&#34;);' class='Small'>Submit</button> &nbsp; ";
	}
	panel += "<button onClick='hidePanel();' class='Small'>Cancel</button>";
	   
	return panel;
}
//==============================================================================
// validate option
//==============================================================================
function vldOpt(arg, action)
{
	var error = false;
	var msg = "";
	var br = "";
	document.getElementById("spnError").innerHTML = "";
	var opt = null;
	
	if(action == "SaveNewAttrOpt")
	{
		opt = document.getElementById("AddOpt").value.trim();
		if(opt == ""){error=true; msg = br + "Please enter the Option."; br = "<br>";}
		
		opt = replaceChar(opt);
	
		for(var i=0; i < AttrOpt.length; i++)
		{
			if(AttrOpt[i] == opt){error=true; msg = br + "The Option is already exists."; br = "<br>"; break;} 
		}
	}
	else if(action == "DltAttrOpt")
	{
		opt = AttrOpt[arg];
		opt = replaceChar(opt);
	}
	
	if(error){ document.getElementById("spnError").innerHTML = msg; }
	else{ sbmOpt(opt, action); }
}
//==============================================================================
// replace spec characters
//==============================================================================
function replaceChar(opt)
{
	var newopt = "";
	while( opt.indexOf("&amp;") >= 0) {	opt = opt.replace("&amp;", "XXXANDXXX" );	}
	
	for(var i=0; i< opt.length; i++)
	{
		var single = opt.substring(i,i+1)
		
		if( single == "+"){	single = "XXXPLUSXXX"; }
		else if( single == "'") { single = "XXXFOOTXXX"; }
		else if( single == "\"") { single = "XXXINCHXXX"; }
		else if( single == "&") { single = "XXXANDXXX"; }
		
		newopt += single;
	}
	return newopt;
}
//==============================================================================
//hide panel
//==============================================================================
function sbmOpt(opt, action)
{	
	var url = "KiboAttrUpd.jsp?Site=11961"
		+ "&Attr=" + AttrFQN
		+ "&AttrOpt=" + opt
		+ "&AttrIpTy=" + AttrType
		+ "&Action=" + action
	;
	window.frame1.location.href = url;
}

//==============================================================================
// validate Product type attribute attachment
//==============================================================================
function vldPtAtr(action)
{
	var error = false;
	var msg = "";
	var br = "";
	document.getElementById("spnError").innerHTML = "";
	
	var opt = new Array();
	var optval = new Array();
	var ptid = new Array();
	var pt = new Array();
	
	// collect selected options
	for(var i=0; i < AttrOpt.length; i++)
	{
		var chk = document.getElementById("inpToPT" + i).checked;
		if(chk)
		{ 
			//opt[opt.length] = AttrOptVal[i];
			opt[opt.length] = AttrOpt[i];
		}
	}	
	if(opt.length < 1){ error=true; msg += br + "Please, select at least 1 Attribute Option."; br = "<br>"; }
	
	// collect selected product types
	for(var i=0; i < arrProdTyId.length; i++)
  	{
		var chk = document.getElementById("inpPTRcv" + i).checked;
		if(chk)
		{ 
			ptid[ptid.length] = document.getElementById("tdPtId" + i).innerHTML;
			pt[pt.length] = document.getElementById("tdPt" + i).innerHTML;
		}
	}	
	if(ptid.length < 1){ error=true; msg += br + "Please, select at least 1 Product Type."; br = "<br>"; }
	
		
	if(error){ document.getElementById("spnError").innerHTML = msg; }
	else{ sbmPtOpt(opt, ptid, pt, action); }
}

//==============================================================================
// submit product type option attachment
//==============================================================================
function sbmPtOpt(opt, ptid, pt, action)
{
	if(isIE){ nwelem = window.frame1.document.createElement("div"); }
	else if(isSafari){ nwelem = window.frame1.document.createElement("div"); }
	else{ nwelem = window.frame1.contentDocument.createElement("div");}
    
    nwelem.id = "dvSbmPtAttrOpt"

    var html = "<form name='frmPostPackId'"
       + " METHOD=Post ACTION='KiboAttrUpd.jsp'>"
       + "<input name='Site'>"
       + "<input name='Action'>"
     ;
    
    // add option to form  
    for(var i=0; i < opt.length; i++)
    {
    	html += "<input name='arrAttr'>"
              + "<input name='arrAttrOpt'>";
    }
    
    // add product type to form 
    for(var i=0; i < ptid.length; i++)
    {
    	html += "<input name='arrProdTypeId'>"
              + "<input name='arrProdType'>";
    }
      
    
    html += "</form>"

    nwelem.innerHTML = html;
    
    if(isIE && ua.indexOf("MSIE 7.0") >= 0){ window.frame1.document.appendChild(nwelem); }
    else if(isIE){ window.frame1.document.body.appendChild(nwelem); }
    else if(isSafari){ window.frame1.document.body.appendChild(nwelem); }
    else{ window.frame1.contentDocument.body.appendChild(nwelem); }

    if(isIE || isSafari)
	 {
   	 	window.frame1.document.all.Site.value = "11961"; 
   	    window.frame1.document.all.Action.value= action;
  		
   	 	// selected attribute options
   	 	for(var i=0; i < opt.length; i++)
     	{
   	 	   if(opt.length == 1)
   	 	   {
   	 			window.frame1.document.all.arrAttr.value = AttrFQN;
	 	   		window.frame1.document.all.arrAttrOpt.value = opt[i];
   	 	   }
   	 	   else 
   	 	   {
   	 	   		window.frame1.document.all.arrAttr[i].value = AttrFQN;
   	 	   		window.frame1.document.all.arrAttrOpt[i].value = opt[i];
   	 	   }
     	}
   	 	
   		// selected product types
   	 	for(var i=0; i < ptid.length; i++)
     	{
   	 		if(ptid.length == 1)
	 		{
   	 			window.frame1.document.all.arrProdTypeId.value = ptid[i];
   	 			window.frame1.document.all.arrProdType.value = pt[i];
	 	   	}
   	 		else
   	 		{
   	 			window.frame1.document.all.arrProdTypeId[i].value = ptid[i];
	 			window.frame1.document.all.arrProdType[i].value = pt[i];
   	 		}   	 	   
     	}
         
  		window.frame1.document.frmPostPackId.submit();
	 }
    else
    {
   	 	window.frame1.contentDocument.forms[0].Site.value = "11961"; 	
   	 	window.frame1.contentDocument.forms[0].Action.value = action;
   	 
  		// selected attribute options
	 	for(var i=0; i < opt.length; i++)
  		{
	 		window.frame1.contentDocument.forms[0].arrAttr[i].value = AttrFQN;
	 		window.frame1.contentDocument.forms[0].arrAttrOpt[i].value = opt[i];
  		}
	 	
		// selected product types
	 	for(var i=0; i < ptid.length; i++)
  		{
	 		window.frame1.contentDocument.forms[0].arrProdTypeId[i].value = ptid;
	 		window.frame1.contentDocument.forms[0].arrProdType[i].value = pt[i];
  		}
      
   	 	window.frame1.contentDocument.forms[0].submit();
    }
}

//==============================================================================
//update Attribute values
//==============================================================================
function getPtAttr(ptid, pt)
{
	ProdTypeId = ptid;
	ProdType = pt;
	
	var url = "KiboAttrUpd.jsp?Site=11961"
		+ "&ProdTypeId=" + ProdTypeId
		+ "&ProdType=" + ProdType
		+ "&Action=GetPtAttrList"
	;
	window.frame1.location.href = url;
}
//==============================================================================
//update Attribute values
//==============================================================================
function showPtAttr(ptattr, ptattrFqn, optcnt)
{
	// save attribute options
	AttrOpt = new Array();
	for(var i=0; i < ptattr.length;i++){ AttrOpt[i] = ptattr[i]; }
	
	var hdr = "Product Type: " + ProdType;
	var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Small' style='text-align: center' colspan=2>" 
	        + popPtAttr(ptattr, ptattrFqn, optcnt)
	     + "</td></tr>"
	   + "</table>"

	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "450";}
	else { document.all.dvItem.style.width = "auto";}
	
	document.all.dvItem.style.height = "300";
	   
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.left=getLeftScreenPos() + 600;
	document.all.dvItem.style.top=getTopScreenPos() + 10;
	document.all.dvItem.style.zIndex = "50";
	document.all.dvItem.style.visibility = "visible";
	
	for(var i=0; i < ptattr.length; i++)
	{
		document.getElementById("tdPtAttr" + i).innerHTML = 
		 "<a href='javascript: getPtAttrOpt(&#34;" + ptattr[i] + "&#34;,&#34;" + ptattrFqn[i] + "&#34;)'>" + ptattr[i] + "</a>";
		document.getElementById("tdPtAttrFqn" + i).innerHTML = ptattrFqn[i];
		document.getElementById("tdPtAttrCnt" + i).innerHTML = optcnt[i];
	}
}
//==============================================================================
//populate order list for selected status
//==============================================================================
function popPtAttr(ptattr, ptattrFqn, optcnt)
{
	var panel = "";
		
  	panel += "<div id='dvPtAttrOpt' class='dvInternal' style='height:250px; width: 100%;'>"     	
  		+ "<table class='tbl01'>"
	    + "<tr class='trHdr08'>"
			+ "<th class='th01'>Attributes</th>"
			+ "<th class='th01'>Attributes FQN</th>"
			+ "<th class='th01'>Number<br>Of<br>Opt</th>"
	
  	panel += "<th class='th01' style='width: 15%'>Remove</th>"
	
		
	panel += "</tr>"
	   
	for(var i=0; i < ptattr.length; i++)
	{
		panel += "<tr class='trDtl04' id='trPtAttr" + i + "'>"
			+ "<td class='td11' id='tdPtAttr" + i + "'></td>"
			+ "<td class='td11' id='tdPtAttrFqn" + i + "'></td>"
			+ "<td class='td12' id='tdPtAttrCnt" + i + "'></td>"
			+ "<td class='td18'>";
		if(optcnt[i] == "0")
		{	
		      panel += "<a class='Small' href='javascript: vldPtAttr(&#34;" + i + "&#34;, &#34;DltPtAttr&#34;)'>Remove</a>"
		}      
		panel += "</td>";
		panel +=  "</tr>";	
	} 
	panel += "</table>";  	     
	panel += "</div>";
	
	panel += "<span style='color:red;text-align:left; vertical-align:middle; padding: 3px; width: 100%' id='spnError'></span><br>"
	panel += "<button onClick='hidePanel();' class='Small'>Cancel</button>"; 
	return panel;
}
//==============================================================================
//mark all option that must be connected to product types
//==============================================================================
function vldPtAttr(arg, action)
{	
	var error = false;
	var msg = "";
	var br = "";
	document.getElementById("spnError").innerHTML = "";
	
	var pt = ProdType;
	var ptid = ProdTypeId;
	
	attrfqn = document.getElementById("tdPtAttrFqn" + arg).innerHTML;
	
	if(error){ document.getElementById("spnError").innerHTML = msg; }
	else{ sbmPtAttr( ptid, pt, attrfqn, action); }
}
//==============================================================================
//hide panel
//==============================================================================
function sbmPtAttr( ptid, pt, attrfqn, action)
{	
	var url = "KiboAttrUpd.jsp?Site=11961"
		+ "&ProdTypeId=" + ptid
		+ "&ProdType=" + pt
		+ "&Attr=" + attrfqn
		+ "&Action=" + action
	;
	window.frame1.location.href = url;
}


//==============================================================================
//update Attribute values
//==============================================================================
function getPtAttrOpt(attr, fqn)
{
	Attr = attr;
	AttrFQN = fqn;
	
	var url = "KiboAttrUpd.jsp?Site=11961"
		+ "&ProdTypeId=" + ProdTypeId
		+ "&ProdType=" + ProdType
		+ "&Attr=" + fqn
		+ "&Action=GetPtAttrOptList"
	;
	window.frame1.location.href = url;
}
//==============================================================================
//update Product Type Attribute options/values
//==============================================================================
function showPtAttrOpt(opt, optval)
{
	// save attribute options and its value
	AttrOpt = new Array();	
	for(var i=0; i < opt.length;i++){ AttrOpt[i] = opt[i]; }
	
	AttrOptVal = new Array();
	for(var i=0; i < optval.length;i++){ AttrOptVal[i] = optval[i]; }
	
	var hdr = "Product Type: " + ProdType + "  Attribute: " + Attr;
	var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript: hidePanel1();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Small' style='text-align: center' colspan=2>" + popPtAttrOpt(opt, optval)
	     + "</td></tr>"
	   + "</table>"
	;

	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvOpt.style.width = "450";}
	else { document.all.dvOpt.style.width = "auto";}
	
	document.all.dvOpt.style.height = "300";
	   
	document.all.dvOpt.innerHTML = html;
	document.all.dvOpt.style.left=getLeftScreenPos() + 550;
	document.all.dvOpt.style.top=getTopScreenPos() + 150;
	document.all.dvOpt.style.zIndex = "50";
	document.all.dvOpt.style.visibility = "visible";
	
	for(var i=0; i < opt.length; i++)
	{
		document.getElementById("tdOpt" + i).innerHTML = optval[i];
		document.getElementById("tdOptVal" + i).innerHTML = opt[i];
	}
}
//==============================================================================
//populate order list for selected status
//==============================================================================
function popPtAttrOpt(opt, optval)
{
	var panel = "";
		
	panel += "<div id='dvPtAttrOpt' class='dvInternal' style='height:250px; width: 100%;'>"     	
		+ "<table class='tbl01'>"
	    + "<tr class='trHdr08'>"
			+ "<th class='th01'>Label</th>"
			+ "<th class='th01'>Values</th>"
	
	panel += "<th class='th01' style='width: 15%'>Remove</th>"
	
		
	panel += "</tr>"
	   
	for(var i=0; i < opt.length; i++)
	{
		panel += "<tr class='trDtl04' id='trOpt" + i + "'>"
		    + "<td class='td11' id='tdOpt" + i + "'></td>"
			+ "<td class='td11' id='tdOptVal" + i + "'></td>"
			+ "<td class='td11'>"	
		      + "<a class='Small' href='javascript: vldPtAttrOpt(&#34;" + i + "&#34;, &#34;DltPtAttrOpt&#34;)'>Remove</a>"
		    + "</td>";
		panel +=  "</tr>";	
	} 
	panel += "</table>";  	     
	panel += "</div>";
	
	panel += "<span style='color:red;text-align:left; vertical-align:middle; padding: 3px; width: 100%' id='spnError'></span><br>"
	panel += "<button onClick='hidePanel1();' class='Small'>Cancel</button>";
	
	 	 
	return panel;
}
//==============================================================================
//mark all option that must be connected to product types
//==============================================================================
function vldPtAttrOpt(arg, action)
{	
	var error = false;
	var msg = "";
	var br = "";
	document.getElementById("spnError").innerHTML = "";
	
	var pt = ProdType;
	var ptid = ProdTypeId;
	var attrfqn = AttrFQN;
	var opt = null;
	
	if(action == "DltPtAttrOpt")
	{
		opt = AttrOptVal[arg];
	}
	
	if(error){ document.getElementById("spnError").innerHTML = msg; }
	else{ sbmPtAttrOpt( ptid, pt, attrfqn, opt, action); }
}
//==============================================================================
//hide panel
//==============================================================================
function sbmPtAttrOpt( ptid, pt, attrfqn, opt, action)
{	
	var url = "KiboAttrUpd.jsp?Site=11961"
		+ "&ProdTypeId=" + ptid
		+ "&ProdType=" + pt
		+ "&Attr=" + AttrFQN
		+ "&AttrOpt=" + opt
		+ "&Action=" + action
	;
	window.frame1.location.href = url;
}
//==============================================================================
// mark all option that must be connected to product types
//==============================================================================
function setMarkOpt(chk)
{
	for(var i=0; i < AttrOpt.length; i++)
	{
		document.getElementById("inpToPT" + i).checked = chk;
	}
}
//==============================================================================
//mark all product type to receive selected attribute option
//==============================================================================
function setMarkPty(chk)
{
	for(var i=0; i < arrProdTyId.length; i++)
	{
		document.getElementById("inpPTRcv" + i).checked = chk;
	}
}
//==============================================================================
//find selected option
//==============================================================================
function findSelOpt(search)
{	
	if(!search){ document.all.FndOpt.value = ""; }
	
	var opt = document.all.FndOpt.value.trim().toUpperCase();
	var fnd = false;
	var opts = new Array();
	
	for(var i=0; i < AttrOpt.length;i++)
	{
		var cell = document.getElementById("tdOpt" + i).innerHTML.toUpperCase();
		if(!search || search && cell.indexOf(opt) == 0)
		{ 
			document.getElementById("trOpt" + i).style.display="table-row"; 
		}
		else
		{
			document.getElementById("trOpt" + i).style.display="none";
		}
	}	
}
//==============================================================================
// add new attribute
//==============================================================================
function addNewAttr()
{	
	var hdr = "Create New Attribute";
	var html = "<table class='tbl01' >"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Small' colspan=2>" + popNewAttr("SaveNewAttr")
	     + "</td></tr>"
	   + "</table>"

	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "200";}
	else { document.all.dvItem.style.width = "auto";}
	   
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.left=getLeftScreenPos() + 230;
	document.all.dvItem.style.top=getTopScreenPos() + 100;
	document.all.dvItem.style.zIndex = "50";
	document.all.dvItem.style.visibility = "visible";	   
}
//==============================================================================
//populate order list for selected status
//==============================================================================
function popNewAttr(action)
{
	var panel = "<table class='tbl01' >";
	panel += "<tr class='trHdr02'>"
  	    + "<th class='th30' nowrap>"
  	      + "Attribute Name: <input size='55' maxlength='50' id='Attr' name='Attr'>"  	      
  	    + "</th>"
  	  + "</tr>"
  	  
  	  + "<tr class='trHdr02'>"
	    + "<th class='th30' nowrap>"
	      //+ "Attribut Type: "
	      //List, Text box, Text area, Yes/No, Date
	      //+ "<input type='radio' id='AttrType' name='AttrType' value='List' checked>List &nbsp;"
	      
	      //+ "<input type='radio' id='AttrType' name='AttrType' value='Text box'>Text box&nbsp;"
	      //+ "<input type='radio' id='AttrType' name='AttrType' value='Text area'>Text area&nbsp;"
	      //+ "<input type='radio' id='AttrType' name='AttrType' value='Yes/No'>Yes/No&nbsp;"
	      //+ "<input type='radio' id='AttrType' name='AttrType' value='Date'>Date&nbsp;"
	    + "</th>"
	  + "</tr>"
  	  
  	panel += "<tr class='trDtl04'><td class='tdError' id='tdError'></td></tr>";
	 
	panel += "<tr class='trDtl03'>"
	   + "<td nowrap class='td18' colspan=10>"
	   + "<button class='Small' onclick='vldAttr(&#34;" + action + "&#34;);'>Submit</button>&nbsp;"
	   + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
	   + "</td></tr>"
	
	return panel;
}

//==============================================================================
//delete Attribute
//==============================================================================
function dltAttr(attr, fqn)
{
	var hdr = "Delete Attribute";
	var html = "<table class='tbl01' >"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Small' colspan=2>" + popDltAttr(attr, fqn, "DltAttr")
	     + "</td></tr>"
	   + "</table>"

	if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "200";}
	else { document.all.dvItem.style.width = "auto";}
	   
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.left=getLeftScreenPos() + 230;
	document.all.dvItem.style.top=getTopScreenPos() + 100;
	document.all.dvItem.style.zIndex = "50";
	document.all.dvItem.style.visibility = "visible";
	
	document.getElementById("Attr").value = attr;
	document.getElementById("AttrFQN").value = fqn;	 
}
//==============================================================================
//populate order list for selected status
//==============================================================================
function popDltAttr(attr, fqn, action)
{
	var panel = "<table class='tbl01' >";
	panel += "<tr class='trHdr02'>"
  	    + "<th class='th30' nowrap>"
  	      + "Attribute Name: <input size='55' maxlength='50' id='Attr' name='Attr' readonly>"
  	      + "<input size='55' maxlength='50' id='AttrFQN' name='AttrFQN' type='hidden'>"
  	    + "</th>"
  	  + "</tr>"
  	    	  
  	panel += "<tr class='trDtl04'><td class='tdError' id='tdError'></td></tr>";
	;
  	 
	panel += "<tr class='trDtl03'>"
	   + "<td nowrap class='td18' colspan=10>"
	   + "<button class='Small' onclick='vldAttr(&#34;" + action + "&#34;);'>Submit</button>&nbsp;"
	   + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
	   + "</td></tr>"
	
	return panel;
}

//==============================================================================
//validate option
//==============================================================================
function vldAttr(action)
{
	var error = false;
	var msg = "";
	var br = "";
	document.getElementById("tdError").innerHTML = "";
	
	var attr = document.getElementById("Attr").value.trim();
	if(attr == ""){error=true; msg = br + "Please enter the Attribute name."; br = "<br>";}
	else if(action != "DltAttr") 
	{
		for(var i=0; i < arrAttr.length; i++)
		{
			if(arrAttr[i].toUpperCase() == attr.toUpperCase())
			{
				error=true; msg = br + "Attribute name already exists."; br = "<br>";
				break;
			}
		}
	}
		
	if(action == "DltAttr"){ attr = document.getElementById("AttrFQN").value.trim(); }
	
	var type = "List";
	/* for future use
	if(action == "SaveNewAttr")
	{
		var typelst = document.all.AttrType;
		for(var i=0; i < typelst.length ;i++)
		{
			if(typelst[i].checked){ type = typelst[i].value; break;}
		}
	}
	*/
	if(error){ document.getElementById("tdError").innerHTML = msg; }
	else{ sbmAttr(attr, type, action); }
}
//==============================================================================
//hide panel
//==============================================================================
function sbmAttr(attr, type, action)
{
	var url = "KiboAttrUpd.jsp?Site=11961"
		+ "&Attr=" + attr
		+ "&AttrType=" + type
		+ "&AttrIsProp=Y"
		+ "&Action=" + action
		+ "&User=<%=sUser%>"
	;
	window.frame1.location.href = url;
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
//hide panel
//==============================================================================
function hidePanel1()
{
	document.all.dvOpt.innerHTML = "";
	document.all.dvOpt.style.visibility = "hidden";
}
//==============================================================================
//reload page
//==============================================================================
function restart()
{
	url = "MozuAttrProdTypeMaint.jsp?LogSize=1";
	if(PosTo.trim() != " ")
	{ 
		url += "&PosTo=" + PosTo; 
	}
	
	window.location.href = url;
}
 


</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

<BODY onload="bodyLoad();">

<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvOpt" class="dvItem"></div>
<div id="dvLog" class="dvLog">Upload log</div>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!----------------- beginning of table ------------------------>  
<table id="tbl01" class="tbl01">
   <tr id="trTopHdr" style="background:ivory; ">
          <th align=center colspan=2>
            <b>Retail Concepts, Inc
            <br>Mozu - Attribute / Product Type maintenance
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="MozuSoldOutLstSel.jsp"><font color="red" size="-1">Select</font></a>&#62; 
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;                                                      
          </th>
        </tr> 
                
      <!-- ======================================================================= -->
      <tr id="trId" style="background:#FFE4C4;">
      	<th align=center valign="top">
    
    	   <table id="tbl01" class="tbl02">
           	<th class="th01" nowrap>No.</th>
           	<th class="th01" nowrap>Attribute
           	    <br><a href="javascript: addNewAttr()">Add New Attribute</a>
           	</th>
           	<th class="th01" nowrap>Is<br>Attribute<br>IP?</th>
           	<th class="th01" nowrap>To<br>Product<br>Type</th>
           	<th class="th01" nowrap>Attribute FQN</th>
           	<th class="th01" nowrap>Add/Update<br>Values</th>
           	<th class="th01" nowrap>&nbsp;</th>
           	<th class="th01" nowrap>Delete<br>Attribute</th>
        </tr> 
        <!----------------------- total line ------------------------>
               
<!------------------------------- Detail --------------------------------->        
        <% boolean bEven = true;        
        for(int i=0; i < sAttr.length; i++)
		{ 
            bEven = !bEven;             
         %>
         <tr id="trId<%=i%>" class="<%if(bEven) {%>trDtl06<%} else {%>trDtl04<%}%>">            
            <td class="td12" ><%=(i+1)%></td>
            <td class="td11"><%=sAttr[i]%></td>
            <td class="td18"><%=sAttrType[i]%></td>
            <td class="td18" ><a href="javascript: updAttrVal('<%=sAttr[i]%>','<%=sAttrFQN[i]%>', '<%=i%>', 'To PT', '<%=sAttrType[i]%>')">To PT</a></td>
            <td class="td11" ><%=sAttrFQN[i]%></td>
            <td class="td18" ><a href="javascript: updAttrVal('<%=sAttr[i]%>','<%=sAttrFQN[i]%>', '<%=i%>', 'Opt Maint', '<%=sAttrType[i]%>')">Upd</a></td>
            <td class="Separator06" nowrap>&nbsp;</td>
            <td class="td18" ><a href="javascript: dltAttr('<%=sAttr[i]%>','<%=sAttrFQN[i]%>')">Dlt</a></td>            
         </tr>  	
       <%}%>
	  </table>
             
      <!----------------------- end of table ------------------------>
    </th>
    <th align=center valign="top">  
      
      <!-- ======================================================================= -->
      <!-- ======================================================================= -->
      <!-- ======================================================================= -->
      
      
      <!----------------------- Product type list ------------------------>
      <table id="tbl01" class="tbl02">
                
      <!-- ======================================================================= -->
      <%
      sStmt = " select PMTYID, PMTYNM"
      	 	+ " from rci.MOPRDTYM"
      	 	+ " order by PMTYNM"
      ;
      //System.out.println(sStmt);
      	
      runsql = new RunSQLStmt();
      runsql.setPrepStmt(sStmt);
      rs = runsql.runQuery();
      Vector<String> vPType = new Vector<String>();
      Vector<String> vPTypeId = new Vector<String>();
      	
      while(runsql.readNextRecord())
      {            	
      	vPTypeId.add(runsql.getData("PMTYID").trim());
      	vPType.add(runsql.getData("PMTYNM").trim());
      }
      	
      String [] sPType = vPType.toArray(new String[]{});
      String [] sPTypeId = vPTypeId.toArray(new String[]{});            	 
     	runsql.disconnect();
      %>
      <tr id="trId" style="background:#FFE4C4;">
           <th class="th01" nowrap>Product Type<br>Id</th>
           <th class="th16" nowrap>Product Type</th> 
           <th class="th01" nowrap>Upd</th>          
      </tr> 
       <%
        for(int i=0; i < sPType.length; i++)
		{ 
            bEven = !bEven;             
         %>
         <tr id="trId" class="<%if(bEven) {%>trDtl06<%} else {%>trDtl04<%}%>">            
            <td class="td12" ><%=sPTypeId[i]%></td>
            <td class="td11" ><%=sPType[i]%></td>
            <td class="td11" ><a href="javascript: getPtAttr('<%=sPTypeId[i]%>', '<%=sPType[i]%>')">Upd</a></td>
               
            <script>arrProdTyId[arrProdTyId.length] = "<%=sPTypeId[i]%>"; arrProdTy[arrProdTy.length] = "<%=sPType[i]%>";</script>         
         </tr>  	
         <script></script>
       <%}%>
      
      
      </table>
      
   </table>
   <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

       
    </body>
</html>
<%
}
%>