<%@ page import="java.sql.*, java.util.*, java.text.*, rciutility.RunSQLStmt"%>
<%
   String sProj = request.getParameter("Proj");

   SimpleDateFormat sdfFrDt = new SimpleDateFormat("yyyy-MM-dd");
   SimpleDateFormat sdfToDt = new SimpleDateFormat("MM/dd/yyyy");

   SimpleDateFormat sdfFrTm = new SimpleDateFormat("HH:mm:ss");
   SimpleDateFormat sdfToTm = new SimpleDateFormat("hh:mm a");

   String sStmt = "select PCCMT, PCRUSER, PCRECDT, PCRECTM"
             + " from RCI.PJCOMMNT"
             + " where pcid = " + sProj
             + " and pctype='User'"
             + " order by pccmtId";

   RunSQLStmt runsql = new RunSQLStmt();
   runsql.setPrepStmt(sStmt);
   ResultSet rs = runsql.runQuery();

   String sComa= "";
   String sCommt = "";
   String sRecUs = "";
   String sRecDt = "";
   String sRecTm = "";

   while(runsql.readNextRecord())
   {
      sCommt += sComa + "\"" + runsql.getData("PCCMT") + "\"";
      sRecUs += sComa + "\"" + runsql.getData("PCRUSER") + "\"";

      java.util.Date dtRec = sdfFrDt.parse( runsql.getData("PCRECDT") );
      sRecDt += sComa + "\"" + sdfToDt.format(dtRec) + "\"";

      java.util.Date tmRec = sdfFrTm.parse( runsql.getData("PCRECTM") );
      sRecTm += sComa + "\"" + sdfToTm.format(tmRec) + "\"";
      sComa=",";
   }
%>

<script language="JavaScript">
  var Proj = "<%=sProj%>";
  var Commt = [<%=sCommt%>];
  var RecUs = [<%=sRecUs%>];
  var RecDt = [<%=sRecDt%>];
  var RecTm = [<%=sRecTm%>];

  parent.setComment(Proj, Commt, RecUs, RecDt, RecTm);
</script>









