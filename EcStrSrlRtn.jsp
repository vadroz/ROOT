<!DOCTYPE html>	
<%@ page import="ecommerce.EcStrSrlRtn, java.util.*, java.text.*"%>
<%
   String sSelCust = request.getParameter("Cust");
   String sSelOrd = request.getParameter("Order");
   String sSelSku = request.getParameter("Sku");
   String [] sSelSts = request.getParameterValues("Sts");
   String sFrDate = request.getParameter("FrDate");
   String sToDate = request.getParameter("ToDate");
   String sSort = request.getParameter("Sort");
   
   if(sSort == null){ sSort = "ORD"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=EcStrSrlRtn.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	EcStrSrlRtn srlretn = new EcStrSrlRtn(sSelCust, sSelOrd, sSelSku, sSelSts, sFrDate, sToDate, sSort, sUser);

	int iNumOfItm = srlretn.getNumOfItm();  
	
	String sSelStr = "ALL";
	String sStrAllowed = session.getAttribute("STORE").toString();
	if(!sStrAllowed.startsWith("ALL")){ sSelStr = sStrAllowed; }
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>Shipped Ord Stat</title>

<SCRIPT>

//--------------- Global variables -----------------------
var FrDate = "<%=sFrDate%>";
var ToDate = "<%=sToDate%>";
var Sort = "<%=sSort%>"
var User = "<%=sUser%>";
var SelStr = "<%=sSelStr%>";

var aItems = new Array();
var MxItem = 0;
var item = { ord:"", sku:"", cust:"", billNm:"", email:"", ups:"", desc:"", venNm:"", venSty:"" 
		, cls:"", ven :"", sty:"", clr:"", siz:"", srl: ""};
var srl = { id:"", str:"", fflSts:"", reason:"", rtnSts:"" };		

var aarg = new Array();
//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
// select/change return item  
//==============================================================================
function selRtnSrl(arg)
{
	item = aItems[arg];
	
	var hdr = "Order: " + item.ord + " &nbsp; &nbsp; SKU: " + item.sku;
	  var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popRtnSrlPanel(arg)
	     + "</td></tr>"
	   + "</table>"

	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.pixelLeft = document.documentElement.scrollLeft + 400;
	  document.all.dvItem.style.pixelTop = document.documentElement.scrollTop + 100;
	  document.all.dvItem.style.visibility = "visible";
	  
	  if(item.srl.reason != "")
	  {
		  var reas = document.all.Reas;
		  for(var i=0; i < reas.length; i++)
		  { 
			  if(reas.options[i].value == item.srl.reason){reas.selectedIndex = i; break;}
		  }
	  }
		  
	  if(item.srl.rtnSts=="")
	  { 
		  if(SelStr != "ALL"){ document.all.Str.value = SelStr; }
		  else{ document.all.Str.readOnly = false; }
	  }
	  else{ document.all.Str.value = item.srl.str; }
	  
	  // set return status
	  if(SelStr != "ALL"){ document.all.dvRtnSts.style.display = "none"; }
	  if(item.srl.rtnSts=="Processed"){ document.all.RtnSts.checked = true; }
	  if(SelStr == "ALL"){ document.all.trEmp.style.display = "none"; } 
}
//==============================================================================
//validate store status changes
//==============================================================================
function popRtnSrlPanel(arg)
{
	item = aItems[arg];
	var rtnsts = item.srl.rtnSts;
	if(rtnsts ==""){ rtnsts = "*** None ***"; } 
	
	var panel = "Scan Item: <input id='ScanSku' onkeypress='if (window.event.keyCode == 13) { searchScan(this.value.trim()); }' class='Small' maxlength=12 size=12>"
	
	panel += "<table class='tbl02'>"
	    + "<tr class='trDtl09'>"
		+ "<th class='th06'>"
			+ "SKU: " + item.sku
	 		+ "<br>UPS: " + item.ups
	 		+ "<br>Desc: " + item.desc
	 		+ "<br>Venodr: " + item.venNm
	 		+ "<br>Ven. Style: " + item.venSty
		+ "</th>"
		+ "<td class='td08'>"
			+ "<table class='tbl06'>"
				+ "<tr class='trDtl09'>"
					+ "<td class='td26'>S/N</td>"
					+ "<td class='td29'> &nbsp; &nbsp; &nbsp; <b>" + item.srl.id + "</b></td>"
				+ "</tr>"
				+ "<tr class='trDtl09'>"
					+ "<td class='td26'>Store</td>"
			    	+ "<td class='td29'><input name='Str'  readonly size=2 maxlength=2></td>"
			 	+ "</tr>"	
				+ "<tr class='trDtl09'>"
					+ "<td class='td26'>Reason</td>"
					+ "<td class='td29'><select name='Reas'>" 
							+ "<option value='None'>-- select reason --</option>"
	                 		+ "<option value='Changed Mind'>Changed Mind</option>"
	                 		+ "<option value='Damaged'>Damaged</option>"
	                 		+ "<option value='Wrong Size'>Wrong Size</option>"
	                 		+ "<option value='Wrong Color'>Wrong Color</option>"
	                 		+ "<option value='Price Error'>Price Error</option>"
	                 		+ "<option value='Miscellaneous Return'>Miscellaneous Return</option>"
							+ "</select>" 
				    + "</td>"
			   + "</tr>"
			   + "<tr class='trDtl09' id='trEmp'>"
		    		+ "<td class='td26'>Employee</td>"
		    		+ "<td class='td29'><input name='Emp' size=4 maxlength=4></td>"
		 	   + "</tr>"
		 	   + "<tr class='trDtl09'>"
	    	   		+ "<td class='td26'>Comment</td>"
	    	   		+ "<td class='td29'><TextArea name='Commt' cols=50 rows=4></TextArea></td>"
	 	   	   + "</tr>"
	panel += "<tr class='trDtl09'>"
	 		+ "<td class='td26' colspan=2><div id='dvRtnSts'>"
	 		+ "<input name='RtnSts' type='checkbox' value='Processed' readonly>Processed</div></td>"
	 	 + "</tr>"
	
	panel += "</table>"
		+ "</td>"
	  + "</tr>"
	
	panel += "<tr class='trDtl09'>"
		+ "<td class='tdError' id='tdError' colspan=2></td>"
	  + "</tr>";
	  
			
	panel += "<tr class='trDtl09'>"
    	+ "<td nowrap class='td09' colspan=2><button onClick='ValidateSrlRtn(&#34;" + arg + "&#34;)' class='Small'>Submit</button>"
    	+ " &nbsp; <button onClick='hidePanel();' class='Small'>Cancel</button>"
 	 + "</td></tr></table>"
 	 
	return panel;
}
//==============================================================================
//validate return entries 
//==============================================================================
function ValidateSrlRtn(arg)
{	
	item = aItems[arg];
	
	var error = false;
    var msg = "";
    var br = "";
    document.all.tdError.innerHTML = "";
    
    var reas = document.all.Reas.options[document.all.Reas.selectedIndex].value;
    if(reas=="None"){ error=true; msg = br + "Please select return Reason."; br = "<br>";}
    
    var str = document.all.Str.value;
    if(str=="" || eval(str)==0){ error=true; msg = br + "Please enter your Store number."; br = "<br>"; }
    else if(isNaN(str)){ error=true; msg = br + "Store number is not numeric."; br = "<br>"; }
    
    var emp = document.all.Emp.value.trim();
    if(SelStr != "ALL")
    {
    	if(emp==""){error = true; msg += br + "Please enter your employee number"; }
		else if(isNaN(emp)){error = true; msg += br + "The employee number is not numeric"; br = "<br>"; }
		else if (!isEmpNumValid(emp)){error = true; msg += br + "Employee number is invalid."; br = "<br>"; }
    }
    else{emp = "SAME"; }
    
	var commt = document.all.Commt.value;
	
	var rtnsts = "Submitted";		
	if(SelStr=="ALL")
	{
		if( document.all.RtnSts.checked)
		{
			rtnsts = document.all.RtnSts.value;	
		}
	}
	else
	{
		if(item.srl.rtnSts != ""){ rtnsts = item.srl.rtnSts; }
	}
	
	
	var action = "AddRtn";
	if(SelStr=="ALL"){ action = "UpdRtn";}
	
    if(error){ document.all.tdError.innerHTML = msg;}
    else{ sbmSrlRtn(arg, str, reas, emp, commt, rtnsts, action); }    
}
//==============================================================================
// submit return entries 
//==============================================================================
function sbmSrlRtn(arg, str, reas, emp, commt, rtnsts, action)
{
	item = aItems[arg];
	
	var nwelem = window.frame1.document.createElement("div");
	nwelem.id = "dvSbmStrSts"
	aSelOrd = new Array();

	var html = "<form name='frmChgSlrRtn'"
	 + " METHOD=Post ACTION='EcStrSlrRtnSv.jsp'>"
	 + "<input name='Site'>"
	 + "<input name='Ord'>"
	 + "<input name='Sku'>"
	 + "<input name='Srl'>"
	 + "<input name='Str'>"
	 + "<input name='Reas'>"
	 + "<input name='RtnSts'>"
	 + "<input name='Emp'>"
	 + "<input name='User'>"
	 + "<input name='Comment'>"
	 + "<input name='Action'>"
	html += "</form>"

	nwelem.innerHTML = html;
	window.frame1.document.body.appendChild(nwelem);

	window.frame1.document.all.Site.value = "SASS";
	window.frame1.document.all.Ord.value = item.ord;
	window.frame1.document.all.Sku.value = item.sku;
	window.frame1.document.all.Srl.value = item.srl.id;
	window.frame1.document.all.Str.value = str;	
	window.frame1.document.all.Reas.value = reas;
	window.frame1.document.all.RtnSts.value = rtnsts;
	window.frame1.document.all.Emp.value = emp;
	window.frame1.document.all.User.value = User;
	
	commt = commt.replace(/\n\r?/g, '<br />');
	window.frame1.document.all.Comment.value = commt;
	window.frame1.document.all.Action.value = action;
	
	window.frame1.document.frmChgSlrRtn.submit();
}
//==============================================================================
//check employee number
//==============================================================================
function isEmpNumValid(emp)
{
	var valid = true;
	var url = "EComItmAsgValidEmp.jsp?Emp=" + emp;
	var xmlhttp;
	// code for IE7+, Firefox, Chrome, Opera, Safari
	if (window.XMLHttpRequest){ xmlhttp=new XMLHttpRequest(); }
	// code for IE6, IE5
	else { xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}

	xmlhttp.onreadystatechange=function()
	{
 		if (xmlhttp.readyState==4 && xmlhttp.status==200)
 		{
  		valid = xmlhttp.responseText.indexOf("true") >= 0;
 		}
	}
	xmlhttp.open("GET",url,false); // synchronize with this apps
	xmlhttp.send();

return valid;
}
//==============================================================================
//retreive comment for selected store
//==============================================================================
function getStrCommt(arg)
{
	item = aItems[arg];
	
	url = "EComSrlAsgCommt.jsp?"
 	 + "Site=SASS"
  	 + "&Order=" + item.ord
 	 + "&Sku=" + item.sku
  	 + "&Str=" + item.srl.str
  	 + "&Action=GETSTRCMMT"

	window.frame1.location.href = url;
}

//==============================================================================
//display comment for selected store
//==============================================================================
function showComments(site, order, sku, serial, str, type, emp, commt, recusr, recdt, rectm)
{
	var hdr = "Logging Information. Order:" + order ;
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
  	 + "<tr>"
   	 	+ "<td class='BoxName' nowrap>" + hdr + "</td>"
     	+ "<td class='BoxClose' valign=top>"
      	  +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
     	+ "</td></tr>"
   	 + "<tr><td class='Prompt' colspan=2>" + popLog(type,emp, commt, recusr, recdt, rectm, str, serial)
  	 + "</td></tr>"
	+ "</table>"

	document.all.dvItem.style.width=600;
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 300;
	document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate log andcomments panel
//==============================================================================
function popLog(type,emp, commt, recusr, recdt, rectm, str, serial)
{
	var panel = "<table class='tbl02' id='tblLog'>"
 		+ "<tr class='trDtl09'>"
    		+ "<th class='th09'>Type</th>"
    		+ "<th class='th09'>S/N</th>"
   			+ "<th class='th09'>Store</th>"
    		+ "<th class='th09' nowrap>Emp #</th>"
    		+ "<th class='th09'>Comment</th>"
    		+ "<th class='th09'>Recorded by</th>"
 		+ "</tr>"
	for(var i=0; i < commt.length; i++)
	{
   		panel += "<tr class='trDtl09'>"
     		+ "<td class='td26' nowrap>" + type[i] + "</td>"
     		+ "<td class='td26' nowrap>" + serial[i] + "</td>"
   		if(str[i] != "0") { panel += "<td class='td26' nowrap>" + str[i] + "&nbsp;</td>" }
   		else{ panel += "<td class='td26' nowrap>H.O.&nbsp;</td>" }

   		panel += "<td class='td26' nowrap>&nbsp;" + emp[i] + "</td>"
     		+ "<td class='td26'>" + commt[i] + "</td>"
     		+ "<td class='td26' nowrap>" + recusr[i] + " " + recdt[i] + " " + rectm[i] + "</td>"
	}

	panel += "</table>"
 		+ "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
 		+ "<button onClick='printLog();' class='Small'>Print</button>"
 

return panel;
}
//==============================================================================
//open new window with Log 
//==============================================================================
function printLog()
{
	var tbl = document.all.tblLog.outerHTML;
	  var WindowOptions =
	   'width=600,height=500, left=100,top=50, resizable=yes , toolbar=yes, location=yes, directories=no, status=yes, scrollbars=yes,menubar=yes';
	var win = window.open("", "PrintLog", WindowOptions);
	
	var hdr  = '<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />'
	 + '<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">'
	 win.document.write(hdr);
	 win.document.write(tbl);
	
	hidePanel();
}

//==============================================================================
// select Print serials
//==============================================================================
function selPrtSrl(arg)
{
	var selitm = aItems[arg];
	aarg = new Array();
	// get list of return itemfor current orders
	for(var i=0; i < aItems.length; i++)
	{
		item = aItems[i];
		if(selitm.ord == item.ord && item.srl.rtnSts!="")
		{ 
			aarg[aarg.length] = i;
		}		
	}		
	var hdr = "Order:" + selitm.ord;
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
  	 + "<tr>"
   	 	+ "<td class='BoxName' nowrap>" + hdr + "</td>"
     	+ "<td class='BoxClose' valign=top>"
      	  +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
     	+ "</td></tr>"
   	 + "<tr><td class='Prompt' colspan=2>" + popPrtSrlPanel()
  	 + "</td></tr>"
	+ "</table>"

	document.all.dvItem.style.width=600;
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 300;
	document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate log andcomments panel
//==============================================================================
function popPrtSrlPanel()
{	
	var panel = "<table class='tbl02' id='tblLog'>"
 		+ "<tr class='trDtl09'>"
 		    + "<th class='th09'>Check</th>"
    		+ "<th class='th09'>SKU</th>"
    		+ "<th class='th09'>UPS</th>"
    		+ "<th class='th09'>Description</th>"
    		+ "<th class='th09'>S/N</th>"
    		+ "<th class='th09'>Reason</th>"    		
 		+ "</tr>"
	for(var i=0; i < aarg.length; i++)
	{
		item = aItems[aarg[i]];
		panel += "<tr class='trDtl09'>"
			+ "<td class='td26' nowrap><input name='Prt" + i + "' type='checkbox' value='" + i + "' checked></td>"
     		+ "<td class='td26' nowrap>" + item.sku + "</td>"
     		+ "<td class='td26' nowrap>" + item.ups + "</td>"
     		+ "<td class='td26' nowrap>" + item.desc + "</td>"
     		+ "<td class='td26' nowrap>" + item.srl.id + "</td>"
     		+ "<td class='td26' nowrap>" + item.srl.reason + "</td>"
     	  + "</tr>";	
   	}
 		
	panel += "</table>"
 		+ "<button onClick='hidePanel();' class='Small'>Close</button>&nbsp;"
 		+ "<button onClick='vldPrtSrl();' class='Small'>Print</button>"
 
 		

	return panel;
}

//==============================================================================
//validate serial number selected to print 
//==============================================================================
function vldPrtSrl()
{
	var error = false;
	var msg = "";
	var chk = false;
	var asel = new Array();
	for(var i=0; i < aarg.length; i++)
	{
		var inp = "Prt" + i;
		if(document.all[inp].checked)
		{
			chk = true;
			item = aItems[aarg[i]];
			asel[asel.length] = item; 
		}
	}
	
	if(!chk){ error=true; msg += "Please check at least 1 item that you want to print."; }
	
	if(error){ alert(msg);}
	else{ sbmPrtSrl(asel); }
}
//==============================================================================
// submit selected serial number to print 
//==============================================================================
function sbmPrtSrl(asel)
{	
	aSelOrd = new Array();

	var url = "EcPrtSlrRtn.jsp?Site=SASS"
	 + "&Ord=" + item.ord
	for(var i=0; i < asel.length; i++)
	{
		item = asel[i];
		url += "&Sku=" + item.sku
		 + "&Ups=" + item.ups
		 + "&Str=" + SelStr
		 + "&Srl=" + item.srl.id
		 + "&Desc=" + item.desc
		 + "&Reas=" + item.srl.reason;
	}
	
	window.location.href=url;
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
//reload page
//==============================================================================
function restart()
{
	window.location.reload();  
}
</SCRIPT>
<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>ECOM Item Return - Selection
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="EcStrSrlRtnSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02" >No.</th>
          <th class="th02" >Order</th>
          <th class="th02" >Customer</th>
          <th class="th02" >Billing<br>Name</th>          
          <th class="th02" >Order<br>Date</th>          
          <th class="th02" >SKU</th>
          <th class="th02" >R<br>t<br>n</th>
          <th class="th02" >UPS</th>
          <th class="th02" >Description</th>
          <th class="th02" >S/N</th>          
          <th class="th02" >FFL Status</th>
          <th class="th02" >L<br>o<br>g</th>
          <th class="th02" >Reason</th>
          <th class="th02" >P<br>r<br>t</th>
          <th class="th02" >Return<br>Status</th>
          <th class="th02" >Return<br>to Str</th>          
          <th class="th02" >Entered by User, Date, Time</th>
        </tr>
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06"; 
           %>
           <%for(int i=0; i < iNumOfItm; i++) {        	   
        	   srlretn.setItemLst();
               
        	   String sOrd = srlretn.getOrd();
               if(!sSvOrd.equals(sOrd) && sTrCls.equals("trDtl04")){ sTrCls = "trDtl06"; sSvOrd = sOrd; }
               else if(!sSvOrd.equals(sOrd) && sTrCls.equals("trDtl06")){ sTrCls = "trDtl04"; sSvOrd = sOrd; }
               
               String sCust  = srlretn.getCust();
               String sEMail  = srlretn.getEMail();
               String sBillNm  = srlretn.getBillNm();
               String sSku = srlretn.getSku();
               String sOrdDt  = srlretn.getOrdDt();
               String sCls  = srlretn.getCls();
               String sVen  = srlretn.getVen();
               String sSty  = srlretn.getSty();
               String sClr  = srlretn.getClr();
               String sSiz  = srlretn.getSiz();
               String sDesc  = srlretn.getDesc();
               String sVenNm  = srlretn.getVenNm();
               String sVenSty  = srlretn.getVenSty();
               String sUps  = srlretn.getUps();
               String sMaxSrl  = srlretn.getMaxSrl();
               
               srlretn.setNumOfSrl();               
               int iNumOfSrl = srlretn.getNumOfSrl();
           %>                           
<!------------------------------- s/n --------------------------------->
           <%for(int j=0; j < iNumOfSrl; j++) {
        	   srlretn.setSrlLst();
        	   String sSrl  = srlretn.getSrl();
        	   String sStr = srlretn.getStr();
        	   String sFflSts  = srlretn.getFflSts();
        	   String sReason  = srlretn.getReason();
        	   String sRtnSts  = srlretn.getRtnSts();       
        	   String sEntUsr  = srlretn.getEntUsr();
        	   String sEntDt  = srlretn.getEntDt();
        	   String sEntTm  = srlretn.getEntTm();
        	   String sRtnStr  = srlretn.getRtnStr();
        	   String sEmp  = srlretn.getEmp();
        	   String sEmpNm  = srlretn.getEmpNm();
           %>
                <tr id="trId" class="<%=sTrCls%>">
                <td class="td11" nowrap><%=i+1%></td>
                <td class="td11" nowrap><a href="EComOrdInfo.jsp?Site=SASS&Order=<%=sOrd%>" target="_blank"><%=sOrd%></a></td>
                <td class="td11" nowrap><%=sCust%></td>
                <td class="td11" nowrap><%=sBillNm%></td>
                <td class="td11" nowrap><%=sOrdDt%></td>
                <td class="td11" nowrap><%=sSku%></td>
                <td class="td11" nowrap>
                	<%if(sSelStr.equals("ALL") || sRtnSts.equals("")){%><a href="javascript: selRtnSrl('<%=i%>')">R</a><%}%>
                </td>
                <td class="td11" nowrap><%=sUps%></td>
                <td class="td11" nowrap><%=sDesc%></td>                
                <td class="td12" nowrap><%=sSrl%></td>                
                <td class="td11" nowrap><%=sFflSts%></td>
                <td class="td11" nowrap><a href="javascript: getStrCommt('<%=i%>')">L</a></td>
                <td class="td11" nowrap><%=sReason%></td>
                <td class="td11" nowrap>&nbsp;
                  <%if(!sRtnSts.equals("")){%><a href="javascript: selPrtSrl('<%=i%>')">P</a><%}%>&nbsp;
                </td>
                <td class="td11" nowrap><%=sRtnSts%></td>
                <td class="td12" nowrap><%=sRtnStr%></td>
                <td class="td11" nowrap><%if(!sRtnSts.equals("")){%><%=sEmp%>-<%=sEmpNm%>, <%=sEntDt%> <%=sEntTm%><%}%>&nbsp;</td>                                                               
              </tr>
              <script>                 		
                 srl = { id:"<%=sSrl%>", str:"<%=sStr%>", fflSts:"<%=sFflSts%>", reason:"<%=sReason%>"
                	, rtnSts:"<%=sRtnSts%>"};                 
                 
                 item = { ord:"<%=sOrd%>", sku:"<%=sSku%>", cust:"<%=sCust%>", billNm:"<%=sBillNm%>"
               	  , email:"<%=sEMail%>", ups:"<%=sUps%>", desc:"<%=sDesc%>", venNm:"<%=sVenNm%>"
               	  , venSty:"<%=sVenSty%>", cls:"<%=sCls%>", ven:"<%=sVen%>", sty:"<%=sSty%>"
               	  , clr:"<%=sClr%>", siz:"<%=sSiz%>", srl:srl};             		
                 
                 aItems[MxItem] = item;                 
                 MxItem++;
              </script>	
             <%}%>
           <%}%>           
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
srlretn.disconnect();
srlretn = null;
}
%>