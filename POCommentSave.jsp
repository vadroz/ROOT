<%@ page import="posend.POCommentSave"%>
<%
   String sPO = request.getParameter("PO");
   String sComment = request.getParameter("Comment");

   if (sComment==null){ sComment=" ";}

//----------------------------------
// Application Authorization
//----------------------------------

 if (session.getAttribute("USER")==null)
 {
   response.sendRedirect("SignOn1.jsp?TARGET=POCommentSave.jsp&APPL=ALL&" + request.getQueryString());
 }
 else
 {
   String sUser = session.getAttribute("USER").toString();

   POCommentSave pocomsv = new POCommentSave(sPO, sComment, sUser);

   pocomsv.disconnect();
   pocomsv = null;
%>
<script name="javascript">
parent.closeFrame();
</script>

<%}%>