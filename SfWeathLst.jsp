<%@ page import="strforce.SfWeathLst, rciutility.StoreSelect, java.util.*, java.text.*
,java.text.SimpleDateFormat"%>
<%
   String sWkend = request.getParameter("Wkend");
   if(sWkend == null)
   { 
	   sWkend = "Todate";
	   Date curDate = new Date();
	   Calendar cal = Calendar.getInstance();
	   cal.setTime(curDate);	   
	   if(cal.get(cal.DAY_OF_WEEK) > 1)
	   {
		   while(cal.get(cal.DAY_OF_WEEK) != 1)
		   {
			   cal.add(cal.DATE, -1);
		   }
		   curDate.setTime(cal.getTime().getTime());
	   }
	   SimpleDateFormat format = new SimpleDateFormat();
	   format = new SimpleDateFormat("MM/dd/yyyy");
	   sWkend = format.format(curDate);
   }
     
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=SfWeathLst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();
		 
	SfWeathLst sfwth = new SfWeathLst();
	sfwth.setWeathLst(sWkend);
	int iNumOfMkt = sfwth.getNumOfMkt();
	
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>StoreForce Weather Averages</title>
<SCRIPT>

//--------------- Global variables ----------------------- 
var Week1 = "<%=sWkend%>"; 
var User = "<%=sUser%>";
var mktFut = new Array();
 
 //--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   setSelDate();
}
//==============================================================================
// set selection date
//==============================================================================
function setSelDate()
{
	//var futday = document.all.selDate;	
	var date = new Date(Week1);

	date = new Date(setToLastSunday(date)); 
	/*for(var i=0; i < 3; i++)
	{		
		var selday = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
		futday.options[i] = new Option(selday, selday);
		date = new Date(date - (-7) * 86400000);
	}*/
	
	document.all.SampDate.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
}
//==============================================================================
//set last sunday
//==============================================================================
function setToLastSunday(d) 
{
	  return d.setDate(d.getDate() - d.getDay());
}
//==============================================================================
// get new report with selected date
//==============================================================================
function getRepBySelDate()
{
	//var date = document.all.selDate.options[document.all.selDate.selectedIndex].value;
	date = document.all.SampDate.value;
	var url="SfWeathLst.jsp?Wkend=" + date;
	window.location.href = url;
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
// get Market Average temperature
//==============================================================================
function getMktAvgTemp(arg, mkt, mktnm, wk1, wk2, wk3)
{
	mktFut = new Array();
	for(var i=0; i < 8; i++)
	{
		var tdnm = "tdAvg" + arg + i;
		var obj = document.all[tdnm];
		var avg = eval(document.all[tdnm].innerHTML);
		mktFut[i] = avg;
	}
	
	var url = "SfWeathMkt.jsp?mkt=" + mkt
		+ "&wk=" + wk1
		+ "&wk=" + wk2
		+ "&wk=" + wk3
		+ "&nm=" + mktnm
	window.frame1.location.href=url;	
}
//==============================================================================
//get Market Average temperature
//==============================================================================
function showHistTemp(mktnm, wk, avg, sls, trf)
{
	var hdr = mktnm + " - 3 selected Weeks of Weather History";

	   var html = "<table border=0 class='tbl02'>"
	     + "<tr class='trDtl19'>"
	       + "<td class='BoxName' nowrap>" + hdr + "</td>"
	       + "<td class='BoxClose' valign=top>"
	         +  "<img src='CloseButton.bmp' onclick='javascript:hidePanel();' alt='Close'>"
	       + "</td></tr>"
	    + "<tr><td class='Prompt' colspan=2>" + popHistTemp(wk, avg, sls, trf)
	     + "</td></tr>"
	   + "</table>"

	   document.all.dvItem.innerHTML = html;
	   document.all.dvItem.style.pixelLeft= document.documentElement.scrollLeft + 440;
	   document.all.dvItem.style.pixelTop= document.documentElement.scrollTop + 195;
	   document.all.dvItem.style.visibility = "visible";
	}
	//==============================================================================
	// populate History Panel
	//==============================================================================
	function popHistTemp(wk, avg, sls, trf)
	{
	  var panel = "<table border=1 width='100%' cellPadding='0' cellSpacing='0'>"
	  panel += "<tr class='trHdr01'>"
		 + "<th class='th02' nowrap>Week</th>"
		 + "<th class='th02' nowrap>&nbsp;</th>"
		 + "<th class='th02' nowrap>Monday</th>"
		 + "<th class='th02' nowrap>Tuesday</th>"
		 + "<th class='th02' nowrap>Wednesday</th>"
		 + "<th class='th02' nowrap>Thursday</th>"
		 + "<th class='th02' nowrap>Friday</th>"
		 + "<th class='th02' nowrap>Saturday</th>"
		 + "<th class='th02' nowrap>Sunday</th>"
		 + "<th class='th02' nowrap>Total</th>"		     
	   + "</tr>";
	   
	  for(var i=0; i < wk.length; i++)
	  {
		  if(wk[i] != "01/01/0001")
		  {
			  panel += "<tr class='trDtl04'>"
				+ "<td class='td12' rowspan=4 nowrap>" + wk[i] + "</td>"
				+ "<td class='td12' nowrap>Temp </td>";
			
	      	  for(var j=0; j < 8; j++)
		      {	    	   
	    	      panel += "<td class='td12' nowrap>" + avg[i][j] + "</td>";
		      }
	          
	      	  panel += "</tr>" 
	             + "<tr class='trDtl04'>"
	        	    + "<td class='td12' nowrap>Score</td>";
	        	
	          var tot = 0;   	
	          for(var j=0; j < 7; j++)
	          {	    	   
	    	    var scr = Math.abs(mktFut[j] - eval(avg[i][j])).toFixed(2);
	    	  	tot += eval(scr); 
		  	  	panel += "<td class='td12' nowrap>" + scr + "</td>";
		  	  }
	      	  panel += "<td class='td12' nowrap>" + tot + "</td>";
	          panel += "</tr>"
	          
	          panel += "<tr class='trDtl04'>"
	  			+ "<td class='td12' nowrap>Sales</td>";
	  			
	  	      for(var j=0; j < 8; j++)
	  		  {
	  	    	  panel += "<td class='td12' nowrap>" + sls[i][j] + "</td>";
	  		  }	
	  	      
	  	      panel += "<tr class='trDtl04'>"
	  			+ "<td class='td12' nowrap>Traffic</td>";
	  			
	  	      for(var j=0; j < 8; j++)
	  		  {
	  	    	  panel += "<td class='td12' nowrap>" + trf[i][j] + "</td>";
	  		  }
	  	      
	  	      panel += "<tr class='Divider'><td colspan=10>&nbsp;</td></tr>";
	  	    
		  }
	  }		  

	  panel += "<tr>";
	  panel += "<td class='td18' colspan=9><button onClick='hidePanel();' class='Small'>Close</button></td></tr>"
	  panel += "</table>";
	  return panel;
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
//populate date with yesterdate
//==============================================================================
function  setDate(direction, id)
{
var button = document.all[id];
var date = new Date(button.value);


if(direction == "DOWN") date = new Date(new Date(date) - 86400000);
else if(direction == "UP") date = new Date(new Date(date) - -86400000);
button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
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
        <tr class="trDtl19">
          <th colspan=45>
            <b>Retail Concepts, Inc
            <br>StoreForce Weather Averages 
            <br>Weekend: <%if(!sWkend.equals("Todate")){%><%=sWkend%><%} else{%>This Week<%}%> 
            <br><br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
               
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp; 
              <br>Select Weekend: <!-- select name="selDate"></select-->
              <button class="Small" name="Down" onClick="setDate('DOWN', 'SampDate')">&#60;</button>
              <input class="Small" name="SampDate" type="text" size=10 maxlength=10>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'SampDate')">&#62;</button>
              &nbsp;&nbsp;&nbsp;
              <a href="javascript: showCalendar(1, null, null, 900, 80, document.all.SampDate)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>&nbsp;
              <button onclick="getRepBySelDate()">Go</button>         
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
        	<th class="th02" rowspan=2>Market</th>
            <th class="th02" rowspan=2>Week<br>1</th>
            <th class="th02" rowspan=2>Week<br>2</th>
            <th class="th02" rowspan=2>Week<br>3</th>
            <th class="th02" rowspan=2>&nbsp;</th>
            <th class="th02" colspan=8>Week Days</th>
        </tr> 
        <tr class="trHdr01">
          <th class="th02">Monday</th>
          <th class="th02">Tuesday</th>
          <th class="th02">Wednesday</th>
          <th class="th02">Thursday</th>
          <th class="th02">Friday</th>
          <th class="th02">Saturday</th>
          <th class="th02">Sunday</th>
          <th class="th02">Total</th>
        </tr>
        
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < iNumOfMkt; i++) {        	   
        	   	sfwth.setMktList();
   				String sMkt = sfwth.getMkt();
   				String sMktNm = sfwth.getMktNm();
   				String [] sWkSamp = sfwth.getWkSamp();
   				String [] sAvg = sfwth.getAvg(); 
   				
   				if(sTrCls.equals("trDtl06")){sTrCls = "trDtl04";}
   				else {sTrCls = "trDtl06";} 
   				 
           %>                           
           <tr id="trGrp<%=i%>" class="<%=sTrCls%>">
             <td id="tdMkt<%=i%>" class="td11" nowrap>
                <a href="javascript: getMktAvgTemp('<%=i%>','<%=sMkt%>', '<%=sMktNm%>','<%=sWkSamp[0]%>','<%=sWkSamp[1]%>','<%=sWkSamp[2]%>')"><%=sMktNm%></a></td>
             <td id="tdWk1<%=i%>" class="td11" nowrap><%if(!sWkSamp[0].equals("01/01/0001")){%><%=sWkSamp[0]%><%}else {%>&nbsp;<%}%></td> 
             <td id="tdWk2<%=i%>" class="td11" nowrap><%if(!sWkSamp[1].equals("01/01/0001")){%><%=sWkSamp[1]%><%}else {%>&nbsp;<%}%></td>
             <td id="tdWk3<%=i%>" class="td11" nowrap><%if(!sWkSamp[2].equals("01/01/0001")){%><%=sWkSamp[2]%><%}else {%>&nbsp;<%}%></td>
             <th class="th04" >&nbsp;</td>
             <%for(int j=0; j < 8; j++){%>
                <td id="tdAvg<%=i%><%=j%>" class="td12" nowrap><%=sAvg[j]%></td>
             <%}%>                           
           </tr>
           <%}%> 
           <!-- ======Total ================ -->
             
             
         </table>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
sfwth.disconnect();
sfwth = null;
}
%>