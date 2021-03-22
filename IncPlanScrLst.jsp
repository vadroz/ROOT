<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
   String sYear = request.getParameter("Year");
   String sQtr = request.getParameter("Qtr");
   String sScrCd = request.getParameter("ScrCd");
   String sScrNm = request.getParameter("ScrNm");
   
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
     response.sendRedirect("SignOn1.jsp?TARGET=IncPlanScrLst.jsp&APPL=ALL&" + request.getQueryString());
}
else
{	
	String sStrAllowed = session.getAttribute("STORE").toString();
	String sUser = session.getAttribute("USER").toString();	
	
   	String sPrepStmt = "select sstr, snam"
   	   + ", (select char(MSSCR) from rci.INMANSCR where MsName='" + sScrCd + "'" 
   	       + " and MsYear=" + sYear + " and MsQtr=" + sQtr + " and MsStr=sstr) as Scr"
   	   + ", (select char(MsPayP) from rci.INMANSCR where MsName='" + sScrCd + "'" 
   	    + " and MsYear=" + sYear + " and MsQtr=" + sQtr + " and MsStr=sstr) as payout"
   	   + " from IPTSFIL.IpStore"
   	   + " where ssts='S'"   		    
   	   + " order by sstr";
   	
   	System.out.println(sPrepStmt);
   	
   	ResultSet rslset = null;
   	RunSQLStmt runsql = new RunSQLStmt();
   	runsql.setPrepStmt(sPrepStmt);		   
   	runsql.runQuery();
   		   
   	Vector<String> vStr = new Vector<String>();
   	Vector<String> vStrNm = new Vector<String>();
   	Vector<String> vScr = new Vector<String>();
   	Vector<String> vPayout = new Vector<String>();
   		   
    while(runsql.readNextRecord())
   	{
   		vStr.add(runsql.getData("sstr"));
   		vStrNm.add(runsql.getData("snam"));
   		
   		String sScr = runsql.getData("scr");
   		if(sScr == null || sScr.trim().equals(".00000")){vScr.add("");}
   		else { vScr.add(sScr.trim());}

   		String sPayout = runsql.getData("payout");
   		if(sPayout == null || sPayout.trim().equals(".00000")){vPayout.add("");}
   		else { vPayout.add(sPayout.trim());}
   	}
    runsql.disconnect();
   	runsql = null;
   	
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<!-- script src="script/Input_Behavior_001.js"></script -->

<title>Inc.Plan Scores Entries</title>

<SCRIPT>

//--------------- Global variables -----------------------
var Year = "<%=sYear%>";
var Qtr = "<%=sQtr%>";
var ScrNm = "<%=sScrNm%>";
var ScrCd = "<%=sScrCd%>";
   
var NumOfStr = "<%=vStr.size()%>";

var progressIntFunc = null;
var progressTime = 0;

 //--------------- End of Global variables ----------------

//==============================================================================
// initial process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem"]);
   document.all.dvPayout.style.visibility="visible";
}
//==============================================================================
// validate entry
//==============================================================================
function Validate()
{
	var error = false;	
	var str = new Array();
	var scr = new Array();
	var pay = new Array();
		
	for(var i=0; i < NumOfStr; i++)
	{
		var msg ="";
		var br = "";
		str[i] = $("#Str" + i).val();
		scr[i] = $("#Scr" + i).val().trim();
		
		
		if(ScrCd == "Training"){
			if(scr[i] < 90){ pay[i] = "0.000"; }
			else if(scr[i] >= 90 && scr[i] < 94){ pay[i] = "0.25"; }
			else if(scr[i] >= 94 && scr[i] < 97){ pay[i] = "0.500"; }
			else if(scr[i] >= 97){  pay[i] = "0.75"; }
		}
		else if(ScrCd == "FlrLeader"){
			if(scr[i] < 40){ pay[i] = "0.0"; }
			else if(scr[i] >= 40 && scr[i] < 50){ pay[i] = "150"; }
			else if(scr[i] >= 50 && scr[i] < 60){ pay[i] = "300"; }
			else if(scr[i] >= 60){  pay[i] = "500"; }
		}
		else if(ScrCd == "Survey"){
			if(scr[i] < 4.5){ pay[i] = "0.000"; }
			else if(scr[i] >= 4.5 && scr[i] < 4.7){ pay[i] = "0.25"; }
			else if(scr[i] >= 4.7 && scr[i] < 4.9){ pay[i] = "0.500"; }
			else if(scr[i] >= 4.9){  pay[i] = "0.75"; }
		}
		else
		{			
			pay[i] = $("#Payout" + i).val().trim();
		}	
		
		if(scr[i] != "" && isNaN(scr[i]))
		{ 
			error = true; 
			msg += br + "Score is not numeric.";
			br = "<br>";
		    $("#tdError" + i).html(msg); 
		}
		else if(scr[i] == ""){scr[i] = "0";}
			
		if(pay[i] != "" && isNaN(pay[i]))
		{ 
			error = true; 
			msg += br + "Payout is not numeric.";
			br = "<br>";
		    $("#tdError" + i).html(msg); 
		}		
		else if(pay[i] == ""){pay[i] = "0";}
	}
	if(!error){sbmScore(str,scr,pay)}
}
//==============================================================================
// submit scores
//==============================================================================
function sbmScore(str,scr,pay)
{
	progressIntFunc = setInterval(function() {showWaitBanner() }, 1000);
	
	var url = "IncPlanScrSv.jsp?"
	  + "Year=" + Year
	  + "&Qtr=" + Qtr
	  + "&ScrNm=" + ScrNm
	  + "&ScrCd=" + ScrCd
	  ;
	
	for(var i=0; i < str.length; i++)
	{
		url += "&Str=" + str[i]
		  + "&Scr=" + scr[i]
		  + "&Pay=" + pay[i]
	}
	window.frame1.location.href = url;
}
//==============================================================================
// restart
//==============================================================================
function restart()
{
	clearInterval( progressIntFunc );
	document.all.dvWait.style.visibility = "hidden";
	
	window.location.reload();
}
//==============================================================================
//check which Key Down pressed 
//==============================================================================
function chkKeyDown( i, event)
{
	var key = event.keyCode
	// enter key in any field or tab key in comment  
	if(key == 9 || key == 13)
	{
		var error = false;
		var msg ="";
		var br = "";
	
		var str = $("#Str" + i).val();
		var scr = $("#Scr" + i).val().trim();
		
		if(scr != "" && isNaN(scr))
		{ 
			error = true; msg += br + "Score is not numeric."; br = "<br>";
	    	$("#tdError" + i).html(msg); 
		}
		else if(scr > 100)
		{ 
			error = true; msg += br + "Scores cannot be greater then 100%."; br = "<br>";
	    	$("#tdError" + i).html(msg); 
		}
		else if(scr[i] == ""){scr = "0";}	
	
		//calculate score
		if(!error)
		{
			if(ScrCd == "Training")
			{
				if(scr < 90){ $("#tdPay" + i).html("0.000"); }
				else if(scr >= 90 && scr < 94){ $("#tdPay" + i).html("0.25"); }
				else if(scr >= 94 && scr < 97){ $("#tdPay" + i).html("0.500"); }
				else if(scr >= 97){  $("#tdPay" + i).html("0.75"); }
			}
			else if(ScrCd == "FlrLeader")
			{
				if(scr < 40){ $("#tdPay" + i).html("0.000"); }
				else if(scr >= 40 && scr < 50){ $("#tdPay" + i).html("0.25"); }
				else if(scr >= 50 && scr < 60){ $("#tdPay" + i).html("0.50"); }
				else if(scr >= 60){ $("#tdPay" + i).html("0.75"); }
			}
			else if(ScrCd == "Survey")
			{
				if(scr < 4.5){ $("#tdPay" + i).html("0.000"); }
				else if(scr >= 4.5 && scr < 4.7){ $("#tdPay" + i).html("0.25"); }
				else if(scr >= 4.7 && scr < 4.9){ $("#tdPay" + i).html("0.500"); }
				else if(scr >= 4.9){ $("#tdPay" + i).html("0.75"); }
			}
		}
		
		
		if(key == 13)
		{
			if(i < NumOfStr - 1){ i++; }
			$("#Scr" + i).focus();
			$("#Scr" + i).select();
		}
	}	
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
	document.all.dvWait.style.top= document.documentElement.scrollTop + 205;
	document.all.dvWait.style.backgroundColor="#cccfff"
	document.all.dvWait.style.visibility = "visible";
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
<div id="dvHelp" class="dvHelp"><a href="Intranet Reference Documents/1.0 Incentive Plan Score Guideline.pdf" class="helpLink" target="_blank">&nbsp;</a>
  <br>Incentive Plan Guidelines
</div>
<div id="dvPayout" class="dvItem">
   <%if(sScrCd.equals("Training")){%>
       <table class="tbl10" id="tblInc" >
        <tr class="trHdr01">
          <th class="th02" colspan=3>Score/Payout Conversion Table</th>          
        </tr>
        <tr class="trHdr01">
          <th class="th02">Score</th>
          <th class="th02">Payout</th>          
        </tr>
       <tr id="trTot" class="trDtl04">		        
		    <td class="td12" nowrap>0 - 89.9</td>
		    <td class="td12" nowrap>0</td>
		</tr>
		<tr id="trTot" class="trDtl04">		        
		    <td class="td12" nowrap>90 - 93.9</td>
		    <td class="td12" nowrap>0.25</td>
		</tr>
		<tr id="trTot" class="trDtl04">		        
		    <td class="td12" nowrap>94 - 96.9</td>
		    <td class="td12" nowrap>0.5</td>
		</tr>
		<tr id="trTot" class="trDtl04">		        
		    <td class="td12" nowrap>97 - +++</td>
		    <td class="td12" nowrap>0.75</td>
		</tr>        
       </table>
    <%}%>   
    <%if(sScrCd.equals("Survey")){%>
       <table class="tbl10" id="tblInc" >
        <tr class="trHdr01">
          <th class="th02" colspan=3>Score/Payout Conversion Table</th>          
        </tr>
        <tr class="trHdr01">
          <th class="th02">Score</th>
          <th class="th02">Payout</th>          
        </tr>
        <tr id="trTot" class="trDtl04">		        
		    <td class="td12" nowrap>0 - 4.5</td>
		    <td class="td12" nowrap>0</td>
		</tr>
		<tr id="trTot" class="trDtl04">		        
		    <td class="td12" nowrap>4.5 - 4.6</td>
		    <td class="td12" nowrap>0.25</td>
		</tr>
		<tr id="trTot" class="trDtl04">		        
		    <td class="td12" nowrap>4.7 - 4.8</td>
		    <td class="td12" nowrap>0.5</td>
		</tr>
		<tr id="trTot" class="trDtl04">		        
		    <td class="td12" nowrap>4.8 - 5.0</td>
		    <td class="td12" nowrap>0.75</td>
		</tr>        
       </table>
    <%}%> 
     
    <%if(sScrCd.equals("FlrLeader")){%>
       <table class="tbl10" id="tblInc" >
        <tr class="trHdr01">
          <th class="th02" colspan=3>Score/Payout Conversion Table</th>          
        </tr>
        <tr class="trHdr01">
          <th class="th02">Score</th>
          <th class="th02">Payout</th>          
        </tr>
       <tr id="trTot" class="trDtl04">		        
		    <td class="td12" nowrap>0 - 39.99</td>
		    <td class="td12" nowrap>$0</td>
		</tr>
		<tr id="trTot" class="trDtl04">		        
		    <td class="td12" nowrap>40 - 49.99</td>
		    <td class="td12" nowrap>0.25</td>
		</tr>
		<tr id="trTot" class="trDtl04">		        
		    <td class="td12" nowrap>50 - 59.9</td>
		    <td class="td12" nowrap>0.50</td>
		</tr>
		<tr id="trTot" class="trDtl04">		        
		    <td class="td12" nowrap>60 - +++</td>
		    <td class="td12" nowrap>0.75</td>
		</tr>        
       </table>
    <%}%>  
    
    <%if(sScrCd.equals("Compliance")){%>
       <table class="tbl10" id="tblInc" >
        <tr class="trHdr01">
          <th class="th02" colspan=3>Rank/Payout Table</th>          
        </tr>
        <tr class="trHdr01">
          <th class="th02">Rank</th>
          <th class="th02">Payout</th>          
        </tr>
       <tr id="trTot" class="trDtl04">		        
		    <td class="td12" nowrap>1-6</td>
		    <td class="td12" nowrap>0.75</td>
		</tr>
		<tr id="trTot" class="trDtl04">		        
		    <td class="td12" nowrap>7-12</td>
		    <td class="td12" nowrap>0.5</td>
		</tr>
		<tr id="trTot" class="trDtl04">		        
		    <td class="td12" nowrap>13-18</td>
		    <td class="td12" nowrap>0.25</td>
		</tr>
		<tr id="trTot" class="trDtl04">		        
		    <td class="td12" nowrap>19-33</td>
		    <td class="td12" nowrap>0</td>
		</tr>        
       </table>
    <%}%>  
</div>       
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
            <br>Incentive Plan Manual Score Entries 
            <br> Fiscal Year: <%=sYear%> Quarter: <%=sQtr%>
            <br>Score Name: <%=sScrNm%>            
            </b>
            <br>
              <a href="/"><font color="red" size="-1">Home</font></a>&#62;
              <a href="IncPlanScrLstSel.jsp"><font color="red" size="-1">Selection</font></a>&#62;
              <font size="-1">This Page.</font> &nbsp; &nbsp; &nbsp; &nbsp;  
              <a href="javascript: Validate()">Save</a>          
          </th>
        </tr>
        <tr>
          <td>  
      <table class="tbl02">
        <tr class="trHdr01">
          <th class="th02">Store</th>
          <th class="th02">
          <%if(sScrCd.equals("FlrLeader")){%>Success<br>%<%} else {%>Score<%}%></th>
          <th class="th02">Payout<br>%</th>
          <th class="th02">Error</th>
        </tr>
<!------------------------------- order/sku --------------------------------->
           <%String sSvOrd = "";
             String sTrCls = "trDtl06"; 
             int iArg = -1;
           %>
           <%for(int i=0; i < vStr.size(); i++) {%>                           
           	<tr id="trGrp<%=i%>" class="<%=sTrCls%>">
             	<td class="td11" ><%=vStr.get(i) + " - " + vStrNm.get(i)%>
             		<input type="hidden" id="Str<%=i%>" name="Str<%=i%>"  value="<%=vStr.get(i)%>">             		
             	</td>
             	<td class="td11" ><%if(!sScrCd.equals("Training") && !sScrCd.equals("FlrLeader") && !sScrCd.equals("Survey")){%>N/A<%}%>
             	   <input id="Scr<%=i%>" name="Scr<%=i%>" onkeydown="chkKeyDown('<%=i%>', event)" value="<%=vScr.get(i)%>"
             	   <%if(!sScrCd.equals("Training") && !sScrCd.equals("FlrLeader")  && !sScrCd.equals("Survey")){%>type="hidden"<%}%>>
             	</td>
             	<td class="td11" id="tdPay<%=i%>"><%if(sScrCd.equals("Training") || sScrCd.equals("FlrLeader") || sScrCd.equals("Survey")){%><%=vPayout.get(i)%><%}%>
             		<input id="Payout<%=i%>" name="Payout<%=i%>" value="<%=vPayout.get(i)%>"
             		 <%if(sScrCd.equals("Training") || sScrCd.equals("FlrLeader") || sScrCd.equals("Survey")){%>type="hidden"<%}%>>
             	</td>
             	<td class="tdError" id="tdError<%=i%>"></td>
           	</tr>            	
           <%}%>
         </table>
         <p style="text-align:center;">
         <a href="javascript: Validate()">Save</a>
      <!----------------------- end of table ------------------------>
      </tr>
   </table>
 </body>
</html>
<%
}
%>