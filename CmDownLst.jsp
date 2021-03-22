<%@ page import="java.io.File, java.text.*, java.util.*, java.net.URL, java.sql.*, rciutility.FormatNumericValue"%>
<%
//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")==null)
{
   response.sendRedirect("SignOn1.jsp?TARGET=CmDownLst.jsp");
}
else
{
   String sPath = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT/CRM";

   File dir = new File(sPath);
   File[] crmdownl = dir.listFiles();
   java.util.Arrays.sort(crmdownl);

   SimpleDateFormat sdf = new SimpleDateFormat("&#160; MM/dd/yyyy &#160; &#160; hh:mm a");

   //---------------------------------------------------------------------------
   // get number of records in files
   //---------------------------------------------------------------------------
   String url   = "jdbc:odbc:McText;DBQ=CRM";
   Connection con = null;
   FormatNumericValue fmt = new FormatNumericValue();

   // connect to database
   try
   {
          Class.forName ("sun.jdbc.odbc.JdbcOdbcDriver");
          con = DriverManager.getConnection (url, "", "");
   }

   catch (SQLException ex) {   System.out.println (ex.getMessage());   }

   long [] lNumOfRec = new long[crmdownl.length];
   String [] sComment = new String[crmdownl.length];

   for(int i=0; i < crmdownl.length; i++ )
   {
      //  run SQL statement
      try
      {
         // get number of records in file
         String query = "SELECT count(*) FROM " + crmdownl[i].getName();
         Statement stmt = con.createStatement ();
         ResultSet rs = stmt.executeQuery (query);
         if (rs.next()) { lNumOfRec[i] = rs.getLong(1); }
         rs.close(); stmt.close();

         // get file comments
         query = "SELECT * FROM " + crmdownl[i].getName();
         stmt = con.createStatement ();
         rs = stmt.executeQuery (query);
         ResultSetMetaData rsmda = rs.getMetaData();
            // if (rs.next()) { sComment[i] = rs.getString(1); }
         sComment[i] = rsmda.getColumnName(1);
         rs.close(); stmt.close();
       }
       catch (SQLException ex) {   System.out.println (ex.getMessage());   }

   }
   con.close();
%>

<HTML>
<HEAD>
<title>CRM Download Files</title>
<META content="RCI, Inc." name="CRM_Dowload_Files"></HEAD>

<style>body {background:ivory;}
        a:link { color:blue; font-size:12px} a:visited { color:blue; font-size:12px}  a:hover { color:red; font-size:12px}
        a:link.small { color:blue; font-size:10px} a:visited.small { color:blue; font-size:10px}  a:hover.small { color:red; font-size:10px}
        th.DataTable { background:#FFCC99;padding-top:3px; padding-bottom:3px; text-align:center; font-family:Verdanda; font-size:12px }
        td.DataTable { padding-top:3px; padding-bottom:3px; text-align:left; font-family:Verdanda; font-size:12px }
        td.DataTable1 { padding-top:3px; padding-bottom:3px; text-align:right; font-family:Verdanda; font-size:12px; font-weight:bold; }

   div.dvSbmSts { position:absolute; visibility:hidden; background-attachment: scroll;
              border: black solid 2px; width:500; background-color:LemonChiffon; z-index:10;
              text-align:center; font-size:10px}
</style>


<script name="javascript1.2">
//==============================================================================
// delete file
//==============================================================================
function dltFile(file)
{
   var url = "CmDltDwnl.jsp?File=" + file;
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


<TABLE height="100%" width="100%" border=0>
  <TBODY>
  <TR>
    <TD vAlign=top align=middle colspan=4><B>Retail Concepts Inc.
        <BR>CRM Download Files
        </B><br>
        <a href="../"><font color="red">Home</font></a>
  <TR>
    <TD vAlign=top align=middle>
<!-- ======================================================================= -->
       <table border=1 cellPadding="0" cellSpacing="0" id="tbSaS">
         <tr class="DataTable"><th class="DataTable" colspan=5>Customer List</th></tr>
         <tr class="DataTable">
           <th class="DataTable">File</th>
           <th class="DataTable">Last Time Modified</th>
           <th class="DataTable">Records</th>
           <th class="DataTable">Comment</th>
           <th class="DataTable">Delete</th>

         </tr>

       <!-- ============================ Details =========================== -->
       <%for(int i=0; i < crmdownl.length; i++ ) { %>
            <tr id="trItem" class="DataTable">
              <td class="DataTable" nowrap><a href="<%="CRM/" + crmdownl[i].getName().trim()%>" target="_blank"><%=crmdownl[i].getName()%></a></td>
              <td class="DataTable" nowrap><%=sdf.format(new java.util.Date(crmdownl[i].lastModified()))%></td>
              <td class="DataTable1" nowrap><%=fmt.getFormatedNum( Long.toString(lNumOfRec[i]), "###,###,###").trim()%></td>
              <td class="DataTable" nowrap>&nbsp;<%=sComment[i]%></td>
              <td class="DataTable" nowrap><a href="javascript: dltFile('<%=crmdownl[i].getName().trim()%>')">Delete</a></td>
            </tr>
       <%}%>
     </table>


<!-- ======================================================================= -->
      </TD>
     </TR>
    </TBODY>
   </TABLE>
</BODY></HTML>
<%}%>