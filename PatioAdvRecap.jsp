<!DOCTYPE html>	
<%@ page import="patiosales.PatioAdvRecap, java.util.*, java.text.*"%>
<%
	String sFrDate = request.getParameter("FrDate");
	String sToDate = request.getParameter("ToDate");
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=PatioAdvRecap&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sUser = session.getAttribute("USER").toString();
    PatioAdvRecap paheard = new PatioAdvRecap();
    paheard.setCustHearUs(sFrDate, sToDate, sUser);
    
    int iNumOfStr = paheard.getNumOfStr();    
    
    String [] sArrClr = new String[]{
      "style='background:#F6CEF5;'"
    , "style='background:#CEE3F6;'"
    , "style='background:#f9bdc1;'"
    , "style='background:#F2F5A9;'"
    , "style='background:#BEF781;'"
    , "style='background:#23f3df;'"
    , "style='background:#F5A9BC;'"
    , "style='background:#F3E2A9;'"
    , "style='background:#D8D8D8;'"
    , };
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<title>How Customers Heard About Us?</title>

<SCRIPT>

//--------------- Global variables -----------------------
var FrDate = "<%=sFrDate%>";
var ToDate = "<%=sToDate%>";

var NumOfStr = <%=iNumOfStr%>

//--------------- End of Global variables ----------------
//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
}
//==============================================================================
//initial process
//==============================================================================
function getOtherStat(lvl, grp, tyly, seq)
{
	var url = "PatioAdvOth.jsp?FrDate=<%=sFrDate%>&ToDate=<%=sToDate%>"
	  + "&Seq=" + seq;
			
	if(lvl == "STR")
	{
		url += "&Str=" + grp;
	}		
	else if(lvl == "REG")
	{
		if(grp=="DC Area"){ url += "&Str=35&Str=46&Str=50";}
		else if(grp=="NY Area"){ url += "&Str=86";}
		else if(grp=="NE Area"){ url += "&Str=63&Str=64&Str=68";}
	}
	else if(lvl == "TOTAL")
	{
		url += "&Str=35&Str=46&Str=50&Str=86&Str=63&Str=64&Str=68";
	}
	window.frame1.location.href=url;
}
//==============================================================================
//initial process
//==============================================================================
function showOtherResp(str, resp, tyly, count)
{
	var hdr = "Other Responses";  
	  
	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	    + "<tr>"
	      + "<td class='BoxName' nowrap>" + hdr + "</td>"
	      + "<td class='BoxClose' valign=top>"
	        +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	      + "</td></tr>"
	   + "<tr><td class='Prompt' colspan=2>"
	       + popOtherResp(str, resp, tyly, count)
	    + "</td></tr>"
	  + "</table>"

	  document.all.dvItem.innerHTML = html;
	  document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 300;
	  document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
	  document.all.dvItem.style.visibility = "visible";
	}
	//==============================================================================
	// populate quantity and status change panel
	//==============================================================================
	function popOtherResp(str, resp, tyly, count)
	{
		var panel = "<table class='tbl04'>"
	     + "<tr class='trHdr02'>"
	       + "<th nowrap class='th02'>This Year</td>"
	       + "<th nowrap class='th02'> &nbsp; &nbsp; &nbsp; &nbsp; </th>"
	       + "<th nowrap class='th02'>Last Year</td>"
	     + "</tr>"
	     
	  // --- this year -----
	     panel += "<tr class='trHdr03'>"
	       + "<td nowrap class='td17'>";
	       
	     panel += "<table class='tbl04'>"
		     + "<tr class='trHdr02'>"
		       + "<th nowrap class='th02'>Str</td>"
		       + "<th nowrap class='th02'>Responses</td>"
		       + "<th nowrap class='th02'>Count</td>"
		       
		     + "</tr>"
		 for(var i=0; i < str.length; i++)
		 {
			 if(tyly[i] == "TY")
			 {
				 panel += "<tr class='trDtl04'>"
			       + "<td nowrap class='td02'>" + str[i] + "</td>"
			       + "<td nowrap class='td02'>" + resp[i] + "</td>"
			       + "<td nowrap class='td02'>" + count[i] + "</td>"
			     + "</tr>";
			 }
		 }
			 
		 panel += "</table>";
		 panel += "</td>";
		 
		 panel += "<td>&nbsp; &nbsp; &nbsp; &nbsp; </td>"
		 
		// --- last year -----
		 panel += "<td nowrap class='td17'>";
	       
	     panel += "<table  class='tbl04'>"
		     + "<tr class='trHdr02'>"
		       + "<th nowrap class='th02'>Str</td>"
		       + "<th nowrap class='th02'>Responses</td>"
		       + "<th nowrap class='th02'>Count</td>"
		     + "</tr>"
		 for(var i=0; i < str.length; i++)
		 {			 
			 if(tyly[i] == "LY")
			 {
				 panel += "<tr class='trDtl04'>"
			       + "<td nowrap class='td02'>" + str[i] + "</td>"
			       + "<td nowrap class='td02'>" + resp[i] + "</td>"
			       + "<td nowrap class='td02'>" + count[i] + "</td>"
			     + "</tr>";
			 }
		 }    
		 panel += "</table>";
		 panel += "</td>";
		 
		 
		 panel += "</tr>";
		     
	     panel += "<tr>"
	      + "<td nowrap class='Small' colspan=2>"
	       + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
	      + "</td>" 
	     + "</tr>"
	   +  "</table>";
	   return panel;
}
	//==============================================================================
	// Hide selection screen
	//==============================================================================
	function hidePanel()
	{
	   document.all.dvItem.innerHTML = " ";
	   document.all.dvItem.style.visibility = "hidden";	   
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
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<!-------------------------------------------------------------------->
      <!----------------- beginning of table ------------------------>
      <table class="tbl01">
        <tr class="trHdr">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>Patio - How Customers Heard About Us?
            <br>Dates: <%=sFrDate%> - <%=sToDate%>
            </b>
            
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="PatioAdvRecapSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;            
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02" rowspan=3>Str</th>
          <td class="td16" rowspan=3>&nbsp;</td>
          <th class="th02" colspan=26>How Customers Heard About Us?</th>
        </tr>
        <tr class="trHdr01">        
          <th class="th02" <%=sArrClr[0]%> colspan=2>Advertisement</th>
          <th class="th04" rowspan=2>&nbsp;</th>
          <th class="th02" <%=sArrClr[1]%> colspan=2>Coupon</th>
          <th class="th04" rowspan=2>&nbsp;</th>
          <th class="th02" <%=sArrClr[2]%> colspan=2>Online</th>
          <th class="th04" rowspan=2>&nbsp;</th>
          <th class="th02" <%=sArrClr[3]%> colspan=2>Referred<br>From<br>a Friend</th>
          <th class="th04" rowspan=2>&nbsp;</th>
          <th class="th02" <%=sArrClr[4]%> colspan=2>Repeat<br>Patio<br>Customer</th>
          <th class="th04" rowspan=2>&nbsp;</th>
          <th class="th02" <%=sArrClr[5]%> colspan=2>Ski<br>Customer</th>
          <th class="th04" rowspan=2>&nbsp;</th>
          <th class="th02" <%=sArrClr[6]%> colspan=2>Walk-In</th>
          <th class="th04" rowspan=2>&nbsp;</th>
          <th class="th02" <%=sArrClr[7]%> colspan=2>*Other</th>
          <th class="th04" rowspan=2>&nbsp;</th>
          <th class="th02" <%=sArrClr[8]%> colspan=2>Total</th>
        </tr>
        <tr class="trHdr01">
           <%for(int i=0; i < 9; i++){%>           
           		<th class="th02">TY</th>
           		<th class="th02">LY</th>
           <%}%>
        </tr>
       
<!------------------------------- Detail --------------------------------->
           <%for(int i=0; i < iNumOfStr; i++) {
        	   paheard.setStrRecap();
               String sStr = paheard.getStr();
               String [] sTyCnt = paheard.getTyCnt();
               String [] sLyCnt = paheard.getLyCnt();
           %>
              <tr id="trId" class="trDtl04">
                <td class="td18" nowrap rowspan=2><%=sStr%></td>                
                
                <%for(int j=0; j < sTyCnt.length; j++){
                   String sColClr = sArrClr[j];
                %>
                	<td class="td16"><%if(j==0){%>TY<%}%>&nbsp;</td>
                	<%if(j > 2 && j <= 6 || j == 8){%>
                		<td class="td21" <%=sColClr%> nowrap><%=sTyCnt[j]%></td>
                		<td class="td12" <%=sColClr%> nowrap>&nbsp;</td>
                	<%} else {%>
                		<td class="td21" <%=sColClr%> nowrap><a href="javascript: getOtherStat('STR','<%=sStr%>', true, '<%=j+1%>')"><%=sTyCnt[j]%></a></td>
                		<td class="td12" <%=sColClr%> nowrap>&nbsp;</td>
                	<%}%>
                <%}%>
              </tr>
              <tr id="trId" class="trDtl03">
                <%for(int j=0; j < sLyCnt.length; j++){
                	String sColClr = sArrClr[j];
                %>
                	<td class="td16" ><%if(j==0){%>LY<%}%>&nbsp;</td>
                	<%if(j > 2 && j <= 6 || j == 8){%>                		
                	    <td class="td19" <%=sColClr%> nowrap>&nbsp;</td>
                		<td class="td20" <%=sColClr%> nowrap><%=sLyCnt[j]%></td>
                	<%} else {%>                		
                	    <td class="td19" <%=sColClr%> nowrap>&nbsp;</td>
                		<td class="td20" <%=sColClr%> nowrap><a href="javascript: getOtherStat('STR','<%=sStr%>', false, '<%=j+1%>')"><%=sLyCnt[j]%></a></td>
                	<%}%>
                <%}%>
                
              </tr>
              
              <%if(sStr.equals("50") || sStr.equals("86") || sStr.equals("68")) {
           	   		paheard.setRegRecap();
           	   		sStr = paheard.getStr();
                 	sTyCnt = paheard.getTyCnt();
                 	sLyCnt = paheard.getLyCnt();
              %>
                <tr id="trId" class="trDtl08">
                 	<td class="td11" nowrap rowspan=2><b><%=sStr%></b></td>                
                
                	<%for(int j=0; j < sTyCnt.length; j++){%>
                		<td class="td16" ><%if(j==0){%>TY<%}%>&nbsp;</td>
                		<%if(j > 2 && j <= 6 || j == 8){%>
                			<td class="td21" nowrap><b><%=sTyCnt[j]%></b></td>
                			<td class="td12" nowrap>&nbsp;</td>
                		<%} else {%>
                			<td class="td21" nowrap><a href="javascript: getOtherStat('REG','<%=sStr%>', true, '<%=j+1%>')"><b><%=sTyCnt[j]%></b></a></td>
                			<td class="td12" nowrap>&nbsp;</td>
                		<%}%>
                	<%}%>
                	
               <tr id="trId" class="trDtl08">
                 	<%for(int j=0; j < sLyCnt.length; j++){%>
                		<td class="td16" ><%if(j==0){%>LY<%}%>&nbsp;</td>
                		<%if(j > 2 && j <= 6 || j == 8){%>
                			<td class="td19" nowrap>&nbsp;</td>
                			<td class="td20" nowrap><b><%=sLyCnt[j]%></b></td>
                		<%} else {%>
                			<td class="td19" nowrap>&nbsp;</td>
                			<td class="td20" nowrap><a href="javascript: getOtherStat('REG','<%=sStr%>', false, '<%=j+1%>')"><b><%=sLyCnt[j]%></b></a></td>
                		<%}%>
                	<%}%> 	
              </tr>
                 	
              <%}%>
              
           <%}%>           
           
           
           <!------------------------------- Total --------------------------------->
           <tr class="trHdr01"><td class="Separator02" nowrap colspan=28>&nbsp;</td></tr> 
           <%
           	paheard.setTotalRecap();
       		String sStr = paheard.getStr();
           	String [] sTyCnt = paheard.getTyCnt();
           	String [] sLyCnt = paheard.getLyCnt();           	
           %>
              <tr id="trId" class="trDtl03">
                <td class="td11" nowrap rowspan=2><b><%=sStr%></b></td>
                
                <%for(int j=0; j < sTyCnt.length; j++){%>
                	<td class="td16" ><%if(j==0){%>TY<%}%>&nbsp;</td>
                	<%if(j > 2 && j <= 6 || j == 8){%>
                		<td class="td21" nowrap><b><%=sTyCnt[j]%></b></td>
                		<td class="td12" nowrap>&nbsp;</td>
                	<%} else {%>
                		<td class="td21" nowrap><a href="javascript: getOtherStat('TOTAL','<%=sStr%>', true, '<%=j+1%>')"><b><%=sTyCnt[j]%></b></a></td>
                		<td class="td12" nowrap>&nbsp;</td>
                	<%}%>
                <%}%>
                </th>
              </tr>
              
              <tr id="trId" class="trDtl03">
                <%for(int j=0; j < sLyCnt.length; j++){%>
                	<td class="td16" ><%if(j==0){%>LY<%}%>&nbsp;</td>
                	<%if(j > 2 && j <= 6 || j == 8){%>
                		<td class="td19" nowrap>&nbsp;</td>
                		<td class="td20" nowrap><b><%=sLyCnt[j]%></b></td>
                	<%} else {%>
                		<td class="td19" nowrap>&nbsp;</td>
                		<td class="td20" nowrap><a href="javascript: getOtherStat('TOTAL','<%=sStr%>', false, '<%=j+1%>')"><b><%=sLyCnt[j]%><b></b></a></td>
                	<%}%>
                <%}%>
                </th>
              </tr>
              
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
paheard.disconnect();
paheard = null;
}
%>