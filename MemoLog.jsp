<%@ page import="memopool.MemoLog, java.io.*"%>
<%
   String sUser = request.getParameter("User");
   String sMemo = request.getParameter("Memo");
   MemoLog log = new MemoLog(sMemo, sUser);
   log.disconnect();
%>




