<%@ page import="salesreport.SlsRepJobMon"%>
<%
   String sSelUsr = request.getParameter("User");
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")==null)
   {
     response.sendRedirect("SignOn1.jsp?TARGET=SlsRepJobMon.jsp&APPL=ALL");
   }
   else
   {
	  String sUser = session.getAttribute("USER").toString();
	  if( sSelUsr == null){sSelUsr = sUser; } 

      SlsRepJobMon jobmon = new SlsRepJobMon( sSelUsr );
      int iNumOfRep = jobmon.getNumOfRep();
      
      jobmon.setUserList();
      int iNumOfUsr = jobmon.getNumOfUsr();
      String [] sUsrLst = jobmon.getUsrLst();
      String sUsrLstJsa = jobmon.getUsrLstJsa();      
%>

<html>
<head>

<style>body {background:ivory; text-align:center;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:darkred;text-align:center;}
        table.DataTable1 { border: darkred solid 1px;background:Cornsilk;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }

        tr.DataTable { background:cornsilk; font-family:Arial; font-size:10px }
        tr.DataTable1 { background:#e7e7e7; font-family:Arial; font-size:10px }

        td.DataTable { border-right: darkred solid 1px; border-bottom: darkred solid 1px;
                       padding-top:3px; padding-bottom:3px; padding-left:3px; padding-right:3px;
                       text-align:left;}
        div.dvFrmTy { position:absolute; background-attachment: scroll;
              border: black solid 2px; width:250; background-color: white; z-index:10;
              text-align:center; font-size:10px}
        .Small {font-size:10px;}
        <!--------------------------------------------------------------------->
</style>




<SCRIPT language="JavaScript1.2">
//--------------- Global variables -----------------------
var User = "<%=sUser%>";
var ArrUsr = [<%=sUsrLstJsa%>];
//--------------- End of Global variables ----------------
//==============================================================================
// initialize process
//==============================================================================
function bodyLoad()
{
	setUserList();
}
//==============================================================================
// set user list
//==============================================================================
function setUserList()
{	
	var html = "<select name='selUser'></select>&nbsp;"
	 + "<button onclick='sbmRep()'>Submit</button>"  
	document.all.dvFrmTy.innerHTML = html;
	document.all.dvFrmTy.style.pixelLeft=document.documentElement.scrollLeft + 10;
	document.all.dvFrmTy.style.pixelTop=document.documentElement.scrollTop + 10;
	 
	for(var i=0; i < ArrUsr.length; i++)
	{
		document.all.selUser.options[i] = new Option(ArrUsr[i], ArrUsr[i]);
	}
	
}
//==============================================================================
// submit report
//==============================================================================
function sbmRep()
{
	var user = document.all.selUser.options[document.all.selUser.selectedIndex].value
	var url = "SlsRepJobMon.jsp?User=" + user;
	window.location.href=url;
}
//==============================================================================
// delete File
//==============================================================================
function dltFile(file, i)
{
   var url = "SlsRepJobDlt.jsp?"
           + "File=" + file
           + "&Action=DLTFILE"
   //alert(url)
   //window.location.href = url;
   window.frame1.location.href = url;

   var id = "File" + i
   document.all[id].innerHTML = "";
   id = "Delete" + i
   document.all[id].innerHTML = "";
}

//==============================================================================
// delete Job
//==============================================================================
function dltJob(job, jobuser, jobnum)
{
   var url = "SlsRepJobDlt.jsp?"
     + "Job=" + job
     + "&JobUser=" + jobuser
     + "&JobNum=" + jobnum
     + "&Action=STOPJOB"

   //alert(url)
   //window.location.href = url;
   window.frame1.location.href = url;
}


//==============================================================================
// close frame after file deleteion
//==============================================================================
function closeFrame()
{
  window.frame1.close();
  window.location.reload()();
}
//==============================================================================
// open document in new window
//==============================================================================
function openDoc(file)
{
   window.location.href=file;
}
</SCRIPT>

<script LANGUAGE="JavaScript1.2" src="String_Trim_function.js"></script>
<script LANGUAGE="JavaScript1.2" src="String_Repalce_Spec_Char_function.js"></script>

</head>
<body onload="bodyLoad()">
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvFrmTy" class="dvFrmTy"></div>
<!-------------------------------------------------------------------->

    <table border="0" cellPadding="0"  cellSpacing="0">
     <tr>
      <td ALIGN="center" VALIGN="TOP"nowrap>
        <b>Retail Concepts, Inc
        <br>Report Monitor
        </b>
      </td>
    </tr>

    <tr>
      <td ALIGN="center" VALIGN="TOP">
      <a href="index.jsp"><font color="red" size="-1">Home</font></a>&#62;<font size="-1">This Page</font>
  <!----------------------- Order List ------------------------------>
     <table class="DataTable" cellPadding="0" width="100%" cellSpacing="0" id="tbDetail">
       <tr  class="DataTable">
         <th class="DataTable" nowrap>Program</th>
         <th class="DataTable" nowrap>Report Name</th>
         <th class="DataTable" nowrap>User</th>
         <th class="DataTable" nowrap>Date</th>
         <th class="DataTable" nowrap>Time</th>
         <th class="DataTable" nowrap>Status</th>
         <th class="DataTable" nowrap>File</th>
         <th class="DataTable" nowrap>Comment</th>
         <th class="DataTable" nowrap>Delete<br>File</th>
         <th class="DataTable" nowrap>Stop<br>Job</th>
      </tr>
      <TBODY>

      <!----------------------- Order List ------------------------>
      <%for(int i=0; i < iNumOfRep; i++)
        {
          jobmon.setJobMon();
          String sPgm = jobmon.getPgm();
          String sRepNm = jobmon.getRepNm();
          String sSbmUser = jobmon.getUser();
          String sDate = jobmon.getDate();
          String sTime = jobmon.getTime();
          String sSts = jobmon.getSts();
          String sFile = jobmon.getFile();
          String sComment = jobmon.getComment();
          String sJob = jobmon.getJob();
          String sJobUser = jobmon.getJobUser();
          String sJobNum = jobmon.getJobNum();
      %>

            <tr class="DataTable">
              <td class="DataTable"><%=sPgm%></td>
              <td class="DataTable"><%=sRepNm%></td>
              <td class="DataTable"><%=sSbmUser%></td>
              <td class="DataTable"><%=sDate%></td>
              <td class="DataTable"><%=sTime%></td>
              <td class="DataTable"><%=sSts%></td>
              <td class="DataTable" id="File<%=i%>"><%if(sFile.trim().length() > 0){%><a href="javascript: openDoc('<%=sFile%>')">Download</a><%}%></td>
              <td class="DataTable"><%=sComment%></td>
              <td class="DataTable" id="Delete<%=i%>"><%if(! sSts.trim().equals("Running")){%><a href="javascript: dltFile('<%=sFile%>', '<%=i%>')">Delete</a><%}%></td>
              <td class="DataTable" id="Stop<%=i%>"><%if(sSts.trim().equals("Submit") || sSts.trim().equals("Running")){%><a href="javascript: dltJob('<%=sJob%>', '<%=sJobUser%>', '<%=sJobNum%>')">Stop</a><%}%></td>
           </tr>
      <%}%>
      <!---------------------------------------------------------------------->
      </TBODY>
    </table>
  <!----------------------- end of table ------------------------>
     </td>
   </tr>

  </table>
 </body>
</html>
<%
  jobmon.disconnect();
  jobmon = null;
%>
<%}%>