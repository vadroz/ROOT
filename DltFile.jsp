<%@ page import="java.io.File, java.util.*"%>
<%
   String sFile = request.getParameter("File");

   try
   {
      System.out.println(sFile);

      File f = new File(sFile);
      System.out.println("Exist? " + f.exists());

      f.delete();
      f = null;
   }
   catch(Exception e){ System.out.println(e.getMessage());}
%>
<script>
  parent.restart();
</script>
