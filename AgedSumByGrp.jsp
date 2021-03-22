<!DOCTYPE html>	
<%@ page import="inventoryreports.AgedSumByGrp, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String [] sSelDiv = request.getParameterValues("Div");
   String [] sSelStr = request.getParameterValues("Str");
   String sSelDpt = request.getParameter("Dpt");
   String sSelCls = request.getParameter("Cls");
   String sSelVen = request.getParameter("Ven");
   String sUcr = request.getParameter("Ucr");
   String sNumMon = request.getParameter("NumMon");
   String sLevel = request.getParameter("Level");
   String sPrec = request.getParameter("Prec");
   String sSort = request.getParameter("Sort");
   
   if(sNumMon == null){ sNumMon = "12"; } 
   if(sPrec == null){ sPrec = "3"; }
   if(sUcr == null){ sUcr = "C"; }
   if(sSort == null){ sSort = "Grp"; }
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=AgedSumByGrp.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	
	AgedSumByGrp agedSum = new AgedSumByGrp();	   
	System.out.println(sSelStr[0] + "| div=" + sSelDiv[0] + "| dpt=" + sSelDpt + "| cls=" + sSelCls 
			+ "| ven=" + sSelVen + "| mon=" + sNumMon + "| lvl=" + sLevel + "| prc=" + sPrec + "|" 
	        + sSort + "|" + sUser);
	agedSum.setAged(sSelStr, sSelDiv, sSelDpt, sSelCls, sSelVen
			, sNumMon, sLevel, sPrec, sSort, sUser);

	int iNumOfMon = agedSum.getNumOfMon();
	int iNumOfAge = agedSum.getNumOfAge();
	String sSelStrJsa = agedSum.cvtToJavaScriptArray(sSelStr);
	String sSelDivJsa = agedSum.cvtToJavaScriptArray(sSelDiv);
	
	agedSum.setGrpLvl();
	String sGrpLvl = agedSum.getGrpLvl();
	String sGrpLvlNm = agedSum.getGrpLvlNm();
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Aged Summary Report</title>

<SCRIPT>

//--------------- Global variables -----------------------
var Store = [<%=sSelStrJsa%>];
var Div = [<%=sSelDivJsa%>];
var Dpt = "<%=sSelDpt%>";
var Cls = "<%=sSelCls%>";
var Ven = "<%=sSelVen%>";
var NumMon = "<%=sNumMon%>";
var Level = "<%=sLevel%>";
var Sort = "<%=sSort%>"
var Prec = "<%=sPrec%>"
var User = "<%=sUser%>";
var Ucr = "<%=sUcr%>";
var GrpLvl = "<%=sGrpLvl%>";
var NumOfAge = "<%=iNumOfAge%>";

var progressIntFunc = null;
var progressTime = 0;

//--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
//reload page
//==============================================================================
function restart()
{
	window.location.reload();  
}
//==============================================================================
// re-sort page
//==============================================================================
function resort(sort)
{		
	
}
//==============================================================================
//drill down report
//==============================================================================
function drillDown(grp)
{
	url = "AgedSumByGrp.jsp?NumMon=" + NumMon
	      + "&Prec=" + Prec
	      + "&Ucr=" + Ucr
	      + "&Sort=" + Sort
	      
    if(GrpLvl == "S")
	{
    	url += "&Str=" + grp;    	
    	for(var i=0; i < Div.length; i++) { url += "&Div=" + Div[i]; }
    	url += "&Dpt=" + Dpt + "&Cls=" + Cls + "&Ven=" + Ven;
    	url += "&Level=D";
	}
    else if(GrpLvl == "D")    	
	{
    	for(var i=0; i < Store.length; i++) { url += "&Str=" + Store[i]; }      	
    	url += "&Div=" + grp + "&Dpt=ALL&Cls=ALL&Ven=ALL";
    	url += "&Level=" + Level;
	}
    else if(GrpLvl == "P")    	
	{
    	for(var i=0; i < Store.length; i++) { url += "&Str=" + Store[i]; }      	
    	url += "&Div=" + Div[0] + "&Dpt=" + grp + "&Cls=ALL&Ven=ALL";
    	url += "&Level=" + Level;
	}
    else if(GrpLvl == "C")    	
	{
    	for(var i=0; i < Store.length; i++) { url += "&Str=" + Store[i]; }      	
    	url += "&Div=" + Div[0] + "&Dpt=" + Dpt + "&Cls=" + grp + "&Ven=ALL"; 
    	url += "&Level=" + Level;
	}
    else if(GrpLvl == "V")    	
	{
    	for(var i=0; i < Store.length; i++) { url += "&Str=" + Store[i]; }      	
    	url += "&Div=" + Div[0] + "&Dpt=" + Dpt + "&Cls=" + grp + "&Ven=ALL"; 
    	url += "&Level=S";
	}
	  
	//alert(url);
	window.location.href=url;
}
//==============================================================================
//drill down report
//==============================================================================
function switchLvl()
{
	url = "AgedSumByGrp.jsp?NumMon=" + NumMon
	      + "&Prec=" + Prec
	      + "&Ucr=" + Ucr
	      + "&Sort=" + Sort
	;
	for(var i=0; i < Store.length; i++) { url += "&Str=" + Store[i]; }
	for(var i=0; i < Div.length; i++) { url += "&Div=" + Div[i]; }
	url += "&Dpt=" + Dpt + "&Cls=" + Cls + "&Ven=" + Ven;  
	
	if(Level == "S"){ url += "&Level=D" ;}
	else { url += "&Level=S" ;}
	
  	window.location.href=url;
}
//==============================================================================
// switch UCR level 
//==============================================================================
function setType(obj)
{
    var sel = obj.value;
    var dspunt = "none";
    var dspcst = "none";
    var dspret = "none";
    
    if(sel == "U"){ dspunt = "inline";}
    if(sel == "C"){ dspcst = "inline";}
    if(sel == "R"){ dspret = "inline";}
    
	var spnunt = $("span[id='spnUnit']");		
	var spncst = $("span[id='spnCost']");	
	var spnret = $("span[id='spnRet']");	
	
	for(var i=0; i < spnunt.length; i++)
	{ 
		spnunt[i].style.display = dspunt; 
	}
	for(var i=0; i < spncst.length; i++){ spncst[i].style.display = dspcst; }
	for(var i=0; i < spnret.length; i++){ spnret[i].style.display = dspret; }
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
}</SCRIPT>
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
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th >
            <b>Retail Concepts, Inc
            <br>Aged Summary Report
                      
            <br>Div:  
                <%String sComa = "";
                for(int i=0; i < sSelDiv.length; i++){%><%=sComa%> <%=sSelDiv[i]%> <%sComa=",";}
                if(sSelDiv.length == 1){%>
                    Dpt: <%=sSelDpt%> Class: <%=sSelCls%>
                <%}%>
                      
            <br>Store: 
                <%sComa = "";
                for(int i=0; i < sSelStr.length; i++){%><%=sComa%> <%=sSelStr[i]%> <%sComa=",";}%>
            
            <br>By <%if(sUcr.equals("U")){%>Unit<%} 
                     else if(sUcr.equals("C")){%>Cost<%} 
                     else if(sUcr.equals("")){%>Retail<%}%>
            </b>
            <br>Switch to 
                <input name="Ucr" type="radio" value="U" onclick="setType(this)" <%if(sUcr.equals("U")){%>checked<%}%>>Unit &nbsp; &nbsp;
                <input name="Ucr" type="radio" value="C" onclick="setType(this)" <%if(sUcr.equals("C")){%>checked<%}%>>Cost &nbsp; &nbsp;
                <input name="Ucr" type="radio" value="R" onclick="setType(this)" <%if(sUcr.equals("R")){%>checked<%}%>>Retail
            
            <br><a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
                <a href="AgedSumByGrpSel.jsp"><font color="red" size="-1">Selection</font></a>&#62; 
            <font size="-1">This Page</font>
             
          </th>
       </tr>      
        <tr>
          <td>  
          
          
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02" rowspan=2><%=sGrpLvlNm%>
             <%if(sSelStr.length > 1 && sGrpLvl.equals("S")){%><br><a href="javascript: switchLvl()">By Merchandise</a><%}%>
             <%if(sSelStr.length > 1 && sLevel.equals("D")){%><br><a href="javascript: switchLvl()">By Store</a><%}%>
          </th>
          <th class="th02" rowspan=2>Current<br>Aged<br>Inv</th>
          <th class="th02" colspan="<%=iNumOfMon%>">Prior 12 Fiscal Months</th>
          <th class="th02" rowspan=2>Current<br>On-hand<br>Inv</th>
          <th class="th02" rowspan=2>Aged<br>%</th>
        </tr>
        
        <tr class="trHdr01">          
          <%for(int i=0; i < iNumOfMon; i++)
            {
        	  agedSum.setMonYear();
        	  String sMon = agedSum.getMon();
  			  String sMonNm = agedSum.getMonNm();
  			  String sYear = agedSum.getYear();
  			  String sEndPer = agedSum.getEndPer();
          %>
            <th class="th02" >FY <%=sMonNm %><br><%=sYear%><br>&nbsp;<%=sEndPer%>&nbsp;</th>
          <%}%>
        </tr>
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl04"; 
             int iArg = -1;
             int iSpn = 0;
           %>
           <%for(int i=0; i < iNumOfAge; i++) {        	   
        	   agedSum.setDetail();
   			    
        	   String sGrp = agedSum.getGrp();
   			   String sGrpNm = agedSum.getGrpNm();
   		       String [] sUnit = agedSum.getUnit();			
   			   String [] sCost = agedSum.getCost();
   			   String [] sRet = agedSum.getRet();
   			   String sPrcUnit = agedSum.getPrcUnit();
   			   String sPrcCost = agedSum.getPrcCost();
   			   String sPrcRet = agedSum.getPrcRet();
   			   
   			   if(sGrpNm.equals("Total")){ sTrCls = "trDtl15"; }
   			   String sStyUnit = "style=\"display: none;\"";
   			   if(sUcr.equals("U")){ sStyUnit = "style=\"display: inline;\""; }
   			   String sStyCost = "style=\"display: none;\"";
			   if(sUcr.equals("C")){ sStyCost = "style=\"display: inline;\""; }
			   String sStyRet = "style=\"display: none;\"";
			   if(sUcr.equals("R")){ sStyRet = "style=\"display: inline;\""; }
           %>                           
                <tr id="trArea<%=i%>" class="<%=sTrCls%>">
                <td class="td11" nowrap>
                   <%if(!sGrpLvl.equals("V") && !sGrpNm.equals("Total")){%><a href="javascript: drillDown(<%=sGrp%>)"><%=sGrp%> - <%=sGrpNm%></a><%}%>
                   <%if(sGrpLvl.equals("V") && !sGrpNm.equals("Total")){%><%=sGrp%> - <%=sGrpNm%><%}%>
                   <%if(sGrpNm.equals("Total")){%>Total<%}%> 
                </td>
                <td class="td12" nowrap>
                    <span id="spnUnit" <%=sStyUnit%>><%=sUnit[iNumOfMon+1]%></span>
                    <span id="spnCost" <%=sStyCost%>><%=sCost[iNumOfMon+1]%></span>
                    <span id="spnRet"  <%=sStyRet%>><%=sRet[iNumOfMon+1]%></span>
                </td>
                <%for(int j=0; j < iNumOfMon; j++){%>
                    <td class="td12" nowrap>
                       <span id="spnUnit" <%=sStyUnit%>><%=sUnit[j]%></span>
                       <span id="spnCost" <%=sStyCost%>><%=sCost[j]%></span>
                       <span id="spnRet"  <%=sStyRet%>><%=sRet[j]%></span>
                    </td>
                <%}%>                
                <td class="td12" nowrap>
                	<span id="spnUnit" <%=sStyUnit%>><%=sUnit[iNumOfMon]%></span>
                	<span id="spnCost" <%=sStyCost%>><%=sCost[iNumOfMon]%></span>
                	<span id="spnRet"  <%=sStyRet%>><%=sRet[iNumOfMon]%></span>
                </td>
                <td class="td12" nowrap>
                	<span id="spnUnit" <%=sStyUnit%>><%=sPrcUnit%></span>
                	<span id="spnCost" <%=sStyCost%>><%=sPrcCost%></span>
                	<span id="spnRet"  <%=sStyRet%> ><%=sPrcRet%></span>
                </td>
              </tr>
              <script></script>	
           <%}%>
           
            
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
   
 </body>
</html>
<%
agedSum.disconnect();
agedSum = null;
}
%>