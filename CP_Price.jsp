<%@ page import="java.util.*, java.io.*, java.net.URL, java.sql.*"%>
<%
   String sSku = request.getParameter("Sku");
   int iCol = 0;
   Connection con = null;
   DatabaseMetaData dma = null;
   Statement stmt = null;
   ResultSet rs = null;
   ResultSetMetaData rsmda = null;

   // get file description
   if(sSku != null)
   {
      String url   = "jdbc:odbc:CounterPoint";
      String query = "SELECT i.ITEM_NO, i.DESCR, p.LOC_ID, p.REG_PRC, p.PRC_1, p.PRC_2,"
                   + "p.PRC_3, p.PRC_4, p.PRC_5, p.PRC_6, v.QTY_ON_HND, v.MIN_QTY,"
                   + "v.MAX_QTY, v.QTY_ON_PO"
                   + " FROM IM_PRC p, IM_ITEM i, IM_INV v  "
                   + " where i.ITEM_NO = '" + sSku + "' and i.ITEM_NO = p.ITEM_NO"
                   + " and i.ITEM_NO = v.ITEM_NO and p.LOC_ID = v.LOC_ID"
                   + " Order by i.ITEM_NO, p.LOC_ID";

      try {
            Class.forName ("sun.jdbc.odbc.JdbcOdbcDriver");
            con = DriverManager.getConnection (url, "", "");
            dma = con.getMetaData ();

            //  run SQL statement
            stmt = con.createStatement ();
            rs = stmt.executeQuery (query);

            rsmda = rs.getMetaData();
            iCol = rsmda.getColumnCount();

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
        tr.Dtl2 { padding-top:3px; padding-bottom:3px; padding-right:3px; padding-left:3px;font-size:14px }
        td.Dtl2 { color:darkred; padding-top:1px; padding-bottom:1px; border-bottom: darkred solid 1px;border-right: darkred solid 1px;text-align:center; }
</style>


<SCRIPT language="JavaScript">
//==============================================================================
// submit File Description
//==============================================================================
function sbmFileDesc()
{
   url = "CP_Price.jsp?Sku=" + document.all.Sku.value
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
       <b>Display Item Price and Inventory<br>
       #2 Import Test Company<br></b>
     </td>
  </tr>



  <tr><td align=center>
    Sku: <input name="Sku"> &nbsp; &nbsp;
    <button onClick="sbmFileDesc()">Description</button>
    <br>
    <a href="../"><font color="red">Home</font></a>&#62;<br>

    <table class="DataTable" cellPadding="0" cellSpacing="0">
      <tr class="Hdr">
        <th class="Hdr">Str</th>

        <th class="Hdr">Reg<br>Price</th>
        <th class="Hdr">Price<br>1</th>
        <th class="Hdr">Price<br>2</th>
        <th class="Hdr">Price<br>3</th>

        <th class="Hdr">Qty<br>On-hand</th>
        <th class="Hdr">Min<br>Qty</th>
        <th class="Hdr">Max<br>Qty</th>
        <th class="Hdr">Qty<br>On PO</th>

      </tr>

      <!-- ----------------------------------------------------------------- -->
      <!-- Details -->
      <!-- ----------------------------------------------------------------- -->
  <%if(sSku != null){%>
      <%boolean bFirst = true;
        while (rs.next ())
        {
      %>
          <%if(bFirst) { bFirst = false;%>
          <tr class="Dtl2">
             <td class="Dtl2" colspan=12><%="Short SKU: " + rs.getString(1) + " &nbsp; " + rs.getString(2)%></td>
          </tr>
          <%}%>
          <tr class="Dtl">
             <td class="Dtl1"><%=rs.getShort(3)%></td>

             <td class="Dtl1">$<%=rs.getDouble(4)%></td>
             <td class="Dtl1">$<%=rs.getDouble(5)%></td>
             <td class="Dtl1">$<%=rs.getDouble(6)%></td>
             <td class="Dtl1">$<%=rs.getDouble(7)%></td>


             <td class="Dtl1"><%=rs.getInt(11)%></td>
             <td class="Dtl1"><%=rs.getInt(12)%></td>
             <td class="Dtl1"><%=rs.getInt(13)%></td>
             <td class="Dtl1"><%=rs.getInt(14)%></td>
         </tr>
      <%}%>
  <%}%>
  </table>


  </td>
 </tr>
</table>

</body>
</html>

<%
   if(sSku != null)
   {
      try
      {
        rs.close();
        stmt.close();
        con.close();
      }
      catch (java.lang.Exception ex)
      {
            out.println(ex.getMessage());
      }

   }
%>


