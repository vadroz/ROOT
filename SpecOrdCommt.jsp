<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sStore = request.getParameter("Store");
   String sOrder = request.getParameter("Order");

   SimpleDateFormat smpDtIso = new SimpleDateFormat("yyyy-MM-dd");
   SimpleDateFormat smpDtMdy = new SimpleDateFormat("MM/dd/yyyy");
   SimpleDateFormat smpTmIso = new SimpleDateFormat("HH:mm:ss");
   SimpleDateFormat smpTmUsa = new SimpleDateFormat("hh:mm a");
   SimpleDateFormat smpYear = new SimpleDateFormat("yyyy");

   String sConj = "";
   String sStmt = "select SOTYPE, SOCOMMT, SORECUS, SORECDT, SORECTM"
     + " from RCI.SpoCommt"
     + " where SoStr=" + sStore + " and SoOrd=" + sOrder
     + " order by soid"
     ;

   //System.out.println(sStmt);

   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   ResultSet rs = runsql.runQuery();

   ResultSetMetaData rsmd = rs.getMetaData();

   int j=0;
   String sComa = "";

   String sType = "";
   String sCommt = "";
   String sCmtUser = "";
   String sCmtDate = "";
   String sCmtTime = "";

   while(runsql.readNextRecord())
   {
      sType += sComa + "\"" + runsql.getData("SOTYPE").trim() + "\"";
      String raw = runsql.getData("SOCOMMT").trim();
      raw = raw.replaceAll("\"", "&#34;");
      sCommt += sComa + "\"" + raw + "\"";
      sCmtUser += sComa + "\"" + runsql.getData("SoRecUs").trim() + "\"";
      sCmtDate += sComa + "\"" + smpDtMdy.format(smpDtIso.parse(runsql.getData("SoRecDt"))) + "\"";
      sCmtTime += sComa + "\"" + smpTmUsa.format(smpTmIso.parse(runsql.getData("SoRecTm"))) + "\"";

      sComa= ",";
   }
%>

<SCRIPT language="JavaScript1.2">
var Store = "<%=sStore%>";
var Order = "<%=sOrder%>";
var Type = [<%=sType%>];
var Commt = [<%=sCommt%>];
var CmtUser = [<%=sCmtUser%>];
var CmtDate = [<%=sCmtDate%>];
var CmtTime = [<%=sCmtTime%>];

parent.showComments(Store, Order, Type, Commt, CmtUser, CmtDate, CmtTime);

</SCRIPT>
