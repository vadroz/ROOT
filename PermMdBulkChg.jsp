<!DOCTYPE html>
<%@ page import="permmdprice.PermMdBulkChg, java.util.*, java.text.*"%>
<%
   String sBatch = request.getParameter("Batch");
   String sSelDpt = request.getParameter("Dpt");
   String sSelCls = request.getParameter("Cls");
   
   if(sSelDpt == null){ sSelDpt = "ALL"; }
   if(sSelCls == null){ sSelCls = "ALL"; }
    
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PermMdBulkChg.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	 
	PermMdBulkChg prcChg = new PermMdBulkChg(sBatch, sSelDpt, sSelCls, sUser);
	
	String sShortNm = prcChg.getShortNm();
    String sLongNm = prcChg.getLongNm();
    String sSelMdPrc = prcChg.getSelMdPrc();
    String sSelMdCent = prcChg.getSelMdCent();
    String sCurLvl = prcChg.getCurLvl();
    
    int iNumOfGrp = prcChg.getNumOfGrp();
	boolean bAlwSbm = sSelDpt == "ALL" && sSelCls == "ALL";
%>
<html>
<head>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
<script src="XX_Set_Browser.js"></script>
<script src="XX_Get_Visible_Position.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Bulk Perm MD Changes</title>

<SCRIPT>

//--------------- Global variables -----------------------
var Batch = "<%=sBatch%>"
var SelDpt = "<%=sSelDpt%>";
var SelCls = "<%=sSelCls%>";
var CurLvl = "<%=sCurLvl%>";
var User = "<%=sUser%>";

var NumOfGrp = "<%=iNumOfGrp%>";
var SvInpExcl = null 

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
//hide panel
//==============================================================================
function hidePanel()
{
	document.all.dvItem.innerHTML = "";
	document.all.dvItem.style.visibility = "hidden";
}
//==============================================================================
// set new price
//==============================================================================
function setNewPrc()
{
	var hdr = "Apply Changes To All";

	   var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" 
	        + popNewPrcPanel()
	     + "</td></tr>"
	   + "</table>"

	   if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "350";}
	   else { document.all.dvItem.style.width = "auto";}
	   
	   document.all.dvItem.innerHTML = html;
	   document.all.dvItem.style.left = getLeftScreenPos() + 440;
	   document.all.dvItem.style.top = getTopScreenPos() + 115;
	   document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate Entry Panel
//==============================================================================
function popNewPrcPanel()
{
	var prcobj = document.getElementsByName("inpMdPrc")[0];
	var prc = prcobj.value.trim();
	var centobj = document.getElementsByName("inpMdCent")[0];
	var cent = centobj.value.trim();
	
	var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
	   + "<tr class='trHdr01'>"
	  	 + "<th class='th10' nowrap>Percent: &nbsp;</th>"
	  	 + "<td  class='td12' nowrap>" + prc + "%</td>"
	   + "</tr>"
	   + "<tr class='trHdr01'>"
 	  	 + "<th class='th10' nowrap>Price Cent Ending: &nbsp;</th>"
 		 + "<td  class='td12' nowrap>" + cent + " cents</td>"
  	   + "</tr>";
	;	
	
	var error = false;
	var msg = "";
	var br = "";
	if(prc == "" || eval(prc) == 0 ){ error=true; msg="The Percent cannot be 0"; br="<br>";}
	else if( isNaN(prc) ){ error=true; msg="The Percent value is not an error.";  br="<br>";}
	
	if(cent == "" || eval(cent) == 0){ error=true; msg += br + "The Ending Cent cannot be 0";  br="<br>";}
	else if( isNaN(cent) ){ error=true; msg += br + "The Ending Cent value is not an error.";  br="<br>";}
	
	if(error)
	{
		panel += "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
		   + "<tr class='trHdr01'>"
		  	 + "<td  class='tdError' nowrap>Error: </td>"
		  	 + "<td  class='tdError' nowrap>" + msg + "</td>"
		   + "</tr>"
	}
	 
	
	panel += "<tr><td class='td18' colspan=7>";
	if(!error)
	{
		panel += "<button onClick='sbmClcPrcChg(&#34;" + prc + "&#34;,&#34;" + cent + "&#34;);' class='Small'>Calculate</button>"
	}
	panel += " <button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
	panel += "</table>";
	return panel;
}
//==============================================================================
//reset  new price
//==============================================================================
function resetNewPrc()
{
	document.getElementsByName("inpMdPrc")[0].value = "";
	document.getElementsByName("inpMdCent")[0].value = "";	
}
//==============================================================================
// submit calculate price changes
//==============================================================================
function sbmClcPrcChg(percent, cent)
{
	var url = "PermMdGenGroup.jsp?Batch=<%=sBatch%>"
	  + "&MdPrc=" + percent
	  + "&MdCent=" + cent
	  + "&Action=UpdPrcnt"
	;
	
	window.frame1.location.href=url;
}
//==============================================================================
// drill down
//==============================================================================
function drilldown(grp)
{
	var url = "PermMdBulkChg.jsp?Batch=<%=sBatch%>";
	
	url += "&Cls=" + grp; 
		
	window.location.href=url;
}
//==============================================================================
// restart
//==============================================================================
function restart(batch)
{
	window.location.reload();
}

//==============================================================================
//show exist options for selection
//==============================================================================
function setExcOvrAmt(inp, grpprc, cls,ven,sty,clr, type)
{	 
	SvInpExcl = inp;
		
	var excl = "Y";
	var ovr = "SAME";
	var action = "";
	
	if(type=="EXC" && !inp.checked){ excl = "Y"; action = "AddExcl"; }
	else if(type=="EXC" && inp.checked){ excl = "N";  action = "DltExcl"; }
	else if(type=="OVR" && inp.value.trim() != "" )
	{ 
		ovr = inp.value.trim(); action = "AddOvrPrice";
		inp.value = grpprc;
		inp.style.backgroundColor = "yellow"; 
	}
	else if(type=="OVR" && inp.value.trim() == "" )
	{ 
		ovr = inp.value.trim(); action = "DltOvrPrice";
		inp.value = grpprc;
		inp.style.backgroundColor = "white"; 
	}
	
	 
	
	sbmExcOvrAmt(cls,ven,sty,clr, excl, ovr, action)
}
//==============================================================================
//show exist options for selection
//==============================================================================
function sbmExcOvrAmt(cls,ven,sty,clr, excl, ovr, action)
{	 
		var url = "PermMdGenGroup.jsp?Batch=" + Batch
		+ "&Cls=" + cls
		+ "&Ven=" + ven
		+ "&Sty=" + sty
		+ "&Clr=" + clr
		+ "&Exclude=" + excl
		+ "&Amt=" + ovr
		+ "&Action=" + action
	;
	window.frame1.location.href = url;
}
//==============================================================================
// mark excluded/included item 
//==============================================================================
function markExcl(Batch, cls,ven,sty,clr,exclude)
{
	var color = "pink";
	if(exclude == "N"){ color = "green"; }
	SvInpExcl.style.backgroundColor = color;
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
// submit Price Change Session
//==============================================================================
function sbmPrcSsn()
{
	var url = "PermMdGenGroup.jsp?Batch=" + Batch
	  + "&Action=SbmPrcSsn"
	;
	window.frame1.location.href = url;
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
<div id="dvHelp" class="dvHelp"><a href="Intranet Reference Documents/2.0 MOS Approval Recap.pdf" class="helpLink" target="_blank">&nbsp;</a></div>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<iframe  id="frame2"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trDtl19">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Bulk Permanent Item Price Markdown                 
            <br>Item Group <%=sShortNm%> &nbsp; Long Name <%=sLongNm%> 
            <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
                <a href="PermMdBulkChgSel.jsp"><font color="red" size="-1">Selection</font>
                &#62;<font size="-1">This Page</font>
                           
          </th>
        </tr>
        <tr>
          <td>
            Chg: <input class="Small" name="inpMdPrc" size="10" maxlength="11" value="<%=sSelMdPrc%>">% 
        	  &nbsp; &nbsp; 
        	  Cents: <input class="Small" name="inpMdCent" size="2" maxlength="3" value="<%=sSelMdCent%>">        	  
        	  <br><button class="Small" onclick="setNewPrc()">Calc</button>&nbsp; &nbsp;
        	  <button class="Small" onclick="resetNewPrc()">Reset</button>
        	  <%if(bAlwSbm){%>
        	     &nbsp; &nbsp;
        	     <button class="Small" onclick="sbmPrcSsn()">Submit SSN</button>
        	  <%}%>
        <br>	    
      <table class="tbl02">
        <tr class="trHdr01">
            <%if(sCurLvl.equals("CLR")){%>
               <th class="th02" rowspan=2>Include</th>
               <th class="th02" rowspan=2>Item</th>
               <th class="th02" rowspan=2>Description</th>
               <th class="th02" rowspan=2>Color<br>Name </th>
            <%} else {%>
        	<th class="th02" rowspan=2>Department</th>
        	<th class="th02" rowspan=2>Class</th>
        	<%}%>
        	<th class="th02" colspan=<%if(sCurLvl.equals("CLR")){%>6<%} else {%>5<%}%>>Summary of Current Inventory</th>
        	<th class="th02" colspan=<%if(sCurLvl.equals("CLR")){%>4<%} else {%>3<%}%>>Calculated Inventory Summary </th>
        	<th class="th02" rowspan=2>Clc MD %</th>
        	<th class="th02" rowspan=2>Var<br>Ret</th>
        	<th class="th02" rowspan=2>Var<br>GM</th>
        	<%if(sCurLvl.equals("CLR")){%>
        		<th class="th02" rowspan=2>Orig<br>Ret</th>
        		<th class="th02" rowspan=2>Suggest<br>Ret</th>
        		<th class="th02" colspan=6>Prior Markdowns</th>
        		<th class="th02" rowspan=2>On hands<br>At Ret</th>
        		<th class="th02" rowspan=2>On hands<br>At Cost</th>
        		<th class="th02" rowspan=2>Last Recv<br>Date</th>
        		<th class="th02" rowspan=2>Last Sale<br>Date</th>
        		<th class="th02" rowspan=2>Beg Inv<br>(Season)</th>
        		<th class="th02" rowspan=2>Std Sls<br>in Units</th>
        		<th class="th02" rowspan=2>Std Purch<br>in Units</th>
        		<th class="th02" rowspan=2>Open PO<br>Qty</th>
        		<th class="th02" rowspan=2 nowrap>Sell-Off</th>
        	<%}%>
        </tr>
        <tr class="trHdr01">
        	<th class="th02">Qty</th>        	
        	<th class="th02">Extended<br>Cost</th>
        	<th class="th02" nowrap>Extended<br>Retail</th> 
        	<th class="th02">GM$</th>
        	<th class="th02">GM%</th>
        	<%if(sCurLvl.equals("CLR")){%>
        	<th class="th02">Retail</th>
        	<%}%>
        	<th class="th02">New(Calculated)<br>Extended<br>Retail</th>
        	<th class="th02">New<br>GM$</th>
        	<th class="th02">New<br>GM%</th>
        	<%if(sCurLvl.equals("CLR")){%>
        	   <th class="th02">New<br>Retail</th>
        	   <th class="th02">Amt</th>
        	   <th class="th02">Date</th>
        	   <th class="th02">Amt</th>
        	   <th class="th02">Date</th>
        	   <th class="th02">Amt</th>
        	   <th class="th02">Date</th>
        	<%}%>
        </tr>
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl04"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfGrp; i++) 
           {
        	   prcChg.setGrp();
        	   String sDiv   = prcChg.getDiv();
           	   String sDpt   = prcChg.getDpt();
           	   String sCls   = prcChg.getCls();
           	   String sVen   = prcChg.getVen();
        	   String sSty   = prcChg.getSty();
        	   String sClr   = prcChg.getClr();
           	   String sClsNm = prcChg.getClsNm();
               String sDptNm = prcChg.getDptNm();
           	   String sQty   = prcChg.getQty();
           	   String sRet   = prcChg.getRet();
           	   String sCost  = prcChg.getCost();
           	   String sGm   = prcChg.getGm();
           	   String sNewRet   = prcChg.getNewRet();
               String sNewGm   = prcChg.getNewGm();
           	   String sMdPrc   = prcChg.getMdPrc();
           	   String sLevel   = prcChg.getLevel();
           	   String sGmPrc   = prcChg.getGmPrc();
        	   String sNewGmPrc = prcChg.getNewGmPrc();
        	   String sVarRet = prcChg.getVarRet();
        	   String sVarGm = prcChg.getVarGm();
        	   String sSngRet   = prcChg.getSngRet();
        	   String sNewSngRet   = prcChg.getNewSngRet();
        	   
        	   String sOrgRet   = prcChg.getOrgRet();
           	   String sSugRet   = prcChg.getSugRet();
           	   String sPri1MdAmt   = prcChg.getPri1MdAmt();
           	   String sPri1MdDt   = prcChg.getPri1MdDt();
           	   String sPri2MdAmt   = prcChg.getPri2MdAmt();
               String sPri2MdDt   = prcChg.getPri2MdDt();
           	   String sPri3MdAmt   = prcChg.getPri3MdAmt();
           	   String sPri3MdDt   = prcChg.getPri3MdDt();
           	   String sOnhAtRet   = prcChg.getOnhAtRet();
           	   String sOnhAtCost   = prcChg.getOnhAtCost();
           	   String sLstRcvDt   = prcChg.getLstRcvDt();
           	   String sLstSlsDt   = prcChg.getLstSlsDt(); 
               String sBegInv = prcChg.getBegInv();
           	   String sSlsUnit = prcChg.getSlsUnit();
           	   String sPurchUnit = prcChg.getPurchUnit();
           	   String sPoQty = prcChg.getPoQty();
           	   String sSellOff = prcChg.getSellOff();
           	   String sExcl = prcChg.getExcl();
        	   String sOvrAmt = prcChg.getOvrAmt();
        	   
        	   String sChkIncl = "checked";
        	   if(sExcl.equals("Y")){ sChkIncl = "";}
        	   
        	   String sOvrVal = sOvrAmt;
        	   String sOvrClr = "style=\"background: yellow;\"";
        	   if(sOvrAmt.equals(".00"))
        	   { 
        		   sOvrVal = sNewSngRet;
        		   sOvrClr = "";
        	   }
           %>                       
           <tr class="<%=sTrCls%>" id="trGrp<%=i%>">
             <%if(!sCurLvl.equals("CLR")){%>
             	<td class="td11" nowrap <%if(sLevel.equals("P")){%>colspan=2<%}%>>
             		<%if(sLevel.equals("P")){%><%=sDpt%> - <%=sDptNm%><%} else{%>&nbsp;<%}%>
             	</td>
             	<%if(sLevel.equals("C")){%>
                	<td class="td11" nowrap>
               			<a href="javascript: drilldown('<%=sCls%>')"><%=sCls%> - <%=sClsNm%></a>
             		</td>
             	<%}%>
             <%} else {%>
                 <td class="td18" nowrap>
                    <input type="checkbox" name="inpIncl" id="inpIncl<%=i%>" 
                      onclick="setExcOvrAmt(this,'','<%=sCls%>', '<%=sVen%>', '<%=sSty%>', '<%=sClr%>','EXC')" <%=sChkIncl%>>
                 </td>
                 <td class="td11" nowrap><%=sCls%>-<%=sVen%>-<%=sSty%>-<%=sClr%></td>
                 <td class="td11" nowrap><%=sClsNm%></td>
                 <td class="td11" nowrap><%=sDptNm%></td>
             <%}%>
             <td class="td12" nowrap><%=sQty%></td>
             <td class="td12" nowrap>$<%=sCost%></td>
             <td class="td12" nowrap>$<%=sRet%></td>
             <td class="td12" nowrap>$<%=sGm%></td>
             <td class="td12" nowrap><%=sGmPrc%>%</td>
             <%if(sCurLvl.equals("CLR")){%>
             	<td class="td12" nowrap>$<%=sSngRet%></td>
             <%}%>
             <td class="td12" nowrap>$<%=sNewRet%></td>
             <td class="td12" nowrap>$<%=sNewGm%></td>
             <td class="td12" nowrap><%=sNewGmPrc%>%</td>
             <%if(sCurLvl.equals("CLR")){%>
             	<td class="td12" nowrap> 
             	    $<input class="Small" <%=sOvrClr%>
             	       value="<%=sOvrVal%>" 
             	       name="inpOvrAmt" id="inpOvrAmt<%=i%>"
             	       onkeypress="if (window.event.keyCode == 13) {setExcOvrAmt(this,'<%=sNewSngRet%>' 
             	           ,'<%=sCls%>', '<%=sVen%>', '<%=sSty%>', '<%=sClr%>','OVR')}"
             	       size="10" maxlength="10">
             	</td>
             <%}%>
             <td class="td12" nowrap><%=sMdPrc%>%</td> 
             <td class="td12" nowrap>$<%=sVarRet%></td>
             <td class="td12" nowrap>$<%=sVarGm%></td>
             
             <%if(sCurLvl.equals("CLR")){%>
             	<td class="td12" nowrap>$<%=sOrgRet%></td>
             	<td class="td12" nowrap>$<%=sSugRet%></td>
             	<td class="td12" nowrap><%if(!sPri1MdAmt.equals(".00")){%>$<%=sPri1MdAmt%><%}%></td>
             	<td class="td12" nowrap><%if(!sPri1MdAmt.equals(".00")){%><%=sPri1MdDt%><%}%></td>
             	<td class="td12" nowrap><%if(!sPri2MdAmt.equals(".00")){%>$<%=sPri2MdAmt%><%}%></td>
             	<td class="td12" nowrap><%if(!sPri2MdAmt.equals(".00")){%><%=sPri2MdDt%><%}%></td>
             	<td class="td12" nowrap><%if(!sPri3MdAmt.equals(".00")){%>$<%=sPri3MdAmt%><%}%></td>
             	<td class="td12" nowrap><%if(!sPri3MdAmt.equals(".00")){%><%=sPri3MdDt%><%}%></td>
             	<td class="td12" nowrap>$<%=sOnhAtRet%></td>
             	<td class="td12" nowrap>$<%=sOnhAtCost%></td>
             	<td class="td12" nowrap><%=sLstRcvDt%></td>
             	<td class="td12" nowrap><%=sLstSlsDt%></td>
             	<td class="td12" nowrap><%=sBegInv%></td>
             	<td class="td12" nowrap><%=sSlsUnit%></td>
             	<td class="td12" nowrap><%=sPurchUnit%></td>
             	<td class="td12" nowrap><%=sPoQty%></td>
             	<td class="td12" nowrap><%=sSellOff%></td>
             <%}%>
           </tr>
           <%
           		if(sLevel.equals("P") && sTrCls.equals("trDtl04")){sTrCls = "trDtl06";}
				else if(sLevel.equals("P") && sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
             }
           %>
           <!-- ============================totals ========================== -->
           <%
           	prcChg.setTotals();
       	
       		String sDptNm = prcChg.getDptNm();
       		String sQty   = prcChg.getQty();
       		String sRet   = prcChg.getRet();
       		String sCost  = prcChg.getCost();
       		String sGm   = prcChg.getGm();
       		String sNewRet   = prcChg.getNewRet();
       		String sNewGm   = prcChg.getNewGm();
       		String sMdPrc   = prcChg.getMdPrc();
       		String sGmPrc   = prcChg.getGmPrc();
     	    String sNewGmPrc = prcChg.getNewGmPrc();
     	    String sVarRet = prcChg.getVarRet();
     	    String sVarGm = prcChg.getVarGm();
     	    
     	    String sSlsUnit = prcChg.getSlsUnit();
       	    String sPurchUnit = prcChg.getPurchUnit();
       	    String sPoQty = prcChg.getPoQty();
       	    String sSellOff = prcChg.getSellOff();
       	   
     	    String sColSpan = "2";
     	    if(sCurLvl.equals("CLR")){ sColSpan = "4"; }
           %> 
           
                 
             <tr class="trDtl12" id="trTotal">
             <td class="td11" colspan="<%=sColSpan%>" nowrap>Total</td>
             <td class="td12" nowrap><%=sQty%></td>
             <td class="td12" nowrap>$<%=sCost%></td>
             <td class="td12" nowrap>$<%=sRet%></td>
             <td class="td12" nowrap>$<%=sGm%></td>
             <td class="td12" nowrap><%=sGmPrc%>%</td>
             <%if(sCurLvl.equals("CLR")){%>
             	<td class="td12" nowrap>&nbsp;</td>
             <%}%>
             <td class="td12" nowrap>$<%=sNewRet%></td>
             <td class="td12" nowrap>$<%=sNewGm%></td>
             <td class="td12" nowrap><%=sNewGmPrc%>%</td>
             <%if(sCurLvl.equals("CLR")){%>
             	<td class="td12" nowrap>&nbsp;</td>
             <%}%>
             <td class="td12" nowrap><%=sMdPrc%>%</td> 
             <td class="td12" nowrap>$<%=sVarRet%></td>
             <td class="td12" nowrap>$<%=sVarGm%></td>
             
             <%if(sCurLvl.equals("CLR")){%>
                <td class="td12" nowrap colspan=13>&nbsp;</td>
             	<td class="td12" nowrap><%=sSlsUnit%></td>
             	<td class="td12" nowrap><%=sPurchUnit%></td>
             	<td class="td12" nowrap><%=sPoQty%></td>
             	<td class="td12" nowrap><%=sSellOff%></td>
             <%} %>	
           </tr>
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
prcChg.disconnect();
prcChg = null;
}
%>