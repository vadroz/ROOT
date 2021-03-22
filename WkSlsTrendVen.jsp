<%@ page import="salesreport3.WkSlsTrendVen, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String [] sSelDiv = request.getParameterValues("Div");   
   String sSelDpt = request.getParameter("Dpt");
   String sSelCls = request.getParameter("Cls");
   String sSelVen = request.getParameter("Ven");
   String sSelVenNm = request.getParameter("VenNm");
   String sFromDt = request.getParameter("FromDt");   
   String sToDt = request.getParameter("ToDt");
   String sLevel = request.getParameter("Level");
   String sAmtType = request.getParameter("selAmtType");
   String sInclClrSls = request.getParameter("InclClrSls");
   String sSort = request.getParameter("Sort");
   
   
   if(sSelDpt == null){ sSelDpt = "ALL"; }
   if(sSelCls == null){ sSelCls = "ALL"; }
   
   if(sLevel == null){ sLevel = "S"; }
   if(sInclClrSls == null){ sInclClrSls = "N"; }
   if(sSort == null){ sSort = "Grp"; }
   if(sAmtType == null){ sAmtType = "R"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=WkSlsTrendVen.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	 
	WkSlsTrendVen vensum = new WkSlsTrendVen();
	
	/*System.out.println("|" + sSelDiv[0] + "|" + sSelDpt + "|" + sSelCls + "|" + sSelVen
		 + "|" + sSelStr[0] + "|"  
		 + "|" + sLevel + "|" + sInclClrSls + "|" + sSort + "|" + sUser);
	*/
	vensum.setVenSum(sSelDiv, sSelDpt, sSelCls, sSelVen, sSelStr, sFromDt, sToDt
			, sLevel, sAmtType, sInclClrSls, sSort);	
		
	int iNumOfGrp = vensum.getNumOfGrp();
	int iNumOfDmm = vensum.getNumOfDmm();
	String [] sDmmNm = vensum.getDmmNm();
	
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
		if(sSelCls.equals("ALL") && sSelVen.equals("ALL")){ sALinkTxt[1] = "By Ven"; sALinkVal[1] = "switchGrpVen()";}
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
   
   String sSelStrJsa =  vensum.cvtToJavaScriptArray(sSelStr);
   String sSelDivJsa =  vensum.cvtToJavaScriptArray(sSelDiv);
   
   boolean bRet = true;
   if(sAmtType.equals("U")){ bRet = false;}
   boolean bClr = false;
   if(sInclClrSls.equals("Y")){ bClr = true;}
   
   
   boolean b2date = true;
   if(sFromDt.equals("NONE")){ b2date = false;}
   
   int iSpanGM1 = 14;
   if(b2date){iSpanGM1 = 4; }
   int iSpanGM2 = 14;
   if(b2date){iSpanGM2 = 2; }
   int iSpanGM3 = 4;
   if(b2date){iSpanGM3 = 2; }
   int iSpanGM4 = 5;
   if(sAmtType.equals("U")){ iSpanGM4 = 4; }
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Wk Trend Comp</title>

<SCRIPT>

//--------------- Global variables -----------------------
var SelStr = [<%=sSelStrJsa%>];
var SelDiv = [<%=sSelDivJsa%>];
var SelDpt = "<%=sSelDpt%>";
var SelCls = "<%=sSelCls%>";
var SelVen = "<%=sSelVen%>";
var SelVenNm = "<%=sSelVenNm%>";

var FromDt = "<%=sFromDt%>";
var ToDt = "<%=sToDt%>";
var Level = "<%=sLevel%>";
var InclClrSls = "<%=sInclClrSls%>";
var Sort = "<%=sSort%>";
var User = "<%=sUser%>";
var NumOfGrp = "<%=iNumOfGrp%>";
var ArrStr = [<%=sStrJsa%>];
var GrpHdr = "<%=sGrpHdr%>";
var AmtType = "<%=sAmtType%>";

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
	var url = "WkSlsTrendVen.jsp?" 
	 + "FromDt=" + FromDt + "&ToDt=" + ToDt
	 + "&selAmtType=" + AmtType
	 + "&Level=" + Level + "&InclClrSls=" + InclClrSls + "&Sort=" + sort;
	 
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
	var url = "WkSlsTrendVen.jsp?FromDt=" + FromDt + "&ToDt=" + ToDt
	  + "&selAmtType=" + AmtType
	  + "&Level=D&InclClrSls=" + InclClrSls + "&Sort=" + Sort;
	 
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
	var url = "WkSlsTrendVen.jsp?FromDt=" + FromDt + "&ToDt=" + ToDt
	 + "&selAmtType=" + AmtType
	 + "&Level=S&InclClrSls=" + InclClrSls + "&Sort=" + Sort;
	
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
	var url = "WkSlsTrendVen.jsp?FromDt=" + FromDt + "&ToDt=" + ToDt
      + "&selAmtType=" + AmtType
	  + "&Level=V&InclClrSls=" + InclClrSls + "&Sort=" + Sort;
	
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
	var url = "WkSlsTrendVen.jsp?FromDt=" + FromDt + "&ToDt=" + ToDt
	 + "&selAmtType=" + AmtType
	 + "&InclClrSls=" + InclClrSls + "&Sort=" + Sort;
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
            <br>Sales Trend by Class Report  
            
            <%String sComa=""; %>
            <br> Store: <%for(int i=0; i < sSelStr.length; i++){%><%=sComa + sSelStr[i]%><%sComa = ",";%><%}%>
            <%sComa=""; %>
            <br> Divison: <%for(int i=0; i < sSelDiv.length; i++){%><%=sComa + sSelDiv[i]%><%sComa = ",";%><%}%>
            <%if(!sSelDpt.equals("ALL")){%>, Department: <%=sSelDpt%><%}%>
            <%if(!sSelCls.equals("ALL")){%>, Class: <%=sSelCls%><%}%>
            <%if(!sSelVen.equals("ALL")){%>, Vendor: <%=sSelVen%><%}%>
            <br><%if(!sFromDt.equals("NONE")){%>From Date: <%=sFromDt%>&nbsp;&nbsp;To <%}%>            
            Date: <%=sToDt%>                        
            <%if(bClr){%><br>Clearance Sales<%}%>
            </b>            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="WkSlsTrendVenSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02" rowspan=3 nowrap><a href="javascript: reSort('Grp')"><%=sGrpHdr%></a><br><br>
             <a href="javascript: <%=sALinkVal[0]%>"><%=sALinkTxt[0]%></a>
             <br><a href="javascript: <%=sALinkVal[1]%>"><%=sALinkTxt[1]%></a>
          </th>
          <th class="th02" rowspan=3 ><%=sGrpNmHdr%></th>
          <th class="th02" rowspan=3 >&nbsp;</th>
          <th class="th02" rowspan=2 colspan=4><%if(bRet){%>Retail<%} else {%>Unit<%}%> <%if(bClr){%>Clearance<%}%> Sales<br>Week Ending Date</th>  
                  
          <%if(!b2date){%>
          <th class="th02" rowspan=3 >&nbsp;</th>
          <th class="th02" rowspan=2 colspan=4><%if(bRet){%>Retail<%} else {%>Unit<%}%> <%if(bClr){%>Clearance<%}%> Sales<br>Month Ending Date</th>
          <th class="th02" rowspan=3 >&nbsp;</th>
          <th class="th02" rowspan=2 colspan=<%=iSpanGM4%>><%if(bRet){%>Retail<%} else {%>Unit<%}%> <%if(bClr){%>Clearance<%}%> Inventory<br>On Hand</th>  
          <th class="th02" rowspan=3 >&nbsp;</th>        
          <th class="th02" rowspan=2 colspan=4><%if(bRet){%>Retail<%} else {%>Unit<%}%> <%if(bClr){%>Clearance<%}%> Sales<br>Year Ending Date</th>
          <%}%>
          <th class="th02" rowspan=3 >&nbsp;</th>        
          <th class="th02" colspan=<%=iSpanGM1%> >Gross Margin Dollars</th>
          <th class="th02" rowspan=3 >&nbsp;</th>        
          <th class="th02" colspan=<%=iSpanGM2%> >Gross Margin Percents</th>          
        </tr>  
        
        <tr class="trHdr01">          
          <th class="th02" colspan=4 >Week</th>
          <%if(!b2date){%>
          <th class="th02" rowspan=2 >&nbsp;</th>
          <th class="th02" colspan=4 >Month</th>
          <th class="th02" rowspan=2 >&nbsp;</th>
          <th class="th02" colspan=4 >Year</th>
          <%}%>
          <th class="th02" colspan=<%=iSpanGM3%>>Week</th>
          <%if(!b2date){%>
          <th class="th02" rowspan=2 >&nbsp;</th>
          <th class="th02" colspan=4 >Month</th>
          <th class="th02" rowspan=2 >&nbsp;</th>
          <th class="th02" colspan=4 >Year</th>
          <%}%>
        </tr>
        
        <tr class="trHdr01">
          <th class="th02"><a href="javascript: reSort('TYWK')">TY</a></th>
          <th class="th02"><a href="javascript: reSort('LYWK')">LY</a></th>
          <th class="th02"><a href="javascript: reSort('WKVAR')">Var($)</a></th>
          <th class="th02"><a href="javascript: reSort('WKVPR')">Var(%)</th>
          <%if(!b2date){%>
          <th class="th02"><a href="javascript: reSort('TYMN')">TY</a></th>
          <th class="th02"><a href="javascript: reSort('LYMN')">LY</a></th>
          <th class="th02"><a href="javascript: reSort('MNVAR')">Var($)</a></th>
          <th class="th02"><a href="javascript: reSort('MNVPR')">Var(%)</th>
          
          
          <th class="th02"><a href="javascript: reSort('TYINV')">TY</a></th>
          <th class="th02"><a href="javascript: reSort('LYINV')">LY</a></th>
          <th class="th02"><a href="javascript: reSort('INVVAR')">Var($)</a></th>
          <th class="th02"><a href="javascript: reSort('INVVPR')">Var(%)</th>
          <%if(bRet){%><th class="th02"><a href="javascript: reSort('STOCKRATIO')">Stock<br>/Sales<br>Ratio</th><%}%>
          
          <th class="th02"><a href="javascript: reSort('TYYR')">TY</a></th>
          <th class="th02"><a href="javascript: reSort('LYYR')">LY</a></th>
          <th class="th02"><a href="javascript: reSort('YRVAR')">Var($)</a></th>
          <th class="th02"><a href="javascript: reSort('YRVPR')">Var(%)</th>
          <%}%>     
          <!-- ======= Gross Margin $ -->          
          <th class="th02"><a href="javascript: reSort('TYWKGMA')">TY</a></th>
          <th class="th02"><a href="javascript: reSort('LYWKGMA')">LY</a></th>
          <th class="th02"><a href="javascript: reSort('WKGMAVAR')">Var($)</a></th>
          <th class="th02"><a href="javascript: reSort('WKGMAVPR')">Var(%)</th>
          <%if(!b2date){%>
          <th class="th02"><a href="javascript: reSort('TYMNGMA')">TY</a></th>
          <th class="th02"><a href="javascript: reSort('LYMNGMA')">LY</a></th>
          <th class="th02"><a href="javascript: reSort('MNGMAVAR')">Var($)</a></th>
          <th class="th02"><a href="javascript: reSort('MNGMAVPR')">Var(%)</th>
          
          <th class="th02"><a href="javascript: reSort('TYYRGMA')">TY</a></th>
          <th class="th02"><a href="javascript: reSort('LYYRGMA')">LY</a></th>
          <th class="th02"><a href="javascript: reSort('YRGMAVAR')">Var($)</a></th>
          <th class="th02"><a href="javascript: reSort('YRGMAVPR')">Var(%)</th>
          <%} %>
          <!-- ======= Gross Margin % -->          
          <th class="th02"><a href="javascript: reSort('TYWKGMP')">TY</a></th>
          <th class="th02"><a href="javascript: reSort('LYWKGMP')">LY</a></th>
          
          <%if(!b2date){%>
          <th class="th02"><a href="javascript: reSort('WKGMPVAR')">Var($)</a></th>
          <th class="th02"><a href="javascript: reSort('WKGMPVPR')">Var(%)</th>
          
          <th class="th02"><a href="javascript: reSort('TYMNGMP')">TY</a></th>
          <th class="th02"><a href="javascript: reSort('LYMNGMP')">LY</a></th>
          <th class="th02"><a href="javascript: reSort('MNGMPVAR')">Var($)</a></th>
          <th class="th02"><a href="javascript: reSort('MNGMPVPR')">Var(%)</th>
          
          <th class="th02"><a href="javascript: reSort('TYYRGMP')">TY</a></th>
          <th class="th02"><a href="javascript: reSort('LYYRGMP')">LY</a></th>
          <th class="th02"><a href="javascript: reSort('YRGMPVAR')">Var($)</a></th>
          <th class="th02"><a href="javascript: reSort('YRGMPVPR')">Var(%)</th>
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
   			
   			String [] sNsr = vensum.getNsr();
			String [] sGmp = vensum.getGmp();
			String [] sCir = vensum.getCir();
			
			String [] sVarNsr = vensum.getVarNsr();
			String [] sVarGmp = vensum.getVarGmp();
			String [] sVarCir = vensum.getVarCir();
			 
			String [] sVprNsr = vensum.getVprNsr();
			String [] sVprGmp = vensum.getVprGmp();   
			String [] sVprCir = vensum.getVprCir();     
			
			String [] sGmpSal = vensum.getGmpSal();
			String [] sVarGmpSal = vensum.getVarGmpSal();
			String [] sVprGmpSal = vensum.getVprGmpSal();
			String [] sStockRatio = vensum.getStockRatio();
   			
   			String [] sPiYrClr = new String[]{"#d6f2d9", "#d9d6b1", "#d4d4fb" };
           %>                           
           <tr id="trGrp<%=i%>" class="<%=sTrCls%>">
             <td id="tdGrp<%=i%>" class="td12" nowrap>
                <%if(!sSelCls.equals("ALL") && sLevel.equals("D")){%><%=sGrp%><%
                } else {%>
             		<a id='alink<%=i%>' href="javascript: drilldown('<%=i%>')"><%=sGrp%></a>
             	<%}%>
             </td>
             <td id="trGrpNm<%=i%>" class="td11" nowrap><%=sGrpNm%></td>
             <td class="td43">&nbsp;</td>             
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[0]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[3]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sVarNsr[0]%></td>
             <td class="td12" nowrap><%if(bRet){%><%}%><%=sVprNsr[0]%>%</td>
             <td class="td43">&nbsp;</td>
             
             <%if(!b2date){%>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[1]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[4]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sVarNsr[1]%></td>
             <td class="td12" nowrap><%=sVprNsr[1]%>%</td>
             <td class="td43">&nbsp;</td>             
             
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sCir[0]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sCir[3]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sVarCir[0]%></td>
             <td class="td12" nowrap><%=sVprCir[0]%>%</td>
             <%if(bRet){%><td class="td12" nowrap><%=sStockRatio[0]%></td><%}%>
             <td class="td43">&nbsp;</td>
             
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[2]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[5]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sVarNsr[2]%></td>
             <td class="td12" nowrap><%=sVprNsr[2]%>%</td>
             <td class="td43">&nbsp;</td>
             <%} %>
             <!-- ========= Dross Margin Dollars ========== -->
             <td class="td12" nowrap>$<%=sGmp[0]%></td>
             <td class="td12" nowrap>$<%=sGmp[3]%></td>
             <td class="td12" nowrap>$<%=sVarGmp[0]%></td>
             <td class="td12" nowrap><%=sVprGmp[0]%>%</td>
             <td class="td43">&nbsp;</td>
            
             <%if(!b2date){%> 
             <td class="td12" nowrap>$<%=sGmp[1]%></td>
             <td class="td12" nowrap>$<%=sGmp[4]%></td>
             <td class="td12" nowrap>$<%=sVarGmp[1]%></td>
             <td class="td12" nowrap><%=sVprGmp[1]%>%</td>
             <td class="td43">&nbsp;</td>
              
             <td class="td12" nowrap>$<%=sGmp[2]%></td>
             <td class="td12" nowrap>$<%=sGmp[5]%></td>
             <td class="td12" nowrap>$<%=sVarGmp[2]%></td>
             <td class="td12" nowrap><%=sVprGmp[2]%>%</td>
             <td class="td43">&nbsp;</td>
             <%} %>
             <!-- ========= Dross Margin Percent ========== -->
             <td class="td12" nowrap><%=sGmpSal[0]%>%</td>
             <td class="td12" nowrap><%=sGmpSal[3]%>%</td>
             
             <%if(!b2date){%>
             <td class="td12" nowrap><%=sVarGmpSal[0]%>%</td>
             <td class="td12" nowrap><%=sVprGmpSal[0]%>%</td> 
             
             <td class="td43">&nbsp;</td>
             <td class="td12" nowrap><%=sGmpSal[1]%>%</td>
             <td class="td12" nowrap><%=sGmpSal[4]%>%</td>
             <td class="td12" nowrap><%=sVarGmpSal[1]%>%</td>
             <td class="td12" nowrap><%=sVprGmpSal[1]%>%</td>
             <td class="td43">&nbsp;</td>
              
             <td class="td12" nowrap><%=sGmpSal[2]%>%</td>
             <td class="td12" nowrap><%=sGmpSal[5]%>%</td>
             <td class="td12" nowrap><%=sVarGmpSal[2]%>%</td>
             <td class="td12" nowrap><%=sVprGmpSal[2]%>%</td>
             <%} %>             
           </tr>
              <script></script>	
           <%}%>
          
          
          
          
        <!-- ====== Mall/Non-mall Total ================ -->
        <%if(sLevel.equals("S")){ %>
           <tr id="trTotal" class="Divider">
             <td colspan=53>&nbsp;</td> 
           </tr> 
           <%for(int i=0; i < 2; i++){%>
           
           <%
            vensum.setMallTot();
           	String [] sNsr = vensum.getNsr();
			String [] sGmp = vensum.getGmp();
			String [] sCir = vensum.getCir();
			
			String [] sVarNsr = vensum.getVarNsr();
			String [] sVarGmp = vensum.getVarGmp();
			String [] sVarCir = vensum.getVarCir();
			 
			String [] sVprNsr = vensum.getVprNsr();
			String [] sVprGmp = vensum.getVprGmp();   
			String [] sVprCir = vensum.getVprCir();     
			
			String [] sGmpSal = vensum.getGmpSal();
			String [] sVarGmpSal = vensum.getVarGmpSal();
			String [] sVprGmpSal = vensum.getVprGmpSal();
			String [] sStockRatio = vensum.getStockRatio();
			
			 
           %>
		   <tr id="trTotal" class="trDtl16">
             <td class="td11" nowrap colspan=2><%if(i==0){%>Mall<%} else {%>Non-Mall<%}%></td>
             <td class="td43">&nbsp;</td>              
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[0]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[3]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sVarNsr[0]%></td>
             <td class="td12" nowrap><%=sVprNsr[0]%>%</td>
             <td class="td43">&nbsp;</td>
             
             <%if(!b2date){%>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[1]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[4]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sVarNsr[1]%></td>
             <td class="td12" nowrap><%=sVprNsr[1]%>%</td>
             <td class="td43">&nbsp;</td>             
             
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sCir[0]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sCir[3]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sVarCir[0]%></td>
             <td class="td12" nowrap><%=sVprCir[0]%>%</td>
             <%if(bRet ){%><td class="td12" nowrap><%=sStockRatio[0]%></td><%}%>
             <td class="td43">&nbsp;</td>
             
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[2]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[5]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sVarNsr[2]%></td>
             <td class="td12" nowrap><%=sVprNsr[2]%>%</td>             
             <td class="td43">&nbsp;</td>
             <%} %>
             <!-- ========= Dross Margin Dollars ========== -->
             <td class="td12" nowrap>$<%=sGmp[0]%></td>
             <td class="td12" nowrap>$<%=sGmp[3]%></td>
             <td class="td12" nowrap>$<%=sVarGmp[0]%></td>
             <td class="td12" nowrap><%=sVprGmp[0]%>%</td>
             <td class="td43">&nbsp;</td>
             
             <%if(!b2date){%>
             <td class="td12" nowrap>$<%=sGmp[1]%></td>
             <td class="td12" nowrap>$<%=sGmp[4]%></td>
             <td class="td12" nowrap>$<%=sVarGmp[1]%></td>
             <td class="td12" nowrap><%=sVprGmp[1]%>%</td>
             <td class="td43">&nbsp;</td>
              
             <td class="td12" nowrap>$<%=sGmp[2]%></td>
             <td class="td12" nowrap>$<%=sGmp[5]%></td>
             <td class="td12" nowrap>$<%=sVarGmp[2]%></td>
             <td class="td12" nowrap><%=sVprGmp[2]%>%</td>
             <td class="td43">&nbsp;</td>
             <%} %>
             
             <!-- ========= Dross Margin Percent ========== -->
             <td class="td12" nowrap><%=sGmpSal[0]%>%</td>
             <td class="td12" nowrap><%=sGmpSal[3]%>%</td>
             <%if(!b2date){%> 
             <td class="td12" nowrap><%=sVarGmpSal[0]%>%</td>
             <td class="td12" nowrap><%=sVprGmpSal[0]%>%</td>
             
             <td class="td43">&nbsp;</td>
             <td class="td12" nowrap><%=sGmpSal[1]%>%</td>
             <td class="td12" nowrap><%=sGmpSal[4]%>%</td>
             <td class="td12" nowrap><%=sVarGmpSal[1]%>%</td>
             <td class="td12" nowrap><%=sVprGmpSal[1]%>%</td>
             <td class="td43">&nbsp;</td>
              
             <td class="td12" nowrap><%=sGmpSal[2]%>%</td>
             <td class="td12" nowrap><%=sGmpSal[5]%>%</td>
             <td class="td12" nowrap><%=sVarGmpSal[2]%>%</td>
             <td class="td12" nowrap><%=sVprGmpSal[2]%>%</td> 
             <%}%>
           </tr>
           <%}%>
        <%}%>
        
        
        <!-- ====== DMM Total ================ -->
        <%if(sSelDiv[0].equals("ALL") && sLevel.equals("D")){ %>
        	<tr id="trTotal" class="Divider">
             <td colspan=53>&nbsp;</td> 
          	</tr> 
           <%for(int i=0; i < iNumOfDmm; i++){%>
           
           <%
            vensum.setDmmTot();
           	String [] sNsr = vensum.getNsr();
			String [] sGmp = vensum.getGmp();
			String [] sCir = vensum.getCir();
			
			String [] sVarNsr = vensum.getVarNsr();
			String [] sVarGmp = vensum.getVarGmp();
			String [] sVarCir = vensum.getVarCir();
			 
			String [] sVprNsr = vensum.getVprNsr();
			String [] sVprGmp = vensum.getVprGmp();   
			String [] sVprCir = vensum.getVprCir();     
			
			String [] sGmpSal = vensum.getGmpSal();
			String [] sVarGmpSal = vensum.getVarGmpSal();
			String [] sVprGmpSal = vensum.getVprGmpSal();
			String [] sStockRatio = vensum.getStockRatio();
			
			 
           %>
		   <tr id="trTotal" class="trDtl16">
             <td class="td11" nowrap colspan=2><%=sDmmNm[i]%></td>
             <td class="td43">&nbsp;</td>              
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[0]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[3]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sVarNsr[0]%></td>
             <td class="td12" nowrap><%=sVprNsr[0]%>%</td>
             <td class="td43">&nbsp;</td>
             
             <%if(!b2date){%>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[1]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[4]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sVarNsr[1]%></td>
             <td class="td12" nowrap><%=sVprNsr[1]%>%</td>
             <td class="td43">&nbsp;</td>             
             
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sCir[0]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sCir[3]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sVarCir[0]%></td>
             <td class="td12" nowrap><%=sVprCir[0]%>%</td>
             <%if(bRet ){%><td class="td12" nowrap><%=sStockRatio[0]%></td><%} %>
             <td class="td43">&nbsp;</td>
             
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[2]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[5]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sVarNsr[2]%></td>
             <td class="td12" nowrap><%=sVprNsr[2]%>%</td>             
             <td class="td43">&nbsp;</td>
             <%} %>
             <!-- ========= Dross Margin Dollars ========== -->
             <td class="td12" nowrap>$<%=sGmp[0]%></td>
             <td class="td12" nowrap>$<%=sGmp[3]%></td>
             <td class="td12" nowrap>$<%=sVarGmp[0]%></td>
             <td class="td12" nowrap><%=sVprGmp[0]%>%</td>
             <td class="td43">&nbsp;</td>
             
             <%if(!b2date){%>
             <td class="td12" nowrap>$<%=sGmp[1]%></td>
             <td class="td12" nowrap>$<%=sGmp[4]%></td>
             <td class="td12" nowrap>$<%=sVarGmp[1]%></td>
             <td class="td12" nowrap><%=sVprGmp[1]%>%</td>
             <td class="td43">&nbsp;</td>
              
             <td class="td12" nowrap>$<%=sGmp[2]%></td>
             <td class="td12" nowrap>$<%=sGmp[5]%></td>
             <td class="td12" nowrap>$<%=sVarGmp[2]%></td>
             <td class="td12" nowrap><%=sVprGmp[2]%>%</td>
             <td class="td43">&nbsp;</td>
             <%} %>
             
             <!-- ========= Dross Margin Percent ========== -->
             <td class="td12" nowrap><%=sGmpSal[0]%>%</td>
             <td class="td12" nowrap><%=sGmpSal[3]%>%</td>
             <%if(!b2date){%> 
             <td class="td12" nowrap><%=sVarGmpSal[0]%>%</td>
             <td class="td12" nowrap><%=sVprGmpSal[0]%>%</td>
             
             <td class="td43">&nbsp;</td>
             <td class="td12" nowrap><%=sGmpSal[1]%>%</td>
             <td class="td12" nowrap><%=sGmpSal[4]%>%</td>
             <td class="td12" nowrap><%=sVarGmpSal[1]%>%</td>
             <td class="td12" nowrap><%=sVprGmpSal[1]%>%</td>
             <td class="td43">&nbsp;</td>
              
             <td class="td12" nowrap><%=sGmpSal[2]%>%</td>
             <td class="td12" nowrap><%=sGmpSal[5]%>%</td>
             <td class="td12" nowrap><%=sVarGmpSal[2]%>%</td>
             <td class="td12" nowrap><%=sVprGmpSal[2]%>%</td> 
             <%}%>
           </tr>
           <%}%>
        <%}%>   
            
           <!-- ======Total ================ -->
          <tr id="trTotal" class="Divider">
             <td colspan=53>&nbsp;</td> 
          </tr>  
           
           <%
            vensum.setTotals();
           String [] sNsr = vensum.getNsr();
			String [] sGmp = vensum.getGmp();
			String [] sCir = vensum.getCir();
			
			String [] sVarNsr = vensum.getVarNsr();
			String [] sVarGmp = vensum.getVarGmp();
			String [] sVarCir = vensum.getVarCir();
			 
			String [] sVprNsr = vensum.getVprNsr();
			String [] sVprGmp = vensum.getVprGmp();   
			String [] sVprCir = vensum.getVprCir();     
			
			String [] sGmpSal = vensum.getGmpSal();
			String [] sVarGmpSal = vensum.getVarGmpSal();
			String [] sVprGmpSal = vensum.getVprGmpSal();
			String [] sStockRatio = vensum.getStockRatio();
			
			 
           %>
		   <tr id="trTotal" class="trDtl15">
             <td class="td12" nowrap colspan=2>Totals:</td>
             <td class="td43">&nbsp;</td>              
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[0]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[3]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sVarNsr[0]%></td>
             <td class="td12" nowrap><%=sVprNsr[0]%>%</td>
             <td class="td43">&nbsp;</td>
             
             <%if(!b2date){%>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[1]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[4]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sVarNsr[1]%></td>
             <td class="td12" nowrap><%=sVprNsr[1]%>%</td>
             <td class="td43">&nbsp;</td>             
             
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sCir[0]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sCir[3]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sVarCir[0]%></td>
             <td class="td12" nowrap><%=sVprCir[0]%>%</td>
             <%if(bRet){%><td class="td12" nowrap><%=sStockRatio[0]%></td><%}%>
             <td class="td43">&nbsp;</td>
             
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[2]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sNsr[5]%></td>
             <td class="td12" nowrap><%if(bRet){%>$<%}%><%=sVarNsr[2]%></td>
             <td class="td12" nowrap><%=sVprNsr[2]%>%</td>             
             <td class="td43">&nbsp;</td>
             <%} %>
             <!-- ========= Dross Margin Dollars ========== -->
             <td class="td12" nowrap>$<%=sGmp[0]%></td>
             <td class="td12" nowrap>$<%=sGmp[3]%></td>
             <td class="td12" nowrap>$<%=sVarGmp[0]%></td>
             <td class="td12" nowrap><%=sVprGmp[0]%>%</td>
             <td class="td43">&nbsp;</td>
             
             <%if(!b2date){%>
             <td class="td12" nowrap>$<%=sGmp[1]%></td>
             <td class="td12" nowrap>$<%=sGmp[4]%></td>
             <td class="td12" nowrap>$<%=sVarGmp[1]%></td>
             <td class="td12" nowrap><%=sVprGmp[1]%>%</td>
             <td class="td43">&nbsp;</td>
              
             <td class="td12" nowrap>$<%=sGmp[2]%></td>
             <td class="td12" nowrap>$<%=sGmp[5]%></td>
             <td class="td12" nowrap>$<%=sVarGmp[2]%></td>
             <td class="td12" nowrap><%=sVprGmp[2]%>%</td>
             <td class="td43">&nbsp;</td>
             <%} %>
             
             <!-- ========= Dross Margin Percent ========== -->
             <td class="td12" nowrap><%=sGmpSal[0]%>%</td>
             <td class="td12" nowrap><%=sGmpSal[3]%>%</td>
             <%if(!b2date){%> 
             <td class="td12" nowrap><%=sVarGmpSal[0]%>%</td>
             <td class="td12" nowrap><%=sVprGmpSal[0]%>%</td>
             
             <td class="td43">&nbsp;</td>
             <td class="td12" nowrap><%=sGmpSal[1]%>%</td>
             <td class="td12" nowrap><%=sGmpSal[4]%>%</td>
             <td class="td12" nowrap><%=sVarGmpSal[1]%>%</td>
             <td class="td12" nowrap><%=sVprGmpSal[1]%>%</td>
             <td class="td43">&nbsp;</td>
              
             <td class="td12" nowrap><%=sGmpSal[2]%>%</td>
             <td class="td12" nowrap><%=sGmpSal[5]%>%</td>
             <td class="td12" nowrap><%=sVarGmpSal[2]%>%</td>
             <td class="td12" nowrap><%=sVprGmpSal[2]%>%</td> 
             <%}%>
           </tr>
           
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
   <p style="font-size: 10px;">
   IT Note:  Data from SLWKAR (using div/dpt from IPCLASS).
 </body>
</html>
<%
vensum.disconnect();
vensum = null;
}
%>