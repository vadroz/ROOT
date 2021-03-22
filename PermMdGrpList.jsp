<%@ page import=" rciutility.RunSQLStmt, java.sql.*, java.util.*, java.text.*
, rciutility.CallAs400SrvPgmSup"%>
<%
    String sSts = request.getParameter("Sts");
    String sUser = session.getAttribute("USER").toString();
    
    String sPrepStmt = "select MGSHORT,MGLONG,MGBATCH,char(MGCDAT, usa) as MGCDAT,MGCUSER " 
       	+ " from Rci.MdGrp"
    ;       	
       	      	
    System.out.println(sPrepStmt);
    ResultSet rslset = null;
    RunSQLStmt runsql = new RunSQLStmt();
    runsql.setPrepStmt(sPrepStmt);		   
    runsql.runQuery();
       	    		   		   
    Vector<String> vShort = new Vector<String>();
    Vector<String> vLong = new Vector<String>();
    Vector<String> vBatch = new Vector<String>();
    Vector<String> vCrtDat = new Vector<String>();
    Vector<String> vCrtUsr = new Vector<String>();
      		   		   
    while(runsql.readNextRecord())
    {  		  
    	vShort.add(runsql.getData("MGSHORT").trim());
       	vLong.add(runsql.getData("MGLONG").trim());  
       	vBatch.add(runsql.getData("MGBatch").trim());
       	vCrtDat.add(runsql.getData("MGCDat").trim());
       	vCrtUsr.add(runsql.getData("MGCUser").trim());
    }  
       	     	  
    String [] sShort = vShort.toArray(new String[]{});
    String [] sLong = vLong.toArray(new String[]{});
    String [] sBatch = vBatch.toArray(new String[]{});
    String [] sCrtDat = vCrtDat.toArray(new String[]{});
    String [] sCrtUsr = vCrtUsr.toArray(new String[]{});
    
    runsql.disconnect();
       	  
    CallAs400SrvPgmSup srvpgm = new CallAs400SrvPgmSup();
    String sShortJsa = srvpgm.cvtToJavaScriptArray(sShort);
    String sLongJsa = srvpgm.cvtToJavaScriptArray(sLong);
    String sBatchJsa = srvpgm.cvtToJavaScriptArray(sBatch);
    String sCrtDatJsa = srvpgm.cvtToJavaScriptArray(sCrtDat);
    String sCrtUsrJsa = srvpgm.cvtToJavaScriptArray(sCrtUsr);
%>

<script name="javascript1.2">
var shortNm = [<%=sShortJsa%>];
var longNm = [<%=sLongJsa%>];
var batch = [<%=sBatchJsa%>];
var crtDat = [<%=sCrtDatJsa%>];
var crtUsr = [<%=sCrtUsrJsa%>];

parent.showBatch(shortNm, longNm, batch, crtDat,crtUsr);

//==============================================================================
// run on loading
//==============================================================================

</script>