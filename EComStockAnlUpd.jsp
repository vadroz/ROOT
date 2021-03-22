<%@ page import="rciutility.CallAs400Pgm"%>
<%
      //(String sLib, String sPgmName, String [] sParam, int [] iPrmLng){
      String sUser = session.getAttribute("USER").toString();
	  String [] sParam = new String[]{sUser};
	  int [] iPrmLng = new int[]{10};
      CallAs400Pgm pgm = new CallAs400Pgm("RCI", "ECSTAUPD", sParam, iPrmLng);
%>
ECSTAUPD Submitted