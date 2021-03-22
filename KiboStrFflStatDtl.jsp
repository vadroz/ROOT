<%@ page import="mozu_com.KiboStrFflStatDtl, java.util.*, java.text.*"%>
<%
   String sSelStr = request.getParameter("Str");
   String sFrom = request.getParameter("FrDate");   
   String sTo = request.getParameter("ToDate");
   String sSort = request.getParameter("Sort");
   
   if(sSort == null){ sSort = "Str"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=KiboStrFflStatDtl.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	 
	KiboStrFflStatDtl strstat = new KiboStrFflStatDtl(sSelStr, sFrom, sTo, sSort, sUser);
	int iNumOfStr = strstat.getNumOfStr();
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
var Str = "<%=sSelStr%>";
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
	var url = "KiboStrFflStatDtlDtl.jsp?Str="  + str
	  + "&FrDate=" + FrDate
	  + "&ToDate=" + ToDate
	  + "&Sort=" + Sort
	;
	window.location.href = url; 
}
//==============================================================================
//retreive comment for selected store
//==============================================================================
function getStrCommt(site, ord, sku, obj)
{
	SelObj = obj;

	url = "MozuSrlAsgCommt.jsp?"
   	+ "Site=" + site
   	+ "&Order=" + ord
   	+ "&Sku=" + sku
   	+ "&Str=0"
   	+ "&Action=GETSTRCMMT"

   	if(isIE){ window.frame1.location.href = url; }
   	else if(isChrome || isEdge) { window.frame1.src = url; }
   	else if(isSafari){ window.frame1.location.href = url; }
}
//==============================================================================
//display comment for selected store
//==============================================================================
function showComments(site, ord, sku, serial, str, type,emp, commt, recusr, recdt, rectm)
{
	var hdr = "Comments. Order: " + ord + " &nbsp; SKU: " + sku ;
	var html = "<table class='DataTable'>"
  	+ "<tr>"
	    + "<td class='BoxName' nowrap>" + hdr + "</td>"
    	+ "<td class='BoxClose' valign=top>"
      	+  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
    	+ "</td></tr>"
  	+ "<tr><td class='Prompt' colspan=2>" + popComment(site, ord, sku, serial, str, type,emp, commt, recusr, recdt, rectm)
	    + "</td></tr>"
  	+ "</table>"

	document.all.dvItem.style.width=700;
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 200;
	document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate panel
//==============================================================================
function popComment(site, ord, sku, serial, str, type,emp, commt, recusr, recdt, rectm)
{
var panel = "<table class='tbl02'  id='tblLog'>"
 + "<tr class='trHdr01'>"
    + "<th class='th02'>S/N</th>"
    + "<th class='th02'>Type</th>"
    + "<th class='th02'>Store</th>"
    + "<th class='th02' nowrap>Emp #</th>"
    + "<th class='th02'>Comment</th>"
    + "<th class='th02'>Recorded by</th>"
 + "</tr>"
for(var i=0; i < commt.length; i++)
{
   panel += "<tr class='trDtl04'><td class='td11' nowrap>" + serial[i] + "</td>"
   panel += "<td class='td11' nowrap>" + type[i] + "</td>"

   if(str[i] != "0") { panel += "<td class='td11'>" + str[i] + "&nbsp;</td>" }
   else{ panel += "<td class='td11' nowrap>H.O.&nbsp;</td>" }
   panel += "<td class='td11' nowrap>&nbsp;" + emp[i] + "</td>"
     + "<td class='td11'>" + commt[i] + "&nbsp;</td>"
     + "<td class='td11' nowrap>" + recusr[i] + " " + recdt[i] + " " + rectm[i] + "</td>"
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
	win.document.write(tbl);
	hidePanel();
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
            <br>Kibo Store Detail Traffic
            <br>Store: <%=sSelStr%> 
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
          <th class="th02" rowspan=3>Order</th>
          <th class="th02" rowspan=3>Short Sku</th>
          <th class="th02" rowspan=3>L<br>o<br>g</th>
          <th class="th02" rowspan=3>Order Date</th>
          <th class="th02" rowspan=3>Ship Date</th>
          <th class="th02" rowspan=3>&nbsp;</th>
          <th class="th02" colspan=14>Sales</th>
          <th class="th02" rowspan=3>&nbsp;</th>
          <th class="th02" colspan=11>Returns</th>
        </tr>  
        <tr class="trHdr01">
          <th class="th02" colspan=2>STS fulfilled by store<br>/ cust p/u there</th>
          <th class="th02" rowspan=2>&nbsp;</th>
          <th class="th02" colspan=2>STS fulfilled<br>by ANOTHER store<br>/ cust p/u there</th>
          <th class="th02" rowspan=2>&nbsp;</th>
          <th class="th02" colspan=2>Orders fulfilled<br> by the store<br> at reg. retail</th>
          <th class="th02" rowspan=2>&nbsp;</th>
          <th class="th02" colspan=2>Orders fulfilled<br> by the store<br> not at reg. retail</th>
          <th class="th02" rowspan=2>&nbsp;</th>
          <th class="th02" colspan=2>Ecomm Orders placed<br>by customers in store<br>for pick-up at that store</th>
          
          <th class="th02" colspan=2>STS fulfilled by store<br>/ cust p/u there</th>
          <th class="th02" rowspan=2>&nbsp;</th>
          <th class="th02" colspan=2>Orders fulfilled<br> by the store<br> at reg. retail</th>
          <th class="th02" rowspan=2>&nbsp;</th>
          <th class="th02" colspan=2>Orders fulfilled<br> by the store<br> not at reg. retail</th>
          
        </tr>
        <tr class="trHdr01">
          <%for(int j=0; j < 5; j++){%>
          	<th class="th32">Qty</th>
          	<th class="th32">Retail</th>
          <%} %>    
          
          <%for(int j=5; j < 8; j++){%>
          	<th class="th33">Qty</th>
          	<th class="th33">Retail</th>
          <%} %>
             
        </tr>
        
 <!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfStr; i++) {  
        	   strstat.setStrTrf();
               
               String sStr = strstat.getStr();
               String sOrd = strstat.getOrd();
               String sSku = strstat.getSku();
               String sOrdDt = strstat.getOrdDt();
               String sShpDt = strstat.getShpDt();
               String [] sQty = strstat.getQty();
               String [] sRet = strstat.getRet();
        	   
        	   if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
   			   else {sTrCls = "trDtl06";}
           %>
           <%if(i > 0 && i % 20 == 0){%>
           <tr class="trHdr01">
          	<th class="th02" >Order</th>
          	<th class="th02" >Short Sku</th>
          	<th class="th02" >L</th>
          	<th class="th02" >Order Date</th>
          	<th class="th02" >Ship Date</th>
          	<th class="th02">&nbsp;</th>
          	<th class="th32" colspan=2>a</th>
          	<th class="th32">&nbsp;</th>
          	<th class="th32" colspan=2>b</th>
          	<th class="th32">&nbsp;</th>
          	<th class="th32" colspan=2>c</th>
          	<th class="th32">&nbsp;</th>
          	<th class="th32" colspan=2>d</th>
          	<th class="th32">&nbsp;</th>
          	<th class="th32" colspan=2>e</th>   
          	<th class="th33">&nbsp;</th>
          	<th class="th33" colspan=2>f</th>
          	<th class="th33">&nbsp;</th>
          	<th class="th33" colspan=2>g</th>
          	<th class="th33">&nbsp;</th>
          	<th class="th33" colspan=2>h</th>                
        </tr>
           <%}%>
           <tr id="trStr<%=i%>" class="<%=sTrCls%>">
             	<td class="td12" nowrap><a href="MozuSrlAsgCtl.jsp?StsFrDate=01/01/0001&StsToDate=12/31/2099&Sku=&Ord=<%=sOrd%>&OrdSts=1&Sts=Open&Sts=Assigned&Sts=Printed&Sts=Picked&Sts=Problem&Sts=Resolve&Sts=Shipped&Sts=Cannot Fill&Sts=Sold Out&Sts=Error&Sts=Cancelled" target="_blank"><%=sOrd%></a></td>
             	<td class="td12" nowrap><%=sSku%></td>
             	<td class="td12" nowrap><a href="javascript: getStrCommt('11961' , '<%=sOrd%>', '<%=sSku%>', document.all.thLog<%=i%>);">&nbsp;L&nbsp;</a></td>
             	<td class="td12" nowrap><%=sOrdDt%></td>
             	<td class="td12" nowrap><%=sShpDt%></td>
             	
           		<%for(int j=0; j < 4; j++){%>   
           		    <td class="td72">&nbsp;</td>        			
           			<td class="td12" nowrap><%=sQty[j]%></td>
           			<td class="td12" nowrap><%if(!sRet[j].equals(".00")){%>$<%=sRet[j]%><%} %></td>           
           		<%}%>
           		<td class="td72">&nbsp;</td>        	
           		<td class="td12" nowrap>&nbsp;</td>
           		<td class="td12" nowrap>&nbsp;</td>
           		
           		<td class="td72">&nbsp;</td>        			
           		<td class="td12" nowrap><%=sQty[4]%></td>
           		<td class="td12" nowrap><%if(!sRet[4].equals(".00")){%>$(<%=sRet[4]%>)<%}%></td> 
           		<td class="td72">&nbsp;</td>        			
           		<td class="td12" nowrap><%=sQty[6]%></td>
           		<td class="td12" nowrap><%if(!sRet[6].equals(".00")){%>$(<%=sRet[6]%>)<%}%></td>
           		<td class="td72">&nbsp;</td>        			
           		<td class="td12" nowrap><%=sQty[7]%></td>
           		<td class="td12" nowrap><%if(!sRet[7].equals(".00")){%>$(<%=sRet[7]%>)<%}%></td>            
           		
           </tr>
           <%}%> 
           
         <!----------------------- Totals ------------------------>
        <%   
           strstat.setTotal();
    	   String [] sQty = strstat.getQty();
    	   String [] sRet = strstat.getRet();  
    	 %>   
    	 <tr id="trTotal" class="trDtl03">
    	 <td class="td11" colspan=5 nowrap>Total</td>
    	 <%for(int j=0; j < 4; j++){%>
    	    <td class="td72">&nbsp;</td>        	                  			
           	<td class="td12" nowrap><%=sQty[j]%></td>
           	<td class="td12" nowrap>$<%=sRet[j]%></td>           
         <%}%>
         <td class="td72">&nbsp;</td>        	 
         <td class="td12" nowrap>&nbsp;</td>
         <td class="td12" nowrap>&nbsp;</td>
         
         <td class="td72">&nbsp;</td>        			
         <td class="td12" nowrap><%=sQty[4]%></td>
         <td class="td12" nowrap>$(<%=sRet[4]%>)</td> 
         <td class="td72">&nbsp;</td>        			
         <td class="td12" nowrap><%=sQty[6]%></td>
         <td class="td12" nowrap>$(<%=sRet[6]%>)</td>
         <td class="td72">&nbsp;</td>        			
         <td class="td12" nowrap><%=sQty[7]%></td>
         <td class="td12" nowrap>$(<%=sRet[7]%>)</td>    
         
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