<%@ page import="flashreps.GenderHrs, java.util.*
, rciutility.RunSQLStmt, java.sql.*,java.util.*, java.text.*"%>
<%
   	String sStore = request.getParameter("Str");
   	String sFrWeek = request.getParameter("FrWeek");
   	String sToWeek = request.getParameter("ToWeek");
   	String sSort = request.getParameter("Sort");

   	if(sStore==null || sStore.equals("")) { sStore="ALL"; }
   	if(sFrWeek==null || sFrWeek.equals("")) { sFrWeek="LAST"; }
   	if(sToWeek==null || sToWeek.equals("")) { sToWeek="LAST"; }
   	if(sSort==null || sSort.equals("")) { sSort="GRP"; }   	
   
String sAppl="BASIC1";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=GenderHrs.jsp&APPL=" + sAppl + "&" + request.getQueryString());
}
else
{
   	String sStrAllowed = session.getAttribute("STORE").toString();
   	String sUser = session.getAttribute("USER").toString();
   
   	GenderHrs flashsls = new GenderHrs();   	
   	flashsls.setGenSls( sStore, sFrWeek, sToWeek, sSort, sUser);
   	
   	int iNumOfStr = flashsls.getNumOfStr();	
	int iNumOfReg = flashsls.getNumOfReg();
	int iNumOfWk = flashsls.getNumOfWk();
	String [] sTyWeek = flashsls.getTyWeek();
	String [] sLyWeek = flashsls.getLyWeek();
%>

<html>
<head>
<title>Flash Sales by Gender</title>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var Store = "<%=sStore%>";
var FrWeek = "<%=sFrWeek%>";
var ToWeek = "<%=sToWeek%>";
var Sort = "<%=sSort%>";

//--------------- End of Global variables ----------------
//---------------------------------------------
// initialize value on load
//---------------------------------------------
function  bodyLoad()
{
	if (ua.match(/iPad/i) || ua.match(/iPhone/i)){ isSafari = true; }  
	
	setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
// re-sort report
//==============================================================================
function reSort(sort)
{
	var url = "GenderHrsDtl.jsp?Str=" + Store
	+ "&FrWeek=" + FrWeek
	+ "&ToWeek=" + ToWeek
	+ "&Sort=" + sort
	;

	window.location.href = url;	
}
//==============================================================================
// show employee list for selected store gender and year
//==============================================================================
function getEmpList(str, gend, week)
{
	var url = "GenderHrsDtl.jsp?Str=" + str
	+ "&Week=" + week
	+ "&Gend=" + gend
	;

	if(isIE || isSafari){ window.frame1.location.href = url; }
    else if(isChrome || isEdge) { window.frame1.src = url; }
}
//==============================================================================
// show employee list 
//==============================================================================
function showEmpList(str, week, gend, emp, empNm, type, sepr, hirDt, trmDt)
{
	var hdr = "Store: " + str + " Week: " + week;
	var html = "<table class='tbl01'>"
	     + "<tr>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popEmpList(str, week, gend, emp, empNm, type, sepr, hirDt, trmDt)
	     + "</td></tr>"
	   + "</table>"

	  if(isIE && ua.indexOf("MSIE 7.0") >= 0){ document.all.dvItem.style.width = "250";}
	  else { document.all.dvItem.style.width = "auto";}
	   
	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.left=getLeftScreenPos() + 300;
	  document.all.dvItem.style.top=getTopScreenPos() + 100;
	  document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//populate picked Item
//==============================================================================
function popEmpList(str, week, gend, emp, empNm, type, sepr, hirDt, trmDt)
{
	var gendNm = "Female";
	if(gend == "M"){ gendNm = "Male"; }
	
	var panel = "<table class='tbl02'";
	panel += "<tr class='trHdr01'>"
		 + "<th class='th02' colspan=10>Gender: " + gendNm + "</th>"
	  + "</tr>"
	  + "<tr class='trHdr01'>"
	     + "<th class='th02' nowrap>No.</th>"
	     + "<th class='th02' nowrap>Employee</th>"
	     + "<th class='th02' nowrap>Type</th>"
	     + "<th class='th02' nowrap>&nbsp;</th>"
	     + "<th class='th02' nowrap>Term<br>Code</th>"
	     + "<th class='th02' nowrap>Hired<br>Date</th>"
	     + "<th class='th02' nowrap>Terminated<br>Date</th>"
	  + "</tr>"
	  
		  
	for(var i=0; i < emp.length; i++)
	{
		panel += "<tr class='trDtl04'>"
		     + "<td class='td11' nowrap>" + (i+1) + "</td>"
			 + "<td class='td11' nowrap>" + emp[i] + " - " + empNm[i]  + "</td>"
	    
		if(type[i] == '1'){  panel +=  "<td class='td11' style='background: yellow'>" + cnvType(type[i]) + "</td>"; }
		if(type[i] == '2'){  panel +=  "<td class='td11' style='background: pink'>" + cnvType(type[i]) + "</td>"; }
		if(type[i] == '3'){  panel +=  "<td class='td11' style='background: lightgreen'>" + cnvType(type[i]) + "</td>"; }
	    
	    panel += "<td class='td43'>&nbsp;</td>"
			 + "<td class='td18'>" + sepr[i] + "</td>"
			 + "<td class='td11'>" + cnvDate(hirDt[i]) + "</td>"
			 + "<td class='td11'>" + cnvDate(trmDt[i]) + "</td>"
		  + "</tr>"
	}

	panel += "</tr>";
	
	panel += "<tr class='trDtl04'>"
	      + "<td colspan=10>"
	          + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
		  + "</td></tr>"
	
	return panel;	  
}
//==============================================================================
//convert Type
//==============================================================================
function cnvType(type)
{
	var typenm = "Active"; 
	if(type == "2"){ typenm = "Terminated"; }
	else if(type == "3"){ typenm = "Hired"; }
	return typenm;
}
//==============================================================================
// convert date
//==============================================================================
function cnvDate(date)
{
	var cvtdt = "&nbsp;"; 
	if(date.length == 8)
	{
		var y = date.substring(0,4);
		var m = date.substring(4,6);
		var d = date.substring(6);
		cvtdt = m + "/" + d + "/" + y;
	}
	return cvtdt;
}

//==============================================================================
//Hide selection screen
//==============================================================================
function hidePanel()
{
	document.all.dvItem.innerHTML = " ";
	document.all.dvItem.style.visibility = "hidden";
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
          <th width=25%>
            <b>Retail Concepts, Inc
            <br>Sales Associate by Gender
            <br> Store: <%=sStore%>
            <br> 
            From Week: <%=sFrWeek%> -  To Week: <%=sToWeek%>            
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="GenderHrsSel.jsp"><font color="red" size="-1">Select</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
          <th width=10%>&nbsp;</th>
          <th width=25%>
             <div style="width:350px; background: white;  border: darkred solid 1px; font-size: 12px; text-align:left; padding: 3px;">
             	<table style="font-size: 12px;">
             	<tr><th align=right>Beg:</th><td>M/F Employee's active at the beginning of the week</td></tr>
             	<tr><th align=right>(-):</th><td>M/F Employee's terminated during that week</td></tr>
             	<tr><th align=right>(+):</th><td>M/F Employee's hired during that week</td></tr>
             	<tr><th align=right>End:</th><td>M/F Employee's active at the end of the week</td></tr>
             	</table>
             </div>
          </th>
          <th>&nbsp;</th>          
        </tr>
        
        <tr>
          <td colspan=4 align=left>  
      <table class="tbl02">
        <tr class="trHdr01">
        	<th class="th02" rowspan=4>Store 
        	</th>        	
        	<%for(int j=0; j < iNumOfWk; j++){%>
        		<th class="th02" rowspan=5>&nbsp;</th>        
        		<th class="th02" colspan=32><%=sTyWeek[j]%></th>          		
          	<%}%>
        </tr>
        
        <tr class="trHdr01"> 
        	<%for(int j=0; j < iNumOfWk; j++){%>         	
          		<th class="th02" colspan=16>Female</th>
          		<th class="th02" colspan=16>Male</th>
          	<%}%>                 	
        </tr>
        
        
        <tr class="trHdr01"> 
        	<%for(int j=0; j < iNumOfWk * 2; j++){%>         	
          		<th class="th02" colspan=8>TY</th>
          		<th class="th02" colspan=8>LY</th>
          	<%}%>                 	
        </tr>
        
        <tr class="trHdr01">
        	<%for(int j=0; j < iNumOfWk * 4 ; j++){%>          	
          		<th class="th02" colspan=2>Beg</th>
          		<th class="th02" colspan=2>(-)</th>
          		<th class="th02" colspan=2>(+)</th>
          		<th class="th02" colspan=2>End</th>
          	<%}%> 
         </tr>
        
          	
        <tr class="trHdr01">
        <th class="th02"><a href="javascript: reSort('GRP')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        
        <%for(int j=0; j < iNumOfWk; j++){%>          
            <th class="th02"><a href="javascript: reSort('TYFEACTUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYFEACTDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYFETRMUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYFETRMDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYFEHIRUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYFEHIRDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYFETOTUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYFETOTDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        
        	<th class="th02"><a href="javascript: reSort('LYFEACTUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYFEACTDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYFETRMUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYFETRMDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYFEHIRUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYFEHIRDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYFETOTUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYFETOTDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	
        	<th class="th02"><a href="javascript: reSort('TYMAACTUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYMAACTDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYMATRMUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYMATRMDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYMAHIRUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYMAHIRDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYMATOTUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('TYMATOTDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        
        	<th class="th02"><a href="javascript: reSort('LYMAACTUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYMAACTDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYMATRMUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYMATRMDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYMAHIRUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYMAHIRDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYMATOTUP<%=j+1%>')"><img src="arrowUpGreen.png" style="border:none;" alt="Ascending" width=10 height=10></a></th>
        	<th class="th02"><a href="javascript: reSort('LYMATOTDN<%=j+1%>')"><img src="arrowDown.png" style="border:none;" alt="Descending" width=10 height=10></a></th>
        	        	        	
        <%}%>
        </tr>
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvReg = "";
             String sTrCls = "trDtl06";
             String sFeBack = "#eacce8";
			 String sMaBack = "#daf4b5";				
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfStr; i++) {        	   
        	   	flashsls.setGenLst();
        	   	String sReg = flashsls.getReg();
        		String sStr = flashsls.getStr();
        		String sStrNm = flashsls.getStrNm();
        		
        		String [] sTyFeAct = flashsls.getTyFeAct();
        		String [] sTyFeTrm = flashsls.getTyFeTrm();
        		String [] sTyFeHir = flashsls.getTyFeHir();
        		String [] sTyFeTot = flashsls.getTyFeTot();
        		
        		String [] sLyFeAct = flashsls.getLyFeAct();
        		String [] sLyFeTrm = flashsls.getLyFeTrm();
        		String [] sLyFeHir = flashsls.getLyFeHir();
        		String [] sLyFeTot = flashsls.getLyFeTot();
        		
        		String [] sTyMaAct = flashsls.getTyMaAct();
        		String [] sTyMaTrm = flashsls.getTyMaTrm();
        		String [] sTyMaHir = flashsls.getTyMaHir();
        		String [] sTyMaTot = flashsls.getTyMaTot();
        		
        		String [] sLyMaAct = flashsls.getLyMaAct();
        		String [] sLyMaTrm = flashsls.getLyMaTrm();
        		String [] sLyMaHir = flashsls.getLyMaHir();
        		String [] sLyMaTot = flashsls.getLyMaTot();
        		
        		String [] sTyAct = flashsls.getTyAct();
        		String [] sTyTrm = flashsls.getTyTrm();
        		String [] sTyHir = flashsls.getTyHir();
        		String [] sTyTot = flashsls.getTyTot();
        		
        		String [] sLyAct = flashsls.getLyAct();
        		String [] sLyTrm = flashsls.getLyTrm();
        		String [] sLyHir = flashsls.getLyHir();
        		String [] sLyTot = flashsls.getLyTot();
       			
   				//if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
   				//else {sTrCls = "trDtl06";}
   				
   				if(sFeBack.equals("#f2dcf0"))
   				{
   					sFeBack = "#eacce8";
   	   				sMaBack = "#daf4b5";   	   				
   				}
   				else 
   				{
   					sFeBack = "#f2dcf0";
   	   				sMaBack = "#ebf7d9";   	   				
   				}
   				
   				
   				boolean bRegBrk = false;
   			    if(!sReg.equals(sSvReg) && i > 0){ bRegBrk = true; }
   			 	sSvReg = sReg;    			
           %> 
           
           <%if(bRegBrk){%>
             <tr class="Divider1"><td  colspan="156">&nbsp;</td></tr>
           <%}%>           
                                     
           <tr class="<%=sTrCls%>">
             <td class="td11" nowrap><%=sStr%> - <%=sStrNm%></td>
              
             <%for(int j=0; j < iNumOfWk; j++){%>
             	<td class="td35" nowrap>&nbsp;</td11>            
             	
             	<td class="td64" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sTyFeAct[j]%></td>
             	<td class="td12" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sTyFeTrm[j]%></td>
             	<td class="td12" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sTyFeHir[j]%></td>
             	<td class="td12" style="background:<%=sFeBack%>" colspan=2 nowrap><a href="javascript: getEmpList('<%=sStr%>', 'F', '<%=sTyWeek[j]%>')"><%=sTyFeTot[j]%></a></td>
             	<td class="td65" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sLyFeAct[j]%></td>
             	<td class="td12" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sLyFeTrm[j]%></td>
             	<td class="td12" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sLyFeHir[j]%></td>
             	<td class="td12" style="background:<%=sFeBack%>" colspan=2 nowrap><a href="javascript: getEmpList('<%=sStr%>', 'F', '<%=sLyWeek[j]%>')"><%=sLyFeTot[j]%></a></td>
             	
             	<td class="td64" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sTyMaAct[j]%></td>
             	<td class="td12" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sTyMaTrm[j]%></td>
             	<td class="td12" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sTyMaHir[j]%></td>
             	<td class="td12" style="background:<%=sMaBack%>" colspan=2 nowrap><a href="javascript: getEmpList('<%=sStr%>', 'M', '<%=sTyWeek[j]%>')"><%=sTyMaTot[j]%></a></td>
             	<td class="td65" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sLyMaAct[j]%></td>
             	<td class="td12" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sLyMaTrm[j]%></td>
             	<td class="td12" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sLyMaHir[j]%></td>
             	<td class="td12" style="background:<%=sMaBack%>" colspan=2 nowrap><a href="javascript: getEmpList('<%=sStr%>', 'M', '<%=sLyWeek[j]%>')"><%=sLyMaTot[j]%></a></td>
             <%}%>             
           </tr>
              <script></script>	
           <%}%>
           
           
           
           <tr class="Divider"><td colspan="156">&nbsp;</td></tr>
           <!-- ====== Region Totals ================ -->
           <%
            for(int i=0; i < iNumOfReg; i++){
            flashsls.setRegTot();
          	
            String sReg = flashsls.getReg();
    		String sStr = flashsls.getStr();
    		String sStrNm = flashsls.getStrNm();
    		
    		String [] sTyFeAct = flashsls.getTyFeAct();
    		String [] sTyFeTrm = flashsls.getTyFeTrm();
    		String [] sTyFeHir = flashsls.getTyFeHir();
    		String [] sTyFeTot = flashsls.getTyFeTot();
    		
    		String [] sLyFeAct = flashsls.getLyFeAct();
    		String [] sLyFeTrm = flashsls.getLyFeTrm();
    		String [] sLyFeHir = flashsls.getLyFeHir();
    		String [] sLyFeTot = flashsls.getLyFeTot();
    		
    		String [] sTyMaAct = flashsls.getTyMaAct();
    		String [] sTyMaTrm = flashsls.getTyMaTrm();
    		String [] sTyMaHir = flashsls.getTyMaHir();
    		String [] sTyMaTot = flashsls.getTyMaTot();
    		
    		String [] sLyMaAct = flashsls.getLyMaAct();
    		String [] sLyMaTrm = flashsls.getLyMaTrm();
    		String [] sLyMaHir = flashsls.getLyMaHir();
    		String [] sLyMaTot = flashsls.getLyMaTot();
    		
    		String [] sTyAct = flashsls.getTyAct();
    		String [] sTyTrm = flashsls.getTyTrm();
    		String [] sTyHir = flashsls.getTyHir();
    		String [] sTyTot = flashsls.getTyTot();
    		
    		String [] sLyAct = flashsls.getLyAct();
    		String [] sLyTrm = flashsls.getLyTrm();
    		String [] sLyHir = flashsls.getLyHir();
    		String [] sLyTot = flashsls.getLyTot();
				
       	    %>  
           <tr id="trTot" class="trDtl041">             
             <td class="td11" nowrap><%=sStrNm%></td>
             
             <%for(int j=0; j < iNumOfWk; j++){%>
             	<td class="td35" nowrap>&nbsp;</td11>  
             	 
             	<td class="td64" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sTyFeAct[j]%></td>
             	<td class="td12" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sTyFeTrm[j]%></td>
             	<td class="td12" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sTyFeHir[j]%></td>
             	<td class="td12" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sTyFeTot[j]%></td>
             	<td class="td65" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sLyFeAct[j]%></td>
             	<td class="td12" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sLyFeTrm[j]%></td>
             	<td class="td12" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sLyFeHir[j]%></td>
             	<td class="td12" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sLyFeTot[j]%></td>
             	
             	<td class="td64" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sTyMaAct[j]%></td>
             	<td class="td12" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sTyMaTrm[j]%></td>
             	<td class="td12" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sTyMaHir[j]%></td>
             	<td class="td12" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sTyMaTot[j]%></td>
             	<td class="td65" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sLyMaAct[j]%></td>
             	<td class="td12" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sLyMaTrm[j]%></td>
             	<td class="td12" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sLyMaHir[j]%></td>
             	<td class="td12" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sLyMaTot[j]%></td>          	  
             <%}%>             
           </tr>
           <%} %>
           
           
           
            <tr class="Divider"><td colspan="156">&nbsp;</td></tr>
           <!-- ======Total ================ -->
           <%
           	flashsls.setTotal();
           	String sReg = flashsls.getReg();
   			String sStr = flashsls.getStr();
   			String sStrNm = flashsls.getStrNm();
   		
   			String [] sTyFeAct = flashsls.getTyFeAct();
   			String [] sTyFeTrm = flashsls.getTyFeTrm();
   			String [] sTyFeHir = flashsls.getTyFeHir();
   			String [] sTyFeTot = flashsls.getTyFeTot();
   		
   			String [] sLyFeAct = flashsls.getLyFeAct();
   			String [] sLyFeTrm = flashsls.getLyFeTrm();
   			String [] sLyFeHir = flashsls.getLyFeHir();
   			String [] sLyFeTot = flashsls.getLyFeTot();
   		
   			String [] sTyMaAct = flashsls.getTyMaAct();
   			String [] sTyMaTrm = flashsls.getTyMaTrm();
   			String [] sTyMaHir = flashsls.getTyMaHir();
   			String [] sTyMaTot = flashsls.getTyMaTot();
   		
   			String [] sLyMaAct = flashsls.getLyMaAct();
   			String [] sLyMaTrm = flashsls.getLyMaTrm();
   			String [] sLyMaHir = flashsls.getLyMaHir();
   			String [] sLyMaTot = flashsls.getLyMaTot();
   		
   			String [] sTyAct = flashsls.getTyAct();
   			String [] sTyTrm = flashsls.getTyTrm();
   			String [] sTyHir = flashsls.getTyHir();
   			String [] sTyTot = flashsls.getTyTot();
   		
   			String [] sLyAct = flashsls.getLyAct();
   			String [] sLyTrm = flashsls.getLyTrm();
   			String [] sLyHir = flashsls.getLyHir();
   			String [] sLyTot = flashsls.getLyTot();
       	    %>  
           <tr id="trTot" class="trDtl12">             
             <td class="td11" nowrap>Total</td>
             
             <%for(int j=0; j < iNumOfWk; j++){%>
             	<td class="td35" nowrap>&nbsp;</td11>
             	
             	<td class="td64" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sTyFeAct[j]%></td>
             	<td class="td12" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sTyFeTrm[j]%></td>
             	<td class="td12" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sTyFeHir[j]%></td>
             	<td class="td12" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sTyFeTot[j]%></td>
             	<td class="td65" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sLyFeAct[j]%></td>
             	<td class="td12" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sLyFeTrm[j]%></td>
             	<td class="td12" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sLyFeHir[j]%></td>
             	<td class="td12" style="background:<%=sFeBack%>" colspan=2 nowrap><%=sLyFeTot[j]%></td>
             	
             	<td class="td64" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sTyMaAct[j]%></td>
             	<td class="td12" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sTyMaTrm[j]%></td>
             	<td class="td12" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sTyMaHir[j]%></td>
             	<td class="td12" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sTyMaTot[j]%></td>
             	<td class="td65" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sLyMaAct[j]%></td>
             	<td class="td12" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sLyMaTrm[j]%></td>
             	<td class="td12" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sLyMaHir[j]%></td>
             	<td class="td12" style="background:<%=sMaBack%>" colspan=2 nowrap><%=sLyMaTot[j]%></td>             	  
             <%}%>
           </tr> 
           <tr>
  
      
           <tr class="trHdr01">
        	<th class="th02" rowspan=4>Store 
        	<%for(int j=0; j < iNumOfWk * 4 ; j++){%> 
        	    <%if(j%4==0){%><th class="th02" rowspan=4>&nbsp;</th><%}%>         	
          		<th class="th02" colspan=2>Beg</th>
          		<th class="th02" colspan=2>(-)</th>
          		<th class="th02" colspan=2>(+)</th>
          		<th class="th02" colspan=2>End</th>
          	<%}%>
        	</th>        	
        	
            </tr>
        
        <tr class="trHdr01"> 
        	<%for(int j=0; j < iNumOfWk * 2; j++){%>         	
          		<th class="th02" colspan=8>TY</th>
          		<th class="th02" colspan=8>LY</th>
          	<%}%>                 	
        </tr>
        
        <tr class="trHdr01"> 
        	<%for(int j=0; j < iNumOfWk; j++){%>         	
          		<th class="th02" colspan=16>Female</th>
          		<th class="th02" colspan=16>Male</th>
          	<%}%>                 	
        </tr>
        
        <tr class="trHdr01">
        	<%for(int j=0; j < iNumOfWk; j++){%>
        		        
        		<th class="th02" colspan=32><%=sTyWeek[j]%></th>          		
          	<%}%>
        	 
         </tr> 
           
               
         </table>
         
         <br><br>
         
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

