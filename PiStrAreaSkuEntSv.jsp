<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*, java.math.*"%>
<%
   String sStr = request.getParameter("Str");
   String sPiCal = request.getParameter("PiCal");   
   String sArea = request.getParameter("Area");
   String sCommt = request.getParameter("Comment");
   String sSku = request.getParameter("Sku");   
   String sAdjQty = request.getParameter("AdjQty");
   String sReas = request.getParameter("Reas");
   String sAction = request.getParameter("Action");
   String sUser = request.getParameter("User");
   
   if(sReas == null ){ sReas=" "; }
   
   // check if area is exists
   String sPiYr = sPiCal.substring(0,4);
   String sPiMo = sPiCal.substring(4);
   
   boolean bExists = false;
   String sStmt = null;
   RunSQLStmt sql_Area = null;
   ResultSet rs_Area = null;
   
   sReas = sReas.replaceAll("'", "''");
   
   if(sAction.equals("ADDSKU") || sAction.equals("DLTSKU"))
   { 
   		sStmt =  "select SaSTR,SaPIYR,SaPIMO,SaAREA,SaSKU,SaADJQTY,SaReas, SaRECBY,SaRECDT,SaRECTM" 
            + " from rci.PIARITCO"
            + " where sastr=" + sStr + " and sapiyr=" + sPiYr + " and sapimo=" + sPiMo
            + " and saarea=" + sArea + " and sasku=" + sSku
   		;   
   
   		//System.out.println(sStmt);
   		sql_Area = new RunSQLStmt();
   	    sql_Area.setPrepStmt(sStmt);
   	    rs_Area = sql_Area.runQuery();
   	       	    
   	    //System.out.println(sStmt);
   	    
   	    String sSvAdjQty = null;
   	   
   	    // if already excists - delete existing entries
   	    if(sql_Area.readNextRecord())
   	    {
   	    	sSvAdjQty = sql_Area.getData("SaADJQTY");
   	    	
   	    	sql_Area.disconnect();
   	    	
   	    	sStmt =  "delete from rci.PIARITCO"
   	             + " where sastr=" + sStr + " and sapiyr=" + sPiYr + " and sapimo=" + sPiMo
   	            + " and saarea=" + sArea + " and sasku=" + sSku;
   	    	
   	    	//System.out.println(sStmt);
   	    	
   	    	sql_Area = new RunSQLStmt();
   	    	sql_Area.setPrepStmt(sStmt);
   	    	rs_Area = sql_Area.runQuery();
   	    	int irs = sql_Area.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);   
   	    	bExists = true;
   	    }
   	 	if(!sAction.equals("DLTSKU"))
     	{
  	   		if(sSvAdjQty != null)
  	   		{
  	   			BigDecimal bdAdjOld = new BigDecimal(sSvAdjQty);
  	   		    BigDecimal bdAdjNew = new BigDecimal(sAdjQty);
  	   		    bdAdjNew = bdAdjNew.add(bdAdjOld);
  	   			/*System.out.println("old=" + sSvAdjQty + " new=" + sAdjQty
  	   		    	+ "add=" + 	bdAdjNew);
  	   			*/
  	   			sAdjQty = bdAdjNew.toString(); 
  	   		}   	 		
   	 		
   	 		sStmt = "insert into rci.PIARITCO values(" 
  	  	      + sStr + "," + sPiYr + "," + sPiMo + "," + sArea + "," + sSku + "," + sAdjQty 
  	  	      + ",'" + sReas + "','" + sUser + "', current date, current time"
  	  	      + ", ' ', ' ', '0001-01-01', '00.00.00'"
  	   		+ ")";
  	   	    //System.out.println(sStmt);
  	   	
  	   		sql_Area = new RunSQLStmt();
	    	sql_Area.setPrepStmt(sStmt);
	    	rs_Area = sql_Area.runQuery();
	    	int irs = sql_Area.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);   
		      
	    	sql_Area.disconnect();		    
     	}
   }
   else if(sAction.equals("UPDSKU"))
   {
	   sStmt =  "update rci.PIARITCO set"
		  + " sareas='" + sReas + "', SAADJQTY=" + sAdjQty 	   
	      + " where sastr=" + sStr + " and sapiyr=" + sPiYr + " and sapimo=" + sPiMo
	      + " and saarea=" + sArea + " and sasku=" + sSku;
	    	
	   //System.out.println(sStmt);
	    	
	   sql_Area = new RunSQLStmt();
	   sql_Area.setPrepStmt(sStmt);
	   rs_Area = sql_Area.runQuery();
	   int irs = sql_Area.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);   
	   bExists = true;
   } 
   else if(sAction.equals("ADDSTRCOMMT"))
   {
	  sCommt = sCommt.replaceAll("'", "''"); 
	  sCommt = sCommt.replaceAll("\"", "\\\"");
	  sStmt = "insert into rci.PISTRCOM values(DEFAULT," 
	  	 + sStr + "," + sPiYr + "," + sPiMo + ",'FINAL'"
	  	 + ",'" + sCommt + "','" + sUser + "', current date, current time"	  	  	       
	  	 + ")";
	  System.out.println(sStmt);
	  	   	
	  sql_Area = new RunSQLStmt();
	  sql_Area.setPrepStmt(sStmt);
 	  int irs = sql_Area.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);   
	  sql_Area.disconnect();	
   }
   else if(sAction.equals("REVSKU"))
   {
	   sStmt =  "insert into rci.PIARITCH"
		+ "(select SASTR,SAPIYR,SAPIMO,SAAREA,SASKU,SAADJQTY,SAREAS,SARECBY,SARECDT"
	    + ",SARECTM,SAPOST,SAPOUS,SAPODT, SaPOTM, current timestamp"
	    + " from rci.PiArItCo"                                                    
	    + " where SaPost = 'Y' and SaPIYR=" + sPiYr + " and SaPIMO=" + sPiMo 
	    + " and SaStr=" + sStr + " and SaArea=" + sArea + " and SaSku=" + sSku  
	    + ")"  
	   ; 	
	   //System.out.println(sStmt);
	    	
	   sql_Area = new RunSQLStmt();
	   sql_Area.setPrepStmt(sStmt);
	   rs_Area = sql_Area.runQuery();
	   int irs = sql_Area.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);   
	   
	   sStmt = "update rci.PIARITCO set"
		  + "  SAADJQTY=" + sAdjQty 
		  + ", SaRecBy='" + sUser + "', SaRecDt=current date, SaRecTm=current time"
		  + ", SAPOST=' ', SaPoUs=' ', SaPoDt='0001-01-01', SaPoTm='00.00.00'"
		  + " where sastr=" + sStr + " and sapiyr=" + sPiYr + " and sapimo=" + sPiMo
		  + " and saarea=" + sArea + " and sasku=" + sSku;
	
	   //System.out.println(sStmt);
			    	
	   sql_Area = new RunSQLStmt();
	   sql_Area.setPrepStmt(sStmt);
	   rs_Area = sql_Area.runQuery();
	   irs = sql_Area.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);   
			   
	   bExists = true;
   } 
%>
<script>
var Action = "<%=sAction%>";
var SkuExists = <%=bExists%>;

 if(Action == "ADDSKU"){ parent.setNewCorrSku(SkuExists); }
 else if(Action == "UPDSKU"){ parent.location.reload(); }
 else if(Action == "DLTSKU"){ parent.location.reload(); }
 else if(Action == "REVSKU"){ parent.updRevSku(); }
 else if(Action == "ADDSTRCOMMT"){ parent.location.reload(); }
</script>












