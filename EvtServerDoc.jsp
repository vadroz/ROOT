<%@ page import="java.io.File, java.util.*"%>
<%
   String sPath = request.getParameter("Path");
   //if(sPath == null) sPath = "C:/Program Files/Apache Group/Tomcat 4.1/webapps/ROOT/memopool";
   //if(sPath == null) sPath = "/var/tomcat4/webapps/ROOT/memopool";

   File dir = new File(sPath);
   System.out.println(sPath);

   File[] file = dir.listFiles();

   int iNumOfFile = 0;
   String [] sFile = null;
   
   if(file != null)
   {
      iNumOfFile = file.length;
      sFile = new String[iNumOfFile];

      for(int i=0; i < iNumOfFile; i++)
      {
        sFile[i] = file[i].getName();
      }
   }
%>
<script language="JavaScript1.2">
var Path = "<%=sPath%>"
var NumOfFile = <%=iNumOfFile%>
var File = new Array(NumOfFile);

<%for(int i=0; i < iNumOfFile; i++){%> File[<%=i%>] = "<%=sFile[i]%>"; <%}%>

parent.showDocs(Path, NumOfFile, File);
window.close();
</script>

