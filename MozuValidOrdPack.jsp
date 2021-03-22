<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sOrder = request.getParameter("Order");
   String sPack = request.getParameter("Pack");


   String sStmt = null;
   if(sOrder != null)
   {  	
	   sStmt = "select ohord, char(ohordate, usa) as ohordate, days(current date) - days(ohordate) as ord_age"
     	+ " from Rci.MoOrdH"
     	+ " where ohord=" + sOrder
     	;
   }
   else
   {
	   sStmt = "select ohord, char(ohordate, usa) as ohordate, days(current date) - days(ohordate) as ord_age"
		     	+ " from Rci.MoOrdh"
		     	+ " where exists(select 1 from rci.MoFdxPId where fdord=ohord and FDPCKID=" + sPack + ")";
   }
   System.out.println(sStmt);

   RunSQLStmt sql_Item = new RunSQLStmt();
   sql_Item.setPrepStmt(sStmt);
   ResultSet rs_Item = sql_Item.runQuery();
   boolean bUpcFound = false;
   String sOrd = "";
   String sOrdDt = "";
   String sDays = "";
   if(sql_Item.readNextRecord())
   {
      bUpcFound = true;
      sOrd = sql_Item.getData("ohord");
      sOrdDt = sql_Item.getData("ohordate");
      sDays = sql_Item.getData("ord_age");
   }
   sql_Item.disconnect();
   //System.out.println(sSku);

%>
<ORD_Valid><%=bUpcFound%></ORD_Valid><Order><%=sOrd%></Order><Ord_Dt><%=sOrdDt%></Ord_Dt><Days><%=sDays%></Days>












