<%@ page import="salesreport.AuditRtnSum, java.util.*, java.text.*"%>
<%
   String sFrom = request.getParameter("FrDate");   
   String sTo = request.getParameter("ToDate");
   String sReb = request.getParameter("Reb");
   
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
   		sReb = "B";
   }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=AuditRtnSum.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	AuditRtnSum audsum = null;
    int iNumOfStr = 0;
    int iNumOfReg = 0; 
    
    if(sFrom != null)
    {
    	audsum = new AuditRtnSum(sFrom, sTo, sReb);
    	iNumOfStr = audsum.getNumOfStr();
    	iNumOfReg = audsum.getNumOfReg(); 
    } 
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Audit Return Summary</title>

<SCRIPT>

//--------------- Global variables -----------------------
var NumOfStr = "<%=iNumOfStr%>";
var NumOfReg = "<%=iNumOfReg%>";
var DayFr = ["0", "1", "8","15","22","30","60","90" ,"120","150","180","210","240","270","300","330","365" ];
var DayTo = ["0", "7","14","21","29","59","89","119","149","179","209","239","269","299","329","364","9999" ]
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
	
	var dispUnit = "none";
	var dispCost = "none";
	var dispRet = "none";
	var dispGm$ = "none";
	
	if(type == "U"){ dispUnit = "table-cell"; }
	if(type == "C"){ dispCost = "table-cell"; }
	if(type == "R"){ dispRet = "table-cell"; }
	if(type == "G"){ dispGm$ = "table-cell"; }
	
	// set displayn for stores
	for(var i=0; i < NumOfStr; i++)
	{
		for(var j=0; j < 19; j++)
		{
			var unitNm = "spnUnit" + i + "_" + j;
			var unit = document.getElementById(unitNm);
			unit.style.display= dispUnit;
			unit.style.textAlign = "right"; 
			
			var costNm = "spnCost" + i + "_" + j;
			var cost = document.getElementById(costNm);
			cost.style.display= dispCost;
			cost.style.textAlign = "right";
			
			var retNm = "spnRet" + i + "_" + j;
			var ret = document.getElementById(retNm);
			ret.style.display= dispRet;
			ret.style.textAlign = "right";
			
			var gm$Nm = "spnGm$" + i + "_" + j;
			var gm$ = document.getElementById(gm$Nm);
			gm$.style.display= dispGm$;
			gm$.style.textAlign = "right";
		}
	}
	
	// set display for region 
	for(var i=0; i < NumOfReg; i++)
	{
		for(var j=0; j < 19; j++)
		{
			var unitNm = "spnRegUnit" + i + "_" + j;
			var unit = document.getElementById(unitNm);
			unit.style.display= dispUnit;
			unit.style.textAlign = "right";
			
			var costNm = "spnRegCost" + i + "_" + j;
			var cost = document.getElementById(costNm);
			cost.style.display= dispCost;
			cost.style.textAlign = "right";
			
			var retNm = "spnRegRet" + i + "_" + j;
			var ret = document.getElementById(retNm);
			ret.style.display= dispRet;
			ret.style.textAlign = "right";
			
			var gm$Nm = "spnRegGm$" + i + "_" + j;
			var gm$ = document.getElementById(gm$Nm);
			gm$.style.display= dispGm$;
			gm$.style.textAlign = "right";
		}
	}
	
	for(var j=0; j < 19; j++)
	{   
		var unitNm = "spnTotUnit" + j;
		var unit = document.getElementById(unitNm);
		unit.style.display= dispUnit;
		unit.style.textAlign = "right";
		
		var costNm = "spnTotCost" + j;
		var cost = document.getElementById(costNm);
		cost.style.display= dispCost;
		cost.style.textAlign = "right";
		
		var retNm = "spnTotRet" + j;
		var ret = document.getElementById(retNm);
		ret.style.display= dispRet;
		ret.style.textAlign = "right";
		
		var gm$Nm = "spnTotGm$" + j;
		var gm$ = document.getElementById(gm$Nm);
		gm$.style.display= dispGm$;
		gm$.style.textAlign = "right";
	}
}
//==============================================================================
// retreive detail data for selected date and day range 
//==============================================================================
function rtvRetnDtl(str, argd)
{
	var url = "AuditRtnDtl.jsp?Str=" + str
	if(argd != "18")
	{	
	 	url += "&DayFr=" + DayFr[argd]
	         + "&DayTo=" + DayTo[argd]
	} 
	else
	{
		url += "&DayFr=NONE&DayTo=NONE"
	}
	
	url += "&FrDate=<%=sFrom%>"
	 + "&ToDate=<%=sTo%>"
	window.frame1.location.href = url;
}
//==============================================================================
// dispaly detail data for selected date and day range 
//==============================================================================
function showRtnDtl(selStr, dayFr, dayTo, frDate, toDate
		   , rtnStr, slsStr, rtnDt, slsDt, rtnRet, rtnCost, rtnQty, empPurch
		   , slsDoc, rtnDoc, slsCash, slsEmp, rtnCash, sku, gtin, desc 
		   , venSty, clrNm, sizNm, venNm
		   , rtnReg, rtnTran, slsReg, slsTran)
{
	var hdr = "Str: " + selStr + " Days: " + dayFr + "-" + dayTo;
	  var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popRtnDtl(rtnStr, slsStr, rtnDt, slsDt
	    		, rtnRet, rtnCost, rtnQty, empPurch, slsDoc, rtnDoc, slsCash, slsEmp
	    		, rtnCash, sku, gtin, desc, venSty, clrNm, sizNm, venNm
	    		, rtnReg, rtnTran, slsReg, slsTran)
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
function popRtnDtl(rtnStr, slsStr, rtnDt, slsDt, rtnRet, rtnCost, rtnQty
		, empPurch, slsDoc, rtnDoc, slsCash, slsEmp, rtnCash, sku, gtin, desc
		, venSty, clrNm, sizNm, venNm, rtnReg, rtnTran, slsReg, slsTran)
{
	var panel = "<table class='tbl02'>";
	panel += "<tr class='trHdr01'>"
       + "<th class='th01' colspan=9>Return Transaction</th>"
       + "<th class='th01' rowspan=2>&nbsp;</th>"
       + "<th class='th01' colspan=8>Original Sale Transaction</th>"       
       + "<th class='th01' rowspan=2>&nbsp;</th>"
       + "<th class='th01' colspan=7>Item Information</th>"        
       + "</tr>"
       panel += "<tr class='trHdr01'>"
           + "<th class='th01'>Str</th>"
           + "<th class='th01'>Date</th>"
           + "<th class='th01'>Reg</th>"
           + "<th class='th01'>Tran#</th>"
           + "<th class='th01'>Cash</th>"
           + "<th class='th01'>Doc</th>"
           + "<th class='th01'>Ret</th>"
           + "<th class='th01'>Cost</th>"
           + "<th class='th01'>Qty</th>"
           
           + "<th class='th01'>Str</th>"
           + "<th class='th01'>Date</th>"
           + "<th class='th01'>Reg</th>"
           + "<th class='th01'>Tran#</th>"
           + "<th class='th01'>Cash</th>"
           + "<th class='th01'>Doc</th>"           
           + "<th class='th01'>Emp</th>"
           + "<th class='th01'>Emp<br>Purch</th>"
           
           + "<th class='th01'>SKU</th>"
           + "<th class='th01'>GTIN</th>"
           + "<th class='th01'>Description</th>"
           + "<th class='th01'>Vendor Style</th>"
           + "<th class='th01'>Color</th>"
           + "<th class='th01'>Size</th>"
           + "<th class='th01'>Vendor</th>"
         + "</tr>"    
    ;
		
	for(var i=0; i < slsStr.length;i++)
	{
		panel += "<tr class='trDtl01'>"
	      + "<td nowrap class='td11'>" + rtnStr[i] + "</td>"
	      + "<td nowrap class='td11'>" + rtnDt[i] + "</td>"
	      + "<td nowrap class='td11'>" + rtnReg[i] + "</td>"
	      + "<td nowrap class='td11'>" + rtnTran[i] + "</td>"
	      + "<td nowrap class='td11'>" + rtnCash[i] + "</td>"
	      + "<td nowrap class='td11'>" + rtnDoc[i] + "</td>"
	      + "<td nowrap class='td11'>" + rtnRet[i] + "</td>"
	      + "<td nowrap class='td11'>" + rtnCost[i] + "</td>"
	      + "<td nowrap class='td11'>" + rtnQty[i] + "</td>"
	      
	      + "<td nowrap class='Separator06'>&nbsp;</td>"	      
	      + "<td nowrap class='td11'>" + slsStr[i] + "</td>"
	      + "<td nowrap class='td11'>" + slsDt[i] + "</td>"
	      + "<td nowrap class='td11'>" + slsReg[i] + "</td>"
	      + "<td nowrap class='td11'>" + slsTran[i] + "</td>"
	      + "<td nowrap class='td11'>" + slsCash[i] + "</td>"
	      + "<td nowrap class='td11'>" + slsDoc[i] + "</td>"	      
	      + "<td nowrap class='td11'>" + slsEmp[i] + "</td>"
	      
	      + "<td nowrap class='td11'>" + empPurch[i] + "</td>"
	      + "<td nowrap class='Separator06'>&nbsp;</td>"
	      + "<td nowrap class='td11'>" + sku[i] + "</td>"
	      + "<td nowrap class='td11'>" + gtin[i] + "</td>"
	      + "<td nowrap class='td11'>" + desc[i] + "</td>"
	      + "<td nowrap class='td11'>" + venSty[i] + "</td>"
	      + "<td nowrap class='td11'>" + clrNm[i] + "</td>"
	      + "<td nowrap class='td11'>" + sizNm[i] + "</td>"
	      + "<td nowrap class='td11'>" + venNm[i] + "</td>"
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
function hidePanel()
{
	document.all.dvItem.innerHTML = "";
	document.all.dvItem.style.visibility = "hidden";
}
</SCRIPT>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Calendar.js"></script>

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
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Returns Analysis
            <br><%if(audsum != null){%>From: <%=sFrom%>&nbsp;
                 To: <%=sTo%>
                 <%}%>
            <br>
               Data: <%if(sReb.equals("R")){%>Return<%} else if(sReb.equals("E")){%>Exchange<%} else if(sReb.equals("B")){%>Return &  Exchange<%} %>     
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="AuditRtnSumSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;
            <br>
              <input type="radio" name="inpType" id=="inpType" value="U" onclick="setType(this)">Unit &nbsp; &nbsp; &nbsp;
              <input type="radio" name="inpType" id=="inpType" value="C" onclick="setType(this)" >Cost &nbsp; &nbsp; &nbsp;
              <input type="radio" name="inpType" id=="inpType" value="R" onclick="setType(this)" checked>Retail &nbsp; &nbsp; &nbsp;
              <input type="radio" name="inpType" id=="inpType" value="G" onclick="setType(this)" >GM $
          </th>
        </tr>
        
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          	<th class="th02">Store</th>
          	<th class="th02" colspan=1>Same<br>Day</th>
          	<th class="th02" colspan=4>In the first Weeks</th> 
          	<th class="th02" colspan=11>In Months After</th>
          	<th class="th02">Over a Year</th>
          	<th class="th02" rowspan=3>Str<br>Total</th>
          	<th class="th02" rowspan=3>Avg<br># Days*</th>  
          	<th class="th02" rowspan=3>Non-Validated<br>Returns<br>(CP POS)**</th>
        </tr>
        
        <tr class="trHdr01">
        	<th class="th02">Week/Month <img src="arrowRight01.png" height="10"></th>
        	<th class="th02">0</th>
        	<th class="th02">1</th>
        	<th class="th02">2</th>
        	<th class="th02">3</th>
        	<th class="th02">4</th>
        	<th class="th02">2</th>
        	<th class="th02">3</th>
        	<th class="th02">4</th>
        	<th class="th02">5</th>
        	<th class="th02">6</th>
        	<th class="th02">7</th>
        	<th class="th02">8</th>
        	<th class="th02">9</th>
        	<th class="th02">10</th>
        	<th class="th02">11</th>
        	<th class="th02">12</th>
        	<th class="th02">13+</th>
        </tr>
        
        <tr class="trHdr01">
            <th class="th02"># of Days <img src="arrowRight01.png" height="10"></th>
        	<th class="th02">0</th>
        	<th class="th02">1-7</th>
        	<th class="th02">8-14</th>
        	<th class="th02">15-21</th>
        	<th class="th02">22-29</th>
        	<th class="th02">30+</th>
        	<th class="th02">60+</th>
        	<th class="th02">90+</th>
        	<th class="th02">120+</th>
        	<th class="th02">150+</th>
        	<th class="th02">180+</th>
        	<th class="th02">210+</th>
        	<th class="th02">240+</th>
        	<th class="th02">270+</th>
        	<th class="th02">300+</th>
        	<th class="th02">330+</th>
        	<th class="th02">365+</th>
        </tr>
         
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfStr; i++) {        	   
        	   	audsum.setAudLst();
          	 	String sStr = audsum.getStr();
          	 	String [] sUnit = audsum.getUnit();
          	 	String [] sCost = audsum.getCost();
          	 	String [] sRet = audsum.getRet();
          	 	String [] sGm$ = audsum.getGm$();
          	 	String sAvgDays = audsum.getAvgDays();
          	 	if(sAvgDays.equals(".0")){sAvgDays = "";}
   			
   				if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
   				else {sTrCls = "trDtl06";}   			
           %>                           
           <tr id="trGrp<%=i%>" class="<%=sTrCls%>">
             <td id="tdGrp<%=i%>" class="td12" nowrap><%=sStr%></td>
             <%for(int j=0; j < 17; j++){
            	 if(sUnit[j].equals("0")){sUnit[j] = "";} 
            	 if(sCost[j].equals("0")){sCost[j] = "";} else{ sCost[j] = "$" + sCost[j]; }
            	 if(sRet[j].equals("0")){sRet[j] = "";} else{ sRet[j] = "$" + sRet[j]; }
            	 if(sGm$[j].equals("0")){sGm$[j] = "";} else{ sGm$[j] = "$" + sGm$[j]; }
             %>
             	<td id="tdGrp<%=i%>" class="td12" nowrap>
             	   <a href="javascript: rtvRetnDtl('<%=sStr%>','<%=j%>')">
             	   <span id="spnUnit<%=i%>_<%=j%>" style="display: none"><%=sUnit[j]%></span>
             	   <span id="spnCost<%=i%>_<%=j%>" style="display: none"><%=sCost[j]%></span>
             	   <span id="spnRet<%=i%>_<%=j%>" style="text-align:right;"><%=sRet[j]%></span>
             	   <span id="spnGm$<%=i%>_<%=j%>" style="display: none"><%=sGm$[j]%></span>
             	   </a>
             	</td>
             <%}
             
             // store totals
             int iStrTot = 17;
             if(sUnit[iStrTot].equals("0")){sUnit[iStrTot] = "";} 
        	 if(sCost[iStrTot].equals("0")){sCost[iStrTot] = "";} else{ sCost[iStrTot] = "$" + sCost[iStrTot]; }
        	 if(sRet[iStrTot].equals("0")){sRet[iStrTot] = "";} else{ sRet[iStrTot] = "$" + sRet[iStrTot]; }
        	 if(sGm$[iStrTot].equals("0")){sGm$[iStrTot] = "";} else{ sGm$[iStrTot] = "$" + sGm$[iStrTot]; }        	 
             %>             
             <td id="tdGrp<%=i%>" class="td12" nowrap>
                <a>
                <span id="spnUnit<%=i%>_<%=iStrTot%>" style="display: none"><%=sUnit[iStrTot]%></span>
                <span id="spnCost<%=i%>_<%=iStrTot%>" style="display: none"><%=sCost[iStrTot]%></span>
                <span id="spnRet<%=i%>_<%=iStrTot%>" style="text-align:right;"><%=sRet[iStrTot]%></span>
                <span id="spnGm$<%=i%>_<%=iStrTot%>" style="display: none"><%=sGm$[iStrTot]%></span>
                </a>
             </td>
             
             <td id="tdGrp<%=i%>" class="td12" nowrap><%=sAvgDays%></td> 
             
        	 <%iStrTot = 18;
             if(sUnit[iStrTot].equals("0")){sUnit[iStrTot] = "";} 
        	 if(sCost[iStrTot].equals("0")){sCost[iStrTot] = "";} else{ sCost[iStrTot] = "$" + sCost[iStrTot]; }
        	 if(sRet[iStrTot].equals("0")){sRet[iStrTot] = "";} else{ sRet[iStrTot] = "$" + sRet[iStrTot]; }
        	 if(sGm$[iStrTot].equals("0")){sGm$[iStrTot] = "";} else{ sGm$[iStrTot] = "$" + sGm$[iStrTot]; }        	 
             %>                          
             <td id="tdGrp<%=i%>" class="td12" nowrap>
                <a href="javascript: rtvRetnDtl('<%=sStr%>','<%=iStrTot%>')">
                <span id="spnUnit<%=i%>_<%=iStrTot%>" style="display: none"><%=sUnit[iStrTot]%></span>
                <span id="spnCost<%=i%>_<%=iStrTot%>" style="display: none"><%=sCost[iStrTot]%></span>
                <span id="spnRet<%=i%>_<%=iStrTot%>" style="display: table-cell"><%=sRet[iStrTot]%></span>
                <span id="spnGm$<%=i%>_<%=iStrTot%>" style="display: none"><%=sGm$[iStrTot]%></span>
                </a>
             </td>
             	
             
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
          	 String [] sUnit = audsum.getUnit();
          	 String [] sCost = audsum.getCost();
          	 String [] sRet = audsum.getRet();
             String [] sGm$ = audsum.getGm$();
          	 String sAvgDays = audsum.getAvgDays();
          	 if(sAvgDays.equals(".0")){sAvgDays = "";}  
           %>	
           	 <tr id="trTotal" class="trDtl05">
             	<td class="td12" nowrap>Dist <%=sStr%></td>
             	<%for(int j=0; j < 17; j++)
             	{
             		if(sUnit[j].equals("0")){sUnit[j] = "";} 
               	 	if(sCost[j].equals("0")){sCost[j] = "";} else{ sCost[j] = "$" + sCost[j]; }
               	 	if(sRet[j].equals("0")){sRet[j] = "";} else{ sRet[j] = "$" + sRet[j]; }
               	    if(sGm$[j].equals("0")){sGm$[j] = "";} else{ sGm$[j] = "$" + sGm$[j]; }
             	%>
             		<td class="td12" nowrap>             		    
             			<a>
             			<span id="spnRegUnit<%=i%>_<%=j%>" style="display: none"><%=sUnit[j]%></span>
             	   		<span id="spnRegCost<%=i%>_<%=j%>" style="display: none"><%=sCost[j]%></span>
             	   		<span id="spnRegRet<%=i%>_<%=j%>" style="text-align:right;"><%=sRet[j]%></span>
             	   		<span id="spnRegGm$<%=i%>_<%=j%>" style="display: none"><%=sGm$[j]%></span>
             	   		</a>
             		</td>
             	<%}
             	
             	// store totals
                int iStrTot = 17;
                if(sUnit[iStrTot].equals("0")){sUnit[iStrTot] = "";} 
           	 	if(sCost[iStrTot].equals("0")){sCost[iStrTot] = "";} else{ sCost[iStrTot] = "$" + sCost[iStrTot]; }
           	 	if(sRet[iStrTot].equals("0")){sRet[iStrTot] = "";} else{ sRet[iStrTot] = "$" + sRet[iStrTot]; }
           	 	if(sGm$[iStrTot].equals("0")){sGm$[iStrTot] = "";} else{ sGm$[iStrTot] = "$" + sGm$[iStrTot]; }        	 
                %>             
                   <td id="tdGrp<%=i%>" class="td12" nowrap>
                	   <a>
                	   <span id="spnRegUnit<%=i%>_<%=iStrTot%>" style="display: none"><%=sUnit[iStrTot]%></span>
                	   <span id="spnRegCost<%=i%>_<%=iStrTot%>" style="display: none"><%=sCost[iStrTot]%></span>
                	   <span id="spnRegRet<%=i%>_<%=iStrTot%>" style="text-align:right;"><%=sRet[iStrTot]%></span>
                	   <span id="spnRegGm$<%=i%>_<%=iStrTot%>" style="display: none"><%=sGm$[iStrTot]%></span>
                	   </a>
                	</td>
                	
               <td id="tdGrp<%=i%>" class="td12" nowrap><%=sAvgDays%></td>    
                	
               <%iStrTot = 18;
               	if(sUnit[iStrTot].equals("0")){sUnit[iStrTot] = "";} 
          	 	if(sCost[iStrTot].equals("0")){sCost[iStrTot] = "";} else{ sCost[iStrTot] = "$" + sCost[iStrTot]; }
          	 	if(sRet[iStrTot].equals("0")){sRet[iStrTot] = "";} else{ sRet[iStrTot] = "$" + sRet[iStrTot]; }
          	 	if(sGm$[iStrTot].equals("0")){sGm$[iStrTot] = "";} else{ sGm$[iStrTot] = "$" + sGm$[iStrTot]; }        	 
               %>             
               <td id="tdGrp<%=i%>" class="td12" nowrap>
                  <a>
                  <span id="spnRegUnit<%=i%>_<%=iStrTot%>" style="display: none"><%=sUnit[iStrTot]%></span>
                  <span id="spnRegCost<%=i%>_<%=iStrTot%>" style="display: none"><%=sCost[iStrTot]%></span>
                  <span id="spnRegRet<%=i%>_<%=iStrTot%>" style="text-align:right;"><%=sRet[iStrTot]%></span>
                  <span id="spnRegGm$<%=i%>_<%=iStrTot%>" style="display: none"><%=sGm$[iStrTot]%></span>
                  </a>
               </td>             	
           	 </tr>
           	      
           <%}%>
           
           
           <%
             audsum.setRepTot();
      	 	 String sStr = audsum.getStr();
    	 	 String [] sUnit = audsum.getUnit();
    	 	 String [] sCost = audsum.getCost();
    	 	 String [] sRet = audsum.getRet();
    	 	 String [] sGm$ = audsum.getGm$();
    	 	 String sAvgDays = audsum.getAvgDays();
    	 	 if(sAvgDays.equals(".0")){sAvgDays = "";} 
    	   %>
		   <tr id="trTotal" class="trDtl15">
             <td class="td12" nowrap>Totals</td>              
             <%for(int j=0; j < 17; j++){
            	 if(sUnit[j].equals("0")){sUnit[j] = "";} 
            	 if(sCost[j].equals("0")){sCost[j] = "";} else{ sCost[j] = "$" + sCost[j]; }
            	 if(sRet[j].equals("0")){sRet[j] = "";} else{ sRet[j] = "$" + sRet[j]; }
            	 if(sGm$[j].equals("0")){sGm$[j] = "";} else{ sGm$[j] = "$" + sGm$[j]; }
             %>
             	<td class="td12" nowrap>
             	    <a>
             		<span id="spnTotUnit<%=j%>" style="display: none"><%=sUnit[j]%></span>
             	   	<span id="spnTotCost<%=j%>" style="display: none"><%=sCost[j]%></span>
             	   	<span id="spnTotRet<%=j%>" style="text-align:right;"><%=sRet[j]%></span>
             	   	<span id="spnTotGm$<%=j%>" style="display: none"><%=sGm$[j]%></span>
             	   	</a>
             	</td>
             <%}
          	 
             // store totals
             int iStrTot = 17;
             if(sUnit[iStrTot].equals("0")){sUnit[iStrTot] = "";} 
        	 if(sCost[iStrTot].equals("0")){sCost[iStrTot] = "";} else{ sCost[iStrTot] = "$" + sCost[iStrTot]; }
        	 if(sRet[iStrTot].equals("0")){sRet[iStrTot] = "";} else{ sRet[iStrTot] = "$" + sRet[iStrTot]; }
        	 if(sGm$[iStrTot].equals("0")){sGm$[iStrTot] = "";} else{ sGm$[iStrTot] = "$" + sGm$[iStrTot]; }        	 
             %>             
                <td class="td12" nowrap>
             	   <a>
             	   <span id="spnTotUnit<%=iStrTot%>" style="display: none"><%=sUnit[iStrTot]%></span>
             	   <span id="spnTotCost<%=iStrTot%>" style="display: none"><%=sCost[iStrTot]%></span>
             	   <span id="spnTotRet<%=iStrTot%>" style="text-align:right;"><%=sRet[iStrTot]%></span>
             	   <span id="spnTotGm$<%=iStrTot%>" style="display: none"><%=sGm$[iStrTot]%></span>
             	   </a>
             	</td>
             
             <td class="td12" nowrap><%=sAvgDays%></td>
             	
             <%iStrTot = 18;
               	if(sUnit[iStrTot].equals("0")){sUnit[iStrTot] = "";} 
          	 	if(sCost[iStrTot].equals("0")){sCost[iStrTot] = "";} else{ sCost[iStrTot] = "$" + sCost[iStrTot]; }
          	 	if(sRet[iStrTot].equals("0")){sRet[iStrTot] = "";} else{ sRet[iStrTot] = "$" + sRet[iStrTot]; }
          	 	if(sGm$[iStrTot].equals("0")){sGm$[iStrTot] = "";} else{ sGm$[iStrTot] = "$" + sGm$[iStrTot]; }        	 
               %>             
               <td class="td12" nowrap>
                  <a>
                  <span id="spnTotUnit<%=iStrTot%>" style="display: none"><%=sUnit[iStrTot]%></span>
                  <span id="spnTotCost<%=iStrTot%>" style="display: none"><%=sCost[iStrTot]%></span>
                  <span id="spnTotRet<%=iStrTot%>" style="text-align:right;"><%=sRet[iStrTot]%></span>
                  <span id="spnTotGm$<%=iStrTot%>" style="display: none"><%=sGm$[iStrTot]%></span>
                  </a>
               </td> 		         
           </tr>            
           <%}%>
           
           <tr class="trHdr01">
          	<th class="th02">Store</th>
          	<th class="th02" colspan=1>Same<br>Day</th>
          	<th class="th02" colspan=4>In the first Weeks</th> 
          	<th class="th02" colspan=11>In Months After</th>
          	<th class="th02">Over a Year</th>
          	<th class="th02" rowspan=3>Str<br>Total</th>
          	<th class="th02" rowspan=3>Avg<br># Days</th>  
          	<th class="th02" rowspan=3>Non-Validated<br>Returns<br>(CP POS)</th>
        </tr>
        
        <tr class="trHdr01">
        	<th class="th02">Week/Month <img src="arrowRight01.png" height="10"></th>
        	<th class="th02">0</th>
        	<th class="th02">1</th>
        	<th class="th02">2</th>
        	<th class="th02">3</th>
        	<th class="th02">4</th>
        	<th class="th02">2</th>
        	<th class="th02">3</th>
        	<th class="th02">4</th>
        	<th class="th02">5</th>
        	<th class="th02">6</th>
        	<th class="th02">7</th>
        	<th class="th02">8</th>
        	<th class="th02">9</th>
        	<th class="th02">10</th>
        	<th class="th02">11</th>
        	<th class="th02">12</th>
        	<th class="th02">13+</th>
        </tr>
        
        <tr class="trHdr01">
            <th class="th02"># of Days <img src="arrowRight01.png" height="10"></th>
        	<th class="th02">0</th>
        	<th class="th02">1-7</th>
        	<th class="th02">8-14</th>
        	<th class="th02">15-21</th>
        	<th class="th02">22-29</th>
        	<th class="th02">30+</th>
        	<th class="th02">60+</th>
        	<th class="th02">90+</th>
        	<th class="th02">120+</th>
        	<th class="th02">150+</th>
        	<th class="th02">180+</th>
        	<th class="th02">210+</th>
        	<th class="th02">240+</th>
        	<th class="th02">270+</th>
        	<th class="th02">300+</th>
        	<th class="th02">330+</th>
        	<th class="th02">365+</th>
        </tr>
           
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
      <tr>
      	<td style="text-align: left; font-size: 10px;">
      	     Notes: 
      	     <br>*Avg # Days - Represents the Average # of Days between Original Sale (or Fulfillment) Date and Return Date.
      	     <br>**Non-Validated Returns - applies to B&M  (CP POS) Stores only.  Return $$ in this column were processed without using the "validated return" feature, therefore no Original Sale date could be used to calculate the # of days between Sale and Return. 
      	</td>
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