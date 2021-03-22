<%@ page import="java.io.File, java.util.*, java.text.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null || session.getAttribute("ECOMDWNL")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=EComDwnLst.jsp");
}
else
{
   String sPath = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT/ECommerce";
   //String sPath = "/var/tomcat4/webapps/ROOT/ECommerce";

   File dir = new File(sPath);
   File[] ecdownl = dir.listFiles();
   java.util.Arrays.sort(ecdownl);


   SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm");
   Calendar cal = Calendar.getInstance();
%>
<HTML>
<HEAD>
<title>E-Commerce_Dowload_Files</title>
<META content="RCI, Inc." name="E-Commerce_Dowload_Files"></HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Verdanda; font-size:12px }

   div.dvSbmSts { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
</style>


<script name="javascript1.2">
var JobId = null;
var Status = null;
//==============================================================================
// download files with new and update items for Volusion
//==============================================================================
function downloadFiles(action)
{
   JobId = null;
   var url = "ECommSbmDwnl.jsp?User=<%=session.getAttribute("USER").toString()%>"
           + "&Action=" + action;
   //alert(url)
   //window.location.href=url;
   window.frame1.location.href=url;

   document.all.btnDown[0].style.display="none";
   document.all.btnDown[1].style.display="none";

   var html = "<br><marquee SCROLLAMOUNT=5 SCROLLDELAY=100 BEHAVIOR=ALTERNATE>"
     + "<span id='spSts' style='color:red; font-size:14px'>File download job have been submitted. Wait please!!!</span>"
   + "</marquee><br><br>"

   document.all.dvSbmSts.innerHTML = html;
   document.all.dvSbmSts.style.pixelLeft= document.documentElement.scrollLeft + 300;
   document.all.dvSbmSts.style.pixelTop= document.documentElement.scrollTop + 100;
   document.all.dvSbmSts.style.visibility = "visible";
}
//==============================================================================
// set submited job ID
//==============================================================================
function setJobId(job)
{
   JobId = job;
   window.frame1.close();
   //getJobStatus();
   setTimeout("getJobStatus()", 3000);
}
//==============================================================================
// get submited job status
//==============================================================================
function getJobStatus()
{
   var url = "ECommSbmDwnl.jsp?User=<%=session.getAttribute("USER").toString()%>"
           + "&Action=CHKJOBSTS"
           + "&JobId=" + JobId;
   window.frame1.location.href=url;
}
//==============================================================================
// get submited job ID
//==============================================================================
function showStatus(sts)
{
   if(sts == "RUN" || sts == "JOBQ")  { setTimeout("getJobStatus()", 3000); }
   else
   {
      if(sts == "ERROR") { alert("Download process return ERROR.\nPlease contact IT department."); }
      window.location.reload()
   }
}
//==============================================================================
// delete file
//==============================================================================
function dltFile(file)
{
   var url = "ECommDltDwnl.jsp?File=" + file;
   //alert(url)
   //window.location.href=url;
   window.frame1.location.href=url;
}
//==============================================================================
// re-start page
//==============================================================================
function restart()
{
  window.location.reload();
}
</script>

<BODY>
<!-------------------------------------------------------------------->
<iframe  id="frame1"  src=""  frameborder=0 height="0" width="0"></iframe>
<!-------------------------------------------------------------------->
<div id="dvSbmSts" class="dvSbmSts"></div>
<!-------------------------------------------------------------------->


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD vAlign=top align=middle colspan=4><B>Retail Concepts Inc.
        <BR>E-Commerce Downloading Files
        </B><br>
        <a href="../"><font color="red">Home</font></a>
  <TR>
    <TD vAlign=top align=middle>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSaS">
         <tr class="DataTable"><th class="DataTable" colspan=3>Sun and Ski Sport Site</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time<br>Modified</th>
           <th class="DataTable">Delete</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("SaS") > 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table>
   <!-- ======================================================================= -->
    <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSCh">
         <tr class="DataTable" ><th class="DataTable" colspan=3>Ski Chalet Site</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time<br>Modified</th>
           <th class="DataTable">Delete</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("SCh") > 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table><br>

     <!-- ======================================================================= -->
    <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSStp">
         <tr class="DataTable" ><th class="DataTable" colspan=3>Ski Stop Site</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time<br>Modified</th>
           <th class="DataTable">Delete</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("Stp") > 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table><br>
    <!-- ====================== Railhead Board Sport ======================= -->
    <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSCh">
         <tr class="DataTable" ><th class="DataTable" colspan=3>Railhead Board Sport</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time<br>Modified</th>
           <th class="DataTable">Delete</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("Rbl") > 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table><br>

<!-- ========================= Joe Johnes ============================= -->
    <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSCh">
         <tr class="DataTable" ><th class="DataTable" colspan=3>Joe Johnes</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time<br>Modified</th>
           <th class="DataTable">Delete</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("JoJo") > 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table><br>

    <!-- ======================= Shopzilla.com ================================================ -->
    <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSCh">
         <tr class="DataTable" ><th class="DataTable" colspan=3>Shopzilla.com</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time<br>Modified</th>
           <th class="DataTable">Delete</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("ShpZila") > 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table>
    </td>
  </tr>
  <!-- ======================= Froogle.com for Sun and ski ============================ -->
  <tr>
    <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSCh">
         <tr class="DataTable" ><th class="DataTable" colspan=3>Froogle for Sun and Ski Sports</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time<br>Modified</th>
           <th class="DataTable">Delete</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("FrooSS") > 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table>
    <!-- ======================= Froogle.com for Ski chalet ============================ -->
    <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSCh">
         <tr class="DataTable" ><th class="DataTable" colspan=3>Froogle for Ski Chalet</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time<br>Modified</th>
           <th class="DataTable">Delete</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("FrooSC") > 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table><br>
    </td>
       <!-- ======================= Froogle.com for RailheadBoardSport.com ============================ -->
    <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSCh">
         <tr class="DataTable" ><th class="DataTable" colspan=3>Froogle for Railhead Board Sports</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time<br>Modified</th>
           <th class="DataTable">Delete</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("FrooRbs") > 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table>
    </td>


       <!-- ======================= Froogle.com for Joe Jonhes.com ============================ -->
    <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbTcr">
         <tr class="DataTable" ><th class="DataTable" colspan=3>Froogle for Joe Jonhes</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time<br>Modified</th>
           <th class="DataTable">Delete</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("FrooTJj") > 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table>
    </td>


   </tr>

    <!-- ======================= ShareASale.com fo Sun And Ski ================================================ -->
   <tr>
    <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSCh">
         <tr class="DataTable" ><th class="DataTable" colspan=3>Shareasale for Sun and Ski Sports</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time<br>Modified</th>
           <th class="DataTable">Delete</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("ShrASaleSS") > 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table>
     <!-- ======================= ShareASale.com for Ski Chalet=================================== -->
    <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSCh">
         <tr class="DataTable" ><th class="DataTable" colspan=3>Shareasale for Ski Chalet</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time<br>Modified</th>
           <th class="DataTable">Delete</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("ShrASaleSC") > 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table>
   <!-- ================ ShareASale.com for Railhead Board Sport ============== -->
    <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSCh">
         <tr class="DataTable" ><th class="DataTable" colspan=3>Shareasale for Railhead Board Sport</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time<br>Modified</th>
           <th class="DataTable">Delete</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("ShrASaleRb") > 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table>
     </td>

    <!-- ================ ShareASale.com for Joe Johnes ============== -->
    <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSCh">
         <tr class="DataTable" ><th class="DataTable" colspan=3>Shareasale for Joe Johnes</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time<br>Modified</th>
           <th class="DataTable">Delete</th>
         </tr>
       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("ShrASaleJj") > 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table>
     </td>



      <!-- ======================= PriceGrabber fo Sun And Ski ================================================ -->
   <tr>
    <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSCh">
         <tr class="DataTable" ><th class="DataTable" colspan=3>PriceGrabber for Sun and Ski Sports</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time<br>Modified</th>
           <th class="DataTable">Delete</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("GrabberSS") > 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table>
     <!-- ======================= PriceGrabber.com for Ski Chalet=================================== -->
    <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSCh">
         <tr class="DataTable" ><th class="DataTable" colspan=3>PriceGrabber for Ski Chalet</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time Modified</th>
           <th class="DataTable">Delete</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("GrabberSC") > 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table>
   <!-- ================ PriceGrabber.com for Railhead Board Sport ============== -->
    <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSCh">
         <tr class="DataTable" ><th class="DataTable" colspan=3>PriceGrabber for Railhead Board Sport</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time Modified</th>
           <th class="DataTable">Delete</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("GrabberRb") > 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table>
     </td>
    <!-- ================ PriceGrabber.com for Joe Johnes ============== -->
    <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSCh">
         <tr class="DataTable" ><th class="DataTable" colspan=3>PriceGrabber for Joe Johnes</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time Modified</th>
           <th class="DataTable">Delete</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("GrabberJj") > 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table>
     </td>




<!-- ======================================================================= -->
      </TD>
     </TR>

   <!-- ======================= Kit Link Price Diffirence ================================================ -->
   <tr>
    <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSCh">
         <tr class="DataTable" >
           <th class="DataTable" colspan=3>Kit Link Price Diffirence<br>Sun & Ski Sports</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time<br>Modified</th>
           <th class="DataTable">Delete</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("PrcDiffSS") >= 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table>
     </td>
     <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSCh">
         <tr class="DataTable" >
           <th class="DataTable" colspan=3>Kit Link Price Diffirence<br>Ski Chalet</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time<br>Modified</th>
           <th class="DataTable">Delete</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("PrcDiffSC") >= 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table>
     </td>


     <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSCh">
         <tr class="DataTable" >
           <th class="DataTable" colspan=3>Kit Link Price Diffirence<br>Ski Stop</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time<br>Modified</th>
           <th class="DataTable">Delete</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("PrcDiffST") >= 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table>
     </td>

     <TD vAlign=top align=middle>
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSCh">
         <tr class="DataTable" >
           <th class="DataTable" colspan=3>Kit Link Price Diffirence<br>Railhead Board Sports</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time<br>Modified</th>
           <th class="DataTable">Delete</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) { %>
         <%if(ecdownl[i].getName().indexOf("PrcDiffRH") >= 0){%>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="ECommerce/" + ecdownl[i].getName().trim()%>" target="_blank"><%=ecdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=df.format(new Date(ecdownl[i].lastModified()))%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=ecdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
         <%}%>
       <%}%>
     </table>
     </td>
     <!-- ================================================================== -->
     <tr>
        <td colspan=3 align=center>
           <!-- button id="btnDown" onClick="downloadFiles('CRTPRC')">Download</button -->
           <button id="btnDown" onClick="downloadFiles('DELETE')">Deleted Items</button>
        </td>
     </tr>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>