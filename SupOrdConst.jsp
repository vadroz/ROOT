<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*, java.math.BigDecimal"%>
<%
   String sConst = request.getParameter("Const");
   String sFunction = request.getParameter("Function");
   String sField = request.getParameter("Field");

   String sStmt = "select PtConst, PtDescr"
      + " from Rci.SuConst"
      + " where PtGrp = '" + sConst + "'"
      + " order by PtSort";

   //System.out.println(sStmt);

   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   ResultSet rs = runsql.runQuery();

   int j=0;

   String sConstJsa = "";
   String sDescJsa = "";
   String sComa= "";

   while(runsql.readNextRecord())
   {
      sConstJsa += sComa + "\"" + runsql.getData("PtConst").trim() + "\"";
      sDescJsa += sComa + "\"" + runsql.getData("PtDescr").trim() + "\"";

      j++;
      sComa=",";
   }
%>

<script language="JavaScript1.2">
var Const = [<%=sConstJsa%>];
var Desc = [<%=sDescJsa%>];

parent.<%=sFunction%>("<%=sField%>", Const, Desc);
</script>















