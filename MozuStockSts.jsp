<%@ page import=" rciutility.RunSQLStmt, java.sql.*, java.math.*
	, java.util.*, rciutility.CallAs400SrvPgmSup"%>
<%
   	String sDate = request.getParameter("Date");
	String sFrTm = request.getParameter("FrTm");
	String sToTm = request.getParameter("ToTm");
	
	if(sDate ==null || sDate.trim().equals("")){ sDate = "current date"; }
	if(sFrTm ==null || sFrTm.trim().equals("")){ sFrTm = "00.00.00"; }
	if(sToTm ==null || sToTm.trim().equals("")){ sToTm = "23.59.59"; }

    
%> 
<html>
<head>

<LINK href="style/Page_0001.css" rel="stylesheet" type="text/css">

<style type="text/css" media="print">  
  .NonPrt  { display:none; }
  #Auto { display:none; }
    
</style>

<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var SelDate = "<%=sDate%>";
var SelTime = new Array();
var MxTime = 0;

//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
   setBoxclasses(["BoxName",  "BoxClose"], ["dvItem", "dvPhoto", "dvReason", "dvToolTip"]);  
   if(SelDate == "current date")
   {
	   var date = new Date();
	   document.all.Date.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear();
   }
   else
   {
	   document.all.Date.value = SelDate;
   }
}
//==============================================================================
//submit report with different date 
//==============================================================================
function sbmRep()
{
	var date = document.all.Date.value;
	var frtm = document.all.FromTm.value;
	var totm = document.all.ToTm.value;
	
	var url = "MozuStockSts.jsp?Date=" + date
	 + "&FrTm=" + frtm
	 + "&ToTm=" + totm
	 
	window.location.href = url; 
}
//==============================================================================
// Hide selection screen
//==============================================================================
function hidePanel()
{
   document.all.dvItem.innerHTML = " ";
   document.all.dvItem.style.visibility = "hidden";
}

//==============================================================================
//populate date with yesterdate
//==============================================================================
function setDate(direction, id, ymd)
{
var button = document.all[id];
var date = new Date(button.value);

date.setHours(18);

if(direction == "DOWN" && ymd=="DAY") { date = new Date(new Date(date) - 86400000); }
else if(direction == "UP" && ymd=="DAY") { date = new Date(new Date(date) - -86400000); }

if(direction == "DOWN" && ymd=="WK") { date = new Date(new Date(date) - 86400000 * 7 ); }
else if(direction == "UP" && ymd=="WK") { date = new Date(new Date(date) - -86400000 * 7 ); }

button.value = (date.getMonth()+1) + "/" + date.getDate() + "/" + date.getFullYear()
}

//==============================================================================
//populate date with yesterdate
//==============================================================================
function setSelTime(i, obj)
{		
	if(MxTime < 2)
	{
		obj.style.backgroundColor = "red";
		SelTime[SelTime.length] = i;
		MxTime++;
		SelTime.sort();		
	}	
	if(MxTime == 2)
	{
		for(var i=0; i < 24 * 4 + 1; i++)
		{
			if(i >= SelTime[0] && i <= SelTime[1])
			{
				var sel = "tdSel" + i;
				document.all[sel].style.backgroundColor = "red";
			}
		}
		
		document.all.FromTm.value = cvtTime(SelTime[0]);
		document.all.ToTm.value = cvtTime(SelTime[1]);		
	}
}
//==============================================================================
//convert selected array slot to time
//==============================================================================
function cvtTime(i)
{
	var hrs = Math.floor(i / 4);
	var min = i % 4 * 15;		
	if(min==0){ min = "00"}
	var tm = hrs + ":" + min + ":00";
	
	if(hrs==24){ tm = "23:59:59"; }
	
	return tm;
}
//==============================================================================
// reset time 
//==============================================================================
function resetTm()
{
	for(var i=0; i < 24 * 4 + 1; i++)
	{
		var sel = "tdSel" + i;
		document.all[sel].style.backgroundColor = "#e7e7e7";
	}
	SelTime = new Array();
	MxTime = 0;
	document.all.FromTm.value ="";
	document.all.ToTm.value ="";		
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="MoveBox.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="Get_Object_Position.js"></script>
<script LANGUAGE="JavaScript1.2" src="Calendar.js"></script>

</head>
<title>Mozu Stock Sts</title>

<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvItem" class="dvItem"></div>
<!-------------------------------------------------------------------->
   <table  class="tbl01" id="tblClaim" width="100%" >
     <tr>       
       <td ALIGN="center" VALIGN="TOP" colspan="3">
      <b>Mozu Stock/Price Status for Selected Date
      <br>Date: <%=sDate%> 
          Time: <%=sFrTm%> - <%=sToTm%>
       </b>
       </td>       
      </tr>

    <tr class="NonPrt">
      <td ALIGN="center" VALIGN="TOP" colspan="3">
        <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;
        &nbsp;&nbsp;&nbsp;        
      </td>
    </tr>
    <tr>
      <td ALIGN="center" VALIGN="TOP"  colspan="3" nowrap>
<!-------------------------------------------------------------------->
<!-- Order Header Information ->
<!-------------------------------------------------------------------->
    <table class="tbl02">
    <%
      String sPrepStmt = "select count(*) as count " 
    		+ " from RCI.MoPrcInv"
    		+ " where date(recdt) = current date";      	
    	  	      	
      //System.out.println(sPrepStmt);
    	  	       	
      ResultSet rslset = null;
      RunSQLStmt runsql = new RunSQLStmt();
      runsql.setPrepStmt(sPrepStmt);		   
      runsql.runQuery();
      String sNumRec = "0";
      if(runsql.readNextRecord()) {
      		sNumRec = runsql.getData("count").trim();
      }%>
     	<tr class="trDtl04">
     		<td class="td11">Number of Processed Items:</td>
     		<td class="td11" nowrap><%=sNumRec%></td>     	        
     	</tr>     
     
    <%
      sPrepStmt = "select count(*) as count " 
    		+ " from RCI.MoItDLog"
    		+ " where date(run_time) = current date";
      rslset = null;
      runsql = new RunSQLStmt();
      runsql.setPrepStmt(sPrepStmt);		   
      runsql.runQuery();
      sNumRec = "0";
      if(runsql.readNextRecord()) {
      		sNumRec = runsql.getData("count").trim();
      }%>
     	<tr class="trDtl04">
     		<td class="td11">Number of Sent:</td>
     		<td class="td11" nowrap><%=sNumRec%></td>     	        
     	</tr>
     	
     	<%
      sPrepStmt = "select count(*) as count " 
    		+ " from RCI.MoItDLog"
    		+ " where date(run_time) = current date"
    		+ " and IDERFLG <> ' '";
      rslset = null;
      runsql = new RunSQLStmt();
      runsql.setPrepStmt(sPrepStmt);		   
      runsql.runQuery();
      sNumRec = "0";
      if(runsql.readNextRecord()) {
      		sNumRec = runsql.getData("count").trim();
      }%>
     	<tr class="trDtl04">
     		<td class="td11">Number of Errors:</td>
     		<td class="td11" nowrap><%=sNumRec%></td>     	        
     	</tr>
     </table>
     
     
     
     	<br><br>
     	
     	
     	
     <table class="tbl02">	
     <%
      sPrepStmt = "with sumf as ("
       + " select  class, vendor,style, color, size"
       + ", IDBEGTM2 , IDendTM2"
       + ", dec(IDEndTM1 - IDBegTM1,9,3) as whole_upd"
       + ", dec(IDEndTM2 - IDBegTM2,9,3) as read_prod"
       + ", dec(IDEndTM3 - IDBegTM3,9,3) as upd_prod"
       + ", dec(IDEndTM4 - IDBegTM4,9,3) as read_loc"
       + ", dec(IDEndTM5 - IDBegTM5,9,3) as upd_loc"
       + ", run_time"
       + " from rci.MoItdLog"
    	+ " where";
      
      if(sDate.equals("current date")){ sPrepStmt += " date(run_time) = current date"; }
      else{ sPrepStmt += " date(run_time) = '" + sDate + "'"; }
    	
      sPrepStmt += " and time(run_time) >= '" + sFrTm + "'"
        + " and time(run_time) <= '" + sToTm + "'"
       	+ " and begtm1 > '0001-01-01 00:00:00.000000'"
       	+ " and endtm1 > '0001-01-01 00:00:00.000000'"
    	/*+ " and begtm2 > '0001-01-01 00:00:00.000000'"
       	+ " and endtm2 > '0001-01-01 00:00:00.000000'"
    	+ " and begtm3 > '0001-01-01 00:00:00.000000'"
       	+ " and endtm4 > '0001-01-01 00:00:00.000000'"
    	+ " and begtm5 > '0001-01-01 00:00:00.000000'"
       	+ " and endtm5 > '0001-01-01 00:00:00.000000'"
       	*/
    	+ " and (idproc='UPDATE_CHILD' or idproc='UPDATE_PARENT')"
       	/*+ " and parent = '2'"*/
    	+ " and IDEndTM1 >= IDBegTM1"
       	/*+ " and IDEndTM2 >= IDBegTM2"
    	+ " and IDEndTM3 >= IDBegTM3"
       	+ " and IDEndTM4 >= IDBegTM4"
    	+ " and IDEndTM5 >= IDBegTM5"
    	*/
       	+ ")"
       + " select count(*) as count"
       	+ ",dec(TIMESTAMPDIFF(2, char(max(run_time) - min(run_time))),11,0) as run_time" 
        + ",dec(avg(whole_upd),9,3) as avg_whole_upd " 
       	+ ",dec(avg(read_prod),9,3) as avg_read_prod" 
        + ",dec(avg(upd_prod),9,3) as avg_upd_prod"  
       	+ ",dec(avg(read_loc),9,3) as avg_read_loc" 
        + ",dec(avg(upd_loc),9,3) as avg_upd_loc" 
        + ",min(run_time) as mintm"
        + ",max(run_time) as maxtm"
       	+ " from sumf"
      ;
     
      System.out.println(sPrepStmt);
      rslset = null;
      runsql = new RunSQLStmt();
      runsql.setPrepStmt(sPrepStmt);		   
      runsql.runQuery();
      sNumRec = "0";
      String sRunTm = "0";
      String sRunTmHrs = "0";
      String sAvgWhole = "0";
      String sAvgReadProd = "0";
      String sAvgUpdProd = "0";
      String sAvgReadLoc = "0";
      String sAvgUpdLoc = "0";
      
      String sMinRunTm = "0";
      String sMaxRunTm = "0";
      
      if(runsql.readNextRecord()) {
      		sNumRec = runsql.getData("count").trim();
      		sRunTm = runsql.getData("run_time");
      		if(sRunTm != null)
      		{
      			BigDecimal bSec = new BigDecimal(sRunTm);      		
      			BigDecimal bHrs = bSec.divide(new BigDecimal("3600"),2, RoundingMode.HALF_EVEN);
      			sRunTmHrs = bHrs.toString();
      		}
      		
      		sAvgWhole = runsql.getData("avg_whole_upd");
      		sAvgReadProd = runsql.getData("avg_read_prod");
      		sAvgUpdProd = runsql.getData("avg_upd_prod");
      		sAvgReadLoc = runsql.getData("avg_read_loc");
      		sAvgUpdLoc = runsql.getData("avg_upd_loc");
      		
      		sMinRunTm = runsql.getData("mintm");
      		sMaxRunTm = runsql.getData("maxtm");
      }%>
        <tr class="trDtl04">
     		<td class="td11">Min/Max Running Time</td><td class="td12" nowrap><%=sMinRunTm%> &nbsp; <%=sMaxRunTm%></td>     		
     	</tr>
     	<tr class="trDtl04">
     		<td class="td11">Number of Records</td><td class="td12" nowrap><%=sNumRec%></td>     		
     	</tr>
        <tr class="trDtl04">
     		<td class="td11">Elapse Time</td><td class="td12" nowrap>
     		    <%=sRunTm%>s<br> or <%=sRunTmHrs%>h 
     		</td>     		
     	</tr>
     	<tr class="trDtl04">
     		<td class="td11">Average Whole Update</td><td class="td12" nowrap><%=sAvgWhole%>s</td>     		
     	</tr>
     	<!--  tr class="trDtl04">
     		<td class="td11">Average Read Product</td><td class="td12" nowrap><%=sAvgReadProd%>s</td>     		
     	</tr>
     	<tr class="trDtl04">
     		<td class="td11">Average Update Product</td><td class="td12" nowrap><%=sAvgUpdProd%>s</td>     		
     	</tr>
     	<tr class="trDtl04">
     		<td class="td11">Average Read Location</td><td class="td12" nowrap><%=sAvgReadLoc%>s</td>     		
     	</tr>
     	<tr class="trDtl04">
     		<td class="td11">Average Update Location</td><td class="td12" nowrap><%=sAvgUpdLoc%>s</td>     		
     	</tr -->
    </table>
    
    <br><br>
    
    <table class="tbl02">
    	<tr class="trDtl06">
     		<td class="td11">Date</td>
     		<td class="td11">
     			<button class="Small" name="Down" onClick="setDate('DOWN', 'Date', 'DAY')"><</button>
     			<input class="Small" name="Date" maxlength=10 size=12 readonly>
     			<button class="Small" name="Up" onClick="setDate('UP', 'Date', 'DAY')">></button>
               &nbsp;&nbsp;&nbsp;
             <a href="javascript:showCalendar(1, null, null, 300, 300, document.all.Date)" >
             <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
     		</td>     		     		
     	</tr>
     	<tr class="trDtl06">
     		<td class="td11">From Time</td>
     		<td class="td11"><input class="Small" name="FromTm" maxlength=8 size=12 readonly></td>     		     		     		
     	</tr>
     	<tr class="trDtl06">
     		<td class="td11">To Time</td>
     		<td class="td11"><input class="Small" name="ToTm" maxlength=8 size=12 readonly></td>     		     		
     	</tr>
     	<tr class="trDtl06">
     		<td class="td11">Select Time<br><a href="javascript: resetTm()">Reset</a></td>
     		<td class="td11">
     		  <table id="tblSelTm" class="tbl02">
     		    <tr>
     		  		<%for(int i=0; i < 24; i++){%>
     		  		   <td id="tdHrs" class="td57"  colspan=4><%=i%>
     		  		   </td>     		     
     		  		<%}%>
     		  	</tr>
     		  	<tr>
     		  		<%for(int i=0, j=0; i < 24 * 4+1; i++, j++){%>     		  		 
     		  		   <td id="tdMin" class="td57"><%if(j==0){%>00<%} else if(j==1){%>15<%} else if(j==2){%>30<%} else if(j==3){%>45<%}%></td>
     		  		   <%if(j==3){ j = -1; }%>     		     
     		  		<%}%>
     		  	</tr>
     		    <tr>
     		  		<%for(int i=0; i < 24 * 4+1; i++){%>
     		  		   <td id="tdSel<%=i%>" class="td57" onclick="setSelTime('<%=i%>', this)">&nbsp;</td>     		     
     		  		<%}%>
     		  	</tr>
     		  </table>
     		</td>     		     		
     	</tr>
     	<tr class="trDtl06">     		
     		<td class="td18" colspan=2><button onclick="sbmRep()">Submit</button>     		     		
     	</tr>    
    </table>    
    
    
    
    
    
    
    
  </table>     
 </body>
</html>














