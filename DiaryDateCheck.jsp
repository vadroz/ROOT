<%@ page import="rciutility.RunSQLStmt, java.text.*, java.util.*, java.sql.*"%>
<%
    String sUser = request.getParameter("user");

    String sStmt = "select ent_dt"
     + " From Rci.DryLog "
     + " where ent_us='" + sUser + "'";

   System.out.println("\n" + sStmt);
   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   ResultSet rs = runsql.runQuery();

   String sList ="";
   String sDiv = "";
   while(runsql.readNextRecord())
   {

      SimpleDateFormat smpYMD = new SimpleDateFormat("yyyy-MM-dd");
      SimpleDateFormat smpMDY = new SimpleDateFormat("MM/dd/yyyy");

      String sDate = smpMDY.format(smpYMD.parse(runsql.getData("ent_dt").trim()));

      sList += sDiv + sDate;
      sDiv = ":";
   }
%>
Dates|<%=sList%>