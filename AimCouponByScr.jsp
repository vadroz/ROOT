<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sEmpScr = request.getParameter("scr");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
      String sUser = session.getAttribute("USER").toString();

      String sCoupon = "";
      String sScr = "";
      String sName = "";

      String sStmt = "select coupon, score, begdt, expdt, name"
        + " from  rci.AMCOUPN"
        + " where status = 'Active'"
        + " and expDt >= current date"
        + " and score <= 20";
      RunSQLStmt runsql = new RunSQLStmt();
      runsql.setPrepStmt(sStmt);
      ResultSet rs = runsql.runQuery();
      String sComa= "";

      while(runsql.readNextRecord())
      {
         sCoupon += sComa + "\"" + runsql.getData("coupon").trim() + "\"";
         sScr += sComa + "\"" + runsql.getData("score").trim() + "\"";
         sName += sComa + "\"" + runsql.getData("name").trim() + "\"";
         sComa=",";
      }
%>
<html>
<head>

<SCRIPT language="JavaScript1.2">
var coupon = [<%=sCoupon%>];
var scr = [<%=sScr%>];
var name = [<%=sName%>];
parent.setCoupon(coupon, scr, name);

</SCRIPT>

<%}
else{%><SCRIPT language="JavaScript1.2">alert("Please sign on")</SCRIPT><%}%>