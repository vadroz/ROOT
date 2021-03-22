<!DOCTYPE html>	
<%@ page import="com.test.api.MozuOrdRetDisplay, java.util.*, java.text.*
, rciutility.RunSQLStmt, java.sql.ResultSet"%>  
<%
	String sOrder = request.getParameter("Order");
	
	MozuOrdRetDisplay morder = new MozuOrdRetDisplay();
	   
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

//==============================================================================
// set selected order
//==============================================================================
function setOrder()
{
	var ord = document.getElementsByName("inpOrd")[0].value;
	var url="MozuOrdRetDisp.jsp?Order=" + ord;
	window.location.href=url;
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
          <th >
            <b>Retail Concepts, Inc
            <br>Mozu - Return Order Analysys           
            </b>            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <font size="-1">This Page.</font> 
              <br>Order: <input name="inpOrd" size=12 maxlength="10"> 
                 <button onclick="setOrder()">Go</button>          
          </th>
        </tr>
        
    <%if(sOrder != null){%>
      <tr class="trHdr">
          <th colspan=45>
            Order: <%=sOrder%> 
          </th>
     </tr>       
     <tr>
     <td>&nbsp;<br>
    <!-- ========== Start of SSN Table ========== -->
    <table class="tbl02" id="tblSsn">
         
    <%
       morder.getOrderReturn(sOrder, false);
       int iNumOfRtn = morder.getNumOfRtn();
       for(int i = 0; i < iNumOfRtn; i++)			
	   {
			morder.getReturn(i);
			String sCrtDate = morder.getCrtDate();
			String sRefTot = morder.getRefTot();
	%>	
	    <tr id="trId" class="trDtl04">
	      <td class="td12" nowrap>Creation Date</td> 
          <td class="td11" nowrap><%=sCrtDate%></td>
          <td class="td11" nowrap>&nbsp; &nbsp; &nbsp; </td>
          <td class="td12" nowrap>Return Total</td> 
          <td class="td11" nowrap>$<%=sRefTot%></td>
        </tr>
        <tr id="trId" class="trDtl04">
        	<td class="td12" colspan=5>        
        	<table class="tbl02" id="tblretItem">
        	  <tr class="trHdr01">
                 <th class="th02">Item</th>
                 <th class="th02">Description</th>
                 <th class="th02">Refund Amount</th>
                 <th class="th02">Refund Tax</th>
                 <th class="th02">Refund Amt & Tax<br>Alter KIBO</th>
              </tr>  
        	<%
        	
        	morder.getRefItemList();
			int iNumOfItm = morder.getNumOfItm();
			for(int j = 0; j < iNumOfItm; j++)
			{
				morder.getRetItem(j);
				String sRetItem = morder.getRetItem();
				String sRetDesc = morder.getRetDesc();
				String sRefAmt = morder.getRefAmt();
				String sRefTax = morder.getRefTax();
				String sRefAmtAndTax = morder.getRefAmtAndTax();
        	%>
          		<tr id="trId" class="trDtl06">
	      			<td class="td11" nowrap><%=sRetItem%></td>
	      			<td class="td11" nowrap><%=sRetDesc%></td>
	      			<td class="td11" nowrap><%=sRefAmt%></td>
	      		    <td class="td11" nowrap><%=sRefTax%></td>
	      		    <td class="td11" nowrap><%=sRefAmtAndTax%></td>
	      		</tr>
        	<%}%>
            </td>
         <tr>   
	<%}%>
    </table>
  <%} %> 
</html>
<%
morder.disconnect();
morder = null;
%>