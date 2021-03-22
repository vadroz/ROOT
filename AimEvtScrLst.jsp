<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sSelId = request.getParameter("id");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
      String sUser = session.getAttribute("USER").toString();

      String sLvlJsa = "";
      String sScrJsa = "";
      String sStmt = "select Level, Score from RCI.AmEvScr where Evt_Id=" + sSelId
         + " order by Level";
      RunSQLStmt runsql = new RunSQLStmt();
      runsql.setPrepStmt(sStmt);
      ResultSet rs = runsql.runQuery();
      String sComa= "";

      while(runsql.readNextRecord())
      {
         String sLvl = runsql.getData("level").trim();
         sLvlJsa += sComa + "\"" + sLvl + "\"";
         String sScr = runsql.getData("score").trim();
         sScrJsa += sComa + "\"" + sScr + "\"";
         sComa=",";
      }

%>
<html>
<head>

<SCRIPT language="JavaScript1.2">
var lvl = [<%=sLvlJsa%>];
var scr = [<%=sScrJsa%>];
parent.setEvtScr(lvl, scr);

</SCRIPT>

<%}
else{%><SCRIPT language="JavaScript1.2">alert("Please sign on")</SCRIPT><%}%>