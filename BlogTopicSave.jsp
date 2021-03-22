<%@ page import="miniblog.BlogTopicSave, java.util.*"%>
<%
   String sBlogGrp = request.getParameter("BlogGrp");
   String sTopic = request.getParameter("Topic");
   String sSubj = request.getParameter("txaSubj");
   String sMsg = request.getParameter("txaMsg");
   String sAction = request.getParameter("Action");
   String sUser = request.getParameter("User");
   String sQuery = request.getParameter("Query");
   String sUri = request.getParameter("Uri");

  //-------------- Security ---------------------
  String sAppl = "MINIBLOG";
  //System.out.println(sBlogGrp + "|" + sTopic + "|" + sSubj + "|" + sMsg + "|" + sAction
  //    + "|" + sUser + "|" + sQuery + "|" +  sUri
  //);

  if (session.getAttribute("USER")==null || session.getAttribute(sAppl)==null)
  {
     response.sendRedirect("SignOn1.jsp?TARGET=BlogGrpList.jsp&APPL=" + sAppl + "&BlogGrp=0");
  }
  else
  {
     BlogTopicSave topsav = new BlogTopicSave(sBlogGrp, sTopic, sSubj, sMsg, sAction, sUser);
     topsav.CloseConnection();

     // return back to topic
     String sLocation = sUri + "?" + sQuery;
     response.sendRedirect(sLocation);
  }
%>