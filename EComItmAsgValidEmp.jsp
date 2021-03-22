<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*"%>
<%
   String sEmp = request.getParameter("Emp");

   String sStmt = "select esepr"
        + " from  rci.rciemp"
        + " where erci=" + sEmp
        ;
    RunSQLStmt sql_Emp = new RunSQLStmt();
    sql_Emp.setPrepStmt(sStmt);
    ResultSet rs_Emp = sql_Emp.runQuery();
    boolean bValid = false;
    if(sql_Emp.readNextRecord())
    {
       String sSepr = sql_Emp.getData("esepr").trim();
       if(sSepr.equals("")){ bValid = true; }
    }
    
    if(!bValid)
    {
    	sStmt = "select UUID"
    	        + " from  IPTSFIL.IPUSERS"
    	        + " where UUID='" + sEmp + "'"
    	        ;
    	sql_Emp = new RunSQLStmt();
    	sql_Emp.setPrepStmt(sStmt);
    	rs_Emp = sql_Emp.runQuery();
    	bValid = false;
    	if(sql_Emp.readNextRecord())
    	{
    	    bValid = true; 
    	}
    	
    }
    
    
    
    sql_Emp.disconnect();


%>
<%=bValid%>











