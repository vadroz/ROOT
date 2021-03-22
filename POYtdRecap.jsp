<%@ page import="posend.POYtdRecap, java.util.*, java.text.*
, rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*"%>
<%
   	String [] sSelStr = request.getParameterValues("Str");
	String sWkend = request.getParameter("Wkend");
	String sType = request.getParameter("Type");
	String sYear = request.getParameter("Year");
	String sSort = request.getParameter("Sort");
   
   if(sSort == null  || sSort.equals("")) {sSort = "Reg";}
   if(sWkend == null || sWkend.equals("")){sWkend = " ";}
   if(sYear == null  || sYear.equals("")) {sYear = " ";}
   
   long lStartTime = (new java.util.Date()).getTime();
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=POYtdRecap.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	POYtdRecap porecap = new POYtdRecap();    
	porecap.setYtdRecap("vrozen");
	
    String [] sPoNum = porecap.getPoNum();
	String [] sPoRet = porecap.getPoRet();
	String [] sPoCost = porecap.getPoCost();
	String [] sPoQty = porecap.getPoQty();

	String [] sPoRcvRet = porecap.getPoRcvRet();
	String [] sPoRcvCost = porecap.getPoRcvCost();
	String [] sPoRcvQty = porecap.getPoRcvQty();

	String [] sPoOpnRet = porecap.getPoOpnRet();
	String [] sPoOpnCost = porecap.getPoOpnCost();
	String [] sPoOpnQty = porecap.getPoOpnQty();
	
	String sPoRcv = porecap.getPoRcv();
	
	String [] sPoNegNum = porecap.getPoNegNum();
	String [] sPoNegQty = porecap.getPoNegQty();
	 
	
	String [] sEdiNum = porecap.getEdiNum();
	String [] sEdiRet = porecap.getEdiRet();
	String [] sEdiCost = porecap.getEdiCost();
	String [] sEdiQty = porecap.getEdiQty();

	String [] sEdiRcvRet = porecap.getEdiRcvRet();
	String [] sEdiRcvCost = porecap.getEdiRcvCost();
	String [] sEdiRcvQty = porecap.getEdiRcvQty();
	
	String [] sEdiOpnRet = porecap.getEdiOpnRet();
	String [] sEdiOpnCost = porecap.getEdiOpnCost();
	String [] sEdiOpnQty = porecap.getEdiOpnQty();
		
	String [] sEdiPost = porecap.getEdiPost();
	String [] sEdiDiff = porecap.getEdiDiff();
	String sEdiRcv = porecap.getEdiRcv();
	String [] sEdiYrNum = porecap.getEdiYrNum();
	
	// past current future Open PO's totals	
	String [] sYtdNum = porecap.getYtdNum();
	String [] sYtdRet = porecap.getYtdRet();
	String [] sYtdCost = porecap.getYtdCost();
	String [] sYtdQty = porecap.getYtdQty();
	
	int iNumOfCurWk = porecap.getNumOfCurWk();
	String [] sCurNum = porecap.getCurNum();
	String [] sCurRet = porecap.getCurRet();
	String [] sCurCost = porecap.getCurCost();
	String [] sCurQty = porecap.getCurQty();	
	String [] sCurWk = porecap.getCurWk();

	int iNumOfFutMn = porecap.getNumOfFutMn();
	String [] sFutNum = porecap.getFutNum();
	String [] sFutRet = porecap.getFutRet();
	String [] sFutCost = porecap.getFutCost();
	String [] sFutQty = porecap.getFutQty();
	String [] sFutMn = porecap.getFutMn();
	
	String sYTotNum = porecap.getYTotNum();
	String sYTotRet = porecap.getYTotRet();
	String sYTotCost = porecap.getYTotCost();
	String sYTotQty = porecap.getYTotQty();
	
	
  	String [] s2wkNum = porecap.get2wkNum();
	String [] s2wkRet = porecap.get2wkRet();
	String [] s2wkCost = porecap.get2wkCost();
	String [] s2wkQty = porecap.get2wkQty(); 
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>PO YTD Recap</title>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT>
//--------------- Global variables ----------------------- 
var User = "<%=sUser%>"; 
var NumOfCurWk = "<%=iNumOfCurWk%>";
var NumOfFutMn = "<%=iNumOfFutMn%>";

 //--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
	 if (ua.match(/iPad/i) || ua.match(/iPhone/i)) { isSafari = true; }
	 else{ setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]); }
	 
	 setOpnPOTbl("C");
}  
//==============================================================================
//initial process
//==============================================================================
function setOpnPOTbl(type)
{
	var num = document.all["spnNum"];
	var qty = document.all["spnQty"];
	var cost = document.all["spnCost"];
	var ret = document.all["spnRet"];
	
	var ponum = document.all["tdNum"];
	var pounit = document.all["tdUnit"];
	var pocost = document.all["tdCost"];
	var poret = document.all["tdRet"];
	
	if(type=="U")
	{
		for(var i=0; i < num.length; i++)
		{
			num[i].style.display = "none";
			qty[i].style.display = "block";
			cost[i].style.display = "none";
			ret[i].style.display = "none";
		}
		pounit[0].style.background = "lightblue"; 
		ponum[0].style.background = "white"; 
		pocost[0].style.background = "white"; 
		poret[0].style.background = "white"; 
		 
	}
	else if(type=="C")
	{
		for(var i=0; i < num.length; i++)
		{
			num[i].style.display = "none";
			qty[i].style.display = "none";
			cost[i].style.display = "block";
			ret[i].style.display = "none";
		}	
		ponum[0].style.background = "white"; 		
		pounit[0].style.background = "white";
		pocost[0].style.background = "lightblue"; 
		poret[0].style.background = "white"; 
	}
	else if(type=="R")
	{
		for(var i=0; i < num.length; i++)
		{
			num[i].style.display = "none";
			qty[i].style.display = "none";
			cost[i].style.display = "none";
			ret[i].style.display = "block";
		}
		ponum[0].style.background = "white"; 		
		pounit[0].style.background = "white"; 
		pocost[0].style.background = "white"; 		
		poret[0].style.background = "lightblue"; 
	}
	else if(type=="N")
	{
		for(var i=0; i < num.length; i++)
		{
			num[i].style.display = "block";
			qty[i].style.display = "none";
			cost[i].style.display = "none";
			ret[i].style.display = "none";
		}
		ponum[0].style.background = "lightblue"; 
		pounit[0].style.background = "white"; 
		pocost[0].style.background = "white"; 		
		poret[0].style.background = "white"; 
	}
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
<div id="dvWait" class="dvItem"></div>
<!-------------------------------------------------------------------->
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trDtl19">
          <th>
            <b>Retail Concepts, Inc
            <br>Drop Shipment PO - Recap
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;                          
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;
          </th>
        </tr>       
        <tr>        
          <td style="text-align:center;">
            &nbsp;<br>&nbsp;<br> 
        <b>All Drop Shipment POs</b>    
       <table class="tbl04">
       <tr class="trHdr07">
           <th class="th02" colspan=2>&nbsp;</th>
           <th class="th24">&nbsp;</th>
           <th class="th02" colspan=3>Order Qty Totals</th>
           <th class="th24">&nbsp;</th>
           <th class="th02" colspan=3>Total Received</th>
           <th class="th24">&nbsp;</th>
           <th class="th02" colspan=3>Total Remainder</th>
           <th class="th24">&nbsp;</th>
           <th class="th02" style="background:pink;" colspan=2>Negative On Hand Orders</th>
       </tr>
       
       <tr class="trHdr07">
           <th class="th02">PO Current Status</th>           
           <th class="th02"># of<br>PO's</th>
           
           <th class="th02">&nbsp;</th>
           <th class="th02">Units</th>
           <th class="th02">Cost<br>(k)</th>
           <th class="th02">Retail<br>(k)</th>
           
           <th class="th02">&nbsp;</th>
           <th class="th02">Units</th>
           <th class="th02">Cost<br>(k)</th>
           <th class="th02">Retail<br>(k)</th>
           
           <th class="th02">&nbsp;</th>
           <th class="th02">Units</th>
           <th class="th02">Cost<br>(k)</th>
           <th class="th02">Retail<br>(k)</th>
           
           <th class="th02">&nbsp;</th>
           <th class="th02" style="background:pink;"># of<br>PO's</th>
           <th class="th02" style="background:pink;">Units</th>
       </tr>
       <%for(int i=0; i < 2; i++){%>
       <tr class="trDtl04">
           <td class="td11">
             <%if(i==0){%><b><a href="POWorksheetList.jsp?Store=ALL&Ven=ALL&FromDate=03/27/2017&ToDate=03/25/2018&InclSO=&Sts=O&Type=B&Sort=PON" target="_blank">Open</a>  <span style="font-size:10px;"><a href="POYtdStr.jsp?Type=N" target="_blank">by Store</a></span>
             </b><br><span style="font-size:10px;">(partially received)</span><%}
             else{%><b>Received</b><br><span style="font-size:10px;">(fully/or closed buyer)</span><%}%>
             
               
           </td>
           <td class="td12" id="tdNum"><%=sPoNum[i]%></td>           
           <td class="td35">&nbsp;</td>
           
           <td class="td12" id="tdUnit"><%=sPoQty[i]%></td>
           <td class="td12" id="tdCost">$<%=sPoCost[i]%></td>
           <td class="td12" id="tdRet">$<%=sPoRet[i]%></td>
           
           <td class="td35">&nbsp;</td>
           <td class="td12"><%=sPoRcvQty[i]%></td>
           <td class="td12">$<%=sPoRcvCost[i]%></td>
           <td class="td12">$<%=sPoRcvRet[i]%></td>
           
           <td class="td35">&nbsp;</td>           
           <td <%if(i==0){%>class="td12"<%} else{%>class="td62"<%}%>><%=sPoOpnQty[i]%></td>
           <td <%if(i==0){%>class="td12"<%} else{%>class="td62"<%}%>>$<%=sPoOpnCost[i]%></td>
           <td <%if(i==0){%>class="td12"<%} else{%>class="td62"<%}%>>$<%=sPoOpnRet[i]%></td>
           
           <td class="td35">&nbsp;</td>
           <td class="td12"><%=sPoNegNum[i]%></td> 
           <td class="td12"><%=sPoNegQty[i]%></td> 
       </tr>
       <%}%>
       <tr class="trDtl12" style="font-weight:bold;">
           <td class="td11">Totals</td>           
           <td class="td12" id="tdNum"><%=sPoNum[2]%></td>
           <td class="td16">&nbsp;</td>
           <td class="td12" id="tdUnit"><%=sPoQty[2]%></td>
           <td class="td12" id="tdCost">$<%=sPoCost[2]%></td>
           <td class="td12" id="tdRet">$<%=sPoRet[2]%></td>
                            
           
           <td class="td16">&nbsp;</td>
           <td class="td12"><%=sPoRcvQty[2]%></td>
           <td class="td12">$<%=sPoRcvCost[2]%></td>
           <td class="td12">$<%=sPoRcvRet[2]%></td>
           
           <td class="td16">&nbsp;</td>
           <td class="td12"><%=sPoOpnQty[2]%></td>
           <td class="td12">$<%=sPoOpnCost[2]%></td>
           <td class="td12">$<%=sPoOpnRet[2]%></td>
           
           <td class="td35">&nbsp;</td>
           <td class="td12"><%=sPoNegNum[2]%></td> 
           <td class="td12"><%=sPoNegQty[2]%></td> 
       </tr>
       <tr class="trDtl12" style="font-weight:bold;">
           <td class="td11">% Received</td>
           <td class="td61" rowspan=3><%=sPoRcv%>%</td>
       </tr> 
      </table>
      
      <!----------------------- Past/Current/Future Open PO's ------------------------>
      &nbsp;<br>&nbsp;<br>
      <b>Future Orders - by PO Anticipat Date</b>
      <br>&nbsp;
      <span style="font-size:10px">
      <input type="radio" name="Info" value="U" onclick="setOpnPOTbl(this.value)">Units &nbsp;&nbsp;
      <input type="radio" name="Info" value="C" onclick="setOpnPOTbl(this.value)" checked>Cost &nbsp;&nbsp;
      <input type="radio" name="Info" value="R" onclick="setOpnPOTbl(this.value)">Retail &nbsp;&nbsp;
      <input type="radio" name="Info" value="N" onclick="setOpnPOTbl(this.value)"># of PO's &nbsp;&nbsp;
      </span>
      
      <table class="tbl04">
      	<tr class="trHdr07">
      	   <th class="th02" rowspan="3">S<br>t<br>o<br>r<br>e</th>
           <th class="th02" colspan=5>Past Anticipate Date</th>
           <th class="th24">&nbsp;</th>
           <th class="th02" colspan="<%=iNumOfCurWk%>">Current Month Week(s)</th>
           <th class="th24">&nbsp;</th>
           <th class="th02" colspan="<%=iNumOfFutMn%>">Future Month(s)</th>
           <th class="th24">&nbsp;</th>
           <th class="th02">Total</th>
        </tr>   
        <tr class="trHdr07">
           <th class="th02">
               <span id="spnNum"># of PO's</span>
               <span id="spnQty">Units</span>
               <span id="spnCost">Cost<br>(k)</span>
               <span id="spnRet">Retail<br>(k)</span>
           </th>
           <th class="th02">
               <span id="spnNum"># of PO's</span>
               <span id="spnQty">Units</span>
               <span id="spnCost">Cost<br>(k)</span>
               <span id="spnRet">Retail<br>(k)</span>
           </th>
           <th class="th02">
               <span id="spnNum"># of PO's</span>
               <span id="spnQty">Units</span>
               <span id="spnCost">Cost<br>(k)</span>
               <span id="spnRet">Retail<br>(k)</span>
           </th>
           <th class="th02">
               <span id="spnNum"># of PO's</span>
               <span id="spnQty">Units</span>
               <span id="spnCost">Cost<br>(k)</span>
               <span id="spnRet">Retail<br>(k)</span>
           </th>
           <th class="th02">
               <span id="spnNum"># of PO's</span>
               <span id="spnQty">Units</span>
               <span id="spnCost">Cost<br>(k)</span>
               <span id="spnRet">Retail<br>(k)</span>
           </th> 
           
           <th class="th02">&nbsp;</th>
           
           <%for(int j=0; j < iNumOfCurWk; j++){%>
           <th class="th02">
               <span id="spnNum"># of PO's</span>
               <span id="spnQty">Units</span>
               <span id="spnCost">Cost<br>(k)</span>
               <span id="spnRet">Retail<br>(k)</span>
           </th>   
           <%}%> 
           
           <th class="th02">&nbsp;</th>
           
           <%for(int j=0; j < iNumOfFutMn; j++){%>
           <th class="th02">
               <span id="spnNum"># of PO's</span>
               <span id="spnQty">Units</span>
               <span id="spnCost">Cost<br>(k)</span>
               <span id="spnRet">Retail<br>(k)</span>
           </th>   
           <%}%>
           
           <th class="th02">&nbsp;</th>
           <th class="th02">
               <span id="spnNum"># of PO's</span>
               <span id="spnQty">Units</span>
               <span id="spnCost">Cost<br>(k)</span>
               <span id="spnRet">Retail<br>(k)</span>
           </th>           
       </tr>
       <tr class="trHdr07">
       	   <th class="th02">with<br>ASN Posted<br>not recv.<br>Older<br>then 2 week</th>
       	   <th class="th02">with<br>ASN Posted<br>not recv.<br>Recent<br>then 2 week</th>
       	   <th class="th02">with<br>ASN Posted<br>not recv.<br>Total</th>
       	   <th class="th02">without<br>ASN Posted<br>not recv.</th>
           <th class="th02">FY thru<br>Last Week</th>
           <th class="th02">&nbsp;</th>
           
           <%for(int j=0; j < iNumOfCurWk; j++){%>
           <th class="th02"><%=sCurWk[j]%></th>
           <%}%>
           
           <th class="th02">&nbsp;</th>
           
           <%for(int j=0; j < iNumOfFutMn; j++){%>
           <th class="th02"><%=sFutMn[j]%></th>
           <%}%>
           
           <th class="th02">&nbsp;</th>
           <th class="th02">&nbsp;</th>
       </tr>
       
       <!-- === Details ===== -->
       <tr class="trDtl04"> 
           <td class="td12"><a href="POYtdPastCurFut.jsp" target="_blank">S</a></td>
           <td class="td12">
           	   <span id="spnNum"><%=s2wkNum[0]%></span>
               <span id="spnQty"><%=s2wkQty[0]%></span>
               <span id="spnCost"><%=s2wkCost[0]%></span>
               <span id="spnRet"><%=s2wkRet[0]%></span>
           </td>
           <td class="td12">
           	   <span id="spnNum"><%=s2wkNum[1]%></span>
               <span id="spnQty"><%=s2wkQty[1]%></span>
               <span id="spnCost"><%=s2wkCost[1]%></span>
               <span id="spnRet"><%=s2wkRet[1]%></span>
           </td>
           <td class="td12">
           	   <span id="spnNum"><%=sYtdNum[1]%></span>
               <span id="spnQty"><%=sYtdQty[1]%></span>
               <span id="spnCost"><%=sYtdCost[1]%></span>
               <span id="spnRet"><%=sYtdRet[1]%></span>
           </td>
           <td class="td12">
           	   <span id="spnNum"><%=sYtdNum[2]%></span>
               <span id="spnQty"><%=sYtdQty[2]%></span>
               <span id="spnCost"><%=sYtdCost[2]%></span>
               <span id="spnRet"><%=sYtdRet[2]%></span>
           </td>          
           <td class="td12">
           	   <span id="spnNum"><%=sYtdNum[0]%></span>
               <span id="spnQty"><%=sYtdQty[0]%></span>
               <span id="spnCost"><%=sYtdCost[0]%></span>
               <span id="spnRet"><%=sYtdRet[0]%></span>
           </td>
           
           <td class="td35">&nbsp;</td>
           
           <%for(int j=0; j < iNumOfCurWk; j++){%>
           <td class="td12">
           	   <span id="spnNum"><%=sCurNum[j]%></span>
               <span id="spnQty"><%=sCurQty[j]%></span>
               <span id="spnCost"><%=sCurCost[j]%></span>
               <span id="spnRet"><%=sCurRet[j]%></span>
           </td>
           <%}%>
           
           <td class="td35">&nbsp;</td>
           
           <%for(int j=0; j < iNumOfFutMn; j++){%>
           <td class="td12">
           	   <span id="spnNum"><%=sFutNum[j]%></span>
               <span id="spnQty"><%=sFutQty[j]%></span>
               <span id="spnCost"><%=sFutCost[j]%></span>
               <span id="spnRet"><%=sFutRet[j]%></span>
           </td>
           <%}%>
           
           <td class="td35">&nbsp;</td>
           
           <td class="td12">
           	   <span id="spnNum"><%=sYTotNum%></span>
               <span id="spnQty"><%=sYTotQty%></span>
               <span id="spnCost"><%=sYTotCost%></span>
               <span id="spnRet"><%=sYTotRet%></span>
           </td>
       </tr>    
       
      </table>
      
      <br>
      
      
       
      <!----------------------- EDI Summary ------------------------>
      &nbsp;<br>&nbsp;<br>
      <b>EDI/ASN - Recap</b>
      <table class="tbl04">
       <tr class="trHdr08">           
           <th class="th24"  >&nbsp;</th>
           <th class="th02">Fiscal Year</th>
           <th class="th24">&nbsp;</th>
           <th class="th02" colspan=3>Y-T-D</th>
           <th class="th24">&nbsp;</th>
           <th class="th02" colspan=3>Order Qty Totals</th>
           <th class="th24">&nbsp;</th>
           <th class="th02" colspan=3>Total Received</th>
           <th class="th24">&nbsp;</th>
           <th class="th02" colspan=3>Total Remainder</th>
       </tr> 
       <tr class="trHdr08">
           <th class="th02">EDI<br>Vendor?</th>
           <th class="th02"># of<br>EDI PO's</th>
           <th class="th02">&nbsp;</th>
           <th class="th02"># of<br>EDI PO's</th>
           <th class="th02"># w/ASN's<br>Posted?</th>
           <th class="th02">%</th>
           <th class="th02">&nbsp;</th>
           <th class="th02">Units</th>
           <th class="th02">Cost<br>(k)</th>
           <th class="th02">Retail<br>(k)</th>
           
           <th class="th02">&nbsp;</th>
           <th class="th02">Units</th>
           <th class="th02">Cost<br>(k)</th>
           <th class="th02">Retail<br>(k)</th>
           
           <th class="th02">&nbsp;</th>
           <th class="th02">Units</th>
           <th class="th02">Cost<br>(k)</th>
           <th class="th02">Retail<br>(k)</th>
       </tr>
       <!-- ================== details ================== -->
       <%for(int i=0; i < 2; i++){%>
       <tr class="trDtl04">
           <td class="td11"><%if(i==0){%>Yes<%}else{%>No<%}%></td>
           <td class="td12"><%=sEdiYrNum[i]%></td>
           <td class="td11">&nbsp;</td>
           <td class="td12"><%=sEdiNum[i]%></td>
           <td class="td12"><%=sEdiPost[i]%></td>
           <td class="td12" <%if(i==0){%>style="background:yellow; font-weight:bold;"<%}%>><%if(i==0){%><%=sEdiDiff[i]%>%<%} else{%>&nbsp;<%} %></td>
           
           <td class="td12">&nbsp;</td>
           
           <td class="td12"><%=sEdiQty[i]%></td>
           <td class="td12">$<%=sEdiCost[i]%></td>
           <td class="td12">$<%=sEdiRet[i]%></td>         
           
           <td class="td16">&nbsp;</td>
           <td class="td12"><%=sEdiRcvQty[i]%></td>
           <td class="td12">$<%=sEdiRcvCost[i]%></td>
           <td class="td12">$<%=sEdiRet[i]%></td>
           
           <td class="td16">&nbsp;</td>
           <td class="td12"><%=sEdiOpnQty[i]%></td>
           <td class="td12">$<%=sEdiOpnCost[i]%></td>
           <td class="td12">$<%=sEdiOpnRet[i]%></td>            
       </tr>
       <%}%>
       <!-- ================== totals ================== --> 
       <tr class="trDtl12" style="font-weight:bold;">
           <td class="td11">Totals</td>
           <td class="td12"><%=sEdiYrNum[2]%></td>
           <td class="td11">&nbsp;</td>
           <td class="td12"><%=sEdiNum[2]%></td>
           <td class="td12">&nbsp;</td>
           <td class="td12">&nbsp;</td>
           <td class="td12">&nbsp;</td>
           <td class="td12"><%=sEdiQty[2]%></td>
           <td class="td12">$<%=sEdiCost[2]%></td>
           <td class="td12">$<%=sEdiRet[2]%></td>
           
           <td class="td16">&nbsp;</td>
           <td class="td12"><%=sEdiRcvQty[2]%></td>
           <td class="td12">$<%=sEdiRcvCost[2]%></td>
           <td class="td12">$<%=sEdiRet[2]%></td>
           
           <td class="td16">&nbsp;</td>
           <td class="td12"><%=sEdiOpnQty[2]%></td>
           <td class="td12">$<%=sEdiOpnCost[2]%></td>
           <td class="td12">$<%=sEdiOpnRet[2]%></td>                               
       </tr>
       <tr class="trDtl12" style="font-weight:bold;">
           <td class="td11">% of PO's</td>
           <td class="td61" rowspan=3><%=sEdiRcv%>%</td>
       </tr>    
      </table>
        <!----------------------- end of report ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
porecap.disconnect();
porecap = null;
}
%>

<%
long lEndTime = (new java.util.Date()).getTime();
long lElapse = (lEndTime - lStartTime) / 1000;
if (lElapse==0) {lElapse = 1;}
//System.out.println("B/Item X-fer loading Elapse time=" + lElapse + " second(s)");
%>
<p  style="text-align: left; font-size:10px; font-weigth:bold;">Elapse: <%=lElapse%> sec.</td>
  
