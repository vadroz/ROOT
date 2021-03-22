<%@ page import="salesreport.SlsRepJobDlt, java.io.File"%>
<%
      String sFile = request.getParameter("File");
      String sJob = request.getParameter("Job");
      String sJobUser = request.getParameter("JobUser");
      String sJobNum = request.getParameter("JobNum");
      String sUser = session.getAttribute("USER").toString();
      String sPath = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT" + sFile;
      String sAction = request.getParameter("Action");


      //  delete file from server
      File f = new File(sPath);
      if(f.exists()) { f.delete(); }

      SlsRepJobDlt jobdlt = new SlsRepJobDlt();

      if(sAction.equals("DLTFILE"))
      {
         jobdlt.deleteFile(sFile, sUser);
      }
      else if(sAction.equals("STOPJOB"))
      {
         //System.out.println(sJob + " " + sJobUser + " " + sJobNum + " " + sUser);
         jobdlt.stopJob(sJob, sJobUser, sJobNum, sUser);
      }

      jobdlt.disconnect();
      jobdlt = null;
%>
<script>
parent.closeFrame();
</script>
