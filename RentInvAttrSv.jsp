<!DOCTYPE html>
<%@ page import="rciutility.RunSQLStmt, java.text.SimpleDateFormat, java.sql.*, java.util.*"%>
<%
   String sBrandTy = request.getParameter("BrandTy");
   String sBrand = request.getParameter("Brand");
   
   String sModelTy = request.getParameter("ModelTy");
   String sModelBra = request.getParameter("ModelBra");
   String sModelAge = request.getParameter("ModelAge");
   String sModel = request.getParameter("Model");
   
   
   String sAction = request.getParameter("Action");
      //----------------------------------
   // Application Authorization
   //----------------------------------
 if (session.getAttribute("USER")!=null)
 {
     
   	String sUser = session.getAttribute("USER").toString();
    String sError = "";
    boolean bError = false;
   	
   	if(sAction.equals("ADDBRAND"))
   	{
   		String sStmt = "select rvtype, rvven"
		 	+ " from Rci.ReVend"
	 		+ " where rvType='" + sBrandTy + "'"
	 		+ " and rvven = '" + sBrand + "'";
	   	
		RunSQLStmt runsql = new RunSQLStmt();
		runsql.setPrepStmt(sStmt);		   
		runsql.runQuery();
	   		   
		if(runsql.readNextRecord())
		{
			sError = "This Brand is already exists";
			bError = true;
		}
		else
		{
			sStmt = "insert into rci.ReVend values(" 
		  	  	+ sBrand + ", '" + sBrandTy + "'"
		  		+ ")";
		  	//System.out.println(sStmt);
		  	   	
		  	runsql = new RunSQLStmt();
			runsql.setPrepStmt(sStmt);
			int irs = runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);   
				      
		   	runsql.disconnect();	
		}
		runsql.disconnect(); runsql = null;
   	}	
   	else if(sAction.equals("DLTBRAND"))
   	{
   		String sStmt = "delete from rci.ReVend" 
			+ " where rvtype='" + sBrandTy + "'"
			+ " and rvven=" + sBrand 
		 ;
		//System.out.println(sStmt);
		  	   	
		RunSQLStmt runsql = new RunSQLStmt();
		runsql.setPrepStmt(sStmt);
		int irs = runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		runsql.disconnect();
   	}
   	
   	// ------------ Model ------------------------
   	else if(sAction.equals("ADDMODEL"))
   	{
   		String sStmt = "select rmtype, rmmodel"
		 	+ " from Rci.ReModel"
	 		+ " where rmType='" + sModelTy + "'"
	 		+ " and rmbrand = " + sModelBra
	 		+ " and rmage = " + sModelAge
	 		+ " and rmmodel = '" + sModel + "'";
	   	
		RunSQLStmt runsql = new RunSQLStmt();
		runsql.setPrepStmt(sStmt);		   
		runsql.runQuery();
	   		   
		if(runsql.readNextRecord())
		{
			sError = "This Model is already exists";
			bError = true;
		}
		else
		{
			sStmt = "insert into rci.ReModel values(" 
		  	  	+ "'" + sModelTy + "', '" + sModel + "'"
		  	  	+ "," + sModelBra + ", '" + sModelAge  + "'"
		  		+ ")";
		  	System.out.println(sStmt);
		  	   	
		  	runsql = new RunSQLStmt();
			runsql.setPrepStmt(sStmt);
			int irs = runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);   
				      
		   	runsql.disconnect();	
		}
		runsql.disconnect(); runsql = null;
   	}	
   	else if(sAction.equals("DLTMODEL"))
   	{
   		String sStmt = "delete from rci.ReModel" 
			+ " where rmtype='" + sModelTy + "'"
			+ " and rmbrand = " + sModelBra
			+ " and rmage = '" + sModelAge + "'" 
			+ " and rmmodel='" + sModel + "'" 
		 ;
		System.out.println(sStmt);
		  	   	
		RunSQLStmt runsql = new RunSQLStmt();
		runsql.setPrepStmt(sStmt);
		int irs = runsql.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		runsql.disconnect();
   	}
   %>
<script>
var error = "<%=sError%>";
var errflg = <%=bError%>

parent.refreshPage(error, errflg);

</SCRIPT>


<%  
  }
 else{%>
  <script>
   alert("Your session is expired! Please sign on again.")
  </script>
 <%}%>
 
 
 
 
 