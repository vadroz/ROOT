<%@ page import="java.text.*, java.util.*, java.sql.ResultSet"%>
<%
    String sDays = request.getParameter("Days");
    String sFrDate = null;
    String sToDate = null;
    if(sDays==null){ sDays="0"; }

    Date currDate = new Date();
    currDate.setTime(currDate.getTime() + 10 * 60 * 60) ;
    SimpleDateFormat smpYmd = new SimpleDateFormat("yyyy-MM-dd");

    if (sFrDate == null)
    {
       Date lastDate = currDate;
       for(int i=0;i < Integer.parseInt(sDays); i++)
       {
           lastDate.setTime(lastDate.getTime() - (60 * 60 * 24 * 1000));
       }
       sFrDate = smpYmd.format(lastDate);
       sToDate = smpYmd.format(lastDate);
    }

    System.out.println("Start ECOM_Headcount.jsp."
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
  <title>ECOM Headcount</title>
</head>
<script language="javascript">
// =============================================================================
//  Global variables
// =============================================================================
 // required date
 var FrDate = "<%=sFrDate%>";
 var ToDate = "<%=sToDate%>";
 var Days = eval("<%=sDays%>");

 var Amount = new Array();
 var Visits = new Array();
</script>


<body>
<!-------------------------------------------------------------------->
<iframe id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
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

<script language="javascript">
setTimeout(function(){
      Days++;
      var url = "Ecom_Headcount_Mult.jsp?Days=" + Days
      window.location = url;
   }
   , 10000);
</script>

</html>




