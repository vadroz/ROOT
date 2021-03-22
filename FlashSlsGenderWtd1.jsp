<!DOCTYPE html>
<%@ page import="flashreps.FlashSlsGenderWtd, java.util.*, rciutility.StoreSelect
, rciutility.RunSQLStmt, java.sql.*,java.util.*, java.text.*"%>
<%
   	String sStore = request.getParameter("Str");
	String sDiv = request.getParameter("Div");
	String sDpt = request.getParameter("Dpt");
	String sCls = request.getParameter("Cls");
   	String sWeek = request.getParameter("Week");   	 
   	String sLevel = request.getParameter("Level");  
   	String sSort = request.getParameter("Sort");

   	if(sStore==null || sStore.equals("")) { sStore="ALL"; }
   	if(sDiv==null || sDiv.equals("")) { sDiv="ALL"; }
   	if(sDpt==null || sDpt.equals("")) { sDpt="ALL"; }
   	if(sCls==null || sCls.equals("")) { sCls="ALL"; }
   	if(sWeek==null || sWeek.equals("")) { sWeek="LAST"; }   	
   	if(sLevel==null || sLevel.equals("")) { sLevel="Str"; } 	
   	if(sSort==null || sSort.equals("")) { sSort="GRP"; }
   	
   
String sAppl="BASIC1";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=FlashSlsGenderWtd.jsp&APPL=" + sAppl + "&" + request.getQueryString());
}
else
{
   String sStrAllowed = session.getAttribute("STORE").toString();
   String sUser = session.getAttribute("USER").toString();
   
   FlashSlsGenderWtd flashsls = new FlashSlsGenderWtd();
	 
	flashsls.setGenSls( sStore,  sDiv, sDpt, sCls, sWeek, sLevel, sSort, sUser);	 
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
   
   String [] sColHdg = new String[]{"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "WTD", "MTD"};
   
   int [] iColWidth = new int[]{ 3, 10
    , 2
	, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
	, 2
	, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
	, 2
	, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
	, 2
	, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
	, 2
	, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
	, 2
	, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
	, 2
	, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
	, 2
	, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
	, 2
	, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
   };
%>

<html>
<head>
<title>Flash Sales by Gender</title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE11" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Store = "<%=sStore%>";
var Div = "<%=sDiv%>";
var Dpt = "<%=sDpt%>";
var Cls = "<%=sCls%>";
var Week = "<%=sWeek%>";
var Level = "<%=sLevel%>";
var Sort = "<%=sSort%>";
var NumOfGrp = "<%=iNumOfGrp%>";
var NumOfReg = "<%=iNumOfReg%>";
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
	var url = "FlashSlsGenderWtd.jsp?Str=" + Store
	+ "&Div=" + Div  
	+ "&Dpt=" + Dpt
	+ "&Cls=" + Cls 
	+ "&Week=" + Week
	+ "&Level=" + Level
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
	
	var url = "FlashSlsGenderWtd.jsp?Str=" + Store
		+ "&Div=" + Div  
		+ "&Dpt=" + Dpt
		+ "&Cls=" + Cls 
		+ "&Week=" + Week
		+ "&Level=" + Level		
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
	
	var url = "FlashSlsGenderWtd.jsp?Str=" + Store
		+ "&Div=" + Div  
		+ "&Dpt=" + Dpt
		+ "&Cls=" + Cls 
		+ "&Week=" + Week
		+ "&Level=" + Level
		+ "&Sort=" + Sort
	;
	//alert(url)
	window.location.href=url;
}
</SCRIPT>

<script type='text/javascript'>//<![CDATA[
$(window).load(function()
{
 
	cloneRow();

	$(window).bind("scroll", function() 
	{
     	var offsetLeft = $(this).scrollLeft();
		var color = "#bee5ea";
		var posLeft = 0; 
		posLeft = offsetLeft; 		
		
		
		var col0hdr1 = "#thGrp";		 
		$(col0hdr1).css({ left: posLeft, position : "relative", background: "#FFE4C4", border: "darkred solid 1px"});
		var col0hdr2 = "#thGrp1";		 
		$(col0hdr2).css({ left: posLeft, position : "relative", background: "#FFE4C4", border: "darkred solid 1px"});
		
		var col1hdr = "#thFix1";		 
		$(col1hdr).css({ left: posLeft, position : "relative", background: "#FFE4C4"});
		var col2hdr = "#thFix2";		 
		$(col2hdr).css({ left: posLeft, position : "relative", background: "#FFE4C4"});
	
		for(var i=0; i < NumOfGrp; i++)
		{
			if(color=="#bee5ea"){ color = "#f4ecbc";}
	 		else{ color = "#bee5ea"; }
			
			var desc = "#tdGrp" + i;
			$(desc).css({ left: posLeft, position : "relative", background:color, border: "lightsalmon solid 1px" });
			$(desc).css("z-index", 0);	
		}
	
		var offsetTop = $(this).scrollTop();
    	if(offsetTop > 150)
    	{
    		$("#trHdr01").css({"display": "none"});
    		$("#trHdr02").css({"display": "none"});
    		$("#trHdr04").css({"display": "none"});
    		$("#trHdr03").css({"display": "none"});
    		$("#tblClone").css({"display": "block"});
    		$("#tblClone").css({top: offsetTop, left: 10});
    		$("#tblClone").css('z-index', 100);
    	}
    	else
    	{	
    		$("#trHdr01").css({"display": "table-row"});
    		$("#trHdr02").css({"display": "table-row"});
    		$("#trHdr03").css({"display": "table-row"});
    		$("#trHdr04").css({"display": "table-row"});
    		$("#tblClone").css({"display": "none"});
    	} 
	}); 
	});//]]> 

//==============================================================================
//clone row 
//==============================================================================
function cloneRow() 
{
  var row1 = document.getElementById("trHdr01");  
  var row2 = document.getElementById("trHdr02");
  var row3 = document.getElementById("trHdr03");  
  var row4 = document.getElementById("trHdr04");
  
  var rowScale = document.getElementById("trScale");
  var table = document.getElementById("tblClone");  
  var clone1 = row1.cloneNode(true); // copy children too  
  var clone2 = row2.cloneNode(true);
  var clone3 = row3.cloneNode(true);
  var clone4 = row4.cloneNode(true);
  
  var cloneScale = rowScale.cloneNode(true);
  clone1.id = "trClone01"; // change id or other attributes/contents
  clone2.id = "trClone02";
  clone3.id = "trClone03";
  clone4.id = "trClone04";
  
  cloneScale.id = "trCloneScale";
  table.appendChild(clone1); // add new row to end of table
  table.appendChild(clone2); 
  table.appendChild(clone3);
  table.appendChild(clone4);  
  table.appendChild(cloneScale); // add new row to end of table
  
  var hdr1 = table.childNodes[0].childNodes[1];
  var hdr2 = table.childNodes[3].childNodes[1];
  hdr1.id = "thFix1";
  hdr2.id = "thFix2";
  rowScale.style.visibility="hidden";  
}
</script>


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
          <th width="1200px">
            <b>Retail Concepts, Inc
            <br>Gender Sales Productivity 
            <br> Store: <%=sStore%>
            <br> Divison: <%=sDiv%>
            <%if(!sDpt.equals("ALL")){%>, Department: <%=sDpt%><%}%>
            <%if(!sCls.equals("ALL")){%>, Class: <%=sDpt%><%}%>
            <br> 
            <%if(!sWeek.equals("LAST")){%>Week: <%=sWeek%><%}
            else {%>Yesterday<%}%>            
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="FlashSlsGenderWtdSel.jsp"><font color="red" size="-1">Select</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
          <th>&nbsp;</th>          
        </tr>
       </table> 
       
       <!-- ======================= Clone Header ========================================== -->
       <table id="tblClone" class="tbl01" style="position: absolute; text-align: left" ></table>
       <!-- ======================= End of Clone Header =================================== -->
       
       
       <table id="tblData" class="tbl02">
        <tr id="trHdr01" class="trHdr01">
        	<th id="thGrp" class="th02" rowspan=3><%=sColHdr%>
        		<br>&nbsp;<br><a href="javascript: switchByStrOrDiv(<%=bLink%>)"><%=sLinkNm%></a> 
        	</th>
        	<th class="th02" rowspan=4>Name</th>
        	<%for(int j=0; j < 9; j++){%>
        		<th class="th02" rowspan=4>&nbsp;</th>        
        		<th class="th02" colspan=16><%=sColHdg[j]%></th>          		
          	<%}%>
        </tr>
        
        <tr id="trHdr02" class="trHdr01"> 
        	<%for(int j=0; j < 9; j++){%>         	
          		<th class="th02" colspan=8>TY</th>
          		<th class="th02" colspan=8>LY</th>
          	<%}%>                 	
        </tr>
        
        <tr id="trHdr03" class="trHdr01">
        	<%for(int j=0; j < 18; j++){%>          	
          		<th class="th02" colspan=2>M%</th>
          		<th class="th02" colspan=2>F%</th>
          		<th class="th02" colspan=2>H%</th>
          		<th class="th02" colspan=2>$'s</th>
          	<%}%> 
         </tr>
        
          	
        <tr id="trHdr04" class="trHdr01">
        <th id="thGrp1" class="th02"><a href="javascript: reSort('GRP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        
        <%for(int j=0; j < 9; j++){%>          
            <th class="th02"><a href="javascript: reSort('TYMARETPRCUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYMARETPRCDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYFERETPRCUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYFERETPRCDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYNGRETPRCUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYNGRETPRCDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYRETUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYRETDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	
        	<th class="th02"><a href="javascript: reSort('LYMARETPRCUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYMARETPRCDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYFERETPRCUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYFERETPRCDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYNGRETPRCUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYNGRETPRCDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYRETUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYRETDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        <%}%>
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
       			
       			String [] sTyRet = flashsls.getTyRet();
       			String [] sLyRet = flashsls.getLyRet();
       			
       			String [] sTyFeRetPrc = flashsls.getTyFeRetPrc();
       			String [] sTyMaRetPrc = flashsls.getTyMaRetPrc();
       			String [] sTyNgRetPrc = flashsls.getTyNgRetPrc();
       			String [] sLyFeRetPrc = flashsls.getLyFeRetPrc();
       			String [] sLyMaRetPrc = flashsls.getLyMaRetPrc();
       			String [] sLyNgRetPrc = flashsls.getLyNgRetPrc();   
       			
       			String sReg = flashsls.getReg();
       			
   				if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
   				else {sTrCls = "trDtl06";}
   				
   				boolean bRegBrk = false;
   			    if(!sReg.equals(sSvReg) && i > 0){ bRegBrk = true; }
   			 	sSvReg = sReg; 
   			 	
   			 	if(iColWidth[0] < sGrp.length()){ iColWidth[0] = sGrp.length(); }
   			 	if(iColWidth[1] < sGrpNm.length()){ iColWidth[1] = sGrpNm.length(); }   			    
           %> 
           
           <%if(bRegBrk){%>
             <tr class="Divider1"><td  colspan="155">&nbsp;</td></tr>
           <%}%>           
                                     
           <tr id="trGrp<%=i%>" class="<%=sTrCls%>">
             <td id="tdGrp<%=i%>" class="td66" nowrap>
             	<%if(!sLevel.equals("SKU")){%><a href="javascript: drillDown('<%=sGrp%>')"><%=sGrp%></a><%}
             	else{%><%=sGrp%><%} %>
             </td>
             <td id="tdGrpNm<%=i%>" class="td11" nowrap><%=sGrpNm%></td>
              
             <%for(int j=0; j < 9; j++){%>
             	<td class="td35" nowrap>&nbsp;</td11>
             	<td id="trTyFeRet<%=i%>" colspan=2 class="td12" nowrap><%if(!sTyMaRetPrc[j].equals(".0")){%><%=sTyMaRetPrc[j]%>%<%}%></td>
             	<td id="trTyFeRet<%=i%>" colspan=2 class="td12" nowrap><%if(!sTyFeRetPrc[j].equals(".0")){%><%=sTyFeRetPrc[j]%>%<%}%></td>
             	<td id="trTyFeRet<%=i%>" colspan=2 class="td12" nowrap><%if(!sTyNgRetPrc[j].equals(".0")){%><%=sTyNgRetPrc[j]%>%<%}%></td>
             	<td id="trTyFeRet<%=i%>" colspan=2 class="td12" nowrap><%if(!sTyRet[j].equals("0")){%>$<%=sTyRet[j]%><%}%></td>
             	
             	<td id="trLyFeRet<%=i%>" colspan=2 class="td63" nowrap><%if(!sLyMaRetPrc[j].equals(".0")){%><%=sLyMaRetPrc[j]%>%<%}%></td>
             	<td id="trLyFeRet<%=i%>" colspan=2 class="td12" nowrap><%if(!sLyFeRetPrc[j].equals(".0")){%><%=sLyFeRetPrc[j]%>%<%}%></td>
             	<td id="trLyFeRet<%=i%>" colspan=2 class="td12" nowrap><%if(!sLyNgRetPrc[j].equals(".0")){%><%=sLyNgRetPrc[j]%>%<%}%></td>
             	<td id="trLyFeRet<%=i%>" colspan=2 class="td12" nowrap><%if(!sLyRet[j].equals("0")){%>$<%=sLyRet[j]%><%}%></td>  
             <%}%>
           </tr>
              <script></script>	
           <%}%>
           
           <tr class="Divider"><td colspan="155">&nbsp;</td></tr>
           <!-- ====== Region Totals ================ -->
           <%
            for(int i=0; i < iNumOfReg; i++){
            flashsls.setRegTot();
          	
           	String sGrp = flashsls.getGrp();
  			String sGrpNm = flashsls.getGrpNm();
  			
  			String [] sTyRet = flashsls.getTyRet();
   			String [] sLyRet = flashsls.getLyRet();
   			
   			String [] sTyFeRetPrc = flashsls.getTyFeRetPrc();
   			String [] sTyMaRetPrc = flashsls.getTyMaRetPrc();
   			String [] sTyNgRetPrc = flashsls.getTyNgRetPrc();
   			String [] sLyFeRetPrc = flashsls.getLyFeRetPrc();
   			String [] sLyMaRetPrc = flashsls.getLyMaRetPrc();
   			String [] sLyNgRetPrc = flashsls.getLyNgRetPrc();       
  			
				
       	    %>  
           <tr id="trTot" class="trDtl041">             
             <td class="td11" nowrap colspan=2><%=sGrpNm%></td>
             
             <%for(int j=0; j < 9; j++){%>
             	<td class="td35" nowrap>&nbsp;</td11>
             	<td colspan=2 class="td12" nowrap><%if(!sTyMaRetPrc[j].equals(".0")){%><%=sTyMaRetPrc[j]%>%<%}%></td>
             	<td colspan=2 class="td12" nowrap><%if(!sTyFeRetPrc[j].equals(".0")){%><%=sTyFeRetPrc[j]%>%<%}%></td>
             	<td colspan=2 class="td12" nowrap><%if(!sTyNgRetPrc[j].equals(".0")){%><%=sTyNgRetPrc[j]%>%<%}%></td>
             	<td colspan=2 class="td12" nowrap><%if(!sTyRet[j].equals("0")){%>$<%=sTyRet[j]%><%}%></td>
             	
             	<td colspan=2 class="td63" nowrap><%if(!sLyMaRetPrc[j].equals(".0")){%><%=sLyMaRetPrc[j]%>%<%}%></td>
             	<td colspan=2 class="td12" nowrap><%if(!sLyFeRetPrc[j].equals(".0")){%><%=sLyFeRetPrc[j]%>%<%}%></td>
             	<td colspan=2 class="td12" nowrap><%if(!sLyNgRetPrc[j].equals(".0")){%><%=sLyNgRetPrc[j]%>%<%}%></td>
             	<td colspan=2 class="td12" nowrap><%if(!sLyRet[j].equals("0")){%>$<%=sLyRet[j]%><%}%></td>  
             <%}%>
           </tr>
           <%} %>
           
            <tr class="Divider"><td colspan="155">&nbsp;</td></tr>
           <!-- ======Total ================ -->
           <%
           	flashsls.setTotal();
          	
            String sGrp = flashsls.getGrp();
  			String sGrpNm = flashsls.getGrpNm();
  			
  			String [] sTyRet = flashsls.getTyRet();
   			String [] sLyRet = flashsls.getLyRet();
   			
   			String [] sTyFeRetPrc = flashsls.getTyFeRetPrc();
   			String [] sTyMaRetPrc = flashsls.getTyMaRetPrc();
   			String [] sTyNgRetPrc = flashsls.getTyNgRetPrc();
   			String [] sLyFeRetPrc = flashsls.getLyFeRetPrc();
   			String [] sLyMaRetPrc = flashsls.getLyMaRetPrc();
   			String [] sLyNgRetPrc = flashsls.getLyNgRetPrc();       
  			
				
       	    %>  
           <tr id="trTot" class="trDtl12">             
             <td class="td11" nowrap colspan=2>Total</td>
             
             <%for(int j=0; j < 9; j++){%>
             	<td class="td35" nowrap>&nbsp;</td11>
             	<td colspan=2 class="td12" nowrap><%=sTyMaRetPrc[j]%>%</td>
             	<td colspan=2 class="td12" nowrap><%=sTyFeRetPrc[j]%>%</td>
             	<td colspan=2 class="td12" nowrap><%=sTyNgRetPrc[j]%>%</td>
             	<td colspan=2 class="td12" nowrap>$<%=sTyRet[j]%></td>
             	
             	<td colspan=2 class="td63" nowrap><%=sLyMaRetPrc[j]%>%</td>
             	<td colspan=2 class="td12" nowrap><%=sLyFeRetPrc[j]%>%</td>
             	<td colspan=2 class="td12" nowrap><%=sLyNgRetPrc[j]%>%</td>
             	<td colspan=2 class="td12" nowrap>$<%=sLyRet[j]%></td>  
             <%}%>
             
           </tr>     
           
           <tr id="trScale" class="trDtl06" style="visibility: hidden;">
             <%for(int j=0; j < iColWidth.length; j++){%>
                <%if(j > 2 && j < iColWidth.length-1){%>
                	<td class="td18" style="border: none;" nowrap><%for(int k=0; k < iColWidth[ j]; k++){%>0<%}%></td>
                <%}
                else{%>
                	<td class="td18" style="border: none;" nowrap><%for(int k=0; k < iColWidth[ j]; k++){%>W<%}%></td>
                <%}%>
             <%}%>
           </tr>
         </table>
         
         <br><br>
         
         <!----------------------- end of table ------------------------>
      
 </body>
</html>
<%
flashsls.disconnect();
flashsls = null;
}
%> 

