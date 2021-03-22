<%@ page import="java.net.URL, java.sql.*, java.util.*, java.text.*"%>
<%
   String sOrder = request.getParameter("Order");

   String url = "jdbc:odbc:McText;DBQ=//rcifile/UPS";


   String query = "insert into newendofday.csv (";
   String sComa = "";
   for(int i=1; i < 29; i++)
   {
      query +=  sComa + "F"  + i;
      sComa = ", ";
   }
   query +=  ") "  + sValues;

   try {
            Class.forName ("sun.jdbc.odbc.JdbcOdbcDriver");

            Connection con = DriverManager.getConnection (url, "", "");
            DatabaseMetaData dma = con.getMetaData ();

            System.out.println("\nConnected to " + dma.getURL());
            System.out.println("Driver       "  + dma.getDriverName());
            System.out.println("Version     " +  dma.getDriverVersion());

            //  run SQL statement
            Statement stmt = con.createStatement ();
            boolean bError = stmt.execute (query);

            stmt.close();
            con.close();
        }
        catch (Exception ex) {
            System.out.println(ex.getMessage());
            ex.printStackTrace ();
        }
%>






