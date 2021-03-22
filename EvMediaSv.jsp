<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sId = request.getParameter("Id");
   String sType = request.getParameter("Type");
   String sMedia = request.getParameter("Media");
   String sComment = request.getParameter("Comment");
   String sAction = request.getParameter("Action");

   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER")!=null)
   {
      String sUser = session.getAttribute("USER").toString();
      String sStmt = null;

      if(sAction.equals("ADDMEDIA"))
      {
         sStmt = "insert into rci.AdMedNam values("
           + " default" + ", '" + sType + "','" + sMedia + "','" + sComment
           + "','" + sUser + "', current date, current time" + ")"
          ;
         //System.out.println(sStmt);
      }
      if(sAction.equals("DLTMEDIA"))
      {
         sStmt = "delete from rci.AdMedNam "
           + " where MNMEDID=" + sId
          ;
      }
      if(sAction.equals("UPDMEDIA"))
      {
         sStmt = "update rci.AdMedNam set"
           + " MNMTYP = '" + sType + "'"
           + ", MNMEDIA ='" + sMedia + "'"
           + ", MNCOMMT ='" + sComment + "'"
           + ", MNRECUS ='" + sUser + "'"
           + ", MNRECDT=current date"
           + ", MNRECTM=current time"
           + " where MNMEDID=" + sId
          ;
      }
      RunSQLStmt sql_MedName = new RunSQLStmt();
      //System.out.println(sStmt);
      int irs = sql_MedName.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
      sql_MedName.disconnect();
%>

<SCRIPT language="JavaScript1.2">
  parent.restart();
</SCRIPT>

<%}
else{%>
 <script language="javascript">alert(You mast sign on again.)</script>
<%}
%>

