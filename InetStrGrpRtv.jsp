<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%   
   String sUser = session.getAttribute("USER").toString(); 
   
   String sStmtGrp = "select ISGRP,IsGrp,ISDESC, ISSORT " 
     + " from rci.istrgrp "
     + " order by issort"
   ;
   //System.out.println(sStmtGrp); 
   RunSQLStmt sql_Grp = new RunSQLStmt();
   sql_Grp.setPrepStmt(sStmtGrp);	    
   ResultSet rs_Grp = sql_Grp.runQuery();		    
   String sGrpJsa = "";
   String sStrJsa = "";
   String coma="";
   while(sql_Grp.readNextRecord())		    
   {   	
	   String sGrp = sql_Grp.getData("IsGrp").trim();
	   sGrpJsa += coma + "\"" + sGrp + "\"";	   
	   
	   // get Stores for this group
	   String sStmtStr = "select Itstr from rci.istrgrps where itgrp='" + sGrp + "' order by itstr";	   
	   RunSQLStmt sql_Str = new RunSQLStmt();
	   sql_Str.setPrepStmt(sStmtStr);
	   ResultSet rs_Str = sql_Str.runQuery();
	   
	   String coma1="";
	   sStrJsa += coma + "[";
	   while(sql_Str.readNextRecord())		    
	   {
		   String sStr = sql_Str.getData("ItStr").trim();		    
		   sStrJsa += coma1 + "\"" + sStr + "\"";
		   coma1=",";		   
	   }	
	   sStrJsa += "]";
	   coma=",";
	   sql_Str.disconnect();
	   
   }
   sql_Grp.disconnect();   
%>
<script>
var grp = [<%=sGrpJsa%>];
var str = [<%=sStrJsa%>];
parent.setStrGrp(grp, str);
</script>