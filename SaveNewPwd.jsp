<%@ page import="rciutility.GetDataBySQL, java.util.*"%>
<%
   String sUser = request.getParameter("User");
   String sPwd = request.getParameter("Pwd");

   GetDataBySQL popfile = new GetDataBySQL();

   String sStmt = "update rci.PrUser set pupswd='" + sPwd + "'"
                + " where puuser='" + sUser + "'";
   popfile.setPrepStmt(sStmt);
   popfile.runQuery();

   // close conncetion
   popfile.disconnect();
   popfile = null;

   String sLocation = "index.jsp";
   response.sendRedirect(sLocation);
%>