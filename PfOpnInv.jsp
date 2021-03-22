<%@ page import="patiosales.PfOpnInv, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String sSelStr = request.getParameter("Str");
   String sIncl = request.getParameter("Incl");
   String sSelOrd = request.getParameter("Ord");
   String sSort = request.getParameter("Sort");
   
   if(sSelOrd == null){ sSelOrd = " "; }
   if(sSort == null){ sSort = "Order"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PfOpnInv.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	 
	PfOpnInv ordlst = new PfOpnInv(sSelStr, sIncl, sSelOrd, sSort, sUser);
	int iNumOfOrd = ordlst.getNumOfOrd();   
	
	String [] sArrStr = new String[]{ "35", "46", "50", "55", "63", "64", "68", "86" };
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>PF Open Order Inventory</title>

<SCRIPT>

//--------------- Global variables -----------------------
var SelStr = "<%=sSelStr%>";
var SelOrd = "<%=sSelOrd%>";
var Sort = "<%=sSort%>"
var User = "<%=sUser%>";

 //--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);   
   if( SelStr != null) {document.all.spnStr.innerHTML = SelStr;}
}
//==============================================================================
// show PI details
//==============================================================================
function showPiDtl(ord, argo, numitm)
{
	var skul = "";
	var arr = new Array();
	var sku = new Array();
	var onh = new Array();
	var phy = new Array();
	var adj = new Array();
	var qty = new Array();
	 
	for(var i=0; i < numitm; i++)
	{ 
		var skunm = "spnSku" + argo + i;
	  	skul = document.all[skunm].innerHTML;
	  	arr = skul.split(",");
	  	sku[i] = arr[0];
	  
	  	var arrq = new Array();
	  	for( var j=1; j < 9; j++){ arrq[arrq.length] = arr[j]; }
	  	onh[i] = arrq;
	  	
	  	arrq = new Array();
	  	for( var j=9; j < 17; j++){ arrq[arrq.length] = arr[j]; }
	  	phy[i] = arrq;
	  	
	  	arrq = new Array();
	  	for( var j=17; j < 25; j++){ arrq[arrq.length] = arr[j]; }
	  	adj[i] = arrq;
	  	
	  	//arrq = new Array();
	  	//for( var j=25; j < 33; j++){ arrq[arrq.length] = arr[j]; }
	  	//qty[i] = arrq;
	}
	// get qty on order
	for(var i=0; i < numitm; i++)
	{ 
		var qtynm = "tdItm" + argo + "I" + i;
	  	qty[i] = document.all[qtynm].innerHTML;
	}  	
	
	var hdr = "Order: " + ord;
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	  + "<tr>"
	    + "<td class='BoxName' nowrap>" + hdr + "</td>"
	    + "<td class='BoxClose' valign=top>"
	      +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	    + "</td></tr>"
	  + "<tr><td class='Prompt' colspan=2>" + popPiDtl(sku, onh, phy, adj, qty)
	    + "</td></tr>"
	  + "</table>"

	document.all.dvItem.style.width=800;
	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 100;
	document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate panel
//==============================================================================
function popPiDtl(sku, onh, phy, adj, qty)
{
	var panel = "<table class='tbl02' cellSpacing='0' width='100%' id='tblLog'>"
	 + "<tr class='trHdr01'>"
	    + "<th class='th18' rowspan=2>SKU</th>"
	    + "<th class='th18' rowspan=2>Ord<br>Qty</th>"
	    + "<th class='th02' colspan=3 style='background:#A9A9F5'>35</th>"
	    + "<th class='th02' colspan=3 style='background:#A9A9F5'>46</th>"
	    + "<th class='th18' colspan=3 style='background:#A9A9F5'>50</th>"
	    + "<th class='th02' colspan=3 style='background:#FBCAC1'>55</th>"
	    + "<th class='th02' colspan=3 style='background:#FBCAC1'>63</th>"
	    + "<th class='th02' colspan=3 style='background:#FBCAC1'>64</th>"
	    + "<th class='th18' colspan=3 style='background:#FBCAC1'>68</th>"
	    + "<th class='th02' colspan=3 style='background:#CED7B5'>86</th>"
	 + "</tr>"
	 + "<tr class='trHdr01'>"
	 ;
	 
	for(var i=0; i < 8; i++)
	{
		panel += "<th class='th02'>Count</th><th class='th02'>OH</th><th class='th18'>Adj</th>";		 
	}
		 
	panel += "</tr>";
	
	var trdtllcs = "trDtl06"; 
	
	for(var i=0; i < sku.length; i++)
	{		
		panel += "<tr class='" + trdtllcs + "'>" 
		   + "<td class='td44' nowrap>" + sku[i] + "</td>"
		   + "<td class='td44' nowrap>" + qty[i] + "</td>"
		   //[0,4,0,0,0,0,0,0 ,0,4,0,0,0,0,0,0 ,0,1,0,0,0,0,0,0 ,0,2,0,0,0,0,0,0 ,0,2,0,0,0,0,0,0 ]
		   
	   	for(var j=0; j < 8; j++)
	   	{
			panel += "<td class='td12'>" + phy[i][j] + "</td><td class='td12'>" + onh[i][j] + "</td><td class='td44'>" + adj[i][j] + "</td>";		 
		}
		
		if(trdtllcs=="trDtl06"){ trdtllcs = "trDtl04"; }
		else{ trdtllcs = "trDtl06"; }
	}

	panel += "<tr><td colspan=25 align=center><button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
	     + "</table>"
	     
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
            <br>Patio Furniture Open Order Inventory
            <br> Store: <span id="spnStr"></span>
            </b>
            <br>
            
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="PfOpnInvSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02" rowspan=2>Sel<br>Str</th>
          <th class="th02" rowspan=2>Order<br>#</th>
          <th class="th02" rowspan=2 >Order<br>Date</th>          
          <th class="th02" rowspan=2 >Order<br>Status</th>
          <th class="th02" rowspan=2 >Order<br>SO<br>Status</th>
          <th class="th02" rowspan=2 >Delivery<br>Date</th>
          <th class="th02" rowspan=2 >Inv<br>Sold<br>From</th>
          <th class="th02" rowspan=2 >SKU</th>
          <th class="th02" rowspan=2 >Description</th>
          <th class="th02" rowspan=2 >Vendor Style</th>
          <th class="th02" rowspan=2 >Retail</th>
          <th class="th02" rowspan=2 >Qty</th>
          <th class="th02" rowspan=2 >Qty<br>Taken</th>
          <th class="th02" colspan=8 >PI Count Adjustment<br>(blank no Adj)<br>(-/+ Qty = Shrink/Swell)</th>
          <th class="th02" rowspan=2 >OH<br>Alert</th>
        </tr>
        <tr class="trHdr01">
           <th class="th02">35</th>
           <th class="th02">46</th>
           <th class="th02">50</th>
           <th class="th02">55</th>
           <th class="th02">63</th>
           <th class="th02">64</th>
           <th class="th02">68</th>
           <th class="th02">86</th>
        </tr>
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfOrd; i++) {        	   
        	   ordlst.setOrdList();

               String sStr = ordlst.getStr();
               String sOrd = ordlst.getOrd();
               String sSts = ordlst.getSts();
               String sSoSts = ordlst.getSoSts();
               String sOpnDt = ordlst.getOpnDt();
               String sStsNm = ordlst.getStsNm();
               String sSoStsNm = ordlst.getSoStsNm();
               String sDelDt = ordlst.getDelDt();
               int iNumOfItm = ordlst.getNumOfItm();
   			
   			   if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
   			   else {sTrCls = "trDtl06";}   			
           %>                           
           <tr id="trOrd<%=i%>" class="<%=sTrCls%>">
             <td class="td12"><%=sStr%></td>
             <td class="td12"><a href="OrderEntry.jsp?Order=<%=sOrd%>" target="_blank"><%=sOrd%></a></td>
             <td class="td12"><%=sOpnDt%></td>             
             <td class="td11"><%=sStsNm%></td>
             <td class="td11"><%=sSoStsNm%></td>
             <td class="td12"><%if(!sDelDt.equals("01/01/0001")){%><%=sDelDt%><%}%></td>
             <%for(int j=0; j < iNumOfItm; j++)
             {
          	   ordlst.setItemList(j);
          	   String sSku = ordlst.getSku();
          	   String sItmQty = ordlst.getItmQty();
          	   String sRet = ordlst.getRet();
          	   String [] sType = ordlst.getType();
          	   String [] sStrQty = ordlst.getStrQty();
          	   String sDesc = ordlst.getDesc();
          	   String sVenSty = ordlst.getVenSty();
          	   String sQtyTkn = ordlst.getQtyTkn();
          	   String sInvStr = ordlst.getInvStr();
          	   String [] sOnhQty = ordlst.getOnhQty();
          	   String [] sPhyQty = ordlst.getPhyQty();
          	   String [] sAdjQty = ordlst.getAdjQty(); 
          	   String sVenNm = ordlst.getVenNm();  
          	   String sOhAlert = ordlst.getOhAlert();
          	   for(int k=0; k < 8; k++)
          	   {
          		   if(sOnhQty[k].equals("0")){sOnhQty[k]= "";}
          		   if(sPhyQty[k].equals("0")){sPhyQty[k]= "";}
          		   if(sAdjQty[k].equals("0")){sAdjQty[k]= "";}
          	   }
          	 %>
          	   <%if(j > 0){%>
          	      <tr id="trOrd<%=i%>" class="<%=sTrCls%>">
          	      <td class="td12">&nbsp;</td>
          	      <td class="td12">&nbsp;</td>
          	      <td class="td12">&nbsp;</td>
          	      <td class="td12">&nbsp;</td>
          	      <td class="td12">&nbsp;</td>
          	      <td class="td12">&nbsp;</td>
          	   <%}%>
               <td class="td11"><%=sInvStr%></td>
               <td class="td12" id="tdSku<%=i%><%=j%>"><a href="javascript: showPiDtl('<%=sOrd%>','<%=i%>','<%=iNumOfItm%>')"><%=sSku%></a>
                 <span style="display:none;" id="spnSku<%=i%><%=j%>">
                 <%=sSku%>
                 ,<%String br = ""; for(int k=0; k < 8; k++){%><%=br + sOnhQty[k]%><%br=",";%><%}%>
                 ,<%br = ""; for(int k=0; k < 8; k++){%><%=br + sPhyQty[k]%><%br=",";%><%}%>
                 ,<%br = ""; for(int k=0; k < 8; k++){%><%=br + sAdjQty[k]%><%br=",";%><%}%>
                 ,<%br = ""; for(int k=0; k < 8; k++){%><%=br + sStrQty[k]%><%br=",";%><%}%>
                 </span>
               </td>
               <td class="td11" nowrap><%=sDesc%></td>
               <td class="td11" nowrap><%=sVenNm + " / " + sVenSty%></td>
               <td class="td12"><%=sRet%></td>
               <td class="td12" id="tdItm<%=i%>I<%=j%>"><%=sItmQty%></td>
               <td class="td12"><%=sQtyTkn%></td>
               <%for(int k=0; k < 8; k++){%>                    
               		<td class="td12" <%if(sArrStr[k].equals(sSelStr)){%>style="background:lightgreen"<%}%>  
               		id="tdPI<%=i%><%=j%><%=k%>"><%if(!sAdjQty[k].equals("0")){%><%=sAdjQty[k]%><%} else{%>&nbsp;<%}%></td>
               <%}%>
               <td class="td18" <%if(sOhAlert.equals("Y")){%>style="background: pink;"<%} %>><%=sOhAlert%></td>
             <%} %>       
           </tr>
           <%if(i==0 && sSelStr == null || sSelOrd != null && !sSelOrd.trim().equals("")){%>
           <script>SelStr = "<%=sStr%>"; document.all.spnStr.innerHTML = SelStr;</script>
           <%}%>
           
           	<%if(i > 0 && i%5==0){%>
           		<tr class="trHdr01">
          			<th class="th03" rowspan=2>Sel<br>Str</th>
          			<th class="th03" rowspan=2>Order<br>#</th>
          			<th class="th03" rowspan=2 >Order<br>Date</th>          
          			<th class="th03" rowspan=2 >Order<br>Status</th>
          			<th class="th03" rowspan=2 >Order<br>SO<br>Status</th>
          			<th class="th03" rowspan=2 >Delivery<br>Date</th>
          			<th class="th03" rowspan=2 >Inv<br>Sold<br>From</th>
          			<th class="th03" rowspan=2 >SKU</th>
          			<th class="th03" rowspan=2 >Description</th>
          			<th class="th03" rowspan=2 >Vendor Style</th>
          			<th class="th03" rowspan=2 >Retail</th>
          			<th class="th03" rowspan=2 >Qty</th>
          			<th class="th03" rowspan=2 >Qty<br>Taken</th>
          			<th class="th03" colspan=8 >PI Count Adjustment<br>(blank no Adj)<br>(-/+ Qty = Shrink/Swell)</th>
          			<th class="th02" rowspan=2 >OH<br>Alert</th>
        		</tr>
        		<tr class="trHdr01">
           			<th class="th03">35</th>
           			<th class="th03">46</th>
           			<th class="th03">50</th>
           			<th class="th03">55</th>
           			<th class="th03">63</th>
           			<th class="th03">64</th>
           			<th class="th03">68</th>
           			<th class="th03">86</th>
        		</tr>
            <%}%>
           <%}%>
           
           
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
ordlst.disconnect();
ordlst = null;
}
%>