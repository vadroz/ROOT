<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
    String sEvtID = request.getParameter("id");

//----------------------------------
// Application Authorization
//----------------------------------
if (session.getAttribute("USER")!=null)
{
      String sUser = session.getAttribute("USER").toString();

      String sEmp = "";
      String sEMail = "";
      String sName = "";
      String sStr = "";
      boolean bExist = false;

      String sStmt = "select emp, email, ename, estore"
        + " from rci.AmEmpPgm ep inner join rci.RciEmp on emp=erci"
        + " where esepr=' '"
          + " and waiver='Y'"
          + " and not exists(select 1 from rci.AmEvEmp ee where ee.emp=ep.emp"
          + " and ee.evt_id = " + sEvtID + ")"
          + " order by ename"
        ;
      RunSQLStmt runsql = new RunSQLStmt();
      runsql.setPrepStmt(sStmt);
      ResultSet rs = runsql.runQuery();
      String sComa ="";

      while(runsql.readNextRecord())
      {
         bExist = true;
         sEmp += sComa + "\"" + runsql.getData("emp").trim() + "\"";
         sEMail += sComa + "\"" + runsql.getData("email").trim() + "\"";
         sName += sComa + "\"" + runsql.getData("ename").trim() + "\"";
         sStr += sComa + "\"" + runsql.getData("estore").trim() + "\"";
         sComa = ",";
      }
%>
<html>
<head>

<SCRIPT language="JavaScript1.2">
var emp = [<%=sEmp%>];
var email = [<%=sEMail%>];
var name = [<%=sName%>];
var str = [<%=sStr%>];

parent.showEmpLst(emp, name, str, email);

</SCRIPT>

<%}
else{%><SCRIPT language="JavaScript1.2">alert("Please sign on")</SCRIPT><%}%>