<%@ page import="posend.POYtdStr, java.util.*, java.text.*"%>
<%
   	String sType = request.getParameter("Type");
	
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=POYtdStr.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	POYtdStr porecap = new POYtdStr();
    
    porecap.setYtdRecap(sType, sUser);
	
    int iNumOfStr = porecap.getNumOfStr();
    String [] sStr = porecap.getStr();
    String [] sStrReg = porecap.getStrReg();    
    int iNumOfReg = porecap.getNumOfReg();
    String [] sReg = porecap.getReg();
    
    String [] sPoStr = porecap.getPoStr();
    String [] sPoReg = porecap.getPoReg();
    
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
	
	String [] sRtotReg = porecap.getRtotReg();    
    String [] sRtotNum = porecap.getRtotNum();    
	String [] sRtotRet = porecap.getRtotRet();
	String [] sRtotCost = porecap.getRtotCost();
	String [] sRtotQty = porecap.getRtotQty();
	String [] sRtotRcvRet = porecap.getRtotRcvRet();
	String [] sRtotRcvCost = porecap.getRtotRcvCost();
	String [] sRtotRcvQty = porecap.getRtotRcvQty();
	String [] sRtotOpnRet = porecap.getRtotOpnRet();
	String [] sRtotOpnCost = porecap.getRtotOpnCost();
	String [] sRtotOpnQty = porecap.getRtotOpnQty();	
	String sRtotRcv = porecap.getRtotRcv();
	
    String sRepNum = porecap.getRepNum();    
	String sRepRet = porecap.getRepRet();
	String sRepCost = porecap.getRepCost();
	String sRepQty = porecap.getRepQty();
	String sRepRcvRet = porecap.getRepRcvRet();
	String sRepRcvCost = porecap.getRepRcvCost();
	String sRepRcvQty = porecap.getRepRcvQty();
	String sRepOpnRet = porecap.getRepOpnRet();
	String sRepOpnCost = porecap.getRepOpnCost();
	String sRepOpnQty = porecap.getRepOpnQty();	
	String sRepRcv = porecap.getRepRcv();
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Str PO Recap</title>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT>
//--------------- Global variables -----------------------
var SelStr = [<%=porecap.cvtToJavaScriptArray(sStr)%>];
var Type = "<%=sType%>";
var User = "<%=sUser%>";

var NumOfReg = "<%=iNumOfReg%>";
var NumOfStr = "<%=iNumOfStr%>";

 //--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
	 if (ua.match(/iPad/i) || ua.match(/iPhone/i)) 
	 {
		 isSafari = true;
		 setDraggable();
	 }
	 else
	 {
	 	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
	 }
	  
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
//show store POs
//==============================================================================
function showStrPo(str)
{
	var url="POWorksheetList.jsp?Store=" + str 
		+ "&Ven=ALL" 
		+ "&FromDate=3/27/2017"
		+ "&ToDate=03/25/2018"
		+ "&InclSO=&Sts=O&Type=B&Sort=PON";
	window.location.href = url;
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
          <th colspan=60>
            <b>Retail Concepts, Inc
            <br>Drop Shipment PO - Recap by Store
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;              
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;
          </th>
        </tr>
         
        <tr>
          <td>  
       <table class="tbl02">
       <tr class="trHdr07">
           <th class="th02" colspan=2>&nbsp;</th>
           <th class="th24">&nbsp;</th>
           <th class="th02" colspan=3>Order Qty Totals</th>
           <th class="th24">&nbsp;</th>
           <th class="th02" colspan=3>Total Received</th>
           <th class="th24">&nbsp;</th>
           <th class="th02" colspan=3>Total Remainder</th>
       </tr>
       
       <tr class="trHdr07">
           <th class="th02">PO Current<br>Status</th>           
           <th class="th02"># of<br>PO's</th>
           
           <th class="th02">&nbsp;</th>
           <th class="th02">Units</th>
           <th class="th02">Cost</th>
           <th class="th02">Retail</th>
           
           <th class="th02">&nbsp;</th>
           <th class="th02">Units</th>
           <th class="th02">Cost</th>
           <th class="th02">Retail</th>
           
           <th class="th02">&nbsp;</th>
           <th class="th02">Units</th>
           <th class="th02">Cost</th>
           <th class="th02">Retail</th>
       </tr>

        	
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvReg = sStrReg[0];
             String sTrCls = "trDtl06"; 
             int iArg = -1;
             int iReg = -1;                        
           %>
           
           <%for(int i=0; i < iNumOfStr; i++) 
             {        	         
           	%>                           
           	<tr id="trGrp<%=i%>" class="<%=sTrCls%>">
             	<!-- td id="tdStr<%=i%>" class="td12" nowrap><a href="javascript: showStrPo('<%=sStr[i]%>')"><%=sStr[i]%></a></td -->
             	<td id="tdStr<%=i%>" class="td12" nowrap><%=sStr[i]%></td>
             	<td id="tdStr<%=i%>" class="td12" nowrap><%=sPoNum[i]%></td>
             	<td class="td16">&nbsp;</td>
             	<td class="td12" nowrap><%=sPoQty[i]%></td>
             	<td class="td12" nowrap>$<%=sPoCost[i]%></td>
             	<td class="td12" nowrap>$<%=sPoRet[i]%></td>
             	<td class="td16">&nbsp;</td>
             	<td class="td12" nowrap><%=sPoRcvQty[i]%></td>
             	<td class="td12" nowrap>$<%=sPoRcvCost[i]%></td>
             	<td class="td12" nowrap>$<%=sPoRcvRet[i]%></td>
             	<td class="td16">&nbsp;</td>
             	<td class="td12"><%=sPoOpnQty[i]%></td>
           		<td class="td12">$<%=sPoOpnCost[i]%></td>
           		<td class="td12">$<%=sPoOpnRet[i]%></td>    
             </tr>
             
             <!-- =========== Region Total ============= -->  
             <%if((i < iNumOfStr - 1 && !sStrReg[i].equals(sStrReg[i+1]) || i == iNumOfStr - 1)){               		
         			iReg++;
             %>
             <tr class="trDtl12">
             	<td class="td11" nowrap>District <%=sStrReg[i]%></td>
             	<td class="td12" nowrap><%=sRtotNum[iReg]%></td>
             	<td class="td16">&nbsp;</td>
             	<td class="td12" nowrap><%=sRtotQty[iReg]%></td>
             	<td class="td12" nowrap>$<%=sRtotCost[iReg]%></td>
             	<td class="td12" nowrap>$<%=sRtotRet[iReg]%></td>
             	<td class="td16">&nbsp;</td>
             	<td class="td12" nowrap><%=sRtotRcvQty[iReg]%></td>
             	<td class="td12" nowrap>$<%=sRtotRcvCost[iReg]%></td>
             	<td class="td12" nowrap>$<%=sRtotRcvRet[iReg]%></td>
             	<td class="td16">&nbsp;</td>
             	<td class="td12"><%=sRtotOpnQty[iReg]%></td>
           		<td class="td12">$<%=sRtotOpnCost[iReg]%></td>
           		<td class="td12">$<%=sRtotOpnRet[iReg]%></td>              	
             </tr>
             <tr class="Divider"><td colspan=60>&nbsp;</td></tr>
             <%
             	if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
 				else {sTrCls = "trDtl06";}
               }%>  
           <%}%>
           
           
           <!-- =========== Report Total ============= -->  
              <tr class="Divider"><td colspan=60>&nbsp;</td></tr>
              <tr class="trDtl12">
             	<td class="td11" nowrap>Total</td>
             	<td class="td12" nowrap><%=sRepNum%></td>
             	<td class="td16">&nbsp;</td>
             	<td class="td12" nowrap><%=sRepQty%></td>
             	<td class="td12" nowrap>$<%=sRepCost%></td>
             	<td class="td12" nowrap>$<%=sRepRet%></td>
             	<td class="td16">&nbsp;</td>
             	<td class="td12" nowrap><%=sRepRcvQty%></td>
             	<td class="td12" nowrap>$<%=sRepRcvCost%></td>
             	<td class="td12" nowrap>$<%=sRepRcvRet%></td>
             	<td class="td16">&nbsp;</td>
             	<td class="td12"><%=sRepOpnQty%></td>
           		<td class="td12">$<%=sRepOpnCost%></td>
           		<td class="td12">$<%=sRepOpnRet%></td>              	
             </tr>
         </table>
      <!----------------------- end of table ------------------------>
      <br>
                
       
      </tr>
   </table>
 </body>
</html>
<%
porecap.disconnect();
porecap = null;
}
%>