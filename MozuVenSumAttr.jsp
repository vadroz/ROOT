<%@ page import="mozu_com.MozuVenSumAttr, rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sSite = request.getParameter("Site");
   String sSelVen = request.getParameter("Ven");
   String sSort = request.getParameter("Sort");
   String [] sSelAttr = request.getParameterValues("Attr");
   
   
   if(sSelVen == null){ sSelVen = "ALL"; }
   if(sSort == null){ sSort = "VEN"; }
   if(sSelAttr == null){ sSelAttr = new String[]{ "2", "3"}; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MozuVenSumAttr.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	
	if(sSite == null)
	{ 
		String sStmt = null;
	    RunSQLStmt runsql = new RunSQLStmt();
	    ResultSet rs = null;
	    
	    sStmt = "select BxSite from RCI.MOSNDBX";           
		runsql = new RunSQLStmt();
		runsql.setPrepStmt(sStmt);
		rs = runsql.runQuery();
		if(runsql.readNextRecord())
		{
			sSite = runsql.getData("BxSite");
		}	
		rs.close();
		runsql.disconnect();
	}
	
	String sUser = session.getAttribute("USER").toString();
	
	MozuVenSumAttr vensum = new MozuVenSumAttr();
	System.out.println(sSite + " " + sSelVen + " " + sSelAttr[0]);
	vensum.setAttrByCls(sSite,  sSelVen,sSelAttr, sSort);
	int iNumOfVen = vensum.getNumOfVen();
	String sAttrJsa = vensum.cvtToJavaScriptArray(sSelAttr);
	
	String sMWSel = "7";
	/*if(sSelAttr.length == 1){ sMWSel = sSelAttr[0]; }
	else if(sSelAttr.length == 2 && sSelAttr[0].equals("2") && sSelAttr[1].equals("3")){ sMWSel = "7"; }
	else if(sSelAttr.length == 2 && sSelAttr[0].equals("0") && sSelAttr[1].equals("2")){ sMWSel = "8"; }
	else if(sSelAttr.length == 2 && sSelAttr[0].equals("0") && sSelAttr[1].equals("3")){ sMWSel = "A"; }
	else if(sSelAttr.length == 3){ sMWSel = "7"; }
	*/
	String sMWSel1 = "6";
	/*if(sSelAttr.length == 1){ sMWSel1 = sSelAttr[0]; }
	else if(sSelAttr.length == 2 && sSelAttr[0].equals("2") && sSelAttr[1].equals("3")){ sMWSel1 = "6"; }
	else if(sSelAttr.length == 2 && sSelAttr[0].equals("0") && sSelAttr[1].equals("2")){ sMWSel1 = "8"; }
	else if(sSelAttr.length == 2 && sSelAttr[0].equals("0") && sSelAttr[1].equals("3")){ sMWSel1 = "A"; }
	else if(sSelAttr.length == 3){ sMWSel1 = "7"; }
	*/
%>
 
<HTML>
<HEAD>
<title>Vendor Attribution Attribution</title>

<META content="RCI, Inc." name="Mozu"></HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        
        
        table.tbl01 { padding: 0px; border-spacing: 0; border-collapse: collapse; width:100%}
        
        th.DataTable { padding:3px; text-align:center; vertical-align:top}
        th.DataTable1 { cursor:hand; color: blue; background:#FFCC99;padding- top:3px; padding-bottom:3px;
                       text-align:center; font-size:11px; text-decoration: underline;}
        
        tr.DataTable { background: #E7E7E7; font-size:12px }
        tr.DataTable1 { background: CornSilk; font-size:12px }
        tr.DataTable2 { background: white; font-size:12px }
        tr.DataTable3 { background: #FFCC99; font-size:12px }
        tr.DataTable4 { background: LimonChiffon; font-size:12px }
        tr.DataTable5 { background: #FFCC99; font-size:16px }

        td.DataTable { padding:3px; text-align:center; white-space:}
        td.DataTable1 { padding:3px; text-align:left; white-space:}
        td.DataTable2 { padding:3px; text-align:right; white-space:}
        td.DataTable01 { cursor:hand;padding:3px; text-align:center; white-space:}
        td.DataTable02 { cursor:hand;padding:3px; text-align:left; white-space:}
        
        td.Space01 { background: #FFCC99; text-align:left;}

        select.Small {font-size:10px }
        input.Small {margin-top:3px;  font-size:10px }
        button.Small {margin-top:3px; font-size:10px }
        textarea.Small { font-size:10px }
        
        div.dvItem { position:absolute; visibility: hidden; background-attachment: scroll;
              border: black solid 1px; width:50; background-color:LemonChiffon; z-index:100;
              text-align:center; vertical-align:top; font-size:10px}

        div.dvSelect { position: absolute; background-attachment: scroll;
              border: black solid 2px; width:250px; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:12px}
              
        div.dvAttr { position: absolute;  top: expression(this.offsetParent.scrollTop+10); left:20px; background-attachment: scroll;
              border: black solid 2px; width:350px; background-color:LemonChiffon; z-index:50;
              text-align:center; font-size:10px}

        td.BoxName {cursor:move;
              filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=1,startColorStr=MidnightBlue, endColorStr=#a0cfec);
              color:white; text-align:center; font-family:Arial; font-size:12px; font-weight:bold}
        td.BoxClose {cursor:hand;background:#a0cfec;
               color:white; text-align:right; font-family:Arial; font-size:12px; }

        td.Cell {font-size:12px; text-align:right; vertical-align:top}
        td.Cell1 {font-size:12px; text-align:left; vertical-align:top}
        td.Cell2 {font-size:12px; text-align:center; vertical-align:top; font-weight:bold;text-decoration:underline}
</style>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<script name="javascript1.2">
//==============================================================================
// Global variables
//==============================================================================
var Site = "<%=sSite%>";
var aDaAsset = new Array();
var aImgAsset = new Array();
var aCoop = new Array();
var aPty = new Array();
var SelVen = null;
var SelVenNm = null;
var SelDays = null;
var SelAttr = [<%=sAttrJsa%>];
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) 
	{
		isSafari = true;
	}
    setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvHist"]);
    setAttr();
}
//==============================================================================
//show fedex data
//==============================================================================
function addNote(ven, type )
{
	var hdr = "Add ";
	if(type=="DAASSET"){ hdr += "Data Asset"; }
	else if(type=="IMGASSET"){ hdr += "Image Asset"; }
	else if(type=="COOP"){ hdr += "COOP Amount"; }
	else if(type=="PRIORITY"){ hdr += "Priority"; }
	hdr += ". Vendor: " + ven; 
	
	   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popNote(ven, type  )
	       + "</td></tr>"
	     + "</table>"

	  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "500";}
	  else { document.all.dvItem.style.width = "auto";}
	     
	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.left = getLeftScreenPos() + 300;
	  document.all.dvItem.style.top = getTopScreenPos() + 150;
	  document.all.dvItem.style.visibility = "visible";
	  
	  document.all.Ven.value = ven;
	  document.all.Type.value = type;
	  
	}
//==============================================================================
// set selected attributes 
//==============================================================================
function setAttr()
{
	var attr = document.all.Attr;
	for(var i=0; i < attr.length;i++)
	{
		for(var j=0; j < SelAttr.length; j++)
		{
			if(attr[i].value == SelAttr[j]){ attr[i].checked=true; }
		}
	}
}
//==============================================================================
//check selected attributes 
//==============================================================================
function setAttrChk(chk)
{
	var attr = document.all.Attr;
	
	if(chk == '0' && attr[0].checked){ attr[1].checked=false; attr[2].checked=false; }
	else if(chk != '0' && (attr[1].checked || attr[2].checked)){ attr[0].checked=false;}
}
//==============================================================================
// populate panel
//==============================================================================
function popNote(ven, type)
{		   
	   var panel = "<table class='tbl01' id='tblLog'>"
	    + "<tr>"
	       + "<td class='td08'>";
	    if(type=="DAASSET" || type=="IMGASSET")
	    {
	    	panel += "<TextArea class='Small' name='Note' cols=100 rows=10></TextArea>";
	    }
	    else  
	    { 
	    	panel += "<input name='Note' maxlength=10 size=10>"
	    }	    
	    
	    panel += "<input type='hidden' name='Ven'>";
	    panel += "<input type='hidden' name='Type'>";
	    panel += "</td>";	       
	    panel += "</tr>";  
	    
		panel += "</table> <br/>";
	    panel += "<tr>"
		  + "<td id='tdError' class='Small' colspan=2 style='color:red;font-size:12px;'></td>"
		   + "</tr>";
		   
	    panel += "</table>"
	        + "<button onClick='vldNote();' class='Small'>Save Changes</button>&nbsp; &nbsp;"
	        + "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
	    ;
	        
		return panel;
	}
	//==============================================================================
	//validate new value
	//==============================================================================
	function vldNote()
	{
		var error = false;
	  	var msg = "";
	  	document.all.tdError.innerHTML="";

	  	var ven = document.all.Ven.value.trim();
	  	var type = document.all.Type.value;
	  	var note = document.all.Note.value;
	  	
	  	if(error){ document.all.tdError.innerHTML=msg; }
	  	else{ sbmNote(ven, type, note); }
	}
	//==============================================================================
	//submit store status changes
	//==============================================================================
	function sbmNote(ven, type, note)
	{
		note = note.replace(/\n\r?/g, '<br />');
		
	  	var nwelem = window.frame1.document.createElement("div");
	  	nwelem.id = "dvSbmVen"
	  	
	  	var html = "<form name='frmAddNote'"
	     + " METHOD=Post ACTION='MozuVenSumAttrSv.jsp'>"
	     + "<input name='Site'>"
	     + "<input name='Ven'>"
	     + "<input name='Type'>"
	     + "<input name='Note'>"       
	     + "<input name='Action'>"

	  	html += "</form>"
	  		
	  	nwelem.innerHTML = html;
	  	window.frame1.document.body.appendChild(nwelem);

	  	window.frame1.document.all.Site.value = Site;
	  	window.frame1.document.all.Ven.value = ven;
	  	window.frame1.document.all.Type.value = type;
	  	window.frame1.document.all.Note.value = note;
	  	window.frame1.document.all.Action.value="ADD";
	  
	  	window.frame1.document.frmAddNote.submit();
	}
	//==============================================================================
	//Hide selection screen
	//==============================================================================
	function hidePanel()
	{
		document.all.dvItem.innerHTML = " ";
		document.all.dvItem.style.visibility = "hidden";
	}
	//==============================================================================
	// re-sort
	//==============================================================================
	function resort(sort)
	{
		var url = "MozuVenSumAttr.jsp?Site=<%=sSite%>&Ven=<%=sSelVen%>&Sort=" + sort;  
		
		for(var i=0; i < SelAttr.length; i++)
		{
			url += "&Attr=" + SelAttr[i];
		}		
		
		window.location.href = url;
	}
	//==============================================================================
	// show tooltip
	//==============================================================================
	function showToolTip(obj, data)
	{
		if(data != "")
		{			
			var html = data;
			var pos = getObjPosition(obj);
		
			if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvToolTip.style.width = "256";}
			else { document.all.dvToolTip.style.width = "auto";}
			document.all.dvToolTip.innerHTML = html;
			document.all.dvToolTip.style.pixelLeft = pos[0] + 50;
			document.all.dvToolTip.style.pixelTop =  pos[1] - 10;
			document.all.dvToolTip.style.visibility = "visible";
		}
		else
		{
			document.all.dvToolTip.style.visibility = "hidden";
		}
	}
	//==============================================================================
	// retreive log
	//==============================================================================
	function rtvLog(ven, type)
	{
		 var url = "MozuVenSumAttrLog.jsp?Site=<%=sSite%>" 
			+ "&Ven=" + ven 
			+ "&Type=" + type;
		 
		 window.frame1.location.href=url;
	}
	//==============================================================================
	// show log
	//==============================================================================
	function showLog(ven, type, note, recUsr, recDt, recTm)
	{ 	 
		 var hdr = "Vendor: " + ven + ". Log";
		 
		 var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
		     + "<tr>"
		       + "<td class='BoxName' nowrap>" + hdr + "</td>"
		       + "<td class='BoxClose' valign=top>"
		         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel1();' alt='Close'>"
		       + "</td></tr>"
		     + "<tr><td class='Prompt' colspan=2>" + popLog( type, note, recUsr, recDt, recTm )
		       + "</td></tr>"
		     + "</table>"

		 if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvHist.style.width = "500";}
		 else { document.all.dvHist.style.width = "auto";}
		     
		 document.all.dvHist.innerHTML = html;
		 document.all.dvHist.style.left = getLeftScreenPos() + 300;
		 document.all.dvHist.style.top = getTopScreenPos() + 350;
		 document.all.dvHist.style.visibility = "visible";
	}
	//==============================================================================
	// populate panel
	//==============================================================================
	function popLog(type, note, recUsr, recDt, recTm)
	{		   
	   var panel = "<table class='tbl01' border=1 id='tblLog'>"
	    + "<tr class='DataTable3'>"
	       + "<th class='DataTable'>Type</th>"
	       + "<th class='DataTable'>Note</th>"
	       + "<th class='DataTable'>Record Stamp</th>" 
	    + "</tr>";
		
	    for(var i=0; i < type.length; i++)
		{
			panel += "<tr class='DataTable1'>"
			   + "<td class='DataTable1'>" + type[i] + "</td>"
			   + "<td class='DataTable1'>" + note[i] + "</td>"
			   + "<td class='DataTable1'>" + recUsr[i] + ", " + recDt[i] + ", " + recTm[i] + "</td>"
			 + "</tr>"
		}
	    
	    panel += "<tr class='DataTable1'>"
			   + "<td class='DataTable' colspan=3><button onClick='hidePanel1();' class='Small'>Close</button>&nbsp;</td>"
	    
	    panel += "</table>"	       
	        
	    ;
		        
		return panel;
	}
	//==============================================================================
	// retreive List of PO
	//==============================================================================
	function rtvPoNum(ven, vennm, days)
	{
		SelVen = ven;
		SelVenNm = vennm;
		SelDays = days;
		
		var url = "RtvPoListByDays.jsp?Ven=" + ven;
		if(days == "30"){ url += "&From=-90&To=30";}
		else if(days == "60"){ url += "&From=30&To=60";}
		else if(days == "90"){ url += "&From=60&To=90"; }
		window.frame1.location.href=url;
	}
	//==============================================================================
	// show PO Summary LIst
	//==============================================================================
	function showPoNum(poNum, div, divNm, antDt, qty, ret, po_num_prnt)
	{		
		var hdr = "Vendor: " + SelVen + " - " + SelVenNm + "  Days: " + SelDays;
		 
		 var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
		     + "<tr>"
		       + "<td class='BoxName' nowrap>" + hdr + "</td>"
		       + "<td class='BoxClose' valign=top>"
		         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel1();' alt='Close'>"
		       + "</td></tr>"
		     + "<tr><td class='Prompt' colspan=2>" + popPoNum( poNum, div, divNm, antDt, qty, ret, po_num_prnt )
		       + "</td></tr>"
		     + "</table>"

		 if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvHist.style.width = "500";}
		 else { document.all.dvHist.style.width = "auto";}
		 document.all.dvHist.innerHTML = html;
		 document.all.dvHist.style.left = getLeftScreenPos() + 300;
		 document.all.dvHist.style.top = getTopScreenPos() + 100;
		 document.all.dvHist.style.visibility = "visible";
	}
	//==============================================================================
	// populate panel
	//==============================================================================
	function popPoNum( poNum, div, divNm, antDt, qty, ret, po_num_prnt )
	{		   
	   var panel = "<table class='tbl01' border=1 id='tblLog'>"
	    + "<tr class='DataTable3'>"
	       + "<th class='DataTable'>No.</th>"
	       + "<th class='DataTable'>PO Number</th>"
	       + "<th class='DataTable'>Div</th>"
	       + "<th class='DataTable'>Division Name</th>"
	       + "<th class='DataTable'>Anticipation<br>Date</th>"
	       + "<th class='DataTable'>Qty</th>"
	       + "<th class='DataTable'>Ret</th>"
	       + "<th class='DataTable'>Number<br>of Parents</th>"
	       
	    + "</tr>";
		
	    for(var i=0; i < poNum.length; i++)
		{
			panel += "<tr class='DataTable1'>"
			   + "<td class='DataTable1'>" + (i+1) + "</td>"
			   + "<td class='DataTable1'><a href='javascript: showPoItmAttr(&#34;" + poNum[i] + "&#34;)'>" + poNum[i] + "</a></td>"		
			   + "<td class='DataTable1'>" + div[i] + "</td>"
			   + "<td class='DataTable1'>" + divNm[i] + "</td>"
			   + "<td class='DataTable'>" + antDt[i] + "</td>"
			   + "<td class='DataTable2'>" + qty[i] + "</td>"
			   + "<td class='DataTable2'>" + ret[i] + "</td>"
			   + "<td class='DataTable2'>" + po_num_prnt[i] + "</td>"
			 + "</tr>"
		}
	    
	    panel += "<tr class='DataTable1'>"
			   + "<td class='DataTable' colspan=8><button onClick='hidePanel1();' class='Small'>Close</button>&nbsp;</td>"
	    
	    panel += "</table>"	       
	        
	    ;
		        
		return panel;
	}
	//==============================================================================
	//Hide selection screen
	//==============================================================================
	function hidePanel1()
	{
		document.all.dvHist.innerHTML = " ";
		document.all.dvHist.style.visibility = "hidden";
	}
//==============================================================================
// show Item for selected PO on Attribution page
//==============================================================================
function showPoItmAttr(po)
{
    url = "MozuParentLst.jsp?Div=ALL&Dpt=ALL&Cls=ALL&Ven=ALL&From=ALL&To=ALL&FromIP=ALL&ToIP=ALL" 
    	+ "&Site=<%=sSite%>&MarkDownl=0&Excel=N&Parent=&Pon="+ po 
    	+ "&ModelYr=&MapExpDt=&InvAvl=NONE&MarkedWeb=5&InvStr=ALL";
    var win = window.open(url);
}
//==============================================================================
// show parent list 
//==============================================================================
function showParentList(ven, web)
{
	url = "MozuParentLst.jsp?Div=ALL&Dpt=ALL&Cls=ALL&Ven=" + ven 
    	+ "&From=ALL&To=ALL&FromIP=ALL&ToIP=ALL&Site=<%=sSite%>&MarkDownl=0&Excel=N&Parent=&Pon=&ModelYr=&MapExpDt=&InvAvl=NONE"
    	+ "&MarkedWeb=" + web + "&InvStr=ALL"
    ;
	
	for(var i=0; i < SelAttr.length; i++)
	{
		url += "&Attr=" + SelAttr[i];
	}
	
    var win = window.open(url);
}
//==============================================================================
// show Item for selected PO on Attribution page
//==============================================================================
function setDiffattr()
{
	var attr = document.all.Attr;
	var aAttr = new Array();
	for(var i=0; i < attr.length;i++)
	{
		if(attr[i].checked){ aAttr[aAttr.length] = attr[i].value; }		
	}
	
	if(aAttr.length == 0)
	{
		alert("Please check at least one Item attribute.")
	}	
	else
	{
		url = "MozuVenSumAttr.jsp?Site=<%=sSite%>&Ven=<%=sSelVen%>&Sort=<%=sSort%>"
		for(var i=0; i < aAttr.length;i++)
		{
			url += "&Attr="	+ aAttr[i];	
		}		 
		window.location.href = url;
	}
}
</script>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

<BODY onload="bodyLoad();">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>

<!----------------- beginning of table ------------------------>          
      <table  border=1 cellPadding="0" cellSpacing="0">      
        <tr id="trTopHdr" class="DataTable5" style="z-index: 50; position: relative; top: expression(this.offsetParent.scrollTop-15);">
          <th colspan=45>
            <b>Retail Concepts, Incs
            <br>Mozu - Vendor Attribution Priority
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;
                          
          </th>
        </tr>
        
      <!-- ======================================================================= -->
      
              
      	<tr id="trId" class="DataTable3" style="z-index: 50; position: relative; top: expression(this.offsetParent.scrollTop-14);">
           <th class="DataTable" nowrap>No.</th>
           <th class="DataTable" nowrap>A<br>d<br>d</th>
           <th class="DataTable" nowrap><a href="javascript: resort('PTY')">Pty</a></th>           
           <th class="DataTable" id="tdhdr1" nowrap><a href="javascript: resort('VEN')">Vendor</a></th>
           <th class="DataTable" id="tdhdr10" nowrap><a href="javascript: resort('VENNM')">Vendor Name</a></th>
           <th class="DataTable" nowrap><a href="javascript: resort('ONHCNT')">Onhand<br>Count</a></th>
           <th class="DataTable" nowrap><a href="javascript: resort('ONHAND')">Onhand<br>Units</a></th> 
           <th class="DataTable" nowrap><a href="javascript: resort('ONHRET')">Onhand<br>Retail</a></th>
           <td class="Space01" nowrap>&nbsp;</td>
           <th class="DataTable" nowrap><a href="javascript: resort('PO30PRT')">PO Parent<br>Count<br>30 Days</a></th>
           <th class="DataTable" nowrap><a href="javascript: resort('PO60PRT')">PO Parent<br>Count<br>60 Days</a></th>
           <th class="DataTable" nowrap><a href="javascript: resort('PO90PRT')">PO Parent<br>Count<br>90 Days</a></th>
           <td class="Space01" nowrap>&nbsp;</td>
           <th class="DataTable" nowrap><a href="javascript: resort('PO30UNT')">PO Units<br>30 Days</a></th>
           <th class="DataTable" nowrap><a href="javascript: resort('PO30RET')">PO Ret<br>30 Days</a></th>
           <th class="DataTable" nowrap><a href="javascript: resort('PO60UNT')">PO Units<br>60 Days</a></th>
           <th class="DataTable" nowrap><a href="javascript: resort('PO60RET')">PO Ret<br>60 Days</a></th>
           <th class="DataTable" nowrap><a href="javascript: resort('PO90UNT')">PO Units<br>90 Days</a></th>
           <th class="DataTable" nowrap><a href="javascript: resort('PO90RET')">PO Ret<br>90 Days</a></th>           
           <td class="Space01" nowrap>&nbsp;</td>
           <th class="DataTable" nowrap><a href="javascript: resort('POTOTUNT')">Total<br>PO Units</a></th>
           <th class="DataTable" nowrap><a href="javascript: resort('POTOTRET')">Total<br>PO Retail</a></th>
           <td class="Space01" nowrap>&nbsp;</td>
           <th class="DataTable" nowrap><a href="javascript: resort('TOTONH')">Total<br>Unit</a></th>
           <th class="DataTable" nowrap><a href="javascript: resort('TOTRET')">Total<br>Retail</a></th>
           <th class="DataTable" nowrap><a href="javascript: resort('PARCNT')">Parent<br>Count</a></th>
           <th class="DataTable" nowrap><a href="javascript: resort('AVG')">Avg</a></th>
           <th class="DataTable" nowrap><a href="javascript: resort('PRC')">Prc</a></th>
           <td class="Space01" nowrap>&nbsp;</td>
           <!-- >th class="DataTable" nowrap>A<br>d<br>d</th>
           <th class="DataTable" nowrap>Data Asset</th>
           <th class="DataTable" nowrap>A<br>d<br>d</th>
           <th class="DataTable" nowrap>Image Asset</th>
           <th class="DataTable" nowrap>A<br>d<br>d</th>
           <th class="DataTable" nowrap>Coop</th>
           
           <th class="DataTable" nowrap>L<br>o<br>g</th -->           
        </tr> 
        <!----------------------- total line ------------------------>
         <%vensum.setTotal();
 		String sVen = vensum.getVen();
 		String sVenNm = vensum.getVenNm();
 		String sOnhUnt = vensum.getOnhUnt();
 		String sOnhRet = vensum.getOnhRet();
 		String sPo30Unt = vensum.getPo30Unt();
 		String sPo60Unt = vensum.getPo60Unt();
 		String sPo90Unt = vensum.getPo90Unt();
 		String sPo30Ret = vensum.getPo30Ret();
 		String sPo60Ret = vensum.getPo60Ret();
 		String sPo90Ret = vensum.getPo90Ret();
 		String sDaAsset = vensum.getDaAsset();
 		String sImgAsset = vensum.getImgAsset();
 		String sCoop = vensum.getCoop();
 		String sPty = vensum.getPty();
 		String sTotPoUnt = vensum.getTotPoUnt();
 		String sTotPoRet = vensum.getTotPoRet();
 		String sAvg = vensum.getAvg();
 		String sPrc = vensum.getPrc();
 		String sTotOnh = vensum.getTotOnh();
		String sTotRet = vensum.getTotRet(); 
		String sOnhPrtCnt = vensum.getOnhPrtCnt();
		String sPo30Prt = vensum.getPo30Prt();
		String sPo60Prt = vensum.getPo60Prt();
		String sPo90Prt = vensum.getPo90Prt();
		String sParentCnt = vensum.getParentCnt();
 		%>
 		
 		<tr id="trId" class="DataTable1" style="z-index: 50; position: relative; top: expression(this.offsetParent.scrollTop-13);">
            <td class="DataTable" nowrap>&nbsp;</td>
            <td class="DataTable" nowrap>&nbsp;</td>
            <td class="DataTable" nowrap><%=sPty%>&nbsp;</td>
            <td class="DataTable1" nowrap colspan=2><%=sVenNm%></td>
            <td class="DataTable" nowrap><%=sOnhPrtCnt%></td>
            <td class="DataTable" nowrap><%=sOnhUnt%></td>
            <td class="DataTable" nowrap>$<%=sOnhRet%></td>
            <td class="Space01" nowrap>&nbsp;</td>
            <td class="DataTable" nowrap><%=sPo30Prt%></td>
            <td class="DataTable" nowrap><%=sPo60Prt%></td>
            <td class="DataTable" nowrap><%=sPo90Prt%></td>
            <td class="Space01" nowrap>&nbsp;</td>
            <td class="DataTable" nowrap><%=sPo30Unt%></td>
            <td class="DataTable" nowrap>$<%=sPo30Ret%></td>
            <td class="DataTable" nowrap><%=sPo60Unt%></td>
            <td class="DataTable" nowrap>$<%=sPo60Ret%></td>
            <td class="DataTable" nowrap><%=sPo90Unt%></td>
            <td class="DataTable" nowrap>$<%=sPo90Ret%></td>            
            <td class="Space01" nowrap>&nbsp;</td>
            <td class="DataTable" nowrap><%=sTotPoUnt%></td>
            <td class="DataTable" nowrap>$<%=sTotPoRet%></td>
            <td class="Space01" nowrap>&nbsp;</td>
            <td class="DataTable" nowrap><%=sTotOnh%></td>
            <td class="DataTable" nowrap>$<%=sTotRet%></td>            
            <td class="DataTable" nowrap><%=sParentCnt%></td>
            <td class="DataTable" nowrap>$<%=sAvg%></td>            
            <td class="DataTable" nowrap>&nbsp;</td>
            <td class="Space01" nowrap>&nbsp;</td>
            <!-- >td class="DataTable" nowrap>&nbsp;</td>
            <td class="DataTable1" nowrap><%=sDaAsset%>&nbsp;</td>
            <td class="DataTable" nowrap>&nbsp;</td>
            <td class="DataTable1" nowrap><%=sImgAsset%>&nbsp;</td>
            <td class="DataTable" nowrap>&nbsp;</td>
            <td class="DataTable" nowrap><%=sCoop%>&nbsp;</td>            
            <td class="DataTable" nowrap>&nbsp;</td -->
        </tr>       
<!------------------------------- Detail --------------------------------->        
        <% boolean bEven = true;        
        for(int i=0; i < iNumOfVen; i++)
		{ 
			vensum.setDetail();
			sVen = vensum.getVen();
			sVenNm = vensum.getVenNm();
			String sVenNm1 = sVenNm;
			if(sVenNm.indexOf("\'") >= 0 ){sVenNm1 = sVenNm.replaceAll("\\\\", "");}
			
			sOnhUnt = vensum.getOnhUnt();
			sOnhRet = vensum.getOnhRet();
			sPo30Unt = vensum.getPo30Unt();
			sPo60Unt = vensum.getPo60Unt();
			sPo90Unt = vensum.getPo90Unt();
			sPo30Ret = vensum.getPo30Ret();
			sPo60Ret = vensum.getPo60Ret();
			sPo90Ret = vensum.getPo90Ret();
			sDaAsset = vensum.getDaAsset();
			sImgAsset = vensum.getImgAsset();
			sCoop = vensum.getCoop();
			sPty = vensum.getPty();
			sTotPoUnt = vensum.getTotPoUnt();
			sTotPoRet = vensum.getTotPoRet();
			sAvg = vensum.getAvg();
			sPrc = vensum.getPrc();
			sTotOnh = vensum.getTotOnh();
			sTotRet = vensum.getTotRet();
			sOnhPrtCnt = vensum.getOnhPrtCnt();
			sPo30Prt = vensum.getPo30Prt();
			sPo60Prt = vensum.getPo60Prt();
			sPo90Prt = vensum.getPo90Prt();
			sParentCnt = vensum.getParentCnt();
			
            bEven = !bEven;
         %>
         <tr id="trId" class="<%if(bEven) {%>DataTable<%} else {%>DataTable2<%}%>">
            <td class="DataTable" nowrap><%=i+1%></td>
            <td class="DataTable1" ><a href="javascript: addNote(<%=sVen%>,'PRIORITY')">P</a></td>
            <td class="DataTable" ><%=sPty%>&nbsp;</td>
            <td class="DataTable1" nowrap>
              <!--  a href="MozuParentLst.jsp?Div=ALL&Dpt=ALL&Cls=ALL&Ven=<%=sVen%>&From=ALL&To=ALL&FromIP=ALL&ToIP=ALL&Site=<%=sSite%>&MarkDownl=0&Excel=N&Parent=&Pon=&ModelYr=&MapExpDt=&InvAvl=NONE&MarkedWeb=<%=sMWSel%>&InvStr=ALL" target="_blank"><%=sVen%></a -->
              <a href="javascript: showParentList('<%=sVen%>', '<%=sMWSel%>')"><%=sVen%></a>
            </td>
            <td class="DataTable1" nowrap><%=sVenNm1%></td>            
            <td class="DataTable" nowrap>                 
                <a href="javascript: showParentList('<%=sVen%>', '<%=sMWSel1%>')"><%=sOnhPrtCnt%></a>                
            </td>
            <td class="DataTable2" nowrap><%=sOnhUnt%></td>
            <td class="DataTable2" nowrap>$<%=sOnhRet%></td>
            <td class="Space01" nowrap>&nbsp;</td>
            <td class="DataTable" nowrap><a href="javascript: rtvPoNum('<%=sVen%>','<%=sVenNm%>','30')"><%=sPo30Prt%></a></td>
            <td class="DataTable" nowrap><a href="javascript: rtvPoNum('<%=sVen%>','<%=sVenNm%>','60')"><%=sPo60Prt%></a></td>
            <td class="DataTable" nowrap><a href="javascript: rtvPoNum('<%=sVen%>','<%=sVenNm%>','90')"><%=sPo90Prt%></a></td>
            <td class="Space01" nowrap>&nbsp;</td>
            <td class="DataTable2" nowrap><%=sPo30Unt%></a></td>
            <td class="DataTable2" nowrap>$<%=sPo30Ret%></td>
            <td class="DataTable2" nowrap><%=sPo60Unt%></td>
            <td class="DataTable2" nowrap>$<%=sPo60Ret%></td>
            <td class="DataTable2" nowrap><%=sPo90Unt%></td>
            <td class="DataTable2" nowrap>$<%=sPo90Ret%></td>            
            <td class="Space01" nowrap>&nbsp;</td>
            <td class="DataTable2" nowrap><%=sTotPoUnt%></td>
            <td class="DataTable2" nowrap>$<%=sTotPoRet%></td>            
            <td class="Space01" nowrap>&nbsp;</td>
            <td class="DataTable2" nowrap><%=sTotOnh%></td>
            <td class="DataTable2" nowrap>$<%=sTotRet%></td>
            <td class="DataTable2" nowrap><%=sParentCnt%></td>
            <td class="DataTable2" nowrap>$<%=sAvg%></td>
            <td class="DataTable2" nowrap><%=sPrc%>%</td>
            <td class="Space01" nowrap>&nbsp;</td>
            <!-- >td class="DataTable1" nowrap><a href="javascript: addNote(<%=sVen%>,'DAASSET')">A</a></td>
            <td class="DataTable1" onmouseover="showToolTip(this, &#34;<%=sDaAsset%>&#34;)" ><%=vensum.getVisible(sDaAsset,25)%>&nbsp;</td>
            <td class="DataTable1" ><a href="javascript: addNote(<%=sVen%>,'IMGASSET')">I</a></td>
            <td class="DataTable1" onmouseover="showToolTip(this, &#34;<%=sImgAsset%>&#34;)"><%=vensum.getVisible(sImgAsset,25)%>&nbsp;</td>
            <td class="DataTable1" ><a href="javascript: addNote(<%=sVen%>,'COOP')">C</a></td>
            <td class="DataTable1" ><%=sCoop%>&nbsp;</td>
            
            <td class="DataTable1" ><a href="javascript: rtvLog(<%=sVen%>, 'ALL')">L</a></td -->
         
         	<script>
         	   aDaAsset[<%=i%>] = "<%=sDaAsset%>"; aImgAsset[<%=i%>] = "<%=sImgAsset%>";
         	   aCoop[<%=i%>] = "<%=sCoop%>"; aPty[<%=i%>] = "<%=sPty%>";         
         	</script>
         <%}%>
         </table>
             
      <!----------------------- end of table ------------------------>
      
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvToolTip" class="dvItem"></div>
<div id="dvHist" class="dvItem"></div>
<div class="dvAttr">
    <input name="Attr" type="checkbox" value="0" onclick="setAttrChk('0')">Non-Web Items &nbsp; &nbsp;
    <input name="Attr" type="checkbox" value="2" onclick="setAttrChk('1')">Web Items &nbsp; &nbsp;
    <input name="Attr" type="checkbox" value="3" onclick="setAttrChk('2')">Unattributed Web Items
    <br><button class="Small" onclick="setDiffattr()">Submit</button>
</div>
<!-------------------------------------------------------------------->
       
    </body>
</html>
<%
vensum.disconnect();
vensum = null;
}
%>
