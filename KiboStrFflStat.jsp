<%@ page import="mozu_com.KiboStrFflStat, java.util.*, java.text.*"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String sFrom = request.getParameter("FrDate");   
   String sTo = request.getParameter("ToDate");
   String sSort = request.getParameter("Sort");
   
   if(sSort == null){ sSort = "Str"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=KiboStrFflStat.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	 
	KiboStrFflStat strstat = new KiboStrFflStat(sSelStr, sFrom, sTo, sSort, sUser);
	int iNumOfStr = strstat.getNumOfStr();
	String sStrJsa = strstat.cvtToJavaScriptArray(sSelStr);
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Kibo - Store Traffic</title>

<SCRIPT>

//--------------- Global variables -----------------------
var ArrStr = [<%=sStrJsa%>];
var FrDate = "<%=sFrom%>";
var ToDate = "<%=sTo%>";
var Sort = "<%=sSort%>";
//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }
   	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvOrd"]);
}
//==============================================================================
// drill to store details
//==============================================================================
function drillDown(str)
{
	var url = "KiboStrFflStatDtl.jsp?Str="  + str
	  + "&FrDate=" + FrDate
	  + "&ToDate=" + ToDate
	  + "&Sort=" + Sort
	;
	window.open(url); 
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
<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvOrd" class="dvItem"></div>
<div id="dvWait" class="dvItem"></div>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<iframe  id="frame2"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Kibo Store Summary Traffic 
            <br>From: <%=sFrom%> Through: <%=sTo%>  
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="KiboStrFflStatSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02" rowspan=3>Store</th>
          <th class="th02" colspan=15>Sales</th>
          <th class="th02" rowspan=3>&nbsp;</th>
          <th class="th02" colspan=12>Returns</th>
        <tr class="trHdr01">  
          <th class="th02" nowrap colspan=3>STS fulfilled by store<br>/ cust p/u there</th>
          <th class="th02" nowrap colspan=3>STS fulfilled<br>by ANOTHER store<br>/ cust p/u there</th>
          <th class="th02" nowrap colspan=3>Orders fulfilled<br> by the store<br> at reg. retail</th>
          <th class="th02" nowrap colspan=3>Orders fulfilled<br> by the store<br> not at reg. retail</th>
          <th class="th02" nowrap colspan=3>Ecomm Orders placed<br>by customers in store<br>for pick-up at that store</th>
          
          <th class="th02" nowrap colspan=3>STS fulfilled by store<br>/ cust p/u there</th>
          <th class="th02" nowrap colspan=3>Orders fulfilled<br> by the store<br> at reg. retail</th>
          <th class="th02" nowrap colspan=3>Orders fulfilled<br> by the store<br> not at reg. retail</th>
          
        </tr>
        <tr class="trHdr01">
          <%for(int j=0; j < 8; j++){%>
          	<th class="th02">Number<br>Of<br>Orders</th>
          	<th class="th02">Qty</th>
          	<th class="th02">Retail</th>
          <%} %>          
        </tr>
        
 <!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfStr; i++) {  
        	   strstat.setSumTrf();
        	   
        	   String sStr = strstat.getStr();
               String [] sOrd = strstat.getOrd();
               String [] sQty = strstat.getQty();
               String [] sRet = strstat.getRet();
        	   
        	   if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
   			   else {sTrCls = "trDtl06";}
           %>
           <tr id="trStr<%=i%>" class="<%=sTrCls%>">
             	<td class="td11" nowrap><a href="javascript: drillDown('<%=sStr%>')"><%=sStr%></a></td>                           
           		<%for(int j=0; j < 4; j++){%>
           			<td class="td12" nowrap><%=sOrd[j]%></td>    
           			<td class="td12" nowrap><%=sQty[j]%></td>
           			<td class="td12" nowrap><%if(!sRet[j].equals(".00")){%>$<%=sRet[j]%><%}%></td>           
           		<%}%>
           		<td class="td12" nowrap>&nbsp;</td>
           		<td class="td12" nowrap>&nbsp;</td>
           		<td class="td12" nowrap>$0.00</td>
           		
           		<td class="td12" nowrap>&nbsp;</td>
           		<td class="td12" nowrap><%=sOrd[4]%></td>    
           		<td class="td12" nowrap><%=sQty[4]%></td>
           		<td class="td12" nowrap><%if(!sRet[4].equals(".00")){%>$(<%=sRet[4]%>)<%}%></td>   
           		<td class="td12" nowrap><%=sOrd[6]%></td>    
           		<td class="td12" nowrap><%=sQty[6]%></td>
           		<td class="td12" nowrap><%if(!sRet[6].equals(".00")){%>$(<%=sRet[6]%>)<%}%></td>
           		<td class="td12" nowrap><%=sOrd[7]%></td>    
           		<td class="td12" nowrap><%=sQty[7]%></td>
           		<td class="td12" nowrap><%if(!sRet[7].equals(".00")){%>$(<%=sRet[7]%>)<%} %></td>           
           		
           		
           </tr>
           <%}%>
           
           <!-- =========== Totals ========================= -->         
           <%strstat.setTotal();
        	   
        	   String sStr = strstat.getStr();
               String [] sOrd = strstat.getOrd();
               String [] sQty = strstat.getQty();
               String [] sRet = strstat.getRet();
           %>
           <tr id="trTotal" class="trDtl03">
             	<td class="td11" nowrap>Totals</td>                           
           		<%for(int j=0; j < 4; j++){%>
           			<td class="td12" nowrap><%=sOrd[j]%></td>
           			<td class="td12" nowrap><%=sQty[j]%></td>
           			<td class="td12" nowrap><%if(!sRet[j].equals(".00")){%>$<%=sRet[j]%><%}%></td>           
           		<%}%>
           		<td class="td12" nowrap>&nbsp;</td>
           		<td class="td12" nowrap>&nbsp;</td>
           		<td class="td12" nowrap>$0.00</td>
           		
           		<td class="td12" nowrap>&nbsp;</td>
           		<td class="td12" nowrap><%=sOrd[4]%></td>    
           		<td class="td12" nowrap><%=sQty[4]%></td>
           		<td class="td12" nowrap><%if(!sRet[4].equals(".00")){%>$(<%=sRet[4]%>)<%}%></td>   
           		<td class="td12" nowrap><%=sOrd[6]%></td>    
           		<td class="td12" nowrap><%=sQty[6]%></td>
           		<td class="td12" nowrap><%if(!sRet[6].equals(".00")){%>$(<%=sRet[6]%>)<%}%></td>
           		<td class="td12" nowrap><%=sOrd[7]%></td>    
           		<td class="td12" nowrap><%=sQty[7]%></td>
           		<td class="td12" nowrap><%if(!sRet[7].equals(".00")){%>$(<%=sRet[7]%>)<%}%></td>      
           </tr>
  
            
        </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
strstat.disconnect();
strstat = null;
}
%>