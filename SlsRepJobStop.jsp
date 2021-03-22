<%@ page import="salesreport.SlsRepJobDlt, java.io.File"%>
<%
      String sFile = request.getParameter("File");
      String sUser = session.getAttribute("USER").toString();
      String sPath = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT" + sFile;

      //  delete file from server
      File f = new File(sPath);
      if(f.exists()) { f.delete(); }

      SlsRepJobDlt jobdlt = new SlsRepJobDlt( sFile, sUser );
      jobdlt.disconnect();
      jobdlt = null;
%>
<script>
parent.closeFrame();
</script>
