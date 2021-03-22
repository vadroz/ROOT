<!DOCTYPE html>	
<%@ page import="mozu_com.MozuStockPriceAnlysis, java.util.*, java.text.*
, rciutility.RunSQLStmt, java.sql.ResultSet"%>  
<%
	String sSite = request.getParameter("Site");
	String sParent = request.getParameter("Parent");
	String sSelSku = request.getParameter("Sku");
	
	if(sSelSku == null){sSelSku = ""; }
	
if (session.getAttribute("USER")!=null)
{
	
	MozuStockPriceAnlysis itmlst = new MozuStockPriceAnlysis();
	if(sParent != null)
	{
		itmlst.setAttrByCls(sSite,  sParent);
	}
	
	int iNumOfMrk = itmlst.getNumOfMrk();
	String [] sMrk = itmlst.getMrk();
	
	int iNumOfStr = itmlst.getNumOfStr();
	String [] sStr = itmlst.getStr();
	String [] sStrMrk = itmlst.getStrMrk();		
	
	int iNumOfItm = itmlst.getNumOfItm();
	String sDiv = itmlst.getDiv();
	String sDpt = itmlst.getDpt();
	String sCls = itmlst.getCls();
	String sVen = itmlst.getVen();
	String sSty = itmlst.getSty();
	String sClr = itmlst.getClr();
	String sSiz = itmlst.getSiz();
	String sDesc = itmlst.getDesc();
	String sMfg = itmlst.getMfg();
	
	
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
<html>
<head>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<title>Kibo Stock Analysis</title>

<SCRIPT>
//--------------- Global variables -----------------------
var BegTime = "Current";
var ParentTotQty = null;
var Parent = <%if(sParent == null){%>null<%} else {%>"<%=sParent%>";<%}%>;

var SelSku = "<%=sSelSku%>";

var SbId = new Array();
<%for(int i=0; i < vSbId.size(); i++){%>SbId[<%=i%>] = "<%=vSbId.get(i)%>";<%}%>
var SbName = new Array();
<%for(int i=0; i < vSbName.size(); i++){%>SbName[<%=i%>] = "<%=vSbName.get(i)%>";<%}%>
var SbProdTest = new Array();
<%for(int i=0; i < vSbProdTest.size(); i++){%>SbProdTest[<%=i%>] = "<%=vSbProdTest.get(i)%>";<%}%>

var progressIntFunc = null;
var progressTime = 0;

//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)) 
	{
		isSafari = true;
	}
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   
    showMozuSandBox();
    
    
    if(SelSku != "") {setTableonSelPgm(); }
    
    dupTbl();
}

//==============================================================================
//set table on selected position
//==============================================================================
function dupTbl()
{
	var tbl = document.getElementById("tblCvsc");
	var div = document.getElementById("divCvsc1");
	div.innerHTML = tbl.outerHTML; 
}
//==============================================================================
//set table on selected position
//==============================================================================
function setTableonSelPgm()
{
	var w = $(window);
	
	var search = "tr" + SelSku;
	var row = window.document.all[search];
	row.style.backgroundColor= "yellow";
	
	var top = row.offsetTop;
	var winh = w.height() / 2;
	var pos = top - (-250) ; // - winh;
	w.scrollTop( pos );	
}

//==============================================================================
//link to PO info
//==============================================================================
function showMozuSandBox()
{
	var html = "<table border='0' width='100%' cellPadding='0' cellSpacing='0'>"
	  + "<tr class='trDtl02'>"
	     + "<td class='td08' nowrap>Sandbox:</td>"
	     + "<td class='td08' nowrap>&nbsp;"
	        + "<input name='SandBox' readOnly><br>"
	  + "</tr>"
	  + "<tr class='trDtl02'>"
		 + "<td class='td08' nowrap>&nbsp;</td>"
		 + "<td class='td08' nowrap>&nbsp;"
	        + "<select name='selSandBox' onchange='setSandBox(this)'> &nbsp; "	        
	     + "</td>"
	  + "</tr>"
	  
	  + "<tr class='trDtl02'>"
	     + "<td class='td08' nowrap>Parent:</td>"
	     + "<td class='td08' nowrap>&nbsp;"
	        + "<input name='Parent' maxlength=20 size=30>&nbsp;"
	        + "<button onclick='vldParent()'>Go</button>"
	     + "</td>"
	  + "</tr>"	  
	  
	html += "</table>"
	
	document.all.dvSelect.innerHTML = html;	
	document.all.dvSelect.style.left = "10px";
	document.all.dvSelect.style.top = "10px";
	document.all.dvSelect.style.width = "250px";
	
	// populate with sandbox
	document.all.selSandBox.options[0] = new Option("--- Select Sandbox ---","");
	for(var i=0, j=1; i < SbId.length; i++, j++)
	{
		document.all.selSandBox.options[j] = 
			new Option(SbId[i] + " - " + SbName[i] + " " + SbProdTest[i], SbId[i]);
	}
	document.all.SandBox.value = SbId[0];
}
//==============================================================================
// validate parent selection
//==============================================================================
function vldParent()
{
	var error = false;
	var msg = "";
	
	var site = document.all.SandBox.value;
	var parent = document.all.Parent.value.trim();
	if(parent == ""){error=true; msg="Please enter Parent";}
	
	//parent = parent.replace(/-/g, "");
	
	parent = setParent(parent);
		 
	if(error){ alert(msg); }
	else{ sbmStockAnalysis(site, parent); }
}
//==============================================================================
//set parent  - remove deshes 
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
	else {
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
//validate parent selection
//==============================================================================
function sbmStockAnalysis(site, parent)
{
	url = "MozuStockPriceAnlysis.jsp?Site=" + site 
	 + "&Parent=" + parent;
	window.location.href = url;
}
//==============================================================================
// send Price again to KIBO
//==============================================================================
function sendPriceAgain()
{
	url = "KiboCurrPrice.jsp?Parent=<%=sParent%>"
	window.frame1.location.href = url;	
	progressIntFunc = setInterval(function() {showWaitBanner() }, 1000); 
}
//==============================================================================
// get today update proce/stock history
//==============================================================================
function getTodayHist()
{
	url = "MozuUpdHist.jsp?Parent=<%=sParent%>"
	window.frame1.location.href = url;	
}
//==============================================================================
//set today update proce/stock history
//==============================================================================
function setUpdHist(par, prod, stock, msrp, price,sales, recdate,rectime)
{
	var hdr = "Today Stock/Price Update History";
	 
	 var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popUpdHist( par, prod, stock, msrp, price,sales,recdate,rectime )
	       + "</td></tr>"
	     + "</table>"

	 if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "500";}
	 else { document.all.dvItem.style.width = "auto";}
	     
	 document.all.dvItem.innerHTML = html;
	 document.all.dvItem.style.left = "300px";
	 document.all.dvItem.style.top = "100px";
	 document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
// populate panel
//==============================================================================
function popUpdHist(par, prod, stock, msrp, price,sales,recdate,rectime)
{		   
  	var panel = "<table class='tbl01' border=1 id='tblLog'>"
   		+ "<tr class='trHdr01'>"
      		+ "<th class='DataTable'>Product</th>"
	        + "<th class='DataTable'>Stock</th>"
	        + "<th class='DataTable'>MSRP</th>"
	        + "<th class='DataTable'>Price</th>"
	        + "<th class='DataTable'>Sales</th>"
	        + "<th class='DataTable'>Record<br>Date</th>"
	        + "<th class='DataTable'>Record<br>Time</th>" 
   		+ "</tr>";
	var cls = "trDtl06";
   	for(var i=0; i < prod.length; i++)
	{
		if(prod[i].length == 13)
		{
			if(cls=="trDtl06"){ cls = "trDtl04"; }
			else{cls = "trDtl06";}
		}
   		panel += "<tr class='" + cls + "'>"
		   + "<td class='td11'>" + prod[i] + "</td>"
		   + "<td class='td12'>" + stock[i] + "</td>"
		   + "<td class='td12'>" + msrp[i] + "</td>"		   
		   + "<td class='td12'>" + price[i] + "</td>"
		   + "<td class='td12'>" + sales[i] + "</td>"
		   + "<td class='td11'>" + recdate[i] + "</td>"
		   + "<td class='td11'>" + rectime[i] + "</td>"
		 + "</tr>"
		
	}
   
   	panel += "<tr class='DataTable1'>"
		   + "<td class='DataTable' colspan=6><button onClick='hidePanel();' class='Small'>Close</button>&nbsp;</td>"
   
   	panel += "</table>";
	        
	return panel;
}

//==============================================================================
// retreive session details
//==============================================================================
function setSsnDtl(ssn)
{
	url = "RtvSsnDtl.jsp?Ssn=" + ssn
	
	window.frame1.location.href = url;
}
//==============================================================================
// show session details
//==============================================================================
function showSsnDtl(cncpt, div, dpt, cls, ven, sty, clr, siz, ins)
{
	
	var hdr = "Today Stock/Price Update History";
	 
	 var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	     + "<tr><td class='Prompt' colspan=2>" + popSsn( cncpt, div, dpt, cls, ven, sty, clr, siz, ins )
	       + "</td></tr>"
	     + "</table>"

	 if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "500";}
	 else { document.all.dvItem.style.width = "auto";}
	     
	 document.all.dvItem.innerHTML = html;
	 document.all.dvItem.style.left = "300px";
	 document.all.dvItem.style.top = "100px";
	 document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate panel
//==============================================================================
function popSsn( cncpt, div, dpt, cls, ven, sty, clr, siz, ins )
{		   
 	var panel = "<table class='tbl01' border=1 id='tblLog'>"
  		+ "<tr class='trHdr01'>"
     		+ "<th class='DataTable'>Concept</th>"
	        + "<th class='DataTable'>Div</th>"
	        + "<th class='DataTable'>Dpt</th>"
	        + "<th class='DataTable'>Class</th>"
	        + "<th class='DataTable'>Vendor</th>"
	        + "<th class='DataTable'>Style</th>"
	        + "<th class='DataTable'>Color</th>"
	        + "<th class='DataTable'>Size</th>"
	        + "<th class='DataTable'>Instructions</th>"
  		+ "</tr>";
	var csscls = "trDtl06";
  	for(var i=0; i < prod.length; i++)
	{
		if(csscls=="trDtl06"){ csscls = "trDtl04"; }
		else{csscls = "trDtl06";}
		
  		panel += "<tr class='" + csscls + "'>"
		   + "<td class='td11'>" + div[i] + "</td>"
		   + "<td class='td12'>" + dpt[i] + "</td>"
		   + "<td class='td12'>" + cls[i] + "</td>"		   
		   + "<td class='td12'>" + ven[i] + "</td>"
		   + "<td class='td12'>" + sty[i] + "</td>"
		   + "<td class='td11'>" + clr[i] + "</td>"
		   + "<td class='td11'>" + siz[i] + "</td>"
		   + "<td class='td11'>" + ins[i] + "</td>"
		 + "</tr>"
		
	}
  
  	panel += "<tr class='DataTable1'>"
		   + "<td class='DataTable' colspan=6><button onClick='hidePanel();' class='Small'>Close</button>&nbsp;</td>"
  
  	panel += "</table>";
	        
	return panel;
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
//set KIBo price
//==============================================================================
function setKiboPrc()
{	
	clearInterval( progressIntFunc );
	document.all.dvWait.style.visibility = "hidden";
}
//==============================================================================
//show exist options for selection
//==============================================================================
function showWaitBanner()
{	
	progressTime++; 
	var html = "<table><tr style='font-size:12px;'>"
	html += "<td>Please wait...</td>";  
	
	for(var i=0; i < progressTime; i++)
	{ 
		html += "<td style='background:blue;'>&nbsp;</td><td>&nbsp;</td>";
	}
	html += "</tr></table>";
	
	if(progressTime >= 10){ progressTime=0; }
	
	document.all.dvWait.innerHTML = html;
	document.all.dvWait.style.height = "20px";
	document.all.dvWait.style.pixelLeft= document.documentElement.scrollLeft + 340;
	document.all.dvWait.style.pixelTop= document.documentElement.scrollTop + 205;
	document.all.dvWait.style.backgroundColor="#cccfff"
	document.all.dvWait.style.visibility = "visible";
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
<div id="dvSelect" class="dvSelect"></div>
<div id="dvWait" class="dvItem"></div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Mozu - Item Stock/Price Analysis             
            </b>            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font> 
              &nbsp; &nbsp; &nbsp; &nbsp; 
              <a href="javascript: getTodayHist()" class="Medium">Latest Sending History</a>
              &nbsp; &nbsp; &nbsp; &nbsp; 
              <a href="javascript: sendPriceAgain()" class="Medium">Send Price Again</a>
              &nbsp; &nbsp; &nbsp; &nbsp; 
              <a href="https://www.sunandski.com/p/<%=sParent%>" class="Medium" target="_blank">On-line</a>
                         
          </th>
        </tr>
    <%if(sParent != null){%>    
    <tr>
     <td>  
      <table class="tbl07" id="tblDtl">
        <tr class="trDtl04">
          <td class="td02">Division</td><td class="td32" nowrap><%=sDiv%></td>
          <td class="td02"><%for(int i=0; i < 10; i++){%>&nbsp;<%} %></th>
          <td class="td02">Department</td><td class="td32" nowrap><%=sDpt%></td>          
        </tr>
        
        <tr class="trDtl04">
          <td class="td02">Parent</td><td class="td33" nowrap>
             <%if(iNumOfItm > 0){%><%=sCls%>-<%=sVen%>-<%=sSty%><%}
             else {%><%=sParent%> <span style="color: red;">is not found</span><%}%>
          </td>
          <td class="td02">&nbsp;</td>
          <td class="td02">Description</td><td class="td32" nowrap><%=sDesc%></td>          
        </tr>
        
        <tr class="trDtl04">
          <td class="td02">Manufacturer</td><td class="td32"  colspan=4 nowrap><%=sMfg%></td>                              
        </tr>
        
        <tr class="trDtl08">
          <td class="td02">Allowed Qty</td><td id="tdPrtTotQty" class="td32"  colspan=4 nowrap></td>                              
        </tr> 
         
      </table>    
     </td>
    </tr>   
    
    <tr>
     <td>&nbsp;<br>
    <!-- ========== Start of SSN Table ========== -->
    <table class="tbl02" id="tblSsn">
        <tr class="trHdr01">
           <th class="th02" colspan="11">
           Price Sessions
           </th>
        </tr>
    	<tr class="trHdr01">
          <th class="th02">No.</th>
          <th class="th02">Session</th>
          <th class="th02">Low Effective<br>Date From</th>
          <th class="th02">High Effective<br>Date To</th>
          <th class="th02">Text</th>
          <th class="th02">Sts</th>
          <th class="th02">General<br>Markdown</th>
          <th class="th02">Approve By</th>
          <th class="th02">Approve Date</th>
          <th class="th02">Approve Time</th>
        </tr>    
    <%
    itmlst.setNumOfSsn();
	int iNumOfSsn = itmlst.getNumOfSsn();
	
	for(int i=0; i < iNumOfSsn; i++){
		itmlst.setSsn();
		String sSsnNum = itmlst.getSsnNum();
		String sSsnLowEffDt = itmlst.getSsnLowEffDt();
		String sSsnHighExpDt = itmlst.getSsnHighExpDt();
		String sSsnText = itmlst.getSsnText();
		String sSsnSts = itmlst.getSsnSts();
		String sSsnApprBy = itmlst.getSsnApprBy();
		String sSsnGenMkd = itmlst.getSsnGenMkd();
		String sSsnApprDt = itmlst.getSsnApprDt();
		String sSsnApprTm = itmlst.getSsnApprTm();
		
	%>	
	    <tr id="trId" class="trDtl04">
	      <td class="td12" nowrap><%=i+1%></td> 
          <td class="td11" nowrap><a href="javascript: setSsnDtl('<%=sSsnNum%>')"><%=sSsnNum%></a></td>
          <td class="td11" nowrap><%=sSsnLowEffDt%></td>
          <td class="td11" nowrap><%=sSsnHighExpDt%></td>
          <td class="td11" nowrap><%=sSsnText%></td>
          <td class="td11" nowrap><%=sSsnSts%></td>
          <td class="td11" nowrap><%=sSsnGenMkd%></td>
          <td class="td11" nowrap><%=sSsnApprBy%></td>
          <td class="td11" nowrap><%=sSsnApprDt%></td>
          <td class="td11" nowrap><%=sSsnNum%></td>
          <td class="td11" nowrap><%=sSsnApprTm%></td>
        </tr>
	<%}%>
    </table>
    <!-- ========== End of SSN Table ========== -->
     </td>
    </tr> 
    
    
    <!-- ============= CVS-C Recap ============ -->
    <tr>
     <td>&nbsp;<br>
      <div id="divCvsc1">
      </div>
      </td>
    </tr> 
    
    <!-- ============= Item Recap ============ -->
    <%
    itmlst.setNumOfToday();
    int iNumOfTod = itmlst.getNumOfTod();
    %>
    <tr>
     <td>&nbsp;<br>  
      <table class="tbl02" id="tblDtl">
        <tr class="trHdr08">
          <th class="th02" colspan=6>Stock/Price Sent Today in KIBO</th>
        </tr>
        <tr class="trHdr01">
          <th class="th02">Product</th>
          <th class="th02">Stock</th>
          <th class="th02">MSRP</th>
          <th class="th02">Price</th>
          <th class="th02">Sls</th>
          <th class="th02">Time</th>
        </tr>
             
    <!-- ============= End Item Recap ============ -->  
    <%for(int i=0; i < iNumOfTod; i++)
    {
    	itmlst.setToday();    	
    	String sTodProd = itmlst.getTodProd();
    	String sTodStock = itmlst.getTodStock();
    	String sTodMsrp = itmlst.getTodMsrp();
    	String sTodPrice = itmlst.getTodPrice();
    	String sTodSls = itmlst.getTodSls();
    	String sTodDate = itmlst.getTodDate();
    	String sTodTime = itmlst.getTodTime();
    %>
    	<tr id="trId" class="trDtl04">
           	<td class="td11"><%=sTodProd%></td>
           	<td class="td12"><%=sTodStock%></td>
           	<td class="td12"><%=sTodMsrp%></td>
           	<td class="td12"><%=sTodPrice%></td>
           	<td class="td12"><%=sTodSls%></td>
           	<td class="td12"><%=sTodTime%></td>
        </tr>   	
        
    <%}%>
    
    	</table>
    	
      </td>
    </tr> 
    <!-- ============= End Item Details ============ -->
    <tr>
     <td>&nbsp;<br>  
      <table class="tbl02" id="tblDtl">
        <tr class="trHdr01">
          <th class="th02">No.</th>
          <th class="th02">SKU</th>
          <th class="th02">Long Item Number</th>
          <th class="th02">Color<br>Name</th>
          <th class="th02">Size<br>Name</th>
          <th class="th02">Onhand</th>          
        </tr>       
<!------------------------------- Detail --------------------------------->
		<tbody id="tbDtl">
		<%for(int i=0; i < iNumOfItm; i++ )
		{ 
			itmlst.setDetail();			
			String sSku = itmlst.getSku();
			sClr = itmlst.getClr();
			String sClrNm = itmlst.getClrNm();
			sSiz = itmlst.getSiz();
			String sSizNm = itmlst.getSizNm();
			String sOnHand = itmlst.getOnHand();
			
			String [] sStrOnh = itmlst.getStrOnh();
			String [] sStrPend = itmlst.getStrPend();
			String [] sStrUncond = itmlst.getStrUncond();
			String [] sStrUnproc = itmlst.getStrUnproc();
			String [] sStrStsPick = itmlst.getStrStsPick();
			String [] sStrTotQty = itmlst.getStrTotQty();
			String [] sStrMinQty = itmlst.getStrMinQty();
			String [] sStrMinPrc = itmlst.getStrMinPrc();
			String [] sStrAlwQty = itmlst.getStrAlwQty();
			String [] sStrMosRtv = itmlst.getStrMosRtv();
			
			String sUnallocOrd = itmlst.getUnallocOrd();
			
			String [] sMrkMinQty = itmlst.getMrkMinQty();
			String [] sMrkMinPrc = itmlst.getMrkMinPrc();
			String [] sMrkQty = itmlst.getMrkQty();
			
			String sCmpMinQty = itmlst.getCmpMinQty();
			String sCmpMinPrc = itmlst.getCmpMinPrc();
			String sCmpQty = itmlst.getCmpQty();
			String sMrkTotQty = itmlst.getMrkTotQty();
		
			double dCmp = 0;
			double dMrk = 0;
			if(!sCmpQty.equals("")){ dCmp = Double.parseDouble(sCmpQty); }
			if(!sMrkTotQty.equals("")) { dMrk = Double.parseDouble(sMrkTotQty); }
			
			String sPassToMozu = sCmpQty;
			if(dCmp < dMrk){ sPassToMozu = sMrkTotQty; }
			
			
			// set child prices
			itmlst.setChlPrc();
			String sNoMap = itmlst.getNoMap();
			String sMap = itmlst.getMap();
			String sMapExpDt = itmlst.getMapExpDt();
			String sMsrp = itmlst.getMsrp();
			String sIpRet = itmlst.getIpRet();
			String sSls = itmlst.getSls();
			String sPrice = itmlst.getPrice();
			String sTempRet = itmlst.getTempRet();
			String sTempFrDt = itmlst.getTempFrDt();
			String sTempToDt = itmlst.getTempToDt();
			String sAltRet = itmlst.getAltRet();
			String sAltFrDt = itmlst.getAltFrDt();
			String sAltToDt = itmlst.getAltToDt();
			String sStrRet = itmlst.getStrRet();
			String [] sPrcEff = itmlst.getPrcEff();
			
			String sEffClr = "style=\"background:#ccffcc;\"";
			String sEffClr1 = "style=\"background:yellow;\"";
		%>
		   <tr  class="trDtl04" id="tr<%=sSku%>">
		      <td class="td12" nowrap><%=(i + 1)%></td>
		      <td class="td24" nowrap><%=sSku%></td>
		      <td class="td24" nowrap><%=sCls%><%=sVen%><%=sSty%>-<%=sClr%><%=sSiz%></td>
		      <td class="td24" nowrap><%=sClr%> - <%=sClrNm%></td>
		      <td class="td24" nowrap><%=sSiz%> - <%=sSizNm%></td>
		      <td class="td12" nowrap><%=sOnHand%></td>
           </tr>
           <tr id="trId" class="trDtl04">
           	<td class="td12" colspan=6>
           		<table class="tbl07" id="tblStrInv">
           		  <tr class="trHdr01">
           		  	<th id="trId" class="th12" colspan=<%=iNumOfStr+1%>>Stores</th>
           		  </tr>
           		  <tr id="trId" class="trDtl04"> 
           		  	<td class="td12" nowrap>Store</td>
           		  	<%for(int j=0; j < iNumOfStr;j++){%>
		            	<td class="td12" nowrap><%=sStr[j]%></td>		            
           		  	<%}%>
           		  </tr>
           		  <tr id="trId" class="trDtl07"> 
           		  	<td class="td12" nowrap>Market</td>
           		  	<%for(int j=0; j < iNumOfStr;j++){%>
		            	<td class="td12" nowrap><%=sStrMrk[j]%></td>		            
           		  	<%}%>
           		  </tr>
           		  <!-- ========== Store Onhand ================================ -->
           		  <tr id="trId" class="trDtl08"> 
           		  	<td class="td12" nowrap>Onhands</td>
           		  	<%for(int j=0; j < iNumOfStr;j++){%>
		            	<td class="td12" nowrap><%=sStrOnh[j]%></td>		            
           		  	<%}%>
           		  </tr>
           		  <!-- ========== Subtract unavailable ======================= -->
           		  <tr id="trId" class="trDtl10"> 
           		  	<td class="td12" nowrap>Pending</td>
           		  	<%for(int j=0; j < iNumOfStr;j++){%>
		            	<td class="td12" nowrap><%=sStrPend[j]%></td>		            
           		  	<%}%>
           		  </tr>
           		  <tr id="trId" class="trDtl10"> 
           		  	<td class="td12" nowrap>Exclusion</td>
           		  	<%for(int j=0; j < iNumOfStr;j++){%>
		            	<td class="td12" nowrap><%=sStrUncond[j]%></td>		            
           		  	<%}%>
           		  </tr>
           		  <tr id="trId" class="trDtl10"> 
           		  	<td class="td12" nowrap>MOS/RTV</td>
           		  	<%for(int j=0; j < iNumOfStr;j++){%>
		            	<td class="td12" nowrap><%=sStrMosRtv[j]%></td>		            
           		  	<%}%>
           		  </tr>
           		  <tr id="trId" class="trDtl10"> 
           		  	<td class="td12" nowrap>Unprocessed</td>
           		  	<%for(int j=0; j < iNumOfStr;j++){%>
		            	<td class="td12" nowrap><%=sStrUnproc[j]%></td>		            
           		  	<%}%>
           		  </tr>
           		  <tr id="trId" class="trDtl10"> 
           		  	<td class="td12" nowrap>Status - Pick</td>
           		  	<%for(int j=0; j < iNumOfStr;j++){%>
		            	<td class="td12" nowrap><%=sStrStsPick[j]%></td>		            
           		  	<%}%>
           		  </tr>
           		  <tr id="trId" class="trDtl10"> 
           		  	<td class="td12" nowrap>Total Reduce Qty</td>
           		  	<%for(int j=0; j < iNumOfStr;j++){%>
		            	<td class="td12" nowrap><%=sStrTotQty[j]%></td>		            
           		  	<%}%>
           		  </tr>
           		  
           		  <!-- ========== Filter by Qty and Price ======================= -->
           		  <tr id="trId" class="trDtl11"> 
           		  	<td class="td12" nowrap>Min Qty</td>
           		  	<%for(int j=0; j < iNumOfStr;j++){%>
		            	<td class="td12" nowrap><%=sStrMinQty[j]%></td>		            
           		  	<%}%>
           		  </tr>
           		  <tr id="trId" class="trDtl11"> 
           		  	<td class="td12" nowrap>Min Price</td>
           		  	<%for(int j=0; j < iNumOfStr;j++){%>
		            	<td class="td12" nowrap><%=sStrMinPrc[j]%></td>		            
           		  	<%}%>
           		  </tr>
           		        
           		  <!-- ========== Allowed Qty ======================= -->
           		  <tr id="trId" class="trDtl08"> 
           		  	<td class="td12" nowrap>Allowed Qty</td>
           		  	<%for(int j=0; j < iNumOfStr;j++){%>
		            	<td class="td12" nowrap><%=sStrAlwQty[j]%></td>		            
           		  	<%}%>
           		  </tr>     		             		             		  
           		</table>
           
           <!-- ========== Market ======================= -->		
           <tr id="trId" class="trDtl04">
           	<td class="td12" colspan=6>
           		<table class="tbl07" id="tblStrInv">
           		  <tr class="trHdr01">
           		  	<th id="trId" class="th12" colspan=<%=iNumOfMrk + 1%>>Markets</th>
           		  	<th id="trId" class="th12" rowspan=5><br><br><br>&nbsp; or &nbsp;</th>
           		  	<th id="trId" class="th12" >Company</th>
           		  	<th id="trId" class="th12" >Unlocated Orders</th>
           		  	<th id="trId" class="th12">Pass To Mozu greater of<br> Company and Market</th>
           		  </tr>
           		  <tr id="trId" class="trDtl04"> 
           		  	<td class="td12" nowrap>Store</td>
           		  	<%for(int j=0; j < iNumOfMrk;j++){%>
		            	<td class="td12" nowrap><%=sMrk[j]%></td>		            
           		  	<%}%>           		  	
           		  	<td>&nbsp;</td>
           		  	<td class="td34" style="background:#D8D8D8;" nowrap rowspan="4"><%=sUnallocOrd%></td>    
           		  	<td class="td12" rowspan=3>&nbsp;</td>
           		  </tr>
           		  
           		  <!-- ========== Filter by Qty and Price ======================= -->
           		  <tr id="trId" class="trDtl11"> 
           		  	<td class="td12" nowrap>Min Qty</td>
           		  	<%for(int j=0; j < iNumOfMrk;j++){%>
		            	<td class="td12" nowrap><%=sMrkMinQty[j]%></td>		            
           		  	<%}%>
           		  	<td class="td12" nowrap><%=sCmpMinQty%></td>           		  	           		  	           		  	
           		  </tr>
           		  <tr id="trId" class="trDtl11"> 
           		  	<td class="td12" nowrap>Min Price</td>
           		  	<%for(int j=0; j < iNumOfMrk;j++){%>
		            	<td class="td12" nowrap><%=sMrkMinPrc[j]%></td>		            
           		  	<%}%>
           		  	<td class="td12" nowrap><%=sCmpMinPrc%></td>
           		  	
           		  </tr>
           		  <!-- ========== Total Qty ======================= -->
           		  <tr id="trId" class="trDtl08"> 
           		  	<td class="td12" nowrap>Total</td>
           		  	<%for(int j=0; j < iNumOfMrk;j++){%>
		            	<td class="td12" nowrap><%=sMrkQty[j]%></td>		            
           		  	<%}%>
           		  	<td class="td12" nowrap><%=sCmpQty%></td>
           		  	<td class="td12" nowrap><%=sPassToMozu%>           		  	
           		  </tr>   
           		</table>
           </td>
          </tr>
          <!-- =============================================== -->
          <!-- ========== Child Prices ======================= -->
          <!-- =============================================== -->
          
           <!-- ========== Map ======================= -->		
           <tr id="trId" class="trDtl04">
           	<td class="td12">
           		<table class="tbl07" id="tblStrInv">
           		  <tr class="trHdr01">
           		    <th id="trId" class="th12">&nbsp;</th>
           		  	<th id="trId" class="th12">Map</th>
           		  </tr>
           		  <tr id="trId" class="trDtl04"> 
           		  	<td class="td12" nowrap>No Map Flag</td>
           		  	<td class="td34" <%if(sPrcEff[0].equals("1")){%><%=sEffClr%><%}%> nowrap><%=sNoMap%></td>
           		  </tr>
           		  <tr id="trId" class="trDtl04"> 
           		  	<td class="td12" nowrap>Price</td>
           		  	<td class="td12" <%if(sPrcEff[3].equals("1")){%><%=sEffClr%><%}%> nowrap>$<%=sMap%></td>
           		  </tr>
           		  <tr id="trId" class="trDtl04"> 
           		  	<td class="td12" nowrap>Exp. Date</td>
           		  	<td class="td12" nowrap><%=sMapExpDt%></td>
           		  </tr>	
           		</table>
           	</td>
           	
           	<!-- ========== Store Price ======================= -->
           	<td class="td12">
           		<table class="tbl07">
           		  <tr class="trHdr01">
           		    <th id="trId" class="th12">&nbsp;</th>
           		    <th id="trId" class="th12">Chain<br>Price</th>
           		  	<th id="trId" class="th12">Store<br>Price</th>
           		  </tr>
           		  <tr id="trId" class="trDtl04"> 
           		  	<td class="td12" nowrap>Retail</td>
           		  	<td class="td12" nowrap>$<%=sIpRet%></td>
           		  	<td class="td12" <%if(sPrcEff[3].equals("1")){%><%=sEffClr%><%}%> nowrap>$<%=sStrRet%></td>
           		  </tr>           		  	
           		</table>
           	</td>
           	
           	<!-- ========== Temp Price ======================= -->
           	<td class="td12">
           		<table class="tbl07">
           		  <tr class="trHdr01">
           		    <th id="trId" class="th12">&nbsp;</th>
           		  	<th id="trId" class="th12">Temporary Chain<br>Price</th>
           		  </tr>
           		  <tr id="trId" class="trDtl04"> 
           		  	<td class="td12" nowrap>Retail</td>
           		  	<td class="td12" <%if(sPrcEff[6].equals("1")){%><%=sEffClr%><%}%> nowrap>$<%=sTempRet%></td>
           		  </tr>
           		  <tr id="trId" class="trDtl04"> 
           		  	<td class="td12" nowrap>From Date</td>
           		  	<td class="td12" nowrap><%=sTempFrDt%></td>
           		  </tr>
           		  <tr id="trId" class="trDtl04"> 
           		  	<td class="td12" nowrap>To Date</td>
           		  	<td class="td12" nowrap><%=sTempToDt%></td>
           		  </tr>	
           		</table>
           	</td>
           	           	           	
           	<!-- ========== Alternative Price ======================= -->
           	<td class="td12">
           		<table class="tbl07">
           		  <tr class="trHdr01">
           		    <th id="trId" class="th12">&nbsp;</th>
           		  	<th id="trId" class="th12">Alternative<br>Price</th>
           		  </tr>
           		  <tr id="trId" class="trDtl04"> 
           		  	<td class="td12" nowrap>Retail</td>
           		  	<td class="td12" <%if(sPrcEff[5].equals("1")){%><%=sEffClr%><%}
           		  	else if(sPrcEff[7].equals("1")){%><%=sEffClr1%><%}%> nowrap>$<%=sAltRet%></td>
           		  </tr>
           		  <tr id="trId" class="trDtl04"> 
           		  	<td class="td12" nowrap>From Date</td>
           		  	<td class="td12" nowrap><%=sAltFrDt%></td>
           		  </tr>
           		  <tr id="trId" class="trDtl04"> 
           		  	<td class="td12" nowrap>To Date</td>
           		  	<td class="td12" nowrap><%=sAltToDt%></td>
           		  </tr>	
           		</table>
           	</td>
           	
           	<!-- ========== Web Price ======================= -->
           	<td class="td12">
           		<table class="tbl07">
           		  <tr class="trHdr01">
           		    <th id="trId" class="th12">&nbsp;</th>
           		    <th id="trId" class="th12">Web Price</th>
           		  </tr>
           		  <tr id="trId" class="trDtl04" <%if(sPassToMozu.equals("")){%>style="background: #e7e7e7;"<%}%>> 
           		  	<td class="td12" nowrap>Msrp</td>
           		  	<td class="td12" nowrap>$<%=sMsrp%></td>           		  	
           		  </tr>
           		  <tr id="trId" class="trDtl04" <%if(sPassToMozu.equals("")){%>style="background: #e7e7e7;"<%}%>> 
           		  	<td class="td12" nowrap>Price</td>
           		  	<td class="td12" nowrap>$<%=sPrice%></td>           		  	           		  	
           		  </tr>
           		  <tr id="trId" class="trDtl04" <%if(sPassToMozu.equals("")){%>style="background: #e7e7e7;"<%}%>> 
           		  	<td class="td12" nowrap>Sale Price</td>
           		  	<td class="td12" nowrap>$<%=sSls%></td>           		  	           		  	
           		  </tr>           		  	
           		</table>
           	</td>
           	           	
           </tr>		  
           		
           		<!-- ====== End of SKU ============= -->
           		  <tr >
           		  	<td class="Separator05" colspan=6>&nbsp;</td>
           		 </tr> 	
           	</td>
           </tr>     
		<%}%>   
      	</table>
    <br>  	
    <br>  	
    <!-- ============= build CVS-C summary table============ -->
    <table class="tbl02" id="tblCvsc">
        <tr class="trHdr01">
           <th class="th02" colspan="11">
           Current ECOM (store 70) Prices in AS400 - IP Item Master
           </th>
        </tr>
    	<tr class="trHdr01">
          <th class="th02">No.</th>
          <th class="th02" style="background: #cccfff;">Class/Vendor/Style-Color</th>
          <th class="th02" style="background: #cce9f0;">Color<br>Name</th>
          <th class="th02" style="background: #c2f0d1;">Regular<br>(Book)<br>Price</th>
          <th class="th02" style="background: #eef0c2;">Sale<br>(Temp)<br>Price</th>
          <th class="th02" style="background: #eef0c2;">Sale<br>(Temp)<br>From</th>
          <th class="th02" style="background: #eef0c2;">Sale<br>(Temp)<br>To</th>
          <th class="th02" style="background: #faf2af;">% Off</th>
          <th class="th02" style="background: #c2f0d1;">Tot Qty<br>On Hand</th>
          <th class="th02" style="background: #f8cafa;">Tot Qty<br>Exclusions</th>
          <th class="th02" style="background: #c2f0d1;">Qty Avail<br>*On-Line</th>
        </tr>    
    <%
    itmlst.setNumOfCvsc();
	
	int iNumOfCvsc = itmlst.getNumOfCvsc();
	for(int i=0; i < iNumOfCvsc; i++){
		itmlst.setCvsc();
		String sCvscCls = itmlst.getCvscCls();
		String sCvscVen = itmlst.getCvscVen();
		String sCvscSty = itmlst.getCvscSty();
		String sCvscClr = itmlst.getCvscClr();
		String sCvscClrNm = itmlst.getCvscClrNm();
		String sCvscRet = itmlst.getCvscRet();
		String sCvscRetTmp = itmlst.getCvscRetTmp();
		String sCvscRetFrm = itmlst.getCvscRetFrm();
		String sCvscRetTo = itmlst.getCvscRetTo();
		String sCvscPrc = itmlst.getCvscPrc();
		String sCvscOnhand = itmlst.getCvscOnhand();
		String sCvscExcl = itmlst.getCvscExcl();
		String sCvscAvail = itmlst.getCvscAvail();
		String sCvscTmpAct = itmlst.getCvscTmpAct();
		String sClrNonAct = "";
		if(!sCvscTmpAct.equals("Y")){ sClrNonAct = "style=\"background: #cecece; color: white;\""; }
	%>	
	    <tr id="trId" class="trDtl04">
	        <td class="td12" nowrap><%=i+1%></td> 
        	<td class="td12" nowrap><%=sCvscCls%><%=sCvscVen%><%=sCvscSty%>-<%=sCvscClr%></td>
        	<td class="td11" nowrap><%=sCvscClrNm%></td>
        	<td class="td12" nowrap>$<%=sCvscRet%></td>
        	<td class="td18" <%=sClrNonAct%> nowrap><%if(!sCvscRetTmp.equals(".00")){%>$<%=sCvscRetTmp%><%} else {%>&nbsp;<%}%></td>
        	<td class="td18" <%=sClrNonAct%> nowrap><%if(!sCvscRetFrm.equals("01/01/0001")){%><%=sCvscRetFrm%><%} else {%>&nbsp;<%}%></td>
        	<td class="td12" <%=sClrNonAct%> nowrap><%if(!sCvscRetTo.equals("01/01/0001")){%><%=sCvscRetTo%><%} else {%>&nbsp;<%}%></td>
        	<td class="td12" <%=sClrNonAct%> nowrap><%if(!sCvscRetTmp.equals(".00")){%><%=sCvscPrc%>%<%} else {%>&nbsp;<%}%></td>
        	<td class="td12" nowrap><%=sCvscOnhand%></td>
        	<td class="td12" nowrap><%=sCvscExcl%></td>
        	<td class="td12" nowrap><%=sCvscAvail%></td>
        </tr>
	<%}%>
    </table>
    	
    
      	
	  </tbody>
      <!----------------------- end of table ------------------------>
      </tr>
      <%} %>
   </table>
   
   <%
		itmlst.setParentTotal();
		String sPrntAlwQty = itmlst.getPrntAlwQty();		
	%>	
 </body>
<script>
if(Parent != null)
{
	ParentTotQty = "<%=sPrntAlwQty%>";
	document.all.tdPrtTotQty.innerHTML = ParentTotQty;
}	
</script> 
</html>
<%
itmlst.disconnect();
itmlst = null;
}
%>