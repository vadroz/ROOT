<%@ page import="salesigns01.FreshSigns, java.io.File, java.util.*, java.text.SimpleDateFormat"%>
<%
    FreshSigns fresh = new FreshSigns("C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT");
    //FreshSigns fresh = new FreshSigns("/var/tomcat4/webapps/ROOT");
    Vector vFile = fresh.getFile();
    Iterator ivFile = vFile.iterator();
%>

<style>body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        table.DataTable { border: darkred solid 1px;background:#FFE4C4;text-align:center;}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { background:white; padding-top:3px; padding-bottom:3px; text-align:left; font-family:Arial; font-size:10px }
	td.DataTable1 { background:lightgrey; padding-top:3px; padding-bottom:3px; border-right: darkred solid 1px; text-align:right; font-family:Arial; font-size:10px }
        td.DataTable2{ background:cornsilk; padding-top:3px; padding-bottom:3px; text-align:right; font-family:Arial; font-size:10px }
</style>


<BODY>
<p align="center"> <b>New Objects Created after 01/12/2007</b>

  <table class="DataTable" align="center" >
     <tr>
       <th class="DataTable" >Object</th>
       <th class="DataTable" >Date</th>
     </tr>
     <!-- ================================================================== -->
     <%
        while(ivFile.hasNext())
        {
            File f = (File) ivFile.next();
            Date lstdate = new Date( f.lastModified());
            SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
            String sDate = df.format(lstdate);
      %>
           <tr>
             <td class="DataTable" ><%=f.getPath()%></td>
             <td class="DataTable" ><%=sDate%></td>
           </tr>
      <%}%>

  </table>
</BODY>
</HTML>
