<%@ page import="java.util.*, java.text.*, rciutility.CallAs400SrvPgmSup"%>  
<%
   String sType = request.getParameter("Type");
   String sStr = request.getParameter("Str");
   String sGrpNm = request.getParameter("GrpNm");
   String [] sColNm = request.getParameterValues("ColNm");
   String [] sPer = request.getParameterValues("Per");
   String [] sTy = request.getParameterValues("TY");
   String [] sLy = request.getParameterValues("LY");
   String [] sVar = request.getParameterValues("Var");
   String [] sGoal = request.getParameterValues("Goal");
   
   CallAs400SrvPgmSup as4pgm = new CallAs400SrvPgmSup();
   String sColNmJsa = as4pgm.cvtToJavaScriptArray(sColNm);
   String sPerJsa = as4pgm.cvtToJavaScriptArray(sPer);
   String sTyJsa = as4pgm.cvtToJavaScriptArray(sTy);
   String sLyJsa = as4pgm.cvtToJavaScriptArray(sLy);
   String sVarJsa = as4pgm.cvtToJavaScriptArray(sVar);
   String sGoalJsa = as4pgm.cvtToJavaScriptArray(sGoal);
 %>
<!DOCTYPE html>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<title>Line Graph 1</title>
<style>
  .hdr01 {font-size:18px;font-weight:bold;}
  .hdr02 {font-size:14px;font-weight:bold;}
  .TYLegend01 {font-size:12px;background: #BD0E0E;}
  .TYLegend02 {font-size:12px;background: #DCDCDC;}
  .TYLegend03 {font-size:12px;background: #2CF762;}  
</style>

<script type="text/javascript" src="scripts/Chart.js-master/Chart.js"></script>



<script>
//==========================================================================
//global varaibles
//==========================================================================
var GrpNm = "<%=sGrpNm%>";	
var ArrColNm = [<%=sColNmJsa%>];
var ArrPer = [<%=sPerJsa%>];
var ArrTy = [<%=sTyJsa%>];
var ArrLy = [<%=sLyJsa%>];
var ArrVar = [<%=sVarJsa%>];
var ArrGoal = [<%=sGoalJsa%>];

// graph data and options
var data = {
	    labels: [],
	    datasets: [
	        {
	            label: "Last",
	            fillColor: "rgba(220,220,220,0.2)",
	            strokeColor: "rgba(220,220,220,1)",
	            pointColor: "rgba(220,220,220,1)",
	            pointStrokeColor: "#fff",
	            pointHighlightFill: "#fff",
	            pointHighlightStroke: "rgba(220,220,220,1)",
	            data: []
	        },
	        {
	            label: "Goal",
	            fillColor: "rgba(44,247,98,0.2)",
	            strokeColor: "rgba(44,247,98,1)",
	            pointColor: "rgba(44,247,98,1)",
	            pointStrokeColor: "#fff",
	            pointHighlightFill: "#fff",
	            pointHighlightStroke: "rgba(151,187,205,1)",
	            data: []
	        },
	        {
	            label: "This",
	            fillColor: "rgba(189,14,14,0.2)",
	            strokeColor: "rgba(189,14,14,1)",
	            pointColor: "rgba(189,14,14,1)",
	            pointStrokeColor: "#fff",
	            pointHighlightFill: "#fff",
	            pointHighlightStroke: "rgba(151,187,205,1)",
	            data: []
	        }
	    ]
	};

var options = {
    scaleShowGridLines : true,
    scaleGridLineColor : "rgba(0,0,0,.05)",
    scaleGridLineWidth : 1,
    bezierCurve : true,
    bezierCurveTension : 0.4,
    pointDot : true,
    pointDotRadius : 4,
    datasetStroke : true,	    
    datasetStrokeWidth : 2,
    datasetFill : true
};


//==========================================================================
// initial process
//==========================================================================
function bodyload()
{
	drawGraph();
}
//==========================================================================
//initial process
//==========================================================================
function drawGraph()
{
	for(var i=0; i < ArrPer.length; i++)
	{
	   	data.labels[i] = ArrPer[i];
	}
	
	for(var i=0; i < ArrTy.length; i++){ data.datasets[2].data[i] = ArrTy[i]; }
	for(var i=0; i < ArrLy.length; i++){ data.datasets[0].data[i] = ArrLy[i]; }	   	
	for(var i=0; i < ArrGoal.length; i++){ data.datasets[1].data[i] = ArrGoal[i]; }
	for(var i=0; i < ArrVar.length; i++){ data.datasets[2].data[i] = ArrVar[i]; }
	
	var ctx = document.getElementById("myChart").getContext("2d");      
	var myLineChart = new Chart(ctx).Line(data, options);
}
</script>
<script src="String_Trim_function.js"></script>

<HTML><HEAD>

</HEAD>
<BODY onload="bodyload()">

<span class="hdr01"><%=sGrpNm%></span><br>
<span class="hdr02">From: <%=sPer[0]%> &nbsp; To: <%=sPer[sPer.length-1]%></span><br>
<span class="hdr02"><%if(sType.equals("STR")){%>Store: <%}%><%=sStr%></span><br>

<table>
	<tr>
	 <%for(int i=0; i < sColNm.length; i++){ %>
	 	<%if( sColNm[i].equals("TY") ){%>
			<td class="TYLegend01">&nbsp;&nbsp;&nbsp;&nbsp;</td><td> - This Year</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<%}%>
		<%if( sColNm[i].equals("LY") ){%>		 
 			<td class="TYLegend02">&nbsp;&nbsp;&nbsp;&nbsp;</td><td> - Last Year</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
 		<%}%>
		<%if( sColNm[i].equals("Goal") ){%>
 			<td class="TYLegend03">&nbsp;&nbsp;&nbsp;&nbsp;</td><td> - Goal</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
 		<%}%>
		<%if( sColNm[i].equals("Var") ){%>	
 	 		<td class="TYLegend01">&nbsp;&nbsp;&nbsp;&nbsp;</td><td> - Variance</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
 	 	<%}%>
 	<%}%> 		 
 	</tr>
</table>

<canvas id="myChart" width="1200" height="600"></canvas>

</BODY></HTML>
