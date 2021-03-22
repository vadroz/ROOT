<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*"%>
<%
   String sRec = request.getParameter("Rec");
   String sRrn = request.getParameter("Rrn");

   String sStmt = "delete "
      + " from rci.PsSchdd sd"
      + " where rrn(sd)= " + sRrn
   ;
   RunSQLStmt runsql = new RunSQLStmt();
   runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
   runsql.disconnect();

   //runsql.setPrepStmt(sStmt);
   //ResultSet rs = runsql.runQuery();
   //while(runsql.readNextRecord())
   //{
   //   System.out.print("\nRRN: " + sRrn);
   //   System.out.print(" Str: " + runsql.getData("SdStr").trim());
   //   System.out.print(" Name: " + runsql.getData("SdENam").trim());
   //   System.out.print("Grp: " + runsql.getData("SdGrp").trim());
   //   System.out.print(" Beg Tiem: " + runsql.getData("SdBTim").trim());
   //   System.out.println(" End Time: " + runsql.getData("SdETim").trim());
   //}

%>
<SCRIPT language="JavaScript">
 parent.dltConfRec("<%=sRec%>");
</script>
