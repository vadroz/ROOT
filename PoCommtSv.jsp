<%@ page import="posend.POUplDocSv"%>
<%
String sPoNum = request.getParameter("Po");
String sEmp = request.getParameter("Emp");
String sCommt = request.getParameter("Commt");    

System.out.println("\n" + sPoNum + "|" + sEmp + "|" + sCommt);

 //----------------------------------
 // Application Authorization
 //----------------------------------
 if (session.getAttribute("USER")!=null)
 {
	
    String sUser = session.getAttribute("USER").toString();
    
    

    POUplDocSv poupldoc = new POUplDocSv();
    poupldoc.saveCommt(sPoNum, sEmp, sCommt, sUser);
    poupldoc.disconnect();
%>
<script language="javascript">

  parent.restart();

</script>
<%}
else {%>
<script language="javascript">
  alert("Please refresh your screen and sign on");
</script>
<%}%>