<%@ page import="java.sql.*, java.util.*, java.text.*, rciutility.RunSQLStmt"%>
<%
   String sUser = request.getParameter("User");
   String sName = request.getParameter("Name");
   String sEMail = request.getParameter("EMail");
   String sDept = request.getParameter("Dept");

   if(sName==null){ sName=sUser;}
   if(sEMail==null){ sEMail="None";}

   if (session.getAttribute("USER")==null)
   {

   }
   else
   {

   // fix user with single quote
   if(sUser.indexOf("'") >= 0)
   {
       String fix = "";
       for(int i=0; i < sUser.length(); i++)
       {
          if(!sUser.substring(i, i+1).equals("'")) { fix += sUser.substring(i, i+1); }
          else { fix += "'" + sUser.substring(i, i+1); }
       }
       sUser = fix;
   }

   // fix user with single quote
   if(sName.indexOf("'") >= 0)
   {
       String fix = "";
       for(int i=0; i < sName.length(); i++)
       {
          if(!sName.substring(i, i+1).equals("'")) { fix += sName.substring(i, i+1); }
          else { fix += "'" + sName.substring(i, i+1); }
       }
       sName = fix;
   }

   String sPrepStmt = "insert into rci.PjUser values("
     + "'" + sUser + "'"
     + ", '" + sName + "'"
     + ", '" + sEMail + "'"
     + ", '" + sDept + "'"
     + ")";

   //System.out.println(sPrepStmt);


   Vector vConst = new Vector();
   Vector vConstDesc = new Vector();

   ResultSet rslset = null;
   RunSQLStmt runsql = new RunSQLStmt();
   runsql.runSinglePrepStmt(sPrepStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
   runsql.disconnect();
   runsql = null;
%>

<script language="JavaScript">
  //parent.popUserMenu();
</script>
<%}%>