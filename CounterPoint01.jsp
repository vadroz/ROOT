<%@ page import="java.util.*, java.io.*, java.net.URL, java.sql.*"%>
<%
   String sFile = request.getParameter("File");

   String [] sName = null;
   String [] sType = null;
   int [] iLen = null;
   int [] iDec = null;
   int iCol = 0;

   // get file description
   if(sFile != null)
   {
      String url   = "jdbc:odbc:CounterPoint";
      String query = "SELECT * FROM " + sFile;
      try {
            Class.forName ("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection (url, "", "");
            DatabaseMetaData dma = con.getMetaData ();

            //  run SQL statement
            Statement stmt = con.createStatement ();
            ResultSet rs = stmt.executeQuery (query);

            ResultSetMetaData rsmda = rs.getMetaData();
            iCol = rsmda.getColumnCount();

            sName = new String[iCol];
            sType = new String[iCol];
            iLen = new int[iCol];
            iDec = new int[iCol];

            for (int i = 1; i <= iCol; i++)
            {
               sName[i-1] = rsmda.getColumnName(i);
               sType[i-1] = rsmda.getColumnTypeName(i);
               iLen[i-1] = rsmda.getPrecision(i);
               iDec[i-1] = rsmda.getScale(i);
            }

            rs.close();
            stmt.close();
            con.close();
        }
        catch (SQLException ex) {
            out.println (ex.getMessage());
        }
        catch (java.lang.Exception ex) {
            out.println(ex.getMessage());
        }
   }
%>
<html>
<style>
        body {background:ivory;}
        a:link { color:blue} a:visited { color:blue}  a:hover { color:blue}
        a.Menu:link { color:black; text-decoration:none }
        a.Menu:visited { color:black; text-decoration:none }
        a.Menu:hover { color:red; text-decoration:none }

        table.DataTable { border: darkred solid 1px;text-align:center;}
        tr.Hdr { background:#FFCC99; padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;text-align:center; font-size:12px }
        th.Hdr { padding-top:1px; padding-bottom:1px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;}

        tr.Dtl { padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;font-size:12px }
        td.Dtl { padding-top:1px; padding-bottom:1px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:left; }
        td.Dtl1 { padding-top:1px; padding-bottom:1px; border-bottom: darkred solid 1px;border-right: darkred solid 1px; text-align:right; }
</style>


<SCRIPT language="JavaScript">
//==============================================================================
// submit File Description
//==============================================================================
function sbmFileDesc()
{
   url = "CounterPoint01.jsp?File=" + document.all.File.value
   window.location.href = url;
}
</SCRIPT>


<body>

<!-- ======================================================================= -->
<!-- File description Table  -->
<!-- ======================================================================= -->
<table border=0 width=100% cellPadding="0" cellSpacing="0">
  <tr>
    <td align=center style="font-size:16px;">
       <b>Display Counter Point File Field Description<br>
       #2 Import Test Company<br></b>
     </td>
  </tr>



  <tr><td align=center>
    File Name: <input name="File"> &nbsp; &nbsp;
    <button onClick="sbmFileDesc()">Description</button>
    <br>
    <a href="../"><font color="red">Home</font></a>&#62;<br>

    <table class="DataTable" cellPadding="0" cellSpacing="0">
      <tr class="Hdr">
        <th class="Hdr" colspan=5>File: <%=sFile%></th>
      </tr>
      <tr class="Hdr">
        <th class="Hdr">No.</th>
        <th class="Hdr">Name</th>
        <th class="Hdr">Type</th>
        <th class="Hdr">Length</th>
        <th class="Hdr">Scale</th>
      </tr>

      <!-- ----------------------------------------------------------------- -->
      <!-- Details -->
      <!-- ----------------------------------------------------------------- -->
      <%for(int i = 0; i < iCol; i++){%>
        <tr class="Dtl">
          <td class="Dtl1"><%=i+1%></td>
          <td class="Dtl"><%=sName[i]%></td>
          <td class="Dtl"><%=sType[i]%></td>
          <td class="Dtl1"><%=iLen[i]%></td>
          <td class="Dtl1"><%=iDec[i]%></td>
        </tr>
      <%}%>
  </table>


  </td>
 </tr>
</table>

</body>
</html>




