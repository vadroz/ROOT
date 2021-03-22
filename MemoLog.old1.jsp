<%@ page import="memopool.MemoLog, java.io.*"%>
<%
   String sUser = request.getParameter("User");
   String sMemo = request.getParameter("Memo");
   MemoLog log = new MemoLog(sMemo, sUser);
   log.disconnect();
   if (sMemo.lastIndexOf(".xls") > 0) response.setContentType("application/vnd.ms-excel");
   else if (sMemo.lastIndexOf(".doc") > 0) response.setContentType("application/vnd.ms-word");
   else if (sMemo.lastIndexOf(".pdf") > 0) response.setContentType("application/pdf");
   System.out.println(sMemo.lastIndexOf(".pdf"));

   File file = new File("C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT/" + sMemo);

   Long lLng = new Long( file.length() );
   int iLng = lLng.intValue();
   byte [] bData = new byte[iLng];
   FileInputStream fileins = new FileInputStream(file);
   iLng = fileins.read(bData);
   String sData = new String(bData);
   out.println(sData);
%>




