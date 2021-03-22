<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sEmp = request.getParameter("emp");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
      String sUser = session.getAttribute("USER").toString();

      String sName = "";
      String sStr = "";
      String sSepr = "";
      boolean bExist = false;

      String sStmt = "select ename, estore, esepr"
        + " from  rci.RciEmp"
        + " where erci =" + sEmp;
      RunSQLStmt runsql = new RunSQLStmt();
      runsql.setPrepStmt(sStmt);
      ResultSet rs = runsql.runQuery();

      if(runsql.readNextRecord())
      {
         bExist = true;
         sName = runsql.getData("ename").trim();
         sStr = runsql.getData("estore").trim();
         sSepr = runsql.getData("esepr").trim();
      }


      String sEmail = "";
      String sWaiver = "";
      String sInit = "";
      String sPrdTy = "";
      String sSiz = "";

      sStmt = "select APEMAIL, APWAIVR, APPRDTY, APSIZ, APINIT"
        + " from  rci.AmEmpPgm"
        + " where apemp=" + sEmp;
      runsql = new RunSQLStmt();
      runsql.setPrepStmt(sStmt);
      rs = runsql.runQuery();

      if(runsql.readNextRecord())
      {
         sEmail = runsql.getData("APEMAIL").trim();
         sWaiver = runsql.getData("APWAIVR").trim();
         sPrdTy = runsql.getData("APPRDTY").trim();
         sSiz = runsql.getData("APSIZ").trim();
         sInit = runsql.getData("APINIT").trim();
      }
%>
<html>
<head>

<SCRIPT language="JavaScript1.2">
var name = "<%=sName%>";
var str = "<%=sStr%>";
var sepr = "<%=sSepr%>";

var email = "<%=sEmail%>";
var waiver = "<%=sWaiver%>";
var prodty = "<%=sPrdTy%>";
var size = "<%=sSiz%>";
var exist = <%=bExist%>;
var init = "<%=sInit%>";
parent.setEmployee(exist, name, str, sepr, email, waiver, prodty, size, init);

</SCRIPT>

<%}
else{%><SCRIPT language="JavaScript1.2">alert("Please sign on")</SCRIPT><%}%>