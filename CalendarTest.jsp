<%@ page import="java.util.*, fusioncharts.FusionCharts"%>
<%
%>

<script name="javascript">
//==============================================================================
// run on loading
//==============================================================================
function bodyLoad()
{
}
</script>

<script LANGUAGE="JavaScript1.2" src="Calendar1.js"></script>

<HTML><HEAD><meta http-equiv="refresh">

</HEAD>
<BODY onload="bodyLoad();">


<div id="chart"></div>
<!--
This is a simple example on how to draw a chart using FusionCharts and JSP.
We have included fusioncharts.FusionCharts, which contains functions
to help us easily embed the charts.
--> 

<--        
Create the chart - Column 2D Chart with data given in constructor parameter 
Syntax for the constructor -
	new FusionCharts("type of chart", 
		"unique chart id", 
		"width of chart", 
		"height of chart", 
		"div id to render the chart", 
		"type of data", 
		"actual data in string format")
-->
<%
FusionCharts column2DChart= new FusionCharts(
	"column2d",// chartType
	"chart1",// chartId
	"600", //   chartWidth
	"400",//    chartHeight
	"chart",//  chartContainer
	"json",//   dataFormat
	"{\"chart\": {\"caption\": \"Harry\'s SuperMart\",\"subCaption\": \"Top 5 stores in last month by revenue\",\"numberPrefix\": \"$\",\"theme\": \"ocean\"},\"data\": [{\"label\": \"Bakersfield Central\",\"value\": \"880000\"}, {\"label\": \"Garden Groove harbour\",\"value\": \"730000\"}, {\"label\": \"Los Angeles Topanga\",\"value\": \"590000\"}, {\"label\": \"Compton-Rancho Dom\",\"value\": \"520000\"}, {\"label\": \"Daly City Serramonte\",\"value\": \"330000\"}]}"
);
%>
<!--            
Render the chart
-->
<%=column2DChart.render()%>





<TABLE height="100%" width="100%" border=0>
        <TR>
            <TD class="Cell" >Date:</TD>
            <TD class="Cell1" nowrap>
              <button class="Small" name="Down" onClick="setDate('DOWN', 'WkendDt')">&#60;</button>
              <input class="Small" name="WkendDt" type="text" size=10 maxlength=10 readOnly>&nbsp;
              <button class="Small" name="Up" onClick="setDate('UP', 'WkendDt')">&#62;</button>&nbsp;&nbsp;&nbsp;
              <a href="javascript:showCalendar(1, null, null, 550, 220, document.all.WkendDt)" >
              <img src="calendar.gif" alt="Calendar Prompt" width="34" height="21"></a>
              <input type="hidden" name="WkendDtSv">&nbsp;
            </TD>
          </TR>        
   </TABLE>
</BODY></HTML>