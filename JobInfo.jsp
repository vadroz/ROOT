<%@ page import=" operatorpanel.GetJobInfo"%>
<% GetJobInfo jobinfo = new GetJobInfo();
   String sJobName = request.getParameter("job");
   String sUser = request.getParameter("user");
   String sJobNum = request.getParameter("num");
   String sSubsys = null;
   String sRunPty = null;
   String sStatus = null;
   String sJobQue = null;
   String sJobQueLib = null;
   String sJobQuePty = null;
   String sOutQue = null;
   String sOutQueLib = null;
   String sOutQuePty = null;
   String sPrinter = null;
   String sSbmJobName = null;
   String sSbmJobUser = null;
   String sSbmJobNum = null;
   String sSbmMsgQue = null;
   String sSbmMsgQL = null;
   String sJobStsOnJobQueue = null;
   String sJobDate = null;
   String sEndSvty = null;
   String sLogSvty = null;
   String sLogLevel = null;
   String sLogText = null;

   jobinfo.getJInfo(sJobName, sUser, sJobNum);
   boolean bNotFounf = jobinfo.isJobFound();
   if(!bNotFounf){
     sSubsys = jobinfo.getSubsystem();
     sRunPty = jobinfo.getRunPty();
     sStatus = jobinfo.getStatus();
     sJobQue = jobinfo.getJobQue();
     sJobQueLib = jobinfo.getJobQueLib();
     sJobQuePty = jobinfo.getJobQuePty();
     sOutQue = jobinfo.getOutQue();
     sOutQueLib = jobinfo.getOutQueLib();
     sOutQuePty = jobinfo.getOutQuePty();
     sPrinter = jobinfo.getPrinter();
     sSbmJobName = jobinfo.getSbmJobName();
     sSbmJobUser = jobinfo.getSbmUser();
     sSbmJobNum = jobinfo.getSbmJobNum();
     sSbmMsgQue = jobinfo.getSbmMsgQ();
     sSbmMsgQL = jobinfo.getSbmMsgQL();
     sJobStsOnJobQueue = jobinfo.getJobStsOnJobQueue();
     sJobDate = jobinfo.getJobDate();
     sEndSvty = jobinfo.getEndSvty();
     sLogSvty = jobinfo.getLogSvty();
     sLogLevel = jobinfo.getLogLevl();
     sLogText = jobinfo.getLogText();
   }
   jobinfo.disconnect();
%>
<html>
 <head>
           <SCRIPT language="JavaScript">
		document.write("<style>body {background:ivory;}");
                document.write("a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}" );
                document.write("table.DataTable { color:MediumSpringGreen; background:black; border: darkred solid 1px;text-align:left; font-family:Courier; font-size:10px}");
                document.write("th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }");
                document.write("td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px; }");
		document.write("td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }");
                document.write("td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }");
		document.write("</style>");
           </SCRIPT>
 </head>
 <body>

         <div id="tooltip2" style="position:absolute;visibility:hidden;
              border: black solid 1px; width:150px;background-color:LemonChiffon; z-index:10"></div>
         <div align="CENTER" name="divTest" onMouseover="showtip2(this,event,' ');" onMouseout="hidetip2();" STYLE="cursor: hand">
         </div>

   <table border="0" width="100%" height="100%">
            <tr>
            <td height="20%" COLSPAN="2">
              <img src="Sun_ski_logo4.png" /></td>
             </tr>
             <tr bgColor="moccasin">
             <td  VALIGN="TOP" WIDTH="15%" bgColor="A7B5E8">
    <font color="#445193" size="2" face="Arial">
    &#160;&#160;<a class="blue" href="../">Home</a>
    </font>
    <font color="#445193" size="1" face="Arial">
    <h5>&#160;&#160;Miscellaneous</h5>
    &#160;&#160;<a class="blue" href="MAILTO:helpdesk@retailconcepts.cc">Mail to IT</a>
    <br/>&#160;&#160;<a class="blue" href="http://sunandski.com/">Our Internet</a>
    <br/>
    </font></td>
      <td ALIGN="center" VALIGN="TOP">
      <b>Retail Concepts, Inc
      <br>Operator's Panel
      <br>Display Job Information</b>
      <br><a href="JobLog.jsp?job=<%=sJobName%>&user=<%=sUser%>&num=<%=sJobNum%>">Display Job Log</a>
      <br><a href="JobLibList.jsp?job=<%=sJobName%>&user=<%=sUser%>&num=<%=sJobNum%>">Display Library List</a>

      <table class="DataTable" wide="100%">
      <tr><th colspan="2" align="center">Job Name: <%=sJobName%>&#160;&#160;&#160;&#160;&#160;&#160;
                      User: <%=sUser%>&#160;&#160;&#160;&#160;&#160;&#160;
                      Number: <%=sJobNum%></th></tr>
     <%if(!bNotFounf){%>
       <tr><td>Run Priority <%for(int i=0;i<25;i++){%> .<%}%></td><td><%=sRunPty%></td></tr>
           <td>Subsystem&#160;<%for(int i=0;i<26;i++){%> .<%}%></td><td><%=sSubsys%></td></tr>
           <td>Job Status<%for(int i=0;i<26;i++){%> .<%}%></td><td><%=sStatus%></td></tr>
           <%if(!sJobQue.equals("          ")){%>
              <td>Job Queue&#160;<%for(int i=0;i<26;i++){%> .<%}%></td><td><%=sJobQue%></td></tr>
              <td>&#160;&#160;&#160;&#160;Library&#160;<%for(int i=0;i<25;i++){%> .<%}%></td><td>&#160;&#160;&#160;&#160;<%=sJobQueLib%></td></tr>
              <td>Job priority on job queue&#160;<%for(int i=0;i<18;i++){%> .<%}%></td><td><%=sJobQue%></td></tr>
           <%}%>
           <td>Output Queue<%for(int i=0;i<25;i++){%> .<%}%></td><td><%=sOutQue%></td></tr>
           <td>&#160;&#160;&#160;&#160;Library&#160;<%for(int i=0;i<25;i++){%> .<%}%></td><td>&#160;&#160;&#160;&#160;<%=sOutQueLib%></td></tr>
           <td>Output queue priority&#160;<%for(int i=0; i < 20; i++){%> .<%}%></td><td><%=sOutQuePty%></td></tr>
           <td>Printer&#160;<%for(int i=0;i<27;i++){%> .<%}%></td><td><%=sPrinter%></td></tr>
           <td>Log Level&#160;<%for(int i=0;i<26;i++){%> .<%}%></td><td><%=sLogLevel%></td></tr>
           <td>Log Severity<%for(int i=0;i<25;i++){%> .<%}%></td><td><%=sLogSvty%></td></tr>
           <td>Log Text<%for(int i=0;i<27;i++){%> .<%}%></td><td><%=sLogText%></td></tr>
           <%if(!sSbmJobName.equals("          ")){%>
              <td>Submitter's Job Name<%for(int i=0;i<21;i++){%> .<%}%></td><td><%=sSbmJobName%></td></tr>
              <td>Submitter's User Name&#160;<%for(int i=0;i<20;i++){%> .<%}%></td><td><%=sSbmJobUser%></td></tr>
              <td>Submitter's Job Number<%for(int i=0;i<20;i++){%> .<%}%></td><td><%=sSbmJobNum%></td></tr>
           <%}%>
           <%if(!sSbmMsgQue.equals("          ")){%>
              <td>Submitter's Message Queue&#160;<%for(int i=0;i<18;i++){%> .<%}%></td><td><%=sSbmMsgQue%></td></tr>
              <td>&#160;&#160;&#160;&#160;Library&#160;<%for(int i=0;i<25;i++){%> .<%}%></td><td>&#160;&#160;&#160;&#160;<%=sSbmMsgQL%></td></tr>
           <%}%>
           <%if(!sJobStsOnJobQueue.equals("          ")){%>
              <td>Job status on job queue&#160;<%for(int i=0;i<19;i++){%> .<%}%></td><td><%=sJobStsOnJobQueue%></td></tr>
           <%}%>
           <td>Job Date<%for(int i=0;i<27;i++){%> .<%}%></td><td><%=sJobDate%></td></tr>
        <%}

        else{%>
         <tr><td colspan="2" align="center">This job is not found on system</td></tr>
        <%}%>
      </table>

        <form name="CONTINUE" method="POST" ACTION="searchcust.SrchCustPurchase">
           <p align="center"><input type="BUTTON" name="Back" value="Back" onClick="javascript:history.back()"></input>
           <input type="HIDDEN" name="NXTRRN"></input>
        </form>
       </td>
     </tr>
  </table>

 </body>
<SCRIPT>
function hidetip2(){
    document.all.tooltip2.style.visibility="hidden"
}
        </SCRIPT>
      </html>
