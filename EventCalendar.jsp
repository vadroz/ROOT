<%@ page import="java.io.File, java.util.*"%>
<%
  String sPath = request.getParameter("Path");
  if(sPath == null) { sPath = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT/Calendar";}
  //if(sPath == null) sPath = "/var/tomcat4/webapps/ROOT/Calendar";

   File dir = new File(sPath);
   File[] signs = dir.listFiles();
   Arrays.sort(signs);
%>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable{ background:cornsilk; padding-top:3px; padding-bottom:3px; text-align:center; font-family:Arial; font-size:10px }
</style>


<BODY>
<p align="center"> <b>Event Calendar</b>
<p align="center">
  <table class="DataTable" align="center" width="200">
     <tr>
       <th class="DataTable">Calendar</th>
     </tr>
      <%for(int i=0; i<signs.length;i++){%>
        <%if(!signs[i].getName().endsWith(".jpg")){%>
          <tr>
           <%if(signs[i].isDirectory()){%>
               <td class="DataTable" >
                 <a href="EventCalendar.jsp?Path=<%=sPath + "/" + signs[i].getName()%>"><%=signs[i].getName()%></a>
               </td>
           <%}
             else {%>
               <td class="DataTable" >
                 <a href="<%=signs[i].getParentFile().getParentFile().getName()%>/<%=signs[i].getParentFile().getName()%>/<%=signs[i].getName()%>"><%=signs[i].getName()%></a>
               </td>
           <%}%>
          </tr>
        <%}%>
      <%}%>
  </table>
</BODY>
</HTML>
