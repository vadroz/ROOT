<%@ page import="mosregister.MosStrSku, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String [] sSelSts = request.getParameterValues("Sts");
   String sReas = request.getParameter("Reas");
   String sSort = request.getParameter("Sort");
   String sType = request.getParameter("Type");
   
   String sWkend = request.getParameter("Wkend");
   String sWkend2 = request.getParameter("Wkend2");
   String sYear = request.getParameter("Year");
   String sMonth = request.getParameter("Month");
   String sDateLvl = request.getParameter("DateLvl");
   
   if(sSort==null || sSort.equals("")){sSort = "Tot"; } 
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MosStrSku.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	 
	MosStrSku ctlinfo = new MosStrSku();
	ctlinfo.setSkuLst(sSelStr, sSelSts, sWkend, sWkend2, sYear, sMonth, sDateLvl
			,  sReas, sType, sSort, sUser);
	
	int iNumOfSku = ctlinfo.getNumOfSku();
	int iNumOfStr = ctlinfo.getNumOfStr();
	
	String sUserAuth = "";
	if(sUser.equals("vrozen") || sUser.equals("psnyder") || sUser.equals("dharris")){sUserAuth = "ALL";}
	else if(sUser.equals("gorozco") || sUser.equals("spaoli") || sUser.equals("kknight")){sUserAuth = "DM";}
	boolean bAllowDlt = !sUserAuth.equals("");
	int [] iStrWidth = new int[iNumOfStr + 1];	
	int [] iColWidth = new int[]{ 3,7,11,12, 11,5,4, 10, 10, 10, 6 };
%> 
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE11" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>MOS Sku By Str Summary</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>

<SCRIPT>

//--------------- Global variables -----------------------
var SelStr = [<%=ctlinfo.cvtToJavaScriptArray(sSelStr)%>];
var SelSts = [<%=ctlinfo.cvtToJavaScriptArray(sSelSts)%>];
var Week1 = "<%=sWkend%>";
var Week2 = "<%=sWkend2%>";
var Year = "<%=sYear%>";
var Month = "<%=sMonth%>";
var DatLvl = "<%=sDateLvl%>";
var Type = "<%=sType%>";

var Reas = "<%=sReas%>"
var Sort = "<%=sSort%>"
var User = "<%=sUser%>";

var NumOfSku = "<%=iNumOfSku%>";
var NumOfStr = "<%=iNumOfStr%>";

 //--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   
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
//set approve flag for Ctl
//==============================================================================
function setApprove(ctl, i, check)
{
	url = "MosCtlSv.jsp?Ctl=" + ctl;
	if(check) { url += "&Approved=Y"; }
	else { url += "&Approved=N"; }
	
	url += "&Action=APPROVED_CTL";
	window.frame1.location.href = url;
	
	var trnm = "trGrp" + i;
	document.all[trnm].style.background = "lightgreen";
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
// drill down to control
//==============================================================================
function drilldown(str)
{
	var url="MosStrSku.jsp?&Wkend=<%=sWkend%>" 
		+ "&Wkend2=<%=sWkend2%>&Year=<%=sYear%>&Month=<%=sMonth%>&DateLvl=<%=sDateLvl%>"
		+ "&Reas=" + Reas;
	
	url += "&Str=" +  str;		
	
	for(var i=0; i < SelSts.length;i++)
	{
		url += "&Sts=" +  SelSts[i];
	}	
	
	window.location.href = url;
}
//==============================================================================
// switch displayed value
//==============================================================================
function switchType(type)
{
	var url="MosStrSku.jsp?&Wkend=<%=sWkend%>" 
		+ "&Wkend2=<%=sWkend2%>&Year=<%=sYear%>&Month=<%=sMonth%>&DateLvl=<%=sDateLvl%>"
		+ "&Reas=" + Reas
		+ "&Type=" + type
	
	for(var i=0; i < SelStr.length;i++)
	{
		url += "&Str=" +  SelStr[i];
	}
	
	for(var i=0; i < SelSts.length;i++)
	{
		url += "&Sts=" +  SelSts[i];
	}	
	
	window.location.href = url;
}
//==============================================================================
// sort by 
//==============================================================================
function sortby(sort)
{
	var url="MosStrSku.jsp?&Wkend=<%=sWkend%>" 
		+ "&Wkend2=<%=sWkend2%>&Year=<%=sYear%>&Month=<%=sMonth%>&DateLvl=<%=sDateLvl%>"
		+ "&Reas=<%=sReas%>"
		+ "&Type=<%=sType%>"
	
	for(var i=0; i < SelStr.length;i++)
	{
		url += "&Str=" +  SelStr[i];
	}
	
	for(var i=0; i < SelSts.length;i++)
	{
		url += "&Sts=" +  SelSts[i];
	}	
	
	url += "&Sort=" + sort;
	
	window.location.href = url;
}
//==============================================================================
//sort by 
//==============================================================================
function showDesc(desc, ven, obj)
{
	var lftpos = 405;
	
	var html = "<table border=0>" 
	  + "<tr>" 
	  	+ "<td style='font-size: 10px; white-space: nowrap; border-right: lightsalmon solid 1px'><b>Desc:</b> " + desc + "&nbsp;</td>"
	  	+ "<td style='font-size: 10px; white-space: nowrap;'><b>Vendor:</b> " + ven + "</td>"
	  + "</table>"
	;
	
	var pos = getObjPosition(obj);
	
	document.all.dvToolTip.style.width = "400px";
	
	document.all.dvToolTip.innerHTML = html;
	document.all.dvToolTip.style.left = pos[0] - lftpos;
	document.all.dvToolTip.style.top = pos[1]; 
	document.all.dvToolTip.style.visibility = "visible";
	
}

</SCRIPT>

<script type='text/javascript'>//<![CDATA[
$(window).load(function(){
 
cloneRow();

$(window).bind("scroll", function() {
    var offsetLeft = $(this).scrollLeft();
	var color = "#e7e7e7";
	var posLeft = 0; 
	if(offsetLeft > 1){ posLeft = offsetLeft-110; }
	else{ posLeft = offsetLeft; }
	
	for(var i=0; i < NumOfSku;i++)
	{
		var desc = "#tdDesc" + i;
		$(desc).css({ left: posLeft, position : "relative", background:color, border: "lightsalmon solid 1px" });
		$(desc).css("z-index", 0);
		
		if(color=="#e7e7e7"){ color = "white";}
	 	else{ color = "#e7e7e7"; }
	} 
	
	
	var offsetTop = $(this).scrollTop();
    if(offsetTop > 150)
    {
    	$("#trHdr01").css({"display": "none"});
    	$("#trHdr02").css({"display": "none"});
    	$("#tblClone").css({"display": "block"});
    	$("#tblClone").css({top: offsetTop, left: 10});
    	$("#tblClone").css('z-index', 100);
    }
    else
    {	
    	$("#trHdr01").css({"display": "table-row"});
    	$("#trHdr02").css({"display": "table-row"});    	
    	$("#tblClone").css({"display": "none"});
    }
}); 
});//]]> 

//==============================================================================
//clone row 
//==============================================================================
function cloneRow() {
  var row1 = document.getElementById("trHdr01");  
  var row2 = document.getElementById("trHdr02");
  var row3 = document.getElementById("trScale");
  var table = document.getElementById("tblClone");  
  var clone1 = row1.cloneNode(true); // copy children too
  var clone2 = row2.cloneNode(true);
  var clone3 = row3.cloneNode(true);
  clone1.id = "trClone01"; // change id or other attributes/contents
  clone2.id = "trClone02";
  clone3.id = "trClone03";
  table.appendChild(clone1); // add new row to end of table
  table.appendChild(clone2); // add new row to end of table
  table.appendChild(clone3); // add new row to end of table
  
  row3.style.visibility="hidden";  
}
</script>

<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<span id="spnTest"></span>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvWait" class="dvItem"></div>
<div id="dvToolTip" class="dvToolTip"></div>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<iframe  id="frame2"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trDtl19" >
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>MOS Store Control Summary List 
            <br>Reason: <%=sReas%>
            <br>By  
                  <%if(sType.equals("U")){%>Unit<%} 
        		  else if(sType.equals("C")){%>Cost<%} 
        		  else if(sType.equals("R")){%>Retail<%}%>
            <br><br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="MosStrCtlSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp; 
              <br>
                <INPUT name="Type" type="radio" onclick="switchType(this.value)" value="U" <%if(sType.equals("U")){%>checked<%}%>>Unit &nbsp; 
                <INPUT name="Type" type="radio" onclick="switchType(this.value)" value="C" <%if(sType.equals("C")){%>checked<%}%>>Cost &nbsp; 
                <INPUT name="Type" type="radio" onclick="switchType(this.value)" value="R" <%if(sType.equals("R")){%>checked<%}%>>Retail &nbsp;                   
          </th>
        </tr>
        </table>
        
        <table id="tblClone" class="tbl01" style="position:absolute; text-align: left" ></table>
            
      <table id="tblData" class="tbl02">
        <thead id="thdData">
        <tr id="trHdr01" class="trHdr01">
            <th class="th02" rowspan=2><a href="javascript: sortby('Div')">Div</a></th>
        	<th class="th02" rowspan=2><a href="javascript: sortby('Sku')">Sku</a></th>        	
        	<th class="th02" rowspan=2><a href="javascript: sortby('Desc')">Description</th>
        	<th class="th02" rowspan=2><a href="javascript: sortby('VenSty')">Vendor Style</a></th>
        	<th class="th02" rowspan=2><a href="javascript: sortby('VenNm')">Vendor Name</a></th>
        	<th class="th02" rowspan=2>Color</th>
        	<th class="th02" rowspan=2>Size</th>
        	<th class="th02" rowspan=2>Last<br>Received</th>
        	<th class="th02" rowspan=2>Last<br>Sold</th>
        	<th class="th02" rowspan=2>Last<br>Markdown</th>
        	<th class="th02" rowspan=2>Chain<br>Onhand</th>
        	<th class="th02" colspan="<%=iNumOfStr%>">Stores</th>
        	<th class="th02" rowspan=2><a href="javascript: sortby('Tot')">Total</a></th>
        </tr>
        <tr  id="trHdr02"  class="trHdr01">        
        	<%for(int j=0; j < iNumOfStr; j++) {%>
           		<th class="th02" style="width: 70px;"><%=sSelStr[j]%></th>
        	<%}%>
        </tr>
        </thead>
        
        <tbody id="tbdData">
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfSku; i++) {        	   
        	   	ctlinfo.setSku();
       			String sSku = ctlinfo.getSku();
       			String sDesc = ctlinfo.getDesc();
       			String sVenSty = ctlinfo.getVenSty();
       			String sVenNm = ctlinfo.getVenNm();
       			String sClrNm = ctlinfo.getClrNm();
       			String sSizNm = ctlinfo.getSizNm();
       			String [] sExtQty = ctlinfo.getExtQty();
       			String [] sExtCost = ctlinfo.getExtCost();
       			String [] sExtRet = ctlinfo.getExtRet();
       			String sTotQty = ctlinfo.getTotQty();
       			String sTotCost = ctlinfo.getTotCost();
       			String sTotRet = ctlinfo.getTotRet();
       			String sDiv = ctlinfo.getDiv();
       			String sLstRctDt = ctlinfo.getLstRctDt();
       			String sLstSoldDt = ctlinfo.getLstSoldDt();
       			String sLstMkdnDt = ctlinfo.getLstMkdnDt();
       			String sChnOnh = ctlinfo.getChnOnh();
       			
   				if(sTrCls.equals("trDtl21")){sTrCls = "trDtl20";}
   				else {sTrCls = "trDtl21";} 
   				
   				for(int j = 0; j < iNumOfStr; j++)
   				{
   					if( sExtQty[j].equals("0")){ sExtQty[j] = "&nbsp;"; }
   					if( sExtCost[j].equals(".00")){sExtCost[j] = "&nbsp;"; }
   					if( sExtRet[j].equals(".00")){sExtRet[j] = "&nbsp;";  }
   				}
   				
   				String [] sAmt = new String[iNumOfStr];
   				for(int j = 0; j < iNumOfStr; j++)
   				{
   					if(sType.equals("U")){sAmt[j] = sExtQty[j]; }
   					else if(sType.equals("C")){sAmt[j] = sExtCost[j]; }
   					else if(sType.equals("R")){sAmt[j] = sExtRet[j]; }
   				}
   				
   				if(iColWidth[0] < sDiv.length()){ iColWidth[0] = sDiv.length(); }
   				if(iColWidth[1] < sSku.length()){ iColWidth[1] = sSku.length(); }
   				if(iColWidth[2] < sDesc.length()){ iColWidth[2] = sDesc.length(); }
   				if(iColWidth[3] < sVenSty.length()){ iColWidth[3] = sVenSty.length(); }
   				if(iColWidth[4] < sVenNm.length()){ iColWidth[4] = sVenNm.length(); }
   				if(iColWidth[5] < sClrNm.length()){ iColWidth[5] = sClrNm.length(); }
   				if(iColWidth[6] < sSizNm.length()){ iColWidth[6] = sSizNm.length(); }
   				if(iColWidth[10] < sChnOnh.length()){ iColWidth[10] = sChnOnh.length(); }
   		   %>                          
           <tr id="trGrp<%=i%>" class="<%=sTrCls%>">
             <td id="tdDiv<%=i%>" class="td12" nowrap><%=sDiv%></td>
             <td id="tdSku<%=i%>" class="td12" nowrap><%=sSku%></td>
             <td id="tdDesc<%=i%>" class="td11" nowrap><%=sDesc%></td>
             <td id="tdVenSty<%=i%>" class="td11" nowrap><%=sVenSty%></td>
             <td id="tdVenNm<%=i%>" class="td11" nowrap><%=sVenNm%></td>
             <td id="tdClrNm<%=i%>" class="td11" nowrap><%=sClrNm%></td>
             <td id="tdSizNm<%=i%>" class="td11" nowrap><%=sSizNm%></td>
             <td id="tdLrd<%=i%>" class="td11" nowrap><%=sLstRctDt%></td>
             <td id="tdLsd<%=i%>" class="td11" nowrap><%=sLstSoldDt%></td>
             <td id="tdLmd<%=i%>" class="td11" nowrap><%=sLstMkdnDt%></td>
             <td id="tdOnh<%=i%>" class="td11" nowrap><%=sChnOnh%></td>
             
             <%for(int j = 0; j < iNumOfStr; j++){%>
        		<td id="tdAmt<%=i%>" class="td12"  
        		    onmouseover="showDesc('<%=sDesc%>', '<%=sVenNm%>', this)">
        		   <%if(!sType.equals("U") && !sAmt[j].equals("&nbsp;")){%>$<%}%><%=sAmt[j]%>
        		</td>
        	 <%}%>
        	 
             <td id="tdTot<%=i%>" class="td12" nowrap>
        		  <%if(sType.equals("U")){%><%=sTotQty%><%} 
        		  else if(sType.equals("C")){%>$<%=sTotCost%><%} 
        		  else if(sType.equals("R")){%>$<%=sTotRet%><%}%>
        	 </td>
           </tr>           
       <%}%>
           
           <tr class="Divider"><td colspan=50>&nbsp;</td></tr>
             
           <!-- ======Total ================ -->
           <%
       	    ctlinfo.setTotal();
       		String [] sExtQty = ctlinfo.getExtQty();
       		String [] sExtCost = ctlinfo.getExtCost();
       		String [] sExtRet = ctlinfo.getExtRet();
       		String sTotQty = ctlinfo.getTotQty();
       		String sTotCost = ctlinfo.getTotCost();
       		String sTotRet = ctlinfo.getTotRet();
       		
       		for(int j = 0; j < iNumOfStr; j++)
			{
				if( sExtQty[j].equals("0")){ sExtQty[j] = "&nbsp;"; }
				if( sExtCost[j].equals(".00")){sExtCost[j] = "&nbsp;"; }
				if( sExtRet[j].equals(".00")){sExtRet[j] = "&nbsp;";  }
			}
			
			String [] sAmt = new String[iNumOfStr];			
			for(int j = 0; j < iNumOfStr; j++)
			{
				if(sType.equals("U")){sAmt[j] = sExtQty[j]; }
				else if(sType.equals("C")){sAmt[j] = sExtCost[j]; }
				else if(sType.equals("R")){sAmt[j] = sExtRet[j]; }
				iStrWidth[j] = sAmt[j].length();
				if(iStrWidth[j] < 5){ iStrWidth[j] = 5;}
			}			  
           %>
           <tr id="trTot" class="trDtl03">
             <td class="td18" nowrap colspan=2><b>Total</b></td>
             <td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             <td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             <td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             <td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             <td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             <td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             <td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             <td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             <td id="tdCtlInfo" class="td12" nowrap>&nbsp;</td>
             
             <%for(int j = 0; j < iNumOfStr; j++){%>
        		<td class="td12" nowrap>
        			<b><%if(!sType.equals("U") && !sAmt[j].equals("&nbsp;")){%>$<%}%><%=sAmt[j]%></b>
        		</td>
        	 <%}%>
        	 
        	 <td class="td12" nowrap><b>
        		  <%if(sType.equals("U")){%><%=sTotQty%><%iStrWidth[iNumOfStr]=sTotQty.length();%><%} 
        		  else if(sType.equals("C")){%>$<%=sTotCost%><%iStrWidth[iNumOfStr]=sTotCost.length();%><%} 
        		  else if(sType.equals("R")){%>$<%=sTotRet%><%iStrWidth[iNumOfStr]=sTotRet.length();%><%}%>
        		  </b>
        	 </td>
           </tr>
         <tr id="trScale" class="trDtl06" style="visibility: hidden;">
           <td class="td12" style="border: none;" nowrap><%for(int k=0; k < iColWidth[ 0]; k++){%>X<%}%></td>
           <td class="td12" style="border: none;" nowrap><%for(int k=0; k < iColWidth[ 1]; k++){%>X<%}%></td>
           <td class="td11" style="border: none;" nowrap><%for(int k=0; k < iColWidth[ 2]; k++){%>X<%}%></td>
           <td class="td11" style="border: none;" nowrap><%for(int k=0; k < iColWidth[ 3]; k++){%>X<%}%></td>
           <td class="td11" style="border: none;" nowrap><%for(int k=0; k < iColWidth[ 4]; k++){%>X<%}%></td>
           <td class="td11" style="border: none;" nowrap><%for(int k=0; k < iColWidth[ 5]; k++){%>X<%}%></td>
           <td class="td11" style="border: none;" nowrap><%for(int k=0; k < iColWidth[ 6]; k++){%>X<%}%></td>
           <td class="td11" style="border: none;" nowrap><%for(int k=0; k < iColWidth[ 7]; k++){%>X<%}%></td>
           <td class="td11" style="border: none;" nowrap><%for(int k=0; k < iColWidth[ 8]; k++){%>X<%}%></td>
           <td class="td11" style="border: none;" nowrap><%for(int k=0; k < iColWidth[ 9]; k++){%>X<%}%></td>
           <td class="td11" style="border: none;" nowrap><%for(int k=0; k < iColWidth[10]; k++){%>X<%}%></td>
           <%for(int j=0; j < iNumOfStr; j++) {%>
           	   <td class="td11" style="border: none;" nowrap><%for(int k=0; k < iStrWidth[j]; k++){%>X<%}%></td>
           <%}%>
           <td class="td11" style="border: none;" nowrap><%for(int k=0; k < iStrWidth[iNumOfStr]; k++){%>X<%}%></td>
       </tr>   
         </tbody> 
         </table>
      <!----------------------- end of table ------------------------>
      
 </body>
</html>
<%
ctlinfo.disconnect();
ctlinfo = null;
}
%>