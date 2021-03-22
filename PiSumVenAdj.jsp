<%@ page import="inventoryreports.PiSumVenAdj, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String [] sSelDiv = request.getParameterValues("Div");   
   String sSelDpt = request.getParameter("Dpt");
   String sSelCls = request.getParameter("Cls");
   String sSelVen = request.getParameter("Ven");
   String sSelVenNm = request.getParameter("VenNm");
   String sPiCal = request.getParameter("PiCal");   
   String sPiCal1 = request.getParameter("PiCal1bk");
   String sPiCal2 = request.getParameter("PiCal2bk");
   String sPiCalNm = request.getParameter("PiCalNm");   
   String sPiCal1Nm = request.getParameter("PiCal1bkNm");
   String sPiCal2Nm = request.getParameter("PiCal2bkNm");
   String sLevel = request.getParameter("Level");
   String sIncl9 = request.getParameter("Incl9");
   String sSort = request.getParameter("Sort");
  
   
   if(sSelDpt == null){ sSelDpt = "ALL"; }
   if(sSelCls == null){ sSelCls = "ALL"; }
   
   if(sLevel == null){ sLevel = "S"; }
   if(sIncl9 == null){ sIncl9 = "N"; }
   if(sSort == null){ sSort = "Grp"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PiSumVenAdj.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	 
	PiSumVenAdj vensum = new PiSumVenAdj();
	
	/*System.out.println("|" + sSelDiv[0] + "|" + sSelDpt + "|" + sSelCls + "|" + sSelVen
		 + "|" + sSelStr[0] + "|" + sPiCal + "|" + sPiCal1 + "|" + sPiCal2 
		 + "|" + sLevel + "|" + sIncl9 + "|" + sSort + "|" + sUser);
	*/
	vensum.setVenSum(sSelDiv, sSelDpt, sSelCls, sSelVen, sSelStr, sPiCal, sPiCal1, sPiCal2, sLevel, sIncl9, sSort, sUser);
	
		
	int iNumOfGrp = vensum.getNumOfGrp();
	String sVenNm = vensum.getVenNm();
	
	String sGrpHdr = null;
	String sGrpNmHdr = null;
	String [] sALinkTxt = new String[2];
	String [] sALinkVal = new String[2];
	boolean bMultDiv = sSelDiv[0].equals("ALL") || sSelDiv.length > 1;
	boolean bMultStr = sSelStr[0].equals("ALL") || sSelStr.length > 1;	
	
	if(sLevel.equals("S"))
	{
		sGrpHdr = "Store";
		sGrpNmHdr = "Store<br>Name";
		sALinkTxt[0] = "By Div";
		sALinkVal[0] = "switchGrpDiv()";
		if(sSelVen.equals("ALL")){sALinkTxt[1] = "By Ven"; sALinkVal[1] = "switchGrpVen()";}
		else{sALinkTxt[1] = ""; sALinkVal[1] = "";}
	}
	else if(sLevel.equals("D"))
	{
		if(!sSelCls.equals("ALL")){ sGrpHdr = "Vendor"; sGrpNmHdr = "Vendor<br>Name"; }
		else if(!sSelDpt.equals("ALL")){ sGrpHdr = "Class"; sGrpNmHdr = "Class<br>Name"; }
		else if(!sSelDiv[0].equals("ALL") && !bMultDiv){ sGrpHdr = "Department"; sGrpNmHdr = "Department<br>Name"; }		
		else if(bMultDiv){sGrpHdr = "Division"; sGrpNmHdr = "Division<br>Name"; }
		
		sALinkTxt[0] = "By Str";
		sALinkVal[0] = "switchGrpStr()";
		if(sSelVen.equals("ALL")){ sALinkTxt[1] = "By Ven"; sALinkVal[1] = "switchGrpVen()";}
		else{ sALinkTxt[1] = ""; sALinkVal[1] = ""; }
	}
	else if(sLevel.equals("V"))
	{
		sGrpHdr = "Vendor"; sGrpNmHdr = "Vendor<br>Name";
		if(bMultStr){sALinkTxt[0] = "By Str"; sALinkVal[0] = "switchGrpStr()";}
		else{sALinkTxt[0] = "";sALinkVal[0] = "";}
		sALinkTxt[1] = "By Div";
		sALinkVal[1] = "switchGrpDiv()";
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
   
   String sSelStrJsa =  vensum.cvtToJavaScriptArray(sSelStr);
   String sSelDivJsa =  vensum.cvtToJavaScriptArray(sSelDiv);
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
var SelDiv = [<%=sSelDivJsa%>];
var SelDpt = "<%=sSelDpt%>";
var SelCls = "<%=sSelCls%>";
var SelVen = "<%=sSelVen%>";
var SelVenNm = "<%=sSelVenNm%>";

var PiCal = "<%=sPiCal%>";
var PiCal1 = "<%=sPiCal1%>";
var PiCal2 = "<%=sPiCal2%>";
var PiCalNm = "<%=sPiCalNm%>";
var PiCal1Nm = "<%=sPiCal1Nm%>";
var PiCal2Nm = "<%=sPiCal2Nm%>";
var Level = "<%=sLevel%>";
var Incl9 = "<%=sIncl9%>";
var Sort = "<%=sSort%>";
var User = "<%=sUser%>";
var NumOfGrp = "<%=iNumOfGrp%>";
var ArrStr = [<%=sStrJsa%>];
var GrpHdr = "<%=sGrpHdr%>";

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
	var url = "PiSumVenAdj.jsp?" 
	 + "PiCal=" + PiCal + "&PiCal1bk=" + PiCal1	+ "&PiCal2bk=" + PiCal2
	 + "&PiCalNm=" + PiCalNm + "&PiCal1bkNm=" + PiCal1Nm	+ "&PiCal2bkNm=" + PiCal2Nm
	 + "&Level=" + Level + "&Inlc9=" + Incl9 + "&Sort=" + sort;
	 
	for(var i=0; i < SelDiv.length; i++){url += "&Div=" + SelDiv[i];}
	url += "&Dpt=" + SelDpt + "&Cls=" + SelCls + "&Ven=" + SelVen + "&VenNm=" + SelVenNm;
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
	var url = "PiSumVenAdj.jsp?PiCal=" + PiCal + "&PiCal1bk=" + PiCal1 + "&PiCal2bk=" + PiCal2 
	  + "&PiCalNm=" + PiCalNm + "&PiCal1bkNm=" + PiCal1Nm	+ "&PiCal2bkNm=" + PiCal2Nm
	  + "&Level=D&Inlc9=" + Incl9 + "&Sort=" + Sort;
	 
	for(var i=0; i < SelDiv.length; i++){url += "&Div=" + SelDiv[i];}
	url += "&Dpt=" + SelDpt + "&Cls=" + SelCls + "&Ven=" + SelVen + "&VenNm=" + SelVenNm;
	for(var i=0; i < SelStr.length; i++){url += "&Str=" + SelStr[i];}
	
	window.location.href = url;
}
//==============================================================================
//switch from Hierarchy group to Store
//==============================================================================
function switchGrpStr()
{
	var url = "PiSumVenAdj.jsp?PiCal=" + PiCal + "&PiCal1bk=" + PiCal1 + "&PiCal2bk=" + PiCal2 
	 + "&PiCalNm=" + PiCalNm + "&PiCal1bkNm=" + PiCal1Nm	+ "&PiCal2bkNm=" + PiCal2Nm
	 + "&Level=S&Inlc9=" + Incl9 + "&Sort=" + Sort;
	
	for(var i=0; i < SelDiv.length; i++){url += "&Div=" + SelDiv[i];}
	url += "&Dpt=" + SelDpt + "&Cls=" + SelCls + "&Ven=" + SelVen + "&VenNm=" + SelVenNm;
	for(var i=0; i < SelStr.length; i++){url += "&Str=" + SelStr[i];}
	
	window.location.href = url;
}
//==============================================================================
//switch from Store/Hierarchy group to Store
//==============================================================================
function switchGrpVen()
{
	var url = "PiSumVenAdj.jsp?PiCal=" + PiCal + "&PiCal1bk=" + PiCal1 + "&PiCal2bk=" + PiCal2
	  + "&PiCalNm=" + PiCalNm + "&PiCal1bkNm=" + PiCal1Nm	+ "&PiCal2bkNm=" + PiCal2Nm
	  + "&Level=V&Inlc9=" + Incl9 + "&Sort=" + Sort;
	
	for(var i=0; i < SelDiv.length; i++){url += "&Div=" + SelDiv[i];}
	url += "&Dpt=" + SelDpt + "&Cls=" + SelCls + "&Ven=" + SelVen + "&VenNm=" + SelVenNm;
	for(var i=0; i < SelStr.length; i++){url += "&Str=" + SelStr[i];}
	
	window.location.href = url;
}
//==============================================================================
// drill down and/or reverse by store or inventory
//==============================================================================
function drilldown(arg)
{
	var url = "PiSumVenAdj.jsp?PiCal=" + PiCal + "&PiCal1bk=" + PiCal1 + "&PiCal2bk=" + PiCal2
	 + "&PiCalNm=" + PiCalNm + "&PiCal1bkNm=" + PiCal1Nm	+ "&PiCal2bkNm=" + PiCal2Nm
	 + "&Incl9=" + Incl9 + "&Sort=" + Sort;
	var lvl = Level;
	
	// reverse report grouping from store or vendor to hierarchy
	if(lvl=="S" || lvl=="V"){ lvl="D";}	
	url += "&Level=" + lvl;

	// drill down
	var grp = null;
	var grpnm = null;
	
	if(arg >= 0){ grp = $("#alink" + arg).html();	grpnm = $("#trGrpNm" + arg).html(); }
	
	if(Level == "D")
	{
		var grplvl = setCurGrpLvl();
		if(grplvl == "DIV"){ url += "&Div=" + grp; }
		else if(grplvl == "DEPT"){ url += "&Div=" + SelDiv + "&Dpt=" + grp; }
		else if(grplvl == "CLASS"){ url += "&Div=" + SelDiv + "&Dpt=" + SelDpt + "&Cls=" + grp; }
	}	 
	else if(Level == "S")
	{
		for(var i=0; i < SelDiv.length; i++){url += "&Div=" + SelDiv[i];}		
		url += "&Dpt=" + SelDpt + "&Cls=" + SelCls + "&Ven=" + SelVen + "&VenNm=" + SelVenNm;
	}
	else if(Level == "V")
	{
		for(var i=0; i < SelDiv.length; i++){url += "&Div=" + SelDiv[i];}		
		url += "&Dpt=" + SelDpt + "&Cls=" + SelCls + "&Ven=" + grp + "&VenNm=" + grpnm;
	}
	
	// add store selection
	if(Level == "S"){ url += "&Str=" + grp; }	
	else 
	{ 
		for(var i=0; i < SelStr.length; i++){url += "&Str=" + SelStr[i];}		 
	}
	
	// add vendor selection
	if(Level == "V"){ url += "&Ven=" + grp + "&VenNm=" + grpnm; }
	else{ url += "&Ven=" + SelVen + "&VenNm=" + SelVenNm; }
		
	window.location.href = url;
}
//==============================================================================
// drill down to class vendor style
//==============================================================================
function drilldownCVS(arg)
{	
	var grp = null;
	var grpnm = null;
	
	if(arg >= 0){ grp = $("#alink" + arg).html();	grpnm = $("#trGrpNm" + arg).html(); }
	
	
	var url = "PiDtlVenAdj.jsp?"
	 
	if(GrpHdr=="Vendor"){ url += "Div=" + SelDiv[0] + "&Dpt=" + SelDpt + "&Cls=" + SelCls + "&Ven=" + grp; }
	else if(GrpHdr=="Class"){ url += "Div=" + SelDiv[0] + "&Dpt=" + SelDpt + "&Cls=" + grp + "&Ven=" + SelVen; }
	else if(GrpHdr=="Department"){ url += "Div=" + SelDiv[0] + "&Dpt=" + grp + "&Cls=" + SelCls + "&Ven=" + SelVen; }
	else if(GrpHdr=="Division"){ url += "Div=" + grp + "&Dpt=" + SelDpt + "&Cls=" + SelCls + "&Ven=" + SelVen; }
	 
	url += "&Sty=ALL"
	 ;
	
	for(var i=0; i < SelStr.length; i++){url += "&Str=" + SelStr[i];}
	
	url += "&PiCal=" + PiCal + "&PiCal1bk=" + PiCal1 + "&PiCal2bk=" + PiCal2
	  + "&PiCalNm=" + PiCalNm + "&PiCal1bkNm=" + PiCal1Nm	+ "&PiCal2bkNm=" + PiCal2Nm
	  + "&Sort=<%=sSort%>&Level=C"
	;
	
	window.location.href = url;
}
//==============================================================================
// find current grp level 
//==============================================================================
function setCurGrpLvl()
{
	var grplvl = "DIV";
	if(SelCls != "ALL"){ grplvl = "VEN"; }
	else if(SelDpt != "ALL"){ grplvl = "CLASS"; }
	else if(SelDiv[0] != "ALL" && SelDiv.length == 1){ grplvl = "DEPT"; }	
	
	return grplvl;
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
            <br> Divison: <%for(int i=0; i < sSelDiv.length; i++){%><%=sComa + sSelDiv[i]%><%sComa = ",";%><%}%>
            <%if(!sSelDpt.equals("ALL")){%>, Department: <%=sSelDpt%><%}%>
            <%if(!sSelCls.equals("ALL")){%>, Class: <%=sSelCls%><%}%>
            <%if(!sSelVen.equals("ALL")){%>, Vendor: <%=sSelVen%> - <%=sVenNm%><%}%>                        
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
             <br><a href="javascript: <%=sALinkVal[1]%>"><%=sALinkTxt[1]%></a>
          </th>
          <th class="th02" rowspan=4 ><%=sGrpNmHdr%></th>
          <th class="th02" rowspan=4 >&nbsp;</th>
          <th class="th02" rowspan=2 colspan=3>Physical Count</th>  
          <th class="th02" rowspan=4 >&nbsp;</th>        
          <th class="th02" rowspan=2 colspan=3>Computer On Hand</th>
          <%for(int j=0; j < iCal; j++){%>
            <th class="th02" rowspan=4 >&nbsp;</th>
            <th class="th02" colspan=9 ><%=sArrCal[j]%></th>
          <%} %>
          <%if(!sGrpHdr.equals("Vendor") && !sGrpHdr.equals("Store")){%>
          	 <th class="th02" rowspan=4 >D<br>e<br>t<br>a<br>i<br>l</th>
          <%}%>
        </tr>  
        
        <tr class="trHdr01">
          <%for(int j=0; j < iCal; j++){%>
          <th class="th02" colspan=6>Total Adjustment</th>
          <th class="th02" rowspan=3>Retail<br>Sales<br>in<br>1,000's</th>
          <th class="th02" rowspan=2 colspan=2>Shrinkage<br>%</th>
          <%} %>
        </tr>
        
        <tr class="trHdr01">
          <th class="th02" rowspan=2>Units</th>
          <th class="th02" rowspan=2>Cost</th>
          <th class="th02" rowspan=2>Retail</th>
          
          <th class="th02" rowspan=2>Units</th>
          <th class="th02" rowspan=2>Cost</th>
          <th class="th02" rowspan=2>Retail</th>  
            
          <%for(int j=0; j < iCal; j++){%>
            <th class="th02" colspan=2>Units</th>
          	<th class="th02" colspan=2>Cost</th>
          	<th class="th02" colspan=2>Retail</th>
          <%} %>          
        </tr>
        
        <tr class="trHdr01">
          <%for(int j=0; j < iCal; j++){%>
            <th class="th02"><a href="javascript: reSort('ADJQTY<%=j+1%>UP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
            <th class="th02"><a href="javascript: reSort('ADJQTY<%=j+1%>DW')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
          	<th class="th02"><a href="javascript: reSort('ADJCOST<%=j+1%>UP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
          	<th class="th02"><a href="javascript: reSort('ADJCOST<%=j+1%>DW')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
          	<th class="th02"><a href="javascript: reSort('ADJRET<%=j+1%>UP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
          	<th class="th02"><a href="javascript: reSort('ADJRET<%=j+1%>DW')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
          	
          	<th class="th02"><a href="javascript: reSort('SHRINK<%=j+1%>UP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
          	<th class="th02"><a href="javascript: reSort('SHRINK<%=j+1%>DW')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
          <%} %>
        </tr>
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfGrp; i++) {        	   
        	vensum.setDetail();
   			String sGrp = vensum.getGrp();
   			String sGrpNm = vensum.getGrpNm();
   			String sStr = vensum.getStr();
   			String sDiv = vensum.getDiv();
   			String sDpt = vensum.getDpt();
   			String sCls = vensum.getCls();
   			String sVen = vensum.getVen();
   			String [] sRet = vensum.getRet();
   			String [] sBookQty = vensum.getBookQty();
   			String [] sBookRet = vensum.getBookRet();
   			String [] sBookCost = vensum.getBookCost();
   			String [] sCompQty = vensum.getCompQty();
   			String [] sCompRet = vensum.getCompRet();
   			String [] sCompCost = vensum.getCompCost();
   			String [] sAdjQty = vensum.getAdjQty();
   			String [] sAdjRet = vensum.getAdjRet();
   			String [] sAdjCost = vensum.getAdjCost();
   			String [] sShrink = vensum.getShrink();
   			
   			//if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
   			//else {sTrCls = "trDtl06";}
   			
   			String [] sPiYrClr = new String[]{"#d6f2d9", "#d9d6b1", "#d4d4fb" };
           %>                           
           <tr id="trGrp<%=i%>" class="<%=sTrCls%>">
             <td id="tdGrp<%=i%>" class="td12" nowrap>
                <%if(!sSelCls.equals("ALL") && sLevel.equals("D")){%>
             		<a id='alink<%=i%>' href="javascript: drilldownCVS('<%=i%>')"><%=sGrp%></a>
             	<%}
             	else {%>
             		<a id='alink<%=i%>' href="javascript: drilldown('<%=i%>')"><%=sGrp%></a>
             	<%}%>
             </td>
             <td id="trGrpNm<%=i%>" class="td11" nowrap><%=sGrpNm%></td>
             <td class="td43">&nbsp;</td>             
             <td class="td12" nowrap><%=sCompQty[0]%></td>
             <td class="td12" nowrap>$<%=sCompCost[0]%></td>
             <td class="td12" nowrap>$<%=sCompRet[0]%></td>
             
             <td class="td43">&nbsp;</td>
             <td class="td12" nowrap><%=sBookQty[0]%></td>
             <td class="td12" nowrap>$<%=sBookCost[0]%></td>
             <td class="td12" nowrap>$<%=sBookRet[0]%></td>
                          	             
             <%for(int j=0; j < iCal; j++){%>
                <td class="td43">&nbsp;</td>
                <td class="td12" style="background: <%=sPiYrClr[j]%>" colspan=2 nowrap><%=sAdjQty[j]%></td>
             	<td class="td12" style="background: <%=sPiYrClr[j]%>" colspan=2 nowrap>$<%=sAdjCost[j]%></td>
             	<td class="td12" style="background: <%=sPiYrClr[j]%>" colspan=2 nowrap>$<%=sAdjRet[j]%></td>
             	<td class="td12" style="background: <%=sPiYrClr[j]%>" nowrap>$<%=sRet[j]%></td>
             	<td class="td12" style="background: <%=sPiYrClr[j]%>" colspan=2 nowrap><%=sShrink[j]%>%</td>
             <%}%>
             <%if(!sGrpHdr.equals("Vendor") && !sGrpHdr.equals("Store")){%>
          	 	<td class="td43"><a href="javascript: drilldownCVS('<%=i%>')">D</a></td>
          	 <%}%>             
           </tr>
              <script></script>	
           <%}%>
           
           
            
           <!-- ======Total ================ -->
           <%
            vensum.setTotals();
            String [] sRet = vensum.getRet();
  			String [] sBookQty = vensum.getBookQty();
  			String [] sBookRet = vensum.getBookRet();
  			String [] sBookCost = vensum.getBookCost();
  			String [] sCompQty = vensum.getCompQty();
  			String [] sCompRet = vensum.getCompRet();
  			String [] sCompCost = vensum.getCompCost();
  			String [] sAdjQty = vensum.getAdjQty();
  			String [] sAdjRet = vensum.getAdjRet();
  			String [] sAdjCost = vensum.getAdjCost();
  			String [] sShrink = vensum.getShrink();
           %>
		   <tr id="trTotal" class="trDtl15">
             <td class="td12" nowrap colspan=2>Totals:</td>
             <td class="td43">&nbsp;</td>              
             <td class="td12" nowrap><%=sCompQty[0]%></td>
             <td class="td12" nowrap>$<%=sCompCost[0]%></td>
             <td class="td12" nowrap>$<%=sCompRet[0]%></td>
             
             <td class="td43">&nbsp;</td>
             <td class="td12" nowrap><%=sBookQty[0]%></td>
             <td class="td12" nowrap>$<%=sBookCost[0]%></td>
             <td class="td12" nowrap>$<%=sBookRet[0]%></td>
             	             
             <%for(int j=0; j < iCal; j++){%>
                <td class="td43">&nbsp;</td>
                <td class="td12" colspan=2 nowrap><%=sAdjQty[j]%></td>
             	<td class="td12" colspan=2 nowrap>$<%=sAdjCost[j]%></td>
             	<td class="td12" colspan=2 nowrap>$<%=sAdjRet[j]%></td>
             	<td class="td12" nowrap>$<%=sRet[j]%></td>
             	<td class="td12" colspan=2 nowrap><%=sShrink[j]%>%</td>
             <%}%>  
             <%if(!sGrpHdr.equals("Vendor") && !sGrpHdr.equals("Store")){%>
          	 	<td class="td43">&nbsp;</td>
          	 <%}%> 
           </tr>
           
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
vensum.disconnect();
vensum = null;
}
%>