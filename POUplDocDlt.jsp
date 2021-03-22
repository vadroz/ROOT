<%@ page import="posend.POUplDocSv,java.util.*, java.io.*"%>
<%
	String sPoNum = request.getParameter("PO");
	String sSeq = request.getParameter("Seq");
	String sExt = request.getParameter("Ext");
   
   //----------------------------------
   // Application Authorization
   //----------------------------------
   if (session.getAttribute("USER") != null)
   {
	   String sUser = session.getAttribute("USER").toString();
	   
	   POUplDocSv poupldoc = new POUplDocSv();
       poupldoc.dltPODoc(sPoNum, sSeq, sUser);
       try{
    	String sFile = "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/ROOT/PO_Pack_List/PO" + sPoNum + "_" + sSeq + "." + sExt;    	
       	File fDoc = new File(sFile);
       	System.out.println("delete: " + sFile + " exists?" + fDoc.exists());
       	fDoc.delete();       	
       	System.out.println("deleted");       	   
       } catch(Exception e){ e.printStackTrace(); }
%>

<script name="javascript">
parent.location.reload();
</script>

<%}
else {%>
<script name="javascript">
 alert("Your session is expired, please signon again.")
</script>
<%}%>