<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page import="payrollreports.IncPlanFloorLead, java.util.*, java.text.*
   , rciutility.StoreSelect "%>
<%
   String sQtr = request.getParameter("Qtr");
   String sSelStr = request.getParameter("Str");
   
   if(sQtr == null){ sQtr = "0"; }
   if(sSelStr == null){ sSelStr = "ALL"; }
   
//----------------------------------   
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=IncPlanFloorLead.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
	
	
	StoreSelect strlst = null;
	if (sStrAllowed != null && sStrAllowed.startsWith("ALL"))
    {
      strlst = new StoreSelect(23);
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
   	String [] sArrStr = strlst.getStrLst();
   	
   	
   	if(!sStrAllowed.startsWith("ALL"))
   	{
   		boolean bFound = false;   		
   		
   		for(int i=0; i < sArrStr.length; i++)
   		{   			
   			if(sArrStr[i] != null && sArrStr[i].equals(sSelStr)){ bFound = true;}
   		}
   		if(!bFound){ sSelStr = sArrStr[0]; }
   	}
		
	IncPlanFloorLead setSls = new IncPlanFloorLead(sQtr, sSelStr);
    
    int iNumOfMon = setSls.getNumOfMon();
    String [] sMon = setSls.getMon();
    String [] sMonNm = setSls.getMonNm();
    String [] sMonEnd = setSls.getMonEnd();
    
    int iNumOfEmp = setSls.getNumOfEmp();
    
    int iNumOfPln = setSls.getNumOfPln();
    String [] sMinPrc = setSls.getMinPrc();
    String [] sMaxPrc = setSls.getMaxPrc();
    String [] sIncPrc = setSls.getIncPrc();
    
    String sMonNmJsa = setSls.cvtToJavaScriptArray(sMonNm);
    String sMonEndJsa = setSls.cvtToJavaScriptArray(sMonEnd); 
    
    String sFiscYr = setSls.getFiscYr();
    String sQtrNum = setSls.getQtrNum();
    
    boolean bAlwPay = sStrAllowed != null && sStrAllowed.startsWith("ALL");
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Inc.Plan - Floor Leader</title>

<SCRIPT>

//--------------- Global variables -----------------------
var Qtr = "<%=sQtr%>";
var Str = "<%=sSelStr%>";
var ArrStr = [<%=sStrJsa%>];
var ArrStrNm = [<%=sStrNameJsa%>];
var AllStrAlw = <%=sStrAllowed.startsWith("ALL")%>;
var Fold = false;
var ArrMon = [<%=sMonNmJsa%>]; 
var ArrMonEnd = [<%=sMonEndJsa%>]; 
//--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   setQtr();
   setStrSel();
   
   document.all.dvTresh.style.visibility="visible";
}
 
//==============================================================================
// set seleted quater 
//==============================================================================
function setQtr()
{
	for(var i=0; i < document.all.SelQtr.length; i++)
	{
		if(document.all.SelQtr[i].value == Qtr)
		{
			document.all.SelQtr.selectedIndex = i;
			break;
		}
	}
	
}
//==============================================================================
//set store selection 
//==============================================================================
function setStrSel()
{   
	var start = 0;
	if(!AllStrAlw){ start=1; }
	
	var str = document.all.SelStr;
	var selidx = 0;
	for(var i=0, j=start; j < ArrStr.length; i++, j++)
	{
		str.options[i] = new Option(ArrStr[j] + " - " + ArrStrNm[j],ArrStr[j]);
		if(ArrStr[j] == Str){selidx = i; }
	}
	str.selectedIndex = selidx;
}
 
//==============================================================================
//select new quarter
//==============================================================================
function getOtherQtrReport()
{
	var qtr = document.all.SelQtr[document.all.SelQtr.selectedIndex].value
	var url="IncPlanFloorLead.jsp?Qtr=" + qtr
	+ "&Str=" + Str
	window.location.href=url;
}
//==============================================================================
//select new quarter
//==============================================================================
function getOtherStrReport()
{
	var str = document.all.SelStr[document.all.SelStr.selectedIndex].value
	var url="IncPlanFloorLead.jsp?Qtr=" + Qtr
	  + "&Str=" + str
	window.location.href=url;
}

//==============================================================================
//set month percentage
//==============================================================================
function setMonth(emp, empnm, prc, action)
{
	var hdr = "Employee: " + emp;
  	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	    + "<tr>"
	      + "<td class='BoxName' nowrap>" + hdr + "</td>"
	      + "<td class='BoxClose' valign=top>"
	        +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"	        
	      + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popMonth(emp, empnm, action)
	     + "</td></tr>"
	   + "</table>"

	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 400;
	document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";
	
	if(action != "ADD")
	{
		var prcinp = document.all.Prc;
		for(var i=0; i < prcinp.length; i++)
		{
			if( prc[i] != ".00"){ prcinp[i].value = prc[i]; } 
		}
		prcinp[0].focus();
		prcinp[0].select();
	}
}
//==============================================================================
// populate quick complete shipment
//==============================================================================
function popMonth(emp, empnm, action)
{
	var panel = "<table cellPadding='0' cellSpacing='0'>"
	panel += "<tr class='trHdr01'>"
		+ "<th nowrap class='th02'>Employee:&nbsp;</td>"
		+ "<th nowrap class='th02' colspan=3>&nbsp;<b>" + emp + "-" + empnm + "&nbsp;</b></td>"
	 + "</tr>"

	panel += "<tr class='trHdr01'><th nowrap class='th02'>Month:</td>"
	for(var i=0; i < ArrMon.length; i++)
	{	
  		panel += "<th class='th02' nowrap>" + ArrMon[i] + "</th>";	    
	} 	
	panel += "</tr>";
	
	panel += "<tr class='trDtl04'><td nowrap class='Small'>Percents:</td>"
		for(var i=0; i < ArrMon.length; i++)
		{	
	  		panel += "<td nowrap class='td18'><input class='Small' name='Prc' size='6' maxlength='4'>&nbsp; &nbsp;" 
	  		 + "<input type='hidden' name='Mon' value='" + ArrMonEnd[i] + "'>" + "</td>";	    
		} 	
		panel += "</tr>";
	
	panel += "<tr class='trDtl04'>"
	       + "<td id='tdError' class='Small' colspan=4 style='color:red;font-size:12px;'></td>"
	    + "</tr>"

	    + "<tr class='trDtl04'>"
	         + "<td nowrap class='td18' colspan=4><button onClick='vldPay("
	            + "&#34;" + emp + "&#34;, &#34;" + action + "&#34;)' class='Small'>Submit</button> "
	       + "<button onClick='hidePanel();' class='Small'>Cancel</button>"
	    + "</td></tr></table>"
   	return panel;
}


//==============================================================================
// validate entries
//==============================================================================
function vldPay(emp, action)
{
	var error = false;
	var msg  = "";
	var tderr = document.all.tdError;
	var br = "";
	tderr.innerHTML = "";
	
	var mon = new Array();
	for(var i=0; i < 3 ;i++)
	{
		mon[i] = document.all.Mon[i].value;
	}
	
	var prc = new Array();
	for(var i=0; i < 3 ;i++)
	{
		prc[i] = document.all.Prc[i].value.trim();
		if(prc[i]==""){ prc[i] = "0"; }
		else if(isNaN(prc[i])){ error=true; msg += br +  "The Percent must be a numeric value."; br="<br>"}
	}
	
	
	if(error){ tderr.innerHTML = msg; }
	else{ sbmPay(emp, mon,  prc, action); }	
}

//==============================================================================
//validate entries
//==============================================================================
function sbmPay(emp, mon,  prc, action)
{
	var url = "IncPlanFlSav.jsp?Emp=" + emp
	
	for(var i=0; i < mon.length; i++)
	{
		url += "&Mon=" + mon[i] 		  
	}
	
	for(var i=0; i < mon.length; i++)
	{
		url += "&Prc=" + prc[i]
	}
	
	url += "&Action=" + action;   
		
	//alert(url)
	window.frame1.location.href = url;
}


//==============================================================================
// set Quarterly payments
//==============================================================================
function setQtrPay()
{
	var hdr = "Submit Quaterly Payments";
  	var html = "<table border=0 width='100%' cellPadding=0 cellSpacing=0>"
	    + "<tr>"
	      + "<td class='BoxName' nowrap>" + hdr + "</td>"
	      + "<td class='BoxClose' valign=top>"
	        +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	      + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2><br>"
	        + "<span style='background:yellow; font-size:18px; font-weight:bold;'>"
	    		+ "&nbsp; Press Submit button to create payroll payment requerments. &nbsp;"
	    		+ "<br>&nbsp;This should only be done in the end of the quarter. &nbsp;"
	    	+ "</span>"
	    	+ "<br><br>" 
	    	+ "<button onclick='sbmQtrPay()' class='Small'>Submit</button> &nbsp;"
	    	+ "<button onClick='hidePanel();' class='Small'>Cancel</button>"
	     + "</td></tr>"
	   + "</table>"

	document.all.dvItem.innerHTML = html;
	document.all.dvItem.style.pixelLeft=document.documentElement.scrollLeft + 400;
	document.all.dvItem.style.pixelTop=document.documentElement.scrollTop + 100;
	document.all.dvItem.style.visibility = "visible";
}
//==============================================================================
//Hide selection screen
//==============================================================================
function sbmQtrPay()
{
	var answer = confirm(
	        "Are you sure that you want to submit payment requerment to payroll?"
	       + "\nThis should only be done in the end of the quarter."
	       )
	if (answer)
	{
		var url = "IncPlanFlSav.jsp?Str=ALL&Qtr=<%=sQtr%>&Action=MARKEDPAY";
		window.frame1.location.href=url;
	}
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

<script src="StrSelBox.js"></script>
<script src="MoveBox.js"></script>
<script src="String_Trim_function.js"></script>
<script src="Get_Object_Position.js"></script>
<script src="Calendar.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<div id="dvHelp" class="dvHelp"><a href="Intranet Reference Documents/1.0 Incentive Plan Floor Leader.pdf" class="helpLink" target="_blank">&nbsp;</a>
  <br>Incentive Plan Guidelines
</div>
<div id="dvTresh" class="dvItem">
       <table class="tbl10" id="tblInc" >
        <tr class="trHdr01">
          <th class="th02" colspan=3>Monthly Segment Success<br>Thresholds & Earnings Table</th>          
        </tr>
        <tr class="trHdr01">
          <th class="th02">Segment Success<br>Thresholds</th>
          <th class="th02">Monthly<br>Bonus Earnings</th>          
        </tr>
        	<%for(int i=0; i < iNumOfPln; i++){%>        
           		<tr id="trTot" class="trDtl04">		        
		        	<td class="td12" nowrap><%=sMinPrc[i]%><%if(!sMaxPrc[i].equals("99999.99")){%> - <%=sMaxPrc[i]%><%} else {%>+<%}%></td>
		        	<td class="td12" nowrap><%=sIncPrc[i]%></td>
		        </tr>
        	<%}%>
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
            <br>Coordinator Floor Leader Incentive
            <br>Quarter: FY <%=sFiscYr%> / <%=sQtrNum%>               
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
          	      <option value="2">2 Qtr Back</option>
          	      <option value="3">3 Qtr Back</option>
          	      <option value="4">4 Qtr Back</option>
          	   </select>
          	   &nbsp;
          	   <button class="Small" onclick="getOtherQtrReport()">Go</button>
          	   <%if(sArrStr.length > 2){%>          	   
          	   		&nbsp;&nbsp;&nbsp;&nbsp;
          	   		Select Store:
          	   		<select class="Small" name="SelStr"></select>
          	   		&nbsp;
          	   		<button class="Small" onclick="getOtherStrReport()">Go</button>
          	   <%}%>
          	   
          	   <%if(bAlwPay && sSelStr.equals("ALL")){%>
          	   		&nbsp;&nbsp;&nbsp;
          	   		<button class="Small" onclick="setQtrPay()"><b>PAY !!!</b></button>
          	   <%}%>
          	</td>
        </tr>   
        <tr>
          <td>  
      <table class="tbl02" id="tblEnt">
        <tr class="trHdr01">
          <th class="th02" rowspan=2>Str</th>
          <th class="th02" rowspan=2>Employee</th>
          <th class="th02" rowspan=2>Dpt</th>
          <th class="th02" rowspan=2>Title</th>
          <th class="th03" rowspan=2></th>
          
          <th class="th02" colspan=3>Percents</th>                              
          <th class="th03" rowspan=2></th>
          <th class="th02" colspan=3>Payout</th>          
          
          <th class="th02" rowspan=2>QTD</th>
          <th class="th03" rowspan=2>&nbsp;</th>
          <th class="th02" colspan=4>Payroll Processing</th>
        </tr>
        
        <tr class="trHdr01">
        <%for(int i=0; i < iNumOfMon; i++) {%>
             <th class="th02" id="tdWk"><%=sMonNm[i]%><br><%=sMonEnd[i]%></th>
          <%}%>
               
          
          <%for(int i=0; i < iNumOfMon; i++) {%>
             <th class="th02" id="tdWk"><%=sMonNm[i]%><br><%=sMonEnd[i]%></th>
          <%}%>
          
          <th class="th02">Marked</th>
          <th class="th02">User</th>
          <th class="th02">Date</th>
          <th class="th02">Time</th>
        </tr>
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvClr = "";
             String sTrCls = "trDtl06";             
             int iArg = 0;
             String sSvStr = null; 
           %>
           <%for(int i=0; i < iNumOfEmp; i++) 
           {
        	   setSls.setSlsInfo();
           	String sStr = setSls.getStr();
           	String sEmp = setSls.getEmp();
           	String [] sMnPrc = setSls.getMnPrc();
           	String [] sMnPay = setSls.getMnPay();
           	String sName = setSls.getName();
           	String sDept = setSls.getDept();
           	String sTitle = setSls.getTitle();
           	String sExists = setSls.getExists();
           	
           	String sMarked = setSls.getMarked();
        	String sPayUs = setSls.getPayUs();
        	String sPayDt = setSls.getPayDt();
        	String sPayTm = setSls.getPayTm();
        	String sRecUs = setSls.getRecUs();
        	String sRecDt = setSls.getRecDt();
        	String sRecTm = setSls.getRecTm();
        	
           	String sAction = "ADD";
           	if(sExists.equals("Y")){ sAction = "UPD";}
           	
           	String sMnPrcJsa = setSls.cvtToJavaScriptArray(sMnPrc);
           %>
           <%if(sSvStr != null && !sSvStr.equals(sStr)){%>
           		<tr class="Divider"><td colspan=18>&nbsp;</td></tr>
           <%}           	
           	sSvStr = sStr;	
           %>                           
            <tr id="trStr<%=i%>" class="<%=sTrCls%>">
               	<td class="td11" nowrap>&nbsp;<%=sStr%>&nbsp</td>
             	<td class="td11" nowrap>
             	    <%if(bAlwPay){%>
                		<a href="javascript: setMonth('<%=sEmp%>','<%=sName%>', [<%=sMnPrcJsa%>],'<%=sAction%>')"><%=sEmp%> - <%=sName%></a>
                	<%} else{%><%=sEmp%> - <%=sName%><%}%>
             	</td>
             	<td class="td11" nowrap><%=sDept%></td>
             	<td class="td11" nowrap><%=sTitle%></td>
         		<th class="th20"></th>
           		<%for(int k=0; k < iNumOfMon; k++) {%>
  	 				<td class="td11" id="tdWk"><%=sMnPrc[k]%>%</td>       				
    			<%}%> 
          		<th class="th20"></th>
          		<%for(int k=0; k < iNumOfMon; k++) {%>  	 				
       				<td class="td11" id="tdWk">$<%=sMnPay[k]%></td>
    			<%}%>
           		   <td class="td12">$<%=sMnPay[iNumOfMon]%></td>
           		
           		   <th class="th20"></th>
          		   <td class="td11" nowrap><%=sMarked%></td>
          		   <td class="td11" nowrap><%=sPayUs%></td>
          		   <td class="td11" nowrap><%=sPayDt%></td>
          		   <td class="td11" nowrap><%=sPayTm%></td>
          		   </tr>    
          		<%}%> 
          		<%
          		   setSls.setTotal(); 
          	       String [] sMnPay = setSls.getMnPay();
          	    %>   
          	    <tr class="trDtl12">
               		<td class="td11" nowrap>&nbsp;Totals&nbsp;</td> 
               		<td class="td11" colspan=7>&nbsp;</td>   
               		<th class="th20"></th> 
               		<%for(int k=0; k < iNumOfMon+1; k++) {%>  	 				
       					<td class="td11" id="tdWk">$<%=sMnPay[k]%></td>
    				<%}%>
    				<th class="th20"></th>
    				<td class="td11" colspan=7>&nbsp;</td>
    			</tr>
         </table>
         </td>
      </tr>
      <tr>
         <td align=left>
      <!----------------------- end of table ------------------------>      
      	</td>
      </tr>
      <tr>
        <td style="text-align:left;"><br>
      
            
       		
       	       		
       	  </th>
       	</tr>
       </table>
       <br><br> 
       
  <p style="text-align:left;">     
  *A minimum of 10 Sales Floor Leader Segements per month is needed to qualify. 
  <br>Refer to program guidlenes by clicking the "?" icon. 
       
       
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