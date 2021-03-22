<%@ page import="rciutility.RunSQLStmt, java.text.*, java.util.*, java.sql.ResultSet"%>
<%
     String sData = request.getQueryString();

     System.out.println("ProProfs Data: " + sData);
     if(sData == null){sData = "None";}

     String query = null;
	 try{
		 query = "insert into rci.EcUData"
		          + " values("
		            + "'Fluid'"   
		            + ",'Response'"
		            + ",'" + sData + "'"		             
		          + ")";

     	System.out.println(query);
	 } catch(Exception e){ query = "Error";}

     RunSQLStmt rsql = new RunSQLStmt();

     int irs = rsql.runSinglePrepStmt(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
     rsql.disconnect();
     rsql = null;
%>
<html>
<head>


