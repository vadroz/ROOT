<%@ page import="flashreps.FlashSlsGender, java.util.*, rciutility.StoreSelect
, rciutility.RunSQLStmt, java.sql.*,java.util.*, java.text.*"%>
<%
   	String sStore = request.getParameter("Str");
	String sDiv = request.getParameter("Div");
	String sDpt = request.getParameter("Dpt");
	String sCls = request.getParameter("Cls");
   	String sFrom = request.getParameter("FrDate");
   	String sTo = request.getParameter("ToDate");
   	String sYear = request.getParameter("Year");
   	String sMonth = request.getParameter("Month");
   	String sLevel = request.getParameter("Level");
   	String sDatLvl = request.getParameter("DatLvl");   
   	String sSort = request.getParameter("Sort");

   	if(sStore==null || sStore.equals("")) { sStore="ALL"; }
   	if(sDiv==null || sDiv.equals("")) { sDiv="ALL"; }
   	if(sDpt==null || sDpt.equals("")) { sDpt="ALL"; }
   	if(sCls==null || sCls.equals("")) { sCls="ALL"; }
   	if(sFrom==null || sFrom.equals("")) { sFrom="LAST"; }
   	if(sTo==null || sTo.equals("")) { sTo="LAST"; }
   	if(sYear==null || sYear.equals("")) { sYear="ALL"; }
   	if(sMonth==null || sMonth.equals("")) { sMonth="ALL"; }
   	if(sLevel==null || sLevel.equals("")) { sLevel="Str"; }
   	if(sDatLvl==null || sDatLvl.equals("")) { sDatLvl="None"; }   	
   	if(sSort==null || sSort.equals("")) { sSort="GRP"; }
   	
   
String sAppl="BASIC1";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=FlashSlsGender.jsp&APPL=" + sAppl + "&" + request.getQueryString());
}
else
{
   String sStrAllowed = session.getAttribute("STORE").toString();
   String sUser = session.getAttribute("USER").toString();
   
   FlashSlsGender flashsls = new FlashSlsGender();
	 
	flashsls.setGenSls( sStore,  sDiv, sDpt, sCls, sFrom, sTo, sYear, sMonth
		, sLevel, sDatLvl, sSort, sUser);	 
	
	int iNumOfGrp = flashsls.getNumOfGrp();
	int iNumOfReg = flashsls.getNumOfReg();
	
	String sColHdr = "Str";
	if(sLevel.equals("Div")){sColHdr = "Div"; }
	else if(sLevel.equals("Dpt")){sColHdr = "Dpt"; }
	else if(sLevel.equals("Cls")){sColHdr = "Class"; }
	else if(sLevel.equals("SKU")){sColHdr = "SKU"; }
	
	String sLinkNm = "Str";
	if(sLevel.equals("Str")){sLinkNm = "Hierarchy"; }
	
	boolean bLink = true; 
	if(sLevel.equals("Str")){ bLink = false; }
	
	
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
   
   String [] sArrMon = new String[]{"April", "May", "June", "July", "August", "September"
		   , "October", "November", "December", "January", "February", "March"}; 
%>

<html>
<head>
<title>Gender Sales Productivity</title>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Store = "<%=sStore%>";
var Div = "<%=sDiv%>";
var Dpt = "<%=sDpt%>";
var Cls = "<%=sCls%>";
var FrDate = "<%=sFrom%>";
var ToDate = "<%=sTo%>";
var Year = "<%=sYear%>";
var Month = "<%=sMonth%>";
var Level = "<%=sLevel%>";
var DatLvl = "<%=sDatLvl%>";
var Sort = "<%=sSort%>";

var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];

//--------------- End of Global variables ----------------
//---------------------------------------------
// initialize value on load
//---------------------------------------------
function  bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }  
}
//==============================================================================
// show another selected week
//==============================================================================
function reSort(sort)
{
	var url = "FlashSlsGender.jsp?Str=" + Store
	+ "&Div=" + Div  
	+ "&Dpt=" + Dpt
	+ "&Cls=" + Cls 
	+ "&FrDate=" + FrDate
	+ "&ToDate=" + ToDate
	+ "&Year=" + Year
	+ "&Month=" + Month
	+ "&Level=" + Level
	+ "&DatLvl=" + DatLvl
	+ "&Sort=" + sort
	;

   //alert(url)
   window.location.href=url;
}
//==============================================================================
//switch between store and Herarchy
//==============================================================================
function switchByStrOrDiv(link)
{ 	   	
	if(!link)
	{ 
		if(Div == "ALL" && Dpt == "ALL" && Cls == "ALL"){ Level = "Div"; } 
		else if(Div != "ALL" && Dpt == "ALL" && Cls == "ALL"){ Level = "Dpt"; }
		else if(Div != "ALL" && Dpt != "ALL" && Cls == "ALL"){ Level = "Cls"; }
	}
	else{ Level = "Str"; }
	
	var url = "FlashSlsGender.jsp?Str=" + Store
		+ "&Div=" + Div  
		+ "&Dpt=" + Dpt
		+ "&Cls=" + Cls 
		+ "&FrDate=" + FrDate
		+ "&ToDate=" + ToDate
		+ "&Year=" + Year
		+ "&Month=" + Month
		+ "&Level=" + Level
		+ "&DatLvl=" + DatLvl
		+ "&Sort=" + Sort
	;
	//alert(url)
    window.location.href=url;	
}
//==============================================================================
// drill down
//==============================================================================
function drillDown(grp)
{
	if(Level == "Str" && Div == "ALL" && Dpt == "ALL" && Cls == "ALL"){ Level = "Div"; Store = grp; }
	else if(Level == "Str" && Div != "ALL" && Dpt == "ALL" && Cls == "ALL"){ Level = "Dpt"; Store = grp; }
	else if(Level == "Str" && Div != "ALL" && Dpt != "ALL" && Cls == "ALL"){ Level = "Cls"; Store = grp; }
	else if(Level == "Str" && Div != "ALL" && Dpt != "ALL" && Cls != "ALL"){ Level = "SKU"; Store = grp; }
	
	else if(Level == "Div"){ Level = "Dpt"; Div = grp; }
	else if(Level == "Dpt"){ Level = "Cls"; Dpt = grp; }
	else if(Level == "Cls"){ Level = "SKU"; Cls = grp; }
	
	var url = "FlashSlsGender.jsp?Str=" + Store
		+ "&Div=" + Div  
		+ "&Dpt=" + Dpt
		+ "&Cls=" + Cls 
		+ "&FrDate=" + FrDate
		+ "&ToDate=" + ToDate
		+ "&Year=" + Year
		+ "&Month=" + Month
		+ "&Level=" + Level
		+ "&DatLvl=" + DatLvl
		+ "&Sort=" + Sort
	;
	//alert(url)
	window.location.href=url;
}
</SCRIPT>
</head>

<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvSelect" class="dvSelect"></div>
<div id="dvItem" class="dvItem"></div>
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
            <br>Gender Sales Productivity 
            <br> Store: <%=sStore%>
            <br> Divison: <%=sDiv%>
            <%if(!sDpt.equals("ALL")){%>, Department: <%=sDpt%><%}%>
            <%if(!sCls.equals("ALL")){%>, Class: <%=sDpt%><%}%>
            <br> 
            <%if(!sFrom.equals("ALL")){%>From: <%=sFrom%> - To: <%=sTo%><%}
            else if(!sMonth.equals("ALL")){%>Year/Month: <%=sYear + " / " + sArrMon[Integer.parseInt(sMonth)-1]%><%}
            else {%>Year: <%=sYear%><%}%>            
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="FlashSlsGenderSel.jsp"><font color="red" size="-1">Select</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr align=center>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
        	<th class="th02" rowspan=3><%=sColHdr%>
        		<br>&nbsp;<br><a href="javascript: switchByStrOrDiv(<%=bLink%>)"><%=sLinkNm%></a> 
        	</th>
        	<th class="th02" rowspan=4>Name</th>
        	<th class="th02" rowspan=4>&nbsp;</th>
          	<th class="th02" colspan=8>Female</th>
          	<th class="th02" rowspan=4>&nbsp;</th>
          	<th class="th02" colspan=8>Male</th>
          	<th class="th02" rowspan=4>&nbsp;</th>
          	<th class="th02" colspan=8>House</th>
          	<th class="th02" rowspan=4>&nbsp;</th>
          	<th class="th02" colspan=4>Total</th>
        </tr>
        <tr class="trHdr01">          	
          	<th class="th02" colspan=4>Sales</th>
          	<th class="th02" colspan=4>M/F<br>Sales Ratio<br>%</th>   
          	
          	<th class="th02" colspan=4>Sales</th>
          	<th class="th02" colspan=4>M/F<br>Sales Ratio<br>%</th>
          	
          	<th class="th02" colspan=4>Sales</th>
          	<th class="th02" colspan=4>M/F<br>Sales Ratio<br>%</th>
          	
          	<th class="th02" colspan=4>Sales</th>  	
        </tr>
        <tr class="trHdr01">          	
          	<th class="th02" colspan=2>TY</th>
          	<th class="th02" colspan=2>LY</th>
          	<th class="th02" colspan=2>TY</th>
          	<th class="th02" colspan=2>LY</th>
          	<th class="th02" colspan=2>TY</th>
          	<th class="th02" colspan=2>LY</th>
          	<th class="th02" colspan=2>TY</th>
          	<th class="th02" colspan=2>LY</th>
          	<th class="th02" colspan=2>TY</th>
          	<th class="th02" colspan=2>LY</th>
          	<th class="th02" colspan=2>TY</th>
          	<th class="th02" colspan=2>LY</th>
          	<th class="th02" colspan=2>TY</th>
          	<th class="th02" colspan=2>LY</th>          	                  	
        </tr>  	
        <tr class="trHdr01">
        <th class="th02"><a href="javascript: reSort('GRP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        
        <th class="th02"><a href="javascript: reSort('TYFERETUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('TYFERETDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('LYFERETUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('LYFERETDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        
        
        <th class="th02"><a href="javascript: reSort('TYFERETPRCUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('TYFERETPRCDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('LYFERETPRCUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('LYFERETPRCDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        
        <th class="th02"><a href="javascript: reSort('TYMARETUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('TYMARETDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('LYMARETUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('LYMARETDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        
        
        <th class="th02"><a href="javascript: reSort('TYMARETPRCUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('TYMARETPRCDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('LYMARETPRCUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('LYMARETPRCDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        
        <th class="th02"><a href="javascript: reSort('TYNGRETUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('TYNGRETDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('LYNGRETUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('LYNGRETDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        
        
        <th class="th02"><a href="javascript: reSort('TYNGRETPRCUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('TYNGRETPRCDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('LYNGRETPRCUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('LYNGRETPRCDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        
        <th class="th02"><a href="javascript: reSort('TYRETUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('TYRETDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('LYRETUP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        <th class="th02"><a href="javascript: reSort('LYRETDN')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        </tr>
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvReg = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfGrp; i++) {        	   
        	   	flashsls.setGenLst();
        	   	String sGrp = flashsls.getGrp();
        		String sGrpNm = flashsls.getGrpNm();
        		
        		String sTyFeRet = flashsls.getTyFeRet();
        		String sTyMaRet = flashsls.getTyMaRet();
        		String sTyNgRet = flashsls.getTyNgRet();
        		String sTyRet = flashsls.getTyRet();
        		String sLyFeRet = flashsls.getLyFeRet();
        		String sLyMaRet = flashsls.getLyMaRet();
        		String sLyNgRet = flashsls.getLyNgRet();
        		String sLyRet = flashsls.getLyRet();
        		
        		String sTyFeRetPrc = flashsls.getTyFeRetPrc();
        		String sTyMaRetPrc = flashsls.getTyMaRetPrc();
        		String sTyNgRetPrc = flashsls.getTyNgRetPrc();
        		String sLyFeRetPrc = flashsls.getLyFeRetPrc();
        		String sLyMaRetPrc = flashsls.getLyMaRetPrc();
        		String sLyNgRetPrc = flashsls.getLyNgRetPrc();
        		String sReg = flashsls.getReg();
       			
   				if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
   				else {sTrCls = "trDtl06";}
   				
   				boolean bRegBrk = false;
   			    if(!sReg.equals(sSvReg) && i > 0){ bRegBrk = true; }
   			 	sSvReg = sReg; 
           %>               
           <%if(bRegBrk){%>
             <tr class="Divider1"><td  colspan="100">&nbsp;</td></tr>
           <%}%>            
           <tr id="trGrp<%=i%>" class="<%=sTrCls%>">
             <td id="tdGrp<%=i%>" class="td12" nowrap> 
             	<%if(!sLevel.equals("SKU")){%><a href="javascript: drillDown('<%=sGrp%>')"><%=sGrp%></a><%}
             	else{%><%=sGrp%><%} %>
             </td>
             <td id="tdGrp<%=i%>" class="td11" nowrap><%=sGrpNm%></td>
             <td id="tdGrp<%=i%>" class="td35" nowrap>&nbsp;</td> 
             
             <td id="trTyFeRet<%=i%>" colspan=2 class="td12" nowrap>$<%=sTyFeRet%></td>
             <td id="trLyFeRet<%=i%>" colspan=2 class="td12" nowrap>$<%=sLyFeRet%></td>             
             <td id="trTyFeRetPrc<%=i%>" colspan=2 class="td12" nowrap><%=sTyFeRetPrc%>%</td>
             <td id="trTyFeRetPrc<%=i%>" colspan=2 class="td12" nowrap><%=sLyFeRetPrc%>%</td>
             
             <td id="tdGrp<%=i%>" class="td35" nowrap>&nbsp;</td>
             
             <td id="trTyFeRet<%=i%>" colspan=2 class="td12" nowrap>$<%=sTyMaRet%></td>
             <td id="trLyFeRet<%=i%>"  colspan=2 class="td12" nowrap>$<%=sLyMaRet%></td>             
             <td id="trTyFeRetPrc<%=i%>" colspan=2 class="td12" nowrap><%=sTyMaRetPrc%>%</td>
             <td id="trTyFeRetPrc<%=i%>" colspan=2 class="td12" nowrap><%=sLyMaRetPrc%>%</td>
             
             <td id="tdGrp<%=i%>" class="td35" nowrap>&nbsp;</td>
             
             <td id="trTyNgRet<%=i%>" colspan=2 class="td12" nowrap>$<%=sTyNgRet%></td>
             <td id="trLyNgRet<%=i%>"  colspan=2 class="td12" nowrap>$<%=sLyNgRet%></td>             
             <td id="trTyNgRetPrc<%=i%>" colspan=2 class="td12" nowrap><%=sTyNgRetPrc%>%</td>
             <td id="trTyNgRetPrc<%=i%>" colspan=2 class="td12" nowrap><%=sLyNgRetPrc%>%</td>
             
             <td id="tdGrp<%=i%>" class="td35" nowrap>&nbsp;</td>
             
             <td id="trTyRet<%=i%>" colspan=2 class="td12" nowrap>$<%=sTyRet%></td>
             <td id="trLyRet<%=i%>"  colspan=2 class="td12" nowrap>$<%=sLyRet%></td>
           </tr>
              <script></script>	
           <%}%> 
           
           <!-- ====== header ================ -->   
           
           <tr class="trHdr01">
        	<th class="th02" rowspan=3><%=sColHdr%></th>
        	<th class="th02" rowspan=3>Name</th>
        	<th class="th02" rowspan=3>&nbsp;</th>
          	<th class="th02" colspan=8>Female</th>
          	<th class="th02" rowspan=3>&nbsp;</th>
          	<th class="th02" colspan=8>Male</th>
          	<th class="th02" rowspan=3>&nbsp;</th>
          	<th class="th02" colspan=8>House</th>
          	<th class="th02" rowspan=3>&nbsp;</th>
          	<th class="th02" colspan=4>Total</th>
        </tr>
        <tr class="trHdr01">          	
          	<th class="th02" colspan=4>Sales</th>
          	<th class="th02" colspan=4>Ratio</th>   
          	
          	<th class="th02" colspan=4>Sales</th>
          	<th class="th02" colspan=4>Ratio</th>
          	
          	<th class="th02" colspan=4>Sales</th>
          	<th class="th02" colspan=4>Ratio</th>
          	
          	<th class="th02" colspan=4>Sales</th>  	
        </tr>
        <tr class="trHdr01">          	
          	<th class="th02" colspan=2>TY</th>
          	<th class="th02" colspan=2>LY</th>
          	<th class="th02" colspan=2>TY</th>
          	<th class="th02" colspan=2>LY</th>
          	<th class="th02" colspan=2>TY</th>
          	<th class="th02" colspan=2>LY</th>
          	<th class="th02" colspan=2>TY</th>
          	<th class="th02" colspan=2>LY</th>
          	<th class="th02" colspan=2>TY</th>
          	<th class="th02" colspan=2>LY</th>
          	<th class="th02" colspan=2>TY</th>
          	<th class="th02" colspan=2>LY</th>
          	<th class="th02" colspan=2>TY</th>
          	<th class="th02" colspan=2>LY</th>          	                  	
        </tr>
           
           
           
           <!-- ====== Region Total ================ -->           
           <%
          if(sStore.equals("ALL")){  
           	for(int i=0; i < iNumOfReg; i++ )
			{
				flashsls.setRegTot();
				String sGrp = flashsls.getGrp();
				String sGrpNm = flashsls.getGrpNm();
		
				String sTyFeRet = flashsls.getTyFeRet();
				String sTyMaRet = flashsls.getTyMaRet();
				String sTyNgRet = flashsls.getTyNgRet();
				String sTyRet = flashsls.getTyRet();
				String sLyFeRet = flashsls.getLyFeRet();
				String sLyMaRet = flashsls.getLyMaRet();
				String sLyNgRet = flashsls.getLyNgRet();
				String sLyRet = flashsls.getLyRet();
		
				String sTyFeRetPrc = flashsls.getTyFeRetPrc();
				String sTyMaRetPrc = flashsls.getTyMaRetPrc();
				String sTyNgRetPrc = flashsls.getTyNgRetPrc();
				String sLyFeRetPrc = flashsls.getLyFeRetPrc();
				String sLyMaRetPrc = flashsls.getLyMaRetPrc();
				String sLyNgRetPrc = flashsls.getLyNgRetPrc();
           %>
           
           <tr id="trTot" class="trDtl041">             
             <td class="td11" nowrap colspan=2><%=sGrpNm%></td>
             <td class="td35" nowrap>&nbsp;</td> 
             
             <td class="td12" colspan=2 nowrap>$<%=sTyFeRet%></td>
             <td class="td12" colspan=2 nowrap>$<%=sLyFeRet%></td>             
             <td class="td12" colspan=2 nowrap><%=sTyFeRetPrc%>%</td>
             <td class="td12" colspan=2 nowrap><%=sLyFeRetPrc%>%</td>
             
             <td class="td35" nowrap>&nbsp;</td>
             
             <td class="td12" colspan=2 nowrap>$<%=sTyMaRet%></td>
             <td class="td12" colspan=2 nowrap>$<%=sLyMaRet%></td>             
             <td class="td12" colspan=2 nowrap><%=sTyMaRetPrc%>%</td>
             <td class="td12" colspan=2 nowrap><%=sLyMaRetPrc%>%</td>
             
             <td class="td35" nowrap>&nbsp;</td>
             
             <td colspan=2 class="td12" nowrap>$<%=sTyNgRet%></td>
             <td colspan=2 class="td12" nowrap>$<%=sLyNgRet%></td>             
             <td colspan=2 class="td12" nowrap><%=sTyNgRetPrc%>%</td>
             <td colspan=2 class="td12" nowrap><%=sLyNgRetPrc%>%</td>
             
             <td class="td35" nowrap>&nbsp;</td>
             
             <td colspan=2 class="td12" nowrap>$<%=sTyRet%></td>
             <td colspan=2 class="td12" nowrap>$<%=sLyRet%></td>
           </tr>
           <%}%>  
         <%}%>
           <!-- ======Total ================ -->
           <%
           	flashsls.setTotal();
           	String sGrp = flashsls.getGrp();
   			String sGrpNm = flashsls.getGrpNm();
   		
   			String sTyFeRet = flashsls.getTyFeRet();
   			String sTyMaRet = flashsls.getTyMaRet();
   			String sTyNgRet = flashsls.getTyNgRet();
   			String sTyRet = flashsls.getTyRet();
   			String sLyFeRet = flashsls.getLyFeRet();
   			String sLyMaRet = flashsls.getLyMaRet();
   			String sLyNgRet = flashsls.getLyNgRet();
   			String sLyRet = flashsls.getLyRet();
   		
   			String sTyFeRetPrc = flashsls.getTyFeRetPrc();
   			String sTyMaRetPrc = flashsls.getTyMaRetPrc();
   			String sTyNgRetPrc = flashsls.getTyNgRetPrc();
   			String sLyFeRetPrc = flashsls.getLyFeRetPrc();
   			String sLyMaRetPrc = flashsls.getLyMaRetPrc();
   			String sLyNgRetPrc = flashsls.getLyNgRetPrc();
           %>  
           <tr id="trTot" class="trDtl12">             
             <td class="td11" nowrap colspan=2>Total</td>
             <td class="td35" nowrap>&nbsp;</td> 
             
             <td class="td12" colspan=2 nowrap>$<%=sTyFeRet%></td>
             <td class="td12" colspan=2 nowrap>$<%=sLyFeRet%></td>             
             <td class="td12" colspan=2 nowrap><%=sTyFeRetPrc%>%</td>
             <td class="td12" colspan=2 nowrap><%=sLyFeRetPrc%>%</td>
             
             <td class="td35" nowrap>&nbsp;</td>
             
             <td class="td12" colspan=2 nowrap>$<%=sTyMaRet%></td>
             <td class="td12" colspan=2 nowrap>$<%=sLyMaRet%></td>             
             <td class="td12" colspan=2 nowrap><%=sTyMaRetPrc%>%</td>
             <td class="td12" colspan=2 nowrap><%=sLyMaRetPrc%>%</td>
             
             <td class="td35" nowrap>&nbsp;</td>
             
             <td colspan=2 class="td12" nowrap>$<%=sTyNgRet%></td>
             <td colspan=2 class="td12" nowrap>$<%=sLyNgRet%></td>             
             <td colspan=2 class="td12" nowrap><%=sTyNgRetPrc%>%</td>
             <td colspan=2 class="td12" nowrap><%=sLyNgRetPrc%>%</td>
             
             <td class="td35" nowrap>&nbsp;</td>
             
             <td colspan=2 class="td12" nowrap>$<%=sTyRet%></td>
             <td colspan=2 class="td12" nowrap>$<%=sLyRet%></td>
           </tr>         
         </table>
         
         <br><br>
         
         <!-- ====== Hours ================ -->         
         <%
         if(sStore.equals("ALL") && sDiv.equals("ALL") && sDpt.equals("ALL") && sCls.equals("ALL"))
         {  
         	flashsls.setGenHrs();
     		int iNumOfStr = flashsls.getNumOfStr();	
     		String [] sStr = flashsls.getStr();
     		String [] sTyFeHrs = flashsls.getTyFeHrs();
     		String [] sTyMaHrs = flashsls.getTyMaHrs();
     		String [] sLyFeHrs = flashsls.getLyFeHrs();
     		String [] sLyMaHrs = flashsls.getLyMaHrs();
     	
	     	String [] sTyFeHrsPrc = flashsls.getTyFeHrsPrc();
    	 	String [] sTyMaHrsPrc = flashsls.getTyMaHrsPrc();
     		String [] sLyFeHrsPrc = flashsls.getLyFeHrsPrc();
     		String [] sLyMaHrsPrc = flashsls.getLyMaHrsPrc();
     		
     		String [] sTyFeCnt = flashsls.getTyFeCnt();
     		String [] sTyMaCnt = flashsls.getTyMaCnt();
     		String [] sLyFeCnt = flashsls.getLyFeCnt();
     		String [] sLyMaCnt = flashsls.getLyMaCnt();
     		
     		String [] sTyFeSph = flashsls.getTyFeSph();
     		String [] sTyMaSph = flashsls.getTyMaSph();
     		String [] sLyFeSph = flashsls.getLyFeSph();
     		String [] sLyMaSph = flashsls.getLyMaSph();	
         %>
         <b>Gender Working Hours for selected periods</b>
         <table class="tbl02">
        	<tr class="trHdr01">
        		<th class="th02" rowspan=3>Str</th>
        		<th class="th02" rowspan=3>&nbsp;</th>
        		<th class="th02" colspan=8>Female</th>
        		<th class="th02" rowspan=3>&nbsp;</th>
        		<th class="th02" colspan=8>Male</th>
        	</tr>
        	<tr class="trHdr01">
        	    <th class="th02" colspan=2>Count</th>
        		<th class="th02" colspan=2>Hours</th>
        		<th class="th02" colspan=2>M/F<br>Working Hrs Ratio<br>%</th>
        		<th class="th02" colspan=2>SPH</th>
        		
        		<th class="th02" colspan=2>Count</th>
        		<th class="th02" colspan=2>Hours</th>
        		<th class="th02" colspan=2>M/F<br>Working Hrs Ratio<br>%</th>
        		<th class="th02" colspan=2>SPH</th>        		        		
        	</tr>
        	<tr class="trHdr01">
        		<th class="th02">TY</th>
        		<th class="th02">LY</th>
        		<th class="th02">TY</th>
        		<th class="th02">LY</th>
        		<th class="th02">TY</th>
        		<th class="th02">LY</th>
        		<th class="th02">TY</th>
        		<th class="th02">LY</th>
        		<th class="th02">TY</th>
        		<th class="th02">LY</th>
        		<th class="th02">TY</th>
        		<th class="th02">LY</th>
        		<th class="th02">TY</th>
        		<th class="th02">LY</th>
        		<th class="th02">TY</th>
        		<th class="th02">LY</th>        		        		        		
        	</tr>
        	<%sTrCls = "trDtl06"; 
              iArg = -1;
           %>
           <%for(int i=0; i < iNumOfStr; i++) { 
        	 	if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
  			 	else {sTrCls = "trDtl06";}
        	 	
        	 	if(sStr[i].equals("Total")){sTrCls = "trDtl12";}
           %>  
           <tr id="trGrp<%=i%>" class="<%=sTrCls%>">
             <td class="td12" nowrap><%=sStr[i]%></td>
             <td class="td35" nowrap>&nbsp;</td>
             
             <td class="td12" nowrap><%=sTyFeCnt[i]%></td>
             <td class="td12" nowrap><%=sLyFeCnt[i]%></td>
             <td class="td12" nowrap><%=sTyFeHrs[i]%></td>
             <td class="td12" nowrap><%=sLyFeHrs[i]%></td>
             <td class="td12" nowrap><%=sTyFeHrsPrc[i]%>%</td>
             <td class="td12" nowrap><%=sLyFeHrsPrc[i]%>%</td>
             <td class="td12" nowrap>$<%=sTyFeSph[i]%></td>
             <td class="td12" nowrap>$<%=sLyFeSph[i]%></td>
             
             <td class="td35" nowrap>&nbsp;</td>
             
             <td class="td12" nowrap><%=sTyMaCnt[i]%></td>
             <td class="td12" nowrap><%=sLyMaCnt[i]%></td>
             <td class="td12" nowrap><%=sTyMaHrs[i]%></td>
             <td class="td12" nowrap><%=sLyMaHrs[i]%></td>
             <td class="td12" nowrap><%=sTyMaHrsPrc[i]%>%</td>
             <td class="td12" nowrap><%=sLyMaHrsPrc[i]%>%</td>
             <td class="td12" nowrap>$<%=sTyMaSph[i]%></td>
             <td class="td12" nowrap>$<%=sLyMaSph[i]%></td>
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
flashsls.disconnect();
flashsls = null;
}
%> 

