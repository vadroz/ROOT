<%@ page import="flashreps.SkiCont, java.util.*, rciutility.StoreSelect
, rciutility.RunSQLStmt, java.sql.*,java.util.*, java.text.*"%>
<%
   	String sSelDate = request.getParameter("Date");   	
    String sType = request.getParameter("Type");
   	String sSort = request.getParameter("Sort");

   	if(sType==null || sType.equals("")) { sType="T"; }
   	if(sSort==null || sSort.equals("")) { sSort="VART9"; }
   	
   
String sAppl="BASIC1";
if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=SkiCont.jsp&APPL=" + sAppl + "&" + request.getQueryString());
}
else
{
   String sStrAllowed = session.getAttribute("STORE").toString();
   String sUser = session.getAttribute("USER").toString();
   
   SkiCont flashsls = new SkiCont();
   flashsls.setGenSls( sSelDate, sSort, sUser);
   int iNumOfStr = flashsls.getNumOfStr();
   String [] sWkDate = flashsls.getWkDate();   
	   
   String [] sArrWk = new String[]{"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun" }; 
%>

<html>
<head>
<title>Skiing Contest</title>
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Set_Browser.js"></script>
<script LANGUAGE="JavaScript1.2" src="XX_Get_Visible_Position.js"></script>


<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var SelDate = "<%=sSelDate%>";
var Type = "<%=sType%>";
var Sort = "<%=sSort%>";

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
	var url = "SkiCont.jsp?Date=" + SelDate  
	+ "&Type=" + Type
	+ "&Sort=" + sort
	;

   //alert(url)
   window.location.href=url;
}
//==============================================================================
//show another selected week
//==============================================================================
function showGrp(type)
{
	if(type=="T"){ Sort = "VART9" }
	else if(type=="A"){ Sort = "VARA9" }
	else if(type=="H"){ Sort = "VARH9" }
	
	var url = "SkiCont.jsp?Date=" + SelDate  
	+ "&Type=" + type
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
            <br>Peak Season Skiing Contest 
            <br>Contest Dates 1/20/2018 - 2/19/2018
            <br> <%if(sType.equals("T")){%>Store Totals<%}%>
                 <%if(sType.equals("A")){%>Apparel<%}%>
                 <%if(sType.equals("H")){%>Hardgoods<%}%>
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="SkiContSel.jsp"><font color="red" size="-1">Select</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;
              
              <br>
              <%if(!sType.equals("A")){%><a href="javascript: showGrp('A')">Apparel</a>&nbsp; &nbsp; &nbsp; &nbsp;<%}%>
              <%if(!sType.equals("H")){%><a href="javascript: showGrp('H')">Hardgoods</a>&nbsp; &nbsp; &nbsp; &nbsp;<%}%>
              <%if(!sType.equals("T")){%><a href="javascript: showGrp('T')">Total</a><%}%>
              &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp; &nbsp; &nbsp; &nbsp;                        
          </th>
        </tr>
        <tr align=center>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
        	<th class="th02" rowspan=3><br><a href="javascript:reSort('Str')">Store</a></th>
        	<%for(int j=0; j < 7; j++){%>
        	  <th class="th02" rowspan=3></th>
        	  <th class="th02" colspan=3><%=sArrWk[j]%></th>
        	<%}%>
        	<th class="th02" rowspan=3></th>
        	<th class="th02" rowspan=2 colspan=3>Week-To-Date<br>Total</th>
        	<th class="th02" rowspan=3></th>
        	<th class="th02" rowspan=2 colspan=3>Contest-To-Date<br>Total</th>        	        	
        </tr>
        <tr class="trHdr01">          	
          	<%for(int j=0; j < 7; j++){%><th class="th02" colspan=3><%=sWkDate[j]%></th><%}%> 	
        </tr>
        <tr class="trHdr01">
            <%if(sType.equals("T")){%>       
            	<%for(int j=0; j < 9; j++){%>    	
          			<th class="th02"><a href="javascript:reSort('TYT<%=j+1%>')">TY</a></th>
          			<th class="th02"><a href="javascript:reSort('LYT<%=j+1%>')">LY</th>
          			<th class="th02"><a href="javascript:reSort('VART<%=j+1%>')">Var</th>
          		<%}%>
          	<%}%>
          	<%if(sType.equals("A")){%>       
            	<%for(int j=0; j < 9; j++){%>    	
          			<th class="th02"><a href="javascript:reSort('TYA<%=j+1%>')">TY</a></th>
          			<th class="th02"><a href="javascript:reSort('LYA<%=j+1%>')">LY</th>
          			<th class="th02"><a href="javascript:reSort('VARA<%=j+1%>')">Var</th>
          		<%}%>
          	<%}%>
          	<%if(sType.equals("H")){%>       
            	<%for(int j=0; j < 9; j++){%>    	
          			<th class="th02"><a href="javascript:reSort('TYH<%=j+1%>')">TY</a></th>
          			<th class="th02"><a href="javascript:reSort('LYH<%=j+1%>')">LY</th>
          			<th class="th02"><a href="javascript:reSort('VARH<%=j+1%>')">Var</th>
          		<%}%>
          	<%}%>          	          	          	                  	
        </tr>  	
        
        
<!------------------------------- order/sku --------------------------------->
           <%
             String sTrCls = "trDtl04"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfStr; i++) {        	   
        	   	flashsls.setContLst();
       			String sStr = flashsls.getStr();
       		
       			String [] sTyApprSls = flashsls.getTyApprSls();
       			String [] sTyHdgSls = flashsls.getTyHdgSls();
       			String [] sTyTotSls = flashsls.getTyTotSls();
       		
       			String [] sLyApprSls = flashsls.getLyApprSls();
       			String [] sLyHdgSls = flashsls.getLyHdgSls();
       			String [] sLyTotSls = flashsls.getLyTotSls();
       		
       			String [] sVarApprSls = flashsls.getVarApprSls();
       			String [] sVarHdgSls = flashsls.getVarHdgSls();
       			String [] sVarTotSls = flashsls.getVarTotSls();
       			
       			if(!sSort.equals("Str") && i < 3){sTrCls = "trDtl18";  }
       			else{ sTrCls = "trDtl04";  }
           %>               
           <tr id="trGrp<%=i%>" class="<%=sTrCls%>">
             <td id="tdStr<%=i%>" class="td12" nowrap><%=sStr%></td>
             <%for(int j=0; j < 9; j++){%>
               <td class="td35">&nbsp;</td>
               <%if(sType.equals("T")){%>   
               		<td id="tdStr<%=i%>" class="td12" nowrap><%if(!sTyTotSls[j].equals("0")){%>$<%=sTyTotSls[j]%><%}%></td>
               		<td id="tdStr<%=i%>" class="td12" nowrap><%if(!sLyTotSls[j].equals("0")){%>$<%=sLyTotSls[j]%><%}%></td>
               		<td id="tdStr<%=i%>" class="td12" nowrap><%if(!sVarTotSls[j].equals("0")){%><%=sVarTotSls[j]%>%<%}%></td>
               <%}%>
               <%if(sType.equals("A")){%>   
               		<td id="tdStr<%=i%>" class="td12" nowrap><%if(!sTyApprSls[j].equals("0")){%>$<%=sTyApprSls[j]%><%}%></td>
               		<td id="tdStr<%=i%>" class="td12" nowrap><%if(!sLyApprSls[j].equals("0")){%>$<%=sLyApprSls[j]%><%}%></td>
               		<td id="tdStr<%=i%>" class="td12" nowrap><%if(!sVarApprSls[j].equals("0")){%><%=sVarApprSls[j]%>%<%}%></td>
               <%}%>
               <%if(sType.equals("H")){%>   
               		<td id="tdStr<%=i%>" class="td12" nowrap><%if(!sTyHdgSls[j].equals("0")){%>$<%=sTyHdgSls[j]%><%}%></td>
               		<td id="tdStr<%=i%>" class="td12" nowrap><%if(!sLyHdgSls[j].equals("0")){%>$<%=sLyHdgSls[j]%><%}%></td>
               		<td id="tdStr<%=i%>" class="td12" nowrap><%if(!sVarHdgSls[j].equals("0")){%><%=sVarHdgSls[j]%>%<%}%></td>
               <%}%>
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
flashsls.disconnect();
flashsls = null;
}
%> 

