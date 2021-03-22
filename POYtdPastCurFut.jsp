<%@ page import="posend.POYtdPastCurFut, java.util.*, java.text.*"%>
<%
	
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=POYtdPastCurFut.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	POYtdPastCurFut porecap = new POYtdPastCurFut();
    
    porecap.setYtdRecap(sUser);
	
    int iNumOfStr = porecap.getNumOfStr();
    String [] sStr = porecap.getStr();
    String [] sStrReg = porecap.getStrReg();    
    int iNumOfReg = porecap.getNumOfReg();
    String [] sReg = porecap.getReg();
    

    int iNumOfWk = porecap.getNumOfWk();
    String [] sCurWk = porecap.getCurWk();
    int iNumOfMon = porecap.getNumOfMon();
    String [] sFutMon = porecap.getFutMon();    
    String sYrBeg = porecap.getYrBeg();
    String sYrEnd = porecap.getYrEnd();
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>PO Future Ord by Str</title>

<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<SCRIPT>
//--------------- Global variables -----------------------
var SelStr = [<%=porecap.cvtToJavaScriptArray(sStr)%>];
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
	  
	 setOpnPOTbl("C");
}
//==============================================================================
// show selected value types
//==============================================================================
function setOpnPOTbl(type)
{
	var num = document.all["spnNum"];
	var qty = document.all["spnQty"];
	var cost = document.all["spnCost"];
	var ret = document.all["spnRet"];
	
	if(type=="U")
	{
		for(var i=0; i < num.length; i++)
		{
			num[i].style.display = "none";
			qty[i].style.display = "block";
			cost[i].style.display = "none";
			ret[i].style.display = "none";
		}	}
	else if(type=="C")
	{
		for(var i=0; i < num.length; i++)
		{
			num[i].style.display = "none";
			qty[i].style.display = "none";
			cost[i].style.display = "block";
			ret[i].style.display = "none";
		}				
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
		+ "&FromDate=<%=sYrBeg%>"
		+ "&ToDate=<%=sYrEnd%>"
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
            <br>Future Orders - by PO Anticipat Date 
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;              
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;
          </th>
        </tr>
         
        <tr>
          <td style="text-align:center;">
           <span style="font-size:10px">
      		<input type="radio" name="Info" value="U" onclick="setOpnPOTbl(this.value)">Units &nbsp;&nbsp;
      		<input type="radio" name="Info" value="C" onclick="setOpnPOTbl(this.value)" checked>Cost &nbsp;&nbsp;
      		<input type="radio" name="Info" value="R" onclick="setOpnPOTbl(this.value)">Retail &nbsp;&nbsp;
      		<input type="radio" name="Info" value="N" onclick="setOpnPOTbl(this.value)"># of PO's &nbsp;&nbsp;
      	   </span>
            
       <table class="tbl02">
       <tr class="trHdr07">
      	   <th class="th02" rowspan="3">S<br>t<br>o<br>r<br>e</th>
           <th class="th02" colspan=3>Past Anticipate Date</th>
           <th class="th24">&nbsp;</th>
           <th class="th02" colspan="<%=iNumOfWk%>">Current Month Week(s)</th>
           <th class="th24">&nbsp;</th>
           <th class="th02" colspan="<%=iNumOfMon%>">Future Month(s)</th>
        </tr>   
       
       <tr class="trHdr07">
       <th class="th02">
               <span id="spnNum"># of PO's</span>
               <span id="spnQty">Units</span>
               <span id="spnCost">Cost</span>
               <span id="spnRet">Retail</span>
           </th>
           <th class="th02">
               <span id="spnNum"># of PO's</span>
               <span id="spnQty">Units</span>
               <span id="spnCost">Cost</span>
               <span id="spnRet">Retail</span>
           </th>
           <th class="th02">
               <span id="spnNum"># of PO's</span>
               <span id="spnQty">Units</span>
               <span id="spnCost">Cost</span>
               <span id="spnRet">Retail</span>
           </th> 
           
           <th class="th02">&nbsp;</th>
           
           <%for(int j=0; j < iNumOfWk; j++){%>
           <th class="th02">
               <span id="spnNum"># of PO's</span>
               <span id="spnQty">Units</span>
               <span id="spnCost">Cost</span>
               <span id="spnRet">Retail</span>
           </th>   
           <%}%> 
           
           <th class="th02">&nbsp;</th>
           
           <%for(int j=0; j < iNumOfMon; j++){%>
           <th class="th02">
               <span id="spnNum"># of PO's</span>
               <span id="spnQty">Units</span>
               <span id="spnCost">Cost</span>
               <span id="spnRet">Retail</span>
           </th>   
           <%}%>           
       </tr>
       <tr class="trHdr07">       		
       	   <th class="th02">with<br>ASNPosted<br>not recv.</th>
       	   <th class="th02">without<br>ASN Posted<br>not recv.</th>
           <th class="th02">FY thru<br>Last Week</th>
           <th class="th02">&nbsp;</th>
           
           <%for(int j=0; j < iNumOfWk; j++){%>
           <th class="th02"><%=sCurWk[j]%></th>
           <%}%>
           
           <th class="th02">&nbsp;</th>
           
           <%for(int j=0; j < iNumOfMon; j++){%>
           <th class="th02"><%=sFutMon[j]%></th>
           <%}%>
       </tr>

        	
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvReg = sStrReg[0];
             String sTrCls = "trDtl06"; 
             int iArg = -1;
             int iReg = 0;                        
           %>
           
           <%for(int i=0; i < iNumOfStr; i++) 
             {        
        	   	porecap.setPoSum(i+1);
        	   	String [] sYtdNum = porecap.getYtdNum();    
        		String [] sYtdRet = porecap.getYtdRet();
        		String [] sYtdCost = porecap.getYtdCost();
        		String [] sYtdQty = porecap.getYtdQty();
       	        
       	    	String [] sCurNum = porecap.getCurNum();    
       			String [] sCurRet = porecap.getCurRet();
       			String [] sCurCost = porecap.getCurCost();
       			String [] sCurQty = porecap.getCurQty();
       	    
       	    	String [] sFutNum = porecap.getFutNum();    
       			String [] sFutRet = porecap.getFutRet();
       			String [] sFutCost = porecap.getFutCost();
       			String [] sFutQty = porecap.getFutQty();
           	%>                           
           	<tr id="trGrp<%=i%>" class="<%=sTrCls%>">
           	    <td id="tdStr<%=i%>" class="td12" nowrap>
           	       <a href="POWorksheetList.jsp?Store=<%=sStr[i]%>&Ven=ALL&FromDate=<%=sYrBeg%>&ToDate<%=sYrEnd%>&InclSO=&Sts=O&Type=B&Sort=PON" target="_blank"><%=sStr[i]%></a>
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
           
           		<%for(int j=0; j < iNumOfWk; j++){%>
           			<td class="td12">
           	   			<span id="spnNum"><%=sCurNum[j]%></span>
               			<span id="spnQty"><%=sCurQty[j]%></span>
               			<span id="spnCost"><%=sCurCost[j]%></span>
               			<span id="spnRet"><%=sCurRet[j]%></span>
           			</td>
           		<%}%>     
           		
           		<td class="td35">&nbsp;</td>
           
           		<%for(int j=0; j < iNumOfMon; j++){%>
           			<td class="td12">
           	   			<span id="spnNum"><%=sFutNum[j]%></span>
               			<span id="spnQty"><%=sFutQty[j]%></span>
               			<span id="spnCost"><%=sFutCost[j]%></span>
               			<span id="spnRet"><%=sFutRet[j]%></span>
           			</td>
           		<%}%>            	             	   
             </tr>
             
             <!-- =========== Region Total ============= -->  
             <%if((i < iNumOfStr - 1 && !sStrReg[i].equals(sStrReg[i+1]) || i == iNumOfStr - 1)){               		
         			iReg++;
         		porecap.setRegTot(iReg);
           		sYtdNum = porecap.getYtdNum();    
           		sYtdRet = porecap.getYtdRet();
           		sYtdCost = porecap.getYtdCost();
           		sYtdQty = porecap.getYtdQty();
           	        
           	    sCurNum = porecap.getCurNum();    
           		sCurRet = porecap.getCurRet();
           		sCurCost = porecap.getCurCost();
           		sCurQty = porecap.getCurQty();
           	    
           	    sFutNum = porecap.getFutNum();    
           		sFutRet = porecap.getFutRet();
           		sFutCost = porecap.getFutCost();
           		sFutQty = porecap.getFutQty();
           		
             %>
             <tr class="trDtl12">
             	<td class="td11" nowrap>District <%=sStrReg[i]%></td> 
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
           
           		<%for(int j=0; j < iNumOfWk; j++){%>
           			<td class="td12">
           	   			<span id="spnNum"><%=sCurNum[j]%></span>
               			<span id="spnQty"><%=sCurQty[j]%></span>
               			<span id="spnCost"><%=sCurCost[j]%></span>
               			<span id="spnRet"><%=sCurRet[j]%></span>
           			</td>
           		<%}%>     
           		
           		<td class="td35">&nbsp;</td>
           
           		<%for(int j=0; j < iNumOfMon; j++){%>
           			<td class="td12">
           	   			<span id="spnNum"><%=sFutNum[j]%></span>
               			<span id="spnQty"><%=sFutQty[j]%></span>
               			<span id="spnCost"><%=sFutCost[j]%></span>
               			<span id="spnRet"><%=sFutRet[j]%></span>
           			</td>
           		<%}%>            	             	   
             </tr>
             	            	              	
             </tr>
             <tr class="Divider"><td colspan=60>&nbsp;</td></tr>
             <%
             	if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
 				else {sTrCls = "trDtl06";}
               }%>  
           <%}%>
           
           
           <!-- =========== Report Total ============= -->
           <%
           	porecap.setRepTot();
           	String [] sYtdNum = porecap.getYtdNum();    
   			String [] sYtdRet = porecap.getYtdRet();
   			String [] sYtdCost = porecap.getYtdCost();
   			String [] sYtdQty = porecap.getYtdQty();
  	        
  	    	String [] sCurNum = porecap.getCurNum();    
  			String [] sCurRet = porecap.getCurRet();
  			String [] sCurCost = porecap.getCurCost();
  			String [] sCurQty = porecap.getCurQty();
  	    
  	    	String [] sFutNum = porecap.getFutNum();    
  			String [] sFutRet = porecap.getFutRet();
  			String [] sFutCost = porecap.getFutCost();
  			String [] sFutQty = porecap.getFutQty();
           %>
 
              <tr class="Divider"><td colspan=60>&nbsp;</td></tr>
              <tr class="trDtl12">
             	<td class="td11" nowrap>Total</td> 
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
           
           		<%for(int j=0; j < iNumOfWk; j++){%>
           			<td class="td12">
           	   			<span id="spnNum"><%=sCurNum[j]%></span>
               			<span id="spnQty"><%=sCurQty[j]%></span>
               			<span id="spnCost"><%=sCurCost[j]%></span>
               			<span id="spnRet"><%=sCurRet[j]%></span>
           			</td>
           		<%}%>     
           		
           		<td class="td35">&nbsp;</td>
           
           		<%for(int j=0; j < iNumOfMon; j++){%>
           			<td class="td12">
           	   			<span id="spnNum"><%=sFutNum[j]%></span>
               			<span id="spnQty"><%=sFutQty[j]%></span>
               			<span id="spnCost"><%=sFutCost[j]%></span>
               			<span id="spnRet"><%=sFutRet[j]%></span>
           			</td>
           		<%}%>            	             	   
             </tr>            	            
               <!-- =========== Report Total ============= -->
           <%
           	porecap.setRepTot_wo_Whs();
           	sYtdNum = porecap.getYtdNum();    
   			sYtdRet = porecap.getYtdRet();
   			sYtdCost = porecap.getYtdCost();
   			sYtdQty = porecap.getYtdQty();
  	        
  	    	sCurNum = porecap.getCurNum();    
  			sCurRet = porecap.getCurRet();
  			sCurCost = porecap.getCurCost();
  			sCurQty = porecap.getCurQty();
  	    
  	    	sFutNum = porecap.getFutNum();    
  			sFutRet = porecap.getFutRet();
  			sFutCost = porecap.getFutCost();
  			sFutQty = porecap.getFutQty();
           %>
 
              <tr class="Divider"><td colspan=60>&nbsp;</td></tr>
              <tr class="trDtl12">
             	<td class="td11" nowrap>Total w/o Str 1,55,75</td> 
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
           
           		<%for(int j=0; j < iNumOfWk; j++){%>
           			<td class="td12">
           	   			<span id="spnNum"><%=sCurNum[j]%></span>
               			<span id="spnQty"><%=sCurQty[j]%></span>
               			<span id="spnCost"><%=sCurCost[j]%></span>
               			<span id="spnRet"><%=sCurRet[j]%></span>
           			</td>
           		<%}%>     
           		
           		<td class="td35">&nbsp;</td>
           
           		<%for(int j=0; j < iNumOfMon; j++){%>
           			<td class="td12">
           	   			<span id="spnNum"><%=sFutNum[j]%></span>
               			<span id="spnQty"><%=sFutQty[j]%></span>
               			<span id="spnCost"><%=sFutCost[j]%></span>
               			<span id="spnRet"><%=sFutRet[j]%></span>
           			</td>
           		<%}%>            	             	   
             </tr>            	            
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