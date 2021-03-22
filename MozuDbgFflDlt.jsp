<%@ page import="rciutility.RunSQLStmt, java.sql.*,java.text.*, java.util.*"%>
<%
  String [] sOrd = request.getParameterValues("o");  
  String [] sSku = request.getParameterValues("s");
  
  
  for(int i=0; i < sOrd.length; i++)
  {
 	 String sStmt = "delete from rci.EcUDatb" 
	  	+ " where UDSITE = 'MOORPASW' and udTable = 'SETSTRSTS'"
	  	+ " and substr(uddata, 11, 10) like ('%" + sOrd[i] + "%')"
	  	+ " and substr(uddata, 21, 10) like ('%" + sSku[i] + "%')"
	   ;
 	 //System.out.println(sStmt);
   		
 	 RunSQLStmt runsql = new RunSQLStmt();
     ResultSet rslset = runsql.getResult();
     int irs = runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
 	 
  }
%>
 

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

<script name="javascript1.2">
 parent.location.reload();
	
</script>

 
