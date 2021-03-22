<%@ page import="salesreport.CouponSumRep, java.util.*, java.text.*"%>
<%
   String sFrom = request.getParameter("FrDate");   
   String sTo = request.getParameter("ToDate");
   String sInclDiv = request.getParameter("InclDiv");
   String sBogo = request.getParameter("Bogo");
   String sSelCode = request.getParameter("Code");
   String sCust = request.getParameter("Cust");
   
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
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=CouponSumRep.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	CouponSumRep coupsum = null;
    int iNumOfStr = 0;
    int iNumOfReg = 0; 
    int iNumOfDsc = 0; 
    String [] sStr = new String[]{};
    String sLyFrDate = "";
    String sLyToDate = "";
    
    if(sFrom != null)
    {
    	coupsum = new CouponSumRep(sFrom, sTo, sInclDiv, sBogo, sSelCode, sCust);
    	
    	iNumOfStr = coupsum.getNumOfStr();
    	sStr = coupsum.getStr(); 
    	
    	iNumOfDsc = coupsum.getNumOfDsc();
    	
        sLyFrDate = coupsum.getLyFrDate();
        sLyToDate = coupsum.getLyToDate();
    } 
%>
<html>
<head>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Market Code Summary</title>

<SCRIPT>

//--------------- Global variables -----------------------
var NumOfStr = "<%=iNumOfStr%>";
var NumOfReg = "<%=iNumOfReg%>";
var NumOfDsc = "<%=iNumOfDsc%>";
var LyFrDate = "<%=sLyFrDate%>";
var LyToDate = "<%=sLyToDate%>";

var SelObjNm = null;
 //--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
   	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}

//==============================================================================
//initial process
//==============================================================================
function setType(inp)
{
	var type = inp.value;
	
	var dispDisc = "none";
	var dispCost = "none";
	var dispRet = "none";
	var dispGm$ = "none";
	
	if(type == "U"){ dispDisc = "table-cell"; }
	if(type == "C"){ dispCost = "table-cell"; }
	if(type == "R"){ dispRet = "table-cell"; }
	if(type == "G"){ dispGm$ = "table-cell"; }
	
	// set displayn for stores
	for(var i=0; i < NumOfStr; i++)
	{
		for(var j=0; j < NumOfDsc; j++)
		{
			setFldDisp("spnTyDisc" + i + "_" + j, dispDisc);
			setFldDisp("spnTyCost" + i + "_" + j, dispCost);
			setFldDisp("spnTyRet" + i + "_" + j, dispRet);
			setFldDisp("spnTyGm$" + i + "_" + j, dispGm$);
			
			setFldDisp("spnLyDisc" + i + "_" + j, dispDisc);
			setFldDisp("spnLyCost" + i + "_" + j, dispCost);
			setFldDisp("spnLyRet" + i + "_" + j, dispRet);
			setFldDisp("spnLyGm$" + i + "_" + j, dispGm$);
		}
		var k = 29;
		setFldDisp("spnTyDisc" + i + "_" + k, dispDisc);
		setFldDisp("spnTyCost" + i + "_" + k, dispCost);
		setFldDisp("spnTyRet" + i + "_" + k, dispRet);
		setFldDisp("spnTyGm$" + i + "_" + k, dispGm$);
		
		setFldDisp("spnLyDisc" + i + "_" + k, dispDisc);
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
			setFldDisp("spnRegTyCost" + i + "_" + j, dispCost);
			setFldDisp("spnRegTyRet" + i + "_" + j, dispRet);
			setFldDisp("spnRegTyGm$" + i + "_" + j, dispGm$);
			
			setFldDisp("spnRegLyDisc" + i + "_" + j, dispDisc);
			setFldDisp("spnRegLyCost" + i + "_" + j, dispCost);
			setFldDisp("spnRegLyRet" + i + "_" + j, dispRet);
			setFldDisp("spnRegLyGm$" + i + "_" + j, dispGm$);
		}
		var k = 29;
		setFldDisp("spnRegTyDisc" + i + "_" + k, dispDisc);
		setFldDisp("spnRegTyCost" + i + "_" + k, dispCost);
		setFldDisp("spnRegTyRet" + i + "_" + k, dispRet);
		setFldDisp("spnRegTyGm$" + i + "_" + k, dispGm$);
		
		setFldDisp("spnRegLyDisc" + i + "_" + k, dispDisc);
		setFldDisp("spnRegLyCost" + i + "_" + k, dispCost);
		setFldDisp("spnRegLyRet" + i + "_" + k, dispRet);
		setFldDisp("spnRegLyGm$" + i + "_" + k, dispGm$);
	}
	
	for(var j=0; j < NumOfDsc; j++)
	{   
		setFldDisp("spnTotTyDisc" + j, dispDisc);
		setFldDisp("spnTotTyCost" + j, dispCost);
		setFldDisp("spnTotTyRet" + j, dispRet);
		setFldDisp("spnTotTyGm$" + j, dispGm$);
		
		setFldDisp("spnTotLyDisc" + j, dispDisc);
		setFldDisp("spnTotLyCost" + j, dispCost);
		setFldDisp("spnTotLyRet" + j, dispRet);
		setFldDisp("spnTotLyGm$" + j, dispGm$);
	}
	
	var k = 29;
	setFldDisp("spnTotTyDisc" + k, dispDisc);
	setFldDisp("spnTotTyCost" + k, dispCost);
	setFldDisp("spnTotTyRet" + k, dispRet);
	setFldDisp("spnTotTyGm$" + k, dispGm$);
	
	setFldDisp("spnTotLyDisc" + k, dispDisc);
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
function rtvDiscDtl(year, str, coup, sort)
{
	var url = "CouponSumRepDtl.jsp?Str=" + str
	 + "&Coup=" + coup
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
		   , reg, tran, date, cash, clsNm, slsp, div, coup, coupNm )
{
	var hdr = "Str: " + str 
	if( code!="EMP" ){ hdr += " Code: " + code; }
	else{ hdr += " Employee Purchase"; }
	
	  var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popDiscDtl(str, code, year, frdate, todate, cls, ven, sty, clr, siz, ret, cost, disc
	    	, qty, desc, sku, gtin, venSty, clrNm, sizNm, venNm, reg, tran, date, cash, clsNm
	    	, slsp, div, coup, coupNm)
	     + "</td></tr>"
	   + "</table>"

	  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "1300";}
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
	, slsp, div, coup, coupNm )
{
	var link1 = "<a href='javascript: rtvDiscDtl(&#34;" + year + "&#34;" 
	   + ",&#34;" + str + "&#34;,&#34;" + code + "&#34;, &#34;Cashier&#34;)'>Cashier<a>";
	var link2 = "<a href='javascript: rtvDiscDtl(&#34;" + year + "&#34;" 
	   + ",&#34;" + str + "&#34;,&#34;" + code + "&#34;, &#34;Retail&#34;)'>Ret<a>";  
	   
	var link3 = "<a href='javascript: rtvDiscDtl(&#34;" + year + "&#34;" 
	   + ",&#34;" + str + "&#34;,&#34;" + code + "&#34;, &#34;Div&#34;)'>Div<a>";  
	
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
       + "<th class='th01'>Vendor Name</th>"
       + "<th class='th01'>Sku</th>"       
       + "<th class='th01'>GTIN</th>"
       + "<th class='th01'>Qty</th>" 
       + "<th class='th01'>" + link2 + "</th>"
       + "<th class='th01'>Disc</th>"
       + "<th class='th01'>Coupon</th>"
       + "<th class='th01'>Coupon Name</th>"
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
	      + "<td nowrap class='td12'>" + ret[i] + "</td>"
	      + "<td nowrap class='td12'>" + disc[i] + "</td>"	
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
function crtExcel(year, coup, str)
{
	var url = "CouponSumRepDtlExcel.jsp?Str=" + str
	 + "&Coup=" + coup 
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
      <table class="tbl01">
        <tr class="trHdr">
          <th style="width=20%">
            <b>Retail Concepts, Inc
            <br>Market Code Summary
            <br><%if(coupsum != null){%>From: <%=sFrom%>&nbsp;
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
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="CouponSumRepSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;
            
          </th>
          <th>&nbsp;</th>
        </tr>
        
        <tr class="trHdr">
        <th  style="width=40%">
                    
          <br>
          <br>
              <input type="radio" name="inpType" id=="inpType" value="R" onclick="setType(this)">Retail &nbsp; &nbsp; &nbsp;
              <!-- input type="radio" name="inpType" id=="inpType" value="C" onclick="setType(this)" >Cost &nbsp; &nbsp; &nbsp; -->
              <input type="radio" name="inpType" id=="inpType" value="U" onclick="setType(this)" checked>Discount &nbsp; &nbsp; &nbsp;                            
              <input type="radio" name="inpType" id=="inpType" value="G" onclick="setType(this)" >GM $	  
        </th>
        <th>&nbsp;</th>
        </tr>
        
        <tr>
          <td colspan=2>  
      <table class="tbl02">
        <tr class="trHdr01">
         	<th class="th02" rowspan=3>Coupon</th>
         	<th class="th02" rowspan=3>Name</th>
          	<th class="th02" colspan="<%=iNumOfStr * 2%>">Stores</th>
          	<th class="th02" rowspan=2 colspan=2>Store<br>Total</th>
          	<th class="th02" rowspan=3>Coupon</th>          	
        </tr>
        
        <tr class="trHdr01">
            <%for(int i=0; i < iNumOfStr; i++){%>
        		<th class="th02" colspan="2"><%=sStr[i]%></th>
        	<%} %>
        </tr>
        <tr class="trHdr01">
            <%for(int i=0; i < iNumOfStr+1; i++){%>
        		<th class="th02">TY</th>
        		<th class="th02">LY</th>
        	<%} %>        	
        </tr>
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl04"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfDsc; i++) {        	   
        	   	coupsum.setAudLst();
          	 	String sCoup = coupsum.getCoup();
          	 	String sCoupNm = coupsum.getCoupNm();

           	 	String [] sTyRet = coupsum.getTyRet();
           	 	String [] sTyCost = coupsum.getTyCost();
           	 	String [] sTyDisc = coupsum.getTyDisc();
           	 	String [] sTyGm$ = coupsum.getTyGm$();
           	   
           	 	String [] sLyRet = coupsum.getLyRet();
           	 	String [] sLyCost = coupsum.getLyCost();
           	 	String [] sLyDisc = coupsum.getLyDisc();
           	 	String [] sLyGm$ = coupsum.getLyGm$();
           	   
   				//if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
   				//else {sTrCls = "trDtl06";}   			
           %>
           <%if(i > 1 && i%20==0){%>
           	<tr class="trHdr01">
           	    <th class="th02" rowspan=2>Coupon</th>
           	    <th class="th02" rowspan=2>Name</th>
            	<%for(int j=0; j < iNumOfStr; j++){%>
        			<th class="th02" colspan="2"><%=sStr[j]%></th>
        		<%} %>
        		<th class="th02" colspan=2>Total</th>
        		<th class="th02" rowspan=2>Coupon</th>
        	</tr>
        	<tr class="trHdr01">
            <%for(int j=0; j < iNumOfStr+1; j++){%>
        		<th class="th02">TY</th>
        		<th class="th02">LY</th>
        	<%}%>
        </tr>
           
           <%}%>                           
           <tr id="trGrp<%=i%>" class="<%=sTrCls%>">             
             <td id="tdGrp<%=i%>" class="td11" nowrap><%=sCoup%></td>
             <td id="tdGrp<%=i%>" class="td11" nowrap><%=sCoupNm%></td>
             <%for(int j=0; j < iNumOfStr; j++){
            	 //System.out.print("|" + sTyDisc[j]);
            	 if(sTyDisc[j].equals("")){sTyDisc[j] = "";} else{ sTyDisc[j] = "$" + sTyDisc[j]; }
            	 if(sTyCost[j].equals("")){sTyCost[j] = "";} else{ sTyCost[j] = "$" + sTyCost[j]; }
            	 if(sTyRet[j].equals("")){sTyRet[j] = "";} else{ sTyRet[j] = "$" + sTyRet[j]; }
            	 if(sTyGm$[j].equals("")){sTyGm$[j] = "";} else{ sTyGm$[j] = "$" + sTyGm$[j]; }
            	 
            	 if(sLyDisc[j].equals("")){sLyDisc[j] = "";} else{ sLyDisc[j] = "$" + sLyDisc[j]; }
            	 if(sLyCost[j].equals("")){sLyCost[j] = "";} else{ sLyCost[j] = "$" + sLyCost[j]; }
            	 if(sLyRet[j].equals("")){sLyRet[j] = "";} else{ sLyRet[j] = "$" + sLyRet[j]; }
            	 if(sLyGm$[j].equals("")){sLyGm$[j] = "";} else{ sLyGm$[j] = "$" + sLyGm$[j]; }
             %>
             	<td id="tdTyCode<%=i%>_<%=j%>" class="td12" nowrap>
             	   
             	   <a href="javascript: rtvDiscDtl('TY','<%=sStr[j]%>','<%=sCoup%>', 'Div')">
             	   <span id="spnTyDisc<%=i%>_<%=j%>" style="text-align:right;"><%=sTyDisc[j]%></span>
             	   <span id="spnTyCost<%=i%>_<%=j%>" style="display: none"><%=sTyCost[j]%></span>
             	   <span id="spnTyRet<%=i%>_<%=j%>" style="display: none"><%=sTyRet[j]%></span>
             	   <span id="spnTyGm$<%=i%>_<%=j%>" style="display: none"><%=sTyGm$[j]%></span>
             	   </a>
             	</td>
             	
             	<td id="tdLyCode<%=i%>_<%=j%>" class="td82" nowrap>
             	   <a href="javascript: rtvDiscDtl('LY','<%=sStr[j]%>','<%=sCoup%>','<%=j%>', 'Div')">
             	   <span id="spnLyDisc<%=i%>_<%=j%>" style="text-align:right;"><%=sLyDisc[j]%></span>
             	   <span id="spnLyCost<%=i%>_<%=j%>" style="display: none"><%=sLyCost[j]%></span>
             	   <span id="spnLyRet<%=i%>_<%=j%>" style="display: none"><%=sLyRet[j]%></span>
             	   <span id="spnLyGm$<%=i%>_<%=j%>" style="display: none"><%=sLyGm$[j]%></span>
             	   </a>
             	</td>             	
             <%}%>
             <%
             int iStr = iNumOfStr;
             if(sTyDisc[iStr].equals("0")){sTyDisc[iStr] = "";} else{ sTyDisc[iStr] = "$" + sTyDisc[iStr]; }
        	 if(sTyCost[iStr].equals("0")){sTyCost[iStr] = "";} else{ sTyCost[iStr] = "$" + sTyCost[iStr]; }
        	 if(sTyRet[iStr].equals("0")){sTyRet[iStr] = "";} else{ sTyRet[iStr] = "$" + sTyRet[iStr]; }
        	 if(sTyGm$[iStr].equals("0")){sTyGm$[iStr] = "";} else{ sTyGm$[iStr] = "$" + sTyGm$[iStr]; }
        	 
        	 if(sLyDisc[iStr].equals("0")){sLyDisc[iStr] = "";} else{ sLyDisc[iStr] = "$" + sLyDisc[iStr]; }
        	 if(sLyCost[iStr].equals("0")){sLyCost[iStr] = "";} else{ sLyCost[iStr] = "$" + sLyCost[iStr]; }
        	 if(sLyRet[iStr].equals("0")){sLyRet[iStr] = "";} else{ sLyRet[iStr] = "$" + sLyRet[iStr]; }
        	 if(sLyGm$[iStr].equals("0")){sLyGm$[iStr] = "";} else{ sLyGm$[iStr] = "$" + sLyGm$[iStr]; }
             %>
             
             <td id="tdTyCode<%=i%>_<%=iStr%>" class="td12" nowrap>
             	   
             	   <a href="javascript: crtExcel('TY','<%=sCoup%>','ALL')">
             	   <span id="spnTyDisc<%=i%>_<%=iStr%>" style="text-align:right;"><%=sTyDisc[iStr]%></span>
             	   <span id="spnTyCost<%=i%>_<%=iStr%>" style="display: none"><%=sTyCost[iStr]%></span>
             	   <span id="spnTyRet<%=i%>_<%=iStr%>" style="display: none"><%=sTyRet[iStr]%></span>
             	   <span id="spnTyGm$<%=i%>_<%=iStr%>" style="display: none"><%=sTyGm$[iStr]%></span>
             	   </a>
             </td>
             	
             <td id="tdLyCode<%=i%>_<%=iStr%>" class="td82" nowrap>
             	   <a href="javascript: crtExcell('LY','<%=sCoup%>','ALL')">
             	   <span id="spnLyDisc<%=i%>_<%=iStr%>" style="text-align:right;"><%=sLyDisc[iStr]%></span>
             	   <span id="spnLyCost<%=i%>_<%=iStr%>" style="display: none"><%=sLyCost[iStr]%></span>
             	   <span id="spnLyRet<%=i%>_<%=iStr%>" style="display: none"><%=sLyRet[iStr]%></span>
             	   <span id="spnLyGm$<%=i%>_<%=iStr%>" style="display: none"><%=sLyGm$[iStr]%></span>
             	   </a>
          	 </td>      
             
             <td id="tdGrp<%=i%>" class="td12" nowrap><%=sCoup%></td> 
           </tr>
              <script></script>	
           <%}%> 
           <!-- ======Total ================ -->
           
           
           <%
             coupsum.setRepTot();
      	 	 String sCoup = coupsum.getCoup();
    	 	 String [] sTyDisc = coupsum.getTyDisc();
    	 	 String [] sTyCost = coupsum.getTyCost();
    	 	 String [] sTyRet = coupsum.getTyRet();
    	 	 String [] sTyGm$ = coupsum.getTyGm$();
    	 	 String [] sLyRet = coupsum.getLyRet();
       	 	 String [] sLyCost = coupsum.getLyCost();
       	 	 String [] sLyDisc = coupsum.getLyDisc();
       	 	 String [] sLyGm$ = coupsum.getLyGm$();
    	   %>
		   <tr id="trTotal" class="trDtl15">
             <td class="td11" nowrap>Totals</td>
             <td class="td11" nowrap>&nbsp;</td>
             <%for(int j=0; j < iNumOfStr; j++){
            	 if(sTyDisc[j].equals("")){sTyDisc[j] = "";} else{ sTyDisc[j] = "$" + sTyDisc[j]; }
            	 if(sTyCost[j].equals("")){sTyCost[j] = "";} else{ sTyCost[j] = "$" + sTyCost[j]; }
            	 if(sTyRet[j].equals("")){sTyRet[j] = "";} else{ sTyRet[j] = "$" + sTyRet[j]; }
            	 if(sTyGm$[j].equals("")){sTyGm$[j] = "";} else{ sTyGm$[j] = "$" + sTyGm$[j]; }
            	 
            	 if(sLyDisc[j].equals("")){sLyDisc[j] = "";} else{ sLyDisc[j] = "$" + sLyDisc[j]; }
            	 if(sLyCost[j].equals("")){sLyCost[j] = "";} else{ sLyCost[j] = "$" + sLyCost[j]; }
            	 if(sLyRet[j].equals("")){sLyRet[j] = "";} else{ sLyRet[j] = "$" + sLyRet[j]; }
            	 if(sLyGm$[j].equals("")){sLyGm$[j] = "";} else{ sLyGm$[j] = "$" + sLyGm$[j]; }
             %>
             	<td class="td12" nowrap>
             	    <a href="javascript: crtExcel('TY', 'ALL', '<%=sStr[j]%>')">
             		<span id="spnTotTyDisc<%=j%>" style="text-align:right;"><%=sTyDisc[j]%></span>
             	   	<span id="spnTotTyCost<%=j%>" style="display: none"><%=sTyCost[j]%></span>
             	   	<span id="spnTotTyRet<%=j%>" style="display: none"><%=sTyRet[j]%></span>
             	   	<span id="spnTotTyGm$<%=j%>" style="display: none"><%=sTyGm$[j]%></span>
             	   	</a>
             	</td>
             	
             	<td class="td82" nowrap>
             	    <a href="javascript: crtExcel('LY', 'ALL', '<%=sStr[j]%>')">
             		<span id="spnTotLyDisc<%=j%>" style="text-align:right;"><%=sLyDisc[j]%></span>
             	   	<span id="spnTotLyCost<%=j%>" style="display: none"><%=sLyCost[j]%></span>
             	   	<span id="spnTotLyRet<%=j%>" style="display: none"><%=sLyRet[j]%></span>
             	   	<span id="spnTotLyGm$<%=j%>" style="display: none"><%=sLyGm$[j]%></span>
             	   	</a>
             	</td>
             <%}%> 
             
             <%
             int iStr = iNumOfStr;
             if(sTyDisc[iStr].equals("0")){sTyDisc[iStr] = "";} else{ sTyDisc[iStr] = "$" + sTyDisc[iStr]; }
        	 if(sTyCost[iStr].equals("0")){sTyCost[iStr] = "";} else{ sTyCost[iStr] = "$" + sTyCost[iStr]; }
        	 if(sTyRet[iStr].equals("0")){sTyRet[iStr] = "";} else{ sTyRet[iStr] = "$" + sTyRet[iStr]; }
        	 if(sTyGm$[iStr].equals("0")){sTyGm$[iStr] = "";} else{ sTyGm$[iStr] = "$" + sTyGm$[iStr]; }
        	 
        	 if(sLyDisc[iStr].equals("0")){sLyDisc[iStr] = "";} else{ sLyDisc[iStr] = "$" + sLyDisc[iStr]; }
        	 if(sLyCost[iStr].equals("0")){sLyCost[iStr] = "";} else{ sLyCost[iStr] = "$" + sLyCost[iStr]; }
        	 if(sLyRet[iStr].equals("0")){sLyRet[iStr] = "";} else{ sLyRet[iStr] = "$" + sLyRet[iStr]; }
        	 if(sLyGm$[iStr].equals("0")){sLyGm$[iStr] = "";} else{ sLyGm$[iStr] = "$" + sLyGm$[iStr]; }
             %>
             
             <td class="td12" nowrap>
             	   
             	   <a>
             	   <span id="spnTotTyDisc<%=iStr%>" style="text-align:right;"><%=sTyDisc[iStr]%></span>
             	   <span id="spnTotTyCost<%=iStr%>" style="display: none"><%=sTyCost[iStr]%></span>
             	   <span id="spnTotTyRet<%=iStr%>" style="display: none"><%=sTyRet[iStr]%></span>
             	   <span id="spnTotTyGm$<%=iStr%>" style="display: none"><%=sTyGm$[iStr]%></span>
             	   </a>
             </td>
             	
             <td  class="td82" nowrap>
             	   <a>
             	   <span id="spnTotLyDisc<%=iStr%>" style="text-align:right;"><%=sLyDisc[iStr]%></span>
             	   <span id="spnTotLyCost%=iStr%>" style="display: none"><%=sLyCost[iStr]%></span>
             	   <span id="spnTotLyRet<%=iStr%>" style="display: none"><%=sLyRet[iStr]%></span>
             	   <span id="spnTotLyGm$<%=iStr%>" style="display: none"><%=sLyGm$[iStr]%></span>
             	   </a>
          	 </td> 
                 	
             <td class="td11" nowrap>Totals</td>            		         
           </tr>            
           
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
	if(coupsum != null)
	{
		coupsum.disconnect();
		coupsum = null;
	}
}
%>