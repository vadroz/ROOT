<%@ page import="java.io.*, java.util.*"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
/*if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=StoreOPS.jsp");
}
else
{*/
   String sFolder = "Audits";//request.getParameter("Folder");
   String sName = "Audits";//request.getParameter("Name");

   String sPath = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT/Store_OPS/" + sFolder;

   File dir = new File(sPath);
   if (!dir.exists()) 
   { 
	   dir.mkdir(); System.out.println("Create new directory: " + sPath);
   }   
   File[] ecdownl = dir.listFiles();
   if(ecdownl != null && ecdownl.length > 0)
   {   
	   java.util.Arrays.sort(ecdownl);   
   }
%>
<HTML>
<HEAD>
<title>Sotre_OPS</title>
<META content="RCI, Inc." name="Store_Operations"></HEAD>

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
        <BR><%=sName%>
        </B><br>
        <a href="../"><font color="red">Home</font></a>
  <TR>
    <TD vAlign=top align=middle>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSaS">
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time Modified</th>
         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < ecdownl.length; i++ ) {
           String sFileName = ecdownl[i].getName().trim();
           boolean bShortcut = false;

           if(ecdownl[i].getName().trim().indexOf("url") >= 0)
           {
              StringBuffer contents = new StringBuffer();
              BufferedReader reader = null;
              try
              {
                  reader = new BufferedReader(new FileReader(ecdownl[i]));
                  String text = null;
                  while ((text = reader.readLine()) != null)
                  {
                     if(text.indexOf("URL=") >= 0)
                     {
                         sFileName = text.substring(4);
                         bShortcut = true;
                         break;
                     }

                  }
              }
              catch(Exception e) { System.out.println(e.getMessage());}
           }
       %>

            <tr id="trItem" class="DataTable">
              <%if(bShortcut){%>
                  <td class="DataTable" nowrap><a href="<%=sFileName%>" target="_blank"><%=ecdownl[i].getName().trim()%></a></td>
              <%} else{%>
                  <td class="DataTable" nowrap><a href="<%="Store_OPS/" + sFolder + "/" + ecdownl[i].getName().trim()%>" target="_blank"><%=sFileName%></a></td>
              <%}%>
              <td class="DataTable" nowrap><%=new Date(ecdownl[i].lastModified())%></td>
            </tr>
       <%}%>
      </table>
     </td>
     </tr>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%
//}
%>