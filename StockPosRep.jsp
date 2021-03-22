<!DOCTYPE html>
<%@ page import="salesvelocity.StockPosRep, rciutility.StoreSelect, java.util.*, java.text.*"%>
<%
   String [] sSelStr = request.getParameterValues("Str");
   String [] sDiv = request.getParameterValues("Div");
   String sDpt = request.getParameter("Dpt");
   String sCls = request.getParameter("Cls");
   String sLevel = request.getParameter("Level");
   String sUcr = request.getParameter("Ucr");
   String sPrec = request.getParameter("Prec");
   String sToMon = request.getParameter("ToMon");
   String sSort = request.getParameter("Sort");
      
   if(sSort == null || sSort.equals("")){sSort = "STKPOS";}
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=StockPosRep.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	 
	StockPosRep stokpos = new StockPosRep(sSelStr, sDiv, sDpt, sCls, sLevel, sToMon, sUcr
			, sPrec, sSort, sUser );
	
	int iNumOfGrp = stokpos.getNumOfGrp();  
    String [] sMon = stokpos.getMon();
    String [] sYear = stokpos.getYear();
    String [] sMonNm = stokpos.getMonNm();
    int iActMon = Integer.parseInt(sToMon) + 1;
    int iActYr = Integer.parseInt(sYear[iActMon]) - 1;
    
    int iNumOfReg = stokpos.getNumOfReg();
    
    String sGrpHdr = "Str";
    String sAltGrp = "Div";
    if(sLevel.equals("Div")){ sGrpHdr = "Div"; }
    else if(sLevel.equals("Dpt")){ sGrpHdr = "Dpt"; }
    else if(sLevel.equals("Cls")){ sGrpHdr = "Cls"; }
    
    if(sLevel.equals("Div") || sLevel.equals("Dpt") || sLevel.equals("Cls")){ sAltGrp = "Str"; }
    else if(sLevel.equals("Str") && sDiv.length > 1){ sAltGrp = "Div"; }
    else if(sLevel.equals("Str") && sDiv[0].equals("ALL") && sDpt.equals("ALL") && sCls.equals("ALL")){ sAltGrp = "Div"; }    
    else if(sLevel.equals("Str") && sDpt.equals("ALL") && sCls.equals("ALL")){ sAltGrp = "Dpt"; }
    else if(sLevel.equals("Str") ){ sAltGrp = "Cls"; }
 
    System.out.println( "sAltGrp=" + sAltGrp );
    
    int [] iColWidth = new int[]{ 20 
    		,9,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
    		, 20};             
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE11" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>

<title>Stock Position</title>

<SCRIPT>

//--------------- Global variables -----------------------
var SelStr = [<%=stokpos.cvtToJavaScriptArray(sSelStr)%>];
var Div = [<%=stokpos.cvtToJavaScriptArray(sDiv)%>];
var Dpt = "<%=sDpt%>";
var Cls = "<%=sCls%>";
var Level = "<%=sLevel%>"
var Ucr = "<%=sUcr%>";
var Prec = "<%=sPrec%>";
var ToMon = "<%=sToMon%>";
var Sort = "<%=sSort%>"
var User = "<%=sUser%>";

var NumOfGrp = "<%=iNumOfGrp%>";
var NumOfReg = "<%=iNumOfReg%>";

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
function drilldown(grp)
{
	var url="StockPosRep.jsp?"
	 
	if(Level == "Str" && Div[0] == "ALL" && Dpt == "ALL" && Cls == "ALL"){ Level = "Div";  SelStr = [ grp ]; }
	
	else if(Level == "Str" && Div.length > 1 ){ Level = "Div"; SelStr = [ grp ]; }
	
	else if(Level == "Str" && Div[0] != "ALL" && Dpt == "ALL" && Cls == "ALL"){ Level = "Dpt"; SelStr = [ grp ]; }
	else if(Level == "Str" && Div[0] != "ALL" && Dpt != "ALL" && Cls == "ALL"){ Level = "Cls"; SelStr = [ grp ]; }
	else if(Level == "Str" && Div[0] != "ALL" && Dpt != "ALL" && Cls != "ALL"){ Level = "Cls"; SelStr = [ grp ]; }
	
	else if(Level == "Div"){ Level = "Dpt"; Div = [grp];  }
	else if(Level == "Dpt"){ Level = "Cls"; Dpt = [grp];  }
	 	
	for(var i=0; i < Div.length; i++){url += "&Div=" + Div[i];}
	for(var i=0; i < SelStr.length; i++){url += "&Str=" + SelStr[i];}
	
	url += "&Dpt=" + Dpt
	  + "&Cls=" + Cls
	  + "&Level=" + Level
	  + "&Ucr=" + Ucr
	  + "&Prec=" + Prec
	  + "&Prec=" + Prec
	  + "&ToMon=" + ToMon
	;		
	
	window.location.href = url;
}
//==============================================================================
// switch displayed value
//==============================================================================
function switchType(type)
{
	var url="StockPosRep.jsp?";
	url +="&Dpt=" + Dpt
	  + "&Cls=" + Cls
	  + "&Level=" + Level
	  + "&Ucr=" + type	
	  + "&ToMon=" + ToMon
	;
	
	if(type == "U"){ url += "&Prec=1"; }
	else { url += "&Prec=3"; }
	
	
	for(var i=0; i < Div.length; i++){url += "&Div=" + Div[i];}
	for(var i=0; i < SelStr.length;i++){ url += "&Str=" +  SelStr[i]; }
	
	
	window.location.href = url;
}
//==============================================================================
//switch by group: Str to div,dpt,cls or vs. to Str
//==============================================================================
function switchGrpBy(grp)
{
	var url="StockPosRep.jsp?";
	url += "&Dpt=" + Dpt
	  + "&Cls=" + Cls
	  + "&Level=" + grp
	  + "&Ucr=" + Ucr
	  + "&Prec=" + Prec
	  + "&ToMon=" + ToMon
	;	
	
	for(var i=0; i < Div.length; i++){url += "&Div=" + Div[i];}
	for(var i=0; i < SelStr.length;i++){ url += "&Str=" +  SelStr[i]; }	
	
	window.location.href = url;
}         
//==============================================================================
// sort by
//==============================================================================
function resort(sort)
{
	var url="StockPosRep.jsp?";
	url += "&Dpt=" + Dpt
	  + "&Cls=" + Cls
	  + "&Level=" + Level
	  + "&Ucr=" + Ucr
	  + "&Prec=" + Prec
	  + "&Sort=" + sort
	  + "&ToMon=" + ToMon
	;	
	
	for(var i=0; i < Div.length; i++){url += "&Div=" + Div[i];}
	for(var i=0; i < SelStr.length;i++){ url += "&Str=" +  SelStr[i]; }	
	
	window.location.href = url;
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
				
				
				/*var col0hdr1 = "#thGrp";		 
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
				*/
			
				var offsetTop = $(this).scrollTop();
		    	if(offsetTop > 150)
		    	{
		    		$("#trHdr01").css({"display": "none"});
		    		$("#trHdr02").css({"display": "none"});		    		
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
		  
		  var rowScale = document.getElementById("trScale");
		  var table = document.getElementById("tblClone");  
		  var clone1 = row1.cloneNode(true); // copy children too  
		  var clone2 = row2.cloneNode(true);
		  var clone3 = row3.cloneNode(true);		  
		  var cloneScale = rowScale.cloneNode(true);
		  
		  
		  clone1.id = "trClone01"; // change id or other attributes/contents
		  clone2.id = "trClone02";
		  clone3.id = "trClone03";
		  cloneScale.id = "trCloneScale";
		  
		// add new row to end of table		  
		  table.appendChild(cloneScale); 
		  table.appendChild(clone1); 		  
		  table.appendChild(clone2); 
		  table.appendChild(clone3);
		  
		  var hdr1 = table.childNodes[1].childNodes[1];
		  var hdr2 = table.childNodes[3].childNodes[1];
		  hdr1.id = "thFix1";
		  hdr2.id = "thFix2";
		  
		  $("#tblClone").css({"display": "none"});  
		}
//==============================================================================
// made header visible 
//==============================================================================
function madeHdrVisible(elem) 
{
	var ey = $(elem).offset().top;
	ey = ey.toFixed(0);
	
	if(ey > 0){ ey = ey-1; }
	
	$(window).scrollTop(ey);
	view = ey;
}
//==============================================================================
// get first seen inseet index
//==============================================================================
function getInsertRowIndex()
{
	var firstVisible = -1; 
	for(var i=0; i < NumOfGrp; i++)
	{
		var drow = document.getElementById("trGrp" + i);	
		if(isScrolledIntoView(drow))
		{
			firstVisible = i; 
			break;
		}
	}
	return firstVisible;
} 
//==============================================================================
// check if row is visible now
//==============================================================================
function isScrolledIntoView(elem)
{
    var docViewTop = $(window).scrollTop();
    var docViewBottom = docViewTop + $(window).height();

    var elemTop = $(elem).offset().top;
    var elemBottom = elemTop + $(elem).height();

    return ((elemBottom <= docViewBottom) && (elemTop >= docViewTop));
}
//==============================================================================
// remove clone 
//==============================================================================
function removeClone() 
{
	clone = false;
	
	var table = document.getElementById("tblData");
	
	var row1 = document.getElementById("trHdr01c");
	var ri1 = row1.rowIndex;
	table.deleteRow(ri1);
	
	var row2 = document.getElementById("trHdr02c");
	var ri2 = row2.rowIndex;
	table.deleteRow(ri2);
	
	var row3 = document.getElementById("trHdr03c");
	var ri3 = row3.rowIndex;
	table.deleteRow(ri3);
	
	var row1 = document.getElementById("trHdr01");  
	var row2 = document.getElementById("trHdr02");
	var row3 = document.getElementById("trHdr03");
	
	row1.style.display = "table-row";
	row2.style.display = "table-row";
	row3.style.display = "table-row";
}
</script>			


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
<!-- div id="dvHelp" class="dvHelp"><a href="Intranet Reference Documents/2.0 MOS Approval Recap.pdf" class="helpLink" target="_blank">&nbsp;</a></div -->
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
            <br>Stock Position Report 
            <br>
            Store(s): 
            <%String sComa = "";
              for(int i=0; i < sSelStr.length; i++){%>
              <%=sComa + sSelStr[i]%><%sComa=", ";%>
            <%}%>
            <br>
            <%if(sDiv.length == 1){%>
            	Div: <%=sDiv[0]%>&nbsp; &nbsp; Dpt: <%=sDpt%>&nbsp; &nbsp; Cls: <%=sCls%>
            <%} else{%>
               <% sComa = "";
               for(int i=0; i < sDiv.length; i++){%><%=sComa%> <%=sDiv[i]%><%sComa=","; }%>
            <%}%>
            <br>Calculate stock Position through: <%=sMonNm[Integer.parseInt(sToMon) + 1]%>
             <%=sYear[Integer.parseInt(sToMon) + 1]%>
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="StockPosRepSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;               
              <br>
                <INPUT name="Type" type="radio" onclick="switchType(this.value)" value="U" <%if(sUcr.equals("U")){%>checked<%}%>>Unit &nbsp; 
                <INPUT name="Type" type="radio" onclick="switchType(this.value)" value="C" <%if(sUcr.equals("C")){%>checked<%}%>>Cost &nbsp; 
                <INPUT name="Type" type="radio" onclick="switchType(this.value)" value="R" <%if(sUcr.equals("R")){%>checked<%}%>>Retail &nbsp;                                  
          </th>
        </tr>
        </table>
        
        
       <!-- ======================= Clone Header ========================================== -->
       <table id="tblClone" class="tbl01" style="position: absolute; text-align: left" ></table>
       <!-- ======================= End of Clone Header =================================== -->
       
          
      <table class="tbl02" id="tblData">
        <thead id="tHead01">
        <tr class="trHdr01" id="trHdr01">
        	<th class="th25" width="5%" rowspan=3><a href="javascript: resort('GRP')"><%=sGrpHdr%></a>
        	  <br><br><a href="javascript: switchGrpBy('<%=sAltGrp%>')">by <%=sAltGrp%></a>
        	</th>
        	<th class="th25" width="5%" rowspan=3><a href="javascript: resort('CURBEGINV')">Current<br>Beg<br>Inv</a></th>
        	<th class="th25" width="5%" colspan=3>Sales History</th>
        	<th class="th25" width="5%" rowspan=3>Actual<br>Current<br>MTD Sls</th>
        	<th class="th25" width="5%" rowspan=3>Planned<br>Current<br>MTD Sls</th>        	
        	<th class="th25" width="5%" colspan=12>Future Sales</th>
        	<th class="th25" width="5%" rowspan=3><a href="javascript: resort('ACTLSTPLN')">Actual<br><%=sMonNm[iActMon]%> <%=iActYr%><br>Inventory</a></th>
        	<th class="th25" width="5%" rowspan=3>Planned<br><%=sMonNm[iActMon]%> <%=sYear[iActMon]%><br>Inventory</th>
        	<th class="th25" width="5%" rowspan=3><a href="javascript: resort('OPNORD')">Total<br>Open<br>Orders</a></th>
        	<th class="th25" width="5%" rowspan=3><a href="javascript: resort('STKPOS')">Stock<br>Position</a></th>
        	<th class="th25" width="5%" colspan=4><a href="javascript: resort('ACTSUP')">Weekly Supply</a></th>        	
        	<th class="th25" width="5%" rowspan=3><a href="javascript: resort('GRP')"><%=sGrpHdr%></a></th>
        </tr>
        
        <tr class="trHdr01" id="trHdr02">
        	<%for(int i = 0; i < 3; i++){%>
        		<th class="th25" id="thPrior" nowrap><%=sMonNm[i]%> <%=sYear[i]%></th>
        	<%}%>
        	<%for(int i = 2; i < 14; i++){%>
        		<th class="th25" id="thPrior" nowrap><%=sMonNm[i]%> 
        		 <%if(i==2){%><%=sYear[3]%><%} else{%><%=sYear[i]%><%} %>        		
        	<%}%>
        	<th class="th25" width="5%" rowspan=2><a href="javascript: resort('ACTSUP')">LM<br>Actual<br>Sales</a></th>
        	<th class="th25" width="5%" rowspan=2><a href="javascript: resort('ACTSUP')">CM<br>Actual<br>Sales</a></th>
        	<th class="th25" width="5%" rowspan=2 ><a href="javascript: resort('PLANSUP')">Planned<br>Sales</a></th>
        	<th class="th25" width="5%" rowspan=2 ><a href="javascript: resort('PLANPOSUP')">Planned<br>Sales<br>w/PO</a></th>
        </tr>
        
        <tr class="trHdr01" id="trHdr03">
        	<th class="th25" id="thPrior" nowrap>Inventory</th>
        	<th class="th25" id="thPrior" nowrap>Actual</th>
        	<th class="th25" id="thPrior" nowrap>Actual</th>
        	<%for(int i = 2; i < 14; i++){%>
        	    <%if(i==2){%><th class="th25" id="thPrior" nowrap>Remain</th><%}
        	    else {%><th class="th25" id="thPrior" nowrap>Planned</th><%}%>
        	<%}%>  
        </tr>
       </thead> 
       <tbody id="tBody01">
<!------------------------------- order/sku --------------------------------->
           <%String sSvReg = "";
             String sTrCls = "trDtl06"; 
             String sTdSpClr = "#e3f7eb";
             
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfGrp; i++) {        	   
        	   stokpos.setStockPos();
               String sGrp = stokpos.getGrp();
               String sGrpNm = stokpos.getGrpNm();
               String sReg = stokpos.getReg();
               String [] sRow = stokpos.getRow();        
   			
   				if(sTrCls.equals("trDtl21")){sTrCls = "trDtl20"; }
   				else {sTrCls = "trDtl21"; sTdSpClr = "#efd3ac";}
   				
   				if(sRow[21].indexOf("-") < 0){sTdSpClr = "#e3f7eb";}
   				else{sTdSpClr = "#f9dddb";}
   				
   				boolean bRegBrk = false;
   			    if(!sReg.equals(sSvReg) && i > 0){ bRegBrk = true; }
   			 	sSvReg = sReg; 
   			 	
   			 	/*if(iColWidth[0] < (sGrp.length() + sGrpNm.length() + 1))
   			 	{ 
   			 		iColWidth[0] = (sGrp.trim().length() + sGrpNm.trim().length());
   			 	    iColWidth[iColWidth.length - 1] = (sGrp.length() + sGrpNm.length() + 1);
   			 	} */
           %> 
           
           <%if(bRegBrk){%>
             <tr class="Divider1"><td  colspan="156">&nbsp;</td></tr>
           <%}%>       
                                     
           <tr id="trGrp<%=i%>" class="<%=sTrCls%>">
             <td id="tdStr<%=i%>" class="td11" nowrap>
             	<%if(!sLevel.equals("Cls")){%><a href="javascript: drilldown('<%=sGrp%>')"><%=sGrp%> <%=sGrpNm%></a><%} 
             	else{%><%=sGrp%> <%=sGrpNm%><%}%>
             </td>
             <%for(int j=0; j < 26; j++){%>
                <%if(j != 21 ){%>
        			<td id="tdRow<%=i%>C<%=j%>" class="td12" nowrap><%=sRow[j]%></td>
        		<%} else {%>
        		    <td id="tdRow<%=i%>C<%=j%>" class="td12" style="background: <%=sTdSpClr%>" nowrap><b><%=sRow[j]%></b></td>
        		<%}%>	
        	 <%}%>
        	 
        	 <td id="tdStr<%=i%>" class="td11" nowrap>
             	<%if(!sLevel.equals("Cls")){%><a href="javascript: drilldown('<%=sGrp%>')"><%=sGrp%> <%=sGrpNm%></a><%} 
             	else{%><%=sGrp%> <%=sGrpNm%><%}%>
             </td>           
           </tr>
           <%}%>
        </tbody>     
           
       <!-- =================== Region Total ============= -->
       <%if(sLevel.equals("Str")){%>    
           <tr class="Divider"><td colspan=50>&nbsp;</td></tr>
           <%
           for(int i=0; i < iNumOfReg; i++ )
       	   {
        	   stokpos.setRegTot(); 
        	   String sGrp = stokpos.getGrp();
               String sGrpNm = stokpos.getGrpNm();
               String sReg = stokpos.getReg();
               String [] sRow = stokpos.getRow();
               
               if(sRow[21].indexOf("-") < 0){sTdSpClr = "#e3f7eb";}
  				else{sTdSpClr = "#f9dddb";}
               
           %>
           <tr id="trRegTot" class="trDtl02">
             <td class="td11" nowrap><b><%=sGrpNm%></b></td>
             <%for(int j=0; j < 26; j++){%>
        		<%if(j != 21 ){%>
        			<td id="tdRow<%=i%>C<%=j%>" class="td12" nowrap><%=sRow[j]%></td>
        		<%} else {%>
        		    <td id="tdRow<%=i%>C<%=j%>" class="td12" style="background: <%=sTdSpClr%>" nowrap><b><%=sRow[j]%></b></td>
        		<%}%>
        		
        		
        	 <%}%>                  
        	 <td class="td11" nowrap><b><%=sGrpNm%></b></td>
           </tr>
           <%}%>
       <%}%>
            
           <!-- ======Total ================ -->
           <%
           	stokpos.setTotal();
           	String sGrp = stokpos.getGrp();
           	String sGrpNm = stokpos.getGrpNm();
          	String sReg = stokpos.getReg();
           	String [] sRow = stokpos.getRow();
           	
           	if(sRow[21].indexOf("-") < 0){sTdSpClr = "#e3f7eb";}
			else{sTdSpClr = "#f9dddb";}
           %>
           <tr class="Divider"><td colspan=50>&nbsp;</td></tr>
           
           <tr id="trTot" class="trDtl03">
             <td class="td11" nowrap><b><%=sGrpNm%></b></td>
             <%for(int j=0; j < 26; j++){%>
        		<%if(j != 21 ){%>
        			<td class="td12" nowrap><%=sRow[j]%></td>
        		<%} else {%>
        		    <td class="td12" style="background: <%=sTdSpClr%>" nowrap><b><%=sRow[j]%></b></td>
        		<%}%>
        	 <%}%>
        	 <td class="td11" nowrap><b><%=sGrpNm%></b></td>
           </tr>          
           <% 
           stokpos.setTotPlan();
           String [] sInvPlan = stokpos.getInvPlan();
           String [] sOpenOrd = stokpos.getOpenOrd();
           %>
           <tr class="Divider"><td colspan=50>&nbsp;</td></tr>
           
           <tr id="trIPTot" class="trDtl03">
             <td class="td11" nowrap><b>Inventory Plan</b></td>
             <td class="td11" colspan=6>&nbsp;</td>
             <%for(int j=0; j < 12; j++){%>
        		<td id="tdTotRow<%=j%>" class="td12" nowrap><%=sInvPlan[j]%></td>	
        	 <%}%>
        	 <td class="td11" colspan=8>&nbsp;</td>
        	 <td class="td11" nowrap><b>Inventory Plan</b></td>
           </tr>   
           
           <tr class="Divider"><td colspan=50>&nbsp;</td></tr>
           
           <tr id="trOOTot" class="trDtl03">
             <td class="td11" nowrap><b>Open Orders</b></td>
             <td class="td11" colspan=6>&nbsp;</td>
             <%for(int j=0; j < 12; j++){%>
        		<td id="tdTotRow<%=j%>" class="td12" nowrap><%=sOpenOrd[j]%></td>	
        	 <%}%>
        	 <td class="td11" colspan=8>&nbsp;</td>
        	 <td class="td11" nowrap><b>Open Orders</b></td>
           </tr>
           
           
           <tr id="trScale" class="trDtl06" style="visibility: hidden;">
             <td class="td18" style="border: none;" nowrap><%for(int k=0; k < iColWidth[0]; k++){%>W<%}%></td>
             <%for(int j=0, a=1; j < 26; j++, a++){%>
              	<td class="td18" style="border: none;" nowrap><%for(int k=0; k < iColWidth[ a]; k++){%>0<%}%></td>             
             <%}%>
             <td class="td18" style="border: none;" nowrap><%for(int k=0; k < iColWidth[0]; k++){%>W<%}%></td>
           </tr>
      <!----------------------- end of table ------------------------>    
		</table>  
        <%for(int i=0; i < 10; i++){ %><br>&nbsp;<%} %>         
 </body>
</html>
<%
stokpos.disconnect();
stokpos = null;
}
%>