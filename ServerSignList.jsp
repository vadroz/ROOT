<%@ page import="java.io.File, java.util.*"%>
<%
   String sPath = request.getParameter("Path");
   if(sPath == null) sPath = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT/Signs";
   //if(sPath == null) sPath = "/var/tomcat4/webapps/ROOT/Signs";

   File dir = new File(sPath);

   File[] signs = dir.listFiles();
%>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:lightgrey; padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px }
	td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable2{ background:cornsilk; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }
</style>


<BODY>
<p align="center"> <b>Sign Directory and File List</b>

  <table class="DataTable" align="center" >
     <tr>
       <th class="DataTable" >Object</th>
       <th class="DataTable" >Type</th>
     </tr>
       <%for(int i=0; i<signs.length;i++){%>
          <tr>
            <!-- show link if directory -->
            <%if(signs[i].isDirectory()) {%>
               <td class="DataTable" >
                 <a href="ServerSignList.jsp?Path=<%=sPath + "/" + signs[i].getName()%>"><%=signs[i].getName()%></a>
               </td>
            <%}
            else {%>
              <td class="DataTable" ><%=signs[i].getName()%><%}%></td>


            <td class="DataTable" >
              <%if(signs[i].isDirectory()) {%> Directory<%}
                else {%> File <%}%>
            </td>
       <%}%>
     </tr>
  </table>
</BODY>
</HTML>
