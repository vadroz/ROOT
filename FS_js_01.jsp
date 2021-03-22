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

    System.out.println("Start Kiosk_Sls_by_js.jsp."
       + "\nDates: " + sFrDate + " - " + sToDate
    );

    // next refesh time in 30 minutes in day time or 8 hours after 10pm
    long lRefreshTime = 1800;
    SimpleDateFormat smpHrs = new SimpleDateFormat("HH");
    if( Integer.parseInt(smpHrs.format(currDate)) >= 22) { lRefreshTime = 8 * 60 * 60; }

    Date nxtDate = new Date(currDate.getTime() + lRefreshTime * 1000);
    SimpleDateFormat smpDaTi = new SimpleDateFormat("MM-dd-yyyy HH:mm");
    String nextRefresh = smpDaTi.format(nxtDate);

 %>
<html>
<head>
  <title>Kiosk Sales Receiving</title>
</head>
<META HTTP-EQUIV=Refresh CONTENT='<%=lRefreshTime%>;'>


<script language="javascript">
// =============================================================================
//  Global variables
// =============================================================================
 // required date
 var FrDate = "<%=sFrDate%>";
 var ToDate = "<%=sToDate%>";

 var EmpNum = new Array();
 var Store = new Array();
 var Order = new Array();
 var Amount = new Array();
 var Trans = new Array();
</script>


<body>
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->

<h1>FluidSurvey</h1>
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

<script src="scripts/fs_auth.js"></script>
<script src="scripts/fs_query.js"></script>

<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

</body>
</html>
