<%@ page import=" operatorpanel.GetJobList"%>
<% GetJobList joblist = null;
   joblist = new GetJobList();
   int iEntNum = joblist.getEntNum();

   String [] sSubsys = new String[iEntNum];
   String [] sJobName = new String[iEntNum];
   String [] sUser = new String[iEntNum];
   String [] sJobNum = new String[iEntNum];
   String [] sType = new String[iEntNum];
   String [] sStatus = new String[iEntNum];
   String [] sFunction = new String[iEntNum];
   String [] sJobID = new String[iEntNum];

   for(int i = 0; i < iEntNum; i++){
       String s = Integer.toString(i+1);
       joblist.getSngJob(s);
       sSubsys[i] = joblist.getSubsystem();
       sJobName[i] = joblist.getJobName();
       sUser[i] = joblist.getUser();
       sJobNum[i] = joblist.getJobNum();
       sType[i] = joblist.getType();
       sStatus[i] = joblist.getStatus();
       sFunction[i] = joblist.getFunction();
       sJobID[i] = joblist.getJobID();
   }
   joblist.disconnect();
%>
      <html>
	 <head>
           <SCRIPT language="JavaScript">
		document.write("<style>body {background:ivory;}");
                document.write("a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}" );
                document.write("table.DataTable { background:#FFE4C4;border: darkred solid 1px;text-align:center;}");
                document.write("th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }");
                document.write("td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px; }");
		document.write("td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }");
                document.write("td.DataTable2 { background:cornsilk; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:left; font-family:Arial; font-size:10px }");
		document.write("</style>");
           </SCRIPT>
          </head>
         <body>

         <div id="tooltip2" style="position:absolute;visibility:hidden; background-attachment: scroll;
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
      <br>Work With Active Job</b>
      <br><a href="javascript:ShowSysStatus()">Display System Status</a></b>

      <table class="DataTable" cellPadding="1" cellSpacing="1" width="60%">
             <tr>
                  <th class="DataTable">Subsystem/Job Name</th>
                  <th class="DataTable">User</th>
                  <th class="DataTable">Job<br/>Number</th>
                  <th class="DataTable">Type</th>
                  <th class="DataTable">Status</th>
                  <th class="DataTable">Function</th>
             </tr>
           <% String sSvSubsys = sSubsys[1];
             for(int i = 0; i < iEntNum; i++) {%>
                <%if(!sSvSubsys.equals(sSubsys[i])){%>
               <tr>

                 <td class="DataTable2" colspan="6" ><%=sSubsys[i]%></td>
                 <%sSvSubsys = sSubsys[i];%>
               </tr>
                <%}
                else{%>
                <tr>
                 <td class="DataTable1">
                     <%if(sStatus[i].equals("MSGW")){%>
                     &nbsp;&nbsp;<a href="JobInfo.jsp?job=<%=sJobName[i]%>&user=<%=sUser[i]%>&num=<%=sJobNum[i]%>"><font color='red'> * <%=sJobName[i]%></font></a>
                     <%}
                     else {%>
                    &nbsp;&nbsp;&nbsp;<a href="JobInfo.jsp?job=<%=sJobName[i]%>&user=<%=sUser[i]%>&num=<%=sJobNum[i]%>"><%=sJobName[i]%></a><%}%></td>
                 <td class="DataTable1"><%=sUser[i]%></td>
                 <td class="DataTable1"><%=sJobNum[i]%></td>
                 <td class="DataTable1"><a href="javascript:showtip2()">
                        <%=sType[i]%></a></td>
                 <td class="DataTable1"><a href="javascript:showtip3()">
                        <%=sStatus[i]%></a></td>
                 <td class="DataTable1"><%=sFunction[i]%></td>
                </tr>
                <%}%>

           <%}%>
       </table>
              <form name="CONTINUE" method="POST" ACTION="searchcust.SrchCustPurchase">

          <p align="center">
             <input type="BUTTON" name="Back" value="Back" onClick="javascript:history.back()"></input>
          </p>
           <input type="HIDDEN" name="NXTRRN"></input>

        </form>
                   </td>
            </tr>
       </table>

        </body>
<SCRIPT>
function showtip2(){
   var text = "<table>" +
    "<CAPTION><font size='+1'><i><u>Job Types</u></i></font></CAPTION>" +
    "<tr><td>ASJ</td><td nowrap>&#160;&#160;&#160;&#160;Autostart</td></tr>" +
    "<tr><td>BCH</td><td nowrap>&#160;&#160;&#160;&#160;Batch</td></tr>" +
    "<tr><td>BCI</td><td nowrap>&#160;&#160;&#160;&#160;Batch immediate</td></tr>" +
    "<tr><td>EVK</td><td nowrap>&#160;&#160;&#160;&#160;Started by a program start request</td></tr>" +
    "<tr><td>INT</td><td nowrap>&#160;&#160;&#160;&#160;Interactive</td>"  +
    "<tr><td>M36</td><td nowrap>&#160;&#160;&#160;&#160;AS/400 Advanced 36 machine server</td></tr>"  +
    "<tr><td>MRT</td><td nowrap>&#160;&#160;&#160;&#160;Multiple requester terminal</td></tr>"  +
    "<tr><td>PJ</td><td nowrap>&#160;&#160;&#160;&#160;Prestart job</td></tr>"  +
    "<tr><td>PDJ</td><td nowrap>&#160;&#160;&#160;&#160;Print driver job</td></tr>"   +
    "<tr><td>RDR</td><td nowrap>&#160;&#160;&#160;&#160;Reader</td></tr>"   +
    "<tr><td>SYS</td><td nowrap>&#160;&#160;&#160;&#160;System</td></tr>"  +
    "<tr><td>SBS</td><td nowrap>&#160;&#160;&#160;&#160;Subsystem monitor</td></tr>"   +
    "<tr><td>blank</td><td nowrap>&#160;&#160;&#160;&#160;Alternative user subtype - not an active job</td></tr>"+
    "<tr><td colspan='2' align='center'><button onclick='hidetip2()'>Close</button></td></tr></table>"


    document.all.tooltip2.innerHTML=text
    document.all.tooltip2.style.pixelLeft=150
    document.all.tooltip2.style.pixelTop=document.documentElement.scrollTop+10
    document.all.tooltip2.style.visibility="visible"
}
function showtip3(){
   var text = "<table>" +
   "<CAPTION><font size='+1'><i><u>Active Status</u></i></font></CAPTION>" +
"<tr><td valign='top'>BSCA</td><td nowrap>Waiting in a pool activity level for the completion<br> of an I/O operation to a binary synchronous device.</td></tr>" +
"<tr><td valign='top'>BSCW</td><td>Waiting for the completion of an I/O operation to a binary synchronous device.</td></tr>" +
"<tr><td valign='top'>CLDW</td><td>Waiting for status information pertaining to one of its child processes.</td></tr>" +
"<tr><td valign='top'>CMNA</td><td>Waiting in a pool activity level for the completion     <br>of an I/O operation to a communications device.</td></tr>" +
"<tr><td valign='top'>CMNW</td><td>Waiting for the completion of an I/O operation to a communications device.</td></tr>" +
"<tr><td valign='top'>CMTW</td><td>Waiting for the completion of save-while-active checkpoint processing in another job.</td></tr>" +
"<tr><td valign='top'>CNDW</td><td>Waiting on handle-based condition.</td></tr>" +
"<tr><td valign='top'>CPCW</td><td>Jobs waiting for the completion of a CPI Communications call.</td></tr>" +
"<tr><td valign='top'>DEQA</td><td>Waiting in the pool activity level for completion of a dequeue operation.</td></tr>" +
"<tr><td valign='top'>DEQW</td><td>Waiting for completion of a dequeue operation. For example, QSYSARB and subsystem monitors generally wait for work  <br>by waiting for a dequeue operation.</td></tr>" +
"<tr><td valign='top'>DKTA</td><td>Waiting in a pool activity level for the completion of an I/O operation to a diskette unit.</td></tr>" +
"<tr><td valign='top'>DKTW</td><td>Waiting for the completion of an I/O operation to  <br>a diskette unit.</td></tr>" +
"<tr><td valign='top'>DLYW</td><td>The Delay Job (DLYJOB) command delays the job for  <br>a time interval to end, or for a specific delay end time. The function field shows either the number of seconds the job is to delay (999999), or the specific time when the job is to resume running.</td></tr>" +
"<tr><td valign='top'>DSC</td><td>Disconnected from a work station display.</td></tr>" +
"<tr><td valign='top'>DSPA</td><td>Waiting in a pool activity level for input from   <br>a work station display.</td></tr>" +
"<tr><td valign='top'>DSPW</td><td>Waiting for input from a work station display.</td></tr>" +
"<tr><td valign='top'>END</td><td>The job has been ended with the   <br>*IMMED option, or its delay time has ended with the *CNTRLD option.</td></tr>" +
"<tr><td valign='top'>EOFA</td><td>Waiting in the activity level to try a read   <br> operation again on a database file after the end-of-file has   <br>been reached.</td></tr>" +
"<tr><td>EOFW</td><td>Waiting to try a read operation again on a   <br>database file after the end-of-file has been reached.</td></tr>" +
"<tr><td>EOJ</td><td>Ending for a reason other than running the   <br>End Job (ENDJOB) or End Subsystem (ENDSBS) command, such as SIGNOFF, End Group Job (ENDGRPJOB), or an exception that is not handled.</td></tr>" +
"<tr><td>EVTW</td><td>Waiting for an event. For example, QLUS and   <br>SCPF generally wait for work by waiting for an event.</td></tr>" +
"<tr><td>GRP</td><td>Suspended by a Transfer Group Job (TFRGRPJOB)   <br>command.</td></tr>" +
"<tr><td>HLD</td><td>Held.</td></tr>" +
"<tr><td>HLDT</td><td>Held due to suspended thread.</td></tr>" +
"<tr><td>ICFA</td><td>Waiting in a pool activity level for the   <br>completion of an I/O operation to an intersystem communications   <br>function file.</td></tr>" +
"<tr><td>ICFW</td><td>Waiting for the completion of an I/O operation to   <br> an intersystem communications function file.</td></tr>" +
"<tr><td>INEL</td><td>Ineligible and not currently in the pool   <br>activity level.</td></tr>" +
"<tr><td>JVAA</td><td>Waiting in a pool activity level for a Java   <br>program operation to complete.</td></tr>" +
"<tr><td>JVAW</td><td>Waiting for a Java program operation to complete.</td></tr>" +
"<tr><td>LCKW</td><td>Waiting for a lock.</td></tr>" +
"<tr><td>MLTA</td><td>Waiting in a pool activity level for the   <br>completion of an I/O operation to multiple files.</td></tr>" +
"<tr><td>MLTW</td><td>Waiting for the completion of an I/O   <br>operation to multiple files.</td></tr>" +
"<tr><td>MSGW</td><td>Waiting for a message from a message queue.</td></tr>" +
"<tr><td>MTXW</td><td>Waiting for access to shared data.</td></tr>" +
"<tr><td>MXDW</td><td>Waiting for the completion of an I/O operation   <br>to a mixed device file.</td></tr>" +
"<tr><td>OPTA</td><td>Waiting in a pool activity level for the   <br>completion of an I/O operation to an optical device.</td></tr>" +
"<tr><td>OPTW</td><td>Waiting for the completion of an I/O operation   <br> to an optical device.</td></tr>" +
"<tr><td>OSIW</td><td>Jobs waiting for the completion of an OSI   <br>Communications Subsystem for OS/400 operation.</td></tr>" +
"<tr><td>PRTA</td><td>Waiting in a pool activity level for   <br>output to a printer to complete.</td></tr>" +
"<tr><td>PRTW</td><td>Waiting for output to a printer to be completed.</td></tr>" +
"<tr><td>PSRW</td><td>A prestart job waiting for a program   <br>start request.</td></tr>" +
"<tr><td>RUN</td><td>Currently running in the pool activity level.</td></tr>" +
"<tr><td>SELW</td><td>Waiting for a selection to complete.</td></tr>" +
"<tr><td>SIGS</td><td>Stopped as the result of a signal.</td></tr>" +
"<tr><td>SIGW</td><td>Waiting for a signal.</td></tr>" +
"<tr><td>SRQ</td><td>The suspended half of a system request job   <br> pair.</td></tr>" +
"<tr><td>SVFA</td><td>Waiting in a pool activity level for   <br>completion of a save file operation.</td></tr>" +
"<tr><td>SVFW</td><td>Waiting for completion of a save file operation.</td></tr>" +
"<tr><td>TAPA</td><td>The job is waiting in a pool activity   <br>level for completion of an I/O operation to a tape device.</td></tr>" +
"<tr><td>TAPW</td><td>Waiting for completion of an I/O operation   <br> to a tape device.</td></tr>" +
"<tr><td>THDW</td><td>Waiting for a thread.</td></tr>" +
"<tr><td>TIMA</td><td>Waiting in a pool activity level for a time   <br> interval to end.</td></tr>" +
"<tr><td>TIMW</td><td>Waiting for a time interval to end.</td></tr>" +
"<tr><td colspan='2' align='center'><button onclick='hidetip2()'>Close</button></td></tr></table>"

    document.all.tooltip2.innerHTML=text
    document.all.tooltip2.style.pixelLeft=150
    document.all.tooltip2.style.pixelTop=document.documentElement.scrollTop+10
    document.all.tooltip2.style.visibility="visible"
}
function hidetip2(){
    document.all.tooltip2.style.visibility="hidden"
}

function ShowSysStatus() {
  window.open("SysStatistics.jsp", "sysstatus", "fullscreen=no,toolbar=no,status=yes, menubar=no,scrollbars=yes,resizable=no,directories=no,location=no,width=250,height=250,left=100,top=10")
}

</SCRIPT>
      </html>
