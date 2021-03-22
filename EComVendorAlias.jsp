<%@ page import="rciutility.RunSQLStmt, java.text.*, java.sql.*, java.util.*"%>
<%
   String sVen = request.getParameter("Ven");
   String sSelVenName = request.getParameter("VenName");
   String sAction = request.getParameter("Action");

   String sPrepStmt = null;

   if(sAction.equals("DELETE"))
   {
      StringBuffer sbRepl = new StringBuffer();
      for(int i=0; i < sSelVenName.length(); i++)
      {
         sbRepl.append(sSelVenName.substring(i, i+1));
         if(sSelVenName.substring(i, i+1).equals("'"))
         {
            sbRepl.append("'");
         }
      }
      sSelVenName = sbRepl.toString();

      sPrepStmt = "delete from rci.EcMrVen"
        + " where MvVen = " + sVen
        + " and MvName = '" + sSelVenName + "'";
      System.out.println(sPrepStmt);
      RunSQLStmt rundltsql = new RunSQLStmt();
      rundltsql.runSinglePrepStmt(sPrepStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
      rundltsql.disconnect();
      rundltsql = null;
   }

   sPrepStmt = "select MvName"
      + " from rci.EcMrVen"
      + " where MvVen = " + sVen
      + " order by MvName";
   //System.out.println(sPrepStmt);

   ResultSet rslset = null;
   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sPrepStmt);

   ResultSet rs = runsql.runQuery();

   int iNumOfRec = 0;

   String sVenName = "";
   String coma = "";
   while(runsql.readNextRecord())
   {
      sVenName += coma + "\"" + runsql.getData("MvName").trim() + "\"";
      coma = ",";
      iNumOfRec++;
   }

   runsql.disconnect();
   runsql = null;


%>

<SCRIPT language="JavaScript1.2">
  var Ven = "<%=sVen%>";
  var VenName = [<%=sVenName%>];
  parent.popMnfAlias(Ven, VenName);
</SCRIPT>







