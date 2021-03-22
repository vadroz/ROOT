<%@ page import="inventoryreports.PiDtlVenAdj, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String sSelDiv = request.getParameter("Div");   
   String sSelDpt = request.getParameter("Dpt");
   String sSelCls = request.getParameter("Cls");
   String sSelVen = request.getParameter("Ven");
   String sSelSty = request.getParameter("Sty");
   String sPiCal = request.getParameter("PiCal");   
   String sPiCal1 = request.getParameter("PiCal1bk");
   String sPiCal2 = request.getParameter("PiCal2bk");
   String sPiCalNm = request.getParameter("PiCalNm");   
   String sPiCal1Nm = request.getParameter("PiCal1bkNm");
   String sPiCal2Nm = request.getParameter("PiCal2bkNm");
   String sLevel = request.getParameter("Level");
   String sSort = request.getParameter("Sort");
   
   if(sSelDpt == null){ sSelDpt = "ALL"; }
   if(sSelCls == null){ sSelCls = "ALL"; }
   if(sSelVen == null){ sSelVen = "ALL"; }
   if(sSelSty == null){ sSelSty = "ALL"; }
   
   if(sLevel == null){ sLevel = "S"; }
   if(sSort == null){ sSort = "Grp"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PiDtlVenAdj.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	 
	PiDtlVenAdj vendtl = new PiDtlVenAdj();
	
	//Div=7&Dpt=901&Cls=7726&Ven=1899&Sty=ALL&Str=3&Str=4&Str=5&PiCal=201612&PiCal1bk=NONE&PiCal2bk=NONE
	
	vendtl.setVenDtl(sSelDiv, sSelDpt, sSelCls, sSelVen, sSelSty, sSelStr
		,sPiCal,sPiCal1,sPiCal2, sLevel, sSort, sUser);
	
	int iNumOfGrp = vendtl.getNumOfGrp();
	
	
	String sGrpHdr = null;
	String sGrpNmHdr = null;
	String [] sALinkTxt = new String[2];
	String [] sALinkVal = new String[2];
	boolean bMultStr = sSelStr[0].equals("ALL") || sSelStr.length > 1;	
	
	if(sLevel.equals("S"))
	{
		sGrpHdr = "Store";
		sGrpNmHdr = "Store<br>Name";
		sALinkTxt[0] = "By Item";
		sALinkVal[0] = "switchGrpDiv()";		 
	}
	else if(sLevel.equals("C"))
	{
		sGrpHdr = "Class-Vendor-Style"; sGrpNmHdr = "Item<br>Description";
		
		sALinkTxt[0] = "By Str";
		sALinkVal[0] = "switchGrpStr()";		 
	}
	else if(sLevel.equals("I"))
	{
		sGrpHdr = "Long ItemNumber"; sGrpNmHdr = "Item<br>Description";
		sALinkTxt[0] = "By Str"; sALinkVal[0] = "switchGrpStr()";		 
	}	
	
	boolean bReverse = false;
	if(sLevel.equals("S") ){ bReverse = true; }
	
    //--------------- retreive store list ----------------------------
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
   
   int iCal = 1;
   Vector<String> vCal = new Vector();
   vCal.add(sPiCalNm);
   if(!sPiCal1.equals("NONE")){iCal++; vCal.add(sPiCal1Nm); }
   if(!sPiCal2.equals("NONE")){iCal++; vCal.add(sPiCal2Nm); }
   String [] sArrCal = new String[]{};
   sArrCal = vCal.toArray(sArrCal);   
   String sSelStrJsa =  vendtl.cvtToJavaScriptArray(sSelStr);   
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>PI Total Adj</title>

<SCRIPT>

//--------------- Global variables -----------------------
var SelStr = [<%=sSelStrJsa%>];
var SelDiv = "<%=sSelDiv%>";
var SelDpt = "<%=sSelDpt%>";
var SelCls = "<%=sSelCls%>";
var SelVen = "<%=sSelVen%>";
var SelSty = "<%=sSelSty%>";

var PiCal = "<%=sPiCal%>";
var PiCal1 = "<%=sPiCal1%>";
var PiCal2 = "<%=sPiCal2%>";
var PiCalNm = "<%=sPiCalNm%>";
var PiCal1Nm = "<%=sPiCal1Nm%>";
var PiCal2Nm = "<%=sPiCal2Nm%>";
var Level = "<%=sLevel%>";
var Sort = "<%=sSort%>";
var User = "<%=sUser%>";
var NumOfGrp = "<%=iNumOfGrp%>";
var ArrStr = [<%=sStrJsa%>];

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
// re-sort page
//==============================================================================
function reSort(sort)
{		
	var url = "PiDtlVenAdj.jsp?PiCal=" + PiCal + "&PiCal1bk=" + PiCal1 + "&PiCal2bk=" + PiCal2 
	+ "&PiCalNm=" + PiCalNm + "&PiCal1bkNm=" + PiCal1Nm	+ "&PiCal2bkNm=" + PiCal2Nm
	+ "&Level=" + Level + "&Sort=" + sort;
	 
	url += "&Div=" + SelDiv + "&Dpt=" + SelDpt + "&Cls=" + SelCls 
	     + "&Ven=" + SelVen + "&Sty=" + SelSty;
	for(var i=0; i < SelStr.length; i++){url += "&Str=" + SelStr[i];}
	
	window.location.href = url;
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
// switch from Store/Vendor to Hierarchy group 
//==============================================================================
function switchGrpDiv()
{
	var url = "PiDtlVenAdj.jsp?PiCal=" + PiCal + "&PiCal1bk=" + PiCal1 + "&PiCal2bk=" + PiCal2
	  + "&PiCalNm=" + PiCalNm + "&PiCal1bkNm=" + PiCal1Nm	+ "&PiCal2bkNm=" + PiCal2Nm;
	
	if(SelSty == "ALL"){ url += "&Level=C";}
	else{ url += "&Level=I"; }
	
	url += "&Sort=" + Sort;
	 
	for(var i=0; i < SelDiv.length; i++){url += "&Div=" + SelDiv[i];}
	url += "&Dpt=" + SelDpt + "&Cls=" + SelCls + "&Ven=" + SelVen + "&Sty=" + SelSty;
	for(var i=0; i < SelStr.length; i++){url += "&Str=" + SelStr[i];}
	
	window.location.href = url;
}
//==============================================================================
//switch from Hierarchy group to Store
//==============================================================================
function switchGrpStr()
{
	var url = "PiDtlVenAdj.jsp?PiCal=" + PiCal + "&PiCal1bk=" + PiCal1 + "&PiCal2bk=" + PiCal2
	  + "&PiCalNm=" + PiCalNm + "&PiCal1bkNm=" + PiCal1Nm	+ "&PiCal2bkNm=" + PiCal2Nm			
	  + "&Level=S&Sort=" + Sort;
	
	for(var i=0; i < SelDiv.length; i++){url += "&Div=" + SelDiv[i];}
	url += "&Dpt=" + SelDpt + "&Cls=" + SelCls + "&Ven=" + SelVen + "&Sty=" + SelSty;
	for(var i=0; i < SelStr.length; i++){url += "&Str=" + SelStr[i];}
	
	window.location.href = url;
}
//==============================================================================
// drill down and/or reverse by store or inventory
//==============================================================================
function drilldown(arg)
{
	var url = "PiDtlVenAdj.jsp?PiCal=" + PiCal + "&PiCal1bk=" + PiCal1 + "&PiCal2bk=" + PiCal2 
		+ "&PiCalNm=" + PiCalNm + "&PiCal1bkNm=" + PiCal1Nm	+ "&PiCal2bkNm=" + PiCal2Nm
		+ "&Sort=" + Sort;
	var lvl = Level;
	
	// reverse report grouping from store or vendor to hierarchy
	if(lvl=="S"){ lvl="C";}	
	else if(lvl=="C"){ lvl="I";}
	url += "&Level=" + lvl;

	// drill down
	var grp = null;
		
	if(arg >= 0){ grp = $("#alink" + arg).html();}
	
	if(Level == "C")
	{		 
	 	url += "&Div=" + SelDiv + "&Dpt=" + SelDpt + "&Cls=" + SelCls
	 	 + "&Ven=" + grp.substring(5,10)  + "&Sty=" + grp.substring(11)
	 	; 
	}	
	else if(Level == "S")
	{
		for(var i=0; i < SelDiv.length; i++){url += "&Div=" + SelDiv[i];}		
		url += "&Dpt=" + SelDpt + "&Cls=" + SelCls + "&Ven=" + SelVen;
	}
	
	// add store selection
	if(Level == "S"){ url += "&Str=" + grp; }	
	else 
	{ 
		for(var i=0; i < SelStr.length; i++){url += "&Str=" + SelStr[i];}		 
	}
			
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
//go to Store fullfilment tool by store
//==============================================================================
function gotoStrFflTool_ByStr(arg)
{
	var url = "MozuSrlAsg.jsp?StsFrDate=" + FromDt + "&StsToDate=" + ToDt;
			
	var grp = $("#alink" + arg).html();
	url += "&Str=" + grp + "&Sts=Cannot Fill";
	
	var istr = 0;	
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
<iframe  id="frame2"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Physical Inventory Total Adjustment:  
            
            <%String sComa=""; %>
            <br> Store: <%for(int i=0; i < sSelStr.length; i++){%><%=sComa%><%if(i%30 == 0){%><br><%}%><%=sSelStr[i]%><%sComa = ",";%><%}%>
            <%sComa=""; %>
            <br> Divison: <%=sSelDiv%>
            <%if(!sSelDpt.equals("ALL")){%>, Department: <%=sSelDpt%><%}%>
            <%if(!sSelCls.equals("ALL")){%>, Class: <%=sSelCls%><%}%>
            <%if(!sSelVen.equals("ALL")){%>, Vendor: <%=sSelVen%><%}%>            
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="PiSumVenAdjSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02" rowspan=4 nowrap><a href="javascript: reSort('Grp')"><%=sGrpHdr%></a><br><br>
             <a href="javascript: <%=sALinkVal[0]%>"><%=sALinkTxt[0]%></a>              
          </th>           
          <th class="th02" rowspan=4 >Item Description</th>
          <th class="th02" rowspan=4 >Vendor Name</th>
          <th class="th02" rowspan=4 >Color Name</th>
          <th class="th02" rowspan=4 >Size Name</th>
          <th class="th02" rowspan=4 >SKU</th>
          <th class="th02" rowspan=4 >UPC</th>
          <th class="th02" rowspan=4 >First<br>Received<br>Date</th>
          <th class="th02" rowspan=4 >First<br>Chain<br>Retail</th>
          
          <%for(int j=0; j < iCal; j++){%>
            <th class="th02" rowspan=4 >&nbsp</th>
            <th class="th02" colspan=20 ><%=sArrCal[j]%></th>
          <%} %>
        </tr>
        
        <tr class="trHdr01">
          <%for(int j=0; j < iCal; j++){%>
          	<th class="th02" rowspan=1 colspan=6>Physical Count</th>
          	<th class="th02" rowspan=3 >&nbsp</th>
          	<th class="th02" rowspan=1 colspan=6>Computer On Hand</th>
          	<th class="th02" rowspan=3 >&nbsp</th>
          	<th class="th02" rowspan=1 colspan=6>Total Adjustment</th>
          <%} %>
        </tr>
        <tr class="trHdr01">            
          <%for(int j=0; j < iCal; j++){%>          	
            <th class="th02" colspan=2>Units</th>
          	<th class="th02" colspan=2>Cost</th>
          	<th class="th02" colspan=2>Retail</th>
          	
          	<th class="th02" colspan=2>Units</th>
          	<th class="th02" colspan=2>Cost</th>
          	<th class="th02" colspan=2>Retail</th>
          	
          	
          	<th class="th02" colspan=2>Units</th>
          	<th class="th02" colspan=2>Cost</th>
          	<th class="th02" colspan=2>Retail</th>
          <%} %>          
        </tr>
        
        <tr class="trHdr01">
          <%for(int j=0; j < iCal; j++){%>
            <th class="th02"><a href="javascript: reSort('BOOKQTY<%=j+1%>UP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
            <th class="th02"><a href="javascript: reSort('BOOKQTY<%=j+1%>DW')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
          	<th class="th02"><a href="javascript: reSort('BOOKCOST<%=j+1%>UP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>          	
          	<th class="th02"><a href="javascript: reSort('BOOKCOST<%=j+1%>DW')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
          	<th class="th02"><a href="javascript: reSort('BOOKRET<%=j+1%>UP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
          	<th class="th02"><a href="javascript: reSort('BOOKRET<%=j+1%>DW')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
          	   
          	<th class="th02"><a href="javascript: reSort('PHYQTY<%=j+1%>UP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
          	<th class="th02"><a href="javascript: reSort('PHYQTY<%=j+1%>DW')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>          	
          	<th class="th02"><a href="javascript: reSort('PHYCOST<%=j+1%>UP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
          	<th class="th02"><a href="javascript: reSort('PHYCOST<%=j+1%>DW')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
          	<th class="th02"><a href="javascript: reSort('PHYRET<%=j+1%>UP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
          	<th class="th02"><a href="javascript: reSort('PHYRET<%=j+1%>DW')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
          	
          	<th class="th02"><a href="javascript: reSort('ADJQTY<%=j+1%>UP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
          	<th class="th02"><a href="javascript: reSort('ADJQTY<%=j+1%>DW')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>          	
          	<th class="th02"><a href="javascript: reSort('ADJCOST<%=j+1%>UP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
          	<th class="th02"><a href="javascript: reSort('ADJCOST<%=j+1%>DW')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
          	<th class="th02"><a href="javascript: reSort('ADJRET<%=j+1%>UP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
          	<th class="th02"><a href="javascript: reSort('ADJRET<%=j+1%>DW')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
          <%} %>
        </tr>
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfGrp; i++) {        	   
        	vendtl.setDetail();
        	String sGrp = vendtl.getGrp();
			String sGrpNm = vendtl.getGrpNm();
			String sStr = vendtl.getStr();
			String sCls = vendtl.getCls();
			String sVen = vendtl.getVen();
			String sSty = vendtl.getSty();
			String sClr = vendtl.getClr();
			String sSiz = vendtl.getSiz();
			String sSku = vendtl.getSku();
			String sUpd = vendtl.getUpd();			 
			String sRet = vendtl.getRet();
			String sFri = vendtl.getFri();
			
			String [] sBookQty = vendtl.getBookQty();
			String [] sBookRet = vendtl.getBookRet();
			String [] sBookCost = vendtl.getBookCost();
			
			String [] sCompQty = vendtl.getCompQty();
			String [] sCompRet = vendtl.getCompRet();
			String [] sCompCost = vendtl.getCompCost();
			
			String [] sAdjQty = vendtl.getAdjQty();
			String [] sAdjRet = vendtl.getAdjRet();
			String [] sAdjCost = vendtl.getAdjCost();
			
			String sVenNm = vendtl.getVenNm();
			String sClrNm = vendtl.getClrNm();
			String sSizNm = vendtl.getSizNm();
			String sDesc = vendtl.getDesc();	
			
   			//if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
   			//else {sTrCls = "trDtl06";}
   			
			String [] sPiYrClr = new String[]{"#d6f2d9", "#d9d6b1", "#d4d4fb" };
           %>                           
           <tr id="trGrp<%=i%>" class="<%=sTrCls%>">
             <td id="tdGrp<%=i%>" class="td12" nowrap>                
             	<%if(sSelSty.equals("ALL")){%><a id='alink<%=i%>' href="javascript: drilldown('<%=i%>')"><%=sGrp%></a><%}
             	  else {%><%=sGrp%><%}%>             	 
             </td>             
             <td class="td11" nowrap><%=sDesc%></td>
             <td class="td11" nowrap><%=sVenNm%></td>
             <td class="td11" nowrap><%=sClrNm%></td>
             <td class="td11" nowrap><%=sSizNm%></td>
             <td class="td11" nowrap><%=sSku%></td>
             <td class="td11" nowrap><%=sUpd%></td>
             <td class="td18" nowrap><%=sFri%></td>
             <td class="td12" nowrap>$<%=sRet%></td>
             
             <%for(int j=0; j < iCal; j++){%>
                <td class="td43">&nbsp</td>
             	<td class="td12" colspan=2 style="background: <%=sPiYrClr[j]%>" nowrap><%=sCompQty[0]%></td>
             	<td class="td12" colspan=2 style="background: <%=sPiYrClr[j]%>" nowrap>$<%=sCompCost[0]%></td>
             	<td class="td12" colspan=2 style="background: <%=sPiYrClr[j]%>" nowrap>$<%=sCompRet[0]%></td>
             	
             	<td class="td43">&nbsp</td>
             	<td class="td12" colspan=2 style="background: <%=sPiYrClr[j]%>" nowrap><%=sBookQty[0]%></td>
             	<td class="td12" colspan=2 style="background: <%=sPiYrClr[j]%>" nowrap>$<%=sBookCost[0]%></td>
             	<td class="td12" colspan=2 style="background: <%=sPiYrClr[j]%>" nowrap>$<%=sBookRet[0]%></td>
             	             
                <td class="td43">&nbsp</td>
                <td class="td12" colspan=2 style="background: <%=sPiYrClr[j]%>" nowrap><%=sAdjQty[j]%></td>
             	<td class="td12" colspan=2 style="background: <%=sPiYrClr[j]%>" nowrap>$<%=sAdjCost[j]%></td>
             	<td class="td12" colspan=2 style="background: <%=sPiYrClr[j]%>" nowrap>$<%=sAdjRet[j]%></td>             	             	
             <%}%>             
           </tr>
              <script></script>	
           <%}%>
           
           
            
           <!-- ======Total ================ -->
           <%
            vendtl.setTotals();
            String [] sBookQty = vendtl.getBookQty();
  			String [] sBookRet = vendtl.getBookRet();
  			String [] sBookCost = vendtl.getBookCost();
  			String [] sCompQty = vendtl.getCompQty();
  			String [] sCompRet = vendtl.getCompRet();
  			String [] sCompCost = vendtl.getCompCost();
  			String [] sAdjQty = vendtl.getAdjQty();
  			String [] sAdjRet = vendtl.getAdjRet();
  			String [] sAdjCost = vendtl.getAdjCost();  			
           %>
		   <tr id="trTotal" class="trDtl15">
             <td class="td12" nowrap colspan=9>Totals:</td>
             
             <%for(int j=0; j < iCal; j++){%>
             	<td class="td43">&nbsp;</td>
             	<td class="td12" colspan=2 nowrap><%=sCompQty[0]%></td>
             	<td class="td12" colspan=2 nowrap>$<%=sCompCost[0]%></td>
             	<td class="td12" colspan=2 nowrap>$<%=sCompRet[0]%></td>
             	
             	<td class="td43">&nbsp;</td> 
             	<td class="td12" colspan=2 nowrap><%=sBookQty[0]%></td>
             	<td class="td12" colspan=2 nowrap>$<%=sBookCost[0]%></td>
             	<td class="td12" colspan=2 nowrap>$<%=sBookRet[0]%></td>            	             
             
                <td class="td43">&nbsp;</td>
                <td class="td12" colspan=2 nowrap><%=sAdjQty[j]%></td>
             	<td class="td12" colspan=2 nowrap>$<%=sAdjCost[j]%></td>
             	<td class="td12" colspan=2 nowrap>$<%=sAdjRet[j]%></td>             	
             <%}%>   
           </tr>
           
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
vendtl.disconnect();
vendtl = null;
}
%>