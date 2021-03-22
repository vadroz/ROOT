<%@ page import="rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*, java.math.*"%>
<%
   String sStr = request.getParameter("Str");
   String sPiCal = request.getParameter("PiCal");   
   String sArea = request.getParameter("Area");
   String sCommt = request.getParameter("Comment");
   String sVerifyOk = request.getParameter("Ok");
   String sSku = request.getParameter("Sku");   
   String sAdjQty = request.getParameter("AdjQty");
   String sAction = request.getParameter("Action");
   String sUser = request.getParameter("User");
   
   // check if area is exists
   String sPiYr = sPiCal.substring(0,4);
   String sPiMo = sPiCal.substring(4);
   
   if(sVerifyOk==null || sVerifyOk.equals("")){ sVerifyOk= " "; }
   
   boolean bExists = false;
   String sStmt = null;
   RunSQLStmt sql_Area = null;
   ResultSet rs_Area = null;
   
   
   
   if(sAction.equals("ADDSKU") || sAction.equals("DLTSKU"))
   { 
   		sStmt =  "select SPSTR,SPPIYR,SPPIMO,SPAREA,SPSKU,SPADJQTY,SpRECBY,SpRECDT,SpRECTM" 
            + " from rci.PIARCORR"
            + " where spstr=" + sStr + " and sppiyr=" + sPiYr + " and sppimo=" + sPiMo
            + " and sparea=" + sArea + " and spsku=" + sSku
            + " and SpPost=' '"
   		;   
   		
   		sql_Area = new RunSQLStmt();
   	    sql_Area.setPrepStmt(sStmt);
   	    rs_Area = sql_Area.runQuery();
   	   
   	    // System.out.println(sStmt);
   	    
   	    String sSvAdjQty = null;
   	   
   	    // if already excists - delete existing entries
   	    if(sql_Area.readNextRecord())
   	    {
   	    	sSvAdjQty = sql_Area.getData("SpADJQTY");
   	    	
   	    	sql_Area.disconnect();
   	    	
   	    	sStmt =  "delete from rci.PIARCORR"
   	             + " where spstr=" + sStr + " and sppiyr=" + sPiYr + " and sppimo=" + sPiMo
   	            + " and sparea=" + sArea + " and spsku=" + sSku
   	            + " and SpPost=' '";
   	    	
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
	   			System.out.println("old=" + sSvAdjQty + " new=" + sAdjQty
	   		    	+ "add=" + 	bdAdjNew);
	   			sAdjQty = bdAdjNew.toString(); 
	   		}   	 	
   	 		
  	   		sStmt = "insert into rci.PIArCorr values(" 
  	  	      + sStr + "," + sPiYr + "," + sPiMo + "," + sArea + "," + sSku + "," + sAdjQty 
  	  	      + ",'" + sUser + "', current date, current time"
  	  	      + ", ' ', ' ','0001-01-01', '00.00.00'"
  	   		+ ")";
  	   	    //System.out.println(sStmt);
  	   	
  	   		sql_Area = new RunSQLStmt();
	    	sql_Area.setPrepStmt(sStmt);
	    	rs_Area = sql_Area.runQuery();
	    	int irs = sql_Area.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);   
		    
	    	// update date and timestamp
	    	sStmt =  "update rci.PISTRCNT set SCCNTBY='" + sUser + "'"
	    		    + ", scCntDt=current date" 
	    		    + ", scCntTm=current time"	    		    
	    		  	+ " where SCSTR=" + sStr + " and scpiyr=" + sPiYr + " and scpimo=" + sPiMo
	    		  	+ " and scarea=" + sArea;   
	       
	       	//System.out.println(sStmt);	       
	       	sql_Area = new RunSQLStmt();
	       	sql_Area.setPrepStmt(sStmt);
	       	rs_Area = sql_Area.runQuery();
	       	irs = sql_Area.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	    	
	    	sql_Area.disconnect();		    
     	}
   }
   
   if(sAction.equals("ADD"))
   {
	   sStmt =  "update rci.PISTRCNT set SCCNTBY='" + sUser + "'"
		    + ", scCntDt=current date" 
		    + ", scCntTm=current time"
		    + ", scCntCm='" + sCommt  + "'"
		    + ", scOk='" + sVerifyOk + "'"
		  	+ " where SCSTR=" + sStr + " and scpiyr=" + sPiYr + " and scpimo=" + sPiMo
		  	+ " and scarea=" + sArea;   
   
   		//System.out.println(sStmt);
   
   		sql_Area = new RunSQLStmt();
   		sql_Area.setPrepStmt(sStmt);
   		rs_Area = sql_Area.runQuery();
   		int irs = sql_Area.runSinglePrepStmt(sStmt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);   
   		sql_Area.disconnect();
   }
%>
<script>
var Action = "<%=sAction%>";
var SkuExists = <%=bExists%>;

if(Action == "ADD"){parent.window.location.reload();}
else if(Action == "ADDSKU"){ parent.setNewCorrSku(SkuExists); }
</script>












