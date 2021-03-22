<%@ page import="mozu_com.MozuCnlSum, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String sSelStr = request.getParameter("Store");
   String sSelDiv = request.getParameter("Div");
   String sSelDivNm = request.getParameter("DivNm");
   String sSelDpt = request.getParameter("Dpt");   
   String sSelDptNm = request.getParameter("DptNm");
   String sSelCls = request.getParameter("Cls");
   String sSelClsNm = request.getParameter("ClsNm");
   String sFrom = request.getParameter("FromDt");   
   String sTo = request.getParameter("ToDt");
   String sSts = request.getParameter("Sts");
   String sLevel = request.getParameter("Level");
   String sSort = request.getParameter("Sort");
   
   if(sSelStr == null){ sSelStr = "ALL"; }
   if(sSelDiv == null){ sSelDiv = "ALL"; }
   if(sSelDpt == null){ sSelDpt = "ALL"; }
   if(sSelCls == null){ sSelCls = "ALL"; }
   
   if(sSelDivNm == null){ sSelDivNm = ""; }
   if(sSelDptNm == null){ sSelDptNm = ""; }
   if(sSelClsNm == null){ sSelClsNm = ""; }
   
   if(sLevel == null){ sLevel = "S"; }
   if(sSort == null){ sSort = "Sort"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=MozuCnlSum.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	 
	MozuCnlSum cnlsum = new MozuCnlSum();
	cnlsum.setAttrByCls(sSts, sSelStr, sSelDiv, sSelDpt, sSelCls, sFrom, sTo
			, sLevel, sSort, sUser);
	int iNumOfGrp = cnlsum.getNumOfGrp();
	
	String sGrpHdr = "Store";
	String sGrpNmHdr = "Store<br>Name";	 
	if(sLevel.equals("D"))
	{
		if(!sSelCls.equals("ALL")){ sGrpHdr = "SKU"; sGrpNmHdr = "Item<br>Description"; }
		else if(!sSelDpt.equals("ALL")){ sGrpHdr = "Class"; sGrpNmHdr = "Class<br>Name"; }
		else if(!sSelDiv.equals("ALL")){ sGrpHdr = "Department"; sGrpNmHdr = "Department<br>Name"; }		
		else if(sSelDiv.equals("ALL")){sGrpHdr = "Division"; sGrpNmHdr = "Division<br>Name"; }	
	}	
	String sALinkTxt = "By Str";
	if(sLevel.equals("S")){ sALinkTxt = "By Div"; }
	
	boolean bTop = sSelDiv.equals("ALL") && sSelDpt.equals("ALL") && sSelCls.equals("ALL")
			&& sSelStr.equals("ALL");
	
	
	boolean bReverse = false;
	if(sLevel.equals("S") ){ bReverse = true; }
	
	StoreSelect strlst = null;
	if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
    {
      strlst = new StoreSelect(20);
    }
    else if (sStrAllowed != null && sStrAllowed.trim().equals("70"))
    {
      strlst = new StoreSelect(21);
    }
    else
    {
      Vector vStr = (Vector) session.getAttribute("STRLST");
      String [] sStrAlwLst = new String[ vStr.size()];
      Iterator iter = vStr.iterator();

      int iStrAlwLst = 0;
      while (iter.hasNext()){ sStrAlwLst[iStrAlwLst] = (String) iter.next(); iStrAlwLst++; }

      if (vStr.size() > 1) { strlst = new StoreSelect(sStrAlwLst); }
      else strlst = new StoreSelect(new String[]{sStrAllowed});
   }

   String sStrJsa = strlst.getStrNum();
   String sStrNameJsa = strlst.getStrName();
   
   String [] sStsLst = new String[]{"Assigned","Printed","Picked","Problem","Resolve","Shipped"
		   ,"Cannot Fill","Sold Out","Cancelled","Error"};
   String [] sErrCode = new String[]{"WPS","DMG","SOP","DEF","TAG","EXT","OTHER"};
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Mozu Status Summary</title>

<SCRIPT>

//--------------- Global variables -----------------------
var SelStr = "<%=sSelStr%>";
var SelDiv = "<%=sSelDiv%>";
var SelDpt = "<%=sSelDpt%>";
var SelCls = "<%=sSelCls%>";
var SelDivNm = "<%=sSelDivNm%>";
var SelDptNm = "<%=sSelDptNm%>";
var SelClsNm = "<%=sSelClsNm%>";
var Sts = "<%=sSts%>";
var FromDt = "<%=sFrom%>";
var ToDt = "<%=sTo%>";
var Level = "<%=sLevel%>"
var Sort = "<%=sSort%>"
var User = "<%=sUser%>";
var NumOfGrp = "<%=iNumOfGrp%>";
var ArrStr = [<%=sStrJsa%>];

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
//==============================================================================
// drill down and/or reverse by store or inventory
//==============================================================================
function drilldown(arg, down,reverse)
{
	var url = "MozuCnlSum.jsp?Sts=" + Sts + "&FromDt=" + FromDt + "&ToDt=" + ToDt + "&Sort=" + Sort;
	var lvl = Level;
	
	// reverse report grouping from store to inventory and vise versa
	if(reverse)
	{
	   if(lvl=="S"){ lvl="D";}
	   else{ lvl="S"; }	   
	}	
	url += "&Level=" + lvl;

	// drill down
	var grp = null;
	var grpnm = null;
	
	if(arg >= 0){ grp = $("#alink" + arg).html();	grpnm = $("#trGrpNm" + arg).html(); }
	
	if(down && !reverse)
	{	
	   var grplvl = setCurGrpLvl();
	   if(grplvl == "DIV"){ url += "&Div=" + grp + "&DivNm=" + grpnm + "&Store=" + SelStr; }
	   else if(grplvl == "DEPT"){ url += "&Div=" + SelDiv + "&DivNm=" + SelDivNm 
		   + "&Dpt=" + grp + "&DptNm=" + grpnm; }
	   else if(grplvl == "CLASS"){ url += "&Div=" + SelDiv + "&DivNm=" + SelDivNm 
		   + "&Dpt=" + SelDpt + "&DptNm=" + SelDptNm + "&Cls=" + grp + "&ClsNm=" + grpnm; }
	}
	else{ url += "&Div=" + SelDiv + "&DivNm=" + SelDivNm + "&Dpt=" + SelDpt + "&DptNm=" + SelDptNm 
		       + "&Cls=" + SelCls + "&ClsNm=" + SelClsNm; }
	
	if(reverse && Level == "S" && down){ url += "&Store=" + grp; }
	else { url += "&Store=" + SelStr; }
	
	window.location.href = url;
}
//==============================================================================
// find current grp level 
//==============================================================================
function setCurGrpLvl()
{
	var grplvl = "DIV";
	if(SelCls != "ALL"){ grplvl = "ITEM"; }
	else if(SelDpt != "ALL"){ grplvl = "CLASS"; }
	else if(SelDiv != "ALL"){ grplvl = "DEPT"; }	
	
	return grplvl;
}

//==============================================================================
//submit report with new status
//==============================================================================
function sbmNewSts(sts)
{
	var url = "MozuCnlSum.jsp?Sts=" + sts.value + "&FromDt=" + FromDt + "&ToDt=" + ToDt 
	  + "&Sort=" + Sort + "&Level=" + Level
	  + "&Div=" + SelDiv + "&DivNm=" + SelDivNm + "&Dpt=" + SelDpt + "&DptNm=" + SelDptNm 
      + "&Cls=" + SelCls + "&ClsNm=" + SelClsNm + "&Store=" + SelStr
     ;

	window.location.href = url;
}

 
//==============================================================================
// go to Store fullfilment tool by sku
//==============================================================================
function gotoStrFflTool_BySku(arg)
{
	var url = "MozuSrlAsg.jsp?StsFrDate=" + FromDt + "&StsToDate=" + ToDt;
			
	var grp = $("#tdGrp" + arg).html();
	url += "&Sku=" + grp + "&Sts=Cannot Fill";
	
	var istr = 0;
	if(ArrStr.length > 1){ istr = 1; }
	for(var i=istr; i < ArrStr.length; i++){ url += "&Str=" + ArrStr[i]; }
	window.location.href = url;
}
//==============================================================================
//get Order for selected date and status
//==============================================================================
function getOrdLst(arg)
{
	str = $("#alink" + arg).html();
	
	var url = "MozuStatusOrdLst.jsp?Str=" + str
 		+ "&From=" + FromDt
 		+ "&To=" + ToDt
 		+ "&Sts=" + Sts 
 		+ "&Action=ByStatusDate";
	;
	window.frame1.location.href = url;
}
//==============================================================================
//show Order for selected date and status
//==============================================================================
function setOrdLst(str, from, to, site, ord, sku, asgdt, orddt, desc, cls, ven, sty, vennm, ret
		, ordsts, fflsts, paysts, oldpar) 
{
	var hdr = "Str: " + str + " " + from + " " + to;
	  var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvOrd&#34;);' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popOrdLst(str, from, to, site, ord, sku, asgdt, orddt
	    		, desc, cls, ven, sty, vennm, ret, ordsts, fflsts, paysts, oldpar)
	     + "</td></tr>"
	   + "</table>"

	  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvOrd.style.width = "400";}
	  else { document.all.dvItem.style.width = "auto";}
	   
	  document.all.dvOrd.innerHTML = html;
	  document.all.dvOrd.style.left=getLeftScreenPos() + 230;
	  document.all.dvOrd.style.top=getTopScreenPos() + 100;
	  document.all.dvOrd.style.zIndex = "50";
	  document.all.dvOrd.style.visibility = "visible";	   
}
//==============================================================================
//populate order list for selected status
//==============================================================================
function popOrdLst(str, from, to, site, ord, sku, asgdt, orddt, desc, cls, ven, sty, vennm, ret
		, ordsts, fflsts, paysts, oldpar)
{
	var panel = "<table class='tbl02'>";
	panel += "<tr class='trHdr01'>"
    + "<th class='th01'>Order</th>"
    + "<th class='th01'>Order<br>Date</th>"
    + "<th class='th01'>Assigned<br>Date</th>"
    + "<th class='th01' nowrap >Parent<br><span style='font-size: 10px;'>(Link to KIBO)</span></th>"
    + "<th class='th01'>SKU</th>"
    + "<th class='th01'>Description</th>"
    + "<th class='th01'>Vendor</th>"
    + "<th class='th01'>Ret</th>"
    + "<th class='th01'>Order<br>Status</th>"
    + "<th class='th01'>Fulfilled<br>Status</th>"
    + "<th class='th01'>Pay<br>Status</th>"
    + "<th class='th01'>L<br>o<br>g</th>"
    + "</tr>"
 ;
		
	for(var i=0; i < ord.length;i++)
	{
		var parent = setParent(cls[i], ven[i], sty[i], oldpar[i]);
		
	    panel += "<tr class='trDtl01'>"
	      + "<td nowrap class='td11'>" + ord[i] + "</td>"
	      + "<td nowrap class='td11'>" + orddt[i] + "</td>"
	      + "<td nowrap class='td11'>" + asgdt[i] + "</td>"
	      + "<td nowrap class='td11'><a href='https://www.sunandski.com/p/" 
	        + parent + "' target='_blank'>"
	      	+ cls[i] + ven[i] + sty[i] 
	      + "</a></td>"
	      + "<td nowrap class='td11'>" + sku[i] + "</td>"
	      + "<td nowrap class='td11'>" + desc[i] + "</td>"
	      + "<td nowrap class='td11'>" + vennm[i] + "</td>"
	      + "<td nowrap class='td11'>" + ret[i] + "</td>"
	      + "<td nowrap class='td11'>" + ordsts[i] + "</td>"
	      + "<td nowrap class='td11'>" + fflsts[i] + "</td>"
	      + "<td nowrap class='td11'>" + paysts[i] + "</td>"
	      + "<td nowrap class='td11'>" 
	         + "<a href='javascript: getStrCommt(&#34;" + str + "&#34;,&#34;" + site[i] + "&#34;, &#34;" + ord[i] 
	            + "&#34;,&#34;" + sku[i] + "&#34;) '>L</a>" 
	      + "</td>"
	      
	      + "</tr>";
 }
	
	panel += "<tr class='trDtl03'>"
	   + "<td nowrap class='td18' colspan=10>"
	   + "<button onClick='hidePanel(&#34;dvOrd&#34;);' class='Small'>Cancel</button>"
	   + "</td></tr>"
	
	return panel;
}
//==============================================================================
//set parent for KIBO
//==============================================================================
function setParent(cls, ven, sty, oldpar)
{
	var parent = cls + ven + sty;
	if(oldpar == "Y")
	{
		parent = cls + ven.substring(1) + sty.substring(3);
	}
	
	return parent;
}
//==============================================================================
//retreive comment for selected store
//==============================================================================
function getStrCommt(str, site, ord, sku)
{
	url = "MozuSrlAsgCommt.jsp?"
	 + "Site=" + site
	 + "&Order=" + ord
	 + "&Sku=" + sku
	 + "&Str=" + str
	 + "&Action=GETSTRCMMT"
	 ;

if(isIE){ window.frame1.location.href = url; }
else if(isChrome || isEdge) { window.frame1.src = url; }
else if(isSafari){ window.frame1.location.href = url; }
}

//==============================================================================
//display comment for selected store
//==============================================================================
function showComments(site, order, sku, serial, str, type, emp, commt, recusr, recdt, rectm)
{
	var hdr = "Logging Information. Order:" + order ;
	var html = "<table class='tbl01'> "
		+ "<tr>"
 + "<td class='BoxName' nowrap>" + hdr + "</td>"
 + "<td class='BoxClose' valign=top>"
   +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel(&#34;dvItem&#34;);' alt='Close'>"
 + "</td></tr>"
+ "<tr><td class='Prompt' colspan=2>" + popLog(type,emp, commt, recusr, recdt, rectm, str, serial)
+ "</td></tr>"
+ "</table>"

if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "550";}
else { document.all.dvItem.style.width = "auto";} 

document.all.dvItem.innerHTML = html;
document.all.dvItem.style.left = getLeftScreenPos() + 100;
document.all.dvItem.style.top = getTopScreenPos() + 140;
document.all.dvItem.style.zIndex = "100"; 
document.all.dvItem.style.visibility = "visible";

}
//==============================================================================
//populate log andcomments panel
//==============================================================================
function popLog(type,emp, commt, recusr, recdt, rectm, str, serial)
{
	var panel = "<table class='tbl02'> "
	+ "<tr  class='trHdr01'>"
 	+ "<th class='th01'>Type</th>"
 	+ "<th class='th01'>S/N</th>"
 	+ "<th class='th01'>Store</th>"
 	+ "<th  class='th01' nowrap>Emp #</th>"
 	+ "<th class='th01'>Comment</th>"
 	+ "<th class='th01'>Recorded by</th>"
	+ "</tr>"

	for(var i=0; i < commt.length; i++)
	{
		panel += "<tr class='trDtl01'>"
  		+ "<td class='td11' nowrap>" + type[i] + "</td>"
  		+ "<td class='td11' nowrap>" + serial[i] + "</td>"
		if(str[i] != "0") { panel += "<td  class='td11' nowrap>" + str[i] + "&nbsp;</td>" }
		else{ panel += "<td  class='td11' nowrap>H.O.&nbsp;</td>" }

		panel += "<td  class='DataTable' nowrap>&nbsp;" + emp[i] + "</td>"
  		+ "<td class='td11'>" + commt[i] + "</td>"
  		+ "<td class='td11' nowrap>" + recusr[i] + " " + recdt[i] + " " + rectm[i] + "</td>"
	}

	panel += "</table>"
	+ "<p style='text-align:center;'>" 
	+ "<button onClick='hidePanel(&#34;dvItem&#34;);' class='Small'>Close</button>&nbsp;"


	return panel;
}

//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel(div)
{
	var obj = document.all[div];
	obj.innerHTML = " ";
	obj.style.visibility = "hidden";	
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
            <br>Mozu Summary for Selected Status 
            <br> Store: <%=sSelStr%>
            <br> Divison: <%=sSelDiv%>
            <%if(!sSelDpt.equals("ALL")){%>, Department: <%=sSelDpt%><%}%>
            <%if(!sSelCls.equals("ALL")){%>, Class: <%=sSelDpt%><%}%>
            <br>Status: <%=sSts%>            
            </b>
            <br>
            <div style="font-size:11px;">
            <%for(int i=0; i < sStsLst.length ; i++){%>
                <input class="Small" name="Sts" type="radio" value="<%=sStsLst[i]%>" 
                  onclick="sbmNewSts(this)" <%if(sStsLst[i].equals(sSts)){%>checked<%}%>><%=sStsLst[i]%> &nbsp;
            <%}%>
            </div>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="MozuCnlSumSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;     
              <%if(sSts.equals("Error") && sSelStr.equals("ALL")){%><a href="MozuCnlSumToExcel.jsp?&FromDt=<%=sFrom%>&ToDt=<%=sTo%>" target="_blank">To Excel</a><%}%>       
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02" rowspan=3><%=sGrpHdr%><br><a href="javascript: drilldown(-1, false,true)"><%=sALinkTxt %></a> 
          </th>
          <th class="th02" rowspan=3 ><%=sGrpNmHdr%></th>
          <th class="th02" rowspan=3 >Item Qty</th>
          <th class="th02" rowspan=3 >Item Retail</th>
          <%if(sSts.equals("Cannot Fill") || sSts.equals("Sold Out")){%>
            <th class="th02" rowspan=3 >&nbsp;</th>     
          	<th class="th02" colspan=11>Cannot Fill By Type</th>          	
          <%}
          else if(sSts.equals("Error")) {%>
          	<th class="th02" rowspan=3 >&nbsp;</th>     
          	<th class="th02" colspan=23>Error By Type</th>
          <%}%>
           
          <%if(sGrpHdr.equals("SKU")){%>
                <th class="th02" rowspan=3 >Str<br>FFL</th>
                <th class="th02" rowspan=3 >Long Item Number</th>
          		<th class="th02" rowspan=3 >Vendor<br>Name</th>
          		<th class="th02" rowspan=3 >Color</th>
          		<th class="th02" rowspan=3 >Size</th>
          <%}%>         
          
          <%if(sSts.equals("Shipped") && sGrpHdr.equals("Store") && bTop) {%>
          	<th class="th02">&nbsp;</th>     
          	<th class="th02">(Completed Orders)<br>Item Qty</th>
          	<th class="th02">Var</th>
          	<th class="th02">&nbsp;</th>
          	<th class="th02">(Completed Orders)<br>Item Retail</th>
          	<th class="th02">Var</th>
          <%}%>
          
        </tr>
        
        <tr class="trHdr01">
        	<%if(sSts.equals("Cannot Fill") || sSts.equals("Sold Out")){%>        		
        	    <th class="th02" colspan=2>Cannot Locate</th>
        	    <th class="th02" rowspan=2 >&nbsp;</th>     
				<th class="th02" colspan=2>RTV</th>
				<th class="th02" rowspan=2 >&nbsp;</th>  
				<th class="th02" colspan=2>Soiled/Damaged</th>
				<th class="th02" rowspan=2 >&nbsp;</th>  
				<th class="th02" colspan=2>Missing Pieces</th>
            <%} else if(sSts.equals("Error")) {
                   for(int j=0; j < sErrCode.length - 1; j++)
                   {%>
                	    <th class="th02" colspan=2><%=sErrCode[j]%></th>
               	        <th class="th02" rowspan=2 >&nbsp;</th>
                   <%}%>
                   <th class="th02" colspan=2>Store Totals</th>
                   <th class="th02" rowspan=2 >&nbsp;</th>
                   <th class="th02" colspan=2>Other</th>              
            <%}%>            
        </tr>
        
        <tr class="trHdr01">
        	<%if(sSts.equals("Cannot Fill") || sSts.equals("Sold Out")){%>
               <%for(int j=0; j < 4;j++){%>
               	  <th class="th02">Qty</th>
               	  <th class="th02">Ret</th>
               <%} %>          	
            <%}
            else if(sSts.equals("Error")) {%>
               <%for(int j=0; j < 8;j++){%>
               	  <th class="th02">Qty</th>
               	  <th class="th02">Ret</th>
               <%}%>
            <%}%>
        </tr>
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfGrp; i++) {        	   
        	cnlsum.setDetail();
   			String sGrp = cnlsum.getGrp();
   			String sGrpNm = cnlsum.getGrpNm();
   			String sStr = cnlsum.getStr();
   			String sDiv = cnlsum.getDiv();
   			String sDpt = cnlsum.getDpt();
   			String sCls = cnlsum.getCls();
   			String sVen = cnlsum.getVen();
   			String sSty = cnlsum.getSty();
   			String sClr = cnlsum.getClr();
   			String sSiz = cnlsum.getSiz();
   			String sSku = cnlsum.getSku();
   			String sQty = cnlsum.getQty();
   			String sRet = cnlsum.getRet();
   			String [] sCnlQty = cnlsum.getCnlQty();
			String [] sCnlRet = cnlsum.getCnlRet();
   			String sDesc = cnlsum.getDesc();
   			String sDivNm = cnlsum.getDivNm();
   			String sDptNm = cnlsum.getDptNm();
   			String sVenNm = cnlsum.getVenNm();
   			String sClsNm = cnlsum.getClsNm();
   			String sClrNm = cnlsum.getClrNm();
   			String sSizNm = cnlsum.getSizNm();
   			String sStrNm = cnlsum.getStrNm();   			
   			String [] sErrQty = cnlsum.getErrQty();
			String [] sErrRet = cnlsum.getErrRet();
			
			String sQtyComp = cnlsum.getQtyComp();
			String sQtyVar = cnlsum.getQtyVar();
			String sRetComp = cnlsum.getRetComp();
			String sRetVar = cnlsum.getRetVar();
   			
   			if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
   			else {sTrCls = "trDtl06";}
   			
           %>                           
           <tr id="trGrp<%=i%>" class="<%=sTrCls%>">
             <td id="tdGrp<%=i%>" class="td12" nowrap><%if(sSelCls.equals("ALL")){%><a id='alink<%=i%>' href="javascript: drilldown('<%=i%>', true, <%=bReverse%>)"><%=sGrp%></a><%} else {%><%=sGrp%><%}%></td>
             <td id="trGrpNm<%=i%>" class="td11" nowrap><%=sGrpNm%></td>
             <td class="td12" nowrap>
                 <%if(sLevel.equals("S") && sSelDiv.equals("ALL") && sSelDpt.equals("ALL") && sSelCls.equals("ALL")){%>
                    <a id='alinkFflStr<%=i%>' href="javascript: getOrdLst('<%=i%>')"><%=sQty%></a>
                 <%} else {%><%=sQty%><%}%>   
             </td>
             <td class="td12" nowrap>$<%=sRet%></td>
             <%if(sSts.equals("Cannot Fill") || sSts.equals("Sold Out")){%>
               <%for(int j=0; j < 4;j++){%>
                  <td class="td43">&nbsp;</td>
                  <td class="td12" nowrap><%=sCnlQty[j]%></td>
               	  <td class="td12" nowrap>$<%=sCnlRet[j]%></td>
               <%} %>          	
             <%}
             else if(sSts.equals("Error") ){%>
               <%for(int j=0; j < 6;j++){%>
                  <td class="td43">&nbsp;</td>
                  <td class="td12" nowrap><%=sErrQty[j]%></td>
               	  <td class="td12" nowrap>$<%=sErrRet[j]%></td>
               <%} %>
                  <td class="td43">&nbsp;</td>
                  <td class="td12" style="background: gold" nowrap><%=sErrQty[7]%></td>
               	  <td class="td12" style="background: gold" nowrap>$<%=sErrRet[7]%></td>
               	  <td class="td43">&nbsp;</td>
               	  <td class="td12" nowrap><%=sErrQty[6]%></td>
               	  <td class="td12" nowrap>$<%=sErrRet[6]%></td>
             <%}%>
             <%if(sGrpHdr.equals("SKU")){%>
                <td class="td11" ><a id='alinkFfl<%=i%>' href="javascript: gotoStrFflTool_BySku('<%=i%>')">FFL</a></td>
                <td class="td11" ><%=sCls%>-<%=sVen%>-<%=sSty%>-<%=sClr%>-<%=sSiz%></td>
          		<td class="td11" ><%=sVenNm%></td>
          		<td class="td11" ><%=sClrNm%></td>
          		<td class="td11" ><%=sSizNm%></td>
          	 <%}%>
          	 
          	 <%if(sSts.equals("Shipped") && sGrpHdr.equals("Store") && bTop) {%>
          	 	<td class="td43">&nbsp;</td>
          	    <td class="td12" ><%=sQtyComp%></td>
          	    <td class="td12" ><%=sQtyVar%>%</td>
          	    
          	    <td class="td43">&nbsp;</td>
          	    <td class="td12" >$<%=sRetComp%></td>
          	    <td class="td12" ><%=sRetVar%>%</td>
            <%}%>
           </tr>
              <script></script>	
           <%}%> 
           <!-- ======Total ================ -->
           <%
           cnlsum.setTotals();
   		   String sQty = cnlsum.getQty();
   		   String sRet = cnlsum.getRet();
   		   String [] sCnlQty = cnlsum.getCnlQty();
		   String [] sCnlRet = cnlsum.getCnlRet();
		   String [] sErrQty = cnlsum.getErrQty();
		   String [] sErrRet = cnlsum.getErrRet();
		   
		   String sQtyComp = cnlsum.getQtyComp();
		   String sQtyVar = cnlsum.getQtyVar();
		   String sRetComp = cnlsum.getRetComp();
		   String sRetVar = cnlsum.getRetVar();
		   
           %>
		   <tr id="trTotal" class="trDtl15">
             <td class="td12" nowrap colspan=2>Totals:</td>              
             <td class="td12" nowrap><%=sQty%></td>
             <td class="td12" nowrap>$<%=sRet%></td> 
             <%if(sSts.equals("Cannot Fill") || sSts.equals("Sold Out")){%>
               <%for(int j=0; j < 4;j++){%>
                  <td class="td43">&nbsp;</td>
                  <td class="td12" nowrap><%=sCnlQty[j]%></td>
               	  <td class="td12" nowrap>$<%=sCnlRet[j]%></td>
               <%} %>          	
             <%}
             else if(sSts.equals("Error") ){%>
             <%for(int j=0; j < 6;j++){%>
                <td class="td43">&nbsp;</td>
                <td class="td12" nowrap><%=sErrQty[j]%></td>
             	  <td class="td12" nowrap>$<%=sErrRet[j]%></td>
             <%} %>
                  <td class="td43">&nbsp;</td>
                  <td class="td12" style="background: gold" nowrap><%=sErrQty[7]%></td>
             	  <td class="td12" style="background: gold" nowrap>$<%=sErrRet[7]%></td>
             	  <td class="td43">&nbsp;</td>
             	  <td class="td12" nowrap><%=sErrQty[6]%></td>
             	  <td class="td12" nowrap>$<%=sErrRet[6]%></td>
           <%}%>
           
             <%if(sGrpHdr.equals("SKU")){%>
                <td class="td11" colspan=5>&nbsp;</td>
          	 <%}%> 
          	 
          	 <%if(sSts.equals("Shipped") && sGrpHdr.equals("Store") && bTop) {%>
          	 	<td class="td43">&nbsp;</td>
          	    <td class="td12" ><%=sQtyComp%></td>
          	    <td class="td12" ><%=sQtyVar%>%</td>
          	    
          	    <td class="td43">&nbsp;</td>
          	    <td class="td12" >$<%=sRetComp%></td>
          	    <td class="td12" ><%=sRetVar%>%</td>
            <%}%>              
           </tr>
           
           <%if(sLevel.equals("S") && sSelStr.equals("ALL")){%>
                <%
                cnlsum.setTotals();
                sQty = cnlsum.getQty();
                sRet = cnlsum.getRet();
                sCnlQty = cnlsum.getCnlQty();
    			sCnlRet = cnlsum.getCnlRet();
    			sErrQty = cnlsum.getErrQty();
    			sErrRet = cnlsum.getErrRet();
    			
    			sQtyComp = cnlsum.getQtyComp();
    			sQtyVar = cnlsum.getQtyVar();
    			sRetComp = cnlsum.getRetComp();
    			sRetVar = cnlsum.getRetVar();
    	           
                %>
		        <tr id="trTotal" class="trDtl15">
                  <td class="td12" nowrap colspan=2>DC:</td>              
                  <td class="td12" nowrap><%=sQty%></td>
                  <td class="td12" nowrap>$<%=sRet%></td> 
                  <%if(sSts.equals("Cannot Fill") || sSts.equals("Sold Out")){%>
               		<%for(int j=0; j < 4;j++){%>
                  		<td class="td43">&nbsp;</td>
                  		<td class="td12" nowrap><%=sCnlQty[j]%></td>
               	  		<td class="td12" nowrap>$<%=sCnlRet[j]%></td>
               		<%} %>          	
             	  <%}
                  else if(sSts.equals("Error") ){%>
                  <%for(int j=0; j < 6;j++){%>
                     <td class="td43">&nbsp;</td>
                     <td class="td12" nowrap><%=sErrQty[j]%></td>
                  	  <td class="td12" nowrap>$<%=sErrRet[j]%></td>
                  <%} %>
                     <td class="td43">&nbsp;</td>
                      <td class="td12" style="background: gold" nowrap><%=sErrQty[7]%></td>
                  	  <td class="td12" style="background: gold" nowrap>$<%=sErrRet[7]%></td>
                  	  <td class="td43">&nbsp;</td>
                  	  <td class="td12" nowrap><%=sErrQty[6]%></td>
                  	  <td class="td12" nowrap>$<%=sErrRet[6]%></td>
                <%}%>
                
                  <%if(sGrpHdr.equals("SKU")){%>
                    <td class="td11" colspan=5>&nbsp;</td>
          	      <%}%>
          	      
          	      <%if(sSts.equals("Shipped") && sGrpHdr.equals("Store") && bTop) {%>
          	 		<td class="td43">&nbsp;</td>
          	    	<td class="td12" ><%=sQtyComp%></td>
          	    	<td class="td12" ><%=sQtyVar%>%</td>
          	    
          	    	<td class="td43">&nbsp;</td>
          	    	<td class="td12" >$<%=sRetComp%></td>
          	    	<td class="td12" ><%=sRetVar%>%</td>
                <%}%> 
          	      
          	      
          	      
          	    <%
                cnlsum.setTotals();
                sQty = cnlsum.getQty();
                sRet = cnlsum.getRet();
                sCnlQty = cnlsum.getCnlQty();
    			sCnlRet = cnlsum.getCnlRet();
    			sErrQty = cnlsum.getErrQty();
    			sErrRet = cnlsum.getErrRet();
    			
    			sQtyComp = cnlsum.getQtyComp();
    			sQtyVar = cnlsum.getQtyVar();
    			sRetComp = cnlsum.getRetComp();
    			sRetVar = cnlsum.getRetVar();
                %>
		        <tr id="trTotal" class="trDtl15">
                  <td class="td12" nowrap colspan=2>All Stores:</td>              
                  <td class="td12" nowrap><%=sQty%></td>
                  <td class="td12" nowrap>$<%=sRet%></td> 
                  <%if(sSts.equals("Cannot Fill") || sSts.equals("Sold Out")){%>
               		<%for(int j=0; j < 4;j++){%>
                  		<td class="td43">&nbsp;</td>
                  		<td class="td12" nowrap><%=sCnlQty[j]%></td>
               	  		<td class="td12" nowrap>$<%=sCnlRet[j]%></td>
               		<%} %>          	
             	  <%}
                  else if(sSts.equals("Error") ){%>
                  <%for(int j=0; j < 6;j++){%>
                     <td class="td43">&nbsp;</td>
                     <td class="td12" nowrap><%=sErrQty[j]%></td>
                  	  <td class="td12" nowrap>$<%=sErrRet[j]%></td>
                  <%} %>
                     <td class="td43">&nbsp;</td>
                      <td class="td12" style="background: gold" nowrap><%=sErrQty[7]%></td>
                  	  <td class="td12" style="background: gold" nowrap>$<%=sErrRet[7]%></td>
                  	  <td class="td43">&nbsp;</td>
                  	  <td class="td12" nowrap><%=sErrQty[6]%></td>
                  	  <td class="td12" nowrap>$<%=sErrRet[6]%></td>
                <%}%>
                                    
                  
                  <%if(sGrpHdr.equals("SKU")){%>
                    <td class="td11" colspan=5>&nbsp;</td>
          	      <%}%>
          	      
          	      <%if(sSts.equals("Shipped") && sGrpHdr.equals("Store") && bTop) {%>
          	 		<td class="td43">&nbsp;</td>
          	    	<td class="td12" ><%=sQtyComp%></td>
          	    	<td class="td12" ><%=sQtyVar%>%</td>
          	    
          	    	<td class="td43">&nbsp;</td>
          	    	<td class="td12" >$<%=sRetComp%></td>
          	    	<td class="td12" ><%=sRetVar%>%</td>
            	<%}%> 
          	                     
           </tr>
           
           <%}%>
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
cnlsum.disconnect();
cnlsum = null;
}
%>