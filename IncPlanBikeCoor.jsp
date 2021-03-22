<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page import="payrollreports.IncPlanBikeCoor, java.util.*, java.text.*"%>
<%
   String sQtr = request.getParameter("Qtr");
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=IncPlanBikeCoor.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
	
	IncPlanBikeCoor setSls = new IncPlanBikeCoor(sQtr);
    int iNumOfReg = setSls.getNumOfReg();
    String [] sReg = setSls.getReg();
    int [] iNumOfRegStr = setSls.getNumOfRegStr();
    String [][] sStrLst = setSls.getStrLst();
    
    int iNumOfMon = setSls.getNumOfMon();
    String [] sMon = setSls.getMon();
    String [] sMonNm = setSls.getMonNm();
    String [] sMonEnd = setSls.getMonEnd();
    
    int iNumOfStr = setSls.getNumOfStr();
    
    int iNumOfPln = setSls.getNumOfPln();
    String [] sCateg = setSls.getCateg();
    String [] sLevel = setSls.getLevel();
    String [] sMinPrc = setSls.getMinPrc();
    String [] sMaxPrc = setSls.getMaxPrc();
    String [] sIncPrc = setSls.getIncPrc();
    
    String sFiscYr = setSls.getFiscYr();
    String sQtrNum = setSls.getQtrNum();
%>
<html>
<head>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Inc.Plan - Bike Coordinator</title>

<SCRIPT>

//--------------- Global variables -----------------------
var Qtr = "<%=sQtr%>";
var Fold = false;
//--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);  
   //foldCol()
   
   document.all.dvPayout.style.visibility="visible";
   document.all.dvPayout.style.pixelLeft = document.documentElement.scrollLeft + 1;
   document.all.dvPayout.style.pixelTop =  document.documentElement.scrollTop + 1;
}
//==============================================================================
//initial process
//==============================================================================
function foldCol()
{		
   	var disp = "block";
   	if(Fold == false){ disp = "none"; }
   	Fold = !Fold;
   	
   	var wk = document.all.tdWk;
   	for(var i=0; i < wk.length; i++)
   	{
   		wk[i].style.display = disp;
   	}
}
//==============================================================================
//select new quarter
//==============================================================================
function getOtherQtrReport()
{
	var qtr = document.all.SelQtr[document.all.SelQtr.selectedIndex].value
	var url="IncPlanBikeCoor.jsp?Qtr=" + qtr 
	window.location.href=url;
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
<div id="dvHelp" class="dvHelp"><a href="Intranet Reference Documents/1.0 Incentive Plan Bike Coor.pdf" class="helpLink" target="_blank">&nbsp;</a>
<br>Bike Coordinator
<br>Incentive Plan
<br>Outline
</div>

<div id="dvPayout" class="dvItem">
<table border=0>
        <tr>
          <th>
      
      <table class="tbl10" id="tblInc" >
        <tr class="trHdr01">
          <th class="th02" colspan=3>Over 1M Volume (Group A)</th>          
        </tr>
        <tr class="trHdr01">
          <th class="th02">Tier</th>
          <th class="th02">Comp %</th>
          <th class="th02">Payout $</th>          
        </tr>
        <%for(int i=0; i < iNumOfPln; i++){
			if(sCateg[i].equals("A")){
        %>
        
           		<tr id="trTot" class="trDtl04">
		        	<td class="td11" nowrap><%=sLevel[i]%></td>
		        	<td class="td11" nowrap><%=sMinPrc[i]%><%if(!sMaxPrc[i].equals("99999.99")){%> - <%=sMaxPrc[i]%><%} else {%>+<%}%></td>
		        	<td class="td12" nowrap><%=sIncPrc[i]%></td>
		        </tr>	
        	<%} %>
        <%} %>
       </table>       
       		
       		</th>
       		<th>&nbsp;</th>
       		<th>
       <table class="tbl10" id="tblInc" >
        <tr class="trHdr01">
          <th class="th02" colspan=3>Under 1M Volume (Group B)</th>          
        </tr>
        <tr class="trHdr01">
          <th class="th02">Tier</th>
          <th class="th02">Comp %</th>
          <th class="th02">Payout $</th>          
        </tr>
        <%for(int i=0; i < iNumOfPln; i++){
			if(sCateg[i].equals("B")){
        %>
        
           		<tr id="trTot" class="trDtl04">
		        	<td class="td11" nowrap><%=sLevel[i]%></td>
		        	<td class="td11" nowrap><%=sMinPrc[i]%><%if(!sMaxPrc[i].equals("99999.99")){%> - <%=sMaxPrc[i]%><%} else {%>+<%}%></td>
		        	<td class="td12" nowrap><%=sIncPrc[i]%></td>
		        </tr>	
        	<%} %>
        <%} %>
       </table>		
       		
       	  </th>
       	</tr>
       </table>
</div>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src="" height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">      
        <tr class="trHdr">
          <th colspan=45>
            <img src="Sun_ski_logo4.png"/>
            <br><b>Retail Concepts, Inc
            <br>Bike Coordinator Incentive Plan Bulletin Board
            <br>Quarter: FY<%=sFiscYr%> / <%=sQtrNum%>               
            </b>
          	</th>
        </tr>
        <tr>
          	<td><a href="/"><font color="red" size="-1">Home</font></a>&#62;This Page</td>
        </tr>
        <tr>
          	<td class="Small" style="text-align: center;">
          	   <!-- a class="Small" href="javascript: foldCol();">Fold/Unfold</a -->
          	   
          	   Select quarter:
          	   <select class="Small" name="SelQtr">
          	      <option value="0">Currtent</option>
          	      <option value="1">Previous</option>
          	   </select>
          	   &nbsp;
          	   <button class="Small" onclick="getOtherQtrReport()">Go</button>
          	</td>
        </tr>   
        <tr>
          <td>  
      <table class="tbl02" id="tblEnt">
        <tr class="trHdr01">
          <th class="th02" rowspan=2>Dst</th>
          <th class="th02" rowspan=2>Str</th>
          <th class="th03" rowspan=2></th>
          
          <%for(int i=0; i < iNumOfMon; i++) {%>
             <th class="th02" id="tdWk" colspan=3><%=sMonNm[i]%><br><%=sMonEnd[i]%></th>
          <%}%>          
          <th class="th03" rowspan=2></th>
          <th class="th02" colspan=3>QTD</th>
          <th class="th03" rowspan=2></th>
          
          <th class="th02" rowspan=2>Payout$</th>
          <th class="th02" rowspan=2>Volume<br>Group</th>
          <th class="th02" rowspan=2>Trailing 12<br>Month Sales</th>
        </tr>
        
        <tr class="trHdr01">
        	<%for(int i=0; i < iNumOfMon; i++) {%>
            	<th class="th03" id="tdWk">TY</th>
            	<th class="th03" id="tdWk">LY</th>
            	<th class="th03" id="tdWk">%</th>
          	<%}%>
          	<th class="th02" id="tdQtr">TY</th>
            <th class="th02" id="tdQtr">LY</th>
            <th class="th02" id="tdQtr">%</th>
        </tr>
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvClr = "";
             String sTrCls = "trDtl27";             
             int iArg = 0;
              
           %>
           <%for(int i=0; i < iNumOfReg; i++) {%>                           
               <tr id="trStr<%=i%>" class="<%=sTrCls%>">
                	<td class="td11" nowrap rowspan="<%=iNumOfRegStr[i]%>"><%=sReg[i]%></td>
                	
                	<%for(int j=0; j < iNumOfRegStr[i]; j++){
                		setSls.setSlsInfo();
                    	String sStr = setSls.getStr();
                    	String [] sTyMnSls = setSls.getTyMnSls();
                    	String [] sLyMnSls = setSls.getLyMnSls();
                    	String [] sMnPrc = setSls.getMnPrc();
                    	String sTyQtrSls = setSls.getTyQtrSls();
                    	String sLyQtrSls = setSls.getLyQtrSls();
                    	String sQtrPrc = setSls.getQtrPrc();
                    	String sGroup = setSls.getGroup();
                    	String sTrail = setSls.getTrail();
                    	String sPayout = setSls.getPayout();
                	%>
                	    <%if(j > 0){%></tr><tr id="trStr<%=i%>" class="<%=sTrCls%>"><%}%>
                		<td class="td11" nowrap><%=sStrLst[i][j]%></td>
                		<th class="th20"></th>
                		<%for(int k=0; k < iNumOfMon; k++) {%>
             				<td class="td11" id="tdWk">$<%=sTyMnSls[k]%></td>
             				<td class="td11" id="tdWk">$<%=sLyMnSls[k]%></td>
             				<td class="td11" id="tdWk" nowrap><%=sMnPrc[k]%>%</td>
          				<%}%> 
          				<th class="th20"></th>
          				<td class="td12">$<%=sTyQtrSls%></td>
             			<td class="td12">$<%=sLyQtrSls%></td>
             			<td class="td12" nowrap><%=sQtrPrc%>%</td>
                		<th class="th20"></th>               		
                		<td class="td12" <%if(!sPayout.equals("0")){%>style="background:lightgreen"<%}%> nowrap><%if(!sPayout.equals("0")){%>$<%=sPayout%><%}%></td>
                		<td class="td12" nowrap><%=sGroup%></td>
                		<td class="td12">$<%=sTrail%></td>
          			<%}%>                	
               </tr>
               <!-- ============== Region Totals ======================= -->
               <%
            	setSls.setRegSls();            	
           		String sStr = setSls.getStr();
           		String [] sTyMnSls = setSls.getTyMnSls();
           		String [] sLyMnSls = setSls.getLyMnSls();
           		String [] sMnPrc = setSls.getMnPrc();
           		String sTyQtrSls = setSls.getTyQtrSls();
           		String sLyQtrSls = setSls.getLyQtrSls();
           		String sQtrPrc = setSls.getQtrPrc();
           		String sGroup = setSls.getGroup();
           		String sTrail = setSls.getTrail();
           		String sPayout = setSls.getPayout();
               %>
               <tr id="trReg<%=i%>" class="trDtl29">
               		<td class="td11" nowrap colspan=2>**District Total</td>
                	<th class="th20"></th>
                	<%for(int k=0; k < iNumOfMon; k++) {%>
             			<td class="td11" id="tdWk">$<%=sTyMnSls[k]%></td>
             			<td class="td11" id="tdWk">$<%=sLyMnSls[k]%></td>
             			<td class="td11" id="tdWk" nowrap><%=sMnPrc[k]%>%</td>
          			<%}%> 
          			<th class="th20"></th>
          			<td class="td12">$<%=sTyQtrSls%></td>
             		<td class="td12">$<%=sLyQtrSls%></td>
             		<td class="td12" nowrap><%=sQtrPrc%>%</td>
                	<th class="th20"></th>               		
                	<td class="td12">&nbsp;</td>
                	<td class="td12" nowrap>&nbsp;</td>
                	<td class="td12">&nbsp;</td>
               </tr>
              <% iArg++; %>              
              <%}%>   
              
              <!-- ============== Report Totals ======================= -->
               <%
            	setSls.setTotSls();            	
           		String sStr = setSls.getStr();
           		String [] sTyMnSls = setSls.getTyMnSls();
           		String [] sLyMnSls = setSls.getLyMnSls();
           		String [] sMnPrc = setSls.getMnPrc();
           		String sTyQtrSls = setSls.getTyQtrSls();
           		String sLyQtrSls = setSls.getLyQtrSls();
           		String sQtrPrc = setSls.getQtrPrc();
           		String sGroup = setSls.getGroup();   
           		String sTrail = setSls.getTrail();
           		String sPayout = setSls.getPayout();
               %>
               <tr id="trTot" class="trDtl28">
               		<td class="td11" nowrap colspan=2>***Report Total</td>
                	<th class="th20"></th>
                	<%for(int k=0; k < iNumOfMon; k++) {%>
             			<td class="td11" id="tdWk">$<%=sTyMnSls[k]%></td>
             			<td class="td11" id="tdWk">$<%=sLyMnSls[k]%></td>
             			<td class="td11" id="tdWk" nowrap><%=sMnPrc[k]%>%</td>
          			<%}%> 
          			<th class="th20"></th>
          			<td class="td12">$<%=sTyQtrSls%></td>
             		<td class="td12">$<%=sLyQtrSls%></td>
             		<td class="td12" nowrap><%=sQtrPrc%>%</td>
                	<th class="th20"></th>               		
                	<td class="td12">$<%=sPayout%></td>
                	<td class="td12" nowrap>&nbsp;</td>
                	<td class="td12">&nbsp;</td>
               </tr>
         </table>
         </td>
      </tr>
      <tr>
         <td align=center>
      <!----------------------- end of table ------------------------>
      *Divisions: 7,88,89,96-992,98-960, Classes: 9573, 9591, 9592 only
      <br>**District totals only include comp stores
      <br>***Report total only include comp stores
      
      	</td>
      </tr>
       
      
   </table>
   
   
 </body>
</html>
<%
setSls.disconnect();
setSls = null;
}
%>