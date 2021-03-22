<!DOCTYPE html>
<%@ page import="salesreport.DiscSumRep, java.util.*, java.text.*"%>
<%
   String sFrom = request.getParameter("FrDate");   
   String sTo = request.getParameter("ToDate");
   String sInclDiv = request.getParameter("InclDiv");
   String sBogo = request.getParameter("Bogo");
   String sSelCode = request.getParameter("Code");
   String sCust = request.getParameter("Cust");
   String sSort = request.getParameter("Sort");
   String sSelType = request.getParameter("Type");
   
   if(sFrom == null)
   {
	   	SimpleDateFormat sdfMdy = new SimpleDateFormat("MM/dd/yyyy");
	   	Calendar cal = Calendar.getInstance();
	   	cal.add(Calendar.DATE, -1);
	   	Date dToDate = cal.getTime();
	   	cal.add(Calendar.DATE, -30);
	   	sTo = sdfMdy.format(dToDate);
	   	Date dFrDate = cal.getTime();
	   	sFrom = sdfMdy.format(dFrDate);   
   }
   
   if(sSort == null){sSort = "Str"; }
   if(sSelType == null){sSelType = "U"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=DiscSumRep.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	DiscSumRep audsum = null;
    int iNumOfStr = 0;
    int iNumOfReg = 0; 
    int iNumOfDsc = 0; 
    String [] sCode = new String[]{};
    String [] sCdDesc = new String[]{};
    String sLyFrDate = "";
    String sLyToDate = "";
    
    if(sFrom != null)
    {
    	audsum = new DiscSumRep(sFrom, sTo, sInclDiv, sBogo, sSelCode, sCust, sSort);
    	iNumOfStr = audsum.getNumOfStr();
    	iNumOfReg = audsum.getNumOfReg(); 
    	
    	iNumOfDsc = audsum.getNumOfDsc();
        sCode = audsum.getCode();
        sCdDesc = audsum.getCdDesc();
        sLyFrDate = audsum.getLyFrDate();
        sLyToDate = audsum.getLyToDate();
    } 
%>
<html>
<head>
 
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Discount By Code Summary</title>

<SCRIPT>

//--------------- Global variables -----------------------
var NumOfStr = "<%=iNumOfStr%>";
var NumOfReg = "<%=iNumOfReg%>";
var NumOfDsc = "<%=iNumOfDsc%>";
var LyFrDate = "<%=sLyFrDate%>";
var LyToDate = "<%=sLyToDate%>";

var SelObjNm = null;
var SelType = "<%=sSelType%>";
 //--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
   	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   	initSetType();
}
//==============================================================================
//initial process
//==============================================================================
function initSetType()
{
	var inp = document.getElementsByName("inpType");
	for(var i=0; i < inp.length ; i++)
	{	
		inp[i].checked = false;
	}
	if(SelType == "R"){ inp[0].checked = true; }
	if(SelType == "U"){ inp[1].checked = true; }
	if(SelType == "P"){ inp[2].checked = true; }
	if(SelType == "G"){ inp[3].checked = true; }
	
	setType(SelType);
}
//==============================================================================
//change selected data type 
//==============================================================================
function setType(inp)
{
	var type = inp;
	
	SelType = type;
	
	var dispDisc = "none";
	var dispDscPrc = "none";
	var dispCost = "none";
	var dispRet = "none";
	var dispGm$ = "none";
	
	if(type == "U"){ dispDisc = "table-cell"; }
	if(type == "P"){ dispDscPrc = "table-cell"; }
	if(type == "C"){ dispCost = "table-cell"; }
	if(type == "R"){ dispRet = "table-cell"; }
	if(type == "G"){ dispGm$ = "table-cell"; }
	
	// set displayn for stores
	for(var i=0; i < NumOfStr; i++)
	{
		for(var j=0; j < NumOfDsc; j++)
		{
			setFldDisp("spnTyDisc" + i + "_" + j, dispDisc);
			setFldDisp("spnTyDscPrc" + i + "_" + j, dispDscPrc);
			setFldDisp("spnTyCost" + i + "_" + j, dispCost);
			setFldDisp("spnTyRet" + i + "_" + j, dispRet);
			setFldDisp("spnTyGm$" + i + "_" + j, dispGm$);
			
			setFldDisp("spnLyDisc" + i + "_" + j, dispDisc);
			setFldDisp("spnLyDscPrc" + i + "_" + j, dispDscPrc);
			setFldDisp("spnLyCost" + i + "_" + j, dispCost);
			setFldDisp("spnLyRet" + i + "_" + j, dispRet);
			setFldDisp("spnLyGm$" + i + "_" + j, dispGm$);
		}
		var k = 29;
		setFldDisp("spnTyDisc" + i + "_" + k, dispDisc);
		setFldDisp("spnTyDscPrc" + i + "_" + k, dispDscPrc);
		setFldDisp("spnTyCost" + i + "_" + k, dispCost);
		setFldDisp("spnTyRet" + i + "_" + k, dispRet);
		setFldDisp("spnTyGm$" + i + "_" + k, dispGm$);
		
		setFldDisp("spnLyDisc" + i + "_" + k, dispDisc);
		setFldDisp("spnLyDscPrc" + i + "_" + k, dispDscPrc);
		setFldDisp("spnLyCost" + i + "_" + k, dispCost);
		setFldDisp("spnLyRet" + i + "_" + k, dispRet);
		setFldDisp("spnLyGm$" + i + "_" + k, dispGm$);
		
		k = NumOfDsc;
		setFldDisp("spnTyDisc" + i + "_" + k, dispDisc);
		setFldDisp("spnTyDscPrc" + i + "_" + k, dispDscPrc);
		setFldDisp("spnTyCost" + i + "_" + k, dispCost);
		setFldDisp("spnTyRet" + i + "_" + k, dispRet);
		setFldDisp("spnTyGm$" + i + "_" + k, dispGm$);
		
		setFldDisp("spnLyDisc" + i + "_" + k, dispDisc);
		setFldDisp("spnLyDscPrc" + i + "_" + k, dispDscPrc);
		setFldDisp("spnLyCost" + i + "_" + k, dispCost);
		setFldDisp("spnLyRet" + i + "_" + k, dispRet);
		setFldDisp("spnLyGm$" + i + "_" + k, dispGm$);
		
		k = 28;
		setFldDisp("spnTyDisc" + i + "_" + k, dispDisc);
		setFldDisp("spnTyDscPrc" + i + "_" + k, dispDscPrc);
		setFldDisp("spnTyCost" + i + "_" + k, dispCost);
		setFldDisp("spnTyRet" + i + "_" + k, dispRet);
		setFldDisp("spnTyGm$" + i + "_" + k, dispGm$);
		
		setFldDisp("spnLyDisc" + i + "_" + k, dispDisc);
		setFldDisp("spnLyDscPrc" + i + "_" + k, dispDscPrc);
		setFldDisp("spnLyCost" + i + "_" + k, dispCost);
		setFldDisp("spnLyRet" + i + "_" + k, dispRet);
		setFldDisp("spnLyGm$" + i + "_" + k, dispGm$);
	}
	
	// set display for region 
	for(var i=0; i < NumOfReg; i++)
	{
		for(var j=0; j < NumOfDsc; j++)
		{
			setFldDisp("spnRegTyDisc" + i + "_" + j, dispDisc);
			setFldDisp("spnRegTyDscPrc" + i + "_" + j, dispDscPrc);
			setFldDisp("spnRegTyCost" + i + "_" + j, dispCost);
			setFldDisp("spnRegTyRet" + i + "_" + j, dispRet);
			setFldDisp("spnRegTyGm$" + i + "_" + j, dispGm$);
			
			setFldDisp("spnRegLyDisc" + i + "_" + j, dispDisc);
			setFldDisp("spnRegLyDscPrc" + i + "_" + j, dispDscPrc);
			setFldDisp("spnRegLyCost" + i + "_" + j, dispCost);
			setFldDisp("spnRegLyRet" + i + "_" + j, dispRet);
			setFldDisp("spnRegLyGm$" + i + "_" + j, dispGm$);
		}
		var k = 29;
		setFldDisp("spnRegTyDisc" + i + "_" + k, dispDisc);
		setFldDisp("spnRegTyDscPrc" + i + "_" + k, dispDscPrc);
		setFldDisp("spnRegTyCost" + i + "_" + k, dispCost);
		setFldDisp("spnRegTyRet" + i + "_" + k, dispRet);
		setFldDisp("spnRegTyGm$" + i + "_" + k, dispGm$);
		
		setFldDisp("spnRegLyDisc" + i + "_" + k, dispDisc);
		setFldDisp("spnRegLyDscPrc" + i + "_" + k, dispDscPrc);
		setFldDisp("spnRegLyCost" + i + "_" + k, dispCost);
		setFldDisp("spnRegLyRet" + i + "_" + k, dispRet);
		setFldDisp("spnRegLyGm$" + i + "_" + k, dispGm$);
		
		k = NumOfDsc;
		setFldDisp("spnRegTyDisc" + i + "_" + k, dispDisc);
		setFldDisp("spnRegTyDscPrc" + i + "_" + k, dispDscPrc);
		setFldDisp("spnRegTyCost" + i + "_" + k, dispCost);
		setFldDisp("spnRegTyRet" + i + "_" + k, dispRet);
		setFldDisp("spnRegTyGm$" + i + "_" + k, dispGm$);
		
		setFldDisp("spnRegLyDisc" + i + "_" + k, dispDisc);
		setFldDisp("spnRegLyDscPrc" + i + "_" + k, dispDscPrc);
		setFldDisp("spnRegLyCost" + i + "_" + k, dispCost);
		setFldDisp("spnRegLyRet" + i + "_" + k, dispRet);
		setFldDisp("spnRegLyGm$" + i + "_" + k, dispGm$);
		
		k = 28;
		setFldDisp("spnRegTyDisc" + i + "_" + k, dispDisc);
		setFldDisp("spnRegTyDscPrc" + i + "_" + k, dispDscPrc);
		setFldDisp("spnRegTyCost" + i + "_" + k, dispCost);
		setFldDisp("spnRegTyRet" + i + "_" + k, dispRet);
		setFldDisp("spnRegTyGm$" + i + "_" + k, dispGm$);
		
		setFldDisp("spnRegLyDisc" + i + "_" + k, dispDisc);
		setFldDisp("spnRegLyDscPrc" + i + "_" + k, dispDscPrc);
		setFldDisp("spnRegLyCost" + i + "_" + k, dispCost);
		setFldDisp("spnRegLyRet" + i + "_" + k, dispRet);
		setFldDisp("spnRegLyGm$" + i + "_" + k, dispGm$);
	}
	
	for(var j=0; j < NumOfDsc; j++)
	{   
		setFldDisp("spnTotTyDisc" + j, dispDisc);
		setFldDisp("spnTotTyDscPrc" + j, dispDscPrc);
		setFldDisp("spnTotTyCost" + j, dispCost);
		setFldDisp("spnTotTyRet" + j, dispRet);
		setFldDisp("spnTotTyGm$" + j, dispGm$);
		
		setFldDisp("spnTotLyDisc" + j, dispDisc);
		setFldDisp("spnTotLyDscPrc" + j, dispDscPrc);
		setFldDisp("spnTotLyCost" + j, dispCost);
		setFldDisp("spnTotLyRet" + j, dispRet);
		setFldDisp("spnTotLyGm$" + j, dispGm$);
	}
	
	var k = 29;
	setFldDisp("spnTotTyDisc" + k, dispDisc);
	setFldDisp("spnTotTyDscPrc" + k, dispDscPrc);
	setFldDisp("spnTotTyCost" + k, dispCost);
	setFldDisp("spnTotTyRet" + k, dispRet);
	setFldDisp("spnTotTyGm$" + k, dispGm$);
	
	setFldDisp("spnTotLyDisc" + k, dispDisc);
	setFldDisp("spnTotLyDscPrc" + k, dispDscPrc);
	setFldDisp("spnTotLyCost" + k, dispCost);
	setFldDisp("spnTotLyRet" + k, dispRet);
	setFldDisp("spnTotLyGm$" + k, dispGm$);
	
	k = NumOfDsc;
	setFldDisp("spnTotTyDisc" + k, dispDisc);
	setFldDisp("spnTotTyDscPrc" + k, dispDscPrc);
	setFldDisp("spnTotTyCost" + k, dispCost);
	setFldDisp("spnTotTyRet" + k, dispRet);
	setFldDisp("spnTotTyGm$" + k, dispGm$);
	
	setFldDisp("spnTotLyDisc" + k, dispDisc);
	setFldDisp("spnTotLyDscPrc" + k, dispDscPrc);
	setFldDisp("spnTotLyCost" + k, dispCost);
	setFldDisp("spnTotLyRet" + k, dispRet);
	setFldDisp("spnTotLyGm$" + k, dispGm$);
	
	k = 28;
	setFldDisp("spnTotTyDisc" + k, dispDisc);
	setFldDisp("spnTotTyDscPrc" + k, dispDscPrc);
	setFldDisp("spnTotTyCost" + k, dispCost);
	setFldDisp("spnTotTyRet" + k, dispRet);
	setFldDisp("spnTotTyGm$" + k, dispGm$);
	
	setFldDisp("spnTotLyDisc" + k, dispDisc);
	setFldDisp("spnTotLyDscPrc" + k, dispDscPrc);
	setFldDisp("spnTotLyCost" + k, dispCost);
	setFldDisp("spnTotLyRet" + k, dispRet);
	setFldDisp("spnTotLyGm$" + k, dispGm$);
}

//==============================================================================
// set field display property 
//==============================================================================
function setFldDisp(name, disp)
{
	var objnm = name;
	var obj = document.getElementById(objnm);
	obj.style.display= disp;
	obj.style.textAlign = "right";
}

//==============================================================================
// retreive detail data for selected date and day range 
//==============================================================================
function rtvDiscDtl(year, str, code, sort)
{
	var url = "DiscSumRepDtl.jsp?Str=" + str
	 + "&Code=" + code
	 + "&Year=" + year
	 + "&InclDiv=<%=sInclDiv%>"
	 + "&Bogo=<%=sBogo%>"
	 + "&InclCode=<%=sSelCode%>"
	 + "&Cust=<%=sCust%>"
	 
	if(year=='TY')
	{
		url += "&FrDate=<%=sFrom%>"
	 	 + "&ToDate=<%=sTo%>";
	}
	else 
	{
	 	url += "&FrDate=<%=sLyFrDate%>"
	 	 + "&ToDate=<%=sLyToDate%>";
	} 
	
	url += "&Sort=" + sort;
	
	window.frame1.location.href = url;
}

//==============================================================================
// dispaly detail data for selected date and day range 
//==============================================================================
function showDiscDtl(str, code, year, frdate, todate, cls, ven, sty, clr, siz, ret, cost, disc
		   , qty, desc, sku, gtin, venSty, clrNm, sizNm, venNm
		   , reg, tran, date, cash, clsNm, slsp, div, coup, coupNm, discPrc, price )
{
	var hdr = "Str: " + str 
	if( code!="EMP" ){ hdr += " Code: " + code; }
	else{ hdr += " Employee Discounts"; }
	
	  var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popDiscDtl(str, code, year, frdate, todate, cls, ven, sty, clr, siz, ret, cost, disc
	    	, qty, desc, sku, gtin, venSty, clrNm, sizNm, venNm, reg, tran, date, cash, clsNm
	    	, slsp, div, coup, coupNm, discPrc, price)
	     + "</td></tr>"
	   + "</table>"

	  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "1500";}
	  else { document.all.dvItem.style.width = "auto";}
	   
	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.left=getLeftScreenPos() + 100;
	  document.all.dvItem.style.top=getTopScreenPos() + 100;
	  document.all.dvItem.style.zIndex = "50";
	  document.all.dvItem.style.visibility = "visible";	   
}
//==============================================================================
//populate order list for selected status
//==============================================================================
function popDiscDtl(str, code, year, frdate, todate, cls, ven, sty, clr, siz, ret, cost, disc
	, qty, desc, sku, gtin, venSty, clrNm, sizNm, venNm, reg, tran, date, cash, clsNm
	, slsp, div, coup, coupNm, discPrc, price )
{
	var link1 = "<a href='javascript: rtvDiscDtl(&#34;" + year + "&#34;" 
	   + ",&#34;" + str + "&#34;,&#34;" + code + "&#34;, &#34;Cashier&#34;)'>Cashier<a>";
	var link2 = "<a href='javascript: rtvDiscDtl(&#34;" + year + "&#34;" 
	   + ",&#34;" + str + "&#34;,&#34;" + code + "&#34;, &#34;Retail&#34;)'>Ret<a>";  
	   
	var link3 = "<a href='javascript: rtvDiscDtl(&#34;" + year + "&#34;" 
	   + ",&#34;" + str + "&#34;,&#34;" + code + "&#34;, &#34;Div&#34;)'>Div<a>";  
	   
	var link4 = "<a href='javascript: rtvDiscDtl(&#34;" + year + "&#34;" 
	   + ",&#34;" + str + "&#34;,&#34;" + code + "&#34;, &#34;Vendor&#34;)'>Vendor Name<a>";  
	   
	var link5 = "<a href='javascript: rtvDiscDtl(&#34;" + year + "&#34;" 
	   + ",&#34;" + str + "&#34;,&#34;" + code + "&#34;, &#34;Disc$&#34;)'>Disc$<a>";     
	
	var panel = "<table class='tbl02'>";
	panel += "<tr class='trHdr01'>"
	   + "<th class='th01'>Date</th>"
	   + "<th class='th01'>Reg</th>"
       + "<th class='th01'>Trans</th>"
       + "<th class='th01'>" + link1 + "</th>"
       + "<th class='th01'>Salesperson</th>"
       + "<th class='th01'>" + link3 + "</th>"
       + "<th class='th01'>Class</th>"
       + "<th class='th01'>Description</th>"
       + "<th class='th01'>Color Name</th>"
       + "<th class='th01'>Size Name</th>"
       + "<th class='th01'>Vendor Style</th>"
       + "<th class='th01'>" + link4 + "</th>"
       + "<th class='th01'>Sku</th>"       
       + "<th class='th01'>GTIN</th>"
       + "<th class='th01'>Qty</th>" 
       + "<th class='th01'>Price</th>"
       + "<th class='th01'>" + link2 + "</th>"
       + "<th class='th01'>" + link5 + "</th>"
       + "<th class='th01'>Disc%</th>"
       + "<th class='th01'>Mkt. Code</th>"
       + "<th class='th01'>Mkt. Code Name</th>"
     + "</tr>";
      	
	for(var i=0; i < cls.length;i++)
	{
		panel += "<tr class='trDtl01'>"
		  + "<td nowrap class='td12'>" + date[i] + "</td>"
		  + "<td nowrap class='td12'>" + reg[i] + "</td>"
	      + "<td nowrap class='td12'>" + tran[i] + "</td>"
	      + "<td nowrap class='td11'>" + cash[i] + "</td>"
	      + "<td nowrap class='td11'>" + slsp[i] + "</td>"
	      + "<td nowrap class='td12'>" + div[i] + "</td>"
	      + "<td nowrap class='td11'>" + cls[i] + " - " + clsNm[i] + "</td>"
	      + "<td nowrap class='td11'>" + desc[i] + "</td>"
	      + "<td nowrap class='td11'>" + clrNm[i] + "</td>"
	      + "<td nowrap class='td11'>" + sizNm[i] + "</td>"
	      + "<td nowrap class='td11'>" + venSty[i] + "</td>"
	      + "<td nowrap class='td11'>" + venNm[i] + "</td>"
	      + "<td nowrap class='td12'>" + sku[i] + "</td>"
	      + "<td nowrap class='td12'>" + gtin[i] + "</td>"
	      + "<td nowrap class='td12'>" + qty[i] + "</td>"
	      + "<td nowrap class='td12'>" + price[i] + "</td>"
	      + "<td nowrap class='td12'>" + ret[i] + "</td>"
	      + "<td nowrap class='td12'>" + disc[i] + "</td>"
	      + "<td nowrap class='td12'>" + discPrc[i] + "%</td>"
	      + "<td nowrap class='td12'>" + coup[i] + "</td>"
	      + "<td nowrap class='td12'>" + coupNm[i] + "</td>"	
	    + "</tr>";
}
	
	panel += "<tr class='trDtl03'>"
	   + "<td nowrap class='td18' colspan=26>"
	   + "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Cancel</button>"
	   + "</td></tr>"
	
	return panel;
}

//==============================================================================
// generate Excel 
//==============================================================================
function crtExcel(year, str, code)
{
	var url = "DiscSumRepDtlExcel.jsp?Str=" + str
	 + "&Code=" + code 
	 + "&InclDiv=<%=sInclDiv%>"
	 + "&Bogo=<%=sBogo%>"
	 + "&InclCode=<%=sSelCode%>"
	 + "&Cust=<%=sCust%>"
	 
	if(year=='TY')
	{
		url += "&FrDate=<%=sFrom%>"
	 	 + "&ToDate=<%=sTo%>";
	}
	else 
	{
	 	url += "&FrDate=<%=sLyFrDate%>"
	 	 + "&ToDate=<%=sLyToDate%>";
	} 
	
	window.status = url; 
	window.open(url, "Discount_Summary"); 
}

//==============================================================================
//retreive detail data for selected date and day range 
//==============================================================================
function rtvCoupDtl(year, str, code, objnm)
{
	SelObjNm = objnm; 
	
	var url = "DiscSumCoup.jsp?Str=" + str
	 + "&Code=" + code
	 + "&Year=" + year
	 + "&InclDiv=<%=sInclDiv%>"
	 + "&Bogo=<%=sBogo%>"
	 + "&InclCode=<%=sSelCode%>"
	 + "&Cust=<%=sCust%>"
	 
	if(year=='TY')
	{
		url += "&FrDate=<%=sFrom%>"
	 	 + "&ToDate=<%=sTo%>";
	}
	else 
	{
	 	url += "&FrDate=<%=sLyFrDate%>"
	 	 + "&ToDate=<%=sLyToDate%>";
	} 
	
	url += "&Sort=Coup";
	
	window.frame1.location.href = url;
}
//==============================================================================
//dispaly list of coupons were used 
//==============================================================================
function showCoup(str, code, year, frdate, todate, ret, disc, gm$, coup, coupNm )
{
	var hdr = " Coupon List" + " &nbsp; Str: " + str 
	   + ", Code: " + code + ",  " + year;
	
	var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" 
	               + popCoup(str, code, year, frdate, todate, ret, disc, gm$, coup, coupNm )
	     + "</td></tr>"
	   + "</table>"

	  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "350";}
	  else { document.all.dvItem.style.width = "auto";}
	  
	  var obj = document.all[SelObjNm];
	  var pos = getObjPosition(obj); 
	   
	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.left = pos[0] + 60;
	  document.all.dvItem.style.top = pos[1];;
	  document.all.dvItem.style.zIndex = "50";
	  document.all.dvItem.style.visibility = "visible";	   
}
//==============================================================================
//populate order list for selected status
//==============================================================================
function popCoup(str, code, year, frdate, todate, ret, disc, gm$, coup, coupNm )
{	
	var panel = "<table class='tbl02'>";
	panel += "<tr class='trHdr01'>"
	   + "<th class='th01'>Coupon</th>"
	   + "<th class='th01'>Description</th>"
       + "<th class='th01'>Ret</th>"
       + "<th class='th01'>Disc</th>"
       + "<th class='th01'>GM $</th>"       
     + "</tr>";
      	
	for(var i=0; i < coup.length;i++)
	{
		panel += "<tr class='trDtl01'>"
		  + "<td nowrap class='td11'>" + coup[i] + "</td>"
		  + "<td nowrap class='td11'>" + coupNm[i] + "</td>"	
		  + "<td nowrap class='td12'>" + ret[i] + "</td>"
	      + "<td nowrap class='td12'>" + disc[i] + "</td>"	
	      + "<td nowrap class='td12'>" + gm$[i] + "</td>"
	    + "</tr>";
}
	
	panel += "<tr class='trDtl03'>"
	   + "<td nowrap class='td18' colspan=26>"
	   + "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Cancel</button>"
	   + "</td></tr>"
	
	return panel;
}
//==============================================================================
//hide panel
//==============================================================================
function resort(sort)
{
	var sfx = "";
	
	if(SelType == "R"){ sfx = "Ret"; }
	else if(SelType == "U"){ sfx = "Disc"; }
	else if(SelType == "P"){ sfx = "DiscPrc"; }
	else if(SelType == "G"){ sfx = "Gm$"; }
	
	if (sort == "TYTot" || sort == "LYTot" || sort == "TYEmp" || sort == "LYEmp")
	{
		sort += sfx;
	}
	
	var url = "DiscSumRep.jsp?FrDate=<%=sFrom%>&ToDate=<%=sTo%>" 
	  + "&InclDiv=<%=sInclDiv%>&Bogo=<%=sBogo%>&Code=<%=sSelCode%>&Cust=<%=sCust%>"
	  + "&Sort=" + sort
	  + "&Type=" + SelType
	;
	
	window.location.href = url;  
}
//==============================================================================
//hide panel
//==============================================================================
function hidePanel()
{
	document.all.dvItem.innerHTML = "";
	document.all.dvItem.style.visibility = "hidden";
}
</SCRIPT>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Calendar.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
 <!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <div style="position: fixed; top: 0; right: 300; width: 500px; border: none; background-color:ivory;">
       <b>Retail Concepts, Inc
            <br>Discount By Code Summary
            <br><%if(audsum != null){%>From: <%=sFrom%>&nbsp;
                 To: <%=sTo%>
                 <%}%>
            <br>BOGO: 
            	<%if(sBogo.equals("1")){%>Excluded<%}
            	  else if(sBogo.equals("2")){%>Included<%}
            	  else if(sBogo.equals("3")){%>Only<%}%>
            <br><%if(sSelCode.equals("1")){%>Did not filter on Marketing Code (Show All Discounts)<%}
                  else if(sSelCode.equals("2")){%>Has a Marketing Code only<%}
                  else if(sSelCode.equals("3")){%>Has NO Marketing Code <%}%>
            <br><%if(sCust.equals("1")){%>Did not filter on Customer Phone #'s (show all discounts)<%}
                  else if(sCust.equals("2")){%>Excluded Store (Walk-In) customer phone #'s     <%}
                  else if(sCust.equals("3")){%>Included Only Store (Walk-In) Customer phone #'s<%}%>      	  
            <br>Sorted by <%if(sSort.equals("Str")){%>Store<%}
                       else if(sSort.equals("TYEmpRet")){%>This Year Employee Purchase Retail<%} 
                       else if(sSort.equals("LYEmpRet")){%>Last Year Employee Purchase Retail<%} 
                       else if(sSort.equals("TYEmpDisc")){%>This Year Employee Purchase Discount<%} 
                       else if(sSort.equals("LYEmpDisc")){%>Last Year Employee Purchase Discount<%} 
                       else if(sSort.equals("TYEmpDiscPrc")){%>This Year Employee Purchase Discount %<%} 
                       else if(sSort.equals("LYEmpDiscPrc")){%>Last Year Employee Purchase Discount %<%} 
                       else if(sSort.equals("TYEmpGm$")){%>This Year Employee Purchase GM $<%} 
                       else if(sSort.equals("LYEmpGm$")){%>Last Year Employee Purchase GM $<%}
                       
                       else if(sSort.equals("TYTotRet")){%>This Year Store Sales Retail<%}
                       else if(sSort.equals("LYTotRet")){%>Last Year Store Sales Retail<%}
                       else if(sSort.equals("TYTotDisc")){%>This Year Store Sales Discount<%}
                       else if(sSort.equals("LYTotDisc")){%>Last Year Store Sales Discount<%}
                       else if(sSort.equals("TYTotDiscPrc")){%>This Year Store Sales Discount %<%}
                       else if(sSort.equals("LYTotDiscPrc")){%>Last Year Store Sales Discount %<%}
                       else if(sSort.equals("TYTotGm$")){%>This Year Store Sales GM $<%}
                       else if(sSort.equals("LYTotGm$")){%>Last Year Store Sales GM $<%}
                       
                       else if(sSort.equals("TYSlsPrc")){%>This Year % of Sales<%}
                       else if(sSort.equals("LYSlsPrc")){%>Last Year % of Sales<%}%>
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="DiscSumRepSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;
              
            <br>
              <input type="radio" name="inpType" id=="inpType1" value="R" onclick="setType(this.value)">Retail &nbsp; &nbsp; &nbsp;
              <!-- input type="radio" name="inpType" id=="inpType" value="C" onclick="setType(this.value)" >Cost &nbsp; &nbsp; &nbsp; -->
              <input type="radio" name="inpType" id=="inpType2" value="U" onclick="setType(this.value)">Discount $ &nbsp; &nbsp; &nbsp;
              <input type="radio" name="inpType" id=="inpType3" value="P" onclick="setType(this.value)" >Discount % &nbsp; &nbsp; &nbsp;                            
              <input type="radio" name="inpType" id=="inpType4" value="G" onclick="setType(this.value)" >GM $  
      </div>
      
      
      
      <br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>
      
      <table class="tbl01">
        
        
        <tr class="trHdr">
        <td style="font:size:11px;text-align: left" colspan=2>
          <u>*</u> - Results have at least one <b>Marketing Code</b> referenced, click on the * for a recap.. 
        </td>
        </tr>
        
        <tr>
          <td >  
      <table class="tbl02">
        <tr class="trHdr01">
          	<th class="th02" rowspan=3><a href="javascript: resort('Str')">Store</a></th>
          	<th class="th02" colspan="18">Ticket Discounts</th>
          	<th class="th02" colspan="14">Line Item Discounts</th>
          	<th class="th02" colspan="4">POS Discounts</th>
          	<th class="th02" rowspan=2 colspan=2>Total<br>Str POS<br>Discounts</th>
          	<th class="th02" rowspan=2 colspan=2>Employee<br>Discounts</th>
          	<th class="th02" rowspan=2 colspan=2>Str<br>Total</th>
          	<th class="th02" rowspan=2 colspan=2>Total<br>% of Sales</th>
          	<th class="th02" rowspan=3>Store</th>          	
        </tr>
        
        <tr class="trHdr01">
            <%for(int i=0; i < iNumOfDsc; i++){%>
        		<th class="th02" colspan="2"><%=sCode[i]%>
        		   <br><span style="font-size:9px; text-weigth:normal;"><%=sCdDesc[i]%>
        		   <%if(sCode[i].equals("07")){%><br>(Includes all uses of Mkt Code=1080)<%}%>
        		   </span>
        		</th>
        	<%} %>
        </tr>
        <tr class="trHdr01">
            <%for(int i=0; i < iNumOfDsc; i++){%>
        		<th class="th02">TY</th>
        		<th class="th02">LY</th>
        	<%} %>
        	<th class="th02">TY</th>
        	<th class="th02">LY</th>
        	<th class="th02"><a href="javascript: resort('TYEmp')">TY</a></th>
        	<th class="th02"><a href="javascript: resort('LYEmp')">LY</a></th>
        	<th class="th02"><a href="javascript: resort('TYTot')">TY</a></th>
        	<th class="th02"><a href="javascript: resort('LYTot')">LY</a></th>
        	<th class="th02"><a href="javascript: resort('TYSlsPrc')">TY</a></th>
        	<th class="th02"><a href="javascript: resort('LYSlsPrc')">LY</a></th>
        </tr>
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl04"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfStr; i++) {        	   
        	   	audsum.setAudLst();
          	 	String sStr = audsum.getStr();

           	 	String [] sTyRet = audsum.getTyRet();
           	 	String [] sTyCost = audsum.getTyCost();
           	 	String [] sTyDisc = audsum.getTyDisc();
           	 	String [] sTyGm$ = audsum.getTyGm$();
           	    String [] sTyCoup = audsum.getTyCoup();
           	    String [] sTyDscPrc = audsum.getTyDscPrc();
           	    String sTySlsPrc = audsum.getTySlsPrc();
           	 
           	 	String [] sLyRet = audsum.getLyRet();
           	 	String [] sLyCost = audsum.getLyCost();
           	 	String [] sLyDisc = audsum.getLyDisc();
           	 	String [] sLyGm$ = audsum.getLyGm$();
           	    String [] sLyCoup = audsum.getLyCoup();
           	    String [] sLyDscPrc = audsum.getLyDscPrc();
           	    String sLySlsPrc = audsum.getLySlsPrc();
          	 	
   				//if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
   				//else {sTrCls = "trDtl06";}   			
           %>
           <%if(i==20){%>
           	<tr class="trHdr01">
           	    <th class="th02" rowspan=2>Store</th>
            	<%for(int j=0; j < iNumOfDsc; j++){
            	%>
        			<th class="th02" colspan="2"><%=sCode[j]%>
        			     <br><span style="font-size:9px; text-weigth:normal;"><%=sCdDesc[j]%>
        			     <%if(sCode[j].equals("07")){%><br>(Includes all uses of Mkt Code=1080)<%}%>
        			     </span>
        			</th>
        		<%} %>
        		<th class="th02" colspan="2">POS Tot</th>
        		<th class="th02" colspan="2">Employee<br>Discounts</th>
        		<th class="th02" colspan="2">Str Tot</th>
        		<th class="th02" colspan=2>Total<br>% of Sls</th>
        		<th class="th02" rowspan=2>Store</th>
        	</tr>
        	<tr class="trHdr01">
            <%for(int j=0; j < iNumOfDsc; j++){%>
        		<th class="th02">TY</th>
        		<th class="th02">LY</th>
        	<%}%>
        	<th class="th02">TY</th>
        	<th class="th02">LY</th>
        	<th class="th02">TY</th>
        	<th class="th02">LY</th>
        	<th class="th02">TY</th>
        	<th class="th02">LY</th>
        	<th class="th02">TY</th>
        	<th class="th02">LY</th>
        </tr>
           
           <%}%>                           
           <tr id="trGrp<%=i%>" class="<%=sTrCls%>">             
             <td id="tdGrp<%=i%>" class="td12" nowrap><%=sStr%></td>
             <%for(int j=0; j < iNumOfDsc; j++){
            	 if(sTyDisc[j].equals("0")){sTyDisc[j] = "";} else{ sTyDisc[j] = "$" + sTyDisc[j]; }
            	 if(sTyCost[j].equals("0")){sTyCost[j] = "";} else{ sTyCost[j] = "$" + sTyCost[j]; }
            	 if(sTyRet[j].equals("0")){sTyRet[j] = "";} else{ sTyRet[j] = "$" + sTyRet[j]; }
            	 if(sTyGm$[j].equals("0")){sTyGm$[j] = "";} else{ sTyGm$[j] = "$" + sTyGm$[j]; }
            	 if(sTyDscPrc[j].equals("0")){sTyDscPrc[j] = "";} else{ sTyDscPrc[j] = sTyDscPrc[j] + "%"; }
            	 
            	 if(sLyDisc[j].equals("0")){sLyDisc[j] = "";} else{ sLyDisc[j] = "$" + sLyDisc[j]; }
            	 if(sLyCost[j].equals("0")){sLyCost[j] = "";} else{ sLyCost[j] = "$" + sLyCost[j]; }
            	 if(sLyRet[j].equals("0")){sLyRet[j] = "";} else{ sLyRet[j] = "$" + sLyRet[j]; }
            	 if(sLyGm$[j].equals("0")){sLyGm$[j] = "";} else{ sLyGm$[j] = "$" + sLyGm$[j]; }
            	 if(sLyDscPrc[j].equals("0")){sLyDscPrc[j] = "";} else{ sLyDscPrc[j] = sLyDscPrc[j] + "%"; }
             %>
             	<td id="tdTyCode<%=i%>_<%=j%>" class="td12" nowrap>             	   
             	   <%if(sTyCoup[j].equals("1")){%>
             	     &nbsp;<sup><a href="javascript: rtvCoupDtl('TY','<%=sStr%>','<%=sCode[j]%>', 'tdTyCode<%=i%>_<%=j%>')">*</a></sup>
             	   <%}%>
             	   <%if(!sCode[j].equals("00") && !sCode[j].equals("10")){%>
             	   		<a href="javascript: rtvDiscDtl('TY','<%=sStr%>','<%=sCode[j]%>', 'Div')">
             	   <%} else {%><a><%}%>
             	   <span id="spnTyDisc<%=i%>_<%=j%>" style="display: none;"><%=sTyDisc[j]%></span>             	   
             	   <span id="spnTyCost<%=i%>_<%=j%>" style="display: none"><%=sTyCost[j]%></span>
             	   <span id="spnTyRet<%=i%>_<%=j%>" style="display: none"><%=sTyRet[j]%></span>
             	   <span id="spnTyGm$<%=i%>_<%=j%>" style="display: none"><%=sTyGm$[j]%></span>
             	   <span id="spnTyDscPrc<%=i%>_<%=j%>" style="display: none"><%=sTyDscPrc[j]%></span>
             	   </a>
             	</td>
             	
             	<td id="tdLyCode<%=i%>_<%=j%>" class="td82" nowrap>
             	   <%if(sLyCoup[j].equals("1")){%>
             	     &nbsp;<sup><a href="javascript: rtvCoupDtl('LY','<%=sStr%>','<%=sCode[j]%>',  'tdLyCode<%=i%>_<%=j%>')">*</a></sup>
             	   <%}%>
             	   
             	   <%if(!sCode[j].equals("00") && !sCode[j].equals("10")){%>
             	     	<a href="javascript: rtvDiscDtl('LY', '<%=sStr%>','<%=sCode[j]%>', 'Div')">
             	   <%} else {%><a><%}%>
             	   <span id="spnLyDisc<%=i%>_<%=j%>" style="display: none;"><%=sLyDisc[j]%></span>
             	   <span id="spnLyCost<%=i%>_<%=j%>" style="display: none"><%=sLyCost[j]%></span>
             	   <span id="spnLyRet<%=i%>_<%=j%>" style="display: none"><%=sLyRet[j]%></span>
             	   <span id="spnLyGm$<%=i%>_<%=j%>" style="display: none"><%=sLyGm$[j]%></span>
             	   <span id="spnLyDscPrc<%=i%>_<%=j%>" style="display: none"><%=sLyDscPrc[j]%></span>
             	   </a>
             	   
             	</td>             	
             <%}%>
             <%
             // store totals
             int iStrTot = 29;
             if(sTyDisc[iStrTot].equals("0")){sTyDisc[iStrTot] = "";} else{ sTyDisc[iStrTot] = "$" + sTyDisc[iStrTot]; }
        	 if(sTyCost[iStrTot].equals("0")){sTyCost[iStrTot] = "";} else{ sTyCost[iStrTot] = "$" + sTyCost[iStrTot]; }
        	 if(sTyRet[iStrTot].equals("0")){sTyRet[iStrTot] = "";} else{ sTyRet[iStrTot] = "$" + sTyRet[iStrTot]; }
        	 if(sTyGm$[iStrTot].equals("0")){sTyGm$[iStrTot] = "";} else{ sTyGm$[iStrTot] = "$" + sTyGm$[iStrTot]; }
        	 if(sTyDscPrc[iStrTot].equals("0")){sTyDscPrc[iStrTot] = "";} else{ sTyDscPrc[iStrTot] = sTyDscPrc[iStrTot] + "%"; }
        	 
        	 if(sLyDisc[iStrTot].equals("0")){sLyDisc[iStrTot] = "";} else{ sLyDisc[iStrTot] = "$" + sLyDisc[iStrTot]; }
        	 if(sLyCost[iStrTot].equals("0")){sLyCost[iStrTot] = "";} else{ sLyCost[iStrTot] = "$" + sLyCost[iStrTot]; }
        	 if(sLyRet[iStrTot].equals("0")){sLyRet[iStrTot] = "";} else{ sLyRet[iStrTot] = "$" + sLyRet[iStrTot]; }
        	 if(sLyGm$[iStrTot].equals("0")){sLyGm$[iStrTot] = "";} else{ sLyGm$[iStrTot] = "$" + sLyGm$[iStrTot]; }
        	 if(sLyDscPrc[iStrTot].equals("0")){sLyDscPrc[iStrTot] = "";} else{ sLyDscPrc[iStrTot] = sLyDscPrc[iStrTot] + "%"; }
             %>             
             <td id="tdGrp<%=i%>" class="td12" nowrap>
                <a href="javascript: crtExcel('TY', '<%=sStr%>', 'ALL')">
                <span id="spnTyDisc<%=i%>_<%=iStrTot%>" style="display: none;"><%=sTyDisc[iStrTot]%></span>
                <span id="spnTyCost<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyCost[iStrTot]%></span>
                <span id="spnTyRet<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyRet[iStrTot]%></span>
                <span id="spnTyGm$<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyGm$[iStrTot]%></span>
                <span id="spnTyDscPrc<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyDscPrc[iStrTot]%></span>
                </a>
             </td>
             
             <td id="tdGrp<%=i%>" class="td82" nowrap>
                <a href="javascript: crtExcel('LY', '<%=sStr%>', 'ALL')">
                <span id="spnLyDisc<%=i%>_<%=iStrTot%>" style="display: none;"><%=sLyDisc[iStrTot]%></span>
                <span id="spnLyCost<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyCost[iStrTot]%></span>
                <span id="spnLyRet<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyRet[iStrTot]%></span>
                <span id="spnLyGm$<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyGm$[iStrTot]%></span>
                <span id="spnLyDscPrc<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyDscPrc[iStrTot]%></span>
                </a>
             </td>
             
             <%// employee purchase
             iStrTot = iNumOfDsc;
             if(sTyDisc[iStrTot].equals("0")){sTyDisc[iStrTot] = "";} else{ sTyDisc[iStrTot] = "$" + sTyDisc[iStrTot]; }
        	 if(sTyCost[iStrTot].equals("0")){sTyCost[iStrTot] = "";} else{ sTyCost[iStrTot] = "$" + sTyCost[iStrTot]; }
        	 if(sTyRet[iStrTot].equals("0")){sTyRet[iStrTot] = "";} else{ sTyRet[iStrTot] = "$" + sTyRet[iStrTot]; }
        	 if(sTyGm$[iStrTot].equals("0")){sTyGm$[iStrTot] = "";} else{ sTyGm$[iStrTot] = "$" + sTyGm$[iStrTot]; }
        	 if(sTyDscPrc[iStrTot].equals("0")){sTyDscPrc[iStrTot] = "";} else{ sTyDscPrc[iStrTot] = sTyDscPrc[iStrTot] + "%"; }
        	 
        	 if(sLyDisc[iStrTot].equals("0")){sLyDisc[iStrTot] = "";} else{ sLyDisc[iStrTot] = "$" + sLyDisc[iStrTot]; }
        	 if(sLyCost[iStrTot].equals("0")){sLyCost[iStrTot] = "";} else{ sLyCost[iStrTot] = "$" + sLyCost[iStrTot]; }
        	 if(sLyRet[iStrTot].equals("0")){sLyRet[iStrTot] = "";} else{ sLyRet[iStrTot] = "$" + sLyRet[iStrTot]; }
        	 if(sLyGm$[iStrTot].equals("0")){sLyGm$[iStrTot] = "";} else{ sLyGm$[iStrTot] = "$" + sLyGm$[iStrTot]; }
        	 if(sLyDscPrc[iStrTot].equals("0")){sLyDscPrc[iStrTot] = "";} else{ sLyDscPrc[iStrTot] = sLyDscPrc[iStrTot] + "%"; }
             %>             
             <td id="tdGrp<%=i%>" class="td12" nowrap>
                <a href="javascript: rtvDiscDtl('TY', '<%=sStr%>','EMP', 'Div')">
                <span id="spnTyDisc<%=i%>_<%=iStrTot%>" style="display: none;"><%=sTyDisc[iStrTot]%></span>
                <span id="spnTyCost<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyCost[iStrTot]%></span>
                <span id="spnTyRet<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyRet[iStrTot]%></span>
                <span id="spnTyGm$<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyGm$[iStrTot]%></span>
                <span id="spnTyDscPrc<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyDscPrc[iStrTot]%></span>
                </a>
             </td>
             
             <td id="tdGrp<%=i%>" class="td82" nowrap>
                <a href="javascript: rtvDiscDtl('LY', '<%=sStr%>','EMP', 'Div')">
                <span id="spnLyDisc<%=i%>_<%=iStrTot%>" style="display: none;"><%=sLyDisc[iStrTot]%></span>
                <span id="spnLyCost<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyCost[iStrTot]%></span>
                <span id="spnLyRet<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyRet[iStrTot]%></span>
                <span id="spnLyGm$<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyGm$[iStrTot]%></span>
                <span id="spnLyDscPrc<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyDscPrc[iStrTot]%></span>
                </a>
             </td>
             
             <%
             // store totals
             iStrTot = 28;
             if(sTyDisc[iStrTot].equals("0")){sTyDisc[iStrTot] = "";} else{ sTyDisc[iStrTot] = "$" + sTyDisc[iStrTot]; }
        	 if(sTyCost[iStrTot].equals("0")){sTyCost[iStrTot] = "";} else{ sTyCost[iStrTot] = "$" + sTyCost[iStrTot]; }
        	 if(sTyRet[iStrTot].equals("0")){sTyRet[iStrTot] = "";} else{ sTyRet[iStrTot] = "$" + sTyRet[iStrTot]; }
        	 if(sTyGm$[iStrTot].equals("0")){sTyGm$[iStrTot] = "";} else{ sTyGm$[iStrTot] = "$" + sTyGm$[iStrTot]; }
        	 if(sTyDscPrc[iStrTot].equals("0")){sTyDscPrc[iStrTot] = "";} else{ sTyDscPrc[iStrTot] = sTyDscPrc[iStrTot] + "%"; }
        	 
        	 if(sLyDisc[iStrTot].equals("0")){sLyDisc[iStrTot] = "";} else{ sLyDisc[iStrTot] = "$" + sLyDisc[iStrTot]; }
        	 if(sLyCost[iStrTot].equals("0")){sLyCost[iStrTot] = "";} else{ sLyCost[iStrTot] = "$" + sLyCost[iStrTot]; }
        	 if(sLyRet[iStrTot].equals("0")){sLyRet[iStrTot] = "";} else{ sLyRet[iStrTot] = "$" + sLyRet[iStrTot]; }
        	 if(sLyGm$[iStrTot].equals("0")){sLyGm$[iStrTot] = "";} else{ sLyGm$[iStrTot] = "$" + sLyGm$[iStrTot]; }
        	 if(sLyDscPrc[iStrTot].equals("0")){sLyDscPrc[iStrTot] = "";} else{ sLyDscPrc[iStrTot] = sLyDscPrc[iStrTot] + "%"; }
             %>             
             <td id="tdGrp<%=i%>" class="td12" nowrap>
                <a href="javascript: crtExcel('TY', '<%=sStr%>', 'ALL')">
                <span id="spnTyDisc<%=i%>_<%=iStrTot%>" style="display: none;"><%=sTyDisc[iStrTot]%></span>
                <span id="spnTyCost<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyCost[iStrTot]%></span>
                <span id="spnTyRet<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyRet[iStrTot]%></span>
                <span id="spnTyGm$<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyGm$[iStrTot]%></span>
                <span id="spnTyDscPrc<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyDscPrc[iStrTot]%></span>
                </a>
             </td>
             
             <td id="tdGrp<%=i%>" class="td82" nowrap>
                <a href="javascript: crtExcel('LY', '<%=sStr%>', 'ALL')">
                <span id="spnLyDisc<%=i%>_<%=iStrTot%>" style="display: none;"><%=sLyDisc[iStrTot]%></span>
                <span id="spnLyCost<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyCost[iStrTot]%></span>
                <span id="spnLyRet<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyRet[iStrTot]%></span>
                <span id="spnLyGm$<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyGm$[iStrTot]%></span>
                <span id="spnLyDscPrc<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyDscPrc[iStrTot]%></span>
                </a>
             </td>
             
             
             <td id="tdTySlsPrc<%=i%>" class="td12" nowrap><%if(!sTySlsPrc.equals(".0")){%><%=sTySlsPrc%>%<%} else {%>&nbsp;<%}%></td>
             <td id="tdTySlsPrc<%=i%>" class="td12" nowrap><%if(!sLySlsPrc.equals(".0")){%><%=sLySlsPrc%>%<%} else {%>&nbsp;<%}%></td>             
             
             <td id="tdGrp<%=i%>" class="td12" nowrap><%=sStr%></td> 
           </tr>
              <script></script>	
           <%}%> 
           <!-- ======Total ================ -->
           <%
            
           %>
           <%if(audsum != null){%>
           
           <%for(int i=0; i < iNumOfReg; i++)
           {
          	 audsum.setRegTot();
          	 String sStr = audsum.getStr();
          	 String [] sTyDisc = audsum.getTyDisc();
          	 String [] sTyCost = audsum.getTyCost();
          	 String [] sTyRet = audsum.getTyRet();
             String [] sTyGm$ = audsum.getTyGm$();
             String [] sTyDscPrc = audsum.getTyDscPrc();
             String sTySlsPrc = audsum.getTySlsPrc();
             
             String [] sLyRet = audsum.getLyRet();
        	 String [] sLyCost = audsum.getLyCost();
        	 String [] sLyDisc = audsum.getLyDisc();
        	 String [] sLyGm$ = audsum.getLyGm$();
        	 String [] sLyDscPrc = audsum.getLyDscPrc();
        	 String sLySlsPrc = audsum.getLySlsPrc();
           %>	
           	 <tr id="trTotal" class="trDtl05">
             	<td class="td11" nowrap>Dist <%=sStr%></td>
             	<%for(int j=0; j < iNumOfDsc; j++)
             	{
             		if(sTyDisc[j].equals("0")){sTyDisc[j] = "";} else{ sTyDisc[j] = "$" + sTyDisc[j]; }
               	 	if(sTyCost[j].equals("0")){sTyCost[j] = "";} else{ sTyCost[j] = "$" + sTyCost[j]; }
               	 	if(sTyRet[j].equals("0")){sTyRet[j] = "";} else{ sTyRet[j] = "$" + sTyRet[j]; }
               	    if(sTyGm$[j].equals("0")){sTyGm$[j] = "";} else{ sTyGm$[j] = "$" + sTyGm$[j]; }
               	    if(sTyDscPrc[j].equals("0")){sTyDscPrc[j] = "";} else{ sTyDscPrc[j] = "$" + sTyDscPrc[j]; }
               	    
               	    if(sLyDisc[j].equals("0")){sLyDisc[j] = "";} else{ sLyDisc[j] = "$" + sLyDisc[j]; }
            	 	if(sLyCost[j].equals("0")){sLyCost[j] = "";} else{ sLyCost[j] = "$" + sLyCost[j]; }
            	 	if(sLyRet[j].equals("0")){sLyRet[j] = "";} else{ sLyRet[j] = "$" + sLyRet[j]; }
            	    if(sLyGm$[j].equals("0")){sLyGm$[j] = "";} else{ sLyGm$[j] = "$" + sLyGm$[j]; }
            	    if(sLyDscPrc[j].equals("0")){sLyDscPrc[j] = "";} else{ sLyDscPrc[j] = "$" + sLyDscPrc[j]; }
             	%>
             		<td class="td12" nowrap>             		    
             			<a>
             			<span id="spnRegTyDisc<%=i%>_<%=j%>" style="display: none;"><%=sTyDisc[j]%></span>
             	   		<span id="spnRegTyCost<%=i%>_<%=j%>" style="display: none"><%=sTyCost[j]%></span>
             	   		<span id="spnRegTyRet<%=i%>_<%=j%>" style="display: none"><%=sTyRet[j]%></span>
             	   		<span id="spnRegTyGm$<%=i%>_<%=j%>" style="display: none"><%=sTyGm$[j]%></span>
             	   		<span id="spnRegTyDscPrc<%=i%>_<%=j%>" style="display: none"><%=sTyDscPrc[j]%></span>
             	   		</a>
             		</td>	
             		<td class="td82" nowrap>             		    
             			<a>
             	   		<span id="spnRegLyDisc<%=i%>_<%=j%>" style="display: none;"><%=sLyDisc[j]%></span>
             	   		<span id="spnRegLyCost<%=i%>_<%=j%>" style="display: none"><%=sLyCost[j]%></span>
             	   		<span id="spnRegLyRet<%=i%>_<%=j%>" style="display: none"><%=sLyRet[j]%></span>
             	   		<span id="spnRegLyGm$<%=i%>_<%=j%>" style="display: none"><%=sLyGm$[j]%></span>
             	   		<span id="spnRegLyDscPrc<%=i%>_<%=j%>" style="display: none"><%=sLyDscPrc[j]%></span>
             	   		
             	   		</a>
             		</td>
             	<%}%>
             	<%
             	// store totals
                int iStrTot = 29;
                if(sTyDisc[iStrTot].equals("0")){sTyDisc[iStrTot] = "";} else{ sTyDisc[iStrTot] = "$" + sTyDisc[iStrTot]; } 
           	 	if(sTyCost[iStrTot].equals("0")){sTyCost[iStrTot] = "";} else{ sTyCost[iStrTot] = "$" + sTyCost[iStrTot]; }
           	 	if(sTyRet[iStrTot].equals("0")){sTyRet[iStrTot] = "";} else{ sTyRet[iStrTot] = "$" + sTyRet[iStrTot]; }
           	 	if(sTyGm$[iStrTot].equals("0")){sTyGm$[iStrTot] = "";} else{ sTyGm$[iStrTot] = "$" + sTyGm$[iStrTot]; }
           	    if(sTyDscPrc[iStrTot].equals("0")){sTyDscPrc[iStrTot] = "";} else{ sTyDscPrc[iStrTot] = sTyDscPrc[iStrTot] + "%"; }
           	 	
           	 	if(sLyDisc[iStrTot].equals("0")){sLyDisc[iStrTot] = "";} else{ sLyDisc[iStrTot] = "$" + sLyDisc[iStrTot]; } 
     	 		if(sLyCost[iStrTot].equals("0")){sLyCost[iStrTot] = "";} else{ sLyCost[iStrTot] = "$" + sLyCost[iStrTot]; }
     	 		if(sLyRet[iStrTot].equals("0")){sLyRet[iStrTot] = "";} else{ sLyRet[iStrTot] = "$" + sLyRet[iStrTot]; }
     	    	if(sLyGm$[iStrTot].equals("0")){sLyGm$[iStrTot] = "";} else{ sLyGm$[iStrTot] = "$" + sLyGm$[iStrTot]; }
     	    	if(sLyDscPrc[iStrTot].equals("0")){sLyDscPrc[iStrTot] = "";} else{ sLyDscPrc[iStrTot] = sLyDscPrc[iStrTot] + "%"; }
                %>             
                   <td id="tdGrp<%=i%>" class="td12" nowrap>
                	   <a>
                	   <span id="spnRegTyDisc<%=i%>_<%=iStrTot%>" style="display: none;"><%=sTyDisc[iStrTot]%></span>
                	   <span id="spnRegTyCost<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyCost[iStrTot]%></span>
                	   <span id="spnRegTyRet<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyRet[iStrTot]%></span>
                	   <span id="spnRegTyGm$<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyGm$[iStrTot]%></span>
                	   <span id="spnRegTyDscPrc<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyDscPrc[iStrTot]%></span>
                	   </a>
                	</td>
                	<td class="td82" nowrap>             		    
             			<a>   
                	   <span id="spnRegLyDisc<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyDisc[iStrTot]%></span>
                	   <span id="spnRegLyCost<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyCost[iStrTot]%></span>
                	   <span id="spnRegLyRet<%=i%>_<%=iStrTot%>" style="display: none;"><%=sLyRet[iStrTot]%></span>
                	   <span id="spnRegLyGm$<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyGm$[iStrTot]%></span>                	   
                	   <span id="spnRegLyDscPrc<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyDscPrc[iStrTot]%></span>
                	   </a>
                	</td>   
                	
             <%// store totals
             iStrTot = iNumOfDsc;
             if(sTyDisc[iStrTot].equals("0")){sTyDisc[iStrTot] = "";} else{ sTyDisc[iStrTot] = "$" + sTyDisc[iStrTot]; } 
        	 if(sTyCost[iStrTot].equals("0")){sTyCost[iStrTot] = "";} else{ sTyCost[iStrTot] = "$" + sTyCost[iStrTot]; }
        	 if(sTyRet[iStrTot].equals("0")){sTyRet[iStrTot] = "";} else{ sTyRet[iStrTot] = "$" + sTyRet[iStrTot]; }
        	 if(sTyGm$[iStrTot].equals("0")){sTyGm$[iStrTot] = "";} else{ sTyGm$[iStrTot] = "$" + sTyGm$[iStrTot]; }        	 
        	 if(sTyDscPrc[iStrTot].equals("0")){sTyDscPrc[iStrTot] = "";} else{ sTyDscPrc[iStrTot] = sTyDscPrc[iStrTot] + "%"; }
        	 
        	 if(sLyDisc[iStrTot].equals("0")){sLyDisc[iStrTot] = "";} else{ sLyDisc[iStrTot] = "$" + sLyDisc[iStrTot]; } 
  	 		 if(sLyCost[iStrTot].equals("0")){sLyCost[iStrTot] = "";} else{ sLyCost[iStrTot] = "$" + sLyCost[iStrTot]; }
  	 		 if(sLyRet[iStrTot].equals("0")){sLyRet[iStrTot] = "";} else{ sLyRet[iStrTot] = "$" + sLyRet[iStrTot]; }
  	    	 if(sLyGm$[iStrTot].equals("0")){sLyGm$[iStrTot] = "";} else{ sLyGm$[iStrTot] = "$" + sLyGm$[iStrTot]; }
  	      	 if(sLyDscPrc[iStrTot].equals("0")){sLyDscPrc[iStrTot] = "";} else{ sLyDscPrc[iStrTot] = sLyDscPrc[iStrTot] + "%"; }
             %>             
                <td id="tdGrp<%=i%>" class="td12" nowrap>
             	   <a>
             	   <span id="spnRegTyDisc<%=i%>_<%=iStrTot%>" style="display: none;"><%=sTyDisc[iStrTot]%></span>
             	   <span id="spnRegTyCost<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyCost[iStrTot]%></span>
             	   <span id="spnRegTyRet<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyRet[iStrTot]%></span>
             	   <span id="spnRegTyGm$<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyGm$[iStrTot]%></span>
             	   <span id="spnRegTyDscPrc<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyDscPrc[iStrTot]%></span>
             	   </a>
             	</td>
             	<td class="td82" nowrap>             		    
          			<a>   
             	   <span id="spnRegLyDisc<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyDisc[iStrTot]%></span>
             	   <span id="spnRegLyCost<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyCost[iStrTot]%></span>
             	   <span id="spnRegLyRet<%=i%>_<%=iStrTot%>" style="display: none;"><%=sLyRet[iStrTot]%></span>
             	   <span id="spnRegLyGm$<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyGm$[iStrTot]%></span>
             	   <span id="spnRegLyDscPrc<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyDscPrc[iStrTot]%></span>                	   
             	   </a>
             	</td>     	
                
                <%
             	// store totals
                iStrTot = 28;
                if(sTyDisc[iStrTot].equals("0")){sTyDisc[iStrTot] = "";} else{ sTyDisc[iStrTot] = "$" + sTyDisc[iStrTot]; } 
           	 	if(sTyCost[iStrTot].equals("0")){sTyCost[iStrTot] = "";} else{ sTyCost[iStrTot] = "$" + sTyCost[iStrTot]; }
           	 	if(sTyRet[iStrTot].equals("0")){sTyRet[iStrTot] = "";} else{ sTyRet[iStrTot] = "$" + sTyRet[iStrTot]; }
           	 	if(sTyGm$[iStrTot].equals("0")){sTyGm$[iStrTot] = "";} else{ sTyGm$[iStrTot] = "$" + sTyGm$[iStrTot]; }
           	    if(sTyDscPrc[iStrTot].equals("0")){sTyDscPrc[iStrTot] = "";} else{ sTyDscPrc[iStrTot] = sTyDscPrc[iStrTot] + "%"; }
           	 	
           	 	if(sLyDisc[iStrTot].equals("0")){sLyDisc[iStrTot] = "";} else{ sLyDisc[iStrTot] = "$" + sLyDisc[iStrTot]; } 
     	 		if(sLyCost[iStrTot].equals("0")){sLyCost[iStrTot] = "";} else{ sLyCost[iStrTot] = "$" + sLyCost[iStrTot]; }
     	 		if(sLyRet[iStrTot].equals("0")){sLyRet[iStrTot] = "";} else{ sLyRet[iStrTot] = "$" + sLyRet[iStrTot]; }
     	    	if(sLyGm$[iStrTot].equals("0")){sLyGm$[iStrTot] = "";} else{ sLyGm$[iStrTot] = "$" + sLyGm$[iStrTot]; }
     	    	if(sLyDscPrc[iStrTot].equals("0")){sLyDscPrc[iStrTot] = "";} else{ sLyDscPrc[iStrTot] = sLyDscPrc[iStrTot] + "%"; }
                %>             
                   <td id="tdGrp<%=i%>" class="td12" nowrap>
                	   <a>
                	   <span id="spnRegTyDisc<%=i%>_<%=iStrTot%>" style="display: none;"><%=sTyDisc[iStrTot]%></span>
                	   <span id="spnRegTyCost<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyCost[iStrTot]%></span>
                	   <span id="spnRegTyRet<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyRet[iStrTot]%></span>
                	   <span id="spnRegTyGm$<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyGm$[iStrTot]%></span>
                	   <span id="spnRegTyDscPrc<%=i%>_<%=iStrTot%>" style="display: none"><%=sTyDscPrc[iStrTot]%></span>
                	   </a>
                	</td>
                	<td class="td82" nowrap>             		    
             			<a>   
                	   <span id="spnRegLyDisc<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyDisc[iStrTot]%></span>
                	   <span id="spnRegLyCost<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyCost[iStrTot]%></span>
                	   <span id="spnRegLyRet<%=i%>_<%=iStrTot%>" style="display: none;"><%=sLyRet[iStrTot]%></span>
                	   <span id="spnRegLyGm$<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyGm$[iStrTot]%></span>                	   
                	   <span id="spnRegLyDscPrc<%=i%>_<%=iStrTot%>" style="display: none"><%=sLyDscPrc[iStrTot]%></span>
                	   </a>
                	</td>	
                	
                	<td id="tdRegTySlsPrc" class="td12" nowrap><%if(!sTySlsPrc.equals(".0")){%><%=sTySlsPrc%>%<%} else {%>&nbsp;<%}%></td>
                    <td id="tdRegLySlsPrc" class="td12" nowrap><%if(!sLySlsPrc.equals(".0")){%><%=sLySlsPrc%>%<%} else {%>&nbsp;<%}%></td>
                	
                	<td class="td11" nowrap>Dist <%=sStr%></td>	
           	 </tr>
           	 
           	 
           	      
           <%}%>
           
           
           <%
             audsum.setRepTot();
      	 	 String sStr = audsum.getStr();
    	 	 String [] sTyDisc = audsum.getTyDisc();
    	 	 String [] sTyCost = audsum.getTyCost();
    	 	 String [] sTyRet = audsum.getTyRet();
    	 	 String [] sTyGm$ = audsum.getTyGm$();
    	 	 String [] sTyDscPrc = audsum.getTyDscPrc();
    	 	 String sTySlsPrc = audsum.getTySlsPrc();
    	 	 
    	 	 String [] sLyRet = audsum.getLyRet();
       	 	 String [] sLyCost = audsum.getLyCost();
       	 	 String [] sLyDisc = audsum.getLyDisc();
       	 	 String [] sLyGm$ = audsum.getLyGm$();
       	 	 String [] sLyDscPrc = audsum.getLyDscPrc();
       	     String sLySlsPrc = audsum.getLySlsPrc();
    	   %>
		   <tr id="trTotal" class="trDtl15">
             <td class="td11" nowrap>Totals</td>              
             <%for(int j=0; j < iNumOfDsc; j++){
            	 if(sTyDisc[j].equals("0")){sTyDisc[j] = "";} else{ sTyDisc[j] = "$" + sTyDisc[j]; }
            	 if(sTyCost[j].equals("0")){sTyCost[j] = "";} else{ sTyCost[j] = "$" + sTyCost[j]; }
            	 if(sTyRet[j].equals("0")){sTyRet[j] = "";} else{ sTyRet[j] = "$" + sTyRet[j]; }
            	 if(sTyGm$[j].equals("0")){sTyGm$[j] = "";} else{ sTyGm$[j] = "$" + sTyGm$[j]; }
            	 if(sTyDscPrc[j].equals("0")){sTyDscPrc[j] = "";} else{ sTyDscPrc[j] = sTyDscPrc[j] + "%"; }
            	 
            	 if(sLyDisc[j].equals("0")){sLyDisc[j] = "";} else{ sLyDisc[j] = "$" + sLyDisc[j]; }
            	 if(sLyCost[j].equals("0")){sLyCost[j] = "";} else{ sLyCost[j] = "$" + sLyCost[j]; }
            	 if(sLyRet[j].equals("0")){sLyRet[j] = "";} else{ sLyRet[j] = "$" + sLyRet[j]; }
            	 if(sLyGm$[j].equals("0")){sLyGm$[j] = "";} else{ sLyGm$[j] = "$" + sLyGm$[j]; }
            	 if(sLyDscPrc[j].equals("0")){sLyDscPrc[j] = "";} else{ sLyDscPrc[j] = sLyDscPrc[j] + "%"; }
             %>
             	<td class="td12" nowrap>
             	    <%if(!sCode[j].equals("00") && !sCode[j].equals("10")){%>
             	    	<a href="javascript: crtExcel('TY', 'ALL', '<%=sCode[j]%>')">
             	    <%} else {%><a><%}%>
             		<span id="spnTotTyDisc<%=j%>" style="display: none;"><%=sTyDisc[j]%></span>
             	   	<span id="spnTotTyCost<%=j%>" style="display: none"><%=sTyCost[j]%></span>
             	   	<span id="spnTotTyRet<%=j%>" style="display: none"><%=sTyRet[j]%></span>
             	   	<span id="spnTotTyGm$<%=j%>" style="display: none"><%=sTyGm$[j]%></span>
             	   	<span id="spnTotTyDscPrc<%=j%>" style="display: none"><%=sTyDscPrc[j]%></span>
             	   	</a>
             	</td>
             	
             	<td class="td82" nowrap>
             	    <%if(!sCode[j].equals("00") && !sCode[j].equals("10")){%>
             	    	<a href="javascript: crtExcel('LY', 'ALL', '<%=sCode[j]%>')">
             	    <%} else {%><a><%}%>
             		<span id="spnTotLyDisc<%=j%>" style="display: none;"><%=sLyDisc[j]%></span>
             	   	<span id="spnTotLyCost<%=j%>" style="display: none"><%=sLyCost[j]%></span>
             	   	<span id="spnTotLyRet<%=j%>" style="display: none"><%=sLyRet[j]%></span>
             	   	<span id="spnTotLyGm$<%=j%>" style="display: none"><%=sLyGm$[j]%></span>
             	   	<span id="spnTotLyDscPrc<%=j%>" style="display: none"><%=sLyDscPrc[j]%></span>
             	   	</a>
             	</td>
             <%}%>
          	 
          	 <%
             // store totals
             int iStrTot = 29;
             if(sTyDisc[iStrTot].equals("0")){sTyDisc[iStrTot] = "";} else{ sTyDisc[iStrTot] = "$" + sTyDisc[iStrTot]; }
        	 if(sTyCost[iStrTot].equals("0")){sTyCost[iStrTot] = "";} else{ sTyCost[iStrTot] = "$" + sTyCost[iStrTot]; }
        	 if(sTyRet[iStrTot].equals("0")){sTyRet[iStrTot] = "";} else{ sTyRet[iStrTot] = "$" + sTyRet[iStrTot]; }
        	 if(sTyGm$[iStrTot].equals("0")){sTyGm$[iStrTot] = "";} else{ sTyGm$[iStrTot] = "$" + sTyGm$[iStrTot]; }
        	 if(sTyDscPrc[iStrTot].equals("0")){sTyDscPrc[iStrTot] = "";} else{ sTyDscPrc[iStrTot] = sTyDscPrc[iStrTot] + "%"; }
        	 
        	 if(sLyDisc[iStrTot].equals("0")){sLyDisc[iStrTot] = "";} else{ sLyDisc[iStrTot] = "$" + sLyDisc[iStrTot]; }
        	 if(sLyCost[iStrTot].equals("0")){sLyCost[iStrTot] = "";} else{ sLyCost[iStrTot] = "$" + sLyCost[iStrTot]; }
        	 if(sLyRet[iStrTot].equals("0")){sLyRet[iStrTot] = "";} else{ sLyRet[iStrTot] = "$" + sLyRet[iStrTot]; }
        	 if(sLyGm$[iStrTot].equals("0")){sLyGm$[iStrTot] = "";} else{ sLyGm$[iStrTot] = "$" + sLyGm$[iStrTot]; }
        	 if(sLyDscPrc[iStrTot].equals("0")){sLyDscPrc[iStrTot] = "";} else{ sLyDscPrc[iStrTot] = sLyDscPrc[iStrTot] + "%"; }
             %>             
                <td class="td12" nowrap>
             	   <a>
             	   <span id="spnTotTyDisc<%=iStrTot%>" style="display: none;"><%=sTyDisc[iStrTot]%></span>
             	   <span id="spnTotTyCost<%=iStrTot%>" style="display: none"><%=sTyCost[iStrTot]%></span>
             	   <span id="spnTotTyRet<%=iStrTot%>" style="display: none"><%=sTyRet[iStrTot]%></span>
             	   <span id="spnTotTyGm$<%=iStrTot%>" style="display: none"><%=sTyGm$[iStrTot]%></span>
             	   <span id="spnTotTyDscPrc<%=iStrTot%>" style="display: none"><%=sTyDscPrc[iStrTot]%></span>
             	   </a>
             	</td>     
             	<td class="td82" nowrap>
             	   <a>
             	   <span id="spnTotLyDisc<%=iStrTot%>" style="display: none;"><%=sLyDisc[iStrTot]%></span>
             	   <span id="spnTotLyCost<%=iStrTot%>" style="display: none"><%=sLyCost[iStrTot]%></span>
             	   <span id="spnTotLyRet<%=iStrTot%>" style="display: none"><%=sLyRet[iStrTot]%></span>
             	   <span id="spnTotLyGm$<%=iStrTot%>" style="display: none"><%=sLyGm$[iStrTot]%></span>
             	   <span id="spnTotLyDscPrc<%=iStrTot%>" style="display: none"><%=sLyDscPrc[iStrTot]%></span>
             	   </a>
             	</td> 
             	
             <%// store totals
             iStrTot = iNumOfDsc;
             if(sTyDisc[iStrTot].equals("0")){sTyDisc[iStrTot] = "";} else{ sTyDisc[iStrTot] = "$" + sTyDisc[iStrTot]; }
        	 if(sTyCost[iStrTot].equals("0")){sTyCost[iStrTot] = "";} else{ sTyCost[iStrTot] = "$" + sTyCost[iStrTot]; }
        	 if(sTyRet[iStrTot].equals("0")){sTyRet[iStrTot] = "";} else{ sTyRet[iStrTot] = "$" + sTyRet[iStrTot]; }
        	 if(sTyGm$[iStrTot].equals("0")){sTyGm$[iStrTot] = "";} else{ sTyGm$[iStrTot] = "$" + sTyGm$[iStrTot]; }
        	 if(sTyDscPrc[iStrTot].equals("0")){sTyDscPrc[iStrTot] = "";} else{ sTyDscPrc[iStrTot] = sTyDscPrc[iStrTot] + "%"; }
        	 
        	 if(sLyDisc[iStrTot].equals("0")){sLyDisc[iStrTot] = "";} else{ sLyDisc[iStrTot] = "$" + sLyDisc[iStrTot]; }
        	 if(sLyCost[iStrTot].equals("0")){sLyCost[iStrTot] = "";} else{ sLyCost[iStrTot] = "$" + sLyCost[iStrTot]; }
        	 if(sLyRet[iStrTot].equals("0")){sLyRet[iStrTot] = "";} else{ sLyRet[iStrTot] = "$" + sLyRet[iStrTot]; }
        	 if(sLyGm$[iStrTot].equals("0")){sLyGm$[iStrTot] = "";} else{ sLyGm$[iStrTot] = "$" + sLyGm$[iStrTot]; }
        	 if(sLyDscPrc[iStrTot].equals("0")){sLyDscPrc[iStrTot] = "";} else{ sLyDscPrc[iStrTot] = sLyDscPrc[iStrTot] + "%"; }
             %>             
                <td class="td12" nowrap>
             	   <a>
             	   <span id="spnTotTyDisc<%=iStrTot%>" style="display: none;"><%=sTyDisc[iStrTot]%></span>
             	   <span id="spnTotTyDscPrc<%=iStrTot%>" style="display: none;"><%=sTyDscPrc[iStrTot]%></span>
             	   <span id="spnTotTyCost<%=iStrTot%>" style="display: none"><%=sTyCost[iStrTot]%></span>
             	   <span id="spnTotTyRet<%=iStrTot%>" style="display: none"><%=sTyRet[iStrTot]%></span>
             	   <span id="spnTotTyGm$<%=iStrTot%>" style="display: none"><%=sTyGm$[iStrTot]%></span>
             	   <span id="spnTotTyDscPrc<%=iStrTot%>" style="display: none"><%=sTyDscPrc[iStrTot]%></span>
             	   </a>
             	</td>     
             	<td class="td82" nowrap>
             	   <a>
             	   <span id="spnTotLyDisc<%=iStrTot%>" style="display: none;"><%=sLyDisc[iStrTot]%></span>
             	   <span id="spnTotLyCost<%=iStrTot%>" style="display: none"><%=sLyCost[iStrTot]%></span>
             	   <span id="spnTotLyRet<%=iStrTot%>" style="display: none"><%=sLyRet[iStrTot]%></span>
             	   <span id="spnTotLyGm$<%=iStrTot%>" style="display: none"><%=sLyGm$[iStrTot]%></span>
             	   <span id="spnTotLyDscPrc<%=iStrTot%>" style="display: none"><%=sLyDscPrc[iStrTot]%></span>
             	   </a>
             	</td>
             	
             	<%
             // store totals
             iStrTot = 28;
             if(sTyDisc[iStrTot].equals("0")){sTyDisc[iStrTot] = "";} else{ sTyDisc[iStrTot] = "$" + sTyDisc[iStrTot]; }
        	 if(sTyCost[iStrTot].equals("0")){sTyCost[iStrTot] = "";} else{ sTyCost[iStrTot] = "$" + sTyCost[iStrTot]; }
        	 if(sTyRet[iStrTot].equals("0")){sTyRet[iStrTot] = "";} else{ sTyRet[iStrTot] = "$" + sTyRet[iStrTot]; }
        	 if(sTyGm$[iStrTot].equals("0")){sTyGm$[iStrTot] = "";} else{ sTyGm$[iStrTot] = "$" + sTyGm$[iStrTot]; }
        	 if(sTyDscPrc[iStrTot].equals("0")){sTyDscPrc[iStrTot] = "";} else{ sTyDscPrc[iStrTot] = sTyDscPrc[iStrTot] + "%"; }
        	 
        	 if(sLyDisc[iStrTot].equals("0")){sLyDisc[iStrTot] = "";} else{ sLyDisc[iStrTot] = "$" + sLyDisc[iStrTot]; }
        	 if(sLyCost[iStrTot].equals("0")){sLyCost[iStrTot] = "";} else{ sLyCost[iStrTot] = "$" + sLyCost[iStrTot]; }
        	 if(sLyRet[iStrTot].equals("0")){sLyRet[iStrTot] = "";} else{ sLyRet[iStrTot] = "$" + sLyRet[iStrTot]; }
        	 if(sLyGm$[iStrTot].equals("0")){sLyGm$[iStrTot] = "";} else{ sLyGm$[iStrTot] = "$" + sLyGm$[iStrTot]; }
        	 if(sLyDscPrc[iStrTot].equals("0")){sLyDscPrc[iStrTot] = "";} else{ sLyDscPrc[iStrTot] = sLyDscPrc[iStrTot] + "%"; }
             %>             
                <td class="td12" nowrap>
             	   <a>
             	   <span id="spnTotTyDisc<%=iStrTot%>" style="display: none;"><%=sTyDisc[iStrTot]%></span>
             	   <span id="spnTotTyCost<%=iStrTot%>" style="display: none"><%=sTyCost[iStrTot]%></span>
             	   <span id="spnTotTyRet<%=iStrTot%>" style="display: none"><%=sTyRet[iStrTot]%></span>
             	   <span id="spnTotTyGm$<%=iStrTot%>" style="display: none"><%=sTyGm$[iStrTot]%></span>
             	   <span id="spnTotTyDscPrc<%=iStrTot%>" style="display: none"><%=sTyDscPrc[iStrTot]%></span>
             	   </a>
             	</td>     
             	<td class="td82" nowrap>
             	   <a>
             	   <span id="spnTotLyDisc<%=iStrTot%>" style="display: none;"><%=sLyDisc[iStrTot]%></span>
             	   <span id="spnTotLyCost<%=iStrTot%>" style="display: none"><%=sLyCost[iStrTot]%></span>
             	   <span id="spnTotLyRet<%=iStrTot%>" style="display: none"><%=sLyRet[iStrTot]%></span>
             	   <span id="spnTotLyGm$<%=iStrTot%>" style="display: none"><%=sLyGm$[iStrTot]%></span>
             	   <span id="spnTotLyDscPrc<%=iStrTot%>" style="display: none"><%=sLyDscPrc[iStrTot]%></span>
             	   </a>
             	</td>
             	
             	<td id="tdTotTySlsPrc" class="td12" nowrap><%if(!sTySlsPrc.equals(".0")){%><%=sTySlsPrc%>%<%} else {%>&nbsp;<%}%></td>
                <td id="tdTotLySlsPrc" class="td12" nowrap><%if(!sLySlsPrc.equals(".0")){%><%=sLySlsPrc%>%<%} else {%>&nbsp;<%}%></td>
             	 	
             	<td class="td11" nowrap>Totals</td>            		         
           </tr>            
           <%}%>
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
	if(audsum != null)
	{
		audsum.disconnect();
		audsum = null;
	}
}
%>