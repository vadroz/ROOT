<%@ page import="java.text.*, java.util.*, java.sql.ResultSet"%>
<%
    String sFrDate = request.getParameter("From");
    String sToDate = request.getParameter("To");

    Date currDate = new Date();
    SimpleDateFormat smpYmd = new SimpleDateFormat("yyyy-MM-dd");

    if (sFrDate == null)
    {
       Date lastDate = new Date(currDate.getTime() - (60 * 60 * 24 * 1000));
       sFrDate = smpYmd.format(lastDate);
       sToDate = smpYmd.format(currDate);
    }

    
    // next refesh time in 30 minutes in day time or 8 hours after 10pm
    long lRefreshTime = 60 * 60 * 2;
    SimpleDateFormat smpHrs = new SimpleDateFormat("HH");
    if( Integer.parseInt(smpHrs.format(currDate)) >= 22) { lRefreshTime = 8 * 60 * 60; }

    Date nxtDate = new Date(currDate.getTime() + lRefreshTime * 1000);
    SimpleDateFormat smpDaTi = new SimpleDateFormat("MM-dd-yyyy HH:mm");
    String nextRefresh = smpDaTi.format(nxtDate);

 %>
<html>
<head>
  <title>ECOM Headcount</title>
</head>
<META HTTP-EQUIV=Refresh CONTENT='<%=lRefreshTime%>;'>


<script language="javascript">
// =============================================================================
//  Global variables
// =============================================================================
 // required date
 var FrDate = "<%=sFrDate%>";
 var ToDate = "<%=sToDate%>";

 var Amount = new Array();
 var Visits = new Array();
</script>


<body>
<!-------------------------------------------------------------------->
<iframe id="frame1" src="" height="200" width="100%"></iframe>
<!-------------------------------------------------------------------->

<h1>ECOM Headcount</h1>
<b>From:</b> <%=sFrDate%> <b>To:</b> <%=sToDate%>
<br><b>Last Update:</b> <%=currDate%>
&nbsp; &nbsp; &nbsp; &nbsp;
<b>Next Update:</b> <%=nextRefresh%>

<hr>

<button id="authorize-button" style="visibility: hidden">Authorize</button>

<div id="dvStatus">&nbsp;</div>
<br>
<hr>
<div id="output">Loading, one sec....</div>

<script src="scripts/da_auth.js"></script>
<script src="scripts/ga_query_visitors.js"></script>
<script src="https://apis.google.com/js/client.js?onload=handleClientLoad"></script>

</body>
</html>




